Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D6CCD195
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 00:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAC280422;
	Mon, 20 Oct 2025 02:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F1B807B1; Mon, 20 Oct 2025 02:00:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 83CC9802C1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 02:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 019CB1063;
 Sun, 19 Oct 2025 17:00:25 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2BB53F59E;
 Sun, 19 Oct 2025 17:00:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:59:52 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev, John Watts
 <contact@jookia.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Message-ID: <20251020005924.73e41909@minigeek.lan>
In-Reply-To: <5396890.31r3eYUQgx@lukas-hpz440workstation>
References: <20250915192036.323741-1-lukas.schmid@netcube.li>
 <20250917224826.7837663c@minigeek.lan>
 <5396890.31r3eYUQgx@lukas-hpz440workstation>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Thu, 16 Oct 2025 17:30:41 +0200
Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi Lukas,

> I finally got some time to look into this patch again.
>=20
> Dropping out of the DRAM type check earlier sounds like a good move here.=
 I=20
> can definitely do that and also test it on my board.=20

Yes, please do, and send a v3 if that works for you.
=20
> About the other changes. Is the patch itself in a good state right now (e=
xcept=20
> the commit message) or would you (or anyone else here for that matter) li=
ke to=20
> see something changed?
>=20
> I'll change/update the commit message to have a smaller footprint regardi=
ng=20
> the SID chip ID, and also remove the reference to the "random" git repo.

What's more important than the sources is some background and some
description about what the patch does, like this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The T113-s4 SoC is using the same die as the T113-s3, but comes with
256MiB of co-packaged DRAM. Besides the doubled size, the DRAM chip
seems to be connected slightly differently, which requires to use a
different pin remapping.

Extend the DRAM initialisation code to add support for the T113-S4 aka
T113M4020DC0 by checking the SoC's CHIPID, which is stored in the first
word of the SID efuses.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So no lengthy dumps or links. You might want to put the link to the
github repo as a comment before the enum in dram_sun20i_d1.h.

Thanks,
Andre

>=20
> Best regards,
> Lukas

> On Mittwoch, 17. September 2025 23:48:26 Mitteleurop=C3=A4ische Sommerzei=
t Andre=20
> Przywara wrote:
> > On Mon, 15 Sep 2025 21:20:35 +0200
> > Lukas Schmid <lukas.schmid@netcube.li> wrote:
> >=20
> > Hi Lukas, John,
> >=20
> > so looking at the code again, table 0 is special in that it's all 0's,
> > which apparently means no remapping, according to some comments.
> > We already bail out earlier of this function for configurations that do
> > not require remapping, so can you test whether this works here as well?
> > Just do the chip ID test early, after the DRAM type check, and before
> > the fuse is read. And if it's 0x7200, then just return;
> >=20
> > I think that would look better than the odd fuse special case.
> >=20
> > Thanks,
> > Andre
> >  =20
> > > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > > T113M4020DC0 by checking the SoC's CHIPID.
> > >=20
> > > The list of Chip-IDs came from
> > > https://github.com/ua1arn/hftrx/blob/25d8cb9e4cfe1d7d0e4a2f641025c88a=
9ec5e
> > > 758/inc/clocks.h#L250
> > >=20
> > > And the chipid register address was something I heard through apritzel
> > > altough it seems that, according to Jookia, the Tina Device Tree seems
> > > to agree:
> > >=20
> > > sid@3006000 {
> > >=20
> > > 	compatible =3D "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
> > > 	reg =3D <0x0 0x03006000 0 0x1000>;
> > > 	#address-cells =3D <1>;
> > > 	#size-cells =3D <1>;
> > > =09
> > > 	chipid {
> > > =09
> > > 		reg =3D <0x0 0>;
> > > 		offset =3D <0x200>;
> > > 		size =3D <0x10>;
> > > =09
> > > 	};
> > > 	...
> > >=20
> > > };
> > >=20
> > > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > > Tested-by: John Watts <contact@jookia.org>
> > > Reviewed-by: John Watts <contact@jookia.org>
> > > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >=20
> > > Changes in v2:
> > >   - Use uint32_t instead of u32 for sid_read_soc_chipid return type
> > >   - Add descriptive comment about source of Chip-ID list and register
> > > =20
> > >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> > >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c
> > > b/drivers/ram/sunxi/dram_sun20i_d1.c index a1794032f3b..381eeb87e2e
> > > 100644
> > > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *p=
ara)
> > >=20
> > >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> > > =20
> > >  }
> > >=20
> > > +static uint32_t sid_read_soc_chipid(void)
> > > +{
> > > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > > +}
> > > +
> > >=20
> > >  static void dram_voltage_set(const dram_para_t *para)
> > >  {
> > > =20
> > >  	int vol;
> > >=20
> > > @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para=
_t =20
> > > *para,>  =20
> > >  	fuse =3D (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> > >  	debug("DDR efuse: 0x%x\n", fuse);
> > >=20
> > > +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> > >=20
> > >  	if (para->dram_type =3D=3D SUNXI_DRAM_TYPE_DDR2) {
> > >  =09
> > >  		if (fuse =3D=3D 15)
> > >=20
> > > @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_par=
a_t =20
> > > *para,>  =20
> > >  			switch (fuse) {
> > >  			case 8: cfg =3D ac_remapping_tables[2]; break;
> > >  			case 9: cfg =3D ac_remapping_tables[3]; break;
> > >=20
> > > -			case 10: cfg =3D ac_remapping_tables[5];  =20
> break;
> > > +			case 10:
> > > +				if (sid_read_soc_chipid() =3D=3D  =20
> SUNXI_CHIPID_T113M4020DC0)
> > > +					cfg =3D  =20
> ac_remapping_tables[0];
> > > +				else
> > > +					cfg =3D  =20
> ac_remapping_tables[5];
> > > +				break;
> > >=20
> > >  			case 11: cfg =3D ac_remapping_tables[4];  =20
> break;
> > >  			default:
> > >  			case 12: cfg =3D ac_remapping_tables[1];  =20
> break;
> > >=20
> > > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h
> > > b/drivers/ram/sunxi/dram_sun20i_d1.h index 91383f6cf10..7bd8f67a77a
> > > 100644
> > > --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> > > +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> > > @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> > >=20
> > >  	SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
> > > =20
> > >  };
> > >=20
> > > +enum sunxi_soc_chipid {
> > > +	SUNXI_CHIPID_F133A =3D 0x5C00,
> > > +	SUNXI_CHIPID_D1S =3D 0x5E00,
> > > +	SUNXI_CHIPID_T113S3 =3D 0x6000,
> > > +	SUNXI_CHIPID_T113M4020DC0 =3D 0x7200,
> > > +};
> > > +
> > >=20
> > >  /*
> > > =20
> > >   * This structure contains a mixture of fixed configuration settings,
> > >   * variables that are used at runtime to communicate settings betwee=
n =20
>=20

