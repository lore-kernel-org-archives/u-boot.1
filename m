Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5ADC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 12:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109CF826AA;
	Mon,  9 Jun 2025 14:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b02NIVLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34BC682998; Mon,  9 Jun 2025 14:26:07 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16001811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 14:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559CQ2TI1987360;
 Mon, 9 Jun 2025 07:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749471962;
 bh=uoB+tPstMvBK2XZ28cbVPl7OTJVtaLjk/K878kU5gBo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=b02NIVLJvxzv31Jc3MC/88teWx2B536Oz8HWVFBntXndB2vC/1mCY+Lopkl0mLeQd
 pn5v8P1RHLJWULlJdSwgoKvbJlHoeOgv2twzUjB017tQgrImc0h/xy+zBodba/zASY
 FoVQ3Jq/fYCOe0pDXnk+FnbcRTBwiEhDnezMPcng=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559CQ2rw1367612
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 07:26:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 07:26:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 07:26:01 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559CQ0Ts1252708;
 Mon, 9 Jun 2025 07:26:00 -0500
Date: Mon, 9 Jun 2025 17:56:00 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/3] drivers: misc: k3_bist: Add K3 BIST driver
Message-ID: <20250609122600.heebe5xdc3bnenxa@uda0497581-HP>
References: <20250609102706.2434495-1-n-francis@ti.com>
 <20250609102706.2434495-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609102706.2434495-2-n-francis@ti.com>
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

On 15:57-20250609, Neha Malcom Francis wrote:
> Add a driver for the BIST module that support triggering of both PBIST
> (Memory BIST) and LBIST (Logic BIST) tests. Also expose the relevant
> operations and functions that would be required for an end user to
> trigger the tests.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v2 and v3:
> - code cleanup and minor optimizations
> - LBIST MISR calculation modified to pick up expected value for comparison in
>   POST LBIST check instead of hard coding the value
> - moved from using ti,sci-dev-id instead of ti,bist-under-test
> 
>  drivers/misc/Kconfig                      |   8 +
>  drivers/misc/Makefile                     |   1 +
>  drivers/misc/k3_bist.c                    | 807 ++++++++++++++++++++++
>  drivers/misc/k3_bist_static_data.h        | 673 ++++++++++++++++++
>  drivers/misc/k3_j784s4_bist_static_data.h | 370 ++++++++++
>  include/k3_bist.h                         |  44 ++
>  6 files changed, 1903 insertions(+)
>  create mode 100644 drivers/misc/k3_bist.c
>  create mode 100644 drivers/misc/k3_bist_static_data.h
>  create mode 100644 drivers/misc/k3_j784s4_bist_static_data.h
>  create mode 100644 include/k3_bist.h
> 
> diff --git a/drivers/misc/k3_bist.c b/drivers/misc/k3_bist.c
> new file mode 100644
> index 00000000000..3acb1a1ac1f
> --- /dev/null
> +++ b/drivers/misc/k3_bist.c
[..]
> +/**
> + * pbist_neg_self_test() - Run PBIST_negTEST on specified cores
> + * @config: pbist_config_neg structure for PBIST negative test
> + *
> + * Function to run PBIST failure insertion test
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +static int pbist_neg_self_test(struct pbist_config_neg *config)
> +{
[..]
> +	/* Set Registers*/
> +	writel(0x00000001, base + PBIST_RF0L);
> +	writel(0x00003123, base + PBIST_RF0U);

Do these have some meaning or are they supposed to be hardcoded?
Wondering if each bit corresponds to something then maybe we should make
some FLAGS like PBIST_RF0U_XYZ | PBIST_RF0L_ABC to make it more readable
but wondering if that'd be too much as well given soo many registers..
Don't have much idea about the IP but looking at this seems like way too
much magic to me..

> +	writel(0x0513FC02, base + PBIST_RF1L);
> +	writel(0x00000002, base + PBIST_RF1U);
> +	writel(0x00000003, base + PBIST_RF2L);
> +	writel(0x00000000, base + PBIST_RF2U);
> +	writel(0x00000004, base + PBIST_RF3L);
> +	writel(0x00000028, base + PBIST_RF3U);
> +	writel(0x64000044, base + PBIST_RF4L);
> +	writel(0x00000000, base + PBIST_RF4U);
> +	writel(0x0006A006, base + PBIST_RF5L);
> +	writel(0x00000000, base + PBIST_RF5U);
> +	writel(0x00000007, base + PBIST_RF6L);
> +	writel(0x0000A0A0, base + PBIST_RF6U);
> +	writel(0x00000008, base + PBIST_RF7L);
> +	writel(0x00000064, base + PBIST_RF7U);
> +	writel(0x00000009, base + PBIST_RF8L);
> +	writel(0x0000A5A5, base + PBIST_RF8U);
> +	writel(0x0000000A, base + PBIST_RF9L);
> +	writel(0x00000079, base + PBIST_RF9U);
> +	writel(0x00000000, base + PBIST_RF10L);
> +	writel(0x00000001, base + PBIST_RF10U);
> +	writel(0xAAAAAAAA, base + PBIST_D);
> +	writel(0xAAAAAAAA, base + PBIST_E);
> +
[..]
> +/**
> + * pbist_rom_self_test() - Run PBIST_ROM_TEST on specified cores
> + * @config: pbist_config_rom structure for PBIST negative test
> + *
> + * Function to run PBIST test of ROM
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +static int pbist_rom_self_test(struct pbist_config_rom *config)
> +{
[..]
> +
> +	/* Set Registers*/
> +	writel(0x00000001, base + PBIST_RF0L);
> +	writel(0x00003123, base + PBIST_RF0U);

Same..

> +	writel(0x7A400183, base + PBIST_RF1L);
> +	writel(0x00000060, base + PBIST_RF1U);
> +	writel(0x00000184, base + PBIST_RF2L);
> +	writel(0x00000000, base + PBIST_RF2U);
> +	writel(0x7B600181, base + PBIST_RF3L);
> +	writel(0x00000061, base + PBIST_RF3U);
> +	writel(0x00000000, base + PBIST_RF4L);
> +	writel(0x00000000, base + PBIST_RF4U);
> +
[..]
> +int prepare_pbist(struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> +	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
> +	struct core_under_test *cut = info_pbist->cut;
> +
> +	if (proc_ops->proc_request(handle, cut[0].proc_id)) {
> +		printf("%s: requesting primary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (proc_ops->proc_request(handle, cut[1].proc_id)) {

Do we get any return code from these? If yes, then ig better to do 
ret = proc_ops->proc_request(handle, cut[1].proc_id))
and maybe print that value in printf as well which might help in debugging

> +		printf("%s: requesting secondary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (dev_ops->set_device_resets(handle, cut[0].dev_id, 0x1)) {
> +		printf("%s: local reset primary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (dev_ops->set_device_resets(handle, cut[1].dev_id, 0x1)) {
> +		printf("%s: local reset secondary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (dev_ops->get_device(handle, cut[0].dev_id)) {
> +		printf("%s: power on primary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (dev_ops->get_device(handle, cut[1].dev_id)) {
> +		printf("%s: power on secondary core failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (dev_ops->get_device(handle, info_pbist->dev_id)) {
> +		printf("%s: power on PBIST failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
[..]
> diff --git a/drivers/misc/k3_j784s4_bist_static_data.h b/drivers/misc/k3_j784s4_bist_static_data.h
> new file mode 100644
> index 00000000000..7f9378e917f
> --- /dev/null
> +++ b/drivers/misc/k3_j784s4_bist_static_data.h
> @@ -0,0 +1,370 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Static Data for Texas Instruments' BIST logic for J784S4
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +/* Device IDs of IPs that can be tested under BIST */
> +#define TISCI_DEV_MCU_R5FSS2_CORE0		343
> +#define TISCI_DEV_MCU_R5FSS2_CORE1		344
> +#define TISCI_DEV_RTI32					365
> +#define TISCI_DEV_RTI33					366

Unused? 

[..]

> diff --git a/include/k3_bist.h b/include/k3_bist.h
> new file mode 100644
> index 00000000000..cc650f5a8c4
> --- /dev/null
> +++ b/include/k3_bist.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Texas Instruments' BIST (Built-In Self-Test) driver
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + *      Neha Malcom Francis <n-francis@ti.com>
> + *
> + */
> +
> +#ifndef _INCLUDE_BIST_H_
> +#define _INCLUDE_BIST_H_
> +
> +#define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001

Unused? 

> +#define PROC_ID_MCU_R5FSS2_CORE0		0x0A
> +#define PROC_ID_MCU_R5FSS2_CORE1		0x0B

> +#define PROC_BOOT_CTRL_FLAG_R5_LPSC		0x00000002

Unused? 

> +
> +#define TISCI_DEV_PBIST14 237
> +#define TISCI_DEV_R5FSS2_CORE0 343
> +#define TISCI_DEV_R5FSS2_CORE1 344

> +
> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF 0
> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_RETENTION 1
> +#define TISCI_MSG_VALUE_DEVICE_SW_STATE_ON 2
> +
> +#define TISCI_BIT(n)  ((1) << (n))

Unused? Also wondering that maybe these shouldn't even be here.. they
are tisci related..

> +
> +struct bist_ops {
> +	int (*run_lbist)(void);
> +	int (*run_lbist_post)(void);
> +	int (*run_pbist_post)(void);
> +	int (*run_pbist_neg)(void);
> +	int (*run_pbist_rom)(void);
> +	int (*run_pbist)(void);
> +};
> +
> +void lbist_enable_isolation(void);
> +void lbist_disable_isolation(void);
> +int prepare_pbist(struct ti_sci_handle *handle);
> +int deprepare_pbist(struct ti_sci_handle *handle);
> +int prepare_lbist(struct ti_sci_handle *handle);
> +int deprepare_lbist(struct ti_sci_handle *handle);
> +
> +#endif /* _INCLUDE_BIST_H_ */
> -- 
> 2.34.1
> 

Regards,
Manorit
