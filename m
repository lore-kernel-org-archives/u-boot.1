Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FE0C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4209F87BFD;
	Tue, 23 Jan 2024 15:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cOMbUaL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BDB87D18; Tue, 23 Jan 2024 15:42:30 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA95878A5
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NEgGBZ064656;
 Tue, 23 Jan 2024 08:42:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706020936;
 bh=mplLwIUDC/Mk4zIfdBUG1/hz5TUP+xl8oPQ0opwKwL8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cOMbUaL6vHt8CZpCud5ar+HnJ3v1erDMM6Fr/TmWlfqpoPPt7WULnOvfqPx4o+WoL
 maiCNkm0sOKh4Qtd37bAV9yYeXv8X0IVMIXhC4+Ix02hfWP0fDfZsMrYa6ARl3W0/M
 hbOhUxhcB0AEtLx76aAo+rLckfaTa0nhDmUxyA1U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NEgGvZ130735
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 08:42:16 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:42:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:42:15 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NEdu0i079783; 
 Tue, 23 Jan 2024 08:42:10 -0600
Message-ID: <2d43b124-2e92-4c0d-9dcf-9d92e18c440f@ti.com>
Date: Tue, 23 Jan 2024 20:12:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/16] board: ti: j784s4: Add board support for J784S4
 EVM
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-10-a-nandan@ti.com>
 <20240119193913.ter2wn6krowklcr6@relenting>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240119193913.ter2wn6krowklcr6@relenting>
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

On 20/01/24 01:09, Nishanth Menon wrote:
> On 23:20-20240119, Apurva Nandan wrote:
>> Add board files for J784S4 EVM.
>>
>> SYS_DISABLE_DCACHE_OPS is selected in the Kconfig because
>> J784S4/AM69 are a coherent architecture at A72 level by
>> MSMC support.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [ add env and board specific yaml files for binman ]
> Neither of them are part of this patch?
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> [ cleaned up the env files ]
> no env file in this patch?
Will fix.
>
>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
> [...]
>
>> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
>> new file mode 100644
>> index 0000000000..9e0df11503
>> --- /dev/null
>> +++ b/board/ti/j784s4/MAINTAINERS
>> @@ -0,0 +1,14 @@
>> +J784S4 EVM BOARD
>> +M:	Apurva Nandan <a-nandan@ti.com>
>> +S:	Maintained
>> +F:	board/ti/j784s4
>> +F:	arch/arm/mach-k3/j784s4
>> +F:	include/configs/j784s4_evm.h
>> +F:	arch/arm/dts/k3-j784s4.dtsi
>> +F:	arch/arm/dts/k3-j784s4-main.dtsi
>> +F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>> +F:	arch/arm/dts/k3-j784s4-thermal.dtsi
>> +F:	arch/arm/dts/k3-j784s4-evm.dts
>> +
>> +AM69 SK BOARD
> Don't all entries need a maintainer? I am not actually sure if the above
> M will fall through for SK board.
Okay, will add M for AM69 as well.
>
>> +F:	arch/arm/dts/k3-am69-sk.dts
>> diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
>> new file mode 100644
>> index 0000000000..60161a8b5c
>> --- /dev/null
>> +++ b/board/ti/j784s4/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>> +#	Hari Nagalla <hnagalla@ti.com>
>> +#
>> +
>> +obj-y += evm.o
>> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
>> new file mode 100644
>> index 0000000000..5af3e21ff0
>> --- /dev/null
>> +++ b/board/ti/j784s4/evm.c
>> @@ -0,0 +1,43 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Board specific initialization for J784S4 EVM
>> + *
>> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>> + *	Hari Nagalla <hnagalla@ti.com>
>> + *
>> + */
>> +
>> +#include <image.h>
>> +#include <init.h>
>> +#include <spl.h>
>> +#include <stdlib.h>
> Are you sure we need all the above headers?
Ok, will cleanup
>
>> +#include "../common/fdt_ops.h"
> [...]
>
-- 
Regards,
Apurva Nandan,
Texas Instruments.

