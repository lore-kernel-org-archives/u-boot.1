Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5EC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BC988B17;
	Thu,  1 Aug 2024 16:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722523339;
	bh=YTshFCTD1WOCr928axjfA/nLwpvxmzrFn3Z+CUovkms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxmLHTu1P2szCac/NphTk3e7J6wZCLA0oE4ljZXLWTcl6nt78kPKBGbq9moULZKtw
	 wvkkw79SRwaqzZ1gCPPQ3z3vc8r9G9OSUkE9ZLSYlp9n1MJVFmzk0lp0hxaCyvqmY6
	 B3qqqCvUkX1RtICpq2aUGv6IKsdmiE5IRVvmFucNCeXsbDzRGXR8NRSw1oWdnQtlUs
	 YzUOqkazjuOpmDgucG868iccwE9FLX0ZbyQNtk4TR7wJ74j9dq7zYrfyLZf59NJGoq
	 OiUwlecg2+kLNuNsOQAZpmgnChUijwI2w9qKdvA2y5zIHfqF/uAO+vZ/XKL1cblBph
	 NS24quGMwfxvg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 59BB188A15;
 Thu,  1 Aug 2024 16:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722523337;
 bh=YTshFCTD1WOCr928axjfA/nLwpvxmzrFn3Z+CUovkms=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=al+JalvGU3phJoHHTWvzWQJiyRlia5AfggN8gmJeyfX4j8Pai2R3r4nIvr4WaUNeF
 SMFODHsPNeGs43+3PjRnOwbwhCpkDdii19QkW/L8O24IZ3nMPquyxYy5r144ahxi5F
 Qq9UIbA/wB0qn9pGiM1o06qGPbWUIrEt5XvtUXj2zHEuhM8ZpQntr9HMeI9Fqlddpl
 RC7SAzAG3q5F4myyaA4jzddYG+OXOm5UZ7qg2JJbhmityUCDWjL9iOveZnr921dJ88
 0sX+dK0san+htwj18GYPj6JVO7WO7LxZUyjC3PfC7rnUUEVP/6Hfxxjwf5ZxgYGaur
 Cwcypul8HoJAQ==
Date: Thu, 1 Aug 2024 16:42:16 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh
 <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, Simon
 Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] config: Adjust Phytec imx8mm module config to
 support NVME disk
Message-ID: <20240801164216.40eec3ec@wsk>
In-Reply-To: <CAOMZO5CqQtUOt1zgL7x8goSaH=HeFwQkg3-CJtY=ynyHgg7=bA@mail.gmail.com>
References: <20240801125416.1582652-1-lukma@denx.de>
 <20240801125416.1582652-2-lukma@denx.de>
 <CAOMZO5CqQtUOt1zgL7x8goSaH=HeFwQkg3-CJtY=ynyHgg7=bA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wOcUKARxlj/qSvdOp_w/1XX";
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

--Sig_/wOcUKARxlj/qSvdOp_w/1XX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Aug 1, 2024 at 9:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>=20
> > +CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000 =20
>=20
> Please explain why this option was added.

It must have been slipped in...

Default value is 5000 for this SoM.

IMHO it would be safe to remove it (and use default value) - I will
prepare v2 without it. Thanks for spotting it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/wOcUKARxlj/qSvdOp_w/1XX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmarnsgACgkQAR8vZIA0
zr2+gQgAgUwQBGnkRUokC4EOgO2DZcpkD8Dd9T8dEKpDiQ/dHrR1kR8kYmacDKDN
hyiVT5tCe6kwuc7mVaxf1QQcZckKBsMutzmz4JnSyho0xt52FteGd4MdmztCpLr2
SHgj+GjjVZGa9BEhJTraP8YMvjaMNPc+lUNEVc5+RUFkyniM0sGKTjZbDMoAo1iI
Ch1WbR5+ftBeFSIa5szt2p8VdQ9kKmc6ja0qeshN/W7dhuuRwVaJBe8wKbe+RgWS
XVQSibjpKgakrnwah5r1xnqaFU7k9J03LbjL9oGG0A9TmODlxno96r4Hravmm9Ga
rBf3Fzgpkluj8cHgwDpbHaoKxecTMw==
=NxAY
-----END PGP SIGNATURE-----

--Sig_/wOcUKARxlj/qSvdOp_w/1XX--
