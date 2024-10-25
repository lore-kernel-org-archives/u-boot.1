Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C06D0C5FB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38AD088DFE;
	Fri, 25 Oct 2024 13:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pQL+BXQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DB688BEF; Fri, 25 Oct 2024 13:17:44 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A17F8900B
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso1314716a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729855052; x=1730459852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EljbPZ8HYAFxXPx673c7XLA36An7N4btONJ4fgcmP7U=;
 b=pQL+BXQyFHf5uu610od6LXqJYUb58JmqwF4KLsNESW7Hgkv7TNi6pbQvfaIgkxX8dp
 dTtbH2D1gL153nNESKNlw7Gj4pbUPx859gEUx0dT0pUateCVoO2AxPehs45fEeUupjfh
 vP7P54GWOojW+JTruCedaGe9ePGgVgUaJfiX8okozX3lHPb+tlf31iqtpZXmZUK9j11l
 mjfPFIrcCYqbTGyC8EN9e0LU5U2khP3KZsvAhxNjFjm2uituUgbJ89QLctIQB6T75gEU
 wPEGNHB8E84ioZIWVnFDPQ9qdE2AroOA01Tgv4jBOLpNBknghaRHr39TA7bG0K9725Z9
 TBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855052; x=1730459852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EljbPZ8HYAFxXPx673c7XLA36An7N4btONJ4fgcmP7U=;
 b=I6zW/1yl2xrlxtosjqBOTgRiGE8aXbPy/OPx9tRXn83YBUVaI6kaSCJeO73YmeDlXA
 8ObSV3kxMmRquCmKWViLlwGvtU8LB/oiUyZA1YB5WDNShLIazKR4HYPzE8uGy6Wwn8LF
 ha8Lw+01Q/a5iWALXJOSMNyliUftR7eoVjdq/U8XFLuUEdQRtt+DkRfhgC8OA7OZCvpy
 XhRwk565RUsa0aDXjnC7kaBoewY5bNmvsl4Sf6bjYitRQvnwBeCLEzEqi/pJmWWhN87s
 mXG/GaQzrDBOcz4oEnGPWwhmZqV5lUp6QW9nkESzhzWXYfu88/IlTY3rur9uwKoQBT0p
 BPKw==
X-Gm-Message-State: AOJu0YzunY4GBpWdLAJLuJ66E3Yp/jW0pmFBm5gBFsgT5ShIMJf3h9+A
 P6q0lpBqa0CDua5yXJ9GWnFfiF7DBok5dZ0IzM/ZNuknAJBZng8N4h8QzVDplfinAKRSMLh3Jk3
 vwiPzhaPaTHznOfh9ZGbJ8bvpFULtqk4LiKCBEg==
X-Google-Smtp-Source: AGHT+IFyQVxhbZvvVpq6NyWxDEfR/JOKiHIQlIBw0y4qKXU58kqlC+QqU+7e8rrtQiF8AhRHQWF66JL1cB915p8eQwI=
X-Received: by 2002:a05:6a20:d808:b0:1d4:fc66:30e8 with SMTP id
 adf61e73a8af0-1d978aeaee5mr11319012637.10.1729855051763; Fri, 25 Oct 2024
 04:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-4-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-4-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 14:16:55 +0300
Message-ID: <CAC_iWjJbCq9VjD_hAOdAFRdJtYdSBJjBHhruG35N+c-4sSh03Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi_loader: preserve installer images in pmem
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
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices.
>
> It's worth noting that for linux to instantiate the /dev/pmemX device,
> the memory described in the pmem node has to be omitted from the EFI
> memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
> enabled. With those enabled the pmem driver ends up calling
> devm_memremap_pages() instead of devm_memremap(). The latter works
> whether the memory is omitted or marked as reserved, but mapping pages
> only works if the memory is omitted.
>
> On top of that, depending on how the kernel is configured, that memory
> area must be page aligned or 2MB aligned. PowerPC is an exception here
> and requires 16MB alignment, but since we don't have EFI support for
> it, limit the alignment to 2MB.
>
> Ensure that the ISO image is 2MB aligned and remove the region
> occupied by the image from the EFI memory map.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a3aa2b8d1b..16f75555f6 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -18,6 +18,8 @@
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
>
>  static const struct efi_boot_services *bs;
>  static const struct efi_runtime_services *rs;
> @@ -358,13 +360,16 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>         }
>
>         /*
> -        * TODO: expose the ramdisk to OS.
> -        * Need to pass the ramdisk information by the architecture-specific
> -        * methods such as 'pmem' device-tree node.
> +        * Linux supports 'pmem' which allows OS installers to find, reclaim
> +        * the mounted images and continue the installation since the contents
> +        * of the pmem region are treated as local media.
> +        *
> +        * The memory regions used for it needs to be carved out of the EFI
> +        * memory map.
>          */
> -       ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> +       ret = efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
>         if (ret != EFI_SUCCESS) {
> -               log_err("Memory reservation failed\n");
> +               log_err("Failed to reserve memory\n");
>                 goto err;
>         }
>
> @@ -486,6 +491,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>                 ret = EFI_INVALID_PARAMETER;
>                 goto err;
>         }
> +       /*
> +        * Depending on the kernel configuration, pmem memory area must be page
> +        * aligned or 2MB aligned. PowerPC is an exception here and requires
> +        * 16MB alignment, but since we don't have EFI support for it, limit
> +        * the alignment to 2MB.
> +        */
> +       image_size = ALIGN(image_size, SZ_2M);
>
>         /*
>          * If the file extension is ".iso" or ".img", mount it and try to load
> --
> 2.34.1
>
