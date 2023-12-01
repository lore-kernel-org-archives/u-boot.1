Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F46C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95FD87483;
	Fri,  1 Dec 2023 10:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rqd2te90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7D086F50; Fri,  1 Dec 2023 10:34:12 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBDC876C6
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33330305372so460724f8f.3
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423247; x=1702028047; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+jyqf/1Ai+8YDs8Ii91Bf2mTvxZl327YqyYGP4egj7g=;
 b=rqd2te903/1cVD/F6UOdFwlGguJ28pFc+p65dFIkr7Ywn4JbhEnC60FZIwlrWN+U/R
 wYpED1Lu4k6B3/yn45APRQHlqfmXZNKb5J+HjzFFhf+OUDgPsXoLptoZPkqpsn7RNGgo
 ZFQupGXxl/XvguS9UkqnDsBKzqyIPRv69HogrDB9OgTfftfB35pNgHoZ/VbHZPblUWOb
 rexg+Jf8gGOrhhy8yptHyonD0Q9WXaUeOeAEvLWRqOcH9871EdciFnBKSNJKHXQgON5C
 zeu7fb/F1sLLucp35fHlLiu2M/trE1GRd2iRqlv4v8po+iRw14fVCk5/GZ4OKjZLNdgp
 Ds+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423247; x=1702028047;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+jyqf/1Ai+8YDs8Ii91Bf2mTvxZl327YqyYGP4egj7g=;
 b=LRKn6bItomsBC0Mdf4yQOiZdOMENSlPzcv3aTpF7GV2ekhiUG48LyQctRn4uR7ZxlR
 xSjUv/hokFGIKLkc5Y3LnxptgnaEfezoLOgpJSvX6mBbbKNwCi5Xn9osm2wogJvEknRp
 bF/3rjfd0G84VsJrvhJJ9XCy6xKdaKTP7G9vJ9LdEJCGoDNHPY715ZQrS2vvWFpk3n0l
 Hbj6nhAY7Eodg1FZiwDiV+LxrWMOZVubIqRI+uMqEyuQg9pdSJHtNpwvsru2x5gKcbWx
 cWAw2vgG8aT1NONdDbKrrDXGFSSfDAiUWBqvjBsiurg4xHpYQRBSzITZUu2mG63J6rO8
 TRjQ==
X-Gm-Message-State: AOJu0Yy3PcsbycmRFqDF27kuKIOtHvu2TVIgyqC1xN3UbVZjkMEvFIuQ
 fuvNlKStTA44tJ6kQhMAtA4bcQ==
X-Google-Smtp-Source: AGHT+IELs9mwX6zZAodkUxZS62EVDKIDTof1AN4WVNDqbYBFD+i08Z9jV1ab9VA+HMuASARGtRI3Rg==
X-Received: by 2002:a5d:54c9:0:b0:333:2fd2:6f5d with SMTP id
 x9-20020a5d54c9000000b003332fd26f5dmr452649wrv.103.1701423247222; 
 Fri, 01 Dec 2023 01:34:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm3695695wrm.27.2023.12.01.01.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:34:06 -0800 (PST)
Message-ID: <6dd8c405-0006-44f6-8ecf-235f1c675bc5@linaro.org>
Date: Fri, 1 Dec 2023 10:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
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
 <20231130-b4-qcom-dt-compat-v5-6-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-6-41500e237ad0@linaro.org>
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
> Use the upstream gpio-ranges property instead of gpio-count, and drop
> the bank-name property for Qualcomm boards.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c.dts | 3 +--
>   arch/arm/dts/dragonboard820c.dts | 3 +--
>   arch/arm/dts/qcs404-evb.dts      | 2 +-
>   arch/arm/dts/sdm845.dtsi         | 3 +--
>   4 files changed, 4 insertions(+), 7 deletions(-)
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
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
