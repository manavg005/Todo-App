import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/business_layer/provider/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskProvider _provider;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Input Field
            _buildTitleInputField(),

            SizedBox(height: 10),

            // Description Input Field
            _buildDescriptionInputField(),

            SizedBox(height: 10),

            // Add Button
            _buildAddButton(),

            SizedBox(height: 10),

            // Task List
            Expanded(child: _buildTaskList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleInputField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  Widget _buildDescriptionInputField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      child: Text("Add"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        textStyle: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        _provider.addTask(
          _titleController.text.trim(),
          _descriptionController.text.trim(),
        );
        _titleController.clear();
        _descriptionController.clear();
      },
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _provider.task.length,
      itemBuilder: (context, index) {
        final task = _provider.task[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(task.description),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (v) => _provider.markTaskComplete(index),
            ),
            trailing: IconButton(
              onPressed: () => _provider.deleteTask(index),
              icon: Icon(Icons.delete_forever, color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
