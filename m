Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C8FC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C619807FE;
	Sun,  9 Feb 2025 22:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i+S1cnuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B427B807FE; Sun,  9 Feb 2025 22:15:19 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684E8803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3cfe17f75dfso36455565ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135715; x=1739740515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FdHzSNpEFHvUiUhCZAvKRP+Te87IS0T5dA3tQo39Fw=;
 b=i+S1cnuCK3W/qohrrj/zOsTOYZWBHcB+zAs3lviGHRaRdNexG+hxJsXIkjeWMs77vX
 numvg5eHI+ZiSLPPDC5JjtC+sYCUa5pY+eha+H572nPEpgY31578dTOQwNF5QA07Qg49
 AtORdwZiBks86t0IfagnchcXd+hv9Jde/y5aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135715; x=1739740515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FdHzSNpEFHvUiUhCZAvKRP+Te87IS0T5dA3tQo39Fw=;
 b=boAlKtTbbFSJAvC2V2K2d4989ipxA2fcuYfv2ocLq1xSj0WZbfaX72qsSdel0XxRaS
 l5sKa8iRJ6DEGe0GVAXVWk56gZnqP6IRvEVHXvy7+VA1lEBJ4ak5BoJyq3Syr64WaidH
 2dlWIDP0YArLkN0c66CtD4Bn3Ro1yIu4FnZ1xkR8KkN4m2PfJ9i+FsgFFj3TGe0DtJ9B
 2XGtSb5FHxFZHvZYssvnKjWe+DHeiuymTYNrVGLHfOTeonGqacm/ybYGwgT2WteF28SP
 EhTXbN1zHqwCFt7guR/PeBcC8Z47KIbSDKsaXQP/nqMgmXim8fdbbuA7HRu1+Rmn0B/c
 rhTQ==
X-Gm-Message-State: AOJu0YxrWNU+KGIlR1koO9ZgK1egeXYzrJKJYnM+x0c8pyp2AQy2KZam
 yjYWTCZNVUh9hd8+0Sid/ChBYcWD+/SllRSvdwAiAdJ8lsX8PcjrwFMJEwk0QF3X5LqXkjiyJc8
 =
X-Gm-Gg: ASbGnctVPV7dIVWtsRYUtUSxLi1LoBdXIL7TZsdYHhtPMZYeyQjdrx0HQtLyv/2b29x
 fZhC0EgxY3jpj4XCTsGKRLZrNmW8moH3rhHZuw6yyTmmks8pLMXTP1QvL8mi10NkU9FpudnZKOn
 8JtS/XhW9Jnm+rUSaxJ5hmJuQLq9/oU59QuXthLj4iYNTt/KULLf8+gmQPbmxU7UbSjxEwSkuG2
 xGUculziIGTPyguTYpxzDhfu+GU1v26M9VxypsUal9sB+dluXGzYcNqlEBOv60grmNMg6kndHO4
 FvOPXvWCjSnuCQj/1pPBvjPjL8ctiO/luyg6AKSaHzwvQciHTJop
X-Google-Smtp-Source: AGHT+IFREFpsbSUIkTXQ6cN6BBnFoKCbRPG6fiuNb+6xWhQtrRfaRBF9NzMxrMjt4xGwr6dpIJck5A==
X-Received: by 2002:a05:6e02:b2e:b0:3d0:137a:8c77 with SMTP id
 e9e14a558f8ab-3d13dd026c9mr94369585ab.3.1739135714874; 
 Sun, 09 Feb 2025 13:15:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:13 -0800 (PST)
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
Subject: [PATCH v2 01/35] tpl: Rename TPL_NEEDS_SEPARATE_STACK to
 TPL_HAVE_INIT_STACK
Date: Sun,  9 Feb 2025 14:14:22 -0700
Message-ID: <20250209211502.2299245-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to rename TPL_NEEDS_SEPARATE_STACK

 arch/arm/lib/crt0.S            |  2 +-
 arch/arm/lib/crt0_64.S         |  2 +-
 arch/arm/mach-rockchip/Kconfig | 14 +++++++-------
 common/spl/Kconfig.tpl         | 19 ++++++++++---------
 configs/mk808_defconfig        |  2 +-
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a691d844847..a7e6f50d39a 100644
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
index 4d3157b2edd..4c515593718 100644
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
@@ -106,7 +106,7 @@ config ROCKCHIP_RK322X
 	select TPL
 	select TPL_DM
 	select TPL_OF_LIBFDT
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	select SPL_DRIVERS_MISC
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_SERIAL
@@ -139,7 +139,7 @@ config ROCKCHIP_RK3288
 	imply TPL_DRIVERS_MISC
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
-	imply TPL_NEEDS_SEPARATE_STACK
+	imply TPL_HAVE_INIT_STACK
 	imply TPL_OF_CONTROL
 	imply TPL_OF_PLATDATA
 	imply TPL_RAM
@@ -197,7 +197,7 @@ config ROCKCHIP_RK3328
 	select SPL
 	select SUPPORT_TPL
 	select TPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	imply MISC
@@ -225,7 +225,7 @@ config ROCKCHIP_RK3368
 	select ARM64
 	select SUPPORT_SPL
 	select SUPPORT_TPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
@@ -257,7 +257,7 @@ config ROCKCHIP_RK3399
 	select SPL_RAM if SPL
 	select SPL_REGMAP if SPL
 	select SPL_SYSCON if SPL
-	select TPL_NEEDS_SEPARATE_STACK if TPL
+	select TPL_HAVE_INIT_STACK if TPL
 	select SPL_SEPARATE_BSS
 	select CLK
 	select FIT
@@ -392,7 +392,7 @@ config ROCKCHIP_RV1126
 	select SKIP_LOWLEVEL_INIT_ONLY
 	select TPL
 	select SUPPORT_TPL
-	select TPL_NEEDS_SEPARATE_STACK
+	select TPL_HAVE_INIT_STACK
 	select TPL_ROCKCHIP_BACK_TO_BROM
 	select SPL
 	select SUPPORT_SPL
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 22ca7016453..980d6da202a 100644
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
+	  Enable if the TPL phase should not use inherit its initial
+	  stack-pointer from the settings for U-Boot proper, but should set
+	  its own value.
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

