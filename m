Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4107E73151
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 09:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDAE83DA7;
	Mon,  2 Feb 2026 10:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dniiP9s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251F883DCA; Mon,  2 Feb 2026 10:53:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F14883D9F
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 10:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyUpJEMb6O+yjqI1Fi5ctgjzUdzs8g9goL1wd1WCn1O9bvCBafHijd0a7dvPhQQrj1RK86UNOKJN3k/uogz6GXaLkh3IvkqpKpRmOOHbNtV0aFG2xfhiF7hWzp5Ef9Mr9tR6JlEOUl6CpA0adjEiKNDMRvvLI+AE5lEdH1JpXZemA1x2WBhbKa2py+ccm2hTI3NPKcKWdQ4HHH1O+2eCTBLvPahgTae20v7P8FGayvdR40vtcfymKLVExcIjre0bQClU3jOup2z5hS9GGQ3Q6QdYvlyjhhF67NUKsjJ4BEYQZYazFzEENGAhBW/vWjHUgJt1JD98IO0zHlD5yySkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5tA3U36svLAjDMVXDW+lkeyCBK/wEZxGSPLSGlehNE=;
 b=JAOPOaeIXvfEOJBMjngbKYCh7u3qCQbE46c7cbFq3ZV4n3Iqq+Pz3J/+OWkfBheQUn+bkdC34DOdkqI+sWLxRkCfkdSbAs2p7/EHlTWYJSDYSz2YwiXeUOyVprnTSffzjeIWoL1vIEMpZ1PvfHbQdrTPFAaAtAe8ldNMNkHyuldzuZSTVYpuhDH0lNsQ9JrlAQuYYcg2ChK+5NkccZYieFu4gCszyW5U4hZpBU8MQvAeYbb5LDFIFnl4wd2X0sQZISwOYikrXuiSYv3SoA7lZKQ7z4fsEnwnWfQ2Ni/vHGwo6I7kPjvyjCXrPd9rMtIKQFmO5rvjCqwRlgXKfOIjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5tA3U36svLAjDMVXDW+lkeyCBK/wEZxGSPLSGlehNE=;
 b=dniiP9s3XHLN60loew7rwwMSK1wp+cTIX11IYtNvOlg9JqVhRn8Aq9VcENvBi09pauPjWBhvKRit2cnsa2gOK+1xVaPnUYu9QjM83WGdAWBIwwe4Sh/RO6KrdhNqrCASdjbTfOoUiZXW0aXRqvfeOnZFaaFYTiDAv3CjO01j+II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10106.eurprd04.prod.outlook.com (2603:10a6:150:17d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:53:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 09:53:08 +0000
Message-ID: <cfdccb81-4bc7-4e7b-accd-0524206f4547@cherry.de>
Date: Mon, 2 Feb 2026 10:51:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
To: Vagrant Cascadian <vagrant@debian.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
References: <87ikcjc1oc.fsf@wireframe>
 <11f467e2-1059-4edb-81a2-8b970b315882@cherry.de> <87bjiabyhz.fsf@wireframe>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87bjiabyhz.fsf@wireframe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10106:EE_
X-MS-Office365-Filtering-Correlation-Id: be01ceb8-2658-4f64-419d-08de6240de81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTIvSzRXaEFDUkxNWXFueVVrL2JXQTFlOXdEQWVES0FQUGRtWWhaTjJFMUl0?=
 =?utf-8?B?NG50UUlnRm1UN1JHenVaYnVFK0U4REQwbnBrRTcxQTg4cjZEUXRxMWRwd25a?=
 =?utf-8?B?cjJ2YjM4N3JRcThRV2hMb1BWcnRKTEEwN2NSaEhBK3J2NXU4UkxaWUdiOTRj?=
 =?utf-8?B?L090eEd2dGxSSlhWV2FRNlQzQ2xyRFUvL2hlajlIeEtxV0dSRmJLckJsUGEy?=
 =?utf-8?B?U0ZleEpmNkZ2Q3AvbWxydlFaSTA3d1VYMTNuclpUUlVRK1l4OGIyanNOU2Zo?=
 =?utf-8?B?Z1U4VG9MTWtaRWdjMUZoNldwajJEck9HaFNYQ0Q4R2VaajA1aGpkMFhFbHp6?=
 =?utf-8?B?UTN2UVVYRFBxV1JoQTFZSHFBSmR3UzJjMXBJZXN3RkNOaE51NDdNNDB5MThM?=
 =?utf-8?B?OGlPR1YwTWlleW0yWlBIV2JEK0N0MmxRcy8yQVlRQWlhY0RXN1pVTUNzUkRa?=
 =?utf-8?B?VjVxc1MyYVJwaU5kUldLcHUwL2pKc2cwaDA5bGpoTkNFZE9TQ3FBQjE1TnJH?=
 =?utf-8?B?UjRQVGxkN1Zsa0Y4L2h6MHJYWTI4SHZraVNLdFJRMWRNbFVOM0lOUFpiUTJD?=
 =?utf-8?B?ZkZ0M04zb2lIMXprcGNRSjdyVGN2T0FkWW1yemg4SU9wNU52MklYcUhjVlh6?=
 =?utf-8?B?aUxSQkNtckp2dVhlRE9ZWWlYYnpxTWwxbmZpNGcxQS9yZXJ6QzV6WXBHSzg4?=
 =?utf-8?B?YXJFNkpzNzlETnVreFhaM2lqTUxPTUM3NmlJSGkwcjZBSmVEeVR3bVlCRHFt?=
 =?utf-8?B?TG1PYU9rR2drVXdvVTFCcExiS2FvUUJrZm1CVHp6UEVPSlpxTG5wRG9uYlEz?=
 =?utf-8?B?aitVYVpIdFQyZXpVSHljSXFCN3FHU0o1Yno1aytKcUwxRzZRWDkvdERYQ2ZL?=
 =?utf-8?B?Y0U2NXRHTDBSVjJiVmMxaS9scjZYdE8zU0RhWWIxbE1XQVpqbGRxVHhiUzdF?=
 =?utf-8?B?WXloQWtIZjRWaTBFMkJHWHVnSnV3V1lKelJPOUV3N0w2N3BubHM3ZWpaR25v?=
 =?utf-8?B?NWNjQ3d0cyszWnNoZ05rZ2pqSUQyWTZXbXVLQjJHQldHRGVNeHh1a1JCSitx?=
 =?utf-8?B?eWk1RjVLRVJEYzRkUktBQUlXcFVLTmIrQ0N0dDVqdzVDNzZpdnhjRzBUQ3Jl?=
 =?utf-8?B?di8rSWg3cnNYRUU4VVhMN3JhQ2ZNTkp5U1Uvc09IYjFFZ084N2Z0bnJwNC9X?=
 =?utf-8?B?R1BXVldhMGdMOWMvZE0zS3pxOFVsMmh0WlRsTG9URE5NbjZ5b2J4cUtPeG4x?=
 =?utf-8?B?ZXZXaVg3WHovL1pINi8ySllIY3JsbkRoMjhsZEdmbVJVUjVEemJLdDZOOUtj?=
 =?utf-8?B?cGtjVmlTbjdneFVCNGlsbmllTTJmUTlIVVdkODNFM29lbWROU01iOFNQQzE3?=
 =?utf-8?B?MVpHUUZHcnlEU3h0OUtYZHFYYjVCR0xFZ0JZQlcxekRLTk9yei91WjdkbVJY?=
 =?utf-8?B?UWt0eFRWcDYzSUFkaFNRdE1sZWMyMFM2VU9mTDgzQzVJcEsxTFZlQjA4T09o?=
 =?utf-8?B?R1UyM1FlclVXMnVrc1E1MVdvN1VEaTQ4Vjg0M2RNVmN2em1SL29TWUVrd2Z5?=
 =?utf-8?B?ZGtWYlk2RGlEZnRLUll0TDB0cUtKSUw4V2tseFFCVTdSZHFwT0g4OW82V24v?=
 =?utf-8?B?aXNUZTJVZjA3dmlzTkhYQWJUWVZiQmVkZTFaaHBjYUdsQ1BlSnkwOWpoa1Ax?=
 =?utf-8?B?RFRGUVp2dDV5Rmc3c2RnOFptVXFaQ0crVWxnaTBPZk1XRFJvSzFlbkZzYkZm?=
 =?utf-8?B?aXdnd1lCQ3hJdXRKWG93Kzc3cmFrc2IxQXhSdDlyN09sM2dsVDlMcDBWNitQ?=
 =?utf-8?B?ZDczc1dKTVp1azFVeGhDd1FHalJobGVrL28xRXRVSnN0Wmg0MEZXZExwS2Vk?=
 =?utf-8?B?c0dhc1ZwTFZ4NDBobFVzYnlzSjdjQld3OWQ2T1BKRnQ5SFNOcGRJZTFVclo4?=
 =?utf-8?B?dU1EMk52VVFycDJKMUY3WHdXTU0yMFlyNUY1OTZnWVdXZmRMR29lTFo5U3No?=
 =?utf-8?B?L0hoL2t2cWhaYmcrcFdDY2FIMEptNjNuS2xSWWxRWjRGNmdkcy9hNm1NNFBO?=
 =?utf-8?B?dEYrZ3RQelkweFAzTVBuWWhOWjhNVkszNWFuUVBpSkZITDNmWDB6ZFZGbU9n?=
 =?utf-8?Q?CW5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlcwREFIc1NEbVdHTmtCcnZ1V0hnNEZTWU40SDd0QkxOUUo4WjVTSkFzanVZ?=
 =?utf-8?B?VHc3akQrdVNOUzJKazg5TGVRVnByR0RJMHB6QjdQV2xJOGdSOXBuUWs2MlFJ?=
 =?utf-8?B?OWNRVDJxZ3dpUVJRUVJScDZNaFVPa05ZUWo4U1M0SGllb01OK3BJRE9RajND?=
 =?utf-8?B?YWZOekRYWGw0MStKNVMvVXp2ZWZoUkJxdHhHdWl3S29iZjNNZDA5a0RYeTRV?=
 =?utf-8?B?SlFTNzhBTmJFeVIzcVZtb2pycFRFaWNJbEV1MWJ2L20wdkZuaStjVXRxMFo0?=
 =?utf-8?B?dkt6Z1FRSWdRK1ByMW9BVmRZMkQ0YmJWRFh1M0lUL3RsQ00zbFhNNDBzWjUy?=
 =?utf-8?B?L21nbXJ5S1dTa1VQcC8zT0tRYXpxNGx3M0lLWW1zSHBLUnk2dTdGSHN2b0d0?=
 =?utf-8?B?YjB6YlNBVDd0am1VSWN4bFA3YUQ4M1RZTXVoVHNlQlRSd1RFUjZRZ0lLNHh1?=
 =?utf-8?B?Z0VhSEVvUGNBdHJZZFZWMHU1Q1hHRjdQQ2k1bUkrSWxvL0ZhdzJOZkxxeXRk?=
 =?utf-8?B?Nk5oYVVlaWpoM0ZpQmlic1h4akVQNnpoU2tDZ2hwcERCd3RSWk9RcFJDRWRq?=
 =?utf-8?B?WkgyekR2RXFheUtZT28rZlU1TjF5VUZvOW9HZnNZQjlJY05xZ0ZWVC9tM1VF?=
 =?utf-8?B?dDk1ak52Uk96R1VhKzdqR0Jyc0YydEUyZ3pFenVKUjJqNkp2d0FHVEpnR1BJ?=
 =?utf-8?B?NVZ0TFVMbi8zeWluNTRaYktwRk1wV0RaUkZja3c3OEJCUmFtZ3lQcU96dW8x?=
 =?utf-8?B?RStPNnRodHY1bnJBeGsxeUF1NzYyZ2dvOU4zUXUwZWpMaXV0cExaL3FXTms4?=
 =?utf-8?B?NzR5YW1rMkxNVFRVd0lXNGFMeWNTWEJyNE9EdnJjbEs1dG5hazdoVm5HdFQz?=
 =?utf-8?B?Zmw4Sy9GQS9pZDdwL1A3dVN3Mk9OUC84ZEpTV2IzK2xZdnR0QjJOeXk2dzR1?=
 =?utf-8?B?ajJGdHgrTUJNckltRWlLVEl0dUhGMS9Nc0Z1UjBMNEIrSE55QlI1S29rQVc1?=
 =?utf-8?B?eVkyK09lajliR2cvemlncHZOdnEzWmRxdU8rMHozMXlCYzIzSnQwZjE1QmJN?=
 =?utf-8?B?Skp6YjR2b0htODB3UEM4cE55U0xaRWRGd3doTUNaR0U3MHhERnZVNXplQjR3?=
 =?utf-8?B?TCsxTEdvVERFdTY3SEVPWXNPYktieUdySmYwaXZzSm0rUHJMZ29zL0hZSXN3?=
 =?utf-8?B?b1F6c2l0Q2ZSekRtOUN4UkNPTVlvZHJ3L0phQ1dWbFc0OGxKRFhJTW1aVjMy?=
 =?utf-8?B?MGRVMzFxdTVCT3V3V1ErMXppZW5CNnpQNWcvT21oV0lTNEowUHpRTHM0RHFu?=
 =?utf-8?B?Wk9RK3RLMDYzN2h4WnQ0cE5VYi8wRW9aSDdleFp4REc5T2R4Ty9CK2lKWXZn?=
 =?utf-8?B?YnhZbkFqT0l1WVlFd20wTEg1NHpMU21udVpUNy9IaFhWWnhBb1JpNnhxNlBJ?=
 =?utf-8?B?U1AwWWdWOHBJelVyTERBbEZPMjNsMGx5OEE0V1B4c2lnOWZtck9UZWJQdW9w?=
 =?utf-8?B?S1BIS3BrbTV6VXZQc2NtZ1FuaHd0WGVFajRzQkx2dnRZcHQ5OEtFY3FXc095?=
 =?utf-8?B?M201anBRa1NSbFV3YUZTMUZoNDNMakkyTmU4ajUxNTFxWkFlYUNGSDlmWjl4?=
 =?utf-8?B?MlhVelQySlVlcWtrSHd2QXB4UFM0TjgwV0RZSmNKbVluTGhyTk1qTDFpSlRk?=
 =?utf-8?B?bUFoSndISktMMHkwL3FvUEYzMkZuZ0JTenUxaCsxVHc3ZlYrSzFQWmJuTnE2?=
 =?utf-8?B?czNMYW1WR0ZaT29VWWp3WjZWeGhNQXBiSFdsejVPbnVBYUs0M1Yrcjc5UGY3?=
 =?utf-8?B?VFdmSCtRV3BpZXJsQStrTHY4dlpZWE00a0UxMWs5UzRuZGRwMkpJUm1PMTJG?=
 =?utf-8?B?TjdmYzcvMDlDS1ZtdnJrUWJaQ1JUZGRQZjVwN29GcGtZdDMrS0hBMHBzeUho?=
 =?utf-8?B?QmxZd2s3SDRoOWlJQ1ZYR2NzSE1JZ2pjV1c2QXg1VFk5c1E0alRCWFpUV3do?=
 =?utf-8?B?YjNqc2x2TVFETnk1UXlnQU5ReVNwdTdsd2NnRkRXeUNrVVRuTEYyQnp4bkNr?=
 =?utf-8?B?Wmc3UWRlb1RtbTdKUnlqWEJNZU4rUTAyZWlSUHo0TXJIcWVBZGwyV24ybmN3?=
 =?utf-8?B?M2JQZTQ2OURjTC9EU2ZHa0RmYm5rWWMyT3ZVeVY0WTE3YTUyYmNYQjIzQmpR?=
 =?utf-8?B?SDVHZG4wMklCRDJCZklvUngvK1FEdjlVQ0E3ZHBEM1Y5RCtCeDFEUjVBY2NL?=
 =?utf-8?B?azdRTTMwdzA2dGNzcVVxTmxsSjhvTm91T3FpNC9pcmJmNDRReU5MMjVPcEtP?=
 =?utf-8?B?Ui82TldvNUJMQWVMekJFS2N1TktIMTQ4TWZncjdhenZxRW4wZ3FaZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be01ceb8-2658-4f64-419d-08de6240de81
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 09:53:08.4495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTROXMQaLRSUuiWZe67KtxVbb6blUvWn2GYogCZ0gvm93UgMxeYrI+zGgk6nxjrtpmdIeyF5AXMVybUczqyWUbTtXkcrVr7VTHB3WUJgLgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10106
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

Hi Vagrant,

On 1/30/26 10:07 PM, Vagrant Cascadian wrote:
> On 2026-01-30, Quentin Schulz wrote:
>> On 1/30/26 2:46 AM, Vagrant Cascadian wrote:
>>> Thanks for adding support for rk3588 MNT Reform2!
>>>
>>> I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
>>> gets as far as SPL, and then fails:
>>>
>>>     U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>>>     Trying to boot from MMC1
>>>     mmc_load_image_raw_sector: mmc block read error
>>>     Error: -38
>>>     SPL: Unsupported Boot Device!
>>>     SPL: failed to boot from all boot devices
>>>     ### ERROR ### Please RESET the board ###
>>>
>>> I *think* MMC1 is eMMC, which I currently have blanked, as recovering
>>> from a failed install on eMMC is trickier.
>>>
>>
>> It's surprising it isn't trying MMC1 twice as that's what it's supposed
>> to do due to u-boot,spl-boot-order containing "same-as-spl" and the eMMC
>> controller again later in the chain (see the property).
>>
>> In any case, no support for the SD controller in SPL according to the
>> defconfig, can you try with:
>>
>> """
>> diff --git a/configs/mnt-reform2-rk3588_defconfig
>> b/configs/mnt-reform2-rk3588_defconfig
>> index 6adc9e4e60c..982e6c6eb20 100644
>> --- a/configs/mnt-reform2-rk3588_defconfig
>> +++ b/configs/mnt-reform2-rk3588_defconfig
>> @@ -50,6 +50,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
>>    CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
>>    CONFIG_MMC_HS400_SUPPORT=y
>>    CONFIG_SPL_MMC_HS400_SUPPORT=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>>    CONFIG_MMC_SDHCI=y
>>    CONFIG_MMC_SDHCI_SDMA=y
>>    CONFIG_MMC_SDHCI_ROCKCHIP=y
>> """
>>
>> and report if it gets you further?
> 
> Much further, indeed! With that applied to 2026.04-rc1, I managed to
> load the kernel, initrd and dtb from NVMe, and boot all the way to a
> rootfs!
> 

Good to hear!

> With one big downside... no display on linux (eDP? panel, or on
> HDMI). Neither upstream u-boot or vendor u-boot provided output on the
> display, so that part is not a regression.
> 
> I have a slightly older rk3588 module that does not use dsi -> eDP, that
> might be an issue... maybe upstream u-boot vs. vendor u-boot is
> configuring or not configuring something needed...
> 

We should have HDMI support for RK3588 for a few releases in Linux 
already. It works on RK3588 Tiger and Jaguar last time I checked. Maybe 
missing/disabled DT nodes for your module, or drivers not 
selected/installed.

There should be eDP support as well, we use those lanes on RK3588 Tiger 
Displayport carrier which uses eDP for the DP connector. I tested that 
with 
https://lore.kernel.org/linux-rockchip/20251009225050.88192-1-heiko@sntech.de/ 
so maybe missing DT nodes for either the eDP controller or the panel for 
your board?

> 
>> I think you'll be missing support for
>> the CD gpio as well in SPL.
>>
>> So probably you need to enable SPL_GPIO:
>>
>> """
>> diff --git a/configs/mnt-reform2-rk3588_defconfig
>> b/configs/mnt-reform2-rk3588_defconfig
>> index 6adc9e4e60c..7485d03a0cb 100644
>> --- a/configs/mnt-reform2-rk3588_defconfig
>> +++ b/configs/mnt-reform2-rk3588_defconfig
>> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>>    CONFIG_SKIP_LOWLEVEL_INIT=y
>>    CONFIG_COUNTER_FREQUENCY=24000000
>>    CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_SPL_GPIO=y
>>    CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
>>    CONFIG_ROCKCHIP_RK3588=y
>>    CONFIG_SPL_SERIAL=y
>> @@ -50,6 +51,8 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
>>    CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
>>    CONFIG_MMC_HS400_SUPPORT=y
>>    CONFIG_SPL_MMC_HS400_SUPPORT=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>>    CONFIG_MMC_SDHCI=y
>>    CONFIG_MMC_SDHCI_SDMA=y
>>    CONFIG_MMC_SDHCI_ROCKCHIP=y
>> """
>>
>> aaaand also enable it in SPL DT:
>>
>> """
>> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>> b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..47509f4cb37
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3588-u-boot.dtsi"
>> +
>> +/* SD CD */
>> +&gpio0 {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> """
>>
>> I believe?
> 
> Do you think it is worth testing this part as well? Or is booting to

Likely yes.

Can you test having U-Boot TPL+SPL (idbloader.img) on eMMC (block offset 
64, 32KiB), but not U-Boot proper. Have U-Boot proper (u-boot.itb) on SD 
card (block offset 16384, 8MiB).

U-Boot should boot from eMMC first and then fallback to SD card next.

You can also try the opposite to verify this is properly setup as well.

The BootROM initializes various controllers such that if U-Boot doesn't 
need to use another storage controller in SPL (or in proper 
pre-relocation) it'll likely reach U-Boot proper (and Linux) just fine.

You can have this split in two commits. One to make it possible to boot 
from SD card, another one for supporting fallbacks.

Cheers,
Quentin
