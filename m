Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773ABC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C298D88077;
	Tue, 26 Mar 2024 11:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g0dV4urC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79C787F9F; Tue, 26 Mar 2024 11:21:16 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670F987E3F
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 11:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512ed314881so3884508e87.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711448474; x=1712053274; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qZqfRGRSliLghS0rphzp8Xt9mme2q+JhQpqs3+sUNcE=;
 b=g0dV4urCM7ROvwb6PMSswn5FDEVzbtIqr9/CTiu7jhSkbAChqXp8/wEWmIPvneehLp
 F9m9tfVuEz4YIHTPBiy7g/0zvvHWeGgpWHpfOJ2qxeCiZLLOc+u1H4Gn5qXKCDqNjeZP
 PO8EG2pQG1INB5ntw7gbcx9LwLWZE4DXnLGKTAHu9YG2baWj+LQigsY5ffOeeZGtN8M+
 8ofOw9hJeyqFFZiM6ydQrAcy+oNWvvj9oS9SNUbJxuHpZhIDrDF9O8SJJB86JcuZHfb6
 UbllHscD2uMv0idE40o566CltCMt+/gy5driiuiDE7/jXtdsaP08N+Nbh5HmvemU4Vc6
 6HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711448474; x=1712053274;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qZqfRGRSliLghS0rphzp8Xt9mme2q+JhQpqs3+sUNcE=;
 b=biSxweuJrFT2P6mMg3nV+HKDOti0b3mbvO7cm0i+p0mVSaoAN5zwBhKcC8nlCNqKVX
 /qT6h9Hmxah7deryhpYibg6DThYnJ5gEb7zOrPvmiXZduyg8k4D/t3YU7BQ0rkwE59a6
 JIan8AjCiGsr2LOHnBkXzDtrIcDyrxlSs6+SBuZWqb3yLrgrCTNcGTafozr8CghQgDVV
 +vpXb0FNsHzbv9DQiDc+JKUeSAu2+KGAir7vw2SU87HRfMGqSq0qZdjBZWr2kFO8vRke
 kQE3EasYb1/lknXOm6GK1gRonqCtURA86zHthjWs8ID2MiyPZFuJF1JD8zO9FUeRXymE
 6fXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5HhiU8dxM/UV163zhn2YYyVfH8Vpnr/Ym1+oZtxpinxd57J0rjXw4DyXOPTp5X05BeUlOjuYYuJwwQXvy8wSvcUIwMQ==
X-Gm-Message-State: AOJu0YyTVPF/Jc2zFDdBXgB/rVQLykSeEU2yqW8VJJMxX7QtkrKO870z
 E3+ZW6TLIgnbJ5VbNJN805HbUOyRra1/ZfeSX1Ciy5iKOXmFmQrQ3stUz4qwXAI=
X-Google-Smtp-Source: AGHT+IEQOs4QMwGIiOvKAb7bOjNp1zhplN4N2rROAEGmEHhy5fpC8QzSmDvt+CTrA2NjC/J2H4BirQ==
X-Received: by 2002:ac2:47e2:0:b0:512:e220:d3ab with SMTP id
 b2-20020ac247e2000000b00512e220d3abmr6381472lfp.65.1711448473541; 
 Tue, 26 Mar 2024 03:21:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f220:43f0:cd6d:7275?
 ([2a01:e0a:982:cbb0:f220:43f0:cd6d:7275])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a197712000000b00513e24c304fsm1507975lfc.193.2024.03.26.03.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:21:13 -0700 (PDT)
Message-ID: <791d5926-7541-4c5b-9fbf-03be90364c03@linaro.org>
Date: Tue, 26 Mar 2024 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] board: amlogic: jethubj100: fix update docs
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240326082004.1651782-1-adeep@lexina.in>
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
In-Reply-To: <20240326082004.1651782-1-adeep@lexina.in>
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

On 26/03/2024 09:19, Viacheslav Bocharov wrote:
> Fix linter errors
> 
> Fixes: 2fc5e3c1668cffdb4b894986e98c1ee10f6e9955
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/jethub-j100.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index 80bed6e919e..cbf1ea76107 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0+
>   
>   U-Boot for JetHub J100/J110 (A113X)
> -==============================
> +===================================
>   
>   JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
>   manufactured by JetHome with the following specifications:

Thanks, squashed!

Neil
