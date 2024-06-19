Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8E1C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 14:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C279D8840F;
	Wed, 19 Jun 2024 16:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r1ta5dQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641BE8842C; Wed, 19 Jun 2024 16:44:28 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DAA88363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25957dfd971so1757012fac.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718808264; x=1719413064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XBCWw01aQyPTCRhQq3RoPNvV78AXZVJcymeulGn6lCM=;
 b=r1ta5dQSEcMJHAJtdjevhbY5hWA/yt5KX9J7FvwSKdvwDq28en43m9zP37KnYR5hRe
 DIGdBUVxE+N/3INgBti/CZVWFt5PaaMzJxmtKo55P2/+dlVafoRCf1k7s8ZhxNgFxEr/
 DKoiSU4wgH2SaJulUvvLCpXfW8260W0VXzHqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718808264; x=1719413064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBCWw01aQyPTCRhQq3RoPNvV78AXZVJcymeulGn6lCM=;
 b=TkdjmcUChWIla54eJxBsk5DY3qb90suXpfKd6oWbBlK6/nBe31ZLaZmnHjxQgMn+0E
 tZ0ReP234m3kA7Od39srkjDWc2yCId0n8U34I3zky6QXDO8JUGZKBrFKSdNaDh/jn90/
 gqwQUq6VukxLDr3jtepfaosrk4Z88YgxyFZ8ogXLPWFerKtimZ747WpUgKabbx23H8iX
 gk9bbRJQlcFKeIWL4dANs087zbuZVjxm2XAEyLne1y+dxBYxFwN1pNp0Xr7fJwMwfWtd
 tiR7uzM8D4BCZs8cvnjkQ8Ii6QqQ5fuUGp8EQyN15EaYwYvY4wGGxO01H0tpgt2NLhok
 dzrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqHtoEqlNWA2zsKziXerJKUbO6HNqCwpbyPI6dCHPQZU5udkiEs1tAwU+LGmsP26YCFX2OIc2vmU/TH1KCjpfBjQv/8w==
X-Gm-Message-State: AOJu0YzzxxCxAxwyTIimA3q56mB00ZDnDWWqbUSDy9BdA7x3fjf0GItI
 84b7KmCTCcSyPK5Ew5Rkw9bsm+C0xwtlydHt/NxsOdKzmxy/E/3S79tg78CA+j0=
X-Google-Smtp-Source: AGHT+IHVAyD/y9BHbs4NY7+62e1Mz2/OGigj895qTruhHaWloMBBAXZqgae6JQmwPkJDuu6yF5pq+g==
X-Received: by 2002:a05:6870:e386:b0:254:b30a:2ed0 with SMTP id
 586e51a60fabf-25c94b1d2f1mr3232210fac.32.1718808264464; 
 Wed, 19 Jun 2024 07:44:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25bc44fb794sm594819fac.5.2024.06.19.07.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 07:44:23 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:44:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 0/9] misc: introduce STATUS LED activity function
Message-ID: <20240619144421.GX68077@bill-the-cat>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OYUg6m9/0AFSOv92"
Content-Disposition: inline
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
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


--OYUg6m9/0AFSOv92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 01:14:15AM +0200, Christian Marangi wrote:

> This series expand the STATUS LED framework with a new color
> and a big new feature. One thing that many device need is a way
> to communicate to the user that the device is actually doing
> something.
>=20
> This is especially useful for recovery steps where an
> user (for example) insert an USB drive, keep a button pressed
> and the device autorecover.
>=20
> There is currently no way to signal the user externally that
> the bootloader is processing/recoverying aside from setting
> a LED on.
>=20
> A solid LED on is not enough and won't actually signal any
> kind of progress.
> Solution is the good old blinking LED but uboot doesn't
> suggest (and support) interrupts and almost all the LED
> are usually GPIO LED that doesn't support HW blink.
>=20
> To fix this and handle the problem of device not supporting
> HW blink, expand the STATUS LED framework with new API.
>=20
> We introduce a new config LED_STATUS_ACTIVITY, that similar
> to the RED, GREEN and others, takes the LED ID set in
> the LED_STATUS config and is used as the global LED for activity
> operations.
>=20
> We add status_led_activity_start/stop() used to turn the
> activity LED on and register a cyclic to make it blink.
> LED will continue to blink until _stop() is called.
>=20
> Function that will start some kind of action will first call
> _start() and then at the end will call stop().
> If (on the broken implementation) a _start() is called before
> calling a _stop(), the Cyclic is first unregister and is
> registered again.
>=20
> Support for this is initially added to the tftp, mtd and ubi
> command.
>=20
> This also contains a big fixup for the gpio_led driver that
> currently deviates from the Documentation and make the
> coloured status led feature unusable.

A number of platforms now fail to build:
https://source.denx.de/u-boot/u-boot/-/jobs/854228#L1455
and please rebase on top of current next as well. To make world build
testing easier you may wish to read over
https://docs.u-boot.org/en/latest/develop/ci_testing.html but please
note that there are sometimes spurious failures due to the cyclic
framework and applying
https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-r=
asmus.villemoes@prevas.dk/
temporarily is likely the quickest path forward at this time.

--=20
Tom

--OYUg6m9/0AFSOv92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy7sEACgkQFHw5/5Y0
tyw/5gwAk+srX3342/c47mZsqlfekvJRk+YqMnslVrISDqcD9FuhXBf/oCLpXVXM
H7w3ZUTCDq25+6/gXlmwDtJVpMUuLkiNddsKj7/2cPWV9/Eg8Uyx6EMhOQoBg92j
wZI8ZL4eNnbwavCFv8ArpZr1ZyZ5msxu1r7uZNqnO7MrOk0nBE1Te85hXaQX5H4B
Nx02dOtQ7VAcLz7hGErc4xW6kTeXm0A1CKqESyV+RREigXxvigNYrHPQZVbpdVa1
1USjWXWOOz3/SfIlYzk0fmIzJH8teH5t3vIUmxUFa0eK7XxWS5O1qhPbAY7Mbbnn
8cw0KveGCaOv9FdAlcol3M8ftuxY9MLKeHr4foA2e16W1DyQFmpiw7iyKRYEXInJ
UtTjWAskn9gzTTWqDUdmaWBCsr+8KfMyoJbN1WVIitAmJs7Bi8wzRlkFEiFeJWnX
cPD7vyHGeJQwzw7M6Cp7rLpHusnqrMloIVDsvQd6dOxMQw4quNoJOVYX1CaKiO9Q
Rnl9CsXe
=Sa8n
-----END PGP SIGNATURE-----

--OYUg6m9/0AFSOv92--
