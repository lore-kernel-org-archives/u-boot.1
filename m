Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC146CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF556868AE;
	Mon, 16 Oct 2023 10:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697445473;
	bh=bGNd7KsFxfulqCPw0eOHwvn5W4vBzilVNXcD6VZYVME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TKh9cQw9+Crudys2d8cMw5kyRJ977nxYqbJ3KTTAo6+5EpnxS+m5W07QT+fgrvwxP
	 piu3XegU25rQktFs8zYjTmqRrG+rVrMM6pZRwzMfBxfqxbo8ZxOqCwq5bXtuCm1jav
	 kRBUdISDV1fDBPSjJpkr64q/3p9s9nQlNv5EioQ4U8lAPsuIOB2a66e6P0GaVC6A5r
	 HIf1RwftX2JbKUicZMM85MznJ2aAsnOO7kowMOuB/nL2aVDXYSCO7Lad3xMYoLw+o0
	 0RF3puhWuKuUju34Lgcv9f2kzNtXDd2Y947LQVa+a3lUg43A9h7dKXhrh/dxOuLsNl
	 VdRYV4f0HJRdA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5C386C3E; Mon, 16 Oct 2023 10:37:51 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9735386BCF
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S89V14vJMz9sZS;
 Mon, 16 Oct 2023 10:37:45 +0200 (CEST)
Message-ID: <d9801245-eeba-4b54-9b38-7f3b25cdb6fd@denx.de>
Date: Mon, 16 Oct 2023 10:37:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm: mvebu: clearfog: Add defconfigs for eMMC booting
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231008124621.18803-1-josua@solid-run.com>
 <20231008124621.18803-4-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231008124621.18803-4-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S89V14vJMz9sZS
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

Hi Josua,

On 10/8/23 14:46, Josua Mayer wrote:
> Armada 388 can boot from either eMMC data, boot0 or boot1 partitions.
> 
> data partition requires booting from LBA-4096 to avoid conflict with
> MBR. When booting from boot0/boot1 environment should be stored there
> respectively, too.
> 
> Add 3 new defconfigs, for each eMMC partition:
> - clearfog_emmcboot0_defconfig
> - clearfog_emmcboot1_defconfig
> - clearfog_emmcdata_defconfig

Do we really need new, separate defconfig files for those very similar
configurations? Or is there a way to detect this at runtime or if not
possible to include a common defconfig file?

Just checking...

Thanks,
Stefan

> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   configs/clearfog_emmcboot0_defconfig | 82 ++++++++++++++++++++++++++++
>   configs/clearfog_emmcboot1_defconfig | 82 ++++++++++++++++++++++++++++
>   configs/clearfog_emmcdata_defconfig  | 82 ++++++++++++++++++++++++++++
>   3 files changed, 246 insertions(+)
>   create mode 100644 configs/clearfog_emmcboot0_defconfig
>   create mode 100644 configs/clearfog_emmcboot1_defconfig
>   create mode 100644 configs/clearfog_emmcdata_defconfig
> 
> diff --git a/configs/clearfog_emmcboot0_defconfig b/configs/clearfog_emmcboot0_defconfig
> new file mode 100644
> index 00000000000..215b7708a0d
> --- /dev/null
> +++ b/configs/clearfog_emmcboot0_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
> +CONFIG_ARCH_MVEBU=y
> +CONFIG_TEXT_BASE=0x00800000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
> +CONFIG_TARGET_CLEARFOG=y
> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
> +CONFIG_SPL_TEXT_BASE=0x40000030
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK=0x4002c000
> +CONFIG_SPL=y
> +CONFIG_DEBUG_UART_BASE=0xf1012000
> +CONFIG_DEBUG_UART_CLOCK=250000000
> +CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x22fd0
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x40023000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SYS_MAXARGS=32
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_SPL_CMD_TLV_EEPROM=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_MIN_ENTRIES=128
> +CONFIG_SYS_MMC_ENV_PART=1
> +CONFIG_ARP_TIMEOUT=200
> +CONFIG_NET_RETRY_COUNT=50
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_AHCI_MVEBU=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SPL_I2C_EEPROM=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_MV=y
> +CONFIG_MTD=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_MVNETA=y
> +CONFIG_MII=y
> +CONFIG_MVMDIO=y
> +CONFIG_PCI_MVEBU=y
> +CONFIG_SCSI=y
> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550=y
> +CONFIG_KIRKWOOD_SPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> diff --git a/configs/clearfog_emmcboot1_defconfig b/configs/clearfog_emmcboot1_defconfig
> new file mode 100644
> index 00000000000..59f88c64a2e
> --- /dev/null
> +++ b/configs/clearfog_emmcboot1_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
> +CONFIG_ARCH_MVEBU=y
> +CONFIG_TEXT_BASE=0x00800000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
> +CONFIG_TARGET_CLEARFOG=y
> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
> +CONFIG_SPL_TEXT_BASE=0x40000030
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK=0x4002c000
> +CONFIG_SPL=y
> +CONFIG_DEBUG_UART_BASE=0xf1012000
> +CONFIG_DEBUG_UART_CLOCK=250000000
> +CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x22fd0
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x40023000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SYS_MAXARGS=32
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_SPL_CMD_TLV_EEPROM=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_MIN_ENTRIES=128
> +CONFIG_SYS_MMC_ENV_PART=2
> +CONFIG_ARP_TIMEOUT=200
> +CONFIG_NET_RETRY_COUNT=50
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_AHCI_MVEBU=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SPL_I2C_EEPROM=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_MV=y
> +CONFIG_MTD=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_MVNETA=y
> +CONFIG_MII=y
> +CONFIG_MVMDIO=y
> +CONFIG_PCI_MVEBU=y
> +CONFIG_SCSI=y
> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550=y
> +CONFIG_KIRKWOOD_SPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> diff --git a/configs/clearfog_emmcdata_defconfig b/configs/clearfog_emmcdata_defconfig
> new file mode 100644
> index 00000000000..335b50e3c48
> --- /dev/null
> +++ b/configs/clearfog_emmcdata_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
> +CONFIG_ARCH_MVEBU=y
> +CONFIG_TEXT_BASE=0x00800000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
> +CONFIG_TARGET_CLEARFOG=y
> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
> +CONFIG_SPL_TEXT_BASE=0x40000030
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK=0x4002c000
> +CONFIG_SPL=y
> +CONFIG_DEBUG_UART_BASE=0xf1012000
> +CONFIG_DEBUG_UART_CLOCK=250000000
> +CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x22fd0
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x40023000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x1000
> +CONFIG_SPL_I2C=y
> +CONFIG_SYS_MAXARGS=32
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_SPL_CMD_TLV_EEPROM=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_MIN_ENTRIES=128
> +CONFIG_ARP_TIMEOUT=200
> +CONFIG_NET_RETRY_COUNT=50
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_AHCI_MVEBU=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SPL_I2C_EEPROM=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_MV=y
> +CONFIG_MTD=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_MVNETA=y
> +CONFIG_MII=y
> +CONFIG_MVMDIO=y
> +CONFIG_PCI_MVEBU=y
> +CONFIG_SCSI=y
> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550=y
> +CONFIG_KIRKWOOD_SPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
