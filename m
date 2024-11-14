Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83BED65C52
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 07:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4787B88F2A;
	Thu, 14 Nov 2024 08:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nBrY76SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB6889045; Thu, 14 Nov 2024 08:04:17 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E1588F23
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so168908a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731567853; x=1732172653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LW+KYF9lxBh5GLuhDCSkHm8BTbJOOlKR2Dd2odvOos=;
 b=nBrY76SMkcfPZ13KwGEPprFhtUGfQBzh8UxeyoeDH8Fx0UM380HBiGkMZZWx3HW9CQ
 FqdC29Ls6A7k8ECMvfaQzdQwXmLzQePR/Rrr+B80peDHnycwACFDcMdXi1Qnx23UOXja
 xR9Tx//yWQ1J0D9480ceI/21ObfSOdfRDeEXf0v19A0fL4z4mosIrjJ6xXk/IFa/0H8z
 G7+cQ0ienMQWZOSHc4HW68wQRNvm2EagylqgnEe/JNz5IX/1n+wR4Qr/M8AbpeD8WsCu
 quj7rVjXeo4Oawuy5MHbjehDfetFZcg6J5PrniLSt3pmPdf+x8C73U71oN8uJXjj65Jv
 qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731567853; x=1732172653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LW+KYF9lxBh5GLuhDCSkHm8BTbJOOlKR2Dd2odvOos=;
 b=MDg+Spl049c/kJFGIRwnE0tAa2hktdR8ZF2JoH2ibLnQyMjz/Zf2qE2wIaYwgKGFgV
 Tf9689lA307cWU9pEwbQRz3/R6SRLBNxa1TlhKQmlQZt3RRUYf6CIxgrRloURtfTAxy/
 9xIgg6aKtf19RFhc0YoN1BUoHdDlWYcxApYC/Xb7ZRGLV86ZjBySjZ1JCN8xv/zuDzKr
 RUDnF/5of7y5HViZ/HQsCavFQFmywZN1Pp07dkGmi2PMP1KR/mHjhbvtvY3Mtry1y1uW
 a9j7RzMbL/EgIV7TWvdhVkAhgsDS2dVE1hyjjGfnke0DQG0jVvSkr6VuDR31ypsl00t0
 yCuQ==
X-Gm-Message-State: AOJu0YzDHIw049kSxq6d2zdlxiQ3lNOyS7toGs2DMoZ7qf59TIEpF2kg
 sSV5/JbbFOEYzekaHM5Fivel6wLb4kIqrw0SmhNlD6sxxunzzon0qoMy134/pWQqsd2Cp/y+bj/
 z0gbbRpR6KhtogLSLT7yWe60klPyTqJzE65wRBw==
X-Google-Smtp-Source: AGHT+IF5BQQEVpGXOoy7Mmt0aDgCiCMaetZStc1mw0gORBEScNmujYSCvab+pGiIS4YawL3kJinkbog9R/7sTHoMQtM=
X-Received: by 2002:a05:6a21:3e0f:b0:1db:ec5c:cae7 with SMTP id
 adf61e73a8af0-1dc834d2a30mr1165168637.40.1731567853114; Wed, 13 Nov 2024
 23:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-2-sjg@chromium.org>
In-Reply-To: <20241112141105.640189-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 09:03:36 +0200
Message-ID: <CAC_iWjJB4=6Zm8XsgiQcQkUzoDOWnAowzf6C3sVvXNQTv_oByA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Simon,

On Tue, 12 Nov 2024 at 16:11, Simon Glass <sjg@chromium.org> wrote:
>
> The cache-flush function is incorrect which causes a crash in the
> remoteproc tests with arm64.
>
> Fix both problems by using map_sysmem() to convert an address to a
> pointer and map_to_sysmem() to convert a pointer to an address.
>
> Also update the image-loader's cache-flushing logic.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Drop message about EFI_LOADER
>
>  arch/sandbox/cpu/cache.c              |  8 +++++++-
>  drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>  lib/efi_loader/efi_image_loader.c     |  3 ++-
>  3 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> index c8a5e64214b..96b3da47e8e 100644
> --- a/arch/sandbox/cpu/cache.c
> +++ b/arch/sandbox/cpu/cache.c
> @@ -4,12 +4,18 @@
>   */
>
>  #include <cpu_func.h>
> +#include <mapmem.h>
>  #include <asm/state.h>
>
>  void flush_cache(unsigned long addr, unsigned long size)
>  {
> +       void *ptr;
> +
> +       ptr = map_sysmem(addr, size);
> +
>         /* Clang uses (char *) parameters, GCC (void *) */
> -       __builtin___clear_cache((void *)addr, (void *)(addr + size));
> +       __builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> +       unmap_sysmem(ptr);
>  }
>
>  void invalidate_icache_all(void)
> diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
> index ab1836b3f07..0b3941b7798 100644
> --- a/drivers/remoteproc/rproc-elf-loader.c
> +++ b/drivers/remoteproc/rproc-elf-loader.c
> @@ -6,6 +6,7 @@
>  #include <dm.h>
>  #include <elf.h>
>  #include <log.h>
> +#include <mapmem.h>
>  #include <remoteproc.h>
>  #include <asm/cache.h>
>  #include <dm/device_compat.h>
> @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
>         for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
>                 void *dst = (void *)(uintptr_t)phdr->p_paddr;
>                 void *src = (void *)addr + phdr->p_offset;
> +               ulong dst_addr;
>
>                 if (phdr->p_type != PT_LOAD)
>                         continue;
> @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, unsigned long addr, ulong size)
>                 if (phdr->p_filesz != phdr->p_memsz)
>                         memset(dst + phdr->p_filesz, 0x00,
>                                phdr->p_memsz - phdr->p_filesz);
> -               flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> -                           roundup((unsigned long)dst + phdr->p_filesz,
> +               dst_addr = map_to_sysmem(dst);
> +               flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> +                           roundup(dst_addr + phdr->p_filesz,
>                                     ARCH_DMA_MINALIGN) -
> -                           rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> +                           rounddown(dst_addr, ARCH_DMA_MINALIGN));
>         }
>
>         return 0;
> @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
>         const struct dm_rproc_ops *ops;
>         Elf32_Shdr *shdr;
>         void *src, *dst;
> +       ulong dst_addr;
>
>         shdr = rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
>         if (!shdr)
> @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *dev, ulong fw_addr,
>                 (ulong)dst, *rsc_size);
>
>         memcpy(dst, src, *rsc_size);
> -       flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> -                   roundup((unsigned long)dst + *rsc_size,
> -                           ARCH_DMA_MINALIGN) -
> -                   rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> +       dst_addr = map_to_sysmem(dst);
> +       flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> +                   roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> +                   rounddown(dst_addr, ARCH_DMA_MINALIGN));
>
>         return 0;
>  }
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 0ddf69a0918..bb58cf1badb 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -13,6 +13,7 @@
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <pe.h>
>  #include <sort.h>
>  #include <crypto/mscode.h>
> @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>         }
>
>         /* Flush cache */
> -       flush_cache((ulong)efi_reloc,
> +       flush_cache(map_to_sysmem(efi_reloc),

Shouldn't we now umap that address on the err: tag?

Thanks
/Ilias
>                     ALIGN(virt_size, EFI_CACHELINE_SIZE));
>
>         /*
> --
> 2.34.1
>
