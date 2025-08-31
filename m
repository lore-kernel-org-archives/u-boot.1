Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A88CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 15:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A4383447;
	Sun, 31 Aug 2025 17:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWrFKRQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B8D838AA; Sun, 31 Aug 2025 17:35:20 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9096683321
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 17:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-315bab2917bso2318437fac.1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756654517; x=1757259317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jdxu8RxDWDwxta8guak3gbgc+2s5nzp5cGZ/kM4h5Og=;
 b=FWrFKRQMBX8IhAUyU5g2ldmavFEAGjrRcwf5/ORfSDDabaN14eVlYXIyCgPygnlNuP
 W3NDT3GcZxI8MViFJqVJg24+ohNzysBFo1esgeM20pIua+l8PGjHeEYnC9JGcVB/Tjkr
 cNac2PQ7nepIULzw9QX1WCCTCbJ2TSKGLk3Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756654517; x=1757259317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdxu8RxDWDwxta8guak3gbgc+2s5nzp5cGZ/kM4h5Og=;
 b=Wy8graz8N6JbW3/0UQfAbMUbJKroVNgau1RgHH16em//o+ie/1M2n4KipxAdrorLCJ
 YJhuG6zCF6vidYcUKbFz2ZYpx5bvx9OfgNJ3P/+T1wQqtRYvO7S3udq+NjsGDhdcDj6A
 61JF9KiEtQdTfjrUFSGEBPqjMsQpPSeqo5Oaa/Iud1m91FoTDXf57aBzsQqpqyGVic11
 ObOKfza9O54s/g8RhyK3I7mH8xU39H8NohMfKPjAvSG+houQU9BBpuc/WjOr1KcLR4YU
 V+B0GivB48oWdL8YGdlYfxvS7HSxbN944b22K9E74L1+XgO7AFQX4rLUusvFAu4ksGKh
 d42Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxUVmaeSQI2Io7wiGkSLqEwZ/mwgR5r+RpjuDuJykVGp2ja6HGv4w2/zg0zMSQr8ce+Fzhklo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6Hqtnv4rAf878IUQu6CCJRLARSp1YJP1pyoI6ZRqyahaZn7/z
 ta6cYigsTUsVcyAyy5zbLHpZbiDlINsrHYCF2Q0ggsvQJGxtXDfneZq7S7dZHbw+6/w=
X-Gm-Gg: ASbGncszPgXxoOOpdwg1MwRI3KKugmB+JCWZ2Z07WdVEbcvt6u4a0BgBKQhlS47AnoK
 CscX1Xqb3+otzi7tGrI8lljiMHxJIDVird7hyhvDZHGMz7WJRe8MlNepaS+SBe9rFRyOsg/G6gS
 gfJIN50cl6IomE8f5nByFyApgQmM1/BZi7ikzCyOib9LNgJNIo9EH4jlBCMa5/YgjUdIFZ3FAri
 LF83zWM6P0DHkPqIMvBGTt4pvGJ9JbDhbYvNgf+tPEsfaBmiA2n3+E7jaCXm6tL7lYcC2uc0QTf
 LhFLCpwjOZFjX+gbDixf8zFyuKe3F+5ylNFqUpPZtpxeJePaF+6aabovzzGiRPNLWWxreClpNW6
 wp4CINMDJn4AkwUEhYmpxJ2Ctwre93QS0uCxgHRvl4QF9Nv3/EIi5Z5rbQ3UpUdUxnAU=
X-Google-Smtp-Source: AGHT+IHQ+8/QVKi+UoZWx8IxnNnT+SWEnCZ/LRXomPWT9JdyqXPrR1LniPgT2hqMEbjKtYTXcEnNIQ==
X-Received: by 2002:a05:6808:344c:b0:437:e3b8:6364 with SMTP id
 5614622812f47-437f600bd41mr2486182b6e.2.1756654517202; 
 Sun, 31 Aug 2025 08:35:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437ffedd1c5sm451992b6e.11.2025.08.31.08.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 08:35:16 -0700 (PDT)
Date: Sun, 31 Aug 2025 09:35:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
Message-ID: <20250831153513.GA2800031@bill-the-cat>
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IkXUuAF/J/fVksFn"
Content-Disposition: inline
In-Reply-To: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
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


--IkXUuAF/J/fVksFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 12:31:50PM +0100, Andrew Goodbody wrote:

> The for loop in se_desc uses i as the loop index and also to cause the
> loop to end if the passed in name is not found. However i is not
> incremented which could cause the loop to continue indefinitely and
> access out of bounds memory.
> Add an increment of i to ensure that the loop terminates correctly in
> the case where name is not found.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/power/regulator/pfuze100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I size tested this as part of merging and saw unexpected shrinkage. In
turn, this got me to look harder at the code and I think the best answer
is to refactor things so that se_desc(...) follow the normal (linux
kernel) pattern of for (i =3D 0; i < ARRAY_SIZE(desc); i++) instead of
being passed size. That's I think the root of this confusion too. I'll
post a patch shortly.

--=20
Tom

--IkXUuAF/J/fVksFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLRrrgAKCRAr4qD1Cr/k
Cn/zAPwJ9JP9wi3mH1ht78OeMz8J6/QTewvz/f6Fb7m7IuuNCAD/e1wmmLVujEW2
ZUQtoJsEKw3SbzoL0t0IK8DiV/2fJgo=
=Dfex
-----END PGP SIGNATURE-----

--IkXUuAF/J/fVksFn--
