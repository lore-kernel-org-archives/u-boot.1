Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F12C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5278886A;
	Mon,  5 Aug 2024 10:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722846529;
	bh=2xW12YRK18NClevFoegglY0EOf9PYFi90iOYf69BRxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBEAwKfEGiJrIWufivIuvhfowm8No2cIqi2xiTV9X671SXqpFDWFsmwQscfDvuar3
	 bSW4nHiyspbIISAArKO1wM0oFSdzgCWQlx4m7bmO4TwXkM81Un/UBxKbtmc1r6p84p
	 xZtG3LwH8ONLvjM7lgrPAqVsOP+LrVv1DyHzv0Q1GCbgR73T5viRa+XRKUcLiYs8rz
	 b948UrMcPvGDXM3m6X8B2l/D+JR5APJiomaVwiOmIfIREpaqtpdxE2eJdVwtDvC8+J
	 f0Ai1SZpOCuc9BMddcs9FnyHuaA83nzwef+01W4oEYwYn0dr5Da3tBZiZaKuQpQo4W
	 dj2WrGhRdoPIw==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6FE0B881A1;
 Mon,  5 Aug 2024 10:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722846528;
 bh=2xW12YRK18NClevFoegglY0EOf9PYFi90iOYf69BRxg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XYZwAURYOowePD/55g+QzKIYpmjaTmdWZ9cHzPolPd6pj1TxR/VVWo1AcpNLs4vE+
 OjzL5YqVrFdl89knwhhhPbyP7zHV8ltDHSYscon6/3n1klkN3slqp7rikPQdqrmP4k
 oUt+V7bGPbVBHC9pF+HvLKAfKp5cY8HMZWw4i0P9D1DJzTYr9egvKQe4hsPXHechqS
 odTQHwUgGfEmKudSjluVPw6x5WFaFaLIEoljpKG4Yp1pIbhT8r22LxjOvroQo1/nbq
 1+7VbIzwM8bEEVpISljSx5/SHjU9X8/DReaECvouzGhn5jObq89svrOsoXrmK3sUDj
 ZxgCChLu+scyw==
Date: Mon, 5 Aug 2024 10:28:46 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh
 <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, Simon
 Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 2/2] config: Adjust Phytec imx8mm module config to
 support NVME disk
Message-ID: <20240805102846.4f268934@wsk>
In-Reply-To: <CAOMZO5CgH+NQ0e66nvgtAr_UbdiWm1Tc+8FDuBJGLsx6=xejtQ@mail.gmail.com>
References: <20240801144650.1635599-1-lukma@denx.de>
 <CAOMZO5CgH+NQ0e66nvgtAr_UbdiWm1Tc+8FDuBJGLsx6=xejtQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xmv7UGmt814ajjEAXaiRgqU";
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

--Sig_/Xmv7UGmt814ajjEAXaiRgqU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> On Thu, Aug 1, 2024 at 11:47=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > This change adds support for PCIe connected nvme disk -
> > phyBOARD-Polis base board.
> >
> > One needs to call following commands in u-boot: =20
> > > pci enum
> > > nvme scan
> > > nvme info =20
> >
> > And then ones to access proper file system (like fat[ls|load|write],
> > ext4[ls|load|write]).
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Remove not needed adjustment for
> > CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000 =20
>=20
> Applied only this one, thanks.

Thanks :-)


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Xmv7UGmt814ajjEAXaiRgqU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmawjT4ACgkQAR8vZIA0
zr1gjAgAvCPlNBZPrxJAfvwOZ3uat15pkNgwC7lWde2urQe468EbhtLm3dy/loGt
azyPtc2yVXupNLPntu9fSBR9FwQH3GJLlUfqVXrATqF3B76Yjgi9B5pXPADKHEZ3
8D2dp5MeGx5e90NhGUZrZNJVDB5S5rE3PQLEy0aWzPucNe68q/SK0L6ZQETK6/5t
TOLzJybPYcv3RO6uFuPgWnq/yxAXpElpV4maINC9OIkBjjj+D1qZH/+f3HvVapc7
8SUP9yyNxItApQZV/EVQLm4533DNrHuK9Exv5XMVrvNWVGQcRY1KlXiN4pcHu21I
5PRrJVWRfBMS+hWjdcYzsNoAxAdaCw==
=T6pp
-----END PGP SIGNATURE-----

--Sig_/Xmv7UGmt814ajjEAXaiRgqU--
