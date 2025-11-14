Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B03CE7B1E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA6384137;
	Fri, 14 Nov 2025 16:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lm+Io4YY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F42018413A; Fri, 14 Nov 2025 16:07:39 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8920F84135
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPy4fs6FeuU1ltzXFCpOufeAckenAIRKO6Qs2OX375ZwrEBu8RtlWKlZ1ymnLo6g28DJatrUTEC0wZBU2SfYyd4WQHlc2O9CPwH1u844Okpb+BULgxg4mNm+RIeStfsMZPiMz5UiEFLYwS4YPJcA20jtRk+DSzuBBqrzw49f81dlQPDRKoKfsimf5G5cW623wXDFcf+vJabPakiQb3UthIoWqH6P2ZFQMadJ1Z1itnle7TG7NPwkIwtDgGiSCSis+4JIAuVL9hQqAmfEkuqhUuQA7Prh6HuBt6qTvjP1uTROOdGJAFzn41JPb0j/N7LgND5tFZPyukICS953Jh8SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XEXH1AKKvrz/xqIC7j5uGVHd8sgGyw65QpbrdnGcFg=;
 b=RZ2PG9hdm4yEjnOkt9HBPJgj54NWkJEedoW8fulHqKJvG88pMnNU3U8K7Y2xqUZtJ38o6rRMzG/n8IalCG5mR8v9KzCjtuIWeAi3TEIvO+xE7uLHI1FDFdUPcRXUbQrOOqRuSwDss1IT4SOgUlUMqTrfx7+SmuAITAU0prQlOv7r42bpYb0eaPiqEMQs6HJRR0rEM9A7bqSFjvbyyTJftDWRiJML3jhpx2PAJZfOYNgP3I35EcwTOjVz+bykkt/rHzuC16rD1OXMUPe76Q3y2ML0m1xw88wqagIvimqEP7a31ShQfxgmUmPoAET44nAWrJComdCoqRdCI1BuerMoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XEXH1AKKvrz/xqIC7j5uGVHd8sgGyw65QpbrdnGcFg=;
 b=lm+Io4YY/qxKEptZu77iv3GrlIs7keZdXeL2M0qrpb6EHO9m1y95Q7YWUR/lbtrnOE6cWkFJM3PkAw2LXbC3yGCBCK6IdaCixpcpntac42b5Qi0m2XrsrtF9/bCyUw6DlLzsin78rePT98vhj+06zwuZ9Z26LCpKEuiXBwmZmRs=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by BN0PR10MB5000.namprd10.prod.outlook.com (2603:10b6:408:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:07:31 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::67) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Fri,
 14 Nov 2025 15:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 15:07:30 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 09:07:26 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 09:07:24 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 09:07:24 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AEF7KZu2211358;
 Fri, 14 Nov 2025 09:07:21 -0600
Message-ID: <92e38a5b-2dd8-4f09-ac9b-fd41c1479e95@ti.com>
Date: Fri, 14 Nov 2025 20:37:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>,
 <afd@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <t-kristo@ti.com>
CC: <h-salunke@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
References: <20251114114611.57032-1-s-vadapalli@ti.com>
 <2136a803-617f-4dcf-9dac-3459d6b132e3@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <2136a803-617f-4dcf-9dac-3459d6b132e3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BN0PR10MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: a75ae4cc-587a-4d15-446c-08de238f880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpnT0JmK3p0bWJvTmNGdXVITTEySjdsTWxqWWs2RVJCWDVlbUVrU2p2Zis0?=
 =?utf-8?B?N0NZc3BhQkVMeDJHV0xFd3dCSDRiR2RYMzkzU1dsejlmakVFTi9aQWlvT01j?=
 =?utf-8?B?Mi9kaWNyQTJ5SVBvWURFVEU3czYxL3M5d2puMGhZNndUMzNBMjc0enFzNkFk?=
 =?utf-8?B?UGI4UXo1TUVsWXlLNTZwWjc0MFI4K28yL09BcEZCQWMzcVFKN1c4UGNJa0dJ?=
 =?utf-8?B?R2hWL1FUN1YrOEdMMW1sR1ZPcTFacFFraE1tcENhZUFuaG12a05WN0I3dWxY?=
 =?utf-8?B?Wm9VdzRIOERIdlFxdzBoTk9KcnFwem5TamFhS2dDU0VSMjI4dFpERGFqS25H?=
 =?utf-8?B?cnJyY1VjTDNkbjdZYXNiNFJyZ1BOTGxyajZPb04zdWZoYlBVWjl5OGtlSzI3?=
 =?utf-8?B?WnY5WW1jazZLOW9KQ0JyMGNqN2lhVmdpMmNJZzRwbDBFaU1DanBxbXBEU1lJ?=
 =?utf-8?B?cU9halo1VnEyTXBXTEltSVNNZkwyaHFwclhVblBxRHNCNTFsOXZ4clRYU0Rv?=
 =?utf-8?B?a3lZRXBPUm1ZMHdveUN0NzBpLzFzRFRaaFJHS05oYU1hZmRDSnRlQ2dNTWNP?=
 =?utf-8?B?UlFXR244UEpMWi9xUUZtd2owdW5nTnpuZFFkbSt1eTRvRlRHUjJDdEhpY3ph?=
 =?utf-8?B?UDMzRmdnR1NnMWtPbmI3bFBOaDZaR0JNY21UQWNQSEtXcStxYzArSVNWck0v?=
 =?utf-8?B?dVlzVkIxcE10UGJiNk0yVnA0RDVGaVRvcVhUOG5iNEVVZHFKUkhScWlmVGpT?=
 =?utf-8?B?aGVCS3VCV1BCaUY4VFpXRUZSeFZ5VDdKcTZPTm1jWEtlbWU5Ym1UWDRsdUp1?=
 =?utf-8?B?TnEvdjA5VkFRc3c3aW82akg2d0RvVGxCL0lubkQwN1k1eFgrQlFjRy9za21n?=
 =?utf-8?B?TndJQWkvb1pWWGtRVDI3VGtGLzRYSS9ZeGNNVWZicGdPVFAxQ0hxVVAvU01U?=
 =?utf-8?B?NFRUS05VcHA2TjYxTEREaG1ueklGT0oyQnEwYnQ0SC8zbWh1REljZURMb2Yr?=
 =?utf-8?B?SXo0NnZ5QUwwSEF2M2d3VnNyWEZUdTNZMjNaRXVRTVVXWmdhUndOazN5TEty?=
 =?utf-8?B?SE1PNkE3cG5oUVA4ZnRzUldZQzkzTEp2MlpDWkgyZEVxSWxLelRsaFJFcVRX?=
 =?utf-8?B?QWdkYSs4bGl2VzZpUHpybWx5YU5iNncvZ0U5OXczZUhyR1pCMWxPeWFBTmlN?=
 =?utf-8?B?WXVwNWNWbzJqVjNLM0lIZk40QWJqQnpMTkJRS2VHYzRWSGFqQ0lDUHFrZ28z?=
 =?utf-8?B?NEdPcjlITks5UVVIQVZvK1RobEV0dzFTOUFsZmRiSklLTHFqQ1RRV04zS3gr?=
 =?utf-8?B?Q2VGQ2FCZG1GenM1Y21iUUNOWTZON0FpV0dwd1RMMHlZNjE1TmtXTEE3b1JS?=
 =?utf-8?B?eWtWSmxiNUt4RmJpVWpIRDBnaStXTUI3NEN4RldrOHErS1ZJbUkvay9SeE5Q?=
 =?utf-8?B?Qy9idVdkUk1Wcll6MzU0Mk1PdFN5ck5zNG9rZ0pvN0xCWVlTc0EwQmo2WTFT?=
 =?utf-8?B?NVJGVmczaFpRY1lONDdpOXdmdEtDWkttM0VhUUlUZjNPNWIzUTQ1NmRsV0c5?=
 =?utf-8?B?VmI4Z2dOYk9wUmNLYmxpYWxxc0lSRmtGRlhmdXZrZkpxZlhnRWZIK3FSUlJr?=
 =?utf-8?B?eTlwbmRncFQ4T1Y4RUljTFNqb2xqa1d2Z3JuT2Fuc1hUM2dNaG1ERjJuUXFO?=
 =?utf-8?B?NXRpR09yMjZNMk9GelpkTmRTUmdmdTgwTHhpdWIyV1B5M2dQbFFvTXRuSjhk?=
 =?utf-8?B?THlpZUJNVG9MUDMxQUtZOTVhU21nSnFubUFMMjVCSWJzU0dwajdkZWpZbzBy?=
 =?utf-8?B?emg2UHZLaGRNakM3dEp3TE5KcGJXZjEvbkhDWE0rVlhTc3IwNFIzbXBLWk5X?=
 =?utf-8?B?NXVHR3NYb1grdWVJWGdHU3RnMVNEeGdUTFQyS2pxSThTdnVNL1pqa1pnaith?=
 =?utf-8?B?L2xXdDJVZXRnYm9WSk50Wkk5ZUZ1MkQrcmM3STc4ekhma3hoQnYvMjR4RFZZ?=
 =?utf-8?B?Y3ArVW0rVUgwV1ZTVVZZWWxDZDBuS1NhRDhJTm9TVFdubmx5ejFVcUhrdkp3?=
 =?utf-8?B?ZUF2cFZ5VUVhL1dSMmFucVBJWFpHU296WjV4UGlHbEc1eGJRS2YyNTYzRDM4?=
 =?utf-8?Q?VIYU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:07:30.1921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75ae4cc-587a-4d15-446c-08de238f880c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5000
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

On 14/11/25 8:23 PM, Siddharth Vadapalli wrote:
> On 14/11/25 5:16 PM, Siddharth Vadapalli wrote:
>> The helper function "ti_pd_get()" is responsible for powering on a
>> domain if it is powered off. In the current implementation, if a power
>> domain is determined to be powered off - no prior users and the PDCTL
>> register indicates that the user desired state is OFF, then powering on
>> the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
>> register.
>>
>> While the current implementation indeed requests the power domain to be
>> transition to the ON state, the helper function "ti_pd_get()" doesn't
>> verify that the power domain has 'transitioned' to the ON state before
>> returning to its caller. As a result, it is possible that the device(s)
>> belonging to the power domain may be accessed before it is truly powered
>> on, leading to a bus abort.
>>
>> Fix this by waiting for the power domain to transition to the ON state
>> before returning from "ti_pd_get()".
>>
>> Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> 6c2f2d9aa63 Merge branch 'master' of git://source.denx.de/u-boot-usb
>> of the master branch of Mainline U-Boot.
>>
>> Regards,
>> Siddharth.
>>
>>   drivers/power/domain/ti-power-domain.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/ 
>> domain/ti-power-domain.c
>> index c3519307340..8f43d0fed30 100644
>> --- a/drivers/power/domain/ti-power-domain.c
>> +++ b/drivers/power/domain/ti-power-domain.c
>> @@ -227,6 +227,10 @@ static int ti_pd_get(struct ti_pd *pd)
>>       pd_write(pdctl, pd, PSC_PDCTL);
>> +    ret = ti_pd_wait(psc_pd);
>> +    if (ret)
>> +        return ret;
>> +
>>       return 0;
> 
> The above section could be replaced by:
>      return ti_pd_wait(psc_pd);
> 
> I will post the v2 patch implementing this.

I have posted the v2 patch at:
https://lore.kernel.org/u-boot/20251114150243.96429-1-s-vadapalli@ti.com/

Regards,
Siddharth.
