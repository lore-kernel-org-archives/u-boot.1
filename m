Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE98C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AD987F8D;
	Tue, 28 May 2024 10:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cZn7hefS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F7587F31; Tue, 28 May 2024 10:04:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1A987F8D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421124a04d6so3821455e9.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716883480; x=1717488280; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=G4Jd0Mf5Rpg0fX74qYCq1SFuzFA70otscf/0i4j5V9Y=;
 b=cZn7hefSgGDrsaO85ycFE8nHU2RMBcA1ctyc2bRJTaSxRkaRrYBFKAQpZ4mCfMMdYJ
 DA+/NYLPt3LGQDq2eGG0VcRjOrCPlOcr3eWt/DKE3WZb9dq1ScwgZzEGO2uNGB3MPMK9
 HJlBKN1TBCOCxJW7f3rmj4fREXejQYEc++yLsVktcVvqCIZePnpfq+RL+kpvzYMfpy6h
 grdqSI9kD4v7g/EOprZt7du47uGT6/UN6Y2CU+ZVNE5fCE04lwztRl7rQvIZmarjmdt/
 4eJy0V1ddbnxwJlrfMAJ1BFDCXSrTVdVMTyDRxAqB1r8s5215TUSGPL8DJdkAKpwJhLP
 NtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716883480; x=1717488280;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G4Jd0Mf5Rpg0fX74qYCq1SFuzFA70otscf/0i4j5V9Y=;
 b=FZQun5+G6u0w9j53y8IA/Ut2UjvY6g2QCjG1hERA5R7LM0D7gvjTY/nVAaVIZjO3jQ
 NLaJAYDDUpCKV0UYt8q81Dz6Yanx1eLFXSEZuD3olEjj6Q7fK08Ae0NSognx4lQWMKd0
 uGGTbQKP1U4hS3i56Qgv9IOvXIV6ebOhPoQ9wRPcmJXytccmhmo+HbwcbdYCjJOkhYcc
 RTsGAmaBS4Elip1Lw8EggAhq5R3Vgk5aYCl9Eq64maDWfbo/bRTCWEakD/4qZQV1CSz1
 opQWjJqChwug11stFcg+OWdM7+SptANGfUa/k4dEOywMEdCAqZsNOd2L+Rdhhjq9fV+z
 KKnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNxq7eqHM0Ez2vblhBnin0AlDM++wGfN8AX5XrSmWGkDO5vrIxQUrCq3bDq9guWxpfz0zch7TO1C/2tBlPxVRv6IN0Zw==
X-Gm-Message-State: AOJu0YyqWHg+kKJi29GuIufQwvneThkJoHfpUCEO/PfVp4RBHEkQOryH
 liG467QOJSCFah4q07bsGAueh6WHZykLYeUYqGVUUci8o9/Ia88asag8rq3vAKU=
X-Google-Smtp-Source: AGHT+IFBcPB5zcAnu1rhathsemBPOGeRkCWc1ukXghzFb0BJyu7jhe4Si1FPmV6ACimb7Hq116EovQ==
X-Received: by 2002:adf:eac6:0:b0:354:f386:d44 with SMTP id
 ffacd0b85a97d-3552f4fdb02mr8305152f8f.69.1716883480356; 
 Tue, 28 May 2024 01:04:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385?
 ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579f9649esm10876531f8f.29.2024.05.28.01.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 01:04:40 -0700 (PDT)
Message-ID: <31fc866e-6f84-4694-b6fc-d0e6f59e4bec@linaro.org>
Date: Tue, 28 May 2024 10:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 6/8] mach-snapdragon: use SYSRESET_PSCI
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-6-47583d7ad428@linaro.org>
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
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-6-47583d7ad428@linaro.org>
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

On 27/05/2024 19:17, Caleb Connolly wrote:
> Capsule updates depend on SYSRESET, which we currently don't select but
> instead use a custom reset_cpu() implementation which just calls
> psci_reset().
> 
> Clean this up, drop our custom function and require PSCI reset.
> 
> There are some Qualcomm platforms that either can or do run without PSCI
> support, but we didn't handle these properly before anyway.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/Kconfig                 | 2 ++
>   arch/arm/mach-snapdragon/board.c | 5 -----
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 39ad03acd2e4..0d5161358e33 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1084,8 +1084,10 @@ config ARCH_SNAPDRAGON
>   	select OF_CONTROL
>   	select OF_SEPARATE
>   	select SMEM
>   	select SPMI
> +	select SYSRESET
> +	select SYSRESET_PSCI
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
>   	select SAVE_PREV_BL_FDT_ADDR
>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index c4a3394706e6..b0d9a65bb8f5 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -106,13 +106,8 @@ void *board_fdt_blob_setup(int *err)
>   
>   	return (void *)fdt;
>   }
>   
> -void reset_cpu(void)
> -{
> -	psci_system_reset();
> -}
> -
>   /*
>    * Some Qualcomm boards require GPIO configuration when switching USB modes.
>    * Support setting this configuration via pinctrl state.
>    */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
