Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622CDC56204
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 14:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D791083D5D;
	Fri, 20 Feb 2026 15:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Frkw++0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AC383D5D; Fri, 20 Feb 2026 15:45:13 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FC383AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 15:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6780761b665so1176584eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771598710; x=1772203510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+XkUKwdGSi0kJNvZw0LDRUQONS9vxzl2xcMEb+hRFy8=;
 b=Frkw++0C19DpZ/wnyQZGt4T/WXlpdXp0wl/2CsFzHJl7FJfD/JfBcZcvPwGOfi1g4D
 lfjU7q7azIof5Dmk8HpoHJ86FgZA5sD6+SPLUmDI0VNCe4yAbrbPy5wRI1OcEMKqE8s6
 02ENC3KOgxAgMsm4u7+Qru8lYlkrQhPZvBtbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771598710; x=1772203510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XkUKwdGSi0kJNvZw0LDRUQONS9vxzl2xcMEb+hRFy8=;
 b=clW3NYV1bZ0Hz8v4ziqHk5nKzK1FDtTWXORYLbKEnZhFs89zqNTfUTjKcIyvd8QYkd
 JJyw3PaNItany6QjM+495/dlpLpXpUOBRX8OZ3VQAF/mKjU3xjmm2oemeDNWA6mgs25x
 9SB1pgkbZFDC7N8fIMfiBoIm22R6AsIWaLYe0Re8dcQwZGkj7VBzE0dV2YKR8FH4f7/C
 18adY3xpCQltKnq8owSDcDE0kd9yrk5NaoZHvXqMMyDXCKzNqD+Fs5pYnvRk5zCKxbRr
 /3a52zFDOd6peJUZvbvPZp9hehn5bBly/pr8Uyjov3opE/3gy9vt27ZncFPohdoXepFI
 SO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrGSy1Qnoi9be/3q4Q/r0eASlmUFvmwOyjk3KONjyuBb0h25UetlhcNlP7C5/W76BnL4BiqQM=@lists.denx.de
X-Gm-Message-State: AOJu0YyJP+jd7ab87mgapO6BNcC/n/Hj3V1sc47hYeGMbWEKNMlO+ALj
 ZGBsQD1q/nTglZmpfIiIdn0l87DmHItoPgCqSorKyZo/odx928Nb9NMd6HbPrwUnfqg=
X-Gm-Gg: AZuq6aKvu6UCS0sQiyA6qadx/ci/5VScw1s66/GQbjRVbh4s+bxOJIF9YZBvP3QPN0+
 RgH13Wp60Le9N5P+RT750NLTmqaHzff4SLt3fzvpDoMpYY7mWO5FX7z+Slw1ubR7ai+EJaCwh8r
 dMO6MT9EZEJhwC1yAd6YFmcbGuClpLhCHPe9ySpjBq3Qr/wDXLBuo486PN/zQsKwAKeW9My+yWi
 IRw0NSmRxhbQLBCJl78N5BIELe9Sgg3Zn3Ha5JNNVbjcQvKqiTeLidXTRArAfc6v4ntQM8AHFu5
 WvJmatBWZddjMwjOawbGnORaLaSuJXNa+PPwAXW+dJVQqSnEKZ92H/wPga0TCxIDuI1JmijwfL+
 7IC5fc09x3lunwTkl+1XchOBYquzvwBS4P8wZWp2foYIfKLJYa7odj0Jw9S4a2Axu47gjUCIbdd
 Eey4BJ/oMzv671Zm1Sn2hlOG9pV2w8brDDLQE6grCgJcvGhK0bAVc9+/DK++6xYZFPQCFhWo/3E
 ph0J+Bg5baKfl0zs6l4wkToMOK5MMPcy5vAZdNL9KBTMbCyuFk=
X-Received: by 2002:a05:6820:f01:b0:663:5b9:a586 with SMTP id
 006d021491bc7-679c470d349mr8337eaf.72.1771598710041; 
 Fri, 20 Feb 2026 06:45:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6747540780asm17958090eaf.9.2026.02.20.06.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:45:09 -0800 (PST)
Date: Fri, 20 Feb 2026 08:45:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: bb@ti.com, reatmon@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 gehariprasath@ti.com, s-k6@ti.com
Subject: Re: [PATCH] configs: k3_*: Add config fragments for inline ECC and
 BIST
Message-ID: <20260220144507.GS3233182@bill-the-cat>
References: <20260220091532.3584771-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hVrCRb6whxao2JGm"
Content-Disposition: inline
In-Reply-To: <20260220091532.3584771-1-n-francis@ti.com>
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


--hVrCRb6whxao2JGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 02:45:32PM +0530, Neha Malcom Francis wrote:

> Add config fragment support for enabling inline ECC and/or BIST on TI K3
> supported platforms.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Typically we do not enable these configs by default but would still like =
to have
> the option to start building them in our default build flow for testing. =
Also
> there is the added advantage of users being able to see what is needed in=
 case
> they choose to enable these features.

If we want to partly justify this as helping users, we need to update
the board documentation as well. Also, can these live under
board/ti/common perhaps?

--=20
Tom

--hVrCRb6whxao2JGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZhzcwAKCRAr4qD1Cr/k
CvzqAPwOCkNfQ1t0qnw/jLESflqp4dG6r8rXMHvbwXF7fsIwjgD+I1yET+lfp2VP
z81O7pDm4E0ORPevoAIvGkz/na0fMwg=
=JYDk
-----END PGP SIGNATURE-----

--hVrCRb6whxao2JGm--
