// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formativa_kauan/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() async {
  testWidgets('Testar envio de dados para API', (WidgetTester tester) async {
    // Mock da resposta da API
    final Map<String, dynamic> mockUserData = {
      'name': 'John Doe',
      'age': '30',
      'address': '123 Main St',
      'cpf': '12345678901',
      'email': 'john@example.com',
      'phone': '123-456-7890',
      'dob': '1990-01-01',
    };

    // Definir a URL da API
    final String apiUrl = 'http://localhost:3000/usuarios';

    // Criar um cliente HTTP mockado
    http.Client client = MockClient((http.Request request) async {
      return http.Response(jsonEncode(mockUserData), 201);
    });

    // Construir o aplicativo e disparar um frame.
    await tester.pumpWidget(MyApp());

    // Verificar se a tela de login é exibida inicialmente.
    expect(find.text('Login'), findsOneWidget);

    // Clicar no botão de login.
    await tester.tap(find.byKey(ValueKey('login_button')));

    // Aguardar a atualização da tela.
    await tester.pumpAndSettle();

    // Verificar se a tela de entrada de dados é exibida após o login.
    expect(find.text('Data Entry'), findsOneWidget);

    // Preencher todos os campos com dados de teste.
    await tester.enterText(find.byKey(ValueKey('name_field')), 'John Doe');
    await tester.enterText(find.byKey(ValueKey('age_field')), '30');
    await tester.enterText(find.byKey(ValueKey('address_field')), '123 Main St');
    await tester.enterText(find.byKey(ValueKey('cpf_field')), '12345678901');
    await tester.enterText(find.byKey(ValueKey('email_field')), 'john@example.com');
    await tester.enterText(find.byKey(ValueKey('phone_field')), '123-456-7890');
    await tester.enterText(find.byKey(ValueKey('dob_field')), '1990-01-01');

    // Clicar no botão de submit.
    await tester.tap(find.byKey(ValueKey('submit_button')));

    // Aguardar a atualização da tela.
    await tester.pumpAndSettle();

    // Verificar se a tela de exibição de dados é exibida após o envio dos dados.
    expect(find.text('Display Data'), findsOneWidget);

    // Verificar se todos os dados inseridos são exibidos corretamente.
    expect(find.text('Name: John Doe'), findsOneWidget);
    expect(find.text('Age: 30'), findsOneWidget);
    expect(find.text('Address: 123 Main St'), findsOneWidget);
    expect(find.text('CPF: 12345678901'), findsOneWidget);
    expect(find.text('Email: john@example.com'), findsOneWidget);
    expect(find.text('Phone: 123-456-7890'), findsOneWidget);
    expect(find.text('Date of Birth: 1990-01-01'), findsOneWidget);
  });
}