
# Circular Menu Demo

## Overview
In class demo done on 30th June,2026

This project demonstrates a custom Circular Menu built using Flutter. The application recreates a common mobile design pattern where a single action button expands into multiple related actions arranged in a semi-circle.

The demo simulates a simple note editor, allowing users to quickly access actions such as adding a photo, audio recording, text, links, or tags while keeping the interface clean and uncluttered.

---

## Real-World Use Case

Many modern mobile applications provide multiple actions without overcrowding the screen. Instead of displaying several buttons at once, a Circular Menu groups related actions behind a single floating button.

Examples of applications that use similar interaction patterns include note-taking apps, productivity tools, drawing applications, and media creation apps.

---

## Widget / Concept Demonstrated

This project demonstrates the **Circular Menu** concept by combining several Flutter widgets, including:

- AnimatedBuilder
- AnimatedContainer
- AnimatedRotation
- Transform.translate
- GestureDetector
- Stack
- AnimationController

Together, these widgets create a smooth, animated expanding menu.

## How the Circular Menu Works

The circular menu is created using trigonometric functions from Dart's `dart:math` library.

Each menu item is assigned an angle between **-π and 0 radians**, allowing the buttons to be evenly distributed along a semicircle. The horizontal position of each button is calculated using the cosine function, while the vertical position is calculated using the sine function.

```dart
final double x = radius * cos(angle) * _controller.value;
final double y = radius * sin(angle) * _controller.value;
```

The `radius` determines how far each menu item is placed from the center button. The `angle` determines where the item appears along the semicircle, and `_controller.value` (which changes from 0 to 1 during the animation) gradually moves the buttons from the center to their final positions, creating a smooth expanding animation.

This approach automatically spaces the menu items evenly and makes the layout scalable if more items are added in the future.

---

## Three Demonstrated Properties

### 1. Radius

**Default value:** `110`

Controls how far each menu item expands from the center button.

- Smaller radius → buttons appear closer together.
- Larger radius → buttons spread farther apart.

---

### 2. Animation Duration

**Default value:** `400 milliseconds`

Controls the speed of the opening and closing animation.

- Short duration → faster animation.
- Long duration → slower animation.

---

### 3. AnimatedRotation.turns

**Default value:** `0.125`

Controls how much the plus icon rotates when the menu opens.

- Increasing the value rotates the icon further.
- Provides visual feedback that the menu is currently open.

---

## Screenshot

![Circular Menu Demo](assets/screenshot.png)

---

## How to Run

1. Clone this repository.

```bash
git clone https://github.com/ndunge-mbithi/circular-menu-demo.git
```

2. Navigate into the project.

```bash
cd circular-menu-demo
```

3. Install dependencies.

```bash
flutter pub get
```

4. Run the application.

```bash
flutter run
```

---

## Technologies Used

- Flutter
- Dart
- Material Design
- AnimationController
- AnimatedBuilder
- AnimatedContainer
- AnimatedRotation
- GestureDetector

---
SCREENSHOT OF DEMO

<img width="356" height="733" alt="Screenshot 2026-06-30 at 9 24 55 am" src="https://github.com/user-attachments/assets/9faf8627-0d6d-4acc-9fe5-9ead262fe8f9" />

## Author
Ndunge Mutheu Mbithi
