Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C95E6F06B
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F207E88CC9;
	Fri,  1 Nov 2024 16:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SX90xGCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C11892C6; Fri,  1 Nov 2024 16:26:29 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16245889EB
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso34260151fa.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474785; x=1731079585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MLwUEwpwAPcm3DdRqhIpLtME9Je19XPrbtX3c8w4o4=;
 b=SX90xGCGg1vfCkavyf0+LC2eqpbx49ZBE414uci9ea55hmlQD5PU5D0DzzrsG+dZ6D
 C74seVIHdrEnt1wvd3p6qKjTyaG4VcwJA7oXixVOMyuxB78iG5lPdyZKE0lujX4IaNos
 FTjKwx044H+dsT6TlVF2FBlQZcJZYdVExSm14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474785; x=1731079585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MLwUEwpwAPcm3DdRqhIpLtME9Je19XPrbtX3c8w4o4=;
 b=SFNLRdRQPq+GP8XfkfBMfv/JoPNqpoNkVaEOiJ7hV65kFSw51tThT0s2VqfkYNLI+S
 y63jSZPV/kd1pg9mULyA1UDrdnTOZX7DTmLiRGeg9wEnDZhw3gEtZot5eAMpKVAlf9m3
 2vkx+xrGWnfoTwWyP+T9Xgi2MjbCj6xKMrjLALI8+LangwubPz162VBXFJGmzcg4Gx2p
 qdGncVMTbVxO4LSSTJX3Agq/7znFjKVdH4qIw8eLKapLMaoFe7MPee9QUghv40KOjGry
 qWeyGc0cX1964RVNsK9SvgK8LTl2kiIfDFGIQB4L6GZzJ/SHmCZ5/jMC38H7dA81Rc+X
 +HoA==
X-Gm-Message-State: AOJu0Yz6JSS2q3czb+dm50/7bQXWQM8QZcg5O03usDqPtKZVoWx28TCV
 JnInUmgfnB5cWCLsVAhCNofrqbzZD9rtSriWPSqGz9GxFKs3P/t/EcRPS44LDY/POU2dxUWl2P+
 NGBY4
X-Google-Smtp-Source: AGHT+IGZgTOHsSd+IXUT4WiOPj0GqenRAM3Z/EWCLkCKHCZPe2M9oMbmiurMcMr/iWoGWWcLjaP0PQ==
X-Received: by 2002:a05:651c:220d:b0:2fb:6509:b6ba with SMTP id
 38308e7fff4ca-2fedb813ba8mr36126751fa.33.1730474785365; 
 Fri, 01 Nov 2024 08:26:25 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v9 02/11] efi_loader: Add a test app
Date: Fri,  1 Nov 2024 16:26:00 +0100
Message-ID: <20241101152614.238747-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

Add a simple app to use for testing. This is intended to do whatever it
needs to for testing purposes. For now it just prints a message and
exits boot services.

There was a considerable amount of discussion about whether it is OK to
call exit-boot-services and then return to U-Boot. This is not normally
done in a real application, since exit-boot-services is used to
completely disconnect from U-Boot. For now, this part is skipped.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v10:
- Drop call to exit-boot-services

Changes in v9:
- Update license
- Fix 'sevices' typo

Changes in v7:
- Update commit message

 lib/efi_loader/Kconfig   | 10 +++++++
 lib/efi_loader/Makefile  |  1 +
 lib/efi_loader/testapp.c | 64 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 lib/efi_loader/testapp.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 37572c82f54..44319729bda 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -584,6 +584,16 @@ config BOOTEFI_HELLO_COMPILE
 	  No additional space will be required in the resulting U-Boot binary
 	  when this option is enabled.
 
+config BOOTEFI_TESTAPP_COMPILE
+	bool "Compile an EFI test app for testing"
+	default y
+	help
+	  This compiles an app designed for testing. It is packed into an image
+	  by the test.py testing frame in the setup_efi_image() function.
+
+	  No additional space will be required in the resulting U-Boot binary
+	  when this option is enabled.
+
 endif
 
 source "lib/efi/Kconfig"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8ec240cb864..7c8b2dd1ad6 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 apps-y += dtbdump
 endif
+apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
 obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
new file mode 100644
index 00000000000..1a2f9ef9b6c
--- /dev/null
+++ b/lib/efi_loader/testapp.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hello world EFI application
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ *
+ * This test program is used to test the invocation of an EFI application.
+ * It writes a few messages to the console and then exits boot services
+ */
+
+#include <efi_api.h>
+
+static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
+
+static struct efi_system_table *systable;
+static struct efi_boot_services *boottime;
+static struct efi_simple_text_output_protocol *con_out;
+
+/**
+ * efi_main() - entry point of the EFI application.
+ *
+ * @handle:	handle of the loaded image
+ * @systab:	system table
+ * Return:	status code
+ */
+efi_status_t EFIAPI efi_main(efi_handle_t handle,
+			     struct efi_system_table *systab)
+{
+	struct efi_loaded_image *loaded_image;
+	efi_status_t ret;
+
+	systable = systab;
+	boottime = systable->boottime;
+	con_out = systable->con_out;
+
+	/* Get the loaded image protocol */
+	ret = boottime->open_protocol(handle, &loaded_image_guid,
+				      (void **)&loaded_image, NULL, NULL,
+				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS) {
+		con_out->output_string
+			(con_out, u"Cannot open loaded image protocol\r\n");
+		goto out;
+	}
+
+	/* UEFI requires CR LF */
+	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
+
+out:
+	/*
+	 * TODO: exit boot services so that this part of U-Boot can be tested
+	 *
+	 * map_size = 0;
+	 * ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+	 *			       &desc_version);
+	 * boottime->exit_boot_services(handle, map_key);
+	 */
+	con_out->output_string(con_out, u"Exiting test app\n");
+	ret = boottime->exit(handle, ret, 0, NULL);
+
+	/* We should never arrive here */
+	return ret;
+}
-- 
2.43.0

