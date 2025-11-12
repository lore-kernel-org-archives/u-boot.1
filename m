Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8701CCCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 05:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAD783C08;
	Wed, 12 Nov 2025 06:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DaZ/RW/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3086B83C0E; Wed, 12 Nov 2025 06:57:47 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B4383AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYko0n93jXWCvEUPYIt7ZmWilF2Ir7/6pRYkna/OyqAr68T1OxTsxV1Xr97nV2RjoBvhVrOBwOc2VLheIgTIjKRpTpcFKxHUIqcw5Rx/mSnSPlDW4Rn/flh/j01EDeMiLDDgV6bpli/LIylmvI9I/4I4Q1zporAG4Yhd+4LFh3wKItWt7F6qVi1Doruw1Ukgj/nIG2rSUR9H8S9FRFx+5vFVxTzE3EM1VLzyHrYgrLzlWXNvyjHQv6TaJNqBmPxGbzBvYZmSMfePF1XbZW0y3QyvAHwvh5O21QyumA/DE2QTb/VvkFy+0suUjZqFlDbQ37gWKloQFPxB9wadRbkMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnfhkqGlHoGyCIXzv3F0bCm35fyCyjDwAfoi0XhsV3I=;
 b=aqZo5fbqzpCBxDSSIlgk0k1H1FY2yn34cH/vtaYJeIvcAp4Zkv8kePZNjMRGmrfw39YxzlMtq4Flyff5S+WqzNzDxjCCaDtQ6UUjJrvGFvf0bPd6Ki6eTny8TqEgmvtNBXXIpcJbKU5Q9YpoO3Rv67t5E5vj9QknVFrkNe6orTkJ2XhQ2i4DDPI7kDF+sTV1rN71/KbDrreObQ9oNY72vxsjkbpsydEhtmVokjf7w2nyPqHirKKJeCxiCkW5SSDedKrjQ1qlb+K6gKktoQHhhKDuCu10Etv45DHp1XxrElMwNgN6J7IARfW2zSHFSTxWUrNs84oL1Ll3+NbEY5vcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnfhkqGlHoGyCIXzv3F0bCm35fyCyjDwAfoi0XhsV3I=;
 b=DaZ/RW/q3p7m+l9qnJY95NyGfKWA4ZZUKVX++axoE3WfDqKfGGtfzNBKjaLsAHHhRsfJAOmN7/dwno12XfN3ejdHdxr9hdzW+Vs5m2RMNlPuM4KTR6T3G8ugBS+qN3e40xwaJjstNZPfWhLYMGRb07jGEVgwzeDUA171Fc4+8mg=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by SJ2PR10MB7734.namprd10.prod.outlook.com (2603:10b6:a03:56f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 05:57:41 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::1a) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 05:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 05:57:41 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:57:31 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:57:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 23:57:31 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC5vRSj2183231;
 Tue, 11 Nov 2025 23:57:28 -0600
Message-ID: <75199442-3afd-4148-9f31-b62cb28e51b9@ti.com>
Date: Wed, 12 Nov 2025 11:27:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] configs: j784s4_evm_r5_defconfig: Enable configs
 for PCIe boot
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <c-vankar@ti.com>, 
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>, 
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
 <20251111061645.1004382-5-h-salunke@ti.com>
 <26187782-ba7d-4ad0-892b-9e2e09f3fcad@ti.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <26187782-ba7d-4ad0-892b-9e2e09f3fcad@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ2PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 7164b2d2-11ce-4da3-b6bb-08de21b06442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGt6SzVhUkszemtsa3NqMnpaMGNxamJVbzNnZWwvWkczUmVWL3ZOWFFSeWU5?=
 =?utf-8?B?WTN6dVBPNVkzM0tXQnZDcWxqay96NVRHRlhHT3haTHJqUkhadXJ0R3pRaFBi?=
 =?utf-8?B?WSs1T2F0MG9kWCs4OGVidk9TRUJXaW1OdzRQbWhMbzZxMXpFRDM0Q1VEaUpR?=
 =?utf-8?B?ekExOHBHQzBFRFBsVGltQ3hjc0Z3cU5zTEc2K29LSmxLeWVEaXAzL2F5T0xn?=
 =?utf-8?B?WWxFOGtqcE1sSlBTOUZ2WDg3Y1AzaVl5VVY0U2VlRU81cGFzZnRZQ0NBRTBL?=
 =?utf-8?B?VnBGVUNFYlR0bXFqV0FKMGZrcmg1dEpobU90cU5BcUV5ZDhzdnZweTFYS0NQ?=
 =?utf-8?B?ZnJtLzJzV1g4OFpNQXNhWWQzaTNnSFM2eFg3L1YrMXVjVDB4aDl5UDVYL2Jw?=
 =?utf-8?B?R1RBY0RJZDN1dExsWncvSkZmQU4wRnVaS05jTnBDd2R5WWVwd3JSb012cWZn?=
 =?utf-8?B?UXdlYWtIdm53djV5WCtNSmovaVkxOHJVU2pmSXdUa3BDbEQrZDBYTmdvb2I3?=
 =?utf-8?B?ejluMmUzMUYrT1pBTzlrV2tNaFlzK0ltbjFIZVkvcjFEaGV4aHFDNFcyNklO?=
 =?utf-8?B?Q0tmaDYzRHJiOGtydnA5dVM1Ny9ZTUFYYXdYV1pseGhwTDZ6Q3draUFLRksv?=
 =?utf-8?B?RlVlQlpzcUQ5Rk5BOWNhWVM5TDFvQmpnWHI1QzZqa1dYdnRLUmR1eGRRc2JH?=
 =?utf-8?B?bnJoME1BSGJIZkRiOVVwczZ1YjVBakVzeWttVmF1NURsZjlnTWxCL1Y2emY3?=
 =?utf-8?B?UlVGeXcxK3o1ZlI1VlFveDYxcEtHSy8vNjFNeEFOMSt1YTNteFhleWhJeVJo?=
 =?utf-8?B?KzF0ZzY3S3FSOVBCczljT3ZUbXFoTG1PZklOQmpZamZVMWpUNmRYVjZXRXpO?=
 =?utf-8?B?YkVFaWoraGxoRXEwbkhFYTQxNW9LRDlKTW16UEp3OVV1bXN3L1RncDJYZ0hM?=
 =?utf-8?B?YTdRZWR2eDFGQWRHUUFyTWtyQXNsek85aTFuRk9tT3c1eERJUlVld2p4U0dK?=
 =?utf-8?B?dzNZb0NvUUJ4NGtObjRRamtKRXJONVllRUJyWEJVaG9wQ0dQb0pzNkRtUUFi?=
 =?utf-8?B?MkFhOEdDeENtYWxtelFNVk4wY1VpQ2FOMVoyY2FJQURFUmdyUTFMMyt4dW50?=
 =?utf-8?B?RjZZTjVnR04yZDNraDhuTkc5dnVkUDUwRHBQd1FLRFd2SWFSc0hRdEZFWSt6?=
 =?utf-8?B?S0cycEJHdzFaTExqcVZJUUo0TEFJSHk1Y0ZMdGpFS3hubG13LzJrcS9FQkJP?=
 =?utf-8?B?ZmlOTHpmU1h2ODIzcXR3aEVyZjBUQTJ3Y01aS29hQkorR1RlM2h0U3BiaURN?=
 =?utf-8?B?OWhQdWxSN0ZSYWx1SFZROEx5ZXlDNVJpSjN2NzFwUkFRVGRnYlJ1eFZMcVhv?=
 =?utf-8?B?aEdwWnQrcjM4QmY2d3ZxdXJzUWh2S2Y3UE1BUmVrU3dLenhuZFJlUHowczBs?=
 =?utf-8?B?RUV6cFY0ZzVFYy9Jc29tTVZrd3NZM1puc0ZGaTdGTEVkUFVua2VGeXN4NUQx?=
 =?utf-8?B?blVRa0d3QUR6SXc3TlhxSU5lSGsxYm5xT1I5MkZEVHFYTHdkTHZkdFBSc1dY?=
 =?utf-8?B?RUNZZEFVZUZiSm5tbVNQM28zYmtodWt3cnlQTXhYMm9QWTNmYU5NdDdicmhq?=
 =?utf-8?B?a2FqZWh0aHlGNEIvRmlIVXpQZWVXY3djS09BbHJlWFNQRkhLUVJlT25KVlFI?=
 =?utf-8?B?WjNhVnZFSW8remZ0NGNySFpMdlJNVDhMY3FvWWx0RlorWVcrL1g4b1lBZGNp?=
 =?utf-8?B?TVkyVnIrWGd5Mlo0QWMrMHFWK2ZRdy9yU0xsSi8wcHE4aWkyMVhYRmhZelpP?=
 =?utf-8?B?NW9VMFVqeHA4b2JYaVpab0FNbmJFMTZqRXRYNUJSM3F0b2crQUgrYnBWelVx?=
 =?utf-8?B?ZUJkaUttaXEzc043RmY2KzQ2RmxuaFBoQkFlTHU0Z2FsakdUbzRvakc5aUhU?=
 =?utf-8?B?QkJHWnlwWlFybmg5K0h4b2ZHa2Y0REhzcXlZZEVuWjZCbHNnZWJoVkRLaXNu?=
 =?utf-8?B?bTVXNUxXUzJhS3dISXZaY2piZFhQM1gwM1lkdjh1UVJ3ZFdtSG1QM0FuOWNq?=
 =?utf-8?B?N0tMMURNM2pDNkI4TmcydzRhaW5aWWJNQkcrNFJuNmJXdThLNHRuNzFidUlP?=
 =?utf-8?Q?rn4di0MU81/XNIVNjTdlfU3Yr?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:57:41.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7164b2d2-11ce-4da3-b6bb-08de21b06442
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7734
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



On 12/11/25 11:03, Kumar, Udit wrote:
> 
> On 11/11/2025 11:46 AM, Hrushikesh Salunke wrote:
>> J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
>> PCIe1 instance is used for PCIe endpoint boot. Enable the configs
>> required for PCIe boot on the J784S4 platform.
>>
>> Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
>> Torrent PHY, and MMIO multiplexer. These are required to configure
>> the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.
>>
>> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
>> ---
>>   configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/ 
>> j784s4_evm_r5_defconfig
>> index cc340a2fe76..2279ba7f173 100644
>> --- a/configs/j784s4_evm_r5_defconfig
>> +++ b/configs/j784s4_evm_r5_defconfig
>> @@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
>>   CONFIG_SPL_I2C=y
>>   CONFIG_SPL_DM_MAILBOX=y
>>   CONFIG_SPL_DM_SPI_FLASH=y
>> +CONFIG_SPL_PCI_ENDPOINT=y
>>   CONFIG_SPL_DM_RESET=y
>>   CONFIG_SPL_POWER_DOMAIN=y
>>   CONFIG_SPL_RAM_DEVICE=y
>> +CONFIG_SPL_PCI_DFU=y
>> +CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
>> +CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
>> +CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
>> +CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010
> 
> Could you check once , DEVICE_ID
> 
> as per https://lore.kernel.org/linux-pci/20240401110951.3816291-1-s- 
> vadapalli@ti.com/
> 
> ID should be 0xb012
> 

Hi Udit,
Thanks for feedback. Yes you are right it should be 0xb012, I
will update it in next version.

Regards,
Hrushikesh.

> 
>> +CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
>>   # CONFIG_SPL_SPI_FLASH_TINY is not set
>>   CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>>   CONFIG_SPL_SPI_LOAD=y
>> @@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
>>   CONFIG_SPI_FLASH_S28HX_T=y
>>   CONFIG_SPI_FLASH_STMICRO=y
>>   CONFIG_SPI_FLASH_MT35XU=y
>> +CONFIG_MULTIPLEXER=y
>> +CONFIG_SPL_MUX_MMIO=y
>> +CONFIG_PCIE_CDNS_TI_EP=y
>> +CONFIG_SPL_PHY=y
>> +CONFIG_SPL_PHY_CADENCE_TORRENT=y
>> +CONFIG_SPL_PHY_J721E_WIZ=y
>>   CONFIG_PINCTRL=y
>>   CONFIG_SPL_PINCTRL=y
>>   CONFIG_PINCTRL_SINGLE=y

