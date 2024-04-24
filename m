Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF7FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 15:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376298879E;
	Wed, 24 Apr 2024 17:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ossystems-com-br.20230601.gappssmtp.com header.i=@ossystems-com-br.20230601.gappssmtp.com header.b="JXCoVb/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3698881D; Wed, 24 Apr 2024 17:02:02 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184B388712
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ossystems.com.br
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=otavio.salvador@ossystems.com.br
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6164d7a02d2so80983237b3.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ossystems-com-br.20230601.gappssmtp.com; s=20230601; t=1713970916;
 x=1714575716; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rdItZfU5XFgg6MwdowJ5O1QKV80ZiryzXU4YsVLLXBA=;
 b=JXCoVb/JUUJkNCS8yvu9QlMonV/vW4c8L9A8Lr4ISHXWLxhvdIuVDMoimiGIyr8ONe
 YnYDRSm1CQrDeM7MuCzBv1qU4c6bj2KCOk0502GxwgxQgsQ8Rg9RkJDTYEcL4MHmKXWK
 OsayvumBWS+NmMubLVAtnJeFE+eBGCb2xZHhrKSZNADoYZNSAi1IQj5fLQnu1A4gm9vb
 4RgcRnl6bZpOmofuMhUTYkbEX850dre/g6mH/bAuj8etCkOJNOz+9eM+1Wx5g8+htDGU
 AxHBDaqb0cFl0T6r0OA7cAIEdH/Vr+VBfQajgIcwQi6qc7W6hmVaqU8gcwSe0gyZiVQr
 6EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713970916; x=1714575716;
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdItZfU5XFgg6MwdowJ5O1QKV80ZiryzXU4YsVLLXBA=;
 b=BdWSXOWut6FzJAtRb2K6x3o73aGpAO/7IgBFEmLDxAvpKazJjHUFMhXGNLiLGKgN97
 gXfulzTu3BIJ/uW4Gz74zAmuIJN4ktsS3W02j9qBRMCJDP1hB90GUwGSW1fMR1KXfSax
 MhxnPboKB/cUKhSzbvRlBI3v9n8iVkK0PWAfvpsptOS4ZA4PwgK6lD5sH4y6E+HmWr8J
 H8shuZGa3DkvYbKRsXE/YRjhwpMlvQcUEIXbc2FlJSE/A1zUCzp/pmjryyEhTAMP9HKE
 3h3aw2XJAOwLXeMlSC3YmITIkGsohSGQ4qxnHqveHF2gpk58MOQp5VwttCIDZqDFbTO1
 oQtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSkkEOp99CArN6bNFGI0D2VKs/O37kq1sNLWpjpNzvtSenRFDgEif8D9ABLPg4F6WYO19PLFh3Fc+PxxAUiVVwlyEyg==
X-Gm-Message-State: AOJu0YwNQB3JaKAE1zvwSUD8VQiuNzpO/7c/SgdeF46SVfBj87UlGo2o
 np0rhnSmXYiBbSjcmnisMxqC68ni7B+IWMP8swX55mVKRw6ykOnIaZZcb4bfMhIadZm9N6PWUhq
 6k8OB8w==
X-Google-Smtp-Source: AGHT+IHM+pZL2mHprN2XH/h4NyMrBpBlgrFVigjyHEnsp83DzZ5avPQLrQSAegLKa3e4qB9KnQstiA==
X-Received: by 2002:a05:690c:6d08:b0:618:79f5:8d32 with SMTP id
 iv8-20020a05690c6d0800b0061879f58d32mr2897020ywb.48.1713970916255; 
 Wed, 24 Apr 2024 08:01:56 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
 [209.85.128.170]) by smtp.gmail.com with ESMTPSA id
 z34-20020a81ac62000000b006088f2afc2dsm3072163ywj.87.2024.04.24.08.01.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 08:01:55 -0700 (PDT)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-61500da846fso47516217b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 08:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXpYDot/qZs1f9mYBmnMvaNEOW0KnKzH+lzVC3t2BBcylMgpKwNn+3fFaV5HrbnXIAihT1iniOg/W4aIxG2p4C0MTHyQw==
X-Received: by 2002:a05:690c:61c4:b0:615:a86:f77b with SMTP id
 hk4-20020a05690c61c400b006150a86f77bmr2807591ywb.26.1713970914747; Wed, 24
 Apr 2024 08:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240424141841.312688-1-festevam@gmail.com>
In-Reply-To: <20240424141841.312688-1-festevam@gmail.com>
Date: Wed, 24 Apr 2024 12:01:42 -0300
X-Gmail-Original-Message-ID: <CAP9ODKodeM==zUyE4yqJW4Ao3TD-zmd2thqSHs_7aNhFcY=F8A@mail.gmail.com>
Message-ID: <CAP9ODKodeM==zUyE4yqJW4Ao3TD-zmd2thqSHs_7aNhFcY=F8A@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: rv1108: Convert to OF_UPSTREAM
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, otavio@ossystems.com.br, 
 andy.yan@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Reviewed-by: Otavio Salvador <otavio@ossystems.com.br>
Tested-by: Otavio Salvador <otavio@ossystems.com.br>

Em qua., 24 de abr. de 2024 =C3=A0s 11:18, Fabio Estevam <festevam@gmail.co=
m>
escreveu:

> Instead of using the local rv1108 devicetree copies from U-Boot,
> let's convert the rv1108 boards to OF_UPSTREAM so that the upstream kerne=
l
> devicetrees can be used instead.
>
> Tested on a rv1108-elgin-r1 board.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v2:
> - Also removed the arch/arm/dts/Makefile entries.
>
>  arch/arm/dts/Makefile            |   4 -
>  arch/arm/dts/rv1108-elgin-r1.dts |  59 ----
>  arch/arm/dts/rv1108-evb.dts      |  79 -----
>  arch/arm/dts/rv1108.dtsi         | 581 -------------------------------
>  arch/arm/mach-rockchip/Kconfig   |   1 +
>  configs/elgin-rv1108_defconfig   |   2 +-
>  configs/evb-rv1108_defconfig     |   2 +-
>  7 files changed, 3 insertions(+), 725 deletions(-)
>  delete mode 100644 arch/arm/dts/rv1108-elgin-r1.dts
>  delete mode 100644 arch/arm/dts/rv1108-evb.dts
>  delete mode 100644 arch/arm/dts/rv1108.dtsi
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index b1c9c6222e5d..e600f9c6ed25 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -182,10 +182,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) +=3D \
>         rk3588-rock-5b.dtb \
>         rk3588-turing-rk1.dtb
>
> -dtb-$(CONFIG_ROCKCHIP_RV1108) +=3D \
> -       rv1108-elgin-r1.dtb \
> -       rv1108-evb.dtb
> -
>  dtb-$(CONFIG_ROCKCHIP_RV1126) +=3D \
>         rv1126-edgeble-neu2-io.dtb
>
> diff --git a/arch/arm/dts/rv1108-elgin-r1.dts
> b/arch/arm/dts/rv1108-elgin-r1.dts
> deleted file mode 100644
> index 83e8b3183847..000000000000
> --- a/arch/arm/dts/rv1108-elgin-r1.dts
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -
> -#include "rv1108.dtsi"
> -
> -/ {
> -       model =3D "Elgin RV1108 R1 board";
> -       compatible =3D "elgin,rv1108-elgin", "rockchip,rv1108";
> -
> -       memory@60000000 {
> -               device_type =3D "memory";
> -               reg =3D <0x60000000 0x08000000>;
> -       };
> -
> -       chosen {
> -               stdout-path =3D "serial2:1500000n8";
> -       };
> -};
> -
> -&emmc {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&emmc_clk &emmc_cmd &emmc_bus8>;
> -       bus-width =3D <8>;
> -       cap-mmc-highspeed;
> -       disable-wp;
> -       non-removable;
> -       status =3D "okay";
> -};
> -
> -&u2phy {
> -       status =3D "okay";
> -
> -       u2phy_otg: otg-port {
> -               status =3D "okay";
> -       };
> -};
> -
> -&uart2 {
> -       pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&uart2m0_xfer_pullup>;
> -       status =3D "okay";
> -};
> -
> -&usb20_otg {
> -       status =3D "okay";
> -};
> -
> -&pinctrl {
> -       uart2m0 {
> -               uart2m0_xfer_pullup: uart2m0-xfer-pullup {
> -                       rockchip,pins =3D <2 RK_PD2 RK_FUNC_1
> &pcfg_pull_up_drv_8ma>,
> -                                       <2 RK_PD1 RK_FUNC_1
> &pcfg_pull_up_drv_8ma>;
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/rv1108-evb.dts b/arch/arm/dts/rv1108-evb.dts
> deleted file mode 100644
> index c91776bc106e..000000000000
> --- a/arch/arm/dts/rv1108-evb.dts
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -
> -#include "rv1108.dtsi"
> -
> -/ {
> -       model =3D "Rockchip RV1108 Evaluation board";
> -       compatible =3D "rockchip,rv1108-evb", "rockchip,rv1108";
> -
> -       memory@60000000 {
> -               device_type =3D "memory";
> -               reg =3D <0x60000000 0x08000000>;
> -       };
> -
> -       chosen {
> -               stdout-path =3D "serial2:1500000n8";
> -       };
> -
> -       vcc5v0_otg: vcc5v0-otg-drv {
> -               compatible =3D "regulator-fixed";
> -               enable-active-high;
> -               regulator-name =3D "vcc5v0_otg";
> -               gpio =3D <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> -               regulator-min-microvolt =3D <5000000>;
> -               regulator-max-microvolt =3D <5000000>;
> -       };
> -};
> -
> -&gmac {
> -       status =3D "okay";
> -       clock_in_out =3D <0>;
> -       snps,reset-active-low;
> -       snps,reset-delays-us =3D <0 10000 1000000>;
> -       snps,reset-gpio =3D <&gpio1 RK_PC1 GPIO_ACTIVE_LOW>;
> -};
> -
> -&saradc {
> -       status =3D "okay";
> -};
> -
> -&sfc {
> -       status =3D "okay";
> -       flash@0 {
> -               compatible =3D "gd25q256","jedec,spi-nor";
> -               reg =3D <0>;
> -               spi-tx-bus-width =3D <1>;
> -               spi-rx-bus-width =3D <1>;
> -               spi-max-frequency =3D <96000000>;
> -       };
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
> -&usb20_otg {
> -       vbus-supply =3D <&vcc5v0_otg>;
> -       status =3D "okay";
> -};
> -
> -&usb_host_ehci {
> -       status =3D "okay";
> -};
> -
> -&usb_host_ohci {
> -       status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rv1108.dtsi b/arch/arm/dts/rv1108.dtsi
> deleted file mode 100644
> index 215d88522587..000000000000
> --- a/arch/arm/dts/rv1108.dtsi
> +++ /dev/null
> @@ -1,581 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/clock/rv1108-cru.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -/ {
> -       #address-cells =3D <1>;
> -       #size-cells =3D <1>;
> -
> -       compatible =3D "rockchip,rv1108";
> -
> -       interrupt-parent =3D <&gic>;
> -
> -       aliases {
> -               serial0 =3D &uart0;
> -               serial1 =3D &uart1;
> -               serial2 =3D &uart2;
> -               spi0    =3D &sfc;
> -       };
> -
> -       cpus {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -
> -               cpu0: cpu@f00 {
> -                       device_type =3D "cpu";
> -                       compatible =3D "arm,cortex-a7";
> -                       reg =3D <0xf00>;
> -               };
> -       };
> -
> -       arm-pmu {
> -               compatible =3D "arm,cortex-a7-pmu";
> -               interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> -       };
> -
> -       timer {
> -               compatible =3D "arm,armv7-timer";
> -               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
> IRQ_TYPE_LEVEL_HIGH)>,
> -                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
> IRQ_TYPE_LEVEL_HIGH)>;
> -               clock-frequency =3D <24000000>;
> -       };
> -
> -       xin24m: oscillator {
> -               compatible =3D "fixed-clock";
> -               clock-frequency =3D <24000000>;
> -               clock-output-names =3D "xin24m";
> -               #clock-cells =3D <0>;
> -       };
> -
> -       amba {
> -               compatible =3D "simple-bus";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges;
> -
> -               pdma: pdma@102a0000 {
> -                       compatible =3D "arm,pl330", "arm,primecell";
> -                       reg =3D <0x102a0000 0x4000>;
> -                       interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> -                       #dma-cells =3D <1>;
> -                       arm,pl330-broken-no-flushp;
> -                       clocks =3D <&cru ACLK_DMAC>;
> -                       clock-names =3D "apb_pclk";
> -               };
> -       };
> -
> -       bus_intmem@10080000 {
> -               compatible =3D "mmio-sram";
> -               reg =3D <0x10080000 0x2000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0x10080000 0x2000>;
> -       };
> -
> -       uart2: serial@10210000 {
> -               compatible =3D "rockchip,rv1108-uart", "snps,dw-apb-uart"=
;
> -               reg =3D <0x10210000 0x100>;
> -               interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <4>;
> -               clock-frequency =3D <24000000>;
> -               clocks =3D <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&uart2m0_xfer>;
> -               status =3D "disabled";
> -       };
> -
> -       uart1: serial@10220000 {
> -               compatible =3D "rockchip,rv1108-uart", "snps,dw-apb-uart"=
;
> -               reg =3D <0x10220000 0x100>;
> -               interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <4>;
> -               clock-frequency =3D <24000000>;
> -               clocks =3D <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&uart1_xfer>;
> -               status =3D "disabled";
> -       };
> -
> -       uart0: serial@10230000 {
> -               compatible =3D "rockchip,rv1108-uart", "snps,dw-apb-uart"=
;
> -               reg =3D <0x10230000 0x100>;
> -               interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -               reg-shift =3D <2>;
> -               reg-io-width =3D <4>;
> -               clock-frequency =3D <24000000>;
> -               clocks =3D <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -               clock-names =3D "baudclk", "apb_pclk";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&uart0_xfer &uart0_cts &uart0_rts>;
> -               status =3D "disabled";
> -       };
> -
> -       grf: syscon@10300000 {
> -               compatible =3D "rockchip,rv1108-grf", "syscon", "simple-m=
fd";
> -               reg =3D <0x10300000 0x1000>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -
> -               u2phy: usb2-phy@100 {
> -                       compatible =3D "rockchip,rv1108-usb2phy";
> -                       reg =3D <0x100 0x0c>;
> -                       clocks =3D <&cru SCLK_USBPHY>;
> -                       clock-names =3D "phyclk";
> -                       #clock-cells =3D <0>;
> -                       clock-output-names =3D "usbphy";
> -                       rockchip,usbgrf =3D <&usbgrf>;
> -                       status =3D "disabled";
> -
> -                       u2phy_otg: otg-port {
> -                               interrupts =3D <GIC_SPI 48
> IRQ_TYPE_LEVEL_HIGH>;
> -                               interrupt-names =3D "otg-mux";
> -                               #phy-cells =3D <0>;
> -                               status =3D "disabled";
> -                       };
> -
> -                       u2phy_host: host-port {
> -                               interrupts =3D <GIC_SPI 51
> IRQ_TYPE_LEVEL_HIGH>;
> -                               interrupt-names =3D "linestate";
> -                               #phy-cells =3D <0>;
> -                               status =3D "disabled";
> -                       };
> -               };
> -       };
> -
> -       saradc: saradc@1038c000 {
> -               compatible =3D "rockchip,rv1108-saradc",
> "rockchip,rk3399-saradc";
> -               reg =3D <0x1038c000 0x100>;
> -               interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> -               #io-channel-cells =3D <1>;
> -               clock-frequency =3D <1000000>;
> -               clocks =3D <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> -               clock-names =3D "saradc", "apb_pclk";
> -               status =3D "disabled";
> -       };
> -
> -       pmugrf: syscon@20060000 {
> -               compatible =3D "rockchip,rv1108-pmugrf", "syscon";
> -               reg =3D <0x20060000 0x1000>;
> -       };
> -
> -       usbgrf: syscon@202a0000 {
> -               compatible =3D "rockchip,rv1108-usbgrf", "syscon";
> -               reg =3D <0x202a0000 0x1000>;
> -       };
> -
> -       cru: clock-controller@20200000 {
> -               compatible =3D "rockchip,rv1108-cru";
> -               reg =3D <0x20200000 0x1000>;
> -               rockchip,grf =3D <&grf>;
> -               #clock-cells =3D <1>;
> -               #reset-cells =3D <1>;
> -       };
> -
> -       emmc: dwmmc@30110000 {
> -               compatible =3D "rockchip,rv1108-dw-mshc",
> "rockchip,rk3288-dw-mshc";
> -               clock-freq-min-max =3D <400000 150000000>;
> -               clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> -                        <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> -               clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -               fifo-depth =3D <0x100>;
> -               interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -               reg =3D <0x30110000 0x4000>;
> -               status =3D "disabled";
> -       };
> -
> -       sdio: dwmmc@30120000 {
> -               compatible =3D "rockchip,rv1108-dw-mshc",
> "rockchip,rk3288-dw-mshc";
> -               clock-freq-min-max =3D <400000 150000000>;
> -               clocks =3D <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> -                        <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> -               clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -               fifo-depth =3D <0x100>;
> -               interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -               reg =3D <0x30120000 0x4000>;
> -               status =3D "disabled";
> -       };
> -
> -       sdmmc: dwmmc@30130000 {
> -               compatible =3D "rockchip,rv1108-dw-mshc",
> "rockchip,rk3288-dw-mshc";
> -               clock-freq-min-max =3D <400000 100000000>;
> -               clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> -                        <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> -               clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -               fifo-depth =3D <0x100>;
> -               interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -               reg =3D <0x30130000 0x4000>;
> -               status =3D "disabled";
> -       };
> -
> -       usb_host_ehci: usb@30140000 {
> -               compatible =3D "generic-ehci";
> -               reg =3D <0x30140000 0x20000>;
> -               interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> -               status =3D "disabled";
> -       };
> -
> -       usb_host_ohci: usb@30160000 {
> -               compatible =3D "generic-ohci";
> -               reg =3D <0x30160000 0x20000>;
> -               interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -               status =3D "disabled";
> -       };
> -
> -       usb20_otg: usb@30180000 {
> -               compatible =3D "rockchip,rv1108-usb", "rockchip,rk3066-us=
b",
> -                            "snps,dwc2";
> -               reg =3D <0x30180000 0x40000>;
> -               interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru HCLK_OTG>;
> -               clock-names =3D "otg";
> -               dr_mode =3D "otg";
> -               g-np-tx-fifo-size =3D <16>;
> -               g-rx-fifo-size =3D <280>;
> -               g-tx-fifo-size =3D <256 128 128 64 32 16>;
> -               g-use-dma;
> -               phys =3D <&u2phy_otg>;
> -               phy-names =3D "usb2-phy";
> -               status =3D "disabled";
> -       };
> -
> -       sfc: sfc@301c0000 {
> -               compatible =3D "rockchip,sfc";
> -               reg =3D <0x301c0000 0x200>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
> -               interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks =3D <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> -               clock-names =3D "clk_sfc", "hclk_sfc";
> -               pinctrl-0 =3D <&sfc_pins>;
> -               pinctrl-names =3D "default";
> -               status =3D "disabled";
> -        };
> -
> -       gmac: ethernet@30200000 {
> -               compatible =3D "rockchip,rv1108-gmac";
> -               reg =3D <0x30200000 0x10000>;
> -               interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -               interrupt-names =3D "macirq";
> -               rockchip,grf =3D <&grf>;
> -               clocks =3D <&cru SCLK_MAC>,
> -                       <&cru SCLK_MAC_RX>, <&cru SCLK_MAC_TX>,
> -                       <&cru SCLK_MACREF>, <&cru SCLK_MACREF_OUT>,
> -                       <&cru ACLK_GMAC>, <&cru PCLK_GMAC>;
> -                clock-names =3D "stmmaceth",
> -                        "mac_clk_rx", "mac_clk_tx",
> -                        "clk_mac_ref", "clk_mac_refout",
> -                        "aclk_mac", "pclk_mac";
> -               pinctrl-names =3D "default";
> -               pinctrl-0 =3D <&rmii_pins>;
> -               phy-mode =3D "rmii";
> -               max-speed =3D <100>;
> -               status =3D "disabled";
> -       };
> -
> -       gic: interrupt-controller@32010000 {
> -               compatible =3D "arm,gic-400";
> -               interrupt-controller;
> -               #interrupt-cells =3D <3>;
> -               #address-cells =3D <0>;
> -
> -               reg =3D <0x32011000 0x1000>,
> -                     <0x32012000 0x1000>,
> -                     <0x32014000 0x2000>,
> -                     <0x32016000 0x2000>;
> -               interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) |
> IRQ_TYPE_LEVEL_HIGH)>;
> -       };
> -
> -       pinctrl: pinctrl {
> -               compatible =3D "rockchip,rv1108-pinctrl";
> -               rockchip,grf =3D <&grf>;
> -               rockchip,pmu =3D <&pmugrf>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges;
> -
> -               gpio0: gpio0@20030000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x20030000 0x100>;
> -                       interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&xin24m>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio1: gpio1@10310000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x10310000 0x100>;
> -                       interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&xin24m>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio2: gpio2@10320000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x10320000 0x100>;
> -                       interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&xin24m>;
> -
> -                       gpio-controller;
> -                       #gpio-cells =3D <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells =3D <2>;
> -               };
> -
> -               gpio3: gpio3@10330000 {
> -                       compatible =3D "rockchip,gpio-bank";
> -                       reg =3D <0x10330000 0x100>;
> -                       interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&xin24m>;
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
> -               pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
> -                       drive-strength =3D <8>;
> -               };
> -
> -               pcfg_pull_none_drv_12ma: pcfg-pull-none-drv-12ma {
> -                       drive-strength =3D <12>;
> -               };
> -
> -               pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
> -                       bias-pull-up;
> -                       drive-strength =3D <8>;
> -               };
> -
> -               pcfg_pull_none_drv_4ma: pcfg-pull-none-drv-4ma {
> -                       drive-strength =3D <4>;
> -               };
> -
> -               pcfg_pull_up_drv_4ma: pcfg-pull-up-drv-4ma {
> -                       bias-pull-up;
> -                       drive-strength =3D <4>;
> -               };
> -
> -               pcfg_output_high: pcfg-output-high {
> -                       output-high;
> -               };
> -
> -               pcfg_output_low: pcfg-output-low {
> -                       output-low;
> -               };
> -
> -               pcfg_input_high: pcfg-input-high {
> -                       bias-pull-up;
> -                       input-enable;
> -               };
> -
> -               gmac {
> -                       rmii_pins: rmii-pins {
> -                               rockchip,pins =3D <1 RK_PC5 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <1 RK_PC3 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <1 RK_PC4 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <1 RK_PB2 RK_FUNC_3
> &pcfg_pull_none_drv_12ma>,
> -                                               <1 RK_PB3 RK_FUNC_3
> &pcfg_pull_none_drv_12ma>,
> -                                               <1 RK_PB4 RK_FUNC_3
> &pcfg_pull_none_drv_12ma>,
> -                                               <1 RK_PB5 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <1 RK_PB6 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <1 RK_PB7 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <1 RK_PC2 RK_FUNC_3
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               i2c1 {
> -                       i2c1_xfer: i2c1-xfer {
> -                               rockchip,pins =3D <2 RK_PD3 RK_FUNC_1
> &pcfg_pull_up>,
> -                                               <2 RK_PD4 RK_FUNC_1
> &pcfg_pull_up>;
> -                       };
> -               };
> -
> -               i2c2m1 {
> -                       i2c2m1_xfer: i2c2m1-xfer {
> -                               rockchip,pins =3D <0 RK_PC2 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <0 RK_PC6 RK_FUNC_3
> &pcfg_pull_none>;
> -                       };
> -
> -                       i2c2m1_gpio: i2c2m1-gpio {
> -                               rockchip,pins =3D <0 RK_PC2 RK_FUNC_GPIO
> &pcfg_pull_none>,
> -                                               <0 RK_PC6 RK_FUNC_GPIO
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               i2c2m05v {
> -                       i2c2m05v_xfer: i2c2m05v-xfer {
> -                               rockchip,pins =3D <1 RK_PD5 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <1 RK_PD4 RK_FUNC_2
> &pcfg_pull_none>;
> -                       };
> -
> -                       i2c2m05v_gpio: i2c2m05v-gpio {
> -                               rockchip,pins =3D <1 RK_PD5 RK_FUNC_GPIO
> &pcfg_pull_none>,
> -                                               <1 RK_PD4 RK_FUNC_GPIO
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               i2c3 {
> -                       i2c3_xfer: i2c3-xfer {
> -                               rockchip,pins =3D <0 RK_PB6 RK_FUNC_1
> &pcfg_pull_none>,
> -                                               <0 RK_PC4 RK_FUNC_2
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               sfc {
> -                       sfc_pins: sfc-pins {
> -                               rockchip,pins =3D <2 RK_PA3 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <2 RK_PA2 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <2 RK_PA1 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <2 RK_PA0 RK_FUNC_3
> &pcfg_pull_none>,
> -                                               <2 RK_PB7 RK_FUNC_2
> &pcfg_pull_none>,
> -                                               <2 RK_PB4 RK_FUNC_3
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               emmc {
> -                       emmc_clk: emmc-clk {
> -                               rockchip,pins =3D <2 RK_PB6 RK_FUNC_1
> &pcfg_pull_none_drv_8ma>;
> -                       };
> -
> -                       emmc_cmd: emmc-cmd {
> -                               rockchip,pins =3D <2 RK_PB4 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>;
> -                       };
> -
> -                       emmc_pwren: emmc-pwren {
> -                               rockchip,pins =3D <2 RK_PC2 RK_FUNC_2
> &pcfg_pull_none>;
> -                       };
> -
> -                       emmc_bus1: emmc-bus1 {
> -                               rockchip,pins =3D <2 RK_PA0 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>;
> -                       };
> -
> -                       emmc_bus8: emmc-bus8 {
> -                               rockchip,pins =3D <2 RK_PA0 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA1 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA2 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA3 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA4 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA5 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA6 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>,
> -                                               <2 RK_PA7 RK_FUNC_2
> &pcfg_pull_up_drv_8ma>;
> -                       };
> -               };
> -
> -               sdmmc {
> -                       sdmmc_clk: sdmmc-clk {
> -                               rockchip,pins =3D <3 RK_PC4 RK_FUNC_1
> &pcfg_pull_none_drv_4ma>;
> -                       };
> -
> -                       sdmmc_cmd: sdmmc-cmd {
> -                               rockchip,pins =3D <3 RK_PC5 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>;
> -                       };
> -
> -                       sdmmc_cd: sdmmc-cd {
> -                               rockchip,pins =3D <0 RK_PA1 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>;
> -                       };
> -
> -                       sdmmc_bus1: sdmmc-bus1 {
> -                               rockchip,pins =3D <3 RK_PC3 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>;
> -                       };
> -
> -                       sdmmc_bus4: sdmmc-bus4 {
> -                               rockchip,pins =3D <3 RK_PC3 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>,
> -                                               <3 RK_PC2 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>,
> -                                               <3 RK_PC1 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>,
> -                                               <3 RK_PC0 RK_FUNC_1
> &pcfg_pull_up_drv_4ma>;
> -                       };
> -               };
> -
> -               uart0 {
> -                       uart0_xfer: uart0-xfer {
> -                               rockchip,pins =3D <3 RK_PA6 RK_FUNC_1
> &pcfg_pull_up>,
> -                                               <3 RK_PA5 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart0_cts: uart0-cts {
> -                               rockchip,pins =3D <3 RK_PA4 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart0_rts: uart0-rts {
> -                               rockchip,pins =3D <3 RK_PA3 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart0_rts_gpio: uart0-rts-gpio {
> -                               rockchip,pins =3D <3 RK_PA3 RK_FUNC_GPIO
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               uart1 {
> -                       uart1_xfer: uart1-xfer {
> -                               rockchip,pins =3D <1 RK_PD3 RK_FUNC_1
> &pcfg_pull_up>,
> -                                               <1 RK_PD2 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart1_cts: uart1-cts {
> -                               rockchip,pins =3D <1 RK_PD0 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart01rts: uart1-rts {
> -                               rockchip,pins =3D <1 RK_PD1 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               uart2m0 {
> -                       uart2m0_xfer: uart2m0-xfer {
> -                               rockchip,pins =3D <2 RK_PD2 RK_FUNC_1
> &pcfg_pull_up>,
> -                                               <2 RK_PD1 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               uart2m1 {
> -                       uart2m1_xfer: uart2m1-xfer {
> -                               rockchip,pins =3D <3 RK_PC3 RK_FUNC_2
> &pcfg_pull_up>,
> -                                               <3 RK_PC2 RK_FUNC_2
> &pcfg_pull_none>;
> -                       };
> -               };
> -
> -               uart2_5v {
> -                       uart2_5v_cts: uart2_5v-cts {
> -                               rockchip,pins =3D <1 RK_PD4 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -
> -                       uart2_5v_rts: uart2_5v-rts {
> -                               rockchip,pins =3D <1 RK_PD5 RK_FUNC_1
> &pcfg_pull_none>;
> -                       };
> -               };
> -       };
> -};
> diff --git a/arch/arm/mach-rockchip/Kconfig
> b/arch/arm/mach-rockchip/Kconfig
> index 4f22d9bde9f9..b4a10be00249 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -343,6 +343,7 @@ config ROCKCHIP_RV1108
>         bool "Support Rockchip RV1108"
>         select CPU_V7A
>         imply ROCKCHIP_COMMON_BOARD
> +       imply OF_UPSTREAM
>         help
>           The Rockchip RV1108 is a ARM-based SoC with a single-core
> Cortex-A7
>           and a DSP.
> diff --git a/configs/elgin-rv1108_defconfig
> b/configs/elgin-rv1108_defconfig
> index 446c9c9b7aca..140429f84d29 100644
> --- a/configs/elgin-rv1108_defconfig
> +++ b/configs/elgin-rv1108_defconfig
> @@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x60100000
>  CONFIG_ENV_OFFSET=3D0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rv1108-elgin-r1"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rv1108-elgin-r1"
>  CONFIG_ROCKCHIP_RV1108=3Dy
>  CONFIG_ROCKCHIP_BOOT_MODE_REG=3D0
>  CONFIG_TARGET_ELGIN_RV1108=3Dy
> diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
> index 1c62149a9b57..afc0ce4a0929 100644
> --- a/configs/evb-rv1108_defconfig
> +++ b/configs/evb-rv1108_defconfig
> @@ -5,7 +5,7 @@ CONFIG_TEXT_BASE=3D0x60000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x60100000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rv1108-evb"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rv1108-evb"
>  CONFIG_ROCKCHIP_RV1108=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0x10210000
>  CONFIG_DEBUG_UART_CLOCK=3D24000000
> --
> 2.34.1
>
>

--=20
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
