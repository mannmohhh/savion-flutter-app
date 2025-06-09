import 'package:flutter/material.dart';

void main() {
  runApp(const SavionApp());
}

class SavionApp extends StatelessWidget {
  const SavionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savion Life Sciences',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> products = [
    {"name": "CEFX", "file": "assets/products/Product1 -CEFX.jpg"},
    {"name": "CEFX-O", "file": "assets/products/Product2-CEFX-O.jpg"},
    {"name": "SAVIMOX", "file": "assets/products/Product3-SAVIMOX.jpg"},
    {"name": "SAVIKAST-B", "file": "assets/products/Product4-SAVIKAST-B.jpg"},
    {"name": "SAVICORT6", "file": "assets/products/Product5-SAVICORT6.jpg"},
    {"name": "SAVICAL", "file": "assets/products/Product6-SAVICAL.jpg"},
    {"name": "SUFEON", "file": "assets/products/Product7-SUFEON.jpg"},
    {"name": "SAVIDOM-R", "file": "assets/products/Product8-SAVIDOM-R.jpg"},
    {"name": "SAVICOX", "file": "assets/products/Product9-SAVICOX.jpg"},
    {"name": "SAVIDOM-N", "file": "assets/products/Product10-SAVIDOM-N.jpg"},
    {"name": "SAVIDOL-SP", "file": "assets/products/Product11-SAVIDOL-SP.jpg"},
    {"name": "SAVIOX-OZ", "file": "assets/products/Product12-SAVIOX-OZ.jpg"},
    {"name": "SAVICLO-MF", "file": "assets/products/Product13-SAVICLO-MF.jpg"},
    {"name": "SAVIZOLE", "file": "assets/products/Product14-SAVIZOLE.jpg"},
    {"name": "SAVIKID-PM", "file": "assets/products/Product15-SAVIKID-PM.jpg"},
    {"name": "SAFEDIL", "file": "assets/products/Product16-SAFEDIL.jpg"},
  ];

  int? selectedIndex;
  bool showProductView = false;

  void openProductView([int? index]) {
    setState(() {
      showProductView = true;
      selectedIndex = index ?? 0;
    });
  }

  void goHome() {
    setState(() {
      showProductView = false;
      selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image: logo on home, background.jpg on product view
          Positioned.fill(
            child: Image.asset(
              showProductView
                  ? 'assets/logo/background.jpg' // background for product view
                  : 'assets/logo/savion_logo.jpg', // logo for home
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black),
            ),
          ),
          if (!showProductView)
            Center(
              child: ElevatedButton(
                onPressed: () => openProductView(0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text("Show Products"),
              ),
            ),
          if (showProductView)
            SafeArea(
              child: Row(
                children: [
                  // Left: Home button and compact product list
                  Container(
                    width: 120,
                    color: Colors.white.withOpacity(0.92),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.home, color: Colors.blue, size: 32),
                            onPressed: goHome,
                            tooltip: "Home",
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemExtent: 44,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              final isSelected = index == selectedIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.blue[50] : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: isSelected
                                        ? Border.all(color: Colors.blue, width: 2)
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      products[index]["name"]!,
                                      style: TextStyle(
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? Colors.blue[900] : Colors.black,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right: Product image, filling all space right of the list
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(12),
                      child: InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.asset(
                          products[selectedIndex ?? 0]["file"]!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Text(
                              "Image not found",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
