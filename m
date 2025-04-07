Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D071C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C235982D17;
	Mon,  7 Apr 2025 11:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F3F7IzAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F55082D33; Mon,  7 Apr 2025 11:03:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3826382CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso44607395e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016592; x=1744621392; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=x0GgYyBF49CwBpTgNv0BIaeZKyotOv13IMu7r8BJpbE=;
 b=F3F7IzAZ+hgqTxpDKJSgdArEiJ70vfQAwIMHDim/IWB1n04oLnFo1wPquGd0ceP/nM
 3t4Ef0MkN2krx2crFEUwq7vzFfiBWHJuw7TfahMbkgHeTXYWuM8RrIK8owj8LKw2ooVr
 MoLElu5oabUh1e4b6lMhTlozntZEQNPrCLKw5cTUr2dkFz0t3In0I34NmSBFgmWYzEPg
 gEL7kSun7benEqJpHME/wxcia3VjWxeFh4hBPixSTKxc+iTIrxfYktwTz5+D3dUQ6htF
 GzQHWCDhS84jX2mq2W3jDEQ3H3D9YHxDWsKj2XtsIUpU/hArMsemTnkntZ9ymcNxb70S
 NdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016592; x=1744621392;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x0GgYyBF49CwBpTgNv0BIaeZKyotOv13IMu7r8BJpbE=;
 b=Z5EcjgFvHjXJ5m4mNP+nBRNMgFZTDCfxZ+xmwmCmZVDBKJGPyu3Kil94W3zdDLaDpk
 HyaGFgmUbDUGi6mY6fOyrr0mk5vlHgI9RJJzXhwEAfMa33JaeAcCrfg/aYm2K5QlQ7ur
 uH9TSIYry943peesXZn9OiuKItetEcPviKTRi2/Du9CkwIrrtlhOZcI1io+yNs9rFOIy
 f5ksPYpqBsG6EE4KFcAekbpGjqJ2DhOcE6oFNsd1TODT7/f7QKm3mOtVlj8t9dnlXABG
 YK2o1WEjkpKwZ5kAZg2E9/j3AcKlGMtOTLDFVD/otfVPOzB+mlmGwGgxsDivhZfa0H2i
 ygoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFs/t3mHb1D3OuDxrsAJLd/jNwpYQg7pqQRwpCxTF5/G4Up+eiEZMCohB2teDiS/qEnm3n3V0=@lists.denx.de
X-Gm-Message-State: AOJu0YzotyYCPVNumB6qkRHEpa1gAhGbGQlVw4cKMTSQGmGVhomoGMEB
 WYGCj+OnXUEyQxu8u4U6NZm1bfUO1NBCm9OcXxasrcHcfhU9y22151Mswnc4BmU=
X-Gm-Gg: ASbGncsVpHhVi1OxGK2S93XAM2iL3AbbPub8A8t1Tbvp8JWFzscQCvW5JQdSUlkCEE9
 tIL9xdFHTIMnfpSuMw8uF4Qu7x4PieR0+xXTX4hS+T+XCrBTRfHDT03+VmuC2VRFl43ARkKrv8B
 djiCwKL3pKs/BTDmbk1q6JhWGg0phZt6OzfB2srTueGX7dqyrem8QGphM3jPNfRCdGzcdLxrdnf
 tXRNyQsd6BW0Ez4STLk351yeU1m+0+5HCwCnc+LUmpW1RwZ7y/YdtQ3S1Y+yRTHelLFZxntzSLm
 E2tOCDLfddqXOt23EsKEBzQkvulS91nq6PfBfd2LQ+aiM7acgP/Aw9uwL1f2WZXZYOWpuGS2Rwo
 /g/n9dT+n9s2JTnySn0J1kQ==
X-Google-Smtp-Source: AGHT+IEve6amWhylywbvNLbholdVxOqraMtFIWXjx2J4778vklgtluv3j/jxEN2z9iqTPYIdY3mPgA==
X-Received: by 2002:a05:600c:1e13:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43ed0da49e6mr134645325e9.30.1744016591336; 
 Mon, 07 Apr 2025 02:03:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eda4662a0sm84838995e9.36.2025.04.07.02.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:03:11 -0700 (PDT)
Message-ID: <31001b1a-e9c1-45ab-908f-773e5ab8317b@linaro.org>
Date: Mon, 7 Apr 2025 11:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/7] clk/qcom: apq8096: fix the sdhci clock
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-5-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-5-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> Select the right clock for sdhci.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
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
>   		return clk_init_sdc(priv, rate);
>   		break;
>   	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
