Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10404CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 23:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAE48319C;
	Wed, 10 Sep 2025 01:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KuIhl1RZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530E4831BE; Wed, 10 Sep 2025 01:29:17 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320A7830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdWD+L2Zo5I+8uT64jLjsKAa4CXf1nuR0NWKAn/mNBNXkAVlyTSE922KtlcNRdMqKW4fSTAhFSUe1cfABhTjl4C+LOUmFJEZXEtHmBSsJVzTtaNIhRrAS5NoVMh2fOig5K7v+NIiJAmxgGopSnzM9/BiMo/NiRUCVhmhKOtFC0rjJE0mhXTPzPcTPIwG5v1k2gIBMPilAxj2Cwqg5CnciCCsOtcYg8F9YOsYXYGLee4NAUsrUrRvS9uET7XJUMVgPROtRIaWef/AlnRYtHNn73JaEJ335hSRMVMrgAF36g8nEB2vpgKor0wekyK7aJ322LyBJWUx4GofHW55AsZ7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/N6/YaZbQD+fdI0MfK/GgtrYxcaQ5uaB8CJEncdcvM=;
 b=uHHrhpkL61fTu2cAU+kslp1NDbMr+zdFVe832XpUYYpdZJT8E1vStSxy5KLEnCB/2BUM2IlqQSyijvqUAnT8XKgd+rujAUaSoVaJE4l8n0NS/bgqNENiaE44hLuM3NYOTISdMm0PLWOQLF/d/kJyp+RldSECvf9LK87yyE+dryWbMfKso57J0QixXNwbvIdqiapj1gswy8mhNagiUVxNxct/KsGfzQaww/d9/8lheO8O2gyKf4AU2AaUeZdL01QK/yogSjqIwKKT3+6L/uFr5wmw2yS1MF3BbLq9XJ5U2OpKaE7mDuPuCXn1wQXuEFag9nqXq4h7Xl7fUVwAykG5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/N6/YaZbQD+fdI0MfK/GgtrYxcaQ5uaB8CJEncdcvM=;
 b=KuIhl1RZlewkbVvJZ6ODyZ8nGKSxdLMffQiOyOpsq0uyEVJKEvELPlSb1Jc4Lw3JkbCH531NIX7nnZcL/BidgJ0zkrUJ4U2LptJFxMyCRam5GcrWnFRnB0LGNP+p1QV+Y5AJYovvZnNbsowsYgPp4u4tzOUdHah8CelQ4tgUyrseVHoSqkjgMMeCXLtmpi7mG/VM0KdR/u9oFT4sOhAp8dhBxqXOS5kz6o5H0+DeMkOz13tBrDq4YxR8PIMU85p3xczZnW8l5m/h6bWaXjVW6FocDHDsFpE6rFKmt5eTaTGAX32WsOm6NPPzM+Y1KRgRf0UEqvzVk5Ita1+CFZBCPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7398.eurprd08.prod.outlook.com (2603:10a6:10:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 23:29:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 23:29:13 +0000
Message-ID: <ae009630-e001-41b0-bdb4-70be2fdd0101@iopsys.eu>
Date: Wed, 10 Sep 2025 02:29:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] airoha: rework RAM size handling to support multiple
 RAM size
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250909225751.19544-1-ansuelsmth@gmail.com>
 <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
 <68c0b731.df0a0220.1d4f64.2389@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68c0b731.df0a0220.1d4f64.2389@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b57e054-3baa-402c-c88e-08ddeff8af2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UllQaVNPVjUyOEpFbk9vb0pVYitPNjYxaGhhQUw3U2NwUmljSmhNMHBMSlQr?=
 =?utf-8?B?TEErK1dQb3hsdEtZVjdpdjQ1aEdnS3g2RzV2Z2pnWW1GcjhlZlQzeGt0bzJl?=
 =?utf-8?B?ejhNZ2JvNUFTK0ZpR1loQm1oOWFCbFhseEZnMnkwVXgrTG12SndGVHhqOW94?=
 =?utf-8?B?WHNOaHU4bWo2YUVSc2ZsZ0UwY2xQMGQ2VWRnOENzUDNmcEtMeHhOcjFnQmxV?=
 =?utf-8?B?UkhMaWN6V09LRjVQT3BQaVRRbm9JT00wejIrbHRuNHF1QUR3TEVkVzZCYjlq?=
 =?utf-8?B?NkMwei9SNUNZMmM5aDlVdWoya04zaGRKaUwreDZ5UU5ndEFxbFE4RUNha1o3?=
 =?utf-8?B?Z1dESjZvQVMyclZEd1U5MWlrc2Ivd2ZGOHloZi83MzZxV05lK2lJOHdFclAy?=
 =?utf-8?B?UlhEUUw3b0VjRWNJM3h3U0hXTjRzNjFEOGI3TUkvZzQza0w2djBIaDQzclFS?=
 =?utf-8?B?NmgzdXBZYi8zUG5hZk1wQVAvc0daSkNJeGdwZ0U4L3FNejVqcnNHc0pKK3dQ?=
 =?utf-8?B?eThGaWl1TVpNeFBROURaWGc5Y2hJWDFiOXhtRDhRczRkcUJCQnBpenlLSUtM?=
 =?utf-8?B?U2FHYXJKUmJkT3B4NHZONlVsSXF6QVIxbkRhTnNxUDVURW00Qkk5VVZJSHJX?=
 =?utf-8?B?MzlZVWJodUk2MWxyUk5zYUZwUWdId1Q3b3ZoUnJjSUgvVWtCamR6N05JNjBW?=
 =?utf-8?B?dmwwRFg1aHB6dU5KanBDemMzd0JUK3JVaitHSWRtbERnSVk1d1RHMWVsQURv?=
 =?utf-8?B?VUI0SFRKcUZCYS9saCtRbldKQzBEdC8rZGN6NzV5Q0g4Z1ZtVkk5ZkhYbkFh?=
 =?utf-8?B?M3p1QzRjU0NIYmZXRzdnaEFucVR5OGtxUzBaZkNXblVXNEdEaTBseTJwK0Fy?=
 =?utf-8?B?b01XQy91d2pORTdlMGplRU9zNFRoSzkzVzhlb1hrTE15OGlXZWFSZ01QVi95?=
 =?utf-8?B?bUQ1NXBlS0lXdXhKU1lPZ0w1QlVoYk9BdXZvbkM2UVNKVlJpaUhGUVdTWWRI?=
 =?utf-8?B?eklXNGxZeTkvQ0ljcEg1SXE4YXZEaVV3ZERYUEhJQkdGRVZZVURIUUN6dks0?=
 =?utf-8?B?TlBGYjNjaDV2a0IxTjRkVzlzTzdRTzg3ZU9MZk9NSnJ1QWJjSUVhQjdoMWxw?=
 =?utf-8?B?NnVWcThhZTE5Ukhoa3h5MW93T0pWRWl1OElTNG1QbUZZTVhaeHErODgvUWNo?=
 =?utf-8?B?VWp2Q2Y4akZEdDBpMFhRdi92VldIR2pmSGdVNlo4OVU4S3kvYVFvYVZFdW9K?=
 =?utf-8?B?NGVPN3IvdFdHajRaUHdkbjFFOVV4Nkg2Y3drdms2QkYzd0VXeU5ZSGFoblBO?=
 =?utf-8?B?b3J0REZWODF0STFqM2JNNGp4SVNReS83dlk0dEVYQ2tUdGRWQVEvN2VrN1RT?=
 =?utf-8?B?ZEV2NTZyRGFlZW8vUC9pRWlJRklJb1AxTUlQOHVmSEd1U01YS2lJNyszeFhr?=
 =?utf-8?B?VEFaeWkxcE5CRENQeldTazdJQ1NpYWVvN0JsWDFpaFFEV1BNL2Irb2wzQWR4?=
 =?utf-8?B?clJEeVZqZ2FiOVZJWlBvVnBqTVRqNm1aUnNFejZaSlBvRUJSMnVQVlZDeHk2?=
 =?utf-8?B?MFd3Z1I3aHZ5aE14bnRkbTEwekhGSjlrZjJMRlI4T20rRHhsdFhiMTVmRTUy?=
 =?utf-8?B?NmNqSkI1c3lDREhGdWVoU2dGQnBseWk4cit1cW9vbk9KcXpwQ3lJNk1MMDNC?=
 =?utf-8?B?aktYRDN6NFZtMGwwN0o0amNmc3Yxa2t1Zk1ScFhvcXYwellsV1hEWDBmaXFU?=
 =?utf-8?B?ZUZDT0VuSXAvNml6NjFnM2cxR1JwMHFqR0w3SnZSZzVrRU85Nlp0TkJlbDQ0?=
 =?utf-8?B?cHE0WWcreFkrYjdBUVVhdWRId09MakhzK2NoNER5Q2FjcWhoNW9GL096Wll5?=
 =?utf-8?B?K2NaRzY1R25XWlowekRyNHRFTUx5UkJJbVdQS1oweXFKNDFCdGs2cVhoNUVV?=
 =?utf-8?Q?IsgWb7neo0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um02OStUU1kxSVFBcGdmak5OaUU4cTNDL0xiem04MzNTMFR2V3hhTzV0UlJh?=
 =?utf-8?B?aktMZ2Q4TEtWVk5NZFVUMk5wZ1dMMW9aL1ErenJTZnFSSE5hOFZJaFE3MXZ4?=
 =?utf-8?B?RW0zdnBIVitOV05DNHhXb2xlZ25lb1B1TkJhNGpiR3d3SFp6ekhFa0F4NDdW?=
 =?utf-8?B?dEhYWmRtUHhVWGhmWFd3R1gxSzU2RkhlQlovcEdqTm1ybXpyWXlXMFhUVEdG?=
 =?utf-8?B?UkZQTkpCaUdrREJ5c3M2ckFOUlVDcmdOaFlOZHRuMWYveCtLRG5lcCtVQURF?=
 =?utf-8?B?MmhlQ0VpcEwvU3I0NjkxdU9zdWlaNVVZTnNNcHdBeG40OG9Nbk55RGdpank4?=
 =?utf-8?B?WC93ckVKelUzMFk0WHFUUlBuZnpiVWZDMmJLS3hSZFdDcHkvdFBqd3ZhS2pK?=
 =?utf-8?B?elJlR3Nya2d0TGZEbDZvYWxoMkV0aDcvYzhtNk90U2wzcWhyaGxFTEhSRkxJ?=
 =?utf-8?B?M3FoOU1EblZDRFFhWi9ISWZnUTliTjFwV0dRTzlFY0RIZXAzOUxUd253Zjlu?=
 =?utf-8?B?QnJZZFNBcWZFeWtPR01rR2tXSVk5RXJmYlRnY1FzSkxQZnROQ1VkbmpEZ1hD?=
 =?utf-8?B?VFdRZzU3enBTc0hJS2VGUHNyU2tESUdqbGlrMXRJVnRiQWFpeWd3OGd0ckp3?=
 =?utf-8?B?aG5pd3hnckRYM05wSGxEVzVRbG9MNS9DbmlVMFJENXpuWWt4cXVITDVkaU9D?=
 =?utf-8?B?a2J3R3o5SUY0UE1rU3NEb3dTMm0yd1hVeFdPTXJNc2JXSWxueFZDa2RReHU0?=
 =?utf-8?B?bWM0MHhjc0J0VmVtMk9zUFRWd0ljZW5ycEdlYzNBbFFBbjhIa2c4U292a1ZN?=
 =?utf-8?B?VVNlNFhrMkpGc0VRRXYxcEJvb0dIeXJUODhUc3djWEdyTDc1QUNIbW12cVhK?=
 =?utf-8?B?YXVtN1Mzc25GMW50ODMvMFBKOFJKYkI0K0Y1NUpWV3Z3U2hqb0ZpRDNsSCsr?=
 =?utf-8?B?NmNFdzZYcVpOajFOTThCQWxQWlNDT2VNaHlEN2ppZVlxWnVmOVZDUk4yaUdN?=
 =?utf-8?B?MVRsNWxRTjdPUHc2NUE4cThSdThyRUdaODFlSzdZdW11OWhONHlxcWVadzNF?=
 =?utf-8?B?ZmpvYkd6TWE0NFdKZXdWWUE1eVNoeUFPQWhiVWtadkcrZ013d2pLOFIvOVQv?=
 =?utf-8?B?eElHREZRRGNHUy9oMVlzMFd2NEpoRkhOYXlHa0tjenowQXFWRHFZdXNRR252?=
 =?utf-8?B?VzJjdUZFNzRGTURZT2sxb2t0L0tkTFp6L3JPR3ExZUExTW41K0tiSXd1VHdD?=
 =?utf-8?B?NFJVcXlaeDlJOG8zYzEzcE4yOWtha2E2WW5mQjFjb0NrWU9xUTZudEFpRDNs?=
 =?utf-8?B?RWRzdUhybDFzZ0xXdVBDcXVrc0gycG5KUy9BK2NDMUJzR01JNENJWFhpNzNi?=
 =?utf-8?B?NHBRckRmWkdIekpFWDZqZjdEQ0xtcWs4cU5HVHROaHZ2N1F5ODlxaEMxTlBa?=
 =?utf-8?B?WXNyWmNBeXd3NzFYZUwrK09OZWY4eU5hdUV5Q1Q4dmcyazRpQUhsc05paWlw?=
 =?utf-8?B?OXBDdkJ5L0doZXdMY2VmT2RQOFJvTUJVS21xMzNnN1kveDZGcTg3anZBRHo1?=
 =?utf-8?B?Q0NqdExIM3VUdXFZWElOZ1d6UmtYM3E3aU45TnJoWTZKRlNwQ1MycUVjQkk2?=
 =?utf-8?B?N05RQ053YjZ6OWJySWhZd2xtK2k4VWh3eHRGVVYyVG5pd3lqSnptZ1JNWnBD?=
 =?utf-8?B?NXpIMWxOZjYyUzJscnZ4TEpHb2g2TFJsSGVFRjIrdWYzcysyakZlMzNQU1p3?=
 =?utf-8?B?clhKTG9zaFBmcEdWQko4VGk1cnZ4b0d5aWV4V1JydHEvNVhDQVA5MEFVTk53?=
 =?utf-8?B?SmpCKy8ydi9sRlRuUDU4Zk9YZDB6OE5vcWJ0ajdDWnFrakdzalBkMEtrSC80?=
 =?utf-8?B?aHZyZjYySmFaUE8rV0JlNXBkMFM5eVZwck9lcUJqaDZ5YmN3dE1yRGhaczRj?=
 =?utf-8?B?MlE4eno4WllUeEl6c05CaDQzZGpNd3RVM1ZCNTlrV00vbndsL3dGdE9sS2tx?=
 =?utf-8?B?YytnYWJsQ0UvN1pyYXphTitwNTlPb3hOaFNrK1ZFNnNzbWhtUXczWCs0cE1Z?=
 =?utf-8?B?STAzak9ORFJFZzRrM3BtR3hEZVRybHIrVFk1Z0o5UmZEbXEvcHpXazd6dGpO?=
 =?utf-8?B?bnAvMllnSGFubDFMNFlrWGVmOXR5T3FXb25MQ0lLNGRVSUs0eDJZM0RHZFZQ?=
 =?utf-8?Q?EzAOIeEH8QZU+DmX+fxRYY8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b57e054-3baa-402c-c88e-08ddeff8af2c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 23:29:12.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n5bvyKUuEHsX5ZwUAAEB6e2mAdkLFRp/xFECpOccW7U0XVhsOG4lYQCrsKhZcMPQttwoPAGk6XXa3PGmaWcX9d3jYHD+qIPCnIiYJtjt/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7398
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


On 10.09.2025 02:24, Christian Marangi wrote:
> On Wed, Sep 10, 2025 at 02:16:03AM +0300, Mikhail Kshevetskiy wrote:
>> On 10.09.2025 01:57, Christian Marangi wrote:
>>> There are multiple version of the same reference board with different
>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>> better support it use the get_ram_size way to scan for the actual RAM
>>> size of Airoha SoC and increase the size of the memory map.
>>>
>>> Also rework the memory map to account for 2 memyro map. The first one of
>> Misprint, please replace 'memyro' with 'memory'.
>>
> will fix.
>
>>> 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
>>> rest of the RAM since up to 8GB are supported.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>> Changes v2:
>>> - Add memory map to support full 8GB
>>> - Assign 2gb to first memory map for U-Boot
>>>
>>>  arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
>>>  1 file changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>> index d149e0ee3c8..11992027d92 100644
>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>> @@ -2,10 +2,16 @@
>>>  
>>>  #include <fdtdec.h>
>>>  #include <init.h>
>>> +#include <linux/sizes.h>
>>>  #include <sysreset.h>
>>>  #include <asm/armv8/mmu.h>
>>> +#include <asm/global_data.h>
>>>  #include <asm/system.h>
>>>  
>>> +#define CFG_MAX_MEM_MAPPED  SZ_2G
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>>  int print_cpuinfo(void)
>>>  {
>>>  	printf("CPU:   Airoha AN7581\n");
>>> @@ -14,12 +20,28 @@ int print_cpuinfo(void)
>>>  
>>>  int dram_init(void)
>>>  {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	int ret;
>>> +
>>> +	ret = fdtdec_setup_mem_size_base();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>> I think this will not work correctly for 2 memory regions with a gap in
>> between, see  an7581_mem_map. So I think we should use get_ram_size()
>> twice (for each of regions).
>>
> There is no gap between the 2 region. I have the memory map for the SoC,
> it's from 0x80000000 to 0x280000000
>
> With specified
> 0x080000000 0x100000000 32 bit
> 0x100000000 0x280000000 64 bit

Sorry, I am not calculate it properly.

>
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  int dram_init_banksize(void)
>>>  {
>>> -	return fdtdec_setup_memory_banksize();
>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>> +	gd->bd->bi_dram[0].size = get_effective_memsize();
>>> +
>>> +	if (gd->ram_size > SZ_2G) {
>>> +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
>> gd->bd->bi_dram[1].start does not match to the virtual address of second
>> region, see  an7581_mem_map. I think this is a mistake.
> Assuming ram_base ios 0x80000000 + SZ_2G we should be at 0x100000000.
>
> Am I wrong?
I was wrong, sorry.
>>> +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
>>> +	}
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  void reset_cpu(void)
>>> @@ -29,20 +51,26 @@ void reset_cpu(void)
>>>  
>>>  static struct mm_region an7581_mem_map[] = {
>>>  	{
>>> -		/* DDR */
>>> +		/* DDR, 32-bit area */
>>>  		.virt = 0x80000000UL,
>>>  		.phys = 0x80000000UL,
>>> -		.size = 0x80000000UL,
>>> +		.size = SZ_2G,
>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>> +	}, {
>>> +		/* DDR, 64-bit area */
>>> +		.virt = 0x100000000UL,
>>> +		.phys = 0x100000000UL,
>>> +		.size = SZ_4G + SZ_2G,
>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>  	}, {
>>>  		.virt = 0x00000000UL,
>>>  		.phys = 0x00000000UL,
>>> -		.size = 0x20000000UL,
>>> +		.size = 0x40000000UL,
>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>  			 PTE_BLOCK_NON_SHARE |
>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>  	}, {
>>> -		0,
>>> +		/* List terminator */
>>>  	}
>>>  };
>>>  struct mm_region *mem_map = an7581_mem_map;
