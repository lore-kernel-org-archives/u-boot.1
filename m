Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A10C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 14:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAB2180D1E;
	Thu, 20 Aug 2026 14:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZFzkDJsKyXK; Thu, 20 Aug 2026 14:31:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787236269;
	bh=ALcxJYCatevehxbmbfdljHZGbOLXPsqgkp5oTBGSKb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IHfs5jm9Ghi1IaAWxLDqzmM4MNjFiplnW12nGOMPdI3gRxagR4kxB7vGBEyAdyd+9
	 x2dFy5YZc371toIug0NDOZT/9qOY+7UN0F86AraLLizpbzBwl4QCDJceflZcObI3JS
	 eKFrYwupB2DI9KyECyNhUiPUthBeN+h8GDlJQS02vCT7JO3aDuixigNPV+/EZBRbII
	 ZzIotycf2Txn4LTGrqAasEsNVlLH7wP76YXI2GXQuP9lYm6ABKcJnJ8Pls1LjnLnDz
	 Lc74Kl5alctaKKoZLGuCAmHK7rut+OHN9C7m+toDitBW/WTpLvCHgRCswdLKP4tY7m
	 IKwqrRe7n482Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B54B80B91;
	Thu, 20 Aug 2026 14:31:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CEBB2279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC2E780AFB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9kg7a5oQG81 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 14:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=XTpDMpNu
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6236080AA1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEBPvjHL7DtD7EZnqz8t4NkUe201i4KSA/dSTp0EOIyWxzxf55qBHn2CCNcQAU0/RRR6EOSG0nsSgOsJGpZHeVcTGnvAR0zkt4swh0vi3bxK2RiCZdmq20mv/6IMMXWkIA8uVTtwH8pMj77SHmbUs/zgB/rp4ztFs1G8oXdZFr8AAsZrApseWACfUw/dhnwFDG6eAXQTGrZw9ElvmgQr96yaaNaSRh2LKNZEcRa0c5mOPdE6a3TtyqO+pwvWgV7VKhgJEnSReqzZEXZLuITkMFbto88CYrF9KCKOgi38tJJUDxDqwp+y0F0zXU0TtsIGkt89bVi67h8PSh2GkCYD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALcxJYCatevehxbmbfdljHZGbOLXPsqgkp5oTBGSKb8=;
 b=CgQ/vpFgSW8opExMo7UVC3Jk7EfqV45JInvb/1vX3zT1tJe4ykzm4mHmXme0G0SVItXG4N8dYOmSKSh9/5eVteZhhCoDhKarUWHp0khA6iaGaS2ferJeir6T0GDb2oejt207UxiPOlDU1CSWJSgY5ykV/DZ37VmP6bTzUsvGrNQPLaKEFGckuB5tjR71iOaGHP81UvI8KD9w71JXCa/E3Vjqr7r1lKUt03XQ/nZa13s8isWO1FfDMn1hq5AhzboZd/GUXUaP+b7PtLq3U/YI9MZB4jKPp45/w+dbvre2det3fZ1Ddj+vOThiF1VJPNWsz8w5cVhxKxiRye1KnqSVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALcxJYCatevehxbmbfdljHZGbOLXPsqgkp5oTBGSKb8=;
 b=XTpDMpNuDv5ESv0IIrMIlCc9k3EQSnUXBiu+ZS6zmH7RKYjoEkkhRiPWZGiZFQNeOaxXBnC83ocMmFxbaNfLHfoYj1LNZ4gakmONsSWYguwspjCOO7pU0Os0HJlhS7uyfkc66EfYAG98zub3eTZMiuomwZTrjE9XUCu2Bwa6lfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:30:57 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:30:57 +0000
Message-ID: <8ddab8b5-2081-4d6f-9ebd-c32d5521bc4b@cherry.de>
Date: Thu, 20 Aug 2026 16:30:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
 <CAKTNdwHMga0XG1zfgLYirMbVK8iVpWgjyr9x49sQ2ofPNu+w3Q@mail.gmail.com>
 <69c35eba7ee1a353107459b8f8032e92506a3fb1.1787045568.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <69c35eba7ee1a353107459b8f8032e92506a3fb1.1787045568.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3ca737-b914-4c2e-f4ab-08defec7a5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VHjFpuTO/KNq3J/nGKyLLHxsK2OgaIxb44NI3TVYA/hpBg9N+Gs1VUocoqiaotEqRnYJnLawqgL4sD1hqk81/7oxCh+c+F3bh3mMO8+b+fbt39Do+gphqoPwxeh70agSJGsChXAP7MSJJQydkOfR/FtbcfWWaezB6W/rx6LPGL1At2nZvyJ7pXqqabeBGyHJ7NzfUg2aQKKmuyE42nAFMzg/LpQbKbMkP0bpJ9+EIwbhPQCGtZ+CG6lS5lbxAEQVvXtKT+B1Bt7x009RiZPQvCYczEaiiB3OPVJMjSwkLVIR162LUh2wTqBK3w/MP/xnSIIesQs/FEuycfWYWynd+xY1aWRSe4JUa6tu4aBkiwVOsyhy2i0MMLMoWLYzcE929MRjr4ku0p6DnSx/OmZzdNKFbncntGqMDLdyW9PVKNHnzRdsoolpY/Coyy92W6sKSGvx/41IxsBdWVayC7e8VReszB7iuFiFhjirJYmflYW+DugMOIsLW/Xe1TEsBGepjhZRGw+jTcBst1P36u9V6121xO/nJTMn5pDzOsmrxMbT+lpyB457WNS31ZtnBufYdMWcm1ISTqkuk3AU+R92Xm3s45O5DGc7Tah0Gpexg6Ic2NMtbBx5IbNPphb62QaLKdr3C8YCuWRs8wTqsa8sp1V5VsZxT/uKBLF99x/rDwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODRRdGJpN2FySHJBOSsrc0hoem9jVERldHZiQm52NUtnczdGNzhHdWNkSmVy?=
 =?utf-8?B?Q212bm9qSGp5S0Fib3VIaThrWk56N3V1WDdjb3BrUlNZcVB2VnJzWU1pT3Jx?=
 =?utf-8?B?V04xSGlhNFgwSVVyUlhWN29Lcm9xN0UrN0FDOGZGMjAxUGpvS2tNcHhBbkNk?=
 =?utf-8?B?UmtFQXhSYk5seE43NjZDRkNRMkFuWUM0QzVqM3F2Uk5RaC81YS8vY3RsQlYv?=
 =?utf-8?B?enhOTFJ2L2FrVHdPT0NORFFoVlpTZmJtckhWU3JsMDhkcmRaRitPWTBUMEw3?=
 =?utf-8?B?SmlKWWdBZ3hIQnNhSlNaTHRjMms1ZXcwM05ON1ZSeU45cnRVTU96T1Nqb3VK?=
 =?utf-8?B?OHdoU1U5T2VEWStzUEptUW44REZsM09zc0VLV29DTDlaNk02L3hnRHphc2hL?=
 =?utf-8?B?QUdRam0ySWpFQzJpMTJwTE4wK2Q4VXNUZXQ3Z2NMbUMwbHllNllGVE9hRFFD?=
 =?utf-8?B?SlIvVlVHZGR3by96ZlRpaGxhVEhpVmdrZUFPRTJ0dk80VmNTSTFlNkU0b0lr?=
 =?utf-8?B?ZisweGpQVG93RmVJblhnR1BWb0xCS2JaeVoydlFKZUljTDZFKzVVNTlYbE5y?=
 =?utf-8?B?bUU5dERFVXJVRi9Rc3UvNDdmUEg4KzMyaHl2cWFaaWsySitFZXpUZkF3Yk1v?=
 =?utf-8?B?eTJPZUJqRllrWkUrM1N2dG5xWjJxZzVCYWg0OVkxa3NZU3BQWVIvRDRLWkZI?=
 =?utf-8?B?c3oxcWJPaTFxNWJQY2xncFJUcW9PVGJwU3ZUTmhocnhRVVVwR1JwM0dCWGc4?=
 =?utf-8?B?eDFrZmFObktLd0Q1bHB5aWdMMDdqNGRYS2VCK2tUbGdoaXovVzhPNGRNRURP?=
 =?utf-8?B?MlVoMmJxdmlGUzVkNDY1ZHVLUk1nUGx1V2xCR24vRHhOWHRXTUhJdjM5NkJt?=
 =?utf-8?B?Yzd1QlpKeURINkEwN2ZHUHhWR2FzTEZrZU9RbEZQSlI5RGI0bjdNMVV4R2Rn?=
 =?utf-8?B?RjQ0MGlKRkl6UnlmUUJORWxKdFduUndoL3BTLzBkZFJMc2lKcVpsbGxScnlx?=
 =?utf-8?B?THBVVjhFZ0tRcHJWSENuK3k5YVpZOEwvNWxpVU4wa2dkZjZQdGNGUzNtNkhn?=
 =?utf-8?B?SXM5WUlqRUV6R2p6Wnd6OFhwQTJvMDF2RTZaU3BpNnh3d0ZWVU1XcnBpdVlw?=
 =?utf-8?B?S1hJOWdYb1Ird3BQUnhIREpQdEttM1M0VXAwWmREK2hOVlVvUVV4ejNCN1ov?=
 =?utf-8?B?blBkZVFwL29YSVVSR2VDVWFuVys4enp5aFpBbWpTd3hLRXRyaEVlTnZJSWxk?=
 =?utf-8?B?anhGajV3MTBIRlVPekVpL1FqUDFkcWUvWHlQVU0wems5M2Q3MUpia2NsZDNZ?=
 =?utf-8?B?aE5RZ1YzdXRGRWVNbnNkTjMzZHgwUlZkZEZyUGJqVHRySWhPSjlvYTVTbU1u?=
 =?utf-8?B?ZWlFaGRuSk5iaDQxT1NTUzJQU2I0aDZoeWRJS05VNFJTbU40NEdTK3BUcGlC?=
 =?utf-8?B?MnROR2VEanM0ZE1tMGR5NlIrSHJpMFBycU9JKy9DUnZwbk03S25zK3owdVN6?=
 =?utf-8?B?K1E5M0trc1VoUVU2YkpCdUU5SlpWalNGTDdSOVJXeGZkdjV6dXE1MkltQjNw?=
 =?utf-8?B?OXcrYTVDWW5ubHRmemt1TVEwUEpEUEhkRjJ3TmpiaCtTY2hXWURoQTlYUkJv?=
 =?utf-8?B?bXFVU05ESWhzQk1hS1VJZGVoMUVvS1NiWHF0ZjhJc1pSS3EvU0JZMm5OTG0z?=
 =?utf-8?B?NlRwalRXSDdIazRjbldGVmdpR3pkbnNBdi95d1htUTk5aUlKdDdLbWVTMXV6?=
 =?utf-8?B?K3luU1RuWmY2bTNNWUxma0ZYR0JiR3VkRWlaK3FlOW44NWNMWU8zdVRMS09r?=
 =?utf-8?B?VjhFZEJ5OU0wdytGNEI5TGdYSlkzeUxhMzZZNTdvZmhkS09EV1JMamllWGlv?=
 =?utf-8?B?QTlHNEVlTWRYUnFMUFE2b1RxZE1Qamh2UG1CbFdCczAvbXJBNThmcXFCbGlt?=
 =?utf-8?B?bEl1YVZFSi9UTkpiTE00ODAxc09oNGFpMHBNemlCZzNtNU52STF3SWZhQzdY?=
 =?utf-8?B?ZDVLRTN4YUl0cU1pTjQ0QWVqN2ZOc3RUWksyVVpQK2lBbHBhMjMwUFpSdW5X?=
 =?utf-8?B?Qy94dE81Mm96VndVelNkZGxqL1dqdFA1M2htcEFSa1loVkN3WTg5K0ViSjBl?=
 =?utf-8?B?VXR4bzZyUzV4K0Vmejc3SGdneFdzTGlLTFpNUi9rV3pxYlFOUU8yNFQ4UnhB?=
 =?utf-8?B?Umw2U2ZrN2h2eUZRWHpqTld2OU8rNXZ4SmJhZ0VOTjUxTEVtYVJubytYTXNS?=
 =?utf-8?B?d0tKWDRyU0p1d1F2VVpLOUhnZ01xR1ZqZEJqeW9jRXlKUXVnUmFGa2xCcXNK?=
 =?utf-8?B?WjJLQm9lMXVxZlo2WVhpY2o3YTZuY3ErY1J6VWdEZnlCOVdPeWZqMXZzL3dR?=
 =?utf-8?Q?RVosDuMNMu+sXM7PI+nZQUoBL9NfxnQ42E/zGPnvORACO?=
X-MS-Exchange-AntiSpam-MessageData-1: VTL4IcXYU9rwrw==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3ca737-b914-4c2e-f4ab-08defec7a5e5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:30:56.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im8dI81+uR8Qwrbyy5HGcVtGRj3yR2JhqPrHngh9Y6mnJdQytpEC42Tv7GBVJ/weE6YPZiQgRrFGwq9I7KzCH5tthOPgkOeck0Wjv8xlSXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Cole,

On 8/18/26 11:33 AM, Cole Munz wrote:
> The controller has a transfer-mode field that can run transmit-only or
> receive-only instead of both, which leaves the unused FIFO out of the
> transfer entirely. The driver never used it for that: claim_bus always
> programmed TMOD_TR, and the only other mode came from an opportunistic
> switch to TMOD_RO for read-only transfers.
> 
> A device described with spi-{tx,rx}-bus-width = <0> has no wire in that
> direction at all, so now that the width reaches plat->mode as
> SPI_NO_TX/SPI_NO_RX, pick the transfer mode from it. A write-only
> display stops clocking receive bytes nobody reads.
> 
> The transmit-only case needs one more change. The 8-bit loop paces
> itself on the receive FIFO and sets toread unconditionally, so with no
> receive path it would wait on a FIFO that stays empty forever. Leave
> toread at zero there and let the existing wait_till_not_busy() at the
> end of the chunk handle completion, which is the same thing that
> already covers a transmit component today.
> 
> The restore at the end of a read-only transfer went back to a hardcoded
> TMOD_TR, which would undo the device's own mode. Restore what the mode
> asks for instead.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> Alexey, this is the FIFO wiring you asked about. It applies on top of
> "spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX", since it
> needs those bits to exist.
> 
> You are right that the first patch is a no-op on its own. With this one
> the Flipper One display bus stops running the receive FIFO at all: the
> MISO pin is the end-of-frame GPIO, so every byte the controller clocked
> in was discarded by the loop anyway.
> 
> The part that is not just a mode select is the 8-bit loop. It sets
> toread = todo whether or not the caller passed a din, and drains the
> receive FIFO to pace itself. In TMOD_TO that FIFO never fills, so it
> would spin forever. Leaving toread at zero and letting the existing
> rkspi_wait_till_not_busy() close out the chunk keeps the timing the same
> for the transmit case, which already relied on that call.
> 
> Verification, and its limits. I have no Rockchip board, so this is

OK so this is a bit confusing because in the previous patch you said 
it's a boot-log warning on Flipper One, which is a Rockchip device, and 
here you say you don't own any Rockchip device. After reading the issue 
on GitHub (which I guessed because I had seen repos for Flipper One on 
GitHub already; please add a full link next time so we don't have to 
guess), it seems you indeed do not own the device and just derived this 
from a boot log provided by someone with access to the device.

> compile-tested and reasoned from the driver, not run:
> 
>   $ make jaguar-rk3588_defconfig
>   $ make CROSS_COMPILE=aarch64-linux-gnu- drivers/spi/rk_spi.o
>   CC      drivers/spi/rk_spi.o     (exit 0)
> 
> checkpatch --strict is 0/0/0. A full board build stops in binman for want
> of BL31 and tee.bin, identically with and without this patch, so that one
> is my missing blobs rather than the change.
> 
> What I cannot check here is the hardware behaviour: that TMOD_TO really
> does leave the receive FIFO idle on a real part, and that a write-only
> display still clocks out correctly. If you have a board in front of you,
> that is the bit worth a look.
> 
>   drivers/spi/rk_spi.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
> index 2c3d70ba7159..6c2ed3a90bf9 100644
> --- a/drivers/spi/rk_spi.c
> +++ b/drivers/spi/rk_spi.c
> @@ -283,6 +283,20 @@ static int rockchip_spi_probe(struct udevice *bus)
>   	return 0;
>   }
>   
> +/*
> + * A device that declares spi-{tx,rx}-bus-width = <0> has no wire in that
> + * direction, so the controller can drop the matching FIFO entirely instead
> + * of clocking bytes nobody reads.
> + */
> +static u32 rkspi_base_tmod(struct rockchip_spi_priv *priv)
> +{
> +	if (priv->mode & SPI_NO_RX)
> +		return TMOD_TO;
> +	if (priv->mode & SPI_NO_TX)
> +		return TMOD_RO;
> +	return TMOD_TR;
> +}
> +
>   static int rockchip_spi_claim_bus(struct udevice *dev)
>   {
>   	struct udevice *bus = dev->parent;
> @@ -330,7 +344,7 @@ static int rockchip_spi_claim_bus(struct udevice *dev)
>   	ctrlr0 |= FRF_SPI << FRF_SHIFT;
>   
>   	/* Tx and Rx mode */
> -	ctrlr0 |= TMOD_TR << TMOD_SHIFT;
> +	ctrlr0 |= rkspi_base_tmod(priv) << TMOD_SHIFT;

Please reword the comment to something like

Configure RX/TX mode

(or remove the comment entirely) otherwise it's confusing.

>   
>   	writel(ctrlr0, &regs->ctrlr0);
>   
> @@ -472,7 +486,12 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		writel(todo - 1, &regs->ctrlr1);
>   		rkspi_enable_chip(regs, true);
>   
> -		toread = todo;
> +		/*
> +		 * In transmit-only mode the RX FIFO never fills, so waiting
> +		 * on it would hang. Completion is handled by the
> +		 * wait_till_not_busy() below instead.
> +		 */
> +		toread = (priv->mode & SPI_NO_RX) ? 0 : todo;

The SPI core should not even ask the driver to read anything if it knows 
the device cannot read. See __spi_validate in the Linux kernel. It 
should error out instead of silently returning 0 and not read anything. 
This needs to be implemented before ops->xfer() is called. Same applies 
to the transmit path if it isn't supported though I wonder what kind of 
setup we would have with a controller with no TX routed. This is also 
required because otherwise the driver may still read when requested, 
c.f. the rockchip_spi_16bit_reader optimization at the beginning of 
rockchip_spi_xfer. If the core validates as expected prior to calling 
ops->xfer(), then this wouldn't be called when someone attempts to do a 
read on an NO_RX SPI device.

Additional thought: because dm_spi_xfer() specifies "writes "bitlen" 
bits out the SPI MOSI port and simultaneously clocks "bitlen" bits in 
the SPI MISO port. That's just the way SPI works" we cannot do the same 
we've done with towrite, that is:

toread = in ? todo : 0;

would be incorrect and breaking assumptions from the code. So what you 
suggested would be more appropriate indeed.

>   		/* Only write if we have something to write */
>   		towrite = out ? todo : 0;
>   		while (toread || towrite) {
> @@ -513,7 +532,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   	if (!out)
>   		clrsetbits_le32(&regs->ctrlr0,
>   				TMOD_MASK << TMOD_SHIFT,
> -				TMOD_TR << TMOD_SHIFT);
> +				rkspi_base_tmod(priv) << TMOD_SHIFT);

We could optimize out two clrsetbits_le32 by checking whether 
rkspi_base_tmod(priv) is already TMOD_TO, in which case we don't need to 
do this after rockchip_spi_16bit_reader and at the end of 
rockchip_spi_xfer since we know it's already correct. I don't think it's 
necessarily worth implementing, but wanted to mention it.

Cheers,
Quentin
