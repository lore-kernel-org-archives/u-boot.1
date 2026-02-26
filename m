Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658CEFC592F
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 11:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDE583D1A;
	Thu, 26 Feb 2026 12:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="ZKGv2ZEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E170783642; Thu, 26 Feb 2026 12:11:57 +0100 (CET)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D5983E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772104314; x=1772363514;
 bh=Korwu5w4Ihkw+yu5VoXPtU5pG3XiurORjhJeoVfhpVg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZKGv2ZEzXg2ze0c2k0FK/gUzG9lN8LTh/N48h1HOGbYmB1skK7cJ6X+g19ZbbYRs6
 vdAmO0jbc3cjPLqCYp3Btderp3KYanHVG02KCaoYRrPdEg8W0xyXKeY63PHLAZP8U+
 sA/WexNFV1aOTkqcdTZ9xGSPCT6e80J6GBNhNagMYl1S0tkZZ9QvFpzg1PUizTf4WK
 hjpMbzaXvDefuUw2hjb3qKuLCRKVg5oSeYzRKfgw/GKWPrL9japfiCw3gyvWmivnnD
 asvbT+ppL/7bj7NCRNDTfGdBdhFYKABLuRPYK56qm8UR28aXv7jmw8XHjXe2kAWGGQ
 CKOL0PaIwA36A==
Date: Thu, 26 Feb 2026 11:11:50 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, E Shattow <e@freeshell.de>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 2/2] treewide: Remove Timesys from ADI ADSP maintenance
Message-ID: <20260226111136.354009-3-philip@philipmolloy.com>
In-Reply-To: <20260226111136.354009-1-philip@philipmolloy.com>
References: <20260226111136.354009-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: e838f0d7232784bd5869c77d6b430db04c873de3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

After years of developing the ADI ADSP platform, Timesys was purchased
by another company and is no longer contracted to maintain the platform.

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 4 +---
 arch/arm/include/asm/arch-adi/sc5xx/soc.h    | 4 +---
 arch/arm/include/asm/arch-adi/sc5xx/spl.h    | 4 +---
 arch/arm/mach-sc5xx/Kconfig                  | 5 +----
 arch/arm/mach-sc5xx/Makefile                 | 5 +----
 arch/arm/mach-sc5xx/config.mk                | 5 +----
 arch/arm/mach-sc5xx/init/Makefile            | 5 +----
 arch/arm/mach-sc5xx/init/clkinit.c           | 4 +---
 arch/arm/mach-sc5xx/init/clkinit.h           | 4 +---
 arch/arm/mach-sc5xx/init/dmcinit.c           | 4 +---
 arch/arm/mach-sc5xx/init/dmcinit.h           | 4 +---
 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h | 4 +---
 arch/arm/mach-sc5xx/rcu.c                    | 3 +--
 arch/arm/mach-sc5xx/sc57x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc58x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc59x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc59x_64.c               | 4 +---
 arch/arm/mach-sc5xx/soc.c                    | 4 +---
 arch/arm/mach-sc5xx/spl.c                    | 4 +---
 drivers/clk/adi/Kconfig                      | 5 +----
 drivers/clk/adi/Makefile                     | 5 +----
 drivers/clk/adi/clk-adi-pll.c                | 2 +-
 drivers/clk/adi/clk-adi-sc57x.c              | 2 +-
 drivers/clk/adi/clk-adi-sc58x.c              | 2 +-
 drivers/clk/adi/clk-adi-sc594.c              | 2 +-
 drivers/clk/adi/clk-adi-sc598.c              | 2 +-
 drivers/clk/adi/clk-shared.c                 | 2 +-
 drivers/clk/adi/clk.h                        | 2 +-
 drivers/dma/adi_dma.c                        | 5 +----
 drivers/gpio/adp5588_gpio.c                  | 4 +---
 drivers/gpio/gpio-adi-adsp.c                 | 3 +--
 drivers/i2c/adi_i2c.c                        | 4 +---
 drivers/mmc/adi_sdhci.c                      | 4 +---
 drivers/net/dwc_eth_qos_adi.c                | 3 +--
 drivers/pinctrl/pinctrl-adi-adsp.c           | 3 +--
 drivers/remoteproc/adi_sc5xx_rproc.c         | 4 +---
 drivers/serial/serial_adi_uart4.c            | 4 +---
 drivers/spi/adi_spi3.c                       | 6 +-----
 drivers/timer/adi_sc5xx_timer.c              | 3 +--
 drivers/usb/musb-new/sc5xx.c                 | 2 +-
 drivers/watchdog/adi_wdt.c                   | 4 +---
 include/dt-bindings/clock/adi-sc5xx-clock.h  | 4 +---
 include/dt-bindings/pinctrl/adi-adsp.h       | 4 +---
 46 files changed, 46 insertions(+), 126 deletions(-)

diff --git a/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h b/arch/arm/include=
/asm/arch-adi/sc5xx/sc5xx.h
index 683e3d412ce..c80de67d7ae 100644
--- a/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
+++ b/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
 #ifndef ARCH_ADI_SC5XX_SC5XX_H
 #define ARCH_ADI_SC5XX_SC5XX_H
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/soc.h b/arch/arm/include/a=
sm/arch-adi/sc5xx/soc.h
index 430dbe2dae4..065d272acab 100644
--- a/arch/arm/include/asm/arch-adi/sc5xx/soc.h
+++ b/arch/arm/include/asm/arch-adi/sc5xx/soc.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef BOARD_ADI_COMMON_SOC_H
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/spl.h b/arch/arm/include/a=
sm/arch-adi/sc5xx/spl.h
index c215e6b892a..077667daa10 100644
--- a/arch/arm/include/asm/arch-adi/sc5xx/spl.h
+++ b/arch/arm/include/asm/arch-adi/sc5xx/spl.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
 #ifndef ARCH_ADI_SC5XX_SPL_H
 #define ARCH_ADI_SC5XX_SPL_H
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index ec1d5539dc9..1486656b36b 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 # All 32-bit platforms require SYS_ARM_CACHE_WRITETHROUGH
diff --git a/arch/arm/mach-sc5xx/Makefile b/arch/arm/mach-sc5xx/Makefile
index 47b28200a03..4aaf94f6b9f 100644
--- a/arch/arm/mach-sc5xx/Makefile
+++ b/arch/arm/mach-sc5xx/Makefile
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 obj-y +=3D soc.o init/
diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
index b4eb1c42810..85889f54e89 100644
--- a/arch/arm/mach-sc5xx/config.mk
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 ifdef CONFIG_XPL_BUILD
diff --git a/arch/arm/mach-sc5xx/init/Makefile b/arch/arm/mach-sc5xx/init/M=
akefile
index 9d4920fe076..6f99bdaeb72 100644
--- a/arch/arm/mach-sc5xx/init/Makefile
+++ b/arch/arm/mach-sc5xx/init/Makefile
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 obj-y +=3D dmcinit.o clkinit.o
diff --git a/arch/arm/mach-sc5xx/init/clkinit.c b/arch/arm/mach-sc5xx/init/=
clkinit.c
index ae53cd61efd..3dcba33bd1b 100644
--- a/arch/arm/mach-sc5xx/init/clkinit.c
+++ b/arch/arm/mach-sc5xx/init/clkinit.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/arch-adi/sc5xx/sc5xx.h>
diff --git a/arch/arm/mach-sc5xx/init/clkinit.h b/arch/arm/mach-sc5xx/init/=
clkinit.h
index b05f4325bfc..035a766d266 100644
--- a/arch/arm/mach-sc5xx/init/clkinit.h
+++ b/arch/arm/mach-sc5xx/init/clkinit.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef CLKINIT_H_
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/=
dmcinit.c
index 30b77aee459..2bf2cc53a9f 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.c
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/io.h>
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.h b/arch/arm/mach-sc5xx/init/=
dmcinit.h
index 46ff729282d..6ddabdbf325 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.h
+++ b/arch/arm/mach-sc5xx/init/dmcinit.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef DMCINIT_H_
diff --git a/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h b/arch/arm/mach-s=
c5xx/init/mem/is43tr16512bl.h
index a5838370555..0cb1184c236 100644
--- a/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
+++ b/arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef IS43TR16512BL_H
diff --git a/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h b/arch/arm/mach-s=
c5xx/init/mem/mt41k128m16jt.h
index 882777521b8..7c1381e5a18 100644
--- a/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
+++ b/arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef MT41K128M16JT_H
diff --git a/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h b/arch/arm/mach-s=
c5xx/init/mem/mt41k512m16ha.h
index 5735b87871c..21e3f44ccb5 100644
--- a/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
+++ b/arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef MT41K512M16HA_H
diff --git a/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h b/arch/arm/mach-s=
c5xx/init/mem/mt47h128m16rt.h
index 5ada7f2985b..b0d012818cf 100644
--- a/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
+++ b/arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #ifndef MT47H128M16RT_H
diff --git a/arch/arm/mach-sc5xx/rcu.c b/arch/arm/mach-sc5xx/rcu.c
index 49357501a93..c9911be91d6 100644
--- a/arch/arm/mach-sc5xx/rcu.c
+++ b/arch/arm/mach-sc5xx/rcu.c
@@ -2,9 +2,8 @@
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Ian Roberts <ian.roberts@timesys.com>
  */
=20
 #include <dm.h>
diff --git a/arch/arm/mach-sc5xx/sc57x.c b/arch/arm/mach-sc5xx/sc57x.c
index b0587686d73..02b04cd1b2f 100644
--- a/arch/arm/mach-sc5xx/sc57x.c
+++ b/arch/arm/mach-sc5xx/sc57x.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/io.h>
diff --git a/arch/arm/mach-sc5xx/sc58x.c b/arch/arm/mach-sc5xx/sc58x.c
index 0f892774309..c981cafd986 100644
--- a/arch/arm/mach-sc5xx/sc58x.c
+++ b/arch/arm/mach-sc5xx/sc58x.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/io.h>
diff --git a/arch/arm/mach-sc5xx/sc59x.c b/arch/arm/mach-sc5xx/sc59x.c
index 174c6f5c445..675f8c7d69a 100644
--- a/arch/arm/mach-sc5xx/sc59x.c
+++ b/arch/arm/mach-sc5xx/sc59x.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/io.h>
diff --git a/arch/arm/mach-sc5xx/sc59x_64.c b/arch/arm/mach-sc5xx/sc59x_64.=
c
index 001747f223d..a8402075d0a 100644
--- a/arch/arm/mach-sc5xx/sc59x_64.c
+++ b/arch/arm/mach-sc5xx/sc59x_64.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/io.h>
diff --git a/arch/arm/mach-sc5xx/soc.c b/arch/arm/mach-sc5xx/soc.c
index 8f13127a660..cf8ff0dc3af 100644
--- a/arch/arm/mach-sc5xx/soc.c
+++ b/arch/arm/mach-sc5xx/soc.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <asm/arch-adi/sc5xx/sc5xx.h>
diff --git a/arch/arm/mach-sc5xx/spl.c b/arch/arm/mach-sc5xx/spl.c
index 68e0310f5af..c529829420d 100644
--- a/arch/arm/mach-sc5xx/spl.c
+++ b/arch/arm/mach-sc5xx/spl.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <spl.h>
diff --git a/drivers/clk/adi/Kconfig b/drivers/clk/adi/Kconfig
index 5745bedf88c..94cf744305f 100644
--- a/drivers/clk/adi/Kconfig
+++ b/drivers/clk/adi/Kconfig
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 config COMMON_CLK_ADI_SHARED
diff --git a/drivers/clk/adi/Makefile b/drivers/clk/adi/Makefile
index f3f1fd92e5f..b7664fe1da0 100644
--- a/drivers/clk/adi/Makefile
+++ b/drivers/clk/adi/Makefile
@@ -2,10 +2,7 @@
 #
 # (C) Copyright 2022 - Analog Devices, Inc.
 #
-# Written and/or maintained by Timesys Corporation
-#
-# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-# Contact: Greg Malysa <greg.malysa@timesys.com>
+# Written by Timesys Corporation
 #
=20
 obj-$(CONFIG_COMMON_CLK_ADI_SHARED) +=3D clk-shared.o clk-adi-pll.o
diff --git a/drivers/clk/adi/clk-adi-pll.c b/drivers/clk/adi/clk-adi-pll.c
index 372baa9c11b..34818cb1af0 100644
--- a/drivers/clk/adi/clk-adi-pll.c
+++ b/drivers/clk/adi/clk-adi-pll.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/clk/adi/clk-adi-sc57x.c b/drivers/clk/adi/clk-adi-sc57=
x.c
index b17563f0444..3eeb3109bd6 100644
--- a/drivers/clk/adi/clk-adi-sc57x.c
+++ b/drivers/clk/adi/clk-adi-sc57x.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/clk/adi/clk-adi-sc58x.c b/drivers/clk/adi/clk-adi-sc58=
x.c
index 05a0feddec7..776e4748c42 100644
--- a/drivers/clk/adi/clk-adi-sc58x.c
+++ b/drivers/clk/adi/clk-adi-sc58x.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/clk/adi/clk-adi-sc594.c b/drivers/clk/adi/clk-adi-sc59=
4.c
index c80bbf9728d..6749c6d0382 100644
--- a/drivers/clk/adi/clk-adi-sc594.c
+++ b/drivers/clk/adi/clk-adi-sc594.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/clk/adi/clk-adi-sc598.c b/drivers/clk/adi/clk-adi-sc59=
8.c
index d4a16ac9603..05176f2fa85 100644
--- a/drivers/clk/adi/clk-adi-sc598.c
+++ b/drivers/clk/adi/clk-adi-sc598.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
index dcadcafa9d2..afd5f46c845 100644
--- a/drivers/clk/adi/clk-shared.c
+++ b/drivers/clk/adi/clk-shared.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  */
diff --git a/drivers/clk/adi/clk.h b/drivers/clk/adi/clk.h
index f230205c311..acd4e384746 100644
--- a/drivers/clk/adi/clk.h
+++ b/drivers/clk/adi/clk.h
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
  *
diff --git a/drivers/dma/adi_dma.c b/drivers/dma/adi_dma.c
index 28afe488db0..9244ba22068 100644
--- a/drivers/dma/adi_dma.c
+++ b/drivers/dma/adi_dma.c
@@ -4,11 +4,8 @@
  *
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
- * Contact: Ian Roberts <ian.roberts@timesys.com>
  *
  */
 #include <dm.h>
diff --git a/drivers/gpio/adp5588_gpio.c b/drivers/gpio/adp5588_gpio.c
index 36304e48893..a5b2ccfea17 100644
--- a/drivers/gpio/adp5588_gpio.c
+++ b/drivers/gpio/adp5588_gpio.c
@@ -5,10 +5,8 @@
  *
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  * Based on Michael Hennerich's Linux driver:
  * Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/gpio/gpio-adi-adsp.c b/drivers/gpio/gpio-adi-adsp.c
index 0ce00572e08..af54354fa76 100644
--- a/drivers/gpio/gpio-adi-adsp.c
+++ b/drivers/gpio/gpio-adi-adsp.c
@@ -2,10 +2,9 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
- * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.co=
m>
  */
=20
 #include <dm.h>
diff --git a/drivers/i2c/adi_i2c.c b/drivers/i2c/adi_i2c.c
index 4cddcfa6b7f..c80a1517b5f 100644
--- a/drivers/i2c/adi_i2c.c
+++ b/drivers/i2c/adi_i2c.c
@@ -2,12 +2,10 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Converted to driver model by Nathan Barrett-Morrison
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  */
=20
 #include <clk.h>
diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
index f58897b5218..2bcd16ec3ba 100644
--- a/drivers/mmc/adi_sdhci.c
+++ b/drivers/mmc/adi_sdhci.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  * Based on Rockchip's sdhci.c file
  */
diff --git a/drivers/net/dwc_eth_qos_adi.c b/drivers/net/dwc_eth_qos_adi.c
index fee50a88156..b578225eaad 100644
--- a/drivers/net/dwc_eth_qos_adi.c
+++ b/drivers/net/dwc_eth_qos_adi.c
@@ -2,10 +2,9 @@
 /**
  * (C) Copyright 2024 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
- * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.co=
m>
  */
=20
 #include <clk.h>
diff --git a/drivers/pinctrl/pinctrl-adi-adsp.c b/drivers/pinctrl/pinctrl-a=
di-adsp.c
index debf434212d..e39f88c8b26 100644
--- a/drivers/pinctrl/pinctrl-adi-adsp.c
+++ b/drivers/pinctrl/pinctrl-adi-adsp.c
@@ -2,10 +2,9 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
- * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.co=
m>
  *
  * dm pinctrl implementation for ADI ADSP SoCs
  *
diff --git a/drivers/remoteproc/adi_sc5xx_rproc.c b/drivers/remoteproc/adi_=
sc5xx_rproc.c
index 86acd1b98c7..b96603263a5 100644
--- a/drivers/remoteproc/adi_sc5xx_rproc.c
+++ b/drivers/remoteproc/adi_sc5xx_rproc.c
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  * Analog Devices SC5xx remoteproc driver for loading code onto SHARC core=
s
  */
diff --git a/drivers/serial/serial_adi_uart4.c b/drivers/serial/serial_adi_=
uart4.c
index 45f8315d0a0..24b2071d705 100644
--- a/drivers/serial/serial_adi_uart4.c
+++ b/drivers/serial/serial_adi_uart4.c
@@ -2,12 +2,10 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Converted to driver model by Nathan Barrett-Morrison
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  */
=20
diff --git a/drivers/spi/adi_spi3.c b/drivers/spi/adi_spi3.c
index 2125d25561a..bc66dfbfdd6 100644
--- a/drivers/spi/adi_spi3.c
+++ b/drivers/spi/adi_spi3.c
@@ -2,14 +2,10 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Converted to driver model by Nathan Barrett-Morrison
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
- * Contact: Ian Roberts <ian.roberts@timesys.com>
- * Contact: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
  *
  */
=20
diff --git a/drivers/timer/adi_sc5xx_timer.c b/drivers/timer/adi_sc5xx_time=
r.c
index 11c098434a8..d9aef3da11e 100644
--- a/drivers/timer/adi_sc5xx_timer.c
+++ b/drivers/timer/adi_sc5xx_timer.c
@@ -2,12 +2,11 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Converted to driver model by Nathan Barrett-Morrison
  *
  * Author: Greg Malysa <greg.malysa@timesys.com>
- * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.co=
m>
  *
  * dm timer implementation for ADI ADSP-SC5xx SoCs
  *
diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
index 16201480b43..991846818a2 100644
--- a/drivers/usb/musb-new/sc5xx.c
+++ b/drivers/usb/musb-new/sc5xx.c
@@ -4,7 +4,7 @@
  *
  * ADI SC5XX MUSB "glue layer"
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Loosely ported from Linux driver:
  * Author: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
index 6f5b3d5d042..7d7cf98b55e 100644
--- a/drivers/watchdog/adi_wdt.c
+++ b/drivers/watchdog/adi_wdt.c
@@ -2,12 +2,10 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
  * Converted to driver model by Nathan Barrett-Morrison
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  * adi_wtd.c - driver for ADI on-chip watchdog
  *
diff --git a/include/dt-bindings/clock/adi-sc5xx-clock.h b/include/dt-bindi=
ngs/clock/adi-sc5xx-clock.h
index 4a5373d1141..94ab225d3b7 100644
--- a/include/dt-bindings/clock/adi-sc5xx-clock.h
+++ b/include/dt-bindings/clock/adi-sc5xx-clock.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  */
=20
diff --git a/include/dt-bindings/pinctrl/adi-adsp.h b/include/dt-bindings/p=
inctrl/adi-adsp.h
index 7dc8a1ef5c4..afe68e836e7 100644
--- a/include/dt-bindings/pinctrl/adi-adsp.h
+++ b/include/dt-bindings/pinctrl/adi-adsp.h
@@ -2,10 +2,8 @@
 /*
  * (C) Copyright 2022 - Analog Devices, Inc.
  *
- * Written and/or maintained by Timesys Corporation
+ * Written by Timesys Corporation
  *
- * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
- * Contact: Greg Malysa <greg.malysa@timesys.com>
  *
  */
=20
--=20
2.52.0


