Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0B4CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 01:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAF384E14;
	Sat,  9 May 2026 03:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HKXfQh2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D2084E16; Sat,  9 May 2026 03:45:30 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F2A84DF6
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 03:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LefveZgtrQQa4fMv1oQpxQsxYdU+zhQ9t6Blmi6YKCAtZXuOQYdXHj2WPF2lGMu4aOEFxHJorwn3HWfwhH+71n5GJLJPmPuOR6WIR03YO80lAHuq6fRR8hjS4qAutO9u5nzWCSRNwkEKeihwXwC38sDIIaWCYqBbneoqh/4ql2OBwUCLAOjbWfPo4WlWDn5zvdDJsx7UtDbp8aftZ6sOWxqBKV70r9+R1Yb0NpaSiRVjfmd7ISn+GBKD5yhOwYC2ttVPBpsKeik7jbCZNzJj11ODC3h3N1b8NjyxduiNzvfNuCZdWrLqKOQG52fzBQTXQVkehsOghEZs7st+j2bQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMOekzOyfsKlRx+HHb0b1gHLkkmiPk9fMZzEiovSeJ4=;
 b=XPrO77hGix9KwGsgwZzN7l7biHiNZ2bPjH1Zvl8fPTXOTkHmP2pYbVtTjeXqtC0jhA0a/Qd/7sbKs5JWAl6YM3AS4yRIjuwZ3zqyOoZuSL2gIl7Cl+JEUXTzOCGEgxsLdcBR7X619F2SHVy4mpTjXp2L5+J/Q3vlccNVpstZooODLuvimnhfZjt7r1/9YtpW78iGqVlD3JUtqWQDe1PIbtCvD8b54TA+xniz2sY/t+MOhbIVt0c6u/z8l4KxflFUdvvnTTWn/ktfIkdqT3VlT9MTkDxqWiWS6eFEYubEO+PKfV4Pbkpu5P1kK54vMw5vAchb3L4X0c85sX6PI+UnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMOekzOyfsKlRx+HHb0b1gHLkkmiPk9fMZzEiovSeJ4=;
 b=HKXfQh2FELfZlm3GNn4Lj1sKRP3ovd21jEmKvlBW8Ky7fHZ06pyJx6B5+vRqXuSzA+llf5lx5o5ljqMJIWTrsPN/9GDUr6e2/yXG37GS29D3Jnbi2uPHA2S5d96G9jETy1BR6uFhAeJniyt083bcvMvW7aZwiifyz0CKRVQeebg=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 01:45:23 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::f4) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.10 via Frontend Transport; Sat, 9
 May 2026 01:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 01:45:22 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 20:45:22 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 20:45:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 20:45:21 -0500
Received: from [10.249.134.231] ([10.249.134.231])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6491jHpj2786072;
 Fri, 8 May 2026 20:45:18 -0500
Message-ID: <b515a248-9a40-466b-a45f-e363465193e1@ti.com>
Date: Sat, 9 May 2026 07:15:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j721s2: j784s4: Add errata i2378 workaround
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>
CC: <b-padhi@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20260508142507.1386946-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260508142507.1386946-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ee7e4f-c2fc-4047-b048-08dead6ca265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OvE3WhTeFMvaslWIZYNqbkd3G4RFYYrZ89kM5ELlmwNvxU1lHIgFEvK04ResEYev3wKW9vNPbLM/VthCLLSBIW7zFWs1AhjGB/tbl5CTyCryV+5GuwVr0+z1EynXhbbV//8WX8n8kDlatQJw5GwPrntuAGSsMrQKV7BC5XRu29fpniStKjKsRI2pgU42Me0uESjfVAlKFUXhxDf69bWrCqF8MjOVLjy6OfwZ0KtJ+w00fLMcCpakWzJIcU8LdETnOLyqnG6+PQslexNvI1H6P21CT9GZN+kD4Ci7+h0FW5EdXH/q62iTUMsJEEnAulFaACVeGitChWlqH2GU5le6MsKErTcOfZgM45Pc3eobEZwV6pymG3jRiMgZdn4qOSv57RFYgWXuFIRGYSS6U8GW473TUqd+2nSP7LLe+7CpBeiMq9RSBYTwcaY/J9fgJkgdXtVDczy9dx6lxQXHUFD6gIbiCpM25m7cr0t44HbmaMslXKqYZV98hDAeXeWWmhrOYCPIPP9ow4/8wbNBP8JHCr8DAHx8/DeXlkuA2yaC2u36Nesxfug3eEIrxWGTk3jVb3jFofHVDmXZI0Q5jO7swLbevsuZ+DjQC2zYALtHsXUhq32AtInHOBREBmYQXmww88rOYOgSsdpYUHXmS+wh+Vaq+TokKQRCjQPlHHu/gHatA4Yxo2dyGOmi46/CqRMK
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RaEPQPiyGJpahyPV+MY9JJrj4jO29T6n0eUgSLmJyTa8LjbCXrHnQbIiLJwsmduvtQfMtRvgsodmapM3iohqcSJ+P/QSYzV3YYR/kz2Oc1DU0UL1BaEC/4f2Ngv0nDoRS40yz17ncrNoZteMI/wj4ZQCtDRsmSAcF6rPtKvYSKh3jOjke1L3aW1BSJx8xPsfvtGL+47uHiwxMIcJqlyCHe7eAWw6TWDYJl0FYv0i5QsQvOVHzOKIW3632i2puU+kygMNoqJOqb6+lq4MYxJY+2czLjOf+DTUEpY9t2Zvbv6fEYnnSOFstK5utBd3Nx2ihQj6EAurjw6rLr2f75IFXajTUvJMqEhZjP0A0Q1fAC1CE/i4VEImPlCXEDIWBD0tCyISrOB1LV4hpJijm1gOagOLxHk08NNWMPQC2xEngfZ+/oIDSuJWNr+c/YhCSOvO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 01:45:22.4588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee7e4f-c2fc-4047-b048-08dead6ca265
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
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



On 5/8/2026 7:55 PM, Neha Malcom Francis wrote:
> The shadow copies of WAY_SELECT MSMC MMRs have incorrect reset values.
> The main copy has the correct reset value but MSMC functionality uses
> the shadow copy values. This incorrect reset value results in
> under-utilization of MSMC L3 data cache and snoop filter for DDR
> accesses.
> 

Thanks Neha for rolling this out. Wondering if L3 set to zero then
will this hardcoded write will impact in some way ?

> The workaround is to write 0x00000303 to both MSMC MMRs after reset.
> This ensures that their shadow copies get the correct post-reset value.
> 
> Link: https://www.ti.com/lit/er/sprz530c/sprz530c.pdf
> Link: https://www.ti.com/lit/er/sprz536b/sprz536b.pdf
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/j721s2_hardware.h |  4 ++++
>  arch/arm/mach-k3/include/mach/j784s4_hardware.h |  4 ++++
>  arch/arm/mach-k3/j721s2/j721s2_init.c           | 11 +++++++++++
>  arch/arm/mach-k3/j784s4/j784s4_init.c           | 11 +++++++++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> index 82f076a45e0..a4d7fe48662 100644
> --- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> @@ -37,6 +37,10 @@
>  /* MCU SCRATCHPAD usage */
>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>  
> +/* MSMC RT_WAY MMR addresses */
> +#define K3_MSMC_RT_WAY_SELECT		0x6E008000
> +#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
> +
>  #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>  
>  #define J721S2_DEV_MCU_RTI0			295
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> index 29a894baed3..bb5c58d00e4 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -37,6 +37,10 @@
>  /* MCU SCRATCHPAD usage */
>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>  
> +/* MSMC RT_WAY MMR addresses */
> +#define K3_MSMC_RT_WAY_SELECT		0x6E008000
> +#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
> +
>  #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>  
>  #define J784S4_DEV_MCU_RTI0			367
> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
> index b5453d8895d..d996dfcc332 100644
> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> @@ -163,6 +163,14 @@ static void store_boot_info_from_rom(void)
>  	       sizeof(struct rom_extended_boot_data));
>  }
>  
> +void apply_msmc_shadow_copy_errata(void)
> +{
> +	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
> +	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
> +	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
> +	debug("%s: Applied errata i2378\n", __func__);
> +}
> +
>  void k3_spl_init(void)
>  {
>  	struct udevice *dev;
> @@ -176,6 +184,9 @@ void k3_spl_init(void)
>  	/* Make all control module registers accessible */
>  	ctrl_mmr_unlock();
>  
> +	/* Apply MSMC shadow copy errata workaround */
> +	apply_msmc_shadow_copy_errata();
> +
>  	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>  		disable_linefill_optimization();
>  		setup_k3_mpu_regions();
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 53f152ccd9c..48b52fcb333 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -180,6 +180,14 @@ static void store_boot_info_from_rom(void)
>  	       sizeof(struct rom_extended_boot_data));
>  }
>  
> +void apply_msmc_shadow_copy_errata(void)
> +{
> +	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
> +	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
> +	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
> +	debug("%s: Applied errata i2378\n", __func__);	
> +}
> +
>  void k3_spl_init(void)
>  {
>  	struct udevice *dev;
> @@ -194,6 +202,9 @@ void k3_spl_init(void)
>  	/* Make all control module registers accessible */
>  	ctrl_mmr_unlock();
>  
> +	/* Apply MSMC shadow copy errata workaround */
> +	apply_msmc_shadow_copy_errata();
> +
>  	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>  		disable_linefill_optimization();
>  		setup_k3_mpu_regions();

