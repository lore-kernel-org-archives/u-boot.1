Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E3DE8FDB3
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 20:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D0186E02;
	Tue,  3 Oct 2023 22:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Icc2FS2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC47D86E0B; Tue,  3 Oct 2023 22:27:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC4286DD5
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 22:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c8e=FS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696364859;
 bh=MycCUcmuIu5P3G+JhP4FGmvrYpgWOLTvqjefIaRWAjM=;
 b=Icc2FS2F0yDrAZbIFQPtWJ/VWVjkB83KvtxB5X2gPAer9h/2rftjgtgFp6s1q3ICbqPvbzv4Q
 yvb0xhYbzSYfb0wwDn0WyievzZz4W+RtCz35H6SAuJ5hC+g9ce+CnHaevWvfISrDdw7xjtTwnfM
 w9CzT3hLCsVG98NOan398yUJn4w0qJBWDa27BtqO+E5S17zQx+Xyn6LqHfOLKJn9+3bp+2egkjE
 MSZeOFr3GRUMUtzcjaqDe9GZ4ZpgD3dNxKTf7DGqhPsFyNO4Xy4q1H8qgZIUz3s+TVFrQHOF5BO
 vn8x7ISKrD0Cd6oo43OMF+BEeSs/uOPW0eyOKzUpKYqQ==
Message-ID: <8c7f5643-0130-ea31-bf3e-c05609abd8c0@kwiboo.se>
Date: Tue, 3 Oct 2023 22:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
To: Frank Wunderlich <linux@fw-web.de>, Frank Wunderlich
 <frank-w@public-files.de>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Joseph Chen <chenjh@rock-chips.com>,
 u-boot@lists.denx.de
References: <20230920184005.50931-1-linux@fw-web.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230920184005.50931-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 651c793b66e6eee6acc89e46
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

Hi Frank,

On 2023-09-20 20:40, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Bananapi R2 Pro board.
> 
> tested:
> - sdcard
> - both front usb-ports
> - sata
> - wan-port
> 
> lan-ports are connected to mt7531 switch where driver needs to be
> separated from mtk ethernet-driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> because iodomain is different to evb and now iodomain driver is sent as
> patch we need to separate between EVB and R2Pro else board can be bricked.
> 
> ethernet support depends on these series from jonas:
> 
> rockchip: Port IO-domain driver for RK3568 from linux
> https://patchwork.ozlabs.org/project/uboot/cover/20230821223020.3918620-1-jonas@kwiboo.se/
> and
> rockchip: Add GMAC support for RK3568 and RK3588
> https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.1701012-1-jonas@kwiboo.se/
> ---
> v5:
> - add line break in description
> - reorder in makefile
> - drop special dts-handling
>   (deletion of switchnode, disable of usb and gmac0)
> - add MAINTAINERS entry
> - changes to defconfig suggested by jonas
>   - remove "pinctrl-0 pinctrl-names" from CONFIG_OF_SPL_REMOVE_PROPS
>   - add CONFIG_SPL_DM_SEQ_ALIAS=y
>   - add CONFIG_SPL_PINCTRL=y
>   - remove CONFIG_USB_UHCI_HCD
>   - enable EFI_LOADER (defaults to y)
>   - drop CONFIG_SYSRESET_PSCI (reset works without)
> 
> v4:
> - add r2pro board to readme
> - update r2pro dts to linux version
> - remove switch node from linux dts
> - disable gmac0 because switch driver does not work yet
>   to solve timeout error:
>   ethernet@fe2a0000 Waiting for PHY auto negotiation to complete......... TIMEOUT!
>   phy_startup() failed: -110FAILED: -110ethernet@fe010000 Waiting for PHY auto nee
> - cleanup r2pro u-boot.dtsi like jonas suggests
> - update and reorder defconfig based on jonas suggestions
> - dts: disable usb_host0_ohci because of error on usb-start
>   scanning bus usb@fd840000 for devices...
>   ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>   not provide a handshake (OUT) (5)
>   unable to get device descriptor (error=-1)
> - pcie is not yet working, so not adding these options
>   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
>   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -110.
>   pcie_dw_rockchip pcie@fe270000: failed to init phy (ret=-110)
>   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
>   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -110.
>   pcie_dw_rockchip pcie@fe280000: failed to init phy (ret=-110)
> - emmc not tested as it is empty on my board because it breaks sdcard boot
> - rename dts and defconfig (add minus sign)
> - enable efi_loader in defconfig
> 
> v3:
> - disable gmac0 as switch-driver is not yet ready to attach to the mac
> 
> v2:
> - drop switch-node for now as u-boot driver works differently to linux
> ---
>  arch/arm/dts/Makefile                      |   1 +
>  arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi |  19 +
>  arch/arm/dts/rk3568-bpi-r2-pro.dts         | 852 +++++++++++++++++++++
>  board/rockchip/evb_rk3568/MAINTAINERS      |   7 +
>  configs/bpi-r2-pro-rk3568_defconfig        |  94 +++
>  doc/board/rockchip/rockchip.rst            |   1 +
>  6 files changed, 974 insertions(+)
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
>  create mode 100644 configs/bpi-r2-pro-rk3568_defconfig
> 

[...]

> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index cc9eb432a8b5..8c506162c01e 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -7,6 +7,13 @@ F:	configs/evb-rk3568_defconfig
>  F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
>  F:	arch/arm/dts/rk3568-evb.dts
>  
> +Banana Pi BPI-R2 Pro

Maintainer entries are typically in upper case. get_maintainer.pl does
not seem to mind, but use of uppercase seem to be the norm.

> +M:	Frank Wunderlich <frank-w@public-files.de>
> +S:	Maintained
> +F:	configs/bpi-r2-pro-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-bpi-r2-pro.dts
> +F:	arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> +
>  LUBANCAT-2
>  M:	Andy Yan <andyshrk@163.com>
>  S:	Maintained
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
> new file mode 100644
> index 000000000000..5989eab569b8
> --- /dev/null
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -0,0 +1,94 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2-pro"
> +CONFIG_SYS_PROMPT="BPI-R2PRO> "

Very few Rockchip boards use a custom prompt, is this needed?

> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro"

This is missing .dtb suffix, fdtfile env var ends up as:

  fdtfile=rockchip/rk3568-bpi-r2-pro

instead of:

  fdtfile=rockchip/rk3568-bpi-r2-pro.dtb

Resulting in possible a dtb-file not being loaded when an entry in
extlinux.conf use fdtdir instead of fdt value.

> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_SYSBOOT=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SUPPORT_EMMC_BOOT=y

arch/arm/mach-rockchip/spl.c override spl_mmc_boot_mode() to always
return MMCSD_MODE_RAW, so there should not be any need to include
support for MMCSD_MODE_EMMCBOOT.

> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y

Not seeing any pwm-regulator compatible in the DT, so this option could
be removed.

> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642b1..58f20b837876 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3568
>       - Rockchip Evb-RK3568 (evb-rk3568)
> +     - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
>       - EmbedFire LubanCat 2 (lubancat-2-rk3568)
>       - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
>       - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)

With CONFIG_DEFAULT_FDT_FILE fixed, this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

remaining nits is fully up to you.

Regards,
Jonas
