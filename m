Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE9ED111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47FB83A3B;
	Mon,  1 Dec 2025 04:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WS8sApo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46B483A43; Mon,  1 Dec 2025 04:08:24 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66C683A3B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsKFge+gryH7+gbazy0fwTpCHogCkKZ2Wvm4RhOkfQ+guVxRce6+OIJuk5EvUw31KUIMHWI9/Hb9FoDDaEfmx+G/s3YOh0ZyxAbf2+At/pOoGlODNVg6srV5rmsf/FFZgZmVsgZCujtFvHOsZNoHxR6SL8VjPgXw2sv90MeQ561n/JmNiiYsF5i1bAFl53UtLD/GU06i2flAftaZlBe/TCNnYtsUAmePGVkqk4gqbRranXxcvH4owJUm9UBcJ61N/tfeyv0Sx/Mz67rRT8VlqF8pESwTOPiyAm1iHZJjhUQC/52Tq/mlHIi/fgUNSxejvewjsOAH0+23f3axO0ExXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63ek+P7426P38BZRPkiqWGgr0rOxd84NR4woEMRkrDg=;
 b=mtfCApWbu1yXreiXxJ1pw5AaZxZFDkzxflFciC5VtNJu+GxjqjAr1mq4BnvF1SGIgOv7Bpsmxmw4zBYDHrBWvtp75xiw1L+55juYfbFo3OangmY8hz6UHp2KR6CDJXWd/JatJLI5bePF0lOXgprV7oppfXzXFw3GZMComtgbf51Dkl6Iqa4+e/tS1TsflOLmKygHj59a1hFFy6riutKI9sIg77F3IIhm8N/qdysZA9HyumN4n77e32byBMavIkx9CmDAwyf0VsWod9qRtDGJfYF10Mtb5dRpSxHH7NB/+dLOvvduou0nVSJRKLzBbxitKMnZnU+trEf6ErsKDrB4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ek+P7426P38BZRPkiqWGgr0rOxd84NR4woEMRkrDg=;
 b=WS8sApo82aCHPbNT5bkRb4gtYkIfMYV8/FzFNb2bVrXp04iU0U6aUiKznFqmkx4PuV7dV2rkjBlzRgthNme1sN08IvHc2YEmhDYsUjv1/aXsCN22Dzc4+cD3yfXx7XibB2hd86RmENg2tgLuNrNpKFrnnyyM+HjTGvI/4UO1IaNZsN4f6OBv+JeYKlk41uHJeg1QSkkfqNYbxSDlWiDAIh5Z1UYLXjwkO44+LTZdw2iF9XPbjvq5MjS4HYcGkWH7rT3ifGiyWhDG3J442m2GWO+ZszHnXyVftTKpiWIIBBNweBRlDzLnilIRujLnnQ/IBTnV7uAYuKfjgDNWO0x4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:08:20 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:08:20 +0000
Message-ID: <3ae975fd-7189-429a-8ea0-66bb322b4dea@altera.com>
Date: Mon, 1 Dec 2025 11:08:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] spl: Remove ARCH_SOCFPGA from MMC raw mode
 enablement
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-6-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-6-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:802:18::20) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 806e3b2b-69ea-42b2-3ec1-08de3086e14b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2VBeldzcVVYOUdPc3IrSCtzUzVBUGxGYW5vSmFZMEVJUkhmUDhpZ0dYQUNK?=
 =?utf-8?B?ekFTOE9zWURkcTloTUpPaDcyWVhmaEliMXVaNDN0ZGp0aWNkMDMyRXkwdVdh?=
 =?utf-8?B?VGtSL28zUE5qczM0S1c4Qzd2eWk1cmxFNjZEL3BobVJJUHlwSStnc0toNXJN?=
 =?utf-8?B?QUExTm1vQVJReWxHVlpLQ1JtZGJvWFE4MlFWVE9XR3ZLR01yYVdEV1VjNmxl?=
 =?utf-8?B?czVPK1JLN2tqM0xrMzBnVmk5eDAzTEM4MU1qMSt3dW5FYVA4SS80UWNGazZZ?=
 =?utf-8?B?OThRK2d0MW9WczBLenlMRjZHQjJpdGEzaU02UmpGTnVrbU95UlpKNjJZa1Vn?=
 =?utf-8?B?STlHTDdOSUpxSzNYMGxNYTVhRzM1KzdmckcwWXNieW9aaHdJMWVVTS9DdFQx?=
 =?utf-8?B?OUs3SlNqd2JLVnozN3p0eUQzSk84dFhJUy9MUy91dXhtT2lkalBESDJCV1VP?=
 =?utf-8?B?a2MvSmYzVGxmRzdoYUVmelozbkxGUkk3c3haTlZ0ZEI2ZC9LcHE0L2Nndksx?=
 =?utf-8?B?QTQ5T2tGRkhkbE53ZXFBMXBMZlhkMkRCUlI3ZExHb3pKNVRlVkZxaU9GT2pp?=
 =?utf-8?B?TkYxc29YRjdsWGVkZXNSWlpqMFJUaEthNEpBUEt5M1lxckJFeHhSczRvdVBq?=
 =?utf-8?B?dEMrUFV6ZGtxM0V2TkIveUZ4a1NKMThtSml3N0FhL0grVlp0VFdmNXJlRUV1?=
 =?utf-8?B?bnAvV2NWQnp6cHc4ZjRjMHM0Q3ZJT1MvZVk4bGZjZU0zZ0xpejJrWnpkWjM4?=
 =?utf-8?B?WnVoYXUxRFpUNEZodDBpWDRXT0UwVHMxbHBmdU9HeEVsRUE0S3hhcFdOcjRt?=
 =?utf-8?B?c2hlN3FWRkxCbFN1QnJhV3JVOVZ5S3hVaDBUMG9ZVmMvMzFqN1hvU0J5YnBh?=
 =?utf-8?B?SUNnUjNKK0orYjBIdDJub2FxUmhNdEZxZ1g3emFWenl0YjNndE1LdXpERjNj?=
 =?utf-8?B?MGFsMEljd2xyZGY3dW0yZEU0V2htWkROYUdQUVh5cUozUm1URml3T0g3NEln?=
 =?utf-8?B?ZVZ5V0d3STVHQm1BTnQ3aEtTb3lyMVFqc2xQZ3lSM1hDRUhSVEVTbXdGbEZR?=
 =?utf-8?B?YWtmTW5mZHo2M3VTQ2tHaEtZdGRybk1hOStZRDloMzJtUmNkN1laUXVDdTBn?=
 =?utf-8?B?Myt2OVhwcmdYQkZoS3JTcUtoVnRWMzVEeUR0cWtWcDVnUGdUOFdpYTR2RnVi?=
 =?utf-8?B?czNVSTdQNXZacWJqbGhaNC9aMlRJYm41RVNBTS81UFRtWGk2UUZaS1NQVFo3?=
 =?utf-8?B?QngwL3JRYkVoMWJ0MW9Cb2w5YVY0V3BEdjhKajlUaE5kVlZGbEZ4U0JodEE0?=
 =?utf-8?B?M015VW5FZlVEb2htTHB5SXNRdGVCWTV3Mmh6ZXk1UFZ4c28relJ5NnA3c3pO?=
 =?utf-8?B?MWE3c2haRlhCY25pSWlJQkUrcDBReXdCZjFsL0I5R0xmZVlzSTNydWlpTzNZ?=
 =?utf-8?B?dmtxZzQ0RjFRUEhYRkZiOXdvcUEvWGc3WkZ1cHk5MlI2SDMyc0doMDNaRXJI?=
 =?utf-8?B?K3dNUlVKYWNXMlBzbkY0SUR5WGcyelY1eXpkdDY3WHcxQWx4bGhFQ0d2cWkx?=
 =?utf-8?B?bTlGa0pYaWw3QzNjd09tTHV5ZGIzR3RIcHNOUEV5ZGMvekk4NEVRWlo0VTRU?=
 =?utf-8?B?Q3hEN0FQbE9sSW9ZV29zZFk2ZlBKNjZDMTRuSUlhdjNrQWR5blhNQVRIQUxQ?=
 =?utf-8?B?YVpJRU1tZHZSdk9RWVZ4TkdnY3Q5MlR1SnV3enVZOTJpMDROSC9SaDloa2pF?=
 =?utf-8?B?K0xDRWp5QXVjWm42OE5qaGpTWE03aHcwdGhMWkxOb2hYbFdMWnhja0ZNa1Rt?=
 =?utf-8?B?b2FHamNMNHlCa0kzaXplMlJlODlPbXp6Q2VFelJuQmJUWFJkTTIrUjZwZlVk?=
 =?utf-8?B?VzNaZURmcEd4YTdjMHJNS25kNWZiWFZJN3NvME9DUFFnZ0JDNTgwT1R0RWg0?=
 =?utf-8?Q?iHnoBygc0NxA+832B7qkllpPqx69Sssl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtEQVVLN3lrbk1ZQU80RXNVNEdXR3ZONE5rNmU5eGNPTDFXamxaQm9VcHdh?=
 =?utf-8?B?c0VmWmlBblRqR2EwY09FSVBEY3lEL2xMbmljNTU1dkROSTBNY3JHb1FaeitC?=
 =?utf-8?B?L1RjWi9ISGQ5UHMrR0FhWGxHa3RFbTQ3U01wWjBmT0dvRmh0UFRoTTU3ck1U?=
 =?utf-8?B?bG5iTVhaa05ZYWdqTHBFY0wyTk5jYTJXTGdUY0lOZnNKekhRQW8ydTFvd3Bu?=
 =?utf-8?B?clpIaWdtOUdXaVJtYkx5WHpwNWppbnEwbXNBeEFicTBsbjlXcWxja1I1c3oz?=
 =?utf-8?B?NC9CTUxqVklqeHl4K2JwL3ZKM2svUkpFQlFvS2tNN25DZmhOM0pDTWdCMzNv?=
 =?utf-8?B?akhkTmdUSVRCS2x2bjk3bG0yM0FPcnlsMkJYM1AvVXV6OE5NcmVSRC9UL3ky?=
 =?utf-8?B?c09BQm9ZMUNTWWlVWmhSdlJFMFA4ZzJLSkp0MEdRQ2MyUGRrZFdXTTFkYnRV?=
 =?utf-8?B?M1pYc1crQXBPNWNKRGNlRXV6ZDluamRWeC9kQ1JWbHpyYndZUlpKdzA3OXhP?=
 =?utf-8?B?ZTlESk1WSnBGMmlNZUlRUjNsNWRtNEdpQmJpZTdlN3R3YTJBcmFVMC81WmJQ?=
 =?utf-8?B?R1lLWk1KK2FGY0pGdlR0L2tWeXhVSFEreTlEaXZiUmk1Skt1RkdZWXlmWk41?=
 =?utf-8?B?Z2pveVU1S2RPSFh5MGdLQk50WGRseHFiSmlOV1RvbGhKcUIxMVRnQ3NUVURz?=
 =?utf-8?B?eHBPVHg1REpSN1h3WTJZYXdSUkQ3ZFd2T01xSnBzQTEva2NPRVlod2daUlBD?=
 =?utf-8?B?N0JNbm9RS1EvdEdtdXBTMVhBalJ2aWNCNEFpdnFMZDg1S0tqZmI4WGY0QWpC?=
 =?utf-8?B?T3NPMlBpYzVpL1dEdFJJbUd3ZE8wd1JBOFNidVFyMkZkN0JMS2ZEK1c2aTRP?=
 =?utf-8?B?cmFENkVOczB3V0lnMW15MXR5RFBJU25kQjV2cDdOTzBxMkp0L3VCU1o5N0NU?=
 =?utf-8?B?ZDBNRUlDa2l2K1Fzc29qdGFVNnNwWGp6OUdncnErakZVQjBjb0hzdm1vT2cw?=
 =?utf-8?B?VUZPZHUxY0ZCTXY0QWpDSTRmVFRoWUFLRktLSENwWEFiOVVKdDRwdlg2RnRm?=
 =?utf-8?B?VkJJc3lYbU9FakRzQWUzVERtYnpWUlJtVGdoRlNsRmdWSFB2M0lkQzFaQldi?=
 =?utf-8?B?K0lFMi9oSmF6b0d6ODJtSDR2Q0pPdHRHNVBkZkV6eVBVSmNzcmRtcnRPOVFp?=
 =?utf-8?B?NjFia3Y0UVZyTmp4eHJhQ2xoWXpMVEE5RnpMbHhYWWtiN0YrZ3RaUTRUcW1S?=
 =?utf-8?B?RzFoeTZFbDllY2QrdkFBWExLdUNndktNbEV2Ym04OEtSa1lQYVVKRE1UM0FM?=
 =?utf-8?B?Mkd1cFJXbVJrKzN5Q1lTTnJRM01jTEI2dGY0bXo0bVQ1anJBOXc2MXQxbzJD?=
 =?utf-8?B?TmczTzMyV0tDR0thV2JzZ1k2QWEvNHJNR3pya2ZFRzNzT1NHMkx4U0VpUEIw?=
 =?utf-8?B?QU90WnhRMkorc3BOWmNBUWdZRFVabVAybllZQkh5bUQ0aGRMa29aSXU0V05F?=
 =?utf-8?B?aXQ2UzBDdENPQ3pNMFN6d2gyYStnKzRUS0hUUjZxVStxWWpSaXFBOUN1T3VX?=
 =?utf-8?B?ZkswV1p3cWxTWS9WekxRZEdsdlYwRjNPQ25GQmxGM0VXS3g3OU13S0xBUVkx?=
 =?utf-8?B?aFZEVysrVmhJT0FpRVJCNWkvK1FSRjdIVTBNd0RDaHlNbkVCS3ZIWEo5eThH?=
 =?utf-8?B?c3NpQ0Y2d0NGNUlmWFQwWVZFODRxRDdCSzRRbXNJVlN0anl5cncxbU01YndU?=
 =?utf-8?B?dkc4TDAvZ0cwU1RvelVTei9vMGxUSHg1anhXKy9nZnZjNUdQdFZ6MFJwOHdp?=
 =?utf-8?B?KzRpcS92VmhEU1JrUW81dEcrUUwyQkx0RWw0b2dQNmZTVjBlL0R5LzNpY09Q?=
 =?utf-8?B?eG5tWnVvL3pyMDZvVmt4UkVWZDRRSDYwY1A5Q3NSQ2xrK2hBbWR5azBFOUUz?=
 =?utf-8?B?cGN5RUduTGhsWlhDZm1MbWhZYm13UmFBL2NldW9iV0dJV3J3KzJrR0xuUmVQ?=
 =?utf-8?B?b3hKWW5SUnBIUmp6R09JaEgvYlNFbldYdG84U21uNkRObjA4Rnd2ODhlRXlK?=
 =?utf-8?B?TVdoVWxiSWw4NDg2b0lzQkpBRkorYWNYTVhDQkRsSnUxMHRpVUIwT05vK0pX?=
 =?utf-8?B?cnM1QVVRcUJmb2dLNUU1YmZ4YnBncDQwSXRiNzE4YzJFaFNHT3VWeU13MHlK?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806e3b2b-69ea-42b2-3ec1-08de3086e14b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:08:20.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxDe20wRGIj2pQSW6XYxtvD8hNTlYm8ZEW0LDq8o9cCEXV+SjGRN2XGwgZDkbY1cWFwlrkmUtAYJLu07QU6axpw8c2HqpvwZKtcTJMoiU8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> We no longer use raw mode to boot from MMC for our devices in favor
> of FAT filesystem.
>
> Maintaining this config for legacy gen5 devices as to not risk breaking
> any configurations still utilizing raw mode.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   common/spl/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index d24466b0c66..142cdb34cd5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -545,7 +545,7 @@ config SPL_SYS_MMCSD_RAW_MODE
>   	depends on SPL_DM_MMC || SPL_MMC
>   	default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
>   		     ARCH_MX6 || ARCH_MX7 || \
> -		     ARCH_ROCKCHIP || ARCH_MVEBU ||  ARCH_SOCFPGA || \
> +		     ARCH_ROCKCHIP || ARCH_MVEBU || TARGET_SOCFPGA_GEN5 || \
>   		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>   		     OMAP54XX || AM33XX || AM43XX || \
>   		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
> @@ -590,7 +590,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>   	default 0x8a if ARCH_MX6 || ARCH_MX7
>   	default 0x100 if ARCH_UNIPHIER
>   	default 0x0 if ARCH_MVEBU
> -	default 0x200 if ARCH_SOCFPGA || ARCH_AT91
> +	default 0x200 if TARGET_SOCFPGA_GEN5 || ARCH_AT91
>   	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>   		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
>   	default 0x4000 if ARCH_ROCKCHIP


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

