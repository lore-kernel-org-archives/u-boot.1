Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773F1C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D8234081C;
	Thu, 27 Aug 2026 15:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJxUjSpno7fH; Thu, 27 Aug 2026 15:40:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845209;
	bh=V3eppP1bAeYI3er5PDG2w5xyWhTejhPpjnaoonlP92w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Qpn3fYRA8YU/cJLlHJE90pHNd6dAg6OhPSfyqTCVVztlLVnRL0hVmbBL9xRSv/kvC
	 5n9QilxrUiC2xQbDdU28gjnzDyQ/TgMbJz7tOTqSQIjT90xlNNuZJY/P7FmLzgRJaY
	 azLpjdKyg1sxrB6dovhxyiVRbAqyhO39rp/lPTY6ZtEDHaG/tCsWgSW5g4HsNCWXCV
	 ALeIFCKVn0cm6i5k4/vzkbU5huVMwUqmSDDgy3XeYvIWjPPHQ8BAZ0UuKj+ZysD2Pz
	 AZBP7C3bpxU531w4gyGKJkp3HX0/zogq+fKRB/+oOx4RJVh8q26TlG0PY7Obgvboqc
	 4jwv7KMb7nLtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5481407C5;
	Thu, 27 Aug 2026 15:40:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E92A53A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAE28607DD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vw2X7cA_L-ht for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:40:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=uF92Vham
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99D14607DB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:05 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso1085897f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845204; x=1788450004;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V3eppP1bAeYI3er5PDG2w5xyWhTejhPpjnaoonlP92w=;
 b=uF92Vham6w/h0HYsdqI/zdKU1DKaRjrJZHO5eNNDp3MqVI6iSrwcLav3VXfco6A/zy
 HscbrpEnmuVDp9JO4DIlnus4OfKKIbM5fg4m4Po8VEb1U3ufujDzDc3pB7JXaoFDxWzX
 sfroaUPrhhImu/WOudAnTfU6DpmBQWKMUsiAqJ+/0m9GloHD3RY7z8wseAX41oFOM0eT
 x/ysRN9S/UhyBkvWkHLrPEsfEut4HbGMW4YP/l/qqvWnrSkw4Dj41f6g+t4/fdB9zf+s
 s75DERBrk4KU6CtJ5DfLtiLS8eBhRik7flcAW6WOxDZb9zuViW5z/vLiDrN0cHByo22t
 zQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845204; x=1788450004;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V3eppP1bAeYI3er5PDG2w5xyWhTejhPpjnaoonlP92w=;
 b=iamcqKWej6GMN2HActXLtlGNIqMbTqSXJl2+BVok9F1AJE6grDvOdCDqLzQGhyAOYY
 JlxmkQB0m+RV1uZ3vh/+6D/n8ZkydSQvXycjLL9Mn4lF/VMGWuZJswiFBxNEdINmSvtJ
 e4QyPcrBIS6HZ/KHulUglVMROZuJ0iD7uIDLkw5I2/1ZEOermzyZvlbjM4KLg/E8TZRu
 djsM7VrJxE3iRolsicLy4hDzuc9hLaaHcWtSspAEVQ8OOxxFouhaNHHvBEPGeJ8Uma5N
 ZyYPzj39ex9myNP2uiTsd3bZOHW41ydsjWQOurAHRPbpDLM+wze0I+IUMFtI/6OM84X+
 6mtg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop+tdKyer0UGGivxysrMi1MOGhAHwauQEF0rXrLQ9CT1+ZyHiX1/E5eaRgqQciITFzpu15Twc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lFyeJu6/Fz14VuuUhyHTZVrlc5GEBiLGNid8wRvU2x4DM0sJPl
 Na0Qf8H1tdFyZklEsGfEQ/lqwcMQlQupBnlgpqdaIhrid28XubshSsJlqPvqi5cHYag=
X-Gm-Gg: AR+sD13eUs1X6Kwqe9zzYS07jdEytKOGXlNo3QDZEVppe1SHzkZJctBOadUvAK/AdB2
 sNdowtMd3YNvSYCCJzATuJSm9en1NYZOcUyQ3nHuO+eLqVwKnzvEDV0RUi3Kl4rNB4Bun3lPM+H
 kUU18nxjVhY16bGJw8Qf8uBvx4lfQvTz3CurPytYRzMzvYIhY1wyT0DH3oWpXfakJrueKNYwLuS
 RBUEMOiqsQexbX+uzHA+reTovApBXMrpCWw7xuLgHw65LjfHsFPmWYuIqKPtSNCHNf1zPZ7jWWK
 6sQ7GPl79pB2T0P+4qKiWuQg7VmUSyR+9hKBoexTLLwX1OvqBTZBCP8CP8ttiNX5k3K8NZsmjuZ
 RCkDTpwBI/r0gz1MGJ7CsaqjR/Ga2vd9oIyiSwyMLTaChoc+r+rzWACysfHxFIpXatsfbvycrrs
 qzvEm6JSvfi/FF4tGUdhJ8O4u376PGgsDrPbt/AYrTNQe8FKgb5j1B9eeXkhw9uDvgORKL59rFO
 kOV6MFkvMvKxxmlWbJpMASBr147XajZ9W251vrDBHDGPw==
X-Received: by 2002:a5d:64e9:0:b0:482:ea47:4484 with SMTP id
 ffacd0b85a97d-482ea4744b7mr14726624f8f.8.1787845203799; 
 Thu, 27 Aug 2026 08:40:03 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dbe1dsm10542093f8f.22.2026.08.27.08.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:40:03 -0700 (PDT)
Message-ID: <0b21b9f3-bffd-4051-8c88-49dce2c8a86e@linaro.org>
Date: Thu, 27 Aug 2026 17:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 7/9] clk: meson: Support power-of-two dividers
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-8-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-8-sanderson@brivo.com>
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
> Several s4 clocks use power-of-two dividers. Add support for them.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/clk_meson.c | 49 ++++++++++++++++++++++++++---------
>   drivers/clk/meson/clk_meson.h | 44 +++++++++++++++----------------
>   2 files changed, 59 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
> index 29615fdae77..50c72276457 100644
> --- a/drivers/clk/meson/clk_meson.c
> +++ b/drivers/clk/meson/clk_meson.c
> @@ -55,26 +55,49 @@ int meson_clk_disable(struct clk *clk)
>   	return meson_set_gate(clk, false);
>   }
>   
> +static ulong meson_div_get_rate_common(struct clk *clk,
> +				       enum meson_clk_type type, u16 *n,
> +				       ulong *rate)
> +{
> +	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	const struct meson_clk_info *info;
> +	struct clk parent;
> +
> +	info = meson_clk_get_info(clk, type);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*n = GET_PARM_VALUE(priv, info->parm);
> +
> +	parent.dev = clk->dev;
> +	parent.id = info->parents[0];
> +	*rate = meson_clk_get_rate(&parent);
> +	return 0;
> +}
> +
>   static ulong meson_div_get_rate(struct clk *clk)
>   {
> -	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	ulong rate, err;
>   	u16 n;
> -	ulong rate;
> -	const struct meson_clk_info *info;
> -	struct clk parent;
>   
> -	info = meson_clk_get_info(clk, MESON_CLK_DIV);
> -	if (IS_ERR(info))
> -		return PTR_ERR(info);
> +	err = meson_div_get_rate_common(clk, MESON_CLK_DIV, &n, &rate);
> +	if (err)
> +		return err;
>   
>   	/* Actual divider value is (field value + 1), hence the increment */
> -	n = GET_PARM_VALUE(priv, info->parm) + 1;
> +	return rate / (n + 1);
> +}
>   
> -	parent.dev = clk->dev;
> -	parent.id = info->parents[0];
> -	rate = meson_clk_get_rate(&parent);
> +static ulong meson_div2_get_rate(struct clk *clk)
> +{
> +	ulong rate, err;
> +	u16 n;
>   
> -	return rate / n;
> +	err = meson_div_get_rate_common(clk, MESON_CLK_DIV2, &n, &rate);
> +	if (err)
> +		return err;
> +
> +	return rate >> n;
>   }
>   
>   int meson_clk_get_parent(struct clk *clk)
> @@ -150,6 +173,8 @@ ulong meson_clk_get_rate(struct clk *clk)
>   		return meson_clk_get_rate(&parent);
>   	case MESON_CLK_DIV:
>   		return meson_div_get_rate(clk);
> +	case MESON_CLK_DIV2:
> +		return meson_div2_get_rate(clk);
>   	case MESON_CLK_FIXED_DIV:
>   		parent.dev = clk->dev;
>   		parent.id = meson_clk_get_parent(clk);
> diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
> index 86b272985ab..46ee5519410 100644
> --- a/drivers/clk/meson/clk_meson.h
> +++ b/drivers/clk/meson/clk_meson.h
> @@ -61,6 +61,7 @@ struct meson_clk {
>    * @MESON_CLK_GATE: This clock is a gate
>    * @MESON_CLK_MUX: This clock is a multiplexer
>    * @MESON_CLK_DIV: This clock is a configurable divider
> + * @MESON_CLK_DIV2: This clock is a configurable power-of-two divider
>    * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
>    * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
>    * @MESON_CLK_PLL: This is a PLL
> @@ -70,6 +71,7 @@ enum meson_clk_type {
>   	MESON_CLK_GATE,
>   	MESON_CLK_MUX,
>   	MESON_CLK_DIV,
> +	MESON_CLK_DIV2,
>   	MESON_CLK_FIXED_DIV,
>   	MESON_CLK_EXTERNAL,
>   	MESON_CLK_PLL,
> @@ -122,18 +124,25 @@ struct meson_clk_data {
>   		.type = MESON_CLK_MUX,					\
>   	})
>   
> +#define _CLK_REG(_type, _name, _reg, _shift, _width, _parent)		\
> +	(&(struct meson_clk_info){					\
> +		.parents = (const unsigned int[]) { (_parent) },	\
> +		.parm = &(struct parm) {				\
> +			.reg_off = (_reg),				\
> +			.shift = (_shift),				\
> +			.width = (_width),				\
> +		},							\
> +		.name = (_name),					\
> +		.type = _type,						\
> +	})
> +
>   /* A divider with an integral divisor */
> -#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
> -	(&(struct meson_clk_info){					\
> -		.parents = (const unsigned int[]) { (_parent) },	\
> -		.parm = &(struct parm) {				\
> -			.reg_off = (_reg),				\
> -			.shift = (_shift),				\
> -			.width = (_width),				\
> -		},							\
> -		.name = (_name),					\
> -		.type = MESON_CLK_DIV,					\
> -	})
> +#define CLK_DIV(name, reg, shift, width, parent)			\
> +	_CLK_REG(MESON_CLK_DIV, name, reg, shift, width, parent)
> +
> +/* A divider with a power-of-two divisor */
> +#define CLK_DIV2(name, reg, shift, width, parent)			\
> +	_CLK_REG(MESON_CLK_DIV2, name, reg, shift, width, parent)
>   
>   /* A fixed divider */
>   #define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
> @@ -156,17 +165,8 @@ struct meson_clk_data {
>   	})
>   
>   /* A clock gate */
> -#define CLK_GATE(_name, _reg, _shift, _parent)				\
> -	(&(struct meson_clk_info){					\
> -		.parents = (const unsigned int[]) { (_parent) },	\
> -		.parm = &(struct parm) {				\
> -			.reg_off = (_reg),				\
> -			.shift = (_shift),				\
> -			.width = 1,					\
> -		},							\
> -		.name = (_name),					\
> -		.type = MESON_CLK_GATE,					\
> -	})
> +#define CLK_GATE(name, reg, shift, parent)				\
> +	_CLK_REG(MESON_CLK_GATE, name, reg, shift, 1, parent)
>   
>   /* A PLL clock */
>   #define CLK_PLL(_name, _parent, ...)					\

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
