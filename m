Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67068C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8A282F65;
	Mon,  7 Apr 2025 20:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQwJqCQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E0182F85; Mon,  7 Apr 2025 20:12:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F03582F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso34066995e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049521; x=1744654321; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CmV4113fIgM3BE6NnmZAbVQWeT9ZbJW7K9Rn9UJfOds=;
 b=fQwJqCQyM8/wLlq8PoICPiYXgh7c1S9F2Nd7IrVAQKHGiyNrys/qUe3ADstKV2cZdt
 G1kBL4g44IXMfhMtwXDdrjGHnD7ZQ3OF7uzdv9P5BjBJyf5j3hoE19pYVVqkZShbMp5K
 wUwc1QXdDRwkMT7J9hnZ8hPuJk2bAa9JGFxZluHt0HrUHpT3HyxV/B1lsXS+3Hx1+1tX
 SuelH+AcQCQjLP9W4hkX59Mn2X6zpNVuqkVH4w7vtkltHySSAvJcWhhZ+QyBB2TJgHtB
 4py4pQNV7ul4KRIxHg6yVCF7pHpA7o9gFyBgQtYfa033PO0uQlRaTqEH1npplUnX1TJD
 nP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049521; x=1744654321;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CmV4113fIgM3BE6NnmZAbVQWeT9ZbJW7K9Rn9UJfOds=;
 b=Lf1nvrYD/gbZYRuZ5D3Z3vjO95e5PrfgJmyLwI08Xo/7FXuC+f6u073ztBHPDiHADu
 EvrygI+QRTLWQCL8ZDdDT4MxP2onR0icaYURfw11D/qTT6EXsqkDuQfU0EtCVuR43J+a
 /lyEyqUmuzU8qYLBdmgSXAb0+DiR9WQI8y2ESh8yBgLi2P8OUHeFbznV36QHk5oEVuNr
 kxwMkh3HIT8dNbjfSz7E814/0v6wE8sXPbVBpOnLArD1h4fAE1nG1sMOpxjy4CZbc7gr
 gS03E4t85edr77zuzJIeDvXKjlRWMvTzz2+blhb0Qkg9nGMk7ysZCBVSCuZ6e6t+qmsm
 FZUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJZPy4Z+jjmXvWrrxQBCCs08wShF6XNPifPH6rOikV7QCZceSk72HyXyAzidcKmdwnaJ2t8p4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBGC3g+bJbJ/iB2Vr60RZMW98Ue7gXY51ZKiqHWFy8pSHjoVde
 XLRsZ/O8MEqBO8rOFlnnc8MqANcgiFUyPD22keQ2SERUEjYgTqzIl7LxizJ6ayo=
X-Gm-Gg: ASbGncvuABYLJwEwfRk8lk8zU0/gwMGhsZG/e9P4JOAQOag2whjynofmw9x6UaNCQIX
 N2XWQXyZ1rMUOwQaGkwWVUAiF66JVZDozneBUWkat8NNPii8E/hQQ72sYQ+wsgn5XN7Y9B9Hq1h
 wiBjBTjmy5tttLKJ661k+cbSX6G4CN0i+Zwt7EIHMTlh5QuFV77wiCOUotE8789oImUvYjpwmYC
 m6xiFCB66DI/nQSstjIhD3wf6weFwQKphum6eWRxxDBcIf5ao3p5yKBa/e2JtcP8RCORIvVg0FR
 wUNwWFh10P4uv0hkVM9JKAW/jIQQVig35Tvg+sWEQI+/ArxAlchTuDqvyd4KV/CxMxJS9gCn/hn
 HtNlOPlwAVRs8t3kmJ/pJwg==
X-Google-Smtp-Source: AGHT+IFl2+fKL8Mo8ZovctXcIiAu1HUEt6xr2wdIiPTsk0NHDsJ8TU9e49sxdBmZa+uRlFvMzDM1Dg==
X-Received: by 2002:a05:600c:3b8b:b0:43d:7588:6699 with SMTP id
 5b1f17b1804b1-43ecf81b778mr121087555e9.7.1744049521441; 
 Mon, 07 Apr 2025 11:12:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bbd9csm136205785e9.20.2025.04.07.11.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:12:00 -0700 (PDT)
Message-ID: <36a928d1-a95d-4183-a67d-bc2e0cbcfe8c@linaro.org>
Date: Mon, 7 Apr 2025 20:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 01/13] mach-snapdragon: Fix EL2 boot on DragonBoard 410c
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-1-524aefbc8bb4@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250407-db410c-fixes-v1-1-524aefbc8bb4@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/04/2025 18:59, Stephan Gerhold wrote:
> The workaround for the "PSCI bug" on DragonBoard 410c implemented in
> arch/arm/mach-snapdragon/include/mach/boot0.h clobbers the x0 register
> by storing the CurrentEL in there. When running in EL1, the mode switch
> sequence implemented there later clears the register again, but this is
> skipped when U-Boot is booted in EL2.
> 
> This causes crashes in the mach-snapdragon board_fdt_blob_setup() later,
> because the invalid address stored in x0 gets dereferenced to check if it
> points to a valid DTB.
> 
> We can't rely on having a valid values in the CPU registers for the first
> stage bootloader configuration on DB410c, and nothing would place a DTB
> there anyway. Skip selecting the SAVE_PREV_BL_FDT_ADDR option for the boot0
> hook case to avoid crashing with the clobbered register value.
> 
> Fixes: 059d526af312 ("mach-snapdragon: generalise board support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 63aefeda9575fec8fc57194358df0819397d088e..af3d39196ee4fb201d4aad20a882bbbb39263396 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1115,7 +1115,7 @@ config ARCH_SNAPDRAGON
>   	select SPMI
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
> -	select SAVE_PREV_BL_FDT_ADDR
> +	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>   	select SYSRESET
>   	select SYSRESET_PSCI
> 

Good catch

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
