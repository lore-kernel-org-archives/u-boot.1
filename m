Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E5DD33992
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B3F84221;
	Fri,  5 Dec 2025 17:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xNj4iI2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8314D83655; Fri,  5 Dec 2025 17:34:49 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB9683849
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so21268265e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952486; x=1765557286; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Dg8PYcVybaPoOZZ9cizd4h779gJN0LycMKCnQ2LrsTI=;
 b=xNj4iI2wKxhQDs4lnvYtCDI7da8DQcbBGpIex4utF+5/gjrviLt4NeLeB9PjLen4Sm
 W+lFXw3O1/i9Nc0eOf7n8cbWijBMwBsr5Qi2uUlfHqQ60/CsTpyKVf8YuIF90MgbCDe4
 mh0FMx7Cy7NIzsAZuInndci8KIhs1iXI2MwL639oOYY1rmk5Q0y2WpMpafFVgw9FdXWO
 gL55DfV4SeyC5gXHHfwYLwwHsOmO/rJ//D1j4w9HW4leUZQbioJREvKx6loChaK2I++T
 qoOPZh9HOYmY+NoDBeYz1FxwDcD4hEwnq2/nAyVhEbNAc031T5kriVHljbmGzYsNLZnd
 pYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952486; x=1765557286;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dg8PYcVybaPoOZZ9cizd4h779gJN0LycMKCnQ2LrsTI=;
 b=vcaujNB5FfJNkhIidunbJ1fFIzToKJH/cYC5guzYHw7LET09pHWH8nxTTUmNiFO3L7
 /wJ3wgP+SFryW802i5gnrKhYPTSz7JYZWT9o0LuVMYULtyVH2spIvoLxEbqhuZb1K7w/
 r1nqjFLAzfhZe4BDy2HDd44Sch2cEe86XPYRQKblu8HVFUAmhem7XRAeRYhoHQVXjK9n
 5+E0zrMLTmAKtFRz5wAdKEifC73Tn5ghL5rDYemp0RbJBENqKMP1Upsce+FzVz6H0RNB
 sRDwUdA2K0Q9UQIlZ3MnC+iHjwQa/hBPJfIeMH1uv+U3rK1QOm6oy4y7tb5JI1CX++Es
 KwLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzCLq1UQ8FxsUPWW4YFu7kQ5gD0Jug3W4vguiVuH/6nNIrsKMS0W4PcGFACUyxU4pU7syIAq8=@lists.denx.de
X-Gm-Message-State: AOJu0YxyCr/kAXGspPbCVlwxal3K5miYkVF5RWTYAzC6qYnPDo36O/lV
 gORMx788dO3iTb4hzMOusSno1ssC8aDCPmY13jkDVsLgS5ImBqv7nrBbxirLiFQmxIU=
X-Gm-Gg: ASbGncsITfDRsmt4FAJAK752buEQp6LJqLXSd6+GjOHAFQJ/EE1+jDNDYr5hSS3g8NV
 XYpCdiGKNe4AYS1I0ekDCyJsCuUntXZteAf2qxbixx47TzEZi9eNLLWzg6p9ZswAgjy527lDdRL
 CD2vYt1cU4+F2Zbyw+ZgviR+Gy1zrxcTLZIslAhE+4s6sTZyO8YOY8W3MK4/F34XFttEuuO0/3Y
 1qRgApRRD+EiPaP7zn0nZLpyeDUSb9L9Yb9IJlXD1BvNFheAcbamq/1NVX/uNRXO4PbLCCd/YQp
 +ZQz1NV0MD5OvCVpst5LfT6T2pwkhEljbN5duOo5tbc2UGtWBZdeEdK39euqmVM155UleZIczP8
 qaV/qn4ifLcJRCcCNm1WvQ3mcb/YVLOTwQQqunccBK5660jUZhLxiqqqDw5cVXKsH8eNHdAHrKV
 0DjlUMeLS8U/mxZGIWsBxAPI9CshnwLeQiJA7s1ibiMi30qeNXGYonetzEQBbubEc=
X-Google-Smtp-Source: AGHT+IGq18mLafI6z707NQAe71/Vjbxy+jf0hmi/vMA8U8NemKc9ia4HrHm8WgGSPEAHw24aAhkQ2A==
X-Received: by 2002:a05:600c:c494:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-4792f3954e9mr64769005e9.27.1764952486025; 
 Fri, 05 Dec 2025 08:34:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:b735:1b21:d481:e64e?
 ([2a01:e0a:3d9:2080:b735:1b21:d481:e64e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930cb6a96sm89672955e9.15.2025.12.05.08.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 08:34:45 -0800 (PST)
Message-ID: <b2c5b0ac-04d3-44ee-9b70-4b123eaffaa6@linaro.org>
Date: Fri, 5 Dec 2025 17:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: update my email address
To: Linus Walleij <linusw@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, David Feng <fenghua@phytium.com.cn>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251205-linusw-kernel-org-v2-1-40c8652749b2@kernel.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20251205-linusw-kernel-org-v2-1-40c8652749b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/5/25 17:01, Linus Walleij wrote:
> I am moving over to using my email address at kernel.org.
> Change this in all the affected MAINTAINERS files.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - Collect Quentin's ACK.
> - Also add a small .mailmap entry to push mail to the new address.
> - Link to v1: https://lore.kernel.org/r/20251205-linusw-kernel-org-v1-1-a36e342c4b97@kernel.org
> ---
>   .mailmap                            | 1 +
>   MAINTAINERS                         | 4 ++--
>   board/armltd/integrator/MAINTAINERS | 2 +-
>   board/armltd/vexpress64/MAINTAINERS | 6 +++---
>   board/broadcom/bcmns/MAINTAINERS    | 2 +-
>   5 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 04daa274ef31..0e01452a70cb 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -75,6 +75,7 @@ Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <j
>   Kalyani Akula <kalyani.akula@amd.com> <kalyani.akula@xilinx.com>
>   Klaus Goger <klaus.goger@cherry.de> <klaus.goger@theobroma-systems.com>
>   Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
> +Linus Walleij <linusw@kernel.org> <linus.walleij@linaro.org>
>   Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
>   Lukasz Majewski <lukma@denx.de>
>   Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cddeca734ffb..1789f023631a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -820,7 +820,7 @@ F:	include/linux/soc/ti/
>   
>   ARM U8500
>   M:	Stephan Gerhold <stephan@gerhold.net>
> -R:	Linus Walleij <linus.walleij@linaro.org>
> +R:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	arch/arm/dts/ste-*
>   F:	arch/arm/mach-u8500/
> @@ -1648,7 +1648,7 @@ F:	include/scmi*
>   N:	scmi
>   
>   SEAMA
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	cmd/seama.c
>   F:	doc/usage/cmd/seama.rst
> diff --git a/board/armltd/integrator/MAINTAINERS b/board/armltd/integrator/MAINTAINERS
> index 8af765eaebc8..a228fc3daec8 100644
> --- a/board/armltd/integrator/MAINTAINERS
> +++ b/board/armltd/integrator/MAINTAINERS
> @@ -1,5 +1,5 @@
>   INTEGRATOR BOARD
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	board/armltd/integrator/
>   F:	include/configs/integratorcp.h
> diff --git a/board/armltd/vexpress64/MAINTAINERS b/board/armltd/vexpress64/MAINTAINERS
> index c38ab520c521..58ab5db7e4a2 100644
> --- a/board/armltd/vexpress64/MAINTAINERS
> +++ b/board/armltd/vexpress64/MAINTAINERS
> @@ -1,18 +1,18 @@
>   VEXPRESS64 PLATFORM
>   M:	David Feng <fenghua@phytium.com.cn>
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   M:	Peter Hoyes <Peter.Hoyes@arm.com>
>   S:	Maintained
>   F:	board/armltd/vexpress64/
>   F:	include/configs/vexpress_aemv8.h
>   
>   VEXPRESS_AEMV8A_SEMI BOARD
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	configs/vexpress_aemv8a_semi_defconfig
>   
>   JUNO DEVELOPMENT PLATFORM BOARD
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	configs/vexpress_aemv8a_juno_defconfig
>   
> diff --git a/board/broadcom/bcmns/MAINTAINERS b/board/broadcom/bcmns/MAINTAINERS
> index 63c6d8bb4aca..4972d6cc9343 100644
> --- a/board/broadcom/bcmns/MAINTAINERS
> +++ b/board/broadcom/bcmns/MAINTAINERS
> @@ -1,5 +1,5 @@
>   BCMNS BOARD
> -M:	Linus Walleij <linus.walleij@linaro.org>
> +M:	Linus Walleij <linusw@kernel.org>
>   S:	Maintained
>   F:	board/broadcom/bcmns/
>   F:	configs/bcmns_defconfig
> 
> ---
> base-commit: c98b6a6dcd1fc7bcba081fc2353954e33de5053c
> change-id: 20251205-linusw-kernel-org-f2cbcfa6d34b
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
