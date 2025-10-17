Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EC5CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBA783710;
	Fri, 17 Oct 2025 14:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vnRF/lOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8099E83826; Fri, 17 Oct 2025 14:48:48 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909E583655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 32F9E1A1477;
 Fri, 17 Oct 2025 12:48:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0165E606DB;
 Fri, 17 Oct 2025 12:48:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 855C9102F2356; 
 Fri, 17 Oct 2025 14:48:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760705324; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5Qea+T+K0WshxlsMIVOj40lZZ/hj6AU/eQEG73LbQKo=;
 b=vnRF/lOSYxvv3Oz+8UV4N3gbh/d3yyatdPh3U+faWhTaquf5oY5Fc2bwohNcfKMo9PLxLl
 k0dVieuehk1u01HbqXyNApfh5zXw8L6qDcaoash89wEr+toaNr+0MDu1bXZMaLsEh8XyPk
 9F1FChYNJ3dA8fYMjbOZlB34e8KiAgpt7s/aN2lmO08HIlNaGMzaLTBScjg38hE2E6EAyd
 6cbjIculOke0up1A6mQmBiOUyCb9y/KXr901/WSZAdL0s2R97tDvq6582BBHYZfEX244w8
 +fKGN0/rShnBTCEqrZs3knn4ousz7pD07SxZ8C8sW95CxSxz21zQmjC0O/IFEg==
Message-ID: <2dfe9006-a20a-412e-921d-66b083426ccc@bootlin.com>
Date: Fri, 17 Oct 2025 14:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] mtd: rawnand: sunxi_spl: fix pointer from integer
 without a cast
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
 <20251016142752.2627710-3-richard.genoud@bootlin.com>
 <ac8a38f3-bfa7-4124-94f0-139326de5cbb@arm.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <ac8a38f3-bfa7-4124-94f0-139326de5cbb@arm.com>
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

Le 17/10/2025 à 09:57, Andre Przywara a écrit :
> Hi,
> 
> On 16/10/2025 15:27, Richard Genoud wrote:
>> Fix pointer from interget warning when compiling for ARM64
>>
>> When compiling for arm64, we get this error:
>> error: passing argument 2 of ‘__memcpy_fromio’ makes pointer from
>>             integer without a cast [-Wint-conversion]
>>
>> Fix that with a cast to (void *)(uintptr_t)
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/ 
>> raw/sunxi_nand_spl.c
>> index 4f1e2d9a5775..19091ece632b 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> @@ -310,7 +310,8 @@ static int nand_read_page(const struct nfc_config 
>> *conf, u32 offs,
>>               return 1;
>>           /* Retrieve the data from SRAM */
>> -        memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
>> +        memcpy_fromio(data,
>> +                  (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
> 
> I don't think memcpy_fromio() is correct here in the first place. It 
> looks tempting to use it, but the implementation is not safe to use with 
> Allwinner peripherals: we need to stick to the predefined device 
> register access width. Neither the arm nor the arm64 implementation are 
> fully compliant. If you go by the book, the peripheral registers are 32- 
> bit wide, and must only be accessed via a 32-bit wide access (readl/ 
> writel). Empirically 8-bit accesses to a 32-bit aligned address also 
> seem to work, but not to other addresses. Everything else is unsafe and 
> should be avoided.
> So can you please replace this call with a for-loop of readl() 
> invocations? This should be safe with all devices, and since the base 
> address is 32-bit aligned, and I assume ecc_size is as well, we are good 
> here.
Ok, sure.

Thanks!

> 
> Cheers,
> Andre
> 
>>                     conf->ecc_size);
>>           /* Stop the ECC engine */
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
