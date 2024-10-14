Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D5D16245
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 11:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429C988549;
	Mon, 14 Oct 2024 13:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BFJX/g1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1335888CB9; Mon, 14 Oct 2024 13:27:29 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B858852B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so4134748a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728905246; x=1729510046; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=liwsjlwhzP1QeK9OgZtWKbEMXIpt/hoCgLADg6xo1T8=;
 b=BFJX/g1cVvdPNC7nA3i2zn90oMl/+nFylJuFB4/aiI4coXBd4gPkh8p3uJbsaCq7/R
 wJbuz6HAKlKU1bMT4Bp9LW5NoS2oxwWOnJSJgfGp6RO3DByQ6ta/ZT/KCxhtSOEl+IDH
 drg9pnvjYjXBavEtrFjp2+919gXUyu1Q7inGhnSWnewqaKCpCqgJ0xKXd8YIijj9t7gD
 lQMJmhbIoy9zTrmp7K0Ms/RdKLNy4jp/f9aoirYwk0ntkB2Av8+ZOErTF6z676mTFkPL
 inX8FVVCOXrzEZnqepX+60RJXuwENRIAl/2KSJiEUEn0ktDO1Tkok4T6sASkcCusA22y
 CACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728905246; x=1729510046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=liwsjlwhzP1QeK9OgZtWKbEMXIpt/hoCgLADg6xo1T8=;
 b=UpbF+SRZl5Ov7aJQr9s5UAYmx5P1bUw0PGydvq7x5HcCbT19mpI//SV+8z7ftizkNL
 WnWYNJFe4jtKMc8rH3OYIuJi+EAuKoQG5LPECM9JliNPmzhS6xwIQVf1D9bhhZTN1D+y
 2trjhw9e9rd59Xu7S8fmam2iMQAkH9VO2ooXv6FZynpwfd0FQg0/0pbfxVxU/RNyzP3+
 ixaGCl7FPD3kjblQMW6q1/sZNp7kJHQ6oHNC9GZAzhnxf/He6VRywOabnDYbksseIZ0X
 yKIltxqFr9R6o4bmNV5Lzb+k3F1+xD/t3FhXiXtPi4I7vwSM2mtwwa48918rMYnic8xT
 oVIA==
X-Gm-Message-State: AOJu0YwOaIH+Tl06TFOqxS+0yICQoUnxsEEt3jaiurJZtzscvGceYutM
 xFi/HQu7kLsbF1kg4CuTchSI/peB4pncsA501B7m6zM11TQAd0B2freFEW3XIxDyVKkVSl0MhrU
 frGOBSgKczsA9+9rHS6ENNDUhqwzScrzb4GiCFA==
X-Google-Smtp-Source: AGHT+IHDOzVdj1QaDcjXZ3BDtLTIZBdb7zstIkIpuhutdW0SFuAbM8bWbo07LKn0vFJeNmPV/dz6lScX8123xXcRxNM=
X-Received: by 2002:a05:6402:158b:b0:5c5:cdf0:177b with SMTP id
 4fb4d7f45d1cf-5c948cdb1a9mr8660012a12.21.1728905246046; Mon, 14 Oct 2024
 04:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-7-sughosh.ganu@linaro.org>
 <CAC_iWjLQPkg4Vu1CZ7B+4BqRZnCUAiZkqgs412RVmDMDqYR__Q@mail.gmail.com>
In-Reply-To: <CAC_iWjLQPkg4Vu1CZ7B+4BqRZnCUAiZkqgs412RVmDMDqYR__Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 16:57:14 +0530
Message-ID: <CADg8p9782WTD1fHn3bN2Xkykz6fpMFuC+_2FUN+8b4myHK6_Ow@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] lmb: notify of any changes to the LMB memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 15:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
>
> On Sun, 13 Oct 2024 at 13:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > In U-Boot, LMB and EFI are two primary modules who provide memory
> > allocation and reservation API's. Both these modules operate with the
> > same regions of memory for allocations. Use the LMB memory map update
> > event to notify other interested listeners about a change in it's
> > memory map. This can then be used by the other module to keep track of
> > available and used memory.
> >
> > There is no need to send these notifications when the LMB module is
> > being unit-tested. Add a flag to the lmb structure to indicate if the
> > memory map is being used for tests, and suppress sending any
> > notifications when running these unit tests.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: None
> >
> >  include/efi_loader.h        |  14 +++++
> >  include/lmb.h               |   2 +
> >  lib/efi_loader/Kconfig      |   1 +
> >  lib/efi_loader/efi_memory.c |   2 +-
> >  lib/lmb.c                   | 109 ++++++++++++++++++++++++++++++++----
> >  5 files changed, 115 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 511281e150..ac20395718 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -784,6 +784,20 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >                                 uint32_t *descriptor_version);
> >  /* Adds a range into the EFI memory map */
> >  efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> > +
> > +/**
> > + * efi_add_memory_map_pg() - add pages to the memory map
> > + *
> > + * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > + * @pages:             number of pages to add
> > + * @memory_type:       type of memory added
> > + * @overlap_only_ram:  region may only overlap RAM
> > + * Return:             status code
> > + */
> > +efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > +                                         int memory_type,
> > +                                         bool overlap_only_ram);
> > +
> >  /* Adds a conventional range into the EFI memory map */
> >  efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> >                                              u64 ram_top);
> > diff --git a/include/lmb.h b/include/lmb.h
> > index a76262d520..92e9aead76 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -44,10 +44,12 @@ struct lmb_region {
> >   *
> >   * @free_mem:  List of free memory regions
> >   * @used_mem:  List of used/reserved memory regions
> > + * @test:      Is structure being used for LMB tests
> >   */
> >  struct lmb {
> >         struct alist free_mem;
> >         struct alist used_mem;
> > +       bool test;
> >  };
> >
> >  /**
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 69b2c9360d..2282466ae9 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -21,6 +21,7 @@ config EFI_LOADER
> >         select EVENT_DYNAMIC
> >         select LIB_UUID
> >         select LMB
> > +       select MEM_MAP_UPDATE_NOTIFY
> >         imply PARTITION_UUIDS
> >         select REGEX
> >         imply FAT
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index aa1da21f9f..41501e9d41 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -264,7 +264,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >   * @overlap_only_ram:  region may only overlap RAM
> >   * Return:             status code
> >   */
> > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > +efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >                                           int memory_type,
> >                                           bool overlap_only_ram)
> >  {
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index e1e616679f..a567c02784 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <alist.h>
> >  #include <efi_loader.h>
> > +#include <event.h>
> >  #include <image.h>
> >  #include <mapmem.h>
> >  #include <lmb.h>
> > @@ -22,10 +23,55 @@
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +#define MAP_OP_RESERVE         (u8)0x1
> > +#define MAP_OP_FREE            (u8)0x2
> > +#define MAP_OP_ADD             (u8)0x3
> > +
> >  #define LMB_ALLOC_ANYWHERE     0
> >  #define LMB_ALIST_INITIAL_SIZE 4
> >
> >  static struct lmb lmb;
> > +extern bool is_addr_in_ram(uintptr_t addr);
> > +
> > +static bool lmb_notify(enum lmb_flags flags)
> > +{
> > +       return !lmb.test && !(flags & LMB_NONOTIFY);
>
> Can you explain where the test flag is needed? Making the code aware
> its testing something is usually a bad idea

This is because we are running the lmb tests without rebooting the
system, or running them separately. So, adding random memory regions
to the EFI memory map when running the LMB tests causes issues once
the tests have been run. This is to not tamper with the EFI memory map
when running LMB tests. I had initially written a separate test for
lmb which was rebooting U-Boot on running the tests, but Simon
suggested using a stack based implementation instead where the lmb
tests can be run without rebooting.

>
> > +}
> > +
> > +static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
> > +                                               phys_size_t size,
> > +                                               u8 op)
> > +{
> > +       u64 efi_addr;
> > +       u64 pages;
> > +       efi_status_t status;
> > +
> > +       if (!is_addr_in_ram((uintptr_t)addr))
> > +               return 0;
>
> This should be an error and at least print something

IIRC, this was causing some issues on sandbox with /reserved-memory
regions obtained from the fdt. I will check this again and see if this
causes any issues.

>
> > +
> > +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
> > +               log_debug("Invalid map update op received (%d)\n", op);
>
> log_err

Okay

>
> > +               return -1;
> > +       }
> > +
> > +       efi_addr = (uintptr_t)map_sysmem(addr, 0);
> > +       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> > +       efi_addr &= ~EFI_PAGE_MASK;
> > +
> > +       status = efi_add_memory_map_pg(efi_addr, pages,
> > +                                      op == MAP_OP_RESERVE ?
> > +                                      EFI_BOOT_SERVICES_DATA :
> > +                                      EFI_CONVENTIONAL_MEMORY,
> > +                                      false);
> > +
> > +       if (status != EFI_SUCCESS) {
> > +               log_err("%s: LMB Map notify failure %lu\n", __func__,
> > +                       status & ~EFI_ERROR_MASK);
> > +               return -1;
> > +       } else {
> > +               return 0;
> > +       }
> > +}
> >
> >  static void lmb_print_region_flags(enum lmb_flags flags)
> >  {
> > @@ -474,9 +520,17 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
> >  /* This routine may be called with relocation disabled. */
> >  long lmb_add(phys_addr_t base, phys_size_t size)
> >  {
> > +       long ret;
> >         struct alist *lmb_rgn_lst = &lmb.free_mem;
> >
> > -       return lmb_add_region(lmb_rgn_lst, base, size);
> > +       ret = lmb_add_region(lmb_rgn_lst, base, size);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > +               return lmb_map_update_notify(base, size, MAP_OP_ADD);
>
> I didn't get a chance to answer on the previous series, but I think
> this should just depend on the EFI_LOADER, Is the are problem doing
> that for SPL?
> I think it's cleaner to add that check to lmb_notify() and rename it
> to lmb__should_notify(). Then any future subsystems could use that
> function and add their conditions if they need a notification, instead
> of adding Kconfig options

Okay. That is a good suggestion. So instead of this config symbol, I
can add a check for EFI_LOADER in the lmb_should_notify() function. If
at a later point, it is deemed that there is a reason to add a config
symbol for this purpose, it can be done at then. Thanks.

-sughosh

>
> > +
> > +       return 0;
> >  }
> >
> >  static long __lmb_free(phys_addr_t base, phys_size_t size)
> > @@ -530,11 +584,6 @@ static long __lmb_free(phys_addr_t base, phys_size_t size)
> >                                     rgn[i].flags);
> >  }
> >
> > -long lmb_free(phys_addr_t base, phys_size_t size)
> > -{
> > -       return __lmb_free(base, size);
> > -}
> > -
> >  /**
> >   * lmb_free_flags() - Free up a region of memory
> >   * @base: Base Address of region to be freed
> > @@ -546,16 +595,38 @@ long lmb_free(phys_addr_t base, phys_size_t size)
> >   * Return: 0 if successful, -1 on failure
> >   */
> >  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> > -                   __always_unused uint flags)
> > +                   uint flags)
> >  {
> > -       return __lmb_free(base, size);
> > +       long ret;
> > +
> > +       ret = __lmb_free(base, size);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
> > +               return lmb_map_update_notify(base, size, MAP_OP_FREE);
> > +
> > +       return ret;
> > +}
> > +
> > +long lmb_free(phys_addr_t base, phys_size_t size)
> > +{
> > +       return lmb_free_flags(base, size, LMB_NONE);
> >  }
> >
> >  long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
> >  {
> > +       long ret = 0;
> >         struct alist *lmb_rgn_lst = &lmb.used_mem;
> >
> > -       return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> > +       ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
> > +       if (ret < 0)
> > +               return -1;
> > +
> > +       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
> > +               return lmb_map_update_notify(base, size, MAP_OP_RESERVE);
> > +
> > +       return ret;
> >  }
> >
> >  long lmb_reserve(phys_addr_t base, phys_size_t size)
> > @@ -587,6 +658,8 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> >  static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> >                                     phys_addr_t max_addr, enum lmb_flags flags)
> >  {
> > +       u8 op;
> > +       int ret;
> >         long i, rgn;
> >         phys_addr_t base = 0;
> >         phys_addr_t res_base;
> > @@ -617,6 +690,16 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> >                                 if (lmb_add_region_flags(&lmb.used_mem, base,
> >                                                          size, flags) < 0)
> >                                         return 0;
> > +
> > +                               if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) &&
> > +                                   lmb_notify(flags)) {
> > +                                       op = MAP_OP_RESERVE;
> > +                                       ret = lmb_map_update_notify(base, size,
> > +                                                                   op);
> > +                                       if (ret)
> > +                                               return ret;
> > +                               }
> > +
> >                                 return base;
> >                         }
> >
> > @@ -786,7 +869,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
> >         return 0;
> >  }
> >
> > -static int lmb_setup(void)
> > +static int lmb_setup(bool test)
> >  {
> >         bool ret;
> >
> > @@ -804,6 +887,8 @@ static int lmb_setup(void)
> >                 return -ENOMEM;
> >         }
> >
> > +       lmb.test = test;
> > +
> >         return 0;
> >  }
> >
> > @@ -823,7 +908,7 @@ int lmb_init(void)
> >  {
> >         int ret;
> >
> > -       ret = lmb_setup();
> > +       ret = lmb_setup(false);
> >         if (ret) {
> >                 log_info("Unable to init LMB\n");
> >                 return ret;
> > @@ -851,7 +936,7 @@ int lmb_push(struct lmb *store)
> >         int ret;
> >
> >         *store = lmb;
> > -       ret = lmb_setup();
> > +       ret = lmb_setup(true);
> >         if (ret)
> >                 return ret;
> >
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
