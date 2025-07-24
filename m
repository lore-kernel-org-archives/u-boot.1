Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234FEC87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5712C8365C;
	Thu, 24 Jul 2025 10:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qBLUR1h7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1380B83675; Thu, 24 Jul 2025 10:30:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C41483616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45555e3317aso3267215e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753345807; x=1753950607; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gzKrSLaq1ZTyVT4LnrRBse8XQg0JW5ygybJqV/kfD6Q=;
 b=qBLUR1h7jblR65m/DiqZNuIsdb3QIvf2EkrSvhoHPuir7f5uyN0D5+2TKTB5NkMorN
 pJbm3FcaffLPW4YxSGEm34+ypAr9z0F35B3ZcrPNn2AAdcJ2Ve/5W4MrTWULO8m+esnk
 awNddoCpAgZnYw/k6vCPpPN+ENb0U+UlYHC6aYY/4jXUTKD5mXaA9uQo7HFfXLauX71H
 FTlIpnB440ZR0oTZgCd4X5PdZ8LCDPegrpjG0SeaSGHfmQ4RGtMQkfajr0DChcKLPJVi
 GBLfmXuafDZI4F2rhQ4pxiIli6QPMZeLLnB3Wr2/tCERwlqJML1FeLSHrp/Q6fOFmF2R
 l5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753345807; x=1753950607;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gzKrSLaq1ZTyVT4LnrRBse8XQg0JW5ygybJqV/kfD6Q=;
 b=TUXilsmC4W9MK7YooUYMIOUksAWWFUh47kw3ZFkywdQ0e0AvQ7dQzGMzz7ECCx80Od
 wPZwTSG/A3DfJCc+eO9DOA8Mpjy8FZfu6HTF9BM/mwpsiuPZE4CoAwCKjR7Nyf8xlIIS
 N5+yHcuHCpBLmtn0zegBx2TvUSDMhcb65mrAKbD+tTRJwi1Hz3wpGV23hY5jp5mM2gc9
 bHRRmHBKfebjHsmocBB+9JUlh2CEtioezqTCecnXql84esEJvCe9mixQjUCEEDBCwQ0O
 EC3A75U/5YD6LBYvIZGTmr0T0GBNCx2dqkNEirepnWnxvTu9IzhwtImHZ/vHG3MBD08p
 RkeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUS6Slei0Gkz8hf0JRDFmzoJ5FOuIfgUUUnl66NelQSObfK6lNErn1qpBiZRd8pp88GRzV9cE=@lists.denx.de
X-Gm-Message-State: AOJu0YxIyoKYb8d+FxSHALuu4qANbr4msZGxZK0BnQFE/thd1o/XR9/F
 M0wHKxMLUURq9FUbuz6gs5zpyOOjCOkkLpYeGZZ7YCidSX7DRtmf8siSN/Iz3ThFiBc=
X-Gm-Gg: ASbGnctvwU3pwiB5jKu76ZtP4P2pRUMeMqIVjUPO268Rv0y0dDGeQvI91cRXPcPmpu9
 aT+2DX0BoPCksnB+eA7VjXoA+KTedrrpzDZw+RQXPmZ9+ucRCv1+jovLz72NOK0EHnJcMEtc8FL
 MeVWfojciO4TcUqdg9xkeDABqA6Gp94gI3AKpPemmf5wjgrh1VXhC0epabrHm2Kkg85/EXgy/ls
 1DS26wZQqHJuGdtrgn62YIbBgYfHUZit1z7jeB4jvVhimvqLpd4sGKGtX/Rv/uWB3xuYrL8N+lM
 DRz7TViUO5HMP+z/nKsziupusQVjitBXoCjPBBcv8UIUFWZTRBfVKERZCkQgKe2LrQ1vARjFO9H
 zduQAJzu8+V0BKUYV9SdZOfyX8LH0QAoH
X-Google-Smtp-Source: AGHT+IEqRSm8F4M5nLtj2/YydnIn92cdGu3S4AJXdauwCewfuZ9IdIZEFnNotTyxDLOfaXOq1fK3lw==
X-Received: by 2002:a05:600c:8211:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-4586f5f5cfemr12318335e9.7.1753345807467; 
 Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcb96sm11522485e9.21.2025.07.24.01.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Message-ID: <64196c27-1df7-4ab9-bf59-b00621362bf0@linaro.org>
Date: Thu, 24 Jul 2025 10:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] clk: meson: Remove unreachable code
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
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
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
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

On 23/07/2025 18:37, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/meson/g12a.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 5d7faaa3eab..a7a42b2edb6 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   			return -EINVAL;
>   	case CLKID_PCIE_PLL:
>   		return meson_pcie_pll_set_rate(clk, rate);
> -
> -		return 0;
>   	case CLKID_VPU:
>   		return meson_clk_set_rate_by_id(clk,
>   				meson_mux_get_parent(clk, CLKID_VPU), rate,
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_meson-3d90bc29f8dc
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
