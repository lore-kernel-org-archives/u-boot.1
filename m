Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B0DC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8CA8494B;
	Wed,  1 Jul 2026 19:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NDi2Zxto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399AD849B1; Wed,  1 Jul 2026 19:39:47 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91C08469D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso521708a34.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782927583; x=1783532383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iICKavTbrke5rIxYG+fNXd+J12nTNUa6DI9kcIjTq4Y=;
 b=NDi2Zxtolt1lvH9cucbZs5od+FzluvprRj8XZqrAoJWPeyFO4v6OZhMrlh3qa+fpf0
 1FLAUwx1CEPGr/aww1oYh2aZYMl0laT/RdCOz95KW/prQ04o9Dr4Nmkhg81jf+U2iEmb
 zFXRv/rP+agSzjX//btHfWvIvDqXQFEk/PHlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927583; x=1783532383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iICKavTbrke5rIxYG+fNXd+J12nTNUa6DI9kcIjTq4Y=;
 b=DnDdR1vNPMKBYhfJ/2mMyfudBPyUovTtuAtBve4ESP45vouBLLWXAVUF5VdEvtLHiQ
 K94Kb6HHR3NlAcpOSsHP+7ae/Cd2yaygc81e8N+CXJgoltXCJWAXgED9kS4ZuI2FWzhX
 xsluol0mUjZq/kEYaR+bKY5FZCRKFCf6d6hq+LmDO86ox8gd5iUT4uqTEjkfwj1GHrw5
 jZryHDYgSmyYANuuknFp7GfEB0uwvex1TQOr2tJt9dclLLQ7/fCQ0H935FUim9EIk7fd
 Rs7yHRWSMLfNlONoN0weheNRnFu3R1YGWOlAa6Sh/n7EgVgpxk34VpH/nwDh8AjtHRUh
 e9Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x8Z4mceuTIMRO25Fnl8K5qYZ+73zqupm+H1LNHZwEENk7JDSAUPHxmfIkA9q0N3LoUOJ12pw=@lists.denx.de
X-Gm-Message-State: AOJu0YxVWCyY94smiA8vp/BrTcSBdx02PsiAUR0tbitzHpInogWPdpzZ
 jH1Gnp4BbeZDIykhWHl/B6u2D1aOozOGTEh17u9k9YNafNrniIp5m1EfTMzfgFg9g+w=
X-Gm-Gg: AfdE7ckLkoWiA65Zr2WHcimtoBAAyVsE1tqJU0T5DsxzK/FQbvKKCoM7qs+0RbFB4DR
 BXgO1p9eyAun+Tw0WTH//uUHf0zpaC7Z3V70wsVwcOpJlkDlG1ko+qzArHVbRWZdld4yydjphnv
 OeuzVb8WJkIkzWONQBuC0C7pwQsGJP2bmq7OXxXJuZ1sQP8ZET1W3luX94IL0JWojyhgBh/FyBL
 iLtDq7KaDkr2LJDwvOEMDFQW0URCZSEiU4MvW/KRy1ge7m8qJkRz0FlT6H1imd8UmTOr+qda72+
 h7Ap63+bKfv7mqnfNAM0XnUdP4O9+iFFbpy0eouuCvcmB2PJ/p8NiH6Kyl0r/LdhHqVmIqYL5EN
 WnPkowRsZNpqKE56fnQXfu/xbhzc1ZD1RobHmfA5+QJI4+QIukLJHoWPjfSLk7AhC7XPDG1abvl
 tvzji1++027DLL7CVm7IVWRNpoi2boEOKnVL9+FGWVMh5PgsyLRha8Ue94ZzMdyvi/Z8IsTKi7P
 RUUGlfbNYFOip7G306f9q57Zyq6snZ2v6p2LA==
X-Received: by 2002:a05:6830:710e:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7eb4cc4528bmr1701303a34.24.1782927583371; 
 Wed, 01 Jul 2026 10:39:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb544f3d24sm524807a34.21.2026.07.01.10.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:39:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:39:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/16] image: Take entry point as an output of
 setup_booti
Message-ID: <20260701173940.GN749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-4-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdOUo43RiMRSqjzn"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-4-me@ziyao.cc>
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


--TdOUo43RiMRSqjzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:17:55AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> For LoongArch the start of the image is not the entry
> point to the image.
>=20
> We refactor the code base to allow entry point to be
> supplied by setup_booti.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> Changed from v1
> - Correct type of "entry" argument for RISC-V and sandbox

Can you please also provide a link to
https://www.kernel.org/doc/html/latest/arch/loongarch/booting.html which
probably should cover this, but I'm not entirely sure does?

--=20
Tom

--TdOUo43RiMRSqjzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVQ2wAKCRAr4qD1Cr/k
ClOMAQDsXbgDPVhVvRAudoJDGMkZwd1Kgmh8FZgr8ay1hvr92AD/UvWXsoW03L/a
QkR+yrHYvC8K9keU0vdOdzq+WLv09Ak=
=0zVF
-----END PGP SIGNATURE-----

--TdOUo43RiMRSqjzn--
