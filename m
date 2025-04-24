Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E65CC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 05:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AAE806FC;
	Thu, 24 Apr 2025 07:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yd2Nl01P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352A18070C; Thu, 24 Apr 2025 07:21:47 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B48E8056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 07:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5Lg4B2399531
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 00:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745472102;
 bh=MbVyIVv8V0UzbB3HC0cjFP7OO4RxUILmB4T+dHVgyvY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Yd2Nl01P+Fef2pYq8M5Pfrkn+1QTgz06HPBroZ2+U2eZ4zjGsnusiOO2hWWRPERb5
 R3Q9Cv4LjNqMnymC6lTOEN7ZINW84UtswMYJ6QY7Lb2Nh4HPzvuWVp28G6/JECTN4s
 IqSA+56dobTnFQhQMjjYa3VOT3kdinOU7KLfzdJI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5LgIh056764
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 00:21:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 00:21:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 00:21:41 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O5LclF083424;
 Thu, 24 Apr 2025 00:21:39 -0500
Message-ID: <f562754c-d466-4be2-8478-585891e006e7@ti.com>
Date: Thu, 24 Apr 2025 10:51:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-binman: Add template for packing HSM
 firmware
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-3-b-padhi@ti.com>
 <061dd508-b350-4f47-badb-ab773496be9e@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <061dd508-b350-4f47-badb-ab773496be9e@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrew,

On 22/04/25 20:04, Andrew Davis wrote:
> On 4/22/25 4:54 AM, Beleswar Padhi wrote:
>> The HSM M4 core needs to be booted at R5 SPL stage so that it can be
>> used for further Authentication and security services. Therefore, the
>> firmware for the HSM core needs to be packed in tispl.bin fit image so
>> that it can be used by R5 SPL to boot the HSM core.
>>
>> Add a template for packing the HSM firmware in tispl.bin. The size of
>> HSM firmware is padded upto 256 KB. The HSM binaries are unloaded at a
>> temporary DDR address.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/dts/k3-binman.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index 5163161b94d..c2b8388b06e 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -297,6 +297,17 @@
>>                       };
>>                   };
>>   +#ifdef CONFIG_K3_HSM_FW
>> +                hsm {
>> +                    description = "HSM binary";
>> +                    type = "standalone";
>> +                    compression = "none";
>> +                    os = "hsm";
>> +                    load = <0x82000000>;
>> +                    entry = <0x82000000>;
>
> These addresses might already be in use. Why do you need an `entry`
> address here? 


SPL parses the FIT image and assigns the `image_start` based on this `entry` address.

https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/r5/common.c?ref_type=heads#L317
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/r5/common.c?ref_type=heads#L165


> Or a `load` address?, if one isn't given then U-Boot
> should pick a safe spot for you, or even do the operation in-place.


Looks like that's not the case. When I skipped `load` section, U-Boot complains with following error:

```
U-Boot SPL 2025.04-01182-gaa96051c7f78-dirty (Apr 24 2025 - 10:42:17 +0530)                                                                                                                                 
SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.9--v11.00.09+ (Fancy Rat)')                                                                                                                                       
Initialized 4 DRAM controllers                                                                                                                                                                              
SPL initial stack usage: 13456 bytes                                                                                                                                                                        
Trying to boot from MMC2                                                                                                                                                                                                                                                                                           
Skipping authentication on GP device                                                                                                                                                                        
Can't load hsm: No load address and no buffer                                                                                                                                                               
spl_load_simple_fit: can't load image loadables index 0 (ret = -105)                                                                                                                                        
spl_load_image_fat: error reading image tispl.bin, err - -105                                                                                                                                               
spl_load_image_ext: ext4fs mount err - 0                                                                                                                                                                    
Error: -2                                                                                                                                                                                                   
SPL: failed to boot from all boot devices                                                                                                                                                                   
### ERROR ### Please RESET the board ###
```

Thanks,
Beleswar

>
> Andrew
>
>> +                };
>> +#endif
>> +
>>                   dm {
>>                       description = "DM binary";
>>                       type = "firmware";
