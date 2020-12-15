import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  //request for single permission
  Future<bool> requestPermission(Permission permission) async {
    PermissionStatus permissionStatus = PermissionStatus.undetermined;
    permissionStatus = await permission.request();
    if (permissionStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  //check for single permission
  Future<bool> checkForPermission(Permission permission) async {
    PermissionStatus permissionStatus = PermissionStatus.undetermined;
    if (permissionStatus.isGranted) {
      return true;
    } else {
      bool value = await requestPermission(permission);
      if (value) {
        return true;
      } else {
        return false;
      }
    }
  }

  //request for multiple permission
  Future<bool> requestForAllPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.contacts,
      Permission.storage
    ].request();
    if (statuses[Permission.location].isGranted &&
        statuses[Permission.camera].isGranted &&
        statuses[Permission.contacts].isGranted &&
        statuses[Permission.storage].isGranted) {
      return true;
    } else {
      return false;
    }
  }

  //get color according to permission status of permission
  Color getPermissionColor(PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.denied:
        return Colors.redAccent;
      case PermissionStatus.granted:
        return Colors.green;
      default:
        return Colors.grey[200];
    }
  }
}
