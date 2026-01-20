Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AC3D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB6983AB8;
	Tue, 20 Jan 2026 16:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Jvvo3+6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C58283AEE; Tue, 20 Jan 2026 16:12:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EBF83A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBTlY9zHxIyUDiYO/nJbV6eB0JDIRcAymwegPZ1ERQUw8ano/NfFxs1sMkQsY22LvRm59N7j/GWnIRWm+gdfycSJq+9DVPge5r1qdekGrHW4dMHGqgJPIbg0aemp0unZ+iE974dDjC1MIm0ItrblsK/WaFcTrWosytnPmddQEgdUnRD1ullTxTE+NtO975xIJDgIO8M8Lj8e6Llu6pquLU7lzshUNo4E1+CholNmu37Fdx2b0YxpzxSfY22avxT1uet/rF4/gtDFJIL/MtL90717qQpyA38qNHxQtxLv+UnXe3+GfFu8dZkxFJgH0L8nyn/4HDbq8/PonE6b5W5agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJVla0ld6f/4vWyhxOblkQALN2yehGnG81NA0TCAh4o=;
 b=T3DAKb1SJs/83YyZ3j2e0Qcvpc9wh97D2vGzwGiD2WlSynm8g+tQ9dCAevn1ArnWrwt/AvUvydfDsVKB51eEIOvvxtvTjmtgNgVyyiPKFuoFFGWLXar907CTM4XiuEOT8z+fD0Xa31aDjfXUHFMUJ1wDvJJdrdCDveJcxuK6HwRYdzchS/djri2ry03XkKdQwveIHS5hPHfGeYv1RafFTVP8bdirHEzcrvaeDldWeLijQKvIpCbtsbcJaMgXRpsTg7OLt31hIznJk3T20Hnpu51hBwBTOy5OroooVmOV5OXmQ2t+IKyeKTvQGuMinvC4LAJzF6M1YwXJWZ38RMAZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJVla0ld6f/4vWyhxOblkQALN2yehGnG81NA0TCAh4o=;
 b=Jvvo3+6XgZgvXkLTQrz9sstcPk6Hse0U9D8/L3xZu+I2hwuSM1hOyDIW89FTsu57YKZkdxoYyMqmL9DIXay/L7W6h8HQYIYSbauR51aTnI8hCAg9kgFdtufAl97gFEOL907Pgzi+UUnxAscA9mO3kpX/D3huehxqSt50oT1z4Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB10135.eurprd04.prod.outlook.com (2603:10a6:150:1c0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:12:45 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:12:45 +0000
Message-ID: <8efde50d-2eaa-482b-b71d-d05626f6eb56@cherry.de>
Date: Tue, 20 Jan 2026 16:11:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] tools: Fix long option --dump_sig in mkeficapsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, simon.glass@canonical.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-4-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120081206.251544-4-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB10135:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0a7ad7-993d-4746-36b9-08de58365da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clRLRnBEbDgxR0x4WTlPdlVFS0pWQ1FuOGR0YnYyZmdoQWQrd3NUVnpTWjV0?=
 =?utf-8?B?aXE0UTBIa3VmTGN6Z2F3bnh2Y0FlVU51KzhnUmdQMWZWbStnblUwOXh3c3V2?=
 =?utf-8?B?cXpueE9BcmM3TWMyeGpreFJMNzFNUXUxSG5iUll6NVJzOTExclloZ0pHRmhF?=
 =?utf-8?B?Ylkrd2k5N0Z4UkRmYVpIcVZXS3Z0aS90MERZdytWZUMyaTQyeEhDTStEQ042?=
 =?utf-8?B?a3g0akdiUGpVREoyWkoxcnNpTXhMZ2drMXpydmV0MFdrSmhTUGVGM3dZWjNk?=
 =?utf-8?B?YXJTV3RjYXJ2SXBCa1g4VUN2c080NHNhSXFrTEt2alIzNVhCdG9GZ0MyMWFz?=
 =?utf-8?B?cEJoRm1oQ3Q0K1pmRVN6eit0clMvTHVxVWZhTE10K1RvdDZrTzJNRUdtTDJK?=
 =?utf-8?B?UEQwL1ppRnp4UWJXWk1aUDd4NFV3NkxjUTBBaEM5YUx2bEt0MHZIWFpVVDM3?=
 =?utf-8?B?TmtFUkJIUTRVZkY4eWNFNExEWEFzU1lVb3kxU1JOcER6M01XWUNaQ2J6TWVW?=
 =?utf-8?B?dVEwTFJMcktKQXlrYXFPZkUvaEx6OTlHQytnYi93b0RsV0E4Znp5bC9ZMk5a?=
 =?utf-8?B?aERneHhxSEwzUlIwRjRWZ0RQMmZHK2FUZWJXYWt4OFRMMlNHUUtNekZiWnQ1?=
 =?utf-8?B?QXo1WWpPTzhBZUExdnJ1dVNiQjdDWU11enFSdnlrREsydmpCWENjVWRxQ2t5?=
 =?utf-8?B?YStHSUVoN3Y5Z3RLN1Q2OGQwOHRYdjFTdHNra2ZEWFVjUWs3c3hLYVpONWNJ?=
 =?utf-8?B?YkpBTVppbFRLdzdXNjVoQURWdERVaVI0TXpUd0I3b3BQU0VlenphZVBxY2FN?=
 =?utf-8?B?bG1oUEI2amNvTHNMdmtsUHdaNkgxelkxWlFNenpsanhOOGl3Z0wxaFZFVzRX?=
 =?utf-8?B?N2Z3WnpyNy9sTGpEdlVHU3kyVkZsZDlxeHhJVDM5QlYzRFllanFtU1hHSzcy?=
 =?utf-8?B?UlZEdTkybEdNdGY1VEgvbjg0ZzNkWnRZT2pnWmhFWGs3Q2dGbUVvbVBnajlO?=
 =?utf-8?B?cnFZQzVIM091aVdybWtxbDdLUFFvaURIeWw1ZWRLdkpGM2M1NlZaZGsrbEpV?=
 =?utf-8?B?R1J1bVRsQlkvS2NyZzdoRmV4elJ6QkMwMHpwYkFiZW1MTmYxZkRCR1MzRzFO?=
 =?utf-8?B?bHp5VHUrSXoydTYrMDc0R3M3VXRFMzZUOEsyNlVpM29qanJ2V21Tb2xXR2M4?=
 =?utf-8?B?c0hPUmhDWmJpdXhWdVBFdkQ3ZkhUaWVWRzBGb3hSNTg3ZmRyMlJTSHpvOHJ2?=
 =?utf-8?B?MDg4MzNYREJZcEVxdmVHK1doQTZQamVrVmc0VkJHTXEyU1EwRnJJYkFsc0w5?=
 =?utf-8?B?STFMV2tNNkZWVjF5STBJdG45MkxHb0dMNHY0ZTJvZ3h6UWhOdjRVUWw2Nmo0?=
 =?utf-8?B?bVpZSEdXblBGWm5xYXFzN2hwUGpZei9GZzRYUnpDbTh3WkR2YnFWdnNRbVdN?=
 =?utf-8?B?dFZTRzlJRkREV1FaOHZCVHJaODJJb1ZUMVQ5djc5ejZ1QTBvRkVvR0JrZjQ2?=
 =?utf-8?B?bXNjY09hcjRtQjVzSEtVSXphOVIyODlaNE5GaUJZYVA0Rlh0azkrZkxKaHJs?=
 =?utf-8?B?a3YvU2h5ay9MY3FKUHEvRzg4b0RWbjdGeWJ1blYrYjd4UzRFclE2V3BGK29J?=
 =?utf-8?B?dHJjeDAyT3R6emNDRmFoVVkrYmQ4M2Uza003bkorZExOUTQ4d2YvaGloOGVi?=
 =?utf-8?B?NWJFVXB6VGNtQkg5Mk5hZ3FHVzBHMllvcnpLbHB0ZUJTSTQzbnZSMlp4VHFa?=
 =?utf-8?B?bVFQYlZDK0xxSlJoTHdCdnl2SEd5dU9zeW1YQ0orQUY3elFTcmdXcEVxdnVP?=
 =?utf-8?B?bVFSVUVxaGhNTE9XSDY5Q0tyejFGZ2FJd3JWbGdmalhWU0NIVFpsV0xSdS9q?=
 =?utf-8?B?bW10djFlTjRSWFVWV2htcGswUDR6VVpEZUJ1Ry9Sclo5ZzNEQk4xSm44Y05t?=
 =?utf-8?B?YUdYMFR0WFFSQUxqYWxiM0RUMHBGLzF5dlQxbjk3TmpiSE84c3NxNVFUbEdJ?=
 =?utf-8?B?OUtKMkhmT1VMcnNrWVpDWXhwRWk0VUgyWDdTOEh2NjJ4VVZTT3BKUmlpSXVL?=
 =?utf-8?B?UWMwNDFNNlA0aDNyRzdtRVNQYmFqcmlJWjlScmJCQWlSK3lEM0IxeHRhazZl?=
 =?utf-8?Q?7m64=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdCUStpNjBUUHVIdThVVnJRTDJhN0V2NVZCS0RzdUlNWVVVd1lUV09aL0o3?=
 =?utf-8?B?YXhHZFlydktrRmw0NVIxbzVBYndQNlk4Ymg1ejNvWlBNYTRNdjUySmFOVVcv?=
 =?utf-8?B?am9hL3U5dzJIYW5rcHN6R1d4OU9ScHFDY0RkU3lXeTk5RVRuT1FpL0RwNzFo?=
 =?utf-8?B?TlhWWGMwV0ZUSFRJcTlRTHM1b0xUVWNJblhTbmppd2xnT2Q4SEhvVWhKUlBN?=
 =?utf-8?B?bzlUVjlMdW5sZkpxaUxDWGE3RHVwbW9rUm55MHpEMCtyNWZXaVFBay9CVTZp?=
 =?utf-8?B?TE9Wd3dTeS9ucGFxWHlFUVhWSWhjbG9RY0RjNmRsSWhGMFFWekkvY21PMldT?=
 =?utf-8?B?R0VvdlpRTGxRVndRdExIU3gwSEVMYUNCZkNSbzN5bk8welhTZDhQcXB2YWFN?=
 =?utf-8?B?R09aYU1QOHRUSENSeWY4bjZKTE93TVZFQUkwMWVobkxLdTRTNk1kL1FZVFpF?=
 =?utf-8?B?cklQZWIvSzFLZnpqcnVUbG9WaW40czBDbzhVQ2phTW4zNTFFdjVNRnQrcFhJ?=
 =?utf-8?B?OEhFdUJiWmo5USs1aVR3VVA5TVZEcGZWVU8wclZSd0RoMVhldHZMNzdFbWw2?=
 =?utf-8?B?b0RuQnh6eWswWnpMWE1HdGpJcGg1NVdiMUxuakQwREg2UC8wQ0ZnMFdIRUw1?=
 =?utf-8?B?aFJrd3VVaW9FN3EvSXpISi9yMXZxZlRNcEVLSnJKVUtsQkRBUDVhOU1UaGkz?=
 =?utf-8?B?ai9PM09QcVFvT2U4Yi9hRExQL3ZneitWNkl1dGV6bEpyZVJRWU1pQ0o2NU5C?=
 =?utf-8?B?czcva1RPa000dEQ0UGZpNDV2cGxpanZtNzdVT21MVURhaE1NVkh1SUc3Mmp3?=
 =?utf-8?B?Qys1aGg1MkI1WXkrS1psMlVwOGoyNy93Z1R3UW9Ga3V4MkxSTEpFaTd4cVhm?=
 =?utf-8?B?bzFRa25sUnI2Q3plRlgreXNSMnhzV1Y5UDFkcmpwbzVYamJiajV3bFBtVzVo?=
 =?utf-8?B?a0U4emZqM0dkUitiK1p3MGp3ZjVjalZZTjJaRXMwK01ZSlpYTzNBbll1QUpD?=
 =?utf-8?B?TEw2aGltMmJxYUNSYTcyWXdUVWd2TXYvelJQa3gxTDh2MUZ1OTFnTlM5K3Ri?=
 =?utf-8?B?SmcyUy84NTcyNE5OZG1ROHJPVHJCWmdQUnRVUUdlU1pqZHAyOXNFYWFGUzNp?=
 =?utf-8?B?dHdMcVZkbWRUMWljajRPdzJ2RXgvd2NESUluTTF6M2NxSXlNSjdmSnBrZTgr?=
 =?utf-8?B?YWFuWno5ZHBVd0paM1o1WDMzQThKVUo4cVczVHdYVElJbHFUQVFXd1FuS2pz?=
 =?utf-8?B?NkxRcXd4eGNwMnA0ZzhMMk9pYUQvanpaYjhzV0NqZjZ5ZUNIMDRjSnpleCtj?=
 =?utf-8?B?eDI5ZUNFNmJ3aTVzWjRzU0V0eEc5VXQyWFdzUHVlL0taaUl1TENnS2d2bE4v?=
 =?utf-8?B?VVdWVGR1dy9uaGZBTHdkTEd1bjJXNXA3V3FIR1JuWFZEVndKZEZXN0hlUEdD?=
 =?utf-8?B?VVlhWVFMbmFabmtzSi9oYnVEdTVxKzlQUmozSGt2TG1uVlArYi9RQkN4VW9J?=
 =?utf-8?B?OElMdHlQTm1relQ2QXJZd0RXVm03VEM1KzNTNkZFNmVjZEs2WXJCRkVjbW5l?=
 =?utf-8?B?TGNPWnl1ZGpyc3ZrcnhkdzZOS3BFU2VkWDNvcWJFVmtsTG5uK0hnTjU2VUdR?=
 =?utf-8?B?VEJWRkkxK2hrL3ExV2EwVm9PSElzK2RxL29BdEptSEJaQU1jQjJQK2laWDZr?=
 =?utf-8?B?aGlSeFl6aXpub2JSalIrdm01RXBRcStYUE5WaFYvT0VqNUxOQ2xOZENadWov?=
 =?utf-8?B?V2NNa3Z0Ukxobmp5dUc3ejJ6YS9TVVljYy90bG5rRm40TWtlNnZ0NnBoNkdi?=
 =?utf-8?B?aktYOEtQT1crcjhacVd1bmRZcXdVcWJTenV2WktKZnQ0c3NlKzlOWW5mTWth?=
 =?utf-8?B?TTNZdFd4QmsxSk9CanVrWVc4NVdib3NsQnlUdCtqNEpMOHR3UGM4K3M5aGJV?=
 =?utf-8?B?SCtBNXhkZ0c0VytSVkhieTYwdjZaTzZIRlY4TnFmMXkvM0ljS3pWVGtSd2kr?=
 =?utf-8?B?T0ZqZ0lzeStBdmtUTW83V1dWa1JtYzI1SURkRWNuS0I1a3VreHpmQlFsRDRy?=
 =?utf-8?B?TEM4SUhXT0FVblZFYVA4WHNUbTRJQlN2RmhTbnBYUUJVYytjb0JTQTVhNDZG?=
 =?utf-8?B?Vkdqb0xqOGJIRlh5WHRsdU5NaUZGOXM5QmNGMmVydjIxTHdvMHdsRmhVNXc3?=
 =?utf-8?B?R29LUFhoZTYzYkdBWmh6ZGZqclJxc2tJYi9Jb05MeE5MVjFhbEoxTlV6TWtF?=
 =?utf-8?B?THloOEdPOTI1RkxwbHNDQnpOc1Iram1MSTBJVWZXbmwyQTgwOUh6aDgyMjR4?=
 =?utf-8?B?cGF4WitpTmRNbElZeHE1aW1xTW9CNXpDRW5RUW5BbkhWZU4zOVlyQytSMEdZ?=
 =?utf-8?Q?TLrlbhKvSVW6myZ+l+LRUJcVZe8h+E1Z5QpQH?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0a7ad7-993d-4746-36b9-08de58365da5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:12:45.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCSwKiS4SeCPd1+em7ZeLM3jLCFYNdtm38OHXPXAN3DEpE/CmqVJ9mYlC4zBzuN1GisS5q6m3Ug6fJc80LGzQR/gMVUI1bg5dwXKoaGJMdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10135
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

Hi Wojciech,

On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> Only short option has been present.
> 

Actually.... it's been there, just under dump-sig and not dump_sig.

So we have the choice of either fixing the usage string and the manpage 
to use dump-sig instead of dump_sig or support both.

I would personally be in favor of patching the usage string and manpage 
so we don't have long options with an underscore.. it's odd to me.

Regardless of your choice, we need

Fixes: 16abff246b40 ("tools: mkeficapsule: add firmware image signing")

in the commit log.

If you keep dump_sig, I would really recommend to put it next to 
dump-sig and explain why we have both (we need to keep dump-sig for free 
backward compatibility).

Cheers,
Quentin
