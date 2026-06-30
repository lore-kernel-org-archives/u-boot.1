Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1858C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 14:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C5184A51;
	Tue, 30 Jun 2026 16:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nWMg96Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825D484AC3; Tue, 30 Jun 2026 16:46:54 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD8584A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 16:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493a287b8c1so18547535e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782830812; x=1783435612; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PPxfh8xo772It6njxLvEZFp6x9iTW6npiQicTe/wGSw=;
 b=nWMg96Tj0Zy+lGmE3EtORPePzayqPQVgfcBtZDyLUPURcvNMDw+xV+onnPaTprGWaR
 WIaD+kDDgkG+RMk7NoKrKwSQK7t+LI62vMiBj6KdloPHsRM9/hHCRjMYLwFAjRZBY+Fl
 K9NJ9t9+UFdMO3WsC6z8beQuhLAy9PHM0tEifiBPstu41vUo1rzuxW1sBHif/xbHdLPp
 plXs+QDtXnc0bVCcAvfquOzD1qY+XPGwv3ArbjA3P4kJUz+JCptRWG0alE4eNA2uVB3E
 dKfBeGNzcxypBzX/N+ztX69f7Ne4rgCBX5vDsERcDxfYsl62Vae5EpV+KAYuPrZ+IJTx
 bJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830812; x=1783435612;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPxfh8xo772It6njxLvEZFp6x9iTW6npiQicTe/wGSw=;
 b=hDbvDlh53oqw59tMZJapFxAchBdH7MViPcNcrnYLxbjD4HA7diMljJeZeLWA3NNIst
 Yog6cknDX28SdzJtc1y/hZ2VF4VqxX7HQ2rYxi6BNsl3aW939TZerR+YT0D58hfEMCkS
 o7/gNtuoBm7tgpGCZUHrsKgJQivS4WD27JsR1Ts+SG2B2sj5AYIzneZyykRWfCmrbN65
 qp+Q/MT1HeQt/b6UL33ddITtI1Jy0ylZV1luTndnFAc9bQqygs4Vr88NZW+KSTvx6B2h
 HepvK7NREnjnTGSrtVeIa7GdfafbcgSlLOl6Il5fQYX3tMZT5StYV10MhTRF8wxOh3/z
 DFvw==
X-Gm-Message-State: AOJu0YxNjZwPf12IImD5LHEl2C4nCPMbBEZe9te7bZmyKyWcN6QMR3po
 rjo8zOalFpBSw2MjRz4unEPHYRKKcIum5F574lulXWQZWMlaQVCTDOCX3PHi2nSsdBNe0V1xOO1
 Bcnse
X-Gm-Gg: AfdE7cmBgCnInMrbHX60bl+6d3amwSFZlbZcK8AY2AEtHy8VQWlNuGabVE2Oib5Ij4Z
 Ck68+wHprsl8qwjE1VRZDj7zO3ddefBNd4O/GVggW2u0N9IM/BefRqeqjqQjG5HVDuu81+DWuGe
 nFMwp8b7Vj12JLbei8LwTVfYOl0XDjpja48/KB1ULa5ybxVG7k3/BWWqF0SmZHHd5yuNA4TBjun
 WyAX8AJZU4BJ7IT0gNULgWStsdFU0USitGfzZ7ToZgpnB1hXa5nn+0zhEj61hsJiN2iGfiOCn0m
 aHOxV6px8GPkIdUj8cVHIzzBNxqVXK2bZzSMUyXCC4I/iW8xsdf3dsyyP8Ai7OOLf5c2pCccxTX
 O/lYSeOgX8zHD7r+Yr2+M6+Iso7BPn+ABxlEnw8Kc8gzbSQQ9kJ2eTv5aS0XpJs6rfmSTc0rQLa
 BgLG7X9nC/0FylREvHkKRF6YV4kEjBnuGr6yzZk8TQoGZtCw7vK1YjQqQAxpnKj8XWZVVf
X-Received: by 2002:a05:6000:184f:b0:475:f0d1:eb70 with SMTP id
 ffacd0b85a97d-475f0d1ed5fmr3645680f8f.61.1782830811560; 
 Tue, 30 Jun 2026 07:46:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8d1a:9a69:668f:13cf?
 ([2a01:e0a:106d:1080:8d1a:9a69:668f:13cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636ce7esm8920970f8f.23.2026.06.30.07.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 07:46:51 -0700 (PDT)
Message-ID: <08173239-5184-4424-bcc3-0e77269907ac@linaro.org>
Date: Tue, 30 Jun 2026 16:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add entry for ARM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
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

On 6/30/26 16:42, Ilias Apalodimas wrote:
> Since I've added various features in the arm architecture
> support and review most of the patches nowadays, add myself
> as a co-maintainer
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af1964654..45e9076de671 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -154,6 +154,7 @@ F:	include/configs/apple.h
>   
>   ARM
>   M:	Tom Rini <trini@konsulko.com>
> +M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
>   F:	arch/arm/

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
