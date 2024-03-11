Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B4C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD0287D2D;
	Mon, 11 Mar 2024 13:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kLmJ2m/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2AE87E0D; Mon, 11 Mar 2024 13:37:18 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E0887D2D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513382f40e9so5131549e87.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710160635; x=1710765435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uT0vINcWfn8CqPxmNqnem6w7TzUtHFNlq/4XFkW0Q40=;
 b=kLmJ2m/9xUsaXNLC30eBJbt5hqLEd2Q3uuNXwMxhOMseZb8mRs/Nolse2Bsjlk+tCT
 cvhbSv473SOQGAroJHOK6xdVnJnE/4NzcLuBe4ABFKM178aNZn/uhvmadtR/7w37xuWv
 J60ABZPlGZbofRPGLe2Iws8sm+0cHbgyR6IF+azS1jVoSHkgFP3DhpJ+9dMBN7Nq6crn
 X3mJWTsvtwMVcTFi2eqz4nt+f5ZBF77G+zgU3w0fzCnMXD1+t0a1g/oYwS2AlbWvvgGc
 N0ftdVpe6NH3pYBX7tHVMP7zzsIjfCTjGiRHZdNYtcGA2ite7yeiz9nOD6RjFQJHqL4M
 LxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160635; x=1710765435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uT0vINcWfn8CqPxmNqnem6w7TzUtHFNlq/4XFkW0Q40=;
 b=lSZbdmWWCTpG3dyHSbdcKbbiyVixOYASou2J3rgXd6yQmJC5D0oofU4XfNgdkL+LBN
 COpwzXCofFNyyrKDCkRhZnhPWDmOWX9Uq3ZuGLHiTwOw0w3S86tsKTAx5FYwRB7Z0vTJ
 +1npSh6uCTtwBX8rGvHk+qU8bGZ/C+BbmLVU2Fjeu2NM26nvkDtPFB/41LJwGt/rzAuj
 5K6dBIPCUR+drH1YRG9kqbs3k57bBBCWOc3QACme6Tfd73sak+H0vtfzPI0eaujLE3p/
 9tKN5OnSSK5/Laxa0uBU9yXpz+90pIpuXEBX5LZVk0QiDWOmKbOiHYXZqpF/9u131P3V
 hOmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdnXMhyFA94rfGRlE6tQ97GL5dnXxTN9EinAIYpBNj+narcokfmZNr5xxIpdWCq9t2n9oveQ6SViH7C+xg9ZmWSvBwlg==
X-Gm-Message-State: AOJu0Yyo4ZniK28djgLYvrKNJFhgaOOKe0h9y9mHDbCHaJ3VNbfyarcA
 5SUwWhx9XsVEhMswQCEBUTLqPClCIZTugqpw+lTdM4Y3P43qpq5755hinnlVEpE=
X-Google-Smtp-Source: AGHT+IF0uCSyTJoXTf7fjTPJphQDQRDIpZi5tLJW/NOCh/nyw5HYiC8gkgCUsyl9Cw7r1ZO2TMvOVA==
X-Received: by 2002:ac2:4d95:0:b0:513:593c:163f with SMTP id
 g21-20020ac24d95000000b00513593c163fmr3635329lfe.66.1710160635151; 
 Mon, 11 Mar 2024 05:37:15 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b00412cbe4f41bsm15907108wms.4.2024.03.11.05.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:37:14 -0700 (PDT)
Message-ID: <6711f465-05a2-4132-866d-40962016287d@linaro.org>
Date: Mon, 11 Mar 2024 12:37:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] pinctrl: qcom: Add support for driving GPIO pins
 output
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-5-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311111027.44577-5-sumit.garg@linaro.org>
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

Hi Sumit,

On 11/03/2024 11:10, Sumit Garg wrote:
> Add support for driving the GPIO pins as output low or high.

Ohh, this is why it was never working for me >,<
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
>  drivers/pinctrl/qcom/pinctrl-qcom.c    | 26 +++++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index cb0e2227079..04b501c563d 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
>  };
>  
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"gpio", 0},
Please split this into a separate patch.
>  	{"blsp_uart1", 2},
>  	{"blsp_uart2", 2},
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index ee0624df296..932be7c4840 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -29,15 +29,25 @@ struct msm_pinctrl_priv {
>  #define GPIO_CONFIG_REG(priv, x) \
>  	(qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
>  
> -#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
> -#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
> -#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
> -#define TLMM_GPIO_DISABLE BIT(9)
> +#define GPIO_IN_OUT_REG(priv, x) \
> +	(GPIO_CONFIG_REG(priv, x) + 0x4)
> +
> +#define TLMM_GPIO_PULL_MASK	GENMASK(1, 0)
> +#define TLMM_FUNC_SEL_MASK	GENMASK(5, 2)
> +#define TLMM_DRV_STRENGTH_MASK	GENMASK(8, 6)
> +#define TLMM_GPIO_OUTPUT_MASK	BIT(1)
> +#define TLMM_GPIO_OE_MASK	BIT(9)
> +
> +/* GPIO_IN_OUT register shifts. */
> +#define GPIO_IN          0
> +#define GPIO_OUT         1
Are there two separate bits? GPIO_IN is never used? Maybe just define
GPIO_OUT as BIT(0) instead?
>  
>  static const struct pinconf_param msm_conf_params[] = {
>  	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>  	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>  	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
> +	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
> +	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
>  };
>  
>  static int msm_get_functions_count(struct udevice *dev)
> @@ -89,7 +99,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>  		return 0;
>  
>  	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> -			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
> +			TLMM_FUNC_SEL_MASK | TLMM_GPIO_OE_MASK,
>  			priv->data->get_function_mux(func_selector) << 2);
>  	return 0;
>  }
> @@ -117,6 +127,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>  				TLMM_GPIO_PULL_MASK, argument);
>  		break;
> +	case PIN_CONFIG_OUTPUT:
> +		writel(argument << GPIO_OUT,
Then this can be "argument ? GPIO_OUT : GPIO_IN" which feels much
cleaner. Or even just !!argument if it's bit 0.
> +		       priv->base + GPIO_IN_OUT_REG(priv, pin_selector));
> +		setbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> +			     TLMM_GPIO_OE_MASK);
> +		break;
>  	default:
>  		return 0;
>  	}

-- 
// Caleb (they/them)
