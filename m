Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CDC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A976A870EE;
	Mon,  6 Nov 2023 17:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gaU76DOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C10870EE; Mon,  6 Nov 2023 17:33:14 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EA186FE8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7789cb322deso303581885a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288391; x=1699893191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WncudxI1APxATbXmTlC8+uIPuFlO0Qyq2mWG+RwcnL0=;
 b=gaU76DOs+TzlqejUAv14Wjjo6ekEJihDwaWOSZwa5fXXxXadHHQwCefyZD3U7tfaKr
 709qYckz3A7m5iC0PuF+hswt7m7gUO/a31Rhk5B+nkKs8nozJ2+3LmGMV7VltEwECaoa
 XtQQzRbYe8uh5UyfILjoXqkRb8htF+Pq/sSPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288391; x=1699893191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WncudxI1APxATbXmTlC8+uIPuFlO0Qyq2mWG+RwcnL0=;
 b=uTLhlqye2rcActPHvXapqkXcVFhymd/z6pScAcuBFOAvOMD/4V4GV79NR5d33ldcxM
 xoi1JDIa6el2XnBFkK4TI6Rg7OiT+7QtUITQqGncx7mqIZrqQkh9XbL+o9n66lrVLFsM
 EDYSZEY1EiKVS129ZszqcanEB8j0IgiovrbvJ0s/k2Qi6+hlBsmwW1XhBpKmTbvE3fZH
 HwoS7VfNtgXmyHmLmfoEJbKIj7fSf4I/qiLfbM0B7MxJ7mm5zpDFvIpoT8AkP3s3+Z4m
 qqtYaHHhJWMga58Q8s3FG7c4uJNkqujbGdF1RyIMcdbisJ2Re0LROEKu6O+eqiVdxtM+
 zifg==
X-Gm-Message-State: AOJu0YxU0vLcDxYNfALQSjQ1pw4V2FOgTssZB48aoyUoDFApqlx4fmmf
 oWTppsnaHiQ9+fTeIGSOeWf6Xg==
X-Google-Smtp-Source: AGHT+IH1q4qGxfBwaAM7qNWAAJEb0mcOS2ZXtqXXMcBHpslKPFprLI6cF3lIfmNqqtzkwbaPZe/Jpg==
X-Received: by 2002:a05:620a:198f:b0:779:d4ef:5f1f with SMTP id
 bm15-20020a05620a198f00b00779d4ef5f1fmr34575958qkb.29.1699288390799; 
 Mon, 06 Nov 2023 08:33:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 x12-20020ae9e90c000000b007756c0853a5sm3423719qkf.58.2023.11.06.08.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:10 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de,
 tharvey@gateworks.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH 2/2] net: mv88e6xxx: add Clause 45 support
Message-ID: <20231106163308.GR496310@bill-the-cat>
References: <20230808160549.1464982-1-robert.marko@sartura.hr>
 <20230808160549.1464982-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AJNxB0O7qUp1yrHG"
Content-Disposition: inline
In-Reply-To: <20230808160549.1464982-2-robert.marko@sartura.hr>
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


--AJNxB0O7qUp1yrHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 06:05:16PM +0200, Robert Marko wrote:

> Marvell LinkStreet switches support Clause 45 MDIO on the internal bus.
>=20
> C45 read or writes require the register address to be written first to
> the SMI PHY Data register, and then a special C45 Write Address Register
> OP is used on the SMI PHY Register before making a C45 Read Data Register
> OP and being able to actually read the register.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied to u-boot/master, thanks!

--=20
Tom

--AJNxB0O7qUp1yrHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFUQACgkQFHw5/5Y0
tywuJwv+JLN73BD7Tsh8XiTqLsW9Mi1gM/fn3KWvwZNIy/fBA1dl5GcXxKAso1pe
DBHCT/ZSRGPLS+KQ72RPV7Nj6s1UPW+hG6bHexGb6vQ6c1q9nD+ej7FKyjs+hMpK
C95ApphSaTR7+KqgMoKftiyvwMH9Uc9l/k+eBuB2CC1kiNDRbg+dYl6sXbuvJGqt
SlPsduP0HZS9afvfZ+Sm0zImHFkTrY4J08dwCP3s/0K5Ys7OxvWjlHnb2OwtgZfc
tLFIH4hh+PyJ+Loe8+Y3skoad4yZWkOeWDoBHReLAGtX0KJ2p55sIrFBXJNaUT9z
yOoAUhYiXrLxHnHcCOmKOU9j27Z42aNTzlBKI0+9VdNAPuPYMFAT/APWoSmsPoRo
bal8Md0RpfO5JDeoyBKeZe082FUYCL2vxhwow+3K0aT1BBTf75QtQPNxiMRCZcUA
ceXR48BcXh+6UKmffgGdBy5vodnxo30CByAE/+ONiAs7+dwuX+AfD251Kbhnt7MH
5SfvqCDU
=nAlG
-----END PGP SIGNATURE-----

--AJNxB0O7qUp1yrHG--
