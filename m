Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6ABCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 872E487F70;
	Thu, 11 Apr 2024 05:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TPlspEKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C04988140; Thu, 11 Apr 2024 05:16:24 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41182881B7
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-69b10ead8f5so23996866d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805380; x=1713410180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ai7L3lDbdvP1AH0FxXvLGNUR/2Li257RF1T6Dw0nXJs=;
 b=TPlspEKLbMu8dhcYlFFZgQuzIOZV97JkGZ/7+bPenWfNk0KQ9h8AUpzrmH2jHVakaC
 vy5EVSl6T1aqZmTf0PDKl2Wr2ykV3UkWRqSpuej0AGEx5wfW5vmmeT6+AQo4Si3GUpU/
 7TxlrxvRAxT+QDyX2xrwq5CdUsqgaRnwobOz36r0m+SpVz7m4Uc2oo9GCJIi6Dm2uG7r
 C6zwyR9tijWU2VqoQAcnaVarj0kGYeqK+QbvrYaJcyddu5/84r+wrfA8y7wK9gb6Em5t
 ZuuFQMZRcgzQrxoQsB/1quxw4/T+63A9+gre7Lq+AF0lumBX4rd06GfErI7cDqVXdNs6
 D8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805380; x=1713410180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ai7L3lDbdvP1AH0FxXvLGNUR/2Li257RF1T6Dw0nXJs=;
 b=M76/JwZ2rQ2EWytGkSN58/v6+mlO5l02k9QURl/io0fPHy1vtUSf6fmSe7G9gPNCL4
 9eNl4Smabah0T8aGGF8pC4YvoQogiHpYj7et5ycPZYXnsSGBymLx3vJQFCk3lefu0WnB
 QIR42hxy7lpXUL7YNFqE3ZR9Tnc+ZzflhfxQnod2t5VUZK1YamYr9POQAWo9DypbQ2CY
 vBjv83xtQSg9UwRdv+YMF49bV0/IYpwGMRUgLxxfJwW9kj/v+H1N5ZMih6AlFCkkR5Mx
 KWf4yhNKCOqtV4xS8JM+/HmEc9NSw9hcgZfoCAQuDQ8EsAOApCghPUKRyKgp1/TMtXtI
 Oz6g==
X-Gm-Message-State: AOJu0Yz7MeNBoH8nE5m0rUZM7vDgfGJ5Qk4cu3HJm7WVrn1u9e7uDeas
 ISIKqnwvPtHvJirOQIweinOtdAeIrBVzyxRv9jT3XTTuWwI+SgJw4RKIvw==
X-Google-Smtp-Source: AGHT+IEUcBVvVUyYw2lfcOsk3vdwbSg+pxb+fQkd2G5yM1qJFlFP45RhL1GxwO72IF76M7dyQ+YIVQ==
X-Received: by 2002:a05:6214:1bc5:b0:69b:213e:a6d1 with SMTP id
 m5-20020a0562141bc500b0069b213ea6d1mr4778497qvc.21.1712805379916; 
 Wed, 10 Apr 2024 20:16:19 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 h18-20020a0ceed2000000b006991de7276asm371718qvs.94.2024.04.10.20.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:16:19 -0700 (PDT)
Message-ID: <ea965f53-7848-17af-d591-59a9ed54a5ad@gmail.com>
Date: Wed, 10 Apr 2024 23:16:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] clk: sifive: avoid declaring static variables in
 includes
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20240216231804.141470-1-heinrich.schuchardt@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240216231804.141470-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/16/24 18:18, Heinrich Schuchardt wrote:
> The existing code is unnecessarily convoluted:
> 
> Arrays __prci_init_clocks_fu[5|7]40  are initialized with data.
> In separate includes fu[5|7]40-prci.h the size of the arrays is provided as
> constants.
> 
> By moving the structures prci_clk_fu[5|7]40 to the respective code modules
> we can directly use ARRAY_SIZE() to access the size of the data used for
> initialization.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/clk/sifive/fu540-prci.c  |  7 ++++++-
>   drivers/clk/sifive/fu540-prci.h  | 22 ----------------------
>   drivers/clk/sifive/fu740-prci.c  |  7 ++++++-
>   drivers/clk/sifive/fu740-prci.h  | 22 ----------------------
>   drivers/clk/sifive/sifive-prci.c |  3 +--
>   drivers/clk/sifive/sifive-prci.h |  4 ++++
>   6 files changed, 17 insertions(+), 48 deletions(-)
>   delete mode 100644 drivers/clk/sifive/fu540-prci.h
>   delete mode 100644 drivers/clk/sifive/fu740-prci.h
> 
> diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
> index ceb2c6fab0d..e55a26ab8fd 100644
> --- a/drivers/clk/sifive/fu540-prci.c
> +++ b/drivers/clk/sifive/fu540-prci.c
> @@ -58,7 +58,7 @@ static const struct __prci_clock_ops sifive_fu540_prci_tlclksel_clk_ops = {
>   };
>   
>   /* List of clock controls provided by the PRCI */
> -struct __prci_clock __prci_init_clocks_fu540[] = {
> +static struct __prci_clock __prci_init_clocks_fu540[] = {
>   	[PRCI_CLK_COREPLL] = {
>   		.name = "corepll",
>   		.parent_name = "hfclk",
> @@ -83,3 +83,8 @@ struct __prci_clock __prci_init_clocks_fu540[] = {
>   		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
>   	},
>   };
> +
> +const struct prci_clk_desc prci_clk_fu540 = {
> +	.clks = __prci_init_clocks_fu540,
> +	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
> +};
> diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
> deleted file mode 100644
> index 113301107da..00000000000
> --- a/drivers/clk/sifive/fu540-prci.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2020-2021 SiFive, Inc.
> - * Zong Li
> - * Pragnesh Patel
> - */
> -
> -#ifndef __SIFIVE_CLK_FU540_PRCI_H
> -#define __SIFIVE_CLK_FU540_PRCI_H
> -
> -#include "sifive-prci.h"
> -
> -#define NUM_CLOCK_FU540	4
> -
> -extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
> -
> -static const struct prci_clk_desc prci_clk_fu540 = {
> -	.clks = __prci_init_clocks_fu540,
> -	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
> -};
> -
> -#endif /* __SIFIVE_CLK_FU540_PRCI_H */
> diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
> index 5edc864e4bd..4274b215d2f 100644
> --- a/drivers/clk/sifive/fu740-prci.c
> +++ b/drivers/clk/sifive/fu740-prci.c
> @@ -102,7 +102,7 @@ static const struct __prci_clock_ops sifive_fu740_prci_pcieaux_clk_ops = {
>   };
>   
>   /* List of clock controls provided by the PRCI */
> -struct __prci_clock __prci_init_clocks_fu740[] = {
> +static struct __prci_clock __prci_init_clocks_fu740[] = {
>   	[FU740_PRCI_CLK_COREPLL] = {
>   		.name = "corepll",
>   		.parent_name = "hfclk",
> @@ -156,3 +156,8 @@ struct __prci_clock __prci_init_clocks_fu740[] = {
>   		.pwd = &__prci_pcieaux_data,
>   	}
>   };
> +
> +const struct prci_clk_desc prci_clk_fu740 = {
> +	.clks = __prci_init_clocks_fu740,
> +	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
> +};
> diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
> deleted file mode 100644
> index b74f0789061..00000000000
> --- a/drivers/clk/sifive/fu740-prci.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2020-2021 SiFive, Inc.
> - * Zong Li
> - * Pragnesh Patel
> - */
> -
> -#ifndef __SIFIVE_CLK_FU740_PRCI_H
> -#define __SIFIVE_CLK_FU740_PRCI_H
> -
> -#include "sifive-prci.h"
> -
> -#define NUM_CLOCK_FU740		9
> -
> -extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
> -
> -static const struct prci_clk_desc prci_clk_fu740 = {
> -	.clks = __prci_init_clocks_fu740,
> -	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
> -};
> -
> -#endif /* __SIFIVE_CLK_FU740_PRCI_H */
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index c8fb6002907..603a176d06a 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -34,8 +34,7 @@
>   #include <linux/math64.h>
>   #include <dt-bindings/clock/sifive-fu740-prci.h>
>   
> -#include "fu540-prci.h"
> -#include "fu740-prci.h"
> +#include "sifive-prci.h"
>   
>   /*
>    * Private functions
> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
> index 5ce33d61846..b391698081d 100644
> --- a/drivers/clk/sifive/sifive-prci.h
> +++ b/drivers/clk/sifive/sifive-prci.h
> @@ -320,4 +320,8 @@ unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct __prci_clock *pc,
>   
>   int sifive_prci_clock_enable(struct __prci_clock *pc, bool enable);
>   
> +/* Clock driver data */
> +extern const struct prci_clk_desc prci_clk_fu540;
> +extern const struct prci_clk_desc prci_clk_fu740;
> +
>   #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */

How does this affect SPL size?

--Sean
