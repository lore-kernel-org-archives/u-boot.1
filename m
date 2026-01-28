Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17484D35694
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 09:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7022D83CEA;
	Wed, 28 Jan 2026 10:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QFMuvY6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CBF583CEE; Wed, 28 Jan 2026 10:04:01 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC0183BC7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 10:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbZCYfslxobTEPR6u5PRKGk+RyxfXyUXbR1TuBBOPRIlsqiAmu7Pf72G3vVJmXi1DRAhpWFZTiAll9tUd8ae6y+RU3sDQNZlp4YWkKeUL6R3fYKObzI0v5an4fnaF8uSvyQ5NXAg/LzskBJh5d7u8UhpcpSV22RIeQc99Y1dS2+jjaXR4gkS6o0FktM8FjUglGXRZVKfRKul7J+MNPzEQXNmQkKIjA6qqKwkutqaYAFLghJ6020IEaKJIgdNdy4D96ltokbw/XBGOae1uLJ5QanWK9IEoR58r4czbvjosdgV4hX24OUE62Qk/1eOBeQgEi2epIJVpfN5RFmtYmEzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mUuLTfdhRZd+7zzvHVYoDeGXKmeABkI4PkLp0laJEQ=;
 b=SqPa5S8UKdP/X2eFYQQFw5S2Nbmg8l1zxzqItICi1TNwbjT6CQ1pfx/FCMIv81ZvdF0WBwvuRAqbQhA7NrkrCxz38Md4CSMYaP0axE17nGVWz7hBClg8e6oyev0Tb2gP2IqOsPcKngcnsZKJLIJy9wYZAD8Qh6gHma2NGLAL+RHonNtgvwVKgzYS4N85C6r6kbi7TAykcEKGPs4PvgGg4TaKW/ZOCPwXDTCW2ab52/y4V62A6UFusCXTqy8A/mfSU3pMHPbJUgBwGUaJiZjG5YgF55hzuaAZFMuCjFo0mEZnx/Md5ymTlOLjDZfJYGSAdJjaGb5T70az8YjAgZZOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mUuLTfdhRZd+7zzvHVYoDeGXKmeABkI4PkLp0laJEQ=;
 b=QFMuvY6FawaYpXTvSSGaF5NSgB003ZV8V1vtwWutKD+0ZZcdpYVqeivfySPngU5B7lmWWr1FjScyIzqM293UxDos0ueqLNekSX7gmhieSBYGp8FQF9grpq+v2ulCzqpoDYBphJmixhGi8CQAxDwQkUAVJXWynWdfxjO5Y7ZIG69u9Fox0phKw/jth2SbzglkRGtfcrzrJ+nDnBlhsp/ochZ1KDAhPxHxwmQbm5GpRUl6M0DuKMI0KHwt08dxP5l54C09NDAk8VOvVzplUBx/ZmYT+2hojA7xFLNOBp2jRucSMmnDtcTQ4sW2CFPP7RlKrSE3LGXi+S67pNpnzMrIxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW5PR03MB6984.namprd03.prod.outlook.com (2603:10b6:303:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 09:03:55 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 09:03:55 +0000
Message-ID: <e733fe96-e4e7-45b0-8ee6-318981a4f48c@altera.com>
Date: Wed, 28 Jan 2026 14:33:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode
 support
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
 <20260125202329.12738-4-tanmay.kathpalia@altera.com>
 <90244945-f90d-4589-92b9-787e0d3109b8@altera.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <90244945-f90d-4589-92b9-787e0d3109b8@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW5PR03MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: c8532d48-4b30-4afd-a356-08de5e4c2a18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVdjZ3NWMFp5S1NwTm1SbnNLTGtuL1E3dlpUbUJPU1ZLdHZrMXVZWUFTTlRB?=
 =?utf-8?B?dEU0QWthOVNOckZ4Tm11OEJnNXZrbWthQm4rZDVkai9vMXFJWDJrTkpVSEFr?=
 =?utf-8?B?dnVMd2xqV0dkVWNBQzFaTXR3YXVVRHMvejBmNm4yNmpZNXJJRGovcUhkRnA0?=
 =?utf-8?B?QlFCNjJ5RlZoR0lyN1grQjNPczBBRm5WbW5Pb3lCYlB4dFZGanRIUldtUXdj?=
 =?utf-8?B?dG1PcVFUMk9GTmpybk9zNk16ZFpaN1puaDNybW5CSFpyWWsxK21tUkZSbXFu?=
 =?utf-8?B?MXJBUERWcEljNDhMZHEwamhzYkxaYVIrMlREeERLbHNEZzk3N3BrVkRIeGZy?=
 =?utf-8?B?bnFTbCtROSsyN3NQY0dGR0lYV2hYRWJMaUhvS0R5ODJVYlNIT1JYQ3VObGVa?=
 =?utf-8?B?S05vWWtXbnlqMHBjSFpPei9mdzI4V0FTanJWbTdpRGFIeitVZE5Wem9xNW4v?=
 =?utf-8?B?MGlWZkxqb3JRRzlJN3UrSkFMTGVIQU43UldUbGhDb0JUd2c3ZGhjWGZtRU05?=
 =?utf-8?B?TEJYelNmMlA0YXQ3RUo5Y1BqY0RPV1NVdlVGbngzYzNsM2NaSFJibkRXV2dp?=
 =?utf-8?B?K3JXS0Y2R2lPTHl0cGdsSlNRWmdsN2FtSk5xK01TcU5IdldDT2dxTXRLdjJ5?=
 =?utf-8?B?KzQwY2h1TkFCcDk0YzdndSt2RGVBMXVOZW02c3lQc254MVBZVUczY2ZoZ0s2?=
 =?utf-8?B?cG5FMHFkQlZDLzR4Unk4WnlKMm1yVUNpdVprV2NpRkJzMVZ3VUJHTDBKUDky?=
 =?utf-8?B?VW5hem4yMXlaUWdGalJGWHM5OHIrQUpSbW0xdzB6TjhxSStkRFlreW1BdHRw?=
 =?utf-8?B?RFRQdFZDQmt3Yk1Nb1Vrcno4TnBRYzdDTzU3dXNOd09QOEtLbWlvTk5aNG5u?=
 =?utf-8?B?QjFmNkEySWoydmZkS2o3R0JpNk4yMmpiYjhQdnY1dlBDdm1qV25uTWlLdGQw?=
 =?utf-8?B?YWhiOGIyRVp4VHA5RGE5dzJoS1hnWnU4bzBhU0JEWW5NcGFBN3VwR2dIV1Bl?=
 =?utf-8?B?aUUrdjJRQ1QzWGpkdG83Q29kbW1YRFRyenVKaitKZ2JNbVZHLzhkcmFhOVNT?=
 =?utf-8?B?M1hiRGRMWXNFZDNFdEJ1UndhRWhjUTdPMUE5a1VVR3pDaDY1U2dvdk1naDlM?=
 =?utf-8?B?L1N2MEk1cTlRWGdHOFFvK1hXa09HTmpnRDJsTUh6YXVNUXpuMURQRkdGQVFp?=
 =?utf-8?B?ZCtnY0hpcHB5ZTFsMU1NM3VpY1RQS2RJdkRFVFQ2RjljMmFlK29MN3BON1ZD?=
 =?utf-8?B?a2ltRkJHQ2pxUWdvWDZSNERHUmdvNWIxekQ5WC9PdlR0QzhWc2tHWkVzRjNl?=
 =?utf-8?B?M2EyaVJzRjdBRUpNamRRRkx6RnRPNDBzRThHUEtCRTJjQXJOaVJub084N3JD?=
 =?utf-8?B?MjFoV0ZRUk5HZUJVanZ4OGZ3bFhndWFCZ3FEN0M4OUw1NGpBRlJ1dXBSY0Z2?=
 =?utf-8?B?aGZIekR3UGhTOE1sZkZObmE0cmo0dnp0a1NCeEZLaGsxeHU4L3NVQlk0NGJT?=
 =?utf-8?B?eEJLNnh6VGhFTU9TSG5wTHNvWjdlZE44S01LUk4zSnNNdFcrK0NJUDk5SEdR?=
 =?utf-8?B?b0VBWEVEOE5DQlVkc2dlMUVycU1EbE4xdFUwZ2lOMGZzVzMzdC9vZGY0R0ZF?=
 =?utf-8?B?bURjdTdMZ3VyamFRNzROVzNmcGdPZ0dDSVBsbXFUSlZUVjhnclJoUlBFMWdS?=
 =?utf-8?B?K0Ntd0lCT1lTVHBwWXd2cUtETlpnV3haaUNHNER3N3BmUHhZYkpKQjdRdENl?=
 =?utf-8?B?N3g0Q0hEU2cwWDZrS3BNbmR5RUZ3WTQ0ejhDL3NwZ1lSSlFTVXdxMFpkMkoz?=
 =?utf-8?B?bnp3MERldG9NN21qWVVxSEttdHBQWmhIdHJOeUdsaTd5YjU3WW9YeHVkb0lJ?=
 =?utf-8?B?Rm5LVUJza2JNVmdFZWRSbG5FS0ZDMDRXWFduNGIzSSswOGgySkpDY3YyUWIr?=
 =?utf-8?B?b1l0SVhLYVJmelY2Y1hNSzYzN0hFN1NSd3ViaVFLeCt4UmROdDgwaThTU2Yx?=
 =?utf-8?B?WitDajdTNENwbGI3NVFIOTBSSXpCMThkbm1sMjBoRUViTFZseUpEL3Y0V2tH?=
 =?utf-8?Q?rZjunQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm11TXJqazNIeFAyQ3Yvek5uVVBob0hqNnE5bkdvWjJLb0VpRDFpVmhBcE5q?=
 =?utf-8?B?YkplZ1ZYSk1KSTFaNFdjZUg1SU5JQWtUa2w4QkJ6L3hDb0dDZW9YM0RXQ0c2?=
 =?utf-8?B?TGF2enJOVTVMcENyTFFLQ0czSlMvNkRpc2VXUlo1SS9pTXROQmo2SmhJYi9a?=
 =?utf-8?B?bHJ4MWsyWm1adTA2RGdvWmxsRGQyR0J4Sm8vMFFJZGNOMTlNMytrSHUzZ3dO?=
 =?utf-8?B?UHJ2VGdnL1Jkb01XY3NoZ055LzR1R3pzS3Z5eGE0a3VZMWZTV0NxMUhseUFR?=
 =?utf-8?B?d2sybk5xTTBJQWZLWDBncERCblh2Rk01QWFQQWczZkdUcTVBMnJyTXdIcHk1?=
 =?utf-8?B?RXMxSy9USGVBdFM5bVVlUlB0bktkdnMvRVBmTTlaRkUrRG5EUXFYNlhUQTlp?=
 =?utf-8?B?aGh3R3Byamk1NW9pZkNRdjVZM2tMMld0VlBvSFBuaUZFUFpsUlUwRlZHVi94?=
 =?utf-8?B?dWs3enYwSzBpWEVjbENybTdrWFFKOEluMDhQUDVlbXFWSUdVZzFvRHo4aE5F?=
 =?utf-8?B?QmcyZFdSTXQ4YXpiNGZCRDhrZ3BVUk81cUNpVzRRQzAvT0k5aWZCQ0ltMFE1?=
 =?utf-8?B?WTJKM1ZaMW55dGM4U0ZDbEpLMG5OUlUvUXZLcG84RVRjQ0M1OGphVEE0aXE5?=
 =?utf-8?B?UVNWKzNrQnZpcGIxOE50N0pCWU5wMVg0NlFGeDNpcnkxdzFQcEJVblI0R3lP?=
 =?utf-8?B?SE9lak55U2M2UG9sQXpMWHhFOURYNnY2TmJjOFI1MTBzV0VRbDNYU0JYOXhE?=
 =?utf-8?B?bjJFVlcrOE9Ia0hPdVJrS3QwSGFuU01tQjM5dExpV0gvaTZCbUR3alNKZ1dW?=
 =?utf-8?B?czlTcFVUQkdhaG5tc2I3Vmg1bFkybEY4aFdQQmx0dGtmYUpYcnlvR3FoY3hl?=
 =?utf-8?B?Ykw2ejIvQUZTOEtjVG5vRTNFSUhIV1hCcklVTnJManhIL0loWVJsWUpBTEFz?=
 =?utf-8?B?ekdRcXBQaFBad2lraXBjeWU4V25PKzVDU21Mb295dzRTSjNIMGdrUjdVbjNt?=
 =?utf-8?B?MHRoelc0Szc3K1JSMk5qR3N0MWh1QW5LRjBJOEpEMWNBQk5iZVVMcTFSK0M5?=
 =?utf-8?B?WUZZb1BObEUvNk0vaGFzTHg4WW8yWlJhU3ZLRytnWDE4M1IyUmFxWVRxS1Ux?=
 =?utf-8?B?bHc5MkIrdDJLUjZod0Q3S3Q4RCtYaXFQUWdqR1BiSVFGTXJwSis1TktYOEhj?=
 =?utf-8?B?OVhPOUwzK0NjbnU2ZGNKYlhxSWJXU3hETUhvbjlvWEpacTRCTC9iQ0ZGYVpY?=
 =?utf-8?B?MjFNazBBbEd1R0hqWkN6eWdRQ0ZXMTdOOG5IdWIveEFHTjJzNGxiQThrYjA0?=
 =?utf-8?B?UnhTb0JCVUJsSmZvaGJCcVVDMEZhRkxsM05jd1JZRkFsblNqdXZGemc2M0Zi?=
 =?utf-8?B?c2s2ZWt4eDl2TkhqeFlLYmJrNFBXc3pLcmpKUEIzZHVMOVdzV0tXU2VnMGpR?=
 =?utf-8?B?TXNmcDBTbnUxRU9CRTcvdnFDS1RKVGZ5Q09DTHAxeHdpSWs5QjBHb21GdmNY?=
 =?utf-8?B?MzBVUS9tSGdLYzhMdk5vTXE1WXpzbWNTdGZqL0sxeCs1TUdzemNLdGdqWWxu?=
 =?utf-8?B?OTBYY2xZT0xybXQ1dmVHWm1YRDA3bFRVb3JCNS92OC9qaXBKeGZSMnNreWcx?=
 =?utf-8?B?NlFNakxLcFYyUEFBM3hzMzZuMHNnVjhyMGdvbGZiWVhYVFhhZVkwU0JwcUps?=
 =?utf-8?B?WHdxVXQyZ2NNVUMyMW5XTG9yWGpFTXZiUm5LZHdzTjdMSkhiMDdvZFd2eWFD?=
 =?utf-8?B?QTFqU1dHa3ZmQ0lEZUw3UVdESkJQdEsxSW0vQzduWVZzUmVGOG9FVE9oV1ZY?=
 =?utf-8?B?dWFhQkF5SHoxSWUrWm5DM3Z3S2hwTFgycm03VzlkMDh4Q1J6YldYdFpKamo1?=
 =?utf-8?B?bFBtTnRzdW1TT0toV29aMmNGeEJFNW5rSHkyUFNabGlGdmFqQTJoNEtXMSt5?=
 =?utf-8?B?WUpYT0NpNHhoUjc0K0hjSVBieGpzYUpxdmpMTnRKbExGSG51bHY0bFRLNVFS?=
 =?utf-8?B?NXNsMU1nWjJKVE1zZ3h6VFpvODlnUUZSMWF1SmdkdUNzVXY3Q1hSUzRKQXl5?=
 =?utf-8?B?aG43dk40QW1QVGl0cEZiN2d0bTg2ZXdRMGhibjd6VjZPUXVvRStiMHdZd3VN?=
 =?utf-8?B?cGc5RGJ1bUs0K2JFMVVHcVRVMDdXSWpwVWsvbnNSS3ppRzhOZWxINjZ4VnFH?=
 =?utf-8?B?cU8zaFk0VmllaVdaWFppaDBLeGdaU25Ga3U3YStZcWRDdXNKdmpVWVZaUmI5?=
 =?utf-8?B?WVM0bHAzcXRUdExaZXlUN3pJcTgxbWo1eG1xdXdCRjllZ1pGazM2YjVITzJZ?=
 =?utf-8?B?SVZQK1pzVFlvTlZUZHo4NVBWd3J0UlZpLzJIaXc4Z2g1bElzY3FBeUQxbVJI?=
 =?utf-8?Q?zo4TrpYEcqNHD4rw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8532d48-4b30-4afd-a356-08de5e4c2a18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 09:03:55.2993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37s/8L2phLjF/17e+F7nycGwAeaWWgMsF324KlooPwwzPO99YxWrZWPVPrtSNYOlYG+Jkfe3T6r/MGHl0u+frTS5KUE1v5MNCG5oZIcgWyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6984
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

Hi Tien Fong,

On 1/28/2026 2:07 PM, Chee, Tien Fong wrote:
> Hi Tanmay,
> 
> On 26/1/2026 4:23 am, Tanmay Kathpalia wrote:
>> Enable high-speed eMMC modes on Agilex5 SoC development kit for
>> improved storage performance.
>>
>> Defconfig changes:
>> - Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT
>>
>> Device tree changes:
>> - Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
>> - Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
>> - Add sdhci-caps to set 200MHz base clock and 8-bit bus width
>> - Add PHY and controller timing configuration for HS200 mode
>> - Add PHY and controller timing configuration for HS400 mode
>>
>> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
>> ---
>>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 28 ++++++++++++++++++++-
>>   configs/socfpga_agilex5_emmc_defconfig      |  2 ++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/ 
>> dts/socfpga_agilex5_socdk_emmc.dts
>> index f6848c373cd..49b4a85783c 100644
>> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
>> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier:     GPL-2.0
>>   /*
>> - * Copyright (C) 2025 Altera Corporation <www.altera.com>
>> + * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>
> 
> 
> Please don’t change copyright notices when making minor code changes.
> 
> Copyright statements reflect authorship and do not need to be updated 
> year-to-year or for small modifications.
> 
> Even if the file still reads “Copyright (c) 2025 …”, it remains valid 
> and does not require adjustment for this patch.
> 
> 
>>    */
>>   #include "socfpga_agilex5_socdk.dts"
>> @@ -25,11 +25,15 @@
>>       disable-wp;
>>       non-removable;
>>       cap-mmc-highspeed;
>> +    mmc-hs200-1_8v;
>> +    mmc-hs400-1_8v;
>>       bus-width = <8>;
>>       vmmc-supply = <&sd_emmc_power>;
>>       vqmmc-supply = <&emmc_io_1v8_reg>;
>>       max-frequency = <200000000>;
>> +    sdhci-caps = <0x00000000 0x0004c800>;    /* SDHCI_CAN_DO_8BIT */
>> +    sdhci-caps-mask = <0x00000000 0x0000ff00>;
>>       /* eMMC legacy mode timing configuration */
>>       cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
>> @@ -46,4 +50,26 @@
>>       cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
>>       cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
>>       cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
>> +
>> +    /* eMMC HS200 mode timing configuration */
>> +    cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
>> +    cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
>> +    cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
>> +    cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
>> +    cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
>> +    cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
>> +    cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
>> +    cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
>> +    cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
>> +
>> +    /* eMMC HS400 mode timing configuration */
>> +    cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
>> +    cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
>> +    cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
>> +    cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
>> +    cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
>> +    cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
>> +    cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
>> +    cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
>> +    cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
>>   };
>> diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/ 
>> socfpga_agilex5_emmc_defconfig
>> index 9254ab92e0c..d2d359cd1d4 100644
>> --- a/configs/socfpga_agilex5_emmc_defconfig
>> +++ b/configs/socfpga_agilex5_emmc_defconfig
>> @@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
>>   # CONFIG_SPL_DM_REGULATOR_GPIO is not set
>>   # CONFIG_DM_REGULATOR_GPIO is not set
>>   # CONFIG_SPL_DWAPB_GPIO is not set
>> +CONFIG_MMC_HS400_SUPPORT=y
>> +CONFIG_SPL_MMC_HS400_SUPPORT=y
>> \ No newline at end of file
> 
> 
> Please add newline, defconfig files should end with a newline.
> 

Thank you for your feedback, I realized this after sharing the patch, I 
will fix this and share the V2.

Regards,
Tanmay
