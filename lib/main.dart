import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset starting = Offset.zero;
  Offset ending = Offset.zero;

  void _getStartingOffset(DragStartDetails details){
    setState(() {
      starting = details.globalPosition;
    });
  }
  void _getEndingOffset(DragEndDetails details){
    setState(() {
      ending = details.velocity.pixelsPerSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: _getStartingOffset,
        onPanEnd: _getEndingOffset,
        child: Center(
          child: CustomPaint(
            painter: MyPainter(starting: starting, ending: ending),
            child: const FittedBox(
              child: Text("Hello there"),
            ),
          )
        ),
      ),
    );
  }


}

class MyPainter extends CustomPainter {
  Offset starting;
  Offset ending;
  MyPainter({required this.starting,required this.ending});

  @override
  void paint(Canvas canvas, Size size) {
  final painter = Paint()
    ..color = Colors.indigo
    ..style = PaintingStyle.stroke
  ..strokeWidth = 10.5;
  canvas.drawLine(starting, ending,painter);
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


