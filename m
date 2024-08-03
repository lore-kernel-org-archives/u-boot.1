Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E39C52D6F
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 18:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5DF88CF0;
	Sat,  3 Aug 2024 20:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pek3pt/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D1488C75; Sat,  3 Aug 2024 18:09:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BED188BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 18:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sre@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ACF2460ACA;
 Sat,  3 Aug 2024 16:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E2C116B1;
 Sat,  3 Aug 2024 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722701370;
 bh=3XNJUG7Pn6OxUar8JNumZMpROiG/PzjA0Nx6anGUU7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pek3pt/6jih+rdGefqpVI3Xi7GHyYysB2B3lPUYqBf+n9S1rjjMglI+bgMhfsmsS6
 z6qRlntbRzUUOoVED2xNHKdzCNJDYE+Menl2XqkVhcU9BJqJbBVsfH3AD2tNR49PWO
 rjMoxgCWGlugiPZ8P4mL1MrmiIzFqyEOPHzTMILVvGsYjm2qEuTyzQPT1eQsovLuWr
 VQO7DMNIvJHfyi0d15QZH9n6CipMhCij375nrXEx5BffyPt7kYaohctf9zTEtyUlwL
 gUe3zSF2y0k/5MSK9EZgtrXb+YeWX+Ou20wd7FcHm2N5PNPKb5aqfx/tpZRC2BjY96
 tIWDKE81fvBDw==
Received: by mercury (Postfix, from userid 1000)
 id C10621060930; Sat, 03 Aug 2024 18:09:27 +0200 (CEST)
Date: Sat, 3 Aug 2024 18:09:27 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Tim Harvey <tharvey@gateworks.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/7] board: rock5b-rk3588: enable USB-C in operating
 system
Message-ID: <j654dnoy5yu57do2nmdssfykvnw74hayl53nlqvn5jlycr6ny2@h5pprs7sjfds>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-5-sebastian.reichel@collabora.com>
 <88da35e4-77d8-4360-8be2-5efa6ae0d5cf@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j4axkujm35vrojpe"
Content-Disposition: inline
In-Reply-To: <88da35e4-77d8-4360-8be2-5efa6ae0d5cf@kwiboo.se>
X-Mailman-Approved-At: Sat, 03 Aug 2024 20:55:08 +0200
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


--j4axkujm35vrojpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, Aug 02, 2024 at 11:04:05PM GMT, Jonas Karlman wrote:
> Hi Sebastian,
>=20
> On 2024-08-02 19:59, Sebastian Reichel wrote:
> > Since older U-Boot releases do not negotiate USB PD, the kernel
> > DT may not enable the USB-C controller by default to avoid a
> > regression. The plan is to upstream it with 'status =3D "fail";'
> > instead. U-Boot should then mark it as 'status =3D "okay";' if
> > it negotiated USB PD. Currently existing upstream kernel DTs do
> > not yet have the USB-C controller at all, so we ignore any
> > failures.
>=20
> I do not really understand why you need to upstream it this way, there
> are plenty of other rk3588 boards with fcs,fusb302 already having status
> "okay" that possible are affected by same USB PD issue that ROCK 5B
> have.
>=20
> I guess you want to try and protect users that upgrade kernel DT and
> ignore upgrading to a newer U-Boot, use vendor U-Boot or any other
> bootloader from having possible issues with those USB PD power supplies
> that have issues?

Correct. Existing upstream U-Boot with new kernel would result in a
boot loop. That's precisly why we need this U-Boot series. Since the
Rock 5B is usually powered via USB-C and Radxa explicitly requests a
USB-C PD power-supply almost everyone would be affected. IDK how
other boards solve this considering U-Boot does not yet have a
fusb302 driver. For me **all** of my power-supplies trigger a hard
reset and thus a power-loss when booting a kernel with fusb302
combined with an old U-Boot version not supporting fusb302.

-- Sebastian

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  board/radxa/rock5b-rk3588/rock5b-rk3588.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/ro=
ck5b-rk3588/rock5b-rk3588.c
> > index 1c17ae93c76c..4e926ebf2cb0 100644
> > --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> > +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> > @@ -3,6 +3,8 @@
> >   * Copyright (c) 2023-2024 Collabora Ltd.
> >   */
> > =20
> > +#include <fdtdec.h>
> > +#include <fdt_support.h>
> >  #include <usb/tcpm.h>
> > =20
> >  #ifdef CONFIG_MISC_INIT_R
> > @@ -33,3 +35,12 @@ int misc_init_r(void)
> >  	return 0;
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_OF_BOARD_SETUP
> > +int ft_board_setup(void *blob, struct bd_info *bd)
> > +{
> > +	if (IS_ENABLED(CONFIG_MISC_INIT_R))
>=20
> It make very little sense to check for this, it is implied for almost
> all Rockchip boards since it is used in rockchip board common code
> to setup serial and Ethernet mac addresses env vars.
>=20
> Regards,
> Jonas
>=20
> > +		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
> > +	return 0;
> > +}
> > +#endif
>=20

--j4axkujm35vrojpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmauVi0ACgkQ2O7X88g7
+praRg//THqx9f4+C6xtidr+1+MZJWvt1VNG719kIiOLTpea3V5dVcBynJPbylJk
y59FO6eFgJU8i/DKbAIDdafgmUydYb7kYhwrjTdDpqdxvNGtv98lMv3KXyn1ATKZ
dl6iKFWQbxCeGBjiZjuYPnZPPNJd2Xo2Pdx7svdT7Fji+rtfE0/QqY8XQ08c6Sws
PdIh3Kt8rrmR7j1LTHZuJfAPq1z48gJ5HcsS8Bu25KaFE9KCC+Wf+AVJfwdUBIOn
OunOTyMVe771EtimP6wFDDhH4uHrp/8IrIUlOoZ/hfzw/mfibDn9pylSl7e1Ajrx
BDuov9yonH2pZxli7G9ezLbHPkbMrjXkL+ITLeS/Xe64z/SWyocIgGIccrtnyRh4
77njBbYSx/In60xFxX9S63lMEyf4EBLUCziueI2IZtVkrDL1q3kJJMorAqbG0yQO
cKblL3Ut4ukTMShI9zxuNug2bwK/Z963Tbo779mURYnfOAIVsYS/rmz5GbkjL9iY
WJFyyoQiVah2L1txWDS4vJaUm1PDTq724QyeffS1tepb8jlTU5424lFEaOrTDFvg
/ev8dtJ0G+Bwn651BhNOnkw0SAhudx3R3gsucul3NiMz5bBoWMH/hsqZOoWGslCN
QDgJfrODupSZ0P9SvhLCnazIDgfZ6XUhixh0fjwV19gucZU7TpM=
=D9Uj
-----END PGP SIGNATURE-----

--j4axkujm35vrojpe--
