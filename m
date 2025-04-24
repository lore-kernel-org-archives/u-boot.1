Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DDC369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020FC80BA8;
	Thu, 24 Apr 2025 22:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BsLNVm0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD958056A; Thu, 24 Apr 2025 22:19:49 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AA081D5D
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so1614560b3a.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745525985; x=1746130785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqJ2/jVSMdtrxFKacJweFgaP6e++72nWfTIVTkeRVss=;
 b=BsLNVm0k7fioSNQw1PzXO+qPzNOWyvgzzYuv0gIKQOthlrUST+M/7BFnOZxYdmMMOs
 y4hI3zopBmzGJvtJfWSyKz7PF2E9YMu9Wnkk7gBchlkvIL0ef5sPqfcgUEOMzjJfqaNA
 TKssS5/wHAlTiNBILHETyk0dNv3pSDI4UqxlQ+D6KwEKUn1m5tcHPp/TYdtdvBEAyEy7
 Ul2JFCdJVVtp0X2lsesekfFJ8Q89rtIK6IBM8eYvuO6sBYi5UVMbrDa88rck1U3Vo6FF
 33XNhx37DOyy106zfjNrJS31RHYHZYdodQouXe2wjm8OsMjTCCK4VrvX8Wcn+udL8X1a
 a4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525985; x=1746130785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqJ2/jVSMdtrxFKacJweFgaP6e++72nWfTIVTkeRVss=;
 b=C3iEEeUZzKU7NmTPUEvNoepxSMdVIB38StHM5wkXYbZYSVJ/Xa3GI6dZvl8jWGns/u
 JWeQrfxJN2kR62VstVxzQPq2MyyOIw51ml6zRUANTPHtivlf0HdFaY4OPU+6w0VQnVP9
 iJyDfGOKKQ63zd/ryoEZVnH1myO5WQw8etKjISoIcxmf3qmhpuc0q29QEYZ4zqRn6a1A
 YNKaXpnOOjlTaI91IwCVzuvk1cGBYvo2NCj6/oE3zMIMO4lYu6lDU3WNgZIzyk3gE0Qf
 VUfeAy2TI8cXKQH62O6AcBrnqOUlS66/ggEnNH9DTy6PAqnfP4edTctoN2iqe1FXQ4Gj
 kXyw==
X-Gm-Message-State: AOJu0YyANYRD9qHXFFCvNbGpr5L/RCNmnXwn5y8FaI513hKTHLFWk0X/
 VBkQF1ElW3RgQu6s3FikaXaLFy2/cpseTdYm0R9aIHrROsRJeNqo1+98Mw==
X-Gm-Gg: ASbGncvQ3C/v1u1PSitswtT0sTmg/LjRHGbWq0tghZBBLaFmGV1J/DrQN8fyjsBXJ7Z
 kSni+agTnq/ZhS9O/WbYLDnif0Y3P+Xo0+uUE8BmUa1p++JcKEppbl/WVY/1odE4qRzFCJeUAS9
 Vty8QXvnt2ShlU/Z7NREIFj+ktXQ6RzPO6I6p041Gh86apn7h/OXRAlQHLQjpaEVDAZNsp7nWP6
 9d8QANfCdLF7OM7KbA3bvph21LPS4ToWMxY2ZFLr6/HD+dE9sx8A0gY/vdpzX10GxRm1goOCtfa
 QlAQUhg9ZwPOpJQmagx5v0Ak42E18jQ7FFil
X-Google-Smtp-Source: AGHT+IH7VQmjlphnbh6fJ43S1wgw2wR9eAspbVopZdyqCUEZfSxCKzhqqSC5wphulm5d0ozBPw7T7w==
X-Received: by 2002:a05:6a00:4685:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-73e30dd11cdmr1608707b3a.2.1745525984806; 
 Thu, 24 Apr 2025 13:19:44 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25a99a9esm1884419b3a.140.2025.04.24.13.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 13:19:44 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Fri, 25 Apr 2025 04:19:26 +0800
Message-ID: <20250424201927.2027257-4-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424201927.2027257-1-paulliu@debian.org>
References: <20250424201927.2027257-1-paulliu@debian.org>
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

This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
while loading the image.

This feature is described in UEFI Spec 2.10. Section 18.4.3.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
V2: use Kconfig options to turn on/off this feature.
---
 include/efi_api.h             |   2 +
 include/efi_loader.h          |   5 ++
 lib/efi_loader/efi_boottime.c | 140 ++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index 0f4245091f1..ba87af17c1f 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -571,6 +571,8 @@ struct efi_loaded_image {
 #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
 #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
 
+#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
+
 struct efi_debug_image_info_normal {
 	u32 image_info_type;
 	struct efi_loaded_image *loaded_image_protocol_instance;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 370bc042f70..babe23a8a83 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -617,6 +617,11 @@ efi_status_t efi_root_node_register(void);
 efi_status_t efi_initialize_system_table(void);
 /* Called by bootefi to initialize debug */
 efi_status_t efi_initialize_system_table_pointer(void);
+/* Called by efi_load_image for register debug info */
+void efi_core_new_debug_image_info_entry(u32 image_info_type,
+					 struct efi_loaded_image *loaded_image,
+					 efi_handle_t image_handle);
+void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
 /* efi_runtime_detach() - detach unimplemented runtime functions */
 void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index e2665459e44..0d4df5ee6ae 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2130,6 +2130,14 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		*image_handle = NULL;
 		free(info);
 	}
+
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		if (*image_handle) {
+			efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
+							    info,
+							    *image_handle);
+		}
+	}
 error:
 	return EFI_EXIT(ret);
 }
@@ -3359,6 +3367,9 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		efi_core_remove_debug_image_info_entry(image_handle);
+	}
 	switch (efiobj->type) {
 	case EFI_OBJECT_TYPE_STARTED_IMAGE:
 		/* Call the unload function */
@@ -4045,6 +4056,10 @@ efi_m_debug_info_table_header = {
 	NULL
 };
 
+static u32 efi_m_max_table_entries;
+
+#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))
+
 const efi_guid_t efi_debug_image_info_table_guid =
 	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
 
@@ -4095,3 +4110,128 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
 	return ret;
 }
+
+/**
+ * Add a new efi_loaded_image structure to the efi_debug_image_info Table.
+ * Re-Allocates the table if it's not large enough to accomidate another
+ * entry.
+ *
+ * @param image_info_type  type of debug image information
+ * @param loaded_image     pointer to the loaded image protocol for the image
+ *                         being loaded
+ * @param image_handle     image handle for the image being loaded
+ **/
+void efi_core_new_debug_image_info_entry(u32 image_info_type,
+					 struct efi_loaded_image *loaded_image,
+					 efi_handle_t image_handle)
+{
+	union efi_debug_image_info *table;
+	union efi_debug_image_info *new_table;
+	u32 index;
+	u32 table_size;
+
+	/* Set the flag indicating that we're in the process of updating
+	 * the table.
+	 */
+	efi_m_debug_info_table_header.update_status |=
+		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+
+	table = efi_m_debug_info_table_header.efi_debug_image_info_table;
+
+	if (efi_m_debug_info_table_header.table_size < efi_m_max_table_entries) {
+		/* We still have empty entries in the Table, find the first
+		 * empty entry.
+		 */
+		index = 0;
+		while (table[index].normal_image)
+			index++;
+	} else {
+		/* table is full, re-allocate another page for a larger
+		 * table.
+		 */
+		table_size = efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
+		efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
+				  table_size + EFI_PAGE_SIZE,
+				  (void **)&new_table);
+
+		if (!new_table) {
+			efi_m_debug_info_table_header.update_status &=
+				~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+			return;
+		}
+
+		memset(new_table, 0, table_size + EFI_PAGE_SIZE);
+
+		/* Copy the old table into the new one. */
+		memcpy(new_table, table, table_size);
+		/* Free the old table. */
+		efi_free_pool(table);
+		/* Update the table header. */
+		table = new_table;
+		efi_m_debug_info_table_header.efi_debug_image_info_table =
+			new_table;
+
+		/* Enlarge the max table entries and set the first empty
+		 * entry index to be the original max table entries.
+		 */
+		index = efi_m_max_table_entries;
+		efi_m_max_table_entries +=
+			EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
+	}
+
+	/* Allocate data for new entry. */
+	efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
+			  sizeof(struct efi_debug_image_info_normal),
+			  (void **)(&table[index].normal_image));
+	if (table[index].normal_image) {
+		/* Update the entry. */
+		table[index].normal_image->image_info_type = image_info_type;
+		table[index].normal_image->loaded_image_protocol_instance =
+			loaded_image;
+		table[index].normal_image->image_handle = image_handle;
+
+		/* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
+		 * set the efi_m_debug_info_table_header in modified status.
+		 */
+		efi_m_debug_info_table_header.table_size++;
+		efi_m_debug_info_table_header.update_status |=
+			EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
+	}
+
+	efi_m_debug_info_table_header.update_status &=
+		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+}
+
+void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle)
+{
+	union efi_debug_image_info *table;
+	u32 index;
+
+	efi_m_debug_info_table_header.update_status |=
+		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+
+	table = efi_m_debug_info_table_header.efi_debug_image_info_table;
+
+	for (index = 0; index < efi_m_max_table_entries; index++) {
+		if (table[index].normal_image &&
+		    table[index].normal_image->image_handle == image_handle) {
+			/* Found a match. Free up the record, then NULL the
+			 * pointer to indicate the slot is free.
+			 */
+			efi_free_pool(table[index].normal_image);
+			table[index].normal_image = NULL;
+
+			/* Decrease the number of EFI_DEBUG_IMAGE_INFO
+			 * elements and set the efi_m_debug_info_table_header
+			 * in modified status.
+			 */
+			efi_m_debug_info_table_header.table_size--;
+			efi_m_debug_info_table_header.update_status |=
+				EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
+			break;
+		}
+	}
+
+	efi_m_debug_info_table_header.update_status &=
+		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+}
-- 
2.39.5

