Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F76C54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0577884C3;
	Tue, 27 Aug 2024 16:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s8Fo0PIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D20C88A08; Tue, 27 Aug 2024 16:50:52 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC99687FA7
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlqE3u5hrJURdmFsaiEm6bdbDa2BT5PdUOyqcUK+pnpozvDmm4FuniDDXv6dEVq4lLw/SVvlZq14rfvyG2Vd+OjzlHARbK8uyZq+lmu2bYt1+tqdmlHsVBJXLM3gdJFYOhPGXoHQffbUXgQUcAeCVaL6FB+Li7i+UlF3lNUEkmNtz5y1o5WcPEUdeMEOnzW6vosvhu2JExr5ppqCPr8myso2r9rqFg7tGFQCOeITdehW/Pe8mBG2PTDnir0u8GMteHOvPP4BqRhJNH2dTejkW+9xrQliAg2zbXvjoXE+xwxikeaYDeRTZGKp243a+/Wc391T2HQvY7IveP5lHngl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjW0981DJNwni7Lsala83+DPGmIJvfXKYy4e2Hpu+qY=;
 b=dHtRiz5r6qjBKcCjErMJ4NF12eBek2mhptn0H5WbMtr3jrnOfS/RGiMhyNBUYmyyB25AOM/no8BS8h03qFPLe7JmGjmKz5I/vb+WbeQGFNSkWOhNNUx2pFf6QEDA/+y0HnxSw4c1lmyzo6UnAjagHjfiJnL7SKjTqUF7G9TtjnSUd63iuuoxoQYENYVWcawFEhnrERB8UsTsdNeX9OfZG4cdgEy0pD9TqAmVHKoiWxPL9MQGPyobqLR4X1CNlMbIDZmt8HP8gnDdMHPGajUJtg0RzH+cetejEToqDsFNs0iSVWA6KPwX8X7p1BOqvsC0E2CEpUAKwRX3x9jl00hJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjW0981DJNwni7Lsala83+DPGmIJvfXKYy4e2Hpu+qY=;
 b=s8Fo0PIqRadPpCvC1OYg4cv/ui1loJ8uQwNSnB1/jnKcAZdp8kdd+zrVsaGywnAPjrnU8uaMqG7PhbNaWkADeWF1QVMDmG8JziYLlbCzwxz4JjrbtNqGX4r6h11/BNpl2/rGIJodOr7S8kKt0ONzxHH5cOxzkthvkk2I5sI2EKPmaENmHn4VrhLL57QU7IOVxbuLk5xY8AZNmE80FVppZyH14JxhkH24ZWZ8GbJWethwn77AbJdQu2UdU4QzXkzzeQD/+WGlRiZxHMS0M5gSsfNNyD1rQ4+hD7zhIswVSr+AvU06C41lNlY2EWvRg/Rnh9YquKWOkvsx0SxwbVCZrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 14:50:47 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:50:47 +0000
Message-ID: <d1efaed9-8524-4979-b7a3-03d4d0cf233e@oss.nxp.com>
Date: Tue, 27 Aug 2024 22:50:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] imx: ele_ahab: Add HUK derivation support
To: u-boot@lists.denx.de
References: <20240826100707.5923-1-othacehe@gnu.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20240826100707.5923-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2384f2-b5cb-4258-b429-08dcc6a7a2db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2ZGZlJZTFRFUUM4Q0tLK1NuN1VWWkRuYnoxZUVKY21jSGp5cC8zVUgrS2li?=
 =?utf-8?B?Nm9rQnQrb1k0UjIzRFdFcFA2TjZ6YThvajNnUlVqT1hJM3JidVl3aWtlOEFa?=
 =?utf-8?B?bnlNeWE2aGp2T0o1ajEyd2w2TG5Cb3BhbXo3THNweXc1S0ZYMnlxUEVwT3Z1?=
 =?utf-8?B?WnFDaWZUWXlXNWpKd1BiaEFoa2RhRTROT2ZrM3hXTEVMdHBWekRCRitFVkYx?=
 =?utf-8?B?T2dzeWxUdHNsbVVjZ2x5WFdZUStiT01yZHhVNzVvRG9YUGpWc29aS1NJL01U?=
 =?utf-8?B?U20xeWJUM3dLNG5aRGhyWHU0MGttcEE0aEJNUlhIQmo2UVRLTzN3V2VEWjky?=
 =?utf-8?B?M2V3dkpCanhCZ0diSzJCWVVPanZHQlBRMDhkT2o5TDBxeEJ1eWF2UkZkVktu?=
 =?utf-8?B?R2hwUVE5c2k1OEJtYkNhendRRjcwekNnOWhObHdlN2Z3VHErNFRjcVNFcHNG?=
 =?utf-8?B?a3lVUVFmNDlrS2VjT3V6U0wxQVB5NUdEUTFKZWJqbVVaWXQ0UnNHOG1WZDNX?=
 =?utf-8?B?eXZpZEoyMTFHVjkrM3lGZ2hmdHF0cnhkVFhKZ0ZBelRVdHNSRUpnUDhsWWN3?=
 =?utf-8?B?ZEtCR2tjU0FVQXN5NktST3BrTTBRZ1NpSWlBUUs5Y0h1MkRnRk51SkFINWlS?=
 =?utf-8?B?S2hReXNGc0dpOVZGVUVZeHlHN2NBVi9lRHZKNEdTQ1YvSEVQaktyS01oT1ZJ?=
 =?utf-8?B?WkpBSjRNQjFYQi93Z1BwMks0OU9SV003WXFucWxkSFltbGl6L0toR01qOGlQ?=
 =?utf-8?B?VVVBV3lKQmd3aHRzVGFDMEdtWTBIVjNVdWRCeGtsZTlraDNJWEJEV3dxSU04?=
 =?utf-8?B?SUZKV3RydzFJa0JFcWdVb0RobW5JOStySmE3RmZRWDNQZ1lxRUFsQ0JlKzJS?=
 =?utf-8?B?TEFwTjMxc0dGVzdTUTU1c25HUmt6M0xra2tETFgwR21CSjl2R2t1aW1pVjdz?=
 =?utf-8?B?UzFwc0ZpZDdYcmh3S2EzUVpjWWF3dmZqTVRvbExBMEpYalM3bENiVCt6RHA2?=
 =?utf-8?B?dHZoa0NCZXIxQmpTcTIxdFdSSnA3TjRnTmZvR0VUTmZSbUovVXE2dWZBUjhy?=
 =?utf-8?B?WUo0UjVSMGFhcHZnVXNHOVlaV01kZFk2dzkyZU92QzU5M2crcUJtSEhUSWVJ?=
 =?utf-8?B?SVdUN25IdWloWWhaYzloMmtyRVdjU084bFplQmpwVTVORmJDZEUxK25vbE4y?=
 =?utf-8?B?WnFDQ3NNOVVkK1NBSXNvTE96ZVd6Wkg1d1E5U2h6NllkalIrSXFPL0RRQmM0?=
 =?utf-8?B?NDZlSHZYcGZqZG1iVVdBZnh0Snp5WGVGdFNvajhVYVU5OGxVdVUrQm9tRnJ0?=
 =?utf-8?B?Nk1QOTdzR1llbk1sVzB3c3VKUDcyeHdHS3MxVnJRdWJvaVhRL0NjNGNMWkkx?=
 =?utf-8?B?bmlyYnFQZEFhNi8yWUh0d1NJcGlWdnU3Z1BITzVNV3hVMFNRU3lvN3hoZTU2?=
 =?utf-8?B?MElpdDgxQTVSYVo5ZWt4elNkL3dLWW9JNzVFOUhQU0xjNVdPaFZNdC8rN0FE?=
 =?utf-8?B?a1Fycm12eit5M3RTTmxxUU9IalRCYXJYVEszVVRnL1BXSnlxQkEvaFVtWXRx?=
 =?utf-8?B?VEtSd0xxdHMrRzA5TDVFMUNIamttSXhHOCtIbFdvZmdlWkpla1NYcGY5cjY0?=
 =?utf-8?B?TnBRMFVUSXZQS3g4OHdjMDNuUFM3dnRXMXl4anhWRVBzZ1EyZ1BUNGR4c2Zh?=
 =?utf-8?B?MDcvYm1DTXo1YkFpZXZMU3BjQVluMFdDcFBIcURONjNXQmtmcDIvYVZVM1Zm?=
 =?utf-8?B?RTFQdUdqOTI3Myt4dG4vUHJmR3YwSktYR3VjYlF3YjhRZHg3TDdVd2J1dXJ5?=
 =?utf-8?B?NGVWY2pBSlRWNWJsM2h5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFd6RDRKRFlvYk10Ly9FMGo4REVHWDdlRjlnY2UxQWFHcThpMi91RFQ5RlhD?=
 =?utf-8?B?RGs1dTU4NmNZRGRRNzF6YWpnTitZNmNFc0JmUEREMytnemdEdUFFTzJzRmZZ?=
 =?utf-8?B?azdscE4vWlgvV0JScktrN3UxaTdzL0dHbFhLd2ErWkdVRng0R0k1L3YydkZD?=
 =?utf-8?B?YkdueGxzWjBCdXNPSkk5SVRoN0tFeG1UNWZqb3pwME1RdW11V1pMNUpWY2lW?=
 =?utf-8?B?dlpkOWxUTExheTVkRUFYQmxQSC9CTGJvNjRJRHZtT2Vla3lzVFVoN2R5Vml6?=
 =?utf-8?B?QlNZK2NMN25YL1RJSjdHcDVnSDZNMmt3cTRFRzNnT2EyQVAyenRvaE5pNURx?=
 =?utf-8?B?ZzZkL3JTekNKSEc0N2VDSWRzRkpXOHZRV2hndHFUdFY3ZUFJbEVROHB2bEl6?=
 =?utf-8?B?OEN0VldUMkZtVTNqUUJveStjUzZjcTErWkpHUStsQXQ2SzZISnhkV0liTlBS?=
 =?utf-8?B?R2dXeUQ2SDBMN0toVzVlNXBxREV2QTZtM3oyL2JWL3d4WGJzYUdhS3grZVlB?=
 =?utf-8?B?VWtrNG9hanBaTVEwWmZ1REl0dXZ1dHd0bE93bUZGU0MwT2E3N2thV0l5MUFB?=
 =?utf-8?B?MU5XV05IRXBLTkFWalR5Mjc4TTdkbVhBeWJhazlIQmRsNjRMR2hFSjZsOXFm?=
 =?utf-8?B?eDZwUSttYmZLV2t5Ty9FaGd2MTdrZUg2VzNXbWMwdUhSam1SOXpMNmppWWN6?=
 =?utf-8?B?RXdDZmtURmJJWUJTOElqQ21FNnRKNzE2WURzMkxPS2dPTHFUd0k5T2ZUZEpU?=
 =?utf-8?B?Q2ZxZlNQMFpJdG9mQlpabEQ3S3ZlQkt4Rmo3U0ZrY0FOTzM5Z1c1NEt5Tk9V?=
 =?utf-8?B?VXcrMmJpd0FYWWI5eVBFbTZUMlhacU5BcjMxSHRZaDNCRXpUOHB6emFLNzR4?=
 =?utf-8?B?eGFIQUJvQ0Y0UzkzSWxCQ0dhbk4rUHlyd21sV2hoMGk5dFpRTlFmUDZEclU0?=
 =?utf-8?B?TnRIMXh2N2l6dVBNVmxwdUthZ3V2QzE1MGlIUFVCMmVha0wzL3BLak15ditL?=
 =?utf-8?B?OEJSSG00OHNEK1BycjlKT0svczFUSE5kSkphbWQ3WkI2eDNxSTAvYy9nbWd4?=
 =?utf-8?B?a2VPTndZSzg1NU9Zc20zdmY1NWZ1ZGhmcVcyelVMZ2R1N3VvNkVFYmRqcGZF?=
 =?utf-8?B?WHhZK1Vnd3VNT2tXNmcxcVFJUHJ4MHUwbFdLNlRSOVFxQ0pKTElIVThXT3hP?=
 =?utf-8?B?c2l5UURXVGxZT3BQVWU2eUQyMjVvZDdJMWpUZzdha3Ryc3ErMWpvZ3Q0Y0gw?=
 =?utf-8?B?bzBid0VtcFVYS1ZDOGUzYy81QTNQMUVsdmxSdlRtcUlSRElRY0dJYStJbWs2?=
 =?utf-8?B?OE1UTDFMbS9hOEJJbnJwWjNGeERvdHRvdTNyYUxORElGVTF1dVhlSXp6Tlhq?=
 =?utf-8?B?blkyZTdhYTJMKzdZUWhjVVJ4bE1WVmw2NWg2MFhSQ1lVZU9YbHUzMVFzVGFC?=
 =?utf-8?B?aXFtSHNCelhZTUZTaVVEeWJzbmJXblUvUFZKcmlpRlFQQ2RCUmZwT3dhcEhl?=
 =?utf-8?B?RjdhUGhjRGJHeGo5K2F0VHl5NTBpRDNTR1JvY1p1RmYwVE11RnVhWkVwRnFP?=
 =?utf-8?B?c0lwY29PeUVXZ1FnYzEyRmxpSlF4aFcrazYyRmFFM1dyZzBuU29rUVVHcndC?=
 =?utf-8?B?R0lSdDMxOFZjbVYzRStWc0dOYW1sS1BCcWE1aWozSGQrd2FKY3BsMG1qZXZl?=
 =?utf-8?B?UUlqTHVKZXhlRHlRQ1FpajBFV0pLYWFJVStLTnFBWFM5UW5RSVl0QnhEZkQr?=
 =?utf-8?B?dk1uZVc5VkJ0cGlsR2hJN2VQNVdOMEdCMWpWWDRJSFNMNW1TZHlCYS94K0Iy?=
 =?utf-8?B?R3FTZDEzUDE4dC9CTUNkdXlUMnRSVzRaTVZwbTFJRThhc2dURTZwUUgvV3FO?=
 =?utf-8?B?UW1VRFcrdzd0c0tOVEduN3JmZ2x6cWVab2lyMlhZSUV6ZkpJN2VYZXRRYlQy?=
 =?utf-8?B?SzJMRE5WQWVydlNPQWpSdVp5SXVTbEVuYzFiU3c2OWt2SFRBekxDM0E1ZWhJ?=
 =?utf-8?B?eUFJeGJrZ1M5WkJNVEtYOVBQUjl1Y3JXQThXN1hBNHZBYzBHSHFiVGwzUDMv?=
 =?utf-8?B?VTZHUWlFQkZSeHg4d3lEeHlkTjZBRGF2MktzRjJEbk5YU0EzRHY4clE1eitm?=
 =?utf-8?Q?dMGpDDUnhxsYicbdy/ih2EWOn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2384f2-b5cb-4258-b429-08dcc6a7a2db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:50:47.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wErA0AuyFerIOpT9U/zk/U1j3HENRtZaGPPVfhvcrFpgrjQzB0TtJbUfvzfNx2GD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
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


On 8/26/2024 6:07 PM, Mathieu Othacehe wrote:
> Add a new ahab_derive command that derives the hardware unique key (HUK)
> into a 16 or 32 bytes key and stores it at the given address.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> Changelog:
> v2:
> Make the seed size configurable
> v3:
> Fix a typo char* seed -> char seed[]
> Rebase on top of u-boot next
>
>   arch/arm/include/asm/mach-imx/ele_api.h |  2 +
>   arch/arm/mach-imx/ele_ahab.c            | 31 ++++++++++
>   drivers/misc/imx_ele/ele_api.c          | 77 +++++++++++++++++++++++++
>   3 files changed, 110 insertions(+)

Reviewed-by: Ye Li <ye.li@nxp.com>


> diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
> index a29b849d903..d4ac567e7ed 100644
> --- a/arch/arm/include/asm/mach-imx/ele_api.h
> +++ b/arch/arm/include/asm/mach-imx/ele_api.h
> @@ -26,6 +26,7 @@
>   #define ELE_GET_EVENTS_REQ (0xA2)
>   #define ELE_COMMIT_REQ (0xA8)
>   #define ELE_START_RNG (0xA3)
> +#define ELE_CMD_DERIVE_KEY (0xA9)
>   #define ELE_GENERATE_DEK_BLOB (0xAF)
>   #define ELE_ENABLE_PATCH_REQ (0xC3)
>   #define ELE_RELEASE_RDC_REQ (0xC4)
> @@ -143,6 +144,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
>   int ele_release_caam(u32 core_did, u32 *response);
>   int ele_get_fw_version(u32 *fw_version, u32 *sha1, u32 *response);
>   int ele_get_events(u32 *events, u32 *events_cnt, u32 *response);
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *ctx, size_t seed_size);
>   int ele_commit(u16 fuse_id, u32 *response, u32 *info_type);
>   int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_output_size);
>   int ele_dump_buffer(u32 *buffer, u32 buffer_length);
> diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
> index c13d9f0e00e..647daeb6562 100644
> --- a/arch/arm/mach-imx/ele_ahab.c
> +++ b/arch/arm/mach-imx/ele_ahab.c
> @@ -624,6 +624,31 @@ static int do_ahab_return_lifecycle(struct cmd_tbl *cmdtp, int flag, int argc, c
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_ahab_derive(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	ulong key;
> +	size_t key_size;
> +	char seed[] = "_ELE_AHAB_SEED_";
> +
> +	if (argc != 3)
> +		return CMD_RET_USAGE;
> +
> +	key = hextoul(argv[1], NULL);
> +	key_size = simple_strtoul(argv[2], NULL, 10);
> +	if (key_size != 16 && key_size != 32) {
> +		printf("key size can only be 16 or 32\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (ele_derive_huk((u8 *)key, key_size, seed, sizeof(seed))) {
> +		printf("Error in AHAB derive\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>   static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
>   			  char *const argv[])
>   {
> @@ -680,6 +705,12 @@ U_BOOT_CMD(ahab_return_lifecycle, CONFIG_SYS_MAXARGS, 1, do_ahab_return_lifecycl
>   	   "addr - Return lifecycle message block signed by OEM SRK\n"
>   );
>   
> +U_BOOT_CMD(ahab_derive, CONFIG_SYS_MAXARGS, 3, do_ahab_derive,
> +	   "Derive the hardware unique key",
> +	   "addr [16|32]\n"
> +	   "Store at addr the derivation of the HUK on 16 or 32 bytes.\n"
> +);
> +
>   U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
>   	   "commit into the fuses any new SRK revocation and FW version information\n"
>   	   "that have been found into the NXP (ELE FW) and OEM containers",
> diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
> index 3745504637b..b753419f01b 100644
> --- a/drivers/misc/imx_ele/ele_api.c
> +++ b/drivers/misc/imx_ele/ele_api.c
> @@ -1,11 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright 2020, 2023 NXP
> + * Copyright 2024 Mathieu Othacehe <othacehe@gnu.org>
>    *
>    */
>   
>   #include <hang.h>
>   #include <malloc.h>
> +#include <memalign.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <asm/mach-imx/ele_api.h>
> @@ -527,6 +529,81 @@ int ele_start_rng(void)
>   	return ret;
>   }
>   
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *seed, size_t seed_size)
> +{
> +	struct udevice *dev = gd->arch.ele_dev;
> +	struct ele_msg msg;
> +	int msg_size = sizeof(struct ele_msg);
> +	u8 *seed_aligned, *key_aligned;
> +	int ret, size;
> +
> +	if (!dev) {
> +		printf("ele dev is not initialized\n");
> +		return -ENODEV;
> +	}
> +
> +	if (key_size != 16 && key_size != 32) {
> +		printf("key size can only be 16 or 32\n");
> +		return -EINVAL;
> +	}
> +
> +	if (seed_size >= (1U << 16) - 1) {
> +		printf("seed size is too large\n");
> +		return -EINVAL;
> +	}
> +
> +	seed_aligned = memalign(ARCH_DMA_MINALIGN, seed_size);
> +	if (!seed_aligned) {
> +		printf("failed to alloc memory\n");
> +		return -EINVAL;
> +	}
> +	memcpy(seed_aligned, seed, seed_size);
> +
> +	key_aligned = memalign(ARCH_DMA_MINALIGN, key_size);
> +	if (!key_aligned) {
> +		printf("failed to alloc memory\n");
> +		ret = -EINVAL;
> +		goto ret_seed;
> +	}
> +
> +	size = ALIGN(seed_size, ARCH_DMA_MINALIGN);
> +	flush_dcache_range((ulong)seed_aligned,
> +			   (ulong)seed_aligned + size);
> +
> +	size = ALIGN(key_size, ARCH_DMA_MINALIGN);
> +	invalidate_dcache_range((ulong)key_aligned,
> +				(ulong)key_aligned + size);
> +
> +	msg.version = ELE_VERSION;
> +	msg.tag = ELE_CMD_TAG;
> +	msg.size = 7;
> +	msg.command = ELE_CMD_DERIVE_KEY;
> +	msg.data[0] = upper_32_bits((ulong)key_aligned);
> +	msg.data[1] = lower_32_bits((ulong)key_aligned);
> +	msg.data[2] = upper_32_bits((ulong)seed_aligned);
> +	msg.data[3] = lower_32_bits((ulong)seed_aligned);
> +	msg.data[4] = seed_size << 16 | key_size;
> +	msg.data[5] = compute_crc(&msg);
> +
> +	ret = misc_call(dev, false, &msg, msg_size, &msg, msg_size);
> +	if (ret) {
> +		printf("Error: %s: ret %d, response 0x%x\n",
> +		       __func__, ret, msg.data[0]);
> +		goto ret_key;
> +	}
> +
> +	invalidate_dcache_range((ulong)key_aligned,
> +				(ulong)key_aligned + size);
> +	memcpy(key, key_aligned, key_size);
> +
> +ret_key:
> +	free(key_aligned);
> +ret_seed:
> +	free(seed_aligned);
> +
> +	return ret;
> +}
> +
>   int ele_commit(u16 fuse_id, u32 *response, u32 *info_type)
>   {
>   	struct udevice *dev = gd->arch.ele_dev;
