import 'package:flutter/material.dart';

void main() => runApp(ImcCalculator());

class ImcCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC', style: TextStyle(fontSize: 24)),
          backgroundColor: Colors.purpleAccent,
        ),
        body: ImcForm(),
      ),
    );
  }
}

class ImcForm extends StatefulWidget {
  @override
  _ImcFormState createState() => _ImcFormState();
}

class _ImcFormState extends State<ImcForm> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double imc = 0;
  String result = '';

  void calculateImc() {
    double weight;
    double height;

    // Validação de entrada com tratamento de erros
    try {
      weight = double.parse(weightController.text.replaceAll(',', '.'));
      height = double.parse(heightController.text.replaceAll(',', '.')) / 100;
    } catch (e) {
      setState(() {
        result = 'Por favor, insira valores válidos.';
        imc = 0;
      });
      return;
    }

    // Verificação se os valores são válidos
    if (weight <= 0 || height <= 0) {
      setState(() {
        result = 'Peso e altura devem ser maiores que zero.';
        imc = 0;
      });
      return;
    }

    // Cálculo do IMC
    imc = weight / (height * height);

    // Classificação do IMC
    if (imc < 18.5) {
      result = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 25) {
      result = 'Peso normal';
    } else if (imc >= 25 && imc < 30) {
      result = 'Sobrepeso';
    } else {
      result = 'Obesidade';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de entrada de peso
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Peso (kg)',
              labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 4, 19, 83), fontSize: 18),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color.fromARGB(131, 177, 57, 27)),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Campo de entrada de altura
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Altura (cm)',
              labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 4, 19, 83), fontSize: 18),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color.fromARGB(131, 177, 57, 27)),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Botão para calcular o IMC
          ElevatedButton(
            onPressed: calculateImc,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 36, 6,
                  41), // Corrigido: `primary` para `backgroundColor`
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Calcular IMC'),
          ),
          SizedBox(height: 30),

          // Exibição do resultado do IMC
          Text(
            'Seu IMC: ${imc > 0 ? imc.toStringAsFixed(2) : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 46, 6, 53)),
          ),
          SizedBox(height: 10),

          // Exibição da classificação do IMC
          Text(
            result,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 53, 9, 61)),
          ),
        ],
      ),
    );
  }
}
