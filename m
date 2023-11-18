Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2CDC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 07:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C76786E42;
	Sat, 18 Nov 2023 08:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M6WcRCvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7412E86E81; Sat, 18 Nov 2023 08:34:03 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168B986D9E
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50949b7d7ffso3895498e87.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700292837; x=1700897637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qpTbf71UwG6AjE06fMPrZz+lEps4VRicf05x37iQ46E=;
 b=M6WcRCvzV8u4JZrItwF6heqPf4l2FmiYuJ6IYGnn2THtyOscAd0gAaQd5Kmuxfuvli
 ghs7ZWAWLC/mk20Vxbk3+bju7hZ95d/4+WuxCdCyu9fgkzUpvOjFOAoelcXJTlsrfvbJ
 zBPOpz+EUs7JbsCcK6jONoH1rGZCs6/6rP8kXEMU2SHbflJlH7onzK/lQJU9YGgHrUu2
 WrkRtWKwxqrpgjNom65XejAqy4thM1HV0Z7U1PCBNmNmI3OCeeTKf9KUppSLbM8n3Y7h
 7uQOAbh9pVPk3128Q7ntvprcsjmSprrjpMUl1IFa37L81uo41+RewQbvQFATqYpDY3NW
 wiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700292837; x=1700897637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpTbf71UwG6AjE06fMPrZz+lEps4VRicf05x37iQ46E=;
 b=AKxMIiGpBD6xUtJH16EGFyBP9EfRNTXzcevOZNbZ/2PqFTJ3YrEKtJuYT0xup1LL3d
 gMqGwSg6naXbBLWhKu9aBxyAasrsiCUVAtW9udRTBIHOabXP3c1ZjTbmd/0kDo5Y0W2R
 6EiCDoXmDOTN68x54KL88N8zjVx6qsXQSKaYkwhPEjOlleg5JejS4KQh/3QYXLghsXyQ
 hckXvWQw5gvkrhJMdSmo12aMCylpg+e5QthCWLyBPJculjyBFVNTkPS8+mTmzNHnKUJA
 W7PP7KR4x28KrDyieMZam9Eum2thdPSFhZpjHv7eyPbO+ZbGhE+MalhQ3zvhu+AvrgGj
 EbQg==
X-Gm-Message-State: AOJu0YykPnyYtRB5XmQh982R7S0+vwQ/y1P4ui5lSc1uKdU0cHpTZOPn
 M1afEeDR9EH2JBH/8+Xdg+bwntnXJllGhowmfFE0Ag==
X-Google-Smtp-Source: AGHT+IGAUmfgha4QwBLoABgVqNkqJaoVnE5L9pfd0hg6QM5/nDfGk1hm/WBWf1A4L9e2P4s3BiCMOJsJZJr+aD4KFek=
X-Received: by 2002:a19:7616:0:b0:50a:a2cb:cd72 with SMTP id
 c22-20020a197616000000b0050aa2cbcd72mr1151740lff.68.1700292837162; Fri, 17
 Nov 2023 23:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-3-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-3-seanedmond@linux.microsoft.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:33:21 +0200
Message-ID: <CAC_iWjJf87DM=J0aKUHbOMj8ZhMi=8UtDEEyHRSL3Vv0s+iarQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fdt: kaslr seed from RNG device
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, trini@konsulko.com, 
 sjg@chromium.org
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

Hi Sean
There are a few reviewed-by tags missing since v3/v4.  Any reason you
dropped those? The change log doesn't mention anything

Thanks
/Ilias

On Fri, 17 Nov 2023 at 04:02, <seanedmond@linux.microsoft.com> wrote:
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
