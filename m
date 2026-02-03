Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C65E87845
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96DE83B43;
	Tue,  3 Feb 2026 17:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0xhu8pS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A1A83B64; Tue,  3 Feb 2026 17:13:43 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E0D83B32
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-404254ffe8aso755465fac.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770135216; x=1770740016; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Rrmdqo5ij7xQCtVygb3w4QVqR/eOUDRnpBOD2bWCP0=;
 b=h0xhu8pSYraLPKPkURusDNOujNVe1jaHT+YdYsxeUbryJSp28fmgsR7J1DzZN+DjNf
 kUGqhmu/2h+bxlwPfIo+mhDISpvRmOL0WHkWJz8HTJVIdzWA2BwzGpC/rFEySgc7Ihcl
 CVs1BHviY3iKklbrp8ZkY5vZvXzj5OjhPt+ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135216; x=1770740016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Rrmdqo5ij7xQCtVygb3w4QVqR/eOUDRnpBOD2bWCP0=;
 b=PjCMNoDHooMQEj8D4//pZxp34NShGD4jLWJg38HUth2z31jy1i8pv7/8Kq7Q0IbIZ6
 SMAn2OtBbkKwbFzF6DJZ31NT3E+Idr4NQ34DEW1GwkdhNwR5KxGYoHckzPYynpfwSg0y
 aHb/RIGU65Z5GKojZblUzsVyeKBMBXGPfmNt3t1OTEXpb/AZ1icdJfV3AXwNW3lgFiPR
 YvRg/K5ZSud92NBnyeMiD9tdgNgkGjqDz0N/lWM6xeVm2rJ8Jr3tFGrakVBlGE9xjfMM
 7iBBoZ217sSCyZ3mdCYOajcVQNpDziDCADo8jwjr7Rc6saJ2ACTecTYR0TurknBhnL7l
 LXVA==
X-Gm-Message-State: AOJu0YylQESHGoJSx9GJ+1o7y1UTv8eZKwlmUVVAumpl+mtuwGLiCySz
 kRJDjaGsbcJdgtHJ2hsuhygLJkaGV5dnFxHSkhuVrONUSSsxxNdtAWswkBgSfNzI56E=
X-Gm-Gg: AZuq6aIwqwuzzGBCtFDVp1nXt0U8kbSdQZmnRDhMpJt34qOSThuwKuCyJf3psKySrLK
 VB0v6VDF2E5w6xhHsSTjQOeBtAh9WpyDvAc8pwm2OQUp+3Z5K/zd3n9A3t2S4Wc7brfaxR1khuY
 cObEzQ+96kx3qR+71niZkirkWE0v14EHzHdS/R4LvZbtlV+SVAhAfWt5u/fD2r3A9Bby1rItDHA
 RR9LQytpXwpm7iy9MNKc69Fm6ysrpzzoU/x9ENd4R/SSEMbPoD24XmlZnaZsMynQGv9pTl9ZDdS
 WqzTwnX8JnGa/j01Vg4upkX3OmVmsrQDXmrjpKXb0p5XueBpfrk53vw0lH6N6HwGTnZe93CyhEt
 CARBY/gF+8NzGzrI6FfyVoUZnmNJRVf/V95ulwFobcSITxPin1T06E64FF89qc7If7WS3BKSPKW
 4+FYqbU+Lh6hOWO0fLgXMXxqLUuZfArvk9VrRaaOmIdTm5tfAkqv0H73QRuWVtIPO2ThOe4gWVc
 jDXOIwDUHMdeOFocKYEY4zufDoRw09DaPqWFUU=
X-Received: by 2002:a05:6870:1687:b0:3e7:eba8:327e with SMTP id
 586e51a60fabf-40a31add8f9mr1762382fac.22.1770135215943; 
 Tue, 03 Feb 2026 08:13:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095716e7f9sm14252837fac.6.2026.02.03.08.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:13:35 -0800 (PST)
Date: Tue, 3 Feb 2026 10:13:33 -0600
From: Tom Rini <trini@konsulko.com>
To: niko.mauno@vaisala.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] bootcount: Add missing count value masking
Message-ID: <20260203161333.GL2603314@bill-the-cat>
References: <20260203144404.12093-1-niko.mauno@vaisala.com>
 <20260203144404.12093-2-niko.mauno@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VvxL+s/TvNCKZXks"
Content-Disposition: inline
In-Reply-To: <20260203144404.12093-2-niko.mauno@vaisala.com>
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


--VvxL+s/TvNCKZXks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 04:44:03PM +0200, niko.mauno@vaisala.com wrote:

> From: Niko Mauno <niko.mauno@vaisala.com>
>=20
> When storing the single word bootcount value, add applying of the
> bootcount count mask which seemed to be missing.
>=20
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---
>  drivers/bootcount/bootcount.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

A cover letter for the series would be good. I assume you found this
problem in practice as part of doing 3/3 and so the wording here should
be more assertive that there is a problem and this is the fix, rather
than passive voiced.

--=20
Tom

--VvxL+s/TvNCKZXks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIepgAKCRAr4qD1Cr/k
Cl6fAP9uyC/VIwZUC0B5mDX3YwcgAr0WLksg8RxChb9CIPos4QD+LO1dPA8Z0AgT
8IvUhxAyanDSU3yJrUIljms2XO923Ao=
=pVuL
-----END PGP SIGNATURE-----

--VvxL+s/TvNCKZXks--
