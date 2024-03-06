Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCF6C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 11:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA45E87C92;
	Wed,  6 Mar 2024 12:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SSw78suC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C0687D25; Wed,  6 Mar 2024 12:29:09 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69224879CC
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 12:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51321e71673so805569e87.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 03:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709724545; x=1710329345; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppr+8uVV9c7zvfHNmBNQ7rq8crnMGCjRSrbjbV6/IPM=;
 b=SSw78suCVJVt3MZWqiM5YnhG/D5wCCx8JwVrgU92sEO/SRdmCu4eFY/nlA7U/HPd+r
 p6jXNNdxoRczbN1RR2aYv1ACCKUKsnKmswImZZfV+5uElv1Q4G1+NWkTEBJmwzJLm8wI
 SC0G2bzmf1GnhQyVusrrLcVWe/ScVZDXl1klSwzfQCEjOEjIAKbnXELhxHpcg1YbOjQS
 s2U9rZ2d6mqfMMxMVzxoHrAkTbgnQIrnzyzawtpa2slSQ4JEwJhBprNmQUyoIzfLat5P
 Nd4HGHQuyWeDN+XcBUOKRbvihUrP3YdxD2SVPaI+Fr+pnGlOBGoZcgbGu+PnyczwGFmN
 I5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709724545; x=1710329345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppr+8uVV9c7zvfHNmBNQ7rq8crnMGCjRSrbjbV6/IPM=;
 b=wrQ0WSjyrMZwimHBwTzQUakjVFbfJZJiQI8Wgb7k6jBradCQu7Xw+N1TCkAlUWvPro
 eZDhqYjnUcz41HiPA7lGKclfuhyaF9SjXNcqbw2y6cgxjNby6nxI1qN+UFjqSYrRXz+t
 6WC20J2bRUmxft4KoESxk+ZFqbe7yov0aNXPKlQUUEp7Alb6oLkuhgpuf5K6CK0aAFFe
 DhxEar73fmaBq0rf+uDYiDIFuLs+RCBUv5THRPqvEo+7fYyRMOF5TFeVH4h99SwHFVO2
 GdsGK9XDPOugQYfXciDbV98yr55Ya/z7sKq/6yrtYAeHDFK4YQ0AtjFdg4axWU/Yq0yp
 /z4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnBjYTO+fRSlkmHkdO3h3U3SiojP8nn8mfjLaiT10iGAP4OCh8paACVMvS+QOr8wwe/0skuKQRpLjOo84vhtq4W1BqGw==
X-Gm-Message-State: AOJu0YzwyfwB22+JNIpN4bqi8OZzIZ+S0gAGOD1ftJprsSo80VwKkqNS
 RgsyArcWL8bfwGEymKRyRIwxjRNXW4qdhgQUJNG/3eYvYdvn74vycXztL8PFmxQ=
X-Google-Smtp-Source: AGHT+IEbQC3fuOBarQBuFAqGUH8UE9xVOzN0JSDV+6sR05N0ODXyyPY6b77rffvIt2sf5hRlHYu1wg==
X-Received: by 2002:a05:6512:3106:b0:513:3106:ac63 with SMTP id
 n6-20020a056512310600b005133106ac63mr2790907lfb.17.1709724545183; 
 Wed, 06 Mar 2024 03:29:05 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 q29-20020ac2515d000000b005131c5285f8sm2561303lfd.107.2024.03.06.03.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 03:29:04 -0800 (PST)
Message-ID: <6221c929-8d67-4874-a6c7-10056dca9310@linaro.org>
Date: Wed, 6 Mar 2024 11:29:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] qcom: board: validate fdt before trying to use it
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-2-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240306005230.2638972-2-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
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



On 06/03/2024 00:52, Volodymyr Babchuk wrote:
> There are cases when previous bootloader stage leaves some seemingly
> valid value in r0, which in fact does not point to valid FDT
> blob. This behavior was encountered when trying to boot U-Boot as
> "hyp" loader on SA8155P-ADP.
> 
> To be sure that we really got the pointer to a device tree we need to
> validate it with fdt_valid() function.

Thanks for this!
> 
> Note: This approach is not 100% fool-proof, as get_prev_bl_fdt_addr()
> theoretically can return a pointer to a region that is not physically
> mapped and we will get data abort exception when "fdt_valid" will try
> to access it. But at this early boot stage we don't know where RAM is
> anyways so there is little we can do.

IME this hasn't been an issue in practise, but yes it is a risk.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
> Changes in v2:
>  - New patch in v2
> 
>  arch/arm/mach-snapdragon/board.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f12f5791a1..10eec47ada 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -24,6 +24,7 @@
>  #include <linux/sizes.h>
>  #include <lmb.h>
>  #include <malloc.h>
> +#include <fdt_support.h>
>  #include <usb.h>
>  #include <sort.h>
>  
> @@ -93,7 +94,9 @@ void *board_fdt_blob_setup(int *err)
>  	 * try and use the FDT built into U-Boot if there is one...
>  	 * This avoids having a hard dependency on the previous stage bootloader
>  	 */
> -	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K))) {
> +
> +	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K) ||
> +					       !fdt_valid((void *)&fdt))) {
Please use fdt_check_header() here, fdt_valid() prints a bunch of stuff
using printf() which isn't really useful here.
>  		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
>  		return (void *)gd->fdt_blob;
>  	}

-- 
// Caleb (they/them)
