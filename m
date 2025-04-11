Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75903C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D0984097;
	Fri, 11 Apr 2025 16:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nHhY2o77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7CD84099; Fri, 11 Apr 2025 16:12:20 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563AA84085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso2206585f8f.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744380738; x=1744985538; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/qY6t+9iNKr8LcmT5dx0BqI8GDgv7tJY5NEMlvqiLtI=;
 b=nHhY2o774bm7Wi1XC6UmJqZRW1ks4LDQYV0lYloWjfjzuukNHNEr7gwxDEcVsJlWlC
 +D4CluFyc2YT+b2RVfKqR5VwqTwid2Nth2y+acrPYPC0hhRKg74K6+xHe9Xv97i1r2nM
 NFmIGpl2QGxgnfe1w1AvOCwjGKvuJwc9jLo3i3IPQWA5jqp1d4ylOb7SZLHqAE9XxzGE
 a0f0ZXDWfVQ9JSgEumvuB8LE3jJlT4m7u1M4FI+0e+pqdCaHg1IZTVpDIw6M1kwRJCAp
 MADyNDPQk5K55NpnGvIZImBq8P3FVRBz4h9xQu7ejgXwo+0KtuW20GHgNJezTJLTnsJJ
 ug0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380738; x=1744985538;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/qY6t+9iNKr8LcmT5dx0BqI8GDgv7tJY5NEMlvqiLtI=;
 b=DJxFtLXubd7zFxzxThzMOmUT1puvy6WDC3wlIdrjcxYOg0nTjkhTxdeWqF8euEy4lA
 +LLfKifirfTOvu3EpaXMdpY0DRP2fwtHdHMZZk9R0GWZgngNVDGgLcJhSo/H6gZk3uUb
 7gmWx1me6fya7rAjIux7f/7m4dvEjoNQ3SQFCN3Y93tKeVorDinYM/feLpQZ6MyAr8X4
 K94yDm0LqDF0dXDi0Io8MQ1XKwpLrba1Ur8QJLIZmzEG7teCklgcB6M2x/WQf6mx/WZ3
 /Rxq+Vi812lcUg8RoU/ru86HnPOp1cjpm9AIqmes0qkcccBuWw9DLWLor7hNDjUyLEGf
 PDZw==
X-Gm-Message-State: AOJu0Yy23jNGYk/ZB55wMmPmfxOvVGMdvl2EAMokIuPoFyBznIPpxct5
 yFc6HC/6FHdPMNzeHtXtXrpK4oee8OQs0m+lkl11bvrPI6YGo9Ok8Rxq81qs5jkaQW92gmvKtWp
 S
X-Gm-Gg: ASbGncvzddIowY6PlYTdTqAi0ffcT1z36ZTTAU38uXzPlgs9JOIJcpbQJL5ScMJjQOD
 MrbLof9z/zTaFdnBA3guu3ZAvilFXGZWJzEkR+qEreFkibQ/EzzQZiO8PEmJfaQsLk+Gfhql6YX
 JceeBtblqEvLPMuYGWQdegk+Z8BJtW4kJ1ZFonvs0bKiXpdnJJGbeL0u8z29PMyKCXZwb0jnZmj
 7i7ORr70JBbB4LBYCO55q7P+6wziFr8EyAQ1manR/w9cuA56rfZJKK1JG6EjTOFESPj7w5dVHkS
 0RXxXW2tg6X/igDE+iVtKYBPWrl4/gGoSIYpxgFQ0Q4lFBqjQK9qEiFL9kFYuAvWIFL9eWjs7w7
 fbmEziu5suqMTUB41Ig==
X-Google-Smtp-Source: AGHT+IGXSnMjkLgBUnAHo/aY2L6BDpG5ImweEU+dgcYSOfjGBTokB9ISLU3YwQ+//rjdosxBcZkkrA==
X-Received: by 2002:a5d:648d:0:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-39e6e48d03dmr2585044f8f.11.1744380737756; 
 Fri, 11 Apr 2025 07:12:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f77b:949e:1d61:69a8?
 ([2a01:e0a:3d9:2080:f77b:949e:1d61:69a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm2089698f8f.42.2025.04.11.07.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:12:17 -0700 (PDT)
Message-ID: <08b303b9-8d44-4bb6-a616-012c5be78ba5@linaro.org>
Date: Fri, 11 Apr 2025 16:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/8] mach-snapdragon: of_fixup: update comment
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-5-1236823377bb@linaro.org>
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
In-Reply-To: <20250411-livetree-fixup-v2-5-1236823377bb@linaro.org>
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

On 11/04/2025 14:47, Caleb Connolly wrote:
> we don't rewrite the volume buttons any more.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index a5515c02d3de05944dfb7c1b2a5542631b517497..10053e48d88017d2179c96f2f3724c4d5dc4f3e2 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -3,10 +3,9 @@
>    * OF_LIVE devicetree fixup.
>    *
>    * This file implements runtime fixups for Qualcomm DT to improve
>    * compatibility with U-Boot. This includes adjusting the USB nodes
> - * to only use USB high-speed, as well as remapping volume buttons
> - * to behave as up/down for navigating U-Boot.
> + * to only use USB high-speed.
>    *
>    * We use OF_LIVE for this rather than early FDT fixup for a couple
>    * of reasons: it has a much nicer API, is most likely more efficient,
>    * and our changes are only applied to U-Boot. This allows us to use a
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
