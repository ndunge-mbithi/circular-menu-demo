import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Menu Demo',
      theme: ThemeData.dark(),
      home: const NoteEditorPage(),
    );
  }
}

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage>
    with SingleTickerProviderStateMixin {

  // Controls the open/closed state
  bool _isOpen = false;

  // The animation controller drives the fan-out motion
  late AnimationController _controller;

  // Tracks what was last tapped
  String _selectedAction = 'Tap the + button';

  // Menu items: icon, label, colour
  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.camera_alt, 'label': 'Photo',  'color': const Color(0xFF533483)},
    {'icon': Icons.mic,        'label': 'Audio',  'color': const Color(0xFFe94560)},
    {'icon': Icons.text_fields,'label': 'Text',   'color': const Color(0xFF0f3460)},
    {'icon': Icons.link,       'label': 'Link',   'color': const Color(0xFF0d9488)},
    {'icon': Icons.label,      'label': 'Tag',    'color': const Color(0xFF854F0B)},
  ];

  @override
  void initState() {
    super.initState();

    // PROPERTY 2: animationDuration
    // Controls how long the fan-out animation takes.
  
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      _isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  void _onItemTapped(String label) {
    setState(() {
      _selectedAction = '$label selected!';
      _isOpen = false;
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0e17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        title: const Text('Note Editor'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [

          // Background content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.notes, size: 72, color: Color(0xFF2a2a4a)),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a2e),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFF2a2a4a)),
                ),
                child: Text(
                  _selectedAction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          // Dimmed overlay when menu is open
          if (_isOpen)
            GestureDetector(
              onTap: _toggle,
              child: Container(
                color: Colors.black54,
              ),
            ),

          
          // CIRCULAR MENU — built with AnimatedBuilder
          
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [

                  // Fan out each menu item
                  ..._items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    // Spread items evenly in a half circle above the button
                    // PROPERTY 1: radius
                    // How far each item sits from the centre button.
                    
                    const double radius = 110;

                    final double startAngle = -pi;
                    final double endAngle = 0;
                    final double angle = startAngle +
                        (endAngle - startAngle) /
                            (_items.length - 1) *
                            index;

                    // Animate position from centre outward
                    final double x = radius *
                        cos(angle) *
                        _controller.value;
                    final double y = radius *
                        sin(angle) *
                        _controller.value;

                    return Transform.translate(
                      offset: Offset(x, y),
                      child: Opacity(
                        opacity: _controller.value,
                        child: GestureDetector(
                          onTap: () => _onItemTapped(item['label']),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Menu item circle button
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: item['color'],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (item['color'] as Color)
                                          .withOpacity(0.4),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  item['icon'] as IconData,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Label under each item
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1a1a2e),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item['label'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  // Centre FAB button
                  GestureDetector(
                    onTap: _toggle,
                    child: AnimatedContainer(
                      // PROPERTY 3: animating the toggle button colour
                      // when open it turns darker to show it is active.
                      duration: const Duration(milliseconds: 300),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _isOpen
                            ? const Color(0xFFc73652)
                            : const Color(0xFFe94560),
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedRotation(
                        // PROPERTY 3: toggleButtonRotation
                        // The + icon rotates 45 degrees into an X
                        // when the menu opens so the user knows
                        // tapping it again will close the menu.
                        turns: _isOpen ? 0.125 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
          // ═══════════════════════════════════════════

        ],
      ),
    );
  }
}
