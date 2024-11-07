Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381DBD5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948BE88901;
	Thu,  7 Nov 2024 22:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrGy00sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA53988DB2; Thu,  7 Nov 2024 22:32:05 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A9B8878A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6bc0600f9so5647035ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015122; x=1731619922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrE0taTI7pdVEJdlucuJEWGPP0bBZAvBX82ok3msXOE=;
 b=FrGy00saFfRAxGN2pg+dbcSn6KISSrrU93cFti+6gXlY6jS7NKfuPcmHW9IzcAXpgD
 JZ80ZCBO9VrgcD5+UJewy9B1KMpQrhToTyElSuvGGnGFcbvrvnB/Ycyh/c3aXctRsl0W
 mxxdp7H7U/KBzlMLO63Z20YoDvSIsBNQBMcEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015122; x=1731619922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrE0taTI7pdVEJdlucuJEWGPP0bBZAvBX82ok3msXOE=;
 b=wxU+ZF7QeWrWsEnhFjzpaapBiQ7mHvu7X7+pwsJUvRBgqLFhY54p/b+zxZoQplLj6b
 Wn/tO/wvPhtt1wSXgj7VuYRm2r4DopFYbtC6QFHuGfFZd6su2KrQ296nYUI5z1kmR73I
 whCj9nWHLM/BMgw3bsdH+9VKqkjsnYCTAH4ZMNL+ed2XV656f3I1WEw4mnUInjgZaBSr
 EMQk1RBFih1glKuDt2Jo01ZKo66BSM5qhi3jkTblhW3HIGsKBRoKdDovbSYQnOWSOx+v
 xxP3vBY+w0+uvERhuCA67cT2M4ZvV/fbxTCm2ozCd+Dp1SeoGtOWZQH7SuFK4wlipXiw
 TPyA==
X-Gm-Message-State: AOJu0YxvnTIDV0Ag/hJts6POsgHj+d4yiRqgiVmZDLqP/+Ac3I+LdcII
 QVzGkBgHOSS3rVhN6I1TgFUaTK2CnHTJhwdXdXNHO6/XgmdaFuN1+p7C5m6HURw/qLOLh9gpZhc
 =
X-Google-Smtp-Source: AGHT+IEREL9cIjDlUrfGYR/UC5lSvBKwQzGCmHtG+mHQfhvaQVoPAxEIKqAQdUhOPbUba2N58xT78A==
X-Received: by 2002:a92:c264:0:b0:3a6:bb77:a362 with SMTP id
 e9e14a558f8ab-3a6f199037bmr9698495ab.4.1731015121828; 
 Thu, 07 Nov 2024 13:32:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v10 01/10] efi_loader: Add a test app
Date: Thu,  7 Nov 2024 14:31:41 -0700
Message-Id: <20241107213150.1711962-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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
index 066f0ca0da7..58d49789f12 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -567,6 +567,16 @@ config BOOTEFI_HELLO_COMPILE
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
index 00d18966f9e..87131ab911d 100644
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
2.34.1

