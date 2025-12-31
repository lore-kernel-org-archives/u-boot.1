Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB5BEE6457
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 16:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27508840D4;
	Wed, 31 Dec 2025 17:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGNI3ix0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDAB840CF; Wed, 31 Dec 2025 17:11:27 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E6D840CB
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45358572a11so5981557b6e.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767197483; x=1767802283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tlEnJ486HQRQdZUN7GUmNLoKLz7s7/s97aOsLr7ZMGc=;
 b=SGNI3ix0L2PXDpFP3QzqdM5BNJ48NGcgpMWA5S724VvrIlW9nZHa3drRaVoR4QMqsH
 lMw31Ma16/PpTtO0m/sUMm0/GRyn4BrOOYP26xTgBYpH7a2kBhPp7c1cUQ9nbHGPiZap
 YZeAuqExc3A49+89IR9guJVM9I73aiysUEkGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767197483; x=1767802283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlEnJ486HQRQdZUN7GUmNLoKLz7s7/s97aOsLr7ZMGc=;
 b=rNqEPW+muJe+F1cwamgB0OOkf4CaGgkC5bE5twprDB8UpSWYZL5+hLuw0+MjTBXNTt
 +YwTg7ccqazh0hHWIrZ2sahltyGi+dSSf0jD94ied/qLlVIYmLJBpNwOc1V1up3R82aT
 VgI9mMRcBRK6VPMgoS92f8ioTCDuCzkC7ttq/Uo8cGGzo38zAjq180IhJ+JpXc6tZzdl
 Dnxbl/S5Hf6wpAV/ARW1kjf51YjDCbN6Dt8kLXXwBLdH7Tcwxf0kSz+XUIKzAmH0YaTX
 aCke7yKDf3Rhu2i4rNVU1pPDSCvOcqI0uUom/EtwvWb8SEad+kPv9MZYmIuNq7CUvDSd
 XHMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Bm/GzXIeUOCp0AS/d7Uunj1e1cx1skj4U6MzySeXhfiBZS2at2mLP3B8bXw+dzdFqk7sRkI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtk90euScJ6IfpMkO02DAsPg5dppqODXEKcsj/Hig4kSBcToGL
 zBuH6B0Tjf5FFNiaficS6e0iKgd8LAzo3X0KYr2I6QLN/JNHxTSCxhj4suXykmchoTtp/vxoJvH
 fAlKiCZw=
X-Gm-Gg: AY/fxX4phdk6d855UU+Z26xY5zCtx+T61BRc7oZViOvkRW6AqbAGtMYcdMPuIpPnO8U
 7TurCp9k0TRDuk425PNYvZ2tXHh51L4xGOKZ+8FoXKg7iZnhSXUm1Qzi+G62P2PQtkUhABtVqHb
 /qN6RmAm7D3hWM/JbMktHvRI+UCBbV4FcG1qCguPb5VZfRVomw8AwkfBeA/geDwm9mEha97wSOo
 fYTi4UFYGz9oheBdIZBvP9hFayaB8/zdo+B3Zp6iSdjwGihCQla0w+fCEYeWx8zI4gbyMklXce4
 dSwSewHsmR2udWs9IadkubgHeAvMwakICMYkdFOj9udtADC3iR1i/EfiK0Zs415Y86/vWv8C858
 pKtd69eYLcBESGeajS7DBeM4q84tFnRyuP5m769ph7GFRPxVyZ0EWIUjxG64yVe5v4qVElXH/AP
 7HsFClxF12Gsnedj3J6rjbgwi49Af7PySx4q1igbrdZFmoSPTtX/eshE+wCl8/vX6sE02wCK0Eo
 oiELF+bKdwSnwMMOedBnxusU7G2NmS72DRcHF8N6jtDf9X3Ag==
X-Google-Smtp-Source: AGHT+IEyo0CBNaznA8clL9SAcaX9Bgi221rNz4hV8m/HDJZCgZS8s0F/Bt5hi0AjqDngg7tm9FOXcQ==
X-Received: by 2002:a05:6808:3085:b0:450:c63e:440 with SMTP id
 5614622812f47-457b2047bc9mr15105494b6e.66.1767197483176; 
 Wed, 31 Dec 2025 08:11:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be2223sm17331290b6e.8.2025.12.31.08.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:11:22 -0800 (PST)
Date: Wed, 31 Dec 2025 10:11:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in
 SPI NOR
Message-ID: <20251231161120.GB710860@bill-the-cat>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
 <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
 <20251223233205.GG847766@bill-the-cat>
 <56df64f1-f3f8-4fb8-b85b-e1b1e30f5f49@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N2CPZRE6jcXFaXki"
Content-Disposition: inline
In-Reply-To: <56df64f1-f3f8-4fb8-b85b-e1b1e30f5f49@mailbox.org>
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


--N2CPZRE6jcXFaXki
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 05:07:31PM +0100, Marek Vasut wrote:
> On 12/24/25 12:32 AM, Tom Rini wrote:
> > On Tue, Dec 23, 2025 at 07:55:45PM +0100, Marek Vasut wrote:
> > > On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
> > > > On 12/23/25 15:31, Marek Vasut wrote:
> > > > > Add test for environment stored in SPI NOR. The test works in a v=
ery
> > > > > similar way to the current test for environment stored in ext4 FS,
> > > > > except it generates spi.bin file backing the SPI NOR.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > ---
> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > Cc: u-boot@lists.denx.de
> > > > > ---
> > > > > V2: No change
> > > > > ---
> > > > >  =A0 test/py/tests/test_env.py | 99 +++++++++++++++++++++++++++++=
++++++++++
> > > > >  =A0 1 file changed, 99 insertions(+)
> > > > >=20
> > > > > diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> > > > > index 383e26c03b0..48e31f19b3c 100644
> > > > > --- a/test/py/tests/test_env.py
> > > > > +++ b/test/py/tests/test_env.py
> > > > > @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
> > > > >  =A0=A0=A0=A0=A0 utils.run_and_log(c, ['cp',=A0 '-f', persistent,=
 fs_img])
> > > > >  =A0=A0=A0=A0=A0 return fs_img
> > > > > +def mk_env_spi_flash(state_test_env):
> > > >=20
> > > > Thank you for adding the test.
> > > >=20
> > > > Unfortunately pylint doesn't like your code. Please have a look.
> > >=20
> > > Is this something we run in CI ? If so, CI builds did pass.
> > >=20
> > > If not, how do I trigger this ?
> >=20
> > We only run pylint_err not pylint in CI. The "make pylint" target has
> > been unused for so long that the baseline itself is out of date. I don't
> > object to trying to improve our python code to match standard practices
> > better, but this isn't the place to start adding complaints.
> >=20
> > All that said, a newline before a new function is just a normal good
> > practice and so at least the quoted here example should be fixed, just
> > like if it was in C :)
> There is a newline before the function, the code is incorrectly quoted in
> this discussion, see e.g. patchwork for the actual content of this patch:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20251223143130.16266-1-m=
arek.vasut+renesas@mailbox.org/
>=20
> So, what exactly should be fixed in this patch ?

Thanks for explaining. The only problem I have now is you didn't give a
cover letter explaining the feature and so I need to come up with
something when merging the series as a merge commit. I can do that, it's
just easier when I don't have to.

--=20
Tom

--N2CPZRE6jcXFaXki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVVLKAAKCRAr4qD1Cr/k
CsHSAP4+xBAsXIDF4BZiixp7jif05KVfUIQ0Fqs6x+tcol1lywEAnjRLGkSQeolu
8KJuE47wo5Qo08ZHo7Yfucvl+Uu0mAo=
=8oeq
-----END PGP SIGNATURE-----

--N2CPZRE6jcXFaXki--
