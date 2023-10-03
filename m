Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C115EE7544A
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 10:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26098871B0;
	Tue,  3 Oct 2023 12:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oJlUpg+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58151871DB; Tue,  3 Oct 2023 12:42:03 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA18D8719F
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 12:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393AfwvM044369;
 Tue, 3 Oct 2023 05:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696329718;
 bh=AK85JBh0NvUPNElq2iJ+kVkMmAltO5QHQ+vU95LYLGQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oJlUpg+qS5fs7x+isDad+djTf1UhKi4/tAXrRKZNHJMbVunN3A9R83MFTYETcGflC
 rT333/gQkXaRQOpjbX8xeIHBvpHGApw/AJKstD5xIu1iuQCaEdxVzrtAKBX7bUHrKw
 O0f+YpqpVCy2SQnO0L/VlVuUOii6HlXIMvPhdghQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393Afwl8129508
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 05:41:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 05:41:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 05:41:58 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393AfuQS093878;
 Tue, 3 Oct 2023 05:41:57 -0500
Message-ID: <ba65c9e4-b280-c715-1467-56fbcbbec70b@ti.com>
Date: Tue, 3 Oct 2023 16:11:56 +0530
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
 <d51d4e84-71b8-1282-0007-7b5f1061e012@ti.com>
 <20230928143015.gzofmiqtjyh2ls57@darkening>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20230928143015.gzofmiqtjyh2ls57@darkening>
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



On 28/09/23 20:00, Nishanth Menon wrote:
> On 15:00-20230928, Nitin Yadav wrote:
>> Hi,
>>
>> On 27/09/23 17:22, Nishanth Menon wrote:
>>> On 13:51-20230927, Nitin Yadav wrote:
>>>> The AM62x LP SK board is similar to the AM62x SK board,
>>>> but has some significant changes that requires different
>>>> device tree.
>>>>
>>>> The differences are mainly:
>>>> - AM62x SoC in the AMC package that meets AECQ100 automotive standard.
>>>> - LPDDR4 versus DDR4 on the AM62x SK.
>>>> - TPS65219 PMIC instead of discrete regulators.
>>>> - IO expander pin names are wired differently.
>>>> - Second ethernet port is currently disabled as the boards do not have
>>>>   the part physically installed.
>>>> - OSPI NAND vs OSPI NOR.
>>>> - No WLAN chip instead a SDIO M.2 connector.
>>>>
>>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>>>> ---
>>>>  arch/arm/dts/Makefile                         |    2 +
>>>>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |    9 +
>>>>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
>>>
>>>>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   21 +
>>>>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
>>>>  5 files changed, 2453 insertions(+)
>>>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>>>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
>>>>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
>>>>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>>>>
>>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>>> index bde2176ec7..72ea57885f 100644
>>>> --- a/arch/arm/dts/Makefile
>>>> +++ b/arch/arm/dts/Makefile
>>>> @@ -1337,6 +1337,8 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>>>>  
>>>>  dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>>>>  			      k3-am625-r5-sk.dtb \
>>>> +			      k3-am62-lp-sk.dtb \
>>>> +			      k3-am62-r5-lp-sk.dtb \
>>>>  			      k3-am625-beagleplay.dtb \
>>>>  			      k3-am625-r5-beagleplay.dtb \
>>>>  			      k3-am625-verdin-wifi-dev.dtb \
>>>> diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>>>> new file mode 100644
>>>> index 0000000000..7da94fe4b6
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>>>> @@ -0,0 +1,9 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * AM62x LP SK dts file for SPLs
>>>> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>>>> + */
>>>> +
>>>> +#include "k3-am62x-sk-common-u-boot.dtsi"
>>>> +
>>>> +#include "k3-am62-lp-sk-binman.dtsi"
>>>
>>> Are you sure you don't need the dt phase properties for regulators for
>>> mmc to work?
>>>
>>>> diff --git a/arch/arm/dts/k3-am62-lp-sk.dts b/arch/arm/dts/k3-am62-lp-sk.dts
>>>
>>> Is this coming in from v6.6-rc1 if so document that in commit message.
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
>>>> new file mode 100644
>>>> index 0000000000..ed2c028bad
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
>>>> @@ -0,0 +1,21 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * AM62x LP SK dts file for R5 SPL
>>>> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>>>> + */
>>>> +
>>>> +#include "k3-am62-lp-sk.dts"
>>>> +#include "k3-am62x-ddr-lp4-50-800-800.dtsi"
>>>> +#include "k3-am62-ddr.dtsi"
>>>> +
>>>> +#include "k3-am62-lp-sk-u-boot.dtsi"
>>>> +#include "k3-am62x-r5-sk-common.dtsi"
>>>> +
>>>> +/ {
>>>> +	memory@80000000 {
>>>> +		device_type = "memory";
>>>> +		/* 2G RAM */
>>>> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
>>>> +		bootph-pre-ram;
>>>> +	};
>>>> +};
>>>
>>> NAK. should come from board.dts.
>>
>> am62sip support is also in the queue where we have only 512M of RAM.
>> That's why I'm adding this node in r5-sk.dts
> 
> NAK.
> 
> Do this cleanup in the context of the new platform addition - when you
> get it in the kernel first.

I haven't planned to have a kernel dt for am62sip as there is only
difference is DDR size which will be taken care by U-boot.

> 
> Side note: I don't see anything in ti.com for the search text.
> 
> 

-- 
Regards,
Nitin
