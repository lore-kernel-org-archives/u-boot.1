Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A85D6B6D4
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B756E89245;
	Wed, 30 Oct 2024 21:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mq5z9HPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE4689250; Wed, 30 Oct 2024 21:29:21 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900CA89212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso987809b3a.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730320157; x=1730924957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D0SOV0Kunyll5KwdIelCCqKvcqdVuM84N6nI2NjYLGY=;
 b=Mq5z9HPcmGjm9nIxFZlf2XgP01ZGg6T9IZUZjQlemViQZwz0DT0r64uGyDG2s1qKxi
 mYOc8sTT2yw6XcS1bJ0grhUua0ry4PLDzCqnMFA5YXxIT8djjF5sZRVLrrfqOxdo9MJJ
 NncHRkKSBEduo+cVyUQbXtWgTN4tbb0MNoacpQZhG77AaMW8TS21YUQiYzWVYYgylswD
 kAUKpRQluhsVDQom63nNM8w9/WaulcETQfiFCahOxjPoqwQNRLBBVThIBDxY4dXEavo0
 807peuEdig7Jb2Y4n+AzduomhFMjHUHGZhSoeOT89Ip3NpNRakEp5Vxt6+9pSq/O3+DV
 ppfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730320157; x=1730924957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0SOV0Kunyll5KwdIelCCqKvcqdVuM84N6nI2NjYLGY=;
 b=aX+VAiGeMuDWAlFn7Q/F8AsYV3ZiQOeZLpLsEyzeBgqmmILWeG/e3D0ng8KklWf3ep
 1G5JS+vZG30zTA4I/y+mS0Z+05FzcuNBHdnsKdxi9LJF/p5GL6giYQY79DDDD3nJG2rS
 iwFTFf7G1soJq7mexoSLtRcEunVum6tEYwjs9v5psShaMDKEc3rMsp76Av/oAIEJIZ6P
 fQWEtrFVFJVN/D5PPwvaUnnKShAnaqjZMFj57toVFkaByiL8u1pObkC5ezTz4FpVZ2c4
 ab1WBlo1cNNBRxRRwDohB7dg17IA3IW4fsLHTo1AOeaNfIJBmWedZl1N9NRsTp1nPOxt
 qTvg==
X-Gm-Message-State: AOJu0Yw4B15vFMJLRg9VV1c66Nfx22Zt/42BWzchCf89yFgBEYZmG9i/
 TnlIr6/1RSDLs2rhrjC1Lk/5hEbfxEmFa2LA8f1KFxBiDJoL+U6tihe1xQKUXF+B6r6/4fFtcTI
 xzzv816m5l+3EedRWn9/RaOXj9EdQEivM2f89uw==
X-Google-Smtp-Source: AGHT+IHaGfXSBuCh29xagdWVmLyPQ+D8vO4EJLaDBh3hH7rIGOPFacG8BEnp8maAKYJ/bu1l3UiacQYPfnh4QjFdu10=
X-Received: by 2002:a05:6a00:1805:b0:71e:60d9:910d with SMTP id
 d2e1a72fcca58-72096bbddb8mr10886968b3a.6.1730320157029; Wed, 30 Oct 2024
 13:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241030201608.1247488-1-moritzf@google.com>
In-Reply-To: <20241030201608.1247488-1-moritzf@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Oct 2024 22:28:40 +0200
Message-ID: <CAC_iWj+h5yeBkHENBzPuVYeQYjESrpidzrOtvrJiEO9ezm_jZg@mail.gmail.com>
Subject: Re: [PATCH] lib: efi_loader: Fix efi_dp_from_mem() call
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, trini@konsulko.com, 
 pwildt@google.com
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

Hi Moritz

Thanks for the patch

On Wed, 30 Oct 2024 at 22:16, Moritz Fischer <moritzf@google.com> wrote:
>
> The function expects an end address but is being called with
> an size instead.
>
> Fixes: 6422820ac3 ("efi_loader: split unrelated code from efi_bootmgr.c")
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>  lib/efi_loader/efi_bootbin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0..798bcd6eee 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -137,7 +137,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>                  */
>                 file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>                                             (uintptr_t)source_buffer,
> -                                           source_size);
> +                                           (uintptr_t)source_buffer +
> +                                           (size_t)source_size);

Yes, the change is correct, but we don't need the cast.

With that changed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>                 /*
>                  * Make sure that device for device_path exist
>                  * in load_image(). Otherwise, shell and grub will fail.
> --
> 2.47.0.163.g1226f6d8fa-goog
>
