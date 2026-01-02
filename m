Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDF5EEB57A
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 08:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E02841CC;
	Fri,  2 Jan 2026 09:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RrrG35Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CBF841E6; Fri,  2 Jan 2026 09:29:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343FD83FB2
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 09:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01C743F3EE
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767342557;
 bh=GLn+P20fruOGI1HJW0W0NU/qOalTbBj1J6xk68EtCNg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RrrG35Litmp68MpjvnlWuqbGDHwRHMntaa2CCjxpy/4Vxo8UdvOFhQ2jH4yrqozZb
 YK/rxvoccvzOKMJD3ng9pVWrBU5OLQXnGXkmu8YIP+TqOXupo3j2fF7KpSUGyM1yoA
 jVGbrTQAVj0pd1obfhh6Ua5iJq0H7ASXU+imdroFzwbF29SLxbwufmCTSDat+8EHnG
 58AnLfAMqJa8LNr4ZL2Ab7/Qotq2DV6xNDjd89by6UiQdYZzUzWz6+0ME60UWhPwtS
 xFPAtzfDrzv20lzK9mdBOgQIrRZWf3fkKdrWpYY94iNB5Euq3OAcuDqNq3+5securZ
 CIZMjsFHJI4ImRDvr0TCO2GicIglEhkIFtE6XJMvWL9gMK7VzWUZQVamT8uC8cFH6v
 7D2+Oiw9s028JAcIiej/0p25P/nU1LXfNLkoCdpDEzjuN6O6DmKXrwLVsJw+rQ4Srw
 6oCtdhpl48thAabcFYScao08OPgRCl7+vx6XPD1VfOeeSL8NuhqBmoyjZOCsgn9nCD
 QYiZ99L2ZdNh6iujnJ37YZ5vD7Ct9JwfGUXYoDaokLqcqfcHsFSSZaHAEzdmuOCdH3
 +G6qiO6DWfyJQwMJKeNQE+u5/8y4m5W3JXu8Txzvl8j9YSUD+np7GbhSWVMngShjNX
 YcKgjIONB3pqrgFvGkYHfn5I=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso7147269f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 00:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767342556; x=1767947356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLn+P20fruOGI1HJW0W0NU/qOalTbBj1J6xk68EtCNg=;
 b=BI5w7UglgBejmMFKLjVVIvvoZNDFrDPuUuPXXgSxeMBxUWx2wzCtQELtoXToT7a/Nr
 Z1YaVAZfsOiaTUS1cfok1juWV9TfYk5sMFJM80WkKf1LFuoltLql6JhO98MlLtM+2f3G
 xRJ+2mfxFUw7OX7hfwA+lCkfNJ81hCRGFNfv7KD2jfPeUssM15kvbJyshZny5DAQrA8o
 3HkAdFZEYlLNe5EaWqZNV5QV5a6UP9ORmRaOob5NIt1rzxinPhkQxmCXZKkxCl7s+Qpn
 pFsLWnswDwxG510BEU5PXNgOonWMuwi/gLVsaGvcPmeG91vlEekn6SXZ97HdPn9oc/cC
 XD4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4R9awKy7WjIF9B4fRAtj45yHR2Bd/t1dl4HcXbZushPJGxJYW4NcLcOL9duYMoeNAA0ltn2o=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ7T8X3cYrApawnW3m1hwRp85y3gZQIF9mVY3u0NmT1AAYZDVW
 i3Q3BA2yTo5w9y3B+mialD8gscRofhT7n/hfFSTcjOx80hYXfDGu50SOlx/69LnZATWubb+GU3+
 MTkxF/0UNzhrujdno79nSDArcKtKpo9Z5MGyIj4UO7/46njZE9hSUADHgNen4w0+2e7++aD0=
X-Gm-Gg: AY/fxX5CmvKOWX++tRDpDanodcx1Avl2PpynbCHMhWWtxdsNFrK7B5iZpJ7RD/ACY1l
 c2hZcAvrGc3VjPuQerdkPcrvTOJQiHoWZuULTQi0dcHZqNsV08SqAWJ+z7eD4Tat3cB3p36va2z
 95R7zz8OHzwL6/pPyobo7xwn4bV3ixpM3wZir3kiQ/An+ctkX2Ouu9EyhZl03hAHzkcRwR6X24A
 6LB5qgXQlZhX2FP2bADfCzCYJUacjyyP9fcVgy/2095MuU0FV3FWaN7lUJl+rt3FiqvbQu5qhW1
 Wttz2aHxBt1D5LrqyPk73cdErEz4jsGX356p8UbXho94X3RgxmKQymj3BB7W0tp13QRFhYOgtro
 wopXLs06vIwphT9K0HthnNpteECjmazRBvbDpVEiHjN0ugEk/TrrGO8sxrnnUEzQhOTIfZPk8Zv
 +/Mcvda9Q=
X-Received: by 2002:a05:600c:6610:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47d18bd56b8mr474666315e9.12.1767342556572; 
 Fri, 02 Jan 2026 00:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxumRj8IiaZ2E0QvIxKHy55dHTpwSypHkyFGh8nh0BKbAhBj5878cHw3dJf+GzwKmpAZiETw==
X-Received: by 2002:a05:600c:6610:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47d18bd56b8mr474666065e9.12.1767342556129; 
 Fri, 02 Jan 2026 00:29:16 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb5bsm321576365e9.1.2026.01.02.00.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 00:29:15 -0800 (PST)
Message-ID: <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
Date: Fri, 2 Jan 2026 09:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260101175420.4118024-2-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/1/26 18:54, Kuan-Wei Chiu wrote:
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

Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Changes in v4:
> - Support DT probing with platform data as a fallback.
> 
>   MAINTAINERS                      |   6 ++
>   drivers/serial/Kconfig           |   8 +++
>   drivers/serial/Makefile          |   1 +
>   drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
>   include/goldfish_tty.h           |  18 +++++
>   5 files changed, 142 insertions(+)
>   create mode 100644 drivers/serial/serial_goldfish.c
>   create mode 100644 include/goldfish_tty.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ce0bbce13d..da4a6e4d518 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1259,6 +1259,12 @@ S:	Maintained
>   F:	drivers/misc/gsc.c
>   F:	include/gsc.h
>   
> +GOLDFISH SERIAL DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:	Maintained
> +F:	drivers/serial/serial_goldfish.c
> +F:	include/goldfish_tty.h
> +
>   I2C
>   M:	Heiko Schocher <hs@nabladev.com>
>   S:	Maintained
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 371d7aa5bba..b84cb9ec781 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1193,4 +1193,12 @@ config SYS_SDMR
>   	depends on MPC8XX_CONS
>   	default 0x0
>   
> +config SERIAL_GOLDFISH
> +	bool "Goldfish TTY support"
> +	depends on DM_SERIAL
> +	help
> +	  Select this to enable support for the Goldfish TTY serial port.
> +	  This virtual device is commonly used by QEMU virtual machines
> +	  (e.g. m68k virt) for console output.
> +
>   endif
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 8eaae62b0fc..fe8d23be512 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
>   obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
>   
>   obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
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

