Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE1AC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 10:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9938D801FB;
	Wed, 12 Mar 2025 11:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUuQIvgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A558805D7; Wed, 12 Mar 2025 11:25:34 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89DF801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d30c329f2so785685241.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775130; x=1742379930; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWkFNUOh4I8tHv/Cw6aLLBLQB43YJ+IRIkMm2xAuBis=;
 b=SUuQIvggt/aHMuZGsGDlz/alIh6dc78Nf8tdcKOBos0HZzjSocOMPIwK5i9pTBlVVd
 XsvuartKHKhDTPlfzkIIIWHHSyw80zL2y6Fs7gbsDBisAXidjknVDahKXnDdfdhjJaEw
 mel6R5h5q443Ttu5wvcdaT6XArk3Uf3uaoZy+3Dj0wHNK3qvclDVOksM2aHIxb3O7s8U
 7tKZFRY934RxO5SAQRxRsu50z2YtqzMFxgQcmWAOV059Is/0k4kPJcYfM1IEWKFdvKIB
 6/Rko8JRuEEaYvpNQ2QXYOJq+/a1KRuVgWVmw7djuBVjK9c1eUQjyW9e/0g6KIztkM8I
 nb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775130; x=1742379930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWkFNUOh4I8tHv/Cw6aLLBLQB43YJ+IRIkMm2xAuBis=;
 b=V4qWwxKiwc91rnarX09AoO5vcMdyGZHWMBgQuZgfW0PTSUWPo5Oq1l0klKSChB1U1D
 B08O7+w6qeLK//03uXb18dA6h64HdK74iD4+3DB50LPTBjXa5pucI2enpsdIm/1fW9do
 C/mbSu3i4pw05W8JKa5rIDkucJ7OU8s8ierv+2FEk3Wb1+weNqsVEkRieacAdNpo2HVq
 9dcfeKZCN4gcgI7DeOQWkxwOhjgiJvPcuBvI/0xdGrf23Yi7v/9StAcysYjTZ/sH0XNp
 ZPQSJvoeg6ewgYyD0M4VmWklBO+Bho+KPB01P9vct8EzJ4sBI4EtTkovbWmOir83Bc5G
 21xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURIQAyt5XnEvQu5uf7XJP0dAG3YynfiGIY6LtenFrzUPzwYEU199Yu/n0BRRQNnWm1/9RPELo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+FyONBZGNUc6RLLbXKooZztRNNrdIY+Ru+sEEjeJiJl5rgL1N
 Ghq5X36lxMaMY8jWabeevtmP5FlPQqhMyc7Mpd62o39YKHCudML28SPl7aWnATbBopdjHIhmL7E
 kKauaxYEbfGw22/cH1win4SVnJyj07LdA8NAC/g==
X-Gm-Gg: ASbGncvvVogmLypd7KwpIYiIbdNWB1qto4QXzf9Fi54UbFdhaWxHvl4OreOIV/HEMhq
 WKO8ipiXcwUFQjNfXMA8LlEbmokkEUxL+h+b9pgH70CL3GSQK+ytMQuZt01JV9RL6Wt3yhbu06N
 iQKSv+ioPVtcN4ypInu74DI3x75YM=
X-Google-Smtp-Source: AGHT+IHBAuRrvUqJvYRF8qn+YbU43nbCjI+8Dy7GDn62b0afb6yigONRfmESIxvTQRXCrcQdUvArY3gHIxtR3Aujs4k=
X-Received: by 2002:a05:6102:2444:b0:4c3:6dc:8d05 with SMTP id
 ada2fe7eead31-4c34dea9689mr3963846137.11.1741775130307; Wed, 12 Mar 2025
 03:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-5-sughosh.ganu@linaro.org>
 <e1237408-072c-4473-aafb-ab74196a2c71@gmx.de>
In-Reply-To: <e1237408-072c-4473-aafb-ab74196a2c71@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 12 Mar 2025 15:55:19 +0530
X-Gm-Features: AQ5f1Jp_u_59zWPsYd0WOuzVNFtkymyCwy0Icn9y1ZUWE47RE529A3FgMkjEMS4
Message-ID: <CADg8p94fPOHQmqAka7_e2wvh+3ehR0+LV0RrimsooYnduQR4Tw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] efi_loader: add a function to remove memory from
 the EFI map
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Wed, 12 Mar 2025 at 15:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > With upcoming changes supporting pmem nodes, we need to remove the
> > pmem area from the EFI memory map. Add a function to do that.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> > Changes since V7: None
> >
> >   include/efi_loader.h        | 18 ++++++++++++
> >   lib/efi_loader/efi_memory.c | 56 ++++++++++++++++++++++++++-----------
> >   2 files changed, 58 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e9c10819ba2..c20c98c6476 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -878,6 +878,24 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >   /* Adds a range into the EFI memory map */
> >   efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> >
> > +/**
> > + * efi_update_memory_map() - update the memory map by adding/removing pages
> > + *
> > + * @start:                   start address, must be a multiple of
> > + *                           EFI_PAGE_SIZE
> > + * @pages:                   number of pages to add
> > + * @memory_type:             type of memory added
> > + * @overlap_conventional:    region may only overlap free(conventional)
> > + *                           memory
> > + * @remove:                  remove memory map
> > + * Return:                   status code
> > + */
> > +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
> > +                                bool overlap_conventional, bool remove);
>
> Why do we have so many functions that are all doing nearly the same thing:
>
> * efi_map_update_notify()

This function does not get the size in terms of number of pages, but
the size in bytes, which it then converts to pages. Additionally,
there is this conversion from address to pointers.

> * efi_update_memory_map()
> * efi_remove_memory_map()

The efi_remove_memory_map() can indeed be removed, and we can directly
call efi_update_memory_map() directly.

> * efi_add_memory_map_pg()

This function will no longer exist once this series gets applied.

-sughosh

>
> I start failing to understand when to use which. This is getting as
> gruesome as LMB.
>
> Can't we have a single exported function with a properly defined
> interface to cover all use cases?
>
> Best regards
>
> Heinrich
>
> > +
> > +/* Remove memory from the EFI memory map */
> > +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type);
> > +
> >   /* Called by board init to initialize the EFI drivers */
> >   efi_status_t efi_driver_init(void);
> >   /* Called when a block device is added */
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 6d00b186250..3fec40b6de5 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >   }
> >
> >   /**
> > - * efi_add_memory_map_pg() - add pages to the memory map
> > + * efi_update_memory_map() - update the memory map by adding/removing pages
> >    *
> >    * @start:                  start address, must be a multiple of
> >    *                          EFI_PAGE_SIZE
> > @@ -266,12 +266,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >    * @memory_type:            type of memory added
> >    * @overlap_conventional:   region may only overlap free(conventional)
> >    *                          memory
> > + * @remove:                  remove memory map
> >    * Return:                  status code
> >    */
> > -static
> > -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > -                                int memory_type,
> > -                                bool overlap_conventional)
> > +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
> > +                                bool overlap_conventional, bool remove)
> >   {
> >       struct efi_mem_list *lmem;
> >       struct efi_mem_list *newlist;
> > @@ -279,9 +278,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >       uint64_t carved_pages = 0;
> >       struct efi_event *evt;
> >
> > -     EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> > +     EFI_PRINT("%s: 0x%llx 0x%llx %d %s %s\n", __func__,
> >                 start, pages, memory_type, overlap_conventional ?
> > -               "yes" : "no");
> > +               "yes" : "no", remove ? "remove" : "add");
> >
> >       if (memory_type >= EFI_MAX_MEMORY_TYPE)
> >               return EFI_INVALID_PARAMETER;
> > @@ -364,7 +363,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >       }
> >
> >       /* Add our new map */
> > -        list_add_tail(&newlist->link, &efi_mem);
> > +     if (!remove)
> > +             list_add_tail(&newlist->link, &efi_mem);
> > +     else
> > +             free(newlist);
> >
> >       /* And make sure memory is listed in descending order */
> >       efi_mem_sort();
> > @@ -401,7 +403,29 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
> >       pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
> >       start &= ~EFI_PAGE_MASK;
> >
> > -     return efi_add_memory_map_pg(start, pages, memory_type, false);
> > +     return efi_update_memory_map(start, pages, memory_type, false, false);
> > +}
> > +
> > +/**
> > + * efi_remove_memory_map() - remove memory area to the memory map
> > + *
> > + * @start:           start address of the memory area
> > + * @size:            length in bytes of the memory area
> > + * @memory_type:     type of memory removed
> > + *
> > + * Return:           status code
> > + *
> > + * This function automatically aligns the start and size of the memory area
> > + * to EFI_PAGE_SIZE.
> > + */
> > +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type)
> > +{
> > +     u64 pages;
> > +
> > +     pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
> > +     start &= ~EFI_PAGE_MASK;
> > +
> > +     return efi_update_memory_map(start, pages, memory_type, false, true);
> >   }
> >
> >   /**
> > @@ -502,7 +526,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >
> >       efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
> >       /* Reserve that map in our memory maps */
> > -     ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
> > +     ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);
> >       if (ret != EFI_SUCCESS) {
> >               /* Map would overlap, bail out */
> >               lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> > @@ -823,8 +847,8 @@ static void add_u_boot_and_runtime(void)
> >                      uboot_stack_size) & ~EFI_PAGE_MASK;
> >       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> >                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> > -     efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > -                           false);
> > +     efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > +                           false, false);
> >   #if defined(__aarch64__)
> >       /*
> >        * Runtime Services must be 64KiB aligned according to the
> > @@ -842,8 +866,8 @@ static void add_u_boot_and_runtime(void)
> >       runtime_end = (uintptr_t)__efi_runtime_stop;
> >       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> >       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > -     efi_add_memory_map_pg(runtime_start, runtime_pages,
> > -                           EFI_RUNTIME_SERVICES_CODE, false);
> > +     efi_update_memory_map(runtime_start, runtime_pages,
> > +                           EFI_RUNTIME_SERVICES_CODE, false, false);
> >   }
> >
> >   int efi_memory_init(void)
> > @@ -878,11 +902,11 @@ int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> >       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> >       efi_addr &= ~EFI_PAGE_MASK;
> >
> > -     status = efi_add_memory_map_pg(efi_addr, pages,
> > +     status = efi_update_memory_map(efi_addr, pages,
> >                                      op == LMB_MAP_OP_RESERVE ?
> >                                      EFI_BOOT_SERVICES_DATA :
> >                                      EFI_CONVENTIONAL_MEMORY,
> > -                                    false);
> > +                                    false, false);
> >       if (status != EFI_SUCCESS) {
> >               log_err("LMB Map notify failure %lu\n",
> >                       status & ~EFI_ERROR_MASK);
>
