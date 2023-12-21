Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77291C46CD2
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC19A878B8;
	Thu, 21 Dec 2023 17:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sRZ0CvK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA82878BF; Thu, 21 Dec 2023 17:18:16 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892D887860
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3363aa2bbfbso969992f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175494; x=1703780294; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1wvc0kkN226KTe7jiM3f0nOo97oTEBzCqkxrAIZcW1w=;
 b=sRZ0CvK979mAJViZ/HwuCqjSjV3Px4J6158vb+a+vbqeoJy0FLGZRSQAtWXAe86OKC
 zKFvkT5OeXuBEV1kYr1OuW+0lvRcJ7lMC2FI4mPExwLOU/2lU/e9FA5ih0dyRFxHUqxT
 0FPeYvcgs/JB46zyYEGI9O2ECiN9Iox3OpxIooucB4jYgm57g3f7MgVqlcMcRpO+5WN2
 hiAeahUWjgjoGO8uBScWIacDxqdazNn4s9iWAwccbuVG+r4kvXet7jRU1WGvPt+pN7t2
 Wfe1S25+9C8BOJwEWlMtQgoIKFZZnwL3NpuYyYIHnHI57zb3AZhWfEMnzEaZOyu/XKjg
 PU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175494; x=1703780294;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1wvc0kkN226KTe7jiM3f0nOo97oTEBzCqkxrAIZcW1w=;
 b=oNFpl4sA0wNgAWNvqpE62nUA5jwqXSe2FMKNGXN/p3hrfH0RPJWksBEQ1Qt5d/Ta4i
 2bjy1flA3UC5Q7roBBPhfdlMCBUlLSkBF8fKoujRkOIida4/69X360VCoOO2gujaseDO
 VWlo3W2KxdKwnDVrjQUb3mBUiuqdXAdrxQ+bmDZuYJ92kXe/ybmHYtRx8apSnlnp1odb
 92RRohlkIFOlirOVCKnMmZ9Cd9yvD6bJNdTGLmj2fQKE5aUFxOHFCvm4uqB1ZXswVptx
 SkJUJxrRsUlHJ5ArOKOvBx74gv6/oLGV5TACljQZw8zT20R3YaJBA++vf+xiZjSSImEs
 24mQ==
X-Gm-Message-State: AOJu0YyOaQyIFG0+zdmbpt+GYJ1epUxQlMHc2VF4gbhPPgtmWqqddCZm
 AcFSTwdV9EqTNePbSfTaRRvh+CDfVT0DxQ==
X-Google-Smtp-Source: AGHT+IELXNnGjnhyo60ak2B3Uopio1Fta9pE4qrsjTZh3CrC8jN4hGo7ZA8eikPwwNbdfSzWPw+z4g==
X-Received: by 2002:a5d:5505:0:b0:336:7b4c:4378 with SMTP id
 b5-20020a5d5505000000b003367b4c4378mr16359wrv.59.1703175493968; 
 Thu, 21 Dec 2023 08:18:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b003364bb3e989sm2316961wrc.110.2023.12.21.08.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:18:13 -0800 (PST)
Message-ID: <77df1d15-b7b3-4a42-9756-9c124a83691a@linaro.org>
Date: Thu, 21 Dec 2023 17:18:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 08/32] gpio: qcom_pmic: 1-based GPIOs
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
 <20231219-b4-qcom-common-target-v2-8-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-8-b6dd9704219e@linaro.org>
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
> Qualcomm PMICs number their GPIOs starting from 1, implement a custom
> .xlate method to handle this.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 6167c8411678..2a4fef8d28cb 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -209,12 +209,34 @@ static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
>   				       REG_CTL_OUTPUT_MASK, !!value);
>   }
>   
> +static int qcom_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
> +			   struct ofnode_phandle_args *args)
> +{
> +	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +
> +	if (args->args_count < 1)
> +		return -EINVAL;
> +
> +	/* GPIOs in DT are 1-based */
> +	desc->offset = args->args[0] - 1;
> +	if (desc->offset >= uc_priv->gpio_count)
> +		return -EINVAL;
> +
> +	if (args->args_count < 2)
> +		return 0;
> +
> +	desc->flags = gpio_flags_xlate(args->args[1]);
> +
> +	return 0;
> +}
> +
>   static const struct dm_gpio_ops qcom_gpio_ops = {
>   	.direction_input	= qcom_gpio_direction_input,
>   	.direction_output	= qcom_gpio_direction_output,
>   	.get_value		= qcom_gpio_get_value,
>   	.set_value		= qcom_gpio_set_value,
>   	.get_function		= qcom_gpio_get_function,
> +	.xlate			= qcom_gpio_xlate,
>   };
>   
>   static int qcom_gpio_probe(struct udevice *dev)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
