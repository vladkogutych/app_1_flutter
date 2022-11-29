import 'package:flutter/material.dart';
import 'package:labs_vldk/http_imahe.dart';

main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int width = 100;
  int height = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomPaint(
        painter: BackgroundSignIn(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
            child: Column(
              children: [
                Text(
                  'Width $width',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                    value: width.toDouble(),
                    min: 100,
                    max: 1000,
                    onChanged: (value) {
                      setState(() {
                        width = value.toInt();
                      });
                    }),
                Text(
                  'Height $height',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                    value: height.toDouble(),
                    min: 100,
                    max: 1000,
                    onChanged: (value) {
                      setState(() {
                        height = value.toInt();
                      });
                    }),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePage(
                                    width: width,
                                    height: height,
                                  )));
                    },
                    child: const Text('Get Image'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  ImagePage({super.key, required this.width, required this.height});
  final int width, height;
  final HttRequestImage httpImage = HttRequestImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundSignIn(),
      child: Center(
        child: FutureBuilder(
            future: httpImage.getImage(width, height),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    ));
  }
}

class BackgroundSignIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.grey.shade100;
    canvas.drawPath(mainBackground, paint);

    // Blue
    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.5);
    blueWave.quadraticBezierTo(sw * 0.5, sh * 0.45, sw * 0.2, 0);
    blueWave.close();
    paint.color = Colors.blue.shade300;
    canvas.drawPath(blueWave, paint);

    // cyan
    Path cyanWave = Path();
    cyanWave.lineTo(sw, 0);
    cyanWave.lineTo(sw, sh * 0.1);
    cyanWave.cubicTo(
        sw * 0.95, sh * 0.15, sw * 0.65, sh * 0.15, sw * 0.6, sh * 0.38);
    cyanWave.cubicTo(sw * 0.52, sh * 0.52, sw * 0.05, sh * 0.45, 0, sh * 0.4);
    cyanWave.close();
    paint.color = Colors.cyanAccent;
    canvas.drawPath(cyanWave, paint);

    // Yellow
    Path yellowWave = Path();
    yellowWave.lineTo(sw * 0.7, 0);
    yellowWave.cubicTo(
        sw * 0.5, sh * 0.2, sw * 0.27, sh * 0.01, sw * 0.2, sh * 0.1);
    yellowWave.quadraticBezierTo(sw * 0.12, sh * 0.2, 0, sh * 0.2);
    yellowWave.close();
    paint.color = Colors.orange.shade300;
    canvas.drawPath(yellowWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
