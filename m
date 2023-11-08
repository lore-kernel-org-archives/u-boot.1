Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F528C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 18:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70BD787254;
	Wed,  8 Nov 2023 19:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VllJjlan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23968714D; Wed,  8 Nov 2023 19:07:31 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C4787078
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 19:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cc56255e3so20191cf.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699466848; x=1700071648; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kcrz3yVM3JvOxBktEust0+qRtREY3PSG+Km2AktLaUE=;
 b=VllJjlanY1CHtami0afEw1KyGPaubp2YZLMAk5mwApIHttryyvazdolUu5yA9oC2gO
 Bh3fUihW2aMbBbGazQe4ai31IZwSgzjQwCEqoqzUpJlCV0zvkkiBj/cDUpOMzLKlemsr
 AluDU3UNro7VFbF/bSjDY6jMlNWaeqItdficUttpiUcqda1ee8v9P4lHbhNqnh1DfItI
 csDmwKG7uqwF9XgQ4XN/+z8Kk0k8WpxUkX/8az7zbato9V/WRusp4Qv0gfuUFZA1/UhQ
 4LP10QNjD+ROLUsArx9L5Vry1FPPrgplEoNszo3TDT3YDZzjtmWbyna6ifBWn0Rz4lhD
 fIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699466848; x=1700071648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kcrz3yVM3JvOxBktEust0+qRtREY3PSG+Km2AktLaUE=;
 b=MNpmidGJl0GaJfz4yE67G1x6przr+kr3Z167aqM64WA+qXfPNtYEwXFlh7yLjqhgst
 T74VqMpVEmuE4Q3IxxBZjqVNkRwV26R7sMy33L3hIfRr3tNI0C1pxrs3k2+a0uobgLpi
 U+fBSCnY1gmWuhL3A12RkewntgWtHKCWX4EaEEcDKW8O5nVc8kt/LV8URDjGxjfYPDTG
 bin97wdexvDpEtV3PDMStGlrJ5guxyNb4BufWNl8KAwXAmulp+vmKCMYTnPr5IXRuZjq
 osTDBJHZuLzvlrTyGv3wGrienQVZmi1Hzuhg4lVybkg94e13yhRSiSJhnwmOaPQy7kWe
 VAdg==
X-Gm-Message-State: AOJu0Yx5GR8VeDpEja/tXrVVKrS+za3DLUyGClAYzkF6r/FGcptmJeQm
 1ojk/hjdnU1cyxHw0tITS5E=
X-Google-Smtp-Source: AGHT+IFoPeAwpv5hn+WFteO3aJmch3z+VmcCJAIShQ3H+CczPZfP/fUohtU8sL0FcmQeDUARKd5Dtg==
X-Received: by 2002:a05:622a:210:b0:41c:baf5:b500 with SMTP id
 b16-20020a05622a021000b0041cbaf5b500mr3199471qtx.47.1699466848115; 
 Wed, 08 Nov 2023 10:07:28 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 b21-20020a05622a021500b00418189b689csm1139161qtx.10.2023.11.08.10.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 10:07:27 -0800 (PST)
Message-ID: <8b3ac0c1-6f2a-92ec-120a-ae65faae1c0b@gmail.com>
Date: Wed, 8 Nov 2023 13:07:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] clk: nuvoton: add read only feature for clk driver
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, YSCHU@nuvoton.com,
 KWLIU@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231107090128.199267-1-JJLIU0@nuvoton.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231107090128.199267-1-JJLIU0@nuvoton.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/7/23 04:01, Jim Liu wrote:
> Add a flag to set ahb/apb/fiu clock divider as read-only
> It just protects the clock source and can't modify it in uboot.

Thanks for adding this

> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v2:
>     - add commit message
> ---
>   drivers/clk/nuvoton/clk_npcm.c    | 15 ++++++++++++---
>   drivers/clk/nuvoton/clk_npcm.h    |  1 +
>   drivers/clk/nuvoton/clk_npcm8xx.c | 12 ++++++------
>   3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
> index 8d71f2a24b..18cb9cddbf 100644
> --- a/drivers/clk/nuvoton/clk_npcm.c
> +++ b/drivers/clk/nuvoton/clk_npcm.c
> @@ -135,7 +135,7 @@ static u32 npcm_clk_get_div(struct clk *clk)
>   	return div;
>   }
>   
> -static u32 npcm_clk_set_div(struct clk *clk, u32 div)
> +static int npcm_clk_set_div(struct clk *clk, u32 div)
>   {
>   	struct npcm_clk_priv *priv = dev_get_priv(clk->dev);
>   	struct npcm_clk_div *divider;
> @@ -145,6 +145,9 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
>   	if (!divider)
>   		return -EINVAL;
>   
> +	if (divider->flags & DIV_RO)
> +		return 0;
> +
>   	if (divider->flags & PRE_DIV2)
>   		div = div >> 1;
>   
> @@ -153,6 +156,12 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
>   	else
>   		clkdiv = ilog2(div);
>   
> +	if (clkdiv > (divider->mask >> (ffs(divider->mask) - 1))) {
> +		printf("clkdiv(%d) for clk(%ld) is over limit\n",
> +		       clkdiv, clk->id);
> +		return -EINVAL;
> +	}
> +
>   	val = readl(priv->base + divider->reg);
>   	val &= ~divider->mask;
>   	val |= (clkdiv << (ffs(divider->mask) - 1)) & divider->mask;
> @@ -253,8 +262,8 @@ static ulong npcm_clk_set_rate(struct clk *clk, ulong rate)
>   	if (ret)
>   		return ret;
>   
> -	debug("%s: rate %lu, new rate (%lu / %u)\n", __func__, rate, parent_rate, div);
> -	return (parent_rate / div);
> +	debug("%s: rate %lu, new rate %lu\n", __func__, rate, npcm_clk_get_rate(clk));
> +	return npcm_clk_get_rate(clk);
>   }
>   
>   static int npcm_clk_set_parent(struct clk *clk, struct clk *parent)
> diff --git a/drivers/clk/nuvoton/clk_npcm.h b/drivers/clk/nuvoton/clk_npcm.h
> index 06b60dc8b8..b4726d8381 100644
> --- a/drivers/clk/nuvoton/clk_npcm.h
> +++ b/drivers/clk/nuvoton/clk_npcm.h
> @@ -50,6 +50,7 @@
>   #define PRE_DIV2	BIT(2)	/* Pre divisor = 2 */
>   #define POST_DIV2	BIT(3)	/* Post divisor = 2 */
>   #define FIXED_PARENT	BIT(4)	/* clock source is fixed */
> +#define DIV_RO		BIT(5)	/* divider is read-only */
>   
>   /* Parameters of PLL configuration */
>   struct npcm_clk_pll {
> diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/clk_npcm8xx.c
> index 27e3cfcf55..d1b32e3237 100644
> --- a/drivers/clk/nuvoton/clk_npcm8xx.c
> +++ b/drivers/clk/nuvoton/clk_npcm8xx.c
> @@ -45,12 +45,12 @@ static struct npcm_clk_select npcm8xx_clk_selectors[] = {
>   };
>   
>   static struct npcm_clk_div npcm8xx_clk_dividers[] = {
> -	{NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2},
> -	{NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2},
> -	{NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2},
> -	{NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1},
> -	{NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1},
> -	{NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1},
> +	{NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2 | DIV_RO},
> +	{NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2 | DIV_RO},
> +	{NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2 | DIV_RO},

And this makes sense for bus clocks

> +	{NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1 | DIV_RO},
> +	{NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1 | DIV_RO},
> +	{NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1 | DIV_RO},

But it's a little unclear to me why this is enabled for SPI. Are you e.g.
doing XIP from SPI?

--Sean

>   	{NPCM8XX_CLK_SPIX, CLKDIV3, SPIXCKDIV, DIV_TYPE1},
>   	{NPCM8XX_CLK_UART, CLKDIV1, UARTDIV1, DIV_TYPE1},
>   	{NPCM8XX_CLK_UART2, CLKDIV3, UARTDIV2, DIV_TYPE1},

