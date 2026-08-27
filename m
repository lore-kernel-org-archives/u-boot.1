Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08371C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9706407F7;
	Thu, 27 Aug 2026 15:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id soKakG-3JldK; Thu, 27 Aug 2026 15:37:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845021;
	bh=XgmBYgNTHV2qD/YA7OW3WVfArDuUrCr7tLp8EXmTfdc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zLOk4FG+IQj5pZPYTiq45DX3Od/Wbef1M7u3Q0mMDH/0kuaRKDpe5vpahD5pKyc1o
	 IWvQwAb2Y99Koti5Y4WwAEMtRy7COD7CsT4FiWNFEUJa5inLPoChiWNY1q/gJQ3DQd
	 jq8/8DxtaF0rpg5ZWM+7mQacay8d2sXOfBb1NzOArviw9/yfYpGSE72Zff64i5JbAO
	 9Rg0GARCp9lZwumAioTNlBygasGismp9hgnd6zBuPjXASwLErB4ZYiRsh6/BP5fgix
	 ObiUp/R4hmABMYXsVDSq3BuFa8Awoh9iBP3JBdxTelx2LlAqCjJeoz5+UF3pSwer2y
	 qhPYTZtsh8q8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D97ED407E7;
	Thu, 27 Aug 2026 15:37:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 938383A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 790484032E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VDoLJQrbjxu for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:36:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Wxx1me85
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DAC74002B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:36:57 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so523667f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845016; x=1788449816;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XgmBYgNTHV2qD/YA7OW3WVfArDuUrCr7tLp8EXmTfdc=;
 b=Wxx1me85rTbX7EC3wsZd1NmxV9VmVEpZtFU1YdkYThUHwtDwp5SVW2sSxrALptYM14
 T3+eitaLFwmaemgNTjWSRLh76x+wG6TWPpYJIwmsxiyVjKZBEyOmFA8yXj/frKhVvbqP
 S3Du8XBm6tX4/9IZAe3uslDRMlPjud4f1hdUnbDacT6oLQpTjADuuiEHNWtTwoRsXdEZ
 ynGxsfb1SrejUI1/Yj49ILB/BqkcM0ZvW2eu1tI1YNgbovenJNwnUz5j0W21gpIozySq
 8XDnh5UU8DwVKUxaqq27SYUuC61YDjCU1X1V2EOUy1mh2WG99yg8cwyoubQVgZBD7k2g
 XqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845016; x=1788449816;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XgmBYgNTHV2qD/YA7OW3WVfArDuUrCr7tLp8EXmTfdc=;
 b=OINeFJQw77m6sVafTV7d9DB3QVFuN45go8fsMf9lbOdKe9behSCS3y5BVlQvHDuTgq
 exKC4Qbzk24QvvuAAc9KyILvdbZnPBC5F7mMLys6Lr094gfzTcY076/dHVS3UWjqJnOy
 vRslT4GbhUNdhHYXAOoeWvAK2scRTYzC5Wk+lPfnefYNqGR2ldpkgUnkOK5jcG6R5Ce3
 h06KMg5bz+G+R6vJZjJQXwcAWawqa1gc/bWsos6ugHSxBnHbfokZWd9vBqYhtK1yQ+B1
 B3un6QRw3kPpUk2HsKxOj6m+gjyskVWBKwtOT2w2Jc/G5jv7owEuEmgbkUVeT1Dow1uv
 991A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOSsaXNmx18b0ls5uLoyql57Ks8HIZyCgmJDidyYB+t83/RJSCgyPugx888KVAnyONdjHriy8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++musCqouJ3S5gHo8ujrxnedIrZlnZKEhjpSVbdOEIqGqnWdYP5X
 VCgZieDLFCooZCa7xs5JzB2xYFSN2ydR8uvv19CKt3I5fEAgZAIQ0zdFOqD8vguLZ2c=
X-Gm-Gg: AR+sD1069uPR3/rtB6s4oQlpsolxHVVMk4klATDVFseckoCRKlYN8F20EFi6uGOQAD+
 BiLlvIi/PQJjPdE+jKnTrkpOE3S5vlK2NFPcCVycH81EUF4q9Lcf7Ygq8Nx3GjLxyseLexXTpte
 90dV6+Licflv3m27PE+T72tn2WpL+PN3d6yqdpQJGEsdz0+F/bcTT0iA0BHgrGPw+LfuDDjQjWG
 mQU9mLS/CGKhcLkBRlbeIttocq+CjSqHKX3gyZzGgGtTT0fYhEP7eM8q2ys+BafpmIrYTlISHuK
 kVXCPjfFmolfjykdL2SQ1M/CYIWR5zhETmW/YVBpsq7DaKRUIFAG4ZAQR8Da47U9rINahuQVJkV
 KTLRpq3uT8lkUlg1hhI2mctJrTupeBb8myPyqdC7HAmuhtS8PZBXPAJW+9DngJzJkjz6POdjAyL
 0isGQaY25dcDsSVABSmCNKaB3cU4f/98sMWyS7zH7zP98n81cSk7EhrZEyVFXU3n2pNqcAFv5kk
 7MWINHtByNYfJzuP41QPNjD7M8J5GXijKTZNa/cSQ9T4g==
X-Received: by 2002:adf:e009:0:20b0:47f:eb22:4d9a with SMTP id
 ffacd0b85a97d-482e26e47ddmr17032012f8f.22.1787845015450; 
 Thu, 27 Aug 2026 08:36:55 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab569sm9658077f8f.16.2026.08.27.08.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:36:55 -0700 (PDT)
Message-ID: <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Date: Thu, 27 Aug 2026 17:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/9] arm64: meson: Add s4 SoC support
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-2-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-2-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/17/26 19:15, Sean Anderson wrote:
> Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
> similar to other recent SoCs, with the exception of a workaround for
> some BL2 (mis)behavior.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
>   arch/arm/mach-meson/Kconfig             |  7 ++++
>   arch/arm/mach-meson/Makefile            |  1 +
>   arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
>   4 files changed, 72 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>   create mode 100644 arch/arm/mach-meson/board-s4.c
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
> new file mode 100644
> index 00000000000..7338171be15
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-meson/boot0.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2026 Brivo Systems LLC
> + */
> +b reset
> +#if IS_ENABLED(CONFIG_MESON_S4)
> +/*
> + * BL2 copies some keys to the start of DRAM, clobbering anything in the first
> + * 2k aside from the initial instruction. I measured the actual data clobbered
> + * as 1076 bytes, but I suspect the amount depends on the configuration, so
> + * just go with what amlogic does.
> + */
> +.skip 2048
> +#endif

How different is this boot0 with the one posted for T7 at [1] ?

https://lore.kernel.org/all/20260821084603.25974-3-tanure@linux.com/

> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index c687ef822a2..91d1e8342e0 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -67,6 +67,13 @@ config MESON_A1
>   	help
>   	  Select this if your SoC is an A113L
>   
> +config MESON_S4
> +	bool "S4"
> +	select MESON64_COMMON
> +	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	help
> +	  Select this if your SoC is an S905Y4/S905W2/S805X2
> +
>   endchoice
>   
>   config SYS_SOC
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 08a24d4b24f..2157c35c2d5 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -17,3 +17,4 @@ endif
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
>   obj-$(CONFIG_MESON_A1) += board-a1.o
> +obj-$(CONFIG_MESON_S4) += board-s4.o
> diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
> new file mode 100644
> index 00000000000..7d0bea9924f
> --- /dev/null
> +++ b/arch/arm/mach-meson/board-s4.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 SberDevices, Inc.
> + */
> +
> +#include <asm/armv8/mmu.h>
> +#include <asm/io.h>
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +
> +void meson_init_reserved_memory(__maybe_unused void *fdt)
> +{
> +}

No reserved memory at all on S4 ?

> +
> +int meson_get_boot_device(void)
> +{
> +	return -ENOSYS;
> +}
> +
> +static struct mm_region s4_mem_map[] = {
> +	{
> +		.virt = 0x00000000UL,
> +		.phys = 0x00000000UL,
> +		.size = 0x80000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x80000000UL,
> +		.phys = 0x80000000UL,
> +		.size = 0x7FE00000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/*
> +		 * This mem region contains in/out shared memory with bl31,
> +		 * hence it's marked as NORMAL memory type
> +		 */
> +		.virt = 0xFFE00000UL,
> +		.phys = 0xFFE00000UL,
> +		.size = 0x00200000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
> +struct mm_region *mem_map = s4_mem_map;

