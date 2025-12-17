Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6F8D64083
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B35883979;
	Wed, 17 Dec 2025 08:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TanUAIXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124FD839FA; Wed, 17 Dec 2025 08:02:52 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C0883623
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYeerhPqUPB8vFcoUrY3Mh576JchOy2JNVocLIKlng/gy/E3oATrlPFl+1iSJujDxUvco2DZhaiAQ1naG+yNSt+7zu8w7wvnkXSp+VMt5AvLfMdU6wIpmS22mburDPfCkT5OXENQqbVgYy0MWIp9xeQYyRxwJ3GWDBXuX76Fl/8OrBjRx8m4UDCup8uYMKl7ewVQicO83udM25GfwkEiJyUjWGHYtQ4WKmIojUhVu3zV/Dkj/crozZNtRhFO3DVN3mVvTVKBsyWQUE7PTeyQL9a47dXP0I+8qFZuTbu+fdELiGbJPn14YXBiaFiYOzJv1kmpev8rLblnSzFGWhYuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRocZUAsuFIYA20yWq75CrTUQv+S9BxCR/ysRdtv3kI=;
 b=clNISb7qM0qZqCGvuqTtSMibw7M9h02egaeetDrLUhgeg9VDmXXU/5kLAvqpFXHJjv/587z1Z0Rhdzw1ji5CLMgL2gwh26pS3AojS8fD6eRImVgL31ZVjRJlBxrz16Yy4mBWwbZ69ZE4Gv9H7UZMhoeReTSZs7f9FUvi7vZQx/ZRWNu2xcBxAGuMOCIbp68Lm5ILJgr5c6Dfda7zX7WJidL3/HfNTl0PAFaP7qAi1DeXnvMqajFg3CrWC2xp18qcS1o1g4IvSvaJvwPxB0mH4ON/Do9uFc44pK4hGhy+ZvrDy7JLxLH0s/GHCGQ+L/5KS3Eg9OXU+YLfEHvsCf37Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRocZUAsuFIYA20yWq75CrTUQv+S9BxCR/ysRdtv3kI=;
 b=TanUAIXYxeBqfqjDiL1CboT6b/Eodl4QMR+lz4jbZhK1DGpjmctU55QeuaRX9GBaMWKai8nDeF6GYogT3R5LGT+6PN1cpNgjAVGb5MDFVJyU0jjO/7tp5gChHBPZLRse8R1iE/bJFX7CisK2DlE1jbqkD9ZQfdct+BtZEpg0wk0uoX4Af4lUAVRpHSHnNo4agfAWT8bUWRxrzZ9c8xNrVKZ7wxbnJ+btiO3xJa+AHlJJ/CrNb9bNk2M3PVGDDBwpbwjAsKWiOBlo0PFEw+8lcVZojncbeauJwW+E42w6o1ha/4GrsVfmdB5UPhkgefVNW+WF2zv1gq7e6up6pTVptw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN6PR03MB7624.namprd03.prod.outlook.com (2603:10b6:208:4fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:02:46 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:02:46 +0000
Message-ID: <2c8a138b-29d9-4c6e-97e2-e9b373893025@altera.com>
Date: Wed, 17 Dec 2025 15:02:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] Revert "arch: arm: dts: agilex5: Set SDIO_SEL GPIO
 pin as output"
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
 <20251215110117.19371-2-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251215110117.19371-2-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN6PR03MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c606bad-2df7-4bba-7813-08de3d3a47dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em9Nd3NrRnh0VFRuUFZOMW1yeVprL1dUWTduM2dlUG5BRU53c0J2dnQ0a3lY?=
 =?utf-8?B?L2dPRFVCeUpVbGFZOXVpdkxYb24weVBiZmd4RXNsdWorMjBCNXkxR2lSL3lX?=
 =?utf-8?B?WGRVL0JkWUJyaGZXS3hpLzdOTi9jOW92RGtmakg0VVdUMk1zYUJnRUM0dXN3?=
 =?utf-8?B?bncrTEV5ejRDSnlHQnVWV1FOUUR5Mk5JMExBTUVjR2tTVTRvZi9kNkZzaVlp?=
 =?utf-8?B?VXFNdFQrcXJkNmEvZHQvL1VUdzdCTjlYakM2S0YvSHZ1Vm16M05kUUp0bTI3?=
 =?utf-8?B?NURYbm9QQ1huWWdLck8wVjhnSVdtRlpCRTkvWURWYWpoUE5HSkhKeGNodUlL?=
 =?utf-8?B?RTFOeTV0eFNWZWJEeUl0ck9LVzNzelhiUDFydXR0TklmWm1NYkdocU1HNURz?=
 =?utf-8?B?clFsYTZkTmlwS0lYaTVKNWhJSXVkVkVPam5aM1BwTlVHaEdZTzlwU1JlZmNC?=
 =?utf-8?B?aGt0VFNVZzhuOFlsZm1xcmxRN01wbkxROEVkZUMyTFRTVHJVRWpiVjFDazNr?=
 =?utf-8?B?TUZwakMrd3RCL0RRMThlRUdBN1NUUUpmeXJJQVJGTXJYdXYrK1lWUjdKcWVT?=
 =?utf-8?B?R2dvNXQwQnB6QVlKa1NvaWZjOUtublFrZUhnWnpaMTJaVGJ0T0FaUXVlN2dS?=
 =?utf-8?B?dFYwSjdlOVRaUUc4WDNCTjdoMU9xRGxsTG9oaGhmSU9tREhLQmwzbGYvN1NF?=
 =?utf-8?B?dGRnbjBOVW0wai9OR1VEMHNlZlJ4T2lHTVFDSm5mWUwxY0pHVXRFUUxrSkdH?=
 =?utf-8?B?SnE2Y0tzOTJqY1NaQTdWektQUVg5ejFlSEdYR0JjbG9mS1RTT2psODFQaHFy?=
 =?utf-8?B?Unh4a0tsN0VwbzhJdjN2MmRNcGR0SGUvbDlCdUFVekNjb3R6ekgvVWwrNHZM?=
 =?utf-8?B?dEJSUFFYK3laU2hMNHJRSjZuNDFZRkxUU1JWNXdScDRxM3dpRmQ4MThONDdN?=
 =?utf-8?B?bmFqck8zVlptS2JHb09oNlR1NUFaU3pXMTd5UXRjc3c2eUpGUlpmVnRNOThu?=
 =?utf-8?B?cTB6MENFM1o0S09DOFd1aDR3cmZ1TEJJSjA1TmVsUG1QYit6S3ZCcnlFMGth?=
 =?utf-8?B?Z25nNkZGWUFYa3I2T1htQThBT3ZTallHckNyYmwvQ0tEc0hWOUpPL2tvY3ZL?=
 =?utf-8?B?OU5YQU0zbTg5NTh2Yi9hWGl3TXY1MkoweHEzOWVidUl3QzZtckliOHdIcVhZ?=
 =?utf-8?B?dGFlbk5PTU5rSFlBN1VCR0l1QUVRVEF6U1ZUMFNBT2V2dks0T3RXNnRWaWFq?=
 =?utf-8?B?SitOMnhXK2RNemQ5RmRKZXpPMzJmdmRzZUFoS2o0OWYvNWt5a3dNcnlzaDN1?=
 =?utf-8?B?aFJqNWF0TFo5SXQxR2NiVFZjU2JWNTJnUnJNZDRlVmoyQmY1S2Y1OU1LL3BY?=
 =?utf-8?B?b0VUSWo0ZXBGV1VkNk1UV08yalIrRGYyc1djUGltcWVndFE4eFBYbjRnUzNM?=
 =?utf-8?B?Q3V0N3Uva3BpNkJnMnJ5RWtqaEZXZC9MS2JkTUVRb2Q0Z2dPM2lTVXV3SzR6?=
 =?utf-8?B?U2Uyc2dCQmdWZU1DYlRSOEp6ZVhUbnl2Z3QyTXBRSGlqcENPWWNyTEZXMGti?=
 =?utf-8?B?OWVYNW1vSzg0UkhzOThzS01sSm00bnhxQlhCSlpFZUdTdjNTeU5jOEtoSmFB?=
 =?utf-8?B?bGgvSkpkWlZ0bFVteDFncmFnSlJFT0NYRUllS005dmpKYWdJMUhUVU5iZHBO?=
 =?utf-8?B?eGpPM1pNTjhIeHd3ODdWTkF1TGtSQWJ1bUh2QXVQVFBpYWFmL0ZnSWNodjNY?=
 =?utf-8?B?Q1B2VzlpU3FpREh3eVBpRFN6YjBmZkFvRVlHa1JuS3JvU0hlL2VFRWE5RXlp?=
 =?utf-8?B?YVJvckR2bVZRWlJHaGZHTkIrOFFrcHBzeDAxYUVmVnBRWHBKcHRsL0hIOGNM?=
 =?utf-8?B?VnpBaUdDRTVrWmdQUWkxeFJBQzFTZjJ3dDNwY2JPVjlOZXZDVjZPTm1ONXFG?=
 =?utf-8?Q?4LyL9mUhXl9GfMOjdRNzrDJz9ve9HhdE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29tTzFjdURjU3JNUmpkZjBxNlZoRTVQS3JuYWdCNzVhWDA5ZTVoYXB4NWs0?=
 =?utf-8?B?cFRGenpVNGRQSExQWmF2N2ZZR1lIcjVUNHVqQy9id1BYeUtyUGhOZnIvZCtG?=
 =?utf-8?B?ZkxsQXphTk4zTVJ2S0phTDAvMit5Rm52WmRJUU1rdU5ZbEVaTk5GK3V0dy9X?=
 =?utf-8?B?R0owd1l1VkplVG4xTUhheEo1VmNDR0lkcWpxWXB1N0lpL3JSN3prQTJxcVhQ?=
 =?utf-8?B?MmtManYxekFsT1Y3LzU5UzYzM3g3aDVzbitlK2VoUDV5RjJVdzRQZFNzYkRX?=
 =?utf-8?B?Yzd1bldTbEJycklvVlpOL2src3d5K29oMnR5Y3lXdzgwUFJraWkvZUE4eGRo?=
 =?utf-8?B?TXlaYktUaEVFRkxqV2tCbVNmak9rMDdYRUpyQ3g1RkdtVk1YN0FTRWFwOGIr?=
 =?utf-8?B?OWl6Um52dGxVNEdhYjEvdFhobm9WS2tZbEIzRDlIQmhOMXlpaEFmT2kwc0Na?=
 =?utf-8?B?Q1BiSnkxWkt6YkVWRUxOVVlpREs1R2k5em1ZeGNsblo4a0RwRXJLTFdXRDd5?=
 =?utf-8?B?RjUyR1B3L0xNRU51QkRNRkg5V1B1ckw0bGlXcXdXUjFoQ29jMDlzNkpMb1BU?=
 =?utf-8?B?RTlQVXBpd29lV2taOGw1bXdIekhXNkxmYUx6VmRHYk52THdDendFOVVGQnk1?=
 =?utf-8?B?LzFCaUtmMmtqT2pYR3B4K0thM0tpaGpoRGw3Nnh3Q3JzY0o5QXRnQ24wSUVI?=
 =?utf-8?B?RVVrNDNXaDBXN2hwWDdmWS9YaERycXQxdTltMkVmMm9XbGliRUFIVWJmYkw1?=
 =?utf-8?B?R2FWS1ZsakZJSWptenlZWndmZGZqMHNCNjVlVEdvb2tCNFNZbDFVc1NOcFlN?=
 =?utf-8?B?ZFFSUHI4L1Y0R3BVaERrZ0I4MWNJT3pPNTVnUzhJYWJkeDN3SGJZZEwrS3FR?=
 =?utf-8?B?cWlsSnVITUFtcU1ld1BTaGt5ZmxjNFZXbWRRS1VVZy9iZjgwT1lRaUp2Skdh?=
 =?utf-8?B?RG1Vc0NHZElHR083QmF0Ym5BYzFnV0V0UkRDbE1yZllpa0Y1eHdvRzQ5WW4w?=
 =?utf-8?B?TkZOQjdSVFpEd3dhUnRZQzJRWG9sV1ByWnZ5WGQ2WHlJUzZZWS8xbVZFMG5v?=
 =?utf-8?B?b1ZrSndIdEtOWEE5TUd1SHlVazBrdFdSazdCRnpuSXRwK0liM3BJRnM0Vmtn?=
 =?utf-8?B?b1o2cVhta1cvMVJaOElIREtGR09wS1pPcEJRL1A5NVRHbmdKSVE1M2diOGJJ?=
 =?utf-8?B?V1VwOFd0dlpPZjNzb1hGUXFqTFU1Qk5DSnlKNUR0V09sT1JCRnRkS2h2eFJL?=
 =?utf-8?B?YTZmbmFBc0pHWVU0Sk11UlVMekI2Rm13a2o2KzhDc0NEc0REY1cvMVJERDVG?=
 =?utf-8?B?L3FPd0FldTk2djNHT1pMZlYwQ0R6cVNGL2xyblh0eFZqa01DUkh5aDBicHFz?=
 =?utf-8?B?R3M5QVBzRldSMDlBcWxGRzdZeDRKZnBBK0dTZzNJVlpkNkYrbis5dENoR0JB?=
 =?utf-8?B?eWFQODlsZXlqS1ZLdXdxam1rdlNZOWlRSTBxUjgyY1J1MmFOU3dGcjloRzB0?=
 =?utf-8?B?bnNyc2oyM01yRmgvMjFOVk85NTVsbmdKVVgzMmNjamFvYmREWldCdXppL0Za?=
 =?utf-8?B?OGNlSGF0WldXdENHQ3NLa013aDFYdE0rV3dyOGR4WENLeUdiVGhkb3A0eFU2?=
 =?utf-8?B?RGcyL0VDSU1qN2JWWWJxUEk4aDBBMUtoakIzYlpiUWtCSGZKQ3VGaUM2VTZU?=
 =?utf-8?B?NktBdXNqTXhMYjdGVnM1RDNMQ3BFOHd4eGNjbDdxa3BFZFp5RWZRV24ya096?=
 =?utf-8?B?NWpxOCtjV1FiTVZtRnY0YlV4RHp6dW9CbzkzWG5sWmYzRWd3NSsvZmIxWFlr?=
 =?utf-8?B?WWd1elU2QmNiMnFUdGUzYXZLcnN1U2xHallGMDlRb1ZONVdSYURpTzBCakw5?=
 =?utf-8?B?a3lYYkpqY01ibGlNMkdETU9xckZGMUpkZ3dHTk5lZHRiaFJtL3lUYUx0dUxn?=
 =?utf-8?B?QmlkTTh5bUh6U2pUUWxYa0Q3QS9BVW5OTVlvTkpWNWRFZS9oVTdPUjB1ZFBz?=
 =?utf-8?B?VmliQjYvblNFVGtDaExSbVBFWmZyRXZVaHJoRHNvOExQWjk4MndiTHM0NzRZ?=
 =?utf-8?B?WWtzYlhRWDdNUWRub09iV0NkQXVuV2puQnhZOGFvam5TRVhhbSs4ZTM4Sk5D?=
 =?utf-8?B?eXNhTVlBSWRWNjRPdk95NWl3UU00U21HK3d1SUpNOHZ5V205RENrN0I0U0F3?=
 =?utf-8?B?QThBdkZTS0tQdzYraXQ5RHh5NXJTTXBySHMwV1R6WFRZSm5FZHB2VE5zczZK?=
 =?utf-8?B?dzVQMG5uS3ExL2g1Vk5VbTJ0bVQ0bmpBQUtyQW84elE3ZndCN2lHUStyVW9l?=
 =?utf-8?B?Vy9uSkRwcjRSR0pKYTUyVzcrakxiU1k0d1ArNmhyYmdMandmUUF6N0J1RUcr?=
 =?utf-8?Q?GIA3jZd3I0w2cPjE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c606bad-2df7-4bba-7813-08de3d3a47dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:02:46.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdQrJaUnBMBLleTWE6v2PyGnWL6ZvIwQ9jOE8L6kNI+7dCINyDJkzE79IGhHu0gRw0q7G8aJYvDA5Hq9ebmdmWU8T3DGuvCeW9Khj7Sy9Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7624
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


On 15/12/2025 7:01 pm, Tanmay Kathpalia wrote:
> Remove GPIO hog configuration for SDIO_SEL pin as it is now handled
> through the voltage regulator framework for SD ultra high speed mode
> support. The GPIO pin 3 on portb controller is used to control the
> level shifter for SD card I/O voltage switching.
>
> The regulator-based approach provides proper voltage switching control
> for UHS-I modes (SDR50, SDR104) while maintaining compatibility with
> the MMC subsystem's voltage switching protocols.
>
> This reverts commit b0dbc9fcb7dfb7522be25ee205997be2fb5e1bdc.
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 11 -----------
>   configs/socfpga_agilex5_defconfig        |  3 ---
>   2 files changed, 14 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index d51a9e2ff7f..35b198b79ef 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -681,17 +681,6 @@
>   	bootph-all;
>   };
>   
> -&gpio1 {
> -	/* Configure GPIO 1 pin 3 as output pin with value 0 during GPIO probe */
> -	portb: gpio-controller@0{
> -		sdio_sel {
> -			gpio-hog;
> -			gpios = <3 GPIO_ACTIVE_HIGH>;
> -			output-low;
> -		};
> -	};
> -};
> -
>   &i2c0 {
>   	reset-names = "i2c";
>   };
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index 64f2f1bf115..799ea910f03 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -2,7 +2,6 @@ CONFIG_ARM=y
>   CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x80200000
> -CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=3
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
> @@ -79,8 +78,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_ALTERA_SDRAM=y
> -CONFIG_GPIO_HOG=y
> -CONFIG_SPL_GPIO_HOG=y
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

