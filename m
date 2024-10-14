Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2C0D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3A5891B3;
	Mon, 14 Oct 2024 17:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LHwNY4w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D030891E1; Mon, 14 Oct 2024 17:51:10 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCE2891C1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46045199e4dso50010031cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921066; x=1729525866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6yR3+vFN4sKJK3mDaXm7Qq6nbDZbLclrapt3P8WwQCM=;
 b=LHwNY4w+gPqg9xBWFfMsB+8HuBERtheoAwx3fkwH2VFcjRPyU+pjUHc682oRVql35S
 BxBfIowomN5glwoVzDNmj2SHAUr9PvHF1JIhIchBvNRhnILA8Sc/1IoX/dfMLFJThnT4
 zQurt0ITFb4v5pD23aoQWf3pOSldmEFY7YbNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921066; x=1729525866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yR3+vFN4sKJK3mDaXm7Qq6nbDZbLclrapt3P8WwQCM=;
 b=jGSKzOAscczx7rxvh7zuT1EDFOHsD6pAbg7BEcFCh7vvVKuHkZSCIUcjAm/ZDWc1j5
 STPDIQP9+4hCmI2JeQ2MxuoKdWlGV+JW4sDF6UK8nqUKuMcDkIa7EZcSYZvdjWxEpwRL
 b73uonIQMnR1TaO2ZP8alLzO5I1mG1cLsQzofOdacmYS92BwtJjxoUbcM8Ht8YLrEbWp
 NuRn4A/n24nx2M/R1lWGJ2FuxydeiZcb3c4+/nxS5C69VUiN1CrYXm0gh2Ox/xNCQGtY
 6yZt4Eeuestl+fLWbdtdPrhq/czLkZ8C7IGdn2UX/bI2uygZe0yeO/8nWvSCsFn20CFE
 PMrQ==
X-Gm-Message-State: AOJu0YyTW6agMAEr5FW2/+jA1A9ag97LYFen1XPjcfIfr4ng2s4ihC+v
 Lfd6lXEL9FhhqMeujCTOxiDx3Gy+P8440jAZ3BZwr6A+/ptFoTUGLzTDwMHQx8E3ku1BzJ1ApvX
 ZBiiLTCphWmxU90onHZ6/jPUkFHBCXfcvqeun
X-Google-Smtp-Source: AGHT+IE+VaPVufJ6BPYJw0HKbHNNoO50+pZHP/0Auwq6G5hVehqAlc+A0KNpkamYBAHvVhx4ZMSzBqtmnw8V2svsGjE=
X-Received: by 2002:a05:6214:451d:b0:6cc:458:8128 with SMTP id
 6a1803df08f44-6cc045884b4mr100866186d6.53.1728921066523; Mon, 14 Oct 2024
 08:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-14-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-14-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:54 -0600
Message-ID: <CAFLszTjaEykNVFP+p7FKL7uQpR-cGo4tWn2rV=SQ8Ugq1T+TWw@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] efi_memory: do not add RAM memory to the memory
 map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
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

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI_CONVENTIONAL_MEMORY type, which is the usable RAM memory is
> now being managed by the LMB module. Remove the addition of this
> memory type to the EFI memory map. This memory now gets added to the
> EFI memory map as part of the LMB memory map update event handler.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V2:
> * Fix the wording of some comments in efi_add_known_memory() as
>   suggested by Ilias.
>
>
>  include/efi_loader.h        | 13 ++++---
>  lib/efi_loader/efi_memory.c | 77 +++----------------------------------
>  2 files changed, 13 insertions(+), 77 deletions(-)
>

This is replacing direct, simple code with an indirect and hidden call
from the lmb module. It doesn't feel like an improvement for me. It
seems more like an obfuscation. Now I see why you have done this,
since now lmb is calling back into EFI, but it shouldn't...

efi_add_known_memory() should not be weak as noted before

Instead, have add_known_memory() get the information from lmb
directly, by reading out the lmb table in efi_init_obj_list() ?

> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index ac20395718..6b9a66a06c 100644
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
> + * This function is to be used to add different memory types other
> + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> + * memory is handled by the LMB module and gets added to the memory
> + * map through the LMB module.
>   *
> - * This weak function may be overridden for specific architectures.
> + * This function may be overridden for architectures specific purposes.
>   */
>  void efi_add_known_memory(void);
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 16e64987af..f59f7780e9 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -783,82 +783,17 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
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
> + * This function is to be used to add different memory types other
> + * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
> + * memory is handled by the LMB module and gets added to the memory
> + * map through the LMB module.
>   *
> - * This function may be overridden for specific architectures.
> + * This function may be overridden for architectures specific purposes.
>   */
>  __weak void efi_add_known_memory(void)
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

Regards,
Simon
