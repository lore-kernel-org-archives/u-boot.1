Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89806CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD17846F9;
	Fri, 22 May 2026 08:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ljr/KE4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5A9846FA; Fri, 22 May 2026 08:59:22 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70581846F1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4903974854dso13551845e9.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779433159; x=1780037959; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mm54662mwylXHUIaspIs3ZGsXypL/79/x13KKVyspiQ=;
 b=Ljr/KE4eF91h9KXO96J4NqT9RQ9nL3oS332BOSwe03s0S6cRiUxXZmNW/U9xPzw8r1
 M1ZEefUCd3fVSCVk+Xit3VktpVvqaHZSIdCEkQ5Gr/DMCUbVIIn/xPjxj3BTvDDl0YHT
 /RAbjpXZvYUZataRACeBJSnlCEUreZxg6V5i6qzRJzxKbbcfkPjSxB1EcqMJ/LxfgkcK
 U7qgcn06Uwfs4WNhBqoAaIbSS93oiSitXOUm70ku6/S7pri+Qosf01SmRUVsRWGJIMxo
 BHKoGG+ReP4vm0wtZD2fJoICLcV/0tIgImT9yAl/3CAwp+piPicyhwwqI2+iPYnoWiC6
 R82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779433159; x=1780037959;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mm54662mwylXHUIaspIs3ZGsXypL/79/x13KKVyspiQ=;
 b=M+O1oK5oymp4Y6Z7CsY9btQKxr70mYRb6NKggsjY8Fzxt/U9H9TEs4eA9Y+fSmtxCg
 iDjzEv+ioloF2TVbXOB/IVVYi/x7bzWdtJ+lXTMjOr9ylyB8MQ+BpuhuDQWXcv5ZBZOj
 mTaUPPqUGCxYgLXfA2HjzaxRZZvvFW2RG+1aggCaEJqR+ub9DKiWy523tn0UcMLu1Nx9
 YQuF36Nh8z8tsRXsd6BJBLnvMa8HCkgm9C6ihZi42sU1AZ2vXUGcEZN+EnIF+vCoNSz7
 spKN0JDih8HgghuepcjqWmIrVBYgrEebNN4ZuA3nNeE5PiaPJi2VkohUI+Yj9BFFr4PQ
 Kkbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gOxhFPOLfS/LtL3BcGcnjUd3Dg1O0x9Wa+TZ/LhiRI2O3nXpiWZYIcdhF2iLztn0WfWSNDPw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHqMYdEQpzpmk2kscwJTLEszgy9M6/zK8ZAROX2e8UaicudakP
 4cfkPNfXzUJFCKwy9Tv888s1ZtGtfYuV+0ya4GvEgz3Xe4dLtwf66Suf4jo7ng2/cyI=
X-Gm-Gg: Acq92OEcVmG6jielbJ635kA5TU4HME7KXe4aoEVb8qHgn5trRE0kL2rADDsnUL44xh0
 1G/wv3Zsa+qb9YxKA4C3QHdQcOW2A/h90eeTVNYGPoA/2gtr0JvTSGO5TfJrUkQ5nQ4XUofN1dO
 WeMDGO+yaQ0ziU+6uRWEGpudC2k9oPaqKOFtL18OzpSIRYvVYwiNx51BkqI8o0aMC7gArKFrlQP
 6WnU8+qI1sS+QwpYmQ4IyHsbEQL2NRY6AbRiRHjL19h5XUo0M0CSS+Jdt7EP8TuL8vwX8//K1PF
 5fZN21jD9nY7c14/q8A2dMfwcdFxUZdg2HGQ0bYT3ij7hIBPcl0bF8j7w9Kkcf0SxrJlSZcygxL
 7ph81E+hceZLuk9ifTl5cG5cQ8JPNbTTgUqJNnFSqGlJBOBVQkJqbRTuJhttHXWbPuiRuEETnmO
 okPYWajvrGZNeykdt8LbUm/NRdwesOfEaNV65s26WxI4z9doLIdGF+ncBCb3TcefVbyyec9xUgp
 YKdQE0=
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-490425ac8a1mr25042685e9.10.1779433158793; 
 Thu, 21 May 2026 23:59:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:192b:8d21:b456:cb51?
 ([2a01:e0a:106d:1080:192b:8d21:b456:cb51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d48e23sm1699290f8f.20.2026.05.21.23.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:59:18 -0700 (PDT)
Message-ID: <77300ec8-635f-4633-a5e8-fac47b02a2e3@linaro.org>
Date: Fri, 22 May 2026 08:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Replace Amlogic Meson with N:
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260521201745.43997-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260521201745.43997-1-marek.vasut+renesas@mailbox.org>
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

On 5/21/26 22:17, Marek Vasut wrote:
> Use N: to match on all amlogic/meson files, drop the large list of
> entries which represent the same set of relevant files and miss a
> few in the process.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   MAINTAINERS | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5eba287a980..4c52a9645b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -160,27 +160,8 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   S:	Maintained
>   L:	u-boot-amlogic@groups.io
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
> -F:	arch/arm/mach-meson/
> -F:	arch/arm/include/asm/arch-meson/
> -F:	cmd/meson/
> -F:	drivers/clk/meson/
> -F:	drivers/serial/serial_meson.c
> -F:	drivers/reset/reset-meson.c
> -F:	drivers/i2c/meson_i2c.c
> -F:	drivers/net/phy/meson-gxl.c
> -F:	drivers/adc/meson-saradc.c
> -F:	drivers/phy/meson*
> -F:	drivers/mmc/meson_gx_mmc.c
> -F:	drivers/sm/meson-sm.c
> -F:	drivers/spi/meson_spifc.c
> -F:	drivers/pinctrl/meson/
> -F:	drivers/power/domain/meson-gx-pwrc-vpu.c
> -F:	drivers/video/meson/
> -F:	drivers/watchdog/meson_gxbb_wdt.c
> -F:	include/configs/meson64.h
> -F:	include/configs/meson64_android.h
>   F:	tools/amlimage*
> -F:	doc/board/amlogic/
> +N:	amlogic
>   N:	meson
>   
>   ARM ASPEED

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
