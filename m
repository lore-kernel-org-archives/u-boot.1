Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C281D3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9C2892B9;
	Sat, 19 Oct 2024 17:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KG5g5bha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B159F89351; Sat, 19 Oct 2024 17:25:09 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2CD87D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so10868425ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351505; x=1729956305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAOVfrNIob9G4EUgJG7Jf+ZAXVoxN2S09C4J/QX0aP4=;
 b=KG5g5bha3+qy4jTOAeddsXsPbBJtrR3oizQMK/YvlVvrpJKHpLXt8V8DjaZTlpAbvi
 SUpHvp1Ppa1vwj5q21g0lg376LaXQq9kXoodzSPpzzU5DmSzyCrsoleb2kmjEA65JHjR
 XlnlspuMY4Jd5RFC9cbuMX4WdhHe9R3Wi2nyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351505; x=1729956305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAOVfrNIob9G4EUgJG7Jf+ZAXVoxN2S09C4J/QX0aP4=;
 b=nUYo51rswo5nquTxbYIYsEnKOfd34SHRDBlGnB1iyHQma9uNE28J+q6g7wnLGWkms/
 F+qb4O1Q1bwdcSxyroYOeymET2YlgANCwr0WNR/95uwxZqVUy0SKkaqNmKydiPhnJ4/v
 LLG3GX8silEZyLY7kkrTQB2wl3kZO9E52/OOKc6nUft7z15yReCGQAStwP6TB5fVDts/
 y5sS2LB0RipOtkaBW3qq1lbB8vO3JzN9jTToEsOHc8feitwfPpsds+b3bFWnwq4Eecio
 n3n6EG630NrwTIE3ejbeJ1gkL1URWIA/D6OvyTV/Sb6YX/biCOlDYUkR81/dprkHpGm5
 99MA==
X-Gm-Message-State: AOJu0Yz1aba+ah3fDbQtiTSsi6RgLW93uKbiJacKlorRsvug9LcSGUS1
 58uqw5mg5u4F4nGDN3L4Py2iJ4R9CxOsRhOZ0uyzZ9lh734XqyfCdHx4vX4oq8lX5L8KDDeQLzI
 =
X-Google-Smtp-Source: AGHT+IEg3LaGweD60pqujeebPHjo3+j9sIq0onub7sRdaJamZtckKH68qJ/Mx8DecVO37b5lnOKKjA==
X-Received: by 2002:a92:cda4:0:b0:3a3:b4ec:b3f1 with SMTP id
 e9e14a558f8ab-3a3f40ab54cmr55420065ab.17.1729351505397; 
 Sat, 19 Oct 2024 08:25:05 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v7 4/7] efi_loader: Add a test app
Date: Sat, 19 Oct 2024 09:24:31 -0600
Message-Id: <20241019152434.1017394-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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

Changes in v7:
- Update commit message

 lib/efi_loader/Kconfig   | 10 ++++++
 lib/efi_loader/Makefile  |  1 +
 lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 lib/efi_loader/testapp.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 69b2c9360d8..6ced29da719 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
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

