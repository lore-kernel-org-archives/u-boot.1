Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DEBCA0FE4
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 15:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBFF847D3;
	Fri,  1 Sep 2023 17:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Kf54MU/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546B985DE0; Fri,  1 Sep 2023 17:06:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375FD83F7A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 17:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381F6fg7079516;
 Fri, 1 Sep 2023 10:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693580801;
 bh=LmVXSOqOD+i0rfxPFGHmhr2QVKGG+yPOlF6ygzMBtGo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Kf54MU/YXmH7frSjphpnEROlCbgs6AcijxiXtykMZ9arDOFMxvz0Foy/vbpZjPOjz
 mG9LKkTPZyTIxqNNrcrDO0Syr/zi/KPT2TB+avRcwskG/zxFt3uHNQELx7kYAW1ozC
 4P7d6/kmutQiHWx9CK7lPSn65WDc7W7KFXbW0l7Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381F6f5f081283
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 10:06:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 10:06:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 10:06:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381F6eOd111348;
 Fri, 1 Sep 2023 10:06:40 -0500
Date: Fri, 1 Sep 2023 10:06:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>, <peng.fan@nxp.com>,
 <ye.li@nxp.com>, <robimarko@gmail.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH 1/2] thermal: k3-j72xx-bandgap: Add support for vtm
Message-ID: <20230901150640.u7nyi3hawwkz3rbs@leverage>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
 <20230901061500.2342452-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901061500.2342452-2-u-kumar1@ti.com>
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

On 11:44-20230901, Udit Kumar wrote:
> Add support for VTM (Voltage and Thermal Manager), which
> is part of TI's K3 series SOC.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/thermal/Kconfig            |   6 +
>  drivers/thermal/Makefile           |   1 +
>  drivers/thermal/k3_j72xx_bandgap.c | 539 +++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100644 drivers/thermal/k3_j72xx_bandgap.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 681b621760..5ecd916365 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -35,6 +35,12 @@ config IMX_TMU
>  	  The boot is hold to the cool device to throttle CPUs when the
>  	  passive trip is crossed
>  
> +config TI_K3_THERMAL
> +        bool "Temperature sensor driver for TI K3 j7xx SOCs"
> +        help
> +	 Enable thermal support for the Texas Instruments TI K3 j7xx family.
> +	 The driver supports reading CPU temperature.
> +
>  config TI_DRA7_THERMAL
>          bool "Temperature sensor driver for TI dra7xx SOCs"
>          help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8acc7d20cb..e2a6d9f877 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
>  obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
>  obj-$(CONFIG_IMX_SCU_THERMAL) += imx_scu_thermal.o
>  obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
> +obj-$(CONFIG_TI_K3_THERMAL) += k3_j72xx_bandgap.o
>  obj-$(CONFIG_IMX_TMU) += imx_tmu.o
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> new file mode 100644
> index 0000000000..5524bb5c9a
> --- /dev/null
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Bandgap temperature sensor driver for J72XX SoC Family
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + *
> + * Taken from Linux v6.5 (drivers/thermal/k3_j72xx_bandgap.c)
> + * and ported to uboot
> + */
> +
> +#include <linux/math64.h>
> +#include <dm.h>
> +#include <dm/devres.h>
> +#include <thermal.h>
> +
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +
> +#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
> +#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
> +#define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
> +#define K3_VTM_MISC_CTRL_OFFSET			0xc
> +#define K3_VTM_TMPSENS_STAT_OFFSET		0x8
> +#define K3_VTM_ANYMAXT_OUTRG_ALERT_EN		0x1
> +#define K3_VTM_MISC_CTRL2_OFFSET		0x10
> +#define K3_VTM_TS_STAT_DTEMP_MASK		0x3ff
> +#define K3_VTM_MAX_NUM_TS			8
> +#define K3_VTM_TMPSENS_CTRL_SOC			BIT(5)
> +#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
> +#define K3_VTM_TMPSENS_CTRL_CLKON_REQ		BIT(7)
> +#define K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN	BIT(11)
> +
> +#define K3_VTM_CORRECTION_TEMP_CNT		3
> +
> +#define MINUS40CREF				5
> +#define PLUS30CREF				253
> +#define PLUS125CREF				730
> +#define PLUS150CREF				940
> +
> +#define TABLE_SIZE				1024
> +#define MAX_TEMP				123000
> +#define COOL_DOWN_TEMP				105000
> +
> +#define FACTORS_REDUCTION			13
> +static int *derived_table;
> +
> +static u64 int_pow(u64 base, unsigned int exp)
> +{
> +	u64 result = 1;
> +
> +	while (exp) {
> +		if (exp & 1)
> +			result *= base;
> +		exp >>= 1;
> +		base *= base;
> +	}
> +
> +	return result;
> +}
> +
> +static int compute_value(int index, const s64 *factors, int nr_factors,
> +			 int reduction)
> +{
> +	s64 value = 0;
> +	int i;
> +
> +	for (i = 0; i < nr_factors; i++)
> +		value += factors[i] * int_pow(index, i);
> +
> +	return (int)div64_s64(value, int_pow(10, reduction));
> +}
> +
> +static void init_table(int factors_size, int *table, const s64 *factors)
> +{
> +	int i;
> +
> +	for (i = 0; i < TABLE_SIZE; i++)
> +		table[i] = compute_value(i, factors, factors_size,
> +					 FACTORS_REDUCTION);
> +}
> +
> +/**
> + * struct err_values - structure containing error/reference values
> + * @refs: reference error values for -40C, 30C, 125C & 150C
> + * @errs: Actual error values for -40C, 30C, 125C & 150C read from the efuse
> + */
> +struct err_values {
> +	int refs[4];
> +	int errs[4];
> +};
> +
> +static void create_table_segments(struct err_values *err_vals, int seg,
> +				  int *ref_table)
> +{
> +	int m = 0, c, num, den, i, err, idx1, idx2, err1, err2, ref1, ref2;
> +
> +	if (seg == 0)
> +		idx1 = 0;
> +	else
> +		idx1 = err_vals->refs[seg];
> +
> +	idx2 = err_vals->refs[seg + 1];
> +	err1 = err_vals->errs[seg];
> +	err2 = err_vals->errs[seg + 1];
> +	ref1 = err_vals->refs[seg];
> +	ref2 = err_vals->refs[seg + 1];
> +
> +	/*
> +	 * Calculate the slope with adc values read from the register
> +	 * as the y-axis param and err in adc value as x-axis param
> +	 */
> +	num = ref2 - ref1;
> +	den = err2 - err1;
> +	if (den)
> +		m = num / den;
> +	c = ref2 - m * err2;
> +
> +	/*
> +	 * Take care of divide by zero error if error values are same
> +	 * Or when the slope is 0
> +	 */
> +	if (den != 0 && m != 0) {
> +		for (i = idx1; i <= idx2; i++) {
> +			err = (i - c) / m;
> +			if (((i + err) < 0) || ((i + err) >= TABLE_SIZE))
> +				continue;
> +			derived_table[i] = ref_table[i + err];
> +		}
> +	} else { /* Constant error take care of divide by zero */
> +		for (i = idx1; i <= idx2; i++) {
> +			if (((i + err1) < 0) || ((i + err1) >= TABLE_SIZE))
> +				continue;
> +			derived_table[i] = ref_table[i + err1];
> +		}
> +	}
> +}
> +
> +static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
> +{
> +	int inc, i, seg;
> +
> +	/*
> +	 * Fill up the lookup table under 3 segments
> +	 * region -40C to +30C
> +	 * region +30C to +125C
> +	 * region +125C to +150C
> +	 */
> +	for (seg = 0; seg < 3; seg++)
> +		create_table_segments(err_vals, seg, ref_table);
> +
> +	/* Get to the first valid temperature */
> +	i = 0;
> +	while (!derived_table[i])
> +		i++;
> +
> +	/*
> +	 * Get to the last zero index and back fill the temperature for
> +	 * sake of continuity
> +	 */
> +	if (i) {
> +		/* 300 milli celsius steps */
> +		while (i--)
> +			derived_table[i] = derived_table[i + 1] - 300;
> +	}
> +
> +	/*
> +	 * Fill the last trailing 0s which are unfilled with increments of
> +	 * 100 milli celsius till 1023 code
> +	 */
> +	i = TABLE_SIZE - 1;
> +	while (!derived_table[i])
> +		i--;
> +
> +	i++;
> +	inc = 1;
> +	while (i < TABLE_SIZE) {
> +		derived_table[i] = derived_table[i - 1] + inc * 100;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +struct k3_thermal_data;
> +
> +struct k3_j72xx_bandgap {
> +	struct udevice *dev;
> +	void __iomem *base;
> +	void __iomem *cfg2_base;
> +	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
> +};
> +
> +/* common data structures */
> +struct k3_thermal_data {
> +	struct k3_j72xx_bandgap *bgp;
> +	u32 ctrl_offset;
> +	u32 stat_offset;
> +};
> +
> +static int two_cmp(int tmp, int mask)
> +{
> +	tmp = ~(tmp);
> +	tmp &= mask;
> +	tmp += 1;
> +
> +	/* Return negative value */
> +	return (0 - tmp);
> +}
> +
> +static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
> +				       unsigned int s2)
> +{
> +	int d01 = abs(s0 - s1);
> +	int d02 = abs(s0 - s2);
> +	int d12 = abs(s1 - s2);
> +
> +	if (d01 <= d02 && d01 <= d12)
> +		return (s0 + s1) / 2;
> +
> +	if (d02 <= d01 && d02 <= d12)
> +		return (s0 + s2) / 2;
> +
> +	return (s1 + s2) / 2;
> +}
> +
> +static inline int k3_bgp_read_temp(struct k3_j72xx_bandgap *bgp,
> +				   int *temp)
> +{
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	/*
> +	 * Errata is applicable for am654 pg 1.0 silicon/J7ES. There
> +	 * is a variation of the order for certain degree centigrade on AM654.
> +	 * Work around that by getting the average of two closest
> +	 * readings out of three readings everytime we want to
> +	 * report temperatures.
> +	 *
> +	 * Errata workaround.
> +	 */
> +	s0 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s1 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s2 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	dtemp = vtm_get_best_value(s0, s1, s2);
> +
> +	if (dtemp < 0 || dtemp >= TABLE_SIZE)
> +		return -EINVAL;
> +
> +	*temp = derived_table[dtemp];
> +
> +	return 0;
> +}
> +
> +/* Get temperature callback function for thermal zone */
> +static int k3_thermal_get_temp(struct udevice *dev,  int *temp)
> +{
> +	struct k3_j72xx_bandgap *bgp = dev_get_priv(dev);
> +
> +	return k3_bgp_read_temp(bgp, temp);
> +}
> +
> +static const struct dm_thermal_ops k3_of_thermal_ops = {
> +	.get_temp = k3_thermal_get_temp,
> +};
> +
> +static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
> +{
> +	int low = 0, high = TABLE_SIZE - 1, mid;
> +
> +	if (temp > 160000 || temp < -50000)
> +		return -EINVAL;
> +
> +	/* Binary search to find the adc code */
> +	while (low < (high - 1)) {
> +		mid = (low + high) / 2;
> +		if (temp <= derived_table[mid])
> +			high = mid;
> +		else
> +			low = mid;
> +	}
> +
> +	return mid;
> +}
> +
> +static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
> +			     void __iomem *fuse_base)
> +{
> +	int i, tmp, pow;
> +	int ct_offsets[5][K3_VTM_CORRECTION_TEMP_CNT] = {
> +		{ 0x0, 0x8, 0x4 },
> +		{ 0x0, 0x8, 0x4 },
> +		{ 0x0, -1,  0x4 },
> +		{ 0x0, 0xC, -1 },
> +		{ 0x0, 0xc, 0x8 }
> +	};
> +	int ct_bm[5][K3_VTM_CORRECTION_TEMP_CNT] = {
> +		{ 0x3f, 0x1fe000, 0x1ff },
> +		{ 0xfc0, 0x1fe000, 0x3fe00 },
> +		{ 0x3f000, 0x7f800000, 0x7fc0000 },
> +		{ 0xfc0000, 0x1fe0, 0x1f800000 },
> +		{ 0x3f000000, 0x1fe000, 0x1ff0 }
> +	};
> +
> +	for (i = 0; i < 3; i++) {
> +		/* Extract the offset value using bit-mask */
> +		if (ct_offsets[id][i] == -1 && i == 1) {
> +			/* 25C offset Case of Sensor 2 split between 2 regs */
> +			tmp = (readl(fuse_base + 0x8) & 0xE0000000) >> (29);
> +			tmp |= ((readl(fuse_base + 0xC) & 0x1F) << 3);
> +			pow = tmp & 0x80;
> +		} else if (ct_offsets[id][i] == -1 && i == 2) {
> +			/* 125C Case of Sensor 3 split between 2 regs */
> +			tmp = (readl(fuse_base + 0x4) & 0xF8000000) >> (27);
> +			tmp |= ((readl(fuse_base + 0x8) & 0xF) << 5);
> +			pow = tmp & 0x100;
> +		} else {
> +			tmp = readl(fuse_base + ct_offsets[id][i]);
> +			tmp &= ct_bm[id][i];
> +			tmp = tmp >> __ffs(ct_bm[id][i]);
> +
> +			/* Obtain the sign bit pow*/
> +			pow = ct_bm[id][i] >> __ffs(ct_bm[id][i]);
> +			pow += 1;
> +			pow /= 2;
> +		}
> +
> +		/* Check for negative value */
> +		if (tmp & pow) {
> +			/* 2's complement value */
> +			tmp = two_cmp(tmp, ct_bm[id][i] >> __ffs(ct_bm[id][i]));
> +		}
> +		err[i] = tmp;
> +	}
> +
> +	/* Err value for 150C is set to 0 */
> +	err[i] = 0;
> +}
> +
> +static void print_look_up_table(struct udevice *dev, int *ref_table)
> +{
> +	int i;
> +
> +	debug("The contents of derived array\n");
> +	debug("Code   Temperature\n");
> +	for (i = 0; i < TABLE_SIZE; i++)
> +		debug("%d       %d %d\n", i, derived_table[i], ref_table[i]);
> +}
> +
> +struct k3_j72xx_bandgap_data {
> +	const bool has_errata_i2128;
> +};
> +
> +static int k3_j72xx_bandgap_probe(struct udevice *dev)
> +{
> +	int ret = 0, cnt, val, id;
> +	int high_max, low_temp;
> +	struct k3_j72xx_bandgap *bgp;
> +	struct k3_thermal_data *data;
> +	bool workaround_needed = false;
> +	const struct k3_j72xx_bandgap_data *driver_data;
> +	int *ref_table;
> +	struct err_values err_vals;
> +	void __iomem *fuse_base;
> +
> +	const s64 golden_factors[] = {
> +		-490019999999999936,
> +		3251200000000000,
> +		-1705800000000,
> +		603730000,
> +		-92627,
> +	};
> +
> +	const s64 pvt_wa_factors[] = {
> +		-415230000000000000,
> +		3126600000000000,
> +		-1157800000000,
> +	};
> +	bgp = dev_get_priv(dev);
> +	if (!bgp)
> +		return -ENOMEM;
> +
> +	bgp->dev = dev;
> +	bgp->base = (void __iomem *)devfdt_get_addr_index(dev, 0);
> +	if (IS_ERR(bgp->base))
> +		return PTR_ERR(bgp->base);
> +
> +	bgp->cfg2_base = (void __iomem *)devfdt_get_addr_index(dev, 1);
> +	if (IS_ERR(bgp->cfg2_base))
> +		return PTR_ERR(bgp->cfg2_base);
> +
> +	driver_data = (const struct k3_j72xx_bandgap_data *)dev_get_driver_data(dev);
> +	if (driver_data)
> +		workaround_needed = driver_data->has_errata_i2128;
> +
> +	/*
> +	 * Some of TI's J721E SoCs require a software trimming procedure
> +	 * for the temperature monitors to function properly. To determine
> +	 * if this particular SoC is NOT affected, both bits in the
> +	 * WKUP_SPARE_FUSE0[31:30] will be set (0xC0000000) indicating
> +	 * when software trimming should NOT be applied.
> +	 *
> +	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> +	 */
> +	if (workaround_needed) {
> +		fuse_base = (void __iomem *)devfdt_get_addr_index(dev, 2);
> +		if (IS_ERR(fuse_base))
> +			return PTR_ERR(fuse_base);
> +
> +		if ((readl(fuse_base) & 0xc0000000) == 0xc0000000)
> +			workaround_needed = false;
> +	}
> +
> +	debug("Work around %sneeded\n", workaround_needed ? "" : "not ");
> +
> +	/* Get the sensor count in the VTM */
> +	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> +	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +
> +	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
> +	if (!ref_table) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
> +				     GFP_KERNEL);
> +	if (!derived_table) {
> +		ret = -ENOMEM;
> +		goto err_free_ref_table;
> +	}
> +
> +	if (!workaround_needed)
> +		init_table(5, ref_table, golden_factors);
> +	else
> +		init_table(3, ref_table, pvt_wa_factors);
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < cnt; id++) {
> +		data[id].bgp = bgp;
> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
> +		data[id].stat_offset = data[id].ctrl_offset +
> +					K3_VTM_TMPSENS_STAT_OFFSET;
> +
> +		if (workaround_needed) {
> +			/* ref adc values for -40C, 30C & 125C respectively */
> +			err_vals.refs[0] = MINUS40CREF;
> +			err_vals.refs[1] = PLUS30CREF;
> +			err_vals.refs[2] = PLUS125CREF;
> +			err_vals.refs[3] = PLUS150CREF;
> +			get_efuse_values(id, &data[id], err_vals.errs, fuse_base);
> +		}
> +
> +		if (id == 0 && workaround_needed)
> +			prep_lookup_table(&err_vals, ref_table);
> +		else if (id == 0 && !workaround_needed)
> +			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
> +
> +		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> +			K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> +		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
> +
> +		bgp->ts_data[id] = &data[id];
> +	}
> +
> +	/*
> +	 * Program TSHUT thresholds
> +	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> +	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> +	 *         This is already taken care as per of init
> +	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> +	 */
> +	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> +	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> +
> +	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
> +	       K3_VTM_MISC_CTRL2_OFFSET);
> +	mdelay(100);
> +	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
> +	       K3_VTM_MISC_CTRL_OFFSET);
> +
> +	print_look_up_table(dev, ref_table);
> +	/*
> +	 * Now that the derived_table has the appropriate look up values
> +	 * Free up the ref_table
> +	 */
> +	kfree(ref_table);
> +
> +	return 0;
> +
> +err_free_ref_table:
> +	kfree(ref_table);
> +
> +err_alloc:
> +
> +	return ret;
> +}
> +
> +static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
> +	.has_errata_i2128 = true,
> +};
> +
> +static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
> +	.has_errata_i2128 = false,
> +};
> +
> +static const struct  udevice_id of_k3_j72xx_bandgap_match[] = {
> +	{
> +		.compatible = "ti,j721e-vtm",
> +		.data = (ulong)&k3_j72xx_bandgap_j721e_data,

So what happens to drivers/misc/k3_avs.c ?
> +	},
> +	{
> +		.compatible = "ti,j7200-vtm",
> +		.data = (ulong)&k3_j72xx_bandgap_j7200_data,
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +U_BOOT_DRIVER(ti_bandgap_thermal) = {
> +	.name	= "ti_bandgap_thermal",
> +	.id	= UCLASS_THERMAL,
> +	.ops	= &k3_of_thermal_ops,
> +	.probe	= k3_j72xx_bandgap_probe,
> +	.of_match = of_k3_j72xx_bandgap_match,
> +	.priv_auto	= sizeof(struct k3_j72xx_bandgap),
> +};
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
