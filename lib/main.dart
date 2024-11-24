import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portada del Proyecto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CoverPage(),
    );
  }
}

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Universidad Politécnica de Chiapas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Ingeniería de Software',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                'Nombre: Jonathan Jair Pérez Mejía\n'
                '9-A\n'
                'Materia: Seguridad de la Información\n'
                'Maestro: Alonso Macías Montoya\n'
                'Actividad: Taller',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NetworkInfoScreen(),
                    ),
                  );
                },
                child: const Text('Informacion de la red'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NetworkInfoScreen extends StatefulWidget {
  const NetworkInfoScreen({super.key});

  @override
  State<NetworkInfoScreen> createState() => _NetworkInfoScreenState();
}

class _NetworkInfoScreenState extends State<NetworkInfoScreen> {
  String? ipAddress;
  String? subnetMask;
  String? gateway;
  String? dns;

  @override
  void initState() {
    super.initState();
    _fetchNetworkInfo();
  }

  Future<void> _fetchNetworkInfo() async {
    final info = NetworkInfo();
    final ip = await info.getWifiIP();
    final mask = await info.getWifiSubmask();
    final gw = await info.getWifiGatewayIP();

    setState(() {
      ipAddress = ip;
      subnetMask = mask;
      gateway = gw;
      dns = "No disponible.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Red'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IP Local: ${ipAddress ?? "Cargando..."}'),
            Text('Máscara de Red: ${subnetMask ?? "Cargando..."}'),
            Text('Gateway: ${gateway ?? "Cargando..."}'),
            Text('DNS: ${dns ?? "Cargando..."}'),
          ],
        ),
      ),
    );
  }
}
