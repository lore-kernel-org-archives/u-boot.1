Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D0CD5BA1
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 09:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C2D88C24;
	Thu,  5 Sep 2024 11:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kA2hHeah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BBC88C51; Thu,  5 Sep 2024 11:41:46 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C530188C24
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 11:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4859fed5078553;
 Thu, 5 Sep 2024 04:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725529300;
 bh=+/TeinBUBIY36jcUcEtJ/dwUMS3ddjN1XvBpRCATt0g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kA2hHeahBjaepDDdYdoDV8Ie9fvgdVC7Qb9Mh+wA5DyIEXDD2EjVCGQzxaqSMkU5d
 RKwB6rd5IP+9B2CB2ZCm7HrxZTIUy8iRCMNp7ASi/veHaXF/6lgHSvubSZNbXS6k78
 1nlkgzEpWHza5jo6/TPOXnO+Eysfp4SKPux4wHv4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4859feOo119361
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Sep 2024 04:41:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 04:41:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 04:41:40 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4859fZim088005;
 Thu, 5 Sep 2024 04:41:36 -0500
Message-ID: <5198dbc7-19bc-419e-83b7-e7216269abd1@ti.com>
Date: Thu, 5 Sep 2024 15:11:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] drivers: misc: k3_bist: Add K3 BIST driver
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-5-n-francis@ti.com>
 <586db467-5524-42cd-9742-3a673bb02039@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <586db467-5524-42cd-9742-3a673bb02039@ti.com>
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

On 04/09/24 10:35, Kumar, Udit wrote:
> 
> On 9/3/2024 5:14 PM, Neha Malcom Francis wrote:
>> Add a driver for the BIST module which currently includes support for
>> BIST IPs that trigger PBIST (Memory BIST).
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/misc/Kconfig               |   8 +
>>   drivers/misc/Makefile              |   1 +
>>   drivers/misc/k3_bist.c             | 507 ++++++++++++++++++++++++++
>>   drivers/misc/k3_bist_static_data.h | 551 +++++++++++++++++++++++++++++
>>   4 files changed, 1067 insertions(+)
>>   create mode 100644 drivers/misc/k3_bist.c
>>   create mode 100644 drivers/misc/k3_bist_static_data.h
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 6009d55f400..8e28a93d74c 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -664,6 +664,14 @@ config ESM_K3
>>       help
>>         Support ESM (Error Signaling Module) on TI K3 SoCs.
>> +config K3_BIST
>> +    bool "Enable K3 BIST driver"
>> +    depends on ARCH_K3
>> +    help
>> +      Support BIST (Built-In Self Test) module on TI K3 SoCs. This driver
>> +      supports running both PBIST (Memory BIST) and LBIST (Logic BIST) on
>> +      a region or IP in the SoC.
>> +
>>   config MICROCHIP_FLEXCOM
>>       bool "Enable Microchip Flexcom driver"
>>       depends on MISC
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index e53d52c47b3..15c5c4810dd 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -89,6 +89,7 @@ obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
>>   obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
>>   obj-$(CONFIG_K3_AVS0) += k3_avs.o
>>   obj-$(CONFIG_ESM_K3) += k3_esm.o
>> +obj-$(CONFIG_K3_BIST) += k3_bist.o
>>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
>> diff --git a/drivers/misc/k3_bist.c b/drivers/misc/k3_bist.c
>> new file mode 100644
>> index 00000000000..a4728376b73
>> --- /dev/null
>> +++ b/drivers/misc/k3_bist.c
>> @@ -0,0 +1,507 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Texas Instruments' BIST (Built-In Self-Test) driver
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + *      Neha Malcom Francis <n-francis@ti.com>
>> + *
>> + */
>> +
>> +#include <dm.h>
>> +#include <errno.h>
>> +#include <clk.h>
>> +#include <asm/io.h>
>> +#include <dm/device_compat.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <asm/arch/hardware.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +#include <remoteproc.h>
>> +#include <power-domain.h>
>> +
> 
> 
> In general, few macro's name are too long
> 
> many places hard-coded values are used, please consider to move to macro
> 
> driver looks to be j784s4 specific including header files  ,
> 
> please see, if we can make this generic driver.

I've put SoC specific (J784S4 right now) data protected with SoC specific 
configs in k3_bist_static_data.h; the hardcoded values are a sequence for 
triggering a specific test, whatever is generic and known I have put as a macro, 
however I'll try to better understand the sequence if I can put them as macros.

> 
> 
>> +#include "k3_bist_static_data.h"
>> +
>> +/* PBIST Timeout Value */
>> +#define PBIST_MAX_TIMEOUT_VALUE        100000000
>> +
>> +/**
>> + * struct k3_bist_privdata - K3 BIST structure
>> + * @dev: device pointer
>> + * @base: base of register set
>> + * @instance: PBIST instance number
>> + * @intr_num: corresponding interrupt ID of the PBIST instance
>> + */
>> +struct k3_bist_privdata {
>> +    struct udevice *dev;
>> +    void *base;
>> +    u32 instance;
>> +    u32 intr_num;
>> +};
>> +
>> +static struct k3_bist_privdata *k3_bist_priv;
>> +
>> +/**
>> + * pbist_run_post_pbist_check() - Check POST results
>> + *
>> + * Function to check whether HW Power-On Self Test, i.e. POST has run
>> + * successfully on the MCU domain.
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +int pbist_run_post_pbist_check(void)
> 
> Please consider to rename function name as per description above something like
> 
> check_pbist_results_of_mcu_domain,, if you agree
> 
> Also give more context, I believe, ROM runs BIST on MCU domain, Please consider 
> to mention, if you want

Yes will do!

> 
>> +{
>> +    bool is_done, timed_out;
>> +    u32 mask;
>> +    u32 post_reg_val, shift;
>> +
>> +    /* Read HW POST status register */
>> +    post_reg_val = readl(WKUP_CTRL_MMR0_BASE + 
>> WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
>> +
>> +    /* Check if HW POST PBIST was performed */
>> +    shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT;
>> +    is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : 
>> (bool)false;
>> +
>> +    if (!is_done) {
>> +        /* HW POST: PBIST not completed, check if it timed out */
>> +        shift = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT;
> Too long macro name
>> +        timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? (bool)true : 
>> (bool)false;
>> +
>> +        if (!timed_out) {
>> +            debug("%s: PBIST was not performed at all on this device for this 
>> core\n",
>> +                  __func__);
>> +            return -EINVAL;
> 
> This is error no ? , move to dev_err instead of debug
> 

The return in k3_bist_probe throws a dev_err saying HW POST failed to run 
successfully. So these were added as debugs in case the end user wants to know 
exact cause of failure, I can move it as a dev_err as well.

> 
>> +        } else {
>> +            debug("%s: PBIST was attempted but timed out for this section\n", 
>> __func__);
>> +            return -ETIMEDOUT;
> 
> This is error no ? , move to dev_err instead of debug .
> 
> What next, reboot SOC or just continue booting in case of error

This is also something I wanted this RFC to address, I prefer rebooting SoC if 
HW POST fails. HW POST is performed by ROM based on certain switch settings, 
which implies that an end-user wants this check done if selected. And if it 
fails on the MCU domain itself, I do not think we should continue.
> 
> 
>> +        }
>> +    } else {
>> +        /* HW POST: PBIST was completed on this device, check the result */
>> +        mask = WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_FAIL_MASK;
>> +
>> +        if ((post_reg_val & mask) != 0) {
>> +            debug("%s: PBIST was completed, but the test failed\n", __func__);
>> +            return -EINVAL;
>> +        } else {
>> +            debug("%s: HW POST PBIST completed, test passed\n", __func__);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * core_get_by_index() - Configure processor to correct state
> 
> 
> Two operation here. please rename if possible
> 

Will do, thanks!

> 
>> + *
>> + * Function to configure processor under test to correct state for SW-initiated
>> + * PBIST
>> + * @dev: BIST device
>> + * @index: corresponding index of the core in the cores-under-test list
>> + * @turnoff: true if core is needed to be turned off
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +int core_get_by_index(struct udevice *dev, int index, bool turnoff)
>> +{
>> +    struct ofnode_phandle_args args;
>> +    int ret;
>> +    struct udevice *dev_core;
>> +
>> +    ret = dev_read_phandle_with_args(dev, "cores-under-test", NULL, 0, index, 
>> &args);
>> +    if (ret) {
>> +        debug("%s: dev_read_phandle_with_args failed: %d\n", __func__,
>> +              ret);
>> +        return ret;
>> +    }
>> +    ret =  uclass_get_device_by_ofnode(UCLASS_REMOTEPROC, args.node, &dev_core);
>> +    if (ret) {
>> +        debug("%s: uclass_get_device_by_of_offset failed: %d\n",
>> +              __func__, ret);
>> +        return ret;
>> +    }
>> +
>> +    if (turnoff) {
>> +        struct power_domain pwrdmn;
>> +        struct clk fclk;
>> +
> 
> isn't some tisci call are ok to turn off the CPUs.
> 

DM (Device Manager) firmware, responsible for power management is not up at this 
point in the boot flow (R5 SPL). Thus TISCI calls that turn on/turn off clocks 
and power domains are not available and we rely on the primitive clk-k3.c and 
ti-power-domain.c drivers to do this for us. As seen below, using the uclass 
functions which internally calls these primitive drivers would be the way to go.

I could have used the remoteproc framework to do this but currently the rproc 
driver uses TISCI firmware calls from DM and as mentioned above that's not possible.

We should probably target modifying our remoteproc driver to use these generic 
uclass APIs instead of direct TISCI calls.

> 
>> +        ret = power_domain_get_by_index(dev_core, &pwrdmn, 0);
>> +        if (ret) {
>> +            dev_err(dev, "failed to get power domain for the core %d\n", ret);
>> +            return ret;
>> +        }
>> +
>> +        ret = clk_get_by_index(dev_core, 0, &fclk);
>> +        if (ret) {
>> +            dev_err(dev, "failed to get clock for the core %d\n", ret);
>> +            return ret;
>> +        }
>> +
>> +        ret = power_domain_off(&pwrdmn);
>> +        if (ret) {
>> +            dev_err(dev, "failed to power OFF the core %d\n", ret);
>> +            return ret;
>> +        }
>> +
>> +        ret = power_domain_free(&pwrdmn);
>> +        if (ret) {
>> +            dev_err(dev, "failed to free the core %d\n", ret);
>> +            return ret;
>> +        }
>> +        ret = clk_disable(&fclk);
>> +        if (ret) {
>> +            dev_err(dev, "failed to disable clock of the core %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +/**
>> + * pbist_self_test() - Run PBIST_TEST on specified cores
>> + * @config: pbist_config structure for PBIST test
>> + *
>> + * Function to run PBIST_TEST
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +int pbist_self_test(struct pbist_config *config)
>> +{
>> +    struct udevice *dev = k3_bist_priv->dev;
>> +    void *base = k3_bist_priv->base;
>> +    u32 intr_num = k3_bist_priv->intr_num;
>> +    bool test_result = true;
>> +
>> +    /* Turns on PBIST clock in PBIST ACTivate register */
>> +    writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
>> +
>> +    /* Set Margin mode register for Test mode */
>> +    writel(PBIST_TEST_MODE, base + PBIST_MARGIN_MODE);
>> +
>> +    /* Zero out Loop counter 0 */
>> +    writel(0x0, base + PBIST_L0);
>> +
>> +    /* Set algorithm bitmap */
>> +    writel(config->algorithms_bit_map, base + PBIST_ALGO);
>> +
>> +    /* Set Memory group bitmap */
>> +    writel(config->memory_groups_bit_map, base + PBIST_RINFO);
>> +
>> +    /* Zero out override register */
>> +    writel(config->override, base + PBIST_OVER);
>> +
>> +    /* Set Scramble value - 64 bit*/
>> +    writel(config->scramble_value_lo, base + PBIST_SCR_LO);
>> +    writel(config->scramble_value_hi, base + PBIST_SCR_HI);
>> +
>> +    /* Set DLR register for ROM based testing and Config Access */
>> +    writel(PBIST_DLR_DLR0_ROM_MASK
>> +    | PBIST_DLR_DLR0_CAM_MASK, base + PBIST_DLR);
>> +
>> +    udelay(1000);
>> +
>> +    u32 timeout_count = 0;
> Please move timeout_count at start of function
>> +
>> +    while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
>> +           (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
>> +        ;
> 
> Do you want to add some delay instead of just reading in a loop
> 

That is possible... is there any benefit of delay over polling? Eithercase the 
possible time would be at max be PBIST_MAX_TIMEOUT_VALUE.

> 
>> +
>> +    if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
>> +        test_result = false;
>> +        debug("%s(dev=%p): test failed\n", __func__, dev);
> 
> Fail is error , no ?
> 
> 
>> +    } else {
>> +        debug("%s(dev=%p): test passed\n", __func__, dev);
>> +    }
>> +
>> +    writel(0xffffffff, VIM_STS(intr_num));
>> +
>> +    return 0;
> 
> 
> Caller always will see success
> 

Right, I wasn't sure about what action to take based on the result.

> 
>> +}
>> +
>> +/**
>> + * pbist_neg_self_test() - Run PBIST_negTEST on specified cores
>> + * @config: pbist_config_neg structure for PBIST negative test
>> + *
>> + * Function to run PBIST failure insertion test
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +int pbist_neg_self_test(struct pbist_config_neg *config)
>> +{
>> +    struct udevice *dev = k3_bist_priv->dev;
>> +    void *base = k3_bist_priv->base;
>> +    u32 intr_num = k3_bist_priv->intr_num;
>> +    bool test_result = true;
>> +
>> +    /* Turns on PBIST clock in PBIST ACTivate register */
>> +    writel(PBIST_PACT_PACT_MASK, base + PBIST_PACT);
>> +
>> +    /* Set Margin mode register for Test mode */
>> +    writel(PBIST_FAILURE_INSERTION_TEST_MODE, base + PBIST_MARGIN_MODE);
>> +
>> +    /* Zero out Loop counter 0 */
>> +    writel(0x0, base + PBIST_L0);
>> +
>> +    /* Set DLR register */
>> +    writel(0x10, base + PBIST_DLR);
>> +
>> +    /* Set Registers*/
>> +    writel(0x00000001, base + PBIST_RF0L);
>> +    writel(0x00003123, base + PBIST_RF0U);
>> +    writel(0x0513FC02, base + PBIST_RF1L);
>> +    writel(0x00000002, base + PBIST_RF1U);
>> +    writel(0x00000003, base + PBIST_RF2L);
>> +    writel(0x00000000, base + PBIST_RF2U);
>> +    writel(0x00000004, base + PBIST_RF3L);
>> +    writel(0x00000028, base + PBIST_RF3U);
>> +    writel(0x64000044, base + PBIST_RF4L);
>> +    writel(0x00000000, base + PBIST_RF4U);
>> +    writel(0x0006A006, base + PBIST_RF5L);
>> +    writel(0x00000000, base + PBIST_RF5U);
>> +    writel(0x00000007, base + PBIST_RF6L);
>> +    writel(0x0000A0A0, base + PBIST_RF6U);
>> +    writel(0x00000008, base + PBIST_RF7L);
>> +    writel(0x00000064, base + PBIST_RF7U);
>> +    writel(0x00000009, base + PBIST_RF8L);
>> +    writel(0x0000A5A5, base + PBIST_RF8U);
>> +    writel(0x0000000A, base + PBIST_RF9L);
>> +    writel(0x00000079, base + PBIST_RF9U);
>> +    writel(0x00000000, base + PBIST_RF10L);
>> +    writel(0x00000001, base + PBIST_RF10U);
>> +    writel(0xAAAAAAAA, base + PBIST_D);
>> +    writel(0xAAAAAAAA, base + PBIST_E);
> 
> too much direct values
> 

Will try seeing if this sequence has a meaning I can move to MACROS for.

>> +
>> +    writel(config->CA2, base + PBIST_CA2);
>> +    writel(config->CL0, base + PBIST_CL0);
>> +    writel(config->CA3, base + PBIST_CA3);
>> +    writel(config->I0, base + PBIST_I0);
>> +    writel(config->CL1, base + PBIST_CL1);
>> +    writel(config->I3, base + PBIST_I3);
>> +    writel(config->I2, base + PBIST_I2);
>> +    writel(config->CL2, base + PBIST_CL2);
>> +    writel(config->CA1, base + PBIST_CA1);
>> +    writel(config->CA0, base + PBIST_CA0);
>> +    writel(config->CL3, base + PBIST_CL3);
>> +    writel(config->I1, base + PBIST_I1);
>> +    writel(config->RAMT, base + PBIST_RAMT);
>> +    writel(config->CSR, base + PBIST_CSR);
>> +    writel(config->CMS, base + PBIST_CMS);
>> +
>> +    writel(0x00000009, base + PBIST_STR);
>> +
>> +    /* Start PBIST */
>> +    writel(0x00000001, base + PBIST_STR);
>> +
>> +    udelay(1000);
>> +
>> +    u32 timeout_count = 0;
>> +
>> +    while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
>> +           (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
>> +        ;
>> +
>> +    if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
>> +        test_result = false;
>> +        debug("%s(dev=%p): test failed\n", __func__, dev);
>> +    } else {
>> +        debug("%s(dev=%p): test passed\n", __func__, dev);
>> +    }
>> +
>> +    writel(0xffffffff, VIM_STS(intr_num));
>> +
>> +    return 0;
> 
> Same as in above function for error
> 
>> +}
>> +
>> +/**
>> + * pbist_rom_self_test() - Run PBIST_ROM_TEST on specified cores
>> + * @config: pbist_config_rom structure for PBIST negative test
>> + *
>> + * Function to run PBIST test of ROM
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +int pbist_rom_self_test(struct pbist_config_rom *config)
>> +{
>> +    struct udevice *dev = k3_bist_priv->dev;
>> +    void *base = k3_bist_priv->base;
>> +    u32 intr_num = k3_bist_priv->intr_num;
>> +    bool test_result = true;
>> +
>> +    /* Turns on PBIST clock in PBIST ACTivate register */
>> +    writel(0x1, base + PBIST_PACT);
>> +
>> +    /* Set Margin mode register for Test mode */
>> +    writel(0xf, base + PBIST_MARGIN_MODE);
>> +
>> +    /* Zero out Loop counter 0 */
>> +    writel(0x0, base + PBIST_L0);
>> +
>> +    /* Set DLR register */
>> +    writel(0x310, base + PBIST_DLR);
>> +
>> +    /* Set Registers*/
>> +    writel(0x00000001, base + PBIST_RF0L);
>> +    writel(0x00003123, base + PBIST_RF0U);
>> +    writel(0x7A400183, base + PBIST_RF1L);
>> +    writel(0x00000060, base + PBIST_RF1U);
>> +    writel(0x00000184, base + PBIST_RF2L);
>> +    writel(0x00000000, base + PBIST_RF2U);
>> +    writel(0x7B600181, base + PBIST_RF3L);
>> +    writel(0x00000061, base + PBIST_RF3U);
>> +    writel(0x00000000, base + PBIST_RF4L);
>> +    writel(0x00000000, base + PBIST_RF4U);
>> +
>> +    writel(config->D, base + PBIST_D);
>> +    writel(config->E, base + PBIST_E);
>> +    writel(config->CA2, base + PBIST_CA2);
>> +    writel(config->CL0, base + PBIST_CL0);
>> +    writel(config->CA3, base + PBIST_CA3);
>> +    writel(config->I0, base + PBIST_I0);
>> +    writel(config->CL1, base + PBIST_CL1);
>> +    writel(config->I3, base + PBIST_I3);
>> +    writel(config->I2, base + PBIST_I2);
>> +    writel(config->CL2, base + PBIST_CL2);
>> +    writel(config->CA1, base + PBIST_CA1);
>> +    writel(config->CA0, base + PBIST_CA0);
>> +    writel(config->CL3, base + PBIST_CL3);
>> +    writel(config->I1, base + PBIST_I1);
>> +    writel(config->RAMT, base + PBIST_RAMT);
>> +    writel(config->CSR, base + PBIST_CSR);
>> +    writel(config->CMS, base + PBIST_CMS);
>> +
>> +    writel(0x00000009, base + PBIST_STR);
>> +
>> +    /* Start PBIST */
>> +    writel(0x00000001, base + PBIST_STR);
>> +
>> +    udelay(1000);
>> +
> Why delay is needed. please add comment for that
>> +    u32 timeout_count = 0;
> same as above
>> +
>> +    while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
>> +           (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
>> +        ;
>> +
>> +    if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
>> +        test_result = false;
>> +        debug("%s(dev=%p): test failed\n", __func__, dev);
>> +    } else {
>> +        debug("%s(dev=%p): test passed\n", __func__, dev);
>> +    }
>> +
>> +    writel(0xffffffff, VIM_STS(intr_num));
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * k3_bist_probe() - Basic probe
>> + * @dev: corresponding BIST device
>> + *
>> + * Parses BIST info from device tree, and configures the module accordingly.
>> + * Return: 0 if all goes good, else appropriate error message.
>> + */
>> +static int k3_bist_probe(struct udevice *dev)
>> +{
>> +    int ret = 0, num_runs, i, j;
>> +    struct k3_bist_privdata *priv = dev_get_priv(dev);
>> +    struct pbist_inst_info *info;
>> +
>> +    debug("%s(dev=%p)\n", __func__, dev);
>> +
>> +    priv = dev_get_priv(dev);
> 
> NULL error check for priv
> 

Got it, thanks!

> 
>> +    priv->dev = dev;
>> +
>> +    k3_bist_priv = priv;
>> +
>> +    priv->base = dev_remap_addr_index(dev, 0);
>> +    if (!priv->base)
>> +        return -ENODEV;
>> +
>> +    ret = dev_read_u32(dev, "ti,bist-instance", &priv->instance);
>> +    if (!priv->instance)
>> +        return -ENODEV;
>> +
>> +    switch (priv->instance) {
>> +    case PBIST14_INSTANCE:
>> +        info = &pbist14_inst_info;
>> +        priv->intr_num = info->intr_num;
>> +        break;
>> +    default:
>> +        dev_err(dev, "%s: PBIST instance %d not supported\n", __func__, 
>> priv->instance);
>> +        return -ENODEV;
>> +    };
>> +
>> +    /* Probe the cores under test */
>> +    for (i = 0; ; i++) {
>> +        ret = core_get_by_index(dev, i, false);
>> +        if (ret)
>> +            break;
>> +    }
>> +
>> +    if (!i) {
>> +        dev_err(dev, "%s: Acquiring the core failed. ret = %d\n", __func__, 
>> ret);
>> +        return ret;
>> +    }
> 
> Please add a check, what you expect in device tree at start of probe .
> 
> I assume, you can hit this only case of incorrect DT
> 

Right, will add a check at the start.

> 
>> +
>> +    /* Check whether HW POST successfully completely PBIST on the MCU domain */
>> +    ret = pbist_run_post_pbist_check();
>> +    if (ret) {
>> +        dev_err(dev, "HW POST failed to run successfully %d\n", ret);
>> +        return ret;
>> +    }
>> +
> 
> you might need to do this check first. before probing other cores
> 

Hm yes okay, can move that in front.

> 
>> +    /* Run PBIST test */
>> +    num_runs = info->num_pbist_runs;
> if you want num_runs configurable, prefer to use DT
>> +
>> +    for (j = 0; j < num_runs; j++) {
>> +        ret = pbist_self_test(&info->pbist_config_run[j]);
>> +        if (ret) {
>> +            dev_err(dev, "failed to run PBIST test %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
> Dummy question, will above run the BIST on all selected cores ?

A probe of a single BIST instance will run the BIST test on all it's 
modules/cores. So yes, each test is triggering the BIST run on all cores.

>> +
>> +    /* Run PBIST failure insertion test */
>> +    ret = pbist_neg_self_test(&info->pbist_neg_config_run);
>> +    if (ret) {
>> +        dev_err(dev, "failed to run PBIST negative test %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Run PBIST test on ROM */
>> +    num_runs = info->num_pbist_rom_test_runs;
>> +
>> +    for (j = 0; j < num_runs; j++) {
>> +        ret = pbist_rom_self_test(&info->pbist_rom_test_config_run[j]);
>> +        if (ret) {
>> +            dev_err(dev, "failed to run ROM PBIST test %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    /* Power off cores under test */
>> +    while (i--) {
>> +        ret = core_get_by_index(dev, i, true);
>> +        if (ret)
>> +            break;
>> +    }
> 
> can we get rid from this 'i' , May you can do all core ON and OFF in one function,
> 
> Largely its from device tree

Okay I will try changing this.

> 
>> +
>> +    if (i) {
>> +        dev_err(dev, "%s: Stopping the core failed. ret = %d\n", __func__, ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct udevice_id k3_bist_ids[] = {
>> +    { .compatible = "ti,j784s4-bist" },
>> +    {}
>> +};
>> +
>> +U_BOOT_DRIVER(k3_bist) = {
>> +    .name = "k3_bist",
>> +    .of_match = k3_bist_ids,
>> +    .id = UCLASS_MISC,
>> +    .probe = k3_bist_probe,
>> +    .priv_auto = sizeof(struct k3_bist_privdata),
>> +};
>> diff --git a/drivers/misc/k3_bist_static_data.h 
>> b/drivers/misc/k3_bist_static_data.h
>> new file mode 100644
>> index 00000000000..f30fb7935b6
>> --- /dev/null
>> +++ b/drivers/misc/k3_bist_static_data.h
>> @@ -0,0 +1,551 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Static Data for Texas Instruments' BIST (Built-In Self-Test) driver
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + *
>> + */
>> +
>> +#ifndef __K3_BIST_STATIC_DATA_H
>> +#define __K3_BIST_STATIC_DATA_H
>> +
>> +#define PBIST_MAX_NUM_RUNS    2
>> +#define NUM_MAX_PBIST_TEST_ROM_RUNS 13
>> +#define PBIST14_DFT_PBIST_CPU_0_INTR_NUM 311
>> +
>> +/* VIM Registers */
>> +#define VIM_STS_BASE                          0x40f80404
>> +#define VIM_RAW_BASE                          0x40f80400
>> +
>> +#define VIM_STS(i)            (VIM_STS_BASE + (i) / 32 * 0x20)
>> +#define VIM_RAW(i)          (VIM_RAW_BASE + (i) / 32 * 0x20)
>> +#define VIM_RAW_MASK(i)     (BIT((i) % 32))
> 
> Above this SOC specific data , Please have some SOC specific data in another 
> header file and include here.
> 
> So that adding next SOC will be easy
> 
>> [..]
>> +#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
> 
> Please put this data in SOC specific header file

Okay I will create an SoC specific header file.

> 
>> [..]

Thanks for reviewing!

-- 
Thanking You
Neha Malcom Francis
