class CalculatorController {
  static const kZero = '0';
  static const kMemoryFirst = 0;
  static const kMemoryClear = [0.0, 0.0];
  static const kOperationNull = null;
  static const kPoint = ',';
  static const kEmpty = '';
  static const kOperations = ['+', '-', 'x', '/', '%', '='];
  List<double> _memories = [0.0, 0.0];
  int _currentMemoryIndex = 0;
  String _operation;
  bool _usedOperation;
  String result;
  String display;
  bool _usedEqual;
  CalculatorController() {
    _clear();
  }

  void _clear() {
    result = kZero;
    _memories.setAll(kMemoryFirst, kMemoryClear);
    _currentMemoryIndex = kMemoryFirst;
    _operation = kOperationNull;
    _usedOperation = false;
    _usedEqual = false;
    display = kEmpty;
  }

  void _clear2() {
    display = kEmpty;
    _memories.setAll(kMemoryFirst, kMemoryClear);
    _currentMemoryIndex = kMemoryFirst;
    _operation = kOperationNull;
    _usedOperation = false;
    _usedEqual = false;
    display = kEmpty;
  }

  void _deleteDigit() {
    final length = result.length;
    final length1 = display.length;
    if (length > 1) {
      result = result.substring(0, length - 1);
    } else {
      result = kZero;
    }
    if (length1 > 1) {
      display = display.substring(0, length1 - 1);
    } else {
      display = kZero;
    }
    if (result == kZero) {
      _clear2();
    }
    if (display == kEmpty) {}
    _memories[_currentMemoryIndex] = double.parse(
      result.replaceAll(kPoint, '.'),
    );
  }

  void _addDigit(String digit) {
    if (_usedOperation) result = kZero;
    if (result == kZero && digit != kPoint) result = kEmpty;
    if (result.contains(kPoint) && digit == kPoint) digit = kEmpty;

    result += digit;
    display += digit;

    _memories[_currentMemoryIndex] = double.parse(
      result.replaceAll(kPoint, '.'),
    );
    _usedOperation = false;
  }

  void _setOperation(String operation) {
    if (_usedOperation && _operation == operation) return;

    if (_currentMemoryIndex == kMemoryFirst) {
      _currentMemoryIndex++;
    } else if (!_usedEqual || (_usedEqual && operation == '=')) {
      _memories[kMemoryFirst] = _calculate();
    }

    if (operation != '=') {
      _operation = operation;
      _usedEqual = false;
    } else {
      _usedEqual = true;
    }

    _outputFormat();
    _usedOperation = true;
  }

  void _outputFormat() {
    result = _memories[kMemoryFirst].toString();
    result = result.endsWith('.0') ? result.replaceAll('.0', '') : result;
    result = result.replaceAll('.', kPoint);
  }

  double _calculate() {
    if (_operation == '+') return _memories[0] + _memories[1];
    if (_operation == '-') return _memories[0] - _memories[1];
    if (_operation == 'x') return _memories[0] * _memories[1];
    if (_operation == '/') return _memories[0] / _memories[1];
    if (_operation == '%') return _memories[0] % _memories[1];
    return 0.0;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
    } else if (command == 'DEL') {
      _deleteDigit();
    } else if (kOperations.contains(command)) {
      _setOperation(command);
      if (command != "=" &&
          !display.endsWith('+') &&
          !display.endsWith('-') &&
          !display.endsWith('/') &&
          !display.endsWith('x') &&
          !display.endsWith('%')) display += command;
    } else {
      _addDigit(command);
    }
  }
}
