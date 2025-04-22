Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE69C369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2564E809D4;
	Tue, 22 Apr 2025 10:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Uh714VX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E05080F6B; Tue, 22 Apr 2025 10:54:00 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3BB8056A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCspAEhZlc9pI2NiOqx3kSLgShIXx8hckon67IynIg6CjrmfYX968GRiuN+zFsg7oxZOL8bFPWJ/SCoLtM3nLbRHRX7f/IxTO1r8KWhadNHVmxMTLF9oCJ5noYyhAMTYNZc4Y5x3I5PJETzJfmYmaj/FxT7B/SBWOxyz/21h6kECOjEquxbxA31O2UUwxVHEyxJDED8DEpNmzaTN7UDQ2HD5I316xyiK80+Zm9Lu/mD91ZLiiVhew0E1HCitm3iJLn+MrTaMRSENpN8PWQ5veRkyw+uR4GEVwXpLZBJ15Zvv/qFNzbe32+1eksXX8rtAVShfBKFoU7/4v1o5qffslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSX1IDu4XP3saN/+myL8K8TXDkS58q9FMPYP9/j8C6Q=;
 b=hLhBwkOnY6mPMq+LjeiZfuigNhEe6W2ISZ5ZRw6IsKPpnm3Ts9qvwNQea0y4Rbr/cfhivVzqmGxCTbwupPHNVvlpND/oie3f59WGKKq+rmwgOsjFvqdwIVc9KwAByRcuIX1j3EhRuDiePNzAcbpAOXftiaUb1na8uMSeEEFnkxl7493OQjsC8y6RnO6D1L8eweKTuycvtHFSEgNfxIKP0i/Hh6LIumeJiDvh3lb1+AqdGY8FRVlJmuzxftn/HLjWBOQHr+/HeIsqO/srEbryeoIJWsVeAeFdZrpRT5IwirbPK/cwTWEa3qXPVLlCKlp8RNiaeR/ZqDopeHUzNNPiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSX1IDu4XP3saN/+myL8K8TXDkS58q9FMPYP9/j8C6Q=;
 b=Uh714VX9cbDmLjJ78G+VkhTvXQaOJkslPXlFnz3s1pc0ItaIrgwCX9z542qYd4ZrCFa1G9+neWX1Ae9QzcJ2ns0xlgot/EFZmucntDrr6My0zgWG95thY3djY1Yq5F0JwmH99c+aHQPnzlRhsOCW0I7fdROqCzP5ct4s/rVRkVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 08:53:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:53:55 +0000
Message-ID: <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
Date: Tue, 22 Apr 2025 10:53:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4eb8ed-dca0-4ad1-814b-08dd817b3467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZNS3JNdDJab0pVZG9FV3BlWUttMzdPTFJBMEFYSDlXS1hRTWxuRmZ6ZnRj?=
 =?utf-8?B?WWIyUDZFOGF6NVYyQlVUczErWkNsbTNhUTJtdTRtMEVhbFdqOTREVklhL1Vh?=
 =?utf-8?B?dTNiYlBhU2dLUU5vWnRySm8vekdWcmk0SHFFeWtIOFFTVkhYSllUZ3BsWUVq?=
 =?utf-8?B?RXZNRVl4dlRRazB1Mit5MG83YzkxQ21BbFVqU2tCLzdKWmRhK0RvQW1pN3Na?=
 =?utf-8?B?YVlRNjRhamwyQmVPNjE1RFg5aFA5TEdxcmlyZFpZY2s1dk11UU1qbmhhd3dq?=
 =?utf-8?B?MExkZTQ5TTlXT2tzSjhVblZmLzFORkJuY1ZtWjhqU01Vak9xM242VW9NWm53?=
 =?utf-8?B?bUt0Yjc4czlYWjcyRDZIY0YxMnJGbDNLRkVhRTlzS29jNDFNdFlhTUZFdEU3?=
 =?utf-8?B?ZlAvVFJKV1RIU2JuV2hZdFFCY0VZdUxEa25hZGRrWXdTQ0pSUGFOU1doWWd0?=
 =?utf-8?B?VHgyUUk1YXBuWHhvR2kzdjd5bzBxdnRGK1A2U2g1WE92R1NPdWNvTkNnRWRs?=
 =?utf-8?B?STRpK3hGdmN4THZIN0ZNUnl4c1hBSHBRSjVBMk1ickM4RWYwNDVCM042RHRJ?=
 =?utf-8?B?enFtS1p2TmRZaXRrNTB5ZHdjWEV1NWEyNXpzaHBZWnFxZmtjdkQvNUJrZDlQ?=
 =?utf-8?B?QXIyZFNHSkxtQnFHaHBnWWFMbVdLQk94a0dQTitGUzJvZUhLN2pOOGFVanVU?=
 =?utf-8?B?NVExenZ0VDYreFF2U1F3RW43WXpQbWdGcENaTVZmYkM0ZkM0dFhFRFF5SlFX?=
 =?utf-8?B?YnBKcmxZT2xSMW1wOS9ib3hjazAvR3p4Q1JVblZBRWUzdE80WENxNHFtZzQ5?=
 =?utf-8?B?RGdyT0dqc3lIdlM1QXlQVzZzWDRkZmJ5TDZFN1kya0E0WVVOSGdHSThLTCtj?=
 =?utf-8?B?cjA4R3FyZlZGYnJxcXB1dXFsOTYyWWxVUzNnS3BOclorK1UyWTg5M3JOWnhp?=
 =?utf-8?B?VmVUc3h0SGtvWE5ldHRHT0dVSUIwN1Q0RG0ydDl4c2kzbTdBcGtVL3AvM2l0?=
 =?utf-8?B?UzUwQ014OGtCWm8wZmhVZVZ4MDVRS3ZqbGJUdnRGdHI4dmpTSTAxd2RTZTVH?=
 =?utf-8?B?ZS9USkQ0YnBERVA0cmNBWWZtNkk0VmZnOGFNTFBUYS95TE1LNFR0TnRwZkNU?=
 =?utf-8?B?VXlJYXpRcCtrWnRoSGcwRjQvOXBUWDd5OWRmYUsxb1ZqdEZBbjBNd2VmNU1X?=
 =?utf-8?B?T1dhaHQ1dWxvNEZFdDhDWE5RWUp5N3FVTytEd0pyTDA1c0FhU0RkUUQwcnE1?=
 =?utf-8?B?QWJQOTBDWXBRZkNYU1ZsNFVncjREaE5IRG9XY1pGOEx1aWpWaHFybDFqUGta?=
 =?utf-8?B?bjZKTDJ1ZmdVRGNrdzYwaU1MSE96NVpHWDdQRG9ORXBXV29VMXovSDNCZVh5?=
 =?utf-8?B?U0FaV29veTgvbXJkVXRRK1c5YktMcGxtVysrcGlwWDRVT2tlREc1RWtuK0VS?=
 =?utf-8?B?Y0oxV1d5MmRoMkRTSXhpYU02azJHOVBKSTZJTXhDenRIVkhySHYzeWVMNEw3?=
 =?utf-8?B?V0RpU3F1U3F4YTk3SUtmdmNvMXRKaDJ1R25WcWJIT2dwKzBkeU4zM3hINGpV?=
 =?utf-8?B?TndhSkVWQ2trdTI3S0lEVlBnUldrYVJyMzlqU1FNRHJGYWs4YVdmeC9MOFpG?=
 =?utf-8?B?bmNmVCtQa3dpTzhSQTFvQXI5c2NDMVZlT0pJaS9keVFFbDB4bzN5c2E3ZkFx?=
 =?utf-8?B?T05ZU2JwRzZsRnFGdXJGT2JvVjRFNTNLanVKdEFTZU1SNXE5QzhaaDdXRnRT?=
 =?utf-8?B?ZTdFZzBvRzljUUk3U2tmRVM4clVwbzdzaFdGRlEvUFphU3pER0s2c1dWaGxN?=
 =?utf-8?B?NERHb0tXYS9lZzZkcGJISnpyTTZKR3FTcGY4dkZBNmJnYmZTRTI0TStlMSsw?=
 =?utf-8?B?VmV3cHlNM2xVMEd3WStwOXFSWlFiNzBqY3NuMVJWVWpoaTByZ2ZsOU52TzJm?=
 =?utf-8?Q?g7i+HTQcvs0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzE3ZjlmeXlxME1sUHNJUnNXTlZLaFRpdVIxL1hSOSt0ZGJ0SzVpL29ZcFFh?=
 =?utf-8?B?T1J6bEUwUDFuOGNncWJZK1dnTjNaTFUvS09sc0g5NE4zQ1p0d3A0VEdGVEh1?=
 =?utf-8?B?eE9LTkJkNC9TcW9Sem1hd2oxcWhIY01OdnlvOU1WTUV2K1dab2RMeVppRDgy?=
 =?utf-8?B?MHB2eDhVWlFBaytBS0JsOFZkUzVtWkNQMXdmZUwybG84dHRnUTdlT0h4MVVm?=
 =?utf-8?B?UXAzVXFmMi9iaUErUWU1eTZMaWNySUQ0WnVpNTd5KzZGZno2dGZmdlZiQWhV?=
 =?utf-8?B?Ni8veks5SmgycFdpbzl2K3hRc3g3anRBRVg3dkdMUU4xOXRpTGFieTE4eWtP?=
 =?utf-8?B?dGJJblB5a3VHRUE1WXMxWGVDV2pwbTZPeEFDbXlRNGlSUExucFY2YXM5SnNo?=
 =?utf-8?B?ZEVzbmdSRU9FS2JSeFU4MjR3dEZQakVPdEJYcEM1M0V4RDJTekk2R3RaNlRw?=
 =?utf-8?B?SG91MWNkZzBHNTNwR042dUtKbWUwVnhEdE1abHVJb0psYTBWYTNYNmw2M21z?=
 =?utf-8?B?ZklxUkJ4UXdzK3hiY2ZqdTFJeC9yR1FRenlWUDFYVjdUYVFCRTlMZVdMZk1M?=
 =?utf-8?B?VjY0S25aelFpYnU0U243QlJSRlIrS09SNzkwNXRFY0daTG9jQkpNZWs0dWJS?=
 =?utf-8?B?akpRVWFObTFWMjh2czVUQVpDdk5QVW9ZRGpPOUpxR2JRYmxDa2djcExrbm9z?=
 =?utf-8?B?ZlhiL2YxMEN1eUx2UXRiOWxxWEF1R3ZOL0N6UGc1MTZsTlRTdTIyemVZWkh6?=
 =?utf-8?B?eHZuRUhrZ1dNV25HK2JQWTlRQTVDMktXcWZvemRtSUZPUW0xS2V2SjlNMmpN?=
 =?utf-8?B?MjFnVzRjR25zaTR0eFVQSDZCQlhCbElGbTVLdlphV0dOS3BsOUtFM05CaExN?=
 =?utf-8?B?aE9KZGRVeGJVY0ZuaXV5b2JBdXFhSW5yYTJjNDRhWkJObmdEeUlyd0ZwUytn?=
 =?utf-8?B?REh3bXJoTFY4bzF6SyswOVdJRHBGRFYxQlR4bmV0S0xKNFpHZzdXZWJqVEd1?=
 =?utf-8?B?bXZpQzNRZzZXcHNBUlFDK0RheFIwOWhBNERBUmxwcTRjNzhrRUxBUFhkeUFZ?=
 =?utf-8?B?bkVaNXlQdFoyV3JZZk5QbVJ6L0dHTjFkREI5Z3BRQTJoWUFYZ0FHaVJTWjNX?=
 =?utf-8?B?YjJZcjg3Wi9kWmI0aVhUbVFjYk9WcWFISGpsbjBXUi9VTExTbzZWakhvWVFY?=
 =?utf-8?B?SEFjN1VvdkZXWGQ4SFErV01pSGJMaDNRZ01mQmJWWDRCMGRiKzJiSjB3MTlY?=
 =?utf-8?B?aTRQRVBwUHVrVzBRVjFBNVE2N1lNL3Y5ekhZa2kvVWlVKzJuNlU3OVhmYjUw?=
 =?utf-8?B?Y0RtbW41L242TC9sd3NHNmQ3YW9UZ2Myc0NhdmdUQk0wVUFCQmFjZ3dwZXVp?=
 =?utf-8?B?Sk5ETDVxa2xMekFOZzY2Mm1SV1B3bU1oRC84YlRRNTYxdUtDanZsRCtTbnFW?=
 =?utf-8?B?a0hMZ0dNejhITmJhclRtUHFKaHRqdFQ2RFJTMmxVakxhT2JhYlF6b2VOWW1t?=
 =?utf-8?B?OWpUc1RaenFmT2NjaC9oWUNFMmF3Q2NyVTlKQjJwMHYxZTZEZ2J0TzlBSEt4?=
 =?utf-8?B?bTh2c3dvaDNvMXdqa3VCem5ESTZvVUNXaG5VOEFVcnFLcVFhZ1RhZXBTUW5o?=
 =?utf-8?B?QnVBWkhlUExHeFk0b2hXc3E3NytQY3lyQXhqUm1leGJnbUNGc1psVHlJN1kx?=
 =?utf-8?B?MzlxYXZJdC9zMHdDaXYrMFFCZXVxTjU1eGNaTmlTbm9UK0pVUDFUS25vU3R1?=
 =?utf-8?B?VFo0eXhPMmFlMG1TV0RwcmRidUpaRzVuYU1RSW9NK0ZxT1RYclhGZGdlcC90?=
 =?utf-8?B?cSs5K1g5WWtDOG5SYm52aEQ1U0UxRktpM0VkK1pMZTYwUEE3dEpBajVIN1Bi?=
 =?utf-8?B?TzRsQTl1M1lEY2Z6eHZ6OFc3Y1YrcFRxbDM1VTNLTWJNc3BwWUJyOFFxSHFC?=
 =?utf-8?B?OUJmZWVVL0tmeitNZk9rNy9Nb2JscmxTY0RveW9XakVQQ2lzR1ZPbjZreWVZ?=
 =?utf-8?B?RTdIK0daOUt4YkowL1lVN3lDVkx2cHVSTlk0ZkFyeGM2NWxjcnJqN2ZON3ZH?=
 =?utf-8?B?WHBkR3dwaENwS0pYdlhYY29IbDk5bUJXSll0dVZEM0MzSUg4MkJVaGJGdlVu?=
 =?utf-8?B?TnA1a3BqQmZqT2tvUWp5dGpENC9DeDgzSmNGMC9xNkw0WkNEcHprZU1mM2sz?=
 =?utf-8?B?a1ZpUlY2eGlUdUNaeE1QNTRDR0x6cVlObzFNLzY5eUtRaUlXS1NtaVNTS2lB?=
 =?utf-8?B?TkZtWGJZdU9UTzJGWGkzZzI5VENnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4eb8ed-dca0-4ad1-814b-08dd817b3467
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:53:55.6220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE7eWKn0kgIyIjQ9SbF91r0KRIuOXtzimZuSQUcoWcK3xKQp8iHOJcdwhglHkwoQMiVgcpUAPFmqv+seKp+V6MB3kPYp+4tFhgW+N1NkgsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314
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

Hi Simon,

On 4/18/25 7:19 PM, Simon Glass wrote:
> On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may contain
>> a path instead of a filename due to user mistake.
>>
>> Because we currently assume it is a filename instead of a path, binman
>> will find the full path to the key based on that path, and return the
>> dirname of the full path but keeps the path in key-name-hint instead of
>> stripping the directories from it.
>>
>> This means mkimage will fail with the following error message if we have
>> key-name-hint set to keys/dev:
>>
>> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file or directory
>>
>> Let's make it a bit more obvious what the error is by erroring out in
>> binman if a path is provided in key-name-hint (it is named key-name-hint
>> and not key-path-hint after all).
>>
>> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
>>   tools/binman/ftest.py                                    |  7 +++++++
>>   .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 ++++++++++++++++
>>   3 files changed, 25 insertions(+)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> The change log seems to be missing?

The change log?

Between v1 and v2? It's in the cover letter of the series, this is how 
b4 handles it, not per-patch change log.

Or are you talking about another change log I am currently unaware of?

Cheers,
Quentin
