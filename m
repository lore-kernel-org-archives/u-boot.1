Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D7CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 11:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EE782A9E;
	Mon, 29 Sep 2025 13:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dGekVeA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BAA83071; Mon, 29 Sep 2025 13:10:41 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8018206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSqDEwP4Cf5vnxFExex2WjhHhKnqiBXX1OYitaDnQZCEmeZcC/bNkK5E+iDPpPGP3OhESvBf4ViPfYz/gJBmNjI60PbX7vmNNv+9L8Xl7DAc9jzE3fBOAqvfzs8yD5qw6YsFOEyF5A2kENECtBnEJFK7W+m5EFYfJWVRX83Yc0/J4tyeR7ucGEuDfu3Zcm6LVvs8Evb7wy4s5f01MiJSKH22PurpqVGpEev9PlVpO/OvJgtvi8YCSuok/1Rb+egQ6jtBjzJmmIaeRMolD8zSxt8UvaToLzqtBPU933GBCxs/FZ5SwfAtFEJ40k7mtooo6abuwjGnqoXUl3bR8mEowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xnsUdHmJK36S8TDW1tTh/pyQEdn17zYXbxrCoyS/GA=;
 b=fV+igXvuEdx3sGGB4YBNRHPmJ5rmV5TrPiQqmO8I1x/XyyJjsXAhuv3lLK9axgYUY/LNv0MeSxomRj4QD5m2EGOL+qmmEHx5+7G4UeVq2JuDCDQ8qxj/X5zrSCeWuUsbG5O3QIF1cP5BTZYggTFY6dGLz9mqBcyU3Y1qlwMGIytEZfMTsrFTPahu7xSw3ExImmWzbwWC1hk4ec/g/tFd8gLE8CnmK3VYGthexJIeRjTIbD63uDg6zRfjxFeVrjRtT4nMoPRCqGss9YhumHVg//i9Xr68gApEIGOmYwqBWxiYb+InQL/f90NI8pL+BYlr8nl2eW137rlAeS25FFli3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xnsUdHmJK36S8TDW1tTh/pyQEdn17zYXbxrCoyS/GA=;
 b=dGekVeA2G1vBzIHpCajyLJRLY7LYIEqWzQimRPqkew5nWO1PqoK2GV4j/nyFnVHBppfxixoYQUxH+fOOfUzFEm5P+E51+uGWQ5ppYexcS7K2KI/SI9cI4D/hdKGlXm2nm2nYWMPy3IGe3MKpKtQhBxjvJ0ctRrS9BU0UPFZdGhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 11:10:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 11:10:32 +0000
Message-ID: <af41fd43-7d59-4493-b767-ef7275a2996d@amd.com>
Date: Mon, 29 Sep 2025 13:10:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable sntp command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 git@amd.com
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
 <1dedd6e9-16da-49b4-aeba-3b5ae478b8ac@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <1dedd6e9-16da-49b4-aeba-3b5ae478b8ac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0205.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d22aebe-5a9c-4653-7a31-08ddff48ce24
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU9qWWRLcHo0ZytXT0tIUGdUQm1SRTNPYUMxVzRpQ1BzVVkvNjNxbzdsZUh1?=
 =?utf-8?B?bE43RkxZOERSZmdSWjNnSDNPQXZyaUcrMzZXTE5aSER2Y1QvckU3QUFVNlN5?=
 =?utf-8?B?VCtOaS9kdDhyRGc0MTB1NmxrVytEQlUzalBoQy9PNTdSamxLUXd6cUMrYTJX?=
 =?utf-8?B?WHJPMFE2bVBBcTY5RUkxMTZXbldDV2N2R2J1ZUZibFl5MjNTWFVsMThudzkz?=
 =?utf-8?B?RHp6NVZQanRrb3hZMUJmTWJuQzcvMVpIdk1SMTVkUHljOXBxS1ZYN25Kak9R?=
 =?utf-8?B?bUdUQ3lOcFlvY2NHYnFPbFYwSlBWKzZreUtQK1V1ZE5tY0ZlZjNuZkVCazNW?=
 =?utf-8?B?L3R0d0ZqNDBkS3RsU09wak1hUXM2THpWN2x5eElqM0FQRXAzWGs4bE51UHdr?=
 =?utf-8?B?bmRxZkIzMmtnT2xyWHE3N1BiM0lYMjdtQis2VUM0SVRXNFB3T3lhUE9QOFdI?=
 =?utf-8?B?OWg3NzA5RDVHcVBMQTk2Z2ZRZzZwWEM1UklKa2dONnN5c1gyNElUbTNVV3di?=
 =?utf-8?B?N2ZaQXp2RmcveGRmakZLV01tVnY4UnJ0c0lsdGx6N1FKNmFHN2ZvbDEva1FF?=
 =?utf-8?B?UEZ6T0JLQUlwU2RJZWFOL2NKRC9CUG82YVJpaXhmc0hHdnVuTTZ6TTFMWEpN?=
 =?utf-8?B?Z0U0YURCWHYxUENFa29ZR0VkV3NVZHF4VDFFYlF5OUJhNk81RjdTWEpkeGlv?=
 =?utf-8?B?Y1BFNjBrc2RzbmJwRytkcVR0Z2lJRUxkS0Z1S0ovT2tIa2pNTlJHbEZZanY5?=
 =?utf-8?B?QUpwWjNiN1NweXpmeXBTbEtnU0hpMnczU2tiYWxqZVZWbUNsS3piUXdmdms2?=
 =?utf-8?B?R2ZQWEVGS255eFZ0SHRIWmtIWDNjVklWS3RnVWN0RlhRdERpVS9BRXY1QjZ1?=
 =?utf-8?B?eHV5N2VqZUI2NzFDK3NTZDlMUlljWDk4WEYrZTN5TnJJMXdQSE9JeDdwUkNU?=
 =?utf-8?B?MlhFQ2JLN2hQV2d3dVhpT0N0OEM1NVp4WmEvd0pFV2FmdGh1T3pmTFNlUUJE?=
 =?utf-8?B?alN0Ni8vMTdlK3BydEF2OXMwc1lzVmdhalBEU3krbnBiZEpuNWZ0RzdmdUlN?=
 =?utf-8?B?TVRDT2JuV3lpYzM5alM2eVpySm9odkViZUdPM3hHUVVablloUzhBcHhQRGZK?=
 =?utf-8?B?eHo2NkFHazdMaWdJTTkwRUMra2VadGcvc0ZnZWtBQzErZ2pRZ09DaXFUL1li?=
 =?utf-8?B?TTJ0K2lzVitaSVg5WkVhODdvY1dKOWNIQ2tLNlVBdWx2djJSbEc1MUdXSTNz?=
 =?utf-8?B?b0NYbHg3eFpYREErbEc1T0Vlb3I5K3gwT3dFb083dnVlaDdKM2tFZHBBTkxL?=
 =?utf-8?B?aFAvc2kyRkwrQ2ZieE5VVUN0RzJBUTZNQ1NWUzRaYmJIbTRmQXVlV0tsVWR4?=
 =?utf-8?B?eVU3MG4vcE10UDNacFVXOFAvRTRjVnczUCtYWUpjdUVmV25lR1ZEdkNRUjky?=
 =?utf-8?B?d2pUTU51MjFnR1h2ajVBb2VyV2M5UUdlR29rV0gxNlI4YkVWK2FlTVc4L0gz?=
 =?utf-8?B?RmVYckhlME1OVEpYWHc3dDFGUFVqNHZEZm9oZ2ZhZUdYWGZaZWR2OEc4ZzVx?=
 =?utf-8?B?dG82azBXaVcyRkRlWGFDalNKaHlZalQvTzZReUZZSmw5clVUVXdzWFVUQjdl?=
 =?utf-8?B?OExTb2FRTnhiWUNBNlBJTWJsUHlPTytzZWZsaFFhTk0rdWZwMHQrZjFPMXcw?=
 =?utf-8?B?QlpqSzBydG01a2Y5ZUx0WEV1UWJYTTRISUJMZW8zNFM2dnRSdnlvbkFyYm05?=
 =?utf-8?B?dFlCTG9SUTlZTDBINTU0aVE5M0lqRjRnUnhTb1RrM1M1Q3U0clloZXlsU1k1?=
 =?utf-8?B?QmNnOTBoRi8zTXJkU0lLYkFIRklPZ1ZkcW9PQjg4alpCQ04zcmhiNlBQUW5O?=
 =?utf-8?B?Z3FKWUNxcjczZVhjSjZrRDg0S3FqQWhwem1veHF4R3dRQVNKNy9lOFVuWjV6?=
 =?utf-8?Q?XwTpb1BaXIISFHgTBBGyE+cmouJXjrUw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNyVGdtNFF1TTlrUFhEaDlZWjdOYzR4cEFoTE5WVDJXQjl4UWFsZndlcy9j?=
 =?utf-8?B?WDRyZE94VUdsTXhpRHdJbFg0Ym5ZaUkyRlpJUXFremxoNWs5UUZqckVVdmt3?=
 =?utf-8?B?a3JUV3BjMHFTWEx1ZytVUk5mb0g1MDgyb2dBTm03cEJidXM0S1BtQkpuOWE2?=
 =?utf-8?B?SlR5QndFbVJXU1FrZC9RdFVMaW92WHh4K1JCNEVTVEV5R2VHaW5KZkZJd1dF?=
 =?utf-8?B?ZHQxa1pMQVcyZ2NHN3R1QkV1Qk0wRU1BSTcyVmk4VnhMRTEwQUh6bXhZUXA4?=
 =?utf-8?B?TTQwL2NFaEFNY2hTYWU0aXhNYXl2d3ZYeUZzZWNRdTVBVFRkNkRrWVN1MEEw?=
 =?utf-8?B?SFUxUUhqRXFoSm1JRVdDZU5nK2E3Y3NrQlZETXY1MUI0NVNTMXRLWjlicVFK?=
 =?utf-8?B?RjFwTjZEdmMvOEN4SHY0QnpGdWJhbWZENjJHdmh3MTltTGtQek1tUE9Mek1r?=
 =?utf-8?B?MzVKdWVCcWlQeWp2b0dXS0plY1pVMUJJWFNBSTZRbE9RNnRDUEYyVDFPRENP?=
 =?utf-8?B?VEprVWl1dEQ3dlgwOTI4RktBVGRwdUtaR3Zkc3Y0b0NBSVJaNGpjU3V6R2JO?=
 =?utf-8?B?OXJYYURmdEcvbTRLcFJUSWYya3BnWVUyZ003VTF4c3FNa0dhVHhJK0tOK0xJ?=
 =?utf-8?B?SUxoL0lJTm54MmFXa2FGZnlVbURueVhUQm05dXpxR3o2c0tUeEtDaC9Hc2tw?=
 =?utf-8?B?b05DOFdQYzZ0S205bGNFWjBSdUZ4Vm1TK0E4c01YM0NTbC9LN3BOSnZibnZL?=
 =?utf-8?B?R3MwWHFUWThqc1ZaMzUwT1MrTmV6dGlReEs5ekxqV3RFWGlqV3BvWDk4cGl4?=
 =?utf-8?B?M3FBOXFHRWp0ZjVFcE1za2lITEV6YTBPSG1JcmhqRDhZV0lXcWozOFQveERp?=
 =?utf-8?B?WUFnd1MxRE5mdTduQVp2YURMV1hmQXBvOEpnbzRnRXNqcnhaNXNmeE44dmJQ?=
 =?utf-8?B?azBjUUFkRnN4aHVYVWhPekZDcE1NQWZXSDhsWVd3cGU0Y2dlVm5hdnNzYXZ3?=
 =?utf-8?B?SWZ6dFAxcDk1NkVOdlVjL1NIWXVJdStvSUJERTZHZ3ZGME9DR0dCVU9RVWxl?=
 =?utf-8?B?VExZMjJyK3dSOEFlWTR1TmdJVk9RY1VSYVkxMWVmZ3FnTXhzOWJ0VGlLUlZo?=
 =?utf-8?B?aElLNU1NRlNJcE0xSnl5YzhzN2hOcEQrOU1Cb0lxNVo4YWM5ZXpEVTIwUldU?=
 =?utf-8?B?WjlyMHNBMXBTM0cxWmlKWEVzbGtKQ1paeHpBVlNlbFV3b2NmaGh0bE1kNGYw?=
 =?utf-8?B?bnBOZGhKcXZjMmJ0K1J0Uld5SEdDaVdTMGc1MGpSbGJadHh4OWFUQ3l1NXpv?=
 =?utf-8?B?QlFjNmpSVytqWXVGNitkSDBDVXVGZm9EM0J0VjBvbDdvQ3dicWpyNWkvcXV5?=
 =?utf-8?B?L1A4clRuSnRXV0N1T3h4ZFAzck4vKzdBaUxtd2hYSXpiSG85Qkw4VmNoNGhr?=
 =?utf-8?B?NlpOWDdxbVZKcmZCdTNMNk0xK3FOc1FLdXFwTkhlOFh6N1N2T0poU0ZkQmZw?=
 =?utf-8?B?S0I5Q1A5NjYzWVg1R21MY2JUSWo4ZFlEUitKb3YvUVZDeXMyWmgrbHZCYmNz?=
 =?utf-8?B?TGtxYTMwdXhnRU5iOGQrWGl2Nm9ZdExTamM3bzNZeUZjWmhkc2JINU45b3BV?=
 =?utf-8?B?T3U2T1FhOUxpL0ZtdWJzSmFDSkxsems0U1lEaFE0TTZMOUVnWFFEWnAxUVc3?=
 =?utf-8?B?RXlSVUx0SnI4eEY4Z2gyVWdFVmlacFNiTkk5NnJpY0w5M1ptQ1FGelM2NmUy?=
 =?utf-8?B?SlZodzRWRDBkNjJmeDc4MS93YnppTkNDZFJEZS93RlJ6am9kTWFUOTVhYkht?=
 =?utf-8?B?MXJPK0c3UmZWRSt4S2RDRmcvQ0J5ZGkzdUdyN1lDU21IbGVRSEoybGFoQmh5?=
 =?utf-8?B?WndJRHJabk9mWWFvaDJBaElUb0FQTWlKRTAvNkMvQ2xJUTdxSUVtQTRaYzlp?=
 =?utf-8?B?QTA2UTFqSldOczVkZU9rcFNKMi9tNlVuZnlwRmVmQktuY0RjalFYMzVzU0ZQ?=
 =?utf-8?B?TzQzUDhwcmQzTHBRS1MrN3BwdXdNK1BOTnkxZ0huVkdGc1liMkpQOWhkY2tt?=
 =?utf-8?B?TFRXWXJoektMRDNHZmdlZDBsZTZ0aFNYQTcyR1hzL1NpY3c0RktLSDRUNG9C?=
 =?utf-8?Q?M6E3WhgX7neuWH3hcFrrHfxYN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d22aebe-5a9c-4653-7a31-08ddff48ce24
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:10:32.0871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ParsZaH7p6NbnVDIME2lknCEj1F3JwFgqjKNYT0OML67VDSqzgSSlLE9J2nx0+ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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



On 9/29/25 10:50, Heinrich Schuchardt wrote:
> On 9/29/25 08:24, Michal Simek wrote:
>> Enable SNTP commands on all Xilinx boards.
> 
> Would it make sense to enable CONFIG_RTC_EMULATION on those boards that don't 
> have an RTC like amd_versal2_virt_defconfig? For instance FAT write uses the 
> date from the RTC.
> 
> For boards that have an RTC (emulated or not) CONFIG_CMD_DATE may be helpful.

yep - let me enable it too.

Thanks,
Michal
