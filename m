Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5B2CFD344
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 11:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23C9892E6;
	Fri, 11 Oct 2024 12:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qpvx/MnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513EC892FB; Fri, 11 Oct 2024 12:59:59 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB2F892A2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so252851a91.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728644395; x=1729249195; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KIr0mZvQ0QQxgd4J0zuaMywhg4QnACYTh7WBjgt9Nr8=;
 b=Qpvx/MnTito2LCMSjL3WF8Tb66b3W+fuQo9cD8fTiKwxalyRzlonixGCv1qireylrS
 Z0Zb32GJDcxnkp7SSFXOMq3/+Tt+KYpEmZV7j/XEJsr61kT1tk4+QfzwNxX+ORaxtRpD
 UKTNq+cAc6qyGorJfyK8q1WY8Vc8ktwQyEIPFLROLNcHO/cWIJbA7RSQwHalsW6WtkRu
 9PR6+wbt7wV4L7l6JCuYpuR0V1Me2Tjj46k+I/Gy0cF3ztSzSAXJISM5n3Vlmb8AgEZL
 HXAPMOyN2V2X7O5dC8OzrOTubm0Hyw/wz4v+RDPHEim0T2QNfujRFmBu/CuVx4M6NkeW
 EEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728644395; x=1729249195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KIr0mZvQ0QQxgd4J0zuaMywhg4QnACYTh7WBjgt9Nr8=;
 b=nOw3Ak1G4Co2FoqEHf4o0yasNev8Ls2hrn6EjuWKhJytiQKy40qrKplnYEygsVi089
 q1ee5+/0k/LLplldY8iRL8X175er2BY0ahliWZN1OA5VlvO0LHt6YUPe6BiEL0g+oM8q
 uNKAbbz8Ul2P1BRh8VXk3CcC+NJxBAI8Q4gdVLhKqZwr/tmpv8ZfoISi0M4+dtZFjTjU
 RQqJG7Lq3/wtyeof5GwxT4geJviDlOrBjNwT9EQiedbiE/g3CbFso6n2YYXv2gwo3EY6
 Lp+pd/5Q5VAgk7oztXpkifn4xFHz449FWuKFIaefO5zW+8N355PN7u8NNmrJP6UUIecO
 cidg==
X-Gm-Message-State: AOJu0Yw38qVaswpWRKfhbzviulupwDUrKz/r3T6oeFIWx2yt2t+QYHLy
 OrVqJv2jZTEFKQYxObWvnwyE3Tg7BRvDxZcKvWCX7f44FYFCsoK3JYdGMH9COvgUIyN+xUro3c6
 qDhAbLtvQPQ9t/IquwEaL58/fF6iQpk+0JV7EKg==
X-Google-Smtp-Source: AGHT+IH4eJyuw7Ktkjgl0zyB574p4Xhzjr0MfnoCaSNBrFqP0FGHjv1JYZNa81WEOPna+rfTZ0HD9nwyP9WjKeDUBtM=
X-Received: by 2002:a17:90a:fe01:b0:2e2:9522:279e with SMTP id
 98e67ed59e1d1-2e2f0dfdcf2mr3129477a91.31.1728644395337; Fri, 11 Oct 2024
 03:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-15-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-15-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 13:59:18 +0300
Message-ID: <CAC_iWj+YXbNakXZijoV8SFMRO0p17skLM5c5+VuO6ZDYXsoCYg@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] efi_memory: rename variable to highlight overlap
 with free memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The functions to add a memory region to the EFI memory map have a
> variable, overlap_only_ram, which is used to indicate if a new memory
> region needs to be carved out from the free, or conventional
> memory.

This is a bit confusing. Conventional memory is free memory.
Isn't it this from conventional or non-conventional memory?

> The name overlap_only_ram is a bit confusing, as other
> allocated memory regions, like boot-services code and data are also
> part of the RAM memory. Rename the variable to highlight the fact that
> it is the free/conventional memory that is being referred to in this
> context.

overlap_conventional should be even better?

Thanks
/Ilias
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  include/efi_loader.h        | 16 +++++++-----
>  lib/efi_loader/efi_memory.c | 51 ++++++++++++++++++++-----------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 0d5555c7597..c3512c63a50 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -788,15 +788,17 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>  /**
>   * efi_add_memory_map_pg() - add pages to the memory map
>   *
> - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:             number of pages to add
> - * @memory_type:       type of memory added
> - * @overlap_only_ram:  region may only overlap RAM
> - * Return:             status code
> + * @start:                     start address, must be a multiple of
> + *                             EFI_PAGE_SIZE
> + * @pages:                     number of pages to add
> + * @memory_type:               type of memory added
> + * @overlap_only_freemem:      region may only overlap free(conventional)
> + *                             memory
> + * Return:                     status code
>   */
>  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                         int memory_type,
> -                                         bool overlap_only_ram);
> +                                  int memory_type,
> +                                  bool overlap_only_freemem);
>
>  /* Called by board init to initialize the EFI drivers */
>  efi_status_t efi_driver_init(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 0f25094dbf8..97b89a97a2e 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -173,17 +173,19 @@ static void efi_mem_sort(void)
>  /**
>   * efi_mem_carve_out() - unmap memory region
>   *
> - * @map:               memory map
> - * @carve_desc:                memory region to unmap
> - * @overlap_only_ram:  the carved out region may only overlap RAM
> - * Return:             the number of overlapping pages which have been
> - *                     removed from the map,
> - *                     EFI_CARVE_NO_OVERLAP, if the regions don't overlap,
> - *                     EFI_CARVE_OVERLAPS_NONRAM, if the carve and map overlap,
> - *                     and the map contains anything but free ram
> - *                     (only when overlap_only_ram is true),
> - *                     EFI_CARVE_LOOP_AGAIN, if the mapping list should be
> - *                     traversed again, as it has been altered.
> + * @map:                       memory map
> + * @carve_desc:                        memory region to unmap
> + * @overlap_only_freemem:      the carved out region may only overlap free,
> + *                             or conventional memory
> + * Return:                     the number of overlapping pages which have been
> + *                             removed from the map,
> + *                             EFI_CARVE_NO_OVERLAP, if the regions don't
> + *                             overlap, EFI_CARVE_OVERLAPS_NONRAM, if the carve
> + *                             and map overlap, and the map contains anything
> + *                             but free ram(only when overlap_only_freemem is
> + *                             true),
> + *                             EFI_CARVE_LOOP_AGAIN, if the mapping list should
> + *                             be traversed again, as it has been altered.
>   *
>   * Unmaps all memory occupied by the carve_desc region from the list entry
>   * pointed to by map.
> @@ -193,7 +195,7 @@ static void efi_mem_sort(void)
>   */
>  static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                              struct efi_mem_desc *carve_desc,
> -                            bool overlap_only_ram)
> +                            bool overlap_only_freemem)
>  {
>         struct efi_mem_list *newmap;
>         struct efi_mem_desc *map_desc = &map->desc;
> @@ -208,7 +210,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                 return EFI_CARVE_NO_OVERLAP;
>
>         /* We're overlapping with non-RAM, warn the caller if desired */
> -       if (overlap_only_ram && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> +       if (overlap_only_freemem && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
>                 return EFI_CARVE_OVERLAPS_NONRAM;
>
>         /* Sanitize carve_start and carve_end to lie within our bounds */
> @@ -258,15 +260,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>  /**
>   * efi_add_memory_map_pg() - add pages to the memory map
>   *
> - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:             number of pages to add
> - * @memory_type:       type of memory added
> - * @overlap_only_ram:  region may only overlap RAM
> - * Return:             status code
> + * @start:                     start address, must be a multiple of
> + *                             EFI_PAGE_SIZE
> + * @pages:                     number of pages to add
> + * @memory_type:               type of memory added
> + * @overlap_only_freemem:      region may only overlap free(conventional)
> + *                             memory
> + * Return:                     status code
>   */
>  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                         int memory_type,
> -                                         bool overlap_only_ram)
> +                                  int memory_type,
> +                                  bool overlap_only_freemem)
>  {
>         struct efi_mem_list *lmem;
>         struct efi_mem_list *newlist;
> @@ -275,7 +279,8 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         struct efi_event *evt;
>
>         EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> -                 start, pages, memory_type, overlap_only_ram ? "yes" : "no");
> +                 start, pages, memory_type, overlap_only_freemem ?
> +                 "yes" : "no");
>
>         if (memory_type >= EFI_MAX_MEMORY_TYPE)
>                 return EFI_INVALID_PARAMETER;
> @@ -312,7 +317,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                         s64 r;
>
>                         r = efi_mem_carve_out(lmem, &newlist->desc,
> -                                             overlap_only_ram);
> +                                             overlap_only_freemem);
>                         switch (r) {
>                         case EFI_CARVE_OUT_OF_RESOURCES:
>                                 free(newlist);
> @@ -348,7 +353,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                 }
>         } while (carve_again);
>
> -       if (overlap_only_ram && (carved_pages != pages)) {
> +       if (overlap_only_freemem && (carved_pages != pages)) {
>                 /*
>                  * The payload wanted to have RAM overlaps, but we overlapped
>                  * with an unallocated region. Error out.
> --
> 2.34.1
>
