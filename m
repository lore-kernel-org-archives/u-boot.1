Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF4D729E1
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 14:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82CE89165;
	Fri, 29 Nov 2024 15:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XbGxzExl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8D48919F; Fri, 29 Nov 2024 15:56:34 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D354A8914F
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 15:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAgt82jiwrVRQL4BSBnUllsFmY3DvHF1DrPD7AZRaBfCXr/g3HLOmm4tSkw5c46Xp8UgWP6mnvPhJHwavFNqlgIvexwn1uAlxd5x96PF9nqLRDkNKPdZcpBlbHrMCRMDzYaBEQTTYyj3O8GFwa8PVUMt8zTXv1zKr9SF4uBb0GRdpiXfotvihDde7cilhRpdOXG/ygqs2d7S8h/9CV9xDk+gZ+eJUNuJ54QzJL2U4Vzg+Z1f+PVgCtLkGoQpaxAWP+/vpE6Br6pYZKnGNMWAFoSW1rlYPd8bpiAFNPcA8z7SgVXCA0i2jl3UyrlBU32WMvLsO1hqFkeE1hYHKIHaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgLvbl4mn6V/hTpjEZi9x6IaiA+kS00pfjAZLp71hnM=;
 b=DNLoYGn8yqNG4f8gYtXF0vcIa+iRsar8Zbq1j1OxUEOQeNM31C2mZ59/SD3FrG0E/gQs/KOyUuQpBagzRVtEHZAzDTXta5rwVxWKC06SVpl34jdONW/EDV3oacVzL9n39epg3Gg5Xg+HhsZFf2Pp/OVTNqc9Jt6v8bSzpwqfDgxoA74ViFD69RRi9LYZOR4EXYL5gNSD3TdufBU+Bk0Q0n66FMXbO3uGrDM+syDE7bwwuFB2zYzzyi2BLWUnBVJ7+Km9/aoo8RLtTU/EDna25P/l/FkpB6Qk5lRSBNblsbN3edMBxKOKB/8vhvBgQjGDjWlQCzybeFGChDsaGzyhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgLvbl4mn6V/hTpjEZi9x6IaiA+kS00pfjAZLp71hnM=;
 b=XbGxzExlTY6XwLy7+TBarYcvn65C3x2S7YFV6CBFMZ5LAI/Bhku+R9pEpRFWsoXPzZUv8YOayxJDrNm4XwmzAdiLLNV/HAKse2kT6qoxcqlnyptrT6dEmtrOgYKgyBZqq/jZ+kxQMVlSAEJKU5uG2SwxNnD2e+P/YhwTPgFqBP2TGtM44szkkeAgobm7l77WbcgHYCxAJPZBCxvD3EAKQ0NUFa/O1nF23nqmzFJx/pM106v2OvSzc6FdubpfFVUcKNP8jBCMhvDzOTMmyWHz3J4wh9lJdSaoTM1b64ZnnIdcXKDZrgNncFG4aINPUaNuIf4PjlDjqxoBLp6DpcJnSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7337.eurprd08.prod.outlook.com (2603:10a6:20b:444::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 14:56:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:56:29 +0000
Message-ID: <38bcf7ee-3450-4296-bdd6-f1205a803252@iopsys.eu>
Date: Fri, 29 Nov 2024 17:56:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftpput: reset timeout_count when an ACK is received
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20241129144733.779043-1-jerome.forissier@linaro.org>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241129144733.779043-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:803:14::45) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: ec21c094-f363-4e61-41cc-08dd10860135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWN6aDNFWDFCbkovMlRFUVVMczdmanFYbkdyZXVyaVkxcmdSbXFMOWs3a2Ro?=
 =?utf-8?B?SXIwR0xJRlFoQzJ1REtRTlg5K0prR3Y5bkRPTitzQmc1dXpRM1RpMUFlQ29B?=
 =?utf-8?B?bUFQQ2ZXL21sbTZ4UzJmZVVrenNJMVN5bXYwMURNQ1VrY3h0eTlJemFHMWc5?=
 =?utf-8?B?Zlg2MUhWaE1DclU5ZE5aZkdncUx0ZmNQNFB6WFRTVWlXVVNPTHFicVhMRWhv?=
 =?utf-8?B?c2VWV2c5Yy9JRmFuTkFEemVLQUxmdEd3blVkSE9wS0Z1ZmxTa1NqaXBuU3Vi?=
 =?utf-8?B?MVgyL0F2c3F6RGU5V282c3pCUThNbjRrM0x5OEY5K1NRVkpBbHVnQzBweVNv?=
 =?utf-8?B?R1AwSElLZlFiMW54c2x3SDgrR1pGdkhGMkFjWkorTzEzNy90ek14dFlOTnpR?=
 =?utf-8?B?Vk1saU1XZVM3S3lDUGhmNE5KSVd5S05vWHRLU09SVDA3eDF5aDdkNExlQlNE?=
 =?utf-8?B?K0w0Tlk3M2E5aTU5dmpzVzJVYWJWd2czcmQ0TnhkN05VREdNNUY4TlA3VktX?=
 =?utf-8?B?eUprTUd5YkIvd29oZUFJb1pIdDhpQlA4WEI1MzRxVUJsb1hja1hyVk1jTG5J?=
 =?utf-8?B?MTc2YWxuRHIwRE1LSzJuOTY3Mnk4S2FNWTIwL3pFcGZ4a1BGMTVjUG9rejla?=
 =?utf-8?B?eVVFME9WdHFrbk1taHowbVRSYjdDNHM0TFRMb3VhYWVoanc1eEQrVTdBd3Vu?=
 =?utf-8?B?OWtBKy9RV3hZaTlPU1llcHgxUjhsQVRQbjRpaUhzSy9KMmRKT0g2ak5haHhU?=
 =?utf-8?B?bXc1NDR5UnoyS0YvNy8rdEFwY2xoUWRKQ3BuWjA4QkZRM2VFc3ZYYVQvdThT?=
 =?utf-8?B?cStoK3hsOWtpTkpuWDhSa3hJczAvcFZaaElXZDAxSldNQW14dWRIZlNWZm1P?=
 =?utf-8?B?Y3d4WFBqaXVEWEJjRUh4ZEd0bzVlNWpOVGZCVDNML1hvMzlOQWFwaW04cXg1?=
 =?utf-8?B?Vlp6QXFxRFQ5c000N0pHc2ZsaDk0ODNoN0hZZHdBZWFGcEhRZUlTY1Z5TkND?=
 =?utf-8?B?bTNVTWZVVzFnektuV2ZZRHgzekNWakZ3VDY2dmh5WFN6SzUvdlNZWnA1M0sz?=
 =?utf-8?B?NkZaYVdMZ3ZqN3RVbTBISkZZeFhtRUtoazQxWmN2UGZpRis5eURNTWUyazNG?=
 =?utf-8?B?azRGZ3NMYU9QNC9TUWRjdE00bGlMY3BUcy8xazlOMkowYk5SVXdBeFcvS29J?=
 =?utf-8?B?QWdJWURXTElHd2s1Q2QzaXZySDREc21LZko2SHR2eG5rYlRxMzRqWklpazdV?=
 =?utf-8?B?dWdXTXo4L0NJREpsb1RMLzFaNzd1QmJMejhyd21xV1VWVVMwSG8xRTM0bmpm?=
 =?utf-8?B?NEhkMjkrK0xNYlgvcHpvK09BTlRUOEpkdFd4aUlqdVJtd052K3pWM21yejlG?=
 =?utf-8?B?c2o5eVRDRjZYWFl1bWRuQmsxRGF4TGRwaXZpUEVOQnFpVUlWOU1QcGRmNzFi?=
 =?utf-8?B?eEtmdHY2Q3FsWTNYOWpLUFFaZUpiUDFQRGkrbkZWeEVqNE5BcDJ6UDFYbENL?=
 =?utf-8?B?SjU1dmJvQURkWXBVMHl2amJXRnJ4WEtEWXVvNlhhL29zeTJLWWpKTHIrZjFm?=
 =?utf-8?B?Qy80Q0wyL2loVkJSYVZXVXNiY2dLMDVsbDlYUWYvbnFsdURrLzBkb2d6bldl?=
 =?utf-8?B?eU5qcHlTUStwV3ZTOFU3ZVhjQ1BXby8rSWIxYXB4SVdVbnJhQjd5Y3p6U3lk?=
 =?utf-8?B?bEl1czkrZGJqNURZUDVQcnp6OUp2R1NqVW1LSG0vcFV2QURzd1dha3F5cWhv?=
 =?utf-8?B?ZHNvbm90Zi91TERXNHU1UjBpN1Ard2ZEcytNR0RIQUtPQ1MyN1gwRG9YMjRB?=
 =?utf-8?B?Rmk4VEtNTVI0eldaQWxvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFsYlRVRUxmdHZaT05wakZ6SmZrdEZDL3BYTytqUzNmdEk1cnduK3hTU2lN?=
 =?utf-8?B?V3N6Mm0vaFZVUlJzdTBwUVZEaVMvZWZURE4vbG9vakdaNXQ1Qzc3UW02eUpR?=
 =?utf-8?B?TUQwMlY1dWo4NmdBS0NHM050UTBwT0l3bktFSXFUUkJsT3BvOXBDS3dwdVlZ?=
 =?utf-8?B?Nk9pWmxDTGhRa3RhR09QdGJPbkFtbWhDaFVrdXAreStIKys5bzlUOUtZc25q?=
 =?utf-8?B?YjB1NmVNOVErdmNHNEtsLzNIUHZZeGUxeWRsZStoQWcxR0l6cHFneVNLRVpW?=
 =?utf-8?B?NHo3NFBpK1BESFBMQ1dEQUdtTUlzWmYzY3czYVdVQUFacit0Smt3TEtPU0Fv?=
 =?utf-8?B?Tk9XaWJMK3pjYmh5VC9JTFFpRlF1aXpsczZOZVIxYVd1aHN2TmU5WVNRa1R4?=
 =?utf-8?B?QU55TFFUaDlwbnNiYUJPT2l2RjdtZlhvc2JUQWx3M0wxcDRldmh3VlY4Q0ZV?=
 =?utf-8?B?L0x5NEdZcEQzY3UvMmhVS29Qell5L05oMUJpb2VoaHhPeWlOaUxWZUNrTFVp?=
 =?utf-8?B?cTBPdXQ4ekxJSHMwcXFVYUJkUmw4N2ttOXcvNVpyL0p5T245bG94ZGxHQ1lo?=
 =?utf-8?B?VlZHNVU2SEw1ZWR2QnVhUzhNb1JZcmVKYi9mVnlub0RqU2tDUEMzZ0NTVFE0?=
 =?utf-8?B?RkZ6MmtrR2d2RytRdG9qS2o2bnYxcWhCUlBVMWIzRHZ2YWw0L2ZJNTBPanhk?=
 =?utf-8?B?U3F5RitDTTY3WkNqSnFJaDN1bHdKRDE0Yk9BT29ycUZLTDFTWjdic1E4NU4v?=
 =?utf-8?B?QS80YmtxZks2K1B0RGowb3FtV2NXdnRBYmxGenJRNzZSdmxrcXE2YmVtSW04?=
 =?utf-8?B?SGY4SHhlMUs0R2NUZWk0a2hMQ0tQUENWaHJxdjVQYnEvRFgvcmV6cVd6RHY4?=
 =?utf-8?B?aG5SejdqQ05OUDBzTEswOVJaMWE3bDJUM1JUQnRobUdJYlBGL3RoczFKQUZC?=
 =?utf-8?B?ZEJSOEJRd1pmN0VwMXQzUEdvZmVRbE1Oa2VCd3NtVmZCNFNGRStmL0REeXpN?=
 =?utf-8?B?cU1BM1A1OXBUd2hVQVFhTXVOZDZ0ZW1zOFlHOTUzZ245UUx5MDRqaHc5NVI4?=
 =?utf-8?B?MTR2c3h2VEhpMGdOYmhEWGdQbkRBRENSVE0xMFpmajlPcTRBNjlwQVJoVllJ?=
 =?utf-8?B?SUFZMmhoZmV2YlZ0TEo3RmJRelFJTVl1dWpVdTRQT2xkaXE5LzlqTzBzR2lk?=
 =?utf-8?B?Z3NObTFKcDB5bG1OMkZ1QTdvMGdnRmVUZlREd2RZQWNqdVNzd1BFZytZdkcz?=
 =?utf-8?B?OEpuWkdSSDg5a0lIbXJkTUUwU1NyYW9IYkxUNDJqY016Qi8rOExQV1hRbzFa?=
 =?utf-8?B?L1RtRU1sZlNzRkVGR1F3UkRqclpGOWg3YXZwY3IyN08ya293ZmU4VkI2b0ZU?=
 =?utf-8?B?ei9UL2g0OHRMNVkyTEJpN3dtZmFNdjBEaTZPQ0NDYkgxRnRVTEdzL1hNVmY0?=
 =?utf-8?B?S1FwSkN4aXEvL0Y2VkdZcmpxY3Fpcy9zTE5XdUgyNmxGTzFPT2ZYVW5wK1pq?=
 =?utf-8?B?LzR2cFlvdjExZDN1V0VZMzA3MkFFaW9HVlJiYVBlRGR5U1IwbUpCMVNvZlhp?=
 =?utf-8?B?YlpmVlFQb09FdkE0THpMNzlsZjFDUHVTUlRZVnl3SFR5amhLQnFrVEoxbFFo?=
 =?utf-8?B?dkh1MkZuRitGTGZmS2UzRVpiNFlNYlp2dUhManJhSlpKM2k4L1VVc2xONE0y?=
 =?utf-8?B?bjY2VFBwZTRkcmd1SGlxaFRTM0w3Q0dsT0hFTXo3NStoRTdnOFV1dzNiRWlm?=
 =?utf-8?B?WlVGaXZlVUZ1VEljMU5adE83a2l6S0p4dXp5S2FFdEkvcmNxM1oxbEpMdzU5?=
 =?utf-8?B?U2wxckE5SGJSWHJWUndGM0VvdDBWYkc2Si9oRFFpa29hYjg0UWhoVStIdFdX?=
 =?utf-8?B?Ni85aTBxclZhL202UWgwT3RoRDFhVG5URGNEVFV1dFQxTmFsYTJnT0xEZkRV?=
 =?utf-8?B?a2xSRG1temNueEY4V1RLK1pBUHNjaFQ3N1k5OXIvRndaZnNVY1NERHpIbGQ4?=
 =?utf-8?B?WGYrMlFGeUE4S0NnYytYWkx3ckVUN1RoaU9tM3pHdE1aay85K2FCdzAvb2xW?=
 =?utf-8?B?VElRdlhEWkRVbytPdlJGeDlDK2ZoU1U4ZEU4dmR6Zk9JamROS1lVYmRwckg0?=
 =?utf-8?B?OVBxRi9pVVo2eXN4S2l3cVA4cjgxVm9oamh5U1RDeUE0bzl2Nko0MzBtV3Fp?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21c094-f363-4e61-41cc-08dd10860135
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:56:29.0179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5Uc8HI4Q6RTZB1XwgBpzdyUzjS84MdeMwZCbYS5FgS6/7hdGgdEoMO/APECA2dlO7Wy5amu0am5Ze5IuJ0KrQ55BJglWAlyFYOVfhF+RD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7337
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

actually there is the same issue with tftpget
The following patch fix it

From 2da22fc1fc2601e5b80c742c503177ca235157f8 Mon Sep 17 00:00:00 2001
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Date: Sun, 29 May 2022 19:48:55 +0300
Subject: [PATCH] feature: net/tftp: clear timeout on every successfull block

This patch makes TFTP files loading much more reliable.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 704b20b4ff8..8f948204a6f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -498,6 +498,7 @@ static void tftp_handler(uchar *pkt, unsigned dest,
struct in_addr sip,
                         tftp_state = STATE_DATA;
                         tftp_remote_port = src;
                     }
+                    timeout_count = 0;
                     tftp_send(); /* Send next data block */
                 }
             }
@@ -657,6 +658,7 @@ static void tftp_handler(uchar *pkt, unsigned dest,
struct in_addr sip,
             net_set_state(NETLOOP_FAIL);
             break;
         }
+        timeout_count = 0;
 
         if (len < tftp_block_size) {
             tftp_send();
-- 
2.45.2



On 29.11.2024 17:47, Jerome Forissier wrote:
> timeout_count is never reset once a tftpput transfer has started. If for
> whatever reason timeouts occur frequently, but the server keeps replying
> nonetheless, the transfer may be needlessly aborted.
>
> Reset timer_count on reception of an ACK to avoid this situation.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/tftp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 704b20b4ff8..8d54a83d9c2 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -478,6 +478,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  	case TFTP_ACK:
>  #ifdef CONFIG_CMD_TFTPPUT
>  		if (tftp_put_active) {
> +			timeout_count = 0;
>  			if (tftp_put_final_block_sent) {
>  				tftp_complete();
>  			} else {
