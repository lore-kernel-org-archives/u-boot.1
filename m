Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1DC3601C
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABDD81703;
	Wed,  2 Apr 2025 17:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e9BLfhJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737C881CF0; Wed,  2 Apr 2025 17:00:32 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7736580194
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso2109352b6e.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743606028; x=1744210828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=57xqWlAKbqbJbMfpyddBS8Q2PzNURMTKJhApBzMZB0c=;
 b=e9BLfhJdXu/BDU3juPIS2xrtR05xiNHgPC3vA20nW5RLKd0M1A9kPT7RMgyNI69Ekh
 4eQT5oZHTwvpYRj+czVqdPIK3JdUTx0C07ouUsOdYVqQsScdY6QO12WUmm8LoaNnWcFJ
 mm3uUJNugQ+uWYxwV6Fr1/nHa7NfxMipC0lJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743606028; x=1744210828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57xqWlAKbqbJbMfpyddBS8Q2PzNURMTKJhApBzMZB0c=;
 b=iWqfFbGI+MvgLV6RJU9ndv46iLTtelyHFwHNLkGUuq58v05d4ONlDgX/paWOuzS+v+
 gSeSaWAQKq2SdjteEyvBJkD1Z3xJrTqTe9mSS9g4KvoefkaA6F+wiCrJYs7uNMt8Bfxg
 AKqQVC3buXgeJuleS50sWbldPkkIahCfhATN2L50Dj0nB7eXQf9dJLkU2CK95fzgkcJy
 gWFdyRbNcT451o21M6PYlRU4Qcd9FijDSSwN3omBi8Qm4/hEXoNW5/i6rTgeg9fNChbn
 cwWBVjRGLfv7imQntQ8uy+0o3994fNLsgD9MW0rRfAzfwdPKNllsWfZ1y0k2V0R5m7eO
 bmGg==
X-Gm-Message-State: AOJu0Yw/YqtxGAIe4ETAPUDl8iJBFXfaTZAHoKR/4G9kcWo8zPRjJwZ+
 qY5xB6c3bRBykHXMo369hpXXFWXrJi7KalLZfiRHQWQu9/EekSxQmVnxZPjJ0T0=
X-Gm-Gg: ASbGncsE9ifOl0Tjd503y2UOvs0b0z1eZr9oLBInK7iLdztvvOZYW27epBMUtH4Lqeg
 Z91rGOcT6yf4qmcTHFzGjzyFln7Gl6NRg1UD/aS1RVmEmqdXgGvSGoKx7w99mlozhv2e1qMBIPs
 Pi5tN7tvU6xhmZgfwWjkNwM/0wa2rbbtIFC/DbxBmtlPz21VsPGjrRO8iej84CS79UZjSqeY5iX
 F+TrPBRl2vYs3Xp5D4Nh7OGY0Tz/itmdyK21VXfZxHy8I8gNqXnTegAJaRVtaeqFWXK+fBRO9uY
 4THRuEqYD8ujr2zq9J3Pvd37YwH090Ij8Ie1ODQ/3HNxOeYrcsJkwpeHt7HQlybsy1sHOhJ392V
 owZDMEElkxybxwrRG
X-Google-Smtp-Source: AGHT+IEyFsvy2HmfX2W21ulzNhkO2QOWuoYZcK3eGkI68Nj1OPCpSrytywER6G8AabZKkqdEA3uA8Q==
X-Received: by 2002:a05:6808:228b:b0:3f4:222f:da5e with SMTP id
 5614622812f47-4003621b654mr1544396b6e.23.1743606028016; 
 Wed, 02 Apr 2025 08:00:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05166b15sm2373282b6e.4.2025.04.02.08.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:00:27 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:00:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250402150024.GU5495@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5TJAS2BwlvpTGL+T"
Content-Disposition: inline
In-Reply-To: <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
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


--5TJAS2BwlvpTGL+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> >
> > > This series includes some precursor patches needed for forthcoming ex=
po
> > > enhancements.
> > >
> > > - truetype support for multiple lines
> > > - make white-on-black a runtime option
> > > - support drawing a rectangle
> > >
> > > This series was split out from schd2
> > [snip]
> > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > branch: schg
> >
> > I get as far as patch 4 before it doesn't apply to -next.
>=20
> Your tree is missing the video-damage series which adds some more
> tests. It is here if you want to pick it up:
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D369663&state=3D*
>=20
> I can rebase and send a PR if you prefer.

Reading the cover letter again, that doesn't seem ready to merge either.

--=20
Tom

--5TJAS2BwlvpTGL+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftUQAACgkQFHw5/5Y0
tywrwQwAh1Tp20Eu6begN0uS2dluuuP6TH3AF0Vb7+fDKo+/b5al1UjApZoJqgs/
+2o7U8bFPQ5ZpYlSqKojw+qIH+S6dqOZp109Zx3jf0lrRW/ebLQNGiR/MkwW5T49
U2Xe1I+y5mmwBI11ltUw5eO6UhwCvdHd5Qssu+XTCVUsU8B4tfqGLeuR5HgJ9YVs
m9Nt7ee7aRQkVACP9S2eXcBikvUwNfm36bQs9BBT47uIw0FkHHEgN6NUQgBwlebp
5wPqGSQjKfhoWIhWIcBpfQGl/V73NUU0jvV4Dq8FFGKe8sf/KKp8+3JsYLPsMh9v
UMG782DESmykiuT3yGgF/cO2ZzDC1VU/l6hML1VkbqU4JH0cbIDcQBMwiDWy6ySD
QTygqFlKMAlMg9Qmf9JaF0bjO425/5hmP8Nevvu6Vx0DCgho9GEef71/6ZzgAPP5
r0oP+NHNKxpC389FE0O2xeeDj7GaueQflsCGcosJ7QzLNTnmztUDuBv8qsGV3jbg
c+KTQ3cO
=CaKa
-----END PGP SIGNATURE-----

--5TJAS2BwlvpTGL+T--
