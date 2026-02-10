Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA3EA3F24
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 08:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F8F8341A;
	Tue, 10 Feb 2026 09:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kjqo4MKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A2D8388D; Tue, 10 Feb 2026 09:29:37 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A8D8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlV+5ZZNLZzFKkXvue5JPQXhEzV8yco6JJxfdUteU9mRdImKGAQ4YNKIqFsT1ByK00lkmTcPEoLmQjh3q4nEY2QXFgOTAhLFdc9/Dz4oLX5yqwh/zLtUdAQrl5a10mo8r9ByDWlD23lHPkOIRu6Fe7iOFeK4Gg9/y+GbBkUqWz4fk015di6HlzN04m/m3SECNrMSVLgrVm3gDTe84xSNsq/kj0anVP80AjElI0zA5+ES2EASkeqVLzB+dW0fO0528uhHwkXz5t2CBrZostfzC/wWylh9cozpm6c+kIsl7knMN+pY0C0gb6g4uoV2SB0GXoBjcpA8g8vPARKuwUbQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajbCRiXMBdrXr8oKj0Yglo9yTchyJs/SYPTNIpOpCg4=;
 b=mMyZC2786W8YLFJfjuXyukXoWBlwrFP83o2sd3waGRn8yNO+jyS22vf3SdyystJePvuYis5rXldjOorilTFyX+mJHv7WJ1wjTMGhH6hCBOGmybBrwqtqYgxklsaLemOmnYyEV50ICWhcO4NR/vNa1nIYVXiJmq6TVBj4LNa/h6vzj6Y4Fj+WlZ4BoAhJvweFdfhbw/PhaDgTbuf+dB0D9ObYPir3BR2Rh7Xn5H/CSYUp6BQvmbHJ9noJA7vtXkqUi4N2CRI3Tn12QLosa6vIsz1jaVE9KNepilJvCSMkCK/0v2NCZx4UrlHlqt+tv5URSZYY1HRrf59QqWbBAYsVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajbCRiXMBdrXr8oKj0Yglo9yTchyJs/SYPTNIpOpCg4=;
 b=Kjqo4MKZbP/RUHcdPe3BIuCaxr27pnuo1q8Z/ubzM0eglX05HnomRfUaX7Tkh5VfjNo43HWlcKzbhMxq2ZmEsCgkI3Qq/JURw5TEspYWsHq7hiK02OxoFt+LtN2HQZ3otpEhxul2O5fieRQ6Jnm2hhmllXXr0X0fFxJJYLAyuq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 08:29:28 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 08:29:28 +0000
Message-ID: <bfdae6f2-6d40-4e64-8f01-29e96c3fec13@amd.com>
Date: Tue, 10 Feb 2026 09:29:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Enable dynamic MMU page table sizing
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20260129120021.1328653-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260129120021.1328653-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:803:1::32) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: a8139657-f297-4280-d54b-08de687e81a9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WThCOWxCd25MT05nYkNXKzI0SHloSkYrVGJXNFBFUlUrK0lMemYwbUIvbjl3?=
 =?utf-8?B?aXZvcTNpZ2JYakt2bE9DM3FhbkR2WFJpdXIyWDRZbWF2Nm9qNVlvcldua1V0?=
 =?utf-8?B?NzNZazFZZ25NZkFyS0JYQUh6dVl3ZjhJVzVFWlQvL0IvQXMwRnowUE5tNkRN?=
 =?utf-8?B?SE5BRjYxVG5tblcvcFFzOTV1M2hLbjUvYWtQaXFQdjVpVjRwWXJzUFJQa2JB?=
 =?utf-8?B?K1J5V3B5TVg5UkJndUxHTitCVkcxN0VhSnhoSEQyZlJSdEdaTzVnaU1YdXlU?=
 =?utf-8?B?bEs2TjdoSDVRalRRYmEvMnZGT0E5V2k5L0dZR1Vab095b3UwVDI5VGpKS25n?=
 =?utf-8?B?QXhCOWE4RjRzQ0lhc215RVlyWVZTMjd5Q05ydE9GMmdUbDYxcXI0T1ZFd2tt?=
 =?utf-8?B?VWhSb2ZOOHk3Yk51SHdYVXVVZjh5aHVOWVdsV1FLVGFkUy9yMDhlUWFGVlgv?=
 =?utf-8?B?S2w1YmpuNSt5NGZTUllrLzd4SzdKUTU5SDlyMi9JeUJoZ09kSC9haytQS1FT?=
 =?utf-8?B?S2NVcy83RWxYQlF4NUxwTUlVdktPTmw2THh3K0hoRURQTDdQalBJQk5tRE80?=
 =?utf-8?B?dGpmOTJ3NzJxdU8zZ0tZNEpjdGd5UFVBeVJxWlVOL1VxcDlTWkFkcHlqK3Ex?=
 =?utf-8?B?M2xlU3VjTDJuMXRnOWkyYzN2d055STFGMGtyYUdRdDVnaW5SZjV6VFRheDNq?=
 =?utf-8?B?aFFHbk1kK2Z2cmxRSzBmcWlhT2hSU0ExWUpmN2RXS0FCVnhrZGp6MHM1QXg2?=
 =?utf-8?B?WGp5SDJ3WUlLZmt2T1FnbXc2ME1jbWo3VkV6YWVDOStlTnRkaXBiREdiakNh?=
 =?utf-8?B?dytqMGE1NEM1V0xPeTlMaTBkNmhGVTUrSGhBRTBLYzZHWTJkalB4UzArYU5K?=
 =?utf-8?B?bGZoK0tvb0F2cE5jSUhvWm5mZk82UzFicG5KY3kwSEJ0bzBvck5KdXlRQTlt?=
 =?utf-8?B?NElVZTNiRnl2SHJQNmZEdENkR1lJaW5ieGR1eWRnd1RJVUtoNERhS2VxdEtv?=
 =?utf-8?B?emFwTUVpSkVQNmJVWnRLOXhVeGs2WTNKVzQxdW9hbmlvdDVwblVUeDFBVG1j?=
 =?utf-8?B?dHRLazN0VG5kZmtoT0NiMXFweFJLbW1qbWx0dEp4aUliT3RiU2RHNHJ3bUND?=
 =?utf-8?B?Nmx4aUp4SEoxM0ZUUUpaNkNtRE1xY0RJdEx1RnUzbllkVG5ON3BRdGs4UkVy?=
 =?utf-8?B?bmhpTG1JUGVTenhpM1pZbXJ4U1JkdkdXanlkMHpsdVNmWXdxYUgxcmpFZXBU?=
 =?utf-8?B?OC82MFVQZEk2MFBhYXRlMHVEeTBuWldFMy9oREh2dlVvL05aYnArSnk5bUdm?=
 =?utf-8?B?MmxuZ2FBMG5jZkpidEZTK0pyclJuN3o4eXJ5OUFSVW5FR3J6Z09JNXFiTSts?=
 =?utf-8?B?QUtQUkxjV243WEwzdzNJa1QydmtKRHFwc0g2blpuSVlLdVdOb0tzVEFSbzZX?=
 =?utf-8?B?aTV3UGhrOU15NEJsOGlGYktzVWc4US9CcjhMYlM4alRucUMrWXl6SWphUTdR?=
 =?utf-8?B?OWNVUXcxNFo2S2RyV3hoQ1hyZSsyTTZ0WnBmRm4raWtvc2F1SXhlU2VVNDNp?=
 =?utf-8?B?SzZwTnJOMFlsMkNrWWt5ZUJWcE51NmFPYkJaYkxhTUhHK3JWRUpSNVlzL2g3?=
 =?utf-8?B?L3FCaFdaWWdacDhmY3NxbEc0Rys0MEFrelpzclNBdTFiQTNINEZXazRKei9s?=
 =?utf-8?B?N1NzKzJLVGNJWk1nMFc0MEFXaFdOVHhCblNZQy9qTVJ3NWxPWlFnSGxMZUg5?=
 =?utf-8?B?dVFYV3pEekJnSmZoSHZkeVQvYnFXU3J4QTNXdlMvU0NXYUp3UjhTbFZPYkRO?=
 =?utf-8?B?QUtEeEFGYVdLSmwyaU5mbjk4Q2FCR2phaW1VK0ZDdDdNMFM3Y3ZZdGNtWE1y?=
 =?utf-8?B?S2N3Qms0MCs3VE5hUFpCKzRvYzdqMk1tVEs4N2htNFRvdlc1ZGJicHJkOUp5?=
 =?utf-8?B?aXNnWi8xMW9jWVI3NnVyNjJSa2V1UHZ3OVlJMzVabUt0cVJiWWRGZzR4d3R6?=
 =?utf-8?B?bDArZkMvelR5aUo1SGdwU2RUSThrMVFtaGJPZ0JwYzcvelBKZHdMTDNVbWdy?=
 =?utf-8?B?Smg2WGM2bUxSZm5ZMVd0RGJUMFhmS1dhK1NGemFwK2gyb0pacy9lL3FMN2FJ?=
 =?utf-8?Q?0HhU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZvQ29VeUo0aytXd2tuRUM1Y0prOGViMGw5a3dmVzNCYXVwaGxnWllDWHJs?=
 =?utf-8?B?Q0s1MXRqMERwZXpodzJuMTZuRURjcUMraFl2RmF5UWV1bjA1RzlKV25TZHkz?=
 =?utf-8?B?b1N1eXlnS0I1QTdqRllwdnBmM1l2OU1jM0ZqVTJreXIrL1UvUDcvT1BKODlx?=
 =?utf-8?B?N0ZjT2l6MTJSWVluZEU3bkx6M3ZwSzB2T2FjNjg2cHJGeGwrZWRpVGZNc0Rz?=
 =?utf-8?B?Ylc2RWp4SHZ6dUl0WE0ybnJrN0N2OHpBb3RGQjlGSFJxaUpoZ28xVU5QRXUv?=
 =?utf-8?B?dWZCN3lzRWhwVmtPdG5scjlwT3U2MHZrdlFhTzcrWEVoNVFXcVE3YXFQeWJP?=
 =?utf-8?B?OTRsWGJTb2pRQ05QOXdsV0x4S2N6RWNNdUo4MExXdDdQVC92ZVpoYU1rVlI1?=
 =?utf-8?B?QjRQTG11dnFGVmY0eEN6aU1QQ3Y1Q3dNYkxXTCs0Mm1CZTMvbGl5a1RLWDZR?=
 =?utf-8?B?RENDdkp5UEJ4QVYyeldmUnFEUTZzTlRjU3FsUjd6dzI2clhGODdZcGR5VUM4?=
 =?utf-8?B?RjJjL3VDYm43YkxtQUpnTXcwV2xFRHRiNjN4cWI1S000K3JKRXJhT2FrT2xx?=
 =?utf-8?B?R05VVm5YR25DQlRnYnRTS0NSY3dHMENtS3hMMkdXQ1NSd0JHeklVWFlrWmdT?=
 =?utf-8?B?VjhlRUNmRWRjRGdHSjFXVmR2d1lzTTAyYnUxajFicE9DWVRmUGhhMWlpa1dX?=
 =?utf-8?B?eUt0VVNESzAzVWkrSVhKTWoxS2RCZnNuZ3Nmak5XVlpkVnJSN2EyUHEySkow?=
 =?utf-8?B?RjZJLzhzK0dDVmd1N0wyMm43blN2Y0NGNks0WHIxRzU3QjVwV1E3dnRjdWJX?=
 =?utf-8?B?UnNNWUkxVDZhc0xROVYreTZoa3ZnUFJCVXhKcUY1Wk90Y0lGZ01jYTJtTmV2?=
 =?utf-8?B?R0s2ZXdiQWFUNHo2eGErV3lTMzcxblZuQitQd3I1VEcxd3RJRnFXOFVQeTk0?=
 =?utf-8?B?SXZDV2NrYzlkVHVJUWVlLy9UT0NlOXFIZUUyWUlkZktzVmt4Y0Vsc3VUMUwy?=
 =?utf-8?B?aE9oUmoxZVlzYTZadmFhd3N0NDZscGk2cDlRVlNoR2pLR0RKTm15L1RzWW12?=
 =?utf-8?B?NWV4SUtkbEQwZGhDK1M2QzEwaHZoN0VjRnhOcGJueFZuQWJGemE0OWlKSngw?=
 =?utf-8?B?Vi9BaGZ5WVdvL1UwTjlJMzBUYWUweVZGVEdZU1V3TjEraWdRV0JTNEF5cFAz?=
 =?utf-8?B?OUgzSEpDeU11czkrTm5Sb2ZoRnFFY2tJNFAxZkcvQzEraTJ3Sy9vWmVhMGlk?=
 =?utf-8?B?RldUNC9ROTZwbms4QTNwVy9FUCtiWmkvRDhlcXRiZmZVNVZOcHd0dmV2QjRG?=
 =?utf-8?B?TXdsbkhlemdFeXhyVUdodkx5WWhOSWZjOVdzajZNS3QyU2RsMGVKSmY2UFYv?=
 =?utf-8?B?ODdrY3N6Q3JtdHJhTjhqMEI3ZVgwVHFMYUdjUVZRc2h1TWppUFBnTG9UQXMz?=
 =?utf-8?B?TVJYQ2gwSHNLUUtVbHd1UFlGWS9adUdPUXZTdzBXK2d3cDI5MHJmUGJLM2Ry?=
 =?utf-8?B?SlNxRjhVeWlmZjQ3eS9hWFJlWmkwbDN2Q1RHdG5URzRYZXBpS01IVk5tQWUy?=
 =?utf-8?B?YW8xNHEvbGx4ZE5xZGpNby8zQk9PWVhJMzM0TEY5cHJpYVY5bUlFdlFDRkV6?=
 =?utf-8?B?c3A1Qk4wWEJQSld3U05uMllacmpBQ2tTZFhseTVhdU5EVEFBVmxtTEdBbGU0?=
 =?utf-8?B?N2J3c1VIT1J4MlU4S2xORjk4UFNiTlJvZGRLNGtFbTIvMVBQSm1VbjZsKzFv?=
 =?utf-8?B?eWE4YmFKeHZhcUFERnlLanQ3eWV4cTk4TmtpYkwvdnAwTUpPa2s3MitrcVhn?=
 =?utf-8?B?emUzRXF2RmpQMXRXVXFjU21DemJrR0ZNOXhmalpPOHJYLzc1cnprRUowTXBs?=
 =?utf-8?B?Q3YxdHdpUThhUUgxU3NNbVdFUmVlektFcUJJcmI2aWVLVUYvQmF5czZseVBw?=
 =?utf-8?B?YjhINVJoMGhOL2NJY05idk1udWI3Um5yUmNSQ3N3b014UWZxQlFNQisrN29K?=
 =?utf-8?B?aFpZV21hTlRaTEVPZTJCQkpVRU42cG8xdHhMd2hzUzcwNXd0MmwwaEoydk1R?=
 =?utf-8?B?UXowcm1VM3VPVDhQQlpRMjRFYm1nRzJTYlR4KytnWEExUkwyMnJ2M0JnYlZO?=
 =?utf-8?B?UGMzTFJmT0NZUm5jM3ZqSTgxNUpOWmU5S2VLR2RMaEhpZnhuVG13a3RDVEI5?=
 =?utf-8?B?Z2tPKzhuRUdyamdOdktaRGJmYTNFeG9YYk9VOW1KOFlUUk1DWkkybUUwWmZ1?=
 =?utf-8?B?cWJ6YVdmYlVaVTNYVTB2dTRvK2pvdDZ2N3Mwd3RjNTN1NjhqTnErck4wcEdn?=
 =?utf-8?B?d0tCYVV0MUhia1lCYzVrZEtjd1NRT1F0bE45c2txRWN1RDRYNGJjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8139657-f297-4280-d54b-08de687e81a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:29:28.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEG9/YJqMYl4urY9M4c/YS7FxlYtKZQLLy5a24XeZWINOmyK2y6DeDnqG2Uaglil
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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



On 1/29/26 13:00, Pranav Sanwal wrote:
> This patch series fixes a boot sequence issue in AMD Versal Gen 2, where DRAM banks are populated too late during MMU initialization.
> The fdtdec-based approach doesn't provide memory information early enough.
> 
> Changes in v5:
> -Add fdtdec_ prefix to exported fdt api.
> -Clean up DDR init logs.
> 
> Changes in v4:
> -Better debug logs alignment.
> 
> Changes in v3:
> -Fix DRAM base detection boundary condition (text >= bank_phys)
> 
> Changes in v2:
> -Address boundary case where U-Boot is loaded at the  beginning of a memory region.
> -Export get_next_memory_node() helper from fdtdec for reuse -Split previous monolithic patch into two focused patches -Add comprehensive documentation for new functions -Include proper header dependencies (dm/ofnode_decl.h)
> 
> Pranav Sanwal (2):
>    fdtdec: Add declaration for get_next_memory_node() helper
>    arm64: versal2: Populate DRAM banks before page table size calculation
> 
>   arch/arm/mach-versal2/cpu.c                   | 55 ++++++++++++--
>   .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
>   board/amd/versal2/board.c                     | 75 +++++++++++++++----
>   include/fdtdec.h                              | 24 ++++++
>   lib/fdtdec.c                                  |  7 +-
>   5 files changed, 140 insertions(+), 25 deletions(-)
> 

Applied.
M
