Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFCDD6D23C
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 21:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18C38980E;
	Wed, 27 Nov 2024 22:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3QyQ6W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB2589827; Wed, 27 Nov 2024 22:09:57 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0B3897EA
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 22:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so22782966b.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732741794; x=1733346594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gsmdoYSImDWkGHgcqYHAqZ0LF6l2zEej959A5bz1Mv0=;
 b=j3QyQ6W7S/Qc4RaqrPdk1bPExXWeyIyLXtEOnyyeygYWCeiZvCcdgWyEMFK342LL1H
 gf4HqbYFtFJPlGFOEb3SPUXuQ26TfA0tKkzuS6huJca6AlVvT6CZqxsd2RgB6YTs3W47
 ORhbN+k35HVhRO2JJMUcemtNuAsTzN+nYNOYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732741794; x=1733346594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsmdoYSImDWkGHgcqYHAqZ0LF6l2zEej959A5bz1Mv0=;
 b=WJN14Cqng4xNbYkpNAvu/9OcJDHWiHdp3W73fB95WY7I3pf24IzMqH4F4ncFVuQTd6
 Vz/yUBXP8vHJlZ0Q25l01X+uvkMhiLMTPhj7h/DOC3FcMzFMWPqQipvu4gvGMNy2tJ0G
 jFbC/0P+fS1ZfqjoPCHsLp6Cn5+UAqTH7kIjRyHHry7j3ClIPwVWpVAHQ0vOZ50NkhGG
 8TODimWJ8fZUfxinMeVq3Mmwd3bWYDy7dgwrshZ9qJt7ZXaR78IHCNNUGVA4pvn2gQq3
 +FnNQz3BrhJdhR4cNl7oewJ+q4QfGlKfsEW7jMecYfzx7AWTenYHQlE8SGxvc+iIdVIe
 scVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3J6SHa9Qj1UDYssft/qvQwv/h8BWfhit9t+edz6uLfmHrUIIOCGtxtTPqKzzEf0HPRDyjnxY=@lists.denx.de
X-Gm-Message-State: AOJu0YyH5lIIh7VHnQrbgD3KZVzH7is5mlYDeKrKjcj+u4ksqdwZCJn0
 5D05V3fdJ3StTHywvMrqB+RrECvjc9/NEr/sCjiIRtI4uISX9R9ixnQQ8BpQGpfzEME0Bituw8U
 e12uYEoTbJCEPKm78qTfro9DQCsmLbkTh/Tept3be1GdjtZg=
X-Gm-Gg: ASbGnctsUewqXU/n4Wu240wvpllhM5oPBL5A0A5ZKBnIem006Ka2VglLLI7RuP6jbnw
 zoNPD1Csc3vIO3h4JlXjzE+cIMY9CiKBn
X-Google-Smtp-Source: AGHT+IGeDmaZWLDMJlhVfHP+Q9MhMjXoPxXxmVXWZG5pOErd9NnSmV56E+o1+OcN5rEQHy4BIf8aOlEtoVyHpCkRsQY=
X-Received: by 2002:a17:906:3143:b0:aa5:11fa:626d with SMTP id
 a640c23a62f3a-aa580ee013dmr452516666b.3.1732741794025; Wed, 27 Nov 2024
 13:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
In-Reply-To: <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 14:09:42 -0700
Message-ID: <CAFLszTjDpZYcAoWNetOsyD1SNCob9rx2w530K2oVGiRCNFUy8w@mail.gmail.com>
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 27 Nov 2024 at 11:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 27.11.24 18:17, Tom Rini wrote:
> > From: Simon Glass <sjg@chromium.org>
> >
> > The cache-flush function is incorrect which causes a crash in the
> > remoteproc tests with arm64.
> >
> > Fix both problems by using map_sysmem() to convert an address to a
> > pointer and map_to_sysmem() to convert a pointer to an address.
> >
> > Also update the image-loader's cache-flushing logic.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> > Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
> > Changes in v6:
> > - Re-introduce
> >
> > Changes in v2:
> > - Drop message about EFI_LOADER
> >
> >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> >   3 files changed, 20 insertions(+), 9 deletions(-)
> > ---
> >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> >   3 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> > index c8a5e64214b6..96b3da47e8ed 100644
> > --- a/arch/sandbox/cpu/cache.c
> > +++ b/arch/sandbox/cpu/cache.c
> > @@ -4,12 +4,18 @@
> >    */
> >
> >   #include <cpu_func.h>
> > +#include <mapmem.h>
> >   #include <asm/state.h>
> >
> >   void flush_cache(unsigned long addr, unsigned long size)
> >   {
> > +     void *ptr;
> > +
> > +     ptr = map_sysmem(addr, size);
> > +
> >       /* Clang uses (char *) parameters, GCC (void *) */
> > -     __builtin___clear_cache((void *)addr, (void *)(addr + size));
> > +     __builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> > +     unmap_sysmem(ptr);
> >   }
> >
> >   void invalidate_icache_all(void)
> > diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
> > index ab1836b3f078..0b3941b7798d 100644
> > --- a/drivers/remoteproc/rproc-elf-loader.c
> > +++ b/drivers/remoteproc/rproc-elf-loader.c
> > @@ -6,6 +6,7 @@
> >   #include <dm.h>
> >   #include <elf.h>
> >   #include <log.h>
> > +#include <mapmem.h>
> >   #include <remoteproc.h>
> >   #include <asm/cache.h>
> >   #include <dm/device_compat.h>
> > @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> >       for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> >               void *dst = (void *)(uintptr_t)phdr->p_paddr;
> >               void *src = (void *)addr + phdr->p_offset;
> > +             ulong dst_addr;
> >
> >               if (phdr->p_type != PT_LOAD)
> >                       continue;
> > @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> >               if (phdr->p_filesz != phdr->p_memsz)
> >                       memset(dst + phdr->p_filesz, 0x00,
> >                              phdr->p_memsz - phdr->p_filesz);
> > -             flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -                         roundup((unsigned long)dst + phdr->p_filesz,
> > +             dst_addr = map_to_sysmem(dst);
> > +             flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +                         roundup(dst_addr + phdr->p_filesz,
> >                                   ARCH_DMA_MINALIGN) -
> > -                         rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +                         rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >       }
> >
> >       return 0;
> > @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> >       const struct dm_rproc_ops *ops;
> >       Elf32_Shdr *shdr;
> >       void *src, *dst;
> > +     ulong dst_addr;
> >
> >       shdr = rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> >       if (!shdr)
> > @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> >               (ulong)dst, *rsc_size);
> >
> >       memcpy(dst, src, *rsc_size);
> > -     flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -                 roundup((unsigned long)dst + *rsc_size,
> > -                         ARCH_DMA_MINALIGN) -
> > -                 rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +     dst_addr = map_to_sysmem(dst);
> > +     flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +                 roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> > +                 rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >
> >       return 0;
> >   }
> > diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> > index 0ddf69a09183..bb58cf1badb7 100644
> > --- a/lib/efi_loader/efi_image_loader.c
> > +++ b/lib/efi_loader/efi_image_loader.c
> > @@ -13,6 +13,7 @@
> >   #include <efi_loader.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <mapmem.h>
> >   #include <pe.h>
> >   #include <sort.h>
> >   #include <crypto/mscode.h>
> > @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
> >       }
> >
> >       /* Flush cache */
> > -     flush_cache((ulong)efi_reloc,
> > +     flush_cache(map_to_sysmem(efi_reloc),
> >                   ALIGN(virt_size, EFI_CACHELINE_SIZE));
>
> It would be nice if we could be consistent:
>
> include/cpu_func.h:66:
> void flush_cache(unsigned long addr, unsigned long size);
>
> arch/arc/lib/cache.c:773:
> void flush_cache(unsigned long start, unsigned long size)
>
> arch/sandbox/cpu/cache.c:9:
> void flush_cache(unsigned long addr, unsigned long size)

Patches are welcome :-)

They should all be ulong

Regards,
Simon
