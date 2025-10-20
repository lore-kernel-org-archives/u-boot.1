Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49913CCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 22:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D98B82C84;
	Tue, 21 Oct 2025 00:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F82831D6; Tue, 21 Oct 2025 00:17:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6959782B20
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 00:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1A421063;
 Mon, 20 Oct 2025 15:17:05 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCA173F63F;
 Mon, 20 Oct 2025 15:17:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 23:16:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] configs: add support for NetCube Systems Kumquat
Message-ID: <20251020231639.1de9eba8@minigeek.lan>
In-Reply-To: <20250610053856.1873969-3-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
 <20250610053856.1873969-3-lukas.schmid@netcube.li>
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

On Tue, 10 Jun 2025 07:38:55 +0200
Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi Lukas,

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
>  configs/netcube_kumquat_defconfig | 45 +++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 configs/netcube_kumquat_defconfig
> 
> diff --git a/configs/netcube_kumquat_defconfig b/configs/netcube_kumquat_defconfig
> new file mode 100644
> index 00000000..cfe331cb
> --- /dev/null
> +++ b/configs/netcube_kumquat_defconfig
> @@ -0,0 +1,45 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-netcube-kumquat"
> +CONFIG_SPL=y
> +CONFIG_MACH_SUN8I_V3S=y
> +CONFIG_DRAM_CLK=360

This line is redundant, since it's the default. I would be removed by a
savedefconfig sync anyway.

> +CONFIG_SPL_SPI_SUNXI=y
> +# CONFIG_HAS_ARMV7_SECURE_BASE is not set
> +# CONFIG_TIMESTAMP is not set
> +CONFIG_BOOTDELAY=1
> +CONFIG_PREBOOT=""
> +# CONFIG_SYS_DEVICE_NULLDEV is not set
> +CONFIG_SPL_MTD=y
> +CONFIG_SYS_PROMPT="Kumquat> "  
> +CONFIG_CMD_EEPROM=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MTD=y
> +CONFIG_MTDIDS_DEFAULT="nor0=firmware"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=firmware:960k(u-boot)ro,64k(u-boot-env),-(user)"
> +CONFIG_CMD_DIAG=y
> +CONFIG_OF_UPSTREAM=y

This one is now redundant as well, as all V3 devices are now using the
DT rebasing repo DTs.

Since the rest looks fine, I just removed those lines and queued it for
the next PR.

For the records:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> +# CONFIG_ENV_IS_IN_FAT is not set
> +CONFIG_ENV_SPI_MAX_HZ=1000000
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
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_PHY_SUN4I_USB=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_DS3232=y
> +CONFIG_SPI=y
> +CONFIG_USB_MUSB_HOST=y
> +CONFIG_USB_MUSB_GADGET=y
> +# CONFIG_USB_ETHER is not set

