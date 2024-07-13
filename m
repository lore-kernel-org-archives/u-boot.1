Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E74BC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836018893B;
	Sat, 13 Jul 2024 17:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lu3A+hMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7D88892C; Sat, 13 Jul 2024 17:16:25 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC7F88932
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2bfdae7997aso2174270a91.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883781; x=1721488581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g3xKtyqK4RXsO8e4T66TzORWz+pQXaFZKqYsd+tKx3Y=;
 b=lu3A+hMFzcigQBfTS7AEXQh8BWdwshnM4FVdvyhVWo7x01Pz91Zin2TGI3U5Xxmq2y
 xzbr3FWAQ11goNaU+bi5w0qnUBgFBwCw4Kn5jtQe/cwUpAg4I/kDrUEr/NGBIN2VX/Kk
 VWNiizdufz8B2s5lZ7PX+qpnv3Fc/WiozWK/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883781; x=1721488581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3xKtyqK4RXsO8e4T66TzORWz+pQXaFZKqYsd+tKx3Y=;
 b=luh7WdDkH1v7DdRm1VaMdOAUUWx1WhZMKX1lTFt442iX+a3XX5AfbfeqVfGgLc9SUG
 PKRVS4yL6rMHtwa2I1mBG4gYs/nILSsGEXCROrFsz4/bN21SKHV/WVSz0Laa1nM9ZHiA
 xcspeDyz3Yq4eUlj8NOE4808vfvefbXS5EsLbM01Z4PMwhlMgFRVGHkzUx9lDkh5rY0x
 eW91PnzlSITGLjoiL7kqUvuO8jz55h/PTr6+woUvCvojfeoiJm0tFmI9NWH+urjaak7P
 r7mMvQC4cY1kTmCq7/YatmEuodzHANQ/Rh2D8HBSjz8O1CHCH2V2YlmntWa+734O+Ich
 q77w==
X-Gm-Message-State: AOJu0YzKZIaTjxJlkSfU7FwUWNM/HVJYuB6rzk4Y+wliX2aWULNnPpNr
 21b3rPxGbKZWwaDsEhFsw2uX09D93nZWrXEqNc5r3EE3eVm5cR6pBeE5X5Iutf72qGjZt+vflr+
 A5EreWJh8nME1dgeRZay2kyHgEByuxNkdY4m2
X-Google-Smtp-Source: AGHT+IHb8Z3l7UIRyoGId2/HTvQtuygxWevE+oRA6KEua4CmoAWwVxUUjno8+ICf7DoH3TJBiAPkRQo8xmZr63eAgDI=
X-Received: by 2002:a17:90b:1055:b0:2ca:a318:2729 with SMTP id
 98e67ed59e1d1-2caa3183705mr6129342a91.37.1720883781170; Sat, 13 Jul 2024
 08:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-47-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-47-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:16:01 +0100
Message-ID: <CAFLszThvVSuUMOavz=MqpE5GSm5Yr2CBBUvMkvV7RbNGQEPDVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 46/48] lmb: mark the EFI runtime memory regions as
 reserved
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
> Mark the EFI runtime memory region as reserved memory during board
> init so that it does not get allocated by the LMB module on subsequent
> memory requests.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  lib/lmb.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)

I see again that this is getting circular. Can you look at what is
actually allocated by EFI on init (i.e. before anything is booted)?

>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 387ec2ac65..6018f1de31 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -19,6 +19,7 @@
>  #include <asm/global_data.h>
>  #include <asm/sections.h>
>  #include <linux/kernel.h>
> +#include <linux/sizes.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -212,33 +213,31 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
>  /**
>   * efi_lmb_reserve() - add reservations for EFI memory
>   *
> - * Add reservations for all EFI memory areas that are not
> - * EFI_CONVENTIONAL_MEMORY.
> + * Add reservations for EFI runtime services memory
>   *
> - * Return:     0 on success, 1 on failure
> + * Return: None
>   */
> -static __maybe_unused int efi_lmb_reserve(void)
> +static __maybe_unused void efi_lmb_reserve(void)
>  {
> -       struct efi_mem_desc *memmap = NULL, *map;
> -       efi_uintn_t i, map_size = 0;
> -       efi_status_t ret;
> +       phys_addr_t runtime_start, runtime_end;
> +       unsigned long runtime_mask = EFI_PAGE_MASK;
>
> -       ret = efi_get_memory_map_alloc(&map_size, &memmap);
> -       if (ret != EFI_SUCCESS)
> -               return 1;
> +#if defined(__aarch64__)
> +       /*
> +        * Runtime Services must be 64KiB aligned according to the
> +        * "AArch64 Platforms" section in the UEFI spec (2.7+).
> +        */
>
> -       for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
> -               if (map->type != EFI_CONVENTIONAL_MEMORY) {
> -                       lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> -                                                       map->physical_start),
> -                                         map->num_pages * EFI_PAGE_SIZE,
> -                                         map->type == EFI_RESERVED_MEMORY_TYPE
> -                                             ? LMB_NOMAP : LMB_NONE);
> -               }
> -       }
> -       efi_free_pool(memmap);
> +       runtime_mask = SZ_64K - 1;
> +#endif
>
> -       return 0;
> +       /* Reserve the EFI runtime services memory */
> +       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> +       runtime_end = (uintptr_t)__efi_runtime_stop;
> +       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> +
> +       lmb_reserve_flags(runtime_start, runtime_end - runtime_start,
> +                         LMB_NOOVERWRITE | LMB_NONOTIFY);
>  }
>
>  static void lmb_reserve_common(void *fdt_blob)
> --
> 2.34.1
>

Regards,
Simon
