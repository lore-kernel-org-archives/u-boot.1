Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB71C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF4883123;
	Tue,  8 Jul 2025 15:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xEmRQ0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7B983280; Tue,  8 Jul 2025 15:02:00 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015D1830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzHmSRWbXErM6H2SoSnKQA9SBW+BafhGyF0NYP0U/pRorLivh3OV/fXpN+lg0REymz72Bx0J9wgtzIbNjvsHxHk29ADwKE3JBl6TALUpIdw9h6QrSlqkBWyv0aZjNIOCl0kjJgTg5UG7k4z0X+SN95jcmj7rB3u3Ccxi6SMVFVceDcwoUcwgR2B6WU4PvleA4yxUYkFr/d7xlKA+iIOW9FfOhyZgtYbm0AJQq5BwJxh0Gpn6xozEIFhj1sYyb12n1AlyzZLCUyyFp6C7/Ai5tWbnhMrjrSDtBSMa8COTpsKgyrJA/bFAlZdjGTRl5o3SdNXGqHZrj4DAshVsY7t2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdEy9MljKujzU5M+ThHrcu52OEgenDQOzEwIY3nBVF4=;
 b=vNWVRa5Zil2qk/T9sFVd8c4x9pwoLw8L2M9YHTYFJHu+cckWRFKhaDhwL4Wf/kWWB7oYIe5Sq4jHMhGH3EaWE9aAEZgw5owszon05bRJbnJAW8Iz4wsuDlMczDt1A2O+EubqSRlwOARqermGL+1i0LRFS3TIM0u855y5Zbt2jJ+Na9t8fEvmz5sW8aDS2cElY9QpqUzNqmLASzC8d/SXkA8ekpgz+6FMALic356o4f/njuQB/YvCBFbXnOLJmX8XAbBiknKMUgwSnY8rT5HNzwVocJ9zlAL5/wJhOaUHFikyNdXUa0YEIvz+ViEkPx44u2qKfqNkvF0EGLH9z3Ch0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdEy9MljKujzU5M+ThHrcu52OEgenDQOzEwIY3nBVF4=;
 b=0xEmRQ0wEIp+BK6dZxRAS1D4rnwG+MhQtw2Z5CHhyVffmtbhraX3hoWP6X5bgjze6u4weI9esZWbSsg0z6I0tYAmhUXq0RXEruQADKMGJ+HFt54t67bw/2hQ1bLjgv1fT6csVCMHWaDLCNrMunAOSlLFQY0k/FIaCwv26zYwRJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:01:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:01:51 +0000
Message-ID: <75a80bc7-c0bd-4150-96e9-1aa6b8edecc3@amd.com>
Date: Tue, 8 Jul 2025 15:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] versal2: Enable reset and poweroff
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c56f748-cf23-4e8e-8b2a-08ddbe1f9b7e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0hVcmp3cVBjKzA2RmdVanJoTWNaZXBrb242RVkrOCtWZ2YrQ0F2V0pQTFFQ?=
 =?utf-8?B?NE1Za0VPMWViN1FGaGt4MzdvNUw5RlRJQ3FSbC9WMWVuT3IvTEpUcVowd2pM?=
 =?utf-8?B?QUZRdDhxNnZHVCtoSmtHR2J6QUhsQXF2bnRUVVA2bk83RUpIUjdmbUFsS2hS?=
 =?utf-8?B?d1NpSXF4aDBrSWQvMi9MdE9XSVlMd0xrd3RrVVBodWRKSTRRYU5vTVdSeTdM?=
 =?utf-8?B?a1N0Q2RRbUNmOXhJaWNtRlNJclNVWHJtRHFxb2V0eEdHdW0yaGNVQzRWZExQ?=
 =?utf-8?B?SEJwOVZWZlFPVm1ONC91WDBHcDlIeG1YYUV3cVlzckZDQXV4TDJ5S2ZaRUVt?=
 =?utf-8?B?V3ZWMDNjeEdkS0l1SWhYK2N4b0hrWWJ3clRwTVM0bmxsdG5OeU5na0U4bkN2?=
 =?utf-8?B?bXZwUDRqQ3JOcEZNVzdEaXFKYis1d1pLVGdsUG1Yc2NGd2ZvdHBCZVJqbTRj?=
 =?utf-8?B?eUluS2g5L2EyWERWTG95YVRzVmJSOW1IQzFDSVU4MlBWcXVodnB2YWpmUklW?=
 =?utf-8?B?b3YzNkpSQUVTQlJaZzBnZVgyZis4eHBWdkQvNzEzME1Sb3hJcG0vamovSWw1?=
 =?utf-8?B?alROdmNvVk0zUytqL2dtVktYSEhNUDdsV2xsMkNtOXcwNjRENVEzM2pTUGp1?=
 =?utf-8?B?N29wc0Y5OGFiM1k2L0IxeDVtVkdOdmxWSUdDMjRudXYwcHdDdGk4YjZRZ0ow?=
 =?utf-8?B?N2NwM3JTY2JMK2ZlM2pmTEg2K05uTTlEV0lRV3JUSHZNckJoeTBPbnVyTkUz?=
 =?utf-8?B?N29LQ2UxbHFVS1N2bWRLM2NyWjBpZnF1SDVMZisvZllLUlprZFBjTGIvN3BH?=
 =?utf-8?B?RER0YVllL21yRE1zY1F6azR0TC9SYU1ycWhsdFR0aTBDZFN1b2VJeGk5ZkJW?=
 =?utf-8?B?aWQvbysveDRwaFJkc2xmWXlQMHJ2SmlvYW5wNVhob2NsWnRuQi9hK2NoTFpK?=
 =?utf-8?B?Z2ZOYjVzamVYWGZiZDhwY2ZDNzhYVU1laWM4ZFdjdm04bldmVERzTE9JNWMx?=
 =?utf-8?B?cGN4YWgvZ1lka0NVckp1cG9TQ2pLWWdocEkrMUNRZi9sVjQ5WVpQRS9lMUdm?=
 =?utf-8?B?R0xaZm5rdjZFUytoVlI1NEZ6Z3F1YjM4ZUtheGo2M210cjUrNVF5dkJSY21N?=
 =?utf-8?B?MW5aWmZCRG9KMFZId3h1ek5qV2RrWmNWRjd0NXM2ejNTTGFHUEFjT3gxLzUw?=
 =?utf-8?B?Qk9OaHFzTFNFTWVCOVpab0p5MjNpSUVXZ3dTOE5hSGpnWmNVajZmbitOa0ha?=
 =?utf-8?B?WmFEUFNQRnRNWE1UOXN4NTNtVnZ2RjgvTnhVNEc1cmRmSkhWdDE1SDNDbnpP?=
 =?utf-8?B?akkzSkZlOWMxREZrTEpjNlZNOTBuZzQ5bWNDbGNoTFFPbDIveWlDVm1pSGZk?=
 =?utf-8?B?VVE1OFlBYTVDbkNGUXpoK1NEWHFQc2hNUGdhWnloc0NCYVcrdWJuN09FUTZZ?=
 =?utf-8?B?NThEb3E2N1BjRmVSSVQxTE40RkZiV0NpSmROOTNhWDZpUlJxTUVZWnlBS0VX?=
 =?utf-8?B?enc3ejVTbDlnOHBzQVBmOXBjeXhQWHI2L1dQZ1lGZWVEWC9VSjVTZkE3NlRv?=
 =?utf-8?B?TkZsRys5aGFnby9CWm1NaTR6VmI2WFU5LzlNVXFvVXk4SWM5U0ZDd2taTFVH?=
 =?utf-8?B?dnRpOEVlR2dtTDhqZW4yN0dwZFR3bUNWVUhwL3M4VVV5K1VsTjZudmpyUnpD?=
 =?utf-8?B?d2xWUitOTUN2Wi8xYTN2MFF6ckNCaExSem5aZUsrRUJSaGVLSmEweGZENWo0?=
 =?utf-8?B?eVVsOURTL2pFZG5WTGNvbG82eUFHK1BlK3NsOWdZTVBjbitCZFJvZE5DcTFx?=
 =?utf-8?B?YjhBNkF0Z092c1ViM2V5cW9ZQUdZc3dmenlqSWFQSFJsVmIvV3RlNWtOSGVq?=
 =?utf-8?B?UVc0UDA1RUcrK0ltWVgrT1Z2RXNZZ2lzQTVuRFRMM2Jhb3JkbXFWRGI3bXBz?=
 =?utf-8?Q?DuFSoTrRXzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUloNmltTkJ3YnlsaXcxSWIxRFRzc3h6S292aVlORGhsay9saU9ueUUzK3VU?=
 =?utf-8?B?VEs3dHA3TnV1aUJTOVg2TitjV0JUSG9xRlNCbHRhWFdTYTNiZkczSTRsRzRw?=
 =?utf-8?B?alpqZWlVSmlNTzA1NFdTNGg1QVJFVUI0VGh2b2xrdW02bjR2WHkyWkdISnZD?=
 =?utf-8?B?czh4TVlISkJuaG5zRW5kZGovb2VPZmRxYmNjWXpqRTB0d2F3ZEdtREM2QlFW?=
 =?utf-8?B?WkFPbTA0ZUpIcFVaUWx2S3NjODliMG0yY0NXYVo0aHlkbHU1eHk1ekVqU3Vm?=
 =?utf-8?B?WFpDMWhOUGU3VytiZGd5S25KSy9BaDg3VWlMY203V3gxbXA5R1g4aDBvayto?=
 =?utf-8?B?cVo1MEVEQlpXWndoWXVVUTUvK2FMdmF4bzB1Ti90enhKSHBENUNBTmdLSTlh?=
 =?utf-8?B?QXgvRWdycHhhb2V1SzBCNUtuSHFSUTRJQTYvL0p0YnVvUFhxcUFvZnRCc0gz?=
 =?utf-8?B?Y1RZWkdGRCtpOWdZYUZvdEdMU05vUWJvRVgxR0NPMXRKeGc5cE5jT3NjbkpT?=
 =?utf-8?B?Z1k3bEVkc2kvL3lFOEVrMENNVmtPdEdkYjdaZmsyL29UQjU1WUR0RUQ1YUhX?=
 =?utf-8?B?NlJ2K3UyRlVaU1F3eTYxaml6Qkl1YnVHUmdDU2MzdGRIUzVId2JyNnhjZXJ4?=
 =?utf-8?B?SXpNbW54VUFiVnNOWllWU3NRYTc5SUZaZDFYQW5DRDlKWVNmZWtjeTkxYjho?=
 =?utf-8?B?aEdlSHcrRTE3OFVDUHJOcDIveFpTZm0yMW0zRTlHYllQcVJRQVI0b1oxU0RX?=
 =?utf-8?B?aUJ1aVVHQXE1SDhOcCt4VTdLZ1VhRlZLWklxQ0EzMkdDbHUzNWxTaWJLN1ZL?=
 =?utf-8?B?NHZXQVBpRGpRRE0wSzJ6TVhGSVVHSTFZSHVUWVYxOVZLK2I4QzNvdmVDUWgx?=
 =?utf-8?B?YVpLTDVzdUVsU1p1MmgrMGN6NE1haG1uUzZWRjJtaFNZbGp2ZFBDWkZoNGpi?=
 =?utf-8?B?bm9adzFqeDFiLy9PUnNlL0t1dmJPTE9jY0huTzhXeWY2M1ZmMzRHN0VFc1dv?=
 =?utf-8?B?ZVJGQlQyNitsLzVmMWlQT1NCcFhnT0cxaUhpYXpRcFJ2WmVKNUlwRm5UZ2xM?=
 =?utf-8?B?bC9MOU9RTG8wU3BGQ0ZMNjdUQWRTQzZCRkpINTJ4ajhNaU9vKzIyVUV5YjF6?=
 =?utf-8?B?OXJiTTFzRmNXMSt6bFJSNEtqMzUxMHMra2ZqY0J4cERwVllHZmJWaERRdkpV?=
 =?utf-8?B?SmQzTC9mOFE3Y0dvSWxZc05hRCtRRGFXY0l5WlBHaXdRb01obERKd0pRLzh3?=
 =?utf-8?B?anRKZm9jcUo2c2E4eHBWYy9TK3JMZ0NEVkFkdDhBbDQrdjk0MnJYNHNwdGpN?=
 =?utf-8?B?UlcvV29kV2VLZUI3dmdkazJYb2FRLzJCZm5rK3RiVTI3REk3WENqd0ZTZXFY?=
 =?utf-8?B?N0ZaTnJwTXc1dEF1UVAraGRsdDR0ei9TdDI1N2RCdyswOURYYUVJNkRCUUFL?=
 =?utf-8?B?a0lWYTNsaFhneHlCU2EzTVBXdmFBblpDWUtZa21RbnphKyswU2k0R1F0djJD?=
 =?utf-8?B?elJqdmU0TWhkY1M4UWpqYy82S3ROMEMrdE1YRDJqUzBNQ0hzT1VpOFFDUXR6?=
 =?utf-8?B?T3BPUHNwNFZlQTlhNmxiOGJ2UVA4OTZqS3haRUhLRFBPMnNjdHBOVjFOa3dr?=
 =?utf-8?B?S01nek4wbnA5aDU1bXRpMmRzSVZleTJpandHZUM0eFFqTWtBdGpyb3dId3Zi?=
 =?utf-8?B?SjdRUzJuZXpFSkpaakgvcUpUOVlKb0lCNHZ1WnhVN0M4dmRRWEVZaDdKcEQ3?=
 =?utf-8?B?aDJ5cGtjbEY1QVJTcnA4UnFmM1dpVmxFOUJvcll5d010RVdoYysxVkRUTDlR?=
 =?utf-8?B?RHhmaTFueG96djViVUdidWx2cGxpLzBxVUw4ZXV2d0Z4TVhicDV6N1dJSWh4?=
 =?utf-8?B?OHIrQllvaXBwUTJGUzB3MEdXeXlDWUFEL2RwWVlkVmJ0YjloOXZqZjNpVlhr?=
 =?utf-8?B?VXdvcGZrbzhTdzg1bHBRWHljeDRDZzA3MXplUm1hdG02dmdZQTdQU00rSHBV?=
 =?utf-8?B?ajduVjAvYjRkNnNVdzRoVWJSa3UrcHNxZ2x2WFVwb3owNWtrL3RhdGlyMnEx?=
 =?utf-8?B?Y002a0ZnSE1vM3IyNmVuSjZ3T090WUVpSER2dS9RVUVWd3NnaWcyTENEcjhH?=
 =?utf-8?Q?pdjTJncMqiNB+l57eJMeos0SF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56f748-cf23-4e8e-8b2a-08ddbe1f9b7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:51.9403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiyZlJGDhu7RAKYF2TmolzF35wO7xHoFdZyWJlqo6F/NgGWvY6tOVal2HGk+h9wn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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



On 7/7/25 06:06, Venkatesh Yadav Abbarapu wrote:
> Enable reset and poweroff via sysreset framework.
> 
> Venkatesh Yadav Abbarapu (2):
>    arm64: versal2: Enable reset and poweroff via sysreset framework
>    arm64: versal2: Do not define do_reset() if sysreset is enabled
> 
>   board/amd/versal2/board.c          | 2 ++
>   configs/amd_versal2_virt_defconfig | 3 +++
>   2 files changed, 5 insertions(+)
> 

Applied.
M
