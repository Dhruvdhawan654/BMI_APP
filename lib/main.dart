import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();
  var bgColor= Colors.cyan[100];


  var result = "";
  Color resultColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Center(
          child: Text(
            'Your BMI',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      body:Center(
        child: Container(
            color: Colors.blueGrey[200],
            width: 300,
            height: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BMI Calculator',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: wtController,
                  decoration: const InputDecoration(
                    label: Text('Enter your Weight (kg)'),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: ftController,
                  decoration: const InputDecoration(
                    label: Text('Enter your Height (feet)'),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: inchController,
                  decoration: const InputDecoration(
                    label: Text('Enter your Height (inch)'),
                    prefixIcon: Icon(Icons.height_outlined),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inc = inchController.text.toString();

                    if (wt.isNotEmpty && ft.isNotEmpty && inc.isNotEmpty) {
                      var iwt = double.parse(wt);
                      var ift = double.parse(ft);
                      var iinc = double.parse(inc);

                      // height in meters
                      var totalInches = (ift * 12) + iinc;
                      var totalCm = totalInches * 2.54;
                      var totalM = totalCm / 100;

                      var bmi = iwt / (totalM * totalM);

                      setState(() {
                        if (bmi < 18.5) {
                          result =
                          "Your BMI is ${bmi.toStringAsFixed(2)}\nCategory: Underweight 😕";
                          resultColor = Colors.blue;
                        } else if (bmi >= 18.5 && bmi < 25) {
                          result =
                          "Your BMI is ${bmi.toStringAsFixed(2)}\nCategory: Normal 😊";
                          resultColor = Colors.green;
                        } else if (bmi >= 25 && bmi < 30) {
                          result =
                          "Your BMI is ${bmi.toStringAsFixed(2)}\nCategory: Overweight 😐";
                          resultColor = Colors.orange;
                        } else {
                          result =
                          "Your BMI is ${bmi.toStringAsFixed(2)}\nCategory: Obese 😟";
                          resultColor = Colors.red;
                        }
                      });
                    } else {
                      setState(() {
                        result = "⚠️ Please fill all the required fields!";
                        resultColor = Colors.deepOrange;
                      });
                    }
                  },
                  child: const Text(
                    'CALCULATE',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  result,
                  style: TextStyle(fontSize: 16, color: resultColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ),

    );
  }
}
