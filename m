Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E1CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D953E88457;
	Fri,  5 Apr 2024 09:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TwLxPBFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888138845A; Fri,  5 Apr 2024 09:18:33 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEA1882B2
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4357IGBW036228;
 Fri, 5 Apr 2024 02:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712301496;
 bh=AHBzSCMGq231av705BG0jpZHKyog52HvyNLFvx0g0PA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TwLxPBFmZsYFoQa5ZVTlKZWmd9SGWzvdtDVi/gvhFatPiRkUv6Zf/6UgrzftZyJbQ
 BSKJxz8UKQ2k1jRKO0qHcjHOIntdQophqwtJw1ZtWgP6Xyrt3eVa/QBdUvffpyJK2E
 3mlhcjtpA0mReZmsxNH8PNWjwsgfeFUm4ldLO3wk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4357IGwK035858
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 02:18:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 02:18:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 02:18:15 -0500
Received: from [172.24.227.252]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4357IAD6130708;
 Fri, 5 Apr 2024 02:18:11 -0500
Message-ID: <e7c3882f-ef6a-4f3a-a5ec-2e2aa7cc2b45@ti.com>
Date: Fri, 5 Apr 2024 12:48:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/15] arm: dts: Introduce J722S U-Boot dts files
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>,
 <r-gunasekaran@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-14-j-choudhary@ti.com>
 <d738eaaf-6f13-4502-98a1-ef1bfe82d2ff@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <d738eaaf-6f13-4502-98a1-ef1bfe82d2ff@ti.com>
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

Hi,

On 04/04/24 20:59, Andrew Davis wrote:
> On 4/4/24 4:00 AM, Jayesh Choudhary wrote:
>> Include the uboot device tree files needed to boot the board.
>>
>> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/dts/Makefile                      |    2 +
>>   arch/arm/dts/k3-j722s-binman.dtsi          |  171 ++
>>   arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi | 2795 ++++++++++++++++++++
>>   arch/arm/dts/k3-j722s-evm-u-boot.dtsi      |   36 +
>>   arch/arm/dts/k3-j722s-r5-evm.dts           |   82 +
>>   5 files changed, 3086 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-j722s-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi
>>   create mode 100644 arch/arm/dts/k3-j722s-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j722s-r5-evm.dts
>>
> 
> [...]
> 
>> diff --git a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi 
>> b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..056ef08455
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Common J722S EVM dts file for SPLs
>> + * Copyright (C) 2024 Texas Instruments Incorporated - 
>> https://www.ti.com/
>> + */
>> +
>> +#include "k3-j722s-binman.dtsi"
>> +
>> +/ {
>> +    chosen {
>> +        stdout-path = "serial2:115200n8";
>> +        tick-timer = &main_timer0;
>> +    };
>> +};
>> +
>> +&main_pktdma {
>> +    reg = <0x00 0x485c0000 0x00 0x000100>,
>> +          <0x00 0x4a800000 0x00 0x020000>,
>> +          <0x00 0x4aa00000 0x00 0x040000>,
>> +          <0x00 0x4b800000 0x00 0x400000>,
>> +          <0x00 0x485e0000 0x00 0x020000>,
>> +          <0x00 0x484a0000 0x00 0x004000>,
>> +          <0x00 0x484c0000 0x00 0x002000>,
>> +          <0x00 0x48430000 0x00 0x004000>;
>> +    reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
>> +            "cfg", "tchan", "rchan", "rflow";
> 
> Is this needed? Do we still not have the correct regs in
> upstream kernel?

I missed this change when I was going through j722s dts changes.

u-boot dts currently does not have this fixed.
Tag v6.9-rc1-dts from devicetree-rebasing would have this fix.

Will keep this in mind.

Also from TRM memory map, the range is off for 'tchanrt'
Will send a fix patch for that after checking for all platforms
to linux upstream if required.

> 
>> +};
>> +
>> +&dmsc {
>> +    bootph-pre-ram;
>> +
>> +    k3_sysreset: sysreset-controller {
>> +        compatible = "ti,sci-sysreset";
>> +        bootph-pre-ram;
> 
> This node won't be needed soon either[0]. Should mean an
> almost empty -u-boot.dtsi file, which should be the goal.
> 

Okay. I will remove the node.

Should I mark [0] as dependency or is it okay without it.
Impact would only be on U-Boot RESET I think. Base support
would still be functional.

Thanks,
Jayesh

> Andrew
> 
> [0] https://lore.kernel.org/all/20240402160908.508974-1-afd@ti.com/
> 
>> +    };

[...]
