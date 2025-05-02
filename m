Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF85C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 12:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE8B8209C;
	Fri,  2 May 2025 14:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rW6qSF/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7163781E72; Fri,  2 May 2025 14:30:00 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FAA801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4c30a4bcceeso743485137.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746188996; x=1746793796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOG7/MtCBwMvAqJrXtHhFiSWbWXEN+kIvOzaaR8JlpU=;
 b=rW6qSF/4K7a5bKA+w+JzKP6yQE2hn8skYZrJMXSwequZr2Nj+NYnsUiTxpJlwIHX/j
 bFTA56Ji+0arn7v4sE+FSkAyWa4HZ43CvkRCxsmKjYfx9Bj068o2RHwnDRz4uK4H90GW
 +w+MQpBzc2d1X+XKotbLDmfuvRK3b1U5CNPjaxf5RasMFL5+eX4eBVSL6LUO2fjwqN8Q
 aBsBugS8szhuVnpIzj9JzhvZxz90l5NZB88Y+q84oH6A8Yz/DZjrgMl1tBNEhE0SUN26
 vZ79PRD1rgU7VtuljSM7e+aZMG5EnJ2HB9kowoGSBeFoD8vmwoM40QBKUi1LSdi2m0V0
 cEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746188996; x=1746793796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOG7/MtCBwMvAqJrXtHhFiSWbWXEN+kIvOzaaR8JlpU=;
 b=ogKohyaZAISLIhpkeVb7qHTV/AXRhCcn6AEKTd1jz5xwbvnh3WnJcYnZzNQy8IAL+4
 5JZc0O017Ztgr5xM6qCel0PeA+EaJBgm3FVbKwpsZhZrJwR2A+tgw0SCBf4JW+IVwm+d
 ys9DuhUsbDeRwHTyDI/7hR2Ad3BLTMS93gXhnPQJe5ASTxQ7/olRsvEf/88gQEnv9WsF
 1tr+3Vc6jfOknj/OoJHkTg0EEWQrKXfFbG24dUHsQ79JuHloJsnBFYfDJITUuB07pbnj
 geFbuAbJ6JUs4GivaTMRAY4heoIp8gjukyi7GpmLXfGBHLOMYumML+BwDlkZEy1v8TtV
 Kkog==
X-Gm-Message-State: AOJu0Yxi8SsMzLXGTNXHXn2dqODtfjM4t57sWY9LyQr99Wll7HkCOvVT
 C+GSJuLUQPvxaAuZxMNZnIaunWjmx0vwTpCis70cHCliNq5hXail8WHhHQ6hXKSAxNRgYsGDH6D
 V2B+KcHJGVlsKe638DmK+j0iJCk9gxJ/lnulqEQ==
X-Gm-Gg: ASbGncuyFsQrqWVrJEyHs5ON2tUtbX3tt7HDRrGlbLJp/1tNKV0i0lySlp5ZEWa5iUX
 mxwt/6RUcHdSjekF2txBRVaUPMR4+DMSa4ERMyxFQvFj2cSatyXirIxbYZB+npNV77YWPpYuCqU
 RtTAg8ND92sotbWr6tgaRL1/U=
X-Google-Smtp-Source: AGHT+IG8QAvIrD3jeu7YEaq2TCv18MbLfmC9qX6qUESDDbWTZYmyKp3+DyuYey6SEqmYUd7i9wRGvadpXlle+heqxbU=
X-Received: by 2002:a05:6102:5343:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-4dafb4a2652mr1776102137.2.1746188996665; Fri, 02 May 2025
 05:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-3-sughosh.ganu@linaro.org>
 <D9LI7HGHRKRX.3NLD3DXDAG4@linaro.org>
In-Reply-To: <D9LI7HGHRKRX.3NLD3DXDAG4@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 2 May 2025 17:59:45 +0530
X-Gm-Features: ATxdqUFVgxQI2Y4H4GBoeET8qFFP4HOAuHUlXm73fPSpBCuWu-bLApYX2wm0TXs
Message-ID: <CADg8p97qR=p4fZ+Gy8D5zqCHyNh_aSPJS6k9k-OCuWJHnttTwA@mail.gmail.com>
Subject: Re: [PATCH 2/5] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Fri, 2 May 2025 at 13:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu May 1, 2025 at 3:02 PM EEST, Sughosh Ganu wrote:
> > There currently are two API's for requesting memory from the LMB
> > module, lmb_alloc() and lmb_alloc_base(). The function which does the
> > actual allocation is the same. Use the earlier introduced API
> > lmb_allocate_mem() for both types of allocation requests.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  arch/arm/mach-apple/board.c      | 27 ++++++++++++++-----
> >  arch/arm/mach-snapdragon/board.c | 13 ++++++++-
> >  boot/bootm.c                     |  6 +++--
> >  boot/image-board.c               | 45 ++++++++++++++++++--------------
> >  boot/image-fdt.c                 | 32 +++++++++++++++++------
> >  include/lmb.h                    | 22 +++-------------
> >  lib/efi_loader/efi_memory.c      | 14 +++++-----
> >  lib/lmb.c                        | 30 ++++++++++-----------
> >  test/lib/lmb.c                   | 26 ++++++++++++++++++
> >  9 files changed, 138 insertions(+), 77 deletions(-)
> >
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index 2644a04a622..f0eab5df1ef 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -772,6 +772,19 @@ u64 get_page_table_size(void)
> >
> >  #define KERNEL_COMP_SIZE     SZ_128M
> >
> > +static phys_addr_t lmb_alloc(phys_size_t size)
> > +{
> > +     int ret;
> > +     phys_addr_t addr;
> > +
> > +     /* All memory regions allocated with a 2MiB alignment */
> > +     ret = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> > +     if (ret)
> > +             return 0;
> > +
> > +     return addr;
> > +}
> > +
> >  int board_late_init(void)
> >  {
> >       u32 status = 0;
> > @@ -779,15 +792,15 @@ int board_late_init(void)
> >       /* somewhat based on the Linux Kernel boot requirements:
> >        * align by 2M and maximal FDT size 2M
> >        */
> > -     status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
> > -     status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> > -     status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
> > -     status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
> > +     status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G));
>
> env_set_hex() expects a ulong, which might end up causing problems for some archs, but I don't think
> that's a problem of this patchset. It's something that has to be fixed in a the wider codebase

Yes, there seems to be a prevalence of using the ulong type instead of
a fixed address size type, or something like phys_addr_t, which might
be an issue with certain toolchains. But this issue has been around
for a long time now.

>
> > +     status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M));
> > +     status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M));
> >                                        rd_len, LMB_NONE);
> >               } else {
> >                       if (initrd_high)
> > -                             *initrd_start =
> > -                                     (ulong)lmb_alloc_base(rd_len,
> > -                                                                 0x1000,
> > -                                                                 initrd_high,
> > -                                                                 LMB_NONE);
> > +                             err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX,
> > +                                                    0x1000, &initrd_high,
> > +                                                    rd_len, LMB_NONE);
> >                       else
> > -                             *initrd_start = (ulong)lmb_alloc(rd_len,
> > -                                                              0x1000);
> > +                             err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY,
> > +                                                    0x1000, &initrd_high,
> > +                                                    rd_len, LMB_NONE);
>
> You are now calling the same function, put LMB_MEM_ALLOC_ANY/LMB_MEM_ALLOC_MAX in a variable instead
> and make the if smaller

Will do.

>
> [...]
>
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index 6585813de00..b8e1b0f35bb 100644
> > --- a/boot/image-fdt.c
> > +++ b/boot/image-fdt.c
> > @@ -198,15 +198,27 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
> >                       of_start = (void *)(uintptr_t)addr;
> >                       disable_relocation = 1;
> >               } else if (desired_addr) {
> > -                     addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
> > -                                           LMB_NONE);
> > +                     addr = desired_addr;
> > +                     err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0x1000, &addr,
>
> Is this LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ADDR?

This is a case for LMB_MEM_ALLOC_MAX as the desired_addr variable that
is read as fdt_high has a valid value. So the allocated address should
be below desired_addr.

>
> > +                                            of_len, LMB_NONE);
> > +
> > +                     if (err) {
> > +                             puts("Failed using fdt_high value for Device Tree");
> > +                             goto error;
> > +                     }
> > +
> >                       of_start = map_sysmem(addr, of_len);
> >       } else {
> > @@ -228,11 +240,15 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
> >
> >       switch (type) {
> > +     case LMB_MEM_ALLOC_ANY:
> > +             *addr = LMB_ALLOC_ANYWHERE;
> > +             ret = _lmb_alloc_base(size, align, addr, flags);
> > +             break;
> > +     case LMB_MEM_ALLOC_MAX:
> > +             ret = _lmb_alloc_base(size, align, addr, flags);
> > +             break;
>
> You can make this a fallthrough
> case LMB_MEM_ALLOC_ANY:
>     *addr = LMB_ALLOC_ANYWHERE;
> case LMB_MEM_ALLOC_MAX:
>   ret = _lmb_alloc_base(size, align, addr, flags);
>   break;

Will change. Thanks.

-sughosh

>
> >       case LMB_MEM_ALLOC_ADDR:
> >               ret = _lmb_alloc_addr(*addr, size, flags);
> >               break;
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index f80115570e7..8ce19efc854 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -82,6 +82,32 @@ static int lmb_reserve(phys_addr_t addr, phys_size_t size, u32 flags)
> >       return 0;
> >  }
> >
> > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > +{
> > +     int err;
> > +     phys_addr_t addr;
> > +
> > +     err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> > +     if (err)
> > +             return 0;
> > +
> > +     return addr;
> > +}
> > +
> > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > +                               phys_addr_t max_addr, u32 flags)
> > +{
> > +     int err;
> > +     phys_addr_t addr;
> > +
> > +     addr = max_addr;
> > +     err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > +     if (err)
> > +             return 0;
> > +
> > +     return addr;
> > +}
> > +
> >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> >
> >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
>
> Thanks
> /Ilias
