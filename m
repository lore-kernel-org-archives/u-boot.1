Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010AC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D117680B9B;
	Wed, 29 Jan 2025 23:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xh+M0xGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB8F80BA8; Wed, 29 Jan 2025 23:27:50 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867C8809D2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TMRj2M2202827
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 16:27:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738189665;
 bh=OoWuMBAOyiNiQgejgVQuBeQGWgbdfB4u2SsBC7LvPKQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xh+M0xGBJ7wUEfMUzbsyXYw0lob6H7WJzUISzm4kId4GoLnplb83XfG2WPoS9LG0K
 clLhbXNLKkbMqR2QTKWDoKso5r30zw276Ec3cGYza3fTj8BYZNLOtQpN/D8t/GwIlW
 R5maATByQapsMT2eYO1TRO49WQsKf1sRB+Z33IsU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50TMRj3U116475
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Jan 2025 16:27:45 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 16:27:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 16:27:45 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TMRjET099539;
 Wed, 29 Jan 2025 16:27:45 -0600
Message-ID: <2a37f8f9-8254-4a43-a04f-935fa4e3a647@ti.com>
Date: Wed, 29 Jan 2025 16:27:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] remoteproc: k3-m4: Introduce K3 remote proc driver
 for M4 subsystem
To: Daniel Schultz <D.Schultz@phytec.de>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250123010759.810799-1-jm@ti.com>
 <20250123010759.810799-2-jm@ti.com>
 <1da9f75e-848f-4ec9-ba68-bec406716bf1@phytec.de>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <1da9f75e-848f-4ec9-ba68-bec406716bf1@phytec.de>
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

Hello Daniel,

On 1/29/25 7:24 AM, Daniel Schultz wrote:
> Hey,
> 
> thanks for sending this driver! Tested it on our AM64x board. See two
> comments below.
> 
> On 23.01.25 02:07, Judith Mendez wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> Some K3 devices like AM64, AM62 devices have a M4 processor in MCU
>> voltage domain.
>>
>> Add a remote proc driver to support this subsystem to be able to load
>> and boot the M4 core.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [Judith: Fixed comments explaining local resets]
>> Signed-off-by: Judith Mendez <jm@ti.com>
> Tested-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>    drivers/remoteproc/Kconfig          |  10 +
>>    drivers/remoteproc/Makefile         |   1 +
>>    drivers/remoteproc/ti_k3_m4_rproc.c | 411 ++++++++++++++++++++++++++++
>>    3 files changed, 422 insertions(+)
>>    create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 2790b168b19..e579c4e8371 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -80,6 +80,16 @@ config REMOTEPROC_TI_K3_R5F
>>    	  on various TI K3 family of SoCs through the remote processor
>>    	  framework.
>>    
>> +config REMOTEPROC_TI_K3_M4F
>> +	bool "TI K3 M4F remoteproc support"
>> +	select REMOTEPROC
>> +	depends on ARCH_K3
>> +	depends on TI_SCI_PROTOCOL
>> +	help
>> +	  Say y here to support TI's M4F remote processor subsystems
>> +	  on various TI K3 family of SoCs through the remote processor
>> +	  framework.
>> +
> 
> 
> this config is placed after REMOTEPROC_TI_K3_R5F and not ordered
> alphabetically ... not sure how important the order is in those Kconfig
> files.

I can fix it no problem. Not sure if it matters much but will fix
alphabetically.

> 
> 
>>    config REMOTEPROC_TI_POWER
>>    	bool "Support for TI Power processor"
>>    	select REMOTEPROC
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 3a092b7660e..f81e5009c5e 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_REMOTEPROC_SANDBOX) += sandbox_testproc.o
>>    obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
>>    obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
>>    obj-$(CONFIG_REMOTEPROC_TI_K3_DSP) += ti_k3_dsp_rproc.o
>> +obj-$(CONFIG_REMOTEPROC_TI_K3_M4F) += ti_k3_m4_rproc.o
>>    obj-$(CONFIG_REMOTEPROC_TI_K3_R5F) += ti_k3_r5f_rproc.o
>>    obj-$(CONFIG_REMOTEPROC_TI_POWER) += ti_power_proc.o
>>    obj-$(CONFIG_REMOTEPROC_TI_PRU) += pru_rproc.o
>> diff --git a/drivers/remoteproc/ti_k3_m4_rproc.c b/drivers/remoteproc/ti_k3_m4_rproc.c
>> new file mode 100644
>> index 00000000000..5a5ae2fa81d
>> --- /dev/null
>> +++ b/drivers/remoteproc/ti_k3_m4_rproc.c
>> @@ -0,0 +1,411 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Texas Instruments' K3 M4 Remoteproc driver
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Hari Nagalla <hnagalla@ti.com>
>> + */
>> +
>> +#include <dm.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <remoteproc.h>
>> +#include <errno.h>
>> +#include <clk.h>
>> +#include <reset.h>
>> +#include <asm/io.h>
>> +#include <power-domain.h>
>> +#include <dm/device_compat.h>
>> +#include <linux/err.h>
>> +#include <linux/sizes.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +#include "ti_sci_proc.h"
>> +
>> +/**
>> + * struct k3_m4_mem - internal memory structure
>> + * @cpu_addr: MPU virtual address of the memory region
>> + * @bus_addr: Bus address used to access the memory region
>> + * @dev_addr: Device address from remoteproc view
>> + * @size: Size of the memory region
>> + */
>> +struct k3_m4_mem {
>> +	void __iomem *cpu_addr;
>> +	phys_addr_t bus_addr;
>> +	phys_addr_t dev_addr;
>> +	size_t size;
>> +};
>> +
>> +/**
>> + * struct k3_m4_mem_data - memory definitions for m4 remote core
>> + * @name: name for this memory entry
>> + * @dev_addr: device address for the memory entry
>> + */
>> +struct k3_m4_mem_data {
>> +	const char *name;
>> +	const u32 dev_addr;
>> +};
>> +
>> +/**
>> + * struct k3_m4_boot_data - internal data structure used for boot
>> + * @boot_align_addr: Boot vector address alignment granularity
>> + * @uses_lreset: Flag to denote the need for local reset management
>> + */
>> +struct k3_m4_boot_data {
>> +	u32 boot_align_addr;
>> +	bool uses_lreset;
>> +};
>> +
>> +/**
>> + * struct k3_m4_privdata - Structure representing Remote processor data.
>> + * @m4_rst:		m4 rproc reset control data
>> + * @tsp:		Pointer to TISCI proc contrl handle
>> + * @data:		Pointer to DSP specific boot data structure
>> + * @mem:		Array of available memories
>> + * @num_mem:		Number of available memories
>> + */
>> +struct k3_m4_privdata {
>> +	struct reset_ctl m4_rst;
>> +	struct ti_sci_proc tsp;
>> +	struct k3_m4_boot_data *data;
>> +	struct k3_m4_mem *mem;
>> +	int num_mems;
>> +};
>> +
>> +/*
>> + * The M4 cores have a local reset that affects only the CPU, and a
>> + * generic module reset that powers on the device and allows the M4 internal
>> + * memories to be accessed while the local reset is asserted. This function is
>> + * used to release the global reset on M4F to allow loading into the M4F
>> + * internal RAMs. This helper function is invoked in k3_m4_load() before any
>> + * actual firmware loading and is undone only in k3_m4_stop(). The local reset
>> + * cannot be released on M4 cores until after the firmware images are loaded.
>> + */
>> +static int k3_m4_prepare(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	struct k3_m4_boot_data *data = m4->data;
>> +	int ret;
>> +
>> +	if (!data->uses_lreset)
>> +		return 0;
>> +
>> +	ret = ti_sci_proc_power_domain_on(&m4->tsp);
>> +	if (ret)
>> +		dev_err(dev, "cannot enable internal RAM loading, ret = %d\n",
>> +			ret);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * This function is the counterpart to k3_m4_prepare() and is used to assert
>> + * the global reset on M4 cores. This completes the second step of powering
>> + * down the M4 cores. The cores themselves are halted through the local reset
>> + * in first step. This function is invoked in k3_m4_stop() after the local
>> + * reset is asserted.
>> + */
>> +static int k3_m4_unprepare(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	struct k3_m4_boot_data *data = m4->data;
>> +
>> +	if (!data->uses_lreset)
>> +		return 0;
>> +
>> +	return ti_sci_proc_power_domain_off(&m4->tsp);
>> +}
>> +
>> +/**
>> + * k3_m4_load() - Load up the Remote processor image
>> + * @dev:	rproc device pointer
>> + * @addr:	Address at which image is available
>> + * @size:	size of the image
>> + *
>> + * Return: 0 if all goes good, else appropriate error message.
>> + */
>> +static int k3_m4_load(struct udevice *dev, ulong addr, ulong size)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	void *image_addr = (void *)addr;
>> +	int ret;
>> +
>> +	ret = ti_sci_proc_request(&m4->tsp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = k3_m4_prepare(dev);
>> +	if (ret) {
>> +		dev_err(dev, "Prepare failed for core %d\n",
>> +			m4->tsp.proc_id);
>> +		goto proc_release;
>> +	}
>> +
>> +	ti_secure_image_post_process(&image_addr, &size);
>> +
>> +	ret = rproc_elf_load_image(dev, addr, size);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Loading elf failed %d\n", ret);
>> +		goto unprepare;
>> +	}
>> +
>> +unprepare:
>> +	if (ret)
>> +		k3_m4_unprepare(dev);
>> +proc_release:
>> +	ti_sci_proc_release(&m4->tsp);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * k3_m4_start() - Start the remote processor
>> + * @dev:	rproc device pointer
>> + *
>> + * Return: 0 if all went ok, else return appropriate error
>> + */
>> +static int k3_m4_start(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	struct k3_m4_boot_data *data = m4->data;
>> +	int ret;
>> +
>> +	ret = ti_sci_proc_request(&m4->tsp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!data->uses_lreset) {
>> +		ret = ti_sci_proc_power_domain_on(&m4->tsp);
>> +		if (ret)
>> +			goto proc_release;
>> +	}
>> +
>> +	ret = reset_deassert(&m4->m4_rst);
>> +	if (ret) {
>> +		if (!data->uses_lreset)
>> +			ti_sci_proc_power_domain_off(&m4->tsp);
>> +	}
>> +
>> +proc_release:
>> +	ti_sci_proc_release(&m4->tsp);
>> +
>> +	return ret;
>> +}
>> +
>> +static int k3_m4_stop(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +
>> +	ti_sci_proc_request(&m4->tsp);
>> +	reset_assert(&m4->m4_rst);
>> +	ti_sci_proc_power_domain_off(&m4->tsp);
> 
> 
> Is is safe to call ti_sci_prop_power_domain_off when data->uses_lreset
> is set? The start function has a check included.

uses_lreset here is just a flag used in this driver which is always set
actually, so it does not really do anything. I see how this flag can
cause some confusion, let me cleanup this flag from the driver since it
will always be set.

Thanks for reviewing!

~ Judith


> 
> - Daniel
> 
>> +	ti_sci_proc_release(&m4->tsp);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * k3_m4_init() - Initialize the remote processor
>> + * @dev:	rproc device pointer
>> + *
>> + * Return: 0 if all went ok, else return appropriate error
>> + */
>> +static int k3_m4_init(struct udevice *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int k3_m4_reset(struct udevice *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void *k3_m4_da_to_va(struct udevice *dev, ulong da, ulong len)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	phys_addr_t bus_addr, dev_addr;
>> +	void __iomem *va = NULL;
>> +	size_t size;
>> +	u32 offset;
>> +	int i;
>> +
>> +	if (len <= 0)
>> +		return NULL;
>> +
>> +	for (i = 0; i < m4->num_mems; i++) {
>> +		bus_addr = m4->mem[i].bus_addr;
>> +		dev_addr = m4->mem[i].dev_addr;
>> +		size = m4->mem[i].size;
>> +
>> +		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
>> +			offset = da - dev_addr;
>> +			va = m4->mem[i].cpu_addr + offset;
>> +			return (__force void *)va;
>> +		}
>> +
>> +		if (da >= bus_addr && (da + len) <= (bus_addr + size)) {
>> +			offset = da - bus_addr;
>> +			va = m4->mem[i].cpu_addr + offset;
>> +			return (__force void *)va;
>> +		}
>> +	}
>> +
>> +	/* Assume it is DDR region and return da */
>> +	return map_physmem(da, len, MAP_NOCACHE);
>> +}
>> +
>> +static const struct dm_rproc_ops k3_m4_ops = {
>> +	.init = k3_m4_init,
>> +	.load = k3_m4_load,
>> +	.start = k3_m4_start,
>> +	.stop = k3_m4_stop,
>> +	.reset = k3_m4_reset,
>> +	.device_to_virt = k3_m4_da_to_va,
>> +};
>> +
>> +static int ti_sci_proc_of_to_priv(struct udevice *dev, struct ti_sci_proc *tsp)
>> +{
>> +	u32 ids[2];
>> +	int ret;
>> +
>> +	tsp->sci = ti_sci_get_by_phandle(dev, "ti,sci");
>> +	if (IS_ERR(tsp->sci)) {
>> +		dev_err(dev, "ti_sci get failed: %ld\n", PTR_ERR(tsp->sci));
>> +		return PTR_ERR(tsp->sci);
>> +	}
>> +
>> +	ret = dev_read_u32_array(dev, "ti,sci-proc-ids", ids, 2);
>> +	if (ret) {
>> +		dev_err(dev, "Proc IDs not populated %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	tsp->ops = &tsp->sci->ops.proc_ops;
>> +	tsp->proc_id = ids[0];
>> +	tsp->host_id = ids[1];
>> +	tsp->dev_id = dev_read_u32_default(dev, "ti,sci-dev-id",
>> +					   TI_SCI_RESOURCE_NULL);
>> +	if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
>> +		dev_err(dev, "Device ID not populated %d\n", ret);
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct k3_m4_mem_data am6_m4_mems[] = {
>> +	{ .name = "iram", .dev_addr = 0x0 },
>> +	{ .name = "dram", .dev_addr = 0x30000 },
>> +};
>> +
>> +static int k3_m4_of_get_memories(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +	int i;
>> +
>> +	m4->num_mems = ARRAY_SIZE(am6_m4_mems);
>> +	m4->mem = calloc(m4->num_mems, sizeof(*m4->mem));
>> +	if (!m4->mem)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < m4->num_mems; i++) {
>> +		m4->mem[i].bus_addr = dev_read_addr_size_name(dev,
>> +							      am6_m4_mems[i].name,
>> +					  (fdt_addr_t *)&m4->mem[i].size);
>> +		if (m4->mem[i].bus_addr == FDT_ADDR_T_NONE) {
>> +			dev_err(dev, "%s bus address not found\n",
>> +				am6_m4_mems[i].name);
>> +			return -EINVAL;
>> +		}
>> +		m4->mem[i].cpu_addr = map_physmem(m4->mem[i].bus_addr,
>> +						  m4->mem[i].size,
>> +						  MAP_NOCACHE);
>> +		m4->mem[i].dev_addr = am6_m4_mems[i].dev_addr;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * k3_of_to_priv() - generate private data from device tree
>> + * @dev:	corresponding k3 m4 processor device
>> + * @m4:		pointer to driver specific private data
>> + *
>> + * Return: 0 if all goes good, else appropriate error message.
>> + */
>> +static int k3_m4_of_to_priv(struct udevice *dev, struct k3_m4_privdata *m4)
>> +{
>> +	int ret;
>> +
>> +	ret = reset_get_by_index(dev, 0, &m4->m4_rst);
>> +	if (ret) {
>> +		dev_err(dev, "reset_get() failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = ti_sci_proc_of_to_priv(dev, &m4->tsp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =  k3_m4_of_get_memories(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	m4->data = (struct k3_m4_boot_data *)dev_get_driver_data(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * k3_m4_probe() - Basic probe
>> + * @dev:	corresponding k3 remote processor device
>> + *
>> + * Return: 0 if all goes good, else appropriate error message.
>> + */
>> +static int k3_m4_probe(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4;
>> +	int ret;
>> +
>> +	m4 = dev_get_priv(dev);
>> +	ret = k3_m4_of_to_priv(dev, m4);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * The M4 local resets are deasserted by default on Power-On-Reset.
>> +	 * Assert the local resets to ensure the M4s don't execute bogus code
>> +	 * in .load() callback when the module reset is released to support
>> +	 * internal memory loading. This is needed for M4 cores.
>> +	 */
>> +	reset_assert(&m4->m4_rst);
>> +
>> +	return 0;
>> +}
>> +
>> +static int k3_m4_remove(struct udevice *dev)
>> +{
>> +	struct k3_m4_privdata *m4 = dev_get_priv(dev);
>> +
>> +	free(m4->mem);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct k3_m4_boot_data m4_data = {
>> +	.boot_align_addr = SZ_1K,
>> +	.uses_lreset = true,
>> +};
>> +
>> +static const struct udevice_id k3_m4_ids[] = {
>> +	{ .compatible = "ti,am64-m4fss", .data = (ulong)&m4_data, },
>> +	{}
>> +};
>> +
>> +U_BOOT_DRIVER(k3_m4) = {
>> +	.name = "k3_m4",
>> +	.of_match = k3_m4_ids,
>> +	.id = UCLASS_REMOTEPROC,
>> +	.ops = &k3_m4_ops,
>> +	.probe = k3_m4_probe,
>> +	.remove = k3_m4_remove,
>> +	.priv_auto = sizeof(struct k3_m4_privdata),
>> +};

