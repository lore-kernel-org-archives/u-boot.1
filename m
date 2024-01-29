Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4FCC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 16:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAAD87C44;
	Mon, 29 Jan 2024 17:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA54487C52; Mon, 29 Jan 2024 17:38:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D8CBB87C44
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E2F5DA7;
 Mon, 29 Jan 2024 08:39:11 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D8E3F738;
 Mon, 29 Jan 2024 08:38:26 -0800 (PST)
Date: Mon, 29 Jan 2024 16:38:24 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Nick Alilovic <nickalilovic@gmail.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] configs: Transpeed 8K618-T: Add Transpeed 8K618-T
 board support
Message-ID: <20240129163824.6cf5804e@donnerap.manchester.arm.com>
In-Reply-To: <20240118175655.1c8922a2@donnerap.manchester.arm.com>
References: <20240118164508.43617-1-nickalilovic@gmail.com>
 <20240118175655.1c8922a2@donnerap.manchester.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Thu, 18 Jan 2024 17:56:55 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

> On Thu, 18 Jan 2024 11:45:08 -0500
> Nick Alilovic <nickalilovic@gmail.com> wrote:
> 
> Hi Nick,
> 
> > This is a Chinese TV box based on Allwinner H618 SoC.
> > 
> > The DRAM parameters were derived from the values found in a firmware update.
> > 
> > Signed-off-by: Nick Alilovic <nickalilovic@gmail.com>  
> 
> Thanks for the fixes, looks good now:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> I will queue this after the DT files have been merged.

Merged into sunxi/master.

Thanks!
Andre

> > ---
> > This defconfig relies on the synced sun50i-h618-transpeed-8k618-t.dts file.
> > 
> >  configs/transpeed-8k618-t_defconfig | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 configs/transpeed-8k618-t_defconfig
> > 
> > diff --git a/configs/transpeed-8k618-t_defconfig b/configs/transpeed-8k618-t_defconfig
> > new file mode 100644
> > index 0000000000..020d3974af
> > --- /dev/null
> > +++ b/configs/transpeed-8k618-t_defconfig
> > @@ -0,0 +1,27 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_SUNXI=y
> > +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-transpeed-8k618-t"
> > +CONFIG_SPL=y
> > +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x03030303
> > +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> > +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1f12
> > +CONFIG_DRAM_SUN50I_H616_TPR0=0xc0001002
> > +CONFIG_DRAM_SUN50I_H616_TPR10=0x2f1107
> > +CONFIG_DRAM_SUN50I_H616_TPR11=0xddddcccc
> > +CONFIG_DRAM_SUN50I_H616_TPR12=0xeddc7665
> > +CONFIG_MACH_SUN50I_H616=y
> > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
> > +CONFIG_DRAM_CLK=648
> > +CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> > +CONFIG_R_I2C_ENABLE=y
> > +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > +CONFIG_SPL_I2C=y
> > +CONFIG_SPL_SYS_I2C_LEGACY=y
> > +CONFIG_SYS_I2C_MVTWSI=y
> > +CONFIG_SYS_I2C_SLAVE=0x7f
> > +CONFIG_SYS_I2C_SPEED=400000
> > +CONFIG_SUPPORT_EMMC_BOOT=y
> > +CONFIG_AXP313_POWER=y
> > +CONFIG_AXP_DCDC3_VOLT=1360
> > +CONFIG_USB_EHCI_HCD=y
> > +CONFIG_USB_OHCI_HCD=y  
> 
> 

