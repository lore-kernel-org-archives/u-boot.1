Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B287ECD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 17:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45128800D;
	Mon,  1 Apr 2024 19:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ccNr1ZP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF458801D; Mon,  1 Apr 2024 19:03:59 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857BD87EF5
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 19:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431H3sVW022130;
 Mon, 1 Apr 2024 12:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711991034;
 bh=D4e5YqxsrG5PegyQqVymUBnq63iz9hHRY2OJesev1ug=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ccNr1ZP8Lw2zK5Bp+QJ8FH2fMJjA+q/V1jBXjEfMC1LlAFelOEsCdq1WWydYglEGh
 ZAN5t+zLq109T+mBgycAqrt2u4qK08TimH1LIVbJes3x/PEw43/zz1E5npK45ssA/9
 FWbHVAksSii+dvse2nx8RI++ab4tiwSsaKnVSWLA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431H3smb074933
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 12:03:54 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 12:03:54 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 12:03:54 -0500
Received: from [10.249.129.130] ([10.249.129.130])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431H3ow1123809;
 Mon, 1 Apr 2024 12:03:51 -0500
Message-ID: <347af20e-d3cf-426e-86dc-280653806f6f@ti.com>
Date: Mon, 1 Apr 2024 22:33:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: j721s2_evm_*_defconfig: Enable OSPI configs
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>
References: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
 <20240401-b4-upstream-j721s2-ospi-support-v1-4-20e4a0024db9@ti.com>
Content-Language: en-US
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240401-b4-upstream-j721s2-ospi-support-v1-4-20e4a0024db9@ti.com>
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


On 01/04/24 11:16, Manorit Chawdhry wrote:
> Enable OSPI related configs to boot using OSPI
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   configs/j721s2_evm_a72_defconfig | 3 +++
>   configs/j721s2_evm_r5_defconfig  | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
> index 92f69413fa40..6e7e161fa359 100644
> --- a/configs/j721s2_evm_a72_defconfig
> +++ b/configs/j721s2_evm_a72_defconfig
> @@ -50,6 +50,7 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_MTD=y
> +CONFIG_SPL_MTD_SUPPORT=y
>   CONFIG_SPL_DM_SPI_FLASH=y
>   CONFIG_SPL_NOR_SUPPORT=y
>   CONFIG_SPL_DM_RESET=y
> @@ -58,6 +59,8 @@ CONFIG_SPL_RAM_SUPPORT=y
>   CONFIG_SPL_RAM_DEVICE=y
>   # CONFIG_SPL_SPI_FLASH_TINY is not set
>   CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SF_DEFAULT_MODE=0
> +CONFIG_SF_DEFAULT_SPEED=25000000
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
>   CONFIG_SPL_THERMAL=y
> diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> index cb6b4a44864f..197b3284c12d 100644
> --- a/configs/j721s2_evm_r5_defconfig
> +++ b/configs/j721s2_evm_r5_defconfig
> @@ -57,6 +57,7 @@ CONFIG_SPL_FS_EXT4=y
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_MTD=y
> +CONFIG_SPL_MTD_SUPPORT=y
>   CONFIG_SPL_DM_SPI_FLASH=y
>   CONFIG_SPL_NOR_SUPPORT=y
>   CONFIG_SPL_DM_RESET=y
> @@ -66,6 +67,8 @@ CONFIG_SPL_RAM_DEVICE=y
>   CONFIG_SPL_REMOTEPROC=y
>   # CONFIG_SPL_SPI_FLASH_TINY is not set
>   CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SF_DEFAULT_MODE=0
> +CONFIG_SF_DEFAULT_SPEED=25000000
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
>   CONFIG_SPL_THERMAL=y


Reviewed-by: Apurva Nandan <a-nandan@ti.com>

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

