Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808FFC07E97
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09F187743;
	Tue, 28 Nov 2023 17:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B6lMH27c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5853A8774B; Tue, 28 Nov 2023 17:50:07 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6012487742
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-332d2b6a84cso3874680f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701190205; x=1701795005; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QIzgxqsDziHG6lT5KZa9GdX52ZsUDhOxTaBCvm9ZwT0=;
 b=B6lMH27ccDgCUPKoSdLs3mkHMZ26isGR3L2iI0A3Wh+XmRNa+wCqmYVA81Pukx6XRi
 90A6GxJ3X4QVaLix3VjV9a25Zk7HrEBH3v1Bnfu3mUzlZ6A+CPqaLIvEcypBdZ8H3JMS
 q7ZwCOK6uEDvin6fCRB8pKnGJe7hnJJMWl+KLpWG/Iq6vuKs+80WPk2fT3tAKMil+rwm
 akCHyVt6CGC76Wq44uxbB8jhugCW1sM2MrAzjC7vl2ii4qGHHYa/e1Yg0qQ3vuXEUOEO
 Hx+MmpH4GWDjyfl5p2ivs2gZZ7njb5akpS1D3TwCHMBQtpEyeB+h4KgBZ2E+n8+oPjZt
 HcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701190205; x=1701795005;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QIzgxqsDziHG6lT5KZa9GdX52ZsUDhOxTaBCvm9ZwT0=;
 b=OWv0yKD1kFWBOHMbmf5tsv9nyA7MTxBzS8GIoXx0i5TSJ8i9v2aZQ3F8fseJJMjJoq
 oNTqNpN+Q4xcHqCrFV23HPJGkoki5aJMoh+RBnv8WI7tKir00OY8LVvYt6UnvOD4RZhT
 agv/Ndl8Hopqv1amHL08t35f7/JVSfQE+uk107QRWEZPkFA42gvZwl7t+OuHGfu1tb6t
 8h74Z1lcOaRotdAVrKCFca+7rIQ9hYtudD/QAocWxcLwEo3d+HUFqUBid9lE+d7Ns57X
 ndNgskPqLjT85i61bAEKrk8EHNz+BpESRz0HYt5Xjxfo59cEbW50pkuoT8494DSpZRwx
 afDg==
X-Gm-Message-State: AOJu0Yym/Y+q88Hnz7bLKiJ6YysRz186McIW15cQK4p3DNQ3yCwZiPTk
 HtkXKTmEeiolZxndNpQSzP14szTk6PXpTXMRYtky6uXq
X-Google-Smtp-Source: AGHT+IH7SbsPC9bc3xfGGExWrWHyJLv3yZr46oNY+o5U8AT46nSBKIOg4Znw/tHinsqJJI+ytqTuNw==
X-Received: by 2002:adf:ce89:0:b0:332:f578:874e with SMTP id
 r9-20020adfce89000000b00332f578874emr7649258wrn.56.1701190204749; 
 Tue, 28 Nov 2023 08:50:04 -0800 (PST)
Received: from [10.10.51.254] (lmontsouris-659-1-84-229.w80-11.abo.wanadoo.fr.
 [80.11.4.229]) by smtp.gmail.com with ESMTPSA id
 o18-20020adf8b92000000b00332e8dd713fsm13332454wra.74.2023.11.28.08.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 08:50:04 -0800 (PST)
Message-ID: <007c5cb4-7193-445c-a878-d28584d39c96@linaro.org>
Date: Tue, 28 Nov 2023 17:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/5] gpio: qcom_pmic: fix support for upstream DT
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
 <20231128-b4-qcom-dt-compat-v4-3-949d0982d1de@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231128-b4-qcom-dt-compat-v4-3-949d0982d1de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 28/11/2023 17:30, Caleb Connolly wrote:
> Linux devicetrees use the "gpio-ranges" property, add support for
> parsing it instead of "gpio-count" so that upstream DTs can be used with
> U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c.dts |  3 +--
>   arch/arm/dts/dragonboard820c.dts |  3 +--
>   arch/arm/dts/qcs404-evb.dts      |  2 +-
>   arch/arm/dts/sdm845.dtsi         |  3 +--
>   drivers/gpio/qcom_pmic_gpio.c    | 38 ++++++++++++++++++++++++++++++--------
>   5 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index c41fee977813..6a4e3ccf17b1 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -170,9 +170,8 @@
>   					compatible = "qcom,pm8916-gpio";
>   					reg = <0xc000 0x400>;
>   					gpio-controller;
> -					gpio-count = <4>;
> +					gpio-ranges = <&pm8916_gpios 0 0 4>;
>   					#gpio-cells = <2>;
> -					gpio-bank-name="pmic";
>   				};
>   			};
>   
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 0d9c9f7a4922..146a0af8aafe 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -132,9 +132,8 @@
>   					compatible = "qcom,pm8994-gpio";
>   					reg = <0xc000 0x400>;
>   					gpio-controller;
> -					gpio-count = <24>;
> +					gpio-ranges = <&pm8994_gpios 0 0 22>;
>   					#gpio-cells = <2>;
> -					gpio-bank-name="pm8994.";
>   				};
>   			};
>   
> diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
> index 84224a8a3d39..3bb580ba4e17 100644
> --- a/arch/arm/dts/qcs404-evb.dts
> +++ b/arch/arm/dts/qcs404-evb.dts
> @@ -378,7 +378,7 @@
>   					compatible = "qcom,pms405-gpio";
>   					reg = <0xc000 0x400>;
>   					gpio-controller;
> -					gpio-count = <12>;
> +					gpio-ranges = <&pms405_gpios 0 0 12>;
>   					#gpio-cells = <2>;
>   					gpio-bank-name="pmic";
>   				};
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index cd5d890e9a45..a26e9f411ee0 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -103,9 +103,8 @@
>   					compatible = "qcom,pm8998-gpio";
>   					reg = <0xc000 0x1a00>;
>   					gpio-controller;
> -					gpio-count = <21>;
> +					gpio-ranges = <&pm8998_gpios 0 0 26>;
>   					#gpio-cells = <2>;
> -					gpio-bank-name = "pm8998.";
>   				};
>   			};
>   
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 7b83c67fa464..1adc6566a36d 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -245,23 +245,45 @@ static int qcom_gpio_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +/*
> + * Parse basic GPIO count specified via the gpio-ranges property
> + * as specified in Linux devicetrees
> + * Returns < 0 on error, otherwise gpio count
> + */
> +static int qcom_gpio_of_parse_ranges(struct udevice *dev)
> +{
> +	int ret;
> +	struct ofnode_phandle_args args;
> +
> +	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
> +					     NULL, 3, 0, &args);
> +	if (ret)
> +		return log_msg_ret("gpio-ranges", ret);
> +
> +	return args.args[2];
> +}
> +
>   static int qcom_gpio_of_to_plat(struct udevice *dev)
>   {
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	int ret;
>   
> -	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
> -	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
> -	if (uc_priv->bank_name == NULL)
> -		uc_priv->bank_name = "qcom_pmic";
> +	ret = qcom_gpio_of_parse_ranges(dev);
> +	if (ret > 0)
> +		uc_priv->gpio_count = ret;
> +	else
> +		return ret;
> +
> +	uc_priv->bank_name = "pmic";
>   
>   	return 0;
>   }
>   
>   static const struct udevice_id qcom_gpio_ids[] = {
> -	{ .compatible = "qcom,pm8916-gpio" },
> -	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pm8998-gpio" },
> -	{ .compatible = "qcom,pms405-gpio" },
> +	{ .compatible = "qcom,pm8916-gpio", },
> +	{ .compatible = "qcom,pm8994-gpio", },
> +	{ .compatible = "qcom,pm8998-gpio", },
> +	{ .compatible = "qcom,pms405-gpio", },
>   	{ }
>   };
>   
> 

Here you could introduce qcom_gpio_of_parse_ranges() and use it only if gpio-count
doesn't exist, then in a separate patch change the DT and afterward remove the gpio-count
code ?

Neil
