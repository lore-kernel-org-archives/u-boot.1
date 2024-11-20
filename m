Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674A0D6C2B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F00E895F0;
	Wed, 20 Nov 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bL4HWzk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F6C895FD; Wed, 20 Nov 2024 01:16:33 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5219789250
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so45116865ad.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732061788; x=1732666588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qZM3eKSx7gnoQfDDbiAkVSDQ9sa2dvWxNG2ilFJmBHg=;
 b=bL4HWzk08POyXXqL6lRfMKbecCCFl+CHhdDOjO9vFnmbZA7r521ffoXIDlX1cAc2zc
 wFPAkln8jddPUMPC2ym4bmAs6D8dvNJRlfnNF61QvQtGSqUIjXKYqoTZnr1gfzb5yAN/
 QiB0hgKE6NeXwd/NiWAfIVXDqqAkdKP6ihUkd+N29OOSxWJ2pUTVfOaKPxDLkDTMkzEa
 lvdi1SQiUgfehe1GJb97vmGfCEsHBJJwep76DeMS/1VNmv48z2QvBuFKSXfyR9A4V1Xd
 evdexChFvjagmzyo9S+nwJB8vFCYrFFtOryfW56mCGRDC6NxWJYoAZkM4UUl1wJomw2y
 G9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732061788; x=1732666588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qZM3eKSx7gnoQfDDbiAkVSDQ9sa2dvWxNG2ilFJmBHg=;
 b=VUGRonCPhJUOyAbN0WOrXa34qM1gdF3ZbVRPKPuzP1z+1nXeUuMX5fH5dx62ndZvps
 Y5pTP7LvH99i97/FSAek0GdIYWJZx+naAT2QOC0qk77BENEJnsNh1F6a8EUqCBbvsCb+
 auY+SkFvtGZPZrORd+DGJx8H0uIhzNxq2Si32dpmlKIBg9kxjl7uhHPUb11ezpcDvmEg
 mg6U5MVQSSjZBwdpClRYF+h5RII2giqKqxg6LZkKYFVJgufppFp5pcUgwmIULEPs1Lxb
 d/lpm3oNXfkCVg+OE7aASx3vLpIyrXlbTfWbSMvm+tPo5eTWa+QeVISwi9UUrxt4PW1n
 VjIw==
X-Gm-Message-State: AOJu0YwDU5UToQLdxNN1zLkUgpZlmvkmweOsH3KDgJOR5UyVaAVPgbNQ
 GE7wIyt59ms3YcBnfotcPxO5y9kk3K20zpfUvkRgcvt+otssxQVgFVgArMp+YVs=
X-Google-Smtp-Source: AGHT+IHkXdXqETC9/oEBUj3vNScqW6iZRWYXcvsqbp1lHx/wymp5CwogKKQyrfxOa2TWRbQ8Xw5p2g==
X-Received: by 2002:a17:902:ecc8:b0:20b:6d8c:463 with SMTP id
 d9443c01a7336-2126b012191mr9100655ad.35.1732061787518; 
 Tue, 19 Nov 2024 16:16:27 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:83b8:e581:7748:847e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211f6b3efb5sm61725775ad.216.2024.11.19.16.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 16:16:27 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Robert Marko <robimarko@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: mvebu: Add Allied Telesis x250 board
Date: Wed, 20 Nov 2024 13:16:00 +1300
Message-ID: <20241120131556.1.I395d95af213e80340ae53152f6a49fc86c5f0c69@changeid>
X-Mailer: git-send-email 2.47.0
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

The x250 and SE240 are series of 10G L2+ switches from Allied Telesis.
There are a number of them in the range but as far as U-Boot is
concerned all the CPU block components are the same so there's only one
board defined.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/dts/Makefile             |   3 +-
 arch/arm/dts/cn9130-atl-x250.dts  | 274 ++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig       |   9 +
 board/alliedtelesis/x250/Makefile |   6 +
 board/alliedtelesis/x250/x250.c   |  13 ++
 configs/x250_defconfig            | 102 +++++++++++
 include/configs/x250.h            |  54 ++++++
 7 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/cn9130-atl-x250.dts
 create mode 100644 board/alliedtelesis/x250/Makefile
 create mode 100644 board/alliedtelesis/x250/x250.c
 create mode 100644 configs/x250_defconfig
 create mode 100644 include/configs/x250.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 042282f37235..6ad59aeed5f6 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -190,7 +190,8 @@ dtb-$(CONFIG_ARCH_MVEBU) +=			\
 	cn9130-crb-A.dtb			\
 	cn9130-crb-B.dtb			\
 	ac5-98dx35xx-rd.dtb			\
-	ac5-98dx35xx-atl-x240.dtb
+	ac5-98dx35xx-atl-x240.dtb		\
+	cn9130-atl-x250.dtb
 endif
 
 dtb-$(CONFIG_ARCH_SYNQUACER) += synquacer-sc2a11-developerbox.dtb
diff --git a/arch/arm/dts/cn9130-atl-x250.dts b/arch/arm/dts/cn9130-atl-x250.dts
new file mode 100644
index 000000000000..f2c82da9d14e
--- /dev/null
+++ b/arch/arm/dts/cn9130-atl-x250.dts
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Allied Telesis Labs
+ */
+
+#include "cn9130.dtsi"
+
+/ {
+	model = "Allied Telesis x250";
+	compatible = "alliedtelesis,x250",
+		"marvell,cn9130",
+		"marvell,armada-ap806-quad",
+		"marvell,armada-ap806";
+
+	aliases {
+		serial0 = &uart0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		fault {
+			label = "fault:red";
+			gpios = <&cp0_gpio1 9 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+};
+
+/*
+ * AP related configuration
+ */
+&ap_pinctl {
+	/* AP_MPP Pins:
+	 * GPIO & NC [0-6,9-10,12]
+	 * UART0 [11,19]
+	 * UART1 [7,8]
+	 * Note: The x250-28XTm PT1 units has the console port wired
+	 *       to the second uart pins (UART1). This was fixed in all
+	 *       subsequent models.
+	 *       Here we choose to configure the pin control for both
+	 *       uarts to cater for either unit.
+	 */
+		/*   0 1 2 3 4 5 6 7 8 9 */
+	pin-func = < 0 0 0 0 0 0 0 3 3 0
+		     0 3 0 0 0 0 0 0 0 3 >;
+};
+
+&ap_gpio0 {
+	pp-reset {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "pp-reset";
+	};
+};
+
+/*
+ * CP related configuration
+ */
+&cp0_pinctl {
+	/* MPP Bus:
+	 *	[0-1]	DEV
+	 *	[2-8]	GPIO
+	 *	[9]	DEV
+	 *	[10-12]	GPIO
+	 *	[13]	ND_RB
+	 *	[14]	GPIO
+	 *	[15-28]	DEV
+	 *	[29-30]	GPIO
+	 *	[31]	DEV
+	 *	[32-34]	GPIO
+	 *	[35-36]	I2C1
+	 *	[37-38]	I2C0
+	 *	[39-55]	GPIO
+	 *	[56-60]	SPI
+	 *	[61-62]	GPIO
+	 */
+		/*   0   1   2   3   4   5   6   7   8   9 */
+	pin-func = < 1   1   0   0   0   0   0   0   0   1
+		     0   0   0   2   0   1   1   1   1   1
+		     1   1   1   1   1   1   1   1   1   0
+		     0   1   0   0   0   2   2   2   2   0
+		     0   0   0   0   0   0   0   0   0   0
+		     0   0   0   0   0   0   6   6   6   6
+		     6   0   0>;
+
+	cp0_i2c0_pins: cp0-i2c-pins-0 {
+		marvell,pins = <37 38>;
+		marvell,function = <2>;
+	};
+
+	cp0_i2c0_gpio_pins: cp0-i2c-gpio-pins-0 {
+		marvell,pins = <37 38>;
+		marvell,function = <0>;
+	};
+
+	cp0_i2c1_pins: cp0-i2c-pins-1 {
+		marvell,pins = <35 36>;
+		marvell,function = <2>;
+	};
+
+	cp0_nand_pins: cp0-nand-pins {
+		marvell,pins = <0 1 9 15 16 17 18 19 20 21 22 23 24 25 26 27 28 31>;
+		marvell,function = <1>;
+	};
+
+	cp0_nand_rb: cp0-nand-rb {
+		marvell,pins = <13>;
+		marvell,function = <2>;
+	};
+
+	cp0_spi0_pins: cp0-spi-pins-0 {
+		marvell,pins = <56 57 58 59 60>;
+		marvell,function = <6>;
+	};
+};
+
+&cp0_comphy {
+	phy0 {
+		phy-type = <COMPHY_TYPE_PEX0>;
+	};
+
+	phy1 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy2 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy3 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy4 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy5 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+};
+
+&cp0_pcie0 {
+	num-lanes = <1>;
+		/* non-prefetchable memory */
+	ranges =<0x82000000 0 0xc0000000 0 0xc0000000 0 0x2000000>;
+	status = "disabled";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	clock-frequency = <200000000>;
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+};
+
+&cp0_spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi0_pins>;
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+	};
+};
+
+&cp0_nand {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_nand_pins &cp0_nand_rb>;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	nand-timing-mode = <4>;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@user {
+			reg = <0x00000000 0x10000000>;
+			label = "user";
+		};
+	};
+};
+
+&cp0_gpio0
+{
+	nand-protect {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "nand-protect";
+	};
+};
+
+&cp0_gpio1
+{
+	usb-en {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-en";
+	};
+
+	phy-reset {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "phy-reset";
+	};
+};
+
+&cp0_i2c0 {
+	status = "okay";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	pinctrl-1 = <&cp0_i2c0_gpio_pins>;
+	scl-gpios = <&cp0_gpio1 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&cp0_gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	mux@71 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		i2c-mux-idle-disconnect;
+		reset-gpios = <&cp0_gpio1 19 GPIO_ACTIVE_LOW>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			hwmon@2e {
+				compatible = "adi,adt7476";
+				reg = <0x2e>;
+			};
+
+			rtc@68 {
+				compatible = "adi,max31331";
+				reg = <0x68>;
+			};
+		};
+	};
+};
+
+&cp0_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+};
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index c1a1a333e6c9..f81a2d0586b9 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -215,6 +215,12 @@ config TARGET_X530
 	bool "Support Allied Telesis x530"
 	select 88F6820
 
+config TARGET_X250
+	bool "Support Allied Telesis x250"
+	select ARMADA_8K
+	imply SCSI
+	select SSCANF
+
 config TARGET_X240
 	bool "Support Allied Telesis x240"
 	select ALLEYCAT_5
@@ -301,6 +307,7 @@ config SYS_BOARD
 	default "theadorable" if TARGET_THEADORABLE
 	default "a38x" if TARGET_CONTROLCENTERDC
 	default "x530" if TARGET_X530
+	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
@@ -325,6 +332,7 @@ config SYS_CONFIG_NAME
 	default "turris_mox" if TARGET_TURRIS_MOX
 	default "controlcenterdc" if TARGET_CONTROLCENTERDC
 	default "x530" if TARGET_X530
+	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
@@ -349,6 +357,7 @@ config SYS_VENDOR
 	default "CZ.NIC" if TARGET_TURRIS_MOX
 	default "gdsys" if TARGET_CONTROLCENTERDC
 	default "alliedtelesis" if TARGET_X530
+	default "alliedtelesis" if TARGET_X250
 	default "alliedtelesis" if TARGET_X240
 	default "mikrotik" if TARGET_CRS3XX_98DX3236
 	default "Marvell" if TARGET_MVEBU_ALLEYCAT5
diff --git a/board/alliedtelesis/x250/Makefile b/board/alliedtelesis/x250/Makefile
new file mode 100644
index 000000000000..98e0ccedde4a
--- /dev/null
+++ b/board/alliedtelesis/x250/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Allied Telesis
+#
+
+obj-y	+= x250.o
diff --git a/board/alliedtelesis/x250/x250.c b/board/alliedtelesis/x250/x250.c
new file mode 100644
index 000000000000..c89f61e474dc
--- /dev/null
+++ b/board/alliedtelesis/x250/x250.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier:    GPL-2.0+
+
+#include <config.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/x250_defconfig b/configs/x250_defconfig
new file mode 100644
index 000000000000..c6124ad05812
--- /dev/null
+++ b/configs/x250_defconfig
@@ -0,0 +1,102 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_X250=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xf80000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="cn9130-atl-x250"
+CONFIG_SYS_LOAD_ADDR=0x10000000
+CONFIG_DEBUG_UART_BASE=0xf0512000
+CONFIG_DEBUG_UART_CLOCK=200000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SPL_SILENT_CONSOLE=y
+CONFIG_TPL_SILENT_CONSOLE=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_UBI=y
+CONFIG_MAC_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+# CONFIG_INPUT is not set
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+# CONFIG_MMC is not set
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_PXA3XX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_E1000=y
+CONFIG_MVPP2=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_MVEBU=y
+CONFIG_PHY=y
+CONFIG_MVEBU_COMPHY_SUPPORT=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_ARMADA_8K=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1307=y
+CONFIG_RTC_MAX313XX=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/include/configs/x250.h b/include/configs/x250.h
new file mode 100644
index 000000000000..5a3f445e218c
--- /dev/null
+++ b/include/configs/x250.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Allied Telesis
+ */
+
+#ifndef __X250_H_
+#define __X250_H_
+
+/*
+ * High Level Configuration Options (easy to change)
+ */
+#define CFG_SYS_TCLK		250000000	/* 250MHz */
+
+/* additions for new ARM relocation support */
+#define CFG_SYS_SDRAM_BASE	0x00000000
+
+/* auto boot */
+
+#define CFG_SYS_BAUDRATE_TABLE   { 9600, 19200, 38400, 57600, \
+				      115200, 230400, 460800, 921600 }
+
+/*
+ * Other required minimal configurations
+ */
+
+/* When runtime detection fails this is the default */
+
+/* USB ethernet */
+
+/*
+ * PCI configuration
+ */
+#ifdef CONFIG_DISTRO_DEFAULTS
+#define BOOT_TARGET_DEVICES(func) \
+	func(USB, usb, 0) \
+	func(SCSI, scsi, 0) \
+	func(PXE, pxe, na) \
+	func(DHCP, dhcp, na)
+
+#include <config_distro_bootcmd.h>
+#else
+#define BOOTENV
+#endif
+
+#define CFG_EXTRA_ENV_SETTINGS   \
+	"scriptaddr=0x6d00000\0"	\
+	"pxefile_addr_r=0x6e00000\0"	\
+	"fdt_addr_r=0x6f00000\0"	\
+	"kernel_addr_r=0x7000000\0"	\
+	"ramdisk_addr_r=0xa000000\0"	\
+	"fdtfile=marvell/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	BOOTENV
+
+#endif /* __X250_H_ */
-- 
2.47.0

