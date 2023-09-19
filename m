Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDBACE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504C986A2F;
	Tue, 19 Sep 2023 19:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q5rtk3ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C264866EC; Tue, 19 Sep 2023 19:43:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9AF86AEB
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHhFOi104028;
 Tue, 19 Sep 2023 12:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695145395;
 bh=vuQS07MsOPAlHnAIEChjYjXE8WW88HKbikanrjj1X8U=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=q5rtk3ngZWHtvgVCl/n96OO+gnQTSTOodhPoarBFMmC545VX1+FFevvj6xxA8ZZaT
 4Z21LrJU2i+07YXwq5ZmsQIVF8d13PAXQOk+XLfPNOLeZmkFqkor2b963oumT63HZQ
 h/jFEzICTsJvuUUWj6maGUxfMG0tDBydAviubhR4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHhFQJ039617
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:43:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:43:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:43:15 -0500
Received: from [10.250.64.197] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHh7Un003765;
 Tue, 19 Sep 2023 12:43:08 -0500
Message-ID: <2972f8d5-1b55-4b12-375d-e3f90359221d@ti.com>
Date: Tue, 19 Sep 2023 23:13:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/16] board: ti: j784s4: Add board support for J784S4
 EVM
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-9-a-nandan@ti.com>
 <f31f0b70-e50a-51e3-baf0-7e1d00e6f926@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <f31f0b70-e50a-51e3-baf0-7e1d00e6f926@kernel.org>
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

Hi,

On 09/09/23 16:32, Roger Quadros wrote:
>
> On 08/09/2023 14:05, Apurva Nandan wrote:
>> Add board files for J784S4 EVM.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [ add env and board specific yaml files for binman ]
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> [ cleaned up the env files ]
>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig         |    1 +
>>   board/ti/j784s4/Kconfig          |   63 +
>>   board/ti/j784s4/MAINTAINERS      |   20 +
>>   board/ti/j784s4/Makefile         |    8 +
>>   board/ti/j784s4/board-cfg.yaml   |   36 +
>>   board/ti/j784s4/evm.c            |   87 +
>>   board/ti/j784s4/j784s4.env       |   35 +
>>   board/ti/j784s4/pm-cfg.yaml      |   12 +
>>   board/ti/j784s4/rm-cfg.yaml      | 3057 ++++++++++++++++++++++++++++++
>>   board/ti/j784s4/sec-cfg.yaml     |  379 ++++
>>   board/ti/j784s4/tifs-rm-cfg.yaml | 2655 ++++++++++++++++++++++++++
>>   include/configs/j784s4_evm.h     |   20 +
>>   12 files changed, 6373 insertions(+)
>>   create mode 100644 board/ti/j784s4/Kconfig
>>   create mode 100644 board/ti/j784s4/MAINTAINERS
>>   create mode 100644 board/ti/j784s4/Makefile
>>   create mode 100644 board/ti/j784s4/board-cfg.yaml
>>   create mode 100644 board/ti/j784s4/evm.c
>>   create mode 100644 board/ti/j784s4/j784s4.env
>>   create mode 100644 board/ti/j784s4/pm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/rm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/sec-cfg.yaml
>>   create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>>   create mode 100644 include/configs/j784s4_evm.h
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 0af2ec6ddb..ba3dd393e3 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -197,4 +197,5 @@ source "board/ti/j721e/Kconfig"
>>   source "board/siemens/iot2050/Kconfig"
>>   source "board/ti/j721s2/Kconfig"
>>   source "board/toradex/verdin-am62/Kconfig"
>> +source "board/ti/j784s4/Kconfig"
>>   endif
>> diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
>> new file mode 100644
>> index 0000000000..7eeb21f451
>> --- /dev/null
>> +++ b/board/ti/j784s4/Kconfig
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> +#	Hari Nagalla <hnagalla@ti.com>
>> +
>> +choice
>> +	prompt "K3 J784S4 board"
>> +	optional
>> +
>> +config TARGET_J784S4_A72_EVM
>> +	bool "TI K3 based J784S4 EVM running on A72"
>> +	select ARM64
>> +	select SOC_K3_J784S4
>> +	select BOARD_LATE_INIT
>> +	select SYS_DISABLE_DCACHE_OPS
>> +	select BINMAN
>> +
>> +config TARGET_J784S4_R5_EVM
>> +	bool "TI K3 based J784S4 EVM running on R5"
>> +	select CPU_V7R
>> +	select SYS_THUMB_BUILD
>> +	select SOC_K3_J784S4
>> +	select K3_LOAD_SYSFW
>> +	select RAM
>> +	select SPL_RAM
>> +	select K3_DDRSS
>> +	select BINMAN
>> +	imply SYS_K3_SPL_ATF
>> +
>> +endchoice
>> +
>> +if TARGET_J784S4_A72_EVM
>> +
>> +config SYS_BOARD
>> +       default "j784s4"
>> +
>> +config SYS_VENDOR
>> +       default "ti"
>> +
>> +config SYS_CONFIG_NAME
>> +       default "j784s4_evm"
>> +
>> +source "board/ti/common/Kconfig"
>> +
>> +endif
>> +
>> +if TARGET_J784S4_R5_EVM
>> +
>> +config SYS_BOARD
>> +       default "j784s4"
>> +
>> +config SYS_VENDOR
>> +       default "ti"
>> +
>> +config SYS_CONFIG_NAME
>> +       default "j784s4_evm"
>> +
>> +config SPL_LDSCRIPT
>> +	default "arch/arm/mach-omap2/u-boot-spl.lds"
>> +
>> +source "board/ti/common/Kconfig"
>> +
>> +endif
>> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
>> new file mode 100644
>> index 0000000000..7d3549dd31
>> --- /dev/null
>> +++ b/board/ti/j784s4/MAINTAINERS
>> @@ -0,0 +1,20 @@
>> +J784S4 BOARD
>> +M:	Hari Nagalla <hnagalla@ti.com>
>> +S:	Maintained
>> +F:	board/ti/j784s4
>> +F:	arch/arm/mach-k3/j784s4
>> +F:	include/configs/j784s4_evm.h
>> +F:	configs/j784s4_evm_r5_defconfig
>> +F:	configs/j784s4_evm_a72_defconfig
>> +F:	arch/arm/dts/k3-j784s4.dtsi
>> +F:	arch/arm/dts/k3-j784s4-main.dtsi
>> +F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>> +F:	arch/arm/dts/k3-j784s4-thermal.dtsi
>> +F:	arch/arm/dts/k3-j784s4-evm.dts
>> +F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>> +F:	arch/arm/dts/k3-j784s4-r5-evm.dts
>> +F:	arch/arm/dts/k3-j784s4-ddr.dtsi
>> +F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>> +F:	arch/arm/dts/k3-am69-sk.dts
>> +F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
>> +F:	arch/arm/dts/k3-am69-r5-sk.dts
>> diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
>> new file mode 100644
>> index 0000000000..fc98b24a2d
>> --- /dev/null
>> +++ b/board/ti/j784s4/Makefile
>> @@ -0,0 +1,8 @@
>> +#
>> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> +#	Hari Nagalla <hnagalla@ti.com>
>> +#
>> +# SPDX-License-Identifier:     GPL-2.0+
> SPDX tag must be the first line?
Okay, will fix, thanks!
>
>> +#
>> +
>> +obj-y	+= evm.o
>> diff --git a/board/ti/j784s4/board-cfg.yaml b/board/ti/j784s4/board-cfg.yaml
>> new file mode 100644
>> index 0000000000..ea9a8b4a26
>> --- /dev/null
>> +++ b/board/ti/j784s4/board-cfg.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
>> +#
>> +# Board configuration for J784S4
>> +#
>> +
> <snip>
>
-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

