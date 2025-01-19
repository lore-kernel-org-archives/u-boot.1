Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCA4C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 19:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA2D800CF;
	Sun, 19 Jan 2025 20:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWRjxp4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D88801CF; Sun, 19 Jan 2025 20:45:49 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D4380085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 20:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so25148475e9.1
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 11:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737315946; x=1737920746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+/6PqMEe0c+IjAsdvPW1fUALhlTJaLi00ZahrdRkOg=;
 b=lWRjxp4p/GBuKkAeA5f0esCynteS0gbnRcrhi5DHh3mKzRAI8Jka6MgqNEPJ2VWKhN
 FGo0QpL59PYeGM1BumCTN8dDHwewqb7XmL15WEmWh6wQwrjcunRlN2CqSNOxv1QbJUW6
 8WiaBaA4qZPT7STXgQfFlo4Jm5K1+UeV8N4e4yuEAJQ7qbej7s1jsCvunVUw/5P2vCH3
 m2c/vKgDdjixfGqKhIApnARs2QM51mNeD/UULX6gNVhUyxZKtwlWsl3J6xIsfhOLNaY3
 ReDdPUS1Cpps/5W1acVEEHM2XVbw5FqUUIIuyyf+oORSjIRy8JBR+0q+uyaW4hTHRWmr
 kDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737315946; x=1737920746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+/6PqMEe0c+IjAsdvPW1fUALhlTJaLi00ZahrdRkOg=;
 b=kU99ydd3/fOMA5++A7I4yveJuVo46Hc18Yo6M4f/yw//HaZ3xRcVw2+WX1ua5CVLNP
 88zHLTnXx/kKg5xgDuzvsedjTQ21KWcDLIy38A4pncOdbLxHebIHQo7DELtzFXK7+qkK
 9ibU1N4+Jl6UZq+kX/IdgxpDUOW04/g33oqqlCoLP26PbLMm7qGFlVIHph1v2o9vfpjC
 2c4xJ7bZ88KA2VS6XkdxSgzEDi7YmHie5vIVMqdmItjLYWy2ZzNHaozMC/cMMACPyyk7
 MHBWH54Z+oGEyEb7VQz9RI7NfhTsE7CXVtdVnKw/6AqH9c/Tqtz/hHngF9Eeab8QMw1+
 6HRA==
X-Gm-Message-State: AOJu0YzQIdykPin9urP5mCC5pDBV2yXZmnN3aRMV+n3wrssaGQ9v4+8I
 AuAHf+90YZzAxp6ne2jArU62TCu+DVYP5H6T2E0/Gwk6wqRGaf1/oftfgw==
X-Gm-Gg: ASbGncvMZeHRZpUSVmzQwS6Tu+OWKDka5yMDHZkSoUfRmNCXQJhL4YkJnd4+rcAmdTQ
 NmoA/jjW0P3AdvtyRRI5jabpxdpzWyYBuPcIW7o0EL4xxma808jx2oJvNWuilRgwxuxZ2yErPMr
 ogKVZEaa9/vRs1w2pu7lSTTvdetN4K9kfmbKm4NFpc2yaL7b7d5V2pE70t1oAGkLozYamI1ywUJ
 VoqxdNe+CGh4Gj+QutZ2m2IphlAJlGK9WmgbJVuoNqvMmMm9pyHGHv13sz8IfsnjtaN9zHZzhU9
 t6/4GcqlCT4Zz5IW6lsdEaUnJ2lidV5J+jjWgDoYIYAJMg==
X-Google-Smtp-Source: AGHT+IHn1m8X1BlyIc4fPbfifW66+qpwmb7B/C+fszbg5FGQeX74vHnlqDNlGK1pF1FLUlnT92FR/g==
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-43891435c37mr88041105e9.24.1737315945639; 
 Sun, 19 Jan 2025 11:45:45 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ab36sm8238959f8f.49.2025.01.19.11.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 11:45:45 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/3] suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
Date: Sun, 19 Jan 2025 20:45:43 +0100
Message-ID: <5850974.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20250119164157.23648-2-andre.przywara@arm.com>
References: <20250119164157.23648-1-andre.przywara@arm.com>
 <20250119164157.23648-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 19. januar 2025 ob 17:41:54 Srednjeevropski standardni =C4=8Da=
s je Andre Przywara napisal(a):
> In contrast to some other Allwinner SoCs, there is no difference between
> the DTs for the Allwinner F1C100/F1C200 SoCs (sunvi) between the U-Boot
> and the Linux kernel repository.
>=20
> Remove the old copies of the F1Cx00 related .dts and .dtsi files, and
> switch the whole suniv SoC over to use OF_UPSTREAM.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/dts/Makefile                        |   2 -
>  arch/arm/dts/suniv-f1c100s-licheepi-nano.dts |  73 ----
>  arch/arm/dts/suniv-f1c100s.dtsi              | 330 -------------------
>  arch/arm/dts/suniv-f1c200s-lctech-pi.dts     |  76 -----
>  arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts |  81 -----
>  arch/arm/mach-sunxi/Kconfig                  |   1 +
>  configs/lctech_pi_f1c200s_defconfig          |   2 +-
>  configs/licheepi_nano_defconfig              |   2 +-
>  8 files changed, 3 insertions(+), 564 deletions(-)
>  delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
>  delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
>  delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
>  delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index aef0425c967..5627daa94db 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -530,8 +530,6 @@ dtb-$(CONFIG_STM32H7) +=3D stm32h743i-disco.dtb \
>  	stm32h743i-eval.dtb \
>  	stm32h750i-art-pi.dtb
> =20
> -dtb-$(CONFIG_MACH_SUNIV) +=3D \
> -	suniv-f1c100s-licheepi-nano.dtb
>  dtb-$(CONFIG_MACH_SUN4I) +=3D \
>  	sun4i-a10-a1000.dtb \
>  	sun4i-a10-ba10-tvbox.dtb \
> diff --git a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/dts/=
suniv-f1c100s-licheepi-nano.dts
> deleted file mode 100644
> index 43896723a99..00000000000
> --- a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> -/*
> - * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
> - */
> -
> -/dts-v1/;
> -#include "suniv-f1c100s.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -
> -/ {
> -	model =3D "Lichee Pi Nano";
> -	compatible =3D "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
> -
> -	aliases {
> -		mmc0 =3D &mmc0;
> -		serial0 =3D &uart0;
> -		spi0 =3D &spi0;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	reg_vcc3v3: vcc3v3 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc3v3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -	};
> -};
> -
> -&mmc0 {
> -	broken-cd;
> -	bus-width =3D <4>;
> -	disable-wp;
> -	status =3D "okay";
> -	vmmc-supply =3D <&reg_vcc3v3>;
> -};
> -
> -&spi0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&spi0_pc_pins>;
> -	status =3D "okay";
> -
> -	flash@0 {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		compatible =3D "winbond,w25q128", "jedec,spi-nor";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <40000000>;
> -	};
> -};
> -
> -&otg_sram {
> -	status =3D "okay";
> -};
> -
> -&uart0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&uart0_pe_pins>;
> -	status =3D "okay";
> -};
> -
> -&usb_otg {
> -	dr_mode =3D "otg";
> -	status =3D "okay";
> -};
> -
> -&usbphy {
> -	usb0_id_det-gpios =3D <&pio 4 2 GPIO_ACTIVE_HIGH>; /* PE2 */
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/dts/suniv-f1c100s.dtsi b/arch/arm/dts/suniv-f1c100s=
=2Edtsi
> deleted file mode 100644
> index 3c61d59ab5f..00000000000
> --- a/arch/arm/dts/suniv-f1c100s.dtsi
> +++ /dev/null
> @@ -1,330 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> -/*
> - * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
> - * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
> - */
> -
> -#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
> -#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> -
> -/ {
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -	interrupt-parent =3D <&intc>;
> -
> -	clocks {
> -		osc24M: clk-24M {
> -			#clock-cells =3D <0>;
> -			compatible =3D "fixed-clock";
> -			clock-frequency =3D <24000000>;
> -			clock-output-names =3D "osc24M";
> -		};
> -
> -		osc32k: clk-32k {
> -			#clock-cells =3D <0>;
> -			compatible =3D "fixed-clock";
> -			clock-frequency =3D <32768>;
> -			clock-output-names =3D "osc32k";
> -		};
> -	};
> -
> -	cpus {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		cpu@0 {
> -			compatible =3D "arm,arm926ej-s";
> -			device_type =3D "cpu";
> -			reg =3D <0x0>;
> -		};
> -	};
> -
> -	soc {
> -		compatible =3D "simple-bus";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		ranges;
> -
> -		sram-controller@1c00000 {
> -			compatible =3D "allwinner,suniv-f1c100s-system-control",
> -				     "allwinner,sun4i-a10-system-control";
> -			reg =3D <0x01c00000 0x30>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -			ranges;
> -
> -			sram_d: sram@10000 {
> -				compatible =3D "mmio-sram";
> -				reg =3D <0x00010000 0x1000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <1>;
> -				ranges =3D <0 0x00010000 0x1000>;
> -
> -				otg_sram: sram-section@0 {
> -					compatible =3D "allwinner,suniv-f1c100s-sram-d",
> -						     "allwinner,sun4i-a10-sram-d";
> -					reg =3D <0x0000 0x1000>;
> -					status =3D "disabled";
> -				};
> -			};
> -		};
> -
> -		spi0: spi@1c05000 {
> -			compatible =3D "allwinner,suniv-f1c100s-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg =3D <0x01c05000 0x1000>;
> -			interrupts =3D <10>;
> -			clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
> -			clock-names =3D "ahb", "mod";
> -			resets =3D <&ccu RST_BUS_SPI0>;
> -			status =3D "disabled";
> -			num-cs =3D <1>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -		};
> -
> -		spi1: spi@1c06000 {
> -			compatible =3D "allwinner,suniv-f1c100s-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg =3D <0x01c06000 0x1000>;
> -			interrupts =3D <11>;
> -			clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
> -			clock-names =3D "ahb", "mod";
> -			resets =3D <&ccu RST_BUS_SPI1>;
> -			status =3D "disabled";
> -			num-cs =3D <1>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -		};
> -
> -		mmc0: mmc@1c0f000 {
> -			compatible =3D "allwinner,suniv-f1c100s-mmc",
> -				     "allwinner,sun7i-a20-mmc";
> -			reg =3D <0x01c0f000 0x1000>;
> -			clocks =3D <&ccu CLK_BUS_MMC0>,
> -				 <&ccu CLK_MMC0>,
> -				 <&ccu CLK_MMC0_OUTPUT>,
> -				 <&ccu CLK_MMC0_SAMPLE>;
> -			clock-names =3D "ahb", "mmc", "output", "sample";
> -			resets =3D <&ccu RST_BUS_MMC0>;
> -			reset-names =3D "ahb";
> -			interrupts =3D <23>;
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&mmc0_pins>;
> -			status =3D "disabled";
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -		};
> -
> -		mmc1: mmc@1c10000 {
> -			compatible =3D "allwinner,suniv-f1c100s-mmc",
> -				     "allwinner,sun7i-a20-mmc";
> -			reg =3D <0x01c10000 0x1000>;
> -			clocks =3D <&ccu CLK_BUS_MMC1>,
> -				 <&ccu CLK_MMC1>,
> -				 <&ccu CLK_MMC1_OUTPUT>,
> -				 <&ccu CLK_MMC1_SAMPLE>;
> -			clock-names =3D "ahb", "mmc", "output", "sample";
> -			resets =3D <&ccu RST_BUS_MMC1>;
> -			reset-names =3D "ahb";
> -			interrupts =3D <24>;
> -			status =3D "disabled";
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -		};
> -
> -		usb_otg: usb@1c13000 {
> -			compatible =3D "allwinner,suniv-f1c100s-musb";
> -			reg =3D <0x01c13000 0x0400>;
> -			clocks =3D <&ccu CLK_BUS_OTG>;
> -			resets =3D <&ccu RST_BUS_OTG>;
> -			interrupts =3D <26>;
> -			interrupt-names =3D "mc";
> -			phys =3D <&usbphy 0>;
> -			phy-names =3D "usb";
> -			extcon =3D <&usbphy 0>;
> -			allwinner,sram =3D <&otg_sram 1>;
> -			status =3D "disabled";
> -		};
> -
> -		usbphy: phy@1c13400 {
> -			compatible =3D "allwinner,suniv-f1c100s-usb-phy";
> -			reg =3D <0x01c13400 0x10>;
> -			reg-names =3D "phy_ctrl";
> -			clocks =3D <&ccu CLK_USB_PHY0>;
> -			clock-names =3D "usb0_phy";
> -			resets =3D <&ccu RST_USB_PHY0>;
> -			reset-names =3D "usb0_reset";
> -			#phy-cells =3D <1>;
> -			status =3D "disabled";
> -		};
> -
> -		ccu: clock@1c20000 {
> -			compatible =3D "allwinner,suniv-f1c100s-ccu";
> -			reg =3D <0x01c20000 0x400>;
> -			clocks =3D <&osc24M>, <&osc32k>;
> -			clock-names =3D "hosc", "losc";
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> -		};
> -
> -		intc: interrupt-controller@1c20400 {
> -			compatible =3D "allwinner,suniv-f1c100s-ic";
> -			reg =3D <0x01c20400 0x400>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <1>;
> -		};
> -
> -		pio: pinctrl@1c20800 {
> -			compatible =3D "allwinner,suniv-f1c100s-pinctrl";
> -			reg =3D <0x01c20800 0x400>;
> -			interrupts =3D <38>, <39>, <40>;
> -			clocks =3D <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
> -			clock-names =3D "apb", "hosc", "losc";
> -			gpio-controller;
> -			interrupt-controller;
> -			#interrupt-cells =3D <3>;
> -			#gpio-cells =3D <3>;
> -
> -			mmc0_pins: mmc0-pins {
> -				pins =3D "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
> -				function =3D "mmc0";
> -				drive-strength =3D <30>;
> -			};
> -
> -			/omit-if-no-ref/
> -			i2c0_pd_pins: i2c0-pd-pins {
> -				pins =3D "PD0", "PD12";
> -				function =3D "i2c0";
> -			};
> -
> -			spi0_pc_pins: spi0-pc-pins {
> -				pins =3D "PC0", "PC1", "PC2", "PC3";
> -				function =3D "spi0";
> -			};
> -
> -			uart0_pe_pins: uart0-pe-pins {
> -				pins =3D "PE0", "PE1";
> -				function =3D "uart0";
> -			};
> -
> -			/omit-if-no-ref/
> -			uart1_pa_pins: uart1-pa-pins {
> -				pins =3D "PA2", "PA3";
> -				function =3D "uart1";
> -			};
> -		};
> -
> -		i2c0: i2c@1c27000 {
> -			compatible =3D "allwinner,suniv-f1c100s-i2c",
> -				     "allwinner,sun6i-a31-i2c";
> -			reg =3D <0x01c27000 0x400>;
> -			interrupts =3D <7>;
> -			clocks =3D <&ccu CLK_BUS_I2C0>;
> -			resets =3D <&ccu RST_BUS_I2C0>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c1: i2c@1c27400 {
> -			compatible =3D "allwinner,suniv-f1c100s-i2c",
> -				     "allwinner,sun6i-a31-i2c";
> -			reg =3D <0x01c27400 0x400>;
> -			interrupts =3D <8>;
> -			clocks =3D <&ccu CLK_BUS_I2C1>;
> -			resets =3D <&ccu RST_BUS_I2C1>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		i2c2: i2c@1c27800 {
> -			compatible =3D "allwinner,suniv-f1c100s-i2c",
> -				     "allwinner,sun6i-a31-i2c";
> -			reg =3D <0x01c27800 0x400>;
> -			interrupts =3D <9>;
> -			clocks =3D <&ccu CLK_BUS_I2C2>;
> -			resets =3D <&ccu RST_BUS_I2C2>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		timer@1c20c00 {
> -			compatible =3D "allwinner,suniv-f1c100s-timer";
> -			reg =3D <0x01c20c00 0x90>;
> -			interrupts =3D <13>, <14>, <15>;
> -			clocks =3D <&osc24M>;
> -		};
> -
> -		wdt: watchdog@1c20ca0 {
> -			compatible =3D "allwinner,suniv-f1c100s-wdt",
> -				     "allwinner,sun6i-a31-wdt";
> -			reg =3D <0x01c20ca0 0x20>;
> -			interrupts =3D <16>;
> -			clocks =3D <&osc32k>;
> -		};
> -
> -		pwm: pwm@1c21000 {
> -			compatible =3D "allwinner,suniv-f1c100s-pwm",
> -				     "allwinner,sun7i-a20-pwm";
> -			reg =3D <0x01c21000 0x400>;
> -			clocks =3D <&osc24M>;
> -			#pwm-cells =3D <3>;
> -			status =3D "disabled";
> -		};
> -
> -		ir: ir@1c22c00 {
> -			compatible =3D "allwinner,suniv-f1c100s-ir",
> -				     "allwinner,sun6i-a31-ir";
> -			reg =3D <0x01c22c00 0x400>;
> -			clocks =3D <&ccu CLK_BUS_IR>, <&ccu CLK_IR>;
> -			clock-names =3D "apb", "ir";
> -			resets =3D <&ccu RST_BUS_IR>;
> -			interrupts =3D <6>;
> -			status =3D "disabled";
> -		};
> -
> -		lradc: lradc@1c23400 {
> -			compatible =3D "allwinner,suniv-f1c100s-lradc",
> -				     "allwinner,sun8i-a83t-r-lradc";
> -			reg =3D <0x01c23400 0x400>;
> -			interrupts =3D <22>;
> -			status =3D "disabled";
> -		};
> -
> -		uart0: serial@1c25000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x01c25000 0x400>;
> -			interrupts =3D <1>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART0>;
> -			resets =3D <&ccu RST_BUS_UART0>;
> -			status =3D "disabled";
> -		};
> -
> -		uart1: serial@1c25400 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x01c25400 0x400>;
> -			interrupts =3D <2>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART1>;
> -			resets =3D <&ccu RST_BUS_UART1>;
> -			status =3D "disabled";
> -		};
> -
> -		uart2: serial@1c25800 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x01c25800 0x400>;
> -			interrupts =3D <3>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART2>;
> -			resets =3D <&ccu RST_BUS_UART2>;
> -			status =3D "disabled";
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts b/arch/arm/dts/suni=
v-f1c200s-lctech-pi.dts
> deleted file mode 100644
> index 2d2a3f026df..00000000000
> --- a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts
> +++ /dev/null
> @@ -1,76 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright 2022 Arm Ltd,
> - * based on work:
> - *   Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
> - */
> -
> -/dts-v1/;
> -#include "suniv-f1c100s.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -
> -/ {
> -	model =3D "Lctech Pi F1C200s";
> -	compatible =3D "lctech,pi-f1c200s", "allwinner,suniv-f1c200s",
> -		     "allwinner,suniv-f1c100s";
> -
> -	aliases {
> -		serial0 =3D &uart1;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	reg_vcc3v3: regulator-3v3 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc3v3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -	};
> -};
> -
> -&mmc0 {
> -	broken-cd;
> -	bus-width =3D <4>;
> -	disable-wp;
> -	vmmc-supply =3D <&reg_vcc3v3>;
> -	status =3D "okay";
> -};
> -
> -&otg_sram {
> -	status =3D "okay";
> -};
> -
> -&spi0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&spi0_pc_pins>;
> -	status =3D "okay";
> -
> -	flash@0 {
> -		compatible =3D "spi-nand";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <40000000>;
> -	};
> -};
> -
> -&uart1 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&uart1_pa_pins>;
> -	status =3D "okay";
> -};
> -
> -/*
> - * This is a Type-C socket, but CC1/2 are not connected, and VBUS is con=
nected
> - * to Vin, which supplies the board. Host mode works (if the board is po=
wered
> - * otherwise), but peripheral is probably the intention.
> - */
> -&usb_otg {
> -	dr_mode =3D "peripheral";
> -	status =3D "okay";
> -};
> -
> -&usbphy {
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts b/arch/arm/dts/=
suniv-f1c200s-popstick-v1.1.dts
> deleted file mode 100644
> index 184c245041a..00000000000
> --- a/arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
> - */
> -
> -/dts-v1/;
> -#include "suniv-f1c100s.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -
> -/ {
> -	model =3D "Popcorn Computer PopStick v1.1";
> -	compatible =3D "sourceparts,popstick-v1.1", "sourceparts,popstick",
> -		     "allwinner,suniv-f1c200s", "allwinner,suniv-f1c100s";
> -
> -	aliases {
> -		serial0 =3D &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	leds {
> -		compatible =3D "gpio-leds";
> -
> -		led {
> -			function =3D LED_FUNCTION_STATUS;
> -			color =3D <LED_COLOR_ID_GREEN>;
> -			gpios =3D <&pio 4 6 GPIO_ACTIVE_HIGH>; /* PE6 */
> -			linux,default-trigger =3D "heartbeat";
> -		};
> -	};
> -
> -	reg_vcc3v3: regulator-3v3 {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc3v3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -	};
> -};
> -
> -&mmc0 {
> -	cd-gpios =3D <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
> -	bus-width =3D <4>;
> -	disable-wp;
> -	vmmc-supply =3D <&reg_vcc3v3>;
> -	status =3D "okay";
> -};
> -
> -&otg_sram {
> -	status =3D "okay";
> -};
> -
> -&spi0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&spi0_pc_pins>;
> -	status =3D "okay";
> -
> -	flash@0 {
> -		compatible =3D "spi-nand";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <40000000>;
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&uart0_pe_pins>;
> -	status =3D "okay";
> -};
> -
> -&usb_otg {
> -	dr_mode =3D "peripheral";
> -	status =3D "okay";
> -};
> -
> -&usbphy {
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 8065161e61e..866b55833c0 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -279,6 +279,7 @@ config MACH_SUNIV
>  	select SUPPORT_SPL
>  	select SKIP_LOWLEVEL_INIT_ONLY
>  	select SPL_SKIP_LOWLEVEL_INIT_ONLY
> +	imply OF_UPSTREAM
> =20
>  config MACH_SUN4I
>  	bool "sun4i (Allwinner A10)"
> diff --git a/configs/lctech_pi_f1c200s_defconfig b/configs/lctech_pi_f1c2=
00s_defconfig
> index e1e8d3aaaa3..1588b3b4955 100644
> --- a/configs/lctech_pi_f1c200s_defconfig
> +++ b/configs/lctech_pi_f1c200s_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c200s-lctech-pi"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c200s-lctech-pi"

What's with this board? I don't see it being removed from Makefile. If it
is not there, then this board has been broken all along?

Best regards,
Jernej

>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUNIV=3Dy
>  CONFIG_DRAM_CLK=3D156
> diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_defc=
onfig
> index d59affb0d9c..051b1901f20 100644
> --- a/configs/licheepi_nano_defconfig
> +++ b/configs/licheepi_nano_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c100s-licheepi-nano"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c100s-licheepi-nano"
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUNIV=3Dy
>  CONFIG_DRAM_CLK=3D156
>=20




