Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99AAC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C93F80FEC;
	Tue, 22 Apr 2025 12:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fRGqLtB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A70281FC0; Tue, 22 Apr 2025 12:20:53 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0F8819FC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAKlao1191641
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 05:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745317247;
 bh=LmSGSApZR5k1+PXyE0+luR4GWB1oWKYfPse8onIfqCc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fRGqLtB7e5TSlnSdOLowTm/Fu6YgsOC20b7bli2LnuM/TNIYGr8sNysaI+49kl2Hx
 wi5RYqqqNNtR60KCmPrc8JcB/vZhuML9nj2h+BUEQW4MpTBEqMobfi5n4HEi/ksZoH
 Zk4Cb7MzV7iVm31S8eYP02I/czLb1pVmpdbBhIBc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAKlnK097599
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 05:20:47 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:20:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:20:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MAKjGm118880;
 Tue, 22 Apr 2025 05:20:46 -0500
Date: Tue, 22 Apr 2025 15:50:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 3/3] configs: am64x_evm_a53_defconfig: Enable configs for
 PCIe support
Message-ID: <08fff904-fed8-4df0-8785-a0c03d6f4ff6@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
 <20250416120830.138965-4-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416120830.138965-4-h-salunke@ti.com>
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

On Wed, Apr 16, 2025 at 05:38:30PM +0530, Hrushikesh Salunke wrote:
> TI's AM64 SoC has single instance of PCIe Controller namely PCIe0 which
> is Cadence PCIe Controller. To support PCIe functionality with PCIe0
> instance in Root-Complex mode enable corresponding configs. Also enable
> configs to support NVMe over PCIe.
> 
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  configs/am64x_evm_a53_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index c2ad1242d20..9fc95798ffb 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -31,6 +31,7 @@ CONFIG_SPL_FS_FAT=y
>  CONFIG_SPL_LIBDISK_SUPPORT=y
>  CONFIG_SPL_SPI_FLASH_SUPPORT=y
>  CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> @@ -70,6 +71,7 @@ CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
>  CONFIG_CMD_EFIDEBUG=y
> @@ -135,6 +137,9 @@ CONFIG_PHY_TI_DP83869=y
>  CONFIG_PHY_FIXED=y
>  CONFIG_TI_AM65_CPSW_NUSS=y
>  CONFIG_TI_ICSSG_PRUETH=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCI_CONFIG_HOST_BRIDGE=y
> +CONFIG_PCIE_CDNS_TI=y
>  CONFIG_PHY=y
>  CONFIG_SPL_PHY=y
>  CONFIG_PHY_CADENCE_TORRENT=y

Regards,
Siddharth.
