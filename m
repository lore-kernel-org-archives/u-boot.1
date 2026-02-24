Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD813EF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5772483F14;
	Tue, 24 Feb 2026 17:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WJMA3owc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 907A983642; Tue, 24 Feb 2026 17:49:03 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE3283DEA
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmLMhr/ogVa4CAA+EpYBO+pr3HovTScerEYAw0zKPMlFTPCJD3aUyWiCo89CacFADq2+Kt3jZXtbN7N3U8Nf0zmbuKDGWzU89F2qt46C/FSPIgUj/MgHw/3gUdWs9c6Fh/TuS/kIg98SaLhSmbaavR8rr4tdOiE8ggPtTWi7KiEsYhWmns+UnuziDpzCdfYveTv4nqYcslCMDFMPH1KK7GBQ2zjYdYuRy5zlTVWz8EggiQ6j7wk2PgxLyrnR48lVddaIq/QjVn9iOmPzPHaYPpU/Afbndd2y9gzVQSBRQ41ajck/pjzyl19hyo7ahS65rZPXrhNSRv5kn7w7eFCZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvR2PBIez1okRduGI5OSqWyBSS0DME0RNkrPF7ktbUU=;
 b=Ih5d/Z1wznq7kWTYZJF6+mwfh3gA7FQmNoe9w3TGdcptTbuixRVQ35g3he1pz0Bx8pVWSURAGNuFFkpUGzxA7XZf6Sg1wKfL5ksJGBkGeoityAwYWq0lgykkiWfUIhECENJXvmdHdqmNsQwXS/kCYiE03uhbxLPGCDJZIa6tisH3twqMVaqScbz+yvky0WK5g/lNgleTy++9JUJ+Ut+gWv0NeJU7pjs8YLmBqfunPJHi19yfaqJkfsPkx/mYF87gShoMDACOym2uwbTgjET7rbeSt7ISufgxKPO1n9Q56Nm8t5t9gyNrAam8P8udS/DvCy3uArAm7eERkYyLcxAKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvR2PBIez1okRduGI5OSqWyBSS0DME0RNkrPF7ktbUU=;
 b=WJMA3owcivITywuCCV8ZpFgoiyM7g1NahNY/ZIc+0LkH1mfMfZHETj1u7XDbSbCKfO61Ft7MjQAUTOtMtsH80mdPsVrgHFfZfoCZqM49TwJ3iAgjvIhvm2cK02sX9HbgGN11u3RlBw9VedWdXRYuFmKqJXBdKI/j/vWNQ5hlSoER02BdbV4qQh6qJp2GBEQxSGRBKvTBX/jBhUzyMaddZ/H3EpP33J/LFssW02qVjJs/1UCdM51M7SGJYYEQOqhgaJKRZEfni9s18bSlWvHfLuqtN3uDVmApxHVuWFmGwLfVeq/QP6OKUVwQJFBM45GkHuik7rwk45zRF5Q+NQFf/w==
Received: from DU7PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::14) by PAVPR10MB7089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:319::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 16:48:44 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::f9) by DU7PR01CA0011.outlook.office365.com
 (2603:10a6:10:50f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:48:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:50:28 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:48:21 +0100
Message-ID: <c8fc3b00-4fc8-47a1-bbe3-924fe9d6036e@foss.st.com>
Date: Tue, 24 Feb 2026 17:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH 1/6] stm32mp: cmd_stm32key: add support of
 STM32MP21x SoC
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Gwenael Treuveur <gwenael.treuveur@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Cheick Traore <cheick.traore@foss.st.com>, "Lionel
 Debieve" <lionel.debieve@foss.st.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-1-d95374395840@foss.st.com>
 <6f9cd5cc-550b-49b3-a38e-339050447f8d@foss.st.com>
 <73c32748-8a1e-4d04-9fba-f8cca5e89ae4@foss.st.com>
Content-Language: en-US
In-Reply-To: <73c32748-8a1e-4d04-9fba-f8cca5e89ae4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PAVPR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: a86b7055-0350-42eb-e05f-08de73c492af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGVkYjlNY3lIS3J6aW9Bem5tbkh4WmV1RVNpaS9BZ25VKzBiSisrdU8veEhB?=
 =?utf-8?B?Vi85d1NSdHpDOTcvT1kxdmtJWGZDYytKci9qR2N2YnBtWlJpdis0eGN0RVZ3?=
 =?utf-8?B?Q3ZyS1RyZEdxMDNTU1RKV2dLbFBDUjNUdU1aSGpJc3dpSUEwY3pVeEFEZVNR?=
 =?utf-8?B?MjNNaHQyaTVQNG1Td0p0R3I5RjFWWEFBTXlCYkdDVHBDQ2tMS3VDVkNINEgy?=
 =?utf-8?B?NHRYZFIrWUpCZ2J3NXArejM5VG1EdEU3NzJGUjdYRllERHp5aXVZMU1aajM2?=
 =?utf-8?B?a0c0eXNpMjJQaW1rYk0vU2tCREVBbTM5WVVVQkZBTGtnYkxTNlh2bWpjRXgv?=
 =?utf-8?B?MVg3bWhORkY2SUp6R0xGeE4vMlpqRXJvQXdXcGxmY1RPWHdFYmFnajczUHhD?=
 =?utf-8?B?VlRrcUdrSVJsMzRHRFB0S0xmd0JOT2NrV0FvclJXaFduSE5yeFNIM1I0Q2RF?=
 =?utf-8?B?Wk5rUHFFYjF2RUY5OThCQ2xZOGZJMFR5bFBqa0svMHQ5V1VVZ1AwN2tkRWlo?=
 =?utf-8?B?emJ6STdzRW9mdE1leHRUL2wzRmkreWF1c1phSWk0a29VaVFyUlB4TmVjVXph?=
 =?utf-8?B?RVRQcUpva2I2QVVzUWRDRkg2STNHY0c1NWN4Zzl3WnlxSnJ0Yjk1ZHAwc2Yv?=
 =?utf-8?B?MFpsbXBkWmZBMEVRVmhCZUJFOU0xb20rSFNieGtTWk91M2xScTFCQVRKcGZY?=
 =?utf-8?B?VThTb01naUdiYmZTcWdGZXVXcmVJSE1Ycm5ZSjdqR1RqVFRoT0lmZzhzL2xt?=
 =?utf-8?B?Z01yeDdkTkZORUhpS1NCcTRhWDNvSHcxeDQyVVdxNXpUM2poWWM2NHJmS09j?=
 =?utf-8?B?ZVkvVGVRajVoSnRrVU4vclJpRENaemtPTVhOU2xWOGFOT2RYdWZIRThTcHli?=
 =?utf-8?B?a1NHUjRMNjVqbVZHNTY3eE5YVmJaNVBzbDJLZjdPa3ZOb1NGV1V3eHN1TlJV?=
 =?utf-8?B?RHJocDRycE1NUW5RRjZ4SUhmUXJXNDJCQTZHbmQxaWJ3MjdQUUVOVjhhZ2N1?=
 =?utf-8?B?TUh5OGYwMVlhUnc0WnV5Nldick9VcktTZlBaZjhFM1lEQUFmYmUyUUcwRDFC?=
 =?utf-8?B?bUlhZk5NUlhEVHdYK1dDLzJTK3ExZGowYTRXbk8vUkp0NU1mbjRvb0xGUmxE?=
 =?utf-8?B?UTU4SFZCQXFQY0xBRHJCMnFmVVZMZDU0RGlrUktiZkpMdndlbGpOV2VSOUI1?=
 =?utf-8?B?RmxSd1V6ZXFYRytPR29hZXZRUEpKcm96RHBmZmVycStuK0oxaDBOZG1VN0ly?=
 =?utf-8?B?eUkxc2dtVHgzOXhnVkpyOUsyUGFybllSRFBjM2g3RXFhazZ2bjRFQjc3NjRq?=
 =?utf-8?B?dTk3TDd5dmcyR29iN2xNTUtKVGNFZm1HK1drUVFYOXJxSzNKZ2ZWSDJoQ3BF?=
 =?utf-8?B?emlMT3d6TVp0bHlYU0QySEtVQjZGV1BDZEY5TUxiZ3I0VkZoMmVERndJQWhM?=
 =?utf-8?B?S3hjMy9HVWtZQmZiUi9TV3FvejJ4V2F0ZXBUdXRKN3d4RjRLM0NxRGpkeGhj?=
 =?utf-8?B?S0xpWUdZdzhUT1lla1h1cXN4WXlybG9oekpPRlBoSkF6cHB5ZjRXMVdsQmJL?=
 =?utf-8?B?MmZOdVBaUDlseXRtWnM5YUZYMlhqd0pTSkVNR0YvSktYSzkxa3Vvd2txUmdk?=
 =?utf-8?B?cUsvdGNCdW5rc1ZnVHRXbkVtaWxiSkFKV3VzWDVOdzVHeWtvVHptZFFJUkJ2?=
 =?utf-8?B?eC9BM1ltSGRWUHk3dS9SWHorUFdia0dvc1lSOGdST3RUSVhFOTZOZStWZ0tm?=
 =?utf-8?B?Qmdza2wrNkFmYmdicDdwRzFEYmdEUXIveVFucGt5RUcvdVk4bHdCMXJWa2NC?=
 =?utf-8?B?VVpXZnkzTWc5b0t3dWFNY0hUZGVkZW5oNmhoZVJwdEc4TmNQSlFENENKVThk?=
 =?utf-8?B?ZHVQSkg5RTJvQUg3dFZXL3ZjTmZJaUNQNzBaR05VejJ0QUFPWWI1ZS9NRHlC?=
 =?utf-8?B?cDFvWjRFRng0cWd5NHh6eE5JZHVnK2pIR1hBT3E0NWpBRjVsSmF1VE1PVlBw?=
 =?utf-8?B?MTZkRVhvb01KOW9GeS9zM1A2MS9iYW4rMmlKRWRNUE42UElSTjN5dVBJYmc4?=
 =?utf-8?B?bi9MZWpBYjJJdTMxbWFjcXVsSEx2L28vcVpBcGpSZW9WY1l0RkpndUxsRVNC?=
 =?utf-8?B?OFVROEl6UU94WXMvNkpxM2pvd0t4WCt5U3E5RUFOZEprcVYzYllaV3AzN2lk?=
 =?utf-8?Q?dRjAPh4FE576YMsSu48Jiy4=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9YfVSYNSVuvrCdmXqNUIMkf7d18GDe+zt8GwRwgwyKmj0OfBR2UVbHKQ93OJ52wBW4MGj6NTidF7zb0/LV5JpNsekwN9HgCQQ9RcFssnDo1tlWA2zvdBBTvD2meBH/x7vgge30CnXsWExa8pw68AsRU3j+Gse851e7DFxySU3WICz2IaWLTp33K0RZMaPSgDWc1dlQbXcIwbnEjHaA60PFRvpy5rWMjyWCIGoOPVURFC4D19w2SG+6Aq5MU0U3lX6DOC/pRxgd7l0HHESCiE95Pc6zFgxze2EKo0lcE97agUyLonh7iu2jsrGODXndyoS1L6rsb3qGCjZ5pBlDcTZTo7iOZua860pEDjI8ilAIyvtQwKWQsvmq7sY8v9Cqe9G8lKfe4Q3T0NPKHzEhcYglgomeyq2l16obyomM4VE3JXVEqctDFUQDEbNpp9vWGE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:48:44.3786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86b7055-0350-42eb-e05f-08de73c492af
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7089
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



On 2/24/26 14:00, Patrice CHOTARD wrote:
> 
> 
> On 2/24/26 10:03, Patrick DELAUNAY wrote:
>> Hi,
>>
>> On 2/4/26 11:20, Patrice Chotard wrote:
>>> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>>>
>>> Update stm32key to support stm32mp21 OTP mapping.
>>> Create a new list of key to support the following differences :
>>>    - STM32MP21x SoC support 128b and 25b FSBL encryption keys.
>>>    - OEM-KEY1 and OEM-KEY2 used for authentication are in different OTP
>>>      from MP25 and MP23.
>> minor "from STM32MP25 and STM32MP23"
> 
> Ok, i will update it when merging this patch
> 
>>>
>>> stm32key is compatible with platform STM32MP2 (aarch64)
>>> Hence, use unsigned long to handle argument addr of function
>>> read_key_value() instead of u32.
>>>
>>> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>   arch/arm/mach-stm32mp/cmd_stm32key.c | 97 ++++++++++++++++++++++++++++++++----
>>>   1 file changed, 88 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
>>> index f1e0a3e817c..1ceb640e6b2 100644
>>> --- a/arch/arm/mach-stm32mp/cmd_stm32key.c
>>> +++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
>>> @@ -40,7 +40,7 @@ struct stm32key {
>>>       char *desc;
>>>       u16 start;
>>>       u8 size;
>>> -    int (*post_process)(struct udevice *dev);
>>> +    int (*post_process)(struct udevice *dev, const struct stm32key *key);
>>>   };
>>>     const struct stm32key stm32mp13_list[] = {
>>> @@ -67,7 +67,56 @@ const struct stm32key stm32mp15_list[] = {
>>>       }
>>>   };
>>>   -static int post_process_oem_key2(struct udevice *dev);
>>> +static int post_process_oem_key2(struct udevice *dev, const struct stm32key *key);
>>> +static int post_process_edmk_128b(struct udevice *dev, const struct stm32key *key);
>>> +
>>> +const struct stm32key stm32mp21_list[] = {
>>> +    [STM32KEY_PKH] = {
>>> +        .name = "OEM-KEY1",
>>> +        .desc = "Hash of the 8 ECC Public Keys Hashes Table (ECDSA is the authentication algorithm) for FSBLA or M",
>>> +        .start = 152,
>>> +        .size = 8,
>>> +    },
>>> +    {
>>> +        .name = "OEM-KEY2",
>>> +        .desc = "Hash of the 8 ECC Public Keys Hashes Table (ECDSA is the authentication algorithm) for FSBLM",
>>> +        .start = 160,
>>> +        .size = 8,
>>> +        .post_process = post_process_oem_key2,
>>> +    },
>>> +    {
>>> +        .name = "FIP-EDMK",
>>> +        .desc = "Encryption/Decryption Master Key for FIP",
>>> +        .start = 260,
>>> +        .size = 8,
>>> +    },
>>> +    {
>>> +        .name = "EDMK1-128b",
>>> +        .desc = "Encryption/Decryption Master 128b Key for FSBLA or M",
>>> +        .start = 356,
>>> +        .size = 4,
>>> +        .post_process = post_process_edmk_128b,
>>> +    },
>>> +    {
>>> +        .name = "EDMK1-256b",
>>> +        .desc = "Encryption/Decryption Master 256b Key for FSBLA or M",
>>> +        .start = 356,
>>> +        .size = 8,
>>> +    },
>>> +    {
>>> +        .name = "EDMK2-128b",
>>> +        .desc = "Encryption/Decryption Master 128b Key for FSBLM",
>>> +        .start = 348,
>>> +        .size = 4,
>>> +        .post_process = post_process_edmk_128b,
>>> +    },
>>> +    {
>>> +        .name = "EDMK2-256b",
>>> +        .desc = "Encryption/Decryption Master 256b Key for FSBLM",
>>> +        .start = 348,
>>> +        .size = 8,
>>> +    },
>>> +};
>>>     const struct stm32key stm32mp2x_list[] = {
>>>       [STM32KEY_PKH] = {
>>> @@ -171,8 +220,10 @@ static u8 get_key_nb(void)
>>>       if (IS_ENABLED(CONFIG_STM32MP15X))
>>>           return ARRAY_SIZE(stm32mp15_list);
>>>   -    if (IS_ENABLED(CONFIG_STM32MP21X) || IS_ENABLED(CONFIG_STM32MP23X) ||
>>> -        IS_ENABLED(CONFIG_STM32MP25X))
>>> +    if (IS_ENABLED(CONFIG_STM32MP21X))
>>> +        return ARRAY_SIZE(stm32mp21_list);
>>> +
>>> +    if (IS_ENABLED(CONFIG_STM32MP23X) || IS_ENABLED(CONFIG_STM32MP25X))
>>>           return ARRAY_SIZE(stm32mp2x_list);
>>>   }
>>>   @@ -184,8 +235,10 @@ static const struct stm32key *get_key(u8 index)
>>>       if (IS_ENABLED(CONFIG_STM32MP15X))
>>>           return &stm32mp15_list[index];
>>>   -    if (IS_ENABLED(CONFIG_STM32MP21X) || IS_ENABLED(CONFIG_STM32MP23X) ||
>>> -        IS_ENABLED(CONFIG_STM32MP25X))
>>> +    if (IS_ENABLED(CONFIG_STM32MP21X))
>>> +        return &stm32mp21_list[index];
>>> +
>>> +    if (IS_ENABLED(CONFIG_STM32MP23X) || IS_ENABLED(CONFIG_STM32MP25X))
>>>           return &stm32mp2x_list[index];
>>>   }
>>>   @@ -237,7 +290,8 @@ static void read_key_value(const struct stm32key *key, unsigned long addr)
>>>       }
>>>   }
>>>   -static int read_key_otp(struct udevice *dev, const struct stm32key *key, bool print, bool *locked)
>>> +static int read_key_otp(struct udevice *dev, const struct stm32key *key,
>>> +            bool print, bool *locked)
>>
>> minor: needed change ?
> 
> From what i remember, it was a warning about the length of this line.
> 
> Thanks
> 
> 
>>
>>
>>>   {
>>>       int i, word, ret;
>>>       int nb_invalid = 0, nb_zero = 0, nb_lock = 0, nb_lock_err = 0;
>>> @@ -351,7 +405,7 @@ static int write_close_status(struct udevice *dev)
>>>       return 0;
>>>   }
>>>   -static int post_process_oem_key2(struct udevice *dev)
>>> +static int post_process_oem_key2(struct udevice *dev, const struct stm32key *key)
>>>   {
>>>       int ret;
>>>       u32 val;
>>> @@ -372,6 +426,31 @@ static int post_process_oem_key2(struct udevice *dev)
>>>       return 0;
>>>   }
>>>   +static int post_process_edmk_128b(struct udevice *dev, const struct stm32key *key)
>>> +{
>>> +    int ret, word, start_otp;
>>> +    u32 val;
>>> +
>>> +    start_otp = key->start + key->size;
>>> +
>>> +    /* On MP21, when using a 128bit key, program 0xffffffff and lock the unused OTPs. */
>>> +    for (word = start_otp; word < (start_otp + 4); word++) {
>>> +        val = GENMASK(31, 0);
>>> +        ret = misc_write(dev, STM32_BSEC_OTP(word), &val, 4);
>>> +        if (ret != 4)
>>> +            log_warning("Fuse %s OTP padding %i failed, continue\n", key->name, word);
>>> +
>>> +        val = BSEC_LOCK_PERM;
>>> +        ret = misc_write(dev, STM32_BSEC_LOCK(word), &val, 4);
>>> +        if (ret != 4) {
>>> +            log_err("Failed to lock unused OTP : %d\n", word);
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int fuse_key_value(struct udevice *dev, const struct stm32key *key, unsigned long addr,
>>>                 bool print)
>>>   {
>>> @@ -550,7 +629,7 @@ static int do_stm32key_fuse(struct cmd_tbl *cmdtp, int flag, int argc, char *con
>>>           return CMD_RET_FAILURE;
>>>         if (key->post_process) {
>>> -        if (key->post_process(dev)) {
>>> +        if (key->post_process(dev, key)) {
>>>               printf("Error: %s for post process\n", key->name);
>>>               return CMD_RET_FAILURE;
>>>           }
>>>
>>
>> even with 2 minor remarks
>>
>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> Thanks
>> Patrick
>>
>>

With commit fixed
Applied to u-boot-stm32/master

Thanks
Patrice

> 
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

