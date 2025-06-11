Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7004FC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 05:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5098782B18;
	Wed, 11 Jun 2025 07:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOw4ApGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A7D82C30; Wed, 11 Jun 2025 07:09:15 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A89782C4C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748435ce7cdso2681825b3a.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749618541; x=1750223341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O0J5UK+vrh2GMdoew/PWnH+pTzu2PWEpzWA1bX+yns=;
 b=YOw4ApGAtOP3+mNbzBCs4pqAy/DJy2Y+iz0HIkIXESx+JfCTO6wtuJCuaaFBQLTVpO
 NTOOFGZ92DA+EeGBZZt4hfEgXXSwMyQ8aKu/srAQcY7dKPrfsVYZcOC2bJRMf1xN1WUV
 hL2e9FwjC+ojkBL8Gmq9r7//rNhRopYxXHf77XhgDoq2UtIZMbC3J9ahyFsCxcDZw8LX
 Ecoem3DBLSsfzn+UYo2Ae0Gf3OYVxwT8Z0JDV6cve1rahc4acY53kzLhRbhoH3njQW5f
 8bO1L71NRAyyrxmFOF+u3plePpr1ayZvT2NKtPfL9Rx7ZBHLuhfS+c3/3ViZnSIRoC3Y
 JcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749618541; x=1750223341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/O0J5UK+vrh2GMdoew/PWnH+pTzu2PWEpzWA1bX+yns=;
 b=mQ+oN8kifxOEyHaDVYJF8Z2iRTcbSqdfO3dhKyJGTONagY+CfitvVYQ+4Dk5AZogrt
 s3POQKCfRpHyIapRf0ZLYIHZNMM2UVyQ+zxvWrxPvWHnc5OeK68duqdbVvC/E289hsDy
 4vCnsM+UDrCgT3x5ns2dTjijwhOOb6C/y5TBG1VHEU+47Dp1v17Ea1R4p4aXQXAanjTD
 6qpHejbe8ZwgqEz2WAub/AgxTIOrf5R30aqcOtChgq0PV/i3y9EUZ7HPj7NVLnIuZU40
 1QbiC3i/moj56lSGRdsP6NA4BxFs9dGWhc/gtn9bkXl6JobkbVM4eMjKS7wK1FaExIpr
 tkgg==
X-Gm-Message-State: AOJu0Yz8Z/hU7nbqfqX25hnn5UNQ/B0qcVgo/2u0iLfT3G7hdTyc3aCB
 jTcLH5Lo+5FYYkkoxL04xL23ofdd8Jupov68rgpxxJ6t0r8JVI9zI89vEUYBvEwz
X-Gm-Gg: ASbGncub8lkcxGn1xK5P0xcVgBdMGJ+k4zrSoxoGmihMjg4UNlqjBMqP9RNN9/IQFj0
 N7G3HQaK5ubOsv3f9y7kM36Tt1JHit0EotGHn8KU+K5uHEZzrH2CKk3vM4i6pTRjMvERpBYgEt6
 llj94bVp+lCkFCeR29q3BMrl+0IZi9lcaNB/2Rhb6R9+PyEP9yuZ8WYJsc5z1dWPxRzHjxjUVSO
 4Ged6t+eEC2oUdzwhbQI6cnkz9U689rbOn4hgwNLR32Di+oejMV298AsShETjq4GvCYM3YY44JD
 Sb/9IEMQMeCiOWWQ9o/xGyTojFeie52reVZebA3EMvAyIA7gcrgeO1HCcc2bjGgaFcpR
X-Google-Smtp-Source: AGHT+IG2L+ob+qbSG9aC5vIt+YnHUg35kjqRhSU7IxBhTHA7dKuY0AltkkZlkHkaXwynExJNrIOgWw==
X-Received: by 2002:a05:6a00:b4d:b0:748:2d1d:f7b7 with SMTP id
 d2e1a72fcca58-7486ce51b3emr2747180b3a.21.1749618540885; 
 Tue, 10 Jun 2025 22:09:00 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7482b0ec4aasm8492998b3a.171.2025.06.10.22.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 22:09:00 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Wed, 11 Jun 2025 13:08:43 +0800
Message-ID: <20250611050844.210384-5-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611050844.210384-1-paulliu@debian.org>
References: <20250611050844.210384-1-paulliu@debian.org>
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: use Kconfig options to turn on/off this feature.
V3: Use efi_realloc to realloc the tables. Move tables to boot time.
V4: Use new efi_realloc().
V5: Fix function comments and move the code into a separate module.
---
 include/efi_api.h                  |   2 +
 include/efi_loader.h               |   5 ++
 lib/efi_loader/efi_boottime.c      |  11 +++
 lib/efi_loader/efi_debug_support.c | 129 +++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)

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
index dbebb37dc04..40495c98c18 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2129,6 +2129,14 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		*image_handle = NULL;
 		free(info);
 	}
+
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
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
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
+		efi_core_remove_debug_image_info_entry(image_handle);
+	}
 	switch (efiobj->type) {
 	case EFI_OBJECT_TYPE_STARTED_IMAGE:
 		/* Call the unload function */
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index a6a672bc0e4..468e9e1cc83 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -16,6 +16,13 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
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
@@ -50,3 +57,125 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
 	return EFI_SUCCESS;
 }
+
+/**
+ * efi_core_new_debug_image_info_entry() - Add a new efi_loaded_image structure to the
+ *                                         efi_debug_image_info Table.
+ *
+ * @image_info_type: type of debug image information
+ * @loaded_image:    pointer to the loaded image protocol for the image
+ *                   being loaded
+ * @image_handle:    image handle for the image being loaded
+ *
+ * Re-Allocates the table if it's not large enough to accomidate another
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
+	efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
+			  sizeof(union efi_debug_image_info),
+			  (void **)(&(*table)[index].normal_image));
+	if ((*table)[index].normal_image) {
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
+	}
+
+	efi_m_debug_info_table_header.update_status &=
+		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+
+	return EFI_SUCCESS;
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
+			/* Found a match. Free up the table entry.
+			 * Move the tail of the table one slot to the front.
+			 */
+			efi_free_pool(table[index].normal_image);
+
+			memcpy(&table[index],
+			       &table[index + 1],
+			       (efi_m_debug_info_table_header.table_size -
+				index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);
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

