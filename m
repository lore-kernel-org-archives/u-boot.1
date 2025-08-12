Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A04C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 13:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE9E833BF;
	Tue, 12 Aug 2025 15:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AaaGZbRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4244983257; Tue, 12 Aug 2025 10:11:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC99F8319C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADtmDLdS8AXsMEKIDM+4lvxq8g9jbIUCvVSTb8WjqI3XWAkFX1zOmIVxsOtK270C1CcaTi0uN/QRFit0GF2i8yw7+9UvX+kL76QcbdAnPgKguEkpFlSu1eaA7+0cLSIFUuvjMpA35IgqHVnO5104wCaz6j5+yqjYPk7418CJHSKvtS5yS59s8gfgdAIMVH3TIE3/FVsfVCpwjqldoHaSaV1Fj5Gju6/3HXqCkfF7bbw+K0S3O/nFSBEeHhl5G7YBhUN/3/9HIFgIEg9NsFg/pEllqRhk3/Jcjh0cgtTzxiPAs+wf8uOT75ChqqrwAvwJUDAk5djFGbzGb4aL5BbR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlKZiFDJzFwve6MotFJ7RQWI0F/noSLUkjJOqJ5ceec=;
 b=nI6pbTV02O4kQdxneMUl9/zHnzAN2f8andS3N6QcP269RmsdNSuo0khxrQew+hRHBiepAJJ2EcMQ00DPWzOe8pScq7HKIeJOefQGB0a9rjL0WjKK4L3pTOhRe1d+h0JFJ44u0rLtox7itfjxr6P9BnIBgSYheVY+0Xps/lt1pcbS8wpk/h31KsTHKn91dAReIEB98WPNGGZG+RiobTDmZFvL+x2+dmrTMb9R67oqkAsvzeVdUAGeps9TNSX7aQa/9dK31zTbFWF57ITsJXUWTf7SUqmUoSbxXsdec/ODgZt66o/C/SG32xFrSnjAQob0uXr+CQeigCjWq8LZSKuicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlKZiFDJzFwve6MotFJ7RQWI0F/noSLUkjJOqJ5ceec=;
 b=AaaGZbRE2k3mg7RfL4yzuSwuAFfRcmA5vbl+swk7IlSZaa02+ZCkbJGbIdCXIxpHi8GdjlGAlz75ZkoJmQ5zggcDMXF+SBPgVac0DWgAAXpDBBy98hMEpKTpMfWbMExyksww8ltQbNloG0ynfBw2aAaq29fIYR962djp/3uvIoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB11031.eurprd04.prod.outlook.com (2603:10a6:10:592::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 08:11:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 08:11:21 +0000
Message-ID: <eea28c61-b571-42af-baca-d390489242b0@cherry.de>
Date: Tue, 12 Aug 2025 10:11:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] board: rockchip: add rk3368 ymd8_mb support
To: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Cc: u-boot@lists.denx.de, antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, andrew.goodbody@linaro.org,
 sumit.garg@kernel.org, ag.dev.uboot@gmail.com, rfried.dev@gmail.com,
 joe.hershberger@ni.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 seanga2@gmail.com, lukma@denx.de, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 WeiHao Li <ieiao@outlook.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
 <20250807074419.336752-11-cn.liweihao@gmail.com>
 <e19f94a0-4d69-4c63-bbdb-2598e3f5bf68@cherry.de>
 <CAPEOAkQS_0eHZ5ZKOGqj-+4bZfyXdBDpZSKsQfzxfxaVMei9aQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPEOAkQS_0eHZ5ZKOGqj-+4bZfyXdBDpZSKsQfzxfxaVMei9aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: d462c4e7-8a7b-40c2-0b6a-08ddd977d2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUVUM0VDaW9hbnhIekFGdG8zWXJreG1XK21QektnS2E1YjFWWEhxRUgyOUVj?=
 =?utf-8?B?aTJNRGIwU2I1ZS81NW8yOTlMOVlSRDdSd2JWNEZEQnk5VUgraXN1VktDMzZW?=
 =?utf-8?B?bDRWcWdrd3RlYWlnUnFrYXh5S24wOG9rTGxMdFc3Ly9aZFNZRWV2NEVaRlN4?=
 =?utf-8?B?TFNBV3ZVZGlFUER2ZnRJaGdkZ1ZBS3duTnRUMCtoNEx6MmFzcytCRXpDWkIr?=
 =?utf-8?B?RlB4L3JDMTg4MFUzL0IrQUxtL3g2ZElLdk9ITnFyTTN2bXRiUlpsa3paeWkv?=
 =?utf-8?B?YUl5YXB6WHhwREMxbGs0dm5xWTZQTkwrSjdraXNxUUNYK3lJNzFMMHhwTE5t?=
 =?utf-8?B?aWVoVCtPcG96dzUrSVhDaDhoaHVMbmJFWHIrTjI5WnVTdkN5cUNQZWE0dWxw?=
 =?utf-8?B?dDVCeDhkSzRQUy80MTZGaGtyOFFvOWsxeWtpVVlyZ2E5TXZYS2tEZDVGV2J3?=
 =?utf-8?B?OWRCTnNTODZBMU5wMDhhcUNMUkg3MU9vR2hiN0dtbnZaaVNqQ2J4azl5cGR1?=
 =?utf-8?B?RmJsVGRHcjNrWjNqU3hlVERjYmtMTjd5VFAySVBPazdWdE55c2FsZGZYS3hX?=
 =?utf-8?B?Rzd0ZnJEYXdiazQ5RTRwM3hLbzB2TFV0QloxR3ZENHBtRzA5ZGUrS1c4RnlL?=
 =?utf-8?B?Y3IvaFVtcWxXVkVVNjRDbmNPbXN3MDBtKzJFOForT2c5U0JycFc5d3J5VFhh?=
 =?utf-8?B?dEJsL0Nyd0dqK05XOVNzelNKenRnWWIwLzNWM1ppck9FRnhlbDd5VkY1Q0JE?=
 =?utf-8?B?RVFnTXBGMTFmVTNoRmx5VE95VG9VUFlsSTZUSWord3hqRU96MkNwYW1naFlV?=
 =?utf-8?B?WlkzWG5OZjh2WGgrczdmS1djUUFKb29mcSsxT1ZxcUFrL1hUQk5RQW1ZYmVW?=
 =?utf-8?B?anlsRFFud1NzUEc0bnVYcUJvc2ozVG0vU0twMXhKRWtZbit4YmJZRnM3Y3RP?=
 =?utf-8?B?N0RvVWZpM2FnQnZaZWgxdy9lT3F3RDkvaEJTMkNUenY5dnVTNFVJTjVicmR2?=
 =?utf-8?B?VVFrUjVIVkhJZTFtYTBlTG1BN01teFk4cnladjdVczc2UVpQZU1MRTB0Qzlw?=
 =?utf-8?B?anlDV2pHUm9weHhYeStmcksxRTFGRlRVVW5UQmNMaHFSaG8yMVk1dmNzZ3h2?=
 =?utf-8?B?UFhvNnBTdVB0MDJodkxPbG9ZUUxKNGpiMEJmQVREZjgxRU1NeVprdUgyWXRM?=
 =?utf-8?B?dVNWZFFZY1kybEtpaUFnTUdHZHN6aHFBa3pWcnlzOTh2YTJVOFNDcjVCMnZm?=
 =?utf-8?B?ejRSNkhIdjdqSFdpUXlNVWJ0MGowSi9RN2xQcE1aQU9PbmhYeTJQUXVKZXd4?=
 =?utf-8?B?TWFCdHQxZHI2NzZueXNmV2J4MzAzUHp3Y3hQL0VLRHZBQVo0VlNFZUZrTUM3?=
 =?utf-8?B?NHYzRHRSOThvdVhOWHgyOTNmSTFPbUVLcHJCNmZPL0g5M0IybVVpQWJmdjJ4?=
 =?utf-8?B?bUxqcTRhSHB5emo4ZnRaQWp0c3hzZXZ4UmdFYlpxYVlXQUFqUndROEx6dnpP?=
 =?utf-8?B?SzBabnViZmVIanNuRkhtcXJiRUg5NTFxQndsS3NBVjY1Umg4b1Q3ZXhwUUpv?=
 =?utf-8?B?QXlrY3RqWUwvZGZaSitjZDF1SGxCOVQvaGE2RVFkWmRycGh3UzdNeXNvOUNH?=
 =?utf-8?B?L0RjM0ZsSXZkSFpOUm1seXlzcll2WkFRaVE0MXNjYVZjMTRtUEI2Vm92QjNl?=
 =?utf-8?B?elEwVlVXQ0RhRkcvd1liS3BFNU83MEQwd05peE5yZGgzcHFpNGtUOFR3UmVJ?=
 =?utf-8?B?dVFiWlVZLys4M1dwTGZrRkEwcUJFVEJ3U3U2U24zYkFZTFM2MG44SmtBNmV3?=
 =?utf-8?Q?M1bwzuzfsityI8MkWgfoQKV58fT9zzNuVL6gY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5mclcxVWtyRkdkWitCenZSR3MxRmoydzV1UHB5R2lDR3U0NU5kNzAyczRv?=
 =?utf-8?B?NUVXeFBEWlVGdFVDdFNsSkFUSlRGNkx6ZG5Ubkg5SW9MOFc1TGd2TUxqNWZt?=
 =?utf-8?B?TmNYUnIvVTZWM1RCQ21xNEZmSU44M0FnSG8zdnZCSG4wS0Y2aUhFREJyWlV3?=
 =?utf-8?B?YmxSWGpCRjFQbHgzSzAxRnY1cUpoNGxRVzZWaEw0c3dTbkZxMzdIYjQvSHRr?=
 =?utf-8?B?UkxJeEVNNURYdTNuTyszdngwNzdCVlJ6amJ6VEtneXd6ci9HWVk4Zk0rMU0y?=
 =?utf-8?B?MWhSN0p6ZkhGWU0rTUpnU0tzbitPbGxQcXVrMGVRYWlCVjNLMUhFbTRQY09O?=
 =?utf-8?B?M29pZ3MxamxKRXZTbjJaRjQ0MjBNS3dLSGd5YXhiaXhoNGZSTkZIalBobWlB?=
 =?utf-8?B?RVM3Z0xKRFFXRlJzS1dEMHNUdmM1UktNVFNRdllCZW51VXcrWjc1Mng1Tm13?=
 =?utf-8?B?a3lDRDVreXZ2ZEYvUDhCbnJOeWlpT2Y3ckpuQkM4aXhPVzlEZHlPTVNyQ3Nz?=
 =?utf-8?B?Q3FTRHpYUGEwMTVqa0l6WTJhSDc5Z2x0KzJwSTVGR1ErRCtLKzN1Q0MyaDU4?=
 =?utf-8?B?dTlZZGZ5dlArV29XK2w4SXVjbVI5TnNiZ24yYmRYNUpnWnhoQXIyY1BSaTBk?=
 =?utf-8?B?NVVHY2c4ZGM5c2xPTm42dGVFbzlDcTAyMjczS3hTbk1SVkJRS3pUQjlhdWN3?=
 =?utf-8?B?dzdLQ3REamMzT3MvY21rTXJJRHpXKzN4eVBhc29RckJ4UEUwUEY0dWEvRi9y?=
 =?utf-8?B?aHBjcjdnVEhibHVIbVpuZWZONW82VE8xbHBhRkxneW1nWEVSSUpYOHBoK1pV?=
 =?utf-8?B?c3AyRkN0QWxXWlVRQlJWTlpJbDBoVjlnbWd6b1huTzNiMHNSMDVIL3FnWE9z?=
 =?utf-8?B?bW0rRlRsWldIaUxwSkRyZ2VhR0MvM2R2QXppaWNSTVc1MTdXaTJ6T0loZGNX?=
 =?utf-8?B?TXdEYWR3YkV6SDVYeGNCaFREM3dvdENwb3NRUjhyYVZydlRPMVRFaXFlU2NK?=
 =?utf-8?B?RzRzU2J4SXpVYUhOTHNPT1paMFEyQ3h5bjYwaW81VEdTYlVhWGQ4aTJ5VHF2?=
 =?utf-8?B?NmtJV1B3SzZUVmZkc1JmQ3VScU1ORjJpemVBSStBekJ3bDJyVC91YTkxdUNG?=
 =?utf-8?B?ZDB1Uk96bnBHMDF3UE5WVitqSjV3STI3SHEyQW5uRTNubzdvZk85RXd2dzNz?=
 =?utf-8?B?Ull0ZmRWOXcyTUxiK3BSWE5WcDRHZ29ndHkzdktkSWQ5Wm5HenhVemRndC9O?=
 =?utf-8?B?NXl5bnhveDBLdE9PSEVzS2tmMUY4YmZESTEvQTIxTFJTa1F2WjBzUWhZN0Ja?=
 =?utf-8?B?ejNnZUhoTDZjaXdwOFF1NlVTMktRQkFkck5zQVk3UzFhZ3FuMk5nd0ozWHJ5?=
 =?utf-8?B?cWUvWU5DK3lUejBQNVBLUVIwd2N0Z2dDallNdFkwT3NpMyswR3d4UFJtemlh?=
 =?utf-8?B?VitWdDZNR3VTMlVEM01LTTRqQXdvZi9oNDZ4b1ZwYzYyTC9Yc1I1NG1pdGcv?=
 =?utf-8?B?eTVoN2Uwek93K3BqTyt3cWRBbTdkeXBXaTh3SnlLV2hiWkFvK2dEQ3ZKTWt4?=
 =?utf-8?B?SFpzaEVEYjlRT3FIaGE4Y0cyZCtGSXFBRm1SV0NoaStOaUJQd1FiRmxGd252?=
 =?utf-8?B?R1BQMnUxdHphcy9pMWdSemZtazh1bXRoWnExTFB6RG1hbWYwZWFtMHJpMmxZ?=
 =?utf-8?B?Z1VPMVEyc1Y0RWRhRXBOeFBUMHJuSGJSd1lwSDlxMitHOEQrVDNXcFhqQTRn?=
 =?utf-8?B?YW5YT2ZjUmxQTWZWVTFuOGV0UTZmQTZzMnRhV3dpTDhPVW85cDlmWkN3eGg4?=
 =?utf-8?B?WEV1SlBHZnZsS3pQZHBhWUZkZVpHWWd6N29iVGs1NFJaWThacjFYcmpxRU5J?=
 =?utf-8?B?ZFdaSGRMakdCZ2dZcUp4MExmeTE4M1hoQitzYUE5a0VLWFFNZjhRRExxMWRG?=
 =?utf-8?B?UU1VTFMycm80TG4xZjVXZG5yOWpxSDJvTmRybHo4SkpNcmozN2VoRFMrNjQ5?=
 =?utf-8?B?NWVlM042emg3MkZFVi9oVDVsVWVCbDFLd1E0L1RhMkczbFFDbzNjTnBNbFh3?=
 =?utf-8?B?OEVtVlFMRTRVd2wyc05nM2NoUTJHTjhhREFZd2FpNWtQbFdlQnowK0FsYUxw?=
 =?utf-8?B?Zllkd1N3dVMzNkVBeVhLbFFlOThLazcxeDlvQm9Xc0l3em1GeWMwSnNOSTdr?=
 =?utf-8?B?YjBkb0pTL2ExVzZjOWo0bTgzZmN4bTNaekdFMWQvcUYrTGtVRGVMbk9XMCtP?=
 =?utf-8?B?ZDNIM0FNRkJBVFlUR0E0SXQrYm5nPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d462c4e7-8a7b-40c2-0b6a-08ddd977d2a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:11:21.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S71DBLJJmFpxQgDEfHYRiYuhiysDydMMfcQwb8937nzWF11VoMENnzIzgq01yFBzYBb89ENLkFnPgqjTM+4AR4tR4vTH08J1QKzqMTSxXog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11031
X-Mailman-Approved-At: Tue, 12 Aug 2025 15:14:11 +0200
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

Hi WeiHao,

On 8/12/25 3:25 AM, 李维豪 wrote:
> Hi Quentin,
> 
> Thanks for your review.
> 
> Quentin Schulz <quentin.schulz@cherry.de> 于2025年8月11日周一 23:01写道：
>>
>> Hi WeiHao Li,
>>
>> On 8/7/25 9:44 AM, WeiHao Li wrote:
>>> [You don't often get email from cn.liweihao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>
>> Please always include a few words in the commit log.
>>
> 
> I will add some necessary description in the commit log.
> 
>> I believe the description of the board as told in the cover letter is
>> good enough, so start with that maybe :)
>>
>>> Signed-off-by: WeiHao Li <ieiao@outlook.com>
>>> ---
>>>    arch/arm/dts/Makefile                   |   1 +
>>>    arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi |  44 ++++
>>>    arch/arm/dts/rk3368-ymd8-mb.dts         | 326 ++++++++++++++++++++++++
>>>    arch/arm/dts/rk3368.dtsi                | 258 +++++++++++++++++++
>>>    arch/arm/mach-rockchip/rk3368/Kconfig   |   6 +
>>>    board/rockchip/ymd8_mb/Kconfig          |  12 +
>>>    board/rockchip/ymd8_mb/MAINTAINERS      |   6 +
>>>    board/rockchip/ymd8_mb/Makefile         |   7 +
>>>    board/rockchip/ymd8_mb/README           |   1 +
>>>    board/rockchip/ymd8_mb/ymd8_mb_rk3368.c |  19 ++
>>>    configs/ymd8-mb_defconfig               |  72 ++++++
>>>    include/configs/ymd8_mb.h               |  11 +
>>>    12 files changed, 763 insertions(+)
>>>    create mode 100644 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/rk3368-ymd8-mb.dts
>>>    create mode 100644 board/rockchip/ymd8_mb/Kconfig
>>>    create mode 100644 board/rockchip/ymd8_mb/MAINTAINERS
>>>    create mode 100644 board/rockchip/ymd8_mb/Makefile
>>>    create mode 100644 board/rockchip/ymd8_mb/README
>>>    create mode 100644 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
>>>    create mode 100644 configs/ymd8-mb_defconfig
>>>    create mode 100644 include/configs/ymd8_mb.h
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index 0dc7e190eb..1dfd1c5236 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -73,6 +73,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
>>>           rk3368-sheep.dtb \
>>>           rk3368-geekbox.dtb \
>>>           rk3368-px5-evb.dtb \
>>> +       rk3368-ymd8-mb.dtb
>>>
>>>    dtb-$(CONFIG_ARCH_S5P4418) += \
>>>           s5p4418-nanopi2.dtb
>>> diff --git a/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
>>> new file mode 100644
>>> index 0000000000..925264e620
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
>>> @@ -0,0 +1,44 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR X11
>>> +/*
>>> + * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
>>> + */
>>> +
>>
>> I'm quite sure Theobroma didn't work on that, and not in 2017 :)
>>
>> Please remove us (Theobroma got renamed to Cherry Embedded Solutions
>> last year) from this copyright notice and provide the appropriate
>> copyright holder there instead.
>>
> 
> Got it.
> 
>>> +#include "rk3368-u-boot.dtsi"
>>> +
>>> +&pinctrl {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&service_msch {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&dmc {
>>> +       bootph-all;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pmugrf {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&cru {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&grf {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&uart2 {
>>> +       bootph-all;
>>> +       clock-frequency = <24000000>;
>>> +};
>>> +
>>> +&pwm1 {
>>> +       bootph-all;
>>> +};
>>> +
>>> +&vop {
>>> +       bootph-all;
>>> +};
>>> diff --git a/arch/arm/dts/rk3368-ymd8-mb.dts b/arch/arm/dts/rk3368-ymd8-mb.dts
>>> new file mode 100644
>>> index 0000000000..661390b9d5
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3368-ymd8-mb.dts
>>
>> Are you planning to support this board in upstream Linux as well? I'm
>> sure Heiko would welcome it. If so, maybe think about selecting
>> OF_UPSTREAM for your board once the device tree is merged upstream and
>> appears in dts/upstream directory in U-Boot? It may not be easy to do as
>> no RK3368-based board has been migrated to use OF_UPSTREAM yet.
>>
>> We typically do not allow (in Rockchip) to support new boards without
>> OF_UPSTREAM, but considering how old and how little activity we see for
>> RK3368 maybe Kever will let this pass?
>>
> 
> Yes, I'm planning to suport this board in upstream Linux. but it may take some
> time.

That's great to hear. Have fun!

> 
> Maybe I can separate this patch serial to 2 set, one for driver fix, another for
> board support., the board support patchset submit after upstream Linux merged?
> 

That seems like a good idea to me! You may need to send device tree 
fixes for rk3368.dtsi in U-Boot so that we can see the "user" of the 
drivers you are writing/fixing but we don't necessarily need an actual 
end product using it if I remember correctly.

If you send the patch series for adding support to your board before the 
patch series for the driver fixes is merged, please specify the former 
depends on the latter by providing the link to the latter in the mailing 
list archive (e.g. from lore.kernel.org/u-boot) in the cover-letter of 
the former.

>>> @@ -0,0 +1,326 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2025 Weihao Li
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "rk3368.dtsi"
>>> +#include <dt-bindings/input/input.h>
>>> +
>>> +/ {
>>> +       model = "YMD8_MB";
>>> +       compatible = "rockchip,YMD8_MB", "rockchip,rk3368";
>>
>> The first compatible isn't right if Rockchip isn't the actual
>> manufacturer/seller of the whole product. I couldn't see anything on the
>> PCB picture you posted on your wiki but maybe there's some information
>> on the casing or elsewhere?
> 
> I do not find any manufacturer info for now, I will try to search later.
> 
>>
>> [...]
>>
>>> diff --git a/arch/arm/dts/rk3368.dtsi b/arch/arm/dts/rk3368.dtsi
>>> index 4c64fbefb4..77ff551681 100644
>>> --- a/arch/arm/dts/rk3368.dtsi
>>> +++ b/arch/arm/dts/rk3368.dtsi
>>
>> Nope, this we won't allow.
>>
>> If you add support for a board, don't modify the device tree of the SoC
>> in the same patch. Please separate those changes from the patch adding
>> supoprt for the board.
>>
>> Here, because the rk3368.dtsi already exists, you'll need a patch per
>> logical thing you are adding. There are a few I could notice here:
>> - hdmi
>> - lvds
>> - rgb
>> - edp
>> - dsi
>> - vop
>>
>> First, only add what you tested. I believe this would be DSI+VOP only?
>>
> 
> It's reasonable, I'll fix that.
> 
>> Second, where did you get all the info? I don't see anything in upstream
>> Linux's rk3368.dtsi so it must come from somewhere else? Where? Please
>> specify this in the commit logs. it would be very nice to have this sent
>> and reviewed by the Linux kernel community as well.
>>
> 
> I cross-referenced the downstream U-Boot and Linux repositories of
> Rockchip and made some reasonable inferences based on drivers for the
> same series of SoCs.
> 
> I will add this information to commit log at next submit.
> 

Thanks. Ideally once the nodes are added in the kernel device tree, 
U-Boot device tree nodes should be sync'ed to match if they differ and 
do the appropriate changes in drivers. This would make it easier to do 
the migration to OF_UPSTREAM for example.

Cheers,
Quentin
