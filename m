Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECADDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC168820A;
	Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649A288211; Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5021E881E7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYV0lKZz9tMS;
 Mon, 15 Apr 2024 08:08:14 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3tO6yCr8dEEo; Mon, 15 Apr 2024 08:08:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK45nVz9t5l;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 896DD8B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yKcu-wFuP_ni; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 596AF8B770;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 09/17] board: cssi: Add support for SPI bus on MCR3000 board
Date: Mon, 15 Apr 2024 08:07:22 +0200
Message-ID: <0eead0833a4fcf83f0e92b55cf665f164fdee10a.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

MCR3000 board has some components tied to the SPI bus, like the Texas
Instruments LM74 temperature sensor.

Add support for SPI bus. The SPI chipselects are a bit special in the
way that they are driven by 3 bits in a register of the board's CPLD
where the value writen in those bits exclusively activates one of the
7 possible chipselects and value 0 sets all chipselets to inactive.

So add a special GPIO driver that simulates GPIOs for those chipselect.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/dts/mcr3000.dts      |  31 +++++++++
 board/cssi/mcr3000/Makefile       |   1 +
 board/cssi/mcr3000/mcr3000.c      |   5 ++
 board/cssi/mcr3000/mcr3000_gpio.c | 109 ++++++++++++++++++++++++++++++
 configs/MCR3000_defconfig         |   5 ++
 5 files changed, 151 insertions(+)
 create mode 100644 board/cssi/mcr3000/mcr3000_gpio.c

diff --git a/arch/powerpc/dts/mcr3000.dts b/arch/powerpc/dts/mcr3000.dts
index c4d7737bc6..edcd8358d0 100644
--- a/arch/powerpc/dts/mcr3000.dts
+++ b/arch/powerpc/dts/mcr3000.dts
@@ -26,6 +26,37 @@
 			timeout-sec = <2>;
 			hw_margin_ms = <1000>;
 		};
+
+		spi: spi@aa0 {
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl,mpc8xx-spi";
+		};
+	};
+
+	localbus@ff000100 {
+		compatible = "s3k,mcr3000-localbus", "fsl,pq1-localbus", "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xff000100 0x40>;		// ORx and BRx register
+
+		ranges = <0 0 0x04000000 0x04000000 // BOOT
+			  1 0 0x00000000 0x04000000 // SDRAM
+			  2 0 0x08000000 0x04000000 // RAMDP
+			  3 0 0x0C000000 0x04000000 // NAND
+			  4 0 0x10000000 0x04000000 // Periphs
+			  5 0 0x14000000 0x04000000 // FPGA
+			  6 0 0x18000000 0x04000000 // mezzanine
+			  7 0 0x1c000000 0x04000000>; // DSP
+
+		csspi: gpio-controller@2 {
+			#gpio-cells = <2>;
+			compatible = "s3k,mcr3000-cpld-csspi";
+			reg = <4 0x802 2>;
+			gpio-controller;
+		};
 	};
 
 	SERIAL: smc@0 {
diff --git a/board/cssi/mcr3000/Makefile b/board/cssi/mcr3000/Makefile
index 7803016af3..846fd680e9 100644
--- a/board/cssi/mcr3000/Makefile
+++ b/board/cssi/mcr3000/Makefile
@@ -6,3 +6,4 @@
 
 obj-y += mcr3000.o
 obj-$(CONFIG_CMD_NAND) += nand.o
+obj-$(CONFIG_MPC8XX_SPI) += mcr3000_gpio.o
diff --git a/board/cssi/mcr3000/mcr3000.c b/board/cssi/mcr3000/mcr3000.c
index 8857c9e42c..537d7fa124 100644
--- a/board/cssi/mcr3000/mcr3000.c
+++ b/board/cssi/mcr3000/mcr3000.c
@@ -116,6 +116,11 @@ int misc_init_r(void)
 	clrbits_be16(&iop->iop_pcpar, 0x4);
 	clrbits_be16(&iop->iop_pcdir, 0x4);
 
+	/* Activate SPI */
+	clrsetbits_be32(&immr->im_cpm.cp_pbpar, 0x1, 0xe);
+	setbits_be32(&immr->im_cpm.cp_pbdir, 0xf);
+	clrbits_be32(&immr->im_cpm.cp_pbdat, 0x1);
+
 	/* if BTN_ACQ_AL is pressed then bootdelay is changed to 60 second */
 	if ((in_be16(&iop->iop_pcdat) & 0x0004) == 0)
 		env_set("bootdelay", "60");
diff --git a/board/cssi/mcr3000/mcr3000_gpio.c b/board/cssi/mcr3000/mcr3000_gpio.c
new file mode 100644
index 0000000000..2bba14e6e5
--- /dev/null
+++ b/board/cssi/mcr3000/mcr3000_gpio.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 CS GROUP France
+ *	Christophe Leroy <christophe.leroy@csgroup.eu>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <mapmem.h>
+#include <asm/gpio.h>
+#include <malloc.h>
+
+#include "../common/common.h"
+
+struct mcr3000_spi_gpio_plat {
+	ulong addr;
+};
+
+struct mcr3000_spi_gpio_data {
+	void __iomem *base;
+};
+
+static int mcr3000_spi_gpio_set_value(struct udevice *dev, uint gpio, int value)
+{
+	struct mcr3000_spi_gpio_data *data = dev_get_priv(dev);
+
+	if (value)
+		clrsetbits_be16(data->base, 7 << 5, (gpio & 7) << 5);
+	else
+		clrbits_be16(data->base, 7 << 5);
+
+	return 0;
+}
+
+static int mcr3000_spi_gpio_get_value(struct udevice *dev, uint gpio)
+{
+	struct mcr3000_spi_gpio_data *data = dev_get_priv(dev);
+
+	return gpio == ((in_be16(data->base) >> 5) & 7);
+}
+
+static int mcr3000_spi_gpio_direction_input(struct udevice *dev, uint gpio)
+{
+	return 0;
+}
+
+static int mcr3000_spi_gpio_get_function(struct udevice *dev, uint gpio)
+{
+	return GPIOF_OUTPUT;
+}
+
+static int mcr3000_spi_gpio_ofdata_to_platdata(struct udevice *dev)
+{
+	struct mcr3000_spi_gpio_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+	u32 reg[2];
+
+	dev_read_u32_array(dev, "reg", reg, 2);
+	addr = dev_translate_address(dev, reg);
+
+	plat->addr = addr;
+
+	return 0;
+}
+
+static int mcr3000_spi_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct mcr3000_spi_gpio_data *data = dev_get_priv(dev);
+	struct mcr3000_spi_gpio_plat *plat = dev_get_plat(dev);
+	char name[32], *str;
+
+	data->base = map_sysmem(plat->addr, 2);
+
+	snprintf(name, sizeof(name), "CHIPSELECT@%lx_", plat->addr);
+	str = strdup(name);
+
+	if (!str)
+		return -ENOMEM;
+
+	uc_priv->bank_name = str;
+	uc_priv->gpio_count = 16;
+
+	return 0;
+}
+
+static const struct dm_gpio_ops gpio_mcr3000_spi_ops = {
+	.get_value		= mcr3000_spi_gpio_get_value,
+	.set_value		= mcr3000_spi_gpio_set_value,
+	.direction_input	= mcr3000_spi_gpio_direction_input,
+	.direction_output	= mcr3000_spi_gpio_set_value,
+	.get_function		= mcr3000_spi_gpio_get_function,
+};
+
+static const struct udevice_id mcr3000_spi_gpio_ids[] = {
+	{ .compatible = "s3k,mcr3000-cpld-csspi"},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mcr3000_spi_gpio) = {
+	.name	= "mcr3000_spi_chipselect",
+	.id	= UCLASS_GPIO,
+	.ops	= &gpio_mcr3000_spi_ops,
+	.of_to_plat = mcr3000_spi_gpio_ofdata_to_platdata,
+	.plat_auto = sizeof(struct mcr3000_spi_gpio_plat),
+	.of_match = mcr3000_spi_gpio_ids,
+	.probe	= mcr3000_spi_gpio_probe,
+	.priv_auto = sizeof(struct mcr3000_spi_gpio_data),
+};
diff --git a/configs/MCR3000_defconfig b/configs/MCR3000_defconfig
index 8a88fb445c..ce34c2aa88 100644
--- a/configs/MCR3000_defconfig
+++ b/configs/MCR3000_defconfig
@@ -2,6 +2,7 @@ CONFIG_PPC=y
 CONFIG_TEXT_BASE=0x4000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_SECT_SIZE=0x2000
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="mcr3000"
 CONFIG_SYS_MONITOR_LEN=327680
 CONFIG_SYS_CLK_FREQ=132000000
@@ -91,6 +92,7 @@ CONFIG_SYS_OR6_PRELIM=0xFFFF0908
 CONFIG_SYS_BR7_PRELIM_BOOL=y
 CONFIG_SYS_BR7_PRELIM=0x1C000001
 CONFIG_SYS_OR7_PRELIM=0xFFFF810A
+CONFIG_MPC8XX_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -102,6 +104,9 @@ CONFIG_SYS_MAX_FLASH_SECT=35
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MPC8XX_FEC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MPC8XX_SPI=y
 CONFIG_WDT=y
 CONFIG_WDT_MPC8xxx_BME=y
 CONFIG_LZMA=y
-- 
2.43.0

