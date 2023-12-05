Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD267C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9C886F42;
	Tue,  5 Dec 2023 10:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nSMI0LMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A380286FB5; Tue,  5 Dec 2023 10:03:11 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5AB86F1F
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B592viq051307;
 Tue, 5 Dec 2023 03:02:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701766977;
 bh=pEPiZaVu6t9VLyf8zSW8sAFYNq+yS6yzHgsolBdpLl0=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=nSMI0LMIGcMx/1XA975BudUJIwb7lB5sGQwEiWvwwg0p8iPNuK6WV+e2r9+LtUFgo
 BpRBFgAJBLdgA6kRnsnulHokB0xAoLCPpg9eII1m/Jw6+cWtOGZjRpel4bfcCPA2+0
 /7NkLL8pRJNiSzxfwM2cg7adke8WtSy1KCW2aAfU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B592vte059117
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 03:02:57 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 03:02:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 03:02:57 -0600
Received: from [10.24.69.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B592oj3121548;
 Tue, 5 Dec 2023 03:02:51 -0600
Message-ID: <aa2ff6a9-c72e-4bfe-820f-a444463d7036@ti.com>
Date: Tue, 5 Dec 2023 14:32:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] board: ti: j784s4: Add board support for J784S4
 EVM
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "nm@ti.com" <nm@ti.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-10-a-nandan@ti.com>
 <bfec8d32af29525118437eeed32ac9e2c8cbc554.camel@toradex.com>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <bfec8d32af29525118437eeed32ac9e2c8cbc554.camel@toradex.com>
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

Hi Marcel

On 01/12/23 14:13, Marcel Ziswiler wrote:
> Hi Apurva
>
> Thanks for the update, however, it does not seem to compile. See below...
>
> On Thu, 2023-11-30 at 17:25 +0530, Apurva Nandan wrote:
>> Add board files for J784S4 EVM.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [ add env and board specific yaml files for binman ]
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> [ cleaned up the env files ]
>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig        |  1 +
>>   arch/arm/mach-k3/j784s4/Kconfig | 35 ++++++++++++++++++++++++++++++
>>   board/ti/j784s4/Makefile        |  7 ++++++
>>   board/ti/j784s4/evm.c           | 38 +++++++++++++++++++++++++++++++++
>>   include/configs/j784s4_evm.h    | 20 +++++++++++++++++
>>   5 files changed, 101 insertions(+)
>>   create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
>>   create mode 100644 board/ti/j784s4/Makefile
>>   create mode 100644 board/ti/j784s4/evm.c
>>   create mode 100644 include/configs/j784s4_evm.h
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 150d0bfa14..445b49e245 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -157,5 +157,6 @@ source "arch/arm/mach-k3/am62x/Kconfig"
>>   source "arch/arm/mach-k3/am62ax/Kconfig"
>>   source "arch/arm/mach-k3/j721e/Kconfig"
>>   source "arch/arm/mach-k3/j721s2/Kconfig"
>> +source "arch/arm/mach-k3/j784s4/Kconfig"
>>   
>>   endif
>> diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
>> new file mode 100644
>> index 0000000000..03d3f91371
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/j784s4/Kconfig
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> +#	Hari Nagalla <hnagalla@ti.com>
>> +
>> +if SOC_K3_J784S4
>> +
>> +choice
>> +	prompt "K3 J784S4 board"
>> +	optional
>> +
>> +config TARGET_J784S4_A72_EVM
>> +	bool "TI K3 based J784S4 EVM running on A72"
>> +	select ARM64
>> +	select BOARD_LATE_INIT
>> +	select SYS_DISABLE_DCACHE_OPS
>> +	select BINMAN
>> +
>> +config TARGET_J784S4_R5_EVM
>> +	bool "TI K3 based J784S4 EVM running on R5"
>> +	select CPU_V7R
>> +	select SYS_THUMB_BUILD
>> +	select K3_LOAD_SYSFW
>> +	select RAM
>> +	select SPL_RAM
>> +	select K3_DDRSS
>> +	select BINMAN
>> +	imply SYS_K3_SPL_ATF
>> +
>> +endchoice
>> +
>> +source "board/ti/j784s4/Kconfig"
> Where exactly would that one come from?
>
> ⬢[zim@toolbox u-boot.git]$ make j784s4_evm_r5_defconfig
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    YACC    scripts/kconfig/zconf.tab.c
>    LEX     scripts/kconfig/zconf.lex.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
>    HOSTLD  scripts/kconfig/conf
> arch/arm/mach-k3/j784s4/Kconfig:32: can't open file "board/ti/j784s4/Kconfig"
> make[1]: *** [scripts/kconfig/Makefile:96: j784s4_evm_r5_defconfig] Error 1
> make: *** [Makefile:586: j784s4_evm_r5_defconfig] Error 2
Sorry, somehow I missed to push the Kconfig file in the patch. I will 
fix it in the v6.
Thanks for pointing!
>> +
>> +endif
>> +
>> diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
>> new file mode 100644
>> index 0000000000..3fc70eb8fb
>> --- /dev/null
>> +++ b/board/ti/j784s4/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> +#	Hari Nagalla <hnagalla@ti.com>
>> +#
>> +
>> +obj-y += evm.o
>> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
>> new file mode 100644
>> index 0000000000..4857c9d2f6
>> --- /dev/null
>> +++ b/board/ti/j784s4/evm.c
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Board specific initialization for J784S4 EVM
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + *	Hari Nagalla <hnagalla@ti.com>
>> + *
>> + */
>> +
>> +#include <image.h>
>> +#include <init.h>
>> +#include <spl.h>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +int board_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +int dram_init(void)
>> +{
>> +	return fdtdec_setup_mem_size_base();
>> +}
>> +
>> +int dram_init_banksize(void)
>> +{
>> +	return fdtdec_setup_memory_banksize();
>> +}
>> +
>> +int board_late_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +void spl_board_init(void)
>> +{
>> +}
>> diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
>> new file mode 100644
>> index 0000000000..1b780134ca
>> --- /dev/null
>> +++ b/include/configs/j784s4_evm.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Configuration header file for K3 J784S4 EVM
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + *	Hari Nagalla <hnagalla@ti.com>
>> + */
>> +
>> +#ifndef __CONFIG_J784S4_EVM_H
>> +#define __CONFIG_J784S4_EVM_H
>> +
>> +#include <linux/sizes.h>
>> +
>> +/* DDR Configuration */
>> +#define CFG_SYS_SDRAM_BASE1		0x880000000
>> +
>> +/* Now for the remaining common defines */
>> +#include <configs/ti_armv7_common.h>
>> +
>> +#endif /* __CONFIG_J784S4_EVM_H */
> Cheers
>
> Marcel

-- 
Regards,
Apurva Nandan,
Texas Instruments.

