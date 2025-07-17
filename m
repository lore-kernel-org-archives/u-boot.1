Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4820C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 15:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FF8833F8;
	Thu, 17 Jul 2025 17:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IF6UNyGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0C88340C; Thu, 17 Jul 2025 17:19:44 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2417833EC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 17:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmjJ15DGIX3ChVHbqIkSQGYGGwNBSdwJxtgHBtWeEAErLQu4g66WYLM4it1PecZXNI1Sn88tgWZQJ7bg9MqBluIqoftWRBh8ZlWjM7CM2vHpuLY0mRpcJnlxoJYMBhneM+GWtomesVAwV/uPkV7mDnUhQARVmjSTTugvWfnrFY7EnddmXsvBoDRTirLB/BZXh7POIR5Xf2f0ZsuBGc2ULhL8Rx/W8dDEw1rnf59RDMpQBTyiQJMqw5r2ECwGZF42qjq4XciaZwRlbJIDd5XeR2+d/YmgD9umCt/gsUh/6t5tGB77haoEtVx9iPtH7xfsnzkMerIkjPP0lFM2zlPITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNhfRJu2tadAgN8PSl47wEjOSH1+IyovfMEMyAMBKI0=;
 b=UJkWbfnj+aZHeowPZpwi5jZK5sbeKod3ys7D1i47h9xb7XwFekDyD2ndfP2lQKyAN2cwf/rPCoKCSuGvQAtvVa1ZWiDdcP81EIuAqBdWXOlaNh/9wIbuTOb84zZp5y11DXVLuSCILvm7G9NKjGE4+b8Wc7KqXmRp61ST6Hj4O8O72V3GXHcpwHTd71rRUUJM9eTDpNUGGRByltJLmQJ2ZmcYPq9xj6KotWhOsqZzO5MBL5CAsteNyvPqk+IMof6He8yyaKm/uel2bGDdVPPjCESCRTKkT4H0t7b2pOC+fbmyPZchDClRlQEFArTey8H1JiglfHPpjSsVTghit2wZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNhfRJu2tadAgN8PSl47wEjOSH1+IyovfMEMyAMBKI0=;
 b=IF6UNyGqIS7e3iHBUb+ky9/uCM5BEnuwX4eFQJ3Cpb2iePTFLZAcYB0Vrtgdy/dQuF+l7CqX5jcI0uClD1PJOkM+FR7vDV8oq4NnFaZUiPOIMr+PRcGLEvp0mmCA23QdhgXkalLyTrcs+e/ybc9vIKK9N+2gkEhEvqcvs/gSxMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:19:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:19:40 +0000
Message-ID: <3eb8df7f-632f-464b-bf44-b05678bd22e2@cherry.de>
Date: Thu, 17 Jul 2025 17:19:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for
 addresses
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20250702010535.19250-1-trini@konsulko.com>
 <20250702010535.19250-2-trini@konsulko.com>
 <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
 <20250717150827.GN193579@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250717150827.GN193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: efe1de32-56f5-42e5-a9f6-08ddc545594e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFBsdnRKb2JLY2xjZ1FCR3I3K3ZmZ0xnUnZyWnBPbDZ5NUxqR2hTM3Y2YUVt?=
 =?utf-8?B?Q25yNHkvckMzRHVWVnRNQWc3K1dscmh4MTVpVmdJR3NiL0F0aWcwQ21IeFdX?=
 =?utf-8?B?ZUxnMTRnSHdOSU1BT2lYV3FyR01kOFNBMnpjWFhjOWloSm54bFgzNzdETkE5?=
 =?utf-8?B?cHhsVEFSM0xhU0Z2M2NGNWlVYkRWMXJ5QTFjWFlXWUsrazdiQ0xwdWxHek0w?=
 =?utf-8?B?MnJTN211Ky9nZWxLOGNZbTQzM2NVVUc0V3V0Qm4xaDAwWHhJdXhLdkZZVGw1?=
 =?utf-8?B?ZXE2b3Z3dHY1cUxYbm5pWFFEUW1jemtidGZ6ejZSQStBYWtlWlNqR2tnVk9E?=
 =?utf-8?B?OERCSFZxNWExZlNiSUZ4TFVFZnlTVmlqTER2d1dKUzZhSUZ0VmE4bnZneWVs?=
 =?utf-8?B?RWtudVhqcDJRY3AwQWJPanBmSFg2YnRuVXlIVHh2cHNLUWFWLy9nRHd2REVp?=
 =?utf-8?B?VzhrNUdHMWtoRDJDc0h2cVFhVE9FditBSHV6VFBzcXNjeVNWMFAra3Z4NGZq?=
 =?utf-8?B?UDFQNjhtS0xnUm1jOFB2bHlwRUxyb3lIZXVTWDVhd1prOVdUUlE2d0hFRU1S?=
 =?utf-8?B?SGJlOVRUcEtReEZvZDY3dWpuc1RTWGV1RU8reGhwY2VOSGY2TFJqbUd3d2I0?=
 =?utf-8?B?QnNranRvb0tYaWZxR0NJR1VibXM2R3FnZVJGcFZVT01QSzJsZGdrZkhVNUc2?=
 =?utf-8?B?TFA5QVQyeS9seTNKWTVqUEs2Vm5tS2xQR2tTNERYYkx5VWYyOWlRaXl6NFhp?=
 =?utf-8?B?alFpVVdwOTE1bElXNmFsQldBN3hyZk5ZL3pDa1RyOVNhQUR2NzlCK2FnOEVZ?=
 =?utf-8?B?K0RtNGRZODJuNG90S0pnUHFiVlZ2L20zR21vK1R4SjdBOE03aXd6ZFE3NjVx?=
 =?utf-8?B?dDdnc1pSamFLbXkreGdtcXhpS0drcTR1QUlRNnJsQmtpSHJwZk9WZDV3S2FT?=
 =?utf-8?B?Q1dsMVFEdk1SRW8rK2ZyTm12c2ZrRVhseS9jYlBBVHVyU1ZvWmpPUVdJTldO?=
 =?utf-8?B?dmVBN0RPVE1qOWNCeDN3aUVXb2NHZHQrQzhVd0IyYnI1NTh6TFJzaEQxUVRU?=
 =?utf-8?B?K1JZdUdJeXo2Z211UlU4OXZ5cEI5b00rdU5KcWh3QVhQbXg4aWJNS0hyVzRB?=
 =?utf-8?B?elk3Nnk4MmF3OFA3Mm5MVE1QS1N3bkh6azY3TXQxeXAxY0k2UFA5NTd5cXd0?=
 =?utf-8?B?NjZxM1VySzFCM1k4ODJUdGZBOFRyaEowcHBZOWltOEtETndRWjRWYUIwZW9W?=
 =?utf-8?B?bVJtcjdUTHNJQWxwWEY0N1ZFbjZPS0VNdlFiLzdzTU4zTkdQdFVBKzd1Tjdw?=
 =?utf-8?B?bkJLUzBtRElvWGlmUWE1ZWMvcXozRWNqbWxEWlZNRExhT01GT2RBRFdRMzAv?=
 =?utf-8?B?bmlnUGdOVmkwd3JWZHR6eG1mcHhWWVN5UW1JT2FGc0VDdHNmMXp0bERIS1lo?=
 =?utf-8?B?NHErajNPUjRoQy84V2hFNFk1dUpwUTRmOXJETFVRK3Z0NkFhK3VzWGw0bnM4?=
 =?utf-8?B?bDNidlhXM0d3ditLby9kYncrRmlzUkFnWTh0K2dxbVZsamQ4VjlDK3hLZXVP?=
 =?utf-8?B?RFBvU1NMOVdWN0NQcW54emlPdEc0cXhURllGQkRqQlpUeXBLR3JxSTRXQit3?=
 =?utf-8?B?Z1ZBM1lWenpIN2N6bC82VGxPOXhrckdOSlQvV1JtdzZUaVRsK3U2V3I2VjFT?=
 =?utf-8?B?U0dubW9wTGh6U1dXbWlrbkluZGx0Y1VjKzk4Y2M1d29YenhUYll4SmFMcXBi?=
 =?utf-8?B?YnkwOUd6MzZzYW5ZUnRZYm9pNVZMTllnRk9GQVNJQ3VyckhXWnZ1aHRyaUdo?=
 =?utf-8?B?NWoyOFNrUm9wNWtySkh4UnR5ZDFtaWVMTjlab3h1dXluUXl0cTdac2Jxbkw5?=
 =?utf-8?B?Q1BXRjdrYndaYXluMW54V1EzRnpvYmdTWUJJRE1JV0ljclRrZk9xMjduR0lQ?=
 =?utf-8?Q?Bz/h51vegHc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRyNWszdytTLzJUbkpTZTk4MFdFL251OHFocE1KV0xwTnhsdk1MeDN5blZ1?=
 =?utf-8?B?OFJtTEhIZE10cktVS2Jwc1hhYWIreUxpemJHWjFFbW5FeTFjSTVFQ0VRaHha?=
 =?utf-8?B?dVliN2xISzA0OXorYWtQUWp5SE9TcUpLNmlkelF5NnZnM3h0cTYyaml5N1NJ?=
 =?utf-8?B?RTR6cjNTVHJlU1JIU285akVFSmtwWS9nc0xkdWRBOFo0MldVK29qNVhCWmxy?=
 =?utf-8?B?amp0QkpuQk8rekxxbWtLb0piMU9Ib2FBQklnMitkcFUrdy9DTUw4TWU0cnNX?=
 =?utf-8?B?WjRqTFczb2FLRHd2SDIyV3RZSVlQZlIxQ3NZWlhoL205V0RpRU9xa09xMkE0?=
 =?utf-8?B?VWd6K0VMcTRzd2J6SGVsWXhUSllxL1F6WG84SDVDeTVXMnhLNTI5VEJUWEs5?=
 =?utf-8?B?VmNiTmZaeFo0K0sreFZldVBIYk1Na29Qa3JBYU9wd2hGVmJJZ3JqZGVHY2lO?=
 =?utf-8?B?MitoQjdDRytMYWVLbFlpbCs0SlF0bkxzaXVIdE5CN3ZWbk9mVFNwaEFyY2M5?=
 =?utf-8?B?WEMwaWk4dnhQS3JKRTlTYlI0UTRCV0NObUJIY1g3cml2cFhSMXQ5aldOVy9H?=
 =?utf-8?B?anAxekxMT2JaNjdsbFl5M3lzTFM4enJmcXRWcU1XY0J5V3VJdDF5QnV0R3Nn?=
 =?utf-8?B?clhVL0tXOW5uT1UwbFZNdVdUOEUyOEg4L0drUGpnOS93TEtYeHBmREp6cnZP?=
 =?utf-8?B?UlpZSjFaTkVYNURxb0dmTGFHZXZBUFF1eTJyRjl2UThENkl1TFdObmh6ZlZB?=
 =?utf-8?B?eFpGajlYYlJHTjZPaXNOSExhbWR3R3FocVh3eSt5WmFpZ3FyS1RZV08vNHR6?=
 =?utf-8?B?SDZVNzg3bEJxR0ZuYStKMEFQUE5qWVh3cWdRR010RjJLclZXUmhLWi92bTlE?=
 =?utf-8?B?VVM5bnFoNWVOU25hWTd4elYwL25aUElUcVBWTjNtMGtOOWRXeHh1MEdkNjVt?=
 =?utf-8?B?Q3pOd2RYVFZFemtwZlZvMVkzZjhzaVBPMnEyMjRyMVRUc011TldaS0YxcUFa?=
 =?utf-8?B?K0ZsbCs0cHBjcTIzbXloa2gvQ2haUkNQclNsS05ubXpZbmozU2hpeDFucTRi?=
 =?utf-8?B?V01KSlJhWVJ6Qzk1eW1zbjJ2VWhXMUFYbFFrd0pERFRvRUM4WDhxSW9lYWIw?=
 =?utf-8?B?R2Y2RmVad2ZobHo0YUFKbVhZdDJJeFI5ekdGRW90cFRxL0xGZ251Z0RaZncx?=
 =?utf-8?B?eVo2L3BTQ1RRb1lWRWpwaC9OZGVwaFJ4ak43VXluR1czcndJMmZuMERPT2RY?=
 =?utf-8?B?SjFzNHZGWnZzdTVidC9MR1ZneVNhaVRXUHh0QVpKalNBOVJXVndFZW13Vm9L?=
 =?utf-8?B?MHBpeG0rYUpVRXk1Y2ZxOHNYZVA0ZkZ6YzNqUUExd2hMcGt3MzJ5dW1TaTdP?=
 =?utf-8?B?WEtzdVkyU25QeWVTQk1WSDZCRW1kMGRkb25ydlpFTXZxNGdONzlKek82SHho?=
 =?utf-8?B?R0gxcXI1TWNaeWJoZVpOeXV3eHdsdXVjQVdUSFdFODd5Tk9FYkUxL05rdk5X?=
 =?utf-8?B?Rm94cTVWbUVXMHJpa1lWS2owNG5uTmpwazBmdjV1Q1ozL0JqclhyVjYwZ3lH?=
 =?utf-8?B?WmdWbWoxd0pDbDhqcTZTS1hNcWJoeGx3WXB5ZC9qaUh2ZmZKWUNwQXBoT3o2?=
 =?utf-8?B?aGRFZGdad0VmUDUvU1BoUC9qL0lCS0lYNGZIR2k2R3l5U3FSWWM0QUgwaUlD?=
 =?utf-8?B?M3phNEJqQzRaN2FMQk5sWEVPNmtKa0g3S2JoS05UeWFmOWY1VFgxWUxMNll5?=
 =?utf-8?B?Y1AzM3pBWERWOFZadUs3UXlpbVVJNEZHQkpIKzJxM09WMTVwbFE1UXFOTmhp?=
 =?utf-8?B?Z3ZrNjFFc1c4ekhBQVV5OHZ5THQyWE5qL3QwWTlYZzFKZmNrWW1LZmdab0tH?=
 =?utf-8?B?MW5DRG9jQTVXL1ZqdXlwbmxuRHhZMTBaOUdvaE9HeHM2MFp0RmdzZU1WWTFH?=
 =?utf-8?B?TWNncjZSOFcvSkZ0S1pwbUN5dy9kK3BYTGREN1BBWGNMTjU1bmt6YzlmSC9j?=
 =?utf-8?B?R3dzNEFuY3YwamM5NGcvV1dVdEFKcmRlZnFyTkVZZzZQcldDOGVDVjNlNFVt?=
 =?utf-8?B?SGxMRW4xUllibVRGM2l1Z2NnR3owSG9aVEZNejlTL2VxRHJzUmIzNHZkcVVX?=
 =?utf-8?B?YmFrLzdlYTcyOWtPYWo2aVc1ZlIrSTEyL2dHOWpWeXF4N014UmVWbWNhUlVT?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: efe1de32-56f5-42e5-a9f6-08ddc545594e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:19:39.9875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLDf9Cv/W9nNHdcVZ/QLnFIZbYHYZRkh67JE6rg11esM/EUoYzcIVBQhUqj9mYqM2Ci39eMakmmdTf22eNrhNnsmRZBCSf/Fj219LLx6vcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
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

Hi Tom,

On 7/17/25 5:08 PM, Tom Rini wrote:
> On Mon, Jul 14, 2025 at 12:35:14PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 7/2/25 3:05 AM, Tom Rini wrote:
>>> For 32/64bit correctness, we need to use ulong and not u32 for casting
>>> for addresses.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Lukasz Majewski <lukma@denx.de>
>>> Cc: Sean Anderson <seanga2@gmail.com>
>>> ---
>>>    drivers/clk/clk-cdce9xx.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
>>> index e5f74e714d54..afb997c06be5 100644
>>> --- a/drivers/clk/clk-cdce9xx.c
>>> +++ b/drivers/clk/clk-cdce9xx.c
>>> @@ -103,7 +103,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
>>>    	u32 val;
>>>    	struct clk clk;
>>> -	val = (u32)dev_read_addr_ptr(dev);
>>> +	val = (ulong)dev_read_addr_ptr(dev);
>>
>> The output would be stored in a u32 anyway so not sure this actually helps
>> (see type of val in the git context above).
> 
> Yeah. It's funny. The other example of a driver doing these games is
> drivers/clk/clk_versaclock.c which uses u64 since it's a 64bit system I
> believe.
> 
>>>    	ret = i2c_get_chip(dev->parent, val, 1, &data->i2c);
>>>    	if (ret) {
>>> @@ -226,10 +226,10 @@ static ulong cdce9xx_clk_set_rate(struct clk *clk, ulong rate)
>>>    }
>>>    static const struct udevice_id cdce9xx_clk_of_match[] = {
>>> -	{ .compatible = "ti,cdce913", .data = (u32)&cdce913_chip_info },
>>> -	{ .compatible = "ti,cdce925", .data = (u32)&cdce925_chip_info },
>>> -	{ .compatible = "ti,cdce937", .data = (u32)&cdce937_chip_info },
>>> -	{ .compatible = "ti,cdce949", .data = (u32)&cdce949_chip_info },
>>> +	{ .compatible = "ti,cdce913", .data = (ulong)&cdce913_chip_info },
>>> +	{ .compatible = "ti,cdce925", .data = (ulong)&cdce925_chip_info },
>>> +	{ .compatible = "ti,cdce937", .data = (ulong)&cdce937_chip_info },
>>> +	{ .compatible = "ti,cdce949", .data = (ulong)&cdce949_chip_info },
>>
>> Just get rid of the cast I guess? udevice_id.data being a ulong already the
>> compiler should perform the cast in any case and this improves readability?
> 
> Without some cast we get:
> error: initialization of ‘long unsigned int’ from ‘const struct
> cdce9xx_chip_info *’ makes integer from pointer without a cast
> [-Werror=int-conversion]
> 

My apologies for the mislead.

It seems like places where it's not needed are where the member is of 
type void*. The kernel uses this type for of_device_id struct which I'm 
the most familiar with, but U-Boot's udevice_id actually uses a ulong 
instead, which thus requires the cast I guess.

> That said, I'm just going to drop this patch and make the driver depend
> on ARCH_OMAP2PLUS. My gut feeling is this is another one of the cases
> where we run in to problems because we don't use phys_addr_t for
> physical addresses consistently.
> 

Considering it could be anything, should the type be void* like in the 
kernel for udevice_id.data maybe? Up to the driver to perform the proper 
cast when accessing/dereferencing it?

Cheers,
Quentin
