Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA8DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D4087215;
	Tue, 14 Nov 2023 14:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HajipH/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0517D87446; Tue, 14 Nov 2023 14:14:59 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28E7871E4
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789923612dso348384185a.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699967695; x=1700572495; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYNgrmVJC9w7IXoyL6mbBBtVvXJHUVFxiN5h1vukYzA=;
 b=HajipH/alcXZOFJyDSSvHkm0B/uxWzyCIcZL/5g/knhEjyt+6BAfc8Xr3cqJoCquYS
 wjga7wbAeAa9iVoKoM3SIFRZ0tt3+N3gluCuHpy8v0/CZPEeRzLWPtwnt/IxRIroup4h
 HRRP1GhXPg5m3aiTHHDyEcNi9fUIFSOmRnDpcfLQh6bWHsW7GzvtK70QgJV/VfmZBIuG
 uwBTja2aXp+SUfUbevVOYIsJaxmVWVCpBVdozNL863LKnkM1L07oPA1cOBx+sFgxufJ6
 J6Y2mPvvGzzsUq08T5g/w4qK8LqvMl+KfIhuoq+7ewTHDt+1XXiHSkr51gy2ppHJADYU
 ZYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699967695; x=1700572495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYNgrmVJC9w7IXoyL6mbBBtVvXJHUVFxiN5h1vukYzA=;
 b=upFwm4I4STefgDaKdDvRWf/nOSdtY8mIWHD20/bGRTgQ3XBOvG1bDfZ26N6jOBcX+B
 1YnjKYpwWc/B7i/wRabmoqgTcxO/du7W994pD75A6km7Q8O37uVRDyT09UV+k3KZftE2
 O7hOX1B1t3NbvxHyXK9zyaAn7uWasmpLAv3iNK1k+uBL7WD3Vv5vgOJKxoUrA/WM3W8N
 F7/dlSACRdWiyimLPNRwqZPaO54qEh08ra6PMTQLvtwPut2Tubm7wFJoHwX9lZsLKE6x
 4F8EcBkMuE1pDGTsV3XsScBJcTgpu+pBBD7wu48w+Sd9fwBnnXCZ+eXAKB1FtALrDgp5
 Hv8g==
X-Gm-Message-State: AOJu0YwU/3BVxwPfiXOw6SCPFA2fjBMOBOEfL1egRTRQBYp8oJAYN7n1
 2dOSE6i7g15XEu/brRG4hYo=
X-Google-Smtp-Source: AGHT+IE0eGcsV+5LG1jHpBVzkmZoJzRyod1klriFG3hDsTWTxKGJr66DWfKaDht7EoUBBYN6/3Kduw==
X-Received: by 2002:a05:620a:2a08:b0:77a:1476:fb93 with SMTP id
 o8-20020a05620a2a0800b0077a1476fb93mr2298158qkp.47.1699967695580; 
 Tue, 14 Nov 2023 05:14:55 -0800 (PST)
Received: from [192.168.1.63] (c-71-62-146-134.hsd1.va.comcast.net.
 [71.62.146.134]) by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2640853qkw.43.2023.11.14.05.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:14:55 -0800 (PST)
Message-ID: <b4e935c8-f1b8-53ad-476e-280279abc0f3@gmail.com>
Date: Tue, 14 Nov 2023 08:14:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3] clk: nuvoton: add read only feature for clk driver
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, YSCHU@nuvoton.com,
 KWLIU@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231114090004.3746024-1-JJLIU0@nuvoton.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231114090004.3746024-1-JJLIU0@nuvoton.com>
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



On 11/14/23 04:00, Jim Liu wrote:
> Add a flag to set ahb/apb/fiu/spi clock divider as read-only
> The spi clock setting is related to booting flash, it is setup by early
> bootloader.
> It just protects the clock source and can't modify it in uboot.
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v3:
>     - add commit message
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
> +	{NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1 | DIV_RO},
> +	{NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1 | DIV_RO},
> +	{NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1 | DIV_RO},
>   	{NPCM8XX_CLK_SPIX, CLKDIV3, SPIXCKDIV, DIV_TYPE1},
>   	{NPCM8XX_CLK_UART, CLKDIV1, UARTDIV1, DIV_TYPE1},
>   	{NPCM8XX_CLK_UART2, CLKDIV3, UARTDIV2, DIV_TYPE1},
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
