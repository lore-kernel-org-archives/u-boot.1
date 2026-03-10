Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7832FD2D97
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E466E83FF5;
	Tue, 10 Mar 2026 14:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kqtPTPgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C7B84006; Tue, 10 Mar 2026 14:50:05 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8E483FEE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 14:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAL+RysqmFW1QUYuc8+zhX4O5M3yt6xTspQqX3khgfPDAZ/+UEXNv4kOaDw19bpj6LYgr/a9KXPS1RFcf4DmGDUZIIjhSwn+pp19TrMFJ+fhHoXAh/8OPC7tejUG6UGrWVELpFY02YIjsKo6OVt/3ebGks7zH2ifa0MAttntJEK/G6j1wgZPDSZxRLUK/3QSCdxRxhA5mCfYXnOVHVZVBmFNftmyRr2G0U3AIKdyueIesAoxRujCQoqgbpT2m5ay23pp+WtCn1oXZWshMmBye9BaGGHlNPTepgNqho+7A8AlXSAdDO43FwvLHv3hL4Hw6Gk6oTaz7pz98YLsmL4bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7LjBTUyiz03JFyzcL7BytAsJlXEaRf3XmTo+OlPWgs=;
 b=O3dlkjEyT6GujcHIfMORAd04H0ZyOKdqG6O1kQ22k8mvHo5Kwvot+6FmMur5fh5e2TJ8zdbS2Pt5DT6QbhM8HeNq/DzD3dC1oV5J78i+FDtFN+YhlV1lLhzc9X1WLs0Xu90KDRhpYH75fF9v6mt1Lmb5+GU2r7GjsRjjg7kWpBvy8H2BNgaH/a1SFvof/dMe+xZdoDmNNnrKGPacdBj6xQzQvOjqsJf4NNPyYnBEKRAj2GApgHq7wYlufPerEI9js0vNnrjayo6PIRJaCyESBM8PeNfsG+aqCiMXfcKf00WmIRtOKeAXh8bEA/SHxSoNFN4BsMYdDMYrDP0nOu1ABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7LjBTUyiz03JFyzcL7BytAsJlXEaRf3XmTo+OlPWgs=;
 b=kqtPTPgQXrDbXTgvQqMYEKsgVN7fSxr6u00WnHuomKggcypMsARX91FZrjaf31IXNiMMe5rtElwe5PjaqXsiMLisS97AdkI02ry75w4BBpkLHCGDmfbMBb84W3tETxlKvEHCAc2zTFOvxDCKd1lcN0RRKMJ9JH3ACniY1SuaBTA=
Received: from SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20)
 by MW4PR10MB5811.namprd10.prod.outlook.com (2603:10b6:303:18d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 13:49:55 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a9) by SJ0PR05CA0075.outlook.office365.com
 (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Tue,
 10 Mar 2026 13:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:49:54 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 08:49:53 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 08:49:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 08:49:53 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ADnq3b3166865;
 Tue, 10 Mar 2026 08:49:52 -0500
Message-ID: <a881f055-4fc1-43fe-bc35-7ab1bc47d29b@ti.com>
Date: Tue, 10 Mar 2026 08:49:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|MW4PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdfdb87-fb87-4ada-f755-08de7eabe911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099002; 
X-Microsoft-Antispam-Message-Info: Z+Jw2NJ5TD4p+CMHwV5/0zLKMO5AVMrlQPdMohjh3fVXckCgWW1t/WQYP8/BListtviMnrGAcsiAOyZQCBdtmP1l4V/RT8JZGAOApDJw0r2h0SDTQRucSZ1V7FQEzJNyUQPaPyPrMPHZ4D6d7vyb7rokDB+zEQYCNiOhtIQg65qDj278KocO0gMJfUrg4NVr8G6m8CjkvuFngsxHIrRnLaoL5B7hZtWegLyOg6aCgpWDu15342ZhpQEFgxtHGF+O0mwGFan34Al948HkkRhxSVIvQFCV/Enw4CjE/WgBpyw6PylEfCq/USMqjVvQOLU6C+MgQZ+RGFQ9vJsjNCIcITlt/ZUpAsdNvfSgPPQh4JD6saLqE8ypKxxwZse6vdatdkYLWcKR57Neq2U2NgV2MwCkQMyDjFFFB7P6NZf44NTtQFysp39W8Wr13/2MXdPSRTlhoFcLXPks2ikS4gQORtNxDsPmdtjxWavP+coP9/hy7AA9VDsUyYa28K4K+SuRHyevSZljFPLwYTtAwvucJqcOjoo7+8bFCb72NCvlKv/sdDS4DaUXE2brquUDaYGCVCKKYVk/7k69Qegshz123HTlPdPiwgsQeQozwCf1Sb+qvCMfmlcPtuisD22CR5MiOSfCXtEzMhl3e0rp5gYBnXldbMQ+w6Qkj+OnKnZc2JuNrrFzJM/FqCF/U/TiheT16Hm/3bp4lRsY9VPDGwKzfiuFiUfwYSMDTij1j3rWSJn+vFEkayQ2ANR3khE7L9G8cR8ty5Rnk62okAm0kl2r2g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lE7JJgDcEPqn0kSY13v39Cl8HSjR8ZuBVvA/1S2qpcW0WsoMA5MiPQeIej++Mm3SD0f4GMF9PqVfYALIJYkg2l+N0B15ukBDrLDF5+kGk1M/95hKSixXnP/o4ZDl448W7xgESnQ7eLqn2iNrmwjIWriFhkxjVcnno3b/1puMUiofUGVOsh4T5Y3DVEG4HK3TCIhjBcihAzanMa4+PA2M5iGUBWNd0p1buHXtbIlveORKy9P1hi/x8QCfPaX9dalgyITuUkG8jJVNgXQWuqLIb5odrFNIkarRDc5+efswk8Ks0rHfvg5AsVUa0UjOfBjnatWxKx8vwDXtOpLdQ42Tc7iap1FI30JFXBFbSXo9M57FbclhRXfA64qhys1E/AnPIInI8LoedfHB4A+54va+fBQBP4A3pr23Oyx0JdB64rJhAcjq0S5yT5KeWJ4I9dhj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:49:54.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdfdb87-fb87-4ada-f755-08de7eabe911
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5811
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

On 3/10/26 4:06 AM, Anshul Dalal wrote:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi   |  4 ++--
>   arch/arm/mach-k3/Kconfig      | 15 +++++++++++++++
>   arch/arm/mach-k3/common_fdt.c |  5 +++--
>   3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0fd93f9536a..ad127663d03 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -477,7 +477,7 @@
>   						FWPERM_SECURE_PRIV_RWCD |
>   						FWPERM_SECURE_USER_RWCD)>;
>   		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
> +		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
>   	};
>   	firewall_armv8_optee_fg: template-8 {
>   		control = <(FWCTRL_EN | FWCTRL_LOCK |
> @@ -486,7 +486,7 @@
>   						FWPERM_SECURE_PRIV_RWCD |
>   						FWPERM_SECURE_USER_RWCD)>;
>   		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
> +		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RESERVED_SIZE - 1)>;
>   	};
>   
>   	ti_falcon_template: template-9 {
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb96..ba1130a7996 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
>   	  The load address for the ATF image. This value is used to build the
>   	  FIT image header that places ATF in memory where it will run.
>   
> +config K3_ATF_RESERVED_SIZE
> +	hex "Reserved DDR size for ATF"
> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> +	default 0x20000
> +	help
> +	  The runtime DDR size reserved for ATF. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for ATF.

This does more than just fixing up the DT. It also sets the size of the firewall
in the boot certificate, which is much more important. If this is set smaller
than the real size of ATF then some of it might remain un-firewalled.

Same below for OPTEE. Otherwise, LGTM,

Acked-by: Andrew Davis <afd@ti.com>

> +
>   config K3_OPTEE_LOAD_ADDR
>   	hex "Load address of OPTEE image"
>   	default 0x9e800000
> @@ -137,6 +145,13 @@ config K3_OPTEE_LOAD_ADDR
>   	  The load address for the OPTEE image. This value defaults to 0x9e800000
>   	  if not provided in the board defconfig file.
>   
> +config K3_OPTEE_RESERVED_SIZE
> +	hex "Reserved DDR size for OPTEE"
> +	default 0x1800000
> +	help
> +	  The runtime DDR size reserved for OPTEE. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for OPTEE.
> +
>   config K3_DM_FW
>   	bool "Separate DM firmware image"
>   	depends on CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index cb0fb8274a5..39cb00c3f43 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -173,12 +173,13 @@ int fdt_fixup_reserved(void *blob)
>   	int ret;
>   
>   	ret = fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
> -					0x80000);
> +					CONFIG_K3_ATF_RESERVED_SIZE);
>   	if (ret)
>   		return ret;
>   
>   	return fdt_fixup_reserved_memory(blob, "optee",
> -					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> +					 CONFIG_K3_OPTEE_LOAD_ADDR,
> +					 CONFIG_K3_OPTEE_RESERVED_SIZE);
>   }
>   
>   static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
> 
> ---
> base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
> change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
> 
> Best regards,

