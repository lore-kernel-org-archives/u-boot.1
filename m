Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E8BC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 09:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC38C87FFB;
	Mon, 24 Jun 2024 11:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HW9HYIGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 049DE882BE; Mon, 24 Jun 2024 11:11:43 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3ED387FFB
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso44699825e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719220300; x=1719825100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EWfhviN6WvgKfhx96EfYzMuoJiygBnbMqdG7kCwyd8k=;
 b=HW9HYIGLzfWhTba1XqBMvIVjt3j9vFoKs6rGjJkbRmQB1vmy8So5cYvnFBLPXKUHHE
 FRbQRYWXTzgEcFDVx8bQ1aEpW2Lw6DMAHM8S4M3smhurWxXNNjTWgXstpikRHwh5gAs0
 DaeoFASfXUN7Ava3rZTynP8e+ZtGcxk1J8LG+V3J3adDSXC6kR2PcdFd1oBr8R/Wr1Lz
 dSjj1mw/c/JjgaQJfv8clmLmr5GYoTlTaRHNQQFOEC1eHPSLCcqu3HRF01+U+6XkrtHv
 6M0wOxXrT3ntQgXPiKMipjoy6gNtt0QKElqx5IpP6FlRqyxYvuQjF1KYhcQA7y8AstGr
 f+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719220300; x=1719825100;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EWfhviN6WvgKfhx96EfYzMuoJiygBnbMqdG7kCwyd8k=;
 b=lnrMJHCSANrMw+d48tXgb20A3Te1GtuY+IIVeTKPo5rHtATzgSib7goTbW4JTVllm/
 mPRk9hhMl+eseWfvlPwBoRnU8OnjYyt8PhAde5rxGV6OHPHhWVqJOZSvT5jQ4EW9bvrW
 jAzWHI9O0L8IUCTgw+GQfKKEgqBjuf0SlZcm2AgiNcEr8rkomOBTQOF/VEBNSOO+CENs
 eCxEot0hO2NpIi6IgY+6nNXaSbncR2/NJf34lAzl05jOV3pNZU/GZ1Wf7ikzWMS4b/RM
 rmNzJuKqXKknHUn3quXNhr2eO58P+FPUfNH0z5K7Z5qLmT9NKjj/ra3e9LbQVWZJ82DZ
 JrhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURdjRQ4CjEW0bZ5/MHQVsdNLbKab+SiHvmGM5PgGbtajC7PT/hWFW7mOhl0kHgFBBwt3r0MW+zABcrede4+zCQPkTlVg==
X-Gm-Message-State: AOJu0Yx59dVT69D8XkibJohOm4N8gTl53AWUOUWSvAv8YccxcoXNIGSj
 TeUhrWNCzkePf9vmAIekInZRimlgYAMh2gOzqy3bb5ciw+MCEL3SNh6ANShF4pI=
X-Google-Smtp-Source: AGHT+IHHEGvrSpkT7vZyvxUlqb8JH9M17UnxmZe46d3dA5fdljndtupG4Fjj4xRpS4gB4DOyygq0FQ==
X-Received: by 2002:adf:f782:0:b0:363:7816:7567 with SMTP id
 ffacd0b85a97d-366e949a5e5mr2941656f8f.26.1719220299765; 
 Mon, 24 Jun 2024 02:11:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74?
 ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9975sm125572475e9.14.2024.06.24.02.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 02:11:39 -0700 (PDT)
Message-ID: <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
Date: Mon, 24 Jun 2024 11:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other
 cleanup
To: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
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
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
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

Hi Marek,

On 20/06/2024 09:42, Neil Armstrong wrote:
> Switch to set_mode callback now it's available and in the same
> time make public functions static and drop useless mach-meson
> headers that are no more needed.

Thanks for the review, is it ok to apply it via my tree ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Update commit message in patch 1 to specify why we use _ in the set_mode callback
> - Link to v1: https://lore.kernel.org/r/20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org
> 
> ---
> Neil Armstrong (5):
>        phy: meson-gxl-usb2: add set_mode callback
>        usb: dwc3: meson-gxl: switch to generic_phy_set_mode
>        phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
>        usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
>        usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static
> 
>   arch/arm/include/asm/arch-meson/usb-gx.h | 17 -----------------
>   arch/arm/include/asm/arch-meson/usb.h    | 12 ------------
>   drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++++++++------------
>   drivers/usb/dwc3/dwc3-meson-g12a.c       |  2 +-
>   drivers/usb/dwc3/dwc3-meson-gxl.c        | 18 ++++++++++--------
>   5 files changed, 29 insertions(+), 50 deletions(-)
> ---
> base-commit: f1de28e67aa9b66bfca0fad3dc18446a6ec0b504
> change-id: 20240618-u-boot-usb-gxl-phy-set-mode-c3991c5f1da2
> 
> Best regards,

