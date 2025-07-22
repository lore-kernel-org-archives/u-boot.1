Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAEDC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 02:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3614283211;
	Tue, 22 Jul 2025 04:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13CF48376C; Tue, 22 Jul 2025 04:49:49 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5CF830F6
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 04:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.48.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 62EF1340CE7;
 Tue, 22 Jul 2025 02:49:43 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:49:32 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 20/20] sunxi: A523: add defconfigs for three boards
Message-ID: <20250722024932-GYA724801@gentoo>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-21-andre.przywara@arm.com>
 <20250722013526.6297858c@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722013526.6297858c@minigeek.lan>
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

Hi Andre,

On 01:35 Tue 22 Jul     , Andre Przywara wrote:
> On Fri, 18 Jul 2025 00:54:55 +0100
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
> Hi Yixun,
> 
> see below for a comment on the missing eMMC support for the Radxa
> defconfig. My board doesn't have eMMC, so can you please check this on
> your end?
> 
sure

> > So far developers seem to use three popular boards:
> > - Avaota A1: dev board with USB 3.0, dual Ethernet, small display
> > - X96QPro+: TV box with Gigabit Ethernet, USB 3.0, eMMC
> > - Radxa A5E: small dev board with USB3/M.2 2230 (muxed), dual Ethernet
> > 
> > Add the defconfig files for those boards, containing the DRAM parameters
> > and the usual Kconfig options.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  board/sunxi/MAINTAINERS         | 15 +++++++++++++++
> >  configs/avaota-a1_defconfig     | 31 +++++++++++++++++++++++++++++++
> >  configs/radxa-a5e_defconfig     | 30 ++++++++++++++++++++++++++++++
> >  configs/x96q_pro_plus_defconfig | 32 ++++++++++++++++++++++++++++++++
> >  4 files changed, 108 insertions(+)
> >  create mode 100644 configs/avaota-a1_defconfig
> >  create mode 100644 configs/radxa-a5e_defconfig
> >  create mode 100644 configs/x96q_pro_plus_defconfig
> > 
...
> > diff --git a/configs/radxa-a5e_defconfig b/configs/radxa-a5e_defconfig
> > new file mode 100644
> > index 00000000000..012e7b4eeaf
> > --- /dev/null
> > +++ b/configs/radxa-a5e_defconfig
> > @@ -0,0 +1,30 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_SUNXI=y
> > +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun55i-a527-cubie-a5e"
> > +CONFIG_SPL=y
> > +CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
> > +CONFIG_DRAM_SUNXI_DX_DRI=0x0d0d0d0d
> > +CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
> > +CONFIG_DRAM_SUNXI_ODT_EN=0x84848484
> > +CONFIG_DRAM_SUNXI_TPR0=0x80808080
> > +CONFIG_DRAM_SUNXI_TPR1=0x06060606
> > +CONFIG_DRAM_SUNXI_TPR6=0x38000000
> > +CONFIG_DRAM_SUNXI_TPR10=0x802f3333
> > +CONFIG_DRAM_SUNXI_TPR11=0xc7c5c4c2
> > +CONFIG_DRAM_SUNXI_TPR12=0x3533302f
> > +# BSP value: CONFIG_DRAM_SUNXI_TPR11=0xc6c4c2c0
> > +# BSP value: CONFIG_DRAM_SUNXI_TPR12=0x3a373233
> > +CONFIG_MACH_SUN55I_A523=y
> > +CONFIG_R_I2C_ENABLE=y
> > +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > +CONFIG_SPL_I2C=y
> > +CONFIG_SPL_SYS_I2C_LEGACY=y
> > +CONFIG_SYS_I2C_MVTWSI=y
> > +CONFIG_SYS_I2C_SLAVE=0x7f
> > +CONFIG_SYS_I2C_SPEED=400000
> > +CONFIG_REGULATOR_AXP=y
> > +CONFIG_AXP717_POWER=y
> > +CONFIG_AXP_DCDC2_VOLT=920
> > +CONFIG_AXP_DCDC3_VOLT=1100
> > +CONFIG_USB_EHCI_HCD=y
> > +CONFIG_USB_OHCI_HCD=y
> 
> This is missing CONFIG_MMC_SUNXI_SLOT_EXTRA=2 and
> CONFIG_SUPPORT_EMMC_BOOT=y, as there are Radxa boards with eMMC.
confirmed, the two configs are exactly what I've added to make eMMC work

> The DT describes this, so we should follow suit here, to allow eMMC
> booting. Should not harm boards without the eMMC chip.
> 
agree!

I'd assume you would take care of the config? and send out an updated
version next time?

thanks

-- 
Yixun Lan (dlan)
