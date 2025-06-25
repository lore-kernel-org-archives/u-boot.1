Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB851C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BAF803CC;
	Wed, 25 Jun 2025 15:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pXH8fEcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8228006D; Wed, 25 Jun 2025 15:30:16 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEAE82DF2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4kvT/K+7TOlI4VFeN11bOwza1OAghDgU4TQeVvx5I3S6vPyZXSgF+g8EyKpk63xz8/BXaLWfx5Q1XVDE96gTUTJfMjbVklSv3XOwBmp23UzaEo8jzLEMfdnqXXdlOOwzP0LN2XPSNUWORc4AEVYGlc48UuNe7gJHuBN/ByDnDiTP/gPueb5qBW3d89uiD85E7h+wVP/dcNAbdwT2vW0n6MD0+oChcQ532+7DPwNf0cTNLIaiuv/RZsdXYeA5rAEx4JUR18xxZ42B4w6/+6laIJ1YnXHIMha4H7Mez+3qi9mvMIGX0IBLGSVaN+zp+PJjzHZlAmwB8ZZTpBCbELCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0gr5MD2eVkNa1DytXrXQtxNpzTHfdmeVDPN7ewm0KY=;
 b=OZ7gEmvuIGddwZvqGnelSGhsLf21gg1RRiyvCTTXJVyitkOtOqKA51AHxzYJXsZGPHm5hRxMgS/RbbbHSD0kZfqeQ5KCYf0ZvBF+J47fIC2he/d5kexMWiVNXawoGvH6SbTGPQ5rE94L/WyOUTjZx2hfulALfg6GrwbmnKfLzq1Tzv8FX+P/xb1K/wW2i78d/u5DW453ngKGY+2YAKWZsc3ykSX1Vw4r0KjaQEozqD4h+AJC+8hMABZGLFDNOMSCes9PUyuUnj6tOxEwxomRTHqn55MRl7ExGKsev3oM09bXoMGCEofgzU7yL9N9ojzFrmZqshIfUcFhuA78g0bAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0gr5MD2eVkNa1DytXrXQtxNpzTHfdmeVDPN7ewm0KY=;
 b=pXH8fEcWO6kU102n02ajXVwTVPGetiSx6YVCF48Dh9aCbghSkJNK1HUywpKhMOUkK2gOXeTMX+oGt9u0Efj9UVXnFxxln0RyBxjBPf+vkPflP4VYqyiGAoGL/P6WbNZ0Hl1nN6pEqmVP2Z2SBUWvpR4dLK5dJnV5FnAN4YrBs17VhO6KROH8xAkuFBdwptiopZkjaEEb/ftOuHWv1Cfk6S8CeHoPKkUSVtl1OZFigvT7d5wg+YKpNynYsRhMyiKDZjssRUUMHvNkHvF3aPQXjzCNlQ47u0OgHH5VfV9pRTLTs1XMdAU1lrW4295a0KlEWxd37JPEm+M8T07Xs4qYpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9409.eurprd08.prod.outlook.com (2603:10a6:20b:5a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 13:30:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 13:30:08 +0000
Message-ID: <4bd18e83-a12d-4f1b-ae6a-b6b7566128e0@iopsys.eu>
Date: Wed, 25 Jun 2025 16:30:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer
 access in spl_fit_get_image_name function
To: Michal Simek <monstr@monstr.eu>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, E Shattow <lucent@gmail.com>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
 <38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de>
 <CAHTX3dKdeM=NyjBJVRrZTLiuV3FuoyfvoLvGG8pPgA24o5g9qA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAHTX3dKdeM=NyjBJVRrZTLiuV3FuoyfvoLvGG8pPgA24o5g9qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 809cd2b9-0ada-40fa-72c5-08ddb3ec675e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFJEV1JieVAwaytlMHVHY0dVSHcyZ1lSd05xM2xPRmlBY3hFUmxJUDAzdi8z?=
 =?utf-8?B?NFdhK0JVaVdhVVNHNlUzT2c5c1d1K1R3TGo2RDU2REIwUktERC9Xc3JqQ2h4?=
 =?utf-8?B?NlY2SDR4VUwvWjFxdnM1eksyTXBhUm9ZaGprbVk4MFg3RlpuS1MzRVA0Rjdw?=
 =?utf-8?B?Uzd4dGx0WVBiT2VKRzlvdk5yNWJHdnB1Y1pkdGdKUWRiNDFjdndZL2RYbkgw?=
 =?utf-8?B?OGlZaURJRHFGNHpnL2N6L0JFditDNE9EbVhlbUNBMWl0NVllYU9rQkxqNFFV?=
 =?utf-8?B?VFRnVVhlemhmMEFKVDNMaUJaalNCcHNXOUpPaDROZjkzWkI5VjFjdEpweHM3?=
 =?utf-8?B?enlyNEZvS3BiUHNpL2huVy9PSjBoRy9nTzJndTRNNU9jTytLY1p6a0pjYlEr?=
 =?utf-8?B?dWZWMFRuLzNoUkU3bjA5RW8vZ2lidEJ3YUxJNWREbnprbFprTG54UVg2WTFi?=
 =?utf-8?B?c1F4dVRSVDU0ckhuNlc5Mm9NZEtTRUowbThvMEdQbkZNNWQyTkFhUGM5cjhM?=
 =?utf-8?B?SWg5THEzYXM4aFd4ZVdvUzNRL0pxRXVFN2Z6SjQ4cHF6ei9XbUlmUmVERDV2?=
 =?utf-8?B?Y0ZXWk5LU3BtRUVvKzdJNjI5eEhEUkVKUk1pbERLaFh4RzBFVmd5SDYrT1Ft?=
 =?utf-8?B?bWFmazZGK1MvYWhod2hSUGQveGF4cHM3cXNNcDJaUlJiZFFqZTVwVEZHaGww?=
 =?utf-8?B?RDdUekk1MGI4MkhNNmFqT1NrSTVEVVB0UDFNcUd2bFpQVzRGVlpVOXJOUUUv?=
 =?utf-8?B?YWRaZWZzM1Jqa1U1NEs5YWJvMjVZb2NVVitXM2g2YzF2bW8zbklLSS9GT2JU?=
 =?utf-8?B?bXlJRzdSNisyZUFRaStSUWVGOUNEWG9PZDB6V3VSRlpIZXZWMWFiTWFDbXgr?=
 =?utf-8?B?U0VJZ25idzRtc0QweGU4eVBlVWVCMjBuUGlwWVdDYmVOT0NvaklEYWJPNXhT?=
 =?utf-8?B?WHZDa01WalNoVVVWNHd5WXJJZW45NWxkVVFuM0ZINWd5NmwweFNzNVIydTls?=
 =?utf-8?B?WVkxeDJSUDJjUGxacW9xSFhjQ3JmZEFORFpadUV0MnFmL05qalQ0TnhYcmRM?=
 =?utf-8?B?VHJwUDFZREJIbGg1UC9PeGVUb1hzbEVuQm5zTmsvaDNzREVFWklBR3VBZllU?=
 =?utf-8?B?N3oyVHFqRkRRUkRIbDVyMUEyQkttYTZLdDUvcmJtTFh0WWlSRHIwVWowRmRL?=
 =?utf-8?B?VXVEV0thQW45bDZkb0hobG5hWWwxaHR1dlpTemxXbjVYTGNrZVpBWGkwbTFN?=
 =?utf-8?B?M1JIdmZkeDZxMWNpK3JwMi9wbDdPNXBKZVdMQWZEdVdZY0JPWFovMFpxS0dm?=
 =?utf-8?B?TmpSMTU4OFBKc3Y4ejVjYlJGV0dRMFE2ODFKeEF4WERsWG1FWjJUN01SZzFs?=
 =?utf-8?B?RUNIRU9Sa3pUQS81QjRVdjRrbFRFNm1wd0kwdlRIeEllYjFqbDR3TjBILzB6?=
 =?utf-8?B?UmZpbWFiZjVCUEhTa0F5aDRXK3JnWWRvNjUvZEpHemRsV2JwcjhHYS91a1lO?=
 =?utf-8?B?VUZqS09jU2p2Qm5NcmNVTnZRbm1YdFJySHc4S0JjbWJQN1hiaXdrV2VKb0oy?=
 =?utf-8?B?OHMwL1Z3dytkQ2xKVEpRb3hWa0ptOGNzalB2WmI4SlBzSEVLTG5YQmk3V1gy?=
 =?utf-8?B?ZStRb0gzM2Jlb2tuMlV3VytEYmh5a2ZCcU9sUmJ1SjJQdVM1QnpZSllVeEo3?=
 =?utf-8?B?OVUvUGNXSUJMV1ArRFJvcXNDd0FzRlFtMU5YUy9PV0dLU3FRNG1vN2gxQ2wv?=
 =?utf-8?B?NVkyT1RwamU4ZERQWktrTk9DNXZ0eVgwaHFWWVAxamJ3UmRSdlpzeC9DOXF4?=
 =?utf-8?Q?ONxwuo8VuZu6nmnWuZvD5g1I1gIFzQL8Zfn9A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHB3dFI4SHpNVDBoR1hHUTdSc0Q1RFNGMmhiSG1TSnR5TlMwK1B0NlZkQ1RW?=
 =?utf-8?B?NTIzcDJIVEZZNjFXL015OWFYVFVPcWt0R1dsOXhOc1BrWFUxbk9XdE4vR1Iv?=
 =?utf-8?B?TVpsRFBMNzFZV2JtTVU3ZDkycG5QeXRaNmJ5OUQzZ2s0RklCSU1qdU1LNTNQ?=
 =?utf-8?B?MkRZQThFV0sveWlNcktrY0lwSjJpakt2UU5Fd0J3dWwrWVMybkZIaVBRQ2Ix?=
 =?utf-8?B?NDdWeGFZTG1iUEJ0RVowdnNhQk5iWWU3R25rNzdKaEQ0cThiTEx4ZFNxUk1L?=
 =?utf-8?B?SDF3cmtQbENaK0xSRUs0TVVMSURUUUo0K3dycitTV2kwTmwveFJmYkFYTGQz?=
 =?utf-8?B?YkRoWUIwb3E4OEkxdkx1bElLQ0prN0pyNUJhTFZyRUs5Nkx3Y0xtOUdpVCsv?=
 =?utf-8?B?dGZaTjdEY3JpcjZWSmt1cWw3dWFGN095Mk5TblBIdmdoNWdTZUgwTDVLVkV2?=
 =?utf-8?B?cDh3bHZsSzA4ZzdSbk9XSWlzcVp5UFdVK0dDV2NUTU1lU1Vsanl1SHoxM09o?=
 =?utf-8?B?c0piR1VDbjNXdVpVRnhEcDRNNG9MOXlSdmtlR3lnUUhRKzdZS2dBWnRaUWJ4?=
 =?utf-8?B?eTJlSG5XK1dsNEtHdnhRbXd2cHhHRUJlMmFheGNTRmFRS3daRFFuQkN0RjFW?=
 =?utf-8?B?Q1VicnlWS0hjV2U4SStvdTllWTJpbzA5SHBUL2M5WHN4dnVSTi9NNk0yVW5B?=
 =?utf-8?B?VU5KZzRBQWd4MXpJV2pCamZiWkFUYmJtb293ekZsTEVscXp2WmZocjdGVG9n?=
 =?utf-8?B?aVpsT1A3K3B4dEVhbzJFL3loUDVyVS8rRkNtZ1huQ1ExVlQ5RlFZK0FMdllm?=
 =?utf-8?B?QzN6anp2cHcvWVFiQWh3VW9JeVdsc2NEVmV4ZFJ1WHUxV2pTUzlzQUhKNlRF?=
 =?utf-8?B?SzhwUFR4VmlaeUNPQTFBaEttRlBoeXE0Uy9jOTBmREVGTFNLWTJvT1g0MlFt?=
 =?utf-8?B?U2VzdTY5VVVHa2llbThDM3krQ3RaZ3l3OWhDakp6cklLem5EeW02Zmo5Q2ZH?=
 =?utf-8?B?eGhzbU5Dci8yQ3FtZmI4STR1Z0kwRlZEMWtjUUwwdHQ0SjY2RDJrZTkxUDlz?=
 =?utf-8?B?VTRJazZ6THBiUjZBZ1BzSXl0TExwOHZiTmtmbUZXWHhIRFVJMnNyam1RZmVD?=
 =?utf-8?B?T2kwaVBjbVovK0N6L3FjMTdMNHdLODdENFRwMERLMjJnUFcyWnV4VmhxMThk?=
 =?utf-8?B?cGZJSnY0MDR2S1RsbG5WTGFVZUVmYVVPQjI0eFUxNzBMWG9HYm1od0pIbk9p?=
 =?utf-8?B?YXprVlZzTGZEd1ZRMjVCQlBLM08yTEFPdzFwbFQ0RDljUUwzTlRPWEd0cGYz?=
 =?utf-8?B?ejF5ZnVhZnQ0L0RSLzZNVmxaUVgvMHYwVFRVa0lYVlU4R1p1cGxITkVMOTdC?=
 =?utf-8?B?SFgrMW9hWVBBcFZINVgyeWVWcVdsWlFIeUdBTmkzUHJCRFZORnhPZFdGZ3py?=
 =?utf-8?B?OTdJTHdYdGpIOFNoRzMxNHMvbjBxUUYxU3hzQ3lOay9nWTR2dXZZaWZ3S1Ba?=
 =?utf-8?B?ZjZYeEx4WE9jMnh5L3R2bU14bFp4bitpWHQveW5EZUtYTERZN2tVRjQzb3lF?=
 =?utf-8?B?VXVoZlB0aXFkTkJ1Wk8wQVd1WHY3QnN4aTdtVUNHU3dKNXZrNmZ2cGpMdGNk?=
 =?utf-8?B?aXRyQVJ5cHFOSXA4c2tScVNwejBoVXBHUW52c3ZpL3RTMzNRQzVxWS9OK1pK?=
 =?utf-8?B?NGdjckVOeExwc3VFcEdNMXZXQWhjWjVPYk1NbDcwYTlZbHZNWmxmY1BlZklq?=
 =?utf-8?B?ZUR1WVFnTTV1S0htcmJ1T2ozd0JXOFA1bkVnZUZXcEdQTm9VNFpTL29lYWYy?=
 =?utf-8?B?QnFtWGlTNnNxSXhkdnhvSTBMZVZnV1dKR1owTEFHbllNWmVNMzdydGlNS3pl?=
 =?utf-8?B?M0g1NStiSno4NkhHMHIvT3pUMks4bFd2NTk3Qi9ocXZBT2tvWStZUFFhQVpy?=
 =?utf-8?B?NzdZdGhKbWJ4dnpDL2pwNFQ1d0xVUTl1QmZhWk4zWTA5aXliVHJ6UitnRXNy?=
 =?utf-8?B?czJ0a2FuUXVia2N5eDFwZ2Z0VU83VWxYUVFoTGdTaTFPVnd6L3JObDZzSVVH?=
 =?utf-8?B?NlpPQmR1WVJwcFQvU0xvaWY3OXMwSDBoaVhsT2cvMFU4cnlJOUlzV3l0TCtS?=
 =?utf-8?B?R0t4aFd0OXZVNkpXZkEyYmI2WTJWSk1WUml2b04rRGJ0U3BVdE50alVVSmFX?=
 =?utf-8?Q?+c+DsLIRw4yc3jn4uVqQq7s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 809cd2b9-0ada-40fa-72c5-08ddb3ec675e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:30:08.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOV7nqlbECjTWMAOq+LKA5tXhSquc3xrXz6ZkCMBItII3DhNIflNCCnX4PfewT71y8/knpB33BeKOFeOpmPYfRgoQ24tkeoSHJXpmFwN1iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9409
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

I think I can fix this patch or the patchset of Heinrich Schuchardt
could be applied

Mikhail Kshevetskiy

On 25.06.2025 16:27, Michal Simek wrote:
> [You don't often get email from monstr@monstr.eu. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Tom,
>
> út 24. 6. 2025 v 14:59 odesílatel Heinrich Schuchardt
> <xypron.glpk@gmx.de> napsal:
>> On 10.06.25 11:56, Mikhail Kshevetskiy wrote:
>>> The current code have two issues:
>>> 1) ineffective NULL pointer check
>>>
>>>       str = strchr(str, '\0') + 1
>>>       if (!str || ...
>>>
>>>     The str here will never be NULL (because we add 1 to result of strchr())
>>>
>>> 2) strchr() may go out of the buffer for the special forms of name variable.
>>>     It's better use memchr() function here.
>>>
>>>     According to the code the property is a sequence of C-string like
>>>     shown below:
>>>
>>>       'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '\0'
>>>
>>>     index is the string number we are interested, so
>>>
>>>       index = 0   =>  "hello",
>>>       index = 1   =>  "world",
>>>       index = 2   =>  "!"
>>>
>>>     The issue will arrise if last string for some reason have no terminating
>>>     '\0' character. This can happen for damaged or specially crafted dtb.
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>> ---
>>>   common/spl/spl_fit.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>>> index 86506d6905c..ab277bb2baa 100644
>>> --- a/common/spl/spl_fit.c
>>> +++ b/common/spl/spl_fit.c
>>> @@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>>>
>>>       str = name;
>>>       for (i = 0; i < index; i++) {
>>> -             str = strchr(str, '\0') + 1;
>>> -             if (!str || (str - name >= len)) {
>>> +             str = memchr(str, '\0', name + len - str);
>>> +             if (!str) {
>>>                       found = false;
>>>                       break;
>>>               }
>>> +             str++;
>>>       }
>>>
>>>       if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
>> Since this patch (commit 3704b888a4cabac8) on the Milk-V Mars board I
>> see a message "cannot find image node ''" and on some builds I have seen
>> boot failures.
>>
>> With your patch and some debug messages:
>>
>> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:45:11
>> +0200)
>> DDR version: dc2e84f0.
>> Trying to boot from MMC2
>> spl_fit_get_image_name(): index = 0, name = 'opensbi' len = 8
>> spl_fit_get_image_name(): outname = 'opensbi'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 0, name = 'fdt-2' len = 6
>> spl_fit_get_image_name(): outname = 'fdt-2'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 1, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = ''
>> cannot find image node '': -1
>>
>>
>> Before that patch:
>>
>> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:34:50
>> +0200)
>> DDR version: dc2e84f0.
>> Trying to boot from MMC2
>> spl_fit_get_image_name(): index = 0, name = 'opensbi' len = 8
>> spl_fit_get_image_name(): outname = 'opensbi'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 0, name = 'fdt-2' len = 6
>> spl_fit_get_image_name(): outname = 'fdt-2'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 0, name = 'uboot' len = 6
>> spl_fit_get_image_name(): outname = 'uboot'
>> spl_fit_get_image_name(): index = 1, name = 'uboot' len = 6
>> no string for index 1
>>
>>
>> With your patch spl_fit_get_image_name() does not detect that there is
>> no property at index 1 and does not return -E2BIG. Instead it signals
>> the property is an empty string and returns 0 which is not expected.
>>
> I also see random chars printed on the console on SOM with SPL flow.
> This patch should be reverted.
>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: http://www.monstr.eu/ p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
