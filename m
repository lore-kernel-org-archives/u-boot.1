Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA0C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6F2871F0;
	Wed, 13 Dec 2023 04:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KYU0e5U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83BB877EC; Wed, 13 Dec 2023 04:17:10 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F42987822
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d9d84019c5so4850789a34.3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437419; x=1703042219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCKfxk7RxxuQybzuaeY5DVICR5kE7xn8ldimDxWoUtQ=;
 b=KYU0e5U5p/hhfhYncN4MIFbUSPjueRe0j06XeSpKIflf4MIE53GBlmOH8kvWTGfgui
 lX9DEMT47mk7n3AdWOsbvTH6RfCW361FNiXAwT31+OvbJtz4qwVUvIa06VkQR9F+82o8
 RNXDoIdw5Q4JqIeXER9yNOQygYzff0xlvkL1W7+ZLa34GUWNC+2tfrdwHe8Cgpl0JD03
 ExeTetoMeZ2ur1sjy/my3dvTCzk2PtMl69zkvPV+AzUPiDqtWbkL8P7CNLbSJK+hZAZ6
 0z1ZFSdUAOi+zfhrPdKx8SId/QU7YqbjAOVTOKmP3mETmrISsRu+Z+WUC0fynwu0lNVq
 i+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437419; x=1703042219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCKfxk7RxxuQybzuaeY5DVICR5kE7xn8ldimDxWoUtQ=;
 b=YqolVIRwJ3U+m6/U5ZlGCnFIXxU5u06nQiC0CcP9craeDXEI5j78xQGjSMYXRwxxEA
 34ixIQnNEi8zbP6E8uKwk8V4BrJr2fFaROk7ckXFY3Bcj0tL1P5/WDJapx+JV5hxfkav
 +rMr0mp9Aie+b/YzIYYhhtKKFkRqKAwWw/BQBdiqA1nG+riP5yzEqxB90waUAYHtVPVn
 fiz43U+EhHm+pC1Ev9qWAUxliLyb0znoSR2ZEVfuLdngOw6vtDmuyA2OcVuMn6OLz98R
 YqwPO1QXjkdsyPC0ieT/uZB4ThuNp2sE9wRTvKSDPBYRtuQaORFP55QGwm0B2ChiVh7e
 z/0A==
X-Gm-Message-State: AOJu0YyVGBYOLrTk1MWc2Fuua8oofZgcc3Ue/c/keaxc4wQdJPVLKfva
 BIJZPNbp4ufeGoD+gKvXaV6fSw==
X-Google-Smtp-Source: AGHT+IEOKQqxXs6sI9Ec2vqbPYTAA12Jz8CoxhAqWZ+8Lekmv6HPgvhWARxCwP70LoUJmy9ROP23Lw==
X-Received: by 2002:a9d:7a89:0:b0:6d8:74e2:8a51 with SMTP id
 l9-20020a9d7a89000000b006d874e28a51mr7152227otn.48.1702437418859; 
 Tue, 12 Dec 2023 19:16:58 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 cm11-20020a056830650b00b006d99d363723sm1642853otb.63.2023.12.12.19.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:58 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 12/13] board: samsung: Add support for E850-96 board
Date: Tue, 12 Dec 2023 21:16:45 -0600
Message-Id: <20231213031646.28828-13-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Add support for WinLink E850-96 board [1]. It's based on Exynos850 SoC
and follows 96boards specification, so it's compatible with 96boards
mezzanine boards [2]. This patch enables next features:

  * Serial console
  * USI
  * PMU (muxing AP UART path)
  * Pinctrl
  * Clocks
  * Timer (ARMv8 architected)
  * Reset control

It's quite a minimal enablement. Features like MMC, USB and Ethernet
will be enabled later.

The rationale for config values is as follows:

  * TEXT_BASE = 0xf8800000

    That's where BL2 loads the U-Boot payload, so TEXT_BASE must be
    exactly this value. Overall the memory map is designed in a way to
    keep the bootloader in the upper 128 MiB area of RAM, which is
    0xf8000000..0xffffffff. That includes bootloader's code, stack,
    data, heap, MMU tables, etc. All the memory below that 128 MiB chunk
    can be used for storing boot images (0x80000000..0xf8000000).

  * CUSTOM_SYS_INIT_SP_ADDR = 0xf8c00000

    Just 4 MiB above the TEXT_BASE address, to leave enough space for
    U-Boot code and stack itself (grows downwards).

  * SYS_LOAD_ADDR = 0x80000000

    The beginning of RAM. That's where Linux kernel image must be
    loaded.

  * SYS_MALLOC_LEN = 0x81f000

    8 MiB for malloc() + ENV_SIZE (128 KiB)

  * SYS_MALLOC_F_LEN = 0x4000

    Increase malloc() pool size available before relocation from 8 KiB
    (default) to 16 KiB. Otherwise "alloc space exhausted" message
    appears in U-Boot log during board_init_f() stage. There are next
    reasons for doing so:

      1. Having "bootph-all" flags in some dts nodes leads to binding
         those during pre-relocation stage, and binding (DM) uses
         dynamic memory allocation
      2. clk-exynos850 driver uses CCF clocks, which in turn use dynamic
         memory allocation

Device tree file was imported from Linux kernel. All nodes and boot
phase flags added in exynos850-e850-96-u-boot.dtsi are only needed to
enable serial console:

  * oscclk -> cmu_top -> cmu_peri: generate UART/USI clocks
  * pinctrl_alive and uart1_pins: needed to mux UART pins
  * pmu_system_controller: configures AP UART path to uart1_pins
  * usi_uart: configures USI block to operate as a UART protocol
  * serial_0: enables serial console (UART)

[1] https://www.96boards.org/product/e850-96b/
[2] https://www.96boards.org/products/mezzanine/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi    |   37 +
 arch/arm/dts/exynos850-e850-96.dts            |  273 ++++
 arch/arm/mach-exynos/Kconfig                  |   19 +-
 board/samsung/e850-96/Kconfig                 |   16 +
 board/samsung/e850-96/MAINTAINERS             |    9 +
 board/samsung/e850-96/Makefile                |    6 +
 board/samsung/e850-96/e850-96.c               |   22 +
 configs/e850-96_defconfig                     |   21 +
 doc/board/samsung/e850-96.rst                 |   87 ++
 .../img/exynos850-boot-architecture.svg       | 1283 +++++++++++++++++
 doc/board/samsung/index.rst                   |    1 +
 include/configs/e850-96.h                     |   12 +
 13 files changed, 1786 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/exynos850-e850-96-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos850-e850-96.dts
 create mode 100644 board/samsung/e850-96/Kconfig
 create mode 100644 board/samsung/e850-96/MAINTAINERS
 create mode 100644 board/samsung/e850-96/Makefile
 create mode 100644 board/samsung/e850-96/e850-96.c
 create mode 100644 configs/e850-96_defconfig
 create mode 100644 doc/board/samsung/e850-96.rst
 create mode 100644 doc/board/samsung/img/exynos850-boot-architecture.svg
 create mode 100644 include/configs/e850-96.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 5fc888680b39..7d949a6798ee 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_EXYNOS7420) += exynos7420-espresso7420.dtb
 dtb-$(CONFIG_TARGET_A5Y17LTE) += exynos78x0-axy17lte.dtb
 dtb-$(CONFIG_TARGET_A3Y17LTE) += exynos78x0-axy17lte.dtb
 dtb-$(CONFIG_TARGET_A7Y17LTE) += exynos78x0-axy17lte.dtb
+dtb-$(CONFIG_TARGET_E850_96) += exynos850-e850-96.dtb
 
 dtb-$(CONFIG_ARCH_APPLE) += \
 	t8103-j274.dtb \
diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
new file mode 100644
index 000000000000..7ad11e9faab2
--- /dev/null
+++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ */
+
+&cmu_top {
+	bootph-all;
+};
+
+&cmu_peri {
+	bootph-all;
+};
+
+&oscclk {
+	bootph-all;
+};
+
+&pinctrl_alive {
+	bootph-all;
+};
+
+&pmu_system_controller {
+	bootph-all;
+	samsung,uart-debug-1;
+};
+
+&serial_0 {
+	bootph-all;
+};
+
+&uart1_pins {
+	bootph-all;
+};
+
+&usi_uart {
+	bootph-all;
+};
diff --git a/arch/arm/dts/exynos850-e850-96.dts b/arch/arm/dts/exynos850-e850-96.dts
new file mode 100644
index 000000000000..f074df8982b3
--- /dev/null
+++ b/arch/arm/dts/exynos850-e850-96.dts
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WinLink E850-96 board device tree source
+ *
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Device tree source file for WinLink's E850-96 board which is based on
+ * Samsung Exynos850 SoC.
+ */
+
+/dts-v1/;
+
+#include "exynos850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "WinLink E850-96 board";
+	compatible = "winlink,e850-96", "samsung,exynos850";
+
+	aliases {
+		mmc0 = &mmc_0;
+		serial0 = &serial_0;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		vbus-supply = <&reg_usb_host_vbus>;
+		id-gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&micro_usb_det_pins>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
+	};
+
+	/*
+	 * RAM: 4 GiB (eMCP):
+	 *   - 2 GiB at 0x80000000
+	 *   - 2 GiB at 0x880000000
+	 *
+	 * 0xbab00000..0xbfffffff: secure memory (85 MiB).
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x3ab00000>,
+		      <0x0 0xc0000000 0x40000000>,
+		      <0x8 0x80000000 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
+
+		volume-down-key {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpa1 0 GPIO_ACTIVE_LOW>;
+		};
+
+		volume-up-key {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpa0 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* HEART_BEAT_LED */
+		user_led1: led-1 {
+			label = "yellow:user1";
+			gpios = <&gpg2 2 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+
+		/* eMMC_LED */
+		user_led2: led-2 {
+			label = "yellow:user2";
+			gpios = <&gpg2 3 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			linux,default-trigger = "mmc0";
+		};
+
+		/* SD_LED */
+		user_led3: led-3 {
+			label = "white:user3";
+			gpios = <&gpg2 4 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_SD;
+			linux,default-trigger = "mmc2";
+		};
+
+		/* WIFI_LED */
+		wlan_active_led: led-4 {
+			label = "yellow:wlan";
+			gpios = <&gpg2 6 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WLAN;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		/* BLUETOOTH_LED */
+		bt_active_led: led-5 {
+			label = "blue:bt";
+			gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_BLUETOOTH;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
+
+	/* TODO: Remove this once PMIC is implemented  */
+	reg_dummy: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "dummy_reg";
+	};
+
+	reg_usb_host_vbus: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_host_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpa3 5 GPIO_ACTIVE_LOW>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops@f0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xf0000000 0x200000>;
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x100000>;
+			pmsg-size = <0x20000>;
+		};
+	};
+
+	/*
+	 * RTC clock (XrtcXTI); external, must be 32.768 kHz.
+	 *
+	 * TODO: Remove this once RTC clock is implemented properly as part of
+	 *       PMIC driver.
+	 */
+	rtcclk: clock-rtcclk {
+		compatible = "fixed-clock";
+		clock-output-names = "rtcclk";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+};
+
+&cmu_hsi {
+	clocks = <&oscclk>, <&rtcclk>,
+		 <&cmu_top CLK_DOUT_HSI_BUS>,
+		 <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
+		 <&cmu_top CLK_DOUT_HSI_USB20DRD>;
+	clock-names = "oscclk", "rtcclk", "dout_hsi_bus",
+		      "dout_hsi_mmc_card", "dout_hsi_usb20drd";
+};
+
+&mmc_0 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-highspeed;
+	non-removable;
+	mmc-hs400-enhanced-strobe;
+	card-detect-delay = <200>;
+	clock-frequency = <800000000>;
+	bus-width = <8>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <2 4>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk_pins &sd0_cmd_pins &sd0_rdqs_pins &sd0_nreset_pins
+		     &sd0_bus1_pins &sd0_bus4_pins &sd0_bus8_pins>;
+};
+
+&oscclk {
+	clock-frequency = <26000000>;
+};
+
+&pinctrl_alive {
+	key_voldown_pins: key-voldown-pins {
+		samsung,pins = "gpa1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	key_volup_pins: key-volup-pins {
+		samsung,pins = "gpa0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	micro_usb_det_pins: micro-usb-det-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&cmu_apm CLK_GOUT_RTC_PCLK>, <&rtcclk>;
+	clock-names = "rtc", "rtc_src";
+};
+
+&serial_0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&usbdrd {
+	status = "okay";
+	vdd10-supply = <&reg_dummy>;
+	vdd33-supply = <&reg_dummy>;
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "host";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+&usbdrd_phy {
+	status = "okay";
+};
+
+&usi_uart {
+	samsung,clkreq-on; /* needed for UART mode */
+	status = "okay";
+};
+
+&watchdog_cl0 {
+	status = "okay";
+};
+
+&watchdog_cl1 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 45fc6bb024b0..af00ee1db07a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -2,7 +2,7 @@ if ARCH_EXYNOS
 
 config BOARD_COMMON
 	def_bool y
-	depends on !TARGET_SMDKV310 && !TARGET_ARNDALE
+	depends on !TARGET_SMDKV310 && !TARGET_ARNDALE && !TARGET_E850_96
 
 config SPI_BOOTING
 	bool
@@ -237,6 +237,22 @@ config  TARGET_A3Y17LTE
 endchoice
 endif
 
+if ARCH_EXYNOS9
+
+choice
+	prompt "EXYNOS9 board select"
+
+config TARGET_E850_96
+	bool "WinLink E850-96 board"
+	select ARM64
+	select CLK_EXYNOS
+	select OF_CONTROL
+	select PINCTRL
+	select PINCTRL_EXYNOS850
+
+endchoice
+endif
+
 config SYS_SOC
 	default "exynos"
 
@@ -261,5 +277,6 @@ source "board/samsung/smdk5250/Kconfig"
 source "board/samsung/smdk5420/Kconfig"
 source "board/samsung/espresso7420/Kconfig"
 source "board/samsung/axy17lte/Kconfig"
+source "board/samsung/e850-96/Kconfig"
 
 endif
diff --git a/board/samsung/e850-96/Kconfig b/board/samsung/e850-96/Kconfig
new file mode 100644
index 000000000000..f891a906959b
--- /dev/null
+++ b/board/samsung/e850-96/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_E850_96
+
+config EXYNOS850
+	bool "Exynos850 SoC support"
+	default y
+
+config SYS_BOARD
+	default "e850-96"
+
+config SYS_VENDOR
+	default "samsung"
+
+config SYS_CONFIG_NAME
+	default "e850-96"
+
+endif
diff --git a/board/samsung/e850-96/MAINTAINERS b/board/samsung/e850-96/MAINTAINERS
new file mode 100644
index 000000000000..e8b9365eea85
--- /dev/null
+++ b/board/samsung/e850-96/MAINTAINERS
@@ -0,0 +1,9 @@
+WINLINK E850-96 BOARD
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	arch/arm/dts/exynos850-e850-96-u-boot.dtsi
+F:	arch/arm/dts/exynos850-e850-96.dts
+F:	board/samsung/e850-96/
+F:	configs/e850-96_defconfig
+F:	doc/board/samsung/e850-96.rst
+F:	include/configs/e850-96.h
diff --git a/board/samsung/e850-96/Makefile b/board/samsung/e850-96/Makefile
new file mode 100644
index 000000000000..301c22337119
--- /dev/null
+++ b/board/samsung/e850-96/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2020, Linaro Limited
+# Sam Protsenko <semen.protsenko@linaro.org>
+
+obj-y	:= e850-96.o
diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
new file mode 100644
index 000000000000..a00d81b5d4c3
--- /dev/null
+++ b/board/samsung/e850-96/e850-96.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020, Linaro Limited
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#include <init.h>
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
new file mode 100644
index 000000000000..bb41635ff784
--- /dev/null
+++ b/configs/e850-96_defconfig
@@ -0,0 +1,21 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_EXYNOS=y
+CONFIG_TEXT_BASE=0xf8800000
+CONFIG_SYS_MALLOC_LEN=0x81f000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_ARCH_EXYNOS9=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
+CONFIG_DEFAULT_DEVICE_TREE="exynos850-e850-96"
+CONFIG_SYS_LOAD_ADDR=0x80000000
+# CONFIG_AUTOBOOT is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_NET is not set
+CONFIG_CLK_EXYNOS850=y
+# CONFIG_MMC is not set
+CONFIG_SOC_SAMSUNG=y
+CONFIG_EXYNOS_PMU=y
+CONFIG_EXYNOS_USI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_SYSCON=y
diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
new file mode 100644
index 000000000000..0cb95473e536
--- /dev/null
+++ b/doc/board/samsung/e850-96.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Sam Protsenko <semen.protsenko@linaro.org>
+
+WinLink E850-96 board
+=====================
+
+Overview
+--------
+
+WinLink's E850-96 board [1]_ is based on Samsung Exynos850 SoC and follows
+96Boards Consumer Edition specification [2]_. That makes it possible to use
+96Boards mezzanine boards [3]_ along with it. It's an open-hardware board and
+the hardware design files [4]_ were published, along with the supported
+software [5]_ and related documentation.
+
+U-Boot can be used on E850-96 instead of the original Samsung LittleKernel based
+bootloader [6]_. Because FWBL1 [7]_ doesn't verify bootloader's signature, there
+is no need to sign a U-Boot binary. That means U-Boot binary can be flashed into
+``bootloader`` partition (instead of LittleKernel bootloader) and it will just
+work.
+
+Because BL2 bootloader already sets up DRAM and runs the final bootloader
+(U-Boot) from DRAM, there is no need in U-Boot SPL. It's enough to have only
+U-Boot proper (``u-boot.bin``).
+
+Boot Flow
+---------
+
+The boot path for Exynos850 is shown on the figure below.
+
+.. image:: img/exynos850-boot-architecture.svg
+  :alt: Exynos850 SoC boot flow
+
+Legend:
+
+* ``BL0``: Boot ROM code
+* ``BL1``: Software part of Boot ROM
+* ``EPBL``: Exynos Primary Boot Loader
+* ``BL2``: Initializes CMU and DRAM and runs the final bootloader
+* ``Bootloader``: Final bootloader (e.g. U-Boot); also called BL33 in terms of
+  ARM boot flow
+* ``EL3_MON``: EL3 monitor (trusted firmware, handles SMC calls); also called
+  BL31 in terms of ARM boot flow
+* ``LDFW``: Loadable Firmware
+
+Build Procedure
+---------------
+
+.. warning::
+  At the moment both eMMC and USB features are not enabled in U-Boot. Flashing
+  U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
+  be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
+  to unbrick and revive the board. Flashing U-Boot binary might be helpful for
+  developers or anybody who want to check current state of U-Boot enablement on
+  E850-96 (which is mostly serial console and related blocks).
+
+Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
+
+.. prompt:: bash $
+
+  export PATH=<toolchain path>/bin:$PATH
+  export CROSS_COMPILE=<toolchain prefix>
+  make e850-96_defconfig
+  make
+
+Boot E850-96 board into fastboot mode as described in board software doc [9]_,
+and flash U-Boot binary into ``bootloader`` eMMC partition:
+
+.. prompt:: bash $
+
+  fastboot flash bootloader u-boot.bin
+  fastboot reboot
+
+U-Boot will boot up to the shell.
+
+References
+----------
+
+.. [1] https://www.96boards.org/product/e850-96b/
+.. [2] https://www.96boards.org/products/ce/
+.. [3] https://www.96boards.org/products/mezzanine/
+.. [4] https://www.96boards.org/documentation/consumer/e850-96b/hardware-docs/
+.. [5] https://gitlab.com/Linaro/96boards/e850-96/
+.. [6] https://gitlab.com/Linaro/96boards/e850-96/lk
+.. [7] https://gitlab.com/Linaro/96boards/e850-96/images
+.. [8] https://gitlab.com/Linaro/96boards/e850-96/tools/dltool
+.. [9] https://gitlab.com/Linaro/96boards/e850-96/doc
diff --git a/doc/board/samsung/img/exynos850-boot-architecture.svg b/doc/board/samsung/img/exynos850-boot-architecture.svg
new file mode 100644
index 000000000000..c6e850407b4a
--- /dev/null
+++ b/doc/board/samsung/img/exynos850-boot-architecture.svg
@@ -0,0 +1,1283 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Do not edit this file with editors other than draw.io -->
+
+<svg
+   version="1.1"
+   width="611px"
+   height="327px"
+   viewBox="-0.5 -0.5 611 327"
+   content="&lt;mxfile host=&quot;app.diagrams.net&quot; modified=&quot;2023-12-13T00:04:32.824Z&quot; agent=&quot;Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0&quot; etag=&quot;21pvX7xTZUZ4TDUqmo5l&quot; version=&quot;22.1.8&quot; type=&quot;device&quot;&gt;
+  &lt;diagram name=&quot;Page-1&quot; id=&quot;F-97ItDN78I3cBfC3uC2&quot;&gt;
+    &lt;mxGraphModel dx=&quot;987&quot; dy=&quot;663&quot; grid=&quot;1&quot; gridSize=&quot;10&quot; guides=&quot;1&quot; tooltips=&quot;1&quot; connect=&quot;1&quot; arrows=&quot;1&quot; fold=&quot;1&quot; page=&quot;1&quot; pageScale=&quot;1&quot; pageWidth=&quot;850&quot; pageHeight=&quot;1100&quot; math=&quot;0&quot; shadow=&quot;0&quot;&gt;
+      &lt;root&gt;
+        &lt;mxCell id=&quot;0&quot; /&gt;
+        &lt;mxCell id=&quot;1&quot; parent=&quot;0&quot; /&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-47&quot; value=&quot;Secure World&quot; style=&quot;shape=partialRectangle;whiteSpace=wrap;html=1;bottom=0;right=0;fillColor=#f8cecc;fontFamily=Helvetica;fontSize=11;strokeColor=#b85450;verticalAlign=top;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;430&quot; y=&quot;160&quot; width=&quot;140&quot; height=&quot;200&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-48&quot; value=&quot;&quot; style=&quot;shape=partialRectangle;whiteSpace=wrap;html=1;top=0;left=0;fillColor=#f8cecc;fontFamily=Helvetica;fontSize=11;strokeColor=#b85450;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;340&quot; y=&quot;360&quot; width=&quot;230&quot; height=&quot;60&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-49&quot; value=&quot;&quot; style=&quot;shape=partialRectangle;whiteSpace=wrap;html=1;bottom=0;right=0;fillColor=#f8cecc;fontFamily=Helvetica;fontSize=11;strokeColor=#b85450;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;340&quot; y=&quot;340&quot; width=&quot;160&quot; height=&quot;80&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-50&quot; value=&quot;&quot; style=&quot;shape=partialRectangle;whiteSpace=wrap;html=1;top=0;left=0;fillColor=#f8cecc;fontFamily=Helvetica;fontSize=11;rotation=-90;strokeColor=#b85450;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;465.71&quot; y=&quot;255.7&quot; width=&quot;199.53&quot; height=&quot;9.06&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-43&quot; value=&quot;Non-Secure World&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fillColor=#d5e8d4;strokeColor=#82b366;align=center;verticalAlign=top;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;340&quot; y=&quot;160&quot; width=&quot;80&quot; height=&quot;170&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-42&quot; value=&quot;&amp;lt;span style=&amp;quot;white-space: pre;&amp;quot;&amp;gt;&amp;#x9;&amp;lt;/span&amp;gt;Booting Period&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;align=left;verticalAlign=top;fillColor=#dae8fc;strokeColor=#6c8ebf;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;30&quot; y=&quot;270&quot; width=&quot;300&quot; height=&quot;150&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-4&quot; value=&quot;&quot; style=&quot;edgeStyle=none;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-1&quot; target=&quot;azJPLbs4vMiacVWs4TNu-2&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-1&quot; value=&quot;BL0&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;40&quot; y=&quot;360&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-5&quot; value=&quot;&quot; style=&quot;edgeStyle=none;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-2&quot; target=&quot;azJPLbs4vMiacVWs4TNu-3&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-2&quot; value=&quot;BL1&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;100&quot; y=&quot;360&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-9&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0;entryY=0.5;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-3&quot; target=&quot;azJPLbs4vMiacVWs4TNu-6&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;Array as=&quot;points&quot;&gt;
+              &lt;mxPoint x=&quot;180&quot; y=&quot;350&quot; /&gt;
+            &lt;/Array&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-26&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0;entryY=0.5;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-3&quot; target=&quot;azJPLbs4vMiacVWs4TNu-13&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-3&quot; value=&quot;EPBL&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;160&quot; y=&quot;360&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-10&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=1;entryY=0;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;exitX=0.5;exitY=1;exitDx=0;exitDy=0;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-6&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;270&quot; y=&quot;310&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;200&quot; y=&quot;370&quot; as=&quot;targetPoint&quot; /&gt;
+            &lt;Array as=&quot;points&quot;&gt;
+              &lt;mxPoint x=&quot;220&quot; y=&quot;340&quot; /&gt;
+            &lt;/Array&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-12&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0;entryY=0.5;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-6&quot; target=&quot;azJPLbs4vMiacVWs4TNu-11&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-6&quot; value=&quot;BL2&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;200&quot; y=&quot;280&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-16&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0;entryY=0.5;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-11&quot; target=&quot;azJPLbs4vMiacVWs4TNu-14&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-27&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0;entryY=0;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;289.5&quot; y=&quot;320&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;289.5000000000009&quot; y=&quot;360&quot; as=&quot;targetPoint&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-11&quot; value=&quot;Bootloader&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;260&quot; y=&quot;280&quot; width=&quot;60&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-23&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-13&quot; target=&quot;azJPLbs4vMiacVWs4TNu-20&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-24&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-13&quot; target=&quot;azJPLbs4vMiacVWs4TNu-21&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-13&quot; value=&quot;EL3_MON&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;260&quot; y=&quot;360&quot; width=&quot;300&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-17&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-14&quot; target=&quot;azJPLbs4vMiacVWs4TNu-15&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-14&quot; value=&quot;Linux&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;360&quot; y=&quot;280&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-15&quot; value=&quot;&amp;lt;div&amp;gt;Android&amp;lt;/div&amp;gt;&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;360&quot; y=&quot;200&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-19&quot; value=&quot;Secure App&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;440&quot; y=&quot;200&quot; width=&quot;60&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-22&quot; style=&quot;edgeStyle=elbowEdgeStyle;shape=connector;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;entryX=0.5;entryY=1;entryDx=0;entryDy=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;endArrow=classic;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;azJPLbs4vMiacVWs4TNu-20&quot; target=&quot;azJPLbs4vMiacVWs4TNu-19&quot;&gt;
+          &lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-20&quot; value=&quot;Secure OS&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;440&quot; y=&quot;280&quot; width=&quot;60&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-21&quot; value=&quot;LDFW&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fontFamily=Helvetica;fontSize=11;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;520&quot; y=&quot;280&quot; width=&quot;40&quot; height=&quot;40&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-32&quot; value=&quot;&amp;lt;div&amp;gt;iROM&amp;lt;/div&amp;gt;&quot; style=&quot;shape=flexArrow;endArrow=classic;startArrow=classic;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;fillColor=none;endSize=3;width=30;startSize=3;strokeWidth=1;targetPerimeterSpacing=0;sourcePerimeterSpacing=0;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;100&quot; height=&quot;100&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;40&quot; y=&quot;460&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;80&quot; y=&quot;460&quot; as=&quot;targetPoint&quot; /&gt;
+            &lt;Array as=&quot;points&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-33&quot; value=&quot;&amp;lt;div&amp;gt;iRAM&amp;lt;/div&amp;gt;&quot; style=&quot;shape=flexArrow;endArrow=classic;startArrow=classic;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;fillColor=none;endSize=6;width=30;startSize=6;strokeWidth=1;targetPerimeterSpacing=0;sourcePerimeterSpacing=0;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;100&quot; height=&quot;100&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;100&quot; y=&quot;460&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;240&quot; y=&quot;460&quot; as=&quot;targetPoint&quot; /&gt;
+            &lt;Array as=&quot;points&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-34&quot; value=&quot;&amp;lt;div&amp;gt;DRAM&amp;lt;/div&amp;gt;&quot; style=&quot;shape=flexArrow;endArrow=classic;startArrow=classic;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;fillColor=none;endSize=6;width=30;startSize=6;strokeWidth=1;targetPerimeterSpacing=0;sourcePerimeterSpacing=0;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;100&quot; height=&quot;100&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;260&quot; y=&quot;460&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;560&quot; y=&quot;460&quot; as=&quot;targetPoint&quot; /&gt;
+            &lt;Array as=&quot;points&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-35&quot; value=&quot;&quot; style=&quot;endArrow=none;dashed=1;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;shape=connector;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;50&quot; height=&quot;50&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;20&quot; y=&quot;260&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;610&quot; y=&quot;260&quot; as=&quot;targetPoint&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-36&quot; value=&quot;&quot; style=&quot;endArrow=none;dashed=1;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;shape=connector;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;50&quot; height=&quot;50&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;20&quot; y=&quot;340&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;610&quot; y=&quot;340&quot; as=&quot;targetPoint&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-38&quot; value=&quot;&quot; style=&quot;endArrow=none;dashed=1;html=1;rounded=0;labelBackgroundColor=default;strokeColor=default;align=center;verticalAlign=middle;fontFamily=Helvetica;fontSize=11;fontColor=default;shape=connector;&quot; edge=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry width=&quot;50&quot; height=&quot;50&quot; relative=&quot;1&quot; as=&quot;geometry&quot;&gt;
+            &lt;mxPoint x=&quot;20&quot; y=&quot;410&quot; as=&quot;sourcePoint&quot; /&gt;
+            &lt;mxPoint x=&quot;610&quot; y=&quot;410&quot; as=&quot;targetPoint&quot; /&gt;
+          &lt;/mxGeometry&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-39&quot; value=&quot;EL0&quot; style=&quot;text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=11;fontFamily=Helvetica;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;570&quot; y=&quot;205&quot; width=&quot;60&quot; height=&quot;30&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-40&quot; value=&quot;EL1&quot; style=&quot;text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=11;fontFamily=Helvetica;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;570&quot; y=&quot;285&quot; width=&quot;60&quot; height=&quot;30&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+        &lt;mxCell id=&quot;azJPLbs4vMiacVWs4TNu-41&quot; value=&quot;EL3&quot; style=&quot;text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=11;fontFamily=Helvetica;fontColor=default;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;
+          &lt;mxGeometry x=&quot;570&quot; y=&quot;365&quot; width=&quot;60&quot; height=&quot;30&quot; as=&quot;geometry&quot; /&gt;
+        &lt;/mxCell&gt;
+      &lt;/root&gt;
+    &lt;/mxGraphModel&gt;
+  &lt;/diagram&gt;
+&lt;/mxfile&gt;
+"
+   id="svg242"
+   sodipodi:docname="Untitled Diagram.drawio(1).svg"
+   inkscape:version="1.2.2 (b0a8486541, 2022-12-01)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview244"
+     pagecolor="#ffffff"
+     bordercolor="#000000"
+     borderopacity="0.25"
+     inkscape:showpageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     inkscape:deskcolor="#d1d1d1"
+     showgrid="false"
+     inkscape:zoom="1.4211573"
+     inkscape:cx="171.69105"
+     inkscape:cy="123.84273"
+     inkscape:window-width="1916"
+     inkscape:window-height="1053"
+     inkscape:window-x="0"
+     inkscape:window-y="23"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="switch30" />
+  <defs
+     id="defs2" />
+  <g
+     id="g232">
+    <rect
+       x="410"
+       y="0"
+       width="140"
+       height="200"
+       fill="#f8cecc"
+       stroke="none"
+       pointer-events="all"
+       id="rect4" />
+    <path
+       d="M 410 0 L 550 0 M 550 200 M 410 200 L 410 0"
+       fill="none"
+       stroke="#b85450"
+       stroke-linecap="square"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path6" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g12">
+      <switch
+         id="switch10">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 138px; height: 1px; padding-top: 7px; margin-left: 411px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Secure World</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="480"
+           y="18"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text8">Secure World</text>
+      </switch>
+    </g>
+    <rect
+       x="320"
+       y="200"
+       width="230"
+       height="60"
+       fill="#f8cecc"
+       stroke="none"
+       pointer-events="all"
+       id="rect14" />
+    <path
+       d="M 320 200 M 550 200 L 550 260 L 320 260"
+       fill="none"
+       stroke="#b85450"
+       stroke-linecap="square"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path16" />
+    <rect
+       x="320"
+       y="180"
+       width="160"
+       height="80"
+       fill="#f8cecc"
+       stroke="none"
+       pointer-events="all"
+       id="rect18" />
+    <path
+       d="M 320 180 L 480 180 M 480 260 M 320 260 L 320 180"
+       fill="none"
+       stroke="#b85450"
+       stroke-linecap="square"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path20" />
+    <rect
+       x="445.71"
+       y="95.7"
+       width="199.53"
+       height="9.06"
+       fill="#f8cecc"
+       stroke="none"
+       transform="rotate(-90,545.48,100.23)"
+       pointer-events="all"
+       id="rect22" />
+    <path
+       d="M 445.71 95.7 M 645.24 95.7 L 645.24 104.76 L 445.71 104.76"
+       fill="none"
+       stroke="#b85450"
+       stroke-linecap="square"
+       stroke-miterlimit="10"
+       transform="rotate(-90,545.48,100.23)"
+       pointer-events="all"
+       id="path24" />
+    <rect
+       x="320"
+       y="0"
+       width="80"
+       height="170"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect26" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g32">
+      <switch
+         id="switch30">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 78px; height: 1px; padding-top: 7px; margin-left: 321px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Non-Secure World</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="360"
+           y="18"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text28"><tspan
+             sodipodi:role="line"
+             id="tspan629"
+             x="360"
+             y="18">Non-Secure</tspan><tspan
+             sodipodi:role="line"
+             id="tspan631"
+             x="360"
+             y="31.75">World</tspan></text>
+      </switch>
+    </g>
+    <rect
+       x="10"
+       y="110"
+       width="300"
+       height="150"
+       fill="#dae8fc"
+       stroke="#6c8ebf"
+       pointer-events="all"
+       id="rect34" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g40">
+      <switch
+         id="switch38">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe flex-start; width: 298px; height: 1px; padding-top: 117px; margin-left: 12px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: left;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;"><xhtml:span
+   style="white-space: pre;" />
+Booting Period</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="12"
+           y="128"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           id="text36">	Booting Period</text>
+      </switch>
+    </g>
+    <path
+       d="M 60 220 L 73.63 220"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path42" />
+    <path
+       d="M 78.88 220 L 71.88 223.5 L 73.63 220 L 71.88 216.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path44" />
+    <rect
+       x="20"
+       y="200"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect46" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g52">
+      <switch
+         id="switch50">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 220px; margin-left: 21px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">BL0</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="40"
+           y="224"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text48">BL0</text>
+      </switch>
+    </g>
+    <path
+       d="M 120 220 L 133.63 220"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path54" />
+    <path
+       d="M 138.88 220 L 131.88 223.5 L 133.63 220 L 131.88 216.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path56" />
+    <rect
+       x="80"
+       y="200"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect58" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g64">
+      <switch
+         id="switch62">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 220px; margin-left: 81px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">BL1</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="100"
+           y="224"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text60">BL1</text>
+      </switch>
+    </g>
+    <path
+       d="M 160 200 L 160 140 L 173.63 140"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path66" />
+    <path
+       d="M 178.88 140 L 171.88 143.5 L 173.63 140 L 171.88 136.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path68" />
+    <path
+       d="M 180 220 L 209.67 220 L 233.63 220"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path70" />
+    <path
+       d="M 238.88 220 L 231.88 223.5 L 233.63 220 L 231.88 216.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path72" />
+    <rect
+       x="140"
+       y="200"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect74" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g80">
+      <switch
+         id="switch78">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 220px; margin-left: 141px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">EPBL</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="160"
+           y="224"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text76">EPBL</text>
+      </switch>
+    </g>
+    <path
+       d="M 200 160 L 200 210 L 186.37 210"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path82" />
+    <path
+       d="M 181.12 210 L 188.12 206.5 L 186.37 210 L 188.12 213.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path84" />
+    <path
+       d="M 220 140 L 229.67 140 L 233.63 140"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path86" />
+    <path
+       d="M 238.88 140 L 231.88 143.5 L 233.63 140 L 231.88 136.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path88" />
+    <rect
+       x="180"
+       y="120"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect90" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g96">
+      <switch
+         id="switch94">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 140px; margin-left: 181px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">BL2</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="200"
+           y="144"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text92">BL2</text>
+      </switch>
+    </g>
+    <path
+       d="M 300 140 L 319.67 140 L 333.63 140"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path98" />
+    <path
+       d="M 338.88 140 L 331.88 143.5 L 333.63 140 L 331.88 136.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path100" />
+    <path
+       d="M 269.5 160 L 269.64 193.63"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path102" />
+    <path
+       d="M 269.66 198.88 L 266.13 191.9 L 269.64 193.63 L 273.13 191.87 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path104" />
+    <rect
+       x="240"
+       y="120"
+       width="60"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect106" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g112">
+      <switch
+         id="switch110">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 140px; margin-left: 241px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Bootloader</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="270"
+           y="143"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text108">Bootloader</text>
+      </switch>
+    </g>
+    <path
+       d="M 449.67 200 L 449.67 166.37"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path114" />
+    <path
+       d="M 449.67 161.12 L 453.17 168.12 L 449.67 166.37 L 446.17 168.12 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path116" />
+    <path
+       d="M 519.67 200 L 519.67 166.37"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path118" />
+    <path
+       d="M 519.67 161.12 L 523.17 168.12 L 519.67 166.37 L 516.17 168.12 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path120" />
+    <rect
+       x="240"
+       y="200"
+       width="300"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect122" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g128">
+      <switch
+         id="switch126">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 298px; height: 1px; padding-top: 220px; margin-left: 241px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">EL3_MON</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="390"
+           y="223"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text124">EL3_MON</text>
+      </switch>
+    </g>
+    <path
+       d="M 359.67 120 L 359.67 86.37"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path130" />
+    <path
+       d="M 359.67 81.12 L 363.17 88.12 L 359.67 86.37 L 356.17 88.12 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path132" />
+    <rect
+       x="340"
+       y="120"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect134" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g140">
+      <switch
+         id="switch138">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 140px; margin-left: 341px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Linux</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="360"
+           y="143"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text136">Linux</text>
+      </switch>
+    </g>
+    <rect
+       x="340"
+       y="40"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect142" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g148">
+      <switch
+         id="switch146">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 60px; margin-left: 341px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                <xhtml:div>Android</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="360"
+           y="63"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text144">Android</text>
+      </switch>
+    </g>
+    <rect
+       x="420"
+       y="40"
+       width="60"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect150" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g156">
+      <switch
+         id="switch154">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 60px; margin-left: 421px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Secure App</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="450"
+           y="63"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text152">Secure App</text>
+      </switch>
+    </g>
+    <path
+       d="M 449.67 120 L 449.67 86.37"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path158" />
+    <path
+       d="M 449.67 81.12 L 453.17 88.12 L 449.67 86.37 L 446.17 88.12 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path160" />
+    <rect
+       x="420"
+       y="120"
+       width="60"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect162" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g168">
+      <switch
+         id="switch166">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 140px; margin-left: 421px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Secure OS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="450"
+           y="143"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text164">Secure OS</text>
+      </switch>
+    </g>
+    <rect
+       x="500"
+       y="120"
+       width="40"
+       height="40"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect170" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g176">
+      <switch
+         id="switch174">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 38px; height: 1px; padding-top: 140px; margin-left: 501px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">LDFW</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="520"
+           y="143"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text172">LDFW</text>
+      </switch>
+    </g>
+    <path
+       d="M 30.5 315 L 30.5 325.5 L 20.5 300 L 30.5 274.5 L 30.5 285 L 49.5 285 L 49.5 274.5 L 59.5 300 L 49.5 325.5 L 49.5 315 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path178" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g184">
+      <switch
+         id="switch182">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 300px; margin-left: 40px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">
+                <xhtml:div>iROM</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="40"
+           y="303"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text180">iROM</text>
+      </switch>
+    </g>
+    <path
+       d="M 99.5 315 L 99.5 325.5 L 80.5 300 L 99.5 274.5 L 99.5 285 L 200.5 285 L 200.5 274.5 L 219.5 300 L 200.5 325.5 L 200.5 315 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path186" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g192">
+      <switch
+         id="switch190">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 300px; margin-left: 150px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">
+                <xhtml:div>iRAM</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="150"
+           y="303"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text188">iRAM</text>
+      </switch>
+    </g>
+    <path
+       d="M 259.5 315 L 259.5 325.5 L 240.5 300 L 259.5 274.5 L 259.5 285 L 520.5 285 L 520.5 274.5 L 539.5 300 L 520.5 325.5 L 520.5 315 Z"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path194" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g200">
+      <switch
+         id="switch198">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 300px; margin-left: 390px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">
+                <xhtml:div>DRAM</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="390"
+           y="303"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text196">DRAM</text>
+      </switch>
+    </g>
+    <path
+       d="M 0 100 L 590 100"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="stroke"
+       id="path202" />
+    <path
+       d="M 0 180 L 590 180"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="stroke"
+       id="path204" />
+    <path
+       d="M 0 250 L 590 250"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="stroke"
+       id="path206" />
+    <rect
+       x="550"
+       y="45"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect208" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g214">
+      <switch
+         id="switch212">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 60px; margin-left: 551px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">EL0</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="580"
+           y="63"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text210">EL0</text>
+      </switch>
+    </g>
+    <rect
+       x="550"
+       y="125"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect216" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g222">
+      <switch
+         id="switch220">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 140px; margin-left: 551px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">EL1</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="580"
+           y="143"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text218">EL1</text>
+      </switch>
+    </g>
+    <rect
+       x="550"
+       y="205"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect224" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g230">
+      <switch
+         id="switch228">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 220px; margin-left: 551px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">EL3</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="580"
+           y="223"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text226">EL3</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch240">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g234" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a238">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text236">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
index 971805e20169..a1c9636b0507 100644
--- a/doc/board/samsung/index.rst
+++ b/doc/board/samsung/index.rst
@@ -7,3 +7,4 @@ Samsung
    :maxdepth: 2
 
    axy17lte
+   e850-96
diff --git a/include/configs/e850-96.h b/include/configs/e850-96.h
new file mode 100644
index 000000000000..4607b3089b21
--- /dev/null
+++ b/include/configs/e850-96.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2020, Linaro Limited
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Configuration for E850-96 board.
+ */
+
+#ifndef __E850_96_H
+#define __E850_96_H
+
+#endif /* __E850_96_H */
-- 
2.39.2

