extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var scorep1 = get_node("hud/ScoreP1")
onready var scorep2 = get_node("hud/ScoreP2")
#onready var player1 = get_node("player1")
onready var player1 = load("res://Scenes/player.tscn")
onready var player2 = load("res://Scenes/player.tscn")
onready var p1 = player1.instance()
onready var p2 = player2.instance()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.add_child(p1)
	p1.set_pos(Vector2(191.169006, 0))
	p1.setKey("wasd_up", "wasd_right", "wasd_left")
	self.add_child(p2)
	p2.set_pos(Vector2(831.482971,0))
	scorep1.add_text("Potato: 5")
	scorep2.push_align(HALIGN_RIGHT)
	scorep2.add_text("Tomato: 5")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var p = p1.get_pos()
	if p.y > 600:
		scorep1.clear()
		scorep1.add_text("dead")