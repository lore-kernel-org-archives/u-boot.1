Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA443CE8340
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EE988ED7;
	Mon, 30 Sep 2024 15:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aXwB+cyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF96E88F2C; Mon, 30 Sep 2024 15:29:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E461D88EC0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso54098645e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727702983; x=1728307783; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NDGL+y3/yn6+5sUI7NY+ksb9crIR4G2W11BgYgMZDEk=;
 b=aXwB+cyn0NyXM2vEKLkzk3dp0aew5GJmjDxBONLz1kc6gNbvnRA8bmIj2FDToLKgAQ
 7I9Jq6SuARvuuHFfhmKVYl3G+nuQJ3AzAHaZrxxig+aWYtjkGwCk24KrtezF1dJCen/U
 kDO6qYN0lni/Ptnr4MBdigRNZpK25rDGGbFgZrQ0MyISSzON9RvXyFjx2fppqJexC6i6
 5WvubaXHuQ4UKhCSZ/fKgyDAnP1Dmwk817wgsZUvV11GB/63iSUkczT0zSAgc73Av5YW
 fMLEAl3NViartLQwOrOUwVuzFZJ2TNfmVF8qL3Us1jIoe+I9LainIVDB20UYB9wsUnzw
 MIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702983; x=1728307783;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NDGL+y3/yn6+5sUI7NY+ksb9crIR4G2W11BgYgMZDEk=;
 b=J5DoPVpLnv4DgOXc7upTvJwc8Zx2PZowRxHFG1eY1znxm38fKdMU1GeyCpzOKLemnm
 /EWJxU+y4G1helVmUeU+p/xzBhfo8rXczHl/jEwIDTcurXuXAt6fSCekzuoOv7lvGnJZ
 NPPli81hiEbWefGiPm6tEMMdaec2jOwo1gMNEVNAymRaHETzg+FmNS1JGhOtID4cAjYI
 tiETaSN7Qjp3zFMqYMHdaofi8aZ5dWVtDIzKG4GCP/raWIJKqkRWOHEoRga7BiBVvF7I
 adao6N5D0MnCReXGFTt7vTqWXOZyslejtlxIuY2/x/HRrUA0nAp81wuvFFFnnlO0xO53
 eJ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD6woQT2EKBMsiRqJYs/1CgQQd0JCGJBGq48BDrEeDjNo+w3ECQAkU4Dda1xCKrDVk4rvvMVs=@lists.denx.de
X-Gm-Message-State: AOJu0YyMZHfKzRedT2Apy9SR/sbIsI2L6q7rvEDl3dLMWpHLWa4Vj0wH
 or7VBU0/5ptHmoxQBOwA7v55aXqqFl1AsK4UscNzWxvq6YxnYNf3axMYNNx1scI=
X-Google-Smtp-Source: AGHT+IEpRQS5qIkcnt0d/40PU8N22VY2PljpflpniZJ1ndyPhvBrfzaNXrc5DyW2/vEGjk2U6Rok7w==
X-Received: by 2002:a05:600c:1c26:b0:42c:bd5a:9455 with SMTP id
 5b1f17b1804b1-42f5844bd20mr131791555e9.18.1727702983185; 
 Mon, 30 Sep 2024 06:29:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bdc6:abc9:5047:7828?
 ([2a01:e0a:982:cbb0:bdc6:abc9:5047:7828])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dec19bsm104491025e9.26.2024.09.30.06.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 06:29:42 -0700 (PDT)
Message-ID: <48900864-4f02-482a-b362-028ca21f5a34@linaro.org>
Date: Mon, 30 Sep 2024 15:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] arm: dts: bcm: Update bcm6846 and bcm96846
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
 <20240930-bcmbca-nand-support-v1-2-e637c65de947@linaro.org>
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
In-Reply-To: <20240930-bcmbca-nand-support-v1-2-e637c65de947@linaro.org>
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

Hi,

On 30/09/2024 15:24, Linus Walleij wrote:
> Update the devicetrees for the BCM6846 and the reference
> design BCM96846 from the Linux kernel so we get support
> for NAND. (Linux v6.11-rc7).

Maybe time to switch to OF_UPSTREAM instead of syncing ?

Neil

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/dts/bcm6846.dtsi | 34 ++++++++++++++++++++++++++++++++++
>   arch/arm/dts/bcm96846.dts | 14 ++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm/dts/bcm6846.dtsi b/arch/arm/dts/bcm6846.dtsi
> index 8aa47a2583b2..ee361cb00b7c 100644
> --- a/arch/arm/dts/bcm6846.dtsi
> +++ b/arch/arm/dts/bcm6846.dtsi
> @@ -35,6 +35,8 @@
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> @@ -60,6 +62,12 @@
>   			#clock-cells = <0>;
>   			clock-frequency = <200000000>;
>   		};
> +
> +		hsspi_pll: hsspi-pll {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
>   	};
>   
>   	psci {
> @@ -99,5 +107,31 @@
>   			clock-names = "refclk";
>   			status = "disabled";
>   		};
> +
> +		hsspi: spi@1000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "brcm,bcm6846-hsspi", "brcm,bcmbca-hsspi-v1.0";
> +			reg = <0x1000 0x600>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&hsspi_pll &hsspi_pll>;
> +			clock-names = "hsspi", "pll";
> +			num-cs = <8>;
> +			status = "disabled";
> +		};
> +
> +		nand_controller: nand-controller@1800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
> +			reg = <0x1800 0x600>, <0x2000 0x10>;
> +			reg-names = "nand", "nand-int-base";
> +			status = "disabled";
> +
> +			nandcs: nand@0 {
> +				compatible = "brcm,nandcs";
> +				reg = <0>;
> +			};
> +		};
>   	};
>   };
> diff --git a/arch/arm/dts/bcm96846.dts b/arch/arm/dts/bcm96846.dts
> index c70ebccabc19..943896afb7cc 100644
> --- a/arch/arm/dts/bcm96846.dts
> +++ b/arch/arm/dts/bcm96846.dts
> @@ -28,3 +28,17 @@
>   &uart0 {
>   	status = "okay";
>   };
> +
> +&hsspi {
> +	status = "okay";
> +};
> +
> +&nand_controller {
> +	brcm,wp-not-connected;
> +	status = "okay";
> +};
> +
> +&nandcs {
> +	nand-on-flash-bbt;
> +	brcm,nand-ecc-use-strap;
> +};
> 

