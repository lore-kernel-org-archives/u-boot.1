Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26656CD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 12:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7098846F2;
	Sun, 10 May 2026 14:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GVzLcM3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF79D846F5; Sun, 10 May 2026 14:29:02 +0200 (CEST)
Received: from mail-m4785125252.xmail.ntesmail.com
 (mail-m4785125252.xmail.ntesmail.com [47.85.125.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0D4846F0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.249])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3dd209111;
 Sun, 10 May 2026 20:28:47 +0800 (GMT+08:00)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 4/5] rockchip: Switch rk3368 boards to upstream
 devicetree
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <23ed0db2-b70c-4278-b9f3-0c7189f51336@gmail.com>
Date: Sun, 10 May 2026 20:28:37 +0800
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, =?utf-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>,
 u-boot@lists.denx.de, quentin.schulz@cherry.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C87F468-AD4D-425A-9517-D87A20190DE7@rock-chips.com>
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
 <23ed0db2-b70c-4278-b9f3-0c7189f51336@gmail.com>
To: Johan Jonker <jbx6244@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-HM-Tid: 0a9e11dc8f3703afkunm2810496253983a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkoeVktDSUxITk1OTBlMQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVJT0JZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=GVzLcM3ZM5C5h7O/PgjO5BGZV0DH6XY7Bs1XFlaENwLkYnkyDwPGknk6HIAmdtuL2SaL/KdFn2IldKBx0tsuTqlJKyBqsfyuN434ibOHLZbZo9X+Z8mik/kHFDolNyNPHshJinsIbn8GN64OQEU+wnMvG0TgfSSsGSwgeYh6gTg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=PYnENfdKlsGabBntqDBYuERcoeuECJ3OXo3LWos7Ps0=;
 h=date:mime-version:subject:message-id:from;
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

Hi Johan,

> 2026=E5=B9=B45=E6=9C=888=E6=97=A5 02:38=EF=BC=8CJohan Jonker =
<jbx6244@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Switch rk3368 boards to upstream devicetree.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>=20
> Changed V2:
> removal in a separate patch
> ---
> arch/arm/dts/Makefile           |    4 -
> arch/arm/dts/rk3368-geekbox.dts |  281 -------
> arch/arm/dts/rk3368-px5-evb.dts |  277 -------
> arch/arm/dts/rk3368-u-boot.dtsi |    4 +
> arch/arm/dts/rk3368.dtsi        | 1218 -------------------------------
> arch/arm/mach-rockchip/Kconfig  |    1 +
> configs/evb-px5_defconfig       |    2 +-
> configs/geekbox_defconfig       |    2 +-
> 8 files changed, 7 insertions(+), 1782 deletions(-)
> delete mode 100644 arch/arm/dts/rk3368-geekbox.dts
> delete mode 100644 arch/arm/dts/rk3368-px5-evb.dts
> delete mode 100644 arch/arm/dts/rk3368.dtsi
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 39ab188c5435..cba252489bb1 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -52,10 +52,6 @@ dtb-$(CONFIG_MACH_S900) +=3D \
> dtb-$(CONFIG_MACH_S700) +=3D \
> 	s700-cubieboard7.dtb
>=20
> -dtb-$(CONFIG_ROCKCHIP_RK3368) +=3D \
> -	rk3368-geekbox.dtb \
> -	rk3368-px5-evb.dtb \
> -
> dtb-$(CONFIG_ARCH_S5P4418) +=3D \
> 	s5p4418-nanopi2.dtb
>=20
> diff --git a/arch/arm/dts/rk3368-geekbox.dts =
b/arch/arm/dts/rk3368-geekbox.dts
> deleted file mode 100644
> index 62aa97a0b8c9..000000000000
> --- a/arch/arm/dts/rk3368-geekbox.dts
> +++ /dev/null
> @@ -1,281 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Andreas F=C3=A4rber
> - */
> -
> -/dts-v1/;
> -#include "rk3368.dtsi"
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -	model =3D "GeekBox";
> -	compatible =3D "geekbuying,geekbox", "rockchip,rk3368";
> -
> -	aliases {
> -		mmc0 =3D &emmc;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial2:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type =3D "memory";
> -		reg =3D <0x0 0x0 0x0 0x80000000>;
> -	};
> -
> -	ext_gmac: gmac-clk {
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <125000000>;
> -		clock-output-names =3D "ext_gmac";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	ir: ir-receiver {
> -		compatible =3D "gpio-ir-receiver";
> -		gpios =3D <&gpio3 RK_PD6 GPIO_ACTIVE_LOW>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&ir_int>;
> -	};
> -
> -	keys: gpio-keys {
> -		compatible =3D "gpio-keys";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwr_key>;
> -
> -		power {
> -			gpios =3D <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
> -			label =3D "GPIO Power";
> -			linux,code =3D <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	leds: gpio-leds {
> -		compatible =3D "gpio-leds";
> -
> -		blue_led: led-0 {
> -			gpios =3D <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> -			label =3D "geekbox:blue:led";
> -			default-state =3D "on";
> -		};
> -
> -		red_led: led-1 {
> -			gpios =3D <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
> -			label =3D "geekbox:red:led";
> -			default-state =3D "off";
> -		};
> -	};
> -
> -	vcc_sys: vcc-sys-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc_sys";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&emmc {
> -	status =3D "okay";
> -	bus-width =3D <8>;
> -	cap-mmc-highspeed;
> -	clock-frequency =3D <150000000>;
> -	non-removable;
> -	vmmc-supply =3D <&vcc_io>;
> -	vqmmc-supply =3D <&vcc18_flash>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
> -};
> -
> -&gmac {
> -	status =3D "okay";
> -	phy-supply =3D <&vcc_lan>;
> -	phy-mode =3D "rgmii";
> -	clock_in_out =3D "input";
> -	assigned-clocks =3D <&cru SCLK_MAC>;
> -	assigned-clock-parents =3D <&ext_gmac>;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&rgmii_pins>;
> -	tx_delay =3D <0x30>;
> -	rx_delay =3D <0x10>;
> -};
> -
> -&i2c0 {
> -	status =3D "okay";
> -
> -	rk808: pmic@1b {
> -		compatible =3D "rockchip,rk808";
> -		reg =3D <0x1b>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pmic_int>, <&pmic_sleep>;
> -		interrupt-parent =3D <&gpio0>;
> -		interrupts =3D <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
> -		rockchip,system-power-controller;
> -		vcc1-supply =3D <&vcc_sys>;
> -		vcc2-supply =3D <&vcc_sys>;
> -		vcc3-supply =3D <&vcc_sys>;
> -		vcc4-supply =3D <&vcc_sys>;
> -		vcc6-supply =3D <&vcc_sys>;
> -		vcc7-supply =3D <&vcc_sys>;
> -		vcc8-supply =3D <&vcc_io>;
> -		vcc9-supply =3D <&vcc_sys>;
> -		vcc10-supply =3D <&vcc_sys>;
> -		vcc11-supply =3D <&vcc_sys>;
> -		vcc12-supply =3D <&vcc_io>;
> -		clock-output-names =3D "xin32k", "rk808-clkout2";
> -		#clock-cells =3D <1>;
> -
> -		regulators {
> -			vdd_cpu: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <700000>;
> -				regulator-max-microvolt =3D <1500000>;
> -				regulator-name =3D "vdd_cpu";
> -			};
> -
> -			vdd_log: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <700000>;
> -				regulator-max-microvolt =3D <1500000>;
> -				regulator-name =3D "vdd_log";
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name =3D "vcc_ddr";
> -			};
> -
> -			vcc_io: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <3300000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vcc_io";
> -			};
> -
> -			vcc18_flash: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc18_flash";
> -			};
> -
> -			vcc33_lcd: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <3300000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vcc33_lcd";
> -			};
> -
> -			vdd_10: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1000000>;
> -				regulator-max-microvolt =3D <1000000>;
> -				regulator-name =3D "vdd_10";
> -			};
> -
> -			vcca_18: LDO_REG4 {
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcca_18";
> -			};
> -
> -			vccio_sd: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vccio_sd";
> -			};
> -
> -			vdd10_lcd: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1000000>;
> -				regulator-max-microvolt =3D <1000000>;
> -				regulator-name =3D "vdd10_lcd";
> -			};
> -
> -			vcc_18: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc_18";
> -			};
> -
> -			vcc18_lcd: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc18_lcd";
> -			};
> -
> -			vcc_sd: SWITCH_REG1 {
> -				regulator-name =3D "vcc_sd";
> -			};
> -
> -			vcc_lan: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name =3D "vcc_lan";
> -			};
> -		};
> -	};
> -};
> -
> -&pinctrl {
> -	ir {
> -		ir_int: ir-int {
> -			rockchip,pins =3D <3 RK_PD6 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -
> -	keys {
> -		pwr_key: pwr-key {
> -			rockchip,pins =3D <0 RK_PA2 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_sleep: pmic-sleep {
> -			rockchip,pins =3D <0 RK_PA0 2 &pcfg_pull_none>;
> -		};
> -
> -		pmic_int: pmic-int {
> -			rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO =
&pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status =3D "okay";
> -	rockchip,hw-tshut-mode =3D <0>; /* CRU */
> -	rockchip,hw-tshut-polarity =3D <1>; /* high */
> -};
> -
> -&uart2 {
> -	status =3D "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status =3D "okay";
> -};
> -
> -&usb_otg {
> -	status =3D "okay";
> -};
> -
> -&wdt {
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rk3368-px5-evb.dts =
b/arch/arm/dts/rk3368-px5-evb.dts
> deleted file mode 100644
> index 5ccaa5f7a370..000000000000
> --- a/arch/arm/dts/rk3368-px5-evb.dts
> +++ /dev/null
> @@ -1,277 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include "rk3368.dtsi"
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -	model =3D "Rockchip PX5 EVB";
> -	compatible =3D "rockchip,px5-evb", "rockchip,px5", =
"rockchip,rk3368";
> -
> -	aliases {
> -		mmc0 =3D &sdmmc;
> -		mmc1 =3D &emmc;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial4:115200n8";
> -	};
> -
> -	memory@0 {
> -		reg =3D <0x0 0x0 0x0 0x40000000>;
> -		device_type =3D "memory";
> -	};
> -
> -	keys: gpio-keys {
> -		compatible =3D "gpio-keys";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwr_key>;
> -
> -		power {
> -			gpios =3D <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
> -			label =3D "GPIO Power";
> -			linux,code =3D <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	vcc_sys: vcc-sys-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc_sys";
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&emmc {
> -	status =3D "okay";
> -	bus-width =3D <8>;
> -	cap-mmc-highspeed;
> -	clock-frequency =3D <150000000>;
> -	mmc-hs200-1_8v;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
> -	vmmc-supply =3D <&vcc_io>;
> -	vqmmc-supply =3D <&vcc18_flash>;
> -};
> -
> -&i2c0 {
> -	status =3D "okay";
> -
> -	rk808: pmic@1b {
> -		compatible =3D "rockchip,rk808";
> -		reg =3D <0x1b>;
> -		interrupt-parent =3D <&gpio0>;
> -		interrupts =3D <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pmic_int>, <&pmic_sleep>;
> -		rockchip,system-power-controller;
> -		vcc1-supply =3D <&vcc_sys>;
> -		vcc2-supply =3D <&vcc_sys>;
> -		vcc3-supply =3D <&vcc_sys>;
> -		vcc4-supply =3D <&vcc_sys>;
> -		vcc6-supply =3D <&vcc_sys>;
> -		vcc7-supply =3D <&vcc_sys>;
> -		vcc8-supply =3D <&vcc_io>;
> -		vcc9-supply =3D <&vcc_sys>;
> -		vcc10-supply =3D <&vcc_sys>;
> -		vcc11-supply =3D <&vcc_sys>;
> -		vcc12-supply =3D <&vcc_io>;
> -		clock-output-names =3D "xin32k", "rk808-clkout2";
> -		#clock-cells =3D <1>;
> -
> -		regulators {
> -			vdd_cpu: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <700000>;
> -				regulator-max-microvolt =3D <1500000>;
> -				regulator-name =3D "vdd_cpu";
> -			};
> -
> -			vdd_log: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <700000>;
> -				regulator-max-microvolt =3D <1500000>;
> -				regulator-name =3D "vdd_log";
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name =3D "vcc_ddr";
> -			};
> -
> -			vcc_io: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <3300000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vcc_io";
> -			};
> -
> -			vcc18_flash: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc18_flash";
> -			};
> -
> -			vcca_33: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <3300000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vcca_33";
> -			};
> -
> -			vdd_10: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1000000>;
> -				regulator-max-microvolt =3D <1000000>;
> -				regulator-name =3D "vdd_10";
> -			};
> -
> -			avdd_33: LDO_REG4 {
> -				regulator-min-microvolt =3D <3300000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "avdd_33";
> -			};
> -
> -			vccio_sd: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <3300000>;
> -				regulator-name =3D "vccio_sd";
> -			};
> -
> -			vdd10_lcd: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1000000>;
> -				regulator-max-microvolt =3D <1000000>;
> -				regulator-name =3D "vdd10_lcd";
> -			};
> -
> -			vcc_18: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc_18";
> -			};
> -
> -			vcc18_lcd: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt =3D <1800000>;
> -				regulator-max-microvolt =3D <1800000>;
> -				regulator-name =3D "vcc18_lcd";
> -			};
> -
> -			vcc_sd: SWITCH_REG1 {
> -				regulator-name =3D "vcc_sd";
> -			};
> -
> -			vcc33_lcd: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name =3D "vcc33_lcd";
> -			};
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	status =3D "okay";
> -
> -	accelerometer@18 {
> -		compatible =3D "bosch,bma250";
> -		reg =3D <0x18>;
> -		interrupt-parent =3D <&gpio2>;
> -		interrupts =3D <RK_PC1 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -};
> -
> -&i2c2 {
> -	status =3D "okay";
> -
> -	gsl1680: touchscreen@40 {
> -		compatible =3D "silead,gsl1680";
> -		reg =3D <0x40>;
> -		interrupt-parent =3D <&gpio3>;
> -		interrupts =3D <RK_PD4 IRQ_TYPE_EDGE_FALLING>;
> -		power-gpios =3D <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> -		touchscreen-size-x =3D <800>;
> -		touchscreen-size-y =3D <1280>;
> -		silead,max-fingers =3D <5>;
> -	};
> -};
> -
> -&pinctrl {
> -	keys {
> -		pwr_key: pwr-key {
> -			rockchip,pins =3D <0 RK_PA2 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_sleep: pmic-sleep {
> -			rockchip,pins =3D <0 RK_PA0 2 &pcfg_pull_none>;
> -		};
> -
> -		pmic_int: pmic-int {
> -			rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO =
&pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&sdmmc {
> -	status =3D "okay";
> -	bus-width =3D <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	card-detect-delay =3D <200>;
> -	no-sdio;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_bus4>, =
<&sdmmc_cd>;
> -	rockchip,default-sample-phase =3D <90>;
> -	vmmc-supply =3D <&vcc_sd>;
> -	vqmmc-supply =3D <&vccio_sd>;
> -};
> -
> -&tsadc {
> -	status =3D "okay";
> -	rockchip,hw-tshut-mode =3D <0>; /* CRU */
> -	rockchip,hw-tshut-polarity =3D <1>; /* high */
> -};
> -
> -&uart4 {
> -	status =3D "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status =3D "okay";
> -};
> -
> -&usb_otg {
> -	status =3D "okay";
> -};
> -
> -&wdt {
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rk3368-u-boot.dtsi =
b/arch/arm/dts/rk3368-u-boot.dtsi
> index 811d59ac346e..16c434b944da 100644
> --- a/arch/arm/dts/rk3368-u-boot.dtsi
> +++ b/arch/arm/dts/rk3368-u-boot.dtsi
> @@ -26,3 +26,7 @@
> 		reg =3D <0x0 0xff740000 0x0 0x1000>;
> 	};
> };
> +
> +&xin24m {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/rk3368.dtsi b/arch/arm/dts/rk3368.dtsi
> deleted file mode 100644
> index 4c64fbefb483..000000000000
> --- a/arch/arm/dts/rk3368.dtsi
> +++ /dev/null
> @@ -1,1218 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2015 Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/clock/rk3368-cru.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/soc/rockchip,boot-mode.h>
> -#include <dt-bindings/thermal/thermal.h>
> -
> -/ {
> -	compatible =3D "rockchip,rk3368";
> -	interrupt-parent =3D <&gic>;
> -	#address-cells =3D <2>;
> -	#size-cells =3D <2>;
> -
> -	aliases {
> -		ethernet0 =3D &gmac;
> -		i2c0 =3D &i2c0;
> -		i2c1 =3D &i2c1;
> -		i2c2 =3D &i2c2;
> -		i2c3 =3D &i2c3;
> -		i2c4 =3D &i2c4;
> -		i2c5 =3D &i2c5;
> -		serial0 =3D &uart0;
> -		serial1 =3D &uart1;
> -		serial2 =3D &uart2;
> -		serial3 =3D &uart3;
> -		serial4 =3D &uart4;
> -		spi0 =3D &spi0;
> -		spi1 =3D &spi1;
> -		spi2 =3D &spi2;
> -	};
> -
> -	cpus {
> -		#address-cells =3D <0x2>;
> -		#size-cells =3D <0x0>;
> -
> -		cpu-map {
> -			cluster0 {
> -				core0 {
> -					cpu =3D <&cpu_b0>;
> -				};
> -				core1 {
> -					cpu =3D <&cpu_b1>;
> -				};
> -				core2 {
> -					cpu =3D <&cpu_b2>;
> -				};
> -				core3 {
> -					cpu =3D <&cpu_b3>;
> -				};
> -			};
> -
> -			cluster1 {
> -				core0 {
> -					cpu =3D <&cpu_l0>;
> -				};
> -				core1 {
> -					cpu =3D <&cpu_l1>;
> -				};
> -				core2 {
> -					cpu =3D <&cpu_l2>;
> -				};
> -				core3 {
> -					cpu =3D <&cpu_l3>;
> -				};
> -			};
> -		};
> -
> -		cpu_l0: cpu@0 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x0>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_l1: cpu@1 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x1>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_l2: cpu@2 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x2>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_l3: cpu@3 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x3>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_b0: cpu@100 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x100>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_b1: cpu@101 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x101>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_b2: cpu@102 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x102>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -
> -		cpu_b3: cpu@103 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a53";
> -			reg =3D <0x0 0x103>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -		};
> -	};
> -
> -	arm-pmu {
> -		compatible =3D "arm,armv8-pmuv3";
> -		interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-affinity =3D <&cpu_l0>, <&cpu_l1>, <&cpu_l2>,
> -				     <&cpu_l3>, <&cpu_b0>, <&cpu_b1>,
> -				     <&cpu_b2>, <&cpu_b3>;
> -	};
> -
> -	psci {
> -		compatible =3D "arm,psci-0.2";
> -		method =3D "smc";
> -	};
> -
> -	timer {
> -		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <GIC_PPI 13
> -			(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 14
> -			(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 11
> -			(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 10
> -			(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> -	};
> -
> -	xin24m: oscillator {
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <24000000>;
> -		clock-output-names =3D "xin24m";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	sdmmc: mmc@ff0c0000 {
> -		compatible =3D "rockchip,rk3368-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x0 0xff0c0000 0x0 0x4000>;
> -		max-frequency =3D <150000000>;
> -		clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> -			 <&cru SCLK_SDMMC_DRV>, <&cru =
SCLK_SDMMC_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth =3D <0x100>;
> -		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		resets =3D <&cru SRST_MMC0>;
> -		reset-names =3D "reset";
> -		status =3D "disabled";
> -	};
> -
> -	sdio0: mmc@ff0d0000 {
> -		compatible =3D "rockchip,rk3368-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x0 0xff0d0000 0x0 0x4000>;
> -		max-frequency =3D <150000000>;
> -		clocks =3D <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
> -			 <&cru SCLK_SDIO0_DRV>, <&cru =
SCLK_SDIO0_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth =3D <0x100>;
> -		interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -		resets =3D <&cru SRST_SDIO0>;
> -		reset-names =3D "reset";
> -		status =3D "disabled";
> -	};
> -
> -	emmc: mmc@ff0f0000 {
> -		compatible =3D "rockchip,rk3368-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x0 0xff0f0000 0x0 0x4000>;
> -		max-frequency =3D <150000000>;
> -		clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> -			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth =3D <0x100>;
> -		interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -		resets =3D <&cru SRST_EMMC>;
> -		reset-names =3D "reset";
> -		status =3D "disabled";
> -	};
> -
> -	saradc: saradc@ff100000 {
> -		compatible =3D "rockchip,saradc";
> -		reg =3D <0x0 0xff100000 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -		#io-channel-cells =3D <1>;
> -		clocks =3D <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> -		clock-names =3D "saradc", "apb_pclk";
> -		resets =3D <&cru SRST_SARADC>;
> -		reset-names =3D "saradc-apb";
> -		status =3D "disabled";
> -	};
> -
> -	spi0: spi@ff110000 {
> -		compatible =3D "rockchip,rk3368-spi", =
"rockchip,rk3066-spi";
> -		reg =3D <0x0 0xff110000 0x0 0x1000>;
> -		clocks =3D <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names =3D "spiclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	spi1: spi@ff120000 {
> -		compatible =3D "rockchip,rk3368-spi", =
"rockchip,rk3066-spi";
> -		reg =3D <0x0 0xff120000 0x0 0x1000>;
> -		clocks =3D <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
> -		clock-names =3D "spiclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	spi2: spi@ff130000 {
> -		compatible =3D "rockchip,rk3368-spi", =
"rockchip,rk3066-spi";
> -		reg =3D <0x0 0xff130000 0x0 0x1000>;
> -		clocks =3D <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
> -		clock-names =3D "spiclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c2: i2c@ff140000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff140000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C2>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c2_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c3: i2c@ff150000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff150000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C3>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c3_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c4: i2c@ff160000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff160000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C4>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c4_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c5: i2c@ff170000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff170000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C5>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c5_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	uart0: serial@ff180000 {
> -		compatible =3D "rockchip,rk3368-uart", =
"snps,dw-apb-uart";
> -		reg =3D <0x0 0xff180000 0x0 0x100>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	uart1: serial@ff190000 {
> -		compatible =3D "rockchip,rk3368-uart", =
"snps,dw-apb-uart";
> -		reg =3D <0x0 0xff190000 0x0 0x100>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	uart3: serial@ff1b0000 {
> -		compatible =3D "rockchip,rk3368-uart", =
"snps,dw-apb-uart";
> -		reg =3D <0x0 0xff1b0000 0x0 0x100>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	uart4: serial@ff1c0000 {
> -		compatible =3D "rockchip,rk3368-uart", =
"snps,dw-apb-uart";
> -		reg =3D <0x0 0xff1c0000 0x0 0x100>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART4>, <&cru PCLK_UART4>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	dmac_peri: dma-controller@ff250000 {
> -		compatible =3D "arm,pl330", "arm,primecell";
> -		reg =3D <0x0 0xff250000 0x0 0x4000>;
> -		interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells =3D <1>;
> -		arm,pl330-broken-no-flushp;
> -		arm,pl330-periph-burst;
> -		clocks =3D <&cru ACLK_DMAC_PERI>;
> -		clock-names =3D "apb_pclk";
> -	};
> -
> -	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> -			polling-delay-passive =3D <100>; /* milliseconds =
*/
> -			polling-delay =3D <5000>; /* milliseconds */
> -
> -			thermal-sensors =3D <&tsadc 0>;
> -
> -			trips {
> -				cpu_alert0: cpu_alert0 {
> -					temperature =3D <75000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "passive";
> -				};
> -				cpu_alert1: cpu_alert1 {
> -					temperature =3D <80000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "passive";
> -				};
> -				cpu_crit: cpu_crit {
> -					temperature =3D <95000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&cpu_alert0>;
> -					cooling-device =3D
> -					<&cpu_b0 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b2 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b3 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip =3D <&cpu_alert1>;
> -					cooling-device =3D
> -					<&cpu_l0 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_l1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_l2 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_l3 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -
> -		gpu_thermal: gpu-thermal {
> -			polling-delay-passive =3D <100>; /* milliseconds =
*/
> -			polling-delay =3D <5000>; /* milliseconds */
> -
> -			thermal-sensors =3D <&tsadc 1>;
> -
> -			trips {
> -				gpu_alert0: gpu_alert0 {
> -					temperature =3D <80000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "passive";
> -				};
> -				gpu_crit: gpu_crit {
> -					temperature =3D <115000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&gpu_alert0>;
> -					cooling-device =3D
> -					<&cpu_b0 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b2 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -					<&cpu_b3 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -	};
> -
> -	tsadc: tsadc@ff280000 {
> -		compatible =3D "rockchip,rk3368-tsadc";
> -		reg =3D <0x0 0xff280000 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> -		clock-names =3D "tsadc", "apb_pclk";
> -		resets =3D <&cru SRST_TSADC>;
> -		reset-names =3D "tsadc-apb";
> -		pinctrl-names =3D "init", "default", "sleep";
> -		pinctrl-0 =3D <&otp_pin>;
> -		pinctrl-1 =3D <&otp_out>;
> -		pinctrl-2 =3D <&otp_pin>;
> -		#thermal-sensor-cells =3D <1>;
> -		rockchip,hw-tshut-temp =3D <95000>;
> -		status =3D "disabled";
> -	};
> -
> -	gmac: ethernet@ff290000 {
> -		compatible =3D "rockchip,rk3368-gmac";
> -		reg =3D <0x0 0xff290000 0x0 0x10000>;
> -		interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "macirq";
> -		rockchip,grf =3D <&grf>;
> -		clocks =3D <&cru SCLK_MAC>,
> -			<&cru SCLK_MAC_RX>, <&cru SCLK_MAC_TX>,
> -			<&cru SCLK_MACREF>, <&cru SCLK_MACREF_OUT>,
> -			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>;
> -		clock-names =3D "stmmaceth",
> -			"mac_clk_rx", "mac_clk_tx",
> -			"clk_mac_ref", "clk_mac_refout",
> -			"aclk_mac", "pclk_mac";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host0_ehci: usb@ff500000 {
> -		compatible =3D "generic-ehci";
> -		reg =3D <0x0 0xff500000 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST0>;
> -		status =3D "disabled";
> -	};
> -
> -	usb_otg: usb@ff580000 {
> -		compatible =3D "rockchip,rk3368-usb", =
"rockchip,rk3066-usb",
> -				"snps,dwc2";
> -		reg =3D <0x0 0xff580000 0x0 0x40000>;
> -		interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_OTG0>;
> -		clock-names =3D "otg";
> -		dr_mode =3D "otg";
> -		g-np-tx-fifo-size =3D <16>;
> -		g-rx-fifo-size =3D <275>;
> -		g-tx-fifo-size =3D <256 128 128 64 64 32>;
> -		status =3D "disabled";
> -	};
> -
> -	dmac_bus: dma-controller@ff600000 {
> -		compatible =3D "arm,pl330", "arm,primecell";
> -		reg =3D <0x0 0xff600000 0x0 0x4000>;
> -		interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells =3D <1>;
> -		arm,pl330-broken-no-flushp;
> -		arm,pl330-periph-burst;
> -		clocks =3D <&cru ACLK_DMAC_BUS>;
> -		clock-names =3D "apb_pclk";
> -	};
> -
> -	i2c0: i2c@ff650000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff650000 0x0 0x1000>;
> -		clocks =3D <&cru PCLK_I2C0>;
> -		clock-names =3D "i2c";
> -		interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c0_xfer>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c1: i2c@ff660000 {
> -		compatible =3D "rockchip,rk3368-i2c", =
"rockchip,rk3288-i2c";
> -		reg =3D <0x0 0xff660000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C1>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c1_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm0: pwm@ff680000 {
> -		compatible =3D "rockchip,rk3368-pwm", =
"rockchip,rk3288-pwm";
> -		reg =3D <0x0 0xff680000 0x0 0x10>;
> -		#pwm-cells =3D <3>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm0_pin>;
> -		clocks =3D <&cru PCLK_PWM1>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm1: pwm@ff680010 {
> -		compatible =3D "rockchip,rk3368-pwm", =
"rockchip,rk3288-pwm";
> -		reg =3D <0x0 0xff680010 0x0 0x10>;
> -		#pwm-cells =3D <3>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm1_pin>;
> -		clocks =3D <&cru PCLK_PWM1>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm2: pwm@ff680020 {
> -		compatible =3D "rockchip,rk3368-pwm", =
"rockchip,rk3288-pwm";
> -		reg =3D <0x0 0xff680020 0x0 0x10>;
> -		#pwm-cells =3D <3>;
> -		clocks =3D <&cru PCLK_PWM1>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm3: pwm@ff680030 {
> -		compatible =3D "rockchip,rk3368-pwm", =
"rockchip,rk3288-pwm";
> -		reg =3D <0x0 0xff680030 0x0 0x10>;
> -		#pwm-cells =3D <3>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm3_pin>;
> -		clocks =3D <&cru PCLK_PWM1>;
> -		status =3D "disabled";
> -	};
> -
> -	uart2: serial@ff690000 {
> -		compatible =3D "rockchip,rk3368-uart", =
"snps,dw-apb-uart";
> -		reg =3D <0x0 0xff690000 0x0 0x100>;
> -		clocks =3D <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&uart2_xfer>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	mbox: mbox@ff6b0000 {
> -		compatible =3D "rockchip,rk3368-mailbox";
> -		reg =3D <0x0 0xff6b0000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru PCLK_MAILBOX>;
> -		clock-names =3D "pclk_mailbox";
> -		#mbox-cells =3D <1>;
> -		status =3D "disabled";
> -	};
> -
> -	pmugrf: syscon@ff738000 {
> -		compatible =3D "rockchip,rk3368-pmugrf", "syscon", =
"simple-mfd";
> -		reg =3D <0x0 0xff738000 0x0 0x1000>;
> -
> -		pmu_io_domains: io-domains {
> -			compatible =3D =
"rockchip,rk3368-pmu-io-voltage-domain";
> -			status =3D "disabled";
> -		};
> -
> -		reboot-mode {
> -			compatible =3D "syscon-reboot-mode";
> -			offset =3D <0x200>;
> -			mode-normal =3D <BOOT_NORMAL>;
> -			mode-recovery =3D <BOOT_RECOVERY>;
> -			mode-bootloader =3D <BOOT_FASTBOOT>;
> -			mode-loader =3D <BOOT_BL_DOWNLOAD>;
> -		};
> -	};
> -
> -	cru: clock-controller@ff760000 {
> -		compatible =3D "rockchip,rk3368-cru";
> -		reg =3D <0x0 0xff760000 0x0 0x1000>;
> -		rockchip,grf =3D <&grf>;
> -		#clock-cells =3D <1>;
> -		#reset-cells =3D <1>;
> -	};
> -
> -	grf: syscon@ff770000 {
> -		compatible =3D "rockchip,rk3368-grf", "syscon", =
"simple-mfd";
> -		reg =3D <0x0 0xff770000 0x0 0x1000>;
> -
> -		io_domains: io-domains {
> -			compatible =3D =
"rockchip,rk3368-io-voltage-domain";
> -			status =3D "disabled";
> -		};
> -	};
> -
> -	wdt: watchdog@ff800000 {
> -		compatible =3D "rockchip,rk3368-wdt", "snps,dw-wdt";
> -		reg =3D <0x0 0xff800000 0x0 0x100>;
> -		clocks =3D <&cru PCLK_WDT>;
> -		interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -		status =3D "disabled";
> -	};
> -
> -	timer0: timer@ff810000 {
> -		compatible =3D "rockchip,rk3368-timer", =
"rockchip,rk3288-timer";
> -		reg =3D <0x0 0xff810000 0x0 0x20>;
> -		interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru PCLK_TIMER0>, <&cru SCLK_TIMER00>;
> -		clock-names =3D "pclk", "timer";
> -	};
> -
> -	spdif: spdif@ff880000 {
> -		compatible =3D "rockchip,rk3368-spdif";
> -		reg =3D <0x0 0xff880000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
> -		clock-names =3D "mclk", "hclk";
> -		dmas =3D <&dmac_bus 3>;
> -		dma-names =3D "tx";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spdif_tx>;
> -		status =3D "disabled";
> -	};
> -
> -	i2s_2ch: i2s-2ch@ff890000 {
> -		compatible =3D "rockchip,rk3368-i2s", =
"rockchip,rk3066-i2s";
> -		reg =3D <0x0 0xff890000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names =3D "i2s_clk", "i2s_hclk";
> -		clocks =3D <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
> -		dmas =3D <&dmac_bus 6>, <&dmac_bus 7>;
> -		dma-names =3D "tx", "rx";
> -		status =3D "disabled";
> -	};
> -
> -	i2s_8ch: i2s-8ch@ff898000 {
> -		compatible =3D "rockchip,rk3368-i2s", =
"rockchip,rk3066-i2s";
> -		reg =3D <0x0 0xff898000 0x0 0x1000>;
> -		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names =3D "i2s_clk", "i2s_hclk";
> -		clocks =3D <&cru SCLK_I2S_8CH>, <&cru HCLK_I2S_8CH>;
> -		dmas =3D <&dmac_bus 0>, <&dmac_bus 1>;
> -		dma-names =3D "tx", "rx";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2s_8ch_bus>;
> -		status =3D "disabled";
> -	};
> -
> -	iep_mmu: iommu@ff900800 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x0 0xff900800 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "iep_mmu";
> -		clocks =3D <&cru ACLK_IEP>, <&cru HCLK_IEP>;
> -		clock-names =3D "aclk", "iface";
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	isp_mmu: iommu@ff914000 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x0 0xff914000 0x0 0x100>,
> -		      <0x0 0xff915000 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "isp_mmu";
> -		clocks =3D <&cru ACLK_ISP>, <&cru HCLK_ISP>;
> -		clock-names =3D "aclk", "iface";
> -		#iommu-cells =3D <0>;
> -		rockchip,disable-mmu-reset;
> -		status =3D "disabled";
> -	};
> -
> -	vop_mmu: iommu@ff930300 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x0 0xff930300 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "vop_mmu";
> -		clocks =3D <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> -		clock-names =3D "aclk", "iface";
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	hevc_mmu: iommu@ff9a0440 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x0 0xff9a0440 0x0 0x40>,
> -		      <0x0 0xff9a0480 0x0 0x40>;
> -		interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "hevc_mmu";
> -		clocks =3D <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
> -		clock-names =3D "aclk", "iface";
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	vpu_mmu: iommu@ff9a0800 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x0 0xff9a0800 0x0 0x100>;
> -		interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "vepu_mmu", "vdpu_mmu";
> -		clocks =3D <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
> -		clock-names =3D "aclk", "iface";
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	efuse256: efuse@ffb00000 {
> -		compatible =3D "rockchip,rk3368-efuse";
> -		reg =3D <0x0 0xffb00000 0x0 0x20>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		clocks =3D <&cru PCLK_EFUSE256>;
> -		clock-names =3D "pclk_efuse";
> -
> -		cpu_leakage: cpu-leakage@17 {
> -			reg =3D <0x17 0x1>;
> -		};
> -		temp_adjust: temp-adjust@1f {
> -			reg =3D <0x1f 0x1>;
> -		};
> -	};
> -
> -	gic: interrupt-controller@ffb71000 {
> -		compatible =3D "arm,gic-400";
> -		interrupt-controller;
> -		#interrupt-cells =3D <3>;
> -		#address-cells =3D <0>;
> -
> -		reg =3D <0x0 0xffb71000 0x0 0x1000>,
> -		      <0x0 0xffb72000 0x0 0x2000>,
> -		      <0x0 0xffb74000 0x0 0x2000>,
> -		      <0x0 0xffb76000 0x0 0x2000>;
> -		interrupts =3D <GIC_PPI 9
> -		      (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible =3D "rockchip,rk3368-pinctrl";
> -		rockchip,grf =3D <&grf>;
> -		rockchip,pmu =3D <&pmugrf>;
> -		#address-cells =3D <0x2>;
> -		#size-cells =3D <0x2>;
> -		ranges;
> -
> -		gpio0: gpio0@ff750000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x0 0xff750000 0x0 0x100>;
> -			clocks =3D <&cru PCLK_GPIO0>;
> -			interrupts =3D <GIC_SPI 0x51 =
IRQ_TYPE_LEVEL_HIGH>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <0x2>;
> -		};
> -
> -		gpio1: gpio1@ff780000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x0 0xff780000 0x0 0x100>;
> -			clocks =3D <&cru PCLK_GPIO1>;
> -			interrupts =3D <GIC_SPI 0x52 =
IRQ_TYPE_LEVEL_HIGH>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <0x2>;
> -		};
> -
> -		gpio2: gpio2@ff790000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x0 0xff790000 0x0 0x100>;
> -			clocks =3D <&cru PCLK_GPIO2>;
> -			interrupts =3D <GIC_SPI 0x53 =
IRQ_TYPE_LEVEL_HIGH>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <0x2>;
> -		};
> -
> -		gpio3: gpio3@ff7a0000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x0 0xff7a0000 0x0 0x100>;
> -			clocks =3D <&cru PCLK_GPIO3>;
> -			interrupts =3D <GIC_SPI 0x54 =
IRQ_TYPE_LEVEL_HIGH>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <0x2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <0x2>;
> -		};
> -
> -		pcfg_pull_up: pcfg-pull-up {
> -			bias-pull-up;
> -		};
> -
> -		pcfg_pull_down: pcfg-pull-down {
> -			bias-pull-down;
> -		};
> -
> -		pcfg_pull_none: pcfg-pull-none {
> -			bias-disable;
> -		};
> -
> -		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
> -			bias-disable;
> -			drive-strength =3D <12>;
> -		};
> -
> -		emmc {
> -			emmc_clk: emmc-clk {
> -				rockchip,pins =3D <2 RK_PA4 2 =
&pcfg_pull_none>;
> -			};
> -
> -			emmc_cmd: emmc-cmd {
> -				rockchip,pins =3D <1 RK_PD2 2 =
&pcfg_pull_up>;
> -			};
> -
> -			emmc_pwr: emmc-pwr {
> -				rockchip,pins =3D <1 RK_PD3 2 =
&pcfg_pull_up>;
> -			};
> -
> -			emmc_bus1: emmc-bus1 {
> -				rockchip,pins =3D <1 RK_PC2 2 =
&pcfg_pull_up>;
> -			};
> -
> -			emmc_bus4: emmc-bus4 {
> -				rockchip,pins =3D <1 RK_PC2 2 =
&pcfg_pull_up>,
> -						<1 RK_PC3 2 =
&pcfg_pull_up>,
> -						<1 RK_PC4 2 =
&pcfg_pull_up>,
> -						<1 RK_PC5 2 =
&pcfg_pull_up>;
> -			};
> -
> -			emmc_bus8: emmc-bus8 {
> -				rockchip,pins =3D <1 RK_PC2 2 =
&pcfg_pull_up>,
> -						<1 RK_PC3 2 =
&pcfg_pull_up>,
> -						<1 RK_PC4 2 =
&pcfg_pull_up>,
> -						<1 RK_PC5 2 =
&pcfg_pull_up>,
> -						<1 RK_PC6 2 =
&pcfg_pull_up>,
> -						<1 RK_PC7 2 =
&pcfg_pull_up>,
> -						<1 RK_PD0 2 =
&pcfg_pull_up>,
> -						<1 RK_PD1 2 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		gmac {
> -			rgmii_pins: rgmii-pins {
> -				rockchip,pins =3D	<3 RK_PC6 1 =
&pcfg_pull_none>,
> -						<3 RK_PD0 1 =
&pcfg_pull_none>,
> -						<3 RK_PC3 1 =
&pcfg_pull_none>,
> -						<3 RK_PB0 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB1 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB2 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB6 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PD4 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB5 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB7 1 =
&pcfg_pull_none>,
> -						<3 RK_PC0 1 =
&pcfg_pull_none>,
> -						<3 RK_PC1 1 =
&pcfg_pull_none>,
> -						<3 RK_PC2 1 =
&pcfg_pull_none>,
> -						<3 RK_PD1 1 =
&pcfg_pull_none>,
> -						<3 RK_PC4 1 =
&pcfg_pull_none>;
> -			};
> -
> -			rmii_pins: rmii-pins {
> -				rockchip,pins =3D	<3 RK_PC6 1 =
&pcfg_pull_none>,
> -						<3 RK_PD0 1 =
&pcfg_pull_none>,
> -						<3 RK_PC3 1 =
&pcfg_pull_none>,
> -						<3 RK_PB0 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB1 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB5 1 =
&pcfg_pull_none_12ma>,
> -						<3 RK_PB7 1 =
&pcfg_pull_none>,
> -						<3 RK_PC0 1 =
&pcfg_pull_none>,
> -						<3 RK_PC4 1 =
&pcfg_pull_none>,
> -						<3 RK_PC5 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c0 {
> -			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins =3D <0 RK_PA6 1 =
&pcfg_pull_none>,
> -						<0 RK_PA7 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c1 {
> -			i2c1_xfer: i2c1-xfer {
> -				rockchip,pins =3D <2 RK_PC5 1 =
&pcfg_pull_none>,
> -						<2 RK_PC6 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c2 {
> -			i2c2_xfer: i2c2-xfer {
> -				rockchip,pins =3D <0 RK_PB1 2 =
&pcfg_pull_none>,
> -						<3 RK_PD7 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c3 {
> -			i2c3_xfer: i2c3-xfer {
> -				rockchip,pins =3D <1 RK_PC0 1 =
&pcfg_pull_none>,
> -						<1 RK_PC1 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c4 {
> -			i2c4_xfer: i2c4-xfer {
> -				rockchip,pins =3D <3 RK_PD0 2 =
&pcfg_pull_none>,
> -						<3 RK_PD1 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c5 {
> -			i2c5_xfer: i2c5-xfer {
> -				rockchip,pins =3D <3 RK_PD2 2 =
&pcfg_pull_none>,
> -						<3 RK_PD3 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2s {
> -			i2s_8ch_bus: i2s-8ch-bus {
> -				rockchip,pins =3D <2 RK_PB4 1 =
&pcfg_pull_none>,
> -						<2 RK_PB5 1 =
&pcfg_pull_none>,
> -						<2 RK_PB6 1 =
&pcfg_pull_none>,
> -						<2 RK_PB7 1 =
&pcfg_pull_none>,
> -						<2 RK_PC0 1 =
&pcfg_pull_none>,
> -						<2 RK_PC1 1 =
&pcfg_pull_none>,
> -						<2 RK_PC2 1 =
&pcfg_pull_none>,
> -						<2 RK_PC3 1 =
&pcfg_pull_none>,
> -						<2 RK_PC4 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm0 {
> -			pwm0_pin: pwm0-pin {
> -				rockchip,pins =3D <3 RK_PB0 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm1 {
> -			pwm1_pin: pwm1-pin {
> -				rockchip,pins =3D <0 RK_PB0 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm3 {
> -			pwm3_pin: pwm3-pin {
> -				rockchip,pins =3D <3 RK_PD5 3 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		sdio0 {
> -			sdio0_bus1: sdio0-bus1 {
> -				rockchip,pins =3D <2 RK_PD4 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_bus4: sdio0-bus4 {
> -				rockchip,pins =3D <2 RK_PD4 1 =
&pcfg_pull_up>,
> -						<2 RK_PD5 1 =
&pcfg_pull_up>,
> -						<2 RK_PD6 1 =
&pcfg_pull_up>,
> -						<2 RK_PD7 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_cmd: sdio0-cmd {
> -				rockchip,pins =3D <3 RK_PA0 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_clk: sdio0-clk {
> -				rockchip,pins =3D <3 RK_PA1 1 =
&pcfg_pull_none>;
> -			};
> -
> -			sdio0_cd: sdio0-cd {
> -				rockchip,pins =3D <3 RK_PA2 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_wp: sdio0-wp {
> -				rockchip,pins =3D <3 RK_PA3 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_pwr: sdio0-pwr {
> -				rockchip,pins =3D <3 RK_PA4 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_bkpwr: sdio0-bkpwr {
> -				rockchip,pins =3D <3 RK_PA5 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdio0_int: sdio0-int {
> -				rockchip,pins =3D <3 RK_PA6 1 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		sdmmc {
> -			sdmmc_clk: sdmmc-clk {
> -				rockchip,pins =3D <2 RK_PB1 1 =
&pcfg_pull_none>;
> -			};
> -
> -			sdmmc_cmd: sdmmc-cmd {
> -				rockchip,pins =3D <2 RK_PB2 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdmmc_cd: sdmmc-cd {
> -				rockchip,pins =3D <2 RK_PB3 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdmmc_bus1: sdmmc-bus1 {
> -				rockchip,pins =3D <2 RK_PA5 1 =
&pcfg_pull_up>;
> -			};
> -
> -			sdmmc_bus4: sdmmc-bus4 {
> -				rockchip,pins =3D <2 RK_PA5 1 =
&pcfg_pull_up>,
> -						<2 RK_PA6 1 =
&pcfg_pull_up>,
> -						<2 RK_PA7 1 =
&pcfg_pull_up>,
> -						<2 RK_PB0 1 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		spdif {
> -			spdif_tx: spdif-tx {
> -				rockchip,pins =3D	<2 RK_PC7 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		spi0 {
> -			spi0_clk: spi0-clk {
> -				rockchip,pins =3D <1 RK_PD5 2 =
&pcfg_pull_up>;
> -			};
> -			spi0_cs0: spi0-cs0 {
> -				rockchip,pins =3D <1 RK_PD0 3 =
&pcfg_pull_up>;
> -			};
> -			spi0_cs1: spi0-cs1 {
> -				rockchip,pins =3D <1 RK_PD1 3 =
&pcfg_pull_up>;
> -			};
> -			spi0_tx: spi0-tx {
> -				rockchip,pins =3D <1 RK_PC7 3 =
&pcfg_pull_up>;
> -			};
> -			spi0_rx: spi0-rx {
> -				rockchip,pins =3D <1 RK_PC6 3 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi1 {
> -			spi1_clk: spi1-clk {
> -				rockchip,pins =3D <1 RK_PB6 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_cs0: spi1-cs0 {
> -				rockchip,pins =3D <1 RK_PB7 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_cs1: spi1-cs1 {
> -				rockchip,pins =3D <3 RK_PD4 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_rx: spi1-rx {
> -				rockchip,pins =3D <1 RK_PC0 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_tx: spi1-tx {
> -				rockchip,pins =3D <1 RK_PC1 2 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi2 {
> -			spi2_clk: spi2-clk {
> -				rockchip,pins =3D <0 RK_PB4 2 =
&pcfg_pull_up>;
> -			};
> -			spi2_cs0: spi2-cs0 {
> -				rockchip,pins =3D <0 RK_PB5 2 =
&pcfg_pull_up>;
> -			};
> -			spi2_rx: spi2-rx {
> -				rockchip,pins =3D <0 RK_PB2 2 =
&pcfg_pull_up>;
> -			};
> -			spi2_tx: spi2-tx {
> -				rockchip,pins =3D <0 RK_PB3 2 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		tsadc {
> -			otp_pin: otp-pin {
> -				rockchip,pins =3D <0 RK_PA3 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -			};
> -
> -			otp_out: otp-out {
> -				rockchip,pins =3D <0 RK_PA3 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart0 {
> -			uart0_xfer: uart0-xfer {
> -				rockchip,pins =3D <2 RK_PD0 1 =
&pcfg_pull_up>,
> -						<2 RK_PD1 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart0_cts: uart0-cts {
> -				rockchip,pins =3D <2 RK_PD2 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart0_rts: uart0-rts {
> -				rockchip,pins =3D <2 RK_PD3 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart1 {
> -			uart1_xfer: uart1-xfer {
> -				rockchip,pins =3D <0 RK_PC4 3 =
&pcfg_pull_up>,
> -						<0 RK_PC5 3 =
&pcfg_pull_none>;
> -			};
> -
> -			uart1_cts: uart1-cts {
> -				rockchip,pins =3D <0 RK_PC6 3 =
&pcfg_pull_none>;
> -			};
> -
> -			uart1_rts: uart1-rts {
> -				rockchip,pins =3D <0 RK_PC7 3 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2 {
> -			uart2_xfer: uart2-xfer {
> -				rockchip,pins =3D <2 RK_PA6 2 =
&pcfg_pull_up>,
> -						<2 RK_PA5 2 =
&pcfg_pull_none>;
> -			};
> -			/* no rts / cts for uart2 */
> -		};
> -
> -		uart3 {
> -			uart3_xfer: uart3-xfer {
> -				rockchip,pins =3D <3 RK_PD5 2 =
&pcfg_pull_up>,
> -						<3 RK_PD6 3 =
&pcfg_pull_none>;
> -			};
> -
> -			uart3_cts: uart3-cts {
> -				rockchip,pins =3D <3 RK_PC0 2 =
&pcfg_pull_none>;
> -			};
> -
> -			uart3_rts: uart3-rts {
> -				rockchip,pins =3D <3 RK_PC1 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart4 {
> -			uart4_xfer: uart4-xfer {
> -				rockchip,pins =3D <0 RK_PD3 3 =
&pcfg_pull_up>,
> -						<0 RK_PD2 3 =
&pcfg_pull_none>;
> -			};
> -
> -			uart4_cts: uart4-cts {
> -				rockchip,pins =3D <0 RK_PD0 3 =
&pcfg_pull_none>;
> -			};
> -
> -			uart4_rts: uart4-rts {
> -				rockchip,pins =3D <0 RK_PD1 3 =
&pcfg_pull_none>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/mach-rockchip/Kconfig =
b/arch/arm/mach-rockchip/Kconfig
> index d92fcae2bb56..1cb19f2c909e 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -233,6 +233,7 @@ config ROCKCHIP_RK3368
> 	select SUPPORT_SPL
> 	select SUPPORT_TPL
> 	select TPL_HAVE_INIT_STACK if TPL
> +	imply OF_UPSTREAM
> 	imply ROCKCHIP_COMMON_BOARD
> 	imply SPL_ROCKCHIP_COMMON_BOARD
> 	imply SPL_SEPARATE_BSS
> diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
> index aac352113699..41564e484fb9 100644
> --- a/configs/evb-px5_defconfig
> +++ b/configs/evb-px5_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=3D1
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> CONFIG_ENV_OFFSET=3D0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3368-px5-evb"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3368-px5-evb"
> CONFIG_DM_RESET=3Dy
> CONFIG_ROCKCHIP_RK3368=3Dy
> CONFIG_TPL_LDSCRIPT=3D"arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
> diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
> index 42b5c0c38a88..c2fd98d43e52 100644
> --- a/configs/geekbox_defconfig
> +++ b/configs/geekbox_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x1000
> CONFIG_NR_DRAM_BANKS=3D1
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3368-geekbox"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3368-geekbox"
> CONFIG_ROCKCHIP_RK3368=3Dy
> CONFIG_TARGET_GEEKBOX=3Dy
> CONFIG_SYS_LOAD_ADDR=3D0x800800
> --
> 2.39.5
>=20
>=20
>=20

