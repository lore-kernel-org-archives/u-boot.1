Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200ACD3448
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06AB4889BD;
	Tue,  3 Sep 2024 18:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="0zWmWB3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90CB88BBE; Tue,  3 Sep 2024 18:44:20 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63C1887EB
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f51b67e16dso64444251fa.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381858; x=1725986658;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMGVHVXXGOOL+7tdPe2GmUmTj56nF0iDo5hTR6mIRdk=;
 b=0zWmWB3VYH38cMg3D6ZH9gAjAA6ft56g/M4PO5gp32QYLoywZAYVKpcqfjDaAbvrlQ
 gw8tp4jmvcvjHthxgNGGMiJNv6rSmeEh7HroYqHSNu4j1HdyoRbD5VAunla35yuwszjb
 wh8rr2a3bNHJzhxVxy2nM/7NMZdK7ydnG3Kn1s3rbi7u5aBhkcgRPrMqNyPwkaw9AiiR
 ZpBI/mkk1CAWxfbVB/4FlyMezhnATYBHIYam2LqeroQn4XRH8A8gUU8KzyQ/YT2Bo6w4
 ykDZC050r/YPtPvMMoUQAh7fI/YUBKqx4wtqYrqQUOS046KYDu3jCxahnCCSAPbm4NfY
 7gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381858; x=1725986658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMGVHVXXGOOL+7tdPe2GmUmTj56nF0iDo5hTR6mIRdk=;
 b=TqQ88eorXCPAHdkpSVjhLZxxEAdBotsbuYtlUdBpX0zFa8AtEqk2dQyKkKvkzPPJPz
 jwHK7ZWxJ0lTc+q7M8ajBiv8+FDjAGqSNwV6eeEuhR6lTHjTBh+WKHAqRiB7+HtVxJLB
 T3YiXX0S0TLZ2G099JE32i1AzTnA0pBmccn9ht+y3TC0Egct8Gcn8tBkgqGBG4fFJvs7
 b3QCQoIJJtvQZimMVz96Fw7XWncL41PQAvUWemWJ04SrrQyigp3ZRblv817UpA594E4u
 xIiLykRF1aRq5HcQHAbTfDWDOG1EHyTPbenLwFKY3vrYftzSFrMn0/zrP9C0L9BbkDbw
 k0zg==
X-Gm-Message-State: AOJu0YwoiEwgFOk2zHUnOjGi3N+yiogAibZswY8IHHE7LHySM1473zcZ
 oC5ww6ko820Cs8VHC4f6ADvlx13x+pVfBwNpXBVS9OVi7KRO5BJ+YETISG7F9L18DUnn/dLWhIS
 b
X-Google-Smtp-Source: AGHT+IEKx6H3VKO99pphwQneLf/D1KmzgE/KFeilLzI/ZSqK+v7KOdZg5f0ki7IypS68gz90hRuMxQ==
X-Received: by 2002:a2e:1319:0:b0:2f3:e814:a90d with SMTP id
 38308e7fff4ca-2f64d4ab2d7mr10194941fa.28.1725381857558; 
 Tue, 03 Sep 2024 09:44:17 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:44:17 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG config
 for TPL/SPL
Date: Tue,  3 Sep 2024 18:38:56 +0200
Message-ID: <20240903163858.1155218-4-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
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

Introduce new config symbols TPL_RAM_ROCKCHIP_DEBUG and
SPL_RAM_ROCKCHIP_DEBUG to allow for better dependencies control
of RAM driver debugging configuration.
Add negative dependencies to TPL_SILENT_CONSOLE and
SPL_SILENT_CONSOLE, respectively.

Replace IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG) directives with
CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG) to utilize the configuration
changes.

Update defconfigs of affected boards so that behavior
is not changed.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 configs/anbernic-rgxx3-rk3566_defconfig   |  1 +
 configs/neu2-io-rv1126_defconfig          |  2 ++
 configs/roc-pc-mezzanine-rk3399_defconfig |  2 ++
 configs/roc-pc-rk3399_defconfig           |  2 ++
 configs/rock-pi-n10-rk3399pro_defconfig   |  2 ++
 configs/sonoff-ihost-rv1126_defconfig     |  2 ++
 drivers/ram/rockchip/Kconfig              | 24 +++++++++++++++++++++++
 drivers/ram/rockchip/sdram_common.c       |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c       |  4 ++--
 drivers/ram/rockchip/sdram_rv1126.c       | 10 +++++-----
 10 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index a03509bf467..4392bb5af00 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -68,6 +68,7 @@ CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
 # CONFIG_RNG_SMCCC_TRNG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index 2a4c9b45a04..1bdf99887b3 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -46,6 +46,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYSRESET=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index a57899bfdfa..45c4975e452 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -66,6 +66,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index b45f0e0a899..3f2d5650249 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -63,6 +63,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index ec995a54a0e..d4ba628e428 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -52,6 +52,8 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index 4890644c7e6..1b10cded8fd 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -47,6 +47,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
+# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYSRESET=y
diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..5e069dca3be 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,6 +24,30 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config SPL_RAM_ROCKCHIP_DEBUG
+	bool "Rockchip ram drivers debugging in SPL"
+	depends on DEBUG_UART
+	depends on SPL && SPL_RAM && !SPL_SILENT_CONSOLE
+	default y
+	help
+	  This enables debugging ram driver API's for the platforms
+	  based on Rockchip SoCs.
+
+	  This is an option for developers to understand the ram drivers
+	  initialization, configurations and etc.
+
+config TPL_RAM_ROCKCHIP_DEBUG
+	bool "Rockchip ram drivers debugging in TPL"
+	depends on DEBUG_UART
+	depends on TPL && TPL_RAM && !TPL_SILENT_CONSOLE
+	default y
+	help
+	  This enables debugging ram driver API's for the platforms
+	  based on Rockchip SoCs.
+
+	  This is an option for developers to understand the ram drivers
+	  initialization, configurations and etc.
+
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
 	help
diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
index b7a8fce607c..c2a6310388c 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -10,7 +10,7 @@
 #include <asm/arch-rockchip/sdram.h>
 #include <asm/arch-rockchip/sdram_common.h>
 
-#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
+#if CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)
 void sdram_print_dram_type(unsigned char dramtype)
 {
 	switch (dramtype) {
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 45270e27184..99a1cc6c174 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -2558,7 +2558,7 @@ static int lpddr4_set_rate(struct dram_info *dram,
 	lpddr4_set_ctl(dram, params, ctl_fn,
 		       dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq);
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
 		printf("%s: change freq to %dMHz %d, %d\n", __func__,
 		       dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq / MHz,
 		       ctl_fn, phy_fn);
@@ -2980,7 +2980,7 @@ static int sdram_init(struct dram_info *dram,
 			continue;
 		}
 
-		if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
+		if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
 			printf("Channel ");
 			printf(channel ? "1: " : "0: ");
 		}
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 4fbb088a8d9..14e1df71ae4 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -3375,7 +3375,7 @@ static void ddr_set_rate_for_fsp(struct dram_info *dram,
 	if (get_wrlvl_val(dram, sdram_params))
 		printascii("get wrlvl value fail\n");
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
 		printascii("change to: ");
 		printdec(f1);
 		printascii("MHz\n");
@@ -3383,21 +3383,21 @@ static void ddr_set_rate_for_fsp(struct dram_info *dram,
 	ddr_set_rate(&dram_info, sdram_params, f1,
 		     sdram_params->base.ddr_freq, 1, 1, 1);
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
 		printascii("change to: ");
 		printdec(f2);
 		printascii("MHz\n");
 	}
 	ddr_set_rate(&dram_info, sdram_params, f2, f1, 2, 0, 1);
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
 		printascii("change to: ");
 		printdec(f3);
 		printascii("MHz\n");
 	}
 	ddr_set_rate(&dram_info, sdram_params, f3, f2, 3, 1, 1);
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
 		printascii("change to: ");
 		printdec(f0);
 		printascii("MHz(final freq)\n");
@@ -3493,7 +3493,7 @@ static int rv1126_dmc_init(struct udevice *dev)
 	save_rw_trn_result_to_ddr(&rw_trn_result);
 #endif
 
-	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
+	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
 		printascii("out\n");
 
 	return ret;
-- 
2.43.0

