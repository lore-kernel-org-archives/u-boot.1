Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5531BC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 12:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8B6884CC;
	Mon, 10 Jun 2024 14:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XjbgBguk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72C884EA; Mon, 10 Jun 2024 14:10:22 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEC088323
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so3770119a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718021419; x=1718626219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m6d4FFuuB9WH2kPvsSRGa0aoCyodB08OOrqxZ6gFVT8=;
 b=XjbgBgukCFX9PZTctRyBO7ZxuCts5b8ofRPMMj682yay44Sb+DBX1M3AvI7CXPJV6p
 OvYdDrLBZvLAO564msj7D7rjsz1Msj4+2hz47364yin3PSWUEFg73h/SR2uiLX3GcnFM
 /sYZ26pcis6Kdd3EPllYC5WgV9z56Gs3vizpwTtYbw3cYpLbXkeTOrzd7HDn3KRoZ/EU
 cuFdiQKzzIZqxPRyAlyWQf1B9x10ZJKZiiPJp6l3ajA97UWq4EaAC9VBt4Q1h5VFvuUX
 CE7Jxs+uAK27GUesaMP3WCWkbk3QAjzhPZXeS1/yCy0uFvATQ1TaOu1cuY0nxHbaH7+U
 KONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718021419; x=1718626219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6d4FFuuB9WH2kPvsSRGa0aoCyodB08OOrqxZ6gFVT8=;
 b=UqcEX9qBG/NLGurR9+KwI7QzgfRDsji5Unp/+QzCg0A/ao0i/nnOOZ3LEYohGMWXd+
 /9ivjf7nUAhyqA/6YiTWoy0l/YSubNoqR+aNSz0ENnqhySWgObQcoNigRjQZqXjYgl9d
 3K7IxsvAb+HnKfoKNmQ6oCgmcsY+0PL4fGRqY2f0Fjr4gQh8hh/g1UduWPkEbh2DcQHN
 U6q++eo8lLRUB442KIrSCacINP+hy9k+OkQJeHTSYCj2RkyvBehHZEFLMc6x6IPFRtyY
 Y47BKdbfb9ahJCeNysJUQ9psALefoF7rgN09cLxA707bruceCzqg4AkgY8zKCRKd/uTf
 isYw==
X-Gm-Message-State: AOJu0YzcvOz2+Bkb3wZRV7NrU3sE0+4YNF96SD0AnPUppSiv+yM+V14b
 N4KSN5QdoMXdTzgY83irZ3jhqgCZYBqJmKkgL+ggzO5Z8JSQ1a1AbjJ6XdndnmPUry4HcrMTyJW
 q6HC6gPEwBc2j6JnIieT0a+wAJhlFRj0TNLczZw==
X-Google-Smtp-Source: AGHT+IHZeeioFrfRZNrplUj8/4PMkjkx7us7W+BQnajCUhATCiHWv/5t6eFZfeoXnVA27jCnXfuUVpwenhB/BlbWpM0=
X-Received: by 2002:a05:6a20:9683:b0:1af:acf6:f790 with SMTP id
 adf61e73a8af0-1b2f9ca362cmr8035226637.48.1718021418607; Mon, 10 Jun 2024
 05:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-16-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 15:09:42 +0300
Message-ID: <CAC_iWjJB4t_SAuEoJwTdUR=d+N_PZhXEBx6jMW+n1OQzREVNvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> There are events that would be used to notify other interested modules
> of any changes in available and occupied memory. This would happen
> when a module allocates or reserves memory, or frees up memory. These
> changes in memory map should be notified to other interested modules
> so that the allocated memory does not get overwritten. Add an event
> handler in the EFI memory module to update the EFI memory map
> accordingly when such changes happen. As a consequence, any subsequent
> memory request would honour the updated memory map and only available
> memory would be allocated from.

So the question here, is why do we need a notifier chain overall?
Can't we change the EFI subsystem and allocate memory with lmb now?
And any special functions we have in EFI (e.g allocate aligned memory)
can migrate to lmb()

Cheers
/Ilias
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 435e580fb3..93244161b0 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -73,6 +73,10 @@ struct efi_pool_allocation {
>  #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
>  extern bool is_addr_in_ram(uintptr_t addr);
>
> +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> +                                           int memory_type,
> +                                           bool overlap_only_ram);
> +
>  static void efi_map_update_notify(u64 addr, u64 size, u8 op)
>  {
>         struct event_efi_mem_map_update efi_map = {0};
> @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
>         if (is_addr_in_ram((uintptr_t)addr))
>                 event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
>  }
> +
> +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> +{
> +       u8 op;
> +       u64 addr;
> +       u64 pages;
> +       efi_status_t status;
> +       struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> +
> +       addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> +       pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> +       op = lmb_map->op;
> +       addr &= ~EFI_PAGE_MASK;
> +
> +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> +               log_debug("Invalid map update op received (%d)\n", op);
> +               return -1;
> +       }
> +
> +       status = __efi_add_memory_map_pg(addr, pages,
> +                                        op == MAP_OP_FREE ?
> +                                        EFI_CONVENTIONAL_MEMORY :
> +                                        EFI_BOOT_SERVICES_DATA,
> +                                        true);
> +
> +       return status == EFI_SUCCESS ? 0 : -1;
> +}
> +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
>  #endif /* MEM_MAP_UPDATE_NOTIFY */
>
>  /**
> @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>         return EFI_CARVE_LOOP_AGAIN;
>  }
>
> -/**
> - * efi_add_memory_map_pg() - add pages to the memory map
> - *
> - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:             number of pages to add
> - * @memory_type:       type of memory added
> - * @overlap_only_ram:  region may only overlap RAM
> - * Return:             status code
> - */
> -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                         int memory_type,
> -                                         bool overlap_only_ram)
> +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> +                                           int memory_type,
> +                                           bool overlap_only_ram)
>  {
>         struct list_head *lhandle;
>         struct efi_mem_list *newlist;
> @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                 }
>         }
>
> +       return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_add_memory_map_pg() - add pages to the memory map
> + *
> + * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> + * @pages:             number of pages to add
> + * @memory_type:       type of memory added
> + * @overlap_only_ram:  region may only overlap RAM
> + * Return:             status code
> + */
> +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> +                                         int memory_type,
> +                                         bool overlap_only_ram)
> +{
> +       efi_status_t status;
> +
> +       status = __efi_add_memory_map_pg(start, pages, memory_type,
> +                                        overlap_only_ram);
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
>         if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
>                 efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
>                                       memory_type == EFI_CONVENTIONAL_MEMORY ?
> --
> 2.34.1
>
