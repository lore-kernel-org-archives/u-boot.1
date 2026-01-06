Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5A3CEFCF8
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C79A83FBE;
	Tue,  6 Jan 2026 20:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RjXWID3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D15D83F98; Tue,  6 Jan 2026 20:25:58 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9D383D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 20:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso1269877b3a.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767727554; x=1768332354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GPfsFE0BqUDMXGwpQhxBqMHhP3lpLqutklCAYsNPlew=;
 b=RjXWID3wZfo50d4FHIMiTpdkSPbkeKIedvkbgU8HLf2fMe0/b861HMIi914mSU4fFI
 I/Od641Eti9xRJ83uNC7v+sarRopseCwzWtXlF/UAt990+vTux3UoSobYttVoMgg/TP2
 WvkF1AjIq6bUOkRPcPynGnYj79TIZo2G0KzlTg0o1u8ps/oBmjia/huRGduRwbHRj8Gs
 MKSXGRpgJZTKL3Pm8LdzSUhm3yka7cVst2Fg0s0ydpfPrKIKLO/Bpuc1Sibk+cZ3kLlO
 82MdBnY3oC18tlnOZrOjL/aBqFYN9bH4ajqDmX/PuPWc4WjVXXTIJnVgLL4A4QsvA3Rt
 23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767727554; x=1768332354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPfsFE0BqUDMXGwpQhxBqMHhP3lpLqutklCAYsNPlew=;
 b=KISzVu4syUBsqW/jGFaU59tR7Tep6CwELwSEzx8NTV7Ex/M9R+pHPaqHB2Pb/qDkAg
 UQdZ2vURCtynNrAJMfGo7/z3/a7D8LUP30DhmorMS7C+fR31B1WhtMLIOEQci/Cf4NnS
 AoReU1NxOMR4cPv3/lBlM/RNG+iO5ZjB6NkLlKEFWFvbFlxkpyoQ71mjX/FPQxP7R0fq
 TQ1bTR7Ncq7UXmrkbzcPT9PTQbBSmGFCGijv9SNG4pSEG1oTLJpRkjWNlAll3K7l32W/
 GXwQSJb5gGpwiQJLzs4uGgpD2RjLzfyJulDD17wrSTcn1nOt+738DUSwCgjT/T4ndhi1
 xNog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR5dmmSR7dLYDFSDp6qY/S+IGJiI62HTElJ1q/O9hhefQffOmSJK2MpNESdt17WvONSzBvHIo=@lists.denx.de
X-Gm-Message-State: AOJu0YxviUuRBUq4UXbWpMk5WoX4dr8pOb9mDfn1gTQy9mEaPxbMiB7U
 KdnuVll2AgpehkymBOCXPyiIGi0LD44vRL1Ur2HJXh78vBAdzMcjIlaP
X-Gm-Gg: AY/fxX4vtYebdc+VUY8b42H2MkcQFPr8JVl66TP13VBU4YI+8WRcpZElR3UunhDPtQn
 4xaoC+NV7T2Q6Cgv+OwXCq8XO6NJ7nQ9MOEdFEqaOoFth23A0Fbda9hMojYuHdrNfhI2vhacjK5
 PsWtW4ZeM1fUBED7vhQLBT/+BtwVGfkJBrPDJlxOUShj5MVql80Nq/grMyymfB/CL+D5VlhglBo
 Y73QGn+I4JLIqgX6fD322gW+Sy3aBQnLEfTSzpsNEqfjizE9h7oZUWNC7/JxIOmuvdj/FQGZ4t8
 nmfAAvYrc4JHVKujSPymygudF3o/xcMv82tXIdQM0w+DT7F9E6VSzB07/5d9ycG0ePidWwqrKEt
 iNtn+rcKg36nDP715Nw/Ws1qFqkepUBl0E6v/uOZSdYgeuU/XHTokQPelF0BPBt5ps/jdU0mr2n
 8HOTQDxWVYncpxT8ghGCY2XEZWI9ypPlpeY9Y=
X-Google-Smtp-Source: AGHT+IHHq164jUnVpacOKKsbGCkDc8EIXWUIei/BEK9xt/5zcszafAiZtxXg1RCxzl+rk59VIqM5pQ==
X-Received: by 2002:a05:6a00:3388:b0:7e8:43f5:bd0c with SMTP id
 d2e1a72fcca58-81b7f3f1fe1mr123487b3a.33.1767727553933; 
 Tue, 06 Jan 2026 11:25:53 -0800 (PST)
Received: from google.com ([2402:7500:577:2fcc:2b1c:b727:de22:5862])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c5edc3fesm2820463b3a.64.2026.01.06.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 11:25:53 -0800 (PST)
Date: Wed, 7 Jan 2026 03:25:50 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/7] serial: Add Goldfish TTY driver
Message-ID: <aV1hvqrtZ-lPlrNj@google.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-2-visitorckw@gmail.com>
 <CAFLszTg-nxHarYP8xGmGNxRwZTuRo7Pb7f1SHPn1C85p-Cbpxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg-nxHarYP8xGmGNxRwZTuRo7Pb7f1SHPn1C85p-Cbpxg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jan 2026 20:28:28 +0100
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

Hi Simon,

On Mon, Jan 05, 2026 at 04:30:28PM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On Mon, 5 Jan 2026 at 11:21, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add support for the Google Goldfish TTY serial device. This virtual
> > device is commonly used in QEMU virtual machines (such as the m68k
> > virt machine) and Android emulators.
> >
> > The driver implements basic console output and input polling using the
> > Goldfish MMIO interface.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Reviewed-by: Yao Zi <me@ziyao.cc>
> > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > Changes in v5:
> > - Rebase on u-boot/next branch.
> >
> >  MAINTAINERS                      |   6 ++
> >  drivers/serial/Kconfig           |   8 +++
> >  drivers/serial/Makefile          |   1 +
> >  drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
> >  include/goldfish_tty.h           |  18 +++++
> >  5 files changed, 142 insertions(+)
> >  create mode 100644 drivers/serial/serial_goldfish.c
> >  create mode 100644 include/goldfish_tty.h
> >
> 
> Reviewed-by: Simon Glass <simon.glass@canonical.com>

Thanks for your review!

> 
> One thought below.
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 27ce73d83f4..8f884ff495a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1260,6 +1260,12 @@ S:       Maintained
> >  F:     drivers/misc/gsc.c
> >  F:     include/gsc.h
> >
> > +GOLDFISH SERIAL DRIVER
> > +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> > +S:     Maintained
> > +F:     drivers/serial/serial_goldfish.c
> > +F:     include/goldfish_tty.h
> > +
> >  INTERCONNECT:
> >  M:     Neil Armstrong <neil.armstrong@linaro.org>
> >  S:     Maintained
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> > index 371d7aa5bba..b84cb9ec781 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -1193,4 +1193,12 @@ config SYS_SDMR
> >         depends on MPC8XX_CONS
> >         default 0x0
> >
> > +config SERIAL_GOLDFISH
> > +       bool "Goldfish TTY support"
> > +       depends on DM_SERIAL
> > +       help
> > +         Select this to enable support for the Goldfish TTY serial port.
> > +         This virtual device is commonly used by QEMU virtual machines
> > +         (e.g. m68k virt) for console output.
> > +
> >  endif
> > diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> > index 8eaae62b0fc..fe8d23be512 100644
> > --- a/drivers/serial/Makefile
> > +++ b/drivers/serial/Makefile
> > @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
> >  obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
> >
> >  obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
> > +obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
> > diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> > new file mode 100644
> > index 00000000000..278d0cf3e0d
> > --- /dev/null
> > +++ b/drivers/serial/serial_goldfish.c
> > @@ -0,0 +1,109 @@
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
> > +#include <mapmem.h>
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
> > +       void __iomem *base;
> > +       u8 rx_buf;
> > +};
> > +
> > +static int goldfish_serial_getc(struct udevice *dev)
> > +{
> > +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +       unsigned long paddr;
> > +       u32 count;
> > +
> > +       count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> > +       if (count == 0)
> > +               return -EAGAIN;
> > +
> > +       paddr = virt_to_phys((void *)&priv->rx_buf);
> > +
> > +       __raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
> > +       __raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
> > +       __raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
> > +       __raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
> > +
> > +       return priv->rx_buf;
> > +}
> > +
> > +static int goldfish_serial_putc(struct udevice *dev, const char ch)
> > +{
> > +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +
> > +       __raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
> > +
> > +       return 0;
> > +}
> > +
> > +static int goldfish_serial_pending(struct udevice *dev, bool input)
> > +{
> > +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +
> > +       if (input)
> > +               return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> > +
> > +       return 0;
> > +}
> > +
> > +static int goldfish_serial_probe(struct udevice *dev)
> > +{
> > +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> > +       struct goldfish_tty_plat *plat = dev_get_plat(dev);
> > +       fdt_addr_t addr;
> > +
> > +       addr = dev_read_addr(dev);
> > +       if (addr != FDT_ADDR_T_NONE) {
> > +               priv->base = map_sysmem(addr, 0x1000);
> > +       } else {
> > +               plat = dev_get_plat(dev);
> > +               if (!plat)
> > +                       return -EINVAL;
> > +               priv->base = plat->base;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> Strictly speaking, reading the devicetree should be done in the
> of_to_plat() method. So you would read the base address there.
> 
> Then probe() would convert that to a pointer (I suggest the same 'reg'
> for registers, but it isn't that important).

I will move the device tree reading to of_to_plat() and rename the
platform data member to reg (using phys_addr_t). The probe() function
will then handle the map_sysmem() conversion. I will also apply this
same pattern to the timer and rtc drivers.

Regards,
Kuan-Wei

> 
> > +
> > +static const struct dm_serial_ops goldfish_serial_ops = {
> > +       .putc = goldfish_serial_putc,
> > +       .pending = goldfish_serial_pending,
> > +       .getc = goldfish_serial_getc,
> > +};
> > +
> > +static const struct udevice_id goldfish_serial_ids[] = {
> > +       { .compatible = "google,goldfish-tty" },
> > +       { }
> > +};
> > +
> > +U_BOOT_DRIVER(serial_goldfish) = {
> > +       .name   = "serial_goldfish",
> > +       .id     = UCLASS_SERIAL,
> > +       .of_match = goldfish_serial_ids,
> > +       .probe  = goldfish_serial_probe,
> > +       .ops    = &goldfish_serial_ops,
> > +       .priv_auto = sizeof(struct goldfish_tty_priv),
> > +       .flags  = DM_FLAG_PRE_RELOC,
> > +};
> > diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
> > new file mode 100644
> > index 00000000000..8777da4942d
> > --- /dev/null
> > +++ b/include/goldfish_tty.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#ifndef _GOLDFISH_TTY_H_
> > +#define _GOLDFISH_TTY_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/* Platform data for the Goldfish TTY driver
> > + * Used to pass hardware base address from Board to Driver
> > + */
> > +struct goldfish_tty_plat {
> > +       void __iomem *base;
> > +};
> > +
> > +#endif /* _GOLDFISH_TTY_H_ */
> > --
> > 2.52.0.358.g0dd7633a29-goog
> >
> 
> Regards,
> Simon
