Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315BCF3D5E5
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 05:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AC583B8F;
	Sun, 29 Mar 2026 07:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iYbHV2qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514D683C14; Sun, 29 Mar 2026 07:49:17 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105A883B48
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 07:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULQMgO3otOSRc8TD8q6ktrqg242P9PDw1Z+jsW3Uf/WPaouNEnLUXCPH3juGyFrQuMI6TJtJODjTY99SXHl1GMu0chbP8Xk0a7YuYBsk+Sy/6Y387+Ao3/PQ0nRwOTFsY6jCJpQ37p+pMRV+07lr5+BdoCEH23tmAdZKluGOqRH/9AfmsungGvPAU66U7vpOEU0eVFqb4Q/YXNsLGKUvbxiPY5XsWEgfgBsEpxmNMWckYXKlJ8ua63RPNKnu6VMJPwHF40dXq6jStJntQcHvCxSVcOucuWIGMdfxv6VEWWQOtnwwiYmGFkPTxIV+02C8vv4ymvKdCX77BoeYKunqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mZFwLtm/NFeXex3Pkp0KxobjUr/qPI8kOb+gDScLE0=;
 b=edvVaxEMmetqbRL8jiv9cLVGRS+EoIpYYbYVKN3sXRHUydkkZ27wmQuv1mc4sPGxnNgrle8RjznB1mLSIlD4IbrPoQA5wRV86FLc7KqtDATI/6pNk8yA5DdGmnN6icPQhUBcdb/BqSaPvOOd8NG02g4PlTGaA3UZAjCzRCfVVBCoDpJZ+uHEkZWxj8WkPjTIilKncm8RqgUbANj4XQr/iUZY1uvRR5Y8bp6kMSPqnnmF0hmmwF292BFoHlSEFhL8gybu5TLFZtQ+mFAg8z+FOzbEGruJbgxbutJvGL5BtmQxFxHAvq0H+kE0OqDb+gXiXi4YxEkFot/T8udipIsrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mZFwLtm/NFeXex3Pkp0KxobjUr/qPI8kOb+gDScLE0=;
 b=iYbHV2qN6QDl7ss71vB/KjcTVFoA6hAclfGChdRzLhL4RI06eqpjxwvnpB44GJl+ZSAlNAsPHRRjmvBMvEsHxuUgkTQvqaB5Ylg+SudbL6A5jSPQCYUqaLrk4uH4inZMawHA4YwBawD8M2FaogxnJJ1jeSa9ZnDe/+xAf92xo5o=
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by IA3PR10MB8113.namprd10.prod.outlook.com (2603:10b6:208:50a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Sun, 29 Mar
 2026 05:49:11 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::ca) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Sun,
 29 Mar 2026 05:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Sun, 29 Mar 2026 05:49:09 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 00:49:08 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 00:49:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 29 Mar 2026 00:49:08 -0500
Received: from [10.249.134.231] ([10.249.134.231])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62T5n4w62664820;
 Sun, 29 Mar 2026 00:49:05 -0500
Message-ID: <60358e0a-225d-4747-95c8-d060f27eb8b8@ti.com>
Date: Sun, 29 Mar 2026 11:19:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Add ARMv8-M aarch32 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Casey Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 <u-kumar1@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>, "Francis, Neha"
 <n-francis@ti.com>
References: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA3PR10MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 2870213f-626a-47df-f251-08de8d56e625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CJ6kbTycyYQ76oaXrZDfPGXPIbKjMuYvF7LBYIiW1PxGf97kThwAipOYTln6gjlCidtWlvy1Zr48p2UIndQ46AJIuyGsS9fI8lFa9p15/HN3ROb4pT0qdYA1INocgzwoR/RLidok+JCCHXA/Uo9n1JeVxr3CVTlZywuk8RRO0PdyqcLroSvu3+ApKWg5S8pTqLmrEsU+cZs5Cv93UzFOXZRbZavEqIdnqIMu7IMTY/ExhAXJ/oPLZ5A0tCZWvzuyLWz0yFBXVCGmzl6CZCMz/zAgF5+gX1cuK6bE/RRmr7QlFxyaCtRtbVwZtfwou7aHzYZB2KUcHum6q8Ob+1l0/gtRyRBzFMAuNfqw44wqxzoeTYE/OsG6Yei8Zwxy44LqENcUCZQWwo8OV2Ny5AQY0d0hGEzlPK3Ufy7HaFOGNdOL3B/MvlKw5vZzasIVzdHU9bTCE++KGTYD97FY2toJ0VLE9vMXyqPqs3+T42Pnr16fN+TeS4pPFY70jSXNg42c7qlFuuoEFiEfzBB59n59PLA4y99H7rIvau3c+iix0iQ80uFBp4q9GlwnZ5LLq80Lt5+ExKCKKD2K+1AqsKDO5f4tr3TuHAosMkDq50VwOmNuRj1aj5Hvh/BX9zQOAr26esncr5l/3UcBWRO1s1ClNqSWMqsFE84S7hUNgQphREvsKkbQIf/EIBYMfDB2ZpN3pQafOpjYx4QG2uDppM+qA3PzMCvrCGjZdtbJA8YKaPc=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FykNkD5UYb+qaeQH5nGMhloYOWGzCPpY/tqrrN0n03esLNpRUpYmc7htqo9S7aK0M94CW/u2wxxq39mcG4Hm0ThQOrc6iITStjlHG75sjSUX9M2PwLteH+hUB0NHfXdzlnYJ0gugDPjFRJAblwUjCw9x7bYsceE7x+eumZjOWL6qdiTWrcBo7cHqynQ4LF4DHhhxij4uKFPgtZDy4GUezbHHJ6gz6EACv7i6GjRo1xhn1ACEUhsySTRCnj0TnullOZy0zdiTF1xYvD6fdD0c+e4PEisAcTCXvM4tCL5FhfojAVjQupJuKMsoJTT1Cbz0iOB/hSxy/a9j8StA07B7Jz8feljqEVChTAyCMm8vKasgKxj6VeCILOGrTeJ/kvP+78ysD17cxPCKuVujEKSxuJSHt4einNZ4isUTgDhqXUArufPQ0hrR+a+oY+GaSNWV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 05:49:09.9947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2870213f-626a-47df-f251-08de8d56e625
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8113
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

Thanks Marek,

On 3/25/2026 6:43 AM, Marek Vasut wrote:
> Add configuration for ARMv8-M aarch32 core, which are currently
> Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
> cores, except the code has to be compiled with matching compiler
> -march=armv8-m.main flag . These cores have no MMU, they have MPU,
> which is currently not configured.
> 
> Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
> SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
> initialization code is built from from arch/arm/cpu/armv7m and not
> armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
> for devices using these cores do come from arch/arm64/boot/dts .
> 
> To avoid excess duplication in Makefiles, introduce one new Kconfig
> symbol, CPU_V78M. The CPU_V78M cover both ARMv7-M and ARMv8-M cores.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  Makefile                         |  8 ++++++--
>  arch/arm/Kconfig                 | 18 +++++++++++++++---
[..]>
> +config CPU_V8M
> +	bool
> +	select CPU_V78M
> +	select SYS_CACHE_SHIFT_6

referring to M55 TRM [0], (which seems to be next processor in this
family)  page- (68-69) CCSIDR,
LTM cache size is not default to 64.
my suggestion will be to keep cache line same as of V7M, unless you
think otherwise.


> +
>  config SYS_CPU
>  	default "arm720t" if CPU_ARM720T
>  	default "arm920t" if CPU_ARM920T
> @@ -389,6 +399,7 @@ config SYS_CPU
>  	default "armv7" if CPU_V7A
>  	default "armv7" if CPU_V7R
>  	default "armv7m" if CPU_V7M
> +	default "armv7m" if CPU_V8M
>  	default "armv8" if ARM64
>  
>  config SYS_ARM_ARCH
> @@ -402,6 +413,7 @@ config SYS_ARM_ARCH
>  	default 7 if CPU_V7A
>  	default 7 if CPU_V7M
>  	default 7 if CPU_V7R
> +	default 7 if CPU_V8M
>  	default 8 if ARM64
>  
>  choice
> @@ -445,7 +457,7 @@ config ARCH_CPU_INIT
>  
>  config SYS_ARCH_TIMER
>  	bool "ARM Generic Timer support"
> -	depends on CPU_V7A || CPU_V7M || ARM64
> +	depends on CPU_V7A || CPU_V78M || ARM64
>  	default y if ARM64
>  	help
>  	  The ARM Generic Timer (aka arch-timer) provides an architected
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index b36b0742580..de975fc9368 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -16,6 +16,7 @@ arch-$(CONFIG_CPU_V7A)		=$(call cc-option, -march=armv7-a, \
>  				 $(call cc-option, -march=armv7))
>  arch-$(CONFIG_CPU_V7M)		=-march=armv7-m
>  arch-$(CONFIG_CPU_V7R)		=-march=armv7-r
> +arch-$(CONFIG_CPU_V8M)		=-march=armv8-m.main
>  ifeq ($(CONFIG_ARM64_CRC32),y)
>  arch-$(CONFIG_ARM64)		=-march=armv8-a+crc
>  else
> @@ -42,6 +43,7 @@ tune-$(CONFIG_CPU_ARM1136)	=
>  tune-$(CONFIG_CPU_ARM1176)	=
>  tune-$(CONFIG_CPU_V7A)		=-mtune=generic-armv7-a
>  tune-$(CONFIG_CPU_V7R)		=
> +tune-$(CONFIG_CPU_V8M)		=
>  tune-$(CONFIG_ARM64)		=
>  
>  # Evaluate tune cc-option calls now
> diff --git a/arch/arm/cpu/armv7m/Makefile b/arch/arm/cpu/armv7m/Makefile
> index baeac9343d9..33d49dc3d35 100644
> --- a/arch/arm/cpu/armv7m/Makefile
> +++ b/arch/arm/cpu/armv7m/Makefile
> @@ -4,6 +4,7 @@
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>  
>  extra-y := start.o
> -obj-y += cpu.o cache.o
> +obj-y += cache.o
> +obj-$(CONFIG_CPU_V7M) += cpu.o

Why you are dropping cpu.c compilation

>  obj-$(CONFIG_SYS_ARM_MPU) += mpu.o
>  obj-$(CONFIG_SYS_ARCH_TIMER) += systick-timer.o
> diff --git a/arch/arm/include/asm/armv7_mpu.h b/arch/arm/include/asm/armv7_mpu.h
> index 16b9d0d1aeb..b615b1bc9dc 100644
> --- a/arch/arm/include/asm/armv7_mpu.h
> +++ b/arch/arm/include/asm/armv7_mpu.h
> @@ -11,7 +11,7 @@
[..]
[0]
https://documentation-service.arm.com/static/6622c173fabc8c11c7b53a92?token=
