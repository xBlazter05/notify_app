import 'package:get/get.dart';
import 'package:notificaciones_unifront_app/app/data/models/notificaciones_model.dart';
import 'package:notificaciones_unifront_app/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront_app/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront_app/app/data/services/student_service.dart';
import 'package:notificaciones_unifront_app/app/routes/app_pages.dart';

class InboxLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();

  NotificacionModel? _notificacionModel;

  NotificacionModel? get notificacionModel => _notificacionModel;

  @override
  void onReady() {
    _getNotificaciones();
    super.onReady();
  }

  void _getNotificaciones() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _notificacionModel = await _dbRepository.getNotificaciones(
          token: token,
          idEstudiante: StudentService.to.estudiante.id.toString()
      );
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['notificaciones']);
  }
}