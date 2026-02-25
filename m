Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A33FD3764
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10A183FED;
	Wed, 25 Feb 2026 15:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IP4keUiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97EC183FEE; Wed, 25 Feb 2026 15:39:31 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0E383FE9
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so6332128a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772030259; x=1772635059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p+MF9HCpmi6hnFKNVQLu7hkXfaxdSOo0Ny6872utDpY=;
 b=IP4keUiW14UbraJ9abxX8aJKL+bjI47u6H0jAskd0/ZNiPZbVe/o/skQIR3b2+hSbe
 quQdauy+LNGexVaxaXahPuw6BpWB7rS62g5b2/HRJaUu6n3qNKX+H5Bq0eziJlg0FQ4h
 0uJy5MbXHWrOIZDauKiQfX76Vb6w+KDLp6s4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030259; x=1772635059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+MF9HCpmi6hnFKNVQLu7hkXfaxdSOo0Ny6872utDpY=;
 b=rf6YcQ9EftBIxKaeRp+BXfV8APCJbv7pDFGH85oAPmJ5oU1mwVdRuGIrUFMY7I/Jr5
 UEG2r0Z7GoN4z9EH0XlVAvRh3XQ9HHXCknweZxl65m2REtOeOHHBbfVGL4FOwfsM1BrM
 77tzUfTPoApfO9dHI1IOGzCuBBabV1ccw+QFvI9dpo1V8t3k83W78m/RvhM2k+tUvbPq
 18z8IoAkKsbB604xDsAHjmBfEJTfcTp6K5RDfJr3OLHw7oPO2ruyp4ZswWWjbSO8QZ4N
 vxuyAfuO1MSJizGQjooLrL72sTH0ukW3GMTA8LVQab+R+0ZIq8CvjZWkIeB02xYhs397
 /p7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrhO5FAxwBu9eFb3Q/onNR99V69JN91lZtNiqV2M9qkmBp9PGAZ2CVJ+uk4FyS4oF1rdwYWJ4=@lists.denx.de
X-Gm-Message-State: AOJu0YysA0StnulNPXs0fUniqgfUw8WE7v6S8qCrKGBXvV5/F4WJ6Okt
 pXRoe0IgIsCNC13NHtjI0I/lwOCNtySjg55UiFJSieyWEnBMKTeB0lcrVw8D58ad934=
X-Gm-Gg: ATEYQzyeueuaMKf/rKPFb6n9pu0shjB1byHquDsCEC9KJNGDrvK2YUYcFou8XNDyDSU
 9KIwY6NU4W9OMpIInoin/m47SEk/TSPyzFhuzKB3UqID5mJlea6CwlbSjec+i+xyFG1gHVA7ETV
 Sqi02a8mWdPQdO5JsjfWXrZjaMdzsKZl9CPJjpC4Mm7tCXz1EK4bzQny+8sGHhhdT8VmvbyxETy
 nVD5FGeyEw0rzZuAGA8RBAQg3Q/y0wAO8iGS/ZUiVoRFFmgdfqzfBfIDZLz0yDKpWskPxHOM3xu
 eb9i0bh8iem9PjdVf8GBXjve0B4Tb6qtBus/JUiVSqr0eT7G86clTzCA+sRiu3/DZnOqAprrrkV
 5S8QDnwP2m8vMYsmDhHQemkX1kVr6MJJMlFKZJ+1PR5PXfUztSZVKnPhm9SLDbma+cEZdjtU9TH
 aEOU3rb4Z75zj+9R0RZ5/2Lxmffe2YupNIGwqwNBUTKa6SLN2fkErr1YHDG0+13jByYiBRu2DqQ
 zWn+4M0FpO1PiQjHzRmiiASFDYSkvlEhtN6IS5ddqr0cQ4ugW0=
X-Received: by 2002:a05:6830:442b:b0:7d1:91a7:8e15 with SMTP id
 46e09a7af769-7d582a9889amr315980a34.33.1772030258692; 
 Wed, 25 Feb 2026 06:37:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0386d2sm13838541a34.15.2026.02.25.06.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:37:38 -0800 (PST)
Date: Wed, 25 Feb 2026 08:37:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: exynos: don't imply non-existent CONFIG_KEYBOARD
Message-ID: <20260225143736.GD1593142@bill-the-cat>
References: <20260225100023.46116-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iO/hIixf4NEntsNq"
Content-Disposition: inline
In-Reply-To: <20260225100023.46116-1-heinrich.schuchardt@canonical.com>
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


--iO/hIixf4NEntsNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:00:23AM +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_KEYBOARD does not exist.
> Don't imply it.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/mach-exynos/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index b084b7284aa..06448e875ef 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -34,7 +34,6 @@ config ARCH_EXYNOS5
>  	imply CMD_HASH
>  	imply CRC32_VERIFY
>  	imply HASH_VERIFY
> -	imply KEYBOARD
>  	imply USB_ETHER_ASIX
>  	imply USB_ETHER_RTL8152
>  	imply USB_ETHER_SMSC95XX

Should this be DM_KEYBOARD ? I'm not sure about USB_KEYBOARD instead,
but it looks like USB_KEYBOARD should be a depends on, not selects
DM_KEYBOARD, too.

--=20
Tom

--iO/hIixf4NEntsNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8JMAAKCRAr4qD1Cr/k
CkFJAQCh4ID/ER5FcJot5d5MR7niqN8dhI7HSRHJQJvK944pXgEAi6STDsmJGe1L
U0crLosWi0sr041ttqMk9X6ZClHJRwY=
=t65W
-----END PGP SIGNATURE-----

--iO/hIixf4NEntsNq--
