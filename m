Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90D0C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A913D87587;
	Tue, 21 Nov 2023 02:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zjeFWMf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E883D87584; Tue, 21 Nov 2023 02:30:45 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4C6863FD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ca85ff26afso8802195ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530236; x=1701135036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlJe6g/MGmxeo7thBlyeM3f/K57ZCfoKPQB8Mjgnljw=;
 b=zjeFWMf1r0iWvd9/3/J1j51PADZGHFXZ73yO5I2tTPFzRJPkI8Zx/Sy9iXEeHwdKtX
 4uA46QuS0Kd2OyFmsBBAntqi7hRgH2awsdlblUiLDrojI5p47BEnu4ra1zjV2xmTF9nh
 atZKvHO/1N/xpmVJrXpbdvsh5Eqqu+BSm0keVArygAchHIXwJZk/ZhsbUxmfBs0Wq94e
 44zoHS8xbwLBXJwiE7nS4ds0ZBbeJIKjjs4qYuej6R+U7cgpmeQYFLo3xGx7p2ClP7XT
 sEk8bHC/Cewnge3k7qNJNQgx3jj6WkwsW1dB266FiCvP0A1wV+tgt268tPXeCoyoz2HD
 QgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530236; x=1701135036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlJe6g/MGmxeo7thBlyeM3f/K57ZCfoKPQB8Mjgnljw=;
 b=h8/HlvjdU9GuRWkDYyLYIj1kd7XAUVjeaCGQOBI1Hf8LFf7pSR7VuylxjaLKcDAipL
 02rbswBx6DxJ8Loe1ayCse0bgr4kiWs7n2GAZFMrBwKoW45aqdWZY/C+/TGcBvYThb14
 e7wHZ85O1hYBvOWUgLFqrIbsb7HXUae05pKQzI+mHKIxCYZVH/lQRUIAhEfdie/tUzla
 gma1qGII+zErsxuaNHLMtoWPzZrSrzIsr1JxpZqC28mc0bKg3uq4S4KC0Propi8KVK7S
 KlhA6mAWxlEJTpAseJ3pqoKBqugy5T2BZV8vgFexc7ILCedDnYtHSVxRp9aWX5AZ4u4x
 olkg==
X-Gm-Message-State: AOJu0YywMhKZ0spID0jglvDV3AlWJfZStbj1MJOE3mKs828gk20lpN08
 NptYV0inYHFS2BjKTmA6UoKDDg==
X-Google-Smtp-Source: AGHT+IEV7OL/HNo2saQvrUvDHr8Yl42onKtNIHvC6pUrenfAy7ArDilT51mSFBRgov2B1nxVDTxhKg==
X-Received: by 2002:a17:902:f691:b0:1cf:55c7:94e9 with SMTP id
 l17-20020a170902f69100b001cf55c794e9mr8842691plg.2.1700530235763; 
 Mon, 20 Nov 2023 17:30:35 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:35 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
Date: Tue, 21 Nov 2023 10:29:40 +0900
Message-Id: <20231121012950.156539-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Replicate some code and re-organize do_bootefi() into three cases, which
will be carved out as independent functions in the next two commits.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/Kconfig          | 15 ++++++--
 cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
 include/efi_loader.h |  2 --
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6f636155e5b6..4cf9a210c4a1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -362,9 +362,19 @@ config CMD_BOOTEFI
 	help
 	  Boot an EFI image from memory.
 
+if CMD_BOOTEFI
+config CMD_BOOTEFI_BINARY
+	bool "Allow booting an EFI binary directly"
+	depends on BOOTEFI_BOOTMGR
+	default y
+	help
+	  Select this option to enable direct execution of binary at 'bootefi'.
+	  This subcommand will allow you to load the UEFI binary using
+	  other U-Boot commands or external methods and then run it.
+
 config CMD_BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager command"
-	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
+	depends on BOOTEFI_BOOTMGR
 	default y
 	help
 	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
@@ -373,7 +383,7 @@ config CMD_BOOTEFI_BOOTMGR
 
 config CMD_BOOTEFI_HELLO_COMPILE
 	bool "Compile a standard EFI hello world binary for testing"
-	depends on CMD_BOOTEFI && !CPU_V7M
+	depends on !CPU_V7M
 	default y
 	help
 	  This compiles a standard EFI hello world application with U-Boot so
@@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
 	  up EFI support on a new architecture.
 
 source lib/efi_selftest/Kconfig
+endif
 
 config CMD_BOOTMENU
 	bool "bootmenu"
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 190ccba260e0..e9e5ab67a1f5 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -503,7 +503,6 @@ out:
 	return (ret != EFI_SUCCESS) ? ret : ret2;
 }
 
-#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
 		struct efi_device_path *image_path,
@@ -593,7 +592,6 @@ static int do_efi_selftest(void)
 
 	return ret != EFI_SUCCESS;
 }
-#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
 
 /**
  * do_bootefi() - execute `bootefi` command
@@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	/* Initialize EFI drivers */
-	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
-	}
-
 	if (argc > 2) {
 		uintptr_t fdt_addr;
 
@@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else {
 		fdt = EFI_FDT_USE_INTERNAL;
 	}
-	ret = efi_install_fdt(fdt);
-	if (ret == EFI_INVALID_PARAMETER)
-		return CMD_RET_USAGE;
-	else if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
-		if (!strcmp(argv[1], "bootmgr"))
-			return do_efibootmgr();
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
+	    !strcmp(argv[1], "bootmgr")) {
+		/* Initialize EFI drivers */
+		ret = efi_init_obj_list();
+		if (ret != EFI_SUCCESS) {
+			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+				ret & ~EFI_ERROR_MASK);
+			return CMD_RET_FAILURE;
+		}
+
+		ret = efi_install_fdt(fdt);
+		if (ret == EFI_INVALID_PARAMETER)
+			return CMD_RET_USAGE;
+		else if (ret != EFI_SUCCESS)
+			return CMD_RET_FAILURE;
+
+		return do_efibootmgr();
 	}
-#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
-	if (!strcmp(argv[1], "selftest"))
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
+	    !strcmp(argv[1], "selftest")) {
+		/* Initialize EFI drivers */
+		ret = efi_init_obj_list();
+		if (ret != EFI_SUCCESS) {
+			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+				ret & ~EFI_ERROR_MASK);
+			return CMD_RET_FAILURE;
+		}
+
+		ret = efi_install_fdt(fdt);
+		if (ret == EFI_INVALID_PARAMETER)
+			return CMD_RET_USAGE;
+		else if (ret != EFI_SUCCESS)
+			return CMD_RET_FAILURE;
+
 		return do_efi_selftest();
-#endif
+	}
 
-#ifdef CONFIG_CMD_BOOTEFI_HELLO
-	if (!strcmp(argv[1], "hello")) {
+	if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
+		return CMD_RET_SUCCESS;
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
+	    !strcmp(argv[1], "hello")) {
 		image_buf = __efi_helloworld_begin;
 		size = __efi_helloworld_end - __efi_helloworld_begin;
 		efi_clear_bootdev();
-	} else
-#endif
-	{
+	} else {
 		addr = strtoul(argv[1], NULL, 16);
 		/* Check that a numeric value was passed */
 		if (!addr)
@@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 			size = image_size;
 		}
 	}
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = efi_install_fdt(fdt);
+	if (ret == EFI_INVALID_PARAMETER)
+		return CMD_RET_USAGE;
+	else if (ret != EFI_SUCCESS)
+		return CMD_RET_FAILURE;
+
 	ret = efi_run_image(image_buf, size);
 
 	if (ret != EFI_SUCCESS)
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 664dae28f882..44436d346286 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
 
 efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
 
-#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
 /*
  * Entry point for the tests of the EFI API.
  * It is called by 'bootefi selftest'
  */
 efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 				 struct efi_system_table *systab);
-#endif
 
 efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
 				     const efi_guid_t *vendor, u32 *attributes,
-- 
2.34.1

