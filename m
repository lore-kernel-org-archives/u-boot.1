Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7510C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DB080A46;
	Thu, 20 Feb 2025 09:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yea0Rhz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835D380C98; Thu, 20 Feb 2025 09:49:11 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E01F801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5dd7b439e3so642626276.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740041347; x=1740646147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/CV7NcW5re0VG/v5MqwN3XMtw/WnPmef3eef1UAw+s=;
 b=Yea0Rhz1B5ko/3QwpCUbwksUeDl4/CX0AOGAHnrPuydRiGyHWfWUhII0iOljhYlSu7
 IP3AHsDsOhhdqxvvUulmKhuCcLm+ygAolDW5vt8wSssaoRL2wShLnmS+ZvSnFDoUJZAd
 hVghAVGiHsSsqmftxw7mFhT3HbKu3WCIslrkPqQgxmnzuYD45oBX2K0Q+w/ttlVtXfcn
 P83Yfjpeti3efJqyChvxus7ucZTbYAD2eo+gEDYiCU3+dAeMc8W0vImZaY1j5/PVmj+T
 /iRNsuk09nXZpdx7HDKFz2Yh/RrlsH0HwvymAwfbAlmj18QF2vqkMQDqlizKPyvZXh1V
 dK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740041347; x=1740646147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/CV7NcW5re0VG/v5MqwN3XMtw/WnPmef3eef1UAw+s=;
 b=C6dDm21HTOoG6/NiSPZyTLMTA4yTzPzPpXQmEJDriwtAjkK+p/Op6mI6pw2FmhyVRn
 MTkdv5AZ4OLIX/lpfSIIaieAb4Fvtd94t/TJM4TjnuyglgIB66AqU0r+wloit92DviXA
 BIfKxa1AewW258hp8/N4XkXh0UdzYNEfDtxQnd+C/Y+HV4MulDkscc5qxj7YfJZ1aMKQ
 Cz3tNecLdpO84w6NqqalwmDF9p6arUH/FRCsp9bGSEhRao/kh8FldvJHPIxYKlENZSP3
 Inae2Igo8qF8N2UOgmi0jFOGCY1mj11UKXiMvOshOab2tcqW7QdIgUAiYpSBPHttUGrK
 3EjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmy7rEr++NIkcKZZSGFMe/d0QH2u3SRUY0cL4YeiiKKAfcxlb13MrJtp/edbV1AVVPegRcFUo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxps5AQqNXVFQJ9lCF2YZ7tq8q1M2q2KTj4FlTHTXGwepPqQahT
 kcz6pLMKUiFPSeJAZErexQu2G+9g/EPcv9/xPYidbx2RCPZSS3RtW9nY35iZonOqlkhOCVLOwZp
 WoZt7AzkI1Nytxd1CtlwH9sqqLF3M7m1h/2SPQQ==
X-Gm-Gg: ASbGncuJptT1xJEMJYpCNzmCY+DuOgPqI/4APJWbNrhlQ+sahv8kstbMDZemuE3DIN7
 qazDnUEKtD+L62BsB39LrBRc9q3f3+9o/x5j7rq083TgISThY6M3BJNtp0Zg8Xt4OgpmPgj/bLw
 ==
X-Google-Smtp-Source: AGHT+IEhs4MAlo0KJfJPL2JoMHPCeD8BE5sVJiWoSPgeATKmaXk426xgM4xUxMyOn/i2W68/9bA8Gf7lB+CwhDy4alg=
X-Received: by 2002:a05:6902:2a8b:b0:e5b:2a51:deb6 with SMTP id
 3f1490d57ef6-e5dc9082a7emr17963596276.25.1740041347023; Thu, 20 Feb 2025
 00:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 10:48:31 +0200
X-Gm-Features: AWEUYZkJPC_Umz1G5_D1le01ihdzh-V73ubBad8MkN7bFBbWyvtDeADhSX6UNqk
Message-ID: <CAC_iWjKj9+S3oDfUSBRcH1U-TJK=7gASBmH4iJ6qEzThwdCbug@mail.gmail.com>
Subject: Re: [PATCH 2/3] lmb: move lmb_map_update_notify() to EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
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

Hi Heinrich

On Sun, 16 Feb 2025 at 13:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> and CONFIG_EFI_LOADER

CONFIG_EFI_LOADER is disabled

> an error undefined reference to efi_add_memory_map_pg
> occurs.
>
> Move the EFI dependent part of lmb_map_update_notify() to the EFI
> sub-system.
>
> Reported-by: Liya Huang <1425075683@qq.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Liya Huang <1425075683@qq.com>
> ---
>  include/efi_loader.h        | 15 +++++++++++++++
>  lib/efi_loader/efi_memory.c | 27 +++++++++++++++++++++++++++
>  lib/lmb.c                   | 31 +++----------------------------
>  3 files changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index dcae6a731a0..db3d20fd753 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1263,6 +1263,21 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>   */
>  void efi_add_known_memory(void);
>
> +/**
> + * efi_map_update_notify() - notify EFI of memory map changes
> + *
> + * @addr:      start of memory area
> + * @size:      size of memory area
> + * @op:                type of change
> + * Return:     0 if change could be processed
> + */
> +#ifdef CONFIG_EFI_LOADER
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +                         enum lmb_map_op op);
> +#else
> +#define efi_map_update_notify(addr, size, op) (0)
> +#endif
> +
>  /**
>   * efi_load_option_dp_join() - join device-paths for load option
>   *
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 1212772471e..11d092dc289 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -865,3 +865,30 @@ int efi_memory_init(void)
>
>         return 0;
>  }
> +
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +                         enum lmb_map_op op)
> +{
> +       u64 efi_addr;
> +       u64 pages;
> +       efi_status_t status;
> +
> +       efi_addr = (uintptr_t)map_sysmem(addr, 0);
> +       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> +       efi_addr &= ~EFI_PAGE_MASK;
> +
> +       status = efi_add_memory_map_pg(efi_addr, pages,
> +                                      op == LMB_MAP_OP_RESERVE ?
> +                                      EFI_BOOT_SERVICES_DATA :
> +                                      EFI_CONVENTIONAL_MEMORY,
> +                                      false);
> +       if (status != EFI_SUCCESS) {
> +               log_err("LMB Map notify failure %lu\n",
> +                       status & ~EFI_ERROR_MASK);
> +               return -1;
> +       }
> +       unmap_sysmem((void *)(uintptr_t)efi_addr);
> +
> +       return 0;
> +}
> +
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7534a231c99..93fc1bea07c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -426,37 +426,12 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
>
>  static struct lmb lmb;
>
> -static bool lmb_should_notify(u32 flags)
> -{
> -       return !lmb.test && !(flags & LMB_NONOTIFY) &&
> -               CONFIG_IS_ENABLED(EFI_LOADER);
> -}
> -
>  static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
>                                  enum lmb_map_op op, u32 flags)
>  {
> -       u64 efi_addr;
> -       u64 pages;
> -       efi_status_t status;
> -
> -       if (!lmb_should_notify(flags))
> -               return 0;
> -
> -       efi_addr = (uintptr_t)map_sysmem(addr, 0);
> -       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> -       efi_addr &= ~EFI_PAGE_MASK;
> -
> -       status = efi_add_memory_map_pg(efi_addr, pages,
> -                                      op == LMB_MAP_OP_RESERVE ?
> -                                      EFI_BOOT_SERVICES_DATA :
> -                                      EFI_CONVENTIONAL_MEMORY,
> -                                      false);
> -       if (status != EFI_SUCCESS) {
> -               log_err("%s: LMB Map notify failure %lu\n", __func__,
> -                       status & ~EFI_ERROR_MASK);
> -               return -1;
> -       }
> -       unmap_sysmem((void *)(uintptr_t)efi_addr);
> +       if (CONFIG_IS_ENABLED(EFI_LOADER) &&
> +           !lmb.test && !(flags & LMB_NONOTIFY))
> +               return efi_map_update_notify(addr, size, op);
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>         return 0;
>  }
> --
> 2.47.1
>
