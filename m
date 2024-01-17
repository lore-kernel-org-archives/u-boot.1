Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA71C47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 04:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F102C87800;
	Wed, 17 Jan 2024 05:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e3gNmKXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CED8798F; Wed, 17 Jan 2024 05:40:09 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5148792C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1487147a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 20:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705466401; x=1706071201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdbRdTTrykTriQ/zpf472f3YkcodCIL1wHHKt9xbn8A=;
 b=e3gNmKXsWkkaOwZDJZ9hNs9N4tdaioOGFPR45sGLNFeYyi+DIipVRCv6da958jcYnH
 Sgx2hOwqWnNDLYSW0QdZh/pR4+Jc8A/lK6nAlhpVTEUjQ0yKQW3QJLQPapvx/gLMOURF
 wy62S0IFnRqowq6kQDNUBxelRrpgbE7NhB14HMIfvRaSlz0XQMq+sCGKBHQQo5CR04Ey
 GMbd+aG6we93hsbSwfdQibfOOwNdhjlkf3mRKUIyQSMnFYBVp90RnKED58hre3WsREH1
 DcnayXe3k/va2u7cpr+sCbCfI+U8JB7uF9Is5KUUMP+nQWmmzHDqGe981L8/TGFSmQtY
 wqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705466401; x=1706071201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdbRdTTrykTriQ/zpf472f3YkcodCIL1wHHKt9xbn8A=;
 b=rVO9cNHdGMhC370fcFjhxxyPHCSrPpiOPeqzdAJqxcwuefCuh6e/H2R51jQeEX5osy
 LO3a+61LaZULTXCuV5WXALw0nHoFknmQCL6OVAVTTZlzVxfdeVKuJ4+D7HPOVLHekKvk
 3PCIvxn4BnYARA+ugb3vjIUF4MU2DtWHGaRNkLvG975C+wgjaLCGbPqWaEnOjnrr53WR
 j+lGWpy9PfPsrXQ1/QQbWZ7HWmeb+8dPfgGZvbREBCn6n/vY0t+JuXmfLIpIaLOLsI1K
 4qbACgS2Qqf9Mu6kD4DU52Mu8mSRUexo1G/ErdGTB+MTlsqlrGCd40gj4KYJnqt4I+v6
 mKLA==
X-Gm-Message-State: AOJu0Yxc4NdbKMJGNcYMIB8J+1fhzOQwaCfx3EG0YF9H3b+WwBHBmkIG
 Lb5t9oM0fMTA9kcSX5VCkOTroH8C5xQgrQ==
X-Google-Smtp-Source: AGHT+IGqjX5HTNYof2CM6FHn7C5tfr0VrEot5MqG1WcInTWVchPccRZGbp28qDLH4hsLkDPk5YUwiQ==
X-Received: by 2002:a17:902:da85:b0:1d3:f36a:9d21 with SMTP id
 j5-20020a170902da8500b001d3f36a9d21mr16181677plx.4.1705466400853; 
 Tue, 16 Jan 2024 20:40:00 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e481:26af:1a49:433a])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170902ea1100b001d403969bf4sm10048668plg.309.2024.01.16.20.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 20:40:00 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Date: Wed, 17 Jan 2024 13:39:42 +0900
Message-Id: <20240117043944.477358-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117043944.477358-1-takahiro.akashi@linaro.org>
References: <20240117043944.477358-1-takahiro.akashi@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 boot/Makefile           | 2 +-
 cmd/Kconfig             | 4 ++--
 cmd/efidebug.c          | 4 ++--
 lib/efi_loader/Kconfig  | 2 +-
 lib/efi_loader/Makefile | 2 +-
 test/boot/bootflow.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index a47e00274622..f0a279cde161 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
+obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 150fa37a50a7..62d2ae3d3f1b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -395,7 +395,7 @@ config CMD_BOOTEFI_BINARY
 
 config CMD_BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager command"
-	depends on BOOTEFI_BOOTMGR
+	depends on EFI_BOOTMGR
 	default y
 	help
 	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
@@ -2153,7 +2153,7 @@ config CMD_EFIDEBUG
 config CMD_EFICONFIG
 	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
 	default y if !HAS_BOARD_SIZE_LIMIT
-	depends on BOOTEFI_BOOTMGR
+	depends on EFI_BOOTMGR
 	select MENU
 	help
 	  Enable the 'eficonfig' command which provides the menu-driven UEFI
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index aa8523797efb..a3a7556ea4a5 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1414,7 +1414,7 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 }
 
 static struct cmd_tbl cmd_efidebug_test_sub[] = {
-#ifdef CONFIG_BOOTEFI_BOOTMGR
+#ifdef CONFIG_EFI_BOOTMGR
 	U_BOOT_CMD_MKENT(bootmgr, CONFIG_SYS_MAXARGS, 1, do_efi_test_bootmgr,
 			 "", ""),
 #endif
@@ -1608,7 +1608,7 @@ U_BOOT_LONGHELP(efidebug,
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
index f0a31b4ad509..fcb0af7e7d6d 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -49,7 +49,7 @@ targets += initrddump.o
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
-obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
+obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
 obj-$(CONFIG_EFI_BINARY_EXEC) += efi_bootbin.o
 obj-y += efi_boottime.o
 obj-y += efi_helper.o
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 104f49deef2a..fa54dde661c8 100644
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

