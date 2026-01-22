Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6768FD3EE72
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 15:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA83C8397D;
	Thu, 22 Jan 2026 16:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kxZIJufd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182F5839DF; Thu, 22 Jan 2026 16:20:44 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664C380077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 16:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E9FA01A2A56;
 Thu, 22 Jan 2026 15:20:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B9251606B6;
 Thu, 22 Jan 2026 15:20:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D14DA119B82F6; Thu, 22 Jan 2026 16:20:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769095239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qKw+EEWghxzxleV0/aJSoRJ3eBwxv1XrzyTOFPbtkGw=;
 b=kxZIJufdMWmwX7xg/e2JJ80DuFBvCAGlYf1zDFcwS1Q4UdmnvMjo61AC9ESh7drQHBkpjo
 p6yjzUOJ21o2g0ZOzFsT6QLwAmx1yzgbG6lx2s6czUF7P6eM17NhhtziYlGHs/9+9nvUD4
 Hg/fYS3ivcuQiyjxDqnivM3hlJnD96g8MKomN4I56/M68iihIxRGv1A5tU0naB9Pka0HRx
 /WwvohOViZ+rPedbFqyTGQF23QDeFohw7bW2fNjHXE1ACyDU6XcSRTxlM9RskgC/nKIfuF
 rIUiSORodXCP78mXv1oA01W6/JrNUGop40uOY3c8GKzj7C+AlCHpaH2cYLvrnw==
Message-ID: <6b235dd2-3cab-4707-92ed-4988f0763a58@bootlin.com>
Date: Thu, 22 Jan 2026 16:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] mtd: rawnand: sunxi: remove usage of struct
 sunxi_ccm_reg
From: Richard GENOUD <richard.genoud@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-6-richard.genoud@bootlin.com>
 <20260119141020.729d70b0@orionap.fritz.box>
 <a510fc55-401d-4329-b406-7d0742b01e0b@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <a510fc55-401d-4329-b406-7d0742b01e0b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Andre,
Le 19/01/2026 à 18:34, Richard GENOUD a écrit :
> Hi Andre,
> Le 19/01/2026 à 15:10, Andre Przywara a écrit :
>> On Tue, 28 Oct 2025 10:12:26 +0100
>> Richard Genoud <richard.genoud@bootlin.com> wrote:
>>
>> Hi Richard,
>>
>> many thanks for doing this change.
>>
>>> The sunxi_ccm_reg is legacy, drop its usage from nand related code
>>>
>>> For that, CCU_NAND0_CLK_CFG and CCU_AHB_GATE1 are added to the clock
>>> files when missing.
>>> And clock code in sunxi_nand{,_spl}.c and board.c are changed to use the
>>> new scheme.
>>>
>>> Moreover, drop AHB_DIV_1 in favor of the more readable CCM_NAND_CTRL_M/N
>>>
>>> Suggested-by: Andre Przywara <andre.przywara@arm.com>
>>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>>> ---
>>>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |  1 +
>>>   arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |  1 +
>>>   arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |  1 +
>>>   arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |  2 ++
>>>   board/sunxi/board.c                                | 11 ++++++-----
>>>   drivers/mtd/nand/raw/sunxi_nand.c                  | 11 +++++------
>>>   drivers/mtd/nand/raw/sunxi_nand_spl.c              | 13 +++++++------
>>>   7 files changed, 23 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/ 
>>> arm/include/asm/arch-sunxi/clock_sun4i.h
>>> index 00bdd5f938df..caa4b62b3e2d 100644
>>> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
>>> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
>>> @@ -11,6 +11,7 @@
>>>   #define _SUNXI_CLOCK_SUN4I_H
>>>   #define CCU_AHB_GATE0        0x60
>>> +#define CCU_NAND0_CLK_CFG    0x80
>>>   #define CCU_MMC0_CLK_CFG    0x88
>>>   #define CCU_MMC1_CLK_CFG    0x8c
>>>   #define CCU_MMC2_CLK_CFG    0x90
>>> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h b/arch/ 
>>> arm/include/asm/arch-sunxi/clock_sun6i.h
>>> index 28c3faccbbcf..bdb08a32d01b 100644
>>> --- a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
>>> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
>>> @@ -11,6 +11,7 @@
>>>   #define _SUNXI_CLOCK_SUN6I_H
>>>   #define CCU_AHB_GATE0        0x060
>>> +#define CCU_NAND0_CLK_CFG    0x80
>>
>> Just a nit, but can you please change this to 0x080, to align with the
>> other numbers?
> 
> yes, of course.
>>>   #define CCU_MMC0_CLK_CFG    0x088
>>>   #define CCU_MMC1_CLK_CFG    0x08c
>>>   #define CCU_MMC2_CLK_CFG    0x090
>>> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h b/ 
>>> arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
>>> index 5ad2163926ad..70cd0ca00d21 100644
>>> --- a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
>>> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
>>> @@ -14,6 +14,7 @@
>>>   #define _SUNXI_CLOCK_SUN8I_A83T_H
>>>   #define CCU_AHB_GATE0        0x060
>>> +#define CCU_NAND0_CLK_CFG    0x80
>>
>> Same here.
> ok
> 
>>>   #define CCU_MMC0_CLK_CFG    0x088
>>>   #define CCU_MMC1_CLK_CFG    0x08c
>>>   #define CCU_MMC2_CLK_CFG    0x090
>>> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h b/arch/ 
>>> arm/include/asm/arch-sunxi/clock_sun9i.h
>>> index 8d696e533f8f..3448f3fb3225 100644
>>> --- a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
>>> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
>>> @@ -12,11 +12,13 @@
>>>   #include <linux/bitops.h>
>>>   #endif
>>> +#define CCU_NAND0_CLK_CFG    0x400
>>>   #define CCU_MMC0_CLK_CFG    0x410
>>>   #define CCU_MMC1_CLK_CFG    0x414
>>>   #define CCU_MMC2_CLK_CFG    0x418
>>>   #define CCU_MMC3_CLK_CFG    0x41c
>>>   #define CCU_AHB_GATE0        0x580
>>> +#define CCU_AHB_GATE1        0x584
>>>   #define CCU_AHB_RESET0_CFG    0x5a0
>>
>> For the records, I checked the value of the offsets, they look correct.
>>
>>>   struct sunxi_ccm_reg {
>>> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
>>> index 2929bc17f084..09b531b7f52a 100644
>>> --- a/board/sunxi/board.c
>>> +++ b/board/sunxi/board.c
>>> @@ -307,15 +307,16 @@ static void nand_pinmux_setup(void)
>>>   static void nand_clock_setup(void)
>>>   {
>>> -    struct sunxi_ccm_reg *const ccm =
>>> -        (struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
>>> +    void * const ccm = (void *)SUNXI_CCM_BASE;
>>> -    setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << 
>>> AHB_GATE_OFFSET_NAND0));
>>> +    setbits_le32(ccm + CCU_AHB_GATE0,
>>> +             (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
>>>   #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
>>>       defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
>>
>> So the usage of #define's for the offsets instead of struct members would
>> now allow for those preprocessor guards to be replaced by C statements:
>>     if (IS_ENABLED(CONFIG_MACH_SUN6I) || IS_ENABLED(CONFIG_MACH_SUN8I)
>>     ...
>>
> Ok, I'll do that.
> 
Hum, actually it's not as simple as that.
AHB_GATE_OFFSET_NAND0/AHB_GATE_OFFSET_DMA are not defined for H6/H616, 
and of course 
CCU_H6_NAND_GATE_RESET/CCU_H6_MBUS_GATE/MBUS_GATE_OFFSET_NAND/CCU_NAND1_CLK_CFG 
are only defined for H6/H616


Regards,
Richard
>>> -    setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
>>> +    setbits_le32(ccm + CCU_AHB_RESET0_CFG, (1 << 
>>> AHB_GATE_OFFSET_NAND0));
>>>   #endif
>>> -    setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | 
>>> AHB_DIV_1);
>>> +    setbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
>>> +             CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
>>>   }
>>>   void board_nand_init(void)
>>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/ 
>>> raw/sunxi_nand.c
>>> index c6b9b2a4ebac..ba2740ed1876 100644
>>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>>> @@ -289,8 +289,7 @@ static inline struct sunxi_nfc 
>>> *to_sunxi_nfc(struct nand_hw_control *ctrl)
>>>   static void sunxi_nfc_set_clk_rate(unsigned long hz)
>>>   {
>>> -    struct sunxi_ccm_reg *const ccm =
>>> -    (struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
>>> +    void * const ccm = (void *)SUNXI_CCM_BASE;
>>>       int div_m, div_n;
>>>       div_m = (clock_get_pll6() + hz - 1) / hz;
>>> @@ -305,14 +304,14 @@ static void sunxi_nfc_set_clk_rate(unsigned 
>>> long hz)
>>>       /* config mod clock */
>>>       writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
>>>              CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
>>> -           &ccm->nand0_clk_cfg);
>>> +           ccm + CCU_NAND0_CLK_CFG);
>>>       /* gate on nand clock */
>>> -    setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_NAND0));
>>> +    setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_NAND0));
>>>   #ifdef CONFIG_MACH_SUN9I
>>
>> same here
> ok
> 
> 
>>> -    setbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
>>> +    setbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
>>>   #else
>>> -    setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
>>> +    setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
>>>   #endif
>>>   }
>>> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/ 
>>> nand/raw/sunxi_nand_spl.c
>>> index e90450439e41..2fcf52658008 100644
>>> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
>>> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
>>> @@ -533,14 +533,15 @@ unsigned int nand_page_size(void)
>>>   void nand_deselect(void)
>>>   {
>>> -    struct sunxi_ccm_reg *const ccm =
>>> -        (struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
>>> +    void * const ccm = (void *)SUNXI_CCM_BASE;
>>> -    clrbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << 
>>> AHB_GATE_OFFSET_NAND0));
>>> +    clrbits_le32(ccm + CCU_AHB_GATE0,
>>> +             (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
>>>   #ifdef CONFIG_MACH_SUN9I
>>
>> and here.
> ok
> 
>> But the actual changes look alright, including the usage of
>> CCM_NAND_CTRL_N() and CCM_NAND_CTRL_M().
>>
>> Cheers,
>> Andre
>>
>>> -    clrbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
>>> +    clrbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
>>>   #else
>>> -    clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
>>> +    clrbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
>>>   #endif
>>> -    clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | 
>>> AHB_DIV_1);
>>> +    clrbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
>>> +             CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
>>>   }
>>
> Thanks !
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
