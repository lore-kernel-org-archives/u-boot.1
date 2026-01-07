Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C78CD5854
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 11:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055F883A57;
	Wed,  7 Jan 2026 12:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="fywV4daI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D81183A57; Wed,  7 Jan 2026 12:05:39 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D50D83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 12:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1767783936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PezYwHZpKrbnAbw+45aohkqs3A3w/W/msByLmxO40k8=;
 b=fywV4daIggMBFWElloq+OSSg5/gXw4/KEJh1kqOKq7QYMTXhMllT26k7k5Ys5mvop8/6FO
 TQP8fxOb5vglzWSZqurpyURxz5mOb+TKbqXILzg4yIJVoHvfi4SMQhYThoCvhurOEAIBRz
 7JbjWN5shYqFDp2rXmEuGuiJaP9l/cM=
X-Spam: yes
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 5befaee2
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 7 Jan 2026 11:05:36 +0000 (UTC)
Message-ID: <5c27bf99-bcf2-400b-8228-cd40cc915358@kernel-space.org>
Date: Wed, 7 Jan 2026 12:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] timer: Add Goldfish timer driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-3-visitorckw@gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260105165221.1816070-3-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>

On 1/5/26 17:52, Kuan-Wei Chiu wrote:
> Add support for the Goldfish timer driver. This driver utilizes the
> Goldfish RTC hardware to provide a nanosecond-resolution timer. This
> virtual device is commonly found in QEMU virtual machines (such as the
> m68k virt machine) and Android emulators.
> 
> The driver implements the standard U-Boot timer UCLASS interface,
> exposing a 64-bit monotonically increasing counter with a 1GHz clock
> rate derived from the RTC registers.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
> 
>  MAINTAINERS                    |  6 +++
>  drivers/timer/Kconfig          |  8 ++++
>  drivers/timer/Makefile         |  1 +
>  drivers/timer/goldfish_timer.c | 81 ++++++++++++++++++++++++++++++++++
>  include/goldfish_timer.h       | 13 ++++++
>  5 files changed, 109 insertions(+)
>  create mode 100644 drivers/timer/goldfish_timer.c
>  create mode 100644 include/goldfish_timer.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f884ff495a..efecb213be7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1266,6 +1266,12 @@ S:	Maintained
>  F:	drivers/serial/serial_goldfish.c
>  F:	include/goldfish_tty.h
>  
> +GOLDFISH TIMER DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:	Maintained
> +F:	drivers/timer/goldfish_timer.c
> +F:	include/goldfish_timer.h
> +
>  INTERCONNECT:
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  S:	Maintained
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index f9511503b02..a84a0dc0539 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -340,4 +340,12 @@ config STARFIVE_TIMER
>  	  Select this to enable support for the timer found on
>  	  Starfive SoC.
>  
> +config GOLDFISH_TIMER
> +	bool "Goldfish Timer support"
> +	depends on TIMER
> +	help
> +	  Select this to enable support for the Goldfish Timer.
> +	  It uses the Goldfish RTC hardware to provide a nanosecond-resolution
> +	  timer, commonly found in QEMU virt machines.
> +
>  endmenu
> diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
> index a72e411fb2f..d8b3f2b65d4 100644
> --- a/drivers/timer/Makefile
> +++ b/drivers/timer/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_MCHP_PIT64B_TIMER)	+= mchp-pit64b-timer.o
>  obj-$(CONFIG_IMX_GPT_TIMER)	+= imx-gpt-timer.o
>  obj-$(CONFIG_XILINX_TIMER)	+= xilinx-timer.o
>  obj-$(CONFIG_STARFIVE_TIMER)	+= starfive-timer.o
> +obj-$(CONFIG_GOLDFISH_TIMER)	+= goldfish_timer.o
> diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
> new file mode 100644
> index 00000000000..63946b9ed97
> --- /dev/null
> +++ b/drivers/timer/goldfish_timer.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * Goldfish Timer driver
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <goldfish_timer.h>
> +#include <linux/errno.h>
> +#include <mapmem.h>
> +#include <timer.h>
> +
> +struct goldfish_timer_priv {
> +	void __iomem *base;
> +};
> +
> +/* Goldfish RTC registers used as Timer */
> +#define TIMER_TIME_LOW	0x00
> +#define TIMER_TIME_HIGH	0x04
> +
> +static u64 goldfish_timer_get_count(struct udevice *dev)
> +{
> +	struct goldfish_timer_priv *priv = dev_get_priv(dev);
> +	u32 low, high;
> +	u64 time;
> +
> +	/*
> +	 * TIMER_TIME_HIGH is only updated when TIMER_TIME_LOW is read.
> +	 * We must read LOW before HIGH to latch the high 32-bit value
> +	 * and ensure a consistent 64-bit timestamp.
> +	 */
> +	low = readl(priv->base + TIMER_TIME_LOW);
> +	high = readl(priv->base + TIMER_TIME_HIGH);
> +
> +	time = ((u64)high << 32) | low;
> +
> +	return time;
> +}
> +
> +static int goldfish_timer_probe(struct udevice *dev)
> +{
> +	struct goldfish_timer_priv *priv = dev_get_priv(dev);
> +	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct goldfish_timer_plat *plat;
> +	fdt_addr_t addr;
> +
> +	addr = dev_read_addr(dev);
> +	if (addr != FDT_ADDR_T_NONE) {
> +		priv->base = map_sysmem(addr, 0x20);
> +	} else {
> +		plat = dev_get_plat(dev);
> +		if (!plat)
> +			return -EINVAL;
> +		priv->base = plat->base;
> +	}
> +
> +	/* Goldfish RTC counts in nanoseconds, so the rate is 1GHz */
> +	uc_priv->clock_rate = 1000000000;
> +
> +	return 0;
> +}
> +
> +static const struct timer_ops goldfish_timer_ops = {
> +	.get_count = goldfish_timer_get_count,
> +};
> +
> +static const struct udevice_id goldfish_timer_ids[] = {
> +	{ .compatible = "google,goldfish-rtc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(goldfish_timer) = {
> +	.name	= "goldfish_timer",
> +	.id	= UCLASS_TIMER,
> +	.of_match = goldfish_timer_ids,
> +	.ops	= &goldfish_timer_ops,
> +	.probe	= goldfish_timer_probe,
> +	.priv_auto = sizeof(struct goldfish_timer_priv),
> +};
> diff --git a/include/goldfish_timer.h b/include/goldfish_timer.h
> new file mode 100644
> index 00000000000..2ea28170759
> --- /dev/null
> +++ b/include/goldfish_timer.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _GOLDFISH_TIMER_H_
> +#define _GOLDFISH_TIMER_H_
> +
> +struct goldfish_timer_plat {
> +	void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_TIMER_H_ */

-- Angelo

