Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4448C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 16:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADFE87DED;
	Fri,  1 Mar 2024 17:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZLx42KJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7B488142; Fri,  1 Mar 2024 17:28:10 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA1C87DE3
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 17:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso3441594a12.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709310488; x=1709915288; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZeV0vkq0n2CGddyng+/Wd98DWwboM6UUyr7tQ4TgwY=;
 b=ZLx42KJxAUlYBruEvQs2W4Lw5T8KKIVxGDS2SAxo/vCIfwoJnq4PlSKyoTCGoPupdi
 bnJCntScbOsLXrebf4RZRMUITwLzUvqqH26eP5Xqm+GPiiuF64G41cpkF4J9TzQJZpsD
 oEMVqpIw+91o/ReHCb3e5wrer/BjOpgMc9FjSPR1tQjcf5pUWPwIWDSQ6CKKo3GXpIpI
 jVoy1Lv2UC5siAG64flnAwsc1lrupNLqRHhTtCDA7ec1Dv5aMvPhgBYQss1M6XomN+/B
 5E3nb6KFRDSUk9BybV6t2i/gzFh0OhDXe+CRVJWRcaV99GRO46S+ABQmwyTI1LcAGG+l
 3/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709310488; x=1709915288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZeV0vkq0n2CGddyng+/Wd98DWwboM6UUyr7tQ4TgwY=;
 b=qI4aagQmw4brObnjWn/0bbL/XNCWCT8jk1kkmSFJ5gY6yn+7pNQgZJmfz0ZOdT9ltW
 uAdGWxpND8k9wSuN7sxpuVqIStc0bJv0k6xMkO6BoxjaOPD0uYrD/hFfXEezL4y0cZep
 HQtHmZyS0HkkXM16jpDn4L4iqH60GmlnLEI+Fmd2FObLl2RAjN3zl3QKM1hmJxQEbuT6
 CLUh1NKoHRnMzkx3p3kWUmRoyHnU9Ehe6DSUvzjV9E4NEVwte/otphJg5/+GOsuDT+M1
 erY/g8SY8Ixj70l7S/bS8haLmx5DfHCVA1rJRwwe3Cwm0114+81wsAU97x6klxBkvRac
 gA/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIDbAHNmwuafmksELQKQsKn02KdQmGahD9+HrnrZQgQETgbVAkwcLF+GYuYZ6FLPURCxYM/OGCH0alV7CXTjs9aZuhog==
X-Gm-Message-State: AOJu0YxqzFWN6qqJPU5bAFCbo4iVkvtGALaGh/3aSAFSbTSiiU3wBy/w
 se88rC1qH0WxUQCYl6KDyTAWPgiayYgk5trz0hpDZvHXBoEiHOdcttQoaD3Ct8c=
X-Google-Smtp-Source: AGHT+IHxRDLUh2MssxKJo9nx3fkq5XSgMMGmKM9OLZXzf5SrqXfDhv2XTT/s/W6qNeTP2j4mWP9HmA==
X-Received: by 2002:a05:6402:2683:b0:566:db5a:eae4 with SMTP id
 w3-20020a056402268300b00566db5aeae4mr1701432edd.16.1709310488109; 
 Fri, 01 Mar 2024 08:28:08 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a509305000000b0056676b80a38sm1776465eda.3.2024.03.01.08.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 08:28:07 -0800 (PST)
Message-ID: <7d67cef8-5505-4046-92ec-1d2bc24b204a@linaro.org>
Date: Fri, 1 Mar 2024 16:28:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] pinctr: qcom: pass pin number to get_function_mux
 callback
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-7-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240229142043.1263690-7-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 29/02/2024 14:21, Volodymyr Babchuk wrote:
> This patch is the preparation for SM8150 support. This new SoC
> depending on the particular pin can have different numbers for the
> same function. For example "rgmii" function for GPIO4 has id=2 while
> for GPIO59 it has id=1. So, to support this type of SoCs,
> get_function_mux() callback needs to know for which pin the function
> is requested.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
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
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 8149ffd83c..53042b6e05 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -49,7 +49,8 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>  	}
>  }
>  
> -static unsigned int apq8016_get_function_mux(unsigned int selector)
> +static unsigned int apq8016_get_function_mux(__maybe_unused unsigned int pin,
> +					     unsigned int selector)
>  {
>  	return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index d64ab1ff7b..8dcd171259 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -44,7 +44,8 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>  	}
>  }
>  
> -static unsigned int apq8096_get_function_mux(unsigned int selector)
> +static unsigned int apq8096_get_function_mux(__maybe_unused unsigned int pin,
> +					     unsigned int selector)
>  {
>  	return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index 2d99f99e1e..c2c358f556 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -40,7 +40,8 @@ static const char *ipq4019_get_pin_name(struct udevice *dev,
>  	return pin_name;
>  }
>  
> -static unsigned int ipq4019_get_function_mux(unsigned int selector)
> +static unsigned int ipq4019_get_function_mux(__maybe_unused unsigned int pin,
> +					     unsigned int selector)
>  {
>  	return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index dc3d8c4d90..de0bb4de0a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -82,10 +82,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>  			  unsigned int func_selector)
>  {
>  	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +	u32 func = priv->data->get_function_mux(pin_selector, func_selector);
>  
>  	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> -			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
> -			priv->data->get_function_mux(func_selector) << 2);
> +			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE, func << 2);
>  	return 0;
>  }
>  
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
> index 07f2eae9ba..49b7bfbc00 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.h
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
> @@ -18,7 +18,8 @@ struct msm_pinctrl_data {
>  	int functions_count;
>  	const char *(*get_function_name)(struct udevice *dev,
>  					 unsigned int selector);
> -	unsigned int (*get_function_mux)(unsigned int selector);
> +	unsigned int (*get_function_mux)(unsigned int pin,
> +					 unsigned int selector);
>  	const char *(*get_pin_name)(struct udevice *dev,
>  				    unsigned int selector);
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index ac00afa2a1..977f7b2ac3 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -56,7 +56,8 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>  	}
>  }
>  
> -static unsigned int qcs404_get_function_mux(unsigned int selector)
> +static unsigned int qcs404_get_function_mux(__maybe_unused unsigned int pin,
> +					    unsigned int selector)
>  {
>  	return msm_pinctrl_functions[selector].val;
>  }
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 9f0f4085ce..64ce1bf15e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -70,7 +70,8 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
>  	return pin_name;
>  }
>  
> -static unsigned int sdm845_get_function_mux(unsigned int selector)
> +static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pin,
> +					    unsigned int selector)
>  {
>  	return msm_pinctrl_functions[selector].val;
>  }

-- 
// Caleb (they/them)
