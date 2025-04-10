Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C44C369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A0183B34;
	Thu, 10 Apr 2025 11:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BpOkZ7CK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE6F83B3C; Thu, 10 Apr 2025 11:19:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634EA83B32
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1FC5D5C48E9;
 Thu, 10 Apr 2025 09:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E40C4CEDD;
 Thu, 10 Apr 2025 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744276752;
 bh=DmJOCG54mXsmvB4F8JYD+oK3S+TEINOb3m3354csqW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BpOkZ7CKbFC6SUU0GUaHiqH6Z7HyMf9IZN7iJJ5pq3yJqXkzjJHajI7CszdnYL1Gr
 RumpEW/k2N3rpZWsWASIKzsAWSGxKX/ekRw90DF3McEL3v0bpV5GsMvt7KrU4FAYhF
 4524y/GB98O6UuQUjpTUiBmT1MN5ji9uTpRFb5tJnuax0th1F2LdVnMVc5OQ8R9ulP
 urZbMq66dzr/GpzYmhQkYSjE90hK/JkU9EPUXGXufpwxBWtUfMF7gYWf1QqVueuzRO
 7WDICuCfDZiaehZ8gKoY6VOMx+h91Yz5hzOhPlB7FuhwmA+4It7oanX1MrZh3inNZ7
 N/opMmOntOxmg==
Date: Thu, 10 Apr 2025 14:49:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] pinctrl: qcom: handle reserved ranges
Message-ID: <Z_eNC0bEjUYGDLUY@sumit-X1>
References: <20250410-topic-sm8x50-pinctrl-reserved-ranges-v2-1-654488392b9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-topic-sm8x50-pinctrl-reserved-ranges-v2-1-654488392b9a@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Apr 10, 2025 at 10:52:38AM +0200, neil.armstrong@linaro.org wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Some Qualcomm boards feature reserved ranges of pins which are protected
> by firmware. Attempting to read or write any registers associated with
> these pins results the board resetting.
> 
> Add support for parsing these ranges from devicetree and ensure that the
> pinctrl and GPIO drivers don't try to interact with these pins.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Switch to bitmap
> - Link to v1: https://lore.kernel.org/r/20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org
> ---
>  arch/arm/mach-snapdragon/include/mach/gpio.h | 15 +++++++
>  drivers/gpio/msm_gpio.c                      |  9 ++++
>  drivers/pinctrl/qcom/pinctrl-qcom.c          | 67 ++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
> index cc8f405e20b4392cf9226b805bc85b73aedd9134..11e8104baf2328f5bf82cb318459a237168f6978 100644
> --- a/arch/arm/mach-snapdragon/include/mach/gpio.h
> +++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
> @@ -46,4 +46,19 @@ static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsig
>  	return pindata->special_pins_start && pin >= pindata->special_pins_start;
>  }
>  
> +struct udevice;
> +
> +/**
> + * msm_pinctrl_is_reserved() - Check if a pin lies in a reserved range
> + *
> + * @dev: pinctrl device
> + * @pin: Pin number
> + *
> + * Returns: true if pin is reserved, otherwise false
> + *
> + * Call using dev_get_parent() from the GPIO device, it is a child of
> + * the pinctrl device.
> + */
> +bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin);
> +
>  #endif /* _QCOM_GPIO_H_ */
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index cea073b329777d4e03fbfa86415041a825f65aad..647a616a29374fcf12099509c51fb6e96b19f9f5 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -151,6 +151,9 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>  
>  static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
>  {
> +	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +		return -EPERM;
> +
>  	if (flags & GPIOD_IS_OUT_ACTIVE) {
>  		return msm_gpio_direction_output(dev, gpio, 1);
>  	} else if (flags & GPIOD_IS_OUT) {
> @@ -186,6 +189,9 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  {
>  	struct msm_gpio_bank *priv = dev_get_priv(dev);
>  
> +	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +		return -EPERM;
> +
>  	if (qcom_is_special_pin(priv->pin_data, gpio))
>  		return msm_gpio_get_value_special(priv, gpio);
>  
> @@ -196,6 +202,9 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>  {
>  	struct msm_gpio_bank *priv = dev_get_priv(dev);
>  
> +	if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +		return GPIOF_UNKNOWN;
> +
>  	/* Always NOP for special pins, assume they're in the correct state */
>  	if (qcom_is_special_pin(priv->pin_data, gpio))
>  		return 0;
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index 24d031947a3c00da352fee8b50d5ad38e2d93dfa..c95db56bc47ed3183822fcef2721fc00262b6182 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -15,14 +15,18 @@
>  #include <asm/gpio.h>
>  #include <dm/pinctrl.h>
>  #include <linux/bitops.h>
> +#include <linux/bitmap.h>
>  #include <linux/bug.h>
>  #include <mach/gpio.h>
>  
>  #include "pinctrl-qcom.h"
>  
> +#define MSM_PINCTRL_MAX_PINS 256
> +
>  struct msm_pinctrl_priv {
>  	phys_addr_t base;
>  	struct msm_pinctrl_data *data;
> +	DECLARE_BITMAP(reserved_map, MSM_PINCTRL_MAX_PINS);
>  };
>  
>  #define GPIO_CONFIG_REG(priv, x) \
> @@ -71,13 +75,60 @@ static const char *msm_get_function_name(struct udevice *dev,
>  	return priv->data->get_function_name(dev, selector);
>  }
>  
> +static int msm_pinctrl_parse_ranges(struct udevice *dev)
> +{
> +	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +	ofnode node = dev_ofnode(dev);
> +	int ret, count, i;
> +	u32 *ranges;
> +
> +	if (ofnode_read_prop(node, "gpio-reserved-ranges", &count)) {
> +		if (count % 2 == 1) {
> +			dev_err(dev, "gpio-reserved-ranges must be a multiple of 2\n");
> +			return -EINVAL;
> +		}
> +
> +		ranges = malloc(count);
> +		if (!ranges)
> +			return -ENOMEM;
> +
> +		ret = ofnode_read_u32_array(node, "gpio-reserved-ranges", ranges, count / 4);
> +		if (ret) {
> +			dev_err(dev, "failed to read gpio-reserved-ranges array (%d)\n", ret);
> +			return ret;
> +		}
> +
> +		for (i = 0; i < count / 4; i += 2) {
> +			if (ranges[i] >= MSM_PINCTRL_MAX_PINS ||
> +			    (ranges[i] + ranges[i + 1]) >= MSM_PINCTRL_MAX_PINS) {
> +				dev_err(dev, "invalid reserved-range (%d;%d)\n",
> +					ranges[i], ranges[i + 1]);
> +				return -EINVAL;
> +			}
> +
> +			bitmap_set(priv->reserved_map, ranges[i], ranges[i + 1]);
> +		}
> +
> +		free(ranges);
> +	}
> +
> +	return 0;
> +}
> +
>  static int msm_pinctrl_probe(struct udevice *dev)
>  {
>  	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +	int ret;
>  
>  	priv->base = dev_read_addr(dev);
>  	priv->data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
>  
> +	ret = msm_pinctrl_parse_ranges(dev);
> +	if (ret) {
> +		printf("Couldn't parse reserved GPIO ranges!\n");
> +		return ret;
> +	}
> +
>  	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
>  }
>  
> @@ -97,6 +148,9 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>  	if (func < 0)
>  		return func;
>  
> +	if (msm_pinctrl_is_reserved(dev, pin_selector))
> +		return -EPERM;
> +
>  	/* Always NOP for special pins, assume they're in the correct state */
>  	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
>  		return 0;
> @@ -145,6 +199,9 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  {
>  	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>  
> +	if (msm_pinctrl_is_reserved(dev, pin_selector))
> +		return -EPERM;
> +
>  	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
>  		return msm_pinconf_set_special(priv, pin_selector, param, argument);
>  
> @@ -241,3 +298,13 @@ U_BOOT_DRIVER(pinctrl_qcom) = {
>  	.ops		= &msm_pinctrl_ops,
>  	.probe		= msm_pinctrl_probe,
>  };
> +
> +bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
> +{
> +	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +
> +	if (pin >= MSM_PINCTRL_MAX_PINS)
> +		return false;
> +
> +	return test_bit(pin, priv->reserved_map);
> +}
> 
> ---
> base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
> change-id: 20250401-topic-sm8x50-pinctrl-reserved-ranges-b93cad6cafb3
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 
