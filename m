Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B125FCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EACF836B2;
	Sun, 26 Oct 2025 16:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BaiSNT4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E563883700; Sun, 26 Oct 2025 16:41:35 +0100 (CET)
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com
 [220.197.32.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4493382E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f31;
 Sun, 26 Oct 2025 23:41:29 +0800 (GMT+08:00)
Message-ID: <81da7206-d273-4334-9117-8d7a5b8fc327@rock-chips.com>
Date: Sun, 26 Oct 2025 23:41:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi M5
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20251019165056.885394-1-jonas@kwiboo.se>
 <20251019165056.885394-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019165056.885394-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212e8a1703afkunmdff5369a4d248f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhlKVkJKSxgZHk9JQh9OT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=BaiSNT4HXLvrqItuTJLtXTkDTkeIaMDYTHdG1d1qGw1g6AQPtEFsRq9YuPRO5JRUzBgZ+JtFA2RqAA6T2AZYVznGRRTi32HVO++oxPyJP11urKrX5HKneQEg45AGGc60SKYJXI75lSuUc5rfRCiKlfzjBr2y1xn4fulWyYZBtoI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=VcKMWi19ohayzxOMJJf+UzyvQ2P5XoQa9GL/oYKtZmc=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/10/20 00:50, Jonas Karlman wrote:
> FriendlyElec NanoPi M5 with Rockchip RK3576 SoC (4x Cortex-A72,
> 4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU).
>
> Features tested on a NanoPi M5 2411:
> - SD-card boot
> - SPI flash boot
> - Ethernet
> - LEDs
> - PCIe/NVMe
> - USB HOST/OTG
> - USER button
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi | 22 +++++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>   configs/nanopi-m5-rk3576_defconfig        | 78 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   4 files changed, 107 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
>   create mode 100644 configs/nanopi-m5-rk3576_defconfig
>
> diff --git a/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi b/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
> new file mode 100644
> index 000000000000..0767fbb8168f
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +&led1 {
> +	default-state = "off";
> +};
> +
> +&led2 {
> +	default-state = "off";
> +};
> +
> +&led_sys {
> +	default-state = "on";
> +};
> +
> +&sfc1 {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index e236163992d7..393edd3984ce 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -4,6 +4,12 @@ S:	Maintained
>   F:	arch/arm/dts/rk3576-generic*
>   F:	configs/generic-rk3576_defconfig
>   
> +NANOPI-M5-RK3576
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3576-nanopi-m5*
> +F:	configs/nanopi-m5-rk3576_defconfig
> +
>   OMNI3576-RK3576
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
> new file mode 100644
> index 000000000000..28427390a62b
> --- /dev/null
> +++ b/configs/nanopi-m5-rk3576_defconfig
> @@ -0,0 +1,78 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=50000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-m5"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> +CONFIG_SF_DEFAULT_BUS=6
> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-m5.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 426c38b7189f..542cbc88f57e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -136,6 +136,7 @@ List of mainline supported Rockchip boards:
>   * rk3576
>        - ArmSoM Sige5 (sige5-rk3576)
>        - Firefly ROC-RK3576-PC (roc-pc-rk3576)
> +     - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
>        - Generic RK3576 (generic-rk3576)
>        - Luckfox Omni3576 (omni3576-rk3576)
>        - Radxa ROCK 4D (rock-4d-rk3576)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

