Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4794BC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 13:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9BF87F65;
	Tue, 26 Mar 2024 14:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711461013;
	bh=z1zkJQqt1bzPmfCQ1067Qy5Hj5ahWZk225FYCgC4G+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbDg4TG1ouZaquEj3HINjIkTpf2K9B+MAwpHs7Nf23UNccC7QPjDSjcVGHNh/u10j
	 WDk8qCo6Xy+9F4+7pu3TNZ9ik4qGcnIiizKRpJKTddDP6bfXtVzk8uz7Raz7FN4POP
	 vVNfvVDi3gYL2XwM9LfKUf3x4KcQLetnRPKBqHlzvbMBpbPmz6MeoyRyaFuglRJaxj
	 PILaIVYMjjxQ6IXaKhNW5wpHsbYF1Sqs65L5isvIT+MoHXow+U1ZupEoKot+pXnqZm
	 wXbhYUQq/1hHix61bkquz7ZWsckKQbDOv2s5/VbcbBTf/IRh8JLJ+vZH8IstL4hnsW
	 cWJK+5xMxjGFg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 495CC87C62;
 Tue, 26 Mar 2024 14:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711461012;
 bh=z1zkJQqt1bzPmfCQ1067Qy5Hj5ahWZk225FYCgC4G+g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mw6pIlQ4ZZ0moUj1YOUtEVa0c6QUHxaneyQlBy5I3KAYrhzC/Fnr2vgLvxml8B01e
 yInm0kDINxLWdkbrXUABz9c8tANxxNBfcOnb5zBGKxU/mKqLw9e9HybNVSYbqia54C
 a8Fs5cNQy2r9YIh6jH32hlwnSSOLTZNqgNCiJ5u6yj9mVq4o7mI0E9kntrdWdHpiFi
 fKx1k4XNoiI3TEfCLU4MKlz9kWyyWpw0TuF4GpTrXZxI9oEBE2YZV9M7pdXO00Z08N
 MIaUsIjl5bvko9JL9IBGhlW5meiguqJLfELmljtyQTW46Lu3sOVEEOZbtBlcsi3piR
 MKYeHlHEHMysQ==
Date: Tue, 26 Mar 2024 14:50:05 +0100
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
Message-ID: <20240326145005.09093974@wsk>
In-Reply-To: <CAOMZO5A-hSn9qQ2WkdBLQFPhSb4KxfAw=z9sMyVHKjxBeo8Vzw@mail.gmail.com>
References: <20240322114315.2720727-1-lukma@denx.de>
 <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
 <20240325094812.480d23c8@wsk>
 <CAOMZO5A-hSn9qQ2WkdBLQFPhSb4KxfAw=z9sMyVHKjxBeo8Vzw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ir4MnLWe14at1v3OI+brBI0";
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

--Sig_/ir4MnLWe14at1v3OI+brBI0
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

Yes, exactly.

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

Ok.

> In U-Boot, we want to re-use the upstream Linux devicetree files
> 'as-is'.
>=20

Yes, I'm fully aware of this. However, the U-Boot size increases
rapidly...

> Adding -u-boot.dtsi files is OK though.
>=20

Yes, this is a good way (with /delete-node) to reduce the size.

> Can you convert the imx28-xea board to OF_UPSTREAM available in the
> U-Boot next branch?

I will check if XEA can be moved to OF_UPSTREAM.

>=20
> > Hence, the rename of files (which would be in sync with Linux at
> > some point) looks like not related to Linux DTS (as even after
> > re-sync with upstream Linux those changes will not be in Linux
> > DTS). =20
>=20
> I did not understand this part, do you mean that Linux will also do
> the imx28-xea.dts =3D> imx28-xea.dtsi rename and will also have the new
> imx28-xea-1.dts and imx28-xea-2.dts?

Yes. Exactly. I started the conversion from u-boot. Updating Linux DTS
will be next.

>=20
> Regards,
>=20
> Fabio Estevam




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ir4MnLWe14at1v3OI+brBI0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYC0o0ACgkQAR8vZIA0
zr3Ltwf/bc8bRiAeaWGSwirZo2PZNkCP9zf/08SYId/TCTiH2ZIZbInZwhwO8O9b
rjdejwptNONAyBtGChuwKrfe8lOk/VduM6w0TJagpCjo8lHRh/jGiQOGGDqFXkUy
RadaDZrlHcUSOdZrodMBq0Ogi4Ih0bgvOKmT47qvlZ2uXTnQKeNLPB8/uggkiKv0
P8Y3kEqnyNKHQJa3o3LNR78jn67FJxouKKQFMdq1yIziC1viuqJOCqjsM9SvBER4
ltNbV5YAnhNbQxG6+uWtwGyacezlqx2orhUpy6jKHuOY25Mu0dy/R9DXpi5FPXip
C2VJi3TqlZdh28GdctLjravtUrb6qg==
=S6Ti
-----END PGP SIGNATURE-----

--Sig_/ir4MnLWe14at1v3OI+brBI0--
