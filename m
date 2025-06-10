Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986DAC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 06:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1152180C83;
	Tue, 10 Jun 2025 08:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dMp3YIC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE45880E9A; Tue, 10 Jun 2025 08:05:52 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042C58070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A65mao2205785;
 Tue, 10 Jun 2025 01:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749535548;
 bh=Vu0M+RDbDi72E7Im2Cbui7Fm3yMMxc8NF0JgM5s1ehI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dMp3YIC6/fnQNtVg4Ma/RaUTsec3Fi2Mu53E3U4Z2ce05QiK1hOEaojRhP6g8KpTP
 aY3xdkT40Co5y/WOCx+gD/x6jC4ycCO9L8A2ubuyIARxVJmKYf5LlA2Yag9KydiE//
 XSQoAWcbQOo5uc0ZgdvnpqZw4GEtErDQrc5M/GZ8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A65mfJ159240
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 10 Jun 2025 01:05:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 01:05:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 01:05:47 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A65kGg2594886;
 Tue, 10 Jun 2025 01:05:47 -0500
Date: Tue, 10 Jun 2025 11:35:46 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/3] drivers: misc: k3_bist: Add K3 BIST driver
Message-ID: <20250610060546.b25xnmw7joeuquom@uda0497581-HP>
References: <20250609102706.2434495-1-n-francis@ti.com>
 <20250609102706.2434495-2-n-francis@ti.com>
 <20250609122600.heebe5xdc3bnenxa@uda0497581-HP>
 <fcafa767-0d10-4764-924b-8cd395a98d50@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcafa767-0d10-4764-924b-8cd395a98d50@ti.com>
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

On 11:17-20250610, Neha Malcom Francis wrote:
> Hi Manorit
> 
> On 09/06/25 17:56, Manorit Chawdhry wrote:
> > Hi Neha,
> > 
> > On 15:57-20250609, Neha Malcom Francis wrote:
> >> Add a driver for the BIST module that support triggering of both PBIST
> >> (Memory BIST) and LBIST (Logic BIST) tests. Also expose the relevant
> >> operations and functions that would be required for an end user to
> >> trigger the tests.
> >>
> >> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >> ---
> >> Changes since v2 and v3:
> >> - code cleanup and minor optimizations
> >> - LBIST MISR calculation modified to pick up expected value for comparison in
> >>   POST LBIST check instead of hard coding the value
> >> - moved from using ti,sci-dev-id instead of ti,bist-under-test
> >>
> >>  drivers/misc/Kconfig                      |   8 +
> >>  drivers/misc/Makefile                     |   1 +
> >>  drivers/misc/k3_bist.c                    | 807 ++++++++++++++++++++++
> >>  drivers/misc/k3_bist_static_data.h        | 673 ++++++++++++++++++
> >>  drivers/misc/k3_j784s4_bist_static_data.h | 370 ++++++++++
> >>  include/k3_bist.h                         |  44 ++
> >>  6 files changed, 1903 insertions(+)
> >>  create mode 100644 drivers/misc/k3_bist.c
> >>  create mode 100644 drivers/misc/k3_bist_static_data.h
> >>  create mode 100644 drivers/misc/k3_j784s4_bist_static_data.h
> >>  create mode 100644 include/k3_bist.h
> >>
> >> diff --git a/drivers/misc/k3_bist.c b/drivers/misc/k3_bist.c
> >> new file mode 100644
> >> index 00000000000..3acb1a1ac1f
> >> --- /dev/null
> >> +++ b/drivers/misc/k3_bist.c
> > [..]
> >> +/**
> >> + * pbist_neg_self_test() - Run PBIST_negTEST on specified cores
> >> + * @config: pbist_config_neg structure for PBIST negative test
> >> + *
> >> + * Function to run PBIST failure insertion test
> >> + *
> >> + * Return: 0 if all went fine, else corresponding error.
> >> + */
> >> +static int pbist_neg_self_test(struct pbist_config_neg *config)
> >> +{
> > [..]
> >> +	/* Set Registers*/
> >> +	writel(0x00000001, base + PBIST_RF0L);
> >> +	writel(0x00003123, base + PBIST_RF0U);
> > 
> > Do these have some meaning or are they supposed to be hardcoded?
> > Wondering if each bit corresponds to something then maybe we should make
> > some FLAGS like PBIST_RF0U_XYZ | PBIST_RF0L_ABC to make it more readable
> > but wondering if that'd be too much as well given soo many registers..
> > Don't have much idea about the IP but looking at this seems like way too
> > much magic to me..
> 
> This is an entirely hardware driven sequence with no publicly known
> bitwise meaning as I had mentioned in an earlier review as well [0].
> Values that do have a meaning have been put into macros, however for
> these sequences other than creating new generic macro names I am not
> sure what else to do.
> 

Apologies for missing out in previous reviews, thanks for sharing!

> > 
> >> +	writel(0x0513FC02, base + PBIST_RF1L);
> >> +	writel(0x00000002, base + PBIST_RF1U);
> >> +	writel(0x00000003, base + PBIST_RF2L);
> >> +	writel(0x00000000, base + PBIST_RF2U);
> >> +	writel(0x00000004, base + PBIST_RF3L);
> >> +	writel(0x00000028, base + PBIST_RF3U);
> >> +	writel(0x64000044, base + PBIST_RF4L);
> >> +	writel(0x00000000, base + PBIST_RF4U);
> >> +	writel(0x0006A006, base + PBIST_RF5L);
> >> +	writel(0x00000000, base + PBIST_RF5U);
> >> +	writel(0x00000007, base + PBIST_RF6L);
> >> +	writel(0x0000A0A0, base + PBIST_RF6U);
> >> +	writel(0x00000008, base + PBIST_RF7L);
> >> +	writel(0x00000064, base + PBIST_RF7U);
> >> +	writel(0x00000009, base + PBIST_RF8L);
> >> +	writel(0x0000A5A5, base + PBIST_RF8U);
> >> +	writel(0x0000000A, base + PBIST_RF9L);
> >> +	writel(0x00000079, base + PBIST_RF9U);
> >> +	writel(0x00000000, base + PBIST_RF10L);
> >> +	writel(0x00000001, base + PBIST_RF10U);
> >> +	writel(0xAAAAAAAA, base + PBIST_D);
> >> +	writel(0xAAAAAAAA, base + PBIST_E);
> >> +
> > [..]
> >> +/**
> >> + * pbist_rom_self_test() - Run PBIST_ROM_TEST on specified cores
> >> + * @config: pbist_config_rom structure for PBIST negative test
> >> + *
> >> + * Function to run PBIST test of ROM
> >> + *
> >> + * Return: 0 if all went fine, else corresponding error.
> >> + */
> >> +static int pbist_rom_self_test(struct pbist_config_rom *config)
> >> +{
> > [..]
> >> +
> >> +	/* Set Registers*/
> >> +	writel(0x00000001, base + PBIST_RF0L);
> >> +	writel(0x00003123, base + PBIST_RF0U);
> > 
> > Same..
> > 
> >> +	writel(0x7A400183, base + PBIST_RF1L);
> >> +	writel(0x00000060, base + PBIST_RF1U);
> >> +	writel(0x00000184, base + PBIST_RF2L);
> >> +	writel(0x00000000, base + PBIST_RF2U);
> >> +	writel(0x7B600181, base + PBIST_RF3L);
> >> +	writel(0x00000061, base + PBIST_RF3U);
> >> +	writel(0x00000000, base + PBIST_RF4L);
> >> +	writel(0x00000000, base + PBIST_RF4U);
> >> +
> > [..]
> >> +int prepare_pbist(struct ti_sci_handle *handle)
> >> +{
> >> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> >> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> >> +	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
> >> +	struct core_under_test *cut = info_pbist->cut;
> >> +
> >> +	if (proc_ops->proc_request(handle, cut[0].proc_id)) {
> >> +		printf("%s: requesting primary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (proc_ops->proc_request(handle, cut[1].proc_id)) {
> > 
> > Do we get any return code from these? If yes, then ig better to do 
> > ret = proc_ops->proc_request(handle, cut[1].proc_id))
> > and maybe print that value in printf as well which might help in debugging
> 
> I was doing that in an earlier revision [1] but moved to optimizing the
> code ignoring this ret value.

Ahh, that is bad.

Though just looked at the TI-SCI code, most of it also returns EINVAL
only so maybe it might still be okay but I think next time onwards, it
might be better to keep the ret behaviour. Incase something changes in
other layers to give different error codes, then that would get
propagated here as well and it would be helpful during failure cases but
okay for now.

Missed looking at this comment in Udit's reviews that time unfortunately.

> 
> > 
> >> +		printf("%s: requesting secondary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (dev_ops->set_device_resets(handle, cut[0].dev_id, 0x1)) {
> >> +		printf("%s: local reset primary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (dev_ops->set_device_resets(handle, cut[1].dev_id, 0x1)) {
> >> +		printf("%s: local reset secondary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (dev_ops->get_device(handle, cut[0].dev_id)) {
> >> +		printf("%s: power on primary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (dev_ops->get_device(handle, cut[1].dev_id)) {
> >> +		printf("%s: power on secondary core failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (dev_ops->get_device(handle, info_pbist->dev_id)) {
> >> +		printf("%s: power on PBIST failed\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> > [..]
> >> diff --git a/drivers/misc/k3_j784s4_bist_static_data.h b/drivers/misc/k3_j784s4_bist_static_data.h
> >> new file mode 100644
> >> index 00000000000..7f9378e917f
> >> --- /dev/null
> >> +++ b/drivers/misc/k3_j784s4_bist_static_data.h
> >> @@ -0,0 +1,370 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Static Data for Texas Instruments' BIST logic for J784S4
> >> + *
> >> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> >> + *
> >> + */
> >> +
> >> +/* Device IDs of IPs that can be tested under BIST */
> >> +#define TISCI_DEV_MCU_R5FSS2_CORE0		343
> >> +#define TISCI_DEV_MCU_R5FSS2_CORE1		344
> >> +#define TISCI_DEV_RTI32					365
> >> +#define TISCI_DEV_RTI33					366
> > 
> > Unused? 
> 
> Will clean up the unused macros thanks for catching these.
> > 
> > [..]
> > 
> >> diff --git a/include/k3_bist.h b/include/k3_bist.h
> >> new file mode 100644
> >> index 00000000000..cc650f5a8c4
> >> --- /dev/null
> >> +++ b/include/k3_bist.h
> >> @@ -0,0 +1,44 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Texas Instruments' BIST (Built-In Self-Test) driver
> >> + *
> >> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> >> + *      Neha Malcom Francis <n-francis@ti.com>
> >> + *
> >> + */
> >> +
> >> +#ifndef _INCLUDE_BIST_H_
> >> +#define _INCLUDE_BIST_H_
> >> +
> >> +#define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
> > 
> > Unused? 
> > 
> >> +#define PROC_ID_MCU_R5FSS2_CORE0		0x0A
> >> +#define PROC_ID_MCU_R5FSS2_CORE1		0x0B
> > 
> >> +#define PROC_BOOT_CTRL_FLAG_R5_LPSC		0x00000002
> > 
> > Unused? 
> > 
> >> +
> >> +#define TISCI_DEV_PBIST14 237
> >> +#define TISCI_DEV_R5FSS2_CORE0 343
> >> +#define TISCI_DEV_R5FSS2_CORE1 344
> > 
> >> +
> >> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF 0
> >> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_RETENTION 1
> >> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_ON 2
> >> +
> >> +#define TISCI_BIT(n)  ((1) << (n))
> > 
> > Unused? Also wondering that maybe these shouldn't even be here.. they
> > are tisci related..
> 
> Sorry for these, missed cleaning them out after moving to using
> ti_sci_proc_ops (see prepare_pbist() and prepare_lbist())
> 
> Will clean up these stray macros.
> 
> > 
> >> +
> >> +struct bist_ops {
> >> +	int (*run_lbist)(void);
> >> +	int (*run_lbist_post)(void);
> >> +	int (*run_pbist_post)(void);
> >> +	int (*run_pbist_neg)(void);
> >> +	int (*run_pbist_rom)(void);
> >> +	int (*run_pbist)(void);
> >> +};
> >> +
> >> +void lbist_enable_isolation(void);
> >> +void lbist_disable_isolation(void);
> >> +int prepare_pbist(struct ti_sci_handle *handle);
> >> +int deprepare_pbist(struct ti_sci_handle *handle);
> >> +int prepare_lbist(struct ti_sci_handle *handle);
> >> +int deprepare_lbist(struct ti_sci_handle *handle);
> >> +
> >> +#endif /* _INCLUDE_BIST_H_ */
> >> -- 
> >> 2.34.1
> >>
> > 
> > Regards,
> > Manorit
> 
> [0] https://lore.kernel.org/all/5198dbc7-19bc-419e-83b7-e7216269abd1@ti.com/
> [1] https://lore.kernel.org/all/c244f4af-20a9-4b52-841b-ed6435e25540@ti.com/
> 
> -- 
> Thanking You
> Neha Malcom Francis

Regards,
Manorit
