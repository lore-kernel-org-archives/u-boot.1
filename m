Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0B0C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2722087663;
	Fri,  1 Dec 2023 10:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sKwKsk07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A261787688; Fri,  1 Dec 2023 10:32:20 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8460987483
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bc2e7f1e4so2703447e87.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423138; x=1702027938; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=hjFfVW/IxtttneINpVndAlPVDMprHcYb3JyU8ipeJFw=;
 b=sKwKsk07S08QSpISAsuQgVUVfK5BgQrazy/h1D3I3ENXgdM7iTABY13baLnng4W83E
 uZ92yoOmOufUhX7lD3u+Ds66ehRflgkNsL0AJr9SzSlVH5QBYF6cyl/L1UJOiASJv8Wq
 DvDR5htds9MUteojipUFTjOHHVOt53cwkUZ8CRS7C/gtdzG6RGOrHB1ouVkFrflgDUOj
 7CW+37nOL4tKpTM/a/Y3EVvnuR1zOOnnN59QindBSUt611E3pJ3y7BWlTEZRGhqbARS/
 LbAtvVVr8Xb32vuYpVnCA5AP3XYy/ntpFBBxF29XSHcGZS5DGbTlw9ywyzr9Oyd+Wbst
 IW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423138; x=1702027938;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hjFfVW/IxtttneINpVndAlPVDMprHcYb3JyU8ipeJFw=;
 b=b0shpDQcVrGrZcxPJ/+VG1+i/K6JgX98EbWd8BFgimtK2cDk3/2Y61z8pSkzZI+m33
 r8Kz853hv3xJ520OAsP1TbB54+nN0IORI5W192zITErrUf9R7UwjkynDvp7y4ZHlKRX8
 lbJh1U9wKaXQU55WeKe/bco3LUYXS/g8BS4+2nQ37fnAkIPTQgM91qfKFo9ONQEySBej
 b6lNcS1S2ovChPkIV/VdCGCH2HAy+E3gsQxVFzJg342PDSJ9W4hu6dWwUEmN2GVHNFZi
 Y/FAvkTR1BQ7RhcUxd7LdwM2ByIdCvmFpiSXArCmNoaheu631SxpxP0NcNm5V6K91u2l
 LN0g==
X-Gm-Message-State: AOJu0YxIIxhbKHaivHoNJ4GAWRKh7HxiF7AF0yC6VjW2SAt+AoySK4hy
 yDbU2ofNEx+EsSNqovJT0p7pHw==
X-Google-Smtp-Source: AGHT+IF3EE2tVDkSrsjlwPAD7QvBunKalA6coUnOa/cpsyVKwHbQKaSaQW/J5r3cmXTvLAZVAs5vLg==
X-Received: by 2002:ac2:4c97:0:b0:50a:a81e:469c with SMTP id
 d23-20020ac24c97000000b0050aa81e469cmr519469lfl.64.1701423137870; 
 Fri, 01 Dec 2023 01:32:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm3695695wrm.27.2023.12.01.01.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:32:17 -0800 (PST)
Message-ID: <42a9c51e-a4bf-4d5a-a533-58d6266612f8@linaro.org>
Date: Fri, 1 Dec 2023 10:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/9] gpio: qcom_pmic: fix silent dev_read_addr downcast
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
 <20231130-b4-qcom-dt-compat-v5-1-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-1-41500e237ad0@linaro.org>
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
> priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
> with the upper bits being used for error codes. Do error checking before
> downcasting to u32 to prevent errors being silently ignored.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 65feb453ebc3..e5841f502953 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -221,11 +221,14 @@ static int qcom_gpio_probe(struct udevice *dev)
>   {
>   	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>   	int reg;
> +	u64 pid;
>   
> -	priv->pid = dev_read_addr(dev);
> -	if (priv->pid == FDT_ADDR_T_NONE)
> +	pid = dev_read_addr(dev);
> +	if (pid == FDT_ADDR_T_NONE)
>   		return log_msg_ret("bad address", -EINVAL);
>   
> +	priv->pid = pid;
> +
>   	/* Do a sanity check */
>   	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>   	if (reg != REG_TYPE_VAL)
> @@ -328,11 +331,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>   {
>   	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>   	int reg;
> +	u64 pid;
>   
> -	priv->pid = dev_read_addr(dev);
> -	if (priv->pid == FDT_ADDR_T_NONE)
> +	pid = dev_read_addr(dev);
> +	if (pid == FDT_ADDR_T_NONE)
>   		return log_msg_ret("bad address", -EINVAL);
>   
> +	priv->pid = pid;
> +
>   	/* Do a sanity check */
>   	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>   	if (reg != 0x1)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
