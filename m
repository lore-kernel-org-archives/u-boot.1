Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB3DC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A997E887F3;
	Mon, 15 Jul 2024 16:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OojZg7m+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B5687B84; Mon, 15 Jul 2024 16:12:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEE7887F3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm4VaQUSBgB62qJaL7dZuzZAR3i7iK1oY18gElTpaSDmi0nq2t2XeDIFeefTc0DgnzzURSgfpp0Z0frs7Y0r2eEUPwFw4rZrXPl+Vp4D4BHsS8EdvZ/L+W1H2/bTU7Vo0YL9yl+Too/iHlp6PjiB1XAzOSGlI1nQEiFbzRsmWQUHPlMRGsuDrXkSnSQy4HrdtJ4+6fSmztRyqH71gP4GiD32V8eQwpGZccCl/LreKD1KNyo0BNrxgBo/Kt9bB7OKiH2dF41o7jN6VwTpvDvSZNzpnNp43seQZ+D5VqYul6QnOEj2bDttOxtkiDrPS9jjA5TPWZkrSaPQzY5ot23Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM1ez58Zi0AF08z8D/Z2SY2vMlLRmYC0O5qU5nuciXo=;
 b=AAxusghJVpWRqvXZj8n82DwnXoDLdrjL1nHjsKZGl+7OY935cn5ld1EvXasyOZ3JO/JEDA8b19rsCKxhPF6lHWl/gucaSA84EFlXLhp0QlunaLntteGUtnPtFsE5wtmseoqnYqtPyDPUsrXY1zYvqpLWJV2hXvx9CuhBM7bQujIUQAqu04S48WYOFzcovnV0EPZFKPV4XCjYsH+3bc3OLb8nH9Nj71karAu957cX2R45/PKkmrMXHFcqCdxkQ2Kb7L8YqxwuPz3k+MeLKENGy9BIwfPQChGs6hiriAe0aOOLq8PDrpXixFN28UL1Cm5uNAqI4aB4RqDleXvu/P1xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM1ez58Zi0AF08z8D/Z2SY2vMlLRmYC0O5qU5nuciXo=;
 b=OojZg7m+se6gaSpJe/f2IQeUo6xpF0guEajvIOrWZwZGxSmsVbkTnrV327J92ni4hyWgrlpCo855kc2/958+P0IG54w1P7RcAwwc24Fhjgbj5DhsW44RM7d0pdXicinnorMPDIVhPnQq6dx8SSRN+4KcAT9mm4MC/9Ag0r78Kuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:12:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:12:35 +0000
Message-ID: <783d9dfc-4372-4332-991f-2b06fdf2cdfb@cherry.de>
Date: Mon, 15 Jul 2024 16:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] doc: Move bootstd into its own directory
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 E Shattow <lucent@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaewon Jung <jaewon8868@gmail.com>, Janne Grunau <j@jannau.net>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 013d3bbb-13d0-4953-1bbb-08dca4d82cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUZnUXN4cE1JUElQcFdybFc4bzk5QWRGUG11RFBvRlBkUCtqQ1I5Vk4zdHFr?=
 =?utf-8?B?Ly83SEQ4WXJNeVNEYUlKbXFsN3BqcXhxY0VmaTFVVnM5NXhmWHRoNFpzYkdC?=
 =?utf-8?B?TDZEM1BOWjNyUHA2WEdvc05TUk5kSWpNcXpJMmdTVFc4amxjVWhPTEVWMlVG?=
 =?utf-8?B?Um1zSmhmcmZwVm5meFAwSHBjSGhta0dwQWZRQVFFOHgybnNoSHVobHQwVGkv?=
 =?utf-8?B?c09GTGZpQ0owd053UVRpZ3lLSVBwRHd2UWU3RTZMNUVFaTFtTml0Nzh4T2xj?=
 =?utf-8?B?cVFBeCs1cXBERUVmdFlDcnpFd29KQ0IzTHlqSDNLS2hpTHU5elFXV3IxOFMz?=
 =?utf-8?B?cWNWTGVReVB6d0xnZE5xQ2pNaE9OSGx4Y21HKy95YUZrdks4SmVIN0pJSWph?=
 =?utf-8?B?ZnR1VnhzVmx3bnRydUNtNlNJTE51NXVralljRmtMZkRWN1pIWitoZVcvSjE2?=
 =?utf-8?B?VU9sYWIvNktKaHNFaUw0SnNQTXFFM2xWMEJDd1UvdHRzOHR0bFJ4RVdqZk43?=
 =?utf-8?B?WFBEL1QxS1gvRUdFYW5sckJoTzQvVmtvamNGY1B0dlhMK1lyd1Uxb2ljeFhX?=
 =?utf-8?B?R01MTWh1ZVZNdzVMeFZZb2YzNmJ3THIyNnN3dGpwN3BhRks2b3RJNll5cGlW?=
 =?utf-8?B?ejU4Qk8zRUpRNWhkQitBcFZnTUxIaVA3UTZQbmUrVExqNllDWWtDblNxdlB5?=
 =?utf-8?B?Z0hPUDlieUpucDM3TTdXTFBOYlhSMzhUdE5rMi8vL0I4TzZZTnY2cVhvWldG?=
 =?utf-8?B?MVR6cHRodWVTSE9HTTFZZDg1VG9XL203QWM0b3Fpc2Y2aUtHaEkvYkF6Y0pz?=
 =?utf-8?B?bmhMdFQ3OElQRUZvQ2tjMnZMWXNRWm5OWTVFZXdBeHFMNmt0Y0psUGk4cXRi?=
 =?utf-8?B?V1pOdWFuQmZkc3ZIaGNKZDIzMjVVRVJsU1JFKzlzSDBCdm5keVlvZHlNWVlZ?=
 =?utf-8?B?VTcvQXRMckNvZ1NaTXdCaUV2Y3daamZkenRWS3doYlVLaUVKdjlxQWdFRUZ0?=
 =?utf-8?B?ZXF2dndpSnFEamVRUzdYK1BwWlN4ZTA0QlNaUFcreFErd0pmK0lSUVQ5RmZS?=
 =?utf-8?B?OGI5cXpYVUdNUm1zYjBuaUFpZmRBVEo3T0ZidWhXM0trbU50NHFRdDIzWUpu?=
 =?utf-8?B?TnFiZi9hcFRuTk1zd1ArTkZqZDQzSGxvd0RCSnVSNGlJKzdjYnpPN0pUREJE?=
 =?utf-8?B?RU9FUzBrbnd4bXpvTnlONjJnNTlHdFFlaVF0WXE5M2dLMzRoalNzaUV1aGVa?=
 =?utf-8?B?V3ZENWN5dlhMQTF6Ull3N1hyaWRqaVpUTHJaK3B3alZJSmpoSm4xcjZyTnFR?=
 =?utf-8?B?L0tLYmhZYWp3MVk3NmNKUzhmUy9yUnAwcnVTL2ZqcFBHRlJVd0E4R3JDTHI5?=
 =?utf-8?B?VTArOTU4UzNsWGsxRElHcE03WTh3a2taVDh0Wm5wMFhEL2llQnh4Rk51dEUw?=
 =?utf-8?B?aW1vNmFYckQ4MGpGUFVrNUIyUVlkZjJDaXZueDFWZUJIYVFTV1Q3RzdTVXRo?=
 =?utf-8?B?RnpJMGEwS2hrdVAvZVl0VWdPSk0yRXBBSWFtY2tUTm5TdlhicmNGaDdhQzgz?=
 =?utf-8?B?c0hYcGg5QTVDMndVVXg0ejhtVVpWSmhiei9xenpMbTN0ajF1a0tRTEZQK3NR?=
 =?utf-8?B?WndDQjdNTEhHR2hVT0dQa01oUDRlUkRIM3RBZGM1ZFZmbWg5REZTbDhGWE5X?=
 =?utf-8?B?Q1U4WDc3OVMrMHpnY0dvdnRDdlNIdzNrQVE1T09wNGZYYUZQL1RCcWYwSktS?=
 =?utf-8?B?YWRPSXJ3bDZLeEp6KzB0aE1iM2dUYURrczQvSk5iODBsMVYwczdKZitZNkph?=
 =?utf-8?B?OVlZUkwrNWtuVkVMTkVpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1l1a09QSVZtL3VKUmRSZ1ExZHhlck8rcGxGelJkUnVCN3oxK0xtUUZEMEty?=
 =?utf-8?B?WmpibXVrdmZWM3ZQcjdHdDFvSi9kRDdnS3EycHhpY3ZxOWUyUUdHT3dCK05u?=
 =?utf-8?B?V1lKTExFaWJOeVcwbVBVZWR4eExQMzIza2lyOElUZzAxb3JjaVdhNXl1aUlB?=
 =?utf-8?B?enBNbkYxWEhoZWJUaTNGWWhnQ1ExWFlLVUZrL29yUmZkS1daMXFaUER5R3Zm?=
 =?utf-8?B?YnN2ak9SbVk3enhIOFdOUVFDR1lQNG42ZGpQV09XNzY1LysvRi83cHllb3Bj?=
 =?utf-8?B?OEJQSnVoSjZrcDF6ZlR2a1dzcFdKaDJyQmx3SExtbzFxM3RRd2I1REMvb0l5?=
 =?utf-8?B?d3JDTHFTQ0ZFZHZWNEJkVUtDQlZ6OGtqMGdNcVVhRjRuQzA4eHlDVmVSYVpG?=
 =?utf-8?B?RGFYcHdKNHRXRkVyLzQ0U25WYUZaS3JqeUR0anBNaTZLZm1ISGkrcEMyTkZ0?=
 =?utf-8?B?OEhCRHc3d2tIMUdHVG1vdHdwVDJJamF5YmhUV2VlZVBoYXUvMW9nMUJESjk2?=
 =?utf-8?B?cnZINUYvekVXUFdndForRTkvYXhtVTd5aTk0cU1Na2hJY0pTaGNnNVJHUHho?=
 =?utf-8?B?R0JXeWZSODNhZjdVdkNTYi96VmV6cnRER3puemRGemZ2NU9GWkNKQmNHVkpu?=
 =?utf-8?B?OXFRRklmeTdJbXhhd0txaUlTbk0yVVZjclBLR0lRTWdSLzlDNFNIWGRuYXNR?=
 =?utf-8?B?WVN0SmJxeTdTWC9wMWhuQ2dzY1E4bGpiTnRGZ2NrTWFvQmJwUEo0NWRyNS83?=
 =?utf-8?B?bG9zRC9Pek05cmZ3RXR2YkxsUi9pQi8wWndBZjA2OHRBQytNQlluWE9SZ1F0?=
 =?utf-8?B?dGZrd0M2VXVqaHp3dnpSdHFYOFBvSWNxcXlvczJQQWFkcENJcm5nUWhxcU1C?=
 =?utf-8?B?WmFmSmJUZDZ6NHJvK1lvVHlzbm9ZVHFObGdzcm1UTEM5TU5IdXpLRW1XS3Rr?=
 =?utf-8?B?aDVyL0VWOWU5OFA5RUI5Rkh2Y2pCR0J0azdvYTBYWXpLZHJzOHBqTzc1ZjVS?=
 =?utf-8?B?eEVGT2hzdlZYRUYxOTd0WHc0N2FoS21RazBCcmJmbW5FZnU0SUVlVW1hVDNn?=
 =?utf-8?B?eG5MRUVJUHlSMDJGRGR5YUpCTExIR0dWSTR3SWd5NlgwWDc5Z1doMnM2MERk?=
 =?utf-8?B?bm5zUS80NTNMcDNJR0h4RG1ZZmVBSld2SGdJbHlmQmx5N2RBVkNkSEkxQk4v?=
 =?utf-8?B?cStrZk1RZ0N6eEM4anhML2ZBLys4TzY4Mkszbzd3cUsxTmd3VzVpejRrWG1V?=
 =?utf-8?B?ZlZVVURZelVpYXRWZkpCQXBZcVpKWlc0NEZ5WFBHTFZjZTBLaFBwMEV4dDZT?=
 =?utf-8?B?RENqbFppeVg3OC9peHlBOThpTEkvQnVETjN3ckkrSXliOEYvTVZUZGJWSkU5?=
 =?utf-8?B?Sjc1dW04MzcyMjhUUWJReVhDeTFIRUk1TEFuY1BMcFZJNUFEb0dWZGVxWGNY?=
 =?utf-8?B?S245SjhRMjJKZlpqbXUydVNrQXQzcGxyOEFMSmxoaGJLZlNRZDlaQ1RGd0tN?=
 =?utf-8?B?Qk4za1dkMTBtZWJBRmlXQmtURVE0em9JYWsrR2xjcXF2K1VHcVRudC9QQUNO?=
 =?utf-8?B?c01YRUJDQ3lFN0xpa2o4WUxTakRCZE1pSG9INmYvWW8wYmdjRmNSVDJMeXlW?=
 =?utf-8?B?cmgvUDNZbWkxQ0tUMG5zTmF5THkzRDFwY2I4dWlpcTZ4WnBFamVhNHhSRG1V?=
 =?utf-8?B?QlI1RGJvb1kxZVVuTDQzTXV4UC9WUHZaSFVQL0tWQStCQ2VReXpRbFJxcEtv?=
 =?utf-8?B?MWRiVm56MWxIKzUxVzZIVUlWRlM1QXdieUNEdXA5blVjNzA5SnRkM1VpYzYy?=
 =?utf-8?B?ekRiSFZsbkFpczhhb0xIaTdUUCtMbTRoVWhEMklpNDNQRFFWTmdQOEFNb1RZ?=
 =?utf-8?B?NFlaVUVjUjZWdVM5ZDhmdmZVclQ3M2lpNG9TMTBvZGE1Q3lXNnpTb2ZFbFlT?=
 =?utf-8?B?bHM2cDNKblUwRVNOSlpzV0F1QUx4aUU3MUxJcmVra0RhQTMrMWJnVEhRc05C?=
 =?utf-8?B?TDhWejVBTkR4WTh0SHl4bjA3UTNaZlpGcldGTktRZXFPbkRVUWZhZktBWmkz?=
 =?utf-8?B?S3QxTnc1NDlTYlgydGlJSFhNQmR3QW1SSlNvZWNKWmZ2aW4zb2pJT3pTSHB5?=
 =?utf-8?B?RXlJdVRvSklkY2dmbEUxVmMvNlpHM1VJVG1MT1l5WDZaOG5oS3ZuRHFEaytv?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 013d3bbb-13d0-4953-1bbb-08dca4d82cc5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:12:35.1818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjjOzbTxN5dZzktcpj+ANJ0Qpd8F2C6WEg4iImi4gohDBlSAoxTizpQQKfTnT1cRLoewhg/rVt2W8HYSVfC8tx4id6r+RoFVwTOXeWQgZrQ=
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
> Before adding more files, move the bootstd docs into a new directory,
> with an index.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
