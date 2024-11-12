Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07959D42B80
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D025989446;
	Tue, 12 Nov 2024 14:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="LkTkhbeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D7089446; Tue, 12 Nov 2024 13:59:03 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02526893C3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 13:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 950B3120009;
 Tue, 12 Nov 2024 15:58:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 950B3120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1731416335;
 bh=M1/27UQFJYX2mv1LdPJCpITY8WG5YKsuw+fpAC4aIkk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LkTkhbeIuG+4PPWSEp7VZWwDLwzSUsTlgfoJZdVeqekr9DG2OjwUfPB1QRr10EyKU
 hctJ7El5kiB8zd8mQ0KbXVaDPzz8835CuB+xfvIcViQAOtoWJ8Y9kFJbmD537dzUl+
 D8AQWxH6vkKtS5oCqe/i5VJFiI0j3KqqopZfqngKK/UfEd048fUqEqtwO4G8IXw1kl
 Z3coeHGooAUg7lpbze2omG/Uevdu1uNaXShSaDpwbCni/LHFLHnQu/FyctnJBJj3CJ
 p/bhxVxzwBMuHDlgWJcJ2mr8q8+CzumeZ7osVtBPvzEE1K3591MtMgSTi1OPjROmTB
 OfVyAJIGlwdYw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 12 Nov 2024 15:58:55 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 1/4] arm: dts: meson: remove meson-a1.dtsi
Date: Tue, 12 Nov 2024 15:58:33 +0300
Message-ID: <20241112125836.3239832-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.130.77]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189115 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41
 623e98d5198769c015c72f45fabbb9f77bdb702b,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/11/12 09:54:00 #26847665
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 12 Nov 2024 14:41:49 +0100
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

For Amlogic A1, we have to use dtsi from dts/upstream folder.
The only difference between this two files is the added cpu temperature
node definition in upstream version and additional assigned-clock for
USB. This patch is tested on a device with A113L SoC (AD401-like) and
everything is okay.

So, we can remove legacy arch/arm/dts/meson-a1.dtsi file.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/dts/meson-a1.dtsi | 518 -------------------------------------
 1 file changed, 518 deletions(-)
 delete mode 100644 arch/arm/dts/meson-a1.dtsi

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
deleted file mode 100644
index 648e7f4942..0000000000
--- a/arch/arm/dts/meson-a1.dtsi
+++ /dev/null
@@ -1,518 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- */
-
-#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
-#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
-#include <dt-bindings/gpio/meson-a1-gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/power/meson-a1-power.h>
-#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
-
-/ {
-	compatible = "amlogic,a1";
-
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x1>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-		};
-
-		l2: l2-cache0 {
-			compatible = "cache";
-			cache-level = <2>;
-			cache-unified;
-		};
-	};
-
-	efuse: efuse {
-		compatible = "amlogic,meson-gxbb-efuse";
-		clocks = <&clkc_periphs CLKID_OTP>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		secure-monitor = <&sm>;
-		power-domains = <&pwrc PWRC_OTP_ID>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		linux,cma {
-			compatible = "shared-dma-pool";
-			reusable;
-			size = <0x0 0x800000>;
-			alignment = <0x0 0x400000>;
-			linux,cma-default;
-		};
-	};
-
-	sm: secure-monitor {
-		compatible = "amlogic,meson-gxbb-sm";
-
-		pwrc: power-controller {
-			compatible = "amlogic,meson-a1-pwrc";
-			#power-domain-cells = <1>;
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		spifc: spi@fd000400 {
-			compatible = "amlogic,a1-spifc";
-			reg = <0x0 0xfd000400 0x0 0x290>;
-			clocks = <&clkc_periphs CLKID_SPIFC>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			power-domains = <&pwrc PWRC_SPIFC_ID>;
-			status = "disabled";
-		};
-
-		apb: bus@fe000000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xfe000000 0x0 0x1000000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
-
-			reset: reset-controller@0 {
-				compatible = "amlogic,meson-a1-reset";
-				reg = <0x0 0x0 0x0 0x8c>;
-				#reset-cells = <1>;
-			};
-
-			periphs_pinctrl: pinctrl@400 {
-				compatible = "amlogic,meson-a1-periphs-pinctrl";
-				#address-cells = <2>;
-				#size-cells = <2>;
-				ranges;
-
-				gpio: bank@400 {
-					reg = <0x0 0x0400 0x0 0x003c>,
-					      <0x0 0x0480 0x0 0x0118>;
-					reg-names = "mux", "gpio";
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&periphs_pinctrl 0 0 62>;
-				};
-
-				i2c0_f11_pins: i2c0-f11 {
-					mux {
-						groups = "i2c0_sck_f11",
-							 "i2c0_sda_f12";
-						function = "i2c0";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c0_f9_pins: i2c0-f9 {
-					mux {
-						groups = "i2c0_sck_f9",
-							 "i2c0_sda_f10";
-						function = "i2c0";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c1_x_pins: i2c1-x {
-					mux {
-						groups = "i2c1_sck_x",
-							 "i2c1_sda_x";
-						function = "i2c1";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c1_a_pins: i2c1-a {
-					mux {
-						groups = "i2c1_sck_a",
-							 "i2c1_sda_a";
-						function = "i2c1";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c2_x0_pins: i2c2-x0 {
-					mux {
-						groups = "i2c2_sck_x0",
-							 "i2c2_sda_x1";
-						function = "i2c2";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c2_x15_pins: i2c2-x15 {
-					mux {
-						groups = "i2c2_sck_x15",
-							 "i2c2_sda_x16";
-						function = "i2c2";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c2_a4_pins: i2c2-a4 {
-					mux {
-						groups = "i2c2_sck_a4",
-							 "i2c2_sda_a5";
-						function = "i2c2";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c2_a8_pins: i2c2-a8 {
-					mux {
-						groups = "i2c2_sck_a8",
-							 "i2c2_sda_a9";
-						function = "i2c2";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c3_x_pins: i2c3-x {
-					mux {
-						groups = "i2c3_sck_x",
-							 "i2c3_sda_x";
-						function = "i2c3";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				i2c3_f_pins: i2c3-f {
-					mux {
-						groups = "i2c3_sck_f",
-							 "i2c3_sda_f";
-						function = "i2c3";
-						bias-pull-up;
-						drive-strength-microamp = <3000>;
-					};
-				};
-
-				uart_a_pins: uart-a {
-					mux {
-						groups = "uart_a_tx",
-							 "uart_a_rx";
-						function = "uart_a";
-					};
-				};
-
-				uart_a_cts_rts_pins: uart-a-cts-rts {
-					mux {
-						groups = "uart_a_cts",
-							 "uart_a_rts";
-						function = "uart_a";
-						bias-pull-down;
-					};
-				};
-
-				sdio_pins: sdio {
-					mux0 {
-						groups = "sdcard_d0_x",
-							 "sdcard_d1_x",
-							 "sdcard_d2_x",
-							 "sdcard_d3_x",
-							 "sdcard_cmd_x";
-						function = "sdcard";
-						bias-pull-up;
-					};
-
-					mux1 {
-						groups = "sdcard_clk_x";
-						function = "sdcard";
-						bias-disable;
-					};
-				};
-
-				sdio_clk_gate_pins: sdio-clk-gate {
-					mux {
-						groups = "sdcard_clk_x";
-						function = "sdcard";
-						bias-pull-down;
-					};
-				};
-
-				spifc_pins: spifc {
-					mux {
-						groups = "spif_mo",
-							 "spif_mi",
-							 "spif_clk",
-							 "spif_cs",
-							 "spif_hold_n",
-							 "spif_wp_n";
-						function = "spif";
-					};
-				};
-			};
-
-			gpio_intc: interrupt-controller@440 {
-				compatible = "amlogic,meson-a1-gpio-intc",
-					     "amlogic,meson-gpio-intc";
-				reg = <0x0 0x0440 0x0 0x14>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				amlogic,channel-interrupts =
-					<49 50 51 52 53 54 55 56>;
-			};
-
-			clkc_periphs: clock-controller@800 {
-				compatible = "amlogic,a1-peripherals-clkc";
-				reg = <0 0x800 0 0x104>;
-				#clock-cells = <1>;
-				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
-					 <&clkc_pll CLKID_FCLK_DIV3>,
-					 <&clkc_pll CLKID_FCLK_DIV5>,
-					 <&clkc_pll CLKID_FCLK_DIV7>,
-					 <&clkc_pll CLKID_HIFI_PLL>,
-					 <&xtal>;
-				clock-names = "fclk_div2", "fclk_div3",
-					      "fclk_div5", "fclk_div7",
-					      "hifi_pll", "xtal";
-			};
-
-			i2c0: i2c@1400 {
-				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
-				reg = <0x0 0x1400 0x0 0x20>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&clkc_periphs CLKID_I2C_M_A>;
-				power-domains = <&pwrc PWRC_I2C_ID>;
-			};
-
-			uart_AO: serial@1c00 {
-				compatible = "amlogic,meson-a1-uart",
-					     "amlogic,meson-ao-uart";
-				reg = <0x0 0x1c00 0x0 0x18>;
-				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-				status = "disabled";
-			};
-
-			uart_AO_B: serial@2000 {
-				compatible = "amlogic,meson-a1-uart",
-					     "amlogic,meson-ao-uart";
-				reg = <0x0 0x2000 0x0 0x18>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-				status = "disabled";
-			};
-
-			saradc: adc@2c00 {
-				compatible = "amlogic,meson-g12a-saradc",
-					"amlogic,meson-saradc";
-				reg = <0x0 0x2c00 0x0 0x48>;
-				#io-channel-cells = <1>;
-				power-domains = <&pwrc PWRC_I2C_ID>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>,
-					<&clkc_periphs CLKID_SARADC_EN>,
-					<&clkc_periphs CLKID_SARADC>,
-					<&clkc_periphs CLKID_SARADC_SEL>;
-				clock-names = "clkin", "core",
-					"adc_clk", "adc_sel";
-				status = "disabled";
-			};
-
-			i2c1: i2c@5c00 {
-				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
-				reg = <0x0 0x5c00 0x0 0x20>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&clkc_periphs CLKID_I2C_M_B>;
-				power-domains = <&pwrc PWRC_I2C_ID>;
-			};
-
-			i2c2: i2c@6800 {
-				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
-				reg = <0x0 0x6800 0x0 0x20>;
-				interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&clkc_periphs CLKID_I2C_M_C>;
-				power-domains = <&pwrc PWRC_I2C_ID>;
-			};
-
-			i2c3: i2c@6c00 {
-				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
-				reg = <0x0 0x6c00 0x0 0x20>;
-				interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&clkc_periphs CLKID_I2C_M_D>;
-				power-domains = <&pwrc PWRC_I2C_ID>;
-			};
-
-			usb2_phy1: phy@4000 {
-				compatible = "amlogic,a1-usb2-phy";
-				clocks = <&clkc_periphs CLKID_USB_PHY_IN>;
-				clock-names = "xtal";
-				reg = <0x0 0x4000 0x0 0x60>;
-				resets = <&reset RESET_USBPHY>;
-				reset-names = "phy";
-				#phy-cells = <0>;
-				power-domains = <&pwrc PWRC_USB_ID>;
-			};
-
-			hwrng: rng@5118 {
-				compatible = "amlogic,meson-rng";
-				reg = <0x0 0x5118 0x0 0x4>;
-				power-domains = <&pwrc PWRC_OTP_ID>;
-			};
-
-			sec_AO: ao-secure@5a20 {
-				compatible = "amlogic,meson-gx-ao-secure", "syscon";
-				reg = <0x0 0x5a20 0x0 0x140>;
-				amlogic,has-chip-id;
-			};
-
-			clkc_pll: pll-clock-controller@7c80 {
-				compatible = "amlogic,a1-pll-clkc";
-				reg = <0 0x7c80 0 0x18c>;
-				#clock-cells = <1>;
-				clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
-					 <&clkc_periphs CLKID_HIFIPLL_IN>;
-				clock-names = "fixpll_in", "hifipll_in";
-			};
-
-			sd_emmc: sd@10000 {
-				compatible = "amlogic,meson-axg-mmc";
-				reg = <0x0 0x10000 0x0 0x800>;
-				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clkc_periphs CLKID_SD_EMMC_A>,
-					 <&clkc_periphs CLKID_SD_EMMC>,
-					 <&clkc_pll CLKID_FCLK_DIV2>;
-				clock-names = "core",
-					      "clkin0",
-					      "clkin1";
-				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_SEL2>;
-				assigned-clock-parents = <&xtal>;
-				resets = <&reset RESET_SD_EMMC_A>;
-				power-domains = <&pwrc PWRC_SD_EMMC_ID>;
-				status = "disabled";
-			};
-		};
-
-		usb: usb@fe004400 {
-			status = "disabled";
-			compatible = "amlogic,meson-a1-usb-ctrl";
-			reg = <0x0 0xfe004400 0x0 0xa0>;
-			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			clocks = <&clkc_periphs CLKID_USB_CTRL>,
-				 <&clkc_periphs CLKID_USB_BUS>,
-				 <&clkc_periphs CLKID_USB_CTRL_IN>;
-			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
-			resets = <&reset RESET_USBCTRL>;
-			reset-name = "usb_ctrl";
-
-			dr_mode = "otg";
-
-			phys = <&usb2_phy1>;
-			phy-names = "usb2-phy1";
-
-			dwc3: usb@ff400000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xff400000 0x0 0x100000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode = "host";
-				snps,dis_u2_susphy_quirk;
-				snps,quirk-frame-length-adjustment = <0x20>;
-				snps,parkmode-disable-ss-quirk;
-			};
-
-			dwc2: usb@ff500000 {
-				compatible = "amlogic,meson-a1-usb", "snps,dwc2";
-				reg = <0x0 0xff500000 0x0 0x40000>;
-				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb2_phy1>;
-				phy-names = "usb2-phy";
-				clocks = <&clkc_periphs CLKID_USB_PHY>;
-				clock-names = "otg";
-				dr_mode = "peripheral";
-				g-rx-fifo-size = <192>;
-				g-np-tx-fifo-size = <128>;
-				g-tx-fifo-size = <128 128 16 16 16>;
-			};
-		};
-
-		gic: interrupt-controller@ff901000 {
-			compatible = "arm,gic-400";
-			reg = <0x0 0xff901000 0x0 0x1000>,
-			      <0x0 0xff902000 0x0 0x2000>,
-			      <0x0 0xff904000 0x0 0x2000>,
-			      <0x0 0xff906000 0x0 0x2000>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	xtal: xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xtal";
-		#clock-cells = <0>;
-	};
-};
-- 
2.34.1

