Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F64C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D9D88951;
	Wed, 31 Jul 2024 08:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nKv7Y5Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3661E8890F; Wed, 31 Jul 2024 08:26:18 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C9488951
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a91cdcc78so324405366b.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722407175; x=1723011975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p2xO8eGdlOBypBOD/gnizWFYdfcAnS2zmUOeY+ZdKfo=;
 b=nKv7Y5JbrTAWOCPX7iQk2cv/BnNSeyb/QKayBEUiYGHP1M8qhuZEEfUHMA/kntrLc8
 xTfCP/TwAop8YNtXj6LrhB2kXK72BjE+7Vwu3sEmClVlbKCOYwJVg4LqJmYgd22nhFdJ
 xqPdpTXfyBKi2CO45ISl5/OtNAMu4lzLUNp1ei9z3FXY0OFWGSZaBZ36glC+1HTTN3lT
 K9nqc1o233KoScI6P11P/k3420Oq9+9SPomsJstx+xqozkbxXQOrg1Fqd1rSd9JZIsx/
 SA15UY5rZdpli+fVFfr0rl/f7ipHnJcq/6fuu0jYpFu89tHf1fbmj0AdSZ76nT1akaJL
 02kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722407175; x=1723011975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2xO8eGdlOBypBOD/gnizWFYdfcAnS2zmUOeY+ZdKfo=;
 b=PwPZ7SerYQJJEdCdNpHO0lIvs8D+JlbZODOKWoVxclDaruB2vQ6Y7l078OPimJOb2V
 ocGgZESZ7F8sirECBdyFPJNqVKw1Zi3VWae8Ing7OhtqOFK9ePX7K1VD5aducefS5Wiq
 mghUS/ec7k7NXg+DpanC62Wro/5Wj1iGW1KuX4oPtcm+wrcD44+uVg3quU5b6Ml+aZ6N
 J8m6aWCnogd2RfLEfPjIn5eK6YDarnM1hjePEuoUi6rotCb6aMyPx/vyEaVSJ/zrNkjt
 6oxJK26MWzJbbjr9Y1V7jWnXKAscVa3GbF1OJmCJFgUxXXU1wyRTIkfDwvJ1rTTURL1P
 E75A==
X-Gm-Message-State: AOJu0YxzT1KgwTJcx8EgS++moT6gxk8Q6y1APIpghaL76l2yYK8XFVF5
 XuoKM9nE8IKjUG+YF9RulYYPZzWe0RfEVeu3qGUY69PMBssBcKxxyI04aBTzAu+hL9i6AN4YjeC
 xXphqVlCR4RVswgiLoZL+b/HTyM0bboOKtXBchQ==
X-Google-Smtp-Source: AGHT+IElbX9FwpeFtItZiL/hNISeOz0T959r5cBdDO/dxPsquo468KtNS66/gayAlN8M3u84HMy2Qr8eCLH28q0sSjk=
X-Received: by 2002:a50:8d57:0:b0:5a1:71b2:e9bd with SMTP id
 4fb4d7f45d1cf-5b02375ed86mr10939547a12.34.1722407175493; Tue, 30 Jul 2024
 23:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-12-sughosh.ganu@linaro.org>
 <CAFLszTigqxP-wbxmxUUSkrHauL2UrSpQV4e9XK8gDJ4H=e7a2g@mail.gmail.com>
In-Reply-To: <CAFLszTigqxP-wbxmxUUSkrHauL2UrSpQV4e9XK8gDJ4H=e7a2g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 31 Jul 2024 11:56:03 +0530
Message-ID: <CADg8p974VKejYrBdqVW7qHfasuh4eBbkdkGiOW4iVjcciX8-1g@mail.gmail.com>
Subject: Re: [PATCH 11/40] lmb: make LMB memory map persistent and global
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 31 Jul 2024 at 01:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc:
> > * Squash patches 9 - 11, 13  from the rfc v2 series into a single
> >   patch to make it bisectable.
> >
> >  arch/arc/lib/cache.c                 |   4 +-
> >  arch/arm/lib/stack.c                 |   4 +-
> >  arch/arm/mach-apple/board.c          |  17 +-
> >  arch/arm/mach-snapdragon/board.c     |  17 +-
> >  arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >  arch/m68k/lib/bootm.c                |   7 +-
> >  arch/microblaze/lib/bootm.c          |   4 +-
> >  arch/mips/lib/bootm.c                |  11 +-
> >  arch/nios2/lib/bootm.c               |   4 +-
> >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >  arch/powerpc/include/asm/mp.h        |   4 +-
> >  arch/powerpc/lib/bootm.c             |  14 +-
> >  arch/riscv/lib/bootm.c               |   4 +-
> >  arch/sh/lib/bootm.c                  |   4 +-
> >  arch/x86/lib/bootm.c                 |   4 +-
> >  arch/xtensa/lib/bootm.c              |   4 +-
> >  board/xilinx/common/board.c          |   8 +-
> >  boot/bootm.c                         |  26 +-
> >  boot/bootm_os.c                      |   5 +-
> >  boot/image-board.c                   |  34 +--
> >  boot/image-fdt.c                     |  36 ++-
> >  cmd/bdinfo.c                         |   6 +-
> >  cmd/booti.c                          |   2 +-
> >  cmd/bootz.c                          |   2 +-
> >  cmd/elf.c                            |   2 +-
> >  cmd/load.c                           |   7 +-
> >  drivers/iommu/apple_dart.c           |   8 +-
> >  drivers/iommu/sandbox_iommu.c        |  16 +-
> >  fs/fs.c                              |   7 +-
> >  include/image.h                      |  28 +-
> >  include/lmb.h                        | 114 +++-----
> >  lib/efi_loader/efi_dt_fixup.c        |   2 +-
> >  lib/efi_loader/efi_helper.c          |   2 +-
> >  lib/lmb.c                            | 395 +++++++++++++++------------
> >  net/tftp.c                           |   5 +-
> >  net/wget.c                           |   5 +-
> >  test/cmd/bdinfo.c                    |   2 +-
> >  test/lib/lmb.c                       | 205 ++++++--------
> >  39 files changed, 477 insertions(+), 560 deletions(-)
>
> [..]
>
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 4d39c0d1f9..dd6f22654c 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> [..]
> > -static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
> > +static void lmb_remove_region(struct alist *lmb_rgn_lst, unsigned long r)
> >  {
> >         unsigned long i;
> > +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >
> > -       for (i = r; i < rgn->cnt - 1; i++) {
> > -               rgn->region[i].base = rgn->region[i + 1].base;
> > -               rgn->region[i].size = rgn->region[i + 1].size;
> > -               rgn->region[i].flags = rgn->region[i + 1].flags;
> > +       for (i = r; i < lmb_rgn_lst->count - 1; i++) {
> > +               rgn[i].base = rgn[i + 1].base;
> > +               rgn[i].size = rgn[i + 1].size;
> > +               rgn[i].flags = rgn[i + 1].flags;
>
> This should be:
>
> rgn[i] = rgn[i+1]

Yes, direct struct assignment is a better way of doing this. Thanks
for pointing it out!

-sughosh
