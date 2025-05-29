Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12564C5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 04:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D815836A9;
	Thu, 29 May 2025 06:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B/49Ka93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B078365E; Thu, 29 May 2025 06:05:47 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D128835A5
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 06:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2347b7d6aeeso6636525ad.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748491543; x=1749096343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wdiZK9jFbwRUV4k4Emk7tY1Ok0I3xYosUxumMHZR1w=;
 b=B/49Ka93UX6r1PH+mCLAAl0vLhDQ6POBZhJgsT4hhPhdmEGZy2KJdvx/sZZ/q2OFD2
 en6GjqytSPssDtTgtujAJmOwtYYkMhki+S35Wuq0sfuKEDQkecoXHcOHNHQIv9dIdMfq
 rlbzrVcYb5P2AbedpWT47DXhMaoDWTHxvce6BM1T9otUULY3ds/GTNjbabk4pBbGZPWI
 FFyuWxPnIRAHMOhquR7dmyVWjPk2ia/cc3hcAM4u8IfEkPA2jPoAjQKW1/GGEPngA5sP
 gF7s5lXVmR05G7/ebE1+EEUjUC/l7GPRZeqhvBTxxpdUeW6TCafZWmn/i61fSDlS8GyQ
 fAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748491543; x=1749096343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0wdiZK9jFbwRUV4k4Emk7tY1Ok0I3xYosUxumMHZR1w=;
 b=pxbcGpYovLR+jgg1adCVSg1uHwrNLPgvl9tZ45g5Tawo62Og+1MX4KlXZ/AxS9ay6O
 uyg8NR5IGPZgUU6di97rUnpqB/8kStZpyoS3ajuxJ17CF44c0lsAwwmVakx12nJad/ug
 GIrUuVnYZzpAMpqecwXZ8i1cub4W7U+JlagSV41Nrx8Jwc3qFnIpX2tgSaUa49V4o0dR
 RZ4232N6QvQLm+UxbE+OC2+yis7lud7F/qpe26BQginRRQ15ksPtW2UfTR+frYwFecLU
 DB04KL95QLA71h/qLSuaV5EDPq6aFvryjHvRzaGHd+V6jdexnJuALfKQNzHDjncnHs3j
 aLBw==
X-Gm-Message-State: AOJu0Yy8sKZm8NBvaFfE6fbH3yyXDcF7r/OfMvnFBILCl1ZEd5ds0mfH
 WgM5kZtAOhebuvx37VXgRiO1HTQr7kO5vD2ABynXaN8fbpgim16K05UMRIXYgTmU
X-Gm-Gg: ASbGncsvoiRywQUFTw6tnpeWHZf59Hw1v0DT50RFw8GPe6wAIxeIwSxT4AElVbHa0Gg
 tTO6VQO6SXwB2vatWq8yMs7tJKo5OcBdxWbRo9+uAZpUJW9J9obmJI64kKO+ui3pdcgAMBLLutS
 c6vbWqKSVFI+qRM5CyeWFfgNC0jVK81K94YoAZdcNl2BBLrrtUvWx8CtljTZ89ihBLaBScEjFex
 MMHFofxD6KQgIQdD9fegJfPX9464T94+Dx+qqgDcad9OXnAsvomzepdT2UDF+c+ALFIFqb3yv5D
 nlxdbfpbpl/rP2D7g2orLCpKcyIABiE9d/hnGIGDV54U8RI=
X-Google-Smtp-Source: AGHT+IGhWyRyhg/0Y0hfWpXiGcKVSrw19OgvQLkwohmzM3/GpEOZCislFcRYV+3w5uGOj+i9hEtHFQ==
X-Received: by 2002:a17:902:e5cb:b0:234:c549:da10 with SMTP id
 d9443c01a7336-234c549dbedmr99337535ad.47.1748491542798; 
 Wed, 28 May 2025 21:05:42 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cd75c7sm3611195ad.113.2025.05.28.21.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 21:05:42 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Thu, 29 May 2025 12:05:20 +0800
Message-ID: <20250529040520.3799600-5-paulliu@debian.org>
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
---
 include/efi_api.h             |   2 +
 include/efi_loader.h          |   5 ++
 lib/efi_loader/efi_boottime.c | 137 ++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

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
index 16e921781e9..ebd2dab6e41 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2129,6 +2129,14 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
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
@@ -4038,6 +4049,13 @@ efi_status_t efi_initialize_system_table(void)
 	return ret;
 }
 
+/* efi_m_max_table_entries is the maximum entries allocated for
+ * the efi_m_debug_info_table_header.efi_debug_image_info_table.
+ */
+static u32 efi_m_max_table_entries;
+
+#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info *))
+
 /**
  * efi_initialize_system_table() - Initialize system table pointer
  *
@@ -4072,3 +4090,122 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
 	return EFI_SUCCESS;
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
+ * @return                 status code
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

