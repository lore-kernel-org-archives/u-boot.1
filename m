Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB88C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B889288027;
	Fri, 12 Apr 2024 16:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="siEzWqOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669BC87F4B; Fri, 12 Apr 2024 16:32:43 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0ADA88027
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-346b94fa7ecso897710f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712932360; x=1713537160; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=r7KdH7il8Yu8q0GUL8iOGyW02sOmNzS+EFmso3xkJJQ=;
 b=siEzWqOKvGyb/opVKs8SvYom/s3dpOYV0DsD63siH/NrJGxE0XbRCxvwCbQQGwYJiY
 uH132py7jONc5iIjHmYRb966GxHhpqFFyBffqPUB6v5TRllozm9mmdlreIUEpAHqkb5h
 jUtw6hae3J40IKrGNUHzSrJlyWe1v/Djy6YPhT1sdJg5GiMXUqLXkRdBpMl6vHsyEs0/
 y5HYmJqBj2OE78jZArqvaZHHsVDjw8yAVMxFYyTiwFC1GsYb+43YK2CRConEH64LCIBk
 4meQcH+ueB0JZOyFMOUPGwLS/Kwj0nzmpFrk7NVN8nGHL2Hcdi02HW8UBXBGNUQRRwew
 aXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712932360; x=1713537160;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r7KdH7il8Yu8q0GUL8iOGyW02sOmNzS+EFmso3xkJJQ=;
 b=h0UNlQXV/vZncxhB1hT9L119QTl6SUF6vhWppqbEkEUAIZAK5D+1VoVVBiNsBz0xIV
 OQrIRCBaGOmL1sQCmBIkG6Gu4MHXuV+dnJvJdYjMaGsKU2SFnX0tiYXAwF+KxD6gWaaR
 jxDNMYYijd+JLWF+2CiuH5Ro4A0dtCvzGj6ykBiPxVWMiskYA93bf3nnz9Fs/vHpNFU7
 ZeHnd6IwaC/wnf8tR6OpWStAXFstYRu5kSMmZtEZDFnb1k2DHowo1SBrIKC8JVkEcw38
 y1d0/33+Y6vYtlrKGJog8y/PESshpUZtk8YQ7HwFzrjmIzLu9Il3ySN93XeteJ2LY5Xk
 jzrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEcVTe0W+Ml1eoRvByrA6BIYWPThoS3BJm7e+clGLNd3jBAsGv8xsaB4DD5dpa/u2bDf3pSLnxJjqz0/dZRS01KVnu3Q==
X-Gm-Message-State: AOJu0Yz/+V/7l88UnBH+mB6KFGx7KxpZzBOg38+KLt64ZzI1GZePV8oF
 c7fzIBLGc2GerONkLoG9O9DP6bOiajAWR82gtd6g4SMS/M6zsz7WAFXBiK7wbF4=
X-Google-Smtp-Source: AGHT+IHsQLROxij6CDd8EcJKDhrInLDNuIbItWGPbN4EiWyKBk6sP1KlA4ll7J4w3h7EIVT26+dRaw==
X-Received: by 2002:adf:fa0f:0:b0:346:1443:27ea with SMTP id
 m15-20020adffa0f000000b00346144327eamr2008453wrr.68.1712932359818; 
 Fri, 12 Apr 2024 07:32:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121?
 ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c321300b004167b0819aasm9421722wmp.0.2024.04.12.07.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 07:32:39 -0700 (PDT)
Message-ID: <8fae355b-06a2-4c22-8b02-9ac8fb815aa5@linaro.org>
Date: Fri, 12 Apr 2024 16:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 4/7] pinctrl: qcom: Add support for driving GPIO pins
 output
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240412095438.410570-1-sumit.garg@linaro.org>
 <20240412095438.410570-5-sumit.garg@linaro.org>
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
In-Reply-To: <20240412095438.410570-5-sumit.garg@linaro.org>
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

On 12/04/2024 11:54, Sumit Garg wrote:
> Add support for driving the GPIO pins as output low or high.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-qcom.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index 909e566acf5..e68971b37ff 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -29,15 +29,24 @@ struct msm_pinctrl_priv {
>   #define GPIO_CONFIG_REG(priv, x) \
>   	(qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
>   
> -#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
> -#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
> -#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
> -#define TLMM_GPIO_DISABLE BIT(9)
> +#define GPIO_IN_OUT_REG(priv, x) \
> +	(GPIO_CONFIG_REG(priv, x) + 0x4)
> +
> +#define TLMM_GPIO_PULL_MASK	GENMASK(1, 0)
> +#define TLMM_FUNC_SEL_MASK	GENMASK(5, 2)
> +#define TLMM_DRV_STRENGTH_MASK	GENMASK(8, 6)
> +#define TLMM_GPIO_OUTPUT_MASK	BIT(1)
> +#define TLMM_GPIO_OE_MASK	BIT(9)
> +
> +/* GPIO register shifts. */
> +#define GPIO_OUT_SHIFT		1
>   
>   static const struct pinconf_param msm_conf_params[] = {
>   	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>   	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>   	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
> +	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
> +	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
>   };
>   
>   static int msm_get_functions_count(struct udevice *dev)
> @@ -90,7 +99,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>   		return 0;
>   
>   	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> -			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE, func << 2);
> +			TLMM_FUNC_SEL_MASK | TLMM_GPIO_OE_MASK, func << 2);
>   	return 0;
>   }
>   
> @@ -117,6 +126,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>   		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>   				TLMM_GPIO_PULL_MASK, argument);
>   		break;
> +	case PIN_CONFIG_OUTPUT:
> +		writel(argument << GPIO_OUT_SHIFT,
> +		       priv->base + GPIO_IN_OUT_REG(priv, pin_selector));
> +		setbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> +			     TLMM_GPIO_OE_MASK);
> +		break;
>   	default:
>   		return 0;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
