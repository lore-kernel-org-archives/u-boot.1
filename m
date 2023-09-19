Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C369BCD5483
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488A086A49;
	Tue, 19 Sep 2023 09:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="dCNSTm4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0AB86A77; Tue, 19 Sep 2023 09:32:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695A186A3F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1695108771; x=1695713571; i=frank-w@public-files.de;
 bh=xOv1pLNxZqD4qWo9OluV54oThjvfQHNcERD5JMBkCLQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dCNSTm4haSrVszCT2VOERQejNRHxHTS4S5bV0j3mBJp9XaTGXzsogpML6QTv9M/eu0JhOHl+D5E
 Zci0JZo3lqvc9fSCvHtroAdh0IceLGoJbUA4Y/JmmMAq+cNVPFkc4bvgKKIyj1HgODgb1FTv9ziSE
 LIgoDOQo1rI52MKHb3cgmwuO+hkHaxMfDtklGEyUBBcijjsKb3WXa3Zjezr8fo8p0CQCHWX16hZ2l
 c4zKVwKbkClKbi3NkMrQp34w8yC6xwYLpf4PhW3cBTe4ECSbFh7hVLJPJz43i00/bvZWNY57sPsAJ
 DjxqdHE6JpfIsMAcUJqGcKgRMFKcOgJeg29g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.33] ([217.61.158.33]) by web-mail.gmx.net
 (3c-app-gmx-bap40.server.lan [172.19.172.110]) (via HTTP); Tue, 19 Sep 2023
 09:32:51 +0200
MIME-Version: 1.0
Message-ID: <trinity-6be7b34d-41db-48b1-95a1-3b4c98c3e288-1695108771154@3c-app-gmx-bap40>
From: Frank Wunderlich <frank-w@public-files.de>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Frank Wunderlich <linux@fw-web.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Aw: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Sep 2023 09:32:51 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <b9f21c58-f20e-0a23-5ec2-6610684af680@kwiboo.se>
References: <20230918173624.31464-1-linux@fw-web.de>
 <b9f21c58-f20e-0a23-5ec2-6610684af680@kwiboo.se>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:oN8IhwHv9t3ELDDs4UatYKAS/77V1kP4v1ObxJjGDlGKKTLZsxW1QU20BFB/Ncsarozwo
 1OquflqQgtgqG2aCm6qmDTtEpMKj6NyKgFMID1Uf872K0twhkrj8XfzXn3GFSStp8lV07AT6c4yS
 dghCGwz0eBPwIWcoEREzVni4xLZ3oWPqg/p8TTJNI5Gxti+hOFEEgV9d72zTR5ZBe07tQB6C7w/1
 gUQWpjQ8PRqQ4knQrnhAmKwXDu3zyHsqXM2iDtObCDhjLcpTLi96PiGm+CJin4EhYZUXZeUvsDmL
 iM=
UI-OutboundReport: notjunk:1;M01:P0:8STjVoIsSpY=;JSXHlpYThopIT0CSyrqurHVekFe
 hIZHyLpxlRoCdjStidJN4CBH8EIchp71ONdOqUJoa+drad5ykkhz7psaYeK3chYE7tvEJkLbq
 mWXNVDDXO0514L6+Vahp786qKQn1UCK3Nb5Y3YJfIGuwX52bbei4bvOnRYp+0holzBMiv6utU
 N+DW6K3WdYy6XBbUI/MAhbVgrfbP1kfm1HegTeZJsmxbCQ1HO/1RwYeUhr6uWwzCgC1s89+bj
 lavWjqBTTXJn1IWaVPB3mZQwFRT0MFpZ8CK6ZgST+ZOjOCtc/D9E3Zu2IkXxeXuckHPwl9aLb
 gFjtQf1IuqKBSDBHtbCzbZkFe9ghhfIjQPf6EibPItVYH/Z1ZTQk6b03fJFBPtyqU8RRhEK0b
 HFCkk2uj/euX0qLO2jvS026lI6L6YMr3SB394JAdU0BnvLcf5dl6qkIpzzJ8E2ozm9GzxuVgW
 V3PvjJDmh/SZjXa9BjJJG4lvBBZ3xpK3L75adpEZVeEqSTvnyxss3qtYMsuaQovGD1GDKx/ne
 ErXBuBz0LtDDZG+yOcvgQ/tUn4XW6RXNje6Qi7h22ajJQ6lk83CyoDH8uK+y2t8A5FMqe3Igs
 yW7haFtIUScSf1WAjyQRQRWeUTMurY2T6DfKWBYeAS8K6BjrlFcSUbdjN7XS4u+0YafU+cRcl
 Rx4me+TSb8wLbUM1FkDBLCDOXWkFuoVuQ6HtKAxIDza2pwq0LqdGwk8/T8yLPKhdEaTRwpElG
 EX4eKzLG4oTHFqcBU74McVFqu1JNmx6ak213Q6BF5LWtBMX4TlcW3k5T54PrI3PZSuu9A11CG
 XLkfEoIIFHx6qaD70bDRPJcgPooNFBspYU++thv2dJWeg=
Content-Transfer-Encoding: quoted-printable
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

Hi Jonas

> Gesendet: Montag, 18. September 2023 um 23:45 Uhr
> Von: "Jonas Karlman" <jonas@kwiboo.se>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chr=
omium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <ke=
ver.yang@rock-chips.com>, u-boot@lists.denx.de
> Betreff: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
>
> Hi Frank,
>
> On 2023-09-18 19:36, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add Bananapi R2 Pro board.
> >
> > tested:
> > - sdcard
> > - both front usb-ports
> > - sata
> > - wan-port
> >
> > lan-ports are connected to mt7531 switch where driver needs to be sepa=
rated from mtk ethernet-driver.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > because iodomain is different to evb and now iodomain driver is sent a=
s
> > patch we need to separate between EVB and R2Pro else board can be bric=
ked.
> > ---
> > v4:
> > - add r2pro board to readme
> > - update r2pro dts to linux version
> > - remove switch node from linux dts
> > - disable gmac0 because switch driver does not work yet
> >   to solve timeout error:
> >   ethernet@fe2a0000 Waiting for PHY auto negotiation to complete......=
... TIMEOUT!
> >   phy_startup() failed: -110FAILED: -110ethernet@fe010000 Waiting for =
PHY auto nee
> > - cleanup r2pro u-boot.dtsi like jonas suggests
> > - update and reorder defconfig based on jonas suggestions
> > - dts: disable usb_host0_ohci because of error on usb-start
> >   scanning bus usb@fd840000 for devices...
> >   ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to tok=
en (IN) or did
> >   not provide a handshake (OUT) (5)
> >   unable to get device descriptor (error=3D-1)
> > - pcie is not yet working, so not adding these options
> >   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
> >   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -1=
10.
> >   pcie_dw_rockchip pcie@fe270000: failed to init phy (ret=3D-110)
> >   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
> >   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -1=
10.
> >   pcie_dw_rockchip pcie@fe280000: failed to init phy (ret=3D-110)
>
> Looks like this board use PCIe bifurcation and would depend on my rk35xx
> PCIe bifurcation series to at least have a chance to work. (looks like
> it is applied based on your log rows).

yes i have added your series to my tree...

https://github.com/frank-w/u-boot/commits/2023-10-bpi-r2pro_2

and yes, board uses bifurcation to split pcie3 to an mPCIe slot and an m.2=
 slot.

> Could there be an issue with a regulator not being enabled in time?
> Please use regulator cmd to enable all regulators prior to running the
> pci enum cmd, and see if that changes anything.

at least the output changes...

there are 3 pcie-regulators, first is for clock

vcc3v3_pcie          disabled      3300000          - -          0
vcc3v3_minipcie      disabled      3300000          - -          0
vcc3v3_ngff          disabled      3300000          - -          0

BPI-R2PRO> regulator dev vcc3v3_pcie
dev: vcc3v3_pcie @ vcc3v3-pi6c-05-regulator
BPI-R2PRO> regulator enable
BPI-R2PRO> regulator dev vcc3v3_minipcie
dev: vcc3v3_minipcie @ vcc3v3-minipcie-regulator
BPI-R2PRO> regulator enable

vcc3v3_pcie          enabled       3300000          - -          0
vcc3v3_minipcie      enabled       3300000          - -          0
vcc3v3_ngff          disabled      3300000          - -          0

BPI-R2PRO> pci enum
pcie_dw_rockchip pcie@fe270000: PCIe-0 Link Fail

(card is in mpcie-slot)

> > - emmc not tested as it is empty on my board because it breaks sdcard =
boot
> >
> > v3:
> > - disable gmac0 as switch-driver is not yet ready to attach to the mac
> >
> > v2:
> > - drop switch-node for now as u-boot driver works differently to linux
> > ---
> >  arch/arm/dts/Makefile                     |   3 +-
> >  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  28 +
> >  arch/arm/dts/rk3568-bpi-r2pro.dts         | 852 +++++++++++++++++++++=
+
> >  configs/bpi-r2pro-rk3568_defconfig        |  95 +++
> >  doc/board/rockchip/rockchip.rst           |   1 +
> >  5 files changed, 978 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
>
> The DT file is named rk3568-bpi-r2-pro.dts in linux, please use same
> name in U-Boot. Same goes for defconfig-file, please name it
> bpi-r2-pro-rk3568_defconfig to match DT filename.
>
> >  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 85fd5b1157b1..71c557e87e9e 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -183,7 +183,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) +=3D \
> >  	rk3568-nanopi-r5s.dtb \
> >  	rk3568-odroid-m1.dtb \
> >  	rk3568-radxa-e25.dtb \
> > -	rk3568-rock-3a.dtb
> > +	rk3568-rock-3a.dtb \
> > +	rk3568-bpi-r2pro.dtb
>
> Please sort the dtb files alphabetically.

done in my tree

> >
> >  dtb-$(CONFIG_ROCKCHIP_RK3588) +=3D \
> >  	rk3588-edgeble-neu6a-io.dtb \
> > diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/=
rk3568-bpi-r2pro-u-boot.dtsi
> > new file mode 100644
> > index 000000000000..089e54f8cece
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>
> [...]
>
> > diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk=
3568_defconfig
> > new file mode 100644
> > index 000000000000..df4daed865f0
> > --- /dev/null
> > +++ b/configs/bpi-r2pro-rk3568_defconfig
> > @@ -0,0 +1,95 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_TEXT_BASE=3D0x00a00000
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_NR_DRAM_BANKS=3D2
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc00000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3568-bpi-r2pro"
> > +CONFIG_SYS_PROMPT=3D"BPI-R2PRO> "
> > +CONFIG_ROCKCHIP_RK3568=3Dy
> > +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_SPL_STACK_R_ADDR=3D0x600000
> > +CONFIG_SPL_STACK=3D0x400000
> > +CONFIG_DEBUG_UART_BASE=3D0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_AHCI=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_BOOTSTD_FULL=3Dy
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-bpi-r2pro"
>
> Should be rockchip/rk3568-bpi-r2-pro.dtb to match linux.
done in my tree

> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_PAD_TO=3D0x7f8000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0x4000000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK_R=3Dy
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_I2C=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +CONFIG_CMD_SYSBOOT=3Dy
> > +CONFIG_CMD_PMIC=3Dy
> > +CONFIG_CMD_REGULATOR=3Dy
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_OF_LIVE=3Dy
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names int=
errupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>
> Would recommend you to remove "pinctrl-0 pinctrl-names " from this
> and add CONFIG_SPL_DM_SEQ_ALIAS=3Dy to match other rk3568 boards.

ok, i do

> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_DWC_AHCI=3Dy
> > +CONFIG_SPL_CLK=3Dy
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> > +CONFIG_SUPPORT_EMMC_BOOT=3Dy
>
> Not sure eMMC boot partitions are useful on Rockchip. It is not enabled
> on any other rk356x board. Should we enabled it for other rk356x boards?

have not done much with emmc and on my other boards (mediatek based) i nee=
d to flash
emmc boot0 partition to successful boot from emmc. So i added this option =
here to allow this.
If it is really not needed on rockchip i can drop it.

Problem is when i flah emmc, board always boot from emmc independ of sdcar=
d is inserted and needs to
short the emmc...that makes it hard doing such tests.

> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_PHY_REALTEK=3Dy
> > +CONFIG_DWC_ETH_QOS=3Dy
> > +CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
>
> This Kconfig options is still in a pending series, please remove or
> mention that this patch has a dependency on my rk35xx GMAC series.

ok, i mention it in commit

> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
>
> Would recommend you to add CONFIG_SPL_PINCTRL=3Dy here. It should not hu=
rt
> to let SPL configure pinctrl for sd-card/emmc before it tries to load
> the FIT image for storage media.
>
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_REGULATOR_PWM=3Dy
>
> I am not seeing any pwm regulator in the DT so this line can probably be
> removed.

ok, i drop it

> > +CONFIG_REGULATOR_RK8XX=3Dy
> > +CONFIG_PWM_ROCKCHIP=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_SCSI=3Dy
> > +CONFIG_DM_SCSI=3Dy
> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_SYSRESET_PSCI=3Dy
>
> Is this working/being used? Normal sysreset from cru driver should work.

not tested as i used an older version of evb defconfig as base

> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_UHCI_HCD=3Dy
>
> Is this Kconfig options used for anything? Does not look like there is
> any other board using this, should be safe to remove this line.

the generic EHCI and OHCI have nodes in dts and imho are needed for usb2-s=
upport on the xhci controllers.

> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_ERRNO_STR=3Dy
> > +# CONFIG_EFI_LOADER is not set
>
> I would recommend you to remove this line to allow EFI boot on this boar=
d.

done in my tree

> With EFI enabled users should be able to use a plain aarch64 distro
> installers to setup a system. Fedora, openSUSE, Ubuntu are a few distros
> that currently works with some minor quirks.
>
> For an incomplete guide on how a distro installer could be used, see:
> https://wiki.pine64.org/wiki/Quartz64_UEFI_with_U-Boot
>
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rock=
chip.rst
> > index de9fe8e642b1..a639215d904e 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
> >
> >  * rk3568
> >       - Rockchip Evb-RK3568 (evb-rk3568)
> > +     - BananaPi R2 Pro (bpi-r2pro-rk3568_defconfig)
>
> Please use the full market name, Banana Pi BPI-P2 Pro, if I am not
> mistaken, also remove _defconfig and only keep bpi-r2-pro-rk3568 in
> parentheses.

done in my tree

> >       - EmbedFire LubanCat 2 (lubancat-2-rk3568)
> >       - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
> >       - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
>
> An entry for this board should be added to a MAINTAINERS-file, probably
> board/rockchip/evb_rk3568/MAINTAINERS, because it is using that boards
> config.

done in my tree

> Regards,
> Jonas

regards Frank
