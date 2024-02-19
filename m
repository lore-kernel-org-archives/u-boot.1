Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F6C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6C587613;
	Mon, 19 Feb 2024 10:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B5KApuSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDE387E95; Mon, 19 Feb 2024 10:49:18 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D2387F2C
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512a9ae6c02so1612763e87.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336129; x=1708940929; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W2Hqp2YhZ5vH/ND35pXMcCg1lsrlEzPOQaDCrFMGt5k=;
 b=B5KApuSJ396jPET/31caib7kGI+D2G36Qj9dYnDiEAQI2duEEjC7+ss4o0hmBKU8Ko
 ++CM8EOZECFVD/n5QhB0p2majeyK+FFdoPNESDyDivAQYLo4d+KlxY6IuP+zhVQvszWb
 dOVYFLopjUXzbSYAIME+nURRW2jlhJ5q8pA/PNNL92J/zF5Np3MaaYrwULtRbLHi+G+V
 YlQUsStE+YnKwfO1E1fvUJ/hv1dAoXRdZBPOmOxg1Bo4/cPJ0DNgADO2xkj8Cxf9yv3q
 6jjXpnANoO2KffzUBcyFRJrkeEMv2Ds1II7Lb/4Wnv0SmpQdBxqFKcP2LJ26zBJFKvQA
 QpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336129; x=1708940929;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W2Hqp2YhZ5vH/ND35pXMcCg1lsrlEzPOQaDCrFMGt5k=;
 b=CdJEvs08nLnii60Zc3WtSfmNRUDQcQrZezulJOsRfSF7Ny6uSfFOhEBrKsp/9x75yF
 ScMdaQpvqG3CsAMLkL5IzmnSHyzl1uwVTqkMJFGD5U1FGiWeNiDz609NUTVh2pvfLV8J
 YpjxhHCo+BR+zpkJ+J1VM/6LK0rTBwkDmLTqVsgADrweXj3i7CjuiDlozx68gBdHL8x/
 vewRn1tK/5hip+AEGPBpFXF/VOVIfNUmjhg5nT97CmbMl7Cx06TglFkpJHAYEYjvTLSA
 dfdKiZmOlHAf8o59VRhfAVZOXZjiq7GxuvENJYFFZlkY7Fa18yWuNSJJ965AXiklgpcF
 9IFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV39CpsEtYZDWtnK3QLdMvS9fz27d+0N6zVv/DefGsDmurHZd77XhT/KyBVL6k1ktnfEwnjJ8Ac3WyzQa7qiby6EXLpFw==
X-Gm-Message-State: AOJu0Yw8emYss9bWPPFM7K0bPflAKTup5/yxxXXUn86ks2a5FC6yN440
 G3pAJXDkkDW1VV5/PL08/vspQKEjd1jwD7ywKzIrALKzu/m8sKHkVOJdF60WZDw=
X-Google-Smtp-Source: AGHT+IHk+IyOdWWET5aEqi4NuHx3xr6Eri2pZfBba4xDtTLoqMpkpr+y+E+W1ZXTw3vti8HHPfSESg==
X-Received: by 2002:a05:6512:23a4:b0:512:8a75:6ae4 with SMTP id
 c36-20020a05651223a400b005128a756ae4mr9689554lfv.66.1708336128535; 
 Mon, 19 Feb 2024 01:48:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:48:48 -0800 (PST)
Message-ID: <f53f69ee-d86d-452b-9aad-d324d0b0421b@linaro.org>
Date: Mon, 19 Feb 2024 10:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 12/39] sandbox: dts: fix qcom pmic gpio
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
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-12-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-12-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> Adjust the DT to match upstream bindings.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/sandbox/dts/sandbox.dtsi | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
> index 241f397ba6e7..c93ce7128942 100644
> --- a/arch/sandbox/dts/sandbox.dtsi
> +++ b/arch/sandbox/dts/sandbox.dtsi
> @@ -419,17 +419,16 @@
>   		#size-cells = <0x1>;
>   		pm8916@0 {
>   			compatible = "qcom,spmi-pmic";
> -			reg = <0x0 0x1>;
> +			reg = <0x0 0x0>;
>   			#address-cells = <0x1>;
> -			#size-cells = <0x1>;
> +			#size-cells = <0x0>;
>   
>   			spmi_gpios: gpios@c000 {
>   				compatible = "qcom,pm8916-gpio";
> -				reg = <0xc000 0x400>;
> +				reg = <0xc000>;
>   				gpio-controller;
> -				gpio-count = <4>;
> +				gpio-ranges = <&spmi_gpios 0 0 4>;
>   				#gpio-cells = <2>;
> -				gpio-bank-name="spmi";
>   			};
>   		};
>   	};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
