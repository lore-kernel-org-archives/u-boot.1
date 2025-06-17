Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07AFC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AB782B20;
	Tue, 17 Jun 2025 10:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2638M9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3202982C87; Tue, 17 Jun 2025 10:33:48 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA01681E18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so60168185e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750149225; x=1750754025; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1X6D0CmZFKuhKIucaXsHS1PW0QXBMviPNG+2skzn+Fs=;
 b=n2638M9kt7AhH8z/6vN5n9H3PPzRiKwiF5xY+gd3eqRfehKw94aJPug0FjGf1aCuVK
 ZtOlSDFTUN+DyU5bDCWm8X0gy4lM4sPtwurC8STqVSwTnAszMURqkZQ7xw/5JarbEzf5
 uMghIxNirs6pk6SsYvJFlKOsm1Zv3Ij4jSn99w21gyVZ6dpZoC4P43l6oTfSc793qlG4
 r80kexEq900CixXQa7xiTe4A60KhbLJnFb8G/nLDXDBDI+ZiyyYycOoPZG2P+J/ZjsMS
 18zAL/BFrRpAg/F2gn+EqJ9CsG5QUtEcn/zEWraYX+WVfo8uGX4lgdxvqWTAhSaUChF2
 IVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750149225; x=1750754025;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1X6D0CmZFKuhKIucaXsHS1PW0QXBMviPNG+2skzn+Fs=;
 b=qb7g+vWvK9YNGzlEnntxWUvvj547/o9rgURsxHTyBoOR6rEb9vqJZ1eD2BWPX31i07
 9EC716/eNkWPP5geiqMDmiTzBCST9U7VzGJOPqag84OKbWQydJxwK+d0N0tuyn3A27VA
 nb2bPX/s6g0FIIS9kp9GAwNxCe9oRJUviiPXxl2x57eXI+/WRSq9vEyfqABUd/994B6m
 UnHZT7rqCSXq8Epvp0fNH6YZ++XvGmXRmIS8VCWIj7z6hgmUyCV1lRSUHBSyaXkFE6ZT
 u8eI/oOyFBa6ZzQNDVQIWq0AdqVFTLcoqwG8cQlySzv3mBj71RX33/oGtS7wWCa4/LSQ
 /ERw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfxez0yLC+zvO6QvUJY5cn0KWLyvFswF3DjoXGQoOXA2jlKsXGUU/mAAZWEIclLyegiXwrqEg=@lists.denx.de
X-Gm-Message-State: AOJu0YxH7fL7nmJJL+RoO0fNHQ4qkdD6oOxYuPUOFvhN20WtM8BKyRFa
 yUUIbxyprelv3S7opYTn/H8w1TFKMqFp6arTKsFIdH9yUyBKxCSD67jRCu1Yitn2Ygg=
X-Gm-Gg: ASbGncsqohcJT68BUA8mTXKc5SN5C6HKG36KK3TNpIVNm6FAelyIPKTni88i58xrPD0
 o+S+O6GEVNXiHBrsylpSqBt94TX1F8S3cN4LnU5ZpEIavhv69fLany7lLlJEL1mCwhYVaIU52tE
 vzTTLWVmQpFcS4ejer0dQA238l4gnBEOeqXRQjIWLo9BDfWUbFQ+DcQnN4evsRPsEbXGEoWWe12
 AMc8SW/y+V0K4v7THUYabq7LNAXH+5hEbnJJQGZR0P6K+93X8YQ0/Ez7P5W9mLWEyh/waTN3ISl
 0LdBlLnJLprWVD1XaJPLpYE7T0zgnf6N8dwV90OJIMttWWEQCHuVf+lGhgvI2dhQ4sfqPVCvuHN
 BcOVluIf45CcgOg7Q6TfK0GQR7SVDkFIoxFQbBcM=
X-Google-Smtp-Source: AGHT+IFdrRUimj6V0XE0nSEu1tYMp0HmMwO+Uls5v2hph97JboMPH6lltzRQ4skSOM8/kVLyx2G0KA==
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-4533cad1aa0mr125155075e9.31.1750149225312; 
 Tue, 17 Jun 2025 01:33:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31?
 ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a6389esm13083320f8f.27.2025.06.17.01.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:33:44 -0700 (PDT)
Message-ID: <9a5abd7c-e4f1-41fb-9622-57f10092421f@linaro.org>
Date: Tue, 17 Jun 2025 10:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] pinctrl: meson: support gpio toggle command
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
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
In-Reply-To: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
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

On 16/06/2025 19:01, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> meson_gpio_get() always assumes gpio is configured to input mode. This
> is incorrect and breaks `gpio toggle` command:
> 
> gpio: pin aobus-banks2 (gpio 2) value is 0
>     Warning: value of pin is still 1
> 
> Fix it by adding the logic to handle both input and output mode.
> 
> Fixes: 2009a8d03fe5 ("pinctrl: meson: add GPIO support")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v3:
> - remove unused reg_type assignment.
> - Link to v2: https://lore.kernel.org/r/20250617-meson_ppinctrl-v2-1-16d1cb294ef4@outlook.com
> 
> Changes in v2:
> - return -EINVAL directly in case of error. (Neil Armstrong <neil.armstrong@linaro.org>)
> - Link to v1: https://lore.kernel.org/r/20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index babf1bccc969..7dbaf966f93f 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -117,8 +117,26 @@ int meson_gpio_get(struct udevice *dev, unsigned int offset)
>   	struct meson_pinctrl *priv = dev_get_priv(dev->parent);
>   	unsigned int reg, bit;
>   	int ret;
> +	enum gpio_func_t direction;
> +	enum meson_reg_type reg_type;
>   
> -	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, REG_IN, &reg,
> +	direction = meson_gpio_get_direction(dev, offset);
> +
> +	switch (direction) {
> +	case GPIOF_INPUT:
> +		reg_type = REG_IN;
> +		break;
> +
> +	case GPIOF_OUTPUT:
> +		reg_type = REG_OUT;
> +		break;
> +
> +	default:
> +		dev_warn(dev, "Failed to get current direction of Pin %u\n", offset);
> +		return -EINVAL;
> +	}
> +
> +	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, reg_type, &reg,
>   					  &bit);
>   	if (ret)
>   		return ret;
> 
> ---
> base-commit: c5afa1fef49f55146e78d6157470520391c40eca
> change-id: 20250617-meson_ppinctrl-5139ca06b828
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
