Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85877C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 16:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE058277D;
	Fri,  4 Jul 2025 18:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZPpEkWLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8186782A76; Fri,  4 Jul 2025 18:47:01 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC8D803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 18:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso819507fac.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751647618; x=1752252418; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXxYzqEUSVSSjrr1US4IJVHOw5BSYPMReWUjV2gdvpU=;
 b=ZPpEkWLCGt+lPLZ4s4iwaIWzXiCYIf7OkKIsVjisUQNdL1g3RLys/drBpIa2zRHY2B
 9t9Iwc+1Op5r2BlKbCJe8HgBfaAgRDtdNOJH23pchB2Kvq6DCZfUPLK+vrbgEiNwfXWR
 uCNFLC1jEWCYrckTC2F8EPQI3jVdKaQTJn9AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751647618; x=1752252418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXxYzqEUSVSSjrr1US4IJVHOw5BSYPMReWUjV2gdvpU=;
 b=FaDNys6zHQLbHomdF2WQ33TERdu4XbDhH5x9DLAa1TZ5yvAdjccojOo+Yi+XR7CUEU
 Oo9hhAhQE0lErE1IXBJGbOhshosTrUYLiS0O0Z+CLBQpcBjONeYEakZ8PyaBBroSN1MB
 V66rP/GdLk3/hlW0Yw900R2B/0uGf2uHRA/qjgDWl1A+RdRS775YKu+NsFugGH6w77iX
 UfCs1GBUSfkvj5vGW2iq34PHqWm8/gfVkSkW7+beYBvuWRUneGwWZHpwp0kTa124OCWx
 CrDuDxk6Q5EwOqSMIpmipb6NvfgMSzdNnJDdnR1vf+00yrJhOrqpxcDL4wLvCwAM74yW
 VA9Q==
X-Gm-Message-State: AOJu0YzXwyrSGTE377/L+ZEuMNyIxSvNYMNqn0KgIeR87rBzyWj7ECO7
 kofb6wqU8cTIMPvFAyNMw2Fw2UJ/8zKqQVbUz1phoVyPS7w7dDFe9NFaIVLSNOpK0t0=
X-Gm-Gg: ASbGnctvb7aEUhsXlY0l41fxcMZ4CWwycVKaHkngRo18mzgiJE3lj0rArIfcSiFilTE
 ci3NPomN36IZVZBr+pfz75MRMVTqNAa9QJNEZbn7Y05YC9bjOxSAf4c8NF1e17OTMneemce86qZ
 BuxCXhUBo22Rd3Xpe8ZbJ94Qfvwtj3fdhd8yjyJg3ADwg/sNgZZY0kmgF+IxsVtF2lGmzdWF0Dm
 EnNEyiJWOK3W5EPRPX6ImfbTnCk6VkXI3Rk8J4ZgoE81XzYhF75bS3GEuKWdqlweoBXH1SLl5tg
 7OEFqDnGNgb8Bit2uAXBA1yof6BPrHp1s+4qp2kFYT3pLB44OaJ0pehjF5QSlhxtxrgl+HdpVwW
 YVp0KhLYb0JgSNikg5IXMb23TMUpSa50=
X-Google-Smtp-Source: AGHT+IElNQcfgrkk1SpAdxy1JTT14tW7orL/FCkY1tRy/OMRe/7F2s1lRmZYL+qfo7G4czdCH49DIg==
X-Received: by 2002:a05:6870:e3ce:b0:2c6:7f82:d38c with SMTP id
 586e51a60fabf-2f796e00a52mr2161309fac.31.1751647617883; 
 Fri, 04 Jul 2025 09:46:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff47158sm600791fac.13.2025.07.04.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:46:57 -0700 (PDT)
Date: Fri, 4 Jul 2025 10:46:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org,
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
Message-ID: <20250704164655.GI6424@bill-the-cat>
References: <20250704144022.3946416-1-festevam@gmail.com>
 <20250704155611.GH6424@bill-the-cat>
 <CAOMZO5Ck=ufscXJ8KFyy+Ee-fPJNtHFKTFMCGdQ8t0uWVbFfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4drN8UyDbGZjQLii"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Ck=ufscXJ8KFyy+Ee-fPJNtHFKTFMCGdQ8t0uWVbFfHg@mail.gmail.com>
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


--4drN8UyDbGZjQLii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 01:40:40PM -0300, Fabio Estevam wrote:
> On Fri, Jul 4, 2025 at 12:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Jul 04, 2025 at 11:40:22AM -0300, Fabio Estevam wrote:
> >
> > > The mx6sabresd U-Boot proper binary size has grown beyond the
> > > CONFIG_BOARD_SIZE_LIMIT.
> >
> > So, is CONFIG_BOARD_SIZE_LIMIT set incorrectly then and needs to be
> > lowered?
>=20
> The current CONFIG_BOARD_SIZE_LIMIT is 715766.
>=20
> This value is CONFIG_ENV_OFFSET (0xC0000) - the offset for U-Boot
> proper (69k) =3D 786432 =E2=88=92 69=C3=971024 =3D 715776.
>=20
> The calculation itself is correct.
>=20
> The first issue: CI does not report a build failure. However, my local
> build reports:
>=20
> u-boot.img exceeds file size limit:
>   limit:  0xaebf6 bytes
>   actual: 0xaed70 bytes
>   excess: 0x17a bytes
> make: *** [Makefile:1501: u-boot.img] Error 1
> make: *** Deleting file 'u-boot.img'
> make: *** Waiting for unfinished jobs....
> u-boot-dtb.img exceeds file size limit:
>   limit:  0xaebf6 bytes
>   actual: 0xaed70 bytes
>   excess: 0x17a bytes
> make: *** [Makefile:1501: u-boot-dtb.img] Error 1
> make: *** Deleting file 'u-boot-dtb.img'
>=20
> The second issue is that even if I remove the
> CONFIG_HAS_BOARD_SIZE_LIMIT/CONFIG_BOARD_SIZE_LIMIT, it builds, but
> fails to boot like this:

Ah, so toolchain mismatch problems. Newer GCC optimizes better.

> U-Boot SPL 2025.07-rc5-00012-g7027b445cc0b-dirty (Jul 04 2025 - 13:22:16 =
-0300)
> Trying to boot from MMC1
>=20
> This boot failure is related to the initcall series.
>=20
> To avoid the mx6abresd boot regression and play safe for the upcoming
> 2025.07, I'm more inclined to go with the previous patch version that
> increases CONFIG_BOARD_SIZE_LIMIT.
>=20
> Jerome said he is working on a better fix, which reduces the size by
> 1702 bytes for sabresd.
>=20
> Having CONFIG_BOARD_SIZE_LIMIT with too low a headroom may cause a
> problem where, on some build systems, such as U-Boot CI, the build
> succeeds, while others, like my local build, fail.
>=20
> Let's provide more CONFIG_BOARD_SIZE_LIMIT headroom to avoid this
> situation from happening again.
>=20
> If you agree, feel free to pick v1.

I think Jerome has the wrong idea here. The previous problem was on
armv5 CPUs, armv7 CPUs are thumb2 and aren't tripping this problem. I
suspect that if you used gcc-14.2.0 from kernel.org to build, current
top of tree mainline would work. I think we should still take this patch
as it's both correct and saves much more space so that we aren't quite
so close and so dependent on gcc optimizations.

--=20
Tom

--4drN8UyDbGZjQLii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoBXsACgkQFHw5/5Y0
tyzndQv/XrgjIUkreR/0AqAumM7z1MRds2N27NdUI7yofjrWwlLH7nOMVD7+U6Ii
nP7hXKPqeejpeOMyyz9ifP5Jm2GFTTFMP/Alde2tYsSE4fswFWIj3tc/mMNPL/+5
tRNlGN5lVNk62epmVaXjbNIKwNVDWoLrU9gDX4SIxZOlwuyH6RSDnDu6iofPWfDE
bC9A1Tl2e2QlKYLuwBMcgy862uPPukF/qTHYGimaWYwZErtui51uUH0mvojnacw1
fJ0I1ctkcq3qLBdS5El8269k0jufCZlx6q6gI+GbMqGuDqdEru4cZJL/5fcfJZDc
bk3CbUMw8MLcS7hjDFA2NPa6pGkwt1HK3bkCYAqduowHG6CyrrQVi7z8be4LDEOY
6mvZuTbNHM9H051rZenPF+rL7tqNs+GhSax4JBcCyN9ZGDtsCRfs5JIKIrjSms0A
ufBQhOjo0hSAWLOU9eS1k9/l/xdk/dtsfJL5yJwVyjf4N+MzI/uU/tq6/oRTs9eQ
vE/YC99H
=l0e3
-----END PGP SIGNATURE-----

--4drN8UyDbGZjQLii--
