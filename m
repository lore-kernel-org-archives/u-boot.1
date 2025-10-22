Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC9CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 14:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E3A8323A;
	Wed, 22 Oct 2025 16:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YpO0PrHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF30835B0; Wed, 22 Oct 2025 16:09:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242E782B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nux9i2Ai+fRoABPS5Rbcf7gjhfkHKIhIpeaNcek5Jdn3kfyN+h/E0mOVxnnB8WKE/YXwwDfyF/Z7cBi7OW76Zn2xqI/7AArTmvMvyuX4iuHWscdvwoVb9P5VNB7k8BF29381/6Lngobu92pqWIIGC2frRVkQbf8xjbXJ4GnOVn1tvx9UQZgWQPY4I8ZyK/RNam5qENmm5bySNyoES658mvVkC58pM7b++r2P4jQhmvI0Vp0/468I1Vlc85h+ou2nHkqFgY+6bezGo2RWbE9jF/cskJlzPtf9dJogzTlYRKf5dWvDKyBE7yYslCtsbEPU5G4Z+M4a5Zkahu3sF59iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBItrPh+lQFyn3MQhQhN6zrckONezB8q+BrAtk5l3D0=;
 b=Po1gjkZtcZ3yHNbYxCukmaHNWxaKFmxFVUAP4rcUKx9IuMN37DdEFwysNpF+gzOlruQP4jrEQLtNIViAUDBl8hpuUkoNApV6/DaJUg4/s72ZD3OOkC8vY0cCSBAdVNOYF95b+B4D1cxSksHszFL2Qv3U2yNT405NgkJJ+n1Xo3QJgR6lHdF4qdntgfLU+Fl2zC50rSzn0jw7TUg094KjumMJQt7OZRE6xUTslvOi5ZIn/sCzFFz/KvXZ7co2HAVWTDe6ql+4denNKEdpAq3HDZkYziFlSm24/MZgqHA4sONJxGexr1LbhN6NH2ybWZfvMl4Uyiyt1ZDAdVzOIocNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBItrPh+lQFyn3MQhQhN6zrckONezB8q+BrAtk5l3D0=;
 b=YpO0PrHKIkajj0BIa752IR1k/WT+Sp3GANM624XGLfSxJl2xtApasLFctllcKhIWfQgBP/0X54UrpTRg7XSuC2PFAgGflDziuLUtP+gJnc+AyDJdOUyWM9F9S3SykT2K8HZshVWC8AZgpfySiC5v+/5U9ZSGvPsBTO+Q/GhyBi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10752.eurprd04.prod.outlook.com (2603:10a6:150:203::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 14:09:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:09:25 +0000
Message-ID: <49c41f81-097c-4e0c-a942-e7f161ef2576@cherry.de>
Date: Wed, 22 Oct 2025 16:09:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: seama: Reword return value section
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-4-trini@konsulko.com>
 <40cc7900-f225-4d4c-b3e4-286b1ac4b954@cherry.de>
 <20251022135144.GI6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251022135144.GI6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10752:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a60cf2-2cd6-4fb5-6bf3-08de11749b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWc0a3B2MThwMy96Y3Y5VEc2ZFRCMUR1RVdCVndUbTNUK0JEbVB0MFV2Tjda?=
 =?utf-8?B?cjd5WTNMMGxkZjBNa2VGOS9yK1BDZEg4ejB5RS84eFdjWEhlRDVmUGVmSGdX?=
 =?utf-8?B?WTF6d25NL2RGUW5YOG94dFBGUUNUMEhNekROek9KQmZDR3JRNy9kTHpxZEdl?=
 =?utf-8?B?eHVWZnVUUFp0YnBDTUs2OEYxMkwzeVhmYmExYjF5Y0dRUUdPWkJZa2pVQi93?=
 =?utf-8?B?TFplYng2bEdubmFGS0ZpQk56TGFnZnFKdEhxeDZsTXoxQTJMNU5OMkFBTkFG?=
 =?utf-8?B?SkFOWWhiMStRbEszV1NITm0zQ1FLL0Fib0V5UlFSZHU0SlFMTlhNSkNQbjZY?=
 =?utf-8?B?VUxuT3FnL2FsQUJzMGxUcnIvUTlHeW00c25KRUU1aXNXQm9kREN5ZER1OWc5?=
 =?utf-8?B?YVpNUk5LU2ZOTjhIZkhFTnFqRnBSK3pIdE91WnRLalVFb1BPQnd6L0hMWmpR?=
 =?utf-8?B?R21sOERwcE9mUDFJb0lPRVF6N29iL0oyK0k5bTE4YUxCaGJGaFZQOTg3OG11?=
 =?utf-8?B?aEFvWkRSMWQvQ045VThkZlNlUHBqQVNSOTZVdXRjU3N2d2s3QkxWNXRWTjBa?=
 =?utf-8?B?YUl2dVNvenYvdzdKcVpFWjNjR25vV01CM2tLZDFDcjEwVTBSbjlnTGtQVTV6?=
 =?utf-8?B?UjJzQlBmQjdoL3Z1YmEvMTBnY2IxeVpHWVkrWStLVFBUKzBkRnBBcGQvRHBy?=
 =?utf-8?B?V0RSUUV5bWZKdThlMVJWQWNXamZLeVdseXNMWGp1M3pZTXJVZUJTMWE3cFBt?=
 =?utf-8?B?NDFITWEydVNpMkNRN2h0aVlBRUJjTXNlUEVUMkE4am8xekxwT0RKSGlzaUtj?=
 =?utf-8?B?NU16MTBOaEJWMGFac2NWNTdkeGNyWGR2cWc4Yy9rbWcrQlRFUFNSVG9Hemk4?=
 =?utf-8?B?UGE0NWN5c0llOU9zUSsxeGxKQm4xNng5Z0ZkNDFoREJwK0loVDhycTF2cHU5?=
 =?utf-8?B?T1dCSzJOaDBHOFpZMTd4Q0FVbi85MmVTTlJHMFYzZnVzVC96ZzByZTkvRzly?=
 =?utf-8?B?dTZFRXFGOUJmZDgvWnROZitNTnQvemF0WDgzNUx4Qyt5YVczK1ZDNHRHa01j?=
 =?utf-8?B?aDd0MFgxK2NldmVDU2RzcXArbkY3Z0JXdVh1Ni9aanp5c1RFamZHQzNUY3RN?=
 =?utf-8?B?L2g5bXFCVmliYndHT0NkZ3kwcFRHRExXS1M0OG92T3RiOUlUUllCNi92Vjc1?=
 =?utf-8?B?NDZhc2NQYUZBejEvN2k0eVhLek1uSHVYOTBMNENLQkE5T2NvVGFXZjZyWnZL?=
 =?utf-8?B?VnNoa0VKSWFJVllpLzJURjhJd0xGOVRFR2R6cStNQjVaUjgza0p2akIxMzRz?=
 =?utf-8?B?dlMyZWRNVWc5Vmd5ekdzTEJISk1LT0tPY2xNdnl4aSs1a2MrNnVvek9oOEsz?=
 =?utf-8?B?c0gxYWJmNWxleHZ3TXNQdllYM21JZGJOTUQrNVEwRHBpb21OQXdVRWdYelB0?=
 =?utf-8?B?M3YwV2RqZ0RDMFBrWTR0Y1FqdmVlMzZiREtTRUViSmI0S1lTejI2aXpHbm41?=
 =?utf-8?B?ZnYzaWRtMUMxZHFqNXVXUmpPY0F6aFFBZmhBbU1FeURhcmxsUHY4WnFZQWQw?=
 =?utf-8?B?Tnd4RWlTa2lPdUhzN211bldlVWo1dGtROVZwMUF3UUVGRHE1c1hzc3pvdGto?=
 =?utf-8?B?N2kxVzUvUVpjMmpOVnZzYzlVUXJyNFhqZlRWeUxvMVF2U3cwdXVHZVJxWGl5?=
 =?utf-8?B?NTRRaTFVVi80aDk2UUw3alpWMjZlKzhRQ0JNTFZxLzB5alFxTk5ienJNNHpm?=
 =?utf-8?B?Z0N0cmpuOVhpM2FXdUJtY3R6eGw4dVBWS2JOaEdVS1NiRzZuSDVoc2ZsbG1v?=
 =?utf-8?B?aGZuOVRIZlJYaTVXa0NKUUFjakxjWFJTMVI3VU51cEQvWkJidFY4QXd6VGRW?=
 =?utf-8?B?bC9jRmxYbElOWmpTRHFsZG1SMVp5b2pSL1BpeHNPSUxZVjN6SVFKWDZtQ0Fz?=
 =?utf-8?Q?QX9ZYI9qqrm37qXU2AG99YMRs85R9/mm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qko0SXJwak1sdGtOdWNKTHlIZUNDNnBNNW1aUU0vS05rS2pxaS93ZDlsTk5o?=
 =?utf-8?B?RVRDT2hVMDRyUVIyUWtLYUFvWklqdE4wU2xVUytzeGEwamgvc1cySmVTT0t3?=
 =?utf-8?B?enhiNjgrbjU1WUxWbjFvUXpreW43OGZ3RGpiUW1vdDZndWdlYTJ2L3RmdU92?=
 =?utf-8?B?dE1yM1lZZUFoeWJYbFZsU2s0TkU4VUhkTlI5Ni9DbEM3bXllYTFRbnhwa3I0?=
 =?utf-8?B?KzJWanNvZktpTTdBY3J4akdBQVYzUFQ2RHdGR08zTVcrQVRNYzdxNVV2SDNJ?=
 =?utf-8?B?RVAzWmxmd3FMb1JwTmJoNC93UTViU0hEYUV1SVIzVDE2Y2FYaUdUVnlLTUVo?=
 =?utf-8?B?V2JqNFEyTGJmZ0thYjJHOFlxa2kwaXdZaVlhL1RCTWQ3VkdnSC9NYnFzTFhp?=
 =?utf-8?B?c216LzBLWTNHd3hqZnE1MkJvNGZOaVdRQk83WGtKcEdEZDRQejFwQ3NOTFcv?=
 =?utf-8?B?WW1Qd3pYQTAzeHRvU0o0dHNyVWwvd0NkUm0vTnlLMndPajZ5UnFEVW5KWTM1?=
 =?utf-8?B?Lzd1bTZpR2pNN09PbEhMYWhHdFJadDIxdlVYL0JNaEtDN3J3Nlo0UHVzd0hv?=
 =?utf-8?B?cEhOeUorbDQ3a3RoSzhVTlYweHFNU05kaCtvNitwaDJVRk44QjR0QWIyMFR6?=
 =?utf-8?B?YVcxTzZVYVdsYkdNODg3Rm9uZ0xVamFSRVhqUzg3bG9BOUFDNWtSc0Fkbk13?=
 =?utf-8?B?QTVWYWVtR1UzdlNVVHhqUnRDeS9GOTlJZGxBbDUzR0o2RksvQUhzS0Zkckxw?=
 =?utf-8?B?ZmU1SGJRa05lc2RCTzhGRDRLRS9STkdnWTBsY2tObTVmYmQ0STZhT3BubmpI?=
 =?utf-8?B?OWVyeUtiN0tSeUtyaGpDSmZVM0hJVXd3SlZ0U3p3WmExWHFIUzNDMTREMGlP?=
 =?utf-8?B?cFBqSXZUYmJSalhPRmtqTW5rS0tvamJmSFA0NU14U1JpOVJyR0lwN1VVejQ1?=
 =?utf-8?B?b0loZkxuTTRBL0FMc05qTTZFK1VBQlFGaDRsVXB4OGhPeEY2aVl3NkdSNmdK?=
 =?utf-8?B?Qng4QmhsUEtxTUttT2JDQWF6UCs4OHVzRkFoVjl2RkczZ2xtdjNWYU9lNlNF?=
 =?utf-8?B?VnZrbFVmd3ZacEdzRWJrZFh0cWtUaElPbExVSGR4WldrdFVxN2pUWXU1TmNp?=
 =?utf-8?B?dStIa3NGWlRLQTl0blZXMytONlRxMTRDbndndjdyeVVQc1prWGVzZVpkbjJr?=
 =?utf-8?B?Z2lVblRhNXJIa3VJZ21lYVppN09iTUZBUXYrK3BHWkYwQjFMa1FRNThaV1dW?=
 =?utf-8?B?UlJaTlZwR2NEWEZnMFJjbGN2N0g5SzdIL3hCNWxNRmtZL3hHbkdZYUF2VkJF?=
 =?utf-8?B?V1JNNUdKV3EzRmVzaVdPSExYNHZRNXNIeklkYlFBZ3RKMFN4dnp0TlZkTzNM?=
 =?utf-8?B?QlZCb1NvcHVrUHBSTXIvVnJiemFXNE51R0dIeHFuRS9KVEFJeVZRWnB0NWpJ?=
 =?utf-8?B?eVduaWdDYkN4bG5QYWFOcFFnWjhJVTl2a2t2b1BzUTVGbDdvK3ZJV3Ztb1po?=
 =?utf-8?B?YVlyNjFBWG5tWDJKcXBIRzFtdFBHTjJqUjh5SEtBUThDRmNzNVNkYy83S1Br?=
 =?utf-8?B?WEZRMHFSMGNKUFFZK2NWNEh2QWwrWk1BelMxUTVUTVBabENzNnZaZnBjbzJ6?=
 =?utf-8?B?dkJQNDRsOFZOd2Jpck5UUGZ0QjZJSjFZNWxvZTkxRTVjM2tCL05vSlczTHFo?=
 =?utf-8?B?aXp4cnQzNGV5S3RGTDJ5dWp4bzlXOGpGTURyV1dRb1QvT1hlU0FURUN4TDdv?=
 =?utf-8?B?WUlQdFBFL2RJRllkejR2R3kzajl2b1Q4L3g2QVZlMnE4WmFKa2VGa3lOeXAv?=
 =?utf-8?B?OFR3MytMd3lnWElnVjJsRDZDaGQzMUpuN1lZczZ3Tk5renJzZVZZbmpDVklQ?=
 =?utf-8?B?TGloTmV3UytLZ1FIM0h3L0wraHg3dkxGUjhFNTdqM293ODF0UCtiMHh0WExo?=
 =?utf-8?B?Q1gyOEtsQmVFUndFRk4wbGpNWFhKTFkrenBGYy84d1haZ29WMm03SVhmb0d6?=
 =?utf-8?B?UmtyRHBFdloyeGZOVDQ0cEVnV0c0K0hJUmNPRlZBZnpHMi9CMGVndVNyMm1L?=
 =?utf-8?B?V0thSzBDVHE0c3d2eDg4UDMrOGFibXhFSURrRFc4UFVHMkt5MFpsbFVMcE1k?=
 =?utf-8?B?MUZTM1lQems5blBzajNhVlA1U0Uzc3E0MjVHSkxNSTUxNnFhTThrNVFsT0g3?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a60cf2-2cd6-4fb5-6bf3-08de11749b37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:09:25.3267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5sABRdQ9ZMlkq/x+eJlI4EPZs3XbpaYkIMNv2UIBh4QPKIA3n3jNeNvuUCnsz4kWgk9SgsPSjOm2tAZTPodindgqM4XG90CCJoszZB9PTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10752
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

On 10/22/25 3:51 PM, Tom Rini wrote:
> On Wed, Oct 22, 2025 at 11:33:30AM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 10/21/25 10:25 PM, Tom Rini wrote:
>>> With the addition of general text about how the return value is handled,
>>> reference that while retaining the additional information about setting
>>> $seama_image_size
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>    doc/usage/cmd/seama.rst | 7 ++-----
>>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
>>> index 17fd559f4856..a6b00f32902e 100644
>>> --- a/doc/usage/cmd/seama.rst
>>> +++ b/doc/usage/cmd/seama.rst
>>> @@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=y.
>>>    Return value
>>>    ------------
>>> -The return value $? is set 0 (true) if the loading is succefull, and
>>> -is set to 1 (false) in case of error.
>>> -
>>> -The environment variable $seama_image_size is set to the size of the
>>> -loaded SEAMA image.
>>> +Along with the general rules for setting $?, the environment variable
>>> +$seama_image_size is set to the size of the loaded SEAMA image.
>>
>> Maybe add "as reported by the SEAMA image header" as that seems to be what
>> is reported in this variable reading cmd/seama.c?
>>
>> Also wondering if this shouldn't be in a separate section like "Side
>> effects" since it isn't really the return value. I'm thinking
>> doc/usage/cmd/fatload.rst (and a few others) could benefit from something
>> like that to explain filesize env variable is set automatically.
> 
> Perhaps, but I would see all of that as future clean-ups, I'm just
> trying to get (most) everything consistent first.
> 
> I say most because on reflection, I think a number of commands that say
> they only return 0 are just not mentioning invalid syntax, but
> verifying that is a more involved process (I did check a few commands
> that say the only ever return 0 and saw the normal CMD_RET_USAGE checks,
> so removed their incorrect text).
> 

Fair, I sometimes forget in the review that not everything part of the 
feedback needs to be part of this patch or series.

Considering it does match the current wording and just aligns with the 
rest of the commands, this is fine.

The seama command seems to be handling the usage syntax error and 
"normal" errors as reported in patch 1, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
