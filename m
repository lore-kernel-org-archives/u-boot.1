Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582DBC2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D734A8843F;
	Wed, 19 Jun 2024 14:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xSsSxREX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5428843F; Wed, 19 Jun 2024 14:25:34 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9950887F5C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6e41550ae5bso4866596a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718799930; x=1719404730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mxuCKMMsDWfbYEPYRBRnL5zgnaP8L9ClTGWPGFdd5XE=;
 b=xSsSxREXyCn7t+OaoYLaxllHfSQIcrtC/vqmoqTUzykMndB82FlCo6Rj4rXFp4artQ
 hpTxN1tCfRnhF1WLgkIk5N7u7gtUgq1c5D7NNbL8I04E5IYvw/eU8hSUWFK8+SYH1sEi
 vV0gckbFaPee+b9qFJ4j9tAHpKxEDOvEkXi9zdIpXakGgN+Whu5h2Vf69N/bfClpYFYw
 y44L5jDQeZRRtbdBsdbx7M0hIHlq5h+iRsl3VKvVmLGOMA+R2Q6vLVm2HZ1KkPMbrjVK
 NPsnb2dxdvFsLMZBrH+sPKepS1qtnqpUZxadk+l5KXNikYT+WM5rgbCXEtvQqZyVuKOR
 d1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718799930; x=1719404730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxuCKMMsDWfbYEPYRBRnL5zgnaP8L9ClTGWPGFdd5XE=;
 b=B49ZM8pH/2rPiZC0wwz5GIhHVVFXUhRhoMfI2kBbo9GcEzw59piBTSG9GPu7G5DYT4
 Qn/OUGj/zIxHp17iSpFzACntHOCOE/MA6OJM5WRHtt8RwcdIYG5RJYZqcpVFYcITpptl
 YbScaO//5dw8u/Tv3NaXSDkgeLE8a3EXyrca+9IeZuo2VlTLS+WNDVke8IrFsdKNRAc7
 rH8+ssA+JWZZucJ0sHfkrGQGS7kAsyLkLw5QTMvHojov294cMhMBiDrZpcuyC6AxGz/b
 hogm79IslVtl4b/Th5eUqxibQJr6GjijuUIRmRUw08ZL7fEJV+FEAJoC6woD7CugnpjR
 WRDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWNTE+/AyzZT14ysqcEQPebkmDmxHZiEzBzQO4qs9SflkIldkuujNfPcdhaxjT3uRfEVE9gkrD5+oD60+AKtIJcNfukQ==
X-Gm-Message-State: AOJu0Yxu+hfiodIEcq3DxmbjhYIQHwyY9Ztl79jh97R9Wge/neAUnNZu
 5C7brwFgQlIzkxrOpo1JuLPr8aIZAkS5/uvgub+QLxRZzHN8K5EMufAmZBXPR42OVbuKrnriGL7
 xUjdFmzR7bZR/mbLqwBVTv2inmzuaQL6Mf6v0Ew==
X-Google-Smtp-Source: AGHT+IGCtuGBKfRcuCjd4KyLbRkpWh48KElPjo5EzfE6dJ5h8RxY4zYJTBCCvJS4CIv8Fo3IybLh2uYLnQtnmInHhD4=
X-Received: by 2002:a05:6a20:1a9e:b0:1b5:bc67:b9fa with SMTP id
 adf61e73a8af0-1bcbb58c60bmr1985070637.20.1718799930017; Wed, 19 Jun 2024
 05:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240616173105.7430-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 15:24:54 +0300
Message-ID: <CAC_iWjJAKQvfiXMTPg=yitwYWfhZjER_3t4PQkaR8Q2EXvgiCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: avoid duplicate weak
 invalidate_icache_all()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
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

On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If multiple weak implementations of a weak function exist, it is unclear
> which one the linker should chose. cmd/cache.c already defines a weak
> invalidate_icache_all().
>
> We don't need a call to invalidate_icache_all() on x86.
> ARM, RISC-V, and Sandbox provide an implementation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_image_loader.c | 13 +++++++------
>  lib/efi_loader/efi_runtime.c      |  7 ++++++-
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 60424360328..45dc5b6b244 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -173,11 +173,6 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>         return EFI_SUCCESS;
>  }
>
> -void __weak invalidate_icache_all(void)
> -{
> -       /* If the system doesn't support icache_all flush, cross our fingers */
> -}
> -
>  /**
>   * efi_set_code_and_data_type() - determine the memory types to be used for code
>   *                               and data.
> @@ -986,7 +981,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>         /* Flush cache */
>         flush_cache((ulong)efi_reloc,
>                     ALIGN(virt_size, EFI_CACHELINE_SIZE));
> -       invalidate_icache_all();
> +
> +       /*
> +        * If on x86 a write affects a prefetched instruction,
> +        * the prefetch queue is invalidated.
> +        */
> +       if (!CONFIG_IS_ENABLED(X86))
> +               invalidate_icache_all();
>
>         /* Populate the loaded image interface bits */
>         loaded_image_info->image_base = efi_reloc;
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 011bcd04836..05369c47b01 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -783,7 +783,12 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
>         lastoff = offset;
>  #endif
>
> -        invalidate_icache_all();
> +       /*
> +        * If on x86 a write affects a prefetched instruction,
> +        * the prefetch queue is invalidated.
> +        */
> +       if (!CONFIG_IS_ENABLED(X86))
> +               invalidate_icache_all();
>  }
>
>  /**
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
