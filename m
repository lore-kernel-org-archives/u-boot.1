Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03210E9463A
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 03:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854448341A;
	Tue, 10 Feb 2026 04:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tUhdskCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AD583C65; Tue, 10 Feb 2026 04:56:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDBF8341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzwLsgThiMmM/cy70mrq812SnGreXvJVbs58LW2S6r3etmBK+r50LTBiKlSsWn0jJQvYLzh1BGfaw6O/2sEqoZWIkU7j+EDId6iobnZemntgUZX8++IXxjtmIuFK0K1gNqYdcsX8NaGoU9API4b9OZnuohy+rfCL8It0eiie4wqeFmV2z4JgPX96BuU6PSgtPOsMWQq/lqw4PVfv/eHD29NR1wgDyL3dK2s3JOZGp37NayLHiJO8mX6sKd+dBmHOIxGCTwNSiKSWiOwe6F4LxRfWdd0wJNCg6H1kYIfgVmYFxgaOJcZzjgZHcDpKjUAuP3j1RqrOehYG/OP2A5WTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwdJG4NwuRI8u37NgEq441f959++3ckJhJbXX/OcmlI=;
 b=ToqJp9HBvK3OucdFpJouxBXjcHWbPJ3EIjTOvcAmkEvvvi3qOd6RZUCv3UdvA9ervuIpQaCMnUC+yZuMzUKXAixFUYOcAm5fA2k3lAeJpUbbpuTMrInZqL9KggPVSHFfcKj5tQcv41kK+fTAnu2xmeiCmYuKdqcUemXHBzlcfdCSBPbivjsIftpRjFRh6Q08H8pVap7PE9/FbcT32MmDYIPCKaP6WadD8o8Nn290s5Q4tCrr3CEtlrBWCwRHNjCEjfVbcE9IxveMdMkEQRtHpkQrxfcmesOtDGVNlnplmkFMTw6ir5qT6gdvERA8CfwZzRNIUqcOZZZGkGUSPvPnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwdJG4NwuRI8u37NgEq441f959++3ckJhJbXX/OcmlI=;
 b=tUhdskCMgWl6pukBCmPiNxEkO9MS+fSn+4v56p/QRKOTn1H6IGhMGf2IZAi/PDJf/GQfk1IadD1S8aKqCRMGU2CkP8/n9mohD2w8oeBG0ZCEbyA8vJHh9j4MVc1ws9QbGQF1UbGwuia0OHntxHcWNUGitRinlhQS/v1Y9QvMFPOLmH5BRvGZhmkanMwbgMZO62vahylk5l34pGz0oyiFf6erxhO3d9S7XU+iz9eNOtk/UPw0DQiMmtJsW7/ojZ4oOwwMUUpoqbV5BTXUHvoL1WpFvD7PTmHFWDqqz8VkzHaFwhUTVeKGqLtFi17tsPbz6Xjqn1/vlJXGahIChazTsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB8349.namprd03.prod.outlook.com (2603:10b6:806:460::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 03:55:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 03:55:59 +0000
Message-ID: <ff32e2b0-1096-4d1d-ae19-d5ba29b662c8@altera.com>
Date: Tue, 10 Feb 2026 11:55:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm: agilex5: Enable SD card UHS mode support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
 <20260201151343.27560-3-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260201151343.27560-3-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf22a3a-d202-4fb2-e61a-08de68584cdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29SVitzUm4zRG5NNWcrdlF1ZEc0czduQ2pjc2dBeDk0UzBXamt3WFRFUldz?=
 =?utf-8?B?U3Nxcm9Oakh1TFdRMGxRL2FrYis1Q0FhWXJKMklvQlk0UExXNmZ5MXZyc3Zi?=
 =?utf-8?B?d2tXRDBxanVhdG9BRnJ0c1p4R0xCbnVydUN6dmc0bWh6bXduVTVuZjFxUEhO?=
 =?utf-8?B?S1NSbHpBT3lUOG5aV2VnQTV6TkZxR2JGVHVPQnY0bTBUZzU2a3hPOE9JQllC?=
 =?utf-8?B?cjFpSlYyZ29sbXdVUDlhUmpqaWdPVWpTdkJnSnZmVUFwdXBkT0xGeTJqdEZG?=
 =?utf-8?B?OWEzK1pwTzQ5RjB6ejBuWitzRVhCYm5icU5WMFZKWFFQNEZNbm0rMEtQVC81?=
 =?utf-8?B?UWp2YUdtb1BmdHg3aHQvZmx6NHNCdnNiVzRkWUpEL3Y2eEF4VWc5Ym5oUkNp?=
 =?utf-8?B?bW9IemRnKzBnVVZGbjNFaVJBUktqNlVqT0NjS2xvZTdEYjFrbngvcnVQNVcr?=
 =?utf-8?B?aEdxczBFc05NTFVsUjluUmdIbmphWHFrN1E5Qy9ScDQ5TzlCNE5adnh2YjVz?=
 =?utf-8?B?K1VlVzM3RTdSMzgyZjhEcUh1MmJvR29haGJPQi9LM1pmRUlLN2NTMlZPMFNs?=
 =?utf-8?B?RHhJQUdvYjV6U2tTM2J4SEZLNVhvZVg1cGpQYlNyNWo1NmdpeU9icmdUaHhp?=
 =?utf-8?B?T0xXSTVHTHRQSWxkUnRLWURSVkk4K0pqUjRCNUhveDZNMkZldEo0SHVQaVVX?=
 =?utf-8?B?K0NDYUlweGk0Uk0yMnRqY25kSFZQaVRTYWtMcllYYmpYczNtZkNHUE1mT0xO?=
 =?utf-8?B?L21iWDBpdTNlUDZTYWVML2ppbmY0dHFyUkJMVnF3OGFpUE5RSHAzWElrZTR2?=
 =?utf-8?B?NzdvUWs2RFRFRDBhbFBSRmpvNEZ0OFUwcmN2NVpMSE9pbm1jTnNqcGlaRmlt?=
 =?utf-8?B?T1dORUtKR1BrOVY1dTNERTFZMzhpVEZhS2svMm1CQWVmRThIa1ViSU5UKytC?=
 =?utf-8?B?TVJxQ2hDV3hqUzlxTTh5N2Y4SGhvbU92RVFVMlJpVzVtL0VVaFg4cVVlWW1k?=
 =?utf-8?B?UUNDQVQzcmVJRy9KY0VDdjlxTDBWSFpXVU94QnUyc2VOLzlZcU1td01tUGVp?=
 =?utf-8?B?RmRZNzI0SGM4Qk1WSGZYVGFMMUtGaVcrdDBrUDMzUHdRUFcvY0t2OWNleHpQ?=
 =?utf-8?B?OUlHQkhZMlhqRE9HN0IzRkRqbzZjR1U0V0c5bFRjUWgvMTZqMDQreW1rdHYz?=
 =?utf-8?B?T1ArNTM1aGVVUmk2WU9aOGxLdFREajY2ZW9HQVpvblJ6TVdJcUhRTnlYMzBa?=
 =?utf-8?B?RkxTL2xGTVNISGhPYnNxZ282UTlNQytydms4WEhjYTdLUGt6SUl0bXZ1Mk1Y?=
 =?utf-8?B?bFZwbGdkelV3ckFiWWF3N2ZBY0k3aFp0ajVSczdXdkFoUS9Ea1NNNHdLdTJl?=
 =?utf-8?B?eWYzZGdnUEtsL3NaU2NnRU91ZXN2QXlrRFdqLzlOeHp3WlJKMlBlbGszMFlO?=
 =?utf-8?B?Z2IvZ2RVbk9LVU1sUEFJQTIweVErYVNEeVBQU1BYdkRDTGlXLzM4bGFsdEtG?=
 =?utf-8?B?ZmRscEVZUkd5dnlzYXdobkNIcWgzN0FVbmY0TTdCRTZUcmN5UzhnQmVza2E1?=
 =?utf-8?B?Vm5BSTlhNklzbk9Jcit3bG9kdXA4eFpOUUxUNEZyTkJWdkhkZXI5eE10QVpr?=
 =?utf-8?B?OGtrT1lIK25iSkhoZXRTVFMxT3AySVhDN0VDN0QrYTMrM2IrOS9OaTVZR2cv?=
 =?utf-8?B?b2ZDWXBoN1N5Zi9DclYvQ1lGMm5iYUtnQlpJUWFqb0crTmxJSkZXMmZsWERm?=
 =?utf-8?B?Ui8waXlwTEV1OVF3eTVKMjloaGRIbnk0d2s4S2JQSEVyTlhkNDgraVh5VkpV?=
 =?utf-8?B?cWhZTkdCOXVJeS81NGZWMjhGaWoyaXoxa25RQ21SYmFxd0RtZGFsMjE0TG05?=
 =?utf-8?B?N2VPdnpkV1dSWCs5c2owZ2JwUTc5RGowMGNhQTZ6Q1J4R1JLMGc0cFRMcW1i?=
 =?utf-8?B?UDdWb3p5K0NSVWlkOVBRelpxaFZSMDM4enFPZSt3VWhjZUxsRS9zT05OVXo5?=
 =?utf-8?B?K3o1RUpTNFRkOXlGUm5wSDB4ek9lQWYrY3c5ZlQ4TW1Jak9Kb0xHUkpYc1Z1?=
 =?utf-8?B?OEFKVFNVRFBxVEQ5TG9qUWV3cU1STzlwbndMQUJxeGFzTUhLSmhkZG9DdStS?=
 =?utf-8?Q?vj+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJBbktYT0dES214Q3JoWjRheUFiK0V4bFh2TVgwVDZFODVIUis1T0xqSDJ6?=
 =?utf-8?B?ZThYWHllYXFjeGpLeWlzZFE4eG4rTzlmaWgzZHRESGU5ZlNwNS9LcFBTS05S?=
 =?utf-8?B?NHIrU2JEOVU4UW5UQSt6OStFRVQveGNzNm5YQng3TDM0c0J4ZGZLMnJNaFhR?=
 =?utf-8?B?OHdKdDVJRzBwaWZFRUtGLzBGTEpjQUZjck41aE4xWkxPSHBVVWFiQVlmK2FO?=
 =?utf-8?B?eTdkcU4ydjFhTm00Vk92cGxSR09pSlZVK1BuUWJRYXAwZUZ4UExROWxiV2Fp?=
 =?utf-8?B?TExLbGFEU09XdzJLeWlKbU40WEJDQnRMbW5CYnZWL1g0bjkrMmVLRkU3RUZN?=
 =?utf-8?B?Ym9rYkVYczZaaStiV0ZXUkdtRGZ0M0V4MHYrakJVZ0MyRnIxbGY1dlpjMWhk?=
 =?utf-8?B?VzF4ai9tRnZhVUFSNmlMNVIrYWQ5bE5IbjV5K0tLbEplYTlsL3NIMmcxK1hN?=
 =?utf-8?B?ODZqVGIwZDhWRHdOSlIveUVMTG5kdDJhTk9LcXppbldabkxYK0p2R2dnRGRN?=
 =?utf-8?B?OVN6UnZRL01CcDlFZzJsMklPYkcrck1QTmc5MVFtSlhST3FpSFROUWwzYUlp?=
 =?utf-8?B?R1JmMnVDTjJQK0R5N1FzbGlJdklwN0dOZ21GeEtOYk12aGU0TW03NExlMXQx?=
 =?utf-8?B?U0UwNDF0RWxURWNPN1V1RTFQWWJJTnBqNWpWUHBsc0JPaGdQcFpHbER4QjJ0?=
 =?utf-8?B?ZU5lMGVUb3Zzb0lTdWs4T2k4ZllpVDdkVTh1TXJsR2w5aVBGSUwzNFdlRWxm?=
 =?utf-8?B?Q3pjTndVTVFQTnVVclJrc3dkeE9xRll3MzhQZ3NFTGxQeVBVRmZvQlcwY2ZZ?=
 =?utf-8?B?UjF6NHJTVzROZ2RhNUZwSVpmblVSbEZzdkJuTWZkMnNqbWVqL0p6c1F2WDdn?=
 =?utf-8?B?OFJmYjFpMEZlQ3Y1bS8wcWVXcWpxZ0E3dW1HSVQvR2N3djAwOWZUR1FoNTc3?=
 =?utf-8?B?aWpIS3RPUnd5aEVoZmwrQTZub05UUXF3ekc1ZE9oMjFlZVJmeDlkNm1pNUhM?=
 =?utf-8?B?R1B0WHg2YlVxUCtVOUdVZVBTQVF6RmJYYWlJamkvMlZiM0E3dVpYREZmck5l?=
 =?utf-8?B?L2tlZW15Y1FIYWcyMStjT3pFU2pGWDdGYkh6K2VZZml0QVVSTHRyTFFnYjZr?=
 =?utf-8?B?U3paSVRMSW8wWkRoVnh5UGltUXdIRSthTmpzcjFBdEhQSTFWZU5ydlpwdk5w?=
 =?utf-8?B?V0FsMm1RYnNzQVpqZWdwdElyS2l6YVNXcEJadmxOMjdHK3VmSzJ3YmhiS0lB?=
 =?utf-8?B?SWY3Ykx5MENvSFROTEdJV2RYNjZ4OG5qbG80ZnRmaC9DakJwVFZXNWFURHNZ?=
 =?utf-8?B?ZmpDV2w1cVY4ZGpBUEwxY3ZMZWRJNDVJMXk0VnE1dDVxZjd1T1V6OFhIUDd0?=
 =?utf-8?B?SWVxZThBbkRob0JiTmN2YkhPeHBQZGppeHhaeFVEWnYwYUNqTko5SUJEbkZV?=
 =?utf-8?B?OGY1QVg4QndUNTBPU2hmMFRSUStTbFZQKzJ3WlJYbW12Nm9tMXpyZVhrZWYz?=
 =?utf-8?B?c0lyQi9VWHRudjc1ZkdyVy92WGI0WWlVMlh6SmVVVXJjcnlEcGRaUWptcTBG?=
 =?utf-8?B?OUN4MWZEWVEvNG9oMysxR3VEejY3N29UQitsYWpSc2Voek1Za2h6UkVQMHBh?=
 =?utf-8?B?RWJQSlpKUmE4K0FpaG9kN2FBU2tSQ05DdDJKQ3ZhUmlLZFRUejBZSjgvUmha?=
 =?utf-8?B?VFJpQ2lKbVJTVXJwWkMwNEIzOGJNMGNiek5QeG10b3gySmhWSDExSDNDa1p4?=
 =?utf-8?B?bnAwT3o0MnpmR1NLdGx4OXVaUTF3UkN3aXVuSzhWRHNYcE5YSC84YTExSlRR?=
 =?utf-8?B?ZVlnVCs1Y1prK2JxaFFhOHJ3TWZkcWpoZzdybk5qU05jdElmTk9aVmlsZDBC?=
 =?utf-8?B?VFFtTTVMUTN6THZFR0lrcHVQOXR0VkNjTzdZV0lzL0s0N3VHZnF6anN6RmYw?=
 =?utf-8?B?VHZCekozbS9nU1FnTHJMakk1TDlsOGRBUUVBZWxkSElOa0ppYnpLKy83UmpF?=
 =?utf-8?B?WkpPSW9OalRnb3g1c1RvRlpFakpiejh0dmRkaXYvRUF5WmszM3k3VDVBWHk2?=
 =?utf-8?B?d1MzNU1MMVJJNzR0bnk1eWZPSmpXWkMzL3RZYTRoZWlib25DUG1xYlplK1Jl?=
 =?utf-8?B?T2lGaVArd3hzRFA4UXhtcGRsVHcyUlZDVk1TRkZEQWxHSXB5T1JJRWYyeEFT?=
 =?utf-8?B?UUJySDlrVTlvR1NqdHVMOGpEcjVnejdXUm1xNm92WkhMbSsrS3JXa2tXQ1Y2?=
 =?utf-8?B?MkNXMVg5bWFiN2hMN3owM0FLK25VdDVoU3JnaG5oTGQwVjNSOWZjODZwSXN6?=
 =?utf-8?B?ZzAwNDFaRGtZWmtSWkpMS3FuSDFnMklwZlNUY1YxSlorUWxxc2ZSNmxvWDZ3?=
 =?utf-8?Q?SZ1pazaNjaSvJn9Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf22a3a-d202-4fb2-e61a-08de68584cdf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:55:59.3008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YsjzhH0ZXQhUZxzWqC3tXHNRqNTH5+fjAfCU0EDSwmCQVB21mo4FKMFO/Nmgdi8AuLedzQE91PV5RLAtGjyrhDUz1/AQEpblCWs9s9wbr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8349
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


On 1/2/2026 11:13 pm, Tanmay Kathpalia wrote:
> Enable Ultra High Speed (UHS-I) mode support for SD cards on
> Agilex5 SoC development kit.
>
> Defconfig changes:
> - Enable CONFIG_MMC_UHS_SUPPORT and CONFIG_SPL_MMC_UHS_SUPPORT
>
> Device tree changes:
> - Remove no-1-8-v to allow 1.8V signaling for UHS modes
> - Add sd-uhs-sdr50 and sd-uhs-sdr104 capabilities
> - Add sdhci-caps and sdhci-caps-mask for proper capability reporting
> - Add PHY and controller timing configuration
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 25 ++++++++++++++++++-
>   configs/socfpga_agilex5_defconfig             |  2 ++
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index b443e57b1cd..c03f78b2fdf 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -110,12 +110,15 @@
>   	status = "okay";
>   
>   	no-mmc;
> -	no-1-8-v;
>   	disable-wp;
>   	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
>   	vmmc-supply = <&sd_emmc_power>;
>   	vqmmc-supply = <&sd_io_1v8_reg>;
>   	max-frequency = <200000000>;
> +	sdhci-caps = <0x00000000 0x0000c800>;
> +	sdhci-caps-mask = <0x00002000 0x0000ff00>;
>   
>   	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> @@ -130,6 +133,26 @@
>   	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
>   	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
>   
> +	/* SD card UHS-I SDR50 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
> +	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
> +	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
> +
> +	/* SD card UHS-I SDR104 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
> +	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
> +
>   	bootph-all;
>   };
>   
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index 5fbc49b2307..8a3f9563af2 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -87,6 +87,8 @@ CONFIG_DW_I3C_MASTER=y
>   CONFIG_MISC=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_SPL_MMC_UHS_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y


Acked-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

