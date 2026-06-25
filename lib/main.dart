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
// 1. PANTALLA DE ACCESO
// ==========================================================
class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _emailController = TextEditingController(text: "comunidad@migrante.org");
  final _passwordController = TextEditingController(text: "1234");

  void _iniciarSesion() {
    if (_emailController.text.isNotEmpty && _passwordController.text.length >= 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa datos válidos.'), backgroundColor: Colors.red),
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
              const Text('CONEXIÓN MIGRANTE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
              const SizedBox(height: 35),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Correo', border: OutlineInputBorder())),
              const SizedBox(height: 18),
              TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Contraseña', border: OutlineInputBorder())),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
                  onPressed: _iniciarSesion,
                  child: const Text('INGRESAR SEGURO'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// BASE DE DATOS GLOBAL CON VALORES PARA MAPA Y ANUNCIOS
// ==========================================================
List<Map<String, dynamic>> listaGlobalAnuncios = [
  {
    'id': '1', 'categoria': 'EMPLEO',
    'titulo': 'Ayudante de construcción (Pago diario)',
    'descripcion': 'Se busca personal para remodelación en zona norte. Pago garantizado en efectivo al terminar.',
    'distancia': 'A 1.2 km', 'reportes': 0, 'x': 0.2, 'y': 0.15
  },
  {
    'id': '2', 'categoria': 'DONACIÓN',
    'titulo': 'Ropa de invierno y cobijas gratis',
    'descripcion': 'Tenemos chaquetas, sacos y cobijas térmicas para adultos y niños. Recoger en el centro comunitario.',
    'distancia': 'A 0.5 km', 'reportes': 0, 'x': 0.75, 'y': 0.4
  },
  {
    'id': '3', 'categoria': 'SALUD',
    'titulo': 'Asesoría médica comunitaria voluntaria',
    'descripcion': 'Atención médica general y pediátrica los sábados sin costo para familias sin afiliación.',
    'distancia': 'A 3.4 km', 'reportes': 0, 'x': 0.45, 'y': 0.65
  },
  {
    'id': '4', 'categoria': 'HOSPEDAJE',
    'titulo': 'Albergue temporal solidario (Noche)',
    'descripcion': 'Espacio seguro para pasar la noche con cena y duchas incluidas. Cupos limitados por día.',
    'distancia': 'A 2.1 km', 'reportes': 0, 'x': 0.15, 'y': 0.55
  },
  {
    'id': '5', 'categoria': 'EMPLEO',
    'titulo': 'Personal para empaque y bodega',
    'descripcion': 'Se necesitan 3 personas para organizar cajas y despachos de mercancía. Horario flexible.',
    'distancia': 'A 4.0 km', 'reportes': 0, 'x': 0.6, 'y': 0.25
  },
  {
    'id': '6', 'categoria': 'SALUD',
    'titulo': 'Apoyo psicológico y orientación',
    'descripcion': 'Sesiones individuales de escucha y manejo de estrés por psicólogos aliados.',
    'distancia': 'A 1.8 km', 'reportes': 0, 'x': 0.3, 'y': 0.8
  },
];

// ==========================================================
// 2. ENTORNO PRINCIPAL (CON LOS DOS BOTONES JUNTOS)
// ==========================================================
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _pestanaActual = 0;

  void _actualizarTodo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexión Migrante', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0284C7),
        actions: [
          const Icon(Icons.verified, color: Colors.greenAccent),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), 
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PantallaLogin()))
          ),
        ],
      ),
      body: IndexedStack(
        index: _pestanaActual,
        children: [
          TablonAnunciosVista(alActualizar: _actualizarTodo),
          MapaGeolocalizacionSimulado(alActualizar: _actualizarTodo),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pestanaActual,
        selectedItemColor: const Color(0xFF0284C7),
        onTap: (indice) => setState(() => _pestanaActual = indice),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.space_dashboard), label: 'Tablón'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa GPS'),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btnSos',
            backgroundColor: Colors.red,
            child: const Icon(Icons.emergency, color: Colors.white),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('🚨 Alerta SOS activada: Notificando a red de apoyo segura.'), backgroundColor: Colors.red)
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'btnCrear',
            backgroundColor: const Color(0xFF0284C7),
            child: const Icon(Icons.add_comment, color: Colors.white),
            onPressed: () {
              _mostrarFormularioNuevoAnuncio(context);
            },
          ),
        ],
      ),
    );
  }

  void _mostrarFormularioNuevoAnuncio(BuildContext ctx) {
    final tituloCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String catSeleccionada = 'EMPLEO';

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Publicar Ayuda Seguro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: catSeleccionada,
                    items: ['EMPLEO', 'DONACIÓN', 'SALUD', 'HOSPEDAJE'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setModalState(() => catSeleccionada = val!),
                    decoration: const InputDecoration(labelText: 'Categoría'),
                  ),
                  TextField(controller: tituloCtrl, decoration: const InputDecoration(labelText: 'Título')),
                  TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Descripción')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                    onPressed: () {
                      if (tituloCtrl.text.isNotEmpty) {
                        setState(() {
                          listaGlobalAnuncios.insert(0, {
                            'id': DateTime.now().toString(),
                            'categoria': catSeleccionada,
                            'titulo': tituloCtrl.text,
                            'descripcion': descCtrl.text,
                            'distancia': 'A 0.1 km',
                            'reportes': 0, 'x': 0.4, 'y': 0.4
                          });
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Publicar', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ==========================================================
// 3. TABLÓN RE-DISEÑADO CON FILTRADO INTERACTIVO REAL
// ==========================================================
class TablonAnunciosVista extends StatefulWidget {
  final VoidCallback alActualizar;
  const TablonAnunciosVista({super.key, required this.alActualizar});

  @override
  State<TablonAnunciosVista> createState() => _TablonAnunciosVistaState();
}

class _TablonAnunciosVistaState extends State<TablonAnunciosVista> {
  String categoriaFiltro = 'Todo';

  @override
  Widget build(BuildContext context) {
    var anunciosFiltrados = listaGlobalAnuncios.where((i) => i['reportes'] < 3).toList();

    if (categoriaFiltro != 'Todo') {
      anunciosFiltrados = anunciosFiltrados.where((i) => i['categoria'] == categoriaFiltro.toUpperCase()).toList();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar ayudas o empleo...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.shade200,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: ['Todo', 'Empleo', 'Salud', 'Donación', 'Hospedaje'].map((label) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(label), 
                  selected: categoriaFiltro == label, 
                  onSelected: (bool seleccionado) {
                    setState(() {
                      categoriaFiltro = label;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: anunciosFiltrados.isEmpty
              ? Center(child: Text('No hay anuncios en $categoriaFiltro', style: const TextStyle(color: Colors.grey)))
              : ListView.builder(
                  itemCount: anunciosFiltrados.length,
                  itemBuilder: (context, idx) {
                    final item = anunciosFiltrados[idx];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF0284C7).withOpacity(0.1),
                          child: Icon(
                            item['categoria'] == 'EMPLEO' ? Icons.work :
                            item['categoria'] == 'SALUD' ? Icons.local_hospital :
                            item['categoria'] == 'HOSPEDAJE' ? Icons.home : Icons.handshake,
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                        title: Text(item['titulo'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item['descripcion']),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _mostrarDetalleAyuda(context, item),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _mostrarDetalleAyuda(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 30, backgroundColor: Color(0xFF0284C7), child: Icon(Icons.person, color: Colors.white)),
            const SizedBox(height: 10),
            const Text('Perfil Verificado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),
            Text(item['titulo'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item['descripcion'], textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Chat Seguro')),
                TextButton(
                  onPressed: () {
                    int i = listaGlobalAnuncios.indexWhere((e) => e['id'] == item['id']);
                    listaGlobalAnuncios[i]['reportes']++;
                    Navigator.pop(context);
                    widget.alActualizar();
                  },
                  child: const Text('Denunciar', style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// 4. MAPA SIMULADO CON INTERFAZ DE CALLES COMPLETA
// ==========================================================
class MapaGeolocalizacionSimulado extends StatelessWidget {
  final VoidCallback alActualizar;
  const MapaGeolocalizacionSimulado({super.key, required this.alActualizar});

  @override
  Widget build(BuildContext context) {
    final activos = listaGlobalAnuncios.where((i) => i['reportes'] < 3).toList();
    final anchoPantalla = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filtro GPS Espacial: Activo (5 km)', style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.gps_fixed, color: Color(0xFF0284C7)),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(color: Colors.grey.shade300, child: CustomPaint(painter: GridPainter(), size: Size.infinite)),
              const Center(child: Icon(Icons.my_location, color: Colors.blue, size: 42)),
              ...activos.map((a) {
                double xPos = (a['x'] as double) * anchoPantalla;
                if (xPos > anchoPantalla - 40) xPos = anchoPantalla - 40;
                
                return Positioned(
                  left: xPos,
                  top: 400 * (a['y'] as double),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(a['titulo']),
                          content: Text(a['descripcion']),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar'))],
                        ),
                      );
                    },
                    child: const Icon(Icons.location_on, color: Colors.red, size: 38),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white..strokeWidth = 3;
    for (double i = 0; i < size.width; i += 60) { canvas.drawLine(Offset(i, 0), Offset(i, size.height), p); }
    for (double i = 0; i < size.height; i += 60) { canvas.drawLine(Offset(0, i), Offset(size.width, i), p); }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}