Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CB3C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7060887F9F;
	Mon, 11 Mar 2024 12:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LISCpHYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E404787EF5; Mon, 11 Mar 2024 11:38:04 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C7487D07
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ressetkk@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d2ab9c5e83so39133951fa.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710153482; x=1710758282; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22tCLLYLtNJDSGoevIKctbmHSUVOGVjfeJyX3Wbz8gM=;
 b=LISCpHYbDrnCNN29ter80cYkB8/kMtpS2KKP7JCmflEBgSKRKBhrkPWsqZj30j1CRf
 z3dLndQj2KF1ehgamJmdrJH3Gkrbas+GaDtpfUw637A8ZMsrjMgd01PVwzd71Q33ruKk
 CHgg/rE2m/mnFLawcJfZGJRruY/jnB6wXsCzg7CnOcgVn1SgS+AL3sSwIB95YMbm56r/
 zCqD77coBYOy1mPYd0t4aRe7uVuj0MBVhxV6vgBYRzayIVhn1Gr8PZ52711tDK991kts
 FGwBKznjQOYF+dS9/QI7QDqpA0bvDBmyAZ7XdjkFsDkXEF2yYOaJyDkOQ28QD3mZ6Obm
 NZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710153482; x=1710758282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22tCLLYLtNJDSGoevIKctbmHSUVOGVjfeJyX3Wbz8gM=;
 b=Gad/f11GQTw8ffluJHg3Kq+lkrKiR9M7bUeLq9xd5Ch3iss+ny+yQ+4ScQWW0ZQKil
 +UWYDWEfSQBeu4Zv9PSdIOQvOxfgFwtffesZjY4ly/uEl8HIIhBSnNOCek/ipMKn8RfE
 sDB2zRBff+V76al5qS6qCd/uD1MYdQryA4YMmXdVhEktgqPftxG1r0/+f9N/SzrSUnTf
 0S0kfxvC3lv7GISGfvjFF6LSpcCQRciRtNfgJbTjjVyZvfHKc2iDHVv40jfRU6FYPetb
 oQ0XW9vNXDaH5M6tjxWeuHE/Y0H+T2k5qf6BgOgi9q8CbbpEwyFoVgdsO6jwgLEURJGQ
 Mk+g==
X-Gm-Message-State: AOJu0YzEdG6BQXEoe1issGPEH7qV8IbQWneePVzk4f+p+zdWI4ifOKE8
 DHKBML2T/oId+T132z2iwbpW26PG15bpAU3+duCOBrWuFsqmoxlvj8qoRbGZPPS0+BV4RtxI2GF
 XWH2z6+AxRHW4+ijaLt5LWWf+4Ok=
X-Google-Smtp-Source: AGHT+IGEk/kgWD9uunkVgQaTcURosmY87vbz7ffnOR9uK+93L8bY1upRyp/mP/7LxmNfzekxjS/GOlyHmXEr4QndQPc=
X-Received: by 2002:a2e:9e10:0:b0:2d2:f5fa:f37e with SMTP id
 e16-20020a2e9e10000000b002d2f5faf37emr20559ljk.51.1710153481443; Mon, 11 Mar
 2024 03:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240309192425.40282-1-ressetkk@gmail.com>
 <20240310220004.0965e2ca@minigeek.lan>
In-Reply-To: <20240310220004.0965e2ca@minigeek.lan>
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Mon, 11 Mar 2024 11:37:49 +0100
Message-ID: <CACttifJXW-WJjRBzDYk-TssS6v3XZD=Bc736zcH4emXr46cSPA@mail.gmail.com>
Subject: Re: [PATCH] sunxi: h616: add initial support for T95 AXP313 TV Box
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 11 Mar 2024 12:12:53 +0100
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

Hello Andre,
Thanks for your reply and thanks for pointing some stuff out.

> What is "mbox"? Do you have any more information about this vendor?

"MBOX" refers to the "Model" string from system properties.
The problem is that it's quite hard to pin the correct vendor, since
the OS is built based on Google Pixel 2.
You can see that the fingerprint contains strings only for this phone:
[ro.build.fingerprint]:
[google/walley/walleye:10/QP1A.191105.004/eng.cmj.20220408.125005:userdebug=
/test-keys]
Setting the device model as Vendor string seemed to be the most safe bet.
If you have any other suggestions, please let me know.

> But please note that the devicetree needs to go through the Linux
> mailing lists and repo first, and we automatically copy it from the
> Linux tree once it has been merged there.

Thanks for pointing that out. I'll contact Linux maintainers
and will send updated patch.

Best regards,
Kamil


niedz., 10 mar 2024 o 23:00 Andre Przywara <andre.przywara@arm.com> napisa=
=C5=82(a):
>
> On Sat,  9 Mar 2024 19:24:26 +0000
> Kamil Kasperski <ressetkk@gmail.com> wrote:
>
> Hi Kamil,
>
> many thanks for sending a patch, that looks mostly good from the
> technical point of view, only some smaller comments.
>
> But please note that the devicetree needs to go through the Linux
> mailing lists and repo first, and we automatically copy it from the
> Linux tree once it has been merged there. This is to ensure proper
> review and checks with the Linux tooling.
>
> So can you please send just the .dts file to the DT and sunxi
> maintainers the respective lists, as reported by get_maintainer.pl?
> Then we can take it from there.
>
> > T95 is a most commonly known for being a box with a pre-installed malwa=
re.
> > It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> > This device comes with two versions - one with AXP305 PMIC and another =
with AXP313 PMIC.
> > The AXP313 version comes with Secure Boot enabled and locked bootloader=
, so the u-boot has to be built with TOC0.
> > DRAM settings are taken from Allwinner's boot0 for this box.
>
> Ah, thanks for figuring those out, that's very helpful.
>
> >
> > Cc: Andre Przywara <andre.przywara@arm.com>
> >
> > Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
> > ---
> >  arch/arm/dts/Makefile                   |   3 +-
> >  arch/arm/dts/sun50i-h616-t95-axp313.dts | 148 ++++++++++++++++++++++++
> >  configs/t95_axp313_defconfig            |  27 +++++
> >  3 files changed, 177 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/sun50i-h616-t95-axp313.dts
> >  create mode 100644 configs/t95_axp313_defconfig
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index b102ffb5f6..144daf6c48 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -842,7 +842,8 @@ dtb-$(CONFIG_MACH_SUN50I_H616) +=3D \
> >       sun50i-h618-orangepi-zero2w.dtb \
> >       sun50i-h618-orangepi-zero3.dtb \
> >       sun50i-h618-transpeed-8k618-t.dtb \
> > -     sun50i-h616-x96-mate.dtb
> > +     sun50i-h616-x96-mate.dtb \
> > +     sun50i-h616-t95-axp313.dtb
> >  dtb-$(CONFIG_MACH_SUN50I) +=3D \
> >       sun50i-a64-amarula-relic.dtb \
> >       sun50i-a64-bananapi-m64.dtb \
> > diff --git a/arch/arm/dts/sun50i-h616-t95-axp313.dts b/arch/arm/dts/sun=
50i-h616-t95-axp313.dts
> > new file mode 100644
> > index 0000000000..b006f363d5
> > --- /dev/null
> > +++ b/arch/arm/dts/sun50i-h616-t95-axp313.dts
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2021 Arm Ltd.
>
> Please change this copyright you and this year.
>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +     model =3D "T95 (AXP313)";
> > +     compatible =3D "mbox,t95-axp313", "allwinner,sun50i-h616";
>
> What is "mbox"? Do you have any more information about this vendor?
> In any case a new vendor would need to be added to
> Documentation/devicetree/bindings/vendor-prefixes.yaml, in a separate
> patch. Also you need a patch to add this compatible combination to
> Documentation/devicetree/bindings/arm/sunxi.yaml.
>
> Cheers,
> Andre
>
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     reg_vcc5v: vcc5v {
> > +             /* board wide 5V supply directly from the DC input */
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc-5v";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             regulator-always-on;
> > +     };
> > +};
> > +
> > +&ehci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ir {
> > +     status =3D "okay";
> > +};
> > +
> > +&mmc0 {
> > +     cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>; /* PI16 */
> > +     vmmc-supply =3D <&reg_dldo1>;
> > +     status =3D "okay";
> > +};
> > +
> > +&mmc2 {
> > +     vmmc-supply =3D <&reg_dldo1>;
> > +     vqmmc-supply =3D <&reg_aldo1>;
> > +     bus-width =3D <8>;
> > +     non-removable;
> > +     cap-mmc-hw-reset;
> > +     mmc-ddr-1_8v;
> > +     mmc-hs200-1_8v;
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&r_i2c {
> > +     status =3D "okay";
> > +
> > +     axp313: pmic@36 {
> > +             compatible =3D "x-powers,axp313a";
> > +             reg =3D <0x36>;
> > +             #interrupt-cells =3D <1>;
> > +             interrupt-controller;
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <2 9 IRQ_TYPE_LEVEL_LOW>;  /* PC9 */
> > +
> > +             vin1-supply =3D <&reg_vcc5v>;
> > +             vin2-supply =3D <&reg_vcc5v>;
> > +             vin3-supply =3D <&reg_vcc5v>;
> > +
> > +             regulators {
> > +                     /* Supplies VCC-PLL, so needs to be always on. */
> > +                     reg_aldo1: aldo1 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-name =3D "vcc1v8";
> > +                     };
> > +
> > +                     /* Supplies VCC-IO, so needs to be always on. */
> > +                     reg_dldo1: dldo1 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-name =3D "vcc3v3";
> > +                     };
> > +
> > +                     reg_dcdc1: dcdc1 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <810000>;
> > +                             regulator-max-microvolt =3D <990000>;
> > +                             regulator-name =3D "vdd-gpu-sys";
> > +                     };
> > +
> > +                     reg_dcdc2: dcdc2 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <810000>;
> > +                             regulator-max-microvolt =3D <1100000>;
> > +                             regulator-name =3D "vdd-cpu";
> > +                     };
> > +
> > +                     reg_dcdc3: dcdc3 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <1360000>;
> > +                             regulator-max-microvolt =3D <1360000>;
> > +                             regulator-name =3D "vdd-dram";
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&pio {
> > +     vcc-pc-supply =3D <&reg_aldo1>;
> > +     vcc-pg-supply =3D <&reg_dldo1>;
> > +     vcc-ph-supply =3D <&reg_dldo1>;
> > +     vcc-pi-supply =3D <&reg_dldo1>;
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart0_ph_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbotg {
> > +     dr_mode =3D "host";       /* USB A type receptable */
> > +     status =3D "okay";
> > +};
> > +
> > +&usbphy {
> > +     status =3D "okay";
> > +};
> > diff --git a/configs/t95_axp313_defconfig b/configs/t95_axp313_defconfi=
g
> > new file mode 100644
> > index 0000000000..6542b5bc88
> > --- /dev/null
> > +++ b/configs/t95_axp313_defconfig
> > @@ -0,0 +1,27 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_ARCH_SUNXI=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h616-t95-axp313"
> > +CONFIG_SPL=3Dy
> > +CONFIG_MACH_SUN50I_H616=3Dy
> > +CONFIG_DRAM_CLK=3D648
> > +CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0x1
> > +CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x03030303
> > +CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> > +CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x1c1c
> > +CONFIG_DRAM_SUN50I_H616_TPR10=3D0x2f0006
> > +CONFIG_DRAM_SUN50I_H616_TPR11=3D0xffffdddd
> > +CONFIG_DRAM_SUN50I_H616_TPR12=3D0xfedf7657
> > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy
> > +CONFIG_R_I2C_ENABLE=3Dy
> > +CONFIG_SPL_I2C=3Dy
> > +CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> > +CONFIG_SYS_I2C_MVTWSI=3Dy
> > +CONFIG_SYS_I2C_SLAVE=3D0x7f
> > +CONFIG_SYS_I2C_SPEED=3D400000
> > +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> > +CONFIG_AXP313_POWER=3Dy
> > +CONFIG_AXP_DCDC3_VOLT=3D1360
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_SUN8I_EMAC=3Dy
> > +CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0=3Dy
>


--=20
Kamil Kasperski
