Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CEFC27C78
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58F288739;
	Wed, 12 Jun 2024 00:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HEKUW00N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B888588655; Wed, 12 Jun 2024 00:56:02 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E26888788
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d22a32bef8so185662b6e.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718146558; x=1718751358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c/Rh/+QCVOy4DpX+yJ1655CaEh65a+/9CU2iCiU/3Hk=;
 b=HEKUW00NvqdgM2hhxTzfMmPtm1zIPrIRRKryY5tsSonIkzqNHmU6JcA4FXjoPtk1aC
 upKZeexe6xQK40paRrQe/GqL27DsvTPN1oyLbxPJw5jxXzwCystk7oV8TaCzPOVQLcjP
 lJXWzFwm8fvrHi2YMtj4LywJQ5NNDFC7yU+rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718146558; x=1718751358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/Rh/+QCVOy4DpX+yJ1655CaEh65a+/9CU2iCiU/3Hk=;
 b=Fg96X9EovdNESZk1NokwyVqjh/G9qBOpDpdq3+cUbhWgvD56QV0pwaBBcC2EgRMBd5
 xGMx/Jg94fR5wAygGZPp7ddxdSGxg3slSQMVo85XMicIQxMBYspQuWyivnU5soZEV3N7
 XmLdNhEnUoNK30Xut7jnvYqKM8KorrGtjdJeVMv+pwL8Q3U0zOoM1TgYRn7VvKOWvShj
 pg7Y1c5LKR0gxvTOfIxl+h7ML4KQqIs6fzgBKRHgQJuYVgC5LuBSY2O9LhDzRTv6OhxI
 CeORcviWN7rWP/i5AYSZdzL28VS8ATcuSVTl6/ZKGVC5GpgqZ09NZWir4njLIsUGGoMI
 FCCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdteSCHCN7D2dx1H0zb75sk+lW3PMa7KkVDW02qt9DgA8sWiKNIBC+ZW/SWEo6paRWgO8kgaqwlHuq438t9snOQxeilw==
X-Gm-Message-State: AOJu0Yz0B7RsyKqYCnMYQ5kIWskM+/GC3wz/Elr23hIaElHjiH8TaQN4
 kS5+e8JTG9Z2KfYoXrO5l0hNokK8Ya8gJtlWUt0nXBVm03RPwykkMYgE+YMNjZY=
X-Google-Smtp-Source: AGHT+IEdUftGb9+VwNfuofNNMQ+9sXdLXB2Ne/I9DTpYVhwok+aOucvGQvGQOYooPHu7D6K0wueaoQ==
X-Received: by 2002:a05:6808:1b2a:b0:3d2:16a:2002 with SMTP id
 5614622812f47-3d23460d95dmr1616657b6e.2.1718146558083; 
 Tue, 11 Jun 2024 15:55:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f98dc069f0sm1317235a34.48.2024.06.11.15.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 15:55:57 -0700 (PDT)
Date: Tue, 11 Jun 2024 16:55:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240611225554.GO68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EqS+7P6jJqAib7+B"
Content-Disposition: inline
In-Reply-To: <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
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


--EqS+7P6jJqAib7+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 04:08:56PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 12:52:22PM -0600, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> w=
rote:
> > > >
> > > > With the move of the LMB structure to a persistent state, there is =
no
> > > > need to declare the variable locally, and pass it as part of the LMB
> > > > API's. Remove all local variable instances and change the API's
> > > > correspondingly.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  arch/arc/lib/cache.c                 |   4 +-
> > > >  arch/arm/lib/stack.c                 |   4 +-
> > > >  arch/arm/mach-apple/board.c          |  17 ++-
> > > >  arch/arm/mach-snapdragon/board.c     |  17 ++-
> > > >  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
> > > >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> > > >  arch/m68k/lib/bootm.c                |   7 +-
> > > >  arch/microblaze/lib/bootm.c          |   4 +-
> > > >  arch/mips/lib/bootm.c                |   9 +-
> > > >  arch/nios2/lib/bootm.c               |   4 +-
> > > >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> > > >  arch/powerpc/include/asm/mp.h        |   4 +-
> > > >  arch/powerpc/lib/bootm.c             |  14 +-
> > > >  arch/riscv/lib/bootm.c               |   4 +-
> > > >  arch/sh/lib/bootm.c                  |   4 +-
> > > >  arch/x86/lib/bootm.c                 |   4 +-
> > > >  arch/xtensa/lib/bootm.c              |   4 +-
> > > >  board/xilinx/common/board.c          |   7 +-
> > > >  boot/bootm.c                         |  26 ++--
> > > >  boot/bootm_os.c                      |   5 +-
> > > >  boot/image-board.c                   |  32 ++---
> > > >  boot/image-fdt.c                     |  29 ++---
> > > >  cmd/bdinfo.c                         |   6 +-
> > > >  cmd/booti.c                          |   2 +-
> > > >  cmd/bootz.c                          |   2 +-
> > > >  cmd/load.c                           |   7 +-
> > > >  drivers/iommu/apple_dart.c           |   7 +-
> > > >  drivers/iommu/sandbox_iommu.c        |  15 +--
> > > >  fs/fs.c                              |   7 +-
> > > >  include/image.h                      |  22 +---
> > > >  include/lmb.h                        |  39 +++---
> > > >  lib/lmb.c                            |  81 ++++++------
> > > >  net/tftp.c                           |   5 +-
> > > >  net/wget.c                           |   5 +-
> > > >  test/cmd/bdinfo.c                    |   2 +-
> > > >  test/lib/lmb.c                       | 187 +++++++++++++----------=
----
> > > >  36 files changed, 270 insertions(+), 333 deletions(-)
> > >
> > > This isn't necessary...and it will make things harder. You can have a
> > > global 'lmb' while still allowing passing a different pointer when
> > > needed.
> >
> > There's only one reservation checking system and list of known
> > reservations, keep in mind.
>=20
> There is only one driver model, too, but we use a pointer. It makes
> tests much easier.
>=20
> In fact I see elsewhere in this series that it causes problems with
> tests. Best to use a pointer so it is easy to update.

Maybe? I worry that will lead to thinking that we still, like today,
have many LMB lists, rather than a single LMB list that everyone must
use.

--=20
Tom

--EqS+7P6jJqAib7+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZo1foACgkQFHw5/5Y0
tyzp9gv+Im31Hn/urMzZXfCBEEF1eBsejtRBJu9eX+OQAK/R6ct+Sr9eSD0F52Ze
ftVb0X5MtVhGhdwTkbsVKOT1Oz5/Fiys1fo7f4CslgTKTjIcU4TcOc5K8sFUJ0kw
H46jEsA7VpO3MnjWCbEAyTVDiqxXpn/z5yWycWhwwJ7TinPyR+uRX3IijpILeJUj
tT+wVg4OkZD+hMFu04dJ+0L70Qe8veOR63UpHwCSH9JhEAQ+7v17HKFAqSzkvHxs
sr33un88dcNAb76nhx6D+ujQCMU3m3vwZAmODQoH3/cX8x3eoAmmfZvfgMed/yfN
EBFpdu+bYaDmLpaLhVtIeNQVo9U7DedA6LI1tlzQtV2RhhuYUBSlL4LaFsmhJSlu
wmA5b9eYhCKD0shH+OD3TaptKr/2zO4QY/rJOXxXB2HqjEM9E+rCrntdrwo4h6V+
6sPdtysyh6qQyWfZkE3cWhTmZ78L4h0wNvaWD00hxDJwMqQtLzr6nNcSZsxm+XIg
uofLlh0L
=JbrF
-----END PGP SIGNATURE-----

--EqS+7P6jJqAib7+B--
