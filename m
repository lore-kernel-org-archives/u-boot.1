Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB2C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462D988AF4;
	Thu, 15 Aug 2024 22:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="khyOZdEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0C78870B; Thu, 15 Aug 2024 22:24:49 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D1288AD6
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so51729539f.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753477; x=1724358277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlZkCax0JTI7O6Xx7eXrCZ1Ss/UmtibuO9+isV4O2ng=;
 b=khyOZdEkwyBQeUJ38MX2aehgYajvs0+GX3VZrGI5SpLmNdpltaqcJiZKR5hsS9mg0v
 dCbpOR7lCUCsw31ya9a+BuyC/0iqp99Iwsi4MMeGFCE2fMao6SmfndYb12D0IwXyyuPj
 6Uqz20jS8Zh69YSCk5mO02RQf/ezHXunCjtzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753477; x=1724358277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlZkCax0JTI7O6Xx7eXrCZ1Ss/UmtibuO9+isV4O2ng=;
 b=oR2L4WusjiM/64Bpv0nopJCY3TBBVq+49+8kCe2oSLOTjh3yx8TWO9PSgTxsvnjxQh
 BYlk72Fts5josSMqDetshYGb4pdm5oLGsgAjqRN9k9gBiTBkou5x7V+rqKxvOPmlY8mz
 Tvtn4aqmbawP6xa5J+N9uljiUpDT8MsRUD+82psiuJ067TIwrDpS3QIvC/mZFXmYZKY9
 UjFsMuHK2bGN5a0TC9z72U7SQ2lk+0a6fnDXi84z2x1tV1DieSRw1YlAxthUzoGaGuuN
 p+/w6A1nFeXCE7DXGl3Ip8hndP99HanXxfoGFOcMpLcZDMM3086RtKw1I0hVtnp02/nA
 I6/w==
X-Gm-Message-State: AOJu0YwNqSpW/mmPS79N+ZageYj/0QXtUxwbuUUAPH7yFLr8hRb58b6e
 8JTPcEDoNm21KwSKXtkZAmDrrzynwdXk25A5cigOftzhnfa0ksjlgZg1Mh6ZUWTiiOMl+E1uGkK
 uSA==
X-Google-Smtp-Source: AGHT+IHEFwUNd595V9ucjeL6Mep2Gv9FfsNHINY+gcywNPP8r6dv93ZdpGoKFZJSvjK8uZ5xYtJFVQ==
X-Received: by 2002:a05:6e02:1989:b0:39b:37b9:6a8f with SMTP id
 e9e14a558f8ab-39d26ce3e38mr12108775ab.7.1723753476888; 
 Thu, 15 Aug 2024 13:24:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 11/14] efi_loader: Add a test app
Date: Thu, 15 Aug 2024 14:24:21 -0600
Message-Id: <20240815202424.766778-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

