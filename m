Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B736FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 12:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4493817EC;
	Mon, 24 Mar 2025 13:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="e8M+eabC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1648197D; Mon, 24 Mar 2025 13:27:41 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F1C8122F
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp676cDA8f/m4CsXcuOtDl72Z+8Pcegz/Frt9fasOefbHtAaoMcXL/tj+NksTzJr7CvcZuY4CrSDcHECFUKIfbOZsSy7COC0R8fgs9HYVpn5fo9A6KJzK/B4Sbwp9V05qVo1b7bmrOwhdfIkTq91m9MA6n1YP57uoYxqnGFrniEpSBzE+uQp5o2OXQh9YodK8X7zohGkozp+cKjVubjXCGSbspPCSwUTeMOgWxu99+OU55VtGeyE06DnSJBbsy2yx3sNPqjR4etQeAh/M7DDsT/GIJG4Jc2N7eKuBLpqQCFH0LZQmz+RDDrg4L0FhmNPYHo/P34IRHo6q0UeRKFRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii7AKaHsl+etwS2vXiSoTIHnaEypVzGOY9DX5NE4C1k=;
 b=QX1f05gvfVyw33UQMimI8A/IIL7GE4qo5G0P+MVwwPJ3bd1Q2IDotN74hA8yKQTFG6TSZwChKgESesJbeXwrMiraLHkrw4ir2iSMNRCxlZvcyAtKKCZoTPjD4SLUMH1uIcmlWJkwOkWSaRJnPuLdSVxK8Qb8+XWVrkG6upZSPpfGHM/b70OXDUGioofF3gUCgRUrhxuHpSqXmUkQj3RZvl/UHlvow5f5Iw6esS6h/UtJcxLqNUSkNMBvWcsCRGLHBLs5LAmsr6c0W6YFTLpJxxewqhwtu4A4nf4Lg2FAujQqK5rpitBBQqfemt7wbxEJl2fG7fuUtDosPCcSLkyM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii7AKaHsl+etwS2vXiSoTIHnaEypVzGOY9DX5NE4C1k=;
 b=e8M+eabCTWUtkljdkMM47qJY9kIF6mTwn/mqIE7zv8PYV1eWXE5GZ04X2IysXhIkvFoX6r+dTEREq1xcsQrfhNC5tso07dznGXLGuqTAjFIkMFkFbs9NG/n4xry1NETP6LBkk8BX0E89rF/qzSacPDbrWmuNV9Cs7c2feyBDQD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10900.eurprd04.prod.outlook.com (2603:10a6:150:21c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:27:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:27:35 +0000
Message-ID: <4e721f9f-9d64-4028-b238-828731def884@cherry.de>
Date: Mon, 24 Mar 2025 13:27:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] env: Rename OVERWRITE_ETHADDR_ONCE to
 ENV_OVERWRITE_ETHADDR_ONCE
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10900:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bcdbc4-1d5f-438e-fe7b-08dd6acf41b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VmU21DTDJMdEpYbUswSndoVzFIUGFLTXk2M1NTRFpLY3JscWN0N0E4ZTRr?=
 =?utf-8?B?V0U3Z2ZITmQxdEVOcWpDdWZLOEpqSU9lWFBaSkQ2UzcxeXJ4YnIvN2x3Nng5?=
 =?utf-8?B?V1ZtaVZtbnB4dGp5OEJVbWdmNEhEa211YmdodGVEd2lTazV1WUtlTmZ1SG8y?=
 =?utf-8?B?dmYxdE4rSE1SbkpxeUkra1d0ZDc2eVZpZ2hKQk5LNkQ0Z3VsQ1RkRnV4eWxh?=
 =?utf-8?B?QXE5UlNZaGRCTklMc2VKV0FTK0JvVVRXUmlDb1FKMytHRU9xS3htTGhVUEVt?=
 =?utf-8?B?TmJqVysxdDhZZzhDNk1oam9WMFA5Vi9UL0N5a21VVHdXYnZCcEtVZjJkRzhr?=
 =?utf-8?B?SC9IdUNyU0VSbStWeEdIb0FrYVRucnNiWXR1eEx1WnhxOVdzZHlPdjNrVlBU?=
 =?utf-8?B?bFR3eVc5R29YODliSWs4MnpVMFhOUVpHdUJwVlFrWWFBZy9FcVp1RGZSWmVI?=
 =?utf-8?B?NEF0U2phNzhvU242aVorbkhzZHlxaW9qNW5nRDVwRGRLK0pabEpmQ0svNmtD?=
 =?utf-8?B?cWdMaTM2NEdWZUpHQU45RFFBQUQ0WXRESGtOR2JqR1VHWEdpTEtiSm5BUWVy?=
 =?utf-8?B?UTRtc3VSZ1NLSTdNbjlSNUhxQnd4bDFjUUZSU3FQTlVsUExHQVA1c3J2RzR4?=
 =?utf-8?B?OFNiYlBPTXpJM0ltRlprT2liclc1WmMvdldBYllsdDU1Y0wrTVBWWmp2QVdx?=
 =?utf-8?B?NHA0NkJaQXdwVC9WamZSeGFxWHZLSXhrSE4xVVpac3NrRjlUUCs5M253T1Rx?=
 =?utf-8?B?ZWRYNGZKbE1EVGNSVjhHWndma3FJQWM2TVRZc0Z2SGsrNXhwZm1nQ296WG1m?=
 =?utf-8?B?NFhQYVdTOXNpOTNXVFFMY1VXczVvZGxoYVJ1TTR4d2dXMEFtbGJaSnVpZVV0?=
 =?utf-8?B?UWxqWmYwM0RDcE1CU0tqZWZiTDNFOFhZUjEvait5QUd0VGg4NGhySDhqWi81?=
 =?utf-8?B?UmNqSXViVDFibmh1UU5nTzUzR2htZk42STJnSm5CUEJCTUlWQmdhL3hqcGZK?=
 =?utf-8?B?QmZVL3IyclJaQ3ZuQy9sUkFETkJGM2cwNEJNRnBsRlpwSXQ5VzQ1T1RmNDhF?=
 =?utf-8?B?TXdyUGhnbnFvMS9kakxvRGdTUUIvVFFKdVhodUZxMWJIVkZjVWJFVnFScW44?=
 =?utf-8?B?Mm8zaFBOMUllKzBkK3Mzb2R1c2VqblhuYzZiR3cvbVhDRUp5dFQ1aWhNZjda?=
 =?utf-8?B?bCttZFV4R01hcS9YTmF6RmxDanpxdHFVNXM4cktST2g2NUlieDdjbE0vUnl5?=
 =?utf-8?B?aVBiUGNxZUNZSVJNUXlzUVNHR3FjRFY4R09pNlRaQ0o2cXJ3eHQ4V05xM1VF?=
 =?utf-8?B?RWt1R2lBQXJ0MGxKUGFVZG1nMlA1Z2NPOTQwUmsvREdiN2JCby9GMEVUZldo?=
 =?utf-8?B?cUNBZ05wOFdjbUFGOTRSUUlPVnpyTVBoVEtISXhWdWZjbGl4TTVrTUFkUmVi?=
 =?utf-8?B?WmQ1aFgxRWJTeXFFRjNyckJ1bHIxb3FNVnY5VEs3dVl6VVdEQlliWFA1WXR2?=
 =?utf-8?B?ODY4SGorTlUvMXJ0UzFCTWNzeVBXZ2lleXVhNy9CckNzUmZydzI3T01DWk9Z?=
 =?utf-8?B?a05zRTNnZy95T2FpSVFRTzdXeUREN3ZMZUVmRnhFTldYaHhGckNVWVZiV2VX?=
 =?utf-8?B?cVdCSm52YmV0UDFkR2cybEZ1OHNVU1MzaktiSkpyQlUyNFY1YU1DOG1QQTRX?=
 =?utf-8?B?NjhRN1lVNHg4c2VSd1lJSXdXRjJ5NXJWRDIrMkIxbWxXY0d5MHQzVHhUR0t1?=
 =?utf-8?B?aHZpLzdxRFI3dVJPakVBLytoMysvbnN0RnRUL0FDVlNIOTFSKzZFeUNGdklG?=
 =?utf-8?B?elovUEpCWmVGQXo1L1VmeDR1L3c5ak5rblduTnFkS0lBdkswQzlKeWdkcUFm?=
 =?utf-8?Q?mWGLIzi520uly?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhZM2NsNytNbk1yRG83RndTNktURG96YlJ3dWEzenl3SmFseFVveldXb2ZB?=
 =?utf-8?B?WlRjdGROZHFUM29ad2FTc0FpSDkxUU9oSlVreUhDNGhUekVkRjJqTjNtdW55?=
 =?utf-8?B?TGlGOWh3MmxWQ3NDOXhJeDlvOEhKYm9vZFEzL3FPT055S0pzSm5SSTFLYUVX?=
 =?utf-8?B?SURuQ25uMS9XYUZJemlzcVU1dmZkaURsK00zbk01ZFVVS0gycFZCdEYzK1VL?=
 =?utf-8?B?dlI4RUN4UTBzUVlQUXNEN3lOZkRGVGNVV3p6eGpjdGN0SG9OWklxZm9YZDZZ?=
 =?utf-8?B?Q1A0WXFybGRCM280aFduNzd6R3Q3RHVnaUNnT3lOcHN6TkI5VTFEQVdnTWM5?=
 =?utf-8?B?c3BmMklLZG9oZ2JOSTZKSmZkMGRaNjlhdE1KdFFOUGlReXErRUZPTFFnMkl3?=
 =?utf-8?B?M2NQSHNTZ1psdjBPLzA5SWpSOUpKbC96YmUxcU40NWJScmhLMk5TeU5jUFdO?=
 =?utf-8?B?VVl6VHhVcGtKSE5lMm9NUzFIajBjZW1XNWFxa3RTYVBMb0RqYURrSFR1ZVpG?=
 =?utf-8?B?WDRMNUhaeDdCbTJBOE1ZSXlEOXlwQnhGNElmRFNMNlFQRTVSaVNLdFMrcFRr?=
 =?utf-8?B?LzVmMjhNa2huWmVOak1qdXViUUxlalI4UW5IejNLaGVTWDF0Mms1Z0RqRXdR?=
 =?utf-8?B?akRsQmtXRnR6eHZlVHBrbms3d3Q1bTk2eVJvOUlvOTQ0cVNzZzBwS1NGd2p1?=
 =?utf-8?B?M080WEVhM3N5U0ZsWFpoRnJ5T2tWdU8vQzFNQ09JOCtSWUFYNWxyL1IzZzZm?=
 =?utf-8?B?MXpaY2VSOSt5aUlyZFBGd0RROWxSa3d3ZjB2MGVMU1ZMZjNwUVBCMGcyNEtL?=
 =?utf-8?B?ZjBFRG5IL3M3cjRwS01pNFU4T1dLS2Q3Y1kvZzFGVllZQTUwK1FTaUJnY1RM?=
 =?utf-8?B?WHUwclNFc0tuSHEwYlZOWWVNZmJLVXM4czZ1M1lqaXJBeGdiOXRFWFIvc3hC?=
 =?utf-8?B?ZVR1NEw4Z3VkMGR5N3o2SWExc0w0UHhWY3pVZ0NNTGJqK3BuQ29sY09RVnVL?=
 =?utf-8?B?d3l6WWk2SmdpSUVvR0tVTVZPa1dsRGxsMTM1VkViY1ZuVEQ4MThsemNEdDZD?=
 =?utf-8?B?K01Wb1RQTXR6YTBvRThTV05QWHFFN0lxeG9IKzN5c2JRLyt2Uzg0Mys0TFow?=
 =?utf-8?B?YWtnbGdBNGZubHRqNG0vMmFxSmtubEdvZkk5djVacm52bHdqR29PMGx3MzlK?=
 =?utf-8?B?aG80OHhrbjdGOWRLZGpsUWcxUzlwWGdCUjNtTU8zNmtXR2g1RDdmQXVaQzl2?=
 =?utf-8?B?Lzg1VjdMbHR6UnhZQkpsd0hwVmlmT3FubjBhalk2MWdrWVVhVEIvSnl3aTZo?=
 =?utf-8?B?UVVWOXMrL2l6WnFnYUtHclJXRnpNSU83Q0NRdEJaQWV1U1pRTUhMcHpkaWEv?=
 =?utf-8?B?SXJqeFNxNDRiNWlwM1JYU3JLL2FnQzhLVUd1U3RKRk1uZm83NElDeTl4M1Yx?=
 =?utf-8?B?YzNKMkRtY0Z2SGdkQXYvYnhyUFlFbkhjdCsxdlBsM0hXaFQyYnhzbi9Nb0NU?=
 =?utf-8?B?bHlTTXFWcm5SdHpLdFhmT2Z3cnVPWTVvZkJZL05uanE3d296SS9LaEV6dVdq?=
 =?utf-8?B?YURvS1puZHdZQkVieVM0a1BlcVpnZFZRUG1yRkI5NmFocXNJVTJid09CMHNl?=
 =?utf-8?B?azc1TmlBaTllcklLQVd3bnlKZjBjc1c3M21XSk1KR01EbDh0SlhqVy9iQkF6?=
 =?utf-8?B?OFhFT2VIa2xPT3h6S2l4MVNpZGhxYTd4cW5hZjR1MjA0Zk52MWFOcHBTUmdK?=
 =?utf-8?B?UE05VlZ0cmJhQWRTSVlBd1JHZU9rUDFXNjJ1YWtvMWtrSnFGQlZpZlAxSUMr?=
 =?utf-8?B?MGhvemFyTkc3K2VUVWVLSTdGY0JlZVMwVzRQN2VYUXpXMVNrMlljNEJ6dElB?=
 =?utf-8?B?dTJkRm9qUzRRTVZwQzZMNjZIVXlrQ3hlTkhtNWw0dEVtL01MSnVCMWcrTFg4?=
 =?utf-8?B?MWJQcXI5ZTlDY09INmVicWRjRUdlemxrb1A1RVdmQXdpZm5QZjM5QXJUUVd4?=
 =?utf-8?B?TXdWczNHQTVscUtjaGJKWm9Bak1GR1BrTEFJbE0vbHFLckp1M0NRVDFFYnNO?=
 =?utf-8?B?c1JMNDBnN01XYWlWakRDeGUrNXhpY0Uwc3BlY0xMeDhlbU9rYVZVU3ZJeFdP?=
 =?utf-8?B?dDhZcW9hYWIxVzgrRXBUUVhnMkszZ1YwVEhydjhMdm1LY2FvdWJOZGJ1WUVV?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bcdbc4-1d5f-438e-fe7b-08dd6acf41b6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:27:35.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFtlPtwJeLOju1p6YC4+x7aY8bb6SVE7Xv/FO/V61FY/fZXw+xJog/GWYzj7Pz37E82OrvzgN9h3TzpAtwLJV4YhVqPfYY/PNp6pUmtyzqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10900
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

Hi Marek,

On 3/22/25 10:55 PM, Marek Vasut wrote:
> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
