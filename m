Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8AEC61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33AF5406E7;
	Thu, 27 Aug 2026 15:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UEYLLfDJRK-u; Thu, 27 Aug 2026 15:38:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845086;
	bh=K5qoEqPvqec5Ad6mEHbkA2yhpsPUw/R11eOmhq+5F+8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Of6rUdfu/KeQ28LIezN9vcRc2VNm3uRxQnalAF77GlpSR/06DWqTd504Tzqmg1LlO
	 HiHMdcIjEAc4mVmMNhFJatzp6/qkamy3okJRaOFMZLqaKQZO4wXTbdkIuliqJpCJmB
	 GZR71PP6ZrMKTJFMTOc7lG1qSRLwQEAjQ/6QFE7etmpHPac4xyoSS81BOEJA7+OV3E
	 CeIkwHXXiXFDu1aNTcYqLwhcZqG7rTva3htAK8AWYcH8CRXve992lvvbvkHA9mK7z6
	 6lLoALdkOf7HkOup4u+yEe86Gu7MWwyXJNRavRT19IrzuXnvu/wXLUGfOWNeb8P1kW
	 cktOnCo1tmG0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DAD2407C5;
	Thu, 27 Aug 2026 15:38:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58A72334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A81A80EA0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O913CP_OaWLa for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:38:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AP+tULTS
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10F8B80E9D
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:38:02 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso19469995e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845080; x=1788449880;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5qoEqPvqec5Ad6mEHbkA2yhpsPUw/R11eOmhq+5F+8=;
 b=AP+tULTSFuKWkdqwhZfvozp940wS2vA4HQn5n0vI4hrZa+lbsOSdJB/BWKwHM7EZbX
 CM25ekrtVN84M5MEdpfwy6TOl/ZpOeC/7doNBrWY8EJ6zqhsqP8l8mfqnnANQtxFEuNM
 2GQyY9zEmko1eLqyxmz8D1YZZL6BYf4Jk4dRwYuS0lYhDrTX939ROFhszzLXEVb0oFHh
 svBz8UuaKYD+L3VKHV1Qvu5XCu7uDnCfm/fhdzgfYM2JK35rjaBz6fz61uMNhHx7kUSw
 ZXDRhYfyfOwIViHy/7Y3KpALnN9irYodanLmfsfmvdlLbKx3Yay7yba74gQmasTW6z/K
 gKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845080; x=1788449880;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5qoEqPvqec5Ad6mEHbkA2yhpsPUw/R11eOmhq+5F+8=;
 b=ZdG+CLGk3N7ebdDBVR6XdnwdbPt1hEglve9T4XUQQi27YgnJmuRE4BqEiHwZ377Dll
 bJuKFQyNsHmRiG68KaPiAQ3zfjdHGoPervEO3gJk232oyrbYD4QxYmEWj6J2gv2106mc
 uNmp2JdmVOG3DPoWZjEfgIAYFzLVSPGH9wgGIqXqw345zwX6Nc8Pd2/+BytEAURsB1Cj
 I5JpG3yQU2vOZBSuixyT/cn5AAd4v/ds/pHUBqQlbCivH8+a8UbPBMe9/Tq50GLUS2Hl
 JcoJo/2QzL6vicy7wNlDfouXVv/RKLbXbw9e1R+L92uXJ8CFZB3MTTKJnuXHhUicDyK3
 VqRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi02HL8R7JXyUHRsn+m3D/K09IMFYnt5lOnY2/hDBc14kDhvsZvSl7hwvaCD9l41/PFlMeEIg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kRiqpPslRqdhBYt3NU9pPUUiL7febqmp2rAvAJL+F0WsNVn3JB
 EmiwZFeqIBCJ89cHM7/yoRnXfAy2k/KampkFxtIJnPGBM61U6r5f5+VJ+AexSqSjMyI=
X-Gm-Gg: AR+sD13RHyDvNpmfeuInlziJpUghmBIglUXhuHAoj/QJXez9PcCxmXPJHCiDQnN32Xj
 SN5kSVfO4RFIkP1/ske/tv/+akbeSiHwjzrDM+l+EOfu7BGnCBDuX2fqSZK/h++FvEcRk2iccRv
 GHCkOGoh+zxa57m+6zWo5eAsyWUzoWipq4rqZ+orVYejYbE8RgL9DuXaRYenAUU4WMcH7K6l7fE
 UOKtI6pNFjmEDibasShABdcj3zDhMIlB+ck/r24otidz34vFbhNHKBecqOEImaOL5F3nBrtxqb/
 zKxbkYMbQAxbH3f+pjJn8SbyhVFcVSg+1xM1VOPvhelmTzoA0Mpt0O1q/adSCH5ZWlyN8hZd5EO
 3Q2Ro1SX4D3DZHnMy1uORbGgJzOxZ3GNZ+QeLV2Y2pRTT4sYg6P6//kW0fL/xnLWzSzRfBJp9CA
 HdcM6JIqZ4vEqH0tvsLemIw2x2p+EEFEXjtcSLGjGL6OWcmG+70jkrPg9oIGntmmL7WKcV4JMq4
 dl92huSOYtgi2CfEdNcVcILWucHlgPJzXiwUX6ZQ4Zhtg==
X-Received: by 2002:a05:600c:c4ab:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-499dc6ef59dmr176721805e9.5.1787845080211; 
 Thu, 27 Aug 2026 08:38:00 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm131134735e9.6.2026.08.27.08.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:37:59 -0700 (PDT)
Message-ID: <7c78ba1a-f191-4e13-b741-24ba3166dcb2@linaro.org>
Date: Thu, 27 Aug 2026 17:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/9] clk: meson: Use soc-specific naming for common
 functions
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-5-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-5-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/17/26 19:15, Sean Anderson wrote:
> In preparation for moving a1 versions of several common functions into a
> shared file, rename all the conflicting functions to have a soc-specific
> component.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/axg-ao.c  |  8 ++++----
>   drivers/clk/meson/axg.c     | 12 ++++++------
>   drivers/clk/meson/g12a-ao.c |  8 ++++----
>   drivers/clk/meson/g12a.c    | 20 ++++++++++----------
>   drivers/clk/meson/gxbb.c    | 20 ++++++++++----------
>   5 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> index 6ccf52127b0..3215391006e 100644
> --- a/drivers/clk/meson/axg-ao.c
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_axg_ao_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_axg_ao_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> +	.disable	= meson_axg_ao_clk_disable,
> +	.enable		= meson_axg_ao_clk_enable,
>   	.request	= meson_clk_request,
>   };
>   
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index c421a622a58..e20d3feaade 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -69,12 +69,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_axg_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_axg_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -279,7 +279,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_axg_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
> @@ -305,9 +305,9 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> +	.disable	= meson_axg_clk_disable,
> +	.enable		= meson_axg_clk_enable,
> +	.get_rate	= meson_axg_clk_get_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 61d489c6e1c..e89638d65b5 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_g12a_ao_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_g12a_ao_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> +	.disable	= meson_g12a_ao_clk_disable,
> +	.enable		= meson_g12a_ao_clk_enable,
>   	.request	= meson_clk_request,
>   };
>   
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index f33938e1419..cc7bfe9e2a2 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -194,12 +194,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_g12a_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_g12a_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, false);
>   }
> @@ -858,7 +858,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_g12a_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
> @@ -888,7 +888,7 @@ static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
>   	return 100000000;
>   }
>   
> -static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
> +static int meson_g12a_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	return meson_mux_set_parent(clk, clk->id, parent->id);
>   }
> @@ -958,7 +958,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   	return -EINVAL;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
> +static ulong meson_g12a_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
>   	int ret;
> @@ -1000,11 +1000,11 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_parent	= meson_clk_set_parent,
> -	.set_rate	= meson_clk_set_rate,
> +	.disable	= meson_g12a_clk_disable,
> +	.enable		= meson_g12a_clk_enable,
> +	.get_rate	= meson_g12a_clk_get_rate,
> +	.set_parent	= meson_g12a_clk_set_parent,
> +	.set_rate	= meson_g12a_clk_set_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index bf46f4d50bc..24b5f9b5d40 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -236,12 +236,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_gxbb_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_gxbb_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, false);
>   }
> @@ -840,12 +840,12 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_gxbb_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
>   
> -static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
> +static int meson_gxbb_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	return meson_mux_set_parent(clk, clk->id, parent->id);
>   }
> @@ -912,7 +912,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   	return -EINVAL;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
> +static ulong meson_gxbb_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
>   	int ret;
> @@ -954,11 +954,11 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_parent	= meson_clk_set_parent,
> -	.set_rate	= meson_clk_set_rate,
> +	.disable	= meson_gxbb_clk_disable,
> +	.enable		= meson_gxbb_clk_enable,
> +	.get_rate	= meson_gxbb_clk_get_rate,
> +	.set_parent	= meson_gxbb_clk_set_parent,
> +	.set_rate	= meson_gxbb_clk_set_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
