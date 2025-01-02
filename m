Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9174E77194
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E530580374;
	Thu,  2 Jan 2025 19:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qkZca+Vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11918034E; Thu,  2 Jan 2025 19:11:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D1D80196
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 19:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5787540FA9
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735841506;
 bh=V1TWgQGRxgNvjJqgcKLU+h+9Ks9EI8tJVWvs3AI/rJE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qkZca+Vvay2S5CWBtHsXdsD1ZrPcH525PcteAWgiw6HOkpoCJag0enjHA3GC1Ye3g
 ISXDgMjK+/u1D0gkREVRiqR48mUDY+I5k9P3gA61ZjN7CxD/qMMWoCuXQqeu6YQgK/
 KycYj2lODhpmc3IcNHDzd58Fl8KtZTLR4UMLAN82uNYxRqyqu7W5kXIEDy8COo6DGr
 YPIrodLP4Yht9iVIz/5LAdYXVO8lyeOBprCbK14cHbZ81Pm0jFHj5InnfwvnfxyVWu
 0+llO0vHVPgpxeaRjAOnjsVdQ1goS0uPS1GWz0eO/cuKKrdxdAXKBK7/4xvxR+M/fJ
 VDFUsXcHEmcyQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38a684a0971so74947f8f.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 10:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841505; x=1736446305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1TWgQGRxgNvjJqgcKLU+h+9Ks9EI8tJVWvs3AI/rJE=;
 b=KaSfaU+LvjO0iz0hD1QQLZOGSL/l2ugyZ3Dd+hRDmAh/LiFyeUWFay+I3zpEDYhJ2P
 MXPzJ9wm7QHMzI6uxpWUIzkg4J6um+Ucm+ojV87AhIDWNu87iLeTMQ4ARj5cSGNgqrMH
 p2xyvdYEEvokg0bJD48kUXKxfQJw259A4Dxqql6BxXRQVNwzOgHZ/ks9grjiaWAEOybm
 tGlFxViKvJcRzrJdbxqNZShPjDYr8J3dLd2xbHvzA2q8zWNDq0tHC6hGUQKmvRybY/Dr
 82mjZvssiZBNdcQOAiWrhXjVSz+oQzuK3knuj2NVEiJSGtOxKnHRcfAkU3S0BED6fXDy
 q1EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl9afAczj+hwSIOnadPRCHrravKLQuT/H9Pp2joRIs+eHZN5P6iAE+VpV08kOurMNzz7UHXKE=@lists.denx.de
X-Gm-Message-State: AOJu0YymIpoHdxo/KSv5IkFomNCM66gj7xt+am+ARjNxO66jrIFY4aC4
 NxstwiPnQgYajeXLsUhS90DsTeULjwbJNp2G7kPxAWODG9VSP/BJi3XpRxJHAUqzDZ4Q0P6FXC8
 t/ne1Uf4F/GlxCobUuAKnUvfwGD5ENOKl2EEIEZjr7EA5aqQzVWgDQQwrljrA/P7Aj6M=
X-Gm-Gg: ASbGncvbflQddn0wT0cTCNKtu+VZAzsS9Fi/CZtsiLFkL1tI3UwwTcRuAghSfeLr3jj
 n4y/Z/GC77hG4TAwXyFEzhU+SGVYRplp5nwkprDjIC/UzrU1kkuHKI0/DXBsaqpenc4L6hhJgqn
 vHLo8AwOZJbZR789/tBNPZzeMVhDUEz6nDXNH83WcG3DA1TTHv9VWV6INOxq16AxaL9R0GSPlXi
 6v84uHKbtk00dnCuXrIpC0M5r4CsZqgf9Hi8t8SjX+cM2e+Uk01togB1vS1OFxUkbFuPhe3BZqm
 jdGAWgTmayh7ow==
X-Received: by 2002:a05:6000:1848:b0:38a:19a4:ca9e with SMTP id
 ffacd0b85a97d-38a221f2d57mr39625934f8f.29.1735841505663; 
 Thu, 02 Jan 2025 10:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOdiJ5XTefWlFdmAPzPla2psyu70ctrY6CBH9/FpkSETZMX1MAKQtcMbXLL3uoQgC0EXzxog==
X-Received: by 2002:a05:6000:1848:b0:38a:19a4:ca9e with SMTP id
 ffacd0b85a97d-38a221f2d57mr39625917f8f.29.1735841505329; 
 Thu, 02 Jan 2025 10:11:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:2b1b:688c:df4:9c06:702e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm496278155e9.6.2025.01.02.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:11:44 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] efi_loader: implement a HOB list
Date: Thu,  2 Jan 2025 19:11:30 +0100
Message-ID: <20250102181133.378867-2-heinrich.schuchardt@canonical.com>
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

The debug version of the UEFI shell on x86 requires a HOB list.
This implementation allows to generate an empty HOB list.

Generate the HOB list on the sandbox and on x86 by default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_hob.h          | 32 ++++++++++++++++++++++++++++++++
 include/efi_loader.h       |  9 +++++++++
 lib/efi_loader/Kconfig     |  8 ++++++++
 lib/efi_loader/Makefile    |  1 +
 lib/efi_loader/efi_hob.c   | 33 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c |  7 +++++++
 6 files changed, 90 insertions(+)
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
index 9afbec35ebf..c1258098217 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -654,6 +654,15 @@ efi_status_t efi_acpi_register(void);
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
index c46ffe3a9d8..ec38a0ea352 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -395,6 +395,14 @@ config EFI_LOADER_HII
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
index 2a0b4172bd7..7d1f04e9fbd 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -37,6 +37,7 @@ obj-y += efi_dt_fixup.o
 obj-y += efi_fdt.o
 obj-y += efi_file.o
 obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
+obj-$(CONFIG_EFI_HOB) += efi_hob.o
 obj-y += efi_image_loader.o
 obj-y += efi_load_options.o
 obj-y += efi_memory.o
diff --git a/lib/efi_loader/efi_hob.c b/lib/efi_loader/efi_hob.c
new file mode 100644
index 00000000000..6a1365bd817
--- /dev/null
+++ b/lib/efi_loader/efi_hob.c
@@ -0,0 +1,33 @@
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
+
+	hob = efi_alloc(sizeof(struct efi_hob_header));
+	if (!hob)
+		return EFI_OUT_OF_RESOURCES;
+
+	hob->hob_type = EFI_HOB_TYPE_END_OF_HOB_LIST;
+	hob->hob_length = sizeof(struct efi_hob_header);
+	hob->reserved = 0;
+
+	return efi_install_configuration_table(&efi_guid_hob_list, hob);
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..393b690c3ee 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_hob.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
@@ -271,6 +272,12 @@ efi_status_t efi_init_obj_list(void)
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
2.47.1

