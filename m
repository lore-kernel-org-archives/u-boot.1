Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95386CD0422
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C1783A57;
	Tue,  6 Jan 2026 00:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IIWebsnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B66839F1; Tue,  6 Jan 2026 00:31:08 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BD6083A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b560e425eso551909a12.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655865; x=1768260665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z7AGoxjj6fFsShVIyjUgDADR7l97vvFEj7fA74yjsmI=;
 b=IIWebsnZZybQrtzRdeM69jSQHeTeSZwgyvD74njsaSkg6tJCNb+HNjnjzpUL5Uw1JW
 +YQL2DOnjeRNFpXY9Cuai5k5+fxjORAchRzDeFhSZNWvhTa7G7aqcmBbGkHawATEuAHP
 qAgD5v+O/cMFiWkLLnhEWD7p56i3vwcOa0uDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655865; x=1768260665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7AGoxjj6fFsShVIyjUgDADR7l97vvFEj7fA74yjsmI=;
 b=gKYXBudkPcT34bCR4891UH/OWcUlCQzo5rT5BF2ZVxoMriO5b05RT0f5w1R6A0kG8B
 NvT1agWuYDK88sdnKg4ye+aRU+RszdzapxZyT+H3lI0nmgMwe8ionG9+KyMd5778TgUx
 8mglLpu5vrvvB6ksW3dnFYv3/3UNFnDvcZdPz0zmfbk2rmsMtXVrS+9I7osN61EhGy45
 +LqS6mz48xCaTyaIriwJtnEEEN2hGpTj7LcflstzWwtvUMLZjiRk7gs9wNbyikb/OYp9
 LdXKdxBDbtxTg7dW/2G2MceCP9pQy9klzAzhMgv9mIGmrJMuUOFApesL7sdP4HRogJDV
 0FvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9UPVdNKIxNpOcBEVdXZnreV2ujvWI1BLAjgY3PKCaoUGAQvYYaho8Hd2jp8YCVwfQBqdiRkM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7g1SFc3jrvKZCfdr4iv088jniKyF5pDSsoux6G1uGnFUC+ay9
 Squeqe99ttJSUqOiCVcrAB97tI6m4jvG/M5FE4B2JMhpNBIp9nWAVwSlbCymaDxp0r1dXkFDdAn
 CJHo5fnN0kSCpjm3i7C1lfVuWilQ2gj/FVMPAmN/y
X-Gm-Gg: AY/fxX4xjG5iKpg7aMaAGWlFSdku9UlYXw3/ffz+VcZwEvwjLAM6O2DjPwXfaq7E84p
 85kKu7oXC6nQyGbgaARuoJjJWLreieckhna/Qn5q2/oE6datkaEYYAuSS9ADeQSry+bYafph+Fi
 LuMwfPcdbsjdmNlb7qT4xVTz9ik0G0TuFZslD6VZiQ2pAeIk70T+Xug6Ch0GfhyBRQdIXu0d/pA
 Ct9Bd8pXmf/tlSbVpyssc89ygPjpl8XZ3p5FQgNiCHVFv5DlXZhZEG2Jh7lQ1WmfRAF7Q==
X-Google-Smtp-Source: AGHT+IH+aSLF5+GOBritkr4Ho7o0tY8kvX5MosHXe3NUIJ+hBtC4zxnJL0l/fPx+HbA1Ov+j3SmJIe4kFleJM18kFqo=
X-Received: by 2002:a17:907:9415:b0:b84:1fc8:2fb3 with SMTP id
 a640c23a62f3a-b8426a55c62mr127915966b.4.1767655865486; Mon, 05 Jan 2026
 15:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-2-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-2-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:28 -0700
X-Gm-Features: AQt7F2rbTx_oW0DutkXmJktmREc-ukWluqCnAjeRdJR0yk_JnuaNNt21bhQBq6c
Message-ID: <CAFLszTg-nxHarYP8xGmGNxRwZTuRo7Pb7f1SHPn1C85p-Cbpxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] serial: Add Goldfish TTY driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On Mon, 5 Jan 2026 at 11:21, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
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

Reviewed-by: Simon Glass <simon.glass@canonical.com>

One thought below.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ce73d83f4..8f884ff495a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1260,6 +1260,12 @@ S:       Maintained
>  F:     drivers/misc/gsc.c
>  F:     include/gsc.h
>
> +GOLDFISH SERIAL DRIVER
> +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:     Maintained
> +F:     drivers/serial/serial_goldfish.c
> +F:     include/goldfish_tty.h
> +
>  INTERCONNECT:
>  M:     Neil Armstrong <neil.armstrong@linaro.org>
>  S:     Maintained
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 371d7aa5bba..b84cb9ec781 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1193,4 +1193,12 @@ config SYS_SDMR
>         depends on MPC8XX_CONS
>         default 0x0
>
> +config SERIAL_GOLDFISH
> +       bool "Goldfish TTY support"
> +       depends on DM_SERIAL
> +       help
> +         Select this to enable support for the Goldfish TTY serial port.
> +         This virtual device is commonly used by QEMU virtual machines
> +         (e.g. m68k virt) for console output.
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
> +       void __iomem *base;
> +       u8 rx_buf;
> +};
> +
> +static int goldfish_serial_getc(struct udevice *dev)
> +{
> +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +       unsigned long paddr;
> +       u32 count;
> +
> +       count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +       if (count == 0)
> +               return -EAGAIN;
> +
> +       paddr = virt_to_phys((void *)&priv->rx_buf);
> +
> +       __raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
> +       __raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
> +       __raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
> +       __raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
> +
> +       return priv->rx_buf;
> +}
> +
> +static int goldfish_serial_putc(struct udevice *dev, const char ch)
> +{
> +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +       __raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
> +
> +       return 0;
> +}
> +
> +static int goldfish_serial_pending(struct udevice *dev, bool input)
> +{
> +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +       if (input)
> +               return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +
> +       return 0;
> +}
> +
> +static int goldfish_serial_probe(struct udevice *dev)
> +{
> +       struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +       struct goldfish_tty_plat *plat = dev_get_plat(dev);
> +       fdt_addr_t addr;
> +
> +       addr = dev_read_addr(dev);
> +       if (addr != FDT_ADDR_T_NONE) {
> +               priv->base = map_sysmem(addr, 0x1000);
> +       } else {
> +               plat = dev_get_plat(dev);
> +               if (!plat)
> +                       return -EINVAL;
> +               priv->base = plat->base;
> +       }
> +
> +       return 0;
> +}

Strictly speaking, reading the devicetree should be done in the
of_to_plat() method. So you would read the base address there.

Then probe() would convert that to a pointer (I suggest the same 'reg'
for registers, but it isn't that important).

> +
> +static const struct dm_serial_ops goldfish_serial_ops = {
> +       .putc = goldfish_serial_putc,
> +       .pending = goldfish_serial_pending,
> +       .getc = goldfish_serial_getc,
> +};
> +
> +static const struct udevice_id goldfish_serial_ids[] = {
> +       { .compatible = "google,goldfish-tty" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(serial_goldfish) = {
> +       .name   = "serial_goldfish",
> +       .id     = UCLASS_SERIAL,
> +       .of_match = goldfish_serial_ids,
> +       .probe  = goldfish_serial_probe,
> +       .ops    = &goldfish_serial_ops,
> +       .priv_auto = sizeof(struct goldfish_tty_priv),
> +       .flags  = DM_FLAG_PRE_RELOC,
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
> +       void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_TTY_H_ */
> --
> 2.52.0.358.g0dd7633a29-goog
>

Regards,
Simon
