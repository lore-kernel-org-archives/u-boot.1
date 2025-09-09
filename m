Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCDECAC585
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AAE82A9E;
	Tue,  9 Sep 2025 07:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQdWkO7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E01830B4; Tue,  9 Sep 2025 07:57:22 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B126180422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMcxnfMXk16vfZ5pPZMsi+AkMuv0LOvFvm3tsH8SEgw8vulqCIFGTLif86rpjSvja/xJh+K0lWBT8mBWpD8AoFBdTjHA52OxS7UvQpKg2NbkKb8g2ghhqRArVco3LcJhP64kcNfbX5+aI7rR1U1Qhbe7ZtWPq4/c6V3UK74gLqpgOBYzRZodZlueIXEF9D1faKzOdZ7NPeFrcj6SRLQlvtdzRNsRZzOK4HX6NTtEvRIjmE+uFftozpjOZY2jF42AS+tiriugfaIROI8eqnJ0u5Tzlx3V+K5YQOOzP5/J70t9UEeOhi4kvC0vWwfpsqQafYdwpzcECPp6vYlAiomQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEXgWe6F4jryCnl2wrpooDbfVA0d7SCqn6Ftf4LoaUw=;
 b=DoOynYfdVoj96tfePRs5QDQ4OjrPoA5kgEITQS3CxG4dhtU1Kr6Ea5QGdR2dqgnMT1zWJVyPyXFpqv5cM3fxXare1Z5PSSmvxZqfO4dfiLjqgyrl8EwWD3UF5rXYq9I/9aB4ydpvPxnkMMmvcKz8d1KMsBzzv7Jk9q9SuxyCTgmpcJrajp0PPBWbdjRRnNSuY8MALxXgBMYTXV+AV8H6IFVxaqYjiumDDuH/R3Sol7Dod9P2VJYd9kM2jI5j8SnpndeniCKdwj0h+qiaS4rU2hcteyMaciG77n9zT6ICqEeGl7uoNI1QLi0oPLLcGk04UVaR5/nA2dmLVeSJ1RYv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEXgWe6F4jryCnl2wrpooDbfVA0d7SCqn6Ftf4LoaUw=;
 b=uQdWkO7zjZq28AjqhVeyZywTsdni2OyYbfitwFg1wfjYDLuvyxc+M1VPl+VWP4OPMpx8izA9goS7DbMikFNVJEP4buDtPQ5tGbk8BlogvycyI8q53o1Uj5XLDp1B3lq+3dIt3WV1N3pb8U0eFsiNVnVtAWuXzIBW69iFHotSVt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:57:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:57:14 +0000
Message-ID: <061e711e-5c63-4c78-9567-0bda30af0a11@amd.com>
Date: Tue, 9 Sep 2025 07:57:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: net: Add versal2 10GBE device support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, git@amd.com
References: <20250828045807.426542-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250828045807.426542-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6538fbe2-1f92-4657-2025-08ddef65b9f6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVaOXBLamlRU2VmRkFQR2JrVkh4QzRNcldlM0VKU3NGMFRFYitwWWZmNmJM?=
 =?utf-8?B?VCt0VVNEbzRyeXJyVU9KcmFpMnFpVEMveDNkU2lqbUp3NWtoS2VTSkZISENi?=
 =?utf-8?B?Ty9RK2tyS3BEWW5hdWNoNWN0T0xDWEVpSzlZeFJiditLTnZKb2JFSTNaMUpY?=
 =?utf-8?B?VHAvTnpmdzFzdzZNT3g1TysrSlBnbktMQmlaRHhINmduU2F0RWxrdnNjMFc4?=
 =?utf-8?B?RVRqVTNTOXRiR1FRYWJ3MmRRL1NoUTcwSzBPSG1ZbEJKdytHam1sL1lJRzJE?=
 =?utf-8?B?bFV2bDFYakJGZFZJZzdEdXIzcDZPcU9lbStlZ3B1NEloT2Q3aHZLaHRWRmdj?=
 =?utf-8?B?SFZ6eHI2ZktzTVpYdkJTaUlKaWVJZUs5UTYwd1VEaG44c0JYNk92L1JkQklz?=
 =?utf-8?B?ejJVendZRlNORnlYZEhFa0NuOUE0eWhXSEFQaDZHbWE2WFBnK2ZtQXg2V08z?=
 =?utf-8?B?R041T3poYTBkSkJsaTVKUUtZZldkdFl2c1RoMExlUjlEQkJPbW1IZGxyM3do?=
 =?utf-8?B?ckorT0lDaGpCQ2g3Q2xNTjVpa3ZWaG5xTzUyNGJMb0FFWktMNWJiNkR3U3Zo?=
 =?utf-8?B?cUpobEtoVGJhQlNVT3RzMDRwcmNZaUUyaEpBZHJOdG1qUDJMSm9lWVBIWWJv?=
 =?utf-8?B?RnJqQ1p4aDJ5eW1SSW90S3FmYVRNQks2TmhGZVl6Ym42NTJYS1R5WmFPQjF3?=
 =?utf-8?B?TEErSmFuTmtjR3JZU2pzSEVrYzRyVisxMEN5b2U2YWI2aWlRYXZVWUxUWVpD?=
 =?utf-8?B?OHZwd3FOY1R1dXNIZVg3dHJNMW05NHN6dWZUVXNKbWxJRzVBRkJXSnNSQndT?=
 =?utf-8?B?MmxUbWJ0T1RhSW5zeXluSVZtdTlpalNtNGZvb292cTFTbXJ3czRrY2JRMHFn?=
 =?utf-8?B?NURRb1kySWd6VjlsK0FhVmpZdEJ2dkhMNTBXUXBVc3k4NTR5bmIwWERDV1ZB?=
 =?utf-8?B?TlpNRzcxNTR6Q3p6MEM5KytiUXUrZjJaNURCZW50ekgzNmVKeUlxWmozUHhT?=
 =?utf-8?B?KzZGODdaL2E2TmVrb0w4NVJTVWd2cXdGSFJNMFFvMnpGeENvTzMyOEQ1cnJI?=
 =?utf-8?B?NnJKOGtHVlFTTDg0Q1RBUlU2RUc3SWEyU1FsK2hPanpKTjhhT240K1g2RFRy?=
 =?utf-8?B?RU9ocGxvK0dSWDhRL0g0Q21hblVtamtRZGpJVElRbDVxZVA1cVFINGFuMXNI?=
 =?utf-8?B?MXZwQnQ2TXhOSjRCYndpaFRJQ3JnQk1ncWNIMHhudEtkcDg0ellRSEIxTXZo?=
 =?utf-8?B?YXNCaHNkeGtKcE5nNjFLTkhSYTgwbTUxcUQrU0p6TkpCWHNJbDVUS0tVZjIy?=
 =?utf-8?B?OEZReHo5MmZ4ci9mQjg4VjZqa0ZzYkY2MDFtR3NvdFdYR2JMWVgvM21KZ3Rj?=
 =?utf-8?B?bUxBTFhvQytJMUhuL0hLdmNtZEp1V3Yxb1pjZXJ6R0xhNU5hSHc1STlaN0ZJ?=
 =?utf-8?B?bXRlT2pWdXFVa0xQS0xZYW5VNUorSUZVVzE2ZU5VbUE0aUkwSlQrbVBwMk1Z?=
 =?utf-8?B?UXZxRmhEaEcrbEV5c2VHR2N5YVpPVHBtM0MzcG53N0l3Ri8vQ3FlQWNtYWVR?=
 =?utf-8?B?RzVGQnArK0xyWUduS0ZyNnZKYURCbVNOWERMOHQxc1VSa3NsQy9mSCtwMkpB?=
 =?utf-8?B?WDlIdjI3OUU5azE1SDM2M041ZjVFUTBjbG5GMHBkb0hnWTJuWnlDaEFIakJL?=
 =?utf-8?B?VytHSC9ueTdDa1dvL2ozemc1S1ZTOUZBczlsTml2bjk2d0dLWDFFcnd2dTVJ?=
 =?utf-8?B?YWtOQzRMc0VUL0EweDFkWFpib3l1Z2VEUnVUb21zTFBBSDVtelpMOTgxaGRl?=
 =?utf-8?B?c25GNDdZT3B5VDl6TDBUMUFlakRZSzdkTUYxQXlwd1VUSGgrd085Zjl0NU5p?=
 =?utf-8?B?czBPZlVZQWN2UTZRdTM5ZjRqS2FzSjF2OU1aYjBiZzk0RHh3WlFGSmJzRzh4?=
 =?utf-8?Q?Rl7sY7ZNAQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFaWEhPeXlNQzhoRmd2YXNyMFVlWFpGcEFRQTB6Ukd4MHJPRlBqS21TYW5q?=
 =?utf-8?B?OEZ6WkNyTCtnR0FrRlJndDUvak9GUk1jUFZEdGVaRzVnZ3BOWjJPUXozdEY2?=
 =?utf-8?B?ZlF5TE14NHR0RTRtazk1ajJkTGFaTEQzQkh0czNiYU5vYW5DLzA0aXAyT3JV?=
 =?utf-8?B?T1BJWmxuVjJBbTFxVTJwZ3FFcFFxOXhDQzlrYVFCaHBOeUlFRW1aSU44b2px?=
 =?utf-8?B?bG11WGdXTWZpM3BhcU13WFpKRlFWc1FUWDJDNDFUK0NwWVNNTzhNalU1NkRi?=
 =?utf-8?B?UXMwU3phNXdHazA2bjc5MTlIUUxHQnlITlNHZFA4b1RlWVlxQUNyMHJqdlRE?=
 =?utf-8?B?ZzRuNURFUUJoNDY4TWV4eE05bEZReWpnWmQyN1JuMzArNTdRMXdVWGVYVkda?=
 =?utf-8?B?eEZybS9vZWZ6Y3lkbFl2eVJmWCtpellmSWhYNmtMWk1qQ3hheFNJTU5mWjRZ?=
 =?utf-8?B?RC8wYlQzcVJHM21QYi81NDVkajVSVmhnQmxZNDFUdW1pN1ovekc1dzlvMXJx?=
 =?utf-8?B?eEMzUTYzdnRocWlRSFhha1dEalk2cmVpd3ZDNERKdDdZVFduZXdtSWYvVVBK?=
 =?utf-8?B?MjJLd1hVRnExN0hpL0V5d005am02WHlEUGp4T1lGSXE3MHNxRkdFUTdDL1Np?=
 =?utf-8?B?QzBsR2doY3hSWjlneXR4alhtSzVVWXoyK2dzb3J5K3lldC8wNkhoc3kyV08v?=
 =?utf-8?B?RTNCcGJwYjhZMGQyemo4VTVPaVpaNjhKMGVnSVJjQ2hjejM1N0h4cWF4YWtE?=
 =?utf-8?B?SzZZVnpvSXhmMERCa1FwTy80QzE4Qk9QTnR2VHVjbXJVbHF5QnBJKzZSOTVC?=
 =?utf-8?B?UkVQZFZSOThzN09KT2xRVHhwaVB5TTc0WmlUR3RHTy90b0pZRjBmdm1oNEl6?=
 =?utf-8?B?VUpsOEVWV0FKQVpiOW12VFJ1STV2bTR0OUl5MlFVdTFZc3pOR1JubmpEcWpG?=
 =?utf-8?B?WGhZR0xqNmswU25KRERSUTVQN3JtWmUwdjJxdkRkbGRselV2UFp0b05Vd1dR?=
 =?utf-8?B?QTVPdmVXWlozY1lmR3E2Mk13dVQ4MmE2aDFzQnpyUVhGamh2WnJwbHBjclE1?=
 =?utf-8?B?VHQwdWJGcVFPZ0F3VVZyMWxNNjlaeDN6YnJlcy85M1FOSEZMaDRLV2FOeGJy?=
 =?utf-8?B?aDZyZ1hxWk9qR1VIeUZZMzVqb2VZTnU4bktDUk1yOUlZOWdUMjZwdkxsbzZh?=
 =?utf-8?B?aFJMK3czejlwU2dVMCtDaG1BbTAwb3VBbTdMTGRjM09JbTNHdGtGSUdYbW4r?=
 =?utf-8?B?VHRlN0g3Zi8rbE1nZjY1RjZJa2xubk1WL0hzZ0ZRcGczMWcyTUloSEZmc0ls?=
 =?utf-8?B?ZC9MZXJVdm1nUDZRb0hZaWF3Y0VCeGNjVjNUcDF2ODl0d3lvVm5YR3I0Z1FD?=
 =?utf-8?B?OVF3TTJPVk9lTEpwNTBrSW5zeitoK0dtMjBpMlFrc1lkYVpBMDRpdWtJOCtx?=
 =?utf-8?B?blVHbGJoRUk5REN6RFBmYVFrR1VLaVdiTWhUQ3o3T2t0QVg4akVwOHloRzlM?=
 =?utf-8?B?dzRrTWZrR2x4UVdEczZKVG1Tak5yaXdQbyt1Q2R1ZDhWZm9LUGdJSC9KQW8r?=
 =?utf-8?B?bDUyQUlReGliWVJuKytqOXlWcWtIUUVOb2NnRjJqSkl1S21RS28xbG8vL1di?=
 =?utf-8?B?TnFhcm0rQmRneDg3ZEY0UXNyZHdLbHFTV3RSRm8wR05jNGV3MGxFUng5Q00y?=
 =?utf-8?B?VkJoTXpjWHlwUjZYd2IwdDRwSUIrcDdydmFBU3ZOMkUxSzNkUHpadW9LbHpM?=
 =?utf-8?B?ZGlsMlcwdS9qVEQxZGh1TDNJZll1UWR3QlA2SC8yTjZtczREWGlmVEh4MkpG?=
 =?utf-8?B?VmFXQlBZa08zRjhmV21YNkhEdDJPeCtKS2JUQXB5RDhjeU5KeEdoWDJqS0FL?=
 =?utf-8?B?RUZiWVk2TmFNTlpxdVVEaTZFMG81bmtrS2NhNWRCdDF5WS9uM2pjNEplTzJ1?=
 =?utf-8?B?aUtVeHVFWkNiR0pGbUFkNW5WVVp2Wk0wTWtCK21kc0lEQ1BZaG9rMFFhUkRG?=
 =?utf-8?B?cDA4UW9TSlhockM5dTBoOWZBTkt3UisycTByZTFHNGRGdWl5QTBIeXJ4bFI3?=
 =?utf-8?B?OHQ5eUVhR3VaWjhENTQ5Zys4ZGNnaVFabGViaW90MlZOZSs0TXZ4b3pmZllo?=
 =?utf-8?Q?yenFYnfk9qThqHYEg8GehONTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6538fbe2-1f92-4657-2025-08ddef65b9f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:57:14.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCHj/B60pF97h/RlYsBegwvHu/bGIeH34S0W1sqZ64lnnBDOj8s4Qu3Ivo4Jvn32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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



On 8/28/25 06:58, Venkatesh Yadav Abbarapu wrote:
> Add 10GBE high-speed Mac support, it supports 10G, 5G, 2.5G and 1G speeds.
> 10GBE high speed Mac is an extension of the current 1G Mac in versal,
> inheriting all its current features.
> 
> MMI 10GBE ip has two internal PCS's.
> 1)10GBASER PCS is used for higher speeds 10G and 5G.
> 2)1000BASEX PCS is used for slower speeds 1G and 2.5G.
> 
> Both PCS's speed and rate configuration is done with same
> usx registers. ENABLE_HS_MAC bit in NCR is the toggle switch
> between the PCS's.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/net/zynq_gem.c | 95 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index 703e22479d2..407b022508c 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -162,7 +162,9 @@ struct zynq_gem_regs {
>   	u32 idr; /* 0x2c - Interrupt Disable reg */
>   	u32 reserved3;
>   	u32 phymntnc; /* 0x34 - Phy Maintaince reg */
> -	u32 reserved4[18];
> +	u32 reserved4[6];
> +	u32 hsmaccfg; /* 0x50 - HS MAC Config reg */
> +	u32 reserved5[11];
>   	u32 hashl; /* 0x80 - Hash Low address reg */
>   	u32 hashh; /* 0x84 - Hash High address reg */
>   #define LADDR_LOW	0
> @@ -185,6 +187,10 @@ struct zynq_gem_regs {
>   	u32 upper_txqbase; /* 0x4C8 - Upper tx_q base addr */
>   	u32 reserved11[2];
>   	u32 upper_rxqbase; /* 0x4D4 - Upper rx_q base addr */
> +	u32 reserved13[362];
> +	u32 usxctrlreg;  /* 0xA80 - Usx Control reg */
> +	u32 reserved14;
> +	u32 usxstatusreg; /* 0xA88 - Usx Status reg */
>   };
>   
>   /* BD descriptors */
> @@ -209,6 +215,27 @@ struct emac_bd {
>   /* Setup the first free TX descriptor */
>   #define TX_FREE_DESC	2
>   
> +#define HS_SPEED_1000M                          1
> +#define HS_SPEED_2500M                          2
> +#define HS_SPEED_5000M                          3
> +#define HS_SPEED_10000M                         4
> +#define MACB_SERDES_RATE_5G_2G5_1G              0
> +#define MACB_SERDES_RATE_10G                    1
> +#define USX_BLOCK_LOCK                          BIT(0)
> +#define TX_SCR_BYPASS                           BIT(8)
> +#define RX_SCR_BYPASS                           BIT(9)
> +#define RX_SYNC_RESET                           BIT(2)
> +#define SPEED_5000                              5000
> +#define TX_EN                                   BIT(1)
> +#define SIGNAL_OK                               BIT(0)
> +#define ENABLE_HS_MAC                           BIT(31)
> +#define PCSSEL                                  BIT(11)
> +#define HS_MAC_SPEED_MASK                       0x3
> +#define USX_CONFIG_SERDES_RATE_MASK             0x3
> +#define USX_CONFIG_SERDES_RATE_SHIFT            12
> +#define USX_CONFIG_SPEED_MASK                   0x3
> +#define USX_CONFIG_SPEED_SHIFT                  14
> +
>   /* Initialized, rxbd_current, rx_first_buf must be 0 after init */
>   struct zynq_gem_priv {
>   	struct emac_bd *tx_bd;
> @@ -391,9 +418,11 @@ static int zynq_phy_init(struct udevice *dev)
>   
>   static int zynq_gem_init(struct udevice *dev)
>   {
> -	u32 i, nwconfig, nwcfg;
>   	int ret;
> +	u32 i, nwconfig, nwcfg, ctrl, ncr;
>   	unsigned long clk_rate = 0;
> +	unsigned long speed_val, serdes_rate, config;
> +	unsigned long clear_speed_val_mask, clear_serdes_rate_mask;
>   	struct zynq_gem_priv *priv = dev_get_priv(dev);
>   	struct zynq_gem_regs *regs = priv->iobase;
>   	struct zynq_gem_regs *regs_mdio = priv->mdiobase;
> @@ -499,6 +528,67 @@ static int zynq_gem_init(struct udevice *dev)
>   
>   	nwconfig = ZYNQ_GEM_NWCFG_INIT;
>   
> +	if (device_is_compatible(dev, "amd,versal2-10gbe")) {
> +		if (priv->interface == PHY_INTERFACE_MODE_10GBASER) {
> +			ctrl = readl(&regs->nwcfg);
> +			ctrl |= PCSSEL;
> +			writel(ctrl, &regs->nwcfg);
> +			ncr  = readl(&regs->nwctrl);
> +			ncr  |= ENABLE_HS_MAC;
> +			writel(ncr, &regs->nwctrl);
> +		}
> +		switch (priv->phydev->speed) {
> +		case SPEED_1000:
> +			speed_val = HS_SPEED_1000M;
> +			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
> +			break;
> +		case SPEED_2500:
> +			speed_val = HS_SPEED_2500M;
> +			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
> +			break;
> +		case SPEED_5000:
> +			speed_val = HS_SPEED_5000M;
> +			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
> +			break;
> +		case SPEED_10000:
> +			speed_val = HS_SPEED_10000M;
> +			serdes_rate = MACB_SERDES_RATE_10G;
> +			break;
> +		default:
> +			printf("Specified speed not supported =%d\n", priv->phydev->speed);
> +			break;
> +		}
> +
> +		config = readl(&regs->hsmaccfg);
> +		config = (config & ~HS_MAC_SPEED_MASK) | speed_val;
> +		writel(config, &regs->hsmaccfg);
> +
> +		config = readl(&regs->usxctrlreg);
> +		config |= SIGNAL_OK;
> +		clear_serdes_rate_mask = ~(USX_CONFIG_SERDES_RATE_MASK <<
> +					   USX_CONFIG_SERDES_RATE_SHIFT);
> +		config = (config & clear_serdes_rate_mask) |
> +			  serdes_rate << USX_CONFIG_SERDES_RATE_SHIFT;
> +
> +		clear_speed_val_mask = ~(USX_CONFIG_SPEED_MASK <<
> +					 USX_CONFIG_SPEED_SHIFT);
> +		config = (config & clear_speed_val_mask) |
> +			  speed_val << USX_CONFIG_SPEED_SHIFT;
> +		config &= ~(TX_SCR_BYPASS | RX_SCR_BYPASS);
> +		config |= RX_SYNC_RESET;
> +		writel(config, &regs->usxctrlreg);
> +
> +		mdelay(250);
> +		config &= ~(RX_SYNC_RESET);
> +		config |= (TX_EN);
> +		writel(config, &regs->usxctrlreg);
> +
> +		ret = wait_for_bit_le32(&regs->usxstatusreg, USX_BLOCK_LOCK,
> +					true, 20000, true);
> +		if (ret)
> +			printf("usx block lock failed\n");
> +	}
> +
>   	/*
>   	 * Set SGMII enable PCS selection only if internal PCS/PMA
>   	 * core is used and interface is SGMII.
> @@ -997,6 +1087,7 @@ static int zynq_gem_of_to_plat(struct udevice *dev)
>   }
>   
>   static const struct udevice_id zynq_gem_ids[] = {
> +	{ .compatible = "amd,versal2-10gbe" },
>   	{ .compatible = "xlnx,versal-gem", .data = RXCLK_EN },
>   	{ .compatible = "cdns,versal-gem", .data = RXCLK_EN },
>   	{ .compatible = "xlnx,zynqmp-gem" },

Applied.
M
