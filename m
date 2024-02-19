Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6000DC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA2C87D25;
	Mon, 19 Feb 2024 10:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i2UCH1VA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC4C87CED; Mon, 19 Feb 2024 10:46:54 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C3187DA2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41266ef4bc3so3907295e9.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708335999; x=1708940799; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CG3kEgZLIf65Rho0ck4oqI31AvxiDGPA+aZ6EQqIpAk=;
 b=i2UCH1VAjp7+2EH0IAdyItkb1Az+O+l1GpvHIp4CbNzD7+jMuBEcDxitNnp4Cp0qaT
 NxmqXhDJZuQj6ZWKJFAM1WGoLflggwKuhz7wEfNq3YzlFfmKrXnVHt/NkvcDiJ0eojwy
 UVCegolAnGRlENLHXEcWQeTfCQEniOyYJBtxh7cYYfvCqz38UcBeUDANEy7g5HU/Mc8D
 t0p7JhzzcCX43m1SkXhX1xkn0qtgddlVazoYQYUlOaRMNTC9r7Kghn/6lGz18HZ16GqX
 jemUmkBTbGtTif5YhPJpWUs1dE8re40Lf5SHwXnWY/KmlP+TU/8x/tCPQPUcnqjj5jyP
 pEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708335999; x=1708940799;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CG3kEgZLIf65Rho0ck4oqI31AvxiDGPA+aZ6EQqIpAk=;
 b=jBWFISfi4VmaqwUtHgh/JYGJARG/Ol1g9wgtG91u2UMGUhEw9WMHSXpGwLq4PiamaZ
 ElEXa4F7S9St1GKFTWZcJnAH7r5ogfeMLSTRikcaNXXmdT16HtZDrhRGnRV/JTSaiXh4
 TDfWk5hYKGUAyzX5QMRcgQga8MWbbXH+DxAw3HC4v4EpRynczNcK0smFRLj/c9yxGZWx
 JZ3swYmImgb1KppeWcT1BGeqBl+ZketRLK+VwtrI99W2yZfJECku06FBxlB+c5+iBxwE
 9g2kcb8J/rD18r5BjZbSv+IxHXFtGn9evLk1hJaTKz8zuBzGAnH2r50zE8yYJipeDUNK
 ijBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs/Xeqip3RELL3sjULrdBfWNdHTaPeKxsUPkSyj1at4yNvdtbntdMwyvjmeRxhvN6eqZzHfVRyagMvZTEF9YzWkMVyWg==
X-Gm-Message-State: AOJu0YxnbCQBX/FnwurgcueEDYXQdpXx/o601+HLbwya9jE2vBfWGjve
 zOdvz+Q/c7siQk8sUMQK+flMQ2+dKTqH8O5QqO80rrCWekn6KOwEPlZkxOufRrM=
X-Google-Smtp-Source: AGHT+IHkfLzzyM+iJHDT5mxVbXKejOJ0i3ZN3YpACpyOpfTtAul8utoLuiHyKLkO6VCr9UnHPHVIMQ==
X-Received: by 2002:a05:600c:4446:b0:412:6807:93ab with SMTP id
 v6-20020a05600c444600b00412680793abmr794552wmn.5.1708335999204; 
 Mon, 19 Feb 2024 01:46:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:46:38 -0800 (PST)
Message-ID: <056f528d-2c05-4eff-a353-c9524a47fffc@linaro.org>
Date: Mon, 19 Feb 2024 10:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 06/39] clock/qcom: qcs404: fix clk_set_rate
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-6-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-6-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> We should be returning the rate that we set the clock to, drivers like
> MMC rely on this. So fix it.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-qcs404.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index f5b352803927..958312b88842 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -193,24 +193,18 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>   
>   	switch (clk->id) {
>   	case GCC_BLSP1_UART2_APPS_CLK:
> -		/* UART: 115200 */
> +		/* UART: 1843200Hz for a fixed 115200 baudrate (19200000 * (12/125)) */
>   		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
>   				     CFG_CLK_SRC_CXO, 16);
>   		clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
> -		break;
> -	case GCC_BLSP1_AHB_CLK:
> -		clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
> -		break;
> +		return 1843200;
>   	case GCC_SDCC1_APPS_CLK:
>   		/* SDCC1: 200MHz */
>   		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
>   				     CFG_CLK_SRC_GPLL0, 8);
>   		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>   		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
> -		break;
> -	case GCC_SDCC1_AHB_CLK:
> -		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
> -		break;
> +		return rate;
>   	case GCC_ETH_RGMII_CLK:
>   		if (rate == 250000000)
>   			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
> @@ -224,11 +218,15 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>   		else if (rate == 5000000)
>   			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
>   					     CFG_CLK_SRC_GPLL1, 8);
> -		break;
> -	default:
> -		return 0;
> +		return rate;
>   	}
>   
> +	/* There is a bug only seeming to affect this board where the MMC driver somehow calls
> +	 * clk_set_rate() on a clock with id 0 which is associated with the qcom_clk device.
> +	 * The only clock with ID 0 is the xo_board clock which should not be associated with
> +	 * this device...
> +	 */
> +	log_debug("Unknown clock id %ld\n", clk->id);
>   	return 0;
>   }
>   
> @@ -305,6 +303,9 @@ static int qcs404_clk_enable(struct clk *clk)
>   		clk_rcg_set_rate(priv->base, &blsp1_qup4_i2c_apps_regs, 0,
>   				 CFG_CLK_SRC_CXO);
>   		break;
> +	case GCC_SDCC1_AHB_CLK:
> +		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
> +		break;
>   	default:
>   		return 0;
>   	}
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
