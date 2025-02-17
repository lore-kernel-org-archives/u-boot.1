Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A471C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7E38083C;
	Mon, 17 Feb 2025 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WAtnmK5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EBC808B6; Mon, 17 Feb 2025 16:29:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6AFB807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snDrhfFGQWH+s5tpyrShqsniP8Hxy32ul/qrftS++cZeBx/6kmMWxnt3GR3iY0HnO6gk94gGaKV9neJpj1shujbwE8GQKzQpJ1W/zPw9WjKqlbkQ6VD0kdT52yLxPs9IwCDQauHgqgxzf7pG77FgjICUbGfac7RpcBAPqJbdUEDS4luiVaxi1mU6PV2ju3nxt8ei84PVytWz0atnAiPkJfgzseQS5lGpgTOClmiFdj3llRvnciyKFq9Lbud6ZVQNWGYNtq8zmnGVPyYtQpZ2Ms4Mevw+bbnbFtKHL7bd7i5Fiu3rtRXqFRCDfMEyrdb08rYF5hvtDQl7cWfpnecbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grSK2AbNc4OWV9x1NC2IayNnyvNQrOr5zHLnTepj9k0=;
 b=j06HR8IYPGoTnb9mp7sDgluIV5JpkvUjNKThLYZtI0McN5mIcNou3wx+ak23rV2xrG2IhmmkKxnBikjW6n7hBdKSWwTX/gknbGRa9wrnK1+YoNe7/HJ79ywSSvQPqZ+txNSTxPMFUMAuFi1SMOb+oNlJZX140qfW0vZZm9XvhtEltoZR9Y3lqYDa7qO71EZ/PwQU4QyitoxfmxavomJjchbXX9F3uFEAiCI1q4+dQP/dL+QOi+qhM53H972UP5RXxH20ZzUcJGH2+DdMNyRxOS2uPDJOJB5F2hQsoxFdo40Xwpmj1xLyjBQ/lH7DFrI+Aav0GzJfHPDR/kpvlAdvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grSK2AbNc4OWV9x1NC2IayNnyvNQrOr5zHLnTepj9k0=;
 b=WAtnmK5UzlaWjhxj+zhonEDhuIJMONCg4Ve0he/aRYhq+OKFSD1VHWoulYsv1xUvopeMhYrXmxDGvc+gWynC03aDDVFM7vFLIwSYVT26owltOPaKN3oXTIptrZ7L3LTNc99Cpx3TS9dv+ubOOdLUxnTFMz9uU9RYTudM4mI+qJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7166.eurprd04.prod.outlook.com (2603:10a6:800:121::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 15:29:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 15:29:23 +0000
Message-ID: <43b20b75-5a12-45be-8845-09c4174c5d44@cherry.de>
Date: Mon, 17 Feb 2025 16:29:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] lmb: check for a region's coalescing with all
 existing regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250213131104.186663-4-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9a2a61-fd69-455d-60e9-08dd4f67db3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWozeW84V1NzN0FtU2d1L1dQSjR0eEFlamdVY2h2Ni92cHVHU2tOdXNxTzU4?=
 =?utf-8?B?VEtPNkhmelFQN0JBNDBPcFhOWExRdStDMlNOL1c1NktTOVBDTkpzano2MkNI?=
 =?utf-8?B?ckRQTmRaOFVYMCtIdXliRTh5alZWbWJvbUJINDZRRktiUEt0U1JSdlNjdkl3?=
 =?utf-8?B?RWRlblhPazVDc3htaDR2S242ZXNINFBSRDVmQVZmT3F4dWxnL1NRMDd4bnNB?=
 =?utf-8?B?L0dwcDhSc3p2dy8xWnZWVU9oeDN4eno2VnNrOHUwbEZBb2ZoaTRTdUdSSitD?=
 =?utf-8?B?UGI4UTJoa2dqSkpFYWE3YVI3VXlIb3lZcVlQaVdZWUxxUVFYL0svblByQ1RJ?=
 =?utf-8?B?QklqaEhBanpTMXRMWTEzYlBEcHViODJ3V2cxK0RVaWlWaW8yaDFVWC9qbDBZ?=
 =?utf-8?B?MkVxZXREZnpVS2lNU0ZXMFdWQjVwcVBIVzJlZkxZSEJjVUlxUXRjODZ3QVd5?=
 =?utf-8?B?ZTljN1hESWlFUkVsQlBTdmFwN3NHcTkxY1h0N3N2QkJ0Y1ZOU2J1SWtaeXBK?=
 =?utf-8?B?TzNYeG9Ic0dhaVV3ZGJLemlRck1lMW5RZlVFeC9pazV2bitQRmlzZmtwLzVB?=
 =?utf-8?B?ZW5VbjhGNUJrTzQ3MHliQXdIeWdhQ3o4WkUraGQ1UWNwTGhSL0FkcnJTNFoz?=
 =?utf-8?B?KytGR215OThRaE12S2tNd254Y01EclpWdDRnMW52TEQxelJlM3pSSDBVUGU4?=
 =?utf-8?B?YU5RVis3QVZlVHZQaTBqSEhtcms1RG5QOW1QRTIvSzY2anpBMHJnZGc1YWJ5?=
 =?utf-8?B?Vm1iMlNMVW9GSWF4MnYxVFR1K1FuYURPK2d2WTRPaXYySXZjTlVZNWVWMmJa?=
 =?utf-8?B?WGFmQzhLcCtaMUN1VUZNc05BWUlpSXpodkZKa0pIVmhyV0JFTDNtYmE3NGZK?=
 =?utf-8?B?YnFaMm5xcHFSZ0srb1o5OWNHNm5YVklxTUJiUzRveFZ1TkNjS1NLZGplUjRo?=
 =?utf-8?B?aUxUVER6VDdUYngya0lrdWxpOEYvY2NXZlozUzZQN1B3MFJ4ZWw5TmFRajMx?=
 =?utf-8?B?U3ZZSEhwSUpZaWJsZDFMeFRFOFZadzFRUC9id21NU3VBNnBvZVcxZkVQMzBa?=
 =?utf-8?B?WEFwcGkzbW5STlJLQmsxM2F6RkpWWWRpWllkdHh3dU5rTDdVQkhoemZsZFU4?=
 =?utf-8?B?NlcxV0p4c0MyN2hOM0lqeE5HZlM4YVN0OGdaRmpVeE5JM1hYbVJyMDhiT2hW?=
 =?utf-8?B?azBEckk4aGhQUXQ5Q3NtSExJOUQ2TjQzVDdJZmVOQ0lJU1hpWk5nb1dpR25Y?=
 =?utf-8?B?TnJ3ZTJra2RUVkpwKzZHcnZxZVpGd0ZDQ3ZUVHdHc3AwTDZoSEh3am9Ddkt3?=
 =?utf-8?B?SnlvdEVnRFZJbVV1azI3QVhsS3NsT0JHT2wvYzFtMXZRaklvYXpINzVET2VL?=
 =?utf-8?B?TGcrenZjYS9MeXBLSTRtc0d5dm8wZHlxUEhVSWRieFhJaUYrbUQ1TzZsL3Nt?=
 =?utf-8?B?b1Q0RmkxUWJQaU9oeGFEeHVrbzZRd244TzJIMGlveUFOOTdaODBMYVA2UW9j?=
 =?utf-8?B?Q3JJM3hYbFVwTi9SV0d6OVpWVlJlS1ZnMm5wTFQweGpDT1NSaXg2bEFwdUw2?=
 =?utf-8?B?cThjODhoUENTY3JQOHdiQlBTTUg3U0tOelVUSEI0WFBDbnl2R0NhTUd0U3k2?=
 =?utf-8?B?L0xKOGtxMXhrL3pMZVlkVjlnMk9MRTBlUUtKeGZBQjAxQlBqVll0aEdtRmc0?=
 =?utf-8?B?ck5scnh2MkwyV3ZBSVBteTNKWkpUbThNTFQ1VklqOTYvM004RDE1d2hiNVRI?=
 =?utf-8?B?MDlUT3dxNTJnQXROc20yZDkvSVdrTHlJY0Jkc3ZkWWhjeStKRnNJL1NJdHZQ?=
 =?utf-8?B?eWFEUjZKSE5Nd0pyNDF1RFNDVFE1V2hIT0ZERzVJOGhLRjlTRWRaaUpyT0lB?=
 =?utf-8?Q?ISOzsNvoIws56?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNjZml1WjFEUUpCaVozMVlaYSszK1h2VEdoZSs4YlpsbFhlOFJaZG1kd3dT?=
 =?utf-8?B?ODRFUEdxY2hHY2NJbWxkRDRhL2RiaG10WExWdk1zV1c5UVNZYWkybHFTV0tL?=
 =?utf-8?B?d0Qxcm1DdkY2clFzTGE4MHBpNjlZOGVXcTZSVy9vZFZTbWd5ZUovckZsYnZT?=
 =?utf-8?B?V2xXY3ZTdjNsWXY5dUpoVVpjSGJmL2ZVMFZDOHRUZlRUZjQ3cmQyTFpVMURw?=
 =?utf-8?B?VEZFMEJIb0Evc1JvK0lYUm9McXA2SzF4SXBsSVp2SzFIekJOQUY0elAzQ09N?=
 =?utf-8?B?Y2dlOW9MM00wQ3NnVmRIc0NVU2dnWUNFdE80OUx5K1BwNkpKQm1pSXlPRzY4?=
 =?utf-8?B?a2hGSW9sMVAwcmdSamg0YmNVckZzbWZMaGRpUFQxaWNReGE4cnhQeFhVdGNE?=
 =?utf-8?B?cEJUQ2xVOWR4SmxMMU1YajV0OFpYRWRQMThMcm5JUTNpbEdNUUlwc0crd1Zx?=
 =?utf-8?B?Y2xiQ3J1aHVYUUQwQnNtQmFOTEN3T0tFV2haWlhyK0RYTjhhYjkyay9UNk45?=
 =?utf-8?B?bW04WUgxMFRCMzYvWXIxTjB1RUMzY3c2dWtOKzhBeEJGVUIxcHYzU2VnL3E0?=
 =?utf-8?B?ejBtVThnZTZ3bFFKMk9sNWlpZU5wc1pqUTVHcEl0UzZqL08zOHluK1A1RmhE?=
 =?utf-8?B?K2lOOVRrWnZRa2JtSlJBK2RkUithRWlOTm13RGFzQnE2WWNsMnpBa1c2eVZi?=
 =?utf-8?B?SXZBNG4yWUczOXZyNTY3YXFxd0RLNU92a05jQ1RmOFJ1OFE0VEo4VHJod2tY?=
 =?utf-8?B?b3RCTm9SRVdFZmkrR0RCM3NQaWczSDNtL0lWNU9TQUFUTS9qMnRjcFBNWEtI?=
 =?utf-8?B?Ykp0cHVTWWhZMVZPaWhNTEFOM3VGRW13L3FEYTBzR0xSbTJwalNodEJTUGNl?=
 =?utf-8?B?RzgwQ2VJcVN6YWJHWkhIMWl0YzJDcENCVlJhZlhYci9yZGdsYmF1bGRGRXl6?=
 =?utf-8?B?bitHdzE0TzRpMUQ0bVVkRDhJZjArZU8vUHB5ZEpoMWhITlphRXhwQi9vQ3By?=
 =?utf-8?B?TFQ0M1VobkxmQ1VUZHZjcVNudkVXSUFvazFkbkRxU3dJRGVDWFNCTExyTGw1?=
 =?utf-8?B?Ymwxdy9WYUtEVDBJNFgrb3RITjlCaVJ1dndqMDZHS05LRW1zZGJVNktaZ3Ny?=
 =?utf-8?B?Y1A5b2JDaTk5NlVzam5BVzQxZjJUelVvTlBCN2Y3VWMrNjNzKzQwSlZ6U0Yz?=
 =?utf-8?B?Q0w5MW0xdFFMZFVyM2FvcmJwZ1FBeWRGaS9tNHJCYUxnMzFCb2pPMEI5RTdL?=
 =?utf-8?B?UTdScTc1cDFRVzh5b1pvNHhlOGdBSVlvdGVVTW1UWUFOUzgwNmh2UExRUjZ4?=
 =?utf-8?B?SU1nT216M3BhNFExSE1pc2lVa1NJK2hXVFFxdEQ0R3ErVG9CMkFic01GUU1P?=
 =?utf-8?B?ZUx3OWtlazk4VzN6YTllOEp4VTduSDFCUW9BVENQVU05KzVzK1dxWXhLUGxm?=
 =?utf-8?B?ZjFZVFI4TmkzbUQ1OHlzWWpqTndMTVViY1NkaDdQdjhWWlU2bld4T211MkRl?=
 =?utf-8?B?SkN5OWZ2LzdCa2t5OTJRT0tmRStKT2llN0FxZmU4VEdEWWlEdVRqN1dEcU03?=
 =?utf-8?B?NjZ3N0syN21qT0F1QmdzTkJLNnJMa25HL2VVN0daU1VHdEVSOGR1R0t4bXp1?=
 =?utf-8?B?S2xxZnd2Y2xGcVphMVhZT3Y4NVhyVlR3bUZhbStiSkpCYWJVdnE0ZVA4TkRi?=
 =?utf-8?B?dWhHV0tiYm83YXJjRnNMTDJDVDhLRlFQVGpBQ1RxVDZnWVpXWkROMkVvT1Vm?=
 =?utf-8?B?ZkJHMzdnbmYvTnQ1L3lqQTljNWsyanRXTlQ5eGI3SFZiZENGZjdrcGlLemhE?=
 =?utf-8?B?NGUzcU1wRVRPV0VuUEZNZVRRZm9vdU1POERhdy9ZeHpra1FoMDNieE9saWx5?=
 =?utf-8?B?SVBUTG1WZU9DU2s1SnphMjBuVWVGbWhGVHRNMTZnV2kyelo1UlFmaHFUaVpQ?=
 =?utf-8?B?WGM2amxwSlhpNlZNKzMzWEtSYjd1QVB3ZndGaTJUWTREenpkanlSeDF1YUM4?=
 =?utf-8?B?bVhLMmdOYzYxTHlOT0hOWU9NT1pvZDlLM3EyU3ZqWmJXbkUvQXZ0U1M2Y0JM?=
 =?utf-8?B?WERreUFWVFBQdUlaMUI4bkduTFE2ZHFDYk1TeTF4amdyWjBocVo4N0JhNS8x?=
 =?utf-8?B?NllYS3ZtejNyR1FlODJ5MmtMWDBlY3Rjd09GTGQxM1JhelRYY0t1QzgrZ1RJ?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9a2a61-fd69-455d-60e9-08dd4f67db3b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:29:23.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4lkczh4r0lOoTuUuiqhTV14yfRzNCdrjUfN5pkhI6Ovayvyg2FocKR4E+PPFD2ZIAJUkipJF2lnL5DE/xiDmULA+EvKIzKOCLEL3C25EdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7166
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

Hi Sughosh,

On 2/13/25 2:11 PM, Sughosh Ganu wrote:
> The lmb_add_region_flags() first checks if the new region to be added
> can be coalesced with existing regions. The check stops if the two
> regions are adjecent but their flags do not match. However, it is
> possible that the newly added region might be adjacent with the next
> existing region and with matching flags. Check for this possibility by
> not breaking out of the loop.
> 

What do you mean exactly?

I know nothing about LMB, but I assume a region can only ever exist once 
and with one set of flags? This means a region can only ever have two 
adjacent regions, before itself and after itself.

It doesn't make sense to continue iterating if the adjacent region that 
has a different flag is after the region to be created since we won't 
find a new one, so we could break if base1 < base2 for ret > 0 below?

What do you think?

Cheers,
Quentin
