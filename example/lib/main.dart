import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:signaturefingerprint/signaturefingerprint.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appSignature = 'Unknown';

  @override
  void initState() {
    super.initState();
    initAppSignatureState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initAppSignatureState() async {
    String appSignature;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      appSignature = await Signaturefingerprint.getSignatureFingerprint();
    } on PlatformException {
      appSignature = 'Failed to get app signature.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appSignature = appSignature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_appSignature\n'),
        ),
      ),
    );
  }
}
