Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9689C072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 06:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19BC5874C7;
	Wed, 22 Nov 2023 07:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700632868;
	bh=d0LtpE04LcvW35kdjF7Xpp0cCOmwj5eU1RNHPZk1w3I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Q/pLUKQw+BMlv/T6uZhMYQASVJwSyVyWnfQfO462w6xhQHNh19oQVlajCn6POM2p7
	 42j+iiZ9l5FgZ65qh74uLumvdd6PMLoM0t7NaZtIEmq/7Rwl5Q4gRkh29amLNpj5mz
	 poXjqe6rxKIAfH7Sm/UpPn5yY/ZfmfYAmA7MbHe0FKu+GwQkkonXzZsjGjVA6bZK18
	 CCT4NfRi1725+5lpz6cKV1o5cu6fP12nopa3Bgc23LweiUCFuSw+TCbSgiFn1zz63M
	 d+Z2goQDytOKO2uEBwIJCkJYLE4wi0I5NlKlk6JLPPFuMik8OuFmpc36HGHnYd3VrF
	 N8WJ1xD02J5Lg==
Received: from [192.168.1.107] (fibhost-66-250-214.fibernet.hu [85.66.250.214])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BAA9D8718E;
 Wed, 22 Nov 2023 07:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700632865;
 bh=d0LtpE04LcvW35kdjF7Xpp0cCOmwj5eU1RNHPZk1w3I=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=X3Lp88qL1cngWXkWlYdUDTNbfohhW59T7dUrhINW+4jHtf1IhfJMZUoB1UZK5KucO
 onxZz0y4kgRAlCyCm7W20Ow5Q4aFq+3KcEKEUgHe1dLKR6wEaTVqMkLflXsETVQUEi
 npobhJk6Rmy5BECnJvkyaZWRHbip3ZKtkAyDcUWXEGzSQbrseEAKBhgjyBpNDEWSGR
 nNOUPo5yTkvadZ4hU9yDmLUTUpF9gZ5SXBiavaW/p8e+jDnWVvXCeQxg+ByAQdKNC5
 KaGkUj2XxYUERFkZ8/PxlNFGRFddorZkMkjWMwElSpHcAgSXAbf7gqSMufM1WytxuJ
 yksB2vDFrP5Ug==
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
To: Roger Quadros <rogerq@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>,
 "Govindarajan, Sriramakrishnan" <srk@ti.com>
References: <20231115054044.3937543-1-hs@denx.de>
 <f21f052e-1b6d-45bc-8987-3b33eee7e09a@kernel.org>
 <0d68e932-f631-4154-4d2a-6cd2508da4bb@denx.de>
 <3d76daea-2f07-48f9-865b-81e01964704d@kernel.org>
From: Heiko Schocher <hs@denx.de>
Message-ID: <b9e43922-92bb-67a7-dab9-6d664d534661@denx.de>
Date: Wed, 22 Nov 2023 07:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3d76daea-2f07-48f9-865b-81e01964704d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Roger,

On 21.11.23 22:56, Roger Quadros wrote:
> Hi,
> 
> On 15/11/2023 13:36, Heiko Schocher wrote:
>> Hello Roger,
>>
>> On 15.11.23 12:09, Roger Quadros wrote:
>>>
>>>
>>> On 15/11/2023 07:40, Heiko Schocher wrote:
>>>> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>>>>
>>>> broke AM335x based boards booting from NAND with ECC BCH8 code.
>>>>
>>>> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch()
>>>> in SPL restores correct SPL nand_read_page functionality.
>>>>
>>>> Tested on draco thuban board.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>>
>>>> ---
>>>> fix NAND boot for BCH8 based TI AM335x boards
>>>>
>>>> Fix is based on series from Enrico:
>>>>
>>>> https://lists.denx.de/pipermail/u-boot/2023-November/536793.html
>>>>
>>>> and fixes NAND boot for the draco thuban board. But this patch
>>>> apply also without the patches from above patchseries, see
>>>> azure build:
>>>>
>>>> https://dev.azure.com/hs0298/hs/_build/results?buildId=111&view=results
>>>>
>>>> which is clean.
>>>>
>>>> Above commit seems to change only U-Boot code and did not
>>>> adapt am335x_spl_bch.c, which breaks nand_read_page in SPL
>>>> code for AM335x based boards. So use in SPL "old" hw setup
>>>> and reading page from NAND in SPL works again.
>>>>
>>>>
>>>>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
>>>> index 1a5ed0de31..c9b66dadbd 100644
>>>> --- a/drivers/mtd/nand/raw/omap_gpmc.c
>>>> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
>>>> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>>>>  		nand->ecc.strength	= 8;
>>>>  		nand->ecc.size		= SECTOR_BYTES;
>>>>  		nand->ecc.bytes		= 14;
>>>> +#if defined(CONFIG_SPL_BUILD)
>>>> +		nand->ecc.hwctl		= omap_enable_hwecc;
>>>
>>> I don't think this is correct. omap_enable_hwecc does not setup
>>> the BCH settings and should be used only for 1-bit ECC i.e. OMAP_ECC_HAM1_CODE_*
>>>
>>> I'm sure it will break the boards not using
>>> CONFIG_SPL_NAND_AM33XX_BCH which is
>>> pretty much most TI boards that are not AM335x.
>>>
>>> Now, I need to identify why AM335x NAND is broken.
>>
>> Yes, I played with setting up stuff in drivers/mtd/nand/raw/am335x_spl_bch.c
>> but failed ...
>>
>> If I can help you testing, feel free to ask!
> 
> OK. So I did some tests and we are ending up in a different ECC config on AM335x.
> The ecc.steps is not set at all by the driver (it is at 0) and so so nsectors gets
> set to -1 and so 7 (0b111) which is wrong.
> 
> static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd,
> 						 int mode)
> {
> ...
> 	case OMAP_ECC_BCH8_CODE_HW:
> 		bch_type = 1;
> 		nsectors = chip->ecc.steps;
> ...
> 	/* BCH configuration */
> 	val = ((1			<< 16) | /* enable BCH */
> 	       (bch_type		<< 12) | /* BCH4/BCH8/BCH16 */
> 	       (wr_mode			<<  8) | /* wrap mode */
> 	       (dev_width		<<  7) | /* bus width */
> -->	       (((nsectors - 1) & 0x7)	<<  4) | /* number of sectors */
> 	       (info->cs		<<  1) | /* ECC CS */
> 	       (0x1));	
> ...
> }
> 
> setting chip->ecc.steps needs to be fixed in original commit 
> c3754e9cc23a ("omap_gpmc: BCH8 support (ELM based)")
> 
> But this will still not fix the issue for AM335x as am335x_spl_bch.c
> expects 1 sector at a time ECC calculation.

Yep...

> I also realized that the error correction logic (ELM) is not in page mode
> and so is not suitable for multi-sector error correction.

Okay!

> This means we have to revert the commit
> 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
> 
> and go back to 1 sector BCH ECC generation and correction.

Uff... I did exactly this to get it working (in first shot) but feared
sending such a "drastic" patch, as I had the hope to fix "AM335x SPL code",
as U-Boot part works on AM335x...

What I wonder is that above commit introduced "omap_calculate_ecc_bch_multi"
but did not use it in SPL! For U-Boot code omap_calculate_ecc_bch_multi is
used in drivers/mtd/nand/raw/omap_gpmc.c omap_read_page_bch()

but drivers/mtd/nand/raw/am335x_spl_bch.c has no adaption ... so I tried
to adapt this file... but did not get it up working without digging
very deep into it...


> I will send a patch fix in a day or two after doing some tests at my end.

Okay, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
