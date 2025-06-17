Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B40AC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6E482CD5;
	Tue, 17 Jun 2025 14:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LwRS3Z8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191A582BA1; Tue, 17 Jun 2025 14:09:16 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131DE82CD5
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cea01b9cso26131095e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750162152; x=1750766952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1c2pwJ2/pvZAcb35TUJkkg9SHD7IYnZRmkc2mtIWLBc=;
 b=LwRS3Z8SwsTHSlaTGSMMbv1o8PuQOIMl0GeoxyRboYPI8PH8VvQosUvzDuQnJi2niK
 O23vkCKfjjBVrRKtvTEUD+eVJkuOyjOcHzspR9O/Q+tiAvWvtl6SYhQPPMWreZ1W3rRY
 wyXr73Q9Mju4qvu9zbKeCLkzqpN3wjJaVKF6TdDNHccWV65+0x6yV84+B30Y+jtGz1m+
 R7PfLmVtVKoeS7/2FGRF1OGnsG/7wCCdz3KQImVME+w/JpHGN0pCfzLCaoLyxMPhE4xm
 esgrbQgdrCg7IBcIBbCjlmNYvpuSHdIJEfwLh/u01HYCyzvXzkjbsGTzht5EdJKGWyAF
 HpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162152; x=1750766952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1c2pwJ2/pvZAcb35TUJkkg9SHD7IYnZRmkc2mtIWLBc=;
 b=XtCBRtRtfWWXvy4FU9VJIkdqaL+8uE+DGE5UWP4cnq6YYLXeGEJTZfrkFsyht7yHGa
 qHh6SWSLgpHO07BM+z4g6fhG8TtcBjLGFAglmUorzbQFfGnWSwh5ukoInjGszLxCUWmp
 B/os8wpkdAJk3pqhHu4/YEfXsvQXO7UwBEoqP1z0WpW+e0W80afU0qrRLs8msIYLGYaI
 CYgwAH+BAG4xInZRSwIeclryggArP1uC66PxZ+z+UGmcnYdMtUY6qQEl8BPmx5YIEpfE
 LIMm4APyzZkp2YLvS8qSbz7I+5VR7oc2bwY1WwD14H2cz4fJjagG7yjywLjf5Rldj7b9
 e4VQ==
X-Gm-Message-State: AOJu0YxBPhA3mNncUgX8RSYD+IZW1KrHVOrOI+n/kwr/8S7f+E6nLS6T
 5MY9PqdBa7Ux9INolBwvCd/ItwUTG1BOs8n1den619Hd3xsOZ8HtJiVy2LopQPc5MYU=
X-Gm-Gg: ASbGncu5yyXNdcx2xwlrlSePKVHA5Vm4pISRRnHdVFDeQejS9DfNRJ2TEo9C+WinGbl
 54lj7U8ROhOg4TXto0LLIHmM4RSWFrdDn/+WAo34HkiS0Z0VwQdFubb5ZWAysiYWn0CkkLHDZBv
 s4FtqqVbbS2UsrSWR8ZVjOWNAGRLLpHu+Htbe/jbvWtBo4qOqxtJJQzurz1jn3O7IOHke4TwwiY
 w77aUZqgSimxVvnJN+ILg8sde0L2MRO6HRuXwIvUPyHf9ZLFmDn0azyo1jldfFhbyPuNNRq9ff/
 nzQjxyyzktLsX8e59t/gvBHRKuWwduXV4x9aXNRvi/sYHPYoRQq4ZbIFhqNkMmSlef21byQv
X-Google-Smtp-Source: AGHT+IFPkCLD9/dN/BGi71AaSSV8NQLymQzmR6VSjjOEgNuBSDRtnTvW+2g4zEFUjjHK71Pt5FUVFw==
X-Received: by 2002:a05:600c:3513:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-4533ca7443cmr161529635e9.10.1750162151824; 
 Tue, 17 Jun 2025 05:09:11 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232b68sm172017075e9.10.2025.06.17.05.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:09:11 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Tue, 17 Jun 2025 13:08:55 +0100
Message-Id: <20250617120855.87492-5-paulliu@debian.org>
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
V6: refine the code. Handling the error of efi_allocate_pool.
---
 include/efi_api.h                  |   2 +
 include/efi_loader.h               |   5 ++
 lib/efi_loader/efi_boottime.c      |   8 ++
 lib/efi_loader/efi_debug_support.c | 137 +++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)

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
index dbebb37dc04..303b7543e16 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2129,6 +2129,12 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		*image_handle = NULL;
 		free(info);
 	}
+
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT) && *image_handle) {
+		efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
+						    info,
+						    *image_handle);
+	}
 error:
 	return EFI_EXIT(ret);
 }
@@ -3359,6 +3365,8 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT))
+		efi_core_remove_debug_image_info_entry(image_handle);
 	switch (efiobj->type) {
 	case EFI_OBJECT_TYPE_STARTED_IMAGE:
 		/* Call the unload function */
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index f2dfcc5e6b2..d8df95abf95 100644
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
@@ -50,3 +57,133 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
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

