import 'package:flutter/material.dart';
import 'package:frontend_vania/service/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final data = await getUserProfile();
      setState(() {
        userData = data['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData != null
              ? Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${userData!['name']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Email: ${userData!['email']}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('Failed to load profile data'),
                ),
    );
  }
}
