Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29DAE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F51880087;
	Wed, 11 Dec 2024 15:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eGwahiuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6117C8010E; Wed, 11 Dec 2024 15:51:17 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CF780085
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6eeca160f14so57314717b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 06:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928674; x=1734533474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VVET+E2yGVfabC1zumnyKHwR2NAF8X6eOk6olipNylg=;
 b=eGwahiuk1iv3ENS+Z8gbz1BDT9HFqBSOw+eDpbT58zX925SbsC4l9CLELCt9zNILBH
 cGBWzUQzk+82vSxnz/1RfSAfXkVSZ4QD4QUJEgz/rfFRbGAGlLOtkPMyzxHI9fhOTEIT
 P4MZtjfuMgoGKSX57eTu/iui/CEBASGFvlvdQ10ogAXdKl4nz2jCiCFz1cHL+c2jCbKG
 bMteNiWp4zjPcGHU4tvbnmzbxL9ME8sPZh/mLGt62Nh6+TO/chN/Wc7kM9b9WVWWtAJl
 npkw8lPbV4ePU2NZ48kPYVeuABFNOxLXg0g62dHYzNw8waEeM9tBLPUajyKgNt+gLBZY
 gXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928674; x=1734533474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVET+E2yGVfabC1zumnyKHwR2NAF8X6eOk6olipNylg=;
 b=mp1buXqxxHuftaHxhq8DNcbHRrYmjxuY8fDCA60LlhEm2aofnNnidR+pImRZiVi53z
 1EgXE91oHH0eOTd8wVa1qY9G6QCq1H1lMN9f9H0JKGlm5RD50cot2UmE2TT1qBAKQbbj
 RyKgF5NBRTU9RxtGC+QoDHBY7b94mBD0IkHWHICSpxdS0UjqDr2qD9+1OTdE4y6FQZAv
 NiwLBTfz3wu/nMTMJqjjageUGXz2KvfYxQ0bBVjSpNXGQCL0so5z6/QhXS6m+hn05p5r
 WgYdkaIlVJSetVcMkdQIo5SW4ATRMXrYNCmHNT6e5G7OptKBiKwJ6k1XJ/NpwCsWLiw1
 qSSQ==
X-Gm-Message-State: AOJu0YyCu1sFTdjrfVGI77z0XT58Ob2xVKd+oOigbanoL0vs5qA3CnKZ
 I3L2Swab+yhHExQI27fMii9xNfB4Vt/aNTotTw4gmlz//XN2zyNNZ/0TY7ntC9G2L82W5D7Tx1t
 wJBJJfw8iUoNx8s3V/1XjifISjsyz5s/MoDvaMg==
X-Gm-Gg: ASbGnctRgFNDbZEqW7afDPCKcQ++CHjjfWGNiB3HOo7gy8CAbtKw1YZRTc4qzgG+Iv9
 KVszgovsAlA/mFsSvAAaVHmM3cEhkGE2He+I=
X-Google-Smtp-Source: AGHT+IFnuC19QiQ9M90ff3/DeHmDq82IWq65Kv5N09YUOG+UL8WNDm4qUxFkG+9XTE4h+UNUJ0W32Nyq3Q+jQZLF4hQ=
X-Received: by 2002:a05:690c:6a09:b0:6ef:6cdd:57e3 with SMTP id
 00721157ae682-6f147fad894mr33728747b3.8.1733928673960; Wed, 11 Dec 2024
 06:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-5-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 16:50:37 +0200
Message-ID: <CAC_iWjK8LO=m9ymhCDMep0xwa+hR8OSaBfS1VXgWsPLAGfnuXQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] efi_loader: Show the resulting memory address
 from an alloc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Update efi_allocate_pool_ext() to log the pointer returned from this
> call, which can be helpful when debugging.

Can you explain how logging the success is helping? I think its pretty
pointless, why not log a failure?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Show the returned address rather than the pointer
>
> Changes in v2:
> - Use EFI_PRINT() instead of log_debug()
>
>  lib/efi_loader/efi_boottime.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 080e7f78ae3..f27b3827ed2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -13,6 +13,7 @@
>  #include <irq_func.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <pe.h>
>  #include <time.h>
>  #include <u-boot/crc.h>
> @@ -511,6 +512,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
>
>         EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
>         r = efi_allocate_pool(pool_type, size, buffer);
> +       if (r == EFI_SUCCESS)
> +               EFI_PRINT("*buffer = %llx\n", (u64)map_to_sysmem(*buffer));

buffer can be null if size == 0

> +
>         return EFI_EXIT(r);
>  }
>
> --
> 2.34.1
>
