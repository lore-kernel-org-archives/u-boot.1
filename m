Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6EFC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF868791F;
	Mon, 23 Oct 2023 15:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9E387918; Mon, 23 Oct 2023 15:25:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B9EA98790D
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E1F2F4;
 Mon, 23 Oct 2023 06:25:47 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BAD63F762;
 Mon, 23 Oct 2023 06:25:05 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 03/24] sunxi: remove CONFIG_MACPWR
Date: Mon, 23 Oct 2023 14:24:28 +0100
Message-Id: <20231023132449.813863-4-andre.przywara@arm.com>
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

The CONFIG_MACPWR Kconfig symbol is used to point to a GPIO that enables
the power for the Ethernet "MAC" (mostly PHY, really).
In the DT this is described with the phy-supply property in the MAC DT
node, pointing to a (GPIO controlled) regulator. Since we need Ethernet
only in U-Boot proper, and use a DM driver there, we should use the DT
instead of hardcoding this.

Add code to the sun8i_emac and sunxi_emac drivers to check the DT for
that regulator and enable it, at probe time. Then drop the current code
from board.c, which was doing that job before.
This allows us to remove the MACPWR Kconfig definition and the respective
values from the defconfigs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig           |  7 -------
 board/sunxi/board.c                   | 12 +-----------
 configs/Bananapi_M2_Ultra_defconfig   |  1 -
 configs/Bananapi_defconfig            |  1 -
 configs/Bananapro_defconfig           |  1 -
 configs/Lamobo_R1_defconfig           |  1 -
 configs/Mele_A1000_defconfig          |  1 -
 configs/Orangepi_defconfig            |  1 -
 configs/Orangepi_mini_defconfig       |  1 -
 configs/bananapi_m1_plus_defconfig    |  1 -
 configs/bananapi_m2_plus_h3_defconfig |  1 -
 configs/bananapi_m2_plus_h5_defconfig |  1 -
 configs/i12-tvbox_defconfig           |  1 -
 configs/jesurun_q5_defconfig          |  1 -
 configs/mixtile_loftq_defconfig       |  1 -
 configs/nanopi_m1_plus_defconfig      |  1 -
 configs/nanopi_neo_plus2_defconfig    |  1 -
 configs/nanopi_r1s_h5_defconfig       |  1 -
 configs/orangepi_pc2_defconfig        |  1 -
 configs/orangepi_plus2e_defconfig     |  1 -
 configs/orangepi_plus_defconfig       |  1 -
 configs/orangepi_win_defconfig        |  1 -
 configs/pine_h64_defconfig            |  1 -
 configs/zeropi_defconfig              |  1 -
 drivers/net/sun8i_emac.c              |  7 +++++++
 drivers/net/sunxi_emac.c              |  4 ++--
 26 files changed, 10 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 1b24dfe4dd1..d3ed62add99 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -695,13 +695,6 @@ config OLD_SUNXI_KERNEL_COMPAT
 	Set this to enable various workarounds for old kernels, this results in
 	sub-optimal settings for newer kernels, only enable if needed.
 
-config MACPWR
-	string "MAC power pin"
-	default ""
-	help
-	  Set the pin used to power the MAC. This takes a string in the format
-	  understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
-
 config MMC1_PINS_PH
 	bool "Pins for mmc1 are on Port H"
 	depends on MACH_SUN4I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 50a60e760d4..5cfb33468e5 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -187,7 +187,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 /* add board specific code here */
 int board_init(void)
 {
-	__maybe_unused int id_pfr1, ret, macpwr_pin;
+	__maybe_unused int id_pfr1, ret;
 
 	gd->bd->bi_boot_params = (PHYS_SDRAM_0 + 0x100);
 
@@ -224,15 +224,6 @@ int board_init(void)
 	if (ret)
 		return ret;
 
-	/* strcmp() would look better, but doesn't get optimised away. */
-	if (CONFIG_MACPWR[0]) {
-		macpwr_pin = sunxi_name_to_gpio(CONFIG_MACPWR);
-		if (macpwr_pin >= 0) {
-			gpio_request(macpwr_pin, "macpwr");
-			gpio_direction_output(macpwr_pin, 1);
-		}
-	}
-
 #if CONFIG_IS_ENABLED(DM_I2C)
 	/*
 	 * Temporary workaround for enabling I2C clocks until proper sunxi DM
@@ -240,7 +231,6 @@ int board_init(void)
 	 */
 	i2c_init_board();
 #endif
-
 	eth_init_board();
 
 	return 0;
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index a5fe76af568..2cc7bbbd8b7 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-r40-bananapi-m2-ultra"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_DRAM_CLK=576
-CONFIG_MACPWR="PA17"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB1_VBUS_PIN="PH23"
 CONFIG_USB2_VBUS_PIN="PH23"
diff --git a/configs/Bananapi_defconfig b/configs/Bananapi_defconfig
index 6c2a1f630e8..f4910ba13ac 100644
--- a/configs/Bananapi_defconfig
+++ b/configs/Bananapi_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-bananapi"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
diff --git a/configs/Bananapro_defconfig b/configs/Bananapro_defconfig
index 94fd74754ea..02be8971df9 100644
--- a/configs/Bananapro_defconfig
+++ b/configs/Bananapro_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-bananapro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_USB1_VBUS_PIN="PH0"
 CONFIG_USB2_VBUS_PIN="PH1"
 CONFIG_VIDEO_COMPOSITE=y
diff --git a/configs/Lamobo_R1_defconfig b/configs/Lamobo_R1_defconfig
index 9639cb6aad9..66f57ab3c85 100644
--- a/configs/Lamobo_R1_defconfig
+++ b/configs/Lamobo_R1_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-lamobo-r1"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
index f5b6d908cdc..9ac2e4839d9 100644
--- a/configs/Mele_A1000_defconfig
+++ b/configs/Mele_A1000_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-a1000"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_MACPWR="PH15"
 CONFIG_VIDEO_VGA=y
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_AHCI=y
diff --git a/configs/Orangepi_defconfig b/configs/Orangepi_defconfig
index c89a9a1f9dd..53edf525ec0 100644
--- a/configs/Orangepi_defconfig
+++ b/configs/Orangepi_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-orangepi"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_USB1_VBUS_PIN="PH26"
 CONFIG_USB2_VBUS_PIN="PH22"
 CONFIG_VIDEO_VGA=y
diff --git a/configs/Orangepi_mini_defconfig b/configs/Orangepi_mini_defconfig
index fe9ce808a1e..ccf32670170 100644
--- a/configs/Orangepi_mini_defconfig
+++ b/configs/Orangepi_mini_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-orangepi-mini"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
 CONFIG_USB1_VBUS_PIN="PH26"
 CONFIG_USB2_VBUS_PIN="PH22"
diff --git a/configs/bananapi_m1_plus_defconfig b/configs/bananapi_m1_plus_defconfig
index 0fbb619d623..a432a01f6b4 100644
--- a/configs/bananapi_m1_plus_defconfig
+++ b/configs/bananapi_m1_plus_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-bananapi-m1-plus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_MACPWR="PH23"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
diff --git a/configs/bananapi_m2_plus_h3_defconfig b/configs/bananapi_m2_plus_h3_defconfig
index 26ced59fb02..a8f9b5044b0 100644
--- a/configs/bananapi_m2_plus_h3_defconfig
+++ b/configs/bananapi_m2_plus_h3_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-bananapi-m2-plus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=672
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/bananapi_m2_plus_h5_defconfig b/configs/bananapi_m2_plus_h5_defconfig
index fb6c945919a..1634f626190 100644
--- a/configs/bananapi_m2_plus_h5_defconfig
+++ b/configs/bananapi_m2_plus_h5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun50i-h5-bananapi-m2-plus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_CLK=672
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/i12-tvbox_defconfig b/configs/i12-tvbox_defconfig
index 257dd89af45..37f0f53ae7d 100644
--- a/configs/i12-tvbox_defconfig
+++ b/configs/i12-tvbox_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-i12-tvbox"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_MACPWR="PH21"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/jesurun_q5_defconfig b/configs/jesurun_q5_defconfig
index 0ff666b2ee5..c99be7cea4e 100644
--- a/configs/jesurun_q5_defconfig
+++ b/configs/jesurun_q5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-jesurun-q5"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=312
-CONFIG_MACPWR="PH19"
 CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/mixtile_loftq_defconfig b/configs/mixtile_loftq_defconfig
index 0e4cdc44670..2f92228eb7b 100644
--- a/configs/mixtile_loftq_defconfig
+++ b/configs/mixtile_loftq_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-mixtile-loftq"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=251
-CONFIG_MACPWR="PA21"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB1_VBUS_PIN="PH24"
 CONFIG_USB2_VBUS_PIN=""
diff --git a/configs/nanopi_m1_plus_defconfig b/configs/nanopi_m1_plus_defconfig
index 76655d79ae0..078e98b644d 100644
--- a/configs/nanopi_m1_plus_defconfig
+++ b/configs/nanopi_m1_plus_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-nanopi-m1-plus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=408
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/nanopi_neo_plus2_defconfig b/configs/nanopi_neo_plus2_defconfig
index 924ff38f17c..85ff31c6fe5 100644
--- a/configs/nanopi_neo_plus2_defconfig
+++ b/configs/nanopi_neo_plus2_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/nanopi_r1s_h5_defconfig b/configs/nanopi_r1s_h5_defconfig
index 27cf172d72a..2a6f94afe40 100644
--- a/configs/nanopi_r1s_h5_defconfig
+++ b/configs/nanopi_r1s_h5_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_CLK=672
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/orangepi_pc2_defconfig b/configs/orangepi_pc2_defconfig
index 777af8c60ea..fb6fbaf787a 100644
--- a/configs/orangepi_pc2_defconfig
+++ b/configs/orangepi_pc2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_CLK=672
 CONFIG_DRAM_ZQ=3881977
-CONFIG_MACPWR="PD6"
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/orangepi_plus2e_defconfig b/configs/orangepi_plus2e_defconfig
index 138a6a72b8c..5e2cbc48ea2 100644
--- a/configs/orangepi_plus2e_defconfig
+++ b/configs/orangepi_plus2e_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-plus2e"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=672
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
index ed585881d49..092ce77a6c4 100644
--- a/configs/orangepi_plus_defconfig
+++ b/configs/orangepi_plus_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-plus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=672
-CONFIG_MACPWR="PD6"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB1_VBUS_PIN="PG13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/orangepi_win_defconfig b/configs/orangepi_win_defconfig
index df11ad8c8fd..3ddaf050a48 100644
--- a/configs/orangepi_win_defconfig
+++ b/configs/orangepi_win_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun50i-a64-orangepi-win"
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I=y
-CONFIG_MACPWR="PD14"
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/pine_h64_defconfig b/configs/pine_h64_defconfig
index 6dac6098d04..4712b8e4694 100644
--- a/configs/pine_h64_defconfig
+++ b/configs/pine_h64_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun50i-h6-pine-h64"
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H6=y
 CONFIG_SUNXI_DRAM_H6_LPDDR3=y
-CONFIG_MACPWR="PC16"
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB3_VBUS_PIN="PL5"
 CONFIG_SPL_SPI_SUNXI=y
diff --git a/configs/zeropi_defconfig b/configs/zeropi_defconfig
index 11f3715e6dc..7901bffd159 100644
--- a/configs/zeropi_defconfig
+++ b/configs/zeropi_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-zeropi"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=408
-CONFIG_MACPWR="PD6"
 # CONFIG_VIDEO_DE2 is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 04c3274fbe1..4ba9ee1529e 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -29,6 +29,7 @@
 #include <net.h>
 #include <reset.h>
 #include <wait_bit.h>
+#include <power/regulator.h>
 
 #define MDIO_CMD_MII_BUSY		BIT(0)
 #define MDIO_CMD_MII_WRITE		BIT(1)
@@ -170,6 +171,7 @@ struct emac_eth_dev {
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	struct gpio_desc reset_gpio;
 #endif
+	struct udevice *phy_reg;
 };
 
 
@@ -720,6 +722,9 @@ static int sun8i_emac_eth_probe(struct udevice *dev)
 
 	sun8i_emac_set_syscon(sun8i_pdata, priv);
 
+	if (priv->phy_reg)
+		regulator_set_enable(priv->phy_reg, true);
+
 	sun8i_mdio_init(dev->name, dev);
 	priv->bus = miiphy_get_dev_by_name(dev->name);
 
@@ -829,6 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 
 	priv->sysctl_reg = (void *)syscon_base + priv->variant->syscon_offset;
 
+	device_get_supply_regulator(dev, "phy-supply", &priv->phy_reg);
+
 	pdata->phy_interface = -1;
 	priv->phyaddr = -1;
 	priv->use_internal_phy = false;
diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
index b599b84852f..f546ad1fe8d 100644
--- a/drivers/net/sunxi_emac.c
+++ b/drivers/net/sunxi_emac.c
@@ -598,9 +598,9 @@ static int sunxi_emac_eth_of_to_plat(struct udevice *dev)
 	pdata->iobase = dev_read_addr(dev);
 
 	phy_node = dev_get_phy_node(dev);
-	if (phy_node == ofnode_null()) {
+	if (!ofnode_valid(phy_node)) {
 		dev_err(dev, "failed to get PHY node\n");
-		return ret;
+		return -ENOENT;
 	}
 	/*
 	 * The PHY regulator is in the MDIO node, not the EMAC or PHY node.
-- 
2.25.1

