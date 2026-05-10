Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3518CD3427
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 12:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA988470B;
	Sun, 10 May 2026 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RY857EWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A2E846FD; Sun, 10 May 2026 14:28:30 +0200 (CEST)
Received: from mail-m17221.xmail.ntesmail.com (mail-m17221.xmail.ntesmail.com
 [45.195.17.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877FF8470B
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 14:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.249])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3dd2090eb;
 Sun, 10 May 2026 20:28:18 +0800 (GMT+08:00)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 3/5] rockchip: Remove rk3368-sheep board
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <6249d635-512c-4e66-893a-dcc5834cae86@gmail.com>
Date: Sun, 10 May 2026 20:28:08 +0800
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, =?utf-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>,
 u-boot@lists.denx.de, quentin.schulz@cherry.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <C16CA1F5-F013-4491-A745-F51AA338C10D@rock-chips.com>
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
 <6249d635-512c-4e66-893a-dcc5834cae86@gmail.com>
To: Johan Jonker <jbx6244@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-HM-Tid: 0a9e11dc1bdb03afkunm28104962539780
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUoaVh8aH0pDQhkZSx4eTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVJT0JZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=RY857EWplj9qYmpKSA7gTx1qoypnczWeCIylQro1kWFrrSKvpSvj98xd8O8mxXagsoAd9b6rHNDrImThUU5KMdQkPIugvnbWkYacJlWC+NwiHmuFAEbRb8dX0AM7cHpIiqidwNfkWTLHwx1W3uy9zQwTd+HwvkGX/bG14PtddZ0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=D4TlphWEbtuDhW6hWFk7UElFxYNcOu93XrsyuW05hz8=;
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
> Remove rk3368-sheep board due lack of upstream support.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>=20
> Changed V2:
> removal in a separate patch
> remove README links
> ---
> arch/arm/dts/Makefile                   |   1 -
> arch/arm/dts/rk3368-sheep-u-boot.dtsi   |  35 ---
> arch/arm/dts/rk3368-sheep.dts           | 286 ------------------------
> arch/arm/mach-rockchip/rk3368/Kconfig   |   7 -
> board/geekbuying/geekbox/README         |   1 -
> board/rockchip/evb_px5/README           |   1 -
> board/rockchip/sheep_rk3368/Kconfig     |  12 -
> board/rockchip/sheep_rk3368/MAINTAINERS |   6 -
> board/rockchip/sheep_rk3368/README      |  44 ----
> configs/sheep-rk3368_defconfig          |  32 ---
> doc/board/rockchip/rockchip.rst         |   1 -
> include/configs/sheep_rk3368.h          |  15 --
> 12 files changed, 441 deletions(-)
> delete mode 100644 arch/arm/dts/rk3368-sheep-u-boot.dtsi
> delete mode 100644 arch/arm/dts/rk3368-sheep.dts
> delete mode 100644 board/geekbuying/geekbox/README
> delete mode 100644 board/rockchip/evb_px5/README
> delete mode 100644 board/rockchip/sheep_rk3368/Kconfig
> delete mode 100644 board/rockchip/sheep_rk3368/MAINTAINERS
> delete mode 100644 board/rockchip/sheep_rk3368/README
> delete mode 100644 configs/sheep-rk3368_defconfig
> delete mode 100644 include/configs/sheep_rk3368.h
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 7b2847804835..39ab188c5435 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -53,7 +53,6 @@ dtb-$(CONFIG_MACH_S700) +=3D \
> 	s700-cubieboard7.dtb
>=20
> dtb-$(CONFIG_ROCKCHIP_RK3368) +=3D \
> -	rk3368-sheep.dtb \
> 	rk3368-geekbox.dtb \
> 	rk3368-px5-evb.dtb \
>=20
> diff --git a/arch/arm/dts/rk3368-sheep-u-boot.dtsi =
b/arch/arm/dts/rk3368-sheep-u-boot.dtsi
> deleted file mode 100644
> index cfc8b9340a8f..000000000000
> --- a/arch/arm/dts/rk3368-sheep-u-boot.dtsi
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR X11
> -/*
> - * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
> - */
> -
> -#include "rk3368-u-boot.dtsi"
> -
> -&pinctrl {
> -	bootph-all;
> -};
> -
> -&service_msch {
> -	bootph-all;
> -};
> -
> -&dmc {
> -	bootph-all;
> -	status =3D "okay";
> -};
> -
> -&pmugrf {
> -	bootph-all;
> -};
> -
> -&cru {
> -	bootph-all;
> -};
> -
> -&grf {
> -	bootph-all;
> -};
> -
> -&uart2 {
> -	bootph-all;
> -};
> diff --git a/arch/arm/dts/rk3368-sheep.dts =
b/arch/arm/dts/rk3368-sheep.dts
> deleted file mode 100644
> index 120dec1a3de9..000000000000
> --- a/arch/arm/dts/rk3368-sheep.dts
> +++ /dev/null
> @@ -1,286 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2017 Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include "rk3368.dtsi"
> -#include <dt-bindings/input/input.h>
> -
> -/ {
> -	model =3D "Rockchip sheep board";
> -	compatible =3D "rockchip,sheep", "rockchip,rk3368";
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
> -		gpios =3D <&gpio3 30 GPIO_ACTIVE_LOW>;
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
> -			gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
> -			label =3D "GPIO Power";
> -			linux,code =3D <KEY_POWER>;
> -			wakeup-source;
> -		};
> -	};
> -
> -	leds: gpio-leds {
> -		compatible =3D "gpio-leds";
> -
> -		blue {
> -			gpios =3D <&gpio2 2 GPIO_ACTIVE_HIGH>;
> -			label =3D "geekbox:blue:led";
> -			default-state =3D "on";
> -		};
> -
> -		red {
> -			gpios =3D <&gpio2 3 GPIO_ACTIVE_HIGH>;
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
> -	disable-wp;
> -	keep-power-in-suspend;
> -	non-removable;
> -	num-slots =3D <1>;
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
> -		interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
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
> -				regulator-always-on;
> -				regulator-boot-on;
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
> -			rockchip,pins =3D <3 30 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -
> -	keys {
> -		pwr_key: pwr-key {
> -			rockchip,pins =3D <0 2 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_sleep: pmic-sleep {
> -			rockchip,pins =3D <0 0 RK_FUNC_2 =
&pcfg_pull_none>;
> -		};
> -
> -		pmic_int: pmic-int {
> -			rockchip,pins =3D <0 5 RK_FUNC_GPIO =
&pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&saradc {
> -	status =3D "okay";
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
> diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig =
b/arch/arm/mach-rockchip/rk3368/Kconfig
> index a7be30bbd897..4c28d26d4607 100644
> --- a/arch/arm/mach-rockchip/rk3368/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3368/Kconfig
> @@ -3,12 +3,6 @@ if ROCKCHIP_RK3368
> choice
> 	prompt "RK3368 board"
>=20
> -config TARGET_SHEEP
> -	bool "Sheep board"
> -	help
> -	  Sheep board is designed by Rockchip as a EVB board
> -	  for rk3368.
> -
> config TARGET_GEEKBOX
> 	bool "GeekBox"
>=20
> @@ -41,7 +35,6 @@ config SPL_LIBCOMMON_SUPPORT
> config SPL_LIBGENERIC_SUPPORT
> 	default y
>=20
> -source "board/rockchip/sheep_rk3368/Kconfig"
> source "board/geekbuying/geekbox/Kconfig"
> source "board/rockchip/evb_px5/Kconfig"
>=20
> diff --git a/board/geekbuying/geekbox/README =
b/board/geekbuying/geekbox/README
> deleted file mode 100644
> index de980f2f2337..000000000000
> --- a/board/geekbuying/geekbox/README
> +++ /dev/null
> @@ -1 +0,0 @@
> -see board/rockchip/sheep_rk3368/README
> diff --git a/board/rockchip/evb_px5/README =
b/board/rockchip/evb_px5/README
> deleted file mode 100644
> index de980f2f2337..000000000000
> --- a/board/rockchip/evb_px5/README
> +++ /dev/null
> @@ -1 +0,0 @@
> -see board/rockchip/sheep_rk3368/README
> diff --git a/board/rockchip/sheep_rk3368/Kconfig =
b/board/rockchip/sheep_rk3368/Kconfig
> deleted file mode 100644
> index 321bf814859a..000000000000
> --- a/board/rockchip/sheep_rk3368/Kconfig
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -if TARGET_SHEEP
> -
> -config SYS_BOARD
> -	default "sheep_rk3368"
> -
> -config SYS_VENDOR
> -	default "rockchip"
> -
> -config SYS_CONFIG_NAME
> -	default "sheep_rk3368"
> -
> -endif
> diff --git a/board/rockchip/sheep_rk3368/MAINTAINERS =
b/board/rockchip/sheep_rk3368/MAINTAINERS
> deleted file mode 100644
> index cd5de9923e02..000000000000
> --- a/board/rockchip/sheep_rk3368/MAINTAINERS
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -RK3368 Sheep Board
> -M:	Andy Yan <andy.yan@rock-chips.com>
> -S:	Maintained
> -F:	board/rockchip/sheep_rk3368
> -F:	include/configs/sheep_rk3368.h
> -F:	configs/sheep-rk3368_defconfig
> diff --git a/board/rockchip/sheep_rk3368/README =
b/board/rockchip/sheep_rk3368/README
> deleted file mode 100644
> index 2d078cbe5c09..000000000000
> --- a/board/rockchip/sheep_rk3368/README
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Here is the step-by-step to boot to U-Boot on rk3368.
> -
> -Get miniloader and trust.img form rockchip vendor u-boot source code
> =
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -  > git clone  https://github.com/rockchip-linux/u-boot.git =
rockchip-uboot
> -  > cd rockchip-uboot
> -  > make rk3368_defconfig /*chose px5_defconfig if you run a px5 =
platform here*/
> -  > ./mkv8.sh
> -
> -Compile the upstream U-Boot
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -  > cd u-boot
> -  > make CROSS_COMPILE=3Daarch64-linux-gnu- sheep-rk3368_defconfig  =
all
> -
> -Package u-boot for miniloader
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -  > ../rockchip-uboot/tools/loaderimage --pack --uboot u-boot.bin =
u-boot.img
> -
> -Flash the image by rkdeveloptool
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -rkdeveloptool can get from =
https://github.com/rockchip-linux/rkdeveloptool.git
> -
> -Power on(or reset with RESET KEY) with MASKROM KEY preesed, and then:
> -  > rkdeveloptool db ./rockchip-uboot/rk3368_loader_v2.00.256.bin
> -  > rkdeveloptool wl 0x6000 ./rockchip-uboot/trust.img
> -  > rkdeveloptool wl 0x4000 ./u-boot/u-boot.img
> -  > rkdeveloptool RD
> -
> -You should be able to get U-Boot log message from boot console:
> -
> -U-Boot 2017.05-rc3-01094-g9ddd1e8-dirty (May 15 2017 - 15:57:23 =
+0800)
> -
> -Model: Rockchip sheep board
> -DRAM:  2 GiB
> -MMC:   dwmmc@ff0f0000: 0
> -Using default environment
> -
> -In:    serial@ff690000
> -Out:   serial@ff690000
> -Err:   serial@ff690000
> -Net:   Net Initialization Skipped
> -No ethernet found.
> -Hit any key to stop autoboot:  0
> -=3D>
> diff --git a/configs/sheep-rk3368_defconfig =
b/configs/sheep-rk3368_defconfig
> deleted file mode 100644
> index bbaee0f147f8..000000000000
> --- a/configs/sheep-rk3368_defconfig
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -CONFIG_ARM=3Dy
> -CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> -CONFIG_COUNTER_FREQUENCY=3D24000000
> -CONFIG_ARCH_ROCKCHIP=3Dy
> -CONFIG_TEXT_BASE=3D0x00200000
> -CONFIG_NR_DRAM_BANKS=3D1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3368-sheep"
> -CONFIG_ROCKCHIP_RK3368=3Dy
> -CONFIG_SYS_LOAD_ADDR=3D0x800800
> -CONFIG_DEBUG_UART_BASE=3D0xFF1b0000
> -CONFIG_DEBUG_UART_CLOCK=3D24000000
> -CONFIG_DEBUG_UART=3Dy
> -CONFIG_ANDROID_BOOT_IMAGE=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3368-sheep.dtb"
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_CMD_MMC=3Dy
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_REGMAP=3Dy
> -CONFIG_SYSCON=3Dy
> -CONFIG_CLK=3Dy
> -CONFIG_MMC_DW=3Dy
> -CONFIG_MMC_DW_ROCKCHIP=3Dy
> -CONFIG_PINCTRL=3Dy
> -CONFIG_RAM=3Dy
> -CONFIG_DEBUG_UART_SHIFT=3D2
> -CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> -CONFIG_SYS_NS16550_MEM32=3Dy
> -CONFIG_SYSRESET=3Dy
> -CONFIG_ERRNO_STR=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst =
b/doc/board/rockchip/rockchip.rst
> index 141071f528a3..f369f2a8376e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -76,7 +76,6 @@ List of mainline supported Rockchip boards:
> * rk3368
>      - GeekBox (geekbox)
>      - PX5 EVB (evb-px5)
> -     - Rockchip Sheep (sheep-rk3368)
> * rk3399
>      - 96boards RK3399 Ficus (ficus-rk3399)
>      - 96boards Rock960 (rock960-rk3399)
> diff --git a/include/configs/sheep_rk3368.h =
b/include/configs/sheep_rk3368.h
> deleted file mode 100644
> index 08cc4bf356d9..000000000000
> --- a/include/configs/sheep_rk3368.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (c) 2017 Rockchip Electronics Co., Ltd
> - */
> -
> -#ifndef __CONFIGS_PX5_EVB_H
> -#define __CONFIGS_PX5_EVB_H
> -
> -#include <configs/rk3368_common.h>
> -
> -#define KERNEL_LOAD_ADDR		0x280000
> -#define DTB_LOAD_ADDR			0x5600000
> -#define INITRD_LOAD_ADDR		0x5bf0000
> -
> -#endif
> --
> 2.39.5
>=20
>=20
>=20

