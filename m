Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDED0C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137E48786C;
	Thu, 11 Jan 2024 09:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704961098;
	bh=N02v3Z/bZZnlHi6QTlUlQps4NW09P6oc/klbjKy0tPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGxrJDWNiD828qPAUmZB+QvdARgmOr7eqWBi0/osXWyYhMnoUH/JStyCNIAwr/1aX
	 BUP1XTPBbLm7aM56zNiXfjsKyJtZpN6C4XZ5YjwRgmpXQ6ZvKbGj3hmH9plsTKiaMn
	 nGqSss49BXlRCZeBMKT8XjbeLzRa+nWPL8WAbvsv5DOcCw5obrzNBq5mZcosyXl1l0
	 AM4MKQescRfQ4z/RJc4IZ95Z8geD7zfIjpO4jwAZYbCZQk5FIDuYfDwqIq12b10QiY
	 Kb4sUkpY+QXyb7ykykX+f5wgolP4YbpB7wwjMVwsX5/oDS1w3na5VC+WHpK/vHzcV1
	 C2xq8NkAdEBWA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA2F58718A;
 Thu, 11 Jan 2024 09:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704961097;
 bh=N02v3Z/bZZnlHi6QTlUlQps4NW09P6oc/klbjKy0tPU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i3OI/G9220oWD1LK8uNWzSqjzK/CDFlseOO9zcfjAUMU8Mu2UnAiKOH9Jp6rcxX9o
 0jJwuixJFIqy3elLneZczDYoiYgAqkaFJ15RcWr0/v8zo80yyn77CV4QCZLvMuzf+3
 nmJ0Xtrl6IdABZK/LjDCqCsopdkwmobRwg4dJvgEly8KQETOUVwNx5z4gyWhOip0f7
 GeLsZ1dNCvLatStC02pGpdEnpZr/EZ42l4wRZexFp/PL55jbWAlW6yw2fTX6qOY5be
 rAJUeOq8apuhdC1vT8ARZPT1AuVu7JF4CnTO5B0E3b0E8zdn3w9TYjESLKohz74PtU
 6lVpgRVDLc4iw==
Date: Thu, 11 Jan 2024 09:18:16 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
Subject: Re: [PATCH v1 1/3] arm: config: xea: Update environment variables
 for XEA board (imx287)
Message-ID: <20240111091816.0913390b@wsk>
In-Reply-To: <20240110145252.GE1610741@bill-the-cat>
References: <20240110144849.1783122-1-lukma@denx.de>
 <20240110145252.GE1610741@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7C1AByNkrF7k8ta2ct7o=SM";
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

--Sig_/7C1AByNkrF7k8ta2ct7o=SM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Wed, Jan 10, 2024 at 03:48:47PM +0100, Lukasz Majewski wrote:
>=20
> > As the XEA now supports fitImage, the default envs shall reflect
> > this as well.
> >=20
> > Moreover, some SPI-NOR layout re-organization has took place.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >=20
> >  include/configs/xea.h | 45
> > ++++++++++++++++++++++++------------------- 1 file changed, 25
> > insertions(+), 20 deletions(-) =20
>=20
> Please migrate this to a plain text environment.
>=20

Ok, so I will prepare new patch especially for it.

(IMHO, patches 2/3 and 3/3 can be applied without this one).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7C1AByNkrF7k8ta2ct7o=SM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWfpEgACgkQAR8vZIA0
zr2OkwgAld0fB7kQyzdc1/2fZydjFvOPbzkTRBN0I+VjMwV8Ss2DcHRxEGCAupvP
Jt4WwBNyhjlvELtUyjzGFy/ZSsITS+gVlP9w2fWt229v9WG37LtNAvUXlc+rNUB/
UE5YZHsD0AqoMwOWu7JxDTdC/8kBkE3MXCtJrM8H0Q9PTT56EVXRHiOvRGzzGDhU
Kf2T6crWRU/ZE9ddOVNUOHtMdtHbAdLmbuujqjPJR7rlhK4KEzO/fi1G21C5qo0r
q04k1Fxm7t/vrXmXKOT6peEv0ZkCi03XDkBiGQfJ83dCSA0BskubRYAN9ExJL01E
TgF7dQOx09jntWzMeLC8MY60v4g8LA==
=hBYI
-----END PGP SIGNATURE-----

--Sig_/7C1AByNkrF7k8ta2ct7o=SM--
