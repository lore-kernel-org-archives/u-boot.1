Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA4C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 11:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B174870FC;
	Wed, 15 Nov 2023 12:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700048225;
	bh=U0DNSDDHUM88/jL/Sp6H3pCa81YutGth9e6XL+NpIsw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sY1+wauHuoE36lCk/MjJy3d5jFACWPpICsePBBT0O5FXcYGwQrhSmLnfWNAO30JJB
	 CfUtJyC/EObB+T8auhgqrWNshigatcX65uH1dao45DWrbZevKPc31MwO8R0iEktojH
	 e+/eltiw5MKkN3YBon/4j2PbzGFgo74YmScq2wLqPqF1B/Vrf9RTVUl4n3napl/YOI
	 ShTiwaa8b00ck430B+TwINrcArXCqS7EVBZoFvGtI7KIjyOe5pwybv5al5Dq2KWDYW
	 ESaVvj4POJGQ3O+cxmoznjm8KR1PUed6TWkI47Zxi1iUzq+QEG99u/5WF/5EBAnu57
	 JVS7K+u6kK2yw==
Received: from [192.168.1.107] (82-131-157-239.pool.digikabel.hu
 [82.131.157.239])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9A9A586A19;
 Wed, 15 Nov 2023 12:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700048223;
 bh=U0DNSDDHUM88/jL/Sp6H3pCa81YutGth9e6XL+NpIsw=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Vt53lnlDVnxvnx5lzcjftWJSRCN134HUYXZpG/EkkM5CWidtICVa+boecgCecqUYw
 4xj5BgdjxtOIAMk0F3MX2A7DR8QEmBJz60sHISrFlIlP26eQ+RKp7tBxSayUA34xJw
 6VZ3Jm3uLgdpLegVgKT1Tdn2C0hoM0sAZjWfMzj85ShI7jA5kdx9+ENzrW9xMuvMV3
 eJPppU44BwH4OK9A4ZSDLOsBj1sbaIJo0EtnXIUhVrIbXwylSOKETTyOOJStaiEVhd
 akXhiiwRM3swvp2P9WK7r3GeAKLZxB4LdmZhpRfwwLQrjVkaEVTJOI53MhQ2X9T4Gc
 QE2Po0BmOn1lg==
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
To: Roger Quadros <rogerq@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>
References: <20231115054044.3937543-1-hs@denx.de>
 <f21f052e-1b6d-45bc-8987-3b33eee7e09a@kernel.org>
From: Heiko Schocher <hs@denx.de>
Message-ID: <0d68e932-f631-4154-4d2a-6cd2508da4bb@denx.de>
Date: Wed, 15 Nov 2023 12:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f21f052e-1b6d-45bc-8987-3b33eee7e09a@kernel.org>
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

On 15.11.23 12:09, Roger Quadros wrote:
> 
> 
> On 15/11/2023 07:40, Heiko Schocher wrote:
>> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>>
>> broke AM335x based boards booting from NAND with ECC BCH8 code.
>>
>> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch()
>> in SPL restores correct SPL nand_read_page functionality.
>>
>> Tested on draco thuban board.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> ---
>> fix NAND boot for BCH8 based TI AM335x boards
>>
>> Fix is based on series from Enrico:
>>
>> https://lists.denx.de/pipermail/u-boot/2023-November/536793.html
>>
>> and fixes NAND boot for the draco thuban board. But this patch
>> apply also without the patches from above patchseries, see
>> azure build:
>>
>> https://dev.azure.com/hs0298/hs/_build/results?buildId=111&view=results
>>
>> which is clean.
>>
>> Above commit seems to change only U-Boot code and did not
>> adapt am335x_spl_bch.c, which breaks nand_read_page in SPL
>> code for AM335x based boards. So use in SPL "old" hw setup
>> and reading page from NAND in SPL works again.
>>
>>
>>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
>> index 1a5ed0de31..c9b66dadbd 100644
>> --- a/drivers/mtd/nand/raw/omap_gpmc.c
>> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
>> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
>>  		nand->ecc.strength	= 8;
>>  		nand->ecc.size		= SECTOR_BYTES;
>>  		nand->ecc.bytes		= 14;
>> +#if defined(CONFIG_SPL_BUILD)
>> +		nand->ecc.hwctl		= omap_enable_hwecc;
> 
> I don't think this is correct. omap_enable_hwecc does not setup
> the BCH settings and should be used only for 1-bit ECC i.e. OMAP_ECC_HAM1_CODE_*
> 
> I'm sure it will break the boards not using
> CONFIG_SPL_NAND_AM33XX_BCH which is
> pretty much most TI boards that are not AM335x.
> 
> Now, I need to identify why AM335x NAND is broken.

Yes, I played with setting up stuff in drivers/mtd/nand/raw/am335x_spl_bch.c
but failed ...

If I can help you testing, feel free to ask!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
