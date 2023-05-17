import 'package:flutter/material.dart';
import 'package:my_project/service/category_service.dart';
class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();

  var todoDescriptionController = TextEditingController();

  var todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = <DropdownMenuItem>[];
  @override
  initState(){
  super.initState();
  _loadCategories();
  }
  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create a todo'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller:  todoTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText:  'Write todo title',
            ),
          ),
          TextField(
            controller:  todoDescriptionController,
            decoration: InputDecoration(
                labelText: 'Description',
                hintText:  'Write todo description',
            ),
          ),
          TextField(
            controller:  todoDateController,
            decoration: InputDecoration(
                labelText: 'Date',
                hintText:  'Pick a Date',
              prefixIcon: InkWell(
                onTap: (){},
                child: Icon(Icons.calendar_today),
              ),
            ),
          ),
          DropdownButtonFormField(
              value: _selectedValue,
              hint: Text("Category"),
              items: _categories,
              onChanged: (value){
                setState(() {
                  _selectedValue = value;
                });
              }
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              backgroundColor : Colors.blue,
            ),
            child: const Text("Add"),
          )

        ],
      ),
    );
  }
}
