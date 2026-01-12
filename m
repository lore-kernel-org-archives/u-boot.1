Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E8C9EC8D
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4CC838A5;
	Mon, 12 Jan 2026 14:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LZEkr0Ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202498391B; Mon, 12 Jan 2026 14:36:52 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEEB98388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq8Ngta9JIKOV/FHR62HTJ3D0yQ/6FHRMynVTuWpJKZ7TDEr6iuGM2bUQxrvCvRCf1BUu6fJQVRopxAcgCrwPZEgAuAfnRLX6PFSK3dlH91+7OQg9RYu1Jk/IZbClaKrbbW06dQ2Q/l6vZK8dUGYkNV8chOmZkkpCSIhNcKACKnxdoL8zenmu+ffhA8Ad+cf21iM2p1o4/3e7TndI6sTtzKTpG+NL/Tjau2kOwz1cByVxN8Hg8kvLJzHkcaKkCI/1OKmrow79C/uOcy5wPRRlNw3fWgZeN1NvFbmf11gCL6Uk7JwZJuPW55TUA/6nRK//NVRQMIzr3KUgGfarnSbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDF/7DdZ21KaBJZT8ke1+Ge/A4Yg/xakDc4C9Rld690=;
 b=U4XngOiICpQ6b9SdsiYMmfn4/jXXx+c1J8E08TIVlEJkhqiYtS9A8hq9eruIIYzcTh4l8dAxPvuJCiw35m4yUUfaW5EDhj8rcOHb/TWDUyA4cx8ROXWfrcVQ43NldgI1Ah2+AJEjVuXI6+okEmfWaXfZTtjmfSpFYG6RAFpnn2e78mG4oflrwAamR1KklfolLaGC4RuXVVP5s3b/BInlQsf7X6WGFEABjsLihN13YRdoo5p7Hk1f3jaSpGg5sejSs9ePxFiaovcdSuLmsFLMAWoIHyByZgtIhwRgy4W4GO34FzlT919aFINPsTupWtSXkZgNgMJ6xNO1O5K5zVA26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDF/7DdZ21KaBJZT8ke1+Ge/A4Yg/xakDc4C9Rld690=;
 b=LZEkr0ArzofSw+MWozPXHFjQw61S4p2uIweggwgTi5RdFyVe4Pi2xLhtm9a0oKH5Lv82km9djo0XMNyKN6zm2gzmZlNotFl9Lnllk2Hpf4mIGKVv//QmUPG6f121TQjel1+MhU504ebcXLvkJdZac36RgVECnKSuQ0c9dyFMCkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB10730.eurprd04.prod.outlook.com (2603:10a6:150:219::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:36:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:36:46 +0000
Message-ID: <a6fcc698-26de-408a-acb0-7e263c6b8710@cherry.de>
Date: Mon, 12 Jan 2026 14:35:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cmd: mtd: add logs when bad blocks are encountered
To: Peter Suti <peter.suti@streamunlimited.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <cover.1768208815.git.peter.suti@streamunlimited.com>
 <57e9a612b9ff9e61975ae29a249c488f11ccae73.1768208815.git.peter.suti@streamunlimited.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <57e9a612b9ff9e61975ae29a249c488f11ccae73.1768208815.git.peter.suti@streamunlimited.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB10730:EE_
X-MS-Office365-Filtering-Correlation-Id: 393d527b-0444-4b3d-1e1f-08de51dfa17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmU3ejNCUWpiSHBrOEN1Ums2S1k3dmxWRjFtR1VWYVpJcGFjeEhKRVdhL281?=
 =?utf-8?B?ME9oTlJXS3RWV2lOTFord2pJQ1lvcDJkMlc2SDYySlpuVXM5aGQ0L1VORVdL?=
 =?utf-8?B?WHMvNGZmUk43NVd6UnZxbnN4MDRKMFVzTXRWUVlYSnlrOHlpSmFmOExpQXRh?=
 =?utf-8?B?Z242OU5ackxBdUVlTkMyRm1tZDcxQmxaTjJDRlBycTZKSnFHcE9BeXVCcnVr?=
 =?utf-8?B?SzEvSHRBTTQ1VHN2VUhSWEU2QVlvR0RGeEpaTlJ5dk9HdWUwTjU1KzNtZXRo?=
 =?utf-8?B?dXczM0FiSjlRcGhEdVlKTm1JY3p4QlduZ2N3TWhPdlVXc1AwdWNCd3FBYmZy?=
 =?utf-8?B?aWJqSGdFMlNqWkI0Z3VFVUFEZG1jYjNiWHIzMjlQa3VuaW93bFk0K2NpMkI3?=
 =?utf-8?B?b0wvY2xjSGc4KzdpVmQ4YjRNcUVTKzhySDZvS0dRSnRsaUNaTm9Yc2xOT0hU?=
 =?utf-8?B?VG1rRU5vandmSis3RENML3JvUnNCTUJ2TjJKNDUvTDJ1WlNwRFpXNC9JQllq?=
 =?utf-8?B?VkV5YWhzclhidFRBRmpMaEx1OE5mT0NNK3hCZ0RMWVRBSjZsNTRsejZ2VERF?=
 =?utf-8?B?SjYrNmV0STVweXFmUGtoQXNnMW1xck9EcU84a2FWVUxmeHp6VW1zejZudHpz?=
 =?utf-8?B?LzFIcWc0cjgwVjQzZXF1b2daVS9IT0k5a2VLRnlzTzVGZmM2elZYcWRhaE9v?=
 =?utf-8?B?Qk5kZWhMR1dFQmttZ0NIemROaDN4S1BkaERFQVFtSXZsaU5UaHZLcVA5dVg2?=
 =?utf-8?B?aGdHVDNBYXJSUGE3c2VqV0Q4YVhEb1JXSWZkV29ucmVnd0xabjdIRE1lbXh0?=
 =?utf-8?B?TmhpRFhDNmlBbVZkK2FDTlFDM210TmZSRWV5OW84ZTVid0JlY1lsTy9EUjJt?=
 =?utf-8?B?cmJsZ0sxUEJpVG00andORjVwN3VsMHI2OVcrNEoyQ0gySUxFc211YU1wc2Zs?=
 =?utf-8?B?RjBqR212ZnZMYitGQjVjUTFyNzhCYllXUFBPTS9iQ3dyZnA4NHZvVjY1MERI?=
 =?utf-8?B?cnBBVzFIS3ZsaEpFOGZUbTVvVU0yM0xVNDYxM080ZFRJa0JmempZdVRUUWhH?=
 =?utf-8?B?bVFmQWRDYTdjR3dXM0FoeXIwbndJZjNFa1JNSzNtbTJwUkNCRmYvUkg2STZQ?=
 =?utf-8?B?eFZWRWhtMisvaHZ5eTFQMFBVTjBNQlMrVkxXL1prQ05BZUlJVHVWRjZ1TE4w?=
 =?utf-8?B?WjNsTnF0WDlTUkdSZmdnWkJyOGh1ZnR2L0V1MlpKdGhPRXRsZTV3NG8rSFJm?=
 =?utf-8?B?dVd2ZE9TU3dBSVBmK3NEZzJkNURjbVA3V09WQmtSTzJ1NVc0WGVqdWVZeGpT?=
 =?utf-8?B?cE1jSDNXZ2c1dU4xRVVVM2p4ZFB5RUc0UHFuTU8yUDNGSHAvbGlicGhKWHNr?=
 =?utf-8?B?ZnFLS3cxNnl1dk01UG9SZm8wMEdLb0EvMGZ0dnFYV2piZzZtanp5RVFQKzlr?=
 =?utf-8?B?MDNNRHlLMGFCekJkcmd4M2VRR3dVejAzaFRWbDUzYUVRQlllT3B5T0UxaWF5?=
 =?utf-8?B?b1BNaXlDOEhlWWp6TWtiQlRNMFJYU2hESGl2Q3JvOHowN1gzc2V5algxeHBn?=
 =?utf-8?B?TEF4TE1qNFpib0lPSXhwVmxYNjRWQ0VJUWdkVlNlT3JwZWxJeFpBQnVpYUJm?=
 =?utf-8?B?eG9aQ3JvMjlXN3Qrb2ZjaUx0WFcydG1JWXNwU3Rsbm96OEhvRVljK0MvVWRT?=
 =?utf-8?B?OGtzZ3ZCWVZacXFNdU1DOWdDVTNHb2hrZXNCeXl2alJjcm9XRCtSWTdrazFi?=
 =?utf-8?B?ZExidVcyQVhwVnpob01DcFZFVEVTalhnL1k3QUsrVkh0RG02QkRPZmNUUVJZ?=
 =?utf-8?B?M0xlbzJPZGZMK2VmblQ1VnRycW0wZW1lNXZVMUp4Q3hjL21nR0ZFTG5hRFdm?=
 =?utf-8?B?K0FPNjlUVVZuL3RKVTMzVUdUT1BFajlqN3JkblFRaHdOclRTRWN0NVhPNktF?=
 =?utf-8?Q?BxAhc8sBGc/59FrccDVY2dcLGoJS2cpA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhzTDRKOEVDM2F4Vlg5RHAreXV2ZW5YS3IvbFFad2ZldW5PMnV2bnZpMjlC?=
 =?utf-8?B?YnhTdGJhTXF5dmU2Y3YyMXNwMTk3M1VXd0VSdjNYb0o5VFJPOUE0Z05DMXh0?=
 =?utf-8?B?SUtCM0x6dVBpYjZQQ0RreGJ6RlQxY3lTWGZJSG9scEtBZHp2ZlhMRDBpMFVX?=
 =?utf-8?B?VDlQbGNadlN6ZU1FUmdmVThlR3RtWFJtcmZmS0xPTWdWZ291eURGWm5oSzVX?=
 =?utf-8?B?dkordEw1ekhSNHJaN04vU1l2NGc1QUtqNDh6aXdIdSs1VGNtY0p1ckpxVDFL?=
 =?utf-8?B?MmZKNDZrRzAxTGwySDY2U09VL0tYZ1BrRThXMUEvN1ozR1dKcHIweTBIUnZH?=
 =?utf-8?B?VzZEd3YzV2NEbW1Ja3krc3ZveERUc0pIa0hXZGFxVHo4c3VyZ1o3SUtHZVRv?=
 =?utf-8?B?bEJLMU56VmZsSnZsdUU0Y3pFTlV5V05DdG5nRmxQbmN5aUZGZWMvd1l0V0Rm?=
 =?utf-8?B?QlpEcXVEempDS0dEY3FDQTBxRlZHcFMrd2t6WGh5ZDJlNXpxSXBTWkJWOWc2?=
 =?utf-8?B?K1Y0UlRlTHdvMks0K2s1S0NHbUlWYTFGNnBTYmZaRWROMmdWV2ZFY1dDeE9W?=
 =?utf-8?B?dnlZaDVOcC91TkpyQTJLclRGWndiRWpDVWtVcUpFYzZGaEtXcys5VTZ1ZGFt?=
 =?utf-8?B?cXNNNnVuZlhpdlRzL05veEJ0NUs1aDlrWEtyNTRvNFNWRUduNDlJcUpOenBZ?=
 =?utf-8?B?Q21wQ3QwR3dvd1hxWFd6ZFRwREVzQ05CdFFHY2hVRlJMWmlwNS9GV2Q0NlZh?=
 =?utf-8?B?REdsV1U3S1M1cGFyZXovVFlOZEtZUTlMbnVEd2JFZkZLSmxvcGVjL0ZTbG1C?=
 =?utf-8?B?bzRiMGE3dnVudTVpenRlUE1nSTRJdFVTanNMNWd4UkwvaUxZeHhNenlURFF5?=
 =?utf-8?B?STQ1cDZEOGR4RHBiek8yVGkyWnNlZVp0dFdOcDhSd2QxK29FVSswSUtvaEcx?=
 =?utf-8?B?WmNaK0VPR0VNMnBaTjE0L25LNEhMTFY1Vm5DY2ZkR3lvL1JBdUlyVjRFQSs1?=
 =?utf-8?B?d2VPeEdSRFhDYVJqSGd0S0xpU2E1eTMvZVFSSXlhNnkwNU9CRTVBYXNoTk1i?=
 =?utf-8?B?UFQzNWlIVWNhbGs3QTZYMGpqa1g0TTFvb2o0SkVLekhKUDRoOGxyekwvZU5v?=
 =?utf-8?B?Zk1GbEhzUlA2MWw3d0t6SnRnUVdzTWRnQXNySEdyYnZuRlJOTDBrNlBGd2dh?=
 =?utf-8?B?UlIreGc4RXh5VWFTS1BocXdWbkd5Wno3ZkwycklTRm9HK3dxb1crOHdESk1O?=
 =?utf-8?B?U0pEWGhWb0FlT3NqUlNzNzhsVlFJekRGYXk3Mm85M2Z6T3QxemxxZ1M2TXFI?=
 =?utf-8?B?em9YU0swQWNWWEpVMjBvT0NuaWsxRnBoVll3UlF1M1lxTkR0bmRhZXJVTld4?=
 =?utf-8?B?RG1wWDhQSnJHL05Talpua2hRNXlWRnpkVCtYbEdKNE9vdlRVQ3Q2V2ZOVU1B?=
 =?utf-8?B?cWl1WGtXbFdtQVJ1d0wrZFJQQXIvaUZLUk1HQ09sM0hGQ3BSVXdla1VKeGxr?=
 =?utf-8?B?TDh4WGU2YzBlUTJFRDY0QUZSbFgzeGNLRXRKdGRiZVFhUndaYms1czl2NnB0?=
 =?utf-8?B?Q2xYcHVRT3JUYjVQR0t3ZWFsOUdESUs2NmREd0tBa1g1djBjcDVXMUJQaFpD?=
 =?utf-8?B?Z0J2YW8vNE1WdUVOSFJNSU1HKzhLYUJCWmJQdFoxeGxLLzdjdDNNanJUMjd4?=
 =?utf-8?B?cTU1d20ycE5kZThhYmJDbkVpeC9keVkyVkpmWWNhSDkvanRraGdjVUFVSS9E?=
 =?utf-8?B?SUxONzU3K1cvYlpUMXo2dTcySUl6cU03bDBkTVRwVytlNG5yUHl2NEZRWXZF?=
 =?utf-8?B?bFZkN05xUHp3endKUHV1L0RpK081Qy9WWkZ5eDErYS9ES3ZtQUVrSEZFY0hB?=
 =?utf-8?B?cjBCZDJJSW1PODZJdGNVTmZTcVkvcC84L1VHNDlTOEdvUUMrM0l1UEZTNE1m?=
 =?utf-8?B?dXFOdkJJSlpMUExZbCtwVnBtdVBTYVRRdGZmSUxWblJCTUhYY2Z4bjZ6V0JT?=
 =?utf-8?B?emtmV2FETXhTcEtjUjkvaXU1cWZWcmx1eEdWMWhNcVNaUCtjTFIwRjRtTlhx?=
 =?utf-8?B?VUdFMWhkZGJYQ0crUkNyRi80SjVYbkFSOUo4Y1RFd2h6aDVxWTRKaCtyRENI?=
 =?utf-8?B?VzFxZENVakNZOUtyZTVWdEplSEtjNnFYcldFdzZhcEVHQUpndmZ5S0gyanRM?=
 =?utf-8?B?VFhYNkl1aHVFb2YyZnJHR2lkekRnYWlIb0x1VDBTdi84NzJ4aEloOFRGUUM2?=
 =?utf-8?B?ZG52aVd5S1RBTjRjcUVQa2RoZ3hMMEFiWC9NRFI0S3R2TndxQmE2R0dIVU1J?=
 =?utf-8?B?cUtEOGxiemtFenBRcHNyT2l1S0xZTVNlaGJiRFQ2VEdlM2FnSUx2dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 393d527b-0444-4b3d-1e1f-08de51dfa17c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:36:46.3363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAneKAPHVfHz95cVL0uCgu3DM3fxpUKZTBwZJxg2bU3C8oMXA7Kpnb6fnbQwI5DCunHQOrOV6/UBGDrx8VcWBUrosp9xIKwFB5DpedVQgYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10730
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

Hi Peter,

On 1/12/26 10:09 AM, Peter Suti wrote:
> [You don't often get email from peter.suti@streamunlimited.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

We generally do not like having commits with empty commit logs. What 
made you want to write this patch? Why should we take this in?

> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> ---
>   cmd/mtd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 7f25144098b..32733e8f11f 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -559,8 +559,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
> 
>          /* Search for the first good block after the given offset */
>          off = start_off;
> -       while (mtd_block_isbad(mtd, off))
> +       while (mtd_block_isbad(mtd, off)) {
> +               printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);

I'm not verse in flashes... do we know if a block is a bad block by 
reading it?

Because the code you're looking at can be reached by mtd read, mtd write 
or mtd dump, so maybe we shouldn't say "read" in the error message?

Finally, is this something we should be printing in the command? What 
about the other users (env/mtd.c, dfu, the onenand command). Should we 
rather print (using the logger even maybe?) in the MTD core? Also, 
should we print even if this is not critical? I assume skipping bad 
blocks isn't always an issue?

Cheers,
Quentin
