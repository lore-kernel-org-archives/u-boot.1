Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EBCEFCD9F
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 09:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4C883F6D;
	Tue, 10 Mar 2026 10:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kUjiDnTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2FC83FA6; Tue, 10 Mar 2026 10:57:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3382E83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJAAwweLHm6P/dD3l0rJJi3Eirikuh8/6byBPT/dFzzNwIpAWDqkcVZBp2cLk4GJ7AB+2wS5jEOerIrIrz90M73EXgiorVsREMQ+22TmXtr0qNldORV7A/ya5y2g9r35xf6HqFi0KUHiM0RC5odCAenMcOkRq1BYtNjkAtCAHSfjPPccXTzZeIbSdz/VehgS4G6Z32xzkT8zcRVlBBls30p5nsmt0hJkkmivZyB3AIn2PKxox/gjjs4WcPQU78OL6V5ituAjosjUO1+N3T80fTD/HvPROiyrmHPHzwF7+0lGW1fUyN7SF/w7OkdTEgkl0RXHErSmceMHVJqX9z9lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qjV+TxtiyMh/bgyM/kN7MKMXXvy05tKt2tFNuUwmzg=;
 b=EcPITVC4HZyQ/4ywgW7uvHwFRM6i/2LBSYCSpmEzLW4trFlHUIfH8TVvP/bq8EIzF95QpFapy7wPYjgkfNb+WcfvWcR3mWxpBrQYvQGN2EOvyAH6FCsIjm/CF9OSzudSGzC6RCJjfFvZIwzNuS5LZ5waN6GpAwMzs83SG5Ocrb4gV6NKBugc6R/fXEty+d3oj9x0P00qOWyD6biin1udh5zs9zCtgBp0u8PGX2D+G/wtuQZuDcEKQjfBXb1xkSImnLlA09f00xvS5SupI8VaAF8MxRZhJASNcUmTdATHDCvylTVmKywK+AFwdHkccvPepgo6cRtrxirKHYYxTkaOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qjV+TxtiyMh/bgyM/kN7MKMXXvy05tKt2tFNuUwmzg=;
 b=kUjiDnTS99u4lsZbopGoiroyH3Bb01psESkqOe4AtYBXSjjOZireeAquYkhY+iCVJI6TB+yCsWuesjrQKMRa96b9TCaVx7RkaS88InI3HsCkDiXwJZotDJCRSzDshssy2feRCWYjGoJmuVQJD0mSbNftLX1JGqvzQWJ3EG+DK9k=
Received: from DM6PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:100::47)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:57:52 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::fe) by DM6PR03CA0070.outlook.office365.com
 (2603:10b6:5:100::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Tue, 10 Mar 2026 09:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 09:57:51 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:51 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 04:57:50 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62A9vncg2339857;
 Tue, 10 Mar 2026 04:57:50 -0500
Date: Tue, 10 Mar 2026 15:27:49 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Suhaas Joshi
 <s-joshi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
Message-ID: <20260310095749.dpsm3hzfal3yhala@lcpd911>
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 86aec820-ea7f-4006-243b-08de7e8b7e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: Ivy08Z8cb3HJ3hfHQkC35F/F+YGQh/hjoWsM6RzCyuGWoDO7Gv4UN/cnsUKPPGQ3kVcZmQ2EZ28uCuJSx+CI/DWWccGl/HAP89pmoJkz+yRgpFgSzwB3ho/hUlZrL11NFyzA5BNzyyc4zZ5IJUUIsA2M5fKK6lO35X6tEPmlaff0pe92S8h1pJI847XMTEJ47qn6mCV3qN5XdoLtrx+lhxSPDO2142/qehrhFt4BIqeeA00YnlXiDHt0uj8ZCFJoTR547f8vl6WGEig4XP1cpQAnTjI/UUd/Bk5gi2R2PuN5tCxP4rhmWyWqJvk6nTBgY8OsP6OMZyZBFVEOQ1oPpImzIjlASkQKcDUjtK1u7+CSZM8JGLDfRqswbEGGbVp0BPojkDG6wKeBf+5KCqvFFHqSYJkibIH8OsXrCj3iYcrB91f55cUvYhnMFwcjlwtE6ipnVM/PHMiRXI6Du2NxREsoDCA/VZPowzelNfvA+wTDK1XHZzhWjsn/IvwVrQ4pEAbMqPAlUpsTAmkPR/ms4vAd0TXYmCkQw0mNh2ei0jaVy8vAeyR0ADBZe/CBsiXm6vgEiRVC6TAIh/5ayne0Wzkf9/gZ+svWkUYsDPDi2lHEZGIgMLISh14f+QH/xmLkibHqNJzYXXmI2Cy4+iRFvRy5hKYvbG+ZuPdmLrwIC/GLFEBn4mmS9OoWQLQ1s9ub1i5XOZ2WAAwA/1QvQNM8UCiTBvkYo6nmoJyckUugJwkIzebZpEgzrVgngWCMG2O1pjukoMj9qSIhs94fD+OLmA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Bucy2d06Q/+5/4whW1qIoTWBL3bUysbDYqnFTgazt7lU/lkpo3ju64iY3elzGxhTp6w5hco2xIfDkmCGGIjwMv7q7AzZrR5F8clHixjhUj6XWaey7YTh+sDe8gDK+lTOyCGrpaqX/gO6Qt6l9qT7bkpD8D1qPzSWZKuJy78jVVjGOCvCXDSENUeQO2oq/uYW+1JYzUmcXrozpkWqf6lePi1AvfkjVb4fa63kuhJ8rxHVtSwXDLnq4u1+OziX1gx+74sCamhRVtrfKBFIUSmchCrqRBtXuhBuSgyGX3So55wgzHWVFAQL8YVMbh6Nf38xshE7aq5lL95N/tTJyzm/4oLUAr2646L35CUEN3RMb4+wFxGo28nGYjJOQYwVsDSD8mIhLNAPulJCWW7lzB1NWV0Nfo3Qm+PnpYeC/RPuSez8aWrxQWb/QpTS9NueW87
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:57:51.7179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aec820-ea7f-4006-243b-08de7e8b7e53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
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

On Mar 10, 2026 at 14:36:27 +0530, Anshul Dalal wrote:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Looks good to me in general,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  arch/arm/dts/k3-binman.dtsi   |  4 ++--
>  arch/arm/mach-k3/Kconfig      | 15 +++++++++++++++
>  arch/arm/mach-k3/common_fdt.c |  5 +++--
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0fd93f9536a..ad127663d03 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -477,7 +477,7 @@
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
>  		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
> +		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
>  	};
>  	firewall_armv8_optee_fg: template-8 {
>  		control = <(FWCTRL_EN | FWCTRL_LOCK |
> @@ -486,7 +486,7 @@
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
>  		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
> +		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RESERVED_SIZE - 1)>;
>  	};
>  
>  	ti_falcon_template: template-9 {
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb96..ba1130a7996 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
>  	  The load address for the ATF image. This value is used to build the
>  	  FIT image header that places ATF in memory where it will run.
>  
> +config K3_ATF_RESERVED_SIZE
> +	hex "Reserved DDR size for ATF"
> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> +	default 0x20000
> +	help
> +	  The runtime DDR size reserved for ATF. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for ATF.
> +
>  config K3_OPTEE_LOAD_ADDR
>  	hex "Load address of OPTEE image"
>  	default 0x9e800000
> @@ -137,6 +145,13 @@ config K3_OPTEE_LOAD_ADDR
>  	  The load address for the OPTEE image. This value defaults to 0x9e800000
>  	  if not provided in the board defconfig file.
>  
> +config K3_OPTEE_RESERVED_SIZE
> +	hex "Reserved DDR size for OPTEE"
> +	default 0x1800000
> +	help
> +	  The runtime DDR size reserved for OPTEE. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for OPTEE.
> +
>  config K3_DM_FW
>  	bool "Separate DM firmware image"
>  	depends on CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index cb0fb8274a5..39cb00c3f43 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -173,12 +173,13 @@ int fdt_fixup_reserved(void *blob)
>  	int ret;
>  
>  	ret = fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
> -					0x80000);
> +					CONFIG_K3_ATF_RESERVED_SIZE);
>  	if (ret)
>  		return ret;
>  
>  	return fdt_fixup_reserved_memory(blob, "optee",
> -					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> +					 CONFIG_K3_OPTEE_LOAD_ADDR,
> +					 CONFIG_K3_OPTEE_RESERVED_SIZE);
>  }
>  
>  static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
> 
> ---
> base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
> change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
> 
> Best regards,
> -- 
> Anshul Dalal <anshuld@ti.com>
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
