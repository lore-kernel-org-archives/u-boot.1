Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EBACFC534
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725B18907F;
	Mon, 14 Oct 2024 12:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ckeby1FP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161E589083; Mon, 14 Oct 2024 12:01:32 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C724589074
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e18293a5efso2745005a91.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728900088; x=1729504888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlwMrFqcbYyMTNbSiHG016kYKfqx6XqgWzE9wfWxa5Q=;
 b=Ckeby1FP5vAMqtE/zmuwU72AirNY+fYxy3TvbQ+wJDyg/oTNOqk/eZPJ7IOHKfxjyb
 YHfoIh55d5sybFRRcHrgMYdp/C0mtVmvrn8Mr9aH2P23vZECxFG8OJT2LLmV4VItAZNE
 guNAfRGeNs33Bcw72StseRAlJ9v/gMWia+0IOBTbwwzTKUxMeEOjaAm0bpMWGQOFsq6Z
 BYOXAMA5xD6eB3eaR8EripL4HSgjpkp0y9wVghaEAyguwRQU/2syxZBlqrjlCbSrTsBq
 tEn7GktcLC9dHkcVpjKAGecJ+wRiQAZy4ord8VmZsWznG5p4G8IpwZSWk78pWAX3nrJV
 YVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728900088; x=1729504888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlwMrFqcbYyMTNbSiHG016kYKfqx6XqgWzE9wfWxa5Q=;
 b=IzKuI5bdt1iBVs8Wc5Mt1EfgyodFLJ8O9/NX1AjyvbLYCvzf3tHCa9rlEk/Ll2xGS3
 op4F6517NHbVXTS7O6ElwqvZlOoZigHEKEjdxLknWUlWUH9rt/5aRqITGkIRFCm4eqQ4
 VVuwH5iSH6g+VYjjqjZCWz7tBODwtx3eWMoW4S+6uHxuk5H6PSgaaEdOP+7unFrQa2Ry
 U5e8nFxnQR4VYkWhBwrhiKB4ztf1MXnSriUuy9P4ehxd4NOh5vcPoP7Atd8CptXjtpfC
 3A+wdv0LgL9D4kXovLPvPOAcFajUmAMeDjB4FL8adAz77EeOm1sufr9xYDsHFgIar9bM
 Bg+Q==
X-Gm-Message-State: AOJu0YyySh9SzWKV85nfI/5xruZyk15kEG8WyWpbthRW9uEHDXT7w9Yk
 KZyEqa2jFX3QoK0zSKCwT82uCiKlAPSGjk9aFI63+oXW9cQp0CDst+GSw7wX+MmPhCvmF0n8U6s
 b+dWkojBLTSJLM48oZQjA0YxQ60+Pt7Ms8qRKMw==
X-Google-Smtp-Source: AGHT+IH6xnTe/kgII4CQx39x78XXY374WCFHolMo9JGwOuwMWukVQpvnMK3ZK/vPB4Jxhw/LCFVyhxt4GtpovsVElyA=
X-Received: by 2002:a17:90a:c24f:b0:2e2:da6e:8807 with SMTP id
 98e67ed59e1d1-2e2f0f08c22mr13343613a91.26.1728900088228; Mon, 14 Oct 2024
 03:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-8-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-8-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 13:00:51 +0300
Message-ID: <CAC_iWjKkqRQKe_EPDVKo1QbgH5VEX2t=+asG_QfVotSFfYgG6Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] efi_memory: do not add U-Boot memory to the
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
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

On Sun, 13 Oct 2024 at 13:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The memory region occupied by U-Boot is reserved by LMB, and gets
> added to the EFI memory map through a call from the LMB module. Remove
> this superfluous addition to the EFI memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: New patch
>
>  lib/efi_loader/efi_memory.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 41501e9d41..16e64987af 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -870,16 +870,6 @@ static void add_u_boot_and_runtime(void)
>  {
>         unsigned long runtime_start, runtime_end, runtime_pages;
>         unsigned long runtime_mask = EFI_PAGE_MASK;
> -       unsigned long uboot_start, uboot_pages;
> -       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> -
> -       /* Add U-Boot */
> -       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> -                      uboot_stack_size) & ~EFI_PAGE_MASK;
> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> -       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> -                             false);
>
>  #if defined(__aarch64__)
>         /*
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
