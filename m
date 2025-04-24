Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39984C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C024809A5;
	Thu, 24 Apr 2025 10:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="js+EqiTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB6E809D4; Thu, 24 Apr 2025 10:14:28 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160CF8082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRCYji9z648iDqIVXCP+4FnK270pnjvP5qZlw2tJzB73aFAOvRAKBUo1tQrvSkfWUptIymnUmhijJvrVchfRvArKNY/rrQIk0c1nDAXtjS2VBW3FBBsnyuZMOEJNT58iFZEGhmminVfg8VJWEtut7lQxg4nTv22YGoTx7hwknLrlGc8O+KI98znkAsFHZcWvCNcP5rpXQja07ZSvS1rMcC1HWGtU5/5dJ9dMQyvxeukHeB++yAJwI15jZQCtoLxzqui9EfgsG7/dsm5wPqU5+Gm6T5mN0LBaSBlpjG2envY7CPCVBdlbyUWCam6LebE91EyjX4Purj5WSMvFU+b3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awAjRdjBUhxKbUyNcyirp1KFZ93OZNDlKLY+OWCGhiA=;
 b=iZ3y0jGNZUoBJ9SG8B9VzzCY5/1iirOtD3qKUvY7TjW2ef2ltFWa/6GRuaxwDB81XJYCZxH2gpZbezIAvYVwmwN53T+bNsbFA9Vfkc3NXlHf0mZ1p6omyaY5D7Lqc4MDFIiZGo1l+ZVvwnhIRCrzYLbGxKUzDxlm9nYa0NRGEci6eqebO3P6mNOs+fcXqjDBhC2g8uNTWhpXAtluhymJYTkKCCooryF0C/+hLFtEFB8n4XoAF3bRFqXk80qBa4g7LDDWYxBsmheqavW5DcnnpKQLRPCY7pTsLyK+epeRKVS0DSkx9pxxWf76zzn3YdFeClGoeAW8aN+ieUIv7kSlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awAjRdjBUhxKbUyNcyirp1KFZ93OZNDlKLY+OWCGhiA=;
 b=js+EqiTIAZOPbQH+Kq8lf3tA9rsKAWmVgmFn4WNDJfV/GTuXfMyMrrxjbUc6UBqqBvrfpLtTjJp8JDPa7cte+otPk7uIsQBITbzRBY5jDBLUbNAvWy0YZedo9ZN3GphgepMhahWOmhf88SPCqCRJfwCCJNaWVlln/2yE+xpRywQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8124.eurprd04.prod.outlook.com (2603:10a6:10:246::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 08:14:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:14:21 +0000
Message-ID: <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
Date: Thu, 24 Apr 2025 10:14:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
 <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
 <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: b7790a4c-b013-4366-a52e-08dd83080426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0s1cTlLei9KdGhXYUdUUmU5MVM1alR4T0cwOGkrT0I0RElHSmp5MlFwUmgx?=
 =?utf-8?B?eGd4U3BOV1lqa1QyeUd6WE9BSG1YMFdFVmlCMktyUzUzZWR3L3cwSFlaS2RW?=
 =?utf-8?B?eTJZb09CbEFhRmYxdE02eFovbjNSWkc4R1ZJcVFCNThKL3dKK3pxOE1KaWg4?=
 =?utf-8?B?NWlKZmxCOWJHbmZ6T3VLMTR3a3RDSzF2QTRIbmw2ZGtEblRiUnRSTU9kY0ZV?=
 =?utf-8?B?M1d6UGJ4bGJHRzNrOTBYcXd3UHp3N2l2L01mbUlEalJ1Rlp0ZVJvaHFGOU10?=
 =?utf-8?B?dml1dUQxY0dOYnl3R2dQYzZTanBQZTU4YS9obGxUcStCN3crN3BCZ2RJMEJD?=
 =?utf-8?B?RzY2THNZSER2TmU3cDlhSm1mcU5oM0VVclMwSEN2aEtVdUZZZmxpU1o2WXRS?=
 =?utf-8?B?OW1HK2swN01OOWRoMmJZWllPWTE4QnhBUGxYMmY4VGlDc2ZmZndHQ1RFZURB?=
 =?utf-8?B?cVZpTWh5eGhINW9DSHN3UTRya1pPWm81bEFCNW9yanltbEFEYXI2SHNGcG1K?=
 =?utf-8?B?eUMybDRRbUVMRUl1MUlCM0NvVjNaQ0U0ZHlZRTMwbzB2WEpCK0d1eklHbnIz?=
 =?utf-8?B?Q0Y1WHZ2RzZmQnFpY1A0anRTRmdOYzlhaHJYNVBaTEErOFJ3S2NacmR4OWQ3?=
 =?utf-8?B?WUtlVE9jclUwVjdrQ3E1WWc2R1MxTnVsODdTZUpjSlZaMGxOdmZ3emRhOXFp?=
 =?utf-8?B?U2ZOZHJRWG5MV2hvbCtIajlUUzRJcTNVTkpTLy9sRzQ5RDlzeVNjaTZ0Q01m?=
 =?utf-8?B?RWpGbjdnZmF3SGJzUXlwRTFyV3dQd2ptVEdtcTFzbjQ5NmRJcTRTaFZMMU16?=
 =?utf-8?B?b0ozb1RUZjNxb1c1THV3SHZuQVY0YmRVcXNjOStHT2JLcGdpV2Rqc2lJTGNS?=
 =?utf-8?B?Rk4xTC9BdFJBS2x0ck0raVlpU1E5L05OYWQ5WG1aU1R2eGhIVXV0VGwyaUdM?=
 =?utf-8?B?SmQyWU1tMkVuWFRNVyswS2hVandCcTZ5QjlzTml4MEZHelg1Wk5aVWlQb1dh?=
 =?utf-8?B?M3JFd3Q0OGdtSEVSZUZIczNSRU8rdmVLSnFNa29DRDVKM2wwcnRWVVBiSk1r?=
 =?utf-8?B?d2p3WUVTK0ZhRUUyUUVJeGNiNkJoU0tLL0hUMVlSTTFsWGZka0hhNUlOclJt?=
 =?utf-8?B?d3RBNW80c21GZHAwb1ArbTNsdDAzV3F6aVY1cWx5a053d0ZhZHFUK2k5ZlFn?=
 =?utf-8?B?dnR3alFhUEIzMndRTW1CckNOMStENHFDazhzZGtNTFpCalBITlMyNzRnWnM0?=
 =?utf-8?B?Qm9tODBlRlQ1SWp1MTlUTUN1TDlsTCtiNEFmUTJISzBuVEV2ZFoyc0l0VzBF?=
 =?utf-8?B?VkcybUpqNG1neDdrZlhYQ1R0WXVuRTVOdlJTeXlHYmJZUjlKRWQyek1pZ3RB?=
 =?utf-8?B?YW15WVVxUk1uQ2NDQmhKaVc5cEZFUnNMMnV1RmJ2OVVFeU5NNW1uN05ZTkNa?=
 =?utf-8?B?Zm5udFpOdGxGZzVsYmlZaE9KdkpicUZ1RjJYU21iNlZVakRHWkM2bjY3NDNE?=
 =?utf-8?B?Vmp0RUtyMEFjeFBOZ1MvUFQzRHlhSWthNXpFaVlEWkJUYWVlTEZWWjhxbWpD?=
 =?utf-8?B?V0NOb0orVGVMUDJPNG1RVUlwcmNwenpjWUUvRWM4V0g3c1pqTUhpV1pWYkUy?=
 =?utf-8?B?MmIyZmFSc2tuK2padGoyRkV3UW51U2psTDljNjYxcXQ4VXRxaTdoYnpJZnps?=
 =?utf-8?B?dEJtVWlCbHRicTB2ZHZnV0xEallCQm5sWUNNYnQ5aU5OSkg4TzJLYmdZYmpV?=
 =?utf-8?B?VXd0NW1jM1JpcytoNW0xb3RqSFlBRGl1OHZiWWdldjZ4Q1ArOFZSQlJoQUpP?=
 =?utf-8?Q?djRtPLRY0PfeNnyPtrAHF9FQQlMl6/R6KAMMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djU1NzNlSEZlZHVQVmpPRnpPTjFmWWRiYkJMZVVmcHBNV3YrdGJQU1NSbURv?=
 =?utf-8?B?c1ZoN2gxUHNFT0VmWnNjMmJZcmtUa0FReXpTd1hhNGd4eEFmQTNDTTlIQ0d4?=
 =?utf-8?B?Uml2bXhzakZRa2ZkUnE2SWg0d1JCT0p1ZlRjcEUzNENVWEdKaWtmdVhmQ2J2?=
 =?utf-8?B?KzBkejZkdU1iS2VnZDIxTlM1S0RvUmVvNEJjMTBjZTlQSWhMa01xVVg3czl6?=
 =?utf-8?B?Y2Z5U0RUNDgwQU9Rcll0NmZBMTJncjJGMmxnVWF6RmRXd2xqUGdiK1daak5S?=
 =?utf-8?B?ZzVhZjl0K0J6T3hKTDRkZnlKM1M5bVlBZFdXZFpLWWh2NXFIRk96ZHVZdFZJ?=
 =?utf-8?B?YUEySlJqTk9mN2ljemlsdDBzZ1lDVm9mVzF1Ry9FSnV1eHJuM0ZnbFY1Y2xV?=
 =?utf-8?B?cmxHeU1SdHpvVTlzTlJDUUV5ajFEY29VWlR4SXN1STVlb2ZlTDQ5aG14dWx0?=
 =?utf-8?B?eGkvcmZPOXMzQktEMzhzMFFDUmYzQ2FBNEJrN0lwYmhWdjVPWjQxVTBDbGhB?=
 =?utf-8?B?REdMQzRuM2pSYlAyL0JaV0c0VDBIRW9ZMkx1czB0am95eDR5eHY1QS81eFJy?=
 =?utf-8?B?cnVKcVpCa3MvOVZPendWRmcvdE1VbGVqd21CcXBTbE1uQXI2UlZua3EwdmFL?=
 =?utf-8?B?NzdaVXFPWEVsVzZEYUZ4cFduUFBVaG1LRnoxRGRYVFM0RmdXa3piYUhmeFRx?=
 =?utf-8?B?THlZNkp5RkVVQUxCZXBaSzgwQyszTlN1TVdzb0VPQzIwSldWeDhnS2ZuTkxL?=
 =?utf-8?B?QTAzMyszSDc0a21iV0lzTVBXS0RPUmJSZ21IL2dzRThhcmZLUzVYaDRUVkhN?=
 =?utf-8?B?OTd2WmFiOXlKdkJJUUlwczRDTlBkcjAyZE5PcWk0QWlDZTNETk52bnNiN2NX?=
 =?utf-8?B?eWp0ZEQ2OXlnVTF3V1d5RmM0emY1UUZnU3UxQlAwRHM2R014cXNoeTlvSGFQ?=
 =?utf-8?B?SUVjTWlkN1NORG80UWdpZDN1V21UdzVCUEUxTG1VUjVobE9FS2RuYkl1WlF6?=
 =?utf-8?B?bVpzaUJTSXUrWTFLQ1htVjR4M3JrSFpodk5XVnlwR3dnc01vMWdBOG1OSC9F?=
 =?utf-8?B?Tm1VazdXd3N3TTN3a1F0dy8zOXhiUUMzWUxVRGFRZmx6RFNhLzgwbEtpa29U?=
 =?utf-8?B?bHp6N0VJTnhHNHB1bFlNM2kvMDlYdkNjeU12SlNRNVpVaVNQRGFWNXNJRlJt?=
 =?utf-8?B?c0JSM3FVcjgzdVllVFFpcU9uUDI0Y3UwL3hVdEVJYVZZcm1VanhuZllhaTAx?=
 =?utf-8?B?SUh1WWt0K2NSMElaVi9YakhSak5FeTlVbkl1SUo1TGErN0ZRanpsU2YwMHIv?=
 =?utf-8?B?cEFBRVY5WHdhQ1YrZ1p0OWM4Zk9NdHZnQ3IzaVBiNEVQdFZDNlVDY0hiemxp?=
 =?utf-8?B?NC9WYnI1WUlFSUZKZVNFZm5IaStGbFo0OUhjWnVWNXFuNFZGeURiNDJDQmlt?=
 =?utf-8?B?MnVxTkJqZjNpeUp0b3lndjFRTDJROW5uWHh5bW1BWCtVVEgybWpWa05mOXQ4?=
 =?utf-8?B?T01DN1JIZFRFUVRVS3VXY1F6a0RwNjVoNWV4VzFFQkdGakF1T0pNQlZSSkJv?=
 =?utf-8?B?SHBqOUhKd1V6dTR2VDVKVlJocUhBNjVSY0RlTkhRQ1piWVVlYmZadDBHRnhk?=
 =?utf-8?B?cVU2Szl0dzlSWHdYNEw0SkZBdnRQYjNFQnZka2JZUHNOemNKNEZQUTJDQ2tT?=
 =?utf-8?B?YXBlT3FsWFZFMEtBejBwQXdtb044WHIxQnRiUUkwZUFzK3VRRUx3djE4eWxw?=
 =?utf-8?B?a2JuUzRKeVlEdjBGM2prb1pLeXMyZUdUWWJNWERYU3BvQlFpYmU1cHU0bmlI?=
 =?utf-8?B?d3RCaDdOdStxYVVaLzBIVmxXTGtrVzliRDcvZERxaVovVzBXd0JsOGlrM053?=
 =?utf-8?B?UjEzQ1UrS2RiQ1JTL25oTURlUFZGVGQyY2Fva2xaVDRjQWZkcmt5NFd2cHdS?=
 =?utf-8?B?UFBwSUF0MS9yVGhBZko4akRNUXZlWVo3S3pHaXp0bi9TZEhPTUtRYWxFVit0?=
 =?utf-8?B?ZkIxbGkzWTlzZDloL3kxSC84RnRvOExMWmlCS2szV2ZEU3VZOVVsa01GTGxv?=
 =?utf-8?B?ZjYxcHVNMzE0U2JBMkZJTWZtL2MrNzNEd2N3RGVyL1ZRbzNMUmQ1elZrbUpr?=
 =?utf-8?B?SDJBdjNXK2Z3TmJCdVBKa2ZLTW9NYUNrWkYzdEFqR2hjWG5zcVlWQjZCMG5S?=
 =?utf-8?B?Z01BeHFlRytaYWNick9zWThMUEpFbTkzeE05Y3BlNUZVTHhVTDIxbVdaVnQ1?=
 =?utf-8?B?TkV2QlUxYk5IamQwNTBWMjdEVVJ3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b7790a4c-b013-4366-a52e-08dd83080426
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:14:21.0796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPYDuP1sI0d4sFiGUJBeD5oOeNRNSTU6qc/FREKwwA7WtWULGdVd8ylgf29vIjgmQ8vtN2WZDqQiE8C8WpeTLwH4/CRbs2MXGGphUSu3J50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8124
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

On 4/23/25 2:27 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 22 Apr 2025 at 02:53, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 4/18/25 7:19 PM, Simon Glass wrote:
>>> On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may contain
>>>> a path instead of a filename due to user mistake.
>>>>
>>>> Because we currently assume it is a filename instead of a path, binman
>>>> will find the full path to the key based on that path, and return the
>>>> dirname of the full path but keeps the path in key-name-hint instead of
>>>> stripping the directories from it.
>>>>
>>>> This means mkimage will fail with the following error message if we have
>>>> key-name-hint set to keys/dev:
>>>>
>>>> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file or directory
>>>>
>>>> Let's make it a bit more obvious what the error is by erroring out in
>>>> binman if a path is provided in key-name-hint (it is named key-name-hint
>>>> and not key-path-hint after all).
>>>>
>>>> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
>>>>    tools/binman/ftest.py                                    |  7 +++++++
>>>>    .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 ++++++++++++++++
>>>>    3 files changed, 25 insertions(+)
>>>>
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> The change log seems to be missing?
>>
>> The change log?
>>
>> Between v1 and v2? It's in the cover letter of the series, this is how
>> b4 handles it, not per-patch change log.
> 
> Oh dear, that's harder to work with. I believe someone is working on
> b4 so perhaps that feature could be added?
> 

https://lore.kernel.org/tools/CAOiHx=m8tPANa+5A2dohEdkz48aPgH1g7ZXvF4uLmEu+SCo6DA@mail.gmail.com/t/#u

seems to indicate it's possible to do this manually within the editor 
when doing a git commit, by adding stuff after a --- line. I checked, 
seems to be working fine indeed?

The cover letter will still have a new changes entry, so I guess this 
will somehow duplicate the work, with having to list the changelog in 
two different places and making sure they keep in sync somehow?

Note that you can also do a

b4 diff --compare-versions 1 2

which will do a range-diff of both versions and you'll see differences 
for yourself. Note that the same limitations as for the typical 
range-diff apply, namely that if the changes are too big, it won't 
attempt at comparing the commit diffs, during rebases the git context 
may pollute a bit the output.

This seems like it's bothering you, but you're the first to complain 
since I've started to use b4 a while ago. I don't mind doing it, but it 
would be nice to know for which subsystems/projects I need to do this 
(and hopefully remember doing it :) ). Should we have some documentation 
for that maybe? And not specific to a specific tool used for contributing?

Cheers,
Quentin
