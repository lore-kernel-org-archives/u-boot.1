Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E521D10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EFA84201;
	Wed, 26 Nov 2025 14:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wiY327s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29498421A; Wed, 26 Nov 2025 14:09:54 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E4B841E6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso4126876f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 05:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764162591; x=1764767391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=a+TSOKUbs/ywh/8+S3+0H8wLddAtAOyOvWfNgwrKgIk=;
 b=wiY327s8L6Fw+IFydjzU7eN33yjTKELfgMvsgjhhVhnC56gD49R10Z96pXpP8Y+IV9
 a1h0LCDUZePxwXPA7wHYQpTVEMfiWnCvW5tL9S2+Vpc4b7G4HmiavUjMN6r5nI+bRYG4
 CIxsXOSphlclcOmEyszEbYZVXYuFPIP2PpOKxrlSAiomm6Qtxg5iATEMgIb0WLcVRgpC
 dZzbU6XY/GPvZAElI3kzhRmmGTqvKyoe5ew9TtLkpKemnBq5v8cSZiu39YM/vDrxG9yr
 L0lrwFg+40+u6oit32dm7GkVUl844QrG+IoMTcvrvTWSo9KrLch+/an1WPiqiQALuwz8
 c1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764162591; x=1764767391;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+TSOKUbs/ywh/8+S3+0H8wLddAtAOyOvWfNgwrKgIk=;
 b=Pe/9umlELXwi4dTFvUQcsse8NG9lbT5dPab+DenwpwNdwXRJbWFjsdaVxlbAGunRHu
 2q6cDY2ZdTflKOcSiITcTnbLSKz+1J1GD44dxZoRLBV3mVTf969Y9YrXxk7St5+zDUJc
 +S1ajLUlRI9AVAnaTtu1W0rkbYuemwXnfe6+KfBuuPIyleZp5B1UlXYpZGaMx6SWrbIl
 fUOewp8ypGoHmtML5kVZfHD98DbbA/A0d/p+pD0LbrbmmHLETxVt+xBlELy6x9BiHY8Z
 G0SaQWhaljfjQ8WJg1ttNt+wpJwVLaPwMlJg+or6iopMlW5s2WjPhv7EjtqTBCwMN+hs
 2JYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8mTx3JjmUADiPrlGKyPBisiwSmsVGcahuC4FovrAzxMPBOLRe1+PqRub0NgFkSCMBYBfccVU=@lists.denx.de
X-Gm-Message-State: AOJu0YyWL7kO5mJi78vxNNkKsO8vfE4sMTxoJqskrJqCNSu7gjqlNE+9
 JX5NjfR/7Qt5VcBL9zy/mX+Gr1ohfktAUfJ6D7r/qG6hvCtbQYjVYDCfLmUNSMLM8sc=
X-Gm-Gg: ASbGncvNKK/C109ooZtL2AysdIRTgk6hcQXnRGpFTD0IZr6t3eWS+ApW3Ph5HwOOf8D
 1J0JrmLfDNxXJggcqlLlsMdRgUQeQm2/g4bP1GbWdminuMJxLWyLRb06QyXr942QC7ocvsfMIt6
 98qwnJuHxXx3/ao90S5tTDhdZu3wPFhpUvrSVOiL7EoYjh+/baou1A1ILlr5xPo42So/y6+lfj3
 b83mk8JC60wbanWTcmIQ/SqNEnsUf2cl7v2sLDXEy8y4YF3gbvIucAT7sTndNClAp5+K45lhjbz
 pydObsZY8+ZevhnwdEYoysWyQOYQ4fgEFvjSiWUxZzC5vLE22lUbwtGIUQBHXiYFpMD+I5IpEtA
 9CwFfEUr226QV23/ye3eT8ZQ6B5PQsRQIwok3Z3TG7r4BQGy9JN+Cku2IF2zQ3EBiWdQdOcNuBC
 K8Jt52Ti1SQkHSqhRaNvMpsIVVTOulrBV0gXAMRTapFhTgaFuEGiWTcSGl4X1e
X-Google-Smtp-Source: AGHT+IGLQUgxyvQbu50j9qMZ5iXTGmPY4K3J6uINh0s7pvdNUrUyw5C/1i0O+uJUFPJjz0YI6695bw==
X-Received: by 2002:a05:6000:2c0b:b0:42b:2fc8:186 with SMTP id
 ffacd0b85a97d-42cc1d19a48mr20218255f8f.46.1764162591242; 
 Wed, 26 Nov 2025 05:09:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91ba:3a5e:334:4534?
 ([2a01:e0a:3d9:2080:91ba:3a5e:334:4534])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f49a7bsm40235656f8f.19.2025.11.26.05.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 05:09:49 -0800 (PST)
Message-ID: <d88ea750-fb4f-447e-8e2c-48706176b482@linaro.org>
Date: Wed, 26 Nov 2025 14:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 06/10] arm: dts: meson: add meson-gxbb-u-boot.dtsi
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
 <20251126-spl-gx-v5-6-6cbffb2451ca@postmarketos.org>
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
In-Reply-To: <20251126-spl-gx-v5-6-6cbffb2451ca@postmarketos.org>
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

On 11/26/25 13:17, Ferass El Hafidi wrote:
> Add a common GXBB DTSI, similar to the meson-gxl-u-boot.dtsi file,
> which GXBB devicetrees can include.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi     | 2 +-
>   arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi   | 2 +-
>   arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi    | 2 +-
>   arch/arm/dts/meson-gxbb-p200-u-boot.dtsi        | 2 +-
>   arch/arm/dts/meson-gxbb-p201-u-boot.dtsi        | 2 +-
>   arch/arm/dts/meson-gxbb-u-boot.dtsi             | 7 +++++++
>   arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi   | 2 +-
>   arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi | 2 +-
>   8 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> index 191c5192c68..4a027b9022b 100644
> --- a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> index 2a245bbe7f2..53d5c0113fc 100644
> --- a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> index 5a2be8171e1..1bd000eaa86 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   / {
>   	smbios {
> diff --git a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> index c35158d7e9e..1bef64dc01d 100644
> --- a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> @@ -4,4 +4,4 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> index c35158d7e9e..1bef64dc01d 100644
> --- a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> @@ -4,4 +4,4 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-u-boot.dtsi b/arch/arm/dts/meson-gxbb-u-boot.dtsi
> new file mode 100644
> index 00000000000..c35158d7e9e
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxbb-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> index 3743053eb9c..cd2e9b5099e 100644
> --- a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> index 3743053eb9c..cd2e9b5099e 100644
> --- a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
