Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2E5C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 12:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5F5803DF;
	Thu,  5 Jun 2025 14:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749127059;
	bh=pKIEsSWDNvu3X7EI1wK6q966mzkLSYpZxVQwpXAae3s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ai41nNbvA7mWTldg65mu6AKuAMQZh4bIB/1l1g7B41V1/f9TEJpSAyQYRdqYCbT1G
	 ygmyM2a5QYT5i9tc9X/f6bsxJatxVDBUYKFC/ibMmaFaWMdEMWiDSbJYDbXVlVEsrn
	 G4SBRxmROCD/DFlznLcn88sNnSrWAlRj1D+zYPwt7Dd0YOgiSKjJOrzkKIjDsw2DWs
	 0f7ooM2bawmEl5AdT/rWh+9ktUOcKwUwkk1i8/2KWFJR7pWoXtC49kSaHFV3FfXQUc
	 BQ/sxvTu1DyXWd0lm4REp4ItbKFAdzTzwHXUP1hbzmkbKO68y8/onKQ4fmV7sbBjBY
	 UG4U17CW3Je5g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276508091A; Thu,  5 Jun 2025 14:37:39 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047F980050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZN4tp56+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D09A10397298; 
 Thu,  5 Jun 2025 14:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1749127054; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=pKIEsSWDNvu3X7EI1wK6q966mzkLSYpZxVQwpXAae3s=;
 b=ZN4tp56+CZsmJOwxGTd9Ao+fT1ouUL3NXFyJkdKtBFJvqDbuMMwsVtAMWby9fOzJEs2RD2
 ZhbghyAWTU/2jc893VNeE5jnDVcY0+kxOljScB+yvy4JmsEL5FQeNv4f+gFoqznzyrtCPL
 9YSVR9nkLUhBE4VCBz4SZuvUNmnZeeVcsq42rK4wDVOE1imUA8JLYFYaNtB8HWiuETVjqi
 wdbOrN5dgSNwIPtI1SiYZqVO/ashdGSeTBCZgv1QpzbexI+5E3R7+ybr0pDFXYjaPz4KAC
 inZgY1ymN/bY117dSYpkgzskc9PXYYco+DPwmk/7E4M+re+RZEyBBMS6B5SwAA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3] ARM: imx: mxs: Add support for imx287 based BTT devices
Date: Thu,  5 Jun 2025 14:36:57 +0200
Message-Id: <20250605123657.1083000-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The btt[c3] devices are based on imx287 SoC.

U-Boot SPL 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
Trying to boot from MMC1

U-Boot 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)

CPU:   Freescale i.MX28 rev1.2 at 454 MHz
BOOT:  SSP SPI #3, master, 3V3 NOR
Model: BTT3
Board: LWE BTT SoM HW rev 0
DRAM:  256 MiB
Core:  86 devices, 15 uclasses, devicetree: separate
MMC:   MXS MMC: 0
Loading Environment from SPIFlash... SF: Detected is25lp128 with page
                    size 256 Bytes, erase size 64 KiB, total 16 MiB
OK
In:    serial@80074000
Out:   serial@80074000
Err:   serial@80074000
Net:   eth0: ethernet@800f0000
Hit any key to stop autoboot:  0

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Replace README with entry in doc/boards (*.rst files)

Changes for v3:
- Keep alphabethical order in arch/arm/mach-imx/mxs/Kconfig
- Remove not needed headers (like <usb.h>) from btt.c file
- Add static to const iomux_cfg_t iomux_setup[] definition
- Use proper defines for HW_PINCTRL_EMI_DS_CTRL register setup
- Fix indentation in spl_btt.c
- Use SZ_256M instead of 0x10000000
- Add description regarding SPL and u-boot proper code
---
 arch/arm/dts/imx28-btt3-0-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-1-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-2-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-u-boot.dtsi   |  90 ++++++
 arch/arm/mach-imx/mxs/Kconfig         |   6 +
 board/liebherr/btt/Kconfig            |  24 ++
 board/liebherr/btt/MAINTAINERS        |   6 +
 board/liebherr/btt/Makefile           |   9 +
 board/liebherr/btt/boot_img_scr.h     |  27 ++
 board/liebherr/btt/btt.c              | 450 ++++++++++++++++++++++++++
 board/liebherr/btt/btt.env            | 139 ++++++++
 board/liebherr/btt/spl_btt.c          | 347 ++++++++++++++++++++
 configs/imx28_btt3_defconfig          | 140 ++++++++
 doc/board/index.rst                   |   1 +
 doc/board/liebherr/btt.rst            |  34 ++
 doc/board/liebherr/index.rst          |   9 +
 include/configs/btt.h                 |  18 ++
 17 files changed, 1321 insertions(+)
 create mode 100644 arch/arm/dts/imx28-btt3-0-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-1-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-u-boot.dtsi
 create mode 100644 board/liebherr/btt/Kconfig
 create mode 100644 board/liebherr/btt/MAINTAINERS
 create mode 100644 board/liebherr/btt/Makefile
 create mode 100644 board/liebherr/btt/boot_img_scr.h
 create mode 100644 board/liebherr/btt/btt.c
 create mode 100644 board/liebherr/btt/btt.env
 create mode 100644 board/liebherr/btt/spl_btt.c
 create mode 100644 configs/imx28_btt3_defconfig
 create mode 100644 doc/board/liebherr/btt.rst
 create mode 100644 doc/board/liebherr/index.rst
 create mode 100644 include/configs/btt.h

diff --git a/arch/arm/dts/imx28-btt3-0-u-boot.dtsi b/arch/arm/dts/imx28-btt3-0-u-boot.dtsi
new file mode 100644
index 00000000000..b128eef9e17
--- /dev/null
+++ b/arch/arm/dts/imx28-btt3-0-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include "imx28-btt3-u-boot.dtsi"
diff --git a/arch/arm/dts/imx28-btt3-1-u-boot.dtsi b/arch/arm/dts/imx28-btt3-1-u-boot.dtsi
new file mode 100644
index 00000000000..b128eef9e17
--- /dev/null
+++ b/arch/arm/dts/imx28-btt3-1-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include "imx28-btt3-u-boot.dtsi"
diff --git a/arch/arm/dts/imx28-btt3-2-u-boot.dtsi b/arch/arm/dts/imx28-btt3-2-u-boot.dtsi
new file mode 100644
index 00000000000..b128eef9e17
--- /dev/null
+++ b/arch/arm/dts/imx28-btt3-2-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include "imx28-btt3-u-boot.dtsi"
diff --git a/arch/arm/dts/imx28-btt3-u-boot.dtsi b/arch/arm/dts/imx28-btt3-u-boot.dtsi
new file mode 100644
index 00000000000..3569d29a737
--- /dev/null
+++ b/arch/arm/dts/imx28-btt3-u-boot.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/*
+ * The minimal augmentation DTS U-Boot file to allow eMMC driver
+ * configuration in SPL for falcon boot.
+ */
+#include "imx28-u-boot.dtsi"
+/ {
+	aliases {
+		/delete-property/ saif0;
+		/delete-property/ saif1;
+		/delete-property/ spi0;
+		/delete-property/ spi1;
+		/delete-property/ usbphy0;
+		/delete-property/ usbphy1;
+	};
+	apb@80000000 {
+		bootph-pre-ram;
+
+		apbh@80000000 {
+			bootph-pre-ram;
+		};
+
+		apbx@80040000 {
+			bootph-pre-ram;
+		};
+	};
+
+	/delete-node/ keypad;
+	/delete-node/ panel;
+	/delete-node/ sdio-pwrseq;
+	/delete-node/ sound;
+};
+
+&clks {
+	bootph-pre-ram;
+	status = "disable";
+};
+
+&duart {
+	/delete-property/ clocks;
+	bootph-pre-ram;
+	type = <1>; /* TYPE_PL011 */
+};
+
+&gpio0 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&pinctrl {
+	/delete-property/ pinctrl-names;
+	/delete-property/ pinctrl-0;
+	bootph-pre-ram;
+};
+
+&ssp0 {
+	bootph-pre-ram;
+};
+
+&ssp3 {
+	num-cs = <2>;
+	spi-max-frequency = <40000000>;
+	bootph-pre-ram;
+};
+
+/delete-node/ &hog_pins_a;
+/delete-node/ &keypad_pins_bttc;
+/delete-node/ &lcdif;
+/delete-node/ &lcdif_sync_pins_bttc;
+/delete-node/ &pwm;
+/delete-node/ &saif0;
+/delete-node/ &saif1;
+/delete-node/ &ssp1;
+/delete-node/ &ssp2;
+/delete-node/ &usb0;
+/delete-node/ &usb1;
+/delete-node/ &usbphy0;
+/delete-node/ &usbphy1;
diff --git a/arch/arm/mach-imx/mxs/Kconfig b/arch/arm/mach-imx/mxs/Kconfig
index d2e4205c5ce..b134d04b210 100644
--- a/arch/arm/mach-imx/mxs/Kconfig
+++ b/arch/arm/mach-imx/mxs/Kconfig
@@ -38,6 +38,11 @@ choice
 	prompt "MX28 board select"
 	optional
 
+config TARGET_BTT
+	bool "Support BTT"
+	select PL01X_SERIAL
+	imply OF_UPSTREAM
+
 config TARGET_MX28EVK
 	bool "Support mx28evk"
 	select PL01X_SERIAL
@@ -70,6 +75,7 @@ config SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR
 	  from VDD5V) - so the VDD4P2 power source is operational.
 
 source "board/freescale/mx28evk/Kconfig"
+source "board/liebherr/btt/Kconfig"
 source "board/liebherr/xea/Kconfig"
 
 endif
diff --git a/board/liebherr/btt/Kconfig b/board/liebherr/btt/Kconfig
new file mode 100644
index 00000000000..ff35dd04532
--- /dev/null
+++ b/board/liebherr/btt/Kconfig
@@ -0,0 +1,24 @@
+if TARGET_BTT
+
+config SYS_BOARD
+	default "btt"
+
+config SYS_VENDOR
+	default "liebherr"
+
+config SYS_SOC
+	default "mxs"
+
+config SYS_CONFIG_NAME
+	default "btt"
+
+config ENV_SIZE
+	default 0x2000
+
+config ENV_SECT_SIZE
+	default 0x10000 if ENV_IS_IN_SPI_FLASH
+
+config ENV_OFFSET
+	default 0x80000 if ENV_IS_IN_SPI_FLASH
+
+endif
diff --git a/board/liebherr/btt/MAINTAINERS b/board/liebherr/btt/MAINTAINERS
new file mode 100644
index 00000000000..b4afed5aaeb
--- /dev/null
+++ b/board/liebherr/btt/MAINTAINERS
@@ -0,0 +1,6 @@
+BTT BOARD
+M:	Lukasz Majewski <lukma@denx.de>
+S:	Maintained
+F:	board/liebherr/btt/
+F:	include/configs/btt.h
+F:	configs/imx28_btt3_defconfig
diff --git a/board/liebherr/btt/Makefile b/board/liebherr/btt/Makefile
new file mode 100644
index 00000000000..a8ab657a9e0
--- /dev/null
+++ b/board/liebherr/btt/Makefile
@@ -0,0 +1,9 @@
+#
+# (C) Copyright 2025
+# Lukasz Majewski, DENX Software Engineering, lukma@denx.de.
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+obj-y	:= btt.o
+obj-$(CONFIG_XPL_BUILD) += spl_btt.o
diff --git a/board/liebherr/btt/boot_img_scr.h b/board/liebherr/btt/boot_img_scr.h
new file mode 100644
index 00000000000..baa3072b49c
--- /dev/null
+++ b/board/liebherr/btt/boot_img_scr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier:     GPL-2.0+ */
+/*
+ * Struct for boot image source description for placing in last
+ * two SPI NOR flash sectors on legcom.
+ */
+
+struct boot_img_src {
+	u8 magic;	/* Must be 'B' = 0x42 */
+	u8 flags;	/* flags to specify mmcblk[0|1] boot[0|1] */
+	u8 crc8;	/* CRC-8 over above two bytes */
+} __packed;
+
+/*
+ * Bit definition in boot_img_src.flags:
+ *  Bit 0: mmcblk device 0 or 1 (1 - if this bit set)
+ *  Bit 1: mmcblk boot partition 0 or 1.
+ *         for eMMC: boot0 if this bit is cleared, boot1 - if set
+ *         for SD-card the boot partition value will always be 0
+ *         (independent of the value of this bit)
+ *
+ */
+#define BOOT_SRC_MMC1	BIT(0)
+#define BOOT_SRC_PART1	BIT(1)
+
+/* Offset of the first boot image source descriptor in SPI NOR */
+#define SPI_FLASH_BOOT_SRC_OFFS	0xFE0000
+#define SPI_FLASH_SECTOR_SIZE	0x10000
diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
new file mode 100644
index 00000000000..6e78cec206f
--- /dev/null
+++ b/board/liebherr/btt/btt.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * BTT[3C] iMX28 board
+ *
+ * Copyright (C) 2025 DENX Software Engineering
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include <fdt_support.h>
+#include <init.h>
+#include <log.h>
+#include <net.h>
+#include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/iomux-mx28.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+#include <netdev.h>
+#include <errno.h>
+#include <serial.h>
+#include <u-boot/crc.h>
+#include "boot_img_scr.h"
+
+#include <spi.h>
+#include <spi_flash.h>
+
+#ifdef CONFIG_XPL_BUILD
+#include <spl.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * Functions
+ */
+
+static void init_clocks(void)
+{
+	/* IO0 clock at 480MHz */
+	mxs_set_ioclk(MXC_IOCLK0, 480000);
+	/* IO1 clock at 480MHz */
+	mxs_set_ioclk(MXC_IOCLK1, 480000);
+
+	/* SSP0 clock at 96MHz */
+	mxs_set_sspclk(MXC_SSPCLK0, 96000, 0);
+	/* SSP2 clock at 160MHz */
+	mxs_set_sspclk(MXC_SSPCLK2, 160000, 0);
+	/* SSP3 clock at 96MHz */
+	mxs_set_sspclk(MXC_SSPCLK3, 96000, 0);
+}
+
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
+void board_init_f(ulong arg)
+{
+	init_clocks();
+	spl_early_init();
+	preloader_console_init();
+}
+
+static struct boot_img_src img_src[2];
+static int spi_load_boot_info(void)
+{
+	struct spi_flash *flash;
+	int err;
+
+	flash = spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
+				CONFIG_SF_DEFAULT_CS,
+				CONFIG_SF_DEFAULT_SPEED,
+				CONFIG_SF_DEFAULT_MODE);
+	if (!flash) {
+		printf("%s: SPI probe err\n", __func__);
+		return -ENODEV;
+	}
+
+	/*
+	 * Load both boot info structs from SPI flash
+	 */
+	err = spi_flash_read(flash, SPI_FLASH_BOOT_SRC_OFFS,
+			     sizeof(img_src[0]),
+			     (void *)&img_src[0]);
+	if (err) {
+		debug("%s: First boot info NOR sector read error %d\n",
+		      __func__, err);
+		return err;
+	}
+
+	err = spi_flash_read(flash,
+			     SPI_FLASH_BOOT_SRC_OFFS + SPI_FLASH_SECTOR_SIZE,
+			     sizeof(img_src[0]),
+			     (void *)&img_src[1]);
+	if (err) {
+		debug("%s: First boot info NOR sector read error %d\n",
+		      __func__, err);
+		return err;
+	}
+
+	debug("%s: BI0 0x%x 0x%x 0x%x\n", __func__,
+	      img_src[0].magic, img_src[0].flags, img_src[0].crc8);
+
+	debug("%s: BI1 0x%x 0x%x 0x%x\n", __func__,
+	      img_src[1].magic, img_src[1].flags, img_src[1].crc8);
+
+	return 0;
+}
+
+#define BTT_MONITORING_DEVICE_TIMEOUT 100
+static int rescue_val;
+
+void spl_board_init(void)
+{
+	struct gpio_desc phy_rst, boot, rescue, wifi_en, bt_en;
+	int ret, i;
+
+	/*
+	 * On the new HW version of BTTC/3 (with LAN8720ai PHY) the !RST pin
+	 * (15) is pulled LOW by external resistor. As a result it needs to be
+	 * set HIGH as soon as possible to allow correct generation of RESET
+	 * pulse.
+	 *
+	 * In the old BTTC (with TLK105 PHY) the RC circuit was used instead
+	 * to set the RESET pin to HIGH after 100us, so there was no need to
+	 * set it explicitly.
+	 */
+	ret = dm_gpio_lookup_name("GPIO4_12", &phy_rst);
+	if (ret)
+		printf("Cannot get GPIO4_12\n");
+
+	ret = dm_gpio_request(&phy_rst, "phy-rst");
+	if (ret)
+		printf("Cannot request GPIO4_12\n");
+
+	dm_gpio_set_dir_flags(&phy_rst, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+
+	/*
+	 * Explicitly set GPIO, which controls WL_EN (wifi) to LOW. On the BTT3
+	 * it is directly connected to Jody module without any externa pull up
+	 * down register.
+	 */
+	ret = dm_gpio_lookup_name("GPIO0_27", &wifi_en);
+	if (ret)
+		printf("Cannot get GPIO0_27\n");
+
+	ret = dm_gpio_request(&wifi_en, "wifi-en");
+	if (ret)
+		printf("Cannot request GPIO0_27\n");
+
+	dm_gpio_set_dir_flags(&wifi_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
+			      GPIOD_IS_OUT_ACTIVE);
+
+	/*
+	 * Explicitly set GPIO, which controls BT_EN (Bluetooth) to LOW. On the
+	 * BTT3 it is connected to Jody module via RC circuit (after some R*C
+	 * time this pin is set to HIGH). However, the manual recommends setting
+	 * it high from LOW state.
+	 */
+	ret = dm_gpio_lookup_name("GPIO3_27", &bt_en);
+	if (ret)
+		printf("Cannot get GPIO3_27\n");
+
+	ret = dm_gpio_request(&bt_en, "bt-en");
+	if (ret)
+		printf("Cannot request GPIO3_27\n");
+
+	dm_gpio_set_dir_flags(&bt_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
+			      GPIOD_IS_OUT_ACTIVE);
+
+	/* 'boot' and 'rescue' pins */
+	ret = dm_gpio_lookup_name("GPIO4_9", &boot);
+	if (ret)
+		printf("Cannot get GPIO4_9\n");
+
+	ret = dm_gpio_request(&boot, "boot");
+	if (ret)
+		printf("Cannot request GPIO4_9\n");
+
+	dm_gpio_set_dir_flags(&boot, GPIOD_IS_IN);
+
+	ret = dm_gpio_lookup_name("GPIO4_11", &rescue);
+	if (ret)
+		printf("Cannot get GPIO4_11\n");
+
+	ret = dm_gpio_request(&rescue, "rescue");
+	if (ret)
+		printf("Cannot request GPIO4_11\n");
+
+	dm_gpio_set_dir_flags(&rescue, GPIOD_IS_IN);
+
+	/* Wait for ready signal from system "monitoring" device */
+	for (i = 0; i < BTT_MONITORING_DEVICE_TIMEOUT; i++) {
+		if (dm_gpio_get_value(&boot))
+			break;
+		mdelay(10);
+	}
+
+	rescue_val = dm_gpio_get_value(&rescue);
+}
+
+int spl_mmc_emmc_boot_partition(struct mmc *mmc)
+{
+	int i, src_idx = -1, ret;
+
+	ret = spi_load_boot_info();
+	if (ret) {
+		printf("%s: Cannot read BTT boot info! [%d]\n", __func__, ret);
+		/* To avoid bricking board - by default boot from boot0 eMMC */
+		return 1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (img_src[i].magic == 'B' &&
+		    img_src[i].crc8 == crc8(0, &img_src[i].magic, 2)) {
+			src_idx = i;
+			break;
+		}
+	}
+
+	debug("%s: src idx: %d\n", __func__, src_idx);
+
+	if (src_idx < 0)
+		/*
+		 * Always use eMMC (mmcblkX) boot0 if no
+		 * valid image source description found
+		 */
+		return 1;
+
+	if (img_src[src_idx].flags & BOOT_SRC_PART1)
+		return 2;
+
+	return 1;
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	spl_boot_list[0] = BOOT_DEVICE_MMC1;
+	spl_boot_list[1] = BOOT_DEVICE_SPI;
+	spl_boot_list[2] = BOOT_DEVICE_UART;
+}
+
+int spl_start_uboot(void)
+{
+	/* break into full u-boot on 'c' */
+	if (serial_tstc() && serial_getc() == 'c')
+		return 1;
+
+	debug("%s: rescue: %d\n", __func__, rescue_val);
+	return rescue_val;
+}
+#else
+
+/*
+ * Providing proper board name - i.e. 'bttc' vs 'btt3'
+ * The distinction is made on the size of DRAM memory - i.e.
+ * bttc has only 128 MiB, whereas btt3 has 256 MiB.
+ */
+#define STR_BTTC "bttc"
+#define STR_BTT3 "btt3"
+
+static const char *get_board_name(void)
+{
+	if (gd->bd->bi_dram[0].size == SZ_128M)
+		return STR_BTTC;
+
+	return STR_BTT3;
+}
+
+/*
+ * Reading the HW ID number for BTT3 device
+ *
+ * GPIOs from Port 4:
+ * E0: GPIO4_10
+ * E1: GPIO4_5
+ * E2: GPIO4_14
+ * E3: GPIO4_15
+ * are used on BTT3 to store HW revision information.
+ *
+ * From rev 1+ the REV GPIOs are properly connected on the PCB, so PULL UPs
+ * shall be disabled (as they are by default on pins' SPL configuration)
+ *.
+ * Rev 0: - read all '1' (first production version without HW rev set)
+ * Rev 1: - read 0x1 (E0 set)
+ * Rev 2: - read 0x2 (E1 set)
+ *
+ */
+#define BTT3_HW_ID_GPIO_PORT (MXS_PINCTRL_BASE + (0x0900 + ((4) * 0x10)))
+#define BTT3_HW_ID_E0 BIT(10)
+#define BTT3_HW_ID_E1 BIT(5)
+#define BTT3_HW_ID_E2 BIT(14)
+#define BTT3_HW_ID_E3 BIT(15)
+
+static u8 get_som_rev(void)
+{
+	struct mxs_register_32 *reg =
+		(struct mxs_register_32 *)BTT3_HW_ID_GPIO_PORT;
+	u32 tmp = ~readl(&reg->reg);
+	u8 id = 0;
+
+	if (tmp & BTT3_HW_ID_E0)
+		id += 1;
+
+	if (tmp & BTT3_HW_ID_E1)
+		id += 2;
+
+	if (tmp & BTT3_HW_ID_E2)
+		id += 4;
+
+	if (tmp & BTT3_HW_ID_E3)
+		id += 8;
+
+	/*
+	 * Special case for first production BTT3 version, without HW
+	 * revision support (so it reads 0x0s as pullups are disabled
+	 * and hence 0xF is set for ID)
+	 */
+	if (id == 0xF)
+		id = 0;
+
+	return id;
+}
+
+int board_early_init_f(void)
+{
+	init_clocks();
+
+	return 0;
+}
+
+int board_init(void)
+{
+	struct gpio_desc phy_rst;
+	int ret;
+
+	/* Address of boot parameters */
+	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
+
+	cpu_eth_init(NULL);
+
+	/* PHY INT#/PWDN# */
+	ret = dm_gpio_lookup_name("GPIO4_13", &phy_rst);
+	if (ret) {
+		printf("Cannot get GPIO4_13\n");
+		return ret;
+	}
+
+	ret = dm_gpio_request(&phy_rst, "phy-rst");
+	if (ret) {
+		printf("Cannot request GPIO4_13\n");
+		return ret;
+	}
+
+	dm_gpio_set_dir_flags(&phy_rst, GPIOD_IS_IN);
+	udelay(1000);
+
+	return 0;
+}
+
+#if defined(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	int ret = env_set_ulong("board_som_rev", get_som_rev());
+
+	if (ret)
+		printf("Cannot set BTT's SoM revision env variable!\n");
+
+	ret = env_set("arch", get_board_name());
+	if (ret)
+		printf("Cannot set SoM 'arch' env variable!\n");
+
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_DISPLAY_BOARDINFO)
+int checkboard(void)
+{
+	printf("Board: LWE BTT SoM HW rev %d\n", get_som_rev());
+
+	return 0;
+}
+#endif
+
+int dram_init(void)
+{
+	return mxs_dram_init();
+}
+
+#if defined(CONFIG_OF_BOARD)
+int board_fdt_blob_setup(void **fdtp)
+{
+	/*
+	 * The only purpose of this function is the specific BTT's DTB
+	 * setup in u-boot proper. To be more specific - the SPL
+	 * cannot support DTB selection due to size constraints
+	 * (SPL < 50 KiB).
+	 *
+	 * Hence, the DTB selection is done in u-boot, which due to
+	 * board's partition sizes (and backward compatibility) has also
+	 * size constrain (~448 KiB).
+	 *
+	 * To support multiple DTBs appended, the compression has been used
+	 * for them. Unfortunately, the initf_malloc() is called
+	 * after the DTB needs to be selected. To fix this problem for this
+	 * particular setup (i.e. BTT board) the initf_malloc() is called here.
+	 */
+	initf_malloc();
+
+	return -EEXIST;
+}
+#endif
+
+#if defined(CONFIG_MULTI_DTB_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	u8 rev_id = get_som_rev();
+	char board[12];
+
+	sprintf(board, "imx28-btt3-%d", rev_id);
+
+	if (!strncmp(name, board, sizeof(board)))
+		return 0;
+
+	return -EINVAL;
+}
+#endif
+
+/*
+ * NOTE:
+ *
+ * IMX28 clock "stub" DM driver!
+ *
+ * Only used for SPL stage, which is NOT using DM; serial and
+ * eMMC configuration.
+ *
+ * It is required for SPL_OF_PLATDATA proper code generation as,
+ * this device has hard constrain on the size of the SPL binary
+ * (u-boot.sb).
+ */
+static const struct udevice_id imx28_clk_ids[] = {
+	{ .compatible = "fsl,imx28-clkctrl", },
+	{ }
+};
+
+U_BOOT_DRIVER(fsl_imx28_clkctrl) = {
+	.name           = "fsl_imx28_clkctrl",
+	.id             = UCLASS_CLK,
+	.of_match       = imx28_clk_ids,
+};
+#endif	/* CONFIG_XPL_BUILD */
diff --git a/board/liebherr/btt/btt.env b/board/liebherr/btt/btt.env
new file mode 100644
index 00000000000..aaf0b8415d1
--- /dev/null
+++ b/board/liebherr/btt/btt.env
@@ -0,0 +1,139 @@
+bootmode=update
+bootpri=mmc_mmc
+bootsec=sf_swu
+consdev=ttyAMA0
+baudrate=115200
+dtbfile=imx28-btt3-1.dtb
+rootdev=/dev/mmcblk0p2
+netdev=eth0
+swufile=swupdate-image-btt3-upd.itb
+sf_kernel_offset=0xA0000
+sf_swu_size=0xF40000
+ethact=FEC
+arch=btt3
+lwe_env=
+	if dhcp ${loadaddr} ${hostname}/${lwe_uenv} ; then
+	source ${loadaddr};
+	fi
+lwe_uenv=env_uboot_btt3.bin
+do_update_mmc=
+	if mmc rescan ; then
+	mmc dev 0 ${update_mmc_part} ;
+	if dhcp ${hostname}/${update_filename} ; then
+	setexpr fw_sz ${filesize} / 0x200 ;
+	setexpr fw_sz ${fw_sz} + 1 ;
+	mmc write ${loadaddr} ${update_offset} ${fw_sz} ;
+	fi ;
+	fi
+do_update_sf=
+	if sf probe ; then
+	if dhcp ${hostname}/${update_filename} ; then
+	sf erase ${update_offset} +${filesize} ;
+	sf write ${loadaddr} ${update_offset} ${filesize} ;
+	fi ;
+	fi
+factory_reset=
+	if sf probe ; then
+	run update_swu ;
+	setenv bootmode update ;
+	saveenv ;
+	fi
+update_spl_filename=u-boot.sb
+update_spl=
+	setenv update_filename ${update_spl_filename} ;
+	setenv update_offset 0 ;
+	run do_update_sf
+update_uboot_filename=u-boot.img
+update_uboot=
+	setenv update_filename ${update_uboot_filename} ;
+	setenv update_offset 0x10000 ;
+	run do_update_sf ;
+	setenv update_mmc_part 1 ;
+	setenv update_offset 0 ;
+	run do_update_mmc ;
+	setenv update_mmc_part 2 ;
+	run do_update_mmc
+update_kernel_filename=uImage
+update_kernel=
+	setenv update_mmc_part 1 ;
+	setenv update_filename ${update_kernel_filename} ;
+	setenv update_offset 0x800 ;
+	run do_update_mmc ;
+	setenv update_filename ${dtbfile} ;
+	setenv update_offset 0x400 ;
+	run do_update_mmc
+update_swu=
+	setenv update_filename ${swufile} ;
+	setenv update_offset ${sf_kernel_offset} ;
+	run do_update_sf
+addcons=
+	setenv bootargs ${bootargs}
+	console=${consdev},${baudrate}
+addip=
+	setenv bootargs ${bootargs}
+	ip=${ipaddr}:${serverip}:${gatewayip}:
+		${netmask}:${hostname}:${netdev}:off
+addmisc=
+	setenv bootargs ${bootargs} ${miscargs}
+addargs=run addcons addmisc
+mmcload=
+	mmc rescan ;
+	mmc dev 0 1 ;
+	mmc read ${loadaddr} 0x800 0x2000 ;
+	mmc read ${dtbaddr} 0x400 0x80
+netload=
+	dhcp ${loadaddr} ${hostname}/${bootfile} ;
+	tftp ${dtbaddr} ${hostname}/${dtbfile}
+usbload=
+	usb start ;
+	load usb 0:1 ${loadaddr} ${bootfile}
+miscargs=panic=1
+mmcargs=setenv bootargs root=${rootdev} rw rootwait
+nfsargs=
+	setenv bootargs root=/dev/nfs rw
+		nfsroot=${serverip}:${rootpath},v3,tcp
+mmc_mmc=
+	if run mmcload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+mmc_nfs=
+	if run mmcload nfsargs addip addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+sf_mmc=
+	if run sfload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+sf_swu=
+	if sf probe ; then
+	sf read ${loadaddr} ${sf_kernel_offset} ${sf_swu_size} ;
+	setenv bootargs root=/dev/ram0 rw ;
+	run addargs ;
+	bootm ${loadaddr}#conf-imx28-${arch}-${board_som_rev}.dtb ;
+	fi
+net_mmc=
+	if run netload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+net_nfs=
+	if run netload nfsargs addip addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+prebootcmd=
+	if test ${envsaved} != y ; then ;
+	setenv envsaved y ;
+	saveenv ;
+	fi ;
+	if test ${bootmode} = normal ; then
+	setenv bootdelay 0 ;
+	setenv bootpri mmc_mmc ;
+	elif test ${bootmode} = devel ; then
+	setenv bootdelay 3 ;
+	setenv bootpri net_mmc ;
+	else
+	if test ${bootmode} != update ; then
+	echo Warning: unknown bootmode ${bootmode} ;
+	fi ;
+	setenv bootdelay 1 ;
+	setenv bootpri sf_swu ;
+	fi
diff --git a/board/liebherr/btt/spl_btt.c b/board/liebherr/btt/spl_btt.c
new file mode 100644
index 00000000000..da17e186b06
--- /dev/null
+++ b/board/liebherr/btt/spl_btt.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DENX M28 Boot setup
+ *
+ * Copyright (C) 2025 DENX Software Engineering
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+#include <config.h>
+#include <asm/io.h>
+#include <asm/arch/iomux-mx28.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+
+#define MUX_CONFIG_LCD (MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_NOPULL)
+#define MUX_CONFIG_BOOT (MXS_PAD_3V3)
+#define MUX_CONFIG_TSC (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP)
+#define MUX_CONFIG_SSP0 (MXS_PAD_3V3 | MXS_PAD_12MA | MXS_PAD_PULLUP)
+#define MUX_CONFIG_SSP2 (MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_PULLUP)
+#define MUX_CONFIG_ENET (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_NOPULL)
+#define MUX_CONFIG_EMI (MXS_PAD_3V3 | MXS_PAD_12MA | MXS_PAD_NOPULL)
+
+/* HW_PINCTRL_EMI_DS_CTRL */
+#define EMI_DS_CTRL_CLR 0x3FFF
+#define EMI_DS_CTRL_SLICE0_SHIFT 0
+#define EMI_DS_CTRL_SLICE1_SHIFT 2
+#define EMI_DS_CTRL_SLICE2_SHIFT 4
+#define EMI_DS_CTRL_SLICE3_SHIFT 6
+#define EMI_DS_CTRL_DUALPAD_SHIFT 8
+#define EMI_DS_CTRL_CONTROL_SHIFT 10
+#define EMI_DS_CTRL_ADDRESS_SHIFT 12
+#define EMI_DS_CTRL_MA_20 0x10
+
+/*
+ * The BTT devide can be boot in several ways; U-Boot's 'falcon' mode,
+ * normal boot (through U-Boot proper) and also via recovery system.
+ *
+ * To fix some HW issues on the device, as well as providing all the
+ * above boot method's the same "start" state when kernel starts it
+ * has been decided to configure PINMUXes for all relevant IP blocks
+ * (and GPIOs during early SPI state).
+ *
+ * It also shall be mentioned, that during early SPL stage, the BTT
+ * device needs to cooperate with uC based co-processor - this
+ * requires correct pins configuration.
+ */
+static const iomux_cfg_t iomux_setup[] = {
+	/* AUART0 IRDA */
+	MX28_PAD_AUART0_RX__AUART0_RX,
+	MX28_PAD_AUART0_TX__AUART0_TX,
+
+	/* AUART 4 RS422 */
+	MX28_PAD_AUART0_CTS__AUART4_RX,
+	MX28_PAD_AUART0_RTS__AUART4_TX,
+
+	/* USB0 */
+	MX28_PAD_AUART1_CTS__USB0_OVERCURRENT,
+	MX28_PAD_AUART1_RTS__USB0_ID,
+	MX28_PAD_LCD_VSYNC__GPIO_1_28, /* PRW_On */
+
+	/* USB1 */
+	MX28_PAD_PWM2__USB1_OVERCURRENT,
+
+	/* eMMC */
+	MX28_PAD_SSP0_CMD__SSP0_CMD | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA0__SSP0_D0 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA1__SSP0_D1 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA2__SSP0_D2 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA3__SSP0_D3 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA4__SSP0_D4 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA5__SSP0_D5 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA6__SSP0_D6 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DATA7__SSP0_D7 | MUX_CONFIG_SSP0,
+	MX28_PAD_SSP0_DETECT__GPIO_2_9, /* Reset for eMMC */
+	MX28_PAD_SSP0_SCK__SSP0_SCK | MUX_CONFIG_SSP0,
+
+	/* DIG Keys */
+	MX28_PAD_GPMI_D00__GPIO_0_0,
+	MX28_PAD_GPMI_D01__GPIO_0_1,
+	MX28_PAD_GPMI_D02__GPIO_0_2,
+	MX28_PAD_GPMI_D03__GPIO_0_3,
+	MX28_PAD_GPMI_D04__GPIO_0_4,
+	MX28_PAD_GPMI_D05__GPIO_0_5,
+	MX28_PAD_GPMI_D06__GPIO_0_6,
+	MX28_PAD_GPMI_D07__GPIO_0_7,
+
+	/* ADR_0-2 */
+	MX28_PAD_GPMI_CE1N__GPIO_0_17,
+	MX28_PAD_GPMI_CE2N__GPIO_0_18,
+	MX28_PAD_GPMI_CE3N__GPIO_0_19,
+
+	/* Read Keys */
+	MX28_PAD_GPMI_RDY0__GPIO_0_20,
+
+	/* LATCH_EN */
+	MX28_PAD_GPMI_RDY1__GPIO_0_21,
+
+	/* Power off */
+	MX28_PAD_GPMI_RDN__GPIO_0_24,
+
+	/* WIFI EN */
+	MX28_PAD_GPMI_CLE__GPIO_0_27,
+
+	/* I2C1 Touch */
+	MX28_PAD_AUART2_CTS__GPIO_3_10,
+	MX28_PAD_AUART2_RTS__GPIO_3_11,
+	MX28_PAD_GPMI_RDY2__GPIO_0_22, /* Touch Reset */
+	MX28_PAD_GPMI_RDY3__GPIO_0_23, /* Touch INT */
+
+	/* TIVA */
+	MX28_PAD_AUART1_RX__SSP2_CARD_DETECT,
+	MX28_PAD_SSP2_MISO__SSP2_D0,
+	MX28_PAD_SSP2_MOSI__SSP2_CMD,
+	MX28_PAD_SSP2_SCK__SSP2_SCK,
+	MX28_PAD_SSP2_SS0__SSP2_D3,
+	MX28_PAD_SSP2_SS1__GPIO_2_20,
+	MX28_PAD_SSP2_SS2__GPIO_2_21,
+
+	/* SPI3 NOR-Flash */
+	MX28_PAD_AUART1_TX__SSP3_CARD_DETECT,
+	MX28_PAD_AUART2_RX__SSP3_D1,
+	MX28_PAD_AUART2_TX__SSP3_D2,
+	MX28_PAD_SSP3_MISO__SSP3_D0,
+	MX28_PAD_SSP3_MOSI__SSP3_CMD,
+	MX28_PAD_SSP3_SCK__SSP3_SCK,
+	MX28_PAD_SSP3_SS0__SSP3_D3,
+
+	/* NOR-Flash CMD */
+	MX28_PAD_LCD_RS__GPIO_1_26, /* Hold */
+	MX28_PAD_LCD_WR_RWN__GPIO_1_25, /* write protect */
+
+	/* I2C0 Codec */
+	MX28_PAD_I2C0_SCL__I2C0_SCL,
+	MX28_PAD_I2C0_SDA__I2C0_SDA,
+
+	/* I2S Codec */
+	MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK,
+	MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK,
+	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK,
+	MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0,
+	MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0,
+
+	/* BT_EN */
+	MX28_PAD_SPDIF__GPIO_3_27,
+
+	/* EMI */
+	MX28_PAD_EMI_D00__EMI_DATA0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D01__EMI_DATA1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D02__EMI_DATA2 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D03__EMI_DATA3 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D04__EMI_DATA4 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D05__EMI_DATA5 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D06__EMI_DATA6 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D07__EMI_DATA7 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D08__EMI_DATA8 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D09__EMI_DATA9 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D10__EMI_DATA10 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D11__EMI_DATA11 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D12__EMI_DATA12 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D13__EMI_DATA13 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D14__EMI_DATA14 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_D15__EMI_DATA15 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_ODT0__EMI_ODT0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DQM0__EMI_DQM0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_ODT1__EMI_ODT1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DQM1__EMI_DQM1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DDR_OPEN_FB__EMI_DDR_OPEN_FEEDBACK | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_CLK__EMI_CLK | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DQS0__EMI_DQS0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DQS1__EMI_DQS1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_DDR_OPEN__EMI_DDR_OPEN | MUX_CONFIG_EMI,
+
+	MX28_PAD_EMI_A00__EMI_ADDR0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A01__EMI_ADDR1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A02__EMI_ADDR2 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A03__EMI_ADDR3 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A04__EMI_ADDR4 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A05__EMI_ADDR5 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A06__EMI_ADDR6 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A07__EMI_ADDR7 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A08__EMI_ADDR8 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A09__EMI_ADDR9 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A10__EMI_ADDR10 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A11__EMI_ADDR11 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A12__EMI_ADDR12 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A13__EMI_ADDR13 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_A14__EMI_ADDR14 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_BA0__EMI_BA0 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_BA1__EMI_BA1 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_BA2__EMI_BA2 | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_CASN__EMI_CASN | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_RASN__EMI_RASN | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_WEN__EMI_WEN | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_CE0N__EMI_CE0N | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_CE1N__EMI_CE1N | MUX_CONFIG_EMI,
+	MX28_PAD_EMI_CKE__EMI_CKE | MUX_CONFIG_EMI,
+
+	/* Uart3 Bluetooth-Interface */
+	MX28_PAD_AUART3_CTS__AUART3_CTS,
+	MX28_PAD_AUART3_RTS__AUART3_RTS,
+	MX28_PAD_AUART3_RX__AUART3_RX,
+	MX28_PAD_AUART3_TX__AUART3_TX,
+
+	/* framebuffer */
+	MX28_PAD_LCD_CS__LCD_CS | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D00__LCD_D0 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D01__LCD_D1 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D02__LCD_D2 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D03__LCD_D3 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D04__LCD_D4 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D05__LCD_D5 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D06__LCD_D6 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D07__LCD_D7 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D08__LCD_D8 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D09__LCD_D9 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D10__LCD_D10 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D11__LCD_D11 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D12__LCD_D12 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D13__LCD_D13 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D14__LCD_D14 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D15__LCD_D15 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D16__LCD_D16 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D17__LCD_D17 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D18__LCD_D18 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D19__LCD_D19 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D20__LCD_D20 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D21__LCD_D21 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D22__LCD_D22 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_D23__LCD_D23 | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_ENABLE__LCD_ENABLE | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_HSYNC__LCD_HSYNC | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_RD_E__LCD_VSYNC | MUX_CONFIG_LCD,
+	MX28_PAD_LCD_RESET__LCD_RESET | MUX_CONFIG_LCD,
+
+	/* DUART RS232 */
+	MX28_PAD_PWM0__DUART_RX,
+	MX28_PAD_PWM1__DUART_TX,
+
+	/* Backlight */
+	MX28_PAD_PWM3__PWM_3,
+
+	/* FEC Ethernet */
+	MX28_PAD_ENET_CLK__CLKCTRL_ENET | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_COL__ENET1_TX_EN | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_CRS__ENET1_RX_EN | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_MDC__ENET0_MDC | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_MDIO__ENET0_MDIO | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_RX_CLK__GPIO_4_13, /* Phy Interrupt */
+	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_RXD0__ENET0_RXD0 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_RXD1__ENET0_RXD1 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_RXD3__ENET1_RXD1 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_TX_CLK__GPIO_4_5, /* n.c. */
+	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MUX_CONFIG_ENET,
+	MX28_PAD_ENET0_TXD3__GPIO_4_12, /* PHY reset */
+
+	/* boot/rescue pins */
+	MX28_PAD_ENET0_RXD2__GPIO_4_9,
+	MX28_PAD_ENET0_TXD2__GPIO_4_11,
+
+	/* HW revision setup pins - by default pullup DISABLED */
+	MX28_PAD_ENET0_RXD3__GPIO_4_10,
+	MX28_PAD_ENET0_TX_CLK__GPIO_4_5,
+	MX28_PAD_ENET0_COL__GPIO_4_14,
+	MX28_PAD_ENET0_CRS__GPIO_4_15,
+};
+
+u32 mxs_dram_vals[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00010101, 0x01010101,
+	0x000f0f01, 0x0f02010a, 0x00000000, 0x00010101,
+	0x00000100, 0x00000100, 0x00000000, 0x00000002,
+	0x01010000, 0x07080403, 0x07005303, 0x0b0000c8,
+	0x0200a0c1, 0x0002040c, 0x0038430a, 0x04290322,
+	0x02040203, 0x00c8002b, 0x00000000, 0x00000000,
+	0x00012100, 0xffff0303, 0x00012100, 0xffff0303,
+	0x00012100, 0xffff0303, 0x00012100, 0xffff0303,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000612, 0x01000102,
+	0x06120612, 0x00000200, 0x00020007, 0xf4004a27,
+	0xf4004a27, 0xf4004a27, 0xf4004a27, 0x07400300,
+	0x07400300, 0x07400300, 0x07400300, 0x00000005,
+	0x00000000, 0x00000000, 0x01000000, 0x00000000,
+	0x00000001, 0x000f1133, 0x00000000, 0x00001f04,
+	0x00001f04, 0x00001f04, 0x00001f04, 0x00001f04,
+	0x00001f04, 0x00001f04, 0x00001f04, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00010000, 0x00030404,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x01010000,
+	0x01000000, 0x03030000, 0x00010303, 0x01020202,
+	0x00000000, 0x02040101, 0x21002103, 0x00061200,
+	0x06120612, 0x00000642, 0x00000000, 0x00000004,
+	0x00000000, 0x00000080, 0x00000000, 0x00000000,
+	0x00000000, 0xffffffff
+};
+
+#ifndef CONFIG_SPL_FRAMEWORK
+void board_init_ll(const u32 arg, const uint32_t *resptr)
+{
+	mxs_common_spl_init(arg, resptr, iomux_setup, ARRAY_SIZE(iomux_setup));
+}
+#else
+void lowlevel_init(void)
+{
+	struct mxs_pinctrl_regs *pinctrl_regs =
+		(struct mxs_pinctrl_regs *)MXS_PINCTRL_BASE;
+
+	/* Set EMI drive strength - the HW_PINCTRL_EMI_DS_CTRL */
+	writel(EMI_DS_CTRL_CLR, &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_clr);
+	writel(EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_SLICE0_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_SLICE1_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_SLICE2_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_SLICE3_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_DUALPAD_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_CONTROL_SHIFT |
+	       EMI_DS_CTRL_MA_20 << EMI_DS_CTRL_ADDRESS_SHIFT,
+	       &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_set);
+
+	mxs_common_spl_init(0, NULL, iomux_setup, ARRAY_SIZE(iomux_setup));
+}
+#endif
diff --git a/configs/imx28_btt3_defconfig b/configs/imx28_btt3_defconfig
new file mode 100644
index 00000000000..a84327df922
--- /dev/null
+++ b/configs/imx28_btt3_defconfig
@@ -0,0 +1,140 @@
+CONFIG_ARM=y
+CONFIG_SPL_SYS_THUMB_BUILD=y
+CONFIG_ARCH_MX28=y
+CONFIG_TEXT_BASE=0x40002000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_IMX_CONFIG=""
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/mxs/imx28-btt3-1"
+CONFIG_TARGET_BTT=y
+CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=y
+CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=y
+# CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR is not set
+CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x80000
+CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR=0x43000000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x20000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_TEXT_BASE=0x1000
+CONFIG_SYS_LOAD_ADDR=0x42000000
+CONFIG_SF_DEFAULT_BUS=2
+CONFIG_SPL_SIZE_LIMIT=0xa000
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x90000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=458752
+CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyAMA0,115200n8"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ${bootpri} ; run ${bootsec}"
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="run prebootcmd"
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_MMC_TINY=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x44000000
+CONFIG_SPL_FALCON_BOOT_MMCSD=y
+CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x800
+CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x400
+CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x40
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x100000
+CONFIG_SYS_SPI_ARGS_OFFS=0x80000
+CONFIG_SYS_SPI_ARGS_SIZE=0x8000
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_SPL=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GREPENV=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_DOS_PARTITION=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="nxp/mxs/imx28-btt3-0 nxp/mxs/imx28-btt3-1 nxp/mxs/imx28-btt3-2"
+CONFIG_MULTI_DTB_FIT_GZIP=y
+CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent interrupts"
+CONFIG_SPL_OF_PLATDATA=y
+# CONFIG_SPL_OF_PLATDATA_PARENT is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="uImage"
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="btt3"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_DEVRES=y
+CONFIG_MXS_GPIO=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_MXS=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=1
+CONFIG_PHY_FIXED=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MXS=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXS_SPI=y
+CONFIG_SPL_CRC8=y
+# CONFIG_SPL_OF_LIBFDT is not set
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 3c5a2c7d1cf..e084c7fb1df 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -38,6 +38,7 @@ Board-specific doc
    kontron/index
    lenovo/index
    lg/index
+   liebherr/index
    mediatek/index
    microchip/index
    microsoft/index
diff --git a/doc/board/liebherr/btt.rst b/doc/board/liebherr/btt.rst
new file mode 100644
index 00000000000..d22ffa205bd
--- /dev/null
+++ b/doc/board/liebherr/btt.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Lukasz Majewski <lukma@denx.de>
+
+BTT devices
+===========
+
+Those devices are based on IMX's IMX287 SoC. The description regarding the
+**btt** family of boards (i.e. `btt3` and `bttc`) is identical as the one for
+the already supported **xea** board.
+
+Building
+--------
+
+Make sure that `CROSS_COMPILE` is set appropriately:
+
+.. code-block:: text
+
+ $ make imx28_btt3_defconfig
+ $ make -j4 u-boot.sb u-boot.img
+
+Now you should see `u-boot.sb` and `u-boot.img` files in the build directory.
+
+For initial bringup - one can use `uuu` utulity to boot till u-boot prompt
+(USB connection with the board is required).
+
+Flashing
+--------
+
+Via U-Boot:
+
+.. code-block:: text
+
+ => run update_spl
+ => run update_uboot
diff --git a/doc/board/liebherr/index.rst b/doc/board/liebherr/index.rst
new file mode 100644
index 00000000000..d8db6bd188c
--- /dev/null
+++ b/doc/board/liebherr/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Liebherr
+========
+
+.. toctree::
+   :maxdepth: 2
+
+   btt
diff --git a/include/configs/btt.h b/include/configs/btt.h
new file mode 100644
index 00000000000..dea87fa9b77
--- /dev/null
+++ b/include/configs/btt.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 DENX Software Engineering
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+#ifndef __CONFIGS_BTT_H__
+#define __CONFIGS_BTT_H__
+
+#include <linux/sizes.h>
+/* Memory configuration */
+#define PHYS_SDRAM_1			0x40000000	/* Base address */
+#define PHYS_SDRAM_1_SIZE		SZ_256M	/* Max 256 MB RAM */
+#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
+
+/* The rest of the configuration is shared */
+#include <configs/mxs.h>
+
+#endif /* __CONFIGS_BTT_H__ */
-- 
2.39.5

