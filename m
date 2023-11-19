Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9E0C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5AD86F0D;
	Sun, 19 Nov 2023 21:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8960D87083; Sun, 19 Nov 2023 21:52:25 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 532A186E65
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.04,212,1695654000"; 
 d="asc'?scan'208";a="183485863"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2023 05:52:16 +0900
Received: from unknown (unknown [10.226.92.15])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id 9BC5040AACDD;
 Mon, 20 Nov 2023 05:52:14 +0900 (JST)
Date: Sun, 19 Nov 2023 20:52:13 +0000
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 5/5] sysreset: Support reset via Renesas RAA215300 PMIC
Message-ID: <20231119205213.xyyuwvaluhmm2454@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-6-paul.barker.ct@bp.renesas.com>
 <6d47aaa8-543a-4420-973d-7a28941b475e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lhhucnffpt23duzg"
Content-Disposition: inline
In-Reply-To: <6d47aaa8-543a-4420-973d-7a28941b475e@mailbox.org>
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


--lhhucnffpt23duzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 09:17:40PM +0100, Marek Vasut wrote:
> On 11/15/23 18:40, Paul Barker wrote:
> > This patch allows us to reset the RZ/G2L board via the RAA215300 PMIC.
> >=20
> > Note that the RAA215300 documentation names the available reset types
> > differently to u-boot:
> >=20
> >    - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
> >      (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
> >=20
> >    - A "cold" reset via the RAA215300 PMIC will cycle all power supply
> >      rails, so this corresponds to SYSRESET_POWER.
> >=20
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > ---
> >   board/renesas/rzg2l/rzg2l.c           |  8 ----
> >   configs/renesas_rzg2l_smarc_defconfig |  2 +
> >   drivers/power/pmic/raa215300.c        | 17 ++++++++
> >   drivers/sysreset/Kconfig              |  6 +++
> >   drivers/sysreset/Makefile             |  1 +
> >   drivers/sysreset/sysreset_raa215300.c | 58 +++++++++++++++++++++++++++
> >   6 files changed, 84 insertions(+), 8 deletions(-)
> >   create mode 100644 drivers/sysreset/sysreset_raa215300.c
> >=20
> > diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
> > index 73201a8c69e5..0f6d6e7f514f 100644
> > --- a/board/renesas/rzg2l/rzg2l.c
> > +++ b/board/renesas/rzg2l/rzg2l.c
> > @@ -56,11 +56,3 @@ int board_init(void)
> >   {
> >   	return 0;
> >   }
> > -
> > -void reset_cpu(void)
> > -{
> > -	/*
> > -	 * TODO: Implement reset support once TrustedFirmware supports
> > -	 * the appropriate call.
> > -	 */
> > -}
>=20
> Board change -- separate patch please.

Ok, this makes sense. I'll move this and the defconfig change into a
separate patch.

>=20
> > diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rz=
g2l_smarc_defconfig
> > index b62eae4ee0a4..ba96e746df9e 100644
> > --- a/configs/renesas_rzg2l_smarc_defconfig
> > +++ b/configs/renesas_rzg2l_smarc_defconfig
> > @@ -55,3 +55,5 @@ CONFIG_PMIC_RAA215300=3Dy
> >   CONFIG_DM_REGULATOR=3Dy
> >   CONFIG_DM_REGULATOR_FIXED=3Dy
> >   CONFIG_DM_REGULATOR_GPIO=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_SYSRESET_RAA215300=3Dy
> > diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215=
300.c
> > index 9c0b720994b2..7f68f95f25cf 100644
> > --- a/drivers/power/pmic/raa215300.c
> > +++ b/drivers/power/pmic/raa215300.c
> > @@ -27,9 +27,26 @@ static const struct udevice_id raa215300_ids[] =3D {
> >   	{ /* sentinel */ }
> >   };
> > +static int raa215300_bind(struct udevice *dev)
> > +{
> > +	struct driver *drv;
> > +
> > +	if (IS_ENABLED(CONFIG_SYSRESET_RAA215300)) {
> > +		drv =3D lists_driver_lookup_name("raa215300_sysreset");
> > +		if (!drv)
> > +			return -ENOENT;
> > +
> > +		return device_bind(dev, drv, dev->name, NULL, dev_ofnode(dev),
> > +				   NULL);
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Driver change should be squashed in 4/5.

Moving this to the previous patch doesn't make sense to me - the
sysreset driver needs to exist for this check to be meaningful.
Conversely, adding the sysreset driver first then the pmic driver
wouldn't make sense since the sysreset driver depends on the pmic
driver. This seemed the neatest way to do things to me.

Thanks,
Paul

--lhhucnffpt23duzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZVp1fQAKCRDbaV4Vf/JG
vUABAP9Ufu59LBz7F2AYLS8obZtk5AnNIl7jgljSVWqbqwNjdQD/SIo+IV3TAnTF
dY6ZoLSSvPT2bKQ7Hi+PMTTWYj4CcwE=
=i42d
-----END PGP SIGNATURE-----

--lhhucnffpt23duzg--
