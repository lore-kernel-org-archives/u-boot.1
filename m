Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EBECCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D755583642;
	Fri, 31 Oct 2025 11:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oIpFqcCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1117A836F0; Fri, 31 Oct 2025 11:30:37 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BFBF8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 11:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR5+TIaOC9WZ1/bFbxb9Y8Su+xboyyJUvqc20XgEZtt/S3BWIMsYC5wAl6kk/FBYCUbczIJYX8AXxni2C1YMbWH0HJ8k1cFQVfr0cP8iOaWfT+Iehueo5/nRaohzBPCiOnIrLnodnnuUmcCgKF0RA1SPaPFPH9DMLWx/BnZwrV331+Cqx89+Ah9/gMUkLiGH1AReUJi7XzmGGnOw2+mELDqddoThZoUUk941N2lLGOMMPbwU7zjdPOMnnAae7Sz+3BgzBVTK53Kyc9azx1uyEC5IooT11+Ps2PwCq2/e6QNbIvvtl4WkcgbLag87I9C49Z0UtF86GCQ6b3RvBKHw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS7feGgPyH6/8YeQHSmJNPxSIbJDqf9Miusz9RcG5lI=;
 b=xttx1KnVQtW15zOTIFXr0a27Hijye65SrrVfrlfSv2s+XkV1YPMLtPUoaUIg++VB7zJflmt9NfzrIZDuz9IQZ+2S8r6i6Y2n32BWVCmGlVjSkmCQQv99NHIDYMOf2LZ4N5KCty7b8pEfxvuEwXgBaakZlRNI5AfOZ49P0BMjsGSKVflPDEW4wK2hf9PDEfd1ut+6EvjMJ1RFVUzQS5M4gwPJXZuvTFA4tqvK9mR9uTMaZlD25bkwWGBil3yp4tKtWv4iH9Iv4oVSzeeHCgCf1UikLBZt+llVi5sVVd1j+bkyojwVqD3DEOkqQICKk3KWlt4Y/awwutDSMzzTkAmGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS7feGgPyH6/8YeQHSmJNPxSIbJDqf9Miusz9RcG5lI=;
 b=oIpFqcCUZRSRCZIEamUjBOEDV7+XaF0R8CPvark5T8UHUT7Oc+0VXcMX0Gh8ux5C/RP477X6arSRFwtZ2dedUc8BWb3zSShJgpEyW09VpntW96VcM5ed0M7XA8yGFZIifNDme+XxV1lxpa6PAiIPvC05IGcE21VeBqpVS29K8TA=
Received: from CH0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:610:e5::26)
 by IA1PR10MB5948.namprd10.prod.outlook.com (2603:10b6:208:3d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:30:28 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::b5) by CH0PR03CA0261.outlook.office365.com
 (2603:10b6:610:e5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:30:28 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:30:27 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:30:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 05:30:26 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VAUOZA3767789;
 Fri, 31 Oct 2025 05:30:24 -0500
Message-ID: <b6f34727-d3fb-4dbc-bd1b-319f4521fcf6@ti.com>
Date: Fri, 31 Oct 2025 16:00:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR
 config tool
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-3-n-francis@ti.com>
 <ca2a5898-f1a8-4704-9c53-e2ec3bdbfcf4@ti.com>
 <bd6ae8a2-4450-437a-bba4-60d34beefc84@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <bd6ae8a2-4450-437a-bba4-60d34beefc84@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|IA1PR10MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a4391b-b31b-4006-6d3b-08de186882f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkRHbDl5d09HRGVBaGNzd0FrV0hxeVJTUmVhaC9xV3dCVXhKQWZuTHh0S0ht?=
 =?utf-8?B?TFkvclhMem56ZmlJVi91ZlpwaUFSNS85T2Y3TlFZWVFvaW5BN2o1L0QzbHhM?=
 =?utf-8?B?alZKZ05RZnVINWJuL2VPTlh0ZUY5M1plbnIyK0xMRGMwYnI5K0d2SHBpZXNW?=
 =?utf-8?B?ZTNMTmE0UHNCNWdGTHVKZHlqOUx3MEc0Zjd5SUZUZzFNSk5KWWlnU255RDFZ?=
 =?utf-8?B?ZTh1TldPTEFveWRQV003dU9rRW1PcURoSFd1UnJ3eHg2MmFSVy9kZjBWZVhV?=
 =?utf-8?B?eWU0VXFMWVRpcVhvOHRhY0hzdjlLSE5hN21jdTVQdm4xWjZteVVuZlFBSWJX?=
 =?utf-8?B?N3lPaFlYYy8wK2MwVGlreDB1aUVKYkhPTkd0RzQ0N0pZTEJyZDZWTnRMK2tP?=
 =?utf-8?B?WnNNbzhVa1o3ek5sOTZRalplU2Zjdi8vODBaMlRzT293OG9IWkpjNXhpRmxF?=
 =?utf-8?B?cTRFRTM4S0VGQ1lkalAxQ01Gd0Z6RWRvQkxYaHVodEVzci9pS2d5dWNobnVX?=
 =?utf-8?B?aHM0OFlJd0VzSVg1NEF2SjRHZlg2OERORGMwUmxSVFJ6dkM4KzZPU2Fiakl4?=
 =?utf-8?B?VVdaeW1oZ3AvODFGS1VuWXJPamsvdjdIbjl5SjNYRUE5NnVjK2pmQ2UybStO?=
 =?utf-8?B?MzJBLzJmRDAzSGU1K3NndmZoQlFWVm1hQmhhUzgxVURTNThjOExYVStIVW9v?=
 =?utf-8?B?Wlk5M2ZNdVdoYWN2V1hXa3dqRm5iZkUza3A2OEFvWnRqbXBVVnMySVRnUEdK?=
 =?utf-8?B?Wkg0bEY3VERWS1oyb0N1YU1PM1k4TlJQa3BNRGttU3d1MHVZR1E1ZkEwaWtq?=
 =?utf-8?B?QWhGelo1ZVRJOEZBc3cxeWRVWW5kbFBuWmY0dWh3MDBad0xJWmQreDIrZE1R?=
 =?utf-8?B?bTJNaTg5cUgwN1FvMXl1M2dYZURnRm1XenppcytiRUZZV3d5dXRaUXJwWkFX?=
 =?utf-8?B?ajZYWTB6cXA1RnhyNnVFcmlobjdJeXhmZmo5T2FQMHJVVmxxb3l0eGIzN3Yy?=
 =?utf-8?B?NEdxSnl6Z3ltdXQ2ZnFyNzRWdFBCTVR3YW5pd0Z0Kys2b2FiRW9tMHAwMzMy?=
 =?utf-8?B?MUU0RTYxVXNOTFdzTTNvaG4yejFxemdDYmJpNkszd3gzZ01PTHZnaGRxai9i?=
 =?utf-8?B?ME5McFJqSXRwMVB3Uy8zUzhWUzQxTVNhNGhCUFZ5TGdVUFYyWGFrKzBWQ0hs?=
 =?utf-8?B?ZUVuYlF0aW5vdWlvU1NLemVXbXpCTi9oYndMVjUrK1Irbjl5d2pmaFdFTzhq?=
 =?utf-8?B?MFdXRkhxNUMzbUx3MlBHK1BtQTBvSktHK3lWT0pTem40dkV0NjFvTkNUV0tE?=
 =?utf-8?B?V21kTkVFbjBmZDJVN3ZOYmFRQjFRNkJsa3BKT3dRMm1YQmdNRW85OGluM2xi?=
 =?utf-8?B?YVpKWm0wOERMM2FhWkJETDFRcHdUZ1BtdWxaMDVneVp1REhQRHB0V1J5bTJk?=
 =?utf-8?B?bzY2ZGVXWWZWTkdjK1l6RjVCSkZocTE3Ti9PeERaL0hRWnNkSCs2QUp3T3NO?=
 =?utf-8?B?MDRuQlh3SC8xRmFFUkxsSWd1L1NpTnhGZGIxM2NtS0V5dzhzZUpxWnp5eHhG?=
 =?utf-8?B?R01PV21zYUlSWGQza29USFZqSzY0ckRCZGs0eU5ENG9hMUNONDFBRmdVK2xx?=
 =?utf-8?B?c2pqZkt0MHlKZXlIeTRaUDdXOExWMFBHSTZORU1jbEJWaS90V0JJSWpNbVRy?=
 =?utf-8?B?RDcreGdlS0I4aERhNE05UmtRVi9uOU9GalcrWXFMY2dDcUdlS1pxdFZjUTY4?=
 =?utf-8?B?c2MzVFlJOEJobGhlNkpzbldwbmViS2xsSnpqSHpkZ0NvcDRLVU9SVWxrVzFq?=
 =?utf-8?B?Y1VtV2pKK3JkY1BXTmNVQ3VISGJCTFA5QzFpMnJaKzM0RmRzNzR2Z1ZwVjlN?=
 =?utf-8?B?YkR0eUcvdTlnTnFYNHFPM1BBUUhrM3hqMlRwVWk5VHdJOU1qdjV4ckwwRHZP?=
 =?utf-8?B?YzRnUEpqL0Z2T1RrSjdQdUJHbS9sMVZDUzhtMFZxd2JUTTArQzB4OW1BSVpU?=
 =?utf-8?B?cXNRbmxBSnhwc3liT3RCOWNuYlUxSXphK29USWlYZ1dBZGFXZjh4WkdxQkJv?=
 =?utf-8?Q?da3Gb/?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:30:28.5258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a4391b-b31b-4006-6d3b-08de186882f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5948
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


On 10/31/2025 3:17 PM, Neha Malcom Francis wrote:
> Hi Udit
>
> On 31/10/25 15:00, Kumar, Udit wrote:
>> On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
>>> Update the DDR configuration for J721S2 according to the SysConfig
>>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>>> is [0].
>>>
>>> [0]
>>> https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>    arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi | 591 ++++++++++---------
>>>    1 file changed, 307 insertions(+), 284 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>>> b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>>> index c91576bf093..ecd42b1cf4d 100644
>>> --- a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>>> +++ b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
>>> @@ -1,11 +1,23 @@
>>>    // SPDX-License-Identifier: GPL-2.0+
>>>    /*
>>> - * Copyright (C) 2021 Texas Instruments Incorporated -
>>> https://www.ti.com/
>>> - * This file was generated by the Jacinto7_DDRSS_RegConfigTool,
>>> Revision: 0.7.0
>>> - * This file was generated on 10/14/2021
>>> - */
>>> + * Copyright (C) 2023 Texas Instruments Incorporated -
>>> http://www.ti.com/
>>> + * This file was generated with the following tool revisions:
>>> + *     - SysConfig: Revision 1.25.0+4268
>>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>>> + * This file was generated on Thu Oct 30 2025 14:46:29 GMT+0530
>>> (India Standard Time)
>>> + *
>>> + * Multi DDR Configuration (table based on register configuration
>>> tool inputs):
>>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>>> + * | DDRSS | PHYSICAL SIZE | SOFTWARE ACCESSIBLE SIZE |
>>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>>> + * |   0   |      8 GB     |           8 GB           |
>>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>>> + * |   1   |      8 GB     |           8 GB           |
>>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>>> +*/
>>>    -#define DDRSS_PLL_FHS_CNT 10
>>> +#define DDRSS_PLL_FHS_CNT 5
>>> +#define DDRSS1_PLL_FHS_CNT 5
>>>    #define DDRSS_PLL_FREQUENCY_0 27500000
>>>    #define DDRSS_PLL_FREQUENCY_1 1066500000
>>>    #define DDRSS_PLL_FREQUENCY_2 1066500000
>>> @@ -16,6 +28,15 @@
>>>    #define MULTI_DDR_CFG_HYBRID_SELECT 0
>>>    #define MULTI_DDR_CFG_EMIFS_ACTIVE 3
>>>    [..] #define DDRSS1_PHY_1420_DATA 0x3F0DFF11
>>>    #define DDRSS1_PHY_1421_DATA 0x01FF00F0
>>>    #define DDRSS1_PHY_1422_DATA 0x20040006
>>> +
>>> +
>> <blank line > also in patch 3/6
> As mentioned in the cover letter, I did not want to hand edit this
> configuration file so haven't made any modifications. I will work on
> getting the tool to output data compliant to checkpatch rules.
>
> Is that okay?

Yes , Thanks


>
>>
