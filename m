Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DFCCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFB283642;
	Fri, 31 Oct 2025 10:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pyXsicdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3574B838AE; Fri, 31 Oct 2025 10:48:13 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519B68331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoKuhzuUrY93yaBbeQo5zqvc9Wg25sgwbEA5osPEzyHF1+xM2jRQXXfElgD5Y8sInUFVpRVxABdSPx2BgJapXONkKKJtjvtO9vT4FPgsvF7Y2S3TBu2/ccLkbHOsRlTR5D04vb+fIoyx/yblbG9K9PEeftrmKp8H7KHmIpmwX27ue9Bu78MKvfLIbY2WGf+1uLtO8PMgF6Dpv8yJWHIYAqbM1TyrVRVW9zTmLSvrGGwZDqZ7G/pydyA3WjAHX2g/9j1gCLdg9JS1hzOdLg5tES1clUQmN8hRXN0h7HGfLdRO4pEhtMyT2rvHAJWJg+AobIOO0QRbjEsd/V/vGZaFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFyw+O8GFMRp+3GpfwR7jlNpi0/rfCM2/xjkEUsq5co=;
 b=Vpco1MGn8SjeY8j0ZXuC1izBl6/09qIx0z8kD8ed2/I6OnCsUpPZ8PyTYiZqqUhOiUgoPLywYrK5lVoEgNlY7bwLI/BAph/D/1wrT5+t7Mmle0VA5rpTdFsRBvCbBmLLOlbb77Dch1TRY2MdTxsKR0fyl8wzpaU02V2cixHzwz9LjTT8MHVOJw/f92acwvcUMFyoabEOxROceoq5d8qUV5hNAeJeh6I7OouQrmOv/uiZM0tJ9W2sONBp94fJX+PWlMvU4I+Mq7FVVt3tnLV57kDO6dD1eOVN6Zp1XOA6EgbfW22EYSQkiR33Y4Nku6RZlMGOiJ74dwawESUIAEPoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFyw+O8GFMRp+3GpfwR7jlNpi0/rfCM2/xjkEUsq5co=;
 b=pyXsicdjvH82qJDSJyFDCwKYyUr9X8VSIiM3sYVgmVEfbgbVbJn5fp/iRb5jmCYsNtLhbslsNyowJffZnO3Ml+Sxl+TaYPdXyU38b6sunyMPp+n5QtzmUvU8PLn+mPRzMFROt9IVaiikPzfce++Q+AoZoG6BiIyr2d8026Z297U=
Received: from SJ0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:a03:333::21)
 by DS4PPFD4164D783.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:48:08 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::16) by SJ0PR03CA0106.outlook.office365.com
 (2603:10b6:a03:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.16 via Frontend Transport; Fri,
 31 Oct 2025 09:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:48:04 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:47:45 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:47:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 04:47:45 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V9lgGE3674499;
 Fri, 31 Oct 2025 04:47:43 -0500
Message-ID: <bd6ae8a2-4450-437a-bba4-60d34beefc84@ti.com>
Date: Fri, 31 Oct 2025 15:17:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR
 config tool
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <s-k6@ti.com>,
 <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-3-n-francis@ti.com>
 <ca2a5898-f1a8-4704-9c53-e2ec3bdbfcf4@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <ca2a5898-f1a8-4704-9c53-e2ec3bdbfcf4@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS4PPFD4164D783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9467a2a1-357f-4775-f9c7-08de186296c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm8vL2wyU0tGQkVsakROWUNhOEVlUGRoRWlGK3RKWU9zWXBXbEtNaEdyMTI5?=
 =?utf-8?B?WXhkMTVYY1Jzd21GeFRRcjZDQ09UNVBUWEQ0a09RQjA0SjlUN1ppaGxadlVp?=
 =?utf-8?B?ZmhWcjNvWG41NEVYZ0JNV0MzQ0l3RXBoWGlSYm12SWtoNHdlYXRDeXB0UFkx?=
 =?utf-8?B?L3EycHp2YVVhQm9aaUNVQ2NCZHdQTm8yZ1greVhTK1JjSzYySTgvK1N4d2E3?=
 =?utf-8?B?VzVpUHhvdVEzSFdSVkw4UVlqWklpYUc0MUhXbVdhRWhkMTR6K3RpUW13OFl4?=
 =?utf-8?B?bmNYU2NyZUF1U0IrZlB0Q1pINGtZbFZsaE1BeXR5Rmk3U3J0bFNtM1NFZytj?=
 =?utf-8?B?K0xmUFJ3UUg2M09vOUtMUnpDYlpuVFZQTmNWNjhxRXI4czE4ZE9JK3A2YUVs?=
 =?utf-8?B?TExkSnhuRTR4ZS95SDNiaGRPaHZHWDRNKzc2cnZ3b0ZsbUsvc1R3ZlZlUUVW?=
 =?utf-8?B?N0IxSHZDbWpuQ0FsV0xlalluMG1tNit4SlZoVjhPZDlOM3NWOXc1NXpYREFR?=
 =?utf-8?B?Y1JRSm5ZSzk3RE9XZ0crVXJIbkZZNWdSa3lDMExTc05MSzJlSmlSOHJQRFVP?=
 =?utf-8?B?VnVnOGlYczJEWG1GbWNlQm1LZlIwbnpkRzJuWHhqNDV0ZktRektRbk5rbDhM?=
 =?utf-8?B?YUtMczV2TlpVS3MrZUh4cEF6TDZ1Q2VDYlptd2s1K2dYTlYvVU9sU3E4dkJv?=
 =?utf-8?B?SnN5UWVHZFgrdHcwN1NpODR1VWFnQjFkVDFvNE03a3NXd1lrMGZRK2xva01v?=
 =?utf-8?B?QUsrTWxQdGl5NVRKMzdZWi9BbVFzaTBUREVYeGJEcDVKeTdmR0prWUpvdjh0?=
 =?utf-8?B?S1JSRGFyajFUV0IrRXZqRE14QUtHci9VVXkyWjNKK0E1SDBDSGtRdTZuSTdi?=
 =?utf-8?B?RXA3am54WmNsZXNxTVNCVWdDejRYSk94d0x6OGlUa1lXQjhvUGhVbnlwbUts?=
 =?utf-8?B?U3JkRkc3Q3hrdFMvMUN3OEJiQUpyZFRaRXV6bm56RnhMM2ZiUi9YNE1maFRp?=
 =?utf-8?B?cWdqWGFYMXYyd3EydmVzQVpacFlVM3F6bkNveVU0QlZFRHQ0bE1ZRXk5QnM0?=
 =?utf-8?B?QmVLWXEyN0Z4blJ2TDViTVFHeHZ0TjE2MXVrblZNTXhvdFM4ZXBqVDhRTTdy?=
 =?utf-8?B?K0NTZlE0cFR1N2JqaEl6QlZOcDdyMStvdTllKytlRG5hamM3eUp0azFtTm5v?=
 =?utf-8?B?a0NWNEJyZGk1eWxqWXEzRXJ1MjJkR09YOTZtUGswVzA2R08xWVNWUENvQjJs?=
 =?utf-8?B?QU1DWDFkN2xLdjVscHpBMmhxNWlMbVdpa2MxZC84dWlyRm9ISlNZdUpISVNx?=
 =?utf-8?B?K1V4d21pSkxkK08zMUFENjdYWGdGb0xQbFdOM2ViSk1Mdi9zb0krTklqV3hR?=
 =?utf-8?B?amFUTWo2czlGdjlSOSttcFppYU50N3JrOXlRNUttTENYZmpxOVJpMm50QTdx?=
 =?utf-8?B?NHhDS1RCK3c1cXZPc0thNzF4RFVDa2YzUmRhMXlpMHVDczd3TUFnZEdwdFAz?=
 =?utf-8?B?TTBSdml2dHAvbjJCQXdEVFd0dEs3YkpaNXNoYzV3U0ZQTSttQWJhRld1YVdV?=
 =?utf-8?B?RnBpVnh1akdGSFM0Nks2dVVrYStxNm9pUlJQdk1ieEZXdjE0bGRxa3Jjeklx?=
 =?utf-8?B?bDFUUTZxZThzWDdwVDBrd051d2dwSjNQMlg3clY0RUhZcEVOQ1BlcUV4bXRS?=
 =?utf-8?B?YmVqVHAzdUVzSTdSUUNlTERZZ3FiS2pNUWVtU3BBQkxrVVRRYTlySElwdXdW?=
 =?utf-8?B?VVpGdk14SXhBQ0tGWEc4eHpmZGtNc0h5STR0TUxoMXZTRHlFc3Y0a0VqUkdQ?=
 =?utf-8?B?enN2cDhtYlJLeTVnSTJxNnNaUjZNclhFWXlBZ0lPYWp4UDJmT1Y4eHJLb2l1?=
 =?utf-8?B?aUdPamhKc0NKZnQxdDh6aEUrbDRUbWQ0cUd5aTZMSGNVbHdoQzZtVU9kQks4?=
 =?utf-8?B?ZDZvMGhRbS9jeTRvM0lLb0krVjA0OWtCS1N2R1BidnFiaFB0dHRkdXRGTlhn?=
 =?utf-8?B?M0RFenN4cy95SzltbXlRdnZ2UlVRaWpOcm03NVdFdlNtSGh4ZGRYaW9kNHZ5?=
 =?utf-8?Q?vsmqCk?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:48:04.7351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9467a2a1-357f-4775-f9c7-08de186296c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD4164D783
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

Hi Udit

On 31/10/25 15:00, Kumar, Udit wrote:
> 
> On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
>> Update the DDR configuration for J721S2 according to the SysConfig
>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>> is [0].
>>
>> [0]
>> https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi | 591 ++++++++++---------
>>   1 file changed, 307 insertions(+), 284 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>> b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>> index c91576bf093..ecd42b1cf4d 100644
>> --- a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>> +++ b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>> @@ -1,11 +1,23 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>> - * Copyright (C) 2021 Texas Instruments Incorporated -
>> https://www.ti.com/
>> - * This file was generated by the Jacinto7_DDRSS_RegConfigTool,
>> Revision: 0.7.0
>> - * This file was generated on 10/14/2021
>> - */
>> + * Copyright (C) 2023 Texas Instruments Incorporated -
>> http://www.ti.com/
>> + * This file was generated with the following tool revisions:
>> + *     - SysConfig: Revision 1.25.0+4268
>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>> + * This file was generated on Thu Oct 30 2025 14:46:29 GMT+0530
>> (India Standard Time)
>> + *
>> + * Multi DDR Configuration (table based on register configuration
>> tool inputs):
>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * | DDRSS | PHYSICAL SIZE | SOFTWARE ACCESSIBLE SIZE |
>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * |   0   |      8 GB     |           8 GB           |
>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * |   1   |      8 GB     |           8 GB           |
>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> +*/
>>   -#define DDRSS_PLL_FHS_CNT 10
>> +#define DDRSS_PLL_FHS_CNT 5
>> +#define DDRSS1_PLL_FHS_CNT 5
>>   #define DDRSS_PLL_FREQUENCY_0 27500000
>>   #define DDRSS_PLL_FREQUENCY_1 1066500000
>>   #define DDRSS_PLL_FREQUENCY_2 1066500000
>> @@ -16,6 +28,15 @@
>>   #define MULTI_DDR_CFG_HYBRID_SELECT 0
>>   #define MULTI_DDR_CFG_EMIFS_ACTIVE 3
>>   [..] #define DDRSS1_PHY_1420_DATA 0x3F0DFF11
>>   #define DDRSS1_PHY_1421_DATA 0x01FF00F0
>>   #define DDRSS1_PHY_1422_DATA 0x20040006
>> +
>> +
> 
> <blank line > also in patch 3/6

As mentioned in the cover letter, I did not want to hand edit this
configuration file so haven't made any modifications. I will work on
getting the tool to output data compliant to checkpatch rules.

Is that okay?

> 
> 

-- 
Thanking You
Neha Malcom Francis
