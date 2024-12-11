Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5203E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3417D802F4;
	Wed, 11 Dec 2024 16:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C0080314; Wed, 11 Dec 2024 16:23:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F20C7802C2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53530FEC;
 Wed, 11 Dec 2024 07:23:32 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20F23F5A1;
 Wed, 11 Dec 2024 07:23:02 -0800 (PST)
Date: Wed, 11 Dec 2024 15:22:59 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [U-BOOT PATCH] sunxi: add support for Rervision A33-Vstar board
Message-ID: <20241211152259.55d93ad0@donnerap.manchester.arm.com>
In-Reply-To: <8a28ca7cf3c6241e398d5bdbb6bd7b94ceaa3fe3.camel@icenowy.me>
References: <20241211031752.355509-1-uwu@icenowy.me>
 <f9b90a6f1bc5d81de2a3968f1bb92ed8f158731b.camel@icenowy.me>
 <20241211131415.2611b46c@donnerap.manchester.arm.com>
 <8a28ca7cf3c6241e398d5bdbb6bd7b94ceaa3fe3.camel@icenowy.me>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 11 Dec 2024 22:07:38 +0800
Icenowy Zheng <uwu@icenowy.me> wrote:

Hi,

> =E5=9C=A8 2024-12-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 13:14 +0000=EF=
=BC=8CAndre Przywara=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, 11 Dec 2024 15:21:48 +0800
> > Icenowy Zheng <uwu@icenowy.me> wrote:
> >=20
> > Hi Icenowy,
> >=20
> > thanks for sending the patch!
> >  =20
> > > =E5=9C=A8 2024-12-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 11:17 +0800=
=EF=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A =20
> > > > Rervision A33-Vstar is an evaluation board for their A33-Core1
> > > > A33-
> > > > based
> > > > SoM.
> > > >=20
> > > > Add support for it.
> > > >=20
> > > > Fastboot support is enabled for flashing the eMMC included within
> > > > the
> > > > SoM, and R8152 Ethernet is enabled for the evaluation board's
> > > > onboard
> > > > USB-to-Ethernet.
> > > >=20
> > > > The device tree files are from Linux v6.13-rc1, with PMIC
> > > > interrupt
> > > > patched to match the r_intc node in U-Boot.
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > > > =C2=A0arch/arm/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > > =C2=A0arch/arm/dts/sun8i-a33-vstar-core1.dtsi |=C2=A0 96 +++++++++++
> > > > =C2=A0arch/arm/dts/sun8i-a33-vstar.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 205
> > > > ++++++++++++++++++++++++
> > > > =C2=A0board/sunxi/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
5 +
> > > > =C2=A0configs/A33-Vstar_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +++
> > > > =C2=A05 files changed, 330 insertions(+)
> > > > =C2=A0create mode 100644 arch/arm/dts/sun8i-a33-vstar-core1.dtsi
> > > > =C2=A0create mode 100644 arch/arm/dts/sun8i-a33-vstar.dts
> > > > =C2=A0create mode 100644 configs/A33-Vstar_defconfig
> > > >=20
> > > > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > > > index 6ad59aeed5f..55dde416d71 100644
> > > > --- a/arch/arm/dts/Makefile
> > > > +++ b/arch/arm/dts/Makefile
> > > > @@ -654,6 +654,7 @@ dtb-$(CONFIG_MACH_SUN8I_A33) +=3D \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-a33-olinuxino=
.dtb \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-a33-q8-tablet=
.dtb \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-a33-sinlinx-s=
ina33.dtb \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-a33-vstar.dtb \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-r16-bananapi-=
m2m.dtb \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-r16-nintendo-=
nes-classic.dtb \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i-r16-nintendo-=
super-nes-classic.dtb \
> > > > diff --git a/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
> > > > b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
> > > > new file mode 100644
> > > > index 00000000000..5b7057015cc
> > > > --- /dev/null
> > > > +++ b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
> > > > @@ -0,0 +1,96 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
> > > > + */
> > > > +
> > > > +#include "sun8i-a33.dtsi"
> > > > +
> > > > +&mmc2 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "defau=
lt";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&mmc2_8bi=
t_pins>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmmc-supply =3D <&reg_dc=
dc1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-width =3D <8>;=C2=A0=
  =20
> > >=20
> > > 8-bit eMMC operation seems to be unstable in U-Boot (but okay in
> > > Linux).
> > >=20
> > > Should I change the bus-width to 4 here in this copy of DT? (The
> > > kernel
> > > side DT file is still 8) =20
> >=20
> > No, that would be just wrong, and a dirty hack at best, and we don't
> > want
> > any further differences between U-Boot and kernel.
> > What speed modes do U-Boot and the kernel choose? Because I guess
> > that's the real difference. Would be interesting to see if U-Boot is
> > not =20
>=20
> U-Boot chooses 52MHz and Linux chooses 52MHz DDR (nothing higher than
> 52M DDR is available at 3.3V). Restricting U-Boot to 26MHz seems to be
> not able to solve problem... oops

So does U-Boot not use DDR?

> > honouring one of the properties (drive-strength?), or if there should
> > be a =20
>=20
> I tried to set drive strength to 4 in board/sunxi/board.c, and it makes
> no difference -- I think the U-Boot driver do not really use the drive-
> strength property of DT, right?

The MMC driver not, but the pinctrl driver parses this property and should
do the right thing - at least in U-Boot proper (there is no pinctrl driver
as such in the SPL).

So how does this problem show, exactly? On the H616, we can read some
sectors, but trying to read anything beyond 6 sectors or so hangs, I
believe.

Cheers,
Andre

>=20
> > max-frequency or something? Another difference is that U-Boot is not
> > using
> > DMA, but PIO-ing the FIFO. This is a big and yet unsolved problem on
> > H616,
> > but I haven't heard of issues with older SoCs yet.
> >=20
> > One whitespace issue below ...
> >  =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0non-removable;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cap-mmc-hw-reset;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&mmc2_8bit_pins {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Increase drive streng=
th for DDR modes */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drive-strength =3D <40>;
> > > > +};
> > > > +
> > > > +&r_rsb {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0axp22x: pmic@3a3 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "x-powers,axp223";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0x3a3>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&r_intc>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0eldoin-supply =3D <&reg_dcdc1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0x-powers,drive-vbus-en;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +#include "axp223.dtsi"
> > > > +
> > > > +&reg_aldo1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
io";
> > > > +};
> > > > +
> > > > +&reg_aldo2 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <2350000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <2650000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vdd-=
dll";
> > > > +};
> > > > +
> > > > +&reg_aldo3 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
avcc";
> > > > +};
> > > > +
> > > > +&reg_dc5ldo {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <900000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <1400000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vdd-=
cpus";
> > > > +};
> > > > +
> > > > +&reg_dcdc1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
3v3";
> > > > +};
> > > > +
> > > > +&reg_dcdc2 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <900000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <1400000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vdd-=
sys";
> > > > +};
> > > > +
> > > > +&reg_dcdc3 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <900000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <1400000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vdd-=
cpu";
> > > > +};
> > > > +
> > > > +&reg_dcdc5 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <1500000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <1500000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
dram";
> > > > +};
> > > > +
> > > > +&reg_rtc_ldo {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
rtc";
> > > > +};
> > > > diff --git a/arch/arm/dts/sun8i-a33-vstar.dts
> > > > b/arch/arm/dts/sun8i-
> > > > a33-vstar.dts
> > > > new file mode 100644
> > > > index 00000000000..9f5c29b3df4
> > > > --- /dev/null
> > > > +++ b/arch/arm/dts/sun8i-a33-vstar.dts
> > > > @@ -0,0 +1,205 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "sun8i-a33-vstar-core1.dtsi"
> > > > +
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/input.h>
> > > > +
> > > > +/ {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Rervision A33=
-Vstar";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "rervisio=
n,a33-vstar",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rervision,a33-core1",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun8i-a33";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aliases {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0serial0 =3D &uart0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ethernet0 =3D &r8152;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0stdout-path =3D "serial0:115200n8";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg_usb1_vbus: regulator=
-usb1-vbus {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "regulator-fixed";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "usb1-vbus";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =3D <5000000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =3D <5000000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-boot-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0enable-active-high;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0gpio =3D <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wifi_pwrseq: pwrseq {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "mmc-pwrseq-simple";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reset-gpios =3D <&r_pio 0 6 GPIO_ACTIVE_LOW>; /*
> > > > PL6 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&rtc CLK_OSC32K_FANOUT>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "ext_clock";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +&ac_power_supply {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&codec {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&dai {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&ehci0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hub@1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* Onboard GL850G hub which needs no extra power
> > > > sequence */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "usb5e3,608";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <0>;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0r8152: ethernet@4 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
Onboard Realtek RTL8152 USB Ethernet,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
with no MAC address programmed
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0com=
patible =3D "usbbda,8152";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg=
 =3D <4>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +&lradc {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vref-supply =3D <&reg_al=
do3>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0button-191 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "V+";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0linux,code =3D <KEY_VOLUMEUP>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0channel =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0voltage =3D <191011>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0button-391 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "V-";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0linux,code =3D <KEY_VOLUMEDOWN>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0channel =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0voltage =3D <391304>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0button-600 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "BACK";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0linux,code =3D <KEY_BACK>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0channel =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0voltage =3D <600000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +&mmc0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmmc-supply =3D <&reg_dc=
dc1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-width =3D <4>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cd-gpios =3D <&pio 1 4 G=
PIO_ACTIVE_LOW>; /* PB4 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&mmc1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "defau=
lt";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&mmc1_pg_=
pins>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmmc-supply =3D <&reg_dl=
do1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc-pwrseq =3D <&wifi_pw=
rseq>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-width =3D <4>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0non-removable;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0brcmf: wifi@1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "brcm,bcm4329-fmac";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&r_pio>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupts =3D <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names =3D "host-wake";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +/*
> > > > + * Our WiFi chip needs both DLDO1 and DLDO2 to be powered at the
> > > > same
> > > > + * time, with the two being in sync. Since this is not really
> > > > + * supported right now, just use the two as always on, and we
> > > > will
> > > > fix
> > > > + * it later.
> > > > + */
> > > > +&reg_dldo1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
wifi0";
> > > > +};
> > > > +
> > > > +&reg_dldo2 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-always-on;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =
=3D <3300000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "vcc-=
wifi1";
> > > > +};
> > > > +
> > > > +&reg_drivevbus {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator-name =3D "usb0=
-vbus";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&sound {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* TODO: on-board microp=
hone */
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0simple-audio-card,widget=
s =3D "Headphone", "Headphone
> > > > Jack";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0simple-audio-card,routin=
g =3D
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"Left DAC", "DACL",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"Right DAC", "DACR",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"Headphone Jack", "HP";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&uart0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "defau=
lt";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&uart0_pb=
_pins>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&uart1 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "defau=
lt";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&uart1_pg=
_pins>, <&uart1_cts_rts_pg_pins>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uart-has-rtscts;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bluetooth {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "brcm,bcm43438-bt";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&rtc CLK_OSC32K_FANOUT>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "lpo";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0vbat-supply =3D <&reg_dldo1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0device-wakeup-gpios =3D <&r_pio 0 10 =20
> > > > GPIO_ACTIVE_HIGH>; =20
> > > > /* PL10 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0host-wakeup-gpios =3D <&r_pio 0 9 =20
> > > > GPIO_ACTIVE_HIGH>; /* =20
> > > > PL9 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0shutdown-gpios =3D <&r_pio 0 8 GPIO_ACTIVE_HIGH>;
> > > > /*
> > > > PL8 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +};
> > > > +
> > > > +&usb_otg {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dr_mode =3D "otg";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&usb_power_supply {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > +
> > > > +&usbphy {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb0_id_det-gpios =3D <&=
pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8
> > > > */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb0_vbus_power-supply =
=3D <&usb_power_supply>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb0_vbus-supply =3D <&r=
eg_drivevbus>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb1_vbus-supply =3D <&r=
eg_usb1_vbus>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > > > +};
> > > > diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> > > > index 84799879e85..5592d366600 100644
> > > > --- a/board/sunxi/MAINTAINERS
> > > > +++ b/board/sunxi/MAINTAINERS
> > > > @@ -526,6 +526,11 @@ M:=C2=A0Quentin Schulz
> > > > <quentin.schulz@free-electrons.com>
> > > > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > > > =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configs/parrot_r16_defconfig
> > > > =C2=A0
> > > > +RERVISION A33-VSTAR BOARD
> > > > +M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Icenowy Zheng <uwu@icenowy.me>
> > > > +S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > > > +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configs/A33-Vstar_defconfig
> > > > +
> > > > =C2=A0SINLINX SINA31s BOARD
> > > > =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Chen-Yu Tsai <wens@csie.org>
> > > > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > > > diff --git a/configs/A33-Vstar_defconfig b/configs/A33-
> > > > Vstar_defconfig
> > > > new file mode 100644
> > > > index 00000000000..0053c243444
> > > > --- /dev/null
> > > > +++ b/configs/A33-Vstar_defconfig
> > > > @@ -0,0 +1,23 @@
> > > > +CONFIG_ARM=3Dy
> > > > +CONFIG_ARCH_SUNXI=3Dy
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-a33-vstar"
> > > > +CONFIG_SPL=3Dy
> > > > +CONFIG_MACH_SUN8I_A33=3Dy
> > > > +CONFIG_DRAM_CLK=3D552
> > > > +CONFIG_DRAM_ZQ=3D15291
> > > > +CONFIG_DRAM_ODT_EN=3Dy
> > > > +CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
> > > > +CONFIG_USB0_ID_DET=3D"PH8"
> > > > +CONFIG_USB1_VBUS_PIN=3D"PB2"
> > > > +# CONFIG_VIDEO_SUNXI is not set
> > > > +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > > > +CONFIG_CMD_DFU=3Dy
> > > > +CONFIG_DFU_RAM=3Dy
> > > > +CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
> > > > +CONFIG_AXP_DCDC1_VOLT=3D3300
> > > > +CONFIG_USB_EHCI_HCD=3Dy
> > > > +CONFIG_USB_MUSB_GADGET=3Dy
> > > > +CONFIG_USB_HOST_ETHER=3Dy
> > > > +CONFIG_USB_ETHER_RTL8152=3Dy
> > > > +CONFIG_USB_FUNCTION_MASS_STORAGE=3Dy
> > > > +# CONFIG_USB_ETHER is not set=C2=A0  =20
> >=20
> >=20
> > There seem to be two extra spaces at the end here. =20
>=20
> Oops, will fix this.
>=20
> >=20
> > Cheers,
> > Andre =20
>=20

