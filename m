Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA60C27C77
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189A7882D6;
	Wed, 12 Jun 2024 00:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gwVjmjBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269FE88286; Wed, 12 Jun 2024 00:09:11 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A985882D6
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dfaf512483dso1675833276.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718143747; x=1718748547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hm/YKqOk9x15PwsmMgqOKTGWaoLNMXa+S9bcCXrdt+0=;
 b=gwVjmjBkGwnZx+4s7ZLnnpsE8GJGde05Yh+9zGqGlkIX3s5qnUTpZkAeXN9byQttep
 nc4efBcs4QkKwxGptP3QG6HM4jr6Af45DoKnN3nwpGulOJxzOeu2F0c3e9MUA/aHvYUk
 H7xYzHWRwryA+QPksZxXjEqld6oiixefOyQvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718143747; x=1718748547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hm/YKqOk9x15PwsmMgqOKTGWaoLNMXa+S9bcCXrdt+0=;
 b=u/l03CvKSxrsm5ubT4akMFSUCejS44OuvtyreeBfWHKNG5qmVHWRpXoJtBdNg0pi8P
 k+aRXgYrpSWJetzJS5xdi9v9RXYI5WZ28BELbWwGCG/dYFO0MxErrPcxjaXkHv1OQwl/
 PCFg7t404dSEIETAIuvF4O06nVm861mHI51Y5UBjqmFGMMlUnbuqrm9bXL8VMCtl0UhX
 ds4kjoMQiI6BxuDhqsBhTlMuok39N8X2WtEOKBx5vhe1+nm8v2rckLbBbu/HCzJi0TC/
 XfrNhAf0h92M1wMyUmqtUDOHV27DUSiMrUK0XtwJF9hsIr3vcRRNWT5FBhWRsDwXDtf9
 BNxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSaDHr+04dRHRwEHYyqHqQXFx0T1scTfMCFO+Jw+jMa1mOIv8Er+55FQ56cK67C7K0CC/iLTe6ULu5vjDiDUXVq2VTHw==
X-Gm-Message-State: AOJu0YyeO+pQBwcd8XL88Mtw4I5l9QLVGBxMAtaVdOj6Few6grxLA602
 Nn8Y/q79WDkRP+rAjXh/qaX1LZ0QLAa6lJol1DmRwyoi5+nKDe7LMZ2Or0N6+zP6tFm+av4c2Ng
 +hvwygZA/A+FiYC40x3kdBNnpSlR+Rc91soHQ
X-Google-Smtp-Source: AGHT+IHc0Dwjua9jEDlzeFwWoDJyuIMORp7B7B6EffrY3i92mLT09fL0nXfbMwstjRPRcjmP5HXNQrzvHkRSeSiaWF0=
X-Received: by 2002:a25:7143:0:b0:dfb:af5:8500 with SMTP id
 3f1490d57ef6-dfe6715b38bmr30095276.37.1718143747051; Tue, 11 Jun 2024
 15:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
In-Reply-To: <20240611210145.GM68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 16:08:56 -0600
Message-ID: <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

Hi Tom,

On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 12:52:22PM -0600, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > With the move of the LMB structure to a persistent state, there is no
> > > need to declare the variable locally, and pass it as part of the LMB
> > > API's. Remove all local variable instances and change the API's
> > > correspondingly.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  arch/arc/lib/cache.c                 |   4 +-
> > >  arch/arm/lib/stack.c                 |   4 +-
> > >  arch/arm/mach-apple/board.c          |  17 ++-
> > >  arch/arm/mach-snapdragon/board.c     |  17 ++-
> > >  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
> > >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> > >  arch/m68k/lib/bootm.c                |   7 +-
> > >  arch/microblaze/lib/bootm.c          |   4 +-
> > >  arch/mips/lib/bootm.c                |   9 +-
> > >  arch/nios2/lib/bootm.c               |   4 +-
> > >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> > >  arch/powerpc/include/asm/mp.h        |   4 +-
> > >  arch/powerpc/lib/bootm.c             |  14 +-
> > >  arch/riscv/lib/bootm.c               |   4 +-
> > >  arch/sh/lib/bootm.c                  |   4 +-
> > >  arch/x86/lib/bootm.c                 |   4 +-
> > >  arch/xtensa/lib/bootm.c              |   4 +-
> > >  board/xilinx/common/board.c          |   7 +-
> > >  boot/bootm.c                         |  26 ++--
> > >  boot/bootm_os.c                      |   5 +-
> > >  boot/image-board.c                   |  32 ++---
> > >  boot/image-fdt.c                     |  29 ++---
> > >  cmd/bdinfo.c                         |   6 +-
> > >  cmd/booti.c                          |   2 +-
> > >  cmd/bootz.c                          |   2 +-
> > >  cmd/load.c                           |   7 +-
> > >  drivers/iommu/apple_dart.c           |   7 +-
> > >  drivers/iommu/sandbox_iommu.c        |  15 +--
> > >  fs/fs.c                              |   7 +-
> > >  include/image.h                      |  22 +---
> > >  include/lmb.h                        |  39 +++---
> > >  lib/lmb.c                            |  81 ++++++------
> > >  net/tftp.c                           |   5 +-
> > >  net/wget.c                           |   5 +-
> > >  test/cmd/bdinfo.c                    |   2 +-
> > >  test/lib/lmb.c                       | 187 +++++++++++++--------------
> > >  36 files changed, 270 insertions(+), 333 deletions(-)
> >
> > This isn't necessary...and it will make things harder. You can have a
> > global 'lmb' while still allowing passing a different pointer when
> > needed.
>
> There's only one reservation checking system and list of known
> reservations, keep in mind.

There is only one driver model, too, but we use a pointer. It makes
tests much easier.

In fact I see elsewhere in this series that it causes problems with
tests. Best to use a pointer so it is easy to update.

Regards,
Simon
