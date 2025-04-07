Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F818C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20CB82E58;
	Mon,  7 Apr 2025 14:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yQUlgY3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA9282E7D; Mon,  7 Apr 2025 14:36:54 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40B682E38
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3381414f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744029412; x=1744634212; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bOHLkcCE5qGOuCn7M42Qg4/HMwIFunWZ2Wv17uxUJl8=;
 b=yQUlgY3it6o3OjYN8b841JcnQ0Yx+7n2ADsS+bJmqNj4WiE9srKZcwCjQqghYQshfV
 2TiZUNFbRjPBtxWRRNHfCXxvc06VbXf0u2Cc+a6tU3nOQ2mCpLYBqAdNvGb/E+dOcrUB
 YAYI2Fk24fRbpPBUHKTaunUMAX/7vuBjQKdhGztDkpmwNQBgk2uGlMb6ZJOAiwK43kWo
 wJdg/JXHTxyjUVyhg1DJ9XnrFyRddTXNmwenI33UvmtBzozLDhF7F+A9pendubLnSxSp
 m9szhPqPPQI5ZWQMsg6HBN4wd8Yg4AwgHtwX8tOTAKurzkHUskkeFoeXvzKw0zvCjp8L
 2wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744029412; x=1744634212;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bOHLkcCE5qGOuCn7M42Qg4/HMwIFunWZ2Wv17uxUJl8=;
 b=K2nNDYOLDTuDb11xcBtoEWipimSYRv6uBcr1tOGMAVIKHhikFySSaVEHtw9ie9VkSG
 wJrBnpOErE8aCMYJthPBvWKjbgcaz/WSweo4OldcGhRl79BgfY6kV5Q4ffxfMYLpQQ5l
 1lzzGX/OV22Qd0BR8AmF/5OB5sDJ/qM4mtqnMx40/XmjGwo+G9gWl5s1QfIfHOr+rsK+
 vVX8fLndudVEL80RZh9UULakN+0Cg0GUoR6MFPACNKqUzd/FmCt2YOavFuGFz2wTbT1P
 LHLGe2H3VqFbjftLrv1ocY4c9FGJgu5LTedTt5rz6dG90URb31ayL4kG/yEV1hZziPda
 Yq7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOqM3kNjvXQaKXlaq9Zj8W6uEwINQRp0Axb8dR6SqirpVXFtJqVqplGuVAgAIzZsmDzm6XONw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcct8crs/Wlm6PBN4EcroUIJbf4vSlUjcTnA4FMcmydX0oVkT0
 ybFQyg42QQe5Yfy513h7bi5Gtf2Qe7wLVcqkJysw4sHd7uJJhEMs6zRoFSlvaHo=
X-Gm-Gg: ASbGncsuxgxZ+Q1BMFl/2P7EiwZyH36S8gr7PubyEGW8CVVWlPt0es/IVXvFdUMp2ZI
 XpeGamkLA1iADWv04Y/CnjIG2DGPo6yPg+1l+9ugXAFB+NK7EGqvIEFSvA38ra9eTopbitZ0Lax
 UzxP4b2POeL4Wby1VSf3sgEFhP4yHob1opM9yr9rqvmbuPU7QaDVPOaICZOy4LncqYl2hbhKDxj
 Oix0Pfx9EIS89BII+5H1ROXHfABeBXsMGaaaHPKVHEDxGnzUUgGBhygmCY3KDp1imMGAVXrpyU+
 9fpbFcH0K3sDNAxDQGm/zOYKDdgSHlQVxYKy0zwGe1RPQAe/CZPic2wQUsYusEaJTFYWzihEm/A
 4PJaES1gSg1YHAGYVn7BZgQ==
X-Google-Smtp-Source: AGHT+IHSDhCGLv2d0+yDfYqpco62txpuIEoeMzJ7cAQyCIeQjHJvTTipZ4IwwyRH0yV16Tz6lSy/kg==
X-Received: by 2002:a5d:5846:0:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-39cba943645mr10254926f8f.23.1744029412206; 
 Mon, 07 Apr 2025 05:36:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b42besm11794965f8f.41.2025.04.07.05.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:36:51 -0700 (PDT)
Message-ID: <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org>
Date: Mon, 7 Apr 2025 14:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
> Select the right clock for sdhci.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/clk/qcom/clock-apq8096.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index bc00826a5e8..551f52d5197 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>   
>   	switch (clk->id) {
> -	case GCC_SDCC1_APPS_CLK: /* SDC1 */
> +	case GCC_SDCC2_APPS_CLK: /* SDC2 */

Should be GCC_SDCC2_AHB_CLK

>   		return clk_init_sdc(priv, rate);
>   		break;
>   	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/

