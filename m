Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C2CC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 04:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD74981951;
	Tue, 28 Jan 2025 05:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o1LSQvKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F8C8197D; Tue, 28 Jan 2025 05:10:07 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DB68187B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 05:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S49okp1903387
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 22:09:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738037390;
 bh=JtoFoFyPxaadvTZpmArZ3ksUzPJFW4f5gu+vWX6otLc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=o1LSQvKWdkavx859CWhOYYvvKfTkALxJqORn8bkdZbBI6+Wn7JOZMJKy1L+u3nKZC
 AauABmAaXzy8q3fxqo01cWuU3vN4KjFv3aEaQHk6mLmmdAQMpbRt86/xXHODANNmgI
 HxC0jHsWeBtlT9Xrq9KwQK9TXuaEjs5VJ+3/Yotc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S49onJ002095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 22:09:50 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 22:09:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 22:09:49 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S49gD8044257;
 Mon, 27 Jan 2025 22:09:43 -0600
Message-ID: <2ded45c3-f452-42b5-ae67-a1a14e3138ef@ti.com>
Date: Tue, 28 Jan 2025 09:39:41 +0530
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
 <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <srk@ti.com>, <danishanwar@ti.com>, <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-5-c-vankar@ti.com>
 <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
 <73bcc845-d35b-4f3a-9529-41310cfe5707@ti.com>
 <8bf7f805-a7d5-4324-b939-319b5d12ba6d@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <8bf7f805-a7d5-4324-b939-319b5d12ba6d@kernel.org>
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



On 23/01/25 15:10, Roger Quadros wrote:
> +Vignesh & Siddharth
> 
> On 22/01/2025 10:53, Chintan Vankar wrote:
>>
>>
>> On 07/01/25 20:03, Roger Quadros wrote:
>>>
>>>
>>> On 07/01/2025 11:38, Chintan Vankar wrote:
>>>> To support Ethernet boot on AM68-SK, probe AM65 CPSW NUSS driver in
>>>> board_init_f().
>>>>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> ---
>>>>    arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>>> index 6ce3eb87efb..7208bee5785 100644
>>>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>>>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>>> @@ -329,6 +329,16 @@ void board_init_f(ulong dummy)
>>>>          setup_qos();
>>>>    +    if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>>>> +        spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>>>> +        struct udevice *cpswdev;
>>>> +
>>>> +        ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>>>> +                          &cpswdev);
>>>> +        if (ret)
>>>> +            printf("Failed to probe am65_cpsw_nuss driver..\n");
>>>> +    }
>>>> +
>>>
>>> This looks like a hack. Please find out why the Ethernet driver is not being
>>> probed when SPL tries to load image over net.
>>>
>>
>> Hello Roger,
>>
>> The driver is defined as UCLASS_MISC which should be probed explicitly,
> 
> The driver was originally built without UCLASS_MISC, but
> 
> commit 38922b1f4acc ("net: ti: am65-cpsw: Add support for multi port independent MAC mode")
> 
> Added UCLASS_MISC and states there that
> " Since top level driver is now UCLASS_MISC, board files would need to
>    instantiate this driver explicitly."
> 
> Not an elegant solution. So we need to fix something in the am65-cpuss driver.
> 
> Looking at drivers/net/mvpp2.c we can see a possible solution.
> 1) don't define .probe for the parent driver (UCLASS_MISC). Instead define .bind
> that will scan the device tree for ports and bind the port device and driver.
> e.g. see mvpp2_base_bind()
> 2) in port driver .probe (UCLASS_ETH), if parent has not been probed
> then call the parent probe (am65_cpsw_probe_nuss) . Also set a flag so parent probe
> only gets called once.
> 3) update all board files no not explicitly probe the am65-cpsw UCLASS_MISC driver.
> 
> Siddharth / Vignesh do you see any issues with this solution?
> 

Hello Roger, I have tried to understand your approach, I will work on
that. But for now, is it possible to merge the seris with the existing
approach ?

>> I have discussed the same with Nishanth in following thread:
>> https://lore.kernel.org/all/ee1d16fd-b99b-4b07-97bb-a896e179157a@ti.com/
>>
>>> We have the following defined at the am65-cpsw-nuss driver.
>>>
>>> U_BOOT_DRIVER(am65_cpsw_nuss) = {
>>>           .name   = "am65_cpsw_nuss",
>>>           .id     = UCLASS_MISC,
>>>           .of_match = am65_cpsw_nuss_ids,
>>>           .probe  = am65_cpsw_probe_nuss,
>>>           .priv_auto = sizeof(struct am65_cpsw_common),
>>> };
>>>
>>> U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
>>>           .name   = "am65_cpsw_nuss_port",
>>>           .id     = UCLASS_ETH,
>>>           .probe  = am65_cpsw_port_probe,
>>>           .ops    = &am65_cpsw_ops,
>>>           .priv_auto      = sizeof(struct am65_cpsw_priv),
>>>           .plat_auto      = sizeof(struct eth_pdata),
>>>           .flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
>>> };
>>>
>>> It looks like am65_cpsw_probe_nuss() is not being invoked for you.
>>>
>>> Can you please check if am65_cpsw_port_probe() was invoked?
>>> If yes but am65_cpsw_probe_nuss() was not then we need to fix the
>>> DM hierarchy for AM65_CPSW?
>>>
>> None of the probe function is getting invoked here, since we need
> 
> That is strange. am65_cpsw_probe_nuss() should be called at least for
> port 0 since it is defined as UCLASS_ETH.
> 

am65_cpsw_probe_nuss() is defined as UCLASS_MISC and not UCLASS_ETH, it
will get invoked if declared as UCLASS_ETH, as per your suggestion above
it will need driver changes to invoke the probe function without being
called explicitly and work properly.

>> Ethernet functionality here we need to probe function in board_init_f().
>> We have discussed the same at here:
>> https://lore.kernel.org/r/d68c8045-116a-49c0-9e74-d6a366e6f008@kernel.org/#t
>>
>>
>>>>        if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
>>>>            ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
>>>>                              &dev);
>>>
> 
