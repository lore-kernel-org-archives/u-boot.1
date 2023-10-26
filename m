Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E778C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1A987AEE;
	Thu, 26 Oct 2023 07:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eccwVnTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0FE87AF6; Thu, 26 Oct 2023 07:31:27 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAE18755E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bbfb8f7ac4so121612b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298283; x=1698903083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+czYVJWy61Hd8zv5Ht+HcoSUNO1gaLWG95az3su/V98=;
 b=eccwVnTu+sEmmlG23e71YEG8W9qEgJSbgE0rKeidslWk6+jT8EZ1FWgRQjjfTE3H3b
 lh+PZzBUAb6SJ5unIxSHlKFo/6DLneWxjfkrGhOlncFKeJyGi+seG6UMQDv8eFCX1raL
 z21RlgXhAvAQ/VsA1Hl9XpXn6zy1ES5P/5pdXsuDZdSuVx7ptURR0VQLMLqxxQl9HPVv
 eJblnBcMFBTypmYkDcwSTS3ya6TDoatnLxekQRA4TLp0O+My/971mQ+RhJwuN62Z0Hd9
 pxkyD97GxpXakAdMxtXIH7JqEAJsWKIS3bG+Ai2kJswiosUJPMYR6ltbMOpohtfk4HCZ
 4a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298283; x=1698903083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+czYVJWy61Hd8zv5Ht+HcoSUNO1gaLWG95az3su/V98=;
 b=j3NkZr6ny4y+fhCt2UmEoRKbPTsobOYcGZHg3JbOiHqMDY5qpU8REG5iqgYCsDJbDu
 JaYWYNnjwhpelX884ZJoDNJU8vvxs03OI47/j7hlsBF0SR28CR79T+M0Q3PkMHjMl70S
 BmoXoB2rtw+2USwXjRqlea7CJ0CMlXBTxYXcLQOIRVsLFZOgAIx+PewyBqtuZHKJBZVQ
 nmi/zCqGZph+ZJ3R3mNBStBkQk625CbGbWfeqxiELOBaDBr20bRDu42EAeRJfMEPhvQB
 kPvqDJ4daV1TaKU8RXrr5HL/u67W1OVisHJGDoB87Wis/O4ErA6hkFgLZhNVjz+KTyBN
 5zPQ==
X-Gm-Message-State: AOJu0YxIGzk3bJlqvzjp24twN6o+AlOewGlC69rJcZmlHrcg4Ka/Ca10
 6Cwl4XWzM5luTXZugNllvsRDOA==
X-Google-Smtp-Source: AGHT+IHiu5lm4eDLPApRATYKwFh7gSUrdVT2poM291V7r7f+DeQdle4KupzuvBla1Vd1bZ1sms5Gcw==
X-Received: by 2002:a05:6a00:2c8e:b0:6bc:67ca:671d with SMTP id
 ef14-20020a056a002c8e00b006bc67ca671dmr16997858pfb.1.1698298283329; 
 Wed, 25 Oct 2023 22:31:23 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:23 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 02/13] cmd: bootefi: re-organize do_bootefi_image()
Date: Thu, 26 Oct 2023 14:30:41 +0900
Message-Id: <20231026053052.622453-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Decompose and re-organize do_bootefi_image() into three parts for
the succeeding refactor work.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/Kconfig          | 15 ++++++--
 cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
 include/efi_loader.h |  2 --
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0eb739203ade..825a41d68aad 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -363,9 +363,19 @@ config CMD_BOOTEFI
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
@@ -374,7 +384,7 @@ config CMD_BOOTEFI_BOOTMGR
 
 config CMD_BOOTEFI_HELLO_COMPILE
 	bool "Compile a standard EFI hello world binary for testing"
-	depends on CMD_BOOTEFI && !CPU_V7M
+	depends on !CPU_V7M
 	default y
 	help
 	  This compiles a standard EFI hello world application with U-Boot so
@@ -396,6 +406,7 @@ config CMD_BOOTEFI_HELLO
 	  up EFI support on a new architecture.
 
 source lib/efi_selftest/Kconfig
+endif
 
 config CMD_BOOTMENU
 	bool "bootmenu"
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 1b28bf5a318d..ae00bba3b4f0 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -491,7 +491,6 @@ out:
 	return (ret != EFI_SUCCESS) ? ret : ret2;
 }
 
-#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
 		struct efi_device_path *image_path,
@@ -581,7 +580,6 @@ static int do_efi_selftest(void)
 
 	return ret != EFI_SUCCESS;
 }
-#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
 
 /**
  * do_bootefi() - execute `bootefi` command
@@ -603,14 +601,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
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
 
@@ -619,29 +609,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -663,6 +678,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
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
index e24410505f40..48d4999e56a9 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -878,14 +878,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
 
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

