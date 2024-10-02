Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D86BCF3189
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 01:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5538388E97;
	Wed,  2 Oct 2024 03:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZI5E9QBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E746388EAC; Wed,  2 Oct 2024 03:15:35 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DB78860D
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 03:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4921FW76065994;
 Tue, 1 Oct 2024 20:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727831732;
 bh=RuO2RGPCOpu/PVGkXqooLPUH6nWu+UD/05r1LSpLnNc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZI5E9QBT3k92S12X4HCqn9gB3ubqcwY0iCZGkAII8B5PkcJXpzgBQFVYRXyhHz/OZ
 b+IkdRdk6J5lIZ8VfmBfPRxgwHSZf9enFHCFYCC2YcrnBWZxzaXZQCytIrPkXg9RxL
 jvTnHs50CxsP6pgwOHEezCb17OfM5HUe+wE+/CJo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921FW6J077284;
 Tue, 1 Oct 2024 20:15:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 20:15:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 20:15:31 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921FRt9114752;
 Tue, 1 Oct 2024 20:15:28 -0500
Message-ID: <b618ac7d-1432-4802-ac0f-7612088e6542@ti.com>
Date: Wed, 2 Oct 2024 06:45:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] arm: mach-k3: j721s2_init: Initialize AVS Class 0
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-5-5115d93cdeb2@ti.com>
 <9ea12c2e-3fbf-4d32-9702-a97852a8ccde@ti.com>
 <20241001084852.c4xc6y4c4gyunzmp@uda0497581>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241001084852.c4xc6y4c4gyunzmp@uda0497581>
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


On 10/1/2024 2:18 PM, Manorit Chawdhry wrote:
> Hi Udit,
>
> On 08:46-20240815, Kumar, Udit wrote:
>> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
>>> Initialize AVS Class 0.
>>>
>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>> ---
>>>    arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> index 05453fcad41a..5f5961a2c17a 100644
>>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>>> @@ -315,6 +315,9 @@ void do_dt_magic(void)
>>>    #ifdef CONFIG_SPL_BUILD
>>>    void board_init_f(ulong dummy)
>>>    {
>>> +	struct udevice *dev;
>>> +	int ret;
>>> +
>>>    	k3_spl_init();
>>>    #if defined(CONFIG_SPL_OF_LIST) && defined(CONFIG_TI_I2C_BOARD_DETECT)
>>>    	do_dt_magic();
>>> @@ -325,6 +328,13 @@ void board_init_f(ulong dummy)
>>>    		setup_navss_nb();
>>>    	setup_qos();
>>> +
>>> +	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
>>> +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
>>> +						  &dev);
>> Can we remove this ret, Something like
> I would say we can let this remain, general convention of this file is
> to have ret itself, I know it's only used in one place as of now but I
> feel keeping it consistent is better IMO.


I still suggest to remove non needed variable .

To make it consistent , please think to change at other places :)


>
> Regards,
> Manorit
