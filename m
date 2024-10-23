Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2711CF5365
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 12:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2CF891E9;
	Wed, 23 Oct 2024 14:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729686349;
	bh=tWkY7an2d/JIxP6hpwyCkJ4tyaprMBnjj/6h2SwrWyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NrMLJvjRnpoP766O9YGugZs3a0S/k3TgV/S4rCy7wU7jJefBTPh/7CVcwHFNDcRZF
	 srEKYxIraZfQMIvSJCjgM9KQxnXHXlOLto+iCeeU7LUxF4O38I9aTpnKS7HK/BSVKc
	 8hfIGiJjnRzJb/T/8gVMWbZW7P29a3uOrENQnnUKAoIsXcsyY3WtcVIiy17hDtcOVZ
	 vXyo2agqlRBJad+wq+4+65/ueKHmC3cv59esaFTJdcdJgsZ78KaHXTLGmzNDlwoUY6
	 +NCCQ9srOZmc6nv/ovGk6LBoJ5a6SmdRVxM2BerZ40hhIRNDE1dbvRlOuaGLTGhsat
	 7LOrOIFxTjKbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8A489271; Wed, 23 Oct 2024 14:25:48 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6099588DB7
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 14:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYSts04gpz9slj;
 Wed, 23 Oct 2024 14:25:41 +0200 (CEST)
Message-ID: <a4d8bc03-f3fe-4b86-8f69-856477fda5c7@denx.de>
Date: Wed, 23 Oct 2024 14:25:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: davinci: add support for DaVinci DM644x/DM646x
 processors
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: u-boot@lists.denx.de, Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20241023113926.3223138-1-marcus.folkesson@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241023113926.3223138-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marcus,

On 10/23/24 13:39, Marcus Folkesson wrote:
> Watchdog driver for DaVinci DM644x/DM646x processors.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   MAINTAINERS                    |   5 ++
>   drivers/watchdog/Kconfig       |   9 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/davinci_wdt.c | 151 +++++++++++++++++++++++++++++++++
>   4 files changed, 166 insertions(+)
>   create mode 100644 drivers/watchdog/davinci_wdt.c

I've just now sent a pull request for a new WDT driver from Bastien
(added to Cc) for DaVinci, which I received a few weeks ago:

https://patchwork.ozlabs.org/project/uboot/patch/20241003084255.33478-1-bastien.curutchet@bootlin.com/

Could you please take a look at this driver, if this matches yours?
If there are problems with this driver, then I suggest to solve them
via follow-up patches.

Thanks,
Stefan

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dcce886b8..53aac8a0c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -854,6 +854,11 @@ F:	cmd/cyclic.c
>   F:	common/cyclic.c
>   F:	include/cyclic.h
>   
> +DAVINCI WATCHDOG
> +M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> +S:	Maintained
> +F:	drivers/watchdog/davinci_wdt.c
> +
>   DFU
>   M:	Lukasz Majewski <lukma@denx.de>
>   S:	Maintained
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b5ac8f7f50..e38acb0fe2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -161,6 +161,15 @@ config WDT_CORTINA
>   	  This driver support all CPU ISAs supported by Cortina
>   	  Access CAxxxx SoCs.
>   
> +config WDT_DAVINCI
> +	tristate "DaVinci watchdog timer support"
> +	depends on WDT
> +	depends on ARCH_DAVINCI || ARCH_KEYSTONE
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog timer in the DaVinci DM644x/DM646x
> +	  or Keystone processors.
> +
>   config WDT_GPIO
>   	bool "External gpio watchdog support"
>   	depends on WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 446d961d7d..ab454924c3 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
>   obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
>   obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
> +obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
>   obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
>   obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> new file mode 100644
> index 0000000000..e822621fd3
> --- /dev/null
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Watchdog driver for DaVinci DM644x/DM646x processors
> + *
> + * Copyright 2024 Marcus Folkesson <marcus.folkesson@gmail.com>
> + */
> +
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <common.h>
> +#include <clk.h>
> +#include <dm/device.h>
> +#include <dm/fdtaddr.h>
> +#include <dm/read.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <log.h>
> +#include <watchdog.h>
> +#include <wdt.h>
> +
> +/* Timer register set definition */
> +#define PID12	(0x0)
> +#define EMUMGT	(0x4)
> +#define TIM12	(0x10)
> +#define TIM34	(0x14)
> +#define PRD12	(0x18)
> +#define PRD34	(0x1C)
> +#define TCR	(0x20)
> +#define TGCR	(0x24)
> +#define WDTCR	(0x28)
> +
> +/* TCR bit definitions */
> +#define ENAMODE12		GENMASK(7, 6)
> +#define ENAMODE12_DISABLED	(0)
> +#define ENAMODE12_ONESHOT	(1)
> +#define ENAMODE12_PERIODIC	(2)
> +
> +/* TGCR bit definitions */
> +#define TIM12RS_UNRESET		BIT(0)
> +#define TIM34RS_UNRESET		BIT(1)
> +#define TIMMODE			GENMASK(3, 2)
> +#define TIMMODE_64BIT_WDOG      (2)
> +
> +/* WDTCR bit definitions */
> +#define WDEN			BIT(14)
> +#define WDFLAG			BIT(15)
> +#define WDKEY_SEQ0		(0xa5c6 << 16)
> +#define WDKEY_SEQ1		(0xda7e << 16)
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +struct davinci_wdt_priv {
> +	void __iomem *reg;
> +	unsigned long clk_rate;
> +};
> +
> +static int davinci_wdt_reset(struct udevice *dev)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +
> +	/* put watchdog in service state */
> +	writel(WDKEY_SEQ0 | WDEN, priv->reg + WDTCR);
> +	/* put watchdog in active state */
> +	writel(WDKEY_SEQ1 | WDEN, priv->reg + WDTCR);
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +{
> +	u32 tgcr;
> +	u32 timer_margin;
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +
> +	/* disable, internal clock source */
> +	writel(0, priv->reg + TCR);
> +
> +	/* reset timer, set mode to 64-bit watchdog, and unreset */
> +	writel(0, priv->reg + TGCR);
> +	tgcr = FIELD_PREP(TIMMODE, TIMMODE_64BIT_WDOG) | TIM12RS_UNRESET | TIM34RS_UNRESET;
> +	writel(tgcr, priv->reg + TGCR);
> +
> +	/* clear counter regs */
> +	writel(0, priv->reg + TIM12);
> +	writel(0, priv->reg + TIM34);
> +
> +	/* set timeout period */
> +	timeout = timeout / 1000;
> +	timer_margin = (((u64)timeout * priv->clk_rate) & 0xffffffff);
> +	writel(timer_margin, priv->reg + PRD12);
> +	timer_margin = (((u64)timeout * priv->clk_rate) >> 32);
> +	writel(timer_margin, priv->reg + PRD34);
> +
> +	/* enable run continuously */
> +	writel(FIELD_PREP(ENAMODE12, ENAMODE12_PERIODIC), priv->reg + TCR);
> +
> +	return davinci_wdt_reset(dev);
> +}
> +
> +static int davinci_wdt_expire_now(struct udevice *dev, ulong flags)
> +{
> +	davinci_wdt_start(dev, 0, flags);
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_probe(struct udevice *dev)
> +{
> +	debug("%s: Probing wdt%u (davinci-wdt)\n", __func__, dev_seq(dev));
> +
> +	return 0;
> +}
> +
> +static int davinci_wdt_of_to_plat(struct udevice *dev)
> +{
> +	struct davinci_wdt_priv *priv = dev_get_priv(dev);
> +	struct clk clk;
> +
> +	priv->reg = (void __iomem *)dev_read_addr(dev);
> +	if (IS_ERR(priv->reg))
> +		return PTR_ERR(priv->reg);
> +
> +	if (!clk_get_by_index(dev, 0, &clk))
> +		priv->clk_rate = clk_get_rate(&clk);
> +	else
> +		priv->clk_rate = 24000000;
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops davinci_wdt_ops = {
> +	.start = davinci_wdt_start,
> +	.reset = davinci_wdt_reset,
> +	.expire_now = davinci_wdt_expire_now,
> +};
> +
> +static const struct udevice_id davinci_wdt_ids[] = {
> +	{ .compatible = "ti,davinci-wdt" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(davinci_wdt) = {
> +	.name = "davinci_wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = davinci_wdt_ids,
> +	.probe = davinci_wdt_probe,
> +	.priv_auto	= sizeof(struct davinci_wdt_priv),
> +	.of_to_plat = davinci_wdt_of_to_plat,
> +	.ops = &davinci_wdt_ops,
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
