Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC8DC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6953D80703;
	Thu, 16 Jan 2025 02:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lsjko4tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B76D180214; Thu, 16 Jan 2025 02:27:15 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F56806DD
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so542495a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990833; x=1737595633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aRa1fIFp0YbvbNJhWc/LnCc0xVRhDIvd/cVo7xQGY4g=;
 b=lsjko4twBorGhT5JmyT4LGFcv/GTnAH8JCnmRwYz8z93psNkYgECJmr+JtGq/9Vpm6
 2WFYDyXUO9qM2ZG8LSMMMN+qRVu6xmAfZ4c2VAk98r0w0ssyQ1D/InwAq6V/N1Qa83IE
 cvOMTHCb/espFvzY6BzEjQLNinQ2vg8N9MCjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990833; x=1737595633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aRa1fIFp0YbvbNJhWc/LnCc0xVRhDIvd/cVo7xQGY4g=;
 b=sp+lreps/J41+J0VBMQJpE3qaZgx8C2KpoC+iG6LU/GoE881xnSeRHrxa+Y/VVOLxv
 L5yqpapFD/02YivpGkQ8oGmcrXLVQKO8KEO8+2UaRTu7p1LCQergzQKIlmwATgXCc4gO
 gpSu0FLII8Kx78DWewn6ENMCNZ/nSEeyksa2Ynax736KYCqeclAVes+rNHzzyORQ+XJt
 GjDGIYCeskhWs4szTAXN+YJRh5Fx+IvzpEP0sTydAawFnKEsqVlKutOPUzjauOciEoo1
 kPBsTEjo25D6CPxU7XbKI1lIK/9AIr4iWYgMdxlt+GC7ncPxGx4oexLC9VTSJJYjBzG3
 s8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY48saF/hhb+KT4uILi2X1I/kDM4ie/RxgXEXWzzGjjtxiM9b7eyPn/+B0KXrO6MfWNIjN/tE=@lists.denx.de
X-Gm-Message-State: AOJu0YzfPsslIuRmQ4/YtNobxkNjKybXwnS87BCemEHFDARme3ginic7
 PwudYgtvn00bhHn3bAyoLJsnGXdl5fE92pMez9SFl2imUoQ8uWVWmvb0xxhIVQQLP6dhas162Ej
 9IENcXHqd6ufYtmp5mucX+Uy7B8qpWDwhdD2D
X-Gm-Gg: ASbGncuES38DZn/uTDa1bXGbdSnovH905hEl2aBW57uKZzBLs3IBPS4cEQ1ZNmXQZDc
 GZieFVG8FDxtHtwmAyAvxOCqzsrkrHoYDJeqS07Q=
X-Google-Smtp-Source: AGHT+IEPjrmvw4Wag/BuQlkrmXpmYKpud1tZAHEO7Z60KsdjIxweZnx97cvnkF7A7tdp43dJ1XOvLeCN3TEcpWeVl0E=
X-Received: by 2002:a05:6402:84f:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d972d26e91mr78491783a12.0.1736990833064; Wed, 15 Jan 2025
 17:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
In-Reply-To: <20250115135209.13946-4-harrison.mutai@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 18:26:58 -0700
X-Gm-Features: AbW1kvYkQ3oetKEyW46fb8_7LeoW4r2llPOiymqQhQhD6MOiW4gto1i95eyoElg
Message-ID: <CAFLszTh=c0VXjRN3kSPkJYkujEF3GhFcx9kx9DpjxaFx5addqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com, andre.przywara@arm.com, 
 manish.pandey2@arm.com, u-boot@lists.denx.de
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

Hi Harrison,

On Wed, 15 Jan 2025 at 06:53, Harrison Mutai <harrison.mutai@arm.com> wrote:
>
> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
> bloblist present in the incoming standard passage is utilised in-place.
> There is no need to specify the size of the bloblist as the system
> automatically detects it using the header information.
>
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> ---
>  common/Kconfig    | 8 +++++++-
>  common/bloblist.c | 5 ++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 7a80b797df..49fe04ffca 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1064,6 +1064,12 @@ config BLOBLIST_ALLOC
>           specify a fixed address on systems where this is unknown or can
>           change at runtime.
>
> +config BLOBLIST_PASSAGE
> +       bool "Use bloblist in-place"
> +       help
> +         Use a bloblist in the incoming standard passage. The size is detected
> +         automatically so CONFIG_BLOBLIST_SIZE can be 0.
> +
>  endchoice
>
>  config BLOBLIST_ADDR
> @@ -1078,6 +1084,7 @@ config BLOBLIST_ADDR
>
>  config BLOBLIST_SIZE
>         hex "Size of bloblist"
> +       default 0x0 if BLOBLIST_PASSAGE
>         default 0x400
>         help
>           Sets the size of the bloblist in bytes. This must include all
> @@ -1088,7 +1095,6 @@ config BLOBLIST_SIZE
>  config BLOBLIST_SIZE_RELOC
>         hex "Size of bloblist after relocation"
>         default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> -       default 0x0 if BLOBLIST_PASSAGE
>         default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
>         help
>           Sets the size of the bloblist in bytes after relocation. Since U-Boot
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 110bb9dc44..f52f1eaca9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -475,6 +475,9 @@ int bloblist_reloc(void *to, uint to_size)
>  {
>         struct bloblist_hdr *hdr;
>
> +       if (to_size == 0)

if (!to_size)

> +               return 0;
> +
>         if (to_size < gd->bloblist->total_size)
>                 return -ENOSPC;
>
> @@ -510,7 +513,7 @@ int bloblist_init(void)
>          * install the bloblist passed from previous loader to this fixed
>          * address.
>          */
> -       bool from_boot_arg = fixed && xpl_is_first_phase();
> +       bool from_boot_arg = xpl_is_first_phase();
>
>         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
>                 from_addr = false;
> --
> 2.46.2
>

Regards,
Simon
