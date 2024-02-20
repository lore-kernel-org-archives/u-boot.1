Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C564C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 04:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4492887E0A;
	Tue, 20 Feb 2024 05:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FaFRcY5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE5787E0A; Tue, 20 Feb 2024 05:45:47 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C460C87F60
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K4jCeg087928;
 Mon, 19 Feb 2024 22:45:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708404312;
 bh=pcR1+5NFA74C8oaWUSEfeBzff8coD8Lj1WL1kJrI1T4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FaFRcY5bsRytj0LHjeX2hOxWZvuTcYphy1ItXNfDQXKr3N6s0IWARc/N5VGAFaCzd
 /mMBFZFInoeofoXuxq5ES7jL3by4jhIxtMpu9evxDlXaR6EwZLqsLQi8PlMEHamAB/
 vLJWM3ujqov3Zgc7SxbMYRu/EAPZCq7m/iunyIEY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K4jCjo017685
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Feb 2024 22:45:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 22:45:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 22:45:11 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K4j8I6124381;
 Mon, 19 Feb 2024 22:45:09 -0600
Message-ID: <d0b9bea0-bcfd-45ba-923f-5fc574a909a6@ti.com>
Date: Tue, 20 Feb 2024 10:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
Content-Language: en-US
To: Jesse Taube <mr.bossman075@gmail.com>, <u-boot@lists.denx.de>
CC: Giulio Benetti <giulio.benetti@benettiengineering.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Jesse

On 20/02/24 04:30, Jesse Taube wrote:
> Add support for booting the imxrt1050-evk from spi.
> Add imximage config and the ability for SPL to boot from NOR.
> Enable binman in Kconfig and device tree for imxrt* as it is used to
> prepend fspi_header.bin to SPL and u-boot.img.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>   - Add defconfig to MAINTAINERS
>   - Change Copyright of imximage-nor.cfg to myself
>   - Fix spelling and grammar
>   - Use imperative mood
> V2 -> V3:
>   - Enabled binman for imxrt*
> V3 -> V4:
>   - Mention binman in commit description
>   - Squash enabled binman and this commit
> ---
>   arch/arm/dts/imxrt1020-evk-u-boot.dtsi        |   4 +
>   arch/arm/dts/imxrt1050-evk-u-boot.dtsi        |  31 ++++++
>   arch/arm/dts/imxrt1170-evk-u-boot.dtsi        |   4 +
>   arch/arm/mach-imx/imxrt/Kconfig               |   1 +
>   board/freescale/imxrt1050-evk/MAINTAINERS     |   1 +
>   .../freescale/imxrt1050-evk/imximage-nor.cfg  |  42 ++++++++
>   board/freescale/imxrt1050-evk/imximage.cfg    |  10 +-
>   board/freescale/imxrt1050-evk/imxrt1050-evk.c |   7 +-
>   configs/imxrt1050-evk_defconfig               |   8 +-
>   configs/imxrt1050-evk_fspi_defconfig          | 100 ++++++++++++++++++
>   include/configs/imxrt1050-evk.h               |   6 ++
>   11 files changed, 208 insertions(+), 6 deletions(-)
>   create mode 100644 board/freescale/imxrt1050-evk/imximage-nor.cfg
>   create mode 100644 configs/imxrt1050-evk_fspi_defconfig
> 
> diff --git a/arch/arm/dts/imxrt1020-evk-u-boot.dtsi b/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
> index 46928c07e9..e246de0299 100644
> --- a/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
> @@ -5,6 +5,10 @@
>    */
>   
>   / {
> +	binman: binman {
> +		multiple-images;
> +	};
> +
>   	chosen {
>   		bootph-pre-ram;
>   	};
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
> diff --git a/arch/arm/dts/imxrt1170-evk-u-boot.dtsi b/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
> index f923a14301..6e892c1af7 100644
> --- a/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
> @@ -6,6 +6,10 @@
>    */
>   
>   / {
> +	binman: binman {
> +		multiple-images;
> +	};
> +
>   	chosen {
>   		bootph-pre-ram;
>   	};
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
> diff --git a/board/freescale/imxrt1050-evk/MAINTAINERS b/board/freescale/imxrt1050-evk/MAINTAINERS
> index a872855452..890825b39a 100644
> --- a/board/freescale/imxrt1050-evk/MAINTAINERS
> +++ b/board/freescale/imxrt1050-evk/MAINTAINERS
> @@ -4,3 +4,4 @@ S:	Maintained
>   F:	board/freescale/imxrt1050-evk
>   F:	include/configs/imxrt1050-evk.h
>   F:	configs/imxrt1050-evk_defconfig
> +F:	configs/imxrt1050-evk_fspi_defconfig
> diff --git a/board/freescale/imxrt1050-evk/imximage-nor.cfg b/board/freescale/imxrt1050-evk/imximage-nor.cfg
> new file mode 100644
> index 0000000000..3b80e1f178
> --- /dev/null
> +++ b/board/freescale/imxrt1050-evk/imximage-nor.cfg
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024
> + * Author(s): Jesse Taube <Mr.Bossman075@gmail.com>
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
> + * Unfortunately setting all to OCRAM only works for MMC
> + * and setting all to DTCM only works for FLEXSPI NOR.
> + * This configuration fortunately works for both SPI and MMC.
> +*/
> +/* Set first two banks FlexRAM as OCRAM(01b) and the rest to DTCM(10b) */
> +DATA 4 0x400AC044 0x55aaaaaa
> +/* Use FLEXRAM_BANK_CFG to config FlexRAM */
> +SET_BIT 4 0x400AC040 0x4
> +
> diff --git a/board/freescale/imxrt1050-evk/imximage.cfg b/board/freescale/imxrt1050-evk/imximage.cfg
> index f1f09fd7eb..b30d852194 100644
> --- a/board/freescale/imxrt1050-evk/imximage.cfg
> +++ b/board/freescale/imxrt1050-evk/imximage.cfg
> @@ -29,7 +29,13 @@ BOOT_FROM	sd
>    *	value	  value to be stored in the register
>    */

As a future plan do you think of moving .cfg files to within binman; you can see 
'ti-board-config' entry as an example (tools/binman/etype/ti_board_config.py)

[...]

-- 
Thanking You
Neha Malcom Francis
