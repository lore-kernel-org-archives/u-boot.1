Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367AECCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C664483B99;
	Tue, 18 Nov 2025 09:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c5IBQE95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB83883C65; Tue, 18 Nov 2025 09:09:55 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA34E83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so3690599f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763453393; x=1764058193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tKv6b69hfBVFzGHUxbo/MXa73pEJcpqNKYwMx8yr3LM=;
 b=c5IBQE95Dp8oa8m20VxNCMPYvHwD42fJrFLlBWIU28bBlqRo7g3jyg2kd+8ySyLF1L
 kZRFEY1EiQ1w57Cc4kztS1lOpz6ziwI1jU0AIHS3kTbuVAqFGAGA5cv+qyvQJsH9K9yu
 nMszWY9GBpeCvpihLsH4K4hGLLCzStZJP1z9TH0ml+lQXwdzkS+ZU/PJRLvS530pRI26
 utloumG/xQKijC3lHWtv5KtXgm6fMcjhWyv/8nIBkhPiw5fLw0WeI3MMyERo1FiG1Ucq
 rlZyY8Xow5FRHkWTbdh50tmnp33Z1BmR8VOFhPpdGewDnz39gVwbeJOXB7ultdFTvwLB
 Wxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763453393; x=1764058193;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKv6b69hfBVFzGHUxbo/MXa73pEJcpqNKYwMx8yr3LM=;
 b=OG7KdlUqLN/re4qBDx7xUgNcyL8bsqjzMqwuOmNS3B8D9LYCZLOYXBfcBENSQL5btd
 eA3949ZIVWoiJtyQI9BN4QXyMih7JnX2bEhfqKaQ8JlzFJ5VKlYN2wZFLPuJtib+C0Hi
 YJjNbCVBPwaFaeXvxj1NoTTShBKd2fXGW7uB8gt4XT30eewt4eFKP3ATTe0SOx/eJS5p
 cV+wOTF7BPulXU24KXK87814dgPbYeCz391zxipoMPqd2YjMcsxhbSWsksIeJMXwuJ+E
 0ubRjt79Zbhd5yDM1JcOvS4n7R3iw1J91PjABIzYXr4KErOAFnVTdUBYXLZVxVFaCBLH
 2r8w==
X-Gm-Message-State: AOJu0YzqqMTOGMQVw5wYRkrIEs7gBDJivZaC0BX632W8BWwDzrmmGgSJ
 PCZzb8znub9jtjGngxUgTxmm2QtLwusanUvVDb3SFQLhEDIm41ydZSBYaYQ0JMw2Mk4=
X-Gm-Gg: ASbGncs4iEeTE9H/6EejvLuJG+ympNsQlCY31IIAnpuLALhw9ovMyzsYck/VZT/RNh8
 XC46XeURrV0/sGJ2elkFI7EZcdUUMepHyRC8w+0l/5vhVfiaidWS8+Xg96nq6N7GTiN3n2ZkNRY
 u4cZc78CEEmBlBs0S80XGBrSUGJV0t0xPMphfqLrSyX0utSak1JsK2oaqLRChnoreUjRTLUn7A8
 xllEhCNGnYB7PB7sc3jTU3+F+FLjabPfWYKcE3yirPpsLu0Jx/aYqVMcOINy8Sby/peDilfMJ5S
 GNc4PGzb9mMyrKHxavUWdVLcwThNdQGCE4hI7aSL+DFydF+n4ctOFy1S4+IcY3gpxg++VXb2ZFb
 A+rggSQf4eJiQYtcbga+h99jRq0kaVU3w/HWN9kgZX24zu9H8W1H7uZGrAR/FXBKyt9b5t7H7xe
 BK/FFo4riOEQT1YW8ugHiX4yMNuz2U4UqnOGwdKuukeCXaapW6TP9E4gXRjV3Ga3U=
X-Google-Smtp-Source: AGHT+IEZ6b8sFgSlFlWKmT9RpDwP4heRmVUai22hIu5qz6IVxyhvY3O5SRFp9DQAdI5LcRCdOcxfig==
X-Received: by 2002:a05:6000:4186:b0:429:d19f:d959 with SMTP id
 ffacd0b85a97d-42b5934d6f1mr13518701f8f.15.1763453393118; 
 Tue, 18 Nov 2025 00:09:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:366e:5264:fffe:1c49?
 ([2a01:e0a:3d9:2080:366e:5264:fffe:1c49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae98sm30228588f8f.2.2025.11.18.00.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:09:52 -0800 (PST)
Message-ID: <f980ac5d-e9a2-4c07-8fc2-75be8fd593fa@linaro.org>
Date: Tue, 18 Nov 2025 09:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: qcom: snps-femto-v2: assert reset in probe
To: Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251114144722.173021-2-casey.connolly@linaro.org>
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
In-Reply-To: <20251114144722.173021-2-casey.connolly@linaro.org>
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

On 11/14/25 15:47, Casey Connolly wrote:
> The power on function for the phy only deasserts the reset, so the phy
> might be in a weird state that we don't clean up properly.
> 
> Assert the reset in probe() so that when we power on we will have the
> phy in a clean state.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> index 04f0f0e7817d..e782de07ebc5 100644
> --- a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> @@ -173,9 +173,9 @@ static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
>   		printf("failed to get resets, ret = %d\n", ret);
>   		return ret;
>   	}
>   
> -	reset_deassert_bulk(&priv->resets);
> +	reset_assert_bulk(&priv->resets);
>   
>   	return 0;
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
