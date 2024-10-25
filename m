Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED6AD0C600
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF48388FE4;
	Fri, 25 Oct 2024 13:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQUP0f5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5745288FD5; Fri, 25 Oct 2024 13:17:25 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3A488FE4
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea8d7341e6so1280177a12.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729855038; x=1730459838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J78e3kcvuaU+AS6LIG7KrvGZOBDn7yL1/bidHvOwZKs=;
 b=fQUP0f5WlVqoCxUutEa842+LGjYGI3mJRbfJNVytwa1MaO7x1ARVbsNlqKGa5brZf/
 M6NMNZ5Qttwl8tKk9OTsDBoLbx9fZ8eyrHL5cgnRhbtEfd4iVcnyCEu5yonNwZkbjiGY
 3cnNd3/i52qZmxksrCu7xtWSJmE6y3CC1owp5VYPy+XhZWFu7nDTU4Cmmh5LcY34uuat
 lOJEjjj5r2PR1OzqiVEfeBrWZN47O7XTGsIkSaAPu5dwv+2wu/oD+FLo4+6Qwnt3drCS
 p9l7VZGsJVGmxTvEPNXY9Fp6jqJj5i2Bae4hX1j9OZjdo8Aw5vkqFH+8tzXShnx1grpN
 9yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855038; x=1730459838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J78e3kcvuaU+AS6LIG7KrvGZOBDn7yL1/bidHvOwZKs=;
 b=bPKRN1gGdgiaa2rLk8gEnFNRo6T2PPu7W5l8jMR23xOlLwYkzlqwvIIlsLKOl/OZA+
 Xd+F4ac7HprqbkT08GC/ZuVetgr0bgzScgCwLoc1gfcNjs90oGEWmkRBco2jfiTbJOgN
 EVXXOy0Gqo8H95AL5KCxqOqa/A+mrcSJgR2lGCUgwXlMLvNxo4CQ49Fexe1u03/78iK2
 8OiuG5zgPXEaVHtwgoYgfSVrpVcAWzqHcrxFU7OY3PgcTBpxVx9C/X5wv2w+poSsYUnR
 aSAEHyUAv7cpal1tm0MaZ2Ua4uyrOIo1zK02dW8EV4GobzlSUcnHVZ37GndJU+YqV388
 vWhw==
X-Gm-Message-State: AOJu0YzrnVL7JRNK7wdvFu4LOiWJvnnlX5OLyONB4AAF4TzOmskQFcy+
 atnU5Bc6quy78MR/7HzIqM/K3yRbP46a1Bzz6HhZ9joE2GdDFTvHgJGJ6pLtc9L3VVdPgNHYJIM
 QkevrwQLP6+fWxUGGxyzTC5J/hPH9jOONsR8SFA==
X-Google-Smtp-Source: AGHT+IFuXxoXl080H1l3SN5gIEWphOxws8i06cRM1twvrfqj2J3zO3KvOgIgYTOauLIFckbTlThlqAO5nGgeev93vY8=
X-Received: by 2002:a05:6a21:460c:b0:1d9:275b:4efd with SMTP id
 adf61e73a8af0-1d989cc9001mr6927852637.39.1729855037672; Fri, 25 Oct 2024
 04:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-3-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 14:16:41 +0300
Message-ID: <CAC_iWj+x4HErxWJnxA1p6RmqconQ3cGDnsSH5u8+XZ6eWuiVyg@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi_loader: add a function to remove memory from the
 EFI map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>
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

+CC Anton

On Fri, 25 Oct 2024 at 14:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> With upcoming changes supporting pmem nodes, we need to ommit the
> pmem area rfom the EFI memory map. Add a function to do that
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/efi_loader.h        | 11 +++++---
>  lib/efi_loader/efi_memory.c | 51 +++++++++++++++++++++++++++----------
>  lib/lmb.c                   |  4 +--
>  3 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 291eca5c07..d450e304c6 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -786,7 +786,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>  efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>
>  /**
> - * efi_add_memory_map_pg() - add pages to the memory map
> + * efi_update_memory_map() - update the memory map by adding/removing pages
>   *
>   * @start:                     start address, must be a multiple of
>   *                             EFI_PAGE_SIZE
> @@ -794,11 +794,14 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>   * @memory_type:               type of memory added
>   * @overlap_conventional:      region may only overlap free(conventional)
>   *                             memory
> + * @remove:                    remove memory map
>   * Return:                     status code
>   */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                  int memory_type,
> -                                  bool overlap_conventional);
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
> +                                  bool overlap_conventional, bool remove);
> +
> +/* Remove memory from the EFI memory map */
> +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type);
>
>  /* Called by board init to initialize the EFI drivers */
>  efi_status_t efi_driver_init(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 3d742fa191..cb93bfa55f 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>  }
>
>  /**
> - * efi_add_memory_map_pg() - add pages to the memory map
> + * efi_update_memory_map() - update the memory map by adding/removing pages
>   *
>   * @start:                     start address, must be a multiple of
>   *                             EFI_PAGE_SIZE
> @@ -266,11 +266,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>   * @memory_type:               type of memory added
>   * @overlap_conventional:      region may only overlap free(conventional)
>   *                             memory
> + * @remove:                    remove memory map
>   * Return:                     status code
>   */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                  int memory_type,
> -                                  bool overlap_conventional)
> +efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
> +                                  bool overlap_conventional, bool remove)
>  {
>         struct efi_mem_list *lmem;
>         struct efi_mem_list *newlist;
> @@ -278,9 +278,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         uint64_t carved_pages = 0;
>         struct efi_event *evt;
>
> -       EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> +       EFI_PRINT("%s: 0x%llx 0x%llx %d %s %s\n", __func__,
>                   start, pages, memory_type, overlap_conventional ?
> -                 "yes" : "no");
> +                 "yes" : "no", remove ? "remove" : "add");
>
>         if (memory_type >= EFI_MAX_MEMORY_TYPE)
>                 return EFI_INVALID_PARAMETER;
> @@ -363,7 +363,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         }
>
>         /* Add our new map */
> -        list_add_tail(&newlist->link, &efi_mem);
> +       if (!remove)
> +               list_add_tail(&newlist->link, &efi_mem);
> +       else
> +               free(newlist);
>
>         /* And make sure memory is listed in descending order */
>         efi_mem_sort();
> @@ -400,7 +403,29 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
>         pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
>         start &= ~EFI_PAGE_MASK;
>
> -       return efi_add_memory_map_pg(start, pages, memory_type, false);
> +       return efi_update_memory_map(start, pages, memory_type, false, false);
> +}
> +
> +/**
> + * efi_remove_memory_map() - remove memory area to the memory map
> + *
> + * @start:             start address of the memory area
> + * @size:              length in bytes of the memory area
> + * @memory_type:       type of memory removed
> + *
> + * Return:             status code
> + *
> + * This function automatically aligns the start and size of the memory area
> + * to EFI_PAGE_SIZE.
> + */
> +efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type)
> +{
> +       u64 pages;
> +
> +       pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
> +       start &= ~EFI_PAGE_MASK;
> +
> +       return efi_update_memory_map(start, pages, memory_type, false, true);
>  }
>
>  /**
> @@ -500,7 +525,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>
>         addr = (u64)(uintptr_t)map_sysmem(addr, 0);
>         /* Reserve that map in our memory maps */
> -       ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
> +       ret = efi_update_memory_map(addr, pages, memory_type, true, false);
>         if (ret != EFI_SUCCESS)
>                 /* Map would overlap, bail out */
>                 return  EFI_OUT_OF_RESOURCES;
> @@ -542,8 +567,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>         if (status)
>                 return EFI_NOT_FOUND;
>
> -       ret = efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
> -                                   false);
> +       ret = efi_update_memory_map(memory, pages, EFI_CONVENTIONAL_MEMORY,
> +                                   false, false);
>         if (ret != EFI_SUCCESS)
>                 return EFI_NOT_FOUND;
>
> @@ -828,8 +853,8 @@ static void add_u_boot_and_runtime(void)
>         runtime_end = (uintptr_t)__efi_runtime_stop;
>         runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
>         runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> -       efi_add_memory_map_pg(runtime_start, runtime_pages,
> -                             EFI_RUNTIME_SERVICES_CODE, false);
> +       efi_update_memory_map(runtime_start, runtime_pages,
> +                             EFI_RUNTIME_SERVICES_CODE, false, false);
>  }
>
>  int efi_memory_init(void)
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7e90f17876..05f3cd093d 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -55,11 +55,11 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
>         pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>         efi_addr &= ~EFI_PAGE_MASK;
>
> -       status = efi_add_memory_map_pg(efi_addr, pages,
> +       status = efi_update_memory_map(efi_addr, pages,
>                                        op == MAP_OP_RESERVE ?
>                                        EFI_BOOT_SERVICES_DATA :
>                                        EFI_CONVENTIONAL_MEMORY,
> -                                      false);
> +                                      false, false);
>         if (status != EFI_SUCCESS) {
>                 log_err("%s: LMB Map notify failure %lu\n", __func__,
>                         status & ~EFI_ERROR_MASK);
> --
> 2.34.1
>
