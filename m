Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193AC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 21:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D21D8852D;
	Sat, 10 Aug 2024 23:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="RjMIj0vQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7CD88521; Sat, 10 Aug 2024 23:14:09 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E553A8852D
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 23:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sat, 10 Aug 2024 23:14:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1723324446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsGf9vm+XdVhq1qki6LMfeE6cod1MCBNdrq6SoOIX2A=;
 b=RjMIj0vQq2XUWwFzxZHcr08eQjWPZzRc8nnIZzdrQnz/8MvPxZBbVxE7S3oTmoHfK33QWe
 pQuzAkWaQFrUbPDOTBZn05JTfqsBD+yQcJm8RLKWH55I7MkaCUHD1s/R+NqK7lxqHFsGGF
 iMyBMnyLF9l4Yl8sh+QjUBUkwCJ47V4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: David Virag <virag.david003@gmail.com>
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] i2c: samsung: Support platforms other than
 EXYNOS4 and EXYNOS5
Message-ID: <20240810211404.GA3012@l14.localdomain>
References: <20240802191920.132133-1-virag.david003@gmail.com>
 <20240802191920.132133-3-virag.david003@gmail.com>
 <20240809210818.GA14190@l14.localdomain>
 <a7bfd187c3769f3e8f50a8cc842a749c67d836a4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7bfd187c3769f3e8f50a8cc842a749c67d836a4.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

Hi David,

On Sat, Aug 10, 2024 at 01:05:06AM +0200, David Virag wrote:
> Hi Henrik,
> 
> On Fri, 2024-08-09 at 23:08 +0200, Henrik Grimler wrote:
> > Hi David,
> > 
> > Thinking about this a bit more...
> > 
> > On Fri, Aug 02, 2024 at 09:19:16PM +0200, David Virag wrote:
> [snip]
> > > @@ -9,11 +9,15 @@
> > >  #include <dm.h>
> > >  #include <i2c.h>
> > >  #include <log.h>
> > > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > >  #include <asm/arch/clk.h>
> > >  #include <asm/arch/cpu.h>
> > >  #include <asm/arch/pinmux.h>
> > > +#endif
> > 
> > We want to try to move the Exynos 4 and 5 devices to CCF and
> > OF_UPSTREAM as well, which will make this messy.  Can we check
> > CONFIG_CLK_EXYNOS and CONFIG_PINCTRL_EXYNOS instead?
> > 
> 
> Happy to hear that move, but you are a bit late, this got merged into
> master not long ago. Sending a patch for changing it should be fine,
> the 7885 port I'm working on uses mostly the same things as the E850-
> 96board (just has some support for 2 boards right now, though I may
> submit jackpotlte only first, will see)

Ah, oops, missed that!  Yeah, no problem, I will touch it in an
upcoming patchset.

> > >  #include <asm/global_data.h>
> > > +#include <asm/io.h>
> > >  #include <linux/delay.h>
> > > +#include <clk.h>
> > >  #include "s3c24x0_i2c.h"
> > >  
> > >  DECLARE_GLOBAL_DATA_PTR;
> > > @@ -137,15 +141,26 @@ static int hsi2c_wait_for_trx(struct
> > > exynos5_hsi2c *i2c)
> > >  	return I2C_NOK_TOUT;
> > >  }
> > >  
> > > -static int hsi2c_get_clk_details(struct s3c24x0_i2c_bus *i2c_bus)
> > > +static int hsi2c_get_clk_details(struct udevice *dev)
> > >  {
> > > +	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
> > >  	struct exynos5_hsi2c *hsregs = i2c_bus->hsregs;
> > >  	ulong clkin;
> > >  	unsigned int op_clk = i2c_bus->clock_frequency;
> > >  	unsigned int i = 0, utemp0 = 0, utemp1 = 0;
> > >  	unsigned int t_ftl_cycle;
> > >  
> > > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > 
> > As above, can we check CONFIG_CLK_EXYNOS instead?
> > 
> 
> Should be fine
> 
> > >  	clkin = get_i2c_clk();
> > > +#else
> > > +	struct clk clk;
> > > +	int ret;
> > > +
> > > +	ret = clk_get_by_name(dev, "hsi2c", &clk);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	clkin = clk_get_rate(&clk);
> > > +#endif
> > >  	/* FPCLK / FI2C =
> > >  	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 *
> > > FLT_CYCLE
> > >  	 * uTemp0 = (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
> > > @@ -487,7 +502,7 @@ static int s3c24x0_i2c_set_bus_speed(struct
> > > udevice *dev, unsigned int speed)
> > >  
> > >  	i2c_bus->clock_frequency = speed;
> > >  
> > > -	if (hsi2c_get_clk_details(i2c_bus))
> > > +	if (hsi2c_get_clk_details(dev))
> > >  		return -EFAULT;
> > >  	hsi2c_ch_init(i2c_bus);
> > >  
> > > @@ -514,7 +529,9 @@ static int s3c24x0_i2c_probe(struct udevice
> > > *dev, uint chip, uint chip_flags)
> > >  
> > >  static int s3c_i2c_of_to_plat(struct udevice *dev)
> > >  {
> > > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > >  	const void *blob = gd->fdt_blob;
> > > +#endif
> > >  	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
> > >  	int node;
> > >  
> > > @@ -522,7 +539,9 @@ static int s3c_i2c_of_to_plat(struct udevice
> > > *dev)
> > >  
> > >  	i2c_bus->hsregs = dev_read_addr_ptr(dev);
> > >  
> > > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > >  	i2c_bus->id = pinmux_decode_periph_id(blob, node);
> > > +#endif
> > >  
> > >  	i2c_bus->clock_frequency =
> > >  		dev_read_u32_default(dev, "clock-frequency",
> > > @@ -530,7 +549,9 @@ static int s3c_i2c_of_to_plat(struct udevice
> > > *dev)
> > >  	i2c_bus->node = node;
> > >  	i2c_bus->bus_num = dev_seq(dev);
> > >  
> > > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > >  	exynos_pinmux_config(i2c_bus->id, PINMUX_FLAG_HS_MODE);
> > > +#endif
> > 
> > I think these three #if def's can be consolidated in one #if def
> > group
> > towards the end of s3c_i2c_of_to_plat to make it easier to follow.
> 
> Hm, sounds good, though I don't know if moving the variable declaration
> from the top would work. I don't know which C standard uboot is
> compiled with, but I do know that some don't like that. If it works, it
> works.

We can probably drop "const void *blob" altogether and use
gd->fdt_blob straight away.

> > 
> > Also, can we check CONFIG_PINCTRL_EXYNOS instead?  That would make it
> > easier when migrating Exynos 4 and 5 devices to pinctrl driver and
> > OF_UPSTREAM.
> 
> Yeah, that works too.
> Only reason I used EXYNOS4/5 is that that's really what it directly
> depends on, and I didn't know it was planned to move Exynos4/5 specific
> stuff to CCF/pinctrl.

I am working on migrating exynos4412-odroid-u2 and
exyno5422-odroid-xu4, as well as adding support for exynos4210-i9100.

> My only real nitpick is that these changes would mean we'd have to
> reintroduce the dependency on exynos platforms, since if we say "if we
> don't have exynos ccf driver, use exynos specific stuff", then if we
> just add the driver to some other non-exynos platform without exynos
> ccf driver enabled for some reason, it would not compile, since it'd be
> trying to use the old exynos4/5 stuff.
> Though for now it should be fine if we limit it to Exynos only.

I guess only exynos and older s3c/s5p devices will ever use the
driver, based on current situation in Linux at least.  Even if we fix
compilation for a none-exynos4/5 device without CCF I suppose driver
would not work without modifications to deal with clocks.

Anyways, thanks!  Will CC you on future changes!

Best regards,
Henrik Grimler
