Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F224C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC328606CC;
	Wed, 29 Jul 2026 12:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 626zMf-9LdR5; Wed, 29 Jul 2026 12:16:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C876C607B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785327383;
	bh=DkjMl4yrLW6nYKEJWALll1mZEPpRtthKZn2RafiuXUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGA1nKcRiPPPJ1IrGFERkTiCMmNWXp/xQwtQUKUlwH67nJOMB2Mnz4AcFN7AsvxSl
	 ACMBD8y//atTo2iFd+y9w/nICXTip4rF6QGO7HrgHbAfsUiCbs37FxAqRZLH+UIARq
	 PuoRAlKgVCNXlUuSdp0NzVH9mFD8gMOq5Txu6yxuWyN9GDEEK0Zs3KD+aAvCKDhj2w
	 15J0mfkvGVRQQfdAwSH66s8Gx6zCSHyz6UwdPQMEPEx5zeSEhxxt4Bn9/cPvfnP1Rq
	 0iI9TsZIYy61DIS3JMC9EoxWdtPZTjZ0bHTKDKAwgfX5l04AEigWnb1vPpYoywwt62
	 NH7XP4tcNvnIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C876C607B7;
	Wed, 29 Jul 2026 12:16:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EFA37350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4FC24085E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z3kvTVWCuk7L for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:16:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DFB404084F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFB404084F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFB404084F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:16:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B74E8493F; Wed, 29 Jul 2026 14:16:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A732D82991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:16:15 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A5A044E6B;
 Wed, 29 Jul 2026 12:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F7C1F00A3A;
 Wed, 29 Jul 2026 12:16:13 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Anders Roxell <anders.roxell@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>
Subject: Re: [PATCH v5 67/75] usb: dwc3: make the core driver build in u-boot
In-Reply-To: <20260716134305.614278-68-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-68-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 14:16:11 +0200
Message-ID: <87h5lixa7o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785327374;
 bh=DkjMl4yrLW6nYKEJWALll1mZEPpRtthKZn2RafiuXUE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=WOcn+JKswIxD+9VlVSHxB5tBzumAV80ULmg89wEMKsaJLNy5lqTrdKqaQuAKQEGQS
 Vh8Lz+XAZ/2KPogO4ctw26XFpIgOYfBriC+GPlbiNrHy26y1l/kbo3ok6KNfocEkvt
 n2I/cNjL5M1AmDLsm73tZ3RmpJleJcQdx04Gu/MahQqZU+nGB7Uy3lM6U4hPvOI54Q
 G2mlerP7p7carryildSIolbkfmCb843wKliUnyVtYQ5YK4IpeG6+JHqFVnOV15pi5I
 8Mo63t1ut7zaeqzTBH+O3ld99wZe4JZb8QubxdhjwRGEgMEDrSBV6qcBzuuHxCpivZ
 VlOTFPpnddPgg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WOcn+JKs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WOcn+JKs"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> Adapt the DWC3 core files to u-boot: core, io, Makefile and the omap and
> ti phy glue.

A summary of the core changes could be helpful here to guide the
reviewers. It's a big patch so giving some details is definitely
welcome.

I've seen a a couple of changes that soeem relevant:
* rename from struct device -> struct udevice
* use generic_phy_init() instead of phy_init()


I also see some weird things, which require an explanation:
* We dropped dwc3_clk_enable() but we kept dwc3_clk_disable()
* Some functions moved place without any reason (I can see at least)

Please see some more comments below

>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/dwc3/Makefile     |   57 +-
>  drivers/usb/dwc3/core.c       | 1761 ++++++++-------------------------
>  drivers/usb/dwc3/core.h       |   39 +-
>  drivers/usb/dwc3/dwc3-omap.c  |    2 -
>  drivers/usb/dwc3/io.h         |   28 +-
>  drivers/usb/dwc3/ti_usb_phy.c |    2 -
>  6 files changed, 464 insertions(+), 1425 deletions(-)
>
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index a619cd374fb4..6700ea93eae0 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -1,18 +1,59 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -
> +# SPDX-License-Identifier: GPL-2.0

Why the licence change?

>  obj-$(CONFIG_USB_DWC3)			+= dwc3.o
>  
>  dwc3-y					:= core.o
>  
> -obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
> +ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
> +	dwc3-y				+= host.o

There is no host.c in drivers/usb/dwc3/
This conditional can be dropped

> +endif
> +
> +ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
> +	dwc3-y				+= gadget.o ep0.o
> +endif
> +
> +ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
> +	dwc3-y				+= drd.o
> +endif

There is no drd.c in drivers/usb/dwc3/
This conditional can be dropped

> +
> +ifneq ($(CONFIG_USB_DWC3_ULPI),)
> +	dwc3-y				+= ulpi.o
> +endif

There is no ulpi.c in drivers/usb/dwc3/
This conditional can be dropped

> +
> +ifneq ($(CONFIG_DEBUG_FS),)
> +	dwc3-y				+= debugfs.o
> +endif

There is no debugfs.c in drivers/usb/dwc3/
This conditional can be dropped

> +
> +##
> +# Platform-specific glue layers go here
> +#
> +# NOTICE: Make sure your glue layer doesn't depend on anything
> +# which is arch-specific and that it compiles on all situations.
> +#
> +# We want to keep this requirement in order to be able to compile
> +# the entire driver (with all its glue layers) on several architectures
> +# and make sure it compiles fine. This will also help with allmodconfig
> +# and allyesconfig builds.
> +##
>  
> -obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
> +obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)		+= dwc3-am62.o
>  obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
> +obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
> +obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)	+= dwc3-generic.o
> +obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
> +obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
> +obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
> +obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
> +obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
> +obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
>  obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
>  obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
> -obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
> +obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
> +obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
> +obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
> +obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom-legacy.o
> +obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
> +obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
>  obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
> -obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
> +obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
>  obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
> -obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
> -obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
> +obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o


There is no dwc3-pci.c or dwc3-keystone.c in drivers/usb/dwc3 since we
did not import these drivers.

Please clean up the Makefile to omit all the platform-specific glues
that are not part of U-Boot.


> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 8002c23a5a02..5b6004a54d9b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -8,104 +8,40 @@
>   *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>   */
>  
> -#include <linux/clk.h>
> -#include <linux/version.h>
> -#include <linux/module.h>

[...]

>  }
>  
>  /**
> @@ -490,18 +286,19 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
>  {
>  	struct dwc3_event_buffer	*evt;
>  
> -	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
> +	evt = devm_kzalloc((struct udevice*)dwc->dev, sizeof(*evt), GFP_KERNEL);

checkpatch.pl complains about this:

ERROR: "(foo*)" should be "(foo *)"
#387: FILE: drivers/usb/dwc3/core.c:289:
+       evt = devm_kzalloc((struct udevice*)dwc->dev, sizeof(*evt), GFP_KERNEL);


>  	if (!evt)
>  		return ERR_PTR(-ENOMEM);
>  
>  	evt->dwc	= dwc;
>  	evt->length	= length;
> -	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
> +	evt->cache	= devm_kzalloc((struct udevice *)dwc->dev, length,
> +				       GFP_KERNEL);
>  	if (!evt->cache)
>  		return ERR_PTR(-ENOMEM);
>  
> -	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
> -			&evt->dma, GFP_KERNEL);

[...]

>  
>  static int dwc3_core_init_mode(struct dwc3 *dwc)
>  {
> -	struct device *dev = dwc->dev;
> +	struct udevice *dev = dwc->dev;
>  	int ret;
>  	int i;
>  
> @@ -1607,8 +1278,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_PERIPHERAL:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
>  		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>  
> @@ -1619,8 +1288,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_HOST:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, true);
>  		for (i = 0; i < dwc->num_usb2_ports; i++)
>  			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>  		for (i = 0; i < dwc->num_usb3_ports; i++)
> @@ -1644,6 +1311,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	return 0;
>  }
>  
> +static void dwc3_core_stop(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> +	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
> +}
> +
>  static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  {
>  	switch (dwc->dr_mode) {
> @@ -1665,46 +1340,109 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
>  }
>  
> -static void dwc3_get_software_properties(struct dwc3 *dwc)
> +#define DWC3_ALIGN_MASK		(16 - 1)

This is used way further below, so why does it gets defined in the
middle of the code?

> +
> +
> +/* check whether the core supports IMOD */
> +bool dwc3_has_imod(struct dwc3 *dwc)

Looking further down in this patch, I see that this function used to
exist already.

Why are we moving it here?
It makes this patch much harder to review for correctness.

Please try to keep the diff to a minimum and justify moving functions
around or do them in preparatory patches before this one.

>  {
> -	struct device *tmpdev;
> -	u16 gsbuscfg0_reqinfo;
> -	int ret;
> +	return DWC3_VER_IS_WITHIN(DWC3, 300A, ANY) ||
> +		DWC3_VER_IS_WITHIN(DWC31, 120A, ANY) ||
> +		DWC3_IP_IS(DWC32);
> +}
>  
> -	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
> +static int dwc3_get_num_ports(struct dwc3 *dwc)
> +{
> +	void __iomem *base;
> +	u8 major_revision;
> +	u32 offset;
> +	u32 val;
>  
>  	/*
> -	 * Iterate over all parent nodes for finding swnode properties
> -	 * and non-DT (non-ABI) properties.
> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> +	 * needed to get information on number of ports present.
>  	 */
> -	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
> -		ret = device_property_read_u16(tmpdev,
> -					       "snps,gsbuscfg0-reqinfo",
> -					       &gsbuscfg0_reqinfo);
> -		if (!ret)
> -			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
> -	}
> +	base = ioremap(dwc->xhci_resources[0].start,
> +		       resource_size(&dwc->xhci_resources[0]));
> +	if (!base)
> +		return -ENOMEM;
> +
> +	offset = 0;
> +	do {
> +		offset = xhci_find_next_ext_cap(base, offset,
> +						XHCI_EXT_CAPS_PROTOCOL);
> +		if (!offset)
> +			break;
> +
> +		val = readl(base + offset);
> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
> +
> +		val = readl(base + offset + 0x08);
> +		if (major_revision == 0x03) {
> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else if (major_revision <= 0x02) {
> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else {
> +			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
> +				 major_revision);
> +		}
> +	} while (1);
> +
> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
> +		dwc->num_usb2_ports, dwc->num_usb3_ports);
> +
> +	iounmap(base);
> +
> +	if (dwc->num_usb2_ports > DWC3_USB2_MAX_PORTS ||
> +	    dwc->num_usb3_ports > DWC3_USB3_MAX_PORTS)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
> -static void dwc3_get_properties(struct dwc3 *dwc)
> +#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
> +int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
>  {
> -	struct device		*dev = dwc->dev;
> -	u8			lpm_nyet_threshold;
> -	u8			tx_de_emphasis;
> -	u8			hird_threshold;
> -	u8			rx_thr_num_pkt = 0;
> -	u8			rx_max_burst = 0;
> -	u8			tx_thr_num_pkt = 0;
> -	u8			tx_max_burst = 0;
> -	u8			rx_thr_num_pkt_prd = 0;
> -	u8			rx_max_burst_prd = 0;
> -	u8			tx_thr_num_pkt_prd = 0;
> -	u8			tx_max_burst_prd = 0;
> -	u8			tx_fifo_resize_max_num;
> -	u16			num_hc_interrupters;
> +	int ret;
> +
> +	ret = generic_phy_get_bulk(dev, phys);
> +	if (ret)
> +		return ret;
> +
> +	ret = generic_phy_init_bulk(phys);
> +	if (ret)
> +		return ret;
> +
> +	ret = generic_phy_power_on_bulk(phys);
> +	if (ret)
> +		generic_phy_exit_bulk(phys);
> +
> +	return ret;
> +}
> +
> +int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
> +{
> +	int ret;
> +
> +	ret = generic_phy_power_off_bulk(phys);
> +	ret |= generic_phy_exit_bulk(phys);
> +	return ret;
> +}
> +#endif
> +
> +#if CONFIG_IS_ENABLED(DM_USB)
> +void dwc3_of_parse(struct dwc3 *dwc)
> +{
> +	const u8 *tmp;
> +	struct udevice *dev = dwc->dev;
> +	u8 lpm_nyet_threshold;
> +	u8 tx_de_emphasis;
> +	u8 hird_threshold;
> +	u32 val;
> +	int i;
>  
>  	/* default to highest possible threshold */
> -	lpm_nyet_threshold = 0xf;
> +	lpm_nyet_threshold = 0xff;

Why this change? Are we fixing a bug?

>  
>  	/* default to -3.5dB de-emphasis */
>  	tx_de_emphasis = 1;
> @@ -1715,538 +1453,89 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	 */
>  	hird_threshold = 12;
>  
> -	/*
> -	 * default to a TXFIFO size large enough to fit 6 max packets.  This
> -	 * allows for systems with larger bus latencies to have some headroom
> -	 * for endpoints that have a large bMaxBurst value.
> -	 */

[...]
