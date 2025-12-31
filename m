Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11666EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 10:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18C9183FF9;
	Wed, 31 Dec 2025 11:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ePk8UF9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A588401F; Wed, 31 Dec 2025 11:48:23 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A70483F93
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A972B3F2A3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767178100;
 bh=/xMINyjZ3IFFvhu5RiHVB1wooqei9HjZHZ0Gw5G1JZw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ePk8UF9xq6NVWPEBllkWgnAfEJ7gU4cnxbxfm2oDfOE47hZUmiYk91XHUI680OChp
 RKnC7n2KczPVZHjW9uR+gCz6FuHJYDXRz7z1OUdxZ/4qjjsxgHWr3EDJ3sIny8KJW2
 DMhfM7d7EX7xOigaWOe+O2joVo26E3P04o+7/dO6SpJp9dqFVjG9mnn7trm6AOj0zP
 wZbpo8Lrj9dl3MgvK+iytrh8R5N4y1FflQKsEF+vxzBVnZwcULGj9y00yomFIucsO/
 EVQdmw/SaiVdK0RyhFKHEi5LsJDcv31GCRyOO+uFgdCyPSOHO+1B4fpLzhvtGyEHQw
 Zkp4Yw0SyqY8VTr6epd/6CkF5J65d0WlQkJFmnjkwM6VvYwj9k3n4vt82ZlZvtuSTj
 rj9oIrTEIjP2wQy4f6mo/no69sCZnsoSLKjR/bRhl02b3IGAhXywMmqAIDoNX7rYbb
 wq/VDufWFWP5cdNB0lMv84So1rLcYSTGCbrp+Otq6aTk04/mg4VVTXqX9uN9FuiWqj
 r2jYv3elXAZQqC5j2LHstvRddsedW58BJtuIVlfiqfqkPOEeYnlN1NtoWlpshj0o05
 1buA6O1lAcqndZetx+pvvIvC8iuk1nSzsko+BRV6g6xq8cPb3Jm0DoC+hBILfmocLe
 k+h4BvHN92U27VcNn6nPCuCs=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso8327355f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 02:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767178100; x=1767782900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xMINyjZ3IFFvhu5RiHVB1wooqei9HjZHZ0Gw5G1JZw=;
 b=cLd0Eak6bK1qs28BLfT4gAYuW6BvlG0l5gh3b2zxhxiaDDWC42tWzdPRJsTQAmgdqQ
 bb+/ZKNsnvH08KGr5H6A6MyWrT4ZYFA7ObGTfu5ATSgFCfK+GkCXjdXhyQd+jiJQsTTI
 mFhIyZoSHi/8jzx+0gA+Ulfi6pAhri2YfdmcJAea3GHuLAG9Wp1M6h1lJ7Nh9xDn2qum
 UGlI6LG5O0rCvxAXGFbBrvaiWT0j4s/dwxqT30+rCa3JRYHQ6Y+bw1fStYSAqSCZQHgw
 1hONMHAU8OU/d4u5R66CCrHcHnL1adi0d0OGveF2zvmHOHTtr30dnqDnqQrq6ywgBMFi
 lFTA==
X-Gm-Message-State: AOJu0YwsflUeNpWYDiJBC2dJv9ZoHALnPbDH/6NMjgjyi6D7DDka5A0Q
 kYJffigtYov/wp/dck6+rfEZ6MXkbtmtm0Qsr/TwG84rORmZ9GaMrInmouNy0LJlwcWiff9OMFt
 vv0sT5G0SvPy7Ek8rUgEYE27R/pSwd9QOtRke/3DgeBeNzg7vk4/HtRAgFOXv7ghYAXE1s5k=
X-Gm-Gg: AY/fxX7BhwpiVarXgLuiWTGycn/yB2kEhMJq++HCUxd0v17KraqJ+mSMVLw+m1U94FP
 6F6znU/L+sYgh2RvlSJSWqPGQZtqAot5SjTJx2Ph/naa3qTeaMkpHkHmy+nt9ouLshsahcB+vvY
 xpf2lxrIgp+a2drrRyHo2Xfya8BuJxlmITPI/OudVUmWQ5zfMO65PYOhMq3UlmXf/Wm4huuXx6X
 A+5DREeHR2KKMdJYIieKRLRTJu4+KqAV3yekuqZ8/zMe4LWseSu8EqBfazZV4X/GgCBy6N/p8Jp
 +GNnHhrOTo6XAiIe5yrXC7sm1HEcfqRb5OVWaIOSdCl++v8QLdXcrYfQsYOgjNFiz+zljClAyM9
 c0aDL1b9q0xTD5KJ1/LcC3SmjoUiraASvuKZuNLTdQabOPiVFBAcFt2O4b7iXL2c/AplHXF11u8
 W7
X-Received: by 2002:a05:6000:40dc:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-4325bac3a19mr39802818f8f.39.1767178100146; 
 Wed, 31 Dec 2025 02:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEctWUezTWYSXnQDC3wSHEv2cz9x22G+aD/IGwpzyII5jU0C1D4fGbdxlnQPFxn2Upx+mKPCw==
X-Received: by 2002:a05:6000:40dc:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-4325bac3a19mr39802799f8f.39.1767178099741; 
 Wed, 31 Dec 2025 02:48:19 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm73928483f8f.28.2025.12.31.02.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 02:48:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: implement a HOB list
Date: Wed, 31 Dec 2025 11:47:26 +0100
Message-ID: <20251231104726.14633-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The debug version of the UEFI shell on x86 requires a HOB list.
This implementation allows to generate an empty HOB list.

Generate the HOB list on the sandbox and on x86 by default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Free allocated memory if efi_install_configuration_table() fails.
---
 include/efi_hob.h          | 32 ++++++++++++++++++++++++++++++++
 include/efi_loader.h       |  9 +++++++++
 lib/efi_loader/Kconfig     |  8 ++++++++
 lib/efi_loader/Makefile    |  1 +
 lib/efi_loader/efi_hob.c   | 38 ++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c |  7 +++++++
 6 files changed, 95 insertions(+)
 create mode 100644 include/efi_hob.h
 create mode 100644 lib/efi_loader/efi_hob.c

diff --git a/include/efi_hob.h b/include/efi_hob.h
new file mode 100644
index 00000000000..b401e6c2fa1
--- /dev/null
+++ b/include/efi_hob.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  HOB list
+ *
+ *  Copyright (c) 2025 Heinrich Schuchardt
+ */
+
+#ifndef _EFI_HOB_H
+#define _EFI_HOB_H 1
+
+#include <efi.h>
+
+/**
+ * define EFI_HOB_TYPE_END_OF_HOB_LIST - end of hob list
+ */
+#define EFI_HOB_TYPE_END_OF_HOB_LIST	0xFFFF
+
+/**
+ * struct efi_hob_header - EFI_HOB_GENERIC_HEADER
+ */
+struct efi_hob_header {
+	/** @hob_type:		type of HOB data structure */
+	u16 hob_type;
+	/** @hob_length:	HOB length including header in bytes */
+	u16 hob_length;
+	/** @reserved:		always 0 */
+	u32 reserved;
+};
+
+extern const efi_guid_t efi_guid_hob_list;
+
+#endif /* _EFI_HOB_H */
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac07055..6183da64196 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -714,6 +714,15 @@ efi_status_t efi_acpi_register(void);
  */
 efi_status_t efi_smbios_register(void);
 
+/**
+ * efi_hob_list_register() - install HOB list
+ *
+ * The EFI shell on X86 requires a HOB list
+ *
+ * Return:	status code
+ */
+efi_status_t efi_hob_list_register(void);
+
 struct efi_simple_file_system_protocol *
 efi_fs_from_path(struct efi_device_path *fp);
 
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d06..b4f0d1dc23a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -406,6 +406,14 @@ config EFI_LOADER_HII
 	  U-Boot implements enough of its features to be able to run the UEFI
 	  Shell, but not more than that.
 
+config EFI_HOB
+	bool 'HOB list'
+	default y if SANDBOX || X86
+	help
+	  Install a HOB list. The UEFI shell on x86 requires a HOB list
+	  to be present. Our list is empty as we don't implement the
+	  UEFI Platform Initialization Specification.
+
 config EFI_UNICODE_COLLATION_PROTOCOL2
 	bool "Unicode collation protocol"
 	default y
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index bfa607c8827..f010101125f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -39,6 +39,7 @@ obj-y += efi_dt_fixup.o
 obj-y += efi_fdt.o
 obj-y += efi_file.o
 obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o efi_hii_config.o
+obj-$(CONFIG_EFI_HOB) += efi_hob.o
 obj-y += efi_image_loader.o
 obj-y += efi_load_options.o
 obj-y += efi_memory.o
diff --git a/lib/efi_loader/efi_hob.c b/lib/efi_loader/efi_hob.c
new file mode 100644
index 00000000000..f15439d31e0
--- /dev/null
+++ b/lib/efi_loader/efi_hob.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Provide HOB list
+ *
+ *  Copyright (c) 2025 Heinrich Schuchardt
+ */
+
+#include <efi_hob.h>
+#include <efi_loader.h>
+
+const efi_guid_t efi_guid_hob_list = EFI_HOB_LIST;
+
+/**
+ * efi_hob_list_register() - install HOB list
+ *
+ * The EFI shell on X86 requires a HOB list
+ *
+ * Return:	status code
+ */
+efi_status_t efi_hob_list_register(void)
+{
+	struct efi_hob_header *hob;
+	efi_status_t ret;
+
+	hob = efi_alloc(sizeof(struct efi_hob_header));
+	if (!hob)
+		return EFI_OUT_OF_RESOURCES;
+
+	hob->hob_type = EFI_HOB_TYPE_END_OF_HOB_LIST;
+	hob->hob_length = sizeof(struct efi_hob_header);
+	hob->reserved = 0;
+
+	ret = efi_install_configuration_table(&efi_guid_hob_list, hob);
+	if (ret != EFI_SUCCESS)
+		efi_free_pool(hob);
+
+	return ret;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f06cf49e443..e9b6ffd27b8 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_hob.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
@@ -308,6 +309,12 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 
+	if (IS_ENABLED(CONFIG_EFI_HOB)) {
+		ret = efi_hob_list_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		ret = efi_tcg2_register();
 		if (ret != EFI_SUCCESS)
-- 
2.51.0

