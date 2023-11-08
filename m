Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF8C4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1C28716E;
	Wed,  8 Nov 2023 17:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Weue31oL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F0E387450; Wed,  8 Nov 2023 17:14:59 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C5818716E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-778a20df8c3so486914585a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699460096; x=1700064896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKrRHGvKcwrQVtclaPPUaazBwIQAAIUb1r9JOu+bkOE=;
 b=Weue31oL702k9tIhZqoIS+8Bzq2Gk94vVlASbqVUR65i5mcAQ9oM8phhVpPavwEF/9
 BaEbpeDLsnnscPWoKCOqhlCfFP6dR/eCJ1z7US4mG6wPgfykjZ8VEVOA3ed3tOgXKtq5
 ggyhyavxLKsu1wNEBKeJxW5NLU/We7wW0nolEA1YtCNY1qGfU6qKZwLTBAbLdc5ttlml
 UpS5aQqXMgld/DKwoAGpkp/RmRZijgz+omVSiorlLKzV8WvsTR/WuxuuG4GOsLo1yH9x
 zm214cocL7O9+EQ31q3tNn4Bv2pTsUESPkO7s7+kaQZYsFDMpYpw3OrlD57Khv3Of36R
 Sr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460096; x=1700064896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKrRHGvKcwrQVtclaPPUaazBwIQAAIUb1r9JOu+bkOE=;
 b=KyjV9ffAWq4q5wwzcIE8MDHEhNqjvhJgFxB7lUjHZ/SIruHrCxpIMdgqK4jL0Aw8eU
 ds05MmWhJ1qD9J5vNxClfZ8eyoVvoiMbdewQkeLl7KmyCp5D/e53HP5pW8H63+WQAnE2
 I2J6qHYLblz9L+Zi/dq2OlgZ62q1M6D56R4RnN6SSzJdTfnEIfgiu92/MuR8jqu3Aibv
 l0t/hS4cw7BgPpwOpBwlSuGXii1tAIQ3bxZDgUFjIJaNYfJ4tRSjIe8BpNZYIggzr+RW
 jkmz8r6CC12tNtW4QESa8dM2hADvtgqUbehhwCCRkYyo0xtBRf0Nvp1GJRFQEkYf6Js+
 8F3g==
X-Gm-Message-State: AOJu0Ywu2upwEeNB26ZVXldV4J8y9RxWpp2B6AGCMqB6jlKkhK3AFwH6
 etrkr2yv+CLZHedqr7s3pwE=
X-Google-Smtp-Source: AGHT+IHXHuS8ZkDy8bQR6DhvIe97O5nBw2UMi6ytBdTBYOPhRNA8i8TNjcUKNWb6bc3DPdr+6B9DDw==
X-Received: by 2002:a05:6214:2a8f:b0:66d:15c3:62ca with SMTP id
 jr15-20020a0562142a8f00b0066d15c362camr2424614qvb.24.1699460095746; 
 Wed, 08 Nov 2023 08:14:55 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 kh2-20020a056214514200b00670c15033aesm1196016qvb.144.2023.11.08.08.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:14:55 -0800 (PST)
Message-ID: <a84f5367-237e-7599-42f0-bfb3e99f9f63@gmail.com>
Date: Wed, 8 Nov 2023 11:14:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: exynos: Add header guard for clk-pll.h
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Thomas Abraham <thomas.ab@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
References: <20231107212200.1457-1-semen.protsenko@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231107212200.1457-1-semen.protsenko@linaro.org>
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

On 11/7/23 16:22, Sam Protsenko wrote:
> The clk-pll.h is going to be included in multiple files soon. Add
> missing header guard to prevent possible build errors in future.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 166097e87753 ("clk: exynos: add clock driver for Exynos7420 Soc")
> ---
>   drivers/clk/exynos/clk-pll.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
> index c79aac44258b..7b7af5e67612 100644
> --- a/drivers/clk/exynos/clk-pll.h
> +++ b/drivers/clk/exynos/clk-pll.h
> @@ -5,4 +5,9 @@
>    * Thomas Abraham <thomas.ab@samsung.com>
>    */
>   
> +#ifndef __EXYNOS_CLK_PLL_H
> +#define __EXYNOS_CLK_PLL_H
> +
>   unsigned long pll145x_get_rate(unsigned int *con1, unsigned long fin_freq);
> +
> +#endif /* __EXYNOS_CLK_PLL_H */

Reviewed-by: Sean Anderson <seanga2@gmail.com>
