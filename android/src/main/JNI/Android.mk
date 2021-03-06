LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := reanimated

PROJECT_FILES := $(wildcard $(LOCAL_PATH)/../cpp/*.cpp)
PROJECT_FILES += $(wildcard $(LOCAL_PATH)/../Common/cpp/*.cpp)
PROJECT_FILES += $(wildcard $(LOCAL_PATH)/../Common/cpp/**/*.cpp)

PROJECT_FILES := $(PROJECT_FILES:$(LOCAL_PATH)/%=%)

LOCAL_SRC_FILES := $(PROJECT_FILES)

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
	$(LOCAL_PATH)/../cpp/headers \
	$(LOCAL_PATH)/../Common/cpp/headers \
	$(LOCAL_PATH)/../Common/cpp/headers/NativeModules \
	$(LOCAL_PATH)/../Common/cpp/headers/Registries \
	$(LOCAL_PATH)/../Common/cpp/headers/SharedItems \
	$(LOCAL_PATH)/../Common/cpp/headers/SpecTools \
	$(LOCAL_PATH)/../Common/cpp/headers/Tools \
	$(HERMES_ENGINE)/android/include \

LOCAL_CFLAGS += -DONANDROID -fexceptions -frtti

LOCAL_STATIC_LIBRARIES := libjsi callinvokerholder
LOCAL_SHARED_LIBRARIES := libhermes libfolly_json libfbjni libreactnativejni

include $(BUILD_SHARED_LIBRARY)

# start | build empty library which is needed by CallInvokerHolderImpl.java
include $(CLEAR_VARS)

# Don't strip debug builds
ifeq ($(NATIVE_DEBUG), true)
    cmd-strip :=
endif

LOCAL_MODULE := turbomodulejsijni
include $(BUILD_SHARED_LIBRARY)
# end

include $(LOCAL_PATH)/react/Android.mk
