Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3882BCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858388814B;
	Wed, 10 Apr 2024 10:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OB3gHhFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4668818C; Wed, 10 Apr 2024 10:40:09 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A06787073
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3465921600dso595924f8f.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712738406; x=1713343206; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KmK7QLISS0jZAEf3O7hmnkIUWsAp1Jj3K2SeBXgpm00=;
 b=OB3gHhFIpaoYZg+2b+8HqabOgzx+AjlOaYdE/66BCYDS6I3Dhyu5IcwFdywqcyT3J7
 9/306OCaRr7H7rOW4ike3hCZcdmOmnSq5w3XCp6xRLzUmsLp8r5YOwMpMBLW2LfC6v+e
 sPFQyJ1Axb1tbymzV9LOFXmutXDzo4GMvkWM1++tdDgyMuRTp+ATrPhsmSDawlhoiHWI
 ND2lJaUWykiX53FZmKJyG2sV1qGed26LPxodsBNuIlbRkP4v0SPXhXwtEpFb7qsjK2jY
 YWKwvEf4PUDSJzxu5o9zpQJYj1VLq3MzWcO5yiXzreEn7SYyI9in2xaxbayc2O2ZUseM
 Qhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738406; x=1713343206;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KmK7QLISS0jZAEf3O7hmnkIUWsAp1Jj3K2SeBXgpm00=;
 b=l2VU1Wm0xi7zuHYfxSUMuky85qw15JnGUw+HUg/8zgq3v851fHdfbgWnpX+V/Rbtr/
 MpDWlPXdsh3DW5Gs7a1TA0Z4Vlkk+z9H10ibd9SX4CIKcfsih3KT1fDaR0HjoZ0ufGGq
 sjjlPBlI+S92cB7elZONPy+AOboBGHA25u1DbEeV91uct8sfKrL5fCJE27toL6uNCIbn
 ynW4yhcQKCAAGSDuomW2mYVD4kqkuqbHXLSJ04PDIVxSHHNkv9ZMsbemEyc8tUahwMEp
 dQAXtOkblEcIRVl5OZLyw23Cu1IQJ4+LNvBdTJmylEa4aGcvLqMAtgJzBsgdJ9/V1FYD
 gGPQ==
X-Gm-Message-State: AOJu0YyZ0VMS5mG/JXTBpp04pTZ70W2nrOyA9ebaB+0bWpA681DmeVui
 0EPDQ9IfdM0zpVnXvZNPZFsHf15IBTMq6n7CTxnqwikRwmHpColCoPRRjH8t5yE=
X-Google-Smtp-Source: AGHT+IEerYDzhUMGRrGPYVrjvzWLc125wWAvUPyirzHmoo1Q2g11+GMI5ClVcn99Vdg3h2+zDGrIlQ==
X-Received: by 2002:a5d:6d81:0:b0:346:75ae:471b with SMTP id
 l1-20020a5d6d81000000b0034675ae471bmr640478wrs.51.1712738406436; 
 Wed, 10 Apr 2024 01:40:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a0560001a4700b0033ec94c6277sm13264922wry.115.2024.04.10.01.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:40:06 -0700 (PDT)
Message-ID: <f49a8b0c-6557-49a8-a699-ade7905cdea1@linaro.org>
Date: Wed, 10 Apr 2024 10:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/7] mmc: msm_sdhci: print core version
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-3-5039164ecbf7@linaro.org>
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
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-3-5039164ecbf7@linaro.org>
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

On 09/04/2024 20:03, Caleb Connolly wrote:
> This is useful for debugging.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 5689b4765122..ea5d6b4cbbee 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -172,8 +172,10 @@ static int msm_sdc_probe(struct udevice *dev)
>   	core_major >>= SDCC_VERSION_MAJOR_SHIFT;
>   
>   	core_minor = core_version & SDCC_VERSION_MINOR_MASK;
>   
> +	log_debug("SDCC version %d.%d\n", core_major, core_minor);
> +
>   	/*
>   	 * Support for some capabilities is not advertised by newer
>   	 * controller versions and must be explicitly enabled.
>   	 */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
