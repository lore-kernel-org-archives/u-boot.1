Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF7EC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F381288675;
	Sat, 20 Jul 2024 14:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721479700;
	bh=Aa8U5TbWQ/Df0QtGvZdWLeflZFUv7D/pZVLQ91r7r0U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K7Xs8a01F8dcQjq6EEcvTZnOU6+21LJW+dwxCbaHn1H7fIr/XEG/xoYL+mLh4Gib6
	 jxbRNwCeVqSPuV5F8G+S+Mxc959WRy5OhwdD3+mS3f5TsuH1kpTKK1JXfXHiy0+Q6O
	 aoYbym0OG9q9pg/HiUK+uiCQxc0NOd00EO92XCZPSlFrOv31PMMNOUYw3ySc+bDKOx
	 T0IY0iURfzP6DobMuL88/LX/ffNcs3l/bEUn9SwewcEJsT8XmNN9p7o7GJCW1iN8DK
	 YbwAUrDPuOWMnPkxB5/L2r0CD2f+GxyNXRojUEekkz7IjWPoBG8cRmYEaDLL1Chq8p
	 6CIs6FLoQVcKA==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 082448852E;
 Sat, 20 Jul 2024 14:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721479699;
 bh=Aa8U5TbWQ/Df0QtGvZdWLeflZFUv7D/pZVLQ91r7r0U=;
 h=From:To:Cc:Subject:Date:From;
 b=SmwYVEhDusVcN7tlhfBex/7xTtlreQqq3/fL5+M8TKd6JSwJt/CrOVArP9W5zS4lO
 p8i8rdTY4k2359emTq5sno1rioZ4qXgkKNnjP+E2d4KK7Yj5wb0PUZl0wHbU8bh5uG
 HCA/bjuGWVj2rRzqYOUzwtqTbqhOCFsnkP+VK51cnnrH7pQ+FPQYLZZ9DR2uh/1Fk2
 z/RjzyAalgbX/75gd3xAcTfkheK6FITAlMVEptmeGkuIQpD5BA2K95NNQCBqYlpFxv
 SenQXeXBJ1WxLFgHrHdzehaV9UtKRRxxQH/+9yx9TmhXKMqx56DtBvh5KVWD1JqIXg
 i09n664dNlqwg==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] nitrogen6x: convert to DM_I2C and DM_SERIAL
Date: Sat, 20 Jul 2024 14:48:03 +0200
Message-Id: <20240720124803.3505570-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
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

Rework to remove use of legacy I2C API. Also switch
to DM_SERIAL to avoid board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
---
 board/boundary/nitrogen6x/nitrogen6x.c | 79 ++------------------------
 configs/mx6qsabrelite_defconfig        |  7 +--
 configs/nitrogen6dl2g_defconfig        |  7 +--
 configs/nitrogen6dl_defconfig          |  7 +--
 configs/nitrogen6q2g_defconfig         |  7 +--
 configs/nitrogen6q_defconfig           |  7 +--
 configs/nitrogen6s1g_defconfig         |  7 +--
 configs/nitrogen6s_defconfig           |  7 +--
 include/configs/nitrogen6x.h           |  2 -
 9 files changed, 26 insertions(+), 104 deletions(-)

diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrogen6x/nitrogen6x.c
index 2b0cb2361c..b85fd806cb 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -20,7 +20,6 @@
 #include <linux/errno.h>
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/mach-imx/sata.h>
 #include <asm/mach-imx/spi.h>
 #include <asm/mach-imx/boot_mode.h>
@@ -56,10 +55,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define BUTTON_PAD_CTRL (PAD_CTL_PUS_100K_UP |			\
 	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm | PAD_CTL_HYS)
 
-#define I2C_PAD_CTRL	(PAD_CTL_PUS_100K_UP |			\
-	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm | PAD_CTL_HYS |	\
-	PAD_CTL_ODE | PAD_CTL_SRE_FAST)
-
 #define RGB_PAD_CTRL	PAD_CTL_DSE_120ohm
 
 #define WEAK_PULLUP	(PAD_CTL_PUS_100K_UP |			\
@@ -72,53 +67,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define OUTPUT_40OHM (PAD_CTL_SPEED_MED|PAD_CTL_DSE_40ohm)
 
-/* Prevent compiler error if gpio number 08 or 09 is used */
-#define not_octal(gp) ((((0x##gp >> 4) & 0xf) * 10) + ((0x##gp & 0xf)))
-
-#define _I2C_PADS_INFO_CPU(cpu, i2cnum, scl_pad, scl_bank, scl_gp,	       \
-		sda_pad, sda_bank, sda_gp, pad_ctrl, join_io) {		       \
-	.scl = {							       \
-		.i2c_mode = NEW_PAD_CTRL(cpu##_PAD_##scl_pad##__##i2cnum##_SCL,\
-					 pad_ctrl),			       \
-		.gpio_mode = NEW_PAD_CTRL(				       \
-			cpu##_PAD_##scl_pad##__GPIO##scl_bank##join_io##scl_gp,\
-			pad_ctrl),					       \
-		.gp = IMX_GPIO_NR(scl_bank, not_octal(scl_gp))		       \
-	},								       \
-	.sda = {							       \
-		.i2c_mode = NEW_PAD_CTRL(cpu##_PAD_##sda_pad##__##i2cnum##_SDA,\
-					 pad_ctrl),			       \
-		.gpio_mode = NEW_PAD_CTRL(				       \
-			cpu##_PAD_##sda_pad##__GPIO##sda_bank##join_io##sda_gp,\
-			pad_ctrl),					       \
-			.gp = IMX_GPIO_NR(sda_bank, not_octal(sda_gp))	       \
-	}								       \
-}
-
-#define I2C_PADS_INFO_CPU(cpu, i2cnum, scl_pad, scl_bank, scl_gp,	       \
-		sda_pad, sda_bank, sda_gp, pad_ctrl)			       \
-		_I2C_PADS_INFO_CPU(cpu, i2cnum, scl_pad, scl_bank, scl_gp,     \
-				sda_pad, sda_bank, sda_gp, pad_ctrl, _IO)
-
 #if defined(CONFIG_MX6QDL)
-#define I2C_PADS_INFO_ENTRY(i2cnum, scl_pad, scl_bank, scl_gp,		\
-		sda_pad, sda_bank, sda_gp, pad_ctrl)			\
-	I2C_PADS_INFO_CPU(MX6Q, i2cnum, scl_pad, scl_bank, scl_gp,	\
-		sda_pad, sda_bank, sda_gp, pad_ctrl),			\
-	I2C_PADS_INFO_CPU(MX6DL, i2cnum, scl_pad, scl_bank, scl_gp,	\
-		sda_pad, sda_bank, sda_gp, pad_ctrl)
-#define I2C_PADS_INFO_ENTRY_SPACING 2
-
 #define IOMUX_PAD_CTRL(name, pad_ctrl) \
 		NEW_PAD_CTRL(MX6Q_PAD_##name, pad_ctrl),	\
 		NEW_PAD_CTRL(MX6DL_PAD_##name, pad_ctrl)
 #else
-#define I2C_PADS_INFO_ENTRY(i2cnum, scl_pad, scl_bank, scl_gp,		\
-		sda_pad, sda_bank, sda_gp, pad_ctrl)			\
-	I2C_PADS_INFO_CPU(MX6, i2cnum, scl_pad, scl_bank, scl_gp,	\
-		sda_pad, sda_bank, sda_gp, pad_ctrl)
-#define I2C_PADS_INFO_ENTRY_SPACING 1
-
 #define IOMUX_PAD_CTRL(name, pad_ctrl) NEW_PAD_CTRL(MX6_PAD_##name, pad_ctrl)
 #endif
 
@@ -139,18 +92,6 @@ static iomux_v3_cfg_t const uart2_pads[] = {
 	IOMUX_PAD_CTRL(EIM_D27__UART2_RX_DATA, UART_PAD_CTRL),
 };
 
-static struct i2c_pads_info i2c_pads[] = {
-	/* I2C1, SGTL5000 */
-	I2C_PADS_INFO_ENTRY(I2C1, EIM_D21, 3, 21, EIM_D28, 3, 28, I2C_PAD_CTRL),
-	/* I2C2 Camera, MIPI */
-	I2C_PADS_INFO_ENTRY(I2C2, KEY_COL3, 4, 12, KEY_ROW3, 4, 13,
-			    I2C_PAD_CTRL),
-	/* I2C3, J15 - RGB connector */
-	I2C_PADS_INFO_ENTRY(I2C3, GPIO_5, 1, 05, GPIO_16, 7, 11, I2C_PAD_CTRL),
-};
-
-#define I2C_BUS_CNT    3
-
 static iomux_v3_cfg_t const usdhc2_pads[] = {
 	IOMUX_PAD_CTRL(SD2_CLK__SD2_CLK, USDHC_PAD_CTRL),
 	IOMUX_PAD_CTRL(SD2_CMD__SD2_CMD, USDHC_PAD_CTRL),
@@ -420,9 +361,11 @@ static void do_enable_hdmi(struct display_info_t const *dev)
 
 static int detect_i2c(struct display_info_t const *dev)
 {
-	return ((0 == i2c_set_bus_num(dev->bus))
-		&&
-		(0 == i2c_probe(dev->addr)));
+	struct udevice *udev = NULL;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(dev->bus, dev->addr, 1, &udev);
+	return ret ? 0 : 1;
 }
 
 static void enable_lvds(struct display_info_t const *dev)
@@ -831,15 +774,7 @@ int overwrite_console(void)
 int board_init(void)
 {
 	struct iomuxc *const iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
-	struct i2c_pads_info *p = i2c_pads;
-	int i;
-	int stride = 1;
 
-#if defined(CONFIG_MX6QDL)
-	stride = 2;
-	if (!is_mx6dq() && !is_mx6dqp())
-		p += 1;
-#endif
 	clrsetbits_le32(&iomuxc_regs->gpr[1],
 			IOMUXC_GPR1_OTG_ID_MASK,
 			IOMUXC_GPR1_OTG_ID_GPIO1);
@@ -853,10 +788,6 @@ int board_init(void)
 	setup_spi();
 #endif
 	SETUP_IOMUX_PADS(usdhc2_pads);
-	for (i = 0; i < I2C_BUS_CNT; i++) {
-		setup_i2c(i, CONFIG_SYS_I2C_SPEED, 0x7f, p);
-		p += stride;
-	}
 
 #ifdef CONFIG_SATA
 	setup_sata();
diff --git a/configs/mx6qsabrelite_defconfig b/configs/mx6qsabrelite_defconfig
index ae9d1fa244..bb830c429d 100644
--- a/configs/mx6qsabrelite_defconfig
+++ b/configs/mx6qsabrelite_defconfig
@@ -10,9 +10,6 @@ CONFIG_ENV_OFFSET=0xC0000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6q.cfg"
 CONFIG_MX6Q=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=1024
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-sabrelite"
@@ -55,7 +52,7 @@ CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -68,6 +65,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6dl2g_defconfig b/configs/nitrogen6dl2g_defconfig
index 3ce26da1e7..7060d3cf96 100644
--- a/configs/nitrogen6dl2g_defconfig
+++ b/configs/nitrogen6dl2g_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6dl2g.cfg"
 CONFIG_MX6DL=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=2048
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-nitrogen6x"
@@ -61,7 +58,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -74,6 +71,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6dl_defconfig b/configs/nitrogen6dl_defconfig
index 6a0f48a73c..c2566c96ab 100644
--- a/configs/nitrogen6dl_defconfig
+++ b/configs/nitrogen6dl_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6dl.cfg"
 CONFIG_MX6DL=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=1024
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-nitrogen6x"
@@ -61,7 +58,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -74,6 +71,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6q2g_defconfig b/configs/nitrogen6q2g_defconfig
index 991311e7b6..07800eff08 100644
--- a/configs/nitrogen6q2g_defconfig
+++ b/configs/nitrogen6q2g_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6q2g.cfg"
 CONFIG_MX6Q=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=2048
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-nitrogen6x"
@@ -64,7 +61,7 @@ CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -77,6 +74,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6q_defconfig b/configs/nitrogen6q_defconfig
index 72085fce63..c5e6ce5285 100644
--- a/configs/nitrogen6q_defconfig
+++ b/configs/nitrogen6q_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6q.cfg"
 CONFIG_MX6Q=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=1024
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6q-nitrogen6x"
@@ -64,7 +61,7 @@ CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -77,6 +74,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6s1g_defconfig b/configs/nitrogen6s1g_defconfig
index b31182c1e3..e91c19d30e 100644
--- a/configs/nitrogen6s1g_defconfig
+++ b/configs/nitrogen6s1g_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6s1g.cfg"
 CONFIG_MX6S=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=1024
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-nitrogen6x"
@@ -61,7 +58,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -74,6 +71,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/nitrogen6s_defconfig b/configs/nitrogen6s_defconfig
index 4928f9c449..b8b410c2cf 100644
--- a/configs/nitrogen6s_defconfig
+++ b/configs/nitrogen6s_defconfig
@@ -11,9 +11,6 @@ CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_IMX_CONFIG="board/boundary/nitrogen6x/nitrogen6s.cfg"
 CONFIG_MX6S=y
 CONFIG_TARGET_NITROGEN6X=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DDR_MB=512
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6dl-nitrogen6x"
@@ -61,7 +58,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -74,6 +71,8 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index c9c599d076..c03d11dcda 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -11,8 +11,6 @@
 
 #include "mx6_common.h"
 
-#define CFG_MXC_UART_BASE	       UART2_BASE
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
 #define CFG_SYS_FSL_USDHC_NUM       2
-- 
2.25.1

