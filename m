Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D33E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0201780245;
	Tue, 17 Dec 2024 14:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QMXgSgNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26433801CF; Tue, 17 Dec 2024 07:41:13 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3152801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 07:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85c5a913cffso2463212241.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 22:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734417667; x=1735022467; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QU776xniGZwVcCuwQPUnAJ3wj5eSzmzN/HSKVE/5zY=;
 b=QMXgSgNAT5LlMj0kVp2Z1i5f91NJcNkDBsvnLSsTMIHJroKy6+Z7hKHL4PRqgoGXtZ
 OQ3rgJldsBtn/77qBW6e2v70bCt7EBqo78CNJtigtctQEV6dIM/ToFcx3zXwVl0MLdRH
 ELdCRVWBjIRNtvIYCBcDWuyXvqKMLbk9Cly/xCfDWHK+hZ6g3I66mSopxsv+U1ItSlhJ
 w4vMN3pxlCop6QgOf3BesA0XIIaYuFyAFKG/IFnnWiPnPlpUEgf3zgZU3k03KYeisTDR
 x/z75+Hor+h1HgoJCpK24etm4nZqZK3FMHsiTunwkMehz8Ksl5wXY+g2h7IC1Flr+GI7
 tY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734417667; x=1735022467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QU776xniGZwVcCuwQPUnAJ3wj5eSzmzN/HSKVE/5zY=;
 b=FHRBlB8yk2S0WL8l/Fg/5aW+pXZnyupAVFj4dIjelzgLdnTqdU0Vo4xqkmMLT4OmBf
 9Zm56m2bor+YPXHSG94iPXyOeXxLmbJJdO9jFhrkphsTXhNwbFN8nxgBGtvKLhcIy+Tv
 o7zcTHskPRba2wgLMGSlTdmdt1fj+v14P2tQ3oVhwmSU+rqzut8auLiBPbL5dvDxR06b
 jwGsGQffMgTr1TRYe8nSwEW9tpMs71UibiDe1PK7l9cMdTpElZi7lYz1lJfaES5CdMbW
 bMpC9q6XUFu5mEvyqs6gXUctpPYWTf97+eFByAzIEJ+wy7TqAihlAc4iiTrrCTsYCnGr
 Lpmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWieEcgcagH5QxhaYnGOv6cnnCivXQfKTXrkUNRkb7SJZo4Wv6GE/HTpRkUY4fy4r8YH6Vl2zw=@lists.denx.de
X-Gm-Message-State: AOJu0YxEdYR3nkKt+wXWokWi3Ftjdsi57QCweyKR4ZogtH00Xp22gJPV
 50XOBqdwdbSt2PhXSwTOHqNRmcZ1LXiPJEt0A1xgN6F0Wsh21KRViG0krBr0XurioYD3orlJIpf
 tA0YLQU0/sExqE87m6OObedMN3cT9+vOlqI1MfA==
X-Gm-Gg: ASbGncviVTAkb1D/rLR2FN1OSirmqPOhSJxC/X8RJexDDhdkZAWlk0omwmrTU2L4XB1
 SieEJjfcjrwF3n2mnQ1HHI7LEqwJrKVnLV2fE74Y=
X-Google-Smtp-Source: AGHT+IFo1xwRYmtKgkEbSxqia35Bfin1B61p2DglhYUofuQfbI3MoLTFNmBJEDS8EPPk1Ij4HLJCw9km1Qi3h0kO6vE=
X-Received: by 2002:a05:6102:419e:b0:4b2:5d16:2902 with SMTP id
 ada2fe7eead31-4b25dc6dc7dmr15340022137.6.1734417666821; Mon, 16 Dec 2024
 22:41:06 -0800 (PST)
MIME-Version: 1.0
References: <93c8f104-8596-433d-bc28-c82034addfaa@gmail.com>
In-Reply-To: <93c8f104-8596-433d-bc28-c82034addfaa@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 17 Dec 2024 12:10:55 +0530
Message-ID: <CAFA6WYO4vd5VkHFEbO23YsYoXBEUuKPJ5dGqkbp+p17xYLurtA@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: use OF_UPSTREAM for rk3066a/rk3188
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 17 Dec 2024 14:17:40 +0100
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

On Mon, 16 Dec 2024 at 18:14, Johan Jonker <jbx6244@gmail.com> wrote:
>
> The device tree for rk3066a/rk3188 combined is now
> available in the /dts/upstream directory.
> Use imply OF_UPSTREAM to migrate all rk3066a/rk3188 boards.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V2:
>   remove Makefile entries
> ---
>  arch/arm/dts/Makefile             |   6 -
>  arch/arm/dts/rk3066a-mk808.dts    | 241 --------
>  arch/arm/dts/rk3066a-u-boot.dtsi  |  20 -
>  arch/arm/dts/rk3066a.dtsi         | 880 ------------------------------
>  arch/arm/dts/rk3188-radxarock.dts | 389 -------------
>  arch/arm/dts/rk3188-u-boot.dtsi   |  17 -
>  arch/arm/dts/rk3188.dtsi          | 815 ---------------------------
>  arch/arm/dts/rk3xxx.dtsi          | 488 -----------------
>  arch/arm/mach-rockchip/Kconfig    |   2 +
>  configs/mk808_defconfig           |   4 +-
>  configs/rock_defconfig            |   4 +-
>  11 files changed, 6 insertions(+), 2860 deletions(-)
>  delete mode 100644 arch/arm/dts/rk3066a-mk808.dts
>  delete mode 100644 arch/arm/dts/rk3066a.dtsi
>  delete mode 100644 arch/arm/dts/rk3188-radxarock.dts
>  delete mode 100644 arch/arm/dts/rk3188.dtsi
>  delete mode 100644 arch/arm/dts/rk3xxx.dtsi
>

Glad to see this diff.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 6ad59aeed5f6..166f9628dc8a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -55,15 +55,9 @@ dtb-$(CONFIG_MACH_S700) +=3D \
>  dtb-$(CONFIG_ROCKCHIP_RK3036) +=3D \
>         rk3036-sdk.dtb
>
> -dtb-$(CONFIG_ROCKCHIP_RK3066) +=3D \
> -       rk3066a-mk808.dtb
> -
>  dtb-$(CONFIG_ROCKCHIP_RK3128) +=3D \
>         rk3128-evb.dtb
>
> -dtb-$(CONFIG_ROCKCHIP_RK3188) +=3D \
> -       rk3188-radxarock.dtb
> -
>  dtb-$(CONFIG_ROCKCHIP_RK322X) +=3D \
>         rk3229-evb.dtb
>
> diff --git a/arch/arm/dts/rk3066a-mk808.dts b/arch/arm/dts/rk3066a-mk808.=
dts
> deleted file mode 100644
> index 06790f05b395..000000000000
> --- a/arch/arm/dts/rk3066a-mk808.dts
> +++ /dev/null
> @@ -1,241 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Pawe=C5=82 Jarosz <paweljarosz3691@gmail.com>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/input.h>
> -#include "rk3066a.dtsi"
> -
> -/ {
> -       model =3D "Rikomagic MK808";
> -       compatible =3D "rikomagic,mk808", "rockchip,rk3066a";
> -
> -       aliases {
> -               mmc0 =3D &mmc0;
> -               mmc1 =3D &mmc1;
> -       };
> -
> -       chosen {
> -               stdout-path =3D "serial2:115200n8";
> -       };
> -
> -       memory@60000000 {
> -               reg =3D <0x60000000 0x40000000>;
> -               device_type =3D "memory";
> -       };
> -
> -       adc-keys {
> -               compatible =3D "adc-keys";
> -               io-channels =3D <&saradc 1>;
> -               io-channel-names =3D "buttons";
> -               keyup-threshold-microvolt =3D <2500000>;
> -               poll-interval =3D <100>;
> -
> -               button-recovery {
> -                       label =3D "recovery";
> -                       linux,code =3D <KEY_VENDOR>;
> -                       press-threshold-microvolt =3D <0>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible =3D "gpio-leds";
> -
> -               blue_led: led-0 {
> -                       label =3D "mk808:blue:power";
> -                       gpios =3D <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
> -                       default-state =3D "off";
> -                       linux,default-trigger =3D "default-on";
> -               };
> -       };
> -
> -       hdmi_con {
> -               compatible =3D "hdmi-connector";
> -               type =3D "c";
> -
> -               port {
> -                       hdmi_con_in: endpoint {
> -                               remote-endpoint =3D <&hdmi_out_con>;
> -                       };
> -               };
> -       };
> -
> -       vcc_2v5: vcc-2v5 {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "vcc_2v5";
> -               regulator-min-microvolt =3D <2500000>;
> -               regulator-max-microvolt =3D <2500000>;
> -       };
> -
> -       vcc_io: vcc-io {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "vcc_io";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -       };
> -
> -       vcc_host: usb-host-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpio =3D <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> -               pinctrl-0 =3D <&host_drv>;
> -               pinctrl-names =3D "default";
> -               regulator-always-on;
> -               regulator-name =3D "host-pwr";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -               startup-delay-us =3D <100000>;
> -               vin-supply =3D <&vcc_io>;
> -       };
> -
> -       vcc_otg: usb-otg-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpio =3D <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> -               pinctrl-0 =3D <&otg_drv>;
> -               pinctrl-names =3D "default";
> -               regulator-always-on;
> -               regulator-name =3D "vcc_otg";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -               startup-delay-us =3D <100000>;
> -               vin-supply =3D <&vcc_io>;
> -       };
> -
> -       vcc_sd: sdmmc-regulator {
> -               compatible =3D "regulator-fixed";
> -               gpio =3D <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
> -               pinctrl-0 =3D <&sdmmc_pwr>;
> -               pinctrl-names =3D "default";
> -               regulator-name =3D "vcc_sd";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -               startup-delay-us =3D <100000>;
> -               vin-supply =3D <&vcc_io>;
> -       };
> -
> -       vcc_wifi: sdio-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpio =3D <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
> -               pinctrl-0 =3D <&wifi_pwr>;
> -               pinctrl-names =3D "default";
> -               regulator-name =3D "vcc_wifi";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -               startup-delay-us =3D <100000>;
> -               vin-supply =3D <&vcc_io>;
> -       };
> -};
> -
> -&hdmi {
> -       status =3D "okay";
> -};
> -
> -&hdmi_in_vop1 {
> -       status =3D "disabled";
> -};
> -
> -&hdmi_out {
> -       hdmi_out_con: endpoint {
> -               remote-endpoint =3D <&hdmi_con_in>;
> -       };
> -};
> -
> -&mmc0 {
> -       bus-width =3D <4>;
> -       cap-mmc-highspeed;
> -       cap-sd-highspeed;
> -       vmmc-supply =3D <&vcc_sd>;
> -       status =3D "okay";
> -};
> -
> -&mmc1 {
> -       bus-width =3D <4>;
> -       non-removable;
> -       pinctrl-0 =3D <&sd1_clk &sd1_cmd &sd1_bus4>;
> -       pinctrl-names =3D "default";
> -       vmmc-supply =3D <&vcc_wifi>;
> -       #address-cells =3D <1>;
> -       #size-cells =3D <0>;
> -       status =3D "okay";
> -
> -       brcmf: wifi@1 {
> -               compatible =3D "brcm,bcm4329-fmac";
> -               reg =3D <1>;
> -       };
> -};
> -
> -&nfc {
> -       #address-cells =3D <1>;
> -       #size-cells =3D <0>;
> -       status =3D "okay";
> -
> -       nand@0 {
> -               reg =3D <0>;
> -               label =3D "rk-nand";
> -               nand-bus-width =3D <8>;
> -               nand-ecc-mode =3D "hw";
> -               nand-ecc-step-size =3D <1024>;
> -               nand-ecc-strength =3D <40>;
> -               nand-is-boot-medium;
> -               rockchip,boot-blks =3D <8>;
> -               rockchip,boot-ecc-strength =3D <24>;
> -       };
> -};
> -
> -&pinctrl {
> -       usb-host {
> -               host_drv: host-drv {
> -                       rockchip,pins =3D <0 RK_PA6 RK_FUNC_GPIO &pcfg_pu=
ll_default>;
> -               };
> -       };
> -
> -       usb-otg {
> -               otg_drv: otg-drv {
> -                       rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO &pcfg_pu=
ll_default>;
> -               };
> -       };
> -
> -       sdmmc {
> -               sdmmc_pwr: sdmmc-pwr {
> -                       rockchip,pins =3D <3 RK_PA7 RK_FUNC_GPIO &pcfg_pu=
ll_default>;
> -               };
> -       };
> -
> -       sdio {
> -               wifi_pwr: wifi-pwr {
> -                       rockchip,pins =3D <3 RK_PD0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> -               };
> -       };
> -};
> -
> -&saradc {
> -       vref-supply =3D <&vcc_2v5>;
> -       status =3D "okay";
> -};
> -
> -&uart2 {
> -       status =3D "okay";
> -};
> -
> -&usb_host {
> -       status =3D "okay";
> -};
> -
> -&usb_otg {
> -       status =3D "okay";
> -};
> -
> -&usbphy {
> -       status =3D "okay";
> -};
> -
> -&vop0 {
> -       status =3D "okay";
> -};
> -
> -&wdt {
> -       status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-bo=
ot.dtsi
> index 06f405ca2c5e..d99db7853b59 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -3,26 +3,6 @@
>  #include "rockchip-u-boot.dtsi"
>  #include "rk3xxx-u-boot.dtsi"
>
> -&gpio0 {
> -       gpio-ranges =3D <&pinctrl 0 0 32>;
> -};
> -
> -&gpio1 {
> -       gpio-ranges =3D <&pinctrl 0 32 32>;
> -};
> -
> -&gpio2 {
> -       gpio-ranges =3D <&pinctrl 0 64 32>;
> -};
> -
> -&gpio3 {
> -       gpio-ranges =3D <&pinctrl 0 96 32>;
> -};
> -
> -&gpio4 {
> -       gpio-ranges =3D <&pinctrl 0 128 32>;
> -};
> -
>  &gpio6 {
>         status =3D "disabled";
>  };
> diff --git a/arch/arm/dts/rk3066a.dtsi b/arch/arm/dts/rk3066a.dtsi
> deleted file mode 100644
> index de9915d946f7..000000000000
> --- a/arch/arm/dts/rk3066a.dtsi
> +++ /dev/null
> @@ -1,880 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3066a-cru.h>
> -#include <dt-bindings/power/rk3066-power.h>
> -#include "rk3xxx.dtsi"
> -
> -/ {
> -       compatible =3D "rockchip,rk3066a";
> -
> -       cpus {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               enable-method =3D "rockchip,rk3066-smp";
> -
> -               cpu0: cpu@0 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x0>;
> -                       operating-points =3D
> -                               /* kHz    uV */
> -                               <1416000 1300000>,
> -                               <1200000 1175000>,
> -                               <1008000 1125000>,
> -                               <816000  1125000>,
> -                               <600000  1100000>,
> -                               <504000  1100000>,
> -                               <312000  1075000>;
> -                       clock-latency =3D <40000>;
> -                       clocks =3D <&cru ARMCLK>;
> -               };
> -               cpu1: cpu@1 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x1>;
> -               };
> -       };
> -
> -       display-subsystem {
> -               compatible =3D "rockchip,display-subsystem";
> -               ports =3D <&vop0_out>, <&vop1_out>;
> -       };
> -
> -       sram: sram@10080000 {
> -               compatible =3D "mmio-sram";
> -               reg =3D <0x10080000 0x10000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0x10080000 0x10000>;
> -
> -               smp-sram@0 {
> -                       compatible =3D "rockchip,rk3066-smp-sram";
> -                       reg =3D <0x0 0x50>;
> -               };
> -       };
> -
> -       vop0: vop@1010c000 {
> -               compatible =3D "rockchip,rk3066-vop";
> -               reg =3D <0x1010c000 0x19c>;
> -               interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru ACLK_LCDC0>,
> -                        <&cru DCLK_LCDC0>,
> -                        <&cru HCLK_LCDC0>;
> -               clock-names =3D "aclk_vop", "dclk_vop", "hclk_vop";
> -               power-domains =3D <&power RK3066_PD_VIO>;
> -               resets =3D <&cru SRST_LCDC0_AXI>,
> -                        <&cru SRST_LCDC0_AHB>,
> -                        <&cru SRST_LCDC0_DCLK>;
> -               reset-names =3D "axi", "ahb", "dclk";
> -               status =3D "disabled";
> -
> -               vop0_out: port {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -
> -                       vop0_out_hdmi: endpoint@0 {
> -                               reg =3D <0>;
> -                               remote-endpoint =3D <&hdmi_in_vop0>;
> -                       };
> -               };
> -       };
> -
> -       vop1: vop@1010e000 {
> -               compatible =3D "rockchip,rk3066-vop";
> -               reg =3D <0x1010e000 0x19c>;
> -               interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru ACLK_LCDC1>,
> -                        <&cru DCLK_LCDC1>,
> -                        <&cru HCLK_LCDC1>;
> -               clock-names =3D "aclk_vop", "dclk_vop", "hclk_vop";
> -               power-domains =3D <&power RK3066_PD_VIO>;
> -               resets =3D <&cru SRST_LCDC1_AXI>,
> -                        <&cru SRST_LCDC1_AHB>,
> -                        <&cru SRST_LCDC1_DCLK>;
> -               reset-names =3D "axi", "ahb", "dclk";
> -               status =3D "disabled";
> -
> -               vop1_out: port {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -
> -                       vop1_out_hdmi: endpoint@0 {
> -                               reg =3D <0>;
> -                               remote-endpoint =3D <&hdmi_in_vop1>;
> -                       };
> -               };
> -       };
> -
> -       hdmi: hdmi@10116000 {
> -               compatible =3D "rockchip,rk3066-hdmi";
> -               reg =3D <0x10116000 0x2000>;
> -               interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_HDMI>;
> -               clock-names =3D "hclk";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&hdmii2c_xfer>, <&hdmi_hpd>;
> -               power-domains =3D <&power RK3066_PD_VIO>;
> -               rockchip,grf =3D <&grf>;
> -               status =3D "disabled";
> -
> -               ports {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -
> -                       hdmi_in: port@0 {
> -                               reg =3D <0>;
> -                               #address-cells =3D <1>;
> -                               #size-cells =3D <0>;
> -
> -                               hdmi_in_vop0: endpoint@0 {
> -                                       reg =3D <0>;
> -                                       remote-endpoint =3D <&vop0_out_hd=
mi>;
> -                               };
> -
> -                               hdmi_in_vop1: endpoint@1 {
> -                                       reg =3D <1>;
> -                                       remote-endpoint =3D <&vop1_out_hd=
mi>;
> -                               };
> -                       };
> -
> -                       hdmi_out: port@1 {
> -                               reg =3D <1>;
> -                       };
> -               };
> -       };
> -
> -       i2s0: i2s@10118000 {
> -               compatible =3D "rockchip,rk3066-i2s";
> -               reg =3D <0x10118000 0x2000>;
> -               interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&i2s0_bus>;
> -               clocks =3D <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
> -               clock-names =3D "i2s_clk", "i2s_hclk";
> -               dmas =3D <&dmac1_s 4>, <&dmac1_s 5>;
> -               dma-names =3D "tx", "rx";
> -               rockchip,playback-channels =3D <8>;
> -               rockchip,capture-channels =3D <2>;
> -               #sound-dai-cells =3D <0>;
> -               status =3D "disabled";
> -       };
> -
> -       i2s1: i2s@1011a000 {
> -               compatible =3D "rockchip,rk3066-i2s";
> -               reg =3D <0x1011a000 0x2000>;
> -               interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&i2s1_bus>;
> -               clocks =3D <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
> -               clock-names =3D "i2s_clk", "i2s_hclk";
> -               dmas =3D <&dmac1_s 6>, <&dmac1_s 7>;
> -               dma-names =3D "tx", "rx";
> -               rockchip,playback-channels =3D <2>;
> -               rockchip,capture-channels =3D <2>;
> -               #sound-dai-cells =3D <0>;
> -               status =3D "disabled";
> -       };
> -
> -       i2s2: i2s@1011c000 {
> -               compatible =3D "rockchip,rk3066-i2s";
> -               reg =3D <0x1011c000 0x2000>;
> -               interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&i2s2_bus>;
> -               clocks =3D <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
> -               clock-names =3D "i2s_clk", "i2s_hclk";
> -               dmas =3D <&dmac1_s 9>, <&dmac1_s 10>;
> -               dma-names =3D "tx", "rx";
> -               rockchip,playback-channels =3D <2>;
> -               rockchip,capture-channels =3D <2>;
> -               #sound-dai-cells =3D <0>;
> -               status =3D "disabled";
> -       };
> -
> -       cru: clock-controller@20000000 {
> -               compatible =3D "rockchip,rk3066a-cru";
> -               reg =3D <0x20000000 0x1000>;
> -               clocks =3D <&xin24m>;
> -               clock-names =3D "xin24m";
> -               rockchip,grf =3D <&grf>;
> -               #clock-cells =3D <1>;
> -               #reset-cells =3D <1>;
> -               assigned-clocks =3D <&cru PLL_CPLL>, <&cru PLL_GPLL>,
> -                                 <&cru ACLK_CPU>, <&cru HCLK_CPU>,
> -                                 <&cru PCLK_CPU>, <&cru ACLK_PERI>,
> -                                 <&cru HCLK_PERI>, <&cru PCLK_PERI>;
> -               assigned-clock-rates =3D <400000000>, <594000000>,
> -                                      <300000000>, <150000000>,
> -                                      <75000000>, <300000000>,
> -                                      <150000000>, <75000000>;
> -       };
> -
> -       timer2: timer@2000e000 {
> -               compatible =3D "snps,dw-apb-timer";
> -               reg =3D <0x2000e000 0x100>;
> -               interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
> -               clock-names =3D "timer", "pclk";
> -       };
> -
> -       efuse: efuse@20010000 {
> -               compatible =3D "rockchip,rk3066a-efuse";
> -               reg =3D <0x20010000 0x4000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               clocks =3D <&cru PCLK_EFUSE>;
> -               clock-names =3D "pclk_efuse";
> -
> -               cpu_leakage: cpu_leakage@17 {
> -                       reg =3D <0x17 0x1>;
> -               };
> -       };
> -
> -       timer0: timer@20038000 {
> -               compatible =3D "snps,dw-apb-timer";
> -               reg =3D <0x20038000 0x100>;
> -               interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
> -               clock-names =3D "timer", "pclk";
> -       };
> -
> -       timer1: timer@2003a000 {
> -               compatible =3D "snps,dw-apb-timer";
> -               reg =3D <0x2003a000 0x100>;
> -               interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
> -               clock-names =3D "timer", "pclk";
> -       };
> -
> -       tsadc: tsadc@20060000 {
> -               compatible =3D "rockchip,rk3066-tsadc";
> -               reg =3D <0x20060000 0x100>;
> -               clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> -               clock-names =3D "saradc", "apb_pclk";
> -               interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> -               #io-channel-cells =3D <1>;
> -               resets =3D <&cru SRST_TSADC>;
> -               reset-names =3D "saradc-apb";
> -               status =3D "disabled";
> -       };
> -
> -       pinctrl: pinctrl {
> -               compatible =3D "rockchip,rk3066a-pinctrl";
> -               rockchip,grf =3D <&grf>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges;
> -
> -               gpio0: gpio@20034000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x20034000 0x100>;
> -                       interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO0>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio1: gpio@2003c000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x2003c000 0x100>;
> -                       interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO1>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio2: gpio@2003e000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x2003e000 0x100>;
> -                       interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO2>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio3: gpio@20080000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x20080000 0x100>;
> -                       interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO3>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio4: gpio@20084000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x20084000 0x100>;
> -                       interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO4>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio6: gpio@2000a000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x2000a000 0x100>;
> -                       interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO6>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               pcfg_pull_default: pcfg-pull-default {
> -                       bias-pull-pin-default;
> -               };
> -
> -               pcfg_pull_none: pcfg-pull-none {
> -                       bias-disable;
> -               };
> -
> -               emac {
> -                       emac_xfer: emac-xfer {
> -                               rockchip,pins =3D <1 RK_PC0 2 &pcfg_pull_=
none>, /* mac_clk */
> -                                               <1 RK_PC1 2 &pcfg_pull_no=
ne>, /* tx_en */
> -                                               <1 RK_PC2 2 &pcfg_pull_no=
ne>, /* txd1 */
> -                                               <1 RK_PC3 2 &pcfg_pull_no=
ne>, /* txd0 */
> -                                               <1 RK_PC4 2 &pcfg_pull_no=
ne>, /* rx_err */
> -                                               <1 RK_PC5 2 &pcfg_pull_no=
ne>, /* crs_dvalid */
> -                                               <1 RK_PC6 2 &pcfg_pull_no=
ne>, /* rxd1 */
> -                                               <1 RK_PC7 2 &pcfg_pull_no=
ne>; /* rxd0 */
> -                       };
> -
> -                       emac_mdio: emac-mdio {
> -                               rockchip,pins =3D <1 RK_PD0 2 &pcfg_pull_=
none>, /* mac_md */
> -                                               <1 RK_PD1 2 &pcfg_pull_no=
ne>; /* mac_mdclk */
> -                       };
> -               };
> -
> -               emmc {
> -                       emmc_clk: emmc-clk {
> -                               rockchip,pins =3D <3 RK_PD7 2 &pcfg_pull_=
default>;
> -                       };
> -
> -                       emmc_cmd: emmc-cmd {
> -                               rockchip,pins =3D <4 RK_PB1 2 &pcfg_pull_=
default>;
> -                       };
> -
> -                       emmc_rst: emmc-rst {
> -                               rockchip,pins =3D <4 RK_PB2 2 &pcfg_pull_=
default>;
> -                       };
> -
> -                       /*
> -                        * The data pins are shared between nandc and emm=
c and
> -                        * not accessible through pinctrl. Also they shou=
ld've
> -                        * been already set correctly by firmware, as
> -                        * flash/emmc is the boot-device.
> -                        */
> -               };
> -
> -               hdmi {
> -                       hdmi_hpd: hdmi-hpd {
> -                               rockchip,pins =3D <0 RK_PA0 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       hdmii2c_xfer: hdmii2c-xfer {
> -                               rockchip,pins =3D <0 RK_PA1 1 &pcfg_pull_=
none>,
> -                                               <0 RK_PA2 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c0 {
> -                       i2c0_xfer: i2c0-xfer {
> -                               rockchip,pins =3D <2 RK_PD4 1 &pcfg_pull_=
none>,
> -                                               <2 RK_PD5 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c1 {
> -                       i2c1_xfer: i2c1-xfer {
> -                               rockchip,pins =3D <2 RK_PD6 1 &pcfg_pull_=
none>,
> -                                               <2 RK_PD7 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c2 {
> -                       i2c2_xfer: i2c2-xfer {
> -                               rockchip,pins =3D <3 RK_PA0 1 &pcfg_pull_=
none>,
> -                                               <3 RK_PA1 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c3 {
> -                       i2c3_xfer: i2c3-xfer {
> -                               rockchip,pins =3D <3 RK_PA2 2 &pcfg_pull_=
none>,
> -                                               <3 RK_PA3 2 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c4 {
> -                       i2c4_xfer: i2c4-xfer {
> -                               rockchip,pins =3D <3 RK_PA4 1 &pcfg_pull_=
none>,
> -                                               <3 RK_PA5 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               pwm0 {
> -                       pwm0_out: pwm0-out {
> -                               rockchip,pins =3D <0 RK_PA3 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm1 {
> -                       pwm1_out: pwm1-out {
> -                               rockchip,pins =3D <0 RK_PA4 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm2 {
> -                       pwm2_out: pwm2-out {
> -                               rockchip,pins =3D <0 RK_PD6 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm3 {
> -                       pwm3_out: pwm3-out {
> -                               rockchip,pins =3D <0 RK_PD7 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               spi0 {
> -                       spi0_clk: spi0-clk {
> -                               rockchip,pins =3D <1 RK_PA5 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi0_cs0: spi0-cs0 {
> -                               rockchip,pins =3D <1 RK_PA4 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi0_tx: spi0-tx {
> -                               rockchip,pins =3D <1 RK_PA7 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi0_rx: spi0-rx {
> -                               rockchip,pins =3D <1 RK_PA6 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi0_cs1: spi0-cs1 {
> -                               rockchip,pins =3D <4 RK_PB7 1 &pcfg_pull_=
default>;
> -                       };
> -               };
> -
> -               spi1 {
> -                       spi1_clk: spi1-clk {
> -                               rockchip,pins =3D <2 RK_PC3 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi1_cs0: spi1-cs0 {
> -                               rockchip,pins =3D <2 RK_PC4 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi1_rx: spi1-rx {
> -                               rockchip,pins =3D <2 RK_PC6 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi1_tx: spi1-tx {
> -                               rockchip,pins =3D <2 RK_PC5 2 &pcfg_pull_=
default>;
> -                       };
> -                       spi1_cs1: spi1-cs1 {
> -                               rockchip,pins =3D <2 RK_PC7 2 &pcfg_pull_=
default>;
> -                       };
> -               };
> -
> -               uart0 {
> -                       uart0_xfer: uart0-xfer {
> -                               rockchip,pins =3D <1 RK_PA0 1 &pcfg_pull_=
default>,
> -                                               <1 RK_PA1 1 &pcfg_pull_de=
fault>;
> -                       };
> -
> -                       uart0_cts: uart0-cts {
> -                               rockchip,pins =3D <1 RK_PA2 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       uart0_rts: uart0-rts {
> -                               rockchip,pins =3D <1 RK_PA3 1 &pcfg_pull_=
default>;
> -                       };
> -               };
> -
> -               uart1 {
> -                       uart1_xfer: uart1-xfer {
> -                               rockchip,pins =3D <1 RK_PA4 1 &pcfg_pull_=
default>,
> -                                               <1 RK_PA5 1 &pcfg_pull_de=
fault>;
> -                       };
> -
> -                       uart1_cts: uart1-cts {
> -                               rockchip,pins =3D <1 RK_PA6 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       uart1_rts: uart1-rts {
> -                               rockchip,pins =3D <1 RK_PA7 1 &pcfg_pull_=
default>;
> -                       };
> -               };
> -
> -               uart2 {
> -                       uart2_xfer: uart2-xfer {
> -                               rockchip,pins =3D <1 RK_PB0 1 &pcfg_pull_=
default>,
> -                                               <1 RK_PB1 1 &pcfg_pull_de=
fault>;
> -                       };
> -                       /* no rts / cts for uart2 */
> -               };
> -
> -               uart3 {
> -                       uart3_xfer: uart3-xfer {
> -                               rockchip,pins =3D <3 RK_PD3 1 &pcfg_pull_=
default>,
> -                                               <3 RK_PD4 1 &pcfg_pull_de=
fault>;
> -                       };
> -
> -                       uart3_cts: uart3-cts {
> -                               rockchip,pins =3D <3 RK_PD5 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       uart3_rts: uart3-rts {
> -                               rockchip,pins =3D <3 RK_PD6 1 &pcfg_pull_=
default>;
> -                       };
> -               };
> -
> -               sd0 {
> -                       sd0_clk: sd0-clk {
> -                               rockchip,pins =3D <3 RK_PB0 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd0_cmd: sd0-cmd {
> -                               rockchip,pins =3D <3 RK_PB1 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd0_cd: sd0-cd {
> -                               rockchip,pins =3D <3 RK_PB6 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd0_wp: sd0-wp {
> -                               rockchip,pins =3D <3 RK_PB7 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd0_bus1: sd0-bus-width1 {
> -                               rockchip,pins =3D <3 RK_PB2 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd0_bus4: sd0-bus-width4 {
> -                               rockchip,pins =3D <3 RK_PB2 1 &pcfg_pull_=
default>,
> -                                               <3 RK_PB3 1 &pcfg_pull_de=
fault>,
> -                                               <3 RK_PB4 1 &pcfg_pull_de=
fault>,
> -                                               <3 RK_PB5 1 &pcfg_pull_de=
fault>;
> -                       };
> -               };
> -
> -               sd1 {
> -                       sd1_clk: sd1-clk {
> -                               rockchip,pins =3D <3 RK_PC5 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd1_cmd: sd1-cmd {
> -                               rockchip,pins =3D <3 RK_PC0 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd1_cd: sd1-cd {
> -                               rockchip,pins =3D <3 RK_PC6 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd1_wp: sd1-wp {
> -                               rockchip,pins =3D <3 RK_PC7 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd1_bus1: sd1-bus-width1 {
> -                               rockchip,pins =3D <3 RK_PC1 1 &pcfg_pull_=
default>;
> -                       };
> -
> -                       sd1_bus4: sd1-bus-width4 {
> -                               rockchip,pins =3D <3 RK_PC1 1 &pcfg_pull_=
default>,
> -                                               <3 RK_PC2 1 &pcfg_pull_de=
fault>,
> -                                               <3 RK_PC3 1 &pcfg_pull_de=
fault>,
> -                                               <3 RK_PC4 1 &pcfg_pull_de=
fault>;
> -                       };
> -               };
> -
> -               i2s0 {
> -                       i2s0_bus: i2s0-bus {
> -                               rockchip,pins =3D <0 RK_PA7 1 &pcfg_pull_=
default>,
> -                                               <0 RK_PB0 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB1 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB2 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB3 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB4 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB5 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB6 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PB7 1 &pcfg_pull_de=
fault>;
> -                       };
> -               };
> -
> -               i2s1 {
> -                       i2s1_bus: i2s1-bus {
> -                               rockchip,pins =3D <0 RK_PC0 1 &pcfg_pull_=
default>,
> -                                               <0 RK_PC1 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PC2 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PC3 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PC4 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PC5 1 &pcfg_pull_de=
fault>;
> -                       };
> -               };
> -
> -               i2s2 {
> -                       i2s2_bus: i2s2-bus {
> -                               rockchip,pins =3D <0 RK_PD0 1 &pcfg_pull_=
default>,
> -                                               <0 RK_PD1 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PD2 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PD3 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PD4 1 &pcfg_pull_de=
fault>,
> -                                               <0 RK_PD5 1 &pcfg_pull_de=
fault>;
> -                       };
> -               };
> -       };
> -};
> -
> -&gpu {
> -       compatible =3D "rockchip,rk3066-mali", "arm,mali-400";
> -       interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -       interrupt-names =3D "gp",
> -                         "gpmmu",
> -                         "pp0",
> -                         "ppmmu0",
> -                         "pp1",
> -                         "ppmmu1",
> -                         "pp2",
> -                         "ppmmu2",
> -                         "pp3",
> -                         "ppmmu3";
> -       power-domains =3D <&power RK3066_PD_GPU>;
> -};
> -
> -&grf {
> -       compatible =3D "rockchip,rk3066-grf", "syscon", "simple-mfd";
> -
> -       usbphy: usbphy {
> -               compatible =3D "rockchip,rk3066a-usb-phy";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               status =3D "disabled";
> -
> -               usbphy0: usb-phy@17c {
> -                       reg =3D <0x17c>;
> -                       clocks =3D <&cru SCLK_OTGPHY0>;
> -                       clock-names =3D "phyclk";
> -                       #clock-cells =3D <0>;
> -                       #phy-cells =3D <0>;
> -               };
> -
> -               usbphy1: usb-phy@188 {
> -                       reg =3D <0x188>;
> -                       clocks =3D <&cru SCLK_OTGPHY1>;
> -                       clock-names =3D "phyclk";
> -                       #clock-cells =3D <0>;
> -                       #phy-cells =3D <0>;
> -               };
> -       };
> -};
> -
> -&i2c0 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c0_xfer>;
> -};
> -
> -&i2c1 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c1_xfer>;
> -};
> -
> -&i2c2 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c2_xfer>;
> -};
> -
> -&i2c3 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c3_xfer>;
> -};
> -
> -&i2c4 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c4_xfer>;
> -};
> -
> -&mmc0 {
> -       clock-frequency =3D <50000000>;
> -       dmas =3D <&dmac2 1>;
> -       dma-names =3D "rx-tx";
> -       max-frequency =3D <50000000>;
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
> -};
> -
> -&mmc1 {
> -       dmas =3D <&dmac2 3>;
> -       dma-names =3D "rx-tx";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
> -};
> -
> -&emmc {
> -       dmas =3D <&dmac2 4>;
> -       dma-names =3D "rx-tx";
> -};
> -
> -&pmu {
> -       power: power-controller {
> -               compatible =3D "rockchip,rk3066-power-controller";
> -               #power-domain-cells =3D <1>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               power-domain@RK3066_PD_VIO {
> -                       reg =3D <RK3066_PD_VIO>;
> -                       clocks =3D <&cru ACLK_LCDC0>,
> -                                <&cru ACLK_LCDC1>,
> -                                <&cru DCLK_LCDC0>,
> -                                <&cru DCLK_LCDC1>,
> -                                <&cru HCLK_LCDC0>,
> -                                <&cru HCLK_LCDC1>,
> -                                <&cru SCLK_CIF1>,
> -                                <&cru ACLK_CIF1>,
> -                                <&cru HCLK_CIF1>,
> -                                <&cru SCLK_CIF0>,
> -                                <&cru ACLK_CIF0>,
> -                                <&cru HCLK_CIF0>,
> -                                <&cru HCLK_HDMI>,
> -                                <&cru ACLK_IPP>,
> -                                <&cru HCLK_IPP>,
> -                                <&cru ACLK_RGA>,
> -                                <&cru HCLK_RGA>;
> -                       pm_qos =3D <&qos_lcdc0>,
> -                                <&qos_lcdc1>,
> -                                <&qos_cif0>,
> -                                <&qos_cif1>,
> -                                <&qos_ipp>,
> -                                <&qos_rga>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -
> -               power-domain@RK3066_PD_VIDEO {
> -                       reg =3D <RK3066_PD_VIDEO>;
> -                       clocks =3D <&cru ACLK_VDPU>,
> -                                <&cru ACLK_VEPU>,
> -                                <&cru HCLK_VDPU>,
> -                                <&cru HCLK_VEPU>;
> -                       pm_qos =3D <&qos_vpu>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -
> -               power-domain@RK3066_PD_GPU {
> -                       reg =3D <RK3066_PD_GPU>;
> -                       clocks =3D <&cru ACLK_GPU>;
> -                       pm_qos =3D <&qos_gpu>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -       };
> -};
> -
> -&pwm0 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm0_out>;
> -};
> -
> -&pwm1 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm1_out>;
> -};
> -
> -&pwm2 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm2_out>;
> -};
> -
> -&pwm3 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm3_out>;
> -};
> -
> -&spi0 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -};
> -
> -&spi1 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -};
> -
> -&uart0 {
> -       compatible =3D "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -       dmas =3D <&dmac1_s 0>, <&dmac1_s 1>;
> -       dma-names =3D "tx", "rx";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart0_xfer>;
> -};
> -
> -&uart1 {
> -       compatible =3D "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -       dmas =3D <&dmac1_s 2>, <&dmac1_s 3>;
> -       dma-names =3D "tx", "rx";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart1_xfer>;
> -};
> -
> -&uart2 {
> -       compatible =3D "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -       dmas =3D <&dmac2 6>, <&dmac2 7>;
> -       dma-names =3D "tx", "rx";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart2_xfer>;
> -};
> -
> -&uart3 {
> -       compatible =3D "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -       dmas =3D <&dmac2 8>, <&dmac2 9>;
> -       dma-names =3D "tx", "rx";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart3_xfer>;
> -};
> -
> -&vpu {
> -       power-domains =3D <&power RK3066_PD_VIDEO>;
> -};
> -
> -&wdt {
> -       compatible =3D "rockchip,rk3066-wdt", "snps,dw-wdt";
> -};
> -
> -&emac {
> -       compatible =3D "rockchip,rk3066-emac";
> -};
> diff --git a/arch/arm/dts/rk3188-radxarock.dts b/arch/arm/dts/rk3188-radx=
arock.dts
> deleted file mode 100644
> index 118deacd38c4..000000000000
> --- a/arch/arm/dts/rk3188-radxarock.dts
> +++ /dev/null
> @@ -1,389 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/input.h>
> -#include "rk3188.dtsi"
> -
> -/ {
> -       model =3D "Radxa Rock";
> -       compatible =3D "radxa,rock", "rockchip,rk3188";
> -
> -       aliases {
> -               mmc0 =3D &mmc0;
> -       };
> -
> -       memory@60000000 {
> -               device_type =3D "memory";
> -               reg =3D <0x60000000 0x80000000>;
> -       };
> -
> -       gpio-keys {
> -               compatible =3D "gpio-keys";
> -               autorepeat;
> -
> -               key-power {
> -                       gpios =3D <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -                       linux,code =3D <KEY_POWER>;
> -                       label =3D "GPIO Key Power";
> -                       linux,input-type =3D <1>;
> -                       wakeup-source;
> -                       debounce-interval =3D <100>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible =3D "gpio-leds";
> -
> -               green_led: led-0 {
> -                       label =3D "rock:green:user1";
> -                       gpios =3D <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
> -                       default-state =3D "off";
> -               };
> -
> -               blue_led: led-1 {
> -                       label =3D "rock:blue:user2";
> -                       gpios =3D <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> -                       default-state =3D "off";
> -               };
> -
> -               sleep_led: led-2 {
> -                       label =3D "rock:red:power";
> -                       gpios =3D <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> -                       default-state =3D "off";
> -               };
> -       };
> -
> -       sound {
> -               compatible =3D "simple-audio-card";
> -               simple-audio-card,name =3D "SPDIF";
> -
> -               simple-audio-card,dai-link@1 {  /* S/PDIF - S/PDIF */
> -                       cpu { sound-dai =3D <&spdif>; };
> -                       codec { sound-dai =3D <&spdif_out>; };
> -               };
> -       };
> -
> -       spdif_out: spdif-out {
> -               compatible =3D "linux,spdif-dit";
> -               #sound-dai-cells =3D <0>;
> -       };
> -
> -       ir_recv: ir-receiver {
> -               compatible =3D "gpio-ir-receiver";
> -               gpios =3D <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&ir_recv_pin>;
> -       };
> -
> -       vcc_otg: usb-otg-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpio =3D <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&otg_vbus_drv>;
> -               regulator-name =3D "otg-vbus";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vcc_sd0: sdmmc-regulator {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "sdmmc-supply";
> -               regulator-min-microvolt =3D <3300000>;
> -               regulator-max-microvolt =3D <3300000>;
> -               gpio =3D <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&sdmmc_pwr>;
> -               startup-delay-us =3D <100000>;
> -               vin-supply =3D <&vcc_io>;
> -       };
> -
> -       vcc_host: usb-host-regulator {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               gpio =3D <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&host_vbus_drv>;
> -               regulator-name =3D "host-pwr";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -               regulator-always-on;
> -               regulator-boot-on;
> -       };
> -
> -       vsys: vsys-regulator {
> -               compatible =3D "regulator-fixed";
> -               regulator-name =3D "vsys";
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -               regulator-boot-on;
> -       };
> -};
> -
> -&emac {
> -       phy =3D <&phy0>;
> -       phy-supply =3D <&vcc_rmii>;
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&emac_xfer>, <&emac_mdio>, <&phy_int>;
> -       status =3D "okay";
> -
> -       mdio {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               phy0: ethernet-phy@0 {
> -                       reg =3D <0>;
> -                       interrupt-parent =3D <&gpio3>;
> -                       interrupts =3D <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
> -               };
> -       };
> -};
> -
> -&cpu0 {
> -       cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu1 {
> -       cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu2 {
> -       cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu3 {
> -       cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&gpu {
> -       status =3D "okay";
> -};
> -
> -&i2c1 {
> -       status =3D "okay";
> -       clock-frequency =3D <400000>;
> -
> -       rtc@51 {
> -               compatible =3D "haoyu,hym8563";
> -               reg =3D <0x51>;
> -               interrupt-parent =3D <&gpio0>;
> -               interrupts =3D <RK_PB5 IRQ_TYPE_EDGE_FALLING>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&rtc_int>;
> -               #clock-cells =3D <0>;
> -               clock-output-names =3D "xin32k";
> -       };
> -
> -       act8846: act8846@5a {
> -               compatible =3D "active-semi,act8846";
> -               reg =3D <0x5a>;
> -               status =3D "okay";
> -               system-power-controller;
> -
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&act8846_dvs0_ctl>;
> -
> -               vp1-supply =3D <&vsys>;
> -               vp2-supply =3D <&vsys>;
> -               vp3-supply =3D <&vsys>;
> -               vp4-supply =3D <&vsys>;
> -               inl1-supply =3D <&vcc_io>;
> -               inl2-supply =3D <&vsys>;
> -               inl3-supply =3D <&vsys>;
> -
> -               regulators {
> -                       vcc_ddr: REG1 {
> -                               regulator-name =3D "VCC_DDR";
> -                               regulator-min-microvolt =3D <1200000>;
> -                               regulator-max-microvolt =3D <1200000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdd_log: REG2 {
> -                               regulator-name =3D "VDD_LOG";
> -                               regulator-min-microvolt =3D <1000000>;
> -                               regulator-max-microvolt =3D <1000000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdd_arm: REG3 {
> -                               regulator-name =3D "VDD_ARM";
> -                               regulator-min-microvolt =3D <875000>;
> -                               regulator-max-microvolt =3D <1350000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcc_io: REG4 {
> -                               regulator-name =3D "VCC_IO";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdd_10: REG5 {
> -                               regulator-name =3D "VDD_10";
> -                               regulator-min-microvolt =3D <1000000>;
> -                               regulator-max-microvolt =3D <1000000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdd_hdmi: REG6 {
> -                               regulator-name =3D "VDD_HDMI";
> -                               regulator-min-microvolt =3D <2500000>;
> -                               regulator-max-microvolt =3D <2500000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcc18: REG7 {
> -                               regulator-name =3D "VCC_18";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcca_33: REG8 {
> -                               regulator-name =3D "VCCA_33";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcc_rmii: REG9 {
> -                               regulator-name =3D "VCC_RMII";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                       };
> -
> -                       vccio_wl: REG10 {
> -                               regulator-name =3D "VCCIO_WL";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcc_18: REG11 {
> -                               regulator-name =3D "VCC18_IO";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vcc28: REG12 {
> -                               regulator-name =3D "VCC_28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-always-on;
> -                       };
> -               };
> -       };
> -};
> -
> -&mmc0 {
> -       status =3D "okay";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
> -       vmmc-supply =3D <&vcc_sd0>;
> -
> -       bus-width =3D <4>;
> -       cap-mmc-highspeed;
> -       cap-sd-highspeed;
> -       disable-wp;
> -};
> -
> -&pwm1 {
> -       status =3D "okay";
> -};
> -
> -&pwm2 {
> -       status =3D "okay";
> -};
> -
> -&pwm3 {
> -       status =3D "okay";
> -};
> -
> -&pinctrl {
> -       pcfg_output_low: pcfg-output-low {
> -               output-low;
> -       };
> -
> -       act8846 {
> -               act8846_dvs0_ctl: act8846-dvs0-ctl {
> -                       rockchip,pins =3D <3 RK_PD3 RK_FUNC_GPIO &pcfg_ou=
tput_low>;
> -               };
> -       };
> -
> -       hym8563 {
> -               rtc_int: rtc-int {
> -                       rockchip,pins =3D <0 RK_PA0 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> -               };
> -       };
> -
> -       lan8720a  {
> -               phy_int: phy-int {
> -                       rockchip,pins =3D <3 RK_PD2 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> -               };
> -       };
> -
> -       ir-receiver {
> -               ir_recv_pin: ir-recv-pin {
> -                       rockchip,pins =3D <0 RK_PB2 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> -               };
> -       };
> -
> -       sd0 {
> -               sdmmc_pwr: sdmmc-pwr {
> -                       rockchip,pins =3D <3 RK_PA1 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> -               };
> -       };
> -
> -       usb {
> -               host_vbus_drv: host-vbus-drv {
> -                       rockchip,pins =3D <0 RK_PA3 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> -               };
> -               otg_vbus_drv: otg-vbus-drv {
> -                       rockchip,pins =3D <2 RK_PD7 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> -               };
> -       };
> -};
> -
> -&spdif {
> -       status =3D "okay";
> -};
> -
> -&uart0 {
> -       status =3D "okay";
> -};
> -
> -&uart1 {
> -       status =3D "okay";
> -};
> -
> -&uart2 {
> -       status =3D "okay";
> -};
> -
> -&uart3 {
> -       status =3D "okay";
> -};
> -
> -&usbphy {
> -       status =3D "okay";
> -};
> -
> -&usb_host {
> -       status =3D "okay";
> -};
> -
> -&usb_otg {
> -       status =3D "okay";
> -};
> -
> -&wdt {
> -       status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rk3188-u-boot.dtsi b/arch/arm/dts/rk3188-u-boot=
.dtsi
> index 176f9e65c267..8f2849dda241 100644
> --- a/arch/arm/dts/rk3188-u-boot.dtsi
> +++ b/arch/arm/dts/rk3188-u-boot.dtsi
> @@ -6,25 +6,8 @@
>  #include "rockchip-u-boot.dtsi"
>  #include "rk3xxx-u-boot.dtsi"
>
> -&global_timer {
> -       status =3D "okay";
> -};
> -
>  &gpio0 {
>         compatible =3D "rockchip,gpio-bank";
> -       gpio-ranges =3D <&pinctrl 0 0 32>;
> -};
> -
> -&gpio1 {
> -       gpio-ranges =3D <&pinctrl 0 32 32>;
> -};
> -
> -&gpio2 {
> -       gpio-ranges =3D <&pinctrl 0 64 32>;
> -};
> -
> -&gpio3 {
> -       gpio-ranges =3D <&pinctrl 0 96 32>;
>  };
>
>  &pmu {
> diff --git a/arch/arm/dts/rk3188.dtsi b/arch/arm/dts/rk3188.dtsi
> deleted file mode 100644
> index 44b54af0bbf9..000000000000
> --- a/arch/arm/dts/rk3188.dtsi
> +++ /dev/null
> @@ -1,815 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3188-cru.h>
> -#include <dt-bindings/power/rk3188-power.h>
> -#include "rk3xxx.dtsi"
> -
> -/ {
> -       compatible =3D "rockchip,rk3188";
> -
> -       cpus {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               enable-method =3D "rockchip,rk3066-smp";
> -
> -               cpu0: cpu@0 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x0>;
> -                       clock-latency =3D <40000>;
> -                       clocks =3D <&cru ARMCLK>;
> -                       operating-points-v2 =3D <&cpu0_opp_table>;
> -                       resets =3D <&cru SRST_CORE0>;
> -               };
> -               cpu1: cpu@1 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x1>;
> -                       operating-points-v2 =3D <&cpu0_opp_table>;
> -                       resets =3D <&cru SRST_CORE1>;
> -               };
> -               cpu2: cpu@2 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x2>;
> -                       operating-points-v2 =3D <&cpu0_opp_table>;
> -                       resets =3D <&cru SRST_CORE2>;
> -               };
> -               cpu3: cpu@3 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a9";
> -                       next-level-cache =3D <&L2>;
> -                       reg =3D <0x3>;
> -                       operating-points-v2 =3D <&cpu0_opp_table>;
> -                       resets =3D <&cru SRST_CORE3>;
> -               };
> -       };
> -
> -       cpu0_opp_table: opp-table-0 {
> -               compatible =3D "operating-points-v2";
> -               opp-shared;
> -
> -               opp-312000000 {
> -                       opp-hz =3D /bits/ 64 <312000000>;
> -                       opp-microvolt =3D <875000>;
> -                       clock-latency-ns =3D <40000>;
> -               };
> -               opp-504000000 {
> -                       opp-hz =3D /bits/ 64 <504000000>;
> -                       opp-microvolt =3D <925000>;
> -               };
> -               opp-600000000 {
> -                       opp-hz =3D /bits/ 64 <600000000>;
> -                       opp-microvolt =3D <950000>;
> -                       opp-suspend;
> -               };
> -               opp-816000000 {
> -                       opp-hz =3D /bits/ 64 <816000000>;
> -                       opp-microvolt =3D <975000>;
> -               };
> -               opp-1008000000 {
> -                       opp-hz =3D /bits/ 64 <1008000000>;
> -                       opp-microvolt =3D <1075000>;
> -               };
> -               opp-1200000000 {
> -                       opp-hz =3D /bits/ 64 <1200000000>;
> -                       opp-microvolt =3D <1150000>;
> -               };
> -               opp-1416000000 {
> -                       opp-hz =3D /bits/ 64 <1416000000>;
> -                       opp-microvolt =3D <1250000>;
> -               };
> -               opp-1608000000 {
> -                       opp-hz =3D /bits/ 64 <1608000000>;
> -                       opp-microvolt =3D <1350000>;
> -               };
> -       };
> -
> -       display-subsystem {
> -               compatible =3D "rockchip,display-subsystem";
> -               ports =3D <&vop0_out>, <&vop1_out>;
> -       };
> -
> -       sram: sram@10080000 {
> -               compatible =3D "mmio-sram";
> -               reg =3D <0x10080000 0x8000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0x10080000 0x8000>;
> -
> -               smp-sram@0 {
> -                       compatible =3D "rockchip,rk3066-smp-sram";
> -                       reg =3D <0x0 0x50>;
> -               };
> -       };
> -
> -       vop0: vop@1010c000 {
> -               compatible =3D "rockchip,rk3188-vop";
> -               reg =3D <0x1010c000 0x1000>;
> -               interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru ACLK_LCDC0>, <&cru DCLK_LCDC0>, <&cru HC=
LK_LCDC0>;
> -               clock-names =3D "aclk_vop", "dclk_vop", "hclk_vop";
> -               power-domains =3D <&power RK3188_PD_VIO>;
> -               resets =3D <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, =
<&cru SRST_LCDC0_DCLK>;
> -               reset-names =3D "axi", "ahb", "dclk";
> -               status =3D "disabled";
> -
> -               vop0_out: port {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -               };
> -       };
> -
> -       vop1: vop@1010e000 {
> -               compatible =3D "rockchip,rk3188-vop";
> -               reg =3D <0x1010e000 0x1000>;
> -               interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru ACLK_LCDC1>, <&cru DCLK_LCDC1>, <&cru HC=
LK_LCDC1>;
> -               clock-names =3D "aclk_vop", "dclk_vop", "hclk_vop";
> -               power-domains =3D <&power RK3188_PD_VIO>;
> -               resets =3D <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, =
<&cru SRST_LCDC1_DCLK>;
> -               reset-names =3D "axi", "ahb", "dclk";
> -               status =3D "disabled";
> -
> -               vop1_out: port {
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> -               };
> -       };
> -
> -       timer3: timer@2000e000 {
> -               compatible =3D "rockchip,rk3188-timer", "rockchip,rk3288-=
timer";
> -               reg =3D <0x2000e000 0x20>;
> -               interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru PCLK_TIMER3>, <&cru SCLK_TIMER3>;
> -               clock-names =3D "pclk", "timer";
> -       };
> -
> -       timer6: timer@200380a0 {
> -               compatible =3D "rockchip,rk3188-timer", "rockchip,rk3288-=
timer";
> -               reg =3D <0x200380a0 0x20>;
> -               interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru PCLK_TIMER0>, <&cru SCLK_TIMER6>;
> -               clock-names =3D "pclk", "timer";
> -       };
> -
> -       i2s0: i2s@1011a000 {
> -               compatible =3D "rockchip,rk3188-i2s", "rockchip,rk3066-i2=
s";
> -               reg =3D <0x1011a000 0x2000>;
> -               interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&i2s0_bus>;
> -               clocks =3D <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
> -               clock-names =3D "i2s_clk", "i2s_hclk";
> -               dmas =3D <&dmac1_s 6>, <&dmac1_s 7>;
> -               dma-names =3D "tx", "rx";
> -               rockchip,playback-channels =3D <2>;
> -               rockchip,capture-channels =3D <2>;
> -               #sound-dai-cells =3D <0>;
> -               status =3D "disabled";
> -       };
> -
> -       spdif: sound@1011e000 {
> -               compatible =3D "rockchip,rk3188-spdif", "rockchip,rk3066-=
spdif";
> -               reg =3D <0x1011e000 0x2000>;
> -               #sound-dai-cells =3D <0>;
> -               clocks =3D <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
> -               clock-names =3D "mclk", "hclk";
> -               dmas =3D <&dmac1_s 8>;
> -               dma-names =3D "tx";
> -               interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&spdif_tx>;
> -               status =3D "disabled";
> -       };
> -
> -       cru: clock-controller@20000000 {
> -               compatible =3D "rockchip,rk3188-cru";
> -               reg =3D <0x20000000 0x1000>;
> -               clocks =3D <&xin24m>;
> -               clock-names =3D "xin24m";
> -               rockchip,grf =3D <&grf>;
> -               #clock-cells =3D <1>;
> -               #reset-cells =3D <1>;
> -       };
> -
> -       efuse: efuse@20010000 {
> -               compatible =3D "rockchip,rk3188-efuse";
> -               reg =3D <0x20010000 0x4000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               clocks =3D <&cru PCLK_EFUSE>;
> -               clock-names =3D "pclk_efuse";
> -
> -               cpu_leakage: cpu_leakage@17 {
> -                       reg =3D <0x17 0x1>;
> -               };
> -       };
> -
> -       pinctrl: pinctrl {
> -               compatible =3D "rockchip,rk3188-pinctrl";
> -               rockchip,grf =3D <&grf>;
> -               rockchip,pmu =3D <&pmu>;
> -
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges;
> -
> -               gpio0: gpio@2000a000 {
> -                       compatible =3D "rockchip,rk3188-gpio-bank0";
> -                       reg =3D <0x2000a000 0x100>;
> -                       interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO0>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio1: gpio@2003c000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x2003c000 0x100>;
> -                       interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO1>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio2: gpio@2003e000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x2003e000 0x100>;
> -                       interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO2>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio3: gpio@20080000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x20080000 0x100>;
> -                       interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&cru PCLK_GPIO3>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               pcfg_pull_up: pcfg-pull-up {
> -                       bias-pull-up;
> -               };
> -
> -               pcfg_pull_down: pcfg-pull-down {
> -                       bias-pull-down;
> -               };
> -
> -               pcfg_pull_none: pcfg-pull-none {
> -                       bias-disable;
> -               };
> -
> -               emmc {
> -                       emmc_clk: emmc-clk {
> -                               rockchip,pins =3D <0 RK_PD0 2 &pcfg_pull_=
none>;
> -                       };
> -
> -                       emmc_cmd: emmc-cmd {
> -                               rockchip,pins =3D <0 RK_PD2 2 &pcfg_pull_=
up>;
> -                       };
> -
> -                       emmc_rst: emmc-rst {
> -                               rockchip,pins =3D <0 RK_PD3 2 &pcfg_pull_=
none>;
> -                       };
> -
> -                       /*
> -                        * The data pins are shared between nandc and emm=
c and
> -                        * not accessible through pinctrl. Also they shou=
ld've
> -                        * been already set correctly by firmware, as
> -                        * flash/emmc is the boot-device.
> -                        */
> -               };
> -
> -               emac {
> -                       emac_xfer: emac-xfer {
> -                               rockchip,pins =3D <3 RK_PC0 2 &pcfg_pull_=
none>, /* tx_en */
> -                                               <3 RK_PC1 2 &pcfg_pull_no=
ne>, /* txd1 */
> -                                               <3 RK_PC2 2 &pcfg_pull_no=
ne>, /* txd0 */
> -                                               <3 RK_PC3 2 &pcfg_pull_no=
ne>, /* rxd0 */
> -                                               <3 RK_PC4 2 &pcfg_pull_no=
ne>, /* rxd1 */
> -                                               <3 RK_PC5 2 &pcfg_pull_no=
ne>, /* mac_clk */
> -                                               <3 RK_PC6 2 &pcfg_pull_no=
ne>, /* rx_err */
> -                                               <3 RK_PC7 2 &pcfg_pull_no=
ne>; /* crs_dvalid */
> -                       };
> -
> -                       emac_mdio: emac-mdio {
> -                               rockchip,pins =3D <3 RK_PD0 2 &pcfg_pull_=
none>,
> -                                               <3 RK_PD1 2 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c0 {
> -                       i2c0_xfer: i2c0-xfer {
> -                               rockchip,pins =3D <1 RK_PD0 1 &pcfg_pull_=
none>,
> -                                               <1 RK_PD1 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c1 {
> -                       i2c1_xfer: i2c1-xfer {
> -                               rockchip,pins =3D <1 RK_PD2 1 &pcfg_pull_=
none>,
> -                                               <1 RK_PD3 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c2 {
> -                       i2c2_xfer: i2c2-xfer {
> -                               rockchip,pins =3D <1 RK_PD4 1 &pcfg_pull_=
none>,
> -                                               <1 RK_PD5 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c3 {
> -                       i2c3_xfer: i2c3-xfer {
> -                               rockchip,pins =3D <3 RK_PB6 2 &pcfg_pull_=
none>,
> -                                               <3 RK_PB7 2 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2c4 {
> -                       i2c4_xfer: i2c4-xfer {
> -                               rockchip,pins =3D <1 RK_PD6 1 &pcfg_pull_=
none>,
> -                                               <1 RK_PD7 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               lcdc1 {
> -                       lcdc1_dclk: lcdc1-dclk {
> -                               rockchip,pins =3D <2 RK_PD0 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       lcdc1_den: lcdc1-den {
> -                               rockchip,pins =3D <2 RK_PD1 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       lcdc1_hsync: lcdc1-hsync {
> -                               rockchip,pins =3D <2 RK_PD2 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       lcdc1_vsync: lcdc1-vsync {
> -                               rockchip,pins =3D <2 RK_PD3 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       lcdc1_rgb24: lcdc1-rgb24 {
> -                               rockchip,pins =3D <2 RK_PA0 1 &pcfg_pull_=
none>,
> -                                               <2 RK_PA1 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA2 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA3 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA4 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA5 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA6 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PA7 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB0 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB1 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB2 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB3 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB4 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB5 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB6 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PB7 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC0 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC1 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC2 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC3 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC4 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC5 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC6 1 &pcfg_pull_no=
ne>,
> -                                               <2 RK_PC7 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               pwm0 {
> -                       pwm0_out: pwm0-out {
> -                               rockchip,pins =3D <3 RK_PD3 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm1 {
> -                       pwm1_out: pwm1-out {
> -                               rockchip,pins =3D <3 RK_PD4 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm2 {
> -                       pwm2_out: pwm2-out {
> -                               rockchip,pins =3D <3 RK_PD5 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               pwm3 {
> -                       pwm3_out: pwm3-out {
> -                               rockchip,pins =3D <3 RK_PD6 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               spi0 {
> -                       spi0_clk: spi0-clk {
> -                               rockchip,pins =3D <1 RK_PA6 2 &pcfg_pull_=
up>;
> -                       };
> -                       spi0_cs0: spi0-cs0 {
> -                               rockchip,pins =3D <1 RK_PA7 2 &pcfg_pull_=
up>;
> -                       };
> -                       spi0_tx: spi0-tx {
> -                               rockchip,pins =3D <1 RK_PA5 2 &pcfg_pull_=
up>;
> -                       };
> -                       spi0_rx: spi0-rx {
> -                               rockchip,pins =3D <1 RK_PA4 2 &pcfg_pull_=
up>;
> -                       };
> -                       spi0_cs1: spi0-cs1 {
> -                               rockchip,pins =3D <1 RK_PB7 1 &pcfg_pull_=
up>;
> -                       };
> -               };
> -
> -               spi1 {
> -                       spi1_clk: spi1-clk {
> -                               rockchip,pins =3D <0 RK_PD6 1 &pcfg_pull_=
up>;
> -                       };
> -                       spi1_cs0: spi1-cs0 {
> -                               rockchip,pins =3D <0 RK_PD7 1 &pcfg_pull_=
up>;
> -                       };
> -                       spi1_rx: spi1-rx {
> -                               rockchip,pins =3D <0 RK_PD4 1 &pcfg_pull_=
up>;
> -                       };
> -                       spi1_tx: spi1-tx {
> -                               rockchip,pins =3D <0 RK_PD5 1 &pcfg_pull_=
up>;
> -                       };
> -                       spi1_cs1: spi1-cs1 {
> -                               rockchip,pins =3D <1 RK_PB6 2 &pcfg_pull_=
up>;
> -                       };
> -               };
> -
> -               uart0 {
> -                       uart0_xfer: uart0-xfer {
> -                               rockchip,pins =3D <1 RK_PA0 1 &pcfg_pull_=
up>,
> -                                               <1 RK_PA1 1 &pcfg_pull_no=
ne>;
> -                       };
> -
> -                       uart0_cts: uart0-cts {
> -                               rockchip,pins =3D <1 RK_PA2 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       uart0_rts: uart0-rts {
> -                               rockchip,pins =3D <1 RK_PA3 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               uart1 {
> -                       uart1_xfer: uart1-xfer {
> -                               rockchip,pins =3D <1 RK_PA4 1 &pcfg_pull_=
up>,
> -                                               <1 RK_PA5 1 &pcfg_pull_no=
ne>;
> -                       };
> -
> -                       uart1_cts: uart1-cts {
> -                               rockchip,pins =3D <1 RK_PA6 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       uart1_rts: uart1-rts {
> -                               rockchip,pins =3D <1 RK_PA7 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               uart2 {
> -                       uart2_xfer: uart2-xfer {
> -                               rockchip,pins =3D <1 RK_PB0 1 &pcfg_pull_=
up>,
> -                                               <1 RK_PB1 1 &pcfg_pull_no=
ne>;
> -                       };
> -                       /* no rts / cts for uart2 */
> -               };
> -
> -               uart3 {
> -                       uart3_xfer: uart3-xfer {
> -                               rockchip,pins =3D <1 RK_PB2 1 &pcfg_pull_=
up>,
> -                                               <1 RK_PB3 1 &pcfg_pull_no=
ne>;
> -                       };
> -
> -                       uart3_cts: uart3-cts {
> -                               rockchip,pins =3D <1 RK_PB4 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       uart3_rts: uart3-rts {
> -                               rockchip,pins =3D <1 RK_PB5 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -
> -               sd0 {
> -                       sd0_clk: sd0-clk {
> -                               rockchip,pins =3D <3 RK_PA2 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_cmd: sd0-cmd {
> -                               rockchip,pins =3D <3 RK_PA3 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_cd: sd0-cd {
> -                               rockchip,pins =3D <3 RK_PB0 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_wp: sd0-wp {
> -                               rockchip,pins =3D <3 RK_PB1 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_pwr: sd0-pwr {
> -                               rockchip,pins =3D <3 RK_PA1 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_bus1: sd0-bus-width1 {
> -                               rockchip,pins =3D <3 RK_PA4 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd0_bus4: sd0-bus-width4 {
> -                               rockchip,pins =3D <3 RK_PA4 1 &pcfg_pull_=
none>,
> -                                               <3 RK_PA5 1 &pcfg_pull_no=
ne>,
> -                                               <3 RK_PA6 1 &pcfg_pull_no=
ne>,
> -                                               <3 RK_PA7 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               sd1 {
> -                       sd1_clk: sd1-clk {
> -                               rockchip,pins =3D <3 RK_PC5 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd1_cmd: sd1-cmd {
> -                               rockchip,pins =3D <3 RK_PC0 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd1_cd: sd1-cd {
> -                               rockchip,pins =3D <3 RK_PC6 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd1_wp: sd1-wp {
> -                               rockchip,pins =3D <3 RK_PC7 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd1_bus1: sd1-bus-width1 {
> -                               rockchip,pins =3D <3 RK_PC1 1 &pcfg_pull_=
none>;
> -                       };
> -
> -                       sd1_bus4: sd1-bus-width4 {
> -                               rockchip,pins =3D <3 RK_PC1 1 &pcfg_pull_=
none>,
> -                                               <3 RK_PC2 1 &pcfg_pull_no=
ne>,
> -                                               <3 RK_PC3 1 &pcfg_pull_no=
ne>,
> -                                               <3 RK_PC4 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               i2s0 {
> -                       i2s0_bus: i2s0-bus {
> -                               rockchip,pins =3D <1 RK_PC0 1 &pcfg_pull_=
none>,
> -                                               <1 RK_PC1 1 &pcfg_pull_no=
ne>,
> -                                               <1 RK_PC2 1 &pcfg_pull_no=
ne>,
> -                                               <1 RK_PC3 1 &pcfg_pull_no=
ne>,
> -                                               <1 RK_PC4 1 &pcfg_pull_no=
ne>,
> -                                               <1 RK_PC5 1 &pcfg_pull_no=
ne>;
> -                       };
> -               };
> -
> -               spdif {
> -                       spdif_tx: spdif-tx {
> -                               rockchip,pins =3D <1 RK_PB6 1 &pcfg_pull_=
none>;
> -                       };
> -               };
> -       };
> -};
> -
> -&emac {
> -       compatible =3D "rockchip,rk3188-emac";
> -};
> -
> -&global_timer {
> -       interrupts =3D <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDG=
E_RISING)>;
> -};
> -
> -&local_timer {
> -       interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDG=
E_RISING)>;
> -};
> -
> -&gpu {
> -       compatible =3D "rockchip,rk3188-mali", "arm,mali-400";
> -       interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -       interrupt-names =3D "gp",
> -                         "gpmmu",
> -                         "pp0",
> -                         "ppmmu0",
> -                         "pp1",
> -                         "ppmmu1",
> -                         "pp2",
> -                         "ppmmu2",
> -                         "pp3",
> -                         "ppmmu3";
> -       power-domains =3D <&power RK3188_PD_GPU>;
> -};
> -
> -&grf {
> -       compatible =3D "rockchip,rk3188-grf", "syscon", "simple-mfd";
> -
> -       io_domains: io-domains {
> -               compatible =3D "rockchip,rk3188-io-voltage-domain";
> -               status =3D "disabled";
> -       };
> -
> -       usbphy: usbphy {
> -               compatible =3D "rockchip,rk3188-usb-phy";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               status =3D "disabled";
> -
> -               usbphy0: usb-phy@10c {
> -                       reg =3D <0x10c>;
> -                       clocks =3D <&cru SCLK_OTGPHY0>;
> -                       clock-names =3D "phyclk";
> -                       #clock-cells =3D <0>;
> -                       #phy-cells =3D <0>;
> -               };
> -
> -               usbphy1: usb-phy@11c {
> -                       reg =3D <0x11c>;
> -                       clocks =3D <&cru SCLK_OTGPHY1>;
> -                       clock-names =3D "phyclk";
> -                       #clock-cells =3D <0>;
> -                       #phy-cells =3D <0>;
> -               };
> -       };
> -};
> -
> -&i2c0 {
> -       compatible =3D "rockchip,rk3188-i2c";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c0_xfer>;
> -};
> -
> -&i2c1 {
> -       compatible =3D "rockchip,rk3188-i2c";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c1_xfer>;
> -};
> -
> -&i2c2 {
> -       compatible =3D "rockchip,rk3188-i2c";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c2_xfer>;
> -};
> -
> -&i2c3 {
> -       compatible =3D "rockchip,rk3188-i2c";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c3_xfer>;
> -};
> -
> -&i2c4 {
> -       compatible =3D "rockchip,rk3188-i2c";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&i2c4_xfer>;
> -};
> -
> -&pmu {
> -       power: power-controller {
> -               compatible =3D "rockchip,rk3188-power-controller";
> -               #power-domain-cells =3D <1>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               power-domain@RK3188_PD_VIO {
> -                       reg =3D <RK3188_PD_VIO>;
> -                       clocks =3D <&cru ACLK_LCDC0>,
> -                                <&cru ACLK_LCDC1>,
> -                                <&cru DCLK_LCDC0>,
> -                                <&cru DCLK_LCDC1>,
> -                                <&cru HCLK_LCDC0>,
> -                                <&cru HCLK_LCDC1>,
> -                                <&cru SCLK_CIF0>,
> -                                <&cru ACLK_CIF0>,
> -                                <&cru HCLK_CIF0>,
> -                                <&cru ACLK_IPP>,
> -                                <&cru HCLK_IPP>,
> -                                <&cru ACLK_RGA>,
> -                                <&cru HCLK_RGA>;
> -                       pm_qos =3D <&qos_lcdc0>,
> -                                <&qos_lcdc1>,
> -                                <&qos_cif0>,
> -                                <&qos_ipp>,
> -                                <&qos_rga>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -
> -               power-domain@RK3188_PD_VIDEO {
> -                       reg =3D <RK3188_PD_VIDEO>;
> -                       clocks =3D <&cru ACLK_VDPU>,
> -                                <&cru ACLK_VEPU>,
> -                                <&cru HCLK_VDPU>,
> -                                <&cru HCLK_VEPU>;
> -                       pm_qos =3D <&qos_vpu>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -
> -               power-domain@RK3188_PD_GPU {
> -                       reg =3D <RK3188_PD_GPU>;
> -                       clocks =3D <&cru ACLK_GPU>;
> -                       pm_qos =3D <&qos_gpu>;
> -                       #power-domain-cells =3D <0>;
> -               };
> -       };
> -};
> -
> -&pwm0 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm0_out>;
> -};
> -
> -&pwm1 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm1_out>;
> -};
> -
> -&pwm2 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm2_out>;
> -};
> -
> -&pwm3 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&pwm3_out>;
> -};
> -
> -&spi0 {
> -       compatible =3D "rockchip,rk3188-spi", "rockchip,rk3066-spi";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -};
> -
> -&spi1 {
> -       compatible =3D "rockchip,rk3188-spi", "rockchip,rk3066-spi";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -};
> -
> -&uart0 {
> -       compatible =3D "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart0_xfer>;
> -};
> -
> -&uart1 {
> -       compatible =3D "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart1_xfer>;
> -};
> -
> -&uart2 {
> -       compatible =3D "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart2_xfer>;
> -};
> -
> -&uart3 {
> -       compatible =3D "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart3_xfer>;
> -};
> -
> -&vpu {
> -       compatible =3D "rockchip,rk3188-vpu", "rockchip,rk3066-vpu";
> -       power-domains =3D <&power RK3188_PD_VIDEO>;
> -};
> -
> -&wdt {
> -       compatible =3D "rockchip,rk3188-wdt", "snps,dw-wdt";
> -};
> diff --git a/arch/arm/dts/rk3xxx.dtsi b/arch/arm/dts/rk3xxx.dtsi
> deleted file mode 100644
> index cb4e42ede56a..000000000000
> --- a/arch/arm/dts/rk3xxx.dtsi
> +++ /dev/null
> @@ -1,488 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/soc/rockchip,boot-mode.h>
> -
> -/ {
> -       #address-cells =3D <1>;
> -       #size-cells =3D <1>;
> -
> -       interrupt-parent =3D <&gic>;
> -
> -       aliases {
> -               ethernet0 =3D &emac;
> -               i2c0 =3D &i2c0;
> -               i2c1 =3D &i2c1;
> -               i2c2 =3D &i2c2;
> -               i2c3 =3D &i2c3;
> -               i2c4 =3D &i2c4;
> -               serial0 =3D &uart0;
> -               serial1 =3D &uart1;
> -               serial2 =3D &uart2;
> -               serial3 =3D &uart3;
> -               spi0 =3D &spi0;
> -               spi1 =3D &spi1;
> -       };
> -
> -       xin24m: oscillator {
> -               compatible =3D "fixed-clock";
> -               clock-frequency =3D <24000000>;
> -               #clock-cells =3D <0>;
> -               clock-output-names =3D "xin24m";
> -       };
> -
> -       gpu: gpu@10090000 {
> -               compatible =3D "arm,mali-400";
> -               reg =3D <0x10090000 0x10000>;
> -               clocks =3D <&cru ACLK_GPU>, <&cru ACLK_GPU>;
> -               clock-names =3D "bus", "core";
> -               assigned-clocks =3D <&cru ACLK_GPU>;
> -               assigned-clock-rates =3D <100000000>;
> -               resets =3D <&cru SRST_GPU>;
> -               status =3D "disabled";
> -       };
> -
> -       vpu: video-codec@10104000 {
> -               compatible =3D "rockchip,rk3066-vpu";
> -               reg =3D <0x10104000 0x800>;
> -               interrupts =3D <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
> -                            <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -               interrupt-names =3D "vepu", "vdpu";
> -               clocks =3D <&cru ACLK_VDPU>, <&cru HCLK_VDPU>,
> -                        <&cru ACLK_VEPU>, <&cru HCLK_VEPU>;
> -               clock-names =3D "aclk_vdpu", "hclk_vdpu",
> -                             "aclk_vepu", "hclk_vepu";
> -       };
> -
> -       L2: cache-controller@10138000 {
> -               compatible =3D "arm,pl310-cache";
> -               reg =3D <0x10138000 0x1000>;
> -               cache-unified;
> -               cache-level =3D <2>;
> -       };
> -
> -       scu@1013c000 {
> -               compatible =3D "arm,cortex-a9-scu";
> -               reg =3D <0x1013c000 0x100>;
> -       };
> -
> -       global_timer: global-timer@1013c200 {
> -               compatible =3D "arm,cortex-a9-global-timer";
> -               reg =3D <0x1013c200 0x20>;
> -               interrupts =3D <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_=
TYPE_EDGE_RISING)>;
> -               clocks =3D <&cru CORE_PERI>;
> -               status =3D "disabled";
> -               /* The clock source and the sched_clock provided by the a=
rm_global_timer
> -                * on Rockchip rk3066a/rk3188 are quite unstable because =
their rates
> -                * depend on the CPU frequency.
> -                * Keep the arm_global_timer disabled in order to have th=
e
> -                * DW_APB_TIMER (rk3066a) or ROCKCHIP_TIMER (rk3188) sele=
cted by default.
> -                */
> -       };
> -
> -       local_timer: local-timer@1013c600 {
> -               compatible =3D "arm,cortex-a9-twd-timer";
> -               reg =3D <0x1013c600 0x20>;
> -               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_=
TYPE_EDGE_RISING)>;
> -               clocks =3D <&cru CORE_PERI>;
> -       };
> -
> -       gic: interrupt-controller@1013d000 {
> -               compatible =3D "arm,cortex-a9-gic";
> -               interrupt-controller;
> -               #interrupt-cells =3D <3>;
> -               reg =3D <0x1013d000 0x1000>,
> -                     <0x1013c100 0x0100>;
> -       };
> -
> -       uart0: serial@10124000 {
> -               compatible =3D "snps,dw-apb-uart";
> -               reg =3D <0x10124000 0x400>;
> -               interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <1>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               clocks =3D <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -               status =3D "disabled";
> -       };
> -
> -       uart1: serial@10126000 {
> -               compatible =3D "snps,dw-apb-uart";
> -               reg =3D <0x10126000 0x400>;
> -               interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <1>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               clocks =3D <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -               status =3D "disabled";
> -       };
> -
> -       qos_gpu: qos@1012d000 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012d000 0x20>;
> -       };
> -
> -       qos_vpu: qos@1012e000 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012e000 0x20>;
> -       };
> -
> -       qos_lcdc0: qos@1012f000 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f000 0x20>;
> -       };
> -
> -       qos_cif0: qos@1012f080 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f080 0x20>;
> -       };
> -
> -       qos_ipp: qos@1012f100 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f100 0x20>;
> -       };
> -
> -       qos_lcdc1: qos@1012f180 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f180 0x20>;
> -       };
> -
> -       qos_cif1: qos@1012f200 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f200 0x20>;
> -       };
> -
> -       qos_rga: qos@1012f280 {
> -               compatible =3D "rockchip,rk3066-qos", "syscon";
> -               reg =3D <0x1012f280 0x20>;
> -       };
> -
> -       usb_otg: usb@10180000 {
> -               compatible =3D "rockchip,rk3066-usb", "snps,dwc2";
> -               reg =3D <0x10180000 0x40000>;
> -               interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_OTG0>;
> -               clock-names =3D "otg";
> -               dr_mode =3D "otg";
> -               g-np-tx-fifo-size =3D <16>;
> -               g-rx-fifo-size =3D <275>;
> -               g-tx-fifo-size =3D <256 128 128 64 64 32>;
> -               phys =3D <&usbphy0>;
> -               phy-names =3D "usb2-phy";
> -               status =3D "disabled";
> -       };
> -
> -       usb_host: usb@101c0000 {
> -               compatible =3D "snps,dwc2";
> -               reg =3D <0x101c0000 0x40000>;
> -               interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_OTG1>;
> -               clock-names =3D "otg";
> -               dr_mode =3D "host";
> -               phys =3D <&usbphy1>;
> -               phy-names =3D "usb2-phy";
> -               status =3D "disabled";
> -       };
> -
> -       emac: ethernet@10204000 {
> -               compatible =3D "snps,arc-emac";
> -               reg =3D <0x10204000 0x3c>;
> -               interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clocks =3D <&cru HCLK_EMAC>, <&cru SCLK_MAC>;
> -               clock-names =3D "hclk", "macref";
> -               max-speed =3D <100>;
> -               phy-mode =3D "rmii";
> -
> -               status =3D "disabled";
> -       };
> -
> -       mmc0: mmc@10214000 {
> -               compatible =3D "rockchip,rk2928-dw-mshc";
> -               reg =3D <0x10214000 0x1000>;
> -               interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
> -               clock-names =3D "biu", "ciu";
> -               dmas =3D <&dmac2 1>;
> -               dma-names =3D "rx-tx";
> -               fifo-depth =3D <256>;
> -               resets =3D <&cru SRST_SDMMC>;
> -               reset-names =3D "reset";
> -               status =3D "disabled";
> -       };
> -
> -       mmc1: mmc@10218000 {
> -               compatible =3D "rockchip,rk2928-dw-mshc";
> -               reg =3D <0x10218000 0x1000>;
> -               interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
> -               clock-names =3D "biu", "ciu";
> -               dmas =3D <&dmac2 3>;
> -               dma-names =3D "rx-tx";
> -               fifo-depth =3D <256>;
> -               resets =3D <&cru SRST_SDIO>;
> -               reset-names =3D "reset";
> -               status =3D "disabled";
> -       };
> -
> -       emmc: mmc@1021c000 {
> -               compatible =3D "rockchip,rk2928-dw-mshc";
> -               reg =3D <0x1021c000 0x1000>;
> -               interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
> -               clock-names =3D "biu", "ciu";
> -               dmas =3D <&dmac2 4>;
> -               dma-names =3D "rx-tx";
> -               fifo-depth =3D <256>;
> -               resets =3D <&cru SRST_EMMC>;
> -               reset-names =3D "reset";
> -               status =3D "disabled";
> -       };
> -
> -       nfc: nand-controller@10500000 {
> -               compatible =3D "rockchip,rk2928-nfc";
> -               reg =3D <0x10500000 0x4000>;
> -               interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_NANDC0>;
> -               clock-names =3D "ahb";
> -               status =3D "disabled";
> -       };
> -
> -       pmu: pmu@20004000 {
> -               compatible =3D "rockchip,rk3066-pmu", "syscon", "simple-m=
fd";
> -               reg =3D <0x20004000 0x100>;
> -
> -               reboot-mode {
> -                       compatible =3D "syscon-reboot-mode";
> -                       offset =3D <0x40>;
> -                       mode-normal =3D <BOOT_NORMAL>;
> -                       mode-recovery =3D <BOOT_RECOVERY>;
> -                       mode-bootloader =3D <BOOT_FASTBOOT>;
> -                       mode-loader =3D <BOOT_BL_DOWNLOAD>;
> -               };
> -       };
> -
> -       grf: grf@20008000 {
> -               compatible =3D "syscon", "simple-mfd";
> -               reg =3D <0x20008000 0x200>;
> -       };
> -
> -       dmac1_s: dma-controller@20018000 {
> -               compatible =3D "arm,pl330", "arm,primecell";
> -               reg =3D <0x20018000 0x4000>;
> -               interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                            <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -               #dma-cells =3D <1>;
> -               arm,pl330-broken-no-flushp;
> -               arm,pl330-periph-burst;
> -               clocks =3D <&cru ACLK_DMA1>;
> -               clock-names =3D "apb_pclk";
> -       };
> -
> -       dmac1_ns: dma-controller@2001c000 {
> -               compatible =3D "arm,pl330", "arm,primecell";
> -               reg =3D <0x2001c000 0x4000>;
> -               interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                            <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -               #dma-cells =3D <1>;
> -               arm,pl330-broken-no-flushp;
> -               arm,pl330-periph-burst;
> -               clocks =3D <&cru ACLK_DMA1>;
> -               clock-names =3D "apb_pclk";
> -               status =3D "disabled";
> -       };
> -
> -       i2c0: i2c@2002d000 {
> -               compatible =3D "rockchip,rk3066-i2c";
> -               reg =3D <0x2002d000 0x1000>;
> -               interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clock-names =3D "i2c";
> -               clocks =3D <&cru PCLK_I2C0>;
> -
> -               status =3D "disabled";
> -       };
> -
> -       i2c1: i2c@2002f000 {
> -               compatible =3D "rockchip,rk3066-i2c";
> -               reg =3D <0x2002f000 0x1000>;
> -               interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clocks =3D <&cru PCLK_I2C1>;
> -               clock-names =3D "i2c";
> -
> -               status =3D "disabled";
> -       };
> -
> -       pwm0: pwm@20030000 {
> -               compatible =3D "rockchip,rk2928-pwm";
> -               reg =3D <0x20030000 0x10>;
> -               #pwm-cells =3D <2>;
> -               clocks =3D <&cru PCLK_PWM01>;
> -               status =3D "disabled";
> -       };
> -
> -       pwm1: pwm@20030010 {
> -               compatible =3D "rockchip,rk2928-pwm";
> -               reg =3D <0x20030010 0x10>;
> -               #pwm-cells =3D <2>;
> -               clocks =3D <&cru PCLK_PWM01>;
> -               status =3D "disabled";
> -       };
> -
> -       wdt: watchdog@2004c000 {
> -               compatible =3D "snps,dw-wdt";
> -               reg =3D <0x2004c000 0x100>;
> -               clocks =3D <&cru PCLK_WDT>;
> -               interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> -               status =3D "disabled";
> -       };
> -
> -       pwm2: pwm@20050020 {
> -               compatible =3D "rockchip,rk2928-pwm";
> -               reg =3D <0x20050020 0x10>;
> -               #pwm-cells =3D <2>;
> -               clocks =3D <&cru PCLK_PWM23>;
> -               status =3D "disabled";
> -       };
> -
> -       pwm3: pwm@20050030 {
> -               compatible =3D "rockchip,rk2928-pwm";
> -               reg =3D <0x20050030 0x10>;
> -               #pwm-cells =3D <2>;
> -               clocks =3D <&cru PCLK_PWM23>;
> -               status =3D "disabled";
> -       };
> -
> -       i2c2: i2c@20056000 {
> -               compatible =3D "rockchip,rk3066-i2c";
> -               reg =3D <0x20056000 0x1000>;
> -               interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clocks =3D <&cru PCLK_I2C2>;
> -               clock-names =3D "i2c";
> -
> -               status =3D "disabled";
> -       };
> -
> -       i2c3: i2c@2005a000 {
> -               compatible =3D "rockchip,rk3066-i2c";
> -               reg =3D <0x2005a000 0x1000>;
> -               interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clocks =3D <&cru PCLK_I2C3>;
> -               clock-names =3D "i2c";
> -
> -               status =3D "disabled";
> -       };
> -
> -       i2c4: i2c@2005e000 {
> -               compatible =3D "rockchip,rk3066-i2c";
> -               reg =3D <0x2005e000 0x1000>;
> -               interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               rockchip,grf =3D <&grf>;
> -
> -               clocks =3D <&cru PCLK_I2C4>;
> -               clock-names =3D "i2c";
> -
> -               status =3D "disabled";
> -       };
> -
> -       uart2: serial@20064000 {
> -               compatible =3D "snps,dw-apb-uart";
> -               reg =3D <0x20064000 0x400>;
> -               interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <1>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               clocks =3D <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -               status =3D "disabled";
> -       };
> -
> -       uart3: serial@20068000 {
> -               compatible =3D "snps,dw-apb-uart";
> -               reg =3D <0x20068000 0x400>;
> -               interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <1>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               clocks =3D <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> -               status =3D "disabled";
> -       };
> -
> -       saradc: saradc@2006c000 {
> -               compatible =3D "rockchip,saradc";
> -               reg =3D <0x2006c000 0x100>;
> -               interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -               #io-channel-cells =3D <1>;
> -               clocks =3D <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> -               clock-names =3D "saradc", "apb_pclk";
> -               resets =3D <&cru SRST_SARADC>;
> -               reset-names =3D "saradc-apb";
> -               status =3D "disabled";
> -       };
> -
> -       spi0: spi@20070000 {
> -               compatible =3D "rockchip,rk3066-spi";
> -               clocks =3D <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -               clock-names =3D "spiclk", "apb_pclk";
> -               interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> -               reg =3D <0x20070000 0x1000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               dmas =3D <&dmac2 10>, <&dmac2 11>;
> -               dma-names =3D "tx", "rx";
> -               status =3D "disabled";
> -       };
> -
> -       spi1: spi@20074000 {
> -               compatible =3D "rockchip,rk3066-spi";
> -               clocks =3D <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
> -               clock-names =3D "spiclk", "apb_pclk";
> -               interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> -               reg =3D <0x20074000 0x1000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               dmas =3D <&dmac2 12>, <&dmac2 13>;
> -               dma-names =3D "tx", "rx";
> -               status =3D "disabled";
> -       };
> -
> -       dmac2: dma-controller@20078000 {
> -               compatible =3D "arm,pl330", "arm,primecell";
> -               reg =3D <0x20078000 0x4000>;
> -               interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -               #dma-cells =3D <1>;
> -               arm,pl330-broken-no-flushp;
> -               arm,pl330-periph-burst;
> -               clocks =3D <&cru ACLK_DMA2>;
> -               clock-names =3D "apb_pclk";
> -       };
> -};
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index 92dca5e57600..a9420406649c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -48,6 +48,7 @@ config ROCKCHIP_RK3066
>         select TPL
>         select TPL_ROCKCHIP_BACK_TO_BROM
>         select TPL_ROCKCHIP_EARLYRETURN_TO_BROM
> +       imply OF_UPSTREAM
>         imply ROCKCHIP_COMMON_BOARD
>         imply SPL_ROCKCHIP_COMMON_BOARD
>         imply SPL_SERIAL
> @@ -84,6 +85,7 @@ config ROCKCHIP_RK3188
>         select SPL_ROCKCHIP_EARLYRETURN_TO_BROM
>         select SPL_ROCKCHIP_BACK_TO_BROM
>         select BOARD_LATE_INIT
> +       imply OF_UPSTREAM
>         imply ROCKCHIP_COMMON_BOARD
>         imply SPL_ROCKCHIP_COMMON_BOARD
>         help
> diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
> index 12a37054b4da..e47d0b594f35 100644
> --- a/configs/mk808_defconfig
> +++ b/configs/mk808_defconfig
> @@ -14,7 +14,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x78000000
>  CONFIG_SF_DEFAULT_SPEED=3D20000000
>  CONFIG_ENV_SIZE=3D0x8000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3066a-mk808"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3066a-mk808"
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3066=3Dy
>  # CONFIG_ROCKCHIP_STIMER is not set
> @@ -35,7 +35,7 @@ CONFIG_SPL_PAYLOAD=3D"u-boot.bin"
>  CONFIG_DEBUG_UART=3Dy
>  CONFIG_SD_BOOT=3Dy
>  CONFIG_USE_PREBOOT=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"rk3066a-mk808.dtb"
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3066a-mk808.dtb"
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
>  # CONFIG_DISPLAY_CPUINFO is not set
> diff --git a/configs/rock_defconfig b/configs/rock_defconfig
> index d7f11310cba1..9c05bf451465 100644
> --- a/configs/rock_defconfig
> +++ b/configs/rock_defconfig
> @@ -11,7 +11,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x60100000
>  CONFIG_SF_DEFAULT_SPEED=3D20000000
>  CONFIG_ENV_OFFSET=3D0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3188-radxarock"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3188-radxarock"
>  CONFIG_ROCKCHIP_RK3188=3Dy
>  # CONFIG_ROCKCHIP_STIMER is not set
>  CONFIG_TARGET_ROCK=3Dy
> @@ -25,7 +25,7 @@ CONFIG_DEBUG_UART_BASE=3D0x20064000
>  CONFIG_DEBUG_UART_CLOCK=3D24000000
>  CONFIG_DEBUG_UART=3Dy
>  CONFIG_USE_PREBOOT=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"rk3188-radxarock.dtb"
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3188-radxarock.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x7800
> --
> 2.39.5
>
