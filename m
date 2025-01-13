Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CDC02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 16:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FCB80628;
	Mon, 13 Jan 2025 17:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cn61dY6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E93D80141; Mon, 13 Jan 2025 17:48:38 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17A680619
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 17:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so37090166d6.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736786915; x=1737391715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zczrakj1tZ5rqlnX52y1XfXgnQ88AMlYuRGlDDSysV8=;
 b=Cn61dY6hINgyXrbO3OtysMed304CV4vJ8eoilRALzsRwVEaU6zW4fugM++SAeD9u+a
 U6kg7nN0zyOBTZqUIGWedIPq6C3bLb2L5hEYj1PtSG2iJnuhmzsz0dSU36KCFPp2Xph/
 8EK7iWY1QNbjS3InIM5TvIoCHDDVI0L7tqY6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736786915; x=1737391715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zczrakj1tZ5rqlnX52y1XfXgnQ88AMlYuRGlDDSysV8=;
 b=pXiNYfbSVh7QVfqAT7kHK6iu1QceLbSyOsRVEMrFH+1n7fhB0cnb4kUOkw6MwyahEf
 5+MbaWi/ocuMx3tyoFMs95nNBZhag+ohDvUmSr+xVa5WU9i3iNrKpkABJBvp8JunYfMi
 BO7VPJJ30/j4SrAdmAFR8YHy/xjb7DP8X1FWKCWyagjZMFniXJdq9nszDutSeGeIZxa0
 9dsSx9G2SiRd27bqtcohVNMFChYHdOTy6MyfnhEy/c7aKw0BDy2Nr2OwvVOQKpoyy5KR
 KRVp+MOEHGG5/ABV2pzSRR6R5kqbqt2ZayeR2x/NtakcEVhnxM+QrcSTd5qdN16//eA+
 +oUQ==
X-Gm-Message-State: AOJu0YxKwKPP11D6QSRIOkZAqCvr7whDA6RWMfhiF0Z/qmyyd0YYiRsf
 ym6vKaAmvZ3GUehz9dGEsSqG9S/NdB81Cvj1wZdOucoo26QtQOgCZjREMVxESJE+8C4GV1n7h2h
 L
X-Gm-Gg: ASbGncuAes1FeCX6Z0LT+qNDeE4j6sk1aADGOYMfbrjxnDbQ3PDoLcl+uqBm8PnKUq2
 ex8vA+tvVEMvnvViGAebGqVRFtTmcRGFlI9aPR5Q8UujG8bsiKuc0N+GyiMKQNRO3EhASF7kfW3
 xxt4vQZLve4qmTjDbA0Cc9zWE/4VrmhpoFU5t/vcv6wTeaJ1yQHe42bMX3DKwicbYtpL4zrJfYX
 O7vbfzLLSkbYlxF4gltE061u01DeS/b5V6txtT4pxwCfw3wJ7dTn/M=
X-Google-Smtp-Source: AGHT+IHIPW2y59D5uJpViXxSPPcQ9zHS7s6wgN+nprgAX8GeAw1ZRfKPvay7/y+5j53SFoJvaiz7qA==
X-Received: by 2002:a05:6214:501a:b0:6df:9740:68a3 with SMTP id
 6a1803df08f44-6df9b2b3231mr390663076d6.38.1736786913314; 
 Mon, 13 Jan 2025 08:48:33 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade73266sm42965846d6.74.2025.01.13.08.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 08:48:32 -0800 (PST)
Date: Mon, 13 Jan 2025 10:48:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20250113164829.GX3476@bill-the-cat>
References: <20250113122503.5890-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LSrBqtDFNu7lvbgo"
Content-Disposition: inline
In-Reply-To: <20250113122503.5890-1-marex@denx.de>
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


--LSrBqtDFNu7lvbgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 01:24:50PM +0100, Marek Vasut wrote:

> The following changes since commit e13e0a921f444cc12127c8a497dcc476f12689=
39:
>=20
>   Merge tag 'efi-next-20250105' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi (2025-01-08 18:05:51 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 801b5fafd35db53f229bde5e2eb7d290e5d172e7:
>=20
>   usb: ehci-mx6: Add i.MX95 support (2025-01-13 04:39:05 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--LSrBqtDFNu7lvbgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFQ90ACgkQFHw5/5Y0
tyxi+AwAtIz7ubFiY6s74mN8qJox7caGH9PkTkPqQI45XEIwz/hl/4jAyaNneB2Q
OzqqLKaXz48qyCGreDzu22JBcT3viC9XNEuJV8bnrDTW7n67jldcZhI8rUwMpdHC
IlpL8GQsC1GaVMwtwjjpq7oKyq8PM24E9spe7emvZxXxIn3ZqgbzLYfH0qhnzWid
P2IpOnx8+1w4dCOlYaNq0L2HcTS05IFe9FDLlaFIkw1pyeNplGyUty40idic+fv4
n6LX046zlgWp0RO3cQJUV7x99vOoxbolybIRjRpaMEnzHiiPMulCzSwXKv3wYJCN
9Z+WUBGVqIKt/7nsV6tZbhCmDEEbNvp1+iXY6d6QCFnXGyGg1O88qMMpg2I3+bWD
VZVs6qOYhJFzpDRAH3yTMLzmMRy8yf+prT5XJJuL2ZNL78n6IzOTOJ0cHGkHqF9B
9nD18b4KBMkyJ0n3E4TXtqUpKwm1Lg1SiH601XKAgr1ECL4XRPxtpMrpfBXJn7Gq
Ec/Bd5UF
=A6nz
-----END PGP SIGNATURE-----

--LSrBqtDFNu7lvbgo--
