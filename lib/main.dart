import 'package:flutter/material.dart';
import 'package:mercado_pago_app/utils/globals.dart' as globals;
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

final Map<String, Object> preference = {
  "items": [
    {
      "title": "Test Modified",
      "quantity": 1,
      "currency_id": "USD",
      "unit_price": 20.4
    }
  ],
  'payer': {'name': 'Buyer G.', 'email': 'test@gmail.com'}
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mercado Pago',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> ejecutarMercadoPago() async {
    (await MercadoPagoIntegration.startCheckout(
      publicKey: globals.mpTESTPublicKey,
      preference: preference,
      accessToken: globals.mpTESTAccessToken,
    ))
        .fold((Failure failure) {
      debugPrint('Failure => ${failure.message}');
    }, (Payment payment) {
      debugPrint('Payment => ${payment.paymentId}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado Pago'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: ejecutarMercadoPago,
          child: const Text(
            'Comprar con Mercado Pago',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
