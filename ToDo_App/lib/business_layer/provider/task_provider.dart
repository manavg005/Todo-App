import 'package:flutter/cupertino.dart';
import 'package:todo_app/data_layer/todo_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _task = [];

  List<Task> get task => _task;

  void addTask(String title, String description) {
    _task.add(Task(title: title, description: description));

    notifyListeners();
  }

  void deleteTask(int index) {
    _task.removeAt(index);
    notifyListeners();
  }

  void markTaskComplete(int index) {
    _task[index].isCompleted = !_task[index].isCompleted;
    notifyListeners();
  }
}
