Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2609DC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACB987D2C;
	Tue, 20 Feb 2024 14:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TJGObV0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C91587D70; Tue, 20 Feb 2024 14:23:12 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36E287C13
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4704f3e2a99so396509137.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708435371; x=1709040171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ekxk/z/WUmDuMQO/AjNvmJ1hdWe/mt1eDMy96YOWPMQ=;
 b=TJGObV0RqnOTlkbVyCu9VfhHQYNXI0oBnbBom7kp+1fI/JfHSMKqkPAv05QUi+Nqce
 //DMjw8BrbhqVdNIAxV86PcZ6GORz9LCXTVcoH+o4UnYvioyEVqgouumRCEUv7ABpKKZ
 hXctXLK+76mfjpzscBDwzKhhNZEo0U0+loI5Kt+7Jbs63uizdiblZxiTQx3NnFEC5/dO
 9qw49HqpAd42GKmiV1NnlAGLA0khaKSlR7MbNS7/mGJACchVEWDb3P2AQomPM0UGOIrv
 fQ+CgL6akzwYAJrGj1jVNBq5vx1UzgeL2zf1RfeZvyJRYt7ev5HiEi+wgERD5AgUQOf1
 aP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435371; x=1709040171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ekxk/z/WUmDuMQO/AjNvmJ1hdWe/mt1eDMy96YOWPMQ=;
 b=JoYv72CAYwLHO+TDFEd6AsDJJUYAhyhpOyKlnnU0JdRgWKOLxiKoGyCBb81KzdQmWu
 WnlwlS36C7ZPr2B9Q+LHKmXYsmFXpgzYygs4w8qb7lCpINcD3axfpGozX1xi8XUyRVaB
 cvg7NKeiqI13bpxc+UlJtkB/yl8c8rhdPjnjWpLtTI1RhCs2OH/+USl+tKt7rlfA1hXf
 6DgWg2EUTT2whFw1lrpC9/bl46t4clgbKK+g6IanEJecWVl7fSFj0r7O8hvG4HPtulS2
 63aAGq8mvHCw1JUHoEPMquqL+ZheLmSg9AJkM+r2hZ7kLhxvwywTFtbs0vQW2RPioYbd
 Ec5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrLiaL8wU2pmFC/nmx9fVccljlAPWOq8QBis65TpDR6Tp5y9f5JNguVOgt4KexJd/4SbKhHyQSkD7Cr/LrO7x7WxZdWQ==
X-Gm-Message-State: AOJu0YzoOIPNNsLj4a3UvdfHw2906XdANHH8jJMr7iRD0xovcnP2Qi5K
 ARI+K+0mhw3YcmrLEp7jpwnB4sbvZE6cJGABuOp6BhYWqtzDxU8Tvtq7s/93ZlLP56HOnZgz8Gv
 e6DfZYIkrf/bUYkqLEfKcf510TGrE6fItVKgfgA==
X-Google-Smtp-Source: AGHT+IGfw9yPD9OzaRC7ni3dya/B99vbLo5M3M75jw2HdtmJrydVWwIBghYSOrjIrfDNS0Um2Qo2b6qdZEgMoe02fV8=
X-Received: by 2002:a05:6102:30b1:b0:470:6bfc:b9af with SMTP id
 y17-20020a05610230b100b004706bfcb9afmr2129285vsd.2.1708435371391; Tue, 20 Feb
 2024 05:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-13-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-13-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 18:52:40 +0530
Message-ID: <CAFA6WYP3gtcTpXXtuwg6ckpXFuaC9WMfBL9j38iVidd4EEKg+g@mail.gmail.com>
Subject: Re: [PATCH v4 13/39] pinctrl: qcom: stub support for special GPIOs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Most platforms have a handful of "special" GPIOs, like the MMC
> clock/data lanes, UFS reset, etc. These don't follow the usually naming

s/usually/usual/

> scheme of "gpioX" and also have unique capabilities and registers. We
> can get away without supporting them all for now, but DT compatibility
> is still an issue.
>
> Add support for allowing these to be specified after the other pins, and
> make all pinmux/pinconf calls for them nop.

Yeah earlier incorrect configuration was done for these pins. So
having them nop is an improvement.

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/include/mach/gpio.h |  2 ++
>  drivers/gpio/msm_gpio.c                      | 20 ++++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-qcom.c          | 12 ++++++++++++
>  3 files changed, 34 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
> index 8dac62f870b9..c373f5a4cf3d 100644
> --- a/arch/arm/mach-snapdragon/include/mach/gpio.h
> +++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
> @@ -13,6 +13,8 @@
>  struct msm_pin_data {
>         int pin_count;
>         const unsigned int *pin_offsets;
> +       /* Index of first special pin, these are ignored for now */
> +       unsigned int special_pins_start;
>  };
>
>  static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 80cd28bb231f..8a5e8730e911 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -39,6 +39,10 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (gpio >= priv->pin_data->special_pins_start)
> +               return 0;
> +
>         /* Disable OE bit */
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
>                         GPIO_OE_MASK, GPIO_OE_DISABLE);
> @@ -50,6 +54,10 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (gpio >= priv->pin_data->special_pins_start)
> +               return 0;
> +
>         value = !!value;
>         /* set value */
>         writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -62,6 +70,10 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (gpio >= priv->pin_data->special_pins_start)
> +               return 0;
> +
>         value = !!value;
>         /* set value */
>         writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
> @@ -76,6 +88,10 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (gpio >= priv->pin_data->special_pins_start)
> +               return 0;
> +
>         return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
>  }
>
> @@ -83,6 +99,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (gpio >= priv->pin_data->special_pins_start)
> +               return 0;
> +
>         if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
>                 return GPIOF_OUTPUT;
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index dc3d8c4d9034..1ea4d21c41fc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -83,6 +83,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins, assume they're in the correct state */
> +       if (pin_selector >= priv->data->pin_data.special_pins_start)
> +               return 0;
> +
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>                         TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
>                         priv->data->get_function_mux(func_selector) << 2);
> @@ -94,6 +98,10 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>
> +       /* Always NOP for special pins */
> +       if (pin_selector >= priv->data->pin_data.special_pins_start)
> +               return 0;
> +
>         switch (param) {
>         case PIN_CONFIG_DRIVE_STRENGTH:
>                 argument = (argument / 2) - 1;
> @@ -136,6 +144,10 @@ int msm_pinctrl_bind(struct udevice *dev)
>         const char *name;
>         int ret;
>
> +       /* Make sure we don't indadvertently treat all pins as special pins. */
> +       if (!data->pin_data.special_pins_start)
> +               data->pin_data.special_pins_start = data->pin_data.pin_count;
> +
>         drv = lists_driver_lookup_name("pinctrl_qcom");
>         if (!drv)
>                 return -ENOENT;
>
> --
> 2.43.1
>
