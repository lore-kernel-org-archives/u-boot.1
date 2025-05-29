Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B25C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 04:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2729D83658;
	Thu, 29 May 2025 06:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Moc4cmnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03F583641; Thu, 29 May 2025 06:05:37 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998C8835B9
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 06:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23035b3edf1so4747975ad.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748491533; x=1749096333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V89A9UTG3YMXEddLVjU26j9qzklW25Xyyhm8bQ2C7Uk=;
 b=Moc4cmnzYRc2jnk/MPwnNLXiHVL0ngR+NmrwbXAbFWN3vJ6SuZwkD1Rc6lPgP9ql37
 fEsYzzOsQ8Ptof1dKCUJI7i0lLEr3+YvmvkS2sVUne6BYKdkSrO/ZdC8KI41NyXAh1xu
 XUYomekPJITAZUV+qRc+hgXQlH1iUNLIUz7yFjTjMN1CQ3o/pBtvuo/KQpJApiZ/dHTr
 nMfYmY6RjuGdsO/0I+XmK3qPtmfOz35+F9T15CRGuWJlC+R0DKK03AfxBLQP7NXqsGV8
 8u7/RwZ85H249aNGxwk7PqNoWPjzRuCWYbt5wME1ygxMhVPRQ03CiTWcYRUVDxmgH53r
 cAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748491533; x=1749096333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V89A9UTG3YMXEddLVjU26j9qzklW25Xyyhm8bQ2C7Uk=;
 b=fSWNYFXQmMq+h/13v7TZFmCIKP3fnkVsjCjtNXASXI4g/vRHSCbgk68y6z130V9Vxs
 bvMtYCYp+8oZtCOE6qoze+bBouxc7xIfRS6UUnXkD/inLY6Cwhzrg1uoxRvbd9E7shf4
 UymZyqquTnrt6JZdz6C47X/hWdTE0dVYDK71RshDyWqUpIX7fm456V2WEAEmj5QFqhXs
 3oxOGebz1tvW4xw7AJ6LcB3TNCfT5NEGzHOyLHTmfwLe9lv9tgSLnyql3n5jGQO908br
 evfAnuuVKn2vtG9npIO6K/UjbDUByWRCc6y8dD/MRirI284laLKGd4R2pZgTGTm6CH87
 nkSw==
X-Gm-Message-State: AOJu0Yxwebrrvip8v3uIudeg6tbPeWt9HLB46nuwjz7dC+NlmHKDH9rk
 gUb51sjDwzHo0oEJ/y/MxRP6iveQoohyz05wCM3in+tae92LjWaspGWNkNkFKcAx
X-Gm-Gg: ASbGncuZqMfVZzJzW06qEhIuinVe5pcq4LqAkaAWVcuCW29HJVbvg9dhfDDCpLVdkUP
 AVMouqKwBmgcbA4k6nCBWzPOKznHl4k3X3IgMCpVvfnhVXQBlC9z0mt4QrMuYw6tpz+wA+P9Zer
 y5i5OBRfydU8HxgrjEJ1538uN755pEbD1i9WxyAuXuzygFS89qWcWGypjBZj2DfaxwH/ubbxofX
 /cloETI0LXz00U/RZ3dkQ+t+/QqfSpFYT8sK1M8y5OJXdm5FkHRxrmuH2ffFYn756wJVSPCjNa0
 hIu8qAuRxFexy5+GHi9lcPO9pUr6lY7KM5sXhYC9KHf4f7Q=
X-Google-Smtp-Source: AGHT+IGtx6JZn71M+5z0fd4opKgF6gHc1gX79orMXOHfb87sf2gjaCOyaByltraXNPwcSvKzozkZXQ==
X-Received: by 2002:a17:902:d4d0:b0:234:b41e:37a2 with SMTP id
 d9443c01a7336-234d2a62c4cmr68412715ad.11.1748491533491; 
 Wed, 28 May 2025 21:05:33 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cd3535sm3587545ad.120.2025.05.28.21.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 21:05:32 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Thu, 29 May 2025 12:05:17 +0800
Message-ID: <20250529040520.3799600-2-paulliu@debian.org>
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

Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
the address of EFI_SYSTEM_TABLE.

This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
The implementation ensures support for hardware-assisted debugging and
provides a standardized mechanism for debuggers to discover the EFI
system table.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: add Kconfig options to turn on/off this feature.
V3: make efi_initialize_system_table_pointer() do the job as described.
V4: use efi_alloc_aligned_pages() for system_table_pointer.
---
 include/efi_api.h             | 16 +++++++++++++++
 include/efi_loader.h          |  2 ++
 lib/efi_loader/Kconfig        |  7 +++++++
 lib/efi_loader/efi_boottime.c | 37 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |  8 ++++++++
 5 files changed, 70 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index eb61eafa028..6c4c1a0cc7b 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
 	efi_status_t capsule_status;
 } __packed;
 
+/**
+ * struct efi_system_table_pointer - struct to store the pointer of system
+ * table.
+ * @signature: The signature of this struct.
+ * @efi_system_table_base: The physical address of System Table.
+ * @crc32: CRC32 checksum
+ *
+ * This struct is design for hardware debugger to search through memory to
+ * get the address of EFI System Table.
+ */
+struct efi_system_table_pointer {
+	u64 signature;
+	efi_physical_addr_t efi_system_table_base;
+	u32 crc32;
+};
+
 struct efi_memory_range {
 	efi_physical_addr_t	address;
 	u64			length;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 8f9f2bcf1cb..8f065244d8e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
 efi_status_t efi_root_node_register(void);
 /* Called by bootefi to initialize runtime */
 efi_status_t efi_initialize_system_table(void);
+/* Called by bootefi to initialize debug */
+efi_status_t efi_initialize_system_table_pointer(void);
 /* efi_runtime_detach() - detach unimplemented runtime functions */
 void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 7f02a83e2a2..d878fc9021d 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
 config EFI_SIGNATURE_SUPPORT
 	bool
 
+config EFI_DEBUG_SUPPORT_TABLE
+	bool "EFI Debug Support Table"
+	help
+	  Select this option if you want to setup the EFI Debug Support
+	  Table which is used by the debug agent or an external debugger to
+	  determine loaded image information in a quiescent manner.
+
 menu "UEFI services"
 
 config EFI_GET_TIME
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index dbebb37dc04..16e921781e9 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab = {
 	.tables = NULL,
 };
 
+struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
+
 /**
  * efi_initialize_system_table() - Initialize system table
  *
@@ -4035,3 +4037,38 @@ efi_status_t efi_initialize_system_table(void)
 
 	return ret;
 }
+
+/**
+ * efi_initialize_system_table() - Initialize system table pointer
+ *
+ * Return:	status code
+ */
+efi_status_t efi_initialize_system_table_pointer(void)
+{
+	const int size_4MB = 0x00400000;
+	u64 addr;
+	u32 crc32_value;
+
+	/* Allocate configuration table array */
+	addr = (u64)efi_alloc_aligned_pages(sizeof(struct efi_system_table_pointer),
+					    EFI_RUNTIME_SERVICES_DATA,
+					    size_4MB);
+
+	if (!addr) {
+		log_err("Installing EFI system table pointer failed\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	systab_pointer = (struct efi_system_table_pointer *)addr;
+	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
+
+	systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
+
+	crc32_value = crc32(0,
+			    (const unsigned char *)systab_pointer,
+			    sizeof(struct efi_system_table_pointer));
+	systab_pointer->crc32 = crc32_value;
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 48f91da5df7..a6b37d994f6 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table pointer */
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		ret = efi_initialize_system_table_pointer();
+		if (ret != EFI_SUCCESS) {
+			goto out;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.39.5

