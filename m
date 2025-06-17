Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F010DC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5B582D39;
	Tue, 17 Jun 2025 14:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDOPD+ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E90882BA1; Tue, 17 Jun 2025 14:09:10 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A4D82BCD
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453426170b6so16923215e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750162147; x=1750766947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPHwTuMl+G6hwPSEOHWApGdofp/1DlV7mnQ5GtMvyxY=;
 b=HDOPD+hopEmi5i5q8b2IfrjGZMyStM5MuAoWYLuimr+ucrYaSZMbtj0DR+krtWs3Kp
 6h2OCW6WX/HaHVaXnzA0kvA2mwgu/6iyzkcNiyNEQU4Aiid+nSgVgL8UjmDI8V0lqPOF
 oVwfeVrLnOM+N63QqJ5k2RRcy+sYuQUBr3Ka6s/ThLQScJG1T2lRMC0KCYMdLCgyICrX
 kIQMTuCJQDeVcwuN3huQtPY5MNiB7it9zHO4HmXjjzmiPNr1ZLVZl1Y5hqNUv6Udsrhm
 OdqlM3VVhHAWEk8tDE3W9l1mnJOfLGoZUcuK5QclHicUMTILwhziTUIxcxOykIA5PyIO
 p2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162147; x=1750766947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vPHwTuMl+G6hwPSEOHWApGdofp/1DlV7mnQ5GtMvyxY=;
 b=gTC1dYVAoNnl11mCnSsK5mOBrPSwesxPtjO8p2ExXtwRON5/MHpTrtdAp/rTY1qcGM
 MuFEsP2b51H5aGUaW14v1eyPVXjELR8G5ua0tNqlm6RT4lXxDhHh2xamcK77fYq9EWQ6
 5yXCaSFXMRfdkhYVY1K6xmGhwVQenyQkD2mR6iirmFtsB5bXSaV163vZsx+ixHKqR4wN
 hRA9venTQ/Tq0np4kmM8o1Vt2p+FMpu0GMqJ0ZIdDO1ujsI/EqCWkwUxlDWn+KicLJHs
 fRJOH4QzZKT+wpW73KMySvWWz+23reZCrUwEJWRGDQXsz8rTjiZ7BtFuSR7epnhNM274
 0yag==
X-Gm-Message-State: AOJu0YzyCWu0YtEk72rkwEUPgBHJqk6FMSXnf29azL7Hpi6GMoce+vOG
 UChRu356sdHd+HBiNJH2wB5xo2+w1h7Bunze6JOQt75lSo/+L5aPIL1UA7k8v+5rCow=
X-Gm-Gg: ASbGnct0ZBC1fTs5VoEvafvCXAOqCaziOiYUg+9zu1VcO1ZRL0/Dg3tvQr/7490vPKV
 eUfmJrpk8OEVbsSVGfS9E6fojVHJK2xuBjiIB5Pg9JJGZEcvp6bz7/x/LC+4KR8ZRTTHTzo/lNw
 3iB5SZsa3AJNiEWBzqB4B29e2Lr+kdy0BnxL1CZlYmuXkJLU9IHgJw1u4YqgO0cOSbfjy7rt/3l
 jbk8w5BIJfBWpINKFev+ZqJ0OTsGZFYN2WSTcd7Z8frEV9A2XPwzcaC4N/NtROyMEp4uFENX4Iz
 vrLUcC6qM5/0fkYN4WrYLIJqKUJrNL8UEgWEE5PFw70Py8zNCEWhZ3IU0RRXCA==
X-Google-Smtp-Source: AGHT+IGplvyHf8K+RCiJ1CGd8mZrWhYL1zN5DJ0vk3aJ0+s/zlF5zRIh0Iz5bgtqyTgBtqN0qM1uBA==
X-Received: by 2002:a05:600c:37c5:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-4533b28aa22mr139105505e9.15.1750162146753; 
 Tue, 17 Jun 2025 05:09:06 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224956sm176348555e9.4.2025.06.17.05.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:09:06 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Tue, 17 Jun 2025 13:08:52 +0100
Message-Id: <20250617120855.87492-2-paulliu@debian.org>
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
---
 include/efi_api.h                  | 16 +++++++++++
 include/efi_loader.h               |  2 ++
 lib/efi_loader/Kconfig             |  8 ++++++
 lib/efi_loader/Makefile            |  1 +
 lib/efi_loader/efi_debug_support.c | 46 ++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c         |  8 ++++++
 6 files changed, 81 insertions(+)
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
index 00000000000..3794b31c4cd
--- /dev/null
+++ b/lib/efi_loader/efi_debug_support.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * EFI application boot time services
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
+	uintptr_t addr;
+	u32 crc32_value;
+
+	/* Allocate configuration table array */
+	addr = (uintptr_t)efi_alloc_aligned_pages(sizeof(struct efi_system_table_pointer),
+						  EFI_RUNTIME_SERVICES_DATA,
+						  SZ_4M);
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
index 48f91da5df7..6193b9f6d0c 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table pointer */
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
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

