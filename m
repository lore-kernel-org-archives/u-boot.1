Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF574C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 05:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5FB881DB;
	Mon, 27 May 2024 07:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fnmemrJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD7E874AC; Mon, 27 May 2024 07:11:51 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4471B881EA
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 07:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-48a396a30c0so827793137.0
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716786707; x=1717391507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly6HOU4vlzgMku3S+ExhXYcQNSSJpLs9hyQ5h6nBE1Y=;
 b=fnmemrJBNhyWS6eiYirSbk3uqo8iLVyCSVvRBxE0Ni2f+4sThvyyYjdVnvA6GqGDRs
 j873/Wt1TRlumHgr5YChFHzviWFshMu4znQdonR5SIYjfxOwn+kPU70pxojj7ZG13az0
 /2gDVagsYBZEqUyp0eMJShWk1c947MAbRxQgitG5FWU9hTtrDSfB/mUIW5N+x3VeZOfM
 5i9WTQv1ZM5C25wwaa1NY1Mn+oOeBuVHYHjXA6T1b0A+QdnUw0jR40WeaEq9s/Ax8N6U
 cXU4RlWKOJ/CfRy2MA3ixn+HsFCAJRaVKRJH/Eh1dM/8VxfeZ+skk9FP1Cvf6Epa1jFC
 jhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786707; x=1717391507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ly6HOU4vlzgMku3S+ExhXYcQNSSJpLs9hyQ5h6nBE1Y=;
 b=h1RKqbFKjJhf++vOcYQbYDMGVA1DR11uGheoplLemIW4aoiHw2NrvSEmG7U4qymX7x
 5WDS/T2ltiFZ/59mbBrPmqKAqmK02K8ATOwips1HpM9hl728PoCbX/Nt0LxjVDpfj5Yt
 BH1saFwi+/FBK1vcZeLUEYgM6LaTNrP6L2p+EeAQoVWvxMsf/yp5ZrgICdp997TfAild
 horxVfgby9L5WYaUjclwNbyLfPJMGn2DQ5blfR2sAq+u82Fw/2JwdcB99gZpXfwtzJ9s
 KK7iFfY28Raz103JyIH4xn7Dzp71b8W0D5mUh0+4pUgfknJEb7KIFCUraBgSBlU88iE7
 a99g==
X-Gm-Message-State: AOJu0YxWVc0Dh+SPv4wdlSfrSJ3YIY7p9Oj7dLb5SZb2hTuArnjqiUWp
 rF1mWGy/kZe35vvSW1YRkX6NO9zm5elSvC4BgWLWdkNtogwr6VYyFe2ZYSW28TTXd75X+JN8RHE
 7hfBbbMxuRGB1MOU4oTM1JpJXygwy65rYD5Y5NcIyeWnpDVn0qfo=
X-Google-Smtp-Source: AGHT+IG3kAYrlS0ZQJP9o2oXOIQiLdgAZZCUvTGbgDeoNWjMl947xjn3MRjx9mPm+jrJfpPGwLhxGNOnJxAu+Q3WCK4=
X-Received: by 2002:a05:6102:1172:b0:47b:b404:d63e with SMTP id
 ada2fe7eead31-48a385c9033mr7110222137.15.1716786706875; Sun, 26 May 2024
 22:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240526180128.2807306-1-marek.vasut+renesas@mailbox.org>
 <20240526180128.2807306-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240526180128.2807306-2-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 27 May 2024 10:41:35 +0530
Message-ID: <CAFA6WYOnXcu1wowwQvSm4U2AYQ2YMbsNs9+L3atDXK2RYj2_cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: renesas: Drop R8A779H0 V4M DTs with
 OF_UPSTREAM counterparts
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 26 May 2024 at 23:31, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Remove R8A779H0 V4M DTs which are now replaced by OF_UPSTREAM counterparts.
> No functional change expected.
>
> This patch finalizes OF_UPSTREAM conversion of R8A779H0 V4M which DTs landed
> in Linux 6.9 .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/dts/Makefile                         |   3 -
>  arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi      | 166 -------
>  arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi  |  15 -
>  arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi |  15 -
>  arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi   |  41 --
>  arch/arm/dts/r8a779h0-gray-hawk.dts           |  25 -
>  arch/arm/dts/r8a779h0-u-boot.dtsi             |  27 -
>  arch/arm/dts/r8a779h0.dtsi                    | 460 ------------------
>  8 files changed, 752 deletions(-)
>  delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
>  delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
>  delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
>  delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
>  delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk.dts
>  delete mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
>  delete mode 100644 arch/arm/dts/r8a779h0.dtsi
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index f7032f1e175..6d5ff1bc27b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -958,9 +958,6 @@ dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
>         imxrt1020-evk.dtb \
>         imxrt1170-evk.dtb \
>
> -dtb-$(CONFIG_RCAR_GEN4) += \
> -       r8a779h0-gray-hawk.dtb
> -
>  dtb-$(CONFIG_TARGET_RZG2L) += \
>         r9a07g044l2-smarc.dts
>
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
> deleted file mode 100644
> index c8a46219826..00000000000
> --- a/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/*
> - * Device Tree Source for the Gray Hawk CPU board
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -
> -#include "r8a779h0.dtsi"
> -
> -/ {
> -       model = "Renesas Gray Hawk CPU board";
> -       compatible = "renesas,grayhawk-cpu", "renesas,r8a779h0";
> -
> -       aliases {
> -               ethernet0 = &avb0;
> -               serial0 = &hscif0;
> -       };
> -
> -       chosen {
> -               bootargs = "ignore_loglevel";
> -               stdout-path = "serial0:921600n8";
> -       };
> -
> -       memory@48000000 {
> -               device_type = "memory";
> -               /* first 128MB is reserved for secure area. */
> -               reg = <0x0 0x48000000 0x0 0x78000000>;
> -       };
> -
> -       memory@480000000 {
> -               device_type = "memory";
> -               reg = <0x4 0x80000000 0x1 0x80000000>;
> -       };
> -
> -       reg_1p8v: regulator-1p8v {
> -                       compatible = "regulator-fixed";
> -                       regulator-name = "fixed-1.8V";
> -                       regulator-min-microvolt = <1800000>;
> -                       regulator-max-microvolt = <1800000>;
> -                       regulator-boot-on;
> -                       regulator-always-on;
> -       };
> -
> -       reg_3p3v: regulator-3p3v {
> -                       compatible = "regulator-fixed";
> -                       regulator-name = "fixed-3.3V";
> -                       regulator-min-microvolt = <3300000>;
> -                       regulator-max-microvolt = <3300000>;
> -                       regulator-boot-on;
> -                       regulator-always-on;
> -       };
> -};
> -
> -&avb0 {
> -       pinctrl-0 = <&avb0_pins>;
> -       pinctrl-names = "default";
> -       phy-handle = <&phy0>;
> -       tx-internal-delay-ps = <2000>;
> -       status = "okay";
> -
> -       phy0: ethernet-phy@0 {
> -               compatible = "ethernet-phy-id0022.1622",
> -                            "ethernet-phy-ieee802.3-c22";
> -               rxc-skew-ps = <1500>;
> -               reg = <0>;
> -               interrupt-parent = <&gpio7>;
> -               interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> -               reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
> -       };
> -};
> -
> -&extal_clk {
> -       clock-frequency = <16666666>;
> -};
> -
> -&extalr_clk {
> -       clock-frequency = <32768>;
> -};
> -
> -&hscif0 {
> -       uart-has-rtscts;
> -       status = "okay";
> -};
> -
> -&i2c0 {
> -       pinctrl-0 = <&i2c0_pins>;
> -       pinctrl-names = "default";
> -
> -       status = "okay";
> -       clock-frequency = <400000>;
> -
> -       eeprom@50 {
> -               compatible = "rohm,br24g01", "atmel,24c01";
> -               label = "cpu-board";
> -               reg = <0x50>;
> -               pagesize = <8>;
> -       };
> -};
> -
> -&mmc0 {
> -       pinctrl-0 = <&mmc_pins>;
> -       pinctrl-1 = <&mmc_pins>;
> -       pinctrl-names = "default", "state_uhs";
> -
> -       vmmc-supply = <&reg_3p3v>;
> -       vqmmc-supply = <&reg_1p8v>;
> -       mmc-hs200-1_8v;
> -       mmc-hs400-1_8v;
> -       bus-width = <8>;
> -       no-sd;
> -       no-sdio;
> -       non-removable;
> -       full-pwr-cycle-in-suspend;
> -       status = "okay";
> -};
> -
> -&pfc {
> -       pinctrl-0 = <&scif_clk_pins>;
> -       pinctrl-names = "default";
> -
> -       avb0_pins: avb0 {
> -               mux {
> -                       groups = "avb0_link", "avb0_mdio", "avb0_rgmii",
> -                                "avb0_txcrefclk";
> -                       function = "avb0";
> -               };
> -
> -               pins_mdio {
> -                       groups = "avb0_mdio";
> -                       drive-strength = <21>;
> -               };
> -
> -               pins_mii {
> -                       groups = "avb0_rgmii";
> -                       drive-strength = <21>;
> -               };
> -       };
> -
> -       hscif0_pins: hscif0 {
> -               groups = "hscif0_data", "hscif0_ctrl";
> -               function = "hscif0";
> -       };
> -
> -       i2c0_pins: i2c0 {
> -               groups = "i2c0";
> -               function = "i2c0";
> -       };
> -
> -       mmc_pins: mmc {
> -               groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
> -               function = "mmc";
> -               power-source = <1800>;
> -       };
> -
> -       scif_clk_pins: scif_clk {
> -               groups = "scif_clk";
> -               function = "scif_clk";
> -       };
> -};
> -
> -&scif_clk {
> -       clock-frequency = <24000000>;
> -};
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
> deleted file mode 100644
> index fcdd8eb8d54..00000000000
> --- a/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/*
> - * Device Tree Source for the R-Car V4M Gray Hawk CSI/DSI sub-board
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -&i2c0 {
> -       eeprom@52 {
> -               compatible = "rohm,br24g01", "atmel,24c01";
> -               label = "csi-dsi-sub-board-id";
> -               reg = <0x52>;
> -               pagesize = <8>;
> -       };
> -};
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
> deleted file mode 100644
> index 5a8e598c986..00000000000
> --- a/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/*
> - * Device Tree Source for the R-Car V4M Gray Hawk Ethernet sub-board
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -&i2c0 {
> -       eeprom@53 {
> -               compatible = "rohm,br24g01", "atmel,24c01";
> -               label = "ethernet-sub-board-id";
> -               reg = <0x53>;
> -               pagesize = <8>;
> -       };
> -};
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
> deleted file mode 100644
> index 92c13151613..00000000000
> --- a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source extras for U-Boot for the Gray Hawk board
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -#include "r8a779h0-u-boot.dtsi"
> -
> -/ {
> -       aliases {
> -               spi0 = &rpc;
> -       };
> -};
> -
> -&pfc {
> -       qspi0_pins: qspi0 {
> -               groups = "qspi0_ctrl", "qspi0_data4";
> -               function = "qspi0";
> -       };
> -};
> -
> -&rpc {
> -       pinctrl-0 = <&qspi0_pins>;
> -       pinctrl-names = "default";
> -
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -       spi-max-frequency = <40000000>;
> -       status = "okay";
> -
> -       flash@0 {
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               compatible = "s25fs512s", "jedec,spi-nor";
> -               reg = <0>;
> -               spi-max-frequency = <40000000>;
> -               spi-tx-bus-width = <1>;
> -               spi-rx-bus-width = <1>;
> -       };
> -};
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk.dts b/arch/arm/dts/r8a779h0-gray-hawk.dts
> deleted file mode 100644
> index 59e5e493ad1..00000000000
> --- a/arch/arm/dts/r8a779h0-gray-hawk.dts
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/*
> - * Device Tree Source for the Gray Hawk CPU and BreakOut boards
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -/dts-v1/;
> -#include "r8a779h0-gray-hawk-cpu.dtsi"
> -#include "r8a779h0-gray-hawk-csi-dsi.dtsi"
> -#include "r8a779h0-gray-hawk-ethernet.dtsi"
> -
> -/ {
> -       model = "Renesas Gray Hawk CPU and Breakout boards based on r8a779h0";
> -       compatible = "renesas,gray-hawk-breakout", "renesas,gray-hawk-cpu", "renesas,r8a779h0";
> -};
> -
> -&i2c0 {
> -       eeprom@51 {
> -               compatible = "rohm,br24g01", "atmel,24c01";
> -               label = "breakout-board";
> -               reg = <0x51>;
> -               pagesize = <8>;
> -       };
> -};
> diff --git a/arch/arm/dts/r8a779h0-u-boot.dtsi b/arch/arm/dts/r8a779h0-u-boot.dtsi
> deleted file mode 100644
> index b2f7e054eef..00000000000
> --- a/arch/arm/dts/r8a779h0-u-boot.dtsi
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source extras for U-Boot on R-Car R8A779H0 SoC
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -#include "r8a779x-u-boot.dtsi"
> -/ {
> -       soc {
> -               rpc: spi@ee200000 {
> -                       compatible = "renesas,r8a779h0-rpc-if", "renesas,rcar-gen4-rpc-if";
> -                       reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x04000000>;
> -                       interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 629>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 629>;
> -                       bank-width = <2>;
> -                       num-cs = <1>;
> -                       status = "disabled";
> -               };
> -       };
> -};
> -
> -&extalr_clk {
> -       bootph-all;
> -};
> diff --git a/arch/arm/dts/r8a779h0.dtsi b/arch/arm/dts/r8a779h0.dtsi
> deleted file mode 100644
> index a896bc27f5a..00000000000
> --- a/arch/arm/dts/r8a779h0.dtsi
> +++ /dev/null
> @@ -1,460 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -/*
> - * Device Tree Source for the R-Car V4M (R8A779H0) SoC
> - *
> - * Copyright (C) 2023 Renesas Electronics Corp.
> - */
> -
> -#include <dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/power/renesas,r8a779h0-sysc.h>
> -
> -/ {
> -       compatible = "renesas,r8a779h0";
> -       #address-cells = <2>;
> -       #size-cells = <2>;
> -
> -       cpus {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               a76_0: cpu@0 {
> -                       compatible = "arm,cortex-a76";
> -                       reg = <0>;
> -                       device_type = "cpu";
> -                       power-domains = <&sysc R8A779H0_PD_A1E0D0C0>;
> -               };
> -       };
> -
> -       extal_clk: extal-clk {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               /* This value must be overridden by the board */
> -               clock-frequency = <0>;
> -       };
> -
> -       extalr_clk: extalr-clk {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               /* This value must be overridden by the board */
> -               clock-frequency = <0>;
> -       };
> -
> -       pmu-a76 {
> -               compatible = "arm,cortex-a76-pmu";
> -               interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> -       };
> -
> -       /* External SCIF clock - to be overridden by boards that provide it */
> -       scif_clk: scif-clk {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               clock-frequency = <0>;
> -       };
> -
> -       soc: soc {
> -               compatible = "simple-bus";
> -               interrupt-parent = <&gic>;
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               pfc: pinctrl@e6050000 {
> -                       compatible = "renesas,pfc-r8a779h0";
> -                       reg = <0 0xe6050000 0 0x16c>, <0 0xe6050800 0 0x16c>,
> -                             <0 0xe6058000 0 0x16c>, <0 0xe6058800 0 0x16c>,
> -                             <0 0xe6060000 0 0x16c>, <0 0xe6060800 0 0x16c>,
> -                             <0 0xe6061000 0 0x16c>, <0 0xe6061800 0 0x16c>;
> -               };
> -
> -               gpio0: gpio@e6050180 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6050180 0 0x54>;
> -                       interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 0 19>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 915>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 915>;
> -               };
> -
> -               gpio1: gpio@e6050980 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6050980 0 0x54>;
> -                       interrupts = <GIC_SPI 623 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 32 30>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 915>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 915>;
> -               };
> -
> -               gpio2: gpio@e6058180 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6058180 0 0x54>;
> -                       interrupts = <GIC_SPI 627 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 64 20>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 916>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 916>;
> -               };
> -
> -               gpio3: gpio@e6058980 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6058980 0 0x54>;
> -                       interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 96 32>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 916>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 916>;
> -               };
> -
> -               gpio4: gpio@e6060180 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6060180 0 0x54>;
> -                       interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 128 25>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 917>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 917>;
> -               };
> -
> -               gpio5: gpio@e6060980 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6060980 0 0x54>;
> -                       interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 160 21>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 917>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 917>;
> -               };
> -
> -               gpio6: gpio@e6061180 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6061180 0 0x54>;
> -                       interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 192 21>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 917>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 917>;
> -               };
> -
> -               gpio7: gpio@e6061980 {
> -                       compatible = "renesas,gpio-r8a779h0",
> -                                    "renesas,rcar-gen4-gpio";
> -                       reg = <0 0xe6061980 0 0x54>;
> -                       interrupts = <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>;
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       gpio-ranges = <&pfc 0 224 21>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       clocks = <&cpg CPG_MOD 917>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 917>;
> -               };
> -
> -               cpg: clock-controller@e6150000 {
> -                       compatible = "renesas,r8a779h0-cpg-mssr";
> -                       reg = <0 0xe6150000 0 0x4000>;
> -                       clocks = <&extal_clk>, <&extalr_clk>;
> -                       clock-names = "extal", "extalr";
> -                       #clock-cells = <2>;
> -                       #power-domain-cells = <0>;
> -                       #reset-cells = <1>;
> -               };
> -
> -               rst: reset-controller@e6160000 {
> -                       compatible = "renesas,r8a779h0-rst";
> -                       reg = <0 0xe6160000 0 0x4000>;
> -               };
> -
> -               sysc: system-controller@e6180000 {
> -                       compatible = "renesas,r8a779h0-sysc";
> -                       reg = <0 0xe6180000 0 0x4000>;
> -                       #power-domain-cells = <1>;
> -               };
> -
> -               i2c0: i2c@e6500000 {
> -                       compatible = "renesas,i2c-r8a779h0",
> -                                    "renesas,rcar-gen4-i2c";
> -                       reg = <0 0xe6500000 0 0x40>;
> -                       interrupts = <GIC_SPI 610 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 518>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 518>;
> -                       i2c-scl-internal-delay-ns = <110>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               i2c1: i2c@e6508000 {
> -                       compatible = "renesas,i2c-r8a779h0",
> -                                    "renesas,rcar-gen4-i2c";
> -                       reg = <0 0xe6508000 0 0x40>;
> -                       interrupts = <GIC_SPI 611 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 519>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 519>;
> -                       i2c-scl-internal-delay-ns = <110>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               i2c2: i2c@e6510000 {
> -                       compatible = "renesas,i2c-r8a779h0",
> -                                    "renesas,rcar-gen4-i2c";
> -                       reg = <0 0xe6510000 0 0x40>;
> -                       interrupts = <GIC_SPI 612 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 520>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 520>;
> -                       i2c-scl-internal-delay-ns = <110>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               i2c3: i2c@e66d0000 {
> -                       compatible = "renesas,i2c-r8a779h0",
> -                                    "renesas,rcar-gen4-i2c";
> -                       reg = <0 0xe66d0000 0 0x40>;
> -                       interrupts = <GIC_SPI 613 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 521>;
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 521>;
> -                       i2c-scl-internal-delay-ns = <110>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               hscif0: serial@e6540000 {
> -                       compatible = "renesas,hscif-r8a779h0",
> -                                    "renesas,rcar-gen4-hscif", "renesas,hscif";
> -                       reg = <0 0xe6540000 0 0x60>;
> -                       interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 514>,
> -                                <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
> -                                <&scif_clk>;
> -                       clock-names = "fck", "brg_int", "scif_clk";
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 514>;
> -                       status = "disabled";
> -               };
> -
> -               avb0: ethernet@e6800000 {
> -                       compatible = "renesas,etheravb-r8a779h0",
> -                                    "renesas,etheravb-rcar-gen4";
> -                       reg = <0 0xe6800000 0 0x800>;
> -                       interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "ch0", "ch1", "ch2", "ch3",
> -                                         "ch4", "ch5", "ch6", "ch7",
> -                                         "ch8", "ch9", "ch10", "ch11",
> -                                         "ch12", "ch13", "ch14", "ch15",
> -                                         "ch16", "ch17", "ch18", "ch19",
> -                                         "ch20", "ch21", "ch22", "ch23",
> -                                         "ch24";
> -                       clocks = <&cpg CPG_MOD 211>;
> -                       power-domains = <&sysc R8A779H0_PD_C4>;
> -                       resets = <&cpg 211>;
> -                       phy-mode = "rgmii";
> -                       rx-internal-delay-ps = <0>;
> -                       tx-internal-delay-ps = <0>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               avb1: ethernet@e6810000 {
> -                       compatible = "renesas,etheravb-r8a779h0",
> -                                    "renesas,etheravb-rcar-gen4";
> -                       reg = <0 0xe6810000 0 0x800>;
> -                       interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "ch0", "ch1", "ch2", "ch3",
> -                                         "ch4", "ch5", "ch6", "ch7",
> -                                         "ch8", "ch9", "ch10", "ch11",
> -                                         "ch12", "ch13", "ch14", "ch15",
> -                                         "ch16", "ch17", "ch18", "ch19",
> -                                         "ch20", "ch21", "ch22", "ch23",
> -                                         "ch24";
> -                       clocks = <&cpg CPG_MOD 212>;
> -                       power-domains = <&sysc R8A779H0_PD_C4>;
> -                       resets = <&cpg 212>;
> -                       phy-mode = "rgmii";
> -                       rx-internal-delay-ps = <0>;
> -                       tx-internal-delay-ps = <0>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -                       };
> -
> -               avb2: ethernet@e6820000 {
> -                       compatible = "renesas,etheravb-r8a779h0",
> -                                    "renesas,etheravb-rcar-gen4";
> -                       reg = <0 0xe6820000 0 0x1000>;
> -                       interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "ch0", "ch1", "ch2", "ch3",
> -                                         "ch4", "ch5", "ch6", "ch7",
> -                                         "ch8", "ch9", "ch10", "ch11",
> -                                         "ch12", "ch13", "ch14", "ch15",
> -                                         "ch16", "ch17", "ch18", "ch19",
> -                                         "ch20", "ch21", "ch22", "ch23",
> -                                         "ch24";
> -                       clocks = <&cpg CPG_MOD 213>;
> -                       power-domains = <&sysc R8A779H0_PD_C4>;
> -                       resets = <&cpg 213>;
> -                       phy-mode = "rgmii";
> -                       rx-internal-delay-ps = <0>;
> -                       tx-internal-delay-ps = <0>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -
> -               mmc0: mmc@ee140000 {
> -                       compatible = "renesas,sdhi-r8a779h0",
> -                                    "renesas,rcar-gen4-sdhi";
> -                       reg = <0 0xee140000 0 0x2000>;
> -                       interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&cpg CPG_MOD 706>,
> -                                <&cpg CPG_CORE R8A779H0_CLK_SD0H>;
> -                       clock-names = "core", "clkh";
> -                       power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
> -                       resets = <&cpg 706>;
> -                       max-frequency = <200000000>;
> -                       status = "disabled";
> -               };
> -
> -               gic: interrupt-controller@f1000000 {
> -                       compatible = "arm,gic-v3";
> -                       #interrupt-cells = <3>;
> -                       #address-cells = <0>;
> -                       interrupt-controller;
> -                       reg = <0x0 0xf1000000 0 0x20000>,
> -                             <0x0 0xf1060000 0 0x110000>;
> -                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -               };
> -
> -               prr: chipid@fff00044 {
> -                       compatible = "renesas,prr";
> -                       reg = <0 0xfff00044 0 4>;
> -               };
> -       };
> -
> -       timer {
> -               compatible = "arm,armv8-timer";
> -               interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> -                                     <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> -                                     <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> -                                     <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
> -                                     <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
> -       };
> -};
> --
> 2.43.0
>
