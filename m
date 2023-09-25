Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F8CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2418086D3B;
	Mon, 25 Sep 2023 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="leJi3aCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F81586D3F; Mon, 25 Sep 2023 16:05:10 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174C886D27
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so7309886276.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650707; x=1696255507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xXMjhNWPArnzwPX3N50nV8aFadS+S1ISHEdz/D8pJKE=;
 b=leJi3aCyQGbwH28mcZ8DTAEqq9bSekXwoAI8ra2uJxcNlemuovNt8BvGqheY4j4EPF
 GVxqshoobIo0Z5ZUrgxpId5fFQR4aAm+n/JY8wVffOIla9N0dYTOAxq0IaOdgS55aY1e
 hMUTnIV8Brm8+ZG6qUxNM3vpyvHPc4zglx9Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650707; x=1696255507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXMjhNWPArnzwPX3N50nV8aFadS+S1ISHEdz/D8pJKE=;
 b=PS3bf42xphJwi4JnxRzzLUafdAdzkz9j1bRJ2f1mnMC0da4ltCI+3nqZChBeuJQ0CY
 DjVuTHsgUQwBBeoxz7lnmcEExvAcvyG9KYaIDHRU9zVO1RbLF7otJ0LRj5p4YxH6/Si0
 afUe+dC7vIpMuHXN7t4w2+xk6XwR2V1J/XxL4FgJ3tFNX6OjAEsfvpiHGoxYuQKJLoz0
 rVnm+IZ9DEbY3bIpr+w0YXiUn82N4oY4KOEjO1rwFnZAsWzZPBTQFs/2U/4nppV4c3s3
 RiWTDoVgPv5amI061B+Q85vAN55meDsDdD5r6e0GIWog1Ze7BPu2Dl8RlvB2nPiv1eeo
 du/g==
X-Gm-Message-State: AOJu0YyAZPfxyi8sJ45ksQoH0TYcqssHz/I3mB4UvUay6vhKuWyk9GFt
 AZiCTISxr1J69p7ujByBe9eAKdeZRxN38GaBnBMkrw==
X-Google-Smtp-Source: AGHT+IFvbC0qWGwk977235TWbUdIX7YLsMFBGN59IPcaUlrkNFiUpyUQ25UfZ/7x7oq2h0CHSOECEg==
X-Received: by 2002:a25:ccd6:0:b0:d7e:a15b:58b with SMTP id
 l205-20020a25ccd6000000b00d7ea15b058bmr5499980ybf.8.1695650706836; 
 Mon, 25 Sep 2023 07:05:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a056902018300b00d1b86efc0ffsm2121918ybh.6.2023.09.25.07.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:05:06 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:05:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] common: Drop time.h from common header
Message-ID: <20230925140504.GT305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925023958.1913268-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="01CO37HgTdULZZ0R"
Content-Disposition: inline
In-Reply-To: <20230925023958.1913268-3-sjg@chromium.org>
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


--01CO37HgTdULZZ0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 08:39:51PM -0600, Simon Glass wrote:

> Move this out of the common header and include it only where needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/arch/arm/include/asm/arch-tegra/timer.h b/arch/arm/include/a=
sm/arch-tegra/timer.h
> index 1c4decacd338..c5e9d841031a 100644
> --- a/arch/arm/include/asm/arch-tegra/timer.h
> +++ b/arch/arm/include/asm/arch-tegra/timer.h
> @@ -9,6 +9,7 @@
>  #define _TEGRA_TIMER_H
> =20
>  /* returns the current monotonic timer value in microseconds */
> +#include <time.h>
>  unsigned long timer_get_us(void);
> =20
>  #endif

This should be replaced with timer.h being used directly.

--=20
Tom

--01CO37HgTdULZZ0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURk5AACgkQFHw5/5Y0
tyzwHAv/X0MGCQ0rVYOQaNZXmUJmYGQuB7xyqZ2OZiohWLY/5ltYwif3qtbm+Kdk
OaqKBkG7oM7JoShGbW9lcevPecaa+/pEufdZ0Zdu8qaLTSDJDWABgNcYt+KuSAhr
i3wntqUe6I5b4ZcfM0biCHK4H66MF4eunc2U8DqBudS9VAftJ6H6eCESahR/6X9C
+Dfb6VkyVl2u1vc5WeiLe7/+hGa6Rcv4r3ZXI+V3J1TkH7xAcde1JRTwqfFDhhYs
TkWzFDlkrFiwmJ/KMmgZTPoNm5S44EJRvcYySNLfbazpfEZrMeAv3lqTvhoqVfkx
5mXL9SVDMdljmPpzMJ6nZzYsNnSd55XYrU3akqNMenj9x+5ywvW1dVnZmrF5UhYe
6ftVedYbcJDDSsPmZXHpx6Jk24dnJTgHrtGKF1tlnWbC52gvpl39Wh6c8AcpFESI
8V8ktNz6tnAcMO05E6fbXbejBJZkqlOGfUQ2yzvEm3e+GaOA9Bl7nsT8aAS4ymQq
zvw2+2Y8
=aywT
-----END PGP SIGNATURE-----

--01CO37HgTdULZZ0R--
