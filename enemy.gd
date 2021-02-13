extends KinematicBody2D

const SPEED = 50
const GRAVITY = 40

var velocity = Vector2(0,0)
export var direction = -1
export var detects_cliffs = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs

func _physics_process(delta):
	if is_on_wall() or (detects_cliffs and !$floor_checker.is_colliding() and is_on_floor()):
		flip_direction()
		
	velocity.y = velocity.y + GRAVITY
	velocity.x = SPEED * direction
		
	velocity = move_and_slide(velocity, Vector2.UP)

func flip_direction():
	direction = -direction
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	$floor_checker.position.x = -$floor_checker.position.x


func _on_top_checker_body_entered(body):
	pass # Replace with function body.
