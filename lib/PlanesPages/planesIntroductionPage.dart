import 'package:flutter/material.dart';
import 'planesSectionPage.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(PlanesIntroductionPage());
}

class PlanesIntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geometry: Planes',
      debugShowCheckedModeBanner: false,
      home: PlanesIntroductionGeometryPage(),
    );
  }
}

class PlanesIntroductionGeometryPage extends StatefulWidget {
  @override
  _PlanesIntroductionGeometryPageState createState() =>
      _PlanesIntroductionGeometryPageState();
}

class _PlanesIntroductionGeometryPageState
    extends State<PlanesIntroductionGeometryPage> {
  bool _isEnglish = true;
  FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

  Future<void> _speak(String text) async {
    if (!_isSpeaking) {
      setState(() {
        _isSpeaking = true; // Set speaking state to true
      });
      await flutterTts.setLanguage(_isEnglish ? 'en-US' : 'es-ES');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
      setState(() {
        _isSpeaking = false; // Set speaking state to false
      });
    } else {
      print(
          'Already speaking, please wait.'); // Log message if already speaking
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geometry: Planes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Add back arrow icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlanesSectionsPage()), // Navigate back to PAGE2.dart
            ); // Navigate back when arrow is pressed
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: _toggleLanguage,
          ),
          IconButton(
            icon: Icon(Icons.record_voice_over),
            onPressed: () {
              _speak(_getPageContent());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEnglish ? 'Planes' : 'Planos',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              _buildPlaneDiagram(),
              SizedBox(height: 20.0),
              _buildPlaneDefinition(_isEnglish),
              SizedBox(height: 20.0),
              _buildPlaneTypes(_isEnglish),
            ],
          ),
        ),
      ),
    );
  }

  String _getPageContent() {
    var content = "";
    if (_isEnglish) {
      content =
          'A plane is a flat, two-dimensional surface that extends infinitely in all directions.';
      content += 'Types of Planes:';
      content +=
          '1. Horizontal Plane. A plane that is parallel to the horizon.';
      content +=
          '2. Vertical Plane. A plane that is perpendicular to the horizon.';
      content +=
          '3. Inclined Plane. A plane that is at an angle to the horizontal plane.';
    } else {
      content =
          'Un plano es una superficie plana bidimensional que se extiende infinitamente en todas direcciones.';
      content += 'Tipos de Planos:';
      content += '1. Plano Horizontal. Un plano que es paralelo al horizonte.';
      content +=
          '2. Plano Vertical. Un plano que es perpendicular al horizonte.';
      content +=
          '3. Plano Inclinado. Un plano que está en un ángulo con respecto al plano horizontal.';
    }

    return content;
  }

  Widget _buildPlaneDiagram() {
    return SizedBox(
      height: 100.0,
      child: CustomPaint(
        painter: PlanePainter(),
      ),
    );
  }

  Widget _buildPlaneDefinition(bool isEnglish) {
    return Text(
      isEnglish
          ? 'A plane is a flat, two-dimensional surface that extends infinitely in all directions.'
          : 'Un plano es una superficie plana bidimensional que se extiende infinitamente en todas direcciones.',
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildPlaneTypes(bool isEnglish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnglish ? 'Types of Planes:' : 'Tipos de Planos:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        _buildPlaneTypeItem(
          isEnglish ? '1. Horizontal Plane' : '1. Plano Horizontal',
          isEnglish
              ? 'A plane that is parallel to the horizon.'
              : 'Un plano que es paralelo al horizonte.',
        ),
        _buildPlaneTypeItem(
          isEnglish ? '2. Vertical Plane' : '2. Plano Vertical',
          isEnglish
              ? 'A plane that is perpendicular to the horizon.'
              : 'Un plano que es perpendicular al horizonte.',
        ),
        _buildPlaneTypeItem(
          isEnglish ? '3. Inclined Plane' : '3. Plano Inclinado',
          isEnglish
              ? 'A plane that is at an angle to the horizontal plane.'
              : 'Un plano que está en un ángulo con respecto al plano horizontal.',
        ),
      ],
    );
  }

  Widget _buildPlaneTypeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(description),
        ],
      ),
    );
  }
}

class PlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    canvas.drawRect(
        Rect.fromLTWH(20, 20, size.width - 40, size.height - 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
