Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2FC109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BBE8406D;
	Wed, 25 Mar 2026 20:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkvWXoxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5B683AAB; Wed, 25 Mar 2026 20:00:33 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60B3838BB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7f592b8beso118658a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465229; x=1775070029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0OIPNbfNxnMicZyifpKc9retvzGF6QXsTnXJHM708zs=;
 b=mkvWXoxpWRy+Dp5+FIOny/vT7uHZiJmxEpT4MuTZDwH+Grb7pFgXIvvUnXh5o8Z4qk
 9I11vsGLJYBaOxWhXCJJHa4Qv1ZFX8txCWCohzi2bi/rzXa9jGxGDEaLC3VlvIYXFDm8
 muIFlaouEfn2TYtrn8KeXtzO81Y3zcE6d6KuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465229; x=1775070029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OIPNbfNxnMicZyifpKc9retvzGF6QXsTnXJHM708zs=;
 b=fB0paywrkeAGYj5q0/NdO7Uiqv6uEKUaPxvPemgyfS/bWXsv0VDraBXwD7lFlFICTv
 qmiBEUR7IcHVOTx/irx9QrXu2RGNMpvpMYO//QASETpz7/v/UP+8g9/YGM5Dt162ocII
 nNmxhLPK+Qnp/DpT0Q5WWpY2P4m6I+GuWuiX3aQGpkYNvP12sqJrhnSo8Ixs7w8Ep2RK
 nmAL33BBGri9hKTyopxq0xWxHbCw7PtB8bF5QqaLGqWJEzrZd1crZgMNCjSDRQhF6WRC
 3mXnOHlYfk/CWBLkybrNIsUyjnX2mLIWVP0CwrbW0OG5g72SzkUVPfg7HdKm62/wwY9m
 2kCg==
X-Gm-Message-State: AOJu0Yw+S7iYWWzTXB7icYC5CNi62x58VwVplh6VoNN4jzzb76/j3HgJ
 qV8qIumcJP/2C4Ozq4oXCa/XedEAnBngiIdqjtUscuRPtdRk3keyqKApsFXGtXVwfKDu8Bsh9hw
 Jhan66uQ=
X-Gm-Gg: ATEYQzydbQIPUgONFzytAYGRLuwwGtrtawx8p5669JEFg769aHx79RZA7QGzr8THSp+
 KoFdA3CZhd+6lQL1pQAjAbeJMFHEU2teOW3ecQ/gi1ZIhgLfQA1uxAWDMQXndHxS4N1UEYEPOrm
 qLbEwAmDFIDfYZGuLpxP4ving2VKQXr3Cssauu4IsLiHwor0gH/c5e3L+Cjk0hCtJF3ZYvLe/dD
 sJcZyA2djl+YOIGSmvNOBfK7Tr+/6kQeAbIXthcnWM1GACuLEM/u7toQR3mCYyEzRchhr8nPWi/
 Dmq4+FJrwrnbfVCeMiOVSxh9jsrzDK++Z1+1aakptACyR92K0cdkw6iaL/5N9p9+P+Ee8cf/TN/
 QrJZws+ZjsesD3OQICfeRNL/lroD48TJzp8SK4tgLOmMQ+Y8GjYXcgaRjErAcn3dyXw/MUrnH6n
 BNnYaguKoz2TdzLFNfO0ILN/yA38s4o8mwQTQw0l7bxBqwK/Z429YxYjq+4DYWdhBH2odA+f7OV
 43V5CkRYg0EKBKOe4Usfa4f+0qeGjr1kNHlgl+fY/69Qdt8jLo=
X-Received: by 2002:a05:6830:3487:b0:7d7:f5c6:9fa3 with SMTP id
 46e09a7af769-7d9d67995afmr2447512a34.8.1774465229339; 
 Wed, 25 Mar 2026 12:00:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e701545bsm409005a34.11.2026.03.25.12.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] arm: stm32mp: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:27 -0600
Message-ID: <20260325190027.3428596-1-trini@konsulko.com>
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
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/spl.c         | 15 ++++++---------
 board/engicam/stm32mp1/spl.c                 |  6 ------
 board/st/stm32h750-art-pi/stm32h750-art-pi.c |  5 -----
 configs/stm32h750-art-pi_defconfig           |  1 -
 4 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index e63bdaaf42fd..d2e41b8e65ff 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -90,11 +90,6 @@ void spl_display_print(void)
 }
 #endif
 
-__weak int board_early_init_f(void)
-{
-	return 0;
-}
-
 uint32_t stm32mp_get_dram_size(void)
 {
 	struct ram_info ram;
@@ -204,10 +199,12 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
-	ret = board_early_init_f();
-	if (ret) {
-		log_debug("board_early_init_f() failed: %d\n", ret);
-		hang();
+	if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F)) {
+		ret = board_early_init_f();
+		if (ret) {
+			log_debug("board_early_init_f() failed: %d\n", ret);
+			hang();
+		}
 	}
 
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
diff --git a/board/engicam/stm32mp1/spl.c b/board/engicam/stm32mp1/spl.c
index bb2bd446aa8c..19e5ab0180f9 100644
--- a/board/engicam/stm32mp1/spl.c
+++ b/board/engicam/stm32mp1/spl.c
@@ -15,9 +15,3 @@ void board_vddcore_init(u32 voltage_mv)
 	if (IS_ENABLED(CONFIG_PMIC_STPMIC1) && CONFIG_IS_ENABLED(POWER))
 		opp_voltage_mv = voltage_mv;
 }
-
-int board_early_init_f(void)
-{
-	return 0;
-}
-
diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
index 244bb5eefb3a..8b1b23337790 100644
--- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
+++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
@@ -32,11 +32,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_late_init(void)
 {
 	return 0;
diff --git a/configs/stm32h750-art-pi_defconfig b/configs/stm32h750-art-pi_defconfig
index 971d5c00d88f..0d0dca2511b7 100644
--- a/configs/stm32h750-art-pi_defconfig
+++ b/configs/stm32h750-art-pi_defconfig
@@ -24,7 +24,6 @@ CONFIG_DEFAULT_FDT_FILE="stm32h750i-art-pi"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="U-Boot > "
-- 
2.43.0

