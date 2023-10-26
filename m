Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF1C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A2F87B31;
	Thu, 26 Oct 2023 07:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvaD8gPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5AB87B28; Thu, 26 Oct 2023 07:31:44 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DC287B1D
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bb744262caso113153b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298300; x=1698903100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzM3GADLVfsOYyYUTe9ShM0/j77yEgOVI6Qe6mqlMxI=;
 b=SvaD8gPfp7VFlNnQcWD4WlJh2nnrgwEDOU2Eze7indAM7pil8uj4LXE7FKZvFF7ZZZ
 /JIyWwSTzLoQqsVx6xPCVy5kk1KCivpTtj9jKZa9C6RSBP4P0eR/Cyb7XTygVhnnAwuG
 Hb2lTFoLn4fTpBOH+kbksPu+sIbQFDUhhsky8OkS2sK2rpvg2LoilU3VaRGBDTwWNKVL
 PqdVHz4Vl5Wy/GfnVK8IZ2ByxaC/HCsol17lNmasHVElU1z8mywqblBBXO9klJjYge5l
 1me+o+VftPdtl5I7VXNsgk5kgxZ5D+rXK+bIIUL2youKW1cqIA6uChB/7PRKf8aTHbu2
 ERdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298300; x=1698903100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzM3GADLVfsOYyYUTe9ShM0/j77yEgOVI6Qe6mqlMxI=;
 b=DxpGYPghJ2YZBKiLn/zJmFDiRFcxTK+ozkawybzzs2IFKELZSqO628iXTNEIHmOt+d
 9hM+beqLKSrmBAL7ZA4tnchP5GGeeARyam5rxgKRMyG5bspSC1mCfOkVYmzvbgzJazng
 KdMzIQ3Hgdf81cp0Jll7399QFo8j1JV85EaQJ57n4OIp2tqk9mERCj0TM7pkfLH4KKCP
 bTFG85fpBf64Fpk1uG+JVymBceLSppmcckMuH9B9Z2y/w3Vv6JlnBLb50fP8XKiGcZj4
 AN9ZqCFJ69XGz5nCp0B1pPwuF+ZiY7bw7mejj/CB8/tuAsTVXRkY+UBrBOHApBxyVPr0
 iH2A==
X-Gm-Message-State: AOJu0YzV8W74Gg6UT6D7fsdHwVVEvz5jGKGNT7YYkORmYuXCDojtCxtk
 66gZGZkLV3tCoz8hBvZWzClOTg==
X-Google-Smtp-Source: AGHT+IHsdwhYjWkhIMSr7/WV3853WnoWQh5X3ezy/xFOLp+BpK/zQXTRDbPXUBLe2a6riahrG27yIQ==
X-Received: by 2002:a05:6a21:33a4:b0:163:c167:964a with SMTP id
 yy36-20020a056a2133a400b00163c167964amr21429946pzb.1.1698298300114; 
 Wed, 25 Oct 2023 22:31:40 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:39 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 09/13] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Date: Thu, 26 Oct 2023 14:30:48 +0900
Message-Id: <20231026053052.622453-10-takahiro.akashi@linaro.org>
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

At this point, EFI boot manager interfaces is fully independent from
bootefi command. So just rename the configuration parameter.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 boot/Makefile           | 2 +-
 cmd/Kconfig             | 4 ++--
 cmd/efidebug.c          | 4 ++--
 lib/efi_loader/Kconfig  | 2 +-
 lib/efi_loader/Makefile | 2 +-
 test/boot/bootflow.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index 4eaa5eab4b77..48d74c67d680 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
+obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
diff --git a/cmd/Kconfig b/cmd/Kconfig
index bf16fad04d37..3a8483f7d042 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -375,7 +375,7 @@ config CMD_BOOTEFI_BINARY
 
 config CMD_BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager command"
-	depends on BOOTEFI_BOOTMGR
+	depends on EFI_BOOTMGR
 	default y
 	help
 	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
@@ -2122,7 +2122,7 @@ config CMD_EFIDEBUG
 config CMD_EFICONFIG
 	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
 	default y if !HAS_BOARD_SIZE_LIMIT
-	depends on BOOTEFI_BOOTMGR
+	depends on EFI_BOOTMGR
 	select MENU
 	help
 	  Enable the 'eficonfig' command which provides the menu-driven UEFI
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index c2b2b074e094..7ba2331ad19f 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1335,7 +1335,7 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 }
 
 static struct cmd_tbl cmd_efidebug_test_sub[] = {
-#ifdef CONFIG_BOOTEFI_BOOTMGR
+#ifdef CONFIG_EFI_BOOTMGR
 	U_BOOT_CMD_MKENT(bootmgr, CONFIG_SYS_MAXARGS, 1, do_efi_test_bootmgr,
 			 "", ""),
 #endif
@@ -1526,7 +1526,7 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI memory map\n"
 	"efidebug tables\n"
 	"  - show UEFI configuration tables\n"
-#ifdef CONFIG_BOOTEFI_BOOTMGR
+#ifdef CONFIG_EFI_BOOTMGR
 	"efidebug test bootmgr\n"
 	"  - run simple bootmgr for test\n"
 #endif
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 987a990509f3..27d3f52897a9 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -41,7 +41,7 @@ config EFI_BINARY_EXEC
 	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
 	  command to do that.
 
-config BOOTEFI_BOOTMGR
+config EFI_BOOTMGR
 	bool "UEFI Boot Manager"
 	default y
 	select BOOTMETH_GLOBAL if BOOTSTD
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 0a2cb6e3c476..f882474bba6f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -42,7 +42,7 @@ targets += initrddump.o
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
-obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
+obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
 obj-y += efi_boottime.o
 obj-y += efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 47c552a94165..7eafdc79de3b 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -374,7 +374,7 @@ static int bootflow_system(struct unit_test_state *uts)
 {
 	struct udevice *bootstd, *dev;
 
-	if (!IS_ENABLED(CONFIG_BOOTEFI_BOOTMGR))
+	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
 		return -EAGAIN;
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
-- 
2.34.1

