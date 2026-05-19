Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836B3CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7665848AA;
	Tue, 19 May 2026 17:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCHP5AOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8509848B0; Tue, 19 May 2026 17:48:26 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5E484870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso45761185e9.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779205704; x=1779810504; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QYoMW5/7ZLFvw+TnsCQiqJeIXcIwdLiEnJnrBc1iSDk=;
 b=LCHP5AOA9jdPdqxcw4uxRXE8Yrm5LBonwmaP/9sX680+svgynRr3K8JfHhlydnn+cr
 DUxi9ncwP6ZRbjGnju2leIwgkIKjvM1RaeFchokweb9/0MHzLIAceXTgOdR5Fn7uE+A3
 eShZ3wq/YW/ljhsL3rvm5/doBm5V+kcH1a/9m28U6af6K6A/ZjXpWimny0zIAvT9UD7j
 U5gzqDC6Ji4VtjJTHdRYMy6So9ZZ4lTu+wb3HFo8KOADbAW1kyRKG+7mSnrOyd67x6hX
 vaTqilXj4EEK8Th0C0F7HUggGog+tUVo1A6moUcpyLRYfYlzGWmsqW3pYBnMhvvJG+Qo
 Nv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205704; x=1779810504;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYoMW5/7ZLFvw+TnsCQiqJeIXcIwdLiEnJnrBc1iSDk=;
 b=B1rj+Nt5Rs36HvztbyzMk/98HSHEKgL/eszJwUi9KNgHRQBAiwUgfgfc1+UDYWrzis
 5jXIGRGV++s4F62z/XTnHfQ3HQ7MfIyTyWA7XWxi3XXRr2NA4QFFEvSJJX8fe1XND54n
 1ghUfLE0n76WJdfBINKs5kpUI4etBvLhkziiL8We7ghvDQ6V+qaJ1SGkyQpQlXmiwpmY
 gBkR2FV8mJII2EDgX6xfBtvjFE28KlNijc4CR/0zwWQFk5L3Zcscm8l3vnPxDB4jDEmb
 TSJE/ZoDGVRHd1qYoStnIKGbP98l6lb5hDG6Nbsu8l05Ti6UVnTwg4YNMalsdXqLzTkd
 v5mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+05+DZ4ZeeJfj6wf/oT0zx6PLDnHWCllHR52jjp7fmsiOdF4/soTyXwoIcPPAYz0tIMbQ8+gU=@lists.denx.de
X-Gm-Message-State: AOJu0Yygd+wWOfbEBCFLbXqWF3k1B0uK90zBZ7u7Ew62nAGbawwTshH2
 NJpydUSgdk8uKje1haXY/3jh6Pk2zMGTMvxt56enFc0WUvwot9nnn8U9S3gFEihBwB0=
X-Gm-Gg: Acq92OEKCCjQ1YDS7GzJ+qV/NY+ryTf2Nuvzi0A2aMq0J6UPcRx/+w1/+WEdA9Vefxv
 HBHlUHIWIMxrI6lWxO9Qi7OHPPBPLj7GbMYOdE4xf4UUNTLiVNH6jTKR/blBAH4WxffnXWj171t
 VjJVOZrqT+qBWSmRTutt64FEVXGvi6vy0KmA3vbBYAsZCQ7cEYuWS2+R7/gvmF67A9xUFY/85HN
 5RBTtTeDMoisjkMCdL85VTMC1ijmgTAGd5f9+G1G+qRUFY/eLE9GyL5co/14tJfZzJJlQrXd1tn
 NTaVBkzSV5Cepib2S6u1k+7s3cJUEirFd4InCS/T7EJQfPLc8H55XvzfoYA6V/C7XqiHwwtkYYB
 tI1iwXRvYvrIC0eTmaraNGStYFg3pHOHlD+2dsRcuwT342MFvZDFZ+RQ8n6DF1omCLJX8E0yE5V
 7SGS4FJIuo1RZxNU4+KH/rPKEtJS0wDsjKiHneFbSe9Xszp12N44pTXbZ+CVHSUEUKp3of0IM53
 BnZaQA=
X-Received: by 2002:a05:600c:620d:b0:490:18cb:e820 with SMTP id
 5b1f17b1804b1-49018cbf419mr79277035e9.21.1779205704102; 
 Tue, 19 May 2026 08:48:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:45b7:1191:7413:7781?
 ([2a01:e0a:106d:1080:45b7:1191:7413:7781])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff43f213esm159136075e9.1.2026.05.19.08.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:48:23 -0700 (PDT)
Message-ID: <6d545e23-cd7c-4ff5-96a7-ea70a9ba10e5@linaro.org>
Date: Tue, 19 May 2026 17:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: Kconfig: use bool instead of tristate
To: David Lechner <dlechner@baylibre.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
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
In-Reply-To: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
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

On 5/13/26 16:09, David Lechner wrote:
> Change the lone use of tristate in the UFS Kconfig to bool. U-Boot does
> not support modules, so tristate does not make sense here.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/ufs/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..6ddf0820102 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -24,7 +24,7 @@ config UFS_CADENCE
>   	  controller present on present TI's J721e devices.
>   
>   config UFS_MEDIATEK
> -	tristate "MediaTek UFS Host Controller Driver"
> +	bool "MediaTek UFS Host Controller Driver"
>   	depends on UFS && ARCH_MEDIATEK
>   	select PHY_MTK_UFS
>   	help
> 
> ---
> base-commit: e3e651c480c46b332f16a7555b97c6c6fd640a40
> change-id: 20260513-ufs-kconfig-no-tristate-4d93e6d9e052
> 
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
