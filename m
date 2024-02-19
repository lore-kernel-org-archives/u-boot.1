Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C00DC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC9F87E6A;
	Mon, 19 Feb 2024 10:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B3X3s79K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE8187E80; Mon, 19 Feb 2024 10:51:38 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA3187F35
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412641511beso6262845e9.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336267; x=1708941067; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ls6gDrvYeuRKAxILTXUSEhSCzlHSJ418gqZ7E9Zr35Q=;
 b=B3X3s79K94sD1LcTQMYWaTut0Iy6LsPAhrHBpU1iLkXMr01yHzwlMvCnS/lKb+lrXR
 XG5smfG14zNaoAT54oDg2rmVehkvoOo5mt/w6wkxhx8pVOcPtmA/SBUWeQ3kpnRfvKqh
 TGMFGBYPTJJLqduQpYJTUAdaXqsKbN5H1p3XyU9rskHQ2AHyhWrSpahHwKwPx8EOZcuV
 DkcYYAaZvjx4feVmj0fXUlAwq7VCLiFFk/p9FyyMmJzEU0fd+nnNACTLpdZzbVb/7vj9
 9fHfCfJ/vMxoI62DBiWQYhCeL7CSMOUAvocOYBORgHm+evc1Oi4WjrKo2ss68ZUA/eKA
 hrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336267; x=1708941067;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ls6gDrvYeuRKAxILTXUSEhSCzlHSJ418gqZ7E9Zr35Q=;
 b=ScOymXxW1Bk5KzJnemGWigygkO3P+pxDTBtydbGwfIzB2FAEiulQxaK0maOlpZxgYG
 71iaVEjq8Twz9BTw9B13YFm4kZ3E1vkavscCPpPWI91r6tQXciCvC3Il32ystKTwFmYV
 JYSn/sJDaOBXTMyC+76E0/4z3wQuk/ffDv9RpzDOGYWafrX9ULMerAXaVME8TXul1/C0
 +ox5YDx+zx3tYSgD8/ibeXxGeAefCqZFVPQiGTK8Q3Hh92luuuhasg/3eOJ4nqhNz1wF
 /AIwkocWv0DlfhXYLPOXYL0N9B6rxx0p3D0z78CH4K/Lp77HoBpKUx+Faw/9IQbE5bvg
 o6WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPmNyNGnJXgreA8PNEFrxYL+N8M7u93VrMcU5JyQpamw6b9nk2dzEq1zjlbrZ8+ITrQIGwlTtT+/mOFfvTOF6HTNELg==
X-Gm-Message-State: AOJu0YzYs2OAp2Q/hYImIM+bQuoIkv8v1WaE/1minBANTdnvJosPJUKB
 2Pwtdha55uxYtK75B1oaSnxKza5rbhXCXja2qWaTaISZjvo8tekLG8jzGu9lrW8=
X-Google-Smtp-Source: AGHT+IFe4l2USV78u0y85LSSvWWGXh2PL/hHBgsH5GShLCTfagaHnZYWAastSEXS9lR7uwE9MHOtFw==
X-Received: by 2002:a05:600c:4446:b0:412:6807:93ab with SMTP id
 v6-20020a05600c444600b00412680793abmr802921wmn.5.1708336267097; 
 Mon, 19 Feb 2024 01:51:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:51:06 -0800 (PST)
Message-ID: <0aa43f22-f38c-4493-959e-babdd305f20c@linaro.org>
Date: Mon, 19 Feb 2024 10:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 21/39] mach-snapdragon: dynamic load addresses
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-21-ed06355c634a@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240215-b4-qcom-common-target-v4-21-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> Heavily inspired by Apple board code. Use the LMB allocator to configure
> load addresses at runtime, and implement a lookup table for selecting a
> devicetree.
> 
> As some Qualcomm RBx boards have different RAM capacities and base
> addresses, it isn't possible to hardcode these regions.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/Kconfig                                 |  1 +
>   arch/arm/mach-snapdragon/board.c                 | 34 ++++++++++++++++++++++++
>   board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
>   3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 672577d0ddcc..0dba77f86b49 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1095,6 +1095,7 @@ config ARCH_SNAPDRAGON
>   	select OF_SEPARATE
>   	select SMEM
>   	select SPMI
> +	select BOARD_LATE_INIT
>   	select OF_BOARD
>   	select SAVE_PREV_BL_FDT_ADDR
>   	select LINUX_KERNEL_IMAGE_HEADER
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index a1867852bcca..f445bed3af00 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -22,6 +22,7 @@
>   #include <linux/bug.h>
>   #include <linux/psci.h>
>   #include <linux/sizes.h>
> +#include <lmb.h>
>   #include <malloc.h>
>   #include <usb.h>
>   
> @@ -159,6 +160,39 @@ int board_init(void)
>   	return 0;
>   }
>   
> +void __weak qcom_late_init(void)
> +{
> +}
> +
> +#define KERNEL_COMP_SIZE	SZ_64M
> +
> +#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
> +
> +/* Stolen from arch/arm/mach-apple/board.c */
> +int board_late_init(void)
> +{
> +	struct lmb lmb;
> +	u32 status = 0;
> +
> +	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
> +	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
> +	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
> +	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
> +	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> +	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
> +	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
> +	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
> +
> +	if (status)
> +		log_warning("%s: Failed to set run time variables\n", __func__);
> +
> +	qcom_late_init();
> +
> +	return 0;
> +}
> +
>   static void build_mem_map(void)
>   {
>   	int i;
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 0136cc2237de..fbbfc0e65e24 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -88,7 +88,7 @@ int misc_init_r(void)
>   	return 0;
>   }
>   
> -int board_late_init(void)
> +int qcom_late_init(void)
>   {
>   	char serial[16];
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
