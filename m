Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEBFCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 20:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257B786E65;
	Fri, 13 Oct 2023 22:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fmXoz5go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40AC86ECB; Fri, 13 Oct 2023 22:56:47 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C806B869CA
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 22:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7af45084eso33080887b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697230513; x=1697835313; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LE6FkncOecPyNf5VrGnlrplD6V+34etAK6lIMu3BnoY=;
 b=fmXoz5goQ+NFftCWyG057xr6GHw8+eTW5oQ1Gul8aSgkvcQRHXynE9FU0yWiTp9l0E
 bzxG7TTT98b0d+CZ60g3psG03lXGNtKQzfXCfJMu8r9MQaQUQKEu6e1CW2N2/k68qhsH
 cePQOCrDlKP1/7mcNo+uiQIebQSJ6WorEAgNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697230513; x=1697835313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE6FkncOecPyNf5VrGnlrplD6V+34etAK6lIMu3BnoY=;
 b=DWvsy9qe8u5P3j7c5S328fXEzbeatpWtOgK+W/iWABwSCIBgBbehJ4E+6oCoTyX3Nf
 Gjjpa4MaL6bvY4K3Cl2StTc8I1TeAU+8EOBSLm5wVwyka8QHdmeT9LpsgI7ZWnjlDAuz
 j+bBcDEclu7cqSh5UV7REA/HCzQyg7cn1AhXPRU4chgG2TtjVhNszHuKnDes5R6qJ7am
 gJwuSrhIby7f4fe1OjhpudkK6WBvRkOGUfBFZWBm39fgo7H75bCgJ3ghQE+WbrkbCbD8
 b5ZqOa4Gktm9/0hhuc+Ke+MHU1m6W3tV/dZHBE4zMbqGHO75UXwl7v6s25hqfVTo52BH
 lElQ==
X-Gm-Message-State: AOJu0YyJIFZ5LZjXssQu7KH/KF9j5TjhccgoCPfruG+RuS7qxBVy07y/
 jW+kKFGZx9bAV9aZa/NbmKsL2A==
X-Google-Smtp-Source: AGHT+IEeUo3nNQ3RDzlBJqcfbD0OA6vXgf0dUmpnag8XsdUomJphutQkWxXQPPRDBEjFfj6SE2mogw==
X-Received: by 2002:a0d:d5c1:0:b0:5a8:1ffe:eb4e with SMTP id
 x184-20020a0dd5c1000000b005a81ffeeb4emr2883859ywd.34.1697230512668; 
 Fri, 13 Oct 2023 13:55:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 x65-20020a817c44000000b0059b1f6d1959sm43102ywc.101.2023.10.13.13.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 13:55:12 -0700 (PDT)
Date: Fri, 13 Oct 2023 16:55:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
Message-ID: <20231013205510.GV3119521@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
 <4e4779f8-ddbc-6469-6c9c-a42751f2c9cc@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RExrfe/Y7M+5ff65"
Content-Disposition: inline
In-Reply-To: <4e4779f8-ddbc-6469-6c9c-a42751f2c9cc@kernel-space.org>
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


--RExrfe/Y7M+5ff65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 10:53:04PM +0200, Angelo Dureghello wrote:
> Hi Tom,
>=20
>=20
> On 13/10/23 1:03 AM, Tom Rini wrote:
> > We can remove common.h from most cases of the code here, and only a few
> > places need an additional header instead.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > ---
> >   arch/m68k/cpu/mcf523x/cpu.c         | 1 -
> >   arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
> >   arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
> >   arch/m68k/cpu/mcf523x/speed.c       | 1 -
> >   arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
> >   arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
> >   arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
> >   arch/m68k/cpu/mcf52x2/speed.c       | 1 -
> >   arch/m68k/cpu/mcf530x/cpu.c         | 1 -
> >   arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
> >   arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
> >   arch/m68k/cpu/mcf530x/speed.c       | 1 -
> >   arch/m68k/cpu/mcf532x/cpu.c         | 1 -
> >   arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
> >   arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
> >   arch/m68k/cpu/mcf532x/speed.c       | 1 -
> >   arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
> >   arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
> >   arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
> >   arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
> >   arch/m68k/cpu/mcf5445x/speed.c      | 1 -
> >   arch/m68k/cpu/mcf5445x/start.S      | 1 -
> >   arch/m68k/include/asm/immap.h       | 1 +
> >   arch/m68k/include/asm/immap_520x.h  | 1 +
> >   arch/m68k/include/asm/immap_5235.h  | 1 +
> >   arch/m68k/include/asm/immap_5272.h  | 1 +
> >   arch/m68k/include/asm/immap_5275.h  | 1 +
> >   arch/m68k/include/asm/immap_5282.h  | 1 +
> >   arch/m68k/include/asm/immap_5301x.h | 1 +
> >   arch/m68k/include/asm/immap_5307.h  | 2 ++
> >   arch/m68k/include/asm/immap_5329.h  | 1 +
> >   arch/m68k/include/asm/immap_5441x.h | 1 +
> >   arch/m68k/lib/bdinfo.c              | 3 ++-
> >   arch/m68k/lib/bootm.c               | 1 -
> >   arch/m68k/lib/cache.c               | 2 +-
> >   arch/m68k/lib/fec.c                 | 2 +-
> >   arch/m68k/lib/interrupts.c          | 2 +-
> >   arch/m68k/lib/time.c                | 1 -
> >   arch/m68k/lib/traps.c               | 1 -
> >   39 files changed, 17 insertions(+), 30 deletions(-)
> >=20
>=20
> building for mcf5307 i get this error
>=20
> In file included from arch/m68k/lib/bootm.c:7:
> include/bootstage.h:225:1: error: unknown type name 'ulong'; did you mean
> 'long'?
>   225 | ulong timer_get_boot_us(void);
>       | ^~~~~

Did you apply the whole series?  The first few patches fix some global
issues.

--=20
Tom

--RExrfe/Y7M+5ff65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUprqcACgkQFHw5/5Y0
tyxj3wwAjFGZE5q5C1M1bWYVq81gKKdtfeKRkRq0dFaJZw+LbfiCETy83eurOPGR
ceBql0RttVDZoTwb91i/qluxnbDxLOn2L+1j5D6P/GjQZiXYW/T57WnZFRnVfMGT
D6wMbwI/quzgYNsqPwiz6hUlO2fz0wXyAkyD/PBFDCbcgKYcDUxUvktW8ESFwwtm
OcEYRkFEyFkPjiSOmvqhRXfUWVK3NsK0VGnC3ngAzRtWw45becWJyKADRzPjTks+
OS20elNbljvFapQ8ViJOx5ATE0s1nIx4bNZW8di8xVDuT8mjj5mZjCVu0YNMQ9cu
zDfO462VseGiWn309aBHdiWWjCcMCZ2vHiOKHB2inmv1LFSuLO92z0p3bb4rslat
UADu79V4tjhqycjPW1D9Eq+K1imcx1pXoGcAnw+3b39pWEIMsmU9vwFb89LPAjLj
P2pj/R/jtEkHrAl7sXT8Aa44UAvYHR3UVYMXG4Hn6ORH3ZE8XKrNELYBNHSst/Ls
HJ1oWNks
=0kIs
-----END PGP SIGNATURE-----

--RExrfe/Y7M+5ff65--
