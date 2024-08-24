Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC16C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 05:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780E588A99;
	Sat, 24 Aug 2024 07:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iAHH0uvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0967D88BE4; Sat, 24 Aug 2024 07:35:10 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64E188A99
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 07:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bed05c0a2fso3339207a12.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724477707; x=1725082507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ij/b8mc2OidGWygKnF0w7rsT2zj6CQpcWuf4WDQSSeI=;
 b=iAHH0uvHaZ8GATc4Yph8+cwgIt18JTSRUtymU4AJmHCxewLHz+I6tPQ5APlqCyWdPH
 gm/6c6wDQfi9Yrk+sfNEZyFJfcw85hzgIbQzi4r6oHmkVCBJCKE2WZ654L0ucP2ei4Jd
 P7YRkA3s0as0ZtbJBAWDhqixW0/ww1g8wlSJ1I6N9xLDxcWTs/hBEndRVvnQznGuNy6E
 y5LqcrGvmoZN5ksMqkR4vuOuC/1/kHmiRPJzPGl5qUDGHJuQUskRn0gw5h8oCYsDIsAf
 HO3A/gJYRUY++IlCJFO5BHL5q/9z2zVsaVmKF8SJuJ/G2peJ2afTQFSr/otL9ibiMcod
 ipCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724477707; x=1725082507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ij/b8mc2OidGWygKnF0w7rsT2zj6CQpcWuf4WDQSSeI=;
 b=s1Jp8hE1TTmkQeqd3EG8YZSAAo22fBfE31CPRyacuSbxnccZrZ7cSlIXR2bJlM7Mjn
 AccRCYFnruwLjoBPUR1NuOE4camEu8qAuBA93P7f7ifDri6nq6FY9fBNgAC3z8TSp56B
 wFsC4F1WJ7GiIm0fEQXqeHAIJYDqn23eqx5y+Em7AqrDFMHd4N3CtdkWePD9J1X6ufbX
 zRA6MbeOvwzRsZf4hQB9p6R11ceeVms4G164fmpob1bcoGlaHUd8GJWPELKx0O8IsqcV
 KErN19ic1AgHonFpBB/HSeU4Q26ZowKpnwQFuwnr3ElQ1O7kCwEcYQ+JcEQo6jUY/2Ul
 Ef5g==
X-Gm-Message-State: AOJu0Yz4Dw6gaAyjTCDaU5QqePtBXMVzUIcXsq+G0QaYNF12NyB2cXa3
 pK4Q7KUg8ZVhyMG5I+QhfNBXCl2I7YOpXU9oIRgmRrWt3kAQYdFcFsTeALHk17rBdtXhjp/1B7z
 GFayYOEUSMUwLw0zSTf0J9/Toma0h7OtG+HZUUg==
X-Google-Smtp-Source: AGHT+IHG1L3M4Mw0C3v/RxBSRM+slSJrexAejRqe5x/ufv8F84Z8ATX5H9dYr76ij+ZcVATsCa7aKmg2MfLg7LmYJ2E=
X-Received: by 2002:a05:6402:518d:b0:5c0:99ff:7c85 with SMTP id
 4fb4d7f45d1cf-5c099ff84b0mr333536a12.18.1724477707041; Fri, 23 Aug 2024
 22:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-18-sughosh.ganu@linaro.org>
 <CAFLszTiuOTquP5sztthp=zgb=u-c2ZADu8Rw6E-AhPV2Up9m3A@mail.gmail.com>
In-Reply-To: <CAFLszTiuOTquP5sztthp=zgb=u-c2ZADu8Rw6E-AhPV2Up9m3A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 24 Aug 2024 11:04:55 +0530
Message-ID: <CADg8p96s0EAvFO5qHEduZ6C2hEEf53hM6BfaZPoF5Zx3NVHZ9A@mail.gmail.com>
Subject: Re: [PATCH v3 17/27] lmb: do away with arch_lmb_reserve()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Sat, 24 Aug 2024 at 02:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > All of the current definitions of arch_lmb_reserve() are doing the
> > same thing -- reserve the region of memory occupied by U-Boot,
> > starting from the current stack address to the ram_top. Introduce a
> > function lmb_reserve_uboot_region() which does this, and do away with
> > the arch_lmb_reserve() function.
> >
> > Instead of using the current value of stack pointer for starting the
> > reserved region, have a fixed value, considering the stack size config
> > value.nit
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2:
> > * Remove the definitions of arch_lmb_reserve() and
> >   arch_lmb_reserve_generic() functions.
> > * Introduce a new function lmb_reserve_uboot_region() and call it from
> >   lmb_reserve_common().
> >
> >  arch/arc/lib/cache.c        | 14 -------
> >  arch/arm/lib/stack.c        | 14 -------
> >  arch/m68k/lib/bootm.c       | 17 --------
> >  arch/microblaze/lib/bootm.c | 14 -------
> >  arch/mips/lib/bootm.c       | 15 -------
> >  arch/nios2/lib/bootm.c      | 13 ------
> >  arch/powerpc/lib/bootm.c    |  9 ----
> >  arch/riscv/lib/bootm.c      | 13 ------
> >  arch/sh/lib/bootm.c         | 13 ------
> >  arch/x86/lib/bootm.c        | 18 --------
> >  arch/xtensa/lib/bootm.c     | 13 ------
> >  include/lmb.h               |  2 -
> >  lib/lmb.c                   | 83 ++++++++++++++++++-------------------
> >  13 files changed, 41 insertions(+), 197 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> question below
>
> [..]
>
> > diff --git a/include/lmb.h b/include/lmb.h
> > index e6c6f1cdcd..6e435bd35c 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -108,8 +108,6 @@ void lmb_dump_all(void);
> >  void lmb_dump_all_force(void);
> >
> >  void board_lmb_reserve(void);
> > -void arch_lmb_reserve(void);
> > -void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
> >
> >  #if CONFIG_IS_ENABLED(UNIT_TEST)
>
> There is no need to do this in the header file, BTW. It will cause a
> link error if someone uses it by mistake.

Okay

>
> >  struct lmb *lmb_get(void);
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index e26e329248..1116b2b868 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> [..]
> > @@ -215,10 +179,50 @@ static __maybe_unused int efi_lmb_reserve(void)
> >         return 0;
> >  }
> >
> > +static void lmb_reserve_uboot_region(void)
> > +{
> > +       int bank;
> > +       ulong end, bank_end;
> > +       phys_addr_t rsv_start;
> > +
> > +       rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> > +       end = gd->ram_top;
> > +
> > +       /*
> > +        * Reserve memory from aligned address below the bottom of U-Boot stack
> > +        * until end of RAM area to prevent LMB from overwriting that memory.
> > +        */
> > +       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> > +
> > +       /* adjust sp by 4K to be safe */
> > +       rsv_start -= 16384;
>
> Should that be SZ_4K ?

It should be SZ_16K. This is using the highest value that was being
used by the different architectures. I will fix the comment. Thanks.

-sughosh

>
> > +       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > +               if (!gd->bd->bi_dram[bank].size ||
> > +                   rsv_start < gd->bd->bi_dram[bank].start)
> > +                       continue;
> > +               /* Watch out for RAM at end of address space! */
> > +               bank_end = gd->bd->bi_dram[bank].start +
> > +                       gd->bd->bi_dram[bank].size - 1;
> > +               if (rsv_start > bank_end)
> > +                       continue;
> > +               if (bank_end > end)
> > +                       bank_end = end - 1;
> > +
> > +               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> > +                                 LMB_NOOVERWRITE);
> > +
> > +               if (gd->flags & GD_FLG_SKIP_RELOC)
> > +                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
> > +                                   gd->mon_len, LMB_NOOVERWRITE);
> > +
> > +               break;
> > +       }
> > +}
> > +
> >  static void lmb_reserve_common(void *fdt_blob)
> >  {
> > -       arch_lmb_reserve();
> >         board_lmb_reserve();
> > +       lmb_reserve_uboot_region();
> >
> >         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> >                 boot_fdt_add_mem_rsv_regions(fdt_blob);
> > @@ -689,11 +693,6 @@ __weak void board_lmb_reserve(void)
> >         /* please define platform specific board_lmb_reserve() */
> >  }
> >
> > -__weak void arch_lmb_reserve(void)
> > -{
> > -       /* please define platform specific arch_lmb_reserve() */
> > -}
> > -
> >  static int lmb_setup(void)
> >  {
> >         bool ret;
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
