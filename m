Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B42CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7FB8412F;
	Thu,  9 Oct 2025 14:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jA4VkjHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FC7844EB; Thu,  9 Oct 2025 12:16:20 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCC4844ED
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD7K/SNV3pm1YBce7qOJ/IrYNDZ7cWWCVuBcT8ceBkWtZeoQWmnNXr8mv5ksbkuYxGKu711VPSRgFSDv62zRPzUQ3k+ialISNXX0DiWILIcUQ/JrO+sd4ppa5zdu2DQi8iAQ536GtEIjC38SlWz9kSxzJEwmMw6IVjfLVE1oWGQM8HW3BlBq9BkTz23Rogx0cg4GLCWzMEVTUlvhVhR/9GqhygrAh7QYSjN/oXXeuGDAF3SRYRNbIpr6WoCBz6bijK9xcJ062gsfbfPFJOQbjTwn+r7leX1nZ+JuBa+UHvW0/rBGrWEYvqotbbfUsxBE1Q1QP21kZH8a8yn+m+MqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXBfgM1ZbyA6hHcBO3QQ2s8CUk5BI8UH+WBpCgO9Qe8=;
 b=RBeBqL2oKYFkFcKFKTgQZ/8SLTQ1aoMxiKjy+pmTXHn0C7vwqiVRsPnMa2YH3VXy0C4G4/D0OcDzSxyU5FKsNNMgGukaytHUcUfEJYL4YmlVupFheLWtDrd6sJDLR9gbafFWw9PAjta6lBjlhhQeCigfJBEbk38WzUUD9wCasqrkWNTHsh3x4RJ8WW90eWB23NJ5JMvsk2aLyDJcHqjZi//SIOmX7OrmLW3Ro0cK7HADntsPQ2xR7mHhV01AuwsNErV8jYqFejohwrBCfK2X5qZ9sqNmKX+I6LvdY65hWGPPIHGj/fi2r5NCayRl9C4rPxCDsuvDdlFZ5YvKQUmyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXBfgM1ZbyA6hHcBO3QQ2s8CUk5BI8UH+WBpCgO9Qe8=;
 b=jA4VkjHldFf3CiqxLuVOjKgBevB5FQ7EOptI6LxnYy9W74sT0/UhVIE7n/DvHlNqT95BCetALAtSfxyZ529PCocIFXBxSMfmMZ5lAeunKcOPOS355Xupzmzzpg0KTOmiVGMLFpqSq0vK/w+uH0dPMibbHCDD9mIHG+xDJgBkauVN1wLwiqSpG4JXiZxbVr3Um6nd/jgLy4iWM8bMAxcjbEljiuafbhqLomdf3fET88qYjswTjBiTgkcIfNmaHww+tBawj24awU3nSsGcxQBNofUKQW+1y5MeEBM6MgBI23+anpp/E01iJ7Xu1rw8D/bPOPcAwpuh1m3EFFk4qGiv9A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11239.eurprd04.prod.outlook.com (2603:10a6:150:27a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 10:16:12 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:16:11 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Troy Kisky
 <troy.kisky@boundarydevices.com>, Adrian Alonso <adrian.alonso@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0?=
 =?gb2312?B?OiBBZGQgZGVsYXkgYWZ0ZXIgc29mdHdhcmUgd3JpdGVzIERDVEwgaW4gZHdj?=
 =?gb2312?B?M19nYWRnZXRfcnVuX3N0b3AoKQ==?=
Thread-Topic: [EXT] Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after
 software writes DCTL in dwc3_gadget_run_stop()
Thread-Index: AQHcAHq7JAHAYgHUyUKTzLuOcoRaxLSqOkGAgA/Go4A=
Date: Thu, 9 Oct 2025 10:16:11 +0000
Message-ID: <PAXPR04MB96444C6DBBC329E515CCD9CEE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
In-Reply-To: <87a52dk5mo.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV2PR04MB11239:EE_
x-ms-office365-filtering-correlation-id: 3d7031e5-f815-474e-da84-08de071cdf27
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|921020|38070700021|7053199007|13003099007;
x-microsoft-antispam-message-info: =?gb2312?B?ZXNkZHhObjhzQkkvSEJhNkwzNzVCdElETmJ2SmcyN1R3MXJtR0dTWWNLcDBT?=
 =?gb2312?B?NkFxd0VMdmFOZm1JRFZBc0h3czlyM0NnQ1NQaDBXRzNkQUlrc1BsWXI1aXE3?=
 =?gb2312?B?czRGTW52cWtMUzdVMmpxK3RObXYzMyt0WnkzV3FTVCttWE1Uc0hmclpuYzkz?=
 =?gb2312?B?Y25neE1VS2p2cGRvRnVOZlhVWEdDczhlNFZEM0NHYTdOR1hIeWt5Y2p6eUJO?=
 =?gb2312?B?VHFLSTVLbTV5Y25iZUgvcXdjTWhBMkl3ei8rTFIzTnZ5Sy96czRwVFpYWFJy?=
 =?gb2312?B?aGdmTWdJSUkrdWhiYXpTYlI2MlZzWDhlWm1DLzdDSVMzaXJDL2ppWFdmZm1G?=
 =?gb2312?B?SWZPZkZjTGRNeWNMeDBxN09vZmVYMlpxM05jMis5RSs1V3JNWnYvQVFXcFk3?=
 =?gb2312?B?dkFORHlqU1dLdElTaEIwaXVQWGRWUUY0SEs1R01FUzdjYjdrekpHTFFnZmF3?=
 =?gb2312?B?dzlnc1Q1dWhwbmtCZi9CYnZMQTVNTjYrYy90MDh4S2JFQkdOSldoUVE1bWQ5?=
 =?gb2312?B?d2VHQkt6eDlsYkNLa3FJYzZCNzZSZUNQU0kzY0NlMUNoYmtBUHlxazBGS2dV?=
 =?gb2312?B?WmFuRGpJVUJlWHh6WGkrL1l5WEdRVlZkZlcwcmNNQW8xaDZvVFlsL1R3S0g0?=
 =?gb2312?B?bDdKNURnamJiQ0hRK1lVWmk1WGlDeU85MUR1ZHFSSkZZTmJBZFhTbk9VbXRW?=
 =?gb2312?B?c0Yra1ZZZE9mWnBQaDBmelBtblZvL1gxMVZZbEN2aGt2STgvSWU1VlJlMi9L?=
 =?gb2312?B?TnVZZ2RJaldrSkYrYXNGMXhkREpLR0kxQmowbnNuRmI2bzR4Ty9TaVVUSElM?=
 =?gb2312?B?dXBxNU1sOFZrRjdmNkc3VDdYZGZQTmFGWWJxWjRGV0Jka1FLaEhSNGh2SjF4?=
 =?gb2312?B?em9HOXh4QXB0QkRrOEZNNGViR2pMWXd2c01wVU5SWXJjTGpUakJXTWROdFBs?=
 =?gb2312?B?OVptQTlmaVUybnlwUngxc1BGWTlYRGwxQjdDQ2NOYVBFc2Z6cG9oRXIzSkRK?=
 =?gb2312?B?d2tDcXdRVzYwWDE1RE1uNDFLbXo5UXRER29zVmJYbkpjMHhES2xzdm8xbVNK?=
 =?gb2312?B?SE9iU1RpTklodkF4cjB4VjFyMjZmVkZhMWlVYTNrV05RbGpmaW1NUE41UnpY?=
 =?gb2312?B?NUVCS0xZaXlYRFRVSkFMcXRUbnFRZE55UjdGQVpreUkvU2w4OGNjbHlGOWdY?=
 =?gb2312?B?cTlyaW5FYlp0T3BkcDJ0bXFOK1NBbUM5aWZqazhITDVJUHhlR1J0ZWUyaU5p?=
 =?gb2312?B?UmtkcURIaVlqS0ZKSWdIK0MyNkMwMkxJUE9NLzlhaFlTaWpxUDNmK0M0b0Fs?=
 =?gb2312?B?cnR5dllVZlFRMjJPbUxCOTE1SFBrTXBzVmVranN1MXl0OWZMbHRLK1IxWEp4?=
 =?gb2312?B?Rys2dldJV1NmVVlBM2tsdFpyQUsxV2w0c01ZNXl6cUNLVjNQS1dIcUI5L0lN?=
 =?gb2312?B?RVEwRnJqTmtKdzVDSEh0cDR4NEFFUkZRNlYxQzQwWnlRWEZEeHVLN3JGdlow?=
 =?gb2312?B?a3BMQkJFYlgrRkhMdFlQcitESzhaaUFJekRBU0ZyOTU4SDZyaGNBWkZSTVF4?=
 =?gb2312?B?MStwb3hpckcvUGdtektmYkFxVUo5c1oyNHpaeVpIb2JUdWdBWWRrS01NdTRS?=
 =?gb2312?B?VkYzSmlGRzhHMXZoQnh4cjlBaklMOVF0ZEE4Qis4ZldDSmJzR21NaWxhQVhN?=
 =?gb2312?B?blA1czlIcWhCSW5FMFZHaGEzM0JpTlpDK3NGbjZza3lCa2E5NG5HN2pLaGN3?=
 =?gb2312?B?V3VjNVpzd0hrVXdXaE1nZTh2bzdkaFdHNDdvN2JhdkNZd3NualBQYjhGeVhP?=
 =?gb2312?B?eTdSTlJWMEdpWWEvektDMlNIWloya25qbnpaeklZaXlQRVFnOW9HSjYyMTY5?=
 =?gb2312?B?anRuRG9GTmxVa2tFQXhXWWpkc3ZhVGFVdTBzWWkrL3NSQVhEWCtrWGx5STdB?=
 =?gb2312?B?Q0xUR3lOOHk1enNjbjBTRmx6ZVVIb1pKcG5vdGtGSzRsTmJsM1VEZW8zQmI4?=
 =?gb2312?B?NkFZQ0hWNmxBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(921020)(38070700021)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MThpUnRvRmw5a2VqTEtsdHZMT2tJYlJBVFdnNGxBTXVTWjg2aDJCc0NxNldy?=
 =?gb2312?B?TUtMRmx3aC9uelhsZmZ2QnV3eXl2OUh1UVlmd3JNMkVQVkNUT2ZGRWQ1dEhq?=
 =?gb2312?B?NkJHTmhTRWpkak1xa3ZDNFBrWDAvQ3dPM3BXZDJENVZETzNIcmNOaFBJMzRX?=
 =?gb2312?B?cmdVWnB3WktyWjZWeHRyWlB4cHFRSzFFUVdaa3RJSEluL3VUcDJoTVRMKzdk?=
 =?gb2312?B?Q3N6Qk5CbUFBa1o0UXJtd2JPeTlObFd4Y0wwdnZwWnhjYkRuVXZVZXZHVTdM?=
 =?gb2312?B?UFYwNXZzOEk2dVJWQlcyYWQwTVpqU0U2TGd4RzR2MlRRRXQ0WnhwRVlFRE8w?=
 =?gb2312?B?SUs2bXRHMWU2REFsaDdPRFozclpNT1ZiQ3BtdEhwczIrZEdFbjR3NDNEdUd1?=
 =?gb2312?B?UXB0MHpWYzFwODZtM2Z5Y0QzVk9ucXdtQjdyNlRGVEEyTW9iVVRzbzdoLzRK?=
 =?gb2312?B?ckNpRzI4YnI4Sk9qNGRhcitPYXc0d2t1aFBFYVMrcnNOTlNTZ0p1c0l6STVG?=
 =?gb2312?B?WWFvOWxpcTVkZ3Q1R044UmFmV25Ed2QwaGgwcERxWUxsaHpySzRyLzBxcDdS?=
 =?gb2312?B?dGl4QkRIZExVRllLNUN4ZXpXbE40eXVlbzMzTEUvaDM2aXd6R09PZ0NCTUg0?=
 =?gb2312?B?SHo0UjBUdkNObXQ3am92T3k5YWNLMUdnRzRPQmZTTEJHU3JhMGpISVZsaUY5?=
 =?gb2312?B?NGxjcEtTVkNES0ZQbUNLcWx1RCs5S0R1U3RsQjJ6YmtiWnVrWS9oa2hjcXRJ?=
 =?gb2312?B?YWhmVndTT2JaYWgya0pVUlJlUUpwMktYQ2xVMGhRTi9yTHFTcWZaNkZLZjVU?=
 =?gb2312?B?R0RQSGl3QVRuVWlYV1ZPK0xKMTlvUWlYR2RTRVdYUUsrMzZjUWUxUjdWN25Y?=
 =?gb2312?B?ZFc5VU44cEFNdDgyb0RmZUE4V3FtVnMzL0xQcVZIcDl5Slgzb2dUeStFQ2h0?=
 =?gb2312?B?QlVsb0JGK0tndk1tTGFjTnh1ZzE0d0loWUNacTRRbjBNV2dlK3JncU4zMlFp?=
 =?gb2312?B?eFZMYjU1djBtRW5ma1g2RjlOZUlabUt4VCtzZTVyMDZydXlhOW5rUmVNK1J1?=
 =?gb2312?B?Y080NXVZcnpIYUI0SDllek1DeUFibGROWUpGaG5MNDlCeW1LZFRVZnROLzZk?=
 =?gb2312?B?UTVoNWZQQjdSdjdBM0NLRjNGRVVEWldlMnhlTkVwWTJmeUtMZmxIbW9OVUQ5?=
 =?gb2312?B?VlJQSnlNWi94cUdIcis5Y0RPUTh4cGo3akVxSm03dVVWY0dVdGM4S3ZMSVM1?=
 =?gb2312?B?SXRPeGtRZUd2UGp0YWNaYmJYd3A0TnpwQlkwdk9UNmhRcXRaV3F4d1BtdWNy?=
 =?gb2312?B?ZWtKc2VnY0tweTlNWU9kb3Q1cEVEbUFDSjZROWlrTnh4WVRnSGdKcEpKaUJR?=
 =?gb2312?B?RUZZZEhKRlRxWkJ1TTF2aVJUUGhreHpDYkd2STJPN3JjcU0xVWluNnYvY2F1?=
 =?gb2312?B?OW5lQXNtMUNaTlZpL2JkZ1lBaitDQWxtVk9JcHBZcnRlNEEyaEcxSVJtYmxO?=
 =?gb2312?B?TmN4U2t0aDlPdENEeFo1T1hETTFWcWt4aDcxL3ZlZWJ0cWIvbDlRcis1ZVZY?=
 =?gb2312?B?OGFnTEU0WUNldlRzanMxdU5QU2pJaS9KL090MHpUYk1Pcko5VkNtYW4vY0Y2?=
 =?gb2312?B?Qmc4MitDNVBBZUpHZjFhOUQxQXF3czRtbVZoVjBsL1kyb2FkN1VwUVFQWXFE?=
 =?gb2312?B?QlA2Wk5ZZEJzcCtBRmt4RkFSbXE0RjJJNWNheDhxR0RpbEdCK29rSzVoTVpn?=
 =?gb2312?B?Mk9lL2JBQVRmZTlrNjFoM3V6MlhCcGxzMUNURmdldzMwNDYvNmRxZEJ4ZUxU?=
 =?gb2312?B?YTl4dXg3cXQ2RHd1VFNKZU4va3BqdFkyWk1MbTh1OWJEM2VrZWVjMTh3SjZ1?=
 =?gb2312?B?dGNCdXl4aG5IYmdyWXNhbVBLcVFqSmU2UnR1K1ZKUm5Nd3lZeGhLbmJBZWZU?=
 =?gb2312?B?WHdYVFVqUHlTbXhENE9TVjBqZ2M4eUx4U0p3dzd0dlF3NVVmbVdmNDZQcE1m?=
 =?gb2312?B?VnJOSm93a3RYeXZpeFQrT2F3VzBTU0V0QklSeEJFbHo0ampQamsyMHNyUUhr?=
 =?gb2312?B?K2huWFlpV2h3TmFTNTdxRjRoM2ljaktYd011emZVa1R3Qlo4akk3UWw1b215?=
 =?gb2312?Q?PrKc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7031e5-f815-474e-da84-08de071cdf27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:16:11.7290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIjZUZdtoLHziIFQ9p33YsDdn1eF+0E9g5Y3rufrX+tQamyno2P/b6CFmjXP9okU4G5L2PiLxKwbk3A5DqQ13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11239
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29y
cGVyc2hvZWtAa2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjI5yNUgMTY6NDcNCj4g
ytW8/sjLOiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFN0ZWZhbm8g
QmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVHJv
eSBLaXNreSA8dHJveS5raXNreUBib3VuZGFyeWRldmljZXMuY29tPjsgQWRyaWFuDQo+IEFsb25z
byA8YWRyaWFuLmFsb25zb0BueHAuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRl
PjsgTWF0dGlqcw0KPiBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBNYXJl
ayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
1vfM4jogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0OiBBZGQgZGVsYXkg
YWZ0ZXIgc29mdHdhcmUgd3JpdGVzDQo+IERDVEwgaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKQ0K
Pg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBta29ycGVyc2hvZWtAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhp
cw0KPiBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+IEhpIEFsaWNlLA0KPg0KPiBUaGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4NCj4NCj4gT24gU3VuLCBKdWwgMjAsIDIwMjUgYXQgMDY6MTMsICJBbGljZSBH
dW8gKE9TUykiIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPg0KPiA+IEZyb206
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBXaGVuIHVzaW5nIE5YUCBV
VVUgdG8gZG93bmxvYWQgZmxhc2guYmluIHRvIGkuTVg5NSAxOXgxOSBldmsgYm9hcmQsIGl0DQo+
ID4gd2lsbCBnZXQgc3R1Y2sgaW4gYSBsb29wIGF0IHNkcF9pbml0KCkgd2l0aG91dCB0aGlzIGNo
YW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+DQo+IEkgc2VlIHRoYXQgYSBzaW1pbGFyIGNoYW5nZSBleGlzdCBpbiB0aGUgTGludXgg
a2VybmVsOg0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3JnJTJGYWxsJTJGMjAyMjA5MDEx
OTM2MjUuODcyNy00LXF1aWNfd2NoZW5nJTQwcXVpY2luYy5jb20lMkYmZGENCj4gdGE9MDUlN0Mw
MiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0YzBh
DQo+IGQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3
MzI0MjExNTg5Mw0KPiAzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXUNCj4gTURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lU
V0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDDQo+ICU3QyZzZGF0YT04QW80dE9tY01T
S0h0b25paVZUd1A0MEp3ZzU0bHozNDJLUDBKSFVLd0E4JTNEJnJlc2Vydg0KPiBlZD0wDQo+DQo+
IFBsZWFzZSBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdjIu
DQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuLw0KPiBl
bC5vcmclMkZhbGwlMkYyMDI1MDExMC1kd2MyLWRldi12NC03LTk4N2Y0ZmQ2ZjhiMiU0MHBpZ21v
cmFsLnRlY2glMkYmDQo+IGRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0
YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0Yw0KPiAwYWQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3MzI0MjExNjINCj4gNjQxNiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQQ0KPiB1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdD
JTcNCj4gQyU3QyZzZGF0YT1NdFhxU3VlTkFaNkdmaU94ZG50JTJCSDZJVVdhYkwzSkRlMDFtOElL
SnBNeTAlM0Qmcg0KPiBlc2VydmVkPTANCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4IDJiMDExMTNkNTRjLi42YjJiMjVjN2FhNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0xNDIzLDYgKzE0MjMsNyBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsDQo+IGludCBpc19vbiwgaW50
IHN1c3BlbmQpDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0RDVEwsIHJlZyk7DQo+ID4gKyAgICAgbWRlbGF5KDIpOw0KPg0KPiBDYW4geW91
IGVsYWJvcmF0ZSBvbiB3aHkgMW1zIGlzIG5vdCBlbm91Z2g/DQoNCkhpIE1hdHRpanMsDQoNClRo
aXMgcGF0Y2ggSSBzdWJtaXR0ZWQgd2FzIGluZGVlZCBpbnNwaXJlZCBieSB0aGUgY2hhbmdlIHlv
dSBtZW50aW9uZWQgaW4gdGhlIExpbnV4IGtlcm5lbC4gVGhlIG1kZWxheSgyKSB2YWx1ZSB3YXMg
ZGV0ZXJtaW5lZCBlbXBpcmljYWxseSBkdXJpbmcgdGVzdGluZyBvbiBvdXIgZGV2ZWxvcG1lbnQg
Ym9hcmQuDQoNCkhvd2V2ZXIsIGFmdGVyIGEgZGVlcGVyIHVuZGVyc3RhbmRpbmcgb2YgdGhlIGRy
aXZlciwgSSBiZWxpZXZlIHRoZSByZWFsIHJvb3QgY2F1c2UgaXMgdGhhdCB0aGUgVVNCMyBQSFkg
d2FzIG5vdCBwcm9wZXJseSBpbml0aWFsaXplZC4gV2hlbiBEV0MzIGlzIGNvbmZpZ3VyZWQgdG8g
RFdDM19EU1RTX1NVUEVSU1BFRUQgaW4gZHdjM19nYWRnZXRfc3RhcnQoKSwgZW51bWVyYXRpb24g
ZmFpbHMgYmVjYXVzZSB0aGUgUEhZIGlzIG5vdCByZWFkeSBhbmQgY2Fubm90IGNvbXBsZXRlIHRo
ZSBlbGVjdHJpY2FsIGFuZCBwcm90b2NvbC1sZXZlbCBoYW5kc2hha2UgcmVxdWlyZWQgYnkgVVNC
IDMuMC4gVGhlIGRlbGF5IGFjdHMgYXMgYSB3b3JrYXJvdW5kIHRvIGNvbXBlbnNhdGUgZm9yIHRo
ZSBtaXNzaW5nIGhhcmR3YXJlIGluaXRpYWxpemF0aW9uIG9yIHRpbWluZyBpc3N1ZXMuIE9uY2Ug
dGhlIFBIWSBkcml2ZXIgKHBoeS1pbXg4bXEtdXNiLmMpIGlzIGFkZGVkIGFuZCBwcm9wZXJseSBp
bml0aWFsaXplcyB0aGUgVVNCMyBQSFksIHRoZSBkZWxheSBpcyBubyBsb25nZXIgbmVlZGVkLg0K
DQpUaGUgdXBkYXRlZCBjaGFuZ2VzIGFyZSBpbmNsdWRlZCBpbiB0aGUgcGF0Y2hzZXQgdGl0bGVk
ICJFbmFibGUgVVNCIGFuZCBFTkVUQyBvbiBpLk1YOTQzIEVWSyIsIHNwZWNpZmljYWxseSBpbiBw
YXRjaCA2IGFuZCBwYXRjaCA3Og0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L3Vib290L3BhdGNoLzIwMjUwOTIzLXVzYm5ldGMtdjEtNi01MDdjZGRiZTcyMTRAb3NzLm54cC5j
b20vDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvcGF0Y2gvMjAy
NTA5MjMtdXNibmV0Yy12MS03LTUwN2NkZGJlNzIxNEBvc3MubnhwLmNvbS8NCg0KVGhhbmtzIGZv
ciB0aGUgZmVlZGJhY2shDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0KDQoNCg==
