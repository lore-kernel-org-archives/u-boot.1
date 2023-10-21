Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F51C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 22:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BD487666;
	Sun, 22 Oct 2023 00:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A8C8766A; Sun, 22 Oct 2023 00:06:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A1BD587666
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 00:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7C9C15;
 Sat, 21 Oct 2023 15:07:19 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4943F762;
 Sat, 21 Oct 2023 15:06:37 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:05:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Samuel Holland <samuel@sholland.org>, SASANO
 Takayoshi <uaa@mx5.nisiq.net>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] power: regulator: add AXP313 support
Message-ID: <20231021230534.6ed056bc@slackpad.lan>
In-Reply-To: <2168063.Mh6RI2rZIc@archlinux>
References: <20231018155014.383566-1-andre.przywara@arm.com>
 <20231018155014.383566-4-andre.przywara@arm.com>
 <2168063.Mh6RI2rZIc@archlinux>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sat, 21 Oct 2023 08:51:09 +0200
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

> On Wednesday, October 18, 2023 5:50:14 PM CEST Andre Przywara wrote:
> > The X-Powers AXP313a is a small PMIC with just three buck converters and
> > three LDOs, one of which is actually fixed (so not modelled here).
> >=20
> > Add the compatible string and the respective regulator ranges to allow
> > drivers to adjust voltages.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/power/pmic/axp.c                |  1 +
> >  drivers/power/regulator/axp_regulator.c | 17 +++++++++++++++++
> >  include/axp_pmic.h                      |  1 +
> >  3 files changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
> > index 025dac24f28..0e1e45fba74 100644
> > --- a/drivers/power/pmic/axp.c
> > +++ b/drivers/power/pmic/axp.c
> > @@ -87,6 +87,7 @@ static const struct udevice_id axp_pmic_ids[] =3D {
> >  	{ .compatible =3D "x-powers,axp209", .data =3D AXP209_ID },
> >  	{ .compatible =3D "x-powers,axp221", .data =3D AXP221_ID },
> >  	{ .compatible =3D "x-powers,axp223", .data =3D AXP223_ID },
> > +	{ .compatible =3D "x-powers,axp313a", .data =3D AXP313_ID },
> >  	{ .compatible =3D "x-powers,axp803", .data =3D AXP803_ID },
> >  	{ .compatible =3D "x-powers,axp806", .data =3D AXP806_ID },
> >  	{ .compatible =3D "x-powers,axp809", .data =3D AXP809_ID },
> > diff --git a/drivers/power/regulator/axp_regulator.c
> > b/drivers/power/regulator/axp_regulator.c index 02f320eac1e..d27e09538e0
> > 100644
> > --- a/drivers/power/regulator/axp_regulator.c
> > +++ b/drivers/power/regulator/axp_regulator.c
> > @@ -173,6 +173,22 @@ static const struct axp_regulator_plat
> > axp22x_regulators[] =3D { { }
> >  };
> >=20
> > +/*
> > + * The "dcdc1" regulator has another range, beyond 1.54V up to 3.4V, in
> > + * steps of 100mV. We cannot model this easily, but also don't need th=
at,
> > + * since it's typically only used for ~1.1V anyway, so just ignore it.=
 =20
>=20
> It can be modelled with look up table, as it's already done for some othe=
r=20
> regulators?

Theoretically yes, but it would require about 105 entries, that's quite
a lot for something we don't need. As mentioned, it's
typically VDD_GPU/VDD_SYS, at 0.9V at reset, and no device used in
U-Boot directly references this regulator, so I think it wouldn't be
used anyways. I doubt that even with a user we ever would go beyond
1.54V. So for the sake of simplicity, I'd like to keep this cut to
those two ranges.

Thanks for having a look!

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
> > + * Also the DCDC3 regulator is described wrongly in the (available) ma=
nual,
> > + * experiments show that the split point is at 1200mV, as for DCDC1/2.=
 +
> > */
> > +static const struct axp_regulator_plat axp313_regulators[] =3D {
> > +	{ "dcdc1", 0x10, BIT(0), 0x13, 0x7f,  500, 1540,  10, 70 },
> > +	{ "dcdc2", 0x10, BIT(1), 0x14, 0x7f,  500, 1540,  10, 70 },
> > +	{ "dcdc3", 0x10, BIT(2), 0x15, 0x7f,  500, 1840,  10, 70 },
> > +	{ "aldo1", 0x10, BIT(3), 0x16, 0x1f,  500, 3500, 100, NA },
> > +	{ "dldo1", 0x10, BIT(4), 0x17, 0x1f,  500, 3500, 100, NA },
> > +	{ }
> > +};
> > +
> >  static const struct axp_regulator_plat axp803_regulators[] =3D {
> >  	{ "dcdc1", 0x10, BIT(0), 0x20, 0x1f, 1600, 3400, 100, NA },
> >  	{ "dcdc2", 0x10, BIT(1), 0x21, 0x7f,  500, 1300,  10, 70 },
> > @@ -274,6 +290,7 @@ static const struct axp_regulator_plat *const
> > axp_regulators[] =3D { [AXP209_ID]	=3D axp20x_regulators,
> >  	[AXP221_ID]	=3D axp22x_regulators,
> >  	[AXP223_ID]	=3D axp22x_regulators,
> > +	[AXP313_ID]	=3D axp313_regulators,
> >  	[AXP803_ID]	=3D axp803_regulators,
> >  	[AXP806_ID]	=3D axp806_regulators,
> >  	[AXP809_ID]	=3D axp809_regulators,
> > diff --git a/include/axp_pmic.h b/include/axp_pmic.h
> > index 4ac64865831..aabafc8501b 100644
> > --- a/include/axp_pmic.h
> > +++ b/include/axp_pmic.h
> > @@ -32,6 +32,7 @@ enum {
> >  	AXP209_ID,
> >  	AXP221_ID,
> >  	AXP223_ID,
> > +	AXP313_ID,
> >  	AXP803_ID,
> >  	AXP806_ID,
> >  	AXP809_ID, =20
>=20
>=20
>=20
>=20
>=20

