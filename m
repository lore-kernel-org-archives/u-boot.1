Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E021DC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 21:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EA782B5C;
	Fri, 11 Apr 2025 23:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AbzUXthL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9560D82B92; Fri, 11 Apr 2025 23:53:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B1982B54
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 23:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fee=W6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744408425;
 bh=QtkvqtXfV8rX9+6XqY1EgRBzREFmQY4Eew32PsGRj8U=;
 b=AbzUXthLiQoI5mUutKJB2MiU83unrNfESx081W4d6VR1ieEzMs7+qJRNYViRGf56QYBmq2Eyu
 qfkLBucL2Xy5A2AyF5so1Y22okzDqge1jjRwae+etb7Y3uKJmJutDZ4k7C81u59VXTbIL7Awlt4
 zibJlAb2/1Pfy6lDrErbciJZwAnQQuv3BWbICVXkOG3AHMauzBWC+6dMUe3N6fktuAN0cAl6VCi
 mYWA4pw7iq4wMNrV5jLSIrPbAKomHFDAm20Jd0ly4yQtgC8lIZnkBpQ5z8w7MlptLMvse/onxs0
 X9SHJ+7PS5XTPniQQwr29/enphAfIVSwg1I6huVxTgiA==
X-Forward-Email-ID: 67f98f66a8be77febed3f2f5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <52438f52-792b-4cc9-b7db-813561debd80@kwiboo.se>
Date: Fri, 11 Apr 2025 23:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Xunlong Orange Pi 5 Max
To: K900 <me@0upti.me>
References: <20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 2025-04-05 22:46, K900 wrote:
> The 5 Max is another board in the Orange Pi 5 family.
> 
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
> 
> So, just reuse the config for the 5 Plus and adjust the DT names.
> 
> Signed-off-by: K900 <me@0upti.me>

For Linux kernel you need to be using a known identity (no anonymous
contributions), not sure about U-Boot.

> ---
> The 5 Max is another board in the Orange Pi 5 family.
> 
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
> 
> So, just reuse the config for the 5 Plus and adjust the DT names.
> ---
>  arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi | 20 ++++++
>  configs/orangepi-5-max-rk3588_defconfig        | 89 ++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..1ab31a4ec5ab31810039e480189d373a3bb50061
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&fspim1_pins {

This board use fspim2_pins, please change.

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
> 
> ---
> base-commit: e458e103d4f5fb7aaf13e744c65916ab3ba4a18d
> change-id: 20250405-add-opi5-max-569b1e7a53b1
> 
> Best regards,

This is missing an entry in board/rockchip/evb_rk3588/MAINTAINERS
and please also add the board to doc/board/rockchip/rockchip.rst.

Regards,
Jonas
