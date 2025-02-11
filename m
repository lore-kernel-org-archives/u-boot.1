Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF226C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BDF80824;
	Tue, 11 Feb 2025 14:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i5m+Thi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2481980842; Tue, 11 Feb 2025 14:47:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91A5803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmDJw+NRWM0diTYEkdGeK603nA5iPL0H/2OombaPZwqbQncZcU/+zVniet8oLIv4PDthvUrfKtBp/ntMvjdczsfhVc434qP7/orIDbl6rklCKWN4uFMo416nVoNSK/p/IPKnPVkB/+V5orfg5JQPLp+sa0K/C11zROglyytEk15iYTJUjDNJWRQ5OJuk/XQJYGOtCrNySWgy4bY1c0Bj0DkeJdqaTChhDAcpl1nsuUyWWkJiXYjpS5xGouSizbaiwbCWHTCmpANye3FNn1tnxTuu7iDHBsTh5LFdq0mjEdrlovury4CRD2EfEoWB1kV+wKGXhhqXAEpQFiYyhE8FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYcdWh/7JBTVVcRr77piKe7Y5yncZHHsK2P+0+uOSL8=;
 b=vPWtouOv+b31/MDG3/MY3tgMe6QIraOFMsbpY7il0xw6ullfNWNsBLgFg1gbkXpqvhEpEsvLW2ODORQ6X6Ch5OpScHbH16rF8eDe2X+5sm2H4NVHViP/VLmETIHLsoKL4jAkd7TxcdE8Gf/8sgy5VLTBWqSbUCM3O8CzpdW8N5H+c1myBogdrWnJYtglMemZjTesHrHwxUERJo8okGkQhysi66zlbjMBW1IsrvGbu7iNRU7lBIXFQ/+v6A77Pt3BkRSqJS/R3K+ljS3ptOs+lriNol+S9cOdZhX5u6jNe4W5iKqNSo1Oyn/wcEMe3ZPPK1afF0FgF28kizNb7WYgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYcdWh/7JBTVVcRr77piKe7Y5yncZHHsK2P+0+uOSL8=;
 b=i5m+Thi8jheQkKBUB/ooQKIjUqMCarbM4RC8IzceC1BzCVxkUOzpSXzWNCHfwdSZYTMokD/YWFuAXslyKAqKlweqcKQ1yTLfbvmkuiaM7byLXJ1X8TBRq6sZ/hLfKeCrXxj4VUs1S7wn06yNuhPiIout+P3yAjxtighHPSiEwQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9579.eurprd04.prod.outlook.com (2603:10a6:10:306::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Tue, 11 Feb
 2025 13:47:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 13:47:34 +0000
Message-ID: <ec7c85b2-9275-497b-abcb-3daeb39f796e@cherry.de>
Date: Tue, 11 Feb 2025 14:47:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250211133116.28833-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250211133116.28833-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c15b8-343f-4ac1-8fcb-08dd4aa2a395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z204Sk55UlgxdWVsaUovanhJSmczcWwwbmdIS0xFa0RRQzc1V3VjWTcveFZY?=
 =?utf-8?B?V3BQZW5HZm45N0QxTklLci9pdEZjYjdzaEJrRTlON21HUmV2QzdLL1RDZmxz?=
 =?utf-8?B?MjNGa2VYdDJzRXZ3dkljWEtSZ3czNEoyS1E4djJIalpjbmFBUkVaYjczYjNW?=
 =?utf-8?B?alY5WjNOd08rMVBVTTQzdjh5b1A0eURVOWJPVW9lVCtFZ0Q2bW1KdVlzb3RU?=
 =?utf-8?B?blZDbmVYdGlNSy9MOHV3OUtnU255dU9qWFVxZWo2aHM1K2lIdGpOdWhnejVE?=
 =?utf-8?B?NUFEYUJES2ZQQk1qUXFPRFpoSFA3Mm0rZXd1UUw1cmViazRud1paWnJYVXJR?=
 =?utf-8?B?Wm1EZHJkNUlxcXVvRTVrenkvdkkwRUxlZkxOU0N0Y01rU2xXN0RmZXA3MnFX?=
 =?utf-8?B?UlMzUUcyQno2SG5ZYjYraEozMDg2N1F4bUVDRVhkQ1k3OGEzU0J3RHorSzg4?=
 =?utf-8?B?VjA2QkFQcWJHdnV0QUcrRGdlQUkvTGw3SzVqbUFGSUlva1Z4NWNsL0l3QSsz?=
 =?utf-8?B?djVucHNzUnBmYTFRNC8veEF0ZUR6SGJhdnFwV0JPdzM2cWJHRE9lVmlOR1No?=
 =?utf-8?B?akFwTEVIcUdrN0I1MkQ4WTZrb1NQOGt5aHpXMHNnYUwrYVNsbUNKWFhEYjVq?=
 =?utf-8?B?ZkcxdUZydVZ4WjhkbVFWbUpSd21CdklhYnk0NW9FNXJYMEg3VFNqalB2Zlpn?=
 =?utf-8?B?WDZuUktYQTJERk5HWUxEU09BV3lPOFcwL3hrQmpjVUtPUXI1eVR5SGhrU3RV?=
 =?utf-8?B?Y1VoNFZIaHJBTU9aRE9XUDk0UEc3MklPTFZ6cEYrNnZmeHc0dmVPNzVnVHYr?=
 =?utf-8?B?ZFJESFlQQkR0dWEwYkFYTzU5RmZVV2NTWVhZdCtVVUtjbmxTZlJ3KytFMVFZ?=
 =?utf-8?B?TUJqdk9VejYyb2xhV1lKbjU3RkdtSlJYYktKa3kzNXJZZk52eEhZOFRDc2cw?=
 =?utf-8?B?MFhpajZiL3VjZlRCVzNZb3loM1RtdGU0V244Z0ltVTgwRTdBczdlRzRMdnY5?=
 =?utf-8?B?NVVIekI5M1I5OFg1enBtRzc0RlVhWGRLcFhhK0xzVWhFRy9HcDZpUXhxSzdN?=
 =?utf-8?B?RHhka25tR1IvTHd3RFlnb2FYWXpHbE5saDZqSTdyWDB5Ym1aOTVhc1NKM09H?=
 =?utf-8?B?SkprTUFiZXVleW9rTExLYmFZUk1nOHNXRWlhLzdnY0l6bnV3cWR6eDF3bnJ6?=
 =?utf-8?B?TFJJZy80c3RTS2dXWlhHcnVOYlVrdUJ4SFRkd0dpRjRnbHQ1SisycUZRWkMv?=
 =?utf-8?B?MklmcTBKd2FmeFpZZ29KMDlFVCtXb2VqRlNHRWQyZWtVb2FRVHBoSTVMRm5u?=
 =?utf-8?B?YlhoUXVReHU1ckluUHhoRUMvMkxGWmNLbGdER0Jqa3pjVVVXbGdrNFI4ajk3?=
 =?utf-8?B?WVFNWG9oU1VlY0tKbTZRbHM4RVJuZW10VmcxVTRTeDh6Q0VGU1U1cDNrUGZJ?=
 =?utf-8?B?MTNxR2ladHVXM0xja3daMEZ6c0NsYmxvZzRXNmluOHhobng2RUlOTzc3V25R?=
 =?utf-8?B?S1dOb21wRWpkTFpFZ0s5SmtTRXVUK1BiZ1JmMEVVSVB1RWV5ak9vTlQ4eDQ3?=
 =?utf-8?B?bExOYlR1bUNZWkE0TGwyY1JhdlNtZWhMM1NtRzJpcjBJUllBQjUrSTZMcHRo?=
 =?utf-8?B?Y0tQZmtSWGcvK01BcFpXQTY0MW12eXAweml0TlF3dmxSeFRkRFdIdVRJSU15?=
 =?utf-8?B?SDF2YVA1NGowSXEzdHhQbzJVN3lXaWszUzhOb3N1MG1KaGw5dnRxZVpiSzR4?=
 =?utf-8?B?cStJd1JNcitOMVJvRWo5UTczaGY0KzhFaE5LWnNlTXpmR0hMQ3o3L0xtelBk?=
 =?utf-8?B?RUk0QnlKQWNwOEg0TzRGZW5OWUFmVjBFaUpGem9uYzludEoyUDBvQkpaelM0?=
 =?utf-8?Q?izetpnWwJCYB6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtYWkZ4VHhRSXJOWlNBWW5CbFpOMU5zeC90blBHUmhURUFjajJRelhmU2Ji?=
 =?utf-8?B?d3RKR3lKUHFMTWZHeml0c0l1dmZjeHBvaTdFRDlUWGNqVnRuM3hERGtCblZK?=
 =?utf-8?B?WlQ0OU93V1dlNlZTQnF0citlUTFoQzlKc1hyVWwzNDg4MHRqSnRyZ05qNFda?=
 =?utf-8?B?YXNuNklWbXRTSkNXM0xWWnhRVnRzYVVueXhoY1FidkZOR2pZRWVyS2NvZHlK?=
 =?utf-8?B?bGRhdUdnYVRkOHp4VFpmUTRvd09MbnlsS2hZNGlDSElReEQ2bG14SDI3VUp2?=
 =?utf-8?B?OUZzRFg1VjNidXZZT3FJdWxyWU8vTlZNd1BaRWVXUTVPWnRhN2VrYVh5cmJH?=
 =?utf-8?B?d1Y0OWZEMG9GZFI1RFBlNWtNWlo5b01iUXJEVG5RM2VlaFpFMjMveTVhQVZW?=
 =?utf-8?B?YWN3NjhNRXdxbUxybWxzaXA5cGhhMmViVmk0cmRJQXYxTEhudUdvbEM2RGdY?=
 =?utf-8?B?cFVXelBORFFaR0l4VFpucU9wV1ZkRGd6SFhqSFZxS2E5T1lOc29DOENIUWxQ?=
 =?utf-8?B?ZUpPc29sSFJzQ2lQY3ZRYzRvZU1nZXJWbEJrZ1haWmxLOEV0OGU2aGNPZTUx?=
 =?utf-8?B?YWdmM3Buak90ci84UnZHQjl1dGpZMFhKbUxOTkxaTk12ZUdYL01VaGJlZW5I?=
 =?utf-8?B?d3NyMHVXY2hPOVp1V0FBaTdIV2JLOFFrbkw4aXBDYjk4MkdXWnNZSjlpaDlP?=
 =?utf-8?B?dTRDcjVFbkRNWTVMMzBtOXQxUGsvditJUXJTQ1pneGtKK1VTN2dZN3Y5aFVW?=
 =?utf-8?B?RFhUYklVZWhBYlZLTzNEemk0aHRtQlAxRFFZSW90NkQzbmhiNWdKZVhPUVRS?=
 =?utf-8?B?UTI2TnpwVHk4R1dTZXhCeHNVRWZHRXc5cWZjUW9kSHU3QVBneXBydEdYNWRX?=
 =?utf-8?B?ZUJYTWh6RUt0WGM4dDZMbmpIRTBMWEZrN2NiOW1aVmFUa3krWXdwR0xYYU9x?=
 =?utf-8?B?VUthcEJJOXoza3p5YjNRWU03bUNMVEZrYTJQU1Vsb2dOTUdROUlnNHVNNUNH?=
 =?utf-8?B?RE5EMk1tZmoya0RHVU5EdVp0SE1DR0VzMUNxdm9TNUVWaCs4dHRhc2U4UFV2?=
 =?utf-8?B?dzZLWlBrUHd1VjZLSjJhMnN6Njc3TWVGSlQzaXYxbWZOU2Jab1J5cWREbWNJ?=
 =?utf-8?B?MVowYmtNSStIdlR4L3JJTXJHbkZtMkcrNEpkNFFNOUZzY3h2cW16bnRoYk5U?=
 =?utf-8?B?eEJnZEZnZk1tOUw3UFRNeWRQRFJTY3E1L0MyNUlNUS80M2R6S2w4OFBBajIz?=
 =?utf-8?B?K1BQVWozTUQ5eURCU3ZFbUZKMC9XcjJHR3NKelFhenBUQlZUOWxiblFwMEFN?=
 =?utf-8?B?dGVBeG9OMm55OWxvMmUyYW0vcVhUWEp2TkJDMGYrck1YU2NkaU80TnlCaHc0?=
 =?utf-8?B?cjluUlAvMFhjRzU0L3JmTXhkZTBHK2c0Ri81UWRGQm9BZ3lScVpoWTZOQ0Nz?=
 =?utf-8?B?TTFtdnRwWHhDajFWajdTMy9UZUFhS1lVSXRZK1ZnWWJVYmpHU1ZGN3VrSDY0?=
 =?utf-8?B?eWprTEs0ZjlmRmh5M1NKVnAyTE1YYzgyWExpS3NzaUNRc3o4bnQwcXZvczhx?=
 =?utf-8?B?NmxBOEFKQ2JuVlNOWFVncGVWTENZV1V2MGR4Q29mbGppVHcrczVzZzNqTGpt?=
 =?utf-8?B?UFdMZmwxR0xONVZYMUFkUlcyRmdDbGV2SmhlZ1VQbmFkWkNIUFNQcHFHMlJX?=
 =?utf-8?B?QlFCSHUvYXRjODFBOTBXaWNXT0NmbEZEQm1kMTBUeFQwRk1XWmZWaUQzUnVG?=
 =?utf-8?B?c2VhNUpHakVxa3FOUDJ4S2JGYVhVNVZ6NDRhUHJHcW1PSmVzU3NvaUw2NHVO?=
 =?utf-8?B?Mm9IZUdqRHZHK2k2YXI2YzlMaklpUnYySE12Wml0MUQxMG5Ub2hnc3g0QU5K?=
 =?utf-8?B?bm01bUVSZGg2U3FVNldzVGE1WXl6MlJBN3d2b3cyZXNRdit1ODJ2YW5GUGJI?=
 =?utf-8?B?bVl3T05nQnY3M0VsOFZjV2c2a2orTmFOS2dMaVNKU3FWc0JyZGtwVHJNeENE?=
 =?utf-8?B?VjgwOUlOcEw1aFZSNlQ2ajBnWTVEQVFjN1VuUldGSy9abGsvZ2REVVNTSFhv?=
 =?utf-8?B?RDk5Y0hLRDhNbUdIZTlidjdtRWUyY2IzZUVSV3ZSbjZnK3EwQ0FHUzRYa2hH?=
 =?utf-8?B?VHgvRWxIR1E3WjZwYSt2YzFsbjVGek5BSWFiMTAvVHZSZzZBc0dDV1FWRmJZ?=
 =?utf-8?Q?pgJZoBRXuNkJ/PYzEqYtHEc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c15b8-343f-4ac1-8fcb-08dd4aa2a395
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:47:34.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HqhEXinoDO8GAodSaTHUzejicIbuCoT/4b77XMHdQl6roi/xika6wJydYhIlILutnodyqyOsAZ/RmT1HkLfbtEdhuHvm0a6rzdhtcq8U3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9579
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

Hi Marek,

On 2/11/25 2:31 PM, Marek Vasut wrote:
> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
> 
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Rename mmc_env_hwpart_redund() to mmc_env_is_redundant_in_both_boot_hwparts()
>      - Return bool
> ---
>   env/mmc.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 379f5ec9be7..c4467333263 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -40,18 +40,6 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -/*
> - * In case the environment is redundant, stored in eMMC hardware boot
> - * partition and the environment and redundant environment offsets are
> - * identical, store the environment and redundant environment in both
> - * eMMC boot partitions, one copy in each.
> - * */
> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
> -     (CONFIG_SYS_MMC_ENV_PART == 1) && \
> -     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
> -#define ENV_MMC_HWPART_REDUND	1
> -#endif
> -
>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>   
>   static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
>   }
>   #endif
>   
> +static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
> +{
> +	/*
> +	 * In case the environment is redundant, stored in eMMC hardware boot
> +	 * partition and the environment and redundant environment offsets are
> +	 * identical, store the environment and redundant environment in both
> +	 * eMMC boot partitions, one copy in each.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
> +		return false;
> +
> +	if (CONFIG_SYS_MMC_ENV_PART != 1)

Oof what a terrible name for the actual meaning :/

           MMC hardware partition device number on the platform where the
           environment is stored.  Note that this is not related to any 
software
           defined partition table but instead if we are in the user 
area, which is
           partition 0 or the first boot partition, which is 1 or some 
other defined
           partition.

Would benefit from a small comment making this less confusing in the code.

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Less obscure ifdefery makes me happy.

Thanks!
Quentin
