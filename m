Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A36C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FC28805B;
	Wed, 27 Mar 2024 13:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711541116;
	bh=kK5+y2UkgAPry85jOWTbBoIounY5Kv88TFQVh/x2fWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9fVJr7dBOtoNvZ0K3+itRZdlbnUe06Kgplh0BBoAL8i9enSzL9lz3oYiLDGbgrxW
	 uER3l3hx9eyX82KCRKmCvO53GEsT6FPeRFNC9NIeNiEJqDdICt30jlvSjDA4p1DCQY
	 tGf0RF2/qaInTfjerWkwPUoY+hiz96xSq12kQ46UNF0DxT4uSTGWdFdv1po4uydyTP
	 jHg8dIB6yDiew444mP3M8tThRL9YdBxmz7bulKuU48Fp54E927GEmMk1mQvy+Y6R2T
	 yRNSl+FlOYgZ5nW6dcSkFXxr1L9y8DI6Pngm/Y6Hsj/6P6kMKdmm+7xXTb2SgZu/mP
	 nQ5KDtR7oFzow==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0824A8802E;
 Wed, 27 Mar 2024 13:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711541115;
 bh=kK5+y2UkgAPry85jOWTbBoIounY5Kv88TFQVh/x2fWI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uFMh/2nWJV/7RJjSD8CjPDjitzzCpyo9ICd60SFZ7CY1C+pMbKnPhX/NpGwhZKfeg
 TLaOhXwftyFpKXw8iMnm1G1l1ebCiBeRRf1U0jp6r6GQeJCCNYWK2XxuDnnnIrFEcu
 /ELFcvdWBtHS372N66GuFkmBuCxDl7ef3qpeanAoRuONHhmnA3E+W9NKKCRmwFrIZB
 Vo0bOrgcUe9Y6PRzp0PY6paxbhqDENaa6Me09kCSr1DCMUMBaspHcf+E4W15BHhHmF
 Gt9szqifuRGgcKIqsu8ITlqPsHe8qpoutOC+1BtPNSleF1FYIiKsyO1bQsUiIwLOyz
 jXVvh3QeZ+jNA==
Date: Wed, 27 Mar 2024 13:05:08 +0100
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
Message-ID: <20240327130508.604f598f@wsk>
In-Reply-To: <CAOMZO5A-hSn9qQ2WkdBLQFPhSb4KxfAw=z9sMyVHKjxBeo8Vzw@mail.gmail.com>
References: <20240322114315.2720727-1-lukma@denx.de>
 <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
 <20240325094812.480d23c8@wsk>
 <CAOMZO5A-hSn9qQ2WkdBLQFPhSb4KxfAw=z9sMyVHKjxBeo8Vzw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/viX0.ERF3n3Dz2HvfeV_lk7";
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

--Sig_/viX0.ERF3n3Dz2HvfeV_lk7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Mar 25, 2024 at 5:48=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>=20
> > The case here is that I'm modifying the *-u-boot.dts{i} files only.
> > In =20
>=20
> The diff below shows that you are creating imx28-xea-1.dts and
> imx28-xea-2.dts for U-Boot consumption and renaming the upstream
> imx28-xea.dts to imx28-xea.dts.
>=20
> create mode 100644 arch/arm/dts/imx28-xea-1.dts
> create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
> create mode 100644 arch/arm/dts/imx28-xea-2.dts
> rename arch/arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} (100%)
>=20
> > other words, u-boot will not support features described in Linux
> > DTS. =20
>=20
> That's OK and this happens frequently.
>=20
> For example, upstream devicetree may describes audio codec,
> but U-Boot does not support audio playback.
>=20
> Devicetree should be OS agnostic.
>=20
> In U-Boot, we want to re-use the upstream Linux devicetree files
> 'as-is'.
>=20
> Adding -u-boot.dtsi files is OK though.
>=20
> Can you convert the imx28-xea board to OF_UPSTREAM available in the
> U-Boot next branch?
>=20
> > Hence, the rename of files (which would be in sync with Linux at
> > some point) looks like not related to Linux DTS (as even after
> > re-sync with upstream Linux those changes will not be in Linux
> > DTS). =20
>=20
> I did not understand this part, do you mean that Linux will also do
> the imx28-xea.dts =3D> imx28-xea.dtsi rename and will also have the new
> imx28-xea-1.dts and imx28-xea-2.dts?
>=20

Just a small update - the Linux kernel's imx28-xea.dts [1] doesn't have
switch/phy properties as the earlier attempts to add L2 switch support
for Linux mainline were not accepted by the network stack community.

Hence, the decision to omit those properties (and there is no decision
if another attempt for L2 switch support upstreaming will be done in the
near future).

In u-boot the -u-boot.dts[i] files were used to add functionality not
(yet) supported in Linux kernel.

To sum up - I cannot create imx28-xea-1.dts and imx28-xea-2.dts in Linux
as properties which are different in those two revisions are not present
in the current Linux dts description. I cannot say when all XEA
functionality will be added to Linux.

Links:

[1] -
https://elixir.bootlin.com/linux/v6.9-rc1/source/arch/arm/boot/dts/nxp/mxs/=
imx28-xea.dts

> Regards,
>=20
> Fabio Estevam




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/viX0.ERF3n3Dz2HvfeV_lk7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYEC3QACgkQAR8vZIA0
zr0wAgf/Zb6ViE2Zmr2bPK8hgAd/yHbNPI+TZ4yW+7b25wPwuAkhcNjWvpWbxJy3
gTZOwiSZfUMsiir4s8OfPpQ3ENj/FkGViQks3AWspuD9om3buD3FeZVjRgv1B9h/
2n3MBPce+bGMWfiMR1SZpLkRfZVmJpIyxA5P+77dUHt/SpQxPbuGbjYfNJJDahpH
+h/0GSVA+qV1OPDgCQ1zEE+Jv+Se30Pjr6/+8cT7gtsu/anQhbUFSiFGAAP0LEiB
CHoDOZswjRvDoMWSwEMKPuzxLzJSFP4Xqd2FSWTPAwft3jfxwSUvnh5tAx5DEK/J
qP7rlOCvprwBM9F8ZL91tKSDvwdwnw==
=hXIs
-----END PGP SIGNATURE-----

--Sig_/viX0.ERF3n3Dz2HvfeV_lk7--
