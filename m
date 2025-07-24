Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F02C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 10:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE52082E05;
	Thu, 24 Jul 2025 12:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bK7BO2Sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55CF6835BF; Thu, 24 Jul 2025 12:31:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B86582D32
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 12:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3Douqjmnlq6ywYU3aTCdJMiv7FFzDVJO+gn7lZ6DNiyOpJTWWXfM/zQPTin+NvxTV5RpnLic6N1reO+J/rfBY9QhYZEXofOXwKBr/+E+kS2U0vDXPDbXbSPH18XsGtXSVyilnfGBpRztpJoym13ZrSo9Sk5IY5qUh9Ex0+Z/Jf1bqw77Yni2J6YG4yFp285uEnRMnGoo/KCx46Vfn0E65vzT1f6ficSabsI59/4GwClCVbUHUp+MWkQK38IrsOlbWUxM59YgCFUI3x0W8f9153326Yyr665eNy5DniEn/x5hNXDkr4hlRJ6LuFsOOp+YFe6csFsk4Al62vZRutM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGYg9e6mSaeDC64H8ZLq6SZ1qtY2QRedj0mZINlvl5M=;
 b=Ra1yd1vt+FVhz04jjdYYH8edF+NSHizqOMNlIPBQldBGCJ/sDSSDMwbShZH0zyJMMEv94uFfgayGflMdiohNCSqzL/RPKRKVm7JOsPvy0Lxo5nIHnXRmSs8JS+c++WHgD8PSKlcruVJqTfeGqTv/13Zaytqxe2F/2/RkrV56Xb1XBAKsv+Zh56qcTDaj93KvLlxuXvilveR9UN+bM4G7A5u724DAwmLWnOLVO+nY18gXs3MQOtT6sxWDCgMhtXDVkWBzoWY6bbB81Vmg00gylNPRASjNesaDUxh0QjTzZUcXNruHZazX1U070cA1u1HNvGgwPl/O7MVq5NTWAcF5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGYg9e6mSaeDC64H8ZLq6SZ1qtY2QRedj0mZINlvl5M=;
 b=bK7BO2SvDWpYEBjcYDfE/38zocoP8psZyOfwJ+6fSsIekxOpVIqMLHlMEmGPYkV0lIZ+daS7jq4sbPpWFw90fZdiRoIJRh4GuhxQdtqhWi1s8X/7ZfDc+Sloq6/+6GIke8xApnAO6C7UCP2P5wygwQXQx0atkrVWecJTuSIqmL2vFABINve1gmH6EXvbUzDu7ZGzrsi+Pto8P8FkYMKr6r43xNIh2rS4izDIJBO0q8HR5BNFxteZ6RhlC45XYpFnQcBfJNpzYlOao0Se3vb9E1FNep+plHn8T+uakPtl+ekwK8QQY4NYQKZOWEAqVYjJKA74NDWyAJ2voqsUu3PJpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7806.eurprd08.prod.outlook.com (2603:10a6:20b:519::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 10:30:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 10:30:54 +0000
Message-ID: <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
Date: Thu, 24 Jul 2025 13:30:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250722184426.6964-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e5ac86-52bb-4170-574a-08ddca9d2b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9YRGI4RFpXWnZSUGRVRlNFRG5uZTlKbmRzQi9ZSllhemhHY3llMjBsL0cw?=
 =?utf-8?B?NUlxSGpBNHQvRUlQWm5KNldva2E2TmhLcUdvd3U4TjlJcGcvR21Iejl1SDRJ?=
 =?utf-8?B?R2JkQnNUYkwxUWdrcWhLaWdWOTNFNVZNZkpYOXJZQlhyQnV0YnRiYjdWZEQ2?=
 =?utf-8?B?MHZLWWtMQmxhdnFZOWxTNHZmYUxDeSs3eUJYWHBYcHIxaWR1bE80NlBFckE1?=
 =?utf-8?B?YnE2YlZOYkdCK0wrVzhXb2N6dGdhVnRDdlBSRE1jLzFyZ2tjNGxCRWxrRnFk?=
 =?utf-8?B?bXNZVnpaR1dwbUJ4d3JDNmpaRHV4SjMyZmhJVGVhblJBWUk5V3VLbXlYeVdl?=
 =?utf-8?B?Y05MQlN0RUdZV1BhdlpSOGE2a1BOMk0yMGpUWFM3MjkrYy8zMlVPOVQ0VFE4?=
 =?utf-8?B?d2hzSlFhbHpyWXJ6Wms2bjI2TEQzOVViaFk5Z1RvdjY3UW9qRW5qNjMyNGl3?=
 =?utf-8?B?MmFabURBdUNua1I0MGZtakg2UHVDaUNPRW5GUk9SKytzTGlISVVYNHgrMmVq?=
 =?utf-8?B?RjY1aWt1TmtXUmQyamFqQzlqc0NoK1BGT3JXdlZzcXVHalNLZE1oWmZVMnMw?=
 =?utf-8?B?eW9MN241ajlON1dubEMxeThSRlAybVplQVVDWFpKeGRVTnJTdmFBdGM0aVRZ?=
 =?utf-8?B?c2U3M1JvaFA4UHJHZVZpdWs2K0U4b2QrbUtISlRmd0JwZitOa2xFbE5WNnUw?=
 =?utf-8?B?OEZ2WU93ZlEwSVRjZ2t5a0FKT1dibWVYWXYrOGZ2NGFIc3k0b0ZRZlBOd3FV?=
 =?utf-8?B?RXJ5ZWFLZ3psSzF1TnN2SHFmMFpBOWlrUHdrb0dNVkRvT3hNV0YwSHI1akhK?=
 =?utf-8?B?aWZmQTBzQVlLNXRQMEg1c2t4YjA2Z2NoMEs5dlAraEcwZ2RpOWRITVdyOU9B?=
 =?utf-8?B?SE5SYlVmU0wwR3c2RFE3NTZ4ZHVDS0dNYnA3YmpTaUQ1UlNHUDRkU1Y4eVRv?=
 =?utf-8?B?dDd4Q2tnNEU3TVYvWVpWOUtKYkVpbFU4WlpaZ29NNFVqZk9CVzJyRlB0UFE0?=
 =?utf-8?B?QzJVMWk2a1Z6UG94dk1Qc2QwdzRKSkpVS0R5MWRlazRrUVZ6Y092RUZzOXY4?=
 =?utf-8?B?RHh2a3FDWGJVT2dwN1NjQzB3MkFJWitpTFRiUENMSXFVZFdUa3BEYW1rQ1J1?=
 =?utf-8?B?N243TFVrcjduYVJlOUE5VGsvQS9PU29KWjRYVm1ZK2lUa2p0ejZXcENvQVht?=
 =?utf-8?B?Z3pGenpGWUtuZ0NRQkJ5dXJpMzFGbDhSM0JKMmE4enQwblo5SWxwOXRHWDhy?=
 =?utf-8?B?a3RPdThORW5relJNcm5QOUxWOTdBakw5bUhGZCszWERqSHFNQ3pRZmJzMGk5?=
 =?utf-8?B?MUZqdFU4MmgxR1F2QjNNWnJYeDVmSzJLSEhGNlNRMnNrWmJOMDN2ajhSTXNm?=
 =?utf-8?B?VHF1Njd1WHNwcHpvZi9ONDVnMGRKZlN3ZHdyWEh6ZmRMclhTNVlSaWhiSFln?=
 =?utf-8?B?NnBNdDZTYU1ZMlpxcFhxSlFKSFkxQ2F4dzRweTBOZUFsYWc0RER1MFdnUzBR?=
 =?utf-8?B?YXVUa0VodDZGQy9VMjRvRjJJMlNoUUdTZUFGS0tISjNjaTJiWEI2dWhnNlhC?=
 =?utf-8?B?NHJTUkNkbjRRRno1RGIzYkNaR1MwN1BqVTlQbWNpanpyaVNrMFd4dkVESEFB?=
 =?utf-8?B?OHh4YVl4QjhnUGZTNWw3K2UvZ2N4b3lNNytrNFRlK0wveUdWS083ZFZiOXh2?=
 =?utf-8?B?T2RRNkdwUloxdkp1dlVYZ09reXh0bDY1TEt0MnlpN3lmQlV4S2YyQUpzdW5F?=
 =?utf-8?B?K3ZxdmcvNFNTVC9oN2FRaWZQYWpkUDE2aWxVT2lxbytCQ3hGejBMeHcvU3N2?=
 =?utf-8?B?WWFjN256YStnZm1vSEVIekcxMmRJc0p6b3hzclR6RFNacC9XVDRnWGExTDhZ?=
 =?utf-8?B?bFpXczhwR2lzWGVzZktrZ2x2UVpEMkFNSFBEQXlPbHU2NFRtbzl5RGVQS2Rl?=
 =?utf-8?Q?d8LY0XEi0R4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZTR2ozYkhjc3NnZUE4Tk9pYmpDZDQwTkZBVWxvRkV2RnlPS080WXNDUHpu?=
 =?utf-8?B?WDFYK1cxR1BhZXBzZXhCQXFISUNzeUgzbW9icCs5Z1lzbmo5dS8rUHFYQWlx?=
 =?utf-8?B?c1JMamt1bTR3ZzhaM2J1bHc2dTJxUzBpZGloVTFhK1lMd3lYaitKMWZSaGJW?=
 =?utf-8?B?RnJNVEloVVpmVi9TN2RlWGYvWmM5VTRHQ3ByT0RXV0pKU2dhOHZrakt6SGFP?=
 =?utf-8?B?VEpPczBKZXFmVXlxTTZnZi92WnJ6bGVmYXJOWURkT2RhbldsenNmVWVYZUg5?=
 =?utf-8?B?Zll3ZDQvMjdwaFBBdDFBYzk0WjlLaUpGL1NEbzEwOVFRTXl1YXlCalpWa0tu?=
 =?utf-8?B?R3BCRDd3aTh6NFpmeVM4ZS9NUEFsZWxaRjAxRjZLUDhXUjF3Z3JWNXR5dHZI?=
 =?utf-8?B?b2dsSG41QVUrWDh2UkRqbXlxenJqTDh6cHl1c3VKMlY2Z2F1aFVlamlyZk80?=
 =?utf-8?B?dmY1clg1cDQ2NUV5ZnhIZ2trSjhWbjN0SVpNVkEyNUJOOUw1RUlwVWxsTzEw?=
 =?utf-8?B?R2hlM200a0UyTEFsQVNYZ0tzbGU2cWE0cXZaVGgwUURNWkhEVGtERHlwQWNR?=
 =?utf-8?B?ODd0M2xSNVdmUVRuaWwrellNZ3dxMmNvNU9pMzJpTzFOcHAxbHdqSmkrOUo1?=
 =?utf-8?B?bjhEOFNhN2hyeXpwZWV1ZmhFYno0Nnlwbno2Y3hncDdmL3pvdnk5YmY4d0FV?=
 =?utf-8?B?TnMwc3ZUb1V5RnFza0VhUU03QThsdnpNN1IrWi9VOGZVUWtXekljYWU3dVBh?=
 =?utf-8?B?U3J3Lzd0RCtGaEtibmhiQVpWaDlSTThqVjI5emRDV0JidTAyTm5aVWJDU1Uy?=
 =?utf-8?B?cjVOMFZZeDlSZERqYlJKVnNWZ3h6WHNRdnkxcGJIZkVoUFcxNjhNcmE5WFZp?=
 =?utf-8?B?UnNwa0R0aVN0STBDeTdReGc0R0tFNVY3YVhxcVpJNDQycitxT1VBYkU4UGZm?=
 =?utf-8?B?L25KbEFMVXlIUTVUSC9HV0R1MS9yWXlMNkFNb3MxQk13WmxKdGt3WkJLU3c0?=
 =?utf-8?B?bWRJUlJoQ0VDSHVLbERNVm5FdG0rT3RwTGc0ZGNFQ1dhbGVJM1pSTGtkSmp2?=
 =?utf-8?B?QzJIMm1YbkZWNUhvTjh5OGRXZTB6b3V2L3dOVDZ0YXRiUitMTTdmTkRpcUNU?=
 =?utf-8?B?bEJtTmdVbjVUTFNicjJMVFVPd3RTbWphMWpFd0I0NGRmcFYwc2pDWk1BU2JU?=
 =?utf-8?B?NEpocXMxT0dvTkx4Z2lZblRBOWZaeTNrNXMzdlhTVkVrK2V3SnRSQVZIQW9q?=
 =?utf-8?B?a1FTUlVmZklyZUltNDRqaUJDdS9rcGgrL21ub0wrRitFRWZYYXlVOTBZRTJR?=
 =?utf-8?B?eFo3Y0VScitXY0JvbFlLTWlDTHR3WFgzUDhJQTZ3MmJ1akFQbDMyY3F0dWhM?=
 =?utf-8?B?dWlyL05YRUZpODRkeUNDL2tUQkN6WmtpaVlDd3RXWjFqMmFYbnFoRnlDZWNn?=
 =?utf-8?B?NE95K3QrQWJoWWFMbkNYMzhndCtjRWtaYmxRbkJtVkxhVzJlczYxUGlqT2Q5?=
 =?utf-8?B?d2orbmtHWThIWjVDQlAzTmMxanlBYlVJNUNtTG1INWJjTVd2UjlzcFgrVHVm?=
 =?utf-8?B?MXR1NTBxN1RNU0JQN2x3U0xBZEk2akhtQTEwb3VCNzZXZlpubXl1eWQ1YzdF?=
 =?utf-8?B?bjFCOFg2aXRodWRJMjFKaUR1eHUvZjVuMXNWUTdGVjE2VkdNZnNKb0ZRd2py?=
 =?utf-8?B?U3hzbjE3a2NBUXFqZjZBRXZTSlVlaktYKzc5anVFYU1leFpEeGQ0LzcwRWl6?=
 =?utf-8?B?QTEzQXBCNUl6cVhuRTZ2dGFUbGF6RU84a1p3bVpuSmNTcHY0MnVQeUM3TXJL?=
 =?utf-8?B?U0h6bWRTaC9zTHNiQzdQUDhMcldLWmx1YVk5dXpGdUZKTnF1UDRUa3ltNndG?=
 =?utf-8?B?NzVrd3lwRFBNcENpV00yR0xPK0pndEwrd1ZlWDRRZU1mVzFnQkVZZ29xZDNL?=
 =?utf-8?B?akx6M0w0RnRmRGFIc3NQVlZEYjhWRFpmT0FqclFDeTlKUlZ1aGhjdG0wSVNZ?=
 =?utf-8?B?d2FwZ1cxRHRjNFd2ZWpKZkF2NXlBZnZrUWMrVlJWaytoaHpGV0ZGRDVXTmlM?=
 =?utf-8?B?YkxjdHhnSWRRNnl1elozNlduRHpLTmQ2ZXBLYUp3bUl6Zit3L25lazBPSk9l?=
 =?utf-8?B?eE9UeFRMWjhsS1kvRmNMYmpaT2ZBZW5aMDY3dEhDWmg2MGhiMVhUT0pDMnYx?=
 =?utf-8?Q?agyT4YNO+U1ML85S9z3irrM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e5ac86-52bb-4170-574a-08ddca9d2b8a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:30:54.7191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMqErwaHdtHy65cLMhK2AwR2IOjvJtvU2pSnzSvtXtzmNr6PFgoOBmqn86aEfuVBLr9JstoneQjCEEp6P4qJjJrScS3lqo0BWtL8SX/d2jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7806
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


On 22.07.2025 21:44, Christian Marangi wrote:
> There are multiple version of the same reference board with different
> RAM size and it's not enough to base the RAM size entirely from DT. To
> better support it use the get_ram_size way to scan for the actual RAM
> size of Airoha SoC and increase the size of the memory map.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> index d149e0ee3c8..0f72365c4ab 100644
> --- a/arch/arm/mach-airoha/an7581/init.c
> +++ b/arch/arm/mach-airoha/an7581/init.c
> @@ -2,10 +2,14 @@
>  
>  #include <fdtdec.h>
>  #include <init.h>
> +#include <linux/sizes.h>
>  #include <sysreset.h>
>  #include <asm/armv8/mmu.h>
> +#include <asm/global_data.h>
>  #include <asm/system.h>
>  
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  int print_cpuinfo(void)
>  {
>  	printf("CPU:   Airoha AN7581\n");
> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
>  
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	int ret;
> +
> +	ret = fdtdec_setup_mem_size_base();
> +	if (ret)
> +		return ret;
> +
> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);

Can we use a memory size passed by airoha trusted firmware instead of
playing with  get_ram_size()?

> +
> +	return 0;
>  }
>  
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = gd->ram_size;
as I know u-boot can safely use only 2Gb of memory, thus it's better

        #define CFG_MAX_MEM_MAPPED  SZ_2G

and replace above line with

        gd->bd->bi_dram[0].size = get_effective_memsize();

> +
> +	return 0;
>  }
>  
>  void reset_cpu(void)
> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
>  		/* DDR */
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x80000000UL,
> +		.size = 0x200000000ULL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>  	}, {
>  		.virt = 0x00000000UL,
>  		.phys = 0x00000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x40000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
