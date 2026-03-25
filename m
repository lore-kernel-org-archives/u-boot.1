Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA6109C05A
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCDF84020;
	Wed, 25 Mar 2026 20:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y1hCFqUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0269783FC6; Wed, 25 Mar 2026 20:00:30 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BACE83FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7447778b9so77572a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465226; x=1775070026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YelysLaLnsO4CvsOi2F4fFDhNd/f4YEh64BnVlRRMPA=;
 b=Y1hCFqUjQMIvX5KYf4a1nEaEYJFOh0P9iYDDb2pEK6Zq7T4mRJlkay/t6wneqPyMBR
 ROSWMeMJyuGV3oFBUvd3ipam61r/2VWA6tKLypYJiu+ii6/TxKp8iHrDwiqmzJSi/NLm
 cg23Bk4WSODCXtHaCYisSI7/GRTCuNH/YSAM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465226; x=1775070026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YelysLaLnsO4CvsOi2F4fFDhNd/f4YEh64BnVlRRMPA=;
 b=Gdd3ojlgWG1k6J06sAeuFvmaOKigPmD3j+tFLkSQDbHBIFcd4+WEymMZqi/NDsFblk
 2pdNv4v1PoCv3uAuS6UPJKEX+/2s46TO6cIU/HJY55Hj7ALwS6U3T/6SBC+Y4bmNh3k7
 P8VSMy7EPgs3NxV2Bd/jg89+n5XPxs7wM+N0ldB97SJsXY5UxJiQCzk7Ah6Mp442JJRA
 aELzQN5NonNNqIgIN9nimXUCd6m57Wj0WQLjCG/BACJIF5h/HbeEQ4pzakhVxaMh0r4I
 z04DmYlG6D5SPK5V79HwVF0bGUyiwABcdQLyMKHZwU3nUjX/wCRyaeWz3ey7CyQEFyYI
 rjmQ==
X-Gm-Message-State: AOJu0YyyS9b09nmPvX8HoAA28Esvvlt6SwPd1cb7VYswXQl3fTxGHYfP
 F3vWYfiViwpIp6n187gIuRY5MH80NQFtjc7pmsx8ALymGpQYP+XzFtJcYO5FfJxxjwlzcnG2IVC
 05bD57Js=
X-Gm-Gg: ATEYQzzwBH4XStlqqsOrtY3yQkJkVQKnyVqEiJAi8HJUX5bAH1JgHRWqPbzcWDv9vHJ
 gg8SXtvrF1+BYaJGYc1Fn8xDGqBcZkbsVIkqDKdhBYM4UT9RbK4pMClnCHpfwNQfrImJjXfJ7v4
 sT+TyTXsR7aenlTxeJqPpLIS5iof6+dTxwJMGvGpgmbAvT/om7lAk55jyqR8TrXWBcIhrGk0m04
 HBAhhMZNWEnVOIWiDJkGJDCmpcUZ6g3uq2+FeTejz0PSDA2iz5h0wm6bR16A3cP723QZAMtXGSo
 LasyTgTdjJrfc+GVqcEE8cGOBkcHxerMof5FBN6gDLlkKJE6adzAFXjKZFgP7z6lgRQjafcq5GP
 9mbsec5s4o3W7KhzCbeJauyif4r17LR3ptUvemsrxRhzmc3t4EQaxsErLeKmX6a4MLCfqPyB6sx
 wxk0c5KZiqw7szOw1kEMfnHUufUgJVBcv/PxXbizqs2Pf/xazn8TrERW8jtUtPCSBFG3Hc/Cszd
 WUqVnnVCJWPqO5HaU3gjUSeoO3f+YP7wzslXy4Zugnl/eMJTCKrfjPqIPoIDQ==
X-Received: by 2002:a05:6830:4426:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7d9d68f6bb7mr2462558a34.21.1774465225726; 
 Wed, 25 Mar 2026 12:00:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2af0sm394896a34.6.2026.03.25.12.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Stelian Pop <stelian@popies.net>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Ilko Iliev <iliev@ronetix.at>
Subject: [PATCH] arm: at91: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:24 -0600
Message-ID: <20260325190024.3428545-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Stelian Pop <stelian@popies.net>
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Ilko Iliev <iliev@ronetix.at>
---
 arch/arm/mach-at91/Kconfig                    | 21 -------------------
 arch/arm/mach-at91/spl_atmel.c                |  3 ++-
 board/atmel/at91sam9260ek/at91sam9260ek.c     |  7 -------
 board/atmel/at91sam9261ek/at91sam9261ek.c     |  7 -------
 board/atmel/at91sam9263ek/at91sam9263ek.c     |  7 -------
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |  7 -------
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |  7 -------
 board/atmel/at91sam9rlek/at91sam9rlek.c       |  7 -------
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |  7 -------
 .../sam9x60_curiosity/sam9x60_curiosity.c     |  5 -----
 board/atmel/sam9x60ek/sam9x60ek.c             |  7 -------
 .../sam9x75_curiosity/sam9x75_curiosity.c     |  5 -----
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |  7 -------
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |  7 -------
 board/atmel/sama5d2_icp/sama5d2_icp.c         |  5 -----
 board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c   |  7 -------
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |  7 -------
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |  7 -------
 board/atmel/sama5d3xek/sama5d3xek.c           |  7 -------
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |  7 -------
 board/atmel/sama5d4ek/sama5d4ek.c             |  7 -------
 .../sama7d65_curiosity/sama7d65_curiosity.c   |  5 -----
 board/atmel/sama7g5ek/sama7g5ek.c             |  5 -----
 board/ronetix/pm9261/pm9261.c                 |  5 -----
 board/ronetix/pm9263/pm9263.c                 |  5 -----
 configs/pm9261_defconfig                      |  1 -
 configs/pm9263_defconfig                      |  1 -
 27 files changed, 2 insertions(+), 171 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7d00f1650b42..65e9d70f0840 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -78,7 +78,6 @@ choice
 config TARGET_AT91SAM9260EK
 	bool "Atmel at91sam9260 reference board"
 	select AT91SAM9260
-	select BOARD_EARLY_INIT_F
 
 config TARGET_GURNARD
 	bool "Support gurnard"
@@ -96,7 +95,6 @@ config TARGET_GURNARD
 config TARGET_AT91SAM9261EK
 	bool "Atmel at91sam9261 reference board"
 	select AT91SAM9261
-	select BOARD_EARLY_INIT_F
 
 config TARGET_PM9261
 	bool "Ronetix pm9261 board"
@@ -105,7 +103,6 @@ config TARGET_PM9261
 config TARGET_AT91SAM9263EK
 	bool "Atmel at91sam9263 reference board"
 	select AT91SAM9263
-	select BOARD_EARLY_INIT_F
 
 config TARGET_USB_A9263
 	bool "Caloa USB A9260 board"
@@ -119,7 +116,6 @@ config TARGET_PM9263
 config TARGET_AT91SAM9M10G45EK
 	bool "Atmel AT91SAM9M10G45-EK board"
 	select AT91SAM9M10G45
-	select BOARD_EARLY_INIT_F
 	select SUPPORT_SPL
 
 config TARGET_PM9G45
@@ -129,18 +125,15 @@ config TARGET_PM9G45
 config TARGET_AT91SAM9N12EK
 	bool "Atmel AT91SAM9N12-EK board"
 	select AT91SAM9N12
-	select BOARD_EARLY_INIT_F
 	select SUPPORT_SPL
 
 config TARGET_AT91SAM9RLEK
 	bool "Atmel at91sam9rl reference board"
 	select AT91SAM9RL
-	select BOARD_EARLY_INIT_F
 
 config TARGET_AT91SAM9X5EK
 	bool "Atmel AT91SAM9X5-EK board"
 	select AT91SAM9X5
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select SUPPORT_SPL
 
@@ -154,31 +147,26 @@ config TARGET_GARDENA_SMART_GATEWAY_AT91SAM
 config TARGET_SAM9X60EK
 	bool "SAM9X60-EK board"
 	select SAM9X60
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 
 config TARGET_SAM9X60_CURIOSITY
         bool "SAM9X60 CURIOSITY board"
         select SAM9X60
-        select BOARD_EARLY_INIT_F
         select BOARD_LATE_INIT
 
 config TARGET_SAM9X75_CURIOSITY
 	bool "SAM9X75 CURIOSITY board"
 	select SAM9X7
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	imply OF_UPSTREAM
 
 config TARGET_SAMA5D2_PTC_EK
 	bool "SAMA5D2 PTC EK board"
-	select BOARD_EARLY_INIT_F
 	select SAMA5D2
 	select BOARD_LATE_INIT
 
 config TARGET_SAMA5D2_XPLAINED
 	bool "SAMA5D2 Xplained board"
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select SAMA5D2
 	select SUPPORT_SPL
@@ -186,7 +174,6 @@ config TARGET_SAMA5D2_XPLAINED
 config TARGET_SAMA5D27_SOM1_EK
 	bool "SAMA5D27 SOM1 EK board"
 	select SAMA5D2
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select CPU_V7A
 	select SUPPORT_SPL
@@ -201,7 +188,6 @@ config TARGET_SAMA5D27_SOM1_EK
 config TARGET_SAMA5D27_WLSOM1_EK
 	bool "SAMA5D27 WLSOM1 EK board"
 	select SAMA5D2
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select CPU_V7A
 	select SUPPORT_SPL
@@ -228,7 +214,6 @@ config TARGET_SAMA5D2_ICP
 	bool "SAMA5D2 Industrial Connectivity Platform (ICP)"
 	select SAMA5D2
 	select SUPPORT_SPL
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	help
 	  The SAMA5D2 ICP embeds SAMA5D27 rev. C SoC, together with
@@ -248,28 +233,24 @@ config TARGET_SAMA5D29_CURIOSITY
 
 config TARGET_SAMA5D3_XPLAINED
 	bool "SAMA5D3 Xplained board"
-	select BOARD_EARLY_INIT_F
 	select SAMA5D3
 	select SUPPORT_SPL
 	select BOARD_LATE_INIT
 
 config TARGET_SAMA5D3XEK
 	bool "SAMA5D3X-EK board"
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select SAMA5D3
 	select SUPPORT_SPL
 
 config TARGET_SAMA5D4_XPLAINED
 	bool "SAMA5D4 Xplained board"
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select SAMA5D4
 	select SUPPORT_SPL
 
 config TARGET_SAMA5D4EK
 	bool "SAMA5D4 Evaluation Kit"
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select SAMA5D4
 	select SUPPORT_SPL
@@ -291,7 +272,6 @@ config TARGET_CORVUS
 config TARGET_SAMA7G5EK
        bool "SAMA7G5 EK board"
        select SAMA7G5
-       select BOARD_EARLY_INIT_F
        select BOARD_LATE_INIT
 
 config TARGET_SAMA7G54_CURIOSITY
@@ -307,7 +287,6 @@ config TARGET_SAMA7G54_CURIOSITY
 config TARGET_SAMA7D65_CURIOSITY
 	bool "SAMA7D65 CURIOSITY board"
 	select SAMA7D65
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	imply OF_UPSTREAM
 
diff --git a/arch/arm/mach-at91/spl_atmel.c b/arch/arm/mach-at91/spl_atmel.c
index 7bfbadf0483e..32cf78b3bf6b 100644
--- a/arch/arm/mach-at91/spl_atmel.c
+++ b/arch/arm/mach-at91/spl_atmel.c
@@ -132,7 +132,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
-	board_early_init_f();
+	if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
+		board_early_init_f();
 
 	at91_mem_init();
 
diff --git a/board/atmel/at91sam9260ek/at91sam9260ek.c b/board/atmel/at91sam9260ek/at91sam9260ek.c
index 48aec652c4a4..07fbafba4335 100644
--- a/board/atmel/at91sam9260ek/at91sam9260ek.c
+++ b/board/atmel/at91sam9260ek/at91sam9260ek.c
@@ -71,13 +71,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/board/atmel/at91sam9261ek/at91sam9261ek.c b/board/atmel/at91sam9261ek/at91sam9261ek.c
index 5d7a18379fae..eb5d98ad566c 100644
--- a/board/atmel/at91sam9261ek/at91sam9261ek.c
+++ b/board/atmel/at91sam9261ek/at91sam9261ek.c
@@ -139,13 +139,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 #ifdef CONFIG_AT91SAM9G10EK
diff --git a/board/atmel/at91sam9263ek/at91sam9263ek.c b/board/atmel/at91sam9263ek/at91sam9263ek.c
index 2b0b01798eae..3b272e3ffa1f 100644
--- a/board/atmel/at91sam9263ek/at91sam9263ek.c
+++ b/board/atmel/at91sam9263ek/at91sam9263ek.c
@@ -83,13 +83,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* arch number of AT91SAM9263EK-Board */
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index d94904366eda..d07b5196bc32 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -155,13 +155,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* arch number of AT91SAM9M10G45EK-Board */
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index 2cddc2175acc..6105e51c9ec3 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -89,13 +89,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/board/atmel/at91sam9rlek/at91sam9rlek.c b/board/atmel/at91sam9rlek/at91sam9rlek.c
index 214e917381e7..d21dfea50f32 100644
--- a/board/atmel/at91sam9rlek/at91sam9rlek.c
+++ b/board/atmel/at91sam9rlek/at91sam9rlek.c
@@ -81,13 +81,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* arch number of AT91SAM9RLEK-Board */
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index 3f41fb1c9832..0cbb50a0621c 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -102,13 +102,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* arch number of AT91SAM9X5EK-Board */
diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
index 3393478e4c8c..43797d625e93 100644
--- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
+++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
@@ -51,11 +51,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #define MAC24AA_MAC_OFFSET     0xfa
 
 #ifdef CONFIG_MISC_INIT_R
diff --git a/board/atmel/sam9x60ek/sam9x60ek.c b/board/atmel/sam9x60ek/sam9x60ek.c
index 2e5073f02b3e..64354e5b5fcf 100644
--- a/board/atmel/sam9x60ek/sam9x60ek.c
+++ b/board/atmel/sam9x60ek/sam9x60ek.c
@@ -49,13 +49,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 #define MAC24AA_MAC_OFFSET     0xfa
 
 #ifdef CONFIG_MISC_INIT_R
diff --git a/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
index 4e7c5667e214..364b6a3e24bc 100644
--- a/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
+++ b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
@@ -42,11 +42,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index bf54fc33df4b..858061bf9f93 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -61,13 +61,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 897fab58ebae..19341d325bde 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -55,13 +55,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index 113bd2feb621..d159ad6f4ca3 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -46,11 +46,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c b/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
index 438829df82d5..29fa88ff411d 100644
--- a/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
+++ b/board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c
@@ -105,13 +105,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index eca5b2bf1076..c0862f586061 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -60,13 +60,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index 7a813c19ff20..e12f2883cec6 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -84,13 +84,6 @@ int board_late_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index 555a8c0970b0..405c9c50321b 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -137,13 +137,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index e296b0466aa3..5894e7a654df 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -99,13 +99,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 #define AT24MAC_MAC_OFFSET	0x9a
 
 #ifdef CONFIG_MISC_INIT_R
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index e820605d3b96..7418369c5ba6 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -97,13 +97,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
index 713b1b9d9591..764c8f035c9e 100644
--- a/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
+++ b/board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
@@ -49,11 +49,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* address of boot parameters */
diff --git a/board/atmel/sama7g5ek/sama7g5ek.c b/board/atmel/sama7g5ek/sama7g5ek.c
index c07115a21195..5409ed2375dd 100644
--- a/board/atmel/sama7g5ek/sama7g5ek.c
+++ b/board/atmel/sama7g5ek/sama7g5ek.c
@@ -46,11 +46,6 @@ void board_debug_uart_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #define MAC24AA_MAC_OFFSET     0xfa
 
 #if (IS_ENABLED(CONFIG_MISC_INIT_R))
diff --git a/board/ronetix/pm9261/pm9261.c b/board/ronetix/pm9261/pm9261.c
index ee578749bce7..1f78654b685a 100644
--- a/board/ronetix/pm9261/pm9261.c
+++ b/board/ronetix/pm9261/pm9261.c
@@ -76,11 +76,6 @@ static void pm9261_nand_hw_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* arch number of PM9261-Board */
diff --git a/board/ronetix/pm9263/pm9263.c b/board/ronetix/pm9263/pm9263.c
index 8125f064cf11..cc58e0f3a386 100644
--- a/board/ronetix/pm9263/pm9263.c
+++ b/board/ronetix/pm9263/pm9263.c
@@ -70,11 +70,6 @@ static void pm9263_nand_hw_init(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* arch number of PM9263 Board */
diff --git a/configs/pm9261_defconfig b/configs/pm9261_defconfig
index 026c6de3109c..71cc51004e7d 100644
--- a/configs/pm9261_defconfig
+++ b/configs/pm9261_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_PBSIZE=281
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_AUTO_COMPLETE is not set
 CONFIG_SYS_PROMPT="pm9261> "
 # CONFIG_CMD_BDI is not set
diff --git a/configs/pm9263_defconfig b/configs/pm9263_defconfig
index cc375671f666..810c2464e281 100644
--- a/configs/pm9263_defconfig
+++ b/configs/pm9263_defconfig
@@ -22,7 +22,6 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=288
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_AUTO_COMPLETE is not set
 CONFIG_SYS_PROMPT="u-boot-pm9263> "
 # CONFIG_CMD_BDI is not set
-- 
2.43.0

