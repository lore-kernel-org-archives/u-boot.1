Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261AFC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85EBC88AE0;
	Thu,  8 Aug 2024 12:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qrWMPTn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C9888AEB; Thu,  8 Aug 2024 12:18:59 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A687388A7D
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so646195a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723112336; x=1723717136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8jLEgzUVqK4yt7DE95PWSKkO/NohJhaZmB1WxpXcafg=;
 b=qrWMPTn2VMdJHbNI89ORCXfi0j2J+gsPMH/Gukrrl2LxYhLEW0CjWduPNlcjHSGeEu
 dF6ImU8ti8Es8OMWIi7xkyQ1jdyQvlniDh9gFOYfAzV5rd6/UmYXOtDKOoOj/9qSGyDK
 obH4TP8AmMK9yX7MsyxvAm7R0TujGihqJSGXyAASGjLxbhqaCkrgkHO2SBznL0KvmjjT
 vFReW7p8tkyNUs6v9KLuO81sK5zB3l7IqLHudWciS3bZfn//VA+/8ra2mfqdq8T0fIyk
 wffzbR0s/AuiW34SKXnZsxNl76YCjErE2H8k5r1ofd0+eeYcljiIk2Tbj39FW9bPwEan
 xgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112336; x=1723717136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jLEgzUVqK4yt7DE95PWSKkO/NohJhaZmB1WxpXcafg=;
 b=KKFRD53zlEVzd7i/43tJxRvukhVH0SAS0asKyiGbz/ynyyWMSTnz2QmozT0hiUJoFE
 4nXue6M7lbOzmM7lp72b/G/QTNFIlXG4gulTm8wrrw5a+n16Bs7DN/Dz9hLPD/id9eVA
 /4wxuYzRtaRidnJAj2kVnGPBBGvNP4xwazHGm7hw0cS0TxJWo2lqsbMZhu1uPq70gCBk
 cY+wmsyHzDRlWA3u+qaPQMo2xS0rAQQBQ1qTiwpWV/cUoJWfNjUhGoPAciJpXgkyj9Aw
 YpJhTISPOUFca09uz+/RkLjvo36q+ZGUFLbuboLeYyCGidwn2Q2/zfIETFcuNMp+edot
 dmBA==
X-Gm-Message-State: AOJu0Ywr/QMe6w5Qn42JzxiQWh3kj0t9rx6cZmIAIgaKjI8ldzmB0STX
 D7BIQak3MTBlTZARTkRkH2v1gXGYzQOVneddhjQj6eis8SA730W+QF/izQCAnfyp9Jouzs+wJHU
 eHZX4Q8rpdQsniN0MTavdR5ShjjnucY2fhCZQ6Q==
X-Google-Smtp-Source: AGHT+IHOuBQ7txg04nAQqdoNMfJuu7mrrriFBVSL/f6k3Lk56BYirAoPVYfi3INQVp1NU6xi4mOy2tCzMCJ5MVQ7/rE=
X-Received: by 2002:a05:6a20:3945:b0:1c3:ba3d:3ec3 with SMTP id
 adf61e73a8af0-1c6fcf8133amr1316111637.36.1723112335854; Thu, 08 Aug 2024
 03:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-34-sjg@chromium.org>
In-Reply-To: <20240806125850.2316956-34-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:18:19 +0300
Message-ID: <CAC_iWj+6pC+bfDBJbedjk6sR7-Pjr1dA5adtHOXZ7H0ah9kX_g@mail.gmail.com>
Subject: Re: [PATCH v2 33/39] efi: Use the same filename for all sandbox builds
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 6 Aug 2024 at 15:59, Simon Glass <sjg@chromium.org> wrote:
>
> Sandbox is not a real architecture, but within U-Boot it is real enough.
> We should not need to pretend it is x86 or ARM anywhere in the code.
>
> Also we want to be able to locate the sandbox app using a single
> filename, 'bootsbox.efi', to avoid needing tests to produce different
> files on each host architecture.
>
> Drop the confusing use of host architecture and just let sandbox be
> sandbox.
>
> Fixes: 3a0654ecd0d ("efi_loader: correctly identify binary name")
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  include/efi_default_filename.h | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>
> diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
> index 77932984b55..6806c0daa88 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -5,7 +5,6 @@
>   * file name is defined in this include.
>   *
>   * Copyright (c) 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
> - * Copyright (c) 2022, Linaro Limited

Any reasons why you removed this?

Thanks
/Ilias
>   */
>
>  #ifndef _EFI_DEFAULT_FILENAME_H
> @@ -16,26 +15,8 @@
>  #undef BOOTEFI_NAME
>
>  #ifdef CONFIG_SANDBOX
> -
> -#if HOST_ARCH == HOST_ARCH_X86_64
> -#define BOOTEFI_NAME "BOOTX64.EFI"
> -#elif HOST_ARCH == HOST_ARCH_X86
> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> -#elif HOST_ARCH == HOST_ARCH_AARCH64
> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> -#elif HOST_ARCH == HOST_ARCH_ARM
> -#define BOOTEFI_NAME "BOOTARM.EFI"
> -#elif HOST_ARCH == HOST_ARCH_RISCV32
> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> -#elif HOST_ARCH == HOST_ARCH_RISCV64
> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> -#else
> -#error Unsupported UEFI architecture
> -#endif
> -
> -#else
> -
> -#if defined(CONFIG_ARM64)
> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> +#elif defined(CONFIG_ARM64)
>  #define BOOTEFI_NAME "BOOTAA64.EFI"
>  #elif defined(CONFIG_ARM)
>  #define BOOTEFI_NAME "BOOTARM.EFI"
> @@ -52,5 +33,3 @@
>  #endif
>
>  #endif
> -
> -#endif
> --
> 2.34.1
>
