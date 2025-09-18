Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF49CAC5A0
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 13:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122BC8004F;
	Thu, 18 Sep 2025 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lR2lWRum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34738309A; Thu, 18 Sep 2025 15:18:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475D68003E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IDIoXD017908
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758201531;
 bh=QRSUoDZZ4zXzdv2qQxFcyFFnlERE2uxTaeHRY4iJA9A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lR2lWRumek2hMTPbZMJZWEkcymBi/wBJsaAxOvPehnFsperixAUg6fvAR6XYP72BX
 fHYysEbk1iOGjWOb7HUh/Y4evJBdJvng49IPdeDLWrIR+8smAw4vbdUZpK/eA1pYw7
 v7zT2d3GdswCh2lm+YtHw6/cFlsKc3hHkiHfRDMw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IDIovr2376591
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:18:50 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 08:18:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 08:18:50 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IDIlOh641157;
 Thu, 18 Sep 2025 08:18:47 -0500
Message-ID: <8ad2c8b4-e4e4-48c4-9502-964705aa33c4@ti.com>
Date: Thu, 18 Sep 2025 18:48:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/5] arm: dts: Introduce AM62D2-EVM dtbs
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>, "Bajjuri, Praneeth"
 <praneeth@ti.com>, "Menon, Nishanth" <nm@ti.com>
References: <20250909053429.444854-1-p-bhagat@ti.com>
 <20250909053429.444854-5-p-bhagat@ti.com> <DCOUCTBZ6JGI.QNZEO4LYIKR6@ti.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <DCOUCTBZ6JGI.QNZEO4LYIKR6@ti.com>
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

Hi Anshul,


On 10/09/25 10:08, Anshul Dalal wrote:
>
> On Tue Sep 9, 2025 at 11:04 AM IST, Paresh Bhagat wrote:
>> Introduce the base dts files needed for u-boot or to augment the linux
>> dtbs for use in the u-boot-spl and u-boot binaries. Support added for
>> HS-SE and HS-FS boot binaries for AM62dx via binman.
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> ---
>>   arch/arm/dts/Makefile                        |    2 +
>>   arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>>   arch/arm/dts/k3-am62d-evm-binman.dtsi        |  262 ++
>>   arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   14 +
>>   arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>>   5 files changed, 3162 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
>>
> [snip]
>> diff --git a/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..d1b17e8f83f
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Common AM62D EVM dts file for SPLs
>> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include "k3-am62d-evm-binman.dtsi"
>> +
>> +/ {
>> +	chosen {
>> +		stdout-path = "serial2:115200n8";
>> +		tick-timer = &main_timer0;
>> +	};
>> +};
Since serial_present is enabled, it checks for stdout in the specified 
format.
Also we need to define timer property for r5, so does not make sense to 
move it to kernel dts.


> The chosen node is already part of the kernel dt for the AM62d, why not
> move this addition to the kernel dt directly?
>
> Regards,
> Anshul
