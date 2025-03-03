Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C3C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 10:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146E5811B3;
	Mon,  3 Mar 2025 11:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="LpS4tthV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01353811CE; Mon,  3 Mar 2025 11:26:22 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779DB810EA
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 11:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOWe/ajCQFKSlG0tpE7Ao7853EvV4VneAbfH3nPsOuPX6Ighp/8t/7a1xgJUBu8NI/ntmv6wnPQzELYHXU9XnV+HqxEsMw8A3OPntTIowR2Kjs3vgedxNQ2Qa1Q2mZaI0Hd8hyeRgDIRrP1p6TEDvgcrxq4lma8zLZmlZsOgAJdSfuh4c5DEEyhEr0hYBfsTlaQYLyOuaqX0DZGImX3wbzAf0gnfqSbjMBS94kk/fi+DatNnooCWClLMRof2IXQh/Od+29IBagLLNRQesiOXIw/3RU3ZbY/i38ZVNTLZdX8RjQeRa558hGknGZcA0a4dG8azjVwsxa5P6/iVkocAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VGBq6/K/xma/K0YeTrNrxiOic6599NqXfPEbW7bFYA=;
 b=oEvy1N0Kb3Eo8GJrAQ8Jl2s0IMUDOCde6Gi3eR9aGgHcIl0L1P1HHVVg28z/MMBpyZ6+rH4R1XN3I8VkTPVMQQuuSGdGU/Rhf9GlyhAlgWMzciciuuhdIsDJpQa7KbT1SDTKu6PdvCHu1cweFsBseK3A8NRZTmnkGKiq5QOCY18ji+Y+gv6soScC9Jjvd9re8V7UeqYYKy3XM1DZKZrfsIHArjE7JlvxQzy9jJFZvJFmfLcxuqvjFVxu7CJwGkRxMqM4T4wTDqcpWpBL4b2jV/h0ZdEqXIQopr7eCYInhXYf2rwSMbbkljSFWv9N/gcf4zE3yiLi1eT/w5YNuxwGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VGBq6/K/xma/K0YeTrNrxiOic6599NqXfPEbW7bFYA=;
 b=LpS4tthV0CppvLVn9GlsB7QCZlrxlssf8p7ASCJRS8f6rk5QyM8IRPf+LAoLTjABcXB7w4/eyTSSJ97dAH0Mp0MNY8dsmgXLp0f8IHbA8luJ3nqAQgScHbjs3KowelN+me/P8ugBMIFU0HYKn+pY3zrD6XgSaEN8VnhRmUZ6Sz32m5i0SzZPsUfKgbkKc9gfSDHHyDwTlFknW5Et7NYPRATkEwIjy6lh+7tThkLmbGP6B6ltMB1Eyg3LTzDQIkfNEiPuPS18yiqX7SHUguv/Bg9y4jb3XATnLp23HCvdjMwOIJO4zO67yfM514P2dBG2wYnVYffXOTyKUXRzJzUHYg==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 10:26:15 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 10:26:15 +0000
From: <Manikandan.M@microchip.com>
To: <sumit.garg@linaro.org>, <eugen.hristev@linaro.org>
CC: <lukma@denx.de>, <seanga2@gmail.com>, <kever.yang@rock-chips.com>,
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>,
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <Nicolas.Ferre@microchip.com>, <Mihai.Sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Topic: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Index: AQHbiPsjoBcXgMo1hUCbV6M9r8wp7bNa5k0AgAAO6ICAAD3FAIABR3iAgAATAQCAAASugIAABhMAgASjM4A=
Date: Mon, 3 Mar 2025 10:26:15 +0000
Message-ID: <afc3ff33-81b5-4728-9f00-1dac02dd8fad@microchip.com>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
 <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
 <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
 <d75a8b80-8029-4bf0-9c7c-7c72054bbdf3@linaro.org>
 <CAFA6WYOZCWSMu8MOAaBR1_M64vzopAFxew=2VhcvY=0PHDUz4w@mail.gmail.com>
In-Reply-To: <CAFA6WYOZCWSMu8MOAaBR1_M64vzopAFxew=2VhcvY=0PHDUz4w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: 230a5817-6507-41ed-82a8-08dd5a3dd447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c1E2R3RTZmVEYVZncDA2ZG5vSXQwaGdxTUQ0NVprWUdpN2dQNWpHd2lvQ2du?=
 =?utf-8?B?eG4yVFY0MjFWa0FvaFRic0ZGU09tdEUwN3IweUtHR1AxR1EvVFJ4Z1RxaG5J?=
 =?utf-8?B?TFpsQnZ2YWMydUc4VExTRWNaMGFZWGxTRGJOR3Z3Zzh2SWRabE4yeURoOEtG?=
 =?utf-8?B?UUpDREYvc1lzMlBadkJ4bmV2N25ndzBiZ0w5YzJCdTd1RFFRSG1CY0dwQXBQ?=
 =?utf-8?B?a2lnWjMxN1BublJZYnFCMlRXZTNDSEdrelA0ZWFGSk9PRmE3TFd2NXgxNFVv?=
 =?utf-8?B?Mm9YSWsyenVwb0xaWmtGQVVESmJZdHdtY2FiZGNYc2RTMkpqeFY4dWdxcit0?=
 =?utf-8?B?ZW90TG5scGEzbTlwZ1JEYlRFaFMrS1BETkltcE9LZWRKdURCZnR1QkdSa3dF?=
 =?utf-8?B?SEJuMVRtVTA5V0JSRSt2UVRIZzR4ZDBKTHpnemtLYVNGakxWK1BGWmh3QUhQ?=
 =?utf-8?B?RU4yenRYbVlUd0NPWWo1Z042aGZ1dm1oTjMvTkZxY3phdHN1MmdaVDRYNHdT?=
 =?utf-8?B?TVAyRDRhR0hPaFRaRncxeUswWC84R3g4SnRLYVVIVzRZTFNBOU5tOHkzNGtr?=
 =?utf-8?B?d1BGQTE0bjZJbzVJVEFpaU9Jc3M1clNtTDBqalhTYUNjUmFIQzRTUUo4S2U3?=
 =?utf-8?B?dm9jNGt4ZnFQOHhKVE1ZNzBrZmlVZ2pwQTFHRFVveUVFVFRXeEpXZG55YXlj?=
 =?utf-8?B?Ky9Ra0hOV0c3OEpCNFdFWnRYS2paV2RFUWg1Z0RxR2ZFREY0Y1Znd2Izd0hr?=
 =?utf-8?B?MDcyRy9mNmRzNzdnWlpTWHlkbktDdmlGOUdWdE03eDFPNHpzZUhpUTFtNzBT?=
 =?utf-8?B?VVlEbTU5MEg4OWR6eEdoN0xJREdmNzFBNzJwbHpYSXV3SmNKZnpBdUg4WTZx?=
 =?utf-8?B?UjM1dGRxdk9GQzg1Y1F5NExKQ0dSdURvTzVIQWpwSUo5ZE5UYTZ6WEpGQlF1?=
 =?utf-8?B?WGNuRkdtdWttWFZQQ0xYdmw3NmV1QUo1QW15MlVkeUt0TWxxWEdROW12TjFy?=
 =?utf-8?B?encrcVBUUENwWTg0dnkwUk1EbGhoWmtxUXA5NFJ5NUR0Vkx3WUthUVByYlpG?=
 =?utf-8?B?OHZyM1BjVWUvd1RLUFBmS09sL3NNZEV0Z3VpUDdyWExXZ2RzWHBlc1lnK05K?=
 =?utf-8?B?WWRWMUV3NytPRHVVRFdLbDA4SmNMdGhlR2FSV081ZVBVMFcwbkhOT3YrMjFO?=
 =?utf-8?B?eHptdEdMaXIzcStCK2pGYkZ3Tk00K29NN3hVclkvaU9JNHVRUjRJM3VZaldQ?=
 =?utf-8?B?aWhKQUpzbERRRVdaOElPdWdZVWZJMDZ0RmVibWdneGVZRkpDcG1ZZTB2S1Vo?=
 =?utf-8?B?UERyWFd6SUt5bmxTZEV2cm5CemsweHlHcTNCajJ4dWN3eXJvRCt2OXovSjdl?=
 =?utf-8?B?NHEzYm5JUEluclYyT28xc3dQMUtSYmF0cDdDSFl2MzRUZitrRmxSdGd1cFJZ?=
 =?utf-8?B?RW5xazQ4M1B6MmhRakJGSDdjeGVFd1hzbE1hcy8yU3d2N290MXhDYnQwejZC?=
 =?utf-8?B?SXl4Q2YzcXVjc2diT1ZUUk9zTzI0RmRCSnhzcWZGc2drb3Vnem5aVmZpSjRi?=
 =?utf-8?B?c1YyRndpbTZuV3F2UWtlWndPQll4VXBObXFkeG1paVBXdGlVekFGdDNLQmxS?=
 =?utf-8?B?NzBuS3czYitBeUV6TjdEMjdJZk03dGg1MWpxRU4zbjNzVHpDU2lLZ1ptNWpD?=
 =?utf-8?B?b0VRb2dOS3R3dU5JaFNLd0Ztb1dXZzZsV0NIZ2dueUdMNTAzVVJiV3JOZFl0?=
 =?utf-8?B?bXJYZFlYaXd0a2ZrNHVoUlpOR3hpQ2ZCRjFKNXF2R3U1UTZwVnVQbTV5WUJZ?=
 =?utf-8?B?M3BQdTF4MVBuRlhiRFdFYXZRVTdIWENmeTArSzE5aXpxTTNEblQxeExqMG9x?=
 =?utf-8?B?S3BVQm1NeVZEZWk0M3BDWVJrbmE2SUFXNGRXdG1SclNPK1NaVjRWenlZVWVB?=
 =?utf-8?Q?IewST9WA3Rtd9Q6e32pSM+VmwA4xAQz5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlJBSThWaE5TNjFyTEZKYW53WGUzMnlpanl6V0F2b2p4Vk1CZ2laaDI0clV1?=
 =?utf-8?B?YkErMlJhKy8ybUk4R3pqbjNnZGJqZDQySThaNG9NSGI3WjQrQXRGRTJycG9o?=
 =?utf-8?B?aUxLa0ZlUWF0dkFlZEFzZUZWUlNrSUh0dy9IZnFXT29kOWh6am1MTmZ2OTJZ?=
 =?utf-8?B?QmpqY3Y0VGZleTA5bVlzNDd5MmNJeE1vbFVBUzBkNlhvVnorcjhOYjdMeEFm?=
 =?utf-8?B?SDhzeXlHRGpxTThDVXhuRjJray9aRjB0c3lvSUZwLzlpZHUwcC9KQ1NSWGls?=
 =?utf-8?B?ZmVlRTJZaUQ3VkorekxlSkdNWlZnRHdHWlcydkFLNGRjWmY3U0dCTjRjUEVa?=
 =?utf-8?B?a3ovdno5K1lxZHllSjNSa3lDQW5Xbi9TWWt2S3F2SFF1M1FjclF4SlpOMy9V?=
 =?utf-8?B?Mmt4aFEzeG4ydUl4OWFHNW9laWZzZWdzNTIrM1JUaXpkUUVnTVgvWGQ1Rjdl?=
 =?utf-8?B?Y0I5NVJlRnhKaXVUQ09lKzZVd1JHWXBaUGxTVi9BN2JvRFdObzY0TzF2SG52?=
 =?utf-8?B?KzkrZjR5SmhIa1U5Y3BhK2FteEhjZy9kUUgwVTFrN0Vqc3ZTa0FNeHI4eDFH?=
 =?utf-8?B?Y1RMSFJXbnMvV2tVb0I3b3RRa3VETHdZRVhkSFE3MEtpWGN0TTQ3N1orNFpi?=
 =?utf-8?B?T2YwSGRFSkxxYUp4SXpLSnpYUW45UThYRitJZUFLTi8vbHZLN2lETFZCbWhw?=
 =?utf-8?B?WkF4MkdiY2J2N1ZEV3pFbVgzTENLZTFPUlkxWTByUWdhcTcwdzVKalJtNzFK?=
 =?utf-8?B?cXYzeGpDdjIvSTNpU2JkaFpvMmprcUVDaGFHRStSb2RybUUwVVhTZmQrVWxH?=
 =?utf-8?B?ZjQxbXJVaW94aUw3aU5qalF1QnRiek95eXJkRGJvamJRd2NibENvcWJjREJC?=
 =?utf-8?B?b0l5akIxTWlEckw5M2RMa0tvRC9VQ1BIaDlIRWlwK3JrYUc3VGhHSGprcCs0?=
 =?utf-8?B?UzY5SEpZRVpYOTNSVHhYRjVveWlvMXJRU0d6RXNja2hRMk9CY0NWdXlUc3lj?=
 =?utf-8?B?SmR0OW1kSjVQSnZ6dEJMZGJKc004ZVBmVFVjZmpMYnd3VG8vZ1pESTBDQnlr?=
 =?utf-8?B?ejlDbllsamFZMDBTaGxwSm5MMFRFa0ZIenEvZU1IVTB3RmV2SEtQUkpjVFlT?=
 =?utf-8?B?QmhyWlBtK0tEekFNOXpoS3M5ZVc3UXNHSUhUUzJUODhpbFlmZFdjTEUzM1VI?=
 =?utf-8?B?aVhnWDc2VmJpYnBWT05ieHlQSHhvSnY0a3YrMTJSL0lDSlYvK0oyU1JFM3BR?=
 =?utf-8?B?V2tRRHFoYmFITDRDL0IzTHl4MTB5ZkNFeVBTYkE5VHFGRXVCR2lkWWtKcHpU?=
 =?utf-8?B?eWRGVDdzMm15NURrd1VQMEwweXVxVDZxek8rRHBHQzFPSlFjb2FQVmtBZXB6?=
 =?utf-8?B?QmxpL3MvUlVwYkNhdUVya1pPbnY5dUZDL3FicDgyUU5FTUZhRmc2TnMyUlE0?=
 =?utf-8?B?dHg0TFdMZVAvWVBDa0RTUTYwRnI4Vk5HU3VXTzhHWUVJN0ovV2U5RG54K0lp?=
 =?utf-8?B?S05nMXFyaENpSlFZWWNZWTFrL3o5TXdBTG02TmlQV1R6bW1HS0pXZnRCMU1y?=
 =?utf-8?B?Y041YzNBNzVrOEJ3aW1zS1o5OEFyR1Vnc1JOU05LV3IxZGh4ejdQQXFwVUNI?=
 =?utf-8?B?cHlCOHZoZTBmT2RyWis0aHl4WDZYRzJoa01Kc0UzTXpPUHAzd294aWZOekpD?=
 =?utf-8?B?R1FPdUNJQjR1VVd0bjNjNnBzRTRCcXlON1QrM0JuTGlPOUpBSHhIWkgrd3I3?=
 =?utf-8?B?dURBc1gzWUFzL3lKV2FMb1FnenEwQXlObFgxdzk3azRTNEp0NGlCZDl5U0dI?=
 =?utf-8?B?YUNBNGEya3pZVDRCWk5qY2todW9HNGhDY0FJaDhXM21abjhNdlpQalY5TE1x?=
 =?utf-8?B?aFEwZk0wUnNSWWsrM3NGRUZEZE9QMkN1WVlMcTc5K29zNmpmRWsxc1NnUzhH?=
 =?utf-8?B?d0lNaGl0NkRERWNuQVE1K2tVQVZXN0lSVkxVc24rM0RlLzVxZi9mRVN5dUxJ?=
 =?utf-8?B?UXFKbFBHMFBMbDYyMTdmaGtlN3p2VGlKbHdyUEl4RHZOMk5nL2NtOWthb1dB?=
 =?utf-8?B?VEs5MU1Eb0p6WS9aWGpya3NQNVF3eDA3V2dLUndzcnZwbzg3Mm9IU1UwWml2?=
 =?utf-8?Q?uYv2R+OnqmSuHJTr2bbeK8T8I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA629952CFA3344838B8C550CBDABD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230a5817-6507-41ed-82a8-08dd5a3dd447
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:26:15.6949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M83IoddKO8LtCFaZScLFMZdrCMaTBjaNDVfvLDtyAajn8hgqE1pSMXlbNOTgCaqhPFJT5kkCvd8XGfIu+HYlEYoGlRgMhI2toSFmPtNfL2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
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

SGkgRXVnZW4gYW5kIFN1bWl0LA0KDQpPbiAyOC8wMi8yNSA1OjA3IHBtLCBTdW1pdCBHYXJnIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwg
MjggRmViIDIwMjUgYXQgMTY6NDUsIEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbGluYXJv
Lm9yZz4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiBPbiAyLzI4LzI1IDEyOjU4LCBTdW1pdCBHYXJn
IHdyb3RlOg0KPj4+IE9uIEZyaSwgMjggRmViIDIwMjUgYXQgMTU6MjAsIDxNYW5pa2FuZGFuLk1A
bWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IEhpIEV1Z2VuLA0KPj4+Pg0KPj4+PiBP
biAyNy8wMi8yNSA3OjQ4IHBtLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gT24gMi8yNy8yNSAxMjozNywg
TWFuaWthbmRhbi5NQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+Pj4gSGkgU3VtaXQsDQo+Pj4+
Pj4NCj4+Pj4+PiBPbiAyNy8wMi8yNSAzOjE0IHBtLCBTdW1pdCBHYXJnIHdyb3RlOg0KPj4+Pj4+
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24g
VGh1LCAyNyBGZWIgMjAyNSBhdCAxNTowNiwgTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4NCj4+Pj4+
Pj4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBBZGQgUE1DIGNsb2NrIGRlZmluaXRpb25zIGZvciBNQ0sgYW5kIFVUTUkgd2hpY2ggd2lsbCBi
ZSByZXF1aXJlZA0KPj4+Pj4+Pj4gZm9yIHRoZSBzYW05eDcgT0ZfdXBzdHJlYW0gRFQgc2luY2Ug
dGhlIGNsb2NrIGZyYW1ld29yayBpcyBub3QgaW4NCj4+Pj4+Pj4+IHN5bmMgd2l0aCBMaW51eCBh
bmQgYWxzbyBpbmNsdWRlIHRoaXMgaGVhZGVyIGluICdjbG9jay9hdDkxLmgnIGZpbGUNCj4+Pj4+
Pj4NCj4+Pj4+Pj4gWW91IHNob3VsZCByYXRoZXIgZHJvcCB0aGVzZSBsb2NhbCBEVCBiaW5kaW5n
cyBoZWFkZXJzIHdoaWNoIHdpbGwNCj4+Pj4+Pj4gYWxsb3cgZHRzL3Vwc3RyZWFtL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oIHRvIGJlIGluY2x1ZGVkDQo+Pj4+Pj4+IGF1dG9tYXRp
Y2FsbHkuDQo+Pj4+Pj4gT3RoZXIgU29DIERUcyB3aGVyZSBPRl9VUFNUUkVBTSBtaWdyYXRpb24g
aXMgbm90IGFkZGVkIHlldCwgZGVwZW5kcyBvbg0KPj4+Pj4+IHRoZSBsb2NhbCBEVCBiaW5kaW5n
cyBoZWFkZXIsIGRyb3BwaW5nIHRoaXMgd2lsbCBsZWFkIHRvIGlzc3VlcyB3aXRoDQo+Pj4+Pj4g
Y29tcGlsYXRpb24uDQo+Pj4+Pj4gV2UgY2FuIGRyb3AgdGhpcyBhbHRvZ2V0aGVyIHdoZW4gd2Ug
c3luYyB0aGUgdS1ib290IGNsb2NrIGZyYW1ld29yayB3aXRoDQo+Pj4+Pj4gTGludXguDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IC1TdW1pdA0KPj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNv
bT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gICAgIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xrL2F0
OTEuaCAgIHwgMyArKysNCj4+Pj4+Pj4+ICAgICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0
OTEuaCB8IDIgKysNCj4+Pj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Ns
ay9hdDkxLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsay9hdDkxLmgNCj4+Pj4+Pj4+IGluZGV4
IGExNzhiOTQxNTdiLi4wMTZjNmUwYzYyMCAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xrL2F0OTEuaA0KPj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbGsvYXQ5MS5oDQo+Pj4+Pj4+PiBAQCAtMjQsNCArMjQsNyBAQA0KPj4+Pj4+Pj4gICAgICNk
ZWZpbmUgVVNCX1VUTUkyICAgICAgICAgICAgICAxDQo+Pj4+Pj4+PiAgICAgI2RlZmluZSBVU0Jf
VVRNSTMgICAgICAgICAgICAgIDINCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiArI2RlZmluZSBQTUNfTUNL
ICAgICAgICAgICAgICAgICAgICAgICAgMQ0KPj4+Pj4+Pj4gKyNkZWZpbmUgUE1DX1VUTUkgICAg
ICAgICAgICAgICAyDQo+Pj4+Pg0KPj4+Pj4gV2hlcmUgaW4gdGhlIHBhdGNoIHNlcmllcyBkbyB5
b3UgbmVlZCB0aGVzZSBkZWZpbmVzID8NCj4+Pj4+DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiAgICAg
I2VuZGlmDQo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9h
dDkxLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaA0KPj4+Pj4+Pj4gaW5kZXgg
YWIzZWUyNDFkMTAuLjcyMzViM2JhMDFlIDEwMDY0NA0KPj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9hdDkxLmgNCj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svYXQ5MS5oDQo+Pj4+Pj4+PiBAQCAtNiw2ICs2LDggQEANCj4+Pj4+Pj4+ICAgICAg
KiBMaWNlbnNlZCB1bmRlciBHUEx2MiBvciBsYXRlci4NCj4+Pj4+Pj4+ICAgICAgKi8NCj4+Pj4+
Pj4+DQo+Pj4+Pj4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsay9hdDkxLmg+DQo+Pj4+Pj4+
PiArDQo+Pj4+Pg0KPj4+Pj4gSSBmaW5kIHRoaXMgb2RkIHRvIGluY2x1ZGUgb25lIGF0OTEuaCBp
biBhbm90aGVyIGF0OTEuaA0KPj4+Pj4NCj4+Pj4+IExldCdzIGNvbnNpZGVyIHRvIHJlbW92ZSBv
bmUgb2YgdGhlc2UgZmlsZXMgaW4gdGhlIGZ1dHVyZSwgYW5kIGhhdmUganVzdA0KPj4+Pj4gb25l
IHRoYXQgaXMgaWRlbnRpY2FsIHdpdGggdGhlIGJpbmRpbmdzIG9uZSBmcm9tIExpbnV4DQo+Pj4+
Pg0KPj4+Pj4gTWVhbndoaWxlLCBsZXQncyBzZWUgd2hlcmUgZG8geW91IG5lZWQgdGhlIFBNQ18q
DQo+Pj4+IFRoZSBQTUNfTUNLIGFuZCBQTUNfVVRNSSBhcmUgZGVmaW5lZCBpbiB0aGUgZHRzL3Vw
c3RyZWFtIHNhbTl4NyBTb0MgRFQuDQo+Pj4+IHNpbmNlIGR1cmluZyBjb21waWxhdGlvbiB0aGUg
Y2xvY2svYXQ5MS5oIGZyb20gdS1ib290IGlzIHVzZWQgYW5kIHRvDQo+Pj4+IHJlc29sdmUgdGhl
IHN5bnRheCBpc3N1ZXMgSSBoYWQgdG8gZGVjbGFyZSB0aGVtIGluIGNsay9hdDkxLmggYW5kDQo+
Pj4+IGluY2x1ZGUgdGhlIGhlYWRlciBpbiBjbG9jay9hdDkxLmgNCj4+DQo+PiBJIGRvbid0IHVu
ZGVyc3RhbmQgdGhpcy4gU28gLCBjb21waWxpbmcgc2FtOXg3IHVwc3RyZWFtIERUIHdpdGggdXBz
dHJlYW0NCj4+IGF0OTEuaCBzaG91bGQgd29yay4NCj4+IERvIHlvdSBoYXZlIGlzc3VlcyB3aXRo
IHNhbTl4Ny11LWJvb3QuZHRzaSB0aGF0IGZhaWxzIGJ1aWxkID8NCj4+DQo+Pj4+DQo+Pj4+IGlm
IHdlIGRyb3AgdGhlIGNsb2NrL2F0OTEuaCBmcm9tIHUtYm9vdCwgdGhlIHNhbTl4NzUgd2lsbCBw
YXNzIHVzaW5nIHRoZQ0KPj4+PiBpbmNsdWRlcyBmcm9tIHVwc3RyZWFtIExpbnV4IGJ1dCB3aWxs
IGJyZWFrIG90aGVyIFNvQyB0aGF0IGhhcyBub3QNCj4+Pj4gbWlncmF0ZWQgdG8gT0ZfVVBTVFJF
QU0geWV0Lg0KPj4NCj4+IFNvIHlvdSBuZWVkIHRvIGluY2x1ZGUgY2xvY2svYXQ5MS5oIGZyb20g
dXBzdHJlYW0gZm9yIHNhbTl4NzUgYW5kIHRoZQ0KPj4gb3RoZXIgYXQ5MS5oIGZvciBvbGRlciBT
b0MuDQo+PiBEb2VzIHRoYXQgd29yayA/DQo+IA0KPiBUaGUgd2F5IGl0IHdvcmtzIGN1cnJlbnRs
eSBpcyB5b3UgY2FuIGhhdmUgYSBzaW5nbGUgY2xvY2svYXQ5MS5oDQo+IGF2YWlsYWJsZSB3aGVy
ZSBwcmVmZXJlbmNlIGlzIGN1cnJlbnRseSBnaXZlbiB0byBsb2NhbCBVLUJvb3QgY29weQ0KPiAo
Zm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5KSBvdmVyIHdoYXQgaXMgYXZhaWxhYmxlIGluIHVw
c3RyZWFtIERULg0KPiBTbyBjYW4ndCBoYXZlIGRpZmZlcmVudCB2ZXJzaW9ucyBvZiBjbG9jay9h
dDkxLmggYXZhaWxhYmxlLg0KPiANCj4+DQo+Pj4+DQo+Pj4+IE9yIHdlIGNhbiBhbGlnbiB1LWJv
b3QncyBjbG9jay9hdDkxLmggd2l0aCBMaW51eCBhbmQgZHJvcCBjbGsvYXQ5MS5oLA0KPj4+PiBy
ZXBsYWNlIGl0IHdpdGggY2xvY2svYXQ5MS5oIGluIGRyaXZlcnMgYW5kIERULg0KPj4+PiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgdGhhdCB3b3Jrcy4NCj4+Pg0KPj4+IEkgd291bGQgcmF0aGVyIGZh
dm9yIHRoZSBVLUJvb3QgZHJpdmVycyBhbmQgRFQgdG8gZGlyZWN0bHkgdXNlDQo+Pj4gZHRzL3Vw
c3RyZWFtL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oIGluc3RlYWQgYW5kIGRyb3Ag
bG9jYWwNCj4+PiBEVCBiaW5kaW5ncyBpbXBvcnQuIEl0IHRoZW4gYmVjb21lcyBlYXNpZXIgZm9y
IG90aGVyIFNvQ3MgdG8gbWlncmF0ZQ0KPj4+IHRvIE9GX1VQU1RSRUFNIHRvby4NCj4+DQo+PiBT
dW1pdCwNCj4+DQo+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZXJlIGFyZSB0d28gYXQ5MS5oIHdp
dGggZGlmZmVyZW50IGRlZmluaXRpb25zIGZvcg0KPj4gdGhlIHNhbWUgbWFjcm9zLiAoSSBrbm93
Li4uIGxlZ2FjeSByZWFzb25zLi4pDQo+PiBUaGUgZHJpdmVycyBoYXZlIHRvIGJlIHJld29ya2Vk
IHRvIGNvcGUgd2l0aCB0aGUgbmV3IHZhbHVlcy4gTWVhbndoaWxlIEkNCj4+IHdvdWxkIHNheSB0
aGF0IGF0IGxlYXN0IHRoZSBuZXcgU29DcyBzaG91bGQgdXNlIHRoZSByaWdodCBtYWNyb3MvYmlu
ZGluZ3MNCj4gDQo+IFNpbmNlIHRoZSBkcml2ZXJzIGFyZSBhbHNvIGNvbW1vbiBmb3IgYm90aCBu
ZXcgYW5kIG9sZGVyIFNvQ3MsIGl0J3MNCj4gcmF0aGVyIGJldHRlciB0byBhZGFwdCB0aGVtIHRv
IGNvbW1vbiBiaW5kaW5ncyByYXRoZXIgdGhhbiBzdXBwb3J0aW5nDQo+IDIgZGlmZmVyZW50IHZl
cnNpb25zIG9mIGNsb2NrL2F0OTEuaC4gSWYgeW91IHdhbnQgdG8gZG8gdGhhdCBhcyBwYXJ0DQo+
IG9mIHRoaXMgc2VyaWVzIG9yIGxhdGVyIHdpbGwgYmUgYmFzZWQgb24geW91ciBwcmVmZXJlbmNl
Lg0KDQpUbyBlbnN1cmUgY29uc2lzdGVuY3kgYW5kIGNvbXBhdGliaWxpdHkgd2l0aCB1cHN0cmVh
bSwgSSdsbCByZW5hbWUgdGhlIA0KbG9jYWwgY2xvY2svYXQ5MS5oIHRvIGNsb2NrL2F0OTEtcG1j
LXN0YXR1cy5oIGluIFUtQm9vdCBhbmQgdXBkYXRlIHRoZSANCnJlbGV2YW50IGxlZ2FjeSBTb0Mg
RGV2aWNlIFRyZWVzIHRvIHJlZmxlY3QgdGhpcyBjaGFuZ2UuDQpUaGlzIHdpbGwgYWxsb3cgdGhl
IG5ldyBzYW05eDcgU29DIERUIGFuZCBkcml2ZXIgdG8gdXRpbGl6ZSB0aGUgc3RhbmRhcmQgDQp1
cHN0cmVhbSBkdC1iaW5kaW5ncy9jbG9jay9hdDkxLmggd2l0aG91dCBtb2RpZmljYXRpb25zLg0K
V2Ugc2hhbGwgbGF0ZXIgcmVmaW5lIGF0OTEtcG1jLXN0YXR1cy5oIGR1cmluZyBjbG9jayBzeW5j
aHJvbml6YXRpb24gDQp3aXRoIExpbnV4Lg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgc291
bmRzIGdvb2QNCg0KPiANCj4gLVN1bWl0DQo+IA0KPj4NCj4+Pg0KPj4+IC1TdW1pdA0KPj4+DQo+
Pj4+Pg0KPj4+Pj4+Pj4gICAgICNpZm5kZWYgX0RUX0JJTkRJTkdTX0NMS19BVDkxX0gNCj4+Pj4+
Pj4+ICAgICAjZGVmaW5lIF9EVF9CSU5ESU5HU19DTEtfQVQ5MV9IDQo+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4gLS0NCj4+Pj4+Pj4+IDIuMjUuMQ0KPj4+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+
Pj4gLS0NCj4+Pj4gVGhhbmtzIGFuZCBSZWdhcmRzLA0KPj4+PiBNYW5pa2FuZGFuIE0uDQo+Pj4+
DQo+Pg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNCk1hbmlrYW5kYW4gTS4NCg0K
