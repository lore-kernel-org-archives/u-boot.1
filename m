Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B466DC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2897C8866B;
	Mon,  1 Jul 2024 10:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O//EQAfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BEB8863E; Mon,  1 Jul 2024 10:30:02 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5A28866B
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO5oXcDcGlqgjUHX1pMRMdOoT5Jt2BSs8h2E7osmYYl9DlC4BS3wqTNo3tAbVEgqushsmkQdqjMuWFv/VGoTFcB5s4+tY3xuMZn1WwzX7Cdas3G/vuCNsANpFUKwEeD0FhjqOW989LKrpfkGdTYZJksiS9+Opqj9UTbKUwDE1fgJ81k89FeQrMQsG29aUdvq5Jk8buYEliSFShsKXP3b4UZ3qkBNOiO7CbxVK3JDuPar3nA8cdNM4PMhOMl8HB/gv9936Dl/BjwWTkp7B3LKT/tzBfCz3S1MB6UvXE6VtB4C0sqWsMM891V5bFRsFtJYIO/8UAv7+a8Se51ucxSZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+FNoR3m5CcJ13IgVswGVb3VCzUJ7ARs/zpYuj36pT4=;
 b=gmwYpeu+jy8Rp9w+OnD8VTlCCzsMdQf3CyVnG57YhivXYOs77x+nkgk4EVeUwVaYNY74IcGO3OdVQwpjjJEiB84Ob4Wd8k8RKc2BqPDdLv711MUYWS5g9T4BvUSBUW6VTc7iD11O7u8r2MG8gUaOqhDas28R/p2pOuI6hY3dp+scYAAVcEC1m6+jYsj/80+MdfZFhG7smubMXxylo1NxppfcbIedCgvKvNlpeWH7wNHYD2NRbXzx7dilnQb/LqrVaeqr7gLavWM0/yjGlpNiXM+6Gw50gZWSFZ3ztV1wGGcAIXDgNSXVA6YSNvxi9z6ZABLYGrVjb/DybSt8NGjRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+FNoR3m5CcJ13IgVswGVb3VCzUJ7ARs/zpYuj36pT4=;
 b=O//EQAfHTArq0oypHeqDnNJnMZ6gjbxeTIOAEmgQ9ncnfPcXnw45b3R3ctUCCmeZbnV2DyQ0vsdmLb9hus8XJX525bXH534qUxPW2FAEl/nW6mZbhUOzXXpGzyC5tisHahz8F5c9dKBQps+OJUYsbMOcw/ZD0sN2cyLOP96DuAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 08:29:58 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 08:29:58 +0000
Message-ID: <b2dfccce-6e8b-4a6f-9781-bf38c0ef01f0@cherry.de>
Date: Mon, 1 Jul 2024 10:29:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drivers: bootcount: Fix typo in documentation
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: u-boot@lists.denx.de, Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
 <20240628173543.129207-4-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628173543.129207-4-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c9846a-c455-4488-6378-08dc99a7fe08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGdnZjFJM3UwZjVsZmFPa0tMR0oxOHltWXZxR0xlc29vQTV2bHJMOXhDMHBv?=
 =?utf-8?B?QW5ZUVplWEIxZndBc2lseWRsYUJyRjZDRktJVUJnZFdvMFYxZldUUDJYb2hS?=
 =?utf-8?B?ZXUwSTJqMmlvT0NkYS9MajJCSHJJa3JHUXJOaWMyWThWTExyK3lGbGVyVm9I?=
 =?utf-8?B?QjI3SkR0RzRsUFFwdXZyb0ErNGVMRFV6T2hKODZDbFNxYXpBZHRSc015aDln?=
 =?utf-8?B?WFpvcTNUWi80eWl5Z3pUN2MvSk50bGlSQ2ZjZlBIT1ZueXhEV3hUd3RTSW9Y?=
 =?utf-8?B?OVU5Y3VJWnhQK0VmTTNjd3pnY2VCTG0rOThlM1BaQk5RVjFBZkpGVkllNml2?=
 =?utf-8?B?alBldWZFdEVPSDhrTnJjQkErcS9YazRWY2RRRStnQi92RU5oK3lsNVdCaHNI?=
 =?utf-8?B?SXAvQW1qTU9iZXpGVUdteUQxRzVzOW1TcTlodXFlRU1LQ0VDV2V0d1luUTZl?=
 =?utf-8?B?ckcxM2UwTzR3Qkg1d1NCSUd6empxckVtaVQ1aDU5ZVhWTk1IVXNwc0RPRERU?=
 =?utf-8?B?WnQvYXp4cmY5OFNicHBiSnl1TzdEYytybEpzWVVQalkxa2J1WWM0M2lSOUlU?=
 =?utf-8?B?R3lRZHR2N09xRnJYanI0OWlGR3BXWmRNOUh2V1JHdlBrMmhoOWhVMUJlSGo2?=
 =?utf-8?B?TVZ2MFovbEQzdlErckZ5bTNJN0xzTzBpMU8rQ1dVS1FSVEt1Y3c2Rm9tZUNJ?=
 =?utf-8?B?UlJZZWF1TXVnUDJTUlA5OFo4a3E1Zm9wWDR0akhzVVJBeGRIN05MenNkVER0?=
 =?utf-8?B?bUNtQ3ovbWhVcUhoMFBwZjU1YkxZa01yaE9vdlhMYkthV1NLNHlmYjJmdWpM?=
 =?utf-8?B?RVArL29vREF2cEIyNitjbkI3OFluRkxyUmhCa0hyVzliS0FIcU1XSHk1QzFk?=
 =?utf-8?B?KzU3RHJZWVZRWHhXaXZoWXlWUlVVMVhOOWxpNTRIamx1WWg3SFJjY1RjK0h0?=
 =?utf-8?B?dUxWSllNeGdDU2x0VlZ2ZVlMT0dUaC9pY1dZc0hFcmxGNXYvTTYzT2YrNG5n?=
 =?utf-8?B?QkpxN1pteS9SY205aVRmYkRzbXJvUEFhb21IZ2dsYVpIdVpoY1B6OFVQdzI0?=
 =?utf-8?B?RWdWYjNvbTZyekdWU0t1SUZkVGJ5RXppR3VRc1J1WW1ybWpJeHN5ekZGTmFn?=
 =?utf-8?B?Z1diZlVhcGRGL1N3UDV5WDhHQ0o0Y3pxenA0Z0VHam1VbVpvUjBEald5SUVJ?=
 =?utf-8?B?eWlwMDEwUWZlbHJuRzVpTk15RzBVYUcyTFkwVkc5SXljTEJOVWdONDBzN1Vp?=
 =?utf-8?B?RWR6SklvVm9NYUR2WldDZTFFaVBkT3RKb0hPZHZIY1dKNFg0QjhxMnJnODlq?=
 =?utf-8?B?RlBoTzd5YXZtdExRcjJqdEtqVE1uQ3VEemFmdXFyTWlwMml3TmJadmpDRzdq?=
 =?utf-8?B?MW5NMElpSjJIbVYxUFRUaGwvRDVlSWc1Mi9YeU01K29NajhiRTdJeUNnZnhX?=
 =?utf-8?B?aWlCUVRpN3F2OWk4L2tHOVRwNkcwN296aVJCQXVQTHNnbDZBckFTSDh3LzZX?=
 =?utf-8?B?V2JaZlFkMWxjMkVtK0lmSG5sM29MVzdlSnhSRVRxMHlmUGp0TXhrbVovUHJs?=
 =?utf-8?B?UHJ3WFlqUXJmdHVWdVlIdEJoWk5abm9uKzhCekNYb1JzbHVJYU1YRjBXWmtJ?=
 =?utf-8?B?bkZONGcxbVBFd0tBT01lM3FKT255Sk9UYVBMbGxmQnVLMmV2Q0hIeTFTWWxX?=
 =?utf-8?B?NERobjlQUGFSR2tORmlyeGZFd2VPVVoxSUVwMFkyUmxqT3p3VWNWVm93Y2w5?=
 =?utf-8?B?clFKSVhJNTdOZzF1eDV1MExEUDlqZmt6RnNEeU5tc2hLZVhJK2RmOHF4UzVo?=
 =?utf-8?B?L2htcnUwTlFJRlZ1aHZtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NJQXMyNm9XQmpGVU5WallSRTN6bUEyRmJodkw4SHAycDhiTmZxcDVHQUhO?=
 =?utf-8?B?WW1TZ1NDdnRmc0tMbGZqK3VJUk5zT3NzZVJlK3ZHZ0hpWlNuazZyVEZvT0xM?=
 =?utf-8?B?dW9Ta1lRUmFkalFSeHJWZXY2cWxlam45djBWQ1hNSXQyN1lSRE9qSEcwc3gv?=
 =?utf-8?B?K0l2U2RHYzhxRjNpVXl5eHA5Q2pIZUFBa05JTjBtNVVWTTNkd0xMaGxsK1pP?=
 =?utf-8?B?VDNVQ1pCUDN0TlBuTkxiWXNzczNZeWdvNS9xME5CeFFpMGcveVh2djRzSkJt?=
 =?utf-8?B?TlQybUpJcTF0Ylh6Z0dmcDBnZFpyMWJBSXhBRlJmUkllV25OUUR5d1had1A1?=
 =?utf-8?B?dmpjR3pGeWV6Ui9HOXRXdjN6UjhvRHFLZ0dMMXVNQi9QUDZIVk90M20yN0w3?=
 =?utf-8?B?MkdZa0EzRE9id25FZkt5c0V0SmZRZHpTWEprdWJVNHVxSG93RitJVjgxVzVv?=
 =?utf-8?B?ZFJacGh6eHZQMGtnaFhhWFFTTEtYTjJHVHlaZE5Ma2ZFdkhlZFRyNXRyNVpF?=
 =?utf-8?B?QjNUMEhLdDMvQ25oNTJCTkxjMktpV0NSUXh4c1BKVnpJUTJFazdjY3JxUm04?=
 =?utf-8?B?T2crSCtxRENjSHdJb2VpU1BPQ08zeE1hNWZHYlc5UFgva0ZTanI0NGRHNFZI?=
 =?utf-8?B?RmV1UjlIZVVDWDczQVVvejJwTlJWQkVLbE5zaEJSdVcyaWFvazErS3Z3ZEd4?=
 =?utf-8?B?V0FMUy80N044SXlSVG9pM2orWFdpb0RzVUtabkttSHEzNU5oSHVYbUlIaWpO?=
 =?utf-8?B?UURBcG1WL1M3d05vUmNsYnF3Y3d1aHlLOTNPNHFDbFdIUGcvSzEvWk95UkFt?=
 =?utf-8?B?ekZYYUJuUTRaSDVDa2xFT01jOVRZcHBiVGdVN2NDc0JJMWt5alYyVm9QcVk4?=
 =?utf-8?B?OGZZWm5zSFd6em9idThCR3FaaVN6SStHcjVWbS9VZktvbDc4MHV1T3k3dlhp?=
 =?utf-8?B?ZXlTYmZZZWs3WDkxeTg4NU0rR2VwVm93TnovQkNYeGdKNjZHYnBPdDNVc0Ju?=
 =?utf-8?B?NlJjQnpWcHh6Y3Q4VXNBWUV5ekNMZGlrTDJjNGh6Y1ZwWTdXR04wNkxWVDBK?=
 =?utf-8?B?UVBqZTVOSTFqTUNoU2s5NGF3ZmN0RVovdXJSQ0FaaUxmM2hDeWJYV3h1QTR6?=
 =?utf-8?B?S21ETXMzUzlaMzU4dGJNZFRaMVFRcnhpSmVTZ2lrU0t0eUM0ODRGRFpxSjN5?=
 =?utf-8?B?V0hhd2l6L2RxcndYZEZNdndJVldwSnoyYXJUVEY1S2tFOWM4NHNuYWJtMnV5?=
 =?utf-8?B?c3plc2JaZ3c1bXVVVkN5SFBwbzNKWUxoa1ZqNkZQT2tuMmpjNHc5c1ROZHU2?=
 =?utf-8?B?cGFLbEwySEhKZm5pM05vc20yVFhaMzFnTWtneVlXdk02c0xQRjNwMkpSVFZT?=
 =?utf-8?B?ZGF6a29NbTBpbFFwTkJFdjRrYUVVT2c2S2R3REs5SVpndkJNR0NHaXJ4SU0v?=
 =?utf-8?B?cGtTeVlWcDBqclhKbEdXMWpiWDNOdGhLQjBmckZRdmhueGxxNmpQcEtFQ29w?=
 =?utf-8?B?b2ZaYk9VbThqMEV2THlVMk9HbFNVWTdVSDhiVFlyRnZKL3RYL3c4NzB4YlU5?=
 =?utf-8?B?Und2UEhLenhUcmtpTWxZeUFWeDFienBtL2pyanhIczlKVXZBa0lPbEFJU1F6?=
 =?utf-8?B?WWkrUDBXUDh5YzRPa3h1ejRpYzFPNXcxNnlMZ0U2dmhobE9VZ0E5UE9BV0RC?=
 =?utf-8?B?NnpjeENnZys1ald0NGZ3NlFnenhNZGRPcm55ai9oSStFVVRpLzBab3ZyaDdx?=
 =?utf-8?B?Z3BFZG1LUVFhaFAvdk1Fb1dvR2tOMXlZL01maFRTRktXbDBiaG1XbUp1aXdI?=
 =?utf-8?B?ait1ZkxRYWxGVk5tTnUxem1HVk9ITlhzY3BHS1NwclJBZkJWNGU0QVlsd2hD?=
 =?utf-8?B?ekxtc2ZnanRZdG5zTkg5SW5TL0JyUk1rNi9tS05jdmdRdTFCTEtCSldzdXZ6?=
 =?utf-8?B?RWQyMU4zN01aN2IyLy9Xd0JVdC82Z1hSeHRxSWhwQ3RJWTRaeDBzbTVZa1ZG?=
 =?utf-8?B?R09uUndUcUNHdFVtcTB5STJBWW8zTjZURlNWVkhVaURHdUdab0UwSnloUWJz?=
 =?utf-8?B?Z0hXTGxmczNVSjJzZzl0cG83YVlsQWN1UGV4VFZ2MXhpaGQrTXJ0RFpkQVhL?=
 =?utf-8?B?eHc5bit6MG5vcXpzV0lNTDhkbFJMSFhrSjhDSTd2dkdKalNadCthb3ZtaWlM?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c9846a-c455-4488-6378-08dc99a7fe08
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:29:58.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lv8wCOZ78V3EZfm+6hICadQRBe59EY9Y4wQp5TtXdkX4M6CNz1VDIicV7s3ZI3hrmV4qSbjfjUHuqYXmNUz9+KdRSIa36SWrNwPdm8TB3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

Hi Vasileios,

On 6/28/24 7:35 PM, Vasileios Amoiridis wrote:
> The bootcount documentation was using "unattended" while it probably
> intending to say "unintended"
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
