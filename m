Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829FCCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D714800D7;
	Tue, 30 Sep 2025 20:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOlfpH4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D970882998; Tue, 30 Sep 2025 20:42:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F22B800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso47689995e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257721; x=1759862521; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qresipSgS8fvybY8OpZMi4PNxXwa0WU2PKfp2r6pORc=;
 b=oOlfpH4C/FPA7LzNQm8waj/8cJeH+x1VwL9LYI3oiD6Tpdbhs9h72iXEeuT6WtBxcT
 AkXI1PN8iFmj3KaQP0FVFSMLo2WzqkxStuY2az/65+vRyszTgmJuyDuCrHiSf4B7gY8s
 WH8urfA0rERUVBS1hONpSQRzD5BiVhE6TpVLXYm5/EkNYHYrtzyMUFnCNtAlctpDPLId
 c1GHi5uBcJnbEHkE/xO9i5DFFWrCwGyhxOpBMiJjdok44Yzp8WKWu4tb9dov1u1b6D05
 NP2v/WMmVR6W8f0BE39VB2S/j7PrK6HZpmq1pFAxeClCxaqQTDk4eSEfjia1l12qfmD6
 fVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257721; x=1759862521;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qresipSgS8fvybY8OpZMi4PNxXwa0WU2PKfp2r6pORc=;
 b=hcPP5dLQ8RRRROukXSjmG1OcDO6jrh5XqE/Afb6qSSv6RIvI4dBMMjAONf8gRd88q3
 UgZZ7Ka7u7qsLKSHWg5G9SwntgYRur4XOz3c+IvN51j7B9hh5l2f0lnDAAiD++1hJm9z
 OI+fDKEPQ5I+xt4wg5pju6HjV5wO9IM/VlfA+e+rD7YaqADVhnHmM/FMDmg+fz5NBh32
 pxIdK/C3QuJiEaYR/+ZTi1yab9JAWAYdqNDmtOwOPnX9wJYCI/FiQjsJ1Iob/kTztbFA
 95yFOYuoZTjWJIOohh1wfUbgA7xU6HchsMdvybe0e94i7B1khBnaJNC743i52eJu3eiY
 R/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXij6QeiqEm/GabgoXqdVaWiKcTOwGD698s/8W0WOzD5EMeP78XNbqAymfrXZCVnHNZYMglpl4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5ZYO20T37dl2j4ZhiUpLbQAdM7iegzASDcUsM1pslCVyKIQS5
 hjIZ7WXV/SAMmMntDW1b4J4OsPiuFm2U0Vw0/b8pFShgvmnYj2MWTUhFSsiHcfQ9Dhw=
X-Gm-Gg: ASbGnctcyKyTnHnMJNlBOYJsRQX0MKcvRTCXSaIqoCpudryN0vpMC539j2fZJs1hdPp
 6fM4O7+ML23Hyge/4k2acjicYnaIQG1oQcDeKnhq2VeknVSHacLUBEID9YZ4V0Ud7umhfKK7LeT
 BDN+1mSwa2Ik0yxAzIQteYhGJtO949hXST5lL75QMDZD7lnWVDkYhaClr0IQOeo7yPVni90IZJ4
 EYLQgSXPCZi45JLiPoqbKaoypcBFZuCEgIwf5C4IpnUWUsNcMuH2It3qr9pXGtorZkDvVcu1lVF
 iKeWefahojlu/9uJgOTa4arjTWrnZK0s2GaqnNzbrJXwUWeX6bI71EECMJnI2Z++miS/t3FitcW
 yfDUsyqp+kWUGS96SeoxkKYq/QV3vQpntZ/eZ0TG25fVuGNHjvBKYr0/zEhVAVWNKK2lJT3y0qL
 K/VqLsLaTfaGu6+KOG8XUcJUw=
X-Google-Smtp-Source: AGHT+IEqVcKRGeWWnuDTg4j2FuMH9IluWIcsfaFXdYCi7Vrgl2U43FrDtUO/y4zw3EJ9ny7ru+AJiA==
X-Received: by 2002:a05:6000:420b:b0:3ea:80ec:8552 with SMTP id
 ffacd0b85a97d-4255781e566mr567128f8f.57.1759257720629; 
 Tue, 30 Sep 2025 11:42:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2ff6sm23628002f8f.56.2025.09.30.11.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:42:00 -0700 (PDT)
Message-ID: <9615d8a8-0adb-4690-9296-101363f604be@linaro.org>
Date: Tue, 30 Sep 2025 20:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: Enable pinctrl driver for SDM630/660
To: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250914145620.1962735-1-alexeymin@minlexx.ru>
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
In-Reply-To: <20250914145620.1962735-1-alexeymin@minlexx.ru>
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

On 9/14/25 16:56, Alexey Minnekhanov wrote:
> Pin controller driver for SDM630/636/660 SoCs was added in
> b4420a0c9ed ("drivers: pinctrl: Add Qualcomm SDM630/660 TLMM driver"),
> but not enabled in qcom_defconfig. Correct that omission.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 86d7de89e77..3acd57fb774 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -110,6 +110,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SA8775P=y
>   CONFIG_PINCTRL_QCOM_SC7280=y
> +CONFIG_PINCTRL_QCOM_SDM660=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_PINCTRL_QCOM_SM6115=y
>   CONFIG_PINCTRL_QCOM_SM8150=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
