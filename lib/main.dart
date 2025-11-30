import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math'; // Pentru constanta pi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversie Unghiuri',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AngleConverter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AngleConverter extends StatefulWidget {
  const AngleConverter({super.key});

  @override
  State<AngleConverter> createState() => _AngleConverterState();
}

class _AngleConverterState extends State<AngleConverter> {
  // Controller pentru input
  final TextEditingController _controller = TextEditingController();

  // Variabile
  String _result = '';
  bool _isDegreesToRadians = true; // true = grade->radiani

  // Funcția de conversie
  void _convertAngle() {
    if (_controller.text.isEmpty) {
      setState(() => _result = 'Introduceți o valoare!');
      return;
    }

    final double? inputValue = double.tryParse(_controller.text);

    if (inputValue == null) {
      setState(() => _result = 'Valoare invalidă!');
      return;
    }

    // Conversia
    double convertedValue;
    String unit;

    if (_isDegreesToRadians) {
      convertedValue = inputValue * pi / 180; // grade -> radiani
      unit = 'radiani';
    } else {
      convertedValue = inputValue * 180 / pi; // radiani -> grade
      unit = 'grade';
    }

    setState(() => _result = '${convertedValue.toStringAsFixed(4)} $unit');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversie Unghiuri'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Switch pentru tip conversie
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: _isDegreesToRadians,
                  onChanged: (value) {
                    setState(() {
                      _isDegreesToRadians = value;
                      _result = '';
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // TextField pentru input
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                labelText: _isDegreesToRadians ? 'Valoare în grade' : 'Valoare în radiani',
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _convertAngle(),
            ),

            const SizedBox(height: 20),

            // Buton pentru conversie
            ElevatedButton(
              onPressed: _convertAngle,
              child: const Text('Convertește', style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 30),

            // Rezultatul
            if (_result.isNotEmpty)
              Text(
                _result,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}