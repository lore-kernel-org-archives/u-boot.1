Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 05:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25ABC87FFB;
	Thu, 16 May 2024 07:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715837956;
	bh=ogaXkOS9eJ0pP1NSg10PBmFv+o6Q9wcPo7nBmWg016k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WsUDTIjyYsusq7hcEPUqiQNYrREkwwC6vb2BYg4k8aQcDcTHqfu5eXYk1YrOaAWUW
	 Oux2MPSVuCrjAfU3FHI3Z3DEXJSyB5TMcGOGPecQ3OOwUcWgYCNlANDSExKcKJauvx
	 f9/qK6XaX5EnDTOU41uCIK4IlknTamlaQSlmiO/+U6z8AcPMzaI2IRaDhKjEnVyKLU
	 p2/XRItFAdQh9of4rS8cQynMuMD3g387MvqSlRrUj7aZWkuun3uCs6kICAJXce4c7T
	 dJQCuhoeiWAv5ih0OuU/GxG0KSITcRnENbs5Jw5dkfA7Rzv7JT/TMaAHBM7H8m3gD1
	 bqcxS2+qmfAWQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000F688003; Thu, 16 May 2024 07:39:14 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC82987FF0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 07:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VfzRh2WHlz9sqn;
 Thu, 16 May 2024 07:39:12 +0200 (CEST)
Message-ID: <6ccec60b-471d-4db1-a50e-2d1f3a2039af@denx.de>
Date: Thu, 16 May 2024 07:39:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] watchdog: Add support for ADI SC5XX-family watchdog
 peripheral
To: Greg Malysa <greg.malysa@timesys.com>, u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
 <20240515215837.14028-8-greg.malysa@timesys.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240515215837.14028-8-greg.malysa@timesys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VfzRh2WHlz9sqn
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

On 5/15/24 23:57, Greg Malysa wrote:
> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
> 
>   MAINTAINERS                |   1 +
>   drivers/watchdog/Kconfig   |   9 +++
>   drivers/watchdog/Makefile  |   1 +
>   drivers/watchdog/adi_wdt.c | 145 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 156 insertions(+)
>   create mode 100644 drivers/watchdog/adi_wdt.c

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1685f0352..6feb7e540b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -618,6 +618,7 @@ F:	drivers/pinctrl/pinctrl-adi-adsp.c
>   F:	drivers/serial/serial_adi_uart4.c
>   F:	drivers/timer/adi_sc5xx_timer.c
>   F:	drivers/usb/musb-new/sc5xx.c
> +F:	drivers/watchdog/adi_wdt.c
>   F:	include/env/adi/
>   
>   ARM SNAPDRAGON
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8318fd77a3..5a62000272 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -94,6 +94,15 @@ config WDT_APPLE
>   	  The watchdog will perform a full SoC reset resulting in a
>   	  reboot of the entire system.
>   
> +config WDT_ADI
> +	bool "Analog Devices watchdog timer support"
> +	select WDT
> +	select SPL_WDT if SPL
> +	depends on (SC57X || SC58X || SC59X || SC59X_64)
> +	help
> +	  Enable this to support Watchdog Timer on ADI SC57X, SC58X, SC59X,
> +	  and SC59X_64 processors
> +
>   config WDT_ARMADA_37XX
>   	bool "Marvell Armada 37xx watchdog timer support"
>   	depends on WDT && ARMADA_3700
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7b39adcf0f..7ad61b513c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -50,3 +50,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
>   obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
> +obj-$(CONFIG_WDT_ADI) += adi_wdt.o
> diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
> new file mode 100644
> index 0000000000..67d17dc692
> --- /dev/null
> +++ b/drivers/watchdog/adi_wdt.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * (C) Copyright 2022 - Analog Devices, Inc.
> + *
> + * Written and/or maintained by Timesys Corporation
> + *
> + * Converted to driver model by Nathan Barrett-Morrison
> + *
> + * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> + * Contact: Greg Malysa <greg.malysa@timesys.com>
> + *
> + * adi_wtd.c - driver for ADI on-chip watchdog
> + *
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <wdt.h>
> +#include <linux/delay.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +
> +#define WDOG_CTL  0x0
> +#define WDOG_CNT  0x4
> +#define WDOG_STAT 0x8
> +
> +#define RCU_CTL   0x0
> +#define RCU_STAT  0x4
> +
> +#define SEC_GCTL  0x0
> +#define SEC_FCTL  0x10
> +#define SEC_SCTL0 0x800
> +
> +#define WDEN      0x0010
> +#define WDDIS     0x0AD0
> +
> +struct adi_wdt_priv {
> +	void __iomem *rcu_base;
> +	void __iomem *sec_base;
> +	void __iomem *wdt_base;
> +	struct clk clock;
> +};
> +
> +static int adi_wdt_reset(struct udevice *dev)
> +{
> +	struct adi_wdt_priv *priv = dev_get_priv(dev);
> +
> +	writel(0, priv->wdt_base + WDOG_STAT);
> +
> +	return 0;
> +}
> +
> +static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct adi_wdt_priv *priv = dev_get_priv(dev);
> +	u32 sctl_val;
> +
> +	/* Disable SYSCD_RESETb input and clear the RCU0 reset status */
> +	writel(0xf, priv->rcu_base + RCU_STAT);
> +	writel(0x0, priv->rcu_base + RCU_CTL);
> +
> +	/* reset the SEC controller */
> +	writel(0x2, priv->sec_base + SEC_GCTL);
> +	writel(0x2, priv->sec_base + SEC_FCTL);
> +
> +	udelay(50);
> +
> +	/* enable SEC fault event */
> +	writel(0x1, priv->sec_base + SEC_GCTL);
> +
> +	/* ANOMALY 36100004 Spurious External Fault event occurs when FCTL
> +	 * is re-programmed when currently active fault is not cleared
> +	 */
> +	writel(0xc0, priv->sec_base + SEC_FCTL);
> +	writel(0xc1, priv->sec_base + SEC_FCTL);
> +
> +	/* enable SEC fault source for watchdog0 */
> +	sctl_val = readl((priv->sec_base + SEC_SCTL0) + 3 * 8) | 0x6;
> +	writel(sctl_val, (priv->sec_base + SEC_SCTL0) + 3 * 8);
> +
> +	/* Enable SYSCD_RESETb input */
> +	writel(0x100, priv->rcu_base + RCU_CTL);
> +
> +	/* enable watchdog0 */
> +	writel(WDDIS, priv->wdt_base + WDOG_CTL);
> +
> +	writel(timeout_ms / 1000 *
> +	       (clk_get_rate(&priv->clock) / (IS_ENABLED(CONFIG_SC58X) ? 2 : 1)),
> +	       priv->wdt_base + WDOG_CNT);
> +
> +	writel(0, priv->wdt_base + WDOG_STAT);
> +	writel(WDEN, priv->wdt_base + WDOG_CTL);
> +
> +	return 0;
> +}
> +
> +static int adi_wdt_probe(struct udevice *dev)
> +{
> +	struct adi_wdt_priv *priv = dev_get_priv(dev);
> +	int ret;
> +	struct resource res;
> +
> +	ret = dev_read_resource_byname(dev, "rcu", &res);
> +	if (ret)
> +		return ret;
> +	priv->rcu_base = devm_ioremap(dev, res.start, resource_size(&res));
> +
> +	ret = dev_read_resource_byname(dev, "sec", &res);
> +	if (ret)
> +		return ret;
> +	priv->sec_base = devm_ioremap(dev, res.start, resource_size(&res));
> +
> +	ret = dev_read_resource_byname(dev, "wdt", &res);
> +	if (ret)
> +		return ret;
> +	priv->wdt_base = devm_ioremap(dev, res.start, resource_size(&res));
> +
> +	ret = clk_get_by_name(dev, "sclk0", &priv->clock);
> +	if (ret < 0) {
> +		printf("Can't get WDT clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops adi_wdt_ops = {
> +	.start		= adi_wdt_start,
> +	.reset		= adi_wdt_reset,
> +};
> +
> +static const struct udevice_id adi_wdt_ids[] = {
> +	{ .compatible = "adi,wdt" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(adi_wdt) = {
> +	.name		= "adi_wdt",
> +	.id		= UCLASS_WDT,
> +	.of_match	= adi_wdt_ids,
> +	.probe		= adi_wdt_probe,
> +	.ops		= &adi_wdt_ops,
> +	.priv_auto = sizeof(struct adi_wdt_priv),
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
