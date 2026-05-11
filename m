Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F5CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4E484836;
	Mon, 11 May 2026 10:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4zUjUU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D5284715; Mon, 11 May 2026 10:50:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F8A84706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so597921866b.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 01:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778489453; cv=none;
 d=google.com; s=arc-20240605;
 b=Snyvcv2amZLmdKI147snoPPKAxfPkS04TQjl00CaRhgNFUeEuThbjslD02ffVoDKrH
 FUof2EELomV68sGF0/+7VPIQTn/AWdeHFIy28Mcu8+NayEw1DTW8hHIL12mzdsKyon/t
 dkb6Q1oACStsOQJz9WD+Y1rrGDQ+MZYVlSqTsvW+jrUwVp3PDeWZiA4FTK4aNt3gYDxe
 c6r/aBIxOcYP6hzQZ0J8hKzObQM59e+d9ddrnioSdIFbwezfePdehwKS8P3k9XrHs/af
 Jov5Pmot5/XlWNl+mwNuIt1AOtT6UV8WSOnQqCa9mAnraJaIDeHUFmWy8IpFjN8bvHeG
 saZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kXWXx/uATrCGW+nP2MItDSNqvrKlHbqpsH8SynRcIa0=;
 fh=2K8JEZe89Cg9mIn12L3R2Gvj32qUAuMJvPugKb6ns28=;
 b=GYNidnTT1H16DY8CvjF+N1pOkgXV+D9m4kCuVzjaZR2rTEmOEd1GgdcjFBgo+tnFgJ
 QfLFr0JhXNiSKFDqjGb+nDtcYohM39c6kqLILb9hFCQPDjswvvxR1ODFg2qHPKuiaxqg
 5AAT8EHPI4gmAsv7fvhvnd22AIi2J+CRkC5WLZVfT7mfAN2/V+LWNDHIjzFDwzBKZzUJ
 RwMXXTvTMkYOML4mvx8Ts2z9oQr4+Tin9cNiUm2VO30yPYy8QAkXRbmF60cIep5M9MQX
 S5Uo7AUeclsRaGIPV5IgjBsloJcTFYjo2Zus50o5bAxgSMWgIf5kwpVHCrpweZDb7AqU
 tGhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778489453; x=1779094253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kXWXx/uATrCGW+nP2MItDSNqvrKlHbqpsH8SynRcIa0=;
 b=W4zUjUU/akrD504DxEPJdmVMcQUiuYyizHz915Pdxx19yq0gGBX/yHTemDphOfu6V+
 a3albxSE8zzUCbdtaDjIFgS4nceMDkPfgahmKbqTl6BXKnXwRrTzx4AHt5xxTR44eyAC
 23P7FQuuVnmL89sAaiBT6X0ATSmc7xb4qsa9dVoHYiqSphBl2BBPIO+EHlhaewu+e3Nn
 JBwOaIQYia0noTrHcaSD8uiiOIQ8J9BnGzNuaQqWXRsQ/ZDCUyZhYwZTCX2r7YKZf0Og
 OjeZ3hHcgdAzRWggaeCa2pkMsy7xSjk4Iogh1GdCkHPJxRZL1bsQk2Dm46D7KvA9PEW5
 3V6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778489453; x=1779094253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXWXx/uATrCGW+nP2MItDSNqvrKlHbqpsH8SynRcIa0=;
 b=ZRlUgNZUwSqdkC8ejZpltVaZ/Rj0RpkyLAqMTwSfuynAcHDionC9cJMPPae8zjddHv
 xPDGgVvcnyq1+CWb92zsSrsBE6o/mDW055D7/yKyeN00SKhO+nkqzISEvxZhHoxB7xoS
 l8zZr+ev69xXXUzv5p4koXuZ1my92q+E4BSQ9tpdOstTNgph3OeLRbTpjCcWbKYRwQW8
 WOHsJt+LlbU25Jfv/qF96oUOy47aDoS6JhrutpfehV/3ifq8fElBulVGOg6LJp4r/3KG
 D7A8X4bhb8E8EMRZGsw+DHcjjtcHrKc7RQwFVh0iUALWB3o7WrRPI4rjZTzkV7gCvM/s
 8eUg==
X-Gm-Message-State: AOJu0Yyiu9j77vrVMptnnnhlC+C34UKZoAU+cD3Vj/QvW7/zSFQQ+Pnm
 HjYmYriaqFohRjsM9IRSn9tbadt+d87pdB67vZzEHJzuFyrQIO5vNbpbdJxmOQwsDY2jt1BPmQA
 +qYc4+ry6SPyCVU6qC7BiyR/bWLx81IAhm2N/
X-Gm-Gg: Acq92OE/pjmvAcqnLE1jBtW60SVBrUAxWJCJX3VBHsOHyWcFYHj+2aOGuICRtG+amVl
 TNqCvFqXt8sZ5Yg18drSZxQ43fveXlSpIQ/NYGDn44SxpHhBcDpk9EAthJn6xuJztR02xLnoCNF
 +oWZcnqf3H+3ur9lf1KKczIG7jfHBn1mR6p/TYJvQkHleSlylBwLHr72Bxt0U2fd1Bh3fRmuzfY
 g3POWaVxAbJBK6HY4GJLNi9qA1/0vi8btz7l6yp2WMW/q7MRobkg0c9FWP8Dc8PfUBt3RfZTIbn
 F4v+i2gNfKKoqyGyr6VP0gdAdURS7Qlr68b7gpkeuYIlurqNL1Sdag/SKyaZyX0Q/r0UqR0+MS7
 /5TU3WlpPTDID2EwgCZ5K6KhOHWkRxgAYkiomY30LuRrW3HjffDx7qz67Q/O/h6vvojaKj3+DXO
 IM
X-Received: by 2002:a17:907:268a:b0:bad:af5:7ff3 with SMTP id
 a640c23a62f3a-bc56da16383mr1305761766b.37.1778489452614; Mon, 11 May 2026
 01:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778277334.git.aidan@wolfssl.com>
 <6ab2025f19dfc764f2d56b866f839da7475a3773.1778277334.git.aidan@wolfssl.com>
In-Reply-To: <6ab2025f19dfc764f2d56b866f839da7475a3773.1778277334.git.aidan@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 09:50:40 +0100
X-Gm-Features: AVHnY4LEDrQfme7TpDC3NfBgx9Tr_eSLTjjdTEwyck3qT9-J-jQwGsAIv1Cxkyw
Message-ID: <CALeDE9PKoigRUZRnW1zYO5=o+qkq6mUuRGf5xe4sk0M-OQ1oSw@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] spi: add BCM2835/BCM2711 hardware SPI controller
 driver
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, David Garske <david@wolfssl.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sat, 9 May 2026 at 01:57, Aidan Garske <aidan@wolfssl.com> wrote:
>
> From: Aidan <aidan@wolfssl.com>
>
> Add a hardware SPI controller driver for the BCM2835/BCM2711 SoC
> found on Raspberry Pi 3 and Pi 4 boards.
>
> The driver implements:
> - Register-based SPI transfers using the BCM2835 SPI0 peripheral
> - Software GPIO chip-select control (matching the Linux driver
>   approach) rather than hardware CS, which avoids issues with
>   automatic CS deassertion during multi-byte TPM TIS transactions
> - Clock divider calculation for configurable SPI speed
> - SPI mode 0/1/2/3 support via CPOL/CPHA configuration
> - GPIO pin setup for SPI0 (MISO/MOSI/SCLK as ALT0, CE0/CE1 as
>   output for software CS)
> - TPM reset via GPIO4/GPIO24 during probe
>
> This driver is needed for wolfTPM to communicate with SPI-attached
> TPM chips (e.g., Infineon SLB9670/9672) on Raspberry Pi hardware.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> ---
>  drivers/spi/Kconfig       |   9 +
>  drivers/spi/Makefile      |   1 +
>  drivers/spi/bcm2835_spi.c | 431 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 441 insertions(+)
>  create mode 100644 drivers/spi/bcm2835_spi.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 63d61ccf8ed..02ee2b2e6a0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -116,6 +116,15 @@ config ATMEL_SPI
>           many AT91 (ARM) chips. This driver can be used to access
>           the SPI Flash, such as AT25DF321.
>
> +config BCM2835_SPI
> +       bool "BCM2835/BCM2711 SPI driver"
> +       depends on ARCH_BCM283X
> +       help
> +         Enable the BCM2835/BCM2711 SPI controller driver. This driver
> +         can be used to access SPI devices on Raspberry Pi boards
> +         including Pi 3 and Pi 4. It uses the hardware SPI controller
> +         rather than GPIO bit-banging.
> +
>  config BCM63XX_HSSPI
>         bool "BCM63XX HSSPI driver"
>         depends on (ARCH_BMIPS || ARCH_BCMBCA)
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 0dc2d23e172..47a1c6194b1 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_APPLE_SPI) += apple_spi.o
>  obj-$(CONFIG_ATH79_SPI) += ath79_spi.o
>  obj-$(CONFIG_ATMEL_QSPI) += atmel-quadspi.o
>  obj-$(CONFIG_ATMEL_SPI) += atmel_spi.o
> +obj-$(CONFIG_BCM2835_SPI) += bcm2835_spi.o
>  obj-$(CONFIG_BCM63XX_HSSPI) += bcm63xx_hsspi.o
>  obj-$(CONFIG_BCMBCA_HSSPI) += bcmbca_hsspi.o
>  obj-$(CONFIG_BCM63XX_SPI) += bcm63xx_spi.o
> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> new file mode 100644
> index 00000000000..8133a41a0f8
> --- /dev/null
> +++ b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * BCM2835/BCM2711 SPI controller driver for U-Boot
> + *
> + * Copyright (C) 2025 wolfSSL Inc.
> + * Author: Aidan Garske <aidan@wolfssl.com>

I'm by no means a copyright expert but does wolfSSL own the copyright
if it's derived directly from the Linux driver?

> + * Based on Linux driver by Chris Boot, Martin Sperl, et al.
> + */
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <spi.h>
> +#include <asm/io.h>
> +#include <asm/gpio.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +
> +/* SPI register offsets */
> +#define BCM2835_SPI_CS      0x00    /* Control and Status */
> +#define BCM2835_SPI_FIFO    0x04    /* TX and RX FIFOs */
> +#define BCM2835_SPI_CLK     0x08    /* Clock Divider */
> +#define BCM2835_SPI_DLEN    0x0c    /* Data Length */
> +#define BCM2835_SPI_LTOH    0x10    /* LoSSI mode TOH */
> +#define BCM2835_SPI_DC      0x14    /* DMA DREQ Controls */
> +
> +/* CS register bits */
> +#define BCM2835_SPI_CS_LEN_LONG     BIT(25)
> +#define BCM2835_SPI_CS_DMA_LEN      BIT(24)
> +#define BCM2835_SPI_CS_CSPOL2       BIT(23)
> +#define BCM2835_SPI_CS_CSPOL1       BIT(22)
> +#define BCM2835_SPI_CS_CSPOL0       BIT(21)
> +#define BCM2835_SPI_CS_RXF          BIT(20)
> +#define BCM2835_SPI_CS_RXR          BIT(19)
> +#define BCM2835_SPI_CS_TXD          BIT(18)
> +#define BCM2835_SPI_CS_RXD          BIT(17)
> +#define BCM2835_SPI_CS_DONE         BIT(16)
> +#define BCM2835_SPI_CS_LEN          BIT(13)
> +#define BCM2835_SPI_CS_REN          BIT(12)
> +#define BCM2835_SPI_CS_ADCS         BIT(11)
> +#define BCM2835_SPI_CS_INTR         BIT(10)
> +#define BCM2835_SPI_CS_INTD         BIT(9)
> +#define BCM2835_SPI_CS_DMAEN        BIT(8)
> +#define BCM2835_SPI_CS_TA           BIT(7)
> +#define BCM2835_SPI_CS_CSPOL        BIT(6)
> +#define BCM2835_SPI_CS_CLEAR_RX     BIT(5)
> +#define BCM2835_SPI_CS_CLEAR_TX     BIT(4)
> +#define BCM2835_SPI_CS_CPOL         BIT(3)
> +#define BCM2835_SPI_CS_CPHA         BIT(2)
> +#define BCM2835_SPI_CS_CS_10        BIT(1)
> +#define BCM2835_SPI_CS_CS_01        BIT(0)
> +
> +/* Default clock rate - 250 MHz for Pi 4 */
> +#define BCM2835_SPI_DEFAULT_CLK     250000000
> +
> +struct bcm2835_spi_priv {
> +       void __iomem *regs;
> +       u32 clk_hz;
> +       u32 cs_reg;         /* Cached CS register value */
> +       u32 speed_hz;
> +       u8 mode;
> +       struct gpio_desc cs_gpio;
> +       int cs_gpio_valid;
> +       int cs_asserted;    /* Track if CS should stay asserted between transfers */
> +};
> +
> +struct bcm2835_spi_plat {
> +       fdt_addr_t base;
> +       u32 clk_hz;
> +};
> +
> +static inline u32 bcm2835_spi_readl(struct bcm2835_spi_priv *priv, u32 reg)
> +{
> +       return readl(priv->regs + reg);
> +}
> +
> +static inline void bcm2835_spi_writel(struct bcm2835_spi_priv *priv,
> +                                                                          u32 reg, u32 val)
> +{
> +       writel(val, priv->regs + reg);
> +}
> +
> +static void bcm2835_spi_reset(struct bcm2835_spi_priv *priv)
> +{
> +       /* Clear FIFOs and disable SPI */
> +       bcm2835_spi_writel(priv, BCM2835_SPI_CS,
> +                                          BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
> +}
> +
> +/* GPIO base for software CS control */
> +static void __iomem *g_gpio_base = (void __iomem *)0xFE200000;
> +
> +/* Software CS control - assert (LOW = active) */
> +static void bcm2835_spi_cs_assert(int cs_pin)
> +{
> +       /* GPCLR0 - clear pin (drive LOW) */
> +       writel(1 << cs_pin, g_gpio_base + 0x28);
> +}
> +
> +/* Software CS control - deassert (HIGH = inactive) */
> +static void bcm2835_spi_cs_deassert(int cs_pin)
> +{
> +       /* GPSET0 - set pin (drive HIGH) */
> +       writel(1 << cs_pin, g_gpio_base + 0x1C);
> +}
> +
> +static int bcm2835_spi_xfer(struct udevice *dev, unsigned int bitlen,
> +                                                       const void *dout, void *din, unsigned long flags)
> +{
> +       struct udevice *bus = dev_get_parent(dev);
> +       struct bcm2835_spi_priv *priv = dev_get_priv(bus);
> +       const u8 *tx = dout;
> +       u8 *rx = din;
> +       u32 len = bitlen / 8;
> +       u32 cs_reg;
> +       u32 tx_count = 0, rx_count = 0;
> +       int timeout;
> +       int cs = spi_chip_select(dev);  /* Get chip select from slave device */
> +       int cs_pin = (cs == 0) ? 8 : 7; /* CS0=GPIO8, CS1=GPIO7 */
> +       u32 stat;
> +
> +       if (bitlen == 0) {
> +               /* Handle CS-only operations (deassert) */
> +               if (flags & SPI_XFER_END) {
> +                       bcm2835_spi_cs_deassert(cs_pin);
> +                       priv->cs_asserted = 0;
> +               }
> +               return 0;
> +       }
> +
> +       if (bitlen % 8) {
> +               dev_err(dev, "Non-byte-aligned transfer not supported\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * SOFTWARE GPIO CHIP SELECT - like Linux driver
> +        * Don't use hardware CS bits - set to 0 (unused)
> +        */
> +       cs_reg = priv->cs_reg & ~(BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01);
> +
> +       /* Assert CS at start of transaction (SPI_XFER_BEGIN) */
> +       if (flags & SPI_XFER_BEGIN) {
> +               bcm2835_spi_cs_assert(cs_pin);
> +               priv->cs_asserted = 1;
> +               udelay(1);  /* CS setup time */
> +       }
> +
> +       /* Clear FIFOs for new transaction */
> +       if (flags & SPI_XFER_BEGIN) {
> +               bcm2835_spi_writel(priv, BCM2835_SPI_CS,
> +                                                  cs_reg | BCM2835_SPI_CS_CLEAR_RX |
> +                                                  BCM2835_SPI_CS_CLEAR_TX);
> +               udelay(1);
> +       }
> +
> +       /* Start transfer with TA=1 (but CS is controlled by GPIO, not hardware) */
> +       bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg | BCM2835_SPI_CS_TA);
> +
> +       /* Poll for completion - transfer byte by byte */
> +       timeout = 100000;
> +       while ((tx_count < len || rx_count < len) && timeout > 0) {
> +               stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> +
> +               /* TX FIFO not full - send next byte */
> +               while ((stat & BCM2835_SPI_CS_TXD) && tx_count < len) {
> +                       u8 byte = tx ? tx[tx_count] : 0;
> +
> +                       bcm2835_spi_writel(priv, BCM2835_SPI_FIFO, byte);
> +                       tx_count++;
> +                       stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> +               }
> +
> +               /* RX FIFO has data - read it */
> +               while ((stat & BCM2835_SPI_CS_RXD) && rx_count < len) {
> +                       u8 byte = bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0xff;
> +
> +                       if (rx)
> +                               rx[rx_count] = byte;
> +                       rx_count++;
> +                       stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> +               }
> +
> +               timeout--;
> +       }
> +
> +       /* Wait for DONE */
> +       timeout = 10000;
> +       while (!(bcm2835_spi_readl(priv, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE) &&
> +                  timeout > 0) {
> +               udelay(1);
> +               timeout--;
> +       }
> +
> +       /* Read any remaining RX data from FIFO */
> +       while (bcm2835_spi_readl(priv, BCM2835_SPI_CS) & BCM2835_SPI_CS_RXD) {
> +               u8 byte = bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0xff;
> +
> +               if (rx && rx_count < len)
> +                       rx[rx_count++] = byte;
> +       }
> +
> +       /* Clear TA to complete this transfer (doesn't affect GPIO CS) */
> +       bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg);
> +
> +       /*
> +        * SOFTWARE GPIO CHIP SELECT control:
> +        * - SPI_XFER_END: deassert CS (GPIO HIGH)
> +        * - No END flag: keep CS asserted for next transfer
> +        */
> +       if (flags & SPI_XFER_END) {
> +               bcm2835_spi_cs_deassert(cs_pin);
> +               priv->cs_asserted = 0;
> +       } else {
> +               /* Keep CS asserted for next transfer (e.g., wait state polling) */
> +               priv->cs_asserted = 1;
> +       }
> +
> +       if (timeout == 0) {
> +               bcm2835_spi_cs_deassert(cs_pin);  /* Make sure CS is released */
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int bcm2835_spi_set_speed(struct udevice *bus, uint speed)
> +{
> +       struct bcm2835_spi_priv *priv = dev_get_priv(bus);
> +       u32 cdiv;
> +
> +       if (speed == 0)
> +               speed = 1000000;  /* Default 1 MHz */
> +
> +       priv->speed_hz = speed;
> +
> +       /* Calculate clock divider */
> +       if (speed >= priv->clk_hz / 2) {
> +               cdiv = 2;  /* Fastest possible */
> +       } else {
> +               cdiv = (priv->clk_hz + speed - 1) / speed;
> +               cdiv += (cdiv & 1);  /* Must be even */
> +               if (cdiv >= 65536)
> +                       cdiv = 0;  /* Slowest: clk/65536 */
> +       }
> +
> +       bcm2835_spi_writel(priv, BCM2835_SPI_CLK, cdiv);
> +
> +       return 0;
> +}
> +
> +static int bcm2835_spi_set_mode(struct udevice *bus, uint mode)
> +{
> +       struct bcm2835_spi_priv *priv = dev_get_priv(bus);
> +       u32 cs_reg = 0;
> +
> +       priv->mode = mode;
> +
> +       /* Set clock polarity and phase */
> +       if (mode & SPI_CPOL)
> +               cs_reg |= BCM2835_SPI_CS_CPOL;
> +       if (mode & SPI_CPHA)
> +               cs_reg |= BCM2835_SPI_CS_CPHA;
> +
> +       /* CS bits will be set in xfer based on slave's chip select */
> +       priv->cs_reg = cs_reg;
> +
> +       return 0;
> +}
> +
> +static int bcm2835_spi_claim_bus(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static int bcm2835_spi_release_bus(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +/* Setup GPIO pins for SPI0 with SOFTWARE chip select */
> +static void bcm2835_spi_setup_gpio(void)
> +{
> +       u32 val;
> +
> +       /*
> +        * SPI0 pin configuration:
> +        * GPIO7  (CE1)  - OUTPUT (software CS) - GPFSEL0 bits 23:21 = 001
> +        * GPIO8  (CE0)  - OUTPUT (software CS) - GPFSEL0 bits 26:24 = 001
> +        * GPIO9  (MISO) - ALT0 (SPI)           - GPFSEL0 bits 29:27 = 100
> +        * GPIO10 (MOSI) - ALT0 (SPI)           - GPFSEL1 bits 2:0   = 100
> +        * GPIO11 (SCLK) - ALT0 (SPI)           - GPFSEL1 bits 5:3   = 100
> +        */
> +
> +       /* Set GPIO7, GPIO8 to OUTPUT, GPIO9 to ALT0 in GPFSEL0 */
> +       val = readl(g_gpio_base + 0x00);
> +       val &= ~((7 << 21) | (7 << 24) | (7 << 27));  /* Clear GPIO7,8,9 */
> +       val |= (1 << 21);   /* GPIO7 = OUTPUT (001) */
> +       val |= (1 << 24);   /* GPIO8 = OUTPUT (001) */
> +       val |= (4 << 27);   /* GPIO9 = ALT0 (100) for MISO */
> +       writel(val, g_gpio_base + 0x00);
> +
> +       /* Set GPIO10, GPIO11 to ALT0 in GPFSEL1 */
> +       val = readl(g_gpio_base + 0x04);
> +       val &= ~((7 << 0) | (7 << 3));  /* Clear GPIO10,11 */
> +       val |= (4 << 0);    /* GPIO10 = ALT0 (100) for MOSI */
> +       val |= (4 << 3);    /* GPIO11 = ALT0 (100) for SCLK */
> +       writel(val, g_gpio_base + 0x04);
> +
> +       /* Deassert both CS lines (HIGH = inactive) */
> +       bcm2835_spi_cs_deassert(7);  /* CE1 */
> +       bcm2835_spi_cs_deassert(8);  /* CE0 */
> +}
> +
> +/* TPM Reset via GPIO4 and GPIO24 */
> +static void bcm2835_spi_tpm_reset(void)
> +{
> +       void __iomem *gpio_base = (void __iomem *)0xFE200000;
> +       u32 val;
> +
> +       /* Set GPIO4 as output (GPFSEL0, bits 14:12) */
> +       val = readl(gpio_base + 0x00);  /* GPFSEL0 */
> +       val &= ~(7 << 12);  /* Clear bits 14:12 for GPIO4 */
> +       val |= (1 << 12);   /* Set to output */
> +       writel(val, gpio_base + 0x00);
> +
> +       /* Set GPIO24 as output (GPFSEL2, bits 14:12) */
> +       val = readl(gpio_base + 0x08);  /* GPFSEL2 */
> +       val &= ~(7 << 12);  /* Clear bits 14:12 for GPIO24 */
> +       val |= (1 << 12);   /* Set to output */
> +       writel(val, gpio_base + 0x08);
> +
> +       /* Assert reset on BOTH pins (LOW) */
> +       writel((1 << 4) | (1 << 24), gpio_base + 0x28);  /* GPCLR0 */
> +       mdelay(100);
> +
> +       /* Release reset on BOTH pins (HIGH) */
> +       writel((1 << 4) | (1 << 24), gpio_base + 0x1C);  /* GPSET0 */
> +       mdelay(150);  /* Wait for TPM to initialize */
> +}
> +
> +static int bcm2835_spi_probe(struct udevice *bus)
> +{
> +       struct bcm2835_spi_plat *plat = dev_get_plat(bus);
> +       struct bcm2835_spi_priv *priv = dev_get_priv(bus);
> +       int ret;
> +
> +       priv->regs = (void __iomem *)plat->base;
> +       priv->clk_hz = plat->clk_hz ? plat->clk_hz : BCM2835_SPI_DEFAULT_CLK;
> +
> +       /* Setup GPIO pins for SPI0 (ALT0 function) */
> +       bcm2835_spi_setup_gpio();
> +
> +       /* Reset TPM before using SPI */
> +       bcm2835_spi_tpm_reset();
> +
> +       /* Try to get CS GPIO from device tree */
> +       ret = gpio_request_by_name(bus, "cs-gpios", 0, &priv->cs_gpio,
> +                                  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +       if (!ret) {
> +               priv->cs_gpio_valid = 1;
> +               /* Deassert CS initially */
> +               dm_gpio_set_value(&priv->cs_gpio, 1);
> +       } else {
> +               priv->cs_gpio_valid = 0;
> +       }
> +
> +       /* Reset the SPI controller */
> +       bcm2835_spi_reset(priv);
> +
> +       /* Set default speed and mode */
> +       bcm2835_spi_set_speed(bus, 1000000);  /* 1 MHz default */
> +       bcm2835_spi_set_mode(bus, SPI_MODE_0);
> +
> +       return 0;
> +}
> +
> +static int bcm2835_spi_of_to_plat(struct udevice *bus)
> +{
> +       struct bcm2835_spi_plat *plat = dev_get_plat(bus);
> +       fdt_addr_t addr;
> +
> +       addr = dev_read_addr(bus);
> +       if (addr == FDT_ADDR_T_NONE) {
> +               dev_err(bus, "Failed to get SPI base address\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * On BCM2711 (Pi 4), the device tree often uses VideoCore bus addresses
> +        * which start with 0x7E. The ARM needs to access these via the ARM
> +        * peripheral base at 0xFE000000.
> +        */
> +       if ((addr & 0xFF000000) == 0x7E000000)
> +               addr = (addr & 0x00FFFFFF) | 0xFE000000;
> +
> +       plat->base = addr;
> +
> +       /* Try to get clock rate from device tree */
> +       plat->clk_hz = dev_read_u32_default(bus, "clock-frequency",
> +                                            BCM2835_SPI_DEFAULT_CLK);
> +
> +       return 0;
> +}
> +
> +static const struct dm_spi_ops bcm2835_spi_ops = {
> +       .claim_bus      = bcm2835_spi_claim_bus,
> +       .release_bus    = bcm2835_spi_release_bus,
> +       .xfer           = bcm2835_spi_xfer,
> +       .set_speed      = bcm2835_spi_set_speed,
> +       .set_mode       = bcm2835_spi_set_mode,
> +};
> +
> +static const struct udevice_id bcm2835_spi_ids[] = {
> +       { .compatible = "brcm,bcm2835-spi" },
> +       { .compatible = "brcm,bcm2711-spi" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(bcm2835_spi) = {
> +       .name           = "bcm2835_spi",
> +       .id             = UCLASS_SPI,
> +       .of_match       = bcm2835_spi_ids,
> +       .ops            = &bcm2835_spi_ops,
> +       .of_to_plat     = bcm2835_spi_of_to_plat,
> +       .plat_auto      = sizeof(struct bcm2835_spi_plat),
> +       .priv_auto      = sizeof(struct bcm2835_spi_priv),
> +       .probe          = bcm2835_spi_probe,
> +};
> --
> 2.47.3
>
