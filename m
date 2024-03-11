Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66341C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 20:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0E187F0D;
	Mon, 11 Mar 2024 21:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAshHve2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B54487EF7; Mon, 11 Mar 2024 21:11:06 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEED87EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 21:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peron.clem@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513b1c69cb8so963704e87.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710187858; x=1710792658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gPpCjtyk7TuUaCVq95Hrn0Bm3fEH4LCM7YF5UhFpXA=;
 b=XAshHve2sm1nQwrhcscPJPc8R0YpnkLphPI6B/JAEcSw7rbXdzNrBoUvJOkO51Ridi
 HJELDCMEmrvzpQtTF+VLXYqvm36YWnIOeGpgv5AWGmgy9b9J9BuJN7+oQCkXQR3o386q
 hpKE8lugqIHBlIeZxxxp8V+QQJRLchYpbnJ+G/YCzdydvUKb6it/9fynQv4d+8sXjFZz
 OMPK6jUc2jWD+HZIeZiJHzrlB52g6hlgOMr8CQVal71KxryzxG3mAst53PNBzidtx+zJ
 idf5bHpOp57vjf02t2T2c5Qak3g9IPHelxfN9quk3cjF3sS425by0w/y6C1UoqU4F+7I
 CXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187858; x=1710792658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gPpCjtyk7TuUaCVq95Hrn0Bm3fEH4LCM7YF5UhFpXA=;
 b=DdPT8CLQbLVkMvts0BsmVfKIQKrFgLpbn52wzAZejTxQeqzGQRWFNRqnlDTe4Q343p
 10+akMhbDq8FgGWZtxEbZdfRytnO+UwJkXwp1mDa3nAjikCmImH72LynOFw528ZXjicT
 C6hlOrkn6KzJH/5/VzMtN7hUEHxokhm99osSPgXPcXoYNwqhDiVVMlTVZpCo82/+3xOM
 jXS1m6KJdWYcZGxm8zScDzO4RnK13FtIxTBuJJa7f/0PQObTyqYs/3eeydqcs9wgMEeS
 JEt9dbCXsc+1/k94NLur8YmW7xslePnvhctCKGu7dD19p685SLTxPKBxuJShTAyxNSWv
 +oJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJS5qY0MGuwdtwkqEOhhLDMJNNHm8ij+cg4jIEDQxkMCmYQ+4MVO9bBxPx4UAC/qRCdL2q2OIXh94o81HUu/JNbSaOKA==
X-Gm-Message-State: AOJu0YzV/uiO0J4J932wEiufmWG00IXJf8krmepAAPpOXFqLwht133yS
 BdloCDmJo4NPHWbEApH8wNalS93eyzOkGqM1Z+UDFnfQLOHgcv5pymgXKGupLdfFms45a9WZQA0
 +xDOhgLPd8gQ4PcYDCV8oJgxPk4s=
X-Google-Smtp-Source: AGHT+IGYr4cPhea4AlHJCJdizYXqB09tVX9Ia6iIIl/hlo1qfq1a+7Ks14ukQL9jofKyFsho2KR+cDIWwKdP2EdLkKQ=
X-Received: by 2002:ac2:57c8:0:b0:513:9990:5997 with SMTP id
 k8-20020ac257c8000000b0051399905997mr3995971lfo.35.1710187857552; Mon, 11 Mar
 2024 13:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240309192425.40282-1-ressetkk@gmail.com>
 <20240310220004.0965e2ca@minigeek.lan>
 <CACttifJXW-WJjRBzDYk-TssS6v3XZD=Bc736zcH4emXr46cSPA@mail.gmail.com>
In-Reply-To: <CACttifJXW-WJjRBzDYk-TssS6v3XZD=Bc736zcH4emXr46cSPA@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Mon, 11 Mar 2024 21:10:45 +0100
Message-ID: <CAJiuCcegz07RnkCz_jfG3H_E0Vd08ZC2=Z1nCH09gD4=yfC6Ng@mail.gmail.com>
Subject: Re: [PATCH] sunxi: h616: add initial support for T95 AXP313 TV Box
To: Kamil Kasperski <ressetkk@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de, 
 linux-sunxi <linux-sunxi@lists.linux.dev>
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

Hi,

On Mon, 11 Mar 2024 at 11:38, Kamil Kasperski <ressetkk@gmail.com> wrote:
>
> Hello Andre,
> Thanks for your reply and thanks for pointing some stuff out.
>
> > What is "mbox"? Do you have any more information about this vendor?
>
> "MBOX" refers to the "Model" string from system properties.
> The problem is that it's quite hard to pin the correct vendor, since
> the OS is built based on Google Pixel 2.
> You can see that the fingerprint contains strings only for this phone:
> [ro.build.fingerprint]:
> [google/walley/walleye:10/QP1A.191105.004/eng.cmj.20220408.125005:userdeb=
ug/test-keys]
> Setting the device model as Vendor string seemed to be the most safe bet.
> If you have any other suggestions, please let me know.

Maybe a suggestion could be "YAGALA"

If you look on amazon, aliexpress you could find some vendors setting
the brand to this name.

Regards,

>
> > But please note that the devicetree needs to go through the Linux
> > mailing lists and repo first, and we automatically copy it from the
> > Linux tree once it has been merged there.
>
> Thanks for pointing that out. I'll contact Linux maintainers
> and will send updated patch.
>
> Best regards,
> Kamil
>
>
> niedz., 10 mar 2024 o 23:00 Andre Przywara <andre.przywara@arm.com> napis=
a=C5=82(a):
> >
> > On Sat,  9 Mar 2024 19:24:26 +0000
> > Kamil Kasperski <ressetkk@gmail.com> wrote:
> >
> > Hi Kamil,
> >
> > many thanks for sending a patch, that looks mostly good from the
> > technical point of view, only some smaller comments.
> >
> > But please note that the devicetree needs to go through the Linux
> > mailing lists and repo first, and we automatically copy it from the
> > Linux tree once it has been merged there. This is to ensure proper
> > review and checks with the Linux tooling.
> >
> > So can you please send just the .dts file to the DT and sunxi
> > maintainers the respective lists, as reported by get_maintainer.pl?
> > Then we can take it from there.
> >
> > > T95 is a most commonly known for being a box with a pre-installed mal=
ware.
> > > It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> > > This device comes with two versions - one with AXP305 PMIC and anothe=
r with AXP313 PMIC.
> > > The AXP313 version comes with Secure Boot enabled and locked bootload=
er, so the u-boot has to be built with TOC0.
> > > DRAM settings are taken from Allwinner's boot0 for this box.
> >
> > Ah, thanks for figuring those out, that's very helpful.
> >
> > >
> > > Cc: Andre Przywara <andre.przywara@arm.com>
> > >
> > > Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
> > > ---
> > >  arch/arm/dts/Makefile                   |   3 +-
> > >  arch/arm/dts/sun50i-h616-t95-axp313.dts | 148 ++++++++++++++++++++++=
++
> > >  configs/t95_axp313_defconfig            |  27 +++++
> > >  3 files changed, 177 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm/dts/sun50i-h616-t95-axp313.dts
> > >  create mode 100644 configs/t95_axp313_defconfig
> > >
> > > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > > index b102ffb5f6..144daf6c48 100644
> > > --- a/arch/arm/dts/Makefile
> > > +++ b/arch/arm/dts/Makefile
> > > @@ -842,7 +842,8 @@ dtb-$(CONFIG_MACH_SUN50I_H616) +=3D \
> > >       sun50i-h618-orangepi-zero2w.dtb \
> > >       sun50i-h618-orangepi-zero3.dtb \
> > >       sun50i-h618-transpeed-8k618-t.dtb \
> > > -     sun50i-h616-x96-mate.dtb
> > > +     sun50i-h616-x96-mate.dtb \
> > > +     sun50i-h616-t95-axp313.dtb
> > >  dtb-$(CONFIG_MACH_SUN50I) +=3D \
> > >       sun50i-a64-amarula-relic.dtb \
> > >       sun50i-a64-bananapi-m64.dtb \
> > > diff --git a/arch/arm/dts/sun50i-h616-t95-axp313.dts b/arch/arm/dts/s=
un50i-h616-t95-axp313.dts
> > > new file mode 100644
> > > index 0000000000..b006f363d5
> > > --- /dev/null
> > > +++ b/arch/arm/dts/sun50i-h616-t95-axp313.dts
> > > @@ -0,0 +1,148 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) 2021 Arm Ltd.
> >
> > Please change this copyright you and this year.
> >
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sun50i-h616.dtsi"
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +/ {
> > > +     model =3D "T95 (AXP313)";
> > > +     compatible =3D "mbox,t95-axp313", "allwinner,sun50i-h616";
> >
> > What is "mbox"? Do you have any more information about this vendor?
> > In any case a new vendor would need to be added to
> > Documentation/devicetree/bindings/vendor-prefixes.yaml, in a separate
> > patch. Also you need a patch to add this compatible combination to
> > Documentation/devicetree/bindings/arm/sunxi.yaml.
> >
> > Cheers,
> > Andre
> >
> > > +
> > > +     aliases {
> > > +             serial0 =3D &uart0;
> > > +     };
> > > +
> > > +     chosen {
> > > +             stdout-path =3D "serial0:115200n8";
> > > +     };
> > > +
> > > +     reg_vcc5v: vcc5v {
> > > +             /* board wide 5V supply directly from the DC input */
> > > +             compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "vcc-5v";
> > > +             regulator-min-microvolt =3D <5000000>;
> > > +             regulator-max-microvolt =3D <5000000>;
> > > +             regulator-always-on;
> > > +     };
> > > +};
> > > +
> > > +&ehci0 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ehci2 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ir {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&mmc0 {
> > > +     cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>; /* PI16 */
> > > +     vmmc-supply =3D <&reg_dldo1>;
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&mmc2 {
> > > +     vmmc-supply =3D <&reg_dldo1>;
> > > +     vqmmc-supply =3D <&reg_aldo1>;
> > > +     bus-width =3D <8>;
> > > +     non-removable;
> > > +     cap-mmc-hw-reset;
> > > +     mmc-ddr-1_8v;
> > > +     mmc-hs200-1_8v;
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ohci0 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&ohci2 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&r_i2c {
> > > +     status =3D "okay";
> > > +
> > > +     axp313: pmic@36 {
> > > +             compatible =3D "x-powers,axp313a";
> > > +             reg =3D <0x36>;
> > > +             #interrupt-cells =3D <1>;
> > > +             interrupt-controller;
> > > +             interrupt-parent =3D <&pio>;
> > > +             interrupts =3D <2 9 IRQ_TYPE_LEVEL_LOW>;  /* PC9 */
> > > +
> > > +             vin1-supply =3D <&reg_vcc5v>;
> > > +             vin2-supply =3D <&reg_vcc5v>;
> > > +             vin3-supply =3D <&reg_vcc5v>;
> > > +
> > > +             regulators {
> > > +                     /* Supplies VCC-PLL, so needs to be always on. =
*/
> > > +                     reg_aldo1: aldo1 {
> > > +                             regulator-always-on;
> > > +                             regulator-min-microvolt =3D <1800000>;
> > > +                             regulator-max-microvolt =3D <1800000>;
> > > +                             regulator-name =3D "vcc1v8";
> > > +                     };
> > > +
> > > +                     /* Supplies VCC-IO, so needs to be always on. *=
/
> > > +                     reg_dldo1: dldo1 {
> > > +                             regulator-always-on;
> > > +                             regulator-min-microvolt =3D <3300000>;
> > > +                             regulator-max-microvolt =3D <3300000>;
> > > +                             regulator-name =3D "vcc3v3";
> > > +                     };
> > > +
> > > +                     reg_dcdc1: dcdc1 {
> > > +                             regulator-always-on;
> > > +                             regulator-min-microvolt =3D <810000>;
> > > +                             regulator-max-microvolt =3D <990000>;
> > > +                             regulator-name =3D "vdd-gpu-sys";
> > > +                     };
> > > +
> > > +                     reg_dcdc2: dcdc2 {
> > > +                             regulator-always-on;
> > > +                             regulator-min-microvolt =3D <810000>;
> > > +                             regulator-max-microvolt =3D <1100000>;
> > > +                             regulator-name =3D "vdd-cpu";
> > > +                     };
> > > +
> > > +                     reg_dcdc3: dcdc3 {
> > > +                             regulator-always-on;
> > > +                             regulator-min-microvolt =3D <1360000>;
> > > +                             regulator-max-microvolt =3D <1360000>;
> > > +                             regulator-name =3D "vdd-dram";
> > > +                     };
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&pio {
> > > +     vcc-pc-supply =3D <&reg_aldo1>;
> > > +     vcc-pg-supply =3D <&reg_dldo1>;
> > > +     vcc-ph-supply =3D <&reg_dldo1>;
> > > +     vcc-pi-supply =3D <&reg_dldo1>;
> > > +};
> > > +
> > > +&uart0 {
> > > +     pinctrl-names =3D "default";
> > > +     pinctrl-0 =3D <&uart0_ph_pins>;
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&usbotg {
> > > +     dr_mode =3D "host";       /* USB A type receptable */
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&usbphy {
> > > +     status =3D "okay";
> > > +};
> > > diff --git a/configs/t95_axp313_defconfig b/configs/t95_axp313_defcon=
fig
> > > new file mode 100644
> > > index 0000000000..6542b5bc88
> > > --- /dev/null
> > > +++ b/configs/t95_axp313_defconfig
> > > @@ -0,0 +1,27 @@
> > > +CONFIG_ARM=3Dy
> > > +CONFIG_ARCH_SUNXI=3Dy
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h616-t95-axp313"
> > > +CONFIG_SPL=3Dy
> > > +CONFIG_MACH_SUN50I_H616=3Dy
> > > +CONFIG_DRAM_CLK=3D648
> > > +CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0x1
> > > +CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x03030303
> > > +CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> > > +CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x1c1c
> > > +CONFIG_DRAM_SUN50I_H616_TPR10=3D0x2f0006
> > > +CONFIG_DRAM_SUN50I_H616_TPR11=3D0xffffdddd
> > > +CONFIG_DRAM_SUN50I_H616_TPR12=3D0xfedf7657
> > > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy
> > > +CONFIG_R_I2C_ENABLE=3Dy
> > > +CONFIG_SPL_I2C=3Dy
> > > +CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> > > +CONFIG_SYS_I2C_MVTWSI=3Dy
> > > +CONFIG_SYS_I2C_SLAVE=3D0x7f
> > > +CONFIG_SYS_I2C_SPEED=3D400000
> > > +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> > > +CONFIG_AXP313_POWER=3Dy
> > > +CONFIG_AXP_DCDC3_VOLT=3D1360
> > > +CONFIG_USB_EHCI_HCD=3Dy
> > > +CONFIG_USB_OHCI_HCD=3Dy
> > > +CONFIG_SUN8I_EMAC=3Dy
> > > +CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0=3Dy
> >
>
>
> --
> Kamil Kasperski
>
