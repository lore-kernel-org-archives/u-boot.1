Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72776D3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867028919A;
	Tue, 29 Oct 2024 20:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjUxPYYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50305891AC; Tue, 29 Oct 2024 20:22:36 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4020289191
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so57915481fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229753; x=1730834553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lx0eESSUPcgWQ5AeNES/zyKJ1d7YeNCBq6nf5MAq3yk=;
 b=VjUxPYYKVKw93xficMV1TIm8wrtIVBFokb2+ugcHDizE10sv3gcwWpZfNuoCdlLJ19
 5XxzleIKnYn+eEXQcGAgdsFln6ki9o0CrLtu7fZNgGZSVoyxvYxCv4Rv/VzNPathCfY/
 BnUsnaOrUeabYrmIFgCar6dD93XQ0rptoB8FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229753; x=1730834553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lx0eESSUPcgWQ5AeNES/zyKJ1d7YeNCBq6nf5MAq3yk=;
 b=N25Um0l6RMEtnaG9f3bwbjABV4NVNyr/sSGCnmTazPiZ2kRlj4OiQVpzKModOzqlrx
 k1iD65ymJBnZIDK8TAMaQhf1Swq2UZC0/gXRIzUAq3Hv8QgunDophOVif+HY87CdhrOv
 RDkcdQFdHnZXUMAw7EJyYTURIBCbIgQDDc5kbs2BRQ9qexMgqYZlv7lzilF6ueA2ss7d
 1po8z6zqO8kyAS4sPbNg00PwBIYayDk8gLg/kMqL9g3J00aTq5eFF+f59mzjY2wOLEH1
 6p3MwN4T8uTxapNNWJkeJJf0QVrfwu2R/5c1EcOLTLhSfU9nTm3iKw06sPYYrTmXo2O+
 iBkA==
X-Gm-Message-State: AOJu0YzlNjvRhuft30KBuQBYGrtytNfcMHR/gtsK07GGNHBDR+WyYhVl
 T2zhBHa9IjCnwnvab6kzFBKycffBybDNY5BYjee/radl9/o6i2q9CVq//zIsQXvDr+/53yzIPJS
 pbJDY
X-Google-Smtp-Source: AGHT+IFFs7AtyiFr4ozdRcBoAiYGeYdoHYCwEjWcW3z3vErudhdYLaTA1VLugwLax16ZIDBcr/OusA==
X-Received: by 2002:a05:651c:b20:b0:2fa:c0fc:e3d8 with SMTP id
 38308e7fff4ca-2fd059ea07cmr5061551fa.38.1730229752453; 
 Tue, 29 Oct 2024 12:22:32 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v9 02/11] efi_loader: Add a test app
Date: Tue, 29 Oct 2024 20:22:10 +0100
Message-ID: <20241029192222.362445-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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
completely disconnect from U-Boot. However, since this is a test, we
need to check the results of running the app, so returning is necessary.
It works correctly and it provides a nice model of how to test the EFI
code in a simple way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Update license
- Fix 'sevices' typo

Changes in v7:
- Update commit message

 lib/efi_loader/Kconfig   | 10 ++++++
 lib/efi_loader/Makefile  |  1 +
 lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
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
index 00000000000..a28fc17ce5b
--- /dev/null
+++ b/lib/efi_loader/testapp.c
@@ -0,0 +1,68 @@
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
+	con_out->output_string(con_out, u"Exiting boot services\n");
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
2.43.0

