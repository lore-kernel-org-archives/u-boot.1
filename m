Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC91CC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA0987D7E;
	Wed,  6 Mar 2024 07:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e3/fZp/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB1D87D64; Wed,  6 Mar 2024 07:22:05 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BF487D90
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7dac7cfbea0so1185182241.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 22:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709706121; x=1710310921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltOz7k0UQpDC3TSw26qVKCMig4LRQNCJY44cpclHtnQ=;
 b=e3/fZp/8fH3DDUL+8Wkxn0zi1Ih8OtNO/5NB8UV0HgKkHCxkUGTNvtbfnD+IYGecw6
 iPmM0gN6Opzk/ZspzYS0oMFwEP9THIghzm8K5U8Z8KfwqDI3Ub/JS0q8Cv+uZz1Susvl
 Ml1I7onGorEEQ6vS+SgMe3eLse2+8LfziNP6tPEPVScQdt2d6C2mkcnIbOT0yY503Gvt
 d0hFE8zdRh00i0qev9HNF/BsLVtlAh1J1XO8N7rJdESt/8sjcrklnj+mWyWdGqf2gRRi
 jl+cQVCguHDYpTmHEubi4SO+Fgr2ZEONVQHSny6wU+RLWn/IGmGXOUqZCh1+CWARP066
 IqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709706121; x=1710310921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltOz7k0UQpDC3TSw26qVKCMig4LRQNCJY44cpclHtnQ=;
 b=Vu0RaJJFmWZMN+zIObpcPHuRajr4XwhHk+ym1PRQwgopSSlm8ZS+tv2dv09ud48MyN
 5wHcC2d8l6HF/Hjm/tFoKPLzIcsiYlK8/WUyl5OkxmHruz9SJgsXwkoyVSUs9Pya/rKZ
 EoU0eKtvpkZntXLl7+QR6OXyzCGaQ9eqWgrcqkHKpDm3ft/dYUwh5y2o5IvRHFLrJB6n
 KUWN/yF4YyQ6WUROQFWhUxWhOwQH7rEPss0Ck4ugPDBvo7jRbn5K/ERM3jc9afwDbBpw
 1GZ8yNar20Dh6mUmkO7HkCW0qbxL6iyx9TiFjMUyQ/VVFlxtE8TSWGajZD0lQ51KLB/i
 jNww==
X-Gm-Message-State: AOJu0YyrJs4R1CYdgWg6v4yq/C04A4fP8jFNgw36EFdG7697KlQQ+BgW
 n8MG4fJfpPR19TDd2fycenewH3rUb42VOKDvbuDpJo94UcCSvGbTae8LOp5+MgBu2rxYuclNd6+
 H/qnc8Lg1Ik/TBVFctLPCaHb/812O+6m+4QDN+w==
X-Google-Smtp-Source: AGHT+IFYKpbtudDUa9l8sbJul7VNl0aih3A6i8O/D0E5NjZte3W5PomMbP4CHZy21elen/AItDiXGivH/JQmrsR69uo=
X-Received: by 2002:a05:6102:3574:b0:472:e7a8:e36b with SMTP id
 bh20-20020a056102357400b00472e7a8e36bmr2092741vsb.26.1709706121419; Tue, 05
 Mar 2024 22:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-7-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-7-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 11:51:50 +0530
Message-ID: <CAFA6WYPEOFCXemJSA-Oq93+BKKaFojsQe03doQ8Dz8mbB7qX2w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pinctrl: qcom: pass pin number to get_function_mux
 callback
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> This patch is the preparation for SM8150 support. This new SoC
> depending on the particular pin can have different numbers for the
> same function. For example "rgmii" function for GPIO4 has id=2 while
> for GPIO59 it has id=1. So, to support this type of SoCs,
> get_function_mux() callback needs to know for which pin the function
> is requested.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>
> ---
>
> Changes in v2:
>  - Added Caleb's R-b tag
>
>  drivers/pinctrl/qcom/pinctrl-apq8016.c | 3 ++-
>  drivers/pinctrl/qcom/pinctrl-apq8096.c | 3 ++-
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c | 3 ++-
>  drivers/pinctrl/qcom/pinctrl-qcom.c    | 4 ++--
>  drivers/pinctrl/qcom/pinctrl-qcom.h    | 3 ++-
>  drivers/pinctrl/qcom/pinctrl-qcs404.c  | 3 ++-
>  drivers/pinctrl/qcom/pinctrl-sdm845.c  | 3 ++-
>  7 files changed, 14 insertions(+), 8 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index db0e212468..a9a00f4b08 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -49,7 +49,8 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>         }
>  }
>
> -static unsigned int apq8016_get_function_mux(unsigned int selector)
> +static unsigned int apq8016_get_function_mux(__maybe_unused unsigned int pin,
> +                                            unsigned int selector)
>  {
>         return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index 880df8fe3c..9697cb5beb 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -44,7 +44,8 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>         }
>  }
>
> -static unsigned int apq8096_get_function_mux(unsigned int selector)
> +static unsigned int apq8096_get_function_mux(__maybe_unused unsigned int pin,
> +                                            unsigned int selector)
>  {
>         return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index 74c04ab87c..4479230313 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -40,7 +40,8 @@ static const char *ipq4019_get_pin_name(struct udevice *dev,
>         return pin_name;
>  }
>
> -static unsigned int ipq4019_get_function_mux(unsigned int selector)
> +static unsigned int ipq4019_get_function_mux(__maybe_unused unsigned int pin,
> +                                            unsigned int selector)
>  {
>         return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index ee0624df29..909e566acf 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -83,14 +83,14 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>                           unsigned int func_selector)
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       u32 func = priv->data->get_function_mux(pin_selector, func_selector);
>
>         /* Always NOP for special pins, assume they're in the correct state */
>         if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
>                 return 0;
>
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> -                       TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
> -                       priv->data->get_function_mux(func_selector) << 2);
> +                       TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE, func << 2);
>         return 0;
>  }
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
> index 07f2eae9ba..49b7bfbc00 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.h
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
> @@ -18,7 +18,8 @@ struct msm_pinctrl_data {
>         int functions_count;
>         const char *(*get_function_name)(struct udevice *dev,
>                                          unsigned int selector);
> -       unsigned int (*get_function_mux)(unsigned int selector);
> +       unsigned int (*get_function_mux)(unsigned int pin,
> +                                        unsigned int selector);
>         const char *(*get_pin_name)(struct udevice *dev,
>                                     unsigned int selector);
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index 3a2d468599..4b7c670c90 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -94,7 +94,8 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>         }
>  }
>
> -static unsigned int qcs404_get_function_mux(unsigned int selector)
> +static unsigned int qcs404_get_function_mux(__maybe_unused unsigned int pin,
> +                                           unsigned int selector)
>  {
>         return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 76bd8c4ef4..459a4329ec 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -70,7 +70,8 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
>         return pin_name;
>  }
>
> -static unsigned int sdm845_get_function_mux(unsigned int selector)
> +static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pin,
> +                                           unsigned int selector)
>  {
>         return msm_pinctrl_functions[selector].val;
>  }
> --
> 2.43.0
