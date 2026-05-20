import 'package:flutter/material.dart';

void main() {
  runApp(const ConexionMigranteApp());
}

class ConexionMigranteApp extends StatelessWidget {
  const ConexionMigranteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conexión Migrante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          primary: const Color(0xFF0284C7),
          secondary: const Color(0xFFF59E0B),
        ),
        useMaterial3: true,
      ),
      home: const PantallaLogin(),
    );
  }
}

// ==========================================================
// 1. PANTALLA DE ACCESO / AUTENTICACIÓN
// ==========================================================
class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _iniciarSesion() {
    if (_emailController.text.isNotEmpty && _passwordController.text.length >= 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un correo válido y clave de 4 dígitos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.diversity_3, size: 90, color: Color(0xFF0284C7)),
              const SizedBox(height: 12),
              const Text(
                'CONEXIÓN MIGRANTE',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0284C7), letterSpacing: 1.2),
              ),
              const Text(
                'Plataforma de Apoyo Seguro y Red Solidaria',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña Seguro',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0284C7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _iniciarSesion,
                  child: const Text('INGRESAR DE FORMA SEGURA', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('¿Eres nuevo? Regístrate en la comunidad', style: TextStyle(color: Color(0xFF0284C7))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// 2. ENTORNO PRINCIPAL (CONTENEDOR DE NAVEGACIÓN UBICUA)
// ==========================================================
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _pestanaActual = 0;

  final List<Widget> _vistas = [
    const TablonAnunciosVista(),
    const MapaGeolocalizacionSimulado(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexión Migrante', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0284C7),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PantallaLogin()),
              );
            },
          )
        ],
      ),
      body: _vistas[_pestanaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pestanaActual,
        selectedItemColor: const Color(0xFF0284C7),
        unselectedItemColor: Colors.grey,
        onTap: (indice) {
          setState(() {
            _pestanaActual = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.space_dashboard), label: 'Anuncios'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Cercanos (GPS)'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_comment),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Módulo para crear nuevo microanuncio verificado.')),
          );
        },
      ),
    );
  }
}

// ==========================================================
// 3. TABLÓN DE ANUNCIOS CON SISTEMA ANTI-ESTAFAS
// ==========================================================
class TablonAnunciosVista extends StatefulWidget {
  const TablonAnunciosVista({super.key});

  @override
  State<TablonAnunciosVista> createState() => _TablonAnunciosVistaState();
}

class _TablonAnunciosVistaState extends State<TablonAnunciosVista> {
  final List<Map<String, dynamic>> _anuncios = [
    {
      'id': '1',
      'categoria': 'EMPLEO',
      'titulo': 'Ayudante de construcción (Pago diario)',
      'descripcion': 'Se busca personal para remodelación. No se requiere documentación estricta inicial, pago garantizado al terminar la jornada.',
      'distancia': 'A 1.2 km de tu ubicación',
      'reportes': 0,
    },
    {
      'id': '2',
      'categoria': 'DONACIÓN',
      'titulo': 'Ropa de invierno y cobijas para familia',
      'descripcion': 'Tenemos chaquetas y calzado para adultos y niños gratis. Recoger en el centro comunitario solidario.',
      'distancia': 'A 0.5 km de tu ubicación',
      'reportes': 0,
    },
    {
      'id': '3',
      'categoria': 'SALUD / SOLIDARIDAD',
      'titulo': 'Asesoría médica comunitaria sin costo',
      'descripcion': 'Atención los días Sábados por profesionales voluntarios para chequeos generales e infantil.',
      'distancia': 'A 3.4 km de tu ubicación',
      'reportes': 1,
    },
    {
      'id': '4',
      'categoria': 'EMPLEO',
      'titulo': '[SOSPECHOSO] Tramitamos visa de trabajo en 2 días por \$500',
      'descripcion': 'Escríbenos para asegurar tu cupo legal inmediato pagando por adelantado.',
      'distancia': 'A 15 km de tu ubicación',
      'reportes': 4,
    }
  ];

  void _reportarAnuncio(int indice) {
    setState(() {
      _anuncios[indice]['reportes']++;
    });

    if (_anuncios[indice]['reportes'] >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anuncio ocultado automáticamente por el Algoritmo Anti-Estafas comunitario.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final anunciosActivos = _anuncios.where((item) => item['reportes'] < 3).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: anunciosActivos.length,
        itemBuilder: (context, index) {
          final item = anunciosActivos[index];
          final esEmpleo = item['categoria'] == 'EMPLEO';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: esEmpleo ? Colors.green.shade100 : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item['categoria'],
                          style: TextStyle(color: esEmpleo ? Colors.green.shade800 : Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(item['distancia'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(item['titulo'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(item['descripcion'], style: const TextStyle(color: Colors.black87, fontSize: 14)),
                  const SizedBox(height: 14),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text('Contactar ayuda'),
                        onPressed: () {},
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.report_problem, size: 18, color: Colors.red),
                        label: Text('Reportar Fraude (${item['reportes']})', style: const TextStyle(color: Colors.red)),
                        onPressed: () {
                          int indiceOriginal = _anuncios.indexWhere((element) => element['id'] == item['id']);
                          _reportarAnuncio(indiceOriginal);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================================
// 4. MÓDULO SIMULADO DE GEOLOCALIZACIÓN
// ==========================================================
class MapaGeolocalizacionSimulado extends StatelessWidget {
  const MapaGeolocalizacionSimulado({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Visualización de Radio Cercano',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
Text(
  'Aquí se renderizará el SDK de Google Maps. Los microanuncios se cargarán dinámicamente según las coordenadas GPS del dispositivo en tiempo real.',
  textAlign: TextAlign.center,
  style: TextStyle(color: Colors.grey),
), 
          const SizedBox(height: 30),
          const Text('Rango de búsqueda actual: 5 Kilómetros', style: TextStyle(fontWeight: FontWeight.w500)),
          Slider(
            value: 5.0,
            max: 50.0,
            divisions: 10,
            label: '5 km',
            onChanged: (double valor) {},
          ),
        ],
      ),
    );
  }
}
