Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13412C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AF78876D;
	Tue, 11 Jun 2024 23:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGjy5xx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C924288771; Tue, 11 Jun 2024 23:01:51 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E75D8839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b52b0d0dfeso3073548eaf.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718139708; x=1718744508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0jIGpiVFUcF5+nuR/QdKPw+qarACmsnqSaVMbp4weeg=;
 b=rGjy5xx1VI1NaqTzeydyEmJCBuVgLyOPeRejFKSx18hu1bW6+IQCkDR2hQ4vqOWmPn
 SRmTd6jP2FIk7sWLz+yPB95RVFx43n2axI3gqjBtdiOzgx3thVzQbxWbDA3kKdRioyVd
 VCTSAEECNfvUq8v4qHTDpNX6ytm4h5ELUxb0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718139708; x=1718744508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jIGpiVFUcF5+nuR/QdKPw+qarACmsnqSaVMbp4weeg=;
 b=nVLdfwZl/oLtTJUUrRLyy3YaCQ4ZYqZXsayPIJaeD6lqhbN8Ptk5eiTHWb9pgK6gy7
 wVnGsPHdgykX886mReFHdVljNWE4NRhR56eQE4vNDnfkncRkw1UAQHKdvD1k50j6VcEH
 akFh4JueUzCUgg7iJJV9JaBF3MDp66BQyJ1sLSe3v2a0YMfsKp90qdC4OQUSM+LHWW0F
 rJ0cqiRfSUZUe4/unmP6vRvKRbwq4dklP5gEl/rf3nMaIERflyukZSQdDSBv2qoIqIQE
 WrKFnAUUB+Vvek+cdRssPx3xsVKAw9iegbhauN+93a6epJRMwL0e39MWC+GkoYNMaq71
 VQEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrtlPeqRwn0yunKW6X9KByO5c9PooOJaUqJ+gLL2kgLf0+epEtMKRDX8J4RK9L1j2fhO1Q1ytnI9NCf4Pc/Rf2+mblUg==
X-Gm-Message-State: AOJu0YwV5MIUq77wxGcsigcPqaxsSC9JVY2m30C4byTh7NNIhbOk1wDF
 wx1UzU3tDXArgzUPcw3asVk5hlB03R3OetDxqN+j+oy2Ph+nBMOebsyxcnkymyk=
X-Google-Smtp-Source: AGHT+IEP0FjRiPHn4/fM07bhjwaMoN0I3UcjTvqFCNrVXZAYJik1T++4dXAD6NOa2DqL+Nk24PyzZA==
X-Received: by 2002:a05:6820:168e:b0:5bb:672:404d with SMTP id
 006d021491bc7-5bb067242a8mr6338436eaf.7.1718139707993; 
 Tue, 11 Jun 2024 14:01:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bb33adc67esm124542eaf.13.2024.06.11.14.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 14:01:47 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:01:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240611210145.GM68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P09aqfjzLnJOpwQ4"
Content-Disposition: inline
In-Reply-To: <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
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


--P09aqfjzLnJOpwQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:52:22PM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > With the move of the LMB structure to a persistent state, there is no
> > need to declare the variable locally, and pass it as part of the LMB
> > API's. Remove all local variable instances and change the API's
> > correspondingly.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  arch/arc/lib/cache.c                 |   4 +-
> >  arch/arm/lib/stack.c                 |   4 +-
> >  arch/arm/mach-apple/board.c          |  17 ++-
> >  arch/arm/mach-snapdragon/board.c     |  17 ++-
> >  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
> >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >  arch/m68k/lib/bootm.c                |   7 +-
> >  arch/microblaze/lib/bootm.c          |   4 +-
> >  arch/mips/lib/bootm.c                |   9 +-
> >  arch/nios2/lib/bootm.c               |   4 +-
> >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >  arch/powerpc/include/asm/mp.h        |   4 +-
> >  arch/powerpc/lib/bootm.c             |  14 +-
> >  arch/riscv/lib/bootm.c               |   4 +-
> >  arch/sh/lib/bootm.c                  |   4 +-
> >  arch/x86/lib/bootm.c                 |   4 +-
> >  arch/xtensa/lib/bootm.c              |   4 +-
> >  board/xilinx/common/board.c          |   7 +-
> >  boot/bootm.c                         |  26 ++--
> >  boot/bootm_os.c                      |   5 +-
> >  boot/image-board.c                   |  32 ++---
> >  boot/image-fdt.c                     |  29 ++---
> >  cmd/bdinfo.c                         |   6 +-
> >  cmd/booti.c                          |   2 +-
> >  cmd/bootz.c                          |   2 +-
> >  cmd/load.c                           |   7 +-
> >  drivers/iommu/apple_dart.c           |   7 +-
> >  drivers/iommu/sandbox_iommu.c        |  15 +--
> >  fs/fs.c                              |   7 +-
> >  include/image.h                      |  22 +---
> >  include/lmb.h                        |  39 +++---
> >  lib/lmb.c                            |  81 ++++++------
> >  net/tftp.c                           |   5 +-
> >  net/wget.c                           |   5 +-
> >  test/cmd/bdinfo.c                    |   2 +-
> >  test/lib/lmb.c                       | 187 +++++++++++++--------------
> >  36 files changed, 270 insertions(+), 333 deletions(-)
>=20
> This isn't necessary...and it will make things harder. You can have a
> global 'lmb' while still allowing passing a different pointer when
> needed.

There's only one reservation checking system and list of known
reservations, keep in mind.

--=20
Tom

--P09aqfjzLnJOpwQ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZouzkACgkQFHw5/5Y0
tyzBXgwAjNEsB1Pc3kDl1/W+M19bYZixYVjGxzterfR5yX5ZYSSHJJOh+UjNIFsb
4xmREUi9jOjObq+sqHp0dpNiNI2xrebzFGERjMpvpfCjZn5yfyc5bHulD9JaC6mU
QlCh8f/zusA49PClo2rigHnaGVyiH4cODp9pJM2KCxWylnqzjXC8qYneDXATp1k4
/uhYU5zWPYhuiGUk0jul92kn8VWhfVyE3Cn1Kbble+cgDE5sH69zEWLu/e9f7tgF
YkKkskNJdt05TPHquDl7Ny8CPBMt7MtA0Oa8w+ILJT1cbulFSfbpovmwIpprcOBS
1xf5WAA7eAVdPDs6dXlNI79EqsIBUi8j9Td8s76Q+akcytBPWME0VHkgz9bDP0Gs
rK2vTXj+2AhdxkqBG8oIlcBKOYjJWRhfMpShUHonFqW1zig6xjREZOAfnvovWGCl
Kix/YnrosVzLWbkqzYUU3yuUffCzOnxHE8U4m5We2BMYai6OARd9RqMhXuInyJmq
upqZQQcZ
=wgRO
-----END PGP SIGNATURE-----

--P09aqfjzLnJOpwQ4--
