Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 18:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A4987495;
	Thu,  9 Nov 2023 19:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pGvVETMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFB887015; Thu,  9 Nov 2023 19:45:03 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C97874C3
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 19:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A9IivKt116889;
 Thu, 9 Nov 2023 12:44:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699555497;
 bh=AS+m+BbagHR4j1HyhoP9jrL+5ksc6bO0W//Im21dcs8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pGvVETMsjI9NzJOv6J/jFP/KCP6v6Tg0QHzdJb5fsl40g693iFOjZ+PKjQbwlRdW5
 mTbMcvXliFcQdIMMUXPXI6Jpw6pWmWOpxyWfb/uCLV52M17/ik4swxQS74PkdW6yj8
 D43RAoYtTAmfAroJk2IoBySINlwLxhIR7laN4MJg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A9IivTq029579
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Nov 2023 12:44:57 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 12:44:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 12:44:56 -0600
Received: from [10.250.33.216] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A9Iiui4104254;
 Thu, 9 Nov 2023 12:44:56 -0600
Message-ID: <e27d44a1-03c2-44cf-857f-947c5f4c4796@ti.com>
Date: Thu, 9 Nov 2023 12:44:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] arm: mach-k3: Enable icache on am625 to boot
 faster
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Joao Paulo Goncalves
 <jpaulo.silvagoncalves@gmail.com>
CC: Bryan Brattlof <bb@ti.com>, Suman Anna <s-anna@ti.com>, Joao Paulo
 Goncalves <joao.goncalves@toradex.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20231109140958.1093235-1-joao.goncalves@toradex.com>
 <20231109173741.cuxbq4rtu4nhvath@pagan>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231109173741.cuxbq4rtu4nhvath@pagan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11/9/23 11:37 AM, Nishanth Menon wrote:
> On 11:09-20231109, Joao Paulo Goncalves wrote:
>> Enable the am625 instruction cache on SPL and U-boot earlier for the A53
>> to execute code a bit faster. For normal boot flow, it was possible to
>> gain about 2 seconds on boot time.
>>
>> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>> ---
>> Hello all,
>>
>> We are trying to optimize boot time on our AM62 devices and on TI community
>> forum [1] someone advised to enable ICACHE for am625. We enabled it, tested and got
>> around 2 seconds faster boot on storage media and about 5 seconds with DFU
>> for downloading images from A53 SPL. However, we don't know if this is the correct
>> solution and want more comments on this or why the ICACHE was not enabled by TI in
>> the first place.
>>
>> [1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot
>>
>> Regards,
>> Joao Paulo Goncalves
>>
>>   arch/arm/mach-k3/am625_init.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>> index 8fa36f7b91..d665d07b0b 100644
>> --- a/arch/arm/mach-k3/am625_init.c
>> +++ b/arch/arm/mach-k3/am625_init.c
>> @@ -210,6 +210,9 @@ void board_init_f(ulong dummy)
>>   			panic("DRAM init failed: %d\n", ret);
>>   	}
>>   	spl_enable_dcache();
>> +
>> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && !IS_ENABLED(CONFIG_SYS_ICACHE_OFF))
>> +		icache_enable();
>>   }
>>   
>>   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>> -- 
>> 2.34.1
> 
> Just noticed that icache_enable was missed for all of k3 as well - I
> suspect this is a miss rather than anything consciously done. btw
> icache_enable is already wrapped correctly under CONFIG_SYS_ICACHE_OFF in
> cache_v8.c
> 

For U-Boot proper, both I/D caches are enabled early in board_init_r().
Oddly the SPL version of this function does not do that. Some boards seem
to work around this by adding it manually, others must have missed this.
Maybe due to armv7/start.S doing this for us already, but not armv8/start.S..

We enable Icache in SPL for our CPU_V7R case inside setup_mpu_regions()(??)
We also enable Dcache in spl_enable_dcache(), maybe this should be
renamed spl_enable_cache() and it call enable_caches() which enables
both. Just be careful to invalidate the icache when enabling after
relocation.

This would be temporary, better solution would be to add it to the
SPL common board_init_r() to match the U-Boot one, that way all these
platforms wouldn't need to do it in their current inconsistent ways.

Andrew
