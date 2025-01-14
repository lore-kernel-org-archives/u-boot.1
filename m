Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F5AE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D3580657;
	Tue, 14 Jan 2025 14:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nrpKLoxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6CD8069D; Tue, 14 Jan 2025 14:43:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0462A805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYEgH+ajZEEFtLqWBVTzXU1Fo7+l5+rpzsJy7rVeSSLIKVil8V7KzihBBf/Jb1MMOvxe9M2n33lIQQ2da7iOykZEuHE7d1KjM8UH2L9H+LoMhMl/aThHge3C7CE2LELVEnfbcN1ydovUsKrHNDpoRaaARWNvHPlKmeWtAthYkOIF92DbWGvKtMX2zqWHOdTFtdLUap7lUbVlx14dqeoU9WkeB2FL1U2XAXrsCQy1QdimOcIS3Wq3IKFqgwFVtF2GDw9j59CaPj1X6gC5QuLzgd4Q5zUOxHqb6msvo/Ls5c00isofl8a+fn2uHqVoaIz3BgRoia/2o1NrZD7mAcbeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdUzFljsfjCeg85JQx4shLti5WIhopJOcc1czic2eKw=;
 b=wPugfTlAJ+fE3AY2J33DfdVuPmawB8UYN6Pbyfjo7oOKyt6AMGbfLOzkNpv0eIQt6LPFLSJ55N0GaneGw+M33Lq/uuuFCdd/NFpCXCWrJhVMATVX9fff7WCHcppBjCUl6owiTQzE3wSj4kFxZDN9tdnMPkT7zmBG0BpCfFjBPG9+c9sucKWeF/RawVluCvY/Enyc8wvwUBuKo0i77g7wkSH0IrMEvztVPJ1zuR6RzzM9iQuZWtpzpU8fTiTf06eOU5dNaOKHGk1hs9KUom0jZ5MSwxDnFeb7xHsK+4QZr+n16LcyALvPy1U8M5Dh/vZqcsk7zTSz5I1HSm67wYKCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdUzFljsfjCeg85JQx4shLti5WIhopJOcc1czic2eKw=;
 b=nrpKLoxtw+UKG4WBWHFUTLDxu7lAh82uQ+wgPR+lVVlk1MpfSdn8y9IcdFzat943Sutgpsvf0Eb9M/PCNGdBYCAuc2yLcfYGO3SKJJ1FtPcmuDd0ZGC9EVxLl/1OnNYI97MKJ8bmM8+kDNcAViQFz25OuwLs1z6hSptXT6CbsDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:43:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:43:45 +0000
Message-ID: <975a6b12-f401-4909-9163-20b7f1d6d542@cherry.de>
Date: Tue, 14 Jan 2025 14:43:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drivers/mmc/Kconfig: Make DM_MMC a hidden symbol
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220222612.1757884-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: a57ed6e2-b2b6-426e-e692-08dd34a17735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDhibFhyWEczN1ZNYkx1bFJURnYvNHpweHdhL2YwR1d6TXlkZkJUNDZSM1FT?=
 =?utf-8?B?OWdiRWlxWXVtTFMrdG43WDNnRFRnZkc4MlVuRTcxNmwvc2hxUmduV1hWcm5H?=
 =?utf-8?B?M0MzUk5HRDV2c0dZUTA4OWpRZm1RYmtKWFJmWExuZVNUMnptSHJkdElmdU1m?=
 =?utf-8?B?Y0pMREVCVHdFOGNIK3RvYU55Y1RWaWZtL2xnVjZiS1VpY0ZKK3dzVjNyUXdu?=
 =?utf-8?B?UVRWTkI2NlI3T1RKM3NwM21XWU5UZ2JGUVhFZHVQM2JPVGUrdndMNVgyZnRZ?=
 =?utf-8?B?MnJUMjZIR0dtOUpmTGJwZGNqZHcrYkMvM3drSXM0bnpkZG9nQzBEUldnbzRW?=
 =?utf-8?B?RnFFZ01UeFlWQjJBaXljc2JhT1ZDY0RxNDBPVDZBMHNlcUZZZHlkeTVXTlBF?=
 =?utf-8?B?RmFvNzVzN2pPOERpSGdMSFJ0TTB6c1NkeGYwTUhldDE4M1FVVlNhdnlURlNk?=
 =?utf-8?B?N04ramZYejRJTlhQWFdyTDBtM2pGRHIyRGVWbGNjeEhoRTZyOTh6Uzl6Lytm?=
 =?utf-8?B?RWsydUNsa3hTZkZNV1IyVXJVVWl0MTY5NUo2UkhVYU0rVWdsSmtySWxXOTVp?=
 =?utf-8?B?Q3cvK2QwaFhqRWtDUGRaZTJSSUpGS052c1QvNjBXVU8vWE5rYmpiZ1VlS2th?=
 =?utf-8?B?Y0I1WTk4REFVVjhOUXdjU3FCOVZOdDhVNWlaTzBOa0EwcmkraGE2aWtVZTNn?=
 =?utf-8?B?UVViM0JYcDhvU0RlMm1kMXNnNUMxMks2a1RpelBwSnRHdXd6Sk0zZEhJa05r?=
 =?utf-8?B?Y25XSnRTRDZuVWdDQURUTGVoemFuV1c0MlZicGRNS3kwOWJBbEVlOUFzQUN6?=
 =?utf-8?B?VnZLL1dQdStnMG9STWhoSVpFYjNmcGsyblhmUUJIZ0pyM0VZRWtZRTlGVjd6?=
 =?utf-8?B?VnFVUlQza2s1Wkw1MWJibkJsWk5pOWVUY1VDdzR3K3JFa1RUZ3Y0U1lrWmpY?=
 =?utf-8?B?Q0QvYjNzTHdPUUtna3NCRTIzTVpiWDVYUUJTWDFqYmV1d21lU0o5Mm0xc3Jx?=
 =?utf-8?B?OXVtSno4dU9KTzEzQk80OXFHQm5nL3FHb3NBRUpGbGRmd3UvTjgvckVWYkdP?=
 =?utf-8?B?NmNkaFJPSHAwbGRUbUxIR0Nla0RtSUFlSk1pUi9qN3BOSEhoNzJOM1ZQRWU4?=
 =?utf-8?B?dU5UNVVpbkNUOWNIaWVYTlNPSEVnaFROQTk3a0poemhKOHpUTjFBZjBIS2Ro?=
 =?utf-8?B?UnF6M1NKSUhMUUdEM1p3aXl0aXhDV2YwWitWNVRoQktnM0ZqdWtnMTRkNE9N?=
 =?utf-8?B?SzNMSkdIYUNFT0RyNUJJRUU4TURFaytRdjJFcTNlcHQ3WlQvUU1Dc3ArQk5i?=
 =?utf-8?B?RDFCQU5rRW9HWjJxRkt4dCszT25hQS9mVEtGMGRhTmFPL2I5QWViWUpFaWlh?=
 =?utf-8?B?TEVoSWJraU9HYWovYXE3NWovZks0VERJcTFtZXFXK2ozUGFZamN3QUZFREs4?=
 =?utf-8?B?UjRmWEdlVTJHYVhkM3BYK0xIZE0yN2NoKzFDcHlML25OV2k0c25uRzZHdXJv?=
 =?utf-8?B?bWJ4L1JMVjQwWlhEWmFlV3lhZ016V2x0ZE9rRWpoYVhpNVFLVzdzNlN2aTdF?=
 =?utf-8?B?ekwvY200RmFxRDZvQWlZY250a0F0RkhUWFY3Rnl0K3FUWU1ZaGZqdWd0NU4r?=
 =?utf-8?B?YUovTy9MMVpkMHVGQjBCMjFvYlFNTjljMFI5aGllUnRnVkFIc2h5QXNWUEJS?=
 =?utf-8?B?T0Y3YW9TcmJUeUpFdEV4Wnh4SWp5N05rVURIeUpJMFRlTTgvVlhzVlRMeGEw?=
 =?utf-8?B?TmE2MGF0OFBlL0hLSmZQR3pMdkpDQlFwUzFUeS85Rnpad3BRMDlwT2s0UEVr?=
 =?utf-8?B?TUJrNHlYNUtteGo4a3BxR3RNRlpwNUNBSk42cGxXeThta0FjKzlYUXVybDha?=
 =?utf-8?Q?DnexEhVsreSBp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxCWm5ZRG9xOG5RWmpEREl6SnVOQ3padlpGSG5EcDBzQ3B4cWlvaGZGSEh3?=
 =?utf-8?B?R2F5VUdJVkwzT1ZZYmJmalJEUGg0TERPd0Z1SUNaK3dmVFlpVTFIOU0vZjVL?=
 =?utf-8?B?ODl4TzFrampCK0l5YVhCNVFBUmttcGxCcDVrMGd2R0ppbUI5cDlUMlpoRno0?=
 =?utf-8?B?R3JPOG43RGtPM0tnQjNBNXBjUEs5OVcxTHV3cmxHNDZNM2tiYW1PQlU4bnBi?=
 =?utf-8?B?QVErcU9KTGRxQTJPWHBzRnJkbWhIRUNoQ2UwOCtaR0QyL1puY2FFalB3VE1E?=
 =?utf-8?B?WnlPa2UrTjdKRUhJVFh0S09USFlTSDRSNGptWWlVVEZOSW9oYVlodXNjdG1G?=
 =?utf-8?B?eEUvdVM5N3c1KzJFc0RpaGFQampYa0JURjE1cnk2VmZnQ1pHdGkweVRrbkNx?=
 =?utf-8?B?WWs2aDNndmg3QVc3NysyS2dmbmFmcmRremtsZ3VGaytLc3JQR2pJNTZ3anE3?=
 =?utf-8?B?TFlITXQrZGZqYytQV0xKeHgvb2RtbXc3RmpieEY1SmtyeG5ydHd4bmxnWUZN?=
 =?utf-8?B?aThzcHFuZS94OGNwMWtyRFF5QXhrbzh3MU01aVg3d2tWcjl4eHBIUzN6R1ps?=
 =?utf-8?B?eUNPOWV5Q2pldXBBKzBTK2pJbkxrb0VqSHo0ZVFLM3ZBNDFCMC9xSmdPZHM5?=
 =?utf-8?B?V2Q5eGVvT1Y4QUdvLzlFQjlPeTc2Sm8vWm4xTC91RUlGcUhTVTAxY3g2M3o1?=
 =?utf-8?B?K2xsZlIrTXQ1N2JrR085ZFd5cjV0NDhPOThwaWlKT3RycEZ0WCtuUDdCQWRN?=
 =?utf-8?B?dmczdjVNUFloWmhhRU9ER3lhZFRBejVFalZMRkZnQUpPMWhaSU44SlowV0Ji?=
 =?utf-8?B?VnBvVXNOY0hLcjk5VW1qb1kzblEyL2NGakZJNG5wS0RkMFIvNDlzcFpkNVpW?=
 =?utf-8?B?eDc5NHVSREVaR3VIVitqZjdMYWoxS0l3NThQbHowaGRhZndEd05UOUJKMi8y?=
 =?utf-8?B?Q3VVbXNrdXlpZmpoWWoyVGRBQk4vcWJmaDFoZmhWOXVVeHBjVDd0SUloQmwv?=
 =?utf-8?B?UitwR05pelVtTnVTL0NKLzFrdUJXckVrWVJrYWhhVHF6YjU2UjI4Mk1mZ2ww?=
 =?utf-8?B?Mk0wTzM3alR5VTE5d3MvenF1ZjV6MzdLZnBhaVRUZXJoa083L294ZVpVRDJ3?=
 =?utf-8?B?anRwVElQTGZLMU9RbjIvMkpvVDVFWXBjNU4rTFFXdHpLV0VpOG1HNmtUNjY5?=
 =?utf-8?B?dlFkTEJZbGFUTVF4Yi9zTTllSEpmWlJvbHRZRkxoVWg4b3JQazRxbE1IbHVy?=
 =?utf-8?B?M283ell1TThCcjdJaDlwampoVHQ2Mkc3SHViREF3REsyVitwczlaSDFJS3BU?=
 =?utf-8?B?U1NtSFJveXVZZjRhOXZYWGZmeWtCN3BRYk5aRTdCZ0FGWXdHOVgzUVJxZDh5?=
 =?utf-8?B?V0JxQkZGd1NaajN4eDdNTmZibjRmTVd3QUE4NGhMa2hmRGg4S0ZjNGkwTlZ3?=
 =?utf-8?B?MHNiWHlJSE82cVNVZWhWM0svcHQxL1lUanBvT2pQbzl3NjFHa1Z6Y1dydGYr?=
 =?utf-8?B?Y1pRK25qQzNRZ3J5MlIxM01FSjVuRjlBYmtJcFI1V1Zlby9kdEs5dU81Q3E4?=
 =?utf-8?B?ZWJVdlN3OEgwbEJJUzN3dmRWczAvWWNOZnJrTXgzQzJ2Vm1YZHRXQWJ6ajlr?=
 =?utf-8?B?Ny9GTTcxRWtMbFZoN3lOOE4xZHQ2SEZ5WUR3MDVuSWhsbmV2cE9keko5UWFr?=
 =?utf-8?B?dlFtLzA1VUxVZ3ZlNU03eUZDSlBVYlVLRHRBWVZIZkV5SENwTDNZSVNMeTU3?=
 =?utf-8?B?cHNLNzArN2NkOUtMcUlEa0sxYUhjS3pVcWducDk4eUlHRFg5bW9Vak1wanJL?=
 =?utf-8?B?YXlFQXZaZzFKSngzVnR4bm9IL1l6d1FndWVVbnNhNGNtLzJrYkN4eUtGR3lv?=
 =?utf-8?B?bHlCSXpaLzk2dE5qS1JKQWFlcWdaUERJVmt3Um0vMnpHRStmN2dXYjRvYVk3?=
 =?utf-8?B?NUhZR1pOS2pmaGdUTDRaZHp0L2IwYXhqL0krbFJLTnpud3JiR0VYUHpIRmNa?=
 =?utf-8?B?akwwdjY2MnV1WDNBbzFhL3FnMTlXNEhsK2tNNTQ2dHJUakRMMGxpbEhCc2NC?=
 =?utf-8?B?K0N1WUdWdVFicjdpemhRenF4dERYTHZXdko1emlnRTBkVXZ0SWxjVXQzaXpB?=
 =?utf-8?B?YzVCOW5BaW9HRHFzZWdzWjJsVXNTNzN6N2NqbzgvNTRoeC8wcVRuNVBUU3U2?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a57ed6e2-b2b6-426e-e692-08dd34a17735
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:43:45.2108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EihCYNdcsJkp+vkGeqRs2of1mDKFPc6Nf/DasNtaYkxXLR//qXZtEbaaFh1QdQXDXrRnN8Fm2UivrzBciAQ1LBFxIBhHBgoR3P7Qc7vI6fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906
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

On 12/20/24 11:22 PM, Tom Rini wrote:
> At this point in time, DM is always enabled. So if MMC is enabled, it
> should select DM_MMC. No drivers need to depend on DM_MMC being enabled
> now, so remove that from dependency lists. This now means that a number
> of platforms which select'd DM_MMC need to select MMC instead.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> ---
>   arch/Kconfig                      |  2 +-
>   arch/arm/Kconfig                  | 18 +++------
>   arch/arm/mach-exynos/Kconfig      |  8 ++--
>   arch/arm/mach-imx/mx5/Kconfig     |  2 +-
>   arch/arm/mach-imx/mx6/Kconfig     | 32 +++++++--------
>   arch/arm/mach-omap2/omap3/Kconfig |  2 +-
>   arch/arm/mach-s5pc1xx/Kconfig     |  2 +-
>   arch/arm/mach-tegra/Kconfig       |  2 +-
>   drivers/mmc/Kconfig               | 65 +++++++++++--------------------
>   9 files changed, 52 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6258788f53ff..44ae4b3babdf 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -172,13 +172,13 @@ config SANDBOX
>   	select DM_GPIO
>   	select DM_I2C
>   	select DM_KEYBOARD
> -	select DM_MMC
>   	select DM_SERIAL
>   	select DM_SPI
>   	select DM_SPI_FLASH
>   	select GZIP_COMPRESSED
>   	select IO_TRACE
>   	select LZO
> +	select MMC
>   	select MTD
>   	select OF_BOARD_SETUP
>   	select PCI_ENDPOINT
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ea414fe376a8..ea256f687867 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1163,7 +1163,6 @@ config ARCH_SUNXI
>   	select DM_SPI if SPI
>   	select DM_SPI_FLASH if SPI && MTD
>   	select DM_KEYBOARD
> -	select DM_MMC if MMC
>   	select DM_SERIAL
>   	select OF_BOARD_SETUP
>   	select OF_CONTROL
> @@ -1211,7 +1210,6 @@ config ARCH_U8500
>   	select CPU_V7A
>   	select DM

I guess this can be removed in may places since it defaults to y and we 
are relying on it being set to y?

[...]

> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 9f2fecce3826..46513db0d6e3 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -3,7 +3,7 @@ menu "MMC Host controller Support"
>   config MMC
>   	bool "MMC/SD/SDIO card support"
>   	default ARM || PPC || SANDBOX
> -	select DM_MMC if DM
> +	select DM_MMC
>   	help
>   	  This selects MultiMediaCard, Secure Digital and Secure
>   	  Digital I/O support.
> @@ -39,14 +39,14 @@ config MMC_BROKEN_CD
>   	  If card  detection feature is broken, just poll to detect.
>   
>   config DM_MMC
> -	bool "Enable MMC controllers using Driver Model"
> +	bool
>   	depends on DM

We can probably remove this depends on as well since DM is implied?

Generally, I'm wondering why we are even keeping this symbol and not 
merging MMC and DM_MMC together? This is not a blocker for this change 
though, we can go babysteps :)

Looks ok to me otherwise.

Cheers,
Quentin
