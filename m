Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A772C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4266F84AE6;
	Tue,  7 Jul 2026 17:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZv3QCvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A684B84A4A; Tue,  7 Jul 2026 17:32:52 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31CA849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-44cc65b0a7fso570811fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438368; x=1784043168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGkCV8irPSTFCKiNAhFat2RNZbsAqwjmvTP5q/ob4wc=;
 b=JZv3QCvbupXFBcEvp4r29Q8Ps23credd27SPpujyYruIpGuVfi5TTi5h9Zgc8IzLJC
 ga4XJFwnAke7qqNr4zDfD4tsIhouR1AuICqLR50+gHM+qAytp8SkO0ragOI40QA/ApsS
 iuLvT5XIBZmgNsbt6/Ly0bLrO4ueXOrP9o80E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438368; x=1784043168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nGkCV8irPSTFCKiNAhFat2RNZbsAqwjmvTP5q/ob4wc=;
 b=QhQXRa32uvzgngWZOpsqSFkp5QMqJedcVjR0sGou833hpvIbp9pJJVIF7dvtucoe2o
 p4N9tmdWvaYvz28qHAIRSbkv9OnJEYLTEqelk+BWYADnpGwqzfSMjNKMzxpK5SwsRtPm
 JkxlQN7NiKEO6EHj7lqKgluPHINCc8gOhbkIWvzjSCtCEymppF7Uoi58fusiDEAyrkel
 aVFifyn+o1W6hpOreiTS9wzVRYeRfEosgPqEZAAWTizZ6LGEivSOGB/wXS4rr6qreW3i
 1Tsksw56iqSfSk8tYFx2KffiMDhggEIsT79QkdzQThIUTlnoPO/2sFzgG07lhqnDQwdz
 78ow==
X-Gm-Message-State: AOJu0YzlgPt/0T3CmVKRqr1kDF8Nt1X1+X4LY60NmMsF+6zckgh1QXXb
 kj0nwS+TfiTJuwEQZt5QmDvT0ZHQ3TfiHTXQvreANhLRXeF6b+I608K2WSa6AEkNbEBL7HWRETs
 Vs2GiIQ==
X-Gm-Gg: AfdE7clJBeoGTcswi2hssdL2Pp0Ooa8qEJ3xrAmz5mYsr0JMzIy286Y/oPb2ZZHtZWI
 DUBpqZSVDAF5d8DZkwoJvdhCo+e42Mr5DYovfwlvCZAnbkLtW0OXhuU9PupS4GcPldximbD1Mqu
 JlGRTv0ry5PkmRfWuRNbXOiyJg59RS1DPICl/fdENvla0sZSIIqXDiyjW5WYQ0+NG7ldNY+ngGS
 3QrrwaZmHy7tRB789c4DzSkSioE6b2l8TnH1huZH5QbUk/kFMTZGOfUbURjLzaBSSVRHREPOGat
 obIa9zEASkmM6caV/WlzgVxQR9rYrQN328TpHoYJH+ubL5Gb0ORRFO3SSeZ4xkqXxvWSgssaYHm
 czMcaNNylg7AMn5+mi08sy+IXlZ8RQ6KNy2trLKa42fXvUZB1Jun+qsTxCVT6bqgtEVISJ6wJMk
 AO9ctJ024=
X-Received: by 2002:a05:6808:81d9:b0:4a0:9eab:4d0 with SMTP id
 5614622812f47-4a09eab05efmr1191322b6e.11.1783438368295; 
 Tue, 07 Jul 2026 08:32:48 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Chris Packham <judge.packham@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/15] omega4-rv1103b: Add the initial support
Date: Tue,  7 Jul 2026 09:31:06 -0600
Message-ID: <20260707153135.2048115-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

From: Fabio Estevam <festevam@nabladev.com>

Add the initial support for Onion's Omega4 RV1103B board, using the
board devicetree files as merged in Linux v7.1, which split the board
into rv1103b-omega4.dtsi and rv1103b-omega4-evb.dts

It boots from the SPI NAND.

Tested the boot of a 6.6 OpenWRT kernel and also a 6.19-rc8 mainline
kernel.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split out the SoC support into its own patch (Jonas)
- Move the board devicetree files into this patch (Jonas)
- Add the board to the list in the Rockchip documentation
- Extend the MAINTAINERS entry to cover all the RV1103B files
- Use the board devicetree files as merged in Linux v7.1 and switch
  the default devicetree to rv1103b-omega4-evb

Changes in v2:
- Use RV1103B rather than RV1103, which is the correct SoC name

 arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi   |  10 ++
 arch/arm/dts/rv1103b-omega4-evb.dts           |  63 ++++++++
 arch/arm/dts/rv1103b-omega4.dtsi              | 147 ++++++++++++++++++
 arch/arm/mach-rockchip/rv1103b/Kconfig        |   7 +
 board/onion/omega4_rv1103b/Kconfig            |  12 ++
 board/onion/omega4_rv1103b/MAINTAINERS        |  15 ++
 board/onion/omega4_rv1103b/Makefile           |   7 +
 board/onion/omega4_rv1103b/omega4_rv1103b.c   |  19 +++
 board/onion/omega4_rv1103b/omega4_rv1103b.env |   5 +
 configs/omega4-rv1103b_defconfig              |  82 ++++++++++
 doc/board/index.rst                           |   1 +
 doc/board/onion/index.rst                     |   9 ++
 doc/board/onion/omega4-rv1103b.rst            |  56 +++++++
 doc/board/rockchip/rockchip.rst               |   3 +
 include/configs/omega4_rv1103b.h              |  11 ++
 15 files changed, 447 insertions(+)
 create mode 100644 arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b-omega4-evb.dts
 create mode 100644 arch/arm/dts/rv1103b-omega4.dtsi
 create mode 100644 board/onion/omega4_rv1103b/Kconfig
 create mode 100644 board/onion/omega4_rv1103b/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103b/Makefile
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.env
 create mode 100644 configs/omega4-rv1103b_defconfig
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103b.rst
 create mode 100644 include/configs/omega4_rv1103b.h

diff --git a/arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi b/arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi
new file mode 100644
index 00000000000..c7616de1715
--- /dev/null
+++ b/arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = &spi_nand;
+	};
+};
diff --git a/arch/arm/dts/rv1103b-omega4-evb.dts b/arch/arm/dts/rv1103b-omega4-evb.dts
new file mode 100644
index 00000000000..c6472f933aa
--- /dev/null
+++ b/arch/arm/dts/rv1103b-omega4-evb.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2025 plan44.ch/luz
+ * Copyright (c) 2026 Onion Corporation
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "rv1103b-omega4.dtsi"
+
+/ {
+	model = "Onion Omega4 Evaluation Board";
+	compatible = "onion,omega4-evb", "onion,omega4", "rockchip,rv1103b";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0	{
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "on";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+			label = "sys";
+			pinctrl-names = "default";
+			pinctrl-0 = <&led>;
+		};
+	};
+};
+
+&fspi0 {
+	status = "okay";
+};
+
+&pinctrl {
+	leds {
+		led: led {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdmmc0 {
+	status = "okay";
+};
+
+&sdmmc1 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rv1103b-omega4.dtsi b/arch/arm/dts/rv1103b-omega4.dtsi
new file mode 100644
index 00000000000..6a8e8e0f80c
--- /dev/null
+++ b/arch/arm/dts/rv1103b-omega4.dtsi
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2025 plan44.ch/luz
+ * Copyright (c) 2026 Onion Corporation
+ */
+
+/dts-v1/;
+
+#include "rv1103b.dtsi"
+
+/ {
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <300>;
+		reset-gpios = <&gpio2 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc3v3_sd: vcc3v3-sd {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren>;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vccio_sd: vccio-sd {
+		compatible = "regulator-gpio";
+		gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_volt>;
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 1 1800000 0>;
+	};
+};
+
+&uart0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
+};
+
+&fspi0 {
+	spi_nand: flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
+		spi-max-frequency = <75000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x00000000 0x00040000>;
+				label = "env";
+			};
+
+			partition@40000 {
+				reg = <0x00040000 0x00100000>;
+				label = "idblock";
+				read-only;
+			};
+
+			partition@140000 {
+				reg = <0x00140000 0x00100000>;
+				label = "uboot";
+				read-only;
+			};
+
+			partition@240000 {
+				reg = <0x00240000 0x00800000>;
+				label = "boot";
+			};
+
+			partition@a40000 {
+				reg = <0x00a40000 0x0f5c0000>;
+				label = "ubi";
+			};
+		};
+	};
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	no-sdio;
+	no-mmc;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "disabled";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-sd;
+	no-mmc;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_cmd &sdmmc1_clk &sdmmc1_bus4>;
+	status = "disabled";
+};
+
+&pinctrl {
+	sdio-pwrseq {
+		/omit-if-no-ref/
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc {
+		/omit-if-no-ref/
+		sdmmc_pwren: sdmmc-pwren {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc_volt: sdmmc-volt {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wireless-wlan {
+		/omit-if-no-ref/
+		wifi_host_wake_irq: wifi-host-wake-irq {
+			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/arch/arm/mach-rockchip/rv1103b/Kconfig b/arch/arm/mach-rockchip/rv1103b/Kconfig
index 710a86aeb33..77699a5180e 100644
--- a/arch/arm/mach-rockchip/rv1103b/Kconfig
+++ b/arch/arm/mach-rockchip/rv1103b/Kconfig
@@ -1,5 +1,10 @@
 if ROCKCHIP_RV1103B
 
+config TARGET_OMEGA4_RV1103B
+	bool "OMEGA4_RV1103B"
+	help
+	  Support Onion's Omega4 RV1103B board.
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0x20160200
 
@@ -12,4 +17,6 @@ config SYS_SOC
 config SYS_MALLOC_F_LEN
 	default 0x400
 
+source "board/onion/omega4_rv1103b/Kconfig"
+
 endif
diff --git a/board/onion/omega4_rv1103b/Kconfig b/board/onion/omega4_rv1103b/Kconfig
new file mode 100644
index 00000000000..43b126c20e9
--- /dev/null
+++ b/board/onion/omega4_rv1103b/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_OMEGA4_RV1103B
+
+config SYS_BOARD
+	default "omega4_rv1103b"
+
+config SYS_VENDOR
+	default "onion"
+
+config SYS_CONFIG_NAME
+	default "omega4_rv1103b"
+
+endif
diff --git a/board/onion/omega4_rv1103b/MAINTAINERS b/board/onion/omega4_rv1103b/MAINTAINERS
new file mode 100644
index 00000000000..5ad58118989
--- /dev/null
+++ b/board/onion/omega4_rv1103b/MAINTAINERS
@@ -0,0 +1,15 @@
+OMEGA4 RV1103B
+M:	Fabio Estevam <festevam@nabladev.com>
+S:	Maintained
+F:	arch/arm/dts/rv1103b*
+F:	arch/arm/include/asm/arch-rv1103b/
+F:	arch/arm/include/asm/arch-rockchip/cru_rv1103b.h
+F:	arch/arm/mach-rockchip/rv1103b/
+F:	board/onion/omega4_rv1103b/
+F:	configs/omega4-rv1103b_defconfig
+F:	doc/board/onion/
+F:	drivers/clk/rockchip/clk_rv1103b.c
+F:	drivers/pinctrl/rockchip/pinctrl-rv1103b.c
+F:	include/configs/omega4_rv1103b.h
+F:	include/configs/rv1103b_common.h
+F:	include/dt-bindings/clock/rockchip,rv1103b-cru.h
diff --git a/board/onion/omega4_rv1103b/Makefile b/board/onion/omega4_rv1103b/Makefile
new file mode 100644
index 00000000000..afa0a7f7a93
--- /dev/null
+++ b/board/onion/omega4_rv1103b/Makefile
@@ -0,0 +1,7 @@
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright 2026 Fabio Estevam <festevam@nabladev.com>
+#
+
+obj-y	+= omega4_rv1103b.o
diff --git a/board/onion/omega4_rv1103b/omega4_rv1103b.c b/board/onion/omega4_rv1103b/omega4_rv1103b.c
new file mode 100644
index 00000000000..9bdec3c396a
--- /dev/null
+++ b/board/onion/omega4_rv1103b/omega4_rv1103b.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2026 Fabio Estevam <festevam@nabladev.com>
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = SZ_256M;
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return gd->ram_top;
+}
diff --git a/board/onion/omega4_rv1103b/omega4_rv1103b.env b/board/onion/omega4_rv1103b/omega4_rv1103b.env
new file mode 100644
index 00000000000..7ed232cab91
--- /dev/null
+++ b/board/onion/omega4_rv1103b/omega4_rv1103b.env
@@ -0,0 +1,5 @@
+kernel_addr_r=0x00800000
+fdt_addr_r=0x02000000
+ramdisk_addr_r=0x04000000
+bootargs=console=ttyS0,115200 mtdparts=spi1.0:256K(env),1M@256K(idblock),1M(uboot),8M(boot),-(ubi) ro rootwait ubi.mtd=ubi ubi.block=0,rootfs root=/dev/ubiblock0_0 rootfstype=squashfs
+bootcmd=mtd read spi-nand0 0x04000000 0x240000 0x800000;imxtract 0x04000000 kernel 0x00800000; imxtract 0x04000000 fdt 0x02000000; bootz 0x00800000 - 0x02000000
diff --git a/configs/omega4-rv1103b_defconfig b/configs/omega4-rv1103b_defconfig
new file mode 100644
index 00000000000..04e51af605c
--- /dev/null
+++ b/configs/omega4-rv1103b_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00400000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_DEFAULT_DEVICE_TREE="rv1103b-omega4-evb"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_ROCKCHIP_RV1103B=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_EXTERNAL_TPL=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_OMEGA4_RV1103B=y
+CONFIG_SYS_BOOTM_LEN=0x04000000
+CONFIG_SYS_LOAD_ADDR=0x00008000
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0x20540000
+CONFIG_DEBUG_UART_CLOCK=24000000
+# CONFIG_DEBUG_UART_BOARD_INIT is not set
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_CIPHER=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=1
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_NAND_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x140000
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+# CONFIG_MMC is not set
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_ROCKCHIP_RV1103B=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+# CONFIG_RSA is not set
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_SPL_SHA256 is not set
+CONFIG_LZMA=y
+CONFIG_SPL_LZMA=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 4103fef8d8f..2454c3598fb 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -46,6 +46,7 @@ Board-specific doc
    motorola/index
    nvidia/index
    nxp/index
+   onion/index
    openpiton/index
    ouya/index
    pegatron/index
diff --git a/doc/board/onion/index.rst b/doc/board/onion/index.rst
new file mode 100644
index 00000000000..2e106c8b773
--- /dev/null
+++ b/doc/board/onion/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Onion
+=====
+
+.. toctree::
+   :maxdepth: 2
+
+   omega4-rv1103b
diff --git a/doc/board/onion/omega4-rv1103b.rst b/doc/board/onion/omega4-rv1103b.rst
new file mode 100644
index 00000000000..41c64f40d6c
--- /dev/null
+++ b/doc/board/onion/omega4-rv1103b.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Onion Omega4 RV1103B board
+==========================
+
+U-Boot for the Onion Omega4 RV1103B board
+
+Quick Start
+-----------
+
+- Get the DDR initialization binary
+- Build U-Boot
+- Flash U-Boot into the SPI NAND
+
+Get the DDR initialization binary
+---------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/rockchip-linux/rkbin.git
+
+The RV1103B DDR initialization is located at rkbin/bin/rv11/rv1103bb_ddr_924MHz_v1.05.bin
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=arm-linux-gnueabihf-
+   $ export ROCKCHIP_TPL=<path-to-rkbin>/bin/rv11/rv1103bb_ddr_924MHz_v1.05.bin
+   $ make omega4-rv1103b_defconfig
+   $ make
+
+The idbloader-spi.img and u-boot.img are the binaries that need to be flashed
+into the SPI NAND.
+
+Flash U-Boot into the SPI NAND
+------------------------------
+
+Connect the USB OTG and UART console cables from the Omega4 board to
+the host PC.
+
+Press the BOOT button while applying power to the board.
+
+The string "RKUART" should appear on the console (115200,8N1).
+
+Install the rkdeveloptool from https://github.com/rockchip-linux/rkdeveloptool
+by following the instruction in the README file.
+
+.. code-block:: bash
+
+   $ sudo ./rkdeveloptool db download.bin
+   $ sudo ./rkdeveloptool wl 0x200 idbloader.img
+   $ sudo ./rkdeveloptool wl 0xa00 u-boot.img
+
+Power cycle the board and U-Boot output is seen on the console.
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index a31ee7100b9..2574a1da52c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -180,6 +180,9 @@ List of mainline supported Rockchip boards:
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
      - Yanyi Tech CoolPi CM5 GenBook (coolpi-cm5-genbook-rk3588)
 
+* rv1103b
+     - Onion Omega4 (omega4-rv1103b), see :doc:`../onion/omega4-rv1103b`
+
 * rv1108
      - Rockchip Evb-rv1108 (evb-rv1108)
      - Elgin-R1 (elgin-rv1108)
diff --git a/include/configs/omega4_rv1103b.h b/include/configs/omega4_rv1103b.h
new file mode 100644
index 00000000000..8430b0b4d09
--- /dev/null
+++ b/include/configs/omega4_rv1103b.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/rv1103b_common.h>
+
+#endif
-- 
2.43.0

