Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC20C46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDFC879D5;
	Wed,  3 Jan 2024 01:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295FD879C5; Wed,  3 Jan 2024 01:13:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C6A0087927
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB6314BF;
 Tue,  2 Jan 2024 16:14:22 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 567493F5A1;
 Tue,  2 Jan 2024 16:13:35 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 06/19] sunxi: remove common.h inclusion
Date: Wed,  3 Jan 2024 00:12:26 +0000
Message-Id: <20240103001239.17482-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

The usage of the common.h include file is deprecated, and has already
been removed from several files.

Get rid of all inclusions in the arch/arm/mach-sunxi directory. Most
files actually don't need the header at all, for the few others just
include the headers that we actually require.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/board.c            | 1 -
 arch/arm/mach-sunxi/clock.c            | 1 -
 arch/arm/mach-sunxi/clock_sun4i.c      | 1 -
 arch/arm/mach-sunxi/clock_sun50i_h6.c  | 1 -
 arch/arm/mach-sunxi/clock_sun6i.c      | 1 -
 arch/arm/mach-sunxi/clock_sun8i_a83t.c | 1 -
 arch/arm/mach-sunxi/clock_sun9i.c      | 1 -
 arch/arm/mach-sunxi/cpu_info.c         | 1 -
 arch/arm/mach-sunxi/dram_helpers.c     | 3 ++-
 arch/arm/mach-sunxi/dram_sun4i.c       | 1 -
 arch/arm/mach-sunxi/dram_sun50i_h6.c   | 1 -
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 1 -
 arch/arm/mach-sunxi/dram_sun6i.c       | 1 -
 arch/arm/mach-sunxi/dram_sun8i_a23.c   | 1 -
 arch/arm/mach-sunxi/dram_sun8i_a33.c   | 1 -
 arch/arm/mach-sunxi/dram_sun8i_a83t.c  | 1 -
 arch/arm/mach-sunxi/dram_sun9i.c       | 1 -
 arch/arm/mach-sunxi/dram_suniv.c       | 2 +-
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 1 -
 arch/arm/mach-sunxi/gtbus_sun9i.c      | 1 -
 arch/arm/mach-sunxi/pmic_bus.c         | 1 -
 arch/arm/mach-sunxi/prcm.c             | 1 -
 arch/arm/mach-sunxi/spl_spi_sunxi.c    | 1 -
 arch/arm/mach-sunxi/timer.c            | 1 -
 24 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index d998149e375..0140b07d32a 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -9,7 +9,6 @@
  * Some init for sunxi platform.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-sunxi/clock.c b/arch/arm/mach-sunxi/clock.c
index da3a0eb0584..b6c68c94f67 100644
--- a/arch/arm/mach-sunxi/clock.c
+++ b/arch/arm/mach-sunxi/clock.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
index 471609764d2..8f1d1b65f00 100644
--- a/arch/arm/mach-sunxi/clock_sun4i.c
+++ b/arch/arm/mach-sunxi/clock_sun4i.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index bea91c78bc5..dac3663e1be 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-sunxi/clock_sun6i.c b/arch/arm/mach-sunxi/clock_sun6i.c
index 6bd75a15f6d..aad9df282ec 100644
--- a/arch/arm/mach-sunxi/clock_sun6i.c
+++ b/arch/arm/mach-sunxi/clock_sun6i.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2013 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
diff --git a/arch/arm/mach-sunxi/clock_sun8i_a83t.c b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
index 31e4281529a..198fe9dbd73 100644
--- a/arch/arm/mach-sunxi/clock_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2015 Vishnu Patekar <vishnupatekar0510@gmail.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
diff --git a/arch/arm/mach-sunxi/clock_sun9i.c b/arch/arm/mach-sunxi/clock_sun9i.c
index 8ba4802f3b3..edaff9a28ce 100644
--- a/arch/arm/mach-sunxi/clock_sun9i.c
+++ b/arch/arm/mach-sunxi/clock_sun9i.c
@@ -9,7 +9,6 @@
  *                    Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index 7fecc3b88dd..310dca06e57 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -5,7 +5,6 @@
  * Tom Cubie <tangliang@allwinnertech.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index cdf2750f1c5..4a867df7af8 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -5,8 +5,9 @@
  * (C) Copyright 2015 Hans de Goede <hdegoede@redhat.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <asm/barriers.h>
 #include <asm/io.h>
 #include <asm/arch/dram.h>
diff --git a/arch/arm/mach-sunxi/dram_sun4i.c b/arch/arm/mach-sunxi/dram_sun4i.c
index 80a6c4bc0fd..2cce381c9df 100644
--- a/arch/arm/mach-sunxi/dram_sun4i.c
+++ b/arch/arm/mach-sunxi/dram_sun4i.c
@@ -20,7 +20,6 @@
  * rather undocumented and full of magic.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index bff2e42513c..e7e2e6a06ff 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2017      Icenowy Zheng <icenowy@aosc.io>
  *
  */
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index c5c1331a4c3..68c49e85f9d 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -12,7 +12,6 @@
  * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
  *
  */
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun6i.c b/arch/arm/mach-sunxi/dram_sun6i.c
index 0590110d4ac..c023845908f 100644
--- a/arch/arm/mach-sunxi/dram_sun6i.c
+++ b/arch/arm/mach-sunxi/dram_sun6i.c
@@ -9,7 +9,6 @@
  *
  * (C) Copyright 2014 Hans de Goede <hdegoede@redhat.com>
  */
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun8i_a23.c b/arch/arm/mach-sunxi/dram_sun8i_a23.c
index 056cb03efb1..1c3c6d8126e 100644
--- a/arch/arm/mach-sunxi/dram_sun8i_a23.c
+++ b/arch/arm/mach-sunxi/dram_sun8i_a23.c
@@ -19,7 +19,6 @@
  * This may be used as a (possible) reference for future work / cleanups.
  */
 
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun8i_a33.c b/arch/arm/mach-sunxi/dram_sun8i_a33.c
index 367b74061ed..0d08b6a424e 100644
--- a/arch/arm/mach-sunxi/dram_sun8i_a33.c
+++ b/arch/arm/mach-sunxi/dram_sun8i_a33.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2015      Vishnu Patekar <vishnupatekar0510@gmail.com>
  * (C) Copyright 2015      Hans de Goede <hdegoede@redhat.com>
  */
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun8i_a83t.c b/arch/arm/mach-sunxi/dram_sun8i_a83t.c
index a3f833dd341..ef833321e37 100644
--- a/arch/arm/mach-sunxi/dram_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/dram_sun8i_a83t.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2015      Vishnu Patekar <vishnupatekar0510@gmail.com>
  * (C) Copyright 2015      Hans de Goede <hdegoede@redhat.com>
  */
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_sun9i.c b/arch/arm/mach-sunxi/dram_sun9i.c
index 14be212e891..002b6df39d5 100644
--- a/arch/arm/mach-sunxi/dram_sun9i.c
+++ b/arch/arm/mach-sunxi/dram_sun9i.c
@@ -10,7 +10,6 @@
  *                    Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/arch/arm/mach-sunxi/dram_suniv.c b/arch/arm/mach-sunxi/dram_suniv.c
index 9e583e18553..640f872ad4c 100644
--- a/arch/arm/mach-sunxi/dram_suniv.c
+++ b/arch/arm/mach-sunxi/dram_suniv.c
@@ -9,7 +9,7 @@
  * Copyright(c) 2007-2018 Jianjun Jiang <8192542@qq.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/dram.h>
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 9382d3d0be8..b4074f7d9b3 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -8,7 +8,6 @@
  * (C) Copyright 2015      Hans de Goede <hdegoede@redhat.com>
  * (C) Copyright 2015      Jens Kuske <jenskuske@gmail.com>
  */
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/gtbus_sun9i.c b/arch/arm/mach-sunxi/gtbus_sun9i.c
index 5624621b500..a058fea6bef 100644
--- a/arch/arm/mach-sunxi/gtbus_sun9i.c
+++ b/arch/arm/mach-sunxi/gtbus_sun9i.c
@@ -6,7 +6,6 @@
  *                    Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/gtbus_sun9i.h>
diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index 8e7625fe057..87df312725c 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -9,7 +9,6 @@
  */
 
 #include <axp_pmic.h>
-#include <common.h>
 #include <dm.h>
 #include <asm/arch/p2wi.h>
 #include <asm/arch/rsb.h>
diff --git a/arch/arm/mach-sunxi/prcm.c b/arch/arm/mach-sunxi/prcm.c
index 71a2e44918e..ef7c46eab3b 100644
--- a/arch/arm/mach-sunxi/prcm.c
+++ b/arch/arm/mach-sunxi/prcm.c
@@ -13,7 +13,6 @@
  * Tom Cubie <tangliang@allwinnertech.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index c2410dd7bb1..0a2714d2dd9 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Siarhei Siamashka <siarhei.siamashka@gmail.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <log.h>
 #include <spl.h>
diff --git a/arch/arm/mach-sunxi/timer.c b/arch/arm/mach-sunxi/timer.c
index 9a6f6c06d8c..1bbfad5e520 100644
--- a/arch/arm/mach-sunxi/timer.c
+++ b/arch/arm/mach-sunxi/timer.c
@@ -5,7 +5,6 @@
  * Tom Cubie <tangliang@allwinnertech.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
-- 
2.35.8

