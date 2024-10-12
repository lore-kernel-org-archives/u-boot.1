Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B65D1A431
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 07:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4956E88E18;
	Sat, 12 Oct 2024 09:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YuGGLoMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D997088E19; Sat, 12 Oct 2024 09:41:54 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C514088970
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 09:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so4399358a12.1
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728718912; x=1729323712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LSKQlXQ3fMPtu2rCm59qNI9AarAojPm0nWaRqUIGMQA=;
 b=YuGGLoMWVGCflBHV4h/siNmtf2CBRL68KYevYBJlgeT6OpKV0Oefrow8GU6YMmwXKV
 8LQ4M4E5d/H/7r0L2yNFWKrRx1MlsfIyeuLVtSfkXxF7oBnsYDaThnX4yYcQRWVFBiR4
 RR4/z2FkPmYQxf/0z5nEn2YKALUi1BRDc+4apP7XwAh3FHY+QEGzqC+P/9lFJWp6XdIt
 l2FeTogVioqxtyKUu1MLUBKKuqX3NiZvDxKth0yQMl1X9A+BiyJXvyzaMijwAFeU745k
 ZpjCK2G8rzAUxa/mx+f+m9yAqHIfLHSzsZD3g5Jj11f4zEfsDGeoooIUfyfjkzhcczID
 vLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728718912; x=1729323712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSKQlXQ3fMPtu2rCm59qNI9AarAojPm0nWaRqUIGMQA=;
 b=ecdc+G91ToW7zP+FM7rScxlqg8ucwK2b6cwGs5+vhA0sEO2WQlfOjDF/oSXN/JdlJO
 B3ztC04b6Sm3gBZGquN36BF1j8BxcNQdKcusBBHB9DtAz33Spb4yXMs8TfluGT3z+HZM
 6n+DLIO1MbwvRKZd5zlOXEI34A8kPAm9abu/qoZXS/3zz6dVv6R/1J3RgsSc4CbFCn13
 ki0v2iCaqwdRPr9II1XHDyX25OnMlNjCgKw8a875SixeXWSdoABpFCuDft8C5aNqz8Vw
 FO388ZSqXc6eoRA3GsKSmxOe3kGYuTXEwSGzlRjxz16yY5DtCh2Hk/1LC1tLcLROS/ne
 ZapA==
X-Gm-Message-State: AOJu0YwBdf284TVlV4eXjT+c/ypVfM/xK7swpA/AIFns7Btan4WH8fIb
 pecBihzNTcBYiw8jtpOXW7zvX98knQeFwPhzt49V4AUxoqACkVp7iSHY2LFZD6ZTJPMJK/EI7CS
 jx5gbaBqpSxG5t6ocHRSBlLvV3RnosYEu6hENzA==
X-Google-Smtp-Source: AGHT+IH4K+6FGNb2pGezkw5KEQ8xuJ5KZEAWDAm9NiR5b6r30plhs4RuAY79Jl0phylFJVjKvcnX7ltXwJp6UXhBV6Q=
X-Received: by 2002:a05:6402:5408:b0:5c8:93fe:3f7e with SMTP id
 4fb4d7f45d1cf-5c933550288mr8197220a12.11.1728718912098; Sat, 12 Oct 2024
 00:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-15-sughosh.ganu@linaro.org>
 <CAC_iWj+YXbNakXZijoV8SFMRO0p17skLM5c5+VuO6ZDYXsoCYg@mail.gmail.com>
In-Reply-To: <CAC_iWj+YXbNakXZijoV8SFMRO0p17skLM5c5+VuO6ZDYXsoCYg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 12 Oct 2024 13:11:41 +0530
Message-ID: <CADg8p95AhuwaZ9WpMAerp+h+jNEO=rvpvz8AhqXp9x1n1XXzVA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] efi_memory: rename variable to highlight overlap
 with free memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
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

On Fri, 11 Oct 2024 at 16:29, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The functions to add a memory region to the EFI memory map have a
> > variable, overlap_only_ram, which is used to indicate if a new memory
> > region needs to be carved out from the free, or conventional
> > memory.
>
> This is a bit confusing. Conventional memory is free memory.
> Isn't it this from conventional or non-conventional memory?

Okay, I will try to frame this sentence better.

>
> > The name overlap_only_ram is a bit confusing, as other
> > allocated memory regions, like boot-services code and data are also
> > part of the RAM memory. Rename the variable to highlight the fact that
> > it is the free/conventional memory that is being referred to in this
> > context.
>
> overlap_conventional should be even better?

Indeed, it is much better. Will change. Thanks.

-sughosh

>
> Thanks
> /Ilias
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  include/efi_loader.h        | 16 +++++++-----
> >  lib/efi_loader/efi_memory.c | 51 ++++++++++++++++++++-----------------
> >  2 files changed, 37 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 0d5555c7597..c3512c63a50 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -788,15 +788,17 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> >  /**
> >   * efi_add_memory_map_pg() - add pages to the memory map
> >   *
> > - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > - * @pages:             number of pages to add
> > - * @memory_type:       type of memory added
> > - * @overlap_only_ram:  region may only overlap RAM
> > - * Return:             status code
> > + * @start:                     start address, must be a multiple of
> > + *                             EFI_PAGE_SIZE
> > + * @pages:                     number of pages to add
> > + * @memory_type:               type of memory added
> > + * @overlap_only_freemem:      region may only overlap free(conventional)
> > + *                             memory
> > + * Return:                     status code
> >   */
> >  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > -                                         int memory_type,
> > -                                         bool overlap_only_ram);
> > +                                  int memory_type,
> > +                                  bool overlap_only_freemem);
> >
> >  /* Called by board init to initialize the EFI drivers */
> >  efi_status_t efi_driver_init(void);
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 0f25094dbf8..97b89a97a2e 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -173,17 +173,19 @@ static void efi_mem_sort(void)
> >  /**
> >   * efi_mem_carve_out() - unmap memory region
> >   *
> > - * @map:               memory map
> > - * @carve_desc:                memory region to unmap
> > - * @overlap_only_ram:  the carved out region may only overlap RAM
> > - * Return:             the number of overlapping pages which have been
> > - *                     removed from the map,
> > - *                     EFI_CARVE_NO_OVERLAP, if the regions don't overlap,
> > - *                     EFI_CARVE_OVERLAPS_NONRAM, if the carve and map overlap,
> > - *                     and the map contains anything but free ram
> > - *                     (only when overlap_only_ram is true),
> > - *                     EFI_CARVE_LOOP_AGAIN, if the mapping list should be
> > - *                     traversed again, as it has been altered.
> > + * @map:                       memory map
> > + * @carve_desc:                        memory region to unmap
> > + * @overlap_only_freemem:      the carved out region may only overlap free,
> > + *                             or conventional memory
> > + * Return:                     the number of overlapping pages which have been
> > + *                             removed from the map,
> > + *                             EFI_CARVE_NO_OVERLAP, if the regions don't
> > + *                             overlap, EFI_CARVE_OVERLAPS_NONRAM, if the carve
> > + *                             and map overlap, and the map contains anything
> > + *                             but free ram(only when overlap_only_freemem is
> > + *                             true),
> > + *                             EFI_CARVE_LOOP_AGAIN, if the mapping list should
> > + *                             be traversed again, as it has been altered.
> >   *
> >   * Unmaps all memory occupied by the carve_desc region from the list entry
> >   * pointed to by map.
> > @@ -193,7 +195,7 @@ static void efi_mem_sort(void)
> >   */
> >  static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                              struct efi_mem_desc *carve_desc,
> > -                            bool overlap_only_ram)
> > +                            bool overlap_only_freemem)
> >  {
> >         struct efi_mem_list *newmap;
> >         struct efi_mem_desc *map_desc = &map->desc;
> > @@ -208,7 +210,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                 return EFI_CARVE_NO_OVERLAP;
> >
> >         /* We're overlapping with non-RAM, warn the caller if desired */
> > -       if (overlap_only_ram && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > +       if (overlap_only_freemem && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> >                 return EFI_CARVE_OVERLAPS_NONRAM;
> >
> >         /* Sanitize carve_start and carve_end to lie within our bounds */
> > @@ -258,15 +260,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >  /**
> >   * efi_add_memory_map_pg() - add pages to the memory map
> >   *
> > - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > - * @pages:             number of pages to add
> > - * @memory_type:       type of memory added
> > - * @overlap_only_ram:  region may only overlap RAM
> > - * Return:             status code
> > + * @start:                     start address, must be a multiple of
> > + *                             EFI_PAGE_SIZE
> > + * @pages:                     number of pages to add
> > + * @memory_type:               type of memory added
> > + * @overlap_only_freemem:      region may only overlap free(conventional)
> > + *                             memory
> > + * Return:                     status code
> >   */
> >  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > -                                         int memory_type,
> > -                                         bool overlap_only_ram)
> > +                                  int memory_type,
> > +                                  bool overlap_only_freemem)
> >  {
> >         struct efi_mem_list *lmem;
> >         struct efi_mem_list *newlist;
> > @@ -275,7 +279,8 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >         struct efi_event *evt;
> >
> >         EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> > -                 start, pages, memory_type, overlap_only_ram ? "yes" : "no");
> > +                 start, pages, memory_type, overlap_only_freemem ?
> > +                 "yes" : "no");
> >
> >         if (memory_type >= EFI_MAX_MEMORY_TYPE)
> >                 return EFI_INVALID_PARAMETER;
> > @@ -312,7 +317,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >                         s64 r;
> >
> >                         r = efi_mem_carve_out(lmem, &newlist->desc,
> > -                                             overlap_only_ram);
> > +                                             overlap_only_freemem);
> >                         switch (r) {
> >                         case EFI_CARVE_OUT_OF_RESOURCES:
> >                                 free(newlist);
> > @@ -348,7 +353,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >                 }
> >         } while (carve_again);
> >
> > -       if (overlap_only_ram && (carved_pages != pages)) {
> > +       if (overlap_only_freemem && (carved_pages != pages)) {
> >                 /*
> >                  * The payload wanted to have RAM overlaps, but we overlapped
> >                  * with an unallocated region. Error out.
> > --
> > 2.34.1
> >
