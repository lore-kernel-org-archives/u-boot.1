Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CFFCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA92A87921;
	Mon, 23 Oct 2023 15:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FA887774; Mon, 23 Oct 2023 15:25:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A4D198791E
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B43C15;
 Mon, 23 Oct 2023 06:25:54 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD18F3F762;
 Mon, 23 Oct 2023 06:25:11 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 07/24] pinctrl: sunxi: remove GPIO_EXTRA_HEADER
Date: Mon, 23 Oct 2023 14:24:32 +0100
Message-Id: <20231023132449.813863-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

U-Boot's generic GPIO_EXTRA_HEADER is a convenience symbol to allow code
to more easily include platform specific GPIO headers. This should not
be needed in a DM world anymore, since the generic GPIO framework
handles that nicely.
For Allwinner boards we still need to deal with non-DM GPIO in the SPL,
but this should become the exception, not the rule.

Make this more obvious by removing the definition of GPIO_EXTRA_HEADER,
and just force every legacy user of platform specific GPIO to include
the new sunxi_gpio.h header explicitly. Everyone doing so should feel
ashamed and should find a way to avoid it from now on.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/Kconfig                                               | 1 -
 arch/arm/mach-sunxi/board.c                                    | 1 +
 arch/arm/mach-sunxi/dram_suniv.c                               | 2 +-
 arch/arm/mach-sunxi/spl_spi_sunxi.c                            | 1 +
 board/sunxi/board.c                                            | 1 +
 board/sunxi/chip.c                                             | 2 +-
 drivers/gpio/axp_gpio.c                                        | 1 +
 drivers/gpio/sunxi_gpio.c                                      | 1 +
 drivers/i2c/sun6i_p2wi.c                                       | 2 +-
 drivers/i2c/sun8i_rsb.c                                        | 2 +-
 drivers/mmc/sunxi_mmc.c                                        | 1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                          | 1 +
 drivers/video/hitachi_tx18d42vm_lcd.c                          | 1 +
 drivers/video/ssd2828.c                                        | 1 -
 drivers/video/sunxi/sunxi_display.c                            | 1 +
 drivers/video/sunxi/sunxi_lcd.c                                | 1 +
 arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h | 0
 17 files changed, 14 insertions(+), 6 deletions(-)
 rename arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dcccbfea42a..d812685c984 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1135,7 +1135,6 @@ config ARCH_SUNXI
 	select DM_MMC if MMC
 	select DM_SCSI if SCSI
 	select DM_SERIAL
-	select GPIO_EXTRA_HEADER
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select OF_SEPARATE
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 78597ad932c..4a1a0eacdba 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -17,6 +17,7 @@
 #include <i2c.h>
 #include <serial.h>
 #include <spl.h>
+#include <sunxi_gpio.h>
 #include <asm/cache.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-sunxi/dram_suniv.c b/arch/arm/mach-sunxi/dram_suniv.c
index 3aa3ce76272..9e583e18553 100644
--- a/arch/arm/mach-sunxi/dram_suniv.c
+++ b/arch/arm/mach-sunxi/dram_suniv.c
@@ -13,10 +13,10 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/dram.h>
-#include <asm/arch/gpio.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <hang.h>
+#include <sunxi_gpio.h>
 
 #define SDR_T_CAS			(0x2)
 #define SDR_T_RAS			(0x8)
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 81159cfee61..c2410dd7bb1 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <sunxi_gpio.h>
 
 #ifdef CONFIG_SPL_OS_BOOT
 #error CONFIG_SPL_OS_BOOT is not supported yet
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 5cfb33468e5..7a1c708b9f2 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -38,6 +38,7 @@
 #include <asm/armv7.h>
 #endif
 #include <asm/gpio.h>
+#include <sunxi_gpio.h>
 #include <asm/io.h>
 #include <u-boot/crc.h>
 #include <env_internal.h>
diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
index cde04bebe96..eeee6319e79 100644
--- a/board/sunxi/chip.c
+++ b/board/sunxi/chip.c
@@ -12,7 +12,7 @@
 #include <w1-eeprom.h>
 #include <dm/device-internal.h>
 
-#include <asm/arch/gpio.h>
+#include <sunxi_gpio.h>
 
 #include <extension_board.h>
 
diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
index 49672193ffc..af6631697f5 100644
--- a/drivers/gpio/axp_gpio.c
+++ b/drivers/gpio/axp_gpio.c
@@ -14,6 +14,7 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <errno.h>
+#include <sunxi_gpio.h>
 
 static int axp_gpio_set_value(struct udevice *dev, unsigned pin, int val);
 
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index d7f6a266e53..e335496581f 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <sunxi_gpio.h>
 
 /*
  * =======================================================================
diff --git a/drivers/i2c/sun6i_p2wi.c b/drivers/i2c/sun6i_p2wi.c
index d221323295d..b8e07a533ca 100644
--- a/drivers/i2c/sun6i_p2wi.c
+++ b/drivers/i2c/sun6i_p2wi.c
@@ -20,10 +20,10 @@
 #include <errno.h>
 #include <i2c.h>
 #include <reset.h>
+#include <sunxi_gpio.h>
 #include <time.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
-#include <asm/arch/gpio.h>
 #include <asm/arch/p2wi.h>
 #include <asm/arch/prcm.h>
 #include <asm/arch/sys_proto.h>
diff --git a/drivers/i2c/sun8i_rsb.c b/drivers/i2c/sun8i_rsb.c
index 47fa05b6d1c..f36f2c7afac 100644
--- a/drivers/i2c/sun8i_rsb.c
+++ b/drivers/i2c/sun8i_rsb.c
@@ -14,10 +14,10 @@
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
+#include <sunxi_gpio.h>
 #include <reset.h>
 #include <time.h>
 #include <asm/arch/cpu.h>
-#include <asm/arch/gpio.h>
 #include <asm/arch/prcm.h>
 #include <asm/arch/rsb.h>
 
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 23bc7da917a..03e33753fcf 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -27,6 +27,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/mmc.h>
 #include <linux/delay.h>
+#include <sunxi_gpio.h>
 
 #ifndef CCM_MMC_CTRL_MODE_SEL_NEW
 #define CCM_MMC_CTRL_MODE_SEL_NEW	0
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 946447e9136..fc80fe50b14 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -7,6 +7,7 @@
 #include <dm/pinctrl.h>
 #include <errno.h>
 #include <malloc.h>
+#include <sunxi_gpio.h>
 
 #include <asm/gpio.h>
 
diff --git a/drivers/video/hitachi_tx18d42vm_lcd.c b/drivers/video/hitachi_tx18d42vm_lcd.c
index 87c4d27438a..95984fe3d3d 100644
--- a/drivers/video/hitachi_tx18d42vm_lcd.c
+++ b/drivers/video/hitachi_tx18d42vm_lcd.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 
 #include <asm/gpio.h>
+#include <sunxi_gpio.h>
 #include <errno.h>
 
 /*
diff --git a/drivers/video/ssd2828.c b/drivers/video/ssd2828.c
index 4cdcbe7755a..948f5e74d0f 100644
--- a/drivers/video/ssd2828.c
+++ b/drivers/video/ssd2828.c
@@ -12,7 +12,6 @@
 #include <common.h>
 #include <malloc.h>
 #include <mipi_display.h>
-#include <asm/arch/gpio.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
 
diff --git a/drivers/video/sunxi/sunxi_display.c b/drivers/video/sunxi/sunxi_display.c
index 9110a484821..8da44a1bb6d 100644
--- a/drivers/video/sunxi/sunxi_display.c
+++ b/drivers/video/sunxi/sunxi_display.c
@@ -31,6 +31,7 @@
 #include <malloc.h>
 #include <video.h>
 #include <dm/uclass-internal.h>
+#include <sunxi_gpio.h>
 #include "../videomodes.h"
 #include "../anx9804.h"
 #include "../hitachi_tx18d42vm_lcd.h"
diff --git a/drivers/video/sunxi/sunxi_lcd.c b/drivers/video/sunxi/sunxi_lcd.c
index 8b9c3b2bfa9..7a01cc343ca 100644
--- a/drivers/video/sunxi/sunxi_lcd.c
+++ b/drivers/video/sunxi/sunxi_lcd.c
@@ -17,6 +17,7 @@
 #include <asm/arch/lcdc.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
+#include <sunxi_gpio.h>
 
 struct sunxi_lcd_priv {
 	struct display_timing timing;
diff --git a/arch/arm/include/asm/arch-sunxi/gpio.h b/include/sunxi_gpio.h
similarity index 100%
rename from arch/arm/include/asm/arch-sunxi/gpio.h
rename to include/sunxi_gpio.h
-- 
2.25.1

