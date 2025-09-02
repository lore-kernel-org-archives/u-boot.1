Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA1CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 13:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D2A832DD;
	Tue,  2 Sep 2025 15:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eKc4UQ2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860D5832EB; Tue,  2 Sep 2025 15:31:12 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC85832BC
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 15:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582DV4uM2594440;
 Tue, 2 Sep 2025 08:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756819864;
 bh=mqSlyEPQPh/WDVDAS54IzR/8TfckMjaHV/MHGWiTbHw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=eKc4UQ2FX/T1yt5xJdrxQ1CAy5722GnC/rPdVkXti4jss89RJnUP0iGRB0XY9BTp/
 vC4/FP5t+2uHjjvmUG16SclBIumylhnxgU8elcBmi3/2ve+Z5C+M+FD6usozfsY7Rg
 4aNj9toQYbaR5KxVqO0vkhNM0CrShkkM2iZ/LifM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582DV3bm2768816
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 08:31:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 08:31:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 08:31:03 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582DUwpU3853425;
 Tue, 2 Sep 2025 08:31:01 -0500
Message-ID: <a3ee7787-dc4a-4c69-8d72-e7b7052909e6@ti.com>
Date: Tue, 2 Sep 2025 19:00:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at
 SPL
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902102000.1388848-3-a-dutta@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 9/2/2025 3:49 PM, Anurag Dutta wrote:
> Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
> the necessary configs required to boot HyperFlash successfully, due to
> missing Kconfig dependencies. Now that the Kconfig dependencies have
> been added, re-enable the HBMC and MUX_MMIO configs in the SPL stage.
>
> Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   configs/j721e_evm_r5_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
> index ceb2e273b54..52290722686 100644
> --- a/configs/j721e_evm_r5_defconfig
> +++ b/configs/j721e_evm_r5_defconfig
> @@ -124,6 +124,7 @@ CONFIG_CFI_FLASH=y
>   CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
>   CONFIG_FLASH_CFI_MTD=y
>   CONFIG_SYS_FLASH_CFI=y
> +CONFIG_HBMC_AM654=y
>   CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_SOFT_RESET=y
> @@ -133,6 +134,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
>   CONFIG_MULTIPLEXER=y
> +CONFIG_SPL_MUX_MMIO=y
>   CONFIG_PINCTRL=y
>   # CONFIG_PINCTRL_GENERIC is not set
>   CONFIG_SPL_PINCTRL=y
