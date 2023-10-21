Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85985C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 23:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A636875AF;
	Sun, 22 Oct 2023 01:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59889875AF; Sun, 22 Oct 2023 01:29:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1ABCA8758F
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 01:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10675C15;
 Sat, 21 Oct 2023 16:29:53 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B663F64C;
 Sat, 21 Oct 2023 16:29:10 -0700 (PDT)
Date: Sun, 22 Oct 2023 00:27:59 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards
 <cfsworks@gmail.com>, Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 linux-sunxi@lists.linux.dev, andre.przywara@foss.arm.com, Jagan Teki
 <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 01/22] sunxi: remove CONFIG_SATAPWR
Message-ID: <20231022002759.1608c5c3@slackpad.lan>
In-Reply-To: <9ee155e3-7bd0-ed70-b4b7-33f4760a507c@sholland.org>
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-2-andre.przywara@arm.com>
 <9ee155e3-7bd0-ed70-b4b7-33f4760a507c@sholland.org>
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

On Thu, 19 Oct 2023 18:51:30 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

thanks for having a look!

> On 9/28/23 16:54, Andre Przywara wrote:
> > The CONFIG_SATAPWR Kconfig symbol was used to point to a GPIO that
> > enables the power for a SATA harddisk.
> > In the DT this is described with the target-supply property in the AHCI
> > DT node, pointing to a (GPIO controlled) regulator. Since we need SATA
> > only in U-Boot proper, and use a DM driver for AHCI there, we should use
> > the DT instead of hardcoding this.
> > 
> > Add code to the sunxi AHCI driver to check the DT for that regulator and
> > enable it, at probe time. Then drop the current code from board.c, which
> > was doing that job before.
> > This allows us to remove the SATAPWR Kconfig definition and the
> > respective values from the defconfigs.
> > We also select the generic fixed regulator driver, which handles those
> > GPIO controlled regulators.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  arch/arm/Kconfig                             |  2 ++
> >  arch/arm/mach-sunxi/Kconfig                  |  8 --------
> >  board/sunxi/board.c                          | 16 +---------------
> >  configs/A10-OLinuXino-Lime_defconfig         |  1 -
> >  configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
> >  configs/A20-OLinuXino-Lime2_defconfig        |  1 -
> >  configs/A20-OLinuXino-Lime_defconfig         |  1 -
> >  configs/A20-OLinuXino_MICRO-eMMC_defconfig   |  1 -
> >  configs/A20-OLinuXino_MICRO_defconfig        |  1 -
> >  configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
> >  configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
> >  configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
> >  configs/Cubieboard2_defconfig                |  1 -
> >  configs/Cubieboard_defconfig                 |  1 -
> >  configs/Cubietruck_defconfig                 |  1 -
> >  configs/Itead_Ibox_A20_defconfig             |  1 -
> >  configs/Lamobo_R1_defconfig                  |  1 -
> >  configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
> >  configs/Linksprite_pcDuino3_defconfig        |  1 -
> >  configs/Sinovoip_BPI_M3_defconfig            |  1 -
> >  configs/orangepi_plus_defconfig              |  2 +-
> >  drivers/ata/ahci_sunxi.c                     |  9 +++++++++
> >  22 files changed, 13 insertions(+), 41 deletions(-)
> > 
> > [...]
> > diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
> > index 76de72aa228..ed585881d49 100644
> > --- a/configs/orangepi_plus_defconfig
> > +++ b/configs/orangepi_plus_defconfig
> > @@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=672
> >  CONFIG_MACPWR="PD6"
> >  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> >  CONFIG_USB1_VBUS_PIN="PG13"
> > -CONFIG_SATAPWR="PG11"
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_SPL_I2C=y
> >  CONFIG_SPL_SYS_I2C_LEGACY=y
> > @@ -16,3 +15,4 @@ CONFIG_SUN8I_EMAC=y
> >  CONFIG_SY8106A_POWER=y
> >  CONFIG_USB_EHCI_HCD=y
> >  CONFIG_USB_OHCI_HCD=y
> > +CONFIG_USB3_VBUS_PIN="PG11"  
> 
> This change is unrelated to the purpose of this commit.

I added this line after your suggestion last December:
https://lore.kernel.org/u-boot/bb2ef69f-23e1-9936-e824-6b86924b9c8a@sholland.org/

In short: this is an H3 board without native SATA, so having this
symbol set here enables SATA operation for now, until we get full DT
regulator support in phy-sun4i-usb.c.

Cheers,
Andre
