Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE1C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EE0832C8;
	Mon, 11 Aug 2025 16:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WXs5znuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBAF832DA; Mon, 11 Aug 2025 16:08:38 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44553832BF
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGITR076m5BW3vW/0aVTfoUhVg6UzrpZkv6pY2yVojg8Jql5C17OwLKa3C9Nk/ZjoWe6co9rN6STXUdZyehx6BVGn/9OUFT59Jjlyfn3QA/AGJ4YqEnjYDC9MllRsvCoQ25DuvSAl4OqZJLkJ6UfsJoYl/uzy5SN4WFm1aFI8ct/oQ39I1K3ia+Qkh2CL3l1U219ar+iW4wj+g3w3lE8cewH0sUZOehtibT97F0JG9SDRKT6tQkQ6lIZ5r4ON44DP0cqN9QETzUA5bOUWRurpjU/XpRHtOQwr7BZtWRN4FKts7V4dik131uH5t9nTmpGox+8irvxsqf8lc8l6zwuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suT6nHzv2E9jjPskt7fcoki2+m8TENjf+fOiPkEhzps=;
 b=i3ZHSZrBCbUtl7hQSkYAcNPMmBY2enm20Z1vmbDIkiYJkBSE6jW6txMd5d493VhEivHp3Le74cRbPbh8HuplfwL0b9seEMioT/Lxl6siSnrVrYtGi6soOEbWfMEOjoVnsGq2fF4NQHdIBJMTVoaupIdqJbSneMUrIwz3l7k/xzBzu8sWWK0dBjAiV8gfJC116MgkPUT89IGNqcy6zFgzgw/+xU4E8X5kYC/eklXd27jUDzK8n5C3H7sgPFH6gFOUhmhj1dap9c4+Njy7mTebd94cCdvt6SRbspnZhKEWsFUhy2kdQiLVP+4Od3H/N6QZctApK1EzbNmcTqCnzmvPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suT6nHzv2E9jjPskt7fcoki2+m8TENjf+fOiPkEhzps=;
 b=WXs5znuh0ViUFxoBKJDfGcpWCwvGfQM2t1ILWg99pJrLecmpqirhSbV+yTeheNY2dqluA2txxuyG8dsaaYA6d1OtjWRZKjtvPZ5vWPMkxf0TWPbbH/RDOW9iLdKxr2TIFnrXY+nFVZ6ojxl2rcUNiyIXJizJidBbwXDePB/Nll0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9666.eurprd04.prod.outlook.com (2603:10a6:102:241::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Mon, 11 Aug
 2025 14:08:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 14:08:33 +0000
Message-ID: <1b0c1d33-8d43-457d-b81d-702a9f7e7bee@cherry.de>
Date: Mon, 11 Aug 2025 16:08:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
To: david regan <dregan@broadcom.com>, dregan@mail.com,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250806181450.2324488-1-dregan@broadcom.com>
 <20250806181450.2324488-2-dregan@broadcom.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806181450.2324488-2-dregan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 2991c2f7-0181-4ad2-90c0-08ddd8e08ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWgwalhTVXZOUHJwWEhyZVZLSTNVR3RHOUJUeGN2UWxqdUR4NGF5MFEwYXVp?=
 =?utf-8?B?bVc5dy81SytvKzRVYmt1NGhGTWVoSXBuUFdBd1FjV0RYK2hJa1RrdnVQZFRy?=
 =?utf-8?B?amdtUUEzaE9VVE9CLys3NFBiZ0xrcEpiK3N2T2VBaTlKNjZOVmhJdjhUTmty?=
 =?utf-8?B?MWVsN0xYSGVmLzdqSDV2WHVkYk9TWlVYNFRJOTEwMGlxRDFOYjNiQUdmTXk5?=
 =?utf-8?B?dXlPSGl6akl4K3ZWTitsWmlQYnBrVjVnSHE2Z0xzWWZJVzE0SHp6V2p5TUlG?=
 =?utf-8?B?UjJKWFlyNmtOeHU2TW5rR25tRkZzY0ZuNERUL1gzM3ZsbVQvTWVjYWZZam9E?=
 =?utf-8?B?Um93ckV3eDMzVjRYcTdxR0IzYThBbUczU29HajVRbXBIcTNmd002RzNuR1I4?=
 =?utf-8?B?NlVrcEJ4MkVNeUxna0hwR1I5Q3pnbnR4YTViT3hmbzcxR1JRaEJKZWkvSDlv?=
 =?utf-8?B?bmgrZmZCTFlIMFY3NThVc2dpWjZjaldGRTdFZUhDMWZaK3lNRUpST0lwT2tz?=
 =?utf-8?B?Z2ZiRGhBcEJ4RDVWSUtjbHBINFB4RnhGbjdOOGI5dFkvbUcyS2orTkg0em9H?=
 =?utf-8?B?SkorTEVnUmRqaTd1K2ora2dDazQ2anZ6THhBcXJuUTVOcmVvV0tIc05nNVYy?=
 =?utf-8?B?Y0dxbVI5dEdHTjcxS1QvUlR4N0p1ckZKOG5yZXpmY2JhdGtxajQyYkptUTF0?=
 =?utf-8?B?QlVYMkk2WG1iZGJMNkxJcGNxN1ZvVkszd3ZleThyczB0K0pNczlmZmpWZS9T?=
 =?utf-8?B?L2Z1cWFtb2E1SXZhcEFVSVIvTUNtRHYyOWNCY1g5NGZHSnZhYXJlb29NZVFq?=
 =?utf-8?B?Y1lkNWYySHhuKzJLaHRwWCtnUHZickNrMFVrTnJJc3h5b2JGQW4yUHE1QVlm?=
 =?utf-8?B?VjJCTFhteEFoS0JxQVgrV2tjT3AzY201YnNFMlZ2aWF6YkJsYmlyM3greWFB?=
 =?utf-8?B?RkVDRk45RVBzcTl4aE5ic2g3ZlUvaDVlWHFYaEhwS255dG9DeDhtK3RFS0hj?=
 =?utf-8?B?aGRTQVNKbzVrYmQydGQxb3A3UXZ0K1Y0MU5XTkhMM09zLytCbEs1Z24rUGZS?=
 =?utf-8?B?bjNsaTN2V1FUSGp2dklNVlZXb2ZlTFlidFBrTG53bGVMOWNQQ05QSHk4RmlX?=
 =?utf-8?B?WXdYcmFNcHdmUGIxSHZ5cGVReWRyVk42enpWTjNiTnBBNGRVeVRmZ2UzY3Bm?=
 =?utf-8?B?dnhIVWdNM3M1SVNyTGc0TTVYaUtRN2xVdSsyWHlVZndqRHR4enBrMmE0ZjJJ?=
 =?utf-8?B?a3l1eUxVTjdTb0ExV0ptT2E3Ymw5YVdtWmI2aUVBeVR2WlQ0MjNOd0Z3S3NK?=
 =?utf-8?B?bHpBOUtqYlFaQUNqVTBuZ0pJeENJSVBlUHA1T2VYM2p4WXFZb2cwZDkvSTdU?=
 =?utf-8?B?RDYyN0s1ZlNSYitKeThzY0tva3NpWC8wdnFUUnhiMDBxM2FnQzRtM3RUSzVr?=
 =?utf-8?B?VlRKL3l2OU01NVM0SHJKZldIYVkwQlNUc0kwS3hrR01hRVk4cnFMRzhxTmVK?=
 =?utf-8?B?OHRudnBOVzlPN1dJM2N6SjAyWUV1UFNPenhNT0hIQ05jN0FLbVdyMWI3Y2dr?=
 =?utf-8?B?OEN0V0ZiRXVUN2FDWEZqbWgzNkZBMlVZNXh6NFR3TEhMb1dvb2h4UGw3WXc0?=
 =?utf-8?B?aWx0ZDlDeDIxU21wNERCVzVwaEU0aTBYK3dnV2wvN0YvNUVCQlRvSWxNeExI?=
 =?utf-8?B?Yy9ZZ1J6dzdMRDJoVUs5eHV4Q1puaHUwQzZ5RW9kSm0xQ2hhWEZQLzUzNVds?=
 =?utf-8?B?WGRNemppeHV2VGY5T1BNaUczMlUrRGxZUUZRRGF0SUp3WWhGNGJ6OFNnQ0sz?=
 =?utf-8?B?L0RkUlJjQ2tPV3Q4anNDUkMwdCtMazJSZGUxYWFZZ0w2eUpKVnFrOExaTjgv?=
 =?utf-8?B?YldWSWs5Q0U1MjBxWlFDcHVTUjZiY1laYSt3MFhpSkNXUTF2UUttcS9LNVJx?=
 =?utf-8?B?RUN1eTkvQXhRNWdLVEkxMWh1cDJmSTN3cjdHdm5kYnZxZmphYmh4M0RyenlM?=
 =?utf-8?B?ODMxVWk4NGFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStnK09hbitoUUR3MkRMSXh3djhlKzFaRWpCMXRDZzRwUGdqM3c2WW1tOHo1?=
 =?utf-8?B?YnBsNWJ0UEFsbzRENzdZRS9yalVocDFiUk1iUDlBVnZscEthZ05EQW5hN0V1?=
 =?utf-8?B?bG42MjY2bkR1aFRnOS9kTnI4SUsyejFLRUFxQm9WQWwwNEV4d2NiRUJOWDdD?=
 =?utf-8?B?MUJObDZCenZrVXRNN2l0WUdxUXhkOEdpTWtqajJ5NzlIYWoya3J5RnNHTkNU?=
 =?utf-8?B?aDlqbmRYRXBtOG4rNzY4S2lOdHpnK2Z2Q21STjJHZE5CaW9XT080YllRSkRF?=
 =?utf-8?B?QkVXRnFSZ2VMQ0diYzZaRy9rQzZRRTcrUUEzWWNZRU1VbGpjKzd2c3owNnF2?=
 =?utf-8?B?aUo0YmYwMnBTTHhrOTJ0aUVHZHJUdFFSNGJpTzZ5azdrZlN2Wm5zTzI2ZERG?=
 =?utf-8?B?MXhobXpQMjBoZ2hkelhUZmRzNkNGQld5VU5nR3ZSaW1kS2k0YWdacGRNd2hm?=
 =?utf-8?B?dWFJbGZJNXZqQXhvcVRBSzdyU251QlNpZzIreG0rcVhpV0p5WUhmak10TS81?=
 =?utf-8?B?VnBYZlEyL05UV0pocDZvd21ySUhlVitYdUxTQkVvQlVudFQ0Wk5USjZEWGJF?=
 =?utf-8?B?U3F2Q2U5N29ydU5YNndDOUdjWTJ1cDBoVzlpbkQxb0JPOUYrZDFmSGJMZ05Y?=
 =?utf-8?B?UHBWQngvL0JCRFJCL09MNkxPZXErR1RoS2hNWEMwb0pabDN3bWN4ckQ1dW9i?=
 =?utf-8?B?VFk1QmRWTW1sUjVscy91UnlRVE00ZXY1bnBGTTlCOG9ZeXpxOGVjaXZsODdV?=
 =?utf-8?B?eitXNFpkZzkvd3JqU1BmSXVtN0R4Y1ZwQmcwS25SU01aLy9FV1Z5Nnpyck91?=
 =?utf-8?B?L3ZxdTVJd1cwMi9TQzdOZlpGV01RVEtIZzNZdUpMaXQ1YnF2NlUzcjAzU3RY?=
 =?utf-8?B?RmtsWmdPcVhKbkswS2l2ai8xT2VqVW41R0V1OU81ZFM0bzlYenpYTGx1YUZz?=
 =?utf-8?B?S3BVMWthdklSVFRJbVBNVG9KN00vSGRPTHpkRllaZ3FLd0Q4MzljaW0vY1No?=
 =?utf-8?B?RDZYaVFjdmVQQ1lRVGNaQVU1SEt1c1RUYmdUck82cHBHVDlYZkkzcEFWOTQx?=
 =?utf-8?B?WXdwUmx6bnhqTVRoWm1ISUsvbGliaWhGdHd2WjV6ZGhUbnlTQytDTUIyQkpo?=
 =?utf-8?B?MURFNy9QR1BrdnpvdFdmTUVQRk5mcVlsM21YZnVGNG9ndU1ocHo2ZGZKL3Jk?=
 =?utf-8?B?d2doa3R2dk8rZmtyMUtKRTB1djZiL0ZwclN4QTl2WXovS3BEREFEMHlKMkFx?=
 =?utf-8?B?RHAzMmE5TW5hZnY2cCtzVS9tMUMwVjh3MTd2SGZMU1ljY1VFWUJtSTdtU3lQ?=
 =?utf-8?B?UnZxRXdPdUpnaDFKWERtbUEwNUM3YjhZUXI4bkZQMlBxcG5BSkhBU0RaOGFG?=
 =?utf-8?B?SVlybEl0amZmTTUwcVc4SXB4bC94Ui9HL2hjbWk1NXRJZ3NIRjU5ME84WGZn?=
 =?utf-8?B?WldGSHJxMERnbDdkcFZOK29lVEtYSldFWUxTbitETXphMkJ2STZBNnlxVVBH?=
 =?utf-8?B?bmh5TVpmQmNnelYvZEpHVEw0T2l1M0YvYXo1ZGJub2NJMDl4aGV2M2VTSVJh?=
 =?utf-8?B?aUIrVFhGc3B4d095TFoxNEFrOTJQUklVV0VFR2lXUEZQZWxIakxUbGdIK2tB?=
 =?utf-8?B?UnFlL1BINFlEZ3ZER0dvbEZGcG5TSWhPaHplVjhVWW03NFNPTUNUSUl5b0V4?=
 =?utf-8?B?VDJZYTc2K3ZDQzd6NGRyV2N1TGNXaFhacUpwMFFPdXdPQlp2V3ZnNm5SL1oz?=
 =?utf-8?B?TzFIZk5sTnpaalRpMWl0dFNKTm5vNkRhcmdzMG0wZklvTzFxWCsvbVYrK2xD?=
 =?utf-8?B?TWlUZEVVUmtFMDBRUUY5cXc1T1FYTUF0akdDeWxDOHFjVmFRcXQweUJQenVx?=
 =?utf-8?B?amY3ZUg3Z1lJdjI1My9XN1VYSWFtUGV6amtWNCtyaC9SQVc4bDl3SVorSFcr?=
 =?utf-8?B?MmRjTENwY0VJN0Q5QzVWc1ZVVDF1ZENzSk80N0duSzl2YWRUWkNmMXNXN0t4?=
 =?utf-8?B?bXRObjRiYW1QNkRLQ2xvc0NHL2lrbnJEcllMbXVCOHpScEJZUEFLeGNaY0dG?=
 =?utf-8?B?RzVzd3crTTd3RkFLaUJDSFlhMnJlclRtdzNSdmtCa3VVK1NqVFcrVnZXd0dB?=
 =?utf-8?B?b2tlV09pdFEwT3BLTG43VmFwTFFkZlVOdHkxTHc0ZUxUR3hTUzY5WjVMQ2Zj?=
 =?utf-8?B?ZWcydkZWZWVod1NOd2dsNXJPK0h4R0MzMWVUNFNPM0xxSzREd3RIcDhjdGJ0?=
 =?utf-8?B?Zkh3OEFvRndNVjBtS3ZNU2wzQmFRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2991c2f7-0181-4ad2-90c0-08ddd8e08ead
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:08:33.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ln3T0SjxGv9iCGenHb7XbAn2dLa6u44pqmvHMaejbDqveLhucdCelmXDDRg2pRW7RYsGZbpNGi5RH7VdL10AQtfb4nL31uUH6LOJ+kQtqcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9666
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

Hi David,

On 8/6/25 8:14 PM, david regan wrote:
> bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB since MTD_OOB_AUTO does not exist
> 

There's also env/nand.c which uses this, can you also fix it?

Please also add:

Fixes: dfe64e2c8973 ("mtd: resync with Linux-3.7.1")

To the commit log which i believe is the commit that introduced the issue?

Only a 12yo bug you just found, nice catch :)

Cheers,
Quentin
