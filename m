Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E9AC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B15C88914;
	Sat, 13 Jul 2024 17:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Db3Poslq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3475B8894E; Sat, 13 Jul 2024 17:16:23 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED14D8885D
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-77d3f00778cso2205068a12.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883779; x=1721488579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BrwK5t4yi8ztig8sihagHWO67S8ab23oQgesE1V0qkQ=;
 b=Db3Poslq+q2aE99KF6Qt9VeSmaaCc13+5ZKTkVenAiie+7X76rFlAYyiOercFNwMyG
 CbYfjMCQsqd6rzMMZOHYqXLP6pO2IGw0V8sKO+fE/gyDtmej1XI0AHBckvte9h5yamcG
 uPoPS7VeMMtlJWn3vrpU/LA5WOBN8rJ2S13WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883779; x=1721488579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BrwK5t4yi8ztig8sihagHWO67S8ab23oQgesE1V0qkQ=;
 b=FigEMYUM7gts46tl0vtRxwefbQt9yL+t4rxFMMyYeUmqUIhnq7CsS3MuaTHDgxeHR+
 1YnEBIDvmy7ZuZzMyCEfVfZ5el8OqHAGKxXWD4oGnvHdSlKxo0g/pT5tOHiorksYiKlH
 Bei8Tsh0hgqAxH1BILNFG1poogFs0oiVGADtd9Rm8Opi94XXSn1gvK7xGK3L87XTxBPy
 pGs/0nPCyKTyCSmNguxu06h4IkUjRngWzmtQ328RNqu18T6zzBprm5a3rd4j3NIH9Qhf
 3YY8h3ipzJVgFDP8HnOIh6hy12u2N0EzXfrw482v3EebP72PyVQ1QF7k8fyrnF0tUKvR
 R+6Q==
X-Gm-Message-State: AOJu0YyWSFLl9maL70aMUslvRKh5S34mTTFt7q1RxxXrKOzNyuYReUzH
 +LayLQZsOE0HrXxiah1QjqzYrirH9VRI7vYDOfOIF04lghSdf46xUqfWmvbAdXmM1yy905v3DTp
 iFF/W44ONe8Xbu26slnvCRpEikz2kgAHF1J5u
X-Google-Smtp-Source: AGHT+IEsdQc6fab1uys0QEevjHxsx2rGLJ0sjHwIBHGZTDgjPxrL7K/oNld58vOTTLKvJcOpOCnnnNnNloOMK/5ykHI=
X-Received: by 2002:a05:6a20:728d:b0:1bd:18ee:f145 with SMTP id
 adf61e73a8af0-1c29820c04emr18868504637.1.1720883779425; Sat, 13 Jul 2024
 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-42-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:16:00 +0100
Message-ID: <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Handle the addition of memory to the LMB memory map.
> * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
>   based on the type of operation.
>
>  lib/efi_loader/Kconfig      |  1 +
>  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>

This is getting complicated and I don't believe it is needed.

EFI should not be allocating memory 'in free space' until it starts
up. For the very few (if any) cases where it does, it can do an lmb
allocation.

As to the lmb allocations themselves, EFI can simply call look through
the lmb list and call efi_add_memory_map_pg() for each entry, when it
is ready to boot. There is no need to do it earlier.

> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index bdf5732974..2d90bcef2f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -16,6 +16,7 @@ config EFI_LOADER
>         select CHARSET
>         # We need to send DM events, dynamically, in the EFI block driver
>         select DM_EVENT
> +       select EVENT
>         select EVENT_DYNAMIC
>         select LIB_UUID
>         select LMB
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 5691b5da03..bd12504f72 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -45,6 +45,10 @@ static LIST_HEAD(efi_mem);
>  void *efi_bounce_buffer;
>  #endif
>
> +#define MAP_OP_RESERVE         (u8)0x1
> +#define MAP_OP_FREE            (u8)0x2
> +#define MAP_OP_ADD             (u8)0x3
> +
>  /**
>   * struct efi_pool_allocation - memory block allocated from pool
>   *
> @@ -928,3 +932,33 @@ int efi_memory_init(void)
>
>         return 0;
>  }
> +
> +#if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
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
> +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
> +               log_debug("Invalid map update op received (%d)\n", op);
> +               return -1;
> +       }
> +
> +       status = efi_add_memory_map_pg(addr, pages,
> +                                      op == MAP_OP_RESERVE ?
> +                                      EFI_BOOT_SERVICES_DATA :
> +                                      EFI_CONVENTIONAL_MEMORY,
> +                                      op == MAP_OP_RESERVE ? true : false);
> +
> +       return status == EFI_SUCCESS ? 0 : -1;
> +}
> +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> +#endif /* MEM_MAP_UPDATE_NOTIFY */
> --
> 2.34.1
>

Regards,
Simon
