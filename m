Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE89C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 22:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F5482AA7;
	Tue, 10 Jun 2025 00:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E33682B07; Tue, 10 Jun 2025 00:52:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AB8EA81E06
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF6914BF;
 Mon,  9 Jun 2025 15:51:45 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017AA3F66E;
 Mon,  9 Jun 2025 15:52:03 -0700 (PDT)
Date: Mon, 9 Jun 2025 23:51:06 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 2/2] configs: add support for NetCube Systems Kumquat
Message-ID: <20250608165423.16bce5dd@minigeek.lan>
In-Reply-To: <20250607091141.439318-3-lukas.schmid@netcube.li>
References: <20250607091141.439318-1-lukas.schmid@netcube.li>
 <20250607091141.439318-3-lukas.schmid@netcube.li>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat,  7 Jun 2025 11:11:40 +0200
Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi Lukas,

thanks for taking care and sending a patch!

(CC:ing Paul, please mind his recent V3x U-Boot series here:
https://lore.kernel.org/linux-sunxi/20250601153943.2690123-1-contact@paulk.fr/T/#t)

> NetCube Systems Kumquat is a board based on the Allwinner V3s SoC,
> including:
> 
> - 64MB DDR2 included in SoC
> - 10/100 Mbps Ethernet
> - USB-C DRD
> - Audio Codec
> - Isolated CAN-FD
> - ESP32 over SDIO
> - 8MB SPI-NOR Flash for bootloader
> - I2C EEPROM for MAC addresses
> - SDIO Connector for eMMC or SD-Card
> - 8x 12/24V IOs, 4x normally open relays
> - DS3232 RTC with Battery Backup
> - QWIIC connectors for external I2C devices
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  configs/sun8i_v3s_netcube_kumquat_defconfig | 57 +++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 configs/sun8i_v3s_netcube_kumquat_defconfig
> 
> diff --git a/configs/sun8i_v3s_netcube_kumquat_defconfig b/configs/sun8i_v3s_netcube_kumquat_defconfig
> new file mode 100644
> index 00000000..7a03de16
> --- /dev/null
> +++ b/configs/sun8i_v3s_netcube_kumquat_defconfig

The defconfig names are just maker-model style, we do not use any sunxi
prefixes. So just name it "netcube_kumquat_defconfig".

> @@ -0,0 +1,57 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_ENV_SIZE=0x80000
> +CONFIG_ENV_OFFSET=0x100000

What are the reasons for the non-default environment size and location?
Isn't 64K just under 1MB enough? 512K sounds like a lot, what do you
store in there?

> +CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-netcube-kumquat"
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x180000
> +CONFIG_MACH_SUN8I_V3S=y
> +CONFIG_DRAM_CLK=360
> +CONFIG_SPL_SPI_SUNXI=y
> +# CONFIG_HAS_ARMV7_SECURE_BASE is not set
> +# CONFIG_TIMESTAMP is not set
> +CONFIG_SPI_BOOT=y

That symbol is admittedly somewhat misnamed, and is only needed on one
Atmel SoC, apparently. So please remove it.

> +CONFIG_BOOTDELAY=1
> +CONFIG_PREBOOT=""
> +# CONFIG_SYS_DEVICE_NULLDEV is not set
> +CONFIG_SPL_MTD=y
> +CONFIG_SYS_PROMPT="Kumquat> "  
> +CONFIG_CMD_EEPROM=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_RTC=y

Just curious, what is the RTC command used for? Do you really read or
set the time, or are there are configuration values you store in NVRAM?
And also, given all the commands, are there any custom boot scripts
you are using?

> +CONFIG_MTDIDS_DEFAULT="nor0=firmware"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=firmware:1M(u-boot)ro,512k(u-boot-env1),512k(u-boot-env2),-(user)"

That does not match what's described in the Kumquat readthedocs
documentation, is there any particular reason for that?

> +CONFIG_CMD_DIAG=y
> +# CONFIG_ENV_IS_IN_FAT is not set
> +CONFIG_ENV_SPI_MAX_HZ=1000000
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_USE_HOSTNAME=y
> +CONFIG_HOSTNAME="kumquat"
> +CONFIG_VERSION_VARIABLE=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_MISC=y
> +CONFIG_NVMEM=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> +CONFIG_MTD=y
> +CONFIG_SPI_FLASH_BAR=y

Do you really need this? It looks like the SPI flash is only 8MB in
size, and judging by the doc this is only needed for SPI flash chips
larger than 16MB.

> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_PHY_SUN4I_USB=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_DS3232=y
> +CONFIG_SPI=y
> +CONFIG_USB_MUSB_HOST=y
> +CONFIG_USB_MUSB_GADGET=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_ETHER_SMSC95XX=y

Why do you need all those Ethernet USB drivers? The board seems to have
the SoC EMAC connected, no?
Please note that the defconfig is not meant to reflect some useful
debug or bring-up configuration, but more a common setup. In the case
of this board I doubt that many people connect USB Ethernet adapters to
the only USB port to use in U-Boot?

Cheers,
Andre
 
> +# CONFIG_USB_ETHER is not set

