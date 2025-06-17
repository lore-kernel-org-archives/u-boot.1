Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E450C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E95382BCD;
	Tue, 17 Jun 2025 14:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyLR4Db3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E79782CD5; Tue, 17 Jun 2025 14:09:12 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8B382CD5
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4756905f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750162148; x=1750766948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEIylWC0yYo4Uc3r0VmWEnNvVTsw05DlqRlvmiQKcAA=;
 b=lyLR4Db3VeiVSNG0mMHRh3vyQnXLzJnLXNy9KzpR7FiLJ1xRgwyIN6Kv73KVzzgJAk
 fnPt7ZXDmZoh0aFM1T1J7RSYpuBTXCz338vowfOCsqgBe4qcvYtK1wt/xDjkxupC5r8+
 uqjX7uYw/FjLGWUVDdmCWSp28t0CFUq58JDdsWbzx57xJRxBjL96neb3R8lcUZUpIVR/
 UfbNl1rx9RWLhSTQ1RYDRF7iPksoqGBW9e3RWu4JjURB6LNjVO8WI29TGGRlSwnZIDx0
 5z6Ny1QOUMexqgZdRVpRbnOMWLORW9jt+wE6KtnW75UdBPj+Kdu+cQdtFp2NHmQSV7pX
 rpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162148; x=1750766948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEIylWC0yYo4Uc3r0VmWEnNvVTsw05DlqRlvmiQKcAA=;
 b=Mt+QOsiv08g8r5gaqP6SFyGCKN7n5C9+A2IJw7nw/cYGUcqnkIxxx/nbzJIAHsEJbp
 01uvpgO5HYIR6br6ByyRK20jEn6RuoHr1Iaf+IhtIBiUQUY/cjmy8wBscYdNorPxZ5g9
 9QIyoDVvO/xUmsFd/YwN43aUmTwejK8leyMJvwegpm3fGK7L50eE7m9r0FHly0ZWaGKr
 lKdNPcNmYKl6iAw/JtWM3ZqVFvLYnsHrl1fsSWDA20wbZvuWlZ3eDqg7BxwFdretuPDE
 VFk9Akpp78fav+YCFfI+dUcy4+HU1V01lCadq35/iVHPsm9XQ27dAFtvByPlnRwRZ5d8
 aq3Q==
X-Gm-Message-State: AOJu0YzJFIff7xE85arZSEaF79aw88fjNgbuFeZb/toYu7une0kEkE6D
 s0fK8UcJAKlX9kVz5dKiHMe0HCH5h2UurHwoorOOAOwiE/2L7ZShvNt8f2CmLi7vrZE=
X-Gm-Gg: ASbGncvq2zqMxVXQ1XYKL4iiqN936jJjxlmoAHqbePBWowEn5LMeNdOJ6Zn6/JwbjvD
 Sa6y/cWjS8DYzo9jow01vXQOt07buL1Uecir0heAoCXLNXZO8Vuc3uAUbW3a/3FnrkAZ5sqOjwt
 p6r+F9/pcHVjn+ONaH5cl1zqL9zxLOlF8z8sbhDaQ4NR+HnvBKoY9+mGLsqgs7AOqiIxBD4bnpf
 +s2sJGS7tzYZOdDNEmrKUiXrurN3ckGjOnaGLK0Os3XqwFru4MLTZruYYlrqIpi6rQHQduE103G
 aNO3cvN3nT0gb5NuO2DBo9BMEqma8Wd2gp/1N3BSOD9RS/AZd4LrVxxSei37YQ==
X-Google-Smtp-Source: AGHT+IFjUKR/G/hUngiX3bEYkYVlLB+oXNI/O0t2mJebKKBGHK4pwS9JgdzP3Y2BwW2vo5Y/LSNvrw==
X-Received: by 2002:a05:6000:288d:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a5723a3ad5mr11124992f8f.15.1750162148251; 
 Tue, 17 Jun 2025 05:09:08 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b7741bsm13996560f8f.98.2025.06.17.05.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:09:07 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 2/4] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Tue, 17 Jun 2025 13:08:53 +0100
Message-Id: <20250617120855.87492-3-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617120855.87492-1-paulliu@debian.org>
References: <20250617120855.87492-1-paulliu@debian.org>
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
---
 include/efi_api.h                  | 53 ++++++++++++++++++++++++++++++
 include/efi_loader.h               |  2 ++
 lib/efi_loader/efi_debug_support.c |  6 ++++
 lib/efi_loader/efi_setup.c         | 12 +++++++
 4 files changed, 73 insertions(+)

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
index 3794b31c4cd..f2dfcc5e6b2 100644
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
index 6193b9f6d0c..60f3a7e5fbf 100644
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
@@ -280,10 +283,19 @@ efi_status_t efi_init_obj_list(void)
 
 	/* Initialize system table pointer */
 	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
+		efi_guid_t debug_image_info_table_guid =
+			efi_debug_image_info_table_guid;
+
 		ret = efi_initialize_system_table_pointer();
 		if (ret != EFI_SUCCESS) {
 			goto out;
 		}
+
+		ret = efi_install_configuration_table(&debug_image_info_table_guid,
+						      &efi_m_debug_info_table_header);
+		if (ret != EFI_SUCCESS) {
+			goto out;
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
-- 
2.39.5

