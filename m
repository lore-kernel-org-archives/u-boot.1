Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF4C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C46888F5;
	Mon, 15 Jul 2024 16:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hXKBZioa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2162888F5; Mon, 15 Jul 2024 16:13:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDC087B84
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcyfx+1Iu2L7sD6P3OKlpvNanCppo0n6ELTNtSqFe68BkRqO06YaP4UvHliDpI/cxphjlJgwqMDSrVYH6R9217vuNP+GgMdPvfg3h8JFIcGNDpA+Oo4f1SSywE6nNF53vH4dBNgXUx3BCuuX2lNu+S0qU/WTAcDil15/kQWI27eFcJhpj15Bxb2H9YwS8cRCnvnEEN5SEWb0Kz1ZjFHG+lwpkX6uDmxYRmFtBBAJF+a0SOw82D0thswW1U3rpeuOIOh1saI533OIqW7Bq2pLnw4yT3VsOfOEnM6NhGXDVsuf2SjQGsv1FAr0EbHLWjtjLwQq/qEpjgldXzjD7iA+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1q9DIojRDw4tvHy9UNEDaOXtsUBOxLjtltNEGIEzVE=;
 b=PcXoAOTh/MaljxCqhGinfHt5MhGY7SJm0Fq0NLZvOB1kjjb8PEzfaXNCHZS5DkHBlmi2RjUO6DoPCk4IRHE8Qr0e2lB3A0kQlMFE4fVWzos5H+DhlGwIj+dPa9pePcJQnw/El6kcMZr7eepy98PSNpsFYpk5tRRvKGM+n1NTRqcL9EhZ8XOQdeHU9KjZ5rf9Dc1Daxv4c2CFB6+fAorlZvfpNDRpnxiFRK+ng5seqamYuw72tzCKjk5mPfJ75Pvhiw306W+giYtWPnhG+aHEPowLTMSnE0DtBFB0T4EgmVRoK4ErR3w0t/OZ0YVUxvZyYkehlM9nLx921x9G+GFuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1q9DIojRDw4tvHy9UNEDaOXtsUBOxLjtltNEGIEzVE=;
 b=hXKBZioaCCFTpS6UdWtiVh4QuPAldQl1pACxd/5yN4klEuIo6rFXz0VIPfit9VX/2DLEMscZSuIkxLXKt2UHWr9eiJVoIynx6HXB/M4y0qaZr8NI97hB+fVEIpBvsRt0tbiRylRXaC+nSCYzGzkFixsp+wXu0JSM8pEauZJOLG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:13:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:13:37 +0000
Message-ID: <b8c39a1a-b9c0-4f5a-bc85-9079f6742a4a@cherry.de>
Date: Mon, 15 Jul 2024 16:13:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] doc: Add a description for bootmeth_cros
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-7-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 24716d58-a729-4c8e-60ba-08dca4d8521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZktUZXFxWmJtRUZaMGpXajhDMC9Ock1SMlp3QmZJakExZnh1NVR6SkxYSHlG?=
 =?utf-8?B?Sm1tdnBseTFyUXdYdFd3SGR3Q3kxY3pUMmx1QkIwZURvWFhSeVhOSWVBRkxZ?=
 =?utf-8?B?NFU3L0lnMXdBNzR2QjFiWnpNMm81K0kyNkRxdDBHcTlkMGFDNE45YUtHTWht?=
 =?utf-8?B?RnNqUmtsUmdhbXA4ZUNXd2tmUTAvWUtOY3VGYk1Zdjd3L3lxSFErdHVqMFJo?=
 =?utf-8?B?NFFUNGFOS1d3SE5ra0M1dmdGaGlQVEFHcm14cEV6aTJkYy9SeE5zRC9TWlJh?=
 =?utf-8?B?VTJKVjg0N3BLay83dDNYUGJpeFZzUGJSUFdaWS9EZG45SGFOVHNPVEU2TVNt?=
 =?utf-8?B?K2M5MGI0amdnbWhUN25nL0RVYitCQWYyYzFoUldtMDhvTGdyZmk2TzJQT2V2?=
 =?utf-8?B?cFcwejBnTzZTRVg5S1d4TmdHY255bzlLT0NYdkxvcmFlaXJZVUFYNmQyL2Nk?=
 =?utf-8?B?cXFaUW9jUjVialRsbmdRQUZPcHZHMHlTbTA5N0wzZDNadlhIeTQ5aHArVTY3?=
 =?utf-8?B?M3Fad0lIbGVMYWRYeXE1QjlvdStxYjRKby92bXhmblI3ZmxlNkkvd1B5Zmdk?=
 =?utf-8?B?UndKcXdsZE10TVc3MElQaE1oQzBQY1Byelk4U2VaUHlCYW5uMVptYXJtK0VG?=
 =?utf-8?B?S21GUFg3LzNMbndTTEZ3OUo0aGZyU2NDVWJia3V1dVV5TTZ3c0lOR2xLakNJ?=
 =?utf-8?B?S0FZTXA0TTY0cUc0Q1F3VGd2ejVReGRXaXB5bHBJOVBydmFuV3dYMkErakdv?=
 =?utf-8?B?amc4VTRZV2QzTDFiZ2lDZWNLOEVyb1BIeFpsRHlBUjVjTW5FQ1JndmZ6RVd1?=
 =?utf-8?B?UmFNd0VNRXVRdUtIVzZXZ3pGb2kwQ25aZXFCTHl3emdPKytpdlhBRTJBdk1Y?=
 =?utf-8?B?RmI1QTJLc09TalR6NDNJSGtJZm1QMElQQVUwWkp5eTJJZUpZODVRcnpUYTRL?=
 =?utf-8?B?ZG92ZGliZno3U1JBRnFZZkV6ejc1V1RsMEZveDZLdFpjeFZQeFgzVllLZFBW?=
 =?utf-8?B?T0E1ZlpSalNWNGp0dWFjUkN6aUNnZGx3T1JhcHJnYjVSeERwWjdqcXExQ2hm?=
 =?utf-8?B?RzVKditRRUlEdDVwbGNOeVdXY0pFYW5yMGU0TEM5NXdFVlJZTnpCUzlmOS9M?=
 =?utf-8?B?SmZMRkx3aGNIb1UvYUo3MUtObkd0L2lkcHNWcTBvZEI0aXNZUUxUeVFaK2RK?=
 =?utf-8?B?aTYzZmtUSnFDSmhLdzVqSlNPdmhJQ0c2TnhmS0wrdHRXZ0Z4cmE3MS83eEF0?=
 =?utf-8?B?QUJvYnl3cDBaQUhhWGJaaVcyY1I2bWNFV3Z2U3ZoWVVXQUdQSmVYenpVRWQ5?=
 =?utf-8?B?aVVSR3RuR1lhTGVjMjhYS0JFYXppS2MrSWxhQzRmeERUTWhEQXhadUhOODBT?=
 =?utf-8?B?TVJXUE5CM1h4ZHBkVktrYWlOWjFGeWROOU1HSUNELzRPM05XdDNPOXVPaU1S?=
 =?utf-8?B?czU3MHoxNzNSdExva0x2SVBGVGFyWk5Xc1d1NEZxZTVpKzVOYy9WNE44eDI4?=
 =?utf-8?B?ektSUTRidndXT1RUdkNQd0ZkcFBjTE82NXpqamNNKzBvNnM0NVB3VStoS2cw?=
 =?utf-8?B?WlVnNjR0c253ZHVpOXp5a0x5RDgvOXJkVm5nTDU5RU00ai81b1V0QmlSTksw?=
 =?utf-8?B?WkJRYWYwWURGemp3d2lxazNia0UxanNlL1hqYndaZ0ltTERDTEJ1a05GY0h3?=
 =?utf-8?B?V2xxNWoyODFGNzVJaC9NOFBwQ0pURVJ6U1hZVnROL1JiVE1rY3lzNjk3bTRn?=
 =?utf-8?B?QnN5N0RrZUlTeWh3RTJZUFNiRVhEZW9zZmRXSm1VcVZtZWVJY0RCdkJNUGM5?=
 =?utf-8?B?eWwzL0Z6b2tBWlpCL2duQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhRR0hwQVFRb3BublYvT1pqeGgzakhRZmtRc2t3QVViSndhNjUyZjErbGxB?=
 =?utf-8?B?K21STUw2NkZaL2JZdDdsZlR2WFJNcmhycmxzVTEraWNjMWY2VjlCbnE5Sllw?=
 =?utf-8?B?QmNBVmsxMlREVWhlakhvVXAxcG5qbXRlWmhBYzNtRDRjTkFYdGgrSTkzbS9G?=
 =?utf-8?B?QS91bk9iZUdwTzdRUXpNYS9KdjM2OFRoK2VIWWFmOGhYdURvWEY1bTJoQ3gv?=
 =?utf-8?B?ZlF2WGlrSHpHaFg2cERSWkhkNFh0K01XRkZXMFppNDBmbWlWM3FzQkZVZVRQ?=
 =?utf-8?B?b09VazRYOG15cVhzaUZmbzZHTnozYWY3Wk5yY3FrWjZJb1NRb1JnRHRYcWdQ?=
 =?utf-8?B?d3gxNXhaSzBMNENBVlJhTWh6TjYwNzFJN3RycHFEVU1ocHQwS1dRNHYyUlBx?=
 =?utf-8?B?M051OTROd2h4TjVZTWh3aWNXWCt4TThWVlVicHF1ajdTUTFoWTdrUitYbFky?=
 =?utf-8?B?M2d5YVBIY2lMMnJieXZXT0FwTmFpWnVjaTFDbndFc2xnSUlmblR6NFEzaHZ5?=
 =?utf-8?B?UHMwUThLdkZIMjkxeU02MmpHelN3ejNKM05xYUZ1UEd4MGtpN1pwSjV6VWZv?=
 =?utf-8?B?UzVQZ1VkYkhOZVdpRFIzYnMrYzBlQXVwMmgxWmxKY1FtSjh6OVhSazNjWHUy?=
 =?utf-8?B?S0JpRUZDYTY2OUxNQjNVZk9UN2lsNXNDcWp0dUR0UnplZzRGM25WQVRsNytk?=
 =?utf-8?B?TklXUzhGS3JuSTV0RWdLVDBXYnZuT0ZqUFR3c1FyQUZ3L2VLemMrYzBrQWdu?=
 =?utf-8?B?Z3UzanNLNldTTTBsbU85RDlzYm9zdDRWQ1ZoVVJMdzNpa3V4RG9ET0syQ050?=
 =?utf-8?B?dExpR0hrL2dDYkt1bzFZNFpJTWVPUkdCZkswSU91VVVHQUcvQzRoYW5sazVE?=
 =?utf-8?B?YTdLQXlKQXpxazRlRmdOMnhqTDFtNFFHUEFaVjNHYWhMM0QydkhTblFUeGxO?=
 =?utf-8?B?L2Z2Rzl1eU8rYnMvaGlPcXkvUEZIbk1iUU5rS0I0L1krbGJGNjhZZTk1M21a?=
 =?utf-8?B?cGdidnJ6WUZuUnFpOEdpSGU4NzQwc2FtdytDRDZkWTlsNExoR0crZ05hOWc4?=
 =?utf-8?B?aSszOHZWUDV4ZEIyemdCQTk1ejllc0dNSjRnN21veVU0WGZEanJWY01lMU9m?=
 =?utf-8?B?T1FWTEMvVlg5R1pUa1RWV1JsWmZhYzVSYlJTSUZ3MWlJeWplck1aeUtQOXJ1?=
 =?utf-8?B?b3FheFByc2Z0ODJJNDFwNGs4NnY4N2hpZTFLVGxWckVabzU3amtyOTgxMGJ1?=
 =?utf-8?B?T1B4WTJKRktkNzF1M2hxZWRyUTgybVNPZHE2RmI4SENSRnJpM0dxeUZuUCsv?=
 =?utf-8?B?WXU3QjFmd1BqWmJvY1ArMkg4Qk1oblJYZk54Y3hUOFJRV2NqZ0ZrVGpnQjJN?=
 =?utf-8?B?OXI1cWFHV1hSZjdnbDIwdElHc2dBN01UUXRUUnROYmFTOWVIVWR3NnpRd3lI?=
 =?utf-8?B?bmJSVDNIajVWZXdOVXMzZFFhMHBsZkd4MTdSMzNtMFQ3VlpSQzNJVDd4NG4w?=
 =?utf-8?B?QTA4Wk03YnZaSlhDb2N3aUZoM04yR1FKK2UwZDNCTDRNV2d4dGxhdFY5cVVu?=
 =?utf-8?B?bGV6Tm8xUDlyejAxMDkrWHJObnliMG1IdTJLMjIyQ253aFpqWlNjOE9xcmty?=
 =?utf-8?B?WnVxaXE2N281T3U5U28rOWczVzhqekhyc0JJUzFwRFluS1I5SlRPNGlvOWtO?=
 =?utf-8?B?dzdsV2J5eUNxUnVKalo2KzRiSnhUbFhEU1g0bDlDc2xnOG1NNHg1dmR3a1ZG?=
 =?utf-8?B?bi84ZkczZ2NjMmZjSGU1TnhnUjNXWkJKSzZvSnJMRnhXWDlTbSszVEF5S2NC?=
 =?utf-8?B?dHMxN1JWaExYY2dyb24zcHBPZUVzaVNENjdRekgrUUhMc3o5aE96MlYvcTdi?=
 =?utf-8?B?d25hQ2hDTDcrRjlNa0xxZmxJSUpQejZMV3FvZFV3QWl0bEVYZjF1KzFmK1cv?=
 =?utf-8?B?MGlaZFBsZXVHNzYzRWNjS1NwR2RSVCtQUnVEQmZYRkZPMW5WL3JmZVpFUnB1?=
 =?utf-8?B?U1hORmdWZDdTdjlrZ0VZb3JxL1llWmxtYkxDSkxjUzVnSDNHVXljQ1ZCQmtt?=
 =?utf-8?B?U01SdkdyZDlKUXdLZGVjVWhYMWE5YTlFeG5QOHZhTk8vL0pGOTJNR1VhRjhU?=
 =?utf-8?B?VVVXMjZWUkZkUmlEVHF2WVNEbTNpdTJnd0JxajJnSnpJSDZyWlJtNkMyb2s3?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 24716d58-a729-4c8e-60ba-08dca4d8521f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:13:37.8799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xdj3L02sUkUzHBqOAucB+cSxnSP095jw7b5SgXN6ogC7llMaf+Si0Arh0PA8Hjuxdk/g6afP3bbAr6l7dI55KgakDcXfpapVyiYF9ue0FuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

On 7/15/24 12:13 PM, Simon Glass wrote:
> Add documentation for the cros bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
