Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2846C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FD787F73;
	Tue, 20 Feb 2024 07:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A3crIeYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F27C87F84; Tue, 20 Feb 2024 06:58:43 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5315C87F84
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d625a3ace6so3419062241.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408617; x=1709013417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L6ztb93krhGcmvnSzC+lFo8Mnfdjmd3cmOsuNsp1ipE=;
 b=A3crIeYAVTiP0pnEjwVXmAjBtEBN7/4/C5IkUDtIz7l/GpFwdldipeVeVHoVAK1l4S
 bM6e2+vP+tT/4YqLVvAMJykZmn2OPgy0ZcQWcGajTqaRdmZX7Fixnw4vWBeVJzlMnS0w
 tvyikymk6EeXrwIDli7TviZswhV3msgcfuC5xiPKQ88+t9VQowo9I6M0bXrUsqGgMuhb
 B0+W+Vta3fxAK++YeWTOnsyT+X7AvqnRhdfqqJr9AzLfM1M79nEl3jiTeFuk8HMaib7z
 yK7vN9WZUEBVwdbeoGhA6JFEqY7x08U+Y5q6TM5IYcOS4uXyWCBoS5xjNG+FZ+cIUSzN
 gNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408617; x=1709013417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6ztb93krhGcmvnSzC+lFo8Mnfdjmd3cmOsuNsp1ipE=;
 b=E1Did3NR/7MXuEAATWfWnP4qrSD/teONuHwlWNJEdSOksBOjEpXIOL8loUw+Ohc/vi
 TZltqwkGo9Tde3LKydKdoObVE1P2/mnHcHu9KBddWm4lnV6b59Lt2SyJCg7azoMwoBer
 +TRl4h58tNTqyVFl9YNaUNXyrRuizwGBJofekUEJjYvUxClpeNaW5eDANawchYkUeDmG
 zYJUueepezRca5+xWz7nwUeFq13W9YqWkPKaEqhltdg9kq5ItjifxbseqI1iXkVXF/sm
 YgxXhL68Xjqzx27vZk6CqnN89/A9DqOADUnRlDXqMEXRriyh5yyXOD1MQ0oq/9lYKu+2
 i+EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5xLx7M+vIvqSDQJm18YxoG30qTq9/svkaN11RTCkCGALumwIirhmKqfeDCgJqpavXXrLF3qBtH2CvXU4dG9syHl9e9Q==
X-Gm-Message-State: AOJu0Yx2lhE5KPGGubmgA7OcnpNpHEXNjii3SshdKcYfOgzVYWxJDipi
 pWRzw/xbLRNATBBcA476nBh2rZxWSfl7A7BjnkP8IMn/LDTIdA5PdAsQWeTw8Tggm9FCzeFjYBz
 s4+dT++y/DOu6Zf2qXWWX1fM2T/3pj+LzeW0Vlg==
X-Google-Smtp-Source: AGHT+IFeoJD9/coWCx5gzw86cGw2i6YXMefsxl1d10k8CNrKxwZXCtbRxxCLJK7n5KdvBggFYiB/oB3bQDuV8fknq5Y=
X-Received: by 2002:a67:fe4e:0:b0:470:5b27:dc82 with SMTP id
 m14-20020a67fe4e000000b004705b27dc82mr3169113vsr.8.1708408617353; Mon, 19 Feb
 2024 21:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-10-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-10-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:26:46 +0530
Message-ID: <CAFA6WYN9JZPO6OjfMOVj6qHRK7fp+5aVCth3ppAMv1L8xNypXA@mail.gmail.com>
Subject: Re: [PATCH v4 10/39] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
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
> Some platforms hard reset when attempting to configure PMIC GPIOs. Add
> support for quirks specified in match data with a single quirk to skip
> this configuration. We rely on the GPIO already be configured correctly,
> which is always the case for volume up (the only current user of these
> GPIOs).

I can't find a similar quirk in the counterpart Linux driver
(drivers/pinctrl/qcom/pinctrl-spmi-gpio.c). Is there anything we are
missing in the U-Boot driver?

-Sumit

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 2a4fef8d28cb..198cd84bc31e 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -64,6 +64,15 @@
>  #define REG_EN_CTL             0x46
>  #define REG_EN_CTL_ENABLE      (1 << 7)
>
> +/**
> + * pmic_gpio_match_data - platform specific configuration
> + *
> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them
> + */
> +enum pmic_gpio_quirks {
> +       QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> +};
> +
>  struct qcom_gpio_bank {
>         uint32_t pid; /* Peripheral ID on SPMI bus */
>         bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> @@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
>         struct qcom_gpio_bank *priv = dev_get_priv(dev);
>         uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
>         uint32_t reg_ctl_val;
> -       int ret;
> +       ulong quirks = dev_get_driver_data(dev);
> +       int ret = 0;
> +
> +       /* Some PMICs don't like their GPIOs being configured */
> +       if (quirks & QCOM_PMIC_QUIRK_READONLY)
> +               return 0;
>
>         /* Disable the GPIO */
>         ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
> @@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
>  static const struct udevice_id qcom_gpio_ids[] = {
>         { .compatible = "qcom,pm8916-gpio" },
>         { .compatible = "qcom,pm8994-gpio" },   /* 22 GPIO's */
> -       { .compatible = "qcom,pm8998-gpio" },
> +       { .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
>         { .compatible = "qcom,pms405-gpio" },
>         { }
>  };
>
> --
> 2.43.1
>
