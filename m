Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C31BCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95AAB88414;
	Thu,  4 Apr 2024 12:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zbj1+dmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCD988213; Thu,  4 Apr 2024 06:06:22 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF3088220
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 06:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4788939769fso204388137.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712203572; x=1712808372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yaH6admuIDQR3pfsZ/S3r7+3CsAoy+Hqnyz7hb8Z+eg=;
 b=zbj1+dmVV+kp3iBfNJ59Neo3AiE5yaMlOicbC/GAGQhAtQfgjCF8cOTWlrgpRtDr+j
 4pWkzVaQz4cagZhg4y+rv2LT1yZquLEcF2NX+yUq8w0NLcaACv8ESIvBb1qrtil/fU95
 Ra/62byoaJAaZ5WhKxmIa+tmYF46WLESERJ/Q+97IcOuW7NJlyqeCqqHM+WYjDVlRlYJ
 3/yt7/FYfzt3RnFK8z6TWWk2i1qftNljSMQ8wFoi4/ijz9su6zuC6ycEwUshcOm/WWKN
 ZcIpHChKUVsi9rYc+5oQopUT6dqd+5W+nVZXfr14xPIL0mstOmzsWwgMOtwpM60PNZZR
 iANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712203572; x=1712808372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yaH6admuIDQR3pfsZ/S3r7+3CsAoy+Hqnyz7hb8Z+eg=;
 b=bB+ihzB0CKrA713RWeeS3qdCyDNpF6OE+T4D1cVOHCL8/+pNw76ytDbe1NyGCqrjXZ
 WgTtB9kF3vyrW7y8j1mIiCKjVadfECi4/j2AfbugKvHDIuws51NPtCMtetnCZAnRSvU5
 tFS+vDfZk5mokSMjOGQtTkVXZzvlcs47P3dMAcMSSHVGjVLPl2hW1rliP5Fg8fWEOgqH
 nv8Ij2zjFZWn5sFKqK5buuCBixs7HgdrkzPOK7a0X5aw/1uCRWX8mcw36ceiq87N2VzM
 tqMeOb5ZidvNX33sDyboKcXQmZl8yJS+LnKfNwLij7Iy9h9O6ovJjAowjnHM7MVm95CE
 iI7w==
X-Gm-Message-State: AOJu0YyAxtZw3s04gZ2+jxhCybCNCGyzERAwnHgvdb+2LxNQuHWZs+5a
 RXPebavlwpmPllbdq0bmVzDcFosA9yQwE/oax0nYhjfzkjEggCiXLk3k8KJ7tkM3UG59fxTEsVQ
 sqb2BVbXMnwWCmWD0Q4yWbVReRj/Ty0EA2pOjpg==
X-Google-Smtp-Source: AGHT+IFqFIXhwgUGOrDZdhPzjGCNnh5mAfo++7Zi8WqEnJvm7NzlIeVNH+VxLHwPju4QTxQe3ISV9UFIBp4hxcg/FOE=
X-Received: by 2002:a05:6102:3655:b0:478:3f7b:1d04 with SMTP id
 s21-20020a056102365500b004783f7b1d04mr1221366vsu.21.1712203571285; Wed, 03
 Apr 2024 21:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240403071555.400843-1-marcel@ziswiler.com>
In-Reply-To: <20240403071555.400843-1-marcel@ziswiler.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Apr 2024 09:35:59 +0530
Message-ID: <CAFA6WYPeNGC4d0scCcWFM2_vbs=LihZoSxC1R2gZ6fDW8pJ_pQ@mail.gmail.com>
Subject: Re: [PATCH v1] verdin-imx8mm/verdin-imx8mp: move imx verdins to
 OF_UPSTREAM
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Adam Ford <aford173@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gilles Talis <gilles.talis@gmail.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Patrick Wildt <patrick@blueri.se>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 04 Apr 2024 12:45:42 +0200
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

On Wed, 3 Apr 2024 at 12:51, Marcel Ziswiler <marcel@ziswiler.com> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Move verdin-imx8mm and verdin-imx8mp to OF_UPSTREAM:
> - handle the fact that dtbs now have a 'freescale/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>   *-u-boot.dtsi files
> - update MAINTAINERS files
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>  arch/arm/dts/Makefile                   |    2 -
>  arch/arm/dts/imx8mm-verdin-dev.dtsi     |  160 ---
>  arch/arm/dts/imx8mm-verdin-wifi-dev.dts |   18 -
>  arch/arm/dts/imx8mm-verdin-wifi.dtsi    |   94 --
>  arch/arm/dts/imx8mm-verdin.dtsi         | 1319 ---------------------
>  arch/arm/dts/imx8mp-verdin-dev.dtsi     |  165 ---
>  arch/arm/dts/imx8mp-verdin-wifi-dev.dts |   18 -
>  arch/arm/dts/imx8mp-verdin-wifi.dtsi    |   87 --
>  arch/arm/dts/imx8mp-verdin.dtsi         | 1438 -----------------------
>  arch/arm/mach-imx/imx8m/Kconfig         |    2 +
>  board/toradex/verdin-imx8mm/MAINTAINERS |    4 -
>  board/toradex/verdin-imx8mp/MAINTAINERS |    4 -
>  configs/verdin-imx8mm_defconfig         |    2 +-
>  configs/verdin-imx8mp_defconfig         |    2 +-
>  14 files changed, 4 insertions(+), 3311 deletions(-)
>  delete mode 100644 arch/arm/dts/imx8mm-verdin-dev.dtsi
>  delete mode 100644 arch/arm/dts/imx8mm-verdin-wifi-dev.dts
>  delete mode 100644 arch/arm/dts/imx8mm-verdin-wifi.dtsi
>  delete mode 100644 arch/arm/dts/imx8mm-verdin.dtsi
>  delete mode 100644 arch/arm/dts/imx8mp-verdin-dev.dtsi
>  delete mode 100644 arch/arm/dts/imx8mp-verdin-wifi-dev.dts
>  delete mode 100644 arch/arm/dts/imx8mp-verdin-wifi.dtsi
>  delete mode 100644 arch/arm/dts/imx8mp-verdin.dtsi
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 18fedc16740..cd8aa0b4143 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1082,7 +1082,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
>         imx8mm-phg.dtb \
>         imx8mm-phyboard-polis-rdk.dtb \
>         imx8mm-phygate-tauri-l.dtb \
> -       imx8mm-verdin-wifi-dev.dtb \
>         imx8mn-bsh-smm-s2.dtb \
>         imx8mn-bsh-smm-s2pro.dtb \
>         imx8mq-cm.dtb \
> @@ -1104,7 +1103,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
>         imx8mp-icore-mx8mp-edimm2.2.dtb \
>         imx8mp-msc-sm2s.dtb \
>         imx8mp-phyboard-pollux-rdk.dtb \
> -       imx8mp-verdin-wifi-dev.dtb \
>         imx8mq-pico-pi.dtb \
>         imx8mq-kontron-pitx-imx8m.dtb \
>         imx8mq-librem5-r4.dtb
> diff --git a/arch/arm/dts/imx8mm-verdin-dev.dtsi b/arch/arm/dts/imx8mm-verdin-dev.dtsi
> deleted file mode 100644
> index 3c4b8ca125e..00000000000
> --- a/arch/arm/dts/imx8mm-verdin-dev.dtsi
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/ {
> -       sound_card: sound-card {
> -               compatible = "simple-audio-card";
> -               simple-audio-card,bitclock-master = <&dailink_master>;
> -               simple-audio-card,format = "i2s";
> -               simple-audio-card,frame-master = <&dailink_master>;
> -               simple-audio-card,mclk-fs = <256>;
> -               simple-audio-card,name = "imx8mm-nau8822";
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
> -               dailink_master: simple-audio-card,codec {
> -                       clocks = <&clk IMX8MM_CLK_SAI2_ROOT>;
> -                       sound-dai = <&nau8822_1a>;
> -               };
> -
> -               simple-audio-card,cpu {
> -                       sound-dai = <&sai2>;
> -               };
> -       };
> -};
> -
> -/* Verdin SPI_1 */
> -&ecspi2 {
> -       status = "okay";
> -};
> -
> -/* EEPROM on display adapter boards */
> -&eeprom_display_adapter {
> -       status = "okay";
> -};
> -
> -/* EEPROM on Verdin Development board */
> -&eeprom_carrier_board {
> -       status = "okay";
> -};
> -
> -&fec1 {
> -       status = "okay";
> -};
> -
> -/* Verdin QSPI_1 */
> -&flexspi {
> -       status = "okay";
> -};
> -
> -/* Current measurement into module VCC */
> -&hwmon {
> -       status = "okay";
> -};
> -
> -&hwmon_temp {
> -       vs-supply = <&reg_1p8v>;
> -       status = "okay";
> -};
> -
> -&i2c3 {
> -       status = "okay";
> -};
> -
> -&gpio_expander_21 {
> -       status = "okay";
> -};
> -
> -/* Verdin I2C_1 */
> -&i2c4 {
> -       status = "okay";
> -
> -       /* Audio Codec */
> -       nau8822_1a: audio-codec@1a {
> -               compatible = "nuvoton,nau8822";
> -               reg = <0x1a>;
> -               #sound-dai-cells = <0>;
> -       };
> -};
> -
> -/* Verdin PCIE_1 */
> -&pcie0 {
> -       status = "okay";
> -};
> -
> -&pcie_phy {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&pwm1 {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_1 */
> -&pwm2 {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_2 */
> -&pwm3 {
> -       status = "okay";
> -};
> -
> -/* Verdin I2S_1 */
> -&sai2 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_3 */
> -&uart1 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_1, connector X50 through RS485 transceiver */
> -&uart2 {
> -       linux,rs485-enabled-at-boot-time;
> -       rs485-rts-active-low;
> -       rs485-rx-during-tx;
> -       status = "okay";
> -};
> -
> -/* Verdin UART_2 */
> -&uart3 {
> -       status = "okay";
> -};
> -
> -/* Verdin USB_1 */
> -&usbotg1 {
> -       disable-over-current;
> -       status = "okay";
> -};
> -
> -/* Verdin USB_2 */
> -&usbotg2 {
> -       disable-over-current;
> -       status = "okay";
> -};
> -
> -/* Limit frequency on dev board due to long traces and bad signal integrity */
> -&usdhc2 {
> -       max-frequency = <100000000>;
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev.dts b/arch/arm/dts/imx8mm-verdin-wifi-dev.dts
> deleted file mode 100644
> index ef952021832..00000000000
> --- a/arch/arm/dts/imx8mm-verdin-wifi-dev.dts
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/dts-v1/;
> -
> -#include "imx8mm-verdin.dtsi"
> -#include "imx8mm-verdin-wifi.dtsi"
> -#include "imx8mm-verdin-dev.dtsi"
> -
> -/ {
> -       model = "Toradex Verdin iMX8M Mini WB on Verdin Development Board";
> -       compatible = "toradex,verdin-imx8mm-wifi-dev",
> -                    "toradex,verdin-imx8mm-wifi",
> -                    "toradex,verdin-imx8mm",
> -                    "fsl,imx8mm";
> -};
> diff --git a/arch/arm/dts/imx8mm-verdin-wifi.dtsi b/arch/arm/dts/imx8mm-verdin-wifi.dtsi
> deleted file mode 100644
> index 017db9eab25..00000000000
> --- a/arch/arm/dts/imx8mm-verdin-wifi.dtsi
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/ {
> -       reg_wifi_en: regulator-wifi-en {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_wifi_pwr_en>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "PDn_AW-CM276NF";
> -               startup-delay-us = <2000>;
> -       };
> -};
> -
> -&gpio3 {
> -       gpio-line-names = "SODIMM_52",
> -                         "SODIMM_54",
> -                         "SODIMM_64",
> -                         "SODIMM_21",
> -                         "SODIMM_206",
> -                         "SODIMM_76",
> -                         "SODIMM_56",
> -                         "SODIMM_58",
> -                         "SODIMM_60",
> -                         "SODIMM_62",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_66",
> -                         "SODIMM_17",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_244",
> -                         "",
> -                         "SODIMM_48",
> -                         "SODIMM_44",
> -                         "SODIMM_42",
> -                         "SODIMM_46";
> -};
> -
> -&gpio4 {
> -       gpio-line-names = "SODIMM_102",
> -                         "SODIMM_90",
> -                         "SODIMM_92",
> -                         "SODIMM_94",
> -                         "SODIMM_96",
> -                         "SODIMM_100",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_120",
> -                         "SODIMM_104",
> -                         "SODIMM_106",
> -                         "SODIMM_108",
> -                         "SODIMM_112",
> -                         "SODIMM_114",
> -                         "SODIMM_116",
> -                         "",
> -                         "SODIMM_118",
> -                         "",
> -                         "SODIMM_88",
> -                         "SODIMM_149",
> -                         "SODIMM_147",
> -                         "SODIMM_36",
> -                         "SODIMM_32",
> -                         "SODIMM_30",
> -                         "SODIMM_34",
> -                         "SODIMM_38",
> -                         "SODIMM_252",
> -                         "SODIMM_133",
> -                         "SODIMM_135",
> -                         "SODIMM_129";
> -};
> -
> -/* On-module Wi-Fi */
> -&usdhc3 {
> -       bus-width = <4>;
> -       keep-power-in-suspend;
> -       non-removable;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -       pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wifi_ctrl>;
> -       pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_wifi_ctrl>;
> -       pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_wifi_ctrl>;
> -       vmmc-supply = <&reg_wifi_en>;
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/imx8mm-verdin.dtsi b/arch/arm/dts/imx8mm-verdin.dtsi
> deleted file mode 100644
> index 6f081158714..00000000000
> --- a/arch/arm/dts/imx8mm-verdin.dtsi
> +++ /dev/null
> @@ -1,1319 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -#include <dt-bindings/phy/phy-imx8-pcie.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "imx8mm.dtsi"
> -
> -/ {
> -       chosen {
> -               stdout-path = &uart1;
> -       };
> -
> -       aliases {
> -               rtc0 = &rtc_i2c;
> -               rtc1 = &snvs_rtc;
> -       };
> -
> -       backlight: backlight {
> -               compatible = "pwm-backlight";
> -               brightness-levels = <0 45 63 88 119 158 203 255>;
> -               default-brightness-level = <4>;
> -               /* Verdin I2S_2_D_OUT (DSI_1_BKL_EN/DSI_1_BKL_EN_LVDS, SODIMM 46) */
> -               enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_i2s_2_d_out_dsi_1_bkl_en>;
> -               power-supply = <&reg_3p3v>;
> -               /* Verdin PWM_3_DSI/PWM_3_DSI_LVDS (SODIMM 19) */
> -               pwms = <&pwm1 0 6666667 PWM_POLARITY_INVERTED>;
> -               status = "disabled";
> -       };
> -
> -       /* Fixed clock dedicated to SPI CAN controller */
> -       clk40m: oscillator {
> -               compatible = "fixed-clock";
> -               #clock-cells = <0>;
> -               clock-frequency = <40000000>;
> -       };
> -
> -       gpio-keys {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_keys>;
> -
> -               key-wakeup {
> -                       debounce-interval = <10>;
> -                       /* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
> -                       gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
> -                       label = "Wake-Up";
> -                       linux,code = <KEY_WAKEUP>;
> -                       wakeup-source;
> -               };
> -       };
> -
> -       hdmi_connector: hdmi-connector {
> -               compatible = "hdmi-connector";
> -               ddc-i2c-bus = <&i2c2>;
> -               /* Verdin PWM_3_DSI (SODIMM 19) */
> -               hpd-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> -               label = "hdmi";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pwm_3_dsi_hpd_gpio>;
> -               type = "a";
> -               status = "disabled";
> -       };
> -
> -       panel_lvds: panel-lvds {
> -               compatible = "panel-lvds";
> -               backlight = <&backlight>;
> -               data-mapping = "vesa-24";
> -               status = "disabled";
> -       };
> -
> -       /* Carrier Board Supplies */
> -       reg_1p8v: regulator-1p8v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1800000>;
> -               regulator-min-microvolt = <1800000>;
> -               regulator-name = "+V1.8_SW";
> -       };
> -
> -       reg_3p3v: regulator-3p3v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_SW";
> -       };
> -
> -       reg_5p0v: regulator-5p0v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "+V5_SW";
> -       };
> -
> -       /* Non PMIC On-module Supplies */
> -       reg_ethphy: regulator-ethphy {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>; /* PMIC_EN_ETH */
> -               off-on-delay-us = <500000>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_eth>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "On-module +V3.3_ETH";
> -               startup-delay-us = <200000>;
> -       };
> -
> -       reg_usb_otg1_vbus: regulator-usb-otg1 {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin USB_1_EN (SODIMM 155) */
> -               gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_usb1_en>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "USB_1_EN";
> -       };
> -
> -       reg_usb_otg2_vbus: regulator-usb-otg2 {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin USB_2_EN (SODIMM 185) */
> -               gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_usb2_en>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "USB_2_EN";
> -       };
> -
> -       reg_usdhc2_vmmc: regulator-usdhc2 {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin SD_1_PWR_EN (SODIMM 76) */
> -               gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
> -               off-on-delay-us = <100000>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_SD";
> -               startup-delay-us = <2000>;
> -       };
> -
> -       reserved-memory {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               /* Use the kernel configuration settings instead */
> -               /delete-node/ linux,cma;
> -       };
> -};
> -
> -&A53_0 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_1 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_2 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_3 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&cpu_alert0 {
> -       temperature = <95000>;
> -};
> -
> -&cpu_crit0 {
> -       temperature = <105000>;
> -};
> -
> -&ddrc {
> -       operating-points-v2 = <&ddrc_opp_table>;
> -
> -       ddrc_opp_table: opp-table {
> -               compatible = "operating-points-v2";
> -
> -               opp-25000000 {
> -                       opp-hz = /bits/ 64 <25000000>;
> -               };
> -
> -               opp-100000000 {
> -                       opp-hz = /bits/ 64 <100000000>;
> -               };
> -
> -               opp-750000000 {
> -                       opp-hz = /bits/ 64 <750000000>;
> -               };
> -       };
> -};
> -
> -/* Verdin SPI_1 */
> -&ecspi2 {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -       cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi2>;
> -};
> -
> -/* Verdin CAN_1 (On-module) */
> -&ecspi3 {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -       cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi3>;
> -       status = "okay";
> -
> -       can1: can@0 {
> -               compatible = "microchip,mcp251xfd";
> -               clocks = <&clk40m>;
> -               interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_can1_int>;
> -               reg = <0>;
> -               spi-max-frequency = <8500000>;
> -       };
> -};
> -
> -/* Verdin ETH_1 (On-module PHY) */
> -&fec1 {
> -       fsl,magic-packet;
> -       phy-handle = <&ethphy0>;
> -       phy-mode = "rgmii-id";
> -       phy-supply = <&reg_ethphy>;
> -       pinctrl-names = "default", "sleep";
> -       pinctrl-0 = <&pinctrl_fec1>;
> -       pinctrl-1 = <&pinctrl_fec1_sleep>;
> -
> -       mdio {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               ethphy0: ethernet-phy@7 {
> -                       compatible = "ethernet-phy-ieee802.3-c22";
> -                       interrupt-parent = <&gpio1>;
> -                       interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -                       micrel,led-mode = <0>;
> -                       reg = <7>;
> -               };
> -       };
> -};
> -
> -/* Verdin QSPI_1 */
> -&flexspi {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_flexspi0>;
> -};
> -
> -&gpio1 {
> -       gpio-line-names = "SODIMM_216",
> -                         "SODIMM_19",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_220",
> -                         "SODIMM_222",
> -                         "",
> -                         "SODIMM_218",
> -                         "SODIMM_155",
> -                         "SODIMM_157",
> -                         "SODIMM_185",
> -                         "SODIMM_187";
> -};
> -
> -&gpio2 {
> -       gpio-line-names = "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_84",
> -                         "SODIMM_78",
> -                         "SODIMM_74",
> -                         "SODIMM_80",
> -                         "SODIMM_82",
> -                         "SODIMM_70",
> -                         "SODIMM_72";
> -};
> -
> -&gpio5 {
> -       gpio-line-names = "SODIMM_131",
> -                         "",
> -                         "SODIMM_91",
> -                         "SODIMM_16",
> -                         "SODIMM_15",
> -                         "SODIMM_208",
> -                         "SODIMM_137",
> -                         "SODIMM_139",
> -                         "SODIMM_141",
> -                         "SODIMM_143",
> -                         "SODIMM_196",
> -                         "SODIMM_200",
> -                         "SODIMM_198",
> -                         "SODIMM_202",
> -                         "",
> -                         "",
> -                         "SODIMM_55",
> -                         "SODIMM_53",
> -                         "SODIMM_95",
> -                         "SODIMM_93",
> -                         "SODIMM_14",
> -                         "SODIMM_12",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_210",
> -                         "SODIMM_212",
> -                         "SODIMM_151",
> -                         "SODIMM_153";
> -
> -       ctrl-sleep-moci-hog {
> -               gpio-hog;
> -               /* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
> -               gpios = <1 GPIO_ACTIVE_HIGH>;
> -               line-name = "CTRL_SLEEP_MOCI#";
> -               output-high;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
> -       };
> -};
> -
> -/* On-module I2C */
> -&i2c1 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c1>;
> -       pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -       scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       status = "okay";
> -
> -       pca9450: pmic@25 {
> -               compatible = "nxp,pca9450a";
> -               interrupt-parent = <&gpio1>;
> -               /* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> -               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pmic>;
> -               reg = <0x25>;
> -
> -               /*
> -                * The bootloader is expected to switch on the I2C level shifter for the TLA2024 ADC
> -                * behind this PMIC.
> -                */
> -
> -               regulators {
> -                       reg_vdd_soc: BUCK1 {
> -                               nxp,dvs-run-voltage = <850000>;
> -                               nxp,dvs-standby-voltage = <800000>;
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <850000>;
> -                               regulator-min-microvolt = <800000>;
> -                               regulator-name = "On-module +VDD_SOC (BUCK1)";
> -                               regulator-ramp-delay = <3125>;
> -                       };
> -
> -                       reg_vdd_arm: BUCK2 {
> -                               nxp,dvs-run-voltage = <950000>;
> -                               nxp,dvs-standby-voltage = <850000>;
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1050000>;
> -                               regulator-min-microvolt = <805000>;
> -                               regulator-name = "On-module +VDD_ARM (BUCK2)";
> -                               regulator-ramp-delay = <3125>;
> -                       };
> -
> -                       reg_vdd_dram: BUCK3 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1000000>;
> -                               regulator-min-microvolt = <805000>;
> -                               regulator-name = "On-module +VDD_GPU_VPU_DDR (BUCK3)";
> -                       };
> -
> -                       reg_vdd_3v3: BUCK4 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <3300000>;
> -                               regulator-name = "On-module +V3.3 (BUCK4)";
> -                       };
> -
> -                       reg_vdd_1v8: BUCK5 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "PWR_1V8_MOCI (BUCK5)";
> -                       };
> -
> -                       reg_nvcc_dram: BUCK6 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1100000>;
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-name = "On-module +VDD_DDR (BUCK6)";
> -                       };
> -
> -                       reg_nvcc_snvs: LDO1 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "On-module +V1.8_SNVS (LDO1)";
> -                       };
> -
> -                       reg_vdd_snvs: LDO2 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <800000>;
> -                               regulator-min-microvolt = <800000>;
> -                               regulator-name = "On-module +V0.8_SNVS (LDO2)";
> -                       };
> -
> -                       reg_vdda: LDO3 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "On-module +V1.8A (LDO3)";
> -                       };
> -
> -                       reg_vdd_phy: LDO4 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <900000>;
> -                               regulator-min-microvolt = <900000>;
> -                               regulator-name = "On-module +V0.9_MIPI (LDO4)";
> -                       };
> -
> -                       reg_nvcc_sd: LDO5 {
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
> -                       };
> -               };
> -       };
> -
> -       rtc_i2c: rtc@32 {
> -               compatible = "epson,rx8130";
> -               reg = <0x32>;
> -       };
> -
> -       adc@49 {
> -               compatible = "ti,ads1015";
> -               reg = <0x49>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               /* Verdin I2C_1 (ADC_4 - ADC_3) */
> -               channel@0 {
> -                       reg = <0>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_4 - ADC_1) */
> -               channel@1 {
> -                       reg = <1>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_3 - ADC_1) */
> -               channel@2 {
> -                       reg = <2>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_2 - ADC_1) */
> -               channel@3 {
> -                       reg = <3>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_4 */
> -               channel@4 {
> -                       reg = <4>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_3 */
> -               channel@5 {
> -                       reg = <5>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_2 */
> -               channel@6 {
> -                       reg = <6>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_1 */
> -               channel@7 {
> -                       reg = <7>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -       };
> -
> -       eeprom@50 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -};
> -
> -/* Verdin I2C_2_DSI */
> -&i2c2 {
> -       clock-frequency = <10000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       pinctrl-1 = <&pinctrl_i2c2_gpio>;
> -       scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       status = "disabled";
> -};
> -
> -/* Verdin I2C_3_HDMI N/A */
> -
> -/* Verdin I2C_4_CSI */
> -&i2c3 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c3>;
> -       pinctrl-1 = <&pinctrl_i2c3_gpio>;
> -       scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -};
> -
> -/* Verdin I2C_1 */
> -&i2c4 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c4>;
> -       pinctrl-1 = <&pinctrl_i2c4_gpio>;
> -       scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -
> -       gpio_expander_21: gpio-expander@21 {
> -               compatible = "nxp,pcal6416";
> -               #gpio-cells = <2>;
> -               gpio-controller;
> -               reg = <0x21>;
> -               vcc-supply = <&reg_3p3v>;
> -               status = "disabled";
> -       };
> -
> -       lvds_ti_sn65dsi84: bridge@2c {
> -               compatible = "ti,sn65dsi84";
> -               /* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
> -               /* Verdin GPIO_10_DSI (SODIMM 21) */
> -               enable-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_10_dsi>;
> -               reg = <0x2c>;
> -               status = "disabled";
> -       };
> -
> -       /* Current measurement into module VCC */
> -       hwmon: hwmon@40 {
> -               compatible = "ti,ina219";
> -               reg = <0x40>;
> -               shunt-resistor = <10000>;
> -               status = "disabled";
> -       };
> -
> -       hdmi_lontium_lt8912: hdmi@48 {
> -               compatible = "lontium,lt8912b";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_10_dsi>;
> -               reg = <0x48>;
> -               /* Verdin GPIO_9_DSI (LT8912 INT, SODIMM 17, unused) */
> -               /* Verdin GPIO_10_DSI (SODIMM 21) */
> -               reset-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -
> -       atmel_mxt_ts: touch@4a {
> -               compatible = "atmel,maxtouch";
> -               /*
> -                * Verdin GPIO_9_DSI
> -                * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI84 IRQ albeit currently unused)
> -                */
> -               interrupt-parent = <&gpio3>;
> -               interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_9_dsi>, <&pinctrl_i2s_2_bclk_touch_reset>;
> -               reg = <0x4a>;
> -               /* Verdin I2S_2_BCLK (TOUCH_RESET#, SODIMM 42) */
> -               reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -
> -       /* Temperature sensor on carrier board */
> -       hwmon_temp: sensor@4f {
> -               compatible = "ti,tmp75c";
> -               reg = <0x4f>;
> -               status = "disabled";
> -       };
> -
> -       /* EEPROM on display adapter (MIPI DSI Display Adapter) */
> -       eeprom_display_adapter: eeprom@50 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -               status = "disabled";
> -       };
> -
> -       /* EEPROM on carrier board */
> -       eeprom_carrier_board: eeprom@57 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x57>;
> -               status = "disabled";
> -       };
> -};
> -
> -/* Verdin PCIE_1 */
> -&pcie0 {
> -       assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
> -                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
> -       assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
> -                                <&clk IMX8MM_SYS_PLL2_250M>;
> -       assigned-clock-rates = <10000000>, <250000000>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pcie0>;
> -       /* PCIE_1_RESET# (SODIMM 244) */
> -       reset-gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
> -};
> -
> -&pcie_phy {
> -       clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> -       clock-names = "ref";
> -       fsl,clkreq-unsupported;
> -       fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> -       fsl,tx-deemph-gen1 = <0x2d>;
> -       fsl,tx-deemph-gen2 = <0xf>;
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&pwm1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_1>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* Verdin PWM_1 */
> -&pwm2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_2>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* Verdin PWM_2 */
> -&pwm3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_3>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* Verdin I2S_1 */
> -&sai2 {
> -       #sound-dai-cells = <0>;
> -       assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> -       assigned-clock-rates = <24576000>;
> -       assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_sai2>;
> -};
> -
> -&snvs_pwrkey {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_3, used as the Linux console */
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -};
> -
> -/* Verdin UART_1 */
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart2>;
> -       uart-has-rtscts;
> -};
> -
> -/* Verdin UART_2 */
> -&uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart3>;
> -       uart-has-rtscts;
> -};
> -
> -/*
> - * Verdin UART_4
> - * Resource allocated to M4 by default, must not be accessed from Cortex-A35 or you get an OOPS
> - */
> -&uart4 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart4>;
> -};
> -
> -/* Verdin USB_1 */
> -&usbotg1 {
> -       adp-disable;
> -       dr_mode = "otg";
> -       hnp-disable;
> -       samsung,picophy-dc-vol-level-adjust = <7>;
> -       samsung,picophy-pre-emp-curr-control = <3>;
> -       srp-disable;
> -       vbus-supply = <&reg_usb_otg1_vbus>;
> -};
> -
> -/* Verdin USB_2 */
> -&usbotg2 {
> -       dr_mode = "host";
> -       samsung,picophy-dc-vol-level-adjust = <7>;
> -       samsung,picophy-pre-emp-curr-control = <3>;
> -       vbus-supply = <&reg_usb_otg2_vbus>;
> -};
> -
> -&usbphynop1 {
> -       vcc-supply = <&reg_vdd_3v3>;
> -};
> -
> -&usbphynop2 {
> -       power-domains = <&pgc_otg2>;
> -       vcc-supply = <&reg_vdd_3v3>;
> -};
> -
> -/* On-module eMMC */
> -&usdhc1 {
> -       bus-width = <8>;
> -       keep-power-in-suspend;
> -       non-removable;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -       pinctrl-0 = <&pinctrl_usdhc1>;
> -       pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> -       pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> -       status = "okay";
> -};
> -
> -/* Verdin SD_1 */
> -&usdhc2 {
> -       bus-width = <4>;
> -       cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> -       disable-wp;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> -       pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
> -       vmmc-supply = <&reg_usdhc2_vmmc>;
> -};
> -
> -&wdog1 {
> -       fsl,ext-reset-output;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_wdog>;
> -       status = "okay";
> -};
> -
> -&iomuxc {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
> -                   <&pinctrl_gpio3>, <&pinctrl_gpio4>,
> -                   <&pinctrl_gpio7>, <&pinctrl_gpio8>,
> -                   <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
> -                   <&pinctrl_pmic_tpm_ena>;
> -
> -       pinctrl_can1_int: can1intgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6              0x146>; /* CAN_1_SPI_INT#_1.8V */
> -       };
> -
> -       pinctrl_can2_int: can2intgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7              0x106>; /* CAN_2_SPI_INT#_1.8V, unused */
> -       };
> -
> -       pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1                0x106>; /* SODIMM 256 */
> -       };
> -
> -       pinctrl_ecspi2: ecspi2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO           0x6>,   /* SODIMM 198 */
> -                       <MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI           0x6>,   /* SODIMM 200 */
> -                       <MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK           0x6>,   /* SODIMM 196 */
> -                       <MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13             0x6>;   /* SODIMM 202 */
> -       };
> -
> -       pinctrl_ecspi3: ecspi3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5              0x146>, /* CAN_2_SPI_CS#_1.8V */
> -                       <MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK             0x6>,   /* CAN_SPI_SCK_1.8V */
> -                       <MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI             0x6>,   /* CAN_SPI_MOSI_1.8V */
> -                       <MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO             0x6>,   /* CAN_SPI_MISO_1.8V */
> -                       <MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25              0x6>;   /* CAN_1_SPI_CS_1.8V# */
> -       };
> -
> -       pinctrl_fec1: fec1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                0x3>,
> -                       <MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO              0x3>,
> -                       <MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL    0x91>,
> -                       <MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0          0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1          0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2          0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3          0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC          0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL    0x1f>,
> -                       <MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10             0x146>;
> -       };
> -
> -       pinctrl_fec1_sleep: fec1-sleepgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                0x3>,
> -                       <MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO              0x3>,
> -                       <MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC          0x91>,
> -                       <MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL    0x91>,
> -                       <MX8MM_IOMUXC_ENET_TD0_GPIO1_IO21               0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD1_GPIO1_IO20               0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD2_GPIO1_IO19               0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TD3_GPIO1_IO18               0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23               0x1f>,
> -                       <MX8MM_IOMUXC_ENET_TX_CTL_GPIO1_IO22            0x1f>,
> -                       <MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10             0x106>;
> -       };
> -
> -       pinctrl_flexspi0: flexspi0grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK              0x106>, /* SODIMM 52 */
> -                       <MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B           0x106>, /* SODIMM 54 */
> -                       <MX8MM_IOMUXC_NAND_CE1_B_QSPI_A_SS1_B           0x106>, /* SODIMM 64 */
> -                       <MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0          0x106>, /* SODIMM 56 */
> -                       <MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1          0x106>, /* SODIMM 58 */
> -                       <MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2          0x106>, /* SODIMM 60 */
> -                       <MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3          0x106>, /* SODIMM 62 */
> -                       <MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS               0x106>; /* SODIMM 66 */
> -       };
> -
> -       pinctrl_gpio1: gpio1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4              0x106>; /* SODIMM 206 */
> -       };
> -
> -       pinctrl_gpio2: gpio2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5           0x106>; /* SODIMM 208 */
> -       };
> -
> -       pinctrl_gpio3: gpio3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_UART3_RXD_GPIO5_IO26              0x106>; /* SODIMM 210 */
> -       };
> -
> -       pinctrl_gpio4: gpio4grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_UART3_TXD_GPIO5_IO27              0x106>; /* SODIMM 212 */
> -       };
> -
> -       pinctrl_gpio5: gpio5grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0              0x106>; /* SODIMM 216 */
> -       };
> -
> -       pinctrl_gpio6: gpio6grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11             0x106>; /* SODIMM 218 */
> -       };
> -
> -       pinctrl_gpio7: gpio7grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8              0x106>; /* SODIMM 220 */
> -       };
> -
> -       pinctrl_gpio8: gpio8grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9              0x106>; /* SODIMM 222 */
> -       };
> -
> -       /* Verdin GPIO_9_DSI (pulled-up as active-low) */
> -       pinctrl_gpio_9_dsi: gpio9dsigrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15              0x146>; /* SODIMM 17 */
> -       };
> -
> -       /* Verdin GPIO_10_DSI (pulled-up as active-low) */
> -       pinctrl_gpio_10_dsi: gpio10dsigrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_CE2_B_GPIO3_IO3              0x146>; /* SODIMM 21 */
> -       };
> -
> -       pinctrl_gpio_hog1: gpiohog1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20              0x106>, /* SODIMM 88 */
> -                       <MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1                0x106>, /* SODIMM 90 */
> -                       <MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2               0x106>, /* SODIMM 92 */
> -                       <MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3               0x106>, /* SODIMM 94 */
> -                       <MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4               0x106>, /* SODIMM 96 */
> -                       <MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5               0x106>, /* SODIMM 100 */
> -                       <MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0               0x106>, /* SODIMM 102 */
> -                       <MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11               0x106>, /* SODIMM 104 */
> -                       <MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12              0x106>, /* SODIMM 106 */
> -                       <MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13              0x106>, /* SODIMM 108 */
> -                       <MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14              0x106>, /* SODIMM 112 */
> -                       <MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15              0x106>, /* SODIMM 114 */
> -                       <MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16              0x106>, /* SODIMM 116 */
> -                       <MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18              0x106>, /* SODIMM 118 */
> -                       <MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10              0x106>; /* SODIMM 120 */
> -       };
> -
> -       pinctrl_gpio_hog2: gpiohog2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2               0x106>; /* SODIMM 91 */
> -       };
> -
> -       pinctrl_gpio_hog3: gpiohog3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13             0x146>, /* SODIMM 157 */
> -                       <MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15             0x146>; /* SODIMM 187 */
> -       };
> -
> -       pinctrl_gpio_keys: gpiokeysgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28              0x146>; /* SODIMM 252 */
> -       };
> -
> -       /* On-module I2C */
> -       pinctrl_i2c1: i2c1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL                 0x40000146>,    /* PMIC_I2C_SCL */
> -                       <MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA                 0x40000146>;    /* PMIC_I2C_SDA */
> -       };
> -
> -       pinctrl_i2c1_gpio: i2c1gpiogrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14               0x146>, /* PMIC_I2C_SCL */
> -                       <MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15               0x146>; /* PMIC_I2C_SDA */
> -       };
> -
> -       /* Verdin I2C_4_CSI */
> -       pinctrl_i2c2: i2c2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL                 0x40000146>,    /* SODIMM 55 */
> -                       <MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA                 0x40000146>;    /* SODIMM 53 */
> -       };
> -
> -       pinctrl_i2c2_gpio: i2c2gpiogrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16               0x146>, /* SODIMM 55 */
> -                       <MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17               0x146>; /* SODIMM 53 */
> -       };
> -
> -       /* Verdin I2C_2_DSI */
> -       pinctrl_i2c3: i2c3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL                 0x40000146>,    /* SODIMM 95 */
> -                       <MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA                 0x40000146>;    /* SODIMM 93 */
> -       };
> -
> -       pinctrl_i2c3_gpio: i2c3gpiogrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18               0x146>, /* SODIMM 95 */
> -                       <MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19               0x146>; /* SODIMM 93 */
> -       };
> -
> -       /* Verdin I2C_1 */
> -       pinctrl_i2c4: i2c4grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL                 0x40000146>,    /* SODIMM 14 */
> -                       <MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA                 0x40000146>;    /* SODIMM 12 */
> -       };
> -
> -       pinctrl_i2c4_gpio: i2c4gpiogrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20               0x146>, /* SODIMM 14 */
> -                       <MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21               0x146>; /* SODIMM 12 */
> -       };
> -
> -       /* Verdin I2S_2_BCLK (TOUCH_RESET#) */
> -       pinctrl_i2s_2_bclk_touch_reset: i2s2bclktouchresetgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23              0x6>;   /* SODIMM 42 */
> -       };
> -
> -       /* Verdin I2S_2_D_OUT shared with SAI5 */
> -       pinctrl_i2s_2_d_out_dsi_1_bkl_en: i2s2doutdsi1bklengrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24              0x6>;   /* SODIMM 46 */
> -       };
> -
> -       pinctrl_pcie0: pcie0grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19              0x6>,   /* SODIMM 244 */
> -                       /* PMIC_EN_PCIe_CLK, unused */
> -                       <MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19            0x6>;
> -       };
> -
> -       pinctrl_pmic: pmicirqgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3              0x141>; /* PMIC_INT# */
> -       };
> -
> -       /* Verdin PWM_3_DSI shared with GPIO1_IO1 */
> -       pinctrl_pwm_1: pwm1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT               0x6>;   /* SODIMM 19 */
> -       };
> -
> -       pinctrl_pwm_2: pwm2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT                 0x6>;   /* SODIMM 15 */
> -       };
> -
> -       pinctrl_pwm_3: pwm3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT                 0x6>;   /* SODIMM 16 */
> -       };
> -
> -       /* Verdin PWM_3_DSI (pulled-down as active-high) shared with PWM1_OUT */
> -       pinctrl_pwm_3_dsi_hpd_gpio: pwm3dsihpdgpiogrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1              0x106>; /* SODIMM 19 */
> -       };
> -
> -       pinctrl_reg_eth: regethgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD2_WP_GPIO2_IO20                 0x146>; /* PMIC_EN_ETH */
> -       };
> -
> -       pinctrl_reg_usb1_en: regusb1engrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12             0x106>; /* SODIMM 155 */
> -       };
> -
> -       pinctrl_reg_usb2_en: regusb2engrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14             0x106>; /* SODIMM 185 */
> -       };
> -
> -       pinctrl_sai2: sai2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK               0x6>,   /* SODIMM 38 */
> -                       <MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK             0x6>,   /* SODIMM 30 */
> -                       <MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC            0x6>,   /* SODIMM 32 */
> -                       <MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0           0x6>,   /* SODIMM 36 */
> -                       <MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0           0x6>;   /* SODIMM 34 */
> -       };
> -
> -       pinctrl_sai5: sai5grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0           0x6>,   /* SODIMM 48 */
> -                       <MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC            0x6>,   /* SODIMM 44 */
> -                       <MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK            0x6>,   /* SODIMM 42 */
> -                       <MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0           0x6>;   /* SODIMM 46 */
> -       };
> -
> -       /* control signal for optional ATTPM20P or SE050 */
> -       pinctrl_pmic_tpm_ena: pmictpmenagrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19              0x106>; /* PMIC_TPM_ENA */
> -       };
> -
> -       pinctrl_tsp: tspgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6               0x6>,   /* SODIMM 148 */
> -                       <MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7               0x6>,   /* SODIMM 152 */
> -                       <MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8               0x6>,   /* SODIMM 154 */
> -                       <MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9               0x146>, /* SODIMM 174 */
> -                       <MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17              0x6>;   /* SODIMM 150 */
> -       };
> -
> -       pinctrl_uart1: uart1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX             0x146>, /* SODIMM 147 */
> -                       <MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX            0x146>; /* SODIMM 149 */
> -       };
> -
> -       pinctrl_uart2: uart2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B          0x146>, /* SODIMM 133 */
> -                       <MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B          0x146>, /* SODIMM 135 */
> -                       <MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX             0x146>, /* SODIMM 131 */
> -                       <MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX            0x146>; /* SODIMM 129 */
> -       };
> -
> -       pinctrl_uart3: uart3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B       0x146>, /* SODIMM 141 */
> -                       <MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX          0x146>, /* SODIMM 139 */
> -                       <MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX          0x146>, /* SODIMM 137 */
> -                       <MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B        0x146>; /* SODIMM 143 */
> -       };
> -
> -       pinctrl_uart4: uart4grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX            0x146>, /* SODIMM 151 */
> -                       <MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX            0x146>; /* SODIMM 153 */
> -       };
> -
> -       pinctrl_usdhc1: usdhc1grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                0x190>,
> -                       <MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7            0x1d0>,
> -                       <MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B        0x1d1>,
> -                       <MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE          0x190>;
> -       };
> -
> -       pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                0x194>,
> -                       <MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7            0x1d4>,
> -                       <MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B        0x1d1>,
> -                       <MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE          0x194>;
> -       };
> -
> -       pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                0x196>,
> -                       <MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7            0x1d6>,
> -                       <MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B        0x1d1>,
> -                       <MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE          0x196>;
> -       };
> -
> -       pinctrl_usdhc2_cd: usdhc2cdgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12               0x6>;   /* SODIMM 84 */
> -       };
> -
> -       pinctrl_usdhc2_cd_sleep: usdhc2cdslpgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12               0x0>;   /* SODIMM 84 */
> -       };
> -
> -       pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5                0x6>;   /* SODIMM 76 */
> -       };
> -
> -       /*
> -        * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
> -        * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
> -        */
> -       pinctrl_usdhc2: usdhc2grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,
> -                       <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x90>,  /* SODIMM 78 */
> -                       <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x90>,  /* SODIMM 74 */
> -                       <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x90>,  /* SODIMM 80 */
> -                       <MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1            0x90>,  /* SODIMM 82 */
> -                       <MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2            0x90>,  /* SODIMM 70 */
> -                       <MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3            0x90>;  /* SODIMM 72 */
> -       };
> -
> -       pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,
> -                       <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x94>,
> -                       <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x94>,
> -                       <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x94>,
> -                       <MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1            0x94>,
> -                       <MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2            0x94>,
> -                       <MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3            0x94>;
> -       };
> -
> -       pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,
> -                       <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x96>,
> -                       <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x96>,
> -                       <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x96>,
> -                       <MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1            0x96>,
> -                       <MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2            0x96>,
> -                       <MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3            0x96>;
> -       };
> -
> -       /* Avoid backfeeding with removed card power */
> -       pinctrl_usdhc2_sleep: usdhc2slpgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x0>,
> -                       <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x0>,
> -                       <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x0>,
> -                       <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x0>,
> -                       <MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1            0x0>,
> -                       <MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2            0x0>,
> -                       <MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3            0x0>;
> -       };
> -
> -       /*
> -        * On-module Wi-Fi/BT or type specific SDHC interface
> -        * (e.g. on X52 extension slot of Verdin Development Board)
> -        */
> -       pinctrl_usdhc3: usdhc3grp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0          0x150>,
> -                       <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1          0x150>,
> -                       <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2          0x150>,
> -                       <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3          0x150>,
> -                       <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK              0x150>,
> -                       <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD              0x150>;
> -       };
> -
> -       pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0          0x154>,
> -                       <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1          0x154>,
> -                       <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2          0x154>,
> -                       <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3          0x154>,
> -                       <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK              0x154>,
> -                       <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD              0x154>;
> -       };
> -
> -       pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0          0x156>,
> -                       <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1          0x156>,
> -                       <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2          0x156>,
> -                       <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3          0x156>,
> -                       <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK              0x156>,
> -                       <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD              0x156>;
> -       };
> -
> -       pinctrl_wdog: wdoggrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B           0x166>; /* PMIC_WDI */
> -       };
> -
> -       pinctrl_wifi_ctrl: wifictrlgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16           0x46>,  /* WIFI_WKUP_BT */
> -                       <MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9               0x146>, /* WIFI_W_WKUP_HOST */
> -                       <MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20               0x46>;  /* WIFI_WKUP_WLAN */
> -       };
> -
> -       pinctrl_wifi_i2s: bti2sgrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI1_RXD4_SAI6_TX_BCLK            0x6>,   /* WIFI_TX_BCLK */
> -                       <MX8MM_IOMUXC_SAI1_RXD5_SAI6_TX_DATA0           0x6>,   /* WIFI_TX_DATA0 */
> -                       <MX8MM_IOMUXC_SAI1_RXD6_SAI6_TX_SYNC            0x6>,   /* WIFI_TX_SYNC */
> -                       <MX8MM_IOMUXC_SAI1_TXD5_SAI6_RX_DATA0           0x6>;   /* WIFI_RX_DATA0 */
> -       };
> -
> -       pinctrl_wifi_pwr_en: wifipwrengrp {
> -               fsl,pins =
> -                       <MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25              0x6>;   /* PMIC_EN_WIFI */
> -       };
> -};
> diff --git a/arch/arm/dts/imx8mp-verdin-dev.dtsi b/arch/arm/dts/imx8mp-verdin-dev.dtsi
> deleted file mode 100644
> index bdfdd4c782f..00000000000
> --- a/arch/arm/dts/imx8mp-verdin-dev.dtsi
> +++ /dev/null
> @@ -1,165 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/ {
> -       /* TODO: Audio Codec */
> -
> -       reg_eth2phy: regulator-eth2phy {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               gpio = <&gpio_expander_21 4 GPIO_ACTIVE_HIGH>; /* ETH_PWR_EN */
> -               off-on-delay-us = <500000>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_ETH";
> -               startup-delay-us = <200000>;
> -               vin-supply = <&reg_3p3v>;
> -       };
> -};
> -
> -&backlight {
> -       power-supply = <&reg_3p3v>;
> -};
> -
> -/* Verdin SPI_1 */
> -&ecspi1 {
> -       status = "okay";
> -};
> -
> -/* EEPROM on display adapter boards */
> -&eeprom_display_adapter {
> -       status = "okay";
> -};
> -
> -/* EEPROM on Verdin Development board */
> -&eeprom_carrier_board {
> -       status = "okay";
> -};
> -
> -&eqos {
> -       status = "okay";
> -};
> -
> -&fec {
> -       phy-supply = <&reg_eth2phy>;
> -       status = "okay";
> -};
> -
> -&flexcan1 {
> -       status = "okay";
> -};
> -
> -&flexcan2 {
> -       status = "okay";
> -};
> -
> -/* Verdin QSPI_1 */
> -&flexspi {
> -       status = "okay";
> -};
> -
> -&gpio_expander_21 {
> -       status = "okay";
> -       vcc-supply = <&reg_1p8v>;
> -};
> -
> -/* Current measurement into module VCC */
> -&hwmon {
> -       status = "okay";
> -};
> -
> -&hwmon_temp {
> -       vs-supply = <&reg_1p8v>;
> -       status = "okay";
> -};
> -
> -/* Verdin I2C_2_DSI */
> -&i2c2 {
> -       status = "okay";
> -};
> -
> -&i2c3 {
> -       status = "okay";
> -};
> -
> -/* Verdin I2C_1 */
> -&i2c4 {
> -       status = "okay";
> -
> -       /* TODO: Audio Codec */
> -};
> -
> -/* Verdin PCIE_1 */
> -&pcie {
> -       status = "okay";
> -};
> -
> -&pcie_phy {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_1 */
> -&pwm1 {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_2 */
> -&pwm2 {
> -       status = "okay";
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&pwm3 {
> -       status = "okay";
> -};
> -
> -&reg_usdhc2_vmmc {
> -       vin-supply = <&reg_3p3v>;
> -};
> -
> -/* TODO: Verdin I2C_1 with Audio Codec */
> -
> -/* Verdin UART_1, connector X50 through RS485 transceiver */
> -&uart1 {
> -       linux,rs485-enabled-at-boot-time;
> -       rs485-rts-active-low;
> -       rs485-rx-during-tx;
> -       status = "okay";
> -};
> -
> -/* Verdin UART_2 */
> -&uart2 {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_3, used as the Linux Console */
> -&uart3 {
> -       status = "okay";
> -};
> -
> -/* Verdin USB_1 */
> -&usb3_0 {
> -       status = "okay";
> -};
> -
> -&usb3_phy0 {
> -       status = "okay";
> -};
> -
> -/* Verdin USB_2 */
> -&usb3_1 {
> -       fsl,permanently-attached;
> -       status = "okay";
> -};
> -
> -&usb3_phy1 {
> -       status = "okay";
> -};
> -
> -/* Limit frequency on dev board due to long traces and bad signal integrity */
> -&usdhc2 {
> -       max-frequency = <100000000>;
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev.dts b/arch/arm/dts/imx8mp-verdin-wifi-dev.dts
> deleted file mode 100644
> index c1713c28cdc..00000000000
> --- a/arch/arm/dts/imx8mp-verdin-wifi-dev.dts
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/dts-v1/;
> -
> -#include "imx8mp-verdin.dtsi"
> -#include "imx8mp-verdin-wifi.dtsi"
> -#include "imx8mp-verdin-dev.dtsi"
> -
> -/ {
> -       model = "Toradex Verdin iMX8M Plus WB on Verdin Development Board";
> -       compatible = "toradex,verdin-imx8mp-wifi-dev",
> -                    "toradex,verdin-imx8mp-wifi",
> -                    "toradex,verdin-imx8mp",
> -                    "fsl,imx8mp";
> -};
> diff --git a/arch/arm/dts/imx8mp-verdin-wifi.dtsi b/arch/arm/dts/imx8mp-verdin-wifi.dtsi
> deleted file mode 100644
> index ef94f9a57e2..00000000000
> --- a/arch/arm/dts/imx8mp-verdin-wifi.dtsi
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -/ {
> -       reg_wifi_en: regulator-wifi-en {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_wifi_pwr_en>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "PDn_AW-CM276NF";
> -               startup-delay-us = <2000>;
> -       };
> -};
> -
> -&gpio5 {
> -       gpio-line-names = "SODIMM_42",
> -                         "SODIMM_46",
> -                         "SODIMM_187",
> -                         "SODIMM_20",
> -                         "SODIMM_22",
> -                         "SODIMM_15",
> -                         "SODIMM_196",
> -                         "SODIMM_200",
> -                         "SODIMM_198",
> -                         "SODIMM_202",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_55",
> -                         "SODIMM_53",
> -                         "SODIMM_95",
> -                         "SODIMM_93",
> -                         "SODIMM_14",
> -                         "SODIMM_12",
> -                         "SODIMM_129",
> -                         "SODIMM_131",
> -                         "SODIMM_137",
> -                         "SODIMM_139",
> -                         "SODIMM_147",
> -                         "SODIMM_149",
> -                         "SODIMM_151",
> -                         "SODIMM_153";
> -};
> -
> -&iomuxc {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
> -                   <&pinctrl_gpio3>, <&pinctrl_gpio4>,
> -                   <&pinctrl_gpio7>, <&pinctrl_gpio8>,
> -                   <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>, <&pinctrl_gpio_hog4>,
> -                   <&pinctrl_hdmi_hog>;
> -};
> -
> -/* On-module Bluetooth */
> -&uart4 {
> -       uart-has-rtscts;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_bt_uart>;
> -       status = "okay";
> -
> -       bluetooth {
> -               compatible = "mrvl,88w8997";
> -               max-speed = <921600>;
> -       };
> -};
> -
> -/* On-module Wi-Fi */
> -&usdhc1 {
> -       bus-width = <4>;
> -       keep-power-in-suspend;
> -       max-frequency = <100000000>;
> -       non-removable;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -       pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wifi_ctrl>;
> -       pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wifi_ctrl>;
> -       pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wifi_ctrl>;
> -       vmmc-supply = <&reg_wifi_en>;
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/imx8mp-verdin.dtsi b/arch/arm/dts/imx8mp-verdin.dtsi
> deleted file mode 100644
> index e9e4fcb562f..00000000000
> --- a/arch/arm/dts/imx8mp-verdin.dtsi
> +++ /dev/null
> @@ -1,1438 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> -/*
> - * Copyright 2022 Toradex
> - */
> -
> -#include <dt-bindings/phy/phy-imx8-pcie.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include "imx8mp.dtsi"
> -
> -/ {
> -       chosen {
> -               stdout-path = &uart3;
> -       };
> -
> -       aliases {
> -               /* Ethernet aliases to ensure correct MAC addresses */
> -               ethernet0 = &eqos;
> -               ethernet1 = &fec;
> -               rtc0 = &rtc_i2c;
> -               rtc1 = &snvs_rtc;
> -       };
> -
> -       backlight: backlight {
> -               compatible = "pwm-backlight";
> -               brightness-levels = <0 45 63 88 119 158 203 255>;
> -               default-brightness-level = <4>;
> -               /* Verdin I2S_2_D_OUT (DSI_1_BKL_EN/DSI_1_BKL_EN_LVDS, SODIMM 46) */
> -               enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_i2s_2_d_out_dsi_1_bkl_en>;
> -               power-supply = <&reg_3p3v>;
> -               /* Verdin PWM_3_DSI/PWM_3_DSI_LVDS (SODIMM 19) */
> -               pwms = <&pwm3 0 6666667 PWM_POLARITY_INVERTED>;
> -               status = "disabled";
> -       };
> -
> -       backlight_mezzanine: backlight-mezzanine {
> -               compatible = "pwm-backlight";
> -               brightness-levels = <0 45 63 88 119 158 203 255>;
> -               default-brightness-level = <4>;
> -               /* Verdin GPIO 4 (SODIMM 212) */
> -               enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -               /* Verdin PWM_2 (SODIMM 16) */
> -               pwms = <&pwm2 0 6666667 PWM_POLARITY_INVERTED>;
> -               status = "disabled";
> -       };
> -
> -       gpio-keys {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_keys>;
> -
> -               key-wakeup {
> -                       debounce-interval = <10>;
> -                       /* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
> -                       gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
> -                       label = "Wake-Up";
> -                       linux,code = <KEY_WAKEUP>;
> -                       wakeup-source;
> -               };
> -       };
> -
> -       /* Carrier Board Supplies */
> -       reg_1p8v: regulator-1p8v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <1800000>;
> -               regulator-min-microvolt = <1800000>;
> -               regulator-name = "+V1.8_SW";
> -       };
> -
> -       reg_3p3v: regulator-3p3v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_SW";
> -       };
> -
> -       reg_5p0v: regulator-5p0v {
> -               compatible = "regulator-fixed";
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "+V5_SW";
> -       };
> -
> -       /* Non PMIC On-module Supplies */
> -       reg_module_eth1phy: regulator-module-eth1phy {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>; /* PMIC_EN_ETH */
> -               off-on-delay-us = <500000>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_eth>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "On-module +V3.3_ETH";
> -               startup-delay-us = <200000>;
> -               vin-supply = <&reg_vdd_3v3>;
> -       };
> -
> -       reg_usb1_vbus: regulator-usb1-vbus {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin USB_1_EN (SODIMM 155) */
> -               gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_usb1_vbus>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "USB_1_EN";
> -       };
> -
> -       reg_usb2_vbus: regulator-usb2-vbus {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin USB_2_EN (SODIMM 185) */
> -               gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_usb2_vbus>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-min-microvolt = <5000000>;
> -               regulator-name = "USB_2_EN";
> -       };
> -
> -       reg_usdhc2_vmmc: regulator-usdhc2 {
> -               compatible = "regulator-fixed";
> -               enable-active-high;
> -               /* Verdin SD_1_PWR_EN (SODIMM 76) */
> -               gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> -               off-on-delay-us = <100000>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
> -               regulator-max-microvolt = <3300000>;
> -               regulator-min-microvolt = <3300000>;
> -               regulator-name = "+V3.3_SD";
> -               startup-delay-us = <2000>;
> -       };
> -
> -       reserved-memory {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -               ranges;
> -
> -               /* Use the kernel configuration settings instead */
> -               /delete-node/ linux,cma;
> -       };
> -};
> -
> -&A53_0 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_1 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_2 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&A53_3 {
> -       cpu-supply = <&reg_vdd_arm>;
> -};
> -
> -&cpu_alert0 {
> -       temperature = <95000>;
> -};
> -
> -&cpu_crit0 {
> -       temperature = <105000>;
> -};
> -
> -/* Verdin SPI_1 */
> -&ecspi1 {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -       cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi1>;
> -};
> -
> -/* Verdin ETH_1 (On-module PHY) */
> -&eqos {
> -       phy-handle = <&ethphy0>;
> -       phy-mode = "rgmii-id";
> -       phy-supply = <&reg_module_eth1phy>;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_eqos>;
> -       snps,force_thresh_dma_mode;
> -       snps,mtl-rx-config = <&mtl_rx_setup>;
> -       snps,mtl-tx-config = <&mtl_tx_setup>;
> -
> -       mdio {
> -               compatible = "snps,dwmac-mdio";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               ethphy0: ethernet-phy@7 {
> -                       compatible = "ethernet-phy-ieee802.3-c22";
> -                       eee-broken-100tx;
> -                       eee-broken-1000t;
> -                       interrupt-parent = <&gpio1>;
> -                       interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -                       micrel,led-mode = <0>;
> -                       reg = <7>;
> -               };
> -       };
> -
> -       mtl_rx_setup: rx-queues-config {
> -               snps,rx-queues-to-use = <5>;
> -               snps,rx-sched-sp;
> -
> -               queue0 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x1>;
> -                       snps,map-to-dma-channel = <0>;
> -               };
> -
> -               queue1 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x2>;
> -                       snps,map-to-dma-channel = <1>;
> -               };
> -
> -               queue2 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x4>;
> -                       snps,map-to-dma-channel = <2>;
> -               };
> -
> -               queue3 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x8>;
> -                       snps,map-to-dma-channel = <3>;
> -               };
> -
> -               queue4 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0xf0>;
> -                       snps,map-to-dma-channel = <4>;
> -               };
> -       };
> -
> -       mtl_tx_setup: tx-queues-config {
> -               snps,tx-queues-to-use = <5>;
> -               snps,tx-sched-sp;
> -
> -               queue0 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x1>;
> -               };
> -
> -               queue1 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x2>;
> -               };
> -
> -               queue2 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x4>;
> -               };
> -
> -               queue3 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0x8>;
> -               };
> -
> -               queue4 {
> -                       snps,dcb-algorithm;
> -                       snps,priority = <0xf0>;
> -               };
> -       };
> -};
> -
> -/* Verdin ETH_2_RGMII */
> -&fec {
> -       fsl,magic-packet;
> -       phy-handle = <&ethphy1>;
> -       phy-mode = "rgmii-id";
> -       pinctrl-names = "default", "sleep";
> -       pinctrl-0 = <&pinctrl_fec>;
> -       pinctrl-1 = <&pinctrl_fec_sleep>;
> -
> -       mdio {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               ethphy1: ethernet-phy@7 {
> -                       compatible = "ethernet-phy-ieee802.3-c22";
> -                       interrupt-parent = <&gpio4>;
> -                       interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
> -                       micrel,led-mode = <0>;
> -                       reg = <7>;
> -               };
> -       };
> -};
> -
> -/* Verdin CAN_1 */
> -&flexcan1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_flexcan1>;
> -       status = "disabled";
> -};
> -
> -/* Verdin CAN_2 */
> -&flexcan2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_flexcan2>;
> -       status = "disabled";
> -};
> -
> -/* Verdin QSPI_1 */
> -&flexspi {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_flexspi0>;
> -};
> -
> -&gpio1 {
> -       gpio-line-names = "SODIMM_206",
> -                         "SODIMM_208",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_210",
> -                         "SODIMM_212",
> -                         "SODIMM_216",
> -                         "SODIMM_218",
> -                         "",
> -                         "",
> -                         "SODIMM_16",
> -                         "SODIMM_155",
> -                         "SODIMM_157",
> -                         "SODIMM_185",
> -                         "SODIMM_91";
> -};
> -
> -&gpio2 {
> -       gpio-line-names = "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_143",
> -                         "SODIMM_141",
> -                         "",
> -                         "",
> -                         "SODIMM_161",
> -                         "",
> -                         "SODIMM_84",
> -                         "SODIMM_78",
> -                         "SODIMM_74",
> -                         "SODIMM_80",
> -                         "SODIMM_82",
> -                         "SODIMM_70",
> -                         "SODIMM_72";
> -};
> -
> -&gpio3 {
> -       gpio-line-names = "SODIMM_52",
> -                         "SODIMM_54",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_56",
> -                         "SODIMM_58",
> -                         "SODIMM_60",
> -                         "SODIMM_62",
> -                         "",
> -                         "",
> -                         "",
> -                         "",
> -                         "SODIMM_66",
> -                         "",
> -                         "SODIMM_64",
> -                         "",
> -                         "",
> -                         "SODIMM_34",
> -                         "SODIMM_19",
> -                         "",
> -                         "SODIMM_32",
> -                         "",
> -                         "",
> -                         "SODIMM_30",
> -                         "SODIMM_59",
> -                         "SODIMM_57",
> -                         "SODIMM_63",
> -                         "SODIMM_61";
> -};
> -
> -&gpio4 {
> -       gpio-line-names = "SODIMM_252",
> -                         "SODIMM_222",
> -                         "SODIMM_36",
> -                         "SODIMM_220",
> -                         "SODIMM_193",
> -                         "SODIMM_191",
> -                         "SODIMM_201",
> -                         "SODIMM_203",
> -                         "SODIMM_205",
> -                         "SODIMM_207",
> -                         "SODIMM_199",
> -                         "SODIMM_197",
> -                         "SODIMM_221",
> -                         "SODIMM_219",
> -                         "SODIMM_217",
> -                         "SODIMM_215",
> -                         "SODIMM_211",
> -                         "SODIMM_213",
> -                         "SODIMM_189",
> -                         "SODIMM_244",
> -                         "SODIMM_38",
> -                         "",
> -                         "SODIMM_76",
> -                         "SODIMM_135",
> -                         "SODIMM_133",
> -                         "SODIMM_17",
> -                         "SODIMM_24",
> -                         "SODIMM_26",
> -                         "SODIMM_21",
> -                         "SODIMM_256",
> -                         "SODIMM_48",
> -                         "SODIMM_44";
> -
> -       ctrl-sleep-moci-hog {
> -               gpio-hog;
> -               /* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
> -               gpios = <29 GPIO_ACTIVE_HIGH>;
> -               line-name = "CTRL_SLEEP_MOCI#";
> -               output-high;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
> -       };
> -};
> -
> -/* On-module I2C */
> -&i2c1 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c1>;
> -       pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -       scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       status = "okay";
> -
> -       pca9450: pmic@25 {
> -               compatible = "nxp,pca9450c";
> -               interrupt-parent = <&gpio1>;
> -               /* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> -               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pmic>;
> -               reg = <0x25>;
> -
> -               /*
> -                * The bootloader is expected to switch on LDO4 for the on-module +V3.3_ADC and the
> -                * I2C level shifter for the TLA2024 ADC behind this PMIC.
> -                */
> -
> -               regulators {
> -                       BUCK1 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1000000>;
> -                               regulator-min-microvolt = <720000>;
> -                               regulator-name = "On-module +VDD_SOC (BUCK1)";
> -                               regulator-ramp-delay = <3125>;
> -                       };
> -
> -                       reg_vdd_arm: BUCK2 {
> -                               nxp,dvs-run-voltage = <950000>;
> -                               nxp,dvs-standby-voltage = <850000>;
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1025000>;
> -                               regulator-min-microvolt = <720000>;
> -                               regulator-name = "On-module +VDD_ARM (BUCK2)";
> -                               regulator-ramp-delay = <3125>;
> -                       };
> -
> -                       reg_vdd_3v3: BUCK4 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <3300000>;
> -                               regulator-name = "On-module +V3.3 (BUCK4)";
> -                       };
> -
> -                       reg_vdd_1v8: BUCK5 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "PWR_1V8_MOCI (BUCK5)";
> -                       };
> -
> -                       BUCK6 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1155000>;
> -                               regulator-min-microvolt = <1045000>;
> -                               regulator-name = "On-module +VDD_DDR (BUCK6)";
> -                       };
> -
> -                       LDO1 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1950000>;
> -                               regulator-min-microvolt = <1650000>;
> -                               regulator-name = "On-module +V1.8_SNVS (LDO1)";
> -                       };
> -
> -                       LDO2 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1150000>;
> -                               regulator-min-microvolt = <800000>;
> -                               regulator-name = "On-module +V0.8_SNVS (LDO2)";
> -                       };
> -
> -                       LDO3 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "On-module +V1.8A (LDO3)";
> -                       };
> -
> -                       LDO4 {
> -                               regulator-always-on;
> -                               regulator-boot-on;
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <3300000>;
> -                               regulator-name = "On-module +V3.3_ADC (LDO4)";
> -                       };
> -
> -                       LDO5 {
> -                               regulator-max-microvolt = <3300000>;
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
> -                       };
> -               };
> -       };
> -
> -       rtc_i2c: rtc@32 {
> -               compatible = "epson,rx8130";
> -               reg = <0x32>;
> -       };
> -
> -       /* On-module temperature sensor */
> -       hwmon_temp_module: sensor@48 {
> -               compatible = "ti,tmp1075";
> -               reg = <0x48>;
> -               vs-supply = <&reg_vdd_1v8>;
> -       };
> -
> -       adc@49 {
> -               compatible = "ti,ads1015";
> -               reg = <0x49>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               /* Verdin I2C_1 (ADC_4 - ADC_3) */
> -               channel@0 {
> -                       reg = <0>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_4 - ADC_1) */
> -               channel@1 {
> -                       reg = <1>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_3 - ADC_1) */
> -               channel@2 {
> -                       reg = <2>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 (ADC_2 - ADC_1) */
> -               channel@3 {
> -                       reg = <3>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_4 */
> -               channel@4 {
> -                       reg = <4>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_3 */
> -               channel@5 {
> -                       reg = <5>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_2 */
> -               channel@6 {
> -                       reg = <6>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -
> -               /* Verdin I2C_1 ADC_1 */
> -               channel@7 {
> -                       reg = <7>;
> -                       ti,datarate = <4>;
> -                       ti,gain = <2>;
> -               };
> -       };
> -
> -       eeprom@50 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -};
> -
> -/* Verdin I2C_2_DSI */
> -&i2c2 {
> -       /* Lower frequency to avoid DDC/EDID issues with certain displays/screens. */
> -       clock-frequency = <10000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       pinctrl-1 = <&pinctrl_i2c2_gpio>;
> -       scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -
> -       atmel_mxt_ts_mezzanine: touch-mezzanine@4a {
> -               compatible = "atmel,maxtouch";
> -               /* Verdin GPIO_3 (SODIMM 210) */
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> -               reg = <0x4a>;
> -               /* Verdin GPIO_2 (SODIMM 208) */
> -               reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -};
> -
> -/* TODO: Verdin I2C_3_HDMI */
> -
> -/* Verdin I2C_4_CSI */
> -&i2c3 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c3>;
> -       pinctrl-1 = <&pinctrl_i2c3_gpio>;
> -       scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -};
> -
> -/* Verdin I2C_1 */
> -&i2c4 {
> -       clock-frequency = <400000>;
> -       pinctrl-names = "default", "gpio";
> -       pinctrl-0 = <&pinctrl_i2c4>;
> -       pinctrl-1 = <&pinctrl_i2c4_gpio>;
> -       scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -       sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -
> -       gpio_expander_21: gpio-expander@21 {
> -               compatible = "nxp,pcal6416";
> -               #gpio-cells = <2>;
> -               gpio-controller;
> -               reg = <0x21>;
> -               vcc-supply = <&reg_3p3v>;
> -               status = "disabled";
> -       };
> -
> -       lvds_ti_sn65dsi84: bridge@2c {
> -               compatible = "ti,sn65dsi84";
> -               /* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
> -               /* Verdin GPIO_10_DSI (SODIMM 21) */
> -               enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_10_dsi>;
> -               reg = <0x2c>;
> -               status = "disabled";
> -       };
> -
> -       /* Current measurement into module VCC */
> -       hwmon: hwmon@40 {
> -               compatible = "ti,ina219";
> -               reg = <0x40>;
> -               shunt-resistor = <10000>;
> -               status = "disabled";
> -       };
> -
> -       hdmi_lontium_lt8912: hdmi@48 {
> -               compatible = "lontium,lt8912b";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_10_dsi>, <&pinctrl_pwm_3_dsi_hpd_gpio>;
> -               reg = <0x48>;
> -               /* Verdin GPIO_9_DSI (LT8912 INT, SODIMM 17, unused) */
> -               /* Verdin GPIO_10_DSI (SODIMM 21) */
> -               reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -
> -       atmel_mxt_ts: touch@4a {
> -               compatible = "atmel,maxtouch";
> -               /*
> -                * Verdin GPIO_9_DSI
> -                * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI84 IRQ albeit currently unused)
> -                */
> -               interrupt-parent = <&gpio4>;
> -               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_gpio_9_dsi>, <&pinctrl_i2s_2_bclk_touch_reset>;
> -               reg = <0x4a>;
> -               /* Verdin I2S_2_BCLK (TOUCH_RESET#, SODIMM 42) */
> -               reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> -               status = "disabled";
> -       };
> -
> -       /* Temperature sensor on carrier board */
> -       hwmon_temp: sensor@4f {
> -               compatible = "ti,tmp75c";
> -               reg = <0x4f>;
> -               status = "disabled";
> -       };
> -
> -       /* EEPROM on display adapter (MIPI DSI Display Adapter) */
> -       eeprom_display_adapter: eeprom@50 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -               status = "disabled";
> -       };
> -
> -       /* EEPROM on carrier board */
> -       eeprom_carrier_board: eeprom@57 {
> -               compatible = "st,24c02";
> -               pagesize = <16>;
> -               reg = <0x57>;
> -               status = "disabled";
> -       };
> -};
> -
> -/* Verdin PCIE_1 */
> -&pcie {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pcie>;
> -       /* PCIE_1_RESET# (SODIMM 244) */
> -       reset-gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
> -};
> -
> -&pcie_phy {
> -       clocks = <&hsio_blk_ctrl>;
> -       clock-names = "ref";
> -       fsl,clkreq-unsupported;
> -       fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> -};
> -
> -/* Verdin PWM_1 */
> -&pwm1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_1>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* Verdin PWM_2 */
> -&pwm2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_2>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* Verdin PWM_3_DSI */
> -&pwm3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_pwm_3>;
> -       #pwm-cells = <3>;
> -};
> -
> -/* TODO: Verdin I2S_1 */
> -
> -/* TODO: Verdin I2S_2 */
> -
> -&snvs_pwrkey {
> -       status = "okay";
> -};
> -
> -/* Verdin UART_1 */
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -       uart-has-rtscts;
> -};
> -
> -/* Verdin UART_2 */
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart2>;
> -       uart-has-rtscts;
> -};
> -
> -/* Verdin UART_3, used as the Linux Console */
> -&uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart3>;
> -};
> -
> -/* Verdin UART_4, used for Bluetooth on Wi-Fi/Bluetooth SKUs */
> -&uart4 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart4>;
> -};
> -
> -/* Verdin USB_1 */
> -&usb3_0 {
> -       fsl,disable-port-power-control;
> -       fsl,over-current-active-low;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_usb_1_oc_n>;
> -};
> -
> -&usb_dwc3_0 {
> -       /* dual role only, not full featured OTG */
> -       adp-disable;
> -       dr_mode = "otg";
> -       hnp-disable;
> -       maximum-speed = "high-speed";
> -       role-switch-default-mode = "peripheral";
> -       srp-disable;
> -       usb-role-switch;
> -
> -       connector {
> -               compatible = "gpio-usb-b-connector", "usb-b-connector";
> -               id-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> -               label = "Type-C";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_usb_1_id>;
> -               self-powered;
> -               type = "micro";
> -               vbus-supply = <&reg_usb1_vbus>;
> -       };
> -};
> -
> -/* Verdin USB_2 */
> -&usb3_1 {
> -       fsl,disable-port-power-control;
> -};
> -
> -&usb3_phy1 {
> -       vbus-supply = <&reg_usb2_vbus>;
> -};
> -
> -&usb_dwc3_1 {
> -       dr_mode = "host";
> -};
> -
> -/* Verdin SD_1 */
> -&usdhc2 {
> -       assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
> -       assigned-clock-rates = <400000000>;
> -       bus-width = <4>;
> -       cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> -       disable-wp;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> -       pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> -       pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
> -       vmmc-supply = <&reg_usdhc2_vmmc>;
> -};
> -
> -/* On-module eMMC */
> -&usdhc3 {
> -       assigned-clocks = <&clk IMX8MP_CLK_USDHC3_ROOT>;
> -       assigned-clock-rates = <400000000>;
> -       bus-width = <8>;
> -       non-removable;
> -       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -       pinctrl-0 = <&pinctrl_usdhc3>;
> -       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> -       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> -       status = "okay";
> -};
> -
> -&wdog1 {
> -       fsl,ext-reset-output;
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_wdog>;
> -       status = "okay";
> -};
> -
> -&iomuxc {
> -       pinctrl_bt_uart: btuartgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_ECSPI2_MISO__UART4_DCE_CTS        0x1c4>,
> -                       <MX8MP_IOMUXC_ECSPI2_MOSI__UART4_DCE_TX         0x1c4>,
> -                       <MX8MP_IOMUXC_ECSPI2_SCLK__UART4_DCE_RX         0x1c4>,
> -                       <MX8MP_IOMUXC_ECSPI2_SS0__UART4_DCE_RTS         0x1c4>;
> -       };
> -
> -       pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29              0x1c4>; /* SODIMM 256 */
> -       };
> -
> -       pinctrl_ecspi1: ecspi1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO          0x1c4>, /* SODIMM 198 */
> -                       <MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI          0x4>,   /* SODIMM 200 */
> -                       <MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK          0x4>,   /* SODIMM 196 */
> -                       <MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09            0x1c4>; /* SODIMM 202 */
> -       };
> -
> -       /* Connection On Board PHY */
> -       pinctrl_eqos: eqosgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC                            0x3>,
> -                       <MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO                          0x3>,
> -                       <MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0                      0x91>,
> -                       <MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1                      0x91>,
> -                       <MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2                      0x91>,
> -                       <MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3                      0x91>,
> -                       <MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK      0x91>,
> -                       <MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL                0x91>,
> -                       <MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0                      0x1f>,
> -                       <MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1                      0x1f>,
> -                       <MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2                      0x1f>,
> -                       <MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3                      0x1f>,
> -                       <MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL                0x1f>,
> -                       <MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK      0x1f>;
> -       };
> -
> -       /* ETH_INT# shared with TPM_INT# (usually N/A) */
> -       pinctrl_eth_tpm_int: ethtpmintgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10            0x1c4>;
> -       };
> -
> -       /* Connection Carrier Board PHY ETH_2 */
> -       pinctrl_fec: fecgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC              0x3>,   /* SODIMM 193 */
> -                       <MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO             0x3>,   /* SODIMM 191 */
> -                       <MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0        0x91>,  /* SODIMM 201 */
> -                       <MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1        0x91>,  /* SODIMM 203 */
> -                       <MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2        0x91>,  /* SODIMM 205 */
> -                       <MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3        0x91>,  /* SODIMM 207 */
> -                       <MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC         0x91>,  /* SODIMM 197 */
> -                       <MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL     0x91>,  /* SODIMM 199 */
> -                       <MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0        0x1f>,  /* SODIMM 221 */
> -                       <MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1        0x1f>,  /* SODIMM 219 */
> -                       <MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2        0x1f>,  /* SODIMM 217 */
> -                       <MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3        0x1f>,  /* SODIMM 215 */
> -                       <MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL     0x1f>,  /* SODIMM 211 */
> -                       <MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC        0x1f>,  /* SODIMM 213 */
> -                       <MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18             0x1c4>; /* SODIMM 189 */
> -       };
> -
> -       pinctrl_fec_sleep: fecsleepgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC              0x3>,   /* SODIMM 193 */
> -                       <MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO             0x3>,   /* SODIMM 191 */
> -                       <MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0        0x91>,  /* SODIMM 201 */
> -                       <MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1        0x91>,  /* SODIMM 203 */
> -                       <MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2        0x91>,  /* SODIMM 205 */
> -                       <MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3        0x91>,  /* SODIMM 207 */
> -                       <MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC         0x91>,  /* SODIMM 197 */
> -                       <MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL     0x91>,  /* SODIMM 199 */
> -                       <MX8MP_IOMUXC_SAI1_TXD0__GPIO4_IO12             0x1f>,  /* SODIMM 221 */
> -                       <MX8MP_IOMUXC_SAI1_TXD1__GPIO4_IO13             0x1f>,  /* SODIMM 219 */
> -                       <MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14             0x1f>,  /* SODIMM 217 */
> -                       <MX8MP_IOMUXC_SAI1_TXD3__GPIO4_IO15             0x1f>,  /* SODIMM 215 */
> -                       <MX8MP_IOMUXC_SAI1_TXD4__GPIO4_IO16             0x1f>,  /* SODIMM 211 */
> -                       <MX8MP_IOMUXC_SAI1_TXD5__GPIO4_IO17             0x1f>,  /* SODIMM 213 */
> -                       <MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18             0x184>; /* SODIMM 189 */
> -       };
> -
> -       pinctrl_flexcan1: flexcan1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SPDIF_RX__CAN1_RX                 0x154>, /* SODIMM 22 */
> -                       <MX8MP_IOMUXC_SPDIF_TX__CAN1_TX                 0x154>; /* SODIMM 20 */
> -       };
> -
> -       pinctrl_flexcan2: flexcan2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI2_MCLK__CAN2_RX                0x154>, /* SODIMM 26 */
> -                       <MX8MP_IOMUXC_SAI2_TXD0__CAN2_TX                0x154>; /* SODIMM 24 */
> -       };
> -
> -       pinctrl_flexspi0: flexspi0grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK          0x1c2>, /* SODIMM 52 */
> -                       <MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B       0x82>,  /* SODIMM 54 */
> -                       <MX8MP_IOMUXC_NAND_DQS__FLEXSPI_A_DQS           0x82>,  /* SODIMM 66 */
> -                       <MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00     0x82>,  /* SODIMM 56 */
> -                       <MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01     0x82>,  /* SODIMM 58 */
> -                       <MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02     0x82>,  /* SODIMM 60 */
> -                       <MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03     0x82>,  /* SODIMM 62 */
> -                       <MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16          0x82>;  /* SODIMM 64 */
> -       };
> -
> -       pinctrl_gpio1: gpio1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00            0x184>; /* SODIMM 206 */
> -       };
> -
> -       pinctrl_gpio2: gpio2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01            0x1c4>; /* SODIMM 208 */
> -       };
> -
> -       pinctrl_gpio3: gpio3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05            0x184>; /* SODIMM 210 */
> -       };
> -
> -       pinctrl_gpio4: gpio4grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06            0x184>; /* SODIMM 212 */
> -       };
> -
> -       pinctrl_gpio5: gpio5grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07            0x184>; /* SODIMM 216 */
> -       };
> -
> -       pinctrl_gpio6: gpio6grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08            0x184>; /* SODIMM 218 */
> -       };
> -
> -       pinctrl_gpio7: gpio7grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03             0x184>; /* SODIMM 220 */
> -       };
> -
> -       pinctrl_gpio8: gpio8grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01              0x184>; /* SODIMM 222 */
> -       };
> -
> -       /* Verdin GPIO_9_DSI (pulled-up as active-low) */
> -       pinctrl_gpio_9_dsi: gpio9dsigrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25              0x1c4>; /* SODIMM 17 */
> -       };
> -
> -       /* Verdin GPIO_10_DSI */
> -       pinctrl_gpio_10_dsi: gpio10dsigrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28             0x1c4>; /* SODIMM 21 */
> -       };
> -
> -       /* Non-wifi MSP usage only */
> -       pinctrl_gpio_hog1: gpiohog1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_ECSPI2_MISO__GPIO5_IO12           0x1c4>, /* SODIMM 116 */
> -                       <MX8MP_IOMUXC_ECSPI2_MOSI__GPIO5_IO11           0x1c4>, /* SODIMM 152 */
> -                       <MX8MP_IOMUXC_ECSPI2_SCLK__GPIO5_IO10           0x1c4>, /* SODIMM 164 */
> -                       <MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13            0x1c4>; /* SODIMM 128 */
> -       };
> -
> -       /* USB_2_OC# */
> -       pinctrl_gpio_hog2: gpiohog2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02             0x1c4>; /* SODIMM 187 */
> -       };
> -
> -       pinctrl_gpio_hog3: gpiohog3grp {
> -               fsl,pins =
> -                       /* CSI_1_MCLK */
> -                       <MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15            0x1c4>; /* SODIMM 91 */
> -       };
> -
> -       /* Wifi usage only */
> -       pinctrl_gpio_hog4: gpiohog4grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_UART4_RXD__GPIO5_IO28             0x1c4>, /* SODIMM 151 */
> -                       <MX8MP_IOMUXC_UART4_TXD__GPIO5_IO29             0x1c4>; /* SODIMM 153 */
> -       };
> -
> -       pinctrl_gpio_keys: gpiokeysgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00             0x1c4>; /* SODIMM 252 */
> -       };
> -
> -       pinctrl_hdmi_hog: hdmihoggrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC        0x40000019>,    /* SODIMM 63 */
> -                       <MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL    0x400001c3>,    /* SODIMM 59 */
> -                       <MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA    0x400001c3>,    /* SODIMM 57 */
> -                       <MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD        0x40000019>;    /* SODIMM 61 */
> -       };
> -
> -       /* On-module I2C */
> -       pinctrl_i2c1: i2c1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL                0x400001c6>,    /* PMIC_I2C_SCL */
> -                       <MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA                0x400001c6>;    /* PMIC_I2C_SDA */
> -       };
> -
> -       pinctrl_i2c1_gpio: i2c1gpiogrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14              0x400001c6>,    /* PMIC_I2C_SCL */
> -                       <MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15              0x400001c6>;    /* PMIC_I2C_SDA */
> -       };
> -
> -       /* Verdin I2C_2_DSI */
> -       pinctrl_i2c2: i2c2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL                0x400001c6>,    /* SODIMM 55 */
> -                       <MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA                0x400001c6>;    /* SODIMM 53 */
> -       };
> -
> -       pinctrl_i2c2_gpio: i2c2gpiogrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16              0x400001c6>,    /* SODIMM 55 */
> -                       <MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17              0x400001c6>;    /* SODIMM 53 */
> -       };
> -
> -       /* Verdin I2C_4_CSI */
> -       pinctrl_i2c3: i2c3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL                0x400001c6>,    /* SODIMM 95 */
> -                       <MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA                0x400001c6>;    /* SODIMM 93 */
> -       };
> -
> -       pinctrl_i2c3_gpio: i2c3gpiogrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18              0x400001c6>,    /* SODIMM 95 */
> -                       <MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19              0x400001c6>;    /* SODIMM 93 */
> -       };
> -
> -       /* Verdin I2C_1 */
> -       pinctrl_i2c4: i2c4grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL                0x400001c6>,    /* SODIMM 14 */
> -                       <MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA                0x400001c6>;    /* SODIMM 12 */
> -       };
> -
> -       pinctrl_i2c4_gpio: i2c4gpiogrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20              0x400001c6>,    /* SODIMM 14 */
> -                       <MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21              0x400001c6>;    /* SODIMM 12 */
> -       };
> -
> -       /* Verdin I2S_2_BCLK (TOUCH_RESET#) */
> -       pinctrl_i2s_2_bclk_touch_reset: i2s2bclktouchresetgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00              0x184>; /* SODIMM 42 */
> -       };
> -
> -       /* Verdin I2S_2_D_OUT shared with SAI3 */
> -       pinctrl_i2s_2_d_out_dsi_1_bkl_en: i2s2doutdsi1bklengrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01              0x184>; /* SODIMM 46 */
> -       };
> -
> -       pinctrl_pcie: pciegrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19             0x4>,   /* SODIMM 244 */
> -                       <MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19           0x1c4>; /* PMIC_EN_PCIe_CLK, unused */
> -       };
> -
> -       pinctrl_pmic: pmicirqgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03            0x1c4>; /* PMIC_INT# */
> -       };
> -
> -       pinctrl_pwm_1: pwm1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT           0x6>;   /* SODIMM 15 */
> -       };
> -
> -       pinctrl_pwm_2: pwm2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT              0x6>;   /* SODIMM 16 */
> -       };
> -
> -       /* Verdin PWM_3_DSI shared with GPIO3_IO20 */
> -       pinctrl_pwm_3: pwm3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI5_RXC__PWM3_OUT                0x6>;   /* SODIMM 19 */
> -       };
> -
> -       /* Verdin PWM_3_DSI (pulled-down as active-high) shared with PWM3_OUT */
> -       pinctrl_pwm_3_dsi_hpd_gpio: pwm3dsi1hpdgpiogrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20              0x184>; /* SODIMM 19 */
> -       };
> -
> -       pinctrl_reg_eth: regethgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD2_WP__GPIO2_IO20                0x184>; /* PMIC_EN_ETH */
> -       };
> -
> -       pinctrl_sai1: sai1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI1_MCLK__AUDIOMIX_SAI1_MCLK             0x96>,  /* SODIMM 38 */
> -                       <MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_SAI1_RX_DATA00        0x1d6>, /* SODIMM 36 */
> -                       <MX8MP_IOMUXC_SAI5_MCLK__AUDIOMIX_SAI1_TX_BCLK          0x1d6>, /* SODIMM 30 */
> -                       <MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI1_TX_SYNC          0x1d6>, /* SODIMM 32 */
> -                       <MX8MP_IOMUXC_SAI5_RXFS__AUDIOMIX_SAI1_TX_DATA00        0x96>;  /* SODIMM 34 */
> -       };
> -
> -       pinctrl_sai3: sai3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00 0x1d6>, /* SODIMM 48 */
> -                       <MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK   0x1d6>, /* SODIMM 42 */
> -                       <MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00 0x96>,  /* SODIMM 46 */
> -                       <MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC  0x1d6>; /* SODIMM 44 */
> -       };
> -
> -       pinctrl_uart1: uart1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI2_RXD0__UART1_DCE_RTS          0x1c4>, /* SODIMM 135 */
> -                       <MX8MP_IOMUXC_SAI2_TXFS__UART1_DCE_CTS          0x1c4>, /* SODIMM 133 */
> -                       <MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX           0x1c4>, /* SODIMM 129 */
> -                       <MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX           0x1c4>; /* SODIMM 131 */
> -       };
> -
> -       pinctrl_uart2: uart2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_DATA4__UART2_DCE_RTS          0x1c4>, /* SODIMM 143 */
> -                       <MX8MP_IOMUXC_SD1_DATA5__UART2_DCE_CTS          0x1c4>, /* SODIMM 141 */
> -                       <MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX           0x1c4>, /* SODIMM 137 */
> -                       <MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX           0x1c4>; /* SODIMM 139 */
> -       };
> -
> -       pinctrl_uart3: uart3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX           0x1c4>, /* SODIMM 147 */
> -                       <MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX           0x1c4>; /* SODIMM 149 */
> -       };
> -
> -       /* Non-wifi usage only */
> -       pinctrl_uart4: uart4grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX           0x1c4>, /* SODIMM 151 */
> -                       <MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX           0x1c4>; /* SODIMM 153 */
> -       };
> -
> -       pinctrl_usb1_vbus: usb1vbusgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12            0x106>; /* SODIMM 155 */
> -       };
> -
> -       /* USB_1_ID */
> -       pinctrl_usb_1_id: usb1idgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10           0x1c4>; /* SODIMM 161 */
> -       };
> -
> -       /* USB_1_OC# */
> -       pinctrl_usb_1_oc_n: usb1ocngrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC           0x1c4>; /* SODIMM 157 */
> -       };
> -
> -       pinctrl_usb2_vbus: usb2vbusgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14            0x106>; /* SODIMM 185 */
> -       };
> -
> -       /* On-module Wi-Fi */
> -       pinctrl_usdhc1: usdhc1grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK               0x190>,
> -                       <MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD               0x1d0>,
> -                       <MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0           0x1d0>,
> -                       <MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1           0x1d0>,
> -                       <MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2           0x1d0>,
> -                       <MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3           0x1d0>;
> -       };
> -
> -       pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK               0x194>,
> -                       <MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD               0x1d4>,
> -                       <MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0           0x1d4>,
> -                       <MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1           0x1d4>,
> -                       <MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2           0x1d4>,
> -                       <MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3           0x1d4>;
> -       };
> -
> -       pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK               0x196>,
> -                       <MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD               0x1d6>,
> -                       <MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0           0x1d6>,
> -                       <MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1           0x1d6>,
> -                       <MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2           0x1d6>,
> -                       <MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3           0x1d6>;
> -       };
> -
> -       pinctrl_usdhc2_cd: usdhc2cdgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12              0x1c4>; /* SODIMM 84 */
> -       };
> -
> -       pinctrl_usdhc2_cd_sleep: usdhc2cdslpgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12              0x0>;   /* SODIMM 84 */
> -       };
> -
> -       pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22              0x4>;   /* SODIMM 76 */
> -       };
> -
> -       pinctrl_usdhc2: usdhc2grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT        0x4>,   /* PMIC_USDHC_VSELECT */
> -                       <MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK               0x190>, /* SODIMM 78 */
> -                       <MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD               0x1d0>, /* SODIMM 74 */
> -                       <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0           0x1d0>, /* SODIMM 80 */
> -                       <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1           0x1d0>, /* SODIMM 82 */
> -                       <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2           0x1d0>, /* SODIMM 70 */
> -                       <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3           0x1d0>; /* SODIMM 72 */
> -       };
> -
> -       pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT        0x4>,
> -                       <MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK               0x194>,
> -                       <MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD               0x1d4>,
> -                       <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0           0x1d4>,
> -                       <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1           0x1d4>,
> -                       <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2           0x1d4>,
> -                       <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3           0x1d4>;
> -       };
> -
> -       pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT        0x4>,
> -                       <MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK               0x196>,
> -                       <MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD               0x1d6>,
> -                       <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0           0x1d6>,
> -                       <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1           0x1d6>,
> -                       <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2           0x1d6>,
> -                       <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3           0x1d6>;
> -       };
> -
> -       /* Avoid backfeeding with removed card power */
> -       pinctrl_usdhc2_sleep: usdhc2slpgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT        0x0>,
> -                       <MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK               0x100>,
> -                       <MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD               0x100>,
> -                       <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0           0x100>,
> -                       <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1           0x100>,
> -                       <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2           0x100>,
> -                       <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3           0x100>;
> -       };
> -
> -       pinctrl_usdhc3: usdhc3grp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO09__USDHC3_RESET_B        0x1d1>,
> -                       <MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE         0x190>,
> -                       <MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5          0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6          0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7            0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0         0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1         0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2         0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3         0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4           0x1d0>,
> -                       <MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK             0x190>,
> -                       <MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD             0x1d0>;
> -       };
> -
> -       pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO09__USDHC3_RESET_B        0x1d1>,
> -                       <MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE         0x194>,
> -                       <MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5          0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6          0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7            0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0         0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1         0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2         0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3         0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4           0x1d4>,
> -                       <MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK             0x194>,
> -                       <MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD             0x1d4>;
> -       };
> -
> -       pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO09__USDHC3_RESET_B        0x1d1>,
> -                       <MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE         0x196>,
> -                       <MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5          0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6          0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7            0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0         0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1         0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2         0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3         0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4           0x1d2>,
> -                       <MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK             0x196>,
> -                       <MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD             0x1d6>;
> -       };
> -
> -       pinctrl_wdog: wdoggrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B          0xc6>;  /* PMIC_WDI */
> -       };
> -
> -       pinctrl_bluetooth_ctrl: bluetoothctrlgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08             0x1c4>; /* WIFI_WKUP_BT */
> -       };
> -
> -       pinctrl_wifi_ctrl: wifictrlgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09             0x1c4>; /* WIFI_WKUP_WLAN */
> -       };
> -
> -       pinctrl_wifi_i2s: wifii2sgrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21             0x1d6>, /* WIFI_TX_SYNC */
> -                       <MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21             0x96>,  /* WIFI_RX_DATA0 */
> -                       <MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23             0x1d6>, /* WIFI_TX_BCLK */
> -                       <MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24             0x1d6>; /* WIFI_TX_DATA0 */
> -       };
> -
> -       pinctrl_wifi_pwr_en: wifipwrengrp {
> -               fsl,pins =
> -                       <MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11            0x184>; /* PMIC_EN_WIFI */
> -       };
> -};
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
> index fbde476a7f1..4958f018a7f 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -261,12 +261,14 @@ config TARGET_VERDIN_IMX8MM
>         select IMX8MM
>         select SUPPORT_SPL
>         select IMX8M_LPDDR4
> +       imply OF_UPSTREAM
>
>  config TARGET_VERDIN_IMX8MP
>         bool "Support Toradex Verdin iMX8M Plus module"
>         select IMX8MP
>         select SUPPORT_SPL
>         select IMX8M_LPDDR4
> +       imply OF_UPSTREAM
>
>  config TARGET_IMX8MM_BEACON
>         bool "imx8mm Beacon Embedded devkit"
> diff --git a/board/toradex/verdin-imx8mm/MAINTAINERS b/board/toradex/verdin-imx8mm/MAINTAINERS
> index 8217bbcdc0c..d567f0e1097 100644
> --- a/board/toradex/verdin-imx8mm/MAINTAINERS
> +++ b/board/toradex/verdin-imx8mm/MAINTAINERS
> @@ -2,10 +2,6 @@ Verdin iMX8M Mini
>  M:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
>  W:     https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini
>  S:     Maintained
> -F:     arch/arm/dts/imx8mm-verdin.dtsi
> -F:     arch/arm/dts/imx8mm-verdin-dev.dtsi
> -F:     arch/arm/dts/imx8mm-verdin-wifi.dtsi
> -F:     arch/arm/dts/imx8mm-verdin-wifi-dev.dts
>  F:     arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
>  F:     board/toradex/verdin-imx8mm/
>  F:     board/toradex/common/
> diff --git a/board/toradex/verdin-imx8mp/MAINTAINERS b/board/toradex/verdin-imx8mp/MAINTAINERS
> index 85d6be88163..9fe76d8e42f 100644
> --- a/board/toradex/verdin-imx8mp/MAINTAINERS
> +++ b/board/toradex/verdin-imx8mp/MAINTAINERS
> @@ -1,8 +1,4 @@
>  Verdin iMX8M Plus
> -F:     arch/arm/dts/imx8mp-verdin.dtsi
> -F:     arch/arm/dts/imx8mp-verdin-dev.dtsi
> -F:     arch/arm/dts/imx8mp-verdin-wifi.dtsi
> -F:     arch/arm/dts/imx8mp-verdin-wifi-dev.dts
>  F:     arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
>  F:     board/toradex/verdin-imx8mp/
>  F:     board/toradex/common/
> diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
> index afa42c11fac..4f1480c610c 100644
> --- a/configs/verdin-imx8mm_defconfig
> +++ b/configs/verdin-imx8mm_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>  CONFIG_ENV_SIZE=0x2000
>  CONFIG_ENV_OFFSET=0xFFFFDE00
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="imx8mm-verdin-wifi-dev"
> +CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-verdin-wifi-dev"
>  CONFIG_SPL_TEXT_BASE=0x7E1000
>  CONFIG_TARGET_VERDIN_IMX8MM=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> index b6194404baa..4490a4a19a3 100644
> --- a/configs/verdin-imx8mp_defconfig
> +++ b/configs/verdin-imx8mp_defconfig
> @@ -12,7 +12,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
>  CONFIG_SYS_I2C_MXC_I2C3=y
>  CONFIG_SYS_I2C_MXC_I2C4=y
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="imx8mp-verdin-wifi-dev"
> +CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-verdin-wifi-dev"
>  CONFIG_SPL_TEXT_BASE=0x920000
>  CONFIG_TARGET_VERDIN_IMX8MP=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> --
> 2.44.0
>
