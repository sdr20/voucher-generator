import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() {
  runApp(VoucherApp());
}

class VoucherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voucher Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      home: VoucherHomePage(),
    );
  }
}

class VoucherHomePage extends StatefulWidget {
  @override
  _VoucherHomePageState createState() => _VoucherHomePageState();
}

class _VoucherHomePageState extends State<VoucherHomePage> {
  final List<String> vouchers = [
    "28021739",
    "27396771",
    "52464929",
    "53228249",
    "36962104",
    "30874815",
    "23011102",
    "28431093",
    "12207113",
  ];
  String? selectedVoucher;

  void _generateVoucher() {
    if (vouchers.isNotEmpty) {
      setState(() {
        selectedVoucher = (vouchers..shuffle()).first;
        vouchers.remove(selectedVoucher); 
      });

      Timer(Duration(seconds: 30), () {
        setState(() {
          selectedVoucher = null;
        });
      });
    } else {
 
      setState(() {
        selectedVoucher = "No vouchers left!";
      });
    }
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); 
    } else if (Platform.isIOS) {
      exit(0); 
    } else {
      exit(0); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher Generator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (selectedVoucher == null || selectedVoucher == "No vouchers left!")
              Center(
                child: ElevatedButton(
                  onPressed: _generateVoucher,
                  child: Text('Generate Voucher'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            if (selectedVoucher != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Generated Voucher',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          selectedVoucher!,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Please access this link\n192.168.1.1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedVoucher = null;
                                });
                              },
                              child: Text('Done'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
