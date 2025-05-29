Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56444C5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 04:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D5B835EA;
	Thu, 29 May 2025 06:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9VJeIwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805CB835B9; Thu, 29 May 2025 06:05:41 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B918354B
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 06:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so458973b3a.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748491537; x=1749096337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbQ0JgyWeTa8yr1I6otTZhj93ooreegHVhFql5kSI3c=;
 b=f9VJeIwgrIY9GRL8BUQMZe2JLB8yDc50osmGfDkhuNq6dzAN26LfZzOTEaZ8WxYLVz
 irveyYrRfxqLKP36OczPCKg4VLvY/l8fsQ/MlB4w7jT3IbiYmGoJFddsRdquULE/Qv4E
 QsxtAqwBGBvQ1ArSq9veBBjClTFTwx7OIkfWsbYwNtcZN8MLpOWDZlfzakbUYhctzLH3
 fK8nbd2OMnm56a5H7DuIJjUNwUOwsfIArha/mrVYXe/nnVcMlQ6NnPIEWWtj7mGlRUmw
 21vPZNyB6rgGNRgqxE3iw7bMMr+O76ZCo/lw83bXmWrTozemt7c6WSb17N31S/C8aMbH
 Zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748491537; x=1749096337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PbQ0JgyWeTa8yr1I6otTZhj93ooreegHVhFql5kSI3c=;
 b=PMbW/2YdETKM8S6PEIPNLGFqva8pH8zEvwBAl9CPZrarhyAykp2kobnEHkDK6zqOWJ
 co5IlXihYnHqGRp+bbmcq/YFXkwd1ss612z7OFBZHn9QtmsT9xIhLZOjK7s6EJoJpukU
 ORbdC8ZqohXrL42UK/Fa5+QORiwA+1lc89uLqzQXEqb0VivwJW2+CU8VEqljQLPScIEz
 zbVe65KQA+0DH8zQQy4P75jO/gk2SspWJ5SiAXAborj6Tjy/35NQn3X/nAGBKDgCtFPI
 mxj1hLkTJhr3ZhWAjEasI2VL2WlCKY7KhP7kB1YhB0N0Afj58JylfPcgOX/8qiL82jUV
 1ZHQ==
X-Gm-Message-State: AOJu0Yzqnv5n6/IgHLmZaWP/toEtFUOrRfYvYnaCxFM/eiJsRu15FYgP
 svQLQFeDWpSBs5hMtp32TRQ2ty3sWQokiCXu9eUt+wJ6VIrk4P0/Xe6xztpQJNNk
X-Gm-Gg: ASbGncv4taKiPo0XHJiHFeArEg8a86CZ5YoQOQn+wktPO8zHJE1YeEiehcrbmSQ0LTE
 byFuDm7HL2UDZp/F7DO1utBksfoIguOrPALWOGQYl7Xx3rlJ5v0r3JzqzJVlyT4wJ+WQMLdovxw
 RUVh9LfQJTb21zCZkyX3G/1+K2o9Sm0eEqVhjhSQSHsY8RBMhcKzvOplR72cSh8fer2xjHChUO5
 UCDe8UbqYGHwTwdg5Dxcf6FBIMDaLdMddBcmajLGOc4Yv3liJIyotztuF6l/q8zuWHwRtkm/Zgn
 EGYZJOTpYTn7x0Hq3ZatxLtFeu/AhHSXX8sXbUzRZdWjB1Jn3duMzKJiSw==
X-Google-Smtp-Source: AGHT+IG1MKLcPiyo3R3Z87u7xjJGSmwzUqEmAFmiZ3EsyHas0DQ0GzWgsktq34jr5FWuLFahiyBfnA==
X-Received: by 2002:a05:6a21:4781:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-2188c28e2a4mr28392077637.21.1748491536624; 
 Wed, 28 May 2025 21:05:36 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affadf70sm408774b3a.91.2025.05.28.21.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 21:05:36 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 2/4] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Thu, 29 May 2025 12:05:18 +0800
Message-ID: <20250529040520.3799600-3-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250529040520.3799600-1-paulliu@debian.org>
References: <20250529040520.3799600-1-paulliu@debian.org>
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V3: Fix the way of installation of configuration table.
---
 include/efi_api.h          | 53 ++++++++++++++++++++++++++++++++++++++
 include/efi_loader.h       |  2 ++
 lib/efi_loader/efi_setup.c | 17 ++++++++++++
 3 files changed, 72 insertions(+)

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
 
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index a6b37d994f6..e949100593f 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -18,6 +18,15 @@
 
 efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
 
+struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
+	0,
+	0,
+	NULL
+};
+
+const efi_guid_t efi_debug_image_info_table_guid =
+	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
 /*
  * Allow unaligned memory access.
  *
@@ -280,10 +289,18 @@ efi_status_t efi_init_obj_list(void)
 
 	/* Initialize system table pointer */
 	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		efi_guid_t debug_image_info_table_guid =
+			efi_debug_image_info_table_guid;
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

