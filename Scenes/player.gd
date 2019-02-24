extends KinematicBody2D

onready var ground_ray = get_node("groundRay")

const GRAVITY = 4000
const JUMP_SPEED = -1400
const MIN_JUMP_SPEED = -500
const ACCELERATION = 1500
const FRICTION = -500
const MAX_SPEED = 500

var acc = Vector2()
var vel = Vector2()


func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_up") and ground_ray.is_colliding():
		vel.y = JUMP_SPEED
	if event.is_action_released("ui_up"):
		vel.y = clamp(vel.y, MIN_JUMP_SPEED, vel.y)

func _fixed_process(delta):
	acc.y = GRAVITY
	acc.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
	acc.x *= ACCELERATION
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta
	if ground_ray.is_colliding():
		print("collision detected")
	else:
		print("nope")
	vel += acc * delta
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	
	var motion_reminder = move(vel * delta)
	
	if is_colliding():
		var n = get_collision_normal()
		motion_reminder = n.slide(motion_reminder)
		vel = n.slide(vel)
		move(motion_reminder)