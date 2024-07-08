Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C64CC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB62188758;
	Mon,  8 Jul 2024 16:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448059;
	bh=BC4ZuTWUirLEcB84bKR1trzhKQu6vqfL78vbyoIIs7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAOUTb2SittdomVnqds0U7hbcq6a0wX8IRSQToYgVgqiAoThRoJi9W8KupKDgTy/g
	 V/jFJ+7AZ3+lTw5cBb2IFOsVHNtcstOuL0covd7CVKoELRBu04/LdwmtJImee07KoG
	 /Y53AZ91rbJO4yTWA7bFE3Pn5a7+1uk+BbOMSNaY/eObQUkUQvbfjKK5WepPWbKECE
	 7Gc8H/k+U4dtlWjAXjQwFbAbVYjLA3jfCJaJLENhH8GOHcMDA9aAWC/lSjoCrwntCh
	 s32TJWqJuUlyBeVBFCNYbcAzuKKkaBFx+LfMm2zgoFzH7wMkiahRysOQLFfHeYEVVK
	 VndtCkuMnD0FQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65B588763; Mon,  8 Jul 2024 16:14:18 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AA488756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WHmMV55LCz9tBs;
 Mon,  8 Jul 2024 16:14:14 +0200 (CEST)
Message-ID: <8ecbf593-fee0-4b34-82c2-6c1d1d6da821@denx.de>
Date: Mon, 8 Jul 2024 16:14:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] configs: add mvebu_espressobin_ultra-88f3720_defconfig
Content-Language: en-US
To: Benjamin Schneider <bschnei@gmail.com>, u-boot@lists.denx.de
Cc: Benjamin Schneider <ben@bens.haus>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240530044815.176360-1-ben@bens.haus>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240530044815.176360-1-ben@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/30/24 06:47, Benjamin Schneider wrote:
> Add support for a Marvell Armada 3720 device variant
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
> Changes in v3:
> - Fix typo in MAINTAINERS
> 
>   board/Marvell/mvebu_armada-37xx/MAINTAINERS   |   5 +
>   .../mvebu_espressobin_ultra-88f3720_defconfig | 106 ++++++++++++++++++
>   2 files changed, 111 insertions(+)
>   create mode 100644 configs/mvebu_espressobin_ultra-88f3720_defconfig
> 
> diff --git a/board/Marvell/mvebu_armada-37xx/MAINTAINERS b/board/Marvell/mvebu_armada-37xx/MAINTAINERS
> index 9b0afeef10..e96499e161 100644
> --- a/board/Marvell/mvebu_armada-37xx/MAINTAINERS
> +++ b/board/Marvell/mvebu_armada-37xx/MAINTAINERS
> @@ -9,3 +9,8 @@ ESPRESSOBin BOARD
>   M:	Konstantin Porotchkin <kostap@marvell.com>
>   S:	Maintained
>   F:	configs/mvebu_espressobin-88f3720_defconfig
> +
> +ESPRESSOBin Ultra BOARD
> +M:	Ben Schneider <ben@bens.haus>
> +S:	Maintained
> +F:	configs/mvebu_espressobin_ultra-88f3720_defconfig
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> new file mode 100644
> index 0000000000..c6ffaaabca
> --- /dev/null
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -0,0 +1,106 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_ARCH_MVEBU=y
> +CONFIG_TEXT_BASE=0x00000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
> +CONFIG_TARGET_MVEBU_ARMADA_37XX=y
> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x3F0000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/armada-3720-espressobin-ultra"
> +CONFIG_SYS_LOAD_ADDR=0x6000000
> +CONFIG_PCI=y
> +CONFIG_AHCI=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_SYS_MAXARGS=32
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SATA=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_WDT=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_BTRFS=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_SQUASHFS=y
> +CONFIG_CMD_FS_UUID=y
> +CONFIG_MAC_PARTITION=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ARP_TIMEOUT=200
> +CONFIG_NET_RETRY_COUNT=50
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_AHCI_MVEBU=y
> +CONFIG_LBA48=y
> +CONFIG_SYS_64BIT_LBA=y
> +CONFIG_CLK=y
> +CONFIG_CLK_MVEBU=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MV=y
> +CONFIG_MISC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_XENON=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_DM_DSA=y
> +CONFIG_MV88E6XXX=y
> +CONFIG_MVNETA=y
> +CONFIG_MVMDIO=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCI_AARDVARK=y
> +CONFIG_PHY=y
> +CONFIG_MVEBU_COMPHY_SUPPORT=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_ARMADA_37XX=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DEFAULT_ENV_IS_RW=y
> +CONFIG_MVEBU_A3700_UART=y
> +CONFIG_MVEBU_A3700_SPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_ARMADA_37XX=y
> +CONFIG_SHA1=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_PCF8563=y
> +# CONFIG_DEBUG_UART=y
> +# CONFIG_DEBUG_UART_BASE=0xd0012000
> +# CONFIG_DEBUG_UART_CLOCK=25804800
> +# CONFIG_DEBUG_UART_SHIFT=2
> +# CONFIG_DEBUG_UART_ANNOUNCE=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
