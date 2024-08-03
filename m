Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BE6C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 22:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8809A88702;
	Sun,  4 Aug 2024 00:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="KwF3c6Jy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CDF8862F; Sun,  4 Aug 2024 00:39:00 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DEC88702
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 00:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sun, 4 Aug 2024 00:38:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1722724737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2OAZwIIAMRTL/Jt6hRpr7rGCe2v6ggiFGaVLdaOH18=;
 b=KwF3c6Jy6occ52Q7ay+VuhZAfG3/SERzv+6paMEC4wrXXMBEmvjy93QKe5v32vh2xy60Lb
 8k2gMxCf0TnTh3LJcuO3hixqQ9nWtr0CXqQaiyqSr6tWDApZqhNxQUHy+NGeaLDxvz6iAA
 w0rfED1OC3wwoMF9myBsZ8L1TdLbDqs=
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
Message-ID: <20240803223854.GA185145@l14.localdomain>
References: <20240802191920.132133-1-virag.david003@gmail.com>
 <20240802191920.132133-3-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802191920.132133-3-virag.david003@gmail.com>
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

On Fri, Aug 02, 2024 at 09:19:16PM +0200, David Virag wrote:
> Newer Samsung SoCs (including newer Exynos, ExynosAuto, Google Tensor)
> still use these IPs, or slightly newer versions of it.
> 
> Make these drivers available on these platforms by guarding
> EXYNOS4/EXYNOS5 specific code behind their configs, and using CCF for
> clocks on other platforms.
> 
> Tested S3C I2C driver on Exynos7885.
> This along with extended clock driver should enable S3C I2C on
> Exynos850.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

Tested-by: Henrik Grimler <henrik@grimler.se>

Tested on exynos4412-odroid-u2 and exynos5422-odroid-xu4.  On both
devices i2c still works fine, thanks!

Best regards,
Henrik Grimler

> ---
>  drivers/i2c/Kconfig         |  2 +-
>  drivers/i2c/exynos_hs_i2c.c | 25 +++++++++++++++++++++++--
>  drivers/i2c/s3c24x0_i2c.c   | 30 +++++++++++++++++++++++++++---
>  drivers/i2c/s3c24x0_i2c.h   |  2 ++
>  4 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index cba7f84894..52067fa7c1 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -650,7 +650,7 @@ config SYS_I2C_GENI
>  
>  config SYS_I2C_S3C24X0
>  	bool "Samsung I2C driver"
> -	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && DM_I2C
> +	depends on DM_I2C
>  	help
>  	  Support for Samsung I2C controller as Samsung SoCs.
>  
> diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
> index 189ce6d509..fa0d1c8f64 100644
> --- a/drivers/i2c/exynos_hs_i2c.c
> +++ b/drivers/i2c/exynos_hs_i2c.c
> @@ -9,11 +9,15 @@
>  #include <dm.h>
>  #include <i2c.h>
>  #include <log.h>
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  #include <asm/arch/clk.h>
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/pinmux.h>
> +#endif
>  #include <asm/global_data.h>
> +#include <asm/io.h>
>  #include <linux/delay.h>
> +#include <clk.h>
>  #include "s3c24x0_i2c.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -137,15 +141,26 @@ static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
>  	return I2C_NOK_TOUT;
>  }
>  
> -static int hsi2c_get_clk_details(struct s3c24x0_i2c_bus *i2c_bus)
> +static int hsi2c_get_clk_details(struct udevice *dev)
>  {
> +	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
>  	struct exynos5_hsi2c *hsregs = i2c_bus->hsregs;
>  	ulong clkin;
>  	unsigned int op_clk = i2c_bus->clock_frequency;
>  	unsigned int i = 0, utemp0 = 0, utemp1 = 0;
>  	unsigned int t_ftl_cycle;
>  
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	clkin = get_i2c_clk();
> +#else
> +	struct clk clk;
> +	int ret;
> +
> +	ret = clk_get_by_name(dev, "hsi2c", &clk);
> +	if (ret < 0)
> +		return ret;
> +	clkin = clk_get_rate(&clk);
> +#endif
>  	/* FPCLK / FI2C =
>  	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 * FLT_CYCLE
>  	 * uTemp0 = (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
> @@ -487,7 +502,7 @@ static int s3c24x0_i2c_set_bus_speed(struct udevice *dev, unsigned int speed)
>  
>  	i2c_bus->clock_frequency = speed;
>  
> -	if (hsi2c_get_clk_details(i2c_bus))
> +	if (hsi2c_get_clk_details(dev))
>  		return -EFAULT;
>  	hsi2c_ch_init(i2c_bus);
>  
> @@ -514,7 +529,9 @@ static int s3c24x0_i2c_probe(struct udevice *dev, uint chip, uint chip_flags)
>  
>  static int s3c_i2c_of_to_plat(struct udevice *dev)
>  {
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	const void *blob = gd->fdt_blob;
> +#endif
>  	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
>  	int node;
>  
> @@ -522,7 +539,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
>  
>  	i2c_bus->hsregs = dev_read_addr_ptr(dev);
>  
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	i2c_bus->id = pinmux_decode_periph_id(blob, node);
> +#endif
>  
>  	i2c_bus->clock_frequency =
>  		dev_read_u32_default(dev, "clock-frequency",
> @@ -530,7 +549,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
>  	i2c_bus->node = node;
>  	i2c_bus->bus_num = dev_seq(dev);
>  
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	exynos_pinmux_config(i2c_bus->id, PINMUX_FLAG_HS_MODE);
> +#endif
>  
>  	i2c_bus->active = true;
>  
> diff --git a/drivers/i2c/s3c24x0_i2c.c b/drivers/i2c/s3c24x0_i2c.c
> index ae3a801cad..ade1ad6cef 100644
> --- a/drivers/i2c/s3c24x0_i2c.c
> +++ b/drivers/i2c/s3c24x0_i2c.c
> @@ -9,12 +9,15 @@
>  #include <fdtdec.h>
>  #include <time.h>
>  #include <log.h>
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  #include <asm/arch/clk.h>
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/pinmux.h>
> +#endif
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <i2c.h>
> +#include <clk.h>
>  #include "s3c24x0_i2c.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -46,10 +49,23 @@ static void read_write_byte(struct s3c24x0_i2c *i2c)
>  	clrbits_le32(&i2c->iiccon, I2CCON_IRPND);
>  }
>  
> -static void i2c_ch_init(struct s3c24x0_i2c *i2c, int speed, int slaveadd)
> +static int i2c_ch_init(struct udevice *dev, int speed, int slaveadd)
>  {
> +	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
> +	struct s3c24x0_i2c *i2c = i2c_bus->regs;
>  	ulong freq, pres = 16, div;
> +
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
>  	freq = get_i2c_clk();
> +#else
> +	struct clk clk;
> +	int ret;
> +
> +	ret = clk_get_by_name(dev, "i2c", &clk);
> +	if (ret < 0)
> +		return ret;
> +	freq = clk_get_rate(&clk);
> +#endif
>  	/* calculate prescaler and divisor values */
>  	if ((freq / pres / (16 + 1)) > speed)
>  		/* set prescaler to 512 */
> @@ -67,6 +83,7 @@ static void i2c_ch_init(struct s3c24x0_i2c *i2c, int speed, int slaveadd)
>  	writel(slaveadd, &i2c->iicadd);
>  	/* program Master Transmit (and implicit STOP) */
>  	writel(I2C_MODE_MT | I2C_TXRX_ENA, &i2c->iicstat);
> +	return 0;
>  }
>  
>  #define SYS_I2C_S3C24X0_SLAVE_ADDR	0
> @@ -77,8 +94,9 @@ static int s3c24x0_i2c_set_bus_speed(struct udevice *dev, unsigned int speed)
>  
>  	i2c_bus->clock_frequency = speed;
>  
> -	i2c_ch_init(i2c_bus->regs, i2c_bus->clock_frequency,
> -		    SYS_I2C_S3C24X0_SLAVE_ADDR);
> +	if (i2c_ch_init(dev, i2c_bus->clock_frequency,
> +			SYS_I2C_S3C24X0_SLAVE_ADDR))
> +		return -EFAULT;
>  
>  	return 0;
>  }
> @@ -293,7 +311,9 @@ static int s3c24x0_i2c_xfer(struct udevice *dev, struct i2c_msg *msg,
>  
>  static int s3c_i2c_of_to_plat(struct udevice *dev)
>  {
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	const void *blob = gd->fdt_blob;
> +#endif
>  	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
>  	int node;
>  
> @@ -301,7 +321,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
>  
>  	i2c_bus->regs = dev_read_addr_ptr(dev);
>  
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	i2c_bus->id = pinmux_decode_periph_id(blob, node);
> +#endif
>  
>  	i2c_bus->clock_frequency =
>  		dev_read_u32_default(dev, "clock-frequency",
> @@ -309,7 +331,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
>  	i2c_bus->node = node;
>  	i2c_bus->bus_num = dev_seq(dev);
>  
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	exynos_pinmux_config(i2c_bus->id, 0);
> +#endif
>  
>  	i2c_bus->active = true;
>  
> diff --git a/drivers/i2c/s3c24x0_i2c.h b/drivers/i2c/s3c24x0_i2c.h
> index ec8f1acaef..12249d5c14 100644
> --- a/drivers/i2c/s3c24x0_i2c.h
> +++ b/drivers/i2c/s3c24x0_i2c.h
> @@ -54,7 +54,9 @@ struct s3c24x0_i2c_bus {
>  	struct exynos5_hsi2c *hsregs;
>  	int is_highspeed;	/* High speed type, rather than I2C */
>  	unsigned clock_frequency;
> +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>  	int id;
> +#endif
>  	unsigned clk_cycle;
>  	unsigned clk_div;
>  };
> -- 
> 2.46.0
> 
