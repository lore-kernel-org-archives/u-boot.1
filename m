Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BB4C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23462807EE;
	Wed, 26 Feb 2025 14:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JW6Of5Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C91F80F56; Wed, 26 Feb 2025 14:09:29 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A01805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso42792545e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740575366; x=1741180166; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=F7SMLRn3S1ZTg3G/tWxfalfLDXaeVotVf9L6SRdGPhE=;
 b=JW6Of5RqYto/AmSuTmkZzhSha+WPf6x5KbSd78EjJzsxkLVpnQ+khVYIkmgF/Qpkac
 BDcAB2whqI/uGyNXLGmgSCTyuRV1RG7sM6hwWOYN1iCKWlcjjwGTFgBegSwb48o3oVDC
 Q3wjTANDcR9H1cfTgIs5pqziAWplbTk32PWEtt1KcvBPiteWQZC6AgittJognhobrpyV
 aIH/WxuWHugYxJEIfbufb+jLBPmxAcJuAybLXEzDcLx1ZxJan8qVxm/rLHFzRvJyQkAk
 UuLDLZK3FKgwkm050mL7MHq8jMvyFNw84WPMXENl6YVTSNH6BSn1fL+p1eSvXk5zRjiO
 Aoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740575366; x=1741180166;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F7SMLRn3S1ZTg3G/tWxfalfLDXaeVotVf9L6SRdGPhE=;
 b=Kudy83uxcWjPmEE6R60RXEC4pLbcLHJz6HAupPu+UbwP4mWC76Cm+EWWi/LJKoqqVM
 z+BBMhbqyRJca4+LANKI0Jk40BqECH7qtFT2G0EmMAEh9rfa6tLm1p8GDd6vVkApdS4P
 OeSkszYD/YGjxR4wNiDtm5VkoMeBlkZmdkmG2unDKoOv8ctBZD+tpo0wSLgpO8hBr0+h
 a4Mcq1B2v7YG+tofoTWnf7LprxiDHk9lLkqeFEbgYiOQ3TIXOrBzl3AKgBg7M23nn9GF
 m6TrdMtI3BVHLNhMk77fIVC9HIgDSQhXZo+klUBWuiheYAEMQLuJWEcZguBlikCHMyIZ
 IJJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIGTe503qHzSLxoKBBQOZ+CsE3JZPY8TCFqsQXfZXygoIXjUDxODNmk2UzZRHm80Jjie7pNgc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywsl65bOCRUzImNe1b7zlncDbd+dQeS8YCFaSOphroyHGKTe56I
 4pcSkz3us23P3s4h9NI0w2FXk8WDvPhaROaAIofFIsaOX6EDFWyDl0U66rsgCTokVzn8j63wbAO
 3
X-Gm-Gg: ASbGnct8bE25N0vE2QLKBv6BbWYyyNXn4LqJCsVoj+BG03meny1Gp7nigJQDK9v7bIM
 DI5XVBSR+aZVj2QIYMSMjtudTPZBdaHoHlplzpsv0hFEV8EO2iwJ6WHeU2//IYrD1+f8dHZpdQQ
 xLMIRWNbWfDI3mKxbEKBqKBm1HhLSzofkZ3f3i0Zlq/Z4Hlw9bU1bQXctzGR28Sq+EGc8VEocnc
 y3Nour5LTAAj5QEmBg79EY/VFYqjdIfhlBeN7ThK7t9vovY+24vxzk6Q+OUyCf3VidXB1fgiL7V
 ZYrX9tigSI8/X7KDFAKIqVlfKHL25ysi0fWoUfzFbgUx8y4zJAEGk8GYxwo9fFZTEI/zYLDTTiB
 uUAY=
X-Google-Smtp-Source: AGHT+IG7CB5PBerypG27M/bZ8/ZFkFlfkdCcA8+EP06PyuQ765WMYhG39frV+yKoUFKbh/AC6yreqw==
X-Received: by 2002:a05:600c:1395:b0:439:9b19:9e2d with SMTP id
 5b1f17b1804b1-43ab0f3cb4amr74691665e9.16.1740575366530; 
 Wed, 26 Feb 2025 05:09:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee49:80db:c8ef:c826?
 ([2a01:e0a:982:cbb0:ee49:80db:c8ef:c826])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53983csm21924995e9.23.2025.02.26.05.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 05:09:26 -0800 (PST)
Message-ID: <92f481b8-d177-43af-8fc4-2c80a7cc6d7b@linaro.org>
Date: Wed, 26 Feb 2025 14:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/5] rng: msm: keep core clock disabled when PRNG not
 in use
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
 <20250212-msm-rng-fixes-v2-5-645cf8d3fd3c@samcday.com>
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
In-Reply-To: <20250212-msm-rng-fixes-v2-5-645cf8d3fd3c@samcday.com>
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

On 12/02/2025 08:01, Sam Day wrote:
> This is how the kernel does it. APQ8016E TRM also states that this clock
> can be turned off when no random numbers are needed.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/rng/msm_rng.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
> index 01505509103f28f7c91dd47edb83c23359163c82..aab602c5ed0bfed8b7cb9593fe22a8cef8f0f61a 100644
> --- a/drivers/rng/msm_rng.c
> +++ b/drivers/rng/msm_rng.c
> @@ -44,6 +44,11 @@ static int msm_rng_read(struct udevice *dev, void *data, size_t len)
>   	u32 *retdata = data;
>   	size_t maxsize;
>   	u32 val;
> +	int ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* calculate max size bytes to transfer back to caller */
>   	maxsize = min_t(size_t, MAX_HW_FIFO_SIZE, len);
> @@ -66,6 +71,8 @@ static int msm_rng_read(struct udevice *dev, void *data, size_t len)
>   			break;
>   	} while (currsize < maxsize);
>   
> +	clk_disable(&priv->clk);
> +
>   	return 0;
>   }
>   
> @@ -118,7 +125,9 @@ static int msm_rng_probe(struct udevice *dev)
>   	if (ret < 0)
>   		return ret;
>   
> -	return msm_rng_enable(priv, 1);
> +	ret = msm_rng_enable(priv, 1);
> +	clk_disable(&priv->clk);
> +	return ret;
>   }
>   
>   static int msm_rng_remove(struct udevice *dev)
> 

Looks good

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
