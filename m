Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307EAD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B418B83C7B;
	Wed, 10 Dec 2025 08:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="duna4pBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D923B83C94; Wed, 10 Dec 2025 08:36:11 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AD183655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sn99gIfrhTHhgUMRMTUEfibHovOKNtvaoH8UhmDTp55FANXMqsdAtITbmiyPwmGjNS+HA84foO0FowPum6dW1gR5aNu2OnrYc9issIb9xrBN6UaMWZomc9E0ugVOoXRa0TnBWy9BSWkciCvluz3mvK4YSWBHhpy2ojywTeQXS7i8sKm6aYHZ4/3zJWJEOIC3c5TqjIG8sL+McTg+LkTiCu4MQOo7NiOPYQJZx3vvN7V2QabqGFFAzvXeR1Hvax+tJ6zaE+Ki8mup7Bl+fQA8FVdBaErHlZZrGP/Xgt0AjdS2YmV0ozxuPiv39p9RrF8Xe89xkcwOavl9TLaH2y9mpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQBZUT8LbU9UpexWtSBoqMblUlgd6f8qWRa4jSy9V+Y=;
 b=fgyDUSLs/smUYkbdq0w4MehVBLa3R0vhM1WD+gJbrvT8bNfpogkZv07B+6Bz762RPL2u9qF4BZRVbdzuRHf3LiMi1Lbx+iIloSl4LK/Wz/TylaaqpYWwSJp5lGGcv2x5sqzwSoF0l4T/NsgJtw9TA/lNrGyBUBNmFdXSbNteWM+7o41FXiSvPWgbD+YvE9fRnj1hjp355aGpEKxRNwfPb5BDawWxMmDNfGRLn5xBv7/c6jOtaW+nZo+8hBfQjI8ZmvXs3IY5dxXNIFhWfJLSD6LO9RQyOFi9qXULQMpRcIDoHDi0yElKmQDxDa6FgbdHtgafimj/T4SOnNA33OPqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQBZUT8LbU9UpexWtSBoqMblUlgd6f8qWRa4jSy9V+Y=;
 b=duna4pBoctvg8UqeCOlLUOVEXzCjvlWol+ws10p68lyWY9/VA20iOIePf8R1GETuu/o9Zx8xulEuRRBVwy7IGRE7pV+e0GzFZdnfv6eGRNFlGKRYZ3ulLvoPTcqKW/lzUO8zqGsxuimiB8OACDpffKZ47F9JN2vTLietrznj7aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:36:05 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:36:05 +0000
Message-ID: <14005727-69a4-4336-b522-a853a07cb69c@amd.com>
Date: Wed, 10 Dec 2025 08:35:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cadence_qspi: Remove duplicated return
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <5f6d6db9c301daf10ddb707a9031f1a467d6ebf1.1764180937.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <5f6d6db9c301daf10ddb707a9031f1a467d6ebf1.1764180937.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc51293-e837-4824-62f7-08de37bec6a9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU1TT0poZ28rU1FxTXlWMjZMMUJ2MUxlSE5DV1FjSlp0WWtIYmdEdHFwb2xZ?=
 =?utf-8?B?b3lIMEd1cmM1VTJuVlhHRWpKcVQ5NHNXYTNndm1kR3J3YVk2WHNwV2hZSzBl?=
 =?utf-8?B?UkNIb2QrVEpNVDBYZUhOeDBralZnT0VrNWQxYk1ybmIxelFVSzVya2djSThX?=
 =?utf-8?B?Ly9uRHlyUDFQK25CbThQQkNsc3h2cEpQL2l1ZjEycnpjYnRsa1hJY0RtSjdN?=
 =?utf-8?B?c0VGOXRrY3lxTlM5N0tTSmRGQk0vRFJiREswRnBveSs5ZE1Yb01XYkx5Sk9m?=
 =?utf-8?B?SGtFaGRHWW5rSnhaeEZNMXM5WGpGKytwb1lhOTY1aFhZbkhZUi9UcFFMTzY2?=
 =?utf-8?B?RWdycXV2M2x1QUdLL3ZYVHhoQm9QdVlWaGxzRkg4dHgwMVFndlRKNE9aVkRX?=
 =?utf-8?B?UnIzclExL2xNaFRnRmpHUld6cW9sWHZpaXYvcmVYM0RUYTFya0s1eVdNUURN?=
 =?utf-8?B?Zm5GSlVOa0IwWXF5VWFXTWN5SGdVcGdJSEhzcExabm1ZRk5qdXhTQ2FIdmtB?=
 =?utf-8?B?KzJ2Rm1oQzVnZUlhWGNDQ1hCZis5L09rT3BPdHNYNmVVcU1VeHFkTkEzNWRk?=
 =?utf-8?B?TGd3aGJ5N3hoWEZwTytxNkZRZlJNWVQ0anBXZ0F5c01UQVlsMDFuTkxyZnFI?=
 =?utf-8?B?MlZtaytDVmQrUkpCQ1BPR2dQVGlQbG9ZdFMvaFMyV0xma2lyQlZnNWtGak5M?=
 =?utf-8?B?Wm44YXgxTDl5V0x1RGZKQ0x1Qlpyb1FobmhPanBwTEZNSmtOMkwyYXZCckpJ?=
 =?utf-8?B?TmZaMHhkR0EwSXlJUGpXN0F0TmhpMU14cml2UVhKdVQ4MHJPQm1VekJMS1Q2?=
 =?utf-8?B?VWtEbG1Lem1PUitnOEs1QUpaODgwdDFpc20yRE5SY0tBZUNOaFdWVEl1UUNp?=
 =?utf-8?B?WVF6QXhYUUFlYTdBaW9UbGZidWoyNFhFQUpaRzdWNGY4SU9pOGFtU1pmMWhm?=
 =?utf-8?B?Um9vc2hBMmo3dVFXcmZGMlUzQ2pjZFl6ZjNQb3FrYWlWdXMwUzEyeUUwTSs4?=
 =?utf-8?B?V1lKRmY0T3pEdk85RStyV2dwNURjVHNmbVdlU1dKS2FUNEhqWW9oRkxwNHFx?=
 =?utf-8?B?WS9HQXEzd2NCM0FmMjZzd1ZrNE1wNk9JYTNiTG9DYThkMEVjUnJkS2F6Q2Nr?=
 =?utf-8?B?UHM3MWQ0QVY4NlRZbjdjOGFBV3lCVjFYdG1ySlp6Yk56SGdQbnFiTTh4WFZJ?=
 =?utf-8?B?V3U2R1dsZEhOS3owWHdBTEZJTUFyTWVZU3d2SjJSRWRwWVVzL1BLd2dLVHF0?=
 =?utf-8?B?dEJWRUNYdTc3MHNaMDN3eUxVL28xaGgwQ09VdXh4NEtPM0R3QzgwUWZhN0Zn?=
 =?utf-8?B?UjNYMG4rM1dsM3hwcHExMFBaWUtUM3pUTTJMVHRIMmFsamdWcXV5VXVpUHUw?=
 =?utf-8?B?Y1ZOdEFCYVhRbFh5NjRydHNvNE0xLzhSNDgyZ3krNVdnR2E4MkxRMm1kVEEx?=
 =?utf-8?B?bm45NW94cGwwd3I4dk1vM0JEVE8vSktaYTVldGlRTEU0aE1JTERXdXhpeVRs?=
 =?utf-8?B?eVR5aHpXRm05cVJ0TytrWTFtTjFXTzJFL2xuYmIyb00vWThmMTRaVmxLekVB?=
 =?utf-8?B?V0VncWM1a1A5RUhOdmcxUkU5cE9RdCtBWVBFYXQzV2k1OXVoTVNKVVNxVmNQ?=
 =?utf-8?B?YUJyRW1UR0d0UU1XejNjMktrbmdFblYxbnc4c201SktJNk0zazI3ZDd2WlV2?=
 =?utf-8?B?UEIyWTNPcUpXRVcrOE9GcnVmcmtrNjBIYzYzOGpmc1JRWWtDTjViWlZhK1ZZ?=
 =?utf-8?B?NU96cHdBQmJuK2xCSVZxbkhWRThpSmxkYWxzYlFEVmMyZHpMSllKVVVPWXdD?=
 =?utf-8?B?NkRYRHZzWjR0MTF6bzVCeG5xNVo4YnYwVzE0RXkyOUtPbFZib2h1VXFzbjJF?=
 =?utf-8?B?MXh3NkZIYlZEM2dVOXdQdVJEbThobkFoK0lDdld6cVFja29tMGlERWxpcisv?=
 =?utf-8?Q?n9WgGbW0aCxV0ZCWcKEddg2E/UFwSRpd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBRT0xVTGRlNHRneHFXTXFSS1FNL1R4K2pBSC9pbUNaeGtsMHpUTFN6Wi81?=
 =?utf-8?B?bzN3TG9DYklCSUJaSjlOeXllaHd2V2wwYWlJaDVvcEpsZXdsZUErOWYvNEFn?=
 =?utf-8?B?cy9LNWo3SG9jVXdnMkhjajEvMnZMc1c0SnpIUXJ4c2tiU2pqSHJLMy81aWtj?=
 =?utf-8?B?VW8rZTVhVGtIMDhxNWtrbytmd3lpbzM2emFkQ3pEMjdaVjA4NEpST0RFTE5i?=
 =?utf-8?B?enBDNVplU2ZPNXVjc1FWRTQrNCtCd0tqcXVzc3QzSXhlb3kwTUovK2c4d3Nn?=
 =?utf-8?B?V1NkZmZHSDl0b0JKNHI5Q2NTTENHaUZFRzJkMFVuck9MT3cyKzNUOGh5YlhB?=
 =?utf-8?B?NVdOQnBQS0VDc2g2Zkh3a2orTjZlVk4zd2djY0pack1LTkViMUd6U3VSK1Bj?=
 =?utf-8?B?akgxRS9zakFZOXptNDNmd2lyMTQ2YXVXYXJaeFo0R3c0c1d4aGt6QkJXNytk?=
 =?utf-8?B?VDI0Q0tZeTFBK1hQSlFQQThMLzVkSVE0d21DNHRqOHJJcXlnNWdqL09kdWFQ?=
 =?utf-8?B?QVBzbTU4RzdLUzZDdzYrekdmdGVUR1UvRkN6S1NyZTVnVzRla1FMbmJRUXVI?=
 =?utf-8?B?YzNaTVBBZk5MUmxmY0RLZTBVQ1duZGhiYUVLZzBMRHlEWm9yWU1tTFkvNWw5?=
 =?utf-8?B?TW5rYTNMT3JJejdlaFd4TUpwelpNZHo2ZzRSZUJVcFlDSTV5elNkWEFlbGZN?=
 =?utf-8?B?b1VQak5vTVRUMVZmTVFVemJEUVhaWU5ObzdqZUdnaTQ5VXViVmlXZTJmVTg5?=
 =?utf-8?B?bktMVFlqZWZPcmMxYnlOSExidkZTUWFnK1VNQTNaNExiaVowT0Z4dVNYLzRI?=
 =?utf-8?B?UkkrdDEvR0xEb0xXZGxPUXc2a2ViRTR4VFpCQ1BjRFUxckpnbHhyL3hIR3Ja?=
 =?utf-8?B?YUJsNDlqNlBibXErVTNWWmVLS3EzZm1pWHg5dVd0bElLMFpSb1huUHlMa1Rq?=
 =?utf-8?B?aWhHcC9KckFoRFdXV1JObDJKR1BlL0pTKzc0d1pFYkFiWDJrSFlJbTUzeW1Q?=
 =?utf-8?B?eW5tL09hcWo1M2NCS2tJUmJmSTFwNG01Mkx3TWpzYy8yRmxLRTYxRDNuZ09V?=
 =?utf-8?B?am5mVVhkOHdENzMyZXhXcHNVa2hncjJQb3VuZ091enNJMnE5Tzh0cnhUOU5O?=
 =?utf-8?B?QW1nVTZzZ2c2c2JZeGVuQk82dEJ5dGtlNzQvaU5kaEZVbnhoUTN5czJybjhI?=
 =?utf-8?B?b0FqNFZPRjNTKzJOTmgzYUxjbTRyKzVValQrRThabExkM0I2UXdyRlZFYWVr?=
 =?utf-8?B?Qnpnd3hReHZGK0hFL20xS09PRGEvd2ZNa04zYTBRZ0tZS280Mis3dGt1ZEt2?=
 =?utf-8?B?TEJQd25LZVZuNVNQNFJZUWpXOU9FM2RlYVFHejdwbXF4NDlrMDY4eVNKa1dh?=
 =?utf-8?B?bmJKUm1tYno1b0p4MW80cUNzYUppMzdXMzZ2b0ZJM0VlMmg1Vm45T042WXJM?=
 =?utf-8?B?eDIwNFpXU2lic1dCKzYwVW56dXJITjV3UEFFclhmMVJ1TEh5TldYRUZpbXNY?=
 =?utf-8?B?MXlDMzR5ekV2OExWZFFvZUl2ZXFqdzRYc21WYnpUaHl0NG5ta1dsZHFoZ3F1?=
 =?utf-8?B?QWY1YzJzU3I5WnZGc2Z3SjJQbVJQZWxJWGhjM1R0VFc1Vmt1WHY0UUo2Rm90?=
 =?utf-8?B?VHZHcUV4TEpRUENEeGVUbmpVcEowZzN3U2FISFo0QVdDNEtBZm5iNnJhODBI?=
 =?utf-8?B?VlpOb3BwRDBvaTd4alQxcDVIT0RINDR5VHZjclNEUXNaUm50eEg4ZVFhZHQ1?=
 =?utf-8?B?REpiSjVuVElwTzhlaVVQbGswSFBLYjdoWGFDY3NkQlZGVDdsLzR0Y0l2MzRD?=
 =?utf-8?B?M0RQMy9ZZkdWSVlXank2cktmR1VqWUJISmFwaTZaT3dmbXNLMG1pWmdLN2Ry?=
 =?utf-8?B?TWZBbDN6R0RwRUJ3elY0RFp2eDYyN3AzeFdGRUdvY1pHNmpKdTUxVFBmZE5v?=
 =?utf-8?B?Snl3NFVKeXBmYTVsSnpMRGtjUHk3ZTZENzhHNGxBOGZSU0c2djN6dDhhd3F1?=
 =?utf-8?B?V01jLzBiNk5JV3pxdXR3TFhvQ2xXbFF1NE93Y3dJdGFqTEVBUXZPdVRkbmV2?=
 =?utf-8?B?RTRnU1IyTk8vcmRrUHZqY3VDYmY0UUxWYVJDWEcvRlZIakZ6VmNNZHNnaENv?=
 =?utf-8?Q?Sma7i+7esRsSIqlpMfrMWwISD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc51293-e837-4824-62f7-08de37bec6a9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:36:05.2516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HFr81JuWbbQ2I1H3DVEn1ZZiED3vKxgs87DMNpmx8pti+wVpOov/XK/uMwPpLjZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 11/26/25 19:15, Michal Simek wrote:
> The commit 6d234a79e9eb ("cadence_qspi: Refactor the flash reset
> functionality") introduced two returns in cadence_spi_probe() that's why
> remove it.
> 
> Fixes: 6d234a79e9eb ("cadence_qspi: Refactor the flash reset functionality")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/spi/cadence_qspi.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 892dc3557a5e..2d2469565b5d 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -270,8 +270,6 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	/* Reset ospi flash device */
>   	return cadence_qspi_flash_reset(bus);
> -
> -	return 0;
>   }
>   
>   static int cadence_spi_remove(struct udevice *dev)

Applied.
M
