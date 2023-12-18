Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C97AC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 02:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C63087DB5;
	Mon, 18 Dec 2023 03:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kevrj0Et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D02E87DCA; Mon, 18 Dec 2023 03:39:12 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B29787DB2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d3b3877fc1so2046315ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702867148; x=1703471948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SG3xnS2inJXNhiw+bFYo8TG93VPJM5qNAM//uYJAgkk=;
 b=Kevrj0Et+XEQAYDak9m1IVKy4gbY2sfG5ixot1msPsUMbQFXZZgU8UyEbM6+bXe6L7
 F+gSbvRx8Mtk+GxP55L93K15GiWmnNzp4tfEtegG1+II3D0QAplz8tT3DqFOK7UBuY9H
 wlxYdicuAZv4Okd2t83BNvh9hjBmfuiv4DSO8cTC7aPzSg97DzTAaq1Qt5c0h8j1wyOm
 cEJLlASVTC1kc6XwD0CChAnChne/9uxSorYf2vu1mgyU+FXgQuFQLWzXxX34T/tGvfCk
 hbF7oFaHeXOpcbfEguHPjzKYStNSJD6jvMxg14Y5Cwsc38qy+w+YUh3hzxwVmKSZCRTC
 tnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702867148; x=1703471948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SG3xnS2inJXNhiw+bFYo8TG93VPJM5qNAM//uYJAgkk=;
 b=tVDGllDVaFn26gHQUhvV7S0a4ox3K9VZ8t58FhP9xzQu+Ka7BgtYE4nsuT47iXiWu3
 Y9J3QEMvEJTXJMu7zyNqRLKCysK+s5GMQUpNG4ikoPUh4DDeKV31MyCpgBx3imHybgGJ
 NHNDd3h8U5RaZFj6QRKqBS/ynv6GbqJ597HQjT2mjOyoFEjA27ufgiTop3oK6yW3Rflu
 LkhhHVxPKtNNkmr8alpjdQT9TUW1vdULILWuQWqBoQHhpC+hna5E9RxfBYJUaLLJ0o03
 aRzl6boAvgxsgoPn8xIwZ4SivxT0vMmGC1owZiPPdMly9TFnbcSSFBWJeA4VzB+Biz5v
 n6nQ==
X-Gm-Message-State: AOJu0Yx9sI1P33Truz3f16zcQcCxVrQOQA0btCMADcFMK9qrLNCpB/ET
 RuOWF9UeT58XYDeXfxAjtG2oXQ==
X-Google-Smtp-Source: AGHT+IERlevFICjsCG9Dw0ED+cNa6Ap+Qz6hRQf+7K8rVB+Q6mIfhC5zge/tFvk9zAiK2TTv7DiZ8w==
X-Received: by 2002:a17:903:2311:b0:1d0:7c59:2a4f with SMTP id
 d17-20020a170903231100b001d07c592a4fmr31860123plh.0.1702867148527; 
 Sun, 17 Dec 2023 18:39:08 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:a448:a260:721d:a9f0])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a1709029a9800b001d316770044sm13754305plp.56.2023.12.17.18.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 18:39:08 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Date: Mon, 18 Dec 2023 11:38:40 +0900
Message-Id: <20231218023842.281336-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218023842.281336-1-takahiro.akashi@linaro.org>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
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
index a90ebea5a867..bcd01cfc890c 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
+obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2c993496b70e..856ff9f5395d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -374,7 +374,7 @@ config CMD_BOOTEFI_BINARY
 
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
index e10fbf891a42..b4954258eeba 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1410,7 +1410,7 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 }
 
 static struct cmd_tbl cmd_efidebug_test_sub[] = {
-#ifdef CONFIG_BOOTEFI_BOOTMGR
+#ifdef CONFIG_EFI_BOOTMGR
 	U_BOOT_CMD_MKENT(bootmgr, CONFIG_SYS_MAXARGS, 1, do_efi_test_bootmgr,
 			 "", ""),
 #endif
@@ -1604,7 +1604,7 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI memory map\n"
 	"efidebug tables\n"
 	"  - show UEFI configuration tables\n"
-#ifdef CONFIG_BOOTEFI_BOOTMGR
+#ifdef CONFIG_EFI_BOOTMGR
 	"efidebug test bootmgr\n"
 	"  - run simple bootmgr for test\n"
 #endif
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 64f2f1cdd161..db5571de1d95 100644
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
index f3e5a839da47..57e48fe62694 100644
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

