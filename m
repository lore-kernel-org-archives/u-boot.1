Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4876BCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8179383B5E;
	Tue, 11 Nov 2025 12:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JGobKyYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F0683B63; Tue, 11 Nov 2025 12:22:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77E283A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZUPt2mMFE0sE/Qa9heTb/7uPEDSt35pU0RSNpGhRmRTtg2SibCKmMzBtTDUw87U/oghdyzs9yNtBBSFVC+O230Lwo3DFLa1oZn6q1fNJlmmWAlXg5raRH0bpXfDhkawT4mDNZ4pX4q3Y7Xw11Qw/oDZk2jUiTgtCIeyK874eczuNylQGZknrCujzEyHVlHJN4d2nIK3ltSzNsvy0nS8QjMh87j1x1KsaLUGA1m7BOEDhHoDOnlaL8ewDr1uktVxUcZbAkBTHc2hFbl3/rzPVwNCDo1iubk1A2XbawSUVCWyRUsREV9PVlYF0sXmy0BbWbTEcemZv7DGwc1EbtFB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp9ctPx5G5jeQmpJUJiuGbJAzkGVvXQL8ooPwsUtFg4=;
 b=Xupe19EGht/qyXE5STaoQrwJyv23vIkXfCZM1W8NVIiZNo3DcDSYUYmP+26BYZpZuLS+G93SdLVAPWe1QdvfHoaIKwmrNF/VMdVsMRUOenls3XzGtON2TzymssTB3G+VW6KuMPAgK+ZvCy+EjZl+gKnXPN5+yfpgzdutD/M30vP0w/o/DMAcxPmX+CRKfYa5SMi0flSLvFMcmuJ4PVxup05ulwC33GHebHX1J4neg7eP3vVgsOJzWSyaJZfn2BElGyBOlDgq3tuC+M+N8ByKKRW9d7rfufeOpHubq01VFAdSQW95nEObB53O5xwMWemzd12kKJMqgxMMUZjjVKOPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp9ctPx5G5jeQmpJUJiuGbJAzkGVvXQL8ooPwsUtFg4=;
 b=JGobKyYXtRZiKKsy0+u2fYQSb0dVABmIt0c1smfU2eT4CDSrNhfuJODYI2DZrUAt+mqWc8Wqd5pQJqH3UEPRzRXSO9rU0b0CJ8CdGUI7aYX2TbwfHedxpNqsb7W36CUiOobGyyrzc010FV/QOarR5cVZi5UGbLLrwFEZCWnXG3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8282.eurprd04.prod.outlook.com (2603:10a6:10:24a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:22:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 11:22:35 +0000
Message-ID: <99660d82-6b18-453e-a693-6c02f5eb168f@cherry.de>
Date: Tue, 11 Nov 2025 12:22:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fit: allow signing with only an engine_id
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <DB9PR06MB851219BF2BFB0D28C7211A0CCBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DB9PR06MB851219BF2BFB0D28C7211A0CCBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ce92b1-2d5b-461c-5fc7-08de21149ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U29kK0pKcTVYeFRWckRaWnozck8vSS84b3VxSEsrQ1VnSjhxMUhGM0ZPUU9x?=
 =?utf-8?B?Y3pGMGZJYnl0U0ZNdGpLaEs0U3o4ZnE2NmtzNkhVaDBvRDBXenR5YWVuL3Rs?=
 =?utf-8?B?aVQ2U2c4VFM5R0trYTlaN2tRMm1yc0lMaUhmdXZFeEhycVl3d3dTajNoZFRk?=
 =?utf-8?B?SVhxN09HNFF1Y0lQMElpOGxxRU84ejBRbURaNGFYU3Q3dW5qeHhxQU5UWk1L?=
 =?utf-8?B?TTBLbDUvdkRSaUd2Rk5qNU9RU0RraXVFNTlMQ0w3eWtkeVFzd05DLytabk1C?=
 =?utf-8?B?aUVnR3JnSDZCWDRlQmgvSXloQ0prYjQ0bS9pZlkyRm9DQ0xhQzZRbUhUdVFC?=
 =?utf-8?B?WTUzdmhOaG1WYmQ0aFNtZVFMMzdqUFhtUHprUEtCZWdTb2FEaVVYWHRpWENo?=
 =?utf-8?B?czNteEx4L0wvQk1tZzMyNC9HVVJVSk9KM2t2RnlPMDFOMGQ5RVBuTmV1SkM0?=
 =?utf-8?B?SEt0Z0lCalg1dWQ1UTFJekNROUtGV2Nxa1g2dU1hcU9jSWsyL1krTDc3M2JM?=
 =?utf-8?B?S2JLTmFYWWl0VFpteHYvSTEzdWMrZ1hFNnBJSnBBSE5nN2NhZXhpU3FFZ2dE?=
 =?utf-8?B?VEpCblBPYm9KNytWYy9taEU2cEwxbnlCTTR2V3AybkFPQ2xxZEJPK2xrUmlG?=
 =?utf-8?B?WkdlVG9ZaFFNU3JZS0lUZnhnVjJVK2pSemxYcURaYi9BRXpJdk9sVUFXTS9C?=
 =?utf-8?B?QjNsTVhYRG1RdzJxNHhibkhFYXlyNlBZS2FPdnAraGJPQTlYYU9PQnRObUgy?=
 =?utf-8?B?dEx5b2ZNZGREMHdPZEJpdjhJK3M2VHdJRTJCZzI2a25neC9Wa1QvbG56RkFT?=
 =?utf-8?B?VlM5TWM5Q3VFUncxaU1sQnYxK2hVVjVGaFZnM2xSQlYxY0FseGE4aXFHcHZS?=
 =?utf-8?B?N1JiaEJMdUZjTGp4SmpXL1NBcUZNVnA4YWhUTFk3dkFlNGVtbGdiUCtSMXFJ?=
 =?utf-8?B?SjA0b0x3K0w4Y2F4YmpWQUsyQkxXVDZtRm9MWi9IWVAvVGtucU9tWVFYd05u?=
 =?utf-8?B?YTUyaVlmemJjWG1SZGYwWkpjZFIvdE9zSElWZjdKcW0rZFgwdHNTUXlKcUty?=
 =?utf-8?B?aEhNcFhVWGxWUjQ2VG5jTnQ1OEg2S3hhcCtreStweHJJRjd6WFA2SHp2aWlJ?=
 =?utf-8?B?US9oaHR6NjBOV1V4UjJoOG9uSDFuSnpBdmNnWjAxeG5JQ3FTdzV2R0ZOekg4?=
 =?utf-8?B?aTloaFhPellwbis1S0wyUmU4SllwVjc2d0o0dnVBVXRVL0sxTXl3UklXRUVQ?=
 =?utf-8?B?OEhOTnFzakYzZmN3eDlYUUJrWTNLVGxiVVIyVHZkNEFoT1dhT0s4eXM5Z1N1?=
 =?utf-8?B?N0VNQlJmMzBjY3B2Szd2OVdBZGpYZUw4SnJ1SEJZU2NmZ3dveDlxODZwT0d4?=
 =?utf-8?B?QUNTSlNuQ0Z2dDB0OTNXd1BCQmEzQzdMNlg5VEVsME1OQVZrSGV3dWJVeUdN?=
 =?utf-8?B?cU9RQ0ZIQVFTNjhOUFRJY3JhMUVHUEl0WGNDZ1llZ0xiV1ErQUttZWRQKzBs?=
 =?utf-8?B?TGNZVUt4eTJMQ1FWVFUweHd2Z2ZEZ2hFeDgyZUZtSlJleWFucTZydjFwUUpQ?=
 =?utf-8?B?ellLdHE3RzREM0hZMmdvSUhYQXdoREUzUnVPRWpReGgzWkdwS0ltZkdMNnFG?=
 =?utf-8?B?M3U1MzFpcnVMRm5FUlgvbW12dmU2b2JvVzRiNWlEbmZHMjVLWmMrVGZBUGVL?=
 =?utf-8?B?QTVxejk3SzU5dGRCczlFdlRGM3d2MHphV1IrbzBQUktCNnhNZUJoY2FHNzRX?=
 =?utf-8?B?ck1ncXc3VFV6d2cwVzJBVGoydFdGL05OZU42aGtid3JYbzZFYnp1OWROVVYr?=
 =?utf-8?B?T29lb1gvekJ5ZDUvdHZzUzY3NWJkM2IxK0RmTSs3SUwvbnBMRkVQTXd1bTd0?=
 =?utf-8?B?WWF2dWlubGxuRVJjemtQOWYzK1ZOeWlBM1ZRdnUzbzY4UHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2Zxb0NPcTV1ODduRWFBQktsUUtZcE9xT09sTmNCdUdSazltemV2N0doNmRs?=
 =?utf-8?B?c1ZaWnJxeVFvN1hNdE1rOUc0dTgvRkVGaWhhbm8wVUVjUi9waUJrcklxS0I0?=
 =?utf-8?B?TG9yQlBERzVFVTY4cXdKMnZZWkZ3R09sS3NDQ0xBVGlhSE1EZFBxWEU2QkN6?=
 =?utf-8?B?c1VjQmMzQy9QSFdvbGRQdGtqeFJjSTVCYVErM3Bra004YitBUUVNL2Ztc3M3?=
 =?utf-8?B?SlNIQ3NuL21JdkZNVjYyNTFEZ0FPZVJrTkh5WFZkZU9mbFA2NUZBbVNlOVlL?=
 =?utf-8?B?QVgxZXBrRXU5K3VRYmtjMHZsbGdsUjlMaGQ3RkxYeEJiMnRKZ0drUjA3VFFV?=
 =?utf-8?B?ODFRbTJsZXQrZXZEdFVNNW5FK0FLd1Q3WjJtYkNxL0NwS21tako0d2xybmVT?=
 =?utf-8?B?MW9qbVlvKzVEY1ZrVlYrcnR4M2FQRFlZckRGd24xU2llU1F6ekt2b1pOTXlr?=
 =?utf-8?B?RVBUMDVZMUJVclpJV2R2OUNBUVJSQ2ZrM2JLVkdZRHpTbTRRRHl1SWlCSndM?=
 =?utf-8?B?SU54aWZMcUtPSG1UVEgwQktpOHRxaTVOeHltWmRFaFg4NXBZNXRMZkZIN0RJ?=
 =?utf-8?B?cXk2MExwV2FhTmcwbStya2tzbzgyMzR6VXBhNVpHMU93L1pTOG41UGk1VmQx?=
 =?utf-8?B?Sk9tTFJjYXFscVBrR1JmV0dQVjc5dXVrVVRqRWxacFN1VkdQOGQwbnV4QmpP?=
 =?utf-8?B?NTZybEZSK2psK3NyOEpXMDBtN3BycDIrcmRSekFMakVxZmM0clNySkhWUXNV?=
 =?utf-8?B?RiszZE1oYVNzS3hLdHliNnVxRXNtQ2x1d05kMno2UUxhNG40SW5YaEVtajlv?=
 =?utf-8?B?TXVpemtPV09HWFQ3bVhpZ3d1eXBBb0ZyNDJUbE5CZ2Vpd2g2b2hnR3NOWGJR?=
 =?utf-8?B?UVBwQkNkVWZlMmZXWTIydGFwOGtobGwvR0ZWZk9lSklvcGpvVlprQmtqcE5w?=
 =?utf-8?B?REZKTlJHSHM3OVJ1clVUdzhqMWZibHhJd2FuMk9oTkhBR3ZrQjhZc3VubDlL?=
 =?utf-8?B?bjFRWlN2WEhrbXJMRGRkdzAwUWtQUHFhQllUcTV5REVOQVVnVzY0bU9iN1Q3?=
 =?utf-8?B?amE4YlZBN2xWSGlFWVNLbmo3NEd5NU5xOVR1MXdqNzV1K1pnYnJkUnBSby84?=
 =?utf-8?B?NTBTcXBSYlNsTVhpRTdQU1hOaGY3WGJyaHhHblg4a3RPN081bmlITjVUbHRN?=
 =?utf-8?B?eFhOZXRveG0vamJaK3pIOUwxVDF0MUduMTBGRGNXVGkvdExNeXArR0xNVDJm?=
 =?utf-8?B?eWtkeEJTYUhoclZlWTAyalIzUE4wUUZia3NOdWxiaGdFWUFRVnhhUWdQS3V4?=
 =?utf-8?B?cEdjS3RGamFSTVQvTktRdmw1UUFuam5YK1hRTWtPcnpWU0s5bFBzQ3NZbTAz?=
 =?utf-8?B?eXZZQURNQUU3Wm1PTmhPdklhU3F1Z3Q5NC9TWE1FdEhkdXJpMTFCVnZ1ZkRz?=
 =?utf-8?B?a25yd3hxb1RGQWJzMFdXYjBaRVpUQUkwM3FpU0l6RXpXblVMMkZIUHRWdFJR?=
 =?utf-8?B?SVkyVk1GeWlSelkzMU5YWlkwV2EreC9kQ1VEbjJXSjNkZEptVVlCamtOZExS?=
 =?utf-8?B?aWpoeHBVdFlUc0trQ0Y4QjhsRDJyM2t3ODRKcGdRckQ4ZmJLV1h4ZFdIc3FJ?=
 =?utf-8?B?YU05Mi9hajdUZmpEZmpHbWdPQVc0c2lzVzc4R2JZeGwvTnZCeCsxcWpQbVF0?=
 =?utf-8?B?SUZXbUtlREFkOVF6NjA2UGl6OGo0QTNlWmJSRktvYnd3UU8ydE9hd3B2SFpM?=
 =?utf-8?B?VUQ3T0FYZC9aN3VUaVg0MDZKMTUyMTJibExiTmpMRHdzS1RjM2ZuUFQydVlu?=
 =?utf-8?B?WTZ0MUY4dVduV201eDJNUzhESkpoaGM0SGVEZVk4eVVYQndvanlQWGFORGkx?=
 =?utf-8?B?Wmlobk5BOWlUSlprTEZURmxBZVBIL3dsOGxWUmhnRGxwTnJ6YjZvR1h6d05N?=
 =?utf-8?B?RFJYV3kzbEExRmxYdW9ZNjg1a2ZsY2ZyYXdKUktsdGRrd0VncXZnVm5RdkVl?=
 =?utf-8?B?Vmx4WkRmM1JMTW1BZXVRQitLYUswRkN4TTFnd01GL1FndE5NL1YrdEI0djRE?=
 =?utf-8?B?Y0VMM3lBMnpZa2RYck9oUm1zTmRSNXJ0NFJlTFAwL2w5WDNQUS9pczlnZG5M?=
 =?utf-8?B?NG40UnhkR2dJQWFuQmhReWgzY0JnSmw0Mk8zTENuTWlmSXRGSW44NlZWSjFG?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ce92b1-2d5b-461c-5fc7-08de21149ced
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:22:35.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pibtlhyp76bLrKA9LRJOExTow/YskYs4XK9GIQZka/2kqUh7vdshgWPID508sgQ/KlxgpujGrtAOjMJmyY9NUj7Ig0yO32mnQttkAnJASSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282
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

Hi Wolfgang,

On 11/11/25 11:10 AM, Wolfgang Wallner wrote:
> Hi Quentin,
> 
>> This series allows to sign a FIT image with mkimage (and binman) with
>> only an OpenSSL engine and no key-dir. mkimage will read the
>> key-name-hint property and pass that verbatim to the OpenSSL engine API
>> via the key_id argument.
> 
> Thanks for implementing this!
> I was already looking for a way to implement this myself when I saw your
> implementation on the mailing list.
> 
> I have tested your patch series in our environment with our PKI provider.
> Our PKI provider supports the OpenSSL engine API with a PKCS#11 library.
> 
> Signing and verification with your patch series works fine in our use case.
> 
> I only stumbled over a small issue, but that has nothing to with your patch
> series:
> Initially I used the same key-name-hint in the FIT description for
> U-Boot proper (which is then used by mkimage for signing) and in the
> description for U-Boot SPL (within an u-boot-spl-pubkey-dtb entry).
> In my case key-name-hint contains a colon and several equation signs, it looks
> something like this:
> 
>      key-name-hint = "pkcs11:model=xxx;manufacturer=xxx;serial=1234;token=xxx;id=xxx;object=xxx";
> 
> But when I do this, I cannot decompile the final SPL devicetree any more.
> Decompiling with dtc gives me a "Bad character '=' in node name" error then.

The issue is probably that we use the key-name-hint for the key node in 
SPL DTB, c.f. 
https://elixir.bootlin.com/u-boot/v2025.10/source/lib/rsa/rsa-sign.c#L677

We could sanitize the keyname to make sure it's an appropriate name for 
a DT node. According to the standard, allowed characters are

[0-9][a-z][A-Z],._+-

and the node name shall start with a letter. We could iterate over the 
string and replace any unsupported character.

We shall do the same for when we try to find this key node, 
https://elixir.bootlin.com/u-boot/v2025.10/source/boot/image-fit-sig.c#L87 
and/or 
https://elixir.bootlin.com/u-boot/v2025.10/source/lib/rsa/rsa-verify.c#L538.

> As a workaround, I use a different key-name-hint in the SPL description now.
> But as mentioned above, this is just something I found while testing your
> patches, nothing caused by them.
> 

Can you show us a snippet of how this looks like? Because as far as I 
could tell, the key-name-hint in the SPL pubkey DTB must match the 
key-name-hint used for each signature node in the U-Boot proper FIT 
image. But I assume the key-name-hint for you is used to pass parameters 
to the engine, so you cannot really NOT have it named this way?

Maybe we should split the double meaning of key-name-hint which is both 
for identifying the signature to use and how to sign into two separate 
properties.

> This series is useful for us, and I'm happy to assist with further testing and
> review. I'm not sure if I can help with creating tests, but I will have a look
> at the things Simon listed.
> 

I'll look into mocking the calls to mkimage for testing the binman part 
correctly calls mkimage but I think we should also think about adding 
test for (engine) signing with mkimage (and maybe even verify that the 
generated images work with sandbox for example).

I would also very much like to have a way to sign Rockchip images with 
the default binman instructions in rockchip-u-boot.dtsi, but this is 
currently not possible for multiple reasons.

1) we misuse/abuse SPL_FIT_SIGNATURE without an actual signature/pubkey, 
only for verifying hashes. We should sign the image and add the pubkey 
if SPL_FIT_SIGNATURE is enabled, and fail if it cannot find a key, but 
we cannot do that because it would break current users. We would need to 
split the "check hash" from "verify hash with signature" functionality 
behind another Kconfig symbol for that. I don't think it cannot be done, 
but we need to be careful to avoid forgetting about checking hashes when 
signature is enabled.

2) Make most of the signing configurable through environment variables. 
key-name-hint, whether to use an engine and if so which one, the 
checksum algorithm in algo property, the crypto used (RSA/ECDSA) and its 
key size or whatever other parameter passed to the algo property, the 
padding type (PSS/PKCS) and salt length. I believe we shouldn't make 
those part of the hardcoded binman configuration in DT or from defconfig 
because there is no reason to patch the tree (DT or defconfig) to change 
signatures for essentially the same binaries. We could have environment 
variables used in the binman node in DT though (but for that to work, we 
need to pass environment variables to dtc via flags, or create Kconfig 
symbols generated from env variables). This means many environment 
variables to document and test. Not sure the project wants to go that 
direction though. I would also want this to be something followed by all 
architectures, not simply Rockchip, otherwise enabling SPL_FIT_SIGNATURE 
simply isn't doing what it says it's doing (I can boot unsigned images 
without any issue from current master, which kinda breaks what 
SPL_FIT_SIGNATURE seems to be hinting at "Enable signature verification 
of FIT firmware within SPL").

I'm planning on sending a mail in the next few weeks to ask what would 
be acceptable for 2) but I am not sure this will go anywhere to be honest.
I think implementing a new feature for checking hashes without signing 
(1)) makes sense and is unrelated to/not a blocker for 2).

Cheers,
Quentin
