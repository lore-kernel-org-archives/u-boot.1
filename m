Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FFC55ABF
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 13:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1245B83DBF;
	Fri, 20 Feb 2026 14:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XYlpEJur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8DF83AC5; Fri, 20 Feb 2026 09:35:22 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFBA83A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 09:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvFT6R+hrDUhPnp1kf7g3cXHpkn6YUcoxcj0Zcs1V49TrnyjTDqxltarLI0fGcbRhVkaz96cRoWOyXKxo4TjN3SUSxUTevNOnyJ5TQJZjQ/7QnVwNZFTsl84recEpuXbb4BdiJRO3lBUC6dDYHfgQ+lu5o6I/ZGsO+6LF0hn+F6x8r6cyY1+l/llPCieHi85fnxfUmX5pPb0PnW8FIL4GyY66VUTWGH2A8UXqzWt97PT8oISCMC5gsZPzXNvP7k9rYgl/ugVI5QGStod3r62dDDpMwsq2Ez6PJ7/a8pIQmpnxt8XpTjL2cAgIVA+07ct6EJMLTbAoeOCrD1nApYJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE1Li5owD1PcDKCzFRFLWJOBSgUGVZGNpVpR354J3Vk=;
 b=y04XHHrQ4AU+GG+Iw0XNSGYVXgQ/u1wv+zhRNr8b0BxtIXuBLflgdF7LrJT8jofK87gd0JIJG4JbbGgd499de+8+FlDN81cHCRzR4oTJMDvqtolxP2hyhFotBtLuLZ6YSSqg8ByHLouL4N9WFgHi8eXk6qYZison7KJEYv6nepXQFIWM9PSf+3g4gYPRtZPJ5UZTv5OC27qqsBWmoI2EmcmPBrQxQGZ5Q/RD0Ou5/sPC114vU5hijsLWIBHkBf9ms5A1yN/iTZ/h5DKd0e8SqFJTgOocTjNfdpD57iPXPN97ZSKWTpYY01ey1AUi+rMr5m45fS9PQT7oiEgpZU97Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE1Li5owD1PcDKCzFRFLWJOBSgUGVZGNpVpR354J3Vk=;
 b=XYlpEJurVBQdkxSDyjqCqcENlXq/WF3/bmYGgCeYi/es6vAwBwI8N06JRqfouH/lhh3g3gdm+sJpZNoJNYseXLBVs+PhxCbKYE//l66yfbRvpZ7GFK1myJbowDgmVTWMhvVaH+rVHui/5UdxQ+02G2+Pw0wjalteQC7KeLTl0Hk=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by SJ2PR10MB7706.namprd10.prod.outlook.com (2603:10b6:a03:56f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 08:35:14 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::ac) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 08:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 08:35:14 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 02:35:13 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 02:35:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 02:35:13 -0600
Received: from [172.24.21.92] (lt5cd2489kgj.dhcp.ti.com [172.24.21.92])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K8ZBff3570073;
 Fri, 20 Feb 2026 02:35:11 -0600
Message-ID: <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
Date: Fri, 20 Feb 2026 14:05:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability
 of MMCSD speeds
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <gehariprasath@ti.com>
References: <20260220072515.143720-1-m-shah@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260220072515.143720-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ2PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f962fc-e844-40bf-e06b-08de705af817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2Y1R1Y0dUVXZitiK0IvU1VxVzF5RUlGbTRpRGc0UmxJd0FWakRCRkRIL0hC?=
 =?utf-8?B?bG9vNjFqbXl1cUsvVWZZZUtLSE1JOURzTjZzaGhST21aN0Y4ckw3Rit4RGZm?=
 =?utf-8?B?Y1duRHUwUkV3UXJlV0xQejhkQm8yeTI3OFhRajJnZVNZeC9aMDgxTHpYbGNr?=
 =?utf-8?B?MXV4MEhDZXZGcVRUMmxoU1JGVVdSL09mSGQvOGtSWDFBaUxpdURBdG9IOEc3?=
 =?utf-8?B?N2ZWczluaFkxSldvQzUzWkxsbGgyWnRJZ1I5WXErWFd3amNJYWRtbm0zNEJl?=
 =?utf-8?B?ZTIvRlRkUU1ZRG9MYk1ZNFpLNVBIZEN4OFY2bUNWYlVqZ2MvTkxPVHAyVHdK?=
 =?utf-8?B?UFpNUU55WlpzOWl1eFpGekd6Qmp1enBKc1gvbWNrUkNQSng2K3FFMzZzcUlX?=
 =?utf-8?B?S0xPeWwzNjNyVnVRWVM5WEVNRWVlSnRaS3dxL2FEY2JKOG1YMzFDL05WVHNq?=
 =?utf-8?B?OC9SL2dvMXcweXMzQmowamJmNlVDTHp1N3Z3N3BhZ052Y1BLL2dHc0F6eUJF?=
 =?utf-8?B?ZHdPZHVGOXBBSHoza2RnV1F2a3FCcVRGdkkzd2RHNE1zaTlMUzRlekZkd0tT?=
 =?utf-8?B?RkFDS0JvbW1wUmdCaTd1YmQ4OGZrNEhqZjg5UW94dEVlRHJLOUpkV3owU0sy?=
 =?utf-8?B?NGJNVkU0Y2ZnSXgrendlTEorMFFRWmw1QnRMR21PWC9MSWVqMy81ZFFPS1hL?=
 =?utf-8?B?YkZQVHpSSHArSTNiek9zUSszYTcycTMzdk9vK3NoWTVNRmdiamd2MlhXcFRY?=
 =?utf-8?B?dEx5V2ZJRzFKWlFWdFUzZkRoM2R0eTE4UW5sd3RMVGVaZjlQK3RqdlhpbmdR?=
 =?utf-8?B?SndwMVdweE1pcjFXM1FZODJKbzBvNGd2UlBVUFZNUXhjMlpZV1dwOFVjNDdC?=
 =?utf-8?B?QkY5ZmJRWnlZY01RNUcxWGhXUk5GaW5nUVVaM1JsZlZ2VEh3OEhkUnU3N2Iw?=
 =?utf-8?B?elJyWWNoUkJrMURhL04zREc2MndWcWVmVDBkVUJ6dDZsRlFiV2tJdHRpblY2?=
 =?utf-8?B?bkhIMjBlb3RtNEFoQnkrRXk4RlI3elhyNXNka0pTdHdVbnlYOVkzNU1wR3pv?=
 =?utf-8?B?aVJaazJoSFdzRHRaNnk3TE9OZWhQeDRtaUE3enoxclQvNlErRE05dkQwaE8w?=
 =?utf-8?B?TllJakMxTXpFQTRYVXg1M1pDOVdwY2JCRU1iUDgxSHFxa29TRngrRTNXYkxH?=
 =?utf-8?B?eHVENWUzT2VWQll3ajRsb0NObTRIYUtMQlc1cGJjZW9FamRyYzFja1RDU01Q?=
 =?utf-8?B?dVB2WWhTaUJ1ZWRwdFhhZ1JZMXo2NHN5R1ZRWmxqUWJ2TVlyUmdiNzVkZjh0?=
 =?utf-8?B?QWdTMHFqUjFDQmErcEErcFFZMTQ3aWpxMlZ3eEJtM1IxSExpQmE2YTB1a1FI?=
 =?utf-8?B?UzQ4b1p6SlFMVy91TjJwOGVYRHdxTFBFZnczcVB2dk1BU0tEK0kzYzVabVlL?=
 =?utf-8?B?d21uYjRlSVZrQnZZTXNzVEJ6NWUzblJPZXFuamFtMDhscXdzV3kxQ0UraWJm?=
 =?utf-8?B?SEhmcjZUWTFHOHYvbGlGdk1qTFpDT3ZnOGRvWXM5TDFxYmVpOXhscGZ6K3NB?=
 =?utf-8?B?RTV1dlYxb3pyenBrUldUZXZDL0ZFeUJZMDRMR0xxSjFPUFpOSFVIbnZWNVNa?=
 =?utf-8?B?V1picSttWnZLZ0VTK2phZTdzb0l5SDRZZGNPUk5XUkVRaFZlSk9oS1F3cCtT?=
 =?utf-8?B?L2JBTHFUVjhycnUyWHlNMit5ZStkNWxEbnlLN0JSSWc5aEJsMGUrSUkzb0dY?=
 =?utf-8?B?cUwvVTVBck1rbk0vTlg5WXlLRlE2RDJSckRjYVorbFpGREZLdEl1QU9PcVVX?=
 =?utf-8?B?QUJ2U2l1UW4rQTNPYXdsYzhsSkYxZllhbno1dXQwK1pKNHdWaDhobDNZRERo?=
 =?utf-8?B?NFNCQmVmUXBQemVHYnh4cE9jU2ovTWxXbFAzM2JUbWZZNkJueDB6UjhkeEJu?=
 =?utf-8?B?am1zY0pSVjBmbk45S2hIQ3R5Vlh1WkRqYTVQMVVnWEtTT1pJMVV5TjFUalha?=
 =?utf-8?B?NFV5UkNWdzhhdXJhUWwzc3NxTDR0SGJEaFJ5R1VLZ0VTVGhxU1NkT1FiaUNY?=
 =?utf-8?B?MGZuQ25hWEd3R0FuMFA4MWxpRVlIS21IbmV4VkNwcG1CbjhzR0l6UThtazlr?=
 =?utf-8?B?Nmgwb0pQaWszQXhOMjFRbVQ5WEpmU2plMTdld2doVkYxcTdYM2pLcGFzb2JC?=
 =?utf-8?Q?oA8GqnNFJBvODmk0nsuWwMw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IsXh0w2NUfFTJ/LXICtgt7JrpGAvqqRpgP8eDcwIi+UncYKvgKYZZmEG81BQE47VgzV8p8ZDcuVZ55EHXr4KI07AErK6MHSMzU4Bmy94lFq/Ehbx9URh1VkIuuJfkDZwSubJV+HKUKRgeZZkKuzMGEEBuNUfB6xAP23shpqIlyil0TI+LObc1Y1hwJGt9skbjCCOX1zYgSAH5I090OPwnJOQ2yksykW+j6lxc35T+7KQpI+q6B3s6YiMQ0H5rGXh39p2z3vAGJ/D6YVGfbk0tHCDDU+EYmVMTNeh5A26iF8xTnZ96Y2SwLAnWTiTh15O1TAoZGdSxHZQPJtHly6325hY5IoZJdJzwye0IemSMzaY12NGycRPrT6C/4WRJ0hETiCnEAAWEMmSfmjN3Xk4hRN/y2/naiF3/I+lSk+yzTWO3KhZwhSTsxhyrxPhWGMw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 08:35:14.3644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f962fc-e844-40bf-e06b-08de705af817
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7706
X-Mailman-Approved-At: Fri, 20 Feb 2026 14:03:59 +0100
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


On 2/20/2026 12:55 PM, Moteen Shah wrote:
> Add config to allow UHS support, in turn allowing to select
> UHS speed modes for the SD card
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
> Test logs: https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e
>
>   configs/j722s_evm_a53_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
> index e84670c75ed..24ee293c803 100644
> --- a/configs/j722s_evm_a53_defconfig
> +++ b/configs/j722s_evm_a53_defconfig
> @@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y
>   CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MMC_UHS_SUPPORT=y


you may need at A72/SPL stage as well,

and do you think , R5/SPL will need this too ?


>   CONFIG_MTD=y
>   CONFIG_DM_MTD=y
>   CONFIG_MTD_SPI_NAND=y
