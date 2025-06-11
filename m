Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995F5C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 05:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2935182B97;
	Wed, 11 Jun 2025 07:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzjQHhB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEF380050; Wed, 11 Jun 2025 07:08:57 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E52880050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so3257022a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 22:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749618533; x=1750223333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDFBvNBvhhq4Swz/RoJ3jC4CBUwAvIhB3uqGG8fS/us=;
 b=mzjQHhB6UsoTiaLSQRs/FTqvaqN24xwaNgJ5/0LqoNZ8KqPnixO/atxeI5w9pVo0Nn
 PUrn0+NA/4bSUvmTF0Z41WbWFSu7pfSltT4D6VmiYfPdAanPErh6nDEpQKNuRi/ua+Yo
 NqkP1LyC3SIkeMc3I6GRjooGDoFso0nzBscfYBuvrCx+8RTe96R/OOAofl56a2vtQpL+
 9OaywrzNOe1ABMEhh0sDGaUz0DHLyeEXQ4ns7qLn0wLSv+tqPonh1X6l2+2fhT1/HrEo
 8v7q24MaE9i52Ua1BUn6b5NtKu1VPws6KKYOCAPRaKRLIP2IEP2J0KQV2vzTdLHCxI91
 ZCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749618533; x=1750223333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XDFBvNBvhhq4Swz/RoJ3jC4CBUwAvIhB3uqGG8fS/us=;
 b=WWvNc/mC/ViDdv9Zce6WdaA8H8gc1U3s98YHArNsY8Fl4jN2iclW1eE/C08qekHIrW
 H0S69yS1qKSPVI716iAZ+1rE2z6+kty6haFylwuUUXSgUkm+EwQQstC9SaQuLkMrRN4X
 RpYUx5GmBcLIVqYQ6QsOQZtm3z+iR+yNNS4G34s5rulclPeecRptdi/8Ylfje3EXE4jL
 6xaTdtFsz2VwdzMm0N5dW/dUqm1jxglzLI2B/L4/LES3u46fGVZJG6K/+VzsHHTWBV05
 9oa7qF96AwYfRqoBeEnthGWl3zXluJx0nlW+CCewnzvdUxzKrJQi+QVeZ+vzJY1gAMHl
 b6aw==
X-Gm-Message-State: AOJu0YyV6QgBjAdJgSjNcQuT+8r65mYsMUc9ygJPcT6DfYXIHMoXNKaP
 lW+3gUWszMI7HA0/uwxmP9IjBMEh8pQ/7kLygyDiME/pxJY7VH9i5jDJbWPEoBvc
X-Gm-Gg: ASbGnct4SM0cQTMhAMrfED+qY69zuPliOzwfODIwiX+Jxp0ZGJ53eC+5SZtSqfVUTa8
 Je7phRQSUpAUaai2psFuZUQMnhz/l9serRBfhvDoqmSyC0dJGNyHRgwbaLHFd6pYhiKnVPp+akU
 fllF3snaC6a9mNcoUxkAq2JguKXCj2OPepWger3v5W/hcjAv9w70BaeCheou1si0UIE9i1+hAYH
 h4PjjrS84KdbPANkAouQrQv0050AXV8LsEh6WYAZhCw08ylywiB/SIuCxHNDc7NM3Db4qAmSV0Y
 OHCGNmwaTLrMScBmtzwLtsGwNBwESfh0rdwmI9Q46uypHRj97mNoZ/vUvA==
X-Google-Smtp-Source: AGHT+IFaUs2wC0ZMJQyR9n3S1jPZY4NSFQj5Ips8V9bOCPh0doMXNySrdB2GpB/vf7C0LdcAchdW/A==
X-Received: by 2002:a17:90b:2b4b:b0:312:def0:e2dc with SMTP id
 98e67ed59e1d1-313af0e431cmr3448659a91.7.1749618533240; 
 Tue, 10 Jun 2025 22:08:53 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-236035069c3sm79338905ad.234.2025.06.10.22.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 22:08:52 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Wed, 11 Jun 2025 13:08:40 +0800
Message-ID: <20250611050844.210384-2-paulliu@debian.org>
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
V5: move the code into a separate module.
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
index 00000000000..a0f7506779d
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
+	const int size_4MB = 0x00400000;
+	uintptr_t addr;
+	u32 crc32_value;
+
+	/* Allocate configuration table array */
+	addr = (uintptr_t)efi_alloc_aligned_pages(sizeof(struct efi_system_table_pointer),
+						  EFI_RUNTIME_SERVICES_DATA,
+						  size_4MB);
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

