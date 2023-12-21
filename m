Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D5C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2308E87896;
	Thu, 21 Dec 2023 17:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jDR2q23y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31567877E5; Thu, 21 Dec 2023 17:15:05 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A634287896
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d3ae326f6so9804725e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175300; x=1703780100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4fxOy1uq6y/F4gSgd/DNwMYwM6gjn+k9V48YySZWe0Y=;
 b=jDR2q23yc2yRFJ6t1K2WGU8USKUYqIZHGkFYhOs5oqkyNxXFil0I7WOunq4099HSR7
 R7+HDRYVhAOM0kTPVY5uE+jqCoHYtDcHFRn6JaLSq3vIF+Xi03YyoDLEy2eaU2WmyhAk
 zqwAO76HrLSBPBjqSBY33MbbGNajNAfZhI54t8P+cbO0iUIVgE1KInc8Im+7HP6j2lUb
 UHmTqyJacBmv/gk+JcnxNdemtmkEnwgeHENxEbBlW8RwZ+8KpZYc7T/hgYwZq32DT9sv
 FD68RDBw9O/qVi+c/zFre/bKLDMi/CB1CL3ULda+Gv5t0OaMSxCfdN2Ydb6TyVc2GR6m
 rgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175300; x=1703780100;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4fxOy1uq6y/F4gSgd/DNwMYwM6gjn+k9V48YySZWe0Y=;
 b=N9PSks6lhV+I/2c/c8tGhRuqK3kTdkmzYpz3nORFmbRnJW6Srm3Dtybx643X9h1qAL
 bs5Ep3151+mDn7hyM7NyJNAuPkjh61kLM/k6rmm+RGh7NHq77oyI3qwh20dfQjMv9SWL
 fru1eIPREMfUnwZb3IUzKRc93d877aOwrwyE3XDpdMfFXbUA7JC/RIu3uyRbANrQiCaM
 6i/QUwDgL+uDVDbMf4PV7A0CS9QD3ahlfsgEgftFDsx/pkzvOd6zfvl70BYfS69KdKGs
 5uuEbodjgR+6fJgasg79GROnIOrGJPTfAKuzJG0SyVDFn2XzAjbOvldsVTOE8kH1yjQP
 96Yg==
X-Gm-Message-State: AOJu0YxJkGlUStUIJZ0kWnE4LzIliBrYL05rimqo27wIact88H5Gf0Nk
 nmtuFwA6wAHBhKD3SdwbDDr22g==
X-Google-Smtp-Source: AGHT+IEVKAoOedDEqoNznaWmB/2efPvj9d5LOvwRQHIDjTDVn8HwjkP+lJLo3BMynYgICoshKCzJkg==
X-Received: by 2002:a05:600c:3f85:b0:40d:4181:4d23 with SMTP id
 fs5-20020a05600c3f8500b0040d41814d23mr324314wmb.105.1703175300018; 
 Thu, 21 Dec 2023 08:15:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm3865415wmq.27.2023.12.21.08.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:14:59 -0800 (PST)
Message-ID: <fe1ae3c5-bcf4-4563-91df-2e5c6554194d@linaro.org>
Date: Thu, 21 Dec 2023 17:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 04/32] dt-bindings: drop msm_sdhci binding
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
 <20231219-b4-qcom-common-target-v2-4-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-4-b6dd9704219e@linaro.org>
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
> The upstream DT is supported here, so drop the U-Boot specific binding
> docs.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/device-tree-bindings/mmc/msm_sdhci.txt | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 
> diff --git a/doc/device-tree-bindings/mmc/msm_sdhci.txt b/doc/device-tree-bindings/mmc/msm_sdhci.txt
> deleted file mode 100644
> index 08a290c66931..000000000000
> --- a/doc/device-tree-bindings/mmc/msm_sdhci.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Qualcomm Snapdragon SDHCI controller
> -
> -Required properties:
> -- compatible : "qcom,sdhci-msm-v4"
> -- reg: Base address and length of registers:
> -	- Host controller registers (SDHCI)
> -	- SD Core registers
> -- clock: interface clock (must accept SD bus clock as a frequency)
> -
> -Optional properties:
> -- index: If there is more than one controller - controller index (required
> -	by generic SDHCI code).
> -- bus_width: Width of SD/eMMC bus (default 4)
> -- clock-frequency: Frequency of SD/eMMC bus (default 400 kHz)
> -
> -Example:
> -
> -sdhci@07864000 {
> -	compatible = "qcom,sdhci-msm-v4";
> -	reg = <0x7864900 0x11c 0x7864000 0x800>;
> -	index = <0x1>;
> -	bus-width = <0x4>;
> -	clock = <&clkc 1>;
> -	clock-frequency = <200000000>;
> -};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
