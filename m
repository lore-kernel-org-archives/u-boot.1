Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF0DC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 22:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890DE80F91;
	Thu, 13 Feb 2025 23:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QmsBp9Bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827CF80EBD; Thu, 13 Feb 2025 23:59:31 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6022980F77
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 23:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fb2a6360efso10969577b3.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739487568; x=1740092368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ThS4C7tkJSbkchtNf2pslwwNCJo/PvEsFBveu1TcUfw=;
 b=QmsBp9BwsLBlUOIH2L0Glhv4242ne5HN4RojFpfTnGmsAOnfBzhjIK8qCv14cHh6ql
 0gZ8sJkIdyNa550W1BGikntKfKiXreunrDjv6lw1iAV17AzeOvjs1we0Bi/8Mm5IuAH2
 Z3DbEqi/9pc6YCIoDMkx5Mp0nOikZZnXGGUk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739487568; x=1740092368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThS4C7tkJSbkchtNf2pslwwNCJo/PvEsFBveu1TcUfw=;
 b=BIrCsR9HOzOiRKAM9ZX2qLQQ6NiJ5FcxKClpvDxm2ATom9GGipchhf6z0V70Doz7OC
 v0ZA3LV8nAVs/IT+ZU5SF1dJHU3lPRD6cK4VLU1iG8j9UU3igjdv+kFX1mMiMnkRBO00
 VAlBihauvMt/nduAXwLOIJ6eEnjNruj/axXX9SKcx/tDA3fOZFkH2AfaD8HmlSof8U/W
 pmEjOGB4H8Hzy/gu34TKtkCnEuTHd2LwMtUjLCPZbSp2sAiR7bLOQKk9yaDaPKOnIUIy
 JoE7M/qcvx65rsOoa8ecJoiokLpwXfHgxkh4FoJk4WV2rmsTV1SHNSguhyWrMFjz3Kg3
 8z8w==
X-Gm-Message-State: AOJu0Yyd9+uY/qcNYSOpqs6iEGK+E4DYYJHTb3lFNw1ZL+cAexw4O6Kx
 Ry1qSu9bwkzvGi8Lw1Js08pi1+l8Ydf8ZGwuHBFd1lDrp5iGhgrjajGYyJrYANU=
X-Gm-Gg: ASbGncv6wpU/k8r20QAi8BZoxwaJUTGANEd27ZzFH1Ua4vNLqJrirgpDV+a0pGNK0KZ
 ghhkp6RKBQFlGZ91/rxPXf3qB+KayBmrgWKQl647IP8fi4Ia+du5CZo3LE/V7z4MdDcAXRS+fDR
 oqfg+qrB0HiQChrYQtLYiCPOKwa78nYGuWaCqmNwSyeqlvuBqZN6mQ4xAKTJkjhQTt+H/rNuYKl
 1gfl3jku3Tm/Vc1N9aDjXO1qkfMsb6S0o0DDSJCmjvLXafK0tT/ZrZsJpLrWBXSRCiG/qs0Y0n2
 g3dM7FxwONKOgxA=
X-Google-Smtp-Source: AGHT+IF3imkjCUALWKEwSJ5IIzJM69QCI9v6ioFuqy55eVICxVTgte6J8k42phm4MAn8h1KLlgrDUA==
X-Received: by 2002:a05:6902:15c6:b0:e5b:3b9c:ddbc with SMTP id
 3f1490d57ef6-e5da02069d5mr7507592276.16.1739487568293; 
 Thu, 13 Feb 2025 14:59:28 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5dae0da261sm654861276.37.2025.02.13.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:59:27 -0800 (PST)
Date: Thu, 13 Feb 2025 16:59:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 00/29] test: Complete the suite migration
Message-ID: <20250213225925.GB1233568@bill-the-cat>
References: <20250207183121.117663-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3faBBwkrLbmlT8wE"
Content-Disposition: inline
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
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


--3faBBwkrLbmlT8wE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 11:30:31AM -0700, Simon Glass wrote:

> This series completes the removal of test commands for suites. With this
> it is possible to declare a suite (including init and uninit functions)
> without needing to write a command.
>=20
> It also adds timing for test suites, so we can keep track of how long
> things take.

For the series, applied to u-boot/next, thanks!

--=20
Tom

--3faBBwkrLbmlT8wE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeueUUACgkQFHw5/5Y0
tyx+hQwAiYfCaedIVJ0kGdRq8ALaLiAdcXElpW1wCOYFlQkbQ1LWKZHopqUul/Va
F5Qs+WayPQGkSOnJ7AM3+BjKcR1rNs2BUBGGiEi6obbQrX6iKlSCtAcgSvj8S4ed
LJz0LQcbkpxBnCgKhrBdc7P1WxKZ7qa8hLCorkLX8EXtN3erFJaVA4Ziek9x+Bm/
F4ipakZhKDADRbqHk4jkIHvM3PafGMoE02gkXXbeFGPZyqvqDQqEqkmNOYobiqm2
cmQqvncWFmQutdLq4qk4RVKCphp+ZhR7pp0mxeWBQ+IabTi9m0JSJPI/hSnbK7vR
QuX6KF84/454k7iyA8qmFtG+pf486c0hJr+v3azOVO8CUNfKUZ40Ef5IUiSTCUZq
4Y5aiOBXHjs4PbsQAqccOIDOhAcDR2B7hpmMBS8mhnz9kIVs0mJkWb37SmrrrRp8
b8d2Upasyu3K/0TOwKtq5a9vQe2Z9vSpVEEknhBLy2rz5s2e5f0kn/dLgjS2VB+/
nw6LNPtN
=GVyv
-----END PGP SIGNATURE-----

--3faBBwkrLbmlT8wE--
