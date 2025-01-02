Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98169E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93078803DF;
	Thu,  2 Jan 2025 19:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cg3yK2F2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 728748039B; Thu,  2 Jan 2025 19:11:52 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BCC8039B
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 19:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBBC240FA9
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735841509;
 bh=kVzhLrXSRT8Yrcqt3Gkx9ZseH6xVyFXyuGQdNewhx/U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cg3yK2F2E3ySlmLpAFIixys78o0DfjVy/DHNdZoTo+mqMRiTl076WphguyeCNNHE1
 z6nt8Zzy5q9iFN0plEVMrHaX3G5TlnYIi+ZV6PnVpMU9ukoHs8Vy03UE5OIwYdTMHH
 r6Gts/Z6YpZzSdqjG0C+T8lKSQDIEqDTOXU1J7nAgR1d4UFWOwaZohcNtaIRQ4UPlR
 po8dhjAfDsNfaHWEtAS3b1i5FxcD8jObrUiKydfAGSBDNXV/hDkIgpl8Vy/MoiIAB/
 pgiXriqnf49KCMDMPazsQSpO7kXVXAFJHOy/Wlfva+4cQroKgs+0ZcqGnjBlsHHyR/
 o7CZfTUnTRx6Q==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso62312155e9.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 10:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841509; x=1736446309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVzhLrXSRT8Yrcqt3Gkx9ZseH6xVyFXyuGQdNewhx/U=;
 b=bTNtPEdfscEf/4FHZJwF2M/Rg1HkJ8DT5rYYaAS+hqVz27KvdjsSIVGiVSJvvG+vzZ
 /fDdiJFZf0/9IWPLIJDSKTm6IWz0fildBlPWT082sgqlSMbYUDAKv/HxEjzqxKGdgsxc
 0mqRDQu4TIDBJfh/+Mr8lWJT2QsIc0nbfRZ6RvmW5rcLALl3DbzqNjnJMc0nCYUXM/tr
 L3yia0y68ikOVqLsrj7/yVV/Yu8KWboR/VONUjxRAVdfO3NCu0hG3JRCVT7R8jPKs3FL
 xG0w1kt4vt8TtT/YPhjKfHLvlefyHifcHf3lnRHgMIkV2Kp5llfG5amsgP6xUH/wi5O8
 Dgfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWztlUV07pR9HvLNI+OaLsiA0NDiCOz9Z7ACKYm2yaBIVmKQ+n1PpKR8fYcPK7lsKOgURRMoI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh+EANJgmtFX6s+J5ZPOBW0b2aWwGB9CZfMOfKDwmip7qWPVWZ
 /Pv3yx71HgHmorQiREWh80cwP7xq5W0jjelr5dG9/WOqNwCiC/wrM/R8FXkfTwOiASuUpf4vJ8A
 +XVwElofX53hkEdFn+eoRDYheOAHpLMq4zFOR3vzCnD1yqdFhk2LGQkI6peGHB/IOwn0=
X-Gm-Gg: ASbGnctsyHNSqZDP4vo04MKQZ2pLMl8w0sp4+elS0XOD/bYDJs0UXNlNzD6DQ8G/8JF
 RjA+55nSx/kTpbNOmcxcRRJPaA5I2jm/oyxEmMUAQi6dVKqi788lNVge2o8D1njjBKVhqceAXQQ
 HN40/Sii1t684grEu/e1zR6FIcIO6Fpz/Vvz8bH510omodKLTX6/tcdFTaCj9p6ZEKiXPhE9zbO
 PpOBE8Kc4IJg/6b1unPdcXbFUm9O8ZUHdSBP6600DYLxvwHiBSfsMzLSE/sKdRpHy05ucDW3XD0
 bWHubXLFKCVPBQ==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-43668b7a1dfmr373083565e9.29.1735841509313; 
 Thu, 02 Jan 2025 10:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXzfVF2q33eYvr4IZncqE0iax3I8aFMnkat+kgzshkscJz+DGWWu9QE0QEEfyu9UOIYMqkEw==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-43668b7a1dfmr373083385e9.29.1735841508890; 
 Thu, 02 Jan 2025 10:11:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:2b1b:688c:df4:9c06:702e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm496278155e9.6.2025.01.02.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:11:47 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] efi_loader: install DXE services table
Date: Thu,  2 Jan 2025 19:11:32 +0100
Message-ID: <20250102181133.378867-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
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

The debug version of the UEFI shell requires a DXE services table to exist.

Implement the table and let all DXE functions return EFI_UNSUPPORTED.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_dxe.h          |  54 ++++++++++++
 include/efi_loader.h       |   7 ++
 lib/efi_loader/Kconfig     |   7 ++
 lib/efi_loader/Makefile    |   1 +
 lib/efi_loader/efi_dxe.c   | 176 +++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c |   6 ++
 6 files changed, 251 insertions(+)
 create mode 100644 include/efi_dxe.h
 create mode 100644 lib/efi_loader/efi_dxe.c

diff --git a/include/efi_dxe.h b/include/efi_dxe.h
new file mode 100644
index 00000000000..5623189de0c
--- /dev/null
+++ b/include/efi_dxe.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  DXE services table
+ *
+ *  Copyright (c) 2025 Heinrich Schuchardt
+ */
+
+#ifndef _EFI_DXE_H
+#define _EFI_DXE_H 1
+
+#include <efi.h>
+
+/**
+ * define DXE_SERVICES_SIGNATURE - DXE services signature ('DXE_SERV')
+ */
+#define DXE_SERVICES_SIGNATURE 0x565245535f455844
+/**
+ * define DXE_SERVICES_REVISION - DXE services revision (1.8)
+ */
+#define DXE_SERVICES_REVISION 0x00010050
+
+/**
+ * define EFI_DXE_SERVICES_TABLE_GUID - GUID of the EFI DXE services table
+ */
+#define EFI_DXE_SERVICES_TABLE_GUID \
+	EFI_GUID(0x5ad34ba, 0x6f02, 0x4214, \
+		 0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
+
+struct efi_dxe_services {
+	struct efi_table_hdr hdr;
+
+	efi_status_t (EFIAPI *add_memory_space)(void);
+	efi_status_t (EFIAPI *allocate_memory_space)(void);
+	efi_status_t (EFIAPI *free_memory_space)(void);
+	efi_status_t (EFIAPI *remove_memory_space)(void);
+	efi_status_t (EFIAPI *get_memory_space_descriptor)(void);
+	efi_status_t (EFIAPI *set_memory_space_attributes)(void);
+	efi_status_t (EFIAPI *get_memory_space_map)(void);
+	efi_status_t (EFIAPI *add_io_space)(void);
+	efi_status_t (EFIAPI *allocate_io_space)(void);
+	efi_status_t (EFIAPI *free_io_space)(void);
+	efi_status_t (EFIAPI *remove_io_space)(void);
+	efi_status_t (EFIAPI *get_io_space_descriptor)(void);
+	efi_status_t (EFIAPI *get_io_space_map)(void);
+	efi_status_t (EFIAPI *dispatch)(void);
+	efi_status_t (EFIAPI *schedule)(void);
+	efi_status_t (EFIAPI *trust)(void);
+	efi_status_t (EFIAPI *process_firmware_volume)(void);
+	efi_status_t (EFIAPI *set_memory_space_capabilities)(void);
+};
+
+extern efi_guid_t efi_dxe_services_table_guid;
+
+#endif /* _EFI_DXE_H */
diff --git a/include/efi_loader.h b/include/efi_loader.h
index c1258098217..d474866184f 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -663,6 +663,13 @@ efi_status_t efi_smbios_register(void);
  */
 efi_status_t efi_hob_list_register(void);
 
+/**
+ * efi_dxe_services_register() - install DXE services table
+ *
+ * Return:	status code
+ */
+efi_status_t efi_dxe_services_register(void);
+
 struct efi_simple_file_system_protocol *
 efi_fs_from_path(struct efi_device_path *fp);
 
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index ec38a0ea352..ed3470508ff 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -384,6 +384,13 @@ config EFI_DT_FIXUP
 	  The EFI device-tree fix-up protocol provides a function to let the
 	  firmware apply fix-ups. This may be used by boot loaders.
 
+config EFI_DXE
+	bool 'DXE services table'
+	default y
+	help
+	  Install the DXE services table. The debug version of the UEFI shell
+	  requires it.
+
 config EFI_LOADER_HII
 	bool "HII protocols"
 	default y
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 195ed8667fe..4f250f21811 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -33,6 +33,7 @@ obj-y += efi_console.o
 obj-y += efi_device_path.o
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
 obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
+obj-$(CONFIG_EFI_DXE) += efi_dxe.o
 obj-y += efi_dt_fixup.o
 obj-y += efi_fdt.o
 obj-y += efi_file.o
diff --git a/lib/efi_loader/efi_dxe.c b/lib/efi_loader/efi_dxe.c
new file mode 100644
index 00000000000..f8920575b0c
--- /dev/null
+++ b/lib/efi_loader/efi_dxe.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  DXE services table
+ *
+ *  Copyright (c) 2025 Heinrich Schuchardt
+ */
+
+#include <efi_dxe.h>
+#include <efi_loader.h>
+
+efi_guid_t efi_dxe_services_table_guid = EFI_DXE_SERVICES_TABLE_GUID;
+
+static efi_status_t EFIAPI add_memory_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI allocate_memory_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI free_memory_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI remove_memory_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI get_memory_space_descriptor(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI set_memory_space_attributes(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI get_memory_space_map(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI add_io_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI allocate_io_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI free_io_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI remove_io_space(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI get_io_space_descriptor(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI get_io_space_map(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI dispatch(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI schedule(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI trust(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI process_firmware_volume(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static efi_status_t EFIAPI set_memory_space_capabilities(void)
+{
+	EFI_ENTRY();
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+static struct efi_dxe_services efi_dxe_services = {
+	.hdr = {
+		.signature = DXE_SERVICES_SIGNATURE,
+		.revision = DXE_SERVICES_REVISION,
+		.headersize = sizeof(struct efi_dxe_services),
+	},
+	.add_memory_space = add_memory_space,
+	.allocate_memory_space = allocate_memory_space,
+	.free_memory_space = free_memory_space,
+	.remove_memory_space = remove_memory_space,
+	.get_memory_space_descriptor = get_memory_space_descriptor,
+	.set_memory_space_attributes = set_memory_space_attributes,
+	.get_memory_space_map = get_memory_space_map,
+	.add_io_space = add_io_space,
+	.allocate_io_space = allocate_io_space,
+	.free_io_space = free_io_space,
+	.remove_io_space = remove_io_space,
+	.get_io_space_descriptor = get_io_space_descriptor,
+	.get_io_space_map = get_io_space_map,
+	.dispatch = dispatch,
+	.schedule = schedule,
+	.trust = trust,
+	.process_firmware_volume = process_firmware_volume,
+	.set_memory_space_capabilities = set_memory_space_capabilities,
+};
+
+efi_status_t efi_dxe_services_register(void)
+{
+	struct efi_dxe_services *dxe;
+
+	dxe = efi_alloc(sizeof(struct efi_dxe_services));
+	if (!dxe)
+		return EFI_OUT_OF_RESOURCES;
+
+	memcpy(dxe, &efi_dxe_services, sizeof(struct efi_dxe_services));
+
+	return efi_install_configuration_table(&efi_dxe_services_table_guid, dxe);
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 393b690c3ee..796da5d5678 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -260,6 +260,12 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	if (IS_ENABLED(CONFIG_EFI_DXE)) {
+		ret = efi_dxe_services_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.47.1

