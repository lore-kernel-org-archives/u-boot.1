Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1665CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 18:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0C4839B9;
	Wed,  8 Oct 2025 20:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E84Xyfgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8533C839DD; Wed,  8 Oct 2025 20:18:47 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8AC8394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 20:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so1443885e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759947525; x=1760552325; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8sfVENramFOvP4gpmmvE1V7ca8fRpCflD4I/Y3yP8gE=;
 b=E84XyfgkfH7W2xnzcVIQIaUB0s2PG5VTB+lewAhzsA/SFhuslFvaXMbYSYfiPUo+Zi
 axKfhXewNUyubcRoQtOZBtcEV4np11MejHDgDhA5qXvnpsOsViVN0g1hIgMnK4mrpL22
 VOckGQ0szYY+MJTXiXNtrpDRKUtnc6+BYbIcweCI7dZgfZdVHjFuMRR3O85b+dmD5Z8r
 8+5G9MQShH3XNtM5MFZjUv7A3GaTErYlwBbG1fqgZnkqyVc1ILHLgdrVcPlVubT/cMFp
 KTRRyE1ymeabkbm92ZKeaDVrznvKzPd5xMAbIqfDT8L90jKjsRbvHy8HrKBBa+N+mVWG
 b49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759947525; x=1760552325;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8sfVENramFOvP4gpmmvE1V7ca8fRpCflD4I/Y3yP8gE=;
 b=aTKmeo+rDzYHjqxafKqchpnexZpN+hK3Hk0YVZW4JU7lFg6sRMGnUA8Wa7oEm4wQDz
 V0GkOqYzqIbilsQKUd/sz0ZGQIBcDNcDNHqmtacQv0654fxkXV+iprVGpEoz/WsfPK5B
 zaI/mt8Zi2TY/VWYlTFRTjKpWVIdgTDHUsFFsV9guEcut8o4+rOedTNBiIfAyt0NE8fa
 nzAvoEjxygQU4f4D4zc9zSKwkNU1q4+eoCSqQALw1fm+zpGgg397s4gdJEtchLBalkgS
 sku9zo4ZzcmSxQ/baRzfX21NgMjMLEaM8JPtvQNAzKYSGEvN2LChLsyqJgVaal6+Yrb6
 yGIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Z5Ni1/C9N9mGac6a+xerlsamKbVe/cP1JWlZ72+VmuvMqwTraabpd8fYeWefoYPF1BT59/8=@lists.denx.de
X-Gm-Message-State: AOJu0YxUUqGfdDv2dSCCmsn+sV/qDPgEuPXaVJapiBp++syJRpi4Zo6/
 ChRuxdrPSXrHkxUtu7IgjlvH1KJjd1WtVR9b+aYBzU8v3IG5MZXNV7DBNK+uq9rB3fs=
X-Gm-Gg: ASbGncu1Xo3tBmV7W07o2cOImg62w2sBDTxq3bVrvFtDInuluXxExQduNCssxe2Cx6d
 J7IAcCtNcd43HvVh8YISdkChqcvWkEP0yGW1uLW81oNi/PUobMDb6ie1jZ3N+aM0y8VIeShLtG+
 g0CT87PUHIn4WZ40U8m63H07XwRQCabpB6HL6je60KVeVrLq6jsCUFcxOjJcyLQCQfT9H4PIsQl
 1J0MnqJmFbFDgf1m6iusO292/v4u+N3v9Chw2ibm7mBNV3IjTJUP6iOi0TteqeV9hOwVR9yxTPe
 S5skUk0UHo3OH9sPT+m+LaJ7SL3y0umjIl8lepo+/V2jhBIpiAu1UkeTWy3qfXY49j3bTVTd8Rk
 r+siP6zNnuyi38/S6iAMeMG6SWrbbqNYu3i55STiCvkB35AH96vK/fiRwWTh/F3SOg8z+t6VjWy
 RfWSGVVYrVzmkyAHH/4jU=
X-Google-Smtp-Source: AGHT+IEXC+WBX306MVM+1GlhysC8ffQehBg/Far7GksIoI5oKZFLKbIqBtESxO2K/zg+YZSkBYrXiQ==
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id
 5b1f17b1804b1-46fa9a8b2aemr29480755e9.4.1759947524483; 
 Wed, 08 Oct 2025 11:18:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d?
 ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d62890sm46121425e9.14.2025.10.08.11.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 11:18:44 -0700 (PDT)
Message-ID: <5522dcd6-025d-4e9b-ad7c-7fe3cd65ae04@linaro.org>
Date: Wed, 8 Oct 2025 20:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom: qcom_spmi_gpio: add compatible for pm6150l
To: Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251005154443.71477-1-adrian@mainlining.org>
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
In-Reply-To: <20251005154443.71477-1-adrian@mainlining.org>
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

On 10/5/25 17:44, Jens Reidel wrote:
> Add support for the GPIOs in the PM6150L to the new driver.
> 
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 22c8072534e..69222b4df55 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
>   }
>   
>   static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
> +	{ .compatible = "qcom,pm6150l-gpio" },
>   	{ .compatible = "qcom,pm8550-gpio" },
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
