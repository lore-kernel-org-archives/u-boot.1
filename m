Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD3C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 07:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A8A876E3;
	Fri,  3 Nov 2023 08:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W6laQDwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39669876E3; Fri,  3 Nov 2023 08:17:58 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EB586F69
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 08:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-45d9689b65dso121251137.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698995872; x=1699600672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wEt2lODl2nBPcH2tZIj0kSMZTbpL5jH5nNbqaUPrSUQ=;
 b=W6laQDwIVRI3oyCBPZl/UXtfqAYR8L0m3NyE8ctKQYS47eYKAoKifAEIbFQ80TUDXU
 BpGHh7KIA9Zb6Rj5TRx6+vj6Zs6Shx/b1oLpSMqhUiaBbSEP/l9XE3rhf9lbq/UWlmyp
 JF2OwvlwLfuwkq+DYzCjstZRn4PpyMtAeWYyaRAGpwcqzMLia6yBjqy6nmbanLfPnzHi
 hm1+dThZektWy9qf5J85hsv9gJBBTosj61h8oepY8COK23xE9Xj1r2209aqVoSv+8AeC
 c4PRdFbqioQvgb4aEzZBiapQ8plFZbtvScWXr9rWHwE0kMrNVGoWCioomeV75Pi0zrSu
 Se/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698995872; x=1699600672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wEt2lODl2nBPcH2tZIj0kSMZTbpL5jH5nNbqaUPrSUQ=;
 b=AJ/+OGhQ8vPhCgLFsT19vjqtWtrdYuCxBI6w8kzQ97DK2pahdNC2GMTMZxUPtNFV3V
 LLQV/H6MEbACeN8wjhvUIUKuci3JbdM+fl4s62xn4xU43M3SJv2wIZ//j6U4O3CPEecY
 7N19wfp+ZQtjv5pdlUGtM1MWEiR3ocDF/03JAZiX/RJnuiwjkPDe85IwBfKw7MRBEbG/
 XPJOmDyBqwAt94b7I2gY0y5cUN78Rznvo1opuHsPZ6ZhouRetkS4hZGPFPXdrpiU7pYD
 EgHyYQDYHgOFnNPXHJYssB+VgwFihUyhkxftam5geirDnzqm/5W3tbNsKh/XvfbVFWBq
 hW9Q==
X-Gm-Message-State: AOJu0Yys8siYnA5m/+raN6k4f6yUEXVJUODJpbGkDSKADgv/MCh8alG7
 cCjcUcLtF/XyL34s1D/qf1Uc912uSeGgl9i3B5cy5A==
X-Google-Smtp-Source: AGHT+IG9YJw6EdIbZHtelRGK4/qjFVqR63vw+xZEZl59YyFWlu8pnTxzYjXtoGIwYwyTk/JCn/DBIZ7e2FP3WifW8aM=
X-Received: by 2002:a67:c38b:0:b0:45d:9e12:a9eb with SMTP id
 s11-20020a67c38b000000b0045d9e12a9ebmr308593vsj.11.1698995871673; Fri, 03 Nov
 2023 00:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
 <20231025-b4-qcom-pinctrl-v1-3-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-3-9123d6a217eb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Nov 2023 12:47:40 +0530
Message-ID: <CAFA6WYOxcytSym6-dumkm943UBM0wX+zNb-w5CFDp=-cmzVmzQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] pinctrl: qcom: handle reserved ranges
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 31 Oct 2023 at 19:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Some Qualcomm boards feature reserved ranges of pins which are protected
> by firmware. Attempting to read or write any registers associated with
> these pins results the board resetting.

Does any of the current Qcom boards supported in u-boot require this
feature? If not then you should introduce this feature alongside the
new Qcom boards requiring this feature.

-Sumit

>
> Add support for parsing these ranges from devicetree and ensure that the
> pinctrl and GPIO drivers don't try to interact with these pins.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/msm_gpio.c             | 15 +++++++++
>  drivers/pinctrl/qcom/pinctrl-qcom.c | 64 +++++++++++++++++++++++++++++++++++++
>  include/qcom-gpio.h                 | 15 +++++++++
>  3 files changed, 94 insertions(+)
>
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 7d77776a25fd..7a09abdafb2e 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -39,6 +39,9 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +               return 0;
> +
>         /* Disable OE bit */
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
>                         GPIO_OE_MASK, GPIO_OE_DISABLE);
> @@ -50,6 +53,9 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +               return 0;
> +
>         value = !!value;
>         /* set value */
>         writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -62,6 +68,9 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +               return 0;
> +
>         value = !!value;
>         /* set value */
>         writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -76,6 +85,9 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +               return 0;
> +
>         return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
>  }
>
> @@ -83,6 +95,9 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +               return GPIOF_UNKNOWN;
> +
>         if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
>                 return GPIOF_OUTPUT;
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index fb255f9572f4..92b35c198788 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -20,9 +20,13 @@
>
>  #include "pinctrl-qcom.h"
>
> +#define MSM_PINCTRL_MAX_RESERVED_RANGES 32
> +
>  struct msm_pinctrl_priv {
>         phys_addr_t base;
>         struct msm_pinctrl_data *data;
> +       u32 reserved_ranges[MSM_PINCTRL_MAX_RESERVED_RANGES * 2];
> +       int reserved_ranges_count;
>  };
>
>  #define GPIO_CONFIG_REG(priv, x) \
> @@ -61,13 +65,53 @@ static const char *msm_get_function_name(struct udevice *dev,
>         return priv->data->get_function_name(dev, selector);
>  }
>
> +static int msm_pinctrl_parse_ranges(struct udevice *dev)
> +{
> +       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       int count;
> +
> +       if (ofnode_read_prop(dev_ofnode(dev), "gpio-reserved-ranges",
> +                            &count)) {
> +               if (count % 2 == 1) {
> +                       dev_err(dev, "gpio-reserved-ranges must be a multiple of 2\n");
> +                       return -EINVAL;
> +               }
> +               /* Size is in bytes, but we're indexing by ints */
> +               count /= 4;
> +
> +               if (count > MSM_PINCTRL_MAX_RESERVED_RANGES) {
> +                       dev_err(dev, "gpio-reserved-ranges must be less than %d (got %d)\n",
> +                               MSM_PINCTRL_MAX_RESERVED_RANGES, count);
> +                       return -EINVAL;
> +               }
> +
> +               priv->reserved_ranges_count = count;
> +               for (count = 0; count < priv->reserved_ranges_count; count++) {
> +                       if (ofnode_read_u32_index(dev_ofnode(dev), "gpio-reserved-ranges",
> +                                                 count, &priv->reserved_ranges[count])) {
> +                               dev_err(dev, "failed to read gpio-reserved-ranges[%d]\n", count);
> +                               return -EINVAL;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int msm_pinctrl_probe(struct udevice *dev)
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       int ret;
>
>         priv->base = dev_read_addr(dev);
>         priv->data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
>
> +       ret = msm_pinctrl_parse_ranges(dev);
> +       if (ret) {
> +               printf("Couldn't parse reserved GPIO ranges!\n");
> +               return ret;
> +       }
> +
>         return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
>  }
>
> @@ -83,6 +127,9 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev, pin_selector))
> +               return 0;
> +
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>                         TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
>                         priv->data->get_function_mux(func_selector) << 2);
> @@ -94,6 +141,9 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>
> +       if (msm_pinctrl_is_reserved(dev, pin_selector))
> +               return 0;
> +
>         switch (param) {
>         case PIN_CONFIG_DRIVE_STRENGTH:
>                 argument = (argument / 2) - 1;
> @@ -178,3 +228,17 @@ U_BOOT_DRIVER(qcom_pinctrl) = {
>         .ops            = &msm_pinctrl_ops,
>         .probe          = msm_pinctrl_probe,
>  };
> +
> +bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
> +{
> +       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       unsigned int i, start;
> +
> +       for (i = 0; i < priv->reserved_ranges_count; i += 2) {
> +               start = priv->reserved_ranges[i];
> +               if (pin >= start && pin < start + priv->reserved_ranges[i + 1])
> +                       return true;
> +       }
> +
> +       return false;
> +}
> diff --git a/include/qcom-gpio.h b/include/qcom-gpio.h
> index 8dac62f870b9..490a1de55f89 100644
> --- a/include/qcom-gpio.h
> +++ b/include/qcom-gpio.h
> @@ -25,4 +25,19 @@ static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selecto
>         return out;
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
>
> --
> 2.42.0
>
