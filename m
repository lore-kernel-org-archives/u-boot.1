Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AADEA3F0F
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 06:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D4D83CB9;
	Tue, 10 Feb 2026 07:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LcC9+Fsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DAB83CB9; Tue, 10 Feb 2026 07:57:36 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06FE8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBzwWfK6GZs/cKceSexj6uHHDfOfpCZs+wNmklOOpusZknTNP5Hu0n4Qgc77hfQI7bzDJCdq3S3DoVoAxKj/oh12wFx19dBFRrV4JtoOZRQ25SAK84aOVgyswUZMGu8GhEcnHSvIERh6maBPwh0fStX2WWMvgIFDGMIXokRaG7+I6CVnvSpE0Oy1P4R+8Xh/U2X9ehM3RFjvbJZwn7WMuxoB7ohx5VrK9ddmM6Sr+ObTfHEQnqNi+NzijDSEaiCb4PwtsD6Ldq7CDhME+LNqJKV+QyzrA8ipottykL+5k51RcM3+iXxCrEkkfEf82F4S/+nComQxxn+ibZa5ke328Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWpuizHea8sAhY+32A3uIHEFZUzPKvdIAClvNelaShs=;
 b=ffYjUJOP1koy6lI+9yUcNBVxNkoRop1p2aWCyHRoDj+a2Ct/D8hE7Dm2079c9x+UuxVkiD/DmqvN3McuklK6tlc0jpTVfhtFI03HFOIyI5QYy1i5wPS3jPC/Z++kPQ/oQo2RGV4Q8ycqct+jF7R5CFpmAXnEiU4YiIOwRklWNNh82PlmJIGhla+2afsCcTGJL6LuXa9VX9r7a/pDPE1HAoG3WFJghpa3KQh+o/g5oDSe6t/89gKKEZ1thy3auuBvh1GnNUJc8ji2ing3biqauniEi8FeL6oeUVG5k78x3k1J4T6zKO0MJdg9aKJ9DmAiHiBvDX0P7ObZLWAzahiDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWpuizHea8sAhY+32A3uIHEFZUzPKvdIAClvNelaShs=;
 b=LcC9+FsdpSEIn9Oh8kKAkTUMiNBI031/Y9lD+9Y8Sl39v+naBybOCyAhBzXE5qwtn+7fPiIxxcPfsJPUmq1ZE8ocSLPUFI/GNe3KFvjP1mBHmPY2pyj5zXsxpYeG+U8knAkwBrB7tu58tbVf4+7Zw2JxGsc50cx1iKFMDtW6GxGm4DYMyEECGZl/uc4JCXW5zJNqsimwQVppt082P+4HU085xY1R1+/rNt3o7wbo0uz2zlj2anMPcNwYqE9awUkKeZVE+DEYBxn7PnxfdV6xnDE3WTmNmlL/OZi7lKgpmvZiZLU/vLIcT7tVXVmh5PKS6GVL/1ECVHP1tJGSST/S3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7455.eurprd04.prod.outlook.com (2603:10a6:800:1a1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 06:57:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 06:57:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 10 Feb 2026 16:12:14 +0800
Subject: [PATCH 1/3] firmware: scmi: Validate device tree node before setup
 channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-scmi-fix-v1-1-0d75f57944de@nxp.com>
References: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
In-Reply-To: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 737aa97c-cc93-4f0f-b979-08de6871a94f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVh4VjREUEJTTEFBd0FoZ3lCZzdWa2V3d2srUWgxbFdVbXYrdXFvd1RkdW94?=
 =?utf-8?B?OHJzbHhXbjFaZTUveU1lZlBpRUo2V3FibEd4aks1elpGRGgvb291RGRQZStZ?=
 =?utf-8?B?ZERERDFSS2lGeUxBTk9rdW1sVnFvMTRXOU9yYVBTdGw3dlNtVGlYNE5yYTlv?=
 =?utf-8?B?V1loQjFnQWFPQlF4UlIvb2JqYThwdFRvRW8rR0c1cnhJeVZnUysrSDE4OUpw?=
 =?utf-8?B?R0NVdEZBcWU1bjFjMERRaEhrRDN2Z2N4UDYxMTZhTXV6Y0YwMmI0eW5wcmRw?=
 =?utf-8?B?MkViZXJLb3RLeiszTVFPb3JTZDBUSVJMSzNkZWlzUTBod3Bnb3UyMjUzSU5v?=
 =?utf-8?B?d0NIaEpMRmVwQXRZZ2F6cGxYS2MvbXY5SHZQa3lseFNjcmpyaVZVK3ozWDlt?=
 =?utf-8?B?VDZQaHJZb3hFeEwzSnVnY1dOb215a2Yya3ZEaFhoMVB5TnUrUTZtdXlmSGM0?=
 =?utf-8?B?YmpudGFKdWpuMDFVZXBQTmMyL1lxNDZxQ3N6NzEyWHFBR3JieTNvYUJxNThJ?=
 =?utf-8?B?QWFhYWkvalhYR0JjWjgva21Razl6cjlUNG41eG91SU1mbEFMcSszNFlDeGpa?=
 =?utf-8?B?RjFDWmxncE4xRTg5bnZqeEQra0JSU2cyU1Qya1ZESGpZWnJXRlhidC9EcDJD?=
 =?utf-8?B?UjJGUWJHOUhCbWNTek50eDNTS0tGdWk4ZkY5OXZhcFQvSGk2WkFhS0ZTNlZJ?=
 =?utf-8?B?cXUrZldHZ2lNWXQ4MlBJZlEvTmZFRVgxdUVNRTc2bEpwNCtuMXpnSTdDdGw0?=
 =?utf-8?B?NUkzVTVhVFBNaGJFaHY4NktRbkgrMTdXb0x1SWphMVRKbHZxaVYwY3hRVzZS?=
 =?utf-8?B?R1p5VE55aWNhK0V3OWZiWkhzbE5zRS9SUUVQS0VoM1o4UTNUWVFrbWRhRjFY?=
 =?utf-8?B?eDdiSTZReVREZzNDdDg4MmFnN1ZOOC94WW1td21rek5wNlVYamh4c1grVDMr?=
 =?utf-8?B?ejJFdW5NVFU1eUc3T2lHSHFCY2JhaE13SXNTWkt4UFhhdTNRTkhVRmVuOHYx?=
 =?utf-8?B?NTBHVUduMTZuZFRLVjA3R2UrckxCRkZpR1huZmdrUnJvbjFxUkN4MHg5SFQr?=
 =?utf-8?B?UHZQbUU4SzMrYUxaMmFTNW1UNUlQMUhBOWRCUnh5bFk0Z1FVck05RXJkUG0y?=
 =?utf-8?B?MTlzUThkZ3VFSXZCZmxMcWEwblRTaUZjVFNxQ01tMG0yd0xXSGUxYXp2SWRp?=
 =?utf-8?B?VW9FVUZsQ2xOYlgwWVVtZ2JWQkFRT2ZxWm9YTmZ1YlVKcnd5cW5oeFpqeTNa?=
 =?utf-8?B?Njg1Vm8wYkd0d0xpQk1QUEsySVpYbzJZelArQlpYdnpnTU9SbVVpRXdSczJR?=
 =?utf-8?B?U21lTjNsOEsxUVIzUlRjNnhXcllBdlRCWWthNzRsOU1XcE9HWmZwYWZobTM5?=
 =?utf-8?B?c3dGeTh6VDdRczZJZGgydWdrNFcrNGxoNXY0T29NVnZhQ2tLcmEwR250b3Ax?=
 =?utf-8?B?YWxWOVBHcFM3djh3bmhpOGV3bVJOcS9OWkJLdUpvbGhhSnJnUEFEZy9uWWVD?=
 =?utf-8?B?VzJxVjgxNmg2azZhWDVYQmFlQ0U0UU5mM1duL2RqcmRUbWhZaUxJWHVjb1Zs?=
 =?utf-8?B?dkg4blVKWmQxWjY3YWttanFBMS8vYWl3aC9PKy84eXE5NklqTGJTMkdia3ZE?=
 =?utf-8?B?cytxdzROVEZFMDcxTCtPQlQwOWVNTUpTSXVFUlFuRmFNNStQbTkzays5L0lS?=
 =?utf-8?B?bjBXNE5SSmFacDNGNERnQ2Y1Z0xpOWVRU2lTdnVEaVkrVWpjaWQ4NU1vd0FF?=
 =?utf-8?B?clQxRGdoYU5RUkdkdlFadEowNDU4S1lqNmowZTlDa3YydWJ3ZTEyUkRsdTVC?=
 =?utf-8?B?bndhakxrSlpYMjMxRW9pd3UyTTlSeUhybDdlRkxjak5lZVB5VzNRZnNqbGRx?=
 =?utf-8?B?Rzl2TkRqRUUxbXBFOXcxUWxkMUgySW5HeW00S2RneGRuSHRnb2pKZFE3N0Fq?=
 =?utf-8?B?T01mZDdldVd3QjJqek5MMXJBeHJDU0w4b3EvTG9Hb1ptbE1hQ3dwNGlON2w4?=
 =?utf-8?B?eTJNK2xnV2RxMWJGK1M1TkRsNHlyTk9FMmUxVVUxL0JzYjZwQlpMMk9BQlAr?=
 =?utf-8?B?WmdaUm1meVliTUxXeDdwU011blJEc0R5V1RQcVlVQnlGL25GK0ZpcmNoSTdG?=
 =?utf-8?B?UHJNK2NMZU9VVHZDTEJzYitHZjdNMzVnTE4rbWoyb1I0bElIamV6SjFCaHh4?=
 =?utf-8?Q?iQIY1k6RClDn7nB07BrWvAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlFdHRCQXBoanYxWEFkTGJWZFo2ZkhnNTFka0ozcTVyOGV4WExzcTRFRTQ2?=
 =?utf-8?B?SHR2VU93cStjK3NlNlRwOEpCRVNiVmNVaDUzUDNqMkxydEZLaWVaVjRuRU9y?=
 =?utf-8?B?UmdyYUcwRWRub1J3dDBDSkpRL25Ra3ozR3VmY0c0TDg1Y0VrTGVNeTZ3cU9j?=
 =?utf-8?B?aFVJZXdZN1M1dERMcW9ZRXBoYW5WQzAvM0VOQjhlY0ZaemcvTHh1Y3BtSFpH?=
 =?utf-8?B?V0lHdHkwZ0RDTmN0UXdHVWlwYjdIS013Vjg1ZmsvZUNORlpvemRxUHZjSXJl?=
 =?utf-8?B?SWlPeWFtS1g2N0RyaHM0WXMvdzVRcHF6QkNGYS9LRXZQNG8vSEFoOEZwWnIw?=
 =?utf-8?B?eERqU2k0c1V1aHRjK01pNUVpK1pxb1JRa1NuUk5WTUJRVmw4dWt6Q3hzOEJo?=
 =?utf-8?B?MlVleWdERnkxeGpqdkpOWlRGa3B5bzlNSGJSTnkwVFMrVXQvZ0w0Z3RES1Vk?=
 =?utf-8?B?MzU0WGYvRkRKdUdHWlMwaWhQeVFnWFcxbXpVSGxCcHF6SnJUYTdtUjFBdTZ0?=
 =?utf-8?B?WDUzL0NHVENQdzNaRTlLZDNTaVVCd0VnVGZsOVdBTEtpeGhZN0Z3N1pCK2t1?=
 =?utf-8?B?cGIrNEZTQ1BYSG9sZEtWOE43enNqQzlya1JPNlhibmN5b1pnd0NSWGY2RzBw?=
 =?utf-8?B?NXNlQ0Y5Vmo4dTh5N3dKMUFnSTlTRUhiTnFmY3l1dm8wNVd1REpWUXgyc04x?=
 =?utf-8?B?Z3ljYVBxMXQyRjlOYXdHZFdIUGQ3WXNmYkpXUk1QMitMK2c1SDFMTVZCYkN5?=
 =?utf-8?B?MVZqWUpjN0VrYXdVYUlrcitzL3QvSXZFSUlweVNlN2ZVdS9JY0Yxd05nVkN4?=
 =?utf-8?B?Y1A5SUU0YXY1ME1wRWpxNmV1bCtyMVl2cXRmR1JTWk00SFAwNlJ4eFh0YUtk?=
 =?utf-8?B?U0NlSW8wV21sUTZxZFNldlFQUklDNE5JYjRBMGZKTWtKMUNQdlZsNmRqWVpS?=
 =?utf-8?B?QU9IWklUd3JNMUlvTFJFSzRRN3lVakFPUWE0bElPL2RhN3g3MUwvOUJZSVFl?=
 =?utf-8?B?NTh4SHBZMVhUZ2pFNmo5eTRITVJCQnpvcnFDdUs2d29XeWNyaXJwbyt5TzFl?=
 =?utf-8?B?UUZncUpyRHhWUGVTN0JpZHdjYzJPUjZZUU1KZFoxOGYySThQeDhyN0ZMRHVs?=
 =?utf-8?B?T3ZVbkxsbk1acGlXYWNIKy9yQS9mcU84VmJCZzBMOWUrdzBqSlNieE5KYUVr?=
 =?utf-8?B?bU44M0cxeTdDTTBsTXZ2amI4NnMzUHkzNUlDRlJpYjk0UDVnTktGUUx5RS9G?=
 =?utf-8?B?bTdMQjdRVU1XQTVNaGpERDNyM2ZLcWJaWlZqNzdmWFR6ZlFacE9la2pmQjlN?=
 =?utf-8?B?Wld2a3Q4UXljdHBucTNtZVZ1SUJIdDNOOUU1am1zQnRQRDBMUXNEdEg0OGRN?=
 =?utf-8?B?SHh6YkIrUVlNWWw1Wm5hemIwMCt3aGxEU1hWK1owRFN1UWpRS3BGK2wzb1dX?=
 =?utf-8?B?Ni9JTWM2S0x5Q2NMWGNUaG93Y25XUlFER0p1enJsTCtvQkYxVE90ckd2S1hp?=
 =?utf-8?B?WkFYLzltSHhJdHhUL25EV1hFOGUzSjNFYXh3U2pxT0J5OU5TSXhEbHovSjNH?=
 =?utf-8?B?RTVOSGg3Wno3eTZUNWRZNFN0NlhmMlExRk4wcFBVdDYycHBLQld6ZCtLczBm?=
 =?utf-8?B?UEo2MTBpZGFIRW80SDZ6ZnU3VFl3SkNmcWlLbXJKWFZheTBnQmdva0IzMFE3?=
 =?utf-8?B?ZU5PSW96aWVRdmY1RC85NlQzU3p2Mzh0WGJEV3VGU0VVSEFRWXVFcHErbmZJ?=
 =?utf-8?B?STRlbE1YUU1Jandydk9nbTY2SVJhODJyWEwreTBrTC85UlMyS0YvM3NCSnBO?=
 =?utf-8?B?TVAxME9xOXlEZmNwNW5qTDlQS3Vicm1tV2FRUHY2cDYxUkVRNTI3M2tBeWhI?=
 =?utf-8?B?Tzl0SXI1b1duZklTMXRUWXNscjkyYlBkcVFMMG5ObWpORDdGR2M4NGNHZC9i?=
 =?utf-8?B?NlZCTXpxdThuZGJEMzVXa0U3bXdPQU1OVU02ZEdMLzR0SDFqUTJYSC80blY1?=
 =?utf-8?B?YWQxeE51NXFjVTdwQmVvVVZLYUxvRDV6SjlRU243M05XU0NPUm1GbFJWTkhM?=
 =?utf-8?B?ZHUraUF3NC9hRFZubVVMVnJqSEYxdkM2RzRNVnQ5THVVUk9IQzhXSWxvS25M?=
 =?utf-8?B?U3MzN3oyUTdhaWdIYjlOaDNMN1BWa2k5L2laN1ZZU3UwWHpOcllxbU05bHRQ?=
 =?utf-8?B?eFpLaFlPWFlxWkxoSlZzQzNLTFQrY2lDaFMzWVNQa3pDUXg1MStVNnNYdHlo?=
 =?utf-8?B?KzloaEIxc3JvSEtUcTlFeFlrKzZWZWZVU1d6U2VEaE0zS3VSWHBXZ1JrRWxq?=
 =?utf-8?B?QWVHNHYwRlpiUVYvNHZvcUx6SzNlc01Id2FQZHJvYzRDdE82QWpiZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737aa97c-cc93-4f0f-b979-08de6871a94f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:57:31.6028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwda9TM1fCvzK+Xhp6g7qvg0vXpFQLwSOhJffL4e6At1SrrFTrqkTC58MFo5IEqQJ8/VtCGF1szxUDnLhWP0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7455
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

From: Peng Fan <peng.fan@nxp.com>

SCMI base protocol device does not have a device tree, it should use and
need to use the agent base channel.

For scmi_base.[x], there is no real device tree node for it. ofnode_null() is
assigned as the device tree node for scmi base protocol device:
commit 7eb4eb541c14 ("firmware: scmi: install base protocol to SCMI agent")

However with recent update in commit 0535e46d55d7
("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c"),
SPL panic in fdt_check_node_offset_()->fdt_next_tag(), because offset is -1
and SPL_OF_LIBFDT_ASSUME_MASK is 0xFF.

So add a check in x_get_channel() to validate the protocol devices'
ofnode.

Reported-by: Ye Li <ye.li@nxp.com>
Closes: https://lore.kernel.org/u-boot/939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/mailbox_agent.c | 2 +-
 drivers/firmware/scmi/optee_agent.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 16a82f55ab7..cda94565de5 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -101,7 +101,7 @@ static int scmi_mbox_get_channel(struct udevice *dev,
 	struct scmi_mbox_channel *chan;
 	int ret;
 
-	if (!dev_read_prop(protocol, "shmem", NULL)) {
+	if (!dev_has_ofnode(protocol) || !dev_read_prop(protocol, "shmem", NULL)) {
 		/* Uses agent base channel */
 		*channel = container_of(base_chan, struct scmi_channel, ref);
 
diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
index 631625d715b..7170bd1e682 100644
--- a/drivers/firmware/scmi/optee_agent.c
+++ b/drivers/firmware/scmi/optee_agent.c
@@ -331,7 +331,8 @@ static int scmi_optee_get_channel(struct udevice *dev,
 	u32 channel_id;
 	int ret;
 
-	if (dev_read_u32(protocol, "linaro,optee-channel-id", &channel_id)) {
+	if (!dev_has_ofnode(protocol) ||
+	    dev_read_u32(protocol, "linaro,optee-channel-id", &channel_id)) {
 		/* Uses agent base channel */
 		*channel = container_of(base_chan, struct scmi_channel, ref);
 

-- 
2.51.0

