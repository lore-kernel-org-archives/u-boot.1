Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42002FD3758
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DBF83EDF;
	Wed, 25 Feb 2026 14:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VQZ3H91h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9477E8366F; Wed, 25 Feb 2026 10:28:14 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C6882A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7mXl2N5B1rIfMGxaVoYPP+bf5XOTXvsBGT1TLClAajusFma2b99n4k/n26iNFl7WSOQhPalw0sb0THf/9ty/Q+Jj8GxipFjvUN6AWO2D5gvcena1tSkDQitQ2iOj3Don0O4tSWiJqjxSjEcgo6yANASXTQnQ2sA3VVoJBCW/3U/3j7SKVM3eF67z6d4QD/yebtr1CeEVcPBkEYS6I3wvV3Dt+GErJtLg0o5SJg2hF2bi/UKno6AleE86RO4u1WSzDU0sVCGIQZs2BAL4jhzICnviE1qQ2U6uHWGzPTsJINgVq4f2rzJFOXbsd2m0Uk5bdlU4DAJ7XWZWKopQyvUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqexBtAjH5zleAbkKbFEQYeO1uUQ0CI0DSfE8TIEldw=;
 b=CJ9Mjzi5xOy0d3uMHOAVaQm1i827jTylqtFf5wGZAlho4mPDGOwraVwzyXy+nk4gKHsf0NUp4uIKYtYiI2AVk0jCopwMseJk3dWEMfpimxvOEQ3iCYJ8Me2WYhTSiPrEWBZEg4qxx0HjandBdL/pb4+7ZguuUgTSzczH8Oti2Gg0eKEVZnmB3AJRdN66Fkm5EbfK1691uM48cUAuOmJhKOslADAV3+Td9cABNu3qQ/3k1YsydaA36IAFhMITogAvg/CHORJUCDpqEKQHn/bdi5eboNJFzHwhxKo6RM5xM6+QpEEwPXsJuD2vm4DOXcLN6VbbxX3Ze6OmQqtSomCYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqexBtAjH5zleAbkKbFEQYeO1uUQ0CI0DSfE8TIEldw=;
 b=VQZ3H91htk3EIux2lbOT71e6ZoI8nuvVmkEtURaTkc5Cz6S3xfoSac1aYTrgLQquCXSbfeOIATy3AefD5X6TYu47KC+fOZCR0We/mQ3U4GucdoqJ7DkAt4EeO6reR9VylccjIjzMDYwhya5YQuHBJVKrHkY3lAGHlDt4zeXeIyU=
Received: from BN9PR03CA0111.namprd03.prod.outlook.com (2603:10b6:408:fd::26)
 by SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 09:28:08 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::f3) by BN9PR03CA0111.outlook.office365.com
 (2603:10b6:408:fd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 09:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 09:28:06 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:28:00 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:28:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 03:28:00 -0600
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61P9RuJZ203267;
 Wed, 25 Feb 2026 03:27:57 -0600
Message-ID: <ff104b89-f3f3-4960-8ad4-da876f8bebd9@ti.com>
Date: Wed, 25 Feb 2026 14:57:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62*_evm_a53_defconfig: Enable OP-TEE fTPM
 support
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260223091314.586968-1-s-tripathi1@ti.com>
 <7e0440de-1047-4146-a0ad-378503047269@ti.com>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <7e0440de-1047-4146-a0ad-378503047269@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc4e76c-d0f2-46c2-0ebe-08de74502f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34070700014|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: VCSABVFOLFiRgOE+P7liZ6QtrqSz6WD46R/HnqyYW26G17qHd9w3SPAEiQYaqLBbQQUTKpmx5oDAyJLYswVwNsnDszrKb1iLwFUTb0G/UWAxUgVekxAC73JwuwzRmEs2DWrvCJn/N5A1vUe2edF/x4gN73usH196EPsXw59CFZGyynlK3UNCDRaCC77xgNa5VmjfxoOEJQ3QIYSpCxxoSpI5pWD8NG6dnDx2jg02WUBd8/27tQ69Y+xZ8e/usjPnyjgI9dEdUtOuTk+psVLd1Rqz34DDN1bcCvGC65S5CBymBfcNdX0jERkYYaSP+F0YzmDmDXCY4LLqI957wInXE+WTXuI9QBeUeduVcLTyZelT3t0K6iI45QxsmGlK5EK0ZLRVzBzun/xzY6GYpC4Y5i/Qg4SncFJHYd36IjuDmIWyIsHiSRQB0AbcAs3qco7fjKshOafLlYiwjAnMbP//VsAtdwRK3I6a36NT2LEGlAkR0hvshwxEYSr/iJgn6OZ9sTwCNSf5fG7kY+FNobPXowXS393FYZqNlm3h0/bi6v029JXehu2w35N1RU4DyYwzRgevQDwUBq6cSPumG909HzmlvbXSvAEwaMJNE9bysVexG4Z6BW1f061I6KlPyxcbBdrSnL6W9T56lKGk57DLMkdRrZ9cPSoycHocOj9S1kjzhSWqYvXWeRL+f3TaN9GIDRh1+jvRNd9XJG8RM+If9f/XgDfw1Pf7D6qSPedgcTcImj8+y29NBdXtPGNxYKnkyw/X+SqXhda2bdn+DOmAMlb6ar3lVBTJpkBuyRYx1WaFnxpJ7H2W0A5Wr7+JLuCImew8hekv48OKohh0PR9ULw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34070700014)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rnt7gvbnFgJoSt9C8C+G331kfmhsx9qXwFKgezUukzaRtD8e+NYzbDzRcFlFJVIHte6OsElegbsmZ7eHSPdDN811cfvnkOfSrGxbiRZ8/9ARZ5GhJDI5qsNjcbsNgli4IjnD4KKP/QNR+6rTgmhSHIE93gn26EK+LVoiNdZCp36xPNBqk8nsJoawSNJ6SUzi1/Gk8ZUN8HYo+YQeyX1P8X4VAG36Qp+VLYbNA18O9h0Mi7TynEMVwXvkjnn+ZnghVy5ayxXM0uP1Xw69XHVS+BIE0r7mRLOg3F1deD/RIq50e4a+XI9XbDp6vyDbeIqAreiqt9W6QImbctVt3NQs+t9V+udrOF3ZpOfFazpzMEQ0t4qXvHr0dzuFIV9TvqeVy6vCgJrL7lPYzUOPF+nqnuhZz9kj+GOJwWNvPEp+ehB8TE5BsmdtiICKSdZz/vbs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:28:06.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc4e76c-d0f2-46c2-0ebe-08de74502f09
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:20:05 +0100
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



On 2/23/26 21:28, Andrew Davis wrote:
> On 2/23/26 3:13 AM, Shiva Tripathi wrote:
>> Enable firmware TPM (fTPM) support for AM62x, AM62Ax, and AM62Px SoCs
>> by adding OP-TEE and TPM configuration options to the A53 defconfigs.
>>
>> The AM62 family SoCs do not include an integrated hardware TPM. This
> 
> No K3 SoC integrates a full TPM, so why do this only for AM62? And
> why only the TI EVMs? *All* K3 SoCs and *all* boards based on them
> can make use of OP-TEE's fTPM, so why not move this to a common location
> in the Kconfig files. That way you don't need to add all this in every
> single defconfig.
> 
> For instance the CONFIG_CMD_* ones can be added to TI_COMMON_CMD_OPTIONS,
> 
> config TI_COMMON_CMD_OPTIONS
>     imply CMD_MMC_RPMB if SUPPORT_EMMC_RPMB
> etc..
> 
> Andrew

Thanks for the review. Yes fTPM can be enabled for all K3 SoCs.
I will send an updated version of the patch with suggested changes.

Regards,
Shiva

> 
>> patch enables the Microsoft fTPM Trusted Application running in OP-TEE's
>> secure world to provide TPM 2.0 functionality, with persistent storage
>> backed by the eMMC RPMB partition.
>>
>> This enables TPM 2.0 functionality in U-Boot and provides the foundation
>> for measured boot and disk encryption use cases.
>>
>> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>> ---
>>   configs/am62ax_evm_a53_defconfig | 9 +++++++++
>>   configs/am62px_evm_a53_defconfig | 9 +++++++++
>>   configs/am62x_evm_a53_defconfig  | 9 +++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/
>> am62ax_evm_a53_defconfig
>> index 167ba7ff8df..b14f19968a3 100644
>> --- a/configs/am62ax_evm_a53_defconfig
>> +++ b/configs/am62ax_evm_a53_defconfig
>> @@ -99,5 +99,14 @@ CONFIG_SYSRESET=y
>>   CONFIG_SPL_SYSRESET=y
>>   CONFIG_SYSRESET_TI_SCI=y
>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_TPM=y
>> +CONFIG_TPM_V2=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> +CONFIG_CMD_OPTEE_RPMB=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_CMD_MMC_RPMB=y
>>     #include <configs/am62x_a53_usbdfu.config>
>> diff --git a/configs/am62px_evm_a53_defconfig b/configs/
>> am62px_evm_a53_defconfig
>> index aa241a73c3f..2cd572cd5c7 100644
>> --- a/configs/am62px_evm_a53_defconfig
>> +++ b/configs/am62px_evm_a53_defconfig
>> @@ -148,6 +148,15 @@ CONFIG_SPL_USB_HOST=y
>>   CONFIG_SPL_USB_STORAGE=y
>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>   CONFIG_EFI_SET_TIME=y
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_TPM=y
>> +CONFIG_TPM_V2=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> +CONFIG_CMD_OPTEE_RPMB=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_CMD_MMC_RPMB=y
>>     #include <configs/k3_efi_capsule.config>
>>   #include <configs/am62x_a53_usbdfu.config>
>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/
>> am62x_evm_a53_defconfig
>> index 281fa3fea15..3221a9b8f2b 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -138,6 +138,15 @@ CONFIG_SPL_SYSRESET=y
>>   CONFIG_SYSRESET_TI_SCI=y
>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>   CONFIG_EFI_SET_TIME=y
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_TPM=y
>> +CONFIG_TPM_V2=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> +CONFIG_CMD_OPTEE_RPMB=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_CMD_MMC_RPMB=y
>>     #include <configs/k3_efi_capsule.config>
>>   #include <configs/am62x_a53_usbdfu.config>
> 

