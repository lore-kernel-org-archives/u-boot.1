Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54422CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C996783631;
	Mon, 20 Oct 2025 16:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hbsi+Lc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E7D836D2; Mon, 20 Oct 2025 16:01:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A648334F
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8NvCP0bxt++s9CTcye6bjcx7Dt5Ox3Geopy7a3ky82wqdbax6narHSMTPWELiTUAoxGf+j+x3dmEZnx6KAYLVdOk/I7aWo23uI2si6GyZ2DZjpz4uRbP7YlwjMNL1zaBe/azWPVjBHGcdUEBG5nbp15YOpEHMn7N4PVbR1iEf3D80n5tf1Hz7pa16CvqhuQMR3BOwybfyVGDS76DMTQgGIy+HBg/m280S4aZ7u9IwLpH8S0IZbZp/i9GlOn6lZlZpZ3rPFFWh3ip5yWH8w9a551dwmQELVQ5LofPdyFys87ntTNxMniTP+ftIPHq52w2y69MN3iO6gLpFZ/WAsA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RA4o4bgsPuW2n7ic8FIwt25Z/BrEtJS1Vvh9VcRC2I=;
 b=Uvm6A0I5hGiOLa0i0oTGgpLHo3mi00NvKqYyo/G0ekfJSIJM77F7k59aQwvq/rvUFXaO9KKbsKwHXFw27QagD1d4jtfjAgdSoGumarepBApqHIG0B4/0oe23L6y+3merWkN/Ey17cvq3a7H5LSQ9Hscq63PoyrVQoabXupZzqYu6N7b/Fe0u9E9MAUxY5to+cRgo+CNABXrLEhl3PTt93bjQTFag7XHvBEwZeFRLyFxP9fdQVw3DY4I4u3B5AJVgmFcRztAm0AKIy2NEs6Sv/fNmVGLzm9nh8mn1CEBVVC1TJ28BrKnNuL0blsTLS21bWUoZyFTQ7yt4aRLWU49opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RA4o4bgsPuW2n7ic8FIwt25Z/BrEtJS1Vvh9VcRC2I=;
 b=hbsi+Lc5Cj/+chQHDFY+FE3Y2aQ7Pn9FpdThY3ad5loGCCykBdXPwVThBjU9rYLKrsfo1xd3uZQs3nrIdQxLn1sv/2TmcL4n5YUyRbtZUuvLoecL1ig4Al9JRB6DQM9uKORL7y7cvxqZdMm0ibfPo57wYaZy73dldpT7RAwVWrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AMDPR04MB11701.eurprd04.prod.outlook.com (2603:10a6:20b:71a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Mon, 20 Oct
 2025 14:01:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:01:21 +0000
Message-ID: <3a75448b-c3ff-4504-acbf-e5c3b959189f@cherry.de>
Date: Mon, 20 Oct 2025 16:01:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: environment: fix links to Linux kernel documentation
To: Mattia Narducci <mattianarducci1@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <1937375.tdWV9SEqCh@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1937375.tdWV9SEqCh@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AMDPR04MB11701:EE_
X-MS-Office365-Filtering-Correlation-Id: 1465d847-7ed2-4945-556f-08de0fe125d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXl1ZTQ4MzQ4RTdoQVliZmZvaVhRY0tRU1M3c1A4VGVCRkRSZEsxQTl6RGtU?=
 =?utf-8?B?TGcwSnVVemJzMUxkclBpMkFGTmp0VHdFZHd5TWphUGVZS05nZjZVdytpZisv?=
 =?utf-8?B?Qm1SUkE3OStBOTZTRGZwUFZSMDVxaVRxRUhaWUYxWkJoYUZlRnc2Tm12ZjNI?=
 =?utf-8?B?aWFYWkpMNlNwcHI5YmtRQXV6MFMwbEgzRG11RFFLTTY4eVI0dXQvaks2Q0tP?=
 =?utf-8?B?KzhkdmdFNHYxckgyOUhMbGlWRE5kUG1xZW40bVllOTB0RHhwRUEra0JXZVRj?=
 =?utf-8?B?emxZcTFXNDNyYWJFekZRYkRtV21qc2xLZzlDNlUxenIzQVM4d3BLWGlMeGZ6?=
 =?utf-8?B?TzR1azBNeFRibUhsWWI5eVcxaVYxM1gvQ0hHMDJwejhpc1piQTVqRFdYbTJE?=
 =?utf-8?B?dFNqOXNaakZRSHl4UzFMN2d3WU9sUHZpdkhxSFlkTk95RUdUMDNVN0NXN3RM?=
 =?utf-8?B?YUp1OU5iU2JHaGY3YWloU3RaVm1ObHNVSEt0anRnZUUyYldpcGFHTGU0bFQz?=
 =?utf-8?B?Qzc2dTR2aUhIMGZaL01wK3I5NThrUzQ4bUk4N2c1cVFsdSt3bi8yZ3FQQXlK?=
 =?utf-8?B?Z1p5ak5hZm8wcE4rbEVSaGJ6ZHN5bXhkdXArM2RGbXl1OG1pd0JRSEFrOTNZ?=
 =?utf-8?B?U1dBbVM0U0orblVXTkxjcGFEZ1dBN0wwamR6dURWcDV1QWQ2VzVUdDFJenRu?=
 =?utf-8?B?ZFd0SGowOGEvem9ERUxGcncrcEdkUFpudmRWdjNiY2g0L1NSdnFqQ0VaTXR2?=
 =?utf-8?B?L3l6VXZTZk9Ld0t6MUpYeXF3WGlMNFRMWlZmcnNVK3dkTDFMRG1hUmtGV2Fm?=
 =?utf-8?B?bk5tOS9tVW5ZbnB6UUlMWWoyUkM5ZzRCSHVhSGttSHI4dWtocnh2WTZLYU9E?=
 =?utf-8?B?TTBDS1E4WStyU1JtTXhXazBpb0tDZGFtTGtxaDBIT2ZySS9oQlpXdUpSWStM?=
 =?utf-8?B?eE9RMWtCWWJUOGJZTllLU3JHOXNJUzIrTjF6WldXbGttLzMyMW1CZmNOc3N6?=
 =?utf-8?B?QWlldk44eFNtdTJ4WERtL2dpMzVEbjEwSTI5ajY0ampYVU9OUi9lNmhzODBw?=
 =?utf-8?B?bW92M3dOMjFxa1BMUTJ1QlFFeUpGM2lMbUpEV2xWNnRNT084UGhRNGpkbkJV?=
 =?utf-8?B?aHY5R3ZrQTVKSlpET3UrcFk2TmY1eGl3dVk2TVVKZlhWNU5jUHRYd0pvNDBC?=
 =?utf-8?B?dmdKYzBiaVdTYktoUFQ4N292aXNjWUFkRGh5V3dLaGNHU1dudnRVRHlrYlJ0?=
 =?utf-8?B?VnBkeFNXQ2l0S21pVVFZTlo5VWdLaWR2Qks5ZlloYmw3OE9TYm1nalJwdHlJ?=
 =?utf-8?B?L3BES0paYkN3ZW1JcjBWSHZOTmt2Z29tSFQ0K203ZFUzV0VwckhyaEI2SEha?=
 =?utf-8?B?U3UvNkVCYmtFT2lKT0dnWVdGOEJQdDhoWlZjbUUrRU1mQW1mTlpVdms4c24w?=
 =?utf-8?B?MDJwd3lrYVAzOGdmZC9zY0JqNWNUQlU5cmgyaXhpaGNjK0V5OUcxdjhNc0Np?=
 =?utf-8?B?djZ3RlJEc1BsbWJqR0ljQ0pkYTdxQVZNQWhGc2ZsMzZnbStYWVZ2Zkh2V2J6?=
 =?utf-8?B?YWdVOFQwUUtpSjJDWFBNWFVhVXM5bTgzRzRuY20wck5idG4vVjZydjNVNE9I?=
 =?utf-8?B?bjRxNlFhRGFvWWNtWmk4QlcxZzl4MUVqWHlybXMwajVnT0tSZEJ0NDBZYXRz?=
 =?utf-8?B?eVdFU3VkNDUySlp3ODJwc0hvY1RuYXpTSWhPdk5uRGdQRUhRRGZ1bWJZdFR1?=
 =?utf-8?B?Q0lrT3B5YlpzWFd0ZEdXd3czUDRDU2RRTDdQTnFDT0FVMU4xV1lETW9YUkRq?=
 =?utf-8?B?bWJSZGxGYXg2d3dXMWpqaU5uMUJpOW5jYllRRXdoU0hwQW1WWlc4WVQxV3cv?=
 =?utf-8?B?dkVDQkZWNjlmNVBNc296MFBtSDY0bzYveUhiWWdhZDR4TFJPWWlaUW1Gd1l4?=
 =?utf-8?Q?6g9zBXXWZzM0uZ87NNZW09udwGFW4R7y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpJWmthMGI0azdkOTBNTWdJL2dWbHlXa3lBTWRuNEg0d1l2L3pFTm5Oa1VZ?=
 =?utf-8?B?MitySnBhUTZZZHVlc2ZPQjNZSW96WFV5SmVhRGh4R3UxaWd2c1ErOU5vY2Ju?=
 =?utf-8?B?R2NOVVdBdlVNQ2Q5R1phNVJmL3cyTks3UHh2WDRiU0NwRFZjb2FkWmx0TEJW?=
 =?utf-8?B?OVpRNEZNSWErMkRoZzZoUzBhbzU3MFRGY3NOb2JHaTZ5NEJWV3ZHU2UyTUpo?=
 =?utf-8?B?THlMRzdiUTRJTG5CMGN3LzZaS1EzRlBPZUNqK1grb1FhYU5icEd1QnFlK3VR?=
 =?utf-8?B?REw3TzRWYy85M3o3dWZMOVBnTjBnUk1KeDRENlBYcmE5R1p1ZHVHZ0Z1VGRa?=
 =?utf-8?B?SnU5cjdxLzg0UHYxeEZydE9JOHJ6YjF3MU9ZSDdjV3gxSVlpT3pzSUh0eDcv?=
 =?utf-8?B?R0taNURnRnlaVUFQejllakhTTFVQSFRKeExUSnQ2cW5zZTNNQjFBeE9PM1U1?=
 =?utf-8?B?YVk1ZzRKbjV0blkxckJrem5HdGNnb3o2NjFkdEFENzBZSUFFZDdUL0NOWVJK?=
 =?utf-8?B?S1NSc3h5MDVQUTN5QlVWdkNhZjBueXFxVW1Xb2NZU1FkQXorVWR6MUoxSnJq?=
 =?utf-8?B?ejBORHlPYndTTmIwOTltdVZqUzB5eGdYdEtDekppN0dOalQ5Ung1U1VPNFZL?=
 =?utf-8?B?R29aYUJBRDlNQUQ1a2MzeTgrL085bEtYZ1VxQk5aVzNlMlZ5bEdLR0hnbTVu?=
 =?utf-8?B?SmtJN1pRanplcW9SbStpRG0rS0krS1lsSHRJUURTcGx5R1JWYnJMSW9LWUZ5?=
 =?utf-8?B?SmVFcWRCS2VZMHUyZFdYYXJFK2ZGdkwwemFBeVR0bk8wVzh6cWRzYkw1MWxr?=
 =?utf-8?B?V0VjWXVZbHNoZXZTdm5oOGxCMER3Rm5uSnBUcXEyTWNhU1oyZWVLdGxFRlIx?=
 =?utf-8?B?TndndXd0S2UyWmpPNmZvN3NkRXAyM3lNMFlHNU81dEgyaitvMEdxSU9OR2Fk?=
 =?utf-8?B?QUJ3eVJLdDBZNlIzWDltZGQyclFTMVhaZzhKRXU1NWl1NjgzYWdxZ2Q2dk5q?=
 =?utf-8?B?dHBETll6UklId09SOTllOXdqSkMyYUg3UnBYdzF3Yi9ZVmsvdU1kblB6YnYx?=
 =?utf-8?B?ZnlJSGF2dnNxamZySk9YalBicFdyOUdGcmpJK3NhUzB4NEZBa3c1ZU5lVjBt?=
 =?utf-8?B?ZWhaYWI5dFA3ZFhRaHlEazdYL2tZVnRWa2hza0JGL3E3S3BnRHU4dzFXSS95?=
 =?utf-8?B?YVBVYXVVUGZkOGgvajV2VEM5TitmWWFyYmFtVkt5L0dVTDF2eVozS1NGd0Uz?=
 =?utf-8?B?WnlDamVhcHAra0lwcTZXc0YyQ3VhWDFBTHIweUU1ZGliMkVKSWl0a0JnQUhx?=
 =?utf-8?B?NFNnUTIzY3hjemVJeWc3ZGRRZHYyT1ZCczkxQVVlS1ArOG1aMUdpMTMzMFBD?=
 =?utf-8?B?VElXZVFlVnBTOUN6R3ExMXBzb3VnQUtrLzY1dWhJKytIOS9MSlJoMDQ1NW1a?=
 =?utf-8?B?MDAwNmNLMHFYRm1YUURsQ2pMWjRiSHFhaWRCeGhDVFJvdnluVmZxKzhEOUJ3?=
 =?utf-8?B?TXZmSEhxOU1xTHBiRDBpUW9hMWVxd1dITWNCMkg4RE5yZDRNVkpWOVVtZFFC?=
 =?utf-8?B?RjVXeDRiaERPNjlvN1dweG9ERTJtVlFjZCt6cFMxalE5TUxFNzVTT0d4cE9E?=
 =?utf-8?B?ZmlJTVRNVHI3NGtuR3VSaWRjOW5oSjl4U1NKbmdRVkZMOEVVenJncFNZTGE3?=
 =?utf-8?B?SG84T0ZPV2J2Zmdac1JBMUxBaU5aTDRaRFBFU3Rva3JBR2JnSE5Wbittc0hq?=
 =?utf-8?B?UVlpZmpWN3cyQnRVdGhRSjkyeXlGMTR5THF1Ulg0ZE1qWm5wWWtacUc5eUVn?=
 =?utf-8?B?MFFUQUt3VFBiVXpIRVJCUWkxQXBuOG55aXRYdEV4bVRkZ1pxdUwyeG5iYzFF?=
 =?utf-8?B?WUxxU2txSEw5L21sME51SW9jSWZZR2tpLzlWaElyd0xOQ2ZNUFozOHhDOFJJ?=
 =?utf-8?B?OU1IZHk0eTJ2b3ZMOVBiUklSSjI5OHB3MDRqNjRFZjUxcnB5bzd4L3ljd1cy?=
 =?utf-8?B?ZGV5VWhwWStGVThHK0RXYWVHRjlLeUU5cjFvWnRLbUVjVlVnUSt0WmJTOCtI?=
 =?utf-8?B?QnJQYUJJS0lhRVlXa2dURnROcEd6dGp5eUdldEVPKzVwcmxzSzd3RytGV1V3?=
 =?utf-8?B?ODlLL3h1M1VYY2QrMloxSkJLM0xYeXEwOUI5ZWxhVFh1MDBlczVnUFl0WDVP?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1465d847-7ed2-4945-556f-08de0fe125d1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:01:21.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH5eY0Lyjg6RqR4GCNnmQiakIPUr6WFPuZ1nWCH4Pn69OPX2Ne2A18+FTQ5FXBE5QBG2g3TkJFQgYeFBx3i6aOpFv7J4MVF65EIGtqm9TP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11701
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

Hi Mattia,

On 10/10/25 9:31 PM, Mattia Narducci wrote:
> Architecture-specific documentation in the Linux kernel was moved to
> the arch/ subdirectory.
> 

I confirm, the change was made in 
04fc8904d5d18a132f5ad67b79ee980b6602c8c6 merge commit, part of the v6.5 
kernel release. And the new links work fine while the old ones don't, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
