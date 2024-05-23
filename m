Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B55C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 12:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A74788013;
	Thu, 23 May 2024 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oLnQiIRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD1C88578; Thu, 23 May 2024 09:43:40 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E142787915
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 09:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-47f13801f3aso649533137.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716450214; x=1717055014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBcqGtyXr/ObP7ivEr/sf11p3rOZ9xHnT0JZLHKJtao=;
 b=oLnQiIRv5TeFI/IxD7+RCe6/EDx7lfBcNVkCKAr2iAwe1PzEolVWaL2YY8q2e/dERi
 c4by/0GDWbAyb5siN4brbbh2VmGfqbCVqpg59YEsKIw571vhgeKwuMvnrt5QT+4KTmVh
 ZR4vJQWi4HRtTFKTVb2uevSsp0+gMCYXOaruTp6rd4iQRvo/d6DOSHy5AzAfV6kQsojv
 sECHS1ah9KB1muDgw2FgkCiR6HEAK8NSthaJcoLW7tYm/+JbRvvWKE/ArUVdvO5/HEnq
 kt0Q5yQKgnZ7EnVF+jtvov7R39vHIhbn7Yre3v8iKDm2CVEftIu49VhzAVeH56yvmJxx
 rl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716450214; x=1717055014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBcqGtyXr/ObP7ivEr/sf11p3rOZ9xHnT0JZLHKJtao=;
 b=odHlDIWiozX6Z5ASfy4mt5sMwxtg3MbU1I9CowJXaN7c4Mo1tXO9BZ7LtxsAXHyN/W
 VXJTe6XhfBBv1vwWw74lb3iJUNjIBGqY3DCn7VZuAD0o/zT+ZuSZMidlBUvFkzhcpb/P
 Hs+thK7/r8+XENpjqJTWZI09Jv79agzApMPtDhBPUBeyLczP3a1+5hiMTRP3eKTsiLwl
 Qv2vTQgekpRXtbwlL60yZEqvTbyURhzrljq7wNa+3RnB9mU8lh2VuGQLb1AVOR9WVlp9
 qbmEJS2Zo9YhJurQjp4mR6TAAom8AbUvKU+s8BdoM9dWMhQih6KfOcckKiwDDYok6frk
 mjyw==
X-Gm-Message-State: AOJu0Ywi1V3uWwTVq9kgnkBYi/Qefa5DRsNjgo/1gxp3zq55l4RebxxA
 Nkr70awrZLPnx9FD4y9gvUtVg75stnZ2+iplK6o2X1pEH+8ThyKPCPAp3kfDeeQ0TDmE30Z3DpI
 /RSV6SWD7WF3ov+gh4QEyZ2x4zguPQGTgKcIdkw==
X-Google-Smtp-Source: AGHT+IHou3eeaVZvbkAwym29htThuoGvWPxseioMBXyi8AeuLd5penft7NAJeyV5rlzZhwAlW3z2d/yt2TPAe9k7u7w=
X-Received: by 2002:a05:6102:26d6:b0:47f:4310:39c4 with SMTP id
 ada2fe7eead31-48900936621mr4398227137.2.1716450213933; Thu, 23 May 2024
 00:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240521054842.2121479-1-a-limaye@ti.com>
In-Reply-To: <20240521054842.2121479-1-a-limaye@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 23 May 2024 13:13:22 +0530
Message-ID: <CAFA6WYMpkyf5dMAEy-UF-fkFWAzsb-4XVjRidOi-Ta=nLR1NJA@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: k3-j7200: Move to OF_UPSTREAM
To: Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, u-kumar1@ti.com, 
 n-francis@ti.com, m-chawdhry@ti.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 23 May 2024 14:33:40 +0200
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

On Tue, 21 May 2024 at 11:18, Aniket Limaye <a-limaye@ti.com> wrote:
>
> Move to using OF_UPSTREAM config and thus using the devicetree-rebasing
> subtree.
>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>
> Boot logs:
> https://gist.github.com/aniket-l/aab91bb12d2495c54da094fca49c369f
>
> Changes in v2:
> - Rebased to next
> - Removed dependency on binman templating series [1] as per [2]
>
> [1]: https://lore.kernel.org/all/20240322131011.1029620-1-n-francis@ti.com/
> [2]: https://lore.kernel.org/u-boot/20240520095916.1809962-1-n-francis@ti.com/
>
> ---
>  arch/arm/dts/Makefile                         |    1 -
>  arch/arm/dts/k3-j7200-binman.dtsi             |    2 +-
>  .../k3-j7200-common-proc-board-u-boot.dtsi    |   14 +-
>  arch/arm/dts/k3-j7200-common-proc-board.dts   |  396 -----
>  arch/arm/dts/k3-j7200-main.dtsi               | 1284 -----------------
>  arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |  647 ---------
>  arch/arm/dts/k3-j7200-som-p0.dtsi             |  327 -----
>  arch/arm/dts/k3-j7200-thermal.dtsi            |   47 -
>  arch/arm/dts/k3-j7200.dtsi                    |  164 ---
>  configs/j7200_evm_a72_defconfig               |    3 +-
>  10 files changed, 8 insertions(+), 2877 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-j7200-common-proc-board.dts
>  delete mode 100644 arch/arm/dts/k3-j7200-main.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-som-p0.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200.dtsi
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index f7032f1e175..ea8fee8e25c 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1194,7 +1194,6 @@ dtb-$(CONFIG_SOC_K3_AM654) += \
>
>  dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-common-proc-board.dtb \
>                               k3-j721e-r5-common-proc-board.dtb \
> -                             k3-j7200-common-proc-board.dtb \
>                               k3-j7200-r5-common-proc-board.dtb \
>                               k3-j721e-sk.dtb \
>                               k3-j721e-r5-sk.dtb \
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index 06db8659876..b6e0aa37971 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -180,7 +180,7 @@
>
>  #ifdef CONFIG_TARGET_J7200_A72_EVM
>
> -#define SPL_J7200_EVM_DTB "spl/dts/k3-j7200-common-proc-board.dtb"
> +#define SPL_J7200_EVM_DTB "spl/dts/ti/k3-j7200-common-proc-board.dtb"
>  #define J7200_EVM_DTB "u-boot.dtb"
>
>  &binman {
> diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> index 485f17c5f06..045ef170e17 100644
> --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> @@ -26,8 +26,12 @@
>  &cbass_mcu_wakeup {
>         bootph-all;
>
> -       chipid@43000014 {
> +       wkup_conf: bus@43000000 {
>                 bootph-all;
> +
> +               chipid: chipid@14 {
> +                       bootph-all;
> +               };
>         };
>  };
>
> @@ -40,14 +44,6 @@
>  };
>
>  &mcu_udmap {
> -       reg = <0x0 0x285c0000 0x0 0x100>,
> -               <0x0 0x284c0000 0x0 0x4000>,
> -               <0x0 0x2a800000 0x0 0x40000>,
> -               <0x0 0x284a0000 0x0 0x4000>,
> -               <0x0 0x2aa00000 0x0 0x40000>,
> -               <0x0 0x28400000 0x0 0x2000>;
> -       reg-names = "gcfg", "rchan", "rchanrt", "tchan",
> -                           "tchanrt", "rflow";
>         bootph-all;
>  };
>
> diff --git a/arch/arm/dts/k3-j7200-common-proc-board.dts b/arch/arm/dts/k3-j7200-common-proc-board.dts
> deleted file mode 100644
> index cee2b4b0eb8..00000000000
> --- a/arch/arm/dts/k3-j7200-common-proc-board.dts
> +++ /dev/null
> @@ -1,396 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -/dts-v1/;
> -
> -#include "k3-j7200-som-p0.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/net/ti-dp83867.h>
> -#include <dt-bindings/phy/phy.h>
> -
> -#include "k3-serdes.h"
> -
> -/ {
> -       compatible = "ti,j7200-evm", "ti,j7200";
> -       model = "Texas Instruments J7200 EVM";
> -
> -       aliases {
> -               serial0 = &wkup_uart0;
> -               serial1 = &mcu_uart0;
> -               serial2 = &main_uart0;
> -               serial3 = &main_uart1;
> -               serial5 = &main_uart3;
> -               mmc0 = &main_sdhci0;
> -               mmc1 = &main_sdhci1;
> -       };
> -
> -       chosen {
> -               stdout-path = "serial2:115200n8";
> -       };
> -
> -       evm_12v0: fixedregulator-evm12v0 {
> -               /* main supply */
> -               compatible = "regulator-fixed";
> -               regulator-name = "evm_12v0";
> -               regulator-min-microvolt = <12000000>;
> -               regulator-max-microvolt = <12000000>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vsys_3v3: fixedregulator-vsys3v3 {
> -               /* Output of LM5140 */
> -               compatible = "regulator-fixed";
> -               regulator-name = "vsys_3v3";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               vin-supply = <&evm_12v0>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vsys_5v0: fixedregulator-vsys5v0 {
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
> -       vdd_mmc1: fixedregulator-sd {
> -               /* Output of TPS22918 */
> -               compatible = "regulator-fixed";
> -               regulator-name = "vdd_mmc1";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-boot-on;
> -               enable-active-high;
> -               vin-supply = <&vsys_3v3>;
> -               gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       vdd_sd_dv: gpio-regulator-TLV71033 {
> -               /* Output of TLV71033 */
> -               compatible = "regulator-gpio";
> -               regulator-name = "tlv71033";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&vdd_sd_dv_pins_default>;
> -               regulator-min-microvolt = <1800000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-boot-on;
> -               vin-supply = <&vsys_5v0>;
> -               gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
> -               states = <1800000 0x0>,
> -                        <3300000 0x1>;
> -       };
> -};
> -
> -&wkup_pmx0 {
> -       mcu_uart0_pins_default: mcu-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
> -                       J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
> -                       J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
> -                       J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
> -               >;
> -       };
> -
> -       wkup_uart0_pins_default: wkup-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
> -                       J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
> -               >;
> -       };
> -};
> -
> -&wkup_pmx2 {
> -       mcu_cpsw_pins_default: mcu-cpsw-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
> -                       J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
> -                       J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
> -                       J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
> -                       J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
> -                       J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
> -                       J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
> -                       J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
> -                       J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
> -                       J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
> -                       J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
> -                       J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
> -               >;
> -       };
> -
> -       wkup_gpio_pins_default: wkup-gpio-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x70, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
> -               >;
> -       };
> -
> -       mcu_mdio_pins_default: mcu-mdio1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
> -                       J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
> -               >;
> -       };
> -};
> -
> -&main_pmx0 {
> -       main_uart0_pins_default: main-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
> -                       J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
> -                       J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
> -                       J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
> -               >;
> -       };
> -
> -       main_uart1_pins_default: main-uart1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xb8, PIN_INPUT, 0) /* (T18) UART1_RXD */
> -                       J721E_IOPAD(0xbc, PIN_INPUT, 0) /* (T20) UART1_TXD */
> -               >;
> -       };
> -
> -       main_uart3_pins_default: main-uart3-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x60, PIN_INPUT, 11) /* (T15) MCAN8_TX.UART3_CTSn */
> -                       J721E_IOPAD(0x30, PIN_INPUT, 11) /* (Y18) MCAN2_TX.UART3_RXD */
> -               >;
> -       };
> -
> -       main_i2c1_pins_default: main-i2c1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
> -                       J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
> -               >;
> -       };
> -
> -       main_mmc1_pins_default: main-mmc1-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
> -                       J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
> -                       J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
> -                       J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
> -                       J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
> -                       J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
> -                       J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
> -                       J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
> -               >;
> -       };
> -
> -       vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
> -               >;
> -       };
> -};
> -
> -&main_pmx1 {
> -       main_usbss0_pins_default: main-usbss0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
> -               >;
> -       };
> -};
> -
> -&wkup_uart0 {
> -       /* Wakeup UART is used by System firmware */
> -       status = "reserved";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&wkup_uart0_pins_default>;
> -};
> -
> -&mcu_uart0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_uart0_pins_default>;
> -       clock-frequency = <96000000>;
> -};
> -
> -&main_uart0 {
> -       status = "okay";
> -       /* Shared with ATF on this platform */
> -       power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_uart0_pins_default>;
> -};
> -
> -&main_uart1 {
> -       status = "okay";
> -       /* Default pinmux */
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_uart1_pins_default>;
> -};
> -
> -&main_uart2 {
> -       /* MAIN UART 2 is used by R5F firmware */
> -       status = "reserved";
> -};
> -
> -&main_uart3 {
> -       /* Shared with MCAN Interface */
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_uart3_pins_default>;
> -};
> -
> -&main_gpio0 {
> -       status = "okay";
> -};
> -
> -&wkup_gpio0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&wkup_gpio_pins_default>;
> -};
> -
> -&mcu_cpsw {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
> -};
> -
> -&davinci_mdio {
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
> -&main_i2c0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c0_pins_default>;
> -       clock-frequency = <400000>;
> -
> -       exp1: gpio@20 {
> -               compatible = "ti,tca6416";
> -               reg = <0x20>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -       };
> -
> -       exp2: gpio@22 {
> -               compatible = "ti,tca6424";
> -               reg = <0x22>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -       };
> -};
> -
> -/*
> - * The j7200 CPB board is identical to the CPB used for J721E, the SOMs can be
> - * swapped on the CPB.
> - *
> - * main_i2c1 of J7200 is connected to the CPB i2c bus labeled as i2c3.
> - * The i2c1 of the CPB (as it is labeled) is not connected to j7200.
> - */
> -&main_i2c1 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c1_pins_default>;
> -       clock-frequency = <400000>;
> -
> -       exp3: gpio@20 {
> -               compatible = "ti,tca6408";
> -               reg = <0x20>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               gpio-line-names = "CODEC_RSTz", "CODEC_SPARE1", "UB926_RESETn",
> -                                 "UB926_LOCK", "UB926_PWR_SW_CNTRL",
> -                                 "UB926_TUNER_RESET", "UB926_GPIO_SPARE", "";
> -       };
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
> -       /* SD card */
> -       status = "okay";
> -       pinctrl-0 = <&main_mmc1_pins_default>;
> -       pinctrl-names = "default";
> -       vmmc-supply = <&vdd_mmc1>;
> -       vqmmc-supply = <&vdd_sd_dv>;
> -       ti,driver-strength-ohm = <50>;
> -       disable-wp;
> -};
> -
> -&serdes_ln_ctrl {
> -       idle-states = <J7200_SERDES0_LANE0_PCIE1_LANE0>, <J7200_SERDES0_LANE1_PCIE1_LANE1>,
> -                     <J7200_SERDES0_LANE2_QSGMII_LANE1>, <J7200_SERDES0_LANE3_IP4_UNUSED>;
> -};
> -
> -&usb_serdes_mux {
> -       idle-states = <1>; /* USB0 to SERDES lane 3 */
> -};
> -
> -&usbss0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_usbss0_pins_default>;
> -       ti,vbus-divider;
> -       ti,usb2-only;
> -};
> -
> -&usb0 {
> -       dr_mode = "otg";
> -       maximum-speed = "high-speed";
> -};
> -
> -&tscadc0 {
> -       adc {
> -               ti,adc-channels = <0 1 2 3 4 5 6 7>;
> -       };
> -};
> -
> -&serdes_refclk {
> -       clock-frequency = <100000000>;
> -};
> -
> -&serdes0 {
> -       serdes0_pcie_link: phy@0 {
> -               reg = <0>;
> -               cdns,num-lanes = <2>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_PCIE>;
> -               resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
> -       };
> -
> -       serdes0_qsgmii_link: phy@1 {
> -               reg = <2>;
> -               cdns,num-lanes = <1>;
> -               #phy-cells = <0>;
> -               cdns,phy-type = <PHY_TYPE_QSGMII>;
> -               resets = <&serdes_wiz0 3>;
> -       };
> -};
> -
> -&pcie1_rc {
> -       reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
> -       phys = <&serdes0_pcie_link>;
> -       phy-names = "pcie-phy";
> -       num-lanes = <2>;
> -};
> -
> -&pcie1_ep {
> -       phys = <&serdes0_pcie_link>;
> -       phy-names = "pcie-phy";
> -       num-lanes = <2>;
> -       status = "disabled";
> -};
> diff --git a/arch/arm/dts/k3-j7200-main.dtsi b/arch/arm/dts/k3-j7200-main.dtsi
> deleted file mode 100644
> index 264913f8328..00000000000
> --- a/arch/arm/dts/k3-j7200-main.dtsi
> +++ /dev/null
> @@ -1,1284 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for J7200 SoC Family Main Domain peripherals
> - *
> - * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -/ {
> -       serdes_refclk: serdes-refclk {
> -               #clock-cells = <0>;
> -               compatible = "fixed-clock";
> -       };
> -};
> -
> -&cbass_main {
> -       msmc_ram: sram@70000000 {
> -               compatible = "mmio-sram";
> -               reg = <0x00 0x70000000 0x00 0x100000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0x00 0x00 0x70000000 0x100000>;
> -
> -               atf-sram@0 {
> -                       reg = <0x00 0x20000>;
> -               };
> -       };
> -
> -       scm_conf: scm-conf@100000 {
> -               compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> -               reg = <0x00 0x00100000 0x00 0x1c000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0x00 0x00 0x00100000 0x1c000>;
> -
> -               serdes_ln_ctrl: mux-controller@4080 {
> -                       compatible = "mmio-mux";
> -                       #mux-control-cells = <1>;
> -                       mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> -                                       <0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
> -               };
> -
> -               cpsw0_phy_gmii_sel: phy@4044 {
> -                       compatible = "ti,j7200-cpsw5g-phy-gmii-sel";
> -                       ti,qsgmii-main-ports = <1>;
> -                       reg = <0x4044 0x10>;
> -                       #phy-cells = <1>;
> -               };
> -
> -               usb_serdes_mux: mux-controller@4000 {
> -                       compatible = "mmio-mux";
> -                       #mux-control-cells = <1>;
> -                       mux-reg-masks = <0x4000 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
> -               };
> -       };
> -
> -       gic500: interrupt-controller@1800000 {
> -               compatible = "arm,gic-v3";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -               #interrupt-cells = <3>;
> -               interrupt-controller;
> -               reg = <0x00 0x01800000 0x00 0x10000>,   /* GICD */
> -                     <0x00 0x01900000 0x00 0x100000>,  /* GICR */
> -                     <0x00 0x6f000000 0x00 0x2000>,    /* GICC */
> -                     <0x00 0x6f010000 0x00 0x1000>,    /* GICH */
> -                     <0x00 0x6f020000 0x00 0x2000>;    /* GICV */
> -
> -               /* vcpumntirq: virtual CPU interface maintenance interrupt */
> -               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               gic_its: msi-controller@1820000 {
> -                       compatible = "arm,gic-v3-its";
> -                       reg = <0x00 0x01820000 0x00 0x10000>;
> -                       socionext,synquacer-pre-its = <0x1000000 0x400000>;
> -                       msi-controller;
> -                       #msi-cells = <1>;
> -               };
> -       };
> -
> -       main_gpio_intr: interrupt-controller@a00000 {
> -               compatible = "ti,sci-intr";
> -               reg = <0x00 0x00a00000 0x00 0x800>;
> -               ti,intr-trigger-type = <1>;
> -               interrupt-controller;
> -               interrupt-parent = <&gic500>;
> -               #interrupt-cells = <1>;
> -               ti,sci = <&dmsc>;
> -               ti,sci-dev-id = <131>;
> -               ti,interrupt-ranges = <8 392 56>;
> -       };
> -
> -       main_navss: bus@30000000 {
> -               compatible = "simple-bus";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
> -               ti,sci-dev-id = <199>;
> -               dma-coherent;
> -               dma-ranges;
> -
> -               main_navss_intr: interrupt-controller@310e0000 {
> -                       compatible = "ti,sci-intr";
> -                       reg = <0x00 0x310e0000 0x00 0x4000>;
> -                       ti,intr-trigger-type = <4>;
> -                       interrupt-controller;
> -                       interrupt-parent = <&gic500>;
> -                       #interrupt-cells = <1>;
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <213>;
> -                       ti,interrupt-ranges = <0 64 64>,
> -                                             <64 448 64>,
> -                                             <128 672 64>;
> -               };
> -
> -               main_udmass_inta: msi-controller@33d00000 {
> -                       compatible = "ti,sci-inta";
> -                       reg = <0x00 0x33d00000 0x00 0x100000>;
> -                       interrupt-controller;
> -                       #interrupt-cells = <0>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       msi-controller;
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <209>;
> -                       ti,interrupt-ranges = <0 0 256>;
> -               };
> -
> -               secure_proxy_main: mailbox@32c00000 {
> -                       compatible = "ti,am654-secure-proxy";
> -                       #mbox-cells = <1>;
> -                       reg-names = "target_data", "rt", "scfg";
> -                       reg = <0x00 0x32c00000 0x00 0x100000>,
> -                             <0x00 0x32400000 0x00 0x100000>,
> -                             <0x00 0x32800000 0x00 0x100000>;
> -                       interrupt-names = "rx_011";
> -                       interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -               };
> -
> -               hwspinlock: spinlock@30e00000 {
> -                       compatible = "ti,am654-hwspinlock";
> -                       reg = <0x00 0x30e00000 0x00 0x1000>;
> -                       #hwlock-cells = <1>;
> -               };
> -
> -               mailbox0_cluster0: mailbox@31f80000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f80000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster1: mailbox@31f81000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f81000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster2: mailbox@31f82000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f82000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster3: mailbox@31f83000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f83000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster4: mailbox@31f84000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f84000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster5: mailbox@31f85000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f85000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster6: mailbox@31f86000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f86000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster7: mailbox@31f87000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f87000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster8: mailbox@31f88000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f88000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster9: mailbox@31f89000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f89000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster10: mailbox@31f8a000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f8a000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               mailbox0_cluster11: mailbox@31f8b000 {
> -                       compatible = "ti,am654-mailbox";
> -                       reg = <0x00 0x31f8b000 0x00 0x200>;
> -                       #mbox-cells = <1>;
> -                       ti,mbox-num-users = <4>;
> -                       ti,mbox-num-fifos = <16>;
> -                       interrupt-parent = <&main_navss_intr>;
> -                       status = "disabled";
> -               };
> -
> -               main_ringacc: ringacc@3c000000 {
> -                       compatible = "ti,am654-navss-ringacc";
> -                       reg = <0x00 0x3c000000 0x00 0x400000>,
> -                             <0x00 0x38000000 0x00 0x400000>,
> -                             <0x00 0x31120000 0x00 0x100>,
> -                             <0x00 0x33000000 0x00 0x40000>,
> -                             <0x00 0x31080000 0x00 0x40000>;
> -                       reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
> -                       ti,num-rings = <1024>;
> -                       ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <211>;
> -                       msi-parent = <&main_udmass_inta>;
> -               };
> -
> -               main_udmap: dma-controller@31150000 {
> -                       compatible = "ti,j721e-navss-main-udmap";
> -                       reg = <0x00 0x31150000 0x00 0x100>,
> -                             <0x00 0x34000000 0x00 0x100000>,
> -                             <0x00 0x35000000 0x00 0x100000>;
> -                       reg-names = "gcfg", "rchanrt", "tchanrt";
> -                       msi-parent = <&main_udmass_inta>;
> -                       #dma-cells = <1>;
> -
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <212>;
> -                       ti,ringacc = <&main_ringacc>;
> -
> -                       ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
> -                                               <0x0f>, /* TX_HCHAN */
> -                                               <0x10>; /* TX_UHCHAN */
> -                       ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
> -                                               <0x0b>, /* RX_HCHAN */
> -                                               <0x0c>; /* RX_UHCHAN */
> -                       ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> -               };
> -
> -               cpts@310d0000 {
> -                       compatible = "ti,j721e-cpts";
> -                       reg = <0x00 0x310d0000 0x00 0x400>;
> -                       reg-names = "cpts";
> -                       clocks = <&k3_clks 201 1>;
> -                       clock-names = "cpts";
> -                       interrupts-extended = <&main_navss_intr 391>;
> -                       interrupt-names = "cpts";
> -                       ti,cpts-periodic-outputs = <6>;
> -                       ti,cpts-ext-ts-inputs = <8>;
> -               };
> -       };
> -
> -       cpsw0: ethernet@c000000 {
> -               compatible = "ti,j7200-cpswxg-nuss";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               reg = <0x00 0xc000000 0x00 0x200000>;
> -               reg-names = "cpsw_nuss";
> -               ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
> -               clocks = <&k3_clks 19 33>;
> -               clock-names = "fck";
> -               power-domains = <&k3_pds 19 TI_SCI_PD_EXCLUSIVE>;
> -
> -               dmas = <&main_udmap 0xca00>,
> -                      <&main_udmap 0xca01>,
> -                      <&main_udmap 0xca02>,
> -                      <&main_udmap 0xca03>,
> -                      <&main_udmap 0xca04>,
> -                      <&main_udmap 0xca05>,
> -                      <&main_udmap 0xca06>,
> -                      <&main_udmap 0xca07>,
> -                      <&main_udmap 0x4a00>;
> -               dma-names = "tx0", "tx1", "tx2", "tx3",
> -                           "tx4", "tx5", "tx6", "tx7",
> -                           "rx";
> -
> -               status = "disabled";
> -
> -               ethernet-ports {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       cpsw0_port1: port@1 {
> -                               reg = <1>;
> -                               ti,mac-only;
> -                               label = "port1";
> -                               status = "disabled";
> -                       };
> -
> -                       cpsw0_port2: port@2 {
> -                               reg = <2>;
> -                               ti,mac-only;
> -                               label = "port2";
> -                               status = "disabled";
> -                       };
> -
> -                       cpsw0_port3: port@3 {
> -                               reg = <3>;
> -                               ti,mac-only;
> -                               label = "port3";
> -                               status = "disabled";
> -                       };
> -
> -                       cpsw0_port4: port@4 {
> -                               reg = <4>;
> -                               ti,mac-only;
> -                               label = "port4";
> -                               status = "disabled";
> -                       };
> -               };
> -
> -               cpsw5g_mdio: mdio@f00 {
> -                       compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> -                       reg = <0x00 0xf00 0x00 0x100>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       clocks = <&k3_clks 19 33>;
> -                       clock-names = "fck";
> -                       bus_freq = <1000000>;
> -                       status = "disabled";
> -               };
> -
> -               cpts@3d000 {
> -                       compatible = "ti,j721e-cpts";
> -                       reg = <0x00 0x3d000 0x00 0x400>;
> -                       clocks = <&k3_clks 19 16>;
> -                       clock-names = "cpts";
> -                       interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "cpts";
> -                       ti,cpts-ext-ts-inputs = <4>;
> -                       ti,cpts-periodic-outputs = <2>;
> -               };
> -       };
> -
> -       /* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
> -       main_timerio_input: pinctrl@104200 {
> -               compatible = "pinctrl-single";
> -               reg = <0x0 0x104200 0x0 0x50>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0x000001ff>;
> -       };
> -
> -       /* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
> -       main_timerio_output: pinctrl@104280 {
> -               compatible = "pinctrl-single";
> -               reg = <0x0 0x104280 0x0 0x20>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0x0000001f>;
> -       };
> -
> -       main_pmx0: pinctrl@11c000 {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x11c000 0x00 0x10c>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       main_pmx1: pinctrl@11c11c {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x11c11c 0x00 0xc>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       main_uart0: serial@2800000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02800000 0x00 0x100>;
> -               interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 146 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart1: serial@2810000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02810000 0x00 0x100>;
> -               interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 278 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart2: serial@2820000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02820000 0x00 0x100>;
> -               interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 279 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart3: serial@2830000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02830000 0x00 0x100>;
> -               interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 280 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart4: serial@2840000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02840000 0x00 0x100>;
> -               interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 281 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart5: serial@2850000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02850000 0x00 0x100>;
> -               interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 282 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart6: serial@2860000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02860000 0x00 0x100>;
> -               interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 283 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart7: serial@2870000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02870000 0x00 0x100>;
> -               interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 284 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart8: serial@2880000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02880000 0x00 0x100>;
> -               interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 285 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_uart9: serial@2890000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x02890000 0x00 0x100>;
> -               interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 286 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       main_i2c0: i2c@2000000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2000000 0x00 0x100>;
> -               interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 187 1>;
> -               power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c1: i2c@2010000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2010000 0x00 0x100>;
> -               interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 188 1>;
> -               power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c2: i2c@2020000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2020000 0x00 0x100>;
> -               interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 189 1>;
> -               power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c3: i2c@2030000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2030000 0x00 0x100>;
> -               interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 190 1>;
> -               power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c4: i2c@2040000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2040000 0x00 0x100>;
> -               interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 191 1>;
> -               power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c5: i2c@2050000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2050000 0x00 0x100>;
> -               interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 192 1>;
> -               power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_i2c6: i2c@2060000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x2060000 0x00 0x100>;
> -               interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 193 1>;
> -               power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       main_sdhci0: mmc@4f80000 {
> -               compatible = "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit";
> -               reg = <0x00 0x04f80000 0x00 0x260>, <0x00 0x4f88000 0x00 0x134>;
> -               interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -               power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
> -               clock-names = "clk_ahb", "clk_xin";
> -               clocks = <&k3_clks 91 0>, <&k3_clks 91 3>;
> -               ti,otap-del-sel-legacy = <0x0>;
> -               ti,otap-del-sel-mmc-hs = <0x0>;
> -               ti,otap-del-sel-ddr52 = <0x6>;
> -               ti,otap-del-sel-hs200 = <0x8>;
> -               ti,otap-del-sel-hs400 = <0x5>;
> -               ti,itap-del-sel-legacy = <0x10>;
> -               ti,itap-del-sel-mmc-hs = <0xa>;
> -               ti,strobe-sel = <0x77>;
> -               ti,clkbuf-sel = <0x7>;
> -               ti,trm-icp = <0x8>;
> -               bus-width = <8>;
> -               mmc-ddr-1_8v;
> -               mmc-hs200-1_8v;
> -               mmc-hs400-1_8v;
> -               dma-coherent;
> -               status = "disabled";
> -       };
> -
> -       main_sdhci1: mmc@4fb0000 {
> -               compatible = "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit";
> -               reg = <0x00 0x04fb0000 0x00 0x260>, <0x00 0x4fb8000 0x00 0x134>;
> -               interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> -               power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
> -               clock-names = "clk_ahb", "clk_xin";
> -               clocks = <&k3_clks 92 1>, <&k3_clks 92 2>;
> -               ti,otap-del-sel-legacy = <0x0>;
> -               ti,otap-del-sel-sd-hs = <0x0>;
> -               ti,otap-del-sel-sdr12 = <0xf>;
> -               ti,otap-del-sel-sdr25 = <0xf>;
> -               ti,otap-del-sel-sdr50 = <0xc>;
> -               ti,otap-del-sel-sdr104 = <0x5>;
> -               ti,otap-del-sel-ddr50 = <0xc>;
> -               ti,itap-del-sel-legacy = <0x0>;
> -               ti,itap-del-sel-sd-hs = <0x0>;
> -               ti,itap-del-sel-sdr12 = <0x0>;
> -               ti,itap-del-sel-sdr25 = <0x0>;
> -               ti,clkbuf-sel = <0x7>;
> -               ti,trm-icp = <0x8>;
> -               dma-coherent;
> -               status = "disabled";
> -       };
> -
> -       serdes_wiz0: wiz@5060000 {
> -               compatible = "ti,j721e-wiz-10g";
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 292 11>, <&k3_clks 292 85>, <&serdes_refclk>;
> -               clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> -               num-lanes = <4>;
> -               #reset-cells = <1>;
> -               ranges = <0x5060000 0x0 0x5060000 0x10000>;
> -
> -               assigned-clocks = <&k3_clks 292 85>;
> -               assigned-clock-parents = <&k3_clks 292 89>;
> -
> -               wiz0_pll0_refclk: pll0-refclk {
> -                       clocks = <&k3_clks 292 85>, <&serdes_refclk>;
> -                       clock-output-names = "wiz0_pll0_refclk";
> -                       #clock-cells = <0>;
> -                       assigned-clocks = <&wiz0_pll0_refclk>;
> -                       assigned-clock-parents = <&k3_clks 292 85>;
> -               };
> -
> -               wiz0_pll1_refclk: pll1-refclk {
> -                       clocks = <&k3_clks 292 85>, <&serdes_refclk>;
> -                       clock-output-names = "wiz0_pll1_refclk";
> -                       #clock-cells = <0>;
> -                       assigned-clocks = <&wiz0_pll1_refclk>;
> -                       assigned-clock-parents = <&k3_clks 292 85>;
> -               };
> -
> -               wiz0_refclk_dig: refclk-dig {
> -                       clocks = <&k3_clks 292 85>, <&serdes_refclk>;
> -                       clock-output-names = "wiz0_refclk_dig";
> -                       #clock-cells = <0>;
> -                       assigned-clocks = <&wiz0_refclk_dig>;
> -                       assigned-clock-parents = <&k3_clks 292 85>;
> -               };
> -
> -               wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
> -                       clocks = <&wiz0_refclk_dig>;
> -                       #clock-cells = <0>;
> -               };
> -
> -               serdes0: serdes@5060000 {
> -                       compatible = "ti,j721e-serdes-10g";
> -                       reg = <0x05060000 0x00010000>;
> -                       reg-names = "torrent_phy";
> -                       resets = <&serdes_wiz0 0>;
> -                       reset-names = "torrent_reset";
> -                       clocks = <&wiz0_pll0_refclk>;
> -                       clock-names = "refclk";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -               };
> -       };
> -
> -       pcie1_rc: pcie@2910000 {
> -               compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
> -               reg = <0x00 0x02910000 0x00 0x1000>,
> -                     <0x00 0x02917000 0x00 0x400>,
> -                     <0x00 0x0d800000 0x00 0x00800000>,
> -                     <0x00 0x18000000 0x00 0x00001000>;
> -               reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> -               interrupt-names = "link_state";
> -               interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> -               device_type = "pci";
> -               ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
> -               max-link-speed = <3>;
> -               num-lanes = <4>;
> -               power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 240 6>;
> -               clock-names = "fck";
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -               bus-range = <0x0 0xff>;
> -               cdns,no-bar-match-nbits = <64>;
> -               vendor-id = <0x104c>;
> -               device-id = <0xb00f>;
> -               msi-map = <0x0 &gic_its 0x0 0x10000>;
> -               dma-coherent;
> -               ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
> -                        <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
> -               dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> -       };
> -
> -       pcie1_ep: pcie-ep@2910000 {
> -               compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
> -               reg = <0x00 0x02910000 0x00 0x1000>,
> -                     <0x00 0x02917000 0x00 0x400>,
> -                     <0x00 0x0d800000 0x00 0x00800000>,
> -                     <0x00 0x18000000 0x00 0x08000000>;
> -               reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> -               interrupt-names = "link_state";
> -               interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> -               ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
> -               max-link-speed = <3>;
> -               num-lanes = <4>;
> -               power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 240 6>;
> -               clock-names = "fck";
> -               max-functions = /bits/ 8 <6>;
> -               max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
> -               dma-coherent;
> -       };
> -
> -       usbss0: cdns-usb@4104000 {
> -               compatible = "ti,j721e-usb";
> -               reg = <0x00 0x4104000 0x00 0x100>;
> -               dma-coherent;
> -               power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 288 12>, <&k3_clks 288 3>;
> -               clock-names = "ref", "lpm";
> -               assigned-clocks = <&k3_clks 288 12>;    /* USB2_REFCLK */
> -               assigned-clock-parents = <&k3_clks 288 13>; /* HFOSC0 */
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               usb0: usb@6000000 {
> -                       compatible = "cdns,usb3";
> -                       reg = <0x00 0x6000000 0x00 0x10000>,
> -                             <0x00 0x6010000 0x00 0x10000>,
> -                             <0x00 0x6020000 0x00 0x10000>;
> -                       reg-names = "otg", "xhci", "dev";
> -                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  /* irq.0 */
> -                                    <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
> -                                    <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>; /* otgirq.0 */
> -                       interrupt-names = "host",
> -                                         "peripheral",
> -                                         "otg";
> -                       maximum-speed = "super-speed";
> -                       dr_mode = "otg";
> -                       cdns,phyrst-a-enable;
> -               };
> -       };
> -
> -       main_gpio0: gpio@600000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x00600000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&main_gpio_intr>;
> -               interrupts = <145>, <146>, <147>, <148>,
> -                            <149>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <69>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 105 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       main_gpio2: gpio@610000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x00610000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&main_gpio_intr>;
> -               interrupts = <154>, <155>, <156>, <157>,
> -                            <158>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <69>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 107 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       main_gpio4: gpio@620000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x00620000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&main_gpio_intr>;
> -               interrupts = <163>, <164>, <165>, <166>,
> -                            <167>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <69>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 109 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       main_gpio6: gpio@630000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x00630000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&main_gpio_intr>;
> -               interrupts = <172>, <173>, <174>, <175>,
> -                            <176>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <69>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 111 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       main_spi0: spi@2100000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02100000 0x00 0x400>;
> -               interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 266 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi1: spi@2110000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02110000 0x00 0x400>;
> -               interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 267 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi2: spi@2120000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02120000 0x00 0x400>;
> -               interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 268 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi3: spi@2130000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02130000 0x00 0x400>;
> -               interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 269 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi4: spi@2140000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02140000 0x00 0x400>;
> -               interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 270 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi5: spi@2150000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02150000 0x00 0x400>;
> -               interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 271 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi6: spi@2160000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02160000 0x00 0x400>;
> -               interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 272 1>;
> -               status = "disabled";
> -       };
> -
> -       main_spi7: spi@2170000 {
> -               compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> -               reg = <0x00 0x02170000 0x00 0x400>;
> -               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 273 1>;
> -               status = "disabled";
> -       };
> -
> -       watchdog0: watchdog@2200000 {
> -               compatible = "ti,j7-rti-wdt";
> -               reg = <0x0 0x2200000 0x0 0x100>;
> -               clocks = <&k3_clks 252 1>;
> -               power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
> -               assigned-clocks = <&k3_clks 252 1>;
> -               assigned-clock-parents = <&k3_clks 252 5>;
> -       };
> -
> -       watchdog1: watchdog@2210000 {
> -               compatible = "ti,j7-rti-wdt";
> -               reg = <0x0 0x2210000 0x0 0x100>;
> -               clocks = <&k3_clks 253 1>;
> -               power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
> -               assigned-clocks = <&k3_clks 253 1>;
> -               assigned-clock-parents = <&k3_clks 253 5>;
> -       };
> -
> -       main_timer0: timer@2400000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2400000 0x00 0x400>;
> -               interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 49 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 49 1>;
> -               assigned-clock-parents = <&k3_clks 49 2>;
> -               power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer1: timer@2410000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2410000 0x00 0x400>;
> -               interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 50 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 50 1>, <&k3_clks 313 0>;
> -               assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 313 1>;
> -               power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer2: timer@2420000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2420000 0x00 0x400>;
> -               interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 51 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 51 1>;
> -               assigned-clock-parents = <&k3_clks 51 2>;
> -               power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer3: timer@2430000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2430000 0x00 0x400>;
> -               interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 52 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 52 1>, <&k3_clks 314 0>;
> -               assigned-clock-parents = <&k3_clks 52 2>, <&k3_clks 314 1>;
> -               power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer4: timer@2440000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2440000 0x00 0x400>;
> -               interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 53 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 53 1>;
> -               assigned-clock-parents = <&k3_clks 53 2>;
> -               power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer5: timer@2450000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2450000 0x00 0x400>;
> -               interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 54 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 54 1>, <&k3_clks 315 0>;
> -               assigned-clock-parents = <&k3_clks 54 2>, <&k3_clks 315 1>;
> -               power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer6: timer@2460000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2460000 0x00 0x400>;
> -               interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 55 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 55 1>;
> -               assigned-clock-parents = <&k3_clks 55 2>;
> -               power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer7: timer@2470000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2470000 0x00 0x400>;
> -               interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 57 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 57 1>, <&k3_clks 316 0>;
> -               assigned-clock-parents = <&k3_clks 57 2>, <&k3_clks 316 1>;
> -               power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer8: timer@2480000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2480000 0x00 0x400>;
> -               interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 58 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 58 1>;
> -               assigned-clock-parents = <&k3_clks 58 2>;
> -               power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer9: timer@2490000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2490000 0x00 0x400>;
> -               interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 59 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 59 1>, <&k3_clks 317 0>;
> -               assigned-clock-parents = <&k3_clks 59 2>, <&k3_clks 317 1>;
> -               power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer10: timer@24a0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24a0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 60 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 60 1>;
> -               assigned-clock-parents = <&k3_clks 60 2>;
> -               power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer11: timer@24b0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24b0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 62 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 62 1>, <&k3_clks 318 0>;
> -               assigned-clock-parents = <&k3_clks 62 2>, <&k3_clks 318 1>;
> -               power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer12: timer@24c0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24c0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 63 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 63 1>;
> -               assigned-clock-parents = <&k3_clks 63 2>;
> -               power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer13: timer@24d0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24d0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 64 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 64 1>, <&k3_clks 319 0>;
> -               assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 319 1>;
> -               power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer14: timer@24e0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24e0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 65 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 65 1>;
> -               assigned-clock-parents = <&k3_clks 65 2>;
> -               power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer15: timer@24f0000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x24f0000 0x00 0x400>;
> -               interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 66 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 66 1>, <&k3_clks 320 0>;
> -               assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 320 1>;
> -               power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer16: timer@2500000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2500000 0x00 0x400>;
> -               interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 67 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 67 1>;
> -               assigned-clock-parents = <&k3_clks 67 2>;
> -               power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer17: timer@2510000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2510000 0x00 0x400>;
> -               interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 68 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 68 1>, <&k3_clks 321 0>;
> -               assigned-clock-parents = <&k3_clks 68 2>, <&k3_clks 321 1>;
> -               power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer18: timer@2520000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2520000 0x00 0x400>;
> -               interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 69 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 69 1>;
> -               assigned-clock-parents = <&k3_clks 69 2>;
> -               power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_timer19: timer@2530000 {
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x2530000 0x00 0x400>;
> -               interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 70 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 70 1>, <&k3_clks 322 0>;
> -               assigned-clock-parents = <&k3_clks 70 2>, <&k3_clks 322 1>;
> -               power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       main_r5fss0: r5fss@5c00000 {
> -               compatible = "ti,j7200-r5fss";
> -               ti,cluster-mode = <1>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
> -                        <0x5d00000 0x00 0x5d00000 0x20000>;
> -               power-domains = <&k3_pds 243 TI_SCI_PD_EXCLUSIVE>;
> -
> -               main_r5fss0_core0: r5f@5c00000 {
> -                       compatible = "ti,j7200-r5f";
> -                       reg = <0x5c00000 0x00010000>,
> -                             <0x5c10000 0x00010000>;
> -                       reg-names = "atcm", "btcm";
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <245>;
> -                       ti,sci-proc-ids = <0x06 0xff>;
> -                       resets = <&k3_reset 245 1>;
> -                       firmware-name = "j7200-main-r5f0_0-fw";
> -                       ti,atcm-enable = <1>;
> -                       ti,btcm-enable = <1>;
> -                       ti,loczrama = <1>;
> -               };
> -
> -               main_r5fss0_core1: r5f@5d00000 {
> -                       compatible = "ti,j7200-r5f";
> -                       reg = <0x5d00000 0x00008000>,
> -                             <0x5d10000 0x00008000>;
> -                       reg-names = "atcm", "btcm";
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <246>;
> -                       ti,sci-proc-ids = <0x07 0xff>;
> -                       resets = <&k3_reset 246 1>;
> -                       firmware-name = "j7200-main-r5f0_1-fw";
> -                       ti,atcm-enable = <1>;
> -                       ti,btcm-enable = <1>;
> -                       ti,loczrama = <1>;
> -               };
> -       };
> -
> -       main_esm: esm@700000 {
> -               compatible = "ti,j721e-esm";
> -               reg = <0x0 0x700000 0x0 0x1000>;
> -               ti,esm-pins = <656>, <657>;
> -       };
> -};
> diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
> deleted file mode 100644
> index 3fc588b848c..00000000000
> --- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
> +++ /dev/null
> @@ -1,647 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for J7200 SoC Family MCU/WAKEUP Domain peripherals
> - *
> - * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -&cbass_mcu_wakeup {
> -       dmsc: system-controller@44083000 {
> -               compatible = "ti,k2g-sci";
> -               ti,host-id = <12>;
> -
> -               mbox-names = "rx", "tx";
> -
> -               mboxes = <&secure_proxy_main 11>,
> -                        <&secure_proxy_main 13>;
> -
> -               reg-names = "debug_messages";
> -               reg = <0x00 0x44083000 0x00 0x1000>;
> -
> -               k3_pds: power-controller {
> -                       compatible = "ti,sci-pm-domain";
> -                       #power-domain-cells = <2>;
> -               };
> -
> -               k3_clks: clock-controller {
> -                       compatible = "ti,k2g-sci-clk";
> -                       #clock-cells = <2>;
> -               };
> -
> -               k3_reset: reset-controller {
> -                       compatible = "ti,sci-reset";
> -                       #reset-cells = <2>;
> -               };
> -       };
> -
> -       mcu_timer0: timer@40400000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40400000 0x00 0x400>;
> -               interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 35 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 35 1>;
> -               assigned-clock-parents = <&k3_clks 35 2>;
> -               power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer1: timer@40410000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40410000 0x00 0x400>;
> -               interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 71 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 71 1>, <&k3_clks 308 0>;
> -               assigned-clock-parents = <&k3_clks 71 2>, <&k3_clks 308 1>;
> -               power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer2: timer@40420000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40420000 0x00 0x400>;
> -               interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 72 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 72 1>;
> -               assigned-clock-parents = <&k3_clks 72 2>;
> -               power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer3: timer@40430000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40430000 0x00 0x400>;
> -               interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 73 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 73 1>, <&k3_clks 309 0>;
> -               assigned-clock-parents = <&k3_clks 73 2>, <&k3_clks 309 1>;
> -               power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer4: timer@40440000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40440000 0x00 0x400>;
> -               interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 74 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 74 1>;
> -               assigned-clock-parents = <&k3_clks 74 2>;
> -               power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer5: timer@40450000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40450000 0x00 0x400>;
> -               interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 75 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 75 1>, <&k3_clks 310 0>;
> -               assigned-clock-parents = <&k3_clks 75 2>, <&k3_clks 310 1>;
> -               power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer6: timer@40460000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40460000 0x00 0x400>;
> -               interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 76 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 76 1>;
> -               assigned-clock-parents = <&k3_clks 76 2>;
> -               power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer7: timer@40470000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40470000 0x00 0x400>;
> -               interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 77 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 77 1>, <&k3_clks 311 0>;
> -               assigned-clock-parents = <&k3_clks 77 2>, <&k3_clks 311 1>;
> -               power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer8: timer@40480000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40480000 0x00 0x400>;
> -               interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 78 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 78 1>;
> -               assigned-clock-parents = <&k3_clks 78 2>;
> -               power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_timer9: timer@40490000 {
> -               status = "reserved";
> -               compatible = "ti,am654-timer";
> -               reg = <0x00 0x40490000 0x00 0x400>;
> -               interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&k3_clks 79 1>;
> -               clock-names = "fck";
> -               assigned-clocks = <&k3_clks 79 1>, <&k3_clks 312 0>;
> -               assigned-clock-parents = <&k3_clks 79 2>, <&k3_clks 312 1>;
> -               power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
> -               ti,timer-pwm;
> -       };
> -
> -       mcu_conf: syscon@40f00000 {
> -               compatible = "syscon", "simple-mfd";
> -               reg = <0x00 0x40f00000 0x00 0x20000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0x00 0x00 0x40f00000 0x20000>;
> -
> -               phy_gmii_sel: phy@4040 {
> -                       compatible = "ti,am654-phy-gmii-sel";
> -                       reg = <0x4040 0x4>;
> -                       #phy-cells = <1>;
> -               };
> -       };
> -
> -       chipid@43000014 {
> -               compatible = "ti,am654-chipid";
> -               reg = <0x00 0x43000014 0x00 0x4>;
> -       };
> -
> -       /* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
> -       mcu_timerio_input: pinctrl@40f04200 {
> -               compatible = "pinctrl-single";
> -               reg = <0x0 0x40f04200 0x0 0x28>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0x0000000F>;
> -               status = "reserved";
> -       };
> -
> -       /* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
> -       mcu_timerio_output: pinctrl@40f04280 {
> -               compatible = "pinctrl-single";
> -               reg = <0x0 0x40f04280 0x0 0x28>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0x0000000F>;
> -               status = "reserved";
> -       };
> -
> -       wkup_pmx0: pinctrl@4301c000 {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x4301c000 0x00 0x34>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       wkup_pmx1: pinctrl@4301c038 {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x4301c038 0x00 0x8>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       wkup_pmx2: pinctrl@4301c068 {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x4301c068 0x00 0xec>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       wkup_pmx3: pinctrl@4301c174 {
> -               compatible = "pinctrl-single";
> -               /* Proxy 0 addressing */
> -               reg = <0x00 0x4301c174 0x00 0x20>;
> -               #pinctrl-cells = <1>;
> -               pinctrl-single,register-width = <32>;
> -               pinctrl-single,function-mask = <0xffffffff>;
> -       };
> -
> -       mcu_ram: sram@41c00000 {
> -               compatible = "mmio-sram";
> -               reg = <0x00 0x41c00000 0x00 0x100000>;
> -               ranges = <0x00 0x00 0x41c00000 0x100000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -       };
> -
> -       wkup_uart0: serial@42300000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x42300000 0x00 0x100>;
> -               interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <48000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 287 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       mcu_uart0: serial@40a00000 {
> -               compatible = "ti,j721e-uart", "ti,am654-uart";
> -               reg = <0x00 0x40a00000 0x00 0x100>;
> -               interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <96000000>;
> -               current-speed = <115200>;
> -               power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 149 2>;
> -               clock-names = "fclk";
> -               status = "disabled";
> -       };
> -
> -       wkup_gpio_intr: interrupt-controller@42200000 {
> -               compatible = "ti,sci-intr";
> -               reg = <0x00 0x42200000 0x00 0x400>;
> -               ti,intr-trigger-type = <1>;
> -               interrupt-controller;
> -               interrupt-parent = <&gic500>;
> -               #interrupt-cells = <1>;
> -               ti,sci = <&dmsc>;
> -               ti,sci-dev-id = <137>;
> -               ti,interrupt-ranges = <16 960 16>;
> -       };
> -
> -       wkup_gpio0: gpio@42110000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x42110000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&wkup_gpio_intr>;
> -               interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <85>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 113 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       wkup_gpio1: gpio@42100000 {
> -               compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> -               reg = <0x00 0x42100000 0x00 0x100>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               interrupt-parent = <&wkup_gpio_intr>;
> -               interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               ti,ngpio = <85>;
> -               ti,davinci-gpio-unbanked = <0>;
> -               power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 114 0>;
> -               clock-names = "gpio";
> -               status = "disabled";
> -       };
> -
> -       mcu_navss: bus@28380000 {
> -               compatible = "simple-bus";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
> -               dma-coherent;
> -               dma-ranges;
> -               ti,sci-dev-id = <232>;
> -
> -               mcu_ringacc: ringacc@2b800000 {
> -                       compatible = "ti,am654-navss-ringacc";
> -                       reg = <0x00 0x2b800000 0x00 0x400000>,
> -                             <0x00 0x2b000000 0x00 0x400000>,
> -                             <0x00 0x28590000 0x00 0x100>,
> -                             <0x00 0x2a500000 0x00 0x40000>,
> -                             <0x00 0x28440000 0x00 0x40000>;
> -                       reg-names = "rt", "fifos", "proxy_gcfg",
> -                                   "proxy_target", "cfg";
> -                       ti,num-rings = <286>;
> -                       ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <235>;
> -                       msi-parent = <&main_udmass_inta>;
> -               };
> -
> -               mcu_udmap: dma-controller@285c0000 {
> -                       compatible = "ti,j721e-navss-mcu-udmap";
> -                       reg = <0x00 0x285c0000 0x00 0x100>,
> -                             <0x00 0x2a800000 0x00 0x40000>,
> -                             <0x00 0x2aa00000 0x00 0x40000>;
> -                       reg-names = "gcfg", "rchanrt", "tchanrt";
> -                       msi-parent = <&main_udmass_inta>;
> -                       #dma-cells = <1>;
> -
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <236>;
> -                       ti,ringacc = <&mcu_ringacc>;
> -
> -                       ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
> -                                               <0x0f>; /* TX_HCHAN */
> -                       ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
> -                                               <0x0b>; /* RX_HCHAN */
> -                       ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> -               };
> -       };
> -
> -       secure_proxy_mcu: mailbox@2a480000 {
> -               compatible = "ti,am654-secure-proxy";
> -               #mbox-cells = <1>;
> -               reg-names = "target_data", "rt", "scfg";
> -               reg = <0x0 0x2a480000 0x0 0x80000>,
> -                     <0x0 0x2a380000 0x0 0x80000>,
> -                     <0x0 0x2a400000 0x0 0x80000>;
> -               /*
> -                * Marked Disabled:
> -                * Node is incomplete as it is meant for bootloaders and
> -                * firmware on non-MPU processors
> -                */
> -               status = "disabled";
> -       };
> -
> -       mcu_cpsw: ethernet@46000000 {
> -               compatible = "ti,j721e-cpsw-nuss";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               reg = <0x00 0x46000000 0x00 0x200000>;
> -               reg-names = "cpsw_nuss";
> -               ranges = <0x00 0x00 0x00 0x46000000 0x00 0x200000>;
> -               dma-coherent;
> -               clocks = <&k3_clks 18 21>;
> -               clock-names = "fck";
> -               power-domains = <&k3_pds 18 TI_SCI_PD_EXCLUSIVE>;
> -
> -               dmas = <&mcu_udmap 0xf000>,
> -                      <&mcu_udmap 0xf001>,
> -                      <&mcu_udmap 0xf002>,
> -                      <&mcu_udmap 0xf003>,
> -                      <&mcu_udmap 0xf004>,
> -                      <&mcu_udmap 0xf005>,
> -                      <&mcu_udmap 0xf006>,
> -                      <&mcu_udmap 0xf007>,
> -                      <&mcu_udmap 0x7000>;
> -               dma-names = "tx0", "tx1", "tx2", "tx3",
> -                           "tx4", "tx5", "tx6", "tx7",
> -                           "rx";
> -
> -               ethernet-ports {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -
> -                       cpsw_port1: port@1 {
> -                               reg = <1>;
> -                               ti,mac-only;
> -                               label = "port1";
> -                               ti,syscon-efuse = <&mcu_conf 0x200>;
> -                               phys = <&phy_gmii_sel 1>;
> -                       };
> -               };
> -
> -               davinci_mdio: mdio@f00 {
> -                       compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> -                       reg = <0x00 0xf00 0x00 0x100>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       clocks = <&k3_clks 18 21>;
> -                       clock-names = "fck";
> -                       bus_freq = <1000000>;
> -               };
> -
> -               cpts@3d000 {
> -                       compatible = "ti,am65-cpts";
> -                       reg = <0x00 0x3d000 0x00 0x400>;
> -                       clocks = <&k3_clks 18 2>;
> -                       clock-names = "cpts";
> -                       interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "cpts";
> -                       ti,cpts-ext-ts-inputs = <4>;
> -                       ti,cpts-periodic-outputs = <2>;
> -               };
> -       };
> -
> -       mcu_i2c0: i2c@40b00000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x40b00000 0x00 0x100>;
> -               interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 194 1>;
> -               power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       mcu_i2c1: i2c@40b10000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x40b10000 0x00 0x100>;
> -               interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 195 1>;
> -               power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
> -               status = "disabled";
> -       };
> -
> -       wkup_i2c0: i2c@42120000 {
> -               compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> -               reg = <0x00 0x42120000 0x00 0x100>;
> -               interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               clock-names = "fck";
> -               clocks = <&k3_clks 197 1>;
> -               power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
> -               status = "disabled";
> -       };
> -
> -       mcu_spi0: spi@40300000 {
> -               compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
> -               reg = <0x00 0x040300000 0x00 0x400>;
> -               interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 274 0>;
> -               status = "disabled";
> -       };
> -
> -       mcu_spi1: spi@40310000 {
> -               compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
> -               reg = <0x00 0x040310000 0x00 0x400>;
> -               interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 275 0>;
> -               status = "disabled";
> -       };
> -
> -       mcu_spi2: spi@40320000 {
> -               compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
> -               reg = <0x00 0x040320000 0x00 0x400>;
> -               interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 276 0>;
> -               status = "disabled";
> -       };
> -
> -       fss: syscon@47000000 {
> -               compatible = "syscon", "simple-mfd";
> -               reg = <0x00 0x47000000 0x00 0x100>;
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               hbmc_mux: hbmc-mux {
> -                       compatible = "mmio-mux";
> -                       #mux-control-cells = <1>;
> -                       mux-reg-masks = <0x4 0x2>; /* HBMC select */
> -               };
> -
> -               hbmc: hyperbus@47034000 {
> -                       compatible = "ti,am654-hbmc";
> -                       reg = <0x00 0x47034000 0x00 0x100>,
> -                               <0x05 0x00000000 0x01 0x0000000>;
> -                       power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
> -                       clocks = <&k3_clks 102 0>;
> -                       assigned-clocks = <&k3_clks 102 5>;
> -                       assigned-clock-rates = <333333333>;
> -                       #address-cells = <2>;
> -                       #size-cells = <1>;
> -                       mux-controls = <&hbmc_mux 0>;
> -               };
> -
> -               ospi0: spi@47040000 {
> -                       compatible = "ti,am654-ospi", "cdns,qspi-nor";
> -                       reg = <0x0 0x47040000 0x0 0x100>,
> -                             <0x5 0x00000000 0x1 0x0000000>;
> -                       interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> -                       cdns,fifo-depth = <256>;
> -                       cdns,fifo-width = <4>;
> -                       cdns,trigger-address = <0x0>;
> -                       clocks = <&k3_clks 103 0>;
> -                       assigned-clocks = <&k3_clks 103 0>;
> -                       assigned-clock-parents = <&k3_clks 103 2>;
> -                       assigned-clock-rates = <166666666>;
> -                       power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       status = "disabled";
> -               };
> -       };
> -
> -       tscadc0: tscadc@40200000 {
> -               compatible = "ti,am3359-tscadc";
> -               reg = <0x00 0x40200000 0x00 0x1000>;
> -               interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
> -               power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
> -               clocks = <&k3_clks 0 1>;
> -               assigned-clocks = <&k3_clks 0 3>;
> -               assigned-clock-rates = <60000000>;
> -               clock-names = "fck";
> -               dmas = <&main_udmap 0x7400>,
> -                       <&main_udmap 0x7401>;
> -               dma-names = "fifo0", "fifo1";
> -
> -               adc {
> -                       #io-channel-cells = <1>;
> -                       compatible = "ti,am3359-adc";
> -               };
> -       };
> -
> -       mcu_r5fss0: r5fss@41000000 {
> -               compatible = "ti,j7200-r5fss";
> -               ti,cluster-mode = <1>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0x41000000 0x00 0x41000000 0x20000>,
> -                        <0x41400000 0x00 0x41400000 0x20000>;
> -               power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
> -
> -               mcu_r5fss0_core0: r5f@41000000 {
> -                       compatible = "ti,j7200-r5f";
> -                       reg = <0x41000000 0x00010000>,
> -                             <0x41010000 0x00010000>;
> -                       reg-names = "atcm", "btcm";
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <250>;
> -                       ti,sci-proc-ids = <0x01 0xff>;
> -                       resets = <&k3_reset 250 1>;
> -                       firmware-name = "j7200-mcu-r5f0_0-fw";
> -                       ti,atcm-enable = <1>;
> -                       ti,btcm-enable = <1>;
> -                       ti,loczrama = <1>;
> -               };
> -
> -               mcu_r5fss0_core1: r5f@41400000 {
> -                       compatible = "ti,j7200-r5f";
> -                       reg = <0x41400000 0x00008000>,
> -                             <0x41410000 0x00008000>;
> -                       reg-names = "atcm", "btcm";
> -                       ti,sci = <&dmsc>;
> -                       ti,sci-dev-id = <251>;
> -                       ti,sci-proc-ids = <0x02 0xff>;
> -                       resets = <&k3_reset 251 1>;
> -                       firmware-name = "j7200-mcu-r5f0_1-fw";
> -                       ti,atcm-enable = <1>;
> -                       ti,btcm-enable = <1>;
> -                       ti,loczrama = <1>;
> -               };
> -       };
> -
> -       mcu_crypto: crypto@40900000 {
> -               compatible = "ti,j721e-sa2ul";
> -               reg = <0x00 0x40900000 0x00 0x1200>;
> -               power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> -               dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
> -                      <&mcu_udmap 0x7503>;
> -               dma-names = "tx", "rx1", "rx2";
> -
> -               rng: rng@40910000 {
> -                       compatible = "inside-secure,safexcel-eip76";
> -                       reg = <0x00 0x40910000 0x00 0x7d>;
> -                       interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
> -                       status = "disabled"; /* Used by OP-TEE */
> -               };
> -       };
> -
> -       wkup_vtm0: temperature-sensor@42040000 {
> -               compatible = "ti,j7200-vtm";
> -               reg = <0x00 0x42040000 0x00 0x350>,
> -                     <0x00 0x42050000 0x00 0x350>;
> -               power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> -               #thermal-sensor-cells = <1>;
> -       };
> -
> -       mcu_esm: esm@40800000 {
> -               compatible = "ti,j721e-esm";
> -               reg = <0x00 0x40800000 0x00 0x1000>;
> -               ti,esm-pins = <95>;
> -               bootph-pre-ram;
> -       };
> -};
> diff --git a/arch/arm/dts/k3-j7200-som-p0.dtsi b/arch/arm/dts/k3-j7200-som-p0.dtsi
> deleted file mode 100644
> index 5a300d4c8ba..00000000000
> --- a/arch/arm/dts/k3-j7200-som-p0.dtsi
> +++ /dev/null
> @@ -1,327 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -/dts-v1/;
> -
> -#include "k3-j7200.dtsi"
> -
> -/ {
> -       memory@80000000 {
> -               device_type = "memory";
> -               /* 4G RAM */
> -               reg = <0x00 0x80000000 0x00 0x80000000>,
> -                     <0x08 0x80000000 0x00 0x80000000>;
> -       };
> -
> -       reserved_memory: reserved-memory {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               secure_ddr: optee@9e800000 {
> -                       reg = <0x00 0x9e800000 0x00 0x01800000>;
> -                       alignment = <0x1000>;
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
> -               rtos_ipc_memory_region: ipc-memories@a4000000 {
> -                       reg = <0x00 0xa4000000 0x00 0x00800000>;
> -                       alignment = <0x1000>;
> -                       no-map;
> -               };
> -       };
> -};
> -
> -&wkup_pmx0 {
> -       mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (B6) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
> -                       J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C8) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
> -                       J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (D6) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
> -                       J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (D7) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
> -                       J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (B7) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
> -                       J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D8) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
> -                       J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (C7) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
> -                       J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (C5) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
> -                       J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (A5) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
> -                       J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (A6) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
> -                       J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
> -                       J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
> -                       J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
> -               >;
> -       };
> -
> -       mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
> -                       J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
> -                       J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
> -                       J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
> -                       J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
> -                       J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
> -                       J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
> -                       J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
> -                       J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
> -                       J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
> -                       J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
> -               >;
> -       };
> -};
> -
> -&wkup_pmx2 {
> -       wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> -                       pinctrl-single,pins = <
> -                       J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
> -                       J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
> -               >;
> -       };
> -};
> -
> -&main_pmx0 {
> -       main_i2c0_pins_default: main-i2c0-default-pins {
> -               pinctrl-single,pins = <
> -                       J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
> -                       J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> -               >;
> -       };
> -};
> -
> -&hbmc {
> -       /* OSPI and HBMC are muxed inside FSS, Bootloader will enable
> -        * appropriate node based on board detection
> -        */
> -       status = "disabled";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
> -       ranges = <0x00 0x00 0x05 0x00000000 0x4000000>, /* 64MB Flash on CS0 */
> -                <0x01 0x00 0x05 0x04000000 0x800000>; /* 8MB RAM on CS1 */
> -
> -       flash@0,0 {
> -               compatible = "cypress,hyperflash", "cfi-flash";
> -               reg = <0x00 0x00 0x4000000>;
> -
> -               partitions {
> -                       compatible = "fixed-partitions";
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -
> -                       partition@0 {
> -                               label = "hbmc.tiboot3";
> -                               reg = <0x0 0x100000>;
> -                       };
> -
> -                       partition@100000 {
> -                               label = "hbmc.tispl";
> -                               reg = <0x100000 0x200000>;
> -                       };
> -
> -                       partition@300000 {
> -                               label = "hbmc.u-boot";
> -                               reg = <0x300000 0x400000>;
> -                       };
> -
> -                       partition@700000 {
> -                               label = "hbmc.env";
> -                               reg = <0x700000 0x40000>;
> -                       };
> -
> -                       partition@800000 {
> -                               label = "hbmc.rootfs";
> -                               reg = <0x800000 0x3800000>;
> -                       };
> -               };
> -       };
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
> -&main_i2c0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&main_i2c0_pins_default>;
> -       clock-frequency = <400000>;
> -
> -       exp_som: gpio@21 {
> -               compatible = "ti,tca6408";
> -               reg = <0x21>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               gpio-line-names = "USB2.0_MUX_SEL", "CANUART_MUX1_SEL0",
> -                                 "CANUART_MUX2_SEL0", "CANUART_MUX_SEL1",
> -                                 "UART/LIN_MUX_SEL", "TRC_D17/AUDIO_REFCLK_SEL",
> -                                 "GPIO_LIN_EN", "CAN_STB";
> -       };
> -};
> -
> -&wkup_i2c0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&wkup_i2c0_pins_default>;
> -       clock-frequency = <400000>;
> -
> -       eeprom@50 {
> -               compatible = "atmel,24c256";
> -               reg = <0x50>;
> -       };
> -};
> -
> -&ospi0 {
> -       status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> -
> -       flash@0 {
> -               compatible = "jedec,spi-nor";
> -               reg = <0x0>;
> -               spi-tx-bus-width = <8>;
> -               spi-rx-bus-width = <8>;
> -               spi-max-frequency = <25000000>;
> -               cdns,tshsl-ns = <60>;
> -               cdns,tsd2d-ns = <60>;
> -               cdns,tchsh-ns = <60>;
> -               cdns,tslch-ns = <60>;
> -               cdns,read-delay = <4>;
> -
> -               partitions {
> -                       compatible = "fixed-partitions";
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -
> -                       partition@0 {
> -                               label = "ospi.tiboot3";
> -                               reg = <0x0 0x100000>;
> -                       };
> -
> -                       partition@100000 {
> -                               label = "ospi.tispl";
> -                               reg = <0x100000 0x200000>;
> -                       };
> -
> -                       partition@300000 {
> -                               label = "ospi.u-boot";
> -                               reg = <0x300000 0x400000>;
> -                       };
> -
> -                       partition@700000 {
> -                               label = "ospi.env";
> -                               reg = <0x700000 0x40000>;
> -                       };
> -
> -                       partition@740000 {
> -                               label = "ospi.env.backup";
> -                               reg = <0x740000 0x40000>;
> -                       };
> -
> -                       partition@800000 {
> -                               label = "ospi.rootfs";
> -                               reg = <0x800000 0x37c0000>;
> -                       };
> -
> -                       partition@3fc0000 {
> -                               label = "ospi.phypattern";
> -                               reg = <0x3fc0000 0x40000>;
> -                       };
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/k3-j7200-thermal.dtsi b/arch/arm/dts/k3-j7200-thermal.dtsi
> deleted file mode 100644
> index e7e3a643a6f..00000000000
> --- a/arch/arm/dts/k3-j7200-thermal.dtsi
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include <dt-bindings/thermal/thermal.h>
> -
> -thermal_zones: thermal-zones {
> -       mcu_thermal: mcu-thermal {
> -               polling-delay-passive = <250>; /* milliseconds */
> -               polling-delay = <500>; /* milliseconds */
> -               thermal-sensors = <&wkup_vtm0 0>;
> -
> -               trips {
> -                       wkup_crit: wkup-crit {
> -                               temperature = <125000>; /* milliCelsius */
> -                               hysteresis = <2000>; /* milliCelsius */
> -                               type = "critical";
> -                       };
> -               };
> -       };
> -
> -       mpu_thermal: mpu-thermal {
> -               polling-delay-passive = <250>; /* milliseconds */
> -               polling-delay = <500>; /* milliseconds */
> -               thermal-sensors = <&wkup_vtm0 1>;
> -
> -               trips {
> -                       mpu_crit: mpu-crit {
> -                               temperature = <125000>; /* milliCelsius */
> -                               hysteresis = <2000>; /* milliCelsius */
> -                               type = "critical";
> -                       };
> -               };
> -       };
> -
> -       main_thermal: main-thermal {
> -               polling-delay-passive = <250>; /* milliseconds */
> -               polling-delay = <500>; /* milliseconds */
> -               thermal-sensors = <&wkup_vtm0 2>;
> -
> -               trips {
> -                       c7x_crit: c7x-crit {
> -                               temperature = <125000>; /* milliCelsius */
> -                               hysteresis = <2000>; /* milliCelsius */
> -                               type = "critical";
> -                       };
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/k3-j7200.dtsi b/arch/arm/dts/k3-j7200.dtsi
> deleted file mode 100644
> index ef73e6d7e85..00000000000
> --- a/arch/arm/dts/k3-j7200.dtsi
> +++ /dev/null
> @@ -1,164 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree Source for J7200 SoC Family
> - *
> - * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/soc/ti,sci_pm_domain.h>
> -
> -#include "k3-pinctrl.h"
> -
> -/ {
> -       model = "Texas Instruments K3 J7200 SoC";
> -       compatible = "ti,j7200";
> -       interrupt-parent = <&gic500>;
> -       #address-cells = <2>;
> -       #size-cells = <2>;
> -
> -       chosen { };
> -
> -       cpus {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               cpu-map {
> -                       cluster0: cluster0 {
> -                               core0 {
> -                                       cpu = <&cpu0>;
> -                               };
> -
> -                               core1 {
> -                                       cpu = <&cpu1>;
> -                               };
> -                       };
> -
> -               };
> -
> -               cpu0: cpu@0 {
> -                       compatible = "arm,cortex-a72";
> -                       reg = <0x000>;
> -                       device_type = "cpu";
> -                       enable-method = "psci";
> -                       i-cache-size = <0xc000>;
> -                       i-cache-line-size = <64>;
> -                       i-cache-sets = <256>;
> -                       d-cache-size = <0x8000>;
> -                       d-cache-line-size = <64>;
> -                       d-cache-sets = <256>;
> -                       next-level-cache = <&L2_0>;
> -               };
> -
> -               cpu1: cpu@1 {
> -                       compatible = "arm,cortex-a72";
> -                       reg = <0x001>;
> -                       device_type = "cpu";
> -                       enable-method = "psci";
> -                       i-cache-size = <0xc000>;
> -                       i-cache-line-size = <64>;
> -                       i-cache-sets = <256>;
> -                       d-cache-size = <0x8000>;
> -                       d-cache-line-size = <64>;
> -                       d-cache-sets = <256>;
> -                       next-level-cache = <&L2_0>;
> -               };
> -       };
> -
> -       L2_0: l2-cache0 {
> -               compatible = "cache";
> -               cache-level = <2>;
> -               cache-unified;
> -               cache-size = <0x100000>;
> -               cache-line-size = <64>;
> -               cache-sets = <1024>;
> -               next-level-cache = <&msmc_l3>;
> -       };
> -
> -       msmc_l3: l3-cache0 {
> -               compatible = "cache";
> -               cache-level = <3>;
> -               cache-unified;
> -       };
> -
> -       firmware {
> -               optee {
> -                       compatible = "linaro,optee-tz";
> -                       method = "smc";
> -               };
> -
> -               psci: psci {
> -                       compatible = "arm,psci-1.0";
> -                       method = "smc";
> -               };
> -       };
> -
> -       a72_timer0: timer-cl0-cpu0 {
> -               compatible = "arm,armv8-timer";
> -               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> -                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> -                            <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> -                            <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> -       };
> -
> -       pmu: pmu {
> -               compatible = "arm,cortex-a72-pmu";
> -               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -       };
> -
> -       cbass_main: bus@100000 {
> -               compatible = "simple-bus";
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> -                        <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
> -                        <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
> -                        <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
> -                        <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> -                        <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
> -                        <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
> -                        <0x00 0x70000000 0x00 0x70000000 0x00 0x00800000>, /* MSMC RAM */
> -                        <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
> -                        <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
> -
> -                        /* MCUSS_WKUP Range */
> -                        <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
> -                        <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
> -                        <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
> -                        <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
> -                        <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
> -                        <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
> -                        <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
> -                        <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
> -                        <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
> -                        <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
> -                        <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
> -                        <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
> -                        <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
> -
> -               cbass_mcu_wakeup: bus@28380000 {
> -                       compatible = "simple-bus";
> -                       #address-cells = <2>;
> -                       #size-cells = <2>;
> -                       ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
> -                                <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
> -                                <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
> -                                <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
> -                                <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
> -                                <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
> -                                <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
> -                                <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
> -                                <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
> -                                <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
> -                                <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
> -                                <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
> -                                <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
> -               };
> -       };
> -
> -       #include "k3-j7200-thermal.dtsi"
> -};
> -
> -/* Now include the peripherals for each bus segments */
> -#include "k3-j7200-main.dtsi"
> -#include "k3-j7200-mcu-wakeup.dtsi"
> diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
> index fe8e84c9214..4db5654ca1c 100644
> --- a/configs/j7200_evm_a72_defconfig
> +++ b/configs/j7200_evm_a72_defconfig
> @@ -15,7 +15,7 @@ CONFIG_SF_DEFAULT_MODE=0
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_DM_GPIO=y
>  CONFIG_SPL_DM_SPI=y
> -CONFIG_DEFAULT_DEVICE_TREE="k3-j7200-common-proc-board"
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j7200-common-proc-board"
>  CONFIG_SPL_TEXT_BASE=0x80080000
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
> @@ -96,6 +96,7 @@ CONFIG_REGMAP=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_OF_UPSTREAM=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_CCF=y
> --
> 2.34.1
>
