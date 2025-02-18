Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ABEC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123C880104;
	Tue, 18 Feb 2025 08:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wfT+jYR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D198043C; Tue, 18 Feb 2025 08:03:51 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E45800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so4054304276.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739862227; x=1740467027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=liQ7jh31MHpnRCJNnjjtAu8TKi7tXeepRgy9jIuiCHE=;
 b=wfT+jYR3bVg9pJErpNkEcHtFSEmWxAJIV8ezZLmRFtjnZdC9aH7xI1ryQkK6zXmK7Z
 fQirX7BMOpMronO0Bzzq2n59r/ehP5zc+mG/Mf/IJv7KVdwB/+xbv5HlWVdTZWtU2hZS
 POcy3AbCsAD7/zbPSywuXsNf6ruc4T/Q4wsRSql/uVqpiwzZvx8iBYqRwNFco8DHz7t8
 dyvljFfB/Ts7JIr6eoYMicrW3hH3lLzcF0+WBBL9wQCbRgqy+wgBrOJaF3c28SUuqtgv
 AXclkRK+hpWdYqtdq8Rxw3auv+cq6kzS9c0vuOklBeXylysalt9gTYP70OFRyVK3BLeQ
 weOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739862227; x=1740467027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=liQ7jh31MHpnRCJNnjjtAu8TKi7tXeepRgy9jIuiCHE=;
 b=EDv+Md72ATihbcx3idJj0hMJ8HNMA0yieNBXIimmQK2KaNPniQj+b5D5QgJoaEApBw
 vMz6gIIqiMCcMECsey+Ny+XZ9rbx/ZabU2cJi05WV1xG8eOh27CG4ZM4JHpmWxmckYX1
 xOMyfskgScD0w2Nx96fWqJrqilOEEgv/4k+KfGpVv0tL3xHhyg/hqZ7c5/SynrzElom3
 cvIJKInEmeIYSAsuNu/t4+kTWiYF8Hwyny3ks4d2tialIBcteBh7+nK16b8FlGdFRZmc
 +4NYUcP/wRJ5U7XZPb52xi8TUEVTveHxUG9oiCaZO1YO34lXW5Ur9f8WgMvoe0RKzRBQ
 ROJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+b4rgBTQuoFy+0+lg5L7uOvcQ1Spm1AXEpIYadB4MCSrhckhQ0qzpNH1Gaa0wHwBgG2tVNyc=@lists.denx.de
X-Gm-Message-State: AOJu0YzNzk8yaL9uvIS4TrhdLj2e/bbAdJGfKfC869xMzFao4GVzy+4P
 BIFO7W0ggAt55j0AsZbfFqRb9ClZffRkT0Zgc9C984JFwEpDuv958QpbjzSoHs1Neb4ZI1WPMok
 orl+K39bl9Y6pMJzIpozuJ0uwltXLeajUHPeT5A==
X-Gm-Gg: ASbGnct9wbE2HJwQil3wMgFYRU5OKOunaG2Iv2+1/DmzGltX4UiPjTzsTtKwjL2QYzB
 qlI9YWBH3E4bwls+sDQwz0+/XAqXwoGFvXUFEoXpC9ye5pgybSaX0PYjWEjzZzLruikJc/Krv9g
 ==
X-Google-Smtp-Source: AGHT+IEC+PXQrcy9ybmQ3oda7D+u5nbFoXXun4ZsnTtbo+0SRwbCIYRveRHkhcppYxIQnOw2VMEnyRufc+LObq1imNQ=
X-Received: by 2002:a05:6902:2582:b0:e57:f8cd:f0a4 with SMTP id
 3f1490d57ef6-e5dc91dcaa6mr8281176276.34.1739862227365; Mon, 17 Feb 2025
 23:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250216111241.6846-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Feb 2025 09:03:11 +0200
X-Gm-Features: AWEUYZkGetSWxXvwqAKCsQXE1BNtz8okGG8ERKIDXjS6zfeiVRfOAYSQuluWoTE
Message-ID: <CAC_iWj+LNAPFo1dTO-zuJDo+3zi6c6UQ+Pz1mfzazw1i-scjGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: make efi_add_memory_map_pg() static
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

On Sun, 16 Feb 2025 at 13:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The function is only used in the efi_memory.c module.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h        | 15 ---------------
>  lib/efi_loader/efi_memory.c |  1 +
>  2 files changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index db3d20fd753..1d75d97ebbc 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -852,21 +852,6 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>  /* Adds a range into the EFI memory map */
>  efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>
> -/**
> - * efi_add_memory_map_pg() - add pages to the memory map
> - *
> - * @start:                     start address, must be a multiple of
> - *                             EFI_PAGE_SIZE
> - * @pages:                     number of pages to add
> - * @memory_type:               type of memory added
> - * @overlap_conventional:      region may only overlap free(conventional)
> - *                             memory
> - * Return:                     status code
> - */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                  int memory_type,
> -                                  bool overlap_conventional);
> -
>  /* Called by board init to initialize the EFI drivers */
>  efi_status_t efi_driver_init(void);
>  /* Called when a block device is added */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 11d092dc289..6d00b186250 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -268,6 +268,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>   *                             memory
>   * Return:                     status code
>   */
> +static
>  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                                    int memory_type,
>                                    bool overlap_conventional)
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
