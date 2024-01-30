Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639E7C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 08:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C21879AF;
	Tue, 30 Jan 2024 09:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MWsJevZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C51879B0; Tue, 30 Jan 2024 09:31:52 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4319F8721A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 09:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40U8VmZT009998;
 Tue, 30 Jan 2024 02:31:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706603508;
 bh=jQBZIf7goHHG7X8z8VQh8njCq+eJTM6hPaMgwPDqyR0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MWsJevZTb4mG26xjkK2oMqE9/YAfGxruqn2CqjZrOLobgY2vvGCNYz6pN8LXLHbHh
 7jT5j9ewgjcYkEa6mrKwy7COzsT5e2ATtW0D1M298NQySj3YgoeeIPHqmliGp4P1yz
 inJz3u+HxOG7diRZ9KzYqeBwbk/kQSBapt7mnU+c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40U8Vm0k078909
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 02:31:48 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 02:31:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 02:31:47 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40U8Vi4m024467;
 Tue, 30 Jan 2024 02:31:44 -0600
Message-ID: <283f3440-2c87-453e-9ec7-e4ff54821bc5@ti.com>
Date: Tue, 30 Jan 2024 14:01:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j721s2_init: Support less than max DDR
 controllers
Content-Language: en-US
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <afd@ti.com>, <christian.gmeiner@gmail.com>, <j-choudhary@ti.com>,
 <nm@ti.com>, <d.haller@phytec.de>, <joao.goncalves@toradex.com>,
 <u-boot@lists.denx.de>
References: <20240130074139.2627793-1-n-francis@ti.com>
 <d4ff51e8-9361-45ed-927b-96a5ce234849@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <d4ff51e8-9361-45ed-927b-96a5ce234849@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Udit

On 30/01/24 13:53, Kumar, Udit wrote:
> 
> On 1/30/2024 1:11 PM, Neha Malcom Francis wrote:
>> The number of DDR controllers to be initialised and used should depend
>> on the device tree with the constraint of the maximum number of
>> controllers the device supports. Since J721S2 has multiple (2)
>> controllers, instead of hardcoding the number of probes, move to
>> depending on the device tree UCLASS_RAM nodes present.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Boot logs:
>> https://gist.github.com/nehamalcom/07fedf4aa173590214b5cef6e1688fa1
>>
>> This was also parallely proposed in [1] on the mailing-list for J784S4.
>>
>> [1] https://lore.kernel.org/all/3a7c817b-de29-463a-b4b6-d62c0df66ade@ti.com/
>>
>>   arch/arm/mach-k3/j721s2_init.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
>> index fb0708bae1..ff21619506 100644
>> --- a/arch/arm/mach-k3/j721s2_init.c
>> +++ b/arch/arm/mach-k3/j721s2_init.c
>> @@ -213,10 +213,12 @@ bool check_rom_loaded_sysfw(void)
>>       return is_rom_loaded_sysfw(&bootdata);
>>   }
>> +#define J721S2_MAX_CONTROLLERS    2
>> +
>>   void k3_mem_init(void)
>>   {
>>       struct udevice *dev;
>> -    int ret;
>> +    int ret, ctr = 1;
>>       if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
>>           ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
>> @@ -227,9 +229,14 @@ void k3_mem_init(void)
>>           if (ret)
>>               panic("DRAM 0 init failed: %d\n", ret);
>> -        ret = uclass_next_device_err(&dev);
>> -        if (ret)
>> -            panic("DRAM 1 init failed: %d\n", ret);
> 
> Since there are two controllers only and you need to call uclass_get_device and 
> uclass_next_device_err
> 
> what about just checking error in above removed code, something like
> 
>          ret = uclass_next_device_err(&dev);
>          if (ret!=ENODEV)
>              panic("DRAM 1 init failed: %d\n", ret);
> 
> 

Yes... since AEP has only 2 controllers, this will suffice.

>> +        while (ctr < J721S2_MAX_CONTROLLERS) {
>> +            ret = uclass_next_device_err(&dev);
>> +            if (ret == -ENODEV)
>> +                break;
>> +            if (ret)
>> +                panic("DRAM %d init failed: %d\n", ctr, ret);
>> +            ctr++;
>> +        }
>>       }
>>       spl_enable_cache();
>>   }

-- 
Thanking You
Neha Malcom Francis
