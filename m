Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA5AC9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 11:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C728307F;
	Sun, 18 Jan 2026 12:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="hyFljquD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C096E8313B; Sun, 18 Jan 2026 12:34:24 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E8A82BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 12:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id CE492240029
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 12:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1768736061; bh=Oca1gbM5KrAW2b8mP94lqaYAakJjfHh5z/L4bin4dPU=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=hyFljquDIrQK1NOIR6o09Na08HWtbWxFOqX0WS0ITrOoPuPR9x23tnzy6iDewxCAW
 UVErSzEUQTj6hfGdEUeKsOzWGZSHRCM71TfL2YsdWPCPJGAKhkSEbo3h23VXE4psUX
 qMhnq1Cxgaof06DnBzqXm5IQL+jMfLgY8ECDQKvlPP/w7oko1lB3lD3zGNh9sCTkhJ
 +SXr6sZVPH1pHsbCEL0a4GDfh2HaKTjFD/9u0Rb5B0JUzH+LqVKacNm/N4ZbK/W7GN
 YpLdoNNCZSvF0/JloMJje+4/GjlKg+4Jl2eU7Z83qG8WhUYXKCVgv86nAJjOWIOy3P
 zlzNajK2ygl4w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dvBLt6pyWz6tsf;
 Sun, 18 Jan 2026 12:34:14 +0100 (CET)
Date: Sun, 18 Jan 2026 11:34:21 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay
 <devnull+j.ne.posteo.net@kernel.org>, 
 j.ne@posteo.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH next v2] board: amediatech: Add X96Q support
Message-ID: <aWzFNrTmfP7Lr2rd@probook>
References: <20260110-x96q-v2-1-1d6a725eb825@posteo.net>
 <20260110012313.6fa04c9e@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110012313.6fa04c9e@minigeek.lan>
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

On Sat, Jan 10, 2026 at 01:23:13AM +0100, Andre Przywara wrote:
> On Sat, 10 Jan 2026 00:10:32 +0100
> J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:
> 
> Hi,
> 
> many thanks for sending this!
> CC:ing the sunxi list for better visibility.
> New board support is mostly a matter for the people interested in the
> SoC family, less so for the general U-Boot audience.

Good point. I just followed get_maintainer.pl, which couldn't add the
linux-sunxi list for two reasons:

 - U-Boot's MAINTAINERS file doesn't use keyword tags and none of the
   filenames in this patch match the sunxi entry
 - it doesn't list linux-sunxi mailing list

Anyway, I'll Cc it on the next revision.

> 
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> > 
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> > 
> > This commit adds a defconfig and some documentation. The devicetree is
> > already in dts/upstream.
> > 
> > The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> > values in the DRAM PHY's MMIO space are as close as possible to those
> > observed when booting with the preinstalled vendor U-Boot. The DRAM
> > clock frequency of 600 MHz was reported in the vendor U-Boot's output.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > Changes in v2:
> > - Add missing Signed-off-by
> > - Re-generate x96q_defconfig with 'make savedefconfig'
> > - Move DRAM frequency comment to commit message
> > - Use GPL-2.0-or-later instead of deprecated GPL-2.0+
> > - Link to v1: https://lore.kernel.org/r/20251231-x96q-v1-1-316d703b8f03@posteo.net
> > ---
> >  configs/x96q_defconfig         | 31 +++++++++++++++++++++++
> >  doc/board/amediatech/index.rst |  9 +++++++
> >  doc/board/amediatech/x96q.rst  | 57 ++++++++++++++++++++++++++++++++++++++++++
> >  doc/board/index.rst            |  1 +
> >  4 files changed, 98 insertions(+)
> > 
> > diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
> > new file mode 100644
> > index 00000000000..b74a1b61f3c
> > --- /dev/null
> > +++ b/configs/x96q_defconfig
> > @@ -0,0 +1,31 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_SUNXI=y
> > +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-x96q"
> > +CONFIG_DRAM_CLK=600
> > +CONFIG_SPL=y
> > +CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
> > +CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
> > +CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
> > +CONFIG_DRAM_SUNXI_TPR0=0xc0001002
> > +CONFIG_DRAM_SUNXI_TPR2=0x00000100
> > +CONFIG_DRAM_SUNXI_TPR10=0x002f0107
> > +CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
> > +CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
> > +CONFIG_MACH_SUN50I_H616=y
> > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
> > +CONFIG_R_I2C_ENABLE=y
> > +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > +CONFIG_FIT_BEST_MATCH=y
> 
> What is this for, exactly?

The purpose was to boot FIT images as generated by the Linux kernel
build system.

> 
> > +CONFIG_SPL_I2C=y
> > +CONFIG_CMD_UFETCH=y
> > +CONFIG_CMD_CAT=y
> 
> Can you please drop those two commands? A defconfig is meant to provide
> some low level common configuration, enabling the features that are
> needed to boot. Command support should only be selected in the
> defconfig if it has a special meaning or requirement for this
> board.

Since this and the previous point are deployment characteristics (how a
board is used) rather than a characteristics of the board itself, I'll
remove them.

> 
> > +CONFIG_SPL_SYS_I2C_LEGACY=y
> > +CONFIG_SYS_I2C_MVTWSI=y
> > +CONFIG_SYS_I2C_SLAVE=0x7f

The SYS_I2C_SLAVE setting is also unnecessary for this board.

> > +CONFIG_SYS_I2C_SPEED=400000
> > +CONFIG_SUPPORT_EMMC_BOOT=y
> > +CONFIG_SUN8I_EMAC=y
> > +CONFIG_AXP305_POWER=y
> > +CONFIG_USB_EHCI_HCD=y
> > +CONFIG_USB_OHCI_HCD=y
> > +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
> 
> What is this needed for?

It turns out to be unnecessary.

> 
> > diff --git a/doc/board/amediatech/index.rst b/doc/board/amediatech/index.rst
> 
> What does this file add on top of doc/board/allwinner/sunxi.rst?

 - A mention that this board in particular is supported
 - The information that PLAT=sun50i_h616 should be used when building TF-A

I guess both of these could be derived from the defconfig too.

> In general we do not use board/<vendor> directories for Allwinner
> boards, not for code, and not for documentation.
> So can you please just drop this file and the amediatech entry below?

Ok.

I suppose it makes sense to change the patch title to "board: sunxi: ..." too.

> But you would need to add an entry into board/sunxi/MAINTAINERS,
> otherwise the U-Boot CI will fail.

Will do.


Thanks for your review!
J. Neuschäfer
