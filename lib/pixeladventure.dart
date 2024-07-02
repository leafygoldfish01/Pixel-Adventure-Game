import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_game/Components/player.dart';
import 'package:pixel_game/Components/level.dart';

// ignore: camel_case_types
class pixeladventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  Player player = Player(character: 'Pink Man');
  late JoystickComponent joystick;
  bool showJoystick= false;

  @override
  FutureOr<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();
    final world = Level(levelName: 'level-02', player: player);

    if(showJoystick) {
      addJoystick();
    }

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    priority=0;
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(showJoystick){
      updatejoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 1,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/knob.png'),
        ),
      ),
      knobRadius: 32,
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 16.0, bottom: 16),
    );
    add(joystick);
  }

  void updatejoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement=-1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement=1;
        break;
      default:
        player.horizontalMovement=0;
        break;
    }
  }
}
