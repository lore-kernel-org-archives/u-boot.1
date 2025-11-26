Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3846AD11193
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE90983AC6;
	Wed, 26 Nov 2025 20:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aTi3P4Ph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA07C83AD1; Wed, 26 Nov 2025 20:23:17 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA75983AAC
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLN4twHCpwRpeeJjIG56nV6UrkbbPgsW7MNHtAznNi1HNUYw7ZjK09x5m8APpCodiMJESIOvCwq+ODAY2i8h3wUHQ9kLqijAwYVotc6FW6caijh9ApMG7Mk/TvzBzutZX1DqJnaTzTzVyuCCgy3Bj/FwFBRDxsr9qbM/2u/STBW3xcPC6wq1fjvFI+qtNVTcKcCmXlSE5hZ8mAEAwpqabvEGll051EHe2eyvaP/dIqX1Ev4EJkpoi2JZr+aDoPKNZwJoZrBrDvOgdthyCemsyJHqwLpMMd7ykQFCxHb8FqwaqbD/npLCv2Y/9zkeD/sgYYrV4P+C785zR0VLk7LVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/Hfhd+BsHUForENx2xPricD7XCA1Fpfkg8ZZAw4VBQ=;
 b=mJRR1EUDRdj+oKf4hYWykBaWpEUgZ29FHlU1xqiFk8HvKlNrAU2XbM3kvTZe4i3H4TFkgtWqAptTYP7YuCHshiIAN4RHV43EtaL1Qb/5tUOsXLQrHP5CntLd5TwZzR8NtRiPpOvNTiM0abSHrLVg8N4Pw7lSgKGp7FiadypP/DetkLPm89Rtx17r1guFlrDaW8J8rtvRcmV3oHRkpZHGIoAUDmgB9BjS8yRF4xHbkVw+L2/i86yr1dgkNhYVw2qecQDVxsmX+o0cUD/A1uDRMYbM1e1mrqUsVUBkkp0oqcJmI9E2alYsirAxTt/Ig3E21AQj7d0ZFPmJjqe86cvPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/Hfhd+BsHUForENx2xPricD7XCA1Fpfkg8ZZAw4VBQ=;
 b=aTi3P4PhSXxZLLp03ZT0HIJtWsQJAC3PTwtZSCf1ZgC35XAm4yalN/13O2DlH8EMZpOjWozwIT/hQ/Y2eAiJJCI3vBb6Qo7wlBGxRSII3h1a55RwqrNM5TMBDRpuKAZrAjZvby3C87e0NwwgXHInXgbavhI5JRXmcFN0P8tZwZ0=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.12; Wed, 26 Nov 2025 19:23:08 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::42) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Wed,
 26 Nov 2025 19:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:23:08 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 13:23:03 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 13:23:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 13:23:03 -0600
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AQJN1wN1708108;
 Wed, 26 Nov 2025 13:23:02 -0600
Message-ID: <4c468d40-4d4c-4acf-a758-5b9b88963b90@ti.com>
Date: Thu, 27 Nov 2025 00:53:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j722s: Update SoC auto-gen data
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
References: <20251125094639.1754402-1-c-vankar@ti.com>
 <DEHU1N85F4DN.3W3VX01XHQTCH@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <DEHU1N85F4DN.3W3VX01XHQTCH@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS0PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd66f2b-dd08-4321-d4e5-08de2d213b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzN4ZG9vdisyVmJGaFhGaENkcU5Pc2V3c1l5d2JpZ2JEZndmMHNwZVUxLzZ0?=
 =?utf-8?B?V0pJQ2FvNnorWnNBcDNzV2pEWmtoSkkwRmlwaDI4OXN4VmpCaHpzeFd6WjVC?=
 =?utf-8?B?SnF0TURoY2tEZC9ZQnlCY3dwa1o0MGtiNU1IdGZWYitoanU3ODZNcmlQV1hs?=
 =?utf-8?B?VTRxTXM3UTBMM0ltbUd2VklnVDRMYjY1REJSZTNmVzRURGY2YTNEL0NUWEVJ?=
 =?utf-8?B?MWpDREpBcklOeFdUY3J3N0VFMms0YThpczhPdXdZU2ptR2hoakc1R09USlEy?=
 =?utf-8?B?SG4yanNZKzUvUXVyN1ZSemF2UG51VUh1VlRCZzdIWHNCYWI3V0t3WDYyTitY?=
 =?utf-8?B?K1BHMTNPWEloQTRaTmtKcUtEN3doRkhLSW9CUjBZdllTQml3Z3ZEckd5TmNQ?=
 =?utf-8?B?RlgySGFiclAwYk42c2pEQmpsVVBQaGJOa3pCT1V1dDl6OWwzVGR5ait4Y3J1?=
 =?utf-8?B?ZEs2M0k5NlRSL0pEUGMzb0ZHZEQ5SlJJRUpCUjJkb0MyT1NwWUN2a3BXb0NO?=
 =?utf-8?B?MDRtekNzd2hjallnckVBWUVjVFd4aUJ0b3FjbktDc0QwQ1NkNzVVeGlYQmpT?=
 =?utf-8?B?VDZPNkNQN3psQUl4M3dZMnlWZmY2RGp0OW9xeUhnV2N2NEh3cW9RajY4L1NL?=
 =?utf-8?B?ZEs2c0xyZGhhbnIzRDNaQ2dTU3JvWk9GR014MjNuV25QMGZBdnY3M2k4dWhG?=
 =?utf-8?B?YnFLZkJTWnJrc3pHS2hnbEVyMmxIbkU3S0dTOXFCUE9oOEZxUzUxMjV1MVdU?=
 =?utf-8?B?bElRR1ZaL1hXL2VRdnNvYUpKMHhGSTI0eWRkY1k5SFNsR2VvS0g4TVVoU0lv?=
 =?utf-8?B?UGpoUE84Z3VienVtRkV2WXJ0dXZ6ZUtQZ0ltSzRER09Kd1o5a2lFdGMzczln?=
 =?utf-8?B?Uy9HL1RBb2ViU0Z6ZXFoS3dFNENpbDl0V0d1aXFTRm84MHBIQSsvcHYxb2cz?=
 =?utf-8?B?a3ByNUd6c0QwRUdQRVR4dDM4cjUvUjRyR1BIRWNPWXFLcEZoTnF3VGFkWTlm?=
 =?utf-8?B?WTgwdEZSQWVjbEtNRkFOcXp6RzE3c2VHU1JUZkpGeU1hS1NRR3Z3R3BOOENJ?=
 =?utf-8?B?cXowNTZIS0pJYjZrUWtOVWdTanhodU1CaGtwYytkU3NsRUJJNzJIQmV2ZVBI?=
 =?utf-8?B?dDZzOEtUTjNRcDhJN1pOR1YvTkNQelhmUGkrNTI1MlN6c0FMb2pLN3BidmNO?=
 =?utf-8?B?eXNGUnpJOWZvdjNsRHFzOFJrMFF2Zk9LaHNJWVBKZ2IrclJaYUxyNlpQdUNx?=
 =?utf-8?B?aXJWQWN0N3FPRjNvdHgyWjZlRWpnaEJJUGVpa0UybURCdEZkR1FibU1INDZj?=
 =?utf-8?B?YUt4MHJtNk8xc3JvaWYyYXlyV2J6MTlZWEF5aWdQczZXaTJrZm0wTTBrdVFZ?=
 =?utf-8?B?b0E0TjFqNnFJb09abWhwbXdDTTRKaWYzYmNZckRnTktKZkl1TUxLTmdVajNV?=
 =?utf-8?B?TjNUcHN0L2YzUUpKaElaSHBMZVdBVWVvTXQzc3d0UFNqbnVNdTJzZXZaSHBR?=
 =?utf-8?B?SGdBNVhhTk93cVQrU3puQkJ6dFJhdWlSODVWaGp1TGI3dDdwSDU0aWtMMElB?=
 =?utf-8?B?R1RGNmVEeVVRMURoNWdSc1ZmUW1oblZUeGNKN1FOT3YyelhvTytPRHZiSGNJ?=
 =?utf-8?B?TUp5Y29Na2xtMTJXTE16MDlkUWN5b0FiODkrM2Q1TG5UbUdlaDFDcVN2MUtl?=
 =?utf-8?B?VzZobGJqd1BneDhLU0VnWnJ2bXc5NzRPM2trdzJ6NCtpdVY5cFFBTC9QMDNU?=
 =?utf-8?B?cTBCUXJCbTlMb3d1b0NEVmdkNm9lMDZoT05rcENBLzc2NmJrTUpsSDMzak1L?=
 =?utf-8?B?OThsU2lvSm9WaGgyUDVybCtrcXdtLzFDTDBydTY4a1Q1V1VmcjdyMC9hRVcw?=
 =?utf-8?B?UUFCVFBBQzJvQ1djZXdSTjlSV2ovWnNySExoYWtnQlpPcWZYSXJ0YjdZU2Jk?=
 =?utf-8?B?QyttNXlLbXZHM2I1eDZENjZNNTlHZll3eVZaZGd3SzVkUmRsRUUxTFZ2ODNK?=
 =?utf-8?B?RGl4QXhMblJVU3NRWUZFZXpMZXBXNEtidXhndHh0N1BKdTgrdzF2TEdQN2ht?=
 =?utf-8?B?cFoydE5LUUpib2IvYWNWQ1dpT2cwZnl1UEZ3dz09?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:23:08.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd66f2b-dd08-4321-d4e5-08de2d213b22
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
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

Hello Michael,

On 25/11/25 19:37, Michael Walle wrote:
> On Tue Nov 25, 2025 at 10:46 AM CET, Chintan Vankar wrote:
>> Update dev-data and clk-data to fix the eMMC boot for J722s-EVM.
> 
> Isn't there any more information? Why was it dropped in the previous
> commit?
> 

It was not dropped on purpose, I was enabling CPSW device and
unknowingly I removed device id 57.

> 
>> Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
>> Reported-by: Michael Walle <mwalle@kernel.org>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on commit "4a4871e3dc38" of origin/next branch of
>> u-boot.
> 
> This shall go into origin/master, no? The issue is present in the
> v2026.01-rcN.
> 

Ack, I will rebased onto origin/master and resend.

> That being said,
> Tested-by: Michael Walle <mwalle@kernel.org>
> 

Thank you.


Regards,
Chintan.

> Thanks,
> -michael

