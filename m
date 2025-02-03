Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E7CC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 11:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C9480087;
	Mon,  3 Feb 2025 12:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="KmK2AI2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2CB800B2; Mon,  3 Feb 2025 12:32:08 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5086A80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 12:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F128414830AD; Mon,  3 Feb 2025 12:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1738582321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6A3C4333lqE12xDC1kf2Lki8HDbybapXjWflhSnh7ok=;
 b=KmK2AI2ZPqGG0ApwDRckhv9+N8UEZvFSWkYIDP/oTpbNJP7kZlL1xoI+f/ah9I/y10TN2V
 4TPDueIl4D0pMZFrsVIfJW4Z/qg3tdosJp3Szvbs6L95LM8l2IbyGjVyf2IuT+s+tdrDaz
 4yWYXFYRWR7FX9GGxuWL+uKCjNYmYWAvHvsQIT0wKKbklBQUeyo98f0uOVnbNPETk9J9Bd
 B8vMTdap16+adxmamKCPeHGT7HE8aHNXi7NY/cqgdW7M47JUctMHApLUSrxp/d5rPcCVxf
 RGYztJig1F19LI2M3nCYE/VXSlckUjTm+XH3uH7xr3/Wu+0Yh5WBv/aGDNKKrg==
Date: Mon, 3 Feb 2025 12:31:59 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 6/7] spi: atmel-quadspi: Add support for classic SPI mode
Message-ID: <20250203-trident-jugular-f008126a16bc@thorsis.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
References: <20250123121215.21001-1-ada@thorsis.com>
 <20250123121215.21001-7-ada@thorsis.com>
 <8e563112-38d6-4f27-910f-331c04294465@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e563112-38d6-4f27-910f-331c04294465@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Eugen,

thanks for looking at this.  My remarks below.

Am Thu, Jan 30, 2025 at 11:49:30AM +0200 schrieb Eugen Hristev:
> Hello Alex,
> 
> On 1/23/25 14:12, Alexander Dahl wrote:
> > The qspi controller on sama5d2 and sam9x60 supports "classic" SPI mode
> > without spi-mem enhancements and accelerations, very similar to the old
> > SPI controller on sam9g20 or the modern flexcom controllers of the same
> > SoC family.
> > 
> > Register interface differs somewhat, especially because only one
> > hardware controlled CS line is supported.  Some fields are missing, some
> > are in different registers, but in principal it works similar.  So code
> > is very much inspired by the old atmel-spi driver.
> > 
> > Tested on sam9x60 with a non-mainline driver to configure an FPGA.

[…]

> > +static int atmel_qspi_xfer(struct udevice *dev, unsigned int bitlen,
> > +			   const void *dout, void *din, unsigned long flags)
> > +{
> > +	struct udevice *bus = dev_get_parent(dev);
> > +	struct atmel_qspi *aq = dev_get_priv(bus);
> > +	unsigned int len, len_rx, len_tx;
> > +	const u8 *txp = dout;
> > +	u8 *rxp = din;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	if (bitlen == 0)
> > +		goto out;
> > +
> > +	if (bitlen % 8) {
> > +		flags |= SPI_XFER_END;
> > +		goto out;
> > +	}
> > +
> > +	len = bitlen / 8;
> > +
> > +	if (flags & SPI_XFER_BEGIN) {
> > +		ret = atmel_qspi_set_cs(dev, 1);
> > +		if (ret)
> > +			return log_ret(ret);
> > +		reg = atmel_qspi_read(aq, QSPI_RD);
> > +	}
> > +
> > +	for (len_tx = 0, len_rx = 0; len_rx < len; ) {
> > +		u32 status = atmel_qspi_read(aq, QSPI_SR);
> > +		u8 value;
> > +
> > +		if (status & QSPI_SR_OVRES)
> > +			return log_ret(-1);
> 
> Any specific meaning for '-1' ?
> 
> > +
> > +		if (len_tx < len && (status & QSPI_SR_TDRE)) {
> > +			if (txp)
> > +				value = *txp++;
> > +			else
> > +				value = 0;
> > +			atmel_qspi_write(value, aq, QSPI_TD);
> > +			len_tx++;
> > +		}
> > +
> > +		if (status & QSPI_SR_RDRF) {
> > +			value = atmel_qspi_read(aq, QSPI_RD);
> > +			if (rxp)
> > +				*rxp++ = value;
> > +			len_rx++;
> 
> As this loop is finished only when len_rx == len, can it happen that
> this increment is always skipped thus forever looping ?

The whole loop was copied from the old atmel_spi driver.  Code is
untouched since it was introduced with commit 0eafd4b77615 ("dm: at91:
Add driver model support for the spi driver") back in 2016.  The code
of that loop for the dm based driver is the same as for the old non-dm
implementation which dates back to 2008 introduced with commit
60445cb5c3eb ("atmel_spi: Driver for the Atmel SPI controller").

I don't expect to get any answers from the original author(s) anymore? ^^

My interpretation is this is a very simple way to implement the xfer,
without all the complexity of interrupts and/or dma (which is good
enough for my usecase).

The OVRES flag is set in case of an receive data overrun.  What would
be better to return here instead of -1?  And should we port that to
the old driver, too?  The linux driver seems to use -EIO in a
comparable case.

I think in practice this won't loop forever if the microprocessor
works fine.  RDR and TDR are two holding registers with a shift
register in between clocking in and out the bits from and to the data
lines.  You need to write to TDR to be able to read from RDR.  But
this is just my interpretation of the old code here.

> > +		}
> > +	}
> > +
> > +out:
> > +	if (flags & SPI_XFER_END) {
> > +		readl_poll_timeout(aq->regs + QSPI_SR, reg,
> > +				   reg & QSPI_SR_TXEMPTY,
> > +				   ATMEL_QSPI_TIMEOUT);
> > +
> > +		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
> > +
> > +		ret = atmel_qspi_set_cs(dev, 0);
> > +		if (ret)
> > +			return log_ret(ret);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int atmel_qspi_set_speed(struct udevice *bus, uint hz)
> >  {
> >  	struct atmel_qspi *aq = dev_get_priv(bus);
> > @@ -1089,6 +1222,23 @@ static int atmel_qspi_probe(struct udevice *dev)
> >  	else
> >  		aq->ops = &atmel_qspi_priv_ops;
> >  
> > +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> > +		ret = gpio_request_list_by_name(dev, "cs-gpios", aq->cs_gpios,
> > +						ARRAY_SIZE(aq->cs_gpios), 0);
> > +		if (ret < 0) {
> > +			pr_err("Can't get %s gpios! Error: %d", dev->name, ret);
> 
> Is cs-gpios mandatory ? Apparently binding does not enforce it
> 
> > +			return ret;
> > +		}
> > +
> > +		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
> > +			if (!dm_gpio_is_valid(&aq->cs_gpios[i]))
> > +				continue;
> in here you just skip if gpio isn't valid apparently.
> > +
> > +			dm_gpio_set_dir_flags(&aq->cs_gpios[i],
> > +					      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> > +		}
> > +	}

No cs-gpios is not mandatory.  This code is also copied from the
atmel_spi driver.  There are two reasons why this is not mandatory.

First: It should work with native CS handling by the SoC without a
GPIO line acting as CS.  However I could not test this, I need a
different pin for CS in my usecase than the native one.

Second: the probe function is also for the non-classic spi-mem mode
where the native CS handling of the SoC _is_ used.  That mode did not
use cs-gpios before, and won't with this patch.  Should this be made
more clear somewhere?

Greets
Alex

