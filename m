Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B951CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 05:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58C8331F;
	Mon,  3 Nov 2025 06:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bw2Umq1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024AB838AE; Mon,  3 Nov 2025 06:16:01 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884B180050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 06:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzEX0HEcvrLSQPyMwLGFRqs09O+mHJ87ktTB5VkAsnPDwhx77mzbPuPX3AfIwLvX0iqBNYXNENv4iSlcMhsrmfdvOxLsI46Di2pFq0ouPjOzg+MjXUhxNqmgvlJfIy7mtWLmYMlaUSvwzSnn/dFqO777AfUGHjAtXq0Cdligmt1GEQc8+giuI5kP94Oz3ynftpdja+9Iiwl0MKsHGpJ3GAtgFEUkp7Vhc8iDyJiOfkskri7KwOZcb1emaVeYnpChpglxBN55wMIBK3i2KFs/pt78RfvrFIq9PwAM6QXftK6k3fQXu/iaKqdl8rm7jlIHqqceJQb+VSp4EGPCZ5r7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW0oAzm7cDh4LNEN4zKI1hiT1eCNkmKGHz3KhztxeZk=;
 b=ZfcOUJgs4jFORkgsL/80sXaWle0+x9vmSfdcIqBhuKVAoQjhNYwU9WkMBaoS00AhSx90FXA9xDYWIPke76JLtcyMe2TFkP+2ZlooUit55m5VGYoAiZm8l4lNsq66RcL0Lq1RgbCCJLPDywGJkKuYP8AxHWAaYoq0NTFoGM9Yc5txCfCaKygM/VzaLnVaFAptNo5zJsnf3fhaaxeh4LE6W/fLKe3iFmZzaAR2Bh86CD0/dyI/tA47QmfEzMWd5SG7ptnw+OIIwxllP3t/qSNA5XcU1tLKYMBZ1O/3SG6rPG3KQ9qn522zS4UfT83kGaYKbX8EO9z+7y8jqhcaVOBx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW0oAzm7cDh4LNEN4zKI1hiT1eCNkmKGHz3KhztxeZk=;
 b=Bw2Umq1RCwFT8zl9WWkvkX77Cht2xuOWI+8ywb8woBHQRhwnebZM4bWIX/SCxPKSRz2b63/hjBUVMKz+t4hPVJCVf31qD8X7CjpYjmiXbuPISo32C241WbZjWb9E1f50OkBKVlU9u0s+nFdFmf+BBUXnxd3kx3A5uN1F9agmwr8=
Received: from CH5P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::24)
 by PH0PR10MB997664.namprd10.prod.outlook.com (2603:10b6:510:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 05:15:56 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::e3) by CH5P223CA0004.outlook.office365.com
 (2603:10b6:610:1f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 05:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 05:15:54 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:15:51 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:15:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 23:15:51 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A35Fmaw3578163;
 Sun, 2 Nov 2025 23:15:49 -0600
Message-ID: <3441fa2e-74bc-4a83-a6bb-56286cacb65a@ti.com>
Date: Mon, 3 Nov 2025 10:45:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-k6@ti.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
 <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
 <20251031140810.GA6688@bill-the-cat>
 <20251031143111.ifk5yqrt5akjakgi@bryanbrattlof.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20251031143111.ifk5yqrt5akjakgi@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH0PR10MB997664:EE_
X-MS-Office365-Filtering-Correlation-Id: df222ca4-4b51-494d-3f5d-08de1a981056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmxibG9QaFRzeXh5Y0U2U2hFZFhaOFFQUjZxMWRTVm1EWlRNRFZDOHVhc2Zz?=
 =?utf-8?B?d3JhZmVwaWZsR09BdHZxSjhHZWxybzE3bGVoRzlhWXlPZGp1SEhGT290SkFT?=
 =?utf-8?B?Q3lxZHpyZU5kTk84ZUJNOFpjbkF6d0I4Yyt4K0ltYkhHRGdVNTVVN2FXRDh6?=
 =?utf-8?B?Ry95UUo1aWIzc254NWY2WjVCNGRwbExNVDZ3SkxXVzBINkVtYlhvMEJTUGtY?=
 =?utf-8?B?VzByazNwV0crUXkrZVdoVnlzYTBnTFRvZ3hhamQ3VkJacGVscHYvWUpNd1Zw?=
 =?utf-8?B?aGhzVlRza2dBSWl6LzhtbFFMY2cvNStvdXRlUG9Kdlh4TkJnWkNpU0h2V0to?=
 =?utf-8?B?RkN0Ni9TSk5RMVAyTnZJcDhEcGU4UStUaTRqbWRuSDlCQThEaU03QmZuR0t3?=
 =?utf-8?B?ZlA2QmRzRS9SRmdEVFFwbFBpOWVqT2lOQ1NEV0RndkoxbUN2N1NTMUFMRDFN?=
 =?utf-8?B?K1h0c1dPTlRtSXl5WGlIMXBLQys0RU9meXhqSGdMbkdUU215L2krU1gxU1RW?=
 =?utf-8?B?S2htMThJek51RzJuZm16aHRhZWFCalM1U0RUQkV3RWorQnBOOU1jbUxFMDhT?=
 =?utf-8?B?Q09SclRpMk1IQUlFQXZQRHZVMWt4dGlwOFlJYWs1TkdXY3RFNGtsbERvNWhQ?=
 =?utf-8?B?M2xHZWhNQUVaVGUvNnB2cERoeFFtMlFybEtJUVZoSlErYTZuUHlYZUVpNDFB?=
 =?utf-8?B?cCsrU0NYQU1RN3dPNWdvcFZVWDVWYTV4TjZZUHRYTmZjVG42MXVaUHRQSEM5?=
 =?utf-8?B?K05tcEJ5ZXhnaXBZOHp0NStRRzVxNnI1MGpnclh6YzZEVUhuUXFEZVpoZHJt?=
 =?utf-8?B?WG12VVNPanFHSjIxMm5kbENQVnc5c3AxRHE4eEsrVjVIOHFlcU5TYVVXN1JJ?=
 =?utf-8?B?MkpFd0gxR0YrZTh6TlhENThVSmdYS3lpQUd6VHNaMXRVSUFsL1JDSE1uejhr?=
 =?utf-8?B?MnZhYzZqbTB2YUFRZlBGVHZGS3RLS2lXdlBlVFpDM2tWNHJETjVwV1JrVjJk?=
 =?utf-8?B?ZjljODc5SytwWnZJTldUUmM1bVk1bzhkTzVwQWw2dXRmZ2VFQnZqWXdUd3ZC?=
 =?utf-8?B?TlgyNDNVMjBydU5keGV1dlp5cHZKZTN1dm13SjkrMThHdjNHSXFmelZ6ZHZm?=
 =?utf-8?B?K2RNSEJqaU9iaEhSbFpCQkJtNyt4WG5McStqOUlzeVE2Q2ZvU3hwWWcxRFhi?=
 =?utf-8?B?L2o0d1N0a2I3dmEvT25oY3lHVWRrU0phTFJiVmNISGdvQjZ2T25sMS90SEhp?=
 =?utf-8?B?ZERiZGxCVHMwaVhOQ0RKUUxES1BHVHVENjVJWEc3bVBIU1NxajlxQ1VsQjRs?=
 =?utf-8?B?N2k1bWVoWTRCUGY2TERhb3lmbzBDdTgxK2tHTzBlZUdMWUpKN2ZNYmV4czRr?=
 =?utf-8?B?R1RhYWJ3S0hTNHBXL2c5enNyMTZ5ZkZYS1JvcFpQeUhUZTZGbXJ1cXhWbE13?=
 =?utf-8?B?RFFRU0pqeTdQdTMyMlgvZHBFVWhaMGw3UWtmbkx3Y2IydVNXNUhrQXpjLzNs?=
 =?utf-8?B?clBSdHkwMDZpaS92clc4T3lnTE5DZEgzUitHVjJDUWFGU2NNMmpMNFAyR2ZD?=
 =?utf-8?B?OG55aEtBVnlNVEVQbWQwTHhtVzgxYTlWY0JXSzhXc1dpS2ZCZnpEOUVGWVZX?=
 =?utf-8?B?cnhyaHljVGZLcTBmekVESlpodExIcGtRRWZnTEoycEZCZ2hyeUlXNGtGMFF6?=
 =?utf-8?B?SHNzVUc4WG9DZi9zQm5BbXIrS2YwQVRIMzZxZmF0ZmM0K1RPZExoZVdUMUdh?=
 =?utf-8?B?cXc3UWVSRGhFR1BSRXZoWnBYTDJaMXoxV3ZPcFoyUTJoOWw5cUo4anRkZmdX?=
 =?utf-8?B?dTFkQUY2cmtIVVZmMC8wdGJRTlFSTkJUUnJtRHd0Tld2dFpuVFZhR0I3WFhQ?=
 =?utf-8?B?d0wvWU54ZHZEVUhqNkhrendmTFBnYmdTN0dBMEt2NEU1RWx5R0VRWUFjQkFO?=
 =?utf-8?B?aUNNUjJnVDQ0WTRJVWNYOUpkamNVRG1NVFVxaHJYM3Ewa1kxRlRMRWJMT21u?=
 =?utf-8?B?QUZrdXV0VEdhaWk5OUJ5aDVGalp6b00vWld1c1RqVy95VkdWRHRnS1FUYWFZ?=
 =?utf-8?Q?IF99tp?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 05:15:54.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df222ca4-4b51-494d-3f5d-08de1a981056
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997664
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

Hi Bryan

On 31/10/25 20:01, Bryan Brattlof wrote:
> On October 31, 2025 thus sayeth Tom Rini:
>> On Fri, Oct 31, 2025 at 06:32:40AM -0500, Bryan Brattlof wrote:
>>> On October 31, 2025 thus sayeth Neha Malcom Francis:
>>>> Update the DDR configuration for J7200 according to the SysConfig
>>>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>>>> is [0].
>>>>
>>>> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>>>
>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>> ---
>>>>  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
>>>>  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
>>>>  2 files changed, 2208 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>>>>
>>>> diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>>>> new file mode 100644
>>>> index 00000000000..810415494ce
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>>>> @@ -0,0 +1,2207 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>>>> + * This file was generated with the following tool revisions:
>>>> + *     - SysConfig: Revision 1.25.0+4268
>>>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>>>> + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India Standard Time)
>>>> +*/
>>>> +
>>>
>>> ...
>>>
>>>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts 
>>>> b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> index e35b767a7e3..3127ac83d7f 100644
>>>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> @@ -6,7 +6,7 @@
>>>>  /dts-v1/;
>>>>  
>>>>  #include "k3-j7200-common-proc-board.dts"
>>>> -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
>>>
>>> These are automatically generated files. Why are we keeping the older 
>>> configuration around? 
>>
>> Is this tool publicly available? If so, using it should be mentioned in
>> our docs too, so custom designs can update these more easily.
> 
> Yeah, a porting guide would be a good idea. It's part of TI's sysconfig 
> tools[0]. Maybe we can add at least a reference to it in the docs.
> 

I'll add a doc patch in v2, thanks!

> [0] https://dev.ti.com/sysconfig
> 
> ~Bryan

-- 
Thanking You
Neha Malcom Francis
