Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60351C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AD8887B9;
	Sat, 20 Jul 2024 17:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721489756;
	bh=w6USbBUcC9IcztNj5zmvFRQrM/lppYZNH0ktXM0ieDE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kimmnoRyFkWQtCa2I6FvLA1FbqKeGcs8nupE03f4GGmNGAhvrGaiwvt9Y6YOlqBI+
	 bK2b954JXLPc9pElOYSucGrWzZdtJ8hM5MXRw/Vifz1pFVfJJZLRFNS3ZEY6pJW+C+
	 elHGCS3P+L+gKY3ok20adkAHPZudJFr8JyRsP6hhKZensNsX474GO88yWM2EZ/BPl4
	 5seFGImHQFBWvVlqksG5IIiRCvSWOr2g/kkXFy1lAZid9HvcJjT2rkcs1X6kP2HnWE
	 GeX46sai8J51HiSZhpqP9fPv9MYtf/87K+wB6QQU1+dVJiDBCCTQO19EcSh04RHdru
	 mM9Oy9JOCKf3w==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BEDD9886FF;
 Sat, 20 Jul 2024 17:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721489755;
 bh=w6USbBUcC9IcztNj5zmvFRQrM/lppYZNH0ktXM0ieDE=;
 h=From:To:Cc:Subject:Date:From;
 b=pOWjkccRAYDV6P+QqyuqP/lzH7tmVbYv7z9KHMIiDLynFIXIgOm/g+9KRJNCgtOE8
 dQSRw/bsWxiK1WiNF7anYGiFORjCBw2Y8uJZjg4fUMhxH0oXuaz5DhG3uVbKEzMGB/
 bwR6OZyuqXkqEOKGaiZAh1wfU2wyh140USxLXLzM5RG/gyOojHFBEOfen5TmU5A3Kj
 eCcsmbxDX8ab2FIxjSh7I3ZgS2j4FuqseEEiLIc8UiEinAsW7c03UNf7xYNEFZRHDe
 RCTKFF5GJhmwLUiMei+uxS8RPmzbLMI1sjBwydnUxGrNwUlrpVQJeIwrmlp01a7zLG
 k1qAKeO772IAw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] mx6boards: convert to DM_I2C and DM_SERIAL
Date: Sat, 20 Jul 2024 17:35:39 +0200
Message-Id: <20240720153539.3550313-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rework to remove use of legacy I2C API. Also switch
to DM_SERIAL to avoid board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Eric Bénard <eric@eukrea.com>
---
 board/embest/mx6boards/mx6boards.c | 70 +++---------------------------
 configs/marsboard_defconfig        |  6 +--
 configs/riotboard_defconfig        |  6 +--
 3 files changed, 10 insertions(+), 72 deletions(-)

diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index 896350140d..cf3368c253 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -25,7 +25,6 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/mach-imx/spi.h>
 #include <asm/mach-imx/video.h>
 #include <i2c.h>
@@ -61,10 +60,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ENET_PAD_CTRL_CLK  ((PAD_CTL_PUS_100K_UP & ~PAD_CTL_PKE) | \
 	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST)
 
-#define I2C_PAD_CTRL	(PAD_CTL_PUS_100K_UP |			\
-	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm | PAD_CTL_HYS |	\
-	PAD_CTL_ODE | PAD_CTL_SRE_FAST)
-
 #define SPI_PAD_CTRL (PAD_CTL_HYS | PAD_CTL_SPEED_MED | \
 		      PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST)
 
@@ -148,57 +143,6 @@ static void setup_spi(void)
 }
 #endif
 
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX6_PAD_CSI0_DAT9__I2C1_SCL
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_CSI0_DAT9__GPIO5_IO27
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(5, 27)
-	},
-	.sda = {
-		.i2c_mode = MX6_PAD_CSI0_DAT8__I2C1_SDA
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_CSI0_DAT8__GPIO5_IO26
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(5, 26)
-	}
-};
-
-struct i2c_pads_info i2c_pad_info2 = {
-	.scl = {
-		.i2c_mode = MX6_PAD_KEY_COL3__I2C2_SCL
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_KEY_COL3__GPIO4_IO12
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(4, 12)
-	},
-	.sda = {
-		.i2c_mode = MX6_PAD_KEY_ROW3__I2C2_SDA
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_KEY_ROW3__GPIO4_IO13
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(4, 13)
-	}
-};
-
-struct i2c_pads_info i2c_pad_info3 = {
-	.scl = {
-		.i2c_mode = MX6_PAD_GPIO_5__I2C3_SCL
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_GPIO_5__GPIO1_IO05
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(1, 5)
-	},
-	.sda = {
-		.i2c_mode = MX6_PAD_GPIO_6__I2C3_SDA
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gpio_mode = MX6_PAD_GPIO_6__GPIO1_IO06
-				| MUX_PAD_CTRL(I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(1, 6)
-	}
-};
-
 iomux_v3_cfg_t const tft_pads_riot[] = {
 	/* LCD_PWR_EN */
 	MX6_PAD_ENET_TXD1__GPIO1_IO29 | MUX_PAD_CTRL(NO_PAD_CTRL),
@@ -258,8 +202,11 @@ static void do_enable_hdmi(struct display_info_t const *dev)
 
 static int detect_i2c(struct display_info_t const *dev)
 {
-	return (0 == i2c_set_bus_num(dev->bus)) &&
-		(0 == i2c_probe(dev->addr));
+	struct udevice *udev = NULL;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(dev->bus, dev->addr, 1, &udev);
+	return ret ? 0 : 1;
 }
 
 struct display_info_t const displays[] = {{
@@ -400,12 +347,7 @@ int board_init(void)
 {
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
-	/* i2c1 : PMIC, Audio codec on RiOT, Expansion connector on MarS */
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-	/* i2c2 : HDMI EDID */
-	setup_i2c(1, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info2);
-	/* i2c3 : LVDS, Expansion connector */
-	setup_i2c(2, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info3);
+
 #ifdef CONFIG_MXC_SPI
 	setup_spi();
 #endif
diff --git a/configs/marsboard_defconfig b/configs/marsboard_defconfig
index 8325aaa1c9..198fec2cb2 100644
--- a/configs/marsboard_defconfig
+++ b/configs/marsboard_defconfig
@@ -10,9 +10,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6q.cfg"
 CONFIG_MX6Q=y
 CONFIG_TARGET_EMBESTMX6BOARDS=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-marsboard"
 CONFIG_DISTRO_DEFAULTS=y
@@ -37,7 +34,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
@@ -50,6 +47,7 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index 1b303e738b..a1e806be42 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -12,9 +12,6 @@ CONFIG_ENV_OFFSET=0x60000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6s1g.cfg"
 CONFIG_MX6S=y
 CONFIG_TARGET_EMBESTMX6BOARDS=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-riotboard"
 CONFIG_SPL_TEXT_BASE=0x00908000
@@ -53,7 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -67,6 +64,7 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
-- 
2.25.1

