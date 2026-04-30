Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B17CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 17:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB9D803C6;
	Thu, 30 Apr 2026 19:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n1zAvxbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5202483A91; Thu, 30 Apr 2026 19:32:53 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABFA80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGGiw4837vGrtWEZAnfkwWejCpz/Tb2cCjmFXsvjWXE8kfERJyNQubGCuA8sfCVgCHjcehpD1Rzs46Td59Ykm1Dyhh6iNsGXUlpwJLS4G93BRWz0igWdet1zoXjb7vLy3uxr7KQO4DRLXx/Uf/hQur+5j6+zBQ91TqAprgdtPQnxo65V6Y/VHWpy1f+I7VpYOaEtmFpYQslQinIEwJLLhcW5O0RXGTvxM4vYAiPv7hHTCZxl2814oZrLWXB6OVouYRRjF71FXIm76KN28S6p2KqtB4KSR3Eo9dFrC8kt3t95qf7iF/AV0VxK8rxmFXoTwBDLQtrmXTmMWR8JSgHQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K75tSwp5BQ2k9q14E33lo5HyqvMSa7ysMuEdKSeG6LU=;
 b=a8ZmZmgU/syhCV7cOWDt8sY3wx1byifilAW3DQhov/FHB9/vHsb9W7WHgpjs4OjWsHsNhWGG9JTYO/AuVnVpYqcbfc4yCPP3IavA11WqqeADe9nvli5aomk0AUmVF7wTvNJQWXO8pU1Joar4OYfsOr0s6ERZLZWZG8gOEUlRuLeWfByM0DVaXzwKVBA4EcowG7mTAEpbV6ImU8LaJj/59dayPro9RUXuHD7su9y2y5Ezqgh+gHOoVQXBGVjBd7zJgv8b94UkYW0fQcZVKkf0MNhFMIbhvOnJfdnLPUbeSl/N9yDUrzZcQxD02U6pNHUsv3MQxPQd5TCyAlQQLi2Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K75tSwp5BQ2k9q14E33lo5HyqvMSa7ysMuEdKSeG6LU=;
 b=n1zAvxbB3be6fcxvfSn1vcAZAHx4/e3AgByJf1m90e0oHc3zJc+teiXtUvWJAjZRDuGsfGzXRZbvhJz/VYKbgkPqYdmT+QjvrSd7dJIrVnQlrGI3ePBaszhRcSz1V5VcPlftrTYM3D+U3M531LkYgHYLf+uek09Z4ILrNFEMjmg=
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 17:32:43 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::d4) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Thu,
 30 Apr 2026 17:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 17:32:42 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:32:41 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:32:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 12:32:33 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UHWWGA1602952;
 Thu, 30 Apr 2026 12:32:32 -0500
Message-ID: <51551426-22af-4b6d-9357-8732cf5470ad@ti.com>
Date: Thu, 30 Apr 2026 12:32:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] board: ti: evm: Store wakeup reason on scratchpad
 memory
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-19-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260430084414.1354490-19-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH7PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: a1509a4f-44be-48f2-6a2b-08dea6de7bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: CKQjuTv+JL25S6akyCpzfA6SXDuvoqxrwIBdxPWDj5zl6z5Ugwz6wZz7xmelom3pZQqOdOjfNYiwTlbyDL2GanlQRiu+TBkYLFhKM9GpzcSFYBUJJ8TbZV9zCHuIA2n6x3JjSerOMcQbRDQRPxvdRRt5pjfQ1Asm9L1J1eo2i2bP1cci93CmnewJkV7PCp/sVMkOZXNg3QByRV8IkALbi1xGOudzx0EnSq1bMOT4ZF37phb6oBjhWvq3HXna/QohwEmAh4R/oQ8HvkdADTG6wkOD1LwDpc4Jk6we8KXz6JHhV0zo4qcQy0K3ClEbLc/rxOvSx7RlnYcadkrx9CasJ53u2M6fsukS4qQDb6OYFuhZv/zxbDfSwQbnVE8EkQfwh7q/sLp7fSVMyXFxRJrIOcyDKkwicj9Gupce/0SeIdhw0kbifprauvOBz4wMg0OwWtwsA2vNALWl0r5EpIRZkRjsmo2cASj4kbTwJyvFZC4vHqaSpEiYTeTps7Ef7aEvivYIbviGnhimAN12EZ01zBoq198BojqW5/mJoDd0ipaqy4sJEQmCk50EA+VJhMc50eB4tsDGUh7SElmbOlzP3gbti6Q4vwC5g82xabIkY0nDGe0fIVP5UKut+5PDfnwMQlqoRfGdfoJZHFonwC79zQmipnXd+uodfWB7yemhzAnOVZHdeaEvFIp7/RrCgwvKFGLij3sIr9d4RPegWBmdqvzXdJASgymXzEm3Mzc7TiRSC9Ppa5KaYnJ4zANCkeoqxOMWSeS2h0Lva2UMPSwmCQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z+IB3pLU2yMF86rAEEBEempUsTtKObvr/3NtkPbzEK2p3jrrkvTPo9sNxHZwscq8stBcHIPuDgrS+iBEoQDHn499zumc1zPAnasQgahINIfF2hI6Nqo9pCNwBdlKN6Jja/O0M0cdly2y9gAw8M1jIwdh8PdUCq2z8tB+w/El928s5Pnni2Ftz9xrS0cg+Is/iwyl/DVpwvvqD352e4UPcza+qQRDHt2LR5ltoVt3/bkNWAWU6zhQKWnkxFM010x6bTJhpGNePwxrXKBCwyEjCUfdHd1nJjgoDlKUmTRfEeYtLEa/jv1Pqa+vQt7kiuZoRKbbEs6HcL2NbFvSpNKgbv9tqt5y8lVc5mpEoZroFJBbWCnSfu3BoKU7cXRlDoKtHTR/LO3/73O8H7AnqtlaunzZnSf75CzAEGurE19WIHSKwOStXgMUVdJMrglHFTXV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 17:32:42.3737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1509a4f-44be-48f2-6a2b-08dea6de7bea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
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

On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
> From: Abhash Kumar Jha <a-kumar2@ti.com>
> 
> While resuming from suspend, the wakeup reason need to be stored
> and this will be used by the Linux kernel once its up.
> 
> Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
> store the wakeup reason.
> 
> Read the value as soon as it starts and store it internally.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/j721e_hardware.h  | 1 +
>   arch/arm/mach-k3/include/mach/j784s4_hardware.h | 1 +
>   board/ti/common/k3-lpm.h                        | 5 +++++
>   board/ti/j721e/evm.c                            | 9 +++++++++
>   board/ti/j784s4/evm.c                           | 9 +++++++++
>   5 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> index 587dd10eb1ea..d58e2b3e1bb2 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> @@ -47,6 +47,7 @@
>   
>   /* MCU SCRATCHPAD usage */
>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
> +#define TI_SRAM_SCRATCH_LPM_START		0x40280000

Should this be a Kconfig option?

Andrew

>   
>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>   
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> index dd51473419dd..2fc81902f879 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -46,6 +46,7 @@
>   
>   /* MCU SCRATCHPAD usage */
>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
> +#define TI_SRAM_SCRATCH_LPM_START		0x40280000
>   
>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>   
> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
> index a2141a0c25a8..dfd8f8486f08 100644
> --- a/board/ti/common/k3-lpm.h
> +++ b/board/ti/common/k3-lpm.h
> @@ -13,5 +13,10 @@
>   /* PMIC register where the magic value resides */
>   #define K3_LPM_SCRATCH_PAD_REG 0xcb
>   
> +struct lpm_scratch_space {
> +	u16 wake_src;
> +	u16 reserved;
> +} __packed;
> +
>   #endif /* __K3_LPM_H */
>   
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 41eea1bdea95..a9f469fea1f7 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -474,6 +474,9 @@ err_free_gpio:
>   
>   #if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
>   
> +#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
> +#define LPM_WAKE_SOURCE_MAIN_IO   0x80
> +
>   static void clear_isolation(void)
>   {
>   	int ret;
> @@ -498,12 +501,15 @@ bool j7xx_board_is_resuming(void)
>   {
>   	struct udevice *pmica;
>   	u32 pmctrl_val = readl(PMCTRL_IO_1);
> +	struct lpm_scratch_space *lpm_scratch;
>   	int ret;
>   
>   	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>   		goto end;
>   
> +	lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_SCRATCH_LPM_START;
>   	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
> +		lpm_scratch->wake_src = LPM_WAKE_SOURCE_MAIN_IO;
>   		clear_isolation();
>   		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>   		debug("Resuming from IO_DDR mode\n");
> @@ -520,6 +526,7 @@ bool j7xx_board_is_resuming(void)
>   
>   	if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
>   		debug("%s: board is resuming\n", __func__);
> +		lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
>   		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>   
>   		/* clean magic suspend */
> @@ -527,6 +534,8 @@ bool j7xx_board_is_resuming(void)
>   			printf("Failed to clean magic value for suspend detection in PMICA\n");
>   	} else {
>   		debug("%s: board is booting (no resume detected)\n", __func__);
> +		lpm_scratch->wake_src = 0;
> +		lpm_scratch->reserved = 0;
>   		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>   	}
>   end:
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index eef56556a33c..b94ec7f3653b 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -68,6 +68,9 @@ int board_late_init(void)
>   #if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
>   				      IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
>   
> +#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
> +#define LPM_WAKE_SOURCE_MCU_IO    0x81
> +
>   static void clear_isolation(void)
>   {
>   	int ret;
> @@ -93,12 +96,15 @@ bool j7xx_board_is_resuming(void)
>   {
>   	struct udevice *pmic;
>   	u32 pmctrl_val = readl(WKUP_CTRL_MMR0_BASE + PMCTRL_IO_0);
> +	struct lpm_scratch_space *lpm_scratch;
>   	int err;
>   
>   	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>   		goto end;
>   
> +	lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_SCRATCH_LPM_START;
>   	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
> +		lpm_scratch->wake_src = LPM_WAKE_SOURCE_MCU_IO;
>   		clear_isolation();
>   		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>   		debug("board is resuming from IO_DDR mode\n");
> @@ -115,6 +121,7 @@ bool j7xx_board_is_resuming(void)
>   
>   	if (pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
>   		debug("%s: board is resuming\n", __func__);
> +		lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
>   		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>   
>   		/* clean magic suspend */
> @@ -122,6 +129,8 @@ bool j7xx_board_is_resuming(void)
>   			printf("Failed to clean magic value for suspend detection in PMIC\n");
>   	} else {
>   		debug("%s: board is booting (no resume detected)\n", __func__);
> +		lpm_scratch->wake_src = 0;
> +		lpm_scratch->reserved = 0;
>   		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>   	}
>   end:

