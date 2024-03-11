Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CD4C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA46387E1A;
	Mon, 11 Mar 2024 13:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCBD88023; Mon, 11 Mar 2024 13:03:21 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA5F87F70
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb4z6tqWzMq49k;
 Mon, 11 Mar 2024 13:02:59 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb4y75Kyz3f; Mon, 11 Mar 2024 13:02:58 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:01:57 +0100
Subject: [PATCH v4 14/20] rockchip: include asm/io.h directly in
 asm/arch-rockchip/hardware.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-jaguar-v4-14-d2ca1af68ed3@theobroma-systems.com>
References: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
In-Reply-To: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The different macros use writel which is defined in asm/io.h, so let's
include the header so users of hardware.h do not need to include
asm/io.h as well.

While at it, remove asm/io.h includes wherever
asm/arch-rockchip/hardware.h is included already.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/hardware.h            | 2 ++
 arch/arm/mach-rockchip/cpu-info.c                        | 1 -
 arch/arm/mach-rockchip/px30/px30.c                       | 1 -
 arch/arm/mach-rockchip/rk3036/rk3036.c                   | 1 -
 arch/arm/mach-rockchip/rk3036/sdram_rk3036.c             | 1 -
 arch/arm/mach-rockchip/rk3066/rk3066.c                   | 1 -
 arch/arm/mach-rockchip/rk3188/rk3188.c                   | 1 -
 arch/arm/mach-rockchip/rk322x/rk322x.c                   | 1 -
 arch/arm/mach-rockchip/rk3288/rk3288.c                   | 1 -
 arch/arm/mach-rockchip/rk3308/rk3308.c                   | 1 -
 arch/arm/mach-rockchip/rk3328/rk3328.c                   | 1 -
 arch/arm/mach-rockchip/rk3368/rk3368.c                   | 1 -
 arch/arm/mach-rockchip/rk3399/rk3399.c                   | 1 -
 arch/arm/mach-rockchip/rk3568/rk3568.c                   | 1 -
 arch/arm/mach-rockchip/rk3588/rk3588.c                   | 1 -
 arch/arm/mach-rockchip/rv1126/rv1126.c                   | 1 -
 board/elgin/elgin_rv1108/elgin_rv1108.c                  | 1 -
 board/firefly/firefly-rk3308/roc_cc_rk3308.c             | 1 -
 board/google/gru/gru.c                                   | 1 -
 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c   | 1 -
 board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c | 1 -
 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c         | 1 -
 board/rockchip/evb_rv1108/evb_rv1108.c                   | 1 -
 board/theobroma-systems/puma_rk3399/puma-rk3399.c        | 1 -
 board/vamrs/rock960_rk3399/rock960-rk3399.c              | 1 -
 drivers/clk/rockchip/clk_pll.c                           | 1 -
 drivers/clk/rockchip/clk_px30.c                          | 1 -
 drivers/clk/rockchip/clk_rk3036.c                        | 1 -
 drivers/clk/rockchip/clk_rk3066.c                        | 1 -
 drivers/clk/rockchip/clk_rk3128.c                        | 1 -
 drivers/clk/rockchip/clk_rk3188.c                        | 1 -
 drivers/clk/rockchip/clk_rk322x.c                        | 1 -
 drivers/clk/rockchip/clk_rk3288.c                        | 1 -
 drivers/clk/rockchip/clk_rk3308.c                        | 1 -
 drivers/clk/rockchip/clk_rk3328.c                        | 1 -
 drivers/clk/rockchip/clk_rk3368.c                        | 1 -
 drivers/clk/rockchip/clk_rk3399.c                        | 1 -
 drivers/clk/rockchip/clk_rk3568.c                        | 1 -
 drivers/clk/rockchip/clk_rk3588.c                        | 1 -
 drivers/clk/rockchip/clk_rv1108.c                        | 1 -
 drivers/clk/rockchip/clk_rv1126.c                        | 1 -
 drivers/gpio/rk_gpio.c                                   | 1 -
 drivers/net/gmac_rockchip.c                              | 1 -
 drivers/ram/rockchip/dmc-rk3368.c                        | 1 -
 drivers/ram/rockchip/sdram_px30.c                        | 1 -
 drivers/ram/rockchip/sdram_rk3066.c                      | 1 -
 drivers/ram/rockchip/sdram_rk3188.c                      | 1 -
 drivers/ram/rockchip/sdram_rk322x.c                      | 1 -
 drivers/ram/rockchip/sdram_rk3288.c                      | 1 -
 drivers/ram/rockchip/sdram_rk3399.c                      | 1 -
 drivers/ram/rockchip/sdram_rv1126.c                      | 1 -
 drivers/rng/rockchip_rng.c                               | 1 -
 drivers/sysreset/sysreset_rockchip.c                     | 1 -
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c            | 1 -
 drivers/video/rockchip/rk3288_hdmi.c                     | 1 -
 drivers/video/rockchip/rk3288_mipi.c                     | 1 -
 drivers/video/rockchip/rk3288_vop.c                      | 1 -
 drivers/video/rockchip/rk3399_hdmi.c                     | 1 -
 drivers/video/rockchip/rk3399_mipi.c                     | 1 -
 drivers/video/rockchip/rk3399_vop.c                      | 1 -
 drivers/video/rockchip/rk_edp.c                          | 1 -
 drivers/video/rockchip/rk_hdmi.c                         | 1 -
 drivers/video/rockchip/rk_lvds.c                         | 1 -
 63 files changed, 2 insertions(+), 62 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/hardware.h b/arch/arm/include/asm/arch-rockchip/hardware.h
index 62e8bed8f31..e4662a2d52d 100644
--- a/arch/arm/include/asm/arch-rockchip/hardware.h
+++ b/arch/arm/include/asm/arch-rockchip/hardware.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_ARCH_HARDWARE_H
 #define _ASM_ARCH_HARDWARE_H
 
+#include <asm/io.h>
+
 #define RK_CLRSETBITS(clr, set)		((((clr) | (set)) << 16) | (set))
 #define RK_SETBITS(set)			RK_CLRSETBITS(0, set)
 #define RK_CLRBITS(clr)			RK_CLRSETBITS(clr, 0)
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index dac24910e0c..a62ff53c6a0 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -7,7 +7,6 @@
 #include <common.h>
 #include <env.h>
 #include <init.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index fc7456e680c..b4f655fa4b3 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -9,7 +9,6 @@
 #include <init.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_px30.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3036/rk3036.c b/arch/arm/mach-rockchip/rk3036/rk3036.c
index 0a072cf03a8..e8130abdd77 100644
--- a/arch/arm/mach-rockchip/rk3036/rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/rk3036.c
@@ -6,7 +6,6 @@
 #include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/grf_rk3036.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/sdram_rk3036.h>
diff --git a/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c b/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
index fcae65b2e5a..07cd29a33e6 100644
--- a/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
@@ -4,7 +4,6 @@
  */
 #include <common.h>
 #include <init.h>
-#include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch-rockchip/cru_rk3036.h>
 #include <asm/arch-rockchip/grf_rk3036.h>
diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
index 6661b788295..9a95ff85041 100644
--- a/arch/arm/mach-rockchip/rk3066/rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
@@ -4,7 +4,6 @@
  */
 
 #include <common.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3066.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3188/rk3188.c b/arch/arm/mach-rockchip/rk3188/rk3188.c
index c807221f33f..ffdcaa49a1e 100644
--- a/arch/arm/mach-rockchip/rk3188/rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/rk3188.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3188.h>
diff --git a/arch/arm/mach-rockchip/rk322x/rk322x.c b/arch/arm/mach-rockchip/rk322x/rk322x.c
index a304795fec6..712c0524266 100644
--- a/arch/arm/mach-rockchip/rk322x/rk322x.c
+++ b/arch/arm/mach-rockchip/rk322x/rk322x.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 #include <init.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk322x.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index d9f782e342b..c77c56c1dab 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -11,7 +11,6 @@
 #include <malloc.h>
 #include <asm/armv7.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cpu_rk3288.h>
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 6f121bf1304..27a748327e3 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -5,7 +5,6 @@
 #include <common.h>
 #include <init.h>
 #include <malloc.h>
-#include <asm/io.h>
 #include <asm/arch/grf_rk3308.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index b591d38fe41..b8e657e9bf4 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -10,7 +10,6 @@
 #include <asm/arch-rockchip/grf_rk3328.h>
 #include <asm/arch-rockchip/uart.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 
 #define CRU_BASE		0xFF440000
 #define GRF_BASE		0xFF100000
diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
index d009b8758e5..651ba109020 100644
--- a/arch/arm/mach-rockchip/rk3368/rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3368.h>
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index a1aa0e3e8b5..7fa1d7c7b7a 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -11,7 +11,6 @@
 #include <spl_gpio.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 69ef19cc85a..b30ea04f737 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -6,7 +6,6 @@
 #include <common.h>
 #include <dm.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 7a190e6aa18..eb65dafe3a2 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -7,7 +7,6 @@
 #include <common.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3588.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rv1126/rv1126.c b/arch/arm/mach-rockchip/rv1126/rv1126.c
index b9b898756f7..8589c46f10a 100644
--- a/arch/arm/mach-rockchip/rv1126/rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/rv1126.c
@@ -5,7 +5,6 @@
  */
 
 #include <common.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rv1126.h>
diff --git a/board/elgin/elgin_rv1108/elgin_rv1108.c b/board/elgin/elgin_rv1108/elgin_rv1108.c
index eb7a322d847..10398e7f712 100644
--- a/board/elgin/elgin_rv1108/elgin_rv1108.c
+++ b/board/elgin/elgin_rv1108/elgin_rv1108.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rv1108.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/firefly/firefly-rk3308/roc_cc_rk3308.c b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
index bdf3cc03dc5..99a52a77116 100644
--- a/board/firefly/firefly-rk3308/roc_cc_rk3308.c
+++ b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
@@ -5,7 +5,6 @@
 
 #include <common.h>
 #include <adc.h>
-#include <asm/io.h>
 #include <asm/arch/grf_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/bitops.h>
diff --git a/board/google/gru/gru.c b/board/google/gru/gru.c
index ecbf702b035..9cb3a525204 100644
--- a/board/google/gru/gru.c
+++ b/board/google/gru/gru.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
index 2408a367305..5e758ea6cd9 100644
--- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
+++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
@@ -7,7 +7,6 @@
 #include <common.h>
 #include <dm.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
index de75ee329d8..c9b0d5a061d 100644
--- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
+++ b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
@@ -8,7 +8,6 @@
 #include <dm.h>
 #include <init.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
index d0a694ead1d..fd78ad60d14 100644
--- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
+++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/rockchip/evb_rv1108/evb_rv1108.c b/board/rockchip/evb_rv1108/evb_rv1108.c
index e6ac598648d..0d7a486bed7 100644
--- a/board/rockchip/evb_rv1108/evb_rv1108.c
+++ b/board/rockchip/evb_rv1108/evb_rv1108.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rv1108.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
index 98a818b135d..8b998ef4556 100644
--- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
+++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
@@ -6,7 +6,6 @@
 #include <dm.h>
 #include <syscon.h>
 #include <dm/pinctrl.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
diff --git a/board/vamrs/rock960_rk3399/rock960-rk3399.c b/board/vamrs/rock960_rk3399/rock960-rk3399.c
index a7fc38d42f8..876be8ed9e1 100644
--- a/board/vamrs/rock960_rk3399/rock960-rk3399.c
+++ b/board/vamrs/rock960_rk3399/rock960-rk3399.c
@@ -5,7 +5,6 @@
 
 #include <common.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 1bb31b3313b..66f8bb16695 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -8,7 +8,6 @@
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <div64.h>
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index 93b76538509..2875c152b20 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -15,7 +15,6 @@
 #include <asm/arch-rockchip/cru_px30.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/px30-cru.h>
diff --git a/drivers/clk/rockchip/clk_rk3036.c b/drivers/clk/rockchip/clk_rk3036.c
index 6bc6d41ad61..6238b14c29e 100644
--- a/drivers/clk/rockchip/clk_rk3036.c
+++ b/drivers/clk/rockchip/clk_rk3036.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3036.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index 2c12f6e0441..f83335df6db 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -14,7 +14,6 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3066.h>
 #include <asm/arch-rockchip/grf_rk3066.h>
diff --git a/drivers/clk/rockchip/clk_rk3128.c b/drivers/clk/rockchip/clk_rk3128.c
index 13e176cdad1..182754e7052 100644
--- a/drivers/clk/rockchip/clk_rk3128.c
+++ b/drivers/clk/rockchip/clk_rk3128.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3128.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index ebdd1b3f99a..f98b46a0f73 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -13,7 +13,6 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3188.h>
 #include <asm/arch-rockchip/grf_rk3188.h>
diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
index 28cdba75758..9371c4f63a4 100644
--- a/drivers/clk/rockchip/clk_rk322x.c
+++ b/drivers/clk/rockchip/clk_rk322x.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk322x.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index e24c32c0a2a..0b7eefad15f 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -15,7 +15,6 @@
 #include <mapmem.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index d0a3f654466..7755b016111 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -12,7 +12,6 @@
 #include <malloc.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch/cru_rk3308.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index ef97381f0ed..cfec1d974ac 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -15,7 +15,6 @@
 #include <asm/arch-rockchip/cru_rk3328.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3328.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3328-cru.h>
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 3406ff592e1..1c5dfaa3800 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -18,7 +18,6 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3368.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3368-cru.h>
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index c37e8a53a26..80f65a237e8 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -14,7 +14,6 @@
 #include <mapmem.h>
 #include <syscon.h>
 #include <bitfield.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 68f5bbbb9e5..57ef27dda89 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -13,7 +13,6 @@
 #include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3568-cru.h>
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index a995dd5591d..8f33843179b 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -14,7 +14,6 @@
 #include <asm/arch-rockchip/cru_rk3588.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
index b0c889ae156..fc442f7eebe 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -13,7 +13,6 @@
 #include <malloc.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rv1108.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 580c0b1b0cf..cfdfcbdb0f4 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -16,7 +16,6 @@
 #include <asm/arch-rockchip/grf_rv1126.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <dm/device-internal.h>
-#include <asm/io.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rv1126-cru.h>
 
diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 4a6ae554bf7..c5e096bb1ad 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -11,7 +11,6 @@
 #include <syscon.h>
 #include <linux/errno.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/gpio.h>
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 04008d2b198..c1bae3f68bd 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -13,7 +13,6 @@
 #include <phy.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index 859fc47030f..5279bf0a154 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -13,7 +13,6 @@
 #include <ram.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3368.h>
 #include <asm/arch-rockchip/grf_rk3368.h>
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 2728d93be32..21498e89570 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <ram.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_px30.h>
 #include <asm/arch-rockchip/grf_px30.h>
diff --git a/drivers/ram/rockchip/sdram_rk3066.c b/drivers/ram/rockchip/sdram_rk3066.c
index 39c0be56a6e..562cf544c90 100644
--- a/drivers/ram/rockchip/sdram_rk3066.c
+++ b/drivers/ram/rockchip/sdram_rk3066.c
@@ -17,7 +17,6 @@
 #include <ram.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3066.h>
 #include <asm/arch-rockchip/ddr_rk3188.h>
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index d23d4231798..e1b28c6e593 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -17,7 +17,6 @@
 #include <ram.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3188.h>
 #include <asm/arch-rockchip/ddr_rk3188.h>
diff --git a/drivers/ram/rockchip/sdram_rk322x.c b/drivers/ram/rockchip/sdram_rk322x.c
index 892766a8b43..5fc23c11193 100644
--- a/drivers/ram/rockchip/sdram_rk322x.c
+++ b/drivers/ram/rockchip/sdram_rk322x.c
@@ -12,7 +12,6 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk322x.h>
 #include <asm/arch-rockchip/grf_rk322x.h>
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index 3177051dd12..242d564a7d2 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -17,7 +17,6 @@
 #include <ram.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/ddr_rk3288.h>
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 2bf8d48d25a..02cc4a38cf0 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -14,7 +14,6 @@
 #include <ram.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 0a78e18c732..849e15a9193 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -9,7 +9,6 @@
 #include <dm.h>
 #include <ram.h>
 #include <syscon.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/cru_rv1126.h>
diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 705b424cf3d..9dec7e45dde 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
  */
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/io.h>
 #include <common.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 0fc6b683f2b..f353f9b4c79 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <errno.h>
 #include <sysreset.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3328.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index 5e75b6ec68c..fb784636e87 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -27,7 +27,6 @@
 #include <common.h>
 #include <log.h>
 #include <video.h>
-#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <linux/bitops.h>
 #include <linux/time.h>
diff --git a/drivers/video/rockchip/rk3288_hdmi.c b/drivers/video/rockchip/rk3288_hdmi.c
index 8bedee55ad4..efa87540340 100644
--- a/drivers/video/rockchip/rk3288_hdmi.c
+++ b/drivers/video/rockchip/rk3288_hdmi.c
@@ -14,7 +14,6 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
diff --git a/drivers/video/rockchip/rk3288_mipi.c b/drivers/video/rockchip/rk3288_mipi.c
index c0dffa3cba2..9d42119c826 100644
--- a/drivers/video/rockchip/rk3288_mipi.c
+++ b/drivers/video/rockchip/rk3288_mipi.c
@@ -14,7 +14,6 @@
 #include "rk_mipi.h"
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
diff --git a/drivers/video/rockchip/rk3288_vop.c b/drivers/video/rockchip/rk3288_vop.c
index 44f32bb5fa2..a4683852ea0 100644
--- a/drivers/video/rockchip/rk3288_vop.c
+++ b/drivers/video/rockchip/rk3288_vop.c
@@ -12,7 +12,6 @@
 #include <syscon.h>
 #include <video.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockchip/rk3399_hdmi.c
index 3041360c6ed..5f3f5d26886 100644
--- a/drivers/video/rockchip/rk3399_hdmi.c
+++ b/drivers/video/rockchip/rk3399_hdmi.c
@@ -12,7 +12,6 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
diff --git a/drivers/video/rockchip/rk3399_mipi.c b/drivers/video/rockchip/rk3399_mipi.c
index 7fc79ba9045..b62d8086674 100644
--- a/drivers/video/rockchip/rk3399_mipi.c
+++ b/drivers/video/rockchip/rk3399_mipi.c
@@ -14,7 +14,6 @@
 #include "rk_mipi.h"
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
diff --git a/drivers/video/rockchip/rk3399_vop.c b/drivers/video/rockchip/rk3399_vop.c
index a34b491058f..cb589c7537e 100644
--- a/drivers/video/rockchip/rk3399_vop.c
+++ b/drivers/video/rockchip/rk3399_vop.c
@@ -13,7 +13,6 @@
 #include <video.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
 #include "rk_vop.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index dbd70ad583a..5f68a610e4a 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -17,7 +17,6 @@
 #include <reset.h>
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/edp_rk3288.h>
diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
index 8dcd4d59645..044a29ee47a 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -15,7 +15,6 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include "rk_hdmi.h"
diff --git a/drivers/video/rockchip/rk_lvds.c b/drivers/video/rockchip/rk_lvds.c
index 9cf3e3ca768..d0a015e31ee 100644
--- a/drivers/video/rockchip/rk_lvds.c
+++ b/drivers/video/rockchip/rk_lvds.c
@@ -13,7 +13,6 @@
 #include <syscon.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>

-- 
2.44.0

