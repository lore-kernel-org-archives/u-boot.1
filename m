Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10AEC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 16:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 892B060648;
	Tue, 21 Jul 2026 16:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTnMsjLLmtCB; Tue, 21 Jul 2026 16:34:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43AFC60843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784651666;
	bh=YYbIacdmbbjHZvxvy9pSckmuY+H8WESlVhTFZn3STnw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Y7EYKXX2b3vtKBIpSVAWY5t0rcAdjQ2C+BorhQS+0JxzVLqncWNZOyQcXbcWxEi4I
	 rU4ybEwAMotO3lGm5dhq0Bsl2cHX6vgLDJ8XeoqXBhsdZjr2R9mApuNmSQdNG8K3Tf
	 W01m33QuWXRkivAi3bfghhj6Awxd1E2Y4qE21fyr+ZBR7YTJU48U9IZPfdUvW6+oDl
	 ZI6JcjO0+ZSM3LpHCIsRs7wsRKRgHP3H/lqSfnIFEbY+Q3No4r83KizpAqeuqMkW66
	 zitPp2wYuV2Q0L7xKjrrMjlIzoflQmdS71CglMQBx7+jviaUjRk88UL8EY2F2lhzJw
	 c0k0DOd/xgGzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43AFC60843;
	Tue, 21 Jul 2026 16:34:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7E95109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AFEE4066A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BY1bGULhCNet for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:34:23 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 011D240576
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 011D240576
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 011D240576
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:34:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D41284659; Tue, 21 Jul 2026 18:34:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA30C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 18:34:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNsCvw6Wn8ua3WCxmV7thL0M+ufQtR+Ic8+z1PCOkablou5/nlxGbR33bo0Ho15UWQy6qHjKI+fQNEtn8uexmDZ4H1xZ7RX0GVNj0zXUe3ELnZTLV9lqU4t4URar4uQMQiT7M7rvKuTlNQqrZ1rIIWGm9aJdpdpVExxroomDbG5pczE5Lzw6HUK4jINZqng4rnqfyYGhHuoZRJUioXlangZx+IqPNFSOI9+nF0m5pteI+Z8Wr0pu5RJ/N33D1g+y/IX9977P+z/oqhfvArLPDuNZVFtlopvzm6tc3uE/yPfcxWhcTbIf15q4dJTEJ9eh4R5XLKNEzW6Cfq0wQ6CXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYbIacdmbbjHZvxvy9pSckmuY+H8WESlVhTFZn3STnw=;
 b=NicqItgykNCkwz3IDnNNORllWml8xxrQrgPodjj80r7aThqMP72g3H7Y7XXbTLvr3utLa+Zkj21l9ywapyfLYhIADJmGIEPxg2c8KCdmqUZncfSytczAuNZwoaflKIb3fKmboHElnQWE0Pvn8YH9yTmcU4pYfQvBjlpLnhMVgCP5uW4q5z/LZxMsUP8Aw2yMZg5WK2TceYzEyPVpJnIxqegquMYFEsDmlmKjgy4jcCtXusqADILL6hWadYv2rIx2ArgdDLZkUKx/1YQ3FvQG76P+KoLef9hYPBjDSuxcil6X7lokEtOH3F3Q0KkuXlbHkohCsVhmUMGomAVKPKyDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10760.eurprd04.prod.outlook.com (2603:10a6:800:25e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 16:34:14 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 16:34:14 +0000
Message-ID: <8b27556e-057b-4461-9ed4-f7b6ecd1267c@cherry.de>
Date: Tue, 21 Jul 2026 18:34:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
 <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
 <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
 <c42cd1f8-2a74-4ef7-a426-ad43ee038b56@cherry.de>
 <CAKTNdwGikt3VqNhRLWVK7fUtycijLkCS269Xgm4uqHPknpg7Bg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKTNdwGikt3VqNhRLWVK7fUtycijLkCS269Xgm4uqHPknpg7Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:50::29) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 841896ca-445f-4780-c56f-08dee745e68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: x4grS2Q5KT2W8VuBcKjtiaAOqLCT3YAujemlRLX22Wf5kKaYRoTVWVc39BfWgYy0r0qWOYWgotdODcTUBpTj0WqogTrp5D1r6DZSSiQns1kJ/6dnL5KONo1IR/Z4CO0pZlsVROb/6lBBChSctUjbELVthFH+3Oc7xPIVn5QWszr82XTn4nfTwNkEOufh/4Hnaz316WViLlpNhaswFchkZi/NsKF5wkSgjF6WfX1BnvHkhI1L/4oLdDip8sQ6Ew97PqmDjH3yVxqKvBdL8+khCyPTxP917Rg8LV2mb4vPKtPjRxaYD+bYTEqcMfbaVZmrCqciacInQ3Z8BuxzXBdBJ3mAGoe62n0QKPmGS+HeZWzIb6fGf8XFEGXAPGyP+JNjvrN0lGC7/apM2eF/n2E+XRToJUtteyNGNhza1+fFRfi2Qsqy+Or1r0x87WCJMFoUkZPWrGAQBlIccXdiwIs6sGfjqd/xBPWNlZOxlxWRfUQ7NH5e0t21XkvCG6N9s29wXbDlL++iyWREvctb81BQKDClCnOBs5HD1OtybI/okShEKcxfmmndqFHYQ7cAFUgvb8j8qLN8yt2DuEQ5F9zRb43jais6Q23TCwlCZHQCOumZHJ/wroSpRuo2Dt5KjyON
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dQUElwNkR0d0UxWVlUWWMrUHA2VU1zK3UvZmtIckNpSkY5OHViY1ZtMWVO?=
 =?utf-8?B?UGlCSE1SWEUxam0xd21MMGFVSDlIOStBVGhvcmZKYVF0OEJENm5JTkZGY2xz?=
 =?utf-8?B?ZisyZGdhNXgrVUJWMmtsWXRkTUxpZHNPOVU1aXU5MHV1Unc2cXlVTkUrVWhG?=
 =?utf-8?B?SERUbE9wSVR4U28wenRQK3IyS3lPWlpwMTVaWFRRQTlYTDJmSHNxWkQxNWpP?=
 =?utf-8?B?emY3VHI4YmVnNFFzK1BrdThzRDJiZ2diaGtMVzNxWVAvbDNnNWltWUxUaFZI?=
 =?utf-8?B?cExVOFgvUmtsd214OTNFVFhzM2JzSEpQN1FEbkhIWnRTK1ViUDJXdnEzb0pH?=
 =?utf-8?B?YlhaMGVLZ2ozL0hiYUd1OW9lTWJ0dVNlS25OODY5OEdodmcwekRrOUhEbXdv?=
 =?utf-8?B?T2lCbXJmR3pZVmdRalZxWHpZMDBGem90dDFmcFZaRTladURjSWxIQlF2ZkM1?=
 =?utf-8?B?dVlkaTVlTGZjSjA2MnBrMHBxQ0FpQzJpdEErQ1BnWWdzbHZvSEpLcU4wUGoy?=
 =?utf-8?B?T0cwN0JvMm0rTm5SbXhxcWloZ3lVZWtudlMxZkhQMzN2bWZZa3BJcFd0aGQ2?=
 =?utf-8?B?TjZodExiWkk3MmNobUdZd3QreExPalBtTzVPMnVlcGwwbm9kN05VQ0JyaEFV?=
 =?utf-8?B?N2lJRUVmYjNKVFpnOEpuOUxPRzdRTFh5ZXdmMjRtSDVkdHkrUmN4NytVQ2pr?=
 =?utf-8?B?MXFMQUdwSGZ5M2oyK3lDVTA4L2JoWVFVNTc2U3p1aFpJbXNheWtQekNpNFU4?=
 =?utf-8?B?c1U4SG4xOUo5bk9tRi9CalZkcFRqcWxuT1djcWJHYi93aVE1aVRGNHltYTky?=
 =?utf-8?B?MEdpaUdIekdqRkZGMW5RNGNZaUJNWFFtZ2hCMkdvMFJpdUdKYnBHSUM2MTNM?=
 =?utf-8?B?Z0luNktNTXhoS2JZZ2hUVXF0Rk1DRHdUZ2w0b1NMdURKajl2cXFnK2JiT1J4?=
 =?utf-8?B?clBRU0tTNkswRi9ZTlVhOGJzY2dqMERYdGgyU29kWDZLS2czL1grU1d0UDdE?=
 =?utf-8?B?cHlGazRsWS9WL0puTTN6RWE1WXB2Q1ZnT3pwaHhEelhtZVpmeE9FS0gzRzRl?=
 =?utf-8?B?S0pNaUZsUUZReE9EMXF0V3NXZFEwSG5MQzhSWDYzVWsyc2p5UGR1TUtZbFpT?=
 =?utf-8?B?WkQrTEY4OTJTZFFiaDVicjA4OVpKcWFxT0RxMkZIWHBHVmpzVkdvb05QbkN0?=
 =?utf-8?B?TmtTay9UUTB3MHFzbHdCRjFDdXhoWGEyZ2tJOUlMOExoMndlN3BqUzgydTg4?=
 =?utf-8?B?Tko0a2xoNFVRVnFpZFVEQ2VJRGozMWg2ZzRaOE1KaUpBUDBjUFVWYjVYWUY5?=
 =?utf-8?B?MGozMGNSODJweUMyNlEwS2ZoSkoyZFVCQ21KazREbGRILzN5Ni93UE9Md2l1?=
 =?utf-8?B?LzM4UUQxNVhxN3RuVVNXS1BodVMvSXVBK0JkYXlXMHNUQlZ0N08vQUEwSkVY?=
 =?utf-8?B?QjdPaDVNWVBHSHh2MUpjVTFjVGQxQW52ZTdEQytBRjJhRjFnb04wOFVBU2Jl?=
 =?utf-8?B?Ni9vb3I4MkUrek9Ma2NkRVZDK1pYVG1wVUhkWUQ2bjlSUERLSUY0WEYwdWd0?=
 =?utf-8?B?RFl3WHBVVy8rOVZFVlNiOTluODZFUmtNNHIxa1g3WkhyQVVES2xOYjlVRkpx?=
 =?utf-8?B?WmE2UjFhZ0gxQXFyeEpvaXJrL0QvcVgxNFNYYm1Gd1Rsa2F4aEg2TXRxWW9m?=
 =?utf-8?B?ZDhFVFRxQkRXbGRzOHlIWlRybG45RU9iMjEwT3lOdkMydlJ2OTlsNWpQNTRy?=
 =?utf-8?B?WGVncEs3NTgraDB1Q0kvUVJybDRsOU50NXpCRVBCWmhYdUcrVktFTzhrb3lQ?=
 =?utf-8?B?eDIrU3hlQkxNdnQ3T1lDOHR0NVlLcnIySFVHZDJRUFMxb3Z0bHBWaEdjYU5u?=
 =?utf-8?B?bktCRGt4RTl4VXIwVTNvZlZCQUN5bXlDMFdtbEs3dit2aU80OG5nYTZRWEdY?=
 =?utf-8?B?dUdVM2NsRWpYVjZ6OEw1SGM1UExLSzBNeTFYaElTSDNHdFFSQkM5SUVERVdL?=
 =?utf-8?B?QXlkVXVCREt4N1o3R2w1YWJHV3JXRkkxdXk2Y3pDVWlTcFJGemFVZzN0V3hk?=
 =?utf-8?B?dlNXTzBwZG9qWHpVZXpKUExRS1dWNW45MlU2M1paQ3AraGFUYnJJTEorL1Zh?=
 =?utf-8?B?Z2Y5SXEvSGQ3MXpKVjN4ZXk5NDNIQkJLVTBkV3V2M25SNXl4OXFFTWVJdGxY?=
 =?utf-8?B?TC9KTkJwSWdjKzQyNWhob3VKY1R4em56cHA1dmtOWDZSY2U4UTYyR3g2d3c0?=
 =?utf-8?B?cmU5SzRCb1ZMMlRpRHRwYkFnU3haamZvME54OGhHRjdJeGhHZ3ZraExvaGR3?=
 =?utf-8?B?aUovcUZ6c01nUUUxYWlzLzNnTlliY2VqWHd2aTB4MGQzOVphVks5Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 841896ca-445f-4780-c56f-08dee745e68f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:34:14.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/s51lJLWiOJ1EuNU+9izsxV3A+gT/r3hfB1Ru2q/qjuScfWHzFiQ3Dae50KXTTe/emijks6+jRZJEak1hpVqpALLeR3LGRf1Ds27v3hSiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10760
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYbIacdmbbjHZvxvy9pSckmuY+H8WESlVhTFZn3STnw=;
 b=LVkDi7iw81y7dFligCQV2gGXWQ601hBbWp/O6HOH4q3taEUDIAa9CosoFPWY880vd35V+fpJBSfPJQibC1UxStUBnk+NlFThCAMC2vPFGdanREtXZNLXdxOlRXeoc3GDMSz6E39nW96QE577b5EaqKGk84MtAaocIcvj6usfxn0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LVkDi7iw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="LVkDi7iw"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 5:21 PM, Alexey Charkov wrote:
> On Tue, Jul 21, 2026 at 6:34 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/21/26 2:46 PM, Alexey Charkov wrote:
>>> Hi Quentin,
>>>
>>> On Tue, Jul 21, 2026 at 4:20 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 7/13/26 8:35 PM, Alexey Charkov wrote:
>>>>> The TRM defines the fractional PLL adjustment coefficient as a signed
>>>>> two's complement number, 16 bits wide, so store it as such to avoid
>>>>> confusion.
>>>>>
>>>>
>>>> Yet...
>>>>
>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>> ---
>>>>>     arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
>>>>>     drivers/clk/rockchip/clk_pll.c             | 3 ++-
>>>>>     2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
>>>>> index 95b08bfd046f..f9bfdfb8a6a3 100644
>>>>> --- a/arch/arm/include/asm/arch-rockchip/clock.h
>>>>> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
>>>>> @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
>>>>>         unsigned int m;
>>>>>         unsigned int p;
>>>>>         unsigned int s;
>>>>> -     unsigned int k;
>>>>> +     int k;
>>>>
>>>> ... you use int here instead of s16, any specific reason?
>>>
>>> Yes. What matters here is the signedness. The table value never gets
>>> written to or read from the hardware without accessor functions, which
>>> mask on writes and sign-extend on reads anyway. A generic 'int'
>>> usually performs better than a fixed-width type because it aligns
>>> better and requires fewer instructions for arithmetic.
>>>
>>
>> Is the performance gain worth the potential confusion around int vs s16?
> 
> I'm not particularly attached to either approach. I just prefer using
> general types when there is no hardware-dictated reason to use
> forced-width, and there isn't one in this case. The other coefficients
> use general unsigned types too, so mixing in a single fixed-width felt
> ugly to me. But again, it doesn't matter much, so happy to switch if
> you prefer.
> 
>>> It also reduces potential churn if this table definition is ever
>>> reused for another SoC with a different width for the k coefficient,
>>> but this latter point is more theoretical.
>>>
>>
>> The kernel uses a union in rockchip_pll_rate_table, maybe we should be
>> doing the same (totally unrelated to your patch though)? It also uses an
>> unsigned int k (still, but maybe you're working on that? haven't seen
>> patches on the ML at a quick glance though). In general, I like to not
>> differ tooooo much from the kernel as ideally it would allow to backport
>> patches from the kernel and more eyes have read the code.
> 
> The kernel also uses a wrong denominator for the fractional component
> (65535 instead of 65536). I have a local patch to fix that, but
> haven't yet sent it out (mostly due to the fact that the kernel
> doesn't use rate auto-calculation anyway, and writing out a table
> value directly to the register doesn't care if it's signed or not).
> 
>> If all we care is signedness, I would rather have all s16 or int, not a
>> mix. But if the kernel keeps using an unsigned int for k, maybe we
>> should wait for them to change or just stay with what we have here?
>>
>> I understand using an unsigned int for what is effectively an s16 to be
>> quite confusing, at the very least we can add a comment in the struct.
>>
>>> Shall I reword the commit description accordingly?
>>>
>>> Happy to set the type to s16 if you believe it's more expressive,
>>> though; we aren't doing much arithmetic on the table values anyway.
>>>
>>
>> I'm undecided whether we should diverge from how the kernel represents
>> the rate table (that is, switch away from unsigned int for k), but if we
>> do, I think we really should be consistent and avoid optimization at the
>> cost of readability/confusion (except if gains are substantial).
> 
> Happy to convert the whole struct to fixed-width values for
> consistency then, and submit a corresponding change to Linux along the
> way.
> 

Let's see what the kernel has to say and then we can do the same in 
U-Boot once there's some agreement there.

>> I see that the kernel only has a table of rates, and doesn't do maths to
>> figure out k and it seems they store negative k's in their
>> representation in a unsigned form (that is, values above 32767 to
>> represent negative k's). I'm guessing we cannot store tables in U-Boot
>> because they would take too much space.
> 
> We do store them (drivers/clk/rockchip/clk_rk3576.c:22 and
> drivers/clk/rockchip/clk_rk3588.c:22), but our table is smaller than
> the kernel's.
> 

I'm really starting to wonder if it makes sense to have both a static 
table and a way to figure out the dividers (including fractional) 
dynamically, especially since we fallback to the latter if we cannot 
find the desired rate in the static table. And then we ask to find a 
rate with an input frequency of 24MHz but this expects the PLL to have 
its parent configured to use the 24MHz (xin_osc0) input clock... which 
isn't guaranteed as far as I could tell (yes, it's the register reset 
value but we better hope nothing changes it before U-Boot runs this 
code). While looking for this, I started to read the clock driver a bit 
more and oh boy... it doesn't look good. We **really** shouldn't be 
using anything rk3588 for rk3576 because many assumptions are made that 
it is only rk3588 and not anything else (e.g. it uses pll_id **integer** 
value instead of enum (because it cannot, otherwise it wouldn't compile 
on non-rk3588 devices which don't define the enum) to identify PLLs and 
decide to which offsets to write, etc... and of course, the enum integer 
values are different between rk3576 and rk3588.... I wish I hadn't read 
this code.....

>> I'm sorry this mail is a bit all over the place, but I think there's
>> another issue in the driver. I believe we shouldn't check for rate->k
>> before calling rk_clrsetreg(base + pll->con_offset +
>> RK3588_PLLCON(2),...) otherwise we may not clear an existing non-zero k
>> when setting a new rate. Is that correct? Not required for this series,
>> but I think it should be fixed (if I'm indeed right).
> 
> The check looks wrong: it should be conditional on the given PLL
> supporting the fractional coefficient, not on the rate having a
> fractional component. PLLCON(2) register is not defined for
> integer-only PLLs such as LPLL or BPLL, so I'm not sure if they react
> nicely to a k being written there, be it zero or not.
> 

Yeah, better not try to write to undocumented registers if the vendor 
BSP isn't doing it as well. I don't think we store which PLL is an 
integer PLL and we cannot simply use the PLL ID as they aren't all 
defined for all SoCs (e.g. RK3576 doesn't have NPLL, B0PLL, B1PLL and 
RK3588 doesn't have BPLL)... I guess we may need a new member in the 
struct to reflect that.

At the same time, the kernel doesn't seem to bother checking that and 
simply writes to PLLCON(2) regardless of the type? c.f. 
https://elixir.bootlin.com/linux/v7.1.4/source/drivers/clk/rockchip/clk-pll.c#L967 
so maybe we shouldn't as well (yes I said the opposite in the previous 
paragraph :) ).

We also don't check whether the PLL actually supports fractional 
dividing, we only check whether the input and output frequency are 
multiples of 1MHz, but we could have something based on an integer PLL 
try to get a frequency that wouldn't match this requirement no? Or do we 
have a mechanism in place to make sure this cannot happen?

>> I'm wondering also if we couldn't merge the loops in
>> rockchip_rk3588_pll_frac_by_auto() and rk3588_pll_clk_set_by_auto(). The
>> only difference I see is that p cannot be 1 when we have an exact match
>> (the for-loop in rk3588_pll_clk_set_by_auto()), but if we modify
>> rockchip_rk3588_pll_k_get() as suggested in another patch in this series
>> to return 0 on success, we could have the function set k to 0 and still
>> be valid. What do you think? This is further improvement and is not
>> required for this series.
> 
> I think it would be tricky to explicitly prefer integer matches if we
> try both integer and fractional in the same loop. And we want to
> prefer all-integer settings wherever possible, as it avoids the whole
> sigma-delta block, along with the additional clock jitter it can
> introduce.
> 
> What we can do is just inline the rockchip_rk3588_pll_frac_by_auto()
> helper into the "else" branch of rk3588_pll_clk_set_by_auto(). Having
> the two loops next to each other can make them easier to compare
> visually. Let me know what you think - happy to rearrange those in v2.
> 

Meh. Less appealing now :) I wouldn't bother but you do you :)

Cheers,
Quentin
