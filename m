Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD93C4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 03:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 426EC607AF;
	Tue, 21 Jul 2026 03:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SaqtXhE5Iqv; Tue, 21 Jul 2026 03:08:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4419A607A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784603339;
	bh=W41X22Lsu7vw7ImMZ5rlGeClzEsYLvtCLW+DfTUZycY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Nmil4gTX28f7gHthoGFG9srElBJuSqFReOF1QyJwJ4N4udMbwrha712wd9g5K2fpv
	 amcShszuP/iNysH8D68XWUFnA9VtbxIWe3XBfpUzJkBMNz0l2RVHKw9CvffqBao3gu
	 2l67KsyCPQOf0Os23rtdGfTx9GIeufNqHK7x9t3O7H/o5NVTCnjwlFMMOZMV+Lo9tx
	 vfRCB0WHXLwNHxoGPTkOectzZ4rZbvra2DNFGyfnwA/hHUVnVkCEjCJ7txM0jAntNP
	 01RDlLqXS6DxowmIAfperbjPIHbSvYDBgLiafErgAjZ3Xx54dYzzCdxAlz9V3Ryqqk
	 BHFEzJucRIGAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4419A607A9;
	Tue, 21 Jul 2026 03:08:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9E14224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7EDD607A9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKe5eOezotTu for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 03:08:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 72630605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72630605CA
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72630605CA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:08:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77EF4846A5; Tue, 21 Jul 2026 05:08:54 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694E882991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:08:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WScDURlx9rv2NBo8/CBBO8F/84gzMAzjm/pTuTW0XXAwCSywljUggzZZDCT4d6YgH8QJUXbskPOdtDrxvyyZVPwRAgQM8D9+8G4VRCEtK69pwH6hR4z4qNDwP0DHr0GUqZqdUDUzSN32MMfAOzMHUwoqEzdqxw+bwYdgysgFhF84UHfDxu7kwmdDuuLso0y1TpfsteQNDcDTivCQXAf7XYDP9zIl9y9tDTfZV42b6zKJ58GcF/moJp1drJrRaXzb1vCIYx5jnn132laeIXCAF6PAkiVsrsnUd4V4BPhE4cC+0bvpH/GxL8fdfG19JPRWePUGSsn8wscMQBCMvVAufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W41X22Lsu7vw7ImMZ5rlGeClzEsYLvtCLW+DfTUZycY=;
 b=u8eTn4fyb2I87dQJNcxiI/Ub/LQobXd67Da9RWrVlerDQ/vefodkEW/01eOABtskUY7Gzk69FmQI/DAqSc/Hu4ddCVJmSrcDW6H4h/PLVO7lFAIkX3Xgk+M9r7rzzu2VZlc+hmlAE0QiWVNGeUzD5be5LAnWuPuO70BhrEkOyPdNGRaWUbIJMMvkGPdb+EAm5O9OZePPwEatcnWBdWZpNoc8nn9ZdnV3w6QJqfWiMmtgDen7YN6i01yAatmAi46Fav8x08BaL01htTTV5AcqAMtQn8UhuCdV9C7XUgSo1ECdODS+GJUrNUhOxynLHiJgXWunnOxHnkabvy0qCKfBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH4PR03MB7724.namprd03.prod.outlook.com (2603:10b6:610:244::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 03:08:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 03:08:47 +0000
Message-ID: <65b11287-23bc-4afc-a11b-3d60d5b36635@altera.com>
Date: Tue, 21 Jul 2026 11:08:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
 <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
 <d66ac683-af83-473f-9e75-f6f3a317280b@altera.com>
 <PH7PR03MB69420121B7C50CBB0F30A4CFF7062@PH7PR03MB6942.namprd03.prod.outlook.com>
 <20260529225329.GF627328@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260529225329.GF627328@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH4PR03MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9d89fc-c3a3-48a7-2bfb-08dee6d56178
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: 6Z+TKZJQJXSXmOpip/uNW6pjpNKQsGr9xdUZAtF/4vi5wS8UXIsiwVpRFRkgP2L60QrTtOnFpGUzgk1UmgLeYRIMWUj3tlTGQV+1fXwy2uUnxM5p33xIFXPCiGPZWoEofoku/CEqkQhW/9+ZH6D0zurqLbXT0e3VkAL0yi/yrNbwKK/1+5d7NZGq6qUlu+s3AvOvA9PujGS+0Zt/q85vRXQJ0uUzWNarF/QCRPReFmNzjocER12utuaqZ+AVEdv2NG+wYkzo/DahV4DAZUhS+L2ObvQt7TxCsu7o18gf8FzVT5Eojh5CYzXgESmEk47tVKAsh8/374nQVMWWXCWNkq8IW4tWW8chlWjgJPq1W7hZGpLp5vN4OgBXN+Xd4GyYQjlur9EwdTFKusGIYxepvUOsIGsqCL4jkWX+oTjvp2qPA6V4fWDAF6QwygbPHZd0EmD4Djlt1D5cj6xg1B09wP37pcCB1dxjdxj/TFUdFX6Twyaz9OXxi3Blx/QjtPa4/5dz+28Nwc4SqKw7b/EXmASXHNu/RuzwQshC/6GqID+LAxpmlh8Zqn6Q69l+cR+Fmy5v6T78jnIC75ReXlb7O43kD46e5KrTalWGCPjUXdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENSM0twblZobCtBSENnTzNsTFk5VGtGMUhxOWpJb3ZWSXZnWWFPcGkzNEFH?=
 =?utf-8?B?K3Q1R3dyY1VvSjIrczA4TmVlNEJXVnNKVWJkNWQvMzRoQWxoR1k3cUdvWXFE?=
 =?utf-8?B?NHlydy9DSHVRTS9TM1FCMmR5QTRaTHk4ZkxCUXlFNnVPWE8ybHZRV29tSmlM?=
 =?utf-8?B?bEt6RUJteitVNVFOenc1YzVvc0F6NVpycDhuYytVZUQ0ZTV3OExETWtRQ0M5?=
 =?utf-8?B?QlVRL3A0SzJyZm1HYmFaR1JYUmdXUmxORDVKU3lua1lWb01WU3NIUnRJVVBD?=
 =?utf-8?B?Zzg1T1F6NkJTR2pCNjQ0dERIczVsMjBSUlA5cnNoQzVWN1RmL05maUtyOFZ6?=
 =?utf-8?B?cFNqY2lMc3M3ZisvT2xPWGdtaTkyNlpBa2xVZHo0Q3lHQ093Q0w1Z1RFQURp?=
 =?utf-8?B?UWtyRnpIOTdQbllXdXFPMkZBR0sxa3NBZnJEaHpLTFNpaFhldmM1WUJDWTJy?=
 =?utf-8?B?Z05vWi9WemtKNmpZZER5ZzdtVTI5MXdQY2dycHlBTVNJa21vZ2lhQi91VlBI?=
 =?utf-8?B?R2ozSFpsK25tWWlueUJvbjNOaTV5S211Y0h2Tkl2UXBJTVRwUzluZ0J5Tksy?=
 =?utf-8?B?ZHdHeWxHM3h0aWMwODJSLy9wb0w2VUtnWlZ0TzBPS0QyYU1vQytnVW95cFNU?=
 =?utf-8?B?SXNsazBwMUY3eEVuTmRnUzVPaVhRQzdtZlNLeExiZU9uYVBPN2NOTXNvUmhm?=
 =?utf-8?B?RE5qWlVsVjFHTGcrK0dtRVkwM3VzZTZzdTRDQ1E2R24yQkpNWGs3L1JlZDRP?=
 =?utf-8?B?N3RqUDdNRGN3akZMSHA2K2RVaGJPaWt3THRmdjE3eHM2a3ovUnI2WEFlY3ZZ?=
 =?utf-8?B?dWJ5bytGcHR4ZVpGMTlOTnVLanN4TWR6Vzl6SFYzUjVyTGVYRzc1VFovQ0Vr?=
 =?utf-8?B?WWVHaDVHYWZIK3prallDdnNYQ0lucHc5TjdGOUdKcUdtODZ3c2pRTllZQ2dI?=
 =?utf-8?B?dU1NWHBvY29zeDdlWUpmdTNSWml0NENldWcrb2lnRG9rR3RaNW1HdWxyTlM0?=
 =?utf-8?B?czdNYlk0WGVKTFJ4cUxXamZDLzNuemVKenZCVnMxQ252dDVVdUpLRjU2WUJZ?=
 =?utf-8?B?VjdsY3lVeDc0Ni83Tm5sdUNHdUtLYkd5S2ZsNnFpenZNck5EYmo2NjVZVXVF?=
 =?utf-8?B?K0ZlSFovdHFNbFJpQjVIaUFLKzhkVGlOb1pTNW5qUWhCWWpZNmM1MUdOS3BD?=
 =?utf-8?B?eXc1WHpPMkFOTGIzZWE3NEtjNFd0ck9YWDNJai82Lzl3T2tXYkhteHFwQnpC?=
 =?utf-8?B?TW9hRkY3NXp6UDhRM21od2N2YXBJQ1llVDNqZ3pRVWVqdHZyUDJSSXdablZK?=
 =?utf-8?B?SjZuazJxUVh6MjNjNzBKeDdrb2E3VThnWHZrZGNzMXlQcFZzU0xxS2NTbExz?=
 =?utf-8?B?akUyNDR5bFlNUitjZE5CVnd6YzdnWWczdkNsRXQ0MU13TEhoZGs5V0pqMkox?=
 =?utf-8?B?NWJtbDhYOSt4S1Z1UnZXSGhJTmZEUDd2TXJ1RTRsdG9HMFYzZzNsZ2JDYWc4?=
 =?utf-8?B?dmRZaFJzaFpMMEYvMEw3UGUyc1pMc3Y1ZGVFcEp1bUY4OGxhNFpWYk9idk91?=
 =?utf-8?B?ZlhsNDVOUW9yVGh1bWxuMTIvSjNyZVo4TXJVWWE4cndLSk81SW5IVnFFYmQw?=
 =?utf-8?B?SzI1NFF6RGU0bEZTRk0waUhGaGpwUWJJZ2FkcWh4cTIwbis1U2lST2lxU2lk?=
 =?utf-8?B?V0ZJOWhOS29zeW5IY3RzZGpjWWpsVnhreEJBVmx5VTM1QWNLd3hPZENxYmRU?=
 =?utf-8?B?S1I2c3RDTDNZQWJHeG9CaWp3akg3bkZ1bnpVS0FJTkMyeFlOYVdVWjlwZ0NC?=
 =?utf-8?B?c29nUllSS2lXcGJMNFlVRFhOVnZROC85bmZucjRGTktPY25JMnRtVExrUmxm?=
 =?utf-8?B?eWF6Tlo0NUZqK0FoSWlvZUF1UENJdjNtbE4rZWJCb2dlMzdKMDc0VkhYU09P?=
 =?utf-8?B?eWNST1BXdW52RW9FN2NyWXU2SEF1ZUxNdmhReTN5cXh3blpndGtaSzZjYmc1?=
 =?utf-8?B?b29HeldnL3pBd3ZIQnNraTg3UTl0dGxuR0FJNy9zZlJNM3R4L1lUTlpMRUVt?=
 =?utf-8?B?YmVIaGVYdUpQUXl3em9UMzRhOU5FWkc5TXZ0Y3l6SmZqN1FnK2ZxY2hTQkdx?=
 =?utf-8?B?RkVvMHpOUHQ2QXdOeEV3Ryt1cEsxMVdKYTRyM2l0aUFkeXYvd0NVajhXZU5M?=
 =?utf-8?B?M0VPVXd4ZGJLME16cStNT1praXNTY2FCdDVpYkdPV2p6dk1hWEh2cHFzMExY?=
 =?utf-8?B?cE1XaExTU25ZVzFhNTQzUUowWlNpa3k4azRydmVUVXgwa3ZjWGpaVFlqbWgv?=
 =?utf-8?B?NE5oRzEzMmRjMng4dU1EWE9taFBpVDJQQkxJcjZYN3Z3VkVRSm5LQ3BUSkZ2?=
 =?utf-8?Q?LRVYz/bv9qAxBvJc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9d89fc-c3a3-48a7-2bfb-08dee6d56178
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 03:08:47.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed6Syx3Qk9Ms6+T7GmygjLo8S5Mt0zvPU0opRSWHx6XRrrWq7gcPy38B1sbFUOP0MVK1p7fHYDOEz3xxJL7PoNQdL8xVuliN/m0FYCD63Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7724
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W41X22Lsu7vw7ImMZ5rlGeClzEsYLvtCLW+DfTUZycY=;
 b=DQteTh/StG7L1diSk6KQaTdrd08/CUI8BM0Csem86m4LA5XNdgR+HP3sLZbl0x0Q8NAOnV81QNlY4AL94fhBamx9GIEOra0yHjfEC6+CpaQHIYhmyVW6fWqdSskhV+KfTxtQ4LILxElv81q4h8gCpztv7gdHMo+rdk7bJoVsNTJm5yctTqFbfHi8CZQHdxl6OHqvhbVqCnOxGoin39Sc31jTy8FX1ZmTZ2+FG2A5zya8Gx2HqIuFZgAW2qVBw+kFJukKbMigpiAMwTOJGuaRoFi1S2qFONLo1N7XY6/XXzlUkDdflD/kjHhqiu2z5Boxifpwl4/oaidbYrxN9F0lcA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=DQteTh/S
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="DQteTh/S"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom, Michael, Dario,

On 30/5/2026 6:53 am, Tom Rini wrote:
> On Wed, May 13, 2026 at 02:13:34AM +0000, MANIYAM, DINESH wrote:
>> Hi Tom Rini, Michael,
>>
>> Any update? Can we merge this custodian branch to the master?
>> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-07042026?ref_type=heads
> 
> 
> Michael, Dario, do you have time to pick this and other patches up for
> at least the next branch soon? Thanks!
> 
>>
>> Regards
>> Dinesh

May i know the status of the patches, it was hanging for so long.
Hopefully get picked up and merged soon.

Regards
Dinesh

>>
>>
>> ________________________________
>> From: MANIYAM, DINESH
>> Sent: Tuesday, 28 April 2026 11:44 am
>> To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
>> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Miquel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.khai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
>> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
>>
>> Hi Michael,
>>
>> On 7/4/2026 3:15 pm, Michael Nazzareno Trimarchi wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> Hi DINESH
>>>
>>> Your series is here, I will have time this week.
>>>
>>> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-07042026
>>>
>>> I need to take care of other patches too. I have some Easter stops to
>>> address, and I also have other patches from Bootlin to finish
>>> reviewing and others to queue this week
>>>
>>> Michael
>>>
>>> On Tue, Apr 7, 2026 at 8:41 AM MANIYAM, DINESH
>>> <dinesh.maniyam@altera.com> wrote:
>>>> Hi Michael,
>>>>
>>>>> Hi
>>>>>
>>>>> Yes I have two series on my queue, I I will work on them this week.
>>>>>
>>>>> Michael
>>>>>
>>>>> Michael Nazzareno Trimarchi
>>>>> Co-Founder & Chief Executive Officer
>>>>> M. +39 347 913 2170
>>>>> michael@amarulasolutions.com
>>>>> __________________________________
>>>>>
>>>>> Amarula Solutions BV
>>>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>>>> T. +31 (0)85 111 9172
>>>>> info@amarulasolutions.com
>>>>> www.amarulasolutions.com<http://www.amarulasolutions.com>
>>>> Any update on these 2 series?
>>>>
>>>> Regards,
>>>> Dinesh
>>>> ________________________________
>>>> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
>>>> Sent: Thursday, 26 March 2026 1:57 pm
>>>> To: MANIYAM, DINESH <dinesh.maniyam@altera.com>
>>>> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Miquel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.khai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
>>>> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
>>>>
>>>>
>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>
>>>> Hi
>>>>
>>>> Yes I have two series on my queue, I I will work on them this week.
>>>>
>>>> Michael
>>>>
>>>> Michael Nazzareno Trimarchi
>>>> Co-Founder & Chief Executive Officer
>>>> M. +39 347 913 2170
>>>> michael@amarulasolutions.com
>>>> __________________________________
>>>>
>>>> Amarula Solutions BV
>>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>>> T. +31 (0)85 111 9172
>>>> info@amarulasolutions.com
>>>> www.amarulasolutions.com<http://www.amarulasolutions.com>
>>>>
>>>> Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com> ha scritto:
>>>>
>>>> Hi Michael,
>>>>
>>>>
>>>> ________________________________
>>>> From: Tom Rini
>>>> Sent: Wednesday, March 4, 2026 10:39 PM
>>>> To: MANIYAM, DINESH
>>>> Cc: u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario Binacchi; Michael Trimarchi; Richard Genoud; James Hilliard; Miquel Raynal; Chee, Tien Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
>>>> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
>>>>
>>>> On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote:
>>>>
>>>>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>>>
>>>>> Fix and align Kconfig dependencies for Cadence NAND in SPL.
>>>>> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
>>>>> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
>>>>> keeps SPL Cadence NAND support self-contained.
>>>>>
>>>>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>>>
>>>> --
>>>> Tom
>>>>
>>>> This patch has been reviewed by Tom Rini.
>>>> When you have a chance, could you please take a look?
>>>> If there are no further concerns, I’d appreciate your consideration for merging.
>>>> Thanks for your time.
>>>>
>>>
>>> --
>>> Michael Nazzareno Trimarchi
>>> Co-Founder & Chief Executive Officer
>>> M. +39 347 913 2170
>>> michael@amarulasolutions.com
>>> __________________________________
>>>
>>> Amarula Solutions BV
>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>> T. +31 (0)85 111 9172
>>> info@amarulasolutions.com
>>> www.amarulasolutions.com<http://www.amarulasolutions.com>
>>>
>>> Any update on these patches, do you able to merge it?
>>>
>>> Regards
>>> Dinesh
> 

