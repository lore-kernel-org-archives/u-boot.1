Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415CBD1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A338903B;
	Mon, 14 Oct 2024 17:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O9ObuAwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A9E88FBD; Mon, 14 Oct 2024 17:50:49 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6548388936
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460634ac984so14413191cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921045; x=1729525845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iIbBUjIho6RYhiPGZqOkTpa2OoK9DNg4dEDTfc5A1mw=;
 b=O9ObuAwVTiiv7RLJdHt81Gf9+ADXHQeKjPAQKOOGu6xxLg5D8+Rk3NTaF42QIpvqut
 4LPey5zJjX5UXGbyqgvzIMdQwqwMEeAWVd406PkS8gC0k8ueaADJPYeD1tRnYLud5kVX
 9xodSKgCr531WBc11PMAMsRfGOM4Y4EVvoBDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921045; x=1729525845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIbBUjIho6RYhiPGZqOkTpa2OoK9DNg4dEDTfc5A1mw=;
 b=S6fXcpMp5Yi1T8Sa0mNQdCteFGlNQrKg47n+W2OsDV5yEHs1UKkutSRwHraUj0wyz2
 vB80AJrAuGaPBr4dsZKkN+qpHfPg2oyNAzIG+ZOSaOXUS54nh6q3aEI8Ssx3z/N/YuBv
 aMQ1z2CVl3y11OwExOh/APZxJoKuU0oY1US7eD7AX7Xc1grYbbUCOQa1IrRPbyA37TQZ
 QT+QGC/5KrzfxH4FSEV12y9rlpvPeu3sCYJO/iSVuXYaxX4FPXoNQiIWIucKbrHljw3G
 /tikunM0AgiYJuFf0Nb6bLzDjPqUutMI42WfIZ0dqFehk4VBM3Gb1IF7lzU3b47RJ7C8
 91GQ==
X-Gm-Message-State: AOJu0YzgA+YHV5+K047LyrONIeIaFg/YrLaoZVdKB9pi/ZIcVpHcJ9cl
 3Gm4V27mcje2KvdqvoDK/0gz8GJ7vm/9kgUk10igsxM2KtuVmj8caE9BwD6wEC/wxq8FJfF/opN
 Drv043ZcFJdTxMTuG9FnReAgD1aDpodjPb7+l
X-Google-Smtp-Source: AGHT+IEriYbPf60m4+V4JnizZWA9+82SK+/cuhkEo2RMLWWbsT0aYDOcHm3qSzmFL3boltc3lQjzFodJS5cNqta/Zcc=
X-Received: by 2002:a05:6214:2b97:b0:6cb:dd09:7b4c with SMTP id
 6a1803df08f44-6cbeff384dcmr164387346d6.4.1728921045178; Mon, 14 Oct 2024
 08:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-4-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:34 -0600
Message-ID: <CAFLszTj1zD=8MG-qHSsh3Mbjg5UTX+f4kWELJBQ2TJcKFGMBiQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
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

Hi Sughosh,

On Tue, 8 Oct 2024 at 12:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the LMB API's for allocating and freeing up memory. With this, the
> LMB module becomes the common backend for managing non U-Boot image
> memory that might be requested by other modules.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  lib/efi_loader/Kconfig      |  1 +
>  lib/efi_loader/efi_memory.c | 74 ++++++++++---------------------------
>  2 files changed, 21 insertions(+), 54 deletions(-)
>

Please check my recent series [1] which shows how to avoid needing to
worry about lmb until the app starts, at which point I believe we can
just add the lmb map to the EFI map so we know where the images are?

But without my series, this patch is needed. I do wonder what
addresses lmb happens to allocate with this? From the top? From the
bottom?

> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index e58b8825605..5a576720606 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -20,6 +20,7 @@ config EFI_LOADER
>         select DM_EVENT
>         select EVENT_DYNAMIC
>         select LIB_UUID
> +       select LMB
>         imply PARTITION_UUIDS
>         select REGEX
>         imply FAT
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd09456..90e07ed6a2d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -9,6 +9,7 @@
>
>  #include <efi_loader.h>
>  #include <init.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> @@ -432,53 +433,6 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
>         return EFI_NOT_FOUND;
>  }
>
> -/**
> - * efi_find_free_memory() - find free memory pages
> - *
> - * @len:       size of memory area needed
> - * @max_addr:  highest address to allocate
> - * Return:     pointer to free memory area or 0
> - */
> -static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
> -{
> -       struct efi_mem_list *lmem;
> -
> -       /*
> -        * Prealign input max address, so we simplify our matching
> -        * logic below and can just reuse it as return pointer.
> -        */
> -       max_addr &= ~EFI_PAGE_MASK;
> -
> -       list_for_each_entry(lmem, &efi_mem, link) {
> -               struct efi_mem_desc *desc = &lmem->desc;
> -               uint64_t desc_len = desc->num_pages << EFI_PAGE_SHIFT;
> -               uint64_t desc_end = desc->physical_start + desc_len;
> -               uint64_t curmax = min(max_addr, desc_end);
> -               uint64_t ret = curmax - len;
> -
> -               /* We only take memory from free RAM */
> -               if (desc->type != EFI_CONVENTIONAL_MEMORY)
> -                       continue;
> -
> -               /* Out of bounds for max_addr */
> -               if ((ret + len) > max_addr)
> -                       continue;
> -
> -               /* Out of bounds for upper map limit */
> -               if ((ret + len) > desc_end)
> -                       continue;
> -
> -               /* Out of bounds for lower map limit */
> -               if (ret < desc->physical_start)
> -                       continue;
> -
> -               /* Return the highest address in this map within bounds */
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  /**
>   * efi_allocate_pages - allocate memory pages
>   *
> @@ -493,6 +447,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>                                 efi_uintn_t pages, uint64_t *memory)
>  {
>         u64 len;
> +       uint flags;
>         efi_status_t ret;
>         uint64_t addr;
>
> @@ -508,33 +463,35 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>             (len >> EFI_PAGE_SHIFT) != (u64)pages)
>                 return EFI_OUT_OF_RESOURCES;
>
> +       flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>         switch (type) {
>         case EFI_ALLOCATE_ANY_PAGES:
>                 /* Any page */
> -               addr = efi_find_free_memory(len, -1ULL);
> +               addr = (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);
>                 if (!addr)
>                         return EFI_OUT_OF_RESOURCES;
>                 break;
>         case EFI_ALLOCATE_MAX_ADDRESS:
>                 /* Max address */
> -               addr = efi_find_free_memory(len, *memory);
> +               addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memory,
> +                                                flags);
>                 if (!addr)
>                         return EFI_OUT_OF_RESOURCES;
>                 break;
>         case EFI_ALLOCATE_ADDRESS:
>                 if (*memory & EFI_PAGE_MASK)
>                         return EFI_NOT_FOUND;
> -               /* Exact address, reserve it. The addr is already in *memory. */
> -               ret = efi_check_allocated(*memory, false);
> -               if (ret != EFI_SUCCESS)
> -                       return EFI_NOT_FOUND;
> -               addr = *memory;
> +
> +               addr = (u64)lmb_alloc_addr_flags(*memory, len, flags);
> +               if (!addr)
> +                       return EFI_OUT_OF_RESOURCES;
>                 break;
>         default:
>                 /* UEFI doesn't specify other allocation types */
>                 return EFI_INVALID_PARAMETER;
>         }
>
> +       addr = (u64)(uintptr_t)map_sysmem(addr, 0);
>         /* Reserve that map in our memory maps */
>         ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
>         if (ret != EFI_SUCCESS)
> @@ -555,6 +512,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   */
>  efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>  {
> +       u64 len;
> +       uint flags;
> +       long status;
>         efi_status_t ret;
>
>         ret = efi_check_allocated(memory, true);
> @@ -568,6 +528,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>                 return EFI_INVALID_PARAMETER;
>         }
>
> +       flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
> +       len = (u64)pages << EFI_PAGE_SHIFT;
> +       status = lmb_free_flags(memory, len, flags);
> +       if (status)
> +               return EFI_NOT_FOUND;
> +
>         ret = efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
>                                     false);
>         if (ret != EFI_SUCCESS)
> --
> 2.34.1
>

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=427729
