Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDD5C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 11:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF7880107;
	Mon, 17 Mar 2025 12:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IuB/Bxzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2105980F4C; Mon, 17 Mar 2025 12:10:11 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D959800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 12:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utk+SkPyfxgs2mAO9DO9E5mnmIguHvkqDqk4L8k9WNLUrcAHAUEDos2MnaQEAStrL9VBdTogYNl/Rf5ZJ1G/OzIeFohnrzvaq28PLZoQ7BzBKan9Y0HsfgOSYzj2C+szdtbnxg3hCQEutAZicctXG+FiqElptyHvW3A1THLekBbkEDkT+Sp4v9qAAMq/SdxgAkCi2XnkVsYLPSd8fEjIEgFPFDFNiChNLeKn9MNtLqfaS/6LDwQY7aFwwS96+1w9KZ/t9XQv1BelEuDVntpdwx8t9vMEPbrsE9JeiIDGWXlAM4/DTvPQJ9YETrRTB4eO4t06uoyAx/IV0BVxeNHp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x23eYA9LWcljrauMKQEKMmdCY/sxQXKIvdaPrRsP+nw=;
 b=a+xIfpL+xcfmd19HSpfJS+LC2VCU73EwH5MdnYw0EvIplHWtv2Gnmmj1WSaKYb6mA3N6N91M+V0SkBfIqH3N8n8See+Z+4W1ZoI23l7osKV95PRoX5YCLbH3d7r5IpdkjleYduK2sYHSLLHOd2eumF0c+YDWcs1BDfBZ8uWSfQ5FHfU/YSmF9igi8NHyvF67eohbeoEv2VH8AjHqiie8IVkNk7IYoFww6ZY0IGeRhJS6OderfBw96p8HGBhykCwLn/0ztIK3ciA0RixEOELk4db0GtvEmI53k0AVrA9aruvsYiQJzz5TuQmp9lt7q6MonkTtgV9x7NITFNEDbWMMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x23eYA9LWcljrauMKQEKMmdCY/sxQXKIvdaPrRsP+nw=;
 b=IuB/BxzyzYG8gvqNoyRvUxfBQ6f5Ewnzaavr9lUVjAGoo5eG/fQ9NwyRbBQ32alLRx9tkkod38p9OpYPyTU2MiswdvorFPLMXq82EwcA38hNDD5txEYC4E/b/ywkWp32MAi4qMCo86UBu2MaOVNmsdy0/KUUC1nGa5T1pgA46V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:10:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:10:05 +0000
Message-ID: <a872429d-7ba5-4936-b496-c80af4444d4e@cherry.de>
Date: Mon, 17 Mar 2025 12:10:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx8qxp: Do not use CONFIG_XPL_BUILD in device tree
To: Fabio Estevam <festevam@gmail.com>, Hendrik Donner <hd@os-cillation.de>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
 <20250314200832.154758-1-hd@os-cillation.de>
 <20250314200832.154758-2-hd@os-cillation.de>
 <CAOMZO5BEhVGq7JGOcL_hsNAe8Qf84tKkFY1_+mm18dk7842p3g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOMZO5BEhVGq7JGOcL_hsNAe8Qf84tKkFY1_+mm18dk7842p3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 400ea78d-6c1c-4773-02d5-08dd6544457e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFNzT3h5RWVHalBtRzlVY2xKUnZDRjdkZEU1VlpGNDFtWVFiSzhNYStkVG1j?=
 =?utf-8?B?VUF3NHNNdjRORVFScVJJeXNob0ZadCtIaTdxdE1oVi91SVVCcllWSjg3R3p0?=
 =?utf-8?B?eElsRzBGQU41ZmIxdG5XcjY4QThSVzQzbDJzS1RNQnZ6VmdPZFVYdWM4RGRS?=
 =?utf-8?B?bGY1L0N6RXNvcVZzS3RSVXh0UjM2VFpWT0x5V3RxSWF5VExFTHJZY29wbEdk?=
 =?utf-8?B?M0xJeWJTMGkxS01XemQ1MERTL3ZPTmhvYi9WbnpIaVhZbVhReXJQMWJZN2Q2?=
 =?utf-8?B?c3VhUmtEaFBMSCtjSGh0alU0MmFwNUtCK2gxQzViSE83cjd0SldIa3c5SEs3?=
 =?utf-8?B?dUZpTlBDQlZLOXdZTWZYTHVyNGN5V1RyVWlqYVpnZ1BlcmRhakpScXp2VURy?=
 =?utf-8?B?OVJWdGNsQXczdk1DYUtPVW9iTUJ1eFJ2b09vRWdKZzNoV0hTZ0d4RFNDZElV?=
 =?utf-8?B?cnVwbTZaaXE3TU0rRDJpQ2cxUFI5U2JlaE92NkFPZGxxMTk4N0EycmljeGlR?=
 =?utf-8?B?RGVkV1hyTldwVjdkSXZKclNvQ0VrQ3BjSmdWZ0NIN1djZWtTRXkwektFbm9h?=
 =?utf-8?B?OGRZWVdxREx6M00rYVhmdFVLeC9YWG56c1VVRGpUTmFtcEsrSnl6bExFYlVQ?=
 =?utf-8?B?d1lzTkF0cVBIM3VIaHowZnVNNE5oRWpkRGJZVWFOYlNmcVBGNFF0OHk3SmNk?=
 =?utf-8?B?cTNWbzdzcjZtZm1RbFBZUlBBTXh3aWM2NEw1c000T1FCTEpyYTMrbld6UmJV?=
 =?utf-8?B?L1QraHMram9zMS9mOUpkV0pBcXV3TW8rWU5YeThORGcxeTFvWjFGWnJGODkr?=
 =?utf-8?B?VlRBRGRrMS9haVY4T2FmUDkzUDhtWEwrYkpGZk1ZOTU1dEFqNXRIUUU3T1gr?=
 =?utf-8?B?SW5lK2IrYW9iNzVzSHl2S3U0aU55eHV2dWgxejB3d2N6czIweHNYaVhPUnMx?=
 =?utf-8?B?b3YxUmdyak84WG5mNXJONHpVVEt0MXo1RndvV1gwN1huNnRTZ2M2dDA2M1I1?=
 =?utf-8?B?cU44akxpMVJVY090VTNvM2xRSkVFVC9HbmluM1kwdDZxRGRZb3k4aDVNZk5q?=
 =?utf-8?B?OHNhUWkxNjg3ekYyYU4rWkwwZy9BOSt0Rk0zWldwQlZwOEd3NzJmaEttOFRL?=
 =?utf-8?B?VjZZcmZrUHkvTmtaNzdVaUNOR1oyLzdsTEFvVDVLVHp4bUYyR002Vzg0U3lH?=
 =?utf-8?B?dlJpUzBLQStFVVQ3a0k4aTRyOHJ1aEMvS0JkalFWT1I5MDVUNG5td1Nabm9W?=
 =?utf-8?B?dnZkb3RPem8yWUtvc2JSQmVObjZtcVovTHJ5MUZ5Um5SYXZuQUJkUzFJVmU3?=
 =?utf-8?B?bk9RSkg5ZkhxUUIrQWU1SkJYeFV3ZFlRUkovT3hnajl4TkUvOTBYUS9pYjFY?=
 =?utf-8?B?T2tIbnFZMHNnSk9jam81VU1EWVhRYzVzVlVjU3ZvWjUwV0RTNHZ0bFVsYUFT?=
 =?utf-8?B?anpOaWtyaDBEcmthWVNuYW5JLzZ2WHpKNjBRRFMrV1FiQnNVUlhuUnRmZG9I?=
 =?utf-8?B?UTJuY29KOFoxbDNTQk4xR2w3WWpyb2NWSlVXWmtQNkNlaTZnanBRc0c1bTFU?=
 =?utf-8?B?cHY4bmJNZHgrWTFwcjZUaGxNMFQ4NVZsazlCTWZGa0M4QnNIMEFPOXVwTEUr?=
 =?utf-8?B?THpiUkFuQ0J0dUdiMFlhUHRnbjJYalZzSHpWVkU3czloNVdVaDhrSUhHRVln?=
 =?utf-8?B?WDUzOFVaYnc4bmo5bVB0OE5sb3NDbDJXZUNXNXdvQWpSYUxaNUVXQWd1Zm5O?=
 =?utf-8?B?c0YxS0ppL3Z0MjhVcWlsSzJLRVNMODZ6WWU3aGNjOU5sSXNCSkJmY244WGw1?=
 =?utf-8?B?eGxmTi8yaVZvYllFN3Z3eWpaeDlNWE5uRUlCQjlwanIrMUlIb29WWnhBaVZz?=
 =?utf-8?Q?XS8+pE60eqZNZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFXS3FueGJDL0FpRmdtU1BsNm1IaGdLeFZSeVVqem5qV3RNM2dPUWxDYWZw?=
 =?utf-8?B?a3laRU56Y2FRMGs0YVB1N3hjSWxPSkFrTGxtTjRnSktaak1STXBkRE5rRk1G?=
 =?utf-8?B?T0l3QUFMRG5mcXM4QUM1Z2RqVjVaV2V1WkFDbnhxVHBnYzQ1QkJkeXk2NnlX?=
 =?utf-8?B?TGdsa05sTnUxdnVIc0EzbVdaQkJDVWlLQk9JTDRYanZ5V3hkMk5kenpQY1E1?=
 =?utf-8?B?ajRIWTZtc3RZeXhXS2lpY2FjbURNOW96cDlJSlprOFlZcFRiSllodWpsZmtK?=
 =?utf-8?B?M3JyRyt6bkJtQkpQaGNQSEdRT29STTlJd2hMK3RyVitMeXlWWHZSMDVGZjlL?=
 =?utf-8?B?cFlMaklDOVc2ZjVua1dvSTQ5RlJhRGkyeHJuMERIZjgzRGQ5QTZhOGw4RDNS?=
 =?utf-8?B?ak12RC9jcWJWeXEySW80Tmp5SC9ackNTZ0psSC9tbWo3cm5od2djUkN3K05n?=
 =?utf-8?B?SlI4Q0dTMU05YU1YdUNVbW90WUJsenpyYlNNaGNuQTZWREEwaVJsSDdnaVFL?=
 =?utf-8?B?V09heVNmeUNBM1d4Z2REN3Fpb3lmMGdvRll0QXcxVlU2QklqanlWRHlYMita?=
 =?utf-8?B?UjBpL2IySGJYV2VBOHpJek9DbVNRSndOWWlRb1hIT3Ixb2V5N1NFSERMYkUv?=
 =?utf-8?B?dGpLUm1BQXdmanVxck5xNmRzZFU5VlRocUxSTzJXZDNPejVGdEQwSzB0dlNa?=
 =?utf-8?B?d2dwVFFIcGZpNy85cERURjVqQUZJa3ViZFRzZjRzTlMzejNTbWVpTy81eWJm?=
 =?utf-8?B?RGUxRVIyZFdseEkzZ0pmcjBNNVpCelJ1aDFncUw5NGpqNDZkMko4akxVSVdF?=
 =?utf-8?B?QUxQZmhhNHk5UVBvVlRjbzV5Y2FCS0h0OURHNm1LRTdNUnk4ZDhEbk01VEJX?=
 =?utf-8?B?TGhjcW1aQ2QrM0ZiYkV5UTZSRzlydmpPNGlZUmxxTWllVmRkTGNPM3YyVWRC?=
 =?utf-8?B?Unc0MENBSk03bkRjTnZlODR1azhENWFtR0FucTczNmJ3R1B0SGdWU2o2ejEy?=
 =?utf-8?B?RXVCRkZwOVViWFh6OVBOeGgzelRENElhVU1qb0d1ckV6NXJJYlRIUkE0MTNq?=
 =?utf-8?B?MEdyUVYrb0tEWk5wZ3pVSW9HdW5XMkVycHJERG1HbTRWRDJUVEhubTdBK0Nu?=
 =?utf-8?B?V3ZUblZqczRHellRaURidTNZQVNjYVBlTmYrV0U4U3paUDNNcE8vRWhodnJP?=
 =?utf-8?B?R2F1ZDQ3QUMxZlR4Q0g1YTFRVy81U1dkWEVOSktkTUVFejQ0Sk5IRXR6bVhr?=
 =?utf-8?B?d3pFcHhKTTJVTm51K0NudjZRdjU5dGxneVZQZCsrZWdUZ3lBbDQ2dUFzVW50?=
 =?utf-8?B?SFRndXBjcGJrelNnUEVzRjZrcXp4aS9xN0VTK3BZTWRkSlNLYjFiVkNsOGY3?=
 =?utf-8?B?aXRNanRnNThHRTRlaklwbDRqTjZ5QWhNTFdneWRDenA3OWRwWlhQQ3lnRjli?=
 =?utf-8?B?SUlrdlVPcnZpbndWakZuTGtLNXhQOGpUc3QzVlJHbHVIYzJGb2psYno4Ync4?=
 =?utf-8?B?Z2VXT0RSeFoycGQwS0dkS1MrYktIN0c5ajFLVnJ4c0xEN0g2LzYyaFVaZlNF?=
 =?utf-8?B?ZU1VcTdJc09lL3p3WE52amlhREFYTW5sY05INDFnbnZZdGkzdHM5RjJpVS9x?=
 =?utf-8?B?MkxqaXh5VkRhQVJhYkRHWkQ2NE10Q3hqaVVBNFJXdzlMaUhKazF2L0QyV29n?=
 =?utf-8?B?UUVIU2xPa1cwakxtcXRuRGJKZ1MyeGVaY1pxWnhZamFyV1RkRmZ5WkZ3NndL?=
 =?utf-8?B?bkhjWnZxdk9YNjgwbWc0cXBwWDAyWVYyeHJ3bm1KUGJRNW4vM1FJS0cwZXFI?=
 =?utf-8?B?SGpIOHJLdHdTa0VadTFQZTE3bmE0REFlemNIbnlkbW5BTHgvWEUxMDFDOW0r?=
 =?utf-8?B?MWptNDBZbE90QnprbW9ONUg5bElobVhSTmR3OVFQV2FGc2drT1JQbDdXUE54?=
 =?utf-8?B?blUyL1JOZEdYSnoxdkhwQnhkR3BZL1dLWi9aNlczTGMwOWNLaHVNdlJmZGFJ?=
 =?utf-8?B?bk9lY0tieSthNFVKcksvZWYvVkpNb1ZzZnVWMXlOVWdWVi9xS1JvN0lLZDQ0?=
 =?utf-8?B?WkFUYTZMWkM0RGUvRVV4SG83czVEMmFiZlE4ajE1ZFBlQXJmNitIbElPU3No?=
 =?utf-8?B?M3dSUWRlV2c0bWlDa1FENFI3MlY1Qkh4VDBXOHNvSzBzSlRlV1FZTEUzeXc1?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 400ea78d-6c1c-4773-02d5-08dd6544457e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:10:05.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40lsbFBjoITfJ8DaKxkpZVen4RCWAPrJpI1sVvPQ6ZY2UdN6v33LqXglKn9CoMLlh700AUJZtPIcyfVs+22amr/6e/s/JjSv18YbsODprKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738
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

Hi Fabio,

On 3/15/25 12:58 PM, Fabio Estevam wrote:
> Hi Hendrik,
> 
> On Fri, Mar 14, 2025 at 5:09 PM Hendrik Donner <hd@os-cillation.de> wrote:
>>
>> In c9713c155127 the device tree was moved
>> from CONFIG_SPL to CONFIG_SPL_BUILD and later to CONFIG_XPL_BUILD, but
>> the CONFIG_xPL_BUILD defines are never set for device trees, breaking
>> the build. Move the guards back to CONFIG_SPL.
> 
> Please provide details about the "breaking the build". Which target

The nodes will simply never be added, because CONFIG_XPL_BUILD (or 
CONFIG_SPL_BUILD) simply aren't passed to dtc.

So essentially, this is equivalent to dead/noop code.

> fails to build currently?
> 
> After applying this series, the previous build failures return:
> 

Yes, it was never fixed, just silenced by never building it.

See 
https://lore.kernel.org/u-boot/2849ff05-ef67-4471-aece-422daa57040f@cherry.de/

Cheers,
Quentin
