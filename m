Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D5DCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C63831B4;
	Wed, 27 Aug 2025 20:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A2rjsDlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C34F8831C2; Wed, 27 Aug 2025 20:31:01 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFDD83106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3158b868797so107063fac.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319458; x=1756924258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ok/bBPLCQQlwG0Zf5OiM/3WX3AuvAWqmTupCESc/IA=;
 b=A2rjsDlw3Muo6ZaLkBHT8bQzqRmly5H+1GKFCTT+6RvEytfuF3tPB5KOO7Wf6dpPi+
 k6hHYtkDyB9nzTgMCgTmYChagp2eAhMp6UbvgdOlhRqu0JKm7nbUMz+tUpuGmNVzKA07
 K5xzkPmhAALd962mhsQ/iBF2hO+d8wnchaayU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319458; x=1756924258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ok/bBPLCQQlwG0Zf5OiM/3WX3AuvAWqmTupCESc/IA=;
 b=IS3OOdrGU4cWIROX4+y+8rP/Or21F0nN80uktPv9JLtD0+QFunr0Cz1WXxZ1+Zg9De
 s50OzVFpVVJrwJnoV05y7J8LmQN1gLV3tz9D+R8qSfqMF31tXorlWaVbIpRUkKOdIvIK
 LgTPJqTtVN5Esr99rWHUwdjjOKIdJjm7ZmIj4Ik/C+K5XhzRAFzGDlBM8eilc3ug0sh9
 SpjH078X9SSE9MbLf/j9OvIXdtJILZbfqOaee2pRxmRVsV6a1edptEXyS5mnP1wPMAB3
 z352iQ7y/G7xdoi9Zx4Z1iwq48PLcoFlOyDlA9VoDY521b9lNQ0tSzFDy1q9aFkxTyMY
 oHKA==
X-Gm-Message-State: AOJu0YwlOyC9GbFarzMBGR7zyXC3DIoTHeOmB9FqtBA7g/FN5wK4aajB
 nriIzhMQaPWR3Zx5ILmY5aeZqFxkva9/lA8L3Tm8SqswkgGbZOKO2cM6dbfknRwqC+RPE8dxuiU
 bhBMiXUQ=
X-Gm-Gg: ASbGncsqNCUTYXbMsxvVOBcZLDtMhOjWOe+tqEMSzOKfkDX+5oGQAugr09uYMyiMuIH
 M6WqPh8ebkHEK8ozVP7sHd/rA1INip57O4N6Yqhhfhq7DqvDrshlMmIczbLkOW9owD5cXxnDqFd
 3q9G++FBGl6Qz//PhLicdgznttMZCgFvMG4qyYenDKq1wMeB6/12p7ovm3/MORuoOGhgSecIQej
 r90CzgAFlU4N7FP2QxccUqb7+lyndno1WYXBti30KaDa6GkW+xpdy6BX/CDk1FQsDvS81hR2DUz
 xc7LdJ3HOZeVP499NfIoXTXdWkAq+ptpzc5YKl7Gh4qVkm7qGq57L4vBcGhR2BT+0qiWx/lN2Zd
 iFDYUTTQzeMLUhoDvLlLgkhfRFeZlENT14uEwofHdKy9eM/7C/I8wXC7B
X-Google-Smtp-Source: AGHT+IGh7SNbuQ5PHvsGDx5FWpQPo77dD/kng8Bf4N8vz1BkInmTHmnyVFUDUwb+5h53LJCXQH3E7A==
X-Received: by 2002:a05:6870:cb94:b0:30b:85e1:d3ed with SMTP id
 586e51a60fabf-314dcee0ffamr10336352fac.39.1756319458325; 
 Wed, 27 Aug 2025 11:30:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e29b211sm3210263a34.21.2025.08.27.11.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:30:57 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:30:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: davinci: use mdelay() for multi-millisecond waits
Message-ID: <20250827183055.GL124814@bill-the-cat>
References: <20250827110846.39686-1-bhimeswararao.matsa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zxUutSsa3/x9IjgD"
Content-Disposition: inline
In-Reply-To: <20250827110846.39686-1-bhimeswararao.matsa@gmail.com>
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


--zxUutSsa3/x9IjgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 04:38:46PM +0530, Bhimeswararao Matsa wrote:

> Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> ---
>  drivers/i2c/davinci_i2c.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
> index 9bba0600e3e..ffd0dd0b282 100644
> --- a/drivers/i2c/davinci_i2c.c
> +++ b/drivers/i2c/davinci_i2c.c
> @@ -51,7 +51,7 @@ static int _wait_for_bus(struct i2c_regs *i2c_base)
>  		}
> =20
>  		REG(&(i2c_base->i2c_stat)) =3D stat;
> -		udelay(50000);
> +		mdelay(50);
>  	}
> =20
>  	REG(&(i2c_base->i2c_stat)) =3D 0xffff;

What is the reason for this change? mdelay(x) is just an inline udelay(x * =
1000)

--=20
Tom

--zxUutSsa3/x9IjgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK9O3wAKCRAr4qD1Cr/k
CrwxAQDOSTYIxXCBi0I3k+tiPZq4CBoozVU3EqANSH/ne0QjowEA0RwOEGBw4EcV
uk4NRmRWOJLbE7jQSFalf1NxfS3P5gQ=
=LpXa
-----END PGP SIGNATURE-----

--zxUutSsa3/x9IjgD--
