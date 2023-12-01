Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F11C10F04
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F5C87483;
	Fri,  1 Dec 2023 10:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LYQzbf3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3683A8757B; Fri,  1 Dec 2023 10:27:29 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B1886F50
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b4746ae51so17903485e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701422846; x=1702027646; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Q3N8tv7DCmbgUxZJ6P+88Bjx/96mQ2/Qy7C3sxMYs1c=;
 b=LYQzbf3OCLUD3cpCKzbMabJ+JwdxghDpEN+MuZvwKSRErU5InW3gHNv7U7gaWG9W7l
 xnrQQf4y6Zz0radpfT2uwg87s6eotsndtjouSbJfms+KPNYveqJTSNVpKMGyJ03vzb93
 xdJmfSyh5ex+0tDpyRTDLZkeL8Ni3IrjMJTYZUkHOO9FmQ0r/+Gi17TtUl7oo393NarQ
 BXJsXlinhQbfF6+Ckg20H9vZ6wk2rbZUTzw+7JiSLBTEMRcSCCRChllJekYPc+wbvXvf
 TWqth8ZZeUDUJeJ81Y/rcCTFttDgSiG1zqTE9BlJGwcojzbDAMaqZ1zz4YGSdKjvO97R
 Ab9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701422846; x=1702027646;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q3N8tv7DCmbgUxZJ6P+88Bjx/96mQ2/Qy7C3sxMYs1c=;
 b=g1UWeV3Zn7rw9VBmcjaBs8WrvWn7qvv+RcMCBJP7fCSTXRSmlJ/rsb3E1QPE5Qbj68
 Lb5knxaXvcApia+SFmPUQ9A4SG5CCZ1+g2NSGqBJFClO4zRYt8WBRUYqN/UM+D2QCDxy
 2m2aYXmvvh8Ia/HPc1UfkZkfLV05ISo/KuYtYjkwWoAKUmZjH4QhsN9K+/ARhD2qKKaD
 ubIiGRGeHulhHtl6Rlm/He09f+Tcl3GB2Bbq8V6f4EjLwFy91cqP3mKE+OlKJomdSU4I
 xFxwO/PJSabbpfx5auzwNqm9sd9VHXKk5anWNQhRFcWIzJY1DJTQcYuCU8cwVMXIdwhL
 XQyg==
X-Gm-Message-State: AOJu0YyJY32lJ9pcxFBKdTAqPaJa0V7R6BX9lJPMcGpOuc7QPQk8miv+
 QwQQNK/SLEDB7vRYol5kP9eaXg==
X-Google-Smtp-Source: AGHT+IHhwLzxljh00bQ0+ZLT87o1h7uxfQGgfeLliL/aJHfhaBHm0Lvmtki/CBUaM9Mi4R1pWBaUkQ==
X-Received: by 2002:a05:6000:228:b0:333:2be8:b3e2 with SMTP id
 l8-20020a056000022800b003332be8b3e2mr572292wrz.62.1701422846591; 
 Fri, 01 Dec 2023 01:27:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 dd16-20020a0560001e9000b00332cc24a59bsm3647361wrb.109.2023.12.01.01.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:27:26 -0800 (PST)
Message-ID: <b2a23d68-31e9-4121-bc71-808de3c2e96b@linaro.org>
Date: Fri, 1 Dec 2023 10:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/9] gpio: qcom_pmic: support upstream DT
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
 <20231130-b4-qcom-dt-compat-v5-5-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-5-41500e237ad0@linaro.org>
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
> Upstream uses the gpio-ranges property to define the number of GPIOs,
> support for parsing this when gpio-count is unspecified
> 
> Additionally, drop the bank-name property as it isn't used in upstream,
> and we can just hardcode the bank name instead.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 39 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 7b83c67fa464..54f4dbd2b84e 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -245,23 +245,48 @@ static int qcom_gpio_probe(struct udevice *dev)
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
>   	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
> -	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
> -	if (uc_priv->bank_name == NULL)
> -		uc_priv->bank_name = "qcom_pmic";
> +	if (!uc_priv->gpio_count) {
> +		ret = qcom_gpio_of_parse_ranges(dev);
> +		if (ret > 0)
> +			uc_priv->gpio_count = ret;
> +		else
> +			return ret;
> +	}
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

This seems to be a spurious change

>   	{ }
>   };
>   
> 

