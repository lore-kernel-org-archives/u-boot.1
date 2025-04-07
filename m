Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50160C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D473482F85;
	Mon,  7 Apr 2025 20:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fI/gpLBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137F78301E; Mon,  7 Apr 2025 20:08:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094F982F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so27710495e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049328; x=1744654128; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3ZAhaQ3SFpoCDjpzhexDv/HS3wc/JSRSN8hmQ9yXMhs=;
 b=fI/gpLBRDPBtc04ihEHm1EquZkM8GdGq1RVOs5h4UqqUDiW9VnMHYHry2q8Z8RhfQe
 zHA3/BmE0uD36Tm2j8yyyMPDKR6n6gxpltuOV0BZp2/aVC/Sjot/D6n3cAjXmEgA3i+T
 fr0UByFVfi46qhWqWsX6Fy8O2AE224F8Ki4OBvmDTsBeZrTvNNctxSxaRTbJHt6itpYV
 931OEr+BMtaJ+b1lDaQoKF7DbaG+yuw6EMdJCKwgfMnlVE/cJKH3W/jRiA+wzkuD/15/
 l1gzPEYkpV1mpusUVxfE8LvvyncDDDIaZsyoeY0wxmgJA8Wd+kH/OT/DRLzVLipJjh1e
 NzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049328; x=1744654128;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3ZAhaQ3SFpoCDjpzhexDv/HS3wc/JSRSN8hmQ9yXMhs=;
 b=g/zUB9G0ssssPl5womzZusyDqs9pE4Kk91ghQqeI2Qeb8GU9b7g17MDn+WVz0Jntt7
 w22wYYzrbIV5qB75ODSM5nB7LLp0iA9aeZ3I6Xel/qiWQpvedF2S0kNZQffROygz7Pmj
 7/O6+g8IBNbVtRghG3Ha+tYekjElk04Yg0ry5LGd7q8d0xMZ+1AueeRFOaSoqjoZGGrM
 G1mgVuMTmZmaHKFimVvFejuPPb1SIIH2jnaKGO4oymU1vespK8If7oASP4U25CC48hhL
 ud7q8raNlun3XivTWu60Mjkgcig4rG+yuMKsORhGvzZG6jG0catGLd9mrMIYNWI+5+xL
 uGrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh3hVCdiCqlVSUyeGwuIJrgPXySFm3vDIxKCvejgkWkyoqs3D0bKatyqa8nnrgxUNdF00JhEA=@lists.denx.de
X-Gm-Message-State: AOJu0YzlB+n9GxHU4mkvE9maBHrDcrnGiMLp0hV1Ez4Y61PTasH8Ey8S
 1AV6ELSma7wCfFBcm3IBoG3BtFdn9zpJLRwY/FRpJqcYm9bssOYlp4XYaoLV/GM=
X-Gm-Gg: ASbGncvXXLbF86q6YKgzRE78KkXYG8OLKBGiedKZoOa8qSUtbN1jEcT6XA8WXRTRTON
 tj0bgleazCYhlqhR4/RGoL2OEoQcO9Z/cq43uBXt4fmRhcX+OWpcC4fN4vrRXr1ZSZS10QbBGXA
 xHuAQ2XDFZF+qz0WPGsQWQeBmv3n2/5mb5WT5ROconjBqb9roChGxIUn9dadWAyvsnCEkrBgHJm
 QJnvwyBcyUHWTlgotUVKCs0jBOMfReQPPpUKXzQOVEW6Yd68KM3UrHWUg2uvTfY1mqEc3k/B8kn
 F/JV0qlxoQTv/nncF6mco0isMs7aBmkgyoRWEgqofCbS0ekVSE+JHlFBsS8gzDPi4M+oH+5NFrK
 guHAvK3fZrH7U5QLlPSiMlw==
X-Google-Smtp-Source: AGHT+IEtoHpjAVuNOWgVhm4SLjvnFegHKIDcrqI3tksXDPeVivnqPiTZBguJZyHvjZVVzmri0o2EMw==
X-Received: by 2002:a05:600c:5105:b0:43d:1b95:6d0e with SMTP id
 5b1f17b1804b1-43ed0d6b171mr99038195e9.23.1744049328564; 
 Mon, 07 Apr 2025 11:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea97895e1sm158042815e9.1.2025.04.07.11.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:08:48 -0700 (PDT)
Message-ID: <baf2a4b6-939b-4359-a262-4715292a7f6d@linaro.org>
Date: Mon, 7 Apr 2025 20:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/13] board: dragonboard410c: Fix counter frequency
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-8-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-8-524aefbc8bb4@linaro.org>
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
> The actual counter frequency is 19.2 MHz, not 19.0 MHz. This isn't really
> used so far though, since probably no one (except me) ever tried using
> U-Boot in EL3 where we need to program the counter frequency.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   configs/dragonboard410c_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 5870aae83b4fc8d6897eb0f18cc4eb153d299c11..b7f284b4fa2812c60804126362b61164135adeeb 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -1,6 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_SYS_BOARD="dragonboard410c"
> -CONFIG_COUNTER_FREQUENCY=19000000
> +CONFIG_COUNTER_FREQUENCY=19200000
>   CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
>   CONFIG_ARCH_SNAPDRAGON=y
>   CONFIG_TEXT_BASE=0x8f600000
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
