Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92341D7360A
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 20:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E998D888D5;
	Sat, 30 Nov 2024 21:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QCUh/2dk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2958D8855C; Sat, 30 Nov 2024 21:24:53 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12BA88E4B
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d0c7c8cd6cso1527501a12.0
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732998285; x=1733603085; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t2zymNZFGsDmmfnBtDwzAF+EcReF+m94LJ/quZT818Y=;
 b=QCUh/2dke61A/O8+T5MGjoymSYD+A1AWOd7MqNVCckYrdgnsWsp7oNNdoyXlcitr9+
 eFtUdVANB4ws/pgSxhBQ5IEYH+y1aUo9ohkp1haON+FSBGbIvnSZm09FKqKK/g66XRiZ
 6zp61X5guX0EmW8qdFoIMTerAbmWer9RWuQTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732998285; x=1733603085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2zymNZFGsDmmfnBtDwzAF+EcReF+m94LJ/quZT818Y=;
 b=BPjzg5Eh2+HfGGH42hol2spRmBm/pvC8X6lqaj5rKDhuKlZF6QGQDs0UOykie3Nh8f
 6MbyHY2GsmlzNmERJvK6EADdGczPwLc82hiGIQpH6vjjOilmNGtafwB9LOb+daAAFH5/
 mq8EBBmqDeUMub5Xou+VvEbFwrSCVSe9D1ZiLT3rbEP+uRB0V1lJ4ZiUOhBtyHY+ACPv
 FzspyRtVxAmNkf528wdwyarOn2l4crsxlY85uqWNahXypI3b0tlpStCp/qjwQfS2/yLm
 nBIrUGTXiktRtjg1qeGocUxhkt7Bl5voh+VG9sysLoNivER+8mhQwi/OyiARGByVpI0P
 07Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmLSGiOQRd/gzZmnvCzXQEAzU7sX2dQpna3v9dU0KO0wx080JeF7LAQQUCA5nxSmt1/8cAzGA=@lists.denx.de
X-Gm-Message-State: AOJu0YxYXJuMVBgb3nLd2L4JqzL6/0PujMaOrbYNx3YQ9HHqtew8FkHH
 112C5WsNaCyrwp55DnZcAQcxHmcOiAXb/x7Xsuq4mdJhh3vh470und/nIPq+AM1LHvo8nH2L9Li
 X/GLPp+91eivirjcnnyWbbTdHpgdnqm2OVBi9
X-Gm-Gg: ASbGncvvt0oSvcLGkcwDsPl/7GdS8dnZuBzWI9mRJBCXtIA2ImpaA38+ndjrJchHe7Z
 O6IUnDBRBmjHNOyZ4D4O8d6/7q8hGR7s=
X-Google-Smtp-Source: AGHT+IF252P27Sm6s5gIkeTSJLD0Umc1H7Q7hmKqupk7UBoDplVA863lv/8T8R3MXI7Zvlx1/91th2901rlnKG1tkX8=
X-Received: by 2002:a17:907:7758:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa59450670amr1505271166b.2.1732998284926; Sat, 30 Nov 2024
 12:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
 <CAFLszTjDpZYcAoWNetOsyD1SNCob9rx2w530K2oVGiRCNFUy8w@mail.gmail.com>
 <20241127211427.GD3600562@bill-the-cat>
In-Reply-To: <20241127211427.GD3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 13:24:33 -0700
Message-ID: <CAFLszThgX9PnzSNmxXDBz1j61Fu-4eCpT8cR2MC809UJaSJ1UA@mail.gmail.com>
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Wed, 27 Nov 2024 at 14:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 27, 2024 at 02:09:42PM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 27 Nov 2024 at 11:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 27.11.24 18:17, Tom Rini wrote:
> > > > From: Simon Glass <sjg@chromium.org>
> > > >
> > > > The cache-flush function is incorrect which causes a crash in the
> > > > remoteproc tests with arm64.
> > > >
> > > > Fix both problems by using map_sysmem() to convert an address to a
> > > > pointer and map_to_sysmem() to convert a pointer to an address.
> > > >
> > > > Also update the image-loader's cache-flushing logic.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> > > > Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > >
> > > > Changes in v6:
> > > > - Re-introduce
> > > >
> > > > Changes in v2:
> > > > - Drop message about EFI_LOADER
> > > >
> > > >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> > > >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> > > >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> > > >   3 files changed, 20 insertions(+), 9 deletions(-)
> > > > ---
> > > >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> > > >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> > > >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> > > >   3 files changed, 20 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> > > > index c8a5e64214b6..96b3da47e8ed 100644
> > > > --- a/arch/sandbox/cpu/cache.c
> > > > +++ b/arch/sandbox/cpu/cache.c
> > > > @@ -4,12 +4,18 @@
> > > >    */
> > > >
> > > >   #include <cpu_func.h>
> > > > +#include <mapmem.h>
> > > >   #include <asm/state.h>
> > > >
> > > >   void flush_cache(unsigned long addr, unsigned long size)
> > > >   {
> > > > +     void *ptr;
> > > > +
> > > > +     ptr = map_sysmem(addr, size);
> > > > +
> > > >       /* Clang uses (char *) parameters, GCC (void *) */
> > > > -     __builtin___clear_cache((void *)addr, (void *)(addr + size));
> > > > +     __builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> > > > +     unmap_sysmem(ptr);
> > > >   }
> > > >
> > > >   void invalidate_icache_all(void)
> > > > diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
> > > > index ab1836b3f078..0b3941b7798d 100644
> > > > --- a/drivers/remoteproc/rproc-elf-loader.c
> > > > +++ b/drivers/remoteproc/rproc-elf-loader.c
> > > > @@ -6,6 +6,7 @@
> > > >   #include <dm.h>
> > > >   #include <elf.h>
> > > >   #include <log.h>
> > > > +#include <mapmem.h>
> > > >   #include <remoteproc.h>
> > > >   #include <asm/cache.h>
> > > >   #include <dm/device_compat.h>
> > > > @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> > > >       for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> > > >               void *dst = (void *)(uintptr_t)phdr->p_paddr;
> > > >               void *src = (void *)addr + phdr->p_offset;
> > > > +             ulong dst_addr;
> > > >
> > > >               if (phdr->p_type != PT_LOAD)
> > > >                       continue;
> > > > @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> > > >               if (phdr->p_filesz != phdr->p_memsz)
> > > >                       memset(dst + phdr->p_filesz, 0x00,
> > > >                              phdr->p_memsz - phdr->p_filesz);
> > > > -             flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > > > -                         roundup((unsigned long)dst + phdr->p_filesz,
> > > > +             dst_addr = map_to_sysmem(dst);
> > > > +             flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > > > +                         roundup(dst_addr + phdr->p_filesz,
> > > >                                   ARCH_DMA_MINALIGN) -
> > > > -                         rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > > > +                         rounddown(dst_addr, ARCH_DMA_MINALIGN));
> > > >       }
> > > >
> > > >       return 0;
> > > > @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> > > >       const struct dm_rproc_ops *ops;
> > > >       Elf32_Shdr *shdr;
> > > >       void *src, *dst;
> > > > +     ulong dst_addr;
> > > >
> > > >       shdr = rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> > > >       if (!shdr)
> > > > @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> > > >               (ulong)dst, *rsc_size);
> > > >
> > > >       memcpy(dst, src, *rsc_size);
> > > > -     flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > > > -                 roundup((unsigned long)dst + *rsc_size,
> > > > -                         ARCH_DMA_MINALIGN) -
> > > > -                 rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > > > +     dst_addr = map_to_sysmem(dst);
> > > > +     flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > > > +                 roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> > > > +                 rounddown(dst_addr, ARCH_DMA_MINALIGN));
> > > >
> > > >       return 0;
> > > >   }
> > > > diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> > > > index 0ddf69a09183..bb58cf1badb7 100644
> > > > --- a/lib/efi_loader/efi_image_loader.c
> > > > +++ b/lib/efi_loader/efi_image_loader.c
> > > > @@ -13,6 +13,7 @@
> > > >   #include <efi_loader.h>
> > > >   #include <log.h>
> > > >   #include <malloc.h>
> > > > +#include <mapmem.h>
> > > >   #include <pe.h>
> > > >   #include <sort.h>
> > > >   #include <crypto/mscode.h>
> > > > @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
> > > >       }
> > > >
> > > >       /* Flush cache */
> > > > -     flush_cache((ulong)efi_reloc,
> > > > +     flush_cache(map_to_sysmem(efi_reloc),
> > > >                   ALIGN(virt_size, EFI_CACHELINE_SIZE));
> > >
> > > It would be nice if we could be consistent:
> > >
> > > include/cpu_func.h:66:
> > > void flush_cache(unsigned long addr, unsigned long size);
> > >
> > > arch/arc/lib/cache.c:773:
> > > void flush_cache(unsigned long start, unsigned long size)
> > >
> > > arch/sandbox/cpu/cache.c:9:
> > > void flush_cache(unsigned long addr, unsigned long size)
> >
> > Patches are welcome :-)
> >
> > They should all be ulong
>
> Please note that they are all consistent in prototypes and
> functionality. arc just says "start" rather than "addr" and everyone
> uses them in the same way. The issue, as the Fixes tag shows, is that
> sandbox's isn't complete.

I wasn't suggesting you change this patch, just suggesting what
Heinrich might do if he wants to send a separate patch.

Regards,
Simon
