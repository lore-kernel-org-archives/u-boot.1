Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DCCC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AFA87483;
	Fri,  1 Dec 2023 10:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KWtvDyz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2929876B2; Fri,  1 Dec 2023 10:33:22 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 568D086F50
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3332fc9b9b2so594599f8f.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423200; x=1702028000; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CEWD6sX9PSD00mUCH7m25ZYqLoKsmV3BdGsVXD3hPCI=;
 b=KWtvDyz1hUXi7HLU8oLOczQ1l/Pbbf0fuktHaZjhL0lCzegToPfIb+MBC9Fr4pjhS9
 yZ7Xmc58dnxvk8wXKoOK1rezPxCPK+ePBs5CSEpeVnvIqPhYjOgoeTeUqV/oZ2I27DDV
 Z2AWz5c49HtaUMyeRkbmwazzWCTZZm0YoHtadDwyow0NPraMjQ69TvkF+eYBcS1foRYz
 qX3tkyN5va4cGEcoQb45qdwdciYOz5jkCCAqBGyQvfuS5jwWCkrRx9WWSJlV9k58GXpm
 uth7ll13Qc5mYMDXpfrBir8DL7N0f9G3tAgqrODQHUTYgrlyUYfsW+WF3jk2kmljWJqi
 BS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423200; x=1702028000;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CEWD6sX9PSD00mUCH7m25ZYqLoKsmV3BdGsVXD3hPCI=;
 b=I5N3ex/TFHvtL6Jv2ZLO3OO1l0k718FgNySlZ2o9edY6lKXi8HcY1mM+M/vVNwUzBl
 aSz2YsAYnadY4ehe3RHDoxL+H/eAQn0MsiVbBx2TZZUfveLynbnfGQAIDHY8gbamu/34
 2gw0sDGx/cH8O3ypnKubWmR/msPq1Wj7u1+uZq7+Acr2McE9f4bOPE01A2Ak3eXlImGd
 vOf1Nkhu9Yyij91gzKpebU0ZrTWLYAd76QSD/BLMJnnAlGAhvo6M62uJn+2/6SJ0KReC
 EOseYwkkBWE6Z9ZEooA1rlMa/PQllpKK6V6a708YoccarIDe+uGCyLB5Kkio/k0hovo4
 IcMg==
X-Gm-Message-State: AOJu0Yx8vSp1YeDOHCHRbYYg5GHHnUe4yA/SYbRpuo7Sxqw6cITXkaTE
 e+Tj812T/NQefPVfWeAaX6vjUw==
X-Google-Smtp-Source: AGHT+IE2lDDWeINV6FXwBbLT48xQOhRQh6En6hd7R6YJxYv9+nUnkPGAHOzo9hLQ/nRAVS2v4p1NuA==
X-Received: by 2002:a5d:410f:0:b0:333:3117:c441 with SMTP id
 l15-20020a5d410f000000b003333117c441mr327186wrp.210.1701423199620; 
 Fri, 01 Dec 2023 01:33:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm3695695wrm.27.2023.12.01.01.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:33:19 -0800 (PST)
Message-ID: <f0e6c06c-4924-4597-8cd7-68e420ee9155@linaro.org>
Date: Fri, 1 Dec 2023 10:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/9] mach-snapdragon: switch to PMIC button driver
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
 <20231130-b4-qcom-dt-compat-v5-3-41500e237ad0@linaro.org>
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
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-3-41500e237ad0@linaro.org>
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
> The PMIC button driver is a much better representation of the hardware
> here, adjust the boards to use upstream DT and the PMIC button driver
> instead of exposing the buttons as GPIOs and relying on the GPIO-button
> driver.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c-uboot.dtsi          | 11 ------
>   arch/arm/dts/dragonboard410c.dts                 | 22 +++++++++---
>   arch/arm/dts/dragonboard820c-uboot.dtsi          | 12 -------
>   arch/arm/dts/dragonboard820c.dts                 | 23 ++++++++----
>   arch/arm/dts/dragonboard845c-uboot.dtsi          | 11 ------
>   arch/arm/dts/dragonboard845c.dts                 |  4 +++
>   arch/arm/dts/sdm845.dtsi                         | 23 +++++++++---
>   arch/arm/dts/starqltechn-uboot.dtsi              | 10 ------
>   arch/arm/dts/starqltechn.dts                     | 20 +++--------
>   arch/arm/mach-snapdragon/Kconfig                 |  3 ++
>   arch/arm/mach-snapdragon/init_sdm845.c           | 45 +++++-------------------
>   board/qualcomm/dragonboard410c/dragonboard410c.c | 31 ++++++----------
>   board/qualcomm/dragonboard820c/dragonboard820c.c | 29 +++++----------
>   13 files changed, 91 insertions(+), 153 deletions(-)
> 
> diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
> index 3b0bd0ed0a1b..cec64bf80f99 100644
> --- a/arch/arm/dts/dragonboard410c-uboot.dtsi
> +++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
> @@ -42,14 +42,3 @@
>   		gpios = <&pm8916_gpios 3 0>;
>   	};
>   };
> -
> -
> -&pm8916_pon {
> -	key_vol_down {
> -		gpios = <&pm8916_pon 1 0>;
> -	};
> -
> -	key_power {
> -		gpios = <&pm8916_pon 0 0>;
> -	};
> -};
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index 9230dd3fd96c..c41fee977813 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -147,11 +147,23 @@
>   				#address-cells = <0x1>;
>   				#size-cells = <0x1>;
>   
> -				pm8916_pon: pm8916_pon@800 {
> -					compatible = "qcom,pm8916-pwrkey";
> -					reg = <0x800 0x96>;
> -					#gpio-cells = <2>;
> -					gpio-controller;
> +				pon@800 {
> +					compatible = "qcom,pm8916-pon";
> +					reg = <0x800 0x100>;
> +					mode-bootloader = <0x2>;
> +					mode-recovery = <0x1>;
> +
> +					pwrkey {
> +						compatible = "qcom,pm8941-pwrkey";
> +						debounce = <15625>;
> +						bias-pull-up;
> +					};
> +
> +					pm8916_resin: resin {
> +						compatible = "qcom,pm8941-resin";
> +						debounce = <15625>;
> +						bias-pull-up;
> +					};
>   				};
>   
>   				pm8916_gpios: pm8916_gpios@c000 {
> diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
> index 457728a43ecb..d93c7c1fbdee 100644
> --- a/arch/arm/dts/dragonboard820c-uboot.dtsi
> +++ b/arch/arm/dts/dragonboard820c-uboot.dtsi
> @@ -30,15 +30,3 @@
>   		};
>   	};
>   };
> -
> -&pm8994_pon {
> -	key_vol_down {
> -		gpios = <&pm8994_pon 1 0>;
> -		label = "key_vol_down";
> -	};
> -
> -	key_power {
> -		gpios = <&pm8994_pon 0 0>;
> -		label = "key_power";
> -	};
> -};
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index ad201d48749c..0d9c9f7a4922 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -109,12 +109,23 @@
>   				#address-cells = <0x1>;
>   				#size-cells = <0x1>;
>   
> -				pm8994_pon: pm8994_pon@800 {
> -					compatible = "qcom,pm8994-pwrkey";
> -					reg = <0x800 0x96>;
> -					#gpio-cells = <2>;
> -					gpio-controller;
> -					gpio-bank-name="pm8994_key.";
> +				pm8994_pon: pon@800 {
> +					compatible = "qcom,pm8916-pon";
> +					reg = <0x800 0x100>;
> +					mode-bootloader = <0x2>;
> +					mode-recovery = <0x1>;
> +
> +					pwrkey {
> +						compatible = "qcom,pm8941-pwrkey";
> +						debounce = <15625>;
> +						bias-pull-up;
> +					};
> +
> +					pm8994_resin: resin {
> +						compatible = "qcom,pm8941-resin";
> +						debounce = <15625>;
> +						bias-pull-up;
> +					};
>   				};
>   
>   				pm8994_gpios: pm8994_gpios@c000 {
> diff --git a/arch/arm/dts/dragonboard845c-uboot.dtsi b/arch/arm/dts/dragonboard845c-uboot.dtsi
> index 7728f4f4a3e5..775f45c0149f 100644
> --- a/arch/arm/dts/dragonboard845c-uboot.dtsi
> +++ b/arch/arm/dts/dragonboard845c-uboot.dtsi
> @@ -24,14 +24,3 @@
>   		};
>   	};
>   };
> -
> -&pm8998_pon {
> -	key_vol_down {
> -		gpios = <&pm8998_pon 1 0>;
> -		label = "key_vol_down";
> -	};
> -	key_power {
> -		gpios = <&pm8998_pon 0 0>;
> -		label = "key_power";
> -	};
> -};
> diff --git a/arch/arm/dts/dragonboard845c.dts b/arch/arm/dts/dragonboard845c.dts
> index b4f057ac6537..054f253eb32a 100644
> --- a/arch/arm/dts/dragonboard845c.dts
> +++ b/arch/arm/dts/dragonboard845c.dts
> @@ -41,4 +41,8 @@
>   	};
>   };
>   
> +&pm8998_resin {
> +	status = "okay";
> +};
> +
>   #include "dragonboard845c-uboot.dtsi"
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index 4798ace0ff8b..cd5d890e9a45 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -78,12 +78,25 @@
>   				#address-cells = <0x1>;
>   				#size-cells = <0x1>;
>   
> -				pm8998_pon: pm8998_pon@800 {
> -					compatible = "qcom,pm8998-pwrkey";
> +				pm8998_pon: pon@800 {
> +					compatible = "qcom,pm8998-pon";
> +
>   					reg = <0x800 0x100>;
> -					#gpio-cells = <2>;
> -					gpio-controller;
> -					gpio-bank-name = "pm8998_key.";
> +					mode-bootloader = <0x2>;
> +					mode-recovery = <0x1>;
> +
> +					pm8998_pwrkey: pwrkey {
> +						compatible = "qcom,pm8941-pwrkey";
> +						debounce = <15625>;
> +						bias-pull-up;
> +					};
> +
> +					pm8998_resin: resin {
> +						compatible = "qcom,pm8941-resin";
> +						debounce = <15625>;
> +						bias-pull-up;
> +						status = "disabled";
> +					};
>   				};
>   
>   				pm8998_gpios: pm8998_gpios@c000 {
> diff --git a/arch/arm/dts/starqltechn-uboot.dtsi b/arch/arm/dts/starqltechn-uboot.dtsi
> index 034d5c1c07ed..55c6d18412ba 100644
> --- a/arch/arm/dts/starqltechn-uboot.dtsi
> +++ b/arch/arm/dts/starqltechn-uboot.dtsi
> @@ -25,13 +25,3 @@
>   	};
>   };
>   
> -&pm8998_pon {
> -	key_vol_down {
> -		gpios = <&pm8998_pon 1 0>;
> -		label = "key_vol_down";
> -	};
> -	key_power {
> -		gpios = <&pm8998_pon 0 0>;
> -		label = "key_power";
> -	};
> -};
> diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
> index 5b6372bee79a..0842e19adb60 100644
> --- a/arch/arm/dts/starqltechn.dts
> +++ b/arch/arm/dts/starqltechn.dts
> @@ -45,22 +45,6 @@
>   		format = "a8r8g8b8";
>   	};
>   
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -
> -		key-pwr {
> -			label = "Power";
> -			linux,code = <KEY_ENTER>;
> -			gpios = <&pm8998_pon 0 GPIO_ACTIVE_LOW>;
> -		};
> -
> -		key-vol-down {
> -			label = "Volume Down";
> -			linux,code = <KEY_DOWN>;
> -			gpios = <&pm8998_pon 1 GPIO_ACTIVE_LOW>;
> -		};
> -	};
> -
>   	soc: soc {
>   		serial@a84000 {
>   			status = "okay";
> @@ -68,6 +52,10 @@
>   	};
>   };
>   
> +&pm8998_resin {
> +	status = "okay";
> +};
> +
>   &tlmm {
>   	muic_i2c: muic-i2c-n {
>   		pins = "GPIO_33", "GPIO_34";
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 3c9f3bee3f18..ad6671081910 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -17,6 +17,7 @@ config SDM845
>   	select LINUX_KERNEL_IMAGE_HEADER
>   	imply CLK_QCOM_SDM845
>   	imply PINCTRL_QCOM_SDM845
> +	imply BUTTON_QCOM_PMIC
>   
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default 0x80000000
> @@ -30,6 +31,7 @@ config TARGET_DRAGONBOARD410C
>   	select ENABLE_ARM_SOC_BOOT0_HOOK
>   	imply CLK_QCOM_APQ8016
>   	imply PINCTRL_QCOM_APQ8016
> +	imply BUTTON_QCOM_PMIC
>   	help
>   	  Support for 96Boards Dragonboard 410C. This board complies with
>   	  96Board Open Platform Specifications. Features:
> @@ -45,6 +47,7 @@ config TARGET_DRAGONBOARD820C
>   	bool "96Boards Dragonboard 820C"
>   	imply CLK_QCOM_APQ8096
>   	imply PINCTRL_QCOM_APQ8096
> +	imply BUTTON_QCOM_PMIC
>   	help
>   	  Support for 96Boards Dragonboard 820C. This board complies with
>   	  96Board Open Platform Specifications. Features:
> diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
> index 1f8850239437..067acc9a6f44 100644
> --- a/arch/arm/mach-snapdragon/init_sdm845.c
> +++ b/arch/arm/mach-snapdragon/init_sdm845.c
> @@ -5,6 +5,7 @@
>    * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
>    */
>   
> +#include <button.h>
>   #include <init.h>
>   #include <env.h>
>   #include <common.h>
> @@ -32,46 +33,18 @@ __weak int board_init(void)
>   /* Check for vol- and power buttons */
>   __weak int misc_init_r(void)
>   {
> -	struct udevice *pon;
> -	struct gpio_desc resin;
> -	int node, ret;
> +	struct udevice *btn;
> +	int ret;
> +	enum button_state_t state;
>   
> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8998_pon@800", &pon);
> +	ret = button_get_by_label("pwrkey", &btn);
>   	if (ret < 0) {
> -		printf("Failed to find PMIC pon node. Check device tree\n");
> -		return 0;
> +		printf("Couldn't find power button!\n");
> +		return ret;
>   	}
>   
> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
> -				  "key_vol_down");
> -	if (node < 0) {
> -		printf("Failed to find key_vol_down node. Check device tree\n");
> -		return 0;
> -	}
> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -				       &resin, 0)) {
> -		printf("Failed to request key_vol_down button.\n");
> -		return 0;
> -	}
> -	if (dm_gpio_get_value(&resin)) {
> -		env_set("key_vol_down", "1");
> -		printf("Volume down button pressed\n");
> -	} else {
> -		env_set("key_vol_down", "0");
> -	}
> -
> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
> -				  "key_power");
> -	if (node < 0) {
> -		printf("Failed to find key_power node. Check device tree\n");
> -		return 0;
> -	}
> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -				       &resin, 0)) {
> -		printf("Failed to request key_power button.\n");
> -		return 0;
> -	}
> -	if (dm_gpio_get_value(&resin)) {
> +	state = button_get_state(btn);
> +	if (state == BUTTON_ON) {
>   		env_set("key_power", "1");
>   		printf("Power button pressed\n");
>   	} else {
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 371b3262f8c5..350e0e9e20aa 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -5,6 +5,7 @@
>    * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>    */
>   
> +#include <button.h>
>   #include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> @@ -108,32 +109,20 @@ int board_usb_init(int index, enum usb_init_type init)
>   /* Check for vol- button - if pressed - stop autoboot */
>   int misc_init_r(void)
>   {
> -	struct udevice *pon;
> -	struct gpio_desc resin;
> -	int node, ret;
> +	struct udevice *btn;
> +	int ret;
> +	enum button_state_t state;
>   
> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8916_pon@800", &pon);
> +	ret = button_get_by_label("vol_down", &btn);
>   	if (ret < 0) {
> -		printf("Failed to find PMIC pon node. Check device tree\n");
> -		return 0;
> +		printf("Couldn't find power button!\n");
> +		return ret;
>   	}
>   
> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
> -				  "key_vol_down");
> -	if (node < 0) {
> -		printf("Failed to find key_vol_down node. Check device tree\n");
> -		return 0;
> -	}
> -
> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -				       &resin, 0)) {
> -		printf("Failed to request key_vol_down button.\n");
> -		return 0;
> -	}
> -
> -	if (dm_gpio_get_value(&resin)) {
> +	state = button_get_state(btn);
> +	if (state == BUTTON_ON) {
>   		env_set("preboot", "setenv preboot; fastboot 0");
> -		printf("key_vol_down pressed - Starting fastboot.\n");
> +		printf("vol_down pressed - Starting fastboot.\n");
>   	}
>   
>   	return 0;
> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
> index 6785bf58e949..2f0db628368b 100644
> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
> @@ -5,6 +5,7 @@
>    * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>    */
>   
> +#include <button.h>
>   #include <cpu_func.h>
>   #include <init.h>
>   #include <env.h>
> @@ -139,30 +140,18 @@ void reset_cpu(void)
>   /* Check for vol- button - if pressed - stop autoboot */
>   int misc_init_r(void)
>   {
> -	struct udevice *pon;
> -	struct gpio_desc resin;
> -	int node, ret;
> +	struct udevice *btn;
> +	int ret;
> +	enum button_state_t state;
>   
> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8994_pon@800", &pon);
> +	ret = button_get_by_label("pwrkey", &btn);
>   	if (ret < 0) {
> -		printf("Failed to find PMIC pon node. Check device tree\n");
> -		return 0;
> +		printf("Couldn't find power button!\n");
> +		return ret;
>   	}
>   
> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
> -				  "key_vol_down");
> -	if (node < 0) {
> -		printf("Failed to find key_vol_down node. Check device tree\n");
> -		return 0;
> -	}
> -
> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -				       &resin, 0)) {
> -		printf("Failed to request key_vol_down button.\n");
> -		return 0;
> -	}
> -
> -	if (dm_gpio_get_value(&resin)) {
> +	state = button_get_state(btn);
> +	if (state == BUTTON_ON) {
>   		env_set("bootdelay", "-1");
>   		printf("Power button pressed - dropping to console.\n");
>   	}
> 

Looks good:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
