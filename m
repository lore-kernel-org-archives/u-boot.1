Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C029CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 06:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D143A807B1;
	Mon,  6 Oct 2025 08:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OJoaQ8qw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A72808AF; Mon,  6 Oct 2025 08:11:47 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EC5800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 08:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5966BYdx3942344;
 Mon, 6 Oct 2025 01:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759731094;
 bh=y7o10WFghUicDsocfS9CWGq6jfkP7b6w8rUgZiBJDJs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OJoaQ8qw3FORs6MjzdPmonI5fjPGhz0u2/OBoieueoMpDsPHqrZH8neYfCtvBgu6A
 yQm+Beu6aZvYMKYVZ8YcRmzKd8PwmK1B2bt+4PupuaCFbGLU5mI9PI3ugVfvnzGoG7
 2Rj2imgx0bazOy+ey0Vab5XG/T4jwmzzmIAPnSlc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5966BYKI3103305
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 01:11:34 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 01:11:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 01:11:34 -0500
Received: from [172.24.31.60] (ltd1nqfk3.dhcp.ti.com [172.24.31.60])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5966BVvG2978444;
 Mon, 6 Oct 2025 01:11:32 -0500
Message-ID: <7e5994ca-fc77-46e5-89f6-18213a2231ff@ti.com>
Date: Mon, 6 Oct 2025 11:41:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: ti: Tighten some TI clock driver dependencies
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20250926153132.3680837-1-trini@konsulko.com>
 <99f08016-a451-498d-987c-d392d3e3e29c@ti.com>
 <20251001153557.GJ6093@bill-the-cat>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <20251001153557.GJ6093@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 10/1/2025 9:05 PM, Tom Rini wrote:
> On Wed, Oct 01, 2025 at 05:08:46PM +0530, Chawdhry, Manorit wrote:
>> Hi Tom,
>>
>> On 9/26/2025 9:01 PM, Tom Rini wrote:
>>> A few of the TI clock drivers cannot link without access to TI platform
>>> specific drivers and headers.  Express those requirements in Kconfig as
>>> well.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Lukasz Majewski <lukma@denx.de>
>>> Cc: Sean Anderson <seanga2@gmail.com>
>>> Cc: Manorit Chawdhry <m-chawdhry@ti.com>
>>> Cc: Andrew Davis <afd@ti.com>
>>> Cc: Udit Kumar <u-kumar1@ti.com>
>>> ---
>>>    drivers/clk/ti/Kconfig | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
>>> index e0f15f57f826..ba658c741c4d 100644
>>> --- a/drivers/clk/ti/Kconfig
>>> +++ b/drivers/clk/ti/Kconfig
>>> @@ -18,19 +18,19 @@ config CLK_TI_CTRL
>>>    config CLK_TI_DIVIDER
>>>    	bool "TI divider clock driver"
>>> -	depends on CLK && OF_CONTROL && CLK_CCF
>>> +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
>>>    	help
>>>    	  This enables the divider clock driver support on TI's SoCs.
>>>    config CLK_TI_GATE
>>>    	bool "TI gate clock driver"
>>> -	depends on CLK && OF_CONTROL
>>> +	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
>>>    	help
>>>    	  This enables the gate clock driver support on TI's SoCs.
>>>    config CLK_TI_MUX
>>>    	bool "TI mux clock driver"
>>> -	depends on CLK && OF_CONTROL && CLK_CCF
>>> +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
>>>    	help
>>>    	  This enables the mux clock driver support on TI's SoCs.
>>
>> Do other Kconfigs' work in this file without access to TI platform specific
>> drivers and headers? am wondering that every Kconfig in this file would
>> ideally be TI specific only..
> 
> Ideally, long term we could build all of this on sandbox with
> allyesconfig and get static analysis done to it easily. But also yes,
> after this second patch here every driver has a ARCH dependency because
> the ones that wouldn't compile without a header caused others to fail to
> link. This also tells me that some of these options should be select'd
> by others, rather than everything being a question.
> 

Ah okay, understood. Though I was just trying to understand who were the 
ones trying to use it, as I just see these configs being used in 
`am335x_guardian_defconfig` only. I would assume that until someone 
enables it explicitly ( and can't think of why would they if these are 
TI specific and also in TI specific folders )

Though given that you mentioned sandbox testing, I think we should 
capture the motivation in the commit message too for this ( as otherwise 
at least for me it feels confusing as to why would someone end up and 
start using a TI specific driver when it's in TI specific folder as well )

Though just to experiment, I tried a quick build test with adding these 
configs on j7200 R5 defconfig and can see it fail for them even. So this 
patch looks very specific to ARCH_OMAP2PLUS itself so might be good to 
capture that in the commit message too IMO [ as even TI related 
platforms fail to link ]

I think would suggest commit message improvements only, with that -

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit





