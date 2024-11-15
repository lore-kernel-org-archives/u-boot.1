Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE47D637CE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2781E88FA5;
	Fri, 15 Nov 2024 14:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FEPB93CL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED95E88FB5; Fri, 15 Nov 2024 14:53:29 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D905A88C7E
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso3008649e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678807; x=1732283607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TjkEQ7/GzxNtjqAj5q/2XFcN1OxrqkFlzf7+GK6etnI=;
 b=FEPB93CLWmWAsVBoDXA+cgRHCd+lyusJ9F+eT/DxjISYhvJ17SFSY3sovscESANSfP
 oGleXFJkNvEz88uFhl6ambq6woayJBHoHnuOx8yRvq71MihGnh+4oohDK4AgGuxFjZ8V
 E1SiwDzFP0cR495lKHVABrRczP401cmXvNN8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678807; x=1732283607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjkEQ7/GzxNtjqAj5q/2XFcN1OxrqkFlzf7+GK6etnI=;
 b=BWWbge9yDVcdcuoSWF1PHMz5oncVu1PchBzX4oL+wYaEzZEDCRAJ2rb2Huj/2FLZ4a
 cM64TVEs4cbpZePNFzIOq4vb2OVnK7ckuX8pcnDS8tIwX/G+E93xwR6q5NzYnhKfJl5A
 JKjZtrceSKniQukQXNpmirPBUhx6daAcJ7oJqo4NnCgB1ahwCSLVDi5ssMqBvzt2fIMg
 zkzYQrStLXkdTHCXsWWfoLYp7PCd0buqxbBb9zxyxZq+HiIfdtJjQEmJhAB9mhlAZH6t
 IrSukEn2AXp47aBDBSZXOC5PID/ICqYe2b7DKdcqFLDJ1858YEpQSBOjf5n7CbdMxtOU
 eBaQ==
X-Gm-Message-State: AOJu0YzMZll6Cb7Ts8Sk9dS47yLh8CyqaaHaykB6i13ureG6JsijzvMG
 ggE3zYW+RG2gII/fhGw9WhUshogjD5KyFSzkX5T0cVYRDxEmkcfVrXhWVGMZodFR3PTGLvT1sxa
 xxkVJGFaXNOFqDuDeoxeqLjfnNsru9DMcaq0qkd0ZBd2sjnE=
X-Google-Smtp-Source: AGHT+IFUSXrxOR75s6hfCZt0ZGcdyQec+JAOuclFdLO6BbT+kM/HWyHhWgSTFgiki/i1A85KcOOnCZx8n1nZ53d8huY=
X-Received: by 2002:a05:6512:6c9:b0:53d:a025:1142 with SMTP id
 2adb3069b0e04-53dab3bc29fmr2417201e87.54.1731678806948; Fri, 15 Nov 2024
 05:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-2-sjg@chromium.org>
 <CAC_iWjJB4=6Zm8XsgiQcQkUzoDOWnAowzf6C3sVvXNQTv_oByA@mail.gmail.com>
In-Reply-To: <CAC_iWjJB4=6Zm8XsgiQcQkUzoDOWnAowzf6C3sVvXNQTv_oByA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 06:53:15 -0700
Message-ID: <CAFLszTirwS0svRfOA-k-XcKhrWv9E_FaSfda5ziURaf=ynzTqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Ilias,

On Thu, 14 Nov 2024 at 00:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 12 Nov 2024 at 16:11, Simon Glass <sjg@chromium.org> wrote:
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
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Drop message about EFI_LOADER
> >
> >  arch/sandbox/cpu/cache.c              |  8 +++++++-
> >  drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> >  lib/efi_loader/efi_image_loader.c     |  3 ++-
> >  3 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> > index c8a5e64214b..96b3da47e8e 100644
> > --- a/arch/sandbox/cpu/cache.c
> > +++ b/arch/sandbox/cpu/cache.c
> > @@ -4,12 +4,18 @@
> >   */
> >
> >  #include <cpu_func.h>
> > +#include <mapmem.h>
> >  #include <asm/state.h>
> >
> >  void flush_cache(unsigned long addr, unsigned long size)
> >  {
> > +       void *ptr;
> > +
> > +       ptr = map_sysmem(addr, size);
> > +
> >         /* Clang uses (char *) parameters, GCC (void *) */
> > -       __builtin___clear_cache((void *)addr, (void *)(addr + size));
> > +       __builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> > +       unmap_sysmem(ptr);
> >  }
> >
> >  void invalidate_icache_all(void)
> > diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
> > index ab1836b3f07..0b3941b7798 100644
> > --- a/drivers/remoteproc/rproc-elf-loader.c
> > +++ b/drivers/remoteproc/rproc-elf-loader.c
> > @@ -6,6 +6,7 @@
> >  #include <dm.h>
> >  #include <elf.h>
> >  #include <log.h>
> > +#include <mapmem.h>
> >  #include <remoteproc.h>
> >  #include <asm/cache.h>
> >  #include <dm/device_compat.h>
> > @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> >         for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> >                 void *dst = (void *)(uintptr_t)phdr->p_paddr;
> >                 void *src = (void *)addr + phdr->p_offset;
> > +               ulong dst_addr;
> >
> >                 if (phdr->p_type != PT_LOAD)
> >                         continue;
> > @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
> >                 if (phdr->p_filesz != phdr->p_memsz)
> >                         memset(dst + phdr->p_filesz, 0x00,
> >                                phdr->p_memsz - phdr->p_filesz);
> > -               flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -                           roundup((unsigned long)dst + phdr->p_filesz,
> > +               dst_addr = map_to_sysmem(dst);
> > +               flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +                           roundup(dst_addr + phdr->p_filesz,
> >                                     ARCH_DMA_MINALIGN) -
> > -                           rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +                           rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >         }
> >
> >         return 0;
> > @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> >         const struct dm_rproc_ops *ops;
> >         Elf32_Shdr *shdr;
> >         void *src, *dst;
> > +       ulong dst_addr;
> >
> >         shdr = rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> >         if (!shdr)
> > @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
> >                 (ulong)dst, *rsc_size);
> >
> >         memcpy(dst, src, *rsc_size);
> > -       flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -                   roundup((unsigned long)dst + *rsc_size,
> > -                           ARCH_DMA_MINALIGN) -
> > -                   rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +       dst_addr = map_to_sysmem(dst);
> > +       flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +                   roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> > +                   rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >
> >         return 0;
> >  }
> > diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> > index 0ddf69a0918..bb58cf1badb 100644
> > --- a/lib/efi_loader/efi_image_loader.c
> > +++ b/lib/efi_loader/efi_image_loader.c
> > @@ -13,6 +13,7 @@
> >  #include <efi_loader.h>
> >  #include <log.h>
> >  #include <malloc.h>
> > +#include <mapmem.h>
> >  #include <pe.h>
> >  #include <sort.h>
> >  #include <crypto/mscode.h>
> > @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
> >         }
> >
> >         /* Flush cache */
> > -       flush_cache((ulong)efi_reloc,
> > +       flush_cache(map_to_sysmem(efi_reloc),
>
> Shouldn't we now umap that address on the err: tag?

This address should be in sandbox's DRAM, so there is no mapping
created. The mapping is needed for things that are not in the emulated
DRAM, such as stack variables.

>
> Thanks
> /Ilias
> >                     ALIGN(virt_size, EFI_CACHELINE_SIZE));
> >
> >         /*
> > --
> > 2.34.1
> >

Regards,
Simon
