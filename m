Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDA7C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E198388A99;
	Thu, 15 Aug 2024 22:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723752900;
	bh=CPhWJtEfjzJ6yl/pBWHO/SyO9pE7VuoM4ffMBSGktbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWtwit+PQVfWW37S7o0QKiGZRi9gJGI0Z+l+DfEg0pxSUS21Ydx/1Is0/sffieYS1
	 4hoAEXXyBMiTqmobMdgaq1jnXh9suef8M3eGuEPOX1jF3r7oBZ/5hXtIK4x5xz7GPU
	 6aBc+9YWyYilb95PVx+90sw9r8DoJq51Cib6VipJGXE1ZPnmkaNVupS+4JzmhCS/oK
	 mkZptenwuYqCU9IptVdehS8K/YYPP7htiosJVXyFX0nNXLm2JG/WlOKLqJf4M9NRYe
	 qWX2B2Pt5OsnNjAu4Mf/NclcZTU/Kfpgqbpctfh4u081178jW04ooqAP9pqCH8kBzo
	 04Rw1N8/AMVPQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1D5ED8863B;
 Thu, 15 Aug 2024 22:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723752899;
 bh=CPhWJtEfjzJ6yl/pBWHO/SyO9pE7VuoM4ffMBSGktbc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=inLTsAwPpbh+IEro3JthXdPgPkHniePCvRP7pdjDIoEasoORIFJtZWqc6TnjxyQM4
 l5+f6b8QDi4jydWkBmOYDNkMXt80Op51AYTYNCMD/AZE1cf8cRc80kVFDXQCs8nBG7
 xWtucXy7XoeP9TTWbQUMz1tlMGcBMHRGSTaRkvwwlMQSwQ7Y93IK3QVjKt8Gu/wNPX
 YQvBlMfVJaGJmBnESLrmoMr8dOQGaOoqNTFjZpo0GLF5FLhQzOSUiwEIWXHS6V2V0z
 B3lSX1hUrzbWIIfd3hE67Xi7CRmIcKSsae/T4Np9//983naYxTmtB9RZvJ3XVLDzuN
 LfgnILliYsPFQ==
Date: Thu, 15 Aug 2024 22:14:58 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de, Yannic Moog <y.moog@phytec.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH] config: imx: Add PHYTEC's phycore-imx8mm-fspi_defconfig
Message-ID: <20240815221458.1ecb4947@wsk>
In-Reply-To: <CAOMZO5BM0w1aphmZ4D5cEch_eWVT3ebeZa3gfB9TbfGcT_gOdA@mail.gmail.com>
References: <20240815084012.477436-1-lukma@denx.de>
 <CAOMZO5BM0w1aphmZ4D5cEch_eWVT3ebeZa3gfB9TbfGcT_gOdA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/owAtGYs6N4Qt6UTo_Xwfwbx";
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

--Sig_/owAtGYs6N4Qt6UTo_Xwfwbx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Aug 15, 2024 at 5:40=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > This configuration file provides support for booting phycore module
> > (on e.g. polis-rdk base development board) from QSPI memory.
> >
> > Moreover, the SDP SPL gadget is supported, so single flash.bin
> > binary can be used with uuu (with uuu -v -b qspi ~/u-boot/flash.bin)
> > to flash QSPI in the factory or during debricking. =20
>=20
> This looks good.
>=20
> I suggest adding an entry in doc/board/phytec/phycore-imx8mm.rst to
> explain how to build and flash U-Boot for booting via QSPI.
>=20
> This can be a separate patch though.
>=20

+1

> Reviewed-by: Fabio Estevam <festevam@gmail.com>




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/owAtGYs6N4Qt6UTo_Xwfwbx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma+YcIACgkQAR8vZIA0
zr0qdwf/UUqyGo1XBqoxdLzyYjAn9S6bZkPuNYWjcBglzmpaui2UipAlF5g8X+Ai
pvipEEWM9Sq1oYmQN9SmvBImzXfLo7+ZVEhtN7gTqYx3vqMwDg5GhlX+zkaXjaMI
YrMysZn7j3wH8oht4ZzyxyH7fAYfXzJ32HokQdFCaC7jDkopHLH/cGTTP4IqBSEX
oiSAiR5xm9YV47co+4CWii4VPIMXhu96HXjYC+2+/4zOuloMOrsctYLjHlmQDZvu
ALwVE2C/+VXIDuNdxssL+tvmp3+aWO4OkL/MPUF9S7V7cRFobZkWqhHOlHenGHq9
5/YQ6r0jIYdPrc7SIh9dV11VBqjNeg==
=Phiq
-----END PGP SIGNATURE-----

--Sig_/owAtGYs6N4Qt6UTo_Xwfwbx--
