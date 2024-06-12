Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB95C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 05:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C85E886F0;
	Wed, 12 Jun 2024 07:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EEkNuk7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C4588757; Wed, 12 Jun 2024 07:42:35 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524AC8839D
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 07:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f70509b811so24304565ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718170952; x=1718775752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TMpmxUnXbHL2HW6QyzddQW4rsyq42S8ZTH2WFPmGIFA=;
 b=EEkNuk7W98X25ZLe/d6sEL05vLY/bYXtgJcjpw7NC9PRzXz/uV83qF8HCty1LjbbSU
 u219qT3MUAuWu+bcseH2rPN+bODVaNymV0gJFlPYFiny3kP4C4pNBhLzLpeODdBJpL3U
 l426Ss0UmS7to02caslgGgXGOaukS+/cWscBcFRI/srBsXpEAg4tse3oB+wPIHdLpU10
 CrcMo9swCmZSdW/V76EfTADtTgDG5khpOi0lWglc1gnG2H9ppMsoZKLxnD8hX/H5pvT6
 5nkKGnb7JwWqyEIVsnb3PpHYgI53qxdmfU7aW23tln70ZV2E0+rGnEC6QwBRG1YQ0cQH
 dkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718170952; x=1718775752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TMpmxUnXbHL2HW6QyzddQW4rsyq42S8ZTH2WFPmGIFA=;
 b=S8K/HbZyyLBsjrTN9jTk4XRDvBCaiwbog3dLtpUYvcCh9sdu48SQy8lsjwfZ32s/mi
 vWRbtK0Ff/P+wK2zftoFoMwJ02b3+39KrRUnFamkuEXkgSm7QpDLnunAsQkKryPloAEA
 KYAY/Q5zzBf47oGyRkpF1pvP4Utw3n+z3b2cWf4onvRvMmPTKnyCz46JzhzoSY8D2qVC
 ev5ez4ILGsXgF746ZOufWpxzqZ2n/VfwuaGnWcwb1ZqydhLv6+vj+HagDvgNP6VMsTf0
 +qX3eOnv/iV/4OZsxyrywaI6NcAIijpwXjNiQO8xgeYTJ90j+MmkK2HImbugttCHaKaj
 sUEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAqdzuXqPi1UoRH4osKLLa+odZoQ2/eF85ANCl7GTzr4QuRNtgcWKGzYueWDivPJqR2cQkkKcDFbw/aj83hsTPIB6q/w==
X-Gm-Message-State: AOJu0Yw5o5p38CkMzl2HntyY7UhvYdBL0ZciQvPUC5j/TmNwLDenU0w7
 VdDWc7783fLsqYGS92M/75ocuodBDwyKhsyiQFQXTsBIM9xfPIhIHNEfMOaozkfPQ11QIqZl/Z9
 RaT5doHs+H3hCb0N8p7J3FUaChHNx3gI313D7UA==
X-Google-Smtp-Source: AGHT+IH4DlV79tT49EGw5ySm2Bw/LRc87NJwML36rz9bH9NimexDV7YHCmorGWuYbBqT/nCT2LRLJC3oU/ak7nz3f0s=
X-Received: by 2002:a17:902:a511:b0:1f7:3a5b:2ed with SMTP id
 d9443c01a7336-1f83b60eb11mr8174465ad.26.1718170951752; Tue, 11 Jun 2024
 22:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
In-Reply-To: <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 08:41:55 +0300
Message-ID: <CAC_iWjJDmBiW0wfjiCqoM=4RW_uvzM=+MxC8fiij70BAnX3FuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 12 Jun 2024 at 05:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 11 Jun 2024 at 16:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 04:08:56PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 11, 2024 at 12:52:22PM -0600, Simon Glass wrote:
> > > > > Hi Sughosh,
> > > > >
> > > > > On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > With the move of the LMB structure to a persistent state, there is no
> > > > > > need to declare the variable locally, and pass it as part of the LMB
> > > > > > API's. Remove all local variable instances and change the API's
> > > > > > correspondingly.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >  arch/arc/lib/cache.c                 |   4 +-
> > > > > >  arch/arm/lib/stack.c                 |   4 +-
> > > > > >  arch/arm/mach-apple/board.c          |  17 ++-
> > > > > >  arch/arm/mach-snapdragon/board.c     |  17 ++-
> > > > > >  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
> > > > > >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> > > > > >  arch/m68k/lib/bootm.c                |   7 +-
> > > > > >  arch/microblaze/lib/bootm.c          |   4 +-
> > > > > >  arch/mips/lib/bootm.c                |   9 +-
> > > > > >  arch/nios2/lib/bootm.c               |   4 +-
> > > > > >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> > > > > >  arch/powerpc/include/asm/mp.h        |   4 +-
> > > > > >  arch/powerpc/lib/bootm.c             |  14 +-
> > > > > >  arch/riscv/lib/bootm.c               |   4 +-
> > > > > >  arch/sh/lib/bootm.c                  |   4 +-
> > > > > >  arch/x86/lib/bootm.c                 |   4 +-
> > > > > >  arch/xtensa/lib/bootm.c              |   4 +-
> > > > > >  board/xilinx/common/board.c          |   7 +-
> > > > > >  boot/bootm.c                         |  26 ++--
> > > > > >  boot/bootm_os.c                      |   5 +-
> > > > > >  boot/image-board.c                   |  32 ++---
> > > > > >  boot/image-fdt.c                     |  29 ++---
> > > > > >  cmd/bdinfo.c                         |   6 +-
> > > > > >  cmd/booti.c                          |   2 +-
> > > > > >  cmd/bootz.c                          |   2 +-
> > > > > >  cmd/load.c                           |   7 +-
> > > > > >  drivers/iommu/apple_dart.c           |   7 +-
> > > > > >  drivers/iommu/sandbox_iommu.c        |  15 +--
> > > > > >  fs/fs.c                              |   7 +-
> > > > > >  include/image.h                      |  22 +---
> > > > > >  include/lmb.h                        |  39 +++---
> > > > > >  lib/lmb.c                            |  81 ++++++------
> > > > > >  net/tftp.c                           |   5 +-
> > > > > >  net/wget.c                           |   5 +-
> > > > > >  test/cmd/bdinfo.c                    |   2 +-
> > > > > >  test/lib/lmb.c                       | 187 +++++++++++++--------------
> > > > > >  36 files changed, 270 insertions(+), 333 deletions(-)
> > > > >
> > > > > This isn't necessary...and it will make things harder. You can have a
> > > > > global 'lmb' while still allowing passing a different pointer when
> > > > > needed.
> > > >
> > > > There's only one reservation checking system and list of known
> > > > reservations, keep in mind.
> > >
> > > There is only one driver model, too, but we use a pointer. It makes
> > > tests much easier.
> > >
> > > In fact I see elsewhere in this series that it causes problems with
> > > tests. Best to use a pointer so it is easy to update.

I don't mind keeping it, but OTOH we are fundamentally changing how
lmb works, do we need to expose a ptr to make tests easier? We should
be aiming for code that is more readable and easier to maintain.
Isn't it better to just rewrite the tests replicating the existing
cases & add new potential ones?

> >
> > Maybe? I worry that will lead to thinking that we still, like today,
> > have many LMB lists, rather than a single LMB list that everyone must
> > use.
>
> Do people worry about that with driver model?
>
> Also IMO there is only really one LMB list today. We create it at the
> start of bootm and then it is done when we boot. The file-loading
> stuff is what makes all this confusing...and with bootstd that is
> under control as well.
>
> At lot of this effort seems to be about dealing with random scripts
> which load things. We want to make sure we complain if something
> overlaps. But we should be making the bootstd case work nicely and
> doing things within that framework. Also EFI sort-of has its own
> thing, which it is very-much in control of.
>

I agree that things should be nicely integrated in bootstd, but does
keeping a ptr as an argument help with that ?

> Overall I think this is a bit more subtle that just combining allocators.

Regards
/Ilias
>
> Regards,
> Simon
