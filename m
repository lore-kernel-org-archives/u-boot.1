Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B5CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD11836D1;
	Sun, 26 Oct 2025 16:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YkGYwVPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C769B836D1; Sun, 26 Oct 2025 16:41:08 +0100 (CET)
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com
 [220.197.32.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3CA82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f17;
 Sun, 26 Oct 2025 23:41:01 +0800 (GMT+08:00)
Message-ID: <d4e3db60-b65c-4158-84d8-b2b0094f47c4@rock-chips.com>
Date: Sun, 26 Oct 2025 23:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] board: rockchip: Add Radxa ROCK 4D
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251019154728.846096-1-jonas@kwiboo.se>
 <20251019154728.846096-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019154728.846096-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212e1c4d03afkunme4ac25614d22cb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQklPVh5NGE0ZSxhLGE4ZHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=YkGYwVPicHm1phgPoOvtMmRZ3fXRbw4oymYYXz9RFxq10lKVJ9Xq9g07HRswcGdd/eCX3/toIgxcCbylP1wJn+DEUHCRf7Dl9Xxn56HnXMSu8Hw2xqpvMErG8m8QR60WJ+0rCjOCorzE8YBEI/UBgsIX9JsrtxMTdksIw3XDiEk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ZCeGNKTU5mJ+BqBC/DlO4UCqqTGkT+OMBkQPN7FVHog=;
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


On 2025/10/19 23:47, Jonas Karlman wrote:
> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
> numerous top-tier functions, features, and expansion options.
>
> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
>
> Features tested on a Radxa ROCK 4D v1.112:
> - SPI Flash boot
> - Ethernet
> - PCIe/NVMe
> - USB host
>
> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
> or directly from USB when the MASKROM button is pressed, booting
> directly from SD-card is not possible on these boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: No change
> v3: Drop the reset-gpios prop rename
> v2: Add comment about the reset-gpios prop rename
> ---
>   arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 10 ++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>   configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   4 files changed, 85 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>   create mode 100644 configs/rock-4d-rk3576_defconfig
>
> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> new file mode 100644
> index 000000000000..db46553b66a4
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +&sfc0 {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index 94ef74d429f9..54c75f451f0f 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -4,6 +4,12 @@ S:	Maintained
>   F:	arch/arm/dts/rk3576-generic*
>   F:	configs/generic-rk3576_defconfig
>   
> +ROCK-4D-RK3576
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3576-rock-4d*
> +F:	configs/rock-4d-rk3576_defconfig
> +
>   SIGE5-RK3576
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
> new file mode 100644
> index 000000000000..140a3e0ccd84
> --- /dev/null
> +++ b/configs/rock-4d-rk3576_defconfig
> @@ -0,0 +1,68 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=50000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-rock-4d.dtb"
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
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_MACRONIX=y
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
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de3aa79cb5c9..0ec56c8d068a 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
>        - ArmSoM Sige5 (sige5-rk3576)
>        - Firefly ROC-RK3576-PC (roc-pc-rk3576)
>        - Generic RK3576 (generic-rk3576)
> +     - Radxa ROCK 4D (rock-4d-rk3576)
>   
>   * rk3588
>        - ArmSoM Sige7 (sige7-rk3588)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

