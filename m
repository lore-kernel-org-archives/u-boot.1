Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02663C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D2982AA7;
	Tue, 13 May 2025 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L6aSPz3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0FB80AE0; Tue, 13 May 2025 12:20:30 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAED78091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z32OyhVXbQ7szIqhAB4oJwxDI3dF6Lbyv1MkjuHiKWyGmyq14pb1IDYUAtBts0DCywOuyG4EiT+sVKXpGG90TrIJsH5pZbIG4iaGmlXkS4jY6LkFtj2IC539wWi1aPGHy8+uvgmDMvmXxsBWMMZwnPQVLRUsUPTL+9j99SZMD8q+WlISsSo1cwpfjLVl30q8ZXFpOW5QLg49IZnxk7i7KiV4DMBe7ORRx2Z2eXCZLJK+SLUcV4tzxhNI9Y2vHSvIdug5uOJWbP/NvOQO1PSoeEYTPNhppfkVr86q2yAjnCm7DnGybQnBW3dIckht5kCB3jHaooGHHbGGJaaKVf6V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdvV9UoRNM9KLri/EmoqMmNhzRX2u+djvAjE6b+yq3A=;
 b=julA7rt1UlMI+IzZeImywnVcXCevTNo1yhCht+SeWWDwn7YfbS7cCGo/1XkiqC+VP8uHoArGtgatlndryNGcpObXwFQ97qqlz9HnfW0WXzqkfTmBs2vQj+0y+OGcQvoAHU36C4fU7JK1hrN3r+k8W95I48V3hFINjgyEWUurg2PcmAXQ4XT7PlHtuVfDeSLM0x9p0u3QBuxpapPKoVLVBbsi0K0ayabVUjTIwk79k7TOWdkVOCJ4aw8S2NeWAnAiJQNCARRW6IJzqZCTyJhbTZJTB+5Wa76baG8Qk0/4SpKXCwenrCc9RW22FYHhBzfzzlvQp314XmUW8cvQ0PvniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdvV9UoRNM9KLri/EmoqMmNhzRX2u+djvAjE6b+yq3A=;
 b=L6aSPz3lCEBUyPVCuNeciF7yYpVRklJAfeI/g56yHRq3rNn3zmTmUS/LsrAu/XyjY8tHADYphWgidRibSZ9sr8dwWeKFpGpOLQZeiJ39tzGHdfo41oHLbw498yOJOqPcE+o5zhGppo7+5QyQLNyPKJXsm6NOJZtyukUBFDachrzQWyveIBJ6u2QWT1SUFEKXZFAcjXAjZue2qQjw+70OBj6JKSxZQ2ESth7NVkOt+INOodIvhGCdzlG6iZccMyPhlLPbkx4cH6X+xzlkAGbxtUikgoVmKUennM0bu0+uthDDeDsgPLi5q1kHMx3U7wT4DR+YQHBA0IprasNtkCTbew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:25 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:25 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 04/12] drivers: Enabled Kconfig and Makefile for i3c support
Date: Tue, 13 May 2025 18:19:05 +0800
Message-Id: <20250513101913.30880-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dcba26-ed6e-45fb-eda6-08dd9207c660
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTdWWE1DbC9TK1pwaWRNaTV4dU9veWY1dnlRSGkxczR1TDZkeURDSjVYKzNo?=
 =?utf-8?B?bllRZ0FpNmNJc045TzRKY3hSOVRqZzcrM3NsajRYdVIwU1JJTnhMbWNzU2t6?=
 =?utf-8?B?OFNkYXI1Q1FQTFBMK1dwT2Q4Qndnd0d6d3R2SC84bnk0Q1ZTemRhbFArMlZE?=
 =?utf-8?B?dTRTZkRwdWVwY3RWNkREOGo0RmE1WHRIMzMzaS9DeVZOcEE0N1dTN3ZENnhu?=
 =?utf-8?B?OGsxd2xzZzcrZWF5MTJXaHFBamRkZWQ4cEdFQnZjc2RnaXVkRjN5Nms2Z1B6?=
 =?utf-8?B?bTUzZllLbmdvLzJDUGdKRUJSTUlVNVhZdHBZVUNSTUhWSXhvU2xaK3I0ck5L?=
 =?utf-8?B?VVRXcC92d0Y2ZlFqTVgrYkxodzRjQTBMRGcxcHhUZUwrU1VreWpHdHRmSmY0?=
 =?utf-8?B?L3VraHdBeDR2SG52Snh2MHU4c2p0S203MVVtVFZVWkl2bTAxbGxvQ1AyT1RC?=
 =?utf-8?B?N2p0YjdnUVFGLzdMOVFZTXQrOUR6YnRVVk5odm5HcWUyN3p5Smhudmc2ZHNW?=
 =?utf-8?B?OU5vYm9JUnBLRCthdzk1VFFWM1FSQnRzMHVGZk1vRUd4Vjd3MTFxSmtseVRl?=
 =?utf-8?B?dkxnSGdyU3h2djVIcVZqK2R3YkhWR0czY2dNZmJjZHpWRUxDOFQwK3BLcU5Z?=
 =?utf-8?B?ZDY1SG9Ya2JuWDZFWjE5bFdPRDlvM3dtazZvVGlDUTFMV25rZWZoaFZXa24y?=
 =?utf-8?B?cjJxTjByMVdVRCsrNEpSN1dTUDlnODNIQWwwNkxSK1pmTjcrRFFoUFBLYTJv?=
 =?utf-8?B?Sysxb3Qvd0wxOWFqRnpYSTEwNnpVSmNudzh5Y0ZZYlVibDh4aExXQVhKZHdR?=
 =?utf-8?B?V1huSmhWbDR5dDVLZEpUMmZQUFlUWUQrQ2pqY0U2NFpMUFgwWm1OVy85ajBR?=
 =?utf-8?B?c29WRjU5dno2MU45K29KTFJNR2FFUzJWYy8vaXBqeUV2MSsyR3Y5d09mUHpa?=
 =?utf-8?B?STczUEJTbm5Hd0tBSmxGSEppZ0FmUkNUQWQxNWhKUkE3ajc3bWNTK2wyVnBv?=
 =?utf-8?B?MjJiN2VQRHJKbkoyTDliYkp5alpQL0V4MVU1TmVCUmV2d2YvUHAwWkRqa3lB?=
 =?utf-8?B?WVV1eHk3ajN3aytzdXhmZFNYMDZYb3NUUDd2cUFqRkcyZmxaSEhQYks2Q3NS?=
 =?utf-8?B?NGlvaGFnbUxJNW1EaWNmUDBZYm8xNzViZDFQME8rZXdhQ1dSM0liMTdYRUp4?=
 =?utf-8?B?Nm03THRWL1dUUERFUDNxLzhmQTN0QTVOcHhDT3ZxY1hmUWpoZHRIaFY1NzJv?=
 =?utf-8?B?VnpHMitBaXY3YmpsK0xIM2YwMzFZa2RvQlZZcWk3cFJ5RWlvajg5MWdvL1VG?=
 =?utf-8?B?ckJHbUJxZ0FOOEI3dGYwL0h0emRUemJUR3QzNWhCbzhNcVpLYjNiYW9EZFBQ?=
 =?utf-8?B?ekVtWnN3b0puYlFGSFFBa2FQMHlGaThTSVlGbFJySFpYVHIrYnNEeXc4RUhZ?=
 =?utf-8?B?SHc4L2dBYytxVjUvUzEwV2hTWktlVnFydjA3SkJsUEF3RklGTFUrb0tnMDVZ?=
 =?utf-8?B?VmpyNzV1TE9VT05BNGVhT3U1cmZJc2w5UnJkdWdOM2xzamcxc1VYVTZyNE9N?=
 =?utf-8?B?NlBDV0hORVlXSkRUU0hRRlhjc1c0ZWl2am5XU0tVTFhhUlE4V3o3YkZURjV0?=
 =?utf-8?B?c1QwRzNudmRzZDJpOSt3bDlWMzI5bFg5M1JaeDVYUGhuTS8veFZla3hUSFJq?=
 =?utf-8?B?anU4MTFCWTZHLzZoQ0c2dTh4UmI3eVAzdHNMQndrQ3MyOEVycHNEYW96VGk4?=
 =?utf-8?B?SmFHQTNsVzN5YnpSa1FwS1pKbmNsTStTUkJmeHlrWExONjlHNVI1OHNCNFVW?=
 =?utf-8?Q?X8mAq/pdUVdBpxpxHT7s/M9747daj2IrO9uBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUR2Vk42MlNRSG5Ca3p3WXZQTGdaQ2h0LzNMODhVbEdOWnhEOG1aWTI5c3JM?=
 =?utf-8?B?R1lzcml6NUZDWnVvT0FtWEpuaVZsa0xtYzNiWnIzTmdrRDl5S1VzdW5YeVQv?=
 =?utf-8?B?N0p5NlJDRDJxTFd5U212TmZwNlowSjdYMHZoZ0hsWERPRGU1RWxBUlM4NEpv?=
 =?utf-8?B?T0Y3NitnK3N5Q1owQlBidDN0QmJnSkxUUFVlZ1ZJampPTEw0UWxlMExQT1hQ?=
 =?utf-8?B?N04wZGNnRE8yNjk5WXA1UTlFb3FDWVduL1g2SDlTK1doTEhvc2ZQV1l1THJP?=
 =?utf-8?B?V3E0bUdlRG9WSVhITGxtZVlJS25aMHl1ZHFKQlI1OUVmWmh6dldZdXVrVWI2?=
 =?utf-8?B?N3RWRjd0U0R3dHUyY3ZDYXZxb0x6OWVsRXhvUmtQVVNOYkc5Ky9BeHNNb1pW?=
 =?utf-8?B?c1dHVEo0SU1pOUxjNEpKVXZYWmJqdEFONU94S0JLWS9kV1piVml5SlV4RHpE?=
 =?utf-8?B?dmN1eTlKcjlLdlIzUnFKY01sTml1V2h3Wlhzcm80U2FPWVhYajVBWHQ1UElS?=
 =?utf-8?B?NnRjVTN3RFBwSDBHQzd6T1VDV0EzRWhFYnhENWtRMXRwb3NpQlZobUJuZ1pi?=
 =?utf-8?B?RUF2OVhBU3FWSG5ZUlMrRlFLcjRVY3AvWjAzbnhoWitYVE0zRTdWQldPM3Fp?=
 =?utf-8?B?UTllTWxMSWN0a1hMNzZRQVF2TWtlTWlJSS9rMmpseWxweEpyY0ZYMzdvUkpG?=
 =?utf-8?B?RGtpTm5sNXFLQnBHZTNRcGVMSTVxMjl1VnZUKzVLdlR2V3dFY0ladHZrTWxo?=
 =?utf-8?B?TENwTkRqUGt1b25pRTF4V1hPTjhyU2U5bVRwTXlCOTRxZmhxZGhDNWl3dEtk?=
 =?utf-8?B?dDhrZ244WDljcnVyZkRuanVveEhRVkRtNTRqeHdPcEc4OEptdzJQcGk5bk5H?=
 =?utf-8?B?NVVHa2dPY0JsZ0tpTVBFTHZreTlTOTZadmRJV0RVaDlsKy80TlduZWVXKzdC?=
 =?utf-8?B?d05zRGIyTlFpQkpYRXhCVzlDKzVoemRDdDdwYzc1UzdiTG1TM2R6cjdVNHhH?=
 =?utf-8?B?TURlbjRVN21UYXQrU3Y1OTVHUVRmVEw3S1R4em1FQlpjL3dmVGtFSkJuYXNz?=
 =?utf-8?B?Y1g2aVoraUFpU2ZGZjBKcmVEM2hrbFVsakxoSGppalczYlBKdG5PTCtDTWNJ?=
 =?utf-8?B?Zkk5QjY5NytMeEF6ZXhjNTVtZ2FXWTU5NWppRDc5K09pVUNYakovbDF5MlRC?=
 =?utf-8?B?SUF6N2FFNWlNSlBjMC83UjQ2cUJpV3lDNW9Bd2VkRlZpZk9IRzNQSXdTVjlY?=
 =?utf-8?B?NHZ5YWtZUzVvckZhSlRTbHF1RWNxeHdQZHF0TzhZalg1ZUlBc1RzSjlrSHBP?=
 =?utf-8?B?djFUU3pzSGZIa2VkSnpKd1V6dkcxRUc5MVQ0TWlDc0xoL05Wazl6WmFrOCtO?=
 =?utf-8?B?d1gwTXZWOEVMWnA0TjR0eWs5bytsc1hockRqTHplaEh0Ujh6ZFE5YXdaV1dj?=
 =?utf-8?B?enA4MEhwQWUvZlBjVU11ZEdUVHhkeFRkRVgrNDhJNlBvUWg3S3ZYd2w4SGlX?=
 =?utf-8?B?eVcvb04za3lkK3h6ZUcwYW01ZnpvT2RwVzJLdnVhdUNKRVppVXpHOVpaKzQ4?=
 =?utf-8?B?V29UbFJFVW9DMElvamMvZWIzampnajJ1Rm9Va3hqZU5Lc3FCYzdxN09kRE1P?=
 =?utf-8?B?SUppczU0MTZNKy8ya2lpNnhPK2NBOUljWERYMk9IYXpsQ3JTaERKd0dpM0pP?=
 =?utf-8?B?enBZV1l0WS9ZUzhzVnlJLzZQQlZBc0lvRWRIVm9ReGlHSUx3UzliMUFOUys5?=
 =?utf-8?B?dEx2TzE1dVVyNkVvS2RWaVVISDJkTGUrYms3NytiWFNZVUg2NTNPeldNb0pp?=
 =?utf-8?B?V2orOGs5Ulk1dFVIWVZhOE9xWXY2MmFaeWR5UDMwbmpPYnN6cjZRVllVSGd3?=
 =?utf-8?B?SjFVUEpVWDRpemFRdGgzd08rbE85NG14M2lKYzdoY1Vveml4dHVoWEVVc0Vt?=
 =?utf-8?B?QWU0WFVKQkVWc0JRTm1IOGtPeGZzNFBZTzdhRE50cFlIbUMrS29OUmlMR3hV?=
 =?utf-8?B?em4vb2hoLzVlbDY1dXlaYkVBWW9NbG9FendYaEFscW0xUkZXVXZaRmhjcjFT?=
 =?utf-8?B?ZnhWK1pUK1dJYU91TnpuVjlGeFBYVlh6SmhRWjd5WnVFMXJOeUlLMmx3L2tT?=
 =?utf-8?B?cWlVZjZXMnJ0Zm5TTm5qZ2RXZXFDU3pSV252Zk80T0NrVlBMYzRYL2ZVWXht?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dcba26-ed6e-45fb-eda6-08dd9207c660
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:24.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SGFu6EjM06BHtEOtSBX3h7AQzSXLt+T3JGktMcEjravW5xYJSjs/YVkvnMPe6lfsh92jTmQVc53rXT3oblZmA1D/as5Ps0NnjRU+m2KTDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS          |  7 +++++++
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744..6dcc566eb72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,6 +1230,13 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
+I3C
+M:	Dinesh <dinesh.maniyam@altera.com>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	cmd/i3c.c
+F:	drivers/i3c/
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.26.2

