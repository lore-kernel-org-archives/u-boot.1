Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481EDC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCF787795;
	Wed, 29 Nov 2023 18:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HYnG+Uy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA2387784; Wed, 29 Nov 2023 18:47:49 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E0D87766
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a02d91ab199so5897266b.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280065; x=1701884865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p6YZVEUQf/p4jN6Xjc4u3LqGBXMbsBiUsi926YhUL+Y=;
 b=HYnG+Uy0uckpedcZTFZhWXStpb09Tb6fIuoovjQAIrsg6dDV1b2rSWDxT4myi8KQFb
 JGIf70soPstU6ApO2SOESffZ6qoKKB2uIJSTMMOt1bsK96sDtmTtTFghQvuUx1MZAFOw
 KUHRnyW4dQ7JHYk14FIXsNy9UG9vwWR+UMWKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280065; x=1701884865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6YZVEUQf/p4jN6Xjc4u3LqGBXMbsBiUsi926YhUL+Y=;
 b=EVxRuBACCKwQibkbouHKvabVv7BGJJXVdfLQnErZd+CX1E9/A12yYaASCr6+IQd+29
 kc1OfPbDvd7ahLVhvLTpO8tRkBriDC42CexglWb0Q4oGgaLSsp9D066BFHemFZOyWBMW
 v2OyPgXgONr3k2zCsVKVeV3rQWdH2wHVYzJF8QOLpSJyjwNe+/POq9MPBxm5G0CmaZ/a
 /EPS3Q/afyeJTCb9J6tUtzv4xf3LnXO40av8D8CYBBCxNhwAsVeAy6i3Aie8y8xE9HrM
 VVQK8YjIadvN+X6LrO3iAoZu8oIR9XNqY4UwfoNzg0izbc+E5aHKyqlZx07jYt4D70kD
 2Wlg==
X-Gm-Message-State: AOJu0Yy733CvM656C3zkvCsAbB7XTt35He91dlqbcegCpHzllYYxL/cg
 CNEVlgAk0Ao10ahyKda48+e7PjtmRaIej2i8X3ajcA==
X-Google-Smtp-Source: AGHT+IEtEb2+DaZ5+HbJGVSeD6FVE+U8xHmZfkKO62LFFFXJKVXLg/5opNVUC3ObOZ5oaYIi7XrrSVydJbP65h8z0Bk=
X-Received: by 2002:a17:906:eb53:b0:a02:3f1e:59e6 with SMTP id
 mc19-20020a170906eb5300b00a023f1e59e6mr13292321ejb.71.1701280064982; Wed, 29
 Nov 2023 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-3-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-3-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:28 -0700
Message-ID: <CAPnjgZ3F5AFLaAS66s43p1fFdK=PzTmkLd9BEzR1agQuHotjzQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fdt: kaslr seed from RNG device
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

Hi Sean,

On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
> API to read 8-bytes of random bytes.  Performs the FDT fixup using event
> spy.  To enable use CONFIG_KASLR_RNG_SEED
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  boot/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig        |  7 +++++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49d14a949be..12defcf645c 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -12,7 +12,10 @@
>  #include <log.h>
>  #include <mapmem.h>
>  #include <net.h>
> +#include <rng.h>
>  #include <stdio_dev.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <dm/ofnode.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> @@ -650,6 +653,39 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
>         return 0;
>  }
>
> +int fdt_rng_kaslr_seed(void *ctx, struct event *event)
> +{
> +       u8 rand[8] = {0};
> +       struct udevice *dev;
> +       int ret;
> +       oftree tree = event->data.ft_fixup.tree;
> +       ofnode root_node = oftree_root(tree);
> +
> +       ret = uclass_first_device_err(UCLASS_RNG, &dev);
> +       if (ret) {
> +               printf("ERROR: Failed to find RNG device\n");
> +               return ret;
> +       }
> +
> +       ret = dm_rng_read(dev, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: RNG read failed, ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = fdt_fixup_kaslr_seed(root_node, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +#if defined(CONFIG_KASLR_RNG_SEED)

You could put this if() in the function above


> +EVENT_SPY(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
> +#endif
> +
>  int fdt_record_loadable(void *blob, u32 index, const char *name,
>                         uintptr_t load_addr, u32 size, uintptr_t entry_point,
>                         const char *type, const char *os, const char *arch)
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 19649517a39..4f5dfc00d6f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -477,6 +477,13 @@ config VPL_TPM
>           for the low-level TPM interface, but only one TPM is supported at
>           a time by the TPM library.
>
> +config KASLR_RNG_SEED
> +       bool "Use RNG driver for KASLR random seed"
> +       depends on DM_RNG
> +       help
> +         This enables support for using the RNG driver as entropy source for
> +         KASLR seed populated in kernel's device tree.
> +
>  endmenu
>
>  menu "Android Verified Boot"
> --
> 2.42.0
>
