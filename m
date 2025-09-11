Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87B2CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 10:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD9383327;
	Thu, 11 Sep 2025 12:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DauyIMtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5628338C; Thu, 11 Sep 2025 12:33:19 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8B283303
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BAXF2Z274033;
 Thu, 11 Sep 2025 05:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757586795;
 bh=ise1E1RVMf2v4a81FC43ygQtGWqwiEXUmck+N5lyyhU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DauyIMtRkD9b7fsCebWZ7uJY590V24yk8fMolW2vyfLslGKa8PnGIDD75Zi5mfBHm
 MgaEcucFyn5ulNc8yq9DoVwOUAJ0AqQs41N6leCEFrChlTTyrkrGgGbD2O+JLk0ulN
 skC+Dsa+6aWEZyAj/5D3o/e3WFQp8jkGzLeWo0fA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BAXFbd435212
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 05:33:15 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 05:33:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 05:33:14 -0500
Received: from [10.24.72.162] (moteen-ubuntu-desk.dhcp.ti.com [10.24.72.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 58BAXA1Q1993202; Thu, 11 Sep 2025 05:33:11 -0500
Message-ID: <d4d668df-6aad-4c94-9f98-c7e465e2cef2@ti.com>
Date: Thu, 11 Sep 2025 16:03:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: j722s_evm_a53_defconfig: Disable eMMC HS400
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Andrew Davis" <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-5-jm@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250910214514.1848847-5-jm@ti.com>
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


On 11/09/25 03:15, Judith Mendez wrote:
> This patch addresses silicon errata i2478 [0] "MMCSD0: HS400 Mode not
> supported". Where, eMMC HS400 mode is not supported due to bus timing
> limitations. As per workaround, use HS200 mode instead.
>
> [0] https://www.ti.com/lit/pdf/sprz575
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   configs/j722s_evm_a53_defconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
> index 83ac99c922a..a7ab78a367a 100644
> --- a/configs/j722s_evm_a53_defconfig
> +++ b/configs/j722s_evm_a53_defconfig
> @@ -101,8 +101,8 @@ CONFIG_FS_LOADER=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
> -CONFIG_MMC_HS400_SUPPORT=y
> -CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y


Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen

