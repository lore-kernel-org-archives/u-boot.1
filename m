Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D88D2E9E5
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00D588C4C;
	Mon, 11 Nov 2024 13:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Jd6wpor1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080278911D; Mon, 11 Nov 2024 13:55:19 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D397588815
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piaPqZaHDrhvmG4nvmhnaat8a/RZ7iaotgP5d6Z+9c8CMLTudhVGqPa3wwooR18vxqQ0abPSwleV/vVuZz3v2pfl8VG8RWAbnPKE6TuF/QqS7Mj0YUzo0kA2R2ppNZoWd5qsDu4X7i2o1bCS0ueq4z4V/Q97QSc+hTLvzZtgpB1NImu8ADkXzKQNGvY5ICrALA3qaXitl0gTKznbeB/4bVK++8K/457w9ex6JjCkEfi6MNRnnXz2EtWF36iOndOPW4cFqWFi3ocyme07/SZMzvraDM6YO5xRhoKcQq2IDXbPJYmDzSh+BmqArG9qdDTHwf7rElT3DQ+sUCqU+aTI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZrb9qV23B1lQiL9GGmD+yiQb8609ZYje0NbV1f8LGg=;
 b=PYFfu8OLGkiRit8D8MNWXhT/r8ZBjHzMBzuGtqsh5QrKT64/UT+Qqa+lSj/hlrX/AOG0T0bJUQPbj7lYRQlkPrHU/Dh0FbAVIKKa6isId+eg6xpX/KK9PSyMKbsEVpGjIOIzz7c2ERO9U+Iru0HR7IynuxueGgp2WpbpS6VXSLz2lNZBTPF/yhu+f9ahKNbNPcXZ67XKNUqUNk2TBkaYO6ckPQ+kfuD8jiA+UF4B6t8RTEIANTowFMxA/ifTxjcRVM9suO5bM+uuBu0wEbdqnO14Q+YlJhIWIutsx41PqYeWIJfk1ebKZsaChl/HjBh+m01jTlKEZnECN6doaecpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZrb9qV23B1lQiL9GGmD+yiQb8609ZYje0NbV1f8LGg=;
 b=Jd6wpor1QpItHZdX4DuszGN1T1vu6YjzQHO4vc1T0ZZ8dkhhj++dIXZ6YQ465VEqiwhWK1XQHxCooa7Ye7qmldjH4aDw9INrwW+EIWiHRBB4a0EjuCbtrQBaUSOcYOcVmH1qaXll4hRvgoQEgSDMzrj385kcq4PtrujFqS4XVvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 12:55:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 12:55:13 +0000
Message-ID: <913dcd1a-4157-420a-b0f0-89d6f99bd5ae@cherry.de>
Date: Mon, 11 Nov 2024 13:55:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] sandbox: Report host default-filename in native
 mode
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20241107213150.1711962-1-sjg@chromium.org>
 <20241107213150.1711962-7-sjg@chromium.org>
 <d2d6f345-cdd0-4b1c-b91e-60910409eb44@cherry.de>
 <CAFLszTgxEGw-_uAJReLPWDAcKzKzSmCKRqJMWKcb=zC3inZkmg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgxEGw-_uAJReLPWDAcKzKzSmCKRqJMWKcb=zC3inZkmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c195d69-3a62-4d08-fe96-08dd025014ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzR0ZXBBdTVteG5RVkFDTk1hS1dibk5ld1BSNFdvTTBkOFN6cHJMTEhaQ0RZ?=
 =?utf-8?B?RnhpenJHK2I2SkVMOHJ5blQvK24zaTB3WGZPbGFaNXJyTmswTGxKK1ozYXJU?=
 =?utf-8?B?dkFNZHYxQTVPNEpPdzMwdjA5VGVnODZhZ0pNQUhCS2JkdklVMDhxYUwwcUdl?=
 =?utf-8?B?UnZTdGduOXEwREtPcnYyU215SFhhdGxZK3lOVnE5Z3FpTGlXT0Jpa0NmRis4?=
 =?utf-8?B?Mm9pV2Q1cWF1R283NmV2eEs0dXRSVmkxbG55clJpSGlISGJOa3o2aStpeVFU?=
 =?utf-8?B?Z2NGQTZGVWh5ZElDcEVLYVhxTmxQTTFNdU91dm93aUN5VXFlYXZ6cGNTdFlW?=
 =?utf-8?B?Z3VaMUIrL29uUFZ2YlBkWCt6K2Rzd2NvWTZzeDR6NEZGWFhpay9TREN0N2RI?=
 =?utf-8?B?cmlBQ3J1THVXM3BKVW1QNjFwNTdYTW9ldG9yUnJ3NzkrOU41ZzRPbG15cjVH?=
 =?utf-8?B?dk15S0hIL2RUSFVvQk9rNnpub2ZJbThYV0JyY3JxZFZCSkp6cDNlKy9tUlNN?=
 =?utf-8?B?V3lha2Q0SCtqNFd4bi96R3JGdXNUeHlwWlVFNmw2UHMvczh3ZFgwb2dTOHZN?=
 =?utf-8?B?SStKSHBrV2hGeEl5YmNRejJ6RnZ5S2RvMHZDZjZXS0VWNDVleUtWbVJHODA0?=
 =?utf-8?B?VGlTbGZ0QWZKQi9aNlh6WlRYTTRRcDA2Y3pWOHdldmQ4Y0cxbFlmeWVoeHhT?=
 =?utf-8?B?Z3I2L2ZFcWNsM2VkOHoxTG9UOTBrSUZnWW42UEdRc2RLaWZQUXhzYlZMWldk?=
 =?utf-8?B?VXp6MjYrSzNSc2xSZllpNjgzcWtEdHlnb2JPRkZSSFFncy9ESHhPZjZqeTVs?=
 =?utf-8?B?L2kzSXo2cUM3V05lRkhYdjEwSTRvWXBLcFFFTVVmRzJDc1dPeWFtMlNLY2tB?=
 =?utf-8?B?b0x5MWxaUUxaRTNXT0xncGVxSXkzZHk1dWlTL2xpK0MwNFcwWmxXYk9OaXRB?=
 =?utf-8?B?dWo4WDNUZ2Y0SHBYbGhFeFZIUjNwbU9IYnJDMHhFQjNiU01HSWdwTnRKWEtE?=
 =?utf-8?B?NjJaM3lDczJoaTMySFM5KzZvZ2VLOWRmQXRuTXAzRTVoakJJcmVwR09GWlly?=
 =?utf-8?B?bUg0RkpHeEVHS2EvelF1aFdHUFJWam1TZ0lOUUVOczhSQVhZOVE0d09tL0la?=
 =?utf-8?B?UlNpOHoxUXZpV3QrU1NqMzlpY1BsZ05qcmJBV1dmYmVzS3QyZXdOakUzL0Ur?=
 =?utf-8?B?enNyazQya2IzS01ScCtwaFhZeVdUbi9sbmVKV095SDFudndibVRnUEYwT293?=
 =?utf-8?B?bjdsMG5HeFVSTmk0WUJrbDQ4NGt2VmZLYzQxTHhrclY1UlFSaVkrbmI5ZWVa?=
 =?utf-8?B?a0Z6OHhmQ3BWZEplNExCOU1iYjh3aVRKWFlsMnRzSFFUZEpjWnRDalVyaEc4?=
 =?utf-8?B?MTRPT01IaDNIZ29iMWlrbmRKam11SXQycyttemdYNWh5UHNyM3ZpWDV6R2pq?=
 =?utf-8?B?YzJHK0xBaXhiR1N6a0tsUkxPNTBXNlcxL3dQWHU2ZWYyeWFpRllmTWk2RHJI?=
 =?utf-8?B?dHBoVDBVK1J5bUI2Q0FnRmFJOTBGUHp5cmUyK3BTZUh6M3RUd0s4SDFwc2Ft?=
 =?utf-8?B?SEdTeXRIeDhOenlBS0RxcURaSjJOL3k2SVQ5UWUxWVpJWHN6UmNVanVUcUMv?=
 =?utf-8?B?cy9rcVZYM2xOaEFnWDJZSkwxSE1yODY3ZFJCSDNZUzdWTG02U3lBZVFkcTZU?=
 =?utf-8?B?NzNoelMwaUp3TU40TlI3V1RWZm84Qi9IYkdNczBzYlZRS3BmU2ZHamhPeTM2?=
 =?utf-8?Q?DPX3x62NlX/kzfCbI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y05tRFgzVUFITXJhbis3R1Vhc1RIRXh5RXliS1FGNlNlS0RuN2FUemFVWTZ4?=
 =?utf-8?B?UVVUaG93SXY1clp6aEo5YnRYQU85dUpvUDV6eXAzdk1LSldIREZhYVpkbEtx?=
 =?utf-8?B?Wm43UHZMME82b28xbWZLSnRKM1k5WGFySmplRkhoUDdiQ1NDYUJQbkdhRW9r?=
 =?utf-8?B?RG5iWW9mS1JOcHlNSlJBa0JPTXQ0Ykk3SGY4b0UyWUp0aFJnL1BxN0pYUHFF?=
 =?utf-8?B?bEd1MkNkWEVLYk9oaVgrQXlhNnRCK1BhTk1ZdE9LSkFSRytzeHF6SHRnWEVy?=
 =?utf-8?B?dEtPZjRVTjFxV2E4UTB5V2o5Unc1VTQ5elUvUmdqWk1JTHI5YVZQNm4rY0Zv?=
 =?utf-8?B?dUlBTU9jWGRYN1ZtbHZyNW4yNVhEek9jVzh6M3pRT08xNGdXcUVWSG9zTTAx?=
 =?utf-8?B?ZXRnN1ZHM0x5VlcybDV5eG9wTi9mcDgwRnBWaVdNWDZLR3ZEQ2ZZNkhxODh3?=
 =?utf-8?B?NEwxNEVNSENpMjJUeW9QVjhIMlBCV2NZTldjSENDemRKN0htY0VNSkU1a2tI?=
 =?utf-8?B?RktDQ0crTExuUjNxYUxrRTkyVldJS0Q5dXJEbHl2cytUU0Y2SGdnMzJJZ1Yy?=
 =?utf-8?B?VVVwU1VFWlR0eVE4OWpCb3MrazVScjlvNExPRFBlUjhxTXVRS25jalpYZGYy?=
 =?utf-8?B?anljU25ZZnNJOGU1ZEp3MzN0UlVwWXBiQUFlb3FKUnduQnA0MEhJNkYzQVYr?=
 =?utf-8?B?cjZ1U1Rnd1JjLzl2L3ZXTlJSVk1HbnhhUDA5andTNWgvcVl6cTRJMVFRTWtt?=
 =?utf-8?B?UWRjMFpjRkZvZ3pDeWh3bFhqcTdSc1JnMHZyL0wzcHRDT1podENLMTY1Y2Fv?=
 =?utf-8?B?Umx6cTBtbmowaHZnOTJjckRuK3VXYzVjYXpvRmxWRXpjeHVVUnVlZXZDLzNr?=
 =?utf-8?B?YnJGdVNDK3ZCZENOZDZmYVE2WkI0ME5SbnJoVGFJWnZLQkY4ZDRnR1o0TjlE?=
 =?utf-8?B?MGtnZmtNbjQ3U1U0bXlTc3N6VUd4OXRJaTdLZFZucU8wcmVoUWhaMEFkeVVu?=
 =?utf-8?B?Q2VtRUlwdVZNc2FDeCtXakErQ3BSN1JnMW1RczhNVjI4Tzc0VEtrT09zckQv?=
 =?utf-8?B?NVZTTnRjemxITWg0MU8ranMyaGFrZzhCTHVrOENoaGhGMUlzaE9rYmE0bS84?=
 =?utf-8?B?RVNLREFuOXZrck04bXpMWVUyeFB2dkVTdFlYWEtPT3U2WGhtKzdGTFUwMTFv?=
 =?utf-8?B?UUFyQzdZWjVzZkRjU3c3N2RQell0MUhDUEhlbVppMzBtN2taak9ELzlaN3Zs?=
 =?utf-8?B?RDhBd0Qra3g5aFlvWS8yTlU2RGMvaExTZEtqdFJuQ3k4YjArck1PYlhwMnlO?=
 =?utf-8?B?SXIxSFlMNEQ4UUZxaFpKWFNwbnJvMndRUGVFQXNoVXFjZkFwMkYyTUhRNjRJ?=
 =?utf-8?B?aEUrTlNQMDVIaDduY1ZzVC9OenlrRzI1Z2s5NmNjeitFUy8rRFlnaVI5Tlkx?=
 =?utf-8?B?ek5SVXVGeEsycitPTEY1ZXBxWnR6aWliQ2l2Ym5pa2lLNHowM0ticVRjNngx?=
 =?utf-8?B?UFExVTVvMGt0WmZZTmo3cm0yeVdLaVVlWFdhT0RDTEJvZWw1MUNXOUlFc2x2?=
 =?utf-8?B?cVBOR1NDVk9zblFXcTlNOUVqRnhWU2lXYkF2UGtNc0N5QVZGajFiWnVBQjVQ?=
 =?utf-8?B?bHhEYXZwRjkxZWlZQkpibUowZ09aeEt3TmJLNWlUaTJKbnYrR3VMTnF4eHhK?=
 =?utf-8?B?VlROb2hCOXVGUzh5WVVzaTlTbUFaV09ybk5Fc2JJYStBQjA3ZUZ2M29VdDRw?=
 =?utf-8?B?MHZWZEpsU1NRT0FBWm5uMnNPS0JTcllVVjdXcTFCek1UVnRNTE93S0JGYWNx?=
 =?utf-8?B?QXcrRjJmVTdwZUpqbmZnbGtTMlZvNkIvZGJzdjNvL2U3QnZNNS9VWTREQ3E3?=
 =?utf-8?B?M1lJdy9UQWI4SU5pdzlURDNpZGZyL0UrVExIU0x0UzBMeTVJcmk0bk0zRDVK?=
 =?utf-8?B?NDBXbGdGK0JEOHI3STlUMGtERUkvRFdTeFErMnpmL0lQT0tOZFM0aHFhSFZF?=
 =?utf-8?B?MWVxTkd6blRmaDdVQWZGT3VkWDdHQUpJaENheDRHc0FuV1ZWME9tNlZtR01G?=
 =?utf-8?B?MVY2UjZCdEM4eXEvaW5VWWN3QkxzeDE4QmdzRVR1NmRUaGhocWpZU09MTnpx?=
 =?utf-8?B?aEFlNUFxaCtVemhKNXZOd2NpRnk3ZHJPYXE5NnNRRDZvWVVhc0NkSWoweEZ0?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c195d69-3a62-4d08-fe96-08dd025014ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:55:13.0803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQKM11aFVhSAkd7/2dQr0CCTkOksMvhZ8DTmIcYsZXP/NHFiD5m3Lm9Uhk13dl/W/mFiuINTdw+RLXsm484Jg9pzg8V+v5GE7Qyhly8Et3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378
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

On 11/11/24 1:41 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 11 Nov 2024 at 03:03, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 11/7/24 10:31 PM, Simon Glass wrote:
>>> When the --native flag is given, pretend to be running the host
>>> architecture rather than sandbox.
>>>
>>> Allow the same control for PXE too.
>>>
>>
>> Commit 7506c1566998 ("sandbox: Report host default-filename in native
>> mode") breaks building jaguar-rk3588_defconfig, I believe it's this patch?
>>
>> Reverting it makes the build pass again.
>>
>> HOST_ARCH is empty in include/generated/version_autogenerated.h for some
>> reason. Though it was also empty before.
>>
>> The error is:
>>
>> """
>> lib/efi_loader/efi_helper.c:26:15: error: operator '==' has no left operand
>>      26 | #if HOST_ARCH == HOST_ARCH_X86_64
>>         |               ^~
>> lib/efi_loader/efi_helper.c:29:17: error: operator '==' has no left operand
>>      29 | #elif HOST_ARCH == HOST_ARCH_X86
>>         |                 ^~
>> lib/efi_loader/efi_helper.c:32:17: error: operator '==' has no left operand
>>      32 | #elif HOST_ARCH == HOST_ARCH_AARCH64
>>         |                 ^~
>> lib/efi_loader/efi_helper.c:35:17: error: operator '==' has no left operand
>>      35 | #elif HOST_ARCH == HOST_ARCH_ARM
>>         |                 ^~
>> lib/efi_loader/efi_helper.c:38:17: error: operator '==' has no left operand
>>      38 | #elif HOST_ARCH == HOST_ARCH_RISCV32
>>         |                 ^~
>> lib/efi_loader/efi_helper.c:41:17: error: operator '==' has no left operand
>>      41 | #elif HOST_ARCH == HOST_ARCH_RISCV64
>>         |                 ^~
>> lib/efi_loader/efi_helper.c:45:2: error: #error Unsupported Host
>> architecture
>>      45 | #error Unsupported Host architecture
>>         |  ^~~~~
>> lib/efi_loader/efi_helper.c: In function ‘efi_get_basename’:
>> lib/efi_loader/efi_helper.c:73:38: error: ‘HOST_BOOTEFI_NAME’ undeclared
>> (first use in this function); did you mean ‘BOOTEFI_NAME’?
>>      73 |         return efi_use_host_arch() ? HOST_BOOTEFI_NAME :
>> BOOTEFI_NAME;
>>         |                                      ^~~~~~~~~~~~~~~~~
>>         |                                      BOOTEFI_NAME
>> lib/efi_loader/efi_helper.c:73:38: note: each undeclared identifier is
>> reported only once for each function it appears in
>> lib/efi_loader/efi_helper.c: In function ‘efi_get_pxe_arch’:
>> lib/efi_loader/efi_helper.c:79:24: error: ‘HOST_PXE_ARCH’ undeclared
>> (first use in this function); did you mean ‘HOST_ARCH’?
>>      79 |                 return HOST_PXE_ARCH;
>>         |                        ^~~~~~~~~~~~~
>>         |                        HOST_ARCH
>> lib/efi_loader/efi_helper.c: In function ‘efi_get_basename’:
>> lib/efi_loader/efi_helper.c:74:1: warning: control reaches end of
>> non-void function [-Wreturn-type]
>>      74 | }
>>         | ^
>> make[2]: *** [scripts/Makefile.build:256: lib/efi_loader/efi_helper.o]
>> Error 1
>> make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
>> make: *** [Makefile:1914: lib] Error 2
>> make: *** Waiting for unfinished jobs....
>> """
>>
>> The build host for me is Fedora 41.
> 
> Which cross-toolchain are you using? That variable is set at the top
> of Makefile so it would be worth seeing what MK_ARCH is returning.
> 

Ahah! I had forgotten I use ccache so my CROSS_COMPILE is "ccache 
aarch64-linux-gnu-", without "ccache" in there it works.

I can suggest:
"""
diff --git a/Makefile b/Makefile
index 7275a02f24c..2aa115f2097 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
  ifeq ("", "$(CROSS_COMPILE)")
    MK_ARCH="${shell uname -m}"
  else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 
's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache 
\)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
  endif
  unexport HOST_ARCH
  ifeq ("x86_64", $(MK_ARCH))
"""

an opinion on this or do I just send this as a patch and it can be 
discussed on the ML?

This works for me both with and without ccache in CROSS_COMILE.

Cheers,
Quentin
