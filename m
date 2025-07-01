Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F8C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 03:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2317682EA9;
	Tue,  1 Jul 2025 05:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eubCRz64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A631C82EA5; Tue,  1 Jul 2025 05:49:40 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFB481FFC
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 05:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so4369750f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751341775; x=1751946575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtDuWvkJZbt7GVDm9d//HD8iQHWkZn158bOnhT5atSA=;
 b=eubCRz64jv2Ssar08j1UbOT7LCIaZgYDXcE5xRl6kfthXU5B6rbwckJfipRJG3qr+5
 woss368mO3znm3YuS/KO/4Y0xqvSehUFZ4Kwv1v1rOVgs+He+VByuy2nBVeatWsKoQ3P
 kcYE9OxMK9mg8KqgWpPwcEfoHSOfyRQZW1Tj6G/ruEuON/eq0ifBAmFsBRiz5ERuww3C
 VqQXUZHU99kd2d5ovEHbE8ER2PgYFZ/Ke+BdQec38XqAwYnXU3YVYuNz1JnOA09UYWqJ
 UjQjF4oZ2qYDWKbaaPAmpsv1oDQCQ2eLTgN2Dsttc9l4RuRIyzxw3gEj5gJRykZJwaIV
 QNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751341775; x=1751946575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MtDuWvkJZbt7GVDm9d//HD8iQHWkZn158bOnhT5atSA=;
 b=mQQXyBXkkyANN3gFW+Vuv8RbuJiT3Q/hO37GSZpw1SfZAABMYMVXlNh4d1asd4lJdS
 goBiQCczciruTtn9EGOZQ7ii9eZbKOBInCoVAe0fEdl56d1iHEkvErhLON67CF6OSd2K
 P5MeR/v3MquZEwFsvpN7bYtq1iM1iCkt6AQQV/BGCSBuSFDnER+IwPLukPG3CrI7YqZL
 cUap128AKaFSDyJhv9Mo9DCovHD8oTW35PK8iCWfM9DJVjQjiUcix+27jpMjSqtjXxhF
 Qbxw3lOnC3aw2Kozdpqe8GP/Q0MsOCzOhKL4BTupdps41yhtlOxg6OASOdQpTRrbWe1/
 7+EA==
X-Gm-Message-State: AOJu0YwoG7cqiFAeTtgrS2yZVLl7Jflt6/kjFxiM1lxR0VpVxGgjD2r8
 CZMM7RdhHVQhqhWlsXwuz7THrQuwreMjTZCnfwsBlgU8p1vhwkOF9X/t0ymA75CHYqM=
X-Gm-Gg: ASbGncsc9CB2ZrPlFWbG6TItnNv8mbrsU2JNiB8i4+d8i9ThDvXLm/Wvd4iZdk0LOnr
 Dl3oppQOJDLAIttZikNN5PRUapNWl4K/LzoQ0sh/BODb1LPXfLrUpyoAx1PPMLCtSk5+wowlOhJ
 FUeTDtp95kxsQNs5QhkmX0LH9m33EWj65cB5g7bRvqx3ZqXPks89u12yMTAa8fDyqXQLP1WNsbA
 DeJVSK9OI1FT8RNvkm4eZdI7jZ/JltjIEkwQcfGmBBzm85nGYA1wSqijzh5C4ftarsDOlco+Z/2
 M77EM7+ymnFbcNm+3Svs9bRI24m8M0U9RdTh8SfJBNsYBeZeh1SBpu/zSzPLGw==
X-Google-Smtp-Source: AGHT+IFPE66oxqWOEH2KVLbUBeSA5/D12Ofo7Jjk0QA8ZwXPxunfEk+EQ8OyeUAcYjPhned0f4ZuhQ==
X-Received: by 2002:adf:e282:0:b0:3a5:2a24:fbf5 with SMTP id
 ffacd0b85a97d-3a90d69c3ffmr9983249f8f.18.1751341774530; 
 Mon, 30 Jun 2025 20:49:34 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab15sm12100248f8f.33.2025.06.30.20.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 20:49:34 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 1/6] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Tue,  1 Jul 2025 04:49:21 +0100
Message-Id: <20250701034926.83536-2-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701034926.83536-1-paulliu@debian.org>
References: <20250701034926.83536-1-paulliu@debian.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: add Kconfig options to turn on/off this feature.
V3: make efi_initialize_system_table_pointer() do the job as described.
V4: use efi_alloc_aligned_pages() for system_table_pointer.
V5: move the code into a separate module.
V6: Use macros to replace size_4MB
V7: Fix the code based on the review. Update license field.
---
 include/efi_api.h                  | 16 ++++++++++++
 include/efi_loader.h               |  2 ++
 lib/efi_loader/Kconfig             |  8 ++++++
 lib/efi_loader/Makefile            |  1 +
 lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c         |  7 ++++++
 6 files changed, 74 insertions(+)
 create mode 100644 lib/efi_loader/efi_debug_support.c

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
index 7f02a83e2a2..f9d75cbc3fd 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -71,6 +71,14 @@ config EFI_SECURE_BOOT
 config EFI_SIGNATURE_SUPPORT
 	bool
 
+config EFI_DEBUG_SUPPORT
+	bool "EFI Debug Support"
+	help
+	  Select this option if you want to setup the EFI Debug Support
+	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
+	  agent or an external debugger to determine loaded image information
+	  in a quiescent manner.
+
 menu "UEFI services"
 
 config EFI_GET_TIME
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index cf050e5385d..51ccf1cd87e 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
 obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
 obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) += efi_signature.o
 obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
+obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
 
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
new file mode 100644
index 00000000000..c9773feaa5b
--- /dev/null
+++ b/lib/efi_loader/efi_debug_support.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EFI debug support
+ *
+ * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
+ */
+
+#include <efi_loader.h>
+#include <linux/sizes.h>
+#include <u-boot/crc.h>
+
+struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
+
+/**
+ * efi_initialize_system_table_pointer() - Initialize system table pointer
+ *
+ * Return:	status code
+ */
+efi_status_t efi_initialize_system_table_pointer(void)
+{
+	/* Allocate efi_system_table_pointer structure with 4MB alignment. */
+	systab_pointer = efi_alloc_aligned_pages(sizeof(struct efi_system_table_pointer),
+						 EFI_RUNTIME_SERVICES_DATA,
+						 SZ_4M);
+
+	if (!systab_pointer) {
+		log_err("Installing EFI system table pointer failed\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
+
+	systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
+	systab_pointer->crc32 = crc32(0,
+				      (const unsigned char *)systab_pointer,
+				      sizeof(struct efi_system_table_pointer));
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 48f91da5df7..78c5059256a 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table pointer */
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
+		ret = efi_initialize_system_table_pointer();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.39.5

