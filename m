Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE842C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69AEE86611;
	Mon, 13 Nov 2023 19:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBchj4Zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29E9864F3; Mon, 13 Nov 2023 19:10:48 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF27A86958
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-586beb5e6a7so2709671eaf.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699899043; x=1700503843; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ENWqWZ5ItXcVA86wMeOc9+4kuL/g0dg0MEup7KqFfdw=;
 b=nBchj4Zopm65XJuZrNfV4qU6p05lWFaO5p5sa51HKKsmWa/SCQ/eCLATxxIHKTCqeT
 gjRnTsW+8kpTrE6lnwhD3yl8J78FrgcP6F3uIwRvF4cqkYjibRy0MdhEWGmwEBt+a6Ue
 NlkKcV43k4c9AZmq1onvIo+5OsmiyU6nzDlSkH48AkWPwRv2vV0fHOgVKA0hUqVKubO8
 Wm37TrIrvqEolMsban5HXpzBHchc0b/yHYn91ygsFllUFz9bqJwdct/ae7AxKyGQJewF
 bIt/tjB/yTNMgW7tdRK2vJaQRh+c61i55kzNnxs5uQeX1fzsctDnPtsXJ72AzC7r/ysz
 Z45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899043; x=1700503843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENWqWZ5ItXcVA86wMeOc9+4kuL/g0dg0MEup7KqFfdw=;
 b=PicpmtpbFOf54cNSLbCLPcXsSXHQZ19dNzDOrlAkxUmqeP9tfF8YhumDdxDfVzN93l
 LmadQ9UJ+MbKFPfHdn4N3BYnBvlALzadoZBVNFCoExZlnDy2EAqu63eOIbXTLjwRzvyC
 bhKTHDu6mIwH5es2kI0uZGhNPw0i2xGUJDNsFs7x4vkTBKMze9l3w1wJc5iJvZolsuBJ
 +mboeSfuUCPMHFdfIn9qg5i/mh7pEw4w6LCRrCZKM37o7y72cKphB9q31HPqo7n2YXl1
 ZtJRbr8a1KEuflL01N5fpNi9vTgLll1m8DhVgMNbPshxEXEK7dk6W4T+RznLK/LQQ+bd
 Ag7A==
X-Gm-Message-State: AOJu0YyfcPlNS4tzxLneQMd4Nm/0/m3AKW70JCliXFKPFaciYb1nQa1l
 1+bF8PRuScMcT9hcDzLNcvk=
X-Google-Smtp-Source: AGHT+IEKEVF+lxNbeF+o+3P+AnniUnFqamJlFqCnKk7C0L7C75a99DuBABAQOoN2FB0vRbHVKYEyBA==
X-Received: by 2002:a05:6358:720b:b0:168:e01a:2002 with SMTP id
 h11-20020a056358720b00b00168e01a2002mr73023rwa.10.1699899043032; 
 Mon, 13 Nov 2023 10:10:43 -0800 (PST)
Received: from [172.25.83.38] ([12.186.190.2])
 by smtp.gmail.com with ESMTPSA id
 o11-20020ac8428b000000b004166ab2e509sm2092950qtl.92.2023.11.13.10.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:10:42 -0800 (PST)
Message-ID: <296c78cc-d44b-f47e-38b9-8fbf3e87a7b5@gmail.com>
Date: Mon, 13 Nov 2023 13:10:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] clk: nuvoton: add read only feature for clk driver
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
References: <20231107090128.199267-1-JJLIU0@nuvoton.com>
 <8b3ac0c1-6f2a-92ec-120a-ae65faae1c0b@gmail.com>
 <CAKUZ0+GwDB+f669CJ+hy7n9NpVkZR1y_ZwRRMJVyC2Be7RAcFw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAKUZ0+GwDB+f669CJ+hy7n9NpVkZR1y_ZwRRMJVyC2Be7RAcFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Jim,

On 11/12/23 21:42, Jim Liu wrote:
> Hi Sean
> 
> Thanks for your review.
> 
> The spi clock setting is related to booting flash, it is setup by
> early bootloader and we don't want u-boot to change it

Makes sense. Please add this to your commit message if you do a v3.

Reviewed-by: Sean Anderson <seanga2@gmail.com>

> On Thu, Nov 9, 2023 at 2:07 AM Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 11/7/23 04:01, Jim Liu wrote:
>>> Add a flag to set ahb/apb/fiu clock divider as read-only
>>> It just protects the clock source and can't modify it in uboot.
>>
>> Thanks for adding this
>>
>>> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>>> ---
>>> Changes for v2:
>>>      - add commit message
>>> ---
>>>    drivers/clk/nuvoton/clk_npcm.c    | 15 ++++++++++++---
>>>    drivers/clk/nuvoton/clk_npcm.h    |  1 +
>>>    drivers/clk/nuvoton/clk_npcm8xx.c | 12 ++++++------
>>>    3 files changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
>>> index 8d71f2a24b..18cb9cddbf 100644
>>> --- a/drivers/clk/nuvoton/clk_npcm.c
>>> +++ b/drivers/clk/nuvoton/clk_npcm.c
>>> @@ -135,7 +135,7 @@ static u32 npcm_clk_get_div(struct clk *clk)
>>>        return div;
>>>    }
>>>
>>> -static u32 npcm_clk_set_div(struct clk *clk, u32 div)
>>> +static int npcm_clk_set_div(struct clk *clk, u32 div)
>>>    {
>>>        struct npcm_clk_priv *priv = dev_get_priv(clk->dev);
>>>        struct npcm_clk_div *divider;
>>> @@ -145,6 +145,9 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
>>>        if (!divider)
>>>                return -EINVAL;
>>>
>>> +     if (divider->flags & DIV_RO)
>>> +             return 0;
>>> +
>>>        if (divider->flags & PRE_DIV2)
>>>                div = div >> 1;
>>>
>>> @@ -153,6 +156,12 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
>>>        else
>>>                clkdiv = ilog2(div);
>>>
>>> +     if (clkdiv > (divider->mask >> (ffs(divider->mask) - 1))) {
>>> +             printf("clkdiv(%d) for clk(%ld) is over limit\n",
>>> +                    clkdiv, clk->id);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>>        val = readl(priv->base + divider->reg);
>>>        val &= ~divider->mask;
>>>        val |= (clkdiv << (ffs(divider->mask) - 1)) & divider->mask;
>>> @@ -253,8 +262,8 @@ static ulong npcm_clk_set_rate(struct clk *clk, ulong rate)
>>>        if (ret)
>>>                return ret;
>>>
>>> -     debug("%s: rate %lu, new rate (%lu / %u)\n", __func__, rate, parent_rate, div);
>>> -     return (parent_rate / div);
>>> +     debug("%s: rate %lu, new rate %lu\n", __func__, rate, npcm_clk_get_rate(clk));
>>> +     return npcm_clk_get_rate(clk);
>>>    }
>>>
>>>    static int npcm_clk_set_parent(struct clk *clk, struct clk *parent)
>>> diff --git a/drivers/clk/nuvoton/clk_npcm.h b/drivers/clk/nuvoton/clk_npcm.h
>>> index 06b60dc8b8..b4726d8381 100644
>>> --- a/drivers/clk/nuvoton/clk_npcm.h
>>> +++ b/drivers/clk/nuvoton/clk_npcm.h
>>> @@ -50,6 +50,7 @@
>>>    #define PRE_DIV2    BIT(2)  /* Pre divisor = 2 */
>>>    #define POST_DIV2   BIT(3)  /* Post divisor = 2 */
>>>    #define FIXED_PARENT        BIT(4)  /* clock source is fixed */
>>> +#define DIV_RO               BIT(5)  /* divider is read-only */
>>>
>>>    /* Parameters of PLL configuration */
>>>    struct npcm_clk_pll {
>>> diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/clk_npcm8xx.c
>>> index 27e3cfcf55..d1b32e3237 100644
>>> --- a/drivers/clk/nuvoton/clk_npcm8xx.c
>>> +++ b/drivers/clk/nuvoton/clk_npcm8xx.c
>>> @@ -45,12 +45,12 @@ static struct npcm_clk_select npcm8xx_clk_selectors[] = {
>>>    };
>>>
>>>    static struct npcm_clk_div npcm8xx_clk_dividers[] = {
>>> -     {NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2},
>>> -     {NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2},
>>> -     {NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2},
>>> -     {NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1},
>>> -     {NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1},
>>> -     {NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1},
>>> +     {NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2 | DIV_RO},
>>> +     {NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2 | DIV_RO},
>>> +     {NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2 | DIV_RO},
>>
>> And this makes sense for bus clocks
>>
>>> +     {NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1 | DIV_RO},
>>> +     {NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1 | DIV_RO},
>>> +     {NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1 | DIV_RO},
>>
>> But it's a little unclear to me why this is enabled for SPI. Are you e.g.
>> doing XIP from SPI?
>>
>> --Sean
>>
>>>        {NPCM8XX_CLK_SPIX, CLKDIV3, SPIXCKDIV, DIV_TYPE1},
>>>        {NPCM8XX_CLK_UART, CLKDIV1, UARTDIV1, DIV_TYPE1},
>>>        {NPCM8XX_CLK_UART2, CLKDIV3, UARTDIV2, DIV_TYPE1},
>>
