Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C98EC144C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048F583E7F;
	Tue,  3 Mar 2026 15:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gka/ZFSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F2683EBA; Tue,  3 Mar 2026 15:04:13 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BBFA838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKMfTIwxwzNjcNkREhmnAwAuuTXpyPbrJCIylD7EhIzGJPsx63jPwWABgpTJJhtRJobo6LqiSRLg7MVjs4z1xGab+IGdc+vTgZ9gSNC0M6Ev89tLk9EEzHTyxTpbXfKDg6G2HV9HgyJt5O0R+tIFP3MPRaPna5m6wYBcqZ7uu6C7mXTUtHgzeSWIxO1C8Du2mriM2hXA6vtRpCcQNsxomIR4+b84Mk79rGbVBgQxzNObKAiTi6PRSZ+uKDAWvKh15QukSN/OB0eqK363Zq1yJeF8d/+d+KAM+DXK57jMkALRdSAta3hhN353jEW9YYbnol9iYDF025KxV5v+VvKFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDcdO/sD0jSEKnvw/Jxb8W8eViRyiwasjNA5T8cTeQI=;
 b=oR3UXm60v7Fq5EpcKuaIZSRPu1bLcC0lxW1SiKl5URCrxk2buseoCgMF1kqixgejoI/kJypjXG6Hn0zx5YwnfmR6onsfZMg0INJ82HbJWu7tn9NsLMHWiP/wS6QyVRdfeT18pavo7jBozKTqFxyOWxvn+PkQyCD1aiF3FFzTzZScZDNZB+9haeKCXokyDHUNfhMtOz1F8m8xqSYUi4Y3SSSNEk8f2pR/OX2qfXdawGOQ7h5jStKJhqHDvI6EbmZzr2kOW78HPnW3/T+oRwTmTe0ro5/owdDM5Lsd4gWak2rktORzUFN92UJacEzT5fXshw02wizQYGV33IKkqH8Tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDcdO/sD0jSEKnvw/Jxb8W8eViRyiwasjNA5T8cTeQI=;
 b=gka/ZFSQY6jeieVegQeG1+xBfHHpY3vOEvQcblK1Lumuiq1Gy3KYA7bqNtUzD5VKDWqZ+t6aCSMHOmPQgFOYSmDAV372Hpt+TQTU7CPlXJ8R0KsrXuHMqs/U49e5KR3bnYlDp/cBpD3Zc2hxaYAhUl2H7OZwY4fgEsxOfoeubMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:04:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:04:08 +0000
Message-ID: <2182e977-3a74-4b94-afc7-3890aa129a3f@cherry.de>
Date: Tue, 3 Mar 2026 15:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/16] binman: test: Move blob test files to test/blob/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-7-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e1e101-1285-42c8-5c1c-08de792dbcde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: zXB+JUJTn0x98xvkfcDfAeor0jWzzICwkM7siyfqPsuJdp1lu8eRziEpX5rfBz0mLls0O8C30yiZj54QM5773414znlbHjUFRZKhKa3G7yh7brKajRF8gD0GJaxpzt/pux633H6+NTNuPyOLsneabXZKF3SQEAeWvBKH5eoj1YnKLo0HBX6svjyqYG5PG7w7iBokEfFo6eoFbF2hdFczrl6WT41+6OdfpEFJOQZfmYBFWY+hYP58aQb894qee5ZMDdELoqsokcm68RWeultHgrzYYHpULQZACaUGXgrcno8R0k0S0+2eShsxoHiwaZAN31LDdS7iBOyBOhYukrSwd6izki640aH+dD73f4/S0fdpWFIOPLQ5ELYTIbR6xYNd24ORCcnDpOQv+zZD0xWDRPrZL52GyXYRfQEPJtiuUChMvGzTCcfKdjFGCQLVE9h3ZxMQPF3F/vh9+4RgHz4DJ6Al/lUPu0aQ9x+Nj7QIpaXhvhPgZ4Z0wnfpOM2modc1MaPyZRWk4PqitW4k9Qzt9rn5xFOYJDtxTirRIezSWEVJD5BQM7Zm6vgocTZ/qUeWSdt9bQfYnqCI1r+9TlEGPC0EgA6eOGlrFfVb0LQWGFnYWkfP7nmD/g9NM6DGVg1Ibw6E5jTKtOg5OTEV414LNbDRbyYt1x2dNl4LhNmEktIXW7c2SG8+WAWzgppdjkp18o7LhT9ssSg15Bx4vxuVqGhVjZzArP8ygG0qjBwv3Fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFDN0RWUHRFMFVXT21kUTBOdHQreG1GOUVTdTkxOTNaR1RYcmhRZGxnRXVy?=
 =?utf-8?B?V1FFeE1FOHZmUjdNUSs5ZFVVdHkrK0JPeU1yeHJWWTVYMFdpVTgvaFZ4S1Z5?=
 =?utf-8?B?eG5CcVFqUG5oMUxuRlU1eTRYcThyYkFpTVlrRFJOM0R1VGNkZVJGMVkrUUJM?=
 =?utf-8?B?RjBTR1ptWDRkUjRLS3FuaXV0d1dWQnV3YVYyNmdhaStWUnFaNW9uWmwreVJp?=
 =?utf-8?B?L1FvNU10bngxYU1PTEJkcVNLc2xxM2o2YU90VWY3YlZhL0oybjZydUtkbkVT?=
 =?utf-8?B?VWZaQkxZR1U3VTY0MWh5MHlDYVo0aWZYRUZnMVNzdlZET3k1R2dFeDgvL1Fl?=
 =?utf-8?B?T3h0dEJ5ZVJaSytXalJxUUQ5UzlPZE1Nd0xXcjVKQy9uMmZ1bWJnVVNzaHRJ?=
 =?utf-8?B?bXhGWGllbFpXd290VjY2QnVaS0UyQ0lXTlJhc0xHN1VuVkREenFNUjhxV2hN?=
 =?utf-8?B?Nm14Q3JrZnBrRzcxamoyZnpLejZxZVJ0THpaVkg4WjdKMWVLN1c3TTlrZUJT?=
 =?utf-8?B?Mm05RVdRZmtNdEtObENlNzZBYW5VbnYrOFpuNGs2ZnpmZ0lwdGZNZUpuNFB0?=
 =?utf-8?B?Nm5MMnBMbzYzNkYvSEJ6R0Q2SStOSnU0SnE3U2tGb3ZoMjRqakF2SGxFY2RE?=
 =?utf-8?B?VVZXeVpaZ1BQVkI5a1pFYThvLzN6MzAzOUZzcGUyNy9uaVRUN0V1clczMlhj?=
 =?utf-8?B?QnJtTk9FRW5IdWsrMkRjc2tSM081L01MbXZBQ1NDMEduemkrZnpkUkNad0xJ?=
 =?utf-8?B?S0I5MDNUU0xneHpFMEYwcWdTRGwzUzNqTTN2SnA5YzRoRXBmNTE5WTBuYmk3?=
 =?utf-8?B?bkgzMHFjbUtNRmkxaFl1Vkt6UkdtZVJWUXR1bDhZSUt4cnowSVNYd2FRei9x?=
 =?utf-8?B?TSs1ZGJueXYyUEpiUXZ6dzNRVWtTVHYvaXdvUTdrSlV2QnptVFl5Q00wcHVk?=
 =?utf-8?B?Y1UrWFBSbkIvSVZ0L2Z3N2laUEVCaDFOaFhxWXI4Zlc3akZ3UnoySWgwUW5j?=
 =?utf-8?B?ekEvMUU4QUZZUjhFNDViL3ZISlRDN1E0akprY1Q0bkF3SmZRZGowcnpOSExx?=
 =?utf-8?B?N3NjZDYrbW5KS3pZaU1Hb1UwQmkvN0hRakJWWGZZZy8zQ3c4N3IxNUM5QU9N?=
 =?utf-8?B?amVHVkRCWUZMU2ZTQjV3YVlpMlFsdkNBdHMycUJYV1doR1BZKzI5RXViK0FT?=
 =?utf-8?B?ZytSaW5GZEFZOHZXM3BsbnRPdXo2bytVYzYzT3V2cm9Nc3FwNGRnc3hhZGNi?=
 =?utf-8?B?Zmo3ZU4rcGtPVi9qOTgzR0JkdG14OS9MV1ZYQkkwU2xMQThMMlh2MFdRaGFO?=
 =?utf-8?B?cExxTDY5M0hoeEJPcmxRbUNlb1V3M3l5bWlVTTl5anRnQ1o2Sjgwd1d0OUEz?=
 =?utf-8?B?TjAyVWVMQUVYbmdld1l6aGFwajhWMXdrYzZvQm1rMGs1cDUxSzZ5My8vUjJB?=
 =?utf-8?B?TjlXazlkYzVPYTkxa0xFTXR2S1MyUEZaclJzaW1TVW9ZNUhmL3VUQTFMRVg1?=
 =?utf-8?B?QWYrZDR5QzNWU01vdmI2cktORHp0U1BVeDFYTEQ2dDhUNlpBVXI2US9OWDEv?=
 =?utf-8?B?TVZka2J6VzM3OHpKTTUwQUhKakNWd29NZGZFbDNVRVpHd2psOG82WksvaytR?=
 =?utf-8?B?Yms5NjgraHk5Wk1iWWVESnNaK2JuL0FlVGVhRTBrbDQwckhzTkVsaUxld0p5?=
 =?utf-8?B?alR0d2ViV0ZOUStBRk8rS0lsdDhOZEpGeVpBZWJZSURZaU1HNkMxdHMvRkRk?=
 =?utf-8?B?UHVWMzliWWpjM1ZPbWtnd3VUYjRQcnZKQjNxcExmTFNGODdRd2Z0UkI2V1A5?=
 =?utf-8?B?bFZqMWF3TnFZTEZQV3FlY2dkYjNaV3h3VjZjSjF0eit2RVVLTVVTd2oxNlpO?=
 =?utf-8?B?c0pzZzBGWWFwMFJsM1U5K1BPdEpuT0JXUEx6enZteE9uNkp5WkJtUldMR0pO?=
 =?utf-8?B?L2l4NWZ4bUZ6blk3UjlhN2hQRjFZQlQzM3BoY0NVSFlBVG5rdnZDTjREcS9L?=
 =?utf-8?B?UmNEMkVubWc2MzFEeElpc1RSRlNPMCtpcjhXU2U2VnhxSzljV2gvOXVEdXE4?=
 =?utf-8?B?Y2kyeFpTeERWUy82OG0wbEM0VXNYVTRKUlJmU2JvNUFvS2ZDdENhdHNOQlVh?=
 =?utf-8?B?OWhsNWt0ZlA2aEw2dzI5RStKaXNJWmxlVjZHZDRHbHljUk1GSDIrL2kzRjZ1?=
 =?utf-8?B?dXBSNnZNZXYxWUhXdHRXcUlEZzdhd280d2lUaDN6WWRPMGhUQ2VGdmdPUFA0?=
 =?utf-8?B?aHdiYUpSTWlPd3ovNFplK3c3SEFMcUMxbnQwQkpoYlltN0ZXcVF4NDhwdVc5?=
 =?utf-8?B?N1R3bDBkdDlTZTljNHJLRzF6d0RoNFBpVFFnZHM5T3EwZURLRlpnZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1e101-1285-42c8-5c1c-08de792dbcde
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:04:08.4443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJN8ain7D6EhmXmlqqn8to0SdaucEwgnehGqmRSKw+rkbYrBXZkRy/5UOLNR2Uvv1Ci3lnp1sgfI89/+Mu0vteFbaoYEb3DCzW8Ai6qEoiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about a dozen test files for blob, blob-ext, blob-ext-list,
> fake-blob, and blob-symbol entries into a blob/ subdirectory. Drop
> the numeric prefixes and the redundant blob_ filename prefix, and
> update all references.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
