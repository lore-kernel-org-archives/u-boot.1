Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4AACFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 15:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F0C845C5;
	Fri, 28 Nov 2025 16:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HSWejXWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F75F845CC; Fri, 28 Nov 2025 16:28:40 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629B1845C0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjeqzvd7YMWaxDU3CNyA0arbrG7a5N7twB9OOmlEInNjo4Ck39O49Jq8JYbHP1KaKam+g2pRJczb2VtFa5YQgiGmt+HWHxSyN595LAdAhcHAoFon6wh0aHbQ1FeE1GBS4hZKHwmEnHLiw2btjok5Ltxmw8DAsOm5F9v7Zzj1A8gWGYmPx5/4l/SKhVdJ9Uzk/T+NPUvlOxLissjAUu7XYN7FWniz5zeNgAtxVOUMfyt6H6pmcWdN25U9SKnDDVsB1msLzysZoJI045ULA3/bKKpZwmNhOZ5DzsQgNIs7lnhU+h1agu71Q1uPrZm08+EM/Z5sUA/1HEIR1HcsJnMcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gURnd1ufQ2KXuLLLftiz3nEeZCLvd65Sm43VwSK/xco=;
 b=f4+0ABrePt5WXDNkxHSnsaNxzR+q7+KeTwyiH5GCx4TPtAD2cXy1B0VQXSABqU9jCbFXt3CPlT3geqUGKk6uRYZjTadysWjcpUSOv/Qyh7TDtyn+IDCUsc0EhnYtHHVQH+20QrzFEe5rkqqM8N6ICdvul6K3feDaJEKro4OhWevsTIb6wGrSVLgyC7EdOMW9DZ0Zw44Dhmapsa7GZbzJwmT+Ka9f32G2Nu+OxQ45HMvzvyOz++wK7V+vFc8hW7nakcAuigfzto8VOJk2zMXzAffWCyH86yb9t+thE42+imLzpuyWxllkXz9uPgd/udCQ0AIUUB76sZeKCPgHAGtBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gURnd1ufQ2KXuLLLftiz3nEeZCLvd65Sm43VwSK/xco=;
 b=HSWejXWifiiTynkvBfRDm7aKUPwJ6kqGbHykXKaf5u2+JpSWNbKgeJoYnvuIR2Q+2k3wvC0zBS/+NtzceK+oiOzLBfp/tvn1poWE65ETUnSmpqqHL2bG6WwgtLW7F71gC/HBpjrxbpR0gvQfZCS+iVBIclbvWmTu5W9mlCa9VD0=
Received: from BYAPR07CA0041.namprd07.prod.outlook.com (2603:10b6:a03:60::18)
 by SA1PR10MB997559.namprd10.prod.outlook.com (2603:10b6:806:4b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Fri, 28 Nov
 2025 15:28:34 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::10) by BYAPR07CA0041.outlook.office365.com
 (2603:10b6:a03:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Fri,
 28 Nov 2025 15:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 15:28:34 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:28:28 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:28:28 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 09:28:28 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ASFSQ6Z514761;
 Fri, 28 Nov 2025 09:28:26 -0600
Message-ID: <5dd1354b-5985-49d1-ab25-6a3601c76e3f@ti.com>
Date: Fri, 28 Nov 2025 20:58:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20251128150455.3279166-1-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251128150455.3279166-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA1PR10MB997559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c876d85-4a1c-454e-ffa5-08de2e92cb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vy9adEVYT0h0MXovalA1KzdSWUN3a0Y0cE9BQWV1bjgxU1NMeitQWkFFRzI4?=
 =?utf-8?B?K3RXbUYxUFRHZjZKenlaUEYyeVpLd0pPYjBMTjN3NTExTjFYaXJ6ZEV1S29n?=
 =?utf-8?B?b0FjdDZnMEVvbm41U0tubW9rZHBlbkZReFF6bjlXL3h2M3dUb1dzOGVjUHdt?=
 =?utf-8?B?ZWROaklmTVYvT3RFZjU0NzVYbUw0VXlDSnRYRHZXNjFEU25Fa2k5MFZGVjQ1?=
 =?utf-8?B?U2RObkxwdFdKRmRLSVl2TUZHNTFiN0s1SnZYbEJKMlR4ZnZPWUdKa3JBU1NM?=
 =?utf-8?B?WlJzVk9kZFVwWEVZOWxMTUc5bkNoRzM4UmtLVitJMGJhVVYzUjR0dVJzYTZa?=
 =?utf-8?B?TkcweXU4RWlsR0V0UkxCMmpQb2NIMVpnQ0RaaEZHaWthMU9PaEdqaEQvQ3hw?=
 =?utf-8?B?VTVMUHhlQ09GNkZ3OVJHMnp3N2k1Nng0NVpOU1dZNFRGd0tzQmFqalRucFdZ?=
 =?utf-8?B?ZW5yTkJ2WXdRZDl6Z2pnd3JWUVhuQW50eU5iYWV2Nm84OHpPb0RHZ3RqOWxq?=
 =?utf-8?B?ME9GU29nMjVuMGVwNDl3MTlDa3VSNnNseUphWXhPMWVReTRLcmlkNHhvNy9Y?=
 =?utf-8?B?VUxIbDIxUFo1UHlJSzI1S2I0NngreXVBbnFqZVhIcG9KVmNBNTVBbWpHMHQ5?=
 =?utf-8?B?VFlHaUdrdlNWQzJnTk9CbGprZTBJVm00RnArK0x6a0VRZ20xM2hZS1o2ekd0?=
 =?utf-8?B?MkVYOFppdkdaU1FqZjZQRkdHVUtNajRqVi85N3hPbWZUT0pVQlpSMWpJTGEz?=
 =?utf-8?B?aFhCUjFQWUZqVzREdkRRVVFJZEtQWkI2WmhXKzdKQlFrOFhqak96VGxoTXNW?=
 =?utf-8?B?N21aWUNTSXhDNU8vNnBvNUtYREdVdjRQM0Z6TVVtMFhXa0ZnU1pTc0h0M0Z4?=
 =?utf-8?B?UTk1NXh4UmRTdFIxUnF6SVEycEtCSlZ6WmlteFdGTFhkLzU1bE9JNGQ2Y2E3?=
 =?utf-8?B?eTIrRWxNcWlCY2lDYzhpTWNOSS9ONHdNZWJpODZVVGtKTno1cGJRMHdiZFZI?=
 =?utf-8?B?dXJJNGtQWTNkeGtPZnZNVlptWmkrQ0VzVTd0UmxRWEVOUTB4QmowY1RhamZ4?=
 =?utf-8?B?Vkx3QTNTZnJqMEtOek5wT1EzMXQ3TXdVRFJXMldYTUVOU010cFNkejZmT25z?=
 =?utf-8?B?M04vMHlkK2Z4cjZYM2FtVnZJb2VZaUZrVDlRaHE4Q2JzekFrMzM2UlBKUUdj?=
 =?utf-8?B?SEFBeUgzR0dPWW9FRGJQU1NBOGM2aE10aDlTdmFLc1lqVTBIZnhYblBzYmxh?=
 =?utf-8?B?QklSamJYUFpyZnRqYlZUWm1XOWZZQVhhRmpVLzJZQ3lnTU93UnVYbG05dlRq?=
 =?utf-8?B?UzBpUGRveHI2NW9QR3Vqa1psdm16UmF3M2xiUTJMTXZKcFJXR1QvY3VCU1Fa?=
 =?utf-8?B?bE5pT0U5d2UyN0ZVdEIwSzVrMVhXVEZ3ZlpNWmNndGZndkJwdWh1UFhPUkNl?=
 =?utf-8?B?YXZHaDBsYWtOY0ZPYmtzMWdlRW9WOEc3WnJBNHNnYzM5NzlvbGZFSUNRcXdN?=
 =?utf-8?B?MGtrWkVrdXkrdC80bDhDNDN5a2xiYnpQcURzOFQ5dExlRzdoUVBrUWVzaGZU?=
 =?utf-8?B?SzRRM05nbHVNMFRPdTA4c2tTMk5yejk5Mkw0M1A0WHgwYkkxemlQOWkvRGZq?=
 =?utf-8?B?ckhEY3pPbWk1U1UyVW1sRjNMMEVHNGdJcmNRVTVRRFBEMXpzcVUzL1YwUWRX?=
 =?utf-8?B?ZGlVOGszSCtNK1pXVmdmSDMwVUdiQ1JRNnRkTXJ3a01oSjhSZUZMWWIzTW9a?=
 =?utf-8?B?Z2tUbHkzZjVGeWtZQm8yWmlnT2wzdGltMis2dEt4VkRPNVF3Z2JTSnB5SDEv?=
 =?utf-8?B?ZnFNS0ZGQ241MTdoYVNTSEh3QVRRQmtLbVV0T2tZK1R5YitVK21YdXNNTTNQ?=
 =?utf-8?B?NzFYOEhzUGc5RlE0Wm52R3Z5MGFlTjJTV1d1RTFEUWFJblJUZ2x2WHUrT2pI?=
 =?utf-8?B?YzBETjIvY0ZzUXBhaHRCdGM4OFFRZDYvaUFzcEhzc0YzQWs5d2tabUVNS2sy?=
 =?utf-8?B?eUcyUWkvZFpzVkJtbEhGa3JGM1JySnNEelBBYmFpOVhZL2dRMVhtTnF6aGhN?=
 =?utf-8?Q?FZV8XN?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 15:28:34.3895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c876d85-4a1c-454e-ffa5-08de2e92cb53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997559
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


On 11/28/2025 8:34 PM, Beleswar Padhi wrote:
> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 37 MB is used by PPA and is firewalled. This results in an exception
> and the boot fails.
>
> Introduce a new defconfig for AM571x HS platforms and set
> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
> as per page size for ARM32) for the same.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Fix boot for TI AM571x HS EVM board
> v2: Changelog:
> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
> memory node in DT as it is done by U-Boot as part of FDT fixups
> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
> 2. Add entry in MAINTAINERS for new config.
> 3. Update commit message to use memory size in MB than raw hex bytes
>
> Link to v1:
> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>
> Test logs:
> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>
>   MAINTAINERS                     | 1 +
>   configs/am571x_hs_evm_defconfig | 3 +++
>   2 files changed, 4 insertions(+)
>   create mode 100644 configs/am571x_hs_evm_defconfig
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b43dae882b3..e5d564cd760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
>   F:	configs/am335x_hs_evm_uart_defconfig
>   F:	configs/am43xx_hs_evm_defconfig
>   F:	configs/am43xx_hs_evm_qspi_defconfig
> +F:	configs/am571x_hs_evm_defconfig
>   F:	configs/am57xx_hs_evm_defconfig
>   F:	configs/am57xx_hs_evm_usb_defconfig
>   F:	configs/dra7xx_hs_evm_defconfig
> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
> new file mode 100644
> index 00000000000..7e44ee5221a
> --- /dev/null
> +++ b/configs/am571x_hs_evm_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am57xx_hs_evm_defconfig>
> +
> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


