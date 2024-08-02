Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A7C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED10D88216;
	Fri,  2 Aug 2024 08:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M5RKEtEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B0B82BA7; Fri,  2 Aug 2024 08:55:11 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB66A88641
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-810177d1760so2547157241.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722581707; x=1723186507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5+/aLe6zLb0d96Cmt4Tek49GnHEQ/QIe+AWgxlmFqrM=;
 b=M5RKEtEbkEHROmaZGCHmZPNZ5txWN2ELzlI2hs+RC8bnaFdNnqnBPr+WPdh+WqORmK
 IMlt3/hlBqFeV/fi1PMp9RCAzV/5XqE+R5AjM7WYzSX2VqGd+WOdPTHj7Wzcj/WthiJY
 7du0ZNhOXpm5N6FFQx2cLC7Qp0JK+oo8Ws9PmkL+0K+Kqsg9W3KNUv+fPEO659YsJYSy
 T65LA78s3MaX7HBTcvh+ME5q06RC1O+WYYl4W6uQXjeQi1kSkUjE3R3NabcpSvydq5Zx
 HYH0ijXt2PEksHalZDK7kaat4BUlXsBIfrNqS64LAtjXGHr0Km5ecXXExQxvHh2VLxzl
 42OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581707; x=1723186507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+/aLe6zLb0d96Cmt4Tek49GnHEQ/QIe+AWgxlmFqrM=;
 b=d23luQ03C1QPLR0NUW3r5oz3Q+f43oZy8GwNgwG5SEo7Y9miswtvQ1WrkRs3hTnV9V
 dRwUE89T0QLnPOPY0ukrKtIrhESGqHvXP6LXVfcExvuKdaLU7WTuaAfZcY/a6+vsBvu3
 nDlgkc2+vYMt9aoib3q18YPh7IybPJ1mmlZRCJP777uM0Z2UBJ2GFvT8S3BV0QqoHuyK
 rXrPQIQM5HQLxiL+uGR82lz+xq9CYOIgW8phtYT9EzNW6OMbsEpS53ldcyXEcUi5uMF6
 2ejF+hZtxk8Ptpo+UWY7PzxB8DLp9SHYOau60yqXdnl0wvXWi6vnhpS47dLwdNFR5P02
 MQxw==
X-Gm-Message-State: AOJu0YyWGjMCPwNhAS6QCtHoQ0RHLYH5iOsKLFBYPvgwIgH8ORqApaFE
 MgVjF04ohTkJH//dEyCMQDQ+Dv4vzLBD5kUkcsIPvCS5BL1lD7xU9dvDD6frN2aa9/v+BDR3gY7
 ARNHy8B5XKVxrYGh5aDa58h/8pOYVAgIbuPUsCA==
X-Google-Smtp-Source: AGHT+IHzbOBeXz/wqaBO7ysUtUSDY8yH6yrJmThLyQHtvKn+LMxS11Aj7/qfnnX/NuRfJuxdt4MrpR8k59yFM34OTgk=
X-Received: by 2002:a05:6102:c94:b0:492:9c7d:fb5a with SMTP id
 ada2fe7eead31-4945bf464b0mr3083584137.31.1722581707437; Thu, 01 Aug 2024
 23:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-10-macroalpha82@gmail.com>
In-Reply-To: <20240801225519.336667-10-macroalpha82@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Aug 2024 12:24:56 +0530
Message-ID: <CAFA6WYP7fnswZ4BHtqd+nKT7MZeBrKgocQf-WpJ7-HqjBOaFvQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] sunxi: Add support for Anbernic RG35XX-2024
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com, 
 neil.armstrong@linaro.org, hdegoede@redhat.com, andre.przywara@arm.com, 
 jagan@amarulasolutions.com, trini@konsulko.com, ryan@testtoast.com, 
 Chris Morgan <macromorgan@hotmail.com>
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

Hi Chris,

On Fri, 2 Aug 2024 at 04:29, Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The Anbernic RG35XX series of devices are based around an Allwinner
> H700 SoC with 1GB of RAM, 2 SD cards, and multiple input buttons.
>
> This bootloader has been tested on the Anbernic RG35XX-2024 and
> RG35XX-H, but should be suitable for the entire lineup of H700 based
> devices.
>
> A future series of updates will add board selection logic to identify
> and load the correct device tree automatically, and will switch to
> utilizing a mainline device tree.

I can already see the upstream DT subtree containing DTS for this board as:

./dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts

Are there any major differences that won't allow you to switch to
OF_UPSTREAM for this board?

-Sumit

>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/dts/Makefile                         |   3 +-
>  .../dts/sun50i-h700-anbernic-rg35xx-2024.dts  | 320 ++++++++++++++++++
>  board/sunxi/MAINTAINERS                       |   5 +
>  configs/anbernic_rg35xx_h700_defconfig        |  50 +++
>  4 files changed, 377 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
>  create mode 100644 configs/anbernic_rg35xx_h700_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3ae4110d60..886ab0312a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -679,10 +679,11 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
>         sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_MACH_SUN50I_H616) += \
>         sun50i-h616-orangepi-zero2.dtb \
> +       sun50i-h616-x96-mate.dtb \
>         sun50i-h618-orangepi-zero2w.dtb \
>         sun50i-h618-orangepi-zero3.dtb \
>         sun50i-h618-transpeed-8k618-t.dtb \
> -       sun50i-h616-x96-mate.dtb
> +       sun50i-h700-anbernic-rg35xx-2024.dtb
>  dtb-$(CONFIG_MACH_SUN50I) += \
>         sun50i-a64-amarula-relic.dtb \
>         sun50i-a64-bananapi-m64.dtb \
> diff --git a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
> new file mode 100644
> index 0000000000..75206af164
> --- /dev/null
> +++ b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2024 Ryan Walklin <ryan@testtoast.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +       model = "Anbernic RG35XX 2024";
> +       chassis-type = "handset";
> +       compatible = "anbernic,rg35xx-2024", "allwinner,sun50i-h700";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       gpio_keys_gamepad: gpio-keys-gamepad {
> +               compatible = "gpio-keys";
> +
> +               button-a {
> +                       label = "Action-Pad A";
> +                       gpios = <&pio 0 0 GPIO_ACTIVE_LOW>; /* PA0 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_EAST>;
> +               };
> +
> +               button-b {
> +                       label = "Action-Pad B";
> +                       gpios = <&pio 0 1 GPIO_ACTIVE_LOW>; /* PA1 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_SOUTH>;
> +               };
> +
> +               button-down {
> +                       label = "D-Pad Down";
> +                       gpios = <&pio 4 0 GPIO_ACTIVE_LOW>; /* PE0 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_DPAD_DOWN>;
> +               };
> +
> +               button-l1 {
> +                       label = "Key L1";
> +                       gpios = <&pio 0 10 GPIO_ACTIVE_LOW>; /* PA10 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_TL>;
> +               };
> +
> +               button-l2 {
> +                       label = "Key L2";
> +                       gpios = <&pio 0 11 GPIO_ACTIVE_LOW>; /* PA11 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_TL2>;
> +               };
> +
> +               button-left {
> +                       label = "D-Pad left";
> +                       gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_DPAD_LEFT>;
> +               };
> +
> +               button-menu {
> +                       label = "Key Menu";
> +                       gpios = <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_MODE>;
> +               };
> +
> +               button-r1 {
> +                       label = "Key R1";
> +                       gpios = <&pio 0 12 GPIO_ACTIVE_LOW>; /* PA12 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_TR>;
> +               };
> +
> +               button-r2 {
> +                       label = "Key R2";
> +                       gpios = <&pio 0 7 GPIO_ACTIVE_LOW>; /* PA7 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_TR2>;
> +               };
> +
> +               button-right {
> +                       label = "D-Pad Right";
> +                       gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_DPAD_RIGHT>;
> +               };
> +
> +               button-select {
> +                       label = "Key Select";
> +                       gpios = <&pio 0 5 GPIO_ACTIVE_LOW>; /* PA5 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_SELECT>;
> +               };
> +               button-start {
> +                       label = "Key Start";
> +                       gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_START>;
> +               };
> +
> +               button-up {
> +                       label = "D-Pad Up";
> +                       gpios = <&pio 0 6 GPIO_ACTIVE_LOW>; /* PA6 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_DPAD_UP>;
> +               };
> +
> +               button-x {
> +                       label = "Action-Pad X";
> +                       gpios = <&pio 0 3 GPIO_ACTIVE_LOW>; /* PA3 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_NORTH>;
> +               };
> +
> +               button-y {
> +                       label = "Action Pad Y";
> +                       gpios = <&pio 0 2 GPIO_ACTIVE_LOW>; /* PA2 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <BTN_WEST>;
> +               };
> +       };
> +
> +       gpio-keys-volume {
> +               compatible = "gpio-keys";
> +               autorepeat;
> +
> +               button-vol-up {
> +                       label = "Key Volume Up";
> +                       gpios = <&pio 4 1 GPIO_ACTIVE_LOW>; /* PE1 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +               };
> +
> +               button-vol-down {
> +                       label = "Key Volume Down";
> +                       gpios = <&pio 4 2 GPIO_ACTIVE_LOW>; /* PE2 */
> +                       linux,input-type = <EV_KEY>;
> +                       linux,code = <KEY_VOLUMEDOWN>;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               led-0 {
> +                       function = LED_FUNCTION_POWER;
> +                       color = <LED_COLOR_ID_GREEN>;
> +                       gpios = <&pio 8 12 GPIO_ACTIVE_HIGH>; /* PI12 */
> +                       default-state = "on";
> +               };
> +       };
> +
> +       reg_vcc5v: regulator-vcc5v { /* USB-C power input */
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc-5v";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&reg_dcdc1>;
> +};
> +
> +&mmc0 {
> +       vmmc-supply = <&reg_cldo3>;
> +       disable-wp;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
> +       bus-width = <4>;
> +       status = "okay";
> +};
> +
> +&pio {
> +       vcc-pa-supply = <&reg_cldo3>;
> +       vcc-pc-supply = <&reg_cldo3>;
> +       vcc-pe-supply = <&reg_cldo3>;
> +       vcc-pf-supply = <&reg_cldo3>;
> +       vcc-pg-supply = <&reg_aldo4>;
> +       vcc-ph-supply = <&reg_cldo3>;
> +       vcc-pi-supply = <&reg_cldo3>;
> +};
> +
> +&r_i2c {
> +       status = "okay";
> +
> +       axp717: pmic@34 {
> +               compatible = "x-powers,axp717";
> +               reg = <0x34>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               interrupt-parent = <&nmi_intc>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +
> +               vin1-supply = <&reg_vcc5v>;
> +               vin2-supply = <&reg_vcc5v>;
> +               vin3-supply = <&reg_vcc5v>;
> +               vin4-supply = <&reg_vcc5v>;
> +
> +               regulators {
> +                       reg_dcdc1: dcdc1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1160000>;
> +                               regulator-name = "vdd-cpu";
> +                       };
> +
> +                       reg_dcdc2: dcdc2 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <940000>;
> +                               regulator-max-microvolt = <940000>;
> +                               regulator-name = "vdd-gpu-sys";
> +                       };
> +
> +                       reg_dcdc3: dcdc3 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1100000>;
> +                               regulator-name = "vdd-dram";
> +                       };
> +
> +                       reg_aldo1: aldo1 {
> +                               /* 1.8v - unused */
> +                       };
> +
> +                       reg_aldo2: aldo2 {
> +                               /* 1.8v - unused */
> +                       };
> +
> +                       reg_aldo3: aldo3 {
> +                               /* 1.8v - unused */
> +                       };
> +
> +                       reg_aldo4: aldo4 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "vcc-pg";
> +                       };
> +
> +                       reg_bldo1: bldo1 {
> +                               /* 1.8v - unused */
> +                       };
> +
> +                       reg_bldo2: bldo2 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "vcc-pll";
> +                       };
> +
> +                       reg_bldo3: bldo3 {
> +                               /* 2.8v - unused */
> +                       };
> +
> +                       reg_bldo4: bldo4 {
> +                               /* 1.2v - unused */
> +                       };
> +
> +                       reg_cldo1: cldo1 {
> +                               /* 3.3v - audio codec - not yet implemented */
> +                       };
> +
> +                       reg_cldo2: cldo2 {
> +                               /* 3.3v - unused */
> +                       };
> +
> +                       reg_cldo3: cldo3 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc-io";
> +                       };
> +
> +                       reg_cldo4: cldo4 {
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc-wifi";
> +                       };
> +
> +                       reg_boost: boost {
> +                               regulator-min-microvolt = <5000000>;
> +                               regulator-max-microvolt = <5200000>;
> +                               regulator-name = "boost";
> +                       };
> +
> +                       reg_cpusldo: cpusldo {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1400000>;
> +                               regulator-name = "cpusldo";
> +                       };
> +               };
> +       };
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_ph_pins>;
> +       status = "okay";
> +};
> +
> +&usbotg {
> +       dr_mode = "peripheral";
> +       status = "okay";
> +};
> +
> +&usbphy {
> +       status = "okay";
> +};
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 4bcd9b9af7..e31c1b3a83 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -121,6 +121,11 @@ M: Paul Kocialkowski <contact@paulk.fr>
>  S:     Maintained
>  F:     configs/Ainol_AW1_defconfig
>
> +ANBERNIC RG35XX-2024
> +M:     Chris Morgan <macromorgan@hotmail.com>
> +S:     Maintained
> +F:     configs/anbernic_rg35xx_h700_defconfig
> +
>  AMARULA A64-RELIC
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  S:     Maintained
> diff --git a/configs/anbernic_rg35xx_h700_defconfig b/configs/anbernic_rg35xx_h700_defconfig
> new file mode 100644
> index 0000000000..e8958aaf57
> --- /dev/null
> +++ b/configs/anbernic_rg35xx_h700_defconfig
> @@ -0,0 +1,50 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h700-anbernic-rg35xx-2024"
> +CONFIG_SPL=y
> +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x08080808
> +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
> +CONFIG_DRAM_SUN50I_H616_ODT_EN=0x7887bbbb
> +CONFIG_DRAM_SUN50I_H616_TPR2=0x1
> +CONFIG_DRAM_SUN50I_H616_TPR6=0x40808080
> +CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6633
> +CONFIG_DRAM_SUN50I_H616_TPR11=0x1a1e1e1b
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=y
> +CONFIG_SUNXI_DRAM_H616_LPDDR4=y
> +CONFIG_DRAM_CLK=672
> +CONFIG_R_I2C_ENABLE=y
> +CONFIG_DEFAULT_FDT_FILE="sun50i-h700-anbernic-rg35xx-2024.dtb"
> +CONFIG_LAST_STAGE_INIT=y
> +CONFIG_SPL_I2C=y
> +CONFIG_CMD_BDINFO_EXTRA=y
> +CONFIG_CMD_BOOTDEV=y
> +CONFIG_CMD_BOOTMETH=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_BOOTM_OPENRTOS=y
> +CONFIG_BOOTM_OSE=y
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_CLK=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_BKOPS_ENABLE=y
> +CONFIG_CMD_MMC_REG=y
> +CONFIG_CMD_MMC_SWRITE=y
> +CONFIG_CMD_SDRAM=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_NET is not set
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SLAVE=0x7f
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_REGULATOR_AXP=y
> +CONFIG_AXP717_POWER=y
> +CONFIG_AXP_DCDC2_VOLT=940
> +CONFIG_AXP_DCDC3_VOLT=1100
> +CONFIG_REGEX=y
> +# CONFIG_EFI_LOADER is not set
> --
> 2.34.1
>
