Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CCEC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD4A80F06;
	Fri, 28 Feb 2025 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RcAdmdwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5F8810FE; Fri, 28 Feb 2025 13:21:01 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB9E809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85595f813caso156621439f.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740745256; x=1741350056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1LNsi06g9gaM1BU2rgY4bcz4qIT3FDIKexTnAKuVxs=;
 b=RcAdmdwfhHJSeDCAoVnOCwXV1T49OI09LG4JY+j90hwdaQCKepXLsKUNdAjk0bFMqw
 +cHHUlEOufIGlFa1xHkOewTrHZUbjB7bthKhQ+98gyp19MKIVXPgMLwgmHxL2tPm2nu3
 LGznU+9IuDfrgV+jb+aUAf9hjzIEOdIuvVFcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745256; x=1741350056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1LNsi06g9gaM1BU2rgY4bcz4qIT3FDIKexTnAKuVxs=;
 b=cucvTKmNdWnEWSh+/tNhWCRApu0p3e5QuETnHjRmTd6SznnX2WdXvYVB85BZGPYI0k
 WzufJ/8uOwsznoCqotFF4PzL9crdHCRissFOKWIFc/0UPArG28W4z//qAvVu+o8VpIsv
 CN6bYb97rOUZpSspDKoz+rk3dqfkk8sW6Ly8xpC2NVFMFhofBG54FVr8jsi0W5fuSCou
 ZWitvhiZ5ssI1Wfgj3STw3VOG//eqSWsoNkueSrj2Wyvmc/gNl9BB1ghs8MrujYd4vdu
 c75MGmfUqKXxkE624t0Y+FpBLRHWoU4a/JtK6HiObyC3mTaNxQad/lQDLjsQuAss7gH7
 HYQg==
X-Gm-Message-State: AOJu0Yx4tR50R6d4GpTbv2Z3HPPMpEshb7UrmGZoW3qILk4crlDdbR4E
 MoXuxmzfHdN0k3w1xIPtMVGlYbbO/uktUhQs64N5u72yd4ADaNkkybzmjppM4/w4VEeetXU1TIc
 =
X-Gm-Gg: ASbGncuBnK6xTIBLHjONjb/+mnGm6/xTz3rlz8Rp9IO+1rzcVtRvP3Ix8RM2xjgoFon
 t2Gze4EuywlUKdDEXVfRcguFqwTYH67QFDNKUKpScPUWOWTjlKh3OzpUY+Z1sV0Wjrm6NS4bn6z
 fj4B5hxBgPfWFa0jxaIR41F6+l5qwffHTtl8Uz/0cUBWHXLy5XR54QkHVrL+Hg3nKujL697a+fO
 QzSUEB5pjCrPgBrgBt9fPd972xOBcMTq7CmCXrNygx94W67jBT3Uhebm8vXP1RTvkmETF98qD/c
 hOjM7DhI61vaZEM/C+qfL6E9hh+atETC5IniGh2fXFBCVRb6cyvWl2lBRa2Kwsk=
X-Google-Smtp-Source: AGHT+IFS3XCNNdLysh08eqY1jLFaUd+R4P1gcX0IUpU8WsghRDC5ExIygtjmx9OxHNkv9iLuc83C6Q==
X-Received: by 2002:a05:6602:2c8b:b0:855:bd9c:7183 with SMTP id
 ca18e2360f4ac-85881fcdc11mr265427439f.9.1740745256063; 
 Fri, 28 Feb 2025 04:20:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061fa91e3sm863801173.138.2025.02.28.04.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:20:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Gary Bisson <bisson.gary@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/4] tpl: Rename TPL_NEEDS_SEPARATE_STACK to
 TPL_HAVE_INIT_STACK
Date: Fri, 28 Feb 2025 05:20:23 -0700
Message-ID: <20250228122042.1277079-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228122042.1277079-1-sjg@chromium.org>
References: <20250228122042.1277079-1-sjg@chromium.org>
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

The most common word for features that make a platform work is to use
'HAVE_xxx'. Rename this option to match.

Update the help to use the word 'phase' rather than 'stage', since
that is the current terminology. Also clarify that, absent this setting,
the stack pointer generally comes from the value used by U-Boot proper,
rather than SPL.

Move the option just above TPL_STACK which depends on it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Reword the Kconfig help for TPL_HAVE_INIT_STACK

Changes in v2:
- Add new patch to rename TPL_NEEDS_SEPARATE_STACK

 arch/arm/lib/crt0.S            |  2 +-
 arch/arm/lib/crt0_64.S         |  2 +-
 arch/arm/mach-rockchip/Kconfig | 14 +++++++-------
 common/spl/Kconfig.tpl         | 19 ++++++++++---------
 configs/mk808_defconfig        |  2 +-
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 3e4906e273d..aca5b865680 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -100,7 +100,7 @@ ENTRY(_main)
  * Set up initial C runtime environment and call board_init_f(0).
  */
 
-#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
+#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
 	ldr	r0, =(CONFIG_TPL_STACK)
 #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	r0, =(CONFIG_SPL_STACK)
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 32401f544a7..62a0abe1fed 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -69,7 +69,7 @@ ENTRY(_main)
 /*
  * Set up initial C runtime environment and call board_init_f(0).
  */
-#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
+#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
 	ldr	x0, =(CONFIG_TPL_STACK)
 #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	x0, =(CONFIG_SPL_STACK)
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index adac11a6b89..c6e347b8d9d 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -9,7 +9,7 @@ config ROCKCHIP_PX30
 	select SPL
 	select TPL
 	select TPL_TINY_FRAMEWORK if TPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	imply SPL_SEPARATE_BSS
 	select SPL_SERIAL
 	select TPL_SERIAL
@@ -107,7 +107,7 @@ config ROCKCHIP_RK322X
 	select TPL
 	select TPL_DM
 	select TPL_OF_LIBFDT
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	select SPL_DRIVERS_MISC
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_SERIAL
@@ -140,7 +140,7 @@ config ROCKCHIP_RK3288
 	imply TPL_DRIVERS_MISC
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
-	imply TPL_NEEDS_SEPARATE_STACK
+	imply TPL_HAVE_INIT_STACK
 	imply TPL_OF_CONTROL
 	imply TPL_OF_PLATDATA
 	imply TPL_RAM
@@ -198,7 +198,7 @@ config ROCKCHIP_RK3328
 	select SPL
 	select SUPPORT_TPL
 	select TPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	imply MISC
@@ -226,7 +226,7 @@ config ROCKCHIP_RK3368
 	select ARM64
 	select SUPPORT_SPL
 	select SUPPORT_TPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
@@ -258,7 +258,7 @@ config ROCKCHIP_RK3399
 	select SPL_RAM if SPL
 	select SPL_REGMAP if SPL
 	select SPL_SYSCON if SPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	select SPL_SEPARATE_BSS
 	select CLK
 	select FIT
@@ -393,7 +393,7 @@ config ROCKCHIP_RV1126
 	select SKIP_LOWLEVEL_INIT_ONLY
 	select TPL
 	select SUPPORT_TPL
-	select TPL_NEEDS_SEPARATE_STACK
+	select TPL_HAVE_INIT_STACK
 	select TPL_ROCKCHIP_BACK_TO_BROM
 	select SPL
 	select SUPPORT_SPL
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 22ca7016453..421352f9396 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -106,12 +106,6 @@ config TPL_LDSCRIPT
 	  May be left empty to trigger the Makefile infrastructure to
 	  fall back to the linker-script used for the SPL stage.
 
-config TPL_NEEDS_SEPARATE_STACK
-	bool "TPL needs a separate initial stack-pointer"
-	help
-	  Enable, if the TPL stage should not inherit its initial
-	  stack-pointer from the settings for the SPL stage.
-
 config TPL_POWER
 	bool "Support power drivers"
 	help
@@ -140,11 +134,18 @@ config TPL_MAX_SIZE
 	help
 	  The maximum size (in bytes) of the TPL stage.
 
+config TPL_HAVE_INIT_STACK
+	bool "TPL requires a initial, fixed, stack-pointer location"
+	help
+	  Enable if the TPL phase should not inherit its initial
+	  stack-pointer from the settings for U-Boot proper (or SPL if
+	  SPL_STACK is defined), but should set its own value.
+
 config TPL_STACK
-	hex "Address of the initial stack-pointer for the TPL stage"
-	depends on TPL_NEEDS_SEPARATE_STACK
+	hex "Address of the initial stack-pointer for the TPL phase"
+	depends on TPL_HAVE_INIT_STACK
 	help
-	  The address of the initial stack-pointer for the TPL stage.
+	  The address of the initial stack-pointer for the TPL phase
 	  Usually this will be the (aligned) top-of-stack.
 
 config TPL_READ_ONLY
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index e47d0b594f3..a1f089a23ea 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -48,7 +48,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
-CONFIG_TPL_NEEDS_SEPARATE_STACK=y
+CONFIG_TPL_HAVE_INIT_STACK=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
-- 
2.43.0

