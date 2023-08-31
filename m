Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5432DC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459958657C;
	Thu, 31 Aug 2023 15:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RskHLWD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA42586577; Thu, 31 Aug 2023 15:16:42 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B216C8657C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37VDGZI2064743;
 Thu, 31 Aug 2023 08:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693487795;
 bh=tQHcYAVDWy36WwWhDY2bsE1+WkrN6g5I+lQ2dDUfeEM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RskHLWD5B/eqJTUPTk06/0wQ9Goqbt4xqa6QlUrIlzZbtDqkro1W5Do3O4uGAGSLO
 aZjRd4zr0XcP+WHlMgjbtP06e8XtSng3sFqU+Lnz9mPDdVybQuf7lt5ilupcKpyHfg
 IP5Av86vxFNlgyV72/y59d6i+31hnkcz7+7qlGzg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37VDGZnL079864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 08:16:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 08:16:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 08:16:35 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37VDGVN3091452;
 Thu, 31 Aug 2023 08:16:32 -0500
Message-ID: <71a3b4e6-214a-0fe0-46c8-852137f75708@ti.com>
Date: Thu, 31 Aug 2023 18:46:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] J721E DTS Sync with Kernel v6.5-rc1
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230828113109.2533045-1-n-francis@ti.com>
 <20230828173316.tpzluxjvcnwmcyjj@circus>
 <36818daf-81f5-a41d-0f20-9f4cb81537d2@ti.com>
 <20230831113556.axqxldonwz6edjvu@repave>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230831113556.axqxldonwz6edjvu@repave>
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

On 31/08/23 17:05, Nishanth Menon wrote:
> On 13:56-20230831, Neha Malcom Francis wrote:
>> Hi Nishanth
>>
>> On 28/08/23 23:03, Nishanth Menon wrote:
>>> On 17:01-20230828, Neha Malcom Francis wrote:
>>>> This series aims to sync kernel.org v6.5-rc1 DTS with that of U-Boot. It
>>>> also includes cleanups where necessary along with certain changes to
>>>> ensure boot is unaffected.
>>>>
>>>> While it's mainly synced to the tag v6.5-rc1, one extra commit has been
>>>> added that cleans up duplicating wkup_i2c0 nodes [1] in Kernel.
>>>>
>>>> Same as with other board series that have taken up this effort, cleanup
>>>> of mcu_ringacc and mcu_udmap are dependent on MCU Ringacc [2] and DMA
>>>> [3] fixes. This will be taken up after their merge to Linux.
>>>>
>>>> [1] https://lore.kernel.org/all/20230721082344.1534094-1-u-kumar1@ti.com/
>>>> [2] https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
>>>> [3] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
>>>>
>>>> Boot logs:
>>>> https://gist.github.com/nehamalcom/231426b784e0ba96ef3a0da84346e038
>>>>
>>>> Neha Malcom Francis (4):
>>>>     arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
>>>>     arm: dts: k3-j721e: Sync with v6.5-rc1
>>>>     drivers: misc: k3_avs: Add linux compatible to maintain sync
>>>>     configs: j721e: Remove HBMC_AM654 config
>>> please change the order of patches:
>>> a) introduce the driver change for vtm
>>> b) cleanup config and drop the hbmc node stuff
>>> c) rest of dts sync
>>>
>>> NOTE:
>>> * J721e does'nt use SYSFW - it uses TIFS
>>> * for properties that dont use bootph or u-boot, properties, we
>>>     should'nt be including property changes in u-boot.dtsi or r5.dts
>>>     without explanation as to what.
>>> * There is a bunch of /delete-property/ plugged in for no clear reason.
>>>     I see that even for timer - but timer data could have been included in
>>>     arch/arm/mach-k3/j721e/dev-data.c and so could have been others too.
>>>     This needs clear explanation.
>>>
>>
>> All valid points, will factor these in. However regarding the timer, we have
>> already tried to do the same for J721E by adding in the data in dev-data.c
>> however this does not work since TIFS is in sysfw.itb which has not been
>> loaded yet. Will take action to debug and root cause that further as well as
>> try adding data for all the other existing /delete-property/ using nodes.
> 
> Thanks. What helped us on other platforms was to setup a breakpoints
> with openocd ti_clk_probe and omap_timer_probe using the debug
> technique[1] (board_init_f) and looking at the call stacks. in case of
> am62, ti_clk_probe is hit first and call stack looks like [2] followed
> by omap_timer_probe where the call stack looks like [3].
> 
> [1] https://u-boot.readthedocs.io/en/latest/board/ti/k3.html#code-modification
> [2] https://gist.github.com/nmenon/495f85267ecd0c833218b5054b568b00
> [3] https://gist.github.com/nmenon/c7a3a8c0de0a65b06334190ca9350ead
> 

Thanks for the detailed help on the debug! Will be useful!

-- 
Thanking You
Neha Malcom Francis
