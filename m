Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A624D3C92E
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 23:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3977088F92;
	Sun, 20 Oct 2024 01:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="iqJ10njS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4307C89018; Sun, 20 Oct 2024 01:07:20 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1531788EDE
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 01:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e2c51f62-8e6e-11ef-9ddc-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e2c51f62-8e6e-11ef-9ddc-00505699b430;
 Sun, 20 Oct 2024 01:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MjlweXfs234j4yTSQZdsspGcLgqpvBcgxcJBE861VCs=;
 b=iqJ10njSmKgko+64Qvz2FXzuhYZQ+/WJAXwhoYW+RVCu3XGBtYvFhh2wESNZ9UhMxNjby2rbBB5nW
 HaBYWtg8NE5oQoY8SlnSGs5HjFyU/AVPLaOqyqPgYnufVF0YKeBZLzKHzDGhJjjnlJ1bgvw74oOiND
 kzfy6wkrjz3/Bj1CtkNpsGXY8hYd9dgM8XsLM1J9RtdDIKda3+p+ri7UEaxO6hB8FO7oXV2uXAb+in
 puROJ829ud64lAFMLYQ5iQH2XFa5gS2VMoUFoxTZJXC6jh/4krlPnLBLnrXAIaZTaePykPFs/eLTGL
 CtAn0S/oSTraC+VmW7wBn0Fiw90B2Kw==
X-KPN-MID: 33|ML1M/LS3NY3/jqC3UAvLNcecRGKPDWJH1qrNrEK6m5HnOI/l4K40GpOLyaJo+6n
 uUosR+dd8p6XCVTa49OX2sf1vQThRM+Fe59LsmenHw80=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YyjEP0JKzG8QUq2nr4ZXFq5tWjLEi8saeUT+57OwHQfRX2UbUGYmal+TAPAzSr/
 4ZX4rHP3BTRcZFFiIVoaS1A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e278a749-8e6e-11ef-9744-005056998788;
 Sun, 20 Oct 2024 01:07:17 +0200 (CEST)
Date: Sun, 20 Oct 2024 01:07:16 +0200
Message-Id: <871q0bheu3.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, sjg@chromium.org
In-Reply-To: <20241019152434.1017394-3-sjg@chromium.org> (message from Simon
 Glass on Sat, 19 Oct 2024 09:24:29 -0600)
Subject: Re: [PATCH v7 2/7] Revert "efi_loader: correctly identify binary name"
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-3-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sat, 19 Oct 2024 09:24:29 -0600
> 
> This patch was applied without sandbox review. It has changed how
> sandbox works and the original author has not been willing to
> discuss alternatives.
> 
> This reverts commit 3a0654ecd0d6a39406e6fe91f7a40ce589594ae9.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

This breaks EFI booting from removable media in a cross-compiled
U-Boot.  And you still end up with the same HOST_ARCH-dependent
BOOTEFI_NAME for sandbox, so no, this didn't change how sandbox works.

> Changes in v7:
> - Add a revert of the un-reviewed patch, instead of just changing it
> 
>  include/efi_default_filename.h | 41 +++++++++++++---------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
> index 77932984b55..13b9de8754a 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -5,7 +5,6 @@
>   * file name is defined in this include.
>   *
>   * Copyright (c) 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
> - * Copyright (c) 2022, Linaro Limited
>   */
>  
>  #ifndef _EFI_DEFAULT_FILENAME_H
> @@ -15,42 +14,32 @@
>  
>  #undef BOOTEFI_NAME
>  
> -#ifdef CONFIG_SANDBOX
> -
>  #if HOST_ARCH == HOST_ARCH_X86_64
>  #define BOOTEFI_NAME "BOOTX64.EFI"
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
>  #endif
>  
> -#else
> +#if HOST_ARCH == HOST_ARCH_X86
> +#define BOOTEFI_NAME "BOOTIA32.EFI"
> +#endif
>  
> -#if defined(CONFIG_ARM64)
> +#if HOST_ARCH == HOST_ARCH_AARCH64
>  #define BOOTEFI_NAME "BOOTAA64.EFI"
> -#elif defined(CONFIG_ARM)
> +#endif
> +
> +#if HOST_ARCH == HOST_ARCH_ARM
>  #define BOOTEFI_NAME "BOOTARM.EFI"
> -#elif defined(CONFIG_X86_64)
> -#define BOOTEFI_NAME "BOOTX64.EFI"
> -#elif defined(CONFIG_X86)
> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> -#elif defined(CONFIG_ARCH_RV32I)
> +#endif
> +
> +#if HOST_ARCH == HOST_ARCH_RISCV32
>  #define BOOTEFI_NAME "BOOTRISCV32.EFI"
> -#elif defined(CONFIG_ARCH_RV64I)
> +#endif
> +
> +#if HOST_ARCH == HOST_ARCH_RISCV64
>  #define BOOTEFI_NAME "BOOTRISCV64.EFI"
> -#else
> -#error Unsupported UEFI architecture
>  #endif
>  
> +#ifndef BOOTEFI_NAME
> +#error Unsupported UEFI architecture
>  #endif
>  
>  #endif
> -- 
> 2.34.1
> 
> 
