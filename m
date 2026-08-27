Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCAC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A99AD40821;
	Thu, 27 Aug 2026 15:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4yZQqf1Dnk0; Thu, 27 Aug 2026 15:39:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845161;
	bh=7/TDoCOeFu8rQWONGBSXDbZ2SYevidE23LIBWf3k3ts=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sUhCO7lRiCRjT7l1+2O7Y1MAF6shXpW/CS3/+nEG9LwiDFPocnc5I0SYgKN4pK5yQ
	 RWOq9XbJn60vplYtmOGxmfEYcCC5AREDz3MPdrl+Y/GT/WPRrvk2ervtm9Wh7jTXBU
	 9R7jc0LVyWUSY2ZvS14xQ1nLvnqPzcZ84EHbuoSnupKTnqQ+7rzMHj4xDfiYvXxUqe
	 PSNDq2L0vAKge83EQTaZIYpQapL9NaxA+0SnMdYC+DqL6WgpEaM4s6fTUSWWqqZI22
	 wvKHybDUGxslvZyk6U+p07mhfIg0bPVGYA9v2ejhx7QpOViZWwM33ZaRN8kMWgX7dY
	 mRUdL5GFoBvDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D0244080A;
	Thu, 27 Aug 2026 15:39:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 653881DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6322B607DD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9gq4Jv1k9qv for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:39:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H0cMPLzh
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C942607DB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:39:18 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so1536883f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845156; x=1788449956;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/TDoCOeFu8rQWONGBSXDbZ2SYevidE23LIBWf3k3ts=;
 b=H0cMPLzhEPNt+bNqtUSW0ZyesE2XJGglgJA0rCrrpf2QhrLfCGSuR8+foP+CMDCx/p
 TtKqEnBuF59cubv7wTI2nzyUqjV/00bfub5J3g8I5xAQeEHuYv74DEkjwsZTp6feh04K
 yRXnPiLNPG6hxSrTI92P+bFwEFa94ocs4kdrTgKzvbuBm1XOco/CO6aiICBMv0QvDB97
 kVVIphLpPWQgw7PZCsz/aVDomHLO8lHoLmOPUG2mYe09KDyh3EF8jt6sZLKIjijH/VY7
 e3V/XGLAX0X5/6vJA43W92WXAQ8OKlVwPyia6Gt8kctgHmfNW9lV4XCvLU2xxsU3YsFM
 UPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845156; x=1788449956;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/TDoCOeFu8rQWONGBSXDbZ2SYevidE23LIBWf3k3ts=;
 b=WLiI2si2VbjEr5atpB5k9L1xHx676NQ8okXrIgbMXz2qIR1yeN0p8skDyPLPcCBVkB
 rYCXDGaIon37bVlDRnLs+aCVh/NsC/b+2OqWSxx2fJCoYGDS1qfiXu4zipm8GxeCbe1F
 +DT+Ro18OpnCpy+PoA1ZzgEojLpNp2g3vIDhk+O4fToFewjxjt/+JrUhj+4HAzDpk9D/
 VBZMM3Db2PbTUHiloXt7khP9nWo3C7QfHXM1hb8tRT/JjiYrpItuhkli77F/X8/4KJKH
 soVShPyzTUwejWkpFOsbFPZHhEZ37M3ew2f/iWHUcqxWCcm2+YKLEejm9hEyc4NTVMa4
 t/mQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGZ+pIIrGs5Iua3Z09ZcmXy39+fk0JB3UY2K3K5a+7tdkOwQi8wiZlOp61i9JFPi0D5t7DFXw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lUVJhiCl4JLdjfSMNjnE3wa5H+XwnYjBp6MbmHJbxOYwwpWfAu
 ktnKSq3EBNLbD/G89Vp4zSlYsft5N/9L22OgKdSPAJgGgQb2suMVMclzN9jPmSTjbbM=
X-Gm-Gg: AR+sD10IBqWdx/UglFC+xCeJ+ZqiYFUOfuEVUzeXVcFAaHP4DhfxoirV7zvOGuBwNfk
 5f178hVUvorceo42HPkaPaUg0DB34AoFIM6MGEAH0BxcOEHlTyL3Pmo4q7anAL9wL35NrRI+5CQ
 zTYDB+04KnyWNZIsMmzEq5WMnNMZvNk9AKzjWtZCpCMJ3+M3RGJ9zDIZJkb9TTriQeL1HRtlCZi
 +jeqLfKxRz4dzmtTXi8JIVZN7onOk/YDCoO9LbBNnRTrs9DUUO/2tLhBB9CK9QK1eeMCQgMt0FA
 HcYMwVFqJCmgH1RLGpUzYEoJYhn8eYBwoAP92S0/nJzFn9zbUu2U32fAG0hanRMpb6gEnkt6+/V
 C7TVUOGN5sqEu5uOJrMtE0GuVYHmwzs/yEgTnlohoHzUV016pEGFCZ18rKgEE1PG6d+qQSgWyIi
 8r6Bn4hQJQj5an6e37/ne8Vxrrie5L+sPU0dpb76uN71Txe2nVkOdn+cBH3YtiZhssnXnnHvoFn
 KAApf5Dv15gfgOfA9v6snfdQS99+3hmGQEPIFW5Yh5DIjcyAIMM+1VD
X-Received: by 2002:adf:e004:0:20b0:47f:9662:85fe with SMTP id
 ffacd0b85a97d-482e26c3996mr16833784f8f.16.1787845155963; 
 Thu, 27 Aug 2026 08:39:15 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dbe1dsm10542093f8f.22.2026.08.27.08.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:39:15 -0700 (PDT)
Message-ID: <7c0d0fef-08d5-4898-a18d-1880847d1356@linaro.org>
Date: Thu, 27 Aug 2026 17:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/9] clk: meson: Support fractional fixed-factor clocks
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-7-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-7-sanderson@brivo.com>
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
> One of the s4 clocks has a non-integer divisor (2.5). Add support for
> this.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/clk_meson.c |  3 ++-
>   drivers/clk/meson/clk_meson.h | 12 +++++++++---
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
> index de5aa5ae3c9..29615fdae77 100644
> --- a/drivers/clk/meson/clk_meson.c
> +++ b/drivers/clk/meson/clk_meson.c
> @@ -153,7 +153,8 @@ ulong meson_clk_get_rate(struct clk *clk)
>   	case MESON_CLK_FIXED_DIV:
>   		parent.dev = clk->dev;
>   		parent.id = meson_clk_get_parent(clk);
> -		return meson_clk_get_rate(&parent) / info->div;
> +		return mult_frac(meson_clk_get_rate(&parent), info->mult,
> +				 info->div);
>   	case MESON_CLK_EXTERNAL: {
>   		int ret;
>   		struct clk external_clk;
> diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
> index 990e9434126..86b272985ab 100644
> --- a/drivers/clk/meson/clk_meson.h
> +++ b/drivers/clk/meson/clk_meson.h
> @@ -61,7 +61,7 @@ struct meson_clk {
>    * @MESON_CLK_GATE: This clock is a gate
>    * @MESON_CLK_MUX: This clock is a multiplexer
>    * @MESON_CLK_DIV: This clock is a configurable divider
> - * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
> + * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
>    * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
>    * @MESON_CLK_PLL: This is a PLL
>    */
> @@ -87,7 +87,10 @@ struct meson_clk_info {
>   	const char *name;
>   	union {
>   		const struct parm *parm;
> -		u8 div;
> +		struct {
> +			u8 mult;
> +			u8 div;
> +		};
>   	};
>   	const unsigned int *parents;
>   	const enum meson_clk_type type;
> @@ -133,13 +136,16 @@ struct meson_clk_data {
>   	})
>   
>   /* A fixed divider */
> -#define CLK_DIV_FIXED(_name, _div, _parent)				\
> +#define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
>   	(&(struct meson_clk_info){					\
>   		.parents = (const unsigned int[]) { (_parent) },	\
> +		.mult = (_mult),					\
>   		.div = (_div),						\
>   		.name = (_name),					\
>   		.type = MESON_CLK_FIXED_DIV,				\
>   	})
> +#define CLK_DIV_FIXED(name, div, parent)				\
> +	CLK_DIV_FIXED_FULL(name, 1, div, parent)
>   
>   /* An external clock */
>   #define CLK_EXTERNAL(_name)						\

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
