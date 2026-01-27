Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3157D25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 08:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C0883F9D;
	Tue, 27 Jan 2026 09:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uec9oAuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D511383FBE; Tue, 27 Jan 2026 09:03:07 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F99483F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6JmqXJ2M9hAGcAq361NrrQ9VSvss01MSMb26C6ba92mym6QduXB0XMamBa5ErEi/Sb9dZhqLHD0npVUofKENzVBClolZkIKJdmPW49KIZJDSV/IZzZpyjGGpAarFkJOfe9nu6RWmVdO5DzMp4fEtGNK/JKS+1xHnk4Yc/HU45nK2GxwnYgNcNMR+pRi/IJdXDLmFAVv1+WUCWRe29SeQae7CsfPnEhXmo0eYDOeaoPHYaqncFQGnv0bB5+2NFA2Y88+JkAH4uBNXUykAprjp/eln99v1maY/RfU1LlurljypX8DEr/eEwhBYMKIiRntFKMzzZ+XbNSnI+LaEnd+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgueOph1l0aPz4ZEkHT1r9ljfI06lWINBTzGq7bzxD8=;
 b=DQqyOtiiw4cvzDqoCbmVIclCQf+WAOOm71LtV5AijUtW2pV/DExWpvl3q7NfL0rL6kEY1tIEqmejRvGjjYVUfliGno0GzP5bOfNzrC0TyDgwLNaJbGmO1l0pWbrpGrX8yEIP65YnHB9EH4Cgujd/3GLLpa2VICA+1z2J+xSm9RcIDMD1ccCAizNIuiJDTcWMQJQSqmJhT2En9+W6hUX+RPvaR0vDQk3dSTOF6ypN6He6i04Ub6c9+Tol3fRwsYR1itd2LgnyArG0j6VX6J/FUBCvm+hJBKLb5kqwNJN0L7TaXp4BnT3WRtBXx7b0DpjTtlN2VOoBnzXcjFPG88n0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgueOph1l0aPz4ZEkHT1r9ljfI06lWINBTzGq7bzxD8=;
 b=uec9oAuFhptYatY3vATrcjF2yK530hB71CrQ4plPHvbtHFLgmmZtbPPYi7pMPSsxmwHe9/WYEE9zbBNqGqrWNeMOvQWuqCuyadszcOHX4XkYjCCqTsnzkAO/0Th+asKKXuO0mdmhhQ86YF8wMNeAUScXfLGLwnaYJvcuuz3kHebUyYb0+S0HnzFMfHwHatnwO6qcVjS270Vhf7foANqwS6CW1eFk47vb4e7nTAIfW/1edsE+GRwCysoq24XlthfSc8U+XIlq2e8CJYIqH/e0xWweMq4p6YMUGFQtfXaip8VaUv57hdNF9mGUdZvhlVg+42tIdhs/OxOPJEg9hNVrqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB4968.namprd03.prod.outlook.com (2603:10b6:a03:1ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 08:03:02 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 08:03:02 +0000
Message-ID: <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
Date: Tue, 27 Jan 2026 16:02:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a937a-4d35-4445-81fb-08de5d7a7e16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnJreTluM2txN0JNMmV0d0p3Zmh3L2VOQmlxK0FXMFUvKy96ajNiL2w2aFk4?=
 =?utf-8?B?TU4yMnc3NzZ2QVdOUzlnVDQ1bmRQdkcyNEx3TGxxcks5UjJuS2krRDc5eWtK?=
 =?utf-8?B?YU5kMjFsclhvckJRRkhDSTB6ZXpLME5WR3FSdUhnK3JaNSsxUk80akV6eDMy?=
 =?utf-8?B?bldXYUxMbmc0Ym1udTdMTGYxN3R5bHl5M2pONjA3YVg4SVJNOFVvTGxTRVV2?=
 =?utf-8?B?ZmkrcXU2ZVZsbWNncEtxSVRnbkwrN2lrVTJ4TEZDUXQzMEVZeHk0MFROTHhu?=
 =?utf-8?B?cDFiK3lMUmhXc3pkL2ZhR2NmY0pIcU1Ja0l1UFA2QTJLTlpwTDEvRXdEdE42?=
 =?utf-8?B?bTNoY3M0L3JKL1ljSElYVGNqaEJGODVlTFBCSW9oVFpPNFQwamtCVmY0Mmp4?=
 =?utf-8?B?TURCSXJsUnJxVmdydUJvNGk4RnlpK2l2dlhjTW4rR2xWUVdEdkRVcXhWTDh1?=
 =?utf-8?B?NTJKcWg3QVBidkFER09mWEJqWlhFV1hNR2Y4UWRWSVlYTXRGMi8vWmRVSklr?=
 =?utf-8?B?L0VRVWlxL3NwSC9YMHhUZDZPaVJEOEtKVXlIa24wdXhyOGRGaUJXSHZySDE4?=
 =?utf-8?B?ZEhOSGFkZGJlOTJoVTZ3R0p0Q2tHSDNDM3ZjenBIdnVtZ28rVFRnZGNCYWtE?=
 =?utf-8?B?RFFRS3BpeFlJS0tqRlg1WUp2dGRZT25ORWp5eTZtRzl2Z3FyM0U2ZXg4ZDVU?=
 =?utf-8?B?b1BZUUNHU25oZGpaRWhiNEpHSERJVDdmbk5QU1hDaEpOSU1hY0JIdFBYUGNa?=
 =?utf-8?B?OFhnQlkvdnFiUjJjZmtnVnhxb3dWUXFta21sT0VWMkNJOGJiUWZYc0FZNTho?=
 =?utf-8?B?ZXpxWTcyV25KdlB1dUtKRjRIay9qeVV0bWVVcDUzcG9vRmJUY1lHS3FDRGx1?=
 =?utf-8?B?bWxQQ3VCcmg4VU1qejRZWllobzFnRlBMVTgwRk51UThSbVRtQTlSUERIanIr?=
 =?utf-8?B?eEh6YndiNGFlMHE3Tm5lZkZUQnN1a3lvbHFtaTVGSlphSzRJRnAvamRkbDRU?=
 =?utf-8?B?ODNMZXJSTW1nQmxJb1dkUUw1SXcrRjhhL0IvRkZEUFc1WE4rQkRDZE9ibTJG?=
 =?utf-8?B?S1R5RmE1eFlUb296YVBHdFVNVFdmbk5xZHBBR3VvQ0VxOGFrMG1pcjBWaHE1?=
 =?utf-8?B?MWVjQlNCWmFlUjdsRUpMa3V5NldJMTZpTVlpUWthM2tKK2ltQnIyQUcxMXdM?=
 =?utf-8?B?WnJTWDJHUFlKMlJqWlVCRXZlK0Z1Zks5NUxxNHM2NFE3MmE1NmJSeDNrRHVi?=
 =?utf-8?B?c2hJcEkxaTg1OENnaFkyUmtRK09vVWNhNVZjMDRGem00ZSsrS29odnRKWEhv?=
 =?utf-8?B?VEVKcWxWaTA3c3Z0ZkVmUmV3OVgxbDUxSW5vZkVWT2hBK1pFOE0wK2JiazJL?=
 =?utf-8?B?cFFONGRxQ3Q2MGdZK0tLMVdLaFlIZnhJN0tPRGhxeVp6eGZqNFFUdUpHU1VU?=
 =?utf-8?B?NzZkQ0xQRVRzekNmc1Vqb0d2OUxxbE1TRk1OYlVOdkxhS1U0cElKTklOUUEw?=
 =?utf-8?B?VTlKMGUzY2U0MnRkejRRSXE2cE1hNmxMTUdQSkxYN0IzSjU3OS91dkM2Y3B2?=
 =?utf-8?B?UU9OTENkK2RxK1NwVmhnUHlxdjBDTzFrNjNtSjNLOWhuTEtGWXVXWHVsTW1Z?=
 =?utf-8?B?M0VseVUxc3ZIMnJTQWk0MkpxbzZUVkltVUlUY21UYWpJNmRWZlN5dEpXRGM3?=
 =?utf-8?B?RmNWaG55dHRyUFVtWVU0ZGZCWk5NZDluZGpqNkxrdjRZaWh2WkhPNW1CK3Ey?=
 =?utf-8?B?eEYrNjZNSnhrSFJvL05nUE5Ea3g2Z1h6SXFBenlkY0hsVlkrL2s5RHFpRHhB?=
 =?utf-8?B?QS9VN1JiditSWlBHVlJ4QVBPZHZ5RkZZd3kwTkZnOEF0UlNKS1B4WnlZY0RY?=
 =?utf-8?B?ZXFwSEc2MmR2dnFWS20yak5OVmVIZklFaTBzRjR1bmF6LzFpK2FzV0tHRjZJ?=
 =?utf-8?B?Sm9WUWttWGpYRnlzYUNVL0FlTUJjQ1FaS2xsQXZMdTFkNlNRd2hkYUg5Q3dr?=
 =?utf-8?B?aHp6R2Vsa1kxYUh2ZldCWWh6NlVjVEFkbWlBY0lCUWdrOGlPSk4wUGRPSGd4?=
 =?utf-8?B?ZFA0TDdGR2F2bXNiSURaT1FOMWZ5MkZjWStOVW9aZDRiczZsTldKNmtYSHMx?=
 =?utf-8?Q?WAN4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tBcVQzdTJIazBkZEUvc0ZUOHpZa1RLSEFNZG8xaXRVSDRLc29WWWovazJk?=
 =?utf-8?B?dzFhd0VyZmwzMUd3SkM1MXBBWmE2MDUxNGoyL2hxMDRiVVd4UkoxdG5TOEFi?=
 =?utf-8?B?d2REUTVpUmpOT29kNDJhM0ZkRXJlQjFvWGVwb09qVDEvOWh2WEcrUUZLK05O?=
 =?utf-8?B?aldFZVpseVhJSWQ5TTA0cDhzd1BFNnJDRTVqRWRWZ1diRm4zdE9EUFFKMnQ2?=
 =?utf-8?B?NjNCY0gzMjV2QWNNL3MzTTd1WVBlRDZlS3hOZWs4WFlqbmthVFFaV0lTL3l6?=
 =?utf-8?B?V1ZETHJRR2hINVc4Znd1YVRtQnZxZkx5a1h0NDhlSUJ4bVVKN2NBR3d2NUh0?=
 =?utf-8?B?M29LMFIvb2lGWkVKYmVseWxzakdFTmx4REVqM2NTMndNR2pSLzh3NENQQWFJ?=
 =?utf-8?B?RGRsd2hUVjNKdmJ4eC9yWmE4K0RFT09zV3lHQ28zTU1tNENSZGdNMzRYcmtB?=
 =?utf-8?B?T0NycUFDUEI2OC9WZllZL1FreHlrbWhva3RlcWxiR25TZ0ZJMUtZTUJ5S3NK?=
 =?utf-8?B?ZVo3RUNjT0VtbThqVTZNQTE3ODdoaS9GUWxWOEo5K0xFUzkxOVl6dk4xMjlE?=
 =?utf-8?B?VkN5bllsWk5mMnZkeXNmVFFhbTAwQ2IvUDlBVGt4eEovcGphYldvQjYyd25a?=
 =?utf-8?B?STB3b2I5cUczZFh5d1R4d0ZTTTY1dGxmMHlyczFmdno3c2VRdHRxZEJicDQ5?=
 =?utf-8?B?MVBNY1Fxd0M4TDluR2pwUFlqSiswQTM4SUR2VUNsZ2pXZDRYYXV3NjRBTUZS?=
 =?utf-8?B?amJpVVpjYlRoRVBkejIrUjZnOHdOUHBWTEo3bU1rckF5NW1PdHlDL0FObVpn?=
 =?utf-8?B?V1hXSnp2N3BMUG9hVGxYN2JqZVNQN00xbmhFNzVBTEl4T1UxWmZzdjBiamdF?=
 =?utf-8?B?NjNDYjg1VVFEbnhDVUdnSG9YWFBFQ0cva1creUtGbktBSkMvVmZieFBtL0NB?=
 =?utf-8?B?SFNBd0syUEpOTWU4QzR0VnBGNDloQXFQZjdVVjMrdWZkSDZUUS9xUGplajZE?=
 =?utf-8?B?TnNsRXRrVEZ2bk5kY0l4M1NWaTRTQndpOWJtR0l3L2kxU1FrY0VrcDRFTlhl?=
 =?utf-8?B?dUpyc2gveHJIZU9nRHhYRWtTVVFqWUxNQ05FcnRHUE03TTk2c2pMeXRrcGpV?=
 =?utf-8?B?UTk2TlYyMGlEMHp1d1U4Q0M0aHE0eUcxdGZrN3lZS0JYTGJMYXhHQnYzY2t3?=
 =?utf-8?B?YmlWcGxOKzlweEFON016YklYM0VWdDZ5UCtOZmJORU5STzQ2OEovRDVKbXUw?=
 =?utf-8?B?Mi94OWZaalNkdHZLbVVIZnRRelZKZzFpZ0ZkTkhLd21hZkV1eXRoUDBBRnhF?=
 =?utf-8?B?Z1E3RjRuZ1dNZ3R2UFB6YjFmZG9YVVV1dTVLbDZ2T2tSSzVZS0RHMUtaWlVT?=
 =?utf-8?B?YUxxdEFwWUU1ODZhT1dMNHBGYlZYc05vQ0c5VndwTEpyR2hZdkZhajZoUHJq?=
 =?utf-8?B?aUVEYU5lOGVoTUZFK0laK2Q0RHpIY255U3gwdWlIbU92U1JIUlVzMG5kRE5v?=
 =?utf-8?B?TEpNOFI0bmx5bGI5RUdZWEEvZ1c4dmlRQlN1anhtbFFESFgycnEwQkZDNWt0?=
 =?utf-8?B?R3ZQb3I0V2t4NE9qR3pYRmp6bFU3YlhCTUhDS3RML3RqclBWRHhETStHcjk0?=
 =?utf-8?B?TkNXUnorT2JLL3hYMTIzSlRYbVpWLzVLa3B0N1llSDRia25sOVo4a0hkdG5M?=
 =?utf-8?B?WTE5UXJhOTJiZWFaWVpsdGR2RDNJTGRITUJENFZCTCtKbmt6cWgveUhPbjZw?=
 =?utf-8?B?V1p4ZGd0dG03Ry9wdGc1M0xvbWRPYnRzSWl4TzF4di9hOUJadWVLcUgxT01F?=
 =?utf-8?B?T2lCZUdtblZ0cVlYdmtkK043U0ZSaHNpVGN1bVJYelRFTS9BTWlndnd6akV2?=
 =?utf-8?B?WU1hNVhUaE1ISXRnSDVXV2VUdHh1aGVORFRjOVRtN3RpYjhrcmlNZEU4bFdV?=
 =?utf-8?B?UjZvbC9kT21wNVJiQy85ZjRYWXY0emtVVmhrUHdGdjRJcXlKaysxcDVaZHRk?=
 =?utf-8?B?YnZ4VE1sSHJnM0dUNnIxRDJJOFZaRHFTckdNRThkbzJ0NGVZVW1hdDd2Vm9W?=
 =?utf-8?B?RFEwTUs5MnNoN2tLa3JSczJpRzNXVWgzNERWOTF0a0x4bXNrL2JVT1NvV09y?=
 =?utf-8?B?U1hGOXVKdXZ1blhHTjh2WUcxWGJNenQ1ZW5jb1RGS2QrN0lQck55eElvZ051?=
 =?utf-8?B?cVA4RmRjZDdMSU5XcytTNzlyTU5QcVM5OWtPN2dFcFlzTlFpeUpqa0xnQ1BS?=
 =?utf-8?B?ZlZBaVY1N2hiY0JFZlZpdk5HRTA5ZTI5cnhCSDZ1Q0wwcHZtNFdaV1lYK2t0?=
 =?utf-8?B?Yy9icVpGdzNoVzA2S0RKLzI1T0ZiSjNBRjZtZnowRGUvcVNXZ2ZuL2tHY1Ft?=
 =?utf-8?Q?Q6AL/WwVI/2QW0wU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a937a-4d35-4445-81fb-08de5d7a7e16
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:03:01.9727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdBhEFp/4hRVPsCVNMGkQA5x4vYUXsKam0lBnVxik1wm/hvEjxQhylz455tcm+AIf9zooWV1+BpAH9MGu8g8+PBvDZ8KCHG0GSroSi7oDkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4968
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


On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardware.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> get_ram_size() uses size from device tree. So, it has consistency with
> other device families.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 7a0a043557b..d5892850da7 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -6,6 +6,7 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> +#include <hang.h>
>   #include <init.h>
>   #include <log.h>
>   #include <ram.h>
> @@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> +	/* setup the dram info within bd */
> +	dram_init_banksize();
> +
> +	if (sdram_size != gd->bd->bi_dram[0].size) {
> +		printf("DDR: Warning: DRAM size from device tree (%d MiB)\n",
> +		       (u32)(gd->bd->bi_dram[0].size >> 20));
> +		printf(" mismatch with hardware (%d MiB).\n",
> +		       (u32)(sdram_size >> 20));
> +	}
> +
> +	if (gd->bd->bi_dram[0].size > sdram_size) {
> +		printf("DDR: Error: DRAM size from device tree is greater\n");
> +		printf(" than hardware size.\n");
> +		hang();
> +	}
> +
>   	if (sdram_is_ecc_enabled(sdr_ctrl)) {
>   		/* Must set USEECCASDATA to 0 if ECC is enabled */
>   		clrbits_le32(&sdr_ctrl->static_cfg,
> @@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	}
>   
>   	/* Sanity check ensure correct SDRAM size specified */
> -	if (get_ram_size(0, sdram_size) != sdram_size) {
> +	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
> +			 gd->bd->bi_dram[0].size) {
>   		puts("SDRAM size check failed!\n");
>   		goto failed;
>   	}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

