Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3082C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7113187E95;
	Mon, 19 Feb 2024 10:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ET0yFeRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C561E87E80; Mon, 19 Feb 2024 10:51:00 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DCD87ED3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512a9ae6c02so1614861e87.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336231; x=1708941031; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=f/ucG4Ll4X4pq3QhJLH+Wr3YKS0fw8b8SGmqANbJpDQ=;
 b=ET0yFeRofcZe/86of/43YT5tyJrm6ueihSFAknM9AURZ89G0oaz8j4pvSDNQhDIYA0
 7F9BI7xB36e+IQInmS8G8uO0gC5WtAY+nhHJdpdZrZV8XXSxDdPfuxCayqIusmMx5INW
 bllw64Ky9Qids3ZJkh/UJkG08wZ5+it/xhqxRVMVwv27ikv0e+VR/OJSXPBjD50+vEJt
 BGdNcuWYV/WnitAPDLcZtFnHTaqpOSTxENXrg31Yw53dCGIN35FQJckmIysthf3v2DZw
 W96E4kR6VSwASk5uAV5wDEa/+T7YWRG6ceRVFD1xuEPlZMvkBmLi9TtBDKtPXE+/0ZBh
 B15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336231; x=1708941031;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f/ucG4Ll4X4pq3QhJLH+Wr3YKS0fw8b8SGmqANbJpDQ=;
 b=FbCvV2MxxALlOztKtjIPzidB0jKpUgs0Zpt7HMsawZtsKZLwEupcksmObjCst1DpEr
 ecd7kOTMLh2//np0TOJPGsJxXaGNHijAXELqiYLhS/kUZLZdovIKbO8hmn91X+2N5z0r
 NiijcslxpbqPVXIqFs2PnSjgYof5MvCWP/ORs7ygRd6pdlwgVwbrHmhJrX6va4CNoa0A
 T1C+WdNnjhby9xoGKHmiSiowBIqngvJ+jvsmuFfpOR9/ptYkztPAZjuZPb2AP8Or1vwu
 nol1UEEgc436XDwegDKi2CkcmT32jJtj2v19u7bfiWeM4d1iZrQ/zlAgR/IlghgcvrZs
 RVfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf9+29BcjA2NYXP7YhgTxNjvNgsvKtMUMFzQ29d31NBvWjkwqdzQs6AXdTqGELRb2D9/e/BOuwuzPB9eCyVspzNWRfvg==
X-Gm-Message-State: AOJu0YxKc8vkIlJ9yW4dmQ8RQ+PDaAtQvRAwRtCaYGTO6UbJiHcY2lWK
 hADzct0jhB5BuyGDz9WAxnaZVZ2AT6SqFMdVuI0tsXQBdSe3QnIEFAOv+zPEOsI=
X-Google-Smtp-Source: AGHT+IH128IoV77c81pAa9TTdHLf/mlzIzpm6Y1LSuki8iDxicwpe/x6TTCZs9Dfo/AR+7cU2H6DbQ==
X-Received: by 2002:ac2:55ba:0:b0:512:9595:ef45 with SMTP id
 y26-20020ac255ba000000b005129595ef45mr4853179lfg.34.1708336231005; 
 Mon, 19 Feb 2024 01:50:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:50:30 -0800 (PST)
Message-ID: <2647f79a-4a25-4470-b4a8-aa5f4db92391@linaro.org>
Date: Mon, 19 Feb 2024 10:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 13/39] pinctrl: qcom: stub support for special GPIOs
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
 <20240215-b4-qcom-common-target-v4-13-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-13-ed06355c634a@linaro.org>
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
> Most platforms have a handful of "special" GPIOs, like the MMC
> clock/data lanes, UFS reset, etc. These don't follow the usually naming
> scheme of "gpioX" and also have unique capabilities and registers. We
> can get away without supporting them all for now, but DT compatibility
> is still an issue.
> 
> Add support for allowing these to be specified after the other pins, and
> make all pinmux/pinconf calls for them nop.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/include/mach/gpio.h |  2 ++
>   drivers/gpio/msm_gpio.c                      | 20 ++++++++++++++++++++
>   drivers/pinctrl/qcom/pinctrl-qcom.c          | 12 ++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
> index 8dac62f870b9..c373f5a4cf3d 100644
> --- a/arch/arm/mach-snapdragon/include/mach/gpio.h
> +++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
> @@ -13,6 +13,8 @@
>   struct msm_pin_data {
>   	int pin_count;
>   	const unsigned int *pin_offsets;
> +	/* Index of first special pin, these are ignored for now */
> +	unsigned int special_pins_start;
>   };
>   
>   static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 80cd28bb231f..8a5e8730e911 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -39,6 +39,10 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>   {
>   	struct msm_gpio_bank *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (gpio >= priv->pin_data->special_pins_start)
> +		return 0;
> +
>   	/* Disable OE bit */
>   	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
>   			GPIO_OE_MASK, GPIO_OE_DISABLE);
> @@ -50,6 +54,10 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>   {
>   	struct msm_gpio_bank *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (gpio >= priv->pin_data->special_pins_start)
> +		return 0;
> +
>   	value = !!value;
>   	/* set value */
>   	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -62,6 +70,10 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>   {
>   	struct msm_gpio_bank *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (gpio >= priv->pin_data->special_pins_start)
> +		return 0;
> +
>   	value = !!value;
>   	/* set value */
>   	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -76,6 +88,10 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>   {
>   	struct msm_gpio_bank *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (gpio >= priv->pin_data->special_pins_start)
> +		return 0;
> +
>   	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
>   }
>   
> @@ -83,6 +99,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>   {
>   	struct msm_gpio_bank *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (gpio >= priv->pin_data->special_pins_start)
> +		return 0;
> +
>   	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
>   		return GPIOF_OUTPUT;
>   
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index dc3d8c4d9034..1ea4d21c41fc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -83,6 +83,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>   {
>   	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins, assume they're in the correct state */
> +	if (pin_selector >= priv->data->pin_data.special_pins_start)
> +		return 0;
> +
>   	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>   			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
>   			priv->data->get_function_mux(func_selector) << 2);
> @@ -94,6 +98,10 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>   {
>   	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>   
> +	/* Always NOP for special pins */
> +	if (pin_selector >= priv->data->pin_data.special_pins_start)
> +		return 0;
> +
>   	switch (param) {
>   	case PIN_CONFIG_DRIVE_STRENGTH:
>   		argument = (argument / 2) - 1;
> @@ -136,6 +144,10 @@ int msm_pinctrl_bind(struct udevice *dev)
>   	const char *name;
>   	int ret;
>   
> +	/* Make sure we don't indadvertently treat all pins as special pins. */
> +	if (!data->pin_data.special_pins_start)
> +		data->pin_data.special_pins_start = data->pin_data.pin_count;
> +
>   	drv = lists_driver_lookup_name("pinctrl_qcom");
>   	if (!drv)
>   		return -ENOENT;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
