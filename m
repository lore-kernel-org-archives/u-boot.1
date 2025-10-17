Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B602ACCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 22:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CC983835;
	Sat, 18 Oct 2025 00:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AcxdrEbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B3983837; Sat, 18 Oct 2025 00:08:23 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0333E8382E
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 00:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-443a7490a54so658080b6e.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760738900; x=1761343700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vY6qCCRYSDyOU27vHXzaQ2UFBOIORBhQ8PPu/+zA55g=;
 b=AcxdrEbFGuVaWsLLSrgU+m18oodZtCg/MhPSi23BkQUQrKf2siEJTN7eY/slxVqVwt
 UzI2Kr3C9rgFw9VhOx8mpfMb6Pu6J8RSjsCmc0V6+LUwZ/Y7DuTExIWcMcTKDoGaJ12p
 is8ne7uo0PR6MuML9NdgCRKYHvA6Kuauu2gvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760738900; x=1761343700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vY6qCCRYSDyOU27vHXzaQ2UFBOIORBhQ8PPu/+zA55g=;
 b=hgXkCJC0YqGtsH1C/eh01FYxStSqTfCpqwCsI7TvwhlCUA8TfepC1K4jJ5ds6t0ZpI
 Wn8Cv47khVMXWVlMe4qE77pNKYFmUIa6MpLmQoI3MK79KKWSmEjuzv+CieMt90IKBksp
 OursxlJ09imXXn9ZywLuWhVtFAVPrwNbMHnt1dmwJFpVBI5GZCPuNOZiXrQB50zwg/9J
 E6ROC0yWY91VFUMrUe7gDcCJxCNF2oVA6aZp+RoxrSwH4xUtgQXauHcQOlll5R4O4LGI
 N2yO7Qs0BqTZf3YMX2Jbi0IrGCb9EyXGuJu1GoIYJYFa/orPifRXAZECOielyKlNKowq
 Omuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzFzXTd0/ZU+oSgUHH3WzDTL0dP6xGgsgbhzS9HqCynb5GhFKQBykJuW/5cDhdoKGffaJAsQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwXkmvBO2UiGC5Xh3idMZdwHfeOJUts6uVJDp2CbP2FSYVyvuQy
 KZJMUP8HOMwvGGHsvCfLsQ3X8r278fgJhINULJMQyx30c0vOUTl9WY9zC0rZbpLdCk4=
X-Gm-Gg: ASbGncurw6vOLsE/fslUdfTHZYyLvq56wJZ6cF8o1xa4c2L4UT6ct0qs/ZnrKZ39GBJ
 kmQJlZM/E5BY5EdbO9dNUZ/5o0wJJy0gWC9m+rvYtbyJGAusB/Q9mvWP6JahXIqsJxIlskPF3qK
 niZD/M5ZtVaYeuCvxLFOd/ZONJFBchGlKrKjeQsn28STPCk0itQ5wugrOpLxqKsfBoqvlB4M6Gf
 9zRv9uKwlzXx5AYJY3pl6qt4xEXO30RRYvr/mJcc7+ykpsssd9dqVc6aJ6eTaNI3K2Tl4KtXk1L
 trbOW0n5Pyv1PXL+mhiVWtyUMTW6X2cmdTYMPn0/L2W3C0tomHLm3nzykrPb4d231Fc9GUrrFeH
 3lRA81HYmrn+EiD9WIry11RxwAoWQPMI9TZduG3/yv9Qx7l/orYrwypHoWJjkNJjGenQAC4jzYs
 UYwmPK06CB940ReCNkk6yKy6avYUuRhQTvyRrly4ONpN8s9oaEoQ==
X-Google-Smtp-Source: AGHT+IG1DKUy6Ys3fQTRHw+XWy43Xc8/phnDZMkNnyocAhLKfickvNZwTJPAEZjUApl+sVqhboEboA==
X-Received: by 2002:a05:6808:1a23:b0:43f:7287:a5ca with SMTP id
 5614622812f47-443a30d31c9mr2206801b6e.43.1760738899752; 
 Fri, 17 Oct 2025 15:08:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4d5653sm186083b6e.1.2025.10.17.15.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 15:08:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:08:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org,
 tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Message-ID: <20251017220816.GL6688@bill-the-cat>
References: <20250529150213.27149-1-richard@nod.at>
 <10664479.lqRGMn8q6B@nailgun> <20251003210149.GA6093@bill-the-cat>
 <5561663.0HT0TaD9VG@nailgun>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9jRrpeJGWZrvuGIl"
Content-Disposition: inline
In-Reply-To: <5561663.0HT0TaD9VG@nailgun>
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


--9jRrpeJGWZrvuGIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 10:05:43AM +0200, Richard Weinberger wrote:
> On Freitag, 3. Oktober 2025 23:01 Tom Rini wrote:
> > > My current way to work around the problem is having these commands in
> > > my U-Boot scripts:
> > >=20
> > > fdt addr $fdt_addr
> > > fdt rm /chosen linux,initrd-start
> > > fdt rm /chosen linux,initrd-end
> >=20
> > I do wonder if the best path forward is adding some opt-in CONFIG option
> > here?
>=20
> Hm, yes. Maybe something like CONFIG_FDT_INITRD_EXPLIZIT which is enabled
> by default for the RPi target?

That's probably as good a name as any, yes.

--=20
Tom

--9jRrpeJGWZrvuGIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPK+UAAKCRAr4qD1Cr/k
ChHUAQCsT2eI4GKpA3buCoc/Oll4O6V/Gw+XpNAFaf4QChJPCQEAx8XrxwZJt1Ql
8WeEf4RQv8aLXb1KyKBjg/4unpzQ0Ak=
=Ymkq
-----END PGP SIGNATURE-----

--9jRrpeJGWZrvuGIl--
