Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F92C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4409287CDA;
	Fri, 15 Mar 2024 18:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E7uLOlwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB4187F76; Fri, 15 Mar 2024 18:14:45 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34D987CDA
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-414006a0115so8893295e9.3
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710522883; x=1711127683; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ucNdOTZEVL2hNUIgbY7SSIPDpDh3/i8jpguXRdn36Ew=;
 b=E7uLOlwRnehZ6lz8cRq1NyjB7Rz90okfsCyxDCizpFL1mSZn9OXGY7aWGt1Lzlf5WO
 PT+ZPT1MpGNzHsqlRbAZIJDIexdMZeMe8LDwHLyn2abgC6A4Yd7igfvVIhedJtWn2q/L
 6ihMOD71QNvSUHRtrFQQM0KWA739O5Elo7Rzx3LBfgL80qePHVxbClMRbClMFS7R0Boi
 L35gPHG6ROzw0i5AJ0A9kVHfM//N9rMfq7mAQ3cLP4SsLfT+5T/JNkZHCfRlBkDJjuM7
 Mz0iNWTjN5sfWwS+hgU9Gf3UMOam1I8arMfD+ZIEP6r4vR5hGodkmTHYctukVXIKFyBN
 Jmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710522883; x=1711127683;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ucNdOTZEVL2hNUIgbY7SSIPDpDh3/i8jpguXRdn36Ew=;
 b=STEznqS3EZ+MvF6cOtUceWGcVn1aLEvCeCSlLrYp9J6dxzYI6UgqNBDFXmK2JgwOMw
 WlqPpHHeODzb/hwPDWEPPcoZLgZWSigbz7G/LjmFlR3gPHg9fJsTuJ7C+WBZLzM7jO8O
 X46b4nb1bA4Y41Zg8u67I4YPaRhpLRKCbNqIu8t1JvzHIXPaEdzXjxbU4/Jxz7V8a7Oi
 wAmJJjIqeso0MawRC1wL04uTOGjPg20nt6By5JI0LWdcv54MTXSPh2AcMCHnz59dVzBY
 mDpj/p1I5lenESTgaNM1YUQ9uf92mHWsPnFrIUOTODhrYthoJXwK9PnA3azs9ofyN6+b
 2RZw==
X-Gm-Message-State: AOJu0YwtJGhTnkBUahh4hW6uyQpQGXgOByn+/EIHcQr/UK+wdU5rGDTb
 Y1S1p2Lfh4WHidRMZczptgmm/ua0UA6MUbRIPNfh45tHi/nxLuLAejin0lXBBP8=
X-Google-Smtp-Source: AGHT+IEWW4HPFDtSJRNX2pDVX1lzJo+btdCg6NsHQcSxZt7ZWbj8FvovFypZwsVvO8dDPQpOAmb9pA==
X-Received: by 2002:a05:600c:4586:b0:413:2873:937 with SMTP id
 r6-20020a05600c458600b0041328730937mr3173062wmo.35.1710522882964; 
 Fri, 15 Mar 2024 10:14:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 hg25-20020a05600c539900b00413f08c4d2asm6255315wmb.37.2024.03.15.10.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:14:42 -0700 (PDT)
Message-ID: <8f4271f3-6da4-43e1-a569-8c460ecb7290@linaro.org>
Date: Fri, 15 Mar 2024 18:14:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 06/14] clk/qcom: sdm845: add gdscs
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
 <20240315-b4-qcom-livetree-v2-6-ab635774b2dc@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240315-b4-qcom-livetree-v2-6-ab635774b2dc@linaro.org>
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

On 15/03/2024 16:10, Caleb Connolly wrote:
> Define the GDSC power domains for SDM845.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-sdm845.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index ccb0cf245d33..b7154360894a 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -145,13 +145,31 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>   	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
>   	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
>   };
>   
> +static const struct qcom_power_map sdm845_gdscs[] = {
> +	[PCIE_0_GDSC] = { 0x6b004 },
> +	[PCIE_1_GDSC] = { 0x8d004 },
> +	[UFS_CARD_GDSC] = { 0x75004 },
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +	[USB30_SEC_GDSC] = { 0x10004 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
> +};
> +
>   static struct msm_clk_data sdm845_clk_data = {
>   	.resets = sdm845_gcc_resets,
>   	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
>   	.clks = sdm845_clks,
>   	.num_clks = ARRAY_SIZE(sdm845_clks),
> +	.power_domains = sdm845_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sdm845_gdscs),
>   
>   	.enable = sdm845_clk_enable,
>   	.set_rate = sdm845_clk_set_rate,
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
