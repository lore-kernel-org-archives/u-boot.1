Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC1C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 09:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9CD08215B;
	Fri, 31 Jan 2025 10:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jroo3ex+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248158215E; Fri, 31 Jan 2025 10:42:42 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2821180F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 10:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd730so12428555e9.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738316559; x=1738921359; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xEhDxTVtfduYkZ7yAyLzRBilltpSEon4C60KaQ42yEY=;
 b=jroo3ex+nT0y0Ibe0FPKeTbKv4GbB3iINQa30w0Jn07qEuzs9fd1Z8RWPbc602b5Er
 H2ouwo46t/Wx4tBeAdyfYveU99OIc8IC774dDqFL/+M0ZNblzEhiWe50LXj/v+tFyAOc
 brdl/wNjL3BbMDsUZdahp9wTv74KTZmOJFC3/xHvOsMGueG29jQFXYHEWGNZHvmsbcQP
 QQKbbOsF3xMFa175g+ExN2g3lylT2yynpFTi4BL1Z/sNKuSO+eCWOgG3IKXlNcgtpg0y
 fhZ7THuj0UnSAReU4w1lufzPp1bjGBaueIQ+OVSP5+UoaGn1aAxoomF39vlFbGj64ioI
 12VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738316559; x=1738921359;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xEhDxTVtfduYkZ7yAyLzRBilltpSEon4C60KaQ42yEY=;
 b=El96kTBdBTPDSAYEcqGElXx790hAUFQ4YJSh467lz1Et6FBYNQD1yPHDF1hQ1poMBD
 a/mNaDyrqSfkuvBCBzgXmJ76CdZ1TAV7O8bSUxFEMFoymR7NUox7IzpU68RS5xExdKmm
 OtiOyQLXvjgS5j2krCPkrzGtxD8q6a7szDsuFtgj3G97SxyO1K6QipzqI1rbc4EXRp23
 BOGG0kHpOviDY634imfL4UaeYeozCpuE2DPvytdBXj7xfFUvOyjqb7Ca2slHhIWkqZpx
 KD+ckXgnU8T53wUzhqdgf6NAUyusf58v+NFIfKTObIOZt5GcFeq28VkC9J+Y2T7IQeat
 nc9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmpW2rdISSb77uMbSNEicT5Ngi85sobN7HU1jbFZq52RwDpPY/rG9M9QXOjCXCIiA6taNvR5o=@lists.denx.de
X-Gm-Message-State: AOJu0YwKu8zDZgDHQkHu5ly8sF/3oRTrytk+KI20jBYTZ+7E56zP3M8I
 F93SUYOL0MFAzW3l6OVGsIhApm6aJkWuqP/P7G2F6rS7fXp2arxmPIvmswfoW3U=
X-Gm-Gg: ASbGncuCaRkXFv8wEbhCrc43tbu3Q3pOL7THl3KOs54f18QQ3ZlxKmwNEPQBYL3bes9
 Z2V3HmSdKF5E02S7Gi0Pzk9iJk77JsTonV141q/9ca9bbK4hFN/8gcu40kNT/0SeB1U70RnZ5m5
 EhhUmf5ZaBXQ26TrXDvX3IuSL+Z/sQwLBR7K0c/hHttE4sFfzX2J4Y46utk8A8KKe4Zsn/CS0aC
 xvIR0Xhdqj4pe3ZC460oWWt9OdONZhRiZ3GCxqrydpbWEhlhwVT05FtLuypdqUyfpQ++wWifNKm
 L5g1l+N1kPOY6dVMjZaOm8ZeIJxrlaSoGxQ2AaCVlp20v7IRS6DMI2doiXUl2k/vjPgm
X-Google-Smtp-Source: AGHT+IFGy/WiAJlbBgnXkZlFlT8LosbCwj9QxWmmELkNxZLop4TUDprepujSmCjPiFLlxdFd+tOL1w==
X-Received: by 2002:a05:600c:4e52:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-438dc3fc2b0mr91235635e9.23.1738316559621; 
 Fri, 31 Jan 2025 01:42:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:384d:e7be:1f71:9414?
 ([2a01:e0a:982:cbb0:384d:e7be:1f71:9414])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6181sm49017845e9.18.2025.01.31.01.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:42:39 -0800 (PST)
Message-ID: <c1bb5132-cac8-4d7a-9f3a-2d5b30ce646c@linaro.org>
Date: Fri, 31 Jan 2025 10:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] clk/qcom: apq8016: add PRNG_AHB_CLK
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-1-00f5d2284314@samcday.com>
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
In-Reply-To: <20250127-msm-rng-fixes-v1-1-00f5d2284314@samcday.com>
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

On 27/01/2025 08:48, Sam Day wrote:
> This clock needs to be enabled for the msm-rng driver to work on
> MSM8916, otherwise accessing the PRNG register block causes a data
> abort.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/clk/qcom/clock-apq8016.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index b5def55dbc2ac671130624dec56592288a0ceb3d..ff5e7ca6f02148427240b80fb08efdd356934cd5 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -54,8 +54,9 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>   };
>   
>   static const struct gate_clk apq8016_clks[] = {
> -	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
> -	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, 0x00000001),
> +	GATE_CLK(GCC_PRNG_AHB_CLK,	0x45004, BIT(8)),
> +	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
> +	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0)),
>   };
>   
>   /* SDHCI */
> 

This should be 2 patches, but it's still fine for me...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
