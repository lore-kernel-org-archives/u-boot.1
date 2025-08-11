Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB6C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 09:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E53D832E6;
	Mon, 11 Aug 2025 11:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ajujflIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C978331B; Mon, 11 Aug 2025 11:24:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDFB832DD
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 11:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqTMnFvN0vwZOZs5uVVaHGNAag6We+tPE6pYSelBJt5F9ydGhJN89KWzVDi7jfXfL3ip8bVDpEzm+QQWigq/LABhSJzvwLKfqs3pI67IrDFt+Zn3d14uv3Oz9LPC1y5plEko9ezZe8jM90+AMReLjbd/l4GJ5yb7SfMtsLzgSK5be2s3ABFBIG2jEztZPQ0vxX94fS4onG60p/4xVGwmLR0Q9BWt38slHQAhwleK9OsVNCK6z57NyfTejQnxISvByOoZLnCsNAUpVC5uD+xLwUR8X9bna6ld4PI3E1ys7ssXtiTmDiFWEy13R8XU13DPdwLJQJS1gPxKDtuyUPZF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS1Ffemgfa24HEi5ATaPoZDMSOBoPdr1YBAEkmj7ZK8=;
 b=XM25wX/hWZh+u1MhZIripGCu/s1e5uuuhO4sREPRGkHWz+qOPwQmowxeZSSpsbcp4bPdCenoQ/nSsH82/4Dlhc6x6P+6NyglUg+h/5CzejOQuYRhBwfg2gKXCPvR814NVMQ7nBgHNcYpfEYPywJk9GvNka6n2/eCJjcnK1tGmoIzxOq9MMcofPEQXi60aUecDDIGUL67tyt5tCx96yd/TUnw6waO2a7M6Y/vF0RT0WFwSp2580jUga8KnRoaTTnjnkwXM2/aT0UmL/mTGVGjcqz/za7OXb52U98u93JxK8dL73MMoalvDZ9zk1g7rOa0TW2pJtKubHumrHWYyYJjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS1Ffemgfa24HEi5ATaPoZDMSOBoPdr1YBAEkmj7ZK8=;
 b=ajujflIHVpTFHe9RKUhYDHGlYKTwpqOZLsROboZdVT6WuS7v59nIm4rQMq4UfKakNnygWqxEBqDRA4eY9GyarvH2KYdkMJk0JkPRKU+H/v+xnBwKarTUNTOdP1bGTjTG76nwhNSyB1cp9vquuNkQhhQQgoqSFr08Ds87UaUOapw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 09:24:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:24:26 +0000
Message-ID: <d236a958-8605-4ad7-85f5-6cc03048f8b0@cherry.de>
Date: Mon, 11 Aug 2025 11:24:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: rock5b-rk3588: Add support for ROCK 5B+
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
 <20250801170933.2530191-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250801170933.2530191-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: ed296c0e-cca6-4cbd-9f51-08ddd8b8ddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2NBeEdIcTJPNnlsaU5rZWtPV1NOQzFwdm1yYXJ3WHlZYnpoZng2QW95aExR?=
 =?utf-8?B?OWl6Z1VKUzVvRXhacFF6VTNvWU1KeHRLY0pxdE0vL1RtMjNaY1pwdDlJQ0RX?=
 =?utf-8?B?ZUUrdnNpVE1pbHdCUVlOYW90emUrYlorSmpFZGVsODJuWlA1NlpJanQvS1hE?=
 =?utf-8?B?MmtNYWFsNm9sTWJJUzVXMWxqTVFUVGF5UXpFTGY0UUhvUXd5dXB2cGViWUtR?=
 =?utf-8?B?V3o0bkw4QlJlcUZ1eGNpSEM4SURuc2l3Zjd1L0M2ZlFPdzN6djdXYVNJTkdj?=
 =?utf-8?B?OTZxTFZVTXJSUmRBeEVnZ0hPT2NoZ2hGNHFSbjdvcG1sWWora2dEb056dS9D?=
 =?utf-8?B?TXlIdTRXQ0NtR2V0b3VjVENwampUSTk5ZEJqUlBrOWp4cmJIc3FwRlFBaHJz?=
 =?utf-8?B?dnZTbFQ0SmQrZWR2NTJDZ0ZhVjlqQlN3UGpjME5LRjBsbTZ3bWJwZ3kvTjY3?=
 =?utf-8?B?YktHK1RkaFlUbU5HbWVhekdmcVJzWU1uVDlJcFFiTDVSQ2k0RE1CSmlSYUha?=
 =?utf-8?B?QjlUTTVqYVM2QmNYZjhuWU9CbVpWSmxWTmJybFVCM0k5bURyc2p4Ymk4ZFdn?=
 =?utf-8?B?dmF4WnpnZGFnbmVucndWQWp0U0tSR2ZuYlV6U05NcERQL1FrdGY1SGVFbjY3?=
 =?utf-8?B?VklYbVhpUXFkSklobC9tWXVDQXRqMTV0bFVhOHU3dmV2djJqaDZudE16YTJH?=
 =?utf-8?B?TUppcVFFcVljUUNMMlZZVVFScW1lc2hvenNIN3ZETWdJVzFBSWZyM1ZndnlE?=
 =?utf-8?B?dWsvSHNhb241REExbFlFaHpYRmJyaUhacURqdm52bmlXdGc1aXI0dzcyVTl0?=
 =?utf-8?B?QlQzMDJEZCtUTTNYZnZGNFkvbm9icHFFb2VscTN5bTdtZ2pJelBrTkdJZEFX?=
 =?utf-8?B?bE9wUktCdS9rZ0RxejJSdjhGVGM4dnB4LzdZRmpxcnhsckwzRTFBMXMrbEZl?=
 =?utf-8?B?OExlYnEzb1Bkczd0VkhwWW5MRVVidFNkVjVmNlovd0pFbldaNG5ackJ1YStr?=
 =?utf-8?B?K09ZVFVldnZrNUhYaFJFQ1k4RmVvdHhJQ1lIVXhqNFhsV2VQVTM0QWhERWoz?=
 =?utf-8?B?SXFZSmtvd3VQMnphTTU2ZURqYi9YemNXVWFEZDNRS1ljOTBPbkRsNlpUNnh1?=
 =?utf-8?B?SDB0bHBuNi8ya3RRMjV4VHA2VTQ0VFo1VUduWUJUNTl6YjZLQnI4R21sVi9l?=
 =?utf-8?B?ZHdmVzdPMlNwWEt2VGRmTFEzK0FrSkZOK1pIN3NuS09YdXlHR0JLNldDdzFq?=
 =?utf-8?B?NW9XZ0QwWFM3WmNIVmNSRDdMVTZVb0FBOEVxdVJvSGdtcjdRVlpwU01ROFRG?=
 =?utf-8?B?dWlUUEk4NFNUVTVYQkk4SHd3YUtsa2lKWG9oZ1R4aXJzcTcwOEd6VlAydDQx?=
 =?utf-8?B?TFJCbzVCOFhzZjhQQ0h1TnVLaWdNSFIwSXB1Um8xbmVaZzF5UkpvOUJLNXlh?=
 =?utf-8?B?WHUrbWFjTVp0amNlU1Vxb0l1T2RCSGxvREF4ZVA5WjZsMUV3aDNkdjNVOFZw?=
 =?utf-8?B?UGhyUXptQ21QdTdlNGZSK2ZKWGxhaU9KRHBEZ3JUcDF6MVlIMmNCTyt5emVB?=
 =?utf-8?B?MzJrRmN3MFFyS3YzZFQ3UDhpUnRZcUxuVVE2TVJRVGJNUlB4S3A5UXNNeWpx?=
 =?utf-8?B?WUNmb2ZhQ2gzVHlrTVVXSEIrYnpBYkRZQ0pMU0wrcWFvM3A4VEZ4UzdBV2dO?=
 =?utf-8?B?U2F2Z1VhdE53anJZUTFGeCtJVFBIOE9RVlo1SWJ5TCtERk4zZjhGc3VaV0dt?=
 =?utf-8?B?MjZWVTBzcVpIQnp0NXVzZXNDbm5Idi9EN05Ua3l1QjhLWVYxYUVuMDNVT052?=
 =?utf-8?B?NnRuc0VOdnQxR1BQMmpnemZHcEtvVTMwaTR5R21OdThhL29nNGExTDNmVjdS?=
 =?utf-8?B?Mkx5S05mbUkrUlY3NFgraGNsV3Z6eWhnUndPYmZHeklIcFh3bkpNZzRCRGM0?=
 =?utf-8?Q?thXzWLikQZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWhaci85UG0xNERVZ1VJdkVjZXM1ZXJvckR6YjA2SW12bVV0MEozekc4TFcy?=
 =?utf-8?B?NUkzVExqNnBCb0JZbHllUlNqY0pONllMdjlhQjAyZ2l5UDJGdElBTnFBTC83?=
 =?utf-8?B?S0NlV21ORlFWTlpxZnE3L0MvMHdHVHV0bFh3QmR2S0tnZDJ2akh2N1laSkFL?=
 =?utf-8?B?dTFsOVdvdFRqN0hEV21XQ09FTEZXd0ZyQ0daMWtPSmNndGQvUDlqaU1iMDRR?=
 =?utf-8?B?VS9CZEZmOThaVjdMRWx0NXZxL1FwdDJJN1VRb2ZzU1BJMTZxeStyaDNHNCtP?=
 =?utf-8?B?eFROTXptUnBSdTQ5Y0NKTGFLRmN0bzVreDVrWE1OdzE4QnI2RTFzT3NyM3Rv?=
 =?utf-8?B?TXNCYXc4dnJjQ0tyQWxtT1M2d3dLV3JJNnFRZ1c1MlN3WXIzL3kyNWZtVGM3?=
 =?utf-8?B?TThkM0ZKMnMwTExIVW5HZWdMcG9hVXNlQTJHcS9VRVBqYTJpNW5tZFVIZTlw?=
 =?utf-8?B?M2M4em5IRWZicHRJUEYwenNleWMyRnJ0ekIxdWxLUElNT1E0SExzSnI0ZXhv?=
 =?utf-8?B?U2FWOGhvNlFCWThBVU5pQytFMUJ0cHhwaHdwOVVtamUzZ1puQ1VuK3pjTWFD?=
 =?utf-8?B?SmpRaG1YVTVxWFF1MWFlem0xLzkzZ2hrdWE2SHRSeFU5QkIwOWhYMnl4WnNV?=
 =?utf-8?B?REpjd1NHclhiNktCV2k0VlpQREFUQ0xqdlBFZ2ZERGgwbElydVVOR05aOUJt?=
 =?utf-8?B?VWhidDF0SUU1Z1RqNEV2RVJiSEVLWlE1Y1lYdUpHMm9GQ3UrYVZZQ3Y3bGpl?=
 =?utf-8?B?aEdnNTNiNGZsZU1ISlByT0VRUU9hS3FrdVNKRmxVM2JqRUczTjdkdGtkWmt4?=
 =?utf-8?B?RHRJVklOaGgraVAvTkRNeEo1Mzlvcm9WQWlNRkcwaU04QTQ5QlJtUzR0Lzhj?=
 =?utf-8?B?aTNOSmc1RlRpeUw0YTFPNEhkQ09GUjZRSTBkbFl1TUlrdWVUcHEyUThvZzBV?=
 =?utf-8?B?RU90aXE2WVlyaUlVZHdySnl2enRoY0hQWlptMFRoS2xTVkNwWS9yRENBMEt3?=
 =?utf-8?B?MnpOUDhHN1dpLzNWVkhIR3V6OCtQaVFSaHpjL1dtZGtHdWhoWUJ6Q25OTytu?=
 =?utf-8?B?OFpmWWVVMEQwbVlnRUM0QitETUhjV3pkNGFSOTViUWNUV2dqSy84MEdBSmho?=
 =?utf-8?B?RnArbzVzZ3pWOTBKd1hhemREYnZBenVHc0pZWmtpMTJEYitxbVUrbkVHYlRa?=
 =?utf-8?B?TDlQWTdzMnJlNlBwaklCOFZleEZqbm1qV2xYUWpDU0gvdFBPSVhRUnZHV09T?=
 =?utf-8?B?Yng3dG4wdTQ2ZU5hRFVzTVBtZFA2M1llOTRqM0ZzNk5mbStuQ3FIQ1BRVTc4?=
 =?utf-8?B?cWVDMjk3L1RiR0dQem9WUkpwZnR3d2dLWjJxdjBpSXBQU0YvaUprdXNTOVVR?=
 =?utf-8?B?dHI1RHJHaHdHcHkvaTYvbG5ybFBIcmdCQU5Ea3JaMHJlMzZGNkhqZ0VKeWFH?=
 =?utf-8?B?MkRkS1MvUkhlZ0Eyd004dnhCdXI2VU5tc0lEMVlhdUpYMWw1ZHZHUGdpU3VI?=
 =?utf-8?B?dnRYYTdQZnRFTjVoM3NlSnVxeVdkdk1ublhSekJnUDRYSWd6WEowOVlyVlI4?=
 =?utf-8?B?N0JZclNhNitGK3lhVnRMcUZrY1I3NkJ1dUIveWxhRWxIdFhWU1hzKzU5UVZi?=
 =?utf-8?B?K3JyQ2p3WVdMeWpKbjZkVlo4bTRzeHMzWUJWc0Uyd3hHL28xT1NzRk9rZnlN?=
 =?utf-8?B?bHc2MjRCTEpFamJHbDhIZzV5T1pvRSsvRlhCN2lTclN2enFNbHprS3FEM3I0?=
 =?utf-8?B?UTcxK3l0NjQwUXhJYXR4Qm95bHgxbjFENDYxdi8xcGtmQmhPdjFkWTE4bkQ0?=
 =?utf-8?B?Smk5RjZvL2JTdEJIUGtwSGZubnhNQ2NPRyt2RXlodU8zZ1pKSVNybTVWZEVs?=
 =?utf-8?B?UitRNklVSEZJUW9LRGRKelNYUmVZNytCNEpnelc0M2JubXNpZ3labmJiV010?=
 =?utf-8?B?NFhLeC9XcG1UMEhvQ1lMUnNSOWZwT1VrTGRhd1Z0THNQb3hGSVphOUp6cThz?=
 =?utf-8?B?UXdVeGxXUTkzRFVHNVk3UG5CRnIva3hEVmxwU1oyWWMxMEVJOHJldkRidUlV?=
 =?utf-8?B?WitzdTE2V1dJWjZQV25lMXQrNkhtNzVHMmlwekMvbDd0Z2g2Rm05aHFuazlW?=
 =?utf-8?B?cUVvR0s1YzVnTWE4RnJySE0yNmVSMzhxY1dSUVVsM1dWdWlZUjFWSHhNMVFD?=
 =?utf-8?B?S0VzZGI0Si8wZzlsWVBXYzltQmdyaG93aDVXNGpKa09LWWhpdlBFbnA4UlFq?=
 =?utf-8?B?RWhndC9zQ2JDbVhaSkw5dzJXRlRnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed296c0e-cca6-4cbd-9f51-08ddd8b8ddbc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:24:26.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElOLD6Up39nfxZUMexOIyvrALyp9pL29Vf2YXIZZ+NiHEul3C4s5STmlrtFbWmyiH52KxXUeFyp6aQDCA2ewQhkA3uahiheu0yRjBmGl+ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240
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

Hi Jonas,

On 8/1/25 7:09 PM, Jonas Karlman wrote:
> Include FDTs for both ROCK 5B and 5B+ in the FIT and add board selection
> code to load the 5B+ FDT when the DRAM type is LPDDR5 and ADC channel 5
> value is close to 4095.
> 
>    U-Boot 2025.07 (Jul 14 2025 - 21:28:20 +0000)
> 
>    Model: Radxa ROCK 5B+
>    SoC:   RK3588
>    DRAM:  8 GiB
> 
> Features tested on a ROCK 5B+ v1.2:
> - SD-card boot
> - eMMC boot
> - SPI flash boot
> - PCIe/NVMe
> - Ethernet
> - USB/TCPM
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Add DRAM type check in addition to SARADC check
> ---
>   arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 +
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
>   board/radxa/rock5b-rk3588/Kconfig            |  5 ++
>   board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 63 ++++++++++++++++++++
>   configs/rock5b-rk3588_defconfig              |  1 +
>   doc/board/rockchip/rockchip.rst              |  2 +-
>   7 files changed, 79 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..c07696c83913
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-rock-5b-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index d51fbf51cb88..e07b549c767f 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -46,6 +46,11 @@
>   	};
>   };
>   
> +&saradc {
> +	bootph-pre-ram;
> +	vdd-microvolts = <1800000>;
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
> diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk3588/Kconfig
> index 41dfe2402b12..98d630117836 100644
> --- a/board/radxa/rock5b-rk3588/Kconfig
> +++ b/board/radxa/rock5b-rk3588/Kconfig
> @@ -9,4 +9,9 @@ config SYS_VENDOR
>   config SYS_CONFIG_NAME
>   	default "rock5b-rk3588"
>   
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	select ADC
> +	select SPL_ADC
> +
>   endif
> diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
> index 4460c9971a96..c8a43769105e 100644
> --- a/board/radxa/rock5b-rk3588/MAINTAINERS
> +++ b/board/radxa/rock5b-rk3588/MAINTAINERS
> @@ -5,5 +5,4 @@ S:	Maintained
>   F:	board/radxa/rock5b-rk3588
>   F:	include/configs/rock5b-rk3588.h
>   F:	configs/rock5b-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-rock-5b.dts
> -F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-rock-5b*
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> index fc2f69db2241..6bf4497ce3ae 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -3,8 +3,71 @@
>    * Copyright (c) 2023-2024 Collabora Ltd.
>    */
>   
> +#include <adc.h>
> +#include <env.h>
>   #include <fdtdec.h>
>   #include <fdt_support.h>
> +#include <asm/arch-rockchip/sdram.h>
> +#include <linux/errno.h>
> +
> +#define PMU1GRF_BASE		0xfd58a000
> +#define OS_REG2_REG		0x208
> +

I assume the register address and meaning is stable across all RK3588, 
so maybe we should abstract that somewhere in the SoC file 
(arch/arm/mach-rockchip/rk3588) so that the caller doesn't need to 
specify them?

> +#define HW_ID_CHANNEL		5
> +
> +struct board_model {
> +	unsigned int dram;
> +	unsigned int low;
> +	unsigned int high;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val, dram_type;
> +	int i, ret;

i could be an unsigned number type as well. (and it should since we're 
using it to access items in an array)

> +
> +	dram_type = rockchip_sdram_type(PMU1GRF_BASE + OS_REG2_REG);
> +
> +	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
> +	if (ret)
> +		return NULL;
> +

While checking whether adc_channel_single_shot() is the right function 
to call, I stumbled upon the call in arch/arm/mach-rockchip/boot_mode.c 
which i believe wouldn't work for Rockchip SoCs whose DTSI uses adc@ as 
node name instead of saradc@. That would be rk3328, rk3588, rk3576, 
rk3528 and rv1126.

I guess there are different ways to fix this. We could have each SoC 
define a constant string with the node name of the SARADC or have an 
additional entry in /aliases for saradc in the DT? Maybe some other way 
could be used as well, just throwing ideas :)

Unrelated to this patch though, so feel free to ignore.

Cheers,
Quentin
