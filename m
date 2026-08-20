Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF14C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CA2D80D47;
	Thu, 20 Aug 2026 14:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOS8IWEcSE-Z; Thu, 20 Aug 2026 14:43:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787237001;
	bh=7VkzmL96UljvTw+FL8Yx9VsZGYmi+qIVGefdPqmRukY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LVJ3gaAkzQEpMqP36HRf1+Ufv6geAUCuoh30IHlCGQe+vFp9OfUlFG13F2UIMCt2a
	 jjxKacQD3ogkSIFaJBC/kC6IhAF+0RDJJ0AbgPr35SJTtqLXF28fVLVyaZateCCzoj
	 5WD6J00MgwXcLxPzNraT9WMZ7eXuIKoWz5bYBqo8BKP340h3w7a4Q/5NsyyIGR4LAc
	 wO+9gRe6tBc6MIGG8O6RTcgfXNTm2OGG7bWELyDst6yUI9K9/UGo7vhBQseOXAh3Il
	 0noT9msyAM36dOIUS8A1X+cmEuHE8D43XAHgioxvNmDnfI6gHBRTLO+wyTs7ckgry5
	 VVI+EmBHP881g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39DB680D77;
	Thu, 20 Aug 2026 14:43:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E010D40B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B1580D77
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4P9Dl8aoN0-i for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 14:43:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Uz4lhyQn
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E90F80D47
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFbjrXTHH9uJi3m9ZMvZBuj+j3KAi26ALjo4NZH359JuapCxKEsx7KHsWkqGPIHCJra1ErRm5ihVw0P7Dpnds56FyW5ahy9TSIqWjDL86QtMOS2C0SvCp9pLpuZK3fqVhh57Lcp+jmme8p0c0mbNSOHVp4lq9maqVsnE+FWSbJ0wqCsvDg8JC5SIw9smiplQrCVCWMi/GS57V5AT7WhTEk30FIIl3oNlP7RoB/7FkUBzV8eSUay3C0QvJiLnxgU3HapLD8NKvvctiD5cAY7FgJ+fgz7a/ggY+D6c2EX32bddCX6IaRF7CM/zGppmt3ACbMWTLKJ7UVYSUX7dOFJRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VkzmL96UljvTw+FL8Yx9VsZGYmi+qIVGefdPqmRukY=;
 b=gVnlTsgp7fdVfe7KI3Hwcc3lrM3FuInMgnROAaXXWR0gGwmQ0qtr+MYa4aB4qIDBHzrxzpofHqdtR5hLWCdkv0twaG/cqVEnFzJJzAg38E2qwsAhQnirFKDoun8/UVrsKaOdWJCjT+IyTNYCb4Z89EvpqH8rctNTpY0gzbW3iMZjoJ3zh7Zb3Cts0vpzPt9e3oVaW4wrVZXpxGguc69pEWUqiLTkaegogktyuFGgzJhDFUgY2zYuwOP4CTrew5OzeoJnwsg+SmgX/meGwHUX1HyWHqynIWgUotMfd++NKhlQvWMk7zRAQVK8X6jc5bqxJdqwZ/oNkUK2PVd7lG5qCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VkzmL96UljvTw+FL8Yx9VsZGYmi+qIVGefdPqmRukY=;
 b=Uz4lhyQno6Yj2nCHTJvfj/gmdz6emu0FtJR09KBT62KgkJYHaTC78AcpFQuGXGZLv90A4tvhHvSScnFx99djfUW4HczldLdNKSbJVlemoYSGQE3sg0mW/LQzwpeli3eBsM9Ze4Iywp8CJ9mO8J3vg5z7a8HcjoaPZbxHOtxsQAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB10987.eurprd04.prod.outlook.com (2603:10a6:102:486::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:43:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:43:12 +0000
Message-ID: <53bb3fd9-20ca-432b-8c71-7753ba1763a1@cherry.de>
Date: Thu, 20 Aug 2026 16:43:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
References: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:803:64::32) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB10987:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac89f5c-d543-4f09-2a8c-08defec95c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|18002099003|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info: JKltD9DDllduSY1eDFZkOLM8YCj0xzswBVptfDavY0iitwgbf19zXI7q0JaKfbhqOWYMv7AOL7n7JNVBaLjfs5GJkRPcm+14yzQULV1DG18Y1U4Dodlx0vj1035kXO0+f8tbjgc0GgwK03Pah6oTCuIe5WGAc21Ix7rmLs999w6rxjsnOowc6zoAfHvKpKK4W4NAhqk3xJiclegmwNjDepuKfIVFLyL3J3PfznV83O2EVzH3Jd9QkXcc2cVOle4dwCIkT0pYrZZC896dIAKq3utNxX89APjiLyheXSiNQ7WQ4WE3NwTI2rkwsh+Fw0C13JEjqZqbjfu17qgK13Au9G21tdi2vmybmGCTeoGlzULau4rEl9wnyd/rHWvhEHUAzbIljZZ+2+VMerlzTn78ye9bp6KAlyGF7ppncQHSPvXgCd6pMd8MpNWbIh1mnCtsvddIdPGBVVgav7IJFUkHTuorS6/GgauiZY40iMnbEtmRSGgr0eIyyn2ZmRBC6DG7Ib64hZ9bNogClEeVrO1ZllgPILUaBYLegrVdh7/noK49Ts+2o13TAxmQyfHCa5rbZPjFJhf/p1nPEAg28SUSiyPsboN8PS3nT7SPJaqu3wTZHqiFDMsnqYhu02t3ojJemct38tQ0PGG1PbfQoKXF9u/mNLc678pMo5N+OFQSJbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(5023799004)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZralRWcTEvU1pQVWpmWFZ0MWRiTjYyV3lTMFJxeFo0NDZaTjVTMnoxR1dD?=
 =?utf-8?B?OFRLK0hJYnJXc3Mvc2xJbkx6TUNQSWRmVnlYQk9iM1ltYUNKcUptRnJJZG4w?=
 =?utf-8?B?THVwWDBsU1FEbUpnTUdRWHZZME9FZTNzVzAvUDIyaWdTMzU4TUdpZlhWWVBR?=
 =?utf-8?B?N1Z1WHpmMUFBQ2k1Zkh2aDNmRjQvdzJRZXpLUkxBaHRjSC9DVmtkUkVUcndI?=
 =?utf-8?B?SHBCY05Gc21NdG1iRFQzZzRUQ2tQYWJoNHdYUWdxODNFYTMwMnExdmM5SSs5?=
 =?utf-8?B?Qm5SY2lHSGoyZDVVRkdFN2t6aHdWb25aTmxQa1hld1pabEhYem82d1FvQ3lE?=
 =?utf-8?B?YmtlSzlXOGJTVm1PWUF4WDU1alRlRXlJZHFvNWh0NWYwY3o5c1c3NXRleHBv?=
 =?utf-8?B?TlZha3BXMEU1NjZ3QWVsenRjb1hndmhzN1lKblBPdEgyZlJJZXU3UjVVeEha?=
 =?utf-8?B?Q09pdG5hLzA3SjI1d21zUmlJdzFLbWY4a3E2dHk2czQ0VWdPMWdESy93T0NY?=
 =?utf-8?B?WWNaS1NJM0t1YmxQcEpaOW9CNG1RRXVEMlRUQ1FpSUlkTUJtbzUwZDdxZnlW?=
 =?utf-8?B?RmkxQmcwWkQ5aUN4SnJlcm5NTzA4T3pJczIxbHhzUXpJbGNvczdzMHhGajlr?=
 =?utf-8?B?UHZlOW9mTHJmVkZzVHBxUW5hbC9BUTRyQm5kcXJuQXZ0RFYzQk5WaWlZOWRh?=
 =?utf-8?B?UWhVQlU0NlNsU0IxZ243MFkyQ0IyUEVKbW8zMnQwcTl6TnhRbnVEVktrVzUw?=
 =?utf-8?B?MzNOTlJXaUs5T3M2dlZocE10UTZ3b3BsdEhpdm1sVVNHQXhmd0dURWRoZyt2?=
 =?utf-8?B?TE80UDRQaGJCWWh1eVphZ3JXVlc1eXRBZ0hVNHhPU2pscWZzY0pjT3F4VWFV?=
 =?utf-8?B?TTIzSy9GRFZiT2RXTGYxTmJYQ2tFSHA1RENVbjUyU3NQcWhRakdUdXhFNk92?=
 =?utf-8?B?bFZzSTFNbFF1ZUlGay9SOWpVOEJrT2JYdkJqZ212YUtyNXVZUDBJVUZaYkpX?=
 =?utf-8?B?R295SndzN0hvakVSN2ZaSXhMekJpMnpvZFVqSytRQzJYb2lzWVBDaDltTDE1?=
 =?utf-8?B?K0ExK1A2L2NOOXNwU0FGVkRBMG0zbG95S0p4RVhTQkZMQS93R0RoaGRHNnBH?=
 =?utf-8?B?eS8rcmNDdzV6dkdKenZRZEUxRVRHS0kzMnRGcThhNmVaVTE1d3VEbGlvWmxF?=
 =?utf-8?B?UzR4Q1l4QVlFb0RZWnpORUNHWXlZcWJxeVhTSExocDI3eDRNQ1pKSFhKekhU?=
 =?utf-8?B?NmYvdWRGRkZCUEUySVkwZ3dockZxV00yZWpyc2R6M2hidmxuMnEwYlZ6cG5F?=
 =?utf-8?B?STNwYnJYZ0NOSTB5UG9XNS80M0VRU25peHBJODJvRy85WnBXQjIxRmhrZURs?=
 =?utf-8?B?anY2ekM1U09sYWtiR25CMDd3UUoxQUpXeWpXRFd2QjgvRmg3OFhzQnk1RHdD?=
 =?utf-8?B?czFVMDRPQjhBVk9XMGxuTUtVOVNKNlFjaFVwNER2cGY0Q0J6NkhiNzVZUENU?=
 =?utf-8?B?UDQrK3JCa0hXRnI4MWY0ZFBvVUcvdlFyTzh5aUZKUnc2Z2hxLzhFcWlvUGdr?=
 =?utf-8?B?ZEcyNVJYS3RHWERWUkw2TEtYR0NBcHAwbWxaWjRNZFYxVTJlMVVINUJna21L?=
 =?utf-8?B?WFJKelhzaHJVQmM2bm1DVmRTT0NibFVBam1zbGFjTXpCV0NFWml6WDM4dEdG?=
 =?utf-8?B?dmlEQVJPSGJWYkhBMS9mMGhpNXZDRnAzbnUwWjR2Q0hwYjc3VGRhNHJkNkRW?=
 =?utf-8?B?R2VrbjEzeGZRSmtiRFhqNzVMdXc5TXZSaDYwUzJacEhKdzF5RThmUGV5aG8r?=
 =?utf-8?B?M0NLMTZOdEFyOUY2M0ljdVdHWE40VFQ4cUNoV1pJZUVnbDUzUmlpN2s0N3NF?=
 =?utf-8?B?cGQxclRQQk1BbDNkZmlJSFROM2VjY3kzSzJDWGVwZFk3R3FTYzA4L1V3SnV0?=
 =?utf-8?B?cDJ0Q05kVE1HQjZ4b0ZmNWJ3NHErakpWU2QrVnhyeWFPV2RMd3lqdzdhR2g5?=
 =?utf-8?B?QUlPZVVxOFNHait3NUJ2RnhMWWJDM05FNlNPSVBJT2pLbVVyY3pBVUtabWg0?=
 =?utf-8?B?YkMwQWlyQ2V5MkdaVFFLRGJ2MDR4Sy9QWXprU1ZEYnNBeHc2WkIrcm1YUFFl?=
 =?utf-8?B?VldRMlJDZnVpUUxYbkM3eG9GMEhBUEtiMTI3SzJ1dXR3VmtnTnBGM2lidWtr?=
 =?utf-8?B?U29rZFl3Vi93bXEzZ0x2RUhpbnlZa1FaZk9qMnRZcE94MmM1dHllOTd3Q1VR?=
 =?utf-8?B?c2dMdkhEWUZtb1ErZUFvME5iVzBoMTgrTnM0NUpacFc1c1JHNmNnSkxuZ2pM?=
 =?utf-8?B?UU4xeGtFMkxkUHlBRmN6WERMNmljVFBoS1JHbThwdkJYcGJZUUJOZlg0T0Ur?=
 =?utf-8?Q?U4X0q9kfxxD9/Wtn/TRJA6skkjKSMRvHIAbjKiU6SxUBH?=
X-MS-Exchange-AntiSpam-MessageData-1: qxV53uhaSxPt/A==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac89f5c-d543-4f09-2a8c-08defec95c5d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:43:12.5464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8YqjSGbNmRMrwTd82QM2hJMkUFe9hBON5KEV5wAzeviiucPv88XJ7T5GSjat7+GwDu3ogJN2PQQg8h/pZd3Kq/oS4/+L6K+MfucMG2pB/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10987
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

On 8/18/26 3:15 AM, Cole Munz wrote:
> The spi-peripheral-props binding shipped in dts/upstream allows a bus
> width of 0, meaning no RX or TX is possible on this device. The
> switches in spi_slave_of_to_plat() only handle 1/2/4/8, so a width of
> 0 falls through to the default case and warns "spi-rx-bus-width 0 not
> supported" on every boot, even though the devicetree is valid per the
> binding. The fact that the wire is missing is then dropped from
> plat->mode.
> 
> Map 0 to new SPI_NO_TX/SPI_NO_RX mode bits, as Linux has done since
> v5.12 ("spi: Add SPI_NO_TX/RX support", mainline d962608ce218).
> Bits 16 and 17 are the first free mode bits.
> 
> This comes up on devices with no MISO line at all, such as a
> write-only SPI display described with spi-rx-bus-width = <0>.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> Raised as a boot-log warning on Flipper One, whose display has no MISO
> line at all: that pin is reused as the end-of-frame GPIO. Reported at
> flipperdevices/u-boot#33, and sent here rather than to the fork as

Please provide a full link next time, not everything is hosted on GitHub 
so we wouldn't necessarily know where to look. I knew because I had at a 
look at Flipper One's repos a few weeks ago and remembered. For 
reference: https://github.com/flipperdevices/u-boot/issues/33

> suggested on that issue.
> 
> Verified on sandbox at 527115ef6783, with spi-rx-bus-width = <0> added
> to spi.bin@0 in arch/sandbox/dts/test.dts and CONFIG_LOG disabled, so
> warn_non_xpl() reaches the console the way it does on the board.
> 
> Before:
>   $ ./u-boot -T -c "sf probe"
>   spi-rx-bus-width 0 not supported
>   spi-rx-bus-width 0 not supported
>   SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB
> 
> After:
>   $ ./u-boot -T -c "sf probe"
>   SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB
> 
> It warns twice in sandbox because both the pre- and post-reloc DM scans
> run there; the board logs it once.
> 
> ut dm spi_flash, spi_xfer, spi_find, spi_claim_bus, spi_set_wordlen and
> spi_flash_func all pass with the property in place. Nothing consumes the
> new bits yet, matching d962608ce218 in Linux, where the consumers landed
> later.
> 
>   drivers/spi/spi-uclass.c | 6 ++++++
>   include/spi.h            | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index 120565df1497..0f0d4b1384f2 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -229,6 +229,9 @@ static int spi_child_post_bind(struct udevice *dev)
>   	/* Device DUAL/QUAD mode */
>   	value = dev_read_u32_default(dev, "spi-tx-bus-width", 1);
>   	switch (value) {
> +	case 0:
> +		mode |= SPI_NO_TX;
> +		break;
>   	case 1:
>   		break;
>   	case 2:
> @@ -247,6 +250,9 @@ static int spi_child_post_bind(struct udevice *dev)
>   
>   	value = dev_read_u32_default(dev, "spi-rx-bus-width", 1);
>   	switch (value) {
> +	case 0:
> +		mode |= SPI_NO_RX;
> +		break;
>   	case 1:
>   		break;
>   	case 2:
> diff --git a/include/spi.h b/include/spi.h
> index 97096a775262..f477763bdc60 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -34,6 +34,8 @@ struct spinand_info;
>   #define SPI_RX_QUAD	BIT(13)			/* receive with 4 wires */
>   #define SPI_TX_OCTAL	BIT(14)			/* transmit with 8 wires */
>   #define SPI_RX_OCTAL	BIT(15)			/* receive with 8 wires */
> +#define SPI_NO_TX	BIT(16)			/* no transmit wire */
> +#define SPI_NO_RX	BIT(17)			/* no receive wire */
>   
>   /* Header byte that marks the start of the message */
>   #define SPI_PREAMBLE_END_BYTE	0xec

So this is fine, but incomplete. We should really do:

[...]
struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);

if (din && (plat->mode & SPI_NO_RX))
     return -EINVAL;
if (dout && (plat->mode & SPI_NO_TX))
     return -EINVAL;

return ops->xfer(dev, bitlen, dout, din, flags);

in dm_spi_xfer(). To avoid calling xfer() with an invalid configuration. 
This would then match the Linux kernel behavior (c.f. __spi_validate) 
and avoid all SPI controller drivers having to implement logic to avoid 
reading/writing on NO_RX/NO_TX devices.

It'd be nice to add tests to make sure this is handled properly (the 
function returns -EINAL on invalid configuration).

Please send the spi-uclass.c and rk_spi.c in the same series (in 
separate commits still, like you've done here), with a joined 
cover-letter (the info you added to this patch and the Rockchip one is 
good enough IMO).

Cheers,
Quentin
