Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A2C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F5882F28;
	Tue,  1 Jul 2025 05:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lJ/U+R3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9200E81FFC; Tue,  1 Jul 2025 05:49:45 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B497682B18
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso2229302f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341777; x=1751946577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq8qhX3DHW6M5vvla6f+WmXWjBI7JmQc+3n14/oflRY=;
 b=lJ/U+R3Ph3AsTe42gGDCcEchb7t7M2BxQ0aCYfBY5lmi+kNCPRCCatjrFOm2yBWPFo
 MgZlTEOpG3ma/090rmIO8dXTlvn/6B8Js3HguxchdEbN9BIu8yoNFp/MXFgbxwjOdjQM
 7Zn5isBOqLLcs17R6zpN/MOpqwYDFRQ741L1w6NSQYlZ9mV/lN1gr7W8Cuk3SXNBDrME
 r8vlttLnEoxd9eU/+FXsV42CfGbqIXTzYFVcLFQ4o5GFp1pWdlbxXTrZWBj2/SRjc3yx
 sKH0WgexfpEuIb+ES8WcB/srU/nkd1vfAfbNKXLL8h/SDjbIt3lpQLpQciZGBRmND4ni
 VsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341777; x=1751946577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iq8qhX3DHW6M5vvla6f+WmXWjBI7JmQc+3n14/oflRY=;
 b=BodLZu8CYOtBF7FrNfFnGNgXX9gvwsvighDPTDF46Rki3T+47zZ1ZmOfI6iWPH8jXi
 7/PhI3aRhjUvVs2sruVClvvPKCawXjPnEr1hpLuuj0jadQ1ChuPwKjK5rkI/yoEjqPRh
 MoVHhuXIBgA9w28ynScs4shv1nkeL7yd45c42GlWWsI1ncrW5dBFfVH4dnTSJ0163Ep0
 1oImdETLJuUARSr886Ouf5mmTtuXEbmG1/WkUscVTNANk+p3tQrS2cvDQUuE/ksR0Mzv
 Rh3CzeMPeT5WeKnJxWRzYA8tslzVcPqlFfQEC90Nn+EGwWQl13X7uhE9RNgNsiRmS8cq
 RycQ==
X-Gm-Message-State: AOJu0YwBQqBHn9SAeHcR7EBIkcNEVUBrdZZoSczqESF4O66cnvEauExY
 tjQ8hG3Ts3SmmSK9CTHWWQVQb1y3pYi57AtN59Ql2UBr8W3zcdjk6oaSf9BReIhV9/4=
X-Gm-Gg: ASbGnctrjyJOmywjEdnEcLRr65Z7/GpBakvRzTEZYAyYWiVuzCxRSliSx9huRrBncz5
 jWa/vX4MvGKeH7WwNnfYE9KK/qJBaUPCe+zVub0PWKbmtIgAuLi0iq8mLkkuF8Dx7A9YjPBhLF2
 TbJFL+bonOfQwZkUbPcDL1LVt1t9hIqV5iE4ZuFaZLKDLHd/b0nqpQEAdkRlK4TRjk42WDmrktY
 mJQ6YXBXn4Nr1BwbsLOEKfFoaktJlVftv2l5QC+0tjSV9RdoFswnKqjGVHGENx9W2NXbm2bKGGL
 47SeLafCsOqeofXMOVWVEOdVnpxwPNmJnzbxtzA+6/RUlWp6Evp5tFYS1wSJT2kx3Epit+qM
X-Google-Smtp-Source: AGHT+IFosCA6Q2ILUgWCC7zIgGj5yIT6ewJ64ms2Uhayqkn7YTgs+WPjiA9QZEYcEJ7hZDU3+0Gcrw==
X-Received: by 2002:a05:6000:490b:b0:3a5:8977:e102 with SMTP id
 ffacd0b85a97d-3a8fe4bd13amr15167275f8f.39.1751341776595; 
 Mon, 30 Jun 2025 20:49:36 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b913esm179215905e9.33.2025.06.30.20.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:36 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 2/6] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Tue,  1 Jul 2025 04:49:22 +0100
Message-Id: <20250701034926.83536-3-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701034926.83536-1-paulliu@debian.org>
References: <20250701034926.83536-1-paulliu@debian.org>
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
index c9773feaa5b..83fb3d22ad3 100644
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

