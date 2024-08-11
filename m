Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B0C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2E288C51;
	Sun, 11 Aug 2024 16:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gBNuPSa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021B388C4D; Sun, 11 Aug 2024 16:53:07 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD126889E3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39b40ab3210so13413755ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387978; x=1723992778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlZkCax0JTI7O6Xx7eXrCZ1Ss/UmtibuO9+isV4O2ng=;
 b=gBNuPSa8o1Od/u03tktn3v6S1T0QW3snHtofTVPQfqQUe7s6la+PfOWvMqfviA6P5A
 +4ozjbIiCnBm9HSm+lmVYMoHe9FWRbRo2x11a2ju5f8dqIfLMNNlicIK2BeH85B/pQlk
 TS760Qw7s+HYrJKMFOII+SjUXpOWNrc+ckyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387978; x=1723992778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlZkCax0JTI7O6Xx7eXrCZ1Ss/UmtibuO9+isV4O2ng=;
 b=mX0gyXDJSvLkCAOxuu4xzuWCTc8jCiuv7JrvR0QJfkXvRgVVxzFrVqHpc1fc0YjFkO
 FBYGO9dFjIimPnE/IFMgsB6VIS0KYHgwRpPm8IQFVhNsWV6OlWklU2zUvHiIG85CVy/q
 hy/68uRl1ph1dRxT2yBePk7dZSUIywwqfb2LyioULFnGc7X+7uOIJlGQmcHGg1MAG9gQ
 ODeRPtd/qv+Kn5Qo0gVgbGO148c9JTR9s8xsVJoded4SyBirUOIYW54HsgRKQ7xpZqZL
 3+KI2BbvRHh8zacXYtOYCT1adyIC/zKTsMXrkwH/UoSTDiSlHTAr9jsrJjRw9EQGjF9u
 FZcQ==
X-Gm-Message-State: AOJu0YwpmfDondCBCGHWx/q1KbINYCh0DXH5ulsMyoRb4lHOAbyg5ZxG
 7svsxBr9s+ATGgXCwCNoKObXODbIu+q80o+yt7r6NEGaPMaHxMMm34cJ5dRmNyveOBjR2LSrw2U
 =
X-Google-Smtp-Source: AGHT+IHtzC3GnsRLqfO6KDTrb6XIotYDEKifKL4hFP0aPQX+ClYcWMXeb7qcWruJNOL0IvVU0aZGxA==
X-Received: by 2002:a92:cd8d:0:b0:398:16d1:610b with SMTP id
 e9e14a558f8ab-39b6c11b903mr107666255ab.0.1723387978497; 
 Sun, 11 Aug 2024 07:52:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 37/40] efi: Add a test app
Date: Sun, 11 Aug 2024 08:52:06 -0600
Message-Id: <20240811145209.4191404-38-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/Kconfig   | 10 ++++++
 lib/efi_loader/Makefile  |  1 +
 lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 lib/efi_loader/testapp.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index ab2c1c44364..4de05c6f2d6 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
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
index 00000000000..feb444c92e9
--- /dev/null
+++ b/lib/efi_loader/testapp.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+	efi_uintn_t map_size;
+	efi_uintn_t map_key;
+	efi_uintn_t desc_size;
+	u32 desc_version;
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
+	map_size = 0;
+	ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+				       &desc_version);
+	con_out->output_string(con_out, u"Exiting boot sevices\n");
+
+	/* exit boot services so that this part of U-Boot can be tested */
+	boottime->exit_boot_services(handle, map_key);
+
+	/* now exit for real */
+	ret = boottime->exit(handle, ret, 0, NULL);
+
+	/* We should never arrive here */
+	return ret;
+}
-- 
2.34.1

