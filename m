Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5459C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F12F83FA4;
	Fri, 11 Apr 2025 12:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HbXr+PDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D8583FA8; Fri, 11 Apr 2025 12:01:37 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EA882B1F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7040987879so1577054276.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744365694; x=1744970494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXvK+7SMU6YHPslCtri7q6lF0rIVLu/tMi9h5gnLhkE=;
 b=HbXr+PDoLt9SvALkM7jeuEdLeB5wf5ZO9oCwd3kSddANIWuR82oZHzYcPHxRGg5fcJ
 nn+xsMYRiqqMFMscPG4lM25VvYD4HaohDi3pJ3f+PzKnOn0wawEoTF8rrA2N76/yIrpv
 TsoDZDEuVuvXNclQ0S+mfP9qxs+7fNsUMfNIItLbmCFOL9Rv3XADXj9nMpzd/SEp6jMM
 WVs7jN3V/I5JGvN6NhMvBhXi6rLAbO1AI1F1Lb8OVbde0mjavpIATLzBgz39d1vIPQqH
 oA79p4gXcH+PvXWehYNXhV543+PRxguUzt2Do52X3r02LJbqxmd+cjJnYfLXIZ9qhz0c
 Iglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744365694; x=1744970494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXvK+7SMU6YHPslCtri7q6lF0rIVLu/tMi9h5gnLhkE=;
 b=eVsTQc1K0Tqy2dLMyJZULpQD3JeqsTQwLGZxCdZp5LeR9sjI3wddcBZv3iwP+jFMbg
 yoa+2BGZ2b2KiyS9J4i0OeQgbvWjkrctpYbKEHA9RbqUZpIqIqG+DHqyOznQvRTXCjPY
 uJXE11o3u6K6JzhvM/q4X1lJi+Np/Q2VM3ZyniT9xEOWx5ZytNrDtYvfbtlrcL091+eK
 J4tT+4qpNWhRXB+ieaXNc0ZNrFAoNHEweOe7KHoFu+qROw5yDPUtwFrOdeYjrwbYfVn1
 rYIz4gkpQkgaxS42lWrZNKVaturMq4Eh+/DF9tdGg08rdtbCJ6MUSXH5IGt4xnuvF0hF
 Idtg==
X-Gm-Message-State: AOJu0YwtKwYZQ6YSsoRsiAcLFCTPkE2jN6hrWys3vtfFH/bBj2iWILeZ
 cjFBe6WwHlpNYMqn7ahpldi5jdb/1CcqA+HJYLDA9St7mprWYFNlAk6XIQRz4KiRpGGXXCcAkz7
 lRrsrmcJG5IhZ13OpUbppsI9zi9aBXtEy33Pal71VhOkisIOgAAg=
X-Gm-Gg: ASbGncsRMWwiJrgtWVZkRFL7oVoA0oy7+sMWHSTwyaA5lXoC/mqBLsTKteeXyt+hgtF
 QZLkin0om/2xI7BefIyBTBJOGRnv30eJcaQl1IGtIJA+XvxxOzgIQoBKHrg1f84smB6fbx054cw
 I7r6LcbqjdJ/6NQzW6VbZR3rs=
X-Google-Smtp-Source: AGHT+IFEBlhlifJRbt1tFVRToCX0Ld0qpuNw57VwdnZSYlfMipfszvbfu3rRjFZW1LOHhp+UcB0aWH6XDDisOa9/32o=
X-Received: by 2002:a05:6902:98f:b0:e65:91f3:fbdd with SMTP id
 3f1490d57ef6-e704decaacfmr3666712276.22.1744365693981; Fri, 11 Apr 2025
 03:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250318092327.55203-1-pkochanowski@sii.pl>
In-Reply-To: <20250318092327.55203-1-pkochanowski@sii.pl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 13:00:57 +0300
X-Gm-Features: ATxdqUHXQQaOMO84k2hUxTarwH8Mx5dK5iy0dTwUkbJgBDZJGVrxso1DYQwAsfY
Message-ID: <CAC_iWjJ+5pFYN-Cp0DcB=AWHF9HnBhKFFCagaq8LDM-=CizF1w@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Make FDT extra space configurable
To: Pawel Kochanowski <pkochanowski@sii.pl>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Gabriel Nesteruk <gnesteruk@sii.pl>
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

On Tue, 18 Mar 2025 at 11:23, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
>
> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> in copy_fdt(), which may not be sufficient if additional nodes
> (such as FMAN firmware) are added later.
>
> This patch uses the exisitng SYS_FDT_PAD to reserve space for FDT fixup
> instead of hardcoded value.
>
> This change prevents potential corruption when resizing FDT after
> EFI boot, especially when firmware like FMAN requires additional
> space.
>
> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> ---
> Changes since version 1:
> - Removed custom CONFIG_FDT_EXTRA_SPACE in favor of already present SYS_FDT_PAD
> - Use the define also in efi_dt_fixup.c
>
>  lib/efi_loader/efi_dt_fixup.c | 2 +-
>  lib/efi_loader/efi_helper.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> index 26928cfc454..544e1aa9808 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -168,7 +168,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
>                 /* Check size */
>                 required_size = fdt_off_dt_strings(dtb) +
>                                 fdt_size_dt_strings(dtb) +
> -                               0x3000;
> +                               CONFIG_SYS_FDT_PAD;
>                 total_size = fdt_totalsize(dtb);
>                 if (required_size < total_size)
>                         required_size = total_size;
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 04b2efc4a3b..40e5d31575a 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>          * needs to be expanded later.
>          */
>         fdt = *fdtp;
> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
>         fdt_size = fdt_pages << EFI_PAGE_SHIFT;
>
>         ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
