Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D614C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 08:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533C2801FB;
	Thu, 27 Feb 2025 09:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740645865;
	bh=YymVVCxAZioGDwU+LJtnCeBMBkEvoreNhFOzOMNbQKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XyjlvN9f4VPf7kgSdcPDr1C5TgwTgLc0fro8AI+haVfbRptE19qbPkbttE3eSrDNW
	 S+nlzlnKiQUaKBYhISEA19ZKy8ktKgXPUCT1Voq2fKZbI0+kmoLw5OFPVxANZL5T5A
	 vaWW1iF+lJ3OnTs4GEFrr3VZQJU9q82OarBGYfwhIOu4PtY48uK6uxUVTycXojw285
	 9qKjv3gkOuPQXdwiHcJcyMyvLOiQX+6rFIndPRhLkcxNPLMzlObmzmJ3wqgXsaZ0Vf
	 Hmz5ul0YTAzkxsBaE58cR87stWlksqW95EKuQ6r41XUv4Lcf8ImtDrp6mtM3ToptS4
	 BCqnL2G8KPSuA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 057D480FE2; Thu, 27 Feb 2025 09:44:24 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7DD8003E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Z3Pyq0Dpyz9trP;
 Thu, 27 Feb 2025 09:44:19 +0100 (CET)
Message-ID: <c1bfbe3c-9d27-4290-a0de-4844734117ca@denx.de>
Date: Thu, 27 Feb 2025 09:44:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/12] watchdog: Add support for ADI SC5XX-family
 watchdog peripheral
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Devarsh Thakkar
 <devarsht@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
 <20250226173150.13198-9-malysagreg@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250226173150.13198-9-malysagreg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Z3Pyq0Dpyz9trP
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

On 26.02.25 18:30, Greg Malysa wrote:
> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> Co-developed-by: Greg Malysa <malysagreg@gmail.com>
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> ---
> 
> Changes in v3:
> - replace readl/writel with ioread32 and iowrite32 and friends

Reviewed-by: Stefan Roese <sr@denx.de>

BTW: I already added my RB tag on v1, please include it in later
versions, if not bigger changes occur.

Thanks,
Stefan

>   MAINTAINERS                |   1 +
>   drivers/watchdog/Kconfig   |   9 +++
>   drivers/watchdog/Makefile  |   1 +
>   drivers/watchdog/adi_wdt.c | 143 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 154 insertions(+)
>   create mode 100644 drivers/watchdog/adi_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c4dc8b14c1..0cefd888885 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -640,6 +640,7 @@ F:	drivers/pinctrl/pinctrl-adi-adsp.c
>   F:	drivers/serial/serial_adi_uart4.c
>   F:	drivers/timer/adi_sc5xx_timer.c
>   F:	drivers/usb/musb-new/sc5xx.c
> +F:	drivers/watchdog/adi_wdt.c
>   F:	include/configs/sc5*
>   F:	include/dt-bindings/pinctrl/adi-adsp.h
>   F:	include/env/adi/
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b39b2546e5c..1bb67f50352 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -95,6 +95,15 @@ config WDT_APPLE
>   	  The watchdog will perform a full SoC reset resulting in a
>   	  reboot of the entire system.
>   
> +config WDT_ADI
> +	bool "Analog Devices watchdog timer support"
> +	select WDT
> +	select SPL_WDT if SPL
> +	depends on ARCH_SC5XX
> +	help
> +	  Enable this to support Watchdog Timer on ADI SC57X, SC58X, SC59X,
> +	  and SC59X_64 processors
> +
>   config WDT_ARMADA_37XX
>   	bool "Marvell Armada 37xx watchdog timer support"
>   	depends on WDT && ARMADA_3700
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9b6b1a8e8ad..e6bd4c587af 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
>   obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
> +obj-$(CONFIG_WDT_ADI) += adi_wdt.o
> diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
> new file mode 100644
> index 00000000000..6f5b3d5d042
> --- /dev/null
> +++ b/drivers/watchdog/adi_wdt.c
> @@ -0,0 +1,143 @@
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
> +	iowrite32(0, priv->wdt_base + WDOG_STAT);
> +
> +	return 0;
> +}
> +
> +static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct adi_wdt_priv *priv = dev_get_priv(dev);
> +
> +	/* Disable SYSCD_RESETb input and clear the RCU0 reset status */
> +	iowrite32(0xf, priv->rcu_base + RCU_STAT);
> +	iowrite32(0x0, priv->rcu_base + RCU_CTL);
> +
> +	/* reset the SEC controller */
> +	iowrite32(0x2, priv->sec_base + SEC_GCTL);
> +	iowrite32(0x2, priv->sec_base + SEC_FCTL);
> +
> +	udelay(50);
> +
> +	/* enable SEC fault event */
> +	iowrite32(0x1, priv->sec_base + SEC_GCTL);
> +
> +	/* ANOMALY 36100004 Spurious External Fault event occurs when FCTL
> +	 * is re-programmed when currently active fault is not cleared
> +	 */
> +	iowrite32(0xc0, priv->sec_base + SEC_FCTL);
> +	iowrite32(0xc1, priv->sec_base + SEC_FCTL);
> +
> +	/* enable SEC fault source for watchdog0 */
> +	setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
> +
> +	/* Enable SYSCD_RESETb input */
> +	iowrite32(0x100, priv->rcu_base + RCU_CTL);
> +
> +	/* enable watchdog0 */
> +	iowrite32(WDDIS, priv->wdt_base + WDOG_CTL);
> +
> +	iowrite32(timeout_ms / 1000 *
> +	       (clk_get_rate(&priv->clock) / (IS_ENABLED(CONFIG_SC58X) ? 2 : 1)),
> +	       priv->wdt_base + WDOG_CNT);
> +
> +	iowrite32(0, priv->wdt_base + WDOG_STAT);
> +	iowrite32(WDEN, priv->wdt_base + WDOG_CTL);
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

