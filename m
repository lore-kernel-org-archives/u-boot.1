Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325B4C47077
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 01:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E0787977;
	Wed, 10 Jan 2024 02:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W5YdkEcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A987687708; Wed, 10 Jan 2024 02:17:07 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DAEC8786F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2049e6d7f50so685352fac.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704849418; x=1705454218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbjgTfHkMTJGirKT3R9MJjlpV0ohhIqb0vChQJw0nDk=;
 b=W5YdkEcUphJqcDA6AZTU5svYkfvvli5n3PpDBADTivf7DAqok05LDN9I0zwhjw0gxY
 qOgNvsodyNAH2kQAhlhsc/qWqRs3zA93JT956AS31lrtx1+pZtY3Or7OlxHnRXbhFJXy
 H8NZ1pU79WEwijN32ALay/DkfJnMrJFeg/twUp9TbsTAOUYUAHDSrdHj2+FFSk89SfL2
 Py13ekRmEGErDTRDJQ+iRBL/qWY/OWAn5Wx+woD4B/9dBMskkzQ5t6UzVoWsMQWSzzsd
 NH0ZylHjjUbjY/cms5Z5brjwxWYc/Ios/XtNUjkEkqVHXKPfxdrmTag2FPSHwlZieyhy
 xfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704849418; x=1705454218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbjgTfHkMTJGirKT3R9MJjlpV0ohhIqb0vChQJw0nDk=;
 b=p/iJSWCTYzVBgAEqQwd5I449bvIEhTQhnJgPlOYXOLuVRpyb8Ia/Q4r3F3s+R38vz2
 b/CgRh4AjW8mxRlpkFEY68KgGOnsUmmPEHb3Hhwfv22+373KIpx2qB8tg5PBx/bhgQ9P
 hW+unaGeMl1bA5KzBStBoy2A34O09dAacxNzvilUSTgxNjA7gXuUHtX/PZwAN0O48prL
 VnALsZ6t0DqMUFBngvcRV1vm16WldW4Tka2HtnJyKBWMF3D3w7UApBwB8O2V2oMfMswZ
 rY10d1dDO5y3Mp08sgwJY1k91HYrfTgE4yizAZVbRy8tN+xKOZyEpcasvUdi6ihb6SH1
 xZZw==
X-Gm-Message-State: AOJu0YxD5mRxIpUev49I+oRaCd1nEB1Dl4HzN/22MvLHlmjPOUZMXKy+
 qyWyNyk13FHdGyVRupf1nD/t7cw+gVQtUaE7WEnFv4eeL/4=
X-Google-Smtp-Source: AGHT+IESQST3V9xn/FN8zq5KUxWMfpURXsi1wGMX34naP0wFmPcc695F6deJyzVyyArWa+YjapFQZA==
X-Received: by 2002:a05:6870:8986:b0:204:9066:c34f with SMTP id
 f6-20020a056870898600b002049066c34fmr654965oaq.5.1704849417651; 
 Tue, 09 Jan 2024 17:16:57 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e32c:1ab8:3100:c37f])
 by smtp.gmail.com with ESMTPSA id
 a36-20020a634d24000000b005c2967852c5sm2166833pgb.30.2024.01.09.17.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 17:16:57 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Date: Wed, 10 Jan 2024 10:16:35 +0900
Message-Id: <20240110011637.174710-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110011637.174710-1-takahiro.akashi@linaro.org>
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
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
index f85d26d9724c..56e5ce220a3e 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -42,7 +42,7 @@ targets += initrddump.o
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

