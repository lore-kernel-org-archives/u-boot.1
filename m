Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1CAC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E281B82EA9;
	Thu,  3 Jul 2025 08:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsviCe9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4811782ADA; Thu,  3 Jul 2025 08:28:22 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF3D80194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so42467755e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524099; x=1752128899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lC0lBe9vKtmRM9mLZfZcNSV+qQJlnUS5ENoYnv2KP/E=;
 b=LsviCe9IQG28V3DMBPjfo4CEw5tSv50qnmsz24MgO49VCcALpYtoAMGCUeWCQsrsnq
 c8axEDJEHoRKlmH/lZFJyPOy7h+3905qFFcECb6WtDm+fcLA+TzAPGp8EqBKQw0ROM4s
 /86QRVFwWMikgA36mKQ4Ff8Ej5L3aNiE2hmDFPw4NVgnoanA+/J74g01kloGmWeYye6X
 VooCexmVuamIvuStH++PAH+D7MPdIBYtOkDn2nZQy3DINnhj9/qwVn9wKSNevhEFbKLk
 h2ZIRDG/gGkX6bFnBY3YFzv7rRocUdTrLTjVM9XSm4HWlbOl3veEi4MI0T54UXyIjXIH
 b9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524099; x=1752128899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lC0lBe9vKtmRM9mLZfZcNSV+qQJlnUS5ENoYnv2KP/E=;
 b=GmCmtIeRaV+j3LUeaOWE7Qtm+GXAwGZTn0ZDPaLXXyhQJVu10OJgikUggTobNx08vb
 06a4KatRcIZWWIslL6ld8G++Vhlbe1FvUyCCcXEe0cxTsquHtvu04CWRQcF8d5eu7rt/
 +XuHs9D59loD3sYMoQltgzNtB1KsHjungKtrF6sl0KZ6Iu+2ddRLd6f99EGPVlnMQ4yO
 z63fg4vNN+jTF0aACXj75uiKApFFvARQb5+TYL7QA884xT2MKEMcqn+yqkATUg2KCSw6
 ZsZTcHdAONrXpZ5h00wuzkt1h8kTK9lG+vsXdebWZ+zoqVOIxB+dY7iZs6VL/XRz94G5
 Gm9Q==
X-Gm-Message-State: AOJu0YyM8ZaBb0LnUHXCc9nPYD8Jul9mffjzQTxNCAWS6wfKADDCHZ+X
 b3eOwl/ZhRipWMgvam9NyLP9Ny1fodZlzw4bJe+fQf+LKf9Y/2frSAOIBdE8kOmf31I=
X-Gm-Gg: ASbGnctwU1IUwYRy1t7WDSoOQF4BrQh2bK3pOoBM697elu5ISnQyuw3rjUhgsaCsF3c
 Ua9y09+edSvd0KUS/nEkVPV2qE84VQSBHYXm0J/ia3ThAz5APUSkI11MF7LeksDlME5qgYkf96F
 NGA4mcPMBQTaknd+lxfscyGUDKguSve1B5BDzqwGAiFNF/TA5ggAEchxgubvc1nnFOhDcTHeBf3
 OlUjuVH6w4gjTMJbqW4TxAJlK8GN0we7ClPQ0t4iScLhUwbsjLVZ+oKcwovUplaXqsAyEIL6aYA
 uUiy4WKaW8Dz4J01PhdOCLtaP80pw/hw9ApNyrW6D780wRhSlbYCULt8QSJTQA==
X-Google-Smtp-Source: AGHT+IGXBqE0mRxAuUx/z4lTvxsVh6A7/7/K8oE3en3j5BSdoZc3JgxerKvoZ+6stp1Ye+4SLGdb4g==
X-Received: by 2002:a05:600c:c493:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-454a9c7fac5mr23722545e9.14.1751524098860; 
 Wed, 02 Jul 2025 23:28:18 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab6esm18096320f8f.31.2025.07.02.23.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:28:18 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Thu,  3 Jul 2025 07:28:07 +0100
Message-Id: <20250703062811.72871-2-paulliu@debian.org>
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

Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
the address of EFI_SYSTEM_TABLE.

This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
The implementation ensures support for hardware-assisted debugging and
provides a standardized mechanism for debuggers to discover the EFI
system table.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: add Kconfig options to turn on/off this feature.
V3: make efi_initialize_system_table_pointer() do the job as described.
V4: use efi_alloc_aligned_pages() for system_table_pointer.
V5: move the code into a separate module.
V6: Use macros to replace size_4MB
V7: Fix the code based on the review. Update license field.
V8: Fix pointer casting that causes qemu_arm_defconfig failed. Modify KConfig
    so that more defconfigs enabled by default.
---
 include/efi_api.h                  | 16 ++++++++++++
 include/efi_loader.h               |  2 ++
 lib/efi_loader/Kconfig             |  9 +++++++
 lib/efi_loader/Makefile            |  1 +
 lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c         |  7 ++++++
 6 files changed, 75 insertions(+)
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
index 7f02a83e2a2..621db8b5c79 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -71,6 +71,15 @@ config EFI_SECURE_BOOT
 config EFI_SIGNATURE_SUPPORT
 	bool
 
+config EFI_DEBUG_SUPPORT
+	bool "EFI Debug Support"
+	default y if !HAS_BOARD_SIZE_LIMIT
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
index 00000000000..7dc5fa93af9
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
+	systab_pointer->efi_system_table_base = (uintptr_t)&systab;
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

