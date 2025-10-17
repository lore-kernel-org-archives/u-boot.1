Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA5ACCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 14:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6028382E;
	Fri, 17 Oct 2025 16:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R9/k9u/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56F8382E; Fri, 17 Oct 2025 16:26:30 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4258309A
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1705A4E41145;
 Fri, 17 Oct 2025 14:26:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DAEF6606DB;
 Fri, 17 Oct 2025 14:26:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BE3DD102F235A; 
 Fri, 17 Oct 2025 16:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760711187; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3R4f5hqJbYYTyikvCKTJYuvMdfSOLNNwUHP1OaZ5Bic=;
 b=R9/k9u/OPGWCM8mc5rb3OyzoLTdGSP2LxbsX4l8mr1bqmdo2zSY9v1t9ubIRSVj+rH/fjj
 7/qvDPwB/m6XWVyq9KodvwMXQ2t9I2+xvaYQCDcG/B72l4A6L4QiEa/PKQzc/84Y+EeRWS
 9062MrkputLeJSW3ktJ5zfRgTUOGtzXhItlbpPQmV/azOg//frJe3VkOvlpVWx5mjME3/e
 FRomeTJitQoyqf9dedymKPfYwwEjr+tRJA+zHsEwTyRTaFjhpDi1okAkBMWBOxmgMwWD8M
 RJvfS9Jq5oxbZETp6CMgAp9XPp2cAOoTDJdyzlwmWfLilWk6RKcKmTvyuQZQiw==
Message-ID: <7c7fbd8d-01aa-45fe-a21d-b9120f179f06@bootlin.com>
Date: Fri, 17 Oct 2025 16:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] mtd: rawnand: sunxi_spl: cosmetic: replace
 AHB_DIV_1 by CCM_NAND_CTRL_M/N
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
 <20251016142752.2627710-6-richard.genoud@bootlin.com>
 <98174913-3877-4038-a5f3-064808b29650@arm.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <98174913-3877-4038-a5f3-064808b29650@arm.com>
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

Le 17/10/2025 à 11:36, Andre Przywara a écrit :
> Hi,
> 
> On 16/10/2025 15:27, Richard Genoud wrote:
>> CCM_NAND_CTRL_M/N is defined in clock headers, and it's more readable
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/ 
>> raw/sunxi_nand_spl.c
>> index 306c1c0d0989..9f80a8010d7b 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> @@ -531,5 +531,6 @@ void nand_deselect(void)
>>   #else
>>       clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
>>   #endif
>> -    clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
>> +    clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE |
>> +             CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
> 
> The change looks alright, but can you please use the opportunity to 
> change the CCM access to the new scheme, away from using a struct, and 
> towards using #define'd offsets? You have that conditionally in a later 
> patch, so please rather move the legacy users over here.
> No need to change *every* clock user for the older SoCs, or to remove 
> the NAND clocks from the struct, just define the NAND related offsets in 
> clock_sun4i.h and clock_sun6i.h, then use the H6/H616 way here for all.

Yes, absolutely, it will be cleaner that way.

Thanks!

> 
> Thanks!
> Andre
> 
> 
>>   }
> 

-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
