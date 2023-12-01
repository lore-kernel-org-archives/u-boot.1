Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698EC07E97
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E39386F50;
	Fri,  1 Dec 2023 10:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fe1UxRU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8E886F50; Fri,  1 Dec 2023 10:26:41 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2825586314
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b595bf5d2so14780625e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701422798; x=1702027598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eBihwoE8Yt0Qo9eIuBUrKDJ4ZQXXvKelQ970kx8uWh4=;
 b=Fe1UxRU4QNQjOWcILhIkxZRps3nn2HKYI0P+XK2nCw7YyYErdwGX4WQYt54Wuj3HcU
 nUJP5gngInRSPrAmNkLgyCMBrRLuDwXlAd5CUYcIPrZJhbVzZgXGbXCGRzK1zn/M3H4C
 qjHc/XqpVx14q7+xrjvrAt+/RP+TpnOgSuehy0sThWYrUEnwrQxWfDB9x0Z+kx674cjl
 nfJul6sABv/0F0Q3ezH+8ACqHUkcXZAiDOH8ZyqvM4XnI4IzOvcy/xpEv+fDQ1YKjNud
 5Oe77ErxtOWRvrwSpfcCFCaJEoZNpe6EFpIH609BikOzbCCFoZFG1rxhliP27rg2Szi5
 u81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701422798; x=1702027598;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eBihwoE8Yt0Qo9eIuBUrKDJ4ZQXXvKelQ970kx8uWh4=;
 b=NWlKMp3WEH1kyCF0y1eLSSofW+C5zPdA/+3UtDWysuUQh2g+QVeeALqqClnk41sQsE
 Q3wEzzA9NmFpcjdVwyz2//Rls2zQwgkNwMaLnpWPD++0GWUTHJ2ZpvDmLWCFuek4XTjU
 6BficFC0dTja2r+Pjf//8hjOTbVPrSmKuOPzPF2gycEucBLGInNuxOy/4FOG2xQkQNo4
 /pRuNkuUc6mm6D3p9SKe1SxxowMSrdZylqd9wQecJlYHxH5gE6hUCvbTYli7RcxG/aDA
 FQCp1Wp4z8nHLmufbyv3nhCImjoFxyLPn312mVNUtQBvHP2Ny5cQOnn3KJ6VC4HcMAOn
 Y9QQ==
X-Gm-Message-State: AOJu0YwNWri+hICASqhZ29A5+mCTlNNelZKozlccONRWOmwkO0Z+oFRs
 fzAisIg3Sl+C63+DjeaNPOLqjQ==
X-Google-Smtp-Source: AGHT+IGJ9vjFCR7RAK4I0uvRM9Dot98gmOAEyrF3VV3l5nej5r3JytYWAy6AuJuGD+yemaiBqXwqdg==
X-Received: by 2002:adf:f383:0:b0:333:2fc4:454 with SMTP id
 m3-20020adff383000000b003332fc40454mr357545wro.77.1701422798582; 
 Fri, 01 Dec 2023 01:26:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 dd16-20020a0560001e9000b00332cc24a59bsm3647361wrb.109.2023.12.01.01.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:26:38 -0800 (PST)
Message-ID: <0c64ebe9-aaa7-47e1-8554-0a3afde1621f@linaro.org>
Date: Fri, 1 Dec 2023 10:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 4/9] gpio: qcom_pmic: drop pon GPIO driver
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-4-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-4-41500e237ad0@linaro.org>
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

On 30/11/2023 21:22, Caleb Connolly wrote:
> Remove the (now unused) GPIO driver for the power and resin buttons on
> the PMIC.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/Kconfig          |   3 +-
>   drivers/gpio/qcom_pmic_gpio.c | 104 ------------------------------------------
>   2 files changed, 2 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index ba42b0768e12..fbf77673c5e0 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -309,12 +309,13 @@ config CMD_PCA953X
>   config QCOM_PMIC_GPIO
>   	bool "Qualcomm generic PMIC GPIO/keypad driver"
>   	depends on DM_GPIO && PMIC_QCOM
> +	select BUTTON
>   	help
>   	  Support for GPIO pins and power/reset buttons found on
>   	  Qualcomm SoCs PMIC.
>   	  Default name for GPIO bank is "pm8916".
>   	  Power and reset buttons are placed in "pwkey_qcom" bank and
> -          have gpio numbers 0 and 1 respectively.
> +	  have gpio numbers 0 and 1 respectively.

In a perfect world this should go in a separate commit, but it's not worth it!

>   
>   config PCF8575_GPIO
>   	bool "PCF8575 I2C GPIO Expander driver"
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index e5841f502953..7b83c67fa464 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -275,107 +275,3 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
>   	.priv_auto	= sizeof(struct qcom_gpio_bank),
>   };
>   
> -
> -/* Add pmic buttons as GPIO as well - there is no generic way for now */
> -#define PON_INT_RT_STS                        0x10
> -#define KPDPWR_ON_INT_BIT                     0
> -#define RESIN_ON_INT_BIT                      1
> -
> -static int qcom_pwrkey_get_function(struct udevice *dev, unsigned offset)
> -{
> -	return GPIOF_INPUT;
> -}
> -
> -static int qcom_pwrkey_get_value(struct udevice *dev, unsigned offset)
> -{
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -
> -	int reg = pmic_reg_read(dev->parent, priv->pid + PON_INT_RT_STS);
> -
> -	if (reg < 0)
> -		return 0;
> -
> -	switch (offset) {
> -	case 0: /* Power button */
> -		return (reg & BIT(KPDPWR_ON_INT_BIT)) != 0;
> -		break;
> -	case 1: /* Reset button */
> -	default:
> -		return (reg & BIT(RESIN_ON_INT_BIT)) != 0;
> -		break;
> -	}
> -}
> -
> -/*
> - * Since pmic buttons modelled as GPIO, we need empty direction functions
> - * to trick u-boot button driver
> - */
> -static int qcom_pwrkey_direction_input(struct udevice *dev, unsigned int offset)
> -{
> -	return 0;
> -}
> -
> -static int qcom_pwrkey_direction_output(struct udevice *dev, unsigned int offset, int value)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static const struct dm_gpio_ops qcom_pwrkey_ops = {
> -	.get_value		= qcom_pwrkey_get_value,
> -	.get_function		= qcom_pwrkey_get_function,
> -	.direction_input	= qcom_pwrkey_direction_input,
> -	.direction_output	= qcom_pwrkey_direction_output,
> -};
> -
> -static int qcom_pwrkey_probe(struct udevice *dev)
> -{
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	int reg;
> -	u64 pid;
> -
> -	pid = dev_read_addr(dev);
> -	if (pid == FDT_ADDR_T_NONE)
> -		return log_msg_ret("bad address", -EINVAL);
> -
> -	priv->pid = pid;
> -
> -	/* Do a sanity check */
> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
> -	if (reg != 0x1)
> -		return log_msg_ret("bad type", -ENXIO);
> -
> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
> -	if ((reg & 0x5) == 0)
> -		return log_msg_ret("bad subtype", -ENXIO);
> -
> -	return 0;
> -}
> -
> -static int qcom_pwrkey_of_to_plat(struct udevice *dev)
> -{
> -	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> -
> -	uc_priv->gpio_count = 2;
> -	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
> -	if (uc_priv->bank_name == NULL)
> -		uc_priv->bank_name = "pwkey_qcom";
> -
> -	return 0;
> -}
> -
> -static const struct udevice_id qcom_pwrkey_ids[] = {
> -	{ .compatible = "qcom,pm8916-pwrkey" },
> -	{ .compatible = "qcom,pm8994-pwrkey" },
> -	{ .compatible = "qcom,pm8998-pwrkey" },
> -	{ }
> -};
> -
> -U_BOOT_DRIVER(pwrkey_qcom) = {
> -	.name	= "pwrkey_qcom",
> -	.id	= UCLASS_GPIO,
> -	.of_match = qcom_pwrkey_ids,
> -	.of_to_plat = qcom_pwrkey_of_to_plat,
> -	.probe	= qcom_pwrkey_probe,
> -	.ops	= &qcom_pwrkey_ops,
> -	.priv_auto	= sizeof(struct qcom_gpio_bank),
> -};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
