Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561BC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E94182D7C;
	Fri, 20 Jun 2025 10:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u7nfWzbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E2382D7C; Fri, 20 Jun 2025 10:56:33 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A746D82E17
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so807836f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409791; x=1751014591; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ENfwUEKQuTn05zB9DeGiH3b7FviC6d/wPiV3h1/av1k=;
 b=u7nfWzbjtVEDatTHLH7kkTJ6vqRn4UDQkWIvRO14CaXqkj0eUM8nzC+EVmWpvRiKse
 54rFfg6YmjpryPW6FixFc6MiXKjYzQQYhXZ5JeYqs4/rmKmmsbm5pEe9L8GD5pIMvz3M
 OBttkCUulN+i51VJaAyWPqyk+sOZvR/mQ4gZQbxiTnZfey7OEvBD60Ys9dRr5FHx5lZ2
 nLGAUpPGVUiYeH93CDJRm8486RSV46UbKbfc3E8KKOR0uew0rJvNbgXzI+6wtbN81ley
 Ujrai/IjQDwGPuUwysxuyVNmT9+oO0CXjjgKptzxtPIhUcR32cty5E+TQzFYih9A3ZZA
 7tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409791; x=1751014591;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ENfwUEKQuTn05zB9DeGiH3b7FviC6d/wPiV3h1/av1k=;
 b=UZJYdJ9kLPmNmjsatBOKbwjZnCjuD7exU8u1GDMmfph7/pVMISUyshhI8un6hVKXcb
 We0zTdoJvv9v0w6Bh6XdkvpJM8fYjB7bgICHFauMWR0Y7NFlRGL8NnbAY8blfvhJbq7L
 unkyTLrKwd/8WGzrrfB1vceVVSKqjHf8RVP3zjwsht8wxarbeWPwi0p+dQBMER+TTEEH
 MzPnPqvgWSqiLWH1ntf/tLT1suYYdbO59e8XImrPgmhcPs3xGbUp5E8d71zXRLdZKaTw
 zExATuQ2vTh+mao/wP1nfZ0yns/mTEW3Ez2joSY+LWlOdhb1Hd7v7YGzISzp/o0f7HM1
 ogpQ==
X-Gm-Message-State: AOJu0YwHBYtXl4ClxEv2l2IGCSHcFRwtQhVdVNCuF7AKZtap8LoYqo2S
 2ZqIxdaavpF68CEdyPngxRRAia4Tdze71rfh6wopVegfPj4F4/S+v03Tjj3rG0VMTEo=
X-Gm-Gg: ASbGncugUv2zccXd/H2D1K6N+sCTdlW6UCL/pem9Gid+YkfJxKbq4VWlhsz2MuzivkE
 Grbd+qkCE//rdmLULySHgOsdeC4pAjRsux0ypQYFLyNq/XDTz0aItr6VSNCazJeDdqbgMhYwNQ/
 kmSKIFjz07tFV6ubkW+lt3NN4nJU+YqaGvoTTbPJAsoQeNF3ztTrNiOHAHlN7DlXO0PdxMY6SkN
 BUOmL3cagnVTfALdq9a+EmaZyiZ12on6iHTuKLgz61bJi0RrYaq/kFzSCBMIKcZLZsntbSuXfPI
 CkiQ4LxHwzoYF3+Xj2N5wjABgxxAIb0iNGEdAfY6Hh1eWixB9SUCwXuqgd+RrWFvukeSYbJEhiO
 Qrl8hE571lQEaWURCc1Y3JXAntSm0o6nGPN5F5ls=
X-Google-Smtp-Source: AGHT+IFfc4y2Pt3ZSalCQH7d/Yj2ck7cfteoh1piimTKvF0Y0EQj45qwyBPm5eFR7AvtoGyV+l01iw==
X-Received: by 2002:a05:6000:3111:b0:3a4:ea8f:efe4 with SMTP id
 ffacd0b85a97d-3a6d12a0d6dmr1423361f8f.18.1750409791101; 
 Fri, 20 Jun 2025 01:56:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c16sm51629345e9.19.2025.06.20.01.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:56:30 -0700 (PDT)
Message-ID: <7b9161f6-df38-4edc-8aa6-2d5ab5d8e9ea@linaro.org>
Date: Fri, 20 Jun 2025 10:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 7/8] qcom_defconfig: Enable SM6350 clock and pinctrl
 drivers
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-7-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-7-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> Enable the drivers so that SM6350 devices can boot with qcom_defconfig.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index b8399701da06e20cb5d21c4de1fbeb38df671be6..068475d59da5890858ee8e48af148db33ffcedc2 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -54,6 +54,7 @@ CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SA8775P=y
>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
> +CONFIG_CLK_QCOM_SM6350=y
>   CONFIG_CLK_QCOM_SM8150=y
>   CONFIG_CLK_QCOM_SM8250=y
>   CONFIG_CLK_QCOM_SM8550=y
> @@ -106,6 +107,7 @@ CONFIG_PINCTRL_QCOM_SA8775P=y
>   CONFIG_PINCTRL_QCOM_SC7280=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_PINCTRL_QCOM_SM6115=y
> +CONFIG_PINCTRL_QCOM_SM6350=y
>   CONFIG_PINCTRL_QCOM_SM8150=y
>   CONFIG_PINCTRL_QCOM_SM8250=y
>   CONFIG_PINCTRL_QCOM_SM8550=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
