Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CE7C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6760882ADA;
	Wed,  2 Jul 2025 12:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ioD0yO+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB68782E08; Wed,  2 Jul 2025 12:18:49 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B9182103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e3c6b88dbso49417287b3.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751451526; x=1752056326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsCGe3H6/dK15VTT+vsDAcwSVxy0fHR5zOoDrb6Bq68=;
 b=ioD0yO+Zgwky91r0osP6Sty9ivvcltxIvrR4La2UvSmSLDdrBPMrfH/wJgBZFaoxHM
 auUDSjURTbnRu1H7i7B4R71trnLYlZGDqtW80LmwOBnfZgmP+MVQixlDdWzLMgvMAOWE
 N2L+85ogtLkt6z5nfiWAo6CsBd9GSUv8LoMPFNJDaHa9c4VoRQ/+Su6NZdYRBvi1qLHM
 tZfeSkZrU0wvrtgVh4Lm6tG5BjH6saPXEIEVNwFZ0MYwMbu3gVTU3ZD2ErEA26MOZNfE
 V+dhNC1UG4SIQw2xI6x8mKNZOajLisJCOEEv0rdld+Vo8PgSBzEk1N/INEXXLTWvtEHV
 YXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751451526; x=1752056326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsCGe3H6/dK15VTT+vsDAcwSVxy0fHR5zOoDrb6Bq68=;
 b=tCiDY0RogjToSMu85Ewmkc8uB+OkuOGW3DydPzfSpKWlflMS0i035KGCOy73r5rN9z
 NF9CK+amkLtEFo1m+Idsq1WBetuucD+X30i/NJx0Wi6LjB7nrCLSEcoURXN4FQUz1pwp
 nxanQVzZV1rLjpH6NfZ4+VDB5dA4gZ4y9q2YoNa7hhj9qj5LJPmnkFeh2V2V8AxcviOh
 ihNfBgoNGHWxCSCKrekGp3fT6ecCj46y8E78a8Cd7EZKUxTIOAMBclujA2gcOpbUyq+1
 kTZ4NZ23PvTOFGXjx6NU+fFA7gV4ATFH72058Jl547dc5f5B3siWBehuWqnAJ+mk/dTf
 +bZQ==
X-Gm-Message-State: AOJu0YzDYGtz0FM54zaVxElcI3Jr4p/3ykG8RmJjqBDHJuwc6+xIK4AT
 jwIm05eBn1hgxQmLpHAK/u8klo0gC5S0v85N1I70ziM16bwUr+jaWNmagOEM6fZNC1SWFnxTobn
 YDFwraF9bBn9iOK+RWp8IU671C5N1vZUCU04B66+Ecw==
X-Gm-Gg: ASbGncs3xw/ZBAhUOq6b6PGkElhMlA/kqEn7N1sxNclX483auFKrgJRRXCeHgDhbvSg
 DgSEoyYJI30hvi4bM0UHF8chscL5QslI7FWEsNPFwapHsaKHSjep10l7RUdbU4rpidJdMQ2zO2N
 CSlnRtGUUb1rudWeDHj/6Y1lei6Uu8ypSg2V00ht29dcHZM73O5YTtxRw=
X-Google-Smtp-Source: AGHT+IGaKNCDzlakmgnXSSpvWF/SP507/CmvdNw+Of1GhDqNA420R0Qkpb4D9JeKtVyL9izNDP2xPmFvE5kzIrYtQq0=
X-Received: by 2002:a05:690c:7487:b0:712:d70b:45eb with SMTP id
 00721157ae682-7164d539984mr28597927b3.31.1751451526404; Wed, 02 Jul 2025
 03:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <0e55eb3eade94e9cd0ffe04da0618aa6b1589f01.1751442246.git.michal.simek@amd.com>
In-Reply-To: <0e55eb3eade94e9cd0ffe04da0618aa6b1589f01.1751442246.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 13:18:10 +0300
X-Gm-Features: Ac12FXzQuZaKna5IGXUoDtgefUAjF-jll1lnWoaVHcYJ1NLHkI8wceIEaVK2Gio
Message-ID: <CAC_iWjL+nWRhQFMtns6BxODzJ-tfy9tn7Qs6fTTGW=gPsKsULg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: zynqmp: Enable rng-seed generation
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Anshul Dalal <anshuld@ti.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Wed, 2 Jul 2025 at 10:44, Michal Simek <michal.simek@amd.com> wrote:
>
> SOM has TPM with RNG in it that's why enable rng-seed generation.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v3:
> - Move malloc allocation before rng_read
>
> Changes in v2:
> - Free alloc area in case of error
>
>  board/xilinx/common/board.c          | 33 +++++++++++++++++++++++++++-
>  configs/xilinx_zynqmp_kria_defconfig |  1 +
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe74299016..ceb58da6d3cd 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2014 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@amd.com>
>   */
> @@ -712,3 +712,34 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  }
>
>  #endif
> +
> +#if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
> +/* Use hardware rng to seed Linux random. */
> +__weak int board_rng_seed(struct abuf *buf)
> +{
> +       struct udevice *dev;
> +       ulong len = 64;
> +       u64 *data;
> +
> +       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +               printf("No RNG device\n");
> +               return -ENODEV;
> +       }
> +
> +       data = malloc(len);
> +       if (!data) {
> +               printf("Out of memory\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (dm_rng_read(dev, data, len)) {
> +               printf("Reading RNG failed\n");
> +               free(data);
> +               return -EIO;
> +       }
> +
> +       abuf_init_set(buf, data, len);
> +
> +       return 0;
> +}
> +#endif
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 22ba8a7cc158..3e2ac6144050 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -46,6 +46,7 @@ CONFIG_USE_PREBOOT=y
>  CONFIG_SYS_PBSIZE=2073
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_CLOCKS=y
> +CONFIG_BOARD_RNG_SEED=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  # CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> --
> 2.43.0
>
> base-commit: 506757335edcf5e74eac0e608f1835a8b0102c4b
> branch: debian-sent3
