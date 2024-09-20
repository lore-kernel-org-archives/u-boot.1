Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56760CE8D43
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E45389308;
	Fri, 20 Sep 2024 11:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="clOFsTcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793BF8931B; Fri, 20 Sep 2024 11:56:22 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1052E892D9
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5dfad5a9c21so975058eaf.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726826178; x=1727430978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fQy6p2hFixm2BD9RfL23nAmZ3ZvZHyA5T4mSk8VBKCM=;
 b=clOFsTcp6gDdulyZusBB0vicv9P7C6vRw8haPYi/1DN8paLV/d6lUi9j+INV4YXOrm
 lKg2m1MPpn2cE0R3itKRi8RWPQtdkBWVwZxbUA+GigpSQUZD+C2u4MKjeAMueAMFilQX
 OkPGEA29IP3lbjSp9Cn3GaixwxSTX1cO1o6ZictzFMIMnnMDQ+CgOjRGzTynovDUmuY7
 N9/f2yiRY+wpwvOFt1yB5fMivM7LvHlCXBhRUXsLIPItiVcrE3iJX4/65WDEtDGpN5s0
 F4BXy2G7pW+QhL4e7blTbr6AeiJ3Pp18KTD4KZzrVjjWPG/cKrQYq1xiHx1tKM80te0x
 m1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726826178; x=1727430978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQy6p2hFixm2BD9RfL23nAmZ3ZvZHyA5T4mSk8VBKCM=;
 b=S65dra+AFL0r02kinOyN2lzNa5THHJS1WrLvmadoOq42Dp6WnuHLGjfauG/vwi7A99
 gU6IdVGHdQQm0ZXZtVjdmwodh9GSuAh5M+/yltxndExIQk60yuTbsK0VkJGYQvQu5PdV
 jUmkWEi49atXEPzTGTC/rucoR0Oz0TX9Nqk1JM0LQkEj5NvuVFOydYin2WjGamT9v72d
 K0qw1hm9IwEgtFHbNrYhMsa+SByZngVbpTixvo7QpZwboHHquqpty7w0qgc4SEJXSzW/
 sK8oeUXurh6gsoc+1oMKTPKS1jBk0ZwOd0O1vx2WCCG3LFI0+ph4yvL0/sHNEQLOiN/L
 CY9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkRNNm83C6WMNnnySD77Y706tvpnlREshDM7Hwf4ZiMU/aL4p+4Vn8R+EeLEIe2uvVaKnlb98=@lists.denx.de
X-Gm-Message-State: AOJu0YzG5FkzrIWzDP4Uto9k2OYRT8geEZgR30C+c0VPXsdj+/0UORum
 IMk8xl8dRWIPpy6dV8vlHowUrd9bWPUe0LS01VwPfdE92AHaKZzm+nTjc1zoRf8KqxCbd3jU+wt
 7fahPnbzCRGb8VWyQV3fETkQfTjzkCZYTK3cYjg==
X-Google-Smtp-Source: AGHT+IFM/2nodpTJP/pNNGznMAWJLRQBoQlMItL4hkVsG4u6p7FPq1atzmoe+eF/VpXqWBT68gpZf5qLR2P0spCmWvg=
X-Received: by 2002:a05:6870:1682:b0:27c:ec9d:e5d with SMTP id
 586e51a60fabf-2803a90501emr1899432fac.45.1726826177764; Fri, 20 Sep 2024
 02:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-4-sughosh.ganu@linaro.org>
 <78cbfbf1-91b9-49ad-9b14-962183ee52be@gmx.de>
 <CADg8p95ExGK3VAGo+VOE-7SHidHyfBYqscOYX+JqGhXYRqqWsg@mail.gmail.com>
In-Reply-To: <CADg8p95ExGK3VAGo+VOE-7SHidHyfBYqscOYX+JqGhXYRqqWsg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 12:55:41 +0300
Message-ID: <CAC_iWjJXJULJY6t0tX3xwkMjgeMBpafHsETF_4c-SuQvg8nYaA@mail.gmail.com>
Subject: Re: [PATCH 03/16] efi: memory: use the lmb API's for allocating and
 freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Sughosh,

On Tue, 17 Sept 2024 at 15:09, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sat, 14 Sept 2024 at 20:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > LMB module becomes the common backend for managing non U-Boot image
> > > memory that might be requested by other modules.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >   lib/efi_loader/Kconfig      |  1 +
> > >   lib/efi_loader/efi_memory.c | 74 ++++++++++---------------------------
> > >   2 files changed, 21 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 6ffefa9103..911d4c6bbe 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -18,6 +18,7 @@ config EFI_LOADER
> > >       select DM_EVENT
> > >       select EVENT_DYNAMIC
> > >       select LIB_UUID
> > > +     select LMB
> > >       imply PARTITION_UUIDS
> > >       select REGEX
> > >       imply FAT
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index c6f1dd0945..90e07ed6a2 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -9,6 +9,7 @@
> > >
> > >   #include <efi_loader.h>
> > >   #include <init.h>
> > > +#include <lmb.h>
> > >   #include <log.h>
> > >   #include <malloc.h>
> > >   #include <mapmem.h>
> > > @@ -432,53 +433,6 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
> > >       return EFI_NOT_FOUND;
> > >   }
> > >
> > > -/**
> > > - * efi_find_free_memory() - find free memory pages
> > > - *
> > > - * @len:     size of memory area needed
> > > - * @max_addr:        highest address to allocate
> > > - * Return:   pointer to free memory area or 0
> > > - */
> > > -static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
> > > -{
> > > -     struct efi_mem_list *lmem;
> > > -
> > > -     /*
> > > -      * Prealign input max address, so we simplify our matching
> > > -      * logic below and can just reuse it as return pointer.
> > > -      */
> > > -     max_addr &= ~EFI_PAGE_MASK;
> > > -
> > > -     list_for_each_entry(lmem, &efi_mem, link) {
> > > -             struct efi_mem_desc *desc = &lmem->desc;
> > > -             uint64_t desc_len = desc->num_pages << EFI_PAGE_SHIFT;
> > > -             uint64_t desc_end = desc->physical_start + desc_len;
> > > -             uint64_t curmax = min(max_addr, desc_end);
> > > -             uint64_t ret = curmax - len;
> > > -
> > > -             /* We only take memory from free RAM */
> > > -             if (desc->type != EFI_CONVENTIONAL_MEMORY)
> > > -                     continue;
> > > -
> > > -             /* Out of bounds for max_addr */
> > > -             if ((ret + len) > max_addr)
> > > -                     continue;
> > > -
> > > -             /* Out of bounds for upper map limit */
> > > -             if ((ret + len) > desc_end)
> > > -                     continue;
> > > -
> > > -             /* Out of bounds for lower map limit */
> > > -             if (ret < desc->physical_start)
> > > -                     continue;
> > > -
> > > -             /* Return the highest address in this map within bounds */
> > > -             return ret;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > >   /**
> > >    * efi_allocate_pages - allocate memory pages
> > >    *
> > > @@ -493,6 +447,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> > >                               efi_uintn_t pages, uint64_t *memory)
> > >   {
> > >       u64 len;
> > > +     uint flags;
> > >       efi_status_t ret;
> > >       uint64_t addr;
> > >
> > > @@ -508,33 +463,35 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> > >           (len >> EFI_PAGE_SHIFT) != (u64)pages)
> > >               return EFI_OUT_OF_RESOURCES;
> > >
> > > +     flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
> >
> > In the EFI context we should use LMB notification to notify the
> > EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event and update the memory map.
>
> Not sure if I am understanding your comment right, but what is
> happening here is that the EFI subsystem is requesting LMB for memory.
> And the reason why we have a flag LMB_NONOTIFY, is to prevent a
> circular chain of LMB then notifying EFI of a change to it's memory
> map.
>
> >
> > See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> > specification.
> >
> > >       switch (type) {
> > >       case EFI_ALLOCATE_ANY_PAGES:
> > >               /* Any page */
> > > -             addr = efi_find_free_memory(len, -1ULL);
> > > +             addr = (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);
> >
> > On ARM64 we must ensure that "all 4KiB pages in the 64KiB page ... use
> > identical ARM Memory Page Attributes". I cannot see how LMB implements this.
>
> If you are referring to arm memory attributes, this is not being
> handled by the current EFI  memory code as well. If this is to be
> handled, that needs to be taken up as a separate task -- I am not sure
> if U-Boot even has support in the form of any API's where memory
> regions can be configured for different memory attributes.

So, we *do* handle some EFI memory attributes currently, in
efi_add_memory_map_pg(), but we don't translate those to Arm memory
attributes. The latter should indeed be a task, but I think what
Henrich is saying here is orthogonal. Regardless of what happens to
the mmu in the future the spec says "a 64KiB physical page contains
any 4KiB page with any of the following types listed below, then all
4KiB pages in the 64KiB page must use identical ARM Memory Page
Attribute". So for runtime services/code, EfiACPIMemoryNVS and
reserved memory we should group similar attributes in 64k boundaries.
I think this is something worth planning ahead, instead of plugging
holes afterwards

Cheers
/Ilias

>
> >
> > See chapter 2.3.6 AArch64 Platforms in the UEFI specification.
> >
> > If you pass the EFI memory type to LMB and store it there, we can avoid
> > duplication of the memory map and we can implement the 64 KiB pages
> > logic in LMB.
>
> Okay, that would mean mixing up EFI code in the LMB module. Again, not
> sure if this comes under the purview of the goal of this series, which
> is to ensure that EFI memory does not trample over that allocated by
> LMB. Also, thinking a bit more on this, if we are to address aspects
> like memory attributes etc, I feel that the earlier design that I had
> posted of notification between LMB and EFI to have a synchronous view
> of each other's memory would be a better approach. That way, the EFI
> memory module can then implement things that it needs to, from the EFI
> spec point of view, and the LMB module can then just update the EFI
> module of the memory that it is using.
>
> -sughosh
>
> >
> > Best regards
> >
> > Heinrich
> >
> > >               if (!addr)
> > >                       return EFI_OUT_OF_RESOURCES;
> > >               break;
> > >       case EFI_ALLOCATE_MAX_ADDRESS:
> > >               /* Max address */
> > > -             addr = efi_find_free_memory(len, *memory);
> > > +             addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memory,
> > > +                                              flags);
> > >               if (!addr)
> > >                       return EFI_OUT_OF_RESOURCES;
> > >               break;
> > >       case EFI_ALLOCATE_ADDRESS:
> > >               if (*memory & EFI_PAGE_MASK)
> > >                       return EFI_NOT_FOUND;
> > > -             /* Exact address, reserve it. The addr is already in *memory. */
> > > -             ret = efi_check_allocated(*memory, false);
> > > -             if (ret != EFI_SUCCESS)
> > > -                     return EFI_NOT_FOUND;
> > > -             addr = *memory;
> > > +
> > > +             addr = (u64)lmb_alloc_addr_flags(*memory, len, flags);
> > > +             if (!addr)
> > > +                     return EFI_OUT_OF_RESOURCES;
> > >               break;
> > >       default:
> > >               /* UEFI doesn't specify other allocation types */
> > >               return EFI_INVALID_PARAMETER;
> > >       }
> > >
> > > +     addr = (u64)(uintptr_t)map_sysmem(addr, 0);
> > >       /* Reserve that map in our memory maps */
> > >       ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
> > >       if (ret != EFI_SUCCESS)
> > > @@ -555,6 +512,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> > >    */
> > >   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> > >   {
> > > +     u64 len;
> > > +     uint flags;
> > > +     long status;
> > >       efi_status_t ret;
> > >
> > >       ret = efi_check_allocated(memory, true);
> > > @@ -568,6 +528,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> > >               return EFI_INVALID_PARAMETER;
> > >       }
> > >
> > > +     flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
> > > +     len = (u64)pages << EFI_PAGE_SHIFT;
> > > +     status = lmb_free_flags(memory, len, flags);
> > > +     if (status)
> > > +             return EFI_NOT_FOUND;
> > > +
> > >       ret = efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
> > >                                   false);
> > >       if (ret != EFI_SUCCESS)
> >
