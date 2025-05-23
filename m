Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D542DC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD63832D8;
	Fri, 23 May 2025 17:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="geZY1H6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7993183311; Fri, 23 May 2025 17:06:40 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D52FE83264
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 17:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTJJnYfM6yWJ4+UwM9CUAoh/URsfxk0WcxgYNO8FdFLXJkaA74GF+UbRVjeyn/T/e4Dmk3s6YV741B3ccB2OzxC4TAtRpGJHRFbl60gqAZYCQDM/KWf+BZevYaKZnfHUKUiJCglqbdvvVEx2xFoUuIB1IX19viYObPlmOVaje6N0FRfJibY3d7XXDhwUIF1wHu/pygS+D8HKrtovD1x4SokaQ0HSBjpG2HzvxedQcCdDIgr7xOavgp8tc6wYJy9DXxV1RsGzJh/Ql5PvbYoy35nnya2GfWHo7Phmg1oR/wLoJ9gHvKaHva9vReOMuuBu92MArt2/P7TCYEoEgpTU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+3zdzLP4KB1RmguzrmPmgrYBF9WRI7lgorCbjExdmM=;
 b=I+TH6Y3klUnxzVfPwEUFYKrwB14L0CNGSqGcYWljoyzESCndeg3xWUs85rXMwgOEpKoCGY8Yb9wenDasRpXu0YZnvLXgJmiMfR/pvnFKOV/gm+wiKCblerf7ScFF97504lNpMKL0G4f0kVqBnr8bwrWLFL+NjVaaPS830aaf9MebyB/h8fJv9iZP2Pv+rDSvZtNcbaeVcF5yFCoOI0ocTf4Ng5CyuR4c63omZ1q2xG8QAgaFQywMNv1AkkKLoteugdooGVM9rIjwJAqLXxMtHlE2AvH1EH+QzMcLeHfZO+2fa+SBD1ZmXMF2kj+26vR82FY7QCy6YuNiB0IfiyZdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+3zdzLP4KB1RmguzrmPmgrYBF9WRI7lgorCbjExdmM=;
 b=geZY1H6uHdziEcYplXx/KERzQg0BKlptaJ4KBAS5JQMOMcedrFdu29lzVo8UsOMVcX/6K+4uDCq1mOm47t6ZP0PWJZLfwYxgzRgTND3V5IImq1uYYkuOoSmzKG7deYZ6RMGJfXC0HApJ4kRUhE3lQBqeeY+yqJP3w0vP8EeZDnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 15:06:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 15:06:34 +0000
Message-ID: <5e418e24-edb9-4eb0-8261-ffc87c99c3b9@amd.com>
Date: Fri, 23 May 2025 17:06:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Run dhcp if an http boot option is selected
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20250523130404.2646298-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250523130404.2646298-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa201af-a6b6-4691-ef5e-08dd9a0b67f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVdjdGk2aFRCcFdJL2V0bnJrcGtGOS9aMXJlNU1telBINS9vaDFWQjBWMTBR?=
 =?utf-8?B?b0UrOVRvU1lLNWlXemhkK2NhaThPTkMxNnloTVc2RUhaS01NMng3aFFGb0lG?=
 =?utf-8?B?THRoQkdtT2lvSDVuN2pNWXZadzVFOEVoMCsrQldBUW5JTVZVRzlwVTRVSm5L?=
 =?utf-8?B?dWhYamVKcUhzVlo5dUJMQWF5Tzk3eWRpMnFtNkN4eUZIczhuQ0R3WUV4dStQ?=
 =?utf-8?B?U0lYVFpMaGkzL3c1aFdBNFZ3VTFSWndJRTlyeHJEb1luY0JBOC9oLytad2N2?=
 =?utf-8?B?Q2FjMzR2UTRTOTBVdTRBWkZQOHk3a2Q2MHVpc2xEeGtrSmhQSWlNMDNmTmo2?=
 =?utf-8?B?cGlFYUM3ZFZvK09TMFpqQ1FmaTB0QU1XU2ZXM2tZckZrN1hHYUtxR2hTdXRa?=
 =?utf-8?B?YkR6VEVGVG9vNHdUQWpSbW92bm9JUkJDQXhqRWVocnh4czdmM3FsNTl6MXdk?=
 =?utf-8?B?N2dYMERVQ3NNK3RMVzhNaHgzY2Z6eGpKSTZkWDlMTE4zNXFlMnkrN0QvRXJk?=
 =?utf-8?B?NkNRTnhDNnBDYWRtZ0Y2ZEk0ZGQ0cnFTcXV1WG1oVG1ETWZMbW1DcG9JbStz?=
 =?utf-8?B?Q25kSGtoSlQxS3hVU3JVZVVOd1JISEgvMGlvUnRKRENEY2cybmExQVEweVl6?=
 =?utf-8?B?MXRZbERLUUZBRzg1a091VjRHMnUwN08zeUs5VTNDQ0U3Sm82aWcwdDE2QWcx?=
 =?utf-8?B?Y0VoSHFGU3Zoc1REZkN6NldYc1ZXU0w5eEZScDgybUtGWmJLZnFPczVrc05l?=
 =?utf-8?B?QUxjekhNMXp0bnU5aDhlSmNIQkVielpxVnlCOXd6V2lpTGZIdXhudjVLRzdv?=
 =?utf-8?B?OEdmYVI0WGYvcGxaandiVnpkblhiZ0t0M24xSDczMkNxMlIvZVc0dFY5UDM2?=
 =?utf-8?B?bDM4OVlMRkdIR0pjZW1Rclp5dk9Ja3Y1Ujc2MGcrU3ZOT3YxNExEUmlUbCtk?=
 =?utf-8?B?NkV3QjQ5bW1pUUlZQVRqSW02VXJIaDY4clg5OXc2VTVFbG45TEJDZnJIMmhh?=
 =?utf-8?B?SXhmTXZFdjhHMVNMVXBiQjhjcWl6dUpwTjdqb2RhdGRRYmUxRHdHTFNFaXpY?=
 =?utf-8?B?OEVVZGt3NjFybWU1RzRSREQ3RkJNeHNDT21YWlByMUs1SVBIZ01UczJjamJT?=
 =?utf-8?B?WTZ4SUNQNnBDWFB6UExKODczUzlqOFM3WEFGb1lEa04xeDhHdkViNWNXbWFU?=
 =?utf-8?B?WW1rd1luSk9oeXpDTGxlSzJZeGRLK0ZxWDgxR3pHdWpOVjZHWDhSZ0NTMi9S?=
 =?utf-8?B?eUVwYkIyMnNaNkR4VjlyNTlSSmt3YlU2QTFmR2xnWFpxVVhuNlkrbGpabmh3?=
 =?utf-8?B?K3VEdmo4N01SVWwwdUZTbEIvNFFiOWNTMnF4OVRqb3MwaVpzaHRiNU9LVTRj?=
 =?utf-8?B?TTdTUXRLbkwrQlVnT09RS2s1T2hsRy96YWRFTVFoeXlBVXNjL25ZQ1I0NkFp?=
 =?utf-8?B?UGVqcGdJd0M5ejZmbm9YbEFRVkY1cmNpcWpXL2sreE0zc3FLWDJBNlFrSjhv?=
 =?utf-8?B?c3JWS0FnbG1aandKcFRsWERCYWNEVFVTN1N4ajBoSGNvSjAvS0pIeVptM2U0?=
 =?utf-8?B?WmR3Sk4rdDhkVnBFNjNhdW1tRHBsOGRXMUtZRVVpK2FXZ0Y5MDIzK3pCZEg2?=
 =?utf-8?B?cllOMDQ2WmlBalZ6dmFQTEV0cm1TMDhNOTN1cUNOYURHS1N4QU9RUlR4RVBC?=
 =?utf-8?B?dm9hN2hqclhwdjh3dGZmRlVOZ0NkM1crS1VtTnJ4SlYvckpuL3l0NlRFZFU2?=
 =?utf-8?B?U3p0WjNiWlRMVHJhbXBhNW1RVkZFL0pOUkM3RHVJcGFVYmNkTW5HY0VoeTg1?=
 =?utf-8?B?NStHK1NQTnh5S1doa3F6dzlyZXZ3dW5OcU9lQTAreVVoRHAwKzA0Q3dKNThs?=
 =?utf-8?B?cm43N2xoa3F5NmRmYy9Td2J4RllJMFRiUDhiOWg1OG9KQVdZcGNuNTRGL0k1?=
 =?utf-8?Q?j8uwE5kRdcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFlcy9GSWM0MnlQNDUrOXpvR3lvVGZMU1lSclZBTjdXa3ZqVGlxRytsenVo?=
 =?utf-8?B?MCtuSllNZERZY0NjTy8yek53RTl3VTlucUVJTjlES2MyRnpHeElNbFM5a3ZI?=
 =?utf-8?B?NVlNaTl3VTRXNlBDYUorQzAwQWFvTFh1RXQ0WTNVRzArZS9GeTNSbENTamNM?=
 =?utf-8?B?dUkwZ01hU1BYYWMyaW5Pbjd0dmRBblFZRmM2cElXb0l5VzE3dWVXaGRrSEx0?=
 =?utf-8?B?ZzFZUnVrZUdJSVk1RmFZbG1Hd2x3Z0M5QkJRK3RVRHNmT0FNNm84aFZ3ZWxa?=
 =?utf-8?B?TEgrdzJwYXZrQUlJNUpha0dlaEh0T0tPYmJXcE12RExQdm5FK256TGZSNWpS?=
 =?utf-8?B?ZHQwcE5MV3ZYMzZORjNrM3VxeFdjdkRSclVjQXpMQThocG9oQnpmZHE2WnFY?=
 =?utf-8?B?cWlwUjErc1FNL3NzRWsvVnViM05BNWFVZzF4Z1pPa0tlV3FnYk9SYUlZek9U?=
 =?utf-8?B?cVFoKzRzcXA4bXZRNWFib2N5cU9mZ20xWTlaOVErMVBJVk9jZXNlNDZrQXhy?=
 =?utf-8?B?eC9oNlovcWVRK2M2T2NyOGp6RlZjVFdYVkxINzFOWTBpOTBKa0J2MTNBYk1X?=
 =?utf-8?B?dkhKSmVGazEvK2huRXZ6Y1JuS3NBUUZaNVVuU25qSEtLSzRiOVh5QWttZG5i?=
 =?utf-8?B?TTJlcHJkbTZkTkZrQmxqMkFqSE1HZk1NbTZORGJxR1kvaEhvaFJVb1NFMzJW?=
 =?utf-8?B?T0FISUxWQWxuRmd3SEFQdy9rNCszRGl3dnBXY2J5SkFTV3lhY3BYNC9pYXVC?=
 =?utf-8?B?OGtaL1FUSzNMK1NRRHU1QjJ4b2ZqelFIa01RTUlsbzByMC9IYWNLQit0YmhS?=
 =?utf-8?B?cno4OWpGeXB5TEl6TDV5ckVTK3NNTzZuN2RsYTczN2VxVWZWcjFaYWx1aXVo?=
 =?utf-8?B?UlVvTXhvL0VuTjZUMFZrdDhLMStZL0hIYVZPTmE2MWhyQ3pVQU5CTmlncEwy?=
 =?utf-8?B?SHQvbkE2dG1sL1VVcDRtaTdBYzR1LzJtZ2VOdnA1eS9BVzF5dFV5Q0JVcnNP?=
 =?utf-8?B?T09JcXVscUkxV2phaGVmRzlNOVlFdWtmak0yWGx5eXhRSThZL3ZpWWJKWXRo?=
 =?utf-8?B?eFN1c05jSDNNbWFJVkhsY2JpM0xPbE1tTllOd3NsRVd2bytWYWpxQS92a2ZX?=
 =?utf-8?B?ZWc3Tk92dkpVY0hoR3AySTRIM3NpVGJIZG5xRzVQcjBXK29lRXJRMTdPbkww?=
 =?utf-8?B?MWNHSE5XZFV2TjJYWkc1R3lwSWY3NWNTTHE5UVR0V1d3T3pqRGl4Q1RjVi9N?=
 =?utf-8?B?WU5ZQjh0S0FXaUM2M1VmTHBTSGNPQmlUL25PTzJta1JpeGNIbEloWTVpZkFZ?=
 =?utf-8?B?dnY2b0xEekhsT2VuWVlWRHJiR0d6TERrWGsyS3AyMFZZQk81TUVIQ0lHVzRL?=
 =?utf-8?B?dnl5NHZDbEdVRDBaelA0d3BGYWNUN1daYWN4OXNvdFFRMmhrb1RwWm9aK3Q4?=
 =?utf-8?B?RUNDeG5rbHNCTWdKcjVrdFJsdXlyTHJvb3JIQ1BkOHM3Sm5OMGJ1MU44bUM3?=
 =?utf-8?B?WW0zeG8wTExkSUNhMnpGTUtIa0l0Q3BJV2JQRTdIRHlvRVhjQUJINUVFelJB?=
 =?utf-8?B?V013czgzaE9QUEM2TnRyMXk1Z3h0aEt1R1p6U2dXR3JqNVBpOEVyMzcyZllX?=
 =?utf-8?B?bTcvaStzSmZoakE5U1o2MWVKTWwvTGt1ckc4aUJJL2pzNEhMbXNqMjF4OURp?=
 =?utf-8?B?dVNrbEhqcVJsMXJ6NXpYVmxLbC8zcWpYS0p6VUt3dWRYejNXRDJhdkZucjM5?=
 =?utf-8?B?VmFGcitTQm1GdXFkcVdFUmllWGZrM2NZSWVDbGROVGNnQ3dYWVZZb2JJNnhB?=
 =?utf-8?B?M3hidytQeFR0L2pUUWV3S2hrZTM2SGVuN0dpdHBaTS84a3hHcTJXckF2NVVD?=
 =?utf-8?B?TjB0cUxRQ0pBWWhQMFZaTzhxSDkxSlhvZ0xFaE5XVHRhYmlncFNIb1ZIRFk0?=
 =?utf-8?B?RkdGT09kZ0xvWGxYK1JZNU5EYXUxUFVDdmhmNzZGb2xSS01tcFpIUjVVQ0Qz?=
 =?utf-8?B?S3ZneTZQbllVOFlsUCtHWVJEZUpUcUxRRG1ndWtZTmNnYnVzcEdWTmRTRUVx?=
 =?utf-8?B?Z2g3YXJLZGVmUTFOT3lkaC9Na0lhajNvZDg1dGJObWJkK1Z3OE93ckdNc1Ux?=
 =?utf-8?Q?Pmjk2bHYlyDAQZ1E4QK1Mh30H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa201af-a6b6-4691-ef5e-08dd9a0b67f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 15:06:33.8592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Nxep0Kt9t54sSk94wqrHyTiRwpu7FOqGXPD3KDpn0j3qVMQJDU/gqppopNHrfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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



On 5/23/25 15:04, Ilias Apalodimas wrote:
> The EFI boot manager relies on having an IP address before trying to
> boot an EFI HTTP(s) boot entry. However, defining it as a boot or
> pre-boot command is not always the right answer since it will
> unconditionally add delay to the board boot, even if we don't boot
> over the network.
> 
> So let's do a DHCP request from the boot manager, if 'ipaddr' is
> empty and fail early if we don't have an address.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c0df5cb9acd9..2076630648f7 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -479,6 +479,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>   	if (!ctx)
>   		return EFI_OUT_OF_RESOURCES;
> 
> +	s = env_get("ipaddr");
> +	if (!s && dhcp_run(0, NULL, false)) {
> +		log_err("Error: Can't find a valid IP address\n");
> +		ret = EFI_DEVICE_ERROR;
> +		goto err;
> +	}
> +
>   	s = env_get("loadaddr");
>   	if (!s) {
>   		log_err("Error: loadaddr is not set\n");
> --
> 2.49.0
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
