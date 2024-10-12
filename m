Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC73D1A443
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 07:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5F088D9F;
	Sat, 12 Oct 2024 09:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zMJsldxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D243588E21; Sat, 12 Oct 2024 09:44:34 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C693588970
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 09:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a991fedbd04so228897766b.3
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728719072; x=1729323872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ON65uTY4tpkfdRvOpftBmEebt9rZCBO6dVSrZOZV1bY=;
 b=zMJsldxUgmOVOMDjSRJMWVMivJu/Rc99NiUhPhja2E0k/PCKUcvR/gsLAEbMNV1iku
 dhGBO/izWh6dEFPu4hXhznSHdyDIWZmddCQ/cMQkx37yPBXCTCHHDRsUubXTWyqyAUQN
 yabEjZ8yNnnCLPFjy4cGYRtmrTq6skKCfbD6K4I7AegI335m2a0V3xeYCf6Y0CLbihpY
 Kr7OxNKEXiaV+etmvh++cyRnaxNzhh+9okN7LqN8UZVcFtmTnU7Z8BmoNeJHq3t8WMoi
 jHO/jInPZQPc83ZN4NYrqWbuYXTpE3e6u/81xDQuTatohq+dluymUF3jMfPXsXPR042J
 ak5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728719072; x=1729323872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ON65uTY4tpkfdRvOpftBmEebt9rZCBO6dVSrZOZV1bY=;
 b=KYpGCzENodaJ6vKtb8bEirEt1Q3Jw0SeogA899hKxyjBy8CsdKFtj4RQv+aG37ru5Z
 5dm6nJwgltG752kS1bGXRxL7HHWdJpuKz1EsA+7WE4MkZOTEP8rFhMfXuF2owKTTBf++
 9u7Bg744mnFQp/u6AF2f0Nn5oDuPRRduUgxpLQFEEe6GYmRz7CMFok3cZqNrrJLXQW34
 WKFMd9gOvgAuCTQTvWoiBrE82kyty368GcyT5doIgiG3sP4NSpewdkc1gmHRDjy7cOGV
 VQxwomaDW4OhhWP5Lclinh7YpMq/D7bXqR6ZqO0RFmHl2S4/Fhy15ZPoCe8H71w8bTLQ
 52XQ==
X-Gm-Message-State: AOJu0YxXIt7+RAulez1E/mk3FEk+OgpQDCOx0NhojDER0lII2K5RCaRT
 zckAvqzmdlwRFcIG7DjPzkeeRb2IUUFcHCZVaGzfstzEXHplESxrYuy12lmvr9Pdi686B+jBaUj
 0J+rTV4NJSFKVyE03NeIWfNrAXasDxcnU64ln9g==
X-Google-Smtp-Source: AGHT+IG3kKRGCKLXja9oihWH5UzH3r+yRgavJjb5e6J0bEdrKnpl/A6OYYlbIO+aUATzMICbS7OfPKxxdGg2CVombNU=
X-Received: by 2002:aa7:d3cd:0:b0:5c9:2b2f:fee0 with SMTP id
 4fb4d7f45d1cf-5c95ac64190mr1762930a12.30.1728719072055; Sat, 12 Oct 2024
 00:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-13-sughosh.ganu@linaro.org>
 <CAC_iWjJF5SBE07SPEik8abFGq3fyZvAo=gpM73=Ds=K2aiBaJQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJF5SBE07SPEik8abFGq3fyZvAo=gpM73=Ds=K2aiBaJQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 12 Oct 2024 13:14:20 +0530
Message-ID: <CADg8p94Z80m0qu0vXC6sEx0BdcfsPSjk7gh5yXeDsOCKTz49ww@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] efi_memory: do not add RAM memory to the memory
 map
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

On Fri, 11 Oct 2024 at 16:33, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The EFI_CONVENTIONAL_MEMORY type, which is the usable RAM memory is
> > now being managed by the LMB module. Remove the addition of this
> > memory type to the EFI memory map. This memory now gets added to the
> > EFI memory map as part of the LMB memory map update event handler.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changes since V1: None
> >
> >  include/efi_loader.h        | 13 ++++---
> >  lib/efi_loader/efi_memory.c | 75 +++----------------------------------
> >  2 files changed, 12 insertions(+), 76 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 081cb65d3f7..0d5555c7597 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -798,10 +798,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >                                           int memory_type,
> >                                           bool overlap_only_ram);
> >
> > -/* Adds a conventional range into the EFI memory map */
> > -efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> > -                                            u64 ram_top);
> > -
> >  /* Called by board init to initialize the EFI drivers */
> >  efi_status_t efi_driver_init(void);
> >  /* Called when a block device is added */
> > @@ -1186,9 +1182,14 @@ efi_status_t efi_console_get_u16_string
> >  efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int size);
> >
> >  /**
> > - * efi_add_known_memory() - add memory banks to EFI memory map
> > + * efi_add_known_memory() - add memory types to the EFI memory map
> > + *
> > + * This function is to be used to adding different memory types other
>
> /adding/add

Okay

>
> > + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> > + * memory is handled by the LMB module, and gets added to the memory
>
> no comma after module

Okay

>
> > + * map through the LMB module.
> >   *
> > - * This weak function may be overridden for specific architectures.
> > + * This function may be overridden for specific architectures.
>
> Since you are rewriting this I think for "architecture specific
> purposes" is better

Okay

>
> >   */
> >  void efi_add_known_memory(void);
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 974ecc51113..0f25094dbf8 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -780,82 +780,17 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
> >  }
> >
> >  /**
> > - * efi_add_conventional_memory_map() - add a RAM memory area to the map
> > + * efi_add_known_memory() - add memory types to the EFI memory map
> >   *
> > - * @ram_start:         start address of a RAM memory area
> > - * @ram_end:           end address of a RAM memory area
> > - * @ram_top:           max address to be used as conventional memory
> > - * Return:             status code
> > - */
> > -efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> > -                                            u64 ram_top)
> > -{
> > -       u64 pages;
> > -
> > -       /* Remove partial pages */
> > -       ram_end &= ~EFI_PAGE_MASK;
> > -       ram_start = (ram_start + EFI_PAGE_MASK) & ~EFI_PAGE_MASK;
> > -
> > -       if (ram_end <= ram_start) {
> > -               /* Invalid mapping */
> > -               return EFI_INVALID_PARAMETER;
> > -       }
> > -
> > -       pages = (ram_end - ram_start) >> EFI_PAGE_SHIFT;
> > -
> > -       efi_add_memory_map_pg(ram_start, pages,
> > -                             EFI_CONVENTIONAL_MEMORY, false);
> > -
> > -       /*
> > -        * Boards may indicate to the U-Boot memory core that they
> > -        * can not support memory above ram_top. Let's honor this
> > -        * in the efi_loader subsystem too by declaring any memory
> > -        * above ram_top as "already occupied by firmware".
> > -        */
> > -       if (ram_top < ram_start) {
> > -               /* ram_top is before this region, reserve all */
> > -               efi_add_memory_map_pg(ram_start, pages,
> > -                                     EFI_BOOT_SERVICES_DATA, true);
> > -       } else if (ram_top < ram_end) {
> > -               /* ram_top is inside this region, reserve parts */
> > -               pages = (ram_end - ram_top) >> EFI_PAGE_SHIFT;
> > -
> > -               efi_add_memory_map_pg(ram_top, pages,
> > -                                     EFI_BOOT_SERVICES_DATA, true);
> > -       }
> > -
> > -       return EFI_SUCCESS;
> > -}
> > -
> > -/**
> > - * efi_add_known_memory() - add memory banks to map
> > + * This function is to be used to adding different memory types other
> > + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> > + * memory is handled by the LMB module, and gets added to the memory
> > + * map through the LMB module.
> >   *
> >   * This function may be overridden for specific architectures.
> >   */
> >  __weak void efi_add_known_memory(void)
>
>  We can also get rid of this in the future. Any idea if we have
> platforms using it after the last 2 you removed?

Yes, this is being used by some x86 platform, which is adding other
memory types to the EFI memory map.

-sughosh

>
>
> >  {
> > -       u64 ram_top = gd->ram_top & ~EFI_PAGE_MASK;
> > -       int i;
> > -
> > -       /*
> > -        * ram_top is just outside mapped memory. So use an offset of one for
> > -        * mapping the sandbox address.
> > -        */
> > -       ram_top = (uintptr_t)map_sysmem(ram_top - 1, 0) + 1;
> > -
> > -       /* Fix for 32bit targets with ram_top at 4G */
> > -       if (!ram_top)
> > -               ram_top = 0x100000000ULL;
> > -
> > -       /* Add RAM */
> > -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > -               u64 ram_end, ram_start;
> > -
> > -               ram_start = (uintptr_t)map_sysmem(gd->bd->bi_dram[i].start, 0);
> > -               ram_end = ram_start + gd->bd->bi_dram[i].size;
> > -
> > -               efi_add_conventional_memory_map(ram_start, ram_end, ram_top);
> > -       }
> >  }
> >
> >  /**
> > --
> > 2.34.1
> >
>
> With the spelling nits fixed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
