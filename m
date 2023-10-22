Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB01CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 22:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B76E877F5;
	Mon, 23 Oct 2023 00:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C993877ED; Mon, 23 Oct 2023 00:41:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9C02B877E9
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EAD2F4;
 Sun, 22 Oct 2023 15:42:06 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA893F738;
 Sun, 22 Oct 2023 15:41:24 -0700 (PDT)
Date: Sun, 22 Oct 2023 23:40:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards
 <cfsworks@gmail.com>, Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 linux-sunxi@lists.linux.dev, andre.przywara@foss.arm.com, Jagan Teki
 <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 16/22] sunxi: add R528/T113-s3/D1(s) DRAM
 initialisation code
Message-ID: <20231022234018.63e249f2@slackpad.lan>
In-Reply-To: <f1fb2b20-2c3a-55a3-a35b-e014a2eebe20@sholland.org>
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-17-andre.przywara@arm.com>
 <f1fb2b20-2c3a-55a3-a35b-e014a2eebe20@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 21 Oct 2023 22:52:06 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> On 9/28/23 16:54, Andre Przywara wrote:
> > The Allwinner R528/T113-s/D1/D1s SoCs all share the same die, so use the
> > same DRAM initialisation code.
> > Make use of prior art here and lift some code from awboot[1], which
> > carried init code based on earlier decompilation efforts, but with a
> > GPL2 license tag.
> > This code has been heavily reworked and cleaned up, to match previous
> > DRAM routines for other SoCs, and also to be closer to U-Boot's coding
> > style and support routines.
> > The actual DRAM chip timing parameters are included in the main file,
> > since they cover all DRAM types, and are protected by a new Kconfig
> > CONFIG_SUNXI_DRAM_TYPE symbol, which allows the compiler to pick only
> > the relevant settings, at build time.
> > 
> > The relevant DRAM chips/board specific configuration parameters are
> > delivered via Kconfig, so this code here should work for all supported
> > SoCs and DRAM chips combinations.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Tested-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  drivers/Makefile                   |    1 +
> >  drivers/ram/Makefile               |    3 +
> >  drivers/ram/sunxi/Kconfig          |   59 ++
> >  drivers/ram/sunxi/Makefile         |    4 +
> >  drivers/ram/sunxi/dram_sun20i_d1.c | 1432 ++++++++++++++++++++++++++++
> >  drivers/ram/sunxi/dram_sun20i_d1.h |   73 ++
> >  6 files changed, 1572 insertions(+)
> >  create mode 100644 drivers/ram/sunxi/Makefile
> >  create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.c
> >  create mode 100644 drivers/ram/sunxi/dram_sun20i_d1.h
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index efc2a4afb24..5a4bedf7305 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_$(SPL_)ALTERA_SDRAM) += ddr/altera/
> >  obj-$(CONFIG_ARCH_IMX8M) += ddr/imx/imx8m/
> >  obj-$(CONFIG_IMX8ULP_DRAM) += ddr/imx/imx8ulp/
> >  obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
> > +obj-$(CONFIG_DRAM_SUN8I_R528) += ram/  
> 
> This would need to be duplicated for DRAM_SUN20I_D1.
> 
> >  obj-$(CONFIG_SPL_DM_RESET) += reset/
> >  obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
> >  obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
> > diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
> > index 6eb1a241359..b4750ea11c4 100644
> > --- a/drivers/ram/Makefile
> > +++ b/drivers/ram/Makefile
> > @@ -23,6 +23,9 @@ obj-$(CONFIG_RAM_SIFIVE) += sifive/
> >  ifdef CONFIG_SPL_BUILD
> >  obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive/
> >  endif
> > +
> > +obj-$(CONFIG_DRAM_SUN8I_R528) += sunxi/  
> 
> This would need to be duplicated for DRAM_SUN20I_D1.

Right, so I joined both symbols into one now. I think I wanted to keep
the DM_RAM and non-DM parts logically apart, but it works nevertheless.

My gut feeling is this needs more adjustments anyway once we need the
DM_RAM or want to extend it to more SoCs, so we can fix things when
they need fixing, later.

> 
> > +
> >  obj-$(CONFIG_ARCH_OCTEON) += octeon/
> >  
> >  obj-$(CONFIG_ARCH_RMOBILE) += renesas/
> > diff --git a/drivers/ram/sunxi/Kconfig b/drivers/ram/sunxi/Kconfig
> > index 261d7f57409..35eeda58efa 100644
> > --- a/drivers/ram/sunxi/Kconfig
> > +++ b/drivers/ram/sunxi/Kconfig
> > @@ -12,3 +12,62 @@ config DRAM_SUN8I_R528
> >  	default y if MACH_SUN8I_R528
> >  	help
> >  	  Select this DRAM controller driver for the R528/T113s SoCs.
> > +
> > +if DRAM_SUN20I_D1 || DRAM_SUN8I_R528
> > +
> > +config DRAM_SUNXI_ODT_EN  
> 
> You have a mixture of "DRAM_SUNXI" and "SUNXI_DRAM" for the tunables
> here. I would recommend being consistent.

This was chosen to stay consistent with the existing DRAM drivers,
which use DRAM_SUNxx_ for parameters, but SUNXI_DRAM_TYPE_ for the type
selection. I was looking into moving the other Allwinner DRAM drivers
into here as well (at least for every future SoC), and tested this with
the H616: keeping the symbols compatible was a requirement.

> 
> > +	hex "DRAM ODT EN parameter"
> > +	default 0x1
> > +	help
> > +	  ODT EN value from vendor DRAM settings.
> > +
> > +config DRAM_SUNXI_TPR0
> > +	hex "DRAM TPR0 parameter"
> > +	default 0x0
> > +	help
> > +	  TPR0 value from vendor DRAM settings.
> > +
> > +config DRAM_SUNXI_TPR11
> > +	hex "DRAM TPR11 parameter"
> > +	default 0x0
> > +	help
> > +	  TPR11 value from vendor DRAM settings.
> > +
> > +config DRAM_SUNXI_TPR12
> > +	hex "DRAM TPR12 parameter"
> > +	default 0x0
> > +	help
> > +	  TPR12 value from vendor DRAM settings.
> > +
> > +config DRAM_SUNXI_TPR13
> > +	hex "DRAM TPR13 parameter"
> > +	default 0x0  
> 
> I would suggest dropping the defaults for these tunables. It was
> non-obvious that I was missing some configuration when I switched to
> your driver. I think it's reasonable to require the defconfig/user to
> provide these.

Yeah, that's a good point. No actual value is 0, so this doesn't even
simplify defconfigs.

> > +	help
> > +	  TPR13 value from vendor DRAM settings. It tells which features
> > +	  should be configured.
> > +
> > +choice
> > +	prompt "DRAM chip type"
> > +	default SUNXI_DRAM_TYPE_DDR3 if DRAM_SUN8I_R528 || DRAM_SUN20I_D1
> > +
> > +config SUNXI_DRAM_TYPE_DDR2
> > +        bool "DDR2 chips"
> > +
> > +config SUNXI_DRAM_TYPE_DDR3
> > +        bool "DDR3 chips"
> > +
> > +config SUNXI_DRAM_TYPE_LPDDR2
> > +        bool "LPDDR2 chips"
> > +
> > +config SUNXI_DRAM_TYPE_LPDDR3
> > +        bool "LPDDR3 chips"
> > +endchoice
> > +
> > +config SUNXI_DRAM_TYPE
> > +	int
> > +	default 2 if SUNXI_DRAM_TYPE_DDR2
> > +	default 3 if SUNXI_DRAM_TYPE_DDR3
> > +	default 6 if SUNXI_DRAM_TYPE_LPDDR2
> > +	default 7 if SUNXI_DRAM_TYPE_LPDDR3
> > +
> > +endif
> > diff --git a/drivers/ram/sunxi/Makefile b/drivers/ram/sunxi/Makefile
> > new file mode 100644
> > index 00000000000..d6fb2cf0b65
> > --- /dev/null
> > +++ b/drivers/ram/sunxi/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +obj-$(CONFIG_DRAM_SUN20I_D1) += dram_sun20i_d1.o
> > +obj-$(CONFIG_DRAM_SUN8I_R528) += dram_sun20i_d1.o
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
> > new file mode 100644
> > index 00000000000..c766fc24065
> > --- /dev/null
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > @@ -0,0 +1,1432 @@
> > [...]
> > +/*
> > + * This routine sizes a DRAM device by cycling through address lines and
> > + * figuring out if they are connected to a real address line, or if the
> > + * address is a mirror.
> > + * First the column and bank bit allocations are set to low values (2 and 9
> > + * address lines). Then a maximum allocation (16 lines) is set for rows and
> > + * this is tested.
> > + * Next the BA2 line is checked. This seems to be placed above the column,
> > + * BA0-1 and row addresses. Finally, the column address is allocated 13 lines
> > + * and these are tested. The results are placed in dram_para1 and dram_para2.
> > + */
> > +static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
> > +{
> > +	unsigned int rval, i, j, rank, maxrank, offs;
> > +	unsigned int shft;
> > +	unsigned long ptr, mc_work_mode, chk;  
> 
> This breaks on 64-bit architectures, because readl(chk) can never equal
> ~ptr. Please change ptr and chk to unsigned int.

I think they were originally ints (at least I see it like this is an
earlier version), but I changed it to make "ptr" a pointer compatible
type.
Definitely "chk" is only used as a pointer, so should be long (or
uintptr_t).
The actual problem is that "ptr" is used both as a pointer *and* a
payload, which is odd. I will keep ptr long, but make sure to
write only a true 32 bit payload into the address it points to.

> 
> > +
> > +	if (mctl_core_init(para, config) == 0) {
> > +		printf("DRAM initialisation error : 0\n");
> > +		return 0;
> > +	}
> > +
> > +	maxrank	= (config->dram_para2 & 0xf000) ? 2 : 1;
> > +	mc_work_mode = 0x3102000;
> > +	offs = 0;
> > +
> > +	/* write test pattern */
> > +	for (i = 0, ptr = CFG_SYS_SDRAM_BASE; i < 64; i++, ptr += 4)
> > +		writel((i & 0x1) ? ptr : ~ptr, ptr);
> > +
> > +	for (rank = 0; rank < maxrank;) {
> > +		/* set row mode */
> > +		clrsetbits_le32(mc_work_mode, 0xf0c, 0x6f0);
> > +		udelay(1);
> > +
> > +		// Scan per address line, until address wraps (i.e. see shadow)
> > +		for (i = 11; i < 17; i++) {
> > +			chk = CFG_SYS_SDRAM_BASE + (1U << (i + 11));
> > +			ptr = CFG_SYS_SDRAM_BASE;
> > +			for (j = 0; j < 64; j++) {
> > +				if (readl(chk) != ((j & 1) ? ptr : ~ptr))
> > +					break;
> > +				ptr += 4;
> > +				chk += 4;
> > +			}
> > +			if (j == 64)
> > +				break;
> > +		}
> > +		if (i > 16)
> > +			i = 16;
> > +		debug("rank %d row = %d\n", rank, i);
> > +
> > +		/* Store rows in para 1 */
> > +		shft = offs + 4;
> > +		rval = config->dram_para1;
> > +		rval &= ~(0xff << shft);
> > +		rval |= i << shft;
> > +		config->dram_para1 = rval;
> > +
> > +		if (rank == 1)		/* Set bank mode for rank0 */
> > +			clrsetbits_le32(0x3102000, 0xffc, 0x6a4);
> > +
> > +		/* Set bank mode for current rank */
> > +		clrsetbits_le32(mc_work_mode, 0xffc, 0x6a4);
> > +		udelay(1);
> > +
> > +		// Test if bit A23 is BA2 or mirror XXX A22?
> > +		chk = CFG_SYS_SDRAM_BASE + (1U << 22);
> > +		ptr = CFG_SYS_SDRAM_BASE;
> > +		for (i = 0, j = 0; i < 64; i++) {
> > +			if (readl(chk) != ((i & 1) ? ptr : ~ptr)) {
> > +				j = 1;
> > +				break;
> > +			}
> > +			ptr += 4;
> > +			chk += 4;
> > +		}
> > +
> > +		debug("rank %d bank = %d\n", rank, (j + 1) << 2); /* 4 or 8 */
> > +
> > +		/* Store banks in para 1 */
> > +		shft = 12 + offs;
> > +		rval = config->dram_para1;
> > +		rval &= ~(0xf << shft);
> > +		rval |= j << shft;
> > +		config->dram_para1 = rval;
> > +
> > +		if (rank == 1)		/* Set page mode for rank0 */
> > +			clrsetbits_le32(0x3102000, 0xffc, 0xaa0);
> > +
> > +		/* Set page mode for current rank */
> > +		clrsetbits_le32(mc_work_mode, 0xffc, 0xaa0);
> > +		udelay(1);
> > +
> > +		// Scan per address line, until address wraps (i.e. see shadow)
> > +		for (i = 9; i < 14; i++) {
> > +			chk = CFG_SYS_SDRAM_BASE + (1U << i);
> > +			ptr = CFG_SYS_SDRAM_BASE;
> > +			for (j = 0; j < 64; j++) {
> > +				if (readl(chk) != ((j & 1) ? ptr : ~ptr))
> > +					break;
> > +				ptr += 4;
> > +				chk += 4;
> > +			}
> > +			if (j == 64)
> > +				break;
> > +		}
> > +		if (i > 13)
> > +			i = 13;
> > +
> > +		unsigned int pgsize = (i == 9) ? 0 : (1 << (i - 10));
> > +		debug("rank %d page size = %d KB\n", rank, pgsize);
> > +
> > +		/* Store page size */
> > +		shft = offs;
> > +		rval = config->dram_para1;
> > +		rval &= ~(0xf << shft);
> > +		rval |= pgsize << shft;
> > +		config->dram_para1 = rval;
> > +
> > +		// Move to next rank
> > +		rank++;
> > +		if (rank != maxrank) {
> > +			if (rank == 1) {
> > +				/* MC_WORK_MODE */
> > +				clrsetbits_le32(0x3202000, 0xffc, 0x6f0);
> > +
> > +				/* MC_WORK_MODE2 */
> > +				clrsetbits_le32(0x3202004, 0xffc, 0x6f0);
> > +			}
> > +			/* store rank1 config in upper half of para1 */
> > +			offs += 16;
> > +			mc_work_mode += 4;	/* move to MC_WORK_MODE2 */
> > +		}
> > +	}
> > +	if (maxrank == 2) {
> > +		config->dram_para2 &= 0xfffff0ff;
> > +		/* note: rval is equal to para->dram_para1 here */
> > +		if ((rval & 0xffff) == (rval >> 16)) {
> > +			debug("rank1 config same as rank0\n");
> > +		} else {
> > +			config->dram_para2 |= BIT(8);
> > +			debug("rank1 config different from rank0\n");
> > +		}
> > +	}
> > +
> > +	return 1;
> > +}
> > [...]
> > +static int sunxi_ram_probe(struct udevice *dev)
> > +{
> > +	struct sunxi_ram_priv *priv = dev_get_priv(dev);
> > +	unsigned long dram_size;
> > +
> > +	debug("%s: %s: probing\n", __func__, dev->name);
> > +
> > +	dram_size = sunxi_dram_init();
> > +	if (!dram_size) {
> > +		printf("DRAM init failed: %d\n", ret);  
> 
> There is no ret variable anymore, so this fails to compile. With this
> line and the variable size issue fixed, this driver works on my Nezha
> board, so with those fixes:

Ah, right, thanks for the heads up. I think I had some trick to compile
test this code once, but didn't use it since last year.

> Tested-by: Samuel Holland <samuel@sholland.org>

Thanks!
Andre

P.S. This driver has a lot of rough edges anyway (the whole
clock/"system" setup side, for a start), but we should get things
moving now, before the RFC version celebrates its first birthday. So I
will merge it, but am happy to take fixes: either cleanups, or fixes
for the D1.

> > +		return -ENODEV;
> > +	}
> > +
> > +	priv->size = dram_size;
> > +
> > +	return 0;
> > +}  
> 

