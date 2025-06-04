Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FBDC5B559
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4F58070C;
	Wed,  4 Jun 2025 16:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q3zCLJ91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF928091A; Wed,  4 Jun 2025 16:25:17 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB1380584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-404a5f4cdedso1856460b6e.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749047114; x=1749651914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kTmA7xTNaesx0kuyw1yAzmq9ySPHFYUYqKl6XJwCsdI=;
 b=Q3zCLJ91TMC7gxP3AV3nsiW0lGjAofz+m/I/IKqB67yEemvHJ9+RewMbEF05mcbRdw
 syUTpbcGH8nJl4olY92nL6LmcQOIrTsQjqWFWXK9gKcGUejfNo4Q2ScjgaArsG706EDt
 NS+7JTnkxPw7v4M6lqWCp/M29p7Wo8w4lMeng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749047114; x=1749651914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTmA7xTNaesx0kuyw1yAzmq9ySPHFYUYqKl6XJwCsdI=;
 b=jVlxsLNnRGwQbv1hiAeelpkvw/cMKkeQkqqdeal4/giC6ootvJYvhkVcRAaY8eW/R3
 5mB4AlGGhyaUclL0Al55PJfCAb77F19Mdm1itoGm5IaXcO181NUoJTPsBTylLTMCNA20
 Z8a1DKpPGAH7ak/GHnw6I1WWQXNwLc1AGvi368Ns2cOmyBjXmyCkL/G4sXfuPq03Gvqc
 qgu80iaYk1wTcxDLTzJjfpxxqrqLDvvQ9fQOGt2NMBBYYlajUeviCnTuGuwqULS9Ucjs
 SaLflYb16jCShbaRSdEmCSjLtiPO8J9Y8ElycrhQk8rybe3W6Xq70rfrNKqAKfsxkGbo
 GGrQ==
X-Gm-Message-State: AOJu0YyWLmYguA5c9qM5SJRVWrnpHJKHuafTRyccgEZ0HwK0XKcWWhix
 BAH1cjZ3Ns2+a9sboOxKgXPG5ttn6Oov4kQYmMG/QPWKbG2cr+joatSTx9WQHdq9+uI=
X-Gm-Gg: ASbGncusbJpMVdLkZ2Hx5eCE/5GWOmtiLlXIcNadatHPhsLRvAT7qv7hRcoLoE8xjpJ
 lbzKL/SrUtwvGacScHaP5HFHnVieuhPGWC0zq1y28jxgnswhFuKJFNIli+w3ZwpbUSueKL2J1jw
 iq7PO+9WzNDoWgpz49kh0yaCMTaGvN2wINNzmVtum/Ux6eXtT3xkiRx8t3o3X2Apw5oU52SYTnn
 +vM9Nx8CzRvVd05FTskjuwoiuFslNULDPsDSm6VYzBzCjQvNLVHgbJtvpxbInGKASD9TBrxsJOn
 XHTOYuiYv2t+Xc2FElw2K25xLZpGgR5bSIj/aT/oLOCb1RVhT2oCzxMmlXFsXN4hrty596/UCeL
 CUBZnel0aw1T4
X-Google-Smtp-Source: AGHT+IG7vDHPDvNbQF8Ts7BhkvZVOU68r7v3l5ciw+D81vnEijpofZM5Mvt+bQXjgGA5amFpV3oG3A==
X-Received: by 2002:a05:6808:331a:b0:401:e69a:8af2 with SMTP id
 5614622812f47-408f0ea09c8mr2870028b6e.5.1749047113895; 
 Wed, 04 Jun 2025 07:25:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f1cc599f7sm119682eaf.38.2025.06.04.07.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 07:25:12 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:25:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
Message-ID: <20250604142510.GA1922573@bill-the-cat>
References: <20250516125430.1361912-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MIyoDW1IuLeJmYVD"
Content-Disposition: inline
In-Reply-To: <20250516125430.1361912-1-ravi@prevas.dk>
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


--MIyoDW1IuLeJmYVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 02:54:30PM +0200, Rasmus Villemoes wrote:

> Background:
>=20
> I have several customers that will be using a certain remote signing
> service for signing their images, in order that the private keys are
> never exposed outside that company's secure servers. This is done via
> a pkcs#11 interface that talks to the remote signing server, and all
> of that works quite well.
>=20
> However, the way this particular signing service works is that one
> must upfront create a "signing session", where one indicates which
> keys one will use and, importantly, how many times each key will (may)
> be used. Then, depending on the keys requested and the customer's
> configuration, one or more humans must authorize that signing session
> So for example, if official release keys are to be used, maybe two
> different people from upper management must authorize, while if
> development keys are requested, the developer himself can authorize
> the session.
>=20
> Once authorized, the requester receives a token that must then be used
> for signing via one of the keys associated to that session.
>=20
> I have that integrated in Yocto in a way that when a CI starts a BSP
> build, it automatically works out which keys will be needed (e.g. one
> for signing U-Boot, another for signing a kernel FIT image) based on
> bitbake metadata, requests an appropriate signing session, and the
> appropriate people are then notified and can then look at the details
> of that CI pipeline and confirm that it is legitimate.
>=20
> The problem:
>=20
> The way mkimage does FIT image signing means that the remote server
> can be asked to perform a signature an unbounded number of times, or
> at least a number of times that cannot be determined upfront. This
> means that currently, I need to artificially say that a kernel key
> will be used, say, 10 times, even when only a single FIT image with
> just one configuration node is created.
>=20
> Part of the security model is that once the number of signings using a
> given key has been depleted, the authorization token becomes useless
> even if somehow leaked from the CI - and _if_ it is leaked/compromised
> and abused before the CI has gotten around to do its signings, the
> build will then fail with a clear indication of the
> compromise. Clearly, having to specify a "high enough" expected use
> count is counter to that part of the security model, because it will
> inevitably leave some allowed uses behind.
>=20
> While not perfect, we can give a reasonable estimate of an upper bound
> on the necessary extra size by simply counting the number of hash and
> signature nodes in the FIT image.
>=20
> As indicated in the comments, one could probably make it even more
> precise, and if there would ever be signatures larger than 512 bytes,
> probably one would have to do that. But this works well enough in
> practice for now, and is in fact an improvement in the normal case:
> Currently, starting with size_inc of 0 is guaranteed to fail, so we
> always enter the loop at least twice, even when not doing any signing
> but merely filling hash values.
>=20
> Just in case I've missed anything, keep the loop incrementing 1024
> bytes at a time, and also, in case the estimate turns out to be over
> 64K, ensure that we do at least one attempt by changing to a do-while
> loop.
>=20
> With a little debug printf, creating a FIT image with three
> configuration nodes previously resulted in
>=20
>   Trying size_inc=3D0
>   Trying size_inc=3D1024
>   Trying size_inc=3D2048
>   Trying size_inc=3D3072
>   Succeeded at size_inc=3D3072
>=20
> and dumping info from the signing session (where I've artifically
> asked for 10 uses of the kernel key) shows
>=20
>       "keyid": "kernel-dev-20250218",
>       "usagecount": 9,
>       "maxusagecount": 10
>=20
> corresponding to 1+2+3+3 signatures requested (so while the loop count
> is roughly linear in the number of config nodes, the number of
> signings is quadratic).
>=20
> With this, I instead get
>=20
>   Trying size_inc=3D3456
>   Succeeded at size_inc=3D3456
>=20
> and the expected
>=20
>       "keyid": "kernel-dev-20250218",
>       "usagecount": 3,
>       "maxusagecount": 10
>=20
> thus allowing me to set maxusagecount correctly.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  tools/fit_image.c | 80 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 10 deletions(-)

I think some tests need to be updated now:
https://source.denx.de/u-boot/u-boot/-/jobs/1156824

--=20
Tom

--MIyoDW1IuLeJmYVD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAV0IACgkQFHw5/5Y0
tyw2HQwAnaqnb8NA1wshzTulodSRC/7ML5XXfsyN4lwhPoBqSWW+vQRsdhjupRDQ
5q7zbwGNg/GPRGs242Tamah6oaF7JZkEy8SLERcy1Yd51NCSXvAmvORA8/dk1DA/
Uczcva52iOyBvnr7e7YZRstK74KVHZIMxyXeKfAnegR9EvHCQMPpgA+ROHyTv9sI
eJgyu2VFLAIaCsOloCEPhXkRq698IjJ/NApuECAUDJgDmkMEiBohaskblwblooHn
ozo3W1R/cNfgpEG7e62PY/1nbrSTVDMy1KQ+jRlBtq5BM7v+fHnNMrVGmzy5SIAB
XwSW54ECA+M4TojwzDqCS0FAptlriHn9M+VnUiGYxoqY6N/dUVMC7gRFd6Punmlv
V8XhZbnKBbXPINl/SFUrd8o/3q/uIewSuZJ+/eAccfvz6wqspHsP6R+ZID9SF4vA
RST7QVjYFm0Qk0VRM09WruYvtp8VZJGngT05jBgcZzMU6juHl2fUkkAgMv9ssn2+
1jgY8PJ3
=uZWG
-----END PGP SIGNATURE-----

--MIyoDW1IuLeJmYVD--
