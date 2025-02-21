Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7430DC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 10:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A5E80F67;
	Fri, 21 Feb 2025 11:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vvAs7iCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5730380F6F; Fri, 21 Feb 2025 11:14:38 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45048007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4bd367926easo608106137.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740132874; x=1740737674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AQQJ2KRsZnqrxrh9IaYssKUJu1f3acSF2RqE6GJaGH4=;
 b=vvAs7iCIlFf6Fp20Ls4EFTEto0qkkDPPKleO/7/y/pPy5hvBVMM6hSFut/gF8ihhQ+
 biIpA2xI44dM5teUaCT7K8KyGo47aOAmSjj+ITj0di3Ae17Yq9/OUsItBtjIMlXN3u5b
 IVjfTHAiBKu3mwLfZDyMYWats39VAzHqE9tYq0hxZH/lmyTmK6wBEwL5vr0Y+3ytPxLK
 RG4FMYuYgb9rVNXYH1JDSVtBkBYSXqkXolSM/yX+n7lUHxyzC9mTXUK2VtS1DR+FptDx
 POQuv2P2nlXlEk2CEcDixYZ09EnKMQ1ntiWX4jh9+1vwopkznqVUxUtAi4iIUM/c5OW0
 UpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132874; x=1740737674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQQJ2KRsZnqrxrh9IaYssKUJu1f3acSF2RqE6GJaGH4=;
 b=Tm4VL22EKgRBjtDu/cz3GGxNlTzcd74u/z/8ej0kLD7hzNdc5HK2V26FLWCm9Yq7wZ
 2sLyfXVfodxkBGVELPS2yEihPHQ5i2mFMYymw5i9yykHqZo8vpCmh6fxCslRqHn3w2n1
 k0+m0hjbvqqGZnZDW8soVKvcZ34kH5IjhANcEqz8HmV4kWg0O+uwWh7h/bW9ZIIx2QmE
 59gdTa81VGR1UMsgYP3ysUqM+FzRK/CKwJmHMFm9Mnd1XmylwmKrsP/Yno71Dxn+XpOl
 USCN/rmAZIx/geX92GOcuP+TmCyJFDbgYPndMBV4l/hkfV6HjlZWOvM9NNWiSdPs4WJ0
 eDhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi3+bcvEP9+CfrQNvcB4KUYrem2uP8vwdWbRRj98gn4g/yVGESj1ZaCkPgdPo7k8e71z/NIXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwMACHpQxX2oGbKg8cnwmF6wDLSmRl/d0ek3x8rSdsepZmCIWkq
 1myQtq+uAkhff0/sp6Q7fsYr1ZCCkp4Sw4dtzwIkBuFa3GOJmN6WxuNTrX3mfKx7wpmQKT8Lr4b
 rwgOZLtHGopwQ2cP3aKuj/7B605xB0tzRXpf23A==
X-Gm-Gg: ASbGncvIT0I9+AgSzpJV2oY9bnj2Soesd1T9l618JkZQ4ffAw8RZGMafWP+mQDLvQUh
 1UgyV370rO6lucHzm9m1xpLl9kmagc/hBfygXyigdQmWfuGDUkghLNv1RvZvfZqwvTEs88hc/IO
 hi3BsQykAcQA==
X-Google-Smtp-Source: AGHT+IHXKz+WbE3DKNIH9uXuGAluvC3SP/Bcn/Wyl2djGmq25BReSFPMmXywaZ/RGKoXCcmQO+RXHNq18JT3mzkoJBw=
X-Received: by 2002:a05:6102:50a4:b0:4bd:22d5:fbd7 with SMTP id
 ada2fe7eead31-4bfc00cdcdcmr1744434137.11.1740132874500; Fri, 21 Feb 2025
 02:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20250221100314.464818-1-manikandan.m@microchip.com>
 <20250221100314.464818-7-manikandan.m@microchip.com>
In-Reply-To: <20250221100314.464818-7-manikandan.m@microchip.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Feb 2025 15:44:23 +0530
X-Gm-Features: AWEUYZkZ7sJMnSGcEBShhc4v741PZvyZSOWQNO4qkVdgi2pYdIPYvIIDoEsSpXA
Message-ID: <CAFA6WYNO8KM_na+Yrtf4LqoME9bDP-2RxcdXX72xErnd3Jwoxw@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: dts: at91: sam9x75_curiosity: add sam9x75
 curiosity board
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 seanga2@gmail.com, 
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com, 
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, nicolas.ferre@microchip.com, 
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Fri, 21 Feb 2025 at 15:34, Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:
>
> Add device tree file for sam9x75 curiosity board.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/Makefile                         |   2 +
>  .../dts/at91-sam9x75_curiosity-u-boot.dtsi    |  79 ++++
>  arch/arm/dts/at91-sam9x75_curiosity.dts       | 374 ++++++++++++++++++

Ditto, try to enable OF_UPSTREAM.

-Sumit

>  3 files changed, 455 insertions(+)
>  create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
>  create mode 100644 arch/arm/dts/at91-sam9x75_curiosity.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 0bf3697bdbe..f9bcfcf3d1f 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -959,6 +959,8 @@ dtb-$(CONFIG_TARGET_SAM9X60EK) += sam9x60ek.dtb
>
>  dtb-$(CONFIG_TARGET_SAM9X60_CURIOSITY) += at91-sam9x60_curiosity.dtb
>
> +dtb-$(CONFIG_TARGET_SAM9X75_CURIOSITY) += at91-sam9x75_curiosity.dtb
> +
>  dtb-$(CONFIG_TARGET_AT91SAM9N12EK) += at91sam9n12ek.dtb
>
>  dtb-$(CONFIG_TARGET_GARDENA_SMART_GATEWAY_AT91SAM) += \
> diff --git a/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
> new file mode 100644
> index 00000000000..a07fb83d9c6
> --- /dev/null
> +++ b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity-u-boot.dtsi - Device Tree file for SAM9X75
> + * CURIOSITY board.
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
> + */
> +
> +/ {
> +       ahb {
> +               bootph-all;
> +
> +               apb {
> +                       bootph-all;
> +
> +                       pinctrl {
> +                               bootph-all;
> +                       };
> +               };
> +       };
> +
> +       chosen {
> +               bootph-all;
> +       };
> +};
> +
> +&clk32k {
> +       bootph-all;
> +};
> +
> +&dbgu {
> +       bootph-all;
> +};
> +
> +&main_rc {
> +       bootph-all;
> +};
> +
> +&main_xtal {
> +       bootph-all;
> +};
> +
> +&pinctrl_dbgu_default {
> +       bootph-all;
> +};
> +
> +&pinctrl_sdmmc0_default {
> +       bootph-all;
> +};
> +
> +&pioA {
> +       bootph-all;
> +};
> +
> +&pioB {
> +       bootph-all;
> +};
> +
> +&pit64b0 {
> +       bootph-all;
> +};
> +
> +&pmc {
> +       bootph-all;
> +};
> +
> +&sdmmc0 {
> +       bootph-all;
> +};
> +
> +&slow_xtal {
> +       bootph-all;
> +};
> +
> +&slow_rc_osc {
> +       bootph-all;
> +};
> diff --git a/arch/arm/dts/at91-sam9x75_curiosity.dts b/arch/arm/dts/at91-sam9x75_curiosity.dts
> new file mode 100644
> index 00000000000..a35de9ca82c
> --- /dev/null
> +++ b/arch/arm/dts/at91-sam9x75_curiosity.dts
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
> + */
> +/dts-v1/;
> +#include "sam9x7.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "Microchip SAM9X75 Curiosity";
> +       compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
> +
> +       aliases {
> +               i2c0 = &i2c6;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +               button-user {
> +                       label = "USER";
> +                       gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_0>;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       led-controller {
> +               compatible = "gpio-leds";
> +
> +               led_red: led-red {
> +                       label = "red";
> +                       gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
> +                       pinctrl-0 = <&pinctrl_red_led_gpio_default>;
> +               };
> +
> +               led_green: led-green {
> +                       label = "green";
> +                       gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +                       pinctrl-0 = <&pinctrl_green_led_gpio_default>;
> +               };
> +
> +               led_blue: led-blue {
> +                       label = "blue";
> +                       gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
> +                       pinctrl-0 = <&pinctrl_blue_led_gpio_default>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +
> +       memory {
> +               reg = <0x20000000 0x10000000>;
> +               device_type = "memory";
> +       };
> +};
> +
> +&classd {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_classd_default>;
> +       atmel,pwm-type = "diff";
> +       atmel,non-overlap-time = <10>;
> +       status = "okay";
> +};
> +
> +&dbgu {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dbgu_default>;
> +       status = "okay";
> +};
> +
> +&dma0 {
> +       status = "okay";
> +};
> +
> +&flx6 {
> +       atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flx6_default>;
> +       i2c-analog-filter;
> +       i2c-digital-filter;
> +       i2c-digital-filter-width-ns = <35>;
> +       status = "okay";
> +
> +       pmic@5b {
> +               compatible = "microchip,mcp16502";
> +               reg = <0x5b>;
> +
> +               regulators {
> +                       vdd_3v3: VDD_IO {
> +                               regulator-name = "VDD_IO";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-initial-mode = <2>;
> +                               regulator-allowed-modes = <2>, <4>;
> +                               regulator-always-on;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                                       regulator-mode = <4>;
> +                               };
> +
> +                               regulator-state-mem {
> +                                       regulator-mode = <4>;
> +                               };
> +                       };
> +
> +                       vddioddr: VDD_DDR {
> +                               regulator-name = "VDD_DDR";
> +                               regulator-min-microvolt = <1350000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-initial-mode = <2>;
> +                               regulator-allowed-modes = <2>, <4>;
> +                               regulator-always-on;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                                       regulator-mode = <4>;
> +                               };
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-mode = <4>;
> +                               };
> +                       };
> +
> +                       vddcore: VDD_CORE {
> +                               regulator-name = "VDD_CORE";
> +                               regulator-min-microvolt = <1150000>;
> +                               regulator-max-microvolt = <1150000>;
> +                               regulator-initial-mode = <2>;
> +                               regulator-allowed-modes = <2>, <4>;
> +                               regulator-always-on;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                                       regulator-mode = <4>;
> +                               };
> +
> +                               regulator-state-mem {
> +                                       regulator-mode = <4>;
> +                               };
> +                       };
> +
> +                       dcdc4: VDD_OTHER {
> +                               regulator-name = "VDD_OTHER";
> +                               regulator-min-microvolt = <1150000>;
> +                               regulator-max-microvolt = <1150000>;
> +                               regulator-initial-mode = <2>;
> +                               regulator-allowed-modes = <2>, <4>;
> +                               regulator-ramp-delay = <3125>;
> +                               regulator-always-on;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                                       regulator-mode = <4>;
> +                               };
> +
> +                               regulator-state-mem {
> +                                       regulator-mode = <4>;
> +                               };
> +                       };
> +
> +                       vldo1: LDO1 {
> +                               regulator-name = "LDO1";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vldo2: LDO2 {
> +                               regulator-name = "LDO2";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-standby {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&flx7 {
> +       atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +       status = "okay";
> +};
> +
> +&i2c7 {
> +       dmas = <0>, <0>;
> +       i2c-analog-filter;
> +       i2c-digital-filter;
> +       i2c-digital-filter-width-ns = <35>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flx7_default>;
> +       status = "okay";
> +
> +       power-monitor@10 {
> +               compatible = "microchip,pac1934";
> +               reg = <0x10>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               channel@1 {
> +                       reg = <0x1>;
> +                       shunt-resistor-micro-ohms = <10000>;
> +                       label = "VDD3V3";
> +               };
> +
> +               channel@2 {
> +                       reg = <0x2>;
> +                       shunt-resistor-micro-ohms = <10000>;
> +                       label = "DCDC4";
> +               };
> +
> +               channel@3 {
> +                       reg = <0x3>;
> +                       shunt-resistor-micro-ohms = <10000>;
> +                       label = "VDDCORE";
> +               };
> +
> +               channel@4 {
> +                       reg = <0x4>;
> +                       shunt-resistor-micro-ohms = <10000>;
> +                       label = "VDDIODDR";
> +               };
> +       };
> +};
> +
> +&i2s {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2s_default>;
> +       #sound-dai-cells = <0>;
> +       status = "okay";
> +};
> +
> +&main_xtal {
> +       clock-frequency = <24000000>;
> +};
> +
> +&pinctrl {
> +       classd {
> +               pinctrl_classd_default: classd-default {
> +                       atmel,pins =
> +                               <AT91_PIOA 18 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
> +                               <AT91_PIOA 19 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
> +               };
> +       };
> +
> +       dbgu {
> +               pinctrl_dbgu_default: dbgu-default {
> +                       atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +                                    <AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +               };
> +       };
> +
> +       flexcom {
> +               pinctrl_flx6_default: flx6-default {
> +                       atmel,pins =
> +                               <AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +                               <AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +               };
> +
> +               pinctrl_flx7_default: flx7-default {
> +                       atmel,pins =
> +                               <AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
> +                               <AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
> +               };
> +       };
> +
> +       gpio-keys {
> +               pinctrl_key_gpio_default: key-gpio-default {
> +                       atmel,pins = <AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +       };
> +
> +       i2s {
> +               pinctrl_i2s_default: i2s-default {
> +                       atmel,pins =
> +                               <AT91_PIOB 26 AT91_PERIPH_D AT91_PINCTRL_NONE>,         /* I2SCK */
> +                               <AT91_PIOB 15 AT91_PERIPH_D AT91_PINCTRL_NONE>,         /* I2SWS */
> +                               <AT91_PIOB 16 AT91_PERIPH_D AT91_PINCTRL_NONE>,         /* I2SDIN */
> +                               <AT91_PIOB 17 AT91_PERIPH_D AT91_PINCTRL_NONE>,         /* I2SDOUT */
> +                               <AT91_PIOB 25 AT91_PERIPH_D AT91_PINCTRL_NONE>;         /* I2SMCK */
> +               };
> +       };
> +
> +       led-controller {
> +               pinctrl_red_led_gpio_default: red-led-gpio-default {
> +                       atmel,pins = <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +               pinctrl_green_led_gpio_default: green-led-gpio-default {
> +                       atmel,pins = <AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +               pinctrl_blue_led_gpio_default: blue-led-gpio-default {
> +                       atmel,pins = <AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +               };
> +       };
> +
> +       sdmmc0 {
> +               pinctrl_sdmmc0_default: sdmmc0-default {
> +                       atmel,pins =
> +                               <AT91_PIOA 2 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,                               /* PA2 CK  periph A with pullup */
> +                               <AT91_PIOA 1 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,        /* PA1 CMD periph A with pullup */
> +                               <AT91_PIOA 0 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,        /* PA0 DAT0 periph A */
> +                               <AT91_PIOA 3 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,        /* PA3 DAT1 periph A with pullup */
> +                               <AT91_PIOA 4 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,        /* PA4 DAT2 periph A with pullup */
> +                               <AT91_PIOA 5 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;        /* PA5 DAT3 periph A with pullup */
> +               };
> +       };
> +}; /* pinctrl */
> +
> +&poweroff {
> +       debounce-delay-us = <976>;
> +       status = "okay";
> +
> +       input@0 {
> +               reg = <0>;
> +       };
> +};
> +
> +&rtt {
> +       atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> +
> +&sdmmc0 {
> +       bus-width = <4>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_sdmmc0_default>;
> +       cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
> +       disable-wp;
> +       status = "okay";
> +};
> +
> +&slow_xtal {
> +       clock-frequency = <32768>;
> +};
> +
> +&tcb {
> +       timer0: timer@0 {
> +               compatible = "atmel,tcb-timer";
> +               reg = <0>;
> +       };
> +
> +       timer1: timer@1 {
> +               compatible = "atmel,tcb-timer";
> +               reg = <1>;
> +       };
> +};
> +
> +&trng {
> +       status = "okay";
> +};
> +
> +&watchdog {
> +       status = "okay";
> +};
> --
> 2.25.1
>
