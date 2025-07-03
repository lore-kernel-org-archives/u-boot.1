Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7929AC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4261282F6A;
	Thu,  3 Jul 2025 08:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZVnANk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBF082F5D; Thu,  3 Jul 2025 08:28:23 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F7A81FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3148069f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524100; x=1752128900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRKRY4V95eMGLAjZsypH1GQbWqpKHsMXIHqIVvdpF7U=;
 b=lZVnANk7+c/g8S/Cjg8vcZinDC3+1Cct14Go23yETW/Yb4+wY3UYDeW2d6o+aqzGrk
 IjzZ/q9XTfAarxhPNUExgF+HrJ23+qTUYpAjIECG2W0U8kagNlQBuRJfrfVSnizsKDEh
 1AguDR4dJqP1oEzFDs0KJNEuUFJpy+BcQB7NXBu1Jq1o2FAeYkMXEcaefw8O3MmR2PQ7
 4tLF8XXwCyamjw4+aMUNgOpYa4hm89Buj14lJAZW5T519NyD0HjtClxNihyCTHDeKvtY
 ojkKsv4Xr+VIMgoQBjPhkAUIVfGQdE2PlKciaXu0HOWhTg+r7cIvSRsYxuTAkHSL8vJX
 DJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524100; x=1752128900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BRKRY4V95eMGLAjZsypH1GQbWqpKHsMXIHqIVvdpF7U=;
 b=V+drtEULzGffr/NuY+O2oyQWy1mOlXpmIBlk+SR+ImVf0BSfpHe2naDeJiZXyJtkue
 pHnOqms6JjdkNthuPqQ/ViHoeMiMlxvo+67Wr1hs+n6uEImOcRvhcVGZ6e1jhYulFmPt
 uSYazrpDISuYysRALttaJW1YSixvc+7dNLY0NPAhKjMTE9KxbImEH7oUHK3A2at/oi8/
 tQsYl7Vo5sunfZK1gslldVSYHf2N46yG8pZm6uS0T01HEGVBeg4nHV3GBOQyvDQQwhWH
 K6ztc/9469Efw6WmI8gD/mR6p6x/DAv41JcxIPp+i/a3fu6/oAJb0ia+A/HiYFhZ2GtJ
 dBtg==
X-Gm-Message-State: AOJu0Yzt2NwYIBNJ+3MFn0v7pE3k7NY8tFQmv9a5YhXg1RS7hxh2MIWc
 HY9FeByJR1OQV+0/8CpPj69LF8tL/yNSs2VbLnodNhaSflqqRGp9e6jjUjd5vDLg8GI=
X-Gm-Gg: ASbGncuV7AfvLxkZlzYmv5YoS0Rom02ui/581bVyIalI03kIoyzcbcIQu5qnTBEH3KF
 Wn5x9lEsOgOV2NPosu8B301hUH/tQWva1SYmSpC5d6lBD9/1/XGOH0x4Hi7d7iwTdbGr13rWGM8
 pHx9INedJpQ706qg+vBq7S8tA9HDffxVFs6ULbJN/JErymstKHW06es6iSV4ZXqDAEyo7O754+b
 SwNwSNbds/5oJ8lzJOnNWSoT8sR3+8d+WDCAMdyjggMw9M/VQusX17uNIW6iAwVPK7aBag598Ya
 HQY6kmBdCMg2+mf/wrZ/AwL5ha3Bb6983mAN2EzyQE3pexK8TjfOJ/qS0qLwDA==
X-Google-Smtp-Source: AGHT+IHFnRTzwYBLal6Nwm9MnOPNCGw18SVu3eFMO4IPp3CsSunKaitzalAA0nmJ3ZX9vNvkY/vDNw==
X-Received: by 2002:a5d:5f90:0:b0:3b3:59c3:483d with SMTP id
 ffacd0b85a97d-3b359c34b1emr908761f8f.14.1751524100256; 
 Wed, 02 Jul 2025 23:28:20 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969409sm17005825e9.4.2025.07.02.23.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:19 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 2/5] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Thu,  3 Jul 2025 07:28:08 +0100
Message-Id: <20250703062811.72871-3-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703062811.72871-1-paulliu@debian.org>
References: <20250703062811.72871-1-paulliu@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.

This feature is described in UEFI Spec version 2.10. Section 18.4.
The implementation ensures support for hardware-assisted debugging and
provides a standardized mechanism for debuggers to discover and interact
with system-level debug resources.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V3: Fix the way of installation of configuration table.
V5: move the code into a separate module.
V7: Fix some syntax warnings.
---
 include/efi_api.h                  | 53 ++++++++++++++++++++++++++++++
 include/efi_loader.h               |  2 ++
 lib/efi_loader/efi_debug_support.c |  6 ++++
 lib/efi_loader/efi_setup.c         | 11 +++++++
 4 files changed, 72 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index 6c4c1a0cc7b..8da0a350ce3 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -238,6 +238,10 @@ enum efi_reset_type {
 	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
 		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
 
+#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
+	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
+		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
+
 struct efi_conformance_profiles_table {
 	u16 version;
 	u16 number_of_profiles;
@@ -574,6 +578,55 @@ struct efi_loaded_image {
 	efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
 };
 
+#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
+#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
+
+/**
+ * struct efi_debug_image_info_normal - Store Debug Information for normal
+ * image.
+ * @image_info_type: the type of image info.
+ * @loaded_image_protocol_instance: the pointer to struct efi_loaded_image.
+ * @image_handle: the EFI handle of the image.
+ *
+ * This struct is created by efi_load_image() and store the information
+ * for debugging an normal image.
+ */
+struct efi_debug_image_info_normal {
+	u32 image_info_type;
+	struct efi_loaded_image *loaded_image_protocol_instance;
+	efi_handle_t image_handle;
+};
+
+/**
+ * union efi_debug_image_info - The union to store a pointer for EFI
+ * DEBUG IMAGE INFO.
+ * @image_info_type: the type of the image_info if it is not a normal image.
+ * @normal_image: The pointer to a normal image.
+ *
+ * This union is for a pointer that can point to the struct of normal_image.
+ * Or it points to an image_info_type.
+ */
+union efi_debug_image_info {
+	u32 *image_info_type;
+	struct efi_debug_image_info_normal *normal_image;
+};
+
+/**
+ * struct efi_debug_image_info_table_header - store the array of
+ * struct efi_debug_image_info.
+ * @update_status: Status to notify this struct is ready to use or not.
+ * @table_size: The number of elements of efi_debug_image_info_table.
+ * @efi_debug_image_info_table: The array of efi_debug_image_info.
+ *
+ * This struct stores the array of efi_debug_image_info. The
+ * number of elements is table_size.
+ */
+struct efi_debug_image_info_table_header {
+	volatile u32 update_status;
+	u32 table_size;
+	union efi_debug_image_info *efi_debug_image_info_table;
+};
+
 #define EFI_DEVICE_PATH_PROTOCOL_GUID \
 	EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
 		 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 8f065244d8e..d0c72d0bc58 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -315,6 +315,8 @@ extern const struct efi_hii_config_routing_protocol efi_hii_config_routing;
 extern const struct efi_hii_config_access_protocol efi_hii_config_access;
 extern const struct efi_hii_database_protocol efi_hii_database;
 extern const struct efi_hii_string_protocol efi_hii_string;
+/* structure for EFI_DEBUG_SUPPORT_PROTOCOL */
+extern struct efi_debug_image_info_table_header efi_m_debug_info_table_header;
 
 uint16_t *efi_dp_str(struct efi_device_path *dp);
 
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index 7dc5fa93af9..5401488602e 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -11,6 +11,12 @@
 
 struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
 
+struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
+	0,
+	0,
+	NULL
+};
+
 /**
  * efi_initialize_system_table_pointer() - Initialize system table pointer
  *
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 78c5059256a..f06cf49e443 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -18,6 +18,9 @@
 
 efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
 
+const efi_guid_t efi_debug_image_info_table_guid =
+	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
 /*
  * Allow unaligned memory access.
  *
@@ -280,9 +283,17 @@ efi_status_t efi_init_obj_list(void)
 
 	/* Initialize system table pointer */
 	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
+		efi_guid_t debug_image_info_table_guid =
+			efi_debug_image_info_table_guid;
+
 		ret = efi_initialize_system_table_pointer();
 		if (ret != EFI_SUCCESS)
 			goto out;
+
+		ret = efi_install_configuration_table(&debug_image_info_table_guid,
+						      &efi_m_debug_info_table_header);
+		if (ret != EFI_SUCCESS)
+			goto out;
 	}
 
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
-- 
2.39.5

