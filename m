Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7AFC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62705880E9;
	Wed, 20 Mar 2024 06:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ctHkKrQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777E2880E1; Wed, 20 Mar 2024 06:44:31 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BA1880EB
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-472967264e7so2247584137.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913467; x=1711518267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6QT9oIySL85yE0QRnfNOgFMl43P8UI97mEwkEEuNgBc=;
 b=ctHkKrQXLtd6A1vnEbzyfqVT8ThcUxs4KHp0Xhmaxc9ZdV5Br/kPOwQIomyeEyiJjY
 gO4COlt9w4W4bMdDk5snWXomId9jHDdXM3HZlIKQoWIdfX9bEJouD5o3L4fSv00kwsOv
 0DmDiSwSml0u9xLcHPAqcAse1OxqBE0C8unk0LqGez7BGL8Izq0cdKC199Pt2vHnHF93
 OG6qVI+xayLMxd5Fc7WMyNsIQFuOXnVycw0PZ4LJZG8K2Zh4sT8vmEovPwSAP76shzgR
 2ElfG1Rtpl13yA9Yyg23fPU7laXWdR+Vczr73XBPG0O+BmzU0l+p6dZLEp+9GIuVVFJj
 p8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913467; x=1711518267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QT9oIySL85yE0QRnfNOgFMl43P8UI97mEwkEEuNgBc=;
 b=aXt2lD8mdSvpAJ2SwYdH4bHHz+7+ScGHFJ+Qb2p7Cfw/ceonIJ7jolpeeXl+fLRn8E
 4QtnKlC/pNc/DgN/0EYUVorkYUK11HAQl1/O9doo5pN6lRdn+eSvcmkawCSd1bHqSBUV
 +8rXyFInRzD3E5jiBUEkJN+CkiOo6ojdoZYrhkEVe1dTeuSzHSzEBRDV5Wlest1DEOoD
 sEbpqNWxcVONYUIcS9wsUeMRM04hK0vYLL6I+f/GFPsp+U0dPDuu0merABC6dNGUZFaf
 ar4GTDirrblIzEpikMi8Zku/DDMruksOsXKMVGNDPMnrACbhS3AeCYhmtQouPOSzh6Bs
 ws0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVfcWd+6r9XtbHLWzjH8hSWAhit6cspLTCt739ItoyevC782dcuo7xDRIXgSDs//H2BZ6i7Rfb8xnF9J94VAJLnuRaIQ==
X-Gm-Message-State: AOJu0YyzhxzB4FsZPxRXR7w1lcz5yb2LBVm1P3lY1OXx7Gmh9a8l9o/W
 jhAoVJJMvWu8xmm3uibHmelhaNHnjdZjUrYAtrNt7pmp9Ta4U+ms6Bw19ncTjSLMajhdD37mSbi
 o0Ng6FQb+L2UWpYwSzdjgCsgcmI8RX6OfiimAsw==
X-Google-Smtp-Source: AGHT+IHGIOwugc2aL0/nMc8nMXk0tduX5KMN7/5WjeKVta6YhdSsseHjw8J6Gq/dbu2WttGQpsAemm7rRtLZoVdces0=
X-Received: by 2002:a05:6102:190a:b0:476:8b82:8efd with SMTP id
 jk10-20020a056102190a00b004768b828efdmr921433vsb.23.1710913466854; Tue, 19
 Mar 2024 22:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-8-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-8-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:14:16 +0530
Message-ID: <CAFA6WYPofhP37REb5eqL+GUqtcf9HL1yHcO+jFQBBQjNKL4Kxg@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] gpio: msm_gpio: add .set_flags op
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The .direction_input and .direction_output ops are deprecated, and don't
> seem to behave properly for us. Implement our own .set_flags op to
> handle this correctly.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/msm_gpio.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 5e57b0cbde75..f5d9ab54e817 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -34,21 +34,21 @@ struct msm_gpio_bank {
>
>  #define GPIO_IN_OUT_REG(dev, x) \
>         (GPIO_CONFIG_REG(dev, x) + 0x4)
>
> -static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
> +static void msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
>         /* Always NOP for special pins, assume they're in the correct state */
>         if (qcom_is_special_pin(priv->pin_data, gpio))
> -               return 0;
> +               return;
>
>         /* Disable OE bit */
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
>                         GPIO_OE_MASK, GPIO_OE_DISABLE);
>
> -       return 0;
> +       return;
>  }
>
>  static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>  {
> @@ -83,8 +83,25 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>
>         return 0;
>  }
>
> +static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
> +{
> +       if (flags & GPIOD_IS_OUT_ACTIVE) {
> +               return msm_gpio_direction_output(dev, gpio, 1);
> +       } else if (flags & GPIOD_IS_OUT) {
> +               return msm_gpio_direction_output(dev, gpio, 0);
> +       } else if (flags & GPIOD_IS_IN) {
> +               msm_gpio_direction_input(dev, gpio);
> +               if (flags & GPIOD_PULL_UP)
> +                       return msm_gpio_set_value(dev, gpio, 1);
> +               else if (flags & GPIOD_PULL_DOWN)
> +                       return msm_gpio_set_value(dev, gpio, 0);
> +       }
> +
> +       return 0;
> +}
> +
>  static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> @@ -109,12 +126,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>         return GPIOF_INPUT;
>  }
>
>  static const struct dm_gpio_ops gpio_msm_ops = {
> -       .direction_input        = msm_gpio_direction_input,
> -       .direction_output       = msm_gpio_direction_output,
> +       .set_flags              = msm_gpio_set_flags,
>         .get_value              = msm_gpio_get_value,
> -       .set_value              = msm_gpio_set_value,
>         .get_function           = msm_gpio_get_function,
>  };
>
>  static int msm_gpio_probe(struct udevice *dev)
>
> --
> 2.44.0
>
