Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF3C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0A588247;
	Mon, 26 Aug 2024 18:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ApMaiPWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA8188A46; Mon, 26 Aug 2024 18:26:11 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4086C880E6
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjeEbZJNN/jKOeiQwtCr5qQ9wzk39dWN1t+5evjpOHCRbY+a4MA7h10roZdWj70DC9uVH88JBzjaKmhdp/dFhjrVyhJYrmqJJIEGPGay9YCmlGeA2hGKjhK0e0sORqM3dOVb0A/R1qTL512ysbQltsgrTYH1RfwEh1dVqe7ZQYGSzbrGSHhrq8GwPS6cP74WbmmwOduk9ODNXjwcUgtZ9qGMGtPO17W3CjYb3hqXKSkSkB3i7tOkf4NjX5DLljXC4jg+yFJAmh2cnuDeDH2PvlLuMFw0akNkBfOeem3TKr38RXtQ0J6el4e2A7WirM0eLdKsncYTp+Nzx70T8Chy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY4fdAmt7hjdZZU9chIgH4/BjKJWo2/kGzvm8je0GBw=;
 b=Md9Nj3Q8fD62KwzjLt+9QOUQkukhYIkx12nAJi0mskqRCrwgDV+7wECf7gzL0JCQ+ulyG7P6cMRLDUIwS8+rBOgnwGlYiWA4XhVGVf5jiv6MpXufiz/eJSKum8NmR7KqxXWEOI7mKouLfNmjCOQL2GOrCz2LoDtUfxJJw7i3uiNjER0sv9+IZv09lYFX72w6GnnpFWNYQ2sYPUx4HeMni59M0gOBp8yDJufKqCvJeLLKVxJlKDBHOt1doVD6H17Y7VQBLwenAFL/WG+yHeBzUQfSCi6ByOfF2ZqpM0hZjmHJShvk2LiVISvFKDwvzk/1q+9L2DPUNkl+gqtPeEdKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY4fdAmt7hjdZZU9chIgH4/BjKJWo2/kGzvm8je0GBw=;
 b=ApMaiPWmsPJgQhCK1d8jwCn6tV1saLVHUoGuKyquqxGGyZRxzDsCgF5F71o/AOjIVYmd4OD+h5yiYAqY7ldzl9LcFir153erHwbyXdKM/lVwAXPjuNZAk64RnyPllUYfRIZXLsLOA4Di+RRbkWT1XRaRGAtzGVX9SlTy52B7cZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7399.eurprd04.prod.outlook.com (2603:10a6:10:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 16:11:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 16:11:21 +0000
Message-ID: <2795c560-d36e-4de2-9b72-fb42b245d7fd@cherry.de>
Date: Mon, 26 Aug 2024 18:11:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: add SPI NOR flash support for Radxa E25(CM3I)
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240824220701.97796-1-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240824220701.97796-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: d658eb46-658a-484e-d6e5-08dcc5e9b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUNUZkorQVdIejliQmkrVXVKVCtGRFFpWnhYdXJGNDFiRUZCd0ptQVRJUjhR?=
 =?utf-8?B?ei9wYW9HMzcvNmlkVGdSQU9vcGdieTV2NXh4eVFOaEJUOTU1V2FWRjI3NXNr?=
 =?utf-8?B?eWFjMndJTVVNTUEvR1l4enVVckFCZldSQzBBSUNmd2N4Z21JNDFnY0RSblRi?=
 =?utf-8?B?QjhIbUJ5bmdIeGE1bDdLK2NyY3NVUHEvNGJPK0VGa1BMbE13MWJkVlR6MFNp?=
 =?utf-8?B?K1lMNEV6WFFYU2tPVks1NHdRZHU2aVoyS3RLNXFsUHR2eTdrOWtUaHdodW9Z?=
 =?utf-8?B?WjZDK0U3VUdyQlp5NVNHWVJ6NjNWVGFOKzA0WTBpRzdkZGNCb0pOUTNkRmxi?=
 =?utf-8?B?U0R4SE1sOUpJamkwZTJOMFJEZ0dHdjRKakd0RVJRT1JwYW1RaGFSVVZENFJG?=
 =?utf-8?B?c05yV2kyRnl0ZEFjanVlZmtGNzZPS3JEZmw1RmpjbG5Hd29ML1luRmNkTUx3?=
 =?utf-8?B?N1RJS1REeFljZDhoSkFvYnZJaXlEZnE4cjB2b3UyNGdmT2s4NWlSbENsczVQ?=
 =?utf-8?B?TDV2MHhUWGtZY3lJU2hrU0hldEFJc29INHZTNFc0a0QyTGg3aGJDV296V1lm?=
 =?utf-8?B?by9oVDd0VDZPczN3dDFQMmVSNGE0cHM2UUpKYUoyK2NSZUdQK2M2amxoTFMw?=
 =?utf-8?B?WjNwcVljWG9OdkNxWGJwL05zS1ViaU1tQjJBN25jaWRvNmFvV0tMOVdjNFU5?=
 =?utf-8?B?czB4NlN6cks0ajBUZ3VjQ2ZHbnB1T09maTF1cUFBR2pLMUNnU2hpbGk1bmkw?=
 =?utf-8?B?Njh5dkVHN0tIU3o3UjhlemRocjJQY0pzRFVwY2ZwR2xWdjV5VDQ0MFUxOE1w?=
 =?utf-8?B?d1BVNnAyS0hmRmg4dWloNFBseDd0S2dzRjIvRE9PL0V1eFlUODFwejBHTjda?=
 =?utf-8?B?NGVVbUtsUHplYzlvdWVURC9Ia0ZtMHVMODg2WGRaTEpaMG9zeUE0RGlGVzA0?=
 =?utf-8?B?akNrVVMrbVA0VkJtOGZ1YjBLaXIxT0dzc1Z4clhsdWJhK2hYaHY5ZFhJb0c4?=
 =?utf-8?B?VmV4QjgrcG4zeUU0WUU0dXhyUEJHcU1XbG1YTXBYalNKa09PaTM3dk1PY1ZF?=
 =?utf-8?B?UVBaWXNzSUdQbmtPUUpIMGRTM0pkamtPU2ozaEk2MS9CQzVEN25zSXJOL3By?=
 =?utf-8?B?dzVjU0xBUWorc2dEbnp5ZnBYdXRhNnAzS2hKbnNqTkczSmFFQ2FIeXBOWjhl?=
 =?utf-8?B?Mmc2TS9FZ1Vwc0x0a3dHc09yZ3VFNHdyZk5iTkRIWmQ5a0pQZEpMUnIwSkJR?=
 =?utf-8?B?c1NCSkgxOFl4SmdPYmNSWE82WEcra0FFaTZvTXFhTTM0ZndiamJTQTFoUmdK?=
 =?utf-8?B?S3NIcEhybndiNTdnRnNZYUpGSGVkUnNrRWJONmdhNnFCSVg1TXFBemdtcGMy?=
 =?utf-8?B?M0FtZDBtVE1EQURCSDZ5R0xaaXovNldkSEZRbUs0SlhHTnZIMHBieXdGZjFo?=
 =?utf-8?B?c2w2THlxZkdaeTJJRTVjbEhTV2RnK2g3eEdwcXFCK2JITzY2V3JtZ0VSblJF?=
 =?utf-8?B?alVUdnJKRVVyNWhkTU00amtOQllxVGhOT1Z2Ym9MZFFKaytENHN0b3lIN24v?=
 =?utf-8?B?R0s0Q24rRTJVSEN0QlBLak5qcGJkamhHb1pZZ1REZXpOUlVERWkxWE1OaW1t?=
 =?utf-8?B?Y2FnV1FiMlVUN2dQbmhoQXd4eFo3MTI2dzZoVUFxOHJRN0F1bG9lUHpzZHpn?=
 =?utf-8?B?cWplRzBJNVR0T0orM2NqQ2x1UFpaenA5YWc1Z05vZTNXN0dmRjVjMnltY1dF?=
 =?utf-8?B?VU9oNndmbVlnQ2pHUHN0b0hPSGpZZUdZakpvVDlhaVRPeTlmb2Z2ZDZFdmF4?=
 =?utf-8?B?QlN5Z2V4SzhOMDNEOTc3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDA4ZTZpMXplb1Y2cytwK2lWbHA0OTVCOVpwcGRLYzNpd0loejJxRzhQenR5?=
 =?utf-8?B?OTRRenl6RzVCZWRIaUhwL3BSRTVYNHZZS3A0S2NmOWVXV3ZVU21ZTnpqVlNU?=
 =?utf-8?B?OFMxeERNdWR2KzY0Z1Vvc3dPYk0yYllBdjFaSkxsSXRaZEhuTXd5QzVVbEFm?=
 =?utf-8?B?Ky9WbXJza1VuZU00cEV2a2JEYUt2SjZucVZiaXRwOUlGK2hpcTQ3SnRUcnl4?=
 =?utf-8?B?eUQ0SHJkbFlaT2wzKzJ3NWRvNlNDb0N4L0gzUitnZHREamNOMjdPOGtPNEUy?=
 =?utf-8?B?VUtvY0hONWVFTTJoMTdGTkJjTkFGM09maEZZSzhFMEo5YlRFT1hOMk53WWRo?=
 =?utf-8?B?akxIL3R5dCtXNlFMZElrNjN2Wm83aHBOYkgycGEzRUNjQm9xeUpYTHZQU2dr?=
 =?utf-8?B?Q2pjZUpHVmg3Mk1oU3pLakpYTG1HTEdXWm5YNFVSUFJMa3grSEk1cCt0M3Zx?=
 =?utf-8?B?bzhHV05aNjU5c1oxTkhYQkdpeWxZd016Z2xPbkxOZnU5RjdNQnBlTWdSWE5Z?=
 =?utf-8?B?ekdrREhUTithWmgwY1FrQjZiSE1qTXdWaVJMaElSeGJaaWo1Zm1MTEFYaHZr?=
 =?utf-8?B?QURPdlF6TlQ0TWVUNnd5dElDSjk5eFBFZWhucnFzWkdiR1U0dEc0aCtpdzdS?=
 =?utf-8?B?eUZHVWdWaEI1TmoxdmFjeGZJakF6QVlhYVljWUxPL1FWZ3B0Y1pPZkZrQXVl?=
 =?utf-8?B?a1NjcHNLZlRFNGNUcGw0bU9GdTBxckNUTzUvTWpnK3N0eUxFeWYydlovdm5o?=
 =?utf-8?B?MlZVMTRxSEFnWGU3OEpKTXY3ZHFVSUIvVFlyVDJvVXlYUVd4VHNBTGFrOVQ3?=
 =?utf-8?B?RElhTmE0QTZSdzlUOHl0d0F0ZXNrWE9OZ2w5elVYVUtNdElZb0o0T3hFR3JV?=
 =?utf-8?B?WVNCZ3BsTWpzVXZpa1p5NUk0eTRUdGhidHZEQmUyUHBkSkhDZXlCdDVnc3Zu?=
 =?utf-8?B?SmlkWUlQMWNoYWpJUkEvTWdLLys1MWYyREdQME9DbjdYV0VDRVRITG1DRyta?=
 =?utf-8?B?NTZqTGRhc2dFM0RKc09QMHpqRlRiRm53UEFOSklPc2pRaUJoTmJTWUwxUWVw?=
 =?utf-8?B?K2swam9KT0JqSTlmT1EwelMwRVlQdldWVTlqZWo1Z3FjQzBjYjVPdDk0ZU1a?=
 =?utf-8?B?czJaTDJJVjQwV2ROZEtLc1JtUGd4OWxnMWNFcmhWVGF5YjA4dDNDMWZWSjB1?=
 =?utf-8?B?NWtTeTRvYXdwMmJIZnExL1NXdGlXeklWd0srNlFUWFVlSzNQZXBiZGUrNFo1?=
 =?utf-8?B?S1V0a0hFcW1zeGRqTjhLcnpGZWltRDhsN21RTXErbGsyV2xNdjRkZGllaURT?=
 =?utf-8?B?RGhxV0lUb05oWWdWUjFpdlN6SnBTNzQ3VG4wV2xlQ2ZOdFBFdmVNaGwzNXMv?=
 =?utf-8?B?YWtoWjc4RkV4WXU5Vm1aR0Vad1pUZUs5VmhkQkU1N0lHWktaVklFSkwraHJ2?=
 =?utf-8?B?a3htcyttcEJaVjY2QmlPL1lUUXRZeXE3bHdEYTFxRnpjZ1EzQzRiSWlzWUJa?=
 =?utf-8?B?ckp1aFd1cTNiTXBXT2Q3aWR3bWRTRExuTUNiQ2pJYkZjUWdBNzFHNU1OOXV4?=
 =?utf-8?B?bjY5R1F4a0dQblJxblh1Nm81S0RmajhHWGtXV2RUYXp1ZVRHcjk1YjRtc1da?=
 =?utf-8?B?aVR3ZGFXSzg4dFFvYmVYbTAzOGNwbVdRS1ZIVDFlK0llcEFzOThReW9hWVJF?=
 =?utf-8?B?ckVpOXpzZWdtcWV2M1VuUzJ1c3JtSHNCb1FGS1BZYWpvcmsvTXRlSlF4aWtj?=
 =?utf-8?B?a1E3OXo0ZXMxM0VIUkZ2NDRZTGoxajZLdXJ1VVpPSlk0Ui8xeTlza0FFRThP?=
 =?utf-8?B?aHNGMExCS251RFJjbE01YUkrUEp1eTA3SXB1T2VMVnBFWnNFNnpWcGpzTjIv?=
 =?utf-8?B?QS9ZakFPdlhsMFg1SUMrRFhWNzJFL3h4QVVralh3cW8reWpCb2ZFZEtYMGVm?=
 =?utf-8?B?aFdZNk9HNmRlelo1dUt2UUcvSURPSG5zREtZN0prbFJDbmY4UlZGNkJ2NFVT?=
 =?utf-8?B?R2ozM3oybUFwNWFvMk93cGtDc3JGZDZXdFEyS1dQYmNvdjRvcUZMQ0Q0QmN1?=
 =?utf-8?B?VDBSSjBLVEV6QjUycVh4TjQycDRMajZjR3JIVWNmd0JKZW9acDZWK2xlMkVH?=
 =?utf-8?B?THZQRTlQYlhtSHo0MFhXM25rUld1dHJjUmI0Z21iblpOY2RGV2p0VkxxNVo0?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d658eb46-658a-484e-d6e5-08dcc5e9b965
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:11:21.3870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYi0LdSClKHbLrM17IOlReQk0EGd5rMpbQwgDg0h9soFwyjeF9FTbJeHilSUyg3e+OvFinlw7MhkMH6mIuOLtNcwz7hQBWKHSKbXPIIPbP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7399
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

Hi Naoki,

On 8/25/24 12:07 AM, FUKAUMI Naoki wrote:
> some SKU for CM3I SoM have a SPI NOR flash. this patch enables related
> configurations and changes devicetree.
> 
> => sf probe
> SF: Detected w25q128fw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v2:
> - reword commit message
> ---
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 16 ++++++++++++++++
>   configs/radxa-e25-rk3568_defconfig        | 14 ++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 74755a44eae..1f0bacbf61f 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -21,6 +21,22 @@
>   	mmc-hs400-enhanced-strobe;
>   };
>   
> +&sfc {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		spi-max-frequency = <24000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +

Was this sent upstream to the Linux kernel already? I did a very quick 
search on lore.kernel.org and didn't find anything. Is there anything 
that's preventing you from sending this to them first? I really would 
prefer to have only U-Boot specific stuff in -u-boot.dtsi DTSIs.

Cheers,
Quentin
