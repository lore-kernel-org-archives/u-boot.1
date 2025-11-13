Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF23ECCFA18
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 05:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBDA83C62;
	Thu, 13 Nov 2025 06:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xLnUcTxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F9483D0D; Thu, 13 Nov 2025 06:28:25 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 667E883C54
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 06:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtzpnLUnMMZu4WPIrqarUVjpFt9JSceelCy/zS9cwtCjipD/tDX51XgdA5Noyx4ESSjJ1NQahIco/gl4c7DJYHQemKEn2ytAV903L5lDN68aLhH8YrP9flnu5ZEgmezl5wBlWTNj95vOjPILkneeqEcrUFUVPzeAMesJi8/1iAXJSqLX4J9k4PqKzGeUlGk3uMSVgC3tRIab85Od33Jv3Ygb6VDbO1zg7+V7CwZSvFk+gvCDTP9Z1F4MNyIS4Bitg0iLAm2H09sWP2/DfhIET5jFvyoWB3Zs/xMBIh8Nee/BWFrHgR8LhwBF4PiX4gKGaQ4N9BJYHLqM2hwRbFLjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyj60Ms4KlTlYa+8b1eKpiS1bghWzThi4zc+N4ABCnI=;
 b=Z0yOqk1HYC3JUu26XhrvgWqBSJswBZg8/xjVFYHc/UdCjbBnHNCRWr7cRE8wB7fjVXTP2bhMqmMg/hu7KvdB2ApwI3Qz2OhTC/QF7anm87MmCq+HV2t6hHThk1ld//3nP9wKn2PiZ+LCqlU1eu1qAAnlzt1Q2KrchPmh1pMmTAWLD7W53OcqIrmyhsTYWU73i7u0ZDUQu2AB0mwqvhfXTaimJYkrDoQDArXYRMJRNYkyqkbLLqeHMqXkCVOb8gzehW+Und4nQUJuLViJZ8bMucyN0u17mfVkZcZl9Esk037pPm01gpv1Ar2kUTxZUqAqNjQbm58Tp+nI+uKv8Aw8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyj60Ms4KlTlYa+8b1eKpiS1bghWzThi4zc+N4ABCnI=;
 b=xLnUcTxnhzo3uwwWtSbrXWKmFvOyhwZajf/fOcLwjRW765N5Zq5KrsBVkxfbFxxsqyqAwLH1AlY5TVlBiE5Zym/fasoTQ4rSMFI5YOMe/t4N32tHgL+L2B6NVgtn73Y1aO0RUOJkcMKDxgQI/1u2fkbQsTvX+V7Y+7vZiyakFaE=
Received: from CYZPR14CA0022.namprd14.prod.outlook.com (2603:10b6:930:8f::19)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 05:28:20 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::1f) by CYZPR14CA0022.outlook.office365.com
 (2603:10b6:930:8f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 05:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 05:28:19 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:28:17 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:28:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 23:28:16 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD5SD7W3883892;
 Wed, 12 Nov 2025 23:28:13 -0600
Message-ID: <c143dd67-7034-4a32-ad7e-f7754b10a964@ti.com>
Date: Thu, 13 Nov 2025 10:58:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] configs: j784s4_evm_r5_defconfig: Enable configs
 for PCIe boot
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <c-vankar@ti.com>, 
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>, 
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
 <20251112064725.1049199-5-h-salunke@ti.com>
 <ac1472da-3d1e-4975-9815-50a83b4abd9b@ti.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <ac1472da-3d1e-4975-9815-50a83b4abd9b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BLAPR10MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: de0ba0d5-28d3-4428-c2d9-08de2275748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTZhakJaWGZ0aFpJT0x0cHVOU1B6L3JZRWxadjBOUGpNTmJlWjJkZVh5Vjd1?=
 =?utf-8?B?TmdZSXJuOXFTR2tFRzg4VC9WUnkrYkV1dEUyRWF0d1hoaVBpVlhvdnl5YnZy?=
 =?utf-8?B?ZWlDem9lTlNmOW0vdkJTNUJtV2FSdEFnK280eU5qZm5tMVN6K1NGVFJrQlhr?=
 =?utf-8?B?eG9nb3dmNFR4c044c2FqaUVUa0JsVVZaZFBLSXBUWEY1cERldkxEMXVIRGla?=
 =?utf-8?B?Vzh1d3RRaDVGeGF1TnFUaGU0NFYzMmJKaGR0Q3U3K2tKWDdtRmtKVzEvTjZQ?=
 =?utf-8?B?R0xkN0dKYUcxSlkyODV3c1lxL2p4bjNHTVZod1VMWG5Gc1BCVGxXbGt6Q2tM?=
 =?utf-8?B?NC8rTTYzVEN0Z1JrV01SSnZHZE9yNzU0ajlRYkswSVEvMUhnNW9vc1ZLaGdK?=
 =?utf-8?B?bFZFZGl2aFVmNlpsV3ZFUkFNellrWnV2NWxIdFFiU0Zud3BXakRwd3RVQklv?=
 =?utf-8?B?c0YvSWpXYWxjRHJZOHhCUGhkRURScDZhVXltckx4MU9COGNpdkY5YkxQTy9X?=
 =?utf-8?B?Q2ZEeWJQb0x5aDQ5M0k3eXBwMDdsc1B3UU9lK2U4OW1MUk81anBkRTYwZXpB?=
 =?utf-8?B?WEUvamN3cVBDOE1jaUkrMFNRZHdIRkdMNEFpWjdNYTE3aGJZNmd2WUlQdXR2?=
 =?utf-8?B?cU1EbWRlbytwNUNIMTVVNnZUaEhwSk5DSmZJN0RXdzI1d3BEMkN5NEtGNUtL?=
 =?utf-8?B?cmhseGJqWTJWUUdJOWUwSHlUdVNrKzlhMEdNWU52YTRuWGVzS1hYTi95QjFT?=
 =?utf-8?B?VStSRkkySS9nTnhaMW9Fckh6cjNjaW9TcWRWcUhIeW0waldOcWtHeWdzMTFM?=
 =?utf-8?B?NnAzT0hVSDNXUUtqQ0F4Q0hhbXEyM0RPeHdCc0Q3cW05S3BiZFZsN3hrVTlv?=
 =?utf-8?B?V3BVQi9yRDI5RHJMMnlPQ1NjSVljYnYwNnNkclVHRUxCNHB2NzNwZnZkcWkv?=
 =?utf-8?B?S0JpRGlEZjJ3U0c0citQaTZZTGxjUDZ2eGlPSkNlbzA4OFhQY2VCNU1rWDRL?=
 =?utf-8?B?NU5NeEZiZlhKY3IxdS96SUZzUk93V3QxN0ZnNlhvZWFNYkNiWXYwNjlabUQx?=
 =?utf-8?B?TWFHK01lUC8zN1ljVW9QTFdXL3JKUU1xN3ZEck1nNHl0SDRqM3FpdklEVldY?=
 =?utf-8?B?Yk9EZndDU3RyVjMzODFKZmt1L0d4VDdDVzFxWCt3VTZzTFZXdVBJRHdMNzNR?=
 =?utf-8?B?ZU5icnhQU2U2d21IVjNKdUlKNUQwcmNweFU1QnZNVWpKUUZkOGlaVEpYQW85?=
 =?utf-8?B?RDZTa0szV3J0UXlDcWFlUnhkZ2ZKaVlFRXMweEo0bDA0NWpJclJYL0ZBNjlO?=
 =?utf-8?B?dWZNWnNPMUk4ajZYRUI2UWQ3T0psNmZqbW01UmM4WGhqQTU2enNmblI4b09l?=
 =?utf-8?B?bWdodXBVSHczL3M1ZVRvN1gyWnR1KzFiM055Rjhsb3hCNUI3YzNXOHExQVdY?=
 =?utf-8?B?ZWkrMmtMNVQ3d0xCdEdqVlFwY0oyZStDcnFTU0xOcVVRYTFQTDFZM2Z2d0lP?=
 =?utf-8?B?TTQzOXU2SmhNMG5VVXpYbkhzdTVDQktDWHJwdkJJdmQ3YkcrN0hORTBFQUk3?=
 =?utf-8?B?Rjk0TXZTYk83OTN2Nlg4NGNhN0xtdFJnQTN2TC9Ga0hoT0ZJejY4OEhGUVpw?=
 =?utf-8?B?amswSlV3VjRYNnFVQ2xDaGFReFp3bTNCeCtKZnh5SnlLQ2FYWnFncVpoOERC?=
 =?utf-8?B?WGVNSDc1SDhnY3hCOWRKMWdGSjlnVWdYbURDZkZFaVBxUlluZDJLcENlYTFC?=
 =?utf-8?B?alNsUmU0eUM3YW9kOWFBQW93QlFhd1FCQTVOQWxYeEdPTDlwUkpYZGNnS1ZZ?=
 =?utf-8?B?bHpSTUtmRFVjSW9KamtNaVFUN3NpWGVUM3VzV2dQMUVneHVYTFZDZkw0MnBk?=
 =?utf-8?B?UEljdSt1WlhCOWR3L3VKU0haTlNVU29aUy9uSmo2eTVIUzd5aW1IUi8wYk9v?=
 =?utf-8?B?QnNWQStOSjJnZDNqYjRaOVYzd3cxYjVoVU1ja296ZUJiTUFHQjNLQUFkajQ4?=
 =?utf-8?B?SmNnUE9MTlI1TGo0SGNVdTNmRFAxWldIR3JuYkVCazVUQ2FSamJDLzVMaEo4?=
 =?utf-8?B?amtZV2p2Wkx2N3Z5SDZ0aDIwM1J6NHdsdGZORi9KRExLbGhLYzhYNFExM0Qz?=
 =?utf-8?Q?5oi++yEywLeQQQHd7ftw5Rjq4?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:28:19.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0ba0d5-28d3-4428-c2d9-08de2275748d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
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



On 12/11/25 20:38, Kumar, Udit wrote:
> 
> On 11/12/2025 12:17 PM, Hrushikesh Salunke wrote:
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
>> index cc340a2fe76..a69a253ad12 100644
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
>> +CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
>> +CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
> 
> 
> Since AM69 and J742S2 share , this config.
> 
> So please test on these two board as well,
> 

Hi Udit,
AM69 EVM doesn't support PCIe boot. J742S2 supports PCIe boot
but to enable it will need some changes which are not the scope
of this series. I can post the separate patches to disable the
PCIe boot configs from the board specific config files.

Regards,
Hrushikesh.


> 
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

