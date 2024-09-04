Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC8ACA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D1688C97;
	Wed,  4 Sep 2024 10:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tk0aalC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F81988CAC; Wed,  4 Sep 2024 10:44:05 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1998888C8E
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ighGUkXOExRbd7V3ZidAsQCjwI/xjE+YndrMtqs8Rgd5U8O2flK0q+TsLlpxvtFcIfm25r2CKD9krNypPzF0PrDcS0RRdfYhf9AEUr/3W7VWshgVHzryo124IwEYfTi9bEessAK6au3LgMKGyzmn1i+Wkbh6RNp6F/cvkUgk9bro3/DPrhKRfbbQEPN6ny81OHnTEOJKr7WVeUJGI9v1nVz61opmqzIO2MbluCTa6krkDTDmxp1D5nJ0Fknr0v7HJQGbfKGi03zRIMtTz4gk7+tAnsYh0f6f3BR/NbSjzT0wZEH9yOStRm/jBpyTsxaEeZt98Yfs4/mjZV1YXrpbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaVUaptbTg34UuGVOKT4UKmg5uMNBXI1Zsw15vXUoBs=;
 b=MzlKwEFv2q6/NjnrcdxvGDNq7GgVm40EKIJf76kejnmNpEdvhKNq2m4tzqkaYbEsBxCbKFBCenCXbkJ08r8hWgzLOtKmTZfM3skXVi7agah1yihAYjxUUPiEtIU1Lh9wy5T/mcyoIfTtOJ+HXeq/4JyCDuvgjkpWQSyuJDSD/CIgy4WlpSQphcqXp+5II8HrGA2Kpm6qhMm4FfKNSCOgrlAbH0KWZDPDHi4dbCoBMd8dCYbier0I1NenpSHm6r2h8+ASs6pWP2rSs4H8wDEp7LNe5TuBTDhKND0z34X4UQFVayCaWq7h+Xm+pd1y9YWEK+yh6VuYPEUJqcnoB5/0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaVUaptbTg34UuGVOKT4UKmg5uMNBXI1Zsw15vXUoBs=;
 b=tk0aalC5XtWXduIiBcFbBRMI3CiOZP3qwlEXqtrDf9hhm3J/MTVBRbQHUHO3K92V7XJlQaELSr37e0JfetQJhIE+lt0y3xP6rLJYf507TZcDbt9E3tsrPij2PIplRRhP4dQIQSMZMAccNotAUuK4ZEPSkf81EGH4u9daEbG/AFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 4 Sep
 2024 08:43:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:43:59 +0000
Message-ID: <d8eea758-9637-4278-b251-ae38d5a18a7f@amd.com>
Date: Wed, 4 Sep 2024 10:43:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fwu: v2: perform some checks before reading metadata
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0001.eurprd08.prod.outlook.com
 (2603:10a6:803:104::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 28918d83-4234-49a4-8b1d-08dcccbdb81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1Z3WUdsYUpteFdRZVhWcGFwb2VtRmY3c3JPeTRCbWY4eTlQbVFXcUdYVVhx?=
 =?utf-8?B?Ym5RT09tZE5WWTRvcGh2NE5oTlhUSlBQdXpzVThhL1g3ODFXQjRpNlV3LzZh?=
 =?utf-8?B?a3I1eHU3ZEZ0UHRsVnFnRTZ5L0NmNXJjR1QveTBEY0pZTG5RVWVYZ0U1WkZw?=
 =?utf-8?B?dGVhTDJlZEVXaWlsekl5cWVTS2EvaGxiekV6Yi81b0VoQmc2SXBENmRjbjVx?=
 =?utf-8?B?NlpwUTYwZDFWTXNRdWovV2duamZEdVhmcVZudjFMVjIvSkRVSytidERVV1Bl?=
 =?utf-8?B?SlpNNVUzTFNEOWVXdzkzN2dFZTIxSUdQQi9teHdUU2pPWTVjQmVCZEtpNG9P?=
 =?utf-8?B?UWZzZGpEWllmNW1HbFpZd09xa2ZLVVpyRmYvck5UU3VwTDN6Ukw4RnY1cEVj?=
 =?utf-8?B?ci9WSnJaVVF4ZFlZK0lxc1B6K3Z3MG5xZmZnZXZ5WXd2ZFo5YXdnN1l5R3dF?=
 =?utf-8?B?QnVaTW9PYUhzaHRzdUVQOXNpbXdkSHlSd1BIRUhxRXhRa29QMVBET2NHOFA2?=
 =?utf-8?B?RGlXbFVCZ3JiWG82Z3NuN3NMYy9qTGMzTXV3dnJIY0wwSE1EendPOXJmOGJp?=
 =?utf-8?B?ZUppVUxVUllheTdkUGJrb0Z2d3o5UHZqMXNwU2Zvb0NOWnBKVlA2QjFwVTFl?=
 =?utf-8?B?WTQ5TDB4V1Q5MnpHWFlxS1ZPZGdTVElUZ1hHa0g0Vm1sUzR5eXlMQkZCNHRr?=
 =?utf-8?B?UUlUMTJlRUxGZDBqeDRyUkFJQ3ZDSzVSMDRyZWE1elFybVRYb2ViY3F6dVBl?=
 =?utf-8?B?UWNsZldncnlKQ3lreWdlak0vTXZiSm1paThsTzJOcUg4UFQ2cEUzcVI1WjZN?=
 =?utf-8?B?VlVGdG5leXlIeS9TUGtCUmc3OEVwNFVCYi9lU0JsK25hd1liemlMcTN2a1Ry?=
 =?utf-8?B?bjR5TnZBdjgxeWg5OTNKZnNzNTc1QWU2OERaWnA1bTByb1diVDZXOXhPSm5Q?=
 =?utf-8?B?UFZGckRpYzAvY2ZYR2dBU21RN0NMQ2ZuTG4wbCtRZFphTUpGYkhqVDlVczJN?=
 =?utf-8?B?OTJVTVJaOTQrTWlDbjE0dld5bzFGZ056SG1ZNGZpZGhhRUFQczdML3Y3aENw?=
 =?utf-8?B?S3diYTlBRk8ycjVqRHRrTG1HNnJYNWh4VEJ0Ty80NFlpTUw4cVpYa09td25j?=
 =?utf-8?B?b3N0eTZTU1VNQ1pZRHJhVkU4S2NWUWtvMmlTNHN4a05ZU09ad2NPSDRRblJy?=
 =?utf-8?B?QUF6TGlMODBIOTdqYjdOU0Y3WmFuNGduWXJ0dkV0RWdKMUdCTjRTWUdjTEZT?=
 =?utf-8?B?ZEJzY0FCSWJIb3cvVklnRWhadEMvT1JMcEF3cGVjd0l2WGozdWFBbWR2ZHlB?=
 =?utf-8?B?cWRVRHZxR2E4Z0tqNEJ1M0t1MHhVbEhtZnpFRmNGVkFMblpFZ3dETkxJVER0?=
 =?utf-8?B?c1RaT1V2bWJpZkVuYmIxSTJhRzMxeEYzQkNuSiszSDZRRE5MZHdhT2I1bWp6?=
 =?utf-8?B?RHZ1VEIyWWtOMngvNlQ5WDBWNXltQXo5dElBUXMrdjE4YXQzUUx3Zmc0M3lB?=
 =?utf-8?B?aWlZSjlRQzdaR0FWV3lmR1FHYzA1UHRGMWNibEpqd0tPbDR0VjJnL2hTNlow?=
 =?utf-8?B?RlluUGNDMUMxOUdZSVhFcENRbFhybVNIWnNjWEpPWENyQmdKSFVBN0xjWEpq?=
 =?utf-8?B?dFEwTVhMWjBtcUplWGJEMkdnK3VsSi9vNXdIY3Ixa1c3MUFHQzZuR2d4Rnd1?=
 =?utf-8?B?S0NOZWN2VjNWNEhNOTY5Q2o1WVIzUEhmUXVHQ050N1JpUUZxMFNNTlc0UWVO?=
 =?utf-8?B?eEkvaFZvYVp2SXVkem4xK0lOUW1uVWVOSzQzQUZZRHdnb3JYcHFRN1hHQUll?=
 =?utf-8?B?L2VLNEYreXRib0hTa0pZQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NSttTndScnUxS1NOWU14SjJHSHpuU1I2VVJYUUpkbkx6S2pCVyt2WWtnbC83?=
 =?utf-8?B?ckFrdHlZY3oyTFpNSDRDTnVIdzBscVF4cWYyOGhnR0J1aGpFUUd1eCtxYm1L?=
 =?utf-8?B?ay9KK2dOcGRRRWNFQ1lDZUxFbUhCQXVFNnl3TEpFQS9MdkZCSUlNWUhxbUlm?=
 =?utf-8?B?a25qeVdySDdQTVgyRUE5S3RqT1d4ZmE0cmdzRjhrN2dzc0dXM0pTZENsMWVR?=
 =?utf-8?B?aGMvSEVTS3grdWdvQllsVXNWMWVjcnMvYll0c1haYytxOElTdnVON1FmWXFO?=
 =?utf-8?B?M1g5TU9VL2F0ZVUzN3dmOUtDbWp4NVdaVUcrYVFMNTZJaW5tYk5tUWtzR2Zk?=
 =?utf-8?B?b3RQV3A2SUVXeDRhMlltQ3JlaDNFblFuMFNFRi8remxQMjh6YW4rK09hUFFo?=
 =?utf-8?B?MHo3MU9UU1JBem5jaVNZNFFLbGNSc2RTcitNbk1lZTRTY1RlQ0V6SzlscDhr?=
 =?utf-8?B?aERQNVFaaHNwNUNGOHN6cGxJY29jdGU1VXF4WHQ0K092VnRqaG5Ub1dmMHFU?=
 =?utf-8?B?ZnR1dUFtVCtMMEd5WDNucXloK2Z6Q3lIVDV1RnJPNVBNSkxCcXQrWElwUVdR?=
 =?utf-8?B?VjQzMTZNVWh6K2F6bTgvWUd4ZTdUN3JTZm5vbFAzQTVlTHljUkp3RzlTbHgw?=
 =?utf-8?B?bDgySWYyK0Y0UjRROHhtanNwOUpjdkxtYkcycTNwRS9IZGowZXhxRnAvN0NU?=
 =?utf-8?B?MjhsRHpwYTZSQkhUek5yZW1CZjBnYzF3Z3NPWm1UZE4wQnRNdHEySms0ekln?=
 =?utf-8?B?TldsMEVRYUVpYkNPS0hXSzNVdUhNaGJFUUNVdlNCeFJNbDVMeW5Ddnk5R2d6?=
 =?utf-8?B?ZllyRGdVL2JOUEhNZCsrZitNT2dFQ1lEdmtCVzF2NzJEb201T0hycVNEYzJO?=
 =?utf-8?B?eVhBdWl5aXVmTkhrbWhUczNuV0RVQnRnSm5nWVJYZFp5dFdHZTVNdG1BbFVk?=
 =?utf-8?B?clY5RnNYd1ZBd0lZaE9HN09PNlpqSE16LzBEdkNUdkV5ejBpL3NYZGpHZGRh?=
 =?utf-8?B?R1F4OUo5b1R6Z0cxOE42N2lzZ1pZR2tjSFNqT09JM3VoeC93OFFKWVhhUHpD?=
 =?utf-8?B?R3lJbi9EajhFbnU2WURpa3ZuYi94OFpkQnlaV1ZER0FBY1BVVStCZWR1bmJB?=
 =?utf-8?B?T2FJNEZvTFBYOWFXQmJteUMwYTdGNzloNk5LMW5YbEpWYlozQ2toMFh4VjdO?=
 =?utf-8?B?bVZTUVBNUk1zZy96NjQwNjVqWHMycWpHQk5mbmkxR2NKKzRnNUlwM1cyZS9j?=
 =?utf-8?B?MldUMlRIbDNCWC9CbDRtOG1jQlNob2xKQkVzSWVIc2IvNXNhdU5EVDVUU1ps?=
 =?utf-8?B?ckNDSjdnRzY5UUxzSFVMZjFmMjR2aUVmejdnS2RVeHowRVpacHpFV3RmRnYz?=
 =?utf-8?B?M2lvbHBtV2NWa21FeUh5VE84V1lKL3lGZHoyOTVGR0h3cHVtZXRnek5HM0F6?=
 =?utf-8?B?eHBHbTJoS1M1TTlRUnliZC9ZWnZXSFVWWUY0NUFWWGRwSUVmalhYYWh4ckg1?=
 =?utf-8?B?RzRSYjJrc1FuN0RYeGtMNzF4cGdyZVZOeWp4dkJ6d1dselcvOGoyM2htRmRl?=
 =?utf-8?B?OVp1TjVyZHpac3pwa3dselh4SEk1MVY1OVdyK3FncVpVY2ZURThUbE93cmJv?=
 =?utf-8?B?NGpoSTRpd1F6aTVpdElpNmxsK2JUdHFnck1mK0VoVDZoSFlxd1ZJeGt1T3VB?=
 =?utf-8?B?REZnK0k5WnI1bWdQY292UWQvTlhNamNkUnAwaHJzdzVDbm85S0R2YStXdVc1?=
 =?utf-8?B?RVpXVlhDTEd5OVBDdktUSExGcmxyb2lmSjFlaU5JMnpMRTVhZ2VWbHFDc3Zi?=
 =?utf-8?B?TytmVitlUVlZUEltdVhLdjVFN1FXUUJpK2RPdDhQVWQwRytHQmM1L2NoQklO?=
 =?utf-8?B?SXhPRGs1QTZEMUVUeVVseHlGeVpTcndHRXpqRlFyUUxlRmViQ0ZIYWdPTXNP?=
 =?utf-8?B?SUtNbUlyU2RNSTY5aGpyTlJlVmdOa1ZMUFdaQ25GOFI3Z3B3bjQ1TFQxbEdY?=
 =?utf-8?B?NkdaYlNWTnNsb1UvRDRWbUFYNnhVakdqSE5laHpSVGREYjNvRkRCSkEvM1hx?=
 =?utf-8?B?MERNaGN6RTRTbVJPaG95V0MwREpCUFRqNDd6Yk1rM2REa01TaDA5aURrZmZs?=
 =?utf-8?Q?hm9KUnPno32quVDF1vCwezMZ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28918d83-4234-49a4-8b1d-08dcccbdb81e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:43:59.2015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoUj4mTg7FdJgsVRRg2o9ljDFj1TAjA4mNyUV2EKR72tkyzkKTn5HtZmJDPrHiTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> The version 2 of the FWU metadata has a top level structure, followed
> by optional information on the updatable images. Perform some sanity
> checks on some of the fields in the top level structure to determine
> if the rest of the structure has to be read.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/fwu_updates/fwu_v2.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index 108bc9bb4a..d0d8a25929 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -58,24 +58,6 @@ static int fwu_mdata_sanity_checks(void)
>   	struct fwu_data *data = fwu_get_data();
>   	struct fwu_mdata *mdata = data->fwu_mdata;
>   
> -	if (mdata->version != FWU_MDATA_VERSION) {
> -		log_err("FWU metadata version %u. Expected value of %u\n",
> -			mdata->version, FWU_MDATA_VERSION);
> -		return -EINVAL;
> -	}
> -
> -	if (!mdata->desc_offset) {
> -		log_err("No image information provided with the Metadata. ");
> -		log_err("Image information expected in the metadata\n");
> -		return -EINVAL;
> -	}
> -
> -	if (mdata->desc_offset != 0x20) {
> -		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
> -			mdata->desc_offset);
> -		return -EINVAL;
> -	}
> -
>   	num_banks = fwu_get_fw_desc(mdata)->num_banks;
>   	num_images = fwu_get_fw_desc(mdata)->num_images;
>   
> @@ -238,6 +220,24 @@ int fwu_init(void)
>   		return ret;
>   	}
>   
> +	if (mdata.version != FWU_MDATA_VERSION) {
> +		log_err("FWU metadata version %u. Expected value of %u\n",
> +			mdata.version, FWU_MDATA_VERSION);
> +		return -EINVAL;
> +	}
> +
> +	if (!mdata.desc_offset) {
> +		log_err("No image information provided with the Metadata. ");
> +		log_err("Image information expected in the metadata\n");
> +		return -EINVAL;
> +	}

nit:
One more thing here. You are doing this just to report that desc_offset is not 0
and below it is equal to 0x20. I think you can check directly that it is 0x20.

M
