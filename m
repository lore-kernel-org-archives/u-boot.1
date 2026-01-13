Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CC3D29DF5
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507A683693;
	Tue, 13 Jan 2026 10:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mCWTIgZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A882D803F5; Tue, 13 Jan 2026 10:36:02 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EBD803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso78712775e9.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768296960; x=1768901760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1muLswv1Q6DOrUucLtQIlIAFQgYA5x5EXBkg9GN2Fg0=;
 b=mCWTIgZbA+GR9KeswNBK/vNifr8cuNy9agwMYBAXpdSGUNsAyycr9nBdEcp68Mk6At
 OIX5QLWJPclmj2mFED9b3OZub/u+fU0eYpVDX0HpOZ6JN19oaGrLfXhrs7MUxyc5s4gI
 BxIHHy/4r66lGjcij8wucqUKrzbauLw5iJfeiAqM+oD6bcklKX6i8Pi6xjib02MX8a9k
 3gv6UNFRSFd7rgTHu3eMSEGqpmnzGhnzBH+tIk1hDRR/AW2IIVhd6Q3p1V5nnhKqkECx
 fPh/76XEO2aJxpab8iyMLhC9h4Iv8YP9KYQ6+pqqtUdI8ViDuoYSJfG0Bk6sdSltUPFQ
 qnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296960; x=1768901760;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1muLswv1Q6DOrUucLtQIlIAFQgYA5x5EXBkg9GN2Fg0=;
 b=e/NJwworz05GsVSS5wKfSNKL63teKCx7xqwyH59YG3YYUwwOma05th5c6h3wvZlKdF
 RLa8oz3ZIm3dH3lqF9wAuSRTy6684dWn7u2Y6fjYw20fvrojz0nnjuIsumLgzYGVYoGK
 oJeWpH5U7GI7Y3UM8DYsOe/WIn+qwKFt2dHCV0Ibu/l8Yfn1iqYm5b+hRmoEFFcJy4TV
 qEkqwbpJ5NVR8IgJSjg7KBHCm0uLxK2gmOKGf/+AJvL1+3OO4UNXDYniWBwlnx/yhbmp
 OVQA9l1bDK1SQhVsodiiHwVSi1sdoWBtFnma5pMCqqsULXWiexG5coo+DGRKUK1VBcyX
 I0uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsME7XssCidDEa3PRnOibLQxTI2/yIXejvCwLA3mRJWZQSswB2Ph5uzDufM6RLGUd8Y3OFa50=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq0nBk2/6k0BosOOVuQb6uq/UV7hA+Od7ER0dYQU1l6NIETgbe
 LnjqPTrBR+Iw/I4fCGJXiPhVnWAggtiYY64BDP7Hw9Yw9fBd0VOTw/HUClxXdLKDoilCIOVMTY3
 0cgYP
X-Gm-Gg: AY/fxX7pBqeEeZWmvPLn1RNmdxZpDOmhUXEMILwyDZxnIVucu4mZ5LvXQCBBqVwMigR
 OCX84NE2991wrf3VrkjiRW2cVwQKAmsEGuN9F79Gj1g05maqobfmY3pckW8XOi2LyEVoT0iadZO
 yZBnYXxAtAFi3nhhgUcbbX3Of9B6vVgQByiYQwns3VbW6b4fnebfZfCOMznKAqb2YJflfnJL1Mk
 fQqUBaeLQJwXj5fbtiVnf9bcRl2VKG64j5gJVkPfPr/VfoX637PdXD+Ckitknfo+5zSOh30YmnF
 Ioc1PX9JGBlgKs5ObOzjEg2JITyf4l6+kM4Q8UwV/A5tMXAVjkNTb93GNDXosCVrT8Jr/UABszD
 wXhhjQCKgyHDMdgsfcG+Ymc6RlaMb+Mgv+Y4vm6ySiQLAtEaqSdt/s3e1V2Imw/yP9R2T9g7nZN
 BgViqn55uTZeVi5pKlxj12cYX+63TE90mpjvszuOc=
X-Google-Smtp-Source: AGHT+IGqnYZ3fExI+DYaJMOZvWnviANJrX8z+bo6E/a9SdbhL9swKx4pZxiF0kahKl0l5NZzt+S9Ug==
X-Received: by 2002:a05:6000:2383:b0:432:586f:2ab2 with SMTP id
 ffacd0b85a97d-432c378a128mr23878401f8f.4.1768296959948; 
 Tue, 13 Jan 2026 01:35:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768?
 ([2a01:e0a:3d9:2080::fa42:7768]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm43719599f8f.15.2026.01.13.01.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:35:59 -0800 (PST)
Message-ID: <f363b625-3478-4a46-ab7b-c3276e217e27@linaro.org>
Date: Tue, 13 Jan 2026 10:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: regulator: common: use dm_gpio_is_valid
 helper
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
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

On 1/8/26 15:42, Julien Stephan wrote:
> Use dm_gpio_is_valid() helper function instead of manually checking the
> gpio.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/power/regulator/regulator_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index ce3d80670de045dde7e263c5301bccd744abd2f5..cf98998579aa8a3cb7f09dccd2124207a58d8b00 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -51,7 +51,7 @@ int regulator_common_get_enable(const struct udevice *dev,
>   	struct regulator_common_plat *plat)
>   {
>   	/* Enable GPIO is optional */
> -	if (!plat->gpio.dev)
> +	if (!dm_gpio_is_valid(&plat->gpio))
>   		return true;
>   
>   	return dm_gpio_get_value(&plat->gpio);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
