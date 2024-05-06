Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4473AC25B10
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 12:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FB6882F1;
	Mon,  6 May 2024 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aogVi34d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7A087FA1; Mon,  6 May 2024 11:59:18 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071DE8801F
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 11:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-de45385a1b4so1530862276.3
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714989553; x=1715594353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJFcucLIeMAmhZIDcR5RDRLZfexmokg+3eVYnwwE7pw=;
 b=aogVi34dcuoxy8AMaNL8FiEXtPx2+2SwHWZPGQ3qwJWjFeQkQy/suM/XtXir25zCU7
 X3B/4s4RrlfAhrhYGcZ/XFKYdsdJ2OMsClLeBkFUBQMijgMce8ESAbpPR01ZMasJHo5e
 aTWzsLxK6XzJap1PPfYR4KkKE10znqeoeK4RiDiqD0BreKNYqyaq75ImSMyfDPeR+h06
 j8A3m0zB5AYWZtRZ3k2TOme39FdUc8egpjwSPkKxKaQzmRD5Ye+94Qb6l8b874VGyzSK
 lOX1VuvSn0mOn5GrJwV60G7822EWa5tLyt9xgbYDLCigmPAr5ncqCZEXB5gM6xvQLdi6
 bsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989553; x=1715594353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJFcucLIeMAmhZIDcR5RDRLZfexmokg+3eVYnwwE7pw=;
 b=Ae1QCdFoL87OnpUPuh3WueBHncJ9wyMvPN2sgnBjxtv9hRpj58CDBiDIf9/9e5EO5g
 24SMQ24Mivd8fe08ce6YPMc5h8v42wHqLgybx135DHGjCb5T8q+PyQlcRfz/6BmIgoUw
 J3tO8Ki7VX7Et+D7gMSX6gEjsDEDbeWVn3pextlzMRn2y06zmMlYfH7MJgbUJoj5em5x
 vvvqle9C6BXM0SF6Ai4RoZxMeNeEmulvw79hidC/t74QxMwH78jmTBGsQIYoOt0bLp/a
 atC9icQoKjopWluwLAwZy267sz1946wnS2ghI8+JW/j0cAB3sYAaIuje6DeFfnRswbhT
 jEcQ==
X-Gm-Message-State: AOJu0YwmLGNCYpwiR050Poa7fE/cGVwc5XmmZAuZszGqbblR1+ugOZfN
 Ap5nork5fh5Df1Hw1mo93vfdSy4TcuOS4m2gk8BsB3ZPbRvo8Q1D0zdKIzB43jFQolRS2ck3FfE
 28sgDRX28IQY+xdfDG4cQ4z5mABI=
X-Google-Smtp-Source: AGHT+IGGkpJQPCw9tPfaHsYCemkKC05iF7uZm8/D4KEpNcATFBNt4FJo++ZRM+XtdOQN615T8c0EIwjttO3um3dncJA=
X-Received: by 2002:a25:68ce:0:b0:de4:5c94:f58f with SMTP id
 d197-20020a2568ce000000b00de45c94f58fmr10877120ybc.15.1714989552495; Mon, 06
 May 2024 02:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240504170537.376538-1-liujianfeng1994@gmail.com>
 <35348244-daf0-489c-a56b-234981d95a2f@cherry.de>
In-Reply-To: <35348244-daf0-489c-a56b-234981d95a2f@cherry.de>
From: Jianfeng Liu <liujianfeng1994@gmail.com>
Date: Mon, 6 May 2024 17:59:00 +0800
Message-ID: <CACQ+3oYOdTEVthvbpkx3QXr6XGSqtRqTJs_aR_3H8nyaH1d-dg@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>, 
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jagan Teki <jagan@edgeble.ai>,
 John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tianling Shen <cnsztl@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
X-Mailman-Approved-At: Mon, 06 May 2024 14:57:44 +0200
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

Hi Quentin,

Many thanks to your review.

On May 6, 2024, 8:54 a.m. UTC, Quentin Schulz wrote:
>>   F:     arch/arm/include/asm/arch-rockchip/
>>   F:     arch/arm/mach-rockchip/
>>   F:     board/amarula/vyasa-rk3288/
>> +F:     board/armsom/sige7-rk3588/
>
>Can you order this alphabetically please?

Sure, I will fix it.

>> +&sdhci {
>> +       cap-mmc-highspeed;
>
>I think this isn't supported in U-Boot on RK35xx devices just yet? We
>force everything to be HS200+ anyway if I remember correctly.

I use the same devicetree as rock5b[1] and I haven't encountered issues.
I also remember kernel driver has issues with mmc-hs400, which will cause
system unstable, but it seems that this is fine in u-boot.

[1]
https://github.com/u-boot/u-boot/blob/bcaf6c0570deb7dcd3c029d2e74efea740a0b=
20a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi#L34

>I would recommend using
>arch/arm/dts/rk3588-armsom-sige7* here instead, as to not have to
>maintain a list of DTSes (e.g. if overlays are supported one day?)

Sure, I will change it.

>The wiki doesn't seem to indicate there's any SPI flash on that device
>so I don't think we need to support anything related to it, especially
>the creation of the image to flash on an SPI nor?

Yes there is no spi flash on board. I will delete those SPI flash related
configs.

>> +CONFIG_USB_HOST_ETHER=3Dy
>> +CONFIG_USB_ETHER_ASIX=3Dy
>> +CONFIG_USB_ETHER_ASIX88179=3Dy
>> +CONFIG_USB_ETHER_LAN75XX=3Dy
>> +CONFIG_USB_ETHER_LAN78XX=3Dy
>> +CONFIG_USB_ETHER_MCS7830=3Dy
>> +CONFIG_USB_ETHER_RTL8152=3Dy
>> +CONFIG_USB_ETHER_SMSC95XX=3Dy
>
>I'm surprised to see USB_ETHER support here? Is this something done on
>purpose? The board already has two 2.5Gbps Ethernet, are they not working?

I copied these configs from rock5b. I guess someone should have the need
to do net boot through usb ethernet since there is also usb support.

Best regards,
Jianfeng

Quentin Schulz <quentin.schulz@cherry.de> =E4=BA=8E2024=E5=B9=B45=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=B8=80 16:54=E5=86=99=E9=81=93=EF=BC=9A

> Hi Jianfeng Liu,
>
> On 5/4/24 7:05 PM, Jianfeng Liu wrote:
> > [You don't often get email from liujianfeng1994@gmail.com. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer) by
> > ArmSoM.
> >
> > There are two variants depending on the DRAM size : 8G and 16G.
> >
> > Specification:
> >
> >      Rockchip Rk3588 SoC
> >      4x ARM Cortex-A76, 4x ARM Cortex-A55
> >      8/16GB memory LPDDR4x
> >      Mali G610MC4 GPU
> >      2x MIPI CSI 2 multiple lanes connector
> >      64GB/128GB on board eMMC
> >      uSD slot
> >      1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
> >      1x HDMI 2.1 output
> >      2x 2.5 Gbps Ethernet port
> >      40-pin IO header including UART, SPI and I2C
> >      USB PD over USB Type-C
> >      Size: 92mm x 62mm
> >
> > Kernel commit:
> > 81c828a67c78 (arm64: dts: rockchip: Add ArmSom Sige7 board)
> >
> > Note that these commits:
> > - e18e5e8188f2 (arm64: dts: rockchip: add USBDP phys on rk3588)
> > - 6fca4edb93d3 (arm64: dts: rockchip: Add rk3588 GPU node)
> > are not synced to u-boot, so I remove usb3 drd nodes and gpu from kerne=
l
> > devicetree.
> >
> > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > ---
> >
> >   MAINTAINERS                                  |   1 +
> >   arch/arm/dts/Makefile                        |   1 +
> >   arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi |  31 +
> >   arch/arm/dts/rk3588-armsom-sige7.dts         | 691 ++++++++++++++++++=
+
> >   arch/arm/mach-rockchip/rk3588/Kconfig        |  26 +
> >   board/armsom/sige7-rk3588/Kconfig            |  12 +
> >   board/armsom/sige7-rk3588/MAINTAINERS        |   8 +
> >   configs/sige7-rk3588_defconfig               | 104 +++
> >   doc/board/rockchip/rockchip.rst              |   1 +
> >   include/configs/sige7-rk3588.h               |  15 +
> >   10 files changed, 890 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/rk3588-armsom-sige7.dts
> >   create mode 100644 board/armsom/sige7-rk3588/Kconfig
> >   create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
> >   create mode 100644 configs/sige7-rk3588_defconfig
> >   create mode 100644 include/configs/sige7-rk3588.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7a3b4d3712..52367bf38c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -532,6 +532,7 @@ F:  arch/arm/dts/rv11*
> >   F:     arch/arm/include/asm/arch-rockchip/
> >   F:     arch/arm/mach-rockchip/
> >   F:     board/amarula/vyasa-rk3288/
> > +F:     board/armsom/sige7-rk3588/
>
> Can you order this alphabetically please?
>
> >   F:     board/anbernic/rgxx3_rk3566/
> >   F:     board/chipspark/popmetal_rk3288
> >   F:     board/engicam/px30_core/
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index c9f1b25ad6..040238dede 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -166,6 +166,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) +=3D \
> >          rk3568-rock-3a.dtb
> >
> >   dtb-$(CONFIG_ROCKCHIP_RK3588) +=3D \
> > +       rk3588-armsom-sige7.dtb \
> >          rk3588s-coolpi-4b.dtb \
> >          rk3588-coolpi-cm5-evb.dtb \
> >          rk3588-edgeble-neu6a-io.dtb \
> > diff --git a/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..b9196ba5f5
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2024 ArmSoM Technology Co., Ltd.
> > + */
> > +
> > +#include "rk3588-u-boot.dtsi"
> > +
> > +&sdhci {
> > +       cap-mmc-highspeed;
>
> I think this isn't supported in U-Boot on RK35xx devices just yet? We
> force everything to be HS200+ anyway if I remember correctly.
>
> > +       mmc-hs200-1_8v;
> > +};
> > +
> > +&u2phy1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&u2phy1_otg {
> > +       status =3D "okay";
> > +};
> > +
> > +&usbdp_phy1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&usbdp_phy1_u3 {
> > +       status =3D "okay";
> > +};
> > +
> > +&usb_host1_xhci {
> > +       status =3D "okay";
> > +};
> > diff --git a/arch/arm/dts/rk3588-armsom-sige7.dts
> b/arch/arm/dts/rk3588-armsom-sige7.dts
> > new file mode 100644
> > index 0000000000..c7b46536ec
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3588-armsom-sige7.dts
> > @@ -0,0 +1,691 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +       model =3D "ArmSoM Sige7";
> > +       compatible =3D "armsom,sige7", "rockchip,rk3588";
> > +
> > +       aliases {
> > +               mmc0 =3D &sdhci;
> > +               mmc1 =3D &sdmmc;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial2:1500000n8";
> > +       };
> > +
> > +       analog-sound {
> > +               compatible =3D "audio-graph-card";
> > +               dais =3D <&i2s0_8ch_p0>;
> > +               label =3D "rk3588-es8316";
> > +               hp-det-gpio =3D <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&hp_detect>;
> > +               routing =3D "MIC2", "Mic Jack",
> > +                         "Headphones", "HPOL",
> > +                         "Headphones", "HPOR";
> > +               widgets =3D "Microphone", "Mic Jack",
> > +                         "Headphone", "Headphones";
> > +       };
> > +
> > +       leds {
> > +               compatible =3D "gpio-leds";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&led_rgb_g>;
> > +
> > +               led_green: led-0 {
> > +                       color =3D <LED_COLOR_ID_GREEN>;
> > +                       function =3D LED_FUNCTION_STATUS;
> > +                       gpios =3D <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> > +                       linux,default-trigger =3D "heartbeat";
> > +               };
> > +
> > +               led_red: led-1 {
> > +                       color =3D <LED_COLOR_ID_RED>;
> > +                       function =3D LED_FUNCTION_STATUS;
> > +                       gpios =3D <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> > +                       linux,default-trigger =3D "none";
> > +               };
> > +       };
> > +
> > +       fan: pwm-fan {
> > +               compatible =3D "pwm-fan";
> > +               cooling-levels =3D <0 95 145 195 255>;
> > +               fan-supply =3D <&vcc5v0_sys>;
> > +               pwms =3D <&pwm1 0 50000 0>;
> > +               #cooling-cells =3D <2>;
> > +       };
> > +
> > +       vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc3v3_pcie2x1l2";
> > +               regulator-min-microvolt =3D <3300000>;
> > +               regulator-max-microvolt =3D <3300000>;
> > +               startup-delay-us =3D <5000>;
> > +               vin-supply =3D <&vcc_3v3_s3>;
> > +       };
> > +
> > +       vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> > +               compatible =3D "regulator-fixed";
> > +               enable-active-high;
> > +               gpios =3D <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> > +               regulator-name =3D "vcc3v3_pcie30";
> > +               regulator-min-microvolt =3D <3300000>;
> > +               regulator-max-microvolt =3D <3300000>;
> > +               startup-delay-us =3D <5000>;
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +       };
> > +
> > +       vcc5v0_host: vcc5v0-host-regulator {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc5v0_host";
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +               regulator-min-microvolt =3D <5000000>;
> > +               regulator-max-microvolt =3D <5000000>;
> > +               enable-active-high;
> > +               gpio =3D <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&vcc5v0_host_en>;
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +       };
> > +
> > +       vcc5v0_sys: vcc5v0-sys-regulator {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc5v0_sys";
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +               regulator-min-microvolt =3D <5000000>;
> > +               regulator-max-microvolt =3D <5000000>;
> > +       };
> > +
> > +       vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc_1v1_nldo_s3";
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +               regulator-min-microvolt =3D <1100000>;
> > +               regulator-max-microvolt =3D <1100000>;
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +       };
> > +};
> > +
> > +&combphy0_ps {
> > +       status =3D "okay";
> > +};
> > +
> > +&combphy1_ps {
> > +       status =3D "okay";
> > +};
> > +
> > +&combphy2_psu {
> > +       status =3D "okay";
> > +};
> > +
> > +&cpu_b0 {
> > +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> > +};
> > +
> > +&cpu_b1 {
> > +       cpu-supply =3D <&vdd_cpu_big0_s0>;
> > +};
> > +
> > +&cpu_b2 {
> > +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> > +};
> > +
> > +&cpu_b3 {
> > +       cpu-supply =3D <&vdd_cpu_big1_s0>;
> > +};
> > +
> > +&cpu_l0 {
> > +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l1 {
> > +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l2 {
> > +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l3 {
> > +       cpu-supply =3D <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&i2c0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&i2c0m2_xfer>;
> > +       status =3D "okay";
> > +
> > +       vdd_cpu_big0_s0: regulator@42 {
> > +               compatible =3D "rockchip,rk8602";
> > +               reg =3D <0x42>;
> > +               fcs,suspend-voltage-selector =3D <1>;
> > +               regulator-name =3D "vdd_cpu_big0_s0";
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +               regulator-min-microvolt =3D <550000>;
> > +               regulator-max-microvolt =3D <1050000>;
> > +               regulator-ramp-delay =3D <2300>;
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +
> > +               regulator-state-mem {
> > +                       regulator-off-in-suspend;
> > +               };
> > +       };
> > +
> > +       vdd_cpu_big1_s0: regulator@43 {
> > +               compatible =3D "rockchip,rk8603", "rockchip,rk8602";
> > +               reg =3D <0x43>;
> > +               fcs,suspend-voltage-selector =3D <1>;
> > +               regulator-name =3D "vdd_cpu_big1_s0";
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +               regulator-min-microvolt =3D <550000>;
> > +               regulator-max-microvolt =3D <1050000>;
> > +               regulator-ramp-delay =3D <2300>;
> > +               vin-supply =3D <&vcc5v0_sys>;
> > +
> > +               regulator-state-mem {
> > +                       regulator-off-in-suspend;
> > +               };
> > +       };
> > +};
> > +
> > +&i2c6 {
> > +       status =3D "okay";
> > +
> > +       hym8563: rtc@51 {
> > +               compatible =3D "haoyu,hym8563";
> > +               reg =3D <0x51>;
> > +               interrupt-parent =3D <&gpio0>;
> > +               interrupts =3D <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> > +               #clock-cells =3D <0>;
> > +               clock-output-names =3D "hym8563";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&hym8563_int>;
> > +               wakeup-source;
> > +       };
> > +};
> > +
> > +&i2c7 {
> > +       status =3D "okay";
> > +
> > +       es8316: audio-codec@11 {
> > +               compatible =3D "everest,es8316";
> > +               reg =3D <0x11>;
> > +               assigned-clocks =3D <&cru I2S0_8CH_MCLKOUT>;
> > +               assigned-clock-rates =3D <12288000>;
> > +               clocks =3D <&cru I2S0_8CH_MCLKOUT>;
> > +               clock-names =3D "mclk";
> > +               #sound-dai-cells =3D <0>;
> > +
> > +               port {
> > +                       es8316_p0_0: endpoint {
> > +                               remote-endpoint =3D <&i2s0_8ch_p0_0>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&i2s0_8ch {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&i2s0_lrck
> > +                    &i2s0_mclk
> > +                    &i2s0_sclk
> > +                    &i2s0_sdi0
> > +                    &i2s0_sdo0>;
> > +       status =3D "okay";
> > +
> > +       i2s0_8ch_p0: port {
> > +               i2s0_8ch_p0_0: endpoint {
> > +                       dai-format =3D "i2s";
> > +                       mclk-fs =3D <256>;
> > +                       remote-endpoint =3D <&es8316_p0_0>;
> > +               };
> > +       };
> > +};
> > +
> > +/* phy1 - right ethernet port */
> > +&pcie2x1l0 {
> > +       reset-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> > +       status =3D "okay";
> > +};
> > +
> > +/* phy2 - WiFi */
> > +&pcie2x1l1 {
> > +       reset-gpios =3D <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
> > +       status =3D "okay";
> > +};
> > +
> > +/* phy0 - left ethernet port */
> > +&pcie2x1l2 {
> > +       reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> > +       status =3D "okay";
> > +};
> > +
> > +&pcie30phy {
> > +       status =3D "okay";
> > +};
> > +
> > +&pcie3x4 {
> > +       reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> > +       vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> > +       status =3D "okay";
> > +};
> > +
> > +&pinctrl {
> > +       hym8563 {
> > +               hym8563_int: hym8563-int {
> > +                       rockchip,pins =3D <0 RK_PB0 RK_FUNC_GPIO
> &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> > +       leds {
> > +               led_rgb_g: led-rgb-g {
> > +                       rockchip,pins =3D <0 RK_PB7 RK_FUNC_GPIO
> &pcfg_pull_none>;
> > +               };
> > +               led_rgb_r: led-rgb-r {
> > +                       rockchip,pins =3D <0 RK_PB7 RK_FUNC_GPIO
> &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> > +       sound {
> > +               hp_detect: hp-detect {
> > +                       rockchip,pins =3D <1 RK_PD5 RK_FUNC_GPIO
> &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> > +       usb {
> > +               vcc5v0_host_en: vcc5v0-host-en {
> > +                       rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO
> &pcfg_pull_none>;
> > +               };
> > +       };
> > +};
> > +
> > +&pwm1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&saradc {
> > +       vref-supply =3D <&avcc_1v8_s0>;
> > +       status =3D "okay";
> > +};
> > +
> > +&sdhci {
> > +       bus-width =3D <8>;
> > +       no-sdio;
> > +       no-sd;
> > +       non-removable;
> > +       mmc-hs200-1_8v;
> > +       status =3D "okay";
> > +};
> > +
> > +&sdmmc {
> > +       bus-width =3D <4>;
> > +       cap-mmc-highspeed;
> > +       cap-sd-highspeed;
> > +       disable-wp;
> > +       max-frequency =3D <200000000>;
> > +       no-sdio;
> > +       no-mmc;
> > +       sd-uhs-sdr104;
> > +       vmmc-supply =3D <&vcc_3v3_s3>;
> > +       vqmmc-supply =3D <&vccio_sd_s0>;
> > +       status =3D "okay";
> > +};
> > +
> > +&spi2 {
> > +       assigned-clocks =3D <&cru CLK_SPI2>;
> > +       assigned-clock-rates =3D <200000000>;
> > +       num-cs =3D <1>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&spi2m2_cs0 &spi2m2_pins>;
> > +       status =3D "okay";
> > +
> > +       pmic@0 {
> > +               compatible =3D "rockchip,rk806";
> > +               spi-max-frequency =3D <1000000>;
> > +               reg =3D <0x0>;
> > +
> > +               interrupt-parent =3D <&gpio0>;
> > +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells =3D <2>;
> > +
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pmic_pins>, <&rk806_dvs1_null>,
> > +                           <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> > +
> > +               system-power-controller;
> > +
> > +               vcc1-supply =3D <&vcc5v0_sys>;
> > +               vcc2-supply =3D <&vcc5v0_sys>;
> > +               vcc3-supply =3D <&vcc5v0_sys>;
> > +               vcc4-supply =3D <&vcc5v0_sys>;
> > +               vcc5-supply =3D <&vcc5v0_sys>;
> > +               vcc6-supply =3D <&vcc5v0_sys>;
> > +               vcc7-supply =3D <&vcc5v0_sys>;
> > +               vcc8-supply =3D <&vcc5v0_sys>;
> > +               vcc9-supply =3D <&vcc5v0_sys>;
> > +               vcc10-supply =3D <&vcc5v0_sys>;
> > +               vcc11-supply =3D <&vcc_2v0_pldo_s3>;
> > +               vcc12-supply =3D <&vcc5v0_sys>;
> > +               vcc13-supply =3D <&vcc_1v1_nldo_s3>;
> > +               vcc14-supply =3D <&vcc_1v1_nldo_s3>;
> > +               vcca-supply =3D <&vcc5v0_sys>;
> > +
> > +               rk806_dvs1_null: dvs1-null-pins {
> > +                       pins =3D "gpio_pwrctrl1";
> > +                       function =3D "pin_fun0";
> > +               };
> > +
> > +               rk806_dvs2_null: dvs2-null-pins {
> > +                       pins =3D "gpio_pwrctrl2";
> > +                       function =3D "pin_fun0";
> > +               };
> > +
> > +               rk806_dvs3_null: dvs3-null-pins {
> > +                       pins =3D "gpio_pwrctrl3";
> > +                       function =3D "pin_fun0";
> > +               };
> > +
> > +               regulators {
> > +                       vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <550000>;
> > +                               regulator-max-microvolt =3D <950000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_gpu_s0";
> > +                               regulator-enable-ramp-delay =3D <400>;
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <550000>;
> > +                               regulator-max-microvolt =3D <950000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_cpu_lit_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vdd_log_s0: dcdc-reg3 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <675000>;
> > +                               regulator-max-microvolt =3D <750000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_log_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <750000>;
> > +                               };
> > +                       };
> > +
> > +                       vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <550000>;
> > +                               regulator-max-microvolt =3D <950000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_vdenc_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vdd_ddr_s0: dcdc-reg5 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <675000>;
> > +                               regulator-max-microvolt =3D <900000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_ddr_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <850000>;
> > +                               };
> > +                       };
> > +
> > +                       vdd2_ddr_s3: dcdc-reg6 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-name =3D "vdd2_ddr_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vcc_2v0_pldo_s3: dcdc-reg7 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <2000000>;
> > +                               regulator-max-microvolt =3D <2000000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vdd_2v0_pldo_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <2000000>;
> > +                               };
> > +                       };
> > +
> > +                       vcc_3v3_s3: dcdc-reg8 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc_3v3_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <3300000>;
> > +                               };
> > +                       };
> > +
> > +                       vddq_ddr_s0: dcdc-reg9 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-name =3D "vddq_ddr_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vcc_1v8_s3: dcdc-reg10 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "vcc_1v8_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <1800000>;
> > +                               };
> > +                       };
> > +
> > +                       avcc_1v8_s0: pldo-reg1 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "avcc_1v8_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vcc_1v8_s0: pldo-reg2 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "vcc_1v8_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <1800000>;
> > +                               };
> > +                       };
> > +
> > +                       avdd_1v2_s0: pldo-reg3 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1200000>;
> > +                               regulator-max-microvolt =3D <1200000>;
> > +                               regulator-name =3D "avdd_1v2_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vcc_3v3_s0: pldo-reg4 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vcc_3v3_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vccio_sd_s0: pldo-reg5 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-ramp-delay =3D <12500>;
> > +                               regulator-name =3D "vccio_sd_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       pldo6_s3: pldo-reg6 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "pldo6_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <1800000>;
> > +                               };
> > +                       };
> > +
> > +                       vdd_0v75_s3: nldo-reg1 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <750000>;
> > +                               regulator-max-microvolt =3D <750000>;
> > +                               regulator-name =3D "vdd_0v75_s3";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <750000>;
> > +                               };
> > +                       };
> > +
> > +                       vdd_ddr_pll_s0: nldo-reg2 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <850000>;
> > +                               regulator-max-microvolt =3D <850000>;
> > +                               regulator-name =3D "vdd_ddr_pll_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                                       regulator-suspend-microvolt =3D
> <850000>;
> > +                               };
> > +                       };
> > +
> > +                       avdd_0v75_s0: nldo-reg3 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <750000>;
> > +                               regulator-max-microvolt =3D <750000>;
> > +                               regulator-name =3D "avdd_0v75_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vdd_0v85_s0: nldo-reg4 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <850000>;
> > +                               regulator-max-microvolt =3D <850000>;
> > +                               regulator-name =3D "vdd_0v85_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +
> > +                       vdd_0v75_s0: nldo-reg5 {
> > +                               regulator-always-on;
> > +                               regulator-boot-on;
> > +                               regulator-min-microvolt =3D <750000>;
> > +                               regulator-max-microvolt =3D <750000>;
> > +                               regulator-name =3D "vdd_0v75_s0";
> > +
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&u2phy3 {
> > +       status =3D "okay";
> > +};
> > +
> > +&u2phy3_host {
> > +       phy-supply =3D <&vcc5v0_host>;
> > +       status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +       pinctrl-0 =3D <&uart2m0_xfer>;
> > +       status =3D "okay";
> > +};
> > +
> > +&usb_host1_ehci {
> > +       status =3D "okay";
> > +};
> > +
> > +&usb_host1_ohci {
> > +       status =3D "okay";
> > +};
> > diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig
> b/arch/arm/mach-rockchip/rk3588/Kconfig
> > index 39049ab35a..4c14b0be1e 100644
> > --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> > @@ -152,6 +152,31 @@ config TARGET_ROCK5B_RK3588
> >            USB PD over USB Type-C
> >            Size: 100mm x 72mm (Pico-ITX form factor)
> >
> > +config TARGET_SIGE7_RK3588
> > +       bool "ArmSoM Sige7 RK3588 board"
> > +       select BOARD_LATE_INIT
> > +       help
> > +         ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board
> Computer)
> > +         by ArmSoM.
> > +
> > +         There are two variants depending on the DRAM size : 8G and 16=
G.
> > +
> > +         Specification:
> > +
> > +         Rockchip Rk3588 SoC
> > +         4x ARM Cortex-A76, 4x ARM Cortex-A55
> > +         8/16GB memory LPDDR4x
> > +         Mali G610MC4 GPU
> > +         2x MIPI CSI 2 multiple lanes connector
> > +         64GB/128GB on board eMMC
> > +         uSD slot
> > +         1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
> > +         1x HDMI 2.1 output
> > +         2x 2.5 Gbps Ethernet port
> > +         40-pin IO header including UART, SPI and I2C
> > +         USB PD over USB Type-C
> > +         Size: 92mm x 62mm
> > +
> >   config TARGET_QUARTZPRO64_RK3588
> >          bool "Pine64 QuartzPro64 RK3588 board"
> >          select BOARD_LATE_INIT
> > @@ -221,6 +246,7 @@ config ROCKCHIP_COMMON_STACK_ADDR
> >   config TEXT_BASE
> >          default 0x00a00000
> >
> > +source "board/armsom/sige7-rk3588/Kconfig"
> >   source "board/edgeble/neural-compute-module-6/Kconfig"
> >   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
> >   source "board/pine64/quartzpro64-rk3588/Kconfig"
> > diff --git a/board/armsom/sige7-rk3588/Kconfig
> b/board/armsom/sige7-rk3588/Kconfig
> > new file mode 100644
> > index 0000000000..793985f531
> > --- /dev/null
> > +++ b/board/armsom/sige7-rk3588/Kconfig
> > @@ -0,0 +1,12 @@
> > +if TARGET_SIGE7_RK3588
> > +
> > +config SYS_BOARD
> > +       default "sige7-rk3588"
> > +
> > +config SYS_VENDOR
> > +       default "armsom"
> > +
> > +config SYS_CONFIG_NAME
> > +       default "sige7-rk3588"
> > +
> > +endif
> > diff --git a/board/armsom/sige7-rk3588/MAINTAINERS
> b/board/armsom/sige7-rk3588/MAINTAINERS
> > new file mode 100644
> > index 0000000000..0b84946284
> > --- /dev/null
> > +++ b/board/armsom/sige7-rk3588/MAINTAINERS
> > @@ -0,0 +1,8 @@
> > +SIGE7-RK3588
> > +M:     Jianfeng Liu <liujianfeng1994@gmail.com>
> > +S:     Maintained
> > +F:     board/armsom/sige7-rk3588
> > +F:     include/configs/sige7-rk3588.h
> > +F:     configs/sige7-rk3588_defconfig
> > +F:     arch/arm/dts/rk3588-armsom-sige7.dts
> > +F:     arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>
> I would recommend using
> arch/arm/dts/rk3588-armsom-sige7* here instead, as to not have to
> maintain a list of DTSes (e.g. if overlays are supported one day?)
>
> > diff --git a/configs/sige7-rk3588_defconfig
> b/configs/sige7-rk3588_defconfig
> > new file mode 100644
> > index 0000000000..76fcd2878c
> > --- /dev/null
> > +++ b/configs/sige7-rk3588_defconfig
> > @@ -0,0 +1,104 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_SF_DEFAULT_SPEED=3D24000000
> > +CONFIG_SF_DEFAULT_MODE=3D0x2000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3588-armsom-sige7"
> > +CONFIG_ROCKCHIP_RK3588=3Dy
> > +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
>
> The wiki doesn't seem to indicate there's any SPI flash on that device
> so I don't think we need to support anything related to it, especially
> the creation of the image to flash on an SPI nor?
>
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_TARGET_SIGE7_RK3588=3Dy
> > +CONFIG_DEBUG_UART_BASE=3D0xFEB50000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> > +CONFIG_SPL_SPI=3Dy
> > +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> > +CONFIG_PCI=3Dy
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_AHCI=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3588-armsom-sige7.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_PAD_TO=3D0x7f8000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_SPI_LOAD=3Dy
> > +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x60000
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_I2C=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PCI=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +CONFIG_CMD_ROCKUSB=3Dy
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_REGULATOR=3Dy
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_OF_LIVE=3Dy
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent
> assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_AHCI_PCI=3Dy
> > +CONFIG_DWC_AHCI=3Dy
> > +CONFIG_SPL_CLK=3Dy
> > +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_SF_DEFAULT_BUS=3D5
> > +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> > +CONFIG_SPI_FLASH_MACRONIX=3Dy
> > +CONFIG_SPI_FLASH_XTX=3Dy
>
> Ditto.
>
> > +CONFIG_PHYLIB=3Dy
> > +CONFIG_RTL8169=3Dy
> > +CONFIG_NVME_PCI=3Dy
> > +CONFIG_PCIE_DW_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> > +CONFIG_PHY_ROCKCHIP_USBDP=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_PWM_ROCKCHIP=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_SCSI=3Dy
> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_ROCKCHIP_SFC=3Dy
>
> Ditto.
>
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
> > +CONFIG_USB_HOST_ETHER=3Dy
> > +CONFIG_USB_ETHER_ASIX=3Dy
> > +CONFIG_USB_ETHER_ASIX88179=3Dy
> > +CONFIG_USB_ETHER_LAN75XX=3Dy
> > +CONFIG_USB_ETHER_LAN78XX=3Dy
> > +CONFIG_USB_ETHER_MCS7830=3Dy
> > +CONFIG_USB_ETHER_RTL8152=3Dy
> > +CONFIG_USB_ETHER_SMSC95XX=3Dy
>
> I'm surprised to see USB_ETHER support here? Is this something done on
> purpose? The board already has two 2.5Gbps Ethernet, are they not working=
?
>
> Cheers,
> Quentin
>
