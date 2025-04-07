Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0221CC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84AD482F65;
	Mon,  7 Apr 2025 20:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QXF7JxPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA1582F85; Mon,  7 Apr 2025 20:08:37 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 481DB82F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so2782403f8f.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049315; x=1744654115; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aEoJCcV0LishE+AK7VId3iGjXc7qNcewn8GZ1WwgF74=;
 b=QXF7JxPBzcTh5ulquMyq8P3IEmANy5plNxmPc4xlmJXkZrOZctW+GR31nn8L18vjD3
 XunyqbDR6/oCY76xDz/2MrME2rs7RuXBAtleru0e/Fy68O3U4QbEI5AxvV0zmen5kCRq
 hcH7wZmxBhLJ7rr4MjGFe7w2Ht8ud1vXhQGOzkj5QG+qedlD42I6mzx7JgWTVOxwY281
 0DrMgCAZQeL6pP32phCQHsWc11earaiv98uqPz/1VUi5tJKLOMJ30vFPSsh9H+IDr1fA
 5KA4GbLNE/fcaWGtXhA81wCeowvJ42/QG9LuoRjGen2X5xu/zlehB02TdeHz6DF8+TEr
 Wj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049315; x=1744654115;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aEoJCcV0LishE+AK7VId3iGjXc7qNcewn8GZ1WwgF74=;
 b=P1Ij9Fv8hK+J8NoJ85lb8h8Icmx2gC5e4OC1zDNPyhETmOHL0wjdO0ieKYczDZHRGb
 JsTL/9Vbt4bq7U6KLV3KozwayAPyROmheR7+QSIcVtVgowPUkvwXwczAuQs6gCDxlWYT
 gGvAjHCHmzCq2iWHQ+f50LJec9+WTJP5IINx485Vl+xPzPCGPzpSQnD7DfBHmeVqg2vR
 /qr8ZxMlZ6A0uQM9fcT1kGEhDkz0fYcF/eMk797DtRQqEcOQTbqnvkRlxFNcxcMVfrxe
 dDtYQrwelLvweIUCDQgY9S5mxXMzYm4m/cxImUHBRKKFatXVsWtzhjUqKN3CgrUN3A0q
 Hd5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXWsrgd7X5oMi0hhvop7QuIOggUCfnr4MMtOyJ36i2Nj5iNubk3+EIQ9Q8KRyatRPh0exZQ70=@lists.denx.de
X-Gm-Message-State: AOJu0YzQRaGQC9TrE8RptnIt4TNJbfDznKwtqVsbSyjx2xWzplhJIJhB
 2DLzoCSykUvZ82ukQO4iLRIORi8RQX8WKx3/usDeBnuugn5skJlk5k73ONssk20JR5u27rNC/J2
 T
X-Gm-Gg: ASbGncsvI1kvRys+oCcM3W0mkXQho3MVwPm8hfHmO/6NvNiJbOZ/00hJBRPlXvWIUJ0
 mBDZNHwvwH484gclRIpaL+u98Gz0dwosI2I7q2FVI4v0fAk5h2ujMK46SZsv8CASz8K9VMNBhBL
 +s8DSZdCPFWRH/YJREzSnU8I74FgWaFHLJKVKXNVpnk9yPBIIqAqWZgxhKYd01dvfsLL26eOW1/
 OdPd7R2ZKNsflJf2yZAzrV4jPscEDNJVoUdhOxrq4COHYivHrbBJJ432TXS0UXxtwlna2Bo69D4
 055hHvyxe0y5Ly9CxXX+y8r6TtofN+neTGXkmeZ7qIqPxwfGcgJ5Rf+aQ/5jNY9f7RPbF6Wu8aE
 EUhgV6XunTgVmVEa8xur9cCvEld4x9vl0
X-Google-Smtp-Source: AGHT+IFvgWccpgdOJpUHhsZs6X+6IyFOOmmXPdvbicWZneZLwTnK8TMK3EJWDLKHxQfsMoYer5sP2Q==
X-Received: by 2002:a5d:648e:0:b0:39c:1424:3246 with SMTP id
 ffacd0b85a97d-39d0836e58emr11803833f8f.2.1744049314757; 
 Mon, 07 Apr 2025 11:08:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a727bsm12674060f8f.27.2025.04.07.11.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:08:34 -0700 (PDT)
Message-ID: <bea1ce41-323c-4a93-b761-d65fbff19c03@linaro.org>
Date: Mon, 7 Apr 2025 20:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/13] board: dragonboard410c: Use dynamically allocated
 load addresses
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-7-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-7-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> The generic Qualcomm board code allocates addresses for loading the kernel,
> ramdisk, DT, fastboot etc. This also happens on the DB410c and already
> overrides these definitions defined in the default env. So let's just drop
> the static ones, since the dynamic ones work just fine.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.c   | 2 +-
>   board/qualcomm/dragonboard410c/dragonboard410c.env | 8 +-------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 61d68e7f0c6bed16861e6ceaefd2c7dc94807d65..697e3c9b08b5c874912eb66ff4f0b3d32deaae01 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -66,7 +66,7 @@ int misc_init_r(void)
>   
>   	state = button_get_state(btn);
>   	if (state == BUTTON_ON) {
> -		env_set("preboot", "setenv preboot; fastboot 0");
> +		env_set("preboot", "setenv preboot; run fastboot");
>   		printf("vol_down pressed - Starting fastboot.\n");
>   	}
>   
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
> index eb42c0abcf11fedf7ab86d1340531b4ff5b52bf5..0032dc3592a1021e4bb422357867cc26b4b30551 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.env
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
> @@ -1,9 +1,3 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
> -loadaddr=0x81000000
>   initrd_high=0xffffffffffffffff
> -kernel_addr_r=0x81000000
> -fdtfile=qcom/apq8016-sbc.dtb
> -fdt_addr_r=0x83000000
> -ramdisk_addr_r=0x84000000
> -scriptaddr=0x90000000
> -pxefile_addr_r=0x90100000
> +fastboot=fastboot -l $fastboot_addr_r usb 0
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
