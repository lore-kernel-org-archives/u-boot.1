Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA9DC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 10:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1F487D06;
	Mon, 19 Feb 2024 11:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ijKTL2a6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B1A87C66; Mon, 19 Feb 2024 11:55:53 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0523387CE8
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 11:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so3739371a12.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708340142; x=1708944942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NAJ+G9b4Cj9EdU//k4A/XVTOo7p78+ImULiPf1nS32Q=;
 b=ijKTL2a6Dm98NLEdnjF/B5+16REh3FGby121GKBjgZFUMXG1RvWyq2l+VfIlz9afDE
 kz9uZ9Lev9QRg4rHVC1DqtokoRa+dKvsyYwWBGtKKmw/GaHjhleswCElcB+8+66516lp
 z6HwgaP4Tz+McYhah4MDQuOMvwareg16PC7wKeuDMU8T1TahOSa0W8NIYWXkJ1Aoxr2z
 a8ZWra5lV35se0tUliz4yRuEm1Xvfi+cp/IZms8b7gOZE8C2NznM2/ijDsUIYof8UZ3i
 2lzfS9YrFuJLut5YfByptiIanBBPIRpUpCA0T9sy5ciRQekzHXhxI0BJIfgLET7MkX3h
 7o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708340142; x=1708944942;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NAJ+G9b4Cj9EdU//k4A/XVTOo7p78+ImULiPf1nS32Q=;
 b=pNfw4PGIGWQ0ZlhHNWbGhdpCB0OvwobI0hNnulFNks9XLT0wh+HgoXg2f68DLaqGmz
 hp8Ltk092LmxeLJeLXFr1U9MCP97J/vbgI/+FO7PoMmKL5G1nX441i7KeDgSqFHE5HF7
 ILiBvj5puOeK77u6jbDhVjC9X7UE8+Y4oIBWFuL1Gjn1OKyk5+mgVI1bL1EAAV9PywOg
 kdtLtc+FkJQutVy5Mr01SWPuWXteG8q3jFXpJ0TwsHq9BfEfWxs6GEyX/qB+d4FLV6Jc
 bNYpUQokUzldZJJ3zG6qvrHJPYnOeE76A/U0E9A0cz/5rHaDG+w5fiPvlZpeKm4p6Evj
 lhYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ0jdo98c9/fz7NDqs1tsPCayMdeg0L45Vq6beJzfu5dKG4Hvm+94m4mPG5oewF4GpRudzMeP76UveoLssw1alcWoJPg==
X-Gm-Message-State: AOJu0YztuJYA5OrH/paNwQqp6rzGkVU2fqn6uwWwZRo5oSMfuWRXS3E8
 ljvhzl49hxmTGysxtl+1KrT89JNVvVvJdolnVziv/74FMbSJ93OZKkak0cFDmFc=
X-Google-Smtp-Source: AGHT+IEWcm1b2zfIdA5VqR9mJnTEOdjLDoz31bZ+vrF7dAiuiGnMifIQIVpxyRH5f7tFqfbwz9dkqQ==
X-Received: by 2002:a17:90a:6d63:b0:299:4219:243c with SMTP id
 z90-20020a17090a6d6300b002994219243cmr10346795pjj.5.1708340141841; 
 Mon, 19 Feb 2024 02:55:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fe7f:ff5e:4cf1:97b9?
 ([2a01:e0a:982:cbb0:fe7f:ff5e:4cf1:97b9])
 by smtp.gmail.com with ESMTPSA id
 se3-20020a17090b518300b002998d713b5fsm2521947pjb.40.2024.02.19.02.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 02:55:41 -0800 (PST)
Message-ID: <1edd3c76-6b68-4e5c-abd0-005be70c5e7b@linaro.org>
Date: Mon, 19 Feb 2024 11:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 11/39] gpio: qcom_pmic: add pinctrl driver
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
 <20240215-b4-qcom-common-target-v4-11-ed06355c634a@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240215-b4-qcom-common-target-v4-11-ed06355c634a@linaro.org>
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
> Introduce a basic pinctrl driver for the SPMI PMIC GPIOs. This is
> necessary to make proper use of upstream DT bindings specifically on the
> dragonboard410c where they're used to switch between USB host and device
> modes.
> 
> Only support for driving the pins as output low or high is enabled for
> now.
> 
> To minimise duplicated code and allow for sharing common DT data, the
> pinctrl driver is initialised as a child of the existing GPIO driver.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 257 +++++++++++++++++++++++++++++-------------
>   1 file changed, 176 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 198cd84bc31e..9eca1556c356 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -7,10 +7,14 @@
>   
>   #include <common.h>
>   #include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <dm/pinctrl.h>
>   #include <log.h>
>   #include <power/pmic.h>
>   #include <spmi/spmi.h>
>   #include <asm/io.h>
> +#include <stdlib.h>
>   #include <asm/gpio.h>
>   #include <linux/bitops.h>
>   
> @@ -73,17 +77,54 @@ enum pmic_gpio_quirks {
>   	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
>   };
>   
> -struct qcom_gpio_bank {
> +struct qcom_pmic_gpio_data {
>   	uint32_t pid; /* Peripheral ID on SPMI bus */
>   	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> +	u32 pin_count;
> +	struct udevice *pmic; /* Reference to pmic device for read/write */
>   };
>   
> -static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
> +/* dev can be the GPIO or pinctrl device */
> +static int _qcom_gpio_set_direction(struct udevice *dev, u32 offset, bool input, int value)
> +{
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	u32 gpio_base = plat->pid + REG_OFFSET(offset);
> +	u32 reg_ctl_val;
> +	int ret = 0;
> +
> +	/* Select the mode and output */
> +	if (plat->lv_mv_type) {
> +		if (input)
> +			reg_ctl_val = REG_CTL_LV_MV_MODE_INPUT;
> +		else
> +			reg_ctl_val = REG_CTL_LV_MV_MODE_INOUT;
> +	} else {
> +		if (input)
> +			reg_ctl_val = REG_CTL_MODE_INPUT;
> +		else
> +			reg_ctl_val = REG_CTL_MODE_INOUT | !!value;
> +	}
> +
> +	ret = pmic_reg_write(plat->pmic, gpio_base + REG_CTL, reg_ctl_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (plat->lv_mv_type && !input) {
> +		ret = pmic_reg_write(plat->pmic,
> +				     gpio_base + REG_LV_MV_OUTPUT_CTL,
> +				     !!value << REG_LV_MV_OUTPUT_CTL_SHIFT);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
>   				   bool input, int value)
>   {
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
> -	uint32_t reg_ctl_val;
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
>   	ulong quirks = dev_get_driver_data(dev);
>   	int ret = 0;
>   
> @@ -97,33 +138,10 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
>   	if (ret < 0)
>   		return ret;
>   
> -	/* Select the mode and output */
> -	if (priv->lv_mv_type) {
> -		if (input)
> -			reg_ctl_val = REG_CTL_LV_MV_MODE_INPUT;
> -		else
> -			reg_ctl_val = REG_CTL_LV_MV_MODE_INOUT;
> -	} else {
> -		if (input)
> -			reg_ctl_val = REG_CTL_MODE_INPUT;
> -		else
> -			reg_ctl_val = REG_CTL_MODE_INOUT | !!value;
> -	}
> -
> -	ret = pmic_reg_write(dev->parent, gpio_base + REG_CTL, reg_ctl_val);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (priv->lv_mv_type && !input) {
> -		ret = pmic_reg_write(dev->parent,
> -				     gpio_base + REG_LV_MV_OUTPUT_CTL,
> -				     !!value << REG_LV_MV_OUTPUT_CTL_SHIFT);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	_qcom_gpio_set_direction(dev, offset, input, value);
>   
>   	/* Set the right pull (no pull) */
> -	ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_PULL_CTL,
> +	ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
>   			     REG_DIG_PULL_NO_PU);
>   	if (ret < 0)
>   		return ret;
> @@ -131,13 +149,13 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
>   	/* Configure output pin drivers if needed */
>   	if (!input) {
>   		/* Select the VIN - VIN0, pin is input so it doesn't matter */
> -		ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_VIN_CTL,
> +		ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_VIN_CTL,
>   				     REG_DIG_VIN_VIN0);
>   		if (ret < 0)
>   			return ret;
>   
>   		/* Set the right dig out control */
> -		ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_OUT_CTL,
> +		ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_OUT_CTL,
>   				     REG_DIG_OUT_CTL_CMOS |
>   				     REG_DIG_OUT_CTL_DRIVE_L);
>   		if (ret < 0)
> @@ -162,15 +180,15 @@ static int qcom_gpio_direction_output(struct udevice *dev, unsigned offset,
>   
>   static int qcom_gpio_get_function(struct udevice *dev, unsigned offset)
>   {
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
>   	int reg;
>   
> -	reg = pmic_reg_read(dev->parent, gpio_base + REG_CTL);
> +	reg = pmic_reg_read(plat->pmic, gpio_base + REG_CTL);
>   	if (reg < 0)
>   		return reg;
>   
> -	if (priv->lv_mv_type) {
> +	if (plat->lv_mv_type) {
>   		switch (reg & REG_CTL_LV_MV_MODE_MASK) {
>   		case REG_CTL_LV_MV_MODE_INPUT:
>   			return GPIOF_INPUT;
> @@ -195,11 +213,11 @@ static int qcom_gpio_get_function(struct udevice *dev, unsigned offset)
>   
>   static int qcom_gpio_get_value(struct udevice *dev, unsigned offset)
>   {
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
>   	int reg;
>   
> -	reg = pmic_reg_read(dev->parent, gpio_base + REG_STATUS);
> +	reg = pmic_reg_read(plat->pmic, gpio_base + REG_STATUS);
>   	if (reg < 0)
>   		return reg;
>   
> @@ -209,11 +227,11 @@ static int qcom_gpio_get_value(struct udevice *dev, unsigned offset)
>   static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
>   			       int value)
>   {
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
>   
>   	/* Set the output value of the gpio */
> -	if (priv->lv_mv_type)
> +	if (plat->lv_mv_type)
>   		return pmic_clrsetbits(dev->parent,
>   				       gpio_base + REG_LV_MV_OUTPUT_CTL,
>   				       REG_LV_MV_OUTPUT_CTL_MASK,
> @@ -253,63 +271,74 @@ static const struct dm_gpio_ops qcom_gpio_ops = {
>   	.xlate			= qcom_gpio_xlate,
>   };
>   
> +static int qcom_gpio_bind(struct udevice *dev)
> +{
> +	
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	ulong quirks = dev_get_driver_data(dev);
> +	struct udevice *child;
> +	struct driver *drv;
> +	int ret;
> +
> +	drv = lists_driver_lookup_name("qcom_pmic_pinctrl");
> +	if (!drv) {
> +		log_warning("Cannot find driver '%s'\n", "qcom_pmic_pinctrl");
> +		return -ENOENT;
> +	}
> +
> +	/* Bind the GPIO driver as a child of the PMIC. */
> +	ret = device_bind_with_driver_data(dev, drv,
> +					   dev->name,
> +					   quirks, dev_ofnode(dev), &child);
> +	if (ret)
> +		return log_msg_ret("bind", ret);
> +
> +	dev_set_plat(child, plat);
> +
> +	return 0;
> +}
> +
>   static int qcom_gpio_probe(struct udevice *dev)
>   {
> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
> -	int reg;
> +	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	struct ofnode_phandle_args args;
> +	int val, ret;
>   	u64 pid;
>   
> +	plat->pmic = dev->parent;
> +
>   	pid = dev_read_addr(dev);
>   	if (pid == FDT_ADDR_T_NONE)
>   		return log_msg_ret("bad address", -EINVAL);
>   
> -	priv->pid = pid;
> +	plat->pid = pid;
>   
>   	/* Do a sanity check */
> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
> -	if (reg != REG_TYPE_VAL)
> +	val = pmic_reg_read(plat->pmic, plat->pid + REG_TYPE);
> +	if (val != REG_TYPE_VAL)
>   		return log_msg_ret("bad type", -ENXIO);
>   
> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
> -	if (reg != REG_SUBTYPE_GPIO_4CH && reg != REG_SUBTYPE_GPIOC_4CH &&
> -	    reg != REG_SUBTYPE_GPIO_LV && reg != REG_SUBTYPE_GPIO_MV)
> +	val = pmic_reg_read(plat->pmic, plat->pid + REG_SUBTYPE);
> +	if (val != REG_SUBTYPE_GPIO_4CH && val != REG_SUBTYPE_GPIOC_4CH &&
> +	    val != REG_SUBTYPE_GPIO_LV && val != REG_SUBTYPE_GPIO_MV)
>   		return log_msg_ret("bad subtype", -ENXIO);
>   
> -	priv->lv_mv_type = reg == REG_SUBTYPE_GPIO_LV ||
> -			   reg == REG_SUBTYPE_GPIO_MV;
> -
> -	return 0;
> -}
> -
> -/*
> - * Parse basic GPIO count specified via the gpio-ranges property
> - * as specified in Linux devicetrees
> - * Returns < 0 on error, otherwise gpio count
> - */
> -static int qcom_gpio_of_parse_ranges(struct udevice *dev)
> -{
> -	int ret;
> -	struct ofnode_phandle_args args;
> +	plat->lv_mv_type = val == REG_SUBTYPE_GPIO_LV ||
> +			   val == REG_SUBTYPE_GPIO_MV;
>   
> +	/*
> +	 * Parse basic GPIO count specified via the gpio-ranges property
> +	 * as specified in upstream devicetrees
> +	 */
>   	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
>   					     NULL, 3, 0, &args);
>   	if (ret)
>   		return log_msg_ret("gpio-ranges", ret);
>   
> -	return args.args[2];
> -}
> -
> -static int qcom_gpio_of_to_plat(struct udevice *dev)
> -{
> -	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> -	int ret;
> -
> -	ret = qcom_gpio_of_parse_ranges(dev);
> -	if (ret > 0)
> -		uc_priv->gpio_count = ret;
> -	else
> -		return ret;
> +	plat->pin_count = args.args[2];
>   
> +	uc_priv->gpio_count = plat->pin_count;
>   	uc_priv->bank_name = "pmic";
>   
>   	return 0;
> @@ -327,9 +356,75 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
>   	.name	= "qcom_pmic_gpio",
>   	.id	= UCLASS_GPIO,
>   	.of_match = qcom_gpio_ids,
> -	.of_to_plat = qcom_gpio_of_to_plat,
> -	.probe	= qcom_gpio_probe,
> +	.bind	= qcom_gpio_bind,
> +	.probe = qcom_gpio_probe,
>   	.ops	= &qcom_gpio_ops,
> -	.priv_auto	= sizeof(struct qcom_gpio_bank),
> +	.plat_auto = sizeof(struct qcom_pmic_gpio_data),
> +	.flags = DM_FLAG_ALLOC_PDATA,
>   };
>   
> +static const struct pinconf_param qcom_pmic_pinctrl_conf_params[] = {
> +	{ "output-high", PIN_CONFIG_OUTPUT_ENABLE, 1 },
> +	{ "output-low", PIN_CONFIG_OUTPUT, 0 },
> +};
> +
> +static int qcom_pmic_pinctrl_get_pins_count(struct udevice *dev)
> +{
> +	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +
> +	return plat->pin_count;
> +}
> +
> +static const char *qcom_pmic_pinctrl_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +	static char name[8];
> +
> +	/* DT indexes from 1 */
> +	snprintf(name, sizeof(name), "gpio%u", selector + 1);
> +
> +	return name;
> +}
> +
> +static int qcom_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int selector,
> +					 unsigned int param, unsigned int arg)
> +{
> +	/* We only support configuring the pin as an output, either low or high */
> +	return _qcom_gpio_set_direction(dev, selector, false,
> +					param == PIN_CONFIG_OUTPUT_ENABLE);
> +}
> +
> +static const char *qcom_pmic_pinctrl_get_function_name(struct udevice *dev, unsigned int selector)
> +{
> +	if (!selector)
> +		return "normal";
> +	return NULL;
> +}
> +
> +static int qcom_pmic_pinctrl_generic_get_functions_count(struct udevice *dev)
> +{
> +	return 1;
> +}
> +
> +static int qcom_pmic_pinctrl_generic_pinmux_set_mux(struct udevice *dev, unsigned int selector,
> +						    unsigned int func_selector)
> +{
> +	return 0;
> +}
> +
> +struct pinctrl_ops qcom_pmic_pinctrl_ops = {
> +	.get_pins_count = qcom_pmic_pinctrl_get_pins_count,
> +	.get_pin_name = qcom_pmic_pinctrl_get_pin_name,
> +	.set_state = pinctrl_generic_set_state,
> +	.pinconf_num_params = ARRAY_SIZE(qcom_pmic_pinctrl_conf_params),
> +	.pinconf_params = qcom_pmic_pinctrl_conf_params,
> +	.pinconf_set = qcom_pmic_pinctrl_pinconf_set,
> +	.get_function_name = qcom_pmic_pinctrl_get_function_name,
> +	.get_functions_count = qcom_pmic_pinctrl_generic_get_functions_count,
> +	.pinmux_set = qcom_pmic_pinctrl_generic_pinmux_set_mux,
> +};
> +
> +U_BOOT_DRIVER(qcom_pmic_pinctrl) = {
> +	.name	= "qcom_pmic_pinctrl",
> +	.id	= UCLASS_PINCTRL,
> +	.ops	= &qcom_pmic_pinctrl_ops,
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
