Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9212BCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 04:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA13088216;
	Thu,  4 Apr 2024 06:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eeSp8oIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27DE88216; Thu,  4 Apr 2024 06:07:16 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789E988213
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 06:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-476cec93716so223803137.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712203631; x=1712808431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kTDxITfskRZ/3XRR1fKsJdZMvslUVEzwR9CBoXkERcE=;
 b=eeSp8oIypg1T4enPrzvpDSs89cIv1eaAI7iw0VkMeLkbevd02JT3QTE1piE5Agj0ye
 FygOWoKr8BR03E20QW2f+8VqVKAuz8V+fFqxLNQx15IzNcdnE4R8tGPcIVklsFtMO2S3
 wLuNl//Jy0j9rRCcwHWHRqNq1zMp6KlDEPwTF2dlae+FNWeGSAUr08rUQYQ7yySNUbkp
 xNzkdixWaFJYXQEN1SVrrnsfI/xtw4Sl5d/DoGTBDOAB/6Xk/fYGlEjZCL/dMQx4vVAc
 t4ZKXOu5u6xr+19tnEBx1X41r1FMaWeIJ/AbeY2IveHn7YFM5aTxYCLY0gT0ZxianlZe
 jXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712203631; x=1712808431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTDxITfskRZ/3XRR1fKsJdZMvslUVEzwR9CBoXkERcE=;
 b=QncXGhLOKeIegkxGwgyUo5vV+UovfZQ2v1puRjidB4u19h/b0262ybeuiw6vGf43Gs
 FLx+IzSGUuWZptFf9vL1laREQceFzZGqYzDqRiinCwaR37tWsVcB+x+ov0bLYrq0ir47
 ZFQwIBoVfcHROY7ijtqn7SSYWiAjn/Ve5V8q/Ir+gYYs88QfkrU2QApjZq+v+5jXjdrF
 OZ46tS6zqnsfTogws/AchBMy2B9Qn2BHH1jhgr3THDUxwUcuynoJyN+ilCX+krX3or/P
 2dzrLD2GQaopCBCqtnLHWA1sAuVFLTvxLVVkLXtPC9KNORWLkY7en5rcElCvCICDRGl1
 JeYA==
X-Gm-Message-State: AOJu0YyrSVnek+wKu48uZGvAH32sKXA8r4PnR32sxk/kuaz4hKj9UJaC
 dOScHApQPnyPJu3Jc4cmTPmtWsWf+2dph8bjZwNV8qWHLwXhMZVUB9llEcYbdosgOuSvF6WQ+AN
 NvB4gS9uXdNOiMI7gLXCTrmSz0HzWfZH1Gp6+kw==
X-Google-Smtp-Source: AGHT+IEPBVlRS+Ztp6TXp+yFaYwSH96H5dbGIBSYdVLvaSTfCbqiuVus/tuJbmO/A8q3nHltbQwQhSy+lp1+ZgKWMms=
X-Received: by 2002:a67:fa55:0:b0:478:7465:50da with SMTP id
 j21-20020a67fa55000000b00478746550damr1323346vsq.10.1712203631085; Wed, 03
 Apr 2024 21:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240403071518.400771-1-marcel@ziswiler.com>
In-Reply-To: <20240403071518.400771-1-marcel@ziswiler.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Apr 2024 09:36:59 +0530
Message-ID: <CAFA6WYO2BBV5YQWHXNBqV1n-qH03HYrPa-+x3bHkwsRizTHsVQ@mail.gmail.com>
Subject: Re: [PATCH v1] verdin-am62: move verdin am62 to OF_UPSTREAM
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Wadim Egorov <w.egorov@phytec.de>
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

On Wed, 3 Apr 2024 at 12:45, Marcel Ziswiler <marcel@ziswiler.com> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Move verdin-am62 to OF_UPSTREAM:
> - handle the fact that dtbs now have a 'ti/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>   *-u-boot.dtsi files
> - update MAINTAINERS file
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>  arch/arm/dts/Makefile                         |    1 -
>  arch/arm/dts/k3-am62-verdin-dev.dtsi          |  240 ---
>  arch/arm/dts/k3-am62-verdin-wifi.dtsi         |   45 -
>  arch/arm/dts/k3-am62-verdin.dtsi              | 1443 -----------------
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |    2 +-
>  arch/arm/dts/k3-am625-verdin-wifi-dev.dts     |   22 -
>  arch/arm/mach-k3/am62x/Kconfig                |    1 +
>  board/toradex/verdin-am62/MAINTAINERS         |    4 -
>  configs/verdin-am62_a53_defconfig             |    2 +-
>  9 files changed, 3 insertions(+), 1757 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-am62-verdin-dev.dtsi
>  delete mode 100644 arch/arm/dts/k3-am62-verdin-wifi.dtsi
>  delete mode 100644 arch/arm/dts/k3-am62-verdin.dtsi
>  delete mode 100644 arch/arm/dts/k3-am625-verdin-wifi-dev.dts
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 7b7788f7550..18fedc16740 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1416,7 +1416,6 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>                               k3-am625-r5-sk.dtb \
>                               k3-am625-beagleplay.dtb \
>                               k3-am625-r5-beagleplay.dtb \
> -                             k3-am625-verdin-wifi-dev.dtb \
>                               k3-am625-verdin-r5.dtb \
>                               k3-am625-phyboard-lyra-rdk.dtb \
>                               k3-am625-r5-phycore-som-2gb.dtb
> diff --git a/arch/arm/dts/k3-am62-verdin-dev.dtsi b/arch/arm/dts/k3-am62-verdin-dev.dtsi
> deleted file mode 100644
> index 6701cb8974b..00000000000
> --- a/arch/arm/dts/k3-am62-verdin-dev.dtsi
> +++ /dev/null
> @@ -1,240 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2023 Toradex
> - *
> - * Common dtsi for Verdin AM62 SoM on Development carrier board
> - *
> - * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> - * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
> - */
> -
> -/ {
> -       sound {
> -               compatible = "simple-audio-card";
> -               simple-audio-card,bitclock-master = <&codec_dai>;
> -               simple-audio-card,format = "i2s";
> -               simple-audio-card,frame-master = <&codec_dai>;
> -               simple-audio-card,name = "verdin-nau8822";
> -               simple-audio-card,routing =
> -                       "Headphones", "LHP",
> -                       "Headphones", "RHP",
> -                       "Speaker", "LSPK",
> -                       "Speaker", "RSPK",
> -                       "Line Out", "AUXOUT1",
> -                       "Line Out", "AUXOUT2",
> -                       "LAUX", "Line In",
> -                       "RAUX", "Line In",
> -                       "LMICP", "Mic In",
> -                       "RMICP", "Mic In";
> -               simple-audio-card,widgets =
> -                       "Headphones", "Headphones",
> -                       "Line Out", "Line Out",
> -                       "Speaker", "Speaker",
> -                       "Microphone", "Mic In",
> -                       "Line", "Line In";
> -
> -               codec_dai: simple-audio-card,codec {
> -                       clocks = <&audio_refclk1>;
> -                       sound-dai = <&nau8822_1a>;
> -               };
> -
> -               simple-audio-card,cpu {
> -                       sound-dai = <&mcasp0>;
> -               };
> -       };
> -};
> -
> -/* Verdin ETHs */
> -&cpsw3g {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_rgmii1>, <&pinctrl_rgmii2>;
> -       status = "okay";
> -};
> -
> -/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
> -&cpsw3g_mdio {
> -       status = "okay";
> -
> -       cpsw3g_phy1: ethernet-phy@7 {
> -               compatible = "ethernet-phy-ieee802.3-c22";
> -               reg = <7>;
> -               interrupt-parent = <&main_gpio0>;
> -               interrupts = <38 IRQ_TYPE_EDGE_FALLING>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_eth2_rgmii_int>;
> -               micrel,led-mode = <0>;
> -       };
> -};
> -
> -/* Verdin ETH_1 (On-module PHY) */
> -&cpsw_port1 {
> -       status = "okay";
> -};
> -
> -/* Verdin ETH_2_RGMII */
> -&cpsw_port2 {
> -       phy-handle = <&cpsw3g_phy1>;
> -       phy-mode = "rgmii-rxid";
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_1, PWM_2 */
> -&epwm0 {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&epwm1 {
> -       status = "okay";
> -};
> -
> -&main_gpio0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ctrl_sleep_moci>,
> -                   <&pinctrl_gpio_5>,
> -                   <&pinctrl_gpio_6>,
> -                   <&pinctrl_gpio_7>,
> -                   <&pinctrl_gpio_8>;
> -};
> -
> -/* Verdin I2C_1 */
> -&main_i2c1 {
> -       status = "okay";
> -
> -       /* Audio Codec */
> -       nau8822_1a: audio-codec@1a {
> -               compatible = "nuvoton,nau8822";
> -               reg = <0x1a>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_i2s1_mclk>;
> -               #sound-dai-cells = <0>;
> -       };
> -
> -       /* IO Expander */
> -       gpio_expander_21: gpio@21 {
> -               compatible = "nxp,pcal6416";
> -               reg = <0x21>;
> -               #gpio-cells = <2>;
> -               gpio-controller;
> -       };
> -
> -       /* Current measurement into module VCC */
> -       hwmon@40 {
> -               compatible = "ti,ina219";
> -               reg = <0x40>;
> -               shunt-resistor = <10000>;
> -       };
> -
> -       /* Temperature sensor */
> -       sensor@4f {
> -               compatible = "ti,tmp75c";
> -               reg = <0x4f>;
> -       };
> -
> -       /* EEPROM */
> -       eeprom@57 {
> -               compatible = "st,24c02", "atmel,24c02";
> -               reg = <0x57>;
> -               pagesize = <16>;
> -       };
> -};
> -
> -/* Verdin I2C_2_DSI */
> -&main_i2c2 {
> -       status = "okay";
> -};
> -
> -/* Verdin I2C_4_CSI */
> -&main_i2c3 {
> -       status = "okay";
> -};
> -
> -/* Verdin CAN_1 */
> -&main_mcan0 {
> -       status = "okay";
> -};
> -
> -/* Verdin SPI_1 */
> -&main_spi1 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_3 */
> -&main_uart0 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_1, connector X50 through RS485 transceiver. */
> -&main_uart1 {
> -       linux,rs485-enabled-at-boot-time;
> -       rs485-rx-during-tx;
> -       status = "okay";
> -};
> -
> -/* Verdin I2S_1 */
> -&mcasp0 {
> -       status = "okay";
> -};
> -
> -&mcu_gpio0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_gpio_1>,
> -                   <&pinctrl_gpio_2>,
> -                   <&pinctrl_gpio_3>,
> -                   <&pinctrl_gpio_4>;
> -};
> -
> -/* Verdin I2C_3_HDMI */
> -&mcu_i2c0 {
> -       status = "okay";
> -};
> -
> -/* Verdin CAN_2 */
> -&mcu_mcan0 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_4 */
> -&mcu_uart0 {
> -       status = "okay";
> -};
> -
> -/* Verdin QSPI_1 */
> -&ospi0 {
> -       status = "okay";
> -};
> -
> -/* Verdin SD_1 */
> -&sdhci1 {
> -       ti,driver-strength-ohm = <33>;
> -       status = "okay";
> -};
> -
> -/* Verdin USB_1 */
> -&usbss0 {
> -       status = "okay";
> -};
> -
> -&usb0 {
> -       status = "okay";
> -};
> -
> -/* Verdin USB_2 */
> -&usbss1 {
> -       status = "okay";
> -};
> -
> -&usb1 {
> -       status = "okay";
> -};
> -
> -/* Verdin CTRL_WAKE1_MICO# */
> -&verdin_gpio_keys {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_2 */
> -&wkup_uart0 {
> -       /* FIXME: WKUP UART0 is used by DM firmware */
> -       status = "reserved";
> -};
> diff --git a/arch/arm/dts/k3-am62-verdin-wifi.dtsi b/arch/arm/dts/k3-am62-verdin-wifi.dtsi
> deleted file mode 100644
> index a6808b10c7b..00000000000
> --- a/arch/arm/dts/k3-am62-verdin-wifi.dtsi
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2023 Toradex
> - *
> - * Common dtsi for Verdin AM62 SoM WB variant
> - *
> - * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> - */
> -
> -/ {
> -       wifi_pwrseq: wifi-pwrseq {
> -               compatible = "mmc-pwrseq-simple";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_wifi_en>;
> -               reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
> -       };
> -};
> -
> -/* On-module Wi-Fi */
> -&sdhci2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_sdhci2>;
> -       bus-width = <4>;
> -       cap-power-off-card;
> -       keep-power-in-suspend;
> -       mmc-pwrseq = <&wifi_pwrseq>;
> -       non-removable;
> -       ti,fails-without-test-cd;
> -       ti,driver-strength-ohm = <50>;
> -       vmmc-supply = <&reg_3v3>;
> -       status = "okay";
> -};
> -
> -/* On-module Bluetooth */
> -&main_uart5 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart5>;
> -       uart-has-rtscts;
> -       status = "okay";
> -
> -       bluetooth {
> -               compatible = "nxp,88w8987-bt";
> -               fw-init-baudrate = <3000000>;
> -       };
> -};
> diff --git a/arch/arm/dts/k3-am62-verdin.dtsi b/arch/arm/dts/k3-am62-verdin.dtsi
> deleted file mode 100644
> index 5db52f23725..00000000000
> --- a/arch/arm/dts/k3-am62-verdin.dtsi
> +++ /dev/null
> @@ -1,1443 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2023 Toradex
> - *
> - * Common dtsi for Verdin AM62 SoM
> - *
> - * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/net/ti-dp83867.h>
> -
> -/ {
> -       chosen {
> -               stdout-path = "serial2:115200n8";
> -       };
> -
> -       aliases {
> -               can0 = &main_mcan0;
> -               can1 = &mcu_mcan0;
> -               ethernet0 = &cpsw_port1;
> -               ethernet1 = &cpsw_port2;
> -               i2c0 = &main_i2c0;
> -               i2c1 = &main_i2c1;
> -               i2c2 = &main_i2c2;
> -               i2c3 = &mcu_i2c0;
> -               i2c4 = &main_i2c3;
> -               mmc0 = &sdhci0;
> -               mmc1 = &sdhci1;
> -               mmc2 = &sdhci2;
> -               rtc0 = &rtc_i2c;
> -               rtc1 = &wkup_rtc0;
> -               serial0 = &main_uart1;
> -               serial1 = &wkup_uart0;
> -               serial2 = &main_uart0;
> -               serial3 = &mcu_uart0;
> -               serial4 = &main_uart5;
> -               usb0 = &usb0;
> -               usb1 = &usb1;
> -       };
> -
> -       verdin_gpio_keys: gpio-keys {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
> -               status = "disabled";
> -
> -               verdin_key_wakeup: key-wakeup {
> -                       debounce-interval = <10>;
> -                       /* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
> -                       gpios = <&main_gpio0 32 GPIO_ACTIVE_LOW>;
> -                       label = "Wake-Up";
> -                       linux,code = <KEY_WAKEUP>;
> -                       wakeup-source;
> -               };
> -       };
> -
> -       memory@80000000 {
> -               device_type = "memory";
> -               reg = <0x00000000 0x80000000 0x00000000 0x40000000>; /* 1G RAM */
> -       };
> -
> -       opp-table {
> -               /* Add 1.4GHz OPP. Requires VDD_CORE to be at 0.85V */
> -               opp-1400000000 {
> -                       opp-hz = /bits/ 64 <1400000000>;
> -                       opp-supported-hw = <0x01 0x0004>;
> -                       clock-latency-ns = <6000000>;
> -               };
> -       };
> -
> -       /* Module Power Supply */
> -       reg_vsodimm: regulator-vsodimm {
> -               compatible = "regulator-fixed";
> -               regulator-name = "+V_SODIMM";
> -       };
> -
> -       /* Non PMIC On-module Supplies */
> -       reg_3v3: regulator-3v3 {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "On-module +V3.3";
> -               vin-supply = <&reg_vsodimm>;
> -       };
> -
> -       reg_1v2_dsi: regulator-1v2-dsi {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1200000>;
> -               regulator-min-microvolt = <1200000>;
> -               regulator-name = "On-module +V1.2_DSI";
> -               vin-supply = <&reg_1v8>;
> -       };
> -
> -       /* Enabled by +V1.2_DSI */
> -       reg_1v8_dsi: regulator-1v8-dsi {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1800000>;
> -               regulator-min-microvolt = <1800000>;
> -               regulator-name = "On-module +V1.8_DSI";
> -               vin-supply = <&reg_1v8>;
> -       };
> -
> -       /* Enabled by +V2.5_ETH */
> -       reg_1v0_eth: regulator-1v0-eth {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1000000>;
> -               regulator-min-microvolt = <1000000>;
> -               regulator-name = "On-module +V1.0_ETH";
> -               vin-supply = <&reg_1v8>;
> -       };
> -
> -       /* Enabled by +V2.5_ETH */
> -       reg_1v8_eth: regulator-1v8-eth {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1800000>;
> -               regulator-min-microvolt = <1800000>;
> -               regulator-name = "On-module +V1.8_ETH";
> -               vin-supply = <&reg_1v8>;
> -       };
> -
> -       /* Verdin SD_1 Power Supply */
> -       reg_sdhc1_vmmc: regulator-sdhci1 {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_sd1_pwr_en>;
> -               enable-active-high;
> -               /* Verdin SD_1_PWR_EN (SODIMM 76) */
> -               gpio = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> -               off-on-delay-us = <100000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_SD";
> -               startup-delay-us = <2000>;
> -       };
> -
> -       reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
> -               compatible = "regulator-gpio";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_vsel_sd>;
> -               /* PMIC_VSEL_SD */
> -               gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
> -               regulator-name = "LDO1-VSEL-SD (PMIC)";
> -               regulator-min-microvolt = <1800000>;
> -               regulator-max-microvolt = <3300000>;
> -               states = <1800000 0x0>,
> -                        <3300000 0x1>;
> -               vin-supply = <&reg_sd_3v3_1v8>;
> -       };
> -
> -       reserved-memory {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               secure_tfa_ddr: tfa@9e780000 {
> -                       reg = <0x00 0x9e780000 0x00 0x80000>;
> -                       alignment = <0x1000>;
> -                       no-map;
> -               };
> -
> -               secure_ddr: optee@9e800000 {
> -                       reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> -                       alignment = <0x1000>;
> -                       no-map;
> -               };
> -
> -               wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> -                       compatible = "shared-dma-pool";
> -                       reg = <0x00 0x9db00000 0x00 0xc00000>;
> -                       no-map;
> -               };
> -       };
> -};
> -
> -&main_pmx0 {
> -       /* Verdin PWM_1 */
> -       pinctrl_epwm0_a: main-epwm0a-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01b4, PIN_OUTPUT, 2) /* (A13) SPI0_CS0.EHRPWM0_A */ /* SODIMM 15 */
> -               >;
> -       };
> -
> -       /* Verdin PWM_2 */
> -       pinctrl_epwm0_b: main-epwm0b-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01b8, PIN_OUTPUT, 2) /* (C13) SPI0_CS1.EHRPWM0_B */ /* SODIMM 16 */
> -               >;
> -       };
> -
> -       /* Verdin PWM_3_DSI */
> -       pinctrl_epwm1_a: main-epwm1a-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01bc, PIN_OUTPUT, 2) /* (A14) SPI0_CLK.EHRPWM1_A */ /* SODIMM 19 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_CLK as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_clk_gpio: main-gpio0-0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0000, PIN_INPUT, 7) /* (H24) OSPI0_CLK.GPIO0_0 */ /* SODIMM 52 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_IO0 as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_io0_gpio: main-gpio0-3-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x000c, PIN_INPUT, 7) /* (E25) OSPI0_D0.GPIO0_3 */ /* SODIMM 56 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_IO1 as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_io1_gpio: main-gpio0-4-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0010, PIN_INPUT, 7) /* (G24) OSPI0_D1.GPIO0_4 */ /* SODIMM 58 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_IO2 as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_io2_gpio: main-gpio0-5-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0014, PIN_INPUT, 7) /* (F25) OSPI0_D2.GPIO0_5 */ /* SODIMM 60 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_IO3 as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_io3_gpio: main-gpio0-6-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0018, PIN_INPUT, 7) /* (F24) OSPI0_D3.GPIO0_6 */ /* SODIMM 62 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_CS# as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_cs_gpio: main-gpio0-11-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x002c, PIN_INPUT, 7) /* (F23) OSPI0_CSn0.GPIO0_11 */ /* SODIMM 54 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_CS2# as GPIO (conflict with Verdin QSPI_1 interface) */
> -       pinctrl_qspi1_cs2_gpio: main-gpio0-12-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0030, PIN_INPUT, 7) /* (G21) OSPI0_CSn1.GPIO0_12 */ /* SODIMM 64 */
> -               >;
> -       };
> -
> -       /* WiFi_W_WKUP_HOST# */
> -       pinctrl_wifi_w_wkup_host: main-gpio0-15-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */ /* SODIMM 174 */
> -               >;
> -       };
> -
> -       /* WiFi_BT_WKUP_HOST# */
> -       pinctrl_bt_wkup_host: main-gpio0-16-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */ /* SODIMM 172 */
> -               >;
> -       };
> -
> -       /* PMIC_ETH_RESET# */
> -       pinctrl_eth_reset: main-gpio0-17-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0044, PIN_INPUT, 7) /* (N24) GPMC0_AD2.GPIO0_17 */
> -               >;
> -       };
> -
> -       /* PMIC_BRIDGE_RESET# */
> -       pinctrl_bridge_reset: main-gpio0-20-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0050, PIN_INPUT, 7) /* (P22) GPMC0_AD5.GPIO0_20 */
> -               >;
> -       };
> -
> -       /* PMIC_VSEL_SD */
> -       pinctrl_vsel_sd: main-gpio0-21-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0054, PIN_INPUT, 7) /* (P21) GPMC0_AD6.GPIO0_21 */
> -               >;
> -       };
> -
> -       /* PMIC_EN_WIFI */
> -       pinctrl_wifi_en: main-gpio0-22-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0058, PIN_INPUT, 7) /* (R23) GPMC0_AD7.GPIO0_22 */
> -               >;
> -       };
> -
> -       /* PMIC_ETH_INT# */
> -       pinctrl_eth_int: main-gpio0-25-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0064, PIN_INPUT_PULLUP, 7) /* (T25) GPMC0_AD10.GPIO0_25 */
> -               >;
> -       };
> -
> -       /* WiFi_WKUP_BT# */
> -       pinctrl_wifi_wkup_bt: main-gpio0-26-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0068, PIN_INPUT, 7) /* (R21) GPMC0_AD11.GPIO0_26 */
> -               >;
> -       };
> -
> -       /* WiFi_WKUP_WLAN# */
> -       pinctrl_wifi_wkup_wlan: main-gpio0-27-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x006c, PIN_INPUT, 7) /* (T22) GPMC0_AD12.GPIO0_27 */
> -               >;
> -       };
> -
> -       /* Verdin SD_1_PWR_EN */
> -       pinctrl_sd1_pwr_en: main-gpio0-29-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0074, PIN_INPUT, 7) /* (U25) GPMC0_AD14.GPIO0_29 */ /* SODIMM 76 */
> -               >;
> -       };
> -
> -       /* Verdin DSI_1_BKL_EN */
> -       pinctrl_dsi1_bkl_en: main-gpio0-30-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0078, PIN_INPUT, 7) /* (U24) GPMC0_AD15.GPIO0_30 */ /* SODIMM 21 */
> -               >;
> -       };
> -
> -       /* Verdin CTRL_SLEEP_MOCI# */
> -       pinctrl_ctrl_sleep_moci: main-gpio0-31-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x007c, PIN_INPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */ /* SODIMM 256 */
> -               >;
> -       };
> -
> -       /* Verdin CTRL_WAKE1_MICO# */
> -       pinctrl_ctrl_wake1_mico: main-gpio0-32-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0084, PIN_INPUT_PULLUP, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */ /* SODIMM 252 */
> -               >;
> -       };
> -
> -       /* Verdin I2S_2_D_OUT as GPIO (conflict with Verdin I2S_2 interface) */
> -       pinctrl_i2s_2_d_out_gpio: main-gpio0-34-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x008c, PIN_INPUT, 7) /* (L25) GPMC0_WEn.GPIO0_34 */ /* SODIMM 46 */
> -               >;
> -       };
> -
> -       /* Verdin I2S_2_BCLK as GPIO (conflict with Verdin I2S_2 interface) */
> -       pinctrl_i2s_2_bclk_gpio: main-gpio0-35-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0090, PIN_INPUT, 7) /* (M24) GPMC0_BE0n_CLE.GPIO0_35 */ /* SODIMM 42 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_6 */
> -       pinctrl_gpio_6: main-gpio0-36-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0094, PIN_INPUT, 7) /* (N20) GPMC0_BE1n.GPIO0_36 */ /* SODIMM 218 */
> -               >;
> -       };
> -
> -       /* Verdin ETH_2_RGMII_INT# */
> -       pinctrl_eth2_rgmii_int: main-gpio0-38-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x009c, PIN_INPUT, 7) /* (V25) GPMC0_WAIT1.GPIO0_38 */ /* SODIMM 189 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_5 */
> -       pinctrl_gpio_5: main-gpio0-40-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x00a4, PIN_INPUT, 7) /* (M22) GPMC0_DIR.GPIO0_40 */ /* SODIMM 216 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_7 */
> -       pinctrl_gpio_7: main-gpio0-41-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x00a8, PIN_INPUT, 7) /* (M21) GPMC0_CSn0.GPIO0_41 */ /* SODIMM 220 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_8 */
> -       pinctrl_gpio_8: main-gpio0-42-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x00ac, PIN_INPUT, 7) /* (L21) GPMC0_CSn1.GPIO0_42 */ /* SODIMM 222 */
> -               >;
> -       };
> -
> -       /* Verdin USB_1_OC# */
> -       pinctrl_usb1_oc: main-gpio0-71-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0124, PIN_INPUT, 7) /* (A23) MMC2_SDCD.GPIO0_71 */ /* SODIMM 157 */
> -               >;
> -       };
> -
> -       /* Verdin USB_2_OC# */
> -       pinctrl_usb2_oc: main-gpio0-72-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0128, PIN_INPUT, 7) /* (B23) MMC2_SDWP.GPIO0_72 */ /* SODIMM 187 */
> -               >;
> -       };
> -
> -       /* Verdin PWM_3_DSI as GPIO */
> -       pinctrl_pwm3_dsi_gpio: main-gpio1-17-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01bc, PIN_INPUT, 7) /* (A14) SPI0_CLK.GPIO1_17 */ /* SODIMM 19 */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1_DQS as GPIO */
> -       pinctrl_qspi1_dqs_gpio: main-gpio1-18-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01c0, PIN_INPUT, 7) /* (B13) SPI0_D0.GPIO1_18 */ /* SODIMM 66 */
> -               >;
> -       };
> -
> -       /* Verdin USB_1_ID */
> -       pinctrl_usb0_id: main-gpio1-19-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01c4, PIN_INPUT, 7) /* (B14) SPI0_D1.GPIO1_19 */ /* SODIMM 161 */
> -               >;
> -       };
> -
> -       /* Verdin DSI_1_INT# (pulled-up as active-low) */
> -       pinctrl_dsi1_int: main-gpio1-49-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0244, PIN_INPUT_PULLUP, 7) /* (C17) MMC1_SDWP.GPIO1_49 */ /* SODIMM 17 */
> -               >;
> -       };
> -
> -       /* On-module I2C - PMIC_I2C */
> -       pinctrl_i2c0: main-i2c0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01e0, PIN_INPUT, 0) /* (B16) I2C0_SCL */ /* PMIC_I2C_SCL */
> -                       AM62X_IOPAD(0x01e4, PIN_INPUT, 0) /* (A16) I2C0_SDA */ /* PMIC_I2C_SDA */
> -               >;
> -       };
> -
> -       /* Verdin I2C_1 */
> -       pinctrl_i2c1: main-i2c1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */ /* SODIMM 14 */
> -                       AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */ /* SODIMM 12 */
> -               >;
> -       };
> -
> -       /* Verdin I2C_2_DSI */
> -       pinctrl_i2c2: main-i2c2-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x00b0, PIN_INPUT, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */ /* SODIMM 55 */
> -                       AM62X_IOPAD(0x00b4, PIN_INPUT, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */ /* SODIMM 53 */
> -               >;
> -       };
> -
> -       /* Verdin I2C_4_CSI */
> -       pinctrl_i2c3: main-i2c3-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01d0, PIN_INPUT, 2) /* (A15) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
> -                       AM62X_IOPAD(0x01d4, PIN_INPUT, 2) /* (B15) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
> -               >;
> -       };
> -
> -       /* I2S_1_MCLK */
> -       pinctrl_i2s1_mclk: main-system-audio-ext-reflock1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */ /* SODIMM 38 */
> -               >;
> -       };
> -
> -       /* Verdin I2S_1 */
> -       pinctrl_mcasp0: main-mcasp0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01a4, PIN_INPUT,  0) /* (B20) MCASP0_ACLKX */ /* SODIMM 30 */
> -                       AM62X_IOPAD(0x01a8, PIN_INPUT,  0) /* (D20) MCASP0_AFSX  */ /* SODIMM 32 */
> -                       AM62X_IOPAD(0x01a0, PIN_OUTPUT, 0) /* (E18) MCASP0_AXR0  */ /* SODIMM 34 */
> -                       AM62X_IOPAD(0x019c, PIN_INPUT,  0) /* (B18) MCASP0_AXR1  */ /* SODIMM 36 */
> -               >;
> -       };
> -
> -       /* Verdin I2S_2 */
> -       pinctrl_mcasp1: main-mcasp1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0090, PIN_INPUT,  2) /* (M24) GPMC0_BE0n_CLE.MCASP1_ACLKX */ /* SODIMM 42 */
> -                       AM62X_IOPAD(0x0098, PIN_INPUT,  2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX     */ /* SODIMM 44 */
> -                       AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEn.MCASP1_AXR0       */ /* SODIMM 46 */
> -                       AM62X_IOPAD(0x0088, PIN_INPUT,  2) /* (L24) GPMC0_OEn_REn.MCASP1_AXR1   */ /* SODIMM 48 */
> -               >;
> -       };
> -
> -       /* Verdin CAN_1 */
> -       pinctrl_mcan0: main-mcan0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01dc, PIN_INPUT,  0) /* (E15) MCAN0_RX */ /* SODIMM 22 */
> -                       AM62X_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */ /* SODIMM 20 */
> -               >;
> -       };
> -
> -       /* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
> -       pinctrl_mdio: main-mdio1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC  */ /* ETH_1_MDC,  SODIMM 193 */
> -                       AM62X_IOPAD(0x15c, PIN_INPUT, 0)  /* (AB22) MDIO0_MDIO */ /* ETH_1_MDIO, SODIMM 191 */
> -               >;
> -       };
> -
> -       /* On-module eMMC */
> -       pinctrl_sdhci0: main-mmc0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x220, PIN_INPUT, 0) /*  (Y3) MMC0_CMD  */
> -                       AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK  */
> -                       AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
> -                       AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
> -                       AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
> -                       AM62X_IOPAD(0x208, PIN_INPUT, 0) /*  (Y4) MMC0_DAT3 */
> -                       AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
> -                       AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
> -                       AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
> -                       AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
> -               >;
> -       };
> -
> -       /* Verdin SD_1 */
> -       pinctrl_sdhci1: main-mmc1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x23c, PIN_INPUT,        0) /* (A21) MMC1_CMD  */ /* SODIMM 74 */
> -                       AM62X_IOPAD(0x234, PIN_INPUT,        0) /* (B22) MMC1_CLK  */ /* SODIMM 78 */
> -                       AM62X_IOPAD(0x230, PIN_INPUT,        0) /* (A22) MMC1_DAT0 */ /* SODIMM 80 */
> -                       AM62X_IOPAD(0x22c, PIN_INPUT,        0) /* (B21) MMC1_DAT1 */ /* SODIMM 82 */
> -                       AM62X_IOPAD(0x228, PIN_INPUT,        0) /* (C21) MMC1_DAT2 */ /* SODIMM 70 */
> -                       AM62X_IOPAD(0x224, PIN_INPUT,        0) /* (D22) MMC1_DAT3 */ /* SODIMM 72 */
> -                       AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */ /* SODIMM 84 */
> -               >;
> -       };
> -
> -       /* On-module Wi-Fi on WB SKUs, module-specific SDIO otherwise */
> -       pinctrl_sdhci2: main-mmc2-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x120, PIN_INPUT, 0) /* (C24) MMC2_CMD   */ /* WiFi_SDIO_CMD   */
> -                       AM62X_IOPAD(0x118, PIN_INPUT, 0) /* (D25) MMC2_CLK   */ /* WiFi_SDIO_CLK   */
> -                       AM62X_IOPAD(0x114, PIN_INPUT, 0) /* (B24) MMC2_DAT0  */ /* WiFi_SDIO_DATA0 */
> -                       AM62X_IOPAD(0x110, PIN_INPUT, 0) /* (C25) MMC2_DAT1  */ /* WiFi_SDIO_DATA1 */
> -                       AM62X_IOPAD(0x10c, PIN_INPUT, 0) /* (E23) MMC2_DAT2  */ /* WiFi_SDIO_DATA2 */
> -                       AM62X_IOPAD(0x108, PIN_INPUT, 0) /* (D24) MMC2_DAT3  */ /* WiFi_SDIO_DATA3 */
> -                       AM62X_IOPAD(0x11c, PIN_INPUT, 0) /* (#N/A) MMC2_CLKB */
> -               >;
> -       };
> -
> -       /* Verdin QSPI_1 */
> -       pinctrl_ospi0: main-ospi0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK  */ /* SODIMM 52 */
> -                       AM62X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */ /* SODIMM 54 */
> -                       AM62X_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G21) OSPI0_CSn1 */ /* SODIMM 64 */
> -                       AM62X_IOPAD(0x000c, PIN_INPUT, 0)  /* (E25) OSPI0_D0   */ /* SODIMM 56 */
> -                       AM62X_IOPAD(0x0010, PIN_INPUT, 0)  /* (G24) OSPI0_D1   */ /* SODIMM 58 */
> -                       AM62X_IOPAD(0x0014, PIN_INPUT, 0)  /* (F25) OSPI0_D2   */ /* SODIMM 60 */
> -                       AM62X_IOPAD(0x0018, PIN_INPUT, 0)  /* (F24) OSPI0_D3   */ /* SODIMM 62 */
> -               >;
> -       };
> -
> -       /* Verdin ETH_1 RGMII (On-module PHY) */
> -       pinctrl_rgmii1: main-rgmii1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x14c, PIN_INPUT,  0) /* (AB17) RGMII1_RD0    */
> -                       AM62X_IOPAD(0x150, PIN_INPUT,  0) /* (AC17) RGMII1_RD1    */
> -                       AM62X_IOPAD(0x154, PIN_INPUT,  0) /* (AB16) RGMII1_RD2    */
> -                       AM62X_IOPAD(0x158, PIN_INPUT,  0) /* (AA15) RGMII1_RD3    */
> -                       AM62X_IOPAD(0x148, PIN_INPUT,  0) /* (AD17) RGMII1_RXC    */
> -                       AM62X_IOPAD(0x144, PIN_INPUT,  0) /* (AE17) RGMII1_RX_CTL */
> -                       AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0    */
> -                       AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1    */
> -                       AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2    */
> -                       AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3    */
> -                       AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC    */
> -                       AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
> -               >;
> -       };
> -
> -       /* Verdin ETH_2 RGMII */
> -       pinctrl_rgmii2: main-rgmii2-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x184, PIN_INPUT,  0) /* (AE23) RGMII2_RD0    */ /* SODIMM 201 */
> -                       AM62X_IOPAD(0x188, PIN_INPUT,  0) /* (AB20) RGMII2_RD1    */ /* SODIMM 203 */
> -                       AM62X_IOPAD(0x18c, PIN_INPUT,  0) /* (AC21) RGMII2_RD2    */ /* SODIMM 205 */
> -                       AM62X_IOPAD(0x190, PIN_INPUT,  0) /* (AE22) RGMII2_RD3    */ /* SODIMM 207 */
> -                       AM62X_IOPAD(0x180, PIN_INPUT,  0) /* (AD23) RGMII2_RXC    */ /* SODIMM 197 */
> -                       AM62X_IOPAD(0x17c, PIN_INPUT,  0) /* (AD22) RGMII2_RX_CTL */ /* SODIMM 199 */
> -                       AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /*  (Y18) RGMII2_TD0    */ /* SODIMM 221 */
> -                       AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1    */ /* SODIMM 219 */
> -                       AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2    */ /* SODIMM 217 */
> -                       AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3    */ /* SODIMM 215 */
> -                       AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC    */ /* SODIMM 213 */
> -                       AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */ /* SODIMM 211 */
> -               >;
> -       };
> -
> -       /* Verdin SPI_1 */
> -       pinctrl_spi1: main-spi1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0020, PIN_INPUT, 1) /* (J25) OSPI0_D5.SPI1_CLK */ /* SODIMM 196 */
> -                       AM62X_IOPAD(0x001c, PIN_INPUT, 1) /* (J23) OSPI0_D4.SPI1_CS0 */ /* SODIMM 202 */
> -                       AM62X_IOPAD(0x0024, PIN_INPUT, 1) /* (H25) OSPI0_D6.SPI1_D0  */ /* SODIMM 200 */
> -                       AM62X_IOPAD(0x0028, PIN_INPUT, 1) /* (J22) OSPI0_D7.SPI1_D1  */ /* SODIMM 198 */
> -               >;
> -       };
> -
> -       /* ETH_25MHz_CLK */
> -       pinctrl_eth_clock: main-system-clkout0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01f0, PIN_OUTPUT_PULLUP, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
> -               >;
> -       };
> -
> -       /* PMIC_EXTINT# */
> -       pinctrl_pmic_extint: main-system-extint-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
> -               >;
> -       };
> -
> -       /* Verdin UART_3, used as the Linux console */
> -       pinctrl_uart0: main-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x1c8, PIN_INPUT_PULLUP, 0) /* (D14) UART0_RXD */ /* SODIMM 147 */
> -                       AM62X_IOPAD(0x1cc, PIN_OUTPUT,       0) /* (E14) UART0_TXD */ /* SODIMM 149 */
> -               >;
> -       };
> -
> -       /* Verdin UART_1 */
> -       pinctrl_uart1: main-uart1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0194, PIN_INPUT_PULLUP, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */ /* SODIMM 135 */
> -                       AM62X_IOPAD(0x0198, PIN_OUTPUT,       2) /* (A19) MCASP0_AXR2.UART1_RTSn */ /* SODIMM 133 */
> -                       AM62X_IOPAD(0x01ac, PIN_INPUT_PULLUP, 2) /* (E19) MCASP0_AFSR.UART1_RXD  */ /* SODIMM 129 */
> -                       AM62X_IOPAD(0x01b0, PIN_OUTPUT,       2) /* (A20) MCASP0_ACLKR.UART1_TXD */ /* SODIMM 131 */
> -               >;
> -       };
> -
> -       /* Bluetooth on WB SKUs, module-specific UART otherwise */
> -       pinctrl_uart5: main-uart5-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0008, PIN_INPUT_PULLUP, 5) /* (J24) OSPI0_DQS.UART5_CTSn    */ /* WiFi_UART_CTS */
> -                       AM62X_IOPAD(0x0004, PIN_OUTPUT,       5) /* (G25) OSPI0_LBCLKO.UART5_RTSn */ /* WiFi_UART_RTS */
> -                       AM62X_IOPAD(0x0034, PIN_INPUT_PULLUP, 5) /* (H21) OSPI0_CSn2.UART5_RXD    */ /* WiFi_UART_RXD */
> -                       AM62X_IOPAD(0x0038, PIN_OUTPUT,       5) /* (E24) OSPI0_CSn3.UART5_TXD    */ /* WiFi_UART_TXD */
> -               >;
> -       };
> -
> -       /* Verdin USB_1 */
> -       pinctrl_usb0: main-usb0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0254, PIN_OUTPUT, 0) /* (C20) USB0_DRVVBUS */ /* SODIMM 155 */
> -               >;
> -       };
> -
> -       /* Verdin USB_2 */
> -       pinctrl_usb1: main-usb1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */ /* SODIMM 185 */
> -               >;
> -       };
> -
> -       /* DSS VOUT0 RGB */
> -       pinctrl_parallel_rgb: main-vout-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_IOPAD(0x0100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC            */
> -                       AM62X_IOPAD(0x00f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC            */
> -                       AM62X_IOPAD(0x0104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK             */
> -                       AM62X_IOPAD(0x00fc, PIN_OUTPUT, 0) /*  (Y20) VOUT0_DE               */
> -                       AM62X_IOPAD(0x00b8, PIN_OUTPUT, 0) /*  (U22) VOUT0_DATA0            */
> -                       AM62X_IOPAD(0x00bc, PIN_OUTPUT, 0) /*  (V24) VOUT0_DATA1            */
> -                       AM62X_IOPAD(0x00c0, PIN_OUTPUT, 0) /*  (W25) VOUT0_DATA2            */
> -                       AM62X_IOPAD(0x00c4, PIN_OUTPUT, 0) /*  (W24) VOUT0_DATA3            */
> -                       AM62X_IOPAD(0x00c8, PIN_OUTPUT, 0) /*  (Y25) VOUT0_DATA4            */
> -                       AM62X_IOPAD(0x00cc, PIN_OUTPUT, 0) /*  (Y24) VOUT0_DATA5            */
> -                       AM62X_IOPAD(0x00d0, PIN_OUTPUT, 0) /*  (Y23) VOUT0_DATA6            */
> -                       AM62X_IOPAD(0x00d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7            */
> -                       AM62X_IOPAD(0x00d8, PIN_OUTPUT, 0) /*  (V21) VOUT0_DATA8            */
> -                       AM62X_IOPAD(0x00dc, PIN_OUTPUT, 0) /*  (W21) VOUT0_DATA9            */
> -                       AM62X_IOPAD(0x00e0, PIN_OUTPUT, 0) /*  (V20) VOUT0_DATA10           */
> -                       AM62X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11           */
> -                       AM62X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12           */
> -                       AM62X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13           */
> -                       AM62X_IOPAD(0x00f0, PIN_OUTPUT, 0) /*  (Y22) VOUT0_DATA14           */
> -                       AM62X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15           */
> -                       AM62X_IOPAD(0x005c, PIN_OUTPUT, 1) /*  (R24) GPMC0_AD8.VOUT0_DATA16 */
> -                       AM62X_IOPAD(0x0060, PIN_OUTPUT, 1) /*  (R25) GPMC0_AD9.VOUT0_DATA17 */
> -               >;
> -       };
> -};
> -
> -&mcu_pmx0 {
> -       /* Verdin PCIE_1_RESET# */
> -       pinctrl_pcie_1_reset: mcu-gpio0-0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0000, PIN_INPUT, 7) /* (E8) MCU_SPI0_CS0.MCU_GPIO0_0 */ /* SODIMM 244 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_1 */
> -       pinctrl_gpio_1: mcu-gpio0-1-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0004, PIN_INPUT, 7) /* (B8) MCU_SPI0_CS1.MCU_GPIO0_1 */ /* SODIMM 206 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_2 */
> -       pinctrl_gpio_2: mcu-gpio0-2-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0008, PIN_INPUT, 7) /* (A7) MCU_SPI0_CLK.MCU_GPIO0_2 */ /* SODIMM 208 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_3 */
> -       pinctrl_gpio_3: mcu-gpio0-3-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x000c, PIN_INPUT, 7) /* (D9) MCU_SPI0_D0.MCU_GPIO0_3 */ /* SODIMM 210 */
> -               >;
> -       };
> -
> -       /* Verdin GPIO_4 */
> -       pinctrl_gpio_4: mcu-gpio0-4-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0010, PIN_INPUT, 7) /* (C9) MCU_SPI0_D1.MCU_GPIO0_4 */ /* SODIMM 212 */
> -               >;
> -       };
> -
> -       /* Verdin I2C_3_HDMI */
> -       pinctrl_mcu_i2c0: mcu-i2c0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0044, PIN_INPUT, 0) /*  (A8) MCU_I2C0_SCL */ /* SODIMM 59 */
> -                       AM62X_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
> -               >;
> -       };
> -
> -       /* Verdin CAN_2 */
> -       pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> -                       AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */
> -               >;
> -       };
> -
> -       /* Verdin UART_4 - Reserved to Cortex-M4 */
> -       pinctrl_mcu_uart0: mcu-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0014, PIN_INPUT_PULLUP, 0) /* (B5) MCU_UART0_RXD */ /* SODIMM 151 */
> -                       AM62X_MCU_IOPAD(0x0018, PIN_OUTPUT,       0) /* (A5) MCU_UART0_TXD */ /* SODIMM 153 */
> -               >;
> -       };
> -
> -       /* Verdin CSI_1_MCLK */
> -       pinctrl_csi1_mclk: wkup-clkout0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (A12) WKUP_CLKOUT0 */ /* SODIMM 91 */
> -               >;
> -       };
> -
> -       /* Verdin UART_2 */
> -       pinctrl_wkup_uart0: wkup-uart0-default-pins {
> -               pinctrl-single,pins = <
> -                       AM62X_MCU_IOPAD(0x002c, PIN_INPUT_PULLUP, 0) /* (C6) WKUP_UART0_CTSn */ /* SODIMM 143 */
> -                       AM62X_MCU_IOPAD(0x0030, PIN_OUTPUT,       0) /* (A4) WKUP_UART0_RTSn */ /* SODIMM 141 */
> -                       AM62X_MCU_IOPAD(0x0024, PIN_INPUT_PULLUP, 0) /* (B4) WKUP_UART0_RXD  */ /* SODIMM 137 */
> -                       AM62X_MCU_IOPAD(0x0028, PIN_OUTPUT,       0) /* (C5) WKUP_UART0_TXD  */ /* SODIMM 139 */
> -               >;
> -       };
> -};
> -
> -/* VERDIN I2S_1_MCLK */
> -&audio_refclk1 {
> -       assigned-clock-rates = <25000000>;
> -};
> -
> -&cpsw3g {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_rgmii1>;
> -       status = "disabled";
> -};
> -
> -/* Verdin ETH_1 (On-module PHY) */
> -&cpsw_port1 {
> -       phy-handle = <&cpsw3g_phy0>;
> -       phy-mode = "rgmii-rxid";
> -       status = "disabled";
> -};
> -
> -/* Verdin ETH_2_RGMII */
> -&cpsw_port2 {
> -       status = "disabled";
> -};
> -
> -/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
> -&cpsw3g_mdio {
> -       assigned-clocks = <&k3_clks 157 20>;
> -       assigned-clock-parents = <&k3_clks 157 22>;
> -       assigned-clock-rates = <25000000>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_eth_clock>, <&pinctrl_mdio>;
> -       status = "disabled";
> -
> -       cpsw3g_phy0: ethernet-phy@0 {
> -               compatible = "ethernet-phy-id2000.a231";
> -               reg = <0>;
> -               interrupt-parent = <&main_gpio0>;
> -               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_eth_int>, <&pinctrl_eth_reset>;
> -               reset-gpios = <&main_gpio0 17 GPIO_ACTIVE_LOW>;
> -               reset-assert-us = <10>;
> -               reset-deassert-us = <1000>;
> -               ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> -               ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> -       };
> -};
> -
> -&dss {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_parallel_rgb>;
> -       status = "disabled";
> -};
> -
> -&dss_ports {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -
> -       /* VP2: DPI Output */
> -       port@1 {
> -               reg = <1>;
> -
> -               dpi_out: endpoint {
> -                       remote-endpoint = <&rgb_in>;
> -               };
> -       };
> -};
> -
> -/* Verdin PWM_1, PWM_2 */
> -&epwm0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_epwm0_a>, <&pinctrl_epwm0_b>;
> -       status = "disabled";
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&epwm1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_epwm1_a>;
> -       status = "disabled";
> -};
> -
> -&main_gpio0 {
> -       gpio-line-names =
> -               "SODIMM_52", /* 0 */
> -               "",
> -               "",
> -               "SODIMM_56",
> -               "SODIMM_58",
> -               "SODIMM_60",
> -               "SODIMM_62",
> -               "",
> -               "",
> -               "",
> -               "", /* 10 */
> -               "SODIMM_54",
> -               "SODIMM_64",
> -               "",
> -               "",
> -               "SODIMM_174",
> -               "SODIMM_172",
> -               "",
> -               "",
> -               "",
> -               "", /* 20 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "SODIMM_76",
> -               "SODIMM_21", /* 30 */
> -               "SODIMM_256",
> -               "SODIMM_252",
> -               "",
> -               "SODIMM_46",
> -               "SODIMM_42",
> -               "SODIMM_218",
> -               "",
> -               "SODIMM_189",
> -               "",
> -               "SODIMM_216", /* 40 */
> -               "SODIMM_220",
> -               "SODIMM_222",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 50 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 60 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 70 */
> -               "SODIMM_157",
> -               "SODIMM_187",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 80 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "";
> -
> -       verdin_ctrl_sleep_moci: ctrl-sleep-moci-hog {
> -               gpio-hog;
> -               /* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
> -               gpios = <31 GPIO_ACTIVE_HIGH>;
> -               line-name = "CTRL_SLEEP_MOCI#";
> -               output-high;
> -       };
> -};
> -
> -&main_gpio1 {
> -       gpio-line-names =
> -               "", /* 0 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 10 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "SODIMM_15",
> -               "SODIMM_16",
> -               "SODIMM_19",
> -               "SODIMM_66",
> -               "SODIMM_161",
> -               "", /* 20 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 30 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 40 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "SODIMM_17",
> -               "", /* 50 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 60 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 70 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "", /* 80 */
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "";
> -};
> -
> -/* On-module I2C - PMIC_I2C */
> -&main_i2c0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c0>;
> -       clock-frequency = <400000>;
> -       status = "okay";
> -
> -       dsi_bridge: dsi@e {
> -               compatible = "toshiba,tc358778";
> -               reg = <0xe>;
> -               assigned-clocks = <&k3_clks 157 20>;
> -               assigned-clock-parents = <&k3_clks 157 22>;
> -               assigned-clock-rates = <25000000>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_bridge_reset>;
> -               clocks = <&k3_clks 157 20>;
> -               clock-names = "refclk";
> -               reset-gpios = <&main_gpio0 20 GPIO_ACTIVE_LOW>;
> -               vddc-supply = <&reg_1v2_dsi>;
> -               vddmipi-supply = <&reg_1v2_dsi>;
> -               vddio-supply = <&reg_1v8_dsi>;
> -               status = "disabled";
> -
> -               dsi_bridge_ports: ports {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -
> -                       port@0 {
> -                               reg = <0>;
> -
> -                               rgb_in: endpoint {
> -                                       data-lines = <18>;
> -                                       remote-endpoint = <&dpi_out>;
> -                               };
> -                       };
> -
> -                       port@1 {
> -                               reg = <1>;
> -                       };
> -               };
> -       };
> -
> -       pmic@30 {
> -               compatible = "ti,tps65219";
> -               reg = <0x30>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pmic_extint>;
> -               interrupt-parent = <&gic500>;
> -               interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               buck1-supply = <&reg_vsodimm>;
> -               buck2-supply = <&reg_vsodimm>;
> -               buck3-supply = <&reg_vsodimm>;
> -               ldo1-supply = <&reg_3v3>;
> -               ldo2-supply = <&reg_1v8>;
> -               ldo3-supply = <&reg_3v3>;
> -               ldo4-supply = <&reg_3v3>;
> -               system-power-controller;
> -               ti,power-button;
> -
> -               regulators {
> -                       reg_vdd_core: buck1 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <850000>;
> -                               regulator-min-microvolt = <850000>;
> -                               regulator-name = "+VDD_CORE (PMIC BUCK1)";
> -                       };
> -
> -                       reg_1v8: buck2 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "+V1.8 (PMIC BUCK2)"; /* On-module and SODIMM 214 */
> -                       };
> -
> -                       reg_vdd_ddr: buck3 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1100000>;
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-name = "+VDD_DDR (PMIC BUCK3)";
> -                       };
> -
> -                       reg_sd_3v3_1v8: ldo1 {
> -                               regulator-allow-bypass;
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <3300000>;
> -                               regulator-name = "+V3.3_1.8_SD (PMIC LDO1)";
> -                       };
> -
> -                       reg_vddr_core: ldo2 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <850000>;
> -                               regulator-min-microvolt = <850000>;
> -                               regulator-name = "+VDDR_CORE (PMIC LDO2)";
> -                       };
> -
> -                       reg_1v8a: ldo3 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "+V1.8A (PMIC LDO3)";
> -                       };
> -
> -                       reg_eth_2v5: ldo4 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <2500000>;
> -                               regulator-min-microvolt = <2500000>;
> -                               regulator-name = "+V2.5_ETH (PMIC LDO4)";
> -                       };
> -               };
> -       };
> -
> -       rtc_i2c: rtc@32 {
> -               compatible = "epson,rx8130";
> -               reg = <0x32>;
> -       };
> -
> -       sensor@48 {
> -               compatible = "ti,tmp1075";
> -               reg = <0x48>;
> -       };
> -
> -       adc@49 {
> -               compatible = "ti,ads1015";
> -               reg = <0x49>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               /* Verdin PMIC_I2C (ADC_4 - ADC_3) */
> -               channel@0 {
> -                       reg = <0>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C (ADC_4 - ADC_1) */
> -               channel@1 {
> -                       reg = <1>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C (ADC_3 - ADC_1) */
> -               channel@2 {
> -                       reg = <2>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C (ADC_2 - ADC_1) */
> -               channel@3 {
> -                       reg = <3>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C ADC_4 */
> -               channel@4 {
> -                       reg = <4>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C ADC_3 */
> -               channel@5 {
> -                       reg = <5>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C ADC_2 */
> -               channel@6 {
> -                       reg = <6>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin PMIC_I2C ADC_1 */
> -               channel@7 {
> -                       reg = <7>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -       };
> -
> -       eeprom@50 {
> -               compatible = "st,24c02", "atmel,24c02";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -};
> -
> -/* Verdin I2C_1 */
> -&main_i2c1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c1>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2C_2_DSI */
> -&main_i2c2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2C_4_CSI */
> -&main_i2c3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c3>;
> -       status = "disabled";
> -};
> -
> -&mailbox0_cluster0 {
> -       mbox_m4_0: mbox-m4-0 {
> -               ti,mbox-rx = <0 0 0>;
> -               ti,mbox-tx = <1 0 0>;
> -       };
> -};
> -
> -/* Verdin CAN_1 */
> -&main_mcan0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcan0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin SPI_1 */
> -&main_spi1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_spi1>;
> -       ti,pindir-d0-out-d1-in;
> -       status = "disabled";
> -};
> -
> -/* Verdin UART_3, used as the Linux console */
> -&main_uart0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin UART_1 */
> -&main_uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2S_1 */
> -&mcasp0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcasp0>;
> -       op-mode = <0>; /* I2S mode */
> -       serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> -              1 2 0 0
> -              0 0 0 0
> -              0 0 0 0
> -              0 0 0 0
> -       >;
> -       tdm-slots = <2>;
> -       rx-num-evt = <32>;
> -       tx-num-evt = <32>;
> -       #sound-dai-cells = <0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2S_2 */
> -&mcasp1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcasp1>;
> -       op-mode = <0>; /* I2S mode */
> -       serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> -              1 2 0 0
> -              0 0 0 0
> -              0 0 0 0
> -              0 0 0 0
> -       >;
> -       tdm-slots = <2>;
> -       rx-num-evt = <32>;
> -       tx-num-evt = <32>;
> -       #sound-dai-cells = <0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2C_3_HDMI */
> -&mcu_i2c0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcu_i2c0>;
> -       status = "disabled";
> -};
> -
> -&mcu_gpio0 {
> -       gpio-line-names =
> -               "SODIMM_244",
> -               "SODIMM_206",
> -               "SODIMM_208",
> -               "SODIMM_210",
> -               "SODIMM_212",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "",
> -               "";
> -};
> -
> -/* Verdin CAN_2 */
> -&mcu_mcan0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcu_mcan0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin UART_4 - Cortex-M4 UART */
> -&mcu_uart0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_mcu_uart0>;
> -       status = "disabled";
> -};
> -
> -/* Verdin QSPI_1 */
> -&ospi0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ospi0>;
> -       status = "disabled";
> -};
> -
> -/* On-module eMMC */
> -&sdhci0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_sdhci0>;
> -       non-removable;
> -       ti,driver-strength-ohm = <50>;
> -       status = "okay";
> -};
> -
> -/* Verdin SD_1 */
> -&sdhci1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_sdhci1>;
> -       disable-wp;
> -       ti,driver-strength-ohm = <50>;
> -       vmmc-supply = <&reg_sdhc1_vmmc>;
> -       vqmmc-supply = <&reg_sdhc1_vqmmc>;
> -       status = "disabled";
> -};
> -
> -/* Verdin USB_1 */
> -&usbss0 {
> -       ti,vbus-divider;
> -       status = "disabled";
> -};
> -
> -/* TODO: role swich using ID pin */
> -&usb0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb0_id>;
> -       status = "disabled";
> -};
> -
> -/* Verdin USB_2 */
> -&usbss1 {
> -       ti,vbus-divider;
> -       status = "disabled";
> -};
> -
> -&usb1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usb1>;
> -       dr_mode = "host";
> -       status = "disabled";
> -};
> -
> -/* Verdin UART_2 */
> -&wkup_uart0 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_wkup_uart0>;
> -       status = "disabled";
> -};
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index 4e3704809a6..6f5845024f2 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -140,7 +140,7 @@
>
>  #ifdef CONFIG_TARGET_VERDIN_AM62_A53
>
> -#define SPL_VERDIN_AM62_DTB "spl/dts/k3-am625-verdin-wifi-dev.dtb"
> +#define SPL_VERDIN_AM62_DTB "spl/dts/ti/k3-am625-verdin-wifi-dev.dtb"
>  #define VERDIN_AM62_DTB "u-boot.dtb"
>
>  &binman {
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev.dts b/arch/arm/dts/k3-am625-verdin-wifi-dev.dts
> deleted file mode 100644
> index 4b657d6d3e0..00000000000
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2023 Toradex
> - *
> - * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> - * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
> - */
> -
> -/dts-v1/;
> -
> -#include "k3-am625.dtsi"
> -#include "k3-am62-verdin.dtsi"
> -#include "k3-am62-verdin-wifi.dtsi"
> -#include "k3-am62-verdin-dev.dtsi"
> -
> -/ {
> -       model = "Toradex Verdin AM62 WB on Verdin Development Board";
> -       compatible = "toradex,verdin-am62-wifi-dev",
> -                    "toradex,verdin-am62-wifi",
> -                    "toradex,verdin-am62",
> -                    "ti,am625";
> -};
> diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
> index 7c9bac2ece8..9786751874d 100644
> --- a/arch/arm/mach-k3/am62x/Kconfig
> +++ b/arch/arm/mach-k3/am62x/Kconfig
> @@ -48,6 +48,7 @@ config TARGET_VERDIN_AM62_A53
>         select ARM64
>         select BINMAN
>         select OF_SYSTEM_SETUP
> +       imply OF_UPSTREAM
>
>  config TARGET_VERDIN_AM62_R5
>         bool "Toradex Verdin AM62 running on R5"
> diff --git a/board/toradex/verdin-am62/MAINTAINERS b/board/toradex/verdin-am62/MAINTAINERS
> index 4e75980dbd7..3e30d1d5112 100644
> --- a/board/toradex/verdin-am62/MAINTAINERS
> +++ b/board/toradex/verdin-am62/MAINTAINERS
> @@ -1,12 +1,8 @@
>  Verdin AM62
>  F:     arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
>  F:     arch/arm/dts/k3-am625-verdin-r5.dts
> -F:     arch/arm/dts/k3-am625-verdin-wifi-dev.dts
>  F:     arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
>  F:     arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> -F:     arch/arm/dts/k3-am62-verdin-dev.dtsi
> -F:     arch/arm/dts/k3-am62-verdin.dtsi
> -F:     arch/arm/dts/k3-am62-verdin-wifi.dtsi
>  F:     board/toradex/verdin-am62/
>  F:     configs/verdin-am62_a53_defconfig
>  F:     configs/verdin-am62_r5_defconfig
> diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
> index 15424fedb90..633e9c7398e 100644
> --- a/configs/verdin-am62_a53_defconfig
> +++ b/configs/verdin-am62_a53_defconfig
> @@ -14,7 +14,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
>  CONFIG_ENV_SIZE=0x2000
>  CONFIG_ENV_OFFSET=0xFFFFDE00
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="k3-am625-verdin-wifi-dev"
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-verdin-wifi-dev"
>  CONFIG_SPL_TEXT_BASE=0x80080000
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
> --
> 2.44.0
>
