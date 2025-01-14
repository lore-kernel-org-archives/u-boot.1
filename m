Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A47C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8533D806D6;
	Tue, 14 Jan 2025 14:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V/g/4M5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56DA8022E; Tue, 14 Jan 2025 14:19:41 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872198022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTRBia25XN4aOYOHo15zcLWoOaFiAMskYQlArHatkuK8l/Paqx+TPIHVzO/KaCTCZDgiErEQZqauaoyw75tqh2ony6ao9hz1+hq0bf1z8rc0UkohKryDyO/XcBqIDiak7i7BxoLhu4ZuVLZdytQOls79wCkN82XUvuLmBDra86z8UiqP6mwSlZYetBXYLKURJt1cj74hzZFhLEID/5Fe07CZ1c37kNbI05rfSNwYZm5N/6XHF1eUasA4QYuTd6B7R6LrQMcQf05sTY3yIo37DIVR7tSJapTdXnid1uctGv3oICdrJ53IWy8zR45yBAeyAHVlUrw9fTGwafPfy3NcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TL7DpQl9JOmLeLi472jGip6P1y4DRFUWCXGVAXVIao=;
 b=dEFgex74K91nUkW/W/4Ndpr4MVIuEZTV105iQbBEOlRK4y12aXpcA6m+EcUR6QPIXvpndmC0s3gCqOVGEWka8uW7O5HPuJxuge9Itxk1xhTCpmgWzwgkDVy5Mm9VweHoCYmgjJqES+v9h16pLJVT3jca/W7ImgvGH6pQiwfJg8OK5JxtZ3/sky+yBvWeziM1eZcp3A50t4fqjLCev/cP+FgjfMpuCiKuww3KsyMOKptRVZ222qrfHaiDlY72QSx0VMy2YH4byothkKt+klb1cfjzzkFgqXocCwaHI2YCxb59ygY6wtJWVQptzK0Zy8o61DbLKX8hDwJnp09eUEXLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TL7DpQl9JOmLeLi472jGip6P1y4DRFUWCXGVAXVIao=;
 b=V/g/4M5Ow/4CX6VYidelbUyjiBUpjG5UxanJ0dHjEyElhaQTO1YX1OG+6R4zAd8vlN4p/eiEo+95HZm1MoBiBNG0df8J3P1Dv/DCQSPQr74m59OBrWYwKbmcAJGBDPLWgUmpYpCmUfwO1bylU+NZVmV/YSEr5hn2nkUAMaRYXsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:19:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:19:38 +0000
Message-ID: <c57e066c-e3bf-4221-8dfd-9255f63c7b3f@cherry.de>
Date: Tue, 14 Jan 2025 14:19:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: move licenses to doc/
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250101111920.18535-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250101111920.18535-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9ed07c-c7b9-4e81-c577-08dd349e1894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmxpTHFRdmMwZnZqdXVwRCtKZUFaTy80eFA3SkkreFc1RVVvL2VwUUtyajQv?=
 =?utf-8?B?QTRPZmc1T01VYTl4bWtVdVdaQVk5SElmd2p6ekdKbHZjbWJZWFlxZFlvNDc5?=
 =?utf-8?B?TkFGTDRzaEJ5VEYzYlhZM0lnNGZhK2xiREVXb2crWjdiemRwbDhUTi9RdmVu?=
 =?utf-8?B?VTMyYzJTWGhFMUlzMGNnSVd2bDV2Ry9LQjZ4RVdUVEJ0eXRQWjRqbVhWcytW?=
 =?utf-8?B?bFMzaXJNQ0lERlFocTFqWmZ2Qzh4dEMwYkIvYml5and5ckJYYkY1UC9obEEr?=
 =?utf-8?B?YnpPOWZGRkd5b2F4dVFYNkdmdjhUQk9BdElFeVVrQmdZSm9KanpBN0hsZVRz?=
 =?utf-8?B?ek9vYlVEV3FlbnduSE9nNGlrT2UvdVlRTFJMZmdUSnhDYkg5VlQ0T25ZTnl4?=
 =?utf-8?B?ak9WV295d3dRNHZpUFl5QmFjVFl5ZjNvQXp0cWVMczQrdXNYZ1FFcERCSTc1?=
 =?utf-8?B?TDVNZW1hM1B5a1FiSGdpcUpraGc1MU5EeFI2SkZOVFROWXY4MjFHWk16QnRB?=
 =?utf-8?B?L1U4V3Z4QUFONTA4V3hYbWhNMGdaUzJLcG5RQVNMcXYyayttTXpiSEF4NlN5?=
 =?utf-8?B?S2V4K1JJeUovcGVrT0xuMU9naVI2M2FEWHdEenVkUUYxK0lJc0RWZ0R2emx4?=
 =?utf-8?B?ZFdFQzNtT0pmSjZXRTQwUDFtNDJtOHpYWUZYbWhUM0d1QUNFY0hxQWd3VDMx?=
 =?utf-8?B?ZG0wWW9xcGdVS0lnOVRkQlJFdkltNTUyZjRYeFZyc0NwMlIyQ2JXakVMcmI0?=
 =?utf-8?B?aDVZQzl6b05aQ1FpUXBjMlpUZmpVWERsZ2NucFpnQUFjWStMbDhVNHFuMGg1?=
 =?utf-8?B?VEt2RnJ5WW9ST29MWHdoMHhsQUlNcmpqazY0UzluczN0WGhqTUZXR1o0T2xW?=
 =?utf-8?B?S2ppaFN0c3BMQjZGVGlKOHJLRnV0TFhaTXdrVUMvdlJNWnBHOGlOU21rZUsv?=
 =?utf-8?B?ZEwrQmlGQTZYYnlGWVU3SDQwTHdQZlR5YjBZdkVJVW1GY05jNGUxaEdLdmRi?=
 =?utf-8?B?WDZpS2UzWEVDWDJ0dlJHREU3dnYxQ2RhSzdLY3BneGQvYkMvSjhyTko0a1BS?=
 =?utf-8?B?dTlRNkpyRnI1ZGZYWFFCTTVRYmRlbnZob1lReXRHcmgzZ2ZrYmpGR2NOYTJ4?=
 =?utf-8?B?d29QZEVreDNoRC9MZ2MwR2diQUdDVTkvWFpQR1cvVXI2VVpqUkt5YTZHR3RR?=
 =?utf-8?B?UUY5dkIycmMxcm1uZUhmM0hqNnEvcFgwbk1CREpNa2ZTbVl3bXE0WXUwaVg5?=
 =?utf-8?B?d2VjS1REUmZnV3hMOUZ3eXVjTGVVZEl3QkFyYVBNTGJlZ3I1K2NSN1lPWDMr?=
 =?utf-8?B?N1pmUkFVTjdaRWVzd0F0R2c5MDQzbWQ4dWxMWUViSy84c0pCY0NML05lVThX?=
 =?utf-8?B?Uk1KWUxEQ1N5NTBBa2l1akdWeVFWZktTODJRR0UwVXE2QVJOVHJjOTlmYTRQ?=
 =?utf-8?B?MWRnS05vdmRmOUVQSE5nSEp0OHhGWERaV0VWY3hhanVraUlsZkhMZ2NMcGQ2?=
 =?utf-8?B?SFYyVkVLQVFGNjdmYVJxc1U0eHczc1VLVkQwRkswcEhYcWdBakhZRUJqbDVC?=
 =?utf-8?B?b3ZydGtUODliclh0eWlQcmZOUG5yVXRnSk1DMUFOcnN3UGVhalBRaldpdmRq?=
 =?utf-8?B?M0NXdXA3U09TUkhnblM1MEtHbDZ5WWNhRmVXOTVqZWxOZWt1YzgxOHV6cUNE?=
 =?utf-8?B?a3ZReFBBMHh0eXNRaVVuR2JaZkJZdVF0d3lsUXozRUVZd2IrM0M5aXdJbTUz?=
 =?utf-8?B?aTRDQk0xVXZYOWFxNUJ2dFppdUgvMjhlTVBNSVMvOVNncFR1amlCVWdSL1NR?=
 =?utf-8?B?cnliQ211UWlqa1lmTzRCUnhXM3JzMm1OalV2T2NlVXlpaHBZRkNYUk5lTUxs?=
 =?utf-8?Q?zlcdVQlA4iTie?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZCazFaWWtaN3lzWW80dE9GcFE0aFZObzhXS2VCVml0c3laWTN0eE5uWExp?=
 =?utf-8?B?YlJhSllHckc4eXFxdzkxL1NvUlJhdm8yRHhPd1h6UnlpUjlJc3lxcTM2dDQr?=
 =?utf-8?B?SjRHOWlVN3BaN3dyZ0lVRlBFVFpTd3VGRk52d1FYQi9vRHpYNXJGNUNtaTJQ?=
 =?utf-8?B?MWJYdTdlVDZYQkdPZkUzZkdkUXE0QytZUFdIQVlpekxGZSt2cjlaTG9LTS9x?=
 =?utf-8?B?c3M4VjRCUnIxYzVrUzlQUmVMZHdKVythVTREd3RLMDBkbi9lWXZOdXlZK1dC?=
 =?utf-8?B?UFlzdG1KTVV6aVMrdXp6RWtFZWJaZTBzTURqRWJBVDlObVA1V0t5Q2U1WUlR?=
 =?utf-8?B?aTAyeGxkUXlqcW9MUVRldE9YRmpRNHRpOStKWkFiTTNKU21aV0JObmZDdEww?=
 =?utf-8?B?S0lpZ3F0WDhPZEozK3c3aXRkYWc2dkpJd1o1ODJ6MGRMQUM0aXVZN1RSbWxT?=
 =?utf-8?B?OGFHdDdPK0Q3S1BNOS9aZFUwN3BEejZudnFnNDNxdUxIYkFZNXNJSXAxejlI?=
 =?utf-8?B?VG4yeXlrN2l6d2Nra3JTRXFwRmZPNm14T0N6bzE4YVJmdWVJT3BuNUF3R1Fs?=
 =?utf-8?B?OGdXSzVjanVRTHZZN25EWmpjOGRUR25pSE5BUzZFTGFUYW5DejFURUE1dUcr?=
 =?utf-8?B?MXRoZUw0a1p0NkdKM0NFcGUxVklzaTQwZFh6M0tURWZDL0wzb050ZkZEbTRK?=
 =?utf-8?B?b2kyVVpMV0wyS0xFSDBOSTIrcmEwZUM4Wk5ORjcyQzhFVWZ3SEJNY2ZRUk1w?=
 =?utf-8?B?ZkdvNHBBNGRUUXA2WTlHNXZJSUJISTFrdzRSSmJDNldOTXhLNE5sSG5lS3Ra?=
 =?utf-8?B?T0ZkM0FCNy9iWEJsVmRWVG1vQTVuZWlrU2ZjeVJwMTNhd3NuNlphVG92T1NV?=
 =?utf-8?B?T0RQeG5LR2Z5VnJycGJPMVRkOGNkbi9yeExTZXY2OUdRbUI0RFp0amFqWE5K?=
 =?utf-8?B?d1BYRHlYenZVdXo4UHp1TkpxSHFGV2VFTzlWUm12WXB4enlnaFVOOFhPTGVJ?=
 =?utf-8?B?NE8zQ2xTWmpXMTBORDhCSUJHL0ZERlAva2g5NUlRT1k1TkhqVWFKS01BTGdM?=
 =?utf-8?B?ZFY0WFBuT3lUKzhFOHkzNEkxVTR6WWZSNHpmZDRPbFROL1FVR0dDOXdIeWds?=
 =?utf-8?B?N09RSGlDejFUeG96cHd5MVFEdXRJaUJBZnBuMkxKU2dIdGcwcGwrNEdldEFH?=
 =?utf-8?B?NmhsQ3NyRFJqSzBsWVdBb3dzT0FuT215bmNOb29aRlRycUU4cGljYVhYYnBY?=
 =?utf-8?B?WlFEZzJ6bWdvUWZPOG12UjdEeFFoUmYraU1FU0drVkUwOHJUcS9LZkFYMWVv?=
 =?utf-8?B?a1c3UGRDK3lHSlV0K0NkY3NwcTVldVFHRGRDRFNKaWVxb0g0WjRkaCsrZDh0?=
 =?utf-8?B?Q2xmeUtMa3YwNVhvQnFiNTJ2QTdFRGtWT2IwSEU3amtvTE5UZEoydmp5cDB2?=
 =?utf-8?B?MWdtNlZ6ZXpSR01NeGQ3QlI0YnpWUlRiRWF1NXhTc1hlakY1NklQOWRvTTlF?=
 =?utf-8?B?RS8rUHUxYkJyT0UxN0E0QUhFbzVxNURUTUlySnR6MUlETnVQbkc1SDhySUcw?=
 =?utf-8?B?d2xEUkNMaW1MT1BQSERERjZ4WEZKOS84c3NDbXlHZTlPSUpLODVmdnNucGxN?=
 =?utf-8?B?bHE1c2tYejBDWUM4Qm55enFCYVU4N0NGZkloRnhOa0twd25FcWdrNTR6MjIw?=
 =?utf-8?B?RXNwdTcxOTFkQjNiZk5ZYnoxSG1OVE8xSG1JMkVIc1hBRFFnM0pCYWlXLzFS?=
 =?utf-8?B?amZPQW41OGpCWDViT3BrR0ZrMTNscXVkZVlab1RMK09QVy9CbUUyU1BvbmhW?=
 =?utf-8?B?TGZRZ2paSytrQ0lCdHM3N3ExaUwrOUNQdFRhYjhmbHJLOExaMGZHdlBhT0lk?=
 =?utf-8?B?UFUwNklHNXdtbUxadWd2d2wyeW9sTU1uNHVxTmRwNG5lS0dDUnJaRnBPRUpi?=
 =?utf-8?B?M0JBcTRsRWpxQmxZNjFySlA3OXM4MnY1a1dIbVB3L2tmM2ZnWlRRY0J1dnFB?=
 =?utf-8?B?WUxnRkVNanN2R0RiTTBwR2NBRzNkS0wrWHQ3ME5uZUllbnhiNEl2S0w4VW55?=
 =?utf-8?B?S1htdGRhbVMya2M4Y2tVYStoNHZSaWhSMmZxQUZwS2p6c3ZmZkhQT1NiQ29u?=
 =?utf-8?B?TVRjbU55eDNhNWhGcDlxblR0SCtXUFoxR0s4YldxdVlLaU0xZSswNWtPVUZI?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9ed07c-c7b9-4e81-c577-08dd349e1894
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:19:37.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6DdzK8EFZWSYJ9oMCR5yDhsnSyNYPchcbrIfRoBFvkjtEgLlg1d/R48iwSD99HItpkiKKRKbhhT5lY52sXsOzwGqyhsccfQ+A0cVHot+LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627
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

Hi Heinrich,

On 1/1/25 12:19 PM, Heinrich Schuchardt wrote:
> * Move all license texts to doc/
> * Convert README to restructured text and rename to index.rst
> * Replace '+' suffix by '-or-later' suffix
> * The eCos-2.0 license is OSI approved.
> 

When one lists things done in a commit, it usually highlights those 
should be separate commits, so please do have this split.

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   doc/develop/sending_patches.rst             |   6 +-
>   doc/index.rst                               |   1 +
>   {Licenses => doc/licenses}/Exceptions       |   0

I don't think this move is a good idea.

Reading this from the source code, I would believe those are licenses 
applicable to the docs, not the whole source code.

Cheers,
Quentin
