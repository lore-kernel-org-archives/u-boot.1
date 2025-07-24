Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A109C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C2B83675;
	Thu, 24 Jul 2025 10:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYBzy9Od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB278367B; Thu, 24 Jul 2025 10:30:45 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D9A83616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so947975f8f.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753345843; x=1753950643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XuG6KVRHo2C+iB3ddTGNs6hYkbiFrpONss8PFjYLxrc=;
 b=XYBzy9OdKxA6TkerhUS159cikD+FtznfsxfIurBxzKU+y3wHrGoi3sVSUYWUSbMrCk
 w5bgEHPl25f5BeJIvLcWZR2qy33EG8E42chm9d4tnKeZQdWvO+9BEC/YlYyB/vkn0v8K
 AVY8Byv4z2vbIhXmDTCtn+7XOHVRUpsyAA8PRY7Ej/vzZ4RzC+5rVQQcqrNVZi4L8bwo
 H2+9ROLgYtZR8MJSSQH3ga9xiQwCAaSEcQ36ySrCE2JtVHcD361HK+yRP3ESpP4Ky1kl
 6b9gbGv/L5IeCiqn9GCSrODtO1tlHTr7L1/0tzzAuFBDhYroHFYdNdOy6Ui8XD121x4f
 Rpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753345843; x=1753950643;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XuG6KVRHo2C+iB3ddTGNs6hYkbiFrpONss8PFjYLxrc=;
 b=gYvlci3uS1aSmGeew/gczGhFhQA9XXIegnYQsUPjRtuu/7PpJ3coGE7VpDM2D/aF41
 vqc7yOvKZZPWZxdjtwddQTNAgn4MrwJRLgXNRfcjfn89A7MMi33vF2lA6nPlXFcpgx7K
 Gl/ARDIXPa+zrjwqt8igT8t+5bP0gFlCw8/Sqkwj/ixzK7B5HOee1W9xDURxumNMavOp
 fvUEXTrHgfvLCR568iI2JsZRYySpi9TsSoyx73cFYxKygoi8KXROMU/YQFowICp/P116
 qYvx/JxrNPqj27E6fWAbmssXoRpYbSbiudjzulumpkZ2JQFQk5ysuBm5Q1NJEZ8twG4U
 V4wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4onJ+4aJ73dwaIyelRaVqm8YGLXBe1M1Pj+Ml4quov5+kHOh1D05ugxZkUqvbLAPbmPtIO5I=@lists.denx.de
X-Gm-Message-State: AOJu0YxeKqU9uIpsc4fLV5EGfgky6op2+UKv/kpSqw67ySWyq3BdKeF4
 k/XLwkieIY1yTSSWbJPn3y8BERvxENs7oa1C8SW1Hmaq0LWIt7c7nC7QHe0Im3WpoRY=
X-Gm-Gg: ASbGncudmFuoeWffwvTq1PDl3osLHYneg7uEgXxQuVn2FIobvWjy/6sxVvmSaeXOy8Y
 4YFZGxXwJOVz0iWOHsP5HVZ7cV1Xreua7HZBQzxXOlTA/Q5YqwVzjRoRdpcWeFPjfkyGFOq3Brt
 N2GEOrQCWwPhWN/W0Minua8EikD7Ny3bJxpXiSKI1TkjrvhVgJecJF1kri8r6XFTjWiC6MDs3Gh
 maWAPu0gU0MAKt9qTIW2IOe6OwmuoR5RYnabMiSaf6JtmS4Uqc3ge25fsuWQkdG9WTq2ctYsz39
 qOesqPdPGCE0h2NKYp3bEXkNIbRHTDo29HA5LG9vNuy3/HipQ15RX0lruFK9xeIMZ9l8A9zaeTS
 rPCpZ6XoOV2a/tHX2INeE6u6BdfnSsueS
X-Google-Smtp-Source: AGHT+IHbaUWN3oGzht6uST0yjv6d2XtqP8SkqgbaYOQ/UYleZIrCKpQgnU7vJnYzUrRBpDEI6qYvsg==
X-Received: by 2002:a05:6000:4021:b0:3a5:8991:64b7 with SMTP id
 ffacd0b85a97d-3b77137beefmr801829f8f.26.1753345842862; 
 Thu, 24 Jul 2025 01:30:42 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532b38sm11641265e9.6.2025.07.24.01.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:30:42 -0700 (PDT)
Message-ID: <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
Date: Thu, 24 Jul 2025 10:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
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
In-Reply-To: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 22/07/2025 16:06, Andrew Goodbody wrote:
> timeout is declared as a uint but then tested for being less than zero
> which must always fail. Change the while loop for a pre-decrement on
> timeout and test timeout for being zero.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/adc/meson-saradc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 60e348968fb..0144ff828c5 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -205,9 +205,9 @@ static int meson_saradc_lock(struct meson_saradc_priv *priv)
>   	do {
>   		udelay(1);
>   		regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> -	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
> +	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
>   
> -	if (timeout < 0) {
> +	if (!timeout) {
>   		printf("Timeout while waiting for BL30 unlock\n");
>   		return -ETIMEDOUT;
>   	}
> @@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct meson_saradc_priv *priv)
>   	do {
>   		udelay(1);
>   		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> -	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
> +	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && --timeout);
>   
> -	if (timeout < 0)
> +	if (!timeout)
>   		return -ETIMEDOUT;
>   
>   	return 0;
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250722-meson_saradc-4bba9dc18333
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
