Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB8C54ED0
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 01:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0E582FC8;
	Thu, 22 May 2025 03:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fpgHbMl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3492582FC8; Thu, 22 May 2025 03:18:13 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6A4E8006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso5783952b3a.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747876688; x=1748481488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWReCurJ+obBSDi8LPddyb2jrmX55tghlpf2elNaZNs=;
 b=fpgHbMl28pQTgXzbi7yzqn/Aut4CJvxu5cB2eSGNUSQGm8X6e5BNZ20Obcz/j9/HON
 IZqcuzsMCrdEz6u0ShBdSKo/g//GXGtmkmII96dxzb+fDmtTVEvEKOOadDze3e4y50uH
 WCcvT7sx+Cztk3U1XIAaRn9dfNzcWXYO4VT/AxuDB9+6VqX7yGRsJ27GtWaf1wK5uRfy
 9Z2tdOm3I/sySGB2ZZuZ0G1YcpqPQj/pJ7IcNkm4D0zZplLwavnbV9MPiiGq/ZGPpR1a
 MEoprGWntZvC0Hx7fhuwAZrO3RxtjnPYxx3ii6ConOTU0Pd6/21oSADWGDt6gQGZ2/IR
 xfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747876688; x=1748481488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWReCurJ+obBSDi8LPddyb2jrmX55tghlpf2elNaZNs=;
 b=C/DdtuKGq+3UwcvMg2WYjsyVHGLp+gyKzFF6HL7NPlbwEMaXkv+BbAvdWd1e21FBjq
 63vL0infeX6conFPRkXd1pkCGv4hVGZMl+uLdj103pjrL4EwjU1KVla6qaTsvw8g6W1h
 SCFbXf8wo7UfbqqfBUhZQVitid8+NYEGeiTQzYa9iYkqJG4Ydnk3J/lhhppaAsmlvltV
 BhSEYb/L4X8F9KWszf6JNo+k1ftFGuAI1NyeHbOv3nbYmt9RSd9Torf+bz0LF+nzrK7R
 ujaoXObsSmLhSwoTc78rs/FC/tp7gvNv5Tt2SGAJK8yUW+f0EZxpSNKsjnQSWu6W3+8I
 jzDA==
X-Gm-Message-State: AOJu0Ywfqrd5K/aD/CcnjovM6PvBSqAJv60MRXoFsq+vAp5PgLdLTWEh
 JXy53Dd7iTN/bgXi4aVwh30CplSeynTULjkPHf3J3l0J/knu6nCH2RnVxPGczQ==
X-Gm-Gg: ASbGncteQRomLnOjA9z5doGN6eNOHt+x0qASuuNVM9RGjPS9fEmZkKm4o8qOI7TPYs7
 4PI5JULr1KxTkDQ61zFE+CpE6ILmOn+UVE/h16A5NOSMfuq8U6dF+Nwyg8t3LmW7GhMurMe1Ltz
 NIiSVWse3M7LfwVPqH+g9sAUaj9UZxuhFiGIAkydNClt1fd2X9dUJSFzW5pc1xXqAWx+HuYA9jL
 9UYNXXbh+xGwCrqVmKruhDSTQpQpvDmqOj8KKhM4p/g3ygqt2MHJEbNKvP8tSaxnPRpThwUktZt
 WEx+1PKpeT0mxteVvZHBDhnf/EMkQzU1NTV/EgGiNNPBgfeKUWV9L07bO+Rx6hrPJdZo
X-Google-Smtp-Source: AGHT+IEp0otkO96i+fSu1WPl+DdeAe4XWUJNFo6OJopXO/yNoumBhupoRiInDjdIr3TPxQHZuZ/cHg==
X-Received: by 2002:aa7:8e8a:0:b0:742:b3a6:db09 with SMTP id
 d2e1a72fcca58-742b3a6dbdbmr23710755b3a.16.1747876688465; 
 Wed, 21 May 2025 18:18:08 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a98a3403sm10549852b3a.177.2025.05.21.18.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 18:18:08 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Thu, 22 May 2025 09:17:48 +0800
Message-ID: <20250522011749.3498970-5-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522011749.3498970-1-paulliu@debian.org>
References: <20250522011749.3498970-1-paulliu@debian.org>
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
---
V2: use Kconfig options to turn on/off this feature.
V3: Use efi_realloc to realloc the tables. Move tables to boot time.
---
 include/efi_api.h             |   2 +
 include/efi_loader.h          |   5 ++
 lib/efi_loader/efi_boottime.c | 142 ++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)

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
index ff7ca5a0480..649bfc36f22 100644
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
index 5a4349f8679..58fe3416817 100644
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
@@ -4081,3 +4099,127 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
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
+ * @return                 status code
+ **/
+efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
+						 struct efi_loaded_image *loaded_image,
+						 efi_handle_t image_handle)
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
+	if (efi_m_debug_info_table_header.table_size >= efi_m_max_table_entries) {
+		/* table is full, re-allocate the buffer increasing the size
+		 * by 4 KiB.
+		 */
+		table_size = efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
+
+		new_table = efi_realloc(table, table_size + EFI_PAGE_SIZE);
+
+		if (!new_table) {
+			efi_m_debug_info_table_header.update_status &=
+				~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
+			return EFI_OUT_OF_RESOURCES;
+		}
+
+		/* Update the table header. */
+		table = new_table;
+		efi_m_debug_info_table_header.efi_debug_image_info_table =
+			new_table;
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

