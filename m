Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5FCC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 12:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B4587885;
	Thu, 11 Jan 2024 13:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704975524;
	bh=3jpYwoilVTtML9hjhEWme9X+OI3uHvJAoDZVfUi0lNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PfnOzgbb93Q7zUcbhBrn64tbDmgjg5zbyzt0GeACdqxV5u21iEJRIhbBQ4MmmjycB
	 l6IwXkwhLupNM71Lg36LJ4tsNETDIbeg5x/7TOCTr1RuPakm4cMQH9FLQs/4BcHD8d
	 gexGzxOrbf4wNNPRzxD+u3/ld3eyxASlIe5of7Ei+WI7nn021kUQP0ETNJF5Ny1lt9
	 g5mHxx+4GOIq1pjrGMMS4OsRntfxlozlZpC/Q2o2JDFj+PdS0QHc4jQV+nyMVnDfkf
	 mn1a09UjI7buEfEmA947kbJtZwdalDi2mUpFhi21/FvT2BWmdN3VKP+lt+I4OPohwo
	 RaVR/1YysrWEQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 892A086406;
 Thu, 11 Jan 2024 13:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704975522;
 bh=3jpYwoilVTtML9hjhEWme9X+OI3uHvJAoDZVfUi0lNc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LPDcYUBFQAelgpOVCpHr7/kMTV7rdnWWpm+6yQEF1Ef3+VFvUbpKto5WS6IphINgT
 EUbS1b+0HX1Gx5IOht+wVo2fHLxnoOPlJb9fCJnmzLfUzPOSKtCVfKuKXUnNKKkWNT
 m4xXXYhjKDSVVKZmCWhttGHlzfBiyl2OeuJcIXZZrRdcoy80URI9oGzmpOA2ANyHFb
 K+WNVvl7LKmND7UFnyVBPlqpbolyw33wIviIgbzJg46kmu0s+Wr/4xPNIBkhQ3YX8s
 bCjuwxCFyV0CjRtbmI0mdK8vF7PWUT2992RmsPvApZZxT9OZwnGCd+Ex3MnNLtmkm6
 F6zjJRCGnz4Dg==
Date: Thu, 11 Jan 2024 13:18:41 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
Subject: Re: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
Message-ID: <20240111131841.1d816695@wsk>
In-Reply-To: <20240111131150.58928307@wsk>
References: <20240111110611.2051821-1-lukma@denx.de>
 <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
 <CAOMZO5BgwgWPs2mn78bAC4uVQ9Dgm4mWcS5==EnRuZtOuQ6SwQ@mail.gmail.com>
 <20240111131150.58928307@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fubkaME4I0rclIh6+.879Bp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/fubkaME4I0rclIh6+.879Bp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Fabio,
>=20
> > On Thu, Jan 11, 2024 at 8:16=E2=80=AFAM Fabio Estevam <festevam@gmail.c=
om>
> > wrote: =20
> > >
> > > Hi Lukasz,
> > >
> > > On Thu, Jan 11, 2024 at 8:06=E2=80=AFAM Lukasz Majewski <lukma@denx.d=
e>
> > > wrote:  =20
> > > > +serverip=3D10.8.217.79
> > > > +nfs_serverip=3D10.8.218.113
> > > > +gatewayip=3D10.8.209.250   =20
> > >
> > > These IP addresses should not be hardcoded here.
> > >
> > > They were not present in xea.h originally. Please remove them.   =20
> >=20
> > One more thing: xea.h had:
> > "dtbfile=3Dimx28-xea.dtb\0"
> >=20
> > but  I don't see dtbfile declared inside the new xea.env. =20
>=20
> Thanks for spotting it - I've forgotten to remove it after moving
> forward to fitImage.
>=20
> I will remove it.
>=20

This will be added not removed...

>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/fubkaME4I0rclIh6+.879Bp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWf3KEACgkQAR8vZIA0
zr2W5wf/fru/OB1TzdkoMbRyPpZ99fF+tiZc3PgtbjmDtWiz3LYggbsozckvV4BG
gozG8jXFkHANn4X1SWe6FWkZ60ZmtAXHfCJgL8+5LPKBDRlQH1szE+ZyX8C94tc+
IyB3UN9SqrUOnnIwiSWyV08eimRtSzuL6WJDdU6xYsHvlAeaVPkmybCFtz+yanvj
nbsFzv7Ja1bxvSZ2/iSF4MponHpihbbQcqS9L288+PepDzEdIb+s1sBBuShoi3EL
8nBFlR0bA6MHUsNk9QUITZylBhUhWrjDI6LBZQ2Or7cGo2CJGvS2+6ZVF2GpYtnt
gIMXOh1DZnqJB3xt4P1VXAsEVs30Qw==
=gGpt
-----END PGP SIGNATURE-----

--Sig_/fubkaME4I0rclIh6+.879Bp--
