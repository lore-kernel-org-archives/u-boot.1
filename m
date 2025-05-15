Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3117C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB5F82B32;
	Thu, 15 May 2025 15:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c6cuOOSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5B582B32; Thu, 15 May 2025 15:40:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1490782958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBH7oYYWskPR7DXxz0/jqVFYzx6OGkaOIInbeSKqib4zoQ1RDCCTr7KoYIaO6aNPfPnj6xsqJ51JLm3xeKEnHeyEhM0jSJsBgHiPyIk31cI4QcuGbk8EnFpSQEczWPJA1jVCD8p8vNR7YxEqXg/ElTArRVezJ2OQyyfpe5Apo1bJEVloRLWjX9LOgceEs53BqjyKyxCc3GI4JF7tae1h1NsZ1YmYvG/dqinmyZ4z9kF0JzzpjnJRSEoF/qMBufYAIvNfHj+Vl556bK3EWBtaZsVnMLRGY8xP6IV61DXkl43EdcSGn28kWw6Azb8lNfO1JrsmjS6m6PHGuf1p5Tn/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e+JplP2rgUFeQAQk7Rv2KK4+XWMwnA6VJTGKYh8xec=;
 b=ygTPBnMLqp2L4z0QKBN44z/a9KhYd8SSbcoNpICruEaP7ITjXpTpcRWjeFFNlgbjLPq6vB2FWdbZ//8xrxILw5y3/D+4l9tue5pAJEvirCHLrP0SmEqJvsEr0P4Wso/INUA1xMNxWkLX4EbtQkLf+tAQCjN6l5mF405pf2oWEh/QtHitT77pR6Kjs0knsF8gmCoNwiXWFZOSOv9IT2EjGkPzpFOs7pjdNmQUafmdeyslyxgLboFXVgXbdn5zVOzd1EIjQijGwAP2OiordjKB1wDbGu6mQzo4NNphNrx9HXCZRZ8aDNN4Fb4tfA97NaeFumWppS9eEV5vGksRr9MaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e+JplP2rgUFeQAQk7Rv2KK4+XWMwnA6VJTGKYh8xec=;
 b=c6cuOOSfDWKSz/wMl6ee/7b+4za7QVIalU8Vt9KdwuDWoBtEoqLzadlXl5sFt1CQJqy1G+7nO2Ct5aHPzqX64HxdUmhztHzmfFViGArEeH2SOH9RdS9FEAYrLVOBihN6Hv4fGHh/6/AXUMlSGwBtUxjHS6iKVraSkw1Pwk6TgD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 13:40:16 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 13:40:16 +0000
Message-ID: <167689e0-2523-4682-8cba-574a20ace3d9@cherry.de>
Date: Thu, 15 May 2025 15:40:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20250515133035.815572-1-dario.binacchi@amarulasolutions.com>
 <20250515133035.815572-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515133035.815572-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: eca16b76-0e99-4c66-e639-08dd93b606f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Lzgrb0ZOMzAwUE82T0JtU1RxZWNmSnZGTCtXck54R2k2eUIzVER3ZGYzN1d0?=
 =?utf-8?B?S05GbEFtK253REVaTThnenhncFBiZkNPa205YnkvQVZNaUx1aGJEVTFPSElD?=
 =?utf-8?B?VVNiQ2J5ZHhiRjI5OEp4YkhERjhjUnlETVFQVTJ6emJ5M3VuVkU4ZWxUWjNV?=
 =?utf-8?B?VVk2aGZya1FKTGI5MzZ5dTljSjJkc0ZvNmNIVllqWnlXV21xRHJtUGVpUzRI?=
 =?utf-8?B?TmdRazFPeDlQZ1ZGRHpFOXdnODVBbE5RLzNUSzVJNm1taXJXUU5Wek5kTklE?=
 =?utf-8?B?RXJROWpzOVR6c0xsZThSWEpDemVRTVA2bWZpTVU2QW1UTWNESGNqcGdQOUZx?=
 =?utf-8?B?SGhheFE1ZkxLY3kxWG14V0pqclZFZllFMG1HOERWRFlLSkw3cDcyb3Z3ZWdY?=
 =?utf-8?B?S2tZcXlMVkxzRERhYWlTbi82aWpYUnVSRmxiSjlsbFZEWHI3ajFBejhKN1Vj?=
 =?utf-8?B?c2VBRkYxUXFQcEpUNlhJMTVuMjNVNk9vTzJxYWVoQWluYlJPWXJDQkx5MmpW?=
 =?utf-8?B?bm9ROUVSNlNPa1hhcXAxb2RFNVFMNWcwNEc4QnZGK3M3MXl5UHA3anJHTzZT?=
 =?utf-8?B?TXFBVjRXWnVYWWlKRXIrRk5iWUxQVHZYQ2lUTW8raEFqTUdrV2hiY3drN2dK?=
 =?utf-8?B?YWhBU0FMRjc5VURUQ2hSSGswRE1jZlRuWWJ0WC9pVDhwT1BvMGg3M2FEbzd0?=
 =?utf-8?B?aGN6b1B1V1NHeDR3QjdUaFpzcnh6cS9qbzlUejhqQ3AyN0YzSVd1UEVtUmsx?=
 =?utf-8?B?UUsrdDI3RVV1U09MZ24rbG5leW9Tb3hCQTBPTWt2Q01TNXNEcnJsL0JrUEJJ?=
 =?utf-8?B?b0hneFNSdlFVQWhzZnRLbU5NOU5XcE10VW5USmExSUNzUS9ValFrejNNVld1?=
 =?utf-8?B?cFpBNFJKUUFneElhbkdSREpPR0ExQUNlYlNXSWJHdmEvSHBaWEhVNkpkOTAx?=
 =?utf-8?B?NHJhTEtETUpKd2tnMVlwbStHdE14cFA0VEUvZXFhOHlNS01LVXJ5cmpJT0Ji?=
 =?utf-8?B?RjM4eEtraEYrNTFWL3N3NllWRVdRSm9neXFxcjFuQUFuWXVheVB6c21NNloz?=
 =?utf-8?B?aVpVMHBsNHpibkxvaFVqTndVTmZxSjYwZndnYUc0NWw0MHBJT0FRam9lNHRO?=
 =?utf-8?B?b2gwT0sydDBjRU5tSUNMR0lSM3NnRy9NRHdSQzZqdmYvM212WXA1ZkhqZml3?=
 =?utf-8?B?MU1BR0t6Umd2cHdqZWpDQUNNcXVTVE4rR2FzZStCL1ErNTlFaU5Zd0hnYkQr?=
 =?utf-8?B?eEVPWjM0SG94S0x0dDkwcW9XN0RGV2ZhcDdmNUljK1ZYUlcvcW5za1ZoWHdY?=
 =?utf-8?B?aWhKdlpFelR6VGJJOTJ0clBXL0dtbnZTcjNTaUcxM1BYOWpSeExKZmJ4N0xa?=
 =?utf-8?B?STk5MUUyTXlqeS9MZzM5NDl4UENIQm4xWldZQUJneHQ2MHB6KzArcGNjTXc2?=
 =?utf-8?B?aTNWME9xOHVaajRDNmxRNWJIQ2F5NXVHVmJOeGZnekxYY2pVOWN3T05SeC8z?=
 =?utf-8?B?NHJGL3dESkRGa0E4OEZhMVVPa3BjUHZ6aGMwS2tPWHN3ekVoUFVhVkhEOWtu?=
 =?utf-8?B?V080ekJiNkdzYkJ2b1M0ZzN4QnkwakxrbmRlQ0FiYmxZdmhkc3JGR3pLamlW?=
 =?utf-8?B?VWZ5V0dGdFZHVFNEUzVsNWJVaTVTNnpuWmVEZGhDSVB4bVNuZGp2dDJkeVQz?=
 =?utf-8?B?djAzWDVKK1lFKy9zVUhJNXJHVnV2M0QrRy95RDVRR0hDMXhXdjlnWWlxN0lW?=
 =?utf-8?B?cEpKRTRjZnZZRzBMZ0RpVDhJRE02N2tPeVphR2syMGtMUEJQYmJYeXJITUZa?=
 =?utf-8?B?dTYzZlFyL1RYNThJWldFZDlxNGowUkUyN0x1YVc4bVdYL3Rzb0R0QnAwNUJu?=
 =?utf-8?B?aXJjZTNwZUZqeHVtNUtrV3BpYVRLUk5ZRVFMaDFWdDJLMWFuOXhsVnJBY2lX?=
 =?utf-8?Q?zjeXZepZ07M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REt1WVU3WWVDSThiVjVSOG9Nd3NVTVRyWGNqamlwZENBanVxRy9IdHZQaWt5?=
 =?utf-8?B?MG9WSnpKLzlDb3ZwTFo3N2REbS80YTh6ZTRRanRzVEMyK0M2S2ppaDNkbWI3?=
 =?utf-8?B?RlIxQnYrT2JRUjZPS1NyM0FjcW5SbDJHdytTS0lzeW9QeUlGV3A0QWJIQlhL?=
 =?utf-8?B?aG1VTDVIck1uUVU1VTVmSndsZ1p2WXpWMmUrb2MwOGxrU0NKVnFYMjR1ZHBZ?=
 =?utf-8?B?akthQzFCZkY4OEh2ME5aMlBsUjVvdkxwUE01TU9pcGF3cTdKZ0xEWS9DL1F2?=
 =?utf-8?B?MHJtVXphdDkrVVlDeWVVVkZGTU8zREpyM1ZlTjZ3d3NaRC8vNVY5Q1JPRjVO?=
 =?utf-8?B?RDJMa1FOMkUySWhCTWhML2lnbkl5OGZUV0t4c2pNdEZLZDJ6OGMzbWdpKy9k?=
 =?utf-8?B?cTJhenZLY3AvRUJTOUNiWHM4TXFxSDM5Lzk2OFFaYkptVHV6bmQrYUt6ZTNV?=
 =?utf-8?B?SVQ1bWs3QURGbnJNbkV0SXZqQzI0b2RkTjRQZGVSaGZXSWVtUDhYdWVmWllP?=
 =?utf-8?B?bWgwZzZPdzErMnI5N1pOUnBPM1N5ZldOSVpmeEVaM0I2K29NN0J6RTg2c2VK?=
 =?utf-8?B?NlorWE1FQk5yNDZDTWcycG9hdkhPelZzU3RQb0NTZ1FHWXpWT3F1bmcrRWp5?=
 =?utf-8?B?bjUrSFY5T0cwYVhRZGh1OUxnUEdyNnZLbk1GTjdvaTN1bmdWd2JEUkVBcEha?=
 =?utf-8?B?R1dJa0h4RjZleHpmcEdSSnI1ekIxeEpsNEVoZG5ES3ZKM0RwY05oWXJuM2lI?=
 =?utf-8?B?Y2QwVjJ0RnhRbjhIUDhmbG9ma1FNWUNYYlluVTZZUkhhVHpmeUpZU1BUQUxt?=
 =?utf-8?B?RjlZa050U2EwS1pHMUdwNlh4VTdWTlBRd1MzMHFxNENCR1dGMmw2cWNYYUlh?=
 =?utf-8?B?K0l6RnZuV3VwL25vNEJ5RHFDZWJjSEU3dW43WElmdnE2eCtsSGNva2k2OGVL?=
 =?utf-8?B?T2hZcmNtU3g5TW1zSG5TdC8zUExTZHBKOTA3aTA1cW9iQ0VkcHZyZ1ZSNXJI?=
 =?utf-8?B?R0pMOXdXS2VmUDErcCtUcFlYV0hCKzY1NUl1RmhCVkhhbUk2anBqMExjUno0?=
 =?utf-8?B?cnNyU29uUkxHaU5KK0NRdi9kaC9wUDFJeG8walB1YjVHMmNQRlI4VHV5Zzll?=
 =?utf-8?B?TzdDczJMVmRsQml5Y3NmOWM3TFR2MU82OVNmdVZFbHUwamE2dTgwMS9jOHNl?=
 =?utf-8?B?N242SXhRd2pqWFVTZFlFSFc5eUphRmpIYVFab256R0YzWXcwY0xjU1BqNXN2?=
 =?utf-8?B?S0Z4RmZaOEFEMWQ0TmlsVjVMemRremJvNCtjbHRIMW1GK0s5YWFmbnRSaWVJ?=
 =?utf-8?B?cGVBR1A1emVzT2o4aGVhK3VWTTZISVBzZDk5Yzk3MzZISkpDRUVJeEhzN0Jv?=
 =?utf-8?B?aEd4UTFZWkREQVkxY0hRS1NyblZncUpiYnorMDc3U2dSWm5MV1NkVjAwRXJQ?=
 =?utf-8?B?RGJjbGFSamozK3MzR212L1JGcmRWS29IM1NwQjhhNWJsVmtnVzF2YnVzUWNM?=
 =?utf-8?B?WjQzUDNkT3RaamNzQUVZdE0veHJZTlByMDBOV0RZUXBvbEMrOVE3ZGtHdERO?=
 =?utf-8?B?eTRET2ljNUJ1SFkwRVVIcTNPeGl4djhKUDk4a3VhZ0dlMkhnREVDa2xnaWV3?=
 =?utf-8?B?OHJjUFBwWnIvQjF5Sm5WMVJ4c2R3ekgyeVkzQjNYQ0FuN2VaRjdvcVBiSnVF?=
 =?utf-8?B?aEFiajNVWklBbHBKOGFXREI5blY0MzJQQmlXcGExMGxtdkdRQVRRUWxrRVQ0?=
 =?utf-8?B?aHcxV3JTeUxKMGFvZ2lrLzU5Nm5vbTZjWUlIYUpLdlgvOFF1R3N6TG1WRXJE?=
 =?utf-8?B?dzhtd2RNU2VaVmJ4dytsYUgvUmsvWmRIVGNPSUdnRjFOYWZIaDM3MlFtQ3BX?=
 =?utf-8?B?VC9HSHBlMDhINFBoVTk0WktmZXpNUVd6ODBEQ2cwVEZPQTNJRzRhbUdHTzFv?=
 =?utf-8?B?MFFRRnFwYW5aSnFERUxuRzd1YVU5Rm9NK1I5Wk44TjRzbFZQSHhsNEJFbG5S?=
 =?utf-8?B?NXFlTTIrZVIwQVJwTndkNG90U0FlS3l1Y3JPM1lXN3pwbEwyMHEwemFVeGI4?=
 =?utf-8?B?ZCs1TXNkTmRBV2tHT3gzTmNPL0p5aWdIK0NFcGFzVTczeGxVT2dtMUljWGZO?=
 =?utf-8?B?akdBd002T1lSZzJZYkpVbXkvY0RHQ2NabndjZmZmRHFTVUxSMXhFM2hQYkVT?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eca16b76-0e99-4c66-e639-08dd93b606f1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:40:16.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUcUeu7QJwuLr7VbCaJayx2ggsAnB8XkpKVdV8/7Y5by3ggJSvrAVRABQ6gbjgClOb/UwCBc23QGzqOVJBHWHKUpUFacl3kaytqjJsMHgaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
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

Hi Dario,

On 5/15/25 3:30 PM, Dario Binacchi wrote:
> Standardize on using the IS_ENABLED macro.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v1)
> 
>   arch/arm/mach-imx/imx8m/soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index 806adcf145fa..6c53555d22bf 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
>   #endif
>   
>   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)

You can even do those two as well :)

and all the others in this file :) I would recommend to only do for 
those that start with CONFIG_ which are Kconfig symbols. E.g. 
PHYS_SDRAM_2_SIZE isn't, so I don't think you can use IS_ENABLED.

The easiest way to check everything is fine is to compile before and 
after patching the file and checking that the output is bit to bit 
identical (you may need to change the SOURCE_DATE_EPOCH to guarantee 
that though?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
