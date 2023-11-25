import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CircleData> circles = [];

  void _addCircle(CircleData circle) {
    setState(() {
      circles.add(circle);
    });
  }
  void _clear() {
    setState(() {
      circles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle Drawing App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                _addCircle(CircleData(center: details.globalPosition, radius: 0));
              },
              onPanUpdate: (details) {
                int lastIndex = circles.length - 1;
                if (lastIndex >= 0) {
                  double distance = _calculateDistance(circles[lastIndex].center, details.globalPosition);
                  circles[lastIndex] = CircleData(center: circles[lastIndex].center, radius: distance);
                  setState(() {});
                }
              },
              child: Center(
                child: CustomPaint(
                  painter: CirclePainter(circles: circles),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
            ElevatedButton(onPressed: _clear, child: const Text("Clear"))
        ],
      ),
    );
  }

  double _calculateDistance(Offset point1, Offset point2) {
    double dx = point2.dx - point1.dx;
    double dy = point2.dy - point1.dy;
    return sqrt(dx * dx + dy * dy);
  }
}

class CirclePainter extends CustomPainter {
  final List<CircleData> circles;

  CirclePainter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var circle in circles) {
      canvas.drawCircle(circle.center, circle.radius, painter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleData {
  final Offset center;
  final double radius;

  CircleData({required this.center, required this.radius});
}
