Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A617BC61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 06:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81EA80C83;
	Tue, 10 Jun 2025 08:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XJFw5OvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A65282A65; Tue, 10 Jun 2025 08:11:25 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128768070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A6BLGI2206635;
 Tue, 10 Jun 2025 01:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749535881;
 bh=Je4skbEOVeJVkUstLisQ8yisXIge8J/Pvh1EOjakJ7w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XJFw5OvDcSKhxm6y04af+2H+iMHYhb44O8ag/3IRN09A09xFON8tYo3Fw1Xr4eUT1
 Yyk9dU0ECpJlpvmoVxjtSJFNOR1htUZz/Pc3itrJStGs/eHaeV9t+HT+mAfKPmcvkY
 qF0nyW1Lfpxsm6gWSGjpoVZ2K1FmYKnsx5kTNa0A=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A6BLSX681805
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 10 Jun 2025 01:11:21 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 01:11:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 01:11:20 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A6BKQB2602669;
 Tue, 10 Jun 2025 01:11:20 -0500
Date: Tue, 10 Jun 2025 11:41:19 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 2/3] arm: mach-k3: j784s4_init: Trigger LBIST and
 PBIST on MAIN R5 2_0
Message-ID: <20250610061119.dkygfldgupbjl7wy@uda0497581-HP>
References: <20250609102706.2434495-1-n-francis@ti.com>
 <20250609102706.2434495-3-n-francis@ti.com>
 <20250609122647.bogodkb7qm3jwqt4@uda0497581-HP>
 <5505d1fe-d2ee-4bc9-9017-9f0b70afd113@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5505d1fe-d2ee-4bc9-9017-9f0b70afd113@ti.com>
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

Hi Neha,

On 11:19-20250610, Neha Malcom Francis wrote:
> On 09/06/25 17:56, Manorit Chawdhry wrote:
> > Hi Neha,
> > 
> > On 15:57-20250609, Neha Malcom Francis wrote:
> >> Trigger all tests of PBIST and LBIST using appropriate calls to set the
> >> core under test (MAIN R5 2_0) to it's required state.
> >>
> >> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >> ---
> >> No change since v3
> >>
> >>  arch/arm/mach-k3/j784s4/j784s4_init.c | 52 +++++++++++++++++++++++++++
> >>  1 file changed, 52 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> >> index 787cf6261e4..6e21d057fb8 100644
> >> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> >> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> >> @@ -17,6 +17,7 @@
> >>  #include <dm/pinctrl.h>
> >>  #include <mmc.h>
> >>  #include <remoteproc.h>
> >> +#include <k3_bist.h>
> >>  
> >>  #include "../sysfw-loader.h"
> >>  #include "../common.h"
> >> @@ -122,6 +123,48 @@ static void setup_navss_nb(void)
> >>  	writel(NB_THREADMAP_BIT2, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
> >>  }
> >>  
> >> +/* Execute and check results of BIST executed on MCU1_x and MCU4_O */
> >> +static void run_bist_j784s4(struct udevice *dev)
> >> +{
> >> +	struct bist_ops *ops;
> >> +	struct ti_sci_handle *handle;
> >> +	int ret;
> >> +
> >> +	ops = (struct bist_ops *)device_get_ops(dev);
> >> +	handle = get_ti_sci_handle();
> >> +
> >> +	/* get status of HW POST PBIST on MCU1_x */
> >> +	if (ops->run_pbist_post())
> >> +		panic("HW POST LBIST on MCU1_x failed\n");
> >> +
> >> +	/* trigger PBIST tests on MCU4_0 */
> >> +	ret = prepare_pbist(handle);
> >> +	ret |= ops->run_pbist_neg();
> >> +	ret |= deprepare_pbist(handle);
> >> +
> >> +	ret |= prepare_pbist(handle);
> >> +	ret |= ops->run_pbist();
> >> +	ret |= deprepare_pbist(handle);
> >> +
> >> +	ret |= prepare_pbist(handle);
> >> +	ret |= ops->run_pbist_rom();
> >> +	ret |= deprepare_pbist(handle);
> >> +
> >> +	if (ret)
> >> +		panic("PBIST on MCU4_0 failed: %d\n", ret);
> >> +
> >> +	/* get status of HW POST PBIST on MCU1_x */
> >> +	if (ops->run_lbist_post())
> >> +		panic("HW POST LBIST on MCU1_x failed\n");
> >> +
> >> +	/* trigger LBIST tests on MCU1_x */
> >> +	ret = prepare_lbist(handle);
> >> +	ret |= ops->run_lbist();
> >> +	ret |= deprepare_lbist(handle);
> >> +	if (ret)
> >> +		panic("LBIST on MCU4_0 failed: %d\n", ret);
> >> +}
> >> +
> >>  /*
> >>   * This uninitialized global variable would normal end up in the .bss section,
> >>   * but the .bss is cleared between writing and reading this variable, so move
> >> @@ -251,6 +294,15 @@ void board_init_f(ulong dummy)
> >>  			printf("AVS init failed: %d\n", ret);
> >>  	}
> >>  
> >> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
> >> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> >> +						  DM_DRIVER_GET(k3_bist),
> >> +						  &dev);
> >> +		if (ret)
> >> +			panic("Failed to get BIST device: %d\n", ret);
> > 
> > nit: Add "\n" here
> 
> Didn't get you, there is already a "\n" here?
> 

I meant an additional newline.

Before: 
```
if (ret)
	panic("Failed to get BIST device: %d\n", ret);
run_bist_j784s4(dev);
```

After:
```
if (ret)
	panic("Failed to get BIST device: %d\n", ret);
<additional newline here>
run_bist_j784s4(dev);
```

Mostly after conditional statements I have seen newline and I feel it
make the code much more readable as well, wondering if it's an unsaid
convention or written somewhere else but noticed this off so commented.

> > 
> >> +		run_bist_j784s4(dev);
> >> +	}
> >> +
> >>  	if (IS_ENABLED(CONFIG_CPU_V7R))
> >>  		setup_navss_nb();
> >>  
> >> -- 
> >> 2.34.1
> >>
> > 
> > Regards,
> > Manorit
> 
> -- 
> Thanking You
> Neha Malcom Francis

Regards,
Manorit
