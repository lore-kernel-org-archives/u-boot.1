Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CD4C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF3A8836E;
	Tue, 11 Jun 2024 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L88q9agr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD9988624; Tue, 11 Jun 2024 11:49:55 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11556880A3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so652999866b.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718099392; x=1718704192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LIV34FSG/o36CG2nBdhM4M7Crm0ujb+72nD8GOuqLzg=;
 b=L88q9agr932Zd9sBHWvy835u4RXGHhaFz9lzs2rEjNuXzUaw9S1lOqaK44mdl0QPdl
 bdwSjIBCy00mXkcSTV7zM21EVpJHh90ljSR33Nulm1kQlubav6ts6qPuxBcq514nSo6Q
 YxiIpwH2GL0j/T0Tz5d1VGfVwSDnqHjtP+8KuZ+fEY2WHlEVM59uVu24Pepm8PdDoG1p
 a4C0xSy8nuV7df40ohTI9zfm7zWgtXHneZWmpscrBibCx6I2yFNlTN9EYiG8aV0fhz5Y
 2FqXb9A4KP3wl+RsTuOsC+PpI81KxKHjMFSi5omhgpvJWucoeWvDC6fvDs2eY//wgkZH
 mD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718099392; x=1718704192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LIV34FSG/o36CG2nBdhM4M7Crm0ujb+72nD8GOuqLzg=;
 b=bNr0+bnClDKvOaY0PK+kaMEuXNIKX+kYpCH6Hr/Tc44ZCU7jSAbN0bMwQKgE5bHhuq
 D6USfI7kOd2cPVWDvnmtPm7dyqgkVb3belA/EbBTaw1gW8GF8k/LKHyEqWqzdaZFsorA
 jnYlVLRcwMhEhmeqmmxLi6qRp1xs7dlQVRAGDSJYyBX98GhnUYyijUsF6e/dT6hHWuo+
 Spp+H2IBpmBFbOPFdH/yMp4IFh8ga8ThNh1Bx6sX7uGPa7dTfK6RMJT60EDPhP447Wey
 BO087ikwCGl0D6ZbIHc+JLt8m3If1qVhcyFV6tzFcx6BWxQ+Fi3Psqn4T2rsjAe9TI/4
 jwrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyUTg99gwvCXFyP8T7+KRvXt5i0AMEquyfIlnUQsp9VVN+0KAR3uEkietX+RdVmTmB6Akfzhndp2UGfuT/ZCaJODW2iA==
X-Gm-Message-State: AOJu0YxpMTWdhQQYlTLNGu4cXDqokyhsYgOq3wHFoZoDwNXCKhzdwvYe
 PNasX5xs8fOTGImhMGHr9KYkBxBqT0kd3YQXU+GWjWRubx41SF3VAmME7tEL7mZE1a2cBAFAUWk
 /qzxxTnv/050oP089zNfFZu14Gi/GflReHzKpbg==
X-Google-Smtp-Source: AGHT+IEd71qbReGD3pwZgWdBbMCV6COvlF3nVMIN8W+G4GXQMEmdYO1aCdEIoh+tyEhKOPymWhUgCcbH5q3PX7A4UmA=
X-Received: by 2002:a17:906:ae4a:b0:a6e:46ab:9a9b with SMTP id
 a640c23a62f3a-a6e46ab9b22mr626400266b.31.1718099392300; Tue, 11 Jun 2024
 02:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-18-sughosh.ganu@linaro.org>
 <11990152-63d9-4625-be0b-2fc278a8d27c@gmx.de>
In-Reply-To: <11990152-63d9-4625-be0b-2fc278a8d27c@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 15:19:41 +0530
Message-ID: <CADg8p970=RpO-dmyY0vNBz1KT=A0SPVTYJOTPyRhdYZN0+pvtA@mail.gmail.com>
Subject: Re: [RFC PATCH 17/31] lmb: remove call to efi_lmb_reserve()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 11 Jun 2024 at 14:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.06.24 20:52, Sughosh Ganu wrote:
> > The changes in the EFI memory map are now notified to the LMB
> > module. There is therefore no need to explicitly get the efi memory
> > map and set aside the EFI allocated memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/lmb.c | 35 -----------------------------------
> >   1 file changed, 35 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 3059609aea..c9f6ca692e 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -204,38 +204,6 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
> >       }
> >   }
> >
> > -/**
> > - * efi_lmb_reserve() - add reservations for EFI memory
> > - *
> > - * Add reservations for all EFI memory areas that are not
> > - * EFI_CONVENTIONAL_MEMORY.
> > - *
> > - * Return:   0 on success, 1 on failure
> > - */
> > -static __maybe_unused int efi_lmb_reserve(void)
> > -{
> > -     struct efi_mem_desc *memmap = NULL, *map;
> > -     efi_uintn_t i, map_size = 0;
> > -     efi_status_t ret;
> > -
> > -     ret = efi_get_memory_map_alloc(&map_size, &memmap);
> > -     if (ret != EFI_SUCCESS)
> > -             return 1;
> > -
> > -     for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
> > -             if (map->type != EFI_CONVENTIONAL_MEMORY) {
> > -                     lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> > -                                                     map->physical_start),
> > -                                       map->num_pages * EFI_PAGE_SIZE,
> > -                                       map->type == EFI_RESERVED_MEMORY_TYPE
> > -                                           ? LMB_NOMAP : LMB_NONE);
>
>
> Now that you have removed the last usage of LMB_NOMAP, please, remove it
> from enum lmb_flags.

Not all instances are removed. This flag gets used for reserving FDT
memory areas as well. Used in
boot/image-fdt.c:boot_fdt_add_mem_rsv_regions().

-sughosh

> > -     }
> > -     efi_free_pool(memmap);
> > -
> > -     return 0;
> > -}
> > -
> >   /**
> >    * lmb_reserve_common() - Reserve memory region occupied by U-Boot image
> >    * @fdt_blob: pointer to the FDT blob
> > @@ -255,9 +223,6 @@ void lmb_reserve_common(void *fdt_blob)
> >
> >       if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> >               boot_fdt_add_mem_rsv_regions(fdt_blob);
> > -
> > -     if (CONFIG_IS_ENABLED(EFI_LOADER))
> > -             efi_lmb_reserve();
> >   }
> >
> >   /**
>
