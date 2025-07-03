Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07377C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45103822D7;
	Thu,  3 Jul 2025 08:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSUaA2bJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230BE82CFA; Thu,  3 Jul 2025 08:28:27 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5A482F8C
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso5383094f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524103; x=1752128903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfQA27niFnbNsMzMEmDrYf0CSZJMQfvSx7D64Z0wcmI=;
 b=QSUaA2bJGBHhvm9QDUj0W8KO83y1wBtJH2j9XT2UJpR7ib6sIhBzr8Cq4KsOIUvdjH
 +BDa125abdgll2g0b6Wrce7kFwpK50nwGi42WJ7TToo8zUS/9C5uyx+0fKBvyT3+/MpB
 MlFPQ3OeOFObaJuAtr8ogUqFdvbBCUkFPV8XZxhaTy8vTDnKS0L+ZKV1PoG06qlypYQN
 o3Vcc9jzRLOfLswHy6Z9awIyskwy13c0YUIJ1FeBRvihnIkmazygRp2R6cMsuHfXmquZ
 LLMlyJWQB8t3sAYda2aqty2GAFlKlJEOg20JdVsjH7u89BmZkiLMOtugzhS8FEQbmyYz
 64qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524103; x=1752128903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zfQA27niFnbNsMzMEmDrYf0CSZJMQfvSx7D64Z0wcmI=;
 b=jXZV6erUaqkQLJRqooiVQhzgi/O62f3Cj3y8s7qBc3taEXvO0OaBrslepGbJY+jv7x
 JC/jq9wiXmZb1jIfPA/jYIfNIUmRI1k0t2KnRIbFJF/iKtAcrP35kTs1+0eS6FAPkobC
 b5idxyB5QbKk65PJpmTLJm0iPDQW+rI5LxA8ZxtG/QZieXrwdQDve8Pv989oYovuL22z
 V6Zy2kVr6qDQVbfcfMsy8PmvWthN5tXaAXCtkOh0NxmXxUKMEJSsmdEoIzzQpjanx+Am
 7kdNIqENVEJy475AWF5WFFFwbunSYwS8Alvrzry4rynLtZxZxZZDajs8je0Mu5HDNVlK
 gCQw==
X-Gm-Message-State: AOJu0YyCFrLzm9o3IJLvAnYJu+G08UdJGZdwVOMNuYGYrW7UIKsjhIZU
 RIM4/jaShHNv40lFEr38Z/gjm8tvf5dTaXJWOfXZmfud4hqsBuPwRctYxiFE6USBToY=
X-Gm-Gg: ASbGncuwwmeENvf4Clv3Yz/96o0rEIeTgE3Z7VBhD7zrdgtZhOesmD7I9wF6ezzWvBt
 VdNDg1y3AegNnc59G9wBStt9TirAgEptJ1pV0D8LScJvuz3tvWKMOWPOMhn3pS13JkMN99Qsf76
 kYZIOrMklnICr373lAdwSm+uXZoThyYLV2PudMC0NCy1osr6W3/krV5AGp7iXVT5o5KcWXf8jaK
 B3bZcAnqixo8E6JxrL44ofcvHXMbe8ev/5ZsuYMgB5etkLrq3zx0wv+NPn/kMususYwOdptglgo
 epN815Gd3BP9Sg72yYDGHa1liZPbH6Ny6I5nC9AH/pYpCp16OlGWHEkAl7XRag==
X-Google-Smtp-Source: AGHT+IEAZF+UpY4QziT7qYjTBqRAignGwwLmDcBWh2537uhEeh2oYfiFSmIdGLe5H/MK0RTGynTcvg==
X-Received: by 2002:adf:e195:0:b0:3a4:fc07:f453 with SMTP id
 ffacd0b85a97d-3b1fdc20bfamr4051767f8f.8.1751524103216; 
 Wed, 02 Jul 2025 23:28:23 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac48esm16759775e9.37.2025.07.02.23.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:22 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 4/5] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Thu,  3 Jul 2025 07:28:10 +0100
Message-Id: <20250703062811.72871-5-paulliu@debian.org>
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

This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
while loading the image.

This feature is described in UEFI Spec 2.10. Section 18.4.3.
The implementation ensures support for hardware-assisted debugging and
provides a standardized mechanism for debuggers to discover the load
address of an EFI application.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: use Kconfig options to turn on/off this feature.
V3: Use efi_realloc to realloc the tables. Move tables to boot time.
V4: Use new efi_realloc().
V5: Fix function comments and move the code into a separate module.
V6: refine the code. Handling the error of efi_allocate_pool.
V7: Use memmove instead of memcpy. Fix syntax warnings.
---
 include/efi_api.h                  |   2 +
 include/efi_loader.h               |   5 ++
 lib/efi_loader/efi_boottime.c      |   7 ++
 lib/efi_loader/efi_debug_support.c | 137 +++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index 8da0a350ce3..77a05f752e5 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -581,6 +581,8 @@ struct efi_loaded_image {
 #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
 #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
 
+#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
+
 /**
  * struct efi_debug_image_info_normal - Store Debug Information for normal
  * image.
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 13ca2ec9a4e..22440b842e3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -650,6 +650,11 @@ efi_status_t efi_root_node_register(void);
 efi_status_t efi_initialize_system_table(void);
 /* Called by bootefi to initialize debug */
 efi_status_t efi_initialize_system_table_pointer(void);
+/* Called by efi_load_image for register debug info */
+efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
+						 struct efi_loaded_image *loaded_image,
+						 efi_handle_t image_handle);
+void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
 /* efi_runtime_detach() - detach unimplemented runtime functions */
 void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index dbebb37dc04..8c83040ac48 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2129,6 +2129,11 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		*image_handle = NULL;
 		free(info);
 	}
+
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT) && *image_handle)
+		efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
+						    info,
+						    *image_handle);
 error:
 	return EFI_EXIT(ret);
 }
@@ -3359,6 +3364,8 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT))
+		efi_core_remove_debug_image_info_entry(image_handle);
 	switch (efiobj->type) {
 	case EFI_OBJECT_TYPE_STARTED_IMAGE:
 		/* Call the unload function */
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index 5401488602e..17f506a70e7 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -17,6 +17,13 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
 	NULL
 };
 
+/* efi_m_max_table_entries is the maximum entries allocated for
+ * the efi_m_debug_info_table_header.efi_debug_image_info_table.
+ */
+static u32 efi_m_max_table_entries;
+
+#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info *))
+
 /**
  * efi_initialize_system_table_pointer() - Initialize system table pointer
  *
@@ -44,3 +51,133 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
 	return EFI_SUCCESS;
 }
+
+/**
+ * efi_core_new_debug_image_info_entry() - Add a new efi_loaded_image structure to the
+ *                                         efi_debug_image_info table.
+ *
+ * @image_info_type: type of debug image information
+ * @loaded_image:    pointer to the loaded image protocol for the image
+ *                   being loaded
+ * @image_handle:    image handle for the image being loaded
+ *
+ * Re-Allocates the table if it's not large enough to accommodate another
+ * entry.
+ *
+ * Return: status code
+ **/
+efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
+						 struct efi_loaded_image *loaded_image,
+						 efi_handle_t image_handle)
+{
+	union efi_debug_image_info **table;
+	u32 index;
+	u32 table_size;
+	efi_status_t ret;
+
+	/* Set the flag indicating that we're in the process of updating
+	 * the table.
+	 */
+	efi_m_debug_info_table_header.update_status |=
+		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+
+	table = &efi_m_debug_info_table_header.efi_debug_image_info_table;
+
+	if (efi_m_debug_info_table_header.table_size >= efi_m_max_table_entries) {
+		/* table is full, re-allocate the buffer increasing the size
+		 * by 4 KiB.
+		 */
+		table_size = efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
+
+		ret = efi_realloc((void **)table, table_size + EFI_PAGE_SIZE);
+
+		if (ret != EFI_SUCCESS) {
+			efi_m_debug_info_table_header.update_status &=
+				~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+			return ret;
+		}
+
+		/* Enlarge the max table entries and set the first empty
+		 * entry index to be the original max table entries.
+		 */
+		efi_m_max_table_entries +=
+			EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
+	}
+
+	/* We always put the next entry at the end of the currently consumed
+	 * table (i.e. first free entry)
+	 */
+	index = efi_m_debug_info_table_header.table_size;
+
+	/* Allocate data for new entry. */
+	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
+				sizeof(union efi_debug_image_info),
+				(void **)(&(*table)[index].normal_image));
+	if (ret == EFI_SUCCESS && (*table)[index].normal_image) {
+		/* Update the entry. */
+		(*table)[index].normal_image->image_info_type = image_info_type;
+		(*table)[index].normal_image->loaded_image_protocol_instance =
+			loaded_image;
+		(*table)[index].normal_image->image_handle = image_handle;
+
+		/* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
+		 * set the efi_m_debug_info_table_header in modified status.
+		 */
+		efi_m_debug_info_table_header.table_size++;
+		efi_m_debug_info_table_header.update_status |=
+			EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
+	} else {
+		log_err("Adding new efi_debug_image_info failed\n");
+		return ret;
+	}
+
+	efi_m_debug_info_table_header.update_status &=
+		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_core_remove_debug_image_info_entry() - Remove an efi_debug_image_info entry.
+ *
+ * @image_handle:    image handle for the image being removed
+ **/
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
+			/* Found a match. Free up the table entry.
+			 * Move the tail of the table one slot to the front.
+			 */
+			efi_free_pool(table[index].normal_image);
+
+			memmove(&table[index],
+				&table[index + 1],
+				(efi_m_debug_info_table_header.table_size -
+				 index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);
+
+			/* Decrease the number of EFI_DEBUG_IMAGE_INFO
+			 * elements and set the efi_m_debug_info_table_header
+			 * in modified status.
+			 */
+			efi_m_debug_info_table_header.table_size--;
+			table[efi_m_debug_info_table_header.table_size].normal_image =
+				NULL;
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

