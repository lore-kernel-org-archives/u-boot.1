Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EADE7C4EA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACD1876A3;
	Wed,  4 Oct 2023 20:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="IXZzqQZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E727876A4; Wed,  4 Oct 2023 20:04:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781A58768E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 20:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696442677; x=1697047477; i=frank-w@public-files.de;
 bh=MudRV+ASeoXSifOL70gExZIi/+H75JqqyGMqFK/UAUo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IXZzqQZfJhsFaDco4o8A+TkNSQUvWZSG3IxtO28Eyht67MzXvC+IGRn3dEgePHzKHIM8lO5JVS4
 hldsALTOo+MNxfy3jHpNO2/l1pmyIKYmShaZXhIfVFv4I15Nz6tpTbF1zxsIuHHDT29yewh7K3fkU
 P3W/K9dDNlFWgiokGrp3SK8X3bU77luL7vbwD4GpYVaG4HncWrz0eEEA2NMxfwYtJzDJRqHimIKXx
 e3w8mKxPHAo0UkKpHJi9dxAu8HTLG4fwx1B88j8bcR4SdyBNFPK2B9urFhCEBRZ/XZzcP3n2QsCuV
 KPSXtQnmW9vEUiGXAiZBBS+ev24CoEdwdCHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.247] ([217.61.145.247]) by web-mail.gmx.net
 (3c-app-gmx-bap42.server.lan [172.19.172.112]) (via HTTP); Wed, 4 Oct 2023
 20:04:37 +0200
MIME-Version: 1.0
Message-ID: <trinity-f83e3edb-6459-493f-9386-2ba91c2711aa-1696442677622@3c-app-gmx-bap42>
From: Frank Wunderlich <frank-w@public-files.de>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Frank Wunderlich <linux@fw-web.de>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Joseph Chen <chenjh@rock-chips.com>,
 u-boot@lists.denx.de
Subject: Aw: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
Content-Type: text/plain; charset=UTF-8
Date: Wed, 4 Oct 2023 20:04:37 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <8c7f5643-0130-ea31-bf3e-c05609abd8c0@kwiboo.se>
References: <20230920184005.50931-1-linux@fw-web.de>
 <8c7f5643-0130-ea31-bf3e-c05609abd8c0@kwiboo.se>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/5BVi/WaTFw0S+YNhNts5LgIngTYC35lAFcA/nTWk2w8WxZprXFu571e8BQykwMeK0Cuz
 hV2TXB//37NQLYN8Wsh3vgx8usj6JMpVR3iPwIItY8+KJVfpHvL6XpZZUuqezultwX7pmYzdoVs7
 epD3xkoh5/1E2qDeBb/Y4iAK0v8AcLDjmSHpo/nbcHnlfMgPkFXaTSB3nO3w1iePPwjeTfSfNmCI
 CBD//gSr4nAdgsrrHqoReYUhi1+CJYIYrU5kMiLR7vuAr1eu3B15Ha//0kC6h5NEGNV91YgGxe0s
 sM=
UI-OutboundReport: notjunk:1;M01:P0:4//34MaarKw=;hW8Z4i1jA5QdAlQqcyMTQSsx/8a
 dVyANeoVVBRvQWvqR+3FQwe+qSxrEEoDrfVS/eT+mb9HbnTdBjC0x+0vqh7SVxMNH0nWG9hdd
 DfQuwIO4H7bG6hJBmIKawP6MbtfdCa1QxGA6i4u0bFWJRY9tEm/t67ImT7pTbNFzW9LTE/RwI
 BgdxiM6v96HHkFbHc01RLXzvNrazXibO7zjAsP6ZNJb0y2qOjCF7IFOLdP9JwVKOV2NUPajSa
 d1kAzgwZC72IesNghqzeXjnZZmZrnwoZqcuae/O167fEY0aJJq6u4XjWINYljE2Xa6qpfv+6u
 XZKCEk+OmN3v0NR5nmvONoG2Kel6EhSfu70f6KliqC9ZIKu0fMw5naIhWu0trHLFHihr1cwAb
 hEyFn2wuie455mZ90lNFu+zlLU6Sm9YHzgxF6u+qbklM+YRiSxFL8XM59/NdUKNA8nGKI9zcF
 aduxaV0MLR+P2bjj82t1chPvcouk/juAbJBpE/NlVPrdlzvrwcVmt6sie3yY2sQkDkyxfRvs4
 xlJwl9KJwnhv41Br0d6Efndkc9YZmbY9l3tDYSAY+aHAKTqjTeVxlhYnsZMDjRFoOcuvT+nf4
 cjkgK+eScFltZPlyuADi5RFPM7bpoPeWCYRwN1xbOS0qnnthY1HBIUf7XwJMsN/sYiWYVgSJ7
 zmT+mmgweSk2qO6DzcZVnQfeSTRNFfCv7gEDelQAluTGpdMjWjcobOZcl/BGzSdakErQK1DXy
 M8fH/q22LgE8dbjP5n9EnKqnuZRs0uI/UQY5HX/CCZocTRnRQouIlks8SHGqvFZdi+yGJjYiI
 V4lzMTe1xr8c98j+unifthsZHA5WgfPtCvP9jPr+7zmns=
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

thanks for your review.

> Gesendet: Dienstag, 03. Oktober 2023 um 22:27 Uhr
> Von: "Jonas Karlman" <jonas@kwiboo.se>
> An: "Frank Wunderlich" <linux@fw-web.de>, "Frank Wunderlich" <frank-w@pu=
blic-files.de>, "Kever Yang" <kever.yang@rock-chips.com>
> Cc: "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich=
@vrull.eu>, "Joseph Chen" <chenjh@rock-chips.com>, u-boot@lists.denx.de
> Betreff: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
>
> Hi Frank,
>
> On 2023-09-20 20:40, Frank Wunderlich wrote:
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
> > lan-ports are connected to mt7531 switch where driver needs to be
> > separated from mtk ethernet-driver.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > because iodomain is different to evb and now iodomain driver is sent a=
s
> > patch we need to separate between EVB and R2Pro else board can be bric=
ked.
> >
> > ethernet support depends on these series from jonas:
> >
> > rockchip: Port IO-domain driver for RK3568 from linux
> > https://patchwork.ozlabs.org/project/uboot/cover/20230821223020.391862=
0-1-jonas@kwiboo.se/
> > and
> > rockchip: Add GMAC support for RK3568 and RK3588
> > https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.170101=
2-1-jonas@kwiboo.se/
> > ---
> > v5:
> > - add line break in description
> > - reorder in makefile
> > - drop special dts-handling
> >   (deletion of switchnode, disable of usb and gmac0)
> > - add MAINTAINERS entry
> > - changes to defconfig suggested by jonas
> >   - remove "pinctrl-0 pinctrl-names" from CONFIG_OF_SPL_REMOVE_PROPS
> >   - add CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> >   - add CONFIG_SPL_PINCTRL=3Dy
> >   - remove CONFIG_USB_UHCI_HCD
> >   - enable EFI_LOADER (defaults to y)
> >   - drop CONFIG_SYSRESET_PSCI (reset works without)
> >
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
> > - emmc not tested as it is empty on my board because it breaks sdcard =
boot
> > - rename dts and defconfig (add minus sign)
> > - enable efi_loader in defconfig
> >
> > v3:
> > - disable gmac0 as switch-driver is not yet ready to attach to the mac
> >
> > v2:
> > - drop switch-node for now as u-boot driver works differently to linux
> > ---
> >  arch/arm/dts/Makefile                      |   1 +
> >  arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi |  19 +
> >  arch/arm/dts/rk3568-bpi-r2-pro.dts         | 852 ++++++++++++++++++++=
+
> >  board/rockchip/evb_rk3568/MAINTAINERS      |   7 +
> >  configs/bpi-r2-pro-rk3568_defconfig        |  94 +++
> >  doc/board/rockchip/rockchip.rst            |   1 +
> >  6 files changed, 974 insertions(+)
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
> >  create mode 100644 configs/bpi-r2-pro-rk3568_defconfig
> >
>
> [...]
>
> > diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/ev=
b_rk3568/MAINTAINERS
> > index cc9eb432a8b5..8c506162c01e 100644
> > --- a/board/rockchip/evb_rk3568/MAINTAINERS
> > +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> > @@ -7,6 +7,13 @@ F:	configs/evb-rk3568_defconfig
> >  F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
> >  F:	arch/arm/dts/rk3568-evb.dts
> >
> > +Banana Pi BPI-R2 Pro
>
> Maintainer entries are typically in upper case. get_maintainer.pl does
> not seem to mind, but use of uppercase seem to be the norm.

ok, i wil change it to "BANANAPI-BPI-R2-PRO" as i noticed that no spaces a=
re in the other Boards

> > +M:	Frank Wunderlich <frank-w@public-files.de>
> > +S:	Maintained
> > +F:	configs/bpi-r2-pro-rk3568_defconfig
> > +F:	arch/arm/dts/rk3568-bpi-r2-pro.dts
> > +F:	arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> > +
> >  LUBANCAT-2
> >  M:	Andy Yan <andyshrk@163.com>
> >  S:	Maintained
> > diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-=
rk3568_defconfig
> > new file mode 100644
> > index 000000000000..5989eab569b8
> > --- /dev/null
> > +++ b/configs/bpi-r2-pro-rk3568_defconfig
> > @@ -0,0 +1,94 @@
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
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3568-bpi-r2-pro"
> > +CONFIG_SYS_PROMPT=3D"BPI-R2PRO> "
>
> Very few Rockchip boards use a custom prompt, is this needed?

as i use different boards here it is easier with this prompt ;)

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
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-bpi-r2-pro"
>
> This is missing .dtb suffix, fdtfile env var ends up as:
>
>   fdtfile=3Drockchip/rk3568-bpi-r2-pro
>
> instead of:
>
>   fdtfile=3Drockchip/rk3568-bpi-r2-pro.dtb
>
> Resulting in possible a dtb-file not being loaded when an entry in
> extlinux.conf use fdtdir instead of fdt value.

ok, will fix it to

CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-bpi-r2-pro.dtb"

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
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-c=
locks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
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
> arch/arm/mach-rockchip/spl.c override spl_mmc_boot_mode() to always
> return MMCSD_MODE_RAW, so there should not be any need to include
> support for MMCSD_MODE_EMMCBOOT.

i would leave it till i known how to correctly boot from emmc and how
to determine from which mmc device board was booted.

> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_PHY_REALTEK=3Dy
> > +CONFIG_DWC_ETH_QOS=3Dy
> > +CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_REGULATOR_PWM=3Dy
>
> Not seeing any pwm-regulator compatible in the DT, so this option could
> be removed.

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
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_ERRNO_STR=3Dy
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rock=
chip.rst
> > index de9fe8e642b1..58f20b837876 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
> >
> >  * rk3568
> >       - Rockchip Evb-RK3568 (evb-rk3568)
> > +     - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
> >       - EmbedFire LubanCat 2 (lubancat-2-rk3568)
> >       - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
> >       - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
>
> With CONFIG_DEFAULT_FDT_FILE fixed, this is:
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
> remaining nits is fully up to you.


regards Frank

