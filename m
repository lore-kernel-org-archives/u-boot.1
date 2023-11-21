Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FD0C61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097B587584;
	Tue, 21 Nov 2023 02:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ojppAoBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD77875BC; Tue, 21 Nov 2023 02:31:39 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFBD875A4
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc2b8deb23so10682255ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530253; x=1701135053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otqnZHrndwWLn4WmIHD98CEzafN5CRxFeZ2ufbMbKkw=;
 b=ojppAoBPfo5fcDNbh4wvVKPDusenix+feA3uRb2KX+RN7YXlHpKuRwfiOlJOyxb1DH
 A6f/FCqh9BMyYWwlsgnGZz7EbicdhelHA+HBTKUFTDn3YJjUz0MGHJ9hwqRVUPToVPCZ
 Uzd16zHdqwbkZek4Z8Urj/0URLwFloxXjXeV7/JSim7gbYYIjzHpuAUGhgScoluF6fMd
 v/+nME2yR9A1JnvtEsPirgLnSnhzcb+dcXVB4cUxUMgESX9L8gOz1L4xzqBJKafo0uCk
 yYM001Rg4dgLuYCHgaW7gml7Pv35zwtkOQGXGZuOaCGX0N2asxVChapcAivj8/t2Q99/
 0yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530253; x=1701135053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otqnZHrndwWLn4WmIHD98CEzafN5CRxFeZ2ufbMbKkw=;
 b=BxCgYLNb8m0RQhDHrb8PKrwrUUpzZj9uFzm0NCxDLoIy5DoM4LBH4B/RpMYnbYdXPf
 ibPKIfNohF52gVCJtO/FQyEInjVdVqHYFePNGPcoc8UwKVchWfHUJPiXlVDOF8n4pQCW
 gh0aZ/n/P75TKTglWfxiQm+jwntJXrn4bRbthEnro1UbNmQW8IAChQ65IBKXjVQJGx6g
 c8VgOcCkoa9LNul4xK1YSeOwRmATeWSrGL9AonMSHi57uPpTaRoDRAXrvbXcGcNoQ/B9
 dYUqCSVChKfHEB4/YLUJMUv848GEfz5e52wI2cw1PEFbCNinaq53N0Bk8MrZXLQRfWDv
 Najg==
X-Gm-Message-State: AOJu0YyEqG/mB+i2P0z5rxAikYCS61Iu4/r4mo2Cf4YtCtpk+CdFKuHu
 Lm+u0XzNQ10wqVHfYBU7dK7cVg==
X-Google-Smtp-Source: AGHT+IGxMe/mqa+Dp+BOaxM8rnkb5bzJKQXJFnD2I7GxQgiGgW2hlufpbAOahQbOdKh+Vl9s5Y93kw==
X-Received: by 2002:a17:903:32c4:b0:1ce:2fc1:60ef with SMTP id
 i4-20020a17090332c400b001ce2fc160efmr12252807plr.0.1700530253373; 
 Mon, 20 Nov 2023 17:30:53 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:53 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 10/12] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Date: Tue, 21 Nov 2023 10:29:48 +0900
Message-Id: <20231121012950.156539-11-takahiro.akashi@linaro.org>
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
index 189ea6003293..897e99ae68de 100644
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
@@ -2124,7 +2124,7 @@ config CMD_EFIDEBUG
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
index ddb1a012a761..61e056dedb5b 100644
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
index fa1bebdd02da..b670dfd5e5b5 100644
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

