Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65150D0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD0084101;
	Tue, 25 Nov 2025 18:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NdFrlbJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2561B8410C; Tue, 25 Nov 2025 18:36:42 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3B484088
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-656b0bd47b8so1059176eaf.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764092197; x=1764696997;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uopdq74t1NWXPT3TXQa22R2F4nTAidBcqn7O0j5DLbs=;
 b=NdFrlbJeV8wQcs0lzZvXCd9zvU+ObhsyL7UfL0prZizxgqyntexEx8y2TUacXqJV62
 sUf9A3/8Ht3Dm2Cpbny3Q7FNeOpfFW7thibLW1PUB10Ms7uhnqFX9yZbF86AXiycFqUs
 2xon/gmJ4N5ePJjxFaA4MZN/t2ygWKKu1XpgoSJgFofoRvhGg+tkrCyT7zi6OXYY8Odm
 Q5qcnCBA6svuyngeFxisN6z2ojiTXd/YtZ0IXiaMm4rXqa3sGqX1pmPMJiO8wXp/yyWK
 oCZoVi2ql1B+JAObkPBt0af06GfEIBrPcpO8BUSpEntzwNn4w+wVjsDLaMGlQ7U7MkBh
 o8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764092197; x=1764696997;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uopdq74t1NWXPT3TXQa22R2F4nTAidBcqn7O0j5DLbs=;
 b=ebZs7LQIgpRKghPk6bFJauUHSFOtg4I9x5nwgIeLH5TG7lUWpdZslsBwVObduOAvbq
 8qHnS7l6wS/n6jQJ9n16aLwD6NeGe7VTBySFMGMmazZ2R52uN9Hgm0LLOjsIwFtoqyWY
 QIuYdpl8W36pkZMAKifRV81Ehb1M1WasWoH58Qu9qU1cfxGb0z51Cr5povfDtY82Xha0
 A7Gr5Hrw1sPec479SznQeYJgDUmX+CE1rQPhfbeuy6Ihrw5t5nQwlac2zaPKw9C93r0n
 ob6nFIHxB66TCzzTV+mFxxfTbQefo3nQD4sokOER3XBaFWMwYiv9R8yPJ2PXSTOcfQU1
 SV6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMc8xfXEEBHmq+gZe5FG1LgXPlqckFoJnKKRg7Al/r5P+M5duVrYa13aAdirVYSqlzsil/6AU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi+/keZaacL7VncMLW53hqVNXKa0cLTQP19d/v5MeECcmNlg5C
 Z/poeXZ8zB/kWxXcZ8DwQ+Ju2F7rR6C/aZq9ztRoIqJ/02RcO/6lmcmX/R0og+jaXiA=
X-Gm-Gg: ASbGncvhRhmMLG0MMe9fTVGhtXqcl4OVsMeLA0iammmkP1+2nfA4GAJ6tVOIcB8Iu57
 SL9G+i5L0FZnlsMLuDOEoASmlBdBEOxb3qbxw37Om9nLBX5kNm8J7aoC4b9MRMJGF7E+38FFh4u
 5IA1Gr1sTrOWPJzM17/CA+1LN4rWA4VoPdSfAXwnTQWj57FkpFuW3h35/vIYvuzPzf/21FPJlPE
 Xe9b++s4CIVHNyqmvQBZ8jYHmJcjtCoPRZUfk46okNoAHaz8JD2LWhCkqv6NaedenhMH1aOrhyQ
 I24Tc7JW6g0Poc5FQ1q+ai4QtvcA1zhTaR8UyE8zK+bRwzhaeUXRj6BQ6Lcq0wlf7KOX+a+knbJ
 mj4fT9Rv6GEMCWPQBJdq3Uee/5soXQZ7tCM3pB5IYVIAodDib77o+vYWKw/7CGGudEETd+ZIIN0
 U=
X-Google-Smtp-Source: AGHT+IGB5W1LEZQrQ0WXEk1Ilxh1fVmHNx8jQX5xeKNtGPU85q7YAAp0k1gWUkPhEcV6QB70yM3Wog==
X-Received: by 2002:a05:6830:67a1:b0:758:5a29:cba0 with SMTP id
 46e09a7af769-7c7990ae795mr6959006a34.33.1764092196717; 
 Tue, 25 Nov 2025 09:36:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a359efsm4345747eaf.4.2025.11.25.09.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 09:36:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 25 Nov 2025 11:35:51 -0600
Subject: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPboJWkC/x3NTQrCMBBA4auUWTvQRFuiVxGRNJnYQdKUzPgDp
 Xc3uPw2720gVJkELt0Gld4sXJYGc+ggzH55EHJsBtvbwRh7Ql8zRhXMFNkrPVE+rGHGrO44Dqg
 FS7q/VtFKPuN4noLtTXBTctCaa6XE3//vetv3H0s/RQF/AAAA
X-Change-ID: 20251124-arm-dts-mediatek-switch-mt8365-to-of_upstream-69bc201c8bf8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=49877;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Z8ddwYfZ6dicga9XZm1Z2gooI5qOA7or7kenjGojmQs=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpJekcOGOcF3hUP4I/aQHNjNDShcRn6BbIbO5MT
 9V0lffpRs6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSXpHBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWAEH/R0p4GMbokD3hOSDyhdigX2ekE3LdwbDLX+p2TJ
 j/9JoDgde3DQkGONYdy6jPiPt6DJeKP4sn+QoHSmfecBVGA5f9oLNoLAW4C9F+5mE5x0ABr+Bsp
 1jbP5vCqiJbmOX6DT4M+MDl/30k69mLJinMWlypJZaAvYMWk9rgwBds4leNat8HwJMS+cb4fxWo
 lxUDsTVJTSpC7FuIQBExGXuXObXlFSqSxxZqP30mUrP00kktHIOiBrPHIoXlxP71+nC7cDnH0H/
 ttF/gAZrDsVADRFok866ytdUp3m9oAX0deaSJIcW+ew0HkY4eeIGm47cfY4abrYzXzaXPWmytS+
 O41A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 25 Nov 2025 18:52:21 +0100
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

Change mt8365_evk_defconfig to use CONFIG_OF_UPSTREAM=y and delete the
U-Boot copy of the devicetree source files for mt8365.

The upstream devicetree is identical to the U-Boot one being removed
(other than having more nodes for devices not used by U-Boot and
upstream fixed a compatible string in &scpsys, also not affecting
U-Boot).

There was one minor glitch with upstream missing a few topckgen macro
definitions, so those are added to the clock driver directly as a
workaround.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8365-evk.dts                     | 418 ------------
 arch/arm/dts/mt8365.dtsi                        | 840 ------------------------
 board/mediatek/mt8365_evk/MAINTAINERS           |   1 -
 configs/mt8365_evk_defconfig                    |   3 +-
 drivers/clk/mediatek/clk-mt8365.c               |   4 +
 include/dt-bindings/clock/mediatek,mt8365-clk.h | 375 -----------
 6 files changed, 6 insertions(+), 1635 deletions(-)

diff --git a/arch/arm/dts/mt8365-evk.dts b/arch/arm/dts/mt8365-evk.dts
deleted file mode 100644
index 50cbaefa1a9936c6ff6c3bb7ccb94e7326d4f7a1..0000000000000000000000000000000000000000
--- a/arch/arm/dts/mt8365-evk.dts
+++ /dev/null
@@ -1,418 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2021-2022 BayLibre, SAS.
- * Authors:
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
-#include "mt8365.dtsi"
-#include "mt6357.dtsi"
-
-/ {
-	model = "MediaTek MT8365 Open Platform EVK";
-	compatible = "mediatek,mt8365-evk", "mediatek,mt8365";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:921600n8";
-	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys>;
-
-		key-volume-up {
-			gpios = <&pio 24 GPIO_ACTIVE_LOW>;
-			label = "volume_up";
-			linux,code = <KEY_VOLUMEUP>;
-			wakeup-source;
-			debounce-interval = <15>;
-		};
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0 0x40000000 0 0xc0000000>;
-	};
-
-	usb_otg_vbus: regulator-0 {
-		compatible = "regulator-fixed";
-		regulator-name = "otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
-		bl31_secmon_reserved: secmon@43000000 {
-			no-map;
-			reg = <0 0x43000000 0 0x30000>;
-		};
-
-		/* 12 MiB reserved for OP-TEE (BL32)
-		 * +-----------------------+ 0x43e0_0000
-		 * |      SHMEM 2MiB       |
-		 * +-----------------------+ 0x43c0_0000
-		 * |        | TA_RAM  8MiB |
-		 * + TZDRAM +--------------+ 0x4340_0000
-		 * |        | TEE_RAM 2MiB |
-		 * +-----------------------+ 0x4320_0000
-		 */
-		optee_reserved: optee@43200000 {
-			no-map;
-			reg = <0 0x43200000 0 0x00c00000>;
-		};
-	};
-};
-
-&cpu0 {
-	proc-supply = <&mt6357_vproc_reg>;
-	sram-supply = <&mt6357_vsram_proc_reg>;
-};
-
-&cpu1 {
-	proc-supply = <&mt6357_vproc_reg>;
-	sram-supply = <&mt6357_vsram_proc_reg>;
-};
-
-&cpu2 {
-	proc-supply = <&mt6357_vproc_reg>;
-	sram-supply = <&mt6357_vsram_proc_reg>;
-};
-
-&cpu3 {
-	proc-supply = <&mt6357_vproc_reg>;
-	sram-supply = <&mt6357_vsram_proc_reg>;
-};
-
-&ethernet {
-	pinctrl-0 = <&ethernet_pins>;
-	pinctrl-names = "default";
-	phy-handle = <&eth_phy>;
-	phy-mode = "rmii";
-	/*
-	 * Ethernet and HDMI (DSI0) are sharing pins.
-	 * Only one can be enabled at a time and require the physical switch
-	 * SW2101 to be set on LAN position
-	 * mt6357_vibr_reg and mt6357_vsim2_reg are needed to supply ethernet
-	 */
-	status = "disabled";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		eth_phy: ethernet-phy@0 {
-			reg = <0>;
-		};
-	};
-};
-
-&i2c0 {
-	clock-frequency = <100000>;
-	pinctrl-0 = <&i2c0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&mmc0 {
-	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
-	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	cap-mmc-hw-reset;
-	hs400-ds-delay = <0x12012>;
-	max-frequency = <200000000>;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	no-sd;
-	no-sdio;
-	non-removable;
-	pinctrl-0 = <&mmc0_default_pins>;
-	pinctrl-1 = <&mmc0_uhs_pins>;
-	pinctrl-names = "default", "state_uhs";
-	vmmc-supply = <&mt6357_vemc_reg>;
-	vqmmc-supply = <&mt6357_vio18_reg>;
-	status = "okay";
-};
-
-&mmc1 {
-	bus-width = <4>;
-	cap-sd-highspeed;
-	cd-gpios = <&pio 76 GPIO_ACTIVE_LOW>;
-	max-frequency = <200000000>;
-	pinctrl-0 = <&mmc1_default_pins>;
-	pinctrl-1 = <&mmc1_uhs_pins>;
-	pinctrl-names = "default", "state_uhs";
-	sd-uhs-sdr104;
-	sd-uhs-sdr50;
-	vmmc-supply = <&mt6357_vmch_reg>;
-	vqmmc-supply = <&mt6357_vmc_reg>;
-	status = "okay";
-};
-
-&mt6357_pmic {
-	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-};
-
-&pio {
-	ethernet_pins: ethernet-pins {
-		phy_reset_pins {
-			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
-		};
-
-		rmii_pins {
-			pinmux = <MT8365_PIN_0_GPIO0__FUNC_EXT_TXD0>,
-				 <MT8365_PIN_1_GPIO1__FUNC_EXT_TXD1>,
-				 <MT8365_PIN_2_GPIO2__FUNC_EXT_TXD2>,
-				 <MT8365_PIN_3_GPIO3__FUNC_EXT_TXD3>,
-				 <MT8365_PIN_4_GPIO4__FUNC_EXT_TXC>,
-				 <MT8365_PIN_5_GPIO5__FUNC_EXT_RXER>,
-				 <MT8365_PIN_6_GPIO6__FUNC_EXT_RXC>,
-				 <MT8365_PIN_7_GPIO7__FUNC_EXT_RXDV>,
-				 <MT8365_PIN_8_GPIO8__FUNC_EXT_RXD0>,
-				 <MT8365_PIN_9_GPIO9__FUNC_EXT_RXD1>,
-				 <MT8365_PIN_10_GPIO10__FUNC_EXT_RXD2>,
-				 <MT8365_PIN_11_GPIO11__FUNC_EXT_RXD3>,
-				 <MT8365_PIN_12_GPIO12__FUNC_EXT_TXEN>,
-				 <MT8365_PIN_13_GPIO13__FUNC_EXT_COL>,
-				 <MT8365_PIN_14_GPIO14__FUNC_EXT_MDIO>,
-				 <MT8365_PIN_15_GPIO15__FUNC_EXT_MDC>;
-		};
-	};
-
-	gpio_keys: gpio-keys-pins {
-		pins {
-			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
-			bias-pull-up;
-			input-enable;
-		};
-	};
-
-	i2c0_pins: i2c0-pins {
-		pins {
-			pinmux = <MT8365_PIN_57_SDA0__FUNC_SDA0_0>,
-				 <MT8365_PIN_58_SCL0__FUNC_SCL0_0>;
-			bias-pull-up;
-		};
-	};
-
-	mmc0_default_pins: mmc0-default-pins {
-		clk-pins {
-			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
-			bias-pull-down;
-		};
-
-		cmd-dat-pins {
-			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
-				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
-				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
-				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
-				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
-				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
-				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
-				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
-				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		rst-pins {
-			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
-			bias-pull-up;
-		};
-	};
-
-	mmc0_uhs_pins: mmc0-uhs-pins {
-		clk-pins {
-			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_10mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		cmd-dat-pins {
-			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
-				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
-				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
-				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
-				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
-				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
-				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
-				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
-				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_10mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-		};
-
-		ds-pins {
-			pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_10mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		rst-pins {
-			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_10mA>;
-			bias-pull-up;
-		};
-	};
-
-	mmc1_default_pins: mmc1-default-pins {
-		cd-pins {
-			pinmux = <MT8365_PIN_76_CMDAT8__FUNC_GPIO76>;
-			bias-pull-up;
-		};
-
-		clk-pins {
-			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		cmd-dat-pins {
-			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
-				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
-				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
-				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
-				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
-			input-enable;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-		};
-	};
-
-	mmc1_uhs_pins: mmc1-uhs-pins {
-		clk-pins {
-			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		cmd-dat-pins {
-			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
-				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
-				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
-				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
-				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-		};
-	};
-
-	uart0_pins: uart0-pins {
-		pins {
-			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,
-				 <MT8365_PIN_36_UTXD0__FUNC_UTXD0>;
-		};
-	};
-
-	uart1_pins: uart1-pins {
-		pins {
-			pinmux = <MT8365_PIN_37_URXD1__FUNC_URXD1>,
-				 <MT8365_PIN_38_UTXD1__FUNC_UTXD1>;
-		};
-	};
-
-	uart2_pins: uart2-pins {
-		pins {
-			pinmux = <MT8365_PIN_39_URXD2__FUNC_URXD2>,
-				 <MT8365_PIN_40_UTXD2__FUNC_UTXD2>;
-		};
-	};
-
-	usb_pins: usb-pins {
-		id-pins {
-			pinmux = <MT8365_PIN_17_GPIO17__FUNC_GPIO17>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		usb0-vbus-pins {
-			pinmux = <MT8365_PIN_16_GPIO16__FUNC_USB_DRVVBUS>;
-			output-high;
-		};
-
-		usb1-vbus-pins {
-			pinmux = <MT8365_PIN_18_GPIO18__FUNC_GPIO18>;
-			output-high;
-		};
-	};
-
-	pwm_pins: pwm-pins {
-		pins {
-			pinmux = <MT8365_PIN_19_DISP_PWM__FUNC_PWM_A>,
-				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
-		};
-	};
-};
-
-&pwm {
-	pinctrl-0 = <&pwm_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&ssusb {
-	dr_mode = "otg";
-	maximum-speed = "high-speed";
-	pinctrl-0 = <&usb_pins>;
-	pinctrl-names = "default";
-	usb-role-switch;
-	vusb33-supply = <&mt6357_vusb33_reg>;
-	status = "okay";
-
-	connector {
-		compatible = "gpio-usb-b-connector", "usb-b-connector";
-		id-gpios = <&pio 17 GPIO_ACTIVE_HIGH>;
-		type = "micro";
-		vbus-supply = <&usb_otg_vbus>;
-	};
-};
-
-&usb_host {
-	vusb33-supply = <&mt6357_vusb33_reg>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-0 = <&uart1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
diff --git a/arch/arm/dts/mt8365.dtsi b/arch/arm/dts/mt8365.dtsi
deleted file mode 100644
index 24581f7410aae50f4595d8d281429c937b87caf6..0000000000000000000000000000000000000000
--- a/arch/arm/dts/mt8365.dtsi
+++ /dev/null
@@ -1,840 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * (C) 2018 MediaTek Inc.
- * Copyright (C) 2022 BayLibre SAS
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
- */
-#include <dt-bindings/clock/mediatek,mt8365-clk.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/power/mediatek,mt8365-power.h>
-
-/ {
-	compatible = "mediatek,mt8365";
-	interrupt-parent = <&sysirq>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-	cluster0_opp: opp-table-0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-850000000 {
-			opp-hz = /bits/ 64 <850000000>;
-			opp-microvolt = <650000>;
-		};
-
-		opp-918000000 {
-			opp-hz = /bits/ 64 <918000000>;
-			opp-microvolt = <668750>;
-		};
-
-		opp-987000000 {
-			opp-hz = /bits/ 64 <987000000>;
-			opp-microvolt = <687500>;
-		};
-
-		opp-1056000000 {
-			opp-hz = /bits/ 64 <1056000000>;
-			opp-microvolt = <706250>;
-		};
-
-		opp-1125000000 {
-			opp-hz = /bits/ 64 <1125000000>;
-			opp-microvolt = <725000>;
-		};
-
-		opp-1216000000 {
-			opp-hz = /bits/ 64 <1216000000>;
-			opp-microvolt = <750000>;
-		};
-
-		opp-1308000000 {
-			opp-hz = /bits/ 64 <1308000000>;
-			opp-microvolt = <775000>;
-		};
-
-		opp-1400000000 {
-			opp-hz = /bits/ 64 <1400000000>;
-			opp-microvolt = <800000>;
-		};
-
-		opp-1466000000 {
-			opp-hz = /bits/ 64 <1466000000>;
-			opp-microvolt = <825000>;
-		};
-
-		opp-1533000000 {
-			opp-hz = /bits/ 64 <1533000000>;
-			opp-microvolt = <850000>;
-		};
-
-		opp-1633000000 {
-			opp-hz = /bits/ 64 <1633000000>;
-			opp-microvolt = <887500>;
-		};
-
-		opp-1700000000 {
-			opp-hz = /bits/ 64 <1700000000>;
-			opp-microvolt = <912500>;
-		};
-
-		opp-1767000000 {
-			opp-hz = /bits/ 64 <1767000000>;
-			opp-microvolt = <937500>;
-		};
-
-		opp-1834000000 {
-			opp-hz = /bits/ 64 <1834000000>;
-			opp-microvolt = <962500>;
-		};
-
-		opp-1917000000 {
-			opp-hz = /bits/ 64 <1917000000>;
-			opp-microvolt = <993750>;
-		};
-
-		opp-2001000000 {
-			opp-hz = /bits/ 64 <2001000000>;
-			opp-microvolt = <1025000>;
-		};
-	};
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&cpu0>;
-				};
-				core1 {
-					cpu = <&cpu1>;
-				};
-				core2 {
-					cpu = <&cpu2>;
-				};
-				core3 {
-					cpu = <&cpu3>;
-				};
-			};
-		};
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0x0>;
-			#cooling-cells = <2>;
-			enable-method = "psci";
-			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&l2>;
-			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
-				 <&apmixedsys CLK_APMIXED_MAINPLL>;
-			clock-names = "cpu", "intermediate";
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0x1>;
-			#cooling-cells = <2>;
-			enable-method = "psci";
-			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&l2>;
-			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
-				 <&apmixedsys CLK_APMIXED_MAINPLL>;
-			clock-names = "cpu", "intermediate", "armpll";
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0x2>;
-			#cooling-cells = <2>;
-			enable-method = "psci";
-			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&l2>;
-			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
-				 <&apmixedsys CLK_APMIXED_MAINPLL>;
-			clock-names = "cpu", "intermediate", "armpll";
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0x3>;
-			#cooling-cells = <2>;
-			enable-method = "psci";
-			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&l2>;
-			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
-				 <&apmixedsys CLK_APMIXED_MAINPLL>;
-			clock-names = "cpu", "intermediate", "armpll";
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		idle-states {
-			entry-method = "psci";
-
-			CPU_MCDI: cpu-mcdi {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x00010001>;
-				entry-latency-us = <300>;
-				exit-latency-us = <200>;
-				min-residency-us = <1000>;
-			};
-
-			CLUSTER_MCDI: cluster-mcdi {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x01010001>;
-				entry-latency-us = <350>;
-				exit-latency-us = <250>;
-				min-residency-us = <1200>;
-			};
-
-			CLUSTER_DPIDLE: cluster-dpidle {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x01010004>;
-				entry-latency-us = <300>;
-				exit-latency-us = <800>;
-				min-residency-us = <3300>;
-			};
-		};
-
-		l2: l2-cache {
-			compatible = "cache";
-			cache-level = <2>;
-			cache-size = <0x80000>;
-			cache-line-size = <64>;
-			cache-sets = <512>;
-			cache-unified;
-		};
-	};
-
-	clk26m: oscillator {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <26000000>;
-		clock-output-names = "clk26m";
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	soc {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "simple-bus";
-		ranges;
-
-		gic: interrupt-controller@c000000 {
-			compatible = "arm,gic-v3";
-			#interrupt-cells = <3>;
-			interrupt-parent = <&gic>;
-			interrupt-controller;
-			reg = <0 0x0c000000 0 0x10000>, /* GICD */
-			      <0 0x0c080000 0 0x80000>, /* GICR */
-			      <0 0x0c400000 0 0x2000>,  /* GICC */
-			      <0 0x0c410000 0 0x1000>,  /* GICH */
-			      <0 0x0c420000 0 0x2000>;  /* GICV */
-
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		topckgen: syscon@10000000 {
-			compatible = "mediatek,mt8365-topckgen", "syscon";
-			reg = <0 0x10000000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		infracfg: syscon@10001000 {
-			compatible = "mediatek,mt8365-infracfg", "syscon";
-			reg = <0 0x10001000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		pericfg: syscon@10003000 {
-			compatible = "mediatek,mt8365-pericfg", "syscon";
-			reg = <0 0x10003000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		syscfg_pctl: syscfg-pctl@10005000 {
-			compatible = "mediatek,mt8365-syscfg", "syscon";
-			reg = <0 0x10005000 0 0x1000>;
-		};
-
-		scpsys: syscon@10006000 {
-			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
-			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
-
-			/* System Power Manager */
-			spm: power-controller {
-				compatible = "mediatek,mt8365-power-controller";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#power-domain-cells = <1>;
-
-				/* power domains of the SoC */
-				power-domain@MT8365_POWER_DOMAIN_MM {
-					reg = <MT8365_POWER_DOMAIN_MM>;
-					clocks = <&topckgen CLK_TOP_MM_SEL>,
-						 <&mmsys CLK_MM_MM_SMI_COMMON>,
-						 <&mmsys CLK_MM_MM_SMI_COMM0>,
-						 <&mmsys CLK_MM_MM_SMI_COMM1>,
-						 <&mmsys CLK_MM_MM_SMI_LARB0>;
-					clock-names = "mm", "mm-0", "mm-1",
-						      "mm-2", "mm-3";
-					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-					mediatek,infracfg-nao = <&infracfg_nao>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					power-domain@MT8365_POWER_DOMAIN_CAM {
-						reg = <MT8365_POWER_DOMAIN_CAM>;
-						clocks = <&camsys CLK_CAM_LARB2>,
-							 <&camsys CLK_CAM_SENIF>,
-							 <&camsys CLK_CAMSV0>,
-							 <&camsys CLK_CAMSV1>,
-							 <&camsys CLK_CAM_FDVT>,
-							 <&camsys CLK_CAM_WPE>;
-						clock-names = "cam-0", "cam-1",
-							      "cam-2", "cam-3",
-							      "cam-4", "cam-5";
-						#power-domain-cells = <0>;
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
-					};
-
-					power-domain@MT8365_POWER_DOMAIN_VDEC {
-						reg = <MT8365_POWER_DOMAIN_VDEC>;
-						#power-domain-cells = <0>;
-						mediatek,smi = <&smi_common>;
-					};
-
-					power-domain@MT8365_POWER_DOMAIN_VENC {
-						reg = <MT8365_POWER_DOMAIN_VENC>;
-						#power-domain-cells = <0>;
-						mediatek,smi = <&smi_common>;
-					};
-
-					power-domain@MT8365_POWER_DOMAIN_APU {
-						reg = <MT8365_POWER_DOMAIN_APU>;
-						clocks = <&infracfg CLK_IFR_APU_AXI>,
-							 <&apu CLK_APU_IPU_CK>,
-							 <&apu CLK_APU_AXI>,
-							 <&apu CLK_APU_JTAG>,
-							 <&apu CLK_APU_IF_CK>,
-							 <&apu CLK_APU_EDMA>,
-							 <&apu CLK_APU_AHB>;
-						clock-names = "apu", "apu-0",
-							      "apu-1", "apu-2",
-							      "apu-3", "apu-4",
-							      "apu-5";
-						#power-domain-cells = <0>;
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
-					};
-				};
-
-				power-domain@MT8365_POWER_DOMAIN_CONN {
-					reg = <MT8365_POWER_DOMAIN_CONN>;
-					clocks = <&topckgen CLK_TOP_CONN_32K>,
-						 <&topckgen CLK_TOP_CONN_26M>;
-					clock-names = "conn", "conn1";
-					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-				};
-
-				power-domain@MT8365_POWER_DOMAIN_MFG {
-					reg = <MT8365_POWER_DOMAIN_MFG>;
-					clocks = <&topckgen CLK_TOP_MFG_SEL>;
-					clock-names = "mfg";
-					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-				};
-
-				power-domain@MT8365_POWER_DOMAIN_AUDIO {
-					reg = <MT8365_POWER_DOMAIN_AUDIO>;
-					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
-						 <&infracfg CLK_IFR_AUDIO>,
-						 <&infracfg CLK_IFR_AUD_26M_BK>;
-					clock-names = "audio", "audio1", "audio2";
-					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-				};
-
-				power-domain@MT8365_POWER_DOMAIN_DSP {
-					reg = <MT8365_POWER_DOMAIN_DSP>;
-					clocks = <&topckgen CLK_TOP_DSP_SEL>,
-						 <&topckgen CLK_TOP_DSP_26M>;
-					clock-names = "dsp", "dsp1";
-					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-				};
-			};
-		};
-
-		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
-			reg = <0 0x10007000 0 0x100>;
-			#reset-cells = <1>;
-		};
-
-		pio: pinctrl@1000b000 {
-			compatible = "mediatek,mt8365-pinctrl";
-			reg = <0 0x1000b000 0 0x1000>;
-			mediatek,pctl-regmap = <&syscfg_pctl>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		apmixedsys: syscon@1000c000 {
-			compatible = "mediatek,mt8365-apmixedsys", "syscon";
-			reg = <0 0x1000c000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		pwrap: pwrap@1000d000 {
-			compatible = "mediatek,mt8365-pwrap";
-			reg = <0 0x1000d000 0 0x1000>;
-			reg-names = "pwrap";
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&infracfg CLK_IFR_PWRAP_SPI>,
-				 <&infracfg CLK_IFR_PMIC_AP>,
-				 <&infracfg CLK_IFR_PWRAP_SYS>,
-				 <&infracfg CLK_IFR_PWRAP_TMR>;
-			clock-names = "spi", "wrap", "sys", "tmr";
-		};
-
-		keypad: keypad@10010000 {
-			compatible = "mediatek,mt6779-keypad";
-			reg = <0 0x10010000 0 0x1000>;
-			wakeup-source;
-			interrupts = <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
-			clocks = <&clk26m>;
-			clock-names = "kpd";
-			status = "disabled";
-		};
-
-		mcucfg: syscon@10200000 {
-			compatible = "mediatek,mt8365-mcucfg", "syscon";
-			reg = <0 0x10200000 0 0x2000>;
-			#clock-cells = <1>;
-		};
-
-		sysirq: interrupt-controller@10200a80 {
-			compatible = "mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupt-parent = <&gic>;
-			reg = <0 0x10200a80 0 0x20>;
-		};
-
-		iommu: iommu@10205000 {
-			compatible = "mediatek,mt8365-m4u";
-			reg = <0 0x10205000 0 0x1000>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>;
-			#iommu-cells = <1>;
-		};
-
-		infracfg_nao: infracfg@1020e000 {
-			compatible = "mediatek,mt8365-infracfg", "syscon";
-			reg = <0 0x1020e000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		rng: rng@1020f000 {
-			compatible = "mediatek,mt8365-rng", "mediatek,mt7623-rng";
-			reg = <0 0x1020f000 0 0x100>;
-			clocks = <&infracfg CLK_IFR_TRNG>;
-			clock-names = "rng";
-		};
-
-		apdma: dma-controller@11000280 {
-			compatible = "mediatek,mt8365-uart-dma", "mediatek,mt6577-uart-dma";
-			reg = <0 0x11000280 0 0x80>,
-			      <0 0x11000300 0 0x80>,
-			      <0 0x11000380 0 0x80>,
-			      <0 0x11000400 0 0x80>,
-			      <0 0x11000580 0 0x80>,
-			      <0 0x11000600 0 0x80>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
-			dma-requests = <6>;
-			clocks = <&infracfg CLK_IFR_AP_DMA>;
-			clock-names = "apdma";
-			#dma-cells = <1>;
-		};
-
-		uart0: serial@11002000 {
-			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
-			reg = <0 0x11002000 0 0x1000>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
-			clock-names = "baud", "bus";
-			dmas = <&apdma 0>, <&apdma 1>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		uart1: serial@11003000 {
-			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
-			reg = <0 0x11003000 0 0x1000>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&clk26m>, <&infracfg CLK_IFR_UART1>;
-			clock-names = "baud", "bus";
-			dmas = <&apdma 2>, <&apdma 3>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		uart2: serial@11004000 {
-			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
-			reg = <0 0x11004000 0 0x1000>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&clk26m>, <&infracfg CLK_IFR_UART2>;
-			clock-names = "baud", "bus";
-			dmas = <&apdma 4>, <&apdma 5>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		pwm: pwm@11006000 {
-			compatible = "mediatek,mt8365-pwm";
-			reg = <0 0x11006000 0 0x1000>;
-			#pwm-cells = <2>;
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&infracfg CLK_IFR_PWM_HCLK>,
-				 <&infracfg CLK_IFR_PWM>,
-				 <&infracfg CLK_IFR_PWM1>,
-				 <&infracfg CLK_IFR_PWM2>,
-				 <&infracfg CLK_IFR_PWM3>;
-			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
-		};
-
-		i2c0: i2c@11007000 {
-			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
-			reg = <0 0x11007000 0 0xa0>, <0 0x11000080 0 0x80>;
-			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
-			clock-div = <1>;
-			clocks = <&infracfg CLK_IFR_I2C0_AXI>, <&infracfg CLK_IFR_AP_DMA>;
-			clock-names = "main", "dma";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@11008000 {
-			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
-			reg = <0 0x11008000 0 0xa0>, <0 0x11000100 0 0x80>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
-			clock-div = <1>;
-			clocks = <&infracfg CLK_IFR_I2C1_AXI>, <&infracfg CLK_IFR_AP_DMA>;
-			clock-names = "main", "dma";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@11009000 {
-			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
-			reg = <0 0x11009000 0 0xa0>, <0 0x11000180 0 0x80>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
-			clock-div = <1>;
-			clocks = <&infracfg CLK_IFR_I2C2_AXI>, <&infracfg CLK_IFR_AP_DMA>;
-			clock-names = "main", "dma";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi: spi@1100a000 {
-			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
-			reg = <0 0x1100a000 0 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
-				 <&topckgen CLK_TOP_SPI_SEL>,
-				 <&infracfg CLK_IFR_SPI0>;
-			clock-names = "parent-clk", "sel-clk", "spi-clk";
-			status = "disabled";
-		};
-
-		i2c3: i2c@1100f000 {
-			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
-			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
-			clock-div = <1>;
-			clocks = <&infracfg CLK_IFR_I2C3_AXI>, <&infracfg CLK_IFR_AP_DMA>;
-			clock-names = "main", "dma";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		ssusb: usb@11201000 {
-			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
-			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
-			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
-			phys = <&u2port0 PHY_TYPE_USB2>,
-			       <&u2port1 PHY_TYPE_USB2>;
-			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
-				 <&infracfg CLK_IFR_SSUSB_REF>,
-				 <&infracfg CLK_IFR_SSUSB_SYS>,
-				 <&infracfg CLK_IFR_ICUSB>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			status = "disabled";
-
-			usb_host: usb@11200000 {
-				compatible = "mediatek,mt8365-xhci", "mediatek,mtk-xhci";
-				reg = <0 0x11200000 0 0x1000>;
-				reg-names = "mac";
-				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
-				clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
-					 <&infracfg CLK_IFR_SSUSB_REF>,
-					 <&infracfg CLK_IFR_SSUSB_SYS>,
-					 <&infracfg CLK_IFR_ICUSB>,
-					 <&infracfg CLK_IFR_SSUSB_XHCI>;
-				clock-names = "sys_ck", "ref_ck", "mcu_ck",
-					      "dma_ck", "xhci_ck";
-				status = "disabled";
-			};
-		};
-
-		mmc0: mmc@11230000 {
-			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
-			reg = <0 0x11230000 0 0x1000>,
-			      <0 0x11cd0000 0 0x1000>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
-				 <&infracfg CLK_IFR_MSDC0_HCLK>,
-				 <&infracfg CLK_IFR_MSDC0_SRC>;
-			clock-names = "source", "hclk", "source_cg";
-			status = "disabled";
-		};
-
-		mmc1: mmc@11240000 {
-			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
-			reg = <0 0x11240000 0 0x1000>,
-			      <0 0x11c90000 0 0x1000>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
-				 <&infracfg CLK_IFR_MSDC1_HCLK>,
-				 <&infracfg CLK_IFR_MSDC1_SRC>;
-			clock-names = "source", "hclk", "source_cg";
-			status = "disabled";
-		};
-
-		mmc2: mmc@11250000 {
-			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
-			reg = <0 0x11250000 0 0x1000>,
-			      <0 0x11c60000 0 0x1000>;
-			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>,
-				 <&infracfg CLK_IFR_MSDC2_HCLK>,
-				 <&infracfg CLK_IFR_MSDC2_SRC>,
-				 <&infracfg CLK_IFR_MSDC2_BK>,
-				 <&infracfg CLK_IFR_AP_MSDC0>;
-			clock-names = "source", "hclk", "source_cg",
-				      "bus_clk", "sys_cg";
-			status = "disabled";
-		};
-
-		ethernet: ethernet@112a0000 {
-			compatible = "mediatek,mt8365-eth";
-			reg = <0 0x112a0000 0 0x1000>;
-			mediatek,pericfg = <&infracfg>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&topckgen CLK_TOP_ETH_SEL>,
-				 <&infracfg CLK_IFR_NIC_AXI>,
-				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
-			clock-names = "core", "reg", "trans";
-			status = "disabled";
-		};
-
-		u3phy: t-phy@11cc0000 {
-			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0 0x11cc0000 0x9000>;
-
-			u2port0: usb-phy@0 {
-				reg = <0x0 0x400>;
-				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
-					 <&topckgen CLK_TOP_USB20_48M_EN>;
-				clock-names = "ref", "da_ref";
-				#phy-cells = <1>;
-			};
-
-			u2port1: usb-phy@1000 {
-				reg = <0x1000 0x400>;
-				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
-					 <&topckgen CLK_TOP_USB20_48M_EN>;
-				clock-names = "ref", "da_ref";
-				#phy-cells = <1>;
-			};
-		};
-
-		mmsys: syscon@14000000 {
-			compatible = "mediatek,mt8365-mmsys", "syscon";
-			reg = <0 0x14000000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		smi_common: smi@14002000 {
-			compatible = "mediatek,mt8365-smi-common";
-			reg = <0 0x14002000 0 0x1000>;
-			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
-				 <&mmsys CLK_MM_MM_SMI_COMMON>,
-				 <&mmsys CLK_MM_MM_SMI_COMM0>,
-				 <&mmsys CLK_MM_MM_SMI_COMM1>;
-			clock-names = "apb", "smi", "gals0", "gals1";
-			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
-		};
-
-		larb0: larb@14003000 {
-			compatible = "mediatek,mt8365-smi-larb",
-				     "mediatek,mt8186-smi-larb";
-			reg = <0 0x14003000 0 0x1000>;
-			mediatek,smi = <&smi_common>;
-			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
-				 <&mmsys CLK_MM_MM_SMI_LARB0>;
-			clock-names = "apb", "smi";
-			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
-			mediatek,larb-id = <0>;
-		};
-
-		camsys: syscon@15000000 {
-			compatible = "mediatek,mt8365-imgsys", "syscon";
-			reg = <0 0x15000000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		larb2: larb@15001000 {
-			compatible = "mediatek,mt8365-smi-larb",
-				     "mediatek,mt8186-smi-larb";
-			reg = <0 0x15001000 0 0x1000>;
-			mediatek,smi = <&smi_common>;
-			clocks = <&mmsys CLK_MM_MM_SMI_IMG>,
-				 <&camsys CLK_CAM_LARB2>;
-			clock-names = "apb", "smi";
-			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
-			mediatek,larb-id = <2>;
-		};
-
-		vdecsys: syscon@16000000 {
-			compatible = "mediatek,mt8365-vdecsys", "syscon";
-			reg = <0 0x16000000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		larb3: larb@16010000 {
-			compatible = "mediatek,mt8365-smi-larb",
-				     "mediatek,mt8186-smi-larb";
-			reg = <0 0x16010000 0 0x1000>;
-			mediatek,smi = <&smi_common>;
-			clocks = <&vdecsys CLK_VDEC_LARB1>,
-				 <&vdecsys CLK_VDEC_LARB1>;
-			clock-names = "apb", "smi";
-			power-domains = <&spm MT8365_POWER_DOMAIN_VDEC>;
-			mediatek,larb-id = <3>;
-		};
-
-		vencsys: syscon@17000000 {
-			compatible = "mediatek,mt8365-vencsys", "syscon";
-			reg = <0 0x17000000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		larb1: larb@17010000 {
-			compatible = "mediatek,mt8365-smi-larb",
-				     "mediatek,mt8186-smi-larb";
-			reg = <0 0x17010000 0 0x1000>;
-			mediatek,smi = <&smi_common>;
-			clocks = <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
-			clock-names = "apb", "smi";
-			power-domains = <&spm MT8365_POWER_DOMAIN_VENC>;
-			mediatek,larb-id = <1>;
-		};
-
-		apu: syscon@19020000 {
-			compatible = "mediatek,mt8365-apu", "syscon";
-			reg = <0 0x19020000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	system_clk: dummy13m {
-		compatible = "fixed-clock";
-		clock-frequency = <13000000>;
-		#clock-cells = <0>;
-	};
-
-	systimer: timer@10017000 {
-		compatible = "mediatek,mt8365-systimer", "mediatek,mt6765-timer";
-		reg = <0 0x10017000 0 0x100>;
-		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&system_clk>;
-		clock-names = "clk13m";
-	};
-};
diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8365_evk/MAINTAINERS
index bb28ae8df7b15f6426a96b9cb4593d079828fa20..e0d65efe81293f72784ac0d83bf38be65350f8b7 100644
--- a/board/mediatek/mt8365_evk/MAINTAINERS
+++ b/board/mediatek/mt8365_evk/MAINTAINERS
@@ -1,6 +1,5 @@
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
-F:	arch/arm/dts/mt8365-evk.dts
 F:	board/mediatek/mt8365_evk/
 F:	configs/mt8365_evk_defconfig
diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 9d8ea72370ef5c5d80b5532baedd5f734ef12e85..7b411453e0013faaccde8b5c12cee74d81b8d7ad 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -5,12 +5,13 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="mt8365-evk"
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
 CONFIG_TARGET_MT8365=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING=" mt8365-evk"
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
+CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_BAUDRATE=921600
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 61ccd4a210fec2aecaa7bf9fb68bc37337bd1485..53eca73b98d8b7de068fc87a02192da9b9bc1189 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -13,6 +13,10 @@
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include "clk-mtk.h"
 
+/* Missing topckgen clocks definition in dt-bindings */
+#define CLK_TOP_CLK26M		141
+#define CLK_TOP_CLK32K		142
+
 /* apmixedsys */
 #define MT8365_PLL_FMAX		(3800UL * MHZ)
 #define MT8365_PLL_FMIN		(1500UL * MHZ)
diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
deleted file mode 100644
index e5cb8a19ab9bcf581dfb1a86ba338e6d0f06ac51..0000000000000000000000000000000000000000
--- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
+++ /dev/null
@@ -1,375 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
- *
- * Copyright (c) 2022 MediaTek Inc.
- */
-
-#ifndef _DT_BINDINGS_CLK_MT8365_H
-#define _DT_BINDINGS_CLK_MT8365_H
-
-/* TOPCKGEN */
-#define CLK_TOP_CLK_NULL		0
-#define CLK_TOP_I2S0_BCK		1
-#define CLK_TOP_DSI0_LNTC_DSICK		2
-#define CLK_TOP_VPLL_DPIX		3
-#define CLK_TOP_LVDSTX_CLKDIG_CTS	4
-#define CLK_TOP_MFGPLL			5
-#define CLK_TOP_SYSPLL_D2		6
-#define CLK_TOP_SYSPLL1_D2		7
-#define CLK_TOP_SYSPLL1_D4		8
-#define CLK_TOP_SYSPLL1_D8		9
-#define CLK_TOP_SYSPLL1_D16		10
-#define CLK_TOP_SYSPLL_D3		11
-#define CLK_TOP_SYSPLL2_D2		12
-#define CLK_TOP_SYSPLL2_D4		13
-#define CLK_TOP_SYSPLL2_D8		14
-#define CLK_TOP_SYSPLL_D5		15
-#define CLK_TOP_SYSPLL3_D2		16
-#define CLK_TOP_SYSPLL3_D4		17
-#define CLK_TOP_SYSPLL_D7		18
-#define CLK_TOP_SYSPLL4_D2		19
-#define CLK_TOP_SYSPLL4_D4		20
-#define CLK_TOP_UNIVPLL			21
-#define CLK_TOP_UNIVPLL_D2		22
-#define CLK_TOP_UNIVPLL1_D2		23
-#define CLK_TOP_UNIVPLL1_D4		24
-#define CLK_TOP_UNIVPLL_D3		25
-#define CLK_TOP_UNIVPLL2_D2		26
-#define CLK_TOP_UNIVPLL2_D4		27
-#define CLK_TOP_UNIVPLL2_D8		28
-#define CLK_TOP_UNIVPLL2_D32		29
-#define CLK_TOP_UNIVPLL_D5		30
-#define CLK_TOP_UNIVPLL3_D2		31
-#define CLK_TOP_UNIVPLL3_D4		32
-#define CLK_TOP_MMPLL			33
-#define CLK_TOP_MMPLL_D2		34
-#define CLK_TOP_LVDSPLL_D2		35
-#define CLK_TOP_LVDSPLL_D4		36
-#define CLK_TOP_LVDSPLL_D8		37
-#define CLK_TOP_LVDSPLL_D16		38
-#define CLK_TOP_USB20_192M		39
-#define CLK_TOP_USB20_192M_D4		40
-#define CLK_TOP_USB20_192M_D8		41
-#define CLK_TOP_USB20_192M_D16		42
-#define CLK_TOP_USB20_192M_D32		43
-#define CLK_TOP_APLL1			44
-#define CLK_TOP_APLL1_D2		45
-#define CLK_TOP_APLL1_D4		46
-#define CLK_TOP_APLL1_D8		47
-#define CLK_TOP_APLL2			48
-#define CLK_TOP_APLL2_D2		49
-#define CLK_TOP_APLL2_D4		50
-#define CLK_TOP_APLL2_D8		51
-#define CLK_TOP_SYS_26M_D2		52
-#define CLK_TOP_MSDCPLL			53
-#define CLK_TOP_MSDCPLL_D2		54
-#define CLK_TOP_DSPPLL			55
-#define CLK_TOP_DSPPLL_D2		56
-#define CLK_TOP_DSPPLL_D4		57
-#define CLK_TOP_DSPPLL_D8		58
-#define CLK_TOP_APUPLL			59
-#define CLK_TOP_CLK26M_D52		60
-#define CLK_TOP_AXI_SEL			61
-#define CLK_TOP_MEM_SEL			62
-#define CLK_TOP_MM_SEL			63
-#define CLK_TOP_SCP_SEL			64
-#define CLK_TOP_MFG_SEL			65
-#define CLK_TOP_ATB_SEL			66
-#define CLK_TOP_CAMTG_SEL		67
-#define CLK_TOP_CAMTG1_SEL		68
-#define CLK_TOP_UART_SEL		69
-#define CLK_TOP_SPI_SEL			70
-#define CLK_TOP_MSDC50_0_HC_SEL		71
-#define CLK_TOP_MSDC2_2_HC_SEL		72
-#define CLK_TOP_MSDC50_0_SEL		73
-#define CLK_TOP_MSDC50_2_SEL		74
-#define CLK_TOP_MSDC30_1_SEL		75
-#define CLK_TOP_AUDIO_SEL		76
-#define CLK_TOP_AUD_INTBUS_SEL		77
-#define CLK_TOP_AUD_1_SEL		78
-#define CLK_TOP_AUD_2_SEL		79
-#define CLK_TOP_AUD_ENGEN1_SEL		80
-#define CLK_TOP_AUD_ENGEN2_SEL		81
-#define CLK_TOP_AUD_SPDIF_SEL		82
-#define CLK_TOP_DISP_PWM_SEL		83
-#define CLK_TOP_DXCC_SEL		84
-#define CLK_TOP_SSUSB_SYS_SEL		85
-#define CLK_TOP_SSUSB_XHCI_SEL		86
-#define CLK_TOP_SPM_SEL			87
-#define CLK_TOP_I2C_SEL			88
-#define CLK_TOP_PWM_SEL			89
-#define CLK_TOP_SENIF_SEL		90
-#define CLK_TOP_AES_FDE_SEL		91
-#define CLK_TOP_CAMTM_SEL		92
-#define CLK_TOP_DPI0_SEL		93
-#define CLK_TOP_DPI1_SEL		94
-#define CLK_TOP_DSP_SEL			95
-#define CLK_TOP_NFI2X_SEL		96
-#define CLK_TOP_NFIECC_SEL		97
-#define CLK_TOP_ECC_SEL			98
-#define CLK_TOP_ETH_SEL			99
-#define CLK_TOP_GCPU_SEL		100
-#define CLK_TOP_GCPU_CPM_SEL		101
-#define CLK_TOP_APU_SEL			102
-#define CLK_TOP_APU_IF_SEL		103
-#define CLK_TOP_MBIST_DIAG_SEL		104
-#define CLK_TOP_APLL_I2S0_SEL		105
-#define CLK_TOP_APLL_I2S1_SEL		106
-#define CLK_TOP_APLL_I2S2_SEL		107
-#define CLK_TOP_APLL_I2S3_SEL		108
-#define CLK_TOP_APLL_TDMOUT_SEL		109
-#define CLK_TOP_APLL_TDMIN_SEL		110
-#define CLK_TOP_APLL_SPDIF_SEL		111
-#define CLK_TOP_APLL12_CK_DIV0		112
-#define CLK_TOP_APLL12_CK_DIV1		113
-#define CLK_TOP_APLL12_CK_DIV2		114
-#define CLK_TOP_APLL12_CK_DIV3		115
-#define CLK_TOP_APLL12_CK_DIV4		116
-#define CLK_TOP_APLL12_CK_DIV4B		117
-#define CLK_TOP_APLL12_CK_DIV5		118
-#define CLK_TOP_APLL12_CK_DIV5B		119
-#define CLK_TOP_APLL12_CK_DIV6		120
-#define CLK_TOP_AUD_I2S0_M		121
-#define CLK_TOP_AUD_I2S1_M		122
-#define CLK_TOP_AUD_I2S2_M		123
-#define CLK_TOP_AUD_I2S3_M		124
-#define CLK_TOP_AUD_TDMOUT_M		125
-#define CLK_TOP_AUD_TDMOUT_B		126
-#define CLK_TOP_AUD_TDMIN_M		127
-#define CLK_TOP_AUD_TDMIN_B		128
-#define CLK_TOP_AUD_SPDIF_M		129
-#define CLK_TOP_USB20_48M_EN		130
-#define CLK_TOP_UNIVPLL_48M_EN		131
-#define CLK_TOP_LVDSTX_CLKDIG_EN	132
-#define CLK_TOP_VPLL_DPIX_EN		133
-#define CLK_TOP_SSUSB_TOP_CK_EN		134
-#define CLK_TOP_SSUSB_PHY_CK_EN		135
-#define CLK_TOP_CONN_32K		136
-#define CLK_TOP_CONN_26M		137
-#define CLK_TOP_DSP_32K			138
-#define CLK_TOP_DSP_26M			139
-#define CLK_TOP_NR_CLK			140
-#define CLK_TOP_CLK26M			141
-#define CLK_TOP_CLK32K			142
-
-/* INFRACFG */
-#define CLK_IFR_PMIC_TMR		0
-#define CLK_IFR_PMIC_AP			1
-#define CLK_IFR_PMIC_MD			2
-#define CLK_IFR_PMIC_CONN		3
-#define CLK_IFR_ICUSB			4
-#define CLK_IFR_GCE			5
-#define CLK_IFR_THERM			6
-#define CLK_IFR_PWM_HCLK		7
-#define CLK_IFR_PWM1			8
-#define CLK_IFR_PWM2			9
-#define CLK_IFR_PWM3			10
-#define CLK_IFR_PWM4			11
-#define CLK_IFR_PWM5			12
-#define CLK_IFR_PWM			13
-#define CLK_IFR_UART0			14
-#define CLK_IFR_UART1			15
-#define CLK_IFR_UART2			16
-#define CLK_IFR_DSP_UART		17
-#define CLK_IFR_GCE_26M			18
-#define CLK_IFR_CQ_DMA_FPC		19
-#define CLK_IFR_BTIF			20
-#define CLK_IFR_SPI0			21
-#define CLK_IFR_MSDC0_HCLK		22
-#define CLK_IFR_MSDC2_HCLK		23
-#define CLK_IFR_MSDC1_HCLK		24
-#define CLK_IFR_DVFSRC			25
-#define CLK_IFR_GCPU			26
-#define CLK_IFR_TRNG			27
-#define CLK_IFR_AUXADC			28
-#define CLK_IFR_CPUM			29
-#define CLK_IFR_AUXADC_MD		30
-#define CLK_IFR_AP_DMA			31
-#define CLK_IFR_DEBUGSYS		32
-#define CLK_IFR_AUDIO			33
-#define CLK_IFR_PWM_FBCLK6		34
-#define CLK_IFR_DISP_PWM		35
-#define CLK_IFR_AUD_26M_BK		36
-#define CLK_IFR_CQ_DMA			37
-#define CLK_IFR_MSDC0_SF		38
-#define CLK_IFR_MSDC1_SF		39
-#define CLK_IFR_MSDC2_SF		40
-#define CLK_IFR_AP_MSDC0		41
-#define CLK_IFR_MD_MSDC0		42
-#define CLK_IFR_MSDC0_SRC		43
-#define CLK_IFR_MSDC1_SRC		44
-#define CLK_IFR_MSDC2_SRC		45
-#define CLK_IFR_PWRAP_TMR		46
-#define CLK_IFR_PWRAP_SPI		47
-#define CLK_IFR_PWRAP_SYS		48
-#define CLK_IFR_MCU_PM_BK		49
-#define CLK_IFR_IRRX_26M		50
-#define CLK_IFR_IRRX_32K		51
-#define CLK_IFR_I2C0_AXI		52
-#define CLK_IFR_I2C1_AXI		53
-#define CLK_IFR_I2C2_AXI		54
-#define CLK_IFR_I2C3_AXI		55
-#define CLK_IFR_NIC_AXI			56
-#define CLK_IFR_NIC_SLV_AXI		57
-#define CLK_IFR_APU_AXI			58
-#define CLK_IFR_NFIECC			59
-#define CLK_IFR_NFIECC_BK		60
-#define CLK_IFR_NFI1X_BK		61
-#define CLK_IFR_NFI_BK			62
-#define CLK_IFR_MSDC2_AP_BK		63
-#define CLK_IFR_MSDC2_MD_BK		64
-#define CLK_IFR_MSDC2_BK		65
-#define CLK_IFR_SUSB_133_BK		66
-#define CLK_IFR_SUSB_66_BK		67
-#define CLK_IFR_SSUSB_SYS		68
-#define CLK_IFR_SSUSB_REF		69
-#define CLK_IFR_SSUSB_XHCI		70
-#define CLK_IFR_NR_CLK			71
-
-/* PERICFG */
-#define CLK_PERIAXI			0
-#define CLK_PERI_NR_CLK			1
-
-/* APMIXEDSYS */
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_MAINPLL		1
-#define CLK_APMIXED_UNIVPLL		2
-#define CLK_APMIXED_MFGPLL		3
-#define CLK_APMIXED_MSDCPLL		4
-#define CLK_APMIXED_MMPLL		5
-#define CLK_APMIXED_APLL1		6
-#define CLK_APMIXED_APLL2		7
-#define CLK_APMIXED_LVDSPLL		8
-#define CLK_APMIXED_DSPPLL		9
-#define CLK_APMIXED_APUPLL		10
-#define CLK_APMIXED_UNIV_EN		11
-#define CLK_APMIXED_USB20_EN		12
-#define CLK_APMIXED_NR_CLK		13
-
-/* GCE */
-#define CLK_GCE_FAXI			0
-#define CLK_GCE_NR_CLK			1
-
-/* AUDIOTOP */
-#define CLK_AUD_AFE			0
-#define CLK_AUD_I2S			1
-#define CLK_AUD_22M			2
-#define CLK_AUD_24M			3
-#define CLK_AUD_INTDIR			4
-#define CLK_AUD_APLL2_TUNER		5
-#define CLK_AUD_APLL_TUNER		6
-#define CLK_AUD_SPDF			7
-#define CLK_AUD_HDMI			8
-#define CLK_AUD_HDMI_IN			9
-#define CLK_AUD_ADC			10
-#define CLK_AUD_DAC			11
-#define CLK_AUD_DAC_PREDIS		12
-#define CLK_AUD_TML			13
-#define CLK_AUD_I2S1_BK			14
-#define CLK_AUD_I2S2_BK			15
-#define CLK_AUD_I2S3_BK			16
-#define CLK_AUD_I2S4_BK			17
-#define CLK_AUD_NR_CLK			18
-
-/* MIPI_CSI0A */
-#define CLK_MIPI0A_CSR_CSI_EN_0A	0
-#define CLK_MIPI_RX_ANA_CSI0A_NR_CLK	1
-
-/* MIPI_CSI0B */
-#define CLK_MIPI0B_CSR_CSI_EN_0B	0
-#define CLK_MIPI_RX_ANA_CSI0B_NR_CLK	1
-
-/* MIPI_CSI1A */
-#define CLK_MIPI1A_CSR_CSI_EN_1A	0
-#define CLK_MIPI_RX_ANA_CSI1A_NR_CLK	1
-
-/* MIPI_CSI1B */
-#define CLK_MIPI1B_CSR_CSI_EN_1B	0
-#define CLK_MIPI_RX_ANA_CSI1B_NR_CLK	1
-
-/* MIPI_CSI2A */
-#define CLK_MIPI2A_CSR_CSI_EN_2A	0
-#define CLK_MIPI_RX_ANA_CSI2A_NR_CLK	1
-
-/* MIPI_CSI2B */
-#define CLK_MIPI2B_CSR_CSI_EN_2B	0
-#define CLK_MIPI_RX_ANA_CSI2B_NR_CLK	1
-
-/* MCUCFG */
-#define CLK_MCU_BUS_SEL			0
-#define CLK_MCU_NR_CLK			1
-
-/* MFGCFG */
-#define CLK_MFG_BG3D			0
-#define CLK_MFG_MBIST_DIAG		1
-#define CLK_MFG_NR_CLK			2
-
-/* MMSYS */
-#define CLK_MM_MM_MDP_RDMA0		0
-#define CLK_MM_MM_MDP_CCORR0		1
-#define CLK_MM_MM_MDP_RSZ0		2
-#define CLK_MM_MM_MDP_RSZ1		3
-#define CLK_MM_MM_MDP_TDSHP0		4
-#define CLK_MM_MM_MDP_WROT0		5
-#define CLK_MM_MM_MDP_WDMA0		6
-#define CLK_MM_MM_DISP_OVL0		7
-#define CLK_MM_MM_DISP_OVL0_2L		8
-#define CLK_MM_MM_DISP_RSZ0		9
-#define CLK_MM_MM_DISP_RDMA0		10
-#define CLK_MM_MM_DISP_WDMA0		11
-#define CLK_MM_MM_DISP_COLOR0		12
-#define CLK_MM_MM_DISP_CCORR0		13
-#define CLK_MM_MM_DISP_AAL0		14
-#define CLK_MM_MM_DISP_GAMMA0		15
-#define CLK_MM_MM_DISP_DITHER0		16
-#define CLK_MM_MM_DSI0			17
-#define CLK_MM_MM_DISP_RDMA1		18
-#define CLK_MM_MM_MDP_RDMA1		19
-#define CLK_MM_DPI0_DPI0		20
-#define CLK_MM_MM_FAKE			21
-#define CLK_MM_MM_SMI_COMMON		22
-#define CLK_MM_MM_SMI_LARB0		23
-#define CLK_MM_MM_SMI_COMM0		24
-#define CLK_MM_MM_SMI_COMM1		25
-#define CLK_MM_MM_CAM_MDP		26
-#define CLK_MM_MM_SMI_IMG		27
-#define CLK_MM_MM_SMI_CAM		28
-#define CLK_MM_IMG_IMG_DL_RELAY		29
-#define CLK_MM_IMG_IMG_DL_ASYNC_TOP	30
-#define CLK_MM_DSI0_DIG_DSI		31
-#define CLK_MM_26M_HRTWT		32
-#define CLK_MM_MM_DPI0			33
-#define CLK_MM_LVDSTX_PXL		34
-#define CLK_MM_LVDSTX_CTS		35
-#define CLK_MM_NR_CLK			36
-
-/* IMGSYS */
-#define CLK_CAM_LARB2			0
-#define CLK_CAM				1
-#define CLK_CAMTG			2
-#define CLK_CAM_SENIF			3
-#define CLK_CAMSV0			4
-#define CLK_CAMSV1			5
-#define CLK_CAM_FDVT			6
-#define CLK_CAM_WPE			7
-#define CLK_CAM_NR_CLK			8
-
-/* VDECSYS */
-#define CLK_VDEC_VDEC			0
-#define CLK_VDEC_LARB1			1
-#define CLK_VDEC_NR_CLK			2
-
-/* VENCSYS */
-#define CLK_VENC			0
-#define CLK_VENC_JPGENC			1
-#define CLK_VENC_NR_CLK			2
-
-/* APUSYS */
-#define CLK_APU_IPU_CK			0
-#define CLK_APU_AXI			1
-#define CLK_APU_JTAG			2
-#define CLK_APU_IF_CK			3
-#define CLK_APU_EDMA			4
-#define CLK_APU_AHB			5
-#define CLK_APU_NR_CLK			6
-
-#endif /* _DT_BINDINGS_CLK_MT8365_H */

---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251124-arm-dts-mediatek-switch-mt8365-to-of_upstream-69bc201c8bf8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

