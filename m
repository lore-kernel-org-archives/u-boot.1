Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B054EFD239
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 880CC8366F;
	Wed, 25 Feb 2026 10:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gwvh3FXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B595D83DEA; Wed, 25 Feb 2026 10:43:47 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2344B82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4wF9a9UQUgrtbUpNfR6J4I3OO4FrfGMRL4odS5YLRUYKzK/RzUZgEZU9bR6ehnwzC0bhLDSn6dzmdHeVfTkerT6QM3ftU/sWEJ67zQe9lwU1SHa5PoWkAGimBPHcG1HrKmzu2AfySQ+qAIXkUFSbPlX+VybPERcpJYUCtXQ1lyxgdTKWb26qAsdtYQ7kYEzPWxCsr3IlBM9sRHP4MXIk76gPORlzWEBNZ1uCZE0jtQt46+TjTq5GCq7Hzs+3Z4kWoTPp9GLwpD+oLGwuz9Orj2YSsleDPOzMPbGPUrU772ZQNxoxb6LGIjxoYpK7WLB3+RiSebJPuYkJH887iOmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+WKqfd1AJqfEKwVQRWEQdsCYtl7WyFoMBjmg+OvNc0=;
 b=MCz4/QwVI4IT6poIcwxoBipZwMFEI+60NdER6/2KSWTJQ5u4bBQorE72vuPNadBATjUYCiNXD+rn/P4WPQvHnyyXK40FqFXgHnG/gP4ssXtjYJq4ENZzGXByRTmtTXIVNAvdx4bL8xPQd9nRbjD+SRrNyZkB8yTo++j0FNokMznDgqOqn33Fuq4xED4iRWlEgdYFae0aP661uCmQlFstyH3VIckZApvniCczUtOoZAhMK4Gi2HJ6gkQicKPhsF5OkG+EOR4mS3JsU6s4PeQhjex9HUHdKQPAqIg1LfVQ+WVEh3aoG2LOcO6mRX/NSYceIIS3JXIQ4x5UUY/cTVaIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+WKqfd1AJqfEKwVQRWEQdsCYtl7WyFoMBjmg+OvNc0=;
 b=Gwvh3FXy1QmaLeDbaFF8ZNA0xHtcrA0+zTfgncXJHQbqawITOMAroXZflzoHtU0i+tVhk6XJvwpbWQGENJmQI5lg/Bde7t6O4mL5wpmu8LKi5PjSjYTs8HVHaTSAx+1i6AJ8P+utka9OU9nuCUz5dCNlUetA57vfIjqAyG5ow7I=
Received: from BL1P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::12)
 by SJ2PR10MB7581.namprd10.prod.outlook.com (2603:10b6:a03:546::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 09:43:41 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::9e) by BL1P221CA0037.outlook.office365.com
 (2603:10b6:208:5b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 09:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 09:43:40 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:43:21 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:43:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 03:43:20 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61P9hECJ224441;
 Wed, 25 Feb 2026 03:43:15 -0600
Message-ID: <a21ad9ea-56d6-41bf-a5d8-270d5508a695@ti.com>
Date: Wed, 25 Feb 2026 15:13:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62*_evm_a53_defconfig: Enable OP-TEE fTPM
 support
To: Shiva Tripathi <s-tripathi1@ti.com>, Andrew Davis <afd@ti.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260223091314.586968-1-s-tripathi1@ti.com>
 <7e0440de-1047-4146-a0ad-378503047269@ti.com>
 <ff104b89-f3f3-4960-8ad4-da876f8bebd9@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <ff104b89-f3f3-4960-8ad4-da876f8bebd9@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR10MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6ba6bb-aa63-4c36-233b-08de74525bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34070700014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: UNpEOh6k0i9HJvvoRnhTD6PI8laFkMf3mxH1kOrMQHZP9s7HapCK0ZqHThOaVUvulPlYPZtIekOYppELCmnDUP4kcPVlqFy4+b5NHcMWYIw3ZFWqaNbep5qBIweeUxF8VUkB0ZakItK5Y2WLAMMKopG+nO486ePLJGS0U0W4yG97LylHv+H/kmSnjY2SAbXb70r/9XZ9vuYTvX9xXLEWSgGxnTQV8FIrU/+NdbOQbCf5zIHbxNJ1kWaYk0qnsR3S8PRJ9hqmRCaE8jGdfw75UPLNCer+cdND+2u9K7q4YxMuQTuC/+TFp4qqyttPHH9bmbt1q4A9hvGXzcXPoDZDs1JAqgC0AuDaEdjjv5ns8hOBjvqtSP8OnQU8mewOPtvh77oOUUOqLFiaq6LxXXDM76nzKiM26KHZFxrzZedsHWBhsD585x9OFpCD5sXtJ6Swww18YJJnmMcMnD+79mu7oKZulkfAaPM+5mK0OwrEz9MUqLisXqGeqeyzSNdiHyh7wIEY+mN9vVpcAQALGMAcmKKK8oPIYWzj/p90FCxd4c1KA7N7el2cpCVBSQuOP2tHi/XqV7MmyLlHoGu6KljzyTcAP6TSwAjFoBNlAf+/ieoZvIf6y5epfCEcJIhdgPjZ3+jwHxBCaROzqIPLpcgaQRmrCn9mx1EYLxXc8/PWDN8VFT223PSN6KUCAWTANNgozfByTrn/ARRzySJ19IU54PUSYY/QHGSb4ipH75vdKHxBIofyzJvFoQRuxb37jesW0VxTt9y62jJtmBOpRuccVBqVPrvQDsXY5nR9j4aIPcH37S5y57QcQSwcvZqfHDbKkzn7pg8DGULwA9nL8etm0w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34070700014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Rcyu37og24wcmHQFLTWR65qQNQ1ZTfpKMM/JeSZIk33b2wPmneO63g+RBaiP+u+ieQcwpIczVw1juAEAv3Wm3A9UHJc/inbU/DAazx1zZji+Yh4C190Q7F74laR95ixziOivztAB8Phh8lsEyOHR/8Id+l6RX3IxRI1Nal2LZOGEAQiWNDvyKqxAZJOkSUXE+o7pQmvaOGp6pikfA5dMRYQU9e0bEqYFRb6mYmeG58pVX97qFh+Nt2IW25aMuWCWnjP/XsvujKpbp2RoQPo9wAStEx5jPASqECB2n6qBHTpI50N4Dbasj/RbCnpDdS1cafcLprnP8hle2IFrVWMOsi2iSo5zPgnTLiEt+aWlNiZQ8mTNSbp81xxKLAU0RalzE+hHX+X4YYfvoN3yzhmWT2oEmDWRa39/FrR8F0DO2+o9S3+ZQylCL+WRYYFduef
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:43:40.8393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6ba6bb-aa63-4c36-233b-08de74525bcf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7581
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



On 2/25/2026 2:57 PM, Shiva Tripathi wrote:
> 
> 
> On 2/23/26 21:28, Andrew Davis wrote:
>> On 2/23/26 3:13 AM, Shiva Tripathi wrote:
>>> Enable firmware TPM (fTPM) support for AM62x, AM62Ax, and AM62Px SoCs
>>> by adding OP-TEE and TPM configuration options to the A53 defconfigs.
>>>
>>> The AM62 family SoCs do not include an integrated hardware TPM. This
>>
>> No K3 SoC integrates a full TPM, so why do this only for AM62? And
>> why only the TI EVMs? *All* K3 SoCs and *all* boards based on them
>> can make use of OP-TEE's fTPM, so why not move this to a common location
>> in the Kconfig files. That way you don't need to add all this in every
>> single defconfig.
>>
>> For instance the CONFIG_CMD_* ones can be added to TI_COMMON_CMD_OPTIONS,
>>
>> config TI_COMMON_CMD_OPTIONS
>>     imply CMD_MMC_RPMB if SUPPORT_EMMC_RPMB
>> etc..
>>
>> Andrew
> 
> Thanks for the review. Yes fTPM can be enabled for all K3 SoCs.
> I will send an updated version of the patch with suggested changes.


AFAIK , for fTPM you need eMMC.
Please don't enable for board not having eMMC eg AM68. 

 
> Regards,
> Shiva
> 
>>
>>> patch enables the Microsoft fTPM Trusted Application running in OP-TEE's
>>> secure world to provide TPM 2.0 functionality, with persistent storage
>>> backed by the eMMC RPMB partition.
>>>
>>> This enables TPM 2.0 functionality in U-Boot and provides the foundation
>>> for measured boot and disk encryption use cases.
>>>
>>> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>>> ---
>>>   configs/am62ax_evm_a53_defconfig | 9 +++++++++
>>>   configs/am62px_evm_a53_defconfig | 9 +++++++++
>>>   configs/am62x_evm_a53_defconfig  | 9 +++++++++
>>>   3 files changed, 27 insertions(+)
>>>
>>> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/
>>> am62ax_evm_a53_defconfig
>>> index 167ba7ff8df..b14f19968a3 100644
>>> --- a/configs/am62ax_evm_a53_defconfig
>>> +++ b/configs/am62ax_evm_a53_defconfig
>>> @@ -99,5 +99,14 @@ CONFIG_SYSRESET=y
>>>   CONFIG_SPL_SYSRESET=y
>>>   CONFIG_SYSRESET_TI_SCI=y
>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>> +CONFIG_TEE=y
>>> +CONFIG_OPTEE=y
>>> +CONFIG_TPM=y
>>> +CONFIG_TPM_V2=y
>>> +CONFIG_CMD_TPM=y
>>> +CONFIG_TPM2_FTPM_TEE=y
>>> +CONFIG_CMD_OPTEE_RPMB=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_CMD_MMC_RPMB=y
>>>     #include <configs/am62x_a53_usbdfu.config>
>>> diff --git a/configs/am62px_evm_a53_defconfig b/configs/
>>> am62px_evm_a53_defconfig
>>> index aa241a73c3f..2cd572cd5c7 100644
>>> --- a/configs/am62px_evm_a53_defconfig
>>> +++ b/configs/am62px_evm_a53_defconfig
>>> @@ -148,6 +148,15 @@ CONFIG_SPL_USB_HOST=y
>>>   CONFIG_SPL_USB_STORAGE=y
>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>>   CONFIG_EFI_SET_TIME=y
>>> +CONFIG_TEE=y
>>> +CONFIG_OPTEE=y
>>> +CONFIG_TPM=y
>>> +CONFIG_TPM_V2=y
>>> +CONFIG_CMD_TPM=y
>>> +CONFIG_TPM2_FTPM_TEE=y
>>> +CONFIG_CMD_OPTEE_RPMB=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_CMD_MMC_RPMB=y
>>>     #include <configs/k3_efi_capsule.config>
>>>   #include <configs/am62x_a53_usbdfu.config>
>>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/
>>> am62x_evm_a53_defconfig
>>> index 281fa3fea15..3221a9b8f2b 100644
>>> --- a/configs/am62x_evm_a53_defconfig
>>> +++ b/configs/am62x_evm_a53_defconfig
>>> @@ -138,6 +138,15 @@ CONFIG_SPL_SYSRESET=y
>>>   CONFIG_SYSRESET_TI_SCI=y
>>>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>>>   CONFIG_EFI_SET_TIME=y
>>> +CONFIG_TEE=y
>>> +CONFIG_OPTEE=y
>>> +CONFIG_TPM=y
>>> +CONFIG_TPM_V2=y
>>> +CONFIG_CMD_TPM=y
>>> +CONFIG_TPM2_FTPM_TEE=y
>>> +CONFIG_CMD_OPTEE_RPMB=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_CMD_MMC_RPMB=y
>>>     #include <configs/k3_efi_capsule.config>
>>>   #include <configs/am62x_a53_usbdfu.config>
>>
> 

