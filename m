Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762CAC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31A0801BE;
	Fri,  7 Feb 2025 16:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="IDIkKdL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD6B801DE; Fri,  7 Feb 2025 16:06:19 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8852A80141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuaJkng4U1kHqSqtgTdATQAAEsgeNqNMIv3d6W+fme3P8ZPap9efUiO20neQJoQxWvxWMVf+dCC0M6jUNKHlrd3Kewws/SWFVSN/uuoC2TWH2XpPYiwkkTR87y4G4gzYg2Dd3jHlaPa2x+q7wTP8bbdSE3zMBW0+syllOk69skJv+ite8XDa8nfMH7YZIK2tp0+gb5B20R9px6JcPFeS+/uxDiIOA9LwupL3petB3mebDbs0Zi1KSciq8Ksf8aA22wVUs4n+f/mttycFVrL9h7VPN49bZx3VmeiHppkg8M4tKuPdogMEkk6wlSleyYc72sN5oRByNTZUAHQrsIRb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqqUlsQwgh/GBxLhuSThJ+nigRBpywiiHk/5izvQNiE=;
 b=BiJ8dRy+NHqf8wkt1ypuPLH4xl9nrWgC96yoBr09L9l4U+DrA8er3VS/7y1bxPDtGcjBSh7UKJkeZMfETl4/g8RS6oeb8tTSlAz/ftIuOgSFrpeV2DJJRA4RlZjm0F/OEuLZc6NE7dnw9WkQXPceMTPnGmqhio81HBu/nmmuitn8VOEjL86PAH/EpSS55nK2mPX/gKuzBV3LL0pUph0P1jrAR6s1pkX0zBPFipgn6gK3G2OkxPQafkmvYln8PvD3GtJ/tuHcARFcjeSnySEvI9dvJkPFxUfV/1ndPCQu08iPDkCSUPoJup+0g9vjDcUXI1SlDBDWOWnZaj1rK9NoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqqUlsQwgh/GBxLhuSThJ+nigRBpywiiHk/5izvQNiE=;
 b=IDIkKdL+6+gVafw4qgWddUpDWW2VhmSfCguH/wXiI8MRGDNyC2bVXF6wzjvqcyy/VA5z5Ipj6FqJna3GittUeON0F5i9aRMlP5ls29s2XbJkNoilbLlJuNJcnk5LPNsngYWTfxPXoRviWr3qlKD53m2H2//VxhyUE6imsuKY/Ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI1PR04MB6976.eurprd04.prod.outlook.com (2603:10a6:803:130::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:06:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 15:06:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 07 Feb 2025 16:06:08 +0100
Subject: [PATCH] board: kobol: helios4: enable ddr odt0 on write for both
 chip-select
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-a388-sr-som-odt-2-v1-1-4443b17faad8@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAGAhpmcC/x2MQQqAMAzAviI9W5gTdfgV8TDXqj3oZBURxL87P
 IaQPKCchBX64oHEl6jEPUNVFhBWvy+MQpnBGtsYazr0tXOoCTVuGOlEixNlFYhaNxHk7kg8y/0
 /h/F9P8r9085jAAAA
X-Change-ID: 20250207-a388-sr-som-odt-2-bd250cdd68bd
To: Dennis Gilmore <dgilmore@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI1PR04MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: dc447beb-74a6-4bcb-a49c-08dd4788f61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmM2Q0V4QVVNOEZ0VGdOMEpVWEkwdklteFFyWUFoTE9WRlNTY2t4YkpnWjlV?=
 =?utf-8?B?Z1hkM1Q3ekFETXlaaUdEMEQ0OEJFTWhrWDJnYkFDaTZVQllNYmJHM3lQYUV1?=
 =?utf-8?B?MTZ1Z28yaFFoVHpMeW1qekpIN3lxUjl5WS9Ta1NPdjNJT2xkR1BzQktVc3Iy?=
 =?utf-8?B?M0tuQ0ZsbEVNNGlYRG5DNTE5Mmg2VHZIcDlReDljc1NLM084cWZDUElLOGR0?=
 =?utf-8?B?K2Y4WnlvRjJWTnl5K2ZkdUc2WXVKc3pWZldkdzlvd2F6YWphYjAyWnpVZ05V?=
 =?utf-8?B?YjBuTnVpWFRmdGE5ZHVqNnRxcVZLTDdIZWhCTzVTQm1iYlRkb3BhS2MzRlA5?=
 =?utf-8?B?ejBOMzREdVlaSTROZnJpazhSUkQzMCtaUHA2OVJFYWZsenowQVpyRkx2TE9y?=
 =?utf-8?B?NHkzZndhazBsc2pnZkJmZ0ZzNEVTY1ZjWUt0V1hLLzdoYlJNZnJvRWQrakdH?=
 =?utf-8?B?QlozVGxaMVJWcXdYakI0WjFzS1Q4M3lxWWNtRmlodTJLcTVsNGFaaXNnaXRo?=
 =?utf-8?B?MjkvRjJoSThTdGo3MlphRVFyN1V4eHFkQ3JjT3hKeDZHZ1ZQcnp4R1JNM1p2?=
 =?utf-8?B?cnpJZ0hWL2w2c1RWbi9sbWVVa1pOc0dMZUNLcUF4Y25GNmhPV1pPd3l3UU1P?=
 =?utf-8?B?UUlaTEgxaVNsa1IzejlOVm1vTE1OcEEvakJrdFRvNTNhczhBVitYNEREdjND?=
 =?utf-8?B?cDVrMFpZYnRHcWJabXJSbjdLS1pNNTJWRWx5ajFSeGJuczVZSWczclhuL1Vq?=
 =?utf-8?B?YXFUUG8wZG5zdFFZa25sZ3VMUTk0RWxPS1dJZm8ycFZLQlhPckgvZzlLL3ZC?=
 =?utf-8?B?ZVF2NXk0TTFWa203amo5citYVUliS2dCRXdabkhFTVRpeURHN0dpQUJRWVhW?=
 =?utf-8?B?SGdpRGdQQkRod2FGdFVJVEY4VDJhbEVmejZyRThDcldsQkg2eWlYNEdxYmtM?=
 =?utf-8?B?OWo2ejFRWC9Eb09yVDJySloyd1ZXZW5rSVduU29TMWViWmNoTDFmVHJHMFlP?=
 =?utf-8?B?cUJELzNOSXA2T0Y1K1dweGppMzFSZGFTaHN4ZmZ2Sis3NlpNTUFibHRST2d4?=
 =?utf-8?B?TkFlOWJoNU5XWjZqZmNoSFMwbVdTZVIwNEJQcTZkUWVlQmZBN0tXZm44bnJj?=
 =?utf-8?B?YVFLd0xHOGpxcDhSd2lGcEFkT1AzODh6SXJITGpZOUNtZThSQkV5TEpFUUcw?=
 =?utf-8?B?QnZvSzRTOWwvOWh4b2xDTGhJbzl1YytSR1B5V2FvanBXeGM5U2phVzdETitD?=
 =?utf-8?B?c3ErVkxuZFUxWFp0ZmZteEhYUFNiUU0rQ0dPWGY3ZWNPVS9MVmlvdTR6bU1k?=
 =?utf-8?B?dHR0NW5WZnBKVXEzYnlyQlljZ05yL2xJMTJFU0Yrd2RGUXZRZnVxM0F4cnUz?=
 =?utf-8?B?T2hZYWpCeTZHbmhIbzV0VFVkOHlGRE5yZGh5dDdNcG1PSWNCcEdRUE5RTmlH?=
 =?utf-8?B?T2FMdG9HUEZjWTVvdEVsZEpEUG5pc1FDOS80SWRGOGRrNHhDRUc3MmtGUU1F?=
 =?utf-8?B?RDFPR0p6SW9sLzZQOUdiWXZQekNMTWp5a2l2SUdxL2JOREhNZHplSzZUc3p6?=
 =?utf-8?B?T0hEQzNodnNYTkRnN1Irb1Uza0x0NmRsbW51SUlOSCttZDFQWm9VYTcyRnRJ?=
 =?utf-8?B?Sk16d2Vra2NoZUVNRElMc1VBRkRZOTNZSG9yckxCNHIxY2Q0RWNoWmR4Tldz?=
 =?utf-8?B?cjBkYzUyZU9UM2VSSFNPUWllRDNoV2RGY0lCS2Uzc3FOTXNmUzZXZHQ5YTgr?=
 =?utf-8?B?RnhXeVJJKys1bm5QMmNjbzFFMGpyajJVYUhacEpMNFdxYnBvYjlQSWZnTHlL?=
 =?utf-8?B?dFQ2U1o3bFI1a3B3Ylg4ZlI0cVo1TFlWb0xTTFhZc0dINXVHUEdOZXRBYy9M?=
 =?utf-8?B?OXdyaExac0Q5ZmNORkJwcTE0SnBoUGN3L2NqTkVHS28rcGNEbHo3azVYSlNu?=
 =?utf-8?Q?ycnFWZx2fBJd1Y/P/BlO76tEuNTxTepw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRTRzI3TVZCMEZ4dXd5bjgyME9KWGludFFzUGVVZnNQZGxuRytKTG9mWVpl?=
 =?utf-8?B?OGhNSDZBcDhEWUZKYjdaYXFRWkg3ckV1VndzM2ppTGV6MmV4byttWE44Qkov?=
 =?utf-8?B?MmRJdVkvbis1MC93VWxmR3BPZURzcS94ODcvU1FvL1hvLy9qNTh3elc5cXlv?=
 =?utf-8?B?d1pFS1FlREkxYmJQZkt4UFVLZWtXV2xWWXhvejJIUU9aVGFQbVdqMFdhcTd5?=
 =?utf-8?B?K3JxRlBKWXlpUmd4dy9BeHNVTm5UOTdpN0F4RzRzMHZLditUcnp2a3dKWDU5?=
 =?utf-8?B?SjdVUnJyYXkyR1NoaHIxYXRna0NWRzRVSTBKRDFGWXgzbXBiTmJIZWNialdX?=
 =?utf-8?B?QTJybnJGQ0RuWWIrS09pL1BRemI0dGVFV3UrTDlucnZOcENwRWZxTzlaZ1JF?=
 =?utf-8?B?UGFmMU1ibms2RmVNeW5RdndQTWVRaklFNHVURUNuSStUS0RuQ2wrM0RncXk3?=
 =?utf-8?B?aWZiNWdycmVRQXlQRUdNd0xKQm0wbUJRbU1WOUMyNERXaERXNmM4V3dJNmhY?=
 =?utf-8?B?cHBac1BqaHJFUFJ0c3RQYjRkMTRFcVI3ekNqZkRJbHZEOE1HRzIyWm12MVJP?=
 =?utf-8?B?bWY1eDNmcHg3aXBHb0xYeHVYbjB2QVgza0NDMGZnZHlPeVFoZEE5Qm0xT05S?=
 =?utf-8?B?R2ZHSE5wMEZZSXp2ZkZtQzN0RXdlaWlrcHlkVmlNcG16VDU4Wlh2S1FtT1JM?=
 =?utf-8?B?VEg5UnNhTXZWNzhhdkF1SGxuRnFpU1JwVGVHd1BTSWR6VVIrZ3VZWGswVEtG?=
 =?utf-8?B?YUZybHpxcFJYNVRvLytoMHBsQkdiRzRnT2FzZXhlOEE4NmRJV05zL3FLUWJC?=
 =?utf-8?B?RGgxbDNnN2JaUHh6aHcrOHFLTVZGeEV4VVRLYnJiMWh3NTlja2tqYmlBL1pE?=
 =?utf-8?B?MnF5d1BVdGcyaC9JZkxlT092WUN6Y3BsZlpMcU52d2doOWVFbDJQNkFjVm1V?=
 =?utf-8?B?Vk1nT1V2WDY0RmtWcUY4KzVIUzhkMUJvdXRhbjROaFUvM282blEzb0Q5UUhS?=
 =?utf-8?B?Y1ByaVhldDNCSnA0NnN3ZmJDdm5YS0t4dmV5KzNnNXRXTmxZb09RNWVNOTlK?=
 =?utf-8?B?U1cyZG1aVHgwRlhlWEJZcG1qKzA2akE4amo5NmFUaXFsTmtid0tNSWxZRStX?=
 =?utf-8?B?UlpoSDQ1bzN6V1FCK2dSaC80VHdJaFl4UDF1RlpGaFlidVROeDkwYlc2MG9M?=
 =?utf-8?B?aksrOW9GNERZellCb0QwcTB3R2QrR284NllpSGVCSW5MRXBLYks5c2d3NCtK?=
 =?utf-8?B?TG12TjBaOThXYW5obGhPZUIzVUhQY1FzY1Z3QjFEQ2VwTVYyZ3ZaejRxUGRu?=
 =?utf-8?B?dzZtMnNrdUI5OHlqVlRSUHM2UnVyVzkrY2dSTHE4QXZERDZDc1NwbGhDV0Vj?=
 =?utf-8?B?Z2tOVC9peTBXb0h3ODVHaDN4N3NzV0JveGhrZ08xTlVrUExJMUJHdlhHWlQ3?=
 =?utf-8?B?aGp0YkdtZGlRYkFka1hwL0lXU2VndWEzR3R1ay9Xa2xWREUxVXpJUnI3cXJR?=
 =?utf-8?B?R1lYZFhjY1FRRDBKcVBMbGlOQ0FWOU84T1NFRzZhMFZlVDBLMkhKTUhFc2Yz?=
 =?utf-8?B?RHFSOFEzWk9MbUlZN0lsM3c3L25pRjNZdCswakdqWnZ2elZkMmJXTC8vVkdh?=
 =?utf-8?B?NUpUYnRDUTltbzJHaFB0SDE5QXFadksyd1hBRmpBckxGYkdQM240Vi9RQzVl?=
 =?utf-8?B?NkFyTmFDRmhNWURNckhoZUx0TWswRmhSTkdHYWZtK2xpNk9lZVA4QTV2ak8z?=
 =?utf-8?B?ZnROejNJYnNLQ0lIa01DY0FpRGNDTHZvejRUS2JrU2xDUTZLQ0tzNFREYnMr?=
 =?utf-8?B?Q2EvdWpFZ0hqbStXZG1vd1c4Tkl3OFJCeitIcWR2Vm5qV1JhSCtndWNHZHlK?=
 =?utf-8?B?T1QwcjFIVmtrMENIUXNLT3NnWkdmamE4SmIrNk0wZEhVdnp2ZFY0aDM1Zm9T?=
 =?utf-8?B?TGdQVnV0NUVLS2pPWExaaHNyTWhlQkVZczlBc3VaYURIcXhlY1JXL1NOY0FJ?=
 =?utf-8?B?OFdCTSthNHk5Q0FicG1tQno0SHVYN294SkJSVkozZFNJTjc3V3VtekhNQVB1?=
 =?utf-8?B?MWVIZFQrL0hOczRYTFlCdE1TaUsrT0d2amQ1bW1TbWNRRzlINkhQa2dWODNk?=
 =?utf-8?Q?ddKeTYUYEE61sXQw5SUamdVzq?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc447beb-74a6-4bcb-a49c-08dd4788f61f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:06:12.8283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vGPzZJeDrNiE6UTVfI4MxzLtpymD7qO47vfsg5k1FjbMa6m0NFeLwgBDDNDTsfIzCDv4XSJahX1VzgVHWAyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6976
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

Enabling ODT is required to suppress reflection of the data signal on
DDR write operation. SolidRun Armada 388 SoM only connects M_ODT[0] even
when both chip-select are used.

Enable ODT[0] for both chip-select during write only.

See also commit d09f199097d3 ("board: solidrun: clearfog: enable ddr odt0
on write for both chip-select") where this was added to SolidRun
Clearfog board which is using the same System on Module but unlike
Helios-4 without ECC memory.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/kobol/helios4/helios4.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/kobol/helios4/helios4.c b/board/kobol/helios4/helios4.c
index 4c8407bb676846dda2a1270d53a07b0df5a1d13a..7714076edf1a84fdb68d90f134273d06fa7eff3b 100644
--- a/board/kobol/helios4/helios4.c
+++ b/board/kobol/helios4/helios4.c
@@ -73,7 +73,11 @@ static struct mv_ddr_topology_map board_topology_map = {
 	MV_DDR_CFG_DEFAULT,		/* ddr configuration data source */
 	NOT_COMBINED,			/* ddr twin-die combined */
 	{ {0} },			/* raw spd data */
-	{0}				/* timing parameters */
+	{0},				/* timing parameters */
+	{ {0} },			/* electrical configuration */
+	{0,},				/* electrical parameters */
+	0x30000,			/* ODT configuration */
+	0x3,				/* clock enable mask */
 };
 
 struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)

---
base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
change-id: 20250207-a388-sr-som-odt-2-bd250cdd68bd

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

