Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE00BCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 15:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F85845B4;
	Fri, 28 Nov 2025 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DVhQMBb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEA9845B8; Fri, 28 Nov 2025 16:10:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71378457D
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xezWaK/aVUDyVq6aRwNHXomVGODKIEtm054aEeiTJKAAXf1fR06YK64dQIOoutkIUeKyqm1mymfXgZ9z5tu79XM3r+CJ8WZMCI5A6SU7UIDQ997FJD3FpuHKmcdROvJL5lMECqadmHFAwaWyKPtfvnmADp4jmMgfjJg4XAAPHImVdM3pSGf4YxmUSX76ZMiuzgtPkSWAAbj5TkxCoPGzHKoFqFdQc2/q0g9qMI6rXaU2uabFyvKhcXd38F6s7/pb4+pHZJTvhF6TnPSAe6rQ5xb7d/KRSjdwnw5HjGGwaL7KODYEBRlyaXmOvRe7QePmRaZrmkVzhVKhYTmAIIHC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFbxMas3zLPnuZnkDfFlEIElmBZqF3HG6wXBy8m2X1I=;
 b=nqWnSRTT3djunif/5ITJcZmGziobbap1VR/K6+/aYKJoloFqqT7GQBDjlQxGVsPQYceaq8kMIIsJBL5JPc76nmE9VLUBN6m/OGhxDs35ZnNeLTRkqvuFMKfmVvRPD/mycb1/BcKu7oXYh1mixdPVU10TBZ2v50+CuI7XvCYZPEUHpXMP72ZF5D39AE8G91h1n0i42YWdq4Kyrg0nLcXpKIJMVpuPukAOj8Gbrtd0hVcH+WgfiHe3OGCALO5XcbDJ+XdKxwloowF+sw9oNXFlen8pW4lrHhU88Sgk8Ae7HMWAbhcfcMMTeI/dkSSkrACjxZWEZzFaecv2PlYTLW4eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFbxMas3zLPnuZnkDfFlEIElmBZqF3HG6wXBy8m2X1I=;
 b=DVhQMBb7NBgCW2L8Lc1vTBJ/mnJF9JC0X2Sl1feJR10pqS8Rkx7HuPqyeS3nMWcoNAQGe28j7bcFdcIbC1LBGufqu7gpcrp9iLnyijt/tNqAN64tVGkNd0u6SYUYcw3MlKCGcA9XHyXOg9iEI5XQusxhYm08KGQSJ4w7Op8KXRY=
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by CY8PR10MB7219.namprd10.prod.outlook.com (2603:10b6:930:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 15:07:21 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::5) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8 via Frontend Transport; Fri,
 28 Nov 2025 15:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 15:07:19 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:07:15 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:07:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 09:07:15 -0600
Received: from [10.249.128.16] ([10.249.128.16])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ASF7BFM491806;
 Fri, 28 Nov 2025 09:07:12 -0600
Message-ID: <a6b58eed-8eb0-4c0a-b656-665e25bd2d03@ti.com>
Date: Fri, 28 Nov 2025 20:37:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: am571x-idk: Reserve EMIF memory used by PPA
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20251128064353.1295063-1-b-padhi@ti.com>
 <20251128064353.1295063-3-b-padhi@ti.com>
 <821d9b15-cc5c-450e-8ee9-2531d2ec5e85@ti.com>
Content-Language: en-US
From: "Padhi, Beleswar" <b-padhi@ti.com>
In-Reply-To: <821d9b15-cc5c-450e-8ee9-2531d2ec5e85@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY8PR10MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dcf7cf-41fa-4364-e747-08de2e8fd37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdsYWpwRkliWFVGbVBONUVBeG95K0RnUlAxVkg0UjVDa0kyWXFmMlc4cGJi?=
 =?utf-8?B?YkRSV2NnellTV3cwUllYdUFPMDh4NVRtcm5oSVdIQmtYSHphL0t4WTF5bGxT?=
 =?utf-8?B?cmEvYVNTR2pQSjMrM3FOZ2IwOHJncVRlNUxMN2pYd28zMEp0aXNWTDNwK3d0?=
 =?utf-8?B?cGdrSldGSDc2Q2NoS1p4dHlVbUhuYmk1UWhJaE9RS1J3R1BHS3VNMnBtWWE1?=
 =?utf-8?B?bEwzSmhKS0YvZlgrRW5VWHBFaVYzUldrR2Vtc2pTRXVmNDhWSFdIRHpFOXV4?=
 =?utf-8?B?a1ptaHRBS2tiRm8yNUVHV0puZmhacWpQTEs3N0JjTi9VZlZMOEp0UTBqUDJz?=
 =?utf-8?B?TDZ1L0Z1ZU9XZUk1YjlFWmxrTGhGdlVhWUhmRy8zc2pPZ05YREdFM3liNENV?=
 =?utf-8?B?RUdlTzUxbHNSWi9oNlliTU9FWDBPUlZjbFRZVm9PdTA1U0dvREtVV0VMRlVK?=
 =?utf-8?B?OW5iYzBnUWlxa0hnOTN2U2MzcXVNWG90Uk9DMjFUakZvQUdha01JSjBKVERB?=
 =?utf-8?B?RUVEMUI1TmE5MUpQeUt3WXZXT1ROelRsU1AxU2dDWmxoREVJbWw4T2VySWVp?=
 =?utf-8?B?R1VSejM3ZzMxYVRjbnBSOFgrNzdkcnJJbGQ3c0VuWnduUTJveVJEbFlYVVAz?=
 =?utf-8?B?L2xwZmV6ZnJhUDkrOUhOb3dzb3E5aWlYS0R1ZE9ZYW5ieXI4TC8yMERPaXRK?=
 =?utf-8?B?b2hVdWNmMERhK1hIUmVaeVFITEIwazlHbHBHR3ZtRHFkdllkQUllOWt2QUhj?=
 =?utf-8?B?SjMzWWUveTZGYVM1a2FoTzZIWVJQbjFKQnplNXVpWksxVXhuYTQyU0ZMZ2FL?=
 =?utf-8?B?cXJad00yWi95ZnIrZ1VTVWpwRUZQNzBkcUhuU2hvL1VLSHo5cFRMOHZRZWtN?=
 =?utf-8?B?QytnRmNsb1N6eENzMFRjclprdmRZQVJOODdJa293RFVQK01CV0luRTFJTStw?=
 =?utf-8?B?dUJuWHpKa21uZW5kVTFJRzQxRXZYQlFqcXNpdCtrNktDWTZnMldDdGpRVjBu?=
 =?utf-8?B?b1dCbzM1azlaSjQ5Z043bXcyczJseXhoelpCejloWHYyUVNUWVRKRW5GYUxY?=
 =?utf-8?B?TXl3M216U0tmMTJ2TVRPY0w3dndQdS82WHJFWG1YalhSSm03NnB4UXMya0JK?=
 =?utf-8?B?dXd0dTU2NVdyMlVzRUE5allYVTErVWZnS3kzeGh1bXc1WklUV2pqRVdzU2Vq?=
 =?utf-8?B?ZGtaQjREbUl5d2JsVlVJck9hSXhzV21LYlVyWXZmdEhscXozNHZHYWQwZnN6?=
 =?utf-8?B?OVMxQTNtOEhab0IvdUVLeXhMTXdDdWZiSmM0amxJYSt0MU9XaXRHcGdiWHJ1?=
 =?utf-8?B?R0toRnFwSkpYRzBHVlB4MGRTa2haMmpQemdmS1VIYzZxTUhLMFNYcUMzZ011?=
 =?utf-8?B?RnhhS1k3bjNGSXBNRnNDejVMWkY5Qng0azRRcWl1K2EzZE5NaHdpMTdHNUlk?=
 =?utf-8?B?cHNYKzdjeHN4UzZ5REhKQXRQMCswSWZuNEpoaDB6WUxwSEhpa1BtNjN5YVVi?=
 =?utf-8?B?OWQ1VG82dWh6U1QzM08zNklsbW9mSjFHMnZHRERjaFgvdXVTdG5GV3FnSEk0?=
 =?utf-8?B?WWJMdlRrMitvcHNLT2kyOHdVc3pPdDJ6dFNYODVvc3lwYWpKNks0TXBwT2ox?=
 =?utf-8?B?L3RSMXlZbDFoRm1zSlR4VDU4TU1DSUg0WlhtdEpKcXRaS09VT3hDWWJwSjZK?=
 =?utf-8?B?T3AzSis4VkxQbGw1NGtPYTFFN1hYK3owN3I3bklhQTlBQ2lhMTY1OGFYbmRn?=
 =?utf-8?B?SlRDcEg1K2lvQVU3UHZYMnNOTmp1ZFpncW5VWExJNjBQRkpnY2NHTlU0ZHF5?=
 =?utf-8?B?bUFnNU9PdUlmOFZORlNURXlvdHhXMzlVOFl2UFBLSE56QXhkUk5TQmN2OW9J?=
 =?utf-8?B?WFJGSnFFZ0ZoSzRnanVoQUsvYWFHRVdGWU9TR0ZWMUUxdUtQTXcrVDhUa2hI?=
 =?utf-8?B?QW9YcFA0L3BtZjlDQzh5THVFN1NTQlc5WkFVejRwbXBVNGY1QW56cjBuOE1O?=
 =?utf-8?B?bnNDcyt3cHQwYUNsRjRDdzFLb0JWajhYMHhRK0g2YThZeU5NWitXMmZud1NJ?=
 =?utf-8?Q?5HPA+m?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 15:07:19.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dcf7cf-41fa-4364-e747-08de2e8fd37d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7219
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


On 11/28/2025 1:44 PM, Kumar, Udit wrote:
>
> On 11/28/2025 12:13 PM, Beleswar Padhi wrote:
>> The AM571x SoC has 1 GB DDR space. However on HS devices, the top
>> 0x2500000 is used by PPA and is firewalled. We should reserve this
>> memory in device-tree so that U-Boot doesn't use that memory for
>> anything. Reserve the top 0x2600000 memory (aligned to 2MB as per page
>> size for ARM32) for the same.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/dts/am571x-idk.dts | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/dts/am571x-idk.dts b/arch/arm/dts/am571x-idk.dts
>> index b3592b22a0c..0cbd8c8a685 100644
>> --- a/arch/arm/dts/am571x-idk.dts
>> +++ b/arch/arm/dts/am571x-idk.dts
>> @@ -20,6 +20,18 @@
>>           reg = <0x0 0x80000000 0x0 0x40000000>;
>>       };
>>   +    reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        ppa_firewall_memory_region: ppa-firewall-memory@bda00000 {
>> +            compatible = "shared-dma-pool";
>> +            reg = <0x00 0xbda00000 0x00 0x2600000>;
>> +            no-map;
>> +        };
>> +    };
>
> You will lose this memory on GP device as well .
>
> I suggest to have DT specific to HS device, or reserve this at 
> run-time after detecting HS device.


Thanks, while trying to do this via FDT fixups, found out it was already 
taken care of by:

https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107


Thanks,
Beleswar

