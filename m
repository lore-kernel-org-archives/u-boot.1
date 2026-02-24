Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE25EF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5A683EB7;
	Tue, 24 Feb 2026 17:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HtIWoWLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D296183642; Tue, 24 Feb 2026 17:48:58 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA20083E63
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLBPk6D4n3KB+XJw5qmXYn7T6aloNxwO6wO8lQljzPzx2P0q3jKv/48kLGiwQ5LV0hBmDi5iNKAWI2Mk7P8JCZ/vbLPryX4gAZkJ49U55mNwpygCNdyQVU9r8rH6+Bh5H1YlpLCkwBgTcHuj6vZMsh5imGjFEWQnrm8VI1Tr4Bo1WNxSBwiA8o1Do9Tzz74Ba3YH70UYXmbX9BRTsjx3F0fjz/dx9Gkrn6JECO6JXgR04eY6VtGYdqfqycx9KdE2mK9z2oFUJP5r+C9sfAloeBLqjQ3Jya5z0QuJjN37vxU55fyQ5XfrNA/N4jVqtLqOqVYHvriIzMcZmdpX/KmaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcBG4j7Kr0IvfBEDX69hicGbDDH8NwR+xl8yrMtUoI8=;
 b=svslq4IpSMeqC6to7RJjSqVmpnbh1a0osrPLNkPQBvFy/Fi7q+imz3jwt5c0I0IRCMOv12qMfeUWyDOa9/QpfGkegBKxN60Btsews2fUguyynYqk8PcXwxscUmd5Oe35mH4AlgNw+p4gpJAcRACJ85zzIvrcKLMN9iIQHsRa0o+xT4jdh1D+LBHLZ02+7SWrCAYfThgp0yFi7nzlKeYbp3SCKSbjF0BziIn5wP+b7EPtwmSvRijr67dACao2x4I47svsl1fjINVUwz7iSgzLYUEeKWO9Ay8+5dMpfZ7nwJ+8Djzx4MUurgfCBhobE6dlhyqdA2IyI8sNimqHI4xKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcBG4j7Kr0IvfBEDX69hicGbDDH8NwR+xl8yrMtUoI8=;
 b=HtIWoWLgqwf+M5aRLVHcGjPmeRFvHT4b+CKCew6qMA0NdRNJYykHlwV3uogeTF+AudEDtP4LkTyZpxW4MgQYBU7j2Z6I0RYol6+n9cWQqYTTfaRKf2KO0u7PTVMVOsai3CsG4K/MZ5ThxdUU2oQbF+R8+yZfYZx04LlhfZzyJSp6+4T/jO0p8uBH5lsq2TjeFyPiFQXtYw3aY5GhkWhx9eChFikR+AgztOP1kLBAZMIzu4HyvDuSfymmq9z9nr0R7C86BXGhIJZJcBTCKv/hLWmVFDjlE/J8w9kIdxEkV2zoIh7DZxt5fq75cY2DMcASGN2qLfGSKT5kiEX3nO3Cdg==
Received: from DUZPR01CA0102.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::9) by AS1PR10MB5338.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4ae::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:48:50 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::61) by DUZPR01CA0102.outlook.office365.com
 (2603:10a6:10:4bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:48:50 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:51:06 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:48:49 +0100
Message-ID: <75cac966-0da5-4279-8d06-15306187e077@foss.st.com>
Date: Tue, 24 Feb 2026 17:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] stm32mp: cmd_stm32key: add support of ADAC public key
 hash
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-5-d95374395840@foss.st.com>
 <ac3d66d4-d077-4ae2-9923-e0ed1149eca9@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ac3d66d4-d077-4ae2-9923-e0ed1149eca9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AS1PR10MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fabc55-33b5-489f-8e15-08de73c49658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3YxeDIwdEdzQmhCd2tUZEhSVFRZeFpMci92eFB1Y2RIazNXRWhqY0tTYStO?=
 =?utf-8?B?eWpKVllRMGZXU1doY3BKUmp1U1gwVHpTRmJxMDRweiszUy9vRlJUVnV3Syti?=
 =?utf-8?B?WC9zRE1meXRodGQrd2U5RXpaWU14RlEreEszZXF5MEYwNlRzSEtQN1Y3d21Z?=
 =?utf-8?B?WnRwY3M3ZzBoS2p3Z3VaelNycTNNSXdxWFhkanNUc24rbDBkZFRFVmNtRUVM?=
 =?utf-8?B?bzFCc0k0Q3N1Qkh5dmkzeFJoYjVpTDV3VGhJUm0zMFJ6cDc1YmFmZVRqWGxM?=
 =?utf-8?B?dGlseitwNDBhdFN1cld5YU1HeHByQUNzZDFsZXJtdGt2Ym1qYmFaMzdzN2Qz?=
 =?utf-8?B?WFlWNENZSGwwd1RvZFdYYW1oRVZ5RHZoUDE1ZXhzUFNyTVd5YVZPQ01sTklB?=
 =?utf-8?B?UVJjM3ROYTZ3NWduaUI4N3FCcVR6R3VGUnhpL1pwbDdqZUgzQnI3NmZpUFc1?=
 =?utf-8?B?ZGN4dGN3L1JaNkpkanRJc2NNRXNLU29BL3RHQXdEM041bDh3TmROR3lKK1VZ?=
 =?utf-8?B?VnhpS0pvdnh1VCsvcWQ3ZEhSR2VYbzRPWFpDeDNrdndSZlU4ZXZvSWtSS09j?=
 =?utf-8?B?U0pPdDlMQXBKU2U5S21OUkJUdkZIR0c5ZjVpcnBEdmxvNUlBZElNWUdVaEln?=
 =?utf-8?B?a1R2YTZUUVJaVm8wNWFydS9WckJOY29WazlqNGpMeGJ2OTI3Q0tjOGpHMWUx?=
 =?utf-8?B?UHdJQXVuaTBQTGlDS2pYbnVzUEQ0dzBjTzNrbHhEdUJKaG9lMjdyYk1sWXln?=
 =?utf-8?B?cjByV21ka1Z2WDJGYnJEWDVjbmFBK0VuOHBhb3A5UHphRnpORHljS3lndi9L?=
 =?utf-8?B?Umw3QVp2RjBjcTlIL0hPdFluVDZGbXA0a21CNkpFR3J6ZXk4ZDlRelZXRnhy?=
 =?utf-8?B?R0prSmRBNm5GTkJqclFkQ3R1dHl1dXIxN1hBQUprcXpldUJIQUVNUUZKUlR3?=
 =?utf-8?B?N1pGa2U4VkllNGZiWERTbDdjYjJ0cEhWc2huVVVOR3QrNWxFQUJmMU5aQ2g2?=
 =?utf-8?B?aVd6Wmx2Wm1TQ3EzQ1hYWWhyeHc0Y2ZBd3BtelgxM3hMNEM5MXBDRDRYVXlO?=
 =?utf-8?B?cUNUN2FIb0FtVk41ejM0NE9wVGpRWExBNnUySFVCSS9ib3RyWGpIMHN4RTVK?=
 =?utf-8?B?c0dTRlV5NFp6TVc5MVFSeExSdndmYWw1YkJzVWI4bTU1Q29IdUxzendPZXJw?=
 =?utf-8?B?RTdWdWFDOGY5T0lzdDFLK0hSbUgxMElIUlgrd1AwYWNIcWIraWRsUGtMeTBj?=
 =?utf-8?B?ZkF0SXVsZHV3NmNWZWJjUS9CY0tnL0didEFZL2FCTzExMUd5WmxtYkhVUGFl?=
 =?utf-8?B?bXJ0QW9ScWxBeUUrNE81NFp3RUt0dDl3RlVDSHNsaDBnUlJRaWptN0swTmdX?=
 =?utf-8?B?eFA3bzRqQm5CMFRBTS9VODFrYlBjVUR2NTlxRU5xL1hvQWpJVFVKUnFSaGRG?=
 =?utf-8?B?SVI0M25BaUF0VUFJUUVHbkdwYTMyNU5DSEVYMk02d3JxaTFPdS91Vm1iMHhD?=
 =?utf-8?B?UGhEZ0loS3ZDeW9DNkVNMmw3VzVQQzJuZUFsVU5XWlVWNHErMXNWeUhoYk4v?=
 =?utf-8?B?aEt2WmN5UkNzcExHc1lhZ3E3bjNnckRocVE4MWNPSFlLZHlzNS9wYlNUakpY?=
 =?utf-8?B?TVdUSm9tbkR1TG1SR2FPSzd2R3VKeWxIbDhvdjQzcEdockFqOHFubmR4T2w0?=
 =?utf-8?B?S1I3cW5HTEgwSTE4bGJkMHRZT012S2VFamF5REo3VGkwYjNFbkNXK0Y5NTZQ?=
 =?utf-8?B?MzAvbVROdWIxcjg5cWdMSTNOTXY3NXNUZHdnWWtDZjdWSnNkVDlwVGYyMlVJ?=
 =?utf-8?B?TjF4NlZDbHk2MjFMM0Qrd0o5MS91ZjVtYVBUQUdwcWxTR3BIa3ppTnh1eHpn?=
 =?utf-8?B?NTdmQUtxbE5kUUdYN0lxY0Y3NktOb1Z3SEFyUXJNZ09vK2RmeURzWlZHUHVo?=
 =?utf-8?B?cXhJU21uTldWL2RWN2tJekhpWHQxN3ROYVYyRndmODZNS3dtRkQ1Ym5keDhR?=
 =?utf-8?B?c0kxbVVkaG9OZTk3Y2VWRDZ1VTBiSktGWUZqK0VHaGJqMnFMTXZvaUVTU1RU?=
 =?utf-8?B?ZTMxcWhHNWdEdGlCdXphYW1GazNCMnIvQ2h1MVpKOExqMlhLU0xoNTV3QUF4?=
 =?utf-8?B?NVVDeGRJeFF3ZzVGL1B4Q2dSNTBwRjBvWGJYN2JqS3Z1SWhGSjZLd2ErTTBz?=
 =?utf-8?B?Z21zbE8yY0pTQnFtN0l2dnpEV1pCMGhkRFJobzlrcnNDMjBabXplemJnOUZW?=
 =?utf-8?B?Y0k1TS9vbDJhL1VYNC96YnN2SEtnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qZBjjqZwOFFFACIUsOBNpKE7exrvzXVLOBkMpyaVNEA2xZpSo+buq3jK+ryr20tqrumggDw/kAMapcsY1uKsByLcxZt9QmDHC6GEpLJl1Um01A+wkpmoqVVQJ097FoCZJRSLYy68g6FdzX6S0zmlrVY58CSRemLLjgB1TD7PynPbJRtfy7fXoet0DWVgzPkh4Fds8T9BzsIMeeQmzsJZbwoz0Cfdh4qnY0ZNVMsDYohYWYaT9ojIBcqWIH5u73VEdNyqjHxlMLZGIZOOFjFn08bedgjK+pPktFstyFuh2k36/32JYPdchlxYgPpU93DdPcVrtyxIP9l4F/z+msS8OU7NlfPbCfmDaLhBIaNQ/JSFmNRpTZhJdUx/WIZB36xl0mgdPmwp46KyAQNcxGlgUwiQyyMxjPBjoC20uo1Mj/9Ry4qooINI/665HsHQwipW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:48:50.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fabc55-33b5-489f-8e15-08de73c49658
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5338
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



On 2/24/26 10:15, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:20, Patrice Chotard wrote:
>> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>>
>> Add support of ADAC-PKH for STM32MP21.
>>
>> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/cmd_stm32key.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
>> index d1432ba1e23..4610841f825 100644
>> --- a/arch/arm/mach-stm32mp/cmd_stm32key.c
>> +++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
>> @@ -94,6 +94,13 @@ const struct stm32key stm32mp21_list[] = {
>>           .size = 8,
>>           .key_format = format2,
>>       },
>> +    {
>> +        .name = "ADAC-ROTPKH",
>> +        .desc = "Authenticated Debug Access Control Root Of Trust Public Key Hash",
>> +        .start = 238,
>> +        .size = 8,
>> +        .key_format = format2,
>> +    },
>>       {
>>           .name = "FIP-EDMK",
>>           .desc = "Encryption/Decryption Master Key for FIP",
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/master

Thanks
Patrice
