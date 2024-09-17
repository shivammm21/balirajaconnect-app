import 'dart:io';  // for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  int quantity1 = 0;
  int quantity2 = 0;
  int quantity3 = 0;

  String selectedSize = 'Small';
  File? _selectedImage;
  File? _selectedVideo;

  // TextEditingControllers for each quantity field
  TextEditingController _quantity1Controller = TextEditingController();
  TextEditingController _quantity2Controller = TextEditingController();
  TextEditingController _quantity3Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantity1Controller.text = quantity1.toString();
    _quantity2Controller.text = quantity2.toString();
    _quantity3Controller.text = quantity3.toString();
  }

  @override
  void dispose() {
    _quantity1Controller.dispose();
    _quantity2Controller.dispose();
    _quantity3Controller.dispose();
    super.dispose();
  }

  // Function to pick an image from the camera
  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  // Function to pick a video from the camera
  Future _pickVideoFromCamera() async {
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (returnedVideo == null) return;

    setState(() {
      _selectedVideo = File(returnedVideo.path);
    });
  }

  // Function to update the quantity
  void _updateQuantity(int quantity, int newValue, Function(int) onQuantityChanged) {
    setState(() {
      int updatedValue = newValue;
      if (updatedValue < 0) updatedValue = 0;
      onQuantityChanged(updatedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset('lib/images/logo.png', height: 50, width: 50),

              SizedBox(height: 10),
              Text(
                'HYBRID MARKET',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              Text(
                'Product Description',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),

              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),

              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedSize,
                decoration: InputDecoration(
                  labelText: 'Product Size',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                items: ['Small', 'Medium', 'Large'].map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSize = value!;
                  });
                },
              ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildPriceField(
                        'Base Price', 
                        quantity1, 
                        _quantity1Controller, 
                        (newQuantity) => setState(() => quantity1 = newQuantity),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildPriceField(
                        'Target Price', 
                        quantity2, 
                        _quantity2Controller, 
                        (newQuantity) => setState(() => quantity2 = newQuantity),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: _buildPriceField(
                  'Quantity', 
                  quantity3, 
                  _quantity3Controller, 
                  (newQuantity) => setState(() => quantity3 = newQuantity),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImageFromCamera,
                icon: Icon(Icons.image, color: Colors.green),
                label: Text('Upload Product Image', style: TextStyle(color: Colors.green)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickVideoFromCamera,
                icon: Icon(Icons.videocam, color: Colors.green),
                label: Text('Upload Product Video', style: TextStyle(color: Colors.green)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Add product functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Add Product',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceField(String label, int quantity, TextEditingController controller, Function(int) onQuantityChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 0) onQuantityChanged(quantity - 1);
                  controller.text = (quantity - 1).toString();
                },
              ),
              Container(
                width: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: controller,
                  onSubmitted: (value) {
                    int newValue = int.tryParse(value) ?? quantity;
                    _updateQuantity(quantity, newValue, onQuantityChanged);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  onQuantityChanged(quantity + 1);
                  controller.text = (quantity + 1).toString();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
