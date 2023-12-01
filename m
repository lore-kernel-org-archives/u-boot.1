Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70C7C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F9287483;
	Fri,  1 Dec 2023 10:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dlWCRbX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F59875FE; Fri,  1 Dec 2023 10:28:22 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E430786F50
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3332f1512e8so610110f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701422900; x=1702027700; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fbQ61a7ScEs9PFN5v8euTCPCPLr/JOyE9RnRNaljHjI=;
 b=dlWCRbX0pI5AOrSuyKUc6GxbrrBgos5QZQhizPA5uhWLOuWxuXFcqfmBhJKGiUu7Vx
 QQRA2eS1fzUc7a7yHxrb/iC4u8fV3WSeSu/n4SydXtUIjKikuL34v4GtDfRfyNL/hUEA
 YgGfwt4GuJuAkxJhOLMzI6rbHolCntN75a9s1rkM8+L318szdBbuFrjJt0sRiB+5wUdR
 nx+MLUEXoXAtpys3FZU4ces4HNAQTufAu8ghXCgTsO4bd8Bmhm2f6oRsjkw2ugYC3BPS
 y3c/HCyRSIrAY5ybFnPbGaJh6NOQ6sf8+s3/hf40JphGZpebn6JefDYje0LBekVlTz/W
 DScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701422900; x=1702027700;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fbQ61a7ScEs9PFN5v8euTCPCPLr/JOyE9RnRNaljHjI=;
 b=rRMvp5vg5TzBHizZ0HJaN52H/4wQJVSkAxyPY0Q+QzHNuOFgJsvw+kU3kdcjVUL+DD
 tfG95yf5dvGogN+CIQKitcANDQjLac3umfk728ObODwRYvDurnmQhF58o4eCY+kCsp8l
 x6JKxcvf8V9y5ZAmt5PVhu5IzgezIft+HVmuV5Q3Mt2FnFR2aL82poxAE31SqzU7U4tV
 ANJStUDWnNQpsc/UhKETAi6rfAY/SfqevcLVK7oFv+Un+50oijPpg6ymSbh8oMzT9gWX
 jPG9WWvCUAXM8NLkWO3f3p7m/OiPlvce1mblkA3tIsVKjEgWGAgAKbg2FIqL5/nxTaYd
 0V8Q==
X-Gm-Message-State: AOJu0YwnT/rIT7ZW5vry7eMkgsv8hoAjkBYL+feLPNNNiOkktRSb75Ue
 UxPyDvpUdZEPtgC58af4P34jRw==
X-Google-Smtp-Source: AGHT+IEvEBBmclotFjxuJmtBwwhXwByZBYIFuYIVAYDFx42NHcFlWd9R8snOjpI32KYekoUq8XH5Aw==
X-Received: by 2002:a05:6000:1004:b0:333:281c:dedd with SMTP id
 a4-20020a056000100400b00333281cdeddmr621739wrx.62.1701422900120; 
 Fri, 01 Dec 2023 01:28:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 dd16-20020a0560001e9000b00332cc24a59bsm3647361wrb.109.2023.12.01.01.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:28:19 -0800 (PST)
Message-ID: <bd93e86b-1646-4b04-a7d3-992e37fb35c1@linaro.org>
Date: Fri, 1 Dec 2023 10:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 7/9] gpio: qcom_pmic: drop gpio-count property
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
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-7-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-7-41500e237ad0@linaro.org>
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

On 30/11/2023 21:22, Caleb Connolly wrote:
> This property is not part of the dt bindings and all boards use the new
> gpio-ranges property instead. Drop support for this.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/device-tree-bindings/gpio/pm8916_gpio.txt | 48 ---------------------------
>   drivers/gpio/qcom_pmic_gpio.c                 | 13 +++-----
>   2 files changed, 5 insertions(+), 56 deletions(-)
> 
> diff --git a/doc/device-tree-bindings/gpio/pm8916_gpio.txt b/doc/device-tree-bindings/gpio/pm8916_gpio.txt
> deleted file mode 100644
> index 58185b833524..000000000000
> --- a/doc/device-tree-bindings/gpio/pm8916_gpio.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -Driver for part of pm8916 PMIC - gpio and power/reset keys
> -
> -This device should be child of SPMI pmic.
> -
> -1) GPIO driver
> -
> -Required properties:
> -- compatible: "qcom,pm8916-gpio"
> -- reg: peripheral ID, size of register block
> -- gpio-controller
> -- gpio-count: number of GPIOs
> -- #gpio-cells: 2
> -
> -Optional properties:
> -- gpio-bank-name: name of bank (as default "pm8916" is used)
> -
> -Example:
> -
> -pmic_gpios: gpios@c000 {
> -	compatible = "qcom,pm8916-gpio";
> -	reg = <0xc000 0x400>;
> -	gpio-controller;
> -	gpio-count = <4>;
> -	#gpio-cells = <2>;
> -	gpio-bank-name="pmic";
> -};
> -
> -
> -2) Power/Reset key driver
> -
> -Required properties:
> -- compatible: "qcom,pm8916-pwrkey"
> -- reg: peripheral ID, size of register block
> -- gpio-controller
> -- #gpio-cells: 2
> -
> -Optional properties:
> -- gpio-bank-name: name of bank (as default "pm8916_key" is used)
> -
> -
> -Example:
> -
> -pmic_pon: pon@800 {
> -	compatible = "qcom,pm8916-pwrkey";
> -	reg = <0x800 0x96>;
> -	#gpio-cells = <2>;
> -	gpio-controller;
> -};
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 54f4dbd2b84e..1adc6566a36d 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -268,14 +268,11 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
>   	int ret;
>   
> -	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
> -	if (!uc_priv->gpio_count) {
> -		ret = qcom_gpio_of_parse_ranges(dev);
> -		if (ret > 0)
> -			uc_priv->gpio_count = ret;
> -		else
> -			return ret;
> -	}
> +	ret = qcom_gpio_of_parse_ranges(dev);
> +	if (ret > 0)
> +		uc_priv->gpio_count = ret;
> +	else
> +		return ret;
>   
>   	uc_priv->bank_name = "pmic";
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
