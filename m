Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BAFFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931A0840ED;
	Sat, 25 Apr 2026 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U7LdJe0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54A784154; Sat, 25 Apr 2026 18:47:02 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D7E83FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akENBzdRZyn2GzfjoePqdPg8Jo9Pe2/QI5D0f0HqJ57yElKIo/v2rY17mULH12h/uIx9d+RZYRIG5ZVMLb4wYYa2FmwstVZ7ogOMVhBhQFHt0Oy7fziX4y0Qa/TIKm98/UwCari3BWbqe6CGpTH6TIyiSWCK/FZjqFLv4Mq5cDothjr17CTW2t5/YrOUy/nCeNzQLRXUdgyw3+m9diodLEYh9QuWZoZbDVNoSbhUTU010qBJoWUWzOepRodf5oASKzHeCOB0+xZtgO22hlRD560McnWW9JEbQKiySamZMmDKLG0Q6Qv1hZ1lakXDjINyUxn8mXIxo29LPLwUFDh6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a9JFWn1fIPE79jGMy/0OHAx0C1OZ7pnbx0QCTjsx/M=;
 b=o/1XG2+ae88rkNcBaRPezWmcbfIR8SFKG2YduDY66R0IV9H+vLy+Z0kHkUgzogpeUVXuxoIUV1+80p6p7baJ5/0DRAZ+SdzR93aBINK0vgtvu75ma4h/vIXaW7f51ENC/rDxcn5DOPtf+L7gX9ine7KWEQ/uztX8NeU/zmqIepTSds7FHrwb1d372H47sVlESB8OpR1k9YA42NoSHA8rhpsW2uhgtJIENmLgTajZ88iTmT8nmuSQQsnhYgeotkvIlEKTPJtCfCwH9FLUvygQyrFT0H+FqB5qqvLEAq6BHvLp188nuYbSd+nAtsnctSXEa1ymDG1UAKMZ4DHmZoIyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a9JFWn1fIPE79jGMy/0OHAx0C1OZ7pnbx0QCTjsx/M=;
 b=U7LdJe0DtAwf+J5VUrB3j/gW5jj/hFoa0qm/h8OQaQMH2GGzXAiEt239akiJ+Wz/9KIRi3mOYAlbPmNS+noy21sLndt/w/AZqigDqQn8EXY3idenSMtAcr0gku32idWuOjIWcdKaHBhiA3zmGlzDelGsxQElDeLBXs9GWNX8VvQ=
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 IA0PR10MB7256.namprd10.prod.outlook.com (2603:10b6:208:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 16:46:57 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::4e) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 16:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 16:46:55 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 11:46:54 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 11:46:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 11:46:54 -0500
Received: from [10.249.134.231] ([10.249.134.231])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63PGkmek4069160;
 Sat, 25 Apr 2026 11:46:49 -0500
Message-ID: <c7c0936d-adb0-4b6d-b726-0d3ee6f4775d@ti.com>
Date: Sat, 25 Apr 2026 22:16:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: renesas: Add Cortex-M33 build option to R-Car
 Gen5
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube
 <mr.bossman075@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "Paul
 Barker" <paul.barker.ct@bp.renesas.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tien Fong Chee <tien.fong.chee@altera.com>, "Tom
 Rini" <trini@konsulko.com>, <u-kumar1@ti.com>
References: <20260422224957.142539-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260422224957.142539-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f68ef0f-9ed3-487b-bbea-08dea2ea4272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W5P9IQIlAdIa+iSCRpIM3bUKuQ9O4nVlcsYxZo9vuEKRzXkBlgC2RxzbGaHQl/cBc+FNkoGCkWduRa521FH6l9WEFNoAfzid7Ehx8amRE0J2/vvlFDpPNjp0kWsE1GcePjefczL6Q573wjTI4rtXR71QYH3t4jt/7aggZJCIIPLRVashyvfl57nm7/IAEw6x5WGHmFvC629XoR41FNEKXdn1AflvW4VcbWfiedgU5xRdJU5spnKgTx3h/ubaY12gLpYUydojIlGtrV8oury3jjPEnS2PHESThn4M6GNO0INI/h6oPFeM4sGa1gGaX/TIecFBz/1nq4qU8EmLGiH067rU//cOkINpYta/bT4ZOqFBKv6en+6t2oOEfAvx1ufgqJwJNASKGUhJtJQQeakuLrogBm8AEtlv3+lcSIGvzvBdaZgoY+AjnlQylqoZclI9ykfNQJNtNCRWR0uYpoWFgDKMKh/I/UqIVH8Aw6NHiLN4m9wHoMfgW0l+UfhOkKFb6Uyksy8eCJ8/YP0taflrsdtirdhQ69RCNXzFgWG/aLtLLuSIM1ypdrQf4sZCvh8SFEg2oN4P5WHLM4Uo1SCZRAfMAzEPiwWP+XbEW/7Bko+1NREXAA9SibVrmz2vz9jn/9lQTMm6s8/5XY4IW0Rzw3JbY34fuStVKRHu5taecUGWjWUUCNrLwIw29A4IdF4vC9rovpVNDM2da5lRv1PvQ39nZ6S4G8cp/WNqeXzLCSWWbF0XfuTYKem1PXGFx9oSm16BEh16varMZ6o+qc/sng==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +lBKXnyrM/cKSyWWxyC9gRMlXR71t63wuvxLlDTH5PttJao+lIeEZxsNlW1VTRuIwg9rNwOC7el+qYlEQF8lPmXOkbV/2PxmrcnUVOXg6HdUSFVq/+6VtwSTiW5wIK4/ozhbADBQf25dGL1j9nxTo5Jq85qSruEWXF0VWRFz3wHuahrtmOl37llIY0RBnUJ5zqE+ZWj5MZKQ0VI3fZN0CprHetGckJ1ZjJVwoxcpAhr8+ihX7scUgzyiKeTBmArE/1ptC3gcmn/d6WqUBTNV5l5BAAOseDY1HEFmS2V0FUfFqy0HVOrNDc1ecAFQT6CtdReqwslhYsGVbxo7jdgWvGlSvqS1jATMeFRjXiiGor5qKC/vE932ENnLk2WUeXs36xhpAiJZ8WtaedH2sSv2Rtd85ZycuYmUp0J+zxd50TwCpiISRVxKfwjcERYAge5B
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 16:46:55.3186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f68ef0f-9ed3-487b-bbea-08dea2ea4272
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7256
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



On 4/23/2026 4:19 AM, Marek Vasut wrote:
> The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
> cores. Add U-Boot build options for the Cortex-M33 core.
> 
> Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
> RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
> used instead of the ARMv8 timer. Adjust TMU timer base address to match
> the address map of the Cortex-M33 core. 

is there any reason, you can not use core's timer ?

Disable unused OF_BOARD_SETUP
> as well as unavailable POSITION_INDEPENDENT configuration options.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Move Kconfig defaults from common to Kconfig.rcar5
>     - Rename RCAR_64_CM to RCAR_64_RSIP
>     - Select TMU_TIMER in RCAR_64_RSIP
>     - Add R-Car Gen5 into RCAR_64 code comment
> ---
>  arch/arm/mach-renesas/Kconfig                       | 13 +++++++++----
>  arch/arm/mach-renesas/Kconfig.rcar5                 | 11 +++++++++++
>  arch/arm/mach-renesas/include/mach/rcar-gen5-base.h |  6 ++++++
>  include/configs/rcar-gen5-common.h                  |  6 ++++++
>  4 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index fa4e312a4dd..c2640a58c03 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -1,15 +1,20 @@
>  if ARCH_RENESAS
>  
> -# Renesas ARM SoCs R-Car Gen3/Gen4 (64bit)
> +config TMU_TIMER
> +	bool
> +
> +# Renesas ARM SoCs R-Car Gen3/Gen4/Gen5 (64bit)
>  config RCAR_64
>  	bool
> -	select ARM64
> +	select CPU_V8M if RCAR_64_RSIP
> +	select ARM64 if !RCAR_64_RSIP
> +	select TMU_TIMER if RCAR_64_RSIP

You can selecting TMU_TIMER, if this is M core, and later TMU_BASE is
defined for A core, as well or I am missing something.


>  	select CMD_CACHE
> -	select OF_BOARD_SETUP
> +	select OF_BOARD_SETUP if !RCAR_64_RSIP
>  	select PHY
>  	select PINCONF
>  	select PINCTRL
> -	select POSITION_INDEPENDENT
> +	select POSITION_INDEPENDENT if !RCAR_64_RSIP
>  	imply CMD_FS_UUID
>  	imply CMD_GPT
>  	imply CMD_MMC_SWRITE if MMC
> diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
> index 528fc5aecc9..0e0e43c08e4 100644
> --- a/arch/arm/mach-renesas/Kconfig.rcar5
> +++ b/arch/arm/mach-renesas/Kconfig.rcar5
> @@ -1,5 +1,13 @@
>  if RCAR_GEN5
>  
> +config RCAR_64_RSIP
> +	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33 RSIP)"

Sorry but what is RSIP means here

> +	select SKIP_RELOCATE_CODE
> +	select TMU_TIMER

TMU_TIMER is selected here, then you can consider to drop
select TMU_TIMER if RCAR_64_RSIP, in little above of this patch

> +	help
> +	  Build U-Boot for the Cortex-M33 RSIP core present on selected SoC.
> +	  The default is n, meaning U-Boot is built for the Cortex-A core.
> +
>  menu "Select Target SoC"
>  
>  config R8A78000
> @@ -23,4 +31,7 @@ endchoice
>  
>  source "board/renesas/ironhide/Kconfig"
>  
> +config SKIP_RELOCATE_CODE_DATA_OFFSET
> +	default 0xa0000000 if RCAR_64_RSIP
> +
>  endif
> diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> index f9af3ef885a..35b0d00e45c 100644
> --- a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> +++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> @@ -9,7 +9,13 @@
>  /*
>   * R-Car (R8A78000) I/O Addresses
>   */
> +#if defined(CONFIG_RCAR_64_RSIP)
> +/* Cortex-M33 address */
> +#define TMU_BASE		0xC0680000
> +#else
> +/* Cortex-A720AE address */
>  #define TMU_BASE		0x1C030000
> +#endif
>  
>  /* Arm Generic Timer */
>  #define CNTCR_BASE		0x1C000FFF /* Region 0 */
> diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
> index dc28d07c7f9..81b5e2aa5bb 100644
> --- a/include/configs/rcar-gen5-common.h
> +++ b/include/configs/rcar-gen5-common.h
> @@ -17,6 +17,12 @@
>  #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
>  #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
>  
> +/* Timer */
> +#if defined(CONFIG_RCAR_64_RSIP)
> +#define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
> +#define CFG_SYS_TIMER_RATE		(133333333 / 4)

Please check for alignment

> +#endif
> +
>  /* Environment setting */
>  #define CFG_EXTRA_ENV_SETTINGS		\
>  	"bootm_size=0x10000000\0"

