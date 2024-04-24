Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA32C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB3788B96;
	Wed, 24 Apr 2024 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s8YH2zLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B8088E45; Wed, 24 Apr 2024 16:14:05 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBFA8882B
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so8107121a12.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968038; x=1714572838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YY3xISJroA7LiUimw1N7Nd/rLkINOIq23Yll5wHPW8=;
 b=s8YH2zLFdgWFrLAXJM3Q1AfQHoRKXq0z0stifNdZvRQGIxGXrLn2Qr06ViBye+2HFA
 o8SgKJlauYjfuuFiZ/+9J7Hnf4bShrBl4fw0QiaJXsn3wewyusB5bW8pz/JQHTRbMqHY
 v+47QefZbPLezI4XV4Gsi7H8gKr6i6yvJ/QS49oss4Akc+I+n28awnI4nna1SE5NL4J1
 Ygu441CeEXtFqLrdYbpLHvfvvfJ02LM4QsBNM5TRz1NBGl8h01oIDuyZyXP2wvZUfPT4
 ATqM0MrxIl3ZbRLXL7TepHBATPMBEyYHWbNmTRiLYlY++ttK4VTxHzsSuIYp2Q1LYz75
 sGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968038; x=1714572838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YY3xISJroA7LiUimw1N7Nd/rLkINOIq23Yll5wHPW8=;
 b=wObVlftvSx6wFYmnr9bHlAm9RJagrt+Dj7qJOs2Y6OuHZLOHOgV86o6NPCXHnPFp4t
 S6KqywyPlsPgnLTa8LT40qMfM8bEg6Vb56q4IbAQv/m5jsfTSdpKUbRGBISiyApuDqDn
 HVORO7nSUEmD29Gdi1wetoj4LnJ8tdQkIgOD/OsE5jgO1IHUMqJPczKe3BQAW8IWyPWU
 G+PdxI8Tqe4PmI8SKmXO3Yo/DZUEn6hJzwm7DPZ5rppGOh6Rr0UaP6O7HYRjZQbctLdW
 ddVOC4mvNvk67jCOTU3TZqiIa7CcONBA3PhxOeEbxli/mPJxmUWetARP+jfJrF5jY9+X
 RdDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHplHYYjzB7ezYmgb56F/FOOnTVLw7k/jDCJewTgs2LQ2TTuo2F47dPA3ZYgFFL4/3cwhCDfOrMbCk+w5eOR8d+zFX7A==
X-Gm-Message-State: AOJu0YyofZ1JoC/Wqn2O/y0fK99eTHGO5l3MH0i4M0YsFkVOLx/tZoMq
 UAgcKNo4es3VaSN6B1XwOPHoHQqUC/brkSBw4NSwsDCmtoQ8KxzErc+63V40nAo=
X-Google-Smtp-Source: AGHT+IEwjT/JbQK/1y4AQxfsQ7amN/5v4QZCmwVpqyc2rI7nKTOtR2ZFYV/CvJx8shJJRfDfI81h6g==
X-Received: by 2002:a50:a445:0:b0:570:1ea8:c50a with SMTP id
 v5-20020a50a445000000b005701ea8c50amr2023826edb.6.1713968038009; 
 Wed, 24 Apr 2024 07:13:58 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4c3a? ([2a02:8109:aa0d:be00::4c3a])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a0564020f1100b00572334baee7sm500707eda.41.2024.04.24.07.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 07:13:57 -0700 (PDT)
Message-ID: <5d865703-286f-4b62-b8a3-f6c5cf74dc7d@linaro.org>
Date: Wed, 24 Apr 2024 16:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mach-ipq40xx: add CPU specific code
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: j.beck@linefinity.com
References: <20240424111434.373920-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240424111434.373920-1-robert.marko@sartura.hr>
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



On 24/04/2024 13:13, Robert Marko wrote:
> Provide basic DRAM info population from DT, cache setting and the
> board_init stub.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-ipq40xx/Makefile |  7 ++++++
>   arch/arm/mach-ipq40xx/cpu.c    | 44 ++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
>   create mode 100644 arch/arm/mach-ipq40xx/Makefile
>   create mode 100644 arch/arm/mach-ipq40xx/cpu.c
> 
> diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
> new file mode 100644
> index 0000000000..d611de9933
> --- /dev/null
> +++ b/arch/arm/mach-ipq40xx/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024 Sartura Ltd.
> +#
> +# Author: Robert Marko <robert.marko@sartura.hr>
> +
> +obj-y += cpu.o
> diff --git a/arch/arm/mach-ipq40xx/cpu.c b/arch/arm/mach-ipq40xx/cpu.c
> new file mode 100644
> index 0000000000..0446627a8f
> --- /dev/null
> +++ b/arch/arm/mach-ipq40xx/cpu.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * CPU code for Qualcomm IPQ40xx SoC
> + *
> + * Copyright (c) 2024 Sartura Ltd.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + */
> +
> +#include <common.h>
> +#include <cpu_func.h>
> +#include <init.h>
> +
> +int dram_init(void)
> +{
> +	int ret;
> +
> +	ret = fdtdec_setup_memory_banksize();
> +	if (ret)
> +		return ret;
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +/*
> + * Enable/Disable D-cache.
> + * I-cache is already enabled in start.S
> + */
> +void enable_caches(void)
> +{
> +	dcache_enable();
> +}
> +
> +void disable_caches(void)
> +{
> +	dcache_disable();
> +}
> +
> +/*
> + * In case boards need specific init code, they can override this stub.
> + */
> +int __weak board_init(void)
> +{
> +	return 0;
> +}

-- 
// Caleb (they/them)
