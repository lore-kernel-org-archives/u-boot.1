Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2185F33801
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AAA83FA3;
	Tue, 17 Mar 2026 07:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M9HqYuWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D77B83FB6; Tue, 17 Mar 2026 07:21:39 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA4283DB6
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CleES+nSepyL2MF0Akkd3nDl6AjPQxoQZrFvG93ul1Mkl319dSQADaojXCU/kHYMvo4Qn3bEIY1YL1jt+0p16DeXJUP7mIxCt/Ad/IOKbdLGtb7sE48GZBzzwg8KKrbq05TAEVbH1AIzPqJC1RJPfsVb+HpTOJJobBVv8fSryTiDTpFNc9CQ4Kih7JwuO7ClS4ac0A9hUKHtkmfTYiIQMqI05zWHvGsuwBjR4QLuNfoDyymnbcY7pSfTGhVqfvF5gmaydYOklJ4MAaD4AhXDDFurr/tkj3r0uTHTVFrbXsGjjA9MWZ8UpmVhNvaAlthgAow3Cg2Febyr8OBVQMfG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NthdqgyaG9IKBcNLmjorCTvjVtcaNAN+gh+KHsAuU3o=;
 b=iR4mfAd3b9Jjn053onHAi48NCWFxGNGBnxAfryVnqy9fSNp5ThRTAlaHw4jbXbAm6xMv3o14cUaXllJaPfp6WKBSkqe4OY9SStTmYVXPpg07+xgkYTXQNwN9zPUy/TS/1CYWfOXRsmLzO6lOitieSX/CBf78LYKsOskMZNVyMverg1eFpNx02l115Wq15g8PHqQSX+nUeybQiVY1JFYj30sg03FN8C5rTwWSakkXdOPIUBTPLGL3FLQKdaXQ5Jc4+YbDmyaQ+U0YpvZhWwG3DchdCmsFtpmN49bkaXiBEdskgOe5yeX2LGYxwBGHTcbLvVPKbI2EEfJYN8Y5x7tWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NthdqgyaG9IKBcNLmjorCTvjVtcaNAN+gh+KHsAuU3o=;
 b=M9HqYuWlNfGf1diwa2mJfXE+n4q3Z2oX77AJmlXc+CdJjrUQu+3HaroRfblKxQ76IAhWTu9C8RJ7O523D2lwdx18nNKlWqpR00JNV+vzf7rEr9tQ0YLB+eyrTlguv7fjHWrvopnwZv3zoXbsXHmJau2gxtwKFeWvX4NjlzN/kcM=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 PH8PR10MB6575.namprd10.prod.outlook.com (2603:10b6:510:225::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.18; Tue, 17 Mar 2026 06:21:34 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::1) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 06:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 06:21:33 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:21:25 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:21:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 01:21:24 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H6LNbF2655121;
 Tue, 17 Mar 2026 01:21:24 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Mar 2026 11:51:23 +0530
Message-ID: <DH4U9SAX4CR6.36CGITXOROQTA@ti.com>
Subject: Re: [PATCH] core: Rework REGMAP symbols implementation
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317012419.4162359-1-trini@konsulko.com>
In-Reply-To: <20260317012419.4162359-1-trini@konsulko.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|PH8PR10MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8feba3f9-bb3e-4703-e113-08de83ed6f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TpARgeURC+WwjcuXp9MlLf2GuOCDxiBgkx7BWKuqNQ5xE72OMDJwirBE4e32nUX+nnhMvrwyOJgXxIM8EwoOD5fVH+dfTIHVxpJyucCloP+YcBzs24YHmq4gSeIyHlYhKW5IEnTdwHEbUqM54TKl2N8CvJM6PtvmGU4lECSuS0lJyKz+Y8XFCb/tQa2RV01eYTBLP+gge+qBafBo7Op8vZPC5KvEw9ExG0q0XBi/vUa304H8M/q4dLjz9NLufSUwxmDz2bKSXbI5aa+UWfoRjmvldEd55JgusOkUj0SFFVHKZWQA41zfE26ddoqR45IsWpDVH3Hl2mgIt1K3m1vZhfSrb4qauImRAFqkNZaqOGGUa+TgF7dFd3L/GNsr6fY29Phi3Q6RKPjdvDk3dkD/8ii844ZG1utQmX3j8XTQK3NGC7qJT6/gEP/Yj5h8+82LjJ5XNst3BxD1ksrfaLaC8ALhEEoorFQUSjN0HGmjSbLsuuZGykUly2W4iS9NPmrAXEvw4+9sjKdHNeFo9eiWIRJ31TpfZiAAfAx0wdWO3C9K5LocLG1r7ERP2QDEuawvBKwvFU+8yNTQX4ip6lpscjp/za6jl7rW3EuGvzR/mb2x1dw5jd8u6BQXnqprzQcT5Lsz7yCJod2/R5+XGL3AACHIHIZYoxltJXzLmfilVfEdH2djDb3VTgZL1tjxWsarYGyOcBS6r4L+epWePw8DIUN7mNVD7+uYtik0utMhmXvz6v9yIET42GoCHPPiUAHO2W1nqPtJ4H2X8YpnPcbzDA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zy+ojp8KPLhW532XhoJourv1OxlWblZuhTRHZShk+ysLdL1OjRKsAsl1oY0lxq3KquTKsedwjMtyxBY+TnyZ6XpmWzADoyAVqACB76RQXY3IMm0f0h+Got2AWgwNzvrTI4NgjBlRS11zZdeUqSkQGPHZ3mf7AhLJDVVcdgdK5hdF5rhsLU6HaO+4T6+aqdnT3KKQUamfVjwV47U9rVjve27KjtsCIPeiYoCxV/Ym16kVGtsOC7wR8v4EpTcrWjOkGb54MyVRinh0eUp4GOMyamMqMTC+DaNZS7VQjVGvSzJ86bUKg4M5b7k2yj5jRkeAJ5fgtMqqznBXIYz2e4gQzE5jqqMR8J4Bshk8n9ANFm6l23e/KdlsEwTs1HpjiZSOfOa3iEqCMRJdGvbDgx6IaZaGWzWKcY/89GeFNm6IBFl4nyDrPjm3cU7g0yOSWAQG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:21:33.3059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feba3f9-bb3e-4703-e113-08de83ed6f7a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6575
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

On Tue Mar 17, 2026 at 6:54 AM IST, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for REGMAP (and xPL variants). As this is a library function, it should
> always be selected and not depended on by other functionality. This is
> largely done correctly today, so just correct the few outliers.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-airoha/Kconfig       |  1 +
>  arch/arm/mach-aspeed/Kconfig       |  1 +
>  arch/powerpc/cpu/mpc83xx/Kconfig   |  1 +
>  configs/imx8m_data_modul.config    |  1 -
>  configs/imx95_evk.config           |  1 -
>  configs/imx_dhsom.config           |  1 -
>  configs/kontron-osm-s-mx8mp.config |  1 -
>  configs/kontron-osm-s-mx93.config  |  1 -
>  configs/renesas_rcar64.config      |  1 -
>  drivers/clk/microchip/Kconfig      |  1 -
>  drivers/core/Kconfig               | 19 +++++++++++--------
>  drivers/misc/Kconfig               |  3 ++-
>  drivers/mmc/Kconfig                |  3 ++-
>  13 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
> index b9cd0a413e10..4b0374001d0c 100644
> --- a/arch/arm/mach-airoha/Kconfig
> +++ b/arch/arm/mach-airoha/Kconfig
> @@ -10,6 +10,7 @@ config TARGET_EN7523
>  	bool "Airoha EN7523 SoC"
>  	select CPU_V7A
>  	select ARMV7_SET_CORTEX_SMPEN
> +	select REGMAP
>  	help
>  	  The Airoha EN7523 family (en7523/en7529/en7562) is an ARM-based
>  	  SoCs with a dual-core CPU. It comes with Wi-Fi 5/6 support and
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index 9cf60378c118..c88b1e59366e 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -18,6 +18,7 @@ config ASPEED_AST2500
>  	bool "Support Aspeed AST2500 SoC"
>  	select CPU_ARM1176
>  	select DM_RESET
> +	select REGMAP
>  	help
>  	  The Aspeed AST2500 is a ARM-based SoC with arm1176 CPU.
>  	  It is used as Board Management Controller on many server boards,
> diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/=
Kconfig
> index 8ac83420ee22..0dc72c874237 100644
> --- a/arch/powerpc/cpu/mpc83xx/Kconfig
> +++ b/arch/powerpc/cpu/mpc83xx/Kconfig
> @@ -73,6 +73,7 @@ config TARGET_KMTEPR2
>  config TARGET_GAZERBEAM
>  	bool "Support gazerbeam"
>  	select ARCH_MPC8308
> +	select REGMAP
>  	select SYS_FSL_ERRATUM_ESDHC111
>  	imply ENV_IS_IN_FLASH
>  	help
> diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.c=
onfig
> index 4634a0972f09..18c7bb536fa0 100644
> --- a/configs/imx8m_data_modul.config
> +++ b/configs/imx8m_data_modul.config
> @@ -149,7 +149,6 @@ CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX8M=3Dy
>  CONFIG_POWER_DOMAIN=3Dy
>  CONFIG_PROT_TCP_SACK=3Dy
> -CONFIG_REGMAP=3Dy
>  CONFIG_RGMII=3Dy
>  CONFIG_RTC_M41T62=3Dy
>  CONFIG_SF_DEFAULT_SPEED=3D50000000
> diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
> index 3db583cce597..e7832d86fe91 100644
> --- a/configs/imx95_evk.config
> +++ b/configs/imx95_evk.config
> @@ -92,7 +92,6 @@ CONFIG_ETHPRIME=3D"eth0"
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SYS_RX_ETH_BUFFER=3D8
>  CONFIG_SPL_DM=3Dy
> -CONFIG_REGMAP=3Dy
>  CONFIG_SYSCON=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
>  CONFIG_CLK=3Dy
> diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
> index 4a3ddc7e90b7..a0d67c8a0688 100644
> --- a/configs/imx_dhsom.config
> +++ b/configs/imx_dhsom.config
> @@ -28,7 +28,6 @@ CONFIG_ENV_SECT_SIZE_AUTO=3Dy
>  CONFIG_ENV_REDUNDANT=3Dy
>  CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
> =20
> -CONFIG_REGMAP=3Dy
>  CONFIG_SYSCON=3Dy
> =20
>  CONFIG_DM_GPIO=3Dy
> diff --git a/configs/kontron-osm-s-mx8mp.config b/configs/kontron-osm-s-m=
x8mp.config
> index a8881726e079..786fd3e7a6de 100644
> --- a/configs/kontron-osm-s-mx8mp.config
> +++ b/configs/kontron-osm-s-mx8mp.config
> @@ -117,7 +117,6 @@ CONFIG_TFTP_TSIZE=3Dy
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_DM=3Dy
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> -CONFIG_REGMAP=3Dy
>  CONFIG_SYSCON=3Dy
>  CONFIG_BOOTCOUNT_LIMIT=3Dy
>  CONFIG_BOOTCOUNT_ENV=3Dy
> diff --git a/configs/kontron-osm-s-mx93.config b/configs/kontron-osm-s-mx=
93.config
> index a6d316de3d87..c2d4de4efa8a 100644
> --- a/configs/kontron-osm-s-mx93.config
> +++ b/configs/kontron-osm-s-mx93.config
> @@ -115,7 +115,6 @@ CONFIG_TFTP_TSIZE=3Dy
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_DM=3Dy
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> -CONFIG_REGMAP=3Dy
>  CONFIG_SYSCON=3Dy
>  CONFIG_ADC=3Dy
>  CONFIG_ADC_IMX93=3Dy
> diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.confi=
g
> index c2cb88dc157f..da4b262fc6a5 100644
> --- a/configs/renesas_rcar64.config
> +++ b/configs/renesas_rcar64.config
> @@ -6,7 +6,6 @@ CONFIG_CMD_TEMPERATURE=3Dy
>  CONFIG_DM_THERMAL=3Dy
>  CONFIG_PHY_ANEG_TIMEOUT=3D20000
>  CONFIG_RCAR_GEN3_THERMAL=3Dy
> -CONFIG_REGMAP=3Dy
>  CONFIG_REMAKE_ELF=3Dy
>  CONFIG_RENESAS_RPC_SPI=3Dy
>  CONFIG_SUPPORT_RAW_INITRD=3Dy
> diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfi=
g
> index 62072e100b18..6ac7c9c56547 100644
> --- a/drivers/clk/microchip/Kconfig
> +++ b/drivers/clk/microchip/Kconfig
> @@ -2,6 +2,5 @@ config CLK_MPFS
>  	bool "Clock support for Microchip PolarFire SoC"
>  	depends on CLK && CLK_CCF
>  	depends on SYSCON
> -	depends on REGMAP
>  	help
>  	  This enables support clock driver for Microchip PolarFire SoC platfor=
m.
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index c9253099e6ea..5419bf65b5d6 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -195,7 +195,7 @@ config DM_DMA
>  	  the physical address space.
> =20
>  config REGMAP
> -	bool "Support register maps"
> +	bool
>  	depends on DM
>  	select DEVRES
>  	help
> @@ -206,7 +206,7 @@ config REGMAP
>  	  direct memory access.
> =20
>  config SPL_REGMAP
> -	bool "Support register maps in SPL"
> +	bool
>  	depends on SPL_DM
>  	help
>  	  Hardware peripherals tend to have one or more sets of registers
> @@ -216,7 +216,7 @@ config SPL_REGMAP
>  	  direct memory access.
> =20
>  config TPL_REGMAP
> -	bool "Support register maps in TPL"
> +	bool
>  	depends on TPL_DM
>  	help
>  	  Hardware peripherals tend to have one or more sets of registers
> @@ -226,7 +226,7 @@ config TPL_REGMAP
>  	  direct memory access.
> =20
>  config VPL_REGMAP
> -	bool "Support register maps in VPL"
> +	bool
>  	depends on VPL_DM
>  	help
>  	  Hardware peripherals tend to have one or more sets of registers
> @@ -237,7 +237,7 @@ config VPL_REGMAP
> =20
>  config SYSCON
>  	bool "Support system controllers"
> -	depends on REGMAP
> +	select REGMAP
>  	help
>  	  Many SoCs have a number of system controllers which are dealt with
>  	  as a group by a single driver. Some common functionality is provided
> @@ -246,7 +246,8 @@ config SYSCON
> =20
>  config SPL_SYSCON
>  	bool "Support system controllers in SPL"
> -	depends on SPL_REGMAP
> +	depends on SPL_DM
> +	select SPL_REGMAP
>  	help
>  	  Many SoCs have a number of system controllers which are dealt with
>  	  as a group by a single driver. Some common functionality is provided
> @@ -255,7 +256,8 @@ config SPL_SYSCON
> =20
>  config TPL_SYSCON
>  	bool "Support system controllers in TPL"
> -	depends on TPL_REGMAP
> +	depends on TPL_DM
> +	select TPL_REGMAP
>  	help
>  	  Many SoCs have a number of system controllers which are dealt with
>  	  as a group by a single driver. Some common functionality is provided
> @@ -264,7 +266,8 @@ config TPL_SYSCON
> =20
>  config VPL_SYSCON
>  	bool "Support system controllers in VPL"
> -	depends on VPL_REGMAP
> +	depends on VPL_DM
> +	select VPL_REGMAP
>  	help
>  	  Many SoCs have a number of system controllers which are dealt with
>  	  as a group by a single driver. Some common functionality is provided
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index a0aa290480eb..798f1dbf26cf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -350,7 +350,8 @@ config MXS_OCOTP
> =20
>  config NPCM_HOST
>  	bool "Enable support espi or LPC for Host"
> -	depends on REGMAP && SYSCON
> +	depends on SYSCON
> +	select REGMAP
>  	help
>  	  Enable NPCM BMC espi or LPC support for Host reading and writing.
> =20
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 39caf2eff1b7..22bd3a972bdf 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -627,8 +627,9 @@ config MMC_SDHCI_AM654
>  	depends on ARCH_K3
>  	depends on MMC_SDHCI
>  	depends on OF_CONTROL
> -	depends on REGMAP
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select REGMAP
> +	select SPL_REGMAP if SPL_MMC

With this there should be no need to explicitly set REGMAP configs like
we do in most of K3 defconfigs for using MMC.

Acked-by: Anshul Dalal <anshuld@ti.com>

>  	help
>  	  Support for Secure Digital Host Controller Interface (SDHCI)
>  	  controllers present on TI's AM654 SOCs.

