Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D32CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE0D835B0;
	Tue, 30 Sep 2025 20:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I4q/8MbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926D0835B0; Tue, 30 Sep 2025 20:38:34 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84008352B
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so3478839f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257512; x=1759862312; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=q1hQ9S3P14hc2ct4VGoatp4JMBSQVbKxnZhD0u1UoUw=;
 b=I4q/8MbD7VOx8V9HgUQpt+HFiX09a7AEwpKTwinfP7b9/OP/H3+W+ei3Ji8ls5EN21
 UrujXaOB/Z8mFkBrTBfHFczh7YP728PzbOP0qmPYj5+m8+eR1D3qetfcvIodMwRTj7Lo
 tSOy0meEcUre6R1cQfRRIO1E9bNhjVOOzHS8LhRum5bgY+yL9ZkaD6F5ET+4rghDxLdj
 mf4+jBaXwV8vUOorUKa2eHqE2Ub0xWXzB8Jkw5LwiD/EI0FEhNycB8ZuJGzuSg2FxxhM
 jAOVdWSbpEEverm4kNnw9LQ9gtfU4JHGE+vuuubKRHRs8IuO2eApUE6vuPeKo9rmQJkH
 c9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257512; x=1759862312;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q1hQ9S3P14hc2ct4VGoatp4JMBSQVbKxnZhD0u1UoUw=;
 b=AcKQLquH9/Lf7Wg/f2KrL43kUuY3MJnipcK1h+oiM5OyRXdvx3LTEUvctDMN8oZ9eU
 apNyE8givtXQSIJDJgcv7IrPTdS4UKeHYhzV6rJL0Z5C/cBaHW2bEGuxThyuyrZCW4wX
 aFOy6pSYOyrkaFaOzI3w30xeK2jTZPOLx6+nc4AL96ZdNVzaFFU8S9rflglB0Zq0WHGN
 2D/m6q45YyyyzgXJaHOxr5EzWhayGKJ0jOzbIN73F6/Mu0XLbdZjUoyZIP1sweB4jcYL
 0AC0+z3BVLlgiyrOG5VIpHk4nsj7YGRFgkIG6KlpwpY2imCE5geltK3aVvz7mrPKBlpK
 wo3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDcOZWfDzeVR5wI0eSy3sd67SlBSZv5ISn0xtWchhmHykFQAlVD3+93t88eHwA0qV2x3pYzqo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0WbOBubgxOBXu4em6uZAedVeuFRu9BlDv+z/nhjCybkbFNACf
 EcZm46Qm+J4OVnJq88XrfVmHVxGNIbi7VregEXnk4EKjcnbQy3JWIe/Ljz6dsUPnkZg=
X-Gm-Gg: ASbGncsVs4yKcMfXcf0V2Bd2mmjPQ0+egPSEkhq9BmsGPfHEnIy55AA9V2z3awQzBi3
 yyvrki+vjmdvvwsoa0VCjMd2p2yfxX1rxObbv52adY2Fwm8hHxLC5kbckswxRtJ0t0MW0WAODw9
 HLXtSgoCqmUHPIbz7ppRaWz+EBpnnIbFlvZpK70q1AtQbllRjA4ug7M2mzIZOj4ZA6aMceozof9
 OJMuB0cvJRArUxCEtZ8NAIU1y4Qz9IUq3vQ1QVa2Kz8viM8KhrwSc7FZj9WL0qJLoqxeSdZeNMz
 SfcVmSMRYSfx0cW4OlrfxtKjISVI6dY4BsFYT717UvUUDKE1lt6Cq2/YMjuWdAlgAYZtMnoCdKy
 ztNLWd+JeRoETs8S4iVfLljC6Fsa+GiSx5kJGK06v9yHZGynv1dCGm4bCyqCm+lhA/o08zudXvG
 Q5T4yglF9URHIMSW8jTmoLNxHduI+BOMGZ0A==
X-Google-Smtp-Source: AGHT+IGw2cBL5ZRYdjDJPr5O7xi+K7ILhjVRbMgJEOvXhfxCgtuwYHaL3TRGL6mpcnZ0ev59gOjEZA==
X-Received: by 2002:a05:6000:18a6:b0:3fa:2316:c32 with SMTP id
 ffacd0b85a97d-42557820cfbmr533955f8f.57.1759257511705; 
 Tue, 30 Sep 2025 11:38:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb871d051sm24335154f8f.14.2025.09.30.11.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:31 -0700 (PDT)
Message-ID: <f25dda44-ef48-4448-a6a5-b488365b72dd@linaro.org>
Date: Tue, 30 Sep 2025 20:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/5] serial: msm-geni: Update kconfig name for
 DEBUG_UART_MSM_GENI
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
 <20250924-2025-10-misc-v1-3-7e75842ca714@fairphone.com>
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
In-Reply-To: <20250924-2025-10-misc-v1-3-7e75842ca714@fairphone.com>
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

On 9/24/25 13:30, Luca Weiss wrote:
> The previous description "Qualcomm snapdragon" barely tells the user
> anything, update the name so that it's clear which configs the user can
> choose between, namely the older QUP driver, or the newer GENI driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 1f2f2468eb0b32327785f4fcd184b2b6f03a15f6..ccbb40b34fef16e2561bc4bb3ca3284fa700988f 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -328,7 +328,7 @@ config DEBUG_UART_MSM
>   	  be available until the real driver-model serial is running.
>   
>   config DEBUG_UART_MSM_GENI
> -	bool "Qualcomm snapdragon"
> +	bool "Qualcomm GENI UART debug"
>   	depends on ARCH_SNAPDRAGON
>   	help
>   	  Select this to enable a debug UART using the serial_msm driver. You
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
