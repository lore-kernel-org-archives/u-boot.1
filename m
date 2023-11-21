Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C2C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 21:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25EA87582;
	Tue, 21 Nov 2023 22:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r3t7cAOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39448875C3; Tue, 21 Nov 2023 22:56:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1E08744F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 22:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 45E1BCE119A;
 Tue, 21 Nov 2023 21:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC63C433C8;
 Tue, 21 Nov 2023 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700603783;
 bh=5wfX8K1p0Vxz2lneSzbxkc0OyVB3rE4zOCdQ/vZt29I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=r3t7cAOt0US8CUGhB81Zkey9dCH4OelEpwx8XMG8SqH2kWL6zYyVzLt4ZXSH00/08
 lmkssIMFs8bGAOYgG7ZIMVXHkjKzTJRY1XdNjS+kieZFicm7wwWPFSxGXZcKrademI
 DzlpXQtxdGefCPRaAfeF8cnJL7Y4CO/ErzWpT5p2w1MBIGUbU4BNBbrFigH0s21sHy
 9lrPrpHflRpcUx0oPWiIoK5Wbnu0QgM2LB+UVxPxF8/f76hwsRHw4R+0cJP/usOeRH
 6bgFBrI8327mWiVaDcPO7i3ONVpYl9/rirBor4BtKReFmTL+T0rv5DUCm8P1KEnwaZ
 jpbeqJk3VC8Lw==
Message-ID: <3d76daea-2f07-48f9-865b-81e01964704d@kernel.org>
Date: Tue, 21 Nov 2023 23:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
Content-Language: en-US
To: hs@denx.de, U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>,
 "Govindarajan, Sriramakrishnan" <srk@ti.com>
References: <20231115054044.3937543-1-hs@denx.de>
 <f21f052e-1b6d-45bc-8987-3b33eee7e09a@kernel.org>
 <0d68e932-f631-4154-4d2a-6cd2508da4bb@denx.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0d68e932-f631-4154-4d2a-6cd2508da4bb@denx.de>
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

Hi,

On 15/11/2023 13:36, Heiko Schocher wrote:
> Hello Roger,
> 
> On 15.11.23 12:09, Roger Quadros wrote:
>>
>>
>> On 15/11/2023 07:40, Heiko Schocher wrote:
>>> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>>>
>>> broke AM335x based boards booting from NAND with ECC BCH8 code.
>>>
>>> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch()
>>> in SPL restores correct SPL nand_read_page functionality.
>>>
>>> Tested on draco thuban board.
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>
>>> ---
>>> fix NAND boot for BCH8 based TI AM335x boards
>>>
>>> Fix is based on series from Enrico:
>>>
>>> https://lists.denx.de/pipermail/u-boot/2023-November/536793.html
>>>
>>> and fixes NAND boot for the draco thuban board. But this patch
>>> apply also without the patches from above patchseries, see
>>> azure build:
>>>
>>> https://dev.azure.com/hs0298/hs/_build/results?buildId=111&view=results
>>>
>>> which is clean.
>>>
>>> Above commit seems to change only U-Boot code and did not
>>> adapt am335x_spl_bch.c, which breaks nand_read_page in SPL
>>> code for AM335x based boards. So use in SPL "old" hw setup
>>> and reading page from NAND in SPL works again.
>>>
>>>
>>>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
>>> index 1a5ed0de31..c9b66dadbd 100644
>>> --- a/drivers/mtd/nand/raw/omap_gpmc.c
>>> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
>>> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>>>  		nand->ecc.strength	= 8;
>>>  		nand->ecc.size		= SECTOR_BYTES;
>>>  		nand->ecc.bytes		= 14;
>>> +#if defined(CONFIG_SPL_BUILD)
>>> +		nand->ecc.hwctl		= omap_enable_hwecc;
>>
>> I don't think this is correct. omap_enable_hwecc does not setup
>> the BCH settings and should be used only for 1-bit ECC i.e. OMAP_ECC_HAM1_CODE_*
>>
>> I'm sure it will break the boards not using
>> CONFIG_SPL_NAND_AM33XX_BCH which is
>> pretty much most TI boards that are not AM335x.
>>
>> Now, I need to identify why AM335x NAND is broken.
> 
> Yes, I played with setting up stuff in drivers/mtd/nand/raw/am335x_spl_bch.c
> but failed ...
> 
> If I can help you testing, feel free to ask!

OK. So I did some tests and we are ending up in a different ECC config on AM335x.
The ecc.steps is not set at all by the driver (it is at 0) and so so nsectors gets
set to -1 and so 7 (0b111) which is wrong.

static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd,
						 int mode)
{
...
	case OMAP_ECC_BCH8_CODE_HW:
		bch_type = 1;
		nsectors = chip->ecc.steps;
...
	/* BCH configuration */
	val = ((1			<< 16) | /* enable BCH */
	       (bch_type		<< 12) | /* BCH4/BCH8/BCH16 */
	       (wr_mode			<<  8) | /* wrap mode */
	       (dev_width		<<  7) | /* bus width */
-->	       (((nsectors - 1) & 0x7)	<<  4) | /* number of sectors */
	       (info->cs		<<  1) | /* ECC CS */
	       (0x1));	
...
}

setting chip->ecc.steps needs to be fixed in original commit 
c3754e9cc23a ("omap_gpmc: BCH8 support (ELM based)")

But this will still not fix the issue for AM335x as am335x_spl_bch.c
expects 1 sector at a time ECC calculation.

I also realized that the error correction logic (ELM) is not in page mode
and so is not suitable for multi-sector error correction.

This means we have to revert the commit
04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")

and go back to 1 sector BCH ECC generation and correction.

I will send a patch fix in a day or two after doing some tests at my end.

-- 
cheers,
-roger
