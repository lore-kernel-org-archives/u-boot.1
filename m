Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D48BCD583B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 10:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1585E83A26;
	Wed,  7 Jan 2026 11:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="VEIJTze5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B94A83A57; Wed,  7 Jan 2026 11:58:04 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD8D839B1
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 11:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1767783479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iR5k+PTRXAk9c4kk0UdrrpTfWR48c027JgKJkalP7NM=;
 b=VEIJTze53dbowxZqdecg239t+GcB8TqN9czYw6ZYCQpSsUeWLGwS+UHaG/Be414w/XxKls
 g9kdBJwl+CJXTgvier5Wip7+KrxUZSCRz8kgrR22nBeVkVRxlSNEwccKzl3gSk1j5znlWW
 pB7vnt6bVnQzgmmGWdvqrqyZwAm3jKM=
X-Spam: yes
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id a110d440
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 7 Jan 2026 10:57:59 +0000 (UTC)
Message-ID: <3e7f4385-15f4-4ea6-9641-c8e04d043c0b@kernel-space.org>
Date: Wed, 7 Jan 2026 11:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] serial: Add Goldfish TTY driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-2-visitorckw@gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260105165221.1816070-2-visitorckw@gmail.com>
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

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 1/5/26 17:52, Kuan-Wei Chiu wrote:
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
> 
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
> 
>  MAINTAINERS                      |   6 ++
>  drivers/serial/Kconfig           |   8 +++
>  drivers/serial/Makefile          |   1 +
>  drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
>  include/goldfish_tty.h           |  18 +++++
>  5 files changed, 142 insertions(+)
>  create mode 100644 drivers/serial/serial_goldfish.c
>  create mode 100644 include/goldfish_tty.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ce73d83f4..8f884ff495a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1260,6 +1260,12 @@ S:	Maintained
>  F:	drivers/misc/gsc.c
>  F:	include/gsc.h
>  
> +GOLDFISH SERIAL DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:	Maintained
> +F:	drivers/serial/serial_goldfish.c
> +F:	include/goldfish_tty.h
> +
>  INTERCONNECT:
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  S:	Maintained
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 371d7aa5bba..b84cb9ec781 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1193,4 +1193,12 @@ config SYS_SDMR
>  	depends on MPC8XX_CONS
>  	default 0x0
>  
> +config SERIAL_GOLDFISH
> +	bool "Goldfish TTY support"
> +	depends on DM_SERIAL
> +	help
> +	  Select this to enable support for the Goldfish TTY serial port.
> +	  This virtual device is commonly used by QEMU virtual machines
> +	  (e.g. m68k virt) for console output.
> +
>  endif
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 8eaae62b0fc..fe8d23be512 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
>  obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
>  
>  obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
> +obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> new file mode 100644
> index 00000000000..278d0cf3e0d
> --- /dev/null
> +++ b/drivers/serial/serial_goldfish.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + * Goldfish TTY driver for U-Boot
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <goldfish_tty.h>
> +#include <linux/types.h>
> +#include <mapmem.h>
> +#include <serial.h>
> +
> +/* Goldfish TTY Register Offsets */
> +#define GOLDFISH_TTY_PUT_CHAR       0x00
> +#define GOLDFISH_TTY_BYTES_READY    0x04
> +#define GOLDFISH_TTY_CMD            0x08
> +#define GOLDFISH_TTY_DATA_PTR       0x10
> +#define GOLDFISH_TTY_DATA_LEN       0x14
> +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
> +#define GOLDFISH_TTY_VERSION        0x20
> +
> +/* Commands */
> +#define CMD_WRITE_BUFFER   2
> +#define CMD_READ_BUFFER    3
> +
> +struct goldfish_tty_priv {
> +	void __iomem *base;
> +	u8 rx_buf;
> +};
> +
> +static int goldfish_serial_getc(struct udevice *dev)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	unsigned long paddr;
> +	u32 count;
> +
> +	count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +	if (count == 0)
> +		return -EAGAIN;
> +
> +	paddr = virt_to_phys((void *)&priv->rx_buf);
> +
> +	__raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
> +	__raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
> +	__raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
> +	__raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
> +
> +	return priv->rx_buf;
> +}
> +
> +static int goldfish_serial_putc(struct udevice *dev, const char ch)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +	__raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
> +
> +	return 0;
> +}
> +
> +static int goldfish_serial_pending(struct udevice *dev, bool input)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +	if (input)
> +		return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +
> +	return 0;
> +}
> +
> +static int goldfish_serial_probe(struct udevice *dev)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	struct goldfish_tty_plat *plat = dev_get_plat(dev);
> +	fdt_addr_t addr;
> +
> +	addr = dev_read_addr(dev);
> +	if (addr != FDT_ADDR_T_NONE) {
> +		priv->base = map_sysmem(addr, 0x1000);
> +	} else {
> +		plat = dev_get_plat(dev);
> +		if (!plat)
> +			return -EINVAL;
> +		priv->base = plat->base;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dm_serial_ops goldfish_serial_ops = {
> +	.putc = goldfish_serial_putc,
> +	.pending = goldfish_serial_pending,
> +	.getc = goldfish_serial_getc,
> +};
> +
> +static const struct udevice_id goldfish_serial_ids[] = {
> +	{ .compatible = "google,goldfish-tty" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(serial_goldfish) = {
> +	.name	= "serial_goldfish",
> +	.id	= UCLASS_SERIAL,
> +	.of_match = goldfish_serial_ids,
> +	.probe	= goldfish_serial_probe,
> +	.ops	= &goldfish_serial_ops,
> +	.priv_auto = sizeof(struct goldfish_tty_priv),
> +	.flags	= DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
> new file mode 100644
> index 00000000000..8777da4942d
> --- /dev/null
> +++ b/include/goldfish_tty.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _GOLDFISH_TTY_H_
> +#define _GOLDFISH_TTY_H_
> +
> +#include <linux/types.h>
> +
> +/* Platform data for the Goldfish TTY driver
> + * Used to pass hardware base address from Board to Driver
> + */
> +struct goldfish_tty_plat {
> +	void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_TTY_H_ */

-- Angelo

