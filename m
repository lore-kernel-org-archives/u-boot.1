Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91A9D44C5C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B86A80325;
	Thu, 15 Jan 2026 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PDg9/NEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7005980325; Thu, 15 Jan 2026 15:51:12 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7ED80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDPF5J/cagTyvc5vvod0T4UydyDK5Or01HaCD/tjRl2y7B7gnPBMjC5jE0/uiMLc/1E9qh3Cem8d32RR2q4tkq8AKSj8Lzrt6u8fpN9izP+ozYsO0dh/SaBia9P1ccX0/ekd1tGo9Zfh3u8QzVswknC/ncBPFPI4+tvtP3c3LCdx+jl4TbrTpacBzeRPj6J9Qu/MkYBNxJLjFPhQpUkoiQ4eXxwjVyQAZ/fyjfZXOO98ijqidB7ZZ/cKSI1izXHpUqTtO/FX092HnVhiqiZXrnRRRXi0Uoxd9Gto4t3MVNSS8/G29yuGeHVVgd6mC/65AIpmf/S4hIgtmGPhk4Rrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6CumCptARRyRyP+J7y/xG77uEuLda8kS2t5c4nfDDw=;
 b=t3t6Z9SXqXzfZIsrOMtXgdlh1ihD4dDIwYqCRjxzZvtOkCIcYiA9XRnQB5cUscKkDysP+aq4DwY8xeldFS+M9yuUbY7NncZGdKpj51/86paIJT9mW3Wf+f5egOJgzA+eYDa5AGvwPPs2JlpabqDI7HQUPbtiVAyVSIjtqNRcOMu08BvgVyliNxbTN5JtWxCqJ3Fke9mEGyD/v1vWpoWZxjU3y1bepqJh0umKuZ2ouApwqYYmc5bGbO859QVWhlk2xTjcNwIvt3t8q25kB+Eog1V4iqKgtc6omcJkxxsjLHJxRyIp3xkMOJLGt3EgDpodKObAOB3NyVrmebhpvZHy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6CumCptARRyRyP+J7y/xG77uEuLda8kS2t5c4nfDDw=;
 b=PDg9/NEB0wQ87rI5KYMZ0WHKPKkg78GgWJhT5rW1EgiMmH/LTJ9an85O4TEZqHCtIxbngytaj2n97N79lVOSXzSUfHyI3+pPSBK5QQx8Z94Wphypz9ZuWm7QnFojXonDQFXDFXve9Ukynq2yDEsJbiJjN5OvwNPIHwyknFOOml4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10624.eurprd04.prod.outlook.com (2603:10a6:10:592::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:51:06 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:51:06 +0000
Message-ID: <8392ee33-8b40-437f-b7e5-74e4cf7fb31b@cherry.de>
Date: Thu, 15 Jan 2026 15:50:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: rk3588s-rock-5c: Add support for ROCK 5C
 Lite variant
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-4-jonas@kwiboo.se>
 <e286ab86-2253-400a-9717-acc87b7523df@cherry.de>
 <23d37542-3a80-4b4e-8720-3e62aa5f0a02@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <23d37542-3a80-4b4e-8720-3e62aa5f0a02@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: 50df3765-68f5-498c-71bf-08de54458364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDBZSXUwMWpyQ2dseGJTR0c2cGZhRy9DeHJjY1RsYUpwTDNLcFpWNjVUa3V5?=
 =?utf-8?B?dWlNT1RvcXl6aWF4ZmpDaHFLelhiNHp3eU9kVTJTcFZUcDlWVHNQbm5JV1pQ?=
 =?utf-8?B?M3dGSHZyVW04TFIydHFSMTZad3VlREZoTG5QaHlYYUNPZzh1OVVHVXVqVGZF?=
 =?utf-8?B?SWhxOVR1d1ZhMXA4QVZGcFh3Q3NIVlFpSW9wS0M0SE9vRkx3endxNXM5c2Y0?=
 =?utf-8?B?N21jUFpuQWgzM3hLM1RwMGtrUVRmL2pmTmYzM1VRcUdGSHdCZVRhVjIvWmM1?=
 =?utf-8?B?dkp4RHJqMFpUMXJ0dWRvMGdiankyMEJ1LzgwQXJNRE12TFo0RjR3NThuVTYy?=
 =?utf-8?B?dGRZRWRheVNYb0o5dHJyZWVDU09QeXhxcEk2KzZqdU51RXhtYXExamcrK0U2?=
 =?utf-8?B?cUVjNlJqTXBYcGlKOXY5bGU2ditEQXhNTmdqOXpvME50Zk9sMWdrSkV5SkJI?=
 =?utf-8?B?SGd6TkxxM1VRcnFvWkRUQThCMk5CR0lZU3JVWTdWazl2cWxMMktNdTg0WlY1?=
 =?utf-8?B?dUlvK3FySkZkbmJFL0FJSWk0RlR3NFN4NE5pT24zWGFKQjRCNEdWbEd1WDFI?=
 =?utf-8?B?dnhUKzhIUnJvOG8zanpFeXpTRU5reFlWbU93VWp6UzZPV0tDWnFYRFhkd2Fq?=
 =?utf-8?B?cGUraHd4ZWJOdWpHeGpmclNCTEx4REhEcGlCZEF2bzRGR3VZQUZIM05WRC9Q?=
 =?utf-8?B?dnI1bXFuTE1tem9NVEJQOExBMWJCbjdXRDBOdWt1Y01LUVlFalp0T3QraHRt?=
 =?utf-8?B?c2l5RzUvY21zRDczVnVUTGhla05PMFdxdmtQTXptWHBOUTB0a3lvdG5wR25T?=
 =?utf-8?B?TDd1K2hJL1ltUENwSnVKcGhWNkhiMVdsWi90QXlFS3dhR1luSnZwem4wVktS?=
 =?utf-8?B?eEhtdW5MS1Rib1VSeG5kSUdnQUJaT3pDdmdiMlQ3cnZqQk1heEVyaTJGV2Ra?=
 =?utf-8?B?M3RrMzVNeDVwbG9oc0JjeTZ2dEdvcHY2YlRwL21vNVdzNEZGK2F5MG05K2g4?=
 =?utf-8?B?Ymp5T1JqUHo4akNZODNIUFREM280WWdIVjI5anZNcDIrTi8wQkwvTFd1RjNn?=
 =?utf-8?B?MUd0TUtvQTZENTNYQ0ZsWlNLT09wTUZ6T3JZdVhINW02UTNQY1VOVVdzNEtY?=
 =?utf-8?B?YXM0NVpjQnRkMVBYRVJKSi90QjBEN0NyUWFqdzJ1dTZMcEttQzhCRVdOTnlu?=
 =?utf-8?B?VHRTbWw1b1ZxKzRUaThtQXYzNEdBSHF0NnBFRnFveTlzQmt5OVZjTElBN1NB?=
 =?utf-8?B?Q0dqZ2RqOVFtZVhrQi9BTTBSQmx5cFljODh0bFYrNy9raktmcWZWNFJiNkFK?=
 =?utf-8?B?Mk9Ic1JEeldSZVRyV3RIb3VkNkZkOUxzNDJNVmdRdnpFdEVndnZlRXJzeTYy?=
 =?utf-8?B?SFVENGZyTW1KeWFvTzhzNWIzZ2phSU9YQU5aK2IrWFg1VTBaajhPRzlZbWRE?=
 =?utf-8?B?eVNabzZQYWFxYnJZc2tKbXNBMW9QaG9JQjhUVkZMQ0Z5QjFmL29zSXhrU3VZ?=
 =?utf-8?B?YmFHZ0loQ2NBaGYweTltTzJjQzhQSzFFS0F0OSsvdTJ6VnNPVVBOU0ZEVmVU?=
 =?utf-8?B?bGc4b2J1c1ZTNWlsenhReXJBbnQ0d0V5eVN4LzZ2bWJJY2d6Wkw4M3k5Vng3?=
 =?utf-8?B?SkQ0VFBZMFFMYjcwMEVTcHR3QkdhZ1F6RUtIeVI3RkdmNjMva0U2S3JtR0ts?=
 =?utf-8?B?OXBNaEZlRjNsOEtnREx2UGpiWGpNV0RjU0xBNTRCakIwWHFXRG1QMmlwMzVC?=
 =?utf-8?B?QXVoZ0hRZGpCNUVzRVAxd2VEYVFneUNIN2JvT0FhY0xKbFVQQzl3L3ZiaWo4?=
 =?utf-8?B?RnpIN1hqWXRxbEYvWGNkSzNVYkIxWmZTaldkQnhMT1J4ckdSUTh1dnFTaVlh?=
 =?utf-8?B?L1ZCeHhNdzB6bFRISSt3UDFPU0l3ZnN1NFRwcHZkZHUvN3FYYjBsOGNCNk1r?=
 =?utf-8?B?bnBCRjRNRkh1TWRvR0NxSVdzY2l5RlpVYmRiWmlFc2UvTHlaUWtaTHZvNlg3?=
 =?utf-8?B?Qjg1MzRlL1VUT3MvQlVYVzJlMVJ5VlJNaFlPME1zdllKcFI5TlhNNTN5dWhn?=
 =?utf-8?B?anVGNHMxYkxjM0lyQi9zQjdYYmJFb0dNSWhuV1VCeWxNOGl5bCtLYUJCYVZC?=
 =?utf-8?Q?VXv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZLcFBHM0VaU0cycHdtTWxJOXJRYS9yVFpPYVFqNWx5VVluL2lNbFVTSkcy?=
 =?utf-8?B?MEJyeFZqY1hjNTRHek5TMkVDbVFWemk2ZVFTNC8zYUs2VHg2N2VJRnRyMHNY?=
 =?utf-8?B?c1VxQ0pORWJta295R05tTmsyZ1d5Rm5hNDVNb1dObFpSSUs3dFdXdnVmTFZN?=
 =?utf-8?B?QWx6MzZPWm9jM2NVZCtNYTZoanZTNzh4SGF3emdrbWJZMG4zdEo4YWpZazFo?=
 =?utf-8?B?VTFjNnl4aFVRVUdoZHZVaDdjWmJTOFJQVnhNam9vZzhFa2J3Zk5XbUI3V25t?=
 =?utf-8?B?S1IzTTAxVjYrUURPMDNaY0NaWEpHanVacnZRQ0dMTysrcTdHRTF3RUJzSWdI?=
 =?utf-8?B?clFITDJFV1J0M0xKV3RSck0vamt4eWtKaGJtVWZmdmlTVGRJNnp0d2VXZmdt?=
 =?utf-8?B?N2p0U3FrL3MvOVppM3VKUXNyTUFrRkcyMmRSMTFYMngxZzh1T0t6UVk3MWpt?=
 =?utf-8?B?MGUvcFd3Q2NWNnFFY3BIbURtcXJyN1drdnRXcjBPWXZQK1pQa3dBbFV6WE1M?=
 =?utf-8?B?b01RMzQvdWZWMVBHd0NCMUdzb3kzSXpTZW11bGE0ayt4aVplMTJuaVlKV05Y?=
 =?utf-8?B?bWIwQWxkS3hvbDNnU25Nd2l3ZWpSdCt6VlpzT3RXWlY1YzRIRFpNTkxvV2JI?=
 =?utf-8?B?THcvWUQ2eE1xVThoQXI2M2RXMTRvRFk5My9Oc0lzYkZjUHhkRzU5aEk5Nzkz?=
 =?utf-8?B?MVR1a1ZoSWF5Vlk5dW8rRkJjLzMvQVZyQXA3bGJveFQ1U0k3RW9xdzliNTcr?=
 =?utf-8?B?dFgwdFNyZXB6eHZ4YkJzRExkb1ZEMW5GZnNGcGNueXBiTERDRFhZWUEvZkhI?=
 =?utf-8?B?cXRqK1JNV3VvSUdGbjVJV3ZqVFBET1A0YUFFbjE5OVc4WU8vL004Qlo4WHQ3?=
 =?utf-8?B?ZXVTam5WZ0RreSt1SWpLQnlSeEdMclN5RlVvV2k5M1ZGYWQ5QlN0d3ZyMXdv?=
 =?utf-8?B?b3NlT2RHcmxBWmFXRWxFWFQzZFVMUldxbWFZRisyckhJWW90SVBpUVpXMTgx?=
 =?utf-8?B?UGpYblJVUHVwRldIbGJaSWZ5TWxlUStkb2xpWUI5V0ZhcjAvVmZMWkNOalFN?=
 =?utf-8?B?Z0s1MUZ5eTVSY09SRzdKVFpZMTJZWFpROE8xcE5obEZJNld0eENkdGJIeWQy?=
 =?utf-8?B?UnkrUzV3WGp4aHE0bG92RjBRcjhoVHhOVm1JSmtrOFpzVVh4VU1ETDZVWkwr?=
 =?utf-8?B?eDc5N3NONzkrWGhZQkhtV28xakd5cVMvN0J5ZmEzOFNna3JDbG1iNy80NkZW?=
 =?utf-8?B?NWVTSFVTd1FXZWNSYUpMUndhcVZqUVU4V2FrZUY5TXdZME5BR3hqN2tiYUlK?=
 =?utf-8?B?aGpFQW9RaGk3em5RRFRHeUdjN25tdUM2ZHR6cW9rTkhUV0VJZzU1azFabnFk?=
 =?utf-8?B?akd0aS9zWENadnpyUSt3MTdWS3NSV3cyVzM5dXNtUnA5OHZlbUM4ditka1Y3?=
 =?utf-8?B?QklBTTFiOTNraFU2K1NFcDZzcFZFM1R5VE0vQmw2Y2NBU0FpVkZLWkhvYkhM?=
 =?utf-8?B?ZGFjSWhWVGxKSWJxOFpBWmVJckkvQ3lKaytmVkZoRnloT3dOVWE0alhkcmI4?=
 =?utf-8?B?bU9RV05WWTZzZWY1VzZ5WUI1NDJzZm41aVcyd3R4UTNkSzNxa1RLRUNZREk5?=
 =?utf-8?B?Vk10U005QjVXVnYzZ0U1UkJYZ0dyUno1Vm8vcVFwT0JCV2RzQlk0NWhPclB6?=
 =?utf-8?B?b2wvOTRvaURQSjBNWFVDV2xrb0piY1NjRTBmUkJZVkxLblI4ajNXQlVkM1lR?=
 =?utf-8?B?Y2IzRk9vOUpJRSsxck5CM1M5TXlxR1BYVXc5L2NJeFJlaXVUL1FPS1ZpVmtW?=
 =?utf-8?B?Tk51NThObVJ4YU5KVkMzOWx3V3ZxVnE4L0t1Vk81YmRTa2NhQXlEYis1dVd6?=
 =?utf-8?B?dGhtZ2V1L1N5VUFEaHFzaTYvVTVaTWt0WDJ2ZWN6UytzSElheU5RWXlBZ0Vo?=
 =?utf-8?B?YmZ6MW5pSUMwQ052NG93NTZ6OXh3QXNLTUtrNGw0cGg1REQ0ZThRSjl6N2pt?=
 =?utf-8?B?WTRTQTNGZEVTdzg0ZmhqUzZRaDhvRWdCYUZnWC9kdkJCWW12dzNHaG1sYUJ5?=
 =?utf-8?B?SGFKR1JkRm1vckZqQXplMVNkeXBkaEM1MUlmNmU1UzJhUFl2SzhDT2RUL3Nm?=
 =?utf-8?B?YkxidjN1NkpRL0FmUTRudmRIbFpuM1ZmbXVqQjBTYko4UFpZV3lCbHNkV09z?=
 =?utf-8?B?cDVLME9FS25mb0Z5UFZzSGp2NVJZMnMxTUpWS1lOSXV6SEUva0N4Ui8zcjRq?=
 =?utf-8?B?aEtLZG96ZHl3YmhjNTBOaC9aOTlpYjJjcHBtWG5ZMmdpRy8wWHNMazZOajZU?=
 =?utf-8?B?RjJKQ3hwcjVFcmovUTNTV1VXVytkbUFJRFZHOUlsSXB0SUFuUHQ0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 50df3765-68f5-498c-71bf-08de54458364
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:51:06.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC/p+WlGWxYwyE/Dil95s/4iuV1t8wc8xtOYpEIEN2NTNQVf6Fo5h714Cj4fmIvh45WevDxgTjVlt2UNr2msq7JKTcjrOxdASnmoscU+7sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10624
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



On 1/15/26 2:44 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/15/2026 12:26 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/8/26 12:07 AM, Jonas Karlman wrote:

[...]

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
