Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3375C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D81F87F6A;
	Tue, 20 Feb 2024 06:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HbN/Bnvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E7187F81; Tue, 20 Feb 2024 06:49:44 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF02F87F83
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7d60ee03b54so1763181241.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408079; x=1709012879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlnYNOicLw6C+SLEuGpI6Dai7RoMqutriQVe7u3Z6Q8=;
 b=HbN/Bnvh4JEnY8p9Z2KPKzweDdWaoWN2moQn1Z/pMTq2PbUV9IMAikc9o7bmeytrUp
 rZolJjY1WYNai9ZdA5bNO2+y/aSFObKATxIFJb1sWoCRVNddyngew+ghx9uZqpaL8pH0
 X51/UEoLl+I350dUwkhTYF2xTa/3wUjaCxq2bgjtYHCzHJmUXQDn1JoEOpHfrXyv6qGd
 xrQ7cga7A7ViGQEu0tcENKCWH42PumkPoFNGJG+EZVOenzIuL3jNvRhh5RToLpKsMZBI
 kSVqOrV2Qc4cfqO7i/sY9PsXzInoFvjks7CzjGsFQdA7fZ5Qx7PMpSFVCCL30kCyFqce
 P7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408079; x=1709012879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlnYNOicLw6C+SLEuGpI6Dai7RoMqutriQVe7u3Z6Q8=;
 b=UPPWNMHoFEUQUqqAOvD0E0I2nWcXiuImxp9+T1AD/MlueUu48OKZq6+OUu3GyFioyG
 l1jIJRJ2DCypfp0Tk8rm+26Bd+lAhifnXygQhVXd+sn4y+6urxTBvp/ZbzCr1VnjrbYn
 /n4zXbrJlfOGuR6R37F3d3K97KZgyHri9adADwkQXexImZjkLbO/qIY0SSm9mloBnifu
 emCAky6MnbG0kk4pqWCILv8+LTHv2xeK7pVwNxpN4uT3D51Va8OapzzPk/o0SuAXfD8c
 JEQ+OSBITBLKg7U3uHG/XcTT6NP6hV2lKpxEHWgdB6WB+JXTZPYl15scwMH4poXn46+v
 5FEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRKc0ILQAWJZgeLG8zeeSOUYGuTRoHZB9DnX2L9fj8GdO/Y/09O12zh0+CTQyO8RaIvt2e+UAPkF8gYmG6dOQy2IhMAg==
X-Gm-Message-State: AOJu0YwUerFon0BAd4HNoUhnXtXVcvtMy4umfyC578vy8AzC6rQ1eUQ5
 zckqgvGaIX0z/KQhrU7t/pSI8+eP0dhyf9kNEOG1gzLIZL89UFzuzm3wA1GrBVb6bOwiMNwQNbj
 9UTR7Kysb8vEQOkp09OUw6uyit69Dewo3VYkyoQ==
X-Google-Smtp-Source: AGHT+IFTRwuUGVoBUjjMKggHSAfMJ6t683b24kC5sdk6k86mLfnGwWnGlj0ATitygultH6TqFYKtEGL3U0H4u5CP8cU=
X-Received: by 2002:a67:f519:0:b0:470:5503:60e5 with SMTP id
 u25-20020a67f519000000b00470550360e5mr3033890vsn.35.1708408078814; Mon, 19
 Feb 2024 21:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-9-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-9-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:17:47 +0530
Message-ID: <CAFA6WYO2CCzx5MPCi7FMpWFU2WWUiBK6ZZoc+7bKCwZjK44BWA@mail.gmail.com>
Subject: Re: [PATCH v4 09/39] gpio: qcom_pmic: 1-based GPIOs
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
> Qualcomm PMICs number their GPIOs starting from 1, implement a custom
> .xlate method to handle this.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 6167c8411678..2a4fef8d28cb 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -209,12 +209,34 @@ static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
>                                        REG_CTL_OUTPUT_MASK, !!value);
>  }
>
> +static int qcom_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
> +                          struct ofnode_phandle_args *args)
> +{
> +       struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +
> +       if (args->args_count < 1)
> +               return -EINVAL;
> +
> +       /* GPIOs in DT are 1-based */
> +       desc->offset = args->args[0] - 1;
> +       if (desc->offset >= uc_priv->gpio_count)
> +               return -EINVAL;
> +
> +       if (args->args_count < 2)
> +               return 0;
> +
> +       desc->flags = gpio_flags_xlate(args->args[1]);
> +
> +       return 0;
> +}
> +
>  static const struct dm_gpio_ops qcom_gpio_ops = {
>         .direction_input        = qcom_gpio_direction_input,
>         .direction_output       = qcom_gpio_direction_output,
>         .get_value              = qcom_gpio_get_value,
>         .set_value              = qcom_gpio_set_value,
>         .get_function           = qcom_gpio_get_function,
> +       .xlate                  = qcom_gpio_xlate,
>  };
>
>  static int qcom_gpio_probe(struct udevice *dev)
>
> --
> 2.43.1
>
