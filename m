Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E8CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A4B8464D;
	Fri, 15 May 2026 15:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TpfuhI6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E98A84693; Fri, 15 May 2026 15:07:20 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B48884099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd2e8931915so216195366b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850438; cv=none;
 d=google.com; s=arc-20240605;
 b=BnDKKy09xQgnq6peJcM1+Qmwf7Ymy0nwMc+XOFdUV1o7TSqK1x5cFomOU8vb6DOCI6
 +sC6MVZLHSSk4MLOInc0mdyfPugCj/EiW/aFUMLrUVLmVu+IwCSrORMPwfrxuHTpr2i1
 FHVy5NQa+D9XTyLAfLbA1V4TTmCWEJ5br/dLlBdes9Xiot6s1Z0lD3FUi6WZc9Tw0Nx+
 ti6FR6Z1PBHl0A9XCJKwyZAJ2MDI+RvcbXeMSx5znOk5z/khaLMc8mcbTgLwF0tNecmU
 I+GG3POk5WzHOj9bwxEGmcwd3fewBEIG4vtiVW1PSEU26qxPnInpy4MwrRwt5p8YGmR+
 FD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WlkqfhGLAx2Qh3WdjUO6BZBKQ4OipzoU+D+EZSW4cfA=;
 fh=ZgqpIOkm64mVRZrXW+PI1Q2FS4talgvTQQsuRIHDPmo=;
 b=ciHIV3NTjsh5x2vGzo576nkzUD0JjidGDJiXRa028Z4fxOi+kO/O9VIN8++MuSsVrX
 1PAqH1IWzyz0FkIuiBxKugDeJTwWqEgSxBZw70z8OD/15f8nPHStXk9nbq1sLKoJK2+8
 XvzKr4J6jJmA/k2bIjaATUw5g6vIhxrzHqq43X3oHTHpowCHtVwqyFA6qlL5OooF2fr+
 D7kOy5E6xcr+GS27ibNBh0MqzhswDU7lFZstXiB7q1rd/G+z3LXadGnoNprzGzD+RjmG
 FT3oFWH6TzfGZ3dyFhJS9s86oCgf+xPOlzl3rkSLKrxJ1UNQumDaOS9DwQ+hpxh7wJn9
 g+fg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850438; x=1779455238; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WlkqfhGLAx2Qh3WdjUO6BZBKQ4OipzoU+D+EZSW4cfA=;
 b=TpfuhI6UM8xRmxOq7Xp482LJpJqXZ9G+qV7tGAz4A4KR2/iHBK3v+w2BRAe0bAnJ/L
 b4d6jV6lkYoLEf0JBfAfD6bgC+DVqLbSuyNExjwB4bP/eUk4qXmXrO9Fbfzy2uCu3AVf
 OtkE0mrAQ8m7uBxkNpv2TH6o6z0bA7cjMG+bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850438; x=1779455238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlkqfhGLAx2Qh3WdjUO6BZBKQ4OipzoU+D+EZSW4cfA=;
 b=JpH/JLKXHB6siwsIwJQTaDwh6RvWOKyUiN8UGRLt/tZoyOWoqMo6TaA1FpkFIRGvhv
 YDAzMIPboS+zrG+dJg4rhc0IdNuMT7A8EXrLnKvjlG12X2qBC41WtnY2CopTKvo65oCf
 dKacG5WnxUFQSzu3CMl4pA1wbS7EufB8+rguorVkgt9y4SOoXFxu5vfeuvnejZuPOiAp
 HFi+5Bkm3wdyagQqDvbiUMD7XbCm0GAVciEJxunw+rgww2bV7kWhqhHs/RHRO6ZHfEeF
 ceFngL5ZQdrZa+ol1sJ5IBxNmiEhqdtQU8rFY4S9BeQr9ixsmGR7+scmxQaoBNc0MLmB
 yArQ==
X-Gm-Message-State: AOJu0YzpFn4aZDP/Okf5u51P+sSzeATFjF2F0tClhOrC4pGF0eWO417t
 fKExLqj9u8zUVmOteuIPKBE8OePhAB8IN3uo87lzaUCBwBbxv3US05719Wym8D+G+M5kK1UMn4j
 777BhP5CujAmxoUc/LtUeX1DwENJ2cwb2/1XCujcf
X-Gm-Gg: Acq92OHJ4mbzwERPGgpfrfWRnj/90kp0Rpgt6VHSnMmRxUpkmG1BfctppShRXaYJNBh
 qzF4HODcBhQBMuMYCsbl/d73zvkuMD8/rVShMVn06s/GPm/PvBHIZMFDjEH+D7pn1mRq2BY9pJG
 sLSEB/LIn6GjKcK0uL+Ja8JuVmcJYzlKixS4YIc6xkPljmCsv0Fof6liFfj53e9tNLNOxJfW1VE
 SdcIsV8WuImT5FQwhfkluVmA3K2g0Jz5Jr3sPsOweYaVatOotawPh3I8eYQ66MaikLkCkfiucPj
 1aSQhr2IO2OnKqbf
X-Received: by 2002:a17:906:f590:b0:bd5:b27:c02e with SMTP id
 a640c23a62f3a-bd50b27c388mr279834666b.6.1778850437731; Fri, 15 May 2026
 06:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-3-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-3-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:07:05 -0600
X-Gm-Features: AVHnY4I3fOf5yv9SE0dKXXrICdYf6_jIZSL2_chvPt0JPoxxhQMQAwQLVAPbQEI
Message-ID: <CAFLszTh51yo4Jx3OfSoA1gjutFDmPgK0QCmH+=ZvD-rG3yZAww@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] spi: add BCM2835/BCM2711 hardware SPI controller
 driver
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Aidan,

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> spi: add BCM2835/BCM2711 hardware SPI controller driver
>
> The BCM2835/BCM2711 SoC on Raspberry Pi 3/4 has no in-tree U-Boot
> driver for its hardware SPI0 controller; existing U-Boot work with
> SPI peripherals on these boards has to fall back to GPIO bit-banging
> via spi-gpio.  That fallback is functional but slow (a few hundred
> kHz versus the 32 MHz the controller supports), and for protocols
> like the Infineon SLB9670 / SLB9672 TPM 2.0 TIS interface it makes
> early-boot operations (startup, self-test, PCR extend) noticeably
> sluggish.
>
> Port the Linux kernel driver drivers/spi/spi-bcm2835.c into U-Boot
> so existing device-tree nodes using the 'brcm,bcm2835-spi' /
> 'brcm,bcm2711-spi' compatible work out of the box.  The port keeps
> the same register layout and software-GPIO chip-select scheme the
> Linux driver already uses, which is necessary to work around the
> BCM2835 SPI block's CS auto-deassert behaviour - that behaviour
> corrupts multi-byte TPM TIS transactions when hardware CS is left
> enabled.
>
> [...]
>
> drivers/spi/Kconfig       |   9 +
>  drivers/spi/Makefile      |   1 +
>  drivers/spi/bcm2835_spi.c | 440 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 450 insertions(+)

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +/* TPM Reset via GPIO4 and GPIO24 */
> +static void bcm2835_spi_tpm_reset(void)
> +{
> +     void __iomem *gpio_base = (void __iomem *)0xFE200000;
> +     u32 val;
> +
> +     /* Set GPIO4 as output (GPFSEL0, bits 14:12) */

The GPIO base should come from the devicetree and more generally,
access to it should be via a GPIO driver. Please use lower-case hex.

This should not be in a generic SPI controller driver, and it
contradicts the commit message claim that the driver is not
TPM-specific. Any board that probes this driver currently pulses GPIO4
and GPIO24 low for 100 ms - what if something is wired to those pins?
TPM reset belongs in the TPM driver (perhaps with a gpio-reset in the
DT node for the TPM).

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +/* GPIO base for software CS control */
> +static void __iomem *g_gpio_base = (void __iomem *)0xFE200000;

This is BCM2711-only, so BCM2835 (Pi 3, which the Kconfig help and
commit subject both advertise) has its GPIO block at 0x3f200000, so
the driver will silently corrupt unrelated memory there. Anyway,
U-Boot already has pinctrl (pinctrl-bcm283x.c) and GPIO
(bcm2835_gpio.c) drivers for this SoC; please go through those.

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +     /* Try to get CS GPIO from device tree */
> +     ret = gpio_request_by_name(bus, 'cs-gpios', 0, &priv->cs_gpio,
> +                                GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +     if (!ret) {
> +             priv->cs_gpio_valid = 1;
> +             /* Deassert CS initially */
> +             dm_gpio_set_value(&priv->cs_gpio, 1);
> +     } else {
> +             priv->cs_gpio_valid = 0;
> +     }

priv->cs_gpio and priv->cs_gpio_valid are written here but never read
- bcm2835_spi_xfer() instead does

   int cs_pin = (cs == 0) ? 8 : 7;

and pokes GPSET0/GPCLR0 directly, ignoring the DT. Either honour
cs-gpios via dm_gpio_set_value() (the normal U-Boot pattern, which
DM_SPI_GPIO already handles generically), or drop the cs_gpio request
and document that the driver hardcodes the Pi SPI0 CE0/CE1 pin
assignment. As written it's half of each.

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +struct bcm2835_spi_priv {
> +     void __iomem *regs;
> +     u32 clk_hz;
> +     u32 cs_reg;         /* Cached CS register value */
> +     u32 speed_hz;
> +     u8 mode;
> +     struct gpio_desc cs_gpio;
> +     int cs_gpio_valid;
> +     int cs_asserted;    /* Track if CS should stay asserted between transfers */
> +};

cs_asserted is assigned in three places in xfer() but never read.
Please remove it (and the comment that promises behaviour it does not
implement).

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +/* Default clock rate - 250 MHz for Pi 4 */
> +#define BCM2835_SPI_DEFAULT_CLK     250000000

This is the SPI core/source clock, not a default transfer rate - the
default transfer speed is 1 MHz below. The name is confusing. More
importantly, on BCM2835 vs BCM2711 vs different VPU clock settings
this number is not constant; please pull it from the clk uclass (or
from clock-frequency in DT, which you already read, with no hard-coded
fallback).

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +static inline void bcm2835_spi_writel(struct bcm2835_spi_priv *priv,
> +                                                                        u32 reg, u32 val)
> +{
> +     writel(val, priv->regs + reg);
> +}

Please check indent for tab-alignment. Patman or checkpatch will flag these.

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +     /* Poll for completion - transfer byte by byte */
> +     timeout = 100000;
> +     while ((tx_count < len || rx_count < len) && timeout > 0) {

The 100000 and 10000 timeouts are bare loop counters, not time bounds
so at 1 MHz a 4 KB transfer takes ~32 ms and the loop body has no
fixed cost, so these mean nothing except 'don't hang forever'. Please
convert to get_timer() / timer_get_us(), the way other DM_SPI drivers
do, so the timeout is independent of CPU speed and transfer length.

> diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> @@ -0,0 +1,440 @@
> +config BCM2835_SPI
> +     bool "BCM2835/BCM2711 SPI driver"
> +     depends on ARCH_BCM283X

Given the hard-coded 0xfe200000 GPIO base and the BCM2711-only fix-up
in of_to_plat(), the BCM2835 half of this option is not actually
supported. Either fix the driver to derive the GPIO base from DT /
from the existing bcm2835_gpio driver and exercise it on a Pi 3, or
narrow the Kconfig text and commit subject to say BCM2711 only.

Regards,
Simon
