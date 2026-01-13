Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37BDD29DF7
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8080183678;
	Tue, 13 Jan 2026 10:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YaWQf0p0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B803E83935; Tue, 13 Jan 2026 10:41:03 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2728352B
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpQUJm7kJ33549mMJOFPXNgqko70t2AmwQT6N+AVT1kMpu/9Pgkeh0t8Oew6oR3DagDI+tsIM/EJFYeMEYGuAO0y20Y9KU0Oai0m5eE2DhdJFthhNdfkTndH7fihDovx3FZrjHkAkTQu3awmhx+wB/IYdHdNElHzgLxtJdiCqKH0frxhqIOC1tASYRmmFOQ+cdql/hmGG+l4h197edm02RUzZHcz6SnT/zUlqBAHTi0zrwAwGxXF3TdBNuiz/YEubmzo1v+yENJ4Elp6jUv4ldNhrgJzNdevo0JCJZbO3OJjS45UoA/q1mkCTeigtyCzSXbaQp5Im1/M5DRCd7byvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebEeVwocWrySp8WtdUwdEUhfw8FPkYMGoTOhUlufkQY=;
 b=JLw8nHg0gcno6XFvgjM0XJrrK54gj1G1CiQAQBb+qZDBh+Z8EzjR7D2LkuSLpWFku8JREBeOd+q2P2DzDo2Rpch+CGbWIi4JuYEJHNcGBUbvRiUIZd9TrTslAiEniCHJBZTZm10ycgPT2X+d+/ERXI1kcS2Yo4ccQOgmAkKq2LVCTk16B/6Nlq1i3cNLZU4UID3Xd0DimTH2C+z4fnfVDj9HS7KNPL3eRRGR+RoYT2V1vXyVIYZlfTJNtSe+wdt9e7kJkCTonwzzGFJ+76lJjTKmZXEb4eeKrztLrVgcRguLCt0b/CxYXPwbVHRbau3E8wmX9uI1x5XBNVTGYGvK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebEeVwocWrySp8WtdUwdEUhfw8FPkYMGoTOhUlufkQY=;
 b=YaWQf0p0pWgE7FgaPuMoknozBPMJ1qDH4zmM1AJ8Lu6F2fT6qAtIEFvZqMKYgmpkQsQTziDjfgXZ4v4DmP3Lhk32f4PCC0b08wsA663BapRzvm1irENw9fQUwH8iecmNGlfFzqnB5XFrnwa/62JdulULImhBJp0RGSlDNaixe9re1IntCvvgZBjBMyVGujzK99IlUaGeuyGR1UutshkhSYWpaEQee14/pchH8y/9O0iRQ/DPOeTJnUhzxe6G8ctS1nEUk6PX4aOyIJdmvliQClTo1s2kMl4+cJiGTr4NO4vxMXPVYoNV4Y2ahChfuyEFBkj2pBxyia04BOPREkRUOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6469.namprd03.prod.outlook.com (2603:10b6:a03:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:40:55 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 09:40:55 +0000
Message-ID: <83d127aa-1faf-43fd-887d-145306c749d1@altera.com>
Date: Tue, 13 Jan 2026 15:10:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] power: regulator: common: fix compilation issue
To: Peng Fan <peng.fan@oss.nxp.com>, Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
 <aWYKywKkaJITY5R6@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aWYKywKkaJITY5R6@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0145.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::15) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d34e93-a051-4c9b-64a5-08de5287d8f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVQZ0Y5SlB5YWx6TlZkRG85UklIb3BrTlp0dk5ldVNtbG9MSnhyVnF3cjk0?=
 =?utf-8?B?NDdMVExFZlpPWUJpeCsvdllaZjJ0NURPRWNyd3RxSTFWSTNVLytzS3ZRRkND?=
 =?utf-8?B?MjIzbzFFRWVUbFg5NmZxQy9WOGlFN0t2YWRLMTR6Y1dvREJyTlEvMis4UDJQ?=
 =?utf-8?B?ck81WmVPRzhpSDRKSFNhdWo1TDNaYXdpV2xqQlpDc0pndXhoNWNFeDlUV3Ew?=
 =?utf-8?B?enZhdGJ3Qm5XZHhwVGtWc3A1ZHVlNWtiM1BTOUw5MFJtWXFLcEl3QjM2RHNl?=
 =?utf-8?B?MXpzN3RENTdIWXJiaGlRd080Q0ppOTJiVVNWTmlCNzQ2SWZpcEpMd1VHV3VD?=
 =?utf-8?B?Rm51Q3VxSlR0MVpaaFo3U2NjYkdHTzh4b1I2SHpXbXJESGluSDFqbnpybUlw?=
 =?utf-8?B?MDNQUUNXRUd3bXZYUEVxcjl6RVBOMmxvbENnMGI2YkZnaXBrTzlDeW9XN2Qy?=
 =?utf-8?B?OFUxbmhyVzVuRWllYVNwYVNCZ3VwNnB0VlZmTlVQMTBjNXBidElnYnRZRExM?=
 =?utf-8?B?VHBsZXYwSjBmR2JBUjI4dnovSTF4RExYK05GMnlWTnl1NkJrWEZzeUk0ZXMw?=
 =?utf-8?B?NkttVTRjcWFIazY0aXVYSi92YzVvNEh6WlpTUWs3T0oyb1BJS1VQR2F4Z2ZY?=
 =?utf-8?B?azNmWnZSdEZqeUxEMWNQUmdLUmpkUGZpSG9kbGI1b041SCs5RVhtSW9TT0ZG?=
 =?utf-8?B?akZwR1dFVXZjY2UwYlJDaldWSnRPcEYyWDNvUkwwMFFWVm9qLzBybTNTbTVR?=
 =?utf-8?B?azJEL2FtSXBNWDJPRFU0WEZ0TXY5aWozbTRzKzgwRUp1SjlrMmdKV3pwV0lT?=
 =?utf-8?B?QVVCc3N5SmVMbWExZEhCamxLUVdUMjNaZFVoRnJFbnU2WFdHZllqVTVsWk1m?=
 =?utf-8?B?MStlWXZ1eDZQU2VvWGVyczhKL3JXTDl3NlI4djBPOUR1NG9PazAySlY2eU5Y?=
 =?utf-8?B?SXhXTzBrTWVZKytQcEJmcDFKT01nbGpmMXdIUTFBbXVmVVJNK1ZQQldNWXVP?=
 =?utf-8?B?LzJZY3hPVndSSkFKME9lcTMvc2ZXMFNyOWFGRnVTMVpDRXE3WGZhc3ZVV2xq?=
 =?utf-8?B?S2VnSjFTVWJrKytRYjVuV0RtOVhnditwSEMzT2tIOUprU0pvRjdqZDhwcnRk?=
 =?utf-8?B?bHBRc041VkU3WFE3bUpjbzc0cFRnZHpHaGZhZkRTTFM4bjlmaE8zOTBwYmhM?=
 =?utf-8?B?YkxTVWdnU0lwdnpLZW1jYjZldVI3Y2R5UC9OTldWT1NkWGxRYnA1M3hiQXhJ?=
 =?utf-8?B?U1g5SUN1UVd2S3R4Sm1RQ0UyWUhrVEYrYTFCdFBEN2NvRFBRV21VemhMd1BK?=
 =?utf-8?B?ZnVtcVBRajBBdnFEMkpoVjJGTzhqNUl6WnRsZ3Y4RUlXN1FmbS9aWFVpSlJ1?=
 =?utf-8?B?WURjbDBsQXNsWG9aYWY5SE5QR3JsZU00WWN2Z1dHc2tyNVlEWUFmeGhtYUZJ?=
 =?utf-8?B?ZmQ0bzF1cDVYMDVuWFBucGsvUC8xR0U1VERENzh5UzgvUm9QYVlyNGRpaFNC?=
 =?utf-8?B?MEJoQkZmS3MxQkdZR3IvWTVZUUcvd3BWT1h0KzZCdzJzdW5jYUJxVFYwZ3dF?=
 =?utf-8?B?eUZGclpyTUgzQTJVZmlNMEV5UWZZMFpNWnVDU2RnZHhIUFFpbTg2S3UzK29s?=
 =?utf-8?B?NlBlby8xNVhkYkt1YUhzejNOMWdJT1U2V05QMVpzWHFLVnlyS09JRTNFd3hw?=
 =?utf-8?B?TXpNR1FFQ0plK3VyQ1Z4bmtvMkRPdGJHNC9IRHFxSEtnVkNzYkZJRy9sYTRE?=
 =?utf-8?B?NzYwNE43NlJVT0FoeHpQRFZpeGN2TjBSWm1UaW1XWjhHVlFzbi9nNzZMRm80?=
 =?utf-8?B?czJCNFkwQ01vRDAzYjJDTk45azNpUllJdmRlS2ViZUJDcndUaGd1Wi9QYng0?=
 =?utf-8?B?MzNyeHJXL1pPQWxocHJrbXV3Z2FhdFUxZktPdlM5aWxNQjVjWFc3OFNvV0FO?=
 =?utf-8?Q?Lqtl23V4FGQD88xQrrOlvO1vCIiDQ2Jo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dGWDkzMVo4amppMUtEdmlpQVc1aE5EQnFrc3M2dUxJdCtXdDVoWG9RQ0Zj?=
 =?utf-8?B?U0F4dUlLVk5Kakd1NzNwMXNZNlprNVBEOE5HQlhnM2NjQUNjMUw2TGJkVTd2?=
 =?utf-8?B?SnZLWFZ5Y3M4UmFFWG9LZmVoOVE4ZHVLZnNKQXdOY0tNbVlPV1lSTTNZSHFm?=
 =?utf-8?B?STQzQ1RzR2RxT0hZRGw2eGdWcE9lTkFBM2R5R1NyMGxqc3M4QzdZMzMwcDZa?=
 =?utf-8?B?R1htektMakpRT2wwY2NDY3N4bVQ3RTVTT3JJNmJyUEpaSzlqVU9QRkExenhD?=
 =?utf-8?B?cFFUQ2VNR21nbFdZSmRhVmFQMzBycktyQW5CdnM0OFY2YXhseGp3bEE1d0ZN?=
 =?utf-8?B?YzlmUmRVczJReGFjM1V1bUpOMlFRK0JOWEFERFYydjdnS2NGZU9wN3dlZ3Fa?=
 =?utf-8?B?UFFKZnhZVXJSUDZmR0JMMWNheDBkUmlFYWdvQ2pxNithRkdHSzM4VUpsYVR1?=
 =?utf-8?B?eDFOQk13Wmt4bTR2WlZYL2RObzVHbDBubjRreUtBSWluQWRzRUhJVGV5Wksx?=
 =?utf-8?B?elBhekxxWUVvYWY0R3FvWU1FWE5XdXJMVDNaaFlCdVlOaGhpQ2VYOXBJNjB2?=
 =?utf-8?B?Vm9BMkZYL0U5NUY0akhRVmF5Q2hHZ0JLZWlhZkgzVlltRFRFdnpjMFJENm9u?=
 =?utf-8?B?V0FTaExFUGZpem04aFZrQ3hhaWt4aThaSVI2d2JQM2h4MHRqTjZtR1Q4cVVL?=
 =?utf-8?B?Q0IwTTR5VHJtS0hCVnBHNisvQmkyeW5FQ2dYWEFqd3dOR0gvY3FjYS9SbFVF?=
 =?utf-8?B?dWxiSC9TUndwRWZlaFhtcHlOUFR3dklDbE03OGVSRFhYeWlldXl6V2I0MVJz?=
 =?utf-8?B?QjZpT1B0Q0tRWUVtVGFmeFd3T2VEdDFHeHdRYTVHbENOclFLV0ZxQ09ZSDNn?=
 =?utf-8?B?WEVJZlB1cmQyMXVzOXdrNEF1NHJGTWZXZUJNOU55eHRvaWx4eEhtU2FMUkcx?=
 =?utf-8?B?MGRlSDVuSFJBanRHZ2ZHQ2d5bkROMnhPYWdGb3pKVlVOdlIvWGk2b3J0MnBt?=
 =?utf-8?B?eC82ejEwdENFZnc0UlJ2MGEzTEdKZ2ZzYmllR3dpTzIwNXJjNGR5b21IVDY0?=
 =?utf-8?B?TVI1Tno1SFYvbjJIMzdBSGszbU8zWDUzVjBMVXBQMGE0SHFobmNpQTQ0KzJ0?=
 =?utf-8?B?aFRGUHJlclBzQXA3eEpIb0hWMWNYVExjRVNkQTJETHJyck1pSHZzR01HZy9w?=
 =?utf-8?B?NkhjS2dITFFiRVNETXErTmZoeGJ1VnRLZWtRNWhBMW1zalFHV2VyYkdCOWJN?=
 =?utf-8?B?bzNTb0twRml4aG9mN0NSZ3BZYnRtTDAvd21hWm84d3Jza3dDeVE1SVhDR21C?=
 =?utf-8?B?L29udDhZUzBhVERIcGVHcmF4cEVSWFR2OFMwdWdkK250N2VpVWFuZFZjdDFw?=
 =?utf-8?B?WmJpY3VUZlpIdkRwK2orcWludGNocG9ON3JzV2hQZXdGZnFyR3daaHZIdjd3?=
 =?utf-8?B?NmYyK2VPUk9XbjlhTVRNUDlQTDBNaTA4NUkzV0FTU0pYUnlseGZ1QS84blpD?=
 =?utf-8?B?TFJnQWFxQ1VFblJ2cG1mQ2hzV1hvUnU3Ry9PWGFsUTBWb3FuekU3NEVuK080?=
 =?utf-8?B?azRJM3lGVEt1TXN2TVhma2RSc0JlMG5KYW1IMFBPTHJtUjBONG5ET0FTYlNL?=
 =?utf-8?B?d3ViV2ZVb3BOT3hKb3NiT3hTODBya2FMd3orM2N5bUxKdmNZTFZobEdrS1g5?=
 =?utf-8?B?OXhzYTkwQXhvR2VVRnNkaFYxNEJ3eWJpQURCZ1VxZGtiWVRnQ3BRNXVTNE5C?=
 =?utf-8?B?MUw5L0RKMXg5RmRZRlBGNHlhZkNqcmF2OVMxZW1rME5RTlZ6eXRMLzRrOVEv?=
 =?utf-8?B?Nm5sZVE5QjZwYld3TExCcUVNeUxFaEpvMXZQUTRtTVVldVN1SmhWNmZDY3M1?=
 =?utf-8?B?TXpPRkt1eWhSM2lBeHVqcVZDSW9BZk8vTUczUjhSMUNjSDJpUFlCNkxyUVdk?=
 =?utf-8?B?OWwrd0NGbkd6WWdBaFozSlhLeVNudWo2THRpa2pFQU5TQzNSeC9QNnZKUW9K?=
 =?utf-8?B?YTZsKzQ4ak85R3RxWjhSRnp2RXRoV0lrQUxubzlzTnZEc2haTi9HbkVyVklS?=
 =?utf-8?B?eTNFNHZNTkFYWlUrQVd1T3NvcTE0SlNoMmpXbEhEUS9GVDJtRXUxcjE4Rml5?=
 =?utf-8?B?YWdYdFo4NlZsZGM1RkVWVlBnUTU2TU45Nkwva2ZlaXpuYnBTMktiamxyd2l6?=
 =?utf-8?B?R2lkMG9uT1c5enpDdmYvTk9ZSThGMEZsZGVkUVlpWER0K3BGd2xUblQxQnF3?=
 =?utf-8?B?Y2pQZzl1b3JkTkw4NWtBQ3YralVsSkZpVE44L2poYjVNcUo3U1BvcUhZWW82?=
 =?utf-8?B?WmR5Y1IzcHNhTnJsVFdrWFZMSzAydGM4WVM0dEgzR2JEWFZZVTBvdklrWWJW?=
 =?utf-8?Q?ccu8RyUOCtOVM1I4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d34e93-a051-4c9b-64a5-08de5287d8f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:40:55.0275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DLGAKcAH9oUlAfcN6DencU3wF8nFuRjFHr/a3OBqS/msnprqRwO6JZkwnSWlvDU6fv6eC0z11cc973B5YcSm9i7T852N5ercl9DHQd4VKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6469
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

Hi,


On 1/13/2026 2:35 PM, Peng Fan wrote:
> On Thu, Jan 08, 2026 at 03:42:49PM +0100, Julien Stephan wrote:
>> If CONFIG_DM_GPIO is not enabled, compilation fails with the following
>> errors:
>>
>> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
>> <...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
>> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
>> <...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
>> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
>> <...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
>> make: *** [Makefile:2029: u-boot] Error 139
>>
>> Since the enable gpio is optional we can conditionally skip these calls.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Tanmay
