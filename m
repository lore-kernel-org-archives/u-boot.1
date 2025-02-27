Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B06C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB1480FF0;
	Thu, 27 Feb 2025 11:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740651230;
	bh=/+EoCLVucVJ8Q0qSwaf9XnmPMYF/cNSOrItK+RCsmso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lA8Xq3CG9aH6z+n0xSt9VKpF/azU4NJbl6Etzw9c4XUT9POMmpFidEpzurIJsaO2q
	 crs7BkxgaOAhNJFZBxiUlS+FfmIchz/52AQmClyDPGYEGdY5MKs98Yrx04wGzFmoXy
	 RBIvpmTShfSnDZ6sj26T07mU5RwP/77KaMFiWjglF+k2/cyBVN5aR5RCrFsKExCO6s
	 pjXEU2/7Wx/N6XSyuSSqo7ZPJrnKJMpqs4GcsEuH8ydrLjtAz6d/y9fyfSPMbuA3pn
	 r+MtVvDInXbKn08iQMbL7UV4Ljr5D99BBM9AZWEH0zDLtlTh3oGKHXcC2qZx81LXki
	 5PA4JL2+MFFJA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD9F810F1; Thu, 27 Feb 2025 11:13:48 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4F18083E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Z3Rxz2LS5z9txn;
 Thu, 27 Feb 2025 11:13:43 +0100 (CET)
Message-ID: <851ff808-0ffa-44e8-8a10-3545f1369c93@denx.de>
Date: Thu, 27 Feb 2025 11:13:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] u-boot: drivers: marvell: rtc: adding rtc driver
To: Josua Mayer <josua@solid-run.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alex Leibovich <alexl@marvell.com>,
 Kostya Porotchkin <kostap@marvell.com>
References: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
 <20250209-cn9130-board-v1-1-b94ab83e141b@solid-run.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250209-cn9130-board-v1-1-b94ab83e141b@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Z3Rxz2LS5z9txn
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

On 09.02.25 21:23, Josua Mayer wrote:
> From: Alex Leibovich <alexl@marvell.com>
> 
> Adding missing marvell-rtc driver and configuration,
> in order to support "date" command.
> 
> Signed-off-by: Alex Leibovich <alexl@marvell.com>
> Reviewed-on: https://sj1git1.cavium.com/c/IP/SW/boot/u-boot/+/6322
> Reviewed-by: Kostya Porotchkin <kostap@marvell.com>
> Tested-by: Kostya Porotchkin <kostap@marvell.com>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   drivers/rtc/Kconfig       |   9 +++
>   drivers/rtc/Makefile      |   1 +
>   drivers/rtc/marvell_rtc.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/rtc/marvell_rtc.h |  52 +++++++++++++

"marvell_rtc"? I assume this is a plain copy from the original Marvell
commit. But still, this sounds too generic.

Looking at Linux, this file name is used for this compatible property:

rtc-armada38x.c

I would prefer to move this way.

>   4 files changed, 247 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 6467f20422bec546fd96b5e76643209870c8f255..aa2b292c57243f84d99d09b45aa271d66cd15a66 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -14,6 +14,15 @@ config DM_RTC
>   	  drivers to perform the actual functions. See rtc.h for a
>   	  description of the API.
>   
> +config MARVELL_RTC
> +	bool "MARVELL RTC support"
> +	depends on DM_RTC
> +	help
> +	  Choose this option to add
> +	  support for Marvell's
> +	  RTC driver, which is used
> +	  by Armada 7K, 8K and OcteonTX2 CN913x.
> +

The line wrapping does not look appealing to me.

>   config SPL_DM_RTC
>   	bool "Enable Driver Model for RTC drivers in SPL"
>   	depends on SPL_DM
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 99b5a2a346a9680ee33249597cec398c33e8d657..65c4d875d885546efb230bc5abd78e5d056ee863 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -7,6 +7,7 @@
>   obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
>   
>   obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
> +obj-$(CONFIG_MARVELL_RTC) += marvell_rtc.o
>   obj-$(CONFIG_RTC_DAVINCI) += davinci.o
>   obj-$(CONFIG_RTC_DS1307) += ds1307.o
>   obj-$(CONFIG_RTC_DS1338) += ds1307.o
> diff --git a/drivers/rtc/marvell_rtc.c b/drivers/rtc/marvell_rtc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..842aeb84eb26ec79ff889d0484bcdb050da35b40
> --- /dev/null
> +++ b/drivers/rtc/marvell_rtc.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Marvell International Ltd.
> + */
> +
> +#include <asm/io.h>
> +#include <rtc.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include "marvell_rtc.h"
> +#include <linux/delay.h>
> +
> +static int marvell_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
> +	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
> +
> +	rtc_to_tm(RTC_READ_REG(rtc_base, RTC_TIME_REG_OFFS), time);
> +
> +	return 0;
> +}
> +
> +static int marvell_rtc_set(struct udevice *dev, const struct rtc_time *time)
> +{
> +	unsigned long tm;
> +	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
> +	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
> +
> +	tm = rtc_mktime(time);
> +
> +#ifdef ERRATA_FE_3124064
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +#endif

Ah, now it gets a bit ugly. As this is also a verbatim copy of the
original Marvell version, I hesitate to remove this and do the
necessary cleanup directly with this initial commit. Perhaps it's
better to do some cleanup with a follow-up commit?

Some more comments below...

> +	RTC_WRITE_REG(tm, rtc_base, RTC_TIME_REG_OFFS);
> +
> +	/* Give registers time to stabilize */
> +	mdelay(100);
> +
> +	return 0;
> +}
> +
> +static int marvell_rtc_reset(struct udevice *dev)
> +{
> +	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
> +	uintptr_t rtc_base = (uintptr_t)rtc_cfg->rtc_base;
> +
> +	/* Reset Test register */
> +	RTC_WRITE_REG(0, rtc_base, RTC_TEST_CONFIG_REG_OFFS);
> +	/* Oscillator startup time */
> +	mdelay(500);
> +
> +	/* Reset time register */
> +#ifdef ERRATA_FE_3124064
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +#endif
> +	RTC_WRITE_REG(0, rtc_base, RTC_TIME_REG_OFFS);
> +	udelay(62);
> +
> +	/* Reset Status register */
> +	RTC_WRITE_REG((RTC_SZ_STATUS_ALARM1_MASK | RTC_SZ_STATUS_ALARM2_MASK),
> +		      rtc_base, RTC_STATUS_REG_OFFS);
> +	udelay(62);

62? Really?

> +
> +	/* Turn off Int1 and Int2 sources & clear the Alarm count */
> +	RTC_WRITE_REG(0, rtc_base, RTC_IRQ_1_CONFIG_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_IRQ_2_CONFIG_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_ALARM_1_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_ALARM_2_REG_OFFS);
> +
> +	/* Setup nominal register access timing */
> +	RTC_WRITE_REG(RTC_NOMINAL_TIMING, rtc_base, RTC_CLOCK_CORR_REG_OFFS);
> +
> +	/* Reset time register */
> +#ifdef ERRATA_FE_3124064
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +	RTC_WRITE_REG(0, rtc_base, RTC_STATUS_REG_OFFS);
> +#endif
> +	RTC_WRITE_REG(0, rtc_base, RTC_TIME_REG_OFFS);
> +	udelay(10);
> +
> +	/* Reset Status register */
> +	RTC_WRITE_REG((RTC_SZ_STATUS_ALARM1_MASK | RTC_SZ_STATUS_ALARM2_MASK),
> +		      rtc_base, RTC_STATUS_REG_OFFS);
> +	udelay(50);
> +
> +	return 0;
> +}
> +
> +void marvell_rtc_errata(struct udevice *dev)
> +{
> +	unsigned long reg;
> +
> +	/* Get the rtc register base address */
> +	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
> +	uintptr_t rtc_base;
> +
> +	rtc_cfg->rtc_base = (void *)devfdt_get_addr_index(dev, 0);
> +	rtc_base = (uintptr_t)rtc_cfg->rtc_base;
> +
> +	/* Update RTC-MBUS bridge timing parameters */
> +	/* Functional Errata Ref #:
> +	 * FE-3124064 - WA for failing time read attempts.
> +	 * Description:
> +	 *	The device supports CPU write and read access
> +	 *	to the RTC Time register.
> +	 *	However, due to this erratum,
> +	 *	Write to RTC TIME register may fail.
> +	 *	Read from RTC TIME register may fail.
> +	 * Workaround:
> +	 * 1. Configure the RTC Mbus Bridge Timing Control register
> +	 *    (offset 0x284080 and 0x284084)
> +	 *	- Write RTC WRCLK Period 0x3FF (default value is 0xFA)
> +	 *	- Write RTC WRCLK setup to 0x29 (default value is 0x53)
> +	 *	- Write RTC Read Output Delay to 0x3F (default value is 0x10)
> +	 *	- Write RTC WRCLK High Time to 0x53 (default value)
> +	 *	- Mbus - Read All Byte Enable to 0x1 (default value)
> +	 * 2. Configure the RTC Test Configuration Register (offset 0x28401C)
> +	 *    bit3 to '1' (Reserved, Marvell internal)
> +	 *
> +	 * RTC Time register write operation:
> +	 *	- Issue two dummy writes of 0x0 to the RTC Status register
> +	 *	  (offset 0x284000).
> +	 *	- Write the time to the RTC Time register (offset 0x28400C).
> +	 */
> +	reg = RTC_READ_REG(rtc_base, MV_RTC0_SOC_OFFSET);
> +	reg &= ~RTC_WRCLK_PERIOD_MASK;
> +	reg |= 0x3FF << RTC_WRCLK_PERIOD_OFFS;
> +	reg &= ~RTC_WRCLK_SETUP_MASK;
> +	reg |= 0x29 << RTC_WRCLK_SETUP_OFFS;
> +	RTC_WRITE_REG(reg, rtc_base, MV_RTC0_SOC_OFFSET);
> +
> +	reg = RTC_READ_REG(rtc_base, MV_RTC1_SOC_OFFSET);
> +	reg &= ~RTC_READ_OUTPUT_DELAY_MASK;
> +	reg |= 0x3F << RTC_READ_OUTPUT_DELAY_OFFS;
> +	RTC_WRITE_REG(reg, rtc_base, MV_RTC1_SOC_OFFSET);
> +
> +	reg = RTC_READ_REG(rtc_base, RTC_TEST_CONFIG_REG_OFFS);
> +	reg |= 0x8;
> +	RTC_WRITE_REG(reg, rtc_base, RTC_TEST_CONFIG_REG_OFFS);
> +}
> +
> +static int marvell_rtc_probe(struct udevice *dev)
> +{
> +#ifdef ERRATA_FE_3124064
> +	marvell_rtc_errata(dev);
> +#else
> +	/* Get the rtc register base address */
> +	struct rtc_unit_config *rtc_cfg = dev_get_priv(dev);
> +	uintptr_t rtc_base;
> +	unsigned long reg;
> +
> +	rtc_cfg->rtc_base = (void *)devfdt_get_addr_index(dev, 0);
> +	rtc_base = (uintptr_t)rtc_cfg->rtc_base;
> +
> +	/* Update RTC-MBUS bridge timing parameters */
> +	reg = RTC_READ_REG(rtc_base, MV_RTC1_SOC_OFFSET);
> +	reg &= ~RTC_READ_OUTPUT_DELAY_MASK;
> +	reg |= 0x1F << RTC_READ_OUTPUT_DELAY_OFFS;
> +	RTC_WRITE_REG(reg, rtc_base, MV_RTC1_SOC_OFFSET);
> +#endif
> +
> +	return 0;
> +}
> +
> +static const struct rtc_ops marvell_rtc_ops = {
> +	.get = marvell_rtc_get,
> +	.set = marvell_rtc_set,
> +	.reset = marvell_rtc_reset,
> +};
> +
> +static const struct udevice_id marvell_rtc_ids[] = {
> +	{ .compatible = "marvell,armada-8k-rtc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(marvell_rtc) = {
> +	.name	= "marvell_rtc",
> +	.id	= UCLASS_RTC,
> +	.of_match = marvell_rtc_ids,
> +	.ops	= &marvell_rtc_ops,
> +	.probe = marvell_rtc_probe,
> +	.priv_auto = sizeof(struct rtc_unit_config),
> +};
> diff --git a/drivers/rtc/marvell_rtc.h b/drivers/rtc/marvell_rtc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..f93b03bd2c954f1be9b645fb4de23a89e92e9dbc
> --- /dev/null
> +++ b/drivers/rtc/marvell_rtc.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2019 Marvell International Ltd.
> + */
> +
> +#ifndef _MARVELL_RTC_H
> +#define _MARVELL_RTC_H
> +
> +/* The RTC DRS revision 1.2 indicates that firmware should wait
> + * 5us after every register write to the RTC hard macro,
> + * so that the required update can occur without holding off the system bus
> + */
> +#define RTC_READ_REG(rtc_base, reg)		readl((rtc_base) + (reg))
> +#define RTC_WRITE_REG(val, rtc_base, reg)		\
> +	{ writel((val), (rtc_base) + (reg)); udelay(5); }

The marcos should probably be changed into some (inline?) functions?

> +
> +#define RTC_NOMINAL_TIMING		0x2000
> +
> +#define RTC_STATUS_REG_OFFS		0x0
> +#define RTC_IRQ_1_CONFIG_REG_OFFS	0x4
> +#define RTC_IRQ_2_CONFIG_REG_OFFS	0x8
> +#define RTC_TIME_REG_OFFS		0xC
> +#define RTC_ALARM_1_REG_OFFS		0x10
> +#define RTC_ALARM_2_REG_OFFS		0x14
> +#define RTC_CLOCK_CORR_REG_OFFS		0x18
> +#define RTC_TEST_CONFIG_REG_OFFS	0x1C
> +#define MV_RTC0_SOC_OFFSET		0x80
> +#define MV_RTC1_SOC_OFFSET		0x84
> +
> +#define RTC_WRCLK_PERIOD_OFFS		0
> +#define RTC_WRCLK_PERIOD_MASK		(0xFFFF << RTC_WRCLK_PERIOD_OFFS)
> +#define RTC_WRCLK_SETUP_OFFS		16
> +#define RTC_WRCLK_SETUP_MASK		(0xFFFF << RTC_WRCLK_SETUP_OFFS)
> +
> +#define RTC_READ_OUTPUT_DELAY_OFFS	0
> +#define RTC_READ_OUTPUT_DELAY_MASK	(0xFFFF << RTC_READ_OUTPUT_DELAY_OFFS)
> +#define RTC_WRCLK_CLOCK_HIGH_OFFS	16
> +#define RTC_WRCLK_CLOCK_HIGH_MASK	(0xFFFF << RTC_WRCLK_CLOCK_HIGH_OFFS)
> +
> +#define RTC_SZ_STATUS_ALARM1_MASK		0x1
> +#define RTC_SZ_STATUS_ALARM2_MASK		0x2
> +#define RTC_SZ_TIMING_RESERVED1_MASK		0xFFFF0000
> +#define RTC_SZ_INTERRUPT1_INT1AE_MASK		0x1
> +#define RTC_SZ_INTERRUPT1_RESERVED1_MASK	0xFFFFFFC0
> +#define RTC_SZ_INTERRUPT2_INT2FE_MASK		0x2
> +#define RTC_SZ_INTERRUPT2_RESERVED1_MASK	0xFFFFFFC0
> +
> +struct rtc_unit_config {
> +	void __iomem *rtc_base;
> +};
> +
> +#endif /* _MARVELL_RTC_H */
> 


Thanks,
Stefan
