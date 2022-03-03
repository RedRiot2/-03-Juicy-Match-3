extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2(0,0)
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)
var fall_speed = 1.0

var dying = false

func _ready():
	randomize()

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
	if selected:
		$Selected.emitting = true
		$Select.show()
		z_index = 10
	else:
		$Selected.emitting = false
		$Select.hide()
		z_index = 1

func move_piece(change):
	target_position = position + change
	position = target_position

func die():
	dying = true
	var target_color = $Sprite.modulate
	target_color.s = 1
	target_color.h = randf()
	target_color.a = 0
	var fall_duration = randf()*fall_speed + 1
	var rotation_amount = (randi() % 1440) - 720
	
	var target_pos = position
	target_pos.y = 1100
	$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_amount, fall_duration-0.25, Tween.TRANS_QUINT, Tween.EASE_IN)
	$Tween.start()
