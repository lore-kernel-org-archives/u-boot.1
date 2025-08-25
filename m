Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41429C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 19:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEEA82DA1;
	Mon, 25 Aug 2025 21:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r5ygO3Pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A128C83020; Mon, 25 Aug 2025 21:02:30 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6E082C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 21:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30cce5c7f1eso3692323fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756148547; x=1756753347; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+jit/3j23T8OOO1JKwk4Q+vU388l2aLORPYqTKIJTMs=;
 b=r5ygO3Ptwh8A0uRctrlSOZrWxLhn5sZ6XABQJhsn/TBubYRa7sBgj1okGnThHZZwx8
 5z1QsSp5YgGyq10pcKSmDaWv1Fv4lnfKbLjTNSxiwadbnbggaI4UEtg1UyP2ryc3V4Hs
 dIROgSj3O+OSJoKOXEHcK+fydRzaDfFuMoIFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756148547; x=1756753347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jit/3j23T8OOO1JKwk4Q+vU388l2aLORPYqTKIJTMs=;
 b=wvl+iaUHDXvsZeiekLxsDST4gab5Ij5fMud2m2gtEYxO/ZSnUcWXGryYteVzM7ujDh
 7tr60LbUBPKs9VsK/y4ggIirbSoh7K16JUp2/gEhfJq5bxHtcD8SPHyjdbJsoPmRtwrN
 lgf8ql/NX47/1+ubqFC73Mb+i2ppysSsTI7aaFdEyWk5hYCz+7Jd8uhKm4ibsqQFG/zH
 bhTEk7R1rNGjwqJI+9QhqOTbrj+i8Xl1xyzEBeYavDQPBXw4J1ivqfuSoDmVnVi7f/Ck
 7HO3x964azrP0A/mkGK5kEq2CfjJvE9uOlvkxN6qlbhguJ4TlRia+rt34KborYpXM7gm
 nsvQ==
X-Gm-Message-State: AOJu0YxQn2FZVcSrInaRupBHmKZt4RZl+t0/GONRRpsYGXVfwvU0pQfN
 tuksYJlRpqfRkNPNYrHG6P2OmhYYYYxJj0Fpa2RvihTipYQ8S4uIwGO8/his3GIUOtA=
X-Gm-Gg: ASbGnctg9or9QPsJwMnUiDBKRxGTr+mKr5NEQczPIA+CW1KHw1HROGH0nGlEKL/a+dj
 l20Io6W9kknfvapvAAS3FmLlbKl3I9oxEkxHkRFaP8rAgesMYaoZzuv/AbXUQ4eTnZM+5/u73nX
 yGLXJCwmlBz3GE/+o2jQR4IGBpbwBvzCXkxsNeuWaIUbl2BEYua8vCpVp5IDHlfLLC8OtTrMK73
 35jxWJSDrsYJbaR3yTXSvEvJh1BehtnoEEYJvIxadqWCP+DFQs68KcPYxj068Ncldn2/AALOZSd
 rm4iHcVaW9GFG1w9Tr34fYQrmqYZnyDsOMcWzyACXKZRigEuoWNL4wkdgVLifZGOdBfrMY+jHJi
 Slqabel1IK9/JBwniedQGQgN1iw+KEL9VzB7eHhq0l9KY8nLVYo/2Qs1G
X-Google-Smtp-Source: AGHT+IFoE8QfPhojIvt42WZWrxZEKX0KQAy8HqDARAcYovrl7Px6ydmR1SXDGscWf45CnwUd6XmieA==
X-Received: by 2002:a05:6870:2e92:b0:2b8:608d:5dd1 with SMTP id
 586e51a60fabf-31543b177f8mr314187fac.18.1756148547029; 
 Mon, 25 Aug 2025 12:02:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79c54ebsm2013221fac.3.2025.08.25.12.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 12:02:26 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:02:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: tools: patman cannot find aiohttp module
Message-ID: <20250825190224.GU124814@bill-the-cat>
References: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WpAfCAL72wr/bgwE"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
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


--WpAfCAL72wr/bgwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:49:35AM -0700, Tony Dinh wrote:

> Hi Tom,
>=20
> I've just done a git pull on the master branch. And then ran patman
> and got this error.
>=20
> ./tools/patman/patman  -c1 -s2 send -n
> Traceback (most recent call last):
>   File "/usr/src/u-boot-marvell/./tools/patman/patman", line 21, in <modu=
le>
>     from patman import control
>   File "/usr/src/u-boot-marvell/tools/patman/../patman/control.py",
> line 24, in <module>
>     from patman import cseries
>   File "/usr/src/u-boot-marvell/tools/patman/../patman/cseries.py",
> line 19, in <module>
>     from patman import cser_helper
>   File "/usr/src/u-boot-marvell/tools/patman/../patman/cser_helper.py",
> line 18, in <module>
>     import aiohttp
> ModuleNotFoundError: No module named 'aiohttp'
>=20
> I'm on Debian 12.11 and have Python 3.11.2. Is there something I might
> be missing?

Ideally you should be using a virtualenv or whatever is recommended on
Debian 12 and then pip (or pipx?) install -r
tools/patman/requirements.txt

--=20
Tom

--WpAfCAL72wr/bgwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKyzNAAKCRAr4qD1Cr/k
Ci+wAP9erK3f66df3zedyt9uAEW1e3OypP/oIzL/S4dTv74k3AEAz0/msMJ8bqjY
ySUOHs4VkrSLtyT4/hYxAxaNbqnMWgw=
=hXQu
-----END PGP SIGNATURE-----

--WpAfCAL72wr/bgwE--
