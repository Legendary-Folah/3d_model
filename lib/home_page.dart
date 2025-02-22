import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Flutter3DController _controller1 = Flutter3DController();
  final Flutter3DController _controller2 = Flutter3DController();

  void _playAnimation(String animationName) {
    _controller1.playAnimation(animationName: animationName);
    _controller2.playAnimation(animationName: animationName);
  }

  void _pauseAnimation() {
    _controller1.pauseAnimation();
    _controller2.pauseAnimation();
  }

  void _resetAnimation() {
    _controller1.resetAnimation();
    _controller2.resetAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('3D Animation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Flutter3DViewer(
                      activeGestureInterceptor: true,
                      controller: _controller1,
                      src: 'assets/models/anotherModel.glb',
                      progressBarColor: Colors.blue,
                      onLoad: (String modelAddress) {
                        debugPrint('Model 1 loaded: $modelAddress');
                      },
                      onError: (String error) {
                        debugPrint('Model 1 failed to load: $error');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Flutter3DViewer(
                      activeGestureInterceptor: true,
                      controller: _controller2,
                      src: 'assets/models/anotherModel.glb',
                      progressBarColor: Colors.blueAccent,
                      onLoad: (String modelAddress) {
                        debugPrint('Model 2 loaded: $modelAddress');
                      },
                      onError: (String error) {
                        debugPrint('Model 2 failed to load: $error');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onPressed: () => _playAnimation('Walk'),
                    text: 'Walk',
                  ),
                  CustomButton(
                    onPressed: () => _playAnimation('Jump'),
                    text: 'Jump',
                  ),
                  CustomButton(
                    onPressed: () => _playAnimation('Run'),
                    text: 'Run',
                  ),
                ],
              ),
              CustomButton(onPressed: _pauseAnimation, text: 'Pause'),
              CustomButton(onPressed: _resetAnimation, text: 'Reset'),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
