Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A99CC6B36
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 08:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C37839DF;
	Thu,  2 Apr 2026 10:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sKwbVZLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC1B83CF5; Thu,  2 Apr 2026 10:54:10 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB4280212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 10:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-650182d19e0so732501d50.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 01:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775120045; cv=none;
 d=google.com; s=arc-20240605;
 b=I5uNn3c7coftp/+HB7h8ucogkwiDg593ks/SCDSPj2cCdQkXvvDgkXgCrk0domHj6S
 L4cmHMMjFSyDLDAEt7zR0sPF8D9Oj6TRqZAHta/98wv8fWRaH3AxyOxHXWnDsjZ5IciT
 6RyHhfdboYk3+Mo+4Z1TMsffPXsomwFqmXPFMOm+j08jMhO0XC60izcfrBUJ8HQGlMD6
 iKrENadBG5bH9uSo9qkhlObYhLB1ZKehiDVm4vvNzGdFGWSN3Ad+4UXsZtUf/33SioSn
 Vv+YcXSj0dkhSPkKZYGAtGkci0fYLXMoX+Vo9dC2G2sG8ff6q3jeJYv+85YyalBHTHuz
 vcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CH/zdqpDm0wm+XK+T+ycCTaVLcwfcswyn65di7+LBhA=;
 fh=bF0/D4lI7iihEPBF+JxHOYqOKuhqjj3MWLIT9zEhIKc=;
 b=k2kQFu2G4LTH+EA6RkEcIlOmkIzwWCQjpbyim+6lItdBgr0R43C5iavr1m4HWUUXfM
 rLkPW7UWHMncY7YYB5p1jqVs4xgUb/srObgDk+oc0X8V/C4/H/ZoHF94/oWdvRsInirH
 3tjs7MJu2ouJdhgvPME1uqdYIC7R41DLecFUunLXeAjoGpsWUg/X2gYtRx66SRFyJ/9A
 OyefpMcTHhbIecsb8BqakV7nnR8LS1zSUUJGz3aCjVUjMOpx/b8/9zHB10LAu/rK9Bfm
 4XZYScERiKcCQASEQJ86YIhcMoI7GWahjuPebQb7BSB/FzjVdA11tZSiCcWJ4t3CjQnH
 IZeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775120045; x=1775724845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CH/zdqpDm0wm+XK+T+ycCTaVLcwfcswyn65di7+LBhA=;
 b=sKwbVZLo6QrS+PnmptWMzsGRxQJ25boZQ7aTlRvzqVDlhDtiMLStDtyCyu3UR8h/of
 8awJgSCqRaD/b85/V6q1ne5KGHT03CaAK+xaV8SkrpNjEIMUMzsareWYH4ju4FEHThH0
 vQDBaMX6Fgb8KeKmB3c+iQLg082d2LhwjhJpSJTLtrgCNZUZR+mdRuYdIdSIf5zXnmPj
 ayi4h45FmA+0xDIJCgd30DvtSzcj3BADZKFwbG6u3z1lWtkkahfqv+I+Cvxy0LRmmPLl
 Zww89Q70XNWh7LyNTbOd/RFeDDcXqwNYTqeE6iQHwMcThU+6C5EXS8sdpaQWR4hBdys+
 bL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775120045; x=1775724845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CH/zdqpDm0wm+XK+T+ycCTaVLcwfcswyn65di7+LBhA=;
 b=iF4ym98fC2v8ynJAlAIuvyxkoXHhM9VptNS7rWH5Nr8wI2AiAssU/R3QVUiokbbTdm
 oqU1vosmynB8caKP+yie6yEm9woZXQRwy+I7C5Po/DyBm8bPD2hRkh5HFZhoCg8K03XZ
 niULdwzKZdcNMeh2SS13lnkPXjmkH9Ih2/uHSC+pM/Qe87TMH6DFCnHJ1nhITDzhtOmc
 7n8HuNCWzIIDlzq19EgZeKmYI8Q06csBZBuCnfDJutBDk0ePCf6O0nVo5f7EMWk4laGa
 3RqcypmESKM/tt8FIjFlRT0elpVlOzuVN0t1Cb4DI1MX5IDXoISkyC2ZufQIvj0sHpTf
 N5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuQAaUh/GUaYgvHQ6lE1ibxFdcMcDfPXWx0s820weltSI5YsgqelozHAF2W1ZV/tB5PZO6ICs=@lists.denx.de
X-Gm-Message-State: AOJu0YwYlpJm3Y5TwahNwCwDDW1JzmqT3zfz0Bi5drcX3+k2t+6JZdv9
 gKyeDQ8vrynkUGQza+6kuvYD1ZviTt0Ca5WbLr+0lD+hsRAgdiUgwgW2dZvFgnwAwdz9Y4ebVjy
 MnaCUiL66hSVdkRUoe9mN7vDeaVsllwkbMVHrv4Vokg==
X-Gm-Gg: AeBDietaCmsosl1as9IHWOydf7tN4JmCzTmh1LCtRBHk7vIRAxoKK848igMb2zxNklE
 5rGc3XMPmnqXw3A6uCSpsNyti+0ctVq1ABKX4DSeCLrF4N7+Bj14aQdIMDTJMpRAaOZNFNzWQqW
 pbbUTiVZkyPgXgSro+w2nGcUXvK2f5x/2wtLnIH5NwBySCMZnPapM6WYHffWQryursdIaLQMBUP
 LuP9Zi+Xxh+xa4+5T2bnkP52PxlmSL6UfsNyytj+bHDU1ek0grzybpFMnsvYCUuGvNEey8tyj01
 EfvenyWEhbUXAVbBAbQY3Gofrjje9lJ6ZR3FmDJFMoj7FxYErALPPAKOVUZLAZnf8qPZaf5lJdt
 uo32JDNEUmwKmm6bHOVIFNb+JeoykOlC0JK7T2LKdtv5EEUYsiM4gocyqBshf7QOd5ycDZDCROc
 DrbXUhB+DwsrmUvA8ikzel6lonyIpeK6+Uvx3OHgTmtkMzxO+yADRenBQrpndRafMFwu5OJJXfy
 WEj0bXu0m/5+t62vm6zUuYhPBxJO2GR88M1DhMOT0+4XMe/zmACzMTd0p1Nh8KpKqw8JYa0hBe6
 3QPjZqUkblCLJ8P9lc+vGp1/fnPOmpeMcrDM+O+Pk5db
X-Received: by 2002:a05:690e:4192:b0:650:36e6:2ace with SMTP id
 956f58d0204a3-65036e62e0cmr5275716d50.31.1775120045394; Thu, 02 Apr 2026
 01:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-6-rs@ti.com>
In-Reply-To: <20260402001410.3736815-6-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 11:53:29 +0300
X-Gm-Features: AQROBzAGYw3W20kdxLrta_gtoSmUXXJIm988S1GGEW0lgoYCGQQIMJdBbRAlb20
Message-ID: <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi Randolph

On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Backfill any fragmented EFI_CONVENTIONAL_MEMORY when LMB allocations
> start to fail. This may be a low memory environment, or maybe LMB is
> running up against a tricky reserved region.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  lib/efi_loader/efi_memory.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 882366a9f8a..f07cc39b157 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -441,6 +441,27 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
>         return EFI_NOT_FOUND;
>  }
>
> +/**
> + * efi_get_conventional_start - find the highest conventional region start
> + *                              address with at least the specified number of
> + *                              pages
> + *
> + * @pages:                      number of pages required to be in that carveout
> + * Return:                      starting address of the give carveout
> + */
> +static u64 efi_get_conventional_start(u64 pages)
> +{
> +       struct efi_mem_list *item;
> +
> +       list_for_each_entry(item, &efi_mem, link) {
> +               if (item->desc.type != EFI_CONVENTIONAL_MEMORY)
> +                       continue;
> +               if (item->desc.num_pages >= pages)
> +                       return item->desc.physical_start;
> +       }
> +       return 0;

We've been bitten by this in the past and although unlikely 0 is a
valid address for some hardware. Can we return something different if
we don't find a match? UINT64_MAX perhaps?

> +}
> +
>  /**
>   * efi_allocate_pages - allocate memory pages
>   *
> @@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>         /* Reserve that map in our memory maps */
>         ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);

In theory the lmb and the EFI maps are in sync. I haven't checked
close enough yet, but do you have cases where lmb_alloc worked and
updating the efi memory map failed?

>         if (ret != EFI_SUCCESS) {
> -               /* Map would overlap, bail out */
> +               /* Map would overlap, try something else */
>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
> -               return  EFI_OUT_OF_RESOURCES;
> +
> +               /* See if there is any EFI_CONVENTIONAL_MEMORY allocations */
> +               if (type != EFI_ALLOCATE_ADDRESS) {

Can you please inverse this. It's going to reduce the identation.
if (type == EFI_ALLOCATE_ADDRESS)
> +                       *memory = efi_get_conventional_start(pages);
> +                       if (*memory != 0)

Same here

> +                               return efi_allocate_pages(EFI_ALLOCATE_ADDRESS,
> +                                                         memory_type, pages,
> +                                                         memory);
> +               }
> +
> +               return EFI_OUT_OF_RESOURCES;
>         }
>
>         *memory = efi_addr;
> --
> 2.53.0
>

Thanks
/Ilias
