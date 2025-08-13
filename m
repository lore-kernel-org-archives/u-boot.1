Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308F7CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 14:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D7C82CEA;
	Wed, 13 Aug 2025 16:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTDmzaSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7213835FE; Wed, 13 Aug 2025 16:11:23 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BCD829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 16:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-30b947772c5so3567902fac.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755094280; x=1755699080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HwzexpuEALHxHbk5OLiI3/EqhUBzIsDpfVVdCA3By5c=;
 b=oTDmzaSil1x/LzcIXKgv6ywfortZQEEwKoNQexS14QysScN8CSjpQBPaN78Vl9RB/b
 oshyCTCQ58y5jFfjtYSAfkclgFJT+r4eO+fXjWBXLF0s/dKhC6nJYvzGQemnQ+hM+xWR
 /ttOKurjjRb358PWHYVg3/kKhdbrq5yA+Ic6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094280; x=1755699080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwzexpuEALHxHbk5OLiI3/EqhUBzIsDpfVVdCA3By5c=;
 b=HxLKfysB5/lH8rimiNlZicyYXmueg73wrPYTMypzwi9YAPkFs9BC97lqX5W1pNiQ1W
 jrtrNqnrfZkKJk4KMMU9KyCmAR9rplneUaNAl42Zca8CERwC+VpLUZI5hbqBy8p0lbb8
 A7vSHTyC63bwqwYjqUI+TF9cLW/QpUAPWaShik7ad3fJCKA0jl43t7jXpxtchuF02Wi6
 9G9EJ1Vhk28anj2uwvcZVf02dEi5u3+y7O7B2TeSV28RasG9we1vYnXjwKN5do6IdqIS
 100jN3m0UrH1CDero2ZYsBdvy4i+AfxUTZRfgfUkMxrCbiNJCWLK6WDtDPUQN2xyCpok
 4zTw==
X-Gm-Message-State: AOJu0Yx9cfZq7FCY6Q/s88OQntya7pT8WirKJmGtgS2PmQV/XQuYW/eL
 +skTcslYv3fUiJ6JGzK1FHBskxdJLTFSc0NJ2BVvXEYsB5ng7FoLvU0rYkGwHdogjUc=
X-Gm-Gg: ASbGnctZaYdubDr6eYB8kfqgdRe6pPfVLksxmFxPXuvvI2f46IflGGNWBnK/6mQoDWi
 8xxWa5j+zMmJLY1w/RCHPc1msllDA25iYZQfHTAF0FpZEFNNOMSU2FGaNMJ0h6qgt+whsQfV6LY
 mcDwJa32RH6aATAJPv3JEHolqVUf8exDNbhGujsYJ+JbFDU1JiL2w87o610ys9fBLB0/VvLnuNj
 RClK4Y2HNGEWlzHslUdHaZe03IYnLmkUD00eAydIeBo9yQaU47/dhzn0irefUFlt75/1JdQulCn
 RBvdeKMRw5qpi0qNOIBfpQANN4b33IUEaelOUKu8HshazAZujcS4DkZIFCSU6KIu0nZf68vm7tU
 ksfoA9A3fTtd6J5U2BS9jLfD/e+Au6Hep7YjosWV5pVpcCysrChCTX0UI
X-Google-Smtp-Source: AGHT+IGrCjye2UuZK5o5K+7bQ0o/oXheoOLbzhULYb6AHNYJN9A4xbk61u2eL1rozLfbCUdPghoOyw==
X-Received: by 2002:a05:6870:d14d:b0:30b:c4e1:794b with SMTP id
 586e51a60fabf-30cb5c052bamr1940934fac.22.1755094279884; 
 Wed, 13 Aug 2025 07:11:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f96e0f9sm878098a34.34.2025.08.13.07.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:11:19 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:11:16 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Lim, Jit Loon" <jit.loon.lim@altera.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: Re: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Message-ID: <20250813141116.GZ124814@bill-the-cat>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
 <20250806032206.16688-3-boon.khai.ng@altera.com>
 <20250806135412.GM124814@bill-the-cat>
 <SA3PR03MB7187B3809CE6E420A2715E33B42CA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <SA3PR03MB71870FAC5AC6E398C2652C47B42AA@SA3PR03MB7187.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ip+zkRXejUJiRUbg"
Content-Disposition: inline
In-Reply-To: <SA3PR03MB71870FAC5AC6E398C2652C47B42AA@SA3PR03MB7187.namprd03.prod.outlook.com>
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


--ip+zkRXejUJiRUbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 05:50:57AM +0000, Ng, Boon Khai wrote:
> Hi Tom,
>=20
> >  > The callers of dcache_disable/etc should be doing:
> > > if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> >=20
> > Hi Tom, just get to know that the spl_atf.c already implemented with th=
e fix
> > above, will follow the fix in spl_atf.c and submit in v2
> >=20
> > https://github.com/u-boot/u-boot/blob/3526f990b
> > 77fca1c933f1d8b24eb9385010a05bf/common/spl/spl_atf.c#L206
> >=20
>=20
> After carefully analyzing the code, I noticed that after adding the=20
> if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) check and removing=20
> the weak function, U-Boot still fails to compile. This is because the=20
> config check has now shifted from being preprocessor-based to
> runtime-based.
>=20
> Given this, I have two points I'd like to clarify:
> 1) Retaining the Weak Function: Since the weak function effectively
> resolves the compilation issue, would it be sufficient to retain just=20
> the weak function declaration?
>=20
> 2) Config Check Necessity: If the weak function alone solves the issue by
> preventing the compilation failure, would the addition of the
> runtime-based if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) check
> still be necessary?
>=20
> I'd appreciate your thoughts on whether it would be acceptable to keep
> the weak function without the config check as a solution.

What does your patch and config look like that shows this problem? It's
fine to have an undefined function when if
(!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) becomes if (0) once evaluated.=20

--=20
Tom

--ip+zkRXejUJiRUbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJydAAAKCRAr4qD1Cr/k
Cl8kAQDO6hbSb5bOdW9c6+W4j1ZCPDWRMDc+5BpPPqWp0Hx82gEA3zdRw5SujWJy
tR4qAupIg0Q7+LsRPU1ATbFqLPehhQ8=
=N7B7
-----END PGP SIGNATURE-----

--ip+zkRXejUJiRUbg--
