Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D256CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 21:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312518691A;
	Mon, 18 Sep 2023 23:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="a6Jyiqjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08BE865A5; Mon, 18 Sep 2023 23:45:33 +0200 (CEST)
Received: from s.wfbtzhsv.outbound-mail.sendgrid.net
 (s.wfbtzhsv.outbound-mail.sendgrid.net [159.183.224.104])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4049F865A5
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 23:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=fGRB3woew9jrbqu4OsKfQ9OVi4uxuhKIkldmFeukdJY=;
 b=a6Jyiqjjt7PY+gYL1k1Ky9jJai6t6/nnLoo3hWjdVHBFHIG793dfIRc1zfxe5hCL4nOH
 duGnNUDY/Wq9gxcJLkt/71GqLvWADLSPvPFsMap9RLjnOVzma1WgPdT6g1dWDSq+SzxcII
 hBECJlAqV5B0GaBh2z206eKNxaVtVkYn/P9ioyIzueTXNXk7xHRxE+E+v8YuAgOjarPrKD
 0nWZdp0B5PuRPazky5h3fn6J2Q8svhQD6kgwTbPUmf6nFDr1ACE18of5qrFcatwxIEd2SA
 dD2uHLJ4XAguCwo1Hh2be0tgS+HVjZw7Zgk4TNhuL/LO+DUvQtMUVn0M54I6CVsg==
Received: by filterdrecv-d7bbbc8bf-s5hdm with SMTP id
 filterdrecv-d7bbbc8bf-s5hdm-1-6508C4F9-36
 2023-09-18 21:45:29.85183556 +0000 UTC m=+290030.040576247
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-1 (SG) with ESMTP
 id B45-D6MMROGmJ7wS_YMPnQ Mon, 18 Sep 2023 21:45:29.498 +0000 (UTC)
Message-ID: <b9f21c58-f20e-0a23-5ec2-6610684af680@kwiboo.se>
Date: Mon, 18 Sep 2023 21:45:30 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
References: <20230918173624.31464-1-linux@fw-web.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230918173624.31464-1-linux@fw-web.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h09AK8UveDf28Tr=2FN?=
 =?us-ascii?Q?i9rktI=2FJ1J0gLLIpXOP5z=2FdfPJxQYRNa29xpVdd?=
 =?us-ascii?Q?pWNBIl+krXAedMaR=2F=2FOCZikT3bYyvKlZNVAxfpp?=
 =?us-ascii?Q?w5xO=2FWtbsqdVpXzAgkZYuOJz7FlUTCYMJXcwJ02?=
 =?us-ascii?Q?Qm5ERkrVMtNOLARFgXpcfw+CiWMjcOsCBfjwiR?=
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

Hi Frank,

On 2023-09-18 19:36, Frank Wunderlich wrote:
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
> lan-ports are connected to mt7531 switch where driver needs to be separated from mtk ethernet-driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> because iodomain is different to evb and now iodomain driver is sent as
> patch we need to separate between EVB and R2Pro else board can be bricked.
> ---
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

Looks like this board use PCIe bifurcation and would depend on my rk35xx
PCIe bifurcation series to at least have a chance to work. (looks like
it is applied based on your log rows).

Could there be an issue with a regulator not being enabled in time?
Please use regulator cmd to enable all regulators prior to running the
pci enum cmd, and see if that changes anything.

> - emmc not tested as it is empty on my board because it breaks sdcard boot
> 
> v3:
> - disable gmac0 as switch-driver is not yet ready to attach to the mac
> 
> v2:
> - drop switch-node for now as u-boot driver works differently to linux
> ---
>  arch/arm/dts/Makefile                     |   3 +-
>  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  28 +
>  arch/arm/dts/rk3568-bpi-r2pro.dts         | 852 ++++++++++++++++++++++
>  configs/bpi-r2pro-rk3568_defconfig        |  95 +++
>  doc/board/rockchip/rockchip.rst           |   1 +
>  5 files changed, 978 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts

The DT file is named rk3568-bpi-r2-pro.dts in linux, please use same
name in U-Boot. Same goes for defconfig-file, please name it
bpi-r2-pro-rk3568_defconfig to match DT filename.

>  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157b1..71c557e87e9e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -183,7 +183,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>  	rk3568-nanopi-r5s.dtb \
>  	rk3568-odroid-m1.dtb \
>  	rk3568-radxa-e25.dtb \
> -	rk3568-rock-3a.dtb
> +	rk3568-rock-3a.dtb \
> +	rk3568-bpi-r2pro.dtb

Please sort the dtb files alphabetically.

>  
>  dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>  	rk3588-edgeble-neu6a-io.dtb \
> diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> new file mode 100644
> index 000000000000..089e54f8cece
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi

[...]

> diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk3568_defconfig
> new file mode 100644
> index 000000000000..df4daed865f0
> --- /dev/null
> +++ b/configs/bpi-r2pro-rk3568_defconfig
> @@ -0,0 +1,95 @@
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
> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2pro"
> +CONFIG_SYS_PROMPT="BPI-R2PRO> "
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
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2pro"

Should be rockchip/rk3568-bpi-r2-pro.dtb to match linux.

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
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

Would recommend you to remove "pinctrl-0 pinctrl-names " from this
and add CONFIG_SPL_DM_SEQ_ALIAS=y to match other rk3568 boards.

> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SUPPORT_EMMC_BOOT=y

Not sure eMMC boot partitions are useful on Rockchip. It is not enabled
on any other rk356x board. Should we enabled it for other rk356x boards?

> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y

This Kconfig options is still in a pending series, please remove or
mention that this patch has a dependency on my rk35xx GMAC series.

> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y

Would recommend you to add CONFIG_SPL_PINCTRL=y here. It should not hurt
to let SPL configure pinctrl for sd-card/emmc before it tries to load
the FIT image for storage media.

> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y

I am not seeing any pwm regulator in the DT so this line can probably be
removed.

> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y

Is this working/being used? Normal sysreset from cru driver should work.

> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_UHCI_HCD=y

Is this Kconfig options used for anything? Does not look like there is
any other board using this, should be safe to remove this line.

> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> +# CONFIG_EFI_LOADER is not set

I would recommend you to remove this line to allow EFI boot on this board.

With EFI enabled users should be able to use a plain aarch64 distro
installers to setup a system. Fedora, openSUSE, Ubuntu are a few distros
that currently works with some minor quirks.

For an incomplete guide on how a distro installer could be used, see:
https://wiki.pine64.org/wiki/Quartz64_UEFI_with_U-Boot

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642b1..a639215d904e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3568
>       - Rockchip Evb-RK3568 (evb-rk3568)
> +     - BananaPi R2 Pro (bpi-r2pro-rk3568_defconfig)

Please use the full market name, Banana Pi BPI-P2 Pro, if I am not
mistaken, also remove _defconfig and only keep bpi-r2-pro-rk3568 in
parentheses.

>       - EmbedFire LubanCat 2 (lubancat-2-rk3568)
>       - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
>       - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)

An entry for this board should be added to a MAINTAINERS-file, probably
board/rockchip/evb_rk3568/MAINTAINERS, because it is using that boards
config.

Regards,
Jonas

