Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A7BCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 16:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CF283678;
	Fri, 24 Oct 2025 18:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H92lhEPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E697836B2; Fri, 24 Oct 2025 18:47:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240F483655
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLcKM72oPVeTnMKhu3Ii3Pu+uNWNJkmHTUm3KARqfgPhDxw/tBGGvNljCX3HEKyE3zqpQY8NVmsMCkVNwtAzSyRa7ip+b/qtta8aiST/+Ez5hI0+zFTeSFS469W1ekmnIG7nVLS1vJIPHEuiBWk5aKVRJ2tJWuxpIeXzqwsi5G510zCyZv/BRxI3GvDGYVBwTLh4hwnKUvYpivPMrv1T6w1Yy4MJ8a2ipBLQJ7aoKQwzBd9qukyc+wgeltcDE6YY3fI7ZLj5mIdd81wXlRFsisbtgz1y26qjHuVAqIwWh3xRhto6c3L3cBR8LwkCsIXrFylfbEwxRhXUMRChmoLVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxHXHFmUANjpPHnCW4ZYuUTMY53cs0IkF9zcZAarxNk=;
 b=jGyTwq/7fJvNvzxmgO/ns2RWFQ5jo8bZl2RGSjrnuHi+VGwNwMO28HuQx8iVMzwZ6p5uEk6DGfd3hBHP0V9ioVRyuQaeVlf1+D0kVHLKxSTMPBtMVhDmUmGUVtMNrD4piJq9BkqtTqnXLE2qFUAvlDl3qGgYrH3oE/mYjqYe/KclNx5E5Hrfe58L5ywhU1ak0qG+YyY1bX9DRymmIsgebfiOS4m+wIJmVuCXkjW9SmPZep0dhrfMOaILLlYyklE2l9FZQ3pRSx1bjRSlBopojm/fF/ZavDPnzeSzzvMKnj6uXLlTIgpDbwU2mClWeGoPPksgNvaQ1S72LWTbPD6Plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxHXHFmUANjpPHnCW4ZYuUTMY53cs0IkF9zcZAarxNk=;
 b=H92lhEPAVDZDc7InA32Jt9U5uKMjEWXTWq9upQ+eUYP9U3QPnh3DT5JlRk+tTA8xx7DXaKqzQViTUzr4AW0pJuf6C76HPQOC1eYxopA1Jml2qtxyn5cU0BqnI4Ym819TiQD3X/VCq7sfsPeSMRtBBktwQaxRSIsx9Lgd5M9pqjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Fri, 24 Oct
 2025 16:47:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:47:46 +0000
Message-ID: <b79c4e53-e7f7-47bd-9134-4943ef2e5138@cherry.de>
Date: Fri, 24 Oct 2025 18:47:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] doc: usage: Add general rule for `$?`
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251024160557.2317081-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de6902f-343f-4b45-5ad2-08de131d0f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGhIcmNpN1hQb1gxcTY0RzRjeDV2QkwwdHFhbUpFdFlLb1dtdkdTY1FpWXIw?=
 =?utf-8?B?Q1gwMjBISEpaRFJxaS9xMmx3ajlTcXh6TkFDSVBKM1ZhT2x0WU91MlVFY3Fn?=
 =?utf-8?B?SG0vdmlFUDNqQkdiR1E2QlNrWmhlL2ZjTkJkanUwV055eWRhK3pJaWhYZjNV?=
 =?utf-8?B?M3FuWHF2MnF0TDExQnNLOGVLZlpwVFpOYk9STnJoU0FzdGN3QnZHSFJvR1N2?=
 =?utf-8?B?WjlKeXVWbmpxaXo4Ukw2aHNaTTIyNnNtM1FUaEtleXliTHJENDRnWmY5elNi?=
 =?utf-8?B?TTlYZFVPcHM3T2U0Vm9FemdsTFkyMFRuQzJONi9PM09XdGpwL1pqKzc1ZG9p?=
 =?utf-8?B?TC92VXU3V2dLZXord3VCemJZb3JlME8vRFJQK2w4VUsxMWE4YTNtZ2lrVlNv?=
 =?utf-8?B?Q2FmSWRyMExMWHpKanhYMnBhWllOYkZPSkpiT3BBbGhpQm5zZnZxRGJybjdv?=
 =?utf-8?B?cVFWb2pZSW1Hdnk1SFdTdDhsd25rRnJzUXJyUCtCV0VKVStaTnVsWmhhalBk?=
 =?utf-8?B?TkU2a2ZMSURXOUF1L1JraVE2eS8zL0FjNHB3NEZQRGppa0hXa3VMZVBaR2Rw?=
 =?utf-8?B?d1doKzh3T3laeTkxR3d4VGFlZ3EwMHdZNS96THRGZHJXOVIrd2dZQ1oxTW55?=
 =?utf-8?B?WkJGcDRaakhkN2NuWFF5aSs5eEtHdytvbCt5WFp4U1RpVDFiUGhQTU45V2Na?=
 =?utf-8?B?RFdna1g4NFRtMFNJeDVJbDR3TlY5WUZDY2d1MFJEYUl0eGlWYnFDZEZ6ZFho?=
 =?utf-8?B?eVl0bXcyQm5LeUNJOVdlSndBYTV5a3JidHRoMUx1OHJqSmNQeU8rRGNvUzdq?=
 =?utf-8?B?WUZkNE1HL3VVL3JyRDR6YkExR0t3YWlzd3AxV0JRMFVtd3NPYU82RXk5b1Ew?=
 =?utf-8?B?YmlnRDA1c0FORDNTbDdma2xjV2M0MS9ML2ZCb2xKc2plUWIvU1hwQXpRWk82?=
 =?utf-8?B?VE9WZU1ISjNPbTU3ZFBibzR5QlBGMDNqV0w4T0xnVDFTRVVhaTZQL0wwam9R?=
 =?utf-8?B?RHE4cHRiWlhYN2RCdWh4c1h6VGI2cW90R0plZXlnSU9BNXdGM0RRWHhQK1VJ?=
 =?utf-8?B?blZJVmxlT1hORlBPUWlPRFZWQWpRVERjVkpKZFlubzNZM2M0a2RzR2N1Q01k?=
 =?utf-8?B?SXJrM0FXMlBERzNVZ2UzOENDT2hGcHJycGNmTzZJSjA4U0pLaDczVmdLZzN0?=
 =?utf-8?B?VWdldjc1U2NiOFFrNlRaVDdBbTlIdi9la0RXb0xZSjlPdHhRcTRaQWx4L3NB?=
 =?utf-8?B?MWZ2TEYxYjA4NUVjN3E1T25PL0hyMXh6WDJMUnF3QkVVOXlIR1BVWTVBd0Zo?=
 =?utf-8?B?cG9TWW1yRGFrM1FNcWdnT1VxTFRSZVdscHlJalNaYkZTb1dSbzNxU0d5SHdZ?=
 =?utf-8?B?QVp5TjRQVWttbzZDZkpqRHl4RkQ3c0MyVWV1cFZCd3NsZkNudVVYS0h3UFhk?=
 =?utf-8?B?YU56UUFKU2psVWcxV0dRT3pKaks0a3JaN1RFVjlHN1ZBRWtRa0hhMjFwWEI2?=
 =?utf-8?B?Nk95TE90a0FseFoyQXNyQzBQbnoxUTNDVU9JQm45azU2SEF5QjYxaEdmajJN?=
 =?utf-8?B?M1VjMU9NZzgrVlhNakhaRWtiMVAwejZkTytjcDdabUYrNVNDOUJ5dDR6SFA0?=
 =?utf-8?B?NVJJcktTODFuY1NTS0pXUnFkTXlybXN6Zk9kQWk0eHI1cUhUNGdOL2tkRkZj?=
 =?utf-8?B?ekJReVdpYnM3SlZSeTN4SlE4OXprQWxlSHNRQ2lndzVHQVJoK2U5c0t5dDZL?=
 =?utf-8?B?eG1sc0s3eEZ1NndaMGl0amFmTnpnUnl3N1c1M2Ftc09ZM04vSW1Tcjkwc2g2?=
 =?utf-8?B?cU5VZEd3UU9qR0IwcFVNT0pqYTRuRjVDRTh2QlppQWphMStGNFZJMjlieHpF?=
 =?utf-8?B?c2ozSGxjWXNibkgyWm1iT0g5OUJad0JuYmtLRENlbW9oVytMbmpDbWtDdUxl?=
 =?utf-8?Q?5TeIhlevqX/pH+gvjNTOchVO50zdB4g+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhDT2s2SndZQWxOT212czVGMkxETk1hcmRnbFBYcnBISzAxUFJmak1CK0xB?=
 =?utf-8?B?YTcvSDcxbmlnUXVZRDNLeWQxM0trVGIrdXRTaEd4ZjN6bzV6YW5Ed1pmbGlt?=
 =?utf-8?B?bzBhWDZxcFZkL2NOaEtyN3dDUVNNUDd2L1FaWUt0RzJ5c2t1a0Q5cXVZY0JT?=
 =?utf-8?B?U0xRYnI2NFJPUVVKS3llUjZJdkcyZ2FTRmozRGdwYVFRaHIzeFBzOU1QWW5t?=
 =?utf-8?B?cjhva2FJV3N1SWZmWWwvRGhsTC9MRFhLSS9nOTlBWEtkK2I5S0UzRU5VRUFS?=
 =?utf-8?B?UlNLc2NkVFJTV0FYSDNwTjdlV1l0VC90NkNUTDNVRlVQN0swVzA3Zm1jODlv?=
 =?utf-8?B?VUMzSTR5VVdhZ21mVEZseWZRR2d2NHkrQVoyRWN6bGlBVDJMa29lYzFXRjVw?=
 =?utf-8?B?RmhSV2NTZ21Wcm0xUzFSOXdnR3pZZnQ4TTZGRjhqMHc2ek1yWXpzV1JNcDQ0?=
 =?utf-8?B?UTZxM1VENmZkd0NmdnFUdCtDRzJtVEIwdHNSSVRaUDhtUUpUcXNxVFNPODF4?=
 =?utf-8?B?VWpPcHZUYWc5VnlqaXhHcVFLTngrK2xVVkVkYXNFWFV1aXBsVXgydzNFa253?=
 =?utf-8?B?NVhpMysxR3lLTG9xNmVJNjNwWVlta0RTNC84bU1PREE2Z2dJclB6bjhiby9O?=
 =?utf-8?B?enhsNWtMRDY2ZTVhRit0SkFCVjZiUzVTUzl2NjlPWnVqRFBtVUhDVElYNjh4?=
 =?utf-8?B?RmdJTnhMSlZBSUd5VG1ubEdheXdCdiswRU1MOS9ZK1pmaDBHelcxQXVNTk8r?=
 =?utf-8?B?dmQzRnRWZTM1ZVVkM1Fkc3BNKzVmTzdMS3BTVFVjeDhtYlZ3dEF3SFA1SmlK?=
 =?utf-8?B?K0hyQzFybHlERERnbzYwWTBHZCtFU0JEb3RjbWVqYVlEY0xpUnRZUkFJejB5?=
 =?utf-8?B?UTgvaERTK3BQRzV5RnEzTEZuaElPN0NhYW1LWmZrS0Z5VTJkUGV6ODdaeXU4?=
 =?utf-8?B?UGlUUmZBazRpZEp2OFZuK28xYi9UZUJLU0dqSEUwdHU4VVBoZkhKcjdpZFMv?=
 =?utf-8?B?dlF2aTJnTCthemZPbVFGYnJpQy9GQ3o1V2pKcnhXa3o1cjFVckRJWjZ0K2Q0?=
 =?utf-8?B?WkpjbDl2azU0Z0xzYldPNUpGaEFqNUxNSzBES3Y5eEJTcndkOHhBN3NhZ0lk?=
 =?utf-8?B?Q1ZIL09ZZXJwSkkxY2RRemV1OE8yL1ZQTi9LSmtHcUJ2VUdqTFdML0QvQVht?=
 =?utf-8?B?V0p5YTl5UnBSVTZvUi9aUWZ3dThUaFB2cS9RdG1EQjN1UmppaWl3QU5XdGsr?=
 =?utf-8?B?aFl2YUMzZTU3R3h6MFlsK21jL1JpNVJGaXpkcUl6MG9qbjI3TDV3dWRDdW54?=
 =?utf-8?B?Mzg4Tjd6NzFCUnNzMzFaWUJOV3E3Y1h6V1VndkZtbVNtWjBxSlFhL0Y0SHN3?=
 =?utf-8?B?aWkyTFhWUndTakpjUlZBTm9yWURXRUhOaEw3WXdNbnpjMzFqZmdIRzMyYVBi?=
 =?utf-8?B?Sm5SNXovbFg2aVRYL2RqRjc1anFUTDYwUFpFQWNpRWRlQzAzalZqK3Q4Y0M1?=
 =?utf-8?B?ekdqMURYdGZITVZ5d3U5bEVGeHJ1ZTRYTHdhSVFaVGRFSXJVeHA5MFdoK3lW?=
 =?utf-8?B?eEdSZ2krOFg2bS81blZQWENKL0dzZnZ2NFhZWnUrZFM3M1lCTFJHNk1YWVln?=
 =?utf-8?B?eXdrYUhRcUtabmpPZlRVbVRlcXdDOWVPa2xLV3crMGpZblpFc3ZhdE5kcnBs?=
 =?utf-8?B?ZThlc0R2NEJEVWtQM1AyR3RQSnBKN1d3OUtIVXRNNFU3WXQ2RE9xSzR6aG9s?=
 =?utf-8?B?VVhPTDdmeXRvTU5FRGRwZnNUNmtndWx6SXM3VzdFclFvZUh5WklGY3JJb1Ri?=
 =?utf-8?B?TFpxL0cwOG9HemR0aXY2SG4xRnRKdjF6anprV1kyUklJV0x3MTE0RVpyazdN?=
 =?utf-8?B?Rk82bXJ5WTJOeTlGclJrbjJNTVkyODZqcE05SEhGWUljTjI3NnlhdmRhUGtR?=
 =?utf-8?B?dmZVaUZzRE5jSXFSYnozZkphRFpSOXRlMUErYlgwbmtSNEo4WHZORlEvS2lx?=
 =?utf-8?B?TmtqR3V2cEtaV2pSeVlQMFdtSXJOYU1LckN6YytpVkdUaDJLRCt2WENZRFV3?=
 =?utf-8?B?NkFMbWFzWnRzTkIrMytibmM5U284aERpVis2ZTU2SXg1QUJUQitvbDh2TFJL?=
 =?utf-8?B?ZWpMNW96MFNCOC9sWUxuVzY1Z1pydU44V1FjQXJVL0ZWRnlHZkpZNmFEdnN1?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de6902f-343f-4b45-5ad2-08de131d0f13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:47:46.3419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE0TzbsdkGnP3x9bnTPg0zqnDQPYz5xWr3Mx9FYnm6efKihyeldnAk/WUAmEyHXmKgvbTIgXaOmbshorj08aOk0j8FwZcTnoRNaUvwyEz0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414
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

On 10/24/25 6:02 PM, Tom Rini wrote:
> For nearly all commands in U-Boot the '?' variable is handled the same
> way with 0 meaning success, 1 meaning any failure.  Explain this in the
> general rules section of the cmdline documentation (with a link to a
> counter example) and then remove the redundant wording from most
> commands. We retain a section about the return value in a number of
> places where we are doing something such as always returning a specific
> value or we have useful additional information to go along with the
> normal return codes.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Rewordings suggested by Quentin
> - After confirming that invalid syntax also always returns 1 and not -1,

For example cmd/scmi.c do_scmi_set_proto() can return CMD_RET_USAGE 
which is a -1 enum and the function returns an int, so I assume this 
would be propagated properly?

I don't have time today to check the cmd function call stack to see if 
it is, but this seems odd to me.

Cheers,
Quentin
