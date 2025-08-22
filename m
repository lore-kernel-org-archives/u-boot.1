Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9060ACA0EFC
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 12:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23FD80422;
	Fri, 22 Aug 2025 14:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ereTbKi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A11D81D5D; Fri, 22 Aug 2025 14:46:09 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 412688006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBCdXHpoL3wVyabZJ7MhtIXp6rkcrbz/BO5q5Bv3i5sYL/rgYX6ekO20yCo0V1lzTsRUn2Rxjczsfy5rZwxjQa5Tqq1ddACAVxrby63jkiJdPDx8arGMA4GJ6bR/FxlkRofyOYz+nsdEtO7Gq9hI/OuFF/G3w1iTwpSgb39QBBicxfBmrE/rQPxghL0F7yLV8WTBgiZn3gRQ2oWIX+XW3iHFmmNRR9N9Kboz4NCdCtzanVNR8+exgDM6d1o7oC91syk4BARVB3V8pKv283GQkPpz2ybaX10F0ua8wX7zghJJpUZ7MxhQkLfMIqfcX3UGbCSpt2qvXYwNv5tZ6l39GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlOV7IITJyDZanJeXdkJCSCA4pY/eIkJWqyxgd4JsWw=;
 b=A8AmLH/4G3fMcc2XdN1CCBman13rvPSJDUTQg4rsRw5PFuUF7jNbvRaRWRXMENxyUTa8La6J4fRtdWqVKippvCe346ssdzWV3x/OdsX1qAMOkfUM91escwg7GIDa4f2YCny8nEMgFbP14O2o6MYeVjuFoSPaB3g9Aj1PkPS3SabgqPfbYGIKxHbOz3w3cX+adKDZRquH/dbMohsRNMsEgrY/7ueRw7Nfs9F24NXIOtQAhNZoJdhaun6eTdRZyJ15DKr4dk4yYzCcDNREH1k2kzaKbwnLb+cmlRdFSJSik+d3pKeuR29kICrmUL2dfClXwJ5tLfFcljafnUKQlYforA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlOV7IITJyDZanJeXdkJCSCA4pY/eIkJWqyxgd4JsWw=;
 b=ereTbKi71KrYBi40oog79Lcjbjcu6hamaMZU1dloov4VeC9nMrN0YOOMZFE+vHhmDKDSG5WPYSD0vmazm4Mce3Yu7XAn2DTvrtYZN7mkhLXn+FoQft1u5pt3CAbv9KFbwyUuiJOFitzkAMcrxRUNjbhGnLZW4/orS+D83p28TOjykoDu1NG5fnjxRkVVCDbgwLkNaNPUtiPBhiYdtEWCDHJsCW3HXFUBzLYNcOsZ7Zl0vNSDEZcGoyHjrILT5U/DT4WqKmsE6bs/2s9e2wqY6R2C96FM3JkIkiW9L68r9bfhB4F1HcCkaGdJiW1AWT4vPadGgNAhlAypYLRjt5WQMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1324.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 12:46:04 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 12:46:04 +0000
Message-ID: <ba5aa607-a87d-49ae-97d6-02ca24c2b54f@phytec.de>
Date: Fri, 22 Aug 2025 15:46:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
References: <20250710171135.669838-1-jm@ti.com>
 <20250821183012.ps6ygzebsxoi2hoj@dolphin>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250821183012.ps6ygzebsxoi2hoj@dolphin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::46) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9874f3-035e-40ed-2120-08dde179db68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnV1azNYWGhQczJlOEc0RkJJK1hDSFJ3eUFIS0h1K2tiNHNBWjVxYTVSeitL?=
 =?utf-8?B?dVVKdXNmcDF5b3c1MW1yb3FIeEZpN3RKdUNLcTUrQWNmS1NrRGlEY2hFSHlj?=
 =?utf-8?B?bVNUOGZzYzBHTTJ5TVRXU0gvYzFCRWZUNkNGTUM2YVphMXVEK2RMRVdRNGtE?=
 =?utf-8?B?bWVJUWQ2UVpjdldUU3o3SWpHWVd6UDhuemUwdjlmdXB5dDR2SlZieFlPUGhq?=
 =?utf-8?B?KzJuYXRWSnh2NTgvTWlmWVk2R2pXMHd3TVN2MWhLUEdEc0tpbzRkRjM1bUty?=
 =?utf-8?B?dnF6OU9KYkpDMTI4WkE3OUpCU3hERndGQ2JQOEpyZ0NqeUxEa05maFJqbllh?=
 =?utf-8?B?YW52WktjWHVHbU5qY3hubk01cmlQSExjdGNKejkyeUVCN0NoRVoxSjk0bGVI?=
 =?utf-8?B?SlNic0M3bGhpVWw5VGVGOUNORE96bzlIWkl5aHdTTzhqMlVTSVdUdE9tVGUy?=
 =?utf-8?B?ZXZBTHhybDlDbEphY1J6NFhlOCtlcHlqbHViRHRKbE9rdTA5NTlCNUVoRUFS?=
 =?utf-8?B?ZDM1Yk1CNmhhVWFadzNZYjdjRjRTZUxMbi9FZlFWT09zTU9xdWwyMlRpdkZB?=
 =?utf-8?B?UFplOTcrZmY0NkhjVk5yMGtQM3lHOTZwRStWZmVTemw5QTI5K1N4WldWWWRF?=
 =?utf-8?B?WFFSTEwrV1JJWGhNS3RETGR0VHBpaGpiTkhkUlUvSHNtYkM1Z3ZtVVdkQmda?=
 =?utf-8?B?TUZZY01pNGlxN1Z4ZG5JKzNFNnh6N053eGIwNCtRUXlSUnh2bXhtN1kyZFEx?=
 =?utf-8?B?aFRFandRNmVsNk9KWXBJQWplb2hSNUdhQ3VjTVZnZ3lzU1Z0Sjc1NmE5RVlB?=
 =?utf-8?B?aTFnaG56OFV4RUpCc0RUUTlWS1MvK003T1RNN1NQSk9ia3NqRkE1cFdmTGpQ?=
 =?utf-8?B?QXJLTExwaWR4L2hYcW9JdHpRQmtLUEhneHpDa2ZtdERjS2U2UzlZSGV4NkVy?=
 =?utf-8?B?NVZUZmVJQ2NSQW5MU0lxRnpkVzgzYituRURaUFB5N3JwbEJqVStNYTlXZlh3?=
 =?utf-8?B?dVJHSERobHRSWHhaNFhwMEsrQ05vRnAxU1hOQUM0M0RESFY3MkM3SnQyNU0y?=
 =?utf-8?B?ejBxS3pnbWZzWG9MZFhDcTJDL0N5OFdFYk0vWHVxSlRUOWZTQis5UUoyK3Zw?=
 =?utf-8?B?cW80YVErRzIydGVGN0o2T0lKOXdyTXk3c2puKzJlRStRVi9QQmhZWTQxbFds?=
 =?utf-8?B?OTBCc1hPZUNTMzdnZTJBdDJJeSs3RDR6OGxRcnlYSE82ZEk1U2x0elVXWGhB?=
 =?utf-8?B?bmRqVHEvWXllbE1FWWxEZVJNSTRpcktiSUREYUViWFJ2SnEzenRYRzdhVVE3?=
 =?utf-8?B?YllEbHBmR0FSWHlRaWdKaXg4a3g1enJGUHdPMWIxdGxwRnpFS1pyQlpYeUww?=
 =?utf-8?B?eDBidGM4Rk00cGNhQ2hiZVhXckNYczY1Z3daM1hZNEtjUWJqZXZNSW52d0ZX?=
 =?utf-8?B?cTdkOXJsVksxb3dvRHhkVTZJYWxNT3U4elVJcDJrck1yWlBQditrUE1nT1dY?=
 =?utf-8?B?dTJXNjRNV01BL25BckJxeEJwcmhkS01udUhlYlJRQ1Bla1JpOVA0clg3L042?=
 =?utf-8?B?RXN1RU1kRGNDbGRuZFdqNGxXTGtNYmluNWRLWi96c2hub3FNNDZ5WHZFMGg3?=
 =?utf-8?B?K2NGcGdBdTNzcndrOTZiY1R4Wjc5bXk4NXhPcUdpcHpXdHNXKy9WVUdyRXVq?=
 =?utf-8?B?Q0dwdUNFTjJaN1RMQ2dtVzhBdkdiL3NKWDQ4Zm52a09zTEVNNWsxdXNWVnJp?=
 =?utf-8?B?aHpWaitFc08wL2tMS1JJQ0prM3RNS2V1aWVHS2FTOGlpYkJkOGVYb0FUcHdG?=
 =?utf-8?Q?8hs0XZPmdCTuuURDmSYjjvol6j/EgimmFMzR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVWaXJRTWt1TDhCNWZzSFVTMmlicHVvR3ZWcTAyMDd6OWtNUGFDTTA2UWkz?=
 =?utf-8?B?UDdKM2w4SGM0ZHJHV2pwcXlpQ01CLytEZ0ltb0lKQzh3Y2pVNlo2eUxXa2Rv?=
 =?utf-8?B?akZPZEN4TDliNmMrL0JxaldsNXdZWFh0YUlaZ0I1OTBnWGUwZW9MZHRkWjM1?=
 =?utf-8?B?aFF1aG1jUHpLWForZUdlSmU5OGNnTTJub3Q0SEt3RnNoMEpQT0NpSGVXcFcx?=
 =?utf-8?B?K01nMXBidVRwcWRTanRuMDRvRXhJN2lvZlVFQ1lVbTNEYzZiVnoxdUpPeGto?=
 =?utf-8?B?dnU1cTdmSFhPajRJRHNtNVNqNXdCemxvd2VoQ2hRSDVaakZvSThYSnIvNVZT?=
 =?utf-8?B?WHZIdE5BRnFyWml5dG0xa3VMRGpLQUpOS3RtdWRKa2dDNFpXNERmWFV3T1Nw?=
 =?utf-8?B?SWxRQzEzMW9VWVUxeTFRckt3dlhBRTUvUTdva3FEM3hnaDliOGlSVVpoRkN6?=
 =?utf-8?B?dndsUlJ0SEpOYU45TWgxVTRFTG5uUVY5dlFVYW1RcFJxNzVLWmlwSU1mYXFF?=
 =?utf-8?B?NHc4bmpNWjZURk5jbWVuU1p1S0c5aE9ZcHhneUJ6UngxbWF4NHRnL3VTYjVM?=
 =?utf-8?B?aUsvakt5ZEFrVkVBM2xmUFhtbXBENHlNenZZem5UcXhmNFI5YW5WNkNHYlRF?=
 =?utf-8?B?OGgxTHBoWHdLOHhSMS9URzArUzFFemliUkp2S0pNbWVaZEFweGhXTzZaSDdj?=
 =?utf-8?B?TWRIbGNtdmpMWXhLVnovZW8zNWxLdUFocGJnTHBXbEtCMGtLcVIvcXB4L21q?=
 =?utf-8?B?NnpuNGpDa2E3c05CMW1NeExvSXRXak50b0xaK09aaHdNZFVhQlVmU2E2QjN3?=
 =?utf-8?B?Z1BmWnp0Y0dGcHhEaVFVWTFiRDN0RFdkSnI2STkxVGJuT3hrMktzM1NaMDEr?=
 =?utf-8?B?ZHczT1FsSHBmUkJCelIvQTZhQWpaRkxZTkNuU1llWnducjBuOFV5aTFTMHVk?=
 =?utf-8?B?NkRpVUk2bTEvWmJUZ3Z4bC94b3V0Qm5NMVJvR0dSMHFvclh6dklubWdsMElk?=
 =?utf-8?B?MjNpb3plT3NyZElFOGNwT0VRQ0NJdTNhaXpZSC83ald2akFRbTJSWjNjQXRM?=
 =?utf-8?B?SGhqRHBXRGxmWUFqSlNac2h5L3NaSkZuZjVza0poT3pEd3Nmb0srU3A5VERM?=
 =?utf-8?B?SU9mQVE5VjhSN0lTZDExek95UFJnZUhDQW1qTnU2bVcrQW5SVTV1WmdXTm0z?=
 =?utf-8?B?b1dHQWRCZG82cE94bzJ0Nk9YUHpTZjZxT0x1MzAyZWFZWmxMMHJQbnVhL1Bn?=
 =?utf-8?B?MnF1NFFPU2Jra3RvRUhqTk5VYmV2TDhvRHFiOCs5cGhqMXBLdFlHTlFDUFEx?=
 =?utf-8?B?YjVoLzV4S3FQdElmRGpsdUdUcXVzSitUQmZ5QnBoYkUwZ00ycVIwUEp2TVd5?=
 =?utf-8?B?UGZmVmRaVGdqajBWNDlHNW1PSG5SbkxqRjhjM2RLSDFpUkU5RUVJVlorNzNx?=
 =?utf-8?B?L0FxNjRldlJzbTIrZWFnR0hFdWluekRFeDRLNVJxU0NlYlNEYWFObXVRYnA3?=
 =?utf-8?B?N1MwNGlMUG5oWXUyNTVkcUQ3ZWhBRkRvM1BNZFZ1WUQrdk5RUEE2U0p2TWNQ?=
 =?utf-8?B?aHVEYkJoTlh1RlhNblJaY09rdTQxK3BYYmNpWVFTclQwNENQRXJoM0xQa3RY?=
 =?utf-8?B?RTBJcjVBR0JjaW5ZR1FqNlorUHhkNndCcUk0R2VHYUlHdCtYNW1OaW12VDZw?=
 =?utf-8?B?Y2VENCt4TUN3Qld4MUNsZUt5dlJuNEhXNy9CWFpjTWF4QkNORWNETUw4bUps?=
 =?utf-8?B?ZVJmcGxPSFgwcjBPNzdrWExaSWhTQlFwK3RSbTVOYkZGNmcxdTMwUit4TlBy?=
 =?utf-8?B?aWpTYmY0dWh0UU1nb3g2Z2piMHRtQWtFQlNnMXliYWhmN3RwbjlmOGY0Q2lS?=
 =?utf-8?B?UnhnQzN1MVVBbEUyN2dGQ0EzUXVtMXhIbHU4d3o3Q05wY3VmWXA3eTdpWDlI?=
 =?utf-8?B?R0F3YkhvTWIwVXQ0VmN4VWoxRHc0RklvMzUwSWNZY1RYZUhTb05Wa3lQU3RL?=
 =?utf-8?B?MlMvcVNQL0lYY0ZZUndGRHEvaFBTdFhZUVFMUEU0aUQyVld5dlV6TWxBZU55?=
 =?utf-8?B?eE5oWCtTZW5qQVVRanhqT1FRWnZFYzNFckJvM1RzREIwWmxaeDBnWUd5bDcv?=
 =?utf-8?Q?lOP6brUVD3extuYr2pW2z1ytz?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9874f3-035e-40ed-2120-08dde179db68
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:46:04.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HtCxTxk9HOxmqyxRvONkaOr5V69qiOc15fZbM/QsuSbrGbgArKPSAoUCvcqqy3WMpvKD+Dq5bQ5RGyM4OVtRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1324
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



On 8/21/25 9:30 PM, Nishanth Menon wrote:
> On 12:11-20250710, Judith Mendez wrote:
>> This removes support from booting from UDA when in eMMC boot.
>>
>> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
>> boot1 HW partitions, we should not boot from eMMC UDA. The current
>> logic confuses the end user and mixes two different boot modes.
> 
> Wrong! what ROM uses to boot has no bearing as to what bootloader needs
> to do for rest of the system.
> 
> https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#flash-to-emmc
> 
> There is a reason we chose this flow in BeaglePlay and other Beagle
> platforms - U-boot and other components keep growing and our emmc's boot
> partition is too small to handle things.


Maybe it is time to think about how to shrink the bootloader binaries 
again. And I am not talking about introducing new defconfigs for 
specific boot sources such as ethernet or usb.

We would really like to keep it as is and have all three bootloader 
binaries on the boot partitions.

By the way, are you aware that some eMMC devices allow you to change the 
size of their boot partitions?


> 
> 
> NAK if you are trying to bring the old problems we solved back.
>>
>> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
>> this is not a clean solution and fix will come later for falcon boot.
>>
>> Logic was also added for AM62X with commit: 664593464634, but this
>> logic is incorrect according to TRM [0] under Primary Boot Mode Selection
>> for 'eMMC Boot'.
>>
>> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
>> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
>>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
>>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
>>   3 files changed, 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> index edd43a1d78d..1d8644bd073 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
>> index 6e3c66e5107..01e47deca94 100644
>> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
>> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
>> @@ -262,10 +262,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
>> index a422919fab1..eb7e245843c 100644
>> --- a/arch/arm/mach-k3/am62x/am625_init.c
>> +++ b/arch/arm/mach-k3/am62x/am625_init.c
>> @@ -316,10 +316,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> -- 
>> 2.49.0
>>
> 

