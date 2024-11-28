Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8823D5E39F
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 04:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212DD893D0;
	Thu, 28 Nov 2024 05:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YFUnS6Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74915893AE; Thu, 28 Nov 2024 05:56:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD638980E
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 05:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AS4upNx033759;
 Wed, 27 Nov 2024 22:56:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732769811;
 bh=31iR+0xgfTDPBIeIu+XvuHVV+jMsDaZa8jvHD3OfyoU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YFUnS6Z82NdoX3mo74hzTs+kTDskDnMNM09x1hWJxA/HVyVL0WxvbG/C1sJHY1O3D
 PEtgtncPoej4cB/WA8qS/hQae2Akg8vDQTu1H1w6yPqQU2FxvX0AQ/gYpg4pHY+2D3
 Wt0P0KH67LKrF2AqeNUAEtb3jTTAvWItjnuftMf4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS4upip120712;
 Wed, 27 Nov 2024 22:56:51 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 22:56:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 22:56:51 -0600
Received: from [172.24.23.130] (lt5cd2489kgj.dhcp.ti.com [172.24.23.130])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS4ulWY107934;
 Wed, 27 Nov 2024 22:56:47 -0600
Message-ID: <090cc631-4511-4094-ae69-55cfd46d25f8@ti.com>
Date: Thu, 28 Nov 2024 10:26:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers: misc: k3_bist: Add K3 BIST driver
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20241127145346.2609868-1-n-francis@ti.com>
 <20241127145346.2609868-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241127145346.2609868-3-n-francis@ti.com>
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


On 11/27/2024 8:23 PM, Neha Malcom Francis wrote:
> Add a driver for the BIST module that support triggering of both PBIST
> (Memory BIST) and LBIST (Logic BIST) tests. Also expose the relevant

In general , please think of treating err as error in prints instead of 
debug ,

Also, few function could be moved to static,

> operations and functions that would be required for an end user to
> trigger the tests.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/misc/Kconfig                |   8 +
>   drivers/misc/Makefile               |   1 +
>   drivers/misc/k3_bist.c              | 856 ++++++++++++++++++++++++++++
>   drivers/misc/k3_bist_static_data.h  | 576 +++++++++++++++++++
>   drivers/misc/k3_lbist_static_data.h | 460 +++++++++++++++
>   include/k3_bist.h                   |  44 ++
>   6 files changed, 1945 insertions(+)
>   create mode 100644 drivers/misc/k3_bist.c
>   create mode 100644 drivers/misc/k3_bist_static_data.h
>   create mode 100644 drivers/misc/k3_lbist_static_data.h
>   create mode 100644 include/k3_bist.h
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6009d55f400..8e28a93d74c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -664,6 +664,14 @@ config ESM_K3
>   	help
>   	  Support ESM (Error Signaling Module) on TI K3 SoCs.
>   
> +config K3_BIST
> +	bool "Enable K3 BIST driver"
> +	depends on ARCH_K3
> +	help
> +	  Support BIST (Built-In Self Test) module on TI K3 SoCs. This driver
> +	  supports running both PBIST (Memory BIST) and LBIST (Logic BIST) on
> +	  a region or IP in the SoC.
> +
>   config MICROCHIP_FLEXCOM
>   	bool "Enable Microchip Flexcom driver"
>   	depends on MISC
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index dac805e4cdd..c9100c93c3c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
>   obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
>   obj-$(CONFIG_K3_AVS0) += k3_avs.o
>   obj-$(CONFIG_ESM_K3) += k3_esm.o
> +obj-$(CONFIG_K3_BIST) += k3_bist.o
>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
> diff --git a/drivers/misc/k3_bist.c b/drivers/misc/k3_bist.c
> new file mode 100644
> index 00000000000..1a8ce4db8bf
> --- /dev/null
> +++ b/drivers/misc/k3_bist.c
> @@ -0,0 +1,856 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Texas Instruments' BIST (Built-In Self-Test) driver
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *      Neha Malcom Francis <n-francis@ti.com>
> + *
> + */
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <clk.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <asm/arch/hardware.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +#include <remoteproc.h>
> +#include <power-domain.h>
> +#include <k3_bist.h>
> +
> +#include "k3_bist_static_data.h"
> +#include "k3_lbist_static_data.h"
> +
> +/* PBIST Timeout Value */
> +#define PBIST_MAX_TIMEOUT_VALUE		100000000
> +
> +/**
> + * struct k3_bist_privdata - K3 BIST structure
> + * @dev: device pointer
> + * @pbist_base: base of register set for PBIST
> + * @instance: PBIST instance number
> + * @intr_num: corresponding interrupt ID of the PBIST instance
> + * @lbist_ctrl_mmr: base of CTRL MMR register set for LBIST
> + */
> +struct k3_bist_privdata {
> +	struct udevice *dev;
> +	void *pbist_base;
> +	u32 instance;
> +	u32 intr_num;
> +	void *lbist_ctrl_mmr;
> +	struct pbist_inst_info *pbist_info;
> +	struct lbist_inst_info *lbist_info;
> +};
> +
> +static struct k3_bist_privdata *k3_bist_priv;
> +
> +/**
> + * check_post_pbist_result() - Check POST results
> + *
> + * Function to check whether HW Power-On Self Test, i.e. POST has run
> + * successfully on the MCU domain.
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int check_post_pbist_result(void)
> +{
> +	bool is_done, timed_out;
> +	u32 mask;
> +	u32 post_reg_val, shift;
> +
> +	/* Read HW POST status register */
> +	post_reg_val = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
> +
> +	/* Check if HW POST PBIST was performed */
> +	shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT;
> +	is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
> +
> +	if (!is_done) {
> +		/* HW POST: PBIST not completed, check if it timed out */
> +		shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT;
> +		timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
> +
> +		if (!timed_out) {
> +			debug("%s: PBIST was not performed at all on this device for this core\n",
> +			      __func__);
> +			return -EINVAL;

debug to error print


> +		} else {
> +			debug("%s: PBIST was attempted but timed out for this section\n", __func__);
> +			return -ETIMEDOUT;

debug to error print


> +		}
> +	} else {
> +		/* HW POST: PBIST was completed on this device, check the result */
> +		mask = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK;
> +
> +		if ((post_reg_val & mask) != 0) {
> +			debug("%s: PBIST was completed, but the test failed\n", __func__);
debug to error print
> +			return -EINVAL;
> +		} else {
> +			debug("%s: HW POST PBIST completed, test passed\n", __func__);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * check_post_lbist_result() - Check POST results
> + *
> + * Function to check whether HW Power-On Self Test, i.e. POST has run
> + * successfully on the MCU domain.
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int check_post_lbist_result(void)
> +{
> +	bool is_done, timed_out;
> +	u32 post_reg_val, shift;
> +	u32 calculated_misr, expected_misr;
> +
> +	/* Read HW POST status register */
> +	post_reg_val = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
> +
> +	/* Check if HW POST LBIST was performed */
> +	shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_DONE_SHIFT;
> +	is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
> +
> +	if (!is_done) {
> +		/* HW POST: PBIST not completed, check if it timed out */
> +		shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_TIMEOUT_SHIFT;
> +		timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : (bool)false;
> +
> +		if (!timed_out) {
> +			debug("%s: PBIST was not performed at all on this device for this core\n",
> +			      __func__);
debug to error print
> +			return -EINVAL;
> +		} else {
> +			debug("%s: PBIST was attempted but timed out for this section\n", __func__);
debug to error print
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		/* Get the output MISR and the expected MISR */
> +		lbist_get_misr((void *)0x40f0c000, &calculated_misr);
> +		expected_misr = 0; // expected misr is 0 for MCU domain
> +
> +		if (calculated_misr != expected_misr) {
> +			/* HW POST: LBIST was completed, but the test failed for this core */
> +			debug("%s: calculated MISR != expected MISR\n", __func__);
debug to error print
> +			return -EINVAL;
> +		} else {
> +			debug("%s: HW POST LBIST completed, test passed\n", __func__);
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pbist_self_test() - Run PBIST_TEST on specified cores
> + * @config: pbist_config structure for PBIST test
> + *
> + * Function to run PBIST_TEST
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int pbist_self_test(struct pbist_config *config)
> +{
> +	void *base = k3_bist_priv->pbist_base;
> +
> +	/* Turns on PBIST clock in PBIST ACTivate register */
> +	writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
> +
> +	/* Set Margin mode register for Test mode */
> +	writel(PBIST_TEST_MODE, base + PBIST_MARGIN_MODE);
> +
> +	/* Zero out Loop counter 0 */
> +	writel(0x0, base + PBIST_L0);
> +
> +	/* Set algorithm bitmap */
> +	writel(config->algorithms_bit_map, base + PBIST_ALGO);
> +
> +	/* Set Memory group bitmap */
> +	writel(config->memory_groups_bit_map, base + PBIST_RINFO);
> +
> +	/* Zero out override register */
> +	writel(config->override, base + PBIST_OVER);
> +
> +	/* Set Scramble value - 64 bit*/
> +	writel(config->scramble_value_lo, base + PBIST_SCR_LO);
> +	writel(config->scramble_value_hi, base + PBIST_SCR_HI);
> +
> +	/* Set DLR register for ROM based testing and Config Access */
> +	writel(PBIST_DLR_DLR0_ROM_MASK
> +	| PBIST_DLR_DLR0_CAM_MASK, base + PBIST_DLR);
> +
> +	udelay(1000);

Please put some comments, why you need this delay


> +
> +	if (readl(base + PBIST_FSRF) == 0) {
> +		debug("%s: test passed\n", __func__);
> +	} else {
> +		debug("%s: test failed\n", __func__);
> +		return -EINVAL;
> +	}

May be you can do

if (readl(base + PBIST_FSRF) {
         printf ("%s: test failed\n", __func__);
	return -EINVAL;

}

> +
> +	return 0;
> +}
> +
> +/**
> + * pbist_neg_self_test() - Run PBIST_negTEST on specified cores
> + * @config: pbist_config_neg structure for PBIST negative test
> + *
> + * Function to run PBIST failure insertion test
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int pbist_neg_self_test(struct pbist_config_neg *config)
> +{
> +	void *base = k3_bist_priv->pbist_base;
> +
> +	/* Turns on PBIST clock in PBIST ACTivate register */
> +	writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
> +
> +	/* Set Margin mode register for Test mode */
> +	writel(PBIST_FAILURE_INSERTION_TEST_MODE, base + PBIST_MARGIN_MODE);
> +
> +	/* Zero out Loop counter 0 */
> +	writel(0x0, base + PBIST_L0);
> +
> +	/* Set DLR register */
> +	writel(0x10, base + PBIST_DLR);
> +
> +	/* Set Registers*/
> +	writel(0x00000001, base + PBIST_RF0L);
> +	writel(0x00003123, base + PBIST_RF0U);
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
> +	writel(config->CA2, base + PBIST_CA2);
> +	writel(config->CL0, base + PBIST_CL0);
> +	writel(config->CA3, base + PBIST_CA3);
> +	writel(config->I0, base + PBIST_I0);
> +	writel(config->CL1, base + PBIST_CL1);
> +	writel(config->I3, base + PBIST_I3);
> +	writel(config->I2, base + PBIST_I2);
> +	writel(config->CL2, base + PBIST_CL2);
> +	writel(config->CA1, base + PBIST_CA1);
> +	writel(config->CA0, base + PBIST_CA0);
> +	writel(config->CL3, base + PBIST_CL3);
> +	writel(config->I1, base + PBIST_I1);
> +	writel(config->RAMT, base + PBIST_RAMT);
> +	writel(config->CSR, base + PBIST_CSR);
> +	writel(config->CMS, base + PBIST_CMS);
> +
> +	writel(0x00000009, base + PBIST_STR);
> +
> +	/* Start PBIST */
> +	writel(0x00000001, base + PBIST_STR);
> +
> +	udelay(1000);
> +
> +	if (readl(base + PBIST_FSRF) != 0) {
> +		debug("%s: test passed\n", __func__);
> +	} else {
> +		debug("%s: test failed %x\n", __func__, readl(base + PBIST_FSRF));
> +		return -EINVAL;
> +	}

Please think to combine this if-else loop


> +
> +	return 0;
> +}
> +
> +/**
> + * pbist_rom_self_test() - Run PBIST_ROM_TEST on specified cores
> + * @config: pbist_config_rom structure for PBIST negative test
> + *
> + * Function to run PBIST test of ROM
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int pbist_rom_self_test(struct pbist_config_rom *config)
> +{
> +	void *base = k3_bist_priv->pbist_base;
> +
> +	/* Turns on PBIST clock in PBIST ACTivate register */
> +	writel(0x1, base + PBIST_PACT);
> +
> +	/* Set Margin mode register for Test mode */
> +	writel(0xf, base + PBIST_MARGIN_MODE);
> +
> +	/* Zero out Loop counter 0 */
> +	writel(0x0, base + PBIST_L0);
> +
> +	/* Set DLR register */
> +	writel(0x310, base + PBIST_DLR);
> +
> +	/* Set Registers*/
> +	writel(0x00000001, base + PBIST_RF0L);
> +	writel(0x00003123, base + PBIST_RF0U);
> +	writel(0x7A400183, base + PBIST_RF1L);
> +	writel(0x00000060, base + PBIST_RF1U);
> +	writel(0x00000184, base + PBIST_RF2L);
> +	writel(0x00000000, base + PBIST_RF2U);
> +	writel(0x7B600181, base + PBIST_RF3L);
> +	writel(0x00000061, base + PBIST_RF3U);
> +	writel(0x00000000, base + PBIST_RF4L);
> +	writel(0x00000000, base + PBIST_RF4U);
> +
> +	writel(config->D, base + PBIST_D);
> +	writel(config->E, base + PBIST_E);
> +	writel(config->CA2, base + PBIST_CA2);
> +	writel(config->CL0, base + PBIST_CL0);
> +	writel(config->CA3, base + PBIST_CA3);
> +	writel(config->I0, base + PBIST_I0);
> +	writel(config->CL1, base + PBIST_CL1);
> +	writel(config->I3, base + PBIST_I3);
> +	writel(config->I2, base + PBIST_I2);
> +	writel(config->CL2, base + PBIST_CL2);
> +	writel(config->CA1, base + PBIST_CA1);
> +	writel(config->CA0, base + PBIST_CA0);
> +	writel(config->CL3, base + PBIST_CL3);
> +	writel(config->I1, base + PBIST_I1);
> +	writel(config->RAMT, base + PBIST_RAMT);
> +	writel(config->CSR, base + PBIST_CSR);
> +	writel(config->CMS, base + PBIST_CMS);
> +
> +	writel(0x00000009, base + PBIST_STR);
> +
> +	/* Start PBIST */
> +	writel(0x00000001, base + PBIST_STR);
> +
> +	udelay(1000);
> +
> +	if (readl(base + PBIST_FSRF) == 0) {
> +		debug("%s: test passed\n", __func__);
> +	} else {
> +		debug("%s: test failed\n", __func__);
> +		return -EINVAL;
> +	}
Same as above
> +
> +	return 0;
> +}
> +
> +/**
> + * lbist_program_config() - Program LBIST config
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.

function is void, please review your above


> + */
> +void lbist_program_config(struct lbist_config *config)
> +{
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +
> +	lbist_set_clock_delay(base, config->dc_def);
> +	lbist_set_divide_ratio(base, config->divide_ratio);
> +	lbist_clear_load_div(base);
> +	lbist_set_load_div(base);
> +	lbist_set_num_stuck_at_patterns(base, config->static_pc_def);
> +	lbist_set_num_set_patterns(base, config->set_pc_def);
> +	lbist_set_num_reset_patterns(base, config->reset_pc_def);
> +	lbist_set_num_chain_test_patterns(base, config->scan_pc_def);
> +	lbist_set_seed(base, config->prpg_def_l, config->prpg_def_u);
> +}
> +
> +/**
> + * lbist_enable_isolation() - LBIST Enable Isolation
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.
^^ same here
> + */
> +void lbist_enable_isolation(void)
> +{
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +	u32 reg_val;
> +
> +	reg_val = readl(base + SDL_LBIST_SPARE0);
> +	writel(reg_val | (SDL_LBIST_SPARE0_LBIST_SELFTEST_EN_MASK), base + SDL_LBIST_SPARE0);
> +}
> +
> +/**
> + * lbist_disable_isolation() - LBIST Disable Isolation
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.
same
> + */
> +void lbist_disable_isolation(void)
> +{
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +	u32 reg_val;
> +
> +	reg_val = readl(base + SDL_LBIST_SPARE0);
> +	writel(reg_val & (~(SDL_LBIST_SPARE0_LBIST_SELFTEST_EN_MASK)), base + SDL_LBIST_SPARE0);
> +}
> +
> +/**
> + * lbist_enable_run_bist_mode() - LBIST Enable run BIST mode
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.
same
> + */
> +void lbist_enable_run_bist_mode(struct lbist_config *config)
> +{
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +	u32 reg_val;
> +
> +	reg_val = readl(base + SDL_LBIST_CTRL);
> +	writel(reg_val | (SDL_LBIST_CTRL_RUNBIST_MODE_MAX << SDL_LBIST_CTRL_RUNBIST_MODE_SHIFT),
> +	       base + SDL_LBIST_CTRL);
> +}
> +
> +/**
> + * lbist_start() - Start LBIST test
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +void lbist_start(struct lbist_config *config)
> +{
> +	struct udevice *dev = k3_bist_priv->dev;
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +	u32 reg_val;
> +	u32 timeout_count = 0;
> +
> +	reg_val = readl(base + SDL_LBIST_CTRL);
> +	writel(reg_val | (SDL_LBIST_CTRL_BIST_RESET_MAX << SDL_LBIST_CTRL_BIST_RESET_SHIFT),
> +	       base + SDL_LBIST_CTRL);
> +
> +	reg_val = readl(base + SDL_LBIST_CTRL);
> +	writel(reg_val | (SDL_LBIST_CTRL_BIST_RUN_MAX << SDL_LBIST_CTRL_BIST_RUN_SHIFT),
> +	       base + SDL_LBIST_CTRL);
> +
> +	reg_val = readl(base + SDL_LBIST_STAT);
> +	if ((reg_val & SDL_LBIST_STAT_BIST_RUNNING_MASK) != 0)
> +		debug("%s(dev=%p): LBIST is running\n", __func__, dev);
> +	else
> +		debug("%s(dev=%p): LBIST is not running\n", __func__, dev);
optimize above please
> +
> +	while (((!(readl(base + SDL_LBIST_STAT) & SDL_LBIST_STAT_BIST_DONE_MASK))) &&
> +	       (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE)) {
> +	}
> +
> +	if (!(readl(base + SDL_LBIST_STAT) & SDL_LBIST_STAT_BIST_DONE_MASK))
> +		debug("%s(dev=%p): test failed\n", __func__, dev);
> +	else
> +		debug("%s(dev=%p): test passed\n", __func__, dev);
optimize above please
> +}
> +
> +/**
> + * lbist_check_result() - Check LBIST test result
> + * @config: lbist_config structure for LBIST test
> + *
> + * Return: 0 if all went fine, else corresponding error.
> + */
> +int lbist_check_result(struct lbist_config *config)
> +{
> +	void *base = k3_bist_priv->lbist_ctrl_mmr;
> +	struct lbist_inst_info *info = k3_bist_priv->lbist_info;
> +	u32 calculated_misr;
> +	u32 expected_misr;
> +
> +	lbist_get_misr(base, &calculated_misr);
> +	expected_misr = info->expected_misr;
> +	lbist_clear_run_bist_mode(base);
> +	lbist_stop(base);
> +	lbist_reset(base);
> +
> +	if (calculated_misr != expected_misr) {
> +		debug("calculated_misr != expected_misr\n %x %x\n", calculated_misr, expected_misr);
> +		return -EINVAL;
> +	} else {
> +		debug("calculated_misr == expected_misr\n");
> +	}
optimize above please
> +
> +	return 0;
> +}
> +
> +int k3_run_lbist(void)
> +{
> +	/* Check whether HW POST successfully completely LBIST on the MCU domain */
> +	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
> +	int ret;
> +
> +	lbist_program_config(&info_lbist->lbist_conf);
> +	lbist_enable_isolation();
> +	lbist_reset(&info_lbist->lbist_conf);
> +	lbist_enable_run_bist_mode(&info_lbist->lbist_conf);
> +	lbist_start(&info_lbist->lbist_conf);
> +	ret = lbist_check_result(&info_lbist->lbist_conf);
> +	if (ret) {
> +		debug("%s: test failed\n", __func__);

Move to printf , instead of debug


> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int k3_run_lbist_post(void)
> +{
> +	int ret = check_post_lbist_result();
> +
> +	if (ret) {
> +		printf("HW POST LBIST failed to run successfully %d\n", ret);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int k3_run_pbist_post(void)
> +{
> +	int ret = 0;
> +	/* Check whether HW POST successfully completely PBIST on the MCU domain */
> +	ret = check_post_pbist_result();
> +	if (ret) {
> +		printf("HW POST failed to run successfully %d\n", ret);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int k3_run_pbist(void)
> +{
> +	/* Run PBIST test */
> +	int j = 0, ret = 0;
> +	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
> +	int num_runs = info->num_pbist_runs;
> +
> +	for (j = 0; j < num_runs; j++) {
> +		ret = pbist_self_test(&info->pbist_config_run[j]);
> +		if (ret) {
> +			printf("failed to run PBIST test %d\n", ret);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int k3_run_pbist_neg(void)
> +{
> +	/* Run PBIST failure insertion test */
> +	int ret = 0;
> +	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
> +
> +	ret = pbist_neg_self_test(&info->pbist_neg_config_run);
> +	if (ret) {
> +		printf("failed to run PBIST negative test %d\n", ret);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int k3_run_pbist_rom(void)
> +{
> +	/* Run PBIST test on ROM */
> +	int j = 0, ret = 0;
> +	struct pbist_inst_info *info = k3_bist_priv->pbist_info;
> +	int num_runs = info->num_pbist_rom_test_runs;
> +
> +	for (j = 0; j < num_runs; j++) {
> +		ret = pbist_rom_self_test(&info->pbist_rom_test_config_run[j]);
> +		if (ret) {
> +			printf("failed to run ROM PBIST test %d\n", ret);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +void prepare_pbist(struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> +	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
> +	struct core_under_test *cut = info_pbist->cut;
> +
> +	int ret = 0;
> +
> +	ret = proc_ops->proc_request(handle, cut[0].proc_id);
> +	if (ret)
> +		debug("%s: requesting primary core failed\n", __func__);
> +	else
> +		debug("%s: requesting primary core passed\n", __func__);

you can print only case of error, and with error code

> +
> +	ret = proc_ops->proc_request(handle, cut[1].proc_id);
you want to over write previous error code and continue in case of error ?
> +	if (ret)
> +		debug("%s: requesting secondary core failed\n", __func__);
> +	else
> +		debug("%s: requesting secondary core passed\n", __func__);
> +
> +	ret = dev_ops->set_device_resets(handle, cut[0].dev_id, 0x1);
> +	if (ret)
> +		debug("%s: local reset primary core failed\n", __func__);
> +	else
> +		debug("%s: local reset primary core passed\n", __func__);
> +
> +	ret = dev_ops->set_device_resets(handle, cut[1].dev_id, 0x1);
> +	if (ret)
> +		debug("%s: local reset secondary core failed\n", __func__);
> +	else
> +		debug("%s: local reset secondary core passed\n", __func__);
> +
> +	ret = dev_ops->get_device(handle, cut[0].dev_id);
> +	if (ret)
> +		debug("%s: power on primary core failed\n", __func__);
> +	else
> +		debug("%s: power on primary core passed\n", __func__);
> +
> +	ret = dev_ops->get_device(handle, cut[1].dev_id);
> +	if (ret)
> +		debug("%s: power on secondary core failed\n", __func__);
> +	else
> +		debug("%s: power on secondary core passed\n", __func__);
> +
> +	ret = dev_ops->get_device(handle, info_pbist->dev_id);
> +	if (ret)
> +		debug("%s: power on PBIST failed\n", __func__);
> +	else
> +		debug("%s: power on PBIST passed\n", __func__);
> +}
> +
> +void deprepare_pbist(struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> +	struct pbist_inst_info *info_pbist = k3_bist_priv->pbist_info;
> +	struct core_under_test *cut = info_pbist->cut;
> +
> +	int ret = 0;
> +
> +	ret = dev_ops->put_device(handle, info_pbist->dev_id);
> +	if (ret)
> +		debug("%s: power off PBIST failed\n", __func__);
> +	else
> +		debug("%s: power off PBIST passed\n", __func__);

same as in prepare function


> +
> +	ret = dev_ops->put_device(handle, cut[1].dev_id);
> +	if (ret)
> +		debug("%s: power off secondary core failed\n", __func__);
> +	else
> +		debug("%s: power off secondary core passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, cut[0].dev_id);
> +	if (ret)
> +		debug("%s: power off primary core failed\n", __func__);
> +	else
> +		debug("%s: power off primary core passed\n", __func__);
> +
> +	ret = dev_ops->set_device_resets(handle, cut[0].dev_id, 0);
> +	if (ret)
> +		debug("%s: putting primary core out of local reset failed\n", __func__);
> +	else
> +		debug("%s: putting primary core out of local reset passed\n", __func__);
> +
> +	ret = dev_ops->set_device_resets(handle, cut[1].dev_id, 0);
> +	if (ret)
> +		debug("%s: putting secondary core out of local reset failed\n", __func__);
> +	else
> +		debug("%s: putting secondary core out of local reset passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, cut[0].dev_id);
> +	if (ret)
> +		debug("%s: power off primary core failed\n", __func__);
> +	else
> +		debug("%s: power off primary core passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, cut[1].dev_id);
> +	if (ret)
> +		debug("%s: power off secondary core failed\n", __func__);
> +	else
> +		debug("%s: power off secondary core passed\n", __func__);
> +
> +	ret = proc_ops->proc_release(handle, cut[0].proc_id);
> +	if (ret)
> +		debug("%s: release primary core failed\n", __func__);
> +	else
> +		debug("%s: release primary core passed\n", __func__);
> +
> +	ret = proc_ops->proc_release(handle, cut[1].proc_id);
> +	if (ret)
> +		debug("%s: release secondary core failed\n", __func__);
> +	else
> +		debug("%s: release secondary core passed\n", __func__);
> +}
> +
> +void prepare_lbist(struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> +	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
> +	struct core_under_test *cut = &info_lbist->cut;
> +
> +	int ret = 0;
> +
> +	ret = proc_ops->proc_request(handle, cut->proc_id);
> +	if (ret)
> +		debug("%s: requesting primary core failed\n", __func__);
> +	else
> +		debug("%s: requesting primary core passed\n", __func__);
> +
same as above
> +	ret = dev_ops->set_device_resets(handle, cut->dev_id, 0x3);
> +	if (ret)
> +		debug("%s: module and local reset primary core failed\n", __func__);
> +	else
> +		debug("%s: module and local reset primary core passed\n", __func__);
> +
> +	ret = dev_ops->idle_device(handle, cut->dev_id);
> +	if (ret)
> +		debug("%s: putting primary core into retention failed\n", __func__);
> +	else
> +		debug("%s: putting primary core into retention passed\n", __func__);
> +}
> +
> +void deprepare_lbist(struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_proc_ops *proc_ops = &handle->ops.proc_ops;
> +	struct ti_sci_dev_ops *dev_ops = &handle->ops.dev_ops;
> +	struct lbist_inst_info *info_lbist = k3_bist_priv->lbist_info;
> +	struct core_under_test *cut = &info_lbist->cut;
> +
> +	int ret = 0;
> +
> +	ret = dev_ops->put_device(handle, 0);
same as above
> +	if (ret)
> +		debug("%s: power off secondary core failed\n", __func__);
> +	else
> +		debug("%s: power off secondary core passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, cut->dev_id);
> +	if (ret)
> +		debug("%s: power off primary core failed\n", __func__);
> +	else
> +		debug("%s: power off primary core passed\n", __func__);
> +
> +	lbist_disable_isolation();
> +
> +	ret = dev_ops->idle_device(handle, cut->dev_id);
> +	if (ret)
> +		debug("%s: retention primary core failed\n", __func__);
> +	else
> +		debug("%s: retention primary core passed\n", __func__);
> +
> +	ret = dev_ops->idle_device(handle, 0);
> +	if (ret)
> +		debug("%s: retention secondary core failed\n", __func__);
> +	else
> +		debug("%s: retention secondary core passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, 0);
> +	if (ret)
> +		debug("%s: power off secondary core failed\n", __func__);
> +	else
> +		debug("%s: power off secondary core passed\n", __func__);
> +
> +	ret = dev_ops->put_device(handle, cut->dev_id);
> +	if (ret)
> +		debug("%s: power off primary core failed\n", __func__);
> +	else
> +		debug("%s: power off primary core passed\n", __func__);
> +
> +	ret = dev_ops->set_device_resets(handle, cut->dev_id, 0);
> +	if (ret)
> +		debug("%s: putting primary core out of local reset failed\n", __func__);
> +	else
> +		debug("%s: putting primary core out of local reset passed\n", __func__);
> +
> +	ret = proc_ops->proc_release(handle, cut->proc_id);
> +	if (ret)
> +		debug("%s: release primary core failed\n", __func__);
> +	else
> +		debug("%s: release primary core passed\n", __func__);
> +}
> +
> +/**
> + * k3_bist_probe() - Basic probe
> + * @dev: corresponding BIST device
> + *
> + * Parses BIST info from device tree, and configures the module accordingly.
> + * Return: 0 if all goes good, else appropriate error message.
> + */
> +static int k3_bist_probe(struct udevice *dev)
> +{
> +	int ret = 0;
> +	struct k3_bist_privdata *priv = dev_get_priv(dev);
> +	struct pbist_inst_info *info;
> +	struct lbist_inst_info *info_lbist;
> +	void *reg;
> +
> +	debug("%s(dev=%p)\n", __func__, dev);
> +
> +	priv = dev_get_priv(dev);
> +	priv->dev = dev;
> +
> +	k3_bist_priv = priv;
> +
> +	reg = dev_read_addr_name_ptr(dev, "cfg");
> +	if (!reg) {
> +		dev_err(dev, "No reg property for BIST\n");
> +		return -EINVAL;
> +	}
> +	priv->pbist_base = reg;
> +
> +	reg = dev_read_addr_name_ptr(dev, "ctrl_mmr");
> +	if (!reg) {
> +		dev_err(dev, "No reg property for CTRL MMR\n");
> +		return -EINVAL;
> +	}
> +	priv->lbist_ctrl_mmr = reg;
> +
> +	ret = dev_read_u32(dev, "ti,bist-instance", &priv->instance);
> +	if (!priv->instance)
> +		return -ENODEV;
> +
> +	switch (priv->instance) {
> +	case PBIST14_INSTANCE:
> +		priv->pbist_info = &pbist14_inst_info;
> +		priv->lbist_info = &lbist_inst_info_main_r5f2_x;
> +		info = priv->pbist_info;
> +		info_lbist = priv->lbist_info;
> +		priv->intr_num = info->intr_num;
> +		break;
> +	default:
> +		dev_err(dev, "%s: PBIST instance %d not supported\n", __func__, priv->instance);
> +		return -ENODEV;
> +	};
> +
> +	return 0;
> +}
> +
> +static const struct bist_ops k3_bist_ops = {
> +	.run_lbist = k3_run_lbist,
> +	.run_lbist_post = k3_run_lbist_post,
> +	.run_pbist = k3_run_pbist,
> +	.run_pbist_post = k3_run_pbist_post,
> +	.run_pbist_neg = k3_run_pbist_neg,
> +	.run_pbist_rom = k3_run_pbist_rom,
> +};
> +
> +static const struct udevice_id k3_bist_ids[] = {
> +	{ .compatible = "ti,j784s4-bist" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(k3_bist) = {
> +	.name = "k3_bist",
> +	.of_match = k3_bist_ids,
> +	.id = UCLASS_MISC,
> +	.ops = &k3_bist_ops,
> +	.probe = k3_bist_probe,
> +	.priv_auto = sizeof(struct k3_bist_privdata),
> +};
> diff --git a/drivers/misc/k3_bist_static_data.h b/drivers/misc/k3_bist_static_data.h
> new file mode 100644
> index 00000000000..617e9439f36
> --- /dev/null
> +++ b/drivers/misc/k3_bist_static_data.h
> @@ -0,0 +1,576 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Static Data for Texas Instruments' BIST (Built-In Self-Test) driver
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#ifndef __K3_BIST_STATIC_DATA_H
> +#define __K3_BIST_STATIC_DATA_H
> +
> +#define PBIST_MAX_NUM_RUNS	2
> +#define NUM_MAX_PBIST_TEST_ROM_RUNS 13
> +#define PBIST14_DFT_PBIST_CPU_0_INTR_NUM 311
> +
> +/* VIM Registers */
> +#define VIM_STS_BASE						  0x40f80404
> +#define VIM_RAW_BASE						  0x40f80400
> +
> +#define VIM_STS(i)			(VIM_STS_BASE + (i) / 32 * 0x20)
> +#define VIM_RAW(i)	      (VIM_RAW_BASE + (i) / 32 * 0x20)
> +#define VIM_RAW_MASK(i)	 (BIT((i) % 32))

Please check for Alignment


> +
> +/* PBIST Registers and Flags*/
> +#define PBIST_RF0L						    0x00000000
> +#define PBIST_RF1L						    0x00000004
> +#define PBIST_RF2L						    0x00000008
> +#define PBIST_RF3L						    0x0000000C
> +#define PBIST_RF4L						    0x0000010
> +#define PBIST_RF5L						    0x0000014
> +#define PBIST_RF6L						    0x0000018
> +#define PBIST_RF7L						    0x000001C
> +#define PBIST_RF8L						    0x0000020
> +#define PBIST_RF9L						    0x0000024
> +#define PBIST_RF10L						   0x0000028
> +#define PBIST_RF11L						   0x000002C
> +#define PBIST_RF12L						   0x0000030
> +#define PBIST_RF13L						   0x0000034
> +#define PBIST_RF14L						   0x0000038
> +#define PBIST_RF15L						   0x000003C
> +#define PBIST_RF0U						    0x0000040
> +#define PBIST_RF1U						    0x0000044
> +#define PBIST_RF2U						    0x0000048
> +#define PBIST_RF3U						    0x000004C
> +#define PBIST_RF4U						    0x0000050
> +#define PBIST_RF5U						    0x0000054
> +#define PBIST_RF6U						    0x0000058
> +#define PBIST_RF7U						    0x000005C
> +#define PBIST_RF8U						    0x0000060
> +#define PBIST_RF9U						    0x0000064
> +#define PBIST_RF10U						   0x0000068
> +#define PBIST_RF11U						   0x000006C
> +#define PBIST_RF12U						   0x0000070
> +#define PBIST_RF13U						   0x0000074
> +#define PBIST_RF14U						   0x0000078
> +#define PBIST_RF15U						   0x000007C
> +#define PBIST_A0							    0x0000100
> +#define PBIST_A1							    0x0000104
> +#define PBIST_A2							    0x0000108
> +#define PBIST_A3							    0x000010C
> +#define PBIST_L0							    0x0000110
> +#define PBIST_L1							    0x0000114
> +#define PBIST_L2							    0x0000118
> +#define PBIST_L3							    0x000011C
> +#define PBIST_D							     0x0000120
> +#define PBIST_E							     0x0000124
> +#define PBIST_CA0							   0x0000130
> +#define PBIST_CA1							   0x0000134
> +#define PBIST_CA2							   0x0000138
> +#define PBIST_CA3							   0x000013C
> +#define PBIST_CL0							   0x0000140
> +#define PBIST_CL1							   0x0000144
> +#define PBIST_CL2							   0x0000148
> +#define PBIST_CL3							   0x000014C
> +#define PBIST_I0							    0x0000150
> +#define PBIST_I1							    0x0000154
> +#define PBIST_I2							    0x0000158
> +#define PBIST_I3							    0x000015C
> +#define PBIST_RAMT							  0x0000160
> +#define PBIST_DLR							   0x0000164
> +#define PBIST_CMS							   0x0000168
> +#define PBIST_STR							   0x000016C
> +#define PBIST_SCR							   0x0000170
> +#define PBIST_SCR_LO								0x0000170
> +#define PBIST_SCR_HI								0x0000174
> +#define PBIST_CSR							   0x0000178
> +#define PBIST_FDLY							  0x000017C
> +#define PBIST_PACT							  0x0000180
> +#define PBIST_PID							   0x0000184
> +#define PBIST_OVER							  0x0000188
> +#define PBIST_FSRF						    0x0000190
> +#define PBIST_FSRC							  0x0000198
> +#define PBIST_FSRA							  0x00001A0
> +#define PBIST_FSRDL0							0x00001A8
> +#define PBIST_FSRDL1							0x00001B0
> +#define PBIST_MARGIN_MODE						   0x00001B4
> +#define PBIST_WRENZ							 0x00001B8
> +#define PBIST_PAGE_PGS						      0x00001BC
> +#define PBIST_ROM							   0x00001C0
> +#define PBIST_ALGO							  0x00001C4
> +#define PBIST_RINFO							 0x00001C8
> +
> +#define PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK				0x00000003
> +#define PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT				0x00000002
> +#define PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK				0x0000000C
> +#define PBIST_PACT_PACT_MASK						0x00000001
> +#define PBIST_DLR_DLR0_ROM_MASK						0x00000004
> +#define PBIST_DLR_DLR0_CAM_MASK						0x00000010
> +#define PBIST_NOT_DONE							0
> +#define PBIST_DONE							1

Alignment for above all defines

Not sure, if this is my email client, which shows alignment is off


> +/* PBIST test mode */
> +#define PBIST_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
> +			 | (1 << PBIST_MARGIN_MODE_PBIST_DFT_READ_SHIFT))
> +
> +/* PBIST Failure Insertion test mode */
> +#define PBIST_FAILURE_INSERTION_TEST_MODE (PBIST_MARGIN_MODE_PBIST_DFT_WRITE_MASK \
> +					   | PBIST_MARGIN_MODE_PBIST_DFT_READ_MASK)
> +
> +/**
> + * struct core_under_test - structure for a core under a BIST test
> + * @dev_id: Device ID of the core
> + * @proc_id: Processor ID of the core
> + */
> +struct core_under_test {
> +	u32 dev_id;
> +	u32 proc_id;
> +};
> +
> +/*
> + * struct pbist_config - Structure for different configuration used for PBIST
> + * @override: Override value for memory configuration
> + * @algorithms_bit_map: Bitmap to select algorithms to use for test
> + * @memory_groups_bit_map: Bitmap to select memory groups to run test on
> + * @scramble_value_lo: Lower scramble value to be used for test
> + * @scramble_value_hi: Higher scramble value to be used for test
> + */
> +struct pbist_config {
> +	u32 override;
> +	u32 algorithms_bit_map;
> +	u64 memory_groups_bit_map;
> +	u32 scramble_value_lo;
> +	u32 scramble_value_hi;
> +};
> +
> +/*
> + * struct pbist_config_neg - Structure for different configuration used for PBIST
> + * for the failure insertion test to generate negative result
> + * @CA0: Failure insertion value for CA0
> + * @CA1: Failure insertion value for CA1
> + * @CA2: Failure insertion value for CA2
> + * @CA3: Failure insertion value for CA3
> + * @CL0: Failure insertion value for CL0
> + * @CL1: Failure insertion value for CL1
> + * @CL2: Failure insertion value for CL2
> + * @CL3: Failure insertion value for CL3
> + * @CMS: Failure insertion value for CMS
> + * @CSR: Failure insertion value for CSR
> + * @I0: Failure insertion value for I0
> + * @I1: Failure insertion value for I1
> + * @I2: Failure insertion value for I2
> + * @I3: Failure insertion value for I3
> + * @RAMT: Failure insertion value for RAMT
> + */
> +struct pbist_config_neg {
> +	u32 CA0;
> +	u32 CA1;
> +	u32 CA2;
> +	u32 CA3;
> +	u32 CL0;
> +	u32 CL1;
> +	u32 CL2;
> +	u32 CL3;
> +	u32 CMS;
> +	u32 CSR;
> +	u32 I0;
> +	u32 I1;
> +	u32 I2;
> +	u32 I3;
> +	u32 RAMT;
> +};
> +
> +/*
> + * struct pbist_config_neg - Structure for different configuration used for PBIST
> + * test of ROM
> + * @D: ROM test value for D
> + * @E: ROM test value for E
> + * @CA2: ROM test value for CA2
> + * @CL0: ROM test value for CL0
> + * @CA3: ROM test value for CA3
> + * @I0: ROM test value for I0
> + * @CL1: ROM test value for CL1
> + * @I3: ROM test value for I3
> + * @I2: ROM test value for I2
> + * @CL2: ROM test value for CL2
> + * @CA1: ROM test value for CA1
> + * @CA0: ROM test value for CA0
> + * @CL3: ROM test value for CL3
> + * @I1: ROM test value for I1
> + * @RAMT: ROM test value for RAMT
> + * @CSR: ROM test value for CSR
> + * @CMS: ROM test value for CMS
> + */
> +struct pbist_config_rom {
> +	u32 D;
> +	u32 E;
> +	u32 CA2;
> +	u32 CL0;
> +	u32 CA3;
> +	u32 I0;
> +	u32 CL1;
> +	u32 I3;
> +	u32 I2;
> +	u32 CL2;
> +	u32 CA1;
> +	u32 CA0;
> +	u32 CL3;
> +	u32 I1;
> +	u32 RAMT;
> +	u32 CSR;
> +	u32 CMS;
> +};
> +
> +/*
> + * struct pbist_inst_info - Structure for different configuration used for PBIST
> + * @num_pbist_runs: Number of runs of PBIST test
> + * @intr_num: Interrupt number triggered by this PBIST instance to MCU R5 VIM
> + * @pbist_config_run: Configuration for PBIST test
> + * @pbist_neg_config_run: Configuration for PBIST negative test
> + * @num_pbist_rom_test_runs: Number of runs of PBIST test on ROM
> + * @pbist_rom_test_config_run: Configuration for PBIST test on ROM
> + */
> +struct pbist_inst_info {
> +	u32 num_pbist_runs;
> +	u32 intr_num;
> +	u32 dev_id;
> +	struct core_under_test cut[2];
> +	struct pbist_config pbist_config_run[PBIST_MAX_NUM_RUNS];
> +	struct pbist_config_neg pbist_neg_config_run;
> +	u32 num_pbist_rom_test_runs;
> +	struct pbist_config_rom pbist_rom_test_config_run[NUM_MAX_PBIST_TEST_ROM_RUNS];
> +};
> +

> +#if IS_ENABLED(CONFIG_SOC_K3_J784S4)

Can I suggest to move J784S4 specific items into some j784s4-bist file. 
and include there conditionally

#if IS_ENABLED(CONFIG_SOC_K3_J784S4)

#include "tda54.h"

#else

#error "BIST is not supported on this SOC"

#endif

> +
> +/* WKUP CTRL MMR Registers */
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT				0x0000C2C0
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT	0x00000008
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_DONE_SHIFT 0x00000001
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT	0x00000009
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_LBIST_TIMEOUT_SHIFT 0x00000005
> +#define WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK	0x00008000
> +
> +/* Properties of PBIST instances in: PBIST14 */
> +#define PBIST14_INSTANCE					      14
> +#define PBIST14_NUM_TEST_VECTORS				      0x1
> +#define PBIST14_ALGO_BITMAP_0					      0x00000003
> +#define PBIST14_MEM_BITMAP_0					      0x000CCCCC
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA0			      0x00000000
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA1			      0x000001FF
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA2			      0x000001FF
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CA3			      0x00000000
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL0			      0x0000007F
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL1			      0x00000003
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL2			      0x00000008
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CL3			      0x000001FF
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CMS			      0x00000000
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_CSR			      0x20000000
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I0			      0x00000001
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I1			      0x00000004
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I2			      0x00000008
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_I3			      0x00000000
> +#define PBIST14_FAIL_INSERTION_TEST_VECTOR_RAMT			      0x011D2528
> +
> +static struct pbist_inst_info pbist14_inst_info = {
> +	/* Main Pulsar 2 Instance 1 or MAIN_R52_x */
> +	.num_pbist_runs = 1,
> +	.intr_num = PBIST14_DFT_PBIST_CPU_0_INTR_NUM,
> +	.dev_id = TISCI_DEV_PBIST14,
> +	.cut = {
> +		{
> +			.dev_id = TISCI_DEV_R5FSS2_CORE0,
> +			.proc_id = PROC_ID_MCU_R5FSS2_CORE0,
> +		},
> +		{
> +			.dev_id = TISCI_DEV_R5FSS2_CORE1,
> +			.proc_id = PROC_ID_MCU_R5FSS2_CORE1,
> +		}
> +	},
> +	.pbist_config_run = {
> +		{
> +			.override = 0,
> +			.algorithms_bit_map = PBIST14_ALGO_BITMAP_0,
> +			.memory_groups_bit_map = PBIST14_MEM_BITMAP_0,
> +			.scramble_value_lo = 0x76543210,
> +			.scramble_value_hi = 0xFEDCBA98,
> +		},
> +		{
> +			.override = 0,
> +			.algorithms_bit_map = 0,
> +			.memory_groups_bit_map = 0,
> +			.scramble_value_lo = 0,
> +			.scramble_value_hi = 0,
> +		},
> +	},
> +	.pbist_neg_config_run = {
> +		.CA0   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA0,
> +		.CA1   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA1,
> +		.CA2   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA2,
> +		.CA3   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CA3,
> +		.CL0   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL0,
> +		.CL1   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL1,
> +		.CL2   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL2,
> +		.CL3   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CL3,
> +		.CMS   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CMS,
> +		.CSR   = PBIST14_FAIL_INSERTION_TEST_VECTOR_CSR,
> +		.I0    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I0,
> +		.I1    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I1,
> +		.I2    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I2,
> +		.I3    = PBIST14_FAIL_INSERTION_TEST_VECTOR_I3,
> +		.RAMT  = PBIST14_FAIL_INSERTION_TEST_VECTOR_RAMT
> +	},
> +	.num_pbist_rom_test_runs = 1,
> +	.pbist_rom_test_config_run = {
> +		{
> +			.D = 0xF412605Eu,
> +			.E = 0xF412605Eu,
> +			.CA2 = 0x7FFFu,
> +			.CL0 = 0x3FFu,
> +			.CA3 = 0x0u,
> +			.I0 = 0x1u,
> +			.CL1 = 0x1Fu,
> +			.I3 = 0x0u,
> +			.I2 = 0xEu,
> +			.CL2 = 0xEu,
> +			.CA1 = 0x7FFFu,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x7FFFu,
> +			.I1 = 0x20u,
> +			.RAMT = 0x08002020u,
> +			.CSR = 0x00000001u,
> +			.CMS = 0x01u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +		{
> +			.D = 0x0u,
> +			.E = 0x0u,
> +			.CA2 = 0x0u,
> +			.CL0 = 0x0u,
> +			.CA3 = 0x0u,
> +			.I0 = 0x0u,
> +			.CL1 = 0x0u,
> +			.I3 = 0x0u,
> +			.I2 = 0x0u,
> +			.CL2 = 0x0u,
> +			.CA1 = 0x0u,
> +			.CA0 = 0x0u,
> +			.CL3 = 0x0u,
> +			.I1 = 0x0u,
> +			.RAMT = 0x0u,
> +			.CSR = 0x0u,
> +			.CMS = 0x0u
> +		},
> +	},
> +};
> +
> +#endif /* CONFIG_SOC_K3_J784S4 */
> +#endif /* __TI_SCI_STATIC_DATA_H */
> diff --git a/drivers/misc/k3_lbist_static_data.h b/drivers/misc/k3_lbist_static_data.h
> new file mode 100644
> index 00000000000..11d7088927d
> --- /dev/null
> +++ b/drivers/misc/k3_lbist_static_data.h
> @@ -0,0 +1,460 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Static Data for Texas Instruments' LBIST (Logic Built-In Self-Test)
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#ifndef __K3_LBIST_STATIC_DATA_H
> +#define __K3_LBIST_STATIC_DATA_H
> +
> +#define SDL_LBIST_CTRL_DIVIDE_RATIO_MASK            0x0000001F
> +#define SDL_LBIST_CTRL_DIVIDE_RATIO_SHIFT           0x00000000
> +#define SDL_LBIST_CTRL_DIVIDE_RATIO_MAX             0x0000001F
> +
> +#define SDL_LBIST_CTRL_LOAD_DIV_MASK                0x00000080
> +#define SDL_LBIST_CTRL_LOAD_DIV_SHIFT               0x00000007
> +#define SDL_LBIST_CTRL_LOAD_DIV_MAX                 0x00000001
> +
> +#define SDL_LBIST_CTRL_DC_DEF_MASK                  0x00000300
> +#define SDL_LBIST_CTRL_DC_DEF_SHIFT                 0x00000008
> +#define SDL_LBIST_CTRL_DC_DEF_MAX                   0x00000003
> +
> +#define SDL_LBIST_CTRL_RUNBIST_MODE_MASK            0x0000F000
> +#define SDL_LBIST_CTRL_RUNBIST_MODE_SHIFT           0x0000000C
> +#define SDL_LBIST_CTRL_RUNBIST_MODE_MAX             0x0000000F
> +
> +#define SDL_LBIST_CTRL_BIST_RUN_MASK                0x0F000000
> +#define SDL_LBIST_CTRL_BIST_RUN_SHIFT               0x00000018
> +#define SDL_LBIST_CTRL_BIST_RUN_MAX                 0x0000000F
> +
> +#define SDL_LBIST_CTRL_BIST_RESET_MASK              0x80000000
> +#define SDL_LBIST_CTRL_BIST_RESET_SHIFT             0x0000001F
> +#define SDL_LBIST_CTRL_BIST_RESET_MAX               0x00000001
> +
> +/* LBIST_PATCOUNT */
> +
> +#define SDL_LBIST_PATCOUNT_SCAN_PC_DEF_MASK         0x0000000F
> +#define SDL_LBIST_PATCOUNT_SCAN_PC_DEF_SHIFT        0x00000000
> +#define SDL_LBIST_PATCOUNT_SCAN_PC_DEF_MAX          0x0000000F
> +
> +#define SDL_LBIST_PATCOUNT_RESET_PC_DEF_MASK        0x000000F0
> +#define SDL_LBIST_PATCOUNT_RESET_PC_DEF_SHIFT       0x00000004
> +#define SDL_LBIST_PATCOUNT_RESET_PC_DEF_MAX         0x0000000F
> +
> +#define SDL_LBIST_PATCOUNT_SET_PC_DEF_MASK          0x00000F00
> +#define SDL_LBIST_PATCOUNT_SET_PC_DEF_SHIFT         0x00000008
> +#define SDL_LBIST_PATCOUNT_SET_PC_DEF_MAX           0x0000000F
> +
> +#define SDL_LBIST_PATCOUNT_STATIC_PC_DEF_MASK       0x3FFF0000
> +#define SDL_LBIST_PATCOUNT_STATIC_PC_DEF_SHIFT      0x00000010
> +#define SDL_LBIST_PATCOUNT_STATIC_PC_DEF_MAX        0x00003FFF
> +
> +/* LBIST_SEED0 */
> +
> +#define SDL_LBIST_SEED0_PRPG_DEF_MASK               0xFFFFFFFF
> +#define SDL_LBIST_SEED0_PRPG_DEF_SHIFT              0x00000000
> +#define SDL_LBIST_SEED0_PRPG_DEF_MAX                0xFFFFFFFF
> +
> +/* LBIST_SEED1 */
> +
> +#define SDL_LBIST_SEED1_PRPG_DEF_MASK               0x001FFFFF
> +#define SDL_LBIST_SEED1_PRPG_DEF_SHIFT              0x00000000
> +#define SDL_LBIST_SEED1_PRPG_DEF_MAX                0x001FFFFF
> +
> +/* LBIST_SPARE0 */
> +
> +#define SDL_LBIST_SPARE0_LBIST_SELFTEST_EN_MASK     0x00000001
> +#define SDL_LBIST_SPARE0_LBIST_SELFTEST_EN_SHIFT    0x00000000
> +#define SDL_LBIST_SPARE0_LBIST_SELFTEST_EN_MAX      0x00000001
> +
> +#define SDL_LBIST_SPARE0_PBIST_SELFTEST_EN_MASK     0x00000002
> +#define SDL_LBIST_SPARE0_PBIST_SELFTEST_EN_SHIFT    0x00000001
> +#define SDL_LBIST_SPARE0_PBIST_SELFTEST_EN_MAX      0x00000001
> +
> +#define SDL_LBIST_SPARE0_SPARE0_MASK                0xFFFFFFFC
> +#define SDL_LBIST_SPARE0_SPARE0_SHIFT               0x00000002
> +#define SDL_LBIST_SPARE0_SPARE0_MAX                 0x3FFFFFFF
> +
> +/* LBIST_SPARE1 */
> +
> +#define SDL_LBIST_SPARE1_SPARE1_MASK                0xFFFFFFFF
> +#define SDL_LBIST_SPARE1_SPARE1_SHIFT               0x00000000
> +#define SDL_LBIST_SPARE1_SPARE1_MAX                 0xFFFFFFFF
> +
> +/* LBIST_STAT */
> +
> +#define SDL_LBIST_STAT_MISR_MUX_CTL_MASK            0x000000FF
> +#define SDL_LBIST_STAT_MISR_MUX_CTL_SHIFT           0x00000000
> +#define SDL_LBIST_STAT_MISR_MUX_CTL_MAX             0x000000FF
> +
> +#define SDL_LBIST_STAT_OUT_MUX_CTL_MASK             0x00000300
> +#define SDL_LBIST_STAT_OUT_MUX_CTL_SHIFT            0x00000008
> +#define SDL_LBIST_STAT_OUT_MUX_CTL_MAX              0x00000003
> +
> +#define SDL_LBIST_STAT_BIST_RUNNING_MASK            0x00008000
> +#define SDL_LBIST_STAT_BIST_RUNNING_SHIFT           0x0000000F
> +#define SDL_LBIST_STAT_BIST_RUNNING_MAX             0x00000001
> +
> +#define SDL_LBIST_STAT_BIST_DONE_MASK               0x80000000
> +#define SDL_LBIST_STAT_BIST_DONE_SHIFT              0x0000001F
> +#define SDL_LBIST_STAT_BIST_DONE_MAX                0x00000001
> +
> +/* LBIST_MISR */
> +
> +#define SDL_LBIST_MISR_MISR_RESULT_MASK             0xFFFFFFFF
> +#define SDL_LBIST_MISR_MISR_RESULT_SHIFT            0x00000000
> +#define SDL_LBIST_MISR_MISR_RESULT_MAX              0xFFFFFFFF
> +
> +/* VIM Registers */
> +#define VIM_STS_BASE				    0x40f80404
> +#define VIM_RAW_BASE				    0x40f80400
Many defines are duplicated in

k3_bist_static_data.h and k3_lbist_static_data.h Please see, if you can 
combine

> +
> +#define VIM_STS(i)			(VIM_STS_BASE + (i) / 32 * 0x20)
> +#define VIM_RAW(i)	      (VIM_RAW_BASE + (i) / 32 * 0x20)
> +#define VIM_RAW_MASK(i)	 (BIT((i) % 32))
> [..]
