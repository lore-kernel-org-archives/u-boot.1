Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C8C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58AA879DC;
	Mon, 18 Mar 2024 09:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zpNBlAeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F1B879DC; Mon, 18 Mar 2024 09:44:08 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F748799C
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41413b42c8dso1621575e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710751446; x=1711356246; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=I/oeSBGpWO0iH1Zkmp9crshj4uyKP6/bIYBT+8Lwu1M=;
 b=zpNBlAeXc2XScVbqYL1YiGnINk/jpiCc0ZuWpQJSBOVKVENMjT9gdM8kl9Fx6MafIv
 Oe2sFX9mNBbU20FuVZqPx9xFAKNQKhNX2haVQXWklEvZZVYPTTXOvHwrjo3feOiaME0r
 59Cy8s+RWAf5Cm+QCvCj4U6eCnj9KcKA8x9DYC1nvjPVonKap31yVU0fMNFpvdddnrMU
 rxp1IkJM3sdwT5MRAhlG14dlFmCwPVodlAz4Sqi2L9Hzi8OTfBRbcgLgsGSWy3Z1FWQg
 dlYROLA6bTwRMtl07I5Sy7EzoyG1Ldw63KzGNMBO4kJMLXIFcl/8GWHxm22iBmxYYElF
 z3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710751446; x=1711356246;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=I/oeSBGpWO0iH1Zkmp9crshj4uyKP6/bIYBT+8Lwu1M=;
 b=EIGhkA/LhzC+ZpvjUpWeQQgG57NcpcY4LtM9t/J4RY9fJrH+AUmqjjCEqyRpdtPwWd
 KCgwaCPrEzho1ZWXAtyMq6LsvscBTAvvuXHCmLyo2/GtRzpRzc5/OrQaXlDoMX1yLF25
 JEkchcDnimecmEuJEI6QxKoUQLLueXCSnib+TmK6FsNx3RVANbD72TAM0xXWnqV2PKzY
 AOt6/V9A/XfUvAZlZIF/gm1NSWLRBOKbkYHie0ZiswcqbgSRgmWVPtP1r/rT8DcvSBeW
 RfJHN/17DkLKw1o1PeQnGplJJtfYP/JCI5UkkJYyXXjPrjBURbCwNIfXdsapajmUzfa1
 CYfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl2sx3lnFjPxSKhsubXEGrru3BZ0cp+IlMiJ8m7PDj+cg3lg8CFsTUObgrWHOhU6josy4dOsnixEQGGtup0gRcHR1Q5A==
X-Gm-Message-State: AOJu0YyWM/SyN6VYETUubeE5D+xBBw68cQmf8n950h1jpf25VssvJCV2
 KyCwTeNVWKoE+Amgef5b0fv2utimoWcLKTwFPPRjEfPugDAJ0AxLPT+R71+dhdA=
X-Google-Smtp-Source: AGHT+IFG3I15pv8EdDTE22vM5b12wD+p6ePn0LduKYe7zAW8noH4dNrWWnLC8fVlMdJMd2pOIMKivQ==
X-Received: by 2002:a05:600c:3509:b0:414:102f:27c2 with SMTP id
 h9-20020a05600c350900b00414102f27c2mr1328181wmq.1.1710751445796; 
 Mon, 18 Mar 2024 01:44:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc?
 ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b004130378fb77sm17529771wmq.6.2024.03.18.01.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 01:44:05 -0700 (PDT)
Message-ID: <19d5d996-71ce-40e6-874f-70f9f1b6c66b@linaro.org>
Date: Mon, 18 Mar 2024 09:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] ARM: dts: fix Ethernet on WeTek Hub/Play2
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com,
 u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
References: <20240316135430.826898-1-christianshewitt@gmail.com>
 <20240316135430.826898-2-christianshewitt@gmail.com>
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
In-Reply-To: <20240316135430.826898-2-christianshewitt@gmail.com>
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

On 16/03/2024 14:54, Christian Hewitt wrote:
> Placing the snps,reset content needed for Ethernet to probe in a common
> uboot.dtsi results in the content not being used and broken Ethernet. Fix
> this by creating two board specific dtsi files with the right content.
> 
> Fixes: 67d5128df950 ("ARM: dts: add support for WeTek Hub and WeTek Play2")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
>   arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
>   2 files changed, 13 insertions(+)
>   rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
>   create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> similarity index 100%
> rename from arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
> rename to arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> new file mode 100644
> index 00000000000..3743053eb9c
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> +
> +&ethmac {
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
