Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F25C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275C48785F;
	Tue,  9 Jan 2024 20:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ch0RlR35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD1ED8786F; Tue,  9 Jan 2024 20:16:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14A387855
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JGSVh008129;
 Tue, 9 Jan 2024 13:16:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704827788;
 bh=fAI5NYFgXb7OO9faXknkjzOcsCu+H/sYERF0Iz9LQC4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ch0RlR35LAmqjvGQ84GD8Q8MZ5Gc998UzJ4lmhqD5Hb1GWHowRME0FpnDpRB2EhHa
 bUuKeqk+CBOZYFTPG3bClmhc+T5lMmkx1VLWJffb/oTi96hzsckbvguIByEKJB777D
 lHDNPvpqlGX/wH/PjBczXR5SudVJeK8ZfjWvxSUI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JGSQX019937
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 13:16:28 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:16:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:16:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JGR4B105203;
 Tue, 9 Jan 2024 13:16:27 -0600
Date: Tue, 9 Jan 2024 13:16:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <michael@amarulasolutions.com>,
 <dario.binacchi@amarulasolutions.com>, <afd@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109191627.jn2b4nsczlsynik2@carpenter>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109122605.51951-5-rogerq@kernel.org>
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

On 14:26-20240109, Roger Quadros wrote:
> Enables configuration required for NAND in SPL and u-boot.
> 
> Enable MTD Driver model and MTD + UBI command line utilities.
> 
> Add mtdids/mtdparts for NAND as it is required for u-boot's
> MTD subsystem commands to recognize NAND partitions.
> 
> Add u-boot partition location.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  configs/am64x_evm_a53_defconfig | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index 05e35a8db6..e22153a958 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -66,10 +66,15 @@ CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:2m(NAND.tiboot3),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
> +CONFIG_CMD_UBI=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIST="k3-am642-evm k3-am642-sk"
> @@ -107,6 +112,9 @@ CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ADMA=y
>  CONFIG_SPL_MMC_SDHCI_ADMA=y
>  CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_SPL_MTD=y
> +CONFIG_DM_MTD=y
>  CONFIG_DM_SPI_FLASH=y
>  CONFIG_SPI_FLASH_SPANSION=y
>  CONFIG_SPI_FLASH_STMICRO=y
> @@ -161,3 +169,27 @@ CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_MASS_STORAGE=y
>  CONFIG_SPL_DFU=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_MEMORY=y
> +CONFIG_SPL_MEMORY=y
> +CONFIG_TI_GPMC=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_NAND_OMAP_GPMC=y
> +CONFIG_CMD_NAND=y
> +CONFIG_NAND_OMAP_ELM=y
> +CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW=y
> +CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
> +CONFIG_SYS_NAND_ONFI_DETECTION=y
> +CONFIG_SYS_NAND_PAGE_SIZE=0x1000
> +CONFIG_SYS_NAND_PAGE_COUNT=0x40
> +CONFIG_SYS_NAND_OOBSIZE=0x100
> +CONFIG_SPL_NAND_SUPPORT=y
> +CONFIG_SPL_NAND_DRIVERS=y
> +CONFIG_SPL_NAND_BASE=y
> +CONFIG_SPL_NAND_IDENT=y
> +CONFIG_SPL_NAND_ECC=y
> +CONFIG_SYS_NAND_MAX_CHIPS=1
> +CONFIG_SYS_MAX_NAND_DEVICE=1
> +# CONFIG_SPL_NAND_AM33XX_BCH is not set
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> +CONFIG_SYS_NAND_U_BOOT_OFFS=0x600000
> -- 
> 2.34.1
> 

Why not a config fragment?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
