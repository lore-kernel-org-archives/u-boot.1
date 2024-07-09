Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01527C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 20:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FF48865D;
	Tue,  9 Jul 2024 22:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAN5Gl3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81D48865D; Tue,  9 Jul 2024 22:28:23 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E9D88652
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 22:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58b0beaf703so6880278a12.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720556900; x=1721161700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBFHwBzEqWht6IqNQxMZ6iUF+DZvNCLSfbY93tHEE0A=;
 b=QAN5Gl3iC4qWH6fQAf3X87TATwCNXH67VzjNYWYBgg11EF27bOih7oJ9A3TSR5NYlG
 rs7+mA5OMTPZCXgZRp8xu00F4momFpcoruMN0UpjEJGJEnYoXBvoJ4xJ7faL29gdbG9+
 z2NCjmYH6rzUjz+uxXAI39PQ4aOaIiH6WcV/QdbzJNrGiOakZYqB7gTJfFXN3tb533JO
 Lz+fJ8pP2dYw4X/ZPXwdJGz59HY5EsiED1CaKz0r2fNoQA43DC4cXvaZfHOiaHB0wLt6
 lzMLpclMaPcl3Ukw6mEWacZ2BJc4eP91BuYPzkV3e5PX0vnoWdZ6Y48TDn4jN1uTXC0N
 OGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720556900; x=1721161700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBFHwBzEqWht6IqNQxMZ6iUF+DZvNCLSfbY93tHEE0A=;
 b=Q/9MHKtEAzBXa8bXaXyjEVrKjREIyn78cKbYEtdB/rGf/+8H7GFsboMfu1zZeWkWuf
 KiIpYUOvxXqM6Ht9/d6BYvIXmukgg92jyaGraN+BohH53OmD5O2vmBrTITOtc9VgYi7z
 hAORxoFaNOphh3N76lMGu98ehfOtcJNSEicQYsveXbCgTlzsjR9I9yxxCcKmiNy/gGbA
 Maz1auk9oUQDFltft9nTZMZggHyDJrBC7eJtFv+F0VuILBgMY/CypeOyx1Acy19EpdxO
 pL0idM61Czjouhil7qOU+njp6fr92Po/IfGrcxPe56/nnrtYR149R7SBF6liDUbubs5l
 KX8w==
X-Gm-Message-State: AOJu0Yxo2NPn5XrFB/h2XznQc6dN7yUizmxIGtTpyMYjQG8yhhjfXS2a
 1jcmrQBli9mVyZK+aJnCSNMYuDxQ1E1b+RQIw12uVgU+41AvKJP9PUGvRuKz0ls059HBfflLlB6
 Ck9gBQNR47uyesIHa/HUPF406e2o=
X-Google-Smtp-Source: AGHT+IGJtzRwlkBG0XCk7g9vMNNB/rRPx4ZaoOrhR9WnlwOZ+5sx+BCSaRJjleDdQFxf9MdXMGKAYXIU/xog4l2wSLw=
X-Received: by 2002:a05:6402:280a:b0:584:2314:e8a0 with SMTP id
 4fb4d7f45d1cf-594bc7c824amr2769644a12.28.1720556899655; Tue, 09 Jul 2024
 13:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240522215200.16199-1-mibodhi@gmail.com>
 <CAFA6WYMb1vK_ZtECYmWesVBrd8ssOs123owarF1pEcqNE2R9vA@mail.gmail.com>
In-Reply-To: <CAFA6WYMb1vK_ZtECYmWesVBrd8ssOs123owarF1pEcqNE2R9vA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 9 Jul 2024 13:27:52 -0700
Message-ID: <CAJaLiFx5VdVYy2yquOAdD1mvuyGnR83schmPWZBSBYdUpxc81g@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: mvebu: Migrate to upstream DT for Synology
 DS116 (Armada 385) board
To: Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Stefan,

On Thu, May 23, 2024 at 12:27=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Thu, 23 May 2024 at 03:22, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> > DEFAULT_DEVICE_TREE in DS116 defconfig. Remove current DTS in
> > arch/arm/dts/ directory.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  arch/arm/dts/Makefile                      |   1 -
> >  arch/arm/dts/armada-385-synology-ds116.dts | 291 ---------------------
> >  configs/ds116_defconfig                    |   3 +-
> >  3 files changed, 2 insertions(+), 293 deletions(-)
> >  delete mode 100644 arch/arm/dts/armada-385-synology-ds116.dts
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit

Is this OK to be merged to next?

All the best,
Tony

>
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index a5c82ebf7a..75f7e616b4 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -155,7 +155,6 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D                 \
> >         armada-385-atl-x530.dtb                 \
> >         armada-385-atl-x530DP.dtb               \
> >         armada-385-db-88f6820-amc.dtb           \
> > -       armada-385-synology-ds116.dtb           \
> >         armada-385-thecus-n2350.dtb             \
> >         armada-385-turris-omnia.dtb             \
> >         armada-388-clearfog.dtb                 \
> > diff --git a/arch/arm/dts/armada-385-synology-ds116.dts b/arch/arm/dts/=
armada-385-synology-ds116.dts
> > deleted file mode 100644
> > index 82a0373f7f..0000000000
> > --- a/arch/arm/dts/armada-385-synology-ds116.dts
> > +++ /dev/null
> > @@ -1,291 +0,0 @@
> > -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > -/*
> > - * Device Tree file for Synology DS116 NAS
> > - *
> > - * Copyright (C) 2017 Willy Tarreau <w@1wt.eu>
> > - */
> > -
> > -/dts-v1/;
> > -#include "armada-385.dtsi"
> > -#include <dt-bindings/gpio/gpio.h>
> > -
> > -/ {
> > -       model =3D "Synology DS116";
> > -       compatible =3D "marvell,a385-gp", "marvell,armada385", "marvell=
,armada380";
> > -
> > -       chosen {
> > -               stdout-path =3D "serial0:115200n8";
> > -       };
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x40000000>; /* 1 GB */
> > -       };
> > -
> > -       soc {
> > -               ranges =3D <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> > -                         MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> > -                         MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> > -                         MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> > -                         MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
> > -
> > -               internal-regs {
> > -                       i2c@11000 {
> > -                               pinctrl-names =3D "default";
> > -                               pinctrl-0 =3D <&i2c0_pins>;
> > -                               status =3D "okay";
> > -                               clock-frequency =3D <100000>;
> > -
> > -                               eeprom@57 {
> > -                                       compatible =3D "atmel,24c64";
> > -                                       reg =3D <0x57>;
> > -                               };
> > -                       };
> > -
> > -                       serial@12000 {
> > -                               pinctrl-names =3D "default";
> > -                               pinctrl-0 =3D <&uart0_pins>;
> > -                               status =3D "okay";
> > -                       };
> > -
> > -                       serial@12100 {
> > -                               /* A PIC16F1829 is connected to uart1 a=
t 9600 bps,
> > -                                * and takes single-character orders :
> > -                                *   "1" : power off // already handled=
 by the poweroff node
> > -                                *   "2" : short beep
> > -                                *   "3" : long beep
> > -                                *   "4" : turn the power LED ON
> > -                                *   "5" : flash the power LED
> > -                                *   "6" : turn the power LED OFF
> > -                                *   "7" : turn the status LED OFF
> > -                                *   "8" : turn the status LED ON
> > -                                *   "9" : flash the status LED
> > -                                *   "A" : flash the motherboard LED (D=
8)
> > -                                *   "B" : turn the motherboard LED OFF
> > -                                *   "C" : hard reset
> > -                                */
> > -                               pinctrl-names =3D "default";
> > -                               pinctrl-0 =3D <&uart1_pins>;
> > -                               status =3D "okay";
> > -                       };
> > -
> > -                       poweroff@12100 {
> > -                               compatible =3D "synology,power-off";
> > -                               reg =3D <0x12100 0x100>;
> > -                               clocks =3D <&coreclk 0>;
> > -                       };
> > -
> > -                       ethernet@70000 {
> > -                               pinctrl-names =3D "default";
> > -                               phy =3D <&phy0>;
> > -                               phy-mode =3D "sgmii";
> > -                               buffer-manager =3D <&bm>;
> > -                               bm,pool-long =3D <0>;
> > -                               status =3D "okay";
> > -                       };
> > -
> > -                       mdio@72004 {
> > -                               pinctrl-names =3D "default";
> > -                               pinctrl-0 =3D <&mdio_pins>;
> > -
> > -                               phy0: ethernet-phy@1 {
> > -                                       reg =3D <1>;
> > -                               };
> > -                       };
> > -
> > -                       sata@a8000 {
> > -                               pinctrl-names =3D "default";
> > -                               pinctrl-0 =3D <&sata0_pins>;
> > -                               status =3D "okay";
> > -                               #address-cells =3D <1>;
> > -                               #size-cells =3D <0>;
> > -
> > -                               sata0: sata-port@0 {
> > -                                       reg =3D <0>;
> > -                                       target-supply =3D <&reg_5v_sata=
0>;
> > -                               };
> > -                       };
> > -
> > -                       bm@c8000 {
> > -                               status =3D "okay";
> > -                       };
> > -
> > -                       usb3@f0000 {
> > -                               usb-phy =3D <&usb3_0_phy>;
> > -                               status =3D "okay";
> > -                       };
> > -
> > -                       usb3@f8000 {
> > -                               usb-phy =3D <&usb3_1_phy>;
> > -                               status =3D "okay";
> > -                       };
> > -               };
> > -
> > -               bm-bppi {
> > -                       status =3D "okay";
> > -               };
> > -
> > -               gpio-fan {
> > -                       compatible =3D "gpio-fan";
> > -                       gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>,
> > -                               <&gpio1 17 GPIO_ACTIVE_HIGH>,
> > -                               <&gpio1 16 GPIO_ACTIVE_HIGH>;
> > -                       gpio-fan,speed-map =3D <   0 0
> > -                                             1500 1
> > -                                             2500 2
> > -                                             3000 3
> > -                                             3400 4
> > -                                             3700 5
> > -                                             3900 6
> > -                                             4000 7>;
> > -                       #cooling-cells =3D <2>;
> > -               };
> > -
> > -               gpio-leds {
> > -                       compatible =3D "gpio-leds";
> > -
> > -                       /* The green part is on gpio0.20 which is also =
used by
> > -                        * sata0, and accesses to SATA disk 0 make it b=
link so it
> > -                        * doesn't need to be declared here.
> > -                        */
> > -                       orange {
> > -                               gpios =3D <&gpio0 13 GPIO_ACTIVE_HIGH>;
> > -                               label =3D "ds116:orange:disk";
> > -                               default-state =3D "off";
> > -                       };
> > -               };
> > -       };
> > -
> > -       usb3_0_phy: usb3_0_phy {
> > -               compatible =3D "usb-nop-xceiv";
> > -               vcc-supply =3D <&reg_usb3_0_vbus>;
> > -               #phy-cells =3D <0>;
> > -       };
> > -
> > -       usb3_1_phy: usb3_1_phy {
> > -               compatible =3D "usb-nop-xceiv";
> > -               vcc-supply =3D <&reg_usb3_1_vbus>;
> > -               #phy-cells =3D <0>;
> > -       };
> > -
> > -       reg_usb3_0_vbus: usb3-vbus0 {
> > -               compatible =3D "regulator-fixed";
> > -               regulator-name =3D "usb3-vbus0";
> > -               pinctrl-names =3D "default";
> > -               pinctrl-0 =3D <&xhci0_vbus_pins>;
> > -               regulator-min-microvolt =3D <5000000>;
> > -               regulator-max-microvolt =3D <5000000>;
> > -               enable-active-high;
> > -               gpio =3D <&gpio1 26 GPIO_ACTIVE_HIGH>;
> > -       };
> > -
> > -       reg_usb3_1_vbus: usb3-vbus1 {
> > -               compatible =3D "regulator-fixed";
> > -               regulator-name =3D "usb3-vbus1";
> > -               pinctrl-names =3D "default";
> > -               pinctrl-0 =3D <&xhci1_vbus_pins>;
> > -               regulator-min-microvolt =3D <5000000>;
> > -               regulator-max-microvolt =3D <5000000>;
> > -               enable-active-high;
> > -               gpio =3D <&gpio1 27 GPIO_ACTIVE_HIGH>;
> > -       };
> > -
> > -       reg_sata0: pwr-sata0 {
> > -               compatible =3D "regulator-fixed";
> > -               regulator-name =3D "pwr_en_sata0";
> > -               regulator-min-microvolt =3D <12000000>;
> > -               regulator-max-microvolt =3D <12000000>;
> > -               enable-active-high;
> > -               regulator-boot-on;
> > -               gpio =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> > -       };
> > -
> > -       reg_5v_sata0: v5-sata0 {
> > -               compatible =3D "regulator-fixed";
> > -               regulator-name =3D "v5.0-sata0";
> > -               regulator-min-microvolt =3D <5000000>;
> > -               regulator-max-microvolt =3D <5000000>;
> > -               vin-supply =3D <&reg_sata0>;
> > -       };
> > -
> > -       reg_12v_sata0: v12-sata0 {
> > -               compatible =3D "regulator-fixed";
> > -               regulator-name =3D "v12.0-sata0";
> > -               regulator-min-microvolt =3D <12000000>;
> > -               regulator-max-microvolt =3D <12000000>;
> > -               vin-supply =3D <&reg_sata0>;
> > -       };
> > -};
> > -
> > -&spi0 {
> > -       pinctrl-names =3D "default";
> > -       pinctrl-0 =3D <&spi0_pins>;
> > -       status =3D "okay";
> > -
> > -       spi-flash@0 {
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <1>;
> > -               compatible =3D "macronix,mx25l6405d", "jedec,spi-nor";
> > -               reg =3D <0>; /* Chip select 0 */
> > -               spi-max-frequency =3D <50000000>;
> > -               m25p,fast-read;
> > -
> > -               /* Note: there is a redboot partition table despite u-b=
oot
> > -                * being used. The names presented here are the same as=
 those
> > -                * found in the FIS directory. There is also a small de=
vice
> > -                * tree in the last 64kB of the RedBoot partition which=
 is not
> > -                * enumerated. The MAC address and the serial number ar=
e listed
> > -                * in the "vendor" partition.
> > -                */
> > -               partition@0 {
> > -                       label =3D "RedBoot";
> > -                       reg =3D <0x00000000 0x000f0000>;
> > -                       read-only;
> > -               };
> > -
> > -               partition@c0000 {
> > -                       label =3D "zImage";
> > -                       reg =3D <0x000f0000 0x002d0000>;
> > -               };
> > -
> > -               partition@390000 {
> > -                       label =3D "rd.gz";
> > -                       reg =3D <0x003c0000 0x00410000>;
> > -               };
> > -
> > -               partition@7d0000 {
> > -                       label =3D "vendor";
> > -                       reg =3D <0x007d0000 0x00010000>;
> > -                       read-only;
> > -               };
> > -
> > -               partition@7e0000 {
> > -                       label =3D "RedBoot config";
> > -                       reg =3D <0x007e0000 0x00010000>;
> > -                       read-only;
> > -               };
> > -
> > -               partition@7f0000 {
> > -                       label =3D "FIS directory";
> > -                       reg =3D <0x007f0000 0x00010000>;
> > -                       read-only;
> > -               };
> > -       };
> > -};
> > -
> > -&pinctrl {
> > -       /* use only one pin for UART1, as mpp20 is used by sata0 */
> > -       uart1_pins: uart-pins-1 {
> > -               marvell,pins =3D "mpp19";
> > -               marvell,function =3D "ua1";
> > -       };
> > -
> > -       xhci0_vbus_pins: xhci0_vbus_pins {
> > -               marvell,pins =3D "mpp58";
> > -               marvell,function =3D "gpio";
> > -       };
> > -       xhci1_vbus_pins: xhci1_vbus_pins {
> > -               marvell,pins =3D "mpp59";
> > -               marvell,function =3D "gpio";
> > -       };
> > -};
> > diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
> > index 1fc7380216..bcc5f00fe5 100644
> > --- a/configs/ds116_defconfig
> > +++ b/configs/ds116_defconfig
> > @@ -16,7 +16,7 @@ CONFIG_SF_DEFAULT_SPEED=3D50000000
> >  CONFIG_ENV_SIZE=3D0x10000
> >  CONFIG_ENV_OFFSET=3D0x7E0000
> >  CONFIG_ENV_SECT_SIZE=3D0x10000
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"armada-385-synology-ds116"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
> >  CONFIG_SPL_TEXT_BASE=3D0x40000030
> >  CONFIG_SPL_SERIAL=3Dy
> >  CONFIG_SPL_STACK=3D0x4002c000
> > @@ -56,6 +56,7 @@ CONFIG_CMD_CACHE=3Dy
> >  CONFIG_CMD_TIME=3Dy
> >  CONFIG_CMD_MTDPARTS=3Dy
> >  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dspi0.0:1m(u-boot),7040k(kernel),=
64k(u-boot-env),-(data)"
> > +CONFIG_OF_UPSTREAM=3Dy
> >  CONFIG_ENV_OVERWRITE=3Dy
> >  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> >  CONFIG_VERSION_VARIABLE=3Dy
> > --
> > 2.39.2
> >
