Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E4C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 04:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD33987D70;
	Sun, 25 Feb 2024 05:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZLidq/LG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6EA87D70; Sun, 25 Feb 2024 05:48:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB548272A
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41P4mM6B090185;
 Sat, 24 Feb 2024 22:48:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708836502;
 bh=BBQ38PNleH9I5i++Q97Z7bdEcOdzWMOAWrhO6zxySts=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZLidq/LGc2yYjZpl9ZTcmziVfdTUYgSg44Sh18LElB4XT575gRkd/KJJB0PWLNDJj
 kTRMdBof4Wuc3yUyghQoNgrNYVbFmaUwINWe9V7ZxG1F6TgC+yND4k7vCseUK2BmM4
 8MbMRXVtqvnSorJAB8lthoDil97Aa094xXzDmVAs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41P4mM6d125066
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 24 Feb 2024 22:48:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Feb 2024 22:48:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Feb 2024 22:48:22 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41P4mKOs005187;
 Sat, 24 Feb 2024 22:48:21 -0600
Message-ID: <10f17a14-c99d-453d-bf32-73dbf7540d51@ti.com>
Date: Sun, 25 Feb 2024 10:18:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] configs: j721e: Enable OSPI memory
Content-Language: en-US
To: Jonathan Humphreys <j-humphreys@ti.com>, <trini@konsulko.com>,
 <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
 <20240224002307.2284386-2-j-humphreys@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240224002307.2284386-2-j-humphreys@ti.com>
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


On 2/24/2024 5:53 AM, Jonathan Humphreys wrote:
> Set config values to enable OSPI functionality.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   configs/j721e_evm_a72_defconfig | 7 +++++++
>   configs/j721e_evm_r5_defconfig  | 6 ++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
> index 74af5bebb5..1b39dd7c86 100644
> --- a/configs/j721e_evm_a72_defconfig
> +++ b/configs/j721e_evm_a72_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SOC_K3_J721E=y
>   CONFIG_TARGET_J721E_A72_EVM=y
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
> +CONFIG_SF_DEFAULT_SPEED=25000000
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_DM_GPIO=y
>   CONFIG_SPL_DM_SPI=y
> @@ -142,7 +143,13 @@ CONFIG_FLASH_CFI_MTD=y
>   CONFIG_SYS_FLASH_CFI=y
>   CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
>   CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_SPI_FLASH_MTD=y
>   CONFIG_MULTIPLEXER=y
> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
> index bc4f35cce1..59c0c4135c 100644
> --- a/configs/j721e_evm_r5_defconfig
> +++ b/configs/j721e_evm_r5_defconfig
> @@ -10,6 +10,7 @@ CONFIG_K3_EARLY_CONS=y
>   CONFIG_TARGET_J721E_R5_EVM=y
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41cf59f0
> +CONFIG_SF_DEFAULT_SPEED=25000000
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_DM_GPIO=y
>   CONFIG_SPL_DM_SPI=y
> @@ -128,7 +129,12 @@ CONFIG_FLASH_CFI_MTD=y
>   CONFIG_SYS_FLASH_CFI=y
>   CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   CONFIG_PINCTRL=y
>   # CONFIG_PINCTRL_GENERIC is not set
>   CONFIG_SPL_PINCTRL=y
