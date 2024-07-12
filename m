Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A39C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F88887EB;
	Fri, 12 Jul 2024 18:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JcgOyBGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA9088791; Fri, 12 Jul 2024 18:54:49 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68E788829
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-708b273b437so999160a34.0
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720803286; x=1721408086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6SOCTIXgAXc7PTlCW37cTH2NrZqJkCs+ltF6m4tIoIU=;
 b=JcgOyBGYgGwmbQ25gCnSeEnuthgPavqz6TorO3bor7yAZgfhrCFwqB1mU6bJgWVxZa
 z25p7BNPa5v3G7jZG3Kk7PeLbrqj7mpJI9HpNJobO0hZI03CUWdFFoVpRc6utzHHcOq/
 uLKejO4G4gA+wtk/tVLokcBcPIro4Bq6owkRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720803286; x=1721408086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SOCTIXgAXc7PTlCW37cTH2NrZqJkCs+ltF6m4tIoIU=;
 b=NobFydRJYwY7EZQgGl6G/sQeH+UUOwMqd8jHUTJl2dGONl4y1e5fONSD/SCuPjf4EQ
 N7cLhaHIVMLnHFoI46fQDx6Q2xWc2QfHwt6klHddY9YoR8qr9E3vYG/utziqXjRNZQTP
 leQWU0Kup+UkQYH+tBFcS/fPkAq45zPLRAYKWcAE8+TdyKb21W+2b3x9IROCti7mhyIE
 GYO53aCCYN/9WOoSCL9qHJjfynQQc/3eCmTCdNeQBuNscyABnu2SEbCmRXVApWRZDzd8
 8Bu2T+PbvOGK1cw67a11I1u/+XGDCgvKdu093Q0WkfDp9ZqQs8/0OjC09S3qwBbVtPRA
 Saxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuY5iXMQveUAazZJchZBSUOt9lmfEepLl6uX04J5Kop2BJQ7P6tk5T8uH42TSo08N69toPU+eUVd8mj8BV/6+9OxDQIg==
X-Gm-Message-State: AOJu0YxXgPlPultjpGE7KrlmnaDrqNhM63+Po/tZPN5OT3Ja/ujJEBMR
 BGGQ/UxVOHDVSuVXqN4S8AuDcQnRTYVbBGlG8AtnyvO8hGuCaFJ65wvly0BNRd4=
X-Google-Smtp-Source: AGHT+IElo9dTlmnnx3cgk3irzpKSMsAdZqr9VKSXVJ1VpY5/DLLSnddhXfzqx5aiMFheN9JH3oVSgQ==
X-Received: by 2002:a05:6870:e0cc:b0:254:a7ef:b714 with SMTP id
 586e51a60fabf-25eaec95a90mr9621377fac.58.1720803286416; 
 Fri, 12 Jul 2024 09:54:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9fe9fb9sm2270586fac.14.2024.07.12.09.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:54:46 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:54:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Jixiong.Hu@mediatek.com,
 sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de,
 upstream@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] ext4: Fix integer overflow in ext4fs_read_symlink()
Message-ID: <20240712165443.GY38804@bill-the-cat>
References: <20240702194223.31998-1-richard@nod.at>
 <3244366.vfdyTQepKt@somecomputer>
 <59ebc379-66f7-493a-b024-fcc3224b320c@gmx.de>
 <3325697.VqM8IeB0Os@somecomputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fykEE2gMm4xgmyPd"
Content-Disposition: inline
In-Reply-To: <3325697.VqM8IeB0Os@somecomputer>
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


--fykEE2gMm4xgmyPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 01:26:35PM +0200, Richard Weinberger wrote:
> Am Freitag, 12. Juli 2024, 13:19:32 CEST schrieb Heinrich Schuchardt:
> > > Hm, I see man built-ins in the U-Boot source.
> > > Why is this one special?
> >=20
> > See the definition of COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW in
> > include/linux/compiler-clang.h.
>=20
> So I can't use __builtin_add_overflow() because
> u-boot is still supporting outdated compilers that don't offer __builtin_=
add_overflow()?
>=20
> Maybe this is the ideal moment to raise the bar?
> __builtin_add_overflow() is supported by gcc >=3D 5.1 and clang >=3D 8.

We already fail on gcc older than 6, for ARM. And we don't have a
minimum clang specifically, but it's probably newer than 8. So this
should be fine.

--=20
Tom

--fykEE2gMm4xgmyPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRX9MACgkQFHw5/5Y0
tywbUQv/TYCtJd5Kz1MPErgUFBVJUvIU6L6HB+pEn2C3mb2x2Yzd7HPj3juLE6R7
5tDUNndwUtQtB94XOSpbCvQG8P8pJN/CZEyjEkh153L8dAQ7PYCDDMg7dT2O7mxF
ls3f9T/c4nlJecs5mehsto6Q4m8foPu+vZuvXTnqF3O9gmAa1skEhePP9keMumX6
sOqybQBqJKRC4q1fgJJSrNW9N8zqCmBmXhc8H/sKd0wzmTNGesrhrgX4dpg62qLf
1Z98D62K0oRwHvcDVxf2mPfB9t4xTBMlbZ7JEfH+jgTZjeiFlkzDFlV9rmClUAoN
FDvrSv90l3q72wLjiptAL2H0h5rpULbBKfmH9tRC326sbPrGjVHrQsVHj+oXkyx6
8i6v+lNM9507lRghM8eqsSWPZfbwrKDJfyynuOq4kGwGQFLKKv//vnCIQgttk80s
3vGRDRdyskGm/OmjfZ6k3bAopcqBwXxhy3x5/dOD+UzNMjFPjzvk258pKIjDB1h3
OPJtWr2W
=hLYY
-----END PGP SIGNATURE-----

--fykEE2gMm4xgmyPd--
