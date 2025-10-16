Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE788CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4C7837E2;
	Thu, 16 Oct 2025 17:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="c84W+KDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A014837E4; Thu, 16 Oct 2025 17:30:56 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D028F83734
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=PIVRulVtEzPjC/Ds3SEYGBBeE1CgixAC6xS7Famj5/4=;
 b=c84W+KDQ7yMOAlJPZ+DJwkcGCAM8p8wl5Z23RSvmkgH0bSbSdJlWhc2Ay8H0sF9lgkCVtmo2Xbc80P81EVz+CjlUIQWIjKUGDmVGrCPUUxO8bSyAwb0Bb3llsC63kJWFtcdbhPN26fmGsr2sjMbsJufSLEVHReJ0bIRjgcrcXtU=
Received: from lukas-hpz440workstation.localnet (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPSA
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Thu, 16 Oct 2025 17:30:42 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 John Watts <contact@jookia.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Date: Thu, 16 Oct 2025 17:30:41 +0200
Message-ID: <5396890.31r3eYUQgx@lukas-hpz440workstation>
In-Reply-To: <20250917224826.7837663c@minigeek.lan>
References: <20250915192036.323741-1-lukas.schmid@netcube.li>
 <20250917224826.7837663c@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5034631.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart5034631.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>
Date: Thu, 16 Oct 2025 17:30:41 +0200
Message-ID: <5396890.31r3eYUQgx@lukas-hpz440workstation>
In-Reply-To: <20250917224826.7837663c@minigeek.lan>
MIME-Version: 1.0

On Mittwoch, 17. September 2025 23:48:26 Mitteleurop=C3=A4ische Sommerzeit =
Andre=20
Przywara wrote:
> On Mon, 15 Sep 2025 21:20:35 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
>=20
> Hi Lukas, John,
>=20
> so looking at the code again, table 0 is special in that it's all 0's,
> which apparently means no remapping, according to some comments.
> We already bail out earlier of this function for configurations that do
> not require remapping, so can you test whether this works here as well?
> Just do the chip ID test early, after the DRAM type check, and before
> the fuse is read. And if it's 0x7200, then just return;
>=20
> I think that would look better than the odd fuse special case.
>=20
> Thanks,
> Andre
>=20
> > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > T113M4020DC0 by checking the SoC's CHIPID.
> >=20
> > The list of Chip-IDs came from
> > https://github.com/ua1arn/hftrx/blob/25d8cb9e4cfe1d7d0e4a2f641025c88a9e=
c5e
> > 758/inc/clocks.h#L250
> >=20
> > And the chipid register address was something I heard through apritzel
> > altough it seems that, according to Jookia, the Tina Device Tree seems
> > to agree:
> >=20
> > sid@3006000 {
> >=20
> > 	compatible =3D "allwinner,sun20iw1p1-sid", "allwinner,sunxi-sid";
> > 	reg =3D <0x0 0x03006000 0 0x1000>;
> > 	#address-cells =3D <1>;
> > 	#size-cells =3D <1>;
> > =09
> > 	chipid {
> > =09
> > 		reg =3D <0x0 0>;
> > 		offset =3D <0x200>;
> > 		size =3D <0x10>;
> > =09
> > 	};
> > 	...
> >=20
> > };
> >=20
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > Tested-by: John Watts <contact@jookia.org>
> > Reviewed-by: John Watts <contact@jookia.org>
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >=20
> > Changes in v2:
> >   - Use uint32_t instead of u32 for sid_read_soc_chipid return type
> >   - Add descriptive comment about source of Chip-ID list and register
> > =20
> >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c
> > b/drivers/ram/sunxi/dram_sun20i_d1.c index a1794032f3b..381eeb87e2e
> > 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *par=
a)
> >=20
> >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> > =20
> >  }
> >=20
> > +static uint32_t sid_read_soc_chipid(void)
> > +{
> > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > +}
> > +
> >=20
> >  static void dram_voltage_set(const dram_para_t *para)
> >  {
> > =20
> >  	int vol;
> >=20
> > @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t
> > *para,>=20
> >  	fuse =3D (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> >  	debug("DDR efuse: 0x%x\n", fuse);
> >=20
> > +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> >=20
> >  	if (para->dram_type =3D=3D SUNXI_DRAM_TYPE_DDR2) {
> >  =09
> >  		if (fuse =3D=3D 15)
> >=20
> > @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_t
> > *para,>=20
> >  			switch (fuse) {
> >  			case 8: cfg =3D ac_remapping_tables[2]; break;
> >  			case 9: cfg =3D ac_remapping_tables[3]; break;
> >=20
> > -			case 10: cfg =3D ac_remapping_tables[5];=20
break;
> > +			case 10:
> > +				if (sid_read_soc_chipid() =3D=3D=20
SUNXI_CHIPID_T113M4020DC0)
> > +					cfg =3D=20
ac_remapping_tables[0];
> > +				else
> > +					cfg =3D=20
ac_remapping_tables[5];
> > +				break;
> >=20
> >  			case 11: cfg =3D ac_remapping_tables[4];=20
break;
> >  			default:
> >  			case 12: cfg =3D ac_remapping_tables[1];=20
break;
> >=20
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h
> > b/drivers/ram/sunxi/dram_sun20i_d1.h index 91383f6cf10..7bd8f67a77a
> > 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> > @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> >=20
> >  	SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
> > =20
> >  };
> >=20
> > +enum sunxi_soc_chipid {
> > +	SUNXI_CHIPID_F133A =3D 0x5C00,
> > +	SUNXI_CHIPID_D1S =3D 0x5E00,
> > +	SUNXI_CHIPID_T113S3 =3D 0x6000,
> > +	SUNXI_CHIPID_T113M4020DC0 =3D 0x7200,
> > +};
> > +
> >=20
> >  /*
> > =20
> >   * This structure contains a mixture of fixed configuration settings,
> >   * variables that are used at runtime to communicate settings between

Hi Andre,

I finally got some time to look into this patch again.

Dropping out of the DRAM type check earlier sounds like a good move here. I=
=20
can definitely do that and also test it on my board.=20

About the other changes. Is the patch itself in a good state right now (exc=
ept=20
the commit message) or would you (or anyone else here for that matter) like=
 to=20
see something changed?

I'll change/update the commit message to have a smaller footprint regarding=
=20
the SID chip ID, and also remove the reference to the "random" git repo.

Best regards,
Lukas

--nextPart5034631.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPv6dcBmn59ssZMkSJnN+drMVRtgFAmjxD6EACgkQJnN+drMV
Rth8VQf/T6m1BoJu0cJC9cMpiuqvt1R+GnQvOHrYthaISQ9XQlaaBFNjRKcEGM7P
ZqSOLkMW1csEIR4NZ55cbKWN0sU32M7wwhfzmBlLT6T/XU2mF5mkNRxB9ql8m1Xp
ksZ15Q/1EuHG9EUi/kw41uH8HDaMyRW4Ew+ICd5FSHwRgoqLVapEGDRIUXeZfwKX
JJGKa9/GNISfG6XALJBt34Rf6POh5NtAPIZvLHpmsk8H8NCeNVKAjLxbymrxkXNn
Afo33yk0NS3Llj2a2WttTfSrhPtX0zA0ojVdMSEUhdGSrq1yg5/daLgeYM2hYQun
pZBqiGzGij/pqv8uv5pZFwBNZ9XP6Q==
=gFfn
-----END PGP SIGNATURE-----

--nextPart5034631.LvFx2qVVIh--




