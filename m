Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB30DC79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F043B83E23;
	Mon,  5 Jan 2026 16:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wdUIwVNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F2483990; Mon,  5 Jan 2026 16:18:55 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B998B83E28
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so138995e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626317; x=1768231117; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NfsRk7cfjQX3ZxHDJ5XuKm46fDmZbpIYnGFKjzeAtPk=;
 b=wdUIwVNyc21de0X8thvQIRDHxvlu5NA9d9KZypXX3EeNgI7a0j9OMySb34CGTV7UUy
 JFOLDnq/uiT+eSUuFzPb1MYz+BHdtyy89fmCaLabDWKQansHzjAvQi7U2IZx5NC8zE45
 MGVQWInxgVLHYbY6CKu2RZaXJMtMS/AhbhLVDqnLKzR2rYJ8kUmGEVDgrIE6UU5ooFUe
 xaZi1qRe3IwU5wCmWfcpkzOjWVBSu13hFgrcJtzHypV8IMSDlO0bqBKPUjeoceNfXoXE
 krdXcdBPE5od+jSUFnwGA43OrVNz8OkiwqMYIrxhvn1IzYARadGbxVhWea5WbUbzLFpQ
 brHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626317; x=1768231117;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfsRk7cfjQX3ZxHDJ5XuKm46fDmZbpIYnGFKjzeAtPk=;
 b=DoesGViO5uCrTRf19mqYqhpcvQi1cfwZHzlQS+bZALW0FBo69OHfw0xlm62EarR0j0
 49l0S0gOtxzyOHWSuxR47eSYIExJe1GBzfvPagNEkofTl4KP5EUrrwmgablMPotQneSw
 NKoE4w+AL8AEdlxJLHNtT8HJ3jyk55e7HDi4w2g9Y+p9F9LjqIvdgcAmZUmK0haS4A+X
 w4UJiFf6yxfl/mkQZ0ScdEOtBRJBBc5hqueZFBZcmg8YBJN4Fvih+1wrzxj5g206js5A
 +UIl8pFkndFEsffsUS1qfB6mtCcCh/MBEM1FMR/sSm4CWwUg7GYlD7j7QdVtLw+EAFYi
 YhwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD/Sv7ykeGMnS7rxAtotVL0IhkCy3yXC0X68btmxTZjPby/SodB4HujJMXLQBoEizFLQMIJpo=@lists.denx.de
X-Gm-Message-State: AOJu0YxsfiMdW9jhNyiSZLS2BSkN3DnZBOmJbNIhedfJ7/xOUQDePGOU
 pzZTlK2QsbtL9gXO4Uy1zZgyHL7uu+2ewaAdlEotpjwCWgf1B3/382VAJvu8u+Bz+zY=
X-Gm-Gg: AY/fxX605fSARgihf7T40QNUzZAJEAE+MOSnjeX97Fp57MHDM4Ws0gp1scbp01yx5R9
 9nPt8kFXkqtYtJKREM7nbzpoINK4MkooDmWA7sszELRTmF0/e3PTEit7sHkfiqgp3R4792vJfy6
 qRLwiQ2LoQwbDAIfxgOrJzdqORJfzNiawHSL5oKOkEBc+Fo1H0yv96aiqGiOJeATYVWthYGsola
 NNoWwrkqK3lSKrQez/DKnI/O9CPb4bpryjUohB6o4xKQ7y9heno0M99SK+O7SiQuQ9qvkOs1ljm
 SxVF5c5Q/bmIGtPi3gVv9qszKabHKNCKOf0RfpwetkkbxJmTbOMaxqpjWGAiWHdGiOdgCunbSxS
 BuH4aXWyhEfExOJWLQ4a6o6uzasqwGEO0XY2Yh6PNvBinAoQyQXG6JuHPbo/IAE/UTManLSsS+a
 qfyqoj7V5Py4Rw7rFvn/cIYWZk9TuvHqJljShXWcHtiFEpTmiu/dRgAMm+nAEzvU9Oph1yTeHsI
 g==
X-Google-Smtp-Source: AGHT+IEbtpQ6Mqy0Ca6nP8wUO+xKjhKAWZ8qPhoBM6KnkzgsbJrPp6HL/dWcMsPdQ/CZaMCzUteAXQ==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-47d195a9834mr583413435e9.34.1767626317044; 
 Mon, 05 Jan 2026 07:18:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca569e6sm51599f8f.31.2026.01.05.07.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:18:35 -0800 (PST)
Message-ID: <4e8ca8c4-132d-4470-ba8b-bfab30301d53@linaro.org>
Date: Mon, 5 Jan 2026 16:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: amd-versal2: Fix reset names with binding
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <e1082054610fe73d4487d12f4274315030592c77.1765813212.git.michal.simek@amd.com>
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
In-Reply-To: <e1082054610fe73d4487d12f4274315030592c77.1765813212.git.michal.simek@amd.com>
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


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
NeilOn 12/15/25 16:40, Michal Simek wrote:
> Align reset names with DT binding.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Binding is available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
> ---
>   drivers/ufs/ufs-amd-versal2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index bf23439e59d7..97de0756f70a 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + * Copyright (C) 2024-2025 Advanced Micro Devices, Inc.
>    */
>   
>   #include <clk.h>
> @@ -319,12 +319,12 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   	}
>   	priv->host_clk = core_clk_rate;
>   
> -	priv->rstc = devm_reset_control_get(hba->dev, "ufshc-rst");
> +	priv->rstc = devm_reset_control_get(hba->dev, "host");
>   	if (IS_ERR(priv->rstc)) {
>   		dev_err(hba->dev, "failed to get reset ctl: ufshc-rst\n");
>   		return PTR_ERR(priv->rstc);
>   	}
> -	priv->rstphy = devm_reset_control_get(hba->dev, "ufsphy-rst");
> +	priv->rstphy = devm_reset_control_get(hba->dev, "phy");
>   	if (IS_ERR(priv->rstphy)) {
>   		dev_err(hba->dev, "failed to get reset ctl: ufsphy-rst\n");
>   		return PTR_ERR(priv->rstphy);

