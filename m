Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F0CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5825082CF8;
	Mon,  8 Sep 2025 10:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xzCpdzZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D862382C84; Mon,  8 Sep 2025 10:27:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF0D800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45de5f4a06aso5699535e9.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757320059; x=1757924859; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tSgbfDczpUZliVEKI4UxTLO05IQHi+fn5BpPacoFubs=;
 b=xzCpdzZZFFQBiWqUsuN4Z9jz+v+Zg7NbWYel0SZ+By11c+E5MNos6cnOdSBjmDS9lW
 JVvQYaWGbWHwSbn64+9OZqXB/5u0fH6pV/QFxD7fRdCMJXCliM9dZgtgqvw9TBAnd53n
 +pptGpwG9qf6PDCsNsfP+asNALvjezd77Dr2GPmSmbvNuAgThlhP3q4+K5CojTCQp+Wn
 PZvuZowR3RLohreA8Far9xIirsJi4U+3EvhbyTMXBl8qof6IScMpjOgcUyhdmjJ8/F20
 LULg5lgGu4aVAsGRFURtGxwE5C3gUc1OKrYPQ2/l9XsPOgVIVBkrUwOjnHcrlNtdr7m8
 TWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757320059; x=1757924859;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tSgbfDczpUZliVEKI4UxTLO05IQHi+fn5BpPacoFubs=;
 b=EHzAO9KlIIb+kRGRbQRuR01erz8CdB3e5tE7BXwW0XuuoUc0XRBV+rHLxrnnpxjHVF
 Zti6hnA13FbIZOdF9YN5zc+Ln9aGioTaKfytsL2uPS2RImyWF2/xWFSRUDivYaQIkjEn
 ax88gTBpnwfaPrSTMJp7C4PQ2LYC+4tvLS3VSxR6mdAES4RPQbanKAMwaxJhZNOYFoOu
 yqKhfoccWIL/E6tirhDW/p+17qYo2sHnLnh92LRzVIJGoVqxbvDSRUKUAyu8nVyQfgJu
 pRgqnLyo7GViM4ZNtQ2CkD7l5+bLzVHWThraQYKOq+WemFWZrH+d4fjH+IfDGSrudK1V
 GMWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq/AiAtvX761duHfa0Sl24zt/8pstsXMRgU2V02hi2zLCF4Mk8SrRaRvLfAfbgXJzcpok7tDs=@lists.denx.de
X-Gm-Message-State: AOJu0YygEyOo7djSKUgEzXOqK8uyq2dVMgXUGx71U3OQen2cJlryPPEX
 URGKdfevyuF+amSJ0jUxajPzBqrv1qDQ+36rDaOB13hthRNLHL7cU4/Bu17ntaIAo8c=
X-Gm-Gg: ASbGncuMW9ieJLNIypHRTqf88MD23mFdwnclRQzpy7za4yePzXXJ0nXt9yvGsAMUbpn
 dxjR9K8oQCG2FWs6knVYTjjAHnzF7q36pVlixLe6ZFRhA6TJ9kFQxMaJWuN/o7AtJr8oVdX9bdx
 6GavXe/Uuqzb84xyyIIgGQ23ML78l4m6q5zjDQIZrq2ZGjbClsxhdZZM3KMnh1DRkkJOpl5Mm+B
 m2yOF0RcvQWF8lximbQAyiwr5EQ3TVkok401E8N8n7q2ZNke9RmcXUsvhmLeT4Y5lHdBr+oeOck
 hl+zXn9UCMMnWlB1GgdN7bulBFk4LLdJdjE5NaLzIkfPBNxFeWwkBZK46VhSsEb5ZgYTSFRutRn
 A4csNwwLxGc3V3tR0CZ0S3Iy3fm0xfEJflDhNyJijoc82Rsud66kT5MINYhttIUh34oqoKie+ul
 dEiad7KvnoRA==
X-Google-Smtp-Source: AGHT+IE2hnLZJFivOD+VB+wS+KOE6Fc7znNaQiXaeN6vTMwzAJG1Dom96Hs/i0IhZD1lcf+JT2bDvg==
X-Received: by 2002:a05:600c:5247:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-45de2028b99mr50125275e9.8.1757320059307; 
 Mon, 08 Sep 2025 01:27:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b?
 ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dda6da5casm129519405e9.7.2025.09.08.01.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 01:27:39 -0700 (PDT)
Message-ID: <6643e388-2d96-4cbf-871b-e8838af73f6f@linaro.org>
Date: Mon, 8 Sep 2025 10:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 6/9] arm: meson: spl: add support for SPL DRAM init
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-6-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-6-37395d9ff5af@postmarketos.org>
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

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Supports both GXBB and GXL SoCs.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++++
>   arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
>   arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
>   arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
>   arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
>   arch/arm/mach-meson/Kconfig                        |  70 ++++
>   arch/arm/mach-meson/Makefile                       |   3 +
>   arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
>   arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
>   arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
>   10 files changed, 1948 insertions(+)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I guess we can't do better for now, Amlogic BL2 has more logic to detect the memory banks but those could be added later on.

Neil
