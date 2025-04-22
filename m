Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB56C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCD480F6B;
	Tue, 22 Apr 2025 17:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PLCHAQIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0896081273; Tue, 22 Apr 2025 17:21:13 +0200 (CEST)
Received: from mail-m19731112.qiye.163.com (mail-m19731112.qiye.163.com
 [220.197.31.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD5080F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bfc5fc4;
 Tue, 22 Apr 2025 23:21:01 +0800 (GMT+08:00)
Message-ID: <75ed6989-1910-4216-8393-0d3171f290b6@rock-chips.com>
Date: Tue, 22 Apr 2025 23:21:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: rockchip: add Xunlong Orange Pi 5 Max
To: Ilya Katsnelson <me@0upti.me>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>
References: <20250414-add-opi5-max-v3-1-50dc6808a115@0upti.me>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250414-add-opi5-max-v3-1-50dc6808a115@0upti.me>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRoZVhpDHk9LT0pCHUNLSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965e169aa003afkunm12bfc5fc4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Qzo5CTJJCkkaPgMiOFYh
 IRkwCxZVSlVKTE9OSEhOSU1JTU9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUpOTk9PNwY+
DKIM-Signature: a=rsa-sha256;
 b=PLCHAQIlOXkcVo9v7PoI/ubGvAFHbB8o16VRS6e9nah2BwKG0TRcFioRrIPPgVfNa2+vKofUyuKTw9MUvPtoFDqdPzyMX76eLzyrxBy7uHq6RkEh7uHCdSzaJsrlcYrO6ROFZrr+8uH67f6GG3YPpLeYypGKqYVc51yrFXOdUN4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CmLpcJFwMtqH3bq4j3KKOlqwiRnCmp9bno0gDCQ5SPM=;
 h=date:mime-version:subject:message-id:from;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2025/4/14 23:25, Ilya Katsnelson wrote:
> The 5 Max is another board in the Orange Pi 5 family.
>
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
>
> So, just reuse the config for the 5 Plus and adjust the DT names.
>
> Reviewed-by: Jonas Karlman<jonas@kwiboo.se>
> Signed-off-by: Ilya Katsnelson<me@0upti.me>

> ---
> The 5 Max is another board in the Orange Pi 5 family.
>
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
>
> So, just reuse the config for the 5 Plus and adjust the DT names.
>
> Signed-off-by: K900<me@0upti.me>
Why you have two signature?
> ---
> Changes in v3:
> - fixed silly copy/paste error
> - Link to v2:https://lore.kernel.org/r/20250412-add-opi5-max-v2-1-585197588511@0upti.me
>
> Changes in v2:
> - fixed pinctrl definition for the flash
> - added docs and MAINTAINERS entries
> - fixed signoff line to use my real name
> - Link to v1:https://lore.kernel.org/r/20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me
> ---
>   arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi | 20 ++++++
>   board/rockchip/evb_rk3588/MAINTAINERS          |  6 ++
>   configs/orangepi-5-max-rk3588_defconfig        | 89 ++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst                |  1 +
>   4 files changed, 116 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..afd33dd3248a92a721c2f5a6789f395a5b577ae5
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&fspim2_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index a858ab163f362f4fc0dd578830fe84b20d9ca429..f875dbed1ec21a7ba74637c5f0aef858de7f3d49 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -42,3 +42,9 @@ S:	Maintained
>   F:	configs/orangepi-5-plus-rk3588_defconfig
>   F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
>   F:	arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +
> +ORANGEPI-5-MAX-RK3588
> +M:	Ilya Katsnelson<me@0upti.me>
> +S:	Maintained
> +F:	configs/orangepi-5-max-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi

This should be before the ORANGEPI-5-PLUS-RK3588 to keep in alphabet sort.


Thanks,

- Kever

> diff --git a/configs/orangepi-5-max-rk3588_defconfig b/configs/orangepi-5-max-rk3588_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..a655dfe2d64168b2d6a3b400abd4c03d9d4bc402
> --- /dev/null
> +++ b/configs/orangepi-5-max-rk3588_defconfig
> @@ -0,0 +1,89 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-orangepi-5-max"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-max.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
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
> index 1407080f1f4fd226b80e34689a34c88f3c37150a..00d9587e9880937125f7ace229740f10f2c959c4 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -149,6 +149,7 @@ List of mainline supported Rockchip boards:
>        - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
>        - Turing Machines RK1 (turing-rk1-rk3588)
>        - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
> +     - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
>        - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
>        - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
>        - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
>
> ---
> base-commit: e458e103d4f5fb7aaf13e744c65916ab3ba4a18d
> change-id: 20250405-add-opi5-max-569b1e7a53b1
>
> Best regards,
