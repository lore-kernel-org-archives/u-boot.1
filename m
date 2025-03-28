Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7326C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1E18129B;
	Fri, 28 Mar 2025 16:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jZ1QaONd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E76C81DB4; Fri, 28 Mar 2025 16:08:07 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069A3810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEE+xbHm4ZM1pmaG6CVLFuIEImKhOqyzsR5RvSKdbu7BJ8jUJerc0BjnKqEl/GsZGvq9SP5keX4N9bGR42NIl76jaszbTUuHE2ygGxkqPoRUE6lhjmowKV/dm5UNzmQNQq7zuwqkBOVeUdemeY2oGOc5pEZLbqOp+gVmXcdk1So17UncZqlBq3de3XohkyA+XDZHScoovS/5Ix14HvKPaYzDLEe0ivPdyjL3qQhCOzJwAXyAT6v6XALxAS8wsEGGf7gMmXXbkZhR9shvKJ4j2gkpQDaA8GjeWupamYrmJq30LvE5YM3jpW9HYiFNDGv8i+ecFW8NOnxtrQG9GFVPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpHy2rVI0VKblsi/FmIzaD+yFb5rgYH5IkEzlHt5PVs=;
 b=CfBRV84TxBSEPpGN3kM9/IuJFO2sLULqqEyMgSaIAHPFKONoSG1IAZOpasnxebpOiQlMixas506d2+0F9QS5q3bDb28PeUXp5XPz4mzyATG5CSzZWwqERFk71uw9n7qqVt3yRRByKAst8GaR0sfpEz/1fwqEJj3fIn/EEj/a3s+sJ5pb39lVf8wH9EK/MMPjuohJcQjN/CoVi5JfvT8pftEpgBJ35S9cByYI3e0+sFPjkPPSLnY+dE17loG4TZA7+HuWxnVkGFizMKOWMvbSj711v1kao1010Hb9fBHLO2mVrXCH+RG/PpiFkEKQvLRpIU6M2bnr4sV/be2sp688+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpHy2rVI0VKblsi/FmIzaD+yFb5rgYH5IkEzlHt5PVs=;
 b=jZ1QaONd2GbUqX3W6t9tpkghozJ/7OfgZQglzUdyLXia4eY+R0SZOFruzucb3fTjniudQXBql91aFzfR+LUB89poRqzcjqcAdyNUyP9IyF6X65yPu+egKUFy8EeHQQJ/MZKqpsudA8w/8p0uSMpVfxqmaWXKRq8xeqIUc9S05uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:08:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:08:02 +0000
Message-ID: <3b4a6c39-3d26-40cc-aaa5-009ead2684b9@cherry.de>
Date: Fri, 28 Mar 2025 16:08:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
 <421afd11-7a50-415d-b43b-9db62e416dd9@cherry.de>
 <7359fd8c-8235-4530-abae-b97c80cb3c79@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7359fd8c-8235-4530-abae-b97c80cb3c79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3f5aa0-9b0a-4087-8b72-08dd6e0a55b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJZajB3b211cmowcFNPM2ZmSWw5OEZQZTRnVTcvSmtzMHVhZEtnTkt2MVNr?=
 =?utf-8?B?MHZLbWoybVlieE9uajhab1JUTGQ5WWJQSk5pZkVoeEJxMStoNUg2Q3pzbEdx?=
 =?utf-8?B?YzdQZGwyODVFZmFsQ2lUQkcxejlNeXFjbW9pSWRnZHVGU1NuSVR4TkcvaW5R?=
 =?utf-8?B?dytXdlZiMjB3RkFIVVFnc2dDM0xPOW11dVhwTEFMc2Nzd2VxTFdZNnNtWlZC?=
 =?utf-8?B?OVQ3UWpqK0d1ODZ1N0tCMGRLK2Ntd1ZjVE1Sc2NmbmpueU13ckhGbEJPdmZj?=
 =?utf-8?B?RDNvVTQ2d3owWHUvSldaV1FvN1dHQS9NUTRudHUxc2VJMzVYM2psb05qZzRJ?=
 =?utf-8?B?YmJxRjBzZTN4RitRMTV0dS9GQlFnY09qQnlINXVrSWJsS2JTbUkrTjRjQmRZ?=
 =?utf-8?B?eVVCMXQ0WU51QXAzQ3FFYWNOV2JuVDZ2Vmcza3dKVHYzU0N2ZWtpZW10TG02?=
 =?utf-8?B?Q2xPaEwvMTFRNUhMak8yUldnblJVeFAyQk9HNzdRQ1hmZDFvWXc5ZkVEQkM4?=
 =?utf-8?B?T2hlY3ArZU1GMHlEU1lEU1U4WkJKM0pOVnFvcU94ZExadmxnUEtiV0lOM3Ni?=
 =?utf-8?B?Y1pmd3dQMU5oVUJFTmF3Y0owSzFHQzdlaDNqaFpnRUV4dWhyQ0FRTEtmUVZN?=
 =?utf-8?B?RlRSSndsVmtrZm12aGdMNHZrc1dyMThLNGlVYUNXSkRxcGY2cXU4SlA1ZmEz?=
 =?utf-8?B?QlhFbk1oaU5la3gxbmVlREh4NjY3bllWMCt0bTRXbFMrRENoOS90VnVHOUdC?=
 =?utf-8?B?Rno3dmIycVVDb2xnNEYxc3pOMXR5aCs2b2Exdmh5Z1dwbzBzVG9CT3hQMlNq?=
 =?utf-8?B?SnBPVmVHMWNYNEd1ekN0a0JXbnkvTnVDVHpyNmV6QVRmUzJmLzJOT1ZyOWVo?=
 =?utf-8?B?aEtaN3dLdWVHckpTRng4TFlJeGcrTzQyTkZQaVFkV0Q1QTVaWmhEam5qbE55?=
 =?utf-8?B?b2gwZWphNDl0UGdNSy9YQzBoWFRCSGRhRkFpbXNHdHVFdkZiR0xIWTkwOWxn?=
 =?utf-8?B?YTBvYzhDa0k5VGxsMURlSWMrZjB5QkRNN3o3UFQrS1E1TEI0RGxXS0VYZW5n?=
 =?utf-8?B?Sm1zRDZiQjFtTnR2R3hjb3N2bUJaVm1ybHptbFprOUNKa0RpVU1kcnZHc09P?=
 =?utf-8?B?c3pNdmVuZ2Y2eGlsb1FDUk5vNjR1NUtidHh5VU1scmw3Z3dhRXRWSEE1U09O?=
 =?utf-8?B?blU0SVRpbDF4RXFtL2JOaHlZN045bG5xOGJ6aHlEV3VlVVVtL2pIVmk1OXU3?=
 =?utf-8?B?czVEWWtNb0RiSWJtQWpCcnpSdjJvU1VnbGJLZzBURVFwK2dCdzE5MXgvNlY4?=
 =?utf-8?B?SGZDc09jcmtSZkxvZzdad21wTlpldmZ2eHlOQy9OTHhGcTBUM282UG1NUVNY?=
 =?utf-8?B?WFhVZlFQSkpQYlFyb21ialEvNktlSktZZ05ONzFYWE83RVY5a29IVzJxbVNs?=
 =?utf-8?B?UTRqZGVxRDVMQ0JjOS90a3p1c3hMT05qVlBaTGNVaXRKdkRvai9pSXJZNzNC?=
 =?utf-8?B?U3F3ckNicmNOejE2d1dMMU04TFRxa0JTRnpqaUU4bW1Xd0luN1pCU3gyeTNm?=
 =?utf-8?B?RmRYcWJmT1dHWkR2ZDA3dWVubVJaZnNBMG9iVU9sdVc5Z1h0bENRaGU5VW5V?=
 =?utf-8?B?UGdoM2ZBR3BvaTBQMEJ1L1JvNWRkZTYraXErbXlxZ2ROVFFGN3BmMW9STmVB?=
 =?utf-8?B?cU1Kd2QySm5IYXVoRlE1NWdZenRMcnpvT2dHOHYvdFA2UEVKMmFPK1J3YUZT?=
 =?utf-8?B?Y0N4SUxEaFlFZmVoeVRYOU1zbVhqRjg5RGZ4ZkFyQXFqNXI4WnFYVE5tWTV1?=
 =?utf-8?B?bWdtTGxNSkY3R0xLa3I1OGQyOThaWWg1Rk1iYWphbTVGMlE5cUZtN2d4djJL?=
 =?utf-8?Q?LuqmdE651VMp7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THhMM1RlMUxRREpuRW02cUNzZGtmU2hYV21YRWVCTUxQZWQwcTRqRmtTL3JK?=
 =?utf-8?B?bE5CTmZJd0kwcWJJdmV4VkJaMGloSk1ETmFhZkw1THZTZlluR1h1WUdIdW9l?=
 =?utf-8?B?QzNFbUNKem5xakVUZWI3dHZocjh4SEhsN0lGa0hBSTkvbVdleXg3Y3BTR0p2?=
 =?utf-8?B?UXFhcjVGRG8vUW1ZMEcwRTBuSnVvK3BDdlhPZ3RhQit2aFQ0dldnaE9qSXBq?=
 =?utf-8?B?dXdoYkhyblhXT2JMaEtneWFSUWc3SzlUamdUZlVZTFNtS3hqZVpYcTRZVEhU?=
 =?utf-8?B?b1IzSllNN09XZlB4SGN5WU1jdmhMZXRsdklnMmZsZ08yUmRuZ0RteVZQb0RG?=
 =?utf-8?B?dUZvYUN0dExzU0JMeUdXdVk1aFJ2VDF1ekZJekxQTWVWamtKaW9HbVJLZ1RI?=
 =?utf-8?B?NjFFOUFyVjlOaHYyYVpNK3NwWlZMTXBDUVZsRlNrZWZsTXBFM3RyNCtsOS9O?=
 =?utf-8?B?WHpmV1g2a2VvVFRZMFhzWVo1NHhRMXpQODBHRVBrc0hka1RtNTBQczJJYTJl?=
 =?utf-8?B?SU9KcXJZY2RrN2x2c3BuY0R5UlJiT21kOGIzNXVMNWx3bEV0SDN1UXIvRjI5?=
 =?utf-8?B?dStOVFJKZWlUemsrY0VrOTgxdFFlV3pINThaaytoNmlEcEg1dDlKR0NKbFJr?=
 =?utf-8?B?VUlVbmdrckxFTWlNcnM1alNwUjNsR0tZTDBpNU9MSWtjaVl4OVZwclpqM1ht?=
 =?utf-8?B?aXMxZ0lXbnJ3aDBGMTVQem12b2tTWDhIWkppb1ArY3cwWG5YS3FaK3E3ZFho?=
 =?utf-8?B?NktsYlc4dzlRNWlIV1BIS1hWWFZhbkdVOVBiZ0JQME1Pd0lBUnNiOFRMQnRj?=
 =?utf-8?B?QjVsbVJtZytDR0tvWVM3QnRKTkFQaFRhdjZhWklaTWpyNDF5azJKTVpGZUUv?=
 =?utf-8?B?Q2NUZjV3cmp1bXJpT2tIdXBvZHFSaXBDREMrN2tUQVhsL3loZk9qNUdxL2RT?=
 =?utf-8?B?cGdxOU1JQmRZN0l2MytZOCtvVUpNV0p4YVZSRmZqd1dyb2dPNlRnOWhPQW56?=
 =?utf-8?B?M2x4OUtVY3QrOEhBcW5pVlZJV2N1ekxBbGNUdmpUcDdlalZIc3A0NGpENlE3?=
 =?utf-8?B?T2JxOE1KajJHN29JUUNFeVRvQnUwSnNIUXdNelRzelptdzVsVG1kR0Z4bGsv?=
 =?utf-8?B?d3dOTHRITksxTmlpZWxLczZzMGpSMTlKeHVOb2RtNVVUMGdIYnE1azV2cUhw?=
 =?utf-8?B?WjdLMys1Y3NtQmtMbTg1dzU4ZWZCbUdXY2ZhWEliYi8zOVdrVkhwOWFlUjZF?=
 =?utf-8?B?TU5OT3hpMXZmWnltNHdoazhMMjNaZ1NjZFJxMis4YlR2QS9aRk5WWjdnazRw?=
 =?utf-8?B?ZXhQOUNaYjg1bkR0OGh2N3ozeUViS3BGc0tsSEptQlhZREZhK1VMY2hkck9E?=
 =?utf-8?B?UTF4UzY2c3lkdWNPOFd3L29SYndYZElOOHQ3Sk9PYjB4cUJnZzIwK0lsejFy?=
 =?utf-8?B?ckJ1dkQ3VmdzbDF1UlNNZm9kQlVtNmUxRzdqbTJvWEc3NEZyTkNRR2xmSWVM?=
 =?utf-8?B?QTdrVFl3Zk9GcWJLNXgxelowWXVDVlk1M0hxdlEvS0RaRkhqUmk2YmRWZ0hD?=
 =?utf-8?B?Vy9ER0JyT2dQWHpFTHNoZFU1VHZ5MkEvQlV1eDZHL21jTFFiY09nTElTSC9L?=
 =?utf-8?B?S3pLYnBKcm90MTdPQzhIeDVkbXFEeWJ6ZFRxYVV2Yy9mQjhCY2xkbG5xUU5D?=
 =?utf-8?B?T0FVNS9sSzI0UkNxM0JhR1pSQ3FZcnAvNVNGQkFBK1ZLaEQ2SE9ZYlpweXZy?=
 =?utf-8?B?V1RVRlYyeDNuYnJmSTc4cG5sQkppQXJxc0VQMUlBOGdzLy9QWjZvU3FqdTVL?=
 =?utf-8?B?QjFSYTQ0RW41bUI2TTVVNjhETEpiZzhjY1NhcjgvWERaUUhIVm5KUWpYQnhr?=
 =?utf-8?B?MTMwNGlEMDQ5M0RhbG5YRXRCZTNCcGdWRXA5eG0rWUEwMmRwOXE4aUpVektY?=
 =?utf-8?B?VVpJZE56L09XWnpzUlNXK2FEYytmWDJRMWl3Mk5xZVIxLzZIYXZFcnFtV0lp?=
 =?utf-8?B?d1RPa0NkbGJVWjNPMyt1K0U4WmxGTVhxbVhMMDVxYTFITGdyRTdOMVRnS0hz?=
 =?utf-8?B?b2VMMzRqczhIemdpZEhKT3ljVTRpY2VzZ25oS3hIY3JrSmVFMDJQdGRHWDhx?=
 =?utf-8?B?ZElpY1ZETzVVL282bDZtZ05lZXV0R0FyUWZoZzNWMmJqaTNnRVk2ZFEzenVS?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3f5aa0-9b0a-4087-8b72-08dd6e0a55b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:08:02.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAovTUDApPKX3A46y7S5bIVg8GvI9QI6tip814t45oMIQz+Ta70U1+r/Gdzk3KKUE9KhHJPYExwYtmdNge/1xkdo23im5vMncu5rTEKJr2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

Hi Michal,

On 3/27/25 10:11 AM, Michal Simek wrote:
> Hi,
> 
> On 3/25/25 10:48, Quentin Schulz wrote:
>> Hi Michal,
>>
>> On 3/19/25 2:08 PM, Michal Simek wrote:
>>> u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's
>>
>> They are unrelated as far as I can tell?
>>
>> Isn't CONFIG_SPL_FS_LOAD_PAYLOAD_NAME the name of the U-Boot FIT that 
>> the SPL is going to load from some filesystem?
> 
> yes.
> 
>>
>> u-boot.itb in the binman nodes below is the name of the generated U- 
>> Boot FIT on your disk.
>>
>> Your disk FS != SPL FS, no?
>>
>> I can get behind wanting the same name for the file on both FS, but 
>> the issue I have is the additional CONFIG_SPL_FS_LOAD_PAYLOAD_NAME 
>> #ifdef will prevent the generation of this U-Boot FIT image if the 
>> symbol isn't defined anymore (which is possible if SPL has no support 
>> for FS (ext4, fat, squashfs, semihosting)). U- Boot likely work just 
>> fine by trying to load u-boot.itb from another source no? (No 
>> experience with AMD, typically only Aarch64 for me, where u-boot.itb 
>> is usually loaded from a specific offset in the storage medium, 
>> outside of any FS).
>>
>> Basically, do we really need to NOT build U-Boot FIT if 
>> SPL_FS_LOAD_PAYLOAD_NAME is not defined?
> 
> There are couple of things here. AMD/Xilinx evaluation boards are 
> capable to boot from multiple devices.
> 
> On ZynqMP we have one official supported flow which is FSBL or 
> alternative SPL.
> 
> In FSBL boot mode FIT image is not handled and boot image contains just 
> u-boot.elf and that's it and no matter which boot mode you use.
> 
> In SPL boot mode boot image (boot.bin) has only SPL and that's it. Then 
> FIT image should be created to be able to start TF-A, U-Boot, etc.
> 
> Then based on boot device there are in general two options which are raw 
> mode (for example SPI) and then filesystem one (SD or EMMC).
> 

So no raw mode for anything that is not SPI? E.g. no raw mode on SD or eMMC?

> In RAW mode qspi image is created (maybe we can rename it because it can 
> be also used for NAND for example) and image is expected at certain 
> offset and name obviously doesn't matter.
> 

But you still need a u-boot.itb to be available during build (c.f. 
/binman/image/blob-ext@2 which points at u-boot.itb). Isn't this 
u-boot.itb generated by the /binman/itb image node?

> But in filesystem mode names matter and image should match 
> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME because that's the filename which SPL is 
> looking for that's why these has to match.
> 

That's fine. I'm arguing about the fact that you are not only renaming 
the u-boot.itb to the expected filename on the filesystem but also 
entirely skipping building it if the filename is not provided, which is 
not what's done today.

Essentially, I'm wondering if you don't want:

"""
diff --git a/arch/arm/dts/zynqmp-binman-som.dts 
b/arch/arm/dts/zynqmp-binman-som.dts
index d5b63ef604b..e73f196611f 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -9,6 +9,12 @@

  #include <config.h>

+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+#define U_BOOT_ITB_FILENAME CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+#else
+#define U_BOOT_ITB_FILENAME "u-boot.itb"
+#endif
+
  /dts-v1/;
  / {
  	binman: binman {
@@ -105,7 +111,7 @@

  		/* u-boot.itb generation in a static way */
  		itb {
-			filename = "u-boot.itb";
+			filename = U_BOOT_ITB_FILENAME;
  			pad-byte = <0>;

  			fit {
@@ -227,7 +233,7 @@
  			};
  			blob-ext@2 {
  				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = U_BOOT_ITB_FILENAME;
  			};
  			fdtmap {
  			};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 252c2ad552b..89dfbf4e936 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -9,6 +9,12 @@

  #include <config.h>

+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+#define U_BOOT_ITB_FILENAME CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+#else
+#define U_BOOT_ITB_FILENAME "u-boot.itb"
+#endif
+
  /dts-v1/;
  / {
  	binman: binman {
@@ -17,7 +23,7 @@
  #ifdef CONFIG_SPL
  		/* u-boot.itb generation in a static way */
  		itb {
-			filename = "u-boot.itb";
+			filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
  			pad-byte = <0>;

  			fit {
@@ -196,7 +202,7 @@
  			};
  			blob-ext@2 {
  				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = U_BOOT_ITB_FILENAME;
  			};
  			fdtmap {
  			};
"""

Cheers,
Quentin
