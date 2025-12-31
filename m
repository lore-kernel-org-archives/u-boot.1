Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E5EE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCCA8416E;
	Wed, 31 Dec 2025 18:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fz3FbqOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B0D840C1; Wed, 31 Dec 2025 17:18:29 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F27683F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so10945155b3a.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767197905; x=1767802705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8bC19RDzGWCHIUh/azYSRnRxJ1sIIVWzLphLFNaVABo=;
 b=fz3FbqOtuMd/tzDtzpepKbK+PP4HxU6VnwjvZ0ANlt+uoMjQ4D6wimOpIVFlrXNMn5
 who1So3vX3i4+doObjhjp6C33sM/VDj7kQebD16BYobHjFMEu4Ca5FnsDLiZnObXqIsV
 25jo7SJSI2AsDuvdGoCAOTyWTWY0iHnv4nis8Zsb1q283C+P13+h3MLZzyBvnaogKdG1
 5Xg9zzuw4EF4NqI546xwwmulh2sDQ3W27yJ4myB1ES8FGQzKDXn9HgZwkgIj4xjZQKGx
 C1L0kEKgSFAmu3odU6JmEi/ofC9HY+ngZeO3WR2lMi7XtUqb6mtNPpwwTiclUfxtDrjY
 kMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767197905; x=1767802705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bC19RDzGWCHIUh/azYSRnRxJ1sIIVWzLphLFNaVABo=;
 b=Mqw7C73zBs9tNVT9QOKd+l4hck7zv5rqzvyOhoNPZNbb3ZqeEKIkNF+PsRmBU4h69S
 NpVTLBiLjasMcDV4nKnhYVLKj+YwwbLdknlrQIN5ZNnC9FUVze/sxVzDO3HNy6rHNRnc
 10u9Dy9fuWxQe4RjfAk2gMyu016piOibuXjNjqiq+/X0uPeJtGKVE5NgiBOqRSJIylEU
 dngaYbMSETLfYf5qr4lgdBg/MQBtu58jtaXGyy0BV6R4HxNI6iy1+Qu7pMvpxf/EqTdf
 SzxZEuVkFL0VKlexke3MM98rnhdvGeN0zDYhTQ3HYG9BV1RQnIMzNZhfG7IPTZkEFcj/
 0wnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF3W04+tV61/DAN3aesflmXpETyqe9OE9Ls8slCgqy/7JJZz9UMv2HnDdMWR9hHvrGTIpTsNI=@lists.denx.de
X-Gm-Message-State: AOJu0YxZUHzV0jPwgDIMDfpp3S6Y2MueZK8/O1YNmIXxvq/7v7r9kFQL
 3OX+t05lC82uCgRbd+9+22l+xy1gMat2LuagIrc/HqbCNLptSd8WnJNA
X-Gm-Gg: AY/fxX7ENkSiuZ6WJB87zrZrdd39o/FfNr51nEvubGRiGUCZ+UsrV525bVFM3aM2BJm
 3M9IAozp2DNqfPjfFJrpOX5wYoa/0EWa7hJsIvR5K4qY9zWO/XsIAT37NZkN/LmFVxtIgow/SQ8
 TiKLNfVYZoGBTB5zMmeoslK7wtzCXP4wCDTa8arD4hBZ7ApIa1N07oG18HezphqwEhOCXnzy3SN
 BaJDuadswLmQY2+fRy4RDyS4ggjSgqc2VrXvxsKm/HnhsGLdNqgU7R3cS9qiFDdMo/bhdQgqpLt
 92S+7S8bgCm6a6RsinZUChJcuxG11Hyuw5+v1zVrxEPL0GRPxvi41Tn8XDW3pyZFM/awGfV3/CX
 uqjE8TYn9qvKu7mj3HzKp3eb2stfp1G41wXYKUCw0TqRsqKB9IHMAognlaNAwmSsnn6nCGHFYwx
 9i9eNfroGuK9K5kwwYnlnnkTjegf9Bmppw750=
X-Google-Smtp-Source: AGHT+IGXVoq1cL6eEiMK5fQGvwCFcTnq5iisttaMi2PbdjjzWu53NWIqcQLAfD6RJMS6qH+rwLbrHw==
X-Received: by 2002:a05:6a00:8ccc:b0:7ff:91bb:3939 with SMTP id
 d2e1a72fcca58-7ff91bb3a73mr23451124b3a.16.1767197905517; 
 Wed, 31 Dec 2025 08:18:25 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:671b:a2e7:4f81:f445])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b423b9asm36143590b3a.28.2025.12.31.08.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:18:25 -0800 (PST)
Date: Thu, 1 Jan 2026 00:18:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Subject: Re: [PATCH v3 1/6] serial: Add Goldfish TTY driver
Message-ID: <aVVMzVVRaOSQIyfS@google.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-2-visitorckw@gmail.com>
 <4138cb5f-590f-4e80-b88c-2c2dd8894c2e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4138cb5f-590f-4e80-b88c-2c2dd8894c2e@gmx.de>
X-Mailman-Approved-At: Wed, 31 Dec 2025 18:47:14 +0100
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

Hi Heinrich,

On Wed, Dec 31, 2025 at 01:25:10PM +0100, Heinrich Schuchardt wrote:
> On 12/30/25 17:01, Kuan-Wei Chiu wrote:
> > Add support for the Google Goldfish TTY serial device. This virtual
> > device is commonly used in QEMU virtual machines (such as the m68k
> > virt machine) and Android emulators.
> > 
> > The driver implements basic console output and input polling using the
> > Goldfish MMIO interface.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v3:
> > - Remove unnecessary type casts for MMIO register access.
> > 
> >   MAINTAINERS                      |   6 ++
> >   drivers/serial/Kconfig           |   8 +++
> >   drivers/serial/Makefile          |   1 +
> >   drivers/serial/serial_goldfish.c | 102 +++++++++++++++++++++++++++++++
> >   include/goldfish_tty.h           |  18 ++++++
> >   5 files changed, 135 insertions(+)
> >   create mode 100644 drivers/serial/serial_goldfish.c
> >   create mode 100644 include/goldfish_tty.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6ce0bbce13d..da4a6e4d518 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1259,6 +1259,12 @@ S:	Maintained
> >   F:	drivers/misc/gsc.c
> >   F:	include/gsc.h
> > +GOLDFISH SERIAL DRIVER
> > +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> > +S:	Maintained
> > +F:	drivers/serial/serial_goldfish.c
> > +F:	include/goldfish_tty.h
> > +
> >   I2C
> >   M:	Heiko Schocher <hs@nabladev.com>
> >   S:	Maintained
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> > index 371d7aa5bba..b84cb9ec781 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -1193,4 +1193,12 @@ config SYS_SDMR
> >   	depends on MPC8XX_CONS
> >   	default 0x0
> > +config SERIAL_GOLDFISH
> > +	bool "Goldfish TTY support"
> > +	depends on DM_SERIAL
> > +	help
> > +	  Select this to enable support for the Goldfish TTY serial port.
> > +	  This virtual device is commonly used by QEMU virtual machines
> > +	  (e.g. m68k virt) for console output.
> > +
> >   endif
> > diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> > index 8eaae62b0fc..fe8d23be512 100644
> > --- a/drivers/serial/Makefile
> > +++ b/drivers/serial/Makefile
> > @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
> >   obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
> >   obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
> > +obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
> > diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> > new file mode 100644
> > index 00000000000..1d2977d809d
> > --- /dev/null
> > +++ b/drivers/serial/serial_goldfish.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + * Goldfish TTY driver for U-Boot
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <dm.h>
> > +#include <goldfish_tty.h>
> > +#include <linux/types.h>
> > +#include <serial.h>
> > +
> > +/* Goldfish TTY Register Offsets */
> > +#define GOLDFISH_TTY_PUT_CHAR       0x00
> > +#define GOLDFISH_TTY_BYTES_READY    0x04
> > +#define GOLDFISH_TTY_CMD            0x08
> > +#define GOLDFISH_TTY_DATA_PTR       0x10
> > +#define GOLDFISH_TTY_DATA_LEN       0x14
> > +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
> > +#define GOLDFISH_TTY_VERSION        0x20
> > +
> > +/* Commands */
> > +#define CMD_WRITE_BUFFER   2
> > +#define CMD_READ_BUFFER    3
> > +
> > +struct goldfish_tty_priv {
> > +	void __iomem *base;
> > +	u8 rx_buf;
> > +};
> > +
> > +static int goldfish_serial_getc(struct udevice *dev)
> > +{
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +	unsigned long paddr;
> > +	u32 count;
> > +
> > +	count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> > +	if (count == 0)
> > +		return -EAGAIN;
> > +
> > +	paddr = virt_to_phys((void *)&priv->rx_buf);
> > +
> > +	__raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
> > +	__raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
> > +	__raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
> > +	__raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
> > +
> > +	return priv->rx_buf;
> > +}
> > +
> > +static int goldfish_serial_putc(struct udevice *dev, const char ch)
> > +{
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +
> > +	__raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
> > +
> > +	return 0;
> > +}
> > +
> > +static int goldfish_serial_pending(struct udevice *dev, bool input)
> > +{
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +
> > +	if (input)
> > +		return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> > +
> > +	return 0;
> > +}
> > +
> > +static int goldfish_serial_probe(struct udevice *dev)
> > +{
> > +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +	struct goldfish_tty_plat *plat = dev_get_plat(dev);
> > +
> > +	if (!plat)
> > +		return -EINVAL;
> > +
> > +	priv->base = plat->base;
> 
> The Linux binding documentation in
> Documentation/devicetree/bindings/goldfish/tty.txt has this example:
> 
>         goldfish_tty@1f004000 {
>                 compatible = "google,goldfish-tty";
>                 reg = <0x1f004000 0x1000>;
>                 interrupts = <0xc>;
>         };
> 
> The driver should take the reg value as address and use plat->base only as
> fallback for devices that don't provide a proper device-tree.
> 
> We already do this for the RTC driver. Please, apply the same logic to all
> Goldfish drivers.

Agreed.
Will do this for both tty and timer drivers in the next version.

Regards,
Kuan-Wei
