Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EEEE0206
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FB8892F4;
	Wed, 11 Sep 2024 20:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j4Q4EN99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8F9892F3; Wed, 11 Sep 2024 20:05:29 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2371892FA
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so334165e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726077927; x=1726682727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZT8c1Uq9gnVra2TZ0hzVzXfxC4fwKeUpTzULnN2pb20=;
 b=j4Q4EN99NVJgaY2769MIhwdhLZZjIe72hK/2L1cDrdDRSRup3JkIAIE5koCrJ2VIeF
 pwSZRb2uGe3aMdKKmyNLDX1t+XSx/8uqaHWDcoM2CFBNv46T4fxpfqMAg4TYQJOnFtIZ
 I+/xKsrVJnFim3Pd/mtjM5FJwdsW5QwHDJdj5cbABTYgJYm1UPit/ozXtIG3y0VoXYA0
 gmvD0Gi6OdnC3yVmfmYLzimmexLUhZkiTREdCO1+WL1bLWi1ptejAJNCtWku3Ke3IYKC
 Vz91lDVbYo6DyObBdrxzjRrgssax1c5op+uxJTCRYFwpUz4yd9odUWwvpqtzfiE1XHdZ
 3gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726077927; x=1726682727;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZT8c1Uq9gnVra2TZ0hzVzXfxC4fwKeUpTzULnN2pb20=;
 b=BT2MObcPehs+zDH+Z9yrDzHDzOasiJ+mKzTJy+z0i7oP94+IMyTJHsaqjweTXbfAlW
 LAsQs8nZfmxrV2zTu/bOZSnhhPFH6yPgGw318vMY9Strv27fWEtZDKlKUL5+FDrITH/q
 +GgDJBwK0yeFYy6R104recHHG4JMwKyd0KjE8+6adtbQyI8n+V07pdK8Nn3ne6mKZwE5
 WKldLPhSk6s7gcn0H3i1dRfUX69SMx0JzWhtsJNlz4XTBDf3B419z8l7K1uYWJ+lgNKN
 t/8Z1O4NMmrf29GkC7WCAHwBMNThB4C0+tuS1WmROnBhLS2/mbDvZDe9ITHD3BdFl0OS
 /Z/w==
X-Gm-Message-State: AOJu0YxnTXkYJF6qtHnUPV5VFe+ZIkcjkoRFTIP/wjY0uckbE8TSYJWn
 2AFlcI74V8pIhElZ+Bkr8kFG0a9tDyjtKoXDZy8sw721vE96twVINha6ZbNpOrk=
X-Google-Smtp-Source: AGHT+IHLLDXKb7kq8PTb87m9QA8axktliOW0LtSUdJhqQI8OZAcQ8anS2RDCxSNQuAP6GFgcsmOPdA==
X-Received: by 2002:a05:600c:3583:b0:42c:cd88:d0f7 with SMTP id
 5b1f17b1804b1-42cdb547de2mr2848085e9.10.1726077927273; 
 Wed, 11 Sep 2024 11:05:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1680:3625:e94b:7c21?
 ([2a01:e0a:982:cbb0:1680:3625:e94b:7c21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dddacsm12058255f8f.107.2024.09.11.11.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 11:05:26 -0700 (PDT)
Message-ID: <ad32db2d-5798-4497-af4a-155e49bc96cc@linaro.org>
Date: Wed, 11 Sep 2024 20:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/3] config: qcom: add sm8150 to qcom_defconfig
To: Julius Lehmann <lehmanju@devpi.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
 <20240911-sm8150-patches-v3-3-d9164b71316f@devpi.de>
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
In-Reply-To: <20240911-sm8150-patches-v3-3-d9164b71316f@devpi.de>
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

On 11/09/2024 19:13, Julius Lehmann wrote:
> Enable clk and pinctrl for sm8150
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 2a2253f766..e7ed03ff0f 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -48,6 +48,7 @@ CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SC7280=y
>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
> +CONFIG_CLK_QCOM_SM8150=y
>   CONFIG_CLK_QCOM_SM8250=y
>   CONFIG_CLK_QCOM_SM8550=y
>   CONFIG_CLK_QCOM_SM8650=y
> @@ -86,6 +87,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_PINCTRL_QCOM_SM6115=y
> +CONFIG_PINCTRL_QCOM_SM8150=y
>   CONFIG_PINCTRL_QCOM_SM8250=y
>   CONFIG_PINCTRL_QCOM_SM8550=y
>   CONFIG_PINCTRL_QCOM_SM8650=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
