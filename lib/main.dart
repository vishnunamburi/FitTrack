
import 'package:flutter/material.dart';

void main() {
  runApp(const FitTrackApp());
}

const Color bg = Color(0xFF10130F);
const Color card = Color(0xFF1C211B);
const Color lime = Color(0xFFC4F16A);
const Color muted = Color(0xFF858B80);

class FitTrackApp extends StatelessWidget {
  const FitTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: lime,
          surface: card,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class Workout {
  final String name;
  final String duration;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> exercises;

  const Workout({
    required this.name,
    required this.duration,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.exercises,
  });
}

const List<Workout> workouts = [
  Workout(
    name: 'Strength Training',
    duration: '45 min',
    subtitle: 'Full body',
    icon: Icons.fitness_center,
    color: lime,
    exercises: [
      'Push Ups - 3 × 15',
      'Squats - 3 × 15',
      'Dumbbell Press - 3 × 12',
      'Shoulder Press - 3 × 12',
      'Dumbbell Rows - 3 × 12',
      'Plank - 3 × 45 sec',
    ],
  ),
  Workout(
    name: 'Cardio & Running',
    duration: '30 min',
    subtitle: 'Endurance',
    icon: Icons.directions_run,
    color: Colors.orange,
    exercises: [
      'Jumping Jacks - 3 × 30',
      'Jogging - 10 min',
      'High Knees - 3 × 30 sec',
      'Mountain Climbers - 3 × 20',
      'Burpees - 3 × 10',
    ],
  ),
  Workout(
    name: 'Boxing',
    duration: '25 min',
    subtitle: 'Conditioning',
    icon: Icons.sports_mma,
    color: Colors.redAccent,
    exercises: [
      'Warm Up - 5 min',
      'Jab Practice - 3 rounds',
      'Cross Punch - 3 rounds',
      'Hook Practice - 3 rounds',
      'Shadow Boxing - 5 min',
    ],
  ),
  Workout(
    name: 'Core & Abs',
    duration: '20 min',
    subtitle: 'Core strength',
    icon: Icons.accessibility_new,
    color: Colors.cyan,
    exercises: [
      'Plank - 3 × 45 sec',
      'Crunches - 3 × 20',
      'Leg Raises - 3 × 12',
      'Bicycle Crunches - 3 × 20',
      'Russian Twists - 3 × 20',
    ],
  ),
  Workout(
    name: 'Calisthenics',
    duration: '35 min',
    subtitle: 'Bodyweight',
    icon: Icons.sports_gymnastics,
    color: Colors.purpleAccent,
    exercises: [
      'Pull Ups - 3 × 8',
      'Push Ups - 3 × 15',
      'Dips - 3 × 10',
      'Bodyweight Squats - 3 × 20',
      'Plank - 3 × 45 sec',
    ],
  ),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;
  final Set<String> completed = {};

  void openWorkout(Workout workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutDetailScreen(
          workout: workout,
          onComplete: () {
            setState(() {
              completed.add(workout.name);
            });
          },
          isCompleted: completed.contains(workout.name),
        ),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onWorkoutTap: openWorkout),
      WorkoutPage(
        onWorkoutTap: openWorkout,
        completed: completed,
      ),
      ActivityPage(completed: completed),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: pages[selectedTab],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: card,
        indicatorColor: lime.withOpacity(0.2),
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: lime),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            selectedIcon: Icon(Icons.fitness_center, color: lime),
            label: 'Workout',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            selectedIcon: Icon(Icons.bar_chart, color: lime),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: lime),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(Workout) onWorkoutTap;

  const HomePage({super.key, required this.onWorkoutTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'FITTRACK',
          style: TextStyle(
            color: lime,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Hello, Champion! 👋',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Ready to become stronger today?',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TODAY\'S PROGRESS',
                  style: TextStyle(color: lime, letterSpacing: 2)),
              SizedBox(height: 15),
              Text('Stay consistent.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Stat(value: '450', label: 'Calories'),
                  _Stat(value: '45', label: 'Minutes'),
                  _Stat(value: '3', label: 'Workouts'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text('Recommended Workouts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ...workouts.map(
          (w) => WorkoutTile(
            workout: w,
            onTap: () => onWorkoutTap(w),
          ),
        ),
      ],
    );
  }
}

class WorkoutPage extends StatelessWidget {
  final Function(Workout) onWorkoutTap;
  final Set<String> completed;

  const WorkoutPage({
    super.key,
    required this.onWorkoutTap,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text('Workout',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Train hard. Get stronger.',
            style: TextStyle(color: muted)),
        const SizedBox(height: 30),
        const Text(
          'YOUR TRAINING PLANS',
          style: TextStyle(
            color: lime,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...workouts.map(
          (w) => WorkoutTile(
            workout: w,
            onTap: () => onWorkoutTap(w),
            isCompleted: completed.contains(w.name),
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Weekly goal',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              LinearProgressIndicator(
                value: completed.length / 5,
                backgroundColor: Colors.grey.shade800,
                color: lime,
                minHeight: 8,
              ),
              const SizedBox(height: 12),
              Text('${completed.length} of 5 workouts completed',
                  style: const TextStyle(color: muted)),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;
  final bool isCompleted;

  const WorkoutTile({
    super.key,
    required this.workout,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: workout.color.withOpacity(0.15),
                  child: Icon(workout.icon, color: workout.color),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${workout.duration} • ${workout.subtitle}',
                        style: const TextStyle(color: muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  const Icon(Icons.check_circle, color: lime)
                else
                  const Icon(Icons.chevron_right, color: muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailScreen extends StatefulWidget {
  final Workout workout;
  final VoidCallback onComplete;
  final bool isCompleted;

  const WorkoutDetailScreen({
    super.key,
    required this.workout,
    required this.onComplete,
    required this.isCompleted,
  });

  @override
  State<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final Set<int> checkedExercises = {};

  @override
  Widget build(BuildContext context) {
    final workout = widget.workout;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: Text(workout.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Icon(workout.icon, size: 65, color: workout.color),
                const SizedBox(height: 15),
                Text(workout.name,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${workout.duration} • ${workout.subtitle}',
                    style: const TextStyle(color: muted)),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text('Your Exercises',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(workout.exercises.length, (index) {
            final done = checkedExercises.contains(index);

            return CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              tileColor: card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              value: done,
              activeColor: lime,
              checkColor: bg,
              title: Text(
                workout.exercises[index],
                style: TextStyle(
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? muted : Colors.white,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    checkedExercises.add(index);
                  } else {
                    checkedExercises.remove(index);
                  }
                });
              },
            );
          }),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: checkedExercises.length / workout.exercises.length,
            color: lime,
            backgroundColor: card,
          ),
          const SizedBox(height: 10),
          Text(
            '${checkedExercises.length} / ${workout.exercises.length} exercises completed',
            style: const TextStyle(color: muted),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: lime,
              foregroundColor: bg,
              padding: const EdgeInsets.all(17),
            ),
            onPressed: checkedExercises.length == workout.exercises.length
                ? () {
                    widget.onComplete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Workout completed! Great job! 🔥'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Complete Workout',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class ActivityPage extends StatelessWidget {
  final Set<String> completed;

  const ActivityPage({super.key, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Your fitness journey at a glance',
              style: TextStyle(color: muted)),
          const SizedBox(height: 25),
          _StatCard(
            title: 'Completed Workouts',
            value: '${completed.length}',
            icon: Icons.fitness_center,
          ),
          _StatCard(
            title: 'Weekly Goal',
            value: '${completed.length}/5',
            icon: Icons.flag,
          ),
          _StatCard(
            title: 'Consistency',
            value: completed.isEmpty ? 'Start today!' : 'Keep going!',
            icon: Icons.trending_up,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: lime, size: 30),
          const SizedBox(width: 18),
          Expanded(child: Text(title)),
          Text(value,
              style: const TextStyle(
                  color: lime, fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text('Profile',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        const Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: lime,
            child: Icon(Icons.person, size: 55, color: bg),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text('Fitness Champion',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ),
        const Center(
          child: Text('Your journey starts here',
              style: TextStyle(color: muted)),
        ),
        const SizedBox(height: 30),
        const _ProfileItem(icon: Icons.person_outline, title: 'Personal Details'),
        const _ProfileItem(icon: Icons.flag_outlined, title: 'Fitness Goals'),
        const _ProfileItem(icon: Icons.notifications_outlined, title: 'Notifications'),
        const _ProfileItem(icon: Icons.settings_outlined, title: 'Settings'),
        const _ProfileItem(icon: Icons.info_outline, title: 'About FitTrack'),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: lime),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: muted),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: lime, fontSize: 23, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: muted)),
      ],
    );
  }
}
