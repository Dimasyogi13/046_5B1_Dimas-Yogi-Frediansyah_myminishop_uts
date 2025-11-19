import 'package:flutter/material.dart';

void main() {
  runApp(const MyShopMiniApp());
}

class MyShopMiniApp extends StatelessWidget {
  const MyShopMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop Mini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ==========================================
// MODEL PRODUCT
// ==========================================
class Product {
  final String name;
  final int price;
  final IconData icon;     
  final String imagePath;  

  Product({
    required this.name,
    required this.price,
    required this.icon,
    required this.imagePath,
  });
}

// ==========================================
// HALAMAN HOME (KATEGORI)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> categories = const ['Makanan', 'Minuman', 'Elektronik'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyShop Mini - Kategori")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.category)),
              title: Text(categories[index], style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(category: categories[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// HALAMAN LIST PRODUK (GRID)
// ==========================================
class ProductListScreen extends StatelessWidget {
  final String category;

  ProductListScreen({super.key, required this.category});

  // =====================================================
  // DATA PRODUK (DISESUAIKAN DENGAN FILE ANDA)
  // File: roti.jpg, burger.jpg, americano.jpg, esjeruk.jpg, laptop.jpg, hp.jpg
  // =====================================================
  List<Product> getProducts() {
    if (category == 'Makanan') {
      return [
        Product(name: 'Roti Tawar', price: 12000, icon: Icons.bakery_dining, imagePath: 'assets/images/roti.jpg'),
        Product(name: 'Burger', price: 35000, icon: Icons.lunch_dining, imagePath: 'assets/images/burger.jpg'),
        // Pizza & Donat meminjam gambar yang ada dulu
        Product(name: 'Pizza', price: 85000, icon: Icons.local_pizza, imagePath: 'assets/images/burger.jpg'), 
        Product(name: 'Donat', price: 8000, icon: Icons.donut_large, imagePath: 'assets/images/roti.jpg'),
      ];
    } else if (category == 'Minuman') {
      return [
        // Menggunakan americano.jpg dan esjeruk.jpg
        Product(name: 'Es Kopi', price: 18000, icon: Icons.coffee, imagePath: 'assets/images/americano.jpg'),
        Product(name: 'Jus Jeruk', price: 15000, icon: Icons.local_drink, imagePath: 'assets/images/esjeruk.jpg'),
        Product(name: 'Teh Manis', price: 5000, icon: Icons.emoji_food_beverage, imagePath: 'assets/images/esjeruk.jpg'),
      ];
    } else {
      return [
        // Menggunakan laptop.jpg dan hp.jpg
        Product(name: 'Laptop', price: 7500000, icon: Icons.laptop, imagePath: 'assets/images/laptop.jpg'),
        Product(name: 'Smartphone', price: 3000000, icon: Icons.smartphone, imagePath: 'assets/images/hp.jpg'),
        Product(name: 'Headset', price: 250000, icon: Icons.headphones, imagePath: 'assets/images/laptop.jpg'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, 
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // GAMBAR DI GRID
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.cover,
                          // Jika gambar error, tampilkan icon abu-abu
                          errorBuilder: (ctx, error, stack) => Container(
                            color: Colors.grey[200],
                            child: Icon(product.icon, size: 50, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    // TEXT DI GRID
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(product.name, 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1, 
                            overflow: TextOverflow.ellipsis
                          ),
                          Text("Rp ${product.price}", 
                            style: const TextStyle(color: Colors.green)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// HALAMAN DETAIL PRODUK
// ==========================================
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GAMBAR BESAR
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                product.imagePath,
                width: 250, 
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(product.icon, size: 150, color: Colors.indigo);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Rp ${product.price}",
              style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} dibeli!')),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Beli Sekarang"),
            )
          ],
        ),
      ),
    );
  }
}