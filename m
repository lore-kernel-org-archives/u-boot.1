Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40993C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24AF8861A;
	Sat, 17 Aug 2024 17:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EVHos1K9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B36688403; Sat, 17 Aug 2024 17:57:47 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9E488600
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so20914186d6.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910264; x=1724515064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=npkpMKMHrruPC2FXV2Aja2yXQYh8e0wDCoAKAWYMi5g=;
 b=EVHos1K9/SNzZhdynbkC+bG+pnHAe5SScamQecdKs2qMOXmdNcmrJvMSBpnVwJJgOc
 gWN+fPTo5kau5uwzNn11dBmFK7zY/Zbwj/DJI8oBnhB06hWK4fVLmm2uzzdl0j/1yB9e
 L3Df3QPfS6qpUIzx0b7JmVG2qqLJSKy3qRSnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910264; x=1724515064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npkpMKMHrruPC2FXV2Aja2yXQYh8e0wDCoAKAWYMi5g=;
 b=b/ZmHIqLuxxTZ6gC1ux4w/KxV4ENcdY1VJwIozQymEaMNFnyxo1YbaLpNuGhd2YlLY
 HsIVeZ098F967PlfpjC3LUJKNHlKvG2yd9D4c3uxFTRKae0V+bc4jEJvfZ/kuZwJV2s0
 0fVvuLfJAd2km245cqTfu8O9YC7fDCFj3hADC6Y/gIWouHCYa3rn1yB8PBkeny1zioib
 wyxvqKVy3Be0AQeMnCGxYP51D1utlQ7+DWKa1ZxkXnkENSvK/6PlVM56P23gJNPlj26L
 z78xR8dtIGCteMW59vZqNpL32q8YAU8y0PJzOeqWsq7yriLIPwpdiTcKNdW/fEWYWArM
 lZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPmexp/6w8OMieFUvzxNb50a/qGyY3DcOXdV1qagsBOLdL/RaNUlouVHpx3E8bZNiO8JVNNbU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzsak/2KOPklVs83dtoYeqe+noilvAzDc1mg3+eARAjZzeUUNQ0
 txMQff0ecN6vD06e4ZeTT3gDSdmqlJENwSlCDriKtFHvkt6twXqmjjB5jCUGwVAGXr1VSSjbpbR
 fb+M11S8PLbzUzTicfkX1X169TxAiKn25afyn
X-Google-Smtp-Source: AGHT+IFq3fqEEBrMN+PESU1FcITm/HnybrNmmIQlxtb7UsC1074XmqD+VGdR6d1/19io8/JoFiwGVc/8uOKk9xToSSM=
X-Received: by 2002:a05:6214:398d:b0:6bf:8f3c:2e6c with SMTP id
 6a1803df08f44-6bf8f3c39d9mr29009256d6.27.1723910264344; Sat, 17 Aug 2024
 08:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240817110222.31415-1-Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240817110222.31415-1-Maxim.Moskalets@kaspersky.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:57:33 -0600
Message-ID: <CAFLszTi+K+xsGHEgeU5EaY+yLn+3DV7dr1+Xy4i0sZXVaObn8g@mail.gmail.com>
Subject: Re: [PATCH] lib: move phdr increment to for loop heading
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Maxim.Moskalets@kaspersky.com
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

Hi Maxim,

On Sat, 17 Aug 2024 at 05:02, Maxim Moskalets <maximmosk4@gmail.com> wrote:
>
> Shifting this pointer in the loop will be more logical when working
> with the code later, because you can see at a glance what exactly
> changes at each iteration. Moreover, the code remains equivalent
> because this variable is not used after the loop.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>  lib/elf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW we normally use post-increment in loops.

> diff --git a/lib/elf.c b/lib/elf.c
> index dc13935e103..205724b71dc 100644
> --- a/lib/elf.c
> +++ b/lib/elf.c
> @@ -86,7 +86,7 @@ unsigned long load_elf64_image_phdr(unsigned long addr)
>         phdr = (Elf64_Phdr *)(addr + (ulong)ehdr->e_phoff);
>
>         /* Load each program header */
> -       for (i = 0; i < ehdr->e_phnum; ++i) {
> +       for (i = 0; i < ehdr->e_phnum; ++i, ++phdr) {
>                 void *dst = (void *)(ulong)phdr->p_paddr;
>                 void *src = (void *)addr + phdr->p_offset;
>
> @@ -99,7 +99,6 @@ unsigned long load_elf64_image_phdr(unsigned long addr)
>                                phdr->p_memsz - phdr->p_filesz);
>                 flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>                             roundup(phdr->p_memsz, ARCH_DMA_MINALIGN));
> -               ++phdr;
>         }
>
>         if (ehdr->e_machine == EM_PPC64 && (ehdr->e_flags &
> @@ -201,7 +200,7 @@ unsigned long load_elf_image_phdr(unsigned long addr)
>         phdr = (Elf32_Phdr *)(addr + ehdr->e_phoff);
>
>         /* Load each program header */
> -       for (i = 0; i < ehdr->e_phnum; ++i) {
> +       for (i = 0; i < ehdr->e_phnum; ++i, ++phdr) {
>                 void *dst = (void *)(uintptr_t)phdr->p_paddr;
>                 void *src = (void *)addr + phdr->p_offset;
>
> @@ -214,7 +213,6 @@ unsigned long load_elf_image_phdr(unsigned long addr)
>                                phdr->p_memsz - phdr->p_filesz);
>                 flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
>                             roundup(phdr->p_memsz, ARCH_DMA_MINALIGN));
> -               ++phdr;
>         }
>
>         return ehdr->e_entry;
> --
> 2.39.2
>

Regards,
Simon
