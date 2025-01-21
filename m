Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8687C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 15:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EE7801FB;
	Tue, 21 Jan 2025 16:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VmIlhoX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4F280283; Tue, 21 Jan 2025 16:41:07 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021A1801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 16:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPzawYtiWEgjJ17HAjLE9KaGDqyu3xG3xQXmp79P7iTYoVYC558hfifwlcHi6sKTSvkL4XC4IcAE+Y37SbCh0g8AFly6JWnka3fGdeZMSZxr/3muNRhG3f0jQLc4oJhPvGSuT3n+Lzf2BRPmDpSKQNEtbf+emxFrg7+E/Y8sya9vrggvuist/FQNFPjTmurG4ba9CqLUqmr5EBs4xoi7aTf3glauKoz86cQTg76xihypoxAvDkApglFqehUPrKYPJrsg3bR8bDe+ocI9m7HF9LyuAv6ARsdTgk465sFnAmrODEPUV38C6p4dAB4DgpRmzRsStS6yFcTTP2f5Op9psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD6wNcm170NEYiJb2VYiXxGsyeJdAlLMMByXJDcCbSM=;
 b=CB+vZezK260dgt+gViS5lLEhz4SzqTDqhtjWkK1wyvvdMSBOOwOqQhi8ZZazwxy5P2sZYTy31dk+lkcqUf5ZNQ4gR0E1mJN5NrtEXt1VeIB/En//2pdbU4KL6WIwOBwMt97KTzhcwKSw82T1oWUQaCewntXLyYkoP8LVewSUvSq0XeHyIp36EcIStuGCiPrMC03epsZq0z39TSqVF+2qHvsmQJgLp2HBfd6/3DeaHmc7AR0/oDvZnauSzj8/OuidE6yduIjK9+NkDn5laKRQexSDI5GrbKwziZJPgArJ5Pf7ecXgSIPc/WZXMDi3DLPjgY8Ms8mpsFQBUheB5l73TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD6wNcm170NEYiJb2VYiXxGsyeJdAlLMMByXJDcCbSM=;
 b=VmIlhoX+5sPXZirS07Jx2gkVS+nOD/ZGRt7eY/YLh7XYdPQh3865y5HPNeshIt4UwUvyt/6aHkW/X06Umg3PNuDxGCrsDjR9xckZRImcRzoptiItOywi8lg4SQCuzNY0vAuTMyn8AIxya8VOtzg4UgNNnEnEp9A8BR+k9mBOCOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 15:41:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:41:01 +0000
Message-ID: <d8037801-4d77-4f09-a973-c695b589414f@amd.com>
Date: Tue, 21 Jan 2025 16:40:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Replace Maximumm with Maximum in Kconfig symbol
 description
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Anurag Dutta <a-dutta@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250121153836.83878-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250121153836.83878-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb68b17-c194-4168-24b4-08dd3a3201b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG04Sk5hVzhnQVdINFhCVWlXZFQwajFIc3h1bUluQ1Y2aXp0Q3g3QWtnVWVP?=
 =?utf-8?B?SFR5TWpKbUlCajZwL3cvdC94Y0pjWEhFT2YvMCtwdmw5RUttdHh0d2MwVGk5?=
 =?utf-8?B?OEZHTnRqbWUvSUdhcStkdThSQVB6V2Y4UjF4eVUzWnA4Q3B3UjBTZ2FSYklH?=
 =?utf-8?B?YUFwcWVibnoyZ2pCU1d2d3NxNE1nWXUyWG5XMXpMbkNpT2FUSnJjekNWMEp4?=
 =?utf-8?B?MmYyRzEzRkMrQTlwc2pkbnJHdEYwaUowczJnTzR4RVZhZ3I0ZDJBak5kTm5M?=
 =?utf-8?B?T2oraHg3WEdZeWNMaWtUcTBzV2syaVdFK2xFZWdMUDJZalFJU2x1WGF3cy9y?=
 =?utf-8?B?YjVZWFNScGJWRHl4SDVQbnAwY2pGSDJCQVkyT1JDSTlqYlQrbkVwRlVBRWU5?=
 =?utf-8?B?b2xhbWkvY05PV0IyaVZNa0pmaGpkUFBodEVFbEJBazNzOUVSWk1iU3F0bjZQ?=
 =?utf-8?B?a1F0aHEzN0VVazVsK29oZWZNREZZTWRZRDFvR0QvK041UFhyU3RXcFhCUXk3?=
 =?utf-8?B?bEE0a2psdHhiR2tBb0ZFTUZUZmdHY2tyWVp4cXBtWEt0bkNiTTJzbEtwOTFp?=
 =?utf-8?B?ZnY5d1VPOTFWRm13d1dqSks2YnNTVld6MXJja21naE1IWkZzaVB0bEUvM3Yr?=
 =?utf-8?B?SlZvQWNPWndwSVJnNDBYRjlWVlNOQWNoaWZKNEtzM3lKZWpwWkxaT0FiR1JH?=
 =?utf-8?B?enpndVpjWG5CQ2dMQS9veEc0N1FodDFmYkx5dCtGN1lZWXg4b0RQRkN3Vlo0?=
 =?utf-8?B?dHRKdjVPanVjU2RCZk0wU0p6U0EyVVJGUldiU0hTVDBycnRDQW1JbEhMM3lF?=
 =?utf-8?B?dmtCQVVUVERnckV0OFgyVE56WWNocVB1dEVHWWJuSnFWWDUwTzRHcXFSVG1W?=
 =?utf-8?B?cTZQdkZuWlF4c0pySzMxRFVTUklMMG9jSW05VTBjWGpVWURvN0svWXl6RUtQ?=
 =?utf-8?B?elFtUHVuVnZ0SktGdElJS2lFQzNNODhXR1lrcVpNVXRKb2EwN3QzT3I3aTFz?=
 =?utf-8?B?UHZlZGNhU2ovc0c2Q3Q4SnQ3RHlXa2xGdGlGOUMvN21BcmQzR3FiQzRteWZB?=
 =?utf-8?B?d3pFRHVucHBXUXpvQWk1WUlEeHIxbFRMSlRQMWM1N2MzNmFNczNCOVU0bW0w?=
 =?utf-8?B?VVB4cmJobDdlV3pIT012UDBCbEhOb3dRNkNqQmd2Vi9RRURxSVhiQkM0eXo2?=
 =?utf-8?B?WDRvbWtMSldlYjIybSt5NjhhOTY0dllUK0dPRDdEZXl1SkQ3VDUxYVA1MFBi?=
 =?utf-8?B?TVhBRTRydElsNWFmYjJTV01SdFpYTW1pT3VLTG5IZFAza3dkRVR3b1UySWZk?=
 =?utf-8?B?a3lzOXFZcWg5dnhQRFpFWFRvNGpNUE9qSHZqazJtRzFxTUJiMHRkN0FlL2RQ?=
 =?utf-8?B?RkFJK1FBcjVBeXlPM0tLVVdKT2ZNdWo3cTZ5WUhsT1NsWGVtR2RvejVhYzRL?=
 =?utf-8?B?VlBieTIreXc3dnlJeWprRjVGZVpqQW9zTnpqT250ZWhhdUdYV2lJMjUwdFNy?=
 =?utf-8?B?U2lSRDE0dElrWFZpbFNqYXZReVRpbGZzWDBjVXRXOTJQdlpTODNQUEM5K1Ay?=
 =?utf-8?B?c1BxWGVrSVptMjU0Z2VCSFBBRmkzbGJNck9UZ0ZNUy9GcEhJR2NVUmhTVVhS?=
 =?utf-8?B?dndLQ20rbkE5QkJ5TmNuRFVwakdXYWV4Q2dJQ3Iwakh3UnVjOXVNdVRGUHZO?=
 =?utf-8?B?OHQ4T3FyQnFnSGYwSmo0MUp4U0kzSXRqLzUwN1k4bDcwSVM5d2dhcm5PVCs3?=
 =?utf-8?B?N2dUQ1VSNzVoS3lRbmJsQ2o1MVh4a2dweVFtSkh1QzVvU1VzOEc1SUJMZkNm?=
 =?utf-8?B?Y2JLRzFSd2Fvam1kS1FCK0hLSFFDbUQyT3dMOFN2UnFhakhyckoyM1lKclEw?=
 =?utf-8?Q?/Xz5r6Z7sYjvm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0x0Z0NIUGJjdmxsRlZKYlkwOHhGVnRwMHRZSmYvNjVLazdCdFpqZVB6UDFS?=
 =?utf-8?B?L1lwTlMvRUFTYmhlUkJkM1VBTE45NnBwdnNsU0E2MVYxc1pSTXhlS3ZrNlNX?=
 =?utf-8?B?ekEzT1ZMQ1luejJWVGhTYTZ5a2xmT0FkdWo4T1JTd3JVbHlkNHgyd1REUXZP?=
 =?utf-8?B?WkhRVEtlMmpBS2dFZVNUVUFUUW5vM2NkNXNQbVJ4Q2x1Q2xoS2NyU20xM2N5?=
 =?utf-8?B?QmxSdWRwdUpkS2FZb09nYjh6bXJucWRoWE9lVU5NWDA3Y3pES0hQS2NveFYx?=
 =?utf-8?B?VEF2ZUU4QlR4RGxvcXY3Y1I4MDVLWTdJTW5BMkJ4RXBHTkZQN2JuUVVoY1c1?=
 =?utf-8?B?VjlNWnBaVXZ0ekhZQmdJNGltM25MRUZMNlAxdXRQTk04L0RjSHp2THZJWW0r?=
 =?utf-8?B?cFlGcG1ZbkhTYTMwWTlDTi9IVXErdXlFdzVRV1U1VDkxR09GTmx6SUt6UjhW?=
 =?utf-8?B?MTM4d1NSRFJBbnVFNTY0Y1RTYnJjVWZ2WGJ0Y3JOaVhxNUgwT2VheUlaNnYx?=
 =?utf-8?B?OWlLamIzanR3SjJzdHg2OXBrNWpPVDgraUZlY0pGV3hadm5pK1Z0WUFRMUhl?=
 =?utf-8?B?c0l5MUxvK0g2UjVDMWZ5bFZYTVBMOWNQWEtEUmZGZVd3VXlIcUUwR3lTVVM1?=
 =?utf-8?B?cGZJTEJycm50YW9WU0Yzck5UcWVvTGpsMkJuamkzR0xHTGxNYTJBd1BZVXkr?=
 =?utf-8?B?VjdIZnZZTjBVWXJ2aHhta0p1MGMxN0NLS2dkNlRaeXBaeXZsNHZFZXliTnVq?=
 =?utf-8?B?UHRzNXdlQUdFb2R6M3p5d1BHRWllNk5tSUErOGxzK0k5ZExIWGFsNmptWk02?=
 =?utf-8?B?WEZZZXpsOU9Fb204Z2hndU9RYlZTTjhtK1k0MDhYc0FDYnBNNU5CUHowNzZE?=
 =?utf-8?B?TXBuNUhzNDFPSmQ2ci9Ld3pxQkUrbStvNW1uSEtEMEVHSlZEZkJuSDNNOTV6?=
 =?utf-8?B?N1V6STFoRWpXS1hVdEFVUjRnREpaV0hXcEsxQkVkN1BjRHRrT3piU21janYv?=
 =?utf-8?B?WXVoZERlQTBaZ1RPUHJuR0l1Q2w3TE95TVpuOGx5NncreG8rVVllaVdheXFQ?=
 =?utf-8?B?Rkx0MWk1OUVxTlBFRFVMWG52RmRWR1NrR2lOOHFKMEE2RlpvOFV5SVM1ZWIv?=
 =?utf-8?B?NUU3OHFkQzhyM3hKSDVGQTdPMGtSZ1h5QUN4Q1lsVUtHQXhtN0Z0WFdhdHAr?=
 =?utf-8?B?dHpiRW5ESW9oZi8zNE9ZRlViSVBrOFpQellodGVyM2xhcXEvK3daSytKWkRU?=
 =?utf-8?B?cmZ2THRYbmdUTjJBQjd6cjFXSGNoV0c2dU9HZ0RYZVdia1Qxdm95TVp3ZXQw?=
 =?utf-8?B?UVZOSkdFb1VyRE82UjBmTFV2aGJXUlJNd3BtT1cyeFlmUWQxR0hhdE5VQmRF?=
 =?utf-8?B?b1N4ZE9pT0c3VGhWa1Q4cFhrSmUvNFpaR3VIVkJEQjJVdGROR3JEeXphekZH?=
 =?utf-8?B?eDRxLys1QXFSa2QvMGIxTEN5Q1RJWS9mVkRWYkN2b3dUY3A1ZUw3RE1BbGJv?=
 =?utf-8?B?cldLdXFBUC9CZmRJTU1TM0gxVGJiN2xKd0lRRUJEUEMxbjA1eTFicDJsV2ZZ?=
 =?utf-8?B?bGk2ZGhyUkRlY3ZPZXo1cVoxbGVhcW0zczNxeTloVUdyMThMU1hiMmdLQ3Yx?=
 =?utf-8?B?NGo3cUpFNE5heFFUWjQyMDErTDREWGV6WUJSaXhNNDRGRDhhMEhLVGdkTmho?=
 =?utf-8?B?S3h3dGZhNlZIakR1VHhHSW1MZlV1bWg3OWhSbWRqR3ErWHh6TFIzZkpIOHls?=
 =?utf-8?B?RmV4SHhBQVhjbm1ELzFEQUpvak9RVVhtSXhZVE4xQ3ZQVHdPcUgwTW54TEVq?=
 =?utf-8?B?RFNCOXBvVXJmcVZMRHFKRjduV2JsTitva2szSEpxYkFFM3p2NUVDMSt6WnhW?=
 =?utf-8?B?dFZwZXZTSUZ3M0F6b1YwY1JVc3Y4SkJQanlsQW5CZ3IrTjZrSVFvR1BXcmo5?=
 =?utf-8?B?L3RoNjB6eUt2NmJhU0NOQ2FreDArTzdQL3JwVmY5TElxN05qUTBjL2ZZRE5N?=
 =?utf-8?B?d2dISXBNbTQveGdiRllTbkZvOVlhaUlzMndwVVFvQnNpZGZ0bXkvZXpacGhl?=
 =?utf-8?B?VENYeEFxeXR5VmQrOXduNENURngyTGNha3ZlcnFYVDZBYnNGWkxKc2MwUzdp?=
 =?utf-8?Q?9bxLVVFYAmIeTl5p8AsuqGOxW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb68b17-c194-4168-24b4-08dd3a3201b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:41:01.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juq2NeUnlEyzRScdVue28uEnA9EW38h1HnTOKb5TBb8CsGeL2tYTeBxoe/tvHoff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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



On 1/21/25 16:36, Marek Vasut wrote:
> Replace Maximumm with Maximum in Kconfig symbol description, fix a typo.
> No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anurag Dutta <a-dutta@ti.com>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/block/Kconfig | 2 +-
>   drivers/mtd/Kconfig   | 2 +-
>   env/Kconfig           | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index cc75bad02b8..750b0bd2082 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -147,7 +147,7 @@ config IDE
>   if IDE
>   
>   config SYS_IDE_MAXBUS
> -	hex "Maximumm number of IDE buses"
> +	hex "Maximum number of IDE buses"
>   	default 2
>   	help
>   	  This is the number of IDE buses provided by the board. Each one
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 185e8346213..2b7f5e5ed7b 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -216,7 +216,7 @@ config STM32_FLASH
>   	 STM32 MCU.
>   
>   config SYS_MAX_FLASH_SECT
> -	int "Maximumm number of sectors on a flash chip"
> +	int "Maximum number of sectors on a flash chip"
>   	depends on MTD_NOR_FLASH || FLASH_CFI_DRIVER
>   	default 512
>   
> diff --git a/env/Kconfig b/env/Kconfig
> index aaf0b1fe9ac..4438f0b392c 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -60,7 +60,7 @@ config ENV_MIN_ENTRIES
>   	  to store the environment settings.
>   
>   config ENV_MAX_ENTRIES
> -	int "Maximumm number of entries in the environment hashtable"
> +	int "Maximum number of entries in the environment hashtable"
>   	default 512
>   	help
>   	  Maximum number of entries in the hash table that is used internally

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
