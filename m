Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE13DC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B750819D2;
	Mon, 31 Mar 2025 15:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wRcFELzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6612D81DE3; Mon, 31 Mar 2025 15:52:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382308144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so23501945e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743429141; x=1744033941; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pjUppTL6vvnSbGl1jxJdOay9YZA9tQSAsmgJtg91wGU=;
 b=wRcFELzC+4tcXGfK3oTPUIMrmUh0THCXYnslNSGClH6R1ekAD5Gvi8zu+PXEJwV63g
 b53k2Y+RReEt3QuNdPcJbuQwbHDe01JVApBIZINoKMfE0svaM5SDIRUzdZZe46n5ebIL
 JMeKPCYGVkrZVyyus6dQra51VaWkqsdtTB+m3hLa8XqqPUGcTiZX0ASuHgb5r+PZ3YoD
 DQjedXaPRZI9R77dxrCtApLl+C3ebBIXRCvbvJM5c7MREbYV4A3IhoYZ7ZBqRKGAWWax
 ad2r5F0VzVKPdWsM/KMdFfwVitPP84oE4aO46k+t38MZt+zAi6d3p9tAJLeYejeLvHhJ
 JYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743429141; x=1744033941;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pjUppTL6vvnSbGl1jxJdOay9YZA9tQSAsmgJtg91wGU=;
 b=KDIdKzljNqXP5KCd6uY0D5RYoeM9mgY8Zuupl8J3Sc3Pc8tw9EJU1IFE9gxRes0xMt
 kunj7/jFdWW6FC0DqQGeTkvjyZeB53Tv9KPVmQSp/he1XF8ugNtHBL4jyRzMWFfpRJY5
 +uJWQ2iuU6S5xQM9n+NPoUo0T3K/mti7gieYH/jqjYRLa0VixuONet91inW2IAAI1Obe
 wUR82mhdeABY4cA3lbgfHx+RZr/NJ/DNweC6S8XOU2BCaZx8BM0EVGtZ/ty23K2+BSnn
 TPuWLE2hUBU3AlckduF2Z3aw/cxW9PPMRuzwhTNLBMrZGoMOfXMAMdz6R/Nyofl/ccSQ
 Bovw==
X-Gm-Message-State: AOJu0YzWUOONbuD6wMoTu+hWVA03ITUqwy3BBcoj2WRZAmc4oo3iwTAu
 gqbMba0RdLcf7uTj/zfTZJdoqrMp9B0YddRz/eWaixk/dCWlaVgrS7pCP2yb8MA=
X-Gm-Gg: ASbGncvJPq7WdIrHKjUzbHFa3qycgZneiY5hOnfwRN+ktTxO9tZIAXncoIddZaNxE9D
 L8DQQh+VNqC1GG0dTfMgh1V53Eyx+BtFq2uPowgoFFQdTZRVZWNZ2OvCsLs/avqTm/4Xyd/W6TQ
 9CxfL5kfMYEXBTZwA+8VY+DS6YONisVZ3Q2vny9J0XXmoEtFrnSrpMwyLLbEX47apD5uKAQS8q4
 IEwwptbNUWJqn3iCPgCQrcAnlPrWQR9Z+6rUsHDGSr+xEl/cWho+b/GsEn+V+FC2y5j2oJQtOsT
 Z8Gpf3Xjc/lAqz0NpGZ541P0/oFdRl1YCAr94gj9OrsoO6Fd504TjJqka9t6AkgzuvHkVYigdGe
 BnhPOKRMSA6raFn9k
X-Google-Smtp-Source: AGHT+IExo+SBYj0GkMls1TGn23JJ7oKJ9wjgspnQ2cggxqE05cG4dXP/6hLVIBY69FHWaLsLruc9hA==
X-Received: by 2002:a05:600c:c8e:b0:43d:d06:3798 with SMTP id
 5b1f17b1804b1-43db62bd2d1mr77438915e9.20.1743429140649; 
 Mon, 31 Mar 2025 06:52:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:143:2e3d:45f1:fd2?
 ([2a01:e0a:3d9:2080:143:2e3d:45f1:fd2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm11250534f8f.101.2025.03.31.06.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 06:52:20 -0700 (PDT)
Message-ID: <24f50c3f-c203-4972-9bb6-b9a2c6ec9931@linaro.org>
Date: Mon, 31 Mar 2025 15:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] mach-snapdragon: track boot source
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-1-afe2e3696675@linaro.org>
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
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-1-afe2e3696675@linaro.org>
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

On 26/03/2025 18:40, Caleb Connolly wrote:
> Keep track of whether we were loaded via ABL or if U-Boot is running as
> a first-stage bootloader.
> 
> For now we set this based on if we have a valid external FDT or not,
> since it isn't possible to chainload U-Boot from ABL without there being
> an external FDT.
> 
> This will be used to inform the capsule update logic which partition
> U-Boot is flashed to.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c     | 25 +++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-priv.h | 14 ++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d323789eab75d5fe735159b4cd820c02c45..245a963f5321bda3030d3809e1b108f280b3c2b5 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -36,8 +36,10 @@
>   #include "qcom-priv.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +enum qcom_boot_source qcom_boot_source __section(".data") = 0;
> +
>   static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>   
>   struct mm_region *mem_map = rbx_mem_map;
>   
> @@ -237,8 +239,14 @@ int board_fdt_blob_setup(void **fdtp)
>   
>   	if (ret < 0)
>   		panic("No valid memory ranges found!\n");
>   
> +	/* If we have an external FDT, it can only have come from the Android bootloader. */
> +	if (external_valid)
> +		qcom_boot_source = QCOM_BOOT_SOURCE_ANDROID;
> +	else
> +		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
> +
>   	debug("ram_base = %#011lx, ram_size = %#011llx\n",
>   	      gd->ram_base, gd->ram_size);
>   
>   	if (internal_valid) {
> @@ -472,8 +480,24 @@ static void configure_env(void)
>   
>   	qcom_set_serialno();
>   }
>   
> +void qcom_show_boot_source(void)
> +{
> +	const char *name = "UNKNOWN";
> +
> +	switch (qcom_boot_source) {
> +	case QCOM_BOOT_SOURCE_ANDROID:
> +		name = "ABL";
> +		break;
> +	case QCOM_BOOT_SOURCE_XBL:
> +		name = "XBL";
> +		break;
> +	}
> +
> +	log_info("U-Boot loaded from %s\n", name);

Can you write to a boot_source env variable ?

> +}
> +
>   void __weak qcom_late_init(void)
>   {
>   }
>   
> @@ -515,8 +539,9 @@ int board_late_init(void)
>   
>   	configure_env();
>   	qcom_late_init();
>   
> +	qcom_show_boot_source();
>   	/* Configure the dfu_string for capsule updates */
>   	qcom_configure_capsule_updates();
>   
>   	return 0;
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 74d39197b89f4e769299b06214c26ee829ecdce0..e5eb4cfbc2b752de799b1407ede69683c81474c1 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -2,8 +2,22 @@
>   
>   #ifndef __QCOM_PRIV_H__
>   #define __QCOM_PRIV_H__
>   
> +/**
> + * enum qcom_boot_source - Track where we got loaded from.
> + * Used for capsule update logic.
> + *
> + * @QCOM_BOOT_SOURCE_ANDROID: chainloaded (typically from ABL)
> + * @QCOM_BOOT_SOURCE_XBL: flashed to the XBL or UEFI partition
> + */
> +enum qcom_boot_source {
> +	QCOM_BOOT_SOURCE_ANDROID = 1,
> +	QCOM_BOOT_SOURCE_XBL,
> +};
> +
> +extern enum qcom_boot_source qcom_boot_source;
> +
>   #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>   void qcom_configure_capsule_updates(void);
>   #else
>   void qcom_configure_capsule_updates(void) {}
> 

