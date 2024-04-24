Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED18CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E95886FA;
	Wed, 24 Apr 2024 16:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YM2Z0ChL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBA788817; Wed, 24 Apr 2024 16:56:03 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAA78869C
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-437a660c94fso42444031cf.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713970555; x=1714575355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g8W4GZC4nqVN3fr8al+a7KI8QYLjfHP1kE67ajy56ZA=;
 b=YM2Z0ChL/9F3PHD6EhVGgIoRwJI5nIAiKbefprGcMsRb6HR0Ib2n48BEK+vu6+oYsH
 AXSkSLVNA/FvowfqgGuyxHsMmutxSXcTZggKYxYmyPX3hIWhHEuAFiv/GLR4EuGTRLFF
 vfsvUUr8gBj76xr5HkJpPcYx2HU4btQXMQ91M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713970555; x=1714575355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8W4GZC4nqVN3fr8al+a7KI8QYLjfHP1kE67ajy56ZA=;
 b=X1iuotVPtjZ6fABObR0V+8tJm2rafwDJR2XCvA6JLc33gMLxEtMgom+9hX7/bYK4Lq
 ry1IeJ+GtyoXBe5/CxEnnYOxZKn+k7l/msnsM+EDhH6TNRhxxK3/8ellRDaAYpRVizag
 d5poidXQMJo9Uwc6yhXo+Tv+sL6by+Z4GcQMithxI9e2YtP+GgDDtra59wNZUFOkOaSf
 tSSLI9kD9AeBzTUn3jmWLn2wrFTbKRuPwDtwAP4G4uCBdrF8XOg3HFt4JQ3tfKiAs0gD
 +fElV14MBXVQ8dCs3VhbaYHAd5hRelms06iFc8WCo8XqXMX8QVxdIP/h2kZRVjXnZ5Kb
 YfrQ==
X-Gm-Message-State: AOJu0YwcpREpMUupBxEUN8O2ozpoRA3dEVblYcL+PcGIF5AFeCbVU3EF
 HSgkG8Oi5bs+sDbV+fXWz81WXalq3ZU0Jd8C9Ek2ma6TY3QnF84mjJ8i1+hynl4=
X-Google-Smtp-Source: AGHT+IGBM3IWlf4bllKUEAjkgOJM6kxxQxW4fAULfBpVLt4fTwB7dzm9BjIocQlEL3FyV+rQpullRw==
X-Received: by 2002:a05:622a:1116:b0:437:bae4:4004 with SMTP id
 e22-20020a05622a111600b00437bae44004mr2888185qty.9.1713970555258; 
 Wed, 24 Apr 2024 07:55:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 b26-20020ac844da000000b00436434cc3e4sm6131718qto.89.2024.04.24.07.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 07:55:54 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:55:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH 1/4] arm: davinci: Migrate da850-evm to OF_UPSTREAM
Message-ID: <20240424145551.GD1054907@bill-the-cat>
References: <20240404030031.4726-1-aford173@gmail.com>
 <20240412000539.GM2493117@bill-the-cat>
 <CAHCN7xJRkUYCQkF9Lvm1PcpcoTjcqJy9fZAfcP=2ebRJsc2E9g@mail.gmail.com>
 <CAHCN7xLdDeiEaX2AKPk5_zT7PSYk3+eTNNZND1QS5n7U+FJCZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7zO/w2d9R/1FKRo3"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLdDeiEaX2AKPk5_zT7PSYk3+eTNNZND1QS5n7U+FJCZA@mail.gmail.com>
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


--7zO/w2d9R/1FKRo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 09:33:25AM -0500, Adam Ford wrote:
> On Tue, Apr 16, 2024 at 6:53=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > On Thu, Apr 11, 2024 at 7:05=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Wed, Apr 03, 2024 at 10:00:09PM -0500, Adam Ford wrote:
> > >
> > > > The da850-evm can remove the U-Boot device trees if migrated
> > > > to OF_UPSTREAM.  This means pointing the device trees to the
> > > > ti/davinci directory.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > This series leads to failure to build for omapl138_lcdk and lego_ev3 =
or
> > > was I supposed to bring in something else first? Thanks.
> >
> > I just got back from 10 days in Europe for the Embedded World
> > Conference.  It should have been based on [1], but I haven't checked
> > to see if it was applied.  I (maybe wrongly) assumed [1] would have
> > been applied before this patch was.
> >
> > Once I get caught up, I'll look to see what's going one.
> >
>=20
> Tom -
>=20
> Can you point me to a failing log for this, so I can try to replicate it?

Applying the series to top of tree and trying to build omapl138_lcdk
results in:
       arm:  +   omapl138_lcdk
+(omapl138_lcdk) make[3]: *** No rule to make target 'arch/arm/dts/da850-ev=
m.dtb', needed by 'dtbs'.  Stop.
+(omapl138_lcdk) make[2]: *** [dts/Makefile:54: arch-dtbs] Error 2
+(omapl138_lcdk) make[1]: *** [Makefile:1166: dts/dt.dtb] Error 2
+(omapl138_lcdk) make: *** [Makefile:177: sub-make] Error 2

For me right now.

--=20
Tom

--7zO/w2d9R/1FKRo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYpHW0ACgkQFHw5/5Y0
tyzp9Qv/U8RDtvOcmYGIEz0s+N/tu1cjmgqJbmj4Png2s2CdA6sfWq0Bmr/7Pgxz
T9uDQ8RYTVrIiZrvQHVrLDH0GqWSaYNQRAaMKCVDvGGZooWzRrJtrjf69lZJJrAE
QceKDwMbEGwWXoy6h6aSn6TTA2+9gLP3US/K59XsLu4JBPI7XTs32LuIOmUGx6CK
eJmHmEfT75idNv2NbwNfYKLj3zBkTUjeyr6U5UdKvmla7MYUoHOvpFsoYM+3Lxat
ApnbY1xqJMBzgNPCzTAvlSUI4VeABZze6zoZcM+uv2UrNI4Gs1DfWrFAeg99bmTZ
f33OxajQ8On5XiaT3W4j96yiDPwck1FCtWVJnJB49b2tBVe669Fk4te4+EhBYV08
M/4pmXphdRsXO1oGegaAU5EukhYRjxW1kDngsMDjvw5oJp5fE+8GPO70Kuznr3kQ
2E8fUNsoaACN4bl9Uf1hC7E9EOi9Tegj4avTvpu+ijEtRQq7HunuEQ7a19QX18c/
sjd+3CIi
=tvSD
-----END PGP SIGNATURE-----

--7zO/w2d9R/1FKRo3--
