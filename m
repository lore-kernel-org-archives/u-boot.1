Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC79BD2446F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 11:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C577892C6;
	Fri, 11 Oct 2024 13:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u7P6Sdap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE19892D9; Fri, 11 Oct 2024 13:03:33 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545BF892AB
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 13:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so232721b3a.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728644610; x=1729249410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6JEhg+mj9URbUBX2kPVhJvAwK8GfGQuv4Vr45PNOhaE=;
 b=u7P6SdapVz5EBzKXUUGUwufnubmtyphinn6OeYI5mKGTO3UzE/ySJIv82DQl/gMmpo
 pLR9o9Yh/VS0taIfk55nRx8gCOgk/fJNDPB2XWQ5SbEcpkZLWvsGdhFeP6DBIK91nA+D
 BsMjsXbMSB+D7BV8JlaMpmu+PdY5B9rZ9DgZoLylP8ZRFiIWNb5RVAwaft4NUEQ3NZzd
 CXtdSAU0JvgpXdFAeuhDTXlN8YFX+nsCQke9a7vQErcmhlgmGwpqIhu1ERSrsSnmB8OC
 klTRGUtwyCPuG9oRgTFswZ0Qp1WTpJZ065IYIUyfu0D7tJnpNXEK1OH1fHwuY8Oq8nZc
 LDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728644610; x=1729249410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6JEhg+mj9URbUBX2kPVhJvAwK8GfGQuv4Vr45PNOhaE=;
 b=H9nNkDfkhZ4kBMTq6WXL0hodctbE2DvYPS0p51qBnO8hCI7i5BALmk5tNNxWuxkkq/
 HrAoUxkR3aQormeHCnnM2xGvXZH7njMLjkJxIbFmYeyT+OkIV0SxF9epuOkkIPDN/SMj
 X8hc+45vOkOI510IvQdO3xhf2CVns8S/5n3LNA0/7iXEvquGIPY4sLYzlidadR4hIx3F
 EqP0DxZ5jj41t5O4f8Z5B7U5YtqFRp4OtXw7UexBWKt1PI8olo2Z0zw5Y7WH+wcIvxRL
 n5qZhc5Cy25JpmL9Lg4HQ/2rwBZUDszFYW68ooQjMvAKHgrUVQUlX568nZcIMxLAVexF
 Ibhg==
X-Gm-Message-State: AOJu0YzLjlW5WECvCIc/dbXL+5kP4Nkkc7pY8QwQNYjBsb4Igb8JqFa5
 01kvlsuWBvdWdi/QQja7WUKu7VCBsNF9U0lF+/1ThDeujMex75wc3D2ZbmLLMAPifAQiK4K4MAH
 gqSAXwoMO8ZRg3iTTfacK5tit8TTC65UbbZOj4A==
X-Google-Smtp-Source: AGHT+IHkdZjVaWCiXBMbfZE0KSNMuqLu5ZxX3BZS3esYcWw+cg7rB2uKsnwWsOPjwZYHcavDKBfPZz08gkJhS/QFtk8=
X-Received: by 2002:a05:6a20:db0a:b0:1d2:ba9c:6d9f with SMTP id
 adf61e73a8af0-1d8bcf17e91mr3498500637.17.1728644609627; Fri, 11 Oct 2024
 04:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-13-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-13-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 14:02:53 +0300
Message-ID: <CAC_iWjJF5SBE07SPEik8abFGq3fyZvAo=gpM73=Ds=K2aiBaJQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] efi_memory: do not add RAM memory to the memory
 map
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
> The EFI_CONVENTIONAL_MEMORY type, which is the usable RAM memory is
> now being managed by the LMB module. Remove the addition of this
> memory type to the EFI memory map. This memory now gets added to the
> EFI memory map as part of the LMB memory map update event handler.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V1: None
>
>  include/efi_loader.h        | 13 ++++---
>  lib/efi_loader/efi_memory.c | 75 +++----------------------------------
>  2 files changed, 12 insertions(+), 76 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 081cb65d3f7..0d5555c7597 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -798,10 +798,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                                           int memory_type,
>                                           bool overlap_only_ram);
>
> -/* Adds a conventional range into the EFI memory map */
> -efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> -                                            u64 ram_top);
> -
>  /* Called by board init to initialize the EFI drivers */
>  efi_status_t efi_driver_init(void);
>  /* Called when a block device is added */
> @@ -1186,9 +1182,14 @@ efi_status_t efi_console_get_u16_string
>  efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int size);
>
>  /**
> - * efi_add_known_memory() - add memory banks to EFI memory map
> + * efi_add_known_memory() - add memory types to the EFI memory map
> + *
> + * This function is to be used to adding different memory types other

/adding/add

> + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> + * memory is handled by the LMB module, and gets added to the memory

no comma after module

> + * map through the LMB module.
>   *
> - * This weak function may be overridden for specific architectures.
> + * This function may be overridden for specific architectures.

Since you are rewriting this I think for "architecture specific
purposes" is better

>   */
>  void efi_add_known_memory(void);
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 974ecc51113..0f25094dbf8 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -780,82 +780,17 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
>  }
>
>  /**
> - * efi_add_conventional_memory_map() - add a RAM memory area to the map
> + * efi_add_known_memory() - add memory types to the EFI memory map
>   *
> - * @ram_start:         start address of a RAM memory area
> - * @ram_end:           end address of a RAM memory area
> - * @ram_top:           max address to be used as conventional memory
> - * Return:             status code
> - */
> -efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> -                                            u64 ram_top)
> -{
> -       u64 pages;
> -
> -       /* Remove partial pages */
> -       ram_end &= ~EFI_PAGE_MASK;
> -       ram_start = (ram_start + EFI_PAGE_MASK) & ~EFI_PAGE_MASK;
> -
> -       if (ram_end <= ram_start) {
> -               /* Invalid mapping */
> -               return EFI_INVALID_PARAMETER;
> -       }
> -
> -       pages = (ram_end - ram_start) >> EFI_PAGE_SHIFT;
> -
> -       efi_add_memory_map_pg(ram_start, pages,
> -                             EFI_CONVENTIONAL_MEMORY, false);
> -
> -       /*
> -        * Boards may indicate to the U-Boot memory core that they
> -        * can not support memory above ram_top. Let's honor this
> -        * in the efi_loader subsystem too by declaring any memory
> -        * above ram_top as "already occupied by firmware".
> -        */
> -       if (ram_top < ram_start) {
> -               /* ram_top is before this region, reserve all */
> -               efi_add_memory_map_pg(ram_start, pages,
> -                                     EFI_BOOT_SERVICES_DATA, true);
> -       } else if (ram_top < ram_end) {
> -               /* ram_top is inside this region, reserve parts */
> -               pages = (ram_end - ram_top) >> EFI_PAGE_SHIFT;
> -
> -               efi_add_memory_map_pg(ram_top, pages,
> -                                     EFI_BOOT_SERVICES_DATA, true);
> -       }
> -
> -       return EFI_SUCCESS;
> -}
> -
> -/**
> - * efi_add_known_memory() - add memory banks to map
> + * This function is to be used to adding different memory types other
> + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> + * memory is handled by the LMB module, and gets added to the memory
> + * map through the LMB module.
>   *
>   * This function may be overridden for specific architectures.
>   */
>  __weak void efi_add_known_memory(void)

 We can also get rid of this in the future. Any idea if we have
platforms using it after the last 2 you removed?


>  {
> -       u64 ram_top = gd->ram_top & ~EFI_PAGE_MASK;
> -       int i;
> -
> -       /*
> -        * ram_top is just outside mapped memory. So use an offset of one for
> -        * mapping the sandbox address.
> -        */
> -       ram_top = (uintptr_t)map_sysmem(ram_top - 1, 0) + 1;
> -
> -       /* Fix for 32bit targets with ram_top at 4G */
> -       if (!ram_top)
> -               ram_top = 0x100000000ULL;
> -
> -       /* Add RAM */
> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -               u64 ram_end, ram_start;
> -
> -               ram_start = (uintptr_t)map_sysmem(gd->bd->bi_dram[i].start, 0);
> -               ram_end = ram_start + gd->bd->bi_dram[i].size;
> -
> -               efi_add_conventional_memory_map(ram_start, ram_end, ram_top);
> -       }
>  }
>
>  /**
> --
> 2.34.1
>

With the spelling nits fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
