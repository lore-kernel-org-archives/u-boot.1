Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E514EC8732
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 03:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C77A868D1;
	Fri,  8 Sep 2023 05:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JZDDDU7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE9E86682; Fri,  8 Sep 2023 05:14:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FB1869AC
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 05:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3883EI30000714;
 Thu, 7 Sep 2023 22:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694142858;
 bh=N5Ajo7ETNaEuFN5Rmx7QtXIohjiiQIwo0zPeTetiYUc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JZDDDU7YNKQXRNejoyZ4hzSl6XsdIqEIVBhgx5pm7RvbN8gSkaiIESd+7A0PHpLLy
 DNfIBOj9ANdESrxKmv/1A4GJD/mA+dDXfM7NNok+tE8h0vHjle/SUwX+a9+KtEFf3S
 a/NgtlzMvq6owo7JwdzRjT/Qrz8k3Yib0tH2byak=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3883EIDY064628
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 22:14:18 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 22:14:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 22:14:18 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3883EDV5103418;
 Thu, 7 Sep 2023 22:14:14 -0500
Message-ID: <535f60a7-34bb-40b9-14c0-65d0df4ecdc5@ti.com>
Date: Fri, 8 Sep 2023 08:44:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/7] arm: mach-k3: j721e_init: Move clk_k3 probe before
 loading TIFS
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-4-n-francis@ti.com>
 <20230907150301.ro3dnojvridbkfc2@gosling>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230907150301.ro3dnojvridbkfc2@gosling>
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

Hi Nishanth

On 07/09/23 20:33, Nishanth Menon wrote:
> On 19:44-20230907, Neha Malcom Francis wrote:
>> Since we need to configure required clocks before TIFS is loaded, move
>> clk_k3 driver probe before k3_sysfw_loader.
> 
> This needs further elaboration. what kind of clocks are we talking
> about? what is the call sequence that is involved that this is solving?
> 

When setting up our boot media to take in the TIFS binary (sysfw.itb) in legacy 
boot flow  (followed by J721E) what we end up doing is a get_timer() which by 
call stack will eventually call dm_timer_init() and then get our "tick-timer" in 
our case mcu_timer0. Now mcu_timer0 uses k3_clks (clock-controller) and k3_pds 
(power controller) from the dmsc node that forces probe of the ti_sci driver 
(for TIFS that hasn't been loaded yet!).

So we have two issues that need to be solved here, one of not having set the 
required devices and clocks before we even stat to probe their dependent 
devices, and two of handling how ti_sci reacts when TIFS is not even up yet. 
This patch solves the former.

Would this be excessive detailing for a commit message?

>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/mach-k3/j721e_init.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
>> index b6164575b7..b1f7e25ed0 100644
>> --- a/arch/arm/mach-k3/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e_init.c
>> @@ -228,6 +228,18 @@ void board_init_f(ulong dummy)
>>   	if (!ret)
>>   		pinctrl_select_state(dev, "default");
>>   
>> +	/*
>> +	 * Force probe of clk_k3 driver here to ensure basic default clock
>> +	 * configuration is always done.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
>> +		ret = uclass_get_device_by_driver(UCLASS_CLK,
>> +						  DM_DRIVER_GET(ti_clk),
>> +						  &dev);
>> +		if (ret)
>> +			panic("Failed to initialize clk-k3!\n");
>> +	}
>> +
>>   	/*
>>   	 * Load, start up, and configure system controller firmware. Provide
>>   	 * the U-Boot console init function to the SYSFW post-PM configuration
>> @@ -241,18 +253,6 @@ void board_init_f(ulong dummy)
>>   	do_dt_magic();
>>   #endif
>>   
>> -	/*
>> -	 * Force probe of clk_k3 driver here to ensure basic default clock
>> -	 * configuration is always done.
>> -	 */
>> -	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
>> -		ret = uclass_get_device_by_driver(UCLASS_CLK,
>> -						  DM_DRIVER_GET(ti_clk),
>> -						  &dev);
>> -		if (ret)
>> -			panic("Failed to initialize clk-k3!\n");
>> -	}
>> -
>>   	/* Prepare console output */
>>   	preloader_console_init();
>>   
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
