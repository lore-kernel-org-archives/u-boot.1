Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F61DF3C9AF
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C3983E9F;
	Tue, 24 Feb 2026 17:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="UuFTet0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243E783EAC; Tue, 24 Feb 2026 17:53:52 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A0682BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQrHFZ+TS4FM8qZNrAonVA8wjb6oP7Zlde+4oFcNThk576gRXu9Ej/Im60Y7GzUQlbcsQC0NoEuynGbfkFYFjdByy8OwT4S/z+B5eC1d5/aJSU8FoTbBGdpThrFsRX2HCr5VAWCc6heyRHs73UDH3LvI4IpgnMSNwSWh1H2pBfrW/RmWbFLFnlOKoyVWtZck3cey2VEvqBe0k2740LAWMMaa+1J9A6sCz5LVIdTSaXtXHHvwlvZuH2AIc/vA3wyujHV8SPMn0gBW0mchc+Q4NNZ/Y5mpEMu1Ha3ZKZZXLkmE84maii5A8HqR31IzTyFHwZ2r/mAjo/xUwX0cR4UkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs5gBcV94sStFq1tWxz2SHRh8PAp+CjSFfnI1xRqZms=;
 b=CbF2fbuTQRLuAHCi5oBroYp1dii7zCWVxOI5dmAbHLLg09/ytVa36UVitHCcId8U4aMSSGBJjCbSvLflXO8eAfyws3Dq3/V/W6CFD7PbQBOI1N6EIXBIwiMd0GxDBrIURloqPRPPhVd7KzI+Zy8ZaEzfNZHh5tAtDeYNGaZNqYKLhcCeT1ufGAktwBYFkOoP5TnCs/lnC31EylrgjyDX6L//+XthomGNu1FNb5ZfylsYQmQIEVmGeL5B2zH923za7lf3lFSCdPWD9tyfOXX4zpRz2UITWvIx6A6Z/f0GSsNEd219A8UEuP/ij5l/NFnWVeBlkLAYXoB+iFWEK2q4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs5gBcV94sStFq1tWxz2SHRh8PAp+CjSFfnI1xRqZms=;
 b=UuFTet0xN+sh5vJVaJt6wJmYG8vsEV20ACrxBz8udU76JcxJJFAZrZS5GarKEhGsGsj8EUHg2Lv+zRDHB7m5VieecbxJxwJRerklI9GPUIsP756bvOkdprnK17WWc8YeW5bhljqRN9UuD58jV53jKXcXn8dUuDTPstR7sCb8CuM8iBs6L7YE/hUH/jt/LmrMhoINzduUwbPAYVXOGkwQc/RcPjsBq86rzsGyAQUR0gje9t7urtrduJEUXnwA8DSULItrZmy4E5O0SOSHDarCiX/oZz6mdw3ziTabJipeNBflfC6+eLLMCPVOJYMEjw6BOuznrVfSOA60WxcIboT37w==
Received: from DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) by GV1PR10MB8464.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1ca::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:53:46 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::ad) by DUZPR01CA0239.outlook.office365.com
 (2603:10a6:10:4b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:53:46 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:55:52 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:53:45 +0100
Message-ID: <70398f37-cd6f-4c59-9376-e2d0b4c83ad3@foss.st.com>
Date: Tue, 24 Feb 2026 17:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: stm32mp: Check secure state first
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-4-74c813fa4862@foss.st.com>
 <6c1aa9d2-d869-413f-b51d-99d7ca230b04@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <6c1aa9d2-d869-413f-b51d-99d7ca230b04@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|GV1PR10MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2b9574-7ac9-4160-78e8-08de73c54692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTUydm5GK1R4aHJOdEpyNUgwVE5NcUY0eFFVVXljL25veitDSG9OZXJOb1FZ?=
 =?utf-8?B?cFg4WGxrSXVOcWVLK2FCdENhaXQ2WFh4N21aODd3OG1XUVpPR3c3NEtrdHBT?=
 =?utf-8?B?Sm1WeVNJRkh0cE9kQmxJUy9tMzJvYk1wN00wSVo1VlVwNFVMYkpieTRQOGhX?=
 =?utf-8?B?ZXdpZGx3MGVqVlpmV28rS0EwWmJrU3RCNEwvcFQ4OE8rTlo4c3ljWlF2WGND?=
 =?utf-8?B?S1Q4blpqQkQxdHVuU2pGUXN1bzVYOG9xU1paaVZRdCsrczhsRG9ZK1d4K0dJ?=
 =?utf-8?B?L1FkZUdrR21oUzl2TWFVNW5JWWsyRWZaV3gydkhtR3crQ0RQY1N5b2xXQkcr?=
 =?utf-8?B?NXozc09JeXI3Y2xZV0hVS21ONEZ4UllTVEp5RGpmU21IbmxQNlZ4MTRhTUg1?=
 =?utf-8?B?NHFhbUdaUk5jakJKbXlUVUFhU3BObithVzl0UHQyOXFOV20vbXp2SkkydVNj?=
 =?utf-8?B?R2tUcEp3bDhWeEF6Snh5d0lBelhaNFZHMU5pSWlMRllsQ2M1NzNZbFFUZFFZ?=
 =?utf-8?B?b0dka3JERHppdlNRYU9sRlQwKzVhZEZUMHpBZS93N2pkMkRXZUVobEFqcnd4?=
 =?utf-8?B?TVJVUUhpQWFlcHR5U3hFaFlXK3ZJOGI2cVdGMk5qY1htWDRCMklwalU4M1Y1?=
 =?utf-8?B?dXJmTWpwaE1wbTJiREhmczZvQXhSZjJVRUlwWWUvd29Fc2g1Z2JvYy9wS0g0?=
 =?utf-8?B?M2MyaFNnNUZhMG44bEx6UDZvVURtT1JTckpQeFpBUjVIdE96YkdlOWYxOGl4?=
 =?utf-8?B?YnZEWDhycityNFJxU3ZzMzhYNVozYThWWXJtR1J5OTZDdGd1bWhrZWxjSWx3?=
 =?utf-8?B?VWxOQ2JzRDF4UzBZTWRZMVc3TjZrbU9PU2pXY2E2bGdIaDQrWURmWWV0amov?=
 =?utf-8?B?Rlc0ckc5bTdKVSt5YUM0RTJkazdtKzkyMjdjaTBGMDE4YndYeDdqY2hKYXRH?=
 =?utf-8?B?dEVkbFVRdjlZSDZ1cElaZ0x4WTMrQ3dyQjk0d3oxYkx1Y29XOHlibE5Ed3Vw?=
 =?utf-8?B?VWp6aWREdlJ6eXdKc1hXUHhBMmdrK2UwRUlhNGd5NGpXWFA3MUVXc1FkYkpJ?=
 =?utf-8?B?THdOMi9DcU9TVTdEWi9MZlRFWDF1MDhRcG80QzVtWUpxR0tGT0QxekU3cDh5?=
 =?utf-8?B?a043Z0RxMTUvUEt0YUhTQ3BwTmdYL3BzWGQrYzhDRlpRbnQvZHpKdE9nejFh?=
 =?utf-8?B?NmdaUnVHdVhzc1B6VUJxMDczazh1Y1BzUGxSZW5tZUNSc3U4MWI5eWJwZTNj?=
 =?utf-8?B?TnVSZStseDJ3RmpFTitHWmIxeklQWXNQdjBXWGt4eVkydy9GdEw4L1ZMQzQ1?=
 =?utf-8?B?ejJSK2Z5MkRFZ1Q3aDltR0xyNDNuMy9DeEJCc1Nab2s5NitYL3hwUlZtZC9r?=
 =?utf-8?B?akhKWTRwdXFkMlpwWDlIZnA5aC9zSFJwZ0lGZG1sZWRpNXU3WmZ1ZVE4OHdK?=
 =?utf-8?B?eFZmZnYyV3M5Sjl6d3ZzMUxLUUVCeEV3cjRLSUdCZStUL0FkaW9BSzU1VVpo?=
 =?utf-8?B?SmJaM1h5RVBJc2lCbGxrZjAzMldkUWpjanFWbWxCUm90bFN2Q0Z2c0ZvM1Aw?=
 =?utf-8?B?QVdBUDlpZ0NMMngzSDdBMGlGLzdBOEdiK3FyeWEvQU9pandnREFwc3Z2bW5T?=
 =?utf-8?B?Y2k3djlrV0RQT0htbTZkNXRiSno5RXpNZW1zRnBlTzNUSGxtNHMrd3JnUkV5?=
 =?utf-8?B?YnVXMFVlRVdnVGtBeHhxTFFRRkxVbVBWT0gybmdVejJOck1lOXFwdnpWQTBC?=
 =?utf-8?B?a0RQZDJ6cnFjUkxIQ3VOZ285akpFQ3U3VFhiZDlLNkFwOE1WM1hzenM4M1or?=
 =?utf-8?B?bHVYVWpOM1llZ0diK0ZkWHVUMDIwUmpsV0Iwd2hYUk5tbW1WS3RVZGY3ZC84?=
 =?utf-8?B?TzhDTXIwcUNqUmxzUUFoWUhKV2I3TFZGVlE1Zjk5OE5WaVl4TTgxZDJUUlhW?=
 =?utf-8?B?Y0wvZmltSDRUUll4dDF6bW0va1RPcFVBemY5eENTZkJJNmk4R2pOMTh2M2R6?=
 =?utf-8?B?bGtmNjNFU2hneW85a1pzeE4zMUR3SkE0NnlReTFQR21rZThPNnBUTWdJcEo2?=
 =?utf-8?B?MEdSeVIrNjJWOE42TkF1TFozWmpRdmV6NFU2MG9pNmxTK0VQSnlYS2Q4a2FG?=
 =?utf-8?B?WFpocnMxM3ZHeElraXhrZjVJUHIvNTRJVWdseko3bUFqbTNoWjI3Z2ZEcVFk?=
 =?utf-8?B?ZkxWODFocVJyVmF5UWR3cGpCRHBIZ09PV0RCTStVRUYwZVBqRnA2b3BuWFpo?=
 =?utf-8?B?Vit1VXJVWHh5Z1hLUEdSYlpMR1B3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtEwTgFToBztGWNLdkde7kdZjtdflXfdcS4CCwsckFGCrLSmjEEEG+sx+QBNOkI7m9VHO2IzgfIQuJvaD4DIaSBnpFcr0OxwzpIlnYAbyKoCl/sNA/yCA+2egVoPe0rG3ttpak7LKc1/d62ZO7YQCPrj/Dro04nV6UogSi6hcddklpqxHauQUwvXdCUGrYyYGY37uEvPyvIm/3kKx8gUbXkBXTPtM2LDOTTFHSPhtHi6xUhXLJsscgOPOnmV0vCr80/35OZBdeyGLw3qD/dA9kLxakK6VbL0lSeBz2N5VT1FRKKiUWlV2ng9OWfwTueclPylWDnz9uDoc7COO3Wvom175KA15K8Zq5pUBLBuFKq9spOGKkMIfaCtyg5i96nP5WWOI2bPOTTty7Z+kNQ7mpuJu16qGbGjMap2SQZf8ua3n6FlvHpgWf2kpFMNdIFC
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:53:46.1787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2b9574-7ac9-4160-78e8-08de73c54692
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8464
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



On 2/24/26 11:33, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/10/26 11:26, Patrice Chotard wrote:
>> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>
>> Secure state must be checked before handling semaphores,
>> otherwise it can cause an IAC.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> index 0ef086bb956..9db8b9efc64 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> @@ -141,6 +141,12 @@ static int rifsc_check_access(void *base, u32 id)
>>       cid_reg_value = readl(base + RIFSC_RISC_PER0_CIDCFGR(id));
>>       sem_reg_value = readl(base + RIFSC_RISC_PER0_SEMCR(id));
>>   +    /* Check security configuration */
>> +    if (sec_reg_value & BIT(reg_offset)) {
>> +        log_debug("Invalid security configuration for peripheral %d\n", id);
>> +        return -EACCES;
>> +    }
>> +
>>       /* Skip cid check if CID filtering isn't enabled */
>>       if (!(cid_reg_value & CIDCFGR_CFEN))
>>           goto skip_cid_check;
>> @@ -162,12 +168,6 @@ static int rifsc_check_access(void *base, u32 id)
>>       }
>>     skip_cid_check:
>> -    /* Check security configuration */
>> -    if (sec_reg_value & BIT(reg_offset)) {
>> -        log_debug("Invalid security configuration for peripheral %d\n", id);
>> -        return -EACCES;
>> -    }
>> -
>>       return 0;
>>   }
>>  
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 


Applied to u-boot-stm32/master

Thanks
Patrice
