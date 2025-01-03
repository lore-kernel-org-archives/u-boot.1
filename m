Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C5AE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E47680295;
	Fri,  3 Jan 2025 16:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U7A6QwK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C217F802EF; Fri,  3 Jan 2025 16:17:18 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43CF801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38634c35129so9391356f8f.3
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735917436; x=1736522236; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Z4J4rBC6PvDpLRBX4QhlC5NsIBAp9vUh3jPJk26/Ni4=;
 b=U7A6QwK033bxilhGq2xTIBx61h32fO3AX8UqxdBFDH0y5GXKbl/8UKfr/Z0MTu/OUF
 pB6Ioev+qMTUFjV1xfnFMTTd/RLWDTltobomb3ci5lny3wBllcLSYferVUWD7I2t887d
 KOl5PHgE+5k/EmXcIlvnPCF+NA1cLY3No4murxUNxz0XgIxDAQphbMFQoIHaM/lNPptA
 zAv/aKRmTKDMv8GPkiAs97nXvAYKQ+AAgtjGo8Qv2SUJpgDJS0D5tygi7Slj7L9EkRnl
 iS31AbKWWI3eIbqQx4kY5ypN5jrbJ9dbY2Q0rncXf792KWQ0RRgQhqzRdSdXQloMZgkk
 qCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735917436; x=1736522236;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z4J4rBC6PvDpLRBX4QhlC5NsIBAp9vUh3jPJk26/Ni4=;
 b=AfEYx0s1tibyUO75ZLUHMk/q3klx/0tVBzjrRWDrZvyZ3hSaaLDEtyAXpO1EfJlrGD
 zn4i2gy7943aSTtvc3VgeTGblQ4A4MVz3FCh7QVj9qkZePvV2yXSKCKjzOe7lNEYu3s7
 tAWrKGt2jEdFx3RoMsMzbNYSdksLvSCoX2BreZTjBhGws7YqmsWKBXoqf479QkJw16tf
 rn37Y1kywUXhSEhU+Aqwqa5kLByWv7yEBGyn9nyboNXhV/gw/r+hSKeBi5e6i6v/AsFj
 MPiHEOd32K47Je8WT7QTCbcnV7MHl376k/nkYZKWucWvGqcpTlpmwNNg/TQQlgFaa26A
 XLoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuYlgfJES+75qJN1H4uhF5/3y2iV7zBCqKVn6e2aWJDTMKwW/9bk0GUJF2Au5BbvzYKgxz4sI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+4sDuJ0AkrljKn6Q77Pj6ewT9TWHQg9KMQJJXyGYPAhLl/g5r
 BIacC1PvVmTS1TE3E8fIpzBkdB8HVq0gm/I77jIjEiTbW/UICpUFqNraljhLjD8=
X-Gm-Gg: ASbGnctJILAjvHGrQvs1aCGM8an19qcV/nM5hF0ft4SaHdCXcfeHKJAmuFDZqudtyPw
 Vc6xqxoYdYIBl3WS5siM6bAFXR0WqIIWL8DiYL2G3zK/bp9gnDwirnaLXReXXTNO1pdjcqRt7q+
 rKw2wyNM2VQGXiu9e+yAXpMdL1tyaOuPlrq7tPMMWWkfBaJJreN8S31Vg8rlvjCTZ8PmG2KokgA
 jFPs8QfRxnegIkquK0shlW+9ofyNdeUe+ypW0NPa7iUsolxPSMhapfmN1JJbEIdcKky2YHUgf/s
 0uDrmqjxBfsCItQbGgqoSgEdICOlOnCSlA==
X-Google-Smtp-Source: AGHT+IHZNqNdqB6oZ+vtD+TpbziocosreCUpNN4gvjOTf82mQLAk+KtuRD27irOWHtDWsac86RYQlQ==
X-Received: by 2002:a5d:588b:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-38a221eabecmr48175003f8f.16.1735917436099; 
 Fri, 03 Jan 2025 07:17:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a?
 ([2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c848a47sm40426775f8f.62.2025.01.03.07.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 07:17:15 -0800 (PST)
Message-ID: <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
Date: Fri, 3 Jan 2025 16:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
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
In-Reply-To: <20250103051404.1965469-2-quic_varada@quicinc.com>
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

On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
> Define memory layout statically.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
>   2 files changed, 33 insertions(+)
>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> new file mode 100644
> index 0000000000..7d01d5f6a1
> --- /dev/null
> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/ {
> +	model = "Qualcomm QCS9100 Ride Rev3";
> +	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";

Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts

> +
> +	/* Will be removed when bootloader updates later */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x3ee00000>,
> +		      <0x0 0xc0000000 0x0 0x04d00000>,
> +		      <0xD 0x00000000 0x2 0x54100000>,
> +		      <0xA 0x80000000 0x1 0x52d00000>,
> +		      <0x9 0x00000000 0x1 0x80000000>,
> +		      <0x1 0x00000000 0x2 0xf7500000>,
> +		      <0x0 0xd0000000 0x0 0x00100000>,
> +		      <0x0 0xd3500000 0x0 0x07c00000>;
> +	};

Ack, this should be removed once the SMEM code is merged.

> +};
> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> new file mode 100644
> index 0000000000..979462dfec
> --- /dev/null
> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "sa8775p-ride.dts"

Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.

> +/ {
> +	model = "Qualcomm QCS9100 Ride";
> +	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";

Same, unneeded.

In fact, this file is completely unneeded.

> +};

Neil

