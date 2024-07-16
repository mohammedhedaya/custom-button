import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/core/utils/app_colors.dart';
import 'package:vendor_app/core/utils/assets.dart';
import 'package:vendor_app/modules/widgets/button_painter.dart';
import 'package:vendor_app/modules/widgets/custom_drawer.dart';
import 'package:vendor_app/modules/widgets/form_section.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final TextEditingController _titleEnController = TextEditingController();
  final TextEditingController _titleArController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionEnController =
      TextEditingController();
  final TextEditingController _descriptionArController =
      TextEditingController();

  bool _isFormValid = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
        _validateForm();
      });
    }
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _titleEnController.text.isNotEmpty &&
          _titleArController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _descriptionEnController.text.isNotEmpty &&
          _descriptionArController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _titleEnController.addListener(_validateForm);
    _titleArController.addListener(_validateForm);
    _priceController.addListener(_validateForm);
    _descriptionEnController.addListener(_validateForm);
    _descriptionArController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleArController.dispose();
    _priceController.dispose();
    _descriptionEnController.dispose();
    _descriptionArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      key: _key,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 1.sw,
        leading: Row(
          children: [
            SizedBox(width: 16.w),
            InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: SvgPicture.asset(
                Assets.imagesDrawersvg,
                width: 24.w,
                height: 24.h,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              Assets.notificationalert,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundinuploadimage,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: ElevatedButton(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: const Text(
                              "Upload Image",
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (_imageFile != null)
                          Center(
                            child: Image.file(
                              File(_imageFile!.path),
                              width: 150.w,
                              height: 150.h,
                            ),
                          ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Title · AR',
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  formSection("Title · En", "Add English title",
                      controller: _titleEnController),
                  formSection("Title · AR", "Add Arabic title",
                      controller: _titleArController),
                  Row(
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Add Price",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  formSection("Description · En", "Add English Description",
                      isTextArea: true, controller: _descriptionEnController),
                  formSection("Description · AR", "Add Arabic Description",
                      isTextArea: true, controller: _descriptionArController),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClickyButton(
                    key: UniqueKey(),
                    color: _isFormValid ? AppColors.primaryColor : Colors.grey,
                    onPressed: _isFormValid ? () {} : null,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
