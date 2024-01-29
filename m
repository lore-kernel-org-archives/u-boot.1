Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F4BC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 09:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470787CD2;
	Mon, 29 Jan 2024 10:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="ClsO8Bqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BB487CE0; Mon, 29 Jan 2024 10:51:33 +0100 (CET)
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2456E87CD2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 10:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from [172.20.10.3] ([151.46.21.187])
 by Aruba Outgoing Smtp  with ESMTPSA
 id UOIarFZiSJYOgUOIar8zKn; Mon, 29 Jan 2024 10:51:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1706521889; bh=Z4elEBErOdqN5lWL/QDuglSn1MkOmPDijfMXkMMRKTw=;
 h=Date:MIME-Version:Subject:To:From:Content-Type;
 b=ClsO8BqfopZL6bSj9aQXD+qzbklbiDVenoUzxGi9yn4bTPqNuL1tqQkR8Rq0h4K9K
 1c5DqUhsAlwYQnfKEazX4Cf5uvEml6FDlkMImHI3FdKwbQaouESr/G6LRp9jNlhOmv
 339ner347nXWSBYgTDVrTVlM4w+jcb1ZA3fJBQfwUEpHLPvhM805xmQXSYVivT3xRY
 LvJbSwKbUvShPlY1dflyJv3Eh7I2Bmkxqs843ioXIye2cpRnTununyDskTyTOBgBfq
 E7sqwzyc4UzH7DCdhBqleY9TZgiexU3F8F1Yhi881XCtLbjYfx7fJ7ybdfo/5wikLN
 ywS0iQ0FxY0Bg==
Message-ID: <bd0e25f7-d93b-46e6-84e8-a1a21f9686cd@benettiengineering.com>
Date: Mon, 29 Jan 2024 10:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
Content-Language: en-US
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBp/5HYA4uqUcJyns/H+P3q7njNf1jOWzNXQscyTFD05GdcV+5VlXX8+7MCssIEoCAEQK+CA+Jd1zPO1DJLnfh2GQ/8Fn6Cg/kL5CjpG1N3lPXad0swp
 JS2mRsQK2HTaROYCrmN7ykq/fMscGvhdZlZM3+cT4uBAORql2887M+H40LX+qSNyYLub5wo88LKzqAR1FzDSIIppaFc0/OZoMmhb+GYzEYRprKKVzoxTcG4C
 QcLBzpu8gxFy4vg22FwN0A+ns1NmcQc87/i7wkFrifLbFCALDQB+Us6KmwZ7tlvAE3ObOLHt9bGsVMQtdGIiR+ETcmX9RdqK9G6AQqeOEs7XXmXUG6BgI7fG
 oxQXPmh2TyRDXm/tsSPnKFzGazF8Pw==
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

Hi Jesse,

On 28/01/24 22:43, Jesse Taube wrote:
> This add some macros to change addresses to use flexspi.
> 
> This commit adds support for booting the imxrt1050-evk from spi.
> It adds imximage config and the ability for SPL to boot from NOR.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>   arch/arm/dts/imxrt1050-evk-u-boot.dtsi        |  31 ++++++
>   arch/arm/mach-imx/imxrt/Kconfig               |   1 +
>   .../freescale/imxrt1050-evk/imximage-nor.cfg  |  41 +++++++
>   board/freescale/imxrt1050-evk/imximage.cfg    |  10 +-
>   board/freescale/imxrt1050-evk/imxrt1050-evk.c |   7 +-
>   configs/imxrt1050-evk_defconfig               |   8 +-
>   configs/imxrt1050-evk_fspi_defconfig          | 100 ++++++++++++++++++
>   include/configs/imxrt1050-evk.h               |   6 ++
>   8 files changed, 198 insertions(+), 6 deletions(-)
>   create mode 100644 board/freescale/imxrt1050-evk/imximage-nor.cfg
>   create mode 100644 configs/imxrt1050-evk_fspi_defconfig
> 
> diff --git a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
> index a9095e736b..3f54411b7b 100644
> --- a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
> @@ -8,6 +8,10 @@
>   #include "imxrt1050-pinfunc.h"
>   
>   / {
> +	binman: binman {
> +		multiple-images;
> +	};
> +
>   	aliases {
>   		display0 = &lcdif;
>   		usbphy0 = &usbphy1;
> @@ -113,6 +117,33 @@
>   	};
>   };
>   
> +&binman {
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +	imx-boot {
> +		filename = "flash.bin";
> +		pad-byte = <0x00>;
> +
> +		fspi_conf_block {
> +			filename = CONFIG_FSPI_CONF_FILE;
> +			type = "blob-ext";
> +			offset = <0x0>;
> +		};
> +
> +		spl {
> +			filename = "SPL";
> +			offset = <0x1000>;
> +			type = "blob-ext";
> +		};
> +
> +		binman_uboot: uboot {
> +			filename = "u-boot.img";
> +			offset = <0x10000>;
> +			type = "blob-ext";
> +		};
> +	};
> +#endif
> +};
> +
>   &osc {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/mach-imx/imxrt/Kconfig b/arch/arm/mach-imx/imxrt/Kconfig
> index c1d6b09e77..ccccf702f6 100644
> --- a/arch/arm/mach-imx/imxrt/Kconfig
> +++ b/arch/arm/mach-imx/imxrt/Kconfig
> @@ -2,6 +2,7 @@ if ARCH_IMXRT
>   
>   config IMXRT
>   	bool
> +	select BINMAN
>   	select SYS_FSL_ERRATUM_ESDHC135
>   
>   config IMXRT1020
> diff --git a/board/freescale/imxrt1050-evk/imximage-nor.cfg b/board/freescale/imxrt1050-evk/imximage-nor.cfg
> new file mode 100644
> index 0000000000..fb7b6489a3
> --- /dev/null
> +++ b/board/freescale/imxrt1050-evk/imximage-nor.cfg
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2019
> + * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>

thanks for giving me credits but I haven't worked on this, so please
drop my Copyright and add yours here.

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

> + */
> +
> +#include <config.h>
> +
> +/* image version */
> +
> +IMAGE_VERSION 2
> +
> +/*
> + * Boot Device : one of
> + * spi/sd/nand/onenand, qspi/nor
> + */
> +
> +BOOT_FROM	nor
> +
> +/*
> + * Device Configuration Data (DCD)
> + *
> + * Each entry must have the format:
> + * Addr-type           Address        Value
> + *
> + * where:
> + *	Addr-type register length (1,2 or 4 bytes)
> + *	Address	  absolute address of the register
> + *	value	  value to be stored in the register
> + */
> +
> +/*
> + * 0x400AC044 is used to configure the flexram.
> + * Unfortunatly seting all to OCRAM only works for MMC
> + * and setting all to DTCM only works for FLEXSPI NOR.
> + * This configureation fortunaly works for both SPI and MMC.
> +*/
> +/* Set first two banks FlexRAM as OCRAM(01b) and the rest to DTCM(10b) */
> +DATA 4 0x400AC044 0x55aaaaaa
> +/* Use FLEXRAM_BANK_CFG to config FlexRAM */
> +SET_BIT 4 0x400AC040 0x4
> diff --git a/board/freescale/imxrt1050-evk/imximage.cfg b/board/freescale/imxrt1050-evk/imximage.cfg
> index f1f09fd7eb..dd5c231b39 100644
> --- a/board/freescale/imxrt1050-evk/imximage.cfg
> +++ b/board/freescale/imxrt1050-evk/imximage.cfg
> @@ -29,7 +29,13 @@ BOOT_FROM	sd
>    *	value	  value to be stored in the register
>    */
>   
> -/* Set all FlexRAM as OCRAM(01b) */
> -DATA 4 0x400AC044 0x55555555
> +/*
> + * 0x400AC044 is used to configure the flexram.
> + * Unfortunatly seting all to OCRAM only works for MMC
> + * and setting all to DTCM only works for FLEXSPI NOR.
> + * This configureation fortunaly works for both SPI and MMC.
> +*/
> +/* Set first two banks FlexRAM as OCRAM(01b) and the rest to DTCM(10b) */
> +DATA 4 0x400AC044 0x55aaaaaa
>   /* Use FLEXRAM_BANK_CFG to config FlexRAM */
>   SET_BIT 4 0x400AC040 0x4
> diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> index 4b82ee5e9c..d4e39fd914 100644
> --- a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> +++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> @@ -68,7 +68,12 @@ void spl_board_init(void)
>   
>   u32 spl_boot_device(void)
>   {
> -	return BOOT_DEVICE_MMC1;
> +	/* There is no way to find boot device so look if there is valid IVT in RAM for MMC*/
> +	u32 nor_ivt = *(u32 *)(CONFIG_SYS_LOAD_ADDR - 0xC00);
> +
> +	if (nor_ivt == 0x402000d1)
> +		return BOOT_DEVICE_MMC1;
> +	return BOOT_DEVICE_NOR;
>   }
>   #endif
>   
> diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
> index 8b5ce4e735..086fc47ec2 100644
> --- a/configs/imxrt1050-evk_defconfig
> +++ b/configs/imxrt1050-evk_defconfig
> @@ -10,21 +10,22 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20280000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
>   CONFIG_ENV_OFFSET=0x80000
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="imxrt1050-evk"
> -CONFIG_SPL_TEXT_BASE=0x20209000
> +CONFIG_SPL_TEXT_BASE=0x20002000
>   CONFIG_TARGET_IMXRT1050_EVK=y
>   CONFIG_SPL_MMC=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_SIZE_LIMIT=0x20000
>   CONFIG_SPL=y
> -CONFIG_SYS_LOAD_ADDR=0x20209000
> +CONFIG_SYS_LOAD_ADDR=0x20002000
>   CONFIG_HAVE_SYS_UBOOT_START=y
>   CONFIG_SYS_UBOOT_START=0x800023FD
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_SD_BOOT=y
> +CONFIG_SPI_BOOT=y
>   # CONFIG_USE_BOOTCOMMAND is not set
>   CONFIG_SYS_CBSIZE=256
>   CONFIG_SYS_PBSIZE=276
> @@ -36,6 +37,7 @@ CONFIG_SPL_BOARD_INIT=y
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +CONFIG_SPL_NOR_SUPPORT=y
>   # CONFIG_BOOTM_NETBSD is not set
>   # CONFIG_BOOTM_PLAN9 is not set
>   # CONFIG_BOOTM_RTEMS is not set
> diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
> new file mode 100644
> index 0000000000..4b252cfa5d
> --- /dev/null
> +++ b/configs/imxrt1050-evk_fspi_defconfig
> @@ -0,0 +1,100 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_DCACHE_OFF=y
> +# CONFIG_SPL_SYS_DCACHE_OFF is not set
> +CONFIG_ARCH_IMXRT=y
> +CONFIG_TEXT_BASE=0x80002000
> +CONFIG_SYS_MALLOC_LEN=0x40000
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
> +CONFIG_ENV_OFFSET=0x80000
> +CONFIG_IMX_CONFIG="board/freescale/imxrt1050-evk/imximage-nor.cfg"
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="imxrt1050-evk"
> +CONFIG_SPL_TEXT_BASE=0x20002000
> +CONFIG_TARGET_IMXRT1050_EVK=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_SYS_LOAD_ADDR=0x20002000
> +CONFIG_HAVE_SYS_UBOOT_START=y
> +CONFIG_SYS_UBOOT_START=0x800023FD
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_SD_BOOT=y
> +CONFIG_SPI_BOOT=y
> +# CONFIG_USE_BOOTCOMMAND is not set
> +CONFIG_SYS_CBSIZE=256
> +CONFIG_SYS_PBSIZE=276
> +CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_NO_BSS_LIMIT=y
> +CONFIG_SPL_BOARD_INIT=y
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +CONFIG_SPL_NOR_SUPPORT=y
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_MII is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_TFTP_BLOCKSIZE=512
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +# CONFIG_OF_TRANSLATE is not set
> +CONFIG_SPL_CLK_IMXRT1050=y
> +CONFIG_CLK_IMXRT1050=y
> +# CONFIG_SPL_DM_GPIO is not set
> +CONFIG_MXC_GPIO=y
> +# CONFIG_INPUT is not set
> +CONFIG_FSL_USDHC=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PINCTRL_IMXRT=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_IMXRT_SDRAM=y
> +CONFIG_FSL_LPUART=y
> +CONFIG_TIMER=y
> +CONFIG_SPL_TIMER=y
> +CONFIG_IMX_GPT_TIMER=y
> +CONFIG_USB=y
> +# CONFIG_SPL_DM_USB is not set
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_LOGO=y
> +CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MXS=y
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_BMP_16BPP=y
> +CONFIG_SHA1=y
> +CONFIG_SHA256=y
> +CONFIG_HEXDUMP=y
> +CONFIG_FSPI_CONF_HEADER=y
> +CONFIG_FSPI_CONF_FILE="fspi_header.bin"
> +CONFIG_READ_CLK_SOURCE=0x03
> +CONFIG_DEVICE_TYPE=0x00
> +CONFIG_FLASH_PAD_TYPE=0x08
> +CONFIG_SERIAL_CLK_FREQUENCY=0x07
> +CONFIG_FSPI_COL_ADDR_W=0x03
> +CONFIG_FSPI_CONTROLLER_MISC=0x00000059
> +CONFIG_FSPI_FLASH_A1_SIZE=0x04000000
> +CONFIG_LUT_SEQUENCE="0xa0, 0x87, 0x18, 0x8b, 0x10, 0x8f, 0x06, 0xb3, 0x04, 0xa7"
> diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
> index 2af2dde2ae..b370e25105 100644
> --- a/include/configs/imxrt1050-evk.h
> +++ b/include/configs/imxrt1050-evk.h
> @@ -25,4 +25,10 @@
>   		"stderr=serial,vidconsole\0"
>   #endif
>   
> +/*
> + * Address of U-Boot for SPI NOR boot
> + */
> +
> +#define CFG_SYS_UBOOT_BASE			0x60010000
> +
>   #endif /* __IMXRT1050_EVK_H */

