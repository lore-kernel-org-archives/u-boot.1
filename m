Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED61FD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 07:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0CB83A2D;
	Tue, 20 Jan 2026 08:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nJt9pgVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AB6839E8; Tue, 20 Jan 2026 08:49:29 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 567C583A64
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id ED6091A2931;
 Tue, 20 Jan 2026 07:49:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C0DE4606AB;
 Tue, 20 Jan 2026 07:49:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3A55E10B6816D; Tue, 20 Jan 2026 08:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768895365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yO9X+DAkmdiehYOBLBPg0nKDwvgJvO6UrdZc/qXDLsM=;
 b=nJt9pgVqgGELwEFwg3Uhp9ZIHfuLqIWEnLiubZmEQgo3+aJTww8R25wz3xK6INdkDPzQuc
 MW8oCr/6UQAUfPUttSUtqe0+w5QLRd+FrWfWb7tkjzFMPNc36ZsJLm0O7jGCP3DaQHCCJf
 vqbMXdQeaKaABvyWRu+AaWNHpgAE1UyKu9HvG10Yf2OGqriR7EEOgg7J1HUvUGv7fwRSxk
 +lipLf+WALBWDCk1PKu1hwtJs+Qg58zmyo7jO8PbC1vXpGOB6wcSxqdTW2Mn6dojGy5bC5
 KcXnlEF+jXMr8N7qNRxzWJalGalK8P7iQbtJKW237PGNA3h3VX3luebfQ+9WcQ==
Message-ID: <5c6bc402-3bdc-4bd1-aa16-dbac1a91a37d@bootlin.com>
Date: Tue, 20 Jan 2026 08:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] Introduce Allwinner H6/H616 NAND controller
 support
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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
 <CAOf5uw=gqHtS7BynpaN-FO+gNinBnao+phhMAs-pn5gk9BSP6A@mail.gmail.com>
 <5b7e3e38-325f-424b-ab95-8775924333e4@bootlin.com>
 <CAOf5uwkwDKzZpbj-iXBL2YTu-eH=96f2EzLcn0TFyGcJZHiNWQ@mail.gmail.com>
 <CAOf5uwkhHyXHUHRMLa9OStb+uuWQ6wajWOWncd=HUgzGZSBV=A@mail.gmail.com>
 <CAOf5uw=_1O=wYDTXxpXu1UDcUZWUN_9Se1HPbzzMU2Fttqm8Jw@mail.gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <CAOf5uw=_1O=wYDTXxpXu1UDcUZWUN_9Se1HPbzzMU2Fttqm8Jw@mail.gmail.com>
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

Hi Michael,

Le 20/01/2026 à 08:33, Michael Nazzareno Trimarchi a écrit :
> Hi Richard
> 
> On Mon, Jan 19, 2026 at 10:01 AM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>>
>> Hi Richard
>>
>> I queue them and run the CI, I have it ready, waiting for the denx
>> site to be up again
>>
> 
> At this point I think the best is resend the series including last
> patches and the requested changes for two
> patches
Ok!


Thanks!
> 
> Michael
> 
>> Michael
>>
>> On Mon, Jan 12, 2026 at 6:30 PM Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>>
>>> Hi
>>>
>>> My fault, I was thinking to already have picked them, I will do
>>>
>>> On Mon, Jan 12, 2026 at 6:09 PM Richard GENOUD
>>> <richard.genoud@bootlin.com> wrote:
>>>>
>>>> Hi Michael,
>>>> Le 31/10/2025 à 07:43, Michael Nazzareno Trimarchi a écrit :
>>>>> Hi Richard
>>>>>
>>>>> On Tue, Oct 28, 2025 at 10:13 AM Richard Genoud
>>>>> <richard.genoud@bootlin.com> wrote:
>>>>>>
>>>>>> Hi everyone,
>>>>>>
>>>>>> This patch series introduce H6/H616 NAND controller support (but not yet
>>>>>> the DMA/MDMA part).
>>>>>>
>>>>>> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
>>>>>> chip.
>>>>>> ECC is supported, as well as scrambling.
>>>>>>
>>>>>> Support for booting from NAND is not part of this series, but it's almost
>>>>>> ready. (It needs quite some modifications in sunxi-spl-image-builder.c
>>>>>> and sunxi_toc0.c)
>>>>>>
>>>>>> H6 SoC has not been tested, but it shares all registers with H616, plus
>>>>>> some registers dedicated to Embedded Crypto Engine that H616 lacks.
>>>>>>
>>>>>> This IP has quite some register fields modified from the A10/A23, but in
>>>>>> the end, it works more or less the same.
>>>>>> Main differences with A10/A23 are:
>>>>>> - The need for 2 more clocks (for ECC and MBUS)
>>>>>> - The use of a new USER_DATA_LEN register
>>>>>> - More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
>>>>>> - MDMA based on chained buffers
>>>>>> - some registers layouts have changed (mainly due do the stronger ECC)
>>>>>>
>>>>>> Patches 1 and 2 are small fixes
>>>>>>
>>>>>> Patches 3-6 harmonize the registers definitions between U-Boot and SPL,
>>>>>> and ultimately merge those definitions in an include file, without
>>>>>> functional change, removing the usage of sunxi_ccm_reg on the way.
>>>>>>
>>>>>> Patches 7-19 are paving the way to the introduction of H6/H616 NAND
>>>>>> controller by adding per SoC capabilities for both drivers. They are
>>>>>> small for an easier review, without functional change.
>>>>>>
>>>>>> Patches 20-21 are adding missing NAND related clocks definitions for
>>>>>> H6/H616
>>>>>>
>>>>>> Patch 22 adds the support for H6/H616 NAND controller in U-Boot.
>>>>>>
>>>>>> Patch 23 adds the support for H6/H616 NAND controller in SPL.
>>>>>>
>>>>>> Patch 24 fixes warnings in sunxi_nand_spl.c
>>>>>>
>>>>>> A similar series for this NAND controller support in Linux has been sent
>>>>>> and being reviewed.
>>>>>>
>>>>>> Changes from v1:
>>>>>> - pick-up reviewed-by
>>>>>> - use a readl() loop instead of memcpy_fromio() in patch 2 as suggested
>>>>>>     by Andre
>>>>>> - remove cosmetic in patches that are beyond cosmetic changes
>>>>>> - remove usage of struct sunxi_ccm_reg, suggested by Andre
>>>>>> - indent @caps member description in comment
>>>>>> - give more informations on PAT_FOUND registers in commit message
>>>>>> - drop NFC_ECC_BLOCK_SIZE_MSK which was just a 1bit mask for the very
>>>>>>     same bit NFC_ECC_BLOCK_512
>>>>>> - add missing MACH_SUN50I_H6 in Kconfig
>>>>>>
>>>>>> Richard Genoud (24):
>>>>>>     mtd: rawnand: sunxi: cosmetic: remove needless comment
>>>>>>     mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
>>>>>>     mtd: rawnand: sunxi_spl: harmonize register defines with non spl file
>>>>>>     mtd: rawnand: sunxi_spl: cosmetic: use definitions from
>>>>>>       linux/mtd/rawnand.h
>>>>>>     mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
>>>>>>     mtd: rawnand: sunxi: merge register definitions for
>>>>>>       sunxi_nand{,_spl}.c
>>>>>>     mtd: rawnand: sunxi: add per SoC capabilities
>>>>>>     mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
>>>>>>     mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
>>>>>>     mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
>>>>>>     mtd: rawnand: sunxi: add has_ecc_block_512 capability
>>>>>>     mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
>>>>>>     mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
>>>>>>     mtd: rawnand: sunxi_spl: add per SoC capabilities
>>>>>>     mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
>>>>>>     mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
>>>>>>     mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
>>>>>>     mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
>>>>>>     mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macros
>>>>>>     sunxi: clock: H6: add NAND controller clock registers
>>>>>>     clk: sunxi: Add MBUS Master Clock Gating Register
>>>>>>     mtd: rawnand: sunxi: add support for H6/H616 nand controller
>>>>>>     mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
>>>>>>     mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
>>>>>>
>>>>>>    arch/arm/include/asm/arch-sunxi/clock_sun4i.h |   1 +
>>>>>>    .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
>>>>>>    arch/arm/include/asm/arch-sunxi/clock_sun6i.h |   1 +
>>>>>>    .../include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
>>>>>>    arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   2 +
>>>>>>    board/sunxi/board.c                           |  19 +-
>>>>>>    drivers/clk/sunxi/clk_h6.c                    |   2 +
>>>>>>    drivers/clk/sunxi/clk_h616.c                  |   2 +
>>>>>>    drivers/mtd/nand/raw/Kconfig                  |   3 +-
>>>>>>    drivers/mtd/nand/raw/sunxi_nand.c             | 308 +++++++++--------
>>>>>>    drivers/mtd/nand/raw/sunxi_nand.h             | 228 +++++++++++++
>>>>>>    drivers/mtd/nand/raw/sunxi_nand_spl.c         | 322 +++++++++++-------
>>>>>>    12 files changed, 629 insertions(+), 284 deletions(-)
>>>>>>    create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
>>>>>>
>>>>>
>>>>> I will pick the series over the weekend, check CI, and check better
>>>>> all the patches that already
>>>>> get reviewed anyway
>>>>
>>>> Any news?
>>>
>>> Sorry, I have picked the patches assigned to me, but now I found out
>>> that I miss your series because
>>> was not assigned to me. Give me a couple of days
>>>
>>> Michael
>>>
>>>>
>>>>
>>>> Regards,
>>>> Richard
>>>>
>>>>
>>>>>
>>>>> MIchael
>>>>>
>>>>>>
>>>>>> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
>>>>>> --
>>>>>> 2.47.3
>>>>>>
>>>>
>>>>
>>>> --
>>>> Richard Genoud, Bootlin
>>>> Embedded Linux and Kernel engineering
>>>> https://bootlin.com
>>>
>>>
>>>
>>> --
>>> Michael Nazzareno Trimarchi
>>> Co-Founder & Chief Executive Officer
>>> M. +39 347 913 2170
>>> michael@amarulasolutions.com
>>> __________________________________
>>>
>>> Amarula Solutions BV
>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>> T. +31 (0)85 111 9172
>>> info@amarulasolutions.com
>>> www.amarulasolutions.com
>>
>>
>>
>> --
>> Michael Nazzareno Trimarchi
>> Co-Founder & Chief Executive Officer
>> M. +39 347 913 2170
>> michael@amarulasolutions.com
>> __________________________________
>>
>> Amarula Solutions BV
>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>> T. +31 (0)85 111 9172
>> info@amarulasolutions.com
>> www.amarulasolutions.com
> 
> 
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
