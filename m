Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65112D29DF7
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D582983678;
	Tue, 13 Jan 2026 10:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ceI+n0D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA4983693; Tue, 13 Jan 2026 10:39:36 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DDF8352B
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZV95OK4/hamo61D6VlU0gR2mYDz78RNZusZZPVbW2kOwwfm6hjdDBqa+PTcIZ2Aiwm5wvG7eUcYz5vZ6Ux33XZ/nB448hBukNJAywEP6mTyeQCsBjiW1TWNnyaN8tbXekR1j3lbKSzuJpuZJpZToYEEssQ1CLE2Vp6/KtQFPhuWWsbm/8v1w/LE617T4P60i5hTzh4vwyyCyaDqwsMzgOuZm/A8r8Q5O9l/3VkHFPVwg00NKlihVslcrWgblcZcLUj8T8PqXjGVlXmMW2cvCxABy+o1GbQJDsBzh5YgpWha2aTB9kcY/Sf3lHfd5ajjmXpBeJUbmqpdl3tPUAFiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZraU6aPPexqAG6OtF1/TjE9QOyRBsg2b8VC3uTyalg=;
 b=cgEfSupVT8cx6aW+YRrLOmfutlny5kN++wfzqL0BnmzvYQWw6qgXMYDjwcXAP/ya3JgJ9j6J4iN+g13du/vqZJkE2F7PbE4bamh36xj2QSC1xeJfLuY5u7QNnu5H2ITz64cCW5ZR/p9qieen7PRv/CllpDi8NBfY3/96tdpwrHqaCaaTgRcHQ15ofnyniNmtUJPczUAzRbtQF9+zbndBsMd/dThVlCAw7RJGlE8496ZVVeBDg2W4dIKO5WIyqX3mDT65OkO3BPkRVaApnX4E0Z7RHGcevtfYbTl7OCLv2ThsFtICYAA8/g1r6EswCx4krAwZuVT96wc0feDVtieJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZraU6aPPexqAG6OtF1/TjE9QOyRBsg2b8VC3uTyalg=;
 b=ceI+n0D1OE5kfrJ/neiAew/NgAUmLaloBxTsmiIkQfAopvF15WkXf7ZLYJxS1ATUbetAIWasS6ffMPR1QnIIdzwVpo2jjGrHXuma8U7dmrcsO0kvXJ3unzO68a6QPwG5EeH89AsQ/k3rlis9QQJTQZ2eeVoDL2Fdxp3JjPLRNTfyyo6hkyjVRHqK3Lo9CoSiIi3tzJuZdgF266WrmS4PxIwsbUFvyA635gBbYy0/vnqip+iLYFoieCiHF8iizMZrJ1u8vx6DKgp5kgQLxfB/rQNOKf+9t6Goht1MN312WSl2KHbdAFBvvyEbgjkQA7RqXPaWM+LXCUXneuYQ3Sjcew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6469.namprd03.prod.outlook.com (2603:10b6:a03:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:39:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 09:39:31 +0000
Message-ID: <36b97116-4a92-425f-a1a2-c7daf651989f@altera.com>
Date: Tue, 13 Jan 2026 15:09:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] power: regulator: common: remove unnecessary debug
 trace
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-1-b00cb3268059@baylibre.com>
 <65071031-daea-4913-aa0f-5c072aaf362d@linaro.org>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <65071031-daea-4913-aa0f-5c072aaf362d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::17) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d5ac11-0910-4aba-90bf-08de5287a6ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVZnTTdMZ2J3bzBUdFZRVDRxUjlZakpVN3JSYUVXZWw2TUNqWk92VGNjOFZm?=
 =?utf-8?B?OHFkTzR1V3RIbDJDUE1FZ0syYmx2b3EvbmVPL21UNEx3ZGpDeHJTTUYra29I?=
 =?utf-8?B?M3JaT1BBb3h4L2owMk5Qd2N2eFFlTEVxcXExQUwxdnY3cVA0dnhLWWtpcTZw?=
 =?utf-8?B?dTh4ZEwvMC9iMGRxSU1LUWhyc0hBKy9YTG9jb25YVjRQcEtXL292UlhPcFJk?=
 =?utf-8?B?OUtYZytsekN0MHh3NEZzSnJnc1dnQm5OSW05ay9sbWpqY0xiYW5jYkdoWC9G?=
 =?utf-8?B?OGZOWVhhaEdPVmhWWW1SbzNZRFVtNU1kWVJKd3lYSjYvYkRaVmRaTmVhMEtt?=
 =?utf-8?B?Y3JPRmlxVy9VY3FiTGI4WXZkYWhVNHc2RjVuSnZVMTVRMHdmUzRhUW90SDR1?=
 =?utf-8?B?NmxWS1ZGS2Z6blgzejdBTFM2cGd1NTZHd3c0L2RxNDdEWUM2dHVNTEFTZFVB?=
 =?utf-8?B?RnA2SEptV0UrSXpuUGtteWd1UEtwa3k1dnJyemhwaWtnZDlUMCtsV0kwZmZE?=
 =?utf-8?B?bHBCZnFxOFdrV21YRXhVbzRXQlRtSnFSbWVGVkRmZ2Rtemx4dURISmhxQ3Bt?=
 =?utf-8?B?Nlk0Nkh2RkEyT2R0YW0zeFcrRVNzWWJtTzRiY0pSNmZXdngzaE11MFRWRzBi?=
 =?utf-8?B?ald3RjRDNGJsaGpwVUVZbUwra2UwbXZzYTlySkZkNzI1Rm1TWmJhYzFGdVNW?=
 =?utf-8?B?M20rdktNbVZYdGUwRWo4UGZzcklZTEVrUnU4WDlYRlM2NnFWZHJUbll0STRG?=
 =?utf-8?B?UStWNlh5a0tFREpqR1hSaElOZDd4eHZ4TEp0ZC9aeGhVM0FaaklZNFF2MGUz?=
 =?utf-8?B?eVZrZEs5WDYrS2laVzBVTjBQaktSSG84MUJHNE5kSmhPZW5pQ2ZEanQ0SEI3?=
 =?utf-8?B?LzduRU50enpHRXh3cEVaWHV5dnozZTBSVWY0QWpNN0dDazE5aUJXVHhpTUVk?=
 =?utf-8?B?eWJVSTNCSjFkRGVja1pidHNRMEZwTS9FdzRKVmpicStxR1cwNjdpTU9FMERv?=
 =?utf-8?B?d2NyaWlXZnp4TEMvSjRBdzVzL0lVT3FmNzFOaFg5UHA4bU9yblpFSlIwQVBp?=
 =?utf-8?B?dUJUVUxOcldrRFA5MWdiMWN6djI3RVF6YmFYaEdWMUcrYnVBT2tXZXNMc2xx?=
 =?utf-8?B?UDJVWXJCSGttRExVeS96OVkySzIya3dFSmcwVk5uZVVLZm9jMTlXekJvQnJE?=
 =?utf-8?B?dDJWOTQvSXRwVWhFVnZuTkFKOENnZ0g4UEIyeWExVjZsamRwNVV4YmdXZFFi?=
 =?utf-8?B?dlVHbkRUWmFqbFpmZ09sY0ZXajFmSFhjRE5FM2dvMWYvLzBJeHp6TUFOSWFK?=
 =?utf-8?B?NldyUS9RcVJJWEl6bzY1MmdoVUU4WXJnZE0yS1J5MTVLMDZvQnVJZ2NBc25N?=
 =?utf-8?B?djFibDVFRkVNUlRNdnU3bkYzRzJyV3hiV0QwbU1WclFHc1pjZ2hZdDN3TW1P?=
 =?utf-8?B?MHc5N2VDWTNDeDNVb2t4MWdZM0tmUHRRYWx0K3Z6VmpSWWphK1JDaUtYVkl1?=
 =?utf-8?B?N0xkM0RiV1JlZFFzY3BtVUJHR3VEOXRSdTE0QXAzb0xaQmdlNkZGWVN5TFVV?=
 =?utf-8?B?QkdpcVhycWx3bXdKR3JIMjVDMXJMN2pXeHNaTFI5WHVJNkFSWW53MWd4WjBn?=
 =?utf-8?B?enNoVS9WMStHUGpKT280SmJmQlMyczYwQ0RVY0hiWDZoNjZGSEE1RFplNy91?=
 =?utf-8?B?Z0FYb1E4emV0UzYyUnhObmtHMGN2NWRMTkNuWnRMR09UYjVjbDVROG9DaDBs?=
 =?utf-8?B?R2ZkeUw1cWh3NFBRWXgxT0kzcU1nNVFKQnVHL0UzMWRlSWF6Z0YyVm8wWTVn?=
 =?utf-8?B?QndDM2ZvTWprSXUveEE1UXk0U0NXNDZTSW1QUHAxa0kvNmxhT1dlZno5bmNR?=
 =?utf-8?B?MnRnQWY5TVVzelVaTmZRQ2VpOGh1U3dmajZYU1hjZU1TQTRNU0ZYSjFTRmtK?=
 =?utf-8?Q?t9peUgVM002zIA2KLoyZ121RrG5Q5XfO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JxSDdyajZQUHBia0JnRXUzRDBjK2ZWUWlkWkNscC9sVGpIZStoK0RDbzhC?=
 =?utf-8?B?akcyTEJxSGwzN0NFZncvOExPeENqRklSMW5tTmJ1WW5mZGNpbFB5ZVJYUFFi?=
 =?utf-8?B?T1VRWU1ycWxyczJYWXQ5NkJBRDNTcXVOWS9MNGxyRmJDaUVpR2ZyZ3l2MHV3?=
 =?utf-8?B?YUxHQUgya2tuZE9vNy8rcERON0Y2ZHdEN1ZmN2c5eEtIS3gxMngvMlZqM2tI?=
 =?utf-8?B?cUlrUUlJbXZwdkZ0U2V5Nkk4bWxDSEUvRnBiQnRuUlFpM1FiY3pYdmdwT1Qr?=
 =?utf-8?B?TUs5aUh5czdLZHhiQXVNT3BUNy9QSWIzSHZRVVliOEpMZkUvSGtGZC9vU1lr?=
 =?utf-8?B?SWNXZnpJSHB5bHJpSUFmU29ZcFppMHE2OTVrMFpNVVpwMjdRTmVaVnNiRm1C?=
 =?utf-8?B?NVlsL2NrV1FvaGRubEsxVlAyTmVManN1cUsyRCthc21pNUhLQktwK29iNDVl?=
 =?utf-8?B?L2dKWHUrVlk2RWJOczRKa3I4a0E0TVdnblltaks0UzVFNDYzN2ZtSGxPaUln?=
 =?utf-8?B?TnMyeU96WW55V2FDL1VGRDVRam95RGVGR0NJWGNpQ3pVTzdVTnh3bldOem4y?=
 =?utf-8?B?THNkdzN4Z2FlTEVNMEJOd2VLZ1JpQmJ4SGhaV1dlZFBRMjREMXBIblAvTVds?=
 =?utf-8?B?emcvTGVhcGNOenVOeG5pR1JXekNMT0F0UnBKemYxVENWZ0JleVhmM3h6MVNx?=
 =?utf-8?B?YmNoK3JRWXd4aWMzZFVuWXh2YTkvS2xuNlo0ZldsRFgxdVRWUWU3WjZXaWpV?=
 =?utf-8?B?amlQZ0ZoNy9vemhOSmdqUlYxUkVhTjhjUWdQQmdXTG9lU1EwNVhJQUFIVEN2?=
 =?utf-8?B?VUFmOXhQQ3pTSEZCaUhjQXJiWUsvR1l4a3pkTlhpbkRPY1hQV2NWWVhVSzI5?=
 =?utf-8?B?eFVybHprS0VmNE5FVGdwL3k0NmZqUFQrS3hCanNnNGRnd284YlV4cmhvUmk5?=
 =?utf-8?B?TGNIY2JMQWR1bGQ4aHJEVHBsTk9LemxmU0d3K2ZKdTZvelgydDB5Rjdwc1Na?=
 =?utf-8?B?a1JGdys0aVkyUXIreDVTbyt5aXU1Ti9XVTQxUk12SHhOWVplbkJXNUlMeUhB?=
 =?utf-8?B?aUFFTjh0c09rSUw0a0VENlY2MnVZdlVJYlBpLzg5RFZXengvRWpMaFJGK1p1?=
 =?utf-8?B?NU5aME5NeloyOWNiazIxSlNYUmlLMU1rcEVwdVU1bWR1SVZkWVhvVWhaUFV4?=
 =?utf-8?B?bVY1WHlrY2dIdE9aNDBoYzFGUGZpRFdvYk5nTUZNV29DZ1JLY1QvZkpseGtU?=
 =?utf-8?B?NXIyTnpPVFhwZFpnYU8xL1pDVmdSc2RRL2pmdTZQbkRrWFF1b1JWZm0yU3lH?=
 =?utf-8?B?aytUc3Y5QnkyYTd5anErQ0dpMm1pMzExOCt4MUUrdUVId095c1pNQUtxeGNG?=
 =?utf-8?B?dFFpSVJZNW1KQkdMVzhRVm1Ta3N2eXhZOHdCQS84VmNCeVN3SmtCNTdxNVFr?=
 =?utf-8?B?Zmt2ZnV2Y1ZUYnpmQmg1aENUTDBjSVhSQW9CRWh6eGtTc25IclVZRkNUTFBk?=
 =?utf-8?B?MXFKejdVNzJsQU5MQXpKRjNnRjZURldVSk8rQkovMS80MG9JS2IrU2l6L29E?=
 =?utf-8?B?dnhtTnJreFYyb21MWWJRdzAyRTBtSStyaDQ5ZEwyUmxtSkJrL2ZBUEo4T0Fw?=
 =?utf-8?B?TUZONE1iUGFlU0kxalVNaUpwWHFVUVlidDEzb0IvWnZ0WURrSjJBeUcrUWVJ?=
 =?utf-8?B?SGRHQU9SaEtyWUF4ajRZeGhzeFF3c3dwMTJuVSs1dithS3VQbnFMVHZBNjc5?=
 =?utf-8?B?OEh5Z1diK0FBTzlMRkRKaldCWjVGSUswOGlWclRURXBhdGRCWm5lR1FUeEJq?=
 =?utf-8?B?ZjZJekxrVUx6RkFyTUpMdmNyNkZKT0l3UTByeXI4a0ZacDYzQjA5Q0pzc0g0?=
 =?utf-8?B?VERWeVptVVVvUXNza3duUVYxRU9ncTdtVTNnM0hGNGwvaEUxeWcvSkNibmds?=
 =?utf-8?B?dDlWWnJRTzdWWVRxWjArQlVlbGVLZmNRS3BqR2hvOGhuYXNIK2pUZ01GWHdu?=
 =?utf-8?B?MG9WNDFWVStDSU04dDA0WnNLeGJJejNZOURmR1dwaEdpYmgrMEZsTEZYQmpS?=
 =?utf-8?B?alhYUkNaZW1ROXBWZXdGKzgvNTI1czVlYi9EWHhiaVJRNHhKWTlHODErcnhS?=
 =?utf-8?B?aXI5aWZUWTJyZTBPZmlnRkF1SVVNZ0lUaytnSVEzNjRkWFVCLzA0YjdLdHBn?=
 =?utf-8?B?SmlYQm85U0FiK3FkMGRjQTRrRmo2UFN2M3pqL2pBSWQ3YTluKzBRblRsWWRY?=
 =?utf-8?B?NjFtb3pEeHljLzhIaWZ3aWc3d3VsK1BFWWhGVFB1VEdpZTY3OFB4ckpUNkJC?=
 =?utf-8?B?aERaWUgwM09WdlJQcGhzeWYrSDY2VzBkTjFhQVAvUFRrbi9mVy9iQ1BoTGpr?=
 =?utf-8?Q?4TSWD+Bm/Ks0kX6g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d5ac11-0910-4aba-90bf-08de5287a6ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:39:31.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IbrcPC5KMu84pp9OF4oK0P3oJz+y5oRmjQ7z7cpX0jnJgLS8hTuJC7Tdahh2ISWI65SQOIUVJFxuN7U1cXAnQJaslLBXC7eqow/BR9gN9c=
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


On 1/13/2026 3:05 PM, Neil Armstrong wrote:
> On 1/8/26 15:42, Julien Stephan wrote:
>> Drop the ftrace like debug() that checkpatch --strict complains about:
>>
>>    WARNING: Unnecessary ftrace-like logging - prefer using ftrace
>>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>   drivers/power/regulator/regulator_common.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/ 
>> power/regulator/regulator_common.c
>> index 
>> 685d8735fa5c9a6f98cb6154cd13afcabaeab1ac..ce3d80670de045dde7e263c5301bccd744abd2f5 100644
>> --- a/drivers/power/regulator/regulator_common.c
>> +++ b/drivers/power/regulator/regulator_common.c
>> @@ -98,7 +98,6 @@ int regulator_common_set_enable(const struct udevice 
>> *dev,
>>       if (enable && plat->startup_delay_us)
>>           udelay(plat->startup_delay_us);
>> -    debug("%s: done\n", __func__);
>>       if (!enable && plat->off_on_delay_us)
>>           udelay(plat->off_on_delay_us);
>>
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Tanmay

