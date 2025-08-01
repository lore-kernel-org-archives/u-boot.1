Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9261C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 08:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42587839E8;
	Fri,  1 Aug 2025 10:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="R497KV0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B03839EC; Fri,  1 Aug 2025 10:52:05 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD448398C
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 10:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 463C722C3A;
 Fri,  1 Aug 2025 10:52:03 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VORK39iusLiQ; Fri,  1 Aug 2025 10:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754038319; bh=Sgavba8LVh7Z6yPTkGRaMSE6T4kU7eM7P8uLgIiTOcA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R497KV0Zi2jYvHo+fsDOFO1+isBFWN5ZDKTUTP05q93wkptUa8o8vz7jRUmDoFwcF
 4IC3wZVmcoNgtNNGo/yJSf1U4lloB87JKG0NyruqamYCZH6ymGX8W7hka7HHf9J1Ny
 y/vutOxydTj97qeG++38iM0NP3nOyWMaaG6iqCDW95TKdHRlwytN3fOQdobk1DFVrA
 prUz4jVala7ifyOQdo7T8Ov2cEvekj2/v1quaBLQ2qQMfW4nttlKos1PaHek2/rYg9
 S45k4svDxZI95hp+zDCJA2ENMsaL5YbyNGbdpoidSpDphfrYjh5lA9VuDtnptKXxSF
 PrnvZnZfybElA==
Date: Fri, 1 Aug 2025 08:51:53 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v3 03/12] gpio: Add GPIO driver for Intel EG20T
Message-ID: <aIyAKbszXgeCfAjv@pie>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-4-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729162035.209849-4-uros.stajic@htecgroup.com>
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

On Tue, Jul 29, 2025 at 04:22:43PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add a GPIO driver for the Intel EG20T Platform Controller Hub, which
> exposes a set of 12 GPIOs via PCI MMIO.
> 
> The driver implements basic GPIO operations (input/output direction,
> value read/write, and function query) using the U-Boot driver model
> infrastructure. It maps the required BAR1 region via `dm_pci_map_bar`
> and uses internal registers to control pin state and direction.
> 
> This driver is required for platforms using EG20T, such as P8700-based
> systems, to access GPIOs through the standard U-Boot DM GPIO framework.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  board/mips/boston-riscv/MAINTAINERS |   1 +
>  drivers/gpio/Kconfig                |   7 ++
>  drivers/gpio/Makefile               |   1 +
>  drivers/gpio/eg20t-gpio.c           | 138 ++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 drivers/gpio/eg20t-gpio.c
> 
> diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/MAINTAINERS
> index e350121395e..bc59a628c79 100644
> --- a/board/mips/boston-riscv/MAINTAINERS
> +++ b/board/mips/boston-riscv/MAINTAINERS
> @@ -7,3 +7,4 @@ F:  arch/riscv/cpu/p8700/
>  F:  arch/riscv/include/asm/arch-p8700/
>  F:  configs/boston-p8700_defconfig
>  F:  arch/riscv/dts/boston-p8700.dts
> +F:  drivers/gpio/eg20t-gpio.c
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 58e464106a3..26040947a69 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -726,3 +726,10 @@ config MPFS_GPIO
>  		Enable to support the GPIO driver on Polarfire SoC
>  
>  endif
> +
> +config EG20T_GPIO
> +        bool "Intel EG20T GPIO driver"
> +        depends on DM_GPIO && DM_PCI
> +        help
> +          Enable this to support the GPIO controller found in the Intel EG20T
> +          Platform Controller Hub.
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 83e10c79b91..e44122cb9aa 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -81,3 +81,4 @@ obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
>  obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
>  obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
>  obj-$(CONFIG_MPFS_GPIO)	+= mpfs_gpio.o
> +obj-$(CONFIG_EG20T_GPIO)	+= eg20t-gpio.o
> diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
> new file mode 100644
> index 00000000000..d41ca4bfb17
> --- /dev/null
> +++ b/drivers/gpio/eg20t-gpio.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + */
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <pci.h>
> +#include <asm/io.h>
> +#include <asm/gpio.h>
> +#include <log.h>
> +
> +enum {
> +	REG_IEN		= 0x00,
> +	REG_ISTATUS	= 0x04,
> +	REG_IDISP	= 0x08,
> +	REG_ICLR	= 0x0c,
> +	REG_IMASK	= 0x10,
> +	REG_IMASKCLR	= 0x14,
> +	REG_PO		= 0x18,
> +	REG_PI		= 0x1c,
> +	REG_PM		= 0x20,
> +};
> +
> +struct eg20t_gpio_priv {
> +	void *base;
> +};
> +
> +static int eg20t_gpio_get_value(struct udevice *dev, unsigned int offset)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	u32 pm, pval;
> +
> +	pm = readl(priv->base + REG_PM);
> +	if ((pm >> offset) & 0x1)
> +		pval = readl(priv->base + REG_PO);
> +	else
> +		pval = readl(priv->base + REG_PI);
> +
> +	return (pval >> offset) & 0x1;
> +}
> +
> +static int eg20t_gpio_set_value(struct udevice *dev, unsigned int offset,
> +				int value)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	u32 po;
> +
> +	po = readl(priv->base + REG_PO);
> +	if (value)
> +		po |= 1 << offset;
> +	else
> +		po &= ~(1 << offset);
> +	writel(po, priv->base + REG_PO);
> +	return 0;
> +}

This file contains inconsistent usage of empty lines between statements
and the final return among functions. I think it's better to keep the
style aligned.

Regards,
Yao Zi

> +
> +static int eg20t_gpio_direction_input(struct udevice *dev, unsigned int offset)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	u32 pm;
> +
> +	pm = readl(priv->base + REG_PM);
> +	pm &= ~(1 << offset);
> +	writel(pm, priv->base + REG_PM);
> +	return 0;
> +}
> +
> +static int eg20t_gpio_direction_output(struct udevice *dev, unsigned int offset,
> +				       int value)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	u32 pm;
> +
> +	pm = readl(priv->base + REG_PM);
> +	pm |= 1 << offset;
> +	writel(pm, priv->base + REG_PM);
> +
> +	return eg20t_gpio_set_value(dev, offset, value);
> +}
> +
> +static int eg20t_gpio_get_function(struct udevice *dev, unsigned int offset)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	u32 pm;
> +
> +	pm = readl(priv->base + REG_PM);
> +
> +	if ((pm >> offset) & 0x1)
> +		return GPIOF_OUTPUT;
> +
> +	return GPIOF_INPUT;
> +}
> +
> +static const struct dm_gpio_ops eg20t_gpio_ops = {
> +	.direction_input	= eg20t_gpio_direction_input,
> +	.direction_output	= eg20t_gpio_direction_output,
> +	.get_value		= eg20t_gpio_get_value,
> +	.set_value		= eg20t_gpio_set_value,
> +	.get_function		= eg20t_gpio_get_function,
> +};
> +
> +static int eg20t_gpio_probe(struct udevice *dev)
> +{
> +	struct eg20t_gpio_priv *priv = dev_get_priv(dev);
> +	struct gpio_dev_priv *uc_priv = dev->uclass_priv;
> +
> +	priv->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, PCI_REGION_MEM);
> +	if (!priv->base) {
> +		debug("failed to map GPIO registers\n");
> +		return -EINVAL;
> +	}
> +
> +	uc_priv->gpio_count = 12;
> +	uc_priv->bank_name = "eg20t";
> +	return 0;
> +}
> +
> +static const struct udevice_id eg20t_gpio_ids[] = {
> +	{ .compatible = "intel,eg20t-gpio" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(eg20t_gpio) = {
> +	.name	= "eg20t-gpio",
> +	.id	= UCLASS_GPIO,
> +	.of_match = eg20t_gpio_ids,
> +	.probe	= eg20t_gpio_probe,
> +	.priv_auto_alloc_size = sizeof(struct eg20t_gpio_priv),
> +	.ops	= &eg20t_gpio_ops,
> +};
> +
> +static struct pci_device_id eg20t_gpio_supported[] = {
> +	{ PCI_VENDOR_ID_INTEL, 0x8803 },
> +	{ },
> +};
> +
> +U_BOOT_PCI_DEVICE(eg20t_gpio, eg20t_gpio_supported);
> -- 
> 2.34.1
