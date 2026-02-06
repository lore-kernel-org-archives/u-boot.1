Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44641EE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A12838FA;
	Fri,  6 Feb 2026 16:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H+Y92kCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18ED83A64; Fri,  6 Feb 2026 16:03:51 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D474C836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40429b1d8baso760003fac.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770390228; x=1770995028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rID98Tzmsk7pmUaQrp8GFpqxmfzFKINFlR2WPkEx+Eg=;
 b=H+Y92kCV+mfSaWRSv6HPobSRlAzoAZM4sjd7Dce+kiWeYU301QN2fCA/+Fqnr5apBV
 xqUFBI/tmvvwmrjnNaTutONaxfEBIxLeipcdnRM/3P1ynsrcH5w0EAs7vpq5qcFPiW3z
 sZm30KrSpGB9/itzo4zZc/dMEuyziYKwStE5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770390228; x=1770995028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rID98Tzmsk7pmUaQrp8GFpqxmfzFKINFlR2WPkEx+Eg=;
 b=q/MTY7+fe1Y65Xr6+bcbHU3TyJ5fdEAzroTagrTfCPsYNmeIZaq+ACQktgQbLHawuu
 6Mt98FB8SMUfcCnyKV1pOnEiSww89j+tvUnHWgju6MPHqUbjsGLCw9BRZ2JNATfNaXui
 VAjYxYH1i82d4GEaX0ehcRP+U+9HrHYJM2KKDM2GwZgHPkKJM1SjRqCAjhi6dk6+FLUF
 qZ6DgCviP5PXZYyeAhF13Go2cWvTGBQW/1otWrV6A1WlRY4m88h0FIjYi4zFap16Z51J
 i0NhgAqpGFyjUVL5F5Es1rVmILHr3FgNyzwi577hZ8Rmc6zV7d5frQwZEcMUlEk+U5Ca
 HL+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuBW6NtVsovET8Qa2Fg71cEK5NPWwH/TLFrLNNQ+FusRI4kYaPBz6EBYKHgO/Ru0mmvgy79Z0=@lists.denx.de
X-Gm-Message-State: AOJu0YxGlrhdRAoLbv7zGbGvQEE6rDFf6kBjOE2W2v+12iv/LfpmHpw/
 sA9Ctk9qU9O6OBsy6zhmddQtyevm98/IgNeRl+DdF6JvxgKBE8XKvGpFlLoTNqBWf2g=
X-Gm-Gg: AZuq6aIETIN3nZ8xbuyjm8oYxM5vcAeWNTriKsAeuS8wbywcZ/TKIhZlc7XpGr8DWUi
 fXpoZNrIgglFCJF8vYK2BRwoRGnNuWtNAl4WazP11kRODh/9FdNAiagldoRyT00syoYA23zagQ2
 0dFtUpzZbDQdWbps5TGUgvot49A/GNokwTJoYh7ITP1Lea5vr/sHfbOBd1abHhi02UkeMNSzqlA
 CM7RbOIT+aAAWSa5xDheWbWCeY6rOEA0jnrIwajcHmcC2jQ56MxdvGobsJ3F9faNsGhz//8tcZV
 1GZOACxVVgl5X6ELfdokUCCt5N0MtdfO7GhL4E6z4db3D5j6wCFKZ4IuomIKAiDkMj+MwJtKoYm
 nL5MYs8h3Ec4nczo6cPG/Qb4JKRLD2t8M6WsdD0Bss7q/4LxWjenHOsGm5lwzQO8YFl2fcVQLCM
 /WgcOwEARrrC0B1FsRShmwJMo6PWBvW0KpP/Ceg4m/CXIitNDEUeDEeaRL15wOIbVmW4A2MdFAN
 g0rSjH72PRhJvCDHDQcJY3Ryu4RvyQq5I2YtuM=
X-Received: by 2002:a05:6870:160d:b0:409:e025:a467 with SMTP id
 586e51a60fabf-40a96ffed82mr1443454fac.56.1770390228481; 
 Fri, 06 Feb 2026 07:03:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99643fc8sm1777586fac.14.2026.02.06.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 07:03:47 -0800 (PST)
Date: Fri, 6 Feb 2026 09:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260206150345.GT2603314@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <20260206015447.GP2603314@bill-the-cat>
 <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gkl/bf3gmtjH7SOi"
Content-Disposition: inline
In-Reply-To: <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
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


--Gkl/bf3gmtjH7SOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 06:28:39AM +0000, Dorde Stojicevic wrote:
> Hi,
>=20
> yes of course.
>=20
> Here it is:
>=20
> $ mkimage -l build/ed7ct-cb.srp
> FIT description: LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
> Created:         Thu Feb  5 13:58:31 2026
>  Image 0 (kernel-1)
>   Description:  LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
>   Created:      Thu Feb  5 13:58:31 2026
>   Type:         Kernel Image
>   Compression:  uncompressed
>   Data Size:    262512264 Bytes =3D 256359.63 KiB =3D 250.35 MiB
>   Architecture: AArch64
>   OS:           Linux

So, we're getting somewhere. It seems like before our validation check
wasn't working and so claiming to be Linux, but not being Linux, wasn't
caught and failed. The right path here is to add IH_OS_LYNXSECURE to
include/image.h and handling of it in the various boot/ files that need
it. Then the its should have 'os =3D "lynxsecure"' so that it sets that
field correctly.

--=20
Tom

--Gkl/bf3gmtjH7SOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYYCzQAKCRAr4qD1Cr/k
CvrYAQDT7wbVMWWfN6mYRHRljpmcAR7Lz7SIgO5h5tJ0a5ddBwEA1A+zqKz/x75S
rnjEQtZES/NL71mrE9vUvxFab4f+6Qo=
=Q5xl
-----END PGP SIGNATURE-----

--Gkl/bf3gmtjH7SOi--
