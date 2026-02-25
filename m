Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B22FD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CCA84011;
	Wed, 25 Feb 2026 16:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FU/+KAnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446DE83FDC; Wed, 25 Feb 2026 16:07:23 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4A584011
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=tempfail smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/uWZBL332AE/nmzs4ReZPfUvA3QvJEUNplHb91pU5s37uOLNde2w9olJxT5Id+E6MOcDrLQrmIIhIPKde8brYUXxQdZ7rIbX+KBfvlXwlRw4h1dYMOtmMzwAiIANUfY2W4VeZCtF6CbczI2L5SrKJxj0Jm30qyPrSpKS7J6ogMdtzqOGlztn1r5gkWZfft9Z9irnhnIRZdroRE6KSQNOGQxLMMWrOREfONsY42tccKwSX6YNZYQwfP3ObwowfzKqFa9Bw+3SU8T0+JPL/wLNGyVzoMtIbDZT1cTQfXOBAPEwqyVpFPW4tswcnuMNYsd7OVTG0Mil/K7ZuKh9xVzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KNGHdRMS0KG1eU9lsxZnBf1LtLAiKCMl1g2Z3S3oBM=;
 b=Igjo8wCJcnvlF4V+gW56s4MdgbWIMzA09yo8aSDQWlqh3lOfhzKy1EkoSuUWEDInD2blnLtF2QvnZ/qledmshj0iqpI5GeYH/T8GPO18iIHTFSlxTiuwHsVad3/+mjyteofndlZfqVH6Y3YeJ+Xt73HuOJ8acX759btVEB2teI+mnAJ3UZv82KZI593A/mealyktr6aZTXXA5+hRq7cDOxFyrWpCHDrUhGboWlG7liKJROjKJ/ECC6h32mweauH2vCtZ7BOAqocsyYZrCSAAF/Q8FEaxmAdvo8rj2Ui7G3iYqFnBTPrnRQdv9x6hiBGl7owQKCwNdGf9YExOm8g1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KNGHdRMS0KG1eU9lsxZnBf1LtLAiKCMl1g2Z3S3oBM=;
 b=FU/+KAnRny7mJHgPwHG2jRVCi8aPBy4Qqw+4cZHVJnlzNualtJokDU1WvOulmSf+XAPqnOMXHEhtcULGm/spOKeshnjnm4MqUkPJbOClAesnQxBFU0XGg3DQ2SLpeMlLd8T4iy5P6X9HBEYHyjAoZttTkoJLWiKgSI4vndXS0Ok=
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 14:48:35 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::d0) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Wed,
 25 Feb 2026 14:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 14:48:34 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 08:48:29 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 08:48:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 08:48:29 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PEmT36623476;
 Wed, 25 Feb 2026 08:48:29 -0600
Message-ID: <5c95ba8c-4c1d-4f2c-a4ab-499f1a099a56@ti.com>
Date: Wed, 25 Feb 2026 08:48:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Shiva Tripathi <s-tripathi1@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260225112438.1035185-1-s-tripathi1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdcbffe-988a-474a-e7af-08de747cf377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34070700014|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: QBaa+Ws4EW/g9euqfYU32nLHrxJX8ego9WHt2mQEp8G9GYq0zCy0MSRuN+Vdk41MbIUD43UiK9a/FqO/KIOKYNt75BRqRCUYsRc3Kr2Is0snZAlDHgNa+F0FbFifTtFvMm8WbwpKoh9kHsXiXG3UPkA6wQnw3aB6h8QNXxXW+xyJR3eZut9d1ZjuToF1e5B8gw4t0zC+bI7yLWhaxb2rpDdYoMCfB8MNkVR3XG7tw07IUQ1VLi2uCA6ubJ1xEtWnDBH3CDf4ci9ULqgsjvxvJFZBeUNM+M5Uavn9Re6O724b80NbUfOsrkwpGXrhL6kkvRpkdaxhmkbKmODMn5MJ/7tGlgNe3iyQQIQLs8nvBNik4grDoDLj/HNimraxQDdfx7ZGZbdhJhh9LGBJC2RYnDaVLnas6FrBqx9oYgsTqOYhvA2HKE76n0nfMrFfORUxOy9Io8uOCNvk/dVLIz/Dd0aV6kIIfu1tMNqioX4+TuFBw6GDdU3JIktNxFSihDfK+slaNJDZcAqM1GaehBFbnZISfTITgCSv/HTg2cePkdN2/FHHZ0dJlhve2cX62gBxBgrBaoCcQ9yv5VyFM5v+yR/m0RlxwEI4Bs3Kt5TQ530dafXDClDgQk+sU2qUIIy45WyGCeqTjn4XvcNDQ63o79W0SvxwY9YM3gb4vhAYf8hfF6e1cWAr4DknvxvCG8AvSd6fR0bNvG8fdQ/y52+QqS/wXsAg6ox2ZFs7OMjbpgPujb18a7rDebzuwQ5Yqe5zeIyoib/0fthNYIQbBdTQR/BN9KeQZir5ruNq5YCeYEGU1KVfjPSzCjXu0Kuem22TrNDteoU/ATnz+fyr5vh10g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34070700014)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +IQpSezxWLD2zxFqrulQ9wya3v4ElNMhR3W7TJ4m55VxXS80lH57G41+2yWB3cU4xuLL3y73WNelIPd1U7eYo9aEg6Z751gzUqTqWf3NJ9n0ICIxNqVzfQVXRqQ1z++DV3CmesE/9vz3ucIGoNBAJ1bsFjXRdC22vstoANW4XfdlKcDvyV7o1s4gvGeuqRMaSY4eYwdDAYaN2130aTYTPqXT7lBceKhn087/Tc3iGWYFBfcnf5xQMQZttmWoB5XQMJSdTTYXh9xAiQvH3/GpIcKO56Av1bHreaLbfSBxuuoqZSuaIDka9McbRleCgEjDvUxs9qTFt3JwDvavYGUB9KgHiN+HPs6IauxIa5jz8O/Ia0uwaIprYX6dXpXSQPMzfHmv9BeX76nwtSSZyEK930CZUjGM2A0kILXlszcFmH5QC3BG0FUWswQE1bn2VdPw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:48:34.1486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdcbffe-988a-474a-e7af-08de747cf377
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
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

On 2/25/26 5:24 AM, Shiva Tripathi wrote:
> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
> MMC hardware. This provides TPM 2.0 functionality through
> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
> using eMMC RPMB as persistent storage.
> 
> fTPM support in U-Boot provides the foundation for measured boot
> and disk encryption use cases.
> 
> The ARM64 condition ensures these apply only to A53/A72 cores and the
> MMC condition ensures fTPM is enabled only on platforms with eMMC
> hardware support.
> 
> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
> ---
> Changes in v2:
> - Moved fTPM enablement from per-board defconfig files to common Kconfig
> - Added configs to ARCH_K3 (arch/arm/Kconfig) to enable for all K3 platforms
> - Added command configs to TI_COMMON_CMD_OPTIONS (board/ti/common/Kconfig)
> - Added MMC dependency to address concern about boards without eMMC hardware
> - Link to v1: https://lore.kernel.org/all/20260223091314.586968-1-s-tripathi1@ti.com/
> 
> ---
>   arch/arm/Kconfig        | 3 +++
>   board/ti/common/Kconfig | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5508fce796a..eb83b5c35f1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -834,6 +834,9 @@ config ARCH_K3
>   	imply DM_RNG if ARM64
>   	imply TEE if ARM64
>   	imply OPTEE if ARM64
> +	imply TPM if ARM64 && MMC
> +	imply TPM2_FTPM_TEE if ARM64 && MMC

Although maybe less-so, the fTPM can still be useful outside
of the secure storage bits that require eMMC/RPMB. Anyway,

Acked-by: Andrew Davis <afd@ti.com>

> +	imply SUPPORT_EMMC_RPMB if ARM64 && MMC
>   
>   config ARCH_OMAP2PLUS
>   	bool "TI OMAP2+"
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index 409454813f3..149909093b3 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -61,4 +61,6 @@ config TI_COMMON_CMD_OPTIONS
>   	imply CMD_SPL
>   	imply CMD_TIME
>   	imply CMD_USB if USB
> +	imply CMD_TPM if TPM
> +	imply CMD_OPTEE_RPMB if OPTEE && SUPPORT_EMMC_RPMB
>   

