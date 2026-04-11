Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D71BF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2109F84118;
	Sat, 11 Apr 2026 16:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFklCWht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 976598416F; Sat, 11 Apr 2026 16:53:37 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC9D83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-68a2f93b42eso1103301eaf.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775919214; x=1776524014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3YOu26vGzWE1gp8zkDkbaE30rUqLvO9Q+K7hwgAeBqc=;
 b=sFklCWhtcgMB2uaFrv8o6VCYNBS4pUg8qdtmQzxpzJqFV5uprZs6XA2zNQzDknVhqe
 m1uDPKCwjhyRu/Q/jfrE0diLaNegzvxX6MRcXvFlc7R5C5mHRBo9DG2Cy84AN7XG+aZl
 jt+xVbm4A/wsnpf+RwH847LtrStDG5cZbvnv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919214; x=1776524014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YOu26vGzWE1gp8zkDkbaE30rUqLvO9Q+K7hwgAeBqc=;
 b=AQ6D4QkIVu1i0PJFCoKjsTPJQFdiG/oqQUlCwWW+9G+5dwzRY5PhpOdrDMtPnLS2D3
 uX+w7gRjTmdDkFimbu03NPg8HdWPwjriLe8/tlkUC24WzREKmLwrZMltXeuvv1zWSd09
 7bZ6MhEvh8jQikVpm6tHc3gVoNRMzHaAC+lVh6E8WFP7JdQf1zFhjRfPiawvt3MWjmCP
 JD21Fz9VAL7zCk1iZOq6YGNoMVstqENYvAlygPwwCClUltyxPiRp1Yhd2S4Z01AhBfTq
 4OFOKH57m9525OC3Qvv7c2JViyP/p9dUS9+aN8CkL7TaT9teXHl+/UsZkNnKWbnvfy9J
 RXaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFTofJR6oTyCeiCIyNNkjZYGZEc9A0f4hdbPRI1HeRq9qrYr2ZIAJtXF96yGd2ZBj6s7kqPUE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+dwYag9dURVba4eQaPOmjLN4WlRsm6JRDMzrml3aFVZGAiql8
 kst+ASwxZJIpsRAvLKt2SqplEfBGlU4DzSOw2F840C4rYaozannwsrPnnVHdxuR/888=
X-Gm-Gg: AeBDieuG9KnXMOezhvMJKGR29kxN/d+YZJuItY1n+Vt45i4uhAB5pAntj+kZHnnKeax
 hfLtxURInWteXlkTFQDERXD4BJ+U5k2SxabGG+m0B3qp8gMXaUmiUMp6nOERUkZ9tNZ/9TVvP3p
 YhKlwyKYqEwf7GvQgvLFp2VdGeg24M3ROVwet6uKuHnj0fpncfPLKYyIxx8VeJYGxAdZo0cA+L9
 BEKhOwWMaTfwAoEMAFwbuK8ChRmDwRHTKK9DPTDrzWjL+T4ZVxSUvbHapVWE49YoHIv6KW6wETR
 U/ZaqVQ+HQRqnI6zv5ohJuBrZWQPIn1Rk5wHAN1wRhOOFEEIUV0MKWl+J1JR3s1DvdDWZnafOJZ
 YQ1rvTmIxbhj00sBxv9nB8dBGFD92+kyVYM0+O9aOsq7DHMuVM/M8k0zi5hP04i4DBkzaGp6i+W
 g6C1KwvU7SLvQY45Lnv68w4aSYuwydPCa4ARLg5lb1wpgHx/4N0ijWkz4zXgWE1ShgSqP686nTp
 Zyhq+V0VHq9qvc+I19EFTZmcXRlGF/VYi2d9d9qN5xt2GSeWao=
X-Received: by 2002:a05:6820:188f:b0:68b:f68f:86d6 with SMTP id
 006d021491bc7-68bf68f9cedmr3977767eaf.26.1775919214137; 
 Sat, 11 Apr 2026 07:53:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc88c7493sm3103723eaf.7.2026.04.11.07.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 07:53:33 -0700 (PDT)
Date: Sat, 11 Apr 2026 08:53:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
Message-ID: <20260411145330.GV41863@bill-the-cat>
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
 <CAFLszTgwK5nUs2QA2Mh_pkTXycAiA0L4ukD8qywubW1AmTetxw@mail.gmail.com>
 <CAFLszTgvueYQUyGCQp3amZN20__LMvz_Eu5S_m=OQf9QDsr+DQ@mail.gmail.com>
 <tdc3t2.1tjebl3bs6nc5@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MSJPg1yEx2tioKij"
Content-Disposition: inline
In-Reply-To: <tdc3t2.1tjebl3bs6nc5@postmarketos.org>
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


--MSJPg1yEx2tioKij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 02:47:00PM +0000, Ferass El Hafidi wrote:
> Hi Simon,
>=20
> On Sat, 11 Apr 2026 13:34, Simon Glass <sjg@chromium.org> wrote:
> > Hi,
> >=20
> > On Sat, 11 Apr 2026 at 07:27, Simon Glass <sjg@chromium.org> wrote:
> > >=20
> > > On 2026-04-08T16:34:55, Ferass El Hafidi <funderscore@postmarketos.or=
g> wrote:
> > > > autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
> > > >
> > > > The autoboot prompt used to only be customizable in Kconfig when
> > > > AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> > > > autoboot prompt alongside a splash screen, there is no reason for
> > > > AUTOBOOT_KEYED to be required for this.
> > > >
> > > > Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> > > > print_boot_delay() instead of a hardcoded string.
> > > >
> > > > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >
> > > > boot/Kconfig      | 30 +++++++++++++++---------------
> > > >  common/autoboot.c |  2 +-
> > > >  2 files changed, 16 insertions(+), 16 deletions(-)
> > >=20
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > Actually doc/README.autoboot documents CONFIG_AUTOBOOT_PROMPT as part
> > of the CONFIG_AUTOBOOT_KEYED group. [...]
>=20
> Sure can!
>=20
> > [...] Since you are decoupling these,
> > please can you add a patch to update the documentation? Really it
> > should move to doc/ though, if you have the energy for that.
> >=20
>=20
> It's already in doc/, what do you mean by that?

It should be in rST and part of our public docs, rather than a plain
text file under doc/.

--=20
Tom

--MSJPg1yEx2tioKij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadpgYgAKCRAr4qD1Cr/k
Co4bAP4oBQYRPB8YYgYWiaAXGQIZQkmCob6BKyB7gItIj/PjSAEAtKv2H1h8D85L
UZ4SLT/pKsZnNXl7PGr9TruZse9CoQo=
=niu0
-----END PGP SIGNATURE-----

--MSJPg1yEx2tioKij--
