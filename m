Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D0CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 10:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DD383327;
	Thu, 11 Sep 2025 12:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pz9kAKaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8024983335; Thu, 11 Sep 2025 12:32:13 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E5083303
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BAW8X3726908;
 Thu, 11 Sep 2025 05:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757586728;
 bh=4GX0Hlzv2Y7Qm9SsPfpRHfu6NPYiQCP0J13ePWGvnBc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Pz9kAKaWKpCHMh9CNMxcijcJfdcnHuWQl0lREtKhN/I+4P1ExN86qJSb4p9WcsYDB
 UA/ZEXuz0tUZGCPiKqih0clKWJ/IyH1PxjUQYvRmL/5swZgFyfNfr5EFHHJvE5nnSc
 L6tFaDAIDLlELS4RCiX8UIIePkttvx0Y/XuId/v8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BAW8qr1878269
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 05:32:08 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 05:32:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 05:32:08 -0500
Received: from [10.24.72.162] (moteen-ubuntu-desk.dhcp.ti.com [10.24.72.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 58BAW4L21992194; Thu, 11 Sep 2025 05:32:05 -0500
Message-ID: <e200b35d-cd20-43b5-ba0f-a2f81419ed75@ti.com>
Date: Thu, 11 Sep 2025 16:02:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: am62px/j722s: Remove non-spl HS400 support
 at r5 stage
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Andrew Davis" <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-4-jm@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250910214514.1848847-4-jm@ti.com>
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
> MMC_HS400_SUPPORT config does not enable eMMC HS400 support in R5 SPL
> stage, therefore cleanup from r5 defconfig file.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   configs/am62px_evm_r5_defconfig | 1 -
>   configs/j722s_evm_r5_defconfig  | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
> index cf4282eac02..80c15981d84 100644
> --- a/configs/am62px_evm_r5_defconfig
> +++ b/configs/am62px_evm_r5_defconfig
> @@ -88,7 +88,6 @@ CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_ESM_K3=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
> -CONFIG_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y
> diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
> index 8e2741c8d42..8e981ff48c2 100644
> --- a/configs/j722s_evm_r5_defconfig
> +++ b/configs/j722s_evm_r5_defconfig
> @@ -92,7 +92,6 @@ CONFIG_SYS_I2C_OMAP24XX=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_ESM_K3=y
> -CONFIG_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y

Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen
