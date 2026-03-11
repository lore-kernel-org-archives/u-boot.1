Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A291125856
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 17:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C6F83FB6;
	Wed, 11 Mar 2026 18:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LRR3POYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF0883FED; Wed, 11 Mar 2026 18:22:26 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B5C83BC8
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 18:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5rRlC/soVBka5toyFglUa2ba4PnarBwhFbGWBdUm2Y8yMKBpv2UOnHfEOcdYqS2nP4fljYQWtuXvCZr5R2FF3JdQjJzI6Cq+Xtxhj0tz0qbQEwt9OkctIbke3B0X2mTEQwMrG5K/8AbhoDeRG4HvmN9SCTcN8x74P5IZ/JxRv560rgneZHt9RfYSehLMfIVt3lxPp3ewPsXtd041CP6HJgYbSBD31tn6sO0gVOMK7Rp8uejUL0U754xLQNcYUaTN5/QPc8thD1ggEZrZCGVyDwnfdDoYim0yCu6cFomI6gc/NDhdlceUiwmsgySmRTiSs8AHM2y1r03/xEnece43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpCqefM25L/Okkp5Ri5EU3uiwGTV3NMG9KMNjmUfij4=;
 b=jguBZiaY5xpiJcssWwPfm3VwbBdgdxO02U85Av9bm0E03ynDSTDTYEAxHORWxpfxXebEi5gfAaUYvkVOX5dPyBzKWTOnqg87tlLLDzFiZLK1Y4D0vAOZtOCkzdds6km5T6sghoInuW4MyO5QW4WpSoK8nT/mbO8DRi8LL4Dfz1+syUdaA+IDat1CR5eeLgY+ySNc7qBwSsjT5+PfcM1CIx8Ky1DcyVp3amC61qJ2Q/WXv5H6GLb42BLQCETp2IhvBAMwssm8PXj2ZlkvHt2X0FV38IGFUOtfruOH43X5mBAuKhK6iEy/oDvzPavWKm0nBotkVjeGUr22Gc1WJtyB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpCqefM25L/Okkp5Ri5EU3uiwGTV3NMG9KMNjmUfij4=;
 b=LRR3POYAxrbm9eSHUN3fhlBVacUxi6BEpG7zs8yOVvt6RI8sXmLnKAKP8iiyiD2lJc9KxwWEC/Ph1/5T1ljHW2g4T06fkVOGAW6qFor4CYOALCiYAEG9VTpFoJGdGnU/kG/ehztWyXILtZ7OeTl2EVqJn5YEp0U9cZJDDVdGyGM=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 17:22:17 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::75) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 17:22:16 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 12:22:15 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 12:22:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 12:22:15 -0500
Received: from [10.249.132.102] ([10.249.132.102])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62BHMCZk750416;
 Wed, 11 Mar 2026 12:22:12 -0500
Message-ID: <186dd71f-e329-40d3-88d2-5a4dc811acb8@ti.com>
Date: Wed, 11 Mar 2026 22:52:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2] arm: mach-k3: use Kconfig options for ATF/OPTEE
 size
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: b515a595-a0ef-4004-ae7d-08de7f92be32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IKMgGGjVTycKwtUuARPFhx8LgXsI3NQEqq2EytBnu2o/9nzM95dWG1Ls2NQX6xY0d+mWUMAaUxnLCXwW9BrLP2TkPc+yoJNCXaviyNCZ369l6CT3ZNqmwwi5sJ/GCqI5zwLltKA543I3KQeij3pjKJgLpmzGqQqpPthDhPXMtF7ZrZsyHncv5n5DwcYQSEvjWoAyPeQItEMsPTrIFyyIbtKW3F5s8oM4kaWIW64InmvOX/7U60Db6iL0bQWkxi8TvKcoCigGeGv3BcHtBhQxuAh+vHr2Ketsrw2ZEx3BzfwaESIau6mmpfZnIh3hkj47w4TItukSCEkTokq78G5/PEQmW4Wv7Qq1HO+wdxZO9VZEsV8pyPS/JKug+fkbhMxJNgYV8Bh5NEOdRPHO2aJeUnb1AcRBrn+qmYpMDX+Fomv1/6N1ChVSt68SfDQv0TMBf9JRtcAulnrX3u7y5C61+shHSbSM8EJ6XeU3frmbr3ISDAot0VcNCpGnMUAGrlW4N4k1yl6LJY8MZjUX3fpt1ORoaR5VyiNc8u5gzpCgrtDbdAzuUp+Sve9m3sjw68jKmCwNacoqhu68wai5vPd/YJpI2l08z04cS6pimIIysUPJmLyu/6BjVMiVZAHMRse6KJwaIQnTWWn+adgvLKp5gsLxgP93ub4aIWgc/gnvzIXOksZjUZ+pNxUUOKFQe2AAaBATAy6+w53ETokNltqcKqpenZyBAjuKwRQzVDWbAGjuni/mJb4iWosClHJE+tPOMTv1g2bs5Ys9U3FewdCGDg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tFCg+txVP5p5P2UXpifT1zDkMebH38Fjuy1Ctp0MqgU0cfBjDwJr9X5GRGe3rvprPnD20Am49qh2eC2oSF9W49pUzUrYNblk67e7xqfARtkHf+Wgz+LSwRvlTSnKf6Yz1zcSRiV7zl7KTDvpoxjWun8qQMNoSyd8U6FkuAsGh9bkSJhmynyt3S6BfZUp176imh87fwDL78YFKxIglfpEWCSjHAUQbRgxrhaaX7HIA4+ZaG9JmIiYDtZpBTwN/Bc3RSYnnJ29j3efgz5oqdgMBt7vuuk7D8egRwcJRMyWyTJiFN71KPE2Yi6uk6PCbalR4UerwjYc56RZ/CqF1+QfY+OfCXaqljK6rXxiOsXAX0vKUlmcoemlM6+diL26kcm5YscMh89XcE6sXVPgOjEMfQ4SxCvW0tgfCisU/z8rTPYB7RHkwK8ESdq1dy4SgDcO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:22:16.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b515a595-a0ef-4004-ae7d-08de7f92be32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
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

Hi Anshul,

On 3/11/2026 5:42 PM, Anshul Dalal wrote:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v2:
> - Update help text to mention firewall configuration
> - Pick R/Ack-by tags
> - Link to v1: https://lore.kernel.org/r/20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com
> ---
>   arch/arm/dts/k3-binman.dtsi   |  4 ++--
>   arch/arm/mach-k3/Kconfig      | 17 +++++++++++++++++
>   arch/arm/mach-k3/common_fdt.c |  5 +++--
>   3 files changed, 22 insertions(+), 4 deletions(-)
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
> index 1b8c0b1eb96..e7ef35ed2cd 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,6 +130,15 @@ config K3_ATF_LOAD_ADDR
>   	  The load address for the ATF image. This value is used to build the
>   	  FIT image header that places ATF in memory where it will run.
>   
> +config K3_ATF_RESERVED_SIZE
> +	hex "Reserved DDR size for ATF"

Not every device has ATF running through DDR, maybe keeping it generic 
might be good like "memory size"

> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> +	default 0x20000
> +	help
> +	  The runtime DDR size reserved for ATF. This value is used to fixup the
Same here
> +	  kernel device-tree's reserved-memory node for ATF and configure the
> +	  firewall.
> +
>   config K3_OPTEE_LOAD_ADDR
>   	hex "Load address of OPTEE image"
>   	default 0x9e800000
> @@ -137,6 +146,14 @@ config K3_OPTEE_LOAD_ADDR
>   	  The load address for the OPTEE image. This value defaults to 0x9e800000
>   	  if not provided in the board defconfig file.
>   
> +config K3_OPTEE_RESERVED_SIZE
> +	hex "Reserved DDR size for OPTEE"
> +	default 0x1800000
> +	help
> +	  The runtime DDR size reserved for OPTEE. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for OPTEE and configure the
> +	  firewall.
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
> base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
> change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
>
> Best regards,

With that addressed,

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

