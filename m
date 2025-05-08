Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3B6C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0802828A2;
	Thu,  8 May 2025 17:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GORiLOS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E94828BC; Thu,  8 May 2025 17:49:14 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796E8822D7
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so8961275e9.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746719352; x=1747324152; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wuPpFsF8oelPREeH19XbSFdMzU8lMtsYkFob+5FNK2E=;
 b=GORiLOS2FniqyKn0hMAv9Jl11d00mxkVGFvUb3RM8BgdjEccTK0ML/QilziSpO+8+S
 q2PsYpR00IUJCQpnxNBe+Am+ZTSkIutbbxsmbqAsJmvPMGk1Vy5XVwk5d3InUuWUNFip
 SY4mBm8rILTba5OAXmQ0TnKWbp8jJ17cTJcpArPwI73P0Mm53rHOXOmoYbpRaPiKZnN/
 H8mC7BIvGJ9EsMnptzVtZ+JN8Lkc/vk6S85nzNCzegpOTTrpll1wdTQ6PeKBJQmGeZhD
 YrzcouzLNa9kdTdBH2mFsCuScjQeXH2C8w9yLqJykB+z5YYGWhBRzs9WfZ1+ukQJLJis
 7/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746719352; x=1747324152;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wuPpFsF8oelPREeH19XbSFdMzU8lMtsYkFob+5FNK2E=;
 b=hCgibLWd8LYrfgbinQDLGaPcYwsLk6m7KsSfCdUCYGpU6J0ikEN97EFewTd5dyu6R+
 74Phx7qADPyKEJ6CQrBOC9z0qChGtLKbnp3+/z/T1804kqlHSL4V+hVHu4/nA8i9O4RF
 nl+UFHifPAi700OQsFY5i4mLqVvOLK3TMdRq1EFgvaDHMXSv+bfxxsKtb/fUsn9WsYrx
 01RSErTyjMvWw8nM7LTzKKa2/YpoQAMIf50D3/xwlqTyhKkwAbJOFbtJmJnZgLzpGm4c
 q6yaUM9NaGFs2TZQrw8+TON7rL7ygCBE4yTgy1qdPhjWB8obUk2+1z1RMVMStfzZjToW
 lxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjUOJdulI2/HBq7WnDVDfiC3a326QQioBA6BDaiTUr6zvNFkEqncaKOlV6PaX6uWOgNqX2h8=@lists.denx.de
X-Gm-Message-State: AOJu0YxFyKhumm50EuyyaPeCVL4UJnAkGUudPlK8lbI2MqzqZF1oID1L
 VrkPMGMHI6/48OksdB4nEHnNlWgf1MKRKAhIKkP6mcmZh0o8PR0N+wNjcR0qoTU=
X-Gm-Gg: ASbGncsUF9AhinU49NYmjDArkZMSFg88XVg5NEo2/l3cLYrGcIpxeIFTF+NPUe0PEHb
 x7oPfDK5/RETshOgTYq+8jv8pBGpOo2qjBp/MuvFQkDsIgu9s85TV8jDrusX06qHjMyTJvHM+ie
 7v0Yvl+WpMGnaPKkCEKmF01xp9FNuiwJrDmEwJ8ANrSslqbWXjSiMQVmuCfq/ETqaJ+DmzldCKZ
 NFZVcUZtn50OGBTax2LCvGOucr6J6VcAsT0nnQEbuuuGLivJ7EewcS6sKQHzzLlHiaeKeckt1Q/
 cDLnqNumR4/evrwSex3HsfbXoaUxa8cHYrrkaoWqc+f5n9+S+ZIH6SkWBayLWGHzY6c/D1ehFYx
 Ok3H36q94J/zY
X-Google-Smtp-Source: AGHT+IG+91ADPSckxnyX/Gp9qm+Ip/kdhTywunyZsUJpqCMru6B7h0hOFp7A3FIzDIHzanmTtRKHlw==
X-Received: by 2002:a05:600c:1c03:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-441d44c7c41mr75353305e9.17.1746719351946; 
 Thu, 08 May 2025 08:49:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:e17:1e6:6220:c42f?
 ([2a01:e0a:3d9:2080:e17:1e6:6220:c42f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d1719aa4sm31696785e9.32.2025.05.08.08.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 08:49:11 -0700 (PDT)
Message-ID: <ac8bff41-e3fb-44c4-9ff6-93b9a6e61072@linaro.org>
Date: Thu, 8 May 2025 17:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] gpio: msm_gpio: return correct value for gpio read
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08/05/2025 13:36, Aswin Murugan wrote:
> In the current implementation, the GPIO read operation considers
> both the input and outbut bits (bits 0 and 1). It should only consider
> the state of input bit, i.e bit 0. To address this, mask input bit
> alone and read it.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/gpio/msm_gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 6783fc756f4..7de332c66ae 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -202,7 +202,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>   	if (qcom_is_special_pin(priv->pin_data, gpio))
>   		return msm_gpio_get_value_special(priv, gpio);
>   
> -	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
> +	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) & BIT(GPIO_IN));
>   }
>   
>   static int msm_gpio_get_function_special(struct msm_gpio_bank *priv,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
