import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  final TextEditingController nController = TextEditingController();
  String result = '';
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void tinhToan(String operation) {
    setState(() {
      final double? a = double.tryParse(aController.text);
      final double? b = double.tryParse(bController.text);

      if (a == null || b == null) {
        result = 'Số không hợp lệ! Vui lòng nhập lại!';
        return;
      }

      switch (operation) {
        case '+':
          result = 'Kết quả: ${(a + b).toStringAsFixed(1)}';
          break;
        case '-':
          result = 'Kết quả: ${(a - b).toStringAsFixed(1)}';
          break;
        case '*':
          result = 'Kết quả: ${(a * b).toStringAsFixed(1)}';
          break;
        case '/':
          if (b == 0) {
            result = 'Lỗi! Số B không được bằng 0';
          } else {
            result = 'Kết quả: ${(a / b).toStringAsFixed(1)}';
          }
          break;
      }
    });
  }

  void checkSoNguyenTo(BuildContext context) {
    final int? n = int.tryParse(nController.text);

    if (n == null || n < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$n không là số nguyên tố.')));
      return;
    }

    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$n không là số nguyên tố.')));
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$n là số nguyên tố.')));
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        title: Text('Giải bài toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: aController,
              decoration: InputDecoration(
                labelText: 'Nhập vào số A',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bController,
              decoration: InputDecoration(
                labelText: 'Nhập vào số B',
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => tinhToan('+'),
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => tinhToan('-'),
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => tinhToan('*'),
                  child: Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => tinhToan('/'),
                  child: Text('/'),
                ),
              ],
            ),
            Text(result),
            TextField(
              controller: nController,
              decoration: InputDecoration(
                labelText: 'Nhập vào số n',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => checkSoNguyenTo(context),
              child: Text('Kiểm tra số nguyên tố'),
            ),
          ],
        ),
      ),
    );
  }
}
