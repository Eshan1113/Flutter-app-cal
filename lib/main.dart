import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Calculator',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _input = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _input = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_input.isNotEmpty) {
          _num1 = double.parse(_input);
          _operator = value;
          _input = '';
        }
      } else if (value == '=') {
        if (_input.isNotEmpty && _operator.isNotEmpty) {
          _num2 = double.parse(_input);
          switch (_operator) {
            case '+':
              _display = (_num1 + _num2).toString();
              break;
            case '-':
              _display = (_num1 - _num2).toString();
              break;
            case '*':
              _display = (_num1 * _num2).toString();
              break;
            case '/':
              _display = _num2 != 0 ? (_num1 / _num2).toString() : 'Error';
              break;
          }
          _input = '';
          _operator = '';
        }
      } else {
        _input += value;
        _display = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                _display,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  _buildButtonRow(['7', '8', '9', '/']),
                  _buildButtonRow(['4', '5', '6', '*']),
                  _buildButtonRow(['1', '2', '3', '-']),
                  _buildButtonRow(['C', '0', '=', '+']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return Expanded(
            child: GestureDetector(
              onTap: () => _onButtonPressed(button),
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: button == '=' ? Colors.teal : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    button,
                    style: TextStyle(
                      fontSize: 24,
                      color: button == '=' ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
