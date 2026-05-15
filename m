Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF4ACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47CE846CC;
	Fri, 15 May 2026 17:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G37om44H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF315846FA; Fri, 15 May 2026 17:13:34 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F2E846BE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so511597966b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778858012; cv=none;
 d=google.com; s=arc-20240605;
 b=Zk3p+qsCzcq/QMQG+1K9VExcULdUNTfnhLU4jcUkKDZMPRzyQ3UXhr0wh9xREPZ5pZ
 XZsxGtkB4yrcHSjdw18OMhY9zSZxe952ZnroV2FdDFsjB9FoHjickkfm5amGi1zGGlC/
 gD6j3tbM78Pb4+OSuFZDyZ2cat1WL37LQIj062ei8hydzWVGglqLc8ZU9aw3AnhXaNOY
 LtV/7tbHUskS1WFX4VvfpcfyAciKWqW1KLl11Ehax8p1HKgSLcHhNMsXP/CMuiu1T6i+
 ED0g5no1TdtXTN0nfdwFpz3CzJw2zZI0gjtNegTmBm7z30lV8e6qBnYW95XqmK6PGHQX
 dllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p6Sud3usDD2dFjMMVprOhzo/qihR3RryIB86bHPWOMc=;
 fh=53vUflMDHhv9gN1hy9cTJ+q93TqFZkscVeB3wG5oDbQ=;
 b=aEX3OCt7pPqnK5HcWSB0PfCk3KkF8mlzldqw00AWiHXgA0tfVmHeeFhMP7buUO5MB6
 TKvHSvqlJF7rqlG8rLdcdLoE3nKK4RERj+f0G82YyUjYTxmu12AEnVlDSY/nAJmpaG02
 GfFGN6eXtzPV+8sjkrpC8j3g8s1OEhzI73HTzZVYiYSYSEZd/vpXvdDagpk8BXVwxMzd
 9ztSJc8ECz15ufpM7TKZ2Hi0sUBYScxvnjQZQtV2ydsndRKfPlTYiKVFYKgmrKfEDxIX
 Ez7GvkGlXPc+DEb5qTl15w3n34M2cuk7WAT+UKmaqVf+3FcpuYIQkXescb+p7VGpU9yz
 J6Jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778858012; x=1779462812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p6Sud3usDD2dFjMMVprOhzo/qihR3RryIB86bHPWOMc=;
 b=G37om44HQhZLF9WCV0FEI8Xql+QXTMOzaq4zVpMxy6lrg43nGVYOiHTgifqNkZDjhO
 snXaMfa9ivFp93aUpqYlVS0LLazQa5jxDm8NEAtT8ajlX6ArKYYH33D6bsAWGS9ZzFd6
 Q+B1hW/zmghbTMxjZZ96CR4aV4jJIfqI988XYANb/6mdQaEMZq6Xdgmri7/t/d1+K3kP
 /MmNcc6fUiEBk+egm9aA9Wp29q+V84jnq14T2qCr3+C1iaYRzg/MNLiqLd0/NmhjN/c/
 xcidB7ngnP73iluc9apPJgc0v5DiKNB/JKCMKs43MQezD7VEdSTBPzw9tWZtRB+d4IwF
 Wdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858012; x=1779462812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6Sud3usDD2dFjMMVprOhzo/qihR3RryIB86bHPWOMc=;
 b=qNYQYoj2b6ZpjRFoPq41LCiTUEq2awJ3SD4DVDFPpBuK7jS+06AJHLQNlClP0Xoz5D
 42Gf2u9QfXWtGf7zFY2+5/CrVr2F8WvPwDGXzH1fB25oXOH1YSX8Lbl+K4H1IasXwouW
 3mYAeCdsD1HEo1n26IRd1SHcjCeHm5yKW/LaQJ4q6F5p4Tq7zMfBN4j4DJgMhfJGAmib
 2LeQEkMrL/OA1mP60SvawC6n+zX1uAWLraJF2FUpPuUK2uLhtsYI2uTU5RvE5V61NkyA
 WB5p8KX2Ga3WYiIV2V0PUpR+g3/lQY8gvChYZGVDiz5hcwpAXVCX4OlaLwXs/p0IwAut
 6Olg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qRSlTix3+K8LWePGBHHHBM8V1jrbq0+yIYYCAmUwvxfS8Ydc1/iHQ/Ikdvr6vQx1ZSOoEQXE=@lists.denx.de
X-Gm-Message-State: AOJu0YwlMqhc3BjIcv626eyu5eq916umJNV1/rSMqdriEVGnaYDQSUYT
 Ptgn3wdCQ3JgHP+WlsKTuHGF7vzJrjlJMHj0QJiFK4EmvypQJhCUV7muhITD6B1TpetgnrDMa0W
 2T1NRDSgujM0el7PQf+b1HWdJjClLS5M=
X-Gm-Gg: Acq92OEJaWsIhLWU5sWC3oXWl4Md1Vnn11L3LhE4zjXEc2ZgZqs8a5ciGqfaWsLN7Ya
 T0CFCNMoKcRYUf2PKcST0NtzMvpdal5cVdYET/DLPnfHMQjDD2kPUFELgLwylSphWFjSoWt+P0+
 MgdQ6gLtOYcUuJ3Rs9vRbz3NlyaeUPh+k1uAWqV4WOz+BNEyBrlMlZxSAUpOnlwSUp05WulRWld
 0i8YCIpZc9OAHyWrZm0yYS8lGMM9DN2VorfLPS9eHgT/CdAcjwxhUrSYmxtY6NOhv5676mSsBbk
 S9tpR2C4ViKSzdtWykHCg1xMnt0oHbNkduFnucQ8juUYqipvCY+NS7BKBi9yZy6cY3pH9hhSV28
 HrUggUxJlJ6JFFO0KvJlXm5SZKdXYixygKNMTJ3N/Kq1n8WcBF25s6tC4ivHgrDb8XCzFpnBqfQ
 sV
X-Received: by 2002:a17:907:ea5:b0:bd1:ba57:ec8d with SMTP id
 a640c23a62f3a-bd5178458abmr229242066b.17.1778858011554; Fri, 15 May 2026
 08:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-3-aidan@wolfssl.com>
 <CAFLszTh51yo4Jx3OfSoA1gjutFDmPgK0QCmH+=ZvD-rG3yZAww@mail.gmail.com>
In-Reply-To: <CAFLszTh51yo4Jx3OfSoA1gjutFDmPgK0QCmH+=ZvD-rG3yZAww@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 15 May 2026 16:13:19 +0100
X-Gm-Features: AVHnY4KE6hz1P6d0F72RVNB6N8neuKPwbpg45kmdmFO_Hmc5JUTXnXlk4QDrtAU
Message-ID: <CALeDE9P4MM1Mx-Dw+ammCLBCKxJMfLh7KW5KD7dyAhf241WpNQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] spi: add BCM2835/BCM2711 hardware SPI controller
 driver
To: Simon Glass <sjg@chromium.org>
Cc: aidan@wolfssl.com, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Sean Anderson <sean.anderson@seco.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Fri, 15 May 2026 at 14:07, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Aidan,
>
> On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> > spi: add BCM2835/BCM2711 hardware SPI controller driver
> >
> > The BCM2835/BCM2711 SoC on Raspberry Pi 3/4 has no in-tree U-Boot
> > driver for its hardware SPI0 controller; existing U-Boot work with
> > SPI peripherals on these boards has to fall back to GPIO bit-banging
> > via spi-gpio.  That fallback is functional but slow (a few hundred
> > kHz versus the 32 MHz the controller supports), and for protocols
> > like the Infineon SLB9670 / SLB9672 TPM 2.0 TIS interface it makes
> > early-boot operations (startup, self-test, PCR extend) noticeably
> > sluggish.
> >
> > Port the Linux kernel driver drivers/spi/spi-bcm2835.c into U-Boot
> > so existing device-tree nodes using the 'brcm,bcm2835-spi' /
> > 'brcm,bcm2711-spi' compatible work out of the box.  The port keeps
> > the same register layout and software-GPIO chip-select scheme the
> > Linux driver already uses, which is necessary to work around the
> > BCM2835 SPI block's CS auto-deassert behaviour - that behaviour
> > corrupts multi-byte TPM TIS transactions when hardware CS is left
> > enabled.
> >
> > [...]
> >
> > drivers/spi/Kconfig       |   9 +
> >  drivers/spi/Makefile      |   1 +
> >  drivers/spi/bcm2835_spi.c | 440 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 450 insertions(+)
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +/* TPM Reset via GPIO4 and GPIO24 */
> > +static void bcm2835_spi_tpm_reset(void)
> > +{
> > +     void __iomem *gpio_base = (void __iomem *)0xFE200000;
> > +     u32 val;
> > +
> > +     /* Set GPIO4 as output (GPFSEL0, bits 14:12) */
>
> The GPIO base should come from the devicetree and more generally,
> access to it should be via a GPIO driver. Please use lower-case hex.
>
> This should not be in a generic SPI controller driver, and it
> contradicts the commit message claim that the driver is not
> TPM-specific. Any board that probes this driver currently pulses GPIO4
> and GPIO24 low for 100 ms - what if something is wired to those pins?
> TPM reset belongs in the TPM driver (perhaps with a gpio-reset in the
> DT node for the TPM).
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +/* GPIO base for software CS control */
> > +static void __iomem *g_gpio_base = (void __iomem *)0xFE200000;
>
> This is BCM2711-only, so BCM2835 (Pi 3, which the Kconfig help and
> commit subject both advertise) has its GPIO block at 0x3f200000, so
> the driver will silently corrupt unrelated memory there. Anyway,
> U-Boot already has pinctrl (pinctrl-bcm283x.c) and GPIO
> (bcm2835_gpio.c) drivers for this SoC; please go through those.
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +     /* Try to get CS GPIO from device tree */
> > +     ret = gpio_request_by_name(bus, 'cs-gpios', 0, &priv->cs_gpio,
> > +                                GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> > +     if (!ret) {
> > +             priv->cs_gpio_valid = 1;
> > +             /* Deassert CS initially */
> > +             dm_gpio_set_value(&priv->cs_gpio, 1);
> > +     } else {
> > +             priv->cs_gpio_valid = 0;
> > +     }
>
> priv->cs_gpio and priv->cs_gpio_valid are written here but never read
> - bcm2835_spi_xfer() instead does
>
>    int cs_pin = (cs == 0) ? 8 : 7;
>
> and pokes GPSET0/GPCLR0 directly, ignoring the DT. Either honour
> cs-gpios via dm_gpio_set_value() (the normal U-Boot pattern, which
> DM_SPI_GPIO already handles generically), or drop the cs_gpio request
> and document that the driver hardcodes the Pi SPI0 CE0/CE1 pin
> assignment. As written it's half of each.
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +struct bcm2835_spi_priv {
> > +     void __iomem *regs;
> > +     u32 clk_hz;
> > +     u32 cs_reg;         /* Cached CS register value */
> > +     u32 speed_hz;
> > +     u8 mode;
> > +     struct gpio_desc cs_gpio;
> > +     int cs_gpio_valid;
> > +     int cs_asserted;    /* Track if CS should stay asserted between transfers */
> > +};
>
> cs_asserted is assigned in three places in xfer() but never read.
> Please remove it (and the comment that promises behaviour it does not
> implement).
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +/* Default clock rate - 250 MHz for Pi 4 */
> > +#define BCM2835_SPI_DEFAULT_CLK     250000000
>
> This is the SPI core/source clock, not a default transfer rate - the
> default transfer speed is 1 MHz below. The name is confusing. More
> importantly, on BCM2835 vs BCM2711 vs different VPU clock settings
> this number is not constant; please pull it from the clk uclass (or
> from clock-frequency in DT, which you already read, with no hard-coded
> fallback).
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +static inline void bcm2835_spi_writel(struct bcm2835_spi_priv *priv,
> > +                                                                        u32 reg, u32 val)
> > +{
> > +     writel(val, priv->regs + reg);
> > +}
>
> Please check indent for tab-alignment. Patman or checkpatch will flag these.
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +     /* Poll for completion - transfer byte by byte */
> > +     timeout = 100000;
> > +     while ((tx_count < len || rx_count < len) && timeout > 0) {
>
> The 100000 and 10000 timeouts are bare loop counters, not time bounds
> so at 1 MHz a 4 KB transfer takes ~32 ms and the loop body has no
> fixed cost, so these mean nothing except 'don't hang forever'. Please
> convert to get_timer() / timer_get_us(), the way other DM_SPI drivers
> do, so the timeout is independent of CPU speed and transfer length.
>
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > @@ -0,0 +1,440 @@
> > +config BCM2835_SPI
> > +     bool "BCM2835/BCM2711 SPI driver"
> > +     depends on ARCH_BCM283X
>
> Given the hard-coded 0xfe200000 GPIO base and the BCM2711-only fix-up
> in of_to_plat(), the BCM2835 half of this option is not actually
> supported. Either fix the driver to derive the GPIO base from DT /
> from the existing bcm2835_gpio driver and exercise it on a Pi 3, or
> narrow the Kconfig text and commit subject to say BCM2711 only.

This needs to support all, if it's an option people will try to use it
and get a bad experience.
