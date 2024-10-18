Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9DFD3000F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFDC88FAA;
	Fri, 18 Oct 2024 16:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QcWDzzLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BD788FE4; Fri, 18 Oct 2024 16:06:58 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A6F88D9C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso2021251e87.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260416; x=1729865216; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CmQvVkUc8r0/I+7i6HAtes5H5Ct84Dbdo35m+QxFxL8=;
 b=QcWDzzLUBAen31BGN31ubX2tG/zb2RL1gY8/+t/tLlniQXI4Cm4Z9Zfppu6B+B6Bd1
 HBOYY8tCe7mVHC9VioDLt9H8JtZZkueIS5HMmEf4z0wgOFdXwjWEHbSLr1PDBWpbWX+5
 wpJBFYI0A9ES/DjjGxQYBrYVf4WLX8K3q6RpFE/R9wcCakLMPpcFKUtgTaBG1iN12XO6
 KuelWxVbQWylkJj5c6vHWDS+wsBicGBC4ouJxbXyGyvl4ZlyxSD49jXIo2AaXiBb5W9o
 86w/NATHSUAbzV8G91zpWoAGDZudaGS2kbkUKFBf1JX8T6v8P3x8aWihKmR0vtr5M3Kk
 fADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260416; x=1729865216;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CmQvVkUc8r0/I+7i6HAtes5H5Ct84Dbdo35m+QxFxL8=;
 b=Q7jtpUbEwPn/mP02sT5Rjm1AMT7km7lvZeJ4akBFU1wEDychswIStMkfyG9J60OKCa
 xihtXvWF0rV8kWOA9a3Gv19KVNq+1JxZ3e1JqwY1vr28DlFJ8qys1tg+PebCd1iCk8yG
 nPYotvipge9qXQyXr2T9GI4SKGbGrWnfcQ7Rd0mh0ke99kAWy/PFVLXAxAl3MZROBT3H
 29vi4vuqZq14DaqiU9uVVur6sYyG9RXhht7df/H4dWoJlQ8JKaxFlNYKLR2qJZVxEQg7
 60YA5QZpQCG0FhnKuOelOx0ftADyB8Dv4q8Vls/MYLlkUGGF2ini1cGSPe36lAFxqSZo
 KHsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwJBNfM+OHjjBL4w8K5vxE4o8O/m3yFJ5W162hM7dFe1Wb2siidNi6QS6gdNRfyEDZlLFYOEE=@lists.denx.de
X-Gm-Message-State: AOJu0YzblRhINfz9vk98gH6hrcKi7HcO09blYWBOtbKLZRmObmIHernF
 lPtAxDsF2dvDjxHC35gHgKli817RHvestIIsBsz1aJS3aqamB8Sz/V5QpknrTKg=
X-Google-Smtp-Source: AGHT+IElNVqaN4TPXYPpFpAUjcRnJzwPd/MlT2cTuCGSqiRtoUXsBXDzheKdZw6BFIaSJYayfrhSZQ==
X-Received: by 2002:a05:6512:31d2:b0:53a:1337:5ff7 with SMTP id
 2adb3069b0e04-53a154e79d3mr1680432e87.40.1729260415777; 
 Fri, 18 Oct 2024 07:06:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b623:41fc:e293:c9b1?
 ([2a01:e0a:982:cbb0:b623:41fc:e293:c9b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf086312sm2030829f8f.57.2024.10.18.07.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 07:06:55 -0700 (PDT)
Message-ID: <1c8a5861-e970-4f0e-aa93-f0476028b78f@linaro.org>
Date: Fri, 18 Oct 2024 16:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] lmb: notify when adjacent regions are added
To: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20241018135112.3978130-2-caleb.connolly@linaro.org>
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
In-Reply-To: <20241018135112.3978130-2-caleb.connolly@linaro.org>
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

On 18/10/2024 15:51, Caleb Connolly via groups.io wrote:
> lmb_add_region() returns a positive integer if the added regions causes
> existing regions to be coalesced. We still want to notify the EFI
> subsystem about these added regions though, so adjust lmb_add() to only
> bail on errors.
> 
> This fixes EFI memory allocation on boards with adjacent memory banks as is the
> case on several Qualcomm boards like the RB3 Gen 2.
> 
> Fixes: 2f6191526a13 (lmb: notify of any changes to the LMB memory map)
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: u-boot-qcom@groups.io
> ---
>   lib/lmb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 78fe2d4de7c6..7e90f178763b 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -486,9 +486,9 @@ long lmb_add(phys_addr_t base, phys_size_t size)
>   	long ret;
>   	struct alist *lmb_rgn_lst = &lmb.free_mem;
>   
>   	ret = lmb_add_region(lmb_rgn_lst, base, size);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
>   
>   	if (lmb_should_notify(LMB_NONE))
>   		return lmb_map_update_notify(base, size, MAP_OP_ADD);

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks !
Neil
