Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B71C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3069282A0A;
	Mon, 16 Jun 2025 18:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k/AjcFth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D9482B18; Mon, 16 Jun 2025 18:40:40 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AB881E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so4465274f8f.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750092038; x=1750696838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=hcKwZAiVPv4FcYz5W4+J5tCKzB1NjRbzOUmdxAIRS1g=;
 b=k/AjcFthtvqFJT65UmNMRv6CmXSP7Xf07sL6XMrx0EQE5S9Dwex/y8b4OkRG0SVnhS
 UqaX35+cLlydjJIF59OfGR9K9sBDM6eLNr9QRBtxyDGBhmJ0mnwSUVyOvnTD4mulklFC
 jNTfzotUQKdR7YTX5I2aKSJuVOPgpNLsG29Bdgzq8fl3UUG8evBONN7O0xuLrsdVNRrR
 Ju9tKivHd7CYaAmoGBHzGhPXDt++JHikTRWYqL4FxRDzo/exouh7HFIXjVlEzVXE6Xmu
 lfLcmrZpKlhFN3JY5nDqyp0sbdSawQIHIjNtt40xaJJ6Gq9zYEWoPSEeCr48EbXLRzEx
 exkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750092038; x=1750696838;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hcKwZAiVPv4FcYz5W4+J5tCKzB1NjRbzOUmdxAIRS1g=;
 b=sY2IyoC5NLK19azl4aUAxKBiOstsWcl+gN6142+ejIUwq+WWQOn818dGn0vQziP9QA
 pybzY5vtFp/DzU66o9ksMX8abmdx8dJqBX31BsAHf2I5EUyd74pZgFJm5uXPhxcBdDOu
 mhzr1Sk4LUW/7txq/t3k1DUlGcsMa4UYlOn2i5RMgqOrZUqz6M92PlT+UpT07fMkItfN
 Bh5y7qy268mrfNBxruoVQPmUpKQnK9Kj8PtVYkh2DlWz8Jf2yz6TEciKn2ympbXT7SyW
 JbJjLegMV5t6bGix3eZ4IU3lE+5i3gEX1WaiLNPxT5VOIjJ+TFQWSIuwdnqesktN7sDR
 r8tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlWLmz8YWNzcf819nfqLkhMnjfPZOFHm2y2QTmWd3u+K/07z+Wm5eHWE0f69+YxSl7P74p0NY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw07oHkfRfwjca0zQjgthudqoRzsNVVv2Q2YNNZVzZZeherkimJ
 RIQBEPxxyelG9mCbKq3WKUlKC03iCpuemjxn38TjsuusA96D8+7QIET/9rzrgk0o+Jo=
X-Gm-Gg: ASbGncseWbMIa54DHmqWVfrPpZlpbSWRVbjrNpLJjJpPkqQiIedErYXMLOjfOhGJ22Z
 tNgxxeFBnhwnEYJyshgP9PMC8QyzEZK/GPKmnfYMt0B1CwhwwWqOervbtTXMBtCEkkrGaN3Zem+
 tTsFcwsl1X9mlsxo7lksUY9xbc6SYEMbh4zBrs11b/JZibJAnpWQACV59ZDKlAAG3AhHo+kNciX
 rEbmckQ/gYu/rbwXB0IaQUHm9cJleYzjgLaMoV7kHca4n55g/XGmW1LN/SrpqYStRxU+zcMiMb4
 ZWLFGJrKSclbysi+7+zshO7trZzYho5KdF9rhny9fyDz75bZMAI0XUE320hGa2qXMWga43gN7vO
 f1NSH1P3jKNA4qfLh6S0uiis+GR06GlO1AO9C
X-Google-Smtp-Source: AGHT+IHg01366LdLrsnTbbnP4fKY+Xr83m8gzgp9G84snc6OJBUhOTfY4zl/WZhoVEwQS0nD+q/dIA==
X-Received: by 2002:a05:6000:461e:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a572e79733mr6984547f8f.29.1750092037760; 
 Mon, 16 Jun 2025 09:40:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a?
 ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b28240sm11580556f8f.72.2025.06.16.09.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 09:40:37 -0700 (PDT)
Message-ID: <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
Date: Mon, 16 Jun 2025 18:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pinctrl: meson: support gpio toggle command
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
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
In-Reply-To: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
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

On 16/06/2025 18:23, Yang Xiwen via B4 Relay wrote:
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
>   drivers/pinctrl/meson/pinctrl-meson.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index babf1bccc969..a1f4afd11f94 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -117,8 +117,27 @@ int meson_gpio_get(struct udevice *dev, unsigned int offset)
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
> +		reg_type = REG_IN;
> +		dev_warn(dev, "Failed to get current direction of Pin %u\n", offset);
> +		break;

Just return -EINVAL here

Thanks,
Neil

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

