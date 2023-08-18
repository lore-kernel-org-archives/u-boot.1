Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7012C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2E586CBD;
	Fri, 18 Aug 2023 11:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qZ0jQ1AL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D85A86C83; Fri, 18 Aug 2023 11:05:18 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8CD86CAF
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c136ee106so82481966b.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349514; x=1692954314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOTCNYml8KNnr7oEkj37OODWqt2Kg+wRIvzU32uKGW8=;
 b=qZ0jQ1ALcYQG28NUslJzsNhU3C7JJUcscPoFKbdUb++hBnd/oGWrLmqd8x4/X1TkVi
 jdw2gYrsFTxuZoyd7+2ubmR78scoRlrYnWyi/bLK2XU8Lz2S18B6zfdvn9uNNBhYlUl6
 SfMr9x2Mz9d4KFxMORYg512Eu9W2k6Jyj2UwCwauPuSpNXoV/ln7DdzVIx52pvM+N7xW
 ajoMcfxi0hQgLx4MQ+cFy2ET6qlpwPztvdQ/gkV9NuFy0WA9trTkcTOyyz2PYceeEeCm
 hSzUmuaKlDadGfeemIngSUWpFLcvIBJ0WHiXS4ywC05hU4pm/ZKvkin1e/AzrFRiZ1kA
 6hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349514; x=1692954314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOTCNYml8KNnr7oEkj37OODWqt2Kg+wRIvzU32uKGW8=;
 b=M9fFA69P+McBcchJBB4A+TDDcaZzeqvnG9/isM3Wt7uc2ttIL4oYfMg3WkIIuAGCN+
 ztOpwItWqhiz3VJINlLdTj6tf+Qm1FZrhEHc4lfXal4AaoYbVYFCe0T13HJqahiOWxJk
 Jk15wEp2b47JM2RiecWTqRziZT6ZHtc+N6vNKLoV2mS2MKIpzPf4Zfn6QTq//zdZa7W0
 vBO42987aFYa8dJ8ibrwFulF+6Ubcz1s5FGdhaaD4bcptsFwavRYZEt1dn/lkOW8Wy5j
 /b/X4KJI9xadmyVtV2sSbdAfiIf5eECgS554HcYW0XyeXtn1pqvb+cXH6Vp8QM6qRUap
 yZUw==
X-Gm-Message-State: AOJu0Yy1jmgIRP49Z7B7Zn2N0y88p8URQFhv5OnWQMpL/Txl/EqJdNnh
 m5c5I/X6cF6o1hQfn/0SB8E=
X-Google-Smtp-Source: AGHT+IHzGW9RjHOHGecdvpnur4ihx7lJ4rW4GmY1Bmb+VkmYOgSirfm77zsn+VlfECxy81ZD/KB4iQ==
X-Received: by 2002:a17:906:cc10:b0:99d:f79c:38e3 with SMTP id
 ml16-20020a170906cc1000b0099df79c38e3mr1630343ejb.19.1692349513923; 
 Fri, 18 Aug 2023 02:05:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 7/7] board: htc: endeavoru: add One X support
Date: Fri, 18 Aug 2023 12:04:47 +0300
Message-Id: <20230818090447.348820-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818090447.348820-1-clamor95@gmail.com>
References: <20230818090447.348820-1-clamor95@gmail.com>
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

The HTC One X is a touchscreen-based, slate-sized smartphone
designed and manufactured by HTC that runs the Android operating
system. The One X features a 4.7" display, an Nvidia Tegra 3
quad-core chip, 1 GB of RAM and non-extendable 32 GB of internal
storage. UART-A is default debug port.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com>
Tested-by: Ion Agorria <ion@agorria.com>
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/tegra30-htc-endeavoru.dts        | 177 +++++++++
 arch/arm/mach-tegra/tegra30/Kconfig           |   5 +
 board/htc/endeavoru/Kconfig                   |  12 +
 board/htc/endeavoru/MAINTAINERS               |   7 +
 board/htc/endeavoru/Makefile                  |  11 +
 board/htc/endeavoru/endeavoru-spl.c           |  47 +++
 board/htc/endeavoru/endeavoru.c               | 116 ++++++
 board/htc/endeavoru/pinmux-config-endeavoru.h | 362 ++++++++++++++++++
 configs/endeavoru_defconfig                   |  83 ++++
 doc/board/htc/endeavoru.rst                   |  89 +++++
 doc/board/htc/index.rst                       |   9 +
 doc/board/index.rst                           |   1 +
 include/configs/endeavoru.h                   |  65 ++++
 14 files changed, 985 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-htc-endeavoru.dts
 create mode 100644 board/htc/endeavoru/Kconfig
 create mode 100644 board/htc/endeavoru/MAINTAINERS
 create mode 100644 board/htc/endeavoru/Makefile
 create mode 100644 board/htc/endeavoru/endeavoru-spl.c
 create mode 100644 board/htc/endeavoru/endeavoru.c
 create mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h
 create mode 100644 configs/endeavoru_defconfig
 create mode 100644 doc/board/htc/endeavoru.rst
 create mode 100644 doc/board/htc/index.rst
 create mode 100644 include/configs/endeavoru.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0b0d6cd76d..85fd5b1157 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -268,6 +268,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu.dtb \
 	tegra30-colibri.dtb \
+	tegra30-htc-endeavoru.dtb \
 	tegra30-lg-p880.dtb \
 	tegra30-lg-p895.dtb \
 	tegra30-tec-ng.dtb \
diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
new file mode 100644
index 0000000000..5c7b2deae5
--- /dev/null
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/* This dts file describes the HTC One X smartphone */
+/* CPU Speedo ID 4, Soc Speedo ID 1, CPU Process: 1, Core Process: 0 */
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "HTC One X";
+	compatible = "htc,endeavoru", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &micro_usb;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&dsia>;
+			};
+		};
+
+		dsia: dsi@54300000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel = <&panel>;
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		/* Texas Instruments TPS80032 PMIC */
+		pmic: tps80032@48 {
+			compatible = "ti,tps80032";
+			reg = <0x48>;
+
+			ti,system-power-controller;
+
+			regulators {
+				vdd_1v8_vio: smps5 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* DSI VDD */
+				avdd_dsi_csi: ldo1 {
+					regulator-name = "avdd_dsi_csi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+			};
+		};
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	micro_usb: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	backlight: backlight {
+		compatible = "nvidia,tegra-pwm-backlight";
+
+		nvidia,pwm-source = <1>;
+		nvidia,default-brightness = <0x8E>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(U, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	panel: panel {
+		compatible = "htc,edge-panel";
+
+		reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&vdd_3v3_panel>;
+		vddio-supply = <&vdd_1v8_panel>;
+
+		backlight = <&backlight>;
+	};
+
+	vcore_emmc: regulator-emmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_2v85_sdmmc";
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+		gpio = <&gpio TEGRA_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_3v3_panel: regulator-lcm {
+		compatible = "regulator-fixed";
+		regulator-name = "v_lcm_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(E, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_1v8_panel: regulator-lcmio {
+		compatible = "regulator-fixed";
+		regulator-name = "v_lcmio_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(E, 5) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index 9b1df21d28..3e478b3b7b 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -20,6 +20,10 @@ config TARGET_COLIBRI_T30
 	bool "Toradex Colibri T30 board"
 	select BOARD_LATE_INIT
 
+config TARGET_ENDEAVORU
+	bool "HTC Endeavoru T30 board"
+	select BOARD_LATE_INIT
+
 config TARGET_GROUPER
 	bool "Asus and Google Grouper board"
 	select BOARD_LATE_INIT
@@ -45,6 +49,7 @@ source "board/toradex/apalis_t30/Kconfig"
 source "board/nvidia/beaver/Kconfig"
 source "board/nvidia/cardhu/Kconfig"
 source "board/toradex/colibri_t30/Kconfig"
+source "board/htc/endeavoru/Kconfig"
 source "board/asus/grouper/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
 source "board/asus/transformer-t30/Kconfig"
diff --git a/board/htc/endeavoru/Kconfig b/board/htc/endeavoru/Kconfig
new file mode 100644
index 0000000000..0b72c4a687
--- /dev/null
+++ b/board/htc/endeavoru/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ENDEAVORU
+
+config SYS_BOARD
+	default "endeavoru"
+
+config SYS_VENDOR
+	default "htc"
+
+config SYS_CONFIG_NAME
+	default "endeavoru"
+
+endif
diff --git a/board/htc/endeavoru/MAINTAINERS b/board/htc/endeavoru/MAINTAINERS
new file mode 100644
index 0000000000..85f439f467
--- /dev/null
+++ b/board/htc/endeavoru/MAINTAINERS
@@ -0,0 +1,7 @@
+ENDEAVORU BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/htc/endeavoru/
+F:	configs/endeavoru_defconfig
+F:	doc/board/htc/endeavoru.rst
+F:	include/configs/endeavoru.h
diff --git a/board/htc/endeavoru/Makefile b/board/htc/endeavoru/Makefile
new file mode 100644
index 0000000000..0c6ba4af3b
--- /dev/null
+++ b/board/htc/endeavoru/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-$(CONFIG_SPL_BUILD) += endeavoru-spl.o
+
+obj-y += endeavoru.o
diff --git a/board/htc/endeavoru/endeavoru-spl.c b/board/htc/endeavoru/endeavoru-spl.c
new file mode 100644
index 0000000000..7921ff1a73
--- /dev/null
+++ b/board/htc/endeavoru/endeavoru-spl.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 HTC Endeavoru SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <asm/arch-tegra/tegra_i2c.h>
+#include <linux/delay.h>
+
+/*
+ * Endeavoru uses TPS80032 PMIC with SMPS1 and SMPS2 in strandard
+ * mode with zero offset.
+ */
+
+#define TPS80032_DVS_I2C_ADDR			(0x12 << 1)
+#define TPS80032_SMPS1_CFG_VOLTAGE_REG		0x56
+#define TPS80032_SMPS2_CFG_VOLTAGE_REG		0x5C
+#define TPS80032_SMPS1_CFG_VOLTAGE_DATA		(0x2100 | TPS80032_SMPS1_CFG_VOLTAGE_REG)
+#define TPS80032_SMPS2_CFG_VOLTAGE_DATA		(0x3000 | TPS80032_SMPS2_CFG_VOLTAGE_REG)
+
+#define TPS80032_CTL1_I2C_ADDR			(0x48 << 1)
+#define TPS80032_SMPS1_CFG_STATE_REG		0x54
+#define TPS80032_SMPS2_CFG_STATE_REG		0x5A
+#define TPS80032_SMPS1_CFG_STATE_DATA		(0x0100 | TPS80032_SMPS1_CFG_STATE_REG)
+#define TPS80032_SMPS2_CFG_STATE_DATA		(0x0100 | TPS80032_SMPS2_CFG_STATE_REG)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set VDD_CORE to 1.200V. */
+	tegra_i2c_ll_write(TPS80032_DVS_I2C_ADDR, TPS80032_SMPS2_CFG_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS80032_CTL1_I2C_ADDR, TPS80032_SMPS2_CFG_STATE_DATA);
+
+	udelay(1000);
+
+	/* Bring up VDD_CPU to 1.0125V. */
+	tegra_i2c_ll_write(TPS80032_DVS_I2C_ADDR, TPS80032_SMPS1_CFG_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS80032_CTL1_I2C_ADDR, TPS80032_SMPS1_CFG_STATE_DATA);
+	udelay(10 * 1000);
+}
diff --git a/board/htc/endeavoru/endeavoru.c b/board/htc/endeavoru/endeavoru.c
new file mode 100644
index 0000000000..1d92870f91
--- /dev/null
+++ b/board/htc/endeavoru/endeavoru.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <i2c.h>
+#include <log.h>
+#include <asm/arch/pinmux.h>
+#include <asm/arch/gp_padctrl.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch-tegra/fuse.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include "pinmux-config-endeavoru.h"
+
+#define TPS80032_CTL1_I2C_ADDR		0x48
+#define TPS80032_PHOENIX_DEV_ON		0x25
+#define   DEVOFF			BIT(0)
+#define TPS80032_LDO1_CFG_STATE		0x9E
+#define TPS80032_LDO1_CFG_VOLTAGE	0x9F
+
+#ifdef CONFIG_CMD_POWEROFF
+int do_poweroff(struct cmd_tbl *cmdtp, int flag,
+		int argc, char *const argv[])
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS80032_CTL1_I2C_ADDR, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return 0;
+	}
+
+	ret = dm_i2c_reg_write(dev, TPS80032_PHOENIX_DEV_ON, DEVOFF);
+	if (ret)
+		return ret;
+
+	// wait some time and then print error
+	mdelay(5000);
+
+	printf("Failed to power off!!!\n");
+	return 1;
+}
+#endif
+
+/*
+ * Routine: pinmux_init
+ * Description: Do individual peripheral pinmux configs
+ */
+void pinmux_init(void)
+{
+	pinmux_config_pingrp_table(endeavoru_pinmux_common,
+		ARRAY_SIZE(endeavoru_pinmux_common));
+}
+
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+static void tps80032_voltage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS80032_CTL1_I2C_ADDR, 1, &dev);
+	if (ret)
+		log_debug("cannot find PMIC I2C chip\n");
+
+	/* TPS80032: LDO1_REG = 1.2v to DSI */
+	ret = dm_i2c_reg_write(dev, TPS80032_LDO1_CFG_VOLTAGE, 0x03);
+	if (ret)
+		log_debug("avdd_dsi_csi voltage set failed: %d\n", ret);
+
+	/* TPS80032: LDO1_REG enable */
+	ret = dm_i2c_reg_write(dev, TPS80032_LDO1_CFG_STATE, 0x01);
+	if (ret)
+		log_debug("avdd_dsi_csi enable failed: %d\n", ret);
+}
+
+/*
+ * Routine: pin_mux_mmc
+ * Description: setup the MMC muxes, power rails, etc.
+ */
+void pin_mux_mmc(void)
+{
+	/* Bring up DSI power */
+	tps80032_voltage_init();
+}
+#endif	/* MMC */
+
+#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	/* Remove TrustZone nodes */
+	fdt_del_node_and_alias(blob, "/firmware");
+	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
+
+	return 0;
+}
+#endif
+
+void nvidia_board_late_init(void)
+{
+	char serialno_str[17];
+
+	/* Set chip id as serialno */
+	sprintf(serialno_str, "%016llx", tegra_chip_uid());
+	env_set("serial#", serialno_str);
+	env_set("platform", "Tegra 3 T30");
+}
diff --git a/board/htc/endeavoru/pinmux-config-endeavoru.h b/board/htc/endeavoru/pinmux-config-endeavoru.h
new file mode 100644
index 0000000000..a00c5c988f
--- /dev/null
+++ b/board/htc/endeavoru/pinmux-config-endeavoru.h
@@ -0,0 +1,362 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2022, Svyatoslav Ryhel.
+ */
+
+#ifndef _PINMUX_CONFIG_ENDEAVORU_H_
+#define _PINMUX_CONFIG_ENDEAVORU_H_
+
+#define DEFAULT_PINMUX(_pingrp, _mux, _pull, _tri, _io)		\
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_DEFAULT,	\
+		.od		= PMUX_PIN_OD_DEFAULT,		\
+		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
+	}
+
+#define I2C_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _od)	\
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_##_lock,	\
+		.od		= PMUX_PIN_OD_##_od,		\
+		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
+	}
+
+#define LV_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _ioreset) \
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_##_lock,	\
+		.od		= PMUX_PIN_OD_DEFAULT,		\
+		.ioreset	= PMUX_PIN_IO_RESET_##_ioreset	\
+	}
+
+#define DEFAULT_PADCFG(_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) \
+	{							\
+		.drvgrp		= PMUX_DRVGRP_##_drvgrp,	\
+		.slwf		= _slwf,			\
+		.slwr		= _slwr,			\
+		.drvup		= _drvup,			\
+		.drvdn		= _drvdn,			\
+		.lpmd		= PMUX_LPMD_##_lpmd,		\
+		.schmt		= PMUX_SCHMT_##_schmt,		\
+		.hsm		= PMUX_HSM_##_hsm,		\
+	}
+
+static struct pmux_pingrp_config endeavoru_pinmux_common[] = {
+	/* SDMMC1 pinmux */
+	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,  SDMMC1, NORMAL,   NORMAL, OUTPUT),
+	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,  SDMMC1,     UP,   NORMAL,  INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT3_PY4,  UARTE, NORMAL,   NORMAL, OUTPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT2_PY5,  UARTE, NORMAL,   NORMAL,  INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT1_PY6,  RSVD2, NORMAL, TRISTATE,  INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT0_PY7, SDMMC1,     UP,   NORMAL,  INPUT),
+
+	/* SDMMC3 pinmux */
+	DEFAULT_PINMUX(SDMMC3_CLK_PA6,   SDMMC3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_CMD_PA7,   SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,  SDMMC3,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT6_PD3, INVALID, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT7_PD4, INVALID, NORMAL, NORMAL, INPUT),
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CLK_PCC4,  SDMMC4, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_CMD_PT7,   SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT0_PAA0, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT1_PAA1, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT2_PAA2, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT3_PAA3, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT4_PAA4, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT5_PAA5, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT6_PAA6, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_DAT7_PAA7, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(SDMMC4_RST_N_PCC3, RSVD2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+
+	/* I2C pinmux */
+	I2C_PINMUX(GEN1_I2C_SCL_PC4,  I2C1, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(GEN1_I2C_SDA_PC5,  I2C1, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(GEN2_I2C_SCL_PT5,  I2C2, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(GEN2_I2C_SDA_PT6,  I2C2, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(CAM_I2C_SCL_PBB1,  I2C3, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(CAM_I2C_SDA_PBB2,  I2C3, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(DDC_SCL_PV4,       I2C4, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(DDC_SDA_PV5,       I2C4, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(PWR_I2C_SCL_PZ6, I2CPWR, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+	I2C_PINMUX(PWR_I2C_SDA_PZ7, I2CPWR, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
+
+	/* HDMI pinmux */
+	DEFAULT_PINMUX(HDMI_CEC_PEE3,  CEC, NORMAL,   NORMAL, INPUT),
+	DEFAULT_PINMUX(HDMI_INT_PN7, RSVD1, NORMAL, TRISTATE, INPUT),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA0_PO1, UARTA, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(ULPI_DATA1_PO2, UARTA, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA2_PO3,  SPI3, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA3_PO4,   HSI, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA4_PO5,  SPI2, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA5_PO6,  ULPI, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA6_PO7,  ULPI, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_DATA7_PO0,  SPI2, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(ULPI_CLK_PY0,   RSVD2, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(ULPI_DIR_PY1,   RSVD2, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(ULPI_NXT_PY2,    ULPI, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(ULPI_STP_PY3,    ULPI, NORMAL, NORMAL,  INPUT),
+
+	/* DAP3 pinmux */
+	DEFAULT_PINMUX(DAP3_FS_PP0,   I2S2, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP3_DIN_PP1,  I2S2, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP3_DOUT_PP2, I2S2, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP3_SCLK_PP3, I2S2, NORMAL, NORMAL, INPUT),
+
+	/* PV-gpio group pinmux */
+	DEFAULT_PINMUX(PV0, RSVD1, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(PV1, RSVD1, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(PV2, RSVD2, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(PV3, RSVD2, NORMAL, NORMAL, OUTPUT),
+
+	/* CLK2 pinmux */
+	DEFAULT_PINMUX(CLK2_OUT_PW5,  RSVD4, NORMAL, NORMAL,  INPUT),
+	DEFAULT_PINMUX(CLK2_REQ_PCC5, RSVD4, NORMAL, NORMAL, OUTPUT),
+
+	/* LCD pinmux */
+	DEFAULT_PINMUX(LCD_PWR1_PC1,     RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_PWR2_PC6,  DISPLAYA, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_SDIN_PZ2,  DISPLAYA,     UP, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_SDOUT_PN5, DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_WR_N_PZ3,  DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_CS0_N_PN4,    RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_DC0_PN6,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_SCK_PZ4,   DISPLAYA,     UP, TRISTATE, OUTPUT),
+	DEFAULT_PINMUX(LCD_PWR0_PB2,  DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_PCLK_PB3,  DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_DE_PJ1,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_HSYNC_PJ3, DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_VSYNC_PJ4, DISPLAYA,   DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D0_PE0,    DISPLAYA, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D1_PE1,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D2_PE2,       RSVD3, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D3_PE3,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D4_PE4,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D5_PE5,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D6_PE6,       RSVD3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D7_PE7,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D8_PF0,       RSVD4,   DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D9_PF1,    DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D10_PF2,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D11_PF3,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D12_PF4,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D13_PF5,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D14_PF6,      RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D15_PF7,      RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D16_PM0,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D17_PM1,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D18_PM2,      RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D19_PM3,      RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D20_PM4,   DISPLAYA, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_D21_PM5,      RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D22_PM6,      RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_D23_PM7,      RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_CS1_N_PW0,    RSVD4,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(LCD_M1_PW1,    DISPLAYA, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(LCD_DC1_PD2,      RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(CRT_HSYNC_PV6,      CRT, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(CRT_VSYNC_PV7,    RSVD4, NORMAL, NORMAL, OUTPUT),
+
+	/* VI-group pinmux */
+	LV_PINMUX(VI_D0_PT4,    INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D1_PD5,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D2_PL0,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D3_PL1,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D4_PL2,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D5_PL3,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D6_PL4,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D7_PL5,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D8_PL6,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D9_PL7,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D10_PT2,   INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_D11_PT3,   INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_PCLK_PT0,   SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_MCLK_PT1,  INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_VSYNC_PD6, INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+	LV_PINMUX(VI_HSYNC_PD7, INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
+
+	/* UART-2 pinmux */
+	DEFAULT_PINMUX(UART2_RXD_PC3,   SPI4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(UART2_TXD_PC2,   SPI4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(UART2_RTS_N_PJ6, SPI4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(UART2_CTS_N_PJ5, SPI4, NORMAL, NORMAL, INPUT),
+
+	/* UART-3 pinmux */
+	DEFAULT_PINMUX(UART3_TXD_PW6,   UARTC, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(UART3_RXD_PW7,   UARTC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(UART3_CTS_N_PA1, UARTC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(UART3_RTS_N_PC0, UARTC, NORMAL, NORMAL, OUTPUT),
+
+	/* PU-gpio group pinmux */
+	DEFAULT_PINMUX(PU0, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU1, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU2, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU3, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU4, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU5, RSVD4,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(PU6,  PWM3,     UP, TRISTATE, INPUT),
+
+	/* DAP4 pinmux */
+	DEFAULT_PINMUX(DAP4_FS_PP4,    I2S3,   DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP4_DIN_PP5,   I2S3,   DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP4_DOUT_PP6, RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(DAP4_SCLK_PP7, RSVD4, NORMAL, NORMAL, OUTPUT),
+
+	/* CLK3 pinmux */
+	DEFAULT_PINMUX(CLK3_OUT_PEE0, EXTPERIPH3, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(CLK3_REQ_PEE1,      RSVD4, NORMAL, TRISTATE, INPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_WP_N_PC7,  RSVD1,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_IORDY_PI5, RSVD1, NORMAL, TRISTATE, INPUT),
+	DEFAULT_PINMUX(GMI_WAIT_PI7,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_ADV_N_PK0, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CLK_PK1,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS0_N_PJ0,   GMI, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS1_N_PJ2, RSVD1, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS2_N_PK3, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS3_N_PK4, RSVD1, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS4_N_PK2, RSVD4,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS6_N_PI3,  NAND, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_CS7_N_PI6,  NAND, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD0_PG0,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD1_PG1,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD2_PG2,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD3_PG3,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD4_PG4,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD5_PG5,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD6_PG6,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD7_PG7,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD8_PH0,    PWM0, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(GMI_AD9_PH1,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD10_PH2,   NAND, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(GMI_AD11_PH3,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD12_PH4,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD13_PH5,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD14_PH6,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_AD15_PH7,   NAND,   UP, TRISTATE, INPUT),
+	DEFAULT_PINMUX(GMI_A16_PJ7,   UARTD, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(GMI_A17_PB0,   UARTD, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_A18_PB1,   UARTD, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_A19_PK7,   UARTD, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(GMI_WR_N_PI0,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_OE_N_PI1,  RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_DQS_PI2,   RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(GMI_RST_N_PI4, RSVD4,   UP, TRISTATE, INPUT),
+
+	DEFAULT_PINMUX(CAM_MCLK_PCC0, VI_ALT3, NORMAL, NORMAL, INPUT),
+
+	DEFAULT_PINMUX(PCC1, RSVD3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PBB0, RSVD3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PBB3,  VGP3, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(PBB4,  VGP4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PBB5,  VGP5, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PBB6,  VGP6, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PBB7, RSVD3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PCC2, RSVD3,     UP, NORMAL, INPUT),
+
+	DEFAULT_PINMUX(JTAG_RTCK_PU7, RTCK, UP, NORMAL, INPUT),
+
+	/* KBC keys */
+	DEFAULT_PINMUX(KB_ROW0_PR0, RSVD4, NORMAL, TRISTATE, INPUT),
+	DEFAULT_PINMUX(KB_ROW1_PR1,   KBC, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(KB_ROW2_PR2, RSVD4, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(KB_ROW3_PR3, RSVD3, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW4_PR4, RSVD4, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW5_PR5,   KBC, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(KB_ROW6_PR6,   KBC, NORMAL, TRISTATE, INPUT),
+	DEFAULT_PINMUX(KB_ROW7_PR7,   KBC,     UP, TRISTATE, INPUT),
+	DEFAULT_PINMUX(KB_ROW8_PS0,   KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW9_PS1,   KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW10_PS2,  KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW11_PS3,  KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW12_PS4,  KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW13_PS5,  KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW14_PS6,  KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_ROW15_PS7,  KBC, NORMAL, NORMAL, INPUT),
+
+	DEFAULT_PINMUX(KB_COL0_PQ0, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL1_PQ1, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL2_PQ2, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL3_PQ3, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL4_PQ4, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL5_PQ5, KBC,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL6_PQ6, KBC, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(KB_COL7_PQ7, KBC, NORMAL, NORMAL, INPUT),
+
+	/* CLK */
+	DEFAULT_PINMUX(CLK_32K_OUT_PA0, BLINK, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5, SYSCLK, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(OWR, OWR, UP, NORMAL, INPUT),
+
+	/* DAP1 pinmux */
+	DEFAULT_PINMUX(DAP1_FS_PN0,   I2S0, NORMAL, TRISTATE, OUTPUT),
+	DEFAULT_PINMUX(DAP1_DIN_PN1,  I2S0, NORMAL, TRISTATE, OUTPUT),
+	DEFAULT_PINMUX(DAP1_DOUT_PN2, I2S0, NORMAL, TRISTATE, INPUT),
+	DEFAULT_PINMUX(DAP1_SCLK_PN3, I2S0, NORMAL, TRISTATE, OUTPUT),
+
+	/* CLK1 pinmux */
+	DEFAULT_PINMUX(CLK1_REQ_PEE2, DAP, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(CLK1_OUT_PW4, RSVD4, NORMAL, NORMAL, INPUT),
+
+	/* SPDIF pinmux */
+	DEFAULT_PINMUX(SPDIF_IN_PK6, SPDIF, NORMAL, TRISTATE, INPUT),
+	DEFAULT_PINMUX(SPDIF_OUT_PK5, SPDIF, NORMAL, TRISTATE, OUTPUT),
+
+	/* DAP2 pinmux */
+	DEFAULT_PINMUX(DAP2_FS_PA2,   I2S1, DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP2_DIN_PA4,  I2S1, DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP2_DOUT_PA5, I2S1, DOWN, NORMAL, INPUT),
+	DEFAULT_PINMUX(DAP2_SCLK_PA3, I2S1, DOWN, NORMAL, INPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI2_MOSI_PX0,  SPI2, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(SPI2_MISO_PX1,  SPI2, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(SPI2_CS0_N_PX3, SPI2, NORMAL, NORMAL, OUTPUT),
+	DEFAULT_PINMUX(SPI2_SCK_PX2,   SPI2, NORMAL, NORMAL, OUTPUT),
+
+	DEFAULT_PINMUX(SPI2_CS1_N_PW2, SPI2,  UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SPI2_CS2_N_PW3, SPI2,  UP, TRISTATE, INPUT),
+
+	DEFAULT_PINMUX(SPI1_MOSI_PX4,  SPI1, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(SPI1_SCK_PX5,   SPI2,     UP, NORMAL, INPUT),
+	DEFAULT_PINMUX(SPI1_CS0_N_PX6, SPI1, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(SPI1_MISO_PX7, RSVD4, NORMAL, NORMAL, OUTPUT),
+
+	/* PEX pinmux */
+	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE, NORMAL, NORMAL, INPUT),
+	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE, NORMAL, NORMAL, INPUT),
+};
+
+#endif	/* _PINMUX_CONFIG_TRANSFORMER_H_ */
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
new file mode 100644
index 0000000000..a6e98e55d6
--- /dev/null
+++ b/configs/endeavoru_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2CACHE_OFF=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-htc-endeavoru"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_PROMPT="Tegra30 (Endeavoru) # "
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_ENDEAVORU=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_PBSIZE=2084
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PAUSE=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_SPL_DM=y
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="HTC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0bb4
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0c02
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_LCD_ENDEAVORU=y
+CONFIG_VIDEO_DSI_TEGRA30=y
+CONFIG_TEGRA_BACKLIGHT_PWM=y
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
diff --git a/doc/board/htc/endeavoru.rst b/doc/board/htc/endeavoru.rst
new file mode 100644
index 0000000000..950c713f2f
--- /dev/null
+++ b/doc/board/htc/endeavoru.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the HTC One X (endeavoru)
+====================================
+
+``DISCLAMER!`` Moving your HTC ONe X to use U-Boot assumes
+replacement of the vendor hboot. Vendor android firmwares
+will no longer be able to run on the device.
+This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Pack U-Boot into repart-block
+- Flash repart-block into the eMMC
+- Boot
+- Self Upgrading
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make endeavoru_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for flashing (but check the next section for additional
+adjustments).
+
+Pack U-Boot into repar-block
+----------------------------
+
+``DISCLAMER!`` All questions related to re-crypt work should be
+asked in re-crypt repo issues. NOT HERE!
+
+re-crypt is a small script which packs ``u-boot-dtb-tegra.bin`` in
+form usable by device. This process is required only on the first
+installation or to recover the device in case of a failed update.
+
+.. code-block:: bash
+
+    $ git clone https://github.com/clamor-s/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-regra.bin here
+    $ ./re-crypt.sh -d endeavoru
+
+Script will produce you a ``repart-block.bin`` ready to flash.
+
+Flash repart-block into the eMMC
+--------------------------------
+
+``DISCLAMER!`` All questions related to NvFlash should be asked
+in the proper place. NOT HERE! Flashing repart-block will erase
+all your eMMC, so make a backup before!
+
+``repart-block.bin`` contains BCT and bootloader in encrypted state
+in form which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ wheelie --blob blob.bin
+    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+
+Boot
+----
+
+After flashing ``repart-block.bin`` the device should reboot and turn
+itself off. This is normal behavior if no boot configuration is
+found.
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` configuration
+on eMMC. Additionally if Volume Down button is pressed while booting
+device will enter bootmenu. Bootmenu contains entries to mount eMMC as
+mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot
+console and update bootloader (check next chapter).
+
+Flashing ``repart-block.bin`` eliminates vendor restriction on eMMC
+and allows the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the
+eMMC (using ability of u-boot to mount it). Enter bootmenu, choose
+update bootloader option with Power button and U-Boot should update
+itself. Once the process is completed, U-Boot will ask to press any
+button to reboot.
diff --git a/doc/board/htc/index.rst b/doc/board/htc/index.rst
new file mode 100644
index 0000000000..955c9b9e03
--- /dev/null
+++ b/doc/board/htc/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+HTC
+===
+
+.. toctree::
+   :maxdepth: 2
+
+   endeavoru
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 78f260aabc..0194f0aaa3 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -26,6 +26,7 @@ Board-specific doc
    gateworks/index
    google/index
    highbank/index
+   htc/index
    intel/index
    kontron/index
    lg/index
diff --git a/include/configs/endeavoru.h b/include/configs/endeavoru.h
new file mode 100644
index 0000000000..46c582e963
--- /dev/null
+++ b/include/configs/endeavoru.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2012
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+
+#include "tegra30-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"HTC One X"
+
+#define ENDEAVORU_FLASH_UBOOT \
+	"flash_uboot=echo Preparing RAM;" \
+		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
+		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
+		"echo Reading BCT;" \
+		"mmc dev 0 1;" \
+		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
+		"echo Reading bootloader;" \
+		"if load mmc 0:1 ${ramdisk_addr_r} ${bootloader_file};" \
+		"then echo Calculating bootloader size;" \
+			"size mmc 0:1 ${bootloader_file};" \
+			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
+			"echo Writing bootloader to eMMC;" \
+			"mmc dev 0 1;" \
+			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
+			"mmc dev 0 2;" \
+			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
+			"echo Bootloader written successfully;" \
+			"pause 'Press ANY key to reboot device...'; reset;" \
+		"else echo Reading bootloader failed;" \
+			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
+
+#define ENDEAVORU_BOOTMENU \
+	ENDEAVORU_FLASH_UBOOT \
+	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
+	"bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
+	"bootmenu_2=update bootloader=run flash_uboot\0" \
+	"bootmenu_3=reboot RCM=enterrcm\0" \
+	"bootmenu_4=reboot=reset\0" \
+	"bootmenu_5=power off=poweroff\0" \
+	"bootmenu_delay=-1\0"
+
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"boot_block_size_r=0x200000\0" \
+	"boot_block_size=0x1000\0" \
+	"bootloader_file=u-boot-dtb-tegra.bin\0" \
+	"check_button=gpio input 179; test $? -eq 0\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	ENDEAVORU_BOOTMENU
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.39.2

