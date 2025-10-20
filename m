Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51941CCD184
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 02:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF3B807C0;
	Mon, 20 Oct 2025 04:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="T3hKdK7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7601082E34; Mon, 20 Oct 2025 04:28:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EF3807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 04:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 71DEE25DCA;
 Mon, 20 Oct 2025 04:28:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5bz-7PG2sJ6; Mon, 20 Oct 2025 04:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760927295; bh=DuZk49pxVeeyOWR4LFbbyE1acqMFp83L2US5NR89N3o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T3hKdK7vlT3uDmQBsJrbjKVoqbQOEwp1TpsUOKV9n3Rp7Sm/OyPG4e/D1jLuzcCAm
 QsQh+0IycQMFXRTKDWyP7pU3mPrJoIPgDj4KFfUWVM+M0EaL39H+nvc+Fdq2IxpyU7
 NCHG/7m8zV+uqkOycGM83eUmllM27DOGqIqVG+oCTbyQf9wttMZT70FH8g/igLLnBV
 uRPXkOAD9XgSdQFNCRz5Yskybi4OgZZqlf9uaO/wuqrCpXGFgewiZHSr3k8IZuRazl
 w5k6/zho4KcjVah5nNWGGjGfsCnUHWOdXwegOYEIadahXEgYUlIdHfbxwnYDFn268j
 e/yfzgxEncpGA==
Date: Mon, 20 Oct 2025 02:27:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi Zero2
Message-ID: <aPWeJiP1gnrR0Px2@pie>
References: <20251019052607.61702-1-ziyao@disroot.org>
 <20251019052607.61702-3-ziyao@disroot.org>
 <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
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

On Sun, Oct 19, 2025 at 12:52:17PM +0200, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 10/19/2025 7:26 AM, Yao Zi wrote:
> > FriendlElec NanoPi Zero2 is a super-tiny development board based on
> > RK3528A SoC. Add board-level configuration and U-Boot-specific
> > devicetree piece for it.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 +++++
> >  arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 +++
> >  configs/nanopi-zero2_defconfig               | 46 ++++++++++++++++++++
> >  doc/board/rockchip/rockchip.rst              |  1 +
> >  4 files changed, 64 insertions(+)
> >  create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> >  create mode 100644 configs/nanopi-zero2_defconfig
> > 
> > diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..3f65d2e1ff1
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +#include "rk3528-u-boot.dtsi"
> > +
> > +&vdd_arm {
> > +	regulator-init-microvolt = <953000>;
> > +};
> > +
> > +&vdd_logic {
> > +	regulator-init-microvolt = <901000>;
> > +};
> > diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> > index f343f71cf7f..853480a58ce 100644
> > --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> > +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> > @@ -9,3 +9,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
> >  S:	Maintained
> >  F:	arch/arm/dts/rk3528-radxa-e20c*
> >  F:	configs/radxa-e20c-rk3528_defconfig
> > +
> > +NANOPI-ZERO2
> > +M:	Yao Zi <ziyao@disroot.org>
> 
> Feel free to also add me as a maintainer (or reviewer):
> 
> M:	Jonas Karlman <jonas@kwiboo.se>

Sure, will add you as a maintainer.

> > +S:	Maintained
> > +F:	arch/arm/dts/rk3528-nanopi-zero2*
> > +F:	configs/nanopi-zero2_defconfig
> 
> The defconfig should be named nanopi-zero2-rk3528_defconfig to match the
> Rockchip board defconfig naming scheme.
> 
> > diff --git a/configs/nanopi-zero2_defconfig b/configs/nanopi-zero2_defconfig
> > new file mode 100644
> > index 00000000000..af14589568c
> > --- /dev/null
> > +++ b/configs/nanopi-zero2_defconfig
> 
> As mentioned above, please name this nanopi-zero2-rk3528_defconfig.
> 
> > @@ -0,0 +1,46 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
> > +CONFIG_ROCKCHIP_RK3528=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_DEBUG_UART=y
> > +# CONFIG_BOOTMETH_VBE is not set
> 
> There should be no need to drop this, I only drop it in generic Rockchip
> defconfig because it that defconfig is supposed to be as minimal and
> generic as possible.
> 
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-nanopi-zero2.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> 
> Please add following to seed random generator for linux.
> 
> CONFIG_BOARD_RNG_SEED=y
> 
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_CMD_MEMINFO=y
> > +CONFIG_CMD_MEMINFO_MAP=y
> 
> Please add following to add the adc command:
> 
> CONFIG_CMD_ADC=y
> 
> > +CONFIG_CMD_GPIO=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_MISC=y
> > +CONFIG_CMD_MMC=y
> 
> Please add following USB commands to future proof:
> 
> CONFIG_CMD_USB=y
> CONFIG_CMD_ROCKUSB=y
> CONFIG_CMD_USB_MASS_STORAGE=y
> 
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_RNG=y
> 
> Please add following to enable regulator debug:
> 
> CONFIG_CMD_REGULATOR=y
> 
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_BUTTON=y
> > +CONFIG_BUTTON_ADC=y
> 
> Please add following to simplify addition of USB related Kconfig options:
> 
> # CONFIG_USB_FUNCTION_FASTBOOT is not set
> 
> > +CONFIG_ROCKCHIP_GPIO=y
> > +CONFIG_LED=y
> > +CONFIG_LED_GPIO=y
> > +CONFIG_SUPPORT_EMMC_RPMB=y
> > +CONFIG_MMC_DW=y
> > +CONFIG_MMC_DW_ROCKCHIP=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_PHY_REALTEK=y
> 
> Please add following:
> 
> CONFIG_DM_MDIO=y
> 
> > +CONFIG_DWC_ETH_QOS=y
> > +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> 
> Please add following to prepare for USB3/PCIe:
> 
> CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> 
> Please add following to actually enable support for initializing the two
> pwm-regulators on this board.
> 
> CONFIG_REGULATOR_PWM=y
> 
> > +CONFIG_DM_REGULATOR_GPIO=y
> > +CONFIG_PWM_ROCKCHIP=y
> > +CONFIG_BAUDRATE=1500000
> > +CONFIG_DEBUG_UART_SHIFT=2
> > +CONFIG_SYS_NS16550_MEM32=y
> 
> Please add following to prepare for future USB support:
> 
> CONFIG_USB=y
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_GENERIC=y
> CONFIG_USB_DWC3=y
> CONFIG_USB_DWC3_GENERIC=y
> CONFIG_USB_GADGET=y
> CONFIG_USB_GADGET_DOWNLOAD=y
> CONFIG_USB_FUNCTION_ROCKUSB=y
> 
> > +CONFIG_ERRNO_STR=y
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> > index de3aa79cb5c..b2b7de4e43a 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -100,6 +100,7 @@ List of mainline supported Rockchip boards:
> >       - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
> >  
> >  * rk3528
> > +     - FriendlyElec NanoPi Zero2 (nanopi-zero2)
> 
> Please update to include the rk3528 suffix after the defconfig name.
> 
> >       - Generic RK3528 (generic-rk3528)
> >       - Radxa E20C (radxa-e20c-rk3528)
> >  
> 
> With above adjustments this closely matches the defconfig I have been
> carrying in my rk3528 branch at [1] a few months.
> 
> So with above fixed this is:
> 
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Thanks, these changes are all reasonable and I'll adapt them in v2.
Seems I did something wrong when doing savedefconfig and lost some
defconfig changes...

> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> 
> I plan to send out a series with the ROCK-2 and Sige1 board additions shortly.
> 
> Regards,
> Jonas

Best regards,
Yao Zi
