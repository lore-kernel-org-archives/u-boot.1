Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F109DD18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E90389179;
	Mon, 14 Oct 2024 17:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E8nKiXkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC9A891A4; Mon, 14 Oct 2024 17:51:02 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0E789187
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6e38ebcc0abso12066127b3.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921055; x=1729525855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qt2AYzJnWPrrqyajVvGkXllFj33MmN9JpEttRwYXQJ8=;
 b=E8nKiXkQ4DYOLtZILr7VuylCRxyq/oKCTLUE59EhdVH5ef3eF49MV+ROmSrjjaNwbE
 eQfDmTgFNLzVFfm/b161QTsw9I5eRypGS7+mPAxD/Rg+GiuDs3wugf8a9q0QpzntEqsH
 Es8J/QMEgf4kgvATZb0LcFCC41bSYW8DKDlAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921055; x=1729525855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qt2AYzJnWPrrqyajVvGkXllFj33MmN9JpEttRwYXQJ8=;
 b=qFCfA0OJtzHkf5LUE/q4eiR17DpCLOMtRkHV1YNm1r5QATVXZiusr3p7wF1HQpAGSO
 rck9XflszaC0Ol5hZi3WxyXkJtkeFxLAOuY7Id17bfeFglkGiG3vEaEaqDGOTcwDs5AU
 +6CIFylL+0BoXI4pW8M4D1lkV5+Otn2GhyADLPAMwRIheGUBmDPxDzw6n3ntz703Cd6Y
 Oh8TBRO4V0zPdYnn0kVLTfzMZzfrHv9AOoewHQuxQdUgeOAi3LxIGrH6cW0HJ8S8c2Nj
 nCPQcCU1M/K9Y4kkbTMSgIfCIlJFb/hMlBl6FNNF+hdFlryq1DUy5ITC0FzPsRFdCrFm
 fPFg==
X-Gm-Message-State: AOJu0Yw+/JU03mBYHv7AxKXJJyB0ZQC51QQjkG3qkXEcACv4srYRhhN4
 YsyWJrsJKXKVm8tKv3UQB8H5eX7s0byy6UZr4wP/SsWXUPX/14LrQhHmvUsqsDBJwL1nHWNnp8L
 G7ulehgMRxQrSFUaaqi7jL+dhQfeOb46khaV1
X-Google-Smtp-Source: AGHT+IGFasBVxffImoMyGMbBGCo6g4A6MVqdLTycWvwJ+GvIkLsWQQly2YbOZFT5K3+lnz22VO1AwawHTkcxNQT6CwA=
X-Received: by 2002:a05:690c:5c12:b0:6e2:43ea:552 with SMTP id
 00721157ae682-6e3479b5fa2mr82003177b3.16.1728921054725; Mon, 14 Oct 2024
 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-8-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-8-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:44 -0600
Message-ID: <CAFLszTjiq=_xYZUHzVGnZ3_R0NGEbASiPQ5ACEkmkFZBKAFKCw@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] efi_memory: do not add U-Boot memory to the
 memory map
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
> The memory region occupied by U-Boot is reserved by LMB, and gets
> added to the EFI memory map through a call from the LMB module. Remove
> this superfluous addition to the EFI memory map.

Without the patch before (which so far I don't see the need for), this
code is needed.

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

Regards,
Simon
