Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DDAD10F45
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F67684201;
	Wed, 26 Nov 2025 14:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uqX/egI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03CB98422F; Wed, 26 Nov 2025 14:10:58 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055F8841E6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 14:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so3901198f8f.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 05:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764162655; x=1764767455; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KrIoBFBz2wgdKcbz2c+A/gjGCkE3op5fxDQoX0ddYek=;
 b=uqX/egI+2hirXe+t+A9Aw1USgfG8hLdfXS7RtiBUGwOj+5+yGZ1P89wBNzzQ70up1q
 r8ZakfdywHFwbcLOJEyh4KXdcQ3aTb9HJk66X6QCg43vuwCex2pXpzQd/Zg2SEspt1pW
 Wi7pZggVoG5Ci396VoE1YyZdOX+Use8c8WVG8dHE3XM9JP/WuwuxjFhYIqULTuVUvEXU
 kvUm5m8hAY6DJyJWyLUtgb0QylqtTvWS6IjtV2OU8ACPX4wkTj/Mdzvlb/29tLKBj4yZ
 YbsyZaNbpvpgrUrRg9T7kGzXUTeVcltXTM6dRFDIM/QekI1+ke05kJ2husPD1xF7Uqiw
 iH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764162655; x=1764767455;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrIoBFBz2wgdKcbz2c+A/gjGCkE3op5fxDQoX0ddYek=;
 b=iApXFYybLCHBYJKeTdaG8NXUl2AdjnO3rQ6bQGvYoTs8VVNNldvEC7KTURg3DWX/zg
 LPQ6mFkLqfYjK8vELJrWL4+4IJRp4AhBRVIPvcWWV+/3MM/KQoLiRVa96f9o9eLfUeDi
 w9/GMxrxsWAXZFKFYg2AFaNPfYvDe0KJr40at3Fj1whYiEarq1ycydO7aJX7mlHTYxyh
 JAZeXxcMKJZaCiaPb2OxHWcHIKewy4xz1FPq8GFKVSM2E8/01NALnBYMnzCMBI2B1erj
 6aBNLsFX/NGpvzmbJFhz+G3VyEhv/v4I43uuFJQ2tYezuNguALbS0P1WRKvs84FQeWeL
 NwpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp0ziW9stUFbgDczWZveo2lzkQusqhZSIPSt4flY3lCQANuIWz7fdYiL97hYb2VnOOnig7Qf8=@lists.denx.de
X-Gm-Message-State: AOJu0YzXhLTEaTzy9cLuNBCYhqFfZdm22r9mzNqJB7RB+6tYHBUHq8qP
 RtRY2IWYoB1e5o4eraGqzHX3urA21aq0DDPcT+IW/auqR8DAUenco4WdYctqK6POyX0=
X-Gm-Gg: ASbGncuRo7ZPivPGEZSAaaAmV/+uRiWvR1+PmHDb19aPd/Bxho1qk69BIlDlrqDh9ah
 cno9/tDoZmq4WhjrWAwkLlMHMQzyE4Ln6VXh3QcWrqgEVzsFmOxc+INXhuZw8qAv9s0f0kO1OKC
 1ibPj0d0qaV+D1/GRlggtg1ngY+FOHzHdkDCL9bPxWXaO6QpTC0CHoguJ2Jx0TwIbbkEn7upv66
 Psp9rmuWT/BSAxds+ITidKwRRJjlrmLUedQI52cysDh9NcozdvkDIF3uJ49m9ldx7AFGHvXRJhL
 crNgLY3sRuOFeJVo+OVuOHKiE33+ZhViiJO5m36k47nHWdhJjKycMIxf2GGYMujN+mYNLrZEy0c
 +0+UzZTOY/P4GoNQw4XTLldsu84pPmJ1GZDbckFPh3vV8Yd3FFqoTWv0uO6bpbMwkiX5li82Lsd
 gCMDnMk4jh26TjO6gds/G7v8s5u+cBTiH0o5feSC/+sn8vSaXsFKnGvYGIGD9q
X-Google-Smtp-Source: AGHT+IFHNz54TgWOUUVPb68Mxt5+k8eUSXq+l4G0w88Y7ghi6Oq9JQUWxGnslhA2eOHbkFl/WYV8cw==
X-Received: by 2002:a05:6000:228a:b0:42b:2eb3:c90f with SMTP id
 ffacd0b85a97d-42cc1ac98b4mr20719151f8f.10.1764162655306; 
 Wed, 26 Nov 2025 05:10:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91ba:3a5e:334:4534?
 ([2a01:e0a:3d9:2080:91ba:3a5e:334:4534])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8baesm40805651f8f.39.2025.11.26.05.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 05:10:54 -0800 (PST)
Message-ID: <4934bf6f-a667-4b29-885d-045fe68c7763@linaro.org>
Date: Wed, 26 Nov 2025 14:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 09/10] spl: meson: set SPL max size for GX SoCs
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
 <20251126-spl-gx-v5-9-6cbffb2451ca@postmarketos.org>
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
In-Reply-To: <20251126-spl-gx-v5-9-6cbffb2451ca@postmarketos.org>
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

On 11/26/25 13:17, Ferass El Hafidi wrote:
> Enforce the max size for U-Boot SPL at the Kconfig level, to prevent the
> build system from producing an image too large for the bootROM to load.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   common/spl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index f34b96efc02..bc233fa2ed9 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -41,6 +41,7 @@ config SPL_SIZE_LIMIT
>   	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>   	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> +	default 0xb000 if ARCH_MESON && MESON_GX
>   	default 0x0
>   	help
>   	  Specifies the maximum length of the U-Boot SPL image.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
