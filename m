Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F974C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5823F88297;
	Mon, 26 Aug 2024 13:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RrDigFnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84DB8831F; Mon, 26 Aug 2024 13:15:58 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B481881A5
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3b5f2f621so2907058a91.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724670955; x=1725275755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=paPu3KIM4Tf3GpiO+4iFuUkMBwSHb2CQ813VILkXSXg=;
 b=RrDigFnvjexjvMjJCPMaKGmZHgvVcZuNbLC0PMhRFEjtmOv6adLjUdHCv1q0azMpB2
 6JLkZTeFDiEmtY8816CfeHZZVOkFu1OrJbZDN3B+M16C3uSIjSmjAs9XRMltqj1sfk7v
 9cJ+g2L/xs3oOCc+lezD6KblhrTsUcyNzN9xIEQsolpKE9Tz54Xz8F7SEOPlsMG/vsy3
 tgKxlMMEde6nfYVXTiuMlc0X4qdOaQNoy+agxgk3/Pg47v7wgcwTTHC//ZfuVZTn3NLE
 wrA/tM1L3fG4R3JZHLBZpof1FhoKc2xnpkDL9W3PJFURto07WJExGC61oi3l6ZDpAse4
 vFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724670955; x=1725275755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=paPu3KIM4Tf3GpiO+4iFuUkMBwSHb2CQ813VILkXSXg=;
 b=T2qPpSjIrEgzKmhYrQuZsTEhqh81bYMLxbIzXAtcLaHOZERY/hQ8NGGh4TorPjt6tJ
 TFxynmrRZF3DjhbuPjTwJhjXYZScJMOfEcYRtBIm572akDGIidcXmVsLSBgG/XJIzRXd
 Z//Ek3Siw7YKY0tIp8MFDiXPqh82/NUflDxJIGk0wOwTm62JZlaCNB1foZjs20LPPnd+
 mcDkPDsCLzB1hYDBGWzUs/98c+gJDnViWWpy5jx3vU1Bnlqt1eKKvC/PhalyzcgVWmHB
 +0u6UcWenIHZlTCHeEP/sVKnr1DTOZBAN6a9rRFm7TZIpH59V0k2i7DddxTNN6rOnaC+
 iTPA==
X-Gm-Message-State: AOJu0YyLoxew1t+o9KydDBgLoQd45zdXdxo6aKk+C4eKwqM/Gn9WKguN
 us3vZI4UvoRpRpaWr1Yb7mof5vDDwKf8jR6EvKZr2a/80YZW2l4RlA7QnjXczhKbZeKkOArfGUE
 ShIoYf0CsseP47amZQm97TVYivqJI0KK+688iLXuTheh9EfOAXRE=
X-Google-Smtp-Source: AGHT+IHLsC9BZncnxQTlOkEIZgbHsm2EEbdC/5+/myC9R/F0/A87QaFTLTWn8U7RzXX2MsCIJAVUCKJ7sFLbmXu+UY4=
X-Received: by 2002:a17:90b:2346:b0:2d3:ce99:44b6 with SMTP id
 98e67ed59e1d1-2d646d30439mr8731017a91.29.1724670954771; Mon, 26 Aug 2024
 04:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-9-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-9-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:15:18 +0300
Message-ID: <CAC_iWj+6jbSknsmZ_079YtNFw3yTsRFTdaP5LBnLR8a4y7qLYA@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] efi: Use the same filename for all sandbox builds
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
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
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 3a0654ecd0d ("efi_loader: correctly identify binary name")

The reasoning here, was that sandbox is compiled for the host arch,
that's why the name were preserved.
I don't mind changing that, but we don't need the fixes tag.

Without that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Put back the Linaro copyright accidentally removed
>
>  include/efi_default_filename.h | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
> index 77932984b55..06ca8735002 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -16,26 +16,8 @@
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
> @@ -52,5 +34,3 @@
>  #endif
>
>  #endif
> -
> -#endif
> --
> 2.34.1
>
