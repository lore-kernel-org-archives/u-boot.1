Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B968CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D54830B4;
	Tue,  9 Sep 2025 16:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/joM69J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A9D8309E; Tue,  9 Sep 2025 16:37:18 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2371E8309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce534a91so2361138fac.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757428635; x=1758033435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d6gK5WRzcbiAr76gYAvzNGHpquZVhAkjMCCbDA1UGSc=;
 b=D/joM69JuJGdhkWbgAV5nnTx6ley3po1RRO3NA52YqPgcg4AUncznHJkuJFTd23u8I
 9//JMjGiQYlxV5oOpMURgk4x+2Kclx88nO+pflzjk/jHFuihWpu36Q/5im2Oi1IjHB/u
 IyyHx33RvhJOV/h5diz8zUlBvhCPlwWArqE+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757428635; x=1758033435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6gK5WRzcbiAr76gYAvzNGHpquZVhAkjMCCbDA1UGSc=;
 b=HQgavO5NL1kgrpzQPmkpXVZdVsjUwLgr3usR7KWpqMQ+dzMvfzBgdDvvFikTn9EBOz
 kGQBUrmNHIV/jUQ7xb9A37L9/Iu4FJcA4ZNe5CVKwZlnCWn4mE2GsR904SRQdJTDEPQF
 FazWCugBs4lCW1SrNRgSMqrRpR+l8+6Y3tMsndutztDAHuRrj4wcbb2zo7lsC9vJuO/g
 9f4wvqpFfnQgnf56vuxOM/mxqdNIm6hiDUSiQfZx2dK39xVWUfWDJ3M1ISQmjT2tUs3R
 CljuN08ZKJ0meSsP+JzUr+sAuvf5fcagqOAQQjdf8auY3EqIVTb1+mNucoa5C9zR6Zuw
 pI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQI+lFFh0xji76SVFplJx71GAkPnebSrxPKTXXDgpGoog9KdY5AqOLYsb6h21dIstIokfYFds=@lists.denx.de
X-Gm-Message-State: AOJu0YzH7Xae6FpGk9HVw1ExEjSsjOqQmFZIxrM/E5IK85u2Pm6EOGh/
 zoZSLO3aH1fYevNV/hH+6YVXSIjY6mUBUtUWUGPzF4q+jKoZB0JbG45iMM+HfzbmM8Y=
X-Gm-Gg: ASbGncvVx9ZJlq3Ink6Bfp42qShdkNfYulxd9CszFIiaM0uL8RA8ACNJ1CA8uTYCdHo
 95p5bKDjIUqKac9GTg9quhNvdel+O7t5e72VLd906P70NKVYCrMY0rt2YH6sLsSRkoLORDcYAwF
 ncGkXfBsSDzj8j1w81yoS9H4LEcgZF5k7IH9/WUsz6rc3PaKArHnidUsR8mdaL/67gz2dqheTMo
 LaWFyciVt2Kh/geIXpq8GbrJZo43H2/jVQEjT5+azB4QGHbYJeQ+/qOKkSPhr1zYtYbzW4w3F5C
 HSZHtQr3osQzMUpgIHLB7gIWRWkFrcYnpF3eDUUHxJe1K1n+FhbOl8TJw0JmMjx9fDBmCmYaXkD
 mNFWohEBOpipol01WEWp0iR0+BMZK7ZImXLoWuWTwzc3pTR6J4KG5q/D4
X-Google-Smtp-Source: AGHT+IELn4CHLJ3SNPFFnMpB3AG2FiglfETcBcHCOgAV/9eNYmZT+EAQrHCASZHbtwAPLQSGTlDOYA==
X-Received: by 2002:a05:6870:b4ab:b0:321:fcf1:e845 with SMTP id
 586e51a60fabf-32262d77a5bmr4169924fac.19.1757428634615; 
 Tue, 09 Sep 2025 07:37:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319c7aa83e3sm7023827fac.9.2025.09.09.07.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:37:13 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:37:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250909143711.GV124814@bill-the-cat>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
 <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250909162356.6ff75133@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="avoJ0FSPykGzvPZF"
Content-Disposition: inline
In-Reply-To: <20250909162356.6ff75133@kmaincent-XPS-13-7390>
X-Clacks-Overhead: GNU Terry Pratchett
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


--avoJ0FSPykGzvPZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 04:23:56PM +0200, Kory Maincent wrote:
> On Tue, 9 Sep 2025 12:45:10 +0000
> Maarten Brock <Maarten.Brock@sttls.nl> wrote:
>=20
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> > >=20
> > > On Mon, 8 Sep 2025 16:05:04 +0000
> > > Maarten Brock <Maarten.Brock@sttls.nl> wrote:
> > >  =20
> > > > When PMIC drivers are disabled their functions should not be called.
> > > >
> > > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl> =20
> > >=20
> > > There is already board check with board_is_bone or board_is_beaglebon=
ex
> > > call. Is it not sufficient? Why would we disable the PMIC support if =
we are
> > > using one of these boards? =20
> >=20
> > Why would you keep the PMIC support if you are NOT using one of those b=
oards?
> > Note that those checks are at runtime, not at compile time.
> >=20
> > > Maybe the only relevant return would be in scale_vcores_generic, as it
> > > matches the case where the board is not known. =20
> >=20
> > When a board is using a certain PMIC it should be possible to deselect =
all
> > other PMICs that are not present. There is no point in keeping unused c=
ode
> > in the binary. Isn't that the whole idea of the configuration?
> > The current situation gives a build failure when the unused PMIC is
> > deselected.
> >=20
> > This file board/ti/am335x/board.c gives the impression to be useable fo=
r all
> > AM335X based boards, including those yet unknown. What if a board does =
not
> > need any PMIC configuration, because the default strapped config is eno=
ugh,
> > does one still need to drag those drivers along?
> >=20
> > Or to turn things around: if configuration is not to be used to create =
the
> > smallest possible executable image, then why not incorporate all PMIC d=
rivers
> > by default? All those config options could then be removed to simplify =
things
> > a lot.
>=20
> Indeed, I hadn't understood that you would face a build error as the PMIC
> functions are not defined if we disable PMIC configs.
>=20
> I think the first issue is the design of this board.c file, but, well it =
is
> U-boot typical design.=20
> And scale_vcores_generic() is not a generic function at all ...
>=20
> Ok, your change are legit after all.

A thing to keep in mind is that am335x_evm is intended for the TI EVM
family of boards and look-alikes (so all of the beagles which are
kinda-sorta TI EVMs depending on when you asked someone).

--=20
Tom

--avoJ0FSPykGzvPZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMA7lAAKCRAr4qD1Cr/k
CnJVAQDu1MrHlwx5DkV7NdNZsY0jbtE5samYz5QV5aDQQHRufQD/WAa/v6rK7NyB
9ngy6NsyrGjqVCFLDO073OWTh++3XQ8=
=vcSJ
-----END PGP SIGNATURE-----

--avoJ0FSPykGzvPZF--
