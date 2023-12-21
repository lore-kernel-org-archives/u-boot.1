Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800E6C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AEB878D6;
	Thu, 21 Dec 2023 17:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I4mPcCvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16388786E; Thu, 21 Dec 2023 17:40:32 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E56878F4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3367a304091so909472f8f.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176828; x=1703781628; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zfvD7Kbpg6ThESznwG7za9jeFjP2fNZPPwUtmv0oPqo=;
 b=I4mPcCvASa5RPG9JH2szfBfAbJpNbCoZRPWnyuiPjGTK9xSNzbdPF7Tfyy75ONumcT
 q3wL+bX3HL0JieDFKKQw8pNvk0BV5uX+gFf+PYO/FfWbrVUxccCjDjXaCS5CpctMbOI7
 d+JfZgPvXx07unRr/0jQQHbl3SmkFy03HgYIFKJVrnp6Rsqzqvi5IPqD3RhXKBrSldet
 Q42BH1NfADcoELaS+7Wy9ziQR8ks6bEH33EwwdxqrKOUkgXV4fjF+4s2UkVT9N3NT6k6
 rMAypLW4HvvkuapnEVq6siPNYfuEeoXHvtOzNVd5xxr8ws6RzxvP5QbmVqoio/hMhbwW
 AScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176828; x=1703781628;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zfvD7Kbpg6ThESznwG7za9jeFjP2fNZPPwUtmv0oPqo=;
 b=KPnmWfc7Ha+zmIKdwgZLFs1bSNibe5F3COvqM+UQcLESIT8cmy1ITdyGwg62f8vmJN
 LmlVI6acOh+Lmxks1aV6P1bg/AmkuWZ6IJXxG5SPYCDkQdqveVfqZByNaVvoRZiSSGgs
 dkgSUgKUUVBWOHtf5QXxuD+RPxHU/Uh2i62RwFUiI1oBVHliea81tGWHAXNDnizDB5/M
 KrYsH0qpZ7sSm+tqBNA8GVbxULCBYpGT2omvjE9wAd7G6lPd10aQbR5N5ovrHpIZMXH5
 +haYnsabZ1RcQe/JT3M+Q0pHx7OlNt1meh/jilvB+POqTNc41uPPfA9S6OQa6yy/SRvS
 BszA==
X-Gm-Message-State: AOJu0YwWhKydDiR1Dlgo6mU8sE2DZ85/pwZhjKnpE95TKIJ/AAOAC+mo
 L03uyYNZOmxbawJ0XYq3Uzbhz25PdYEFAg==
X-Google-Smtp-Source: AGHT+IGTSeySUaO5zQDIYAuYQ7jhGkrVuunVOZKiCGa3hHLrr8diGDfOMoYV2MfM2t7fzOWeDOWPeQ==
X-Received: by 2002:adf:a4dd:0:b0:336:5f9a:cea4 with SMTP id
 h29-20020adfa4dd000000b003365f9acea4mr24978wrb.62.1703176827854; 
 Thu, 21 Dec 2023 08:40:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm2372633wrj.112.2023.12.21.08.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:40:27 -0800 (PST)
Message-ID: <aa9fbefc-1e48-4d5b-87fa-e141e6ac87c3@linaro.org>
Date: Thu, 21 Dec 2023 17:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 32/32] MAINTAINERS: Qualcomm: add some missing paths
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-32-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-32-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Add drivers and DTS files, as well as regex matches for
> qcom/qualcomm/snapdragon.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   MAINTAINERS | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cd102eaa070..b41801078c94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -571,18 +571,22 @@ M:	Caleb Connolly <caleb.connolly@linaro.org>
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   R:	Sumit Garg <sumit.garg@linaro.org>
>   S:	Maintained
> -F:	arch/arm/mach-snapdragon/
> -F:	drivers/button/button-qcom-pmic.c
> -F:	drivers/clk/qcom/
> +F:	arch/arm/dts/msm8*.dtsi
> +F:	arch/arm/dts/pm8???.dtsi
> +F:	arch/arm/dts/pms405.dtsi
> +F:	arch/arm/dts/sdm845.dtsi
> +F:	drivers/*/*/pm8???-*
>   F:	drivers/gpio/msm_gpio.c
>   F:	drivers/mmc/msm_sdhci.c
>   F:	drivers/phy/msm8916-usbh-phy.c
> -F:	drivers/pinctrl/qcom/
>   F:	drivers/serial/serial_msm.c
>   F:	drivers/serial/serial_msm_geni.c
>   F:	drivers/smem/msm_smem.c
>   F:	drivers/spmi/spmi-msm.c
>   F:	drivers/usb/host/ehci-msm.c
> +N:	qcom
> +N:	snapdragon
> +N:	qualcomm
>   
>   ARM STI
>   M:	Patrice Chotard <patrice.chotard@foss.st.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
