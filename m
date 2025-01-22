Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E540C0218C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 08:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B72A803B5;
	Wed, 22 Jan 2025 09:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YSSfDD3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EDEF80586; Wed, 22 Jan 2025 09:53:56 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9E380283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50M8rfmY984721
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 02:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737536021;
 bh=v3/DkFx6WVjq/o62rAQBGJ3YoLZnESa4AAB098SYX1c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YSSfDD3JivSFf1wFicSLX2yEu3utIWw+lmld41dfn0FozRXchcC6PRSIuNXSFmZT+
 SNB3l5uTXU50ePNu7pLQsw7u8oVqiAZqKk3lCAbRDrPrsWCOln5t9q8wHuS4bvpQTd
 E4UxKwRhy31QdVMUo4yiVPYrp5IIms+6u4hVS6UA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50M8rffc010989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jan 2025 02:53:41 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Jan 2025 02:53:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Jan 2025 02:53:40 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50M8rXCt023887;
 Wed, 22 Jan 2025 02:53:34 -0600
Message-ID: <73bcc845-d35b-4f3a-9529-41310cfe5707@ti.com>
Date: Wed, 22 Jan 2025 14:23:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm: mach-k3: j721s2_init: Probe AM65 CPSW NUSS for
 R5/A72 SPL
To: Roger Quadros <rogerq@kernel.org>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Andreas
 Dannenberg" <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>, "Jayesh
 Choudhary" <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>, "Aradhya
 Bhatia" <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Andrew
 Davis" <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-5-c-vankar@ti.com>
 <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
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



On 07/01/25 20:03, Roger Quadros wrote:
> 
> 
> On 07/01/2025 11:38, Chintan Vankar wrote:
>> To support Ethernet boot on AM68-SK, probe AM65 CPSW NUSS driver in
>> board_init_f().
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> index 6ce3eb87efb..7208bee5785 100644
>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> @@ -329,6 +329,16 @@ void board_init_f(ulong dummy)
>>   
>>   	setup_qos();
>>   
>> +	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>> +	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>> +		struct udevice *cpswdev;
>> +
>> +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>> +						  &cpswdev);
>> +		if (ret)
>> +			printf("Failed to probe am65_cpsw_nuss driver..\n");
>> +	}
>> +
> 
> This looks like a hack. Please find out why the Ethernet driver is not being
> probed when SPL tries to load image over net.
> 

Hello Roger,

The driver is defined as UCLASS_MISC which should be probed explicitly,
I have discussed the same with Nishanth in following thread:
https://lore.kernel.org/all/ee1d16fd-b99b-4b07-97bb-a896e179157a@ti.com/

> We have the following defined at the am65-cpsw-nuss driver.
> 
> U_BOOT_DRIVER(am65_cpsw_nuss) = {
>          .name   = "am65_cpsw_nuss",
>          .id     = UCLASS_MISC,
>          .of_match = am65_cpsw_nuss_ids,
>          .probe  = am65_cpsw_probe_nuss,
>          .priv_auto = sizeof(struct am65_cpsw_common),
> };
> 
> U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
>          .name   = "am65_cpsw_nuss_port",
>          .id     = UCLASS_ETH,
>          .probe  = am65_cpsw_port_probe,
>          .ops    = &am65_cpsw_ops,
>          .priv_auto      = sizeof(struct am65_cpsw_priv),
>          .plat_auto      = sizeof(struct eth_pdata),
>          .flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
> };
> 
> It looks like am65_cpsw_probe_nuss() is not being invoked for you.
> 
> Can you please check if am65_cpsw_port_probe() was invoked?
> If yes but am65_cpsw_probe_nuss() was not then we need to fix the
> DM hierarchy for AM65_CPSW?
>
None of the probe function is getting invoked here, since we need
Ethernet functionality here we need to probe function in board_init_f().
We have discussed the same at here:
https://lore.kernel.org/r/d68c8045-116a-49c0-9e74-d6a366e6f008@kernel.org/#t


>>   	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
>>   		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
>>   						  &dev);
> 
