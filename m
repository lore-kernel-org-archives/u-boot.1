Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC8AE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 05:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417668021D;
	Thu, 19 Dec 2024 06:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TS8cYkfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB108022B; Thu, 19 Dec 2024 06:31:11 +0100 (CET)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75858021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 06:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5187cd9b8e5so139322e0c.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 21:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734586267; x=1735191067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=STrCZE0dzutqo0TAeBrHW/ordSWXXdaLB31UaVm8T7c=;
 b=TS8cYkfZRgbhP6gQLrVz+BJx6jqf9E5SZv++L1viW3mb6iD1DTALSeimNvbR4DMmQ8
 Rway+n35xXw0IY++9otBQjTeubxAON4ZZUsAHCZGVarjE5HagIMsBUMqt7U2HOb3u1Vv
 Om5OoYJB/BI28Iun1MUDLvGeK3siLw34gTFmr828v/ds0Zf6BaUcPhgW2sU4hbhXBmkH
 6enX64na+ySXM+RJ23fqVJE+SQQE25/J1V8rNt7tI8/X1Mshl8FuXfs7VV2Fie13Ha4Y
 mnkjsJxn3qC0jOfAbsOZbrPLsGANGzq/xbtctCfkAkv5fDKmXB1mrfzTRvbANHFFnuE1
 BQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734586267; x=1735191067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=STrCZE0dzutqo0TAeBrHW/ordSWXXdaLB31UaVm8T7c=;
 b=qWbrYJhparj6AMr2Msg+4Qan5L5aYDJXi3PjAM34y5++gAeTf7xEAPRq1WZjR5iyu7
 0esMfZhL7NDiuNBayMG4oi3+M6fxdlpnNCAlR5ybrtFVDLMIKgoEAM2GJc8jMN1nAPWw
 sOg5H3FoaN4P0EPBWy9qdZzZtFo+88xgaL23RAmzOh+ENPy6vGa1x+gPRTQS9V2Bg2wa
 +zi4TqYstTnxZ2TD8O+R7srEJwOXMfhOQQ7hFIT/uM7GxKWKzLphDEbPyTNMiS/IGCm4
 Fpt6Ke+HLC4tVUCs0zxKUhShh2X/NH/0XvkldO9gzNe5NWJuX9s+rCB+3v+WQQUpMSxz
 bZ9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUShSSeq5Dl+blX3OTCEXNwgConqjOGyjOG6jCBLkPOWKt8H9RMv+knfsP96l3Dt3TdNCtbNSQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy06JcfCphRF6YCRKwRUIUMEyjDy1Cv+3tGpnnoNFuT2QSrA3ly
 oGurzqjOFORVHfp+887XFAAyMauVnyySJKw2zF0AsK1TQ3DmQUoV73DvjHadHYvGUikg+xTyN2B
 czPVyscz487Me1hjH93H2Oa6ccKL6AM63OE9Rog==
X-Gm-Gg: ASbGncuZJJuyDw5pCUYpxidNVaufhVlx+88b3yXjyarIkPChDLPxvcdGMAsznFmEP9T
 bX9nBaN+rjwFFtdIHSqmUaTt/9sXoh5sc067jj14=
X-Google-Smtp-Source: AGHT+IFrY3hjsxzyANdGSRZ2n50AW64GsIHocPkClm2a3nVqxQFrBqSlgMNhoyEI4QBH6dFeEIjA565Wo2si1eo9/P8=
X-Received: by 2002:a05:6122:8c07:b0:518:778b:70a1 with SMTP id
 71dfb90a1353d-51a36d9a250mr4458056e0c.7.1734586266482; Wed, 18 Dec 2024
 21:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20241218055514.3898679-1-u-kumar1@ti.com>
In-Reply-To: <20241218055514.3898679-1-u-kumar1@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 19 Dec 2024 11:00:55 +0530
Message-ID: <CAFA6WYOgL=GF=FZii80hG+YU63ydirzm6tTQYJf=qfgn_xf=Gg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-beagleboneai: Move to OF_UPSTREAM
To: Udit Kumar <u-kumar1@ti.com>
Cc: trini@konsulko.com, vigneshr@ti.com, n-francis@ti.com, 
 robertcnelson@gmail.com, u-boot@lists.denx.de, nm@ti.com, bb@ti.com
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

On Wed, 18 Dec 2024 at 11:25, Udit Kumar <u-kumar1@ti.com> wrote:
>
> Move to using OF_UPSTREAM config and thus using the devicetree
> subtree and remove unused device tree files.
>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Bootlog
> https://gist.github.com/uditkumarti/2f56822bab854cb9dcc06c69a8d1003a
>
>  arch/arm/dts/Makefile                         |   1 -
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |   4 +-
>  arch/arm/dts/k3-j721e-beagleboneai64.dts      | 993 ------------------
>  configs/j721e_beagleboneai64_a72_defconfig    |   3 +-
>  4 files changed, 4 insertions(+), 997 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-j721e-beagleboneai64.dts
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 6ad59aeed5..e64725441b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1164,7 +1164,6 @@ dtb-$(CONFIG_SOC_K3_AM654) += \
>  dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-r5-common-proc-board.dtb \
>                               k3-j7200-r5-common-proc-board.dtb \
>                               k3-j721e-r5-sk.dtb \
> -                             k3-j721e-beagleboneai64.dtb \
>                               k3-j721e-r5-beagleboneai64.dtb
>
>  dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-r5-base-board.dtb\
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> index 27851b7d08..8cefa39290 100644
> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> @@ -206,10 +206,10 @@
>  #ifdef CONFIG_TARGET_J721E_A72_BEAGLEBONEAI64
>
>  #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
> -#define SPL_J721E_BBAI64_DTB "spl/dts/k3-j721e-beagleboneai64.dtb"
> +#define SPL_J721E_BBAI64_DTB "spl/dts/ti/k3-j721e-beagleboneai64.dtb"
>
>  #define UBOOT_NODTB "u-boot-nodtb.bin"
> -#define J721E_BBAI64_DTB "arch/arm/dts/k3-j721e-beagleboneai64.dtb"
> +#define J721E_BBAI64_DTB "dts/upstream/src/arm64/ti/k3-j721e-beagleboneai64.dtb"
>
>  &binman {
>         ti-dm {
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64.dts b/arch/arm/dts/k3-j721e-beagleboneai64.dts
> deleted file mode 100644
> index 2f954729f3..0000000000
> --- a/arch/arm/dts/k3-j721e-beagleboneai64.dts
> +++ /dev/null
> @@ -1,993 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * https://beagleboard.org/ai-64
> - * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> - * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
> - * Copyright (C) 2022 Robert Nelson, BeagleBoard.org Foundation
> - */
> -
> -/dts-v1/;
> -
> -#include "k3-j721e.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/net/ti-dp83867.h>
> -#include <dt-bindings/phy/phy-cadence.h>
> -
> -/ {
> -       compatible = "beagle,j721e-beagleboneai64", "ti,j721e";
> -       model = "BeagleBoard.org BeagleBone AI-64";
> -
> -       aliases {
> -               serial0 = &wkup_uart0;
> -               serial2 = &main_uart0;
> -               mmc0 = &main_sdhci0;
> -               mmc1 = &main_sdhci1;
> -               i2c0 = &wkup_i2c0;
> -               i2c1 = &main_i2c6;
> -               i2c2 = &main_i2c2;
> -               i2c3 = &main_i2c4;
> -       };
> -
> -       chosen {
> -               stdout-path = "serial2:115200n8";
> -       };
> -
> -       memory@80000000 {
> -               device_type = "memory";
> -               /* 4G RAM */
> -               reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> -                     <0x00000008 0x80000000 0x00000000 0x80000000>;
> -       };
> -
> -       reserved_memory: reserved-memory {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               secure_ddr: optee@9e800000 {
> -                       reg = <0x00 0x9e800000 0x00 0x01800000>;
> -                       no-map;
> -               };
> -
> -               mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa0000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa0100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa1000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa1100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa2000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa2100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa3000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa3100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa4000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa4100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa5000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa5100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               c66_1_dma_memory_region: c66-dma-memory@a6000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa6000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               c66_0_memory_region: c66-memory@a6100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa6100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               c66_0_dma_memory_region: c66-dma-memory@a7000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa7000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               c66_1_memory_region: c66-memory@a7100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa7100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               c71_0_dma_memory_region: c71-dma-memory@a8000000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa8000000 0x00 0x100000>;
> -                       no-map;
> -               };
> -
> -               c71_0_memory_region: c71-memory@a8100000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0xa8100000 0x00 0xf00000>;
> -                       no-map;
> -               };
> -
> -               rtos_ipc_memory_region: ipc-memories@aa000000 {
> -                       reg = <0x00 0xaa000000 0x00 0x01c00000>;
> -                       alignment = <0x1000>;
> -                       no-map;
> -               };
> -       };
> -
> -       gpio_keys: gpio-keys {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&sw_pwr_pins_default>;
> -
> -               button-1 {
> -                       label = "BOOT";
> -                       linux,code = <BTN_0>;
> -                       gpios = <&wkup_gpio0 0 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               button-2 {
> -                       label = "POWER";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&wkup_gpio0 4 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       leds {
> -               compatible = "gpio-leds";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&led_pins_default>;
> -
> -               led-0 {
> -                       gpios = <&main_gpio0 96 GPIO_ACTIVE_HIGH>;
> -                       function = LED_FUNCTION_HEARTBEAT;
> -                       linux,default-trigger = "heartbeat";
> -               };
> -
> -               led-1 {
> -                       gpios = <&main_gpio0 95 GPIO_ACTIVE_HIGH>;
> -                       function = LED_FUNCTION_DISK_ACTIVITY;
> -                       linux,default-trigger = "mmc0";
> -               };
> -
> -               led-2 {
> -                       gpios = <&main_gpio0 97 GPIO_ACTIVE_HIGH>;
> -                       function = LED_FUNCTION_CPU;
> -                       linux,default-trigger = "cpu";
> -               };
> -
> -               led-3 {
> -                       gpios = <&main_gpio0 110 GPIO_ACTIVE_HIGH>;
> -                       function = LED_FUNCTION_DISK_ACTIVITY;
> -                       linux,default-trigger = "mmc1";
> -               };
> -
> -               led-4 {
> -                       gpios = <&main_gpio0 109 GPIO_ACTIVE_HIGH>;
> -                       function = LED_FUNCTION_WLAN;
> -                       default-state = "off";
> -               };
> -       };
> -
> -       evm_12v0: regulator-0 {
> -               /* main supply */
> -               compatible = "regulator-fixed";
> -               regulator-name = "evm_12v0";
> -               regulator-min-microvolt = <12000000>;
> -               regulator-max-microvolt = <12000000>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vsys_3v3: regulator-1 {
> -               /* Output of LMS140 */
> -               compatible = "regulator-fixed";
> -               regulator-name = "vsys_3v3";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               vin-supply = <&evm_12v0>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vsys_5v0: regulator-2 {
> -               /* Output of LM5140 */
> -               compatible = "regulator-fixed";
> -               regulator-name = "vsys_5v0";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -               vin-supply = <&evm_12v0>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vdd_mmc1: regulator-3 {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&sd_pwr_en_pins_default>;
> -               regulator-name = "vdd_mmc1";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-boot-on;
> -               enable-active-high;
> -               vin-supply = <&vsys_3v3>;
> -               gpio = <&main_gpio0 82 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       vdd_sd_dv_alt: regulator-4 {
> -               compatible = "regulator-gpio";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&vdd_sd_dv_alt_pins_default>;
> -               regulator-name = "tlv71033";
> -               regulator-min-microvolt = <1800000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-boot-on;
> -               vin-supply = <&vsys_5v0>;
> -               gpios = <&main_gpio0 117 GPIO_ACTIVE_HIGH>;
> -               states = <1800000 0x0>,
> -                        <3300000 0x1>;
> -       };
> -
> -       dp_pwr_3v3: regulator-5 {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&dp0_3v3_en_pins_default>;
> -               regulator-name = "dp-pwr";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               gpio = <&main_gpio0 49 GPIO_ACTIVE_HIGH>; /* DP0_PWR_SW_EN */
> -               enable-active-high;
> -       };
> -
> -       dp0: connector {
> -               compatible = "dp-connector";
> -               label = "DP0";
> -               type = "full-size";
> -               dp-pwr-supply = <&dp_pwr_3v3>;
> -
> -               port {
> -                       dp_connector_in: endpoint {
> -                               remote-endpoint = <&dp0_out>;
> -                       };
> -               };
> -       };
> -};
> -
> -&main_pmx0 {
> -       led_pins_default: led-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x184, PIN_INPUT, 7) /* (T23) RGMII5_RD0.GPIO0_96 */
> -                       J721E_IOPAD(0x180, PIN_INPUT, 7) /* (R23) RGMII5_RD1.GPIO0_95 */
> -                       J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
> -                       J721E_IOPAD(0x1bc, PIN_INPUT, 7) /* (V24) MDIO0_MDC.GPIO0_110 */
> -                       J721E_IOPAD(0x1b8, PIN_INPUT, 7) /* (V26) MDIO0_MDIO.GPIO0_109 */
> -               >;
> -       };
> -
> -       main_mmc1_pins_default: main-mmc1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
> -                       J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
> -                       J721E_IOPAD(0x2ac, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
> -                       J721E_IOPAD(0x24c, PIN_INPUT, 0) /* (R24) MMC1_DAT0 */
> -                       J721E_IOPAD(0x248, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
> -                       J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
> -                       J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
> -                       J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
> -               >;
> -       };
> -
> -       main_uart0_pins_default: main-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
> -                       J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
> -               >;
> -       };
> -
> -       sd_pwr_en_pins_default: sd-pwr-en-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x14c, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
> -               >;
> -       };
> -
> -       vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x1d8, PIN_INPUT, 7) /* (W4) SPI1_CS1.GPIO0_117 */
> -               >;
> -       };
> -
> -       main_usbss0_pins_default: main-usbss0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 - USBC_DIR */
> -               >;
> -       };
> -
> -       main_usbss1_pins_default: main-usbss1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x290, INPUT_DISABLE, 1) /* (U6) USB0_DRVVBUS.USB1_DRVVBUS */
> -               >;
> -       };
> -
> -       dp0_3v3_en_pins_default:dp0-3v3-en-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xc8, PIN_INPUT, 7) /* (AE26) PRG0_PRU0_GPO6.GPIO0_49 */
> -               >;
> -       };
> -
> -       dp0_pins_default: dp0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* (Y4) SPI0_CS1.DP0_HPD */
> -               >;
> -       };
> -
> -       main_i2c0_pins_default: main-i2c0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
> -                       J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
> -               >;
> -       };
> -
> -       main_i2c1_pins_default: main-i2c1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
> -                       J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
> -               >;
> -       };
> -
> -       main_i2c2_pins_default: main-i2c2-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x208, PIN_INPUT_PULLUP, 4) /* (W5) MCAN0_RX.I2C2_SCL */
> -                       J721E_IOPAD(0x20c, PIN_INPUT_PULLUP, 4) /* (W6) MCAN0_TX.I2C2_SDA */
> -                       J721E_IOPAD(0x138, PIN_INPUT, 7) /* (AE25) PRG0_PRU1_GPO14.GPIO0_77 */
> -                       J721E_IOPAD(0x13c, PIN_INPUT, 7) /* (AF29) PRG0_PRU1_GPO15.GPIO0_78 */
> -               >;
> -       };
> -
> -       main_i2c3_pins_default: main-i2c3-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
> -                       J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
> -               >;
> -       };
> -
> -       main_i2c4_pins_default: main-i2c4-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x1e0, PIN_INPUT_PULLUP, 2) /* (Y5) SPI1_D0.I2C4_SCL */
> -                       J721E_IOPAD(0x1dc, PIN_INPUT_PULLUP, 2) /* (Y1) SPI1_CLK.I2C4_SDA */
> -                       J721E_IOPAD(0x30, PIN_INPUT, 7) /* (AF24) PRG1_PRU0_GPO11.GPIO0_12 */
> -                       J721E_IOPAD(0x34, PIN_INPUT, 7) /* (AJ24) PRG1_PRU0_GPO12.GPIO0_13 */
> -               >;
> -       };
> -
> -       main_i2c5_pins_default: main-i2c5-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
> -                       J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
> -               >;
> -       };
> -
> -       main_i2c6_pins_default: main-i2c6-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
> -                       J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
> -                       J721E_IOPAD(0x74, PIN_INPUT, 7) /* (AC21) PRG1_PRU1_GPO7.GPIO0_28 */
> -                       J721E_IOPAD(0xa4, PIN_INPUT, 7) /* (AH22) PRG1_PRU1_GPO19.GPIO0_40 */
> -               >;
> -       };
> -
> -       csi0_gpio_pins_default: csi0-gpio-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x19c, PIN_INPUT_PULLDOWN, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
> -                       J721E_IOPAD(0x1a0, PIN_INPUT_PULLDOWN, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
> -               >;
> -       };
> -
> -       csi1_gpio_pins_default: csi1-gpio-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x198, PIN_INPUT_PULLDOWN, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
> -                       J721E_IOPAD(0x1b0, PIN_INPUT_PULLDOWN, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
> -               >;
> -       };
> -
> -       pcie1_rst_pins_default: pcie1-rst-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x5c, PIN_INPUT, 7) /* (AG23) PRG1_PRU1_GPO1.GPIO0_22 */
> -               >;
> -       };
> -};
> -
> -&wkup_pmx0 {
> -       eeprom_wp_pins_default: eeprom-wp-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xc4, PIN_OUTPUT_PULLUP, 7) /* (G24) WKUP_GPIO0_5 */
> -               >;
> -       };
> -
> -       mcu_adc0_pins_default: mcu-adc0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x130, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN0 */
> -                       J721E_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (K26) MCU_ADC0_AIN1 */
> -                       J721E_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (K28) MCU_ADC0_AIN2 */
> -                       J721E_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (L28) MCU_ADC0_AIN3 */
> -                       J721E_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN4 */
> -                       J721E_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (K27) MCU_ADC0_AIN5 */
> -                       J721E_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (K29) MCU_ADC0_AIN6 */
> -               >;
> -       };
> -
> -       mcu_adc1_pins_default: mcu-adc1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (N23) MCU_ADC1_AIN0 */
> -               >;
> -       };
> -
> -       mikro_bus_pins_default: mikro-bus-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x108, PIN_INPUT, 7) /* SDAPULLEN (E26) PMIC_POWER_EN0.WKUP_GPIO0_66 */
> -                       J721E_WKUP_IOPAD(0xd4, PIN_INPUT, 7) /* SDA (G26) WKUP_GPIO0_9.MCU_I2C1_SDA */
> -                       J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 7) /* SDA (D25) MCU_I3C0_SDA.WKUP_GPIO0_61 */
> -                       J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* SCL (G27) WKUP_GPIO0_8.MCU_I2C1_SCL */
> -                       J721E_WKUP_IOPAD(0xf0, PIN_INPUT, 7) /* SCL (D26) MCU_I3C0_SCL.WKUP_GPIO0_60 */
> -
> -                       J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* MOSI (F28) WKUP_GPIO0_2.MCU_SPI1_D1 */
> -                       J721E_WKUP_IOPAD(0xb4, PIN_INPUT, 7) /* MISO (F25) WKUP_GPIO0_1.MCU_SPI1_D0 */
> -                       J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 7) /* CLK (F26) WKUP_GPIO0_0.MCU_SPI1_CLK */
> -                       J721E_WKUP_IOPAD(0xbc, PIN_INPUT, 7) /* CS (F27) WKUP_GPIO0_3.MCU_SPI1_CS0 */
> -
> -                       J721E_WKUP_IOPAD(0x44, PIN_INPUT, 7) /* RX (G22) MCU_OSPI1_D1.WKUP_GPIO0_33 */
> -                       J721E_WKUP_IOPAD(0x48, PIN_INPUT, 7) /* TX (D23) MCU_OSPI1_D2.WKUP_GPIO0_34 */
> -
> -                       J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 7) /* INT (C23) MCU_OSPI1_D3.WKUP_GPIO0_35 */
> -                       J721E_WKUP_IOPAD(0x54, PIN_INPUT, 7) /* RST (E22) MCU_OSPI1_CSn1.WKUP_GPIO0_37 */
> -                       J721E_WKUP_IOPAD(0xdc, PIN_INPUT, 7) /* PWM (H27) WKUP_GPIO0_11 */
> -                       J721E_WKUP_IOPAD(0xac, PIN_INPUT, 7) /* AN (C29) MCU_MCAN0_RX.WKUP_GPIO0_59 */
> -               >;
> -       };
> -
> -       mcu_cpsw_pins_default: mcu-cpsw-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
> -                       J721E_WKUP_IOPAD(0x80, PIN_INPUT, 0) /* (A24) MCU_RGMII1_RD1 */
> -                       J721E_WKUP_IOPAD(0x7c, PIN_INPUT, 0) /* (D24) MCU_RGMII1_RD2 */
> -                       J721E_WKUP_IOPAD(0x78, PIN_INPUT, 0) /* (A25) MCU_RGMII1_RD3 */
> -                       J721E_WKUP_IOPAD(0x74, PIN_INPUT, 0) /* (C24) MCU_RGMII1_RXC */
> -                       J721E_WKUP_IOPAD(0x5c, PIN_INPUT, 0) /* (C25) MCU_RGMII1_RX_CTL */
> -                       J721E_WKUP_IOPAD(0x6c, PIN_OUTPUT, 0) /* (B25) MCU_RGMII1_TD0 */
> -                       J721E_WKUP_IOPAD(0x68, PIN_OUTPUT, 0) /* (A26) MCU_RGMII1_TD1 */
> -                       J721E_WKUP_IOPAD(0x64, PIN_OUTPUT, 0) /* (A27) MCU_RGMII1_TD2 */
> -                       J721E_WKUP_IOPAD(0x60, PIN_OUTPUT, 0) /* (A28) MCU_RGMII1_TD3 */
> -                       J721E_WKUP_IOPAD(0x70, PIN_OUTPUT, 0) /* (B26) MCU_RGMII1_TXC */
> -                       J721E_WKUP_IOPAD(0x58, PIN_OUTPUT, 0) /* (B27) MCU_RGMII1_TX_CTL */
> -               >;
> -       };
> -
> -       mcu_mdio_pins_default: mcu-mdio1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x8c, PIN_OUTPUT, 0) /* (F23) MCU_MDIO0_MDC */
> -                       J721E_WKUP_IOPAD(0x88, PIN_INPUT, 0) /* (E23) MCU_MDIO0_MDIO */
> -               >;
> -       };
> -
> -       sw_pwr_pins_default: sw-pwr-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xc0, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_4 */
> -               >;
> -       };
> -
> -       wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
> -                       J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
> -               >;
> -       };
> -
> -       wkup_uart0_pins_default: wkup-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
> -                       J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
> -               >;
> -       };
> -
> -       mcu_usbss1_pins_default: mcu-usbss1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO0_30 */
> -               >;
> -       };
> -};
> -
> -&wkup_uart0 {
> -       /* Wakeup UART is used by TIFS firmware. */
> -       status = "reserved";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&wkup_uart0_pins_default>;
> -};
> -
> -&main_uart0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_uart0_pins_default>;
> -       /* Shared with ATF on this platform */
> -       power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> -};
> -
> -&main_sdhci0 {
> -       /* eMMC */
> -       status = "okay";
> -       non-removable;
> -       ti,driver-strength-ohm = <50>;
> -       disable-wp;
> -};
> -
> -&main_sdhci1 {
> -       /* SD Card */
> -       status = "okay";
> -       vmmc-supply = <&vdd_mmc1>;
> -       vqmmc-supply = <&vdd_sd_dv_alt>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_mmc1_pins_default>;
> -       ti,driver-strength-ohm = <50>;
> -       disable-wp;
> -};
> -
> -&main_i2c0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c0_pins_default>;
> -       clock-frequency = <400000>;
> -};
> -
> -&main_i2c1 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c1_pins_default>;
> -       clock-frequency = <400000>;
> -};
> -
> -&main_i2c2 {
> -       /* BBB Header: P9.19 and P9.20 */
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c2_pins_default>;
> -       clock-frequency = <100000>;
> -};
> -
> -&main_i2c3 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c3_pins_default>;
> -       clock-frequency = <400000>;
> -};
> -
> -&main_i2c4 {
> -       /* BBB Header: P9.24 and P9.26 */
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c4_pins_default>;
> -       clock-frequency = <100000>;
> -};
> -
> -&main_i2c5 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c5_pins_default>;
> -       clock-frequency = <400000>;
> -};
> -
> -&main_i2c6 {
> -       /* BBB Header: P9.17 and P9.18 */
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c6_pins_default>;
> -       clock-frequency = <100000>;
> -       status = "okay";
> -};
> -
> -&wkup_i2c0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&wkup_i2c0_pins_default>;
> -       clock-frequency = <400000>;
> -
> -       eeprom@50 {
> -               compatible = "atmel,24c04";
> -               reg = <0x50>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&eeprom_wp_pins_default>;
> -       };
> -};
> -
> -&wkup_gpio0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_adc0_pins_default>, <&mcu_adc1_pins_default>,
> -                   <&mikro_bus_pins_default>;
> -};
> -
> -&main_gpio0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&csi1_gpio_pins_default>, <&csi0_gpio_pins_default>;
> -};
> -
> -&main_gpio1 {
> -       status = "okay";
> -};
> -
> -&usb_serdes_mux {
> -       idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
> -};
> -
> -&serdes_ln_ctrl {
> -       idle-states = <J721E_SERDES0_LANE0_IP4_UNUSED>, <J721E_SERDES0_LANE1_IP4_UNUSED>,
> -                     <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
> -                     <J721E_SERDES2_LANE0_IP1_UNUSED>, <J721E_SERDES2_LANE1_USB3_1>,
> -                     <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
> -                     <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
> -                     <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
> -};
> -
> -&serdes_wiz3 {
> -       typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_LOW>;
> -       typec-dir-debounce-ms = <700>;  /* TUSB321, tCCB_DEFAULT 133 ms */
> -};
> -
> -&serdes3 {
> -       serdes3_usb_link: phy@0 {
> -               reg = <0>;
> -               cdns,num-lanes = <2>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_USB3>;
> -               resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
> -       };
> -};
> -
> -&serdes4 {
> -       torrent_phy_dp: phy@0 {
> -               reg = <0>;
> -               resets = <&serdes_wiz4 1>;
> -               cdns,phy-type = <PHY_TYPE_DP>;
> -               cdns,num-lanes = <4>;
> -               cdns,max-bit-rate = <5400>;
> -               #phy-cells = <0>;
> -       };
> -};
> -
> -&mhdp {
> -       phys = <&torrent_phy_dp>;
> -       phy-names = "dpphy";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&dp0_pins_default>;
> -};
> -
> -&usbss0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_usbss0_pins_default>;
> -       ti,vbus-divider;
> -};
> -
> -&usb0 {
> -       dr_mode = "peripheral";
> -       maximum-speed = "super-speed";
> -       phys = <&serdes3_usb_link>;
> -       phy-names = "cdns3,usb3-phy";
> -};
> -
> -&serdes2 {
> -       serdes2_usb_link: phy@1 {
> -               reg = <1>;
> -               cdns,num-lanes = <1>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_USB3>;
> -               resets = <&serdes_wiz2 2>;
> -       };
> -};
> -
> -&usbss1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_usbss1_pins_default>, <&mcu_usbss1_pins_default>;
> -       ti,vbus-divider;
> -};
> -
> -&usb1 {
> -       dr_mode = "host";
> -       maximum-speed = "super-speed";
> -       phys = <&serdes2_usb_link>;
> -       phy-names = "cdns3,usb3-phy";
> -};
> -
> -&tscadc0 {
> -       status = "okay";
> -       /* BBB Header: P9.39, P9.40, P9.37, P9.38, P9.33, P9.36, P9.35 */
> -       adc {
> -               ti,adc-channels = <0 1 2 3 4 5 6>;
> -       };
> -};
> -
> -&tscadc1 {
> -       status = "okay";
> -       /* MCU mikroBUS Header J10.1 - MCU_ADC1_AIN0 */
> -       adc {
> -               ti,adc-channels = <0>;
> -       };
> -};
> -
> -&mcu_cpsw {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_cpsw_pins_default>;
> -};
> -
> -&davinci_mdio {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_mdio_pins_default>;
> -
> -       phy0: ethernet-phy@0 {
> -               reg = <0>;
> -               ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> -               ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> -       };
> -};
> -
> -&cpsw_port1 {
> -       phy-mode = "rgmii-rxid";
> -       phy-handle = <&phy0>;
> -};
> -
> -&dss {
> -       /*
> -        * These clock assignments are chosen to enable the following outputs:
> -        *
> -        * VP0 - DisplayPort SST
> -        * VP1 - DPI0
> -        * VP2 - DSI
> -        * VP3 - DPI1
> -        */
> -
> -       assigned-clocks = <&k3_clks 152 1>,     /* VP 1 pixel clock */
> -                         <&k3_clks 152 4>,     /* VP 2 pixel clock */
> -                         <&k3_clks 152 9>,     /* VP 3 pixel clock */
> -                         <&k3_clks 152 13>;    /* VP 4 pixel clock */
> -       assigned-clock-parents = <&k3_clks 152 2>,      /* PLL16_HSDIV0 */
> -                                <&k3_clks 152 6>,      /* PLL19_HSDIV0 */
> -                                <&k3_clks 152 11>,     /* PLL18_HSDIV0 */
> -                                <&k3_clks 152 18>;     /* PLL23_HSDIV0 */
> -};
> -
> -&dss_ports {
> -       port {
> -               dpi0_out: endpoint {
> -                       remote-endpoint = <&dp0_in>;
> -               };
> -       };
> -};
> -
> -&dp0_ports {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -
> -       port@0 {
> -               reg = <0>;
> -               dp0_in: endpoint {
> -                       remote-endpoint = <&dpi0_out>;
> -               };
> -       };
> -
> -       port@4 {
> -               reg = <4>;
> -               dp0_out: endpoint {
> -                       remote-endpoint = <&dp_connector_in>;
> -               };
> -       };
> -};
> -
> -&serdes0 {
> -       serdes0_pcie_link: phy@0 {
> -               reg = <0>;
> -               cdns,num-lanes = <1>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_PCIE>;
> -               resets = <&serdes_wiz0 1>;
> -       };
> -};
> -
> -&serdes1 {
> -       serdes1_pcie_link: phy@0 {
> -               reg = <0>;
> -               cdns,num-lanes = <2>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_PCIE>;
> -               resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
> -       };
> -};
> -
> -&pcie1_rc {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pcie1_rst_pins_default>;
> -       phys = <&serdes1_pcie_link>;
> -       phy-names = "pcie-phy";
> -       num-lanes = <2>;
> -       max-link-speed = <3>;
> -       reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&ufs_wrapper {
> -       status = "disabled";
> -};
> -
> -&mailbox0_cluster0 {
> -       status = "okay";
> -       interrupts = <436>;
> -
> -       mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -
> -       mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
> -               ti,mbox-rx = <2 0 0>;
> -               ti,mbox-tx = <3 0 0>;
> -       };
> -};
> -
> -&mailbox0_cluster1 {
> -       status = "okay";
> -       interrupts = <432>;
> -
> -       mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -
> -       mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> -               ti,mbox-rx = <2 0 0>;
> -               ti,mbox-tx = <3 0 0>;
> -       };
> -};
> -
> -&mailbox0_cluster2 {
> -       status = "okay";
> -       interrupts = <428>;
> -
> -       mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -
> -       mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> -               ti,mbox-rx = <2 0 0>;
> -               ti,mbox-tx = <3 0 0>;
> -       };
> -};
> -
> -&mailbox0_cluster3 {
> -       status = "okay";
> -       interrupts = <424>;
> -
> -       mbox_c66_0: mbox-c66-0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -
> -       mbox_c66_1: mbox-c66-1 {
> -               ti,mbox-rx = <2 0 0>;
> -               ti,mbox-tx = <3 0 0>;
> -       };
> -};
> -
> -&mailbox0_cluster4 {
> -       status = "okay";
> -       interrupts = <420>;
> -
> -       mbox_c71_0: mbox-c71-0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -};
> -
> -&mcu_r5fss0_core0 {
> -       mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
> -       memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> -                       <&mcu_r5fss0_core0_memory_region>;
> -};
> -
> -&mcu_r5fss0_core1 {
> -       mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
> -       memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
> -                       <&mcu_r5fss0_core1_memory_region>;
> -};
> -
> -&main_r5fss0_core0 {
> -       mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
> -       memory-region = <&main_r5fss0_core0_dma_memory_region>,
> -                       <&main_r5fss0_core0_memory_region>;
> -};
> -
> -&main_r5fss0_core1 {
> -       mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
> -       memory-region = <&main_r5fss0_core1_dma_memory_region>,
> -                       <&main_r5fss0_core1_memory_region>;
> -};
> -
> -&main_r5fss1_core0 {
> -       mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
> -       memory-region = <&main_r5fss1_core0_dma_memory_region>,
> -                       <&main_r5fss1_core0_memory_region>;
> -};
> -
> -&main_r5fss1_core1 {
> -       mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
> -       memory-region = <&main_r5fss1_core1_dma_memory_region>,
> -                       <&main_r5fss1_core1_memory_region>;
> -};
> -
> -&c66_0 {
> -       status = "okay";
> -       mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
> -       memory-region = <&c66_0_dma_memory_region>,
> -                       <&c66_0_memory_region>;
> -};
> -
> -&c66_1 {
> -       status = "okay";
> -       mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
> -       memory-region = <&c66_1_dma_memory_region>,
> -                       <&c66_1_memory_region>;
> -};
> -
> -&c71_0 {
> -       status = "okay";
> -       mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
> -       memory-region = <&c71_0_dma_memory_region>,
> -                       <&c71_0_memory_region>;
> -};
> diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
> index ed75f7ee05..a5d95975fb 100644
> --- a/configs/j721e_beagleboneai64_a72_defconfig
> +++ b/configs/j721e_beagleboneai64_a72_defconfig
> @@ -13,7 +13,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_DM_GPIO=y
>  CONFIG_SPL_DM_SPI=y
> -CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-beagleboneai64"
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j721e-beagleboneai64"
>  CONFIG_SPL_TEXT_BASE=0x80080000
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
> @@ -173,5 +173,6 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6163
>  CONFIG_SPL_DFU=y
>  CONFIG_LZO=y
>  CONFIG_EFI_SET_TIME=y
> +CONFIG_OF_UPSTREAM=y
>
>  #include <configs/k3_efi_capsule.config>
> --
> 2.34.1
>
