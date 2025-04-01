Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2306FC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FB482027;
	Tue,  1 Apr 2025 10:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wRD+hMhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E8582033; Tue,  1 Apr 2025 10:41:18 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385AF81FEE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2735645f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496876; x=1744101676; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zfZkAGeSE4F+DyQqTS2HeayGT60ajSm7CECFeUZ5CjY=;
 b=wRD+hMhZLC0g3Q4iMtfHDxoy1uSqiHrwlCX1D/qim2Ra4Kg8Ji+QdwfRWbSQ9z5+Bf
 Z2OTSLGp2Zfk5iNeHXLvlHMc5QmeiZWm+2iuw9Nsl9RIb6YUGS9pjbuxfHyT8c0lNPNI
 I/Dd4YTPUuUPYgZv7RmzIMwPZe7REWZmyrfBti0ljb4GCkJoN3dizNvYb/fvCgg++OIT
 X37oXw9hWsLT7uAQy8qSPKLadZkHIFaObecRNL5pLrqjp4zR1aVmKL8ik3plbD4LoU+M
 m81Gat1zjOyFuyRKZf+UCGf6p8KSFuou9J/7P0f4RrABWSY5iIakbRUFeUYRvEHbIfdR
 SVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496876; x=1744101676;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zfZkAGeSE4F+DyQqTS2HeayGT60ajSm7CECFeUZ5CjY=;
 b=A3vN8AxmRxEgk1dEnGSF2oSn73Mys6zJkRfrdyqnulzN7Xeknr9xasq2u8lloE7BEi
 PrUrTZ6n40YsyXyaP3uCMNXE8oDFK3MtgDfjiHHQTek+Cfy4AZmSm1XFSYR7dWDZqwvf
 RJxizR932okuIEghOhUL5l2sGmx2eRP8McITOHkqOPrZONGGr/q0MfrTYnAtmFbmDP+8
 FKu2lTHahZGYNkajr5vCH355hRX2GO+Voz8PqWVYnB8HDVrolExjWYROHClssYFSh8PR
 cAh4HPsP/bFZWdC5sF/MOdTF6t2mp5bAdsA5Rx2A/GRB+Uk8/0ORQdunBU358uKxDzzU
 b1dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFDklMd9uKSeeUa67jcIq5jV4ocfDRQCP8+XUSmgxkVlFbEajdVWfhe4hyIeUFz25WzygN16o=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg5hT1mZpgnA9RRuEjIhqpeEkjxUowQNoOvBOSzxs61v4yaGxQ
 um63QUszsVYHKsQxsHRbN0Wc8rR0930TV5wNGOy2Xl/CX0gyVoEdRzzIHFNpPLI=
X-Gm-Gg: ASbGnctgRbDpUlL0lOmNb2BodVP2ncvkbe1+7l42TRpfdVQ1y1psDzoWjw3purgMJhQ
 8bVe0DGRSTNJkxxnZuAzHYODf1dhw080x8NU0c1rkNGKHN1B+bBETZhdADg+HYQnqiQA2Fi4fCK
 Gslri353R943c8Pco75jO5FnSdJ173GaQRmrlUOO7Dq8S2gcfFFyG0AI+jP7MgwkHuR6FK3aN3F
 J1/6z+UtLl49Xw3mxJR+lz2f6zDfY0rHc5nV55XSomGxzyRm6qW0OddiUIbGeS9/JA6EbJuc3pe
 Nf/+eodU3XY7EROBpRs9pBvmE19KvCCrSiyTJ+zdO3kiTcqMwB+hEQ/JoCE3WID652CzSXL9zkP
 5Jzci/0Z1m+snc8vXgCaYXA==
X-Google-Smtp-Source: AGHT+IEkyXt7/u7Ne0WZcikTafif6KqwIGyCnmqVeOwvSegbYKn9lZUuw/UubF6ktjua14Q2WiX0Uw==
X-Received: by 2002:a5d:47c8:0:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39c120daed9mr7968134f8f.17.1743496875690; 
 Tue, 01 Apr 2025 01:41:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0?
 ([2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41e8sm13703756f8f.92.2025.04.01.01.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:41:15 -0700 (PDT)
Message-ID: <613ecdab-65dd-41ab-a0b1-be40a2286dba@linaro.org>
Date: Tue, 1 Apr 2025 10:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/6] button: make button_get_by_label() case insensitive
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
 <20250331-qcom-phones-v4-6-f52e57d3b8c6@linaro.org>
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
In-Reply-To: <20250331-qcom-phones-v4-6-f52e57d3b8c6@linaro.org>
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

On 31/03/2025 14:23, Caleb Connolly wrote:
> This function is already doing a fuzzy match, since there are no
> guarantees that a given label is unique.
> 
> Ignoring case makes it much easier to catch "Volume down" or "Volume
> Down" in board-agnostic code.
> 
> Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
> Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/button/button-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
> index 729983d58701867f7ea18e9b5f87e7404bca3dce..025917887e80f2fe9cbd3777e04035d20fa34713 100644
> --- a/drivers/button/button-uclass.c
> +++ b/drivers/button/button-uclass.c
> @@ -20,9 +20,9 @@ int button_get_by_label(const char *label, struct udevice **devp)
>   	uclass_id_foreach_dev(UCLASS_BUTTON, dev, uc) {
>   		struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>   
>   		/* Ignore the top-level button node */
> -		if (uc_plat->label && !strcmp(label, uc_plat->label))
> +		if (uc_plat->label && !strcasecmp(label, uc_plat->label))
>   			return uclass_get_device_tail(dev, 0, devp);
>   	}
>   
>   	return -ENODEV;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
