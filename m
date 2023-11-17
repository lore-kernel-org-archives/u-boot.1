Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B61C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 05:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D418A86F1E;
	Fri, 17 Nov 2023 06:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gUaINCrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7810586F42; Fri, 17 Nov 2023 06:27:34 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C8A86E37
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4ac985ea4bbso599373e0c.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700198846; x=1700803646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1hsU4HUM2S3Wybuzgv8Fpf2q94mllnigu+bqL1w88B0=;
 b=gUaINCrFPXl6l+cdKw2X2jFLvbzSSw5+5TwrXQw0WAfj3qCSmNZYCjMvCVoCUW0igJ
 mDAKw7nZCc0vOszQMX1gldYbOsg6R9CAqC7H/07r0Qm7Br/Mm5XHkyVrx2oNU/eN20Xp
 wUONuYaSPkbthuCiLx223aRTeJxV89dQmZQk3F2zY7dRBW+nqIhjBYA/Ajo03Y1RoerE
 XXR3CnW2slqtmU/wEcLkyD6y0KOXwQgxXtVJgo6A4kKhiSpAGOOVH3YWYHqT3h6xrWUO
 ZsgJ/zv6Q+is7P3PDeIXehTJZ54x908g7D8LHqJMipBuhVzO6TCqP5ENgQds5oxdY0lb
 VGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700198846; x=1700803646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hsU4HUM2S3Wybuzgv8Fpf2q94mllnigu+bqL1w88B0=;
 b=uKGXoMfvnVstNZFKAzMaU+2ep3dJz+xwyjANrmUDXO92dh4ffSrKXg+me/9eJrZg8J
 HHIrbeN5cJFT+gb1c7YXsyFjczOLdh3sHi8GXjiORwhhe5w37sTH0nF42D6c+ubyJ+b1
 SoWElucMkY6uCbPzwBi2nPgpwYyJgZn6v1Yu1g8t64+GlyZBuVMD4gerUdQzVXAhNcuB
 G/As0ai5LmFUnX4Ho6ocfxI2x1+q2R4Rkap6Auroi/YWA3pO8EBDLsQGQKheWwTHjuCx
 z6sEk8LmWD/g5mU4hQVOOkvEnpgqnx72OWH0M3xeehIi6ZNMrAxjU7jeNswADUog5CJp
 92aw==
X-Gm-Message-State: AOJu0Yx9R3xzXu3e/w473iTgWEDObDNfeKON+thO+0iWlab9n0+4ZSIT
 0fOQ5UMCfjPF5JL5cbWFNAkOtZL1VH8xPBGcqphkiA==
X-Google-Smtp-Source: AGHT+IFafTyxar0DTHiXGPa5NlJdsyNqkR19vk4JVIbuxkPXyobIA3sxAdfMYUA8Xn29KyDgNJ+VBbXlu1dYl31uCxU=
X-Received: by 2002:a05:6122:180d:b0:49b:289a:cc4a with SMTP id
 ay13-20020a056122180d00b0049b289acc4amr20633271vkb.3.1700198846551; Thu, 16
 Nov 2023 21:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-3-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-3-88a92f8f00ba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 17 Nov 2023 10:57:15 +0530
Message-ID: <CAFA6WYNC4zL5z9KqvCWCXp1Cn1CFxTHaxoipu-vBT7BfCDAyjA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: qcom_pmic: fix support for upstream DT
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
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

On Tue, 14 Nov 2023 at 19:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Linux devicetrees use the "gpio-ranges" property, add support for
> parsing it instead of "gpio-count" so that upstream DTs can be used with
> U-Boot.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard410c.dts |  3 +--
>  arch/arm/dts/dragonboard820c.dts |  3 +--
>  arch/arm/dts/qcs404-evb.dts      |  2 +-
>  arch/arm/dts/sdm845.dtsi         |  3 +--
>  drivers/gpio/qcom_pmic_gpio.c    | 38 ++++++++++++++++++++++++++++++--------
>  5 files changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index c41fee977813..6a4e3ccf17b1 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -170,9 +170,8 @@
>                                         compatible = "qcom,pm8916-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <4>;
> +                                       gpio-ranges = <&pm8916_gpios 0 0 4>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name="pmic";
>                                 };
>                         };
>
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 0d9c9f7a4922..146a0af8aafe 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -132,9 +132,8 @@
>                                         compatible = "qcom,pm8994-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <24>;
> +                                       gpio-ranges = <&pm8994_gpios 0 0 22>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name="pm8994.";
>                                 };
>                         };
>
> diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
> index 84224a8a3d39..3bb580ba4e17 100644
> --- a/arch/arm/dts/qcs404-evb.dts
> +++ b/arch/arm/dts/qcs404-evb.dts
> @@ -378,7 +378,7 @@
>                                         compatible = "qcom,pms405-gpio";
>                                         reg = <0xc000 0x400>;
>                                         gpio-controller;
> -                                       gpio-count = <12>;
> +                                       gpio-ranges = <&pms405_gpios 0 0 12>;
>                                         #gpio-cells = <2>;
>                                         gpio-bank-name="pmic";
>                                 };
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index cd5d890e9a45..a26e9f411ee0 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -103,9 +103,8 @@
>                                         compatible = "qcom,pm8998-gpio";
>                                         reg = <0xc000 0x1a00>;
>                                         gpio-controller;
> -                                       gpio-count = <21>;
> +                                       gpio-ranges = <&pm8998_gpios 0 0 26>;
>                                         #gpio-cells = <2>;
> -                                       gpio-bank-name = "pm8998.";
>                                 };
>                         };
>
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 7b83c67fa464..f2424766e5cc 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -245,23 +245,45 @@ static int qcom_gpio_probe(struct udevice *dev)
>         return 0;
>  }
>
> +/*
> + * Parse basic GPIO count specified via the gpio-ranges property
> + * as specified in Linux devicetrees
> + * Returns < 0 on error, otherwise gpio count
> + */
> +static int qcom_gpio_of_parse_ranges(struct udevice *dev)
> +{
> +       int ret;
> +       struct ofnode_phandle_args args;
> +
> +       ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
> +                                            NULL, 3, 0, &args);
> +       if (ret)
> +               return log_msg_ret("gpio-ranges", ret);
> +
> +       return args.args[2];
> +}
> +
>  static int qcom_gpio_of_to_plat(struct udevice *dev)
>  {
>         struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +       int ret;
>
> -       uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
> -       uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
> -       if (uc_priv->bank_name == NULL)
> -               uc_priv->bank_name = "qcom_pmic";
> +       ret = qcom_gpio_of_parse_ranges(dev);
> +       if (ret > 0)
> +               uc_priv->gpio_count = ret;
> +       else
> +               return ret;
> +
> +       uc_priv->bank_name = (const char *)dev->driver_data;

Do you see any value add for users to know the underlying PMIC chip id
for GPIO bank_name? To me it is sufficient to just say that these
GPIOs are coming from PMIC. In Linux I do see the driver data being
used as an alternative way to provide GPIO count for older devicetree
which doesn't provide "gpio-ranges" but I don't think that will be the
case for u-boot. However, we can leave driver_data empty if it's not
really needed.

-Sumit

>
>         return 0;
>  }
>
>  static const struct udevice_id qcom_gpio_ids[] = {
> -       { .compatible = "qcom,pm8916-gpio" },
> -       { .compatible = "qcom,pm8994-gpio" },   /* 22 GPIO's */
> -       { .compatible = "qcom,pm8998-gpio" },
> -       { .compatible = "qcom,pms405-gpio" },
> +       { .compatible = "qcom,pm8916-gpio", .data = (ulong)&"pm8916_gpio" },
> +       { .compatible = "qcom,pm8994-gpio", .data = (ulong)&"pm8994_gpio" },
> +       { .compatible = "qcom,pm8998-gpio", .data = (ulong)&"pm8998_gpio" },
> +       { .compatible = "qcom,pms405-gpio", .data = (ulong)&"pms405_gpio" },
>         { }
>  };
>
>
> --
> 2.42.1
>
