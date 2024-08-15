Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86596C531DC
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 03:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100CD88A11;
	Thu, 15 Aug 2024 05:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EcLox7P/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D61887C38; Thu, 15 Aug 2024 05:20:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6067A88A1E
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F3KWUF111078;
 Wed, 14 Aug 2024 22:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723692032;
 bh=jvplLvkO8hhFqN5rWv8BLMtHotpVP3cMdvboUdImyYg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EcLox7P/4Tt5rijsZRK2wWk9FDTfiO2+CneYEOMu2Jrc8JIocc9NnOde23Z8gc2Ux
 xkb4VN9iAGkQt2KgQctaqQGkD3X6soQgCdUXsG3neaHgyF9JJcDdbyM8qsDl3STsMw
 lBr7oo1vfIZnySET3qpbwnrRlFm972utGFBIRvOA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F3KWsf013534
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 22:20:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:20:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 22:20:32 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47F3KR7Z047209;
 Wed, 14 Aug 2024 22:20:28 -0500
Message-ID: <df14e765-9deb-4443-814b-ae08f6700a6e@ti.com>
Date: Thu, 15 Aug 2024 08:50:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-7-5115d93cdeb2@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-7-5115d93cdeb2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
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

you are having additional changes (am68 and j721s2)  wrt subject of 
patch(j721s2) .

Let other reviewer suggest on that,


For Changes  LGTM.


>   CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
>   CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
>   CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
> diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
> index 6404b1cc3037..288379797432 100644
> --- a/configs/j721s2_evm_r5_defconfig
> +++ b/configs/j721s2_evm_r5_defconfig
> @@ -112,6 +112,7 @@ CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_FS_LOADER=y
>   CONFIG_SPL_FS_LOADER=y
> +CONFIG_K3_AVS0=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_SPL_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
> @@ -141,6 +142,11 @@ CONFIG_SPL_PINCTRL=y
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
