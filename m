Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92710C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211E182F85;
	Mon,  7 Apr 2025 20:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yZCQHW9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D1682FBC; Mon,  7 Apr 2025 20:08:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A366782F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso24312025e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049286; x=1744654086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=IxYnRxE7ipBdW6Ih9kEKHidPG0cBQf52yBlvJcWgC1E=;
 b=yZCQHW9iKrY/A63is6JkLuvKq2fpX94w9PVzqm9lyGuKy69JFv7rtLe0GylEtiCtfE
 aQgfNUuis1qI7OdZQp/3XJoiw+Q8kJBvPirabzyF2JusCHAhCNx4uGuu7ruLcgF2xWxm
 n0e2FS32CSA/7T8WO4EFWY9+yI1LTMnK4lnmua7j5bEHB+JfnrUvPtALQHca6eqdQJ+2
 AC+X857VZyh1UG2VfM8ZBy44VxQcgE08AUNVOfzV02kY025cZMrcd7NEj81qWuoaiTy3
 TjD05sjWrAWGAiCXg8y37OCDCJF1qqIf32voAtvVixq9g4knVFOJ4QkD7+3ngEk9LXa6
 XsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049286; x=1744654086;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IxYnRxE7ipBdW6Ih9kEKHidPG0cBQf52yBlvJcWgC1E=;
 b=oc4ZzjKPPt6qXIU+Rx+fgmZ/ETTFXzMAupn79GE5+EJNDkb2hLcn2Dqij+7kZrTYRg
 x1ioUDXv1Gc6uj3iis3l654chDAjzkNmDVSw7rf/tkobxMd6WrR1wu+pEK6AJUEqVMWo
 Ga3eqzJLX1TBwXryceSDPvgX+Dkc7JYImlpdwXcMdCKmJ0ksEmUe5oJexONe0H0Mn4sc
 Oh9iNRjcr0vtdL0PjWJ4ahnQ3mscBok1i7mdW9FwJ98gH5foza48nYFkVc8LuPFpy86x
 rxgHn1KXueSP6RR4Bj8IA1vjGiEDKKlMdq+eG5gm9usbQv5NGPmraHTBefSYgCKDeHWo
 wZrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3WiF8DGtJi+a/LXz7b0Awz6bA+KMWgWy8fRbFoCKd4GNk65HAW/WG455bfR1GSsMvo5VZmKI=@lists.denx.de
X-Gm-Message-State: AOJu0YxqmvvPvKnm04ufqOrEZ9IQMEzhtTGfqROjXqJoCccxXwtTu8U1
 r0HexH4LAfy6ZvH+xfOVgyWjAEN3+DXr1wflypB7aHvDtYlYcNCfU0yOV8uIzJcrxcd2dU0w9ob
 a
X-Gm-Gg: ASbGncsE40a8S7PtJqOsfFreaolkZEqznC6MUjmEWzObv/UwZXYN1DLaCmM/ODux5S8
 +Bifd6VPasPIx/zzMhjLpbC4Be2To5/vDVLxmohs/AUnwoV5eJBfCp7O4Ik0eHhLaCavuSa0Ety
 oRdIozonGsHXsXroFCqzcZje68qCgL4wAcXa7u9nBQErmZsQgNQyTq05IU3LU9Pvv0PLWeyvSA8
 knrp7CSSDV80YHWfvBP+BVVueQMY+esSLDpYe4rgMxyu/P2rAoa1XDZXuGjmY9luw5/paDn7UQH
 uSQ0fO4j5utFu1Qaq/vBG3lrKPkSBdDvz76t5PKMFojFJxKXNvFCfSU6XPvyRiMVBhPxeelavz0
 PJMK65/2Bjjx8/57IGivtNA==
X-Google-Smtp-Source: AGHT+IEy5PlVAlON1I4OAQdNcz2CNyIEuPOPGHz94MIKLXZe2OqvuVfWHvd6JEMT5m4zCDwr+A4eRw==
X-Received: by 2002:a05:600c:4e47:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43ed0bc8dbbmr154408335e9.10.1744049286128; 
 Mon, 07 Apr 2025 11:08:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b69c4sm12639075f8f.43.2025.04.07.11.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:08:05 -0700 (PDT)
Message-ID: <59920cc2-271e-4c72-980a-0010b83085f8@linaro.org>
Date: Mon, 7 Apr 2025 20:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 06/13] board: dragonboard410c: Drop unused linux_image
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-6-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-6-524aefbc8bb4@linaro.org>
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
> This does not seem to be used anywhere.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.env | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
> index 57a30031f743f43d4a6389286b426b404d2f371b..eb42c0abcf11fedf7ab86d1340531b4ff5b52bf5 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.env
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
> @@ -1,7 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   loadaddr=0x81000000
>   initrd_high=0xffffffffffffffff
> -linux_image=Image
>   kernel_addr_r=0x81000000
>   fdtfile=qcom/apq8016-sbc.dtb
>   fdt_addr_r=0x83000000
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
