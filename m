Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F100C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933B884B53;
	Wed,  1 Jul 2026 19:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aJieAadQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B65784C43; Wed,  1 Jul 2026 19:49:46 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184B9849FB
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4472500e25fso419415fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782928183; x=1783532983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FD9hJhzUl89OMzC3u9zpPXl/fU8GbEiJDuJb99zq68A=;
 b=aJieAadQTik2YH8zaEKvG6OgLtoGLPOjbEymPWcHwYFN9UaTYOGc7rSpb6VXR+wgrW
 hgB+yDvTYurmyN7Xl7juP1spy2SaX+rjUjkcmgM9uJL7KpE0PdxTiR7Vq9G3s8tWgcKE
 Px9fq5Q4spZJ/gNju1lNil4LYOzA7dI2RcztA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928183; x=1783532983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD9hJhzUl89OMzC3u9zpPXl/fU8GbEiJDuJb99zq68A=;
 b=mrUu5ONSdxFmx7nGOTbPu5Z1tz9EY4tSun9OBkTdL6jPZ9Iue+qT0a8KUGafL2voUD
 QjHxlMuWMJNHm/XfDL+OtkLUO/b1kxtI4eJvplkrbVM6+E6NMWnjRe2JHpyfchQhksxK
 KEiT0tE1vr6u/ENWA9S4iQOaP8nPPj45haKWhdWVZr7QnKMH8UUYhsrgtM/nwsyKGGCD
 mbM3MgABh0OLxnPH9lPhqVogLEWTtGNQavn4MGjsx9jDmNTnWXBGDDLLfu8B+AXpFA3z
 K5+I/I7cCkLYG1FWLvPyDuw4bwxchzJaxdewZhg9dnbM0pOcfp18ovQgOKWcouA9fURQ
 +/qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+s0k1fuEIuSO4naN5wNVWHrOpBLdJwwlINmTFft2BII8YU+UmK1MKauj06aYRbebQofHRZuIA=@lists.denx.de
X-Gm-Message-State: AOJu0YzrENisVDhtjBEW8wVHf+bJYOlnVSr2w0R8txl5xvJSutXmjwjz
 nAjytzl5+HIyU8Mkgk7jIPMgl2lTBCDm/mBXdlzfSiyRpcfSMZHQCIBDIbftS21nJIk=
X-Gm-Gg: AfdE7cluIVl5yvyDnY9jjUsTZ1rRu83lBLq7w8BZr8r+a9bEOMNX1/wlqSSWaR5l6/x
 htxlplTNCJZotXh80+1H5ld3WbICBtIc5m/4PXvpaWM2xZp6taf/Uu0ZoI/bIzE4rCS0UVetOjm
 PbW6gOjOWq50nOrHB2cogdb2xKYtgd1ASEVmG4WaI5jwa6nix6D526eBw1bHxRqvLAUnXxa5u5S
 BHrT4NcaIED2PYyavp8wLG6XSvF68q9nrdfXy/VFtfyHzZahHw82kXqnrUlDwrLV8sV/q6LNf0s
 HWuMVyexF6RkeSRVqTpy42djnTIX1TMjp4d3HqoDsEcokwurNQZZfhzoRpw97fGPssG5AiHXlrx
 R6Ga6NhXiw/KDSKCRicFb2jwRQCpRwt253581881Aa3UOUa9TWuYlznF/pkz6Y4u8mgXGK49E1V
 NNVg7yMr9hDW6S0eFC0Pxmm9FKSy/aRN0TvcSHIUv/Q0/SmoODFdsfSFRp5ArbEK4XOLChcK0nJ
 j6nXi231t7lpZFWo8izaof7vXRaKcwvm1/Ofw==
X-Received: by 2002:a05:6870:15cf:b0:447:8919:f7cb with SMTP id
 586e51a60fabf-44cab6eedc0mr1332120fac.16.1782928182710; 
 Wed, 01 Jul 2026 10:49:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbec93a70sm391606fac.11.2026.07.01.10.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:49:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:49:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Message-ID: <20260701174940.GP749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rXgG4yVjXc1wQhQ5"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-8-me@ziyao.cc>
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


--rXgG4yVjXc1wQhQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Add some common library routines for the architecture.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
[snip]
> +#define CACHE_MAX_LEVEL		3
> +#define CACHE_MAX_INDEX		6
> +#define CACHE_OP		GENMASK(4, 3)
> +#define  CACHE_INDEX_INVWB	0x1
> +#define  CACHE_HIT_INVWB	0x2
> +#define CACHE_INDEX		GENMASK(2, 0)

I was expecting checkpatch.pl to catch the double space here, but it
didn't. It did warn about a few other things in macros, which should be
checked out at least. And that comment applies for the whole series,
along with a manual check for other spacing issues, thanks!

--=20
Tom

--rXgG4yVjXc1wQhQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVTMwAKCRAr4qD1Cr/k
CgpZAP9+v4LHte8sBuNCrkBVvLuZOplGP1bXt2XWJcRc7D/5lQEAocoekyntXON+
IumeJOyXne5SBT2nOB6e5a9g/33P9AM=
=PEkK
-----END PGP SIGNATURE-----

--rXgG4yVjXc1wQhQ5--
