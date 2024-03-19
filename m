Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF03CC54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 19:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27A288047;
	Tue, 19 Mar 2024 20:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dpqK3+dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F6488047; Tue, 19 Mar 2024 20:05:06 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA1E88089
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 20:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-609ff069a40so69889317b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710875099; x=1711479899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bQbuuP5ckdgipUzc0OqTPKyotWTCYSqRxfNyWP6Ef6k=;
 b=dpqK3+dz2K5INuX630+dzTfKkgchH3afxiIBgJNuBI9nrxXRAqfLaIO+FTrnF2NB6e
 Jc0hKUzisviujr7Dd0kB8wtR2Kn8lLk2TD+3lDHquf4ft+ANocFZ3g33EGRFVZlR70fJ
 506GAoI7Aff5v9rzeMWuBwbkcTUq8Pod/c5C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875099; x=1711479899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQbuuP5ckdgipUzc0OqTPKyotWTCYSqRxfNyWP6Ef6k=;
 b=alr7o20nw0V/A95sInIXZbdRBN2+b4qe8Lt5XRepHm6TcZyh8bMO003wI/+e9XWDGQ
 3EhvdETMLPDOds/9gVudScG/bZk3mGleDAi3BDYEIU6XczcpMI8zV2pzyPNuXyzf0ByQ
 PsfE3k0NZE+JDfcek+JapQTQGss/y7k0vqOq2NIfwE0qLvOILiBOX5F8HB0yf1Hd4MZC
 AoHlIsIqDGVs/0nEegvhfqqikRYQPY07kdAHl35JdFUpn7rPzoy+TUkilE2J0kGAqW8q
 bkBpb6UQRnfllU+r7bKAymGCQH7QKQhHyHa+mWXPPPw9yx2Mxetb1ZH/s/3eX6V3UUmH
 WcIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZHXpyLjxZi1B9VEfXgLjIQ3kMurpGzmXeAqjU20bLFRpjf4ppKDx8egUJKrwOLTsQVcNSmLdcVAgBzYDgJwGBtdNnaQ==
X-Gm-Message-State: AOJu0Yw2ZR1x2tEkhYXoSprK/8t32XqIQsIV8ATc8CXCAxYXpQ66IDDk
 W1EXCPfkLvGbBmZuIyqyga/++Sl87+JlJeKz030fqh/jmUEG93Rnc0tQEA6mlW8=
X-Google-Smtp-Source: AGHT+IHaurEsoAzMii3Fk3nM30HYji0O2lNF328ZGK5BeoxebPkS3v/aVqmV6DYSCJvBl36tfsBQoQ==
X-Received: by 2002:a0d:d302:0:b0:60a:48ea:2269 with SMTP id
 v2-20020a0dd302000000b0060a48ea2269mr15758781ywd.9.1710875098680; 
 Tue, 19 Mar 2024 12:04:58 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 q187-20020a8199c4000000b0060a0a571e47sm2486430ywg.104.2024.03.19.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:04:58 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:04:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 800MHz
Message-ID: <20240319190456.GJ3442575@bill-the-cat>
References: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
 <20240319150531.GA17472@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WP8syG5U8KOriGaj"
Content-Disposition: inline
In-Reply-To: <20240319150531.GA17472@francesco-nb>
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


--WP8syG5U8KOriGaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:05:31PM +0100, Francesco Dolcini wrote:
> Hello Tom,
>=20
> On Tue, Mar 19, 2024 at 11:04:27AM -0300, Joao Paulo Goncalves wrote:
> > From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> >=20
> > The lowest speed grade of Toradex AM62 SoMs is K speed, resulting in a
> > max value of 800MHz for the CPU operating frequency. A solution with
> > runtime selection of the CPU frequency is already planned to avoid these
> > kinds of problems in the future.
> >=20
> > Fixes: 8fb8a6d49977 ("arm: dts: k3-am625-verdin-r5:Change CPU
> > frequency to 1000MHz")
> > Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> We have a patch ready to make the frequency adjusted at runtime that
> should be on the mailing list in a day or so, as suggested by Vignesh,
> targetting uboot-next, this one fix should go into master however.

OK, noted, thanks.

--=20
Tom

--WP8syG5U8KOriGaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX54dcACgkQFHw5/5Y0
tyzUnQwAicaKPsj5z2IUVW6aA0zyYN4ZfWBwa4ToWfHn33QGowcBRJL6OIgjfhx3
ZjpReW0kNAW7FSy8SK1nWjlic4G91rQDDaWppnFvGNBRASFoqd1MDskb9jjD5ZS/
y0peetmcBPRsyEBmh9U3cCUj5ik0z2wMdZVgKiCmdNbb9lSLhOLAgn4fUkqGdtUL
sKdVtCG8nb0Sh0/eBQI4MObJ1G2D62WNHH1/9PZ4OtRwrvRIuW4qqIQ+IvjkAkum
YpxhF7XEw2oFaZi59HM2RQlo3gft0juUVLBfxL9Uay2jf2fvoGTldrb1lT0w9ZNs
7bIPVIkhOjKAG0tcw6kwvGDNT5FWQtOHUzUwQ1KsuVGTaWX3Cyf0TGYLQDHdhDvf
Z0e63/s8j04gmxIjj2RhhTZ9WIy70lpU9XlbN9mBFwqI6Nq/AdyyHGpiFFMsZey9
hvG7cnm/Q9pbJxvovIEUy78UATak2HIhd+9JNzO2TgKPykuxn4C36RZN7FjhwRI9
AG+2kxBH
=9WL1
-----END PGP SIGNATURE-----

--WP8syG5U8KOriGaj--
