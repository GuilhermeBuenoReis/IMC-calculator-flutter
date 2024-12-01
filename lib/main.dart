import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({Key? key}) : super(key: key);

  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _resultText = "";

  void _calculateIMC() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);

    if (weight == null || height == null || height <= 0) {
      setState(() {
        _resultText = "Por favor, insira valores válidos.";
      });
      return;
    }

    final double imc = weight / (height * height);

    setState(() {
      if (imc < 18.5) {
        _resultText = "Seu IMC é ${imc.toStringAsFixed(2)} (Abaixo do peso)";
      } else if (imc >= 18.5 && imc < 24.9) {
        _resultText = "Seu IMC é ${imc.toStringAsFixed(2)} (Peso normal)";
      } else if (imc >= 25 && imc < 29.9) {
        _resultText = "Seu IMC é ${imc.toStringAsFixed(2)} (Sobrepeso)";
      } else {
        _resultText = "Seu IMC é ${imc.toStringAsFixed(2)} (Obesidade)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (m)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateIMC,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 16),
            Text(
              _resultText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
