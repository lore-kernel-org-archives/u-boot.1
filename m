Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9555BC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 16:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D2E8777D;
	Tue, 23 Jan 2024 17:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="w6/ROLRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4C48753A; Tue, 23 Jan 2024 17:31:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE8B87CA1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1752e7bf78=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40NCho5b004816; Tue, 23 Jan 2024 17:31:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=gEon+i6Gkoj04VHnPRqUpFSp30hco//lhQRWXjLlMUA=; b=w6
 /ROLRyysSzzm1+bMwp1PYjVlkXF+NJ3KbFyS0G+eJ+RZEKiN1KRSp9ZZEraXqnNP
 mQOlBXs1D5o0FHDoR5x/1XsPRbi0wCn3KqY2gUymeEKCG5GNOUlKdu3Qer88lZCg
 AwZ48dFyaD+0GQcZBcJnLsh7uQM4+e8qHUOUESTIeOVkhtdiA08rwr56LBbgERR4
 vgEWINvRLGEDhdPA9imkcIVIzyAPkIrhRg+R1dwTByilCRIVXThqTg+9LHOKqKdb
 0+MNqUFNZGS2EOPICZeXrXQs3f6k3sBGAs7379es9Z2vZzeX0wKPYUvRtQRKtczK
 TPWTecC4CNG6LKnYZE9Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vsrxmxe8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 17:31:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0A7E100056;
 Tue, 23 Jan 2024 17:31:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F880232FEE;
 Tue, 23 Jan 2024 17:31:30 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 17:31:30 +0100
Message-ID: <71b726a6-0fbc-4b57-b8e1-4524328442ee@foss.st.com>
Date: Tue, 23 Jan 2024 17:31:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: Don't suggest to build modules in Kconfig.
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: Patrice Chotard <patrice.chotard@st.com>, Arun Parameswaran
 <arun.parameswaran@broadcom.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
References: <20240123161816.108839-1-heinrich.schuchardt@canonical.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240123161816.108839-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
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



On 1/23/24 17:18, Heinrich Schuchardt wrote:
> U-Boot does not support building kernel modules.
> 
> Fixes: 3c0dbed232bd ("mmc: arm_pl180_mmci: adapt driver to DM usage")
> Fixes: 36645f45a048 ("drivers: mmc: Add sdhci driver for Broadcom iProc platform")
> Fixes: dadd43c14368 ("mmc: synquacer: Add SynQuacer F_SDH30 SDHCI driver")
> Fixes: b312c590bcd8 ("mmc: Add MMC support for stm32h7 Socs")
> Fixes: d24b69395949 ("mmc: mtk-sd: add SD/MMC host controller driver for MT7623 SoC")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/mmc/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index ffde442cb29..9ce331677b8 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -83,7 +83,7 @@ config ARM_PL180_MMCI
>  	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
>  	  Interface (PL180, PL181 and compatible) support.
>  	  If you have an ARM(R) platform with a Multimedia Card slot,
> -	  say Y or M here.
> +	  say Y here.
>  
>  config MMC_QUIRKS
>  	bool "Enable quirks"
> @@ -592,7 +592,7 @@ config MMC_SDHCI_IPROC
>  	  This selects the iProc SD/MMC controller.
>  
>  	  If you have a Broadcom IPROC platform with SD or MMC devices,
> -	  say Y or M here.
> +	  say Y here.
>  
>  	  If unsure, say N.
>  
> @@ -603,7 +603,7 @@ config MMC_SDHCI_F_SDH30
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  Needed by some Fujitsu/Socionext SoC for MMC / SD / SDIO support.
> -	  If you have a controller with this interface, say Y or M here.
> +	  If you have a controller with this interface, say Y here.
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_KONA
> @@ -797,7 +797,7 @@ config STM32_SDMMC2
>  	help
>  	  This selects support for the SD/MMC controller on STM32H7 SoCs.
>  	  If you have a board based on such a SoC and with a SD/MMC slot,
> -	  say Y or M here.
> +	  say Y here.
>  
>  config FTSDC010
>  	bool "Ftsdc010 SD/MMC controller Support"
> @@ -817,7 +817,7 @@ config MMC_MTK
>  	depends on OF_CONTROL
>  	help
>  	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
> -	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> +	  If you have a machine with a integrated SD/MMC card reader, say Y here.
>  	  This is needed if support for any SD/SDIO/MMC devices is required.
>  	  If unsure, say N.
>  

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
