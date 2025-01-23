Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9246C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 09:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FA880214;
	Thu, 23 Jan 2025 10:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k7/91Y52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6E080243; Thu, 23 Jan 2025 10:40:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D0E80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 278565C4BFA;
 Thu, 23 Jan 2025 09:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DA0C4CED3;
 Thu, 23 Jan 2025 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737625226;
 bh=WQThlEiRYS7D7/zWZKzzhpFZQxv3QIzK3OAPN0ySXy8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k7/91Y52eXu9z1KoWfYcSPdSksMB0Ha8UjrA3WABy66z05DvYi4k08LkF6GdOsuuW
 6yQ2FLxOXct77bE2JG/WrglPb72W+wcic8Xq/lorcP2G03KrCdodfWljkHqqx5mOeN
 Q0F4Ar0ydVuEgoJrRgWV8zQi/OWcaY8T/WPxteN3c9b2i+RZWR401r/R62k4GjNGd/
 JFdOH3+LQu0a8HatoK4i27UXVsvDWhA0XFQoyN6cGHKXL2tuW1+Au/SNjxP0kPwHPn
 wxF6+jEbK8aA0/I9r+sOA+4rH+VYm61/63tm27IdSuUfie2nmbJ+UMHFc97JDL70Lc
 luWreHOkJUdcQ==
Message-ID: <8bf7f805-a7d5-4324-b939-319b5d12ba6d@kernel.org>
Date: Thu, 23 Jan 2025 11:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm: mach-k3: j721s2_init: Probe AM65 CPSW NUSS for
 R5/A72 SPL
To: Chintan Vankar <c-vankar@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: srk@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-5-c-vankar@ti.com>
 <d2c8cde1-891f-470a-abd9-598847a9078f@kernel.org>
 <73bcc845-d35b-4f3a-9529-41310cfe5707@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <73bcc845-d35b-4f3a-9529-41310cfe5707@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

+Vignesh & Siddharth

On 22/01/2025 10:53, Chintan Vankar wrote:
> 
> 
> On 07/01/25 20:03, Roger Quadros wrote:
>>
>>
>> On 07/01/2025 11:38, Chintan Vankar wrote:
>>> To support Ethernet boot on AM68-SK, probe AM65 CPSW NUSS driver in
>>> board_init_f().
>>>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>   arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> index 6ce3eb87efb..7208bee5785 100644
>>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> @@ -329,6 +329,16 @@ void board_init_f(ulong dummy)
>>>         setup_qos();
>>>   +    if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
>>> +        spl_boot_device() == BOOT_DEVICE_ETHERNET) {
>>> +        struct udevice *cpswdev;
>>> +
>>> +        ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
>>> +                          &cpswdev);
>>> +        if (ret)
>>> +            printf("Failed to probe am65_cpsw_nuss driver..\n");
>>> +    }
>>> +
>>
>> This looks like a hack. Please find out why the Ethernet driver is not being
>> probed when SPL tries to load image over net.
>>
> 
> Hello Roger,
> 
> The driver is defined as UCLASS_MISC which should be probed explicitly,

The driver was originally built without UCLASS_MISC, but

commit 38922b1f4acc ("net: ti: am65-cpsw: Add support for multi port independent MAC mode")

Added UCLASS_MISC and states there that 
" Since top level driver is now UCLASS_MISC, board files would need to
  instantiate this driver explicitly."

Not an elegant solution. So we need to fix something in the am65-cpuss driver.

Looking at drivers/net/mvpp2.c we can see a possible solution.
1) don't define .probe for the parent driver (UCLASS_MISC). Instead define .bind
that will scan the device tree for ports and bind the port device and driver.
e.g. see mvpp2_base_bind()
2) in port driver .probe (UCLASS_ETH), if parent has not been probed
then call the parent probe (am65_cpsw_probe_nuss) . Also set a flag so parent probe
only gets called once.
3) update all board files no not explicitly probe the am65-cpsw UCLASS_MISC driver.

Siddharth / Vignesh do you see any issues with this solution?

> I have discussed the same with Nishanth in following thread:
> https://lore.kernel.org/all/ee1d16fd-b99b-4b07-97bb-a896e179157a@ti.com/
> 
>> We have the following defined at the am65-cpsw-nuss driver.
>>
>> U_BOOT_DRIVER(am65_cpsw_nuss) = {
>>          .name   = "am65_cpsw_nuss",
>>          .id     = UCLASS_MISC,
>>          .of_match = am65_cpsw_nuss_ids,
>>          .probe  = am65_cpsw_probe_nuss,
>>          .priv_auto = sizeof(struct am65_cpsw_common),
>> };
>>
>> U_BOOT_DRIVER(am65_cpsw_nuss_port) = {
>>          .name   = "am65_cpsw_nuss_port",
>>          .id     = UCLASS_ETH,
>>          .probe  = am65_cpsw_port_probe,
>>          .ops    = &am65_cpsw_ops,
>>          .priv_auto      = sizeof(struct am65_cpsw_priv),
>>          .plat_auto      = sizeof(struct eth_pdata),
>>          .flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
>> };
>>
>> It looks like am65_cpsw_probe_nuss() is not being invoked for you.
>>
>> Can you please check if am65_cpsw_port_probe() was invoked?
>> If yes but am65_cpsw_probe_nuss() was not then we need to fix the
>> DM hierarchy for AM65_CPSW?
>>
> None of the probe function is getting invoked here, since we need

That is strange. am65_cpsw_probe_nuss() should be called at least for
port 0 since it is defined as UCLASS_ETH.

> Ethernet functionality here we need to probe function in board_init_f().
> We have discussed the same at here:
> https://lore.kernel.org/r/d68c8045-116a-49c0-9e74-d6a366e6f008@kernel.org/#t
> 
> 
>>>       if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
>>>           ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
>>>                             &dev);
>>

-- 
cheers,
-roger

