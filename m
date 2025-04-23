Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE8AC369D5
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 21:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D5E8082A;
	Wed, 23 Apr 2025 23:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFJJsI1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3316D817C4; Wed, 23 Apr 2025 23:32:19 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC97B8059A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 23:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227d6b530d8so3350675ad.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745443935; x=1746048735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LRpx+FoNAOUs9oPJ2fK5/pUlKszN2F1r/PYJccPvCU=;
 b=hFJJsI1yCntaCqQGzOPJP+R0AFF8Tc0kB1staKJAnTfdG2yi1IWfWT5jUdYGr4wduV
 OKPQuez1jHvOXqJA5fn4adX1CBfYe2gdLa3hOqvyRSdway3li/AzBITv3HOtqPaAoCTO
 nW5EZrFhz5vqyr7sszwWqSLDHtUYtWiCbJpwWy4QTEa+ERw5vm5MohAtg1aBxIzqlDlV
 dXbXHvGE9IRg5RRTwIJaHjJtr5LeGnrmPo3zaYKDodzXCZqajIP/xySupgH4FFdgWl/d
 oJnxBz8a4aQg58Ky5ZCxegTGl8HnYrA9PwxXgH8vwekFTsvZc2VxeQDcaJp072UMC+HH
 cwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745443935; x=1746048735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LRpx+FoNAOUs9oPJ2fK5/pUlKszN2F1r/PYJccPvCU=;
 b=UWdo9BdS9t2JY9wlC3dqQP97VgqaX6PENTnLdXpsy5GBB22QVjDiD3JZoAUW0ILYGQ
 tfhV+VNtwd15zf/RCdJY+xIYl2Y05ZFjsvyeZbmA+pBe/GTn9N+bnbeYJRfkevc7cKSH
 nlW62F1LqzRZHHy76ULyT8c7P0kg86A4Ol0Yr1cqb/lynbYXJvRX7ApYZz3UQe/wYLKq
 yIfBL0UXIdaQQ8wFTyLW3DA4zHAVnwaAZ6K7DA9v8PzgGTioJUbEVlyH/XwqsT+UXeXL
 Cpd+7HVv8sKYXoO3l2iApb6Zn9hyBC+H1/duj1mV56wtoXXXDty0+jYP5h7DXdBy6p3H
 D/Ig==
X-Gm-Message-State: AOJu0YyO/Z/vS6GT8Xm9oUhPCPvFd1IAJOQF7ZiarQ7QsJcyXMD0mGg9
 FznpyAKEjdZmJVvYGVwGwFX7ubvwI7MHvzGXBCKutfLIzrAwLFgqJg2lrA==
X-Gm-Gg: ASbGncu+ftbr8QjsWC9rWxK9q+aqDxhIb9T9bFqnttUMEKIizRrZDKDQGxXlFr5KXWv
 YVyXQYAks4SQW9MwLgadEzDgjtZ5xbEhArjksncbv4N5iH+shzVbguxUJQm3mrHrEjjz2kSS74o
 81Zv/bhqvVT20JNr+n1dYkdZ2YTzdSeh067qOUtWQmX6AI4KBtPvOwIix6na5cccU7nibXLBAtN
 a3Z+fkka/KFKtNXOzo+5mPO9UZTclZsc6ec4LLINCkrvHPBbaW3PM5oiO5T7I6L3XB35kblEfhc
 kQLAkwlptriBL/O7rr6mfYYSaJjAFJQPKwKS
X-Google-Smtp-Source: AGHT+IHMiwiVV9TY2gSHg2ezDn/AURS0tlGG61qy4a/VLfsBncLdsiRx8AyQdhs+CM9PnsSgubUZFQ==
X-Received: by 2002:a17:903:2311:b0:220:e9ac:e746 with SMTP id
 d9443c01a7336-22db3ded901mr756435ad.53.1745443934777; 
 Wed, 23 Apr 2025 14:32:14 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22c50eceb44sm109452615ad.188.2025.04.23.14.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 14:32:14 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
Date: Thu, 24 Apr 2025 05:31:44 +0800
Message-ID: <20250423213145.1959046-4-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423213145.1959046-1-paulliu@debian.org>
References: <20250423213145.1959046-1-paulliu@debian.org>
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
 include/efi_api.h             |   2 +
 include/efi_loader.h          |   5 ++
 lib/efi_loader/efi_boottime.c | 136 ++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

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
index e2665459e44..bf37580c06b 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2130,6 +2130,12 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 		*image_handle = NULL;
 		free(info);
 	}
+
+	if (*image_handle) {
+		efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
+						    info,
+						    *image_handle);
+	}
 error:
 	return EFI_EXIT(ret);
 }
@@ -3359,6 +3365,7 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	efi_core_remove_debug_image_info_entry(image_handle);
 	switch (efiobj->type) {
 	case EFI_OBJECT_TYPE_STARTED_IMAGE:
 		/* Call the unload function */
@@ -4045,6 +4052,10 @@ efi_m_debug_info_table_header = {
 	NULL
 };
 
+static u32 efi_m_max_table_entries;
+
+#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))
+
 const efi_guid_t efi_debug_image_info_table_guid =
 	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
 
@@ -4095,3 +4106,128 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
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

