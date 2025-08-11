Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B64C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 11:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CC0832DD;
	Mon, 11 Aug 2025 13:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZaaSolHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D7382FC7; Mon, 11 Aug 2025 13:43:21 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D6283390
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BBhGC31148355;
 Mon, 11 Aug 2025 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754912596;
 bh=tq4euBFOswTVX1VJpO+1TNmkBvf3zETyg7si4H5WIbg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZaaSolHUCQZIJFR0dPx8k9E/FlyznZezJxqzypxpUKzcai+y5gU/GQF2Z8JgQuDqQ
 jg2rvZQp3IWEFhOdMzTGvAcRgO3u83s14vKY1FNXgbkGZDUX82ch2ZY4EcnX2yEUCa
 zvEd7tARUEgzZVKbt7p0YqGNjT38T77OIxyY0Tl8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BBhGum3019151
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 11 Aug 2025 06:43:16 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 06:43:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 06:43:15 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BBhDUD2796697;
 Mon, 11 Aug 2025 06:43:13 -0500
Message-ID: <3e769027-69ff-4b10-9c50-0743044b2d91@ti.com>
Date: Mon, 11 Aug 2025 17:13:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ram: k3-ddrss: Use DDR address instead of system
 address for ecc_regions
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <bb@ti.com>,
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <sabiya.d@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-2-n-francis@ti.com>
 <da36b723-14d4-4f82-a8d4-43abd4683d4f@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <da36b723-14d4-4f82-a8d4-43abd4683d4f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Udit,

On 07/08/25 09:51, Kumar, Udit wrote:
> Hello Neha
> 
> On 7/30/2025 7:07 PM, Neha Malcom Francis wrote:
>> Let ecc_regions[x].start reflect the start of the ECC region in terms of
>> DDR addressing rather than system addressing. This will make it easier
>> to extend the usage of the same ecc_regions structure for multi-DDR
>> systems as well.
> 
> comments are not inline with patch contents ,
> 
> LTM, you are doing clean up how ecc_regions[0].start is being used.

Yes that is what we are doing.

> 
> Originally ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
> 
> and while using it  we did (ecc_region_start - ddrss->ddr_bank_base[0])
> 
> other then that I don't see we are using ecc_region_start anywhere.

We will use it later on which is why the message says we are changing
what this variable means so that we can use it in later for multi-DDR
systems. Sorry I didn't understand what exactly needs to change in the
commit message here?

Maybe s/Let/Change will make it a little more easier to understand?

"Change ecc_regions[x].start to reflect the start of the ECC region in
terms of DDR addressing rather than system addressing..."

> 
> With update in commit message , Please use
> 
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> 
> 
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/ram/k3-ddrss/k3-ddrss.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c
>> b/drivers/ram/k3-ddrss/k3-ddrss.c
>> index 6590d57ad84..7389fd8b82f 100644
>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>> @@ -752,7 +752,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct
>> k3_ddrss_desc *ddrss)
>>       u32 val;
>>         /* Only Program region 0 which covers full ddr space */
>> -    k3_ddrss_set_ecc_range_r0(base, ecc_region_start -
>> ddrss->ddr_bank_base[0], ecc_range);
>> +    k3_ddrss_set_ecc_range_r0(base, ecc_region_start, ecc_range);
>>         /* Enable ECC, RMW, WR_ALLOC */
>>       writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
>> @@ -817,7 +817,7 @@ static int k3_ddrss_probe(struct udevice *dev)
>>           k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>>             /* Always configure one region that covers full DDR space */
>> -        ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
>> +        ddrss->ecc_regions[0].start = 0;
>>           ddrss->ecc_regions[0].range = ddrss->ddr_ram_size -
>> ddrss->ecc_reserved_space;
>>           k3_ddrss_lpddr4_ecc_init(ddrss);
>>       }

-- 
Thanking You
Neha Malcom Francis
