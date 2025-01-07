Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D69E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 10:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCB18036D;
	Tue,  7 Jan 2025 11:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iisFub7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF1B8036D; Tue,  7 Jan 2025 11:37:05 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477CF801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 11:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 507AawFJ2842638
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Jan 2025 04:36:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736246218;
 bh=rWqBlnsVlRE/si+vv9ODeA25y/egVnabwVwDF23cPVI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iisFub7T1Z/uiSTMrj3uF4hK2qLg7Xr8nvy6lE9fI74q7MBF1T0UZEbf6mjDmL5e1
 jCE2cJ93YToKWnypGoPvSFYDH2u5ybC9uOFQ8G3nw/raQ8ikfvUKTIbDFgdZse8mhY
 5VZtbS11epRveVKQQFg5KmR526UD+ofwP3WxsLIE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507Aawlx102458;
 Tue, 7 Jan 2025 04:36:58 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 04:36:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 04:36:58 -0600
Received: from [10.24.72.222] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.72.222])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507Aau3h102994;
 Tue, 7 Jan 2025 04:36:56 -0600
Message-ID: <b5854d61-2ba1-42d7-8e53-d3a9ad07f9a3@ti.com>
Date: Tue, 7 Jan 2025 16:06:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-k3: j784s4_init: Set CTRL_MMR for
 AUDIO_REFCLK1 clk_sel
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <sabiya.d@ti.com>
References: <20250106100400.93799-1-j-choudhary@ti.com>
 <19b20f10-9718-4c37-bea9-bd36bfff0125@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <19b20f10-9718-4c37-bea9-bd36bfff0125@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hello Andrew,

On 06/01/25 20:42, Andrew Davis wrote:
> On 1/6/25 4:04 AM, Jayesh Choudhary wrote:
>> The default value for the mux to select the parent clock,
>> AUDIO_REFCLK1_CTRL_CLK_SEL is '11111' (31) but the mux input for 31
>> is marked as 'Reserved' so the ti-sci-clk call for get-parent fails.
>> Mark it to a valid value, '11100' (28) for MAIN_PLL4_HSDIV2_CLKOUT
>> to get rid of the linux failures during boot-time like:
> 
> So the default value of the mux isn't known by firmware? Sounds like
> a firmware issue..
> 
> No issue with using the bootloader to making the hardware's default state
> more sane. Maybe just add a comment above the writel() line as right now
> this is just writing a magic value to a magic address.

Will add the comments in v2.

Thanks,
Jayesh

> 
> Andrew
> 
>> "[    1.573193] ti-sci-clk 44083000.system-controller:clock-controller:
>>   get-parent failed for dev=157, clk=34, ret=-19"
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/j784s4/j784s4_init.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c 
>> b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> index 8a41cd3bb5..787cf6261e 100644
>> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
>> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> @@ -23,6 +23,9 @@
>>   #define J784S4_MAX_DDR_CONTROLLERS    4
>> +#define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL    0x001082e4
>> +#define AUDIO_REFCLK1_DEFAULT            0x1c
>> +
>>   /* NAVSS North Bridge (NB) */
>>   #define NAVSS0_NBSS_NB0_CFG_MMRS        0x03702000
>>   #define NAVSS0_NBSS_NB1_CFG_MMRS        0x03703000
>> @@ -201,6 +204,8 @@ void k3_spl_init(void)
>>           remove_fwl_configs(navss_cbass0_fwls, 
>> ARRAY_SIZE(navss_cbass0_fwls));
>>       }
>> +    writel(AUDIO_REFCLK1_DEFAULT, 
>> (uintptr_t)CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL);
>> +
>>       /* Output System Firmware version info */
>>       k3_sysfw_print_ver();
>>   }
