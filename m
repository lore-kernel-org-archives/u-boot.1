Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E39C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218C48788D;
	Thu, 21 Dec 2023 17:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vg2q/qil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF6A8786E; Thu, 21 Dec 2023 17:39:00 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBF9878A4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e1112b95cso1200801e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176732; x=1703781532; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4uxOo+jjZS/1lo7o7evVd8vijjQe1z/YZ1P6cviPOA0=;
 b=Vg2q/qil5T2QLpdSPBb1uJlw0Fvr8V0zS9CUshtxNEnQ9Jzoa1pWh+OPh/R0+KBGeB
 LR2rLH0xpxJDvY4FIc5NFsb4amdlSsyVuFqRmiCwm9M81ByPinzONe5J1h0IjDpGhqc5
 shONGYn/JXoknrtZqYvvuVSXXB4LceczvMixBWHpcil4stdyvdX8/1PkWGDBa3iocDNT
 TUC2ig/kno7ZLWvNwu7RedrfNtoaxMe9fN5rj8LDNRU7zwpaTyHiBsaL0DT8ua9rfwn+
 QIlj3PV3SJfsPP1PoFTSFJFHt3VsJXk4tK4EA0mn6cSygJlsjGOlGhhwnPnTOjlMW8U1
 3bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176732; x=1703781532;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4uxOo+jjZS/1lo7o7evVd8vijjQe1z/YZ1P6cviPOA0=;
 b=XPEUAhr666Lm4WJJcHUvZp4y7tFAvlilHrALus44T4+t5iEEFBZBWvETwhTIvly/PB
 XTS5ZABeK2pbADhN676yVQQNC6/mV0bhV0XYeYxVju2ejYVxnJekLgHWQ0W+3VNl0kT2
 ljJ6SaomRzYb+I3uaQRhPDgyaMqPWMty8gNuO4YQspEvmfLewLHDNeg+2PTo0KX4AlEj
 6VGvOwH3MKNdakTh7nU5EcpcyA/SRXka9Ib4NRpAK3xe57OCYRZnYhGNKTyNfdnMsjEE
 ppfCl8an4s3bKYgJyMLYoSAn+/QHBr2xJRd6T0f2DNo62XPBPBs+pSSf77+T7m2Xm8ft
 OGRA==
X-Gm-Message-State: AOJu0YwAKTSYSY+cb6vLzgoFaQlQKnkuPJtbyOqGgAr38jjHC5sa5IU6
 m5WdZ56AwMcvJl6k53AFAXM6PA==
X-Google-Smtp-Source: AGHT+IEho1j5c7mkJOwuxtR53WQQ/dMaOl67i1uOLMjo7dSvPuvEZsr4eHmpuPgO9sSZTxf88Ywj7w==
X-Received: by 2002:a05:6512:68b:b0:50e:4a74:23a8 with SMTP id
 t11-20020a056512068b00b0050e4a7423a8mr2088121lfe.150.1703176732492; 
 Thu, 21 Dec 2023 08:38:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm2372633wrj.112.2023.12.21.08.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:38:52 -0800 (PST)
Message-ID: <5e394e26-efd9-4abc-96c0-9b1afb3c1848@linaro.org>
Date: Thu, 21 Dec 2023 17:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 27/32] dts: dragonboard820c: use correct bindings for
 clocks
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
 <20231219-b4-qcom-common-target-v2-27-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-27-b6dd9704219e@linaro.org>
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
> Don't use hardcoded clock IDs, use the IDs from the dt-bindings to be
> compatible with upstream.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard820c.dts | 5 +++--
>   drivers/clk/qcom/clock-apq8096.c | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 86b7f83d36d6..282c37e28f42 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -8,6 +8,7 @@
>   /dts-v1/;
>   
>   #include "skeleton64.dtsi"
> +#include <dt-bindings/clock/qcom,gcc-msm8996.h>
>   
>   / {
>   	model = "Qualcomm Technologies, Inc. DB820c";
> @@ -78,7 +79,7 @@
>   		blsp2_uart2: serial@75b0000 {
>   			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>   			reg = <0x75b0000 0x1000>;
> -			clocks = <&gcc 4>;
> +			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>;
>   			clock-names = "core";
>   			pinctrl-names = "uart";
>   			pinctrl-0 = <&blsp8_uart>;
> @@ -89,7 +90,7 @@
>   			reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
>   			index = <0x0>;
>   			bus-width = <4>;
> -			clock = <&gcc 0>;
> +			clock = <&gcc GCC_SDCC1_APPS_CLK>;
>   			clock-frequency = <200000000>;
>   		 };
>   
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 1e6fdb5cd42d..a4731613c5e0 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -13,6 +13,7 @@
>   #include <errno.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8996.h>
>   
>   #include "clock-qcom.h"
>   
> @@ -107,10 +108,10 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>   
>   	switch (clk->id) {
> -	case 0: /* SDC1 */
> +	case GCC_SDCC1_APPS_CLK: /* SDC1 */
>   		return clk_init_sdc(priv, rate);
>   		break;
> -	case 4: /*UART2*/
> +	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
>   		return clk_init_uart(priv);
>   	default:
>   		return 0;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
