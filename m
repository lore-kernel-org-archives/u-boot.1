Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA5C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 04:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7EE884B4;
	Wed, 29 May 2024 06:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RXtmLxC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54571883D3; Wed, 29 May 2024 06:29:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0442688253
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 06:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T4TVE3108399;
 Tue, 28 May 2024 23:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716956971;
 bh=m9EvBV2le1ifgdK01zX2mqrKaMUI1K8TK9li51ZnPvE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RXtmLxC30SL1z8mNFmSCzTV+IFfORQy7K84u0l+LQb5uGawPWhIx5nD0FYNLt0n0y
 jMqjEp7Tm62ai5Wb0N7KTcnA1DkEO+YEEYQg4ASYin1vR1ELbUqyCVs6Q4/k+npX/O
 5WWbLiJkAhAxhlrQf/HKAVvyIufSGPyZSLVZFoj8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T4TVod114114
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 23:29:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 23:29:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 23:29:30 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T4TQgh061069;
 Tue, 28 May 2024 23:29:27 -0500
Message-ID: <7eea6c58-9a75-4453-be2f-043f7abc20e8@ti.com>
Date: Wed, 29 May 2024 09:59:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
 <20240528-b4-upstream-j721s2-avs-v2-7-df940f2309d0@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-7-df940f2309d0@ti.com>
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


On 5/28/2024 1:43 PM, Manorit Chawdhry wrote:
> Add AVS and PMIC regulator configs
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   configs/am68_sk_r5_defconfig    | 4 ++++
>   configs/j721s2_evm_r5_defconfig | 6 ++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
> index e9b6882c1f68..f4800ef1b8ac 100644
> --- a/configs/am68_sk_r5_defconfig
> +++ b/configs/am68_sk_r5_defconfig
> @@ -5,6 +5,10 @@ CONFIG_ARCH_K3=y
>   CONFIG_SOC_K3_J721S2=y
>   CONFIG_TARGET_J721S2_R5_EVM=y
>   
> +CONFIG_K3_AVS0=n
> +CONFIG_DM_REGULATOR_TPS65941=n
> +CONFIG_PMIC_TPS65941=n
> +

Extra line


>   CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
>   CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
>   CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
> diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> index 3c958cafbe8f..f8a42a9a2ef6 100644
> --- a/configs/j721s2_evm_r5_defconfig
> +++ b/configs/j721s2_evm_r5_defconfig
> @@ -111,6 +111,7 @@ CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_FS_LOADER=y
>   CONFIG_SPL_FS_LOADER=y
> +CONFIG_K3_AVS0=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_SPL_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
> @@ -140,6 +141,11 @@ CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_SINGLE=y
>   CONFIG_POWER_DOMAIN=y
>   CONFIG_TI_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_TPS65941=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_TPS65941=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>   CONFIG_RESET_TI_SCI=y
>
