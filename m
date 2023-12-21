Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A7EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF103878A2;
	Thu, 21 Dec 2023 17:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W3MvM5vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD047878A4; Thu, 21 Dec 2023 17:19:43 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5C98786E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3333b46f26aso859351f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175581; x=1703780381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FSz47gwv8lgFGakEThdXqLgOhC4B5AfA0h1/zEntTaU=;
 b=W3MvM5voy3hEXFK06Bir/KuvP3Gl6tym0guBRy8MpLp1IIYSZxbUq+2oEaFRz0ugyy
 aHWapIIQz0yWwPD0rVx672pqCTCokNDMRQG6p+HLTek/957UWtvWJ0Lh1a20t86QcsB1
 dNHWSxoQEzST9YQecZ0zmwR5xDDvaKJiEEyl+TyXhR+kfN8eZOgMGnJUfdEf8PH1lUJg
 RhdJ1++DG2gg9qa+dA+W3TURsVS6OM5/M7QrtO977GbMIoBXvccs7U1auZddPg4MzASp
 lFuj7YrVey2OaE8oZfOFyyHT30YqeyiVU1mhzrCKggqtfsIZglr0C6JbhBT6Is41h1/K
 ZRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175581; x=1703780381;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FSz47gwv8lgFGakEThdXqLgOhC4B5AfA0h1/zEntTaU=;
 b=OYX4lnCtL6eG0rU1R09ANF01xhLnfhQiK9z7ZJBOgRtZmZ+k/BrzO2XO6iEhVPenWj
 meykP0dGX1AxqC+IKm3SCCd+RahQOTDTpOchfszuJJZO3LdL8ZM23bdTXo70G7FDxprx
 Yh+jCHXyUv647Dmzcc/jpTKb7OxFsDUzYCxOKiSU/OPvvvBQOmrwcwWoolqwKC50wgY/
 tbCNKP759E1oumkJIrlyfHn/eBdX8cIrxYxjyagP51/FHkEkeGKtHMc3WEAWrs8U+WEW
 wwjcUYOxiGNCoqmY9Eyf6L7SKB+n1Yzj4kL2OLUom602UzmXeCgwHV3a4z4p/qJ5IoAZ
 LbUQ==
X-Gm-Message-State: AOJu0Yy0uM9iaRqn2Aw20Jd8kP9jKdXT8kf1+QyaiO8A6vgQH8ZGpGO2
 FUhjkROgHIc4O5H7EWEMV88DjdPpwAGQ+g==
X-Google-Smtp-Source: AGHT+IEWLnn6BA3gmHSiTHAPNfWsLwLC+H78gFUZi55pHgFB5X6FgHaOxtCArSgmpPjE4k8+/AdAPw==
X-Received: by 2002:adf:dd89:0:b0:336:8268:4266 with SMTP id
 x9-20020adfdd89000000b0033682684266mr9702wrl.78.1703175581102; 
 Thu, 21 Dec 2023 08:19:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b003364bb3e989sm2316961wrc.110.2023.12.21.08.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:19:40 -0800 (PST)
Message-ID: <26585839-068c-4816-959d-3759a9bd85d7@linaro.org>
Date: Thu, 21 Dec 2023 17:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 09/32] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
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
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-9-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-9-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Some platforms hard reset when attempting to configure PMIC GPIOs. Add
> support for quirks specified in match data with a single quirk to skip
> this configuration. We rely on the GPIO already be configured correctly,
> which is always the case for volume up (the only current user of these
> GPIOs).

Do you know why this happens in u-boot and not in Linux ?

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 2a4fef8d28cb..198cd84bc31e 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -64,6 +64,15 @@
>   #define REG_EN_CTL             0x46
>   #define REG_EN_CTL_ENABLE      (1 << 7)
>   
> +/**
> + * pmic_gpio_match_data - platform specific configuration
> + *
> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them
> + */
> +enum pmic_gpio_quirks {
> +	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> +};
> +
>   struct qcom_gpio_bank {
>   	uint32_t pid; /* Peripheral ID on SPMI bus */
>   	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> @@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
>   	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>   	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
>   	uint32_t reg_ctl_val;
> -	int ret;
> +	ulong quirks = dev_get_driver_data(dev);
> +	int ret = 0;
> +
> +	/* Some PMICs don't like their GPIOs being configured */
> +	if (quirks & QCOM_PMIC_QUIRK_READONLY)
> +		return 0;
>   
>   	/* Disable the GPIO */
>   	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
> @@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
>   static const struct udevice_id qcom_gpio_ids[] = {
>   	{ .compatible = "qcom,pm8916-gpio" },
>   	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pm8998-gpio" },
> +	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
>   	{ .compatible = "qcom,pms405-gpio" },
>   	{ }
>   };
> 

