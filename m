Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A184ECCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 19:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC25D836B4;
	Sat, 18 Oct 2025 21:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="TKLQXKeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711D9836D1; Sat, 18 Oct 2025 21:25:49 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0352D83631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 21:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sat, 18 Oct 2025 21:25:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1760815545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHk4FJVg8XZlEpymKE/zUDpx3gBFxjuLWN8x4VOeZCc=;
 b=TKLQXKePFrMl6jZopfQnsZZt4FN8NqNiVRslyJvAunXsB5mewDO8vkar0XmEiQAMwbc7Gz
 YWd3ni023NZ0OLz84tOlXQ0tek4e6yzZAlBoH19Wd/PbrwMIkZcFsCvGFpdyGf3x+wFB5q
 kSq0Qh6XAF/oQplBOyYl8YVEM0dVXyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>
Subject: Re: [PATCH] board: samsung: add support for Samsung Exynos mobile
 device board
Message-ID: <20251018192539.GA5922@l14.localdomain>
References: <20251017-board-exynos-mobile-v1-1-55f47dd52fc7@disroot.org>
 <20251017201936.GA13076@l14.localdomain>
 <b6408b1d32a4986622145c1517ec3ae3@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6408b1d32a4986622145c1517ec3ae3@disroot.org>
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

Hi Kaustabh,

On Sat, Oct 18, 2025 at 06:04:35PM +0000, Kaustabh Chakraborty wrote:
> On 2025-10-17 20:19, Henrik Grimler wrote:
> > Hi Kaustabh,
> > 
> > Nice work on all of the linked patches!
> > 
> > On Fri, Oct 17, 2025 at 10:07:35PM +0530, Kaustabh Chakraborty wrote:
> > > Add support for a generic platform which intends to support multiple
> > > boards powerid by Samsung Exynos SoCs. This patch also includes
> > > initial
> > > support for three boards:
> > > * Samsung Galaxy A2 Core
> > > * Samsung Galaxy J6
> > > * Samsung Galaxy J7 Prime
> > 
> > I think it would be easier to review this if you split the patch in two
> > parts: first adding docs and common parts, and then the specific parts
> > for exynos7870 and these devices.
> > 
> > > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> > > ---
> > > This patch has the following dependencies:
> > > (NOTE: `x` indicates applied)
> > > 
> > > armv8-broken-cntfrq		- https://patch.msgid.link/20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org
> > > clk-exynos7870			- https://patch.msgid.link/20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org
> > > gpio-s5p-bank-fix		- https://patch.msgid.link/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org
> > > i2c-hs-exynos7			- https://patch.msgid.link/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
> > > mmc-dw-exynos7870		- https://patch.msgid.link/20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org
> > > phy-usb-exynos7870		- https://patch.msgid.link/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org
> > > pinctrl-exynos7870		- https://patch.msgid.link/20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org
> > > power-pmic-regulator-s2mpu05	- https://patch.msgid.link/20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org
> > > serial-s5p-exynos8895		- https://patch.msgid.link/20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org
> > > soc-pmu-exynos7			- https://patch.msgid.link/20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org
> > > usb-dwc3-exynos7870		- https://patch.msgid.link/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org
> > > ---
> > >  arch/arm/mach-exynos/Kconfig                       |  11 +-
> > >  board/samsung/exynos-mobile/Kconfig                |  18 +
> > >  board/samsung/exynos-mobile/MAINTAINERS            |   6 +
> > >  board/samsung/exynos-mobile/Makefile               |   5 +
> > >  .../samsung/exynos-mobile/debug-exynos7870.config  |   7 +
> > >  board/samsung/exynos-mobile/exynos-mobile.c        | 372
> > > +++++++++++++++++++++
> > >  board/samsung/exynos-mobile/exynos-mobile.env      |  18 +
> > >  configs/exynos-mobile_defconfig                    |  71 ++++
> > >  doc/board/samsung/exynos-mobile.rst                | 112 +++++++
> > >  doc/board/samsung/index.rst                        |   1 +
> > >  include/configs/exynos-mobile.h                    |  14 +
> > >  11 files changed, 634 insertions(+), 1 deletion(-)
> > 
> > [ skipping to docs for now ]
> > 
> > > diff --git a/doc/board/samsung/exynos-mobile.rst
> > > b/doc/board/samsung/exynos-mobile.rst
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..6390c66ffc38a41f01cb51c7406397cfc5a3d223
> > > --- /dev/null
> > > +++ b/doc/board/samsung/exynos-mobile.rst
> > > @@ -0,0 +1,112 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +.. sectionauthor:: Kaustabh Chakraborty <kauschluss@disroot.org>
> > > +
> > > +Samsung Exynos Generic Boards (for mobile devices)
> > > +==================================================
> > > +
> > > +Overview
> > > +--------
> > > +This document describes how to build and run U-Boot for Samsung
> > > Exynos generic
> > > +boards. Boards are expected to boot with a primary bootloader, such
> > > as S-BOOT or
> > > +S-LK, which hands off control to U-Boot, disguised as an Android
> > > boot image.
> > 
> > In my opinion exynos-mobile is a bit too generic. From the docs here
> > it seems plan is to support devices that support android boot images
> > with dt in Samsung's qcdt format. The oldest Exynos mobile device do
> > not even support boot images though, and dt images has only been
> > around since something like 2015. If I am not mistaken the newest
> > devices also does not use dt images.
> 
> Well no, any Exynos would be supported by this variant, the only

Ok, any Exynos, then `disguised as an Android boot image` should be
rephrased, as not all Exynos'es support boot images. Next paragraph
should be updated as well.

> factor is that U-Boot is used as a *secondary* boot loader. QCDT is
> specific to the packaging of the u-boot binary (that too, is
> located under a 7870-specific section), and if there are any other
> packing methods, they can be documented here as well.
> 
> That being said, I've found 'exynos-mobile' to be most appropriate
> (This is for mobile devices like phones and tablets, where we have
> a proprietary primary boot loader). But if you have suggestions for
> better names, let me know. :)

Sure, if any Exynos is supported, then exynos-mobile is fine. 

> > > +U-Boot is packed with multiple FDTs since it targets multiple
> > > boards. The
> > > +appropriate FDT is selected during boot. Additionally, a DTB is
> > > also required
> > > +for embedding in the Android boot image. The previous bootloader
> > > can apply
> > > +useful overlays on it. Both DTBs are consulted for figuring out the
> > > memory
> > > +layout.

Not all Exynos'es have bootloaders that support boot images, and among
the ones that do, not all support dtbs. Please move to 7870 specific
section and/or make the paragraph more generic if it should support
any Exynos.

> > 
> > > +Installation
> > > +------------
> > > +Building
> > > +^^^^^^^^
> > > +To buiid U-Boot, run the following commands
> > 
> > Typo, buiid -> build
> > 
> > > +.. prompt:: bash $
> > > +
> > > +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output
> > > exynos-mobile_defconfig
> > > +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
> > 
> > I think CROSS_COMPILE=aarch64-linux-gnu- can be dropped from the
> > example, or are only
> > aarch64 devices supported?
> 
> Plans were for aarch64. But if its possible to add armv7 support, then
> that would be great! Is multiple arch-es for the same board possible?

Probably not, but not all Exynos'es are armv8, so if instructions
should be for any Exynos then I think it is best to leave $arch out of
the commands.

Best regards,
Henrik Grimler

> > > +If succcessful, the U-Boot binary will be present in
> > > ``.output/u-boot.bin``.
> > 
> > Typo, succcessful -> successful.
> > 
> > > +
> > > +Preparation
> > > +^^^^^^^^^^^
> > > +The U-Boot binary is not flashable as-is, it needs to be
> > > encapsulated in an
> > > +Android boot image. Since it supports multiple boards, and devices
> > > have
> > > +different requirements (thanks to the lack of standards), this step
> > > varies
> > 
> > I think `(thanks to the lack of standards)` is a bit opinionated, and
> > does not really add anything here, could you please remove it?
> 
> I agree. Will remove it.
> 
> > 
> > > +depending on your target.
> > > +
> > > +Exynos 7870 Boards
> > > +""""""""""""""""""
> > > +Create the following devicetree (named ``stub.dts``)
> > > +
> > > +.. code-block:: devicetree
> > > +
> > > +	/dts-v1/;
> > > +
> > > +	/ {
> > > +		compatible = "samsung,exynos7870";
> > > +		#address-cells = <2>;
> > > +		#size-cells = <1>;
> > > +
> > > +		model_info-chip = <7870>;
> > > +		model_info-hw_rev = <0>;
> > > +		model_info-hw_rev_end = <255>;
> > > +
> > > +		chosen {
> > > +		};
> > > +
> > > +		memory@80000000 {
> > > +			device_type = "memory";
> > > +			reg = <0x0 0x80000000 0x0>;
> > > +		};
> > > +
> > > +		memory@100000000 {
> > > +			device_type = "memory";
> > > +			reg = <0x1 0x00000000 0x0>;
> > > +		};
> > > +	};
> > > +
> > > +The chosen node and memory ranges are populated by S-BOOT.
> > > +
> > > +Compile it to a devicetree blob, then use ``dtbTool-exynos`` in
> > > order to pack it
> > > +in the QCDT format [1]_, using the following commands:
> > > +
> > > +.. prompt:: bash $
> > > +
> > > +	dtc -I dts -O dtb -o stub.dtb stub.dts
> > > +	dtbTool-exynos -o stub.dt.img stub.dtb
> > > +
> > > +Finally, use mkbootimg by osm0sis [2]_ to generate the boot image:
> > > +
> > > +.. prompt:: bash $
> > > +
> > > +	mkbootimg -o u-boot.img \
> > > +		--kernel	.output/u-boot.bin \
> > > +		--dt		stub.dt.img
> > > +
> > > +Offsets are not provided to ``mkbootimg`` as S-BOOT ignores them.
> > > +
> > > +Flashing
> > > +^^^^^^^^
> > > +If flashing for the first time, it must be done via Samsung's
> > > Download (Odin)
> > > +mode. Heimdall can be used for flashing, like so:
> > 
> > Maybe it would be useful to link to Heimdall in references as well.
> > 
> > Best regards,
> > Henrik Grimler
> > 
> > > +.. prompt:: bash $
> > > +
> > > +	heimdall flash --BOOT u-boot.img
> > > +
> > > +However, if U-Boot is already installed, you may also use its
> > > fastboot interface
> > > +for flashing. Boot into the boot menu by holding the volume down
> > > key. Enable
> > > +fastboot mode from there, connect the device to your host, then run:
> > > +
> > > +.. prompt:: bash $
> > > +
> > > +	fastboot flash boot u-boot.img
> > > +
> > > +To flash an OS image in internal storage, fastboot is a reliable
> > > option.
> > > +
> > > +References
> > > +----------
> > > +.. [1] https://wiki.postmarketos.org/wiki/QCDT
> > > +.. [2] https://github.com/osm0sis/mkbootimg
> > > diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
> > > index 1b92c9518a57df102c2b64ff934b460548ce3d53..1fbe88130c049e1a33d22ae9230fb60ddccea131
> > > 100644
> > > --- a/doc/board/samsung/index.rst
> > > +++ b/doc/board/samsung/index.rst
> > > @@ -8,4 +8,5 @@ Samsung
> > > 
> > >     axy17lte
> > >     e850-96
> > > +   exynos-mobile
> > >     n1
> > > diff --git a/include/configs/exynos-mobile.h
> > > b/include/configs/exynos-mobile.h
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..862db5779ef4c9ff7f53bef78d7cee5107b7226e
> > > --- /dev/null
> > > +++ b/include/configs/exynos-mobile.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Samsung Exynos Generic Board Configuration (for mobile devices)
> > > + *
> > > + * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
> > > + */
> > > +
> > > +#ifndef __CONFIG_EXYNOS_MOBILE_H
> > > +#define __CONFIG_EXYNOS_MOBILE_H
> > > +
> > > +#define CPU_RELEASE_ADDR	secondary_boot_addr
> > > +#define CFG_SYS_BAUDRATE_TABLE	{9600, 115200}
> > > +
> > > +#endif /* __CONFIG_EXYNOS_MOBILE_H */
> > > 
> > > ---
> > > base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> > > change-id: 20251017-board-exynos-mobile-7c7d43832693
> > > 
> > > Best regards,
> > > --
> > > Kaustabh Chakraborty <kauschluss@disroot.org>
> > > 
