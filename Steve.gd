extends KinematicBody2D


const PLAYER_SPEED = 250
const JUMP_FORCE = -1000
const GRAVITY = 40

var velocity = Vector2(0,0)

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = PLAYER_SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -PLAYER_SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	elif Input.is_action_pressed("down"):
		$Sprite.play("crouch")
	else:
		$Sprite.play("idle")
		
	if not is_on_floor():
		$Sprite.play("air")
		
	velocity.y = velocity.y + GRAVITY
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.1)


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")

