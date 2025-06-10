Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05A1C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 05:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 581FF80C83;
	Tue, 10 Jun 2025 07:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lTmr/Fyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1D980E9A; Tue, 10 Jun 2025 07:49:30 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA9258070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A5nRZO2192869;
 Tue, 10 Jun 2025 00:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749534567;
 bh=4G+JOwLSIQqoHMh6+KV5XFrpKhJmFotPDXfYayxpTAY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lTmr/FypGQ3vrXp3lIrEpuguTSOzNXGQMrGReXMYVO/Vs1tH7jLo9lDffs0vB0tKx
 OcXq6V0bGYNfxEi3Rf/xwkCpdPRv5p2GwX5M8dlBqWAOaowUri4YqHxcuZxTFGFMTw
 +5C0HDpIZqK8kLLFrRTMQGSWBryZqylgfTHJYWq0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A5nRc11900888
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 10 Jun 2025 00:49:27 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 00:49:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 00:49:26 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A5nMh42421806;
 Tue, 10 Jun 2025 00:49:23 -0500
Message-ID: <5505d1fe-d2ee-4bc9-9017-9f0b70afd113@ti.com>
Date: Tue, 10 Jun 2025 11:19:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm: mach-k3: j784s4_init: Trigger LBIST and PBIST
 on MAIN R5 2_0
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250609102706.2434495-1-n-francis@ti.com>
 <20250609102706.2434495-3-n-francis@ti.com>
 <20250609122647.bogodkb7qm3jwqt4@uda0497581-HP>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250609122647.bogodkb7qm3jwqt4@uda0497581-HP>
Content-Type: text/plain; charset="UTF-8"
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

On 09/06/25 17:56, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 15:57-20250609, Neha Malcom Francis wrote:
>> Trigger all tests of PBIST and LBIST using appropriate calls to set the
>> core under test (MAIN R5 2_0) to it's required state.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> No change since v3
>>
>>  arch/arm/mach-k3/j784s4/j784s4_init.c | 52 +++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> index 787cf6261e4..6e21d057fb8 100644
>> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
>> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> @@ -17,6 +17,7 @@
>>  #include <dm/pinctrl.h>
>>  #include <mmc.h>
>>  #include <remoteproc.h>
>> +#include <k3_bist.h>
>>  
>>  #include "../sysfw-loader.h"
>>  #include "../common.h"
>> @@ -122,6 +123,48 @@ static void setup_navss_nb(void)
>>  	writel(NB_THREADMAP_BIT2, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
>>  }
>>  
>> +/* Execute and check results of BIST executed on MCU1_x and MCU4_O */
>> +static void run_bist_j784s4(struct udevice *dev)
>> +{
>> +	struct bist_ops *ops;
>> +	struct ti_sci_handle *handle;
>> +	int ret;
>> +
>> +	ops = (struct bist_ops *)device_get_ops(dev);
>> +	handle = get_ti_sci_handle();
>> +
>> +	/* get status of HW POST PBIST on MCU1_x */
>> +	if (ops->run_pbist_post())
>> +		panic("HW POST LBIST on MCU1_x failed\n");
>> +
>> +	/* trigger PBIST tests on MCU4_0 */
>> +	ret = prepare_pbist(handle);
>> +	ret |= ops->run_pbist_neg();
>> +	ret |= deprepare_pbist(handle);
>> +
>> +	ret |= prepare_pbist(handle);
>> +	ret |= ops->run_pbist();
>> +	ret |= deprepare_pbist(handle);
>> +
>> +	ret |= prepare_pbist(handle);
>> +	ret |= ops->run_pbist_rom();
>> +	ret |= deprepare_pbist(handle);
>> +
>> +	if (ret)
>> +		panic("PBIST on MCU4_0 failed: %d\n", ret);
>> +
>> +	/* get status of HW POST PBIST on MCU1_x */
>> +	if (ops->run_lbist_post())
>> +		panic("HW POST LBIST on MCU1_x failed\n");
>> +
>> +	/* trigger LBIST tests on MCU1_x */
>> +	ret = prepare_lbist(handle);
>> +	ret |= ops->run_lbist();
>> +	ret |= deprepare_lbist(handle);
>> +	if (ret)
>> +		panic("LBIST on MCU4_0 failed: %d\n", ret);
>> +}
>> +
>>  /*
>>   * This uninitialized global variable would normal end up in the .bss section,
>>   * but the .bss is cleared between writing and reading this variable, so move
>> @@ -251,6 +294,15 @@ void board_init_f(ulong dummy)
>>  			printf("AVS init failed: %d\n", ret);
>>  	}
>>  
>> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
>> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +						  DM_DRIVER_GET(k3_bist),
>> +						  &dev);
>> +		if (ret)
>> +			panic("Failed to get BIST device: %d\n", ret);
> 
> nit: Add "\n" here

Didn't get you, there is already a "\n" here?

> 
>> +		run_bist_j784s4(dev);
>> +	}
>> +
>>  	if (IS_ENABLED(CONFIG_CPU_V7R))
>>  		setup_navss_nb();
>>  
>> -- 
>> 2.34.1
>>
> 
> Regards,
> Manorit

-- 
Thanking You
Neha Malcom Francis
