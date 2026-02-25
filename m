Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B1EFD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B1983F37;
	Wed, 25 Feb 2026 14:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v4A/VGNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4061083AA9; Wed, 25 Feb 2026 12:38:26 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E8E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLeM0iL/0uSn371OUm1nUO8vRmXbWU2ho3imu2LLRoCdodxRNBxF9V8hpeqfcB+C+Dk/3S6ZvCRSy3+feH9ICPMA/S2U6lv6imUKAUOjLKL9ptg0ChET3loqVKWX/Oc2Qn5J4sC8oDogcWE5GfW5Vp76WsHkJOQD2sjDqe83gqGvzBT6GUoMOEXW7tPzQiuWK/85CThPAy484kY5aPJoCSCUqXSfxglGNhyQXT5yyOKHYjZt7moscqjCxae5t7W5FTrnUPqwEyGTqgnem0iI6PrEXRHV5a/UdH1nPWUeVxh2xJ0joRkfnrIvcts8KDFYoCHZfl1tD87fTQUSbCaJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ1wuUVj7sxk4bl5H3LpjsfrjaBAfl4dtHfd7TYBze8=;
 b=UGnsDEc/jKJwFL8HJ4Hth7KvV9FvDCf5k60N7gJgqHq/7yABWU6ZOHHP6X9J9ulpPrtds7IQAbZpNun9cDFjHJOM2SyyHbpP7QdQkVnk5NeYDstrQaLAC0xi0udmqQFhXj48Gzu73uYCtX6P9FcVeBZDAf5Ragv7sbgZ3DKA7tnUqHLseIi0DpSlR+HHpbaMeTOIWXo2EVxRTBW3TYR+rsCsxYwuDEuC2rxkLCQgkdOuNkgBdQxK0mr/WWuQswjYdME0MDMnPe1Dfi+uAbcXsGEoIdW6teADCLEhsOhI5y8NE9T+LyxZe4IlZ6cUEsH9XtIVoGqnaNsdlE42ot9byQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ1wuUVj7sxk4bl5H3LpjsfrjaBAfl4dtHfd7TYBze8=;
 b=v4A/VGNH0ASTWPtI8IJgK+UVLf7/5AmB+9Ie/LC/ZVcHtP0YPS3igjOXuNubgLY0v4MveBxb5y4KvaLpZ9QaiTOvcpt/ItVygMg8U39cDHgyqKPZLHJZzQ9x7pUS7mV+8xz5hkiF7GZSJd8nzl1Rajo6JMMGxREeAZPNjV8wi+w=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by BN0PR10MB4984.namprd10.prod.outlook.com (2603:10b6:408:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:38:22 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::99) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 11:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 25 Feb 2026 11:38:20 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:38:19 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:38:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 05:38:19 -0600
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PBcGX8375942;
 Wed, 25 Feb 2026 05:38:16 -0600
Message-ID: <7520c409-f26d-46a7-b45d-a514e62247d5@ti.com>
Date: Wed, 25 Feb 2026 17:08:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62*_evm_a53_defconfig: Enable OP-TEE fTPM
 support
To: "Kumar, Udit" <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260223091314.586968-1-s-tripathi1@ti.com>
 <7e0440de-1047-4146-a0ad-378503047269@ti.com>
 <ff104b89-f3f3-4960-8ad4-da876f8bebd9@ti.com>
 <a21ad9ea-56d6-41bf-a5d8-270d5508a695@ti.com>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <a21ad9ea-56d6-41bf-a5d8-270d5508a695@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BN0PR10MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: f005a372-b28a-4ea4-4359-08de74626047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|34070700014; 
X-Microsoft-Antispam-Message-Info: LPYfl9kD5RAnghSacNOmjYffuq5KQiKo20wTdrG839m4XEaDLGoUJiGXDDWPV90Ib4bM9wnpQmMbUId2vkErhmg5IGKcBuYMsA5c+jBmZ1akbe2VJ8hD15FFckjn9xWlJmyBFqUCSDfnweo9l0D9mnzv8x7+cLuDhplY3HLjpSx3rBA6RcRrRcHB4EEkI1n+0arrDNKFQbNxItaSrTuRRo+MXDkJu2paDGkcmABSp5wfxZWvuC7n2gpbQ9apZ6d+QA+s5v3HzqZUQbcUL1nRw5+MjI07xyeo0bqXxb1k7yXrM0rC3OVMs6CyimhOP19HAtj0DrTfvY5fvN2sUoQt2XdW8VOhr+Kp5n/aLgua4LHtyC1xzuBEeVG7eTbYyNNHiEWB/9MLdA5LkeCO1xD4/NYn1yMZ11QyH7zp4jL11m8SaJLcix7hV8Oa1BAZ35ii5IkkcpM/X1ucnfA9nvzcKfywFA0eq8hhcdgx3xZlMKP+HfWo7DD2HdL5ktX8U7GF51uhDcjCtlCwRYfKdPJUI1/MoG/26W3KgIdRXipNZBUjxQ9C0DWwZuDhcu/y0lnPsnPYu26Gm+ud96CojbUUh4/x71UeUduXkanfe75Qw6eNDRXcopL0RyAHB+cFklIMmj8wN8bBs+K+cWYe+bkbR5iZdVkS504zIESVWu7tKQlSp/k5UhwfVYXYp25LPY3ZvFB+dXRMRL8qcbVGS/7SeDipagrXokuuSTa4UnrCYQLBnjVB2DNQRIC9G6zP6slhTMXA0Paf1hVMsNqqU6h0gGY+QWvdkI1x5A3N5V+JPSEBLbB6uh3CYmzap9p+kpD8naNcnrZNpC2i8+3BMOSZyw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(34070700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W9Iu8EEHWKwd9KcPEANYK8cpv6GaK0ObCVn979AgfNcIOpc3qthCFP7dx286shMLJbMedDEiW5vGdVGPmteex534jWJt6r+ax84gNsHY4Db16Q/ZVM6LHNKRo7Cyaa2x4tKmxNUsrwwRsBSgTbVQDsdIxp8q8twtsM3ufS7iBMIvewFsFRR9AsIu8fVPpcVQFPZHaeG9Vu/axaBmrME8yjIUYQFK0DbRbpwKMDHBrkLHw9++ch95pd08nX8PwSdb+yUqVBrr5mEMyUaQOabOLnzCIBwqqHx1rCbXTXFKqnG9YvsSS7TZ5hBagpMOm5TtmfVf5jQ4lGXcskB9s3YkHDGpNjobQjs5WvvSKaXyR032kBz0jEbLG4yktWR1wL0y9pSSBbNBOJpYXT3r3eTBu+1PpFcKK3L9EHr8mBlm7JjnnyaeJpq3E33S8rdI92Ld
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:38:20.2887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f005a372-b28a-4ea4-4359-08de74626047
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4984
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



On 2/25/26 15:13, Kumar, Udit wrote:
> 
> 
> On 2/25/2026 2:57 PM, Shiva Tripathi wrote:
>>
>>
>> On 2/23/26 21:28, Andrew Davis wrote:
>>> On 2/23/26 3:13 AM, Shiva Tripathi wrote:
>>>> Enable firmware TPM (fTPM) support for AM62x, AM62Ax, and AM62Px SoCs
>>>> by adding OP-TEE and TPM configuration options to the A53 defconfigs.
>>>>
>>>> The AM62 family SoCs do not include an integrated hardware TPM. This
>>>
>>> No K3 SoC integrates a full TPM, so why do this only for AM62? And
>>> why only the TI EVMs? *All* K3 SoCs and *all* boards based on them
>>> can make use of OP-TEE's fTPM, so why not move this to a common location
>>> in the Kconfig files. That way you don't need to add all this in every
>>> single defconfig.
>>>
>>> For instance the CONFIG_CMD_* ones can be added to TI_COMMON_CMD_OPTIONS,
>>>
>>> config TI_COMMON_CMD_OPTIONS
>>>     imply CMD_MMC_RPMB if SUPPORT_EMMC_RPMB
>>> etc..
>>>
>>> Andrew
>>
>> Thanks for the review. Yes fTPM can be enabled for all K3 SoCs.
>> I will send an updated version of the patch with suggested changes.
> 
> 
> AFAIK , for fTPM you need eMMC.
> Please don't enable for board not having eMMC eg AM68. 
> 

I have sent the V2 patch with a conditional check on MMC. Please review.

>  
>> Regards,
>> Shiva
>>
>>>
>>>> patch enables the Microsoft fTPM Trusted Application running in OP-TEE's
>>>> secure world to provide TPM 2.0 functionality, with persistent storage
>>>> backed by the eMMC RPMB partition.
>>>>
>>>> This enables TPM 2.0 functionality in U-Boot and provides the foundation
>>>> for measured boot and disk encryption use cases.
>>>>
>>>> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>>>> ---
>>>>   configs/am62ax_evm_a53_defconfig | 9 +++++++++
>>>>   configs/am62px_evm_a53_defconfig | 9 +++++++++
>>>>   configs/am62x_evm_a53_defconfig  | 9 +++++++++
>>>>   3 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/
>>>> am62ax_evm_a53_defconfig
>>>> index 167ba7ff8df..b14f19968a3 100644
>>>> --- a/configs/am62ax_evm_a53_defconfig
>>>> +++ b/configs/am62ax_evm_a53_defconfig
>>>> @@ -99,5 +99,14 @@ CONFIG_SYSRESET=y
>>>>   CONFIG_SPL_SYSRESET=y
>>>>   CONFIG_SYSRESET_TI_SCI=y
>>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>>> +CONFIG_TEE=y
>>>> +CONFIG_OPTEE=y
>>>> +CONFIG_TPM=y
>>>> +CONFIG_TPM_V2=y
>>>> +CONFIG_CMD_TPM=y
>>>> +CONFIG_TPM2_FTPM_TEE=y
>>>> +CONFIG_CMD_OPTEE_RPMB=y
>>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>>> +CONFIG_CMD_MMC_RPMB=y
>>>>     #include <configs/am62x_a53_usbdfu.config>
>>>> diff --git a/configs/am62px_evm_a53_defconfig b/configs/
>>>> am62px_evm_a53_defconfig
>>>> index aa241a73c3f..2cd572cd5c7 100644
>>>> --- a/configs/am62px_evm_a53_defconfig
>>>> +++ b/configs/am62px_evm_a53_defconfig
>>>> @@ -148,6 +148,15 @@ CONFIG_SPL_USB_HOST=y
>>>>   CONFIG_SPL_USB_STORAGE=y
>>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>>>   CONFIG_EFI_SET_TIME=y
>>>> +CONFIG_TEE=y
>>>> +CONFIG_OPTEE=y
>>>> +CONFIG_TPM=y
>>>> +CONFIG_TPM_V2=y
>>>> +CONFIG_CMD_TPM=y
>>>> +CONFIG_TPM2_FTPM_TEE=y
>>>> +CONFIG_CMD_OPTEE_RPMB=y
>>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>>> +CONFIG_CMD_MMC_RPMB=y
>>>>     #include <configs/k3_efi_capsule.config>
>>>>   #include <configs/am62x_a53_usbdfu.config>
>>>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/
>>>> am62x_evm_a53_defconfig
>>>> index 281fa3fea15..3221a9b8f2b 100644
>>>> --- a/configs/am62x_evm_a53_defconfig
>>>> +++ b/configs/am62x_evm_a53_defconfig
>>>> @@ -138,6 +138,15 @@ CONFIG_SPL_SYSRESET=y
>>>>   CONFIG_SYSRESET_TI_SCI=y
>>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>>>   CONFIG_EFI_SET_TIME=y
>>>> +CONFIG_TEE=y
>>>> +CONFIG_OPTEE=y
>>>> +CONFIG_TPM=y
>>>> +CONFIG_TPM_V2=y
>>>> +CONFIG_CMD_TPM=y
>>>> +CONFIG_TPM2_FTPM_TEE=y
>>>> +CONFIG_CMD_OPTEE_RPMB=y
>>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>>> +CONFIG_CMD_MMC_RPMB=y
>>>>     #include <configs/k3_efi_capsule.config>
>>>>   #include <configs/am62x_a53_usbdfu.config>
>>>
>>
> 

