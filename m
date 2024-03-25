Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD5EC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04AF487DFA;
	Mon, 25 Mar 2024 09:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711356502;
	bh=UL4Grey3YWWT+241vCVICP54o4lFHVf4gMet1RBlOf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCov/GnJQ8AQQu9iujoJbPR1vYf/dsBMoG0TKKQT70eNjspwR9IMyx9uhq+bTCq3q
	 rfTG5+dpMP7U5AZis1h6pBk09gTtqzZCxJJ2eoT0kSfKFjwtYkRhZ+5QDio1IAXWWh
	 CzkMV8iBW+pEVu3afss6p2OFBL/5KNLnycd8++77R1io/wY3Aqrwyt6XUC4nrLSTK6
	 PjGeYy2UGbTXRTFuwOPw1HTCk2qIfuJpaw7LlOE2gLM09u44VS5fyEzvfNCuPYX1g3
	 gr1bMYzQlCN8Cfz72HFSYCSkYMERY/4CxnFO5AvkhLRE10PWS7+kwnhFGTgq7GrQ1D
	 q1V61XNjyWO/A==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 199B387DC8;
 Mon, 25 Mar 2024 09:48:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711356500;
 bh=UL4Grey3YWWT+241vCVICP54o4lFHVf4gMet1RBlOf8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CTcrQ+x2exLN67aK3zSHazOW8PER+67oZuDPK0OCSFgGozLa3d86K9zC0aORN1tkp
 US8R9Df9+B+bBwBj+iFkittb8yMRpR+AZpqgQP0cH25AXe84gNHoRcM4Gn0ykJdw2E
 n7waR0EqUQx3HFx1rP4rLTdv7UingmoopxUJplNvNGE/Wh3qT9fk4XNtwdXUchLEcx
 NeclzCUgAkt4xO/aicGECAkM8sMxHbpf1LemFx9dGc9WM/LAEaIf1NB+QPGjNXNDTa
 oVLxLSXSfX/8mAaoE3fFb9ZZ3kliL+4o6a6yQmCyCBoxNOsiVhoab5UXc9M9cJHVa9
 2ltK0uFRDl7JA==
Date: Mon, 25 Mar 2024 09:48:12 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, Anatolij Gustschin
 <agust@denx.de>, Christian Hewitt <christianshewitt@gmail.com>, FUKAUMI
 Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>, Michal Simek
 <michal.simek@amd.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/12] arm: xea: Provide support for different XEA board
 HW versions
Message-ID: <20240325094812.480d23c8@wsk>
In-Reply-To: <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
References: <20240322114315.2720727-1-lukma@denx.de>
 <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MTAPfCjDr1+L2Q1GSwHocur";
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

--Sig_/MTAPfCjDr1+L2Q1GSwHocur
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Fri, Mar 22, 2024 at 8:43=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>=20
> >  arch/arm/dts/Makefile                         |  3 +-
> >  arch/arm/dts/imx28-xea-1-u-boot.dtsi          | 11 ++++
> >  arch/arm/dts/imx28-xea-1.dts                  |  8 +++
> >  arch/arm/dts/imx28-xea-2-u-boot.dtsi          | 11 ++++
> >  arch/arm/dts/imx28-xea-2.dts                  |  8 +++
> >  arch/arm/dts/imx28-xea-u-boot.dtsi            |  1 -
> >  .../arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} |  0 =20
>=20
> This rename deviates from the upstream devicetree name.
>=20
> Ideally, we should convert to OF_UPSTREAM available in U-Boot next.
>=20
> >  board/liebherr/xea/spl_xea.c                  | 21 +++---
> >  board/liebherr/xea/xea.c                      | 65
> > +++++++++++++++++++ board/liebherr/xea/xea.env                    |
> >  4 +- configs/imx28_xea_defconfig                   |  5 +-
> >  configs/imx28_xea_sb_defconfig                |  5 +-
> >  12 files changed, 128 insertions(+), 14 deletions(-)
> >  create mode 100644 arch/arm/dts/imx28-xea-1-u-boot.dtsi =20
>=20
> >  create mode 100644 arch/arm/dts/imx28-xea-1.dts
> >  create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/imx28-xea-2.dts
> >  rename arch/arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} (100%) =20
>=20
> You should upstream imx28-xea-1.dts and imx28-xea-2.dts first.

The case here is that I'm modifying the *-u-boot.dts{i} files only. In
other words, u-boot will not support features described in Linux DTS.

Hence, the rename of files (which would be in sync with Linux at some
point) looks like not related to Linux DTS (as even after re-sync with
upstream Linux those changes will not be in Linux DTS).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/MTAPfCjDr1+L2Q1GSwHocur
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYBOkwACgkQAR8vZIA0
zr0F1QgAlgUMWB5gUXwXHt4uRINZk2CB345O0CPBNVkYuoFFlbP8jQjxQ2I6Cs2R
jJqj/7TsTqvYz2zcdKcwWvNb3rEN7YO4QogHWknfvyW3E/X1JzHoVyFmEsuyhB18
rIbiwnKDyyH2xPtJZJByqhFkmZ4oqBy/wqtyskth9fgA6fxH7zYSVvdDiFSDk1Zq
PnTe4MT32VjahllBj5ra3DG7KS9AixQS7Vt0ouv6p0sYsn4NxCvcq4H3YvWlsams
bL6elHhxS5h4bITv4WkrTddyjFQgyiwEG2Uq+6NgZp7BTyiDV4SIr6Hjb41tQ3rm
euitbnbUjGxqZMSOBRGkQDxUypfkfg==
=8qwT
-----END PGP SIGNATURE-----

--Sig_/MTAPfCjDr1+L2Q1GSwHocur--
