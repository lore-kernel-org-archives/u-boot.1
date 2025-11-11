Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E473CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40F383AB4;
	Tue, 11 Nov 2025 06:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kTE9YrMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E033E83AEE; Tue, 11 Nov 2025 06:53:58 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B904D83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TantUXsFvl/blYiySOuDW2Z3Ptq85Vt4nlw8mJG88AxQ4NI/ify6f7E5Kke8x7EOYpJdCTGrUHlPD3GSO9CzCzBgruhUcvK0LuWPVvG52cmVdKcKfKJx0lD1m/9/5UGeG/SOX4utahiHaBGlz2TJ/jQvCS8MGOEQJfInwHgtrXF/Cbz3GG7cK6mYwxZ1Ktia3+72zk4O8Lrd2kpYdvDItGW7+3ldp4/zXVGUpupNkF533cvQJGnPvdJDEMn0r1ZE50wD7FD1ntYKOp5zBUrZFmCOAwLi4i1X0NtgtIS2nGfVdeI1seRaqP0HkBeuRpja6NBb8xBFjQ0qzgRKjsVjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBypzpBMup1TxSncpw47obl6HMjn2TukaStnSb7nV6Q=;
 b=ycmBELhWLGSC/35GP7QXYJWj2B48MVfx/Mvix7syJOiqtALHNIxnYjqlGwKXWRdl33AR89gj2Z1BzOhOs3Bw/zP8VZh2bYz/JRF3DdV2eWE0Xj829J9Od+5o4hHoR91A1i0q7QfnDnzGV5Rq0afVvNOzsk7LGsEcFWHsF7RqigGxZnWsZ3tDDt2ty9Tpt6+DI90pGSLtp1yJ9fsGNGY0QIFCyNH0dhDbOKZk2xl/R4AY/uMhmJxjNVsy3WWTA1A7Iw+TJApE5BW9xr9TAr47Ce0FHHCxoTjosumuMTlo7CwnR/jGh/HsZR8dEe/qngQWUujHZEuhL/39w17kVYNLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBypzpBMup1TxSncpw47obl6HMjn2TukaStnSb7nV6Q=;
 b=kTE9YrMvdIh3zkBDvHa+beLD7hEsFrSiZDLD8EmYU1ZnSYQQAnx2Obrc6RQhunDWucLsTPRQsP0SoW++OxhkPSAAiI2apec7ImS1DAQuMuE6UrWj4dEuZY3xWMqD7egVFNyC/yoexNEyXIi32xmWZw+LEfiBBJnIZeJ99MFXT8s=
Received: from SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::16)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:53:53 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::c2) by SA1P222CA0173.outlook.office365.com
 (2603:10b6:806:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 05:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 05:53:52 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:53:48 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:53:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 23:53:47 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB5rgr1412751;
 Mon, 10 Nov 2025 23:53:43 -0600
Message-ID: <6665b274-3a23-4b11-82e2-2f2f92ed8d61@ti.com>
Date: Tue, 11 Nov 2025 11:23:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm: mach-k3: j784s4: Update SoC autogen data to
 enable PCIe boot
To: Tom Rini <trini@konsulko.com>
CC: <a-nandan@ti.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <ahalaney@redhat.com>, <u-boot@lists.denx.de>,
 <danishanwar@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
 <20251110094144.886956-2-h-salunke@ti.com>
 <20251110174744.GM6688@bill-the-cat>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20251110174744.GM6688@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fb4b64-c83d-4f07-a669-08de20e6b192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGMvUkc2UTJ0MFJnWTZaUFQvMGxyRHAzS1JBVWgzQkMraTJBWGVBQStGS2gy?=
 =?utf-8?B?YURmZk5BRllMa0pYc01uT0NGaU5GYysyME1hWC9YaG9wVHJEY2tqZENqMXVw?=
 =?utf-8?B?c0x3dDZxSTYvSVlUeTA4MTgyUzBBQXdyS0pLK1U2T3VqYTVvU3ZjeHVodGVq?=
 =?utf-8?B?MDNkK21aN2h6ZkxNUmd4U3JHMHkzSkJiUUY1ekpPZFJPclJKWks2bW54MWRY?=
 =?utf-8?B?TFNrd2J4V0dCWkt1MG1SWHhkSkJHSXBGY2hWeDV0ZnFUaktOTk0rcHJ1WnUv?=
 =?utf-8?B?R25sWFlZRDUvOGtKNVpyNzZXWmVicmc5WExncWlvWDIrSnZjS0RGeDB3dDhi?=
 =?utf-8?B?WEdySzEzZHhweUtENmxmVDQ3aFc4RE9mRFhqZ0draGdIYnBMWmZENHVYNWVM?=
 =?utf-8?B?SXRadDgyMi9aK3RveDA4c29PcGlGNTVCd3ptZWhVQitFYU5xZGxXN2c3ZHhM?=
 =?utf-8?B?akkrZUZtR1l4YkVIOXNUS1RsMjF5b2REUFN1Y243T1BXNjZxZ2F3Nkc0Sndn?=
 =?utf-8?B?MjZwNzBWcGMxUWF6ZXVlNkRrR0ozVkVhbHBudFdKeFhXbnR3cXl2eUNvVzlv?=
 =?utf-8?B?SFduayt6dnQxWmxIdU1RUmxSWEdrMmNPTHMwNWdVa2VCYXVVbmE2L3VzQTh3?=
 =?utf-8?B?VVdkZ2FhQ1g1V1FEdHpreU03SElodG4zWE02SGxpa29DWkR3bGMvbXgwUEZo?=
 =?utf-8?B?dmtwaDBIcVpmcm5vblVYK3Q1MlY4S2JMYmlEbENIeU9KWW5Td0VVZnpmQ3o5?=
 =?utf-8?B?ODhsL09STnVzNmpqUnNQYWE1WVZ5eElhMTE2RkFvTWJwSjBwcGVzTjljbnpz?=
 =?utf-8?B?Q0tYaGd3eU8reEZ2eTVKUTNsTEYvbVpDTTQ1bUZwNThLVndOTWJhaXhYWWEz?=
 =?utf-8?B?eG5ZQ2diN0Njc2grZUliR0tuRE9KRHd2bUFSYStrSGN0eEM0VjIxZmtvWXVW?=
 =?utf-8?B?UzR2Q1NCc2FwVGk5Y0NDYndCSXQvTWU3bE9vWHd0bzBkRStmalFISmY1eTFI?=
 =?utf-8?B?U1FhMTZCZnpoQTdhK1JnRy9vVnFFa2tObkl1TGg4Yjk2YThnVHd5ZXZZemFZ?=
 =?utf-8?B?TmM4dGxEUnRzSGJ5UEFqaCswcXRBN25PVElvR2g5UFpmWmVQM2wzMWFPeTMv?=
 =?utf-8?B?TTdHWjVrUFBrVUF4TTlNTUJXZlprNmxEd3RuZDdlQm5wbzVSYUNvd0RxTDBp?=
 =?utf-8?B?OGdhZUFWcnBKc1hnNng3NjJwdTNZanFIUnZBTEk0MVJiMmliQVNFNlhzNXo2?=
 =?utf-8?B?bEpzU1cvSlVQY2dGYUc0b0FUYWpFMUF0aytNUlFCeG1TQnAwOGVIVEpyT0Ja?=
 =?utf-8?B?Vms2czYzcUtnRzJhZ0hBWXY0Z2RkZmlubFFtMmJuVmtyU2pQTTVUL0JGT3l2?=
 =?utf-8?B?OEZWSFNlbkl4VDNMak8xVlk2VU9MeG9VTVNleW8wUUZUcW4wSFlmcG1OMms4?=
 =?utf-8?B?NG9DOVdHZzVhbEk3b2dSSythKzl3eHJJaWNmUzJKQmluT1VuZnFLcXVsWnhW?=
 =?utf-8?B?cjllOVdSV1ZudmUyaitOOFFFTkxsRk55aS93TWE0emlKLzAzK2VVdWFzZW9T?=
 =?utf-8?B?aVJyVGpYdmE0NXRlcWpvemxTZEoxMm1QSEhTRDRwMzcvU1JIM3RST0czcG1R?=
 =?utf-8?B?alJ0aDgwTnVLRW1XMy9Qa1hKd2ZndERnV0xrWHA1V0VodXF4YkFDcHNLWWEy?=
 =?utf-8?B?K25BSzVhais4cE41RWtNa0RMa1NQNjkzK2huTkdPTnJFTDJKWGpsTE5RMytY?=
 =?utf-8?B?amNrUVB0OC9PMHFheDNRLzU5MzRzWmhzSGxqSWF6VzRUQ2t4c1VzS3lZanRj?=
 =?utf-8?B?L1lJdFZHU0tUNWI4VzNmV2kzUnhmWmFZdW8xL3UvdC8xU2sxOHdzQ0w0ZzFY?=
 =?utf-8?B?bVVqNmJ1VkpLZnB4TENZVXJreGtldFBXaHhZWXl0Yy8rNStPaklOK3Jza1E1?=
 =?utf-8?B?TW81c0xxRDloRDJRYzBRK2RJMXByZVNTVk9tOUJ2UmhFTFhBOTkyTys3OElP?=
 =?utf-8?B?T21jVTdWLzN3clJlcUJTZzkraG1zSnVLT2NOUUNaSW5RZkpwZnhzMmUyb05X?=
 =?utf-8?B?WGluNXZxNVhGRzZCU1pBN1A1Uk8zVzZmVTZ0Q0xWbCtSN2kvTkwrWWFCQWFo?=
 =?utf-8?Q?3svQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:53:52.6509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fb4b64-c83d-4f07-a669-08de20e6b192
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
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



On 10/11/25 23:17, Tom Rini wrote:
> On Mon, Nov 10, 2025 at 03:11:40PM +0530, Hrushikesh Salunke wrote:
> 
>> To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
>> and configured at r5 stage. Add the required clk-data and dev-data
>> for SERDES0 and PCIE1.
>>
>> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
>> ---
>>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 211 ++++++++++++++++++++++++--
>>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 +++---
>>   2 files changed, 227 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
>> index 24780eb6562..7ea67ce38f5 100644
>> --- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
>> +++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
>> @@ -1,11 +1,11 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> This is wrong, "GPL-2.0-or-later" is the newer SPDX tag. Please go fix
> the tooling if needed, thanks.
> 


Thanks for the feedback, I will address your comments in v2.

Regards,
Hrushikesh.
