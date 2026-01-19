Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B414D29C27
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 13:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9439E80B98;
	Mon, 19 Jan 2026 14:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ipSdKYgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7478B83015; Mon, 19 Jan 2026 14:13:41 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE479800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 14:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5E0D6C214CA;
 Mon, 19 Jan 2026 13:13:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 536E960731;
 Mon, 19 Jan 2026 13:13:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4132210B682CB; Mon, 19 Jan 2026 14:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768828417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/qxgAV0hza188j+Mp7nRaoLT4bE2vnOKCNCKnnfjODM=;
 b=ipSdKYgiF640hVZFivWGDlUdbV5FCMTbLv30TMGorLhChXhSnkZGDLHO5mVckyQn7ciiCx
 woOn8uzzhaUtmfKst2j3KmziaABpqXt0j9C2PTud+jvxUZpG8oxQ6k2pumiL99TqUQG1Pu
 jssxDTo4zjlM8h68yw/cm0/MTNypMVLKAP4Q/1oxqeaMxqSaKTcYrLdnu4hWkNAmS4MkIe
 IQid2pxFnVPyceaZsujK+SzLlKF1bWEAAfm6gzpX7DJViCMd+wf0YMv7v3moo80Hs93Xfn
 be1i5CfqjvTs7VF1zd5ptIdgbi0HiYWz8EH3EC5G0veR0n9yQe1VvSBXjemKmA==
Message-ID: <2a1824b5-e514-4eb0-8e08-2d4307f86c44@bootlin.com>
Date: Mon, 19 Jan 2026 14:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from
 integer without a cast
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
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-3-richard.genoud@bootlin.com>
 <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
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

Hi,
Le 19/01/2026 à 12:12, Andre Przywara a écrit :
> Hi,
> 
> On 28/10/2025 09:12, Richard Genoud wrote:
>> Fix pointer from interget warning when compiling for ARM64
>>
>> When compiling for arm64, we get this error:
>> error: passing argument 2 of ‘__memcpy_fromio’ makes pointer from
>>             integer without a cast [-Wint-conversion]
>>
>> Moreover the copy should be made with dedicated readl(), like for any
>> register access on this peripheral, since they are 32bit wide.
>>
>> So, instead of memcpy_fromio(), just use a readl() loop.
>> Introduce nand_readlcpy() to implement this loop.
>>
>> Fixes: 6ddbb1e936c7 ("spl: nand: sunxi: use PIO instead of DMA")
>> Suggested-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/ 
>> raw/sunxi_nand_spl.c
>> index 4f1e2d9a5775..a15f54573df2 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
>> @@ -251,6 +251,17 @@ static int nand_change_column(u16 column)
>>   static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
>> +static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
>> +{
>> +    if (len & 0x3)
>> +        printf("length should be multiple of 4 (32bits access), data 
>> will be incomplete.\n");
> 
> This should not be a message printed on the console. There is only 
> one(?) internal user, and the argument is a multiple of 512, if I see 
> that correctly. So it's an internal error that wouldn't happen at all in 
> the moment. It just blows up the code size, and isn't even very 
> descriptive.
> 
> If you *really* want to check that, you could try to use something like 
> builtin_constant_p, to create a compile-time error, or maybe use 
> debug(). But I would suggest to drop it completely, as it would be 
> pointless with the current code anyway.
> 
> The rest looks fine, thanks for adding that function.
Indeed, I can drop it and add a comment to warn future users in this driver.

@Michael, do you want me to do a v3, or just apply this v2 and I'll send 
a fix? (or you just remove those lines when you apply the patch?)

Thanks !

Regards,
Richard
> 
> Cheers,
> Andre
> 
>> +    len >>= 2;
>> +
>> +    while (len--)
>> +        *dest++ = readl(src++);
>> +}
>> +
>>   static int nand_read_page(const struct nfc_config *conf, u32 offs,
>>                 void *dest, int len)
>>   {
>> @@ -310,7 +321,8 @@ static int nand_read_page(const struct nfc_config 
>> *conf, u32 offs,
>>               return 1;
>>           /* Retrieve the data from SRAM */
>> -        memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
>> +        nand_readlcpy((u32 *)data,
>> +                  (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
>>                     conf->ecc_size);
>>           /* Stop the ECC engine */
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
