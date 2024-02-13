import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(const QRCodeScannerApp());

class QRCodeScannerApp extends StatefulWidget {
  const QRCodeScannerApp({super.key});

  @override
  QRCodeScannerAppState createState() => QRCodeScannerAppState();
}

class QRCodeScannerAppState extends State<QRCodeScannerApp> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  List<String> listScannedResults = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> getList() {
    List<Widget> children = [];
    for (var i = 0; i < listScannedResults.length; i++) {
      children.add(Text(listScannedResults[i]));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code Scanner'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    const Text('Scan a QR code'),
                    ...getList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) {
        print('Scanned data: ${scanData.code}');
        // Handle the scanned data as desired
        listScannedResults.add('Scanned data: ${scanData.code}');
      });
    });
  }
}
