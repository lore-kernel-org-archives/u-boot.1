Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E159C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 16:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663D581E47;
	Wed, 19 Mar 2025 17:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QnBPoeYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B8C81E6C; Wed, 19 Mar 2025 17:20:05 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F91B81E18
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 17:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so33131525e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742401202; x=1743006002; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=IM0dKk0KfhNjxJc5TX9x+uZArNjdWT0ljDsixL3uLHU=;
 b=QnBPoeYQ60SlOsO9OZFhA2zuXG2J8SPpKtHupPS+l7oxUHoSZHxFrB3iqtEWPYR+iE
 d2LukaZyFWiZqlnWNtFcJkvIrEcM5BVAJ6OuJzZpV1/Rk9TgIGifFngQCcR5m30hclVK
 Yo1skXxlmsyGNeJYvBbSXaFO6uMOmBsZYanFq54yQgs3m6EGBcGYUfcL4/t1jKV1kedl
 KUgn3vzJ9jKPu8PPw3GbDrYoFFJCoc0nACn5T1k741KAQ6JLMmJ02Y4h5lTEP636yDYj
 Ub8/Ux+57dw08gMQ+wfaYdi3C5xuLjiVx/xEKduo22UGZOQkDeVstgRAkapHsompVSq0
 zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401202; x=1743006002;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IM0dKk0KfhNjxJc5TX9x+uZArNjdWT0ljDsixL3uLHU=;
 b=TXZBtsV6ZKxVpqk6Bi9j6PyM/PCg2goxPK/YrOZVmpxD61bT56hwhehotszORTUsEC
 U1CMytTEyIf73KFgZWUj9G4olWsO1fiN61N0VBPb8KBE1zKQgNuo9wdxaxezbmJZQoyz
 0yYfpjiZeD0kwAkLJGo6uLyzuR5TbiyOUS6XoE0MxvKO5IuvjlCUIsjD59fwdtAfNOc/
 IzPGQWyurvnPIxTUhsm6mZ2WUfS55E8jT/ycD+1pN710Xh6RdVwtnhwNJFF9su2BduNM
 k27I4rbuxUGgwldKuInYmW+8Dypnclo9zQ1UdtLy2aNrlOfyw+eitpYitGrX5KAGrtPz
 tnBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYmjFg2+zmImjcBuq3UrOszu0Z/evc0Htapkw9mrZ9AeAnZZQ8fbP284tPYFHNwjW5gsBgn1k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6vuGXZQsBvzPRL2OhBQbmxe9sIqMkHEcYwoyi9OH77WM4L7dL
 6h1/bRmsX+VGD2YwOgCubKAtKcvEOOlybd0159UWhq/52ipz1HmEPzWON2Y56SQ=
X-Gm-Gg: ASbGncvwyWRDFu1w2rPV7V6aik2A7ndPzg1cHdgb9n8rdXXhylRO8S/ReULSlO0jMFl
 a+5VUP1HdEn2XeebpCMPRwWuVzZnMGWBjrAXQppyefR7LFkRZAbtlCNu3oX/fsjsW8SdmR0c9pE
 vmfcUUhcnbvbpUqSTimd3M7Gc5jBHc6IuJqDMv8xQjvTOjolO/NThg89lbJXeAH+XWvdVNzzh0O
 gsL7XogwOwutng2EasPQON2M17HHoWUT64PqsIl+L4V9XSfnqtSwW0z/ky4nD2WOUfuUEp/1wsI
 aCu2JfJ64u2mRqhdmB+xVe07wx54eT7zFfVeB+4+k8ugipGno+X0gmKFcjsKhAhb5yHa1b9LvMv
 WppRIrfsW6cHaWmvYIQLXtg==
X-Google-Smtp-Source: AGHT+IHNTX2JH3jGP12LHd1GZvglKj8VSDInEAxB3dLYII7jcqIPlDNOcWvoqjo2tYm3+3gMcqBj0A==
X-Received: by 2002:a05:600c:1d02:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43d437dbd27mr31858045e9.15.1742401202482; 
 Wed, 19 Mar 2025 09:20:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f407:ab81:b45a:93e8?
 ([2a01:e0a:3d9:2080:f407:ab81:b45a:93e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f33242sm23216865e9.5.2025.03.19.09.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:20:02 -0700 (PDT)
Message-ID: <44597d3f-9a9e-47a9-8279-7aecc1ef8791@linaro.org>
Date: Wed, 19 Mar 2025 17:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] clk/qcom: sdm845: add missing USB3 clocks
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com>
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
In-Reply-To: <20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com>
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

On 19/03/2025 16:45, Sam Day wrote:
> These are necessary for USB gadget to come up properly, now that
> qcom_gate_clk_en fails on unknown clocks.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/clk/qcom/clock-sdm845.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index adffb0cb2402a6b27e0e998af2f121c519301820..1b85b05632fe1100a6ad60dbd430272d8ae1e77a 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -77,7 +77,9 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>   }
>   
>   static const struct gate_clk sdm845_clks[] = {
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
>   	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x0502c, 0x00000001),
>   	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x05030, 0x00000001),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
> 
> ---
> base-commit: 69fb899133b6c374eff11b13482371bec6898a01
> change-id: 20250319-sdm845-usb-clocks-9b794fd89522
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
