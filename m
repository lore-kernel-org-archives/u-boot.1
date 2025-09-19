Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD8CA1013
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 01:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1250D8319C;
	Fri, 19 Sep 2025 03:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EWJ8CnAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013E783281; Fri, 19 Sep 2025 03:45:28 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A761381E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 03:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEC8jIcnjhLR/JxLg/wtGrbwdsAhinGFIQovegfbjtSpqySi8fOmVhaYhB+r38sLRfF38H0qHXfrVwvennfm3wEzG59J1aEeIhjShyVWYMVrwZWZF4s/4u3QYJiiHUwuv305V8oVXY65nmTAWrh2vQZmY4Z1BdbE2ogcktEdf3IDOoTuXzBNIYHTaNMhmsSQYoszCvI2I6YnepgkxaZ+C0V9HTVvPp6Lpp2Qf6ZmhV5TtOEoryn31Gwl0VQbZhDUUiSZxbGaxWCVVKItHVH9xLJvS0L/mlJcmoWxo0fb23oDIQIXzA/ztiKYasobFwMETjuWYllAUnoQ8K1G/MW1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKM+cy3HPSHOByOOpUd/T/5c2Cp5qkm3hTmdyhqknIU=;
 b=xkbPmnTC/SqdRs1vN5WJkYzrvGYAFB3VsOgRJF8bkEYWBHs23UYKcHsK9BSVIT1NC0ZWNUZBAjMOSpOfz//CFofXW2cOusBSdqdZp7ClZnZsyaGwF37RagF9U2rtXmn3qVxPhQZkZQDlB3JsKChDsBhXykVZ4cVBv59Jr00EUZ0R2BFlD2omfxZ+41odKeSIt5WfaT0uS/ZzpJfUX+SOkgKu48DvQmNcA+foQcnHSkNRkuJDOPHwRLr4NIhiFDfF1A+XmPAp3s91XcgQ9KJVSaSqh8yxz/PvNV+5nwa6igVo6j/FBQlM73LqXav2rCww6q8wsTEa9gCIjxf7ON2GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKM+cy3HPSHOByOOpUd/T/5c2Cp5qkm3hTmdyhqknIU=;
 b=EWJ8CnAPCArwyghfgeY9MRuf37HUssvFCjXCtlUeD7yJRx98yenRFgqskMwPvzYxixo+B4PMhDVf8pyqdf2clNpWIYtllIgu8zHmBvoAI6pqSLzIwZ2npJppReF34vEjIoHYcjr7cs1gfXfdf9zeDvskAYm6EAnhkdYvrxOu5n2hqGfFJFb3jwLsP9rvsnrmVweJR6Qi5nXror5BWRPwUEGXX9FFqSvUZhNZFMtudQmpBsoTR17Kmgza7xwNi6eRARH6x5fdEFdlNagXDmQMpeuh784R81kRyhriZkIg10Jj4iuvSaWeBQYmg5B9xbkVdJCY58md2DAdg/GTtZJS1g==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 01:45:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 01:45:21 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIHVzYjogZWhjaS1teDY6IEV4dGVuZCBzdXBw?=
 =?utf-8?Q?ort_to_i.MX91,_i.MX93,_i.MX94,_and_i.MX95?=
Thread-Topic: [PATCH v1] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Thread-Index: AQHcKHmWbfAQVFNu80iaC2h+uqun1bSY3IOAgADf0sA=
Date: Fri, 19 Sep 2025 01:45:21 +0000
Message-ID: <PAXPR04MB9644E58E169A43580389C52EE211A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250908194649.3645232-1-alice.guo@oss.nxp.com>
 <c7645818-d51a-4fbe-8f4f-185429416e61@mailbox.org>
In-Reply-To: <c7645818-d51a-4fbe-8f4f-185429416e61@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA1PR04MB10170:EE_
x-ms-office365-filtering-correlation-id: 94c47f1b-cb21-4db5-6d5b-08ddf71e31bf
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YkYyUGJIVGQ4UTZYMzZUQWRNb2UvczBRMUlWWDh6QWI0eHg3Z21ta1B2eU4x?=
 =?utf-8?B?NERZWjk2T0g2WDVOZnFyejFzV1VrUkhNamtwNHVmL3hYU2hEeWtqMHVtQzQ1?=
 =?utf-8?B?MngyYmNRdExWc3U2SEdQRHVYZ2VuMDFJTGNjRlZHMVpnek5TZHdmbys1MUsy?=
 =?utf-8?B?ZldDOGhBNmZNK0IvaXVlbWh0N2VtVVdNZkxsT01jVGs5dE92aWVvaURPT2V3?=
 =?utf-8?B?RHpnd05mVjh2cHNUaGQzYm1adXR1K1hJamdNWkw0QnZVZm00UEZSMVdadXBo?=
 =?utf-8?B?RDkrQi9tbUpmQmIydzJocXQzZldHWnRHUHFjdkNVVUVBT3NMK1NNd25qbFFO?=
 =?utf-8?B?TGlFbGxXd1g0WW1YMkNYMHAxSlZkekJTQldHMEoyYUVxUDc1RnVNYVh6K0Fy?=
 =?utf-8?B?YjJIUDJTN0JKVGhXOGpyZG03eEhJNDRITjR4Q3hOUmZldzNsZ09SaEUwM2Fz?=
 =?utf-8?B?cVY3NFFlUndEekZiQlRuVHNjSEw0cTdseFBsQkUzV2M2U21wUm5tcVp4dk5P?=
 =?utf-8?B?YWt3WDEzcDdCVUxMTU9yQ05VYTlYZE11TTJLOGhPeERkcFZ2WUhhYmkrcDJq?=
 =?utf-8?B?M0sxMnpaOFRMS0FWMG42MFluWDRVZDRCekVOeTgwVS8wYUM2U0owbjUzaVgz?=
 =?utf-8?B?N2h5WCtUTEgybHlCY043YTZWN0RnMUtSN3k1UUtsaFhyb2l4Nnd4R1BYRXZq?=
 =?utf-8?B?RXYvWFVBU0d6OUx1cWViVEs4am84UmNoREtGbXJQL0pzRDQ5Z2RITFZOYm9N?=
 =?utf-8?B?SXk2c3RLd3h1OXBPcW8vcTdVN29jRXYvWFh0aGwxUkNZa2p3SFZvQ3JicVcv?=
 =?utf-8?B?aDNxZE9NS0pOUHhqck1mRUJLaXB2bktCUy8ybyt6RU1BTTNpZjVGSkVCaUZy?=
 =?utf-8?B?YlgzZ05yeTFCV0grWEdDbHdFN0JFWGgyMHVmZjZCMmxCYmFiY1hwR3p1VW5U?=
 =?utf-8?B?dWU2UnhoSXQ5ZXpOSmZOL0IzWFRHWHJkcXVDNVhWVWwrOTkrRDNJNTk2d2xp?=
 =?utf-8?B?NUorY3FJZElnSnFMRG9SOUZOM0I1K1hSRFVSeHJyQ2JIOWlxV0ZubjUyTHNq?=
 =?utf-8?B?ZzRHM2E0LzVMRjdCbHNqT0tUYlI4V3FBWkdqN1RVajJSWlEyZFFaK2g0UUoz?=
 =?utf-8?B?a3h6ZHJUUXAxOGlCWExDaGcwc21BTVZyMXNNaEZTMS9aNTFkRGxrSnhYSWY2?=
 =?utf-8?B?U0pGVGVQa3o1bW1tajZDWmRLZjR2ZFpoZkh6aXFDZUZ4WnV0NXhLaEU5cU44?=
 =?utf-8?B?YkM1Ym5Db0RoaUxFY1R2SktUZGJPVkNPaFJDTUVGUjFsU0ROUWZTRFRzTTU5?=
 =?utf-8?B?TUlzQlROZ3REanRvS1h4MjFOQ0llYkZ3blJuWlpDUGNzd1o5Y0lOSnJzelJ5?=
 =?utf-8?B?cW96RHp6Y2VLYU92cVVNUEZmbHgwbjJRYnM2YVAxcDQ3Z0Q3eExtNEdVRlZk?=
 =?utf-8?B?VmVvUzdFaFNIVmFSUnRnV3MzUDd5a243MnZSSlZQNkU1RW1XaXpqLytKS0VY?=
 =?utf-8?B?cjY5Uk5WM1NmTDVMd3lkSTMrSThCbk5xN2t4a2xGelBIWlB2ZzhGK0F6ei9I?=
 =?utf-8?B?dU5JTzhBTVUzWkJVNUhibkZQVkJ0VnA5VnVMS0JxbUF5YmhVNWNLNUhpbWs5?=
 =?utf-8?B?Y2dlb2RhNnUxV0ROWGtDVlJrbmxxMEh1TTFBNUx6QjQvM1JyOXdhZnhCbTBl?=
 =?utf-8?B?N201azdjaWNKdGRiYU9XOFNYZ21abjFRMms5TW5RMlIxREZ1ZDFsTGNDVk9Z?=
 =?utf-8?B?eWpaM05HWUUwOS9MQTRieHlnUEZSd2hOVW13OFVYOFFrcjRnOUU3YzV4c3pI?=
 =?utf-8?B?MW14WGtNT0QrRjNvaWpNeUl5Y0taV3JXaFFWMUd6eVl1T1Jlb1d1TW53M1V1?=
 =?utf-8?B?NWhTYnBKOExTQWZoZEg2Z1RrNHB5K1MxZm9tak51d0NSTmovNmx1Qk9QRUds?=
 =?utf-8?B?WmxiSmtmSTZjT0F4OURDSmh6Sk9iS3BMRmljYTVadGQwRVBqZzNXWWl4cWZZ?=
 =?utf-8?B?VnNaaTVhWXNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnFDOGtzb3F3R2UxenpBM25XblFyTERneTZWMWdrQjZNY2NvQmdHbEJrU1Iv?=
 =?utf-8?B?UzR3cSttdDhrV0w5dmdLTTU4SGR6SGtHdkFkVFIvbWRTSTJydGNTK3h1akN0?=
 =?utf-8?B?ZU1DZHd5VmlIQzF5S080L092M1pCMDUwT0xrM1Z0cnFwb1ZETDFaZUJSUnVS?=
 =?utf-8?B?ZjlGU05UQTRsR1V2TmdnRkR4bGpkekxrbklMM1RRaHdGRFN2RDE4VmM4Z2N6?=
 =?utf-8?B?UFBzcDJ4aGJ4YkJRNXkxWjBHTEttVlkrcFRwNUg5emxIS3d3djBDb3hYNTFY?=
 =?utf-8?B?WU9lYWxlMzd5ZmxqTWR5b0wwNXB3Nm9OZDYwVGlwdWF6R3owSkwvc05YcG8w?=
 =?utf-8?B?d3lSZ3VtM0dZYkJ6dGV2ekN6eFg1RmxKNWh0WHJ5dmg4Qmx2TzlnNTFvWUxH?=
 =?utf-8?B?NDJlSytLekp6dExsMGgwdGlKRWNCMkpBTEdiUXRsV1Q4bXJGaU1pemowOE5V?=
 =?utf-8?B?TThDWTV2SDJYaGQ5bGJKMEVTTWxwR0pZWnVrWkNBVFd1NlFHZU55TlU5RG5H?=
 =?utf-8?B?YzBCMHBaMnFJbHhlL1RhN2JmRVAxV2YrMTN2Z0o2Z2F3QW5kZ1JEUllMR3Aw?=
 =?utf-8?B?VS9JUy9IV01hK2FCOVh3V3ZTUUpkMmhhMzh0TjZQcTAzWWJrSEZvVTBZZ3U2?=
 =?utf-8?B?K2xBVGh6MTduV2Z5NkxmdzNDWHl1ZTdnd2NpQWxnWWRZcHFzRkNXM1hiVk44?=
 =?utf-8?B?M3ZBVzY5MW9VdFhQQ2RDcGpGMEVEYXE0NGJWaGZBdkNyZmhWM2xUc3QySDdS?=
 =?utf-8?B?MVA1czR6M3JtaXd6VkUybU4xV1hBbGFnOUxROFVKOEpqYUZrN1pPdWo5ZnY2?=
 =?utf-8?B?cGREakFmMzAvMmFOSkc0N2ZFYnhwdHNZdXorL0tmUFJ2ZFlUaUZGbmltR1Y3?=
 =?utf-8?B?SDRYMyt5dy9XWUcyakxWT0NnVWF3QjZ5Q3M1MTAzQk1tR3pNK2hodmxpWVFM?=
 =?utf-8?B?K3RJOVFYR0xZY2g1QXhWRXJ4b05jdUVabXdyTXBBbGlYQlRxdmpmMEUrQ0h2?=
 =?utf-8?B?c1d1RW1RVWIzZ0Z2YXJSZmczNjQxOUEzZ1lSTFRhWGI2NnlLcSsxRTQ3emNn?=
 =?utf-8?B?Nk9VdEczOVhMSTl4YVJlZUtCVTZBd0ZZSjlJa3ZUaUV4dDJoeW52MlljdUhW?=
 =?utf-8?B?QXhTZnBUUE81T01ic1JOU0llVm84WjJnb1JiUEJUS3A2ZU01RGlTTzB6TW1w?=
 =?utf-8?B?SmhKeVN4K3hZYVl4MmV5RlAvWGVtKy9zc250L0x5TXJ4TUpTTkc0NUZZeE5v?=
 =?utf-8?B?ekN0dHhKQ3RDdUxLczBhbmdGUDRoVWZocGZjRzBNRlp0K0RKWTZRajJDZEZG?=
 =?utf-8?B?QkkwcVhWRXEwWmlmbjRMNFV2cnNTZ3A3THFSTjk4cnlKd1RRc2tDWlQ4QjUr?=
 =?utf-8?B?TjJScytiU1VGQjRBSmtIc3A0QStYTmhPRFptcHhVRU9VS0FibnJLOE5raGFs?=
 =?utf-8?B?SlIxbkhlOEdsbGJUVjFiTUExWXNudDNzMVNxWnNuYjFsS0Y4blZSNkFZV3dt?=
 =?utf-8?B?ZXZWSGhUVXNSbHpQc1lJT0xaUXpRY1hzcWhwT2h6YmlyUTd6eXZ0U1FYVm1u?=
 =?utf-8?B?eUQya3RQMWl4TnJiNmtaUTdIY2pWVk9vQ0tMd00wQnV4cENFNmhZMnRFRE94?=
 =?utf-8?B?VkV1eUxGOHZlUHZQSG0rNkF2TVhuQmsxMzlpZnNKbDBZckdiQlp1YzhOQlps?=
 =?utf-8?B?WksyOUR6MWU3bUdPVitCR3NhZkJXOWlmMGgySytsQWxNTWpvcHNWT0o0YXd0?=
 =?utf-8?B?aVpQYWJwZFM0aHRYNUd3NkMyQUp2bTY3WGc5V1d4Uy9mYk1hWWVJdnJzWHB0?=
 =?utf-8?B?ZFI5TlVzeDRaWk9BeHBUNXk4UWcyOFJyeUk0QUtjSFRqeGdSaUZwb2x2RGZm?=
 =?utf-8?B?c0JDSHBoMkNZN0V6cmltbld3bGlxbjBwN09aYzNqOWk2U3RKNmpoOExCbnpW?=
 =?utf-8?B?QlRsOE8xRXgwa0c4V1k5RjI1alcwWEUyRTk5SXNFeUNYd1grK2I1M0lwUk42?=
 =?utf-8?B?L09pNjRRMVhtWHphRGR6OXdsZ2F6eVhER2RsNnRiZTFIVW04T3NVcktIMnRS?=
 =?utf-8?B?SGlmY0Y3ZUdETThpT0c3TXBzWWV2N3FoUk4wQUtwcjVlWEFEQ21aVGVGUzZO?=
 =?utf-8?Q?WT1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c47f1b-cb21-4db5-6d5b-08ddf71e31bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 01:45:21.1636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hNe5iDdydHDGHep47ejV3KMcMCj8Rltw/sP048D8DyixlWbh6C55X1tT11nrdltJ5qOjImx38UpfRiKgyrF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ55pyIMTjml6UgMjA6
MjENCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47
IHRyaW5pQGtvbnN1bGtvLmNvbTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBBbGljZSBHdW8gPGFs
aWNlLmd1b0BueHAuY29tPg0KPiDmioTpgIE6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBZZSBMaSA8
eWUubGlAbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6
IFJlOiBbUEFUQ0ggdjFdIHVzYjogZWhjaS1teDY6IEV4dGVuZCBzdXBwb3J0IHRvIGkuTVg5MSwg
aS5NWDkzLCBpLk1YOTQsDQo+IGFuZCBpLk1YOTUNCj4gDQo+IE9uIDkvOC8yNSA5OjQ2IFBNLCBB
bGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4gPg0KPiA+IFNpbmNlIHRoZSBFSENJIFVTQiBkcml2ZXIgaXMgc2hhcmVkIGFjcm9z
cyBpLk1YOTEsIGkuTVg5MywgaS5NWDk0LCBhbmQNCj4gPiBpLk1YOTUsIHRoZSBjb25kaXRpb24g
Y2hlY2sgaXMgdXBkYXRlZCB0byB1c2UgSU1YOS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFs
aWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8
bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+DQo+IA0KPiBBbHNvIC4uLiBhdCB3aGF0IGRhdGUgZGlk
IHlvdSBzZW5kIHRoaXMgZW1haWwgPyBJIHJlY2VpdmVkIGl0IHRvZGF5DQo+IDIwMjUtMDktMTgg
Lg0KDQpIaSBNYXJlaywNCg0KSXQgd2FzIGEgbWlzdGFrZSBpbiBteSBjb21wdXRlcidzIHRpbWUg
c2V0dGluZ3MuIEkgaGFkIG5vdCBub3RpY2VkIHRoZSBpbmNvcnJlY3QgdGltZSBiZWZvcmUuDQoN
Cg==
