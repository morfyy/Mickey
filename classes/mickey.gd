extends CharacterBody2D
class_name Mickey

var speed:float = 512.0
var accel:float = 10.0

var dir:int = 0

var jumping:bool = false
var attacking:bool = false


func _physics_process(delta) -> void:
	if not jumping and not attacking:
		dir = Input.get_axis("ui_left","ui_right")
	
	velocity.x += (dir*speed - velocity.x) * accel * delta
	
	if dir != 0:
		$Sprite2D.flip_h = dir == 1
		$Sprite2D.position.x = -dir * 80
	
	move_and_slide()
	animations()

func animations() -> void:
	if jumping or attacking:
		return
	if Input.is_action_just_pressed("jump"):
		jumping = true
		$AnimationPlayer.play("jump")
		dir = 0
		return
	if Input.is_action_just_pressed("attack"):
		attacking = true
		$AnimationPlayer.play("attack")
		dir = 0
		return
	
	if dir != 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "jump":
		jumping = false
	if anim_name == "attack":
		attacking = false
