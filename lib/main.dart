import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_game/pixeladventure.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  pixeladventure game = pixeladventure();
  runApp(
    GameWidget(game: kDebugMode ? pixeladventure() : game),
  );
}
