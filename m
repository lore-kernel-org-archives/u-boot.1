Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F773E743C6
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9239B86E59;
	Thu, 28 Sep 2023 23:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E22386E65; Thu, 28 Sep 2023 23:56:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7F98686E59
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5415CDA7;
 Thu, 28 Sep 2023 14:56:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB383F59C;
 Thu, 28 Sep 2023 14:56:04 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 01/22] sunxi: remove CONFIG_SATAPWR
Date: Thu, 28 Sep 2023 22:54:34 +0100
Message-Id: <20230928215455.28094-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

The CONFIG_SATAPWR Kconfig symbol was used to point to a GPIO that
enables the power for a SATA harddisk.
In the DT this is described with the target-supply property in the AHCI
DT node, pointing to a (GPIO controlled) regulator. Since we need SATA
only in U-Boot proper, and use a DM driver for AHCI there, we should use
the DT instead of hardcoding this.

Add code to the sunxi AHCI driver to check the DT for that regulator and
enable it, at probe time. Then drop the current code from board.c, which
was doing that job before.
This allows us to remove the SATAPWR Kconfig definition and the
respective values from the defconfigs.
We also select the generic fixed regulator driver, which handles those
GPIO controlled regulators.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/Kconfig                             |  2 ++
 arch/arm/mach-sunxi/Kconfig                  |  8 --------
 board/sunxi/board.c                          | 16 +---------------
 configs/A10-OLinuXino-Lime_defconfig         |  1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
 configs/A20-OLinuXino-Lime2_defconfig        |  1 -
 configs/A20-OLinuXino-Lime_defconfig         |  1 -
 configs/A20-OLinuXino_MICRO-eMMC_defconfig   |  1 -
 configs/A20-OLinuXino_MICRO_defconfig        |  1 -
 configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
 configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
 configs/Cubieboard2_defconfig                |  1 -
 configs/Cubieboard_defconfig                 |  1 -
 configs/Cubietruck_defconfig                 |  1 -
 configs/Itead_Ibox_A20_defconfig             |  1 -
 configs/Lamobo_R1_defconfig                  |  1 -
 configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
 configs/Linksprite_pcDuino3_defconfig        |  1 -
 configs/Sinovoip_BPI_M3_defconfig            |  1 -
 configs/orangepi_plus_defconfig              |  2 +-
 drivers/ata/ahci_sunxi.c                     |  9 +++++++++
 22 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71f820e443b..3fac92ebfcc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1158,6 +1158,8 @@ config ARCH_SUNXI
 	imply CMD_GPT
 	imply CMD_UBI if MTD_RAW_NAND
 	imply DISTRO_DEFAULTS
+	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
 	imply FAT_WRITE
 	imply FIT
 	imply OF_LIBFDT_OVERLAY
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 9d5df2c1027..1b24dfe4dd1 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1008,14 +1008,6 @@ config VIDEO_LCD_TL059WV5C0
 
 endchoice
 
-config SATAPWR
-	string "SATA power pin"
-	default ""
-	help
-	  Set the pins used to power the SATA. This takes a string in the
-	  format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of
-	  port H.
-
 config GMAC_TX_DELAY
 	int "GMAC Transmit Clock Delay Chain"
 	default 0
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ebaa9431984..50a60e760d4 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -187,7 +187,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 /* add board specific code here */
 int board_init(void)
 {
-	__maybe_unused int id_pfr1, ret, satapwr_pin, macpwr_pin;
+	__maybe_unused int id_pfr1, ret, macpwr_pin;
 
 	gd->bd->bi_boot_params = (PHYS_SDRAM_0 + 0x100);
 
@@ -225,20 +225,6 @@ int board_init(void)
 		return ret;
 
 	/* strcmp() would look better, but doesn't get optimised away. */
-	if (CONFIG_SATAPWR[0]) {
-		satapwr_pin = sunxi_name_to_gpio(CONFIG_SATAPWR);
-		if (satapwr_pin >= 0) {
-			gpio_request(satapwr_pin, "satapwr");
-			gpio_direction_output(satapwr_pin, 1);
-
-			/*
-			 * Give the attached SATA device time to power-up
-			 * to avoid link timeouts
-			 */
-			mdelay(500);
-		}
-	}
-
 	if (CONFIG_MACPWR[0]) {
 		macpwr_pin = sunxi_name_to_gpio(CONFIG_MACPWR);
 		if (macpwr_pin >= 0) {
diff --git a/configs/A10-OLinuXino-Lime_defconfig b/configs/A10-OLinuXino-Lime_defconfig
index df4fdfaba41..57e91d0f017 100644
--- a/configs/A10-OLinuXino-Lime_defconfig
+++ b/configs/A10-OLinuXino-Lime_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=480
 CONFIG_DRAM_EMR1=4
 CONFIG_SYS_CLK_FREQ=912000000
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-OLinuXino-Lime2-eMMC_defconfig b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
index be49e9323a1..44770ffb048 100644
--- a/configs/A20-OLinuXino-Lime2-eMMC_defconfig
+++ b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
@@ -8,7 +8,6 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_SPL_SPI_SUNXI=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/A20-OLinuXino-Lime2_defconfig b/configs/A20-OLinuXino-Lime2_defconfig
index 43cd28c3dd0..e10660c933c 100644
--- a/configs/A20-OLinuXino-Lime2_defconfig
+++ b/configs/A20-OLinuXino-Lime2_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=384
 CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-OLinuXino-Lime_defconfig b/configs/A20-OLinuXino-Lime_defconfig
index 7c77f38fba6..4ed666a034a 100644
--- a/configs/A20-OLinuXino-Lime_defconfig
+++ b/configs/A20-OLinuXino-Lime_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-OLinuXino_MICRO-eMMC_defconfig b/configs/A20-OLinuXino_MICRO-eMMC_defconfig
index 02116995a3e..ca5869f43d9 100644
--- a/configs/A20-OLinuXino_MICRO-eMMC_defconfig
+++ b/configs/A20-OLinuXino_MICRO-eMMC_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_I2C1_ENABLE=y
 CONFIG_VIDEO_VGA=y
-CONFIG_SATAPWR="PB8"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-OLinuXino_MICRO_defconfig b/configs/A20-OLinuXino_MICRO_defconfig
index 895e8dbcbd2..db4270f9b27 100644
--- a/configs/A20-OLinuXino_MICRO_defconfig
+++ b/configs/A20-OLinuXino_MICRO_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
 CONFIG_I2C1_ENABLE=y
 CONFIG_VIDEO_VGA=y
-CONFIG_SATAPWR="PB8"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-Olimex-SOM-EVB_defconfig b/configs/A20-Olimex-SOM-EVB_defconfig
index 5bcc9f9f3c0..ac900477d1e 100644
--- a/configs/A20-Olimex-SOM-EVB_defconfig
+++ b/configs/A20-Olimex-SOM-EVB_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
 CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_SATAPWR="PC3"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
index e5881090dda..00a98140b37 100644
--- a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
@@ -8,7 +8,6 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/A20-Olimex-SOM204-EVB_defconfig b/configs/A20-Olimex-SOM204-EVB_defconfig
index 592a79a6c7e..f4ae3ae6d8b 100644
--- a/configs/A20-Olimex-SOM204-EVB_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=384
 CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
-CONFIG_SATAPWR="PC3"
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Cubieboard2_defconfig b/configs/Cubieboard2_defconfig
index 0c233687413..ef4f11b7c62 100644
--- a/configs/Cubieboard2_defconfig
+++ b/configs/Cubieboard2_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-cubieboard2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=480
-CONFIG_SATAPWR="PB8"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Cubieboard_defconfig b/configs/Cubieboard_defconfig
index 71743f7b8a1..ab3f65ad667 100644
--- a/configs/Cubieboard_defconfig
+++ b/configs/Cubieboard_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-cubieboard"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=480
-CONFIG_SATAPWR="PB8"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Cubietruck_defconfig b/configs/Cubietruck_defconfig
index 184f305b19d..184143d7086 100644
--- a/configs/Cubietruck_defconfig
+++ b/configs/Cubietruck_defconfig
@@ -8,7 +8,6 @@ CONFIG_USB0_VBUS_PIN="PH17"
 CONFIG_USB0_VBUS_DET="PH22"
 CONFIG_USB0_ID_DET="PH19"
 CONFIG_VIDEO_VGA=y
-CONFIG_SATAPWR="PH12"
 CONFIG_GMAC_TX_DELAY=1
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Itead_Ibox_A20_defconfig b/configs/Itead_Ibox_A20_defconfig
index 5d05f337982..d03fa62196b 100644
--- a/configs/Itead_Ibox_A20_defconfig
+++ b/configs/Itead_Ibox_A20_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-itead-ibox"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=480
-CONFIG_SATAPWR="PB8"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Lamobo_R1_defconfig b/configs/Lamobo_R1_defconfig
index 5294608459b..9639cb6aad9 100644
--- a/configs/Lamobo_R1_defconfig
+++ b/configs/Lamobo_R1_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
 CONFIG_MACPWR="PH23"
-CONFIG_SATAPWR="PB3"
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Linksprite_pcDuino3_Nano_defconfig b/configs/Linksprite_pcDuino3_Nano_defconfig
index e3e30a49490..9eb9a918aee 100644
--- a/configs/Linksprite_pcDuino3_Nano_defconfig
+++ b/configs/Linksprite_pcDuino3_Nano_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_ZQ=122
 CONFIG_USB1_VBUS_PIN="PH11"
-CONFIG_SATAPWR="PH2"
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Linksprite_pcDuino3_defconfig b/configs/Linksprite_pcDuino3_defconfig
index 1fda0db4c9d..7db10e685bc 100644
--- a/configs/Linksprite_pcDuino3_defconfig
+++ b/configs/Linksprite_pcDuino3_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=122
-CONFIG_SATAPWR="PH2"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_defconfig
index 5642e52ec50..ad41dbd26a1 100644
--- a/configs/Sinovoip_BPI_M3_defconfig
+++ b/configs/Sinovoip_BPI_M3_defconfig
@@ -12,7 +12,6 @@ CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH11"
 CONFIG_USB1_VBUS_PIN="PD24"
 CONFIG_AXP_GPIO=y
-CONFIG_SATAPWR="PD25"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
index 76de72aa228..ed585881d49 100644
--- a/configs/orangepi_plus_defconfig
+++ b/configs/orangepi_plus_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=672
 CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB1_VBUS_PIN="PG13"
-CONFIG_SATAPWR="PG11"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
@@ -16,3 +15,4 @@ CONFIG_SUN8I_EMAC=y
 CONFIG_SY8106A_POWER=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB3_VBUS_PIN="PG11"
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 94a3379c532..9064774e661 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -7,6 +7,7 @@
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
+#include <power/regulator.h>
 
 #define AHCI_PHYCS0R 0x00c0
 #define AHCI_PHYCS1R 0x00c4
@@ -74,6 +75,7 @@ static int sunxi_ahci_phy_init(u8 *reg_base)
 
 static int sunxi_sata_probe(struct udevice *dev)
 {
+	struct udevice *reg_dev;
 	ulong base;
 	u8 *reg;
 	int ret;
@@ -89,6 +91,13 @@ static int sunxi_sata_probe(struct udevice *dev)
 		debug("%s: Failed to init phy (err=%d)\n", __func__, ret);
 		return ret;
 	}
+
+	ret = device_get_supply_regulator(dev, "target-supply", &reg_dev);
+	if (ret == 0) {
+		regulator_set_enable(reg_dev, true);
+		mdelay(500);
+	}
+
 	ret = ahci_probe_scsi(dev, base);
 	if (ret) {
 		debug("%s: Failed to probe (err=%d)\n", __func__, ret);
-- 
2.35.8

