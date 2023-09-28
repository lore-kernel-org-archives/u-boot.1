Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F790CE7B10
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A556686E29;
	Thu, 28 Sep 2023 11:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FxhBb7t0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD1A86844; Thu, 28 Sep 2023 11:30:48 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065E986E28
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9UhWW106390;
 Thu, 28 Sep 2023 04:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695893443;
 bh=OaoHLl6LppHnY+lOLdxPeTQcE1V+2wJ6Q+l4P1KweEA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FxhBb7t0rqaHdQ1Ij2nBxIm290j8GN3LduqDWQ8toZEcEFZtVrwWouJkeM4FVKcyk
 GzIR+lwLWWbdyk9Dgs63vpFSop99t1bHee1pDzAfgFc4mxCFA09EVZaopeRC1aXfqZ
 pYRsMwk0WFJ07JaDKVrXdE9YzKStP5YIbd4DXxPs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9UhmS016406
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 04:30:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:30:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:30:43 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9UfnX027491;
 Thu, 28 Sep 2023 04:30:42 -0500
Message-ID: <d51d4e84-71b8-1282-0007-7b5f1061e012@ti.com>
Date: Thu, 28 Sep 2023 15:00:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] arm: dts: Add support for AM62x LP SK
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-3-n-yadav@ti.com>
 <20230927115231.i3kg3wvpvqmmexnd@dazzling>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20230927115231.i3kg3wvpvqmmexnd@dazzling>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On 27/09/23 17:22, Nishanth Menon wrote:
> On 13:51-20230927, Nitin Yadav wrote:
>> The AM62x LP SK board is similar to the AM62x SK board,
>> but has some significant changes that requires different
>> device tree.
>>
>> The differences are mainly:
>> - AM62x SoC in the AMC package that meets AECQ100 automotive standard.
>> - LPDDR4 versus DDR4 on the AM62x SK.
>> - TPS65219 PMIC instead of discrete regulators.
>> - IO expander pin names are wired differently.
>> - Second ethernet port is currently disabled as the boards do not have
>>   the part physically installed.
>> - OSPI NAND vs OSPI NOR.
>> - No WLAN chip instead a SDIO M.2 connector.
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>  arch/arm/dts/Makefile                         |    2 +
>>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |    9 +
>>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
> 
>>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   21 +
>>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
>>  5 files changed, 2453 insertions(+)
>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
>>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
>>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index bde2176ec7..72ea57885f 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1337,6 +1337,8 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>>  
>>  dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>>  			      k3-am625-r5-sk.dtb \
>> +			      k3-am62-lp-sk.dtb \
>> +			      k3-am62-r5-lp-sk.dtb \
>>  			      k3-am625-beagleplay.dtb \
>>  			      k3-am625-r5-beagleplay.dtb \
>>  			      k3-am625-verdin-wifi-dev.dtb \
>> diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..7da94fe4b6
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AM62x LP SK dts file for SPLs
>> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include "k3-am62x-sk-common-u-boot.dtsi"
>> +
>> +#include "k3-am62-lp-sk-binman.dtsi"
> 
> Are you sure you don't need the dt phase properties for regulators for
> mmc to work?
> 
>> diff --git a/arch/arm/dts/k3-am62-lp-sk.dts b/arch/arm/dts/k3-am62-lp-sk.dts
> 
> Is this coming in from v6.6-rc1 if so document that in commit message.
> 
> [...]
> 
>> diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
>> new file mode 100644
>> index 0000000000..ed2c028bad
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AM62x LP SK dts file for R5 SPL
>> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include "k3-am62-lp-sk.dts"
>> +#include "k3-am62x-ddr-lp4-50-800-800.dtsi"
>> +#include "k3-am62-ddr.dtsi"
>> +
>> +#include "k3-am62-lp-sk-u-boot.dtsi"
>> +#include "k3-am62x-r5-sk-common.dtsi"
>> +
>> +/ {
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* 2G RAM */
>> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
>> +		bootph-pre-ram;
>> +	};
>> +};
> 
> NAK. should come from board.dts.

am62sip support is also in the queue where we have only 512M of RAM.
That's why I'm adding this node in r5-sk.dts
> 
>> diff --git a/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi b/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>> new file mode 100644
>> index 0000000000..74693d12e1
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>> @@ -0,0 +1,2190 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * This file was generated with the
>> + * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.08.61
>> + * Tue Mar 22 2022 17:03:08 GMT-0500 (Central Daylight Time)
> 
> Are you sure this does'nt need a sync up to latest?

Thanks will sync & update.
> 
>> + * DDR Type: LPDDR4
> 
> Would be good to document the exact DDR part.
> 
>> + * F0 = 50MHz    F1 = 800MHz    F2 = 800MHz
>> + * Density (per channel): 16Gb
>> + * Number of Ranks: 1
>> + */
>> +
> 
> 	[...]
> 

-- 
Regards,
Nitin
