Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F0AF459EF
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7648419C;
	Fri, 10 Apr 2026 18:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="AwC3Vv+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F468419C; Fri, 10 Apr 2026 18:07:15 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A1284198
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 18:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so1435159fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775837231; x=1776442031;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AqBaar+Eukb8rh2EVvltQ3kkz7L/i0+464QLa/xrtrA=;
 b=AwC3Vv+LANLIn1SRamct4RPsKZXdS/DOm/KHgCEtkurtxM9k/X/QMgqSOhWS5icrvr
 Hx2Oj2uxLBVOBhyHc3+ZAGLQ0A5gOFapi6JjRsh+gVcafYesL7aRfUaD2LaULCTVAIjq
 FTtD+4DaAcEvetDV6LsJMaNH9oK10NN4xY07c0t8Wty0SbyvMxZkLRzrvCwCVwQ78sYr
 qbGrZhzm2havHRAzRvXkxXn6QhohJoOiQMfA8ERUuiwqLeR9pKZ7rXPK0+u4JMkaWhWR
 4MnZAK8J3ItOK++A+jlfaRCprC00KOFIrWmowgmbnTWJfjKoR1J1U8ueIWAYLQvZnCdk
 ZZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775837231; x=1776442031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqBaar+Eukb8rh2EVvltQ3kkz7L/i0+464QLa/xrtrA=;
 b=QAaXjmwUfIs1K36pZMOp4ec2hUuS+amtkeDAlblLg69T1X12xYmdtvY0MDTzFO1vBH
 D196jLKiPRDRq7jaXcEsOP3wB0PkbwTUxiYpY7jysV2LAdFMGfnqBRfDaEDHkwblj0/d
 7CDcReMoMNSHAW81U7ohXVJMp45OLcbyXDlPppVqe+kI0lW9aAx0d2/VOHFeUhYCikM4
 Fy7M4hPQibNisIc5bdTDkGxjzREsmv+Nz0AtjayURb/SiHtQ0Zj5cSrfNRcyFmg0m5Zu
 vROObP26wdALP6tWnyOIy8j6RdggBoZ94BPAFXcI7MvpPlCsFuh+6KeHHjkvNmwTCPmg
 ofPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgd7ZJAufdXTsB1cIOHWQoFFTJ5G+5kaEsBQieWOVRe4rAxli1XaTSaNFo3/GbafM6/09/zvA=@lists.denx.de
X-Gm-Message-State: AOJu0YySC+wSSCgvwQo1dBTDcWeQi0834H12IDNcgLaBtW//UjJZNFdH
 Qo8P1jX8xAqq+wWoGcAVUqtgd72dlGi1D8W1Ao4r7elrak0J9v1krQ3agv4BS6P6q40=
X-Gm-Gg: AeBDievqiMg//VRtSJOzPBoA5Yfhx2OybfJSVLybkRNYu+Jcmo00V+s+B/xMChaDb7p
 04qTZn/lpN7pZrzMhmbHNBDROoITfYpw4Bz9h79pN8K9+S2lmEB3uLWSdqLaC4dah/zp015IIxV
 Ho/q6T2Y2AT29j1qgPN6Lskoga0B06ljGek2jMB3hfxMXjGQi1utzVs7GMgsVlPiuNXuDQ8jjr9
 JAT7yLG46TYhOFBbVvGgugERHSw1JUNdFBdNfwCIKRz3EyO4XTk2oWP/31sAIRqIgNpiD+MFF2c
 g00UHqYFZgE9vU8peV8LlB6q98iIjqz9yWUQbZPUcV/XB9Mwvcxnk+CWBsVzY3rhoqiGcvj2utF
 zbBrCKRY/1UCLJAThcBE12QbABa3uZ7+amLOwwRMhYB62pYsUq8ZqmSSeuwSqK6cN4ctlwe4kTC
 eLUH0Lb+4Ce8NJ8dRdJ35aEiJdDDLk7x0NuFGlXETjodwWQTxUmi08w+8fDI8FgkeNmM1Ep72Pu
 Q==
X-Received: by 2002:a05:6870:2e84:b0:409:b5a3:42bb with SMTP id
 586e51a60fabf-423e115f92fmr1973974fac.31.1775837230824; 
 Fri, 10 Apr 2026 09:07:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b?
 ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddb9c504sm2558014fac.15.2026.04.10.09.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 09:07:10 -0700 (PDT)
Message-ID: <abe54929-2f66-4a3d-b08c-65a03cc32fd3@baylibre.com>
Date: Fri, 10 Apr 2026 11:07:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: mediatek: fix parent rate lookup for fixed PLL
 clocks
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
References: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
 <91c2295c6677a94ea34089a52a93487d8ff7caca.1775786729.git.weijie.gao@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <91c2295c6677a94ea34089a52a93487d8ff7caca.1775786729.git.weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/9/26 9:13 PM, Weijie Gao wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> The refactoring in commit 00d0ff7f81bf ("clk: mediatek: refactor parent
> rate lookup functions") introduced a regression where fixed PLL clocks
> using mtk_clk_fixed_pll_ops are not properly recognized as valid parents
> in the CLK_PARENT_APMIXED case.
> 
> Fixed PLL clocks are implemented using mtk_clk_fixed_pll_ops instead of
> mtk_clk_apmixedsys_ops, but they can also serve as parent clocks in the
> APMIXED domain. The parent lookup function needs to check for both
> driver ops to properly resolve the parent clock device.
> 
> Add mtk_clk_fixed_pll_ops checks alongside mtk_clk_apmixedsys_ops checks
> in mtk_find_parent_rate() to restore support for fixed PLL parent clocks.
> 


> Also refactor the grandparent lookup code to extract the repeated
> dev_get_parent(priv->parent) call into a local variable to keep lines
> under 100 characters and pass checkpatch validation.

This sounds like an unrelated change. Let's split that out into a
separate patch.

> 
> Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup functions")
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 4adec4457b4..26db60dea7f 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -207,20 +207,26 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
>  static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
>  				  const int parent, u16 flags)
>  {
> +	struct udevice *grandparent_dev;

Putting this here is fine, but we could also declare it inside the
else scope instead since it is only used there.

>  	struct udevice *parent_dev;
>  
>  	switch (flags & CLK_PARENT_MASK) {
>  	case CLK_PARENT_APMIXED:
>  		/* APMIXEDSYS can be parent or grandparent. */
> -		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops)
> +		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops ||
> +		    dev_get_driver_ops(clk->dev) == &mtk_clk_fixed_pll_ops) {
>  			parent_dev = clk->dev;
> -		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops)
> +		} else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops ||
> +			dev_get_driver_ops(priv->parent) == &mtk_clk_fixed_pll_ops) {
>  			parent_dev = priv->parent;
> -		else if (dev_get_driver_ops(dev_get_parent(priv->parent)) == &mtk_clk_apmixedsys_ops)
> -			parent_dev = dev_get_parent(priv->parent);
> -		else
> -			return -EINVAL;
> -
> +		} else {
> +			grandparent_dev = dev_get_parent(priv->parent);
> +			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops ||
> +			    dev_get_driver_ops(grandparent_dev) == &mtk_clk_fixed_pll_ops)
> +				parent_dev = grandparent_dev;
> +			else
> +				return -EINVAL;
> +		}
>  		break;
>  	case CLK_PARENT_TOPCKGEN:
>  		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)

