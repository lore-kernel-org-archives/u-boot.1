Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF503C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 11:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2AA807B1;
	Fri, 13 Jun 2025 13:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jH8RSHAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419C380C93; Fri, 13 Jun 2025 13:17:16 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1C6800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 13:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKUg8XbmLj6FRDu9s2+UXpQZGjJTny9HT/aDx/XEMnntyTe1OwVT7SJdWd/OKaYSRbLr2d9LUNSSlRvhK180+c7URDnXS/CMCUq6p1pFNBbdVkcfA8ymtjqrMEt/fYmf4S+u5kAhB1Moiu4O+KlfXOdBaL3thtSzdRhU4iwAv4Fkj/uxJtGvF9j9/5/bKgNfNIzxWmOFX5U1SQUNO8+daUkoSoeYUCrY2OPPUsdG56Uzd/d2kyk5tvO8kLv0b+yAm+sGmksUUhpDqEVbvcrLJOkFcYQXGJyvm1K7fo0nmmLtyAgYZVDJn8CWGHijNRiKX16HfJU8R/U0a2ZCYQoT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ricqChZz3DBxq7NFTfxS3iwbxkeJZ3cyHbQMdy9NEE=;
 b=ao4cIOhdYPUzFkqG1q1zfFB4wLqG2ck/6xowMY2xJao/CB8dRoxxAE+M9DInoevi6Ysk9waljOf3YE5FTUjs+Yv42CyfbxGXFoI1I2b4lR9yoenbajeHfRFf9z5/NXXpIqfG5dFciMQsOftpZ4oDAg+SwgqVfKZKmzZewnNjNNKTWPf6RVcB6sFXZ2koYc/skq1/z2Cf6hi2rcfPxZItDI81LTDOxfHkT429d2KxJckDKyaysQeTcwEB9SSAmWxCZe+egLjowr31Z7UuZlRJhLFUPQnsgKnyApo8wA/N8GuvGbYs/jx6iTBWcTuJrWILWLof5ymccCig53tEE27iHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ricqChZz3DBxq7NFTfxS3iwbxkeJZ3cyHbQMdy9NEE=;
 b=jH8RSHAk56noSlLn1MGuUuRuOxARjcBlhIimVjC6gpQg4MmRBcL4qhMNe3RZPYgSlABz2UJJb3VZU9l9dvmgVKCHuxs4I/hYCMYJu5CV4oFNz5NCyCr0BlohSaa+wBrPGIE2hhu8CMolDVWE6YfFhnU6dGFutMUf9c7Anp5d4l837o8nKSBQTEVbKx1ZEHiAYn2IIok6hZNjZ9q0hqIntHn7rMpCjEXAvgzOZ4vogtPaG+l5pBZJmZRjvZewP1wc4teinG/soWC3G9OPzhQUlBurtI94x59U4XGaEoKcnUHqrBJqKQQkNWsQdWV68fawv1js/OIvgoJDH9TxiHcTPA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS2P195MB2456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:644::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 13 Jun
 2025 11:17:13 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8792.040; Fri, 13 Jun 2025
 11:17:13 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH RFC v2 4/8] binman: replace _entries with GetEntries()
Thread-Topic: [PATCH RFC v2 4/8] binman: replace _entries with GetEntries()
Thread-Index: AQHbzwqySCvLB00Brku/nSnc1gT/3LPrCwwAgBYASQA=
Date: Fri, 13 Jun 2025 11:17:12 +0000
Message-ID: <cfe4b70c26bc313a3fd24f2c13219be9b24b5634.camel@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-4-3362ab897581@phytec.de>
 <CAFLszTi2c4r1+E=ZJLsLsOxhZfL+syW3yWNHkAcipmD9SFyLbw@mail.gmail.com>
In-Reply-To: <CAFLszTi2c4r1+E=ZJLsLsOxhZfL+syW3yWNHkAcipmD9SFyLbw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS2P195MB2456:EE_
x-ms-office365-filtering-correlation-id: 8aae35f3-f4f4-4da6-3400-08ddaa6bd8b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGU0YncxR1JvaTVzNTcwNG12cFNqLzU5a1BaSUIrRURPbDFsclZ2cmZCa2dO?=
 =?utf-8?B?TVU0YWlZeFdKNWFOclR2VFNIZFdXUlJCTGZEUUR0TDU3c3E5a0ZuaVA0VW9z?=
 =?utf-8?B?bmhRYWxVYW1HcjhyUTRBa3RQb3A0VVRHRmZlendBc2pxaWYxdGN2MWlPRzJ4?=
 =?utf-8?B?WnpxQzFmdTBNMDZLbUl4cjVlY3JZV2xnMjM4aHd5cmZ4b3JjUVF0d0xlSEtM?=
 =?utf-8?B?RW9xMWdzYzFtN21ZWnQrZ2lWYllFWlFoZXBlODQvMWRsaTlmUkNLbGdnajlF?=
 =?utf-8?B?bzFZUkliYUVMVW9qWVZSS2JrZFJXd1ZwNE9GOGx2U1phcUhyMTRCd0dOa2g0?=
 =?utf-8?B?RVBZSjhMNlpGZGEzWFFPY0RQYVdUN3hMeVN3Zkd2UzYyMkg4T3B0TU9JUXZy?=
 =?utf-8?B?TTg1ZzZkbGdTTXU0ckxYbTdyeDBKakV1Vk5aTkREOUxOMXltM0ZtOTdpK3oy?=
 =?utf-8?B?YlBBUkZoWWlLSkZUNElBd3AxL1VKellkVkZuSHB0NnVSdW1XZU41b0FiT0ZO?=
 =?utf-8?B?QTBYZFBYUzhkUlVab2tMbys0R3VCTnpyQzk2ckVhRHdTbEQwa05MMHZhTmRx?=
 =?utf-8?B?Y2FVUThuaTNiUEswd2ErSzJRMUo0K0RUYlkzcDFzWUltT2xSSk1kYXVYTVZv?=
 =?utf-8?B?bW5adE9ObHhXNHlpZE44OFpQMlpGK0pBRGtPOU91ejgxUlB5cUdXeVdKbW90?=
 =?utf-8?B?TnN4QjRBT1JLYVVGMG40Q2JYdmdUS2lDT3hLN1Z6MnltWlNUM0dpdE1xVFpk?=
 =?utf-8?B?V0pQeFJnVFE2K0hjbWFKN2NqbmZVMnVyRnpvaStpZXRYOUlIOHZjV2MzWm45?=
 =?utf-8?B?Zk9WZGxyOVEzNmRRWUYrcFNwakdTZ2tKT2luUE1mSlpQSkxJQ1dqNlMrTHoz?=
 =?utf-8?B?alMzZHI1TzkydmZYZkszVWhYSm9yY2dMWkw3b2dOZmp2QU84SHQySXJscWNW?=
 =?utf-8?B?SHp1aEtlejlHWFArc29KR2dBc1NVRnBnZ1p0Q2pJbnVTU25WU2c0RmNycmY0?=
 =?utf-8?B?QmdraXdDTGplSXpEMmI1cGc4NU9tQjZhd2JCTDgzd1JzZjJCRXFISFJNSnJD?=
 =?utf-8?B?Q3ZPemdTY1ZLdXV2OEh0Rk5xenliZHE2VkpYT0IweHgxemllQnhCVUllN3F0?=
 =?utf-8?B?aDlycWRZQzErZDZCWHVFTXllQlBqYzcrRHp0WkRaL01mYmQxTmJ2STFtVEJ6?=
 =?utf-8?B?bjlITFlKMXIrTWtzR1p5SjFqSStnTmVpeHc5dUt6M2dMcUNYUVJteEx6bDc3?=
 =?utf-8?B?Zlk4Z2dyRVQyVFhKd2ZwRlBMUlNaTUNOQmp0aHR4c3dzdWhMSkRuRkd4Z3Js?=
 =?utf-8?B?NkhKaGVyM29JZzZHQ09vbC8vWldYV2lDaHBvL2lvUjA1WTFTZEhYYklKZnA5?=
 =?utf-8?B?R1g2UXN2M1NlYUMwOW1vTUVwV1FxZUpBZThMR0dVZ1lKbE00R3dOa0ZYVldM?=
 =?utf-8?B?K0lqQmZjcnBjbmVXLzRnV1BneDZjQS85UDkvaXpuUlplS2k5UFl2cXJhY29n?=
 =?utf-8?B?ZlVmRlJmd1ViN3JydzgzVHRtK3prdHRyRG04RHBnZWczNEpsN0NSMThUUkNt?=
 =?utf-8?B?NjZBdGRCSlIxL0Vlb0VvUVJEYWFqQ05lUUx6R2FwY2UwZ0I2MzluWWRqZHps?=
 =?utf-8?B?Ukh5eUcvaUx6dDhBcmRpQ2ExSjhiTWtmdkpUVEdtTHdBT0RZbmU2Tm5ocXly?=
 =?utf-8?B?bFlCWmdtcFVIUlBTMUY2aVdhUzhSRWNHRmhtakxVMWtEdVhsZHllZGROMzlj?=
 =?utf-8?B?QXpHV1Ayb3Z4RzJ5blRyYUtXSEZqdW5HNzRScHJRSkFmSXJhUEJnWkJYZU4v?=
 =?utf-8?B?b0hBTkZ1RnhDZHgyVGNMemt2UENiMHNCWk1CT29hRk9HaTJ2SU1WaWpCY0hk?=
 =?utf-8?B?SkUzMHM4dmdQa3JBYUJ3SzkycXhzbWY0RkxPYzRqcW5IdHdPS3NLVWYzdWxu?=
 =?utf-8?B?Wjh4dUhNSzdvYWZkMUlEV3QwNlk2YnhrZ29CZVRQVFpqWkhsQlBWeDdaMEpR?=
 =?utf-8?Q?BDPfaG99y0hgnHEwCuqOfB2bbR3dp4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmxjaXg1TWUxdmxaM3Y0bTZtcnM1dkYwS1hHYW9nNGJwaVo1RFBObUN4M3Rw?=
 =?utf-8?B?T0htNWhTZDY1ZndRTWR6YTVLeGp6R0xuVUN4Q1Y3WXhkV0JDSS9zb1RFZlVt?=
 =?utf-8?B?WXpRcFIvOVdiOEdvblErWnJSQk1udjVjbzh6OEpnd09JbmE1R0lBcXcvWmM5?=
 =?utf-8?B?UG05d29BaVNhSVlRdU9BQ0k5cFN1amRNa2F0UlZGejJRdXhKYjg1NE1pT01L?=
 =?utf-8?B?QThJZ3BGWFlKK1NCc3JXNGtNRk5lcEZ5N0NqNVo2THk3UjBtYjV2V0FmZUM4?=
 =?utf-8?B?Ym1vNk9Id1BrVkk1dlE0K2doMmoyMnREM0gxdjM0dCtWTWI0cXNEd2h5bDJs?=
 =?utf-8?B?WW9CeXI3WGIwTjRIU1FUS1VZeTlKSy9MYm0wSExaRlBqOFM5L2ZERUJlT21w?=
 =?utf-8?B?R2IxUUtQUmFNQjQwYWpZemo2STJabkdYdUxqWUNCV2xWN09HeFdMaXRDVXBW?=
 =?utf-8?B?MmpCQmVPQnAvK1EyeDdNTzJKZHkwd2wvYkp0OW9lbWZtbzgya0ZiZk4ybmNT?=
 =?utf-8?B?NVVxK2k5cHhvUmFKOVNLdmtVUmFMcm9SRDlFdDE2aDhzU3RHSTlFT09ZTG9w?=
 =?utf-8?B?OVdoSVJhVXVFYmk4L2JQMXRzQ2FaeERVay9QUmhKVTAxUmxoYmVKUGxkZE8z?=
 =?utf-8?B?ODhmalU4dzc1ZzNKTzV1UTNkWnk4ekQyaExqNXBSQWxLV1ZzNXNDRkJQcy8x?=
 =?utf-8?B?allpT0w1K2lqOCs3Z0c3Vm82RDBtNEtaQ3RBTnhSTGJCWXNwWUpSR25xbXN5?=
 =?utf-8?B?bzNyTmY0R3RQRzZCenlKUThrek1jZmg4anpEck9SMkFRWUVOaFBuKzVCdmlC?=
 =?utf-8?B?d2xZRUc3cmw1ZXcwMjRVR1VZTjFua2diV3UvWHNwK1h3WlFwZ3JHQnVyd3VG?=
 =?utf-8?B?OUw4NjF6eDZNaUVQM3FZQ0lrRWgxeEpqaVdFK2o3UjVjOVdFeTg0TEVVaUFr?=
 =?utf-8?B?eGN6UnozSFZlKzNEaWVHTjFhY1Z4M20xRndJRmJnN29GNWVnVmhuSWtnemFU?=
 =?utf-8?B?U3pNS05KTVVyTklJMW5PdmwxY1VheGFKamR5a2ZzeDFCNjMvakQyVVF3NEly?=
 =?utf-8?B?K0tkbVBEUVJBdmNraEZIYTZjbG9hZEpMSzIrME1xblQ3enNEeCs4TVAzQU1T?=
 =?utf-8?B?b1BoWFBBbTV6RG1yUDk1STd0OVYySzE2b1o5Sk13UWhlUlVmc3c3VDVRejNj?=
 =?utf-8?B?ZG1MdmoxeHRKNERLcFlVMFJiaDlZUG5EK0RZLzJudUJYVEkxL3daaTJ2RXpS?=
 =?utf-8?B?NzJnaGtRcXFvQ2x3QjE0Q3FVMFlnWXk1QVIxRitrQlJWaWdETVlqaWJkMWdv?=
 =?utf-8?B?SHZTQ09GYnNmbllVWk5RSGR1RUh2RCs2dko4WHhvT2lnVC9hTG1LREV0Zisr?=
 =?utf-8?B?bzhqL0RmUDd3V2R6V25IamRLQm9HMXFXek1XRzdRRitmc0hJSlBWSzkyWUJ5?=
 =?utf-8?B?SXora3M1WFgwQlI0djRONi85ZWd0alEvYmkrVzBrZ2xMdk9KQ2tsYWZmTnBY?=
 =?utf-8?B?bE5TSnRxUFRNc1dPTTdYbitZMURManVOZXNFTWJFRkx1SWxxR1NUWHFZMzBa?=
 =?utf-8?B?TFNWakdhWnZrN3J2ckNwS0ZrVE1XNlpEVS9DeFFKSlJBRjc1ai9vT3hTYURy?=
 =?utf-8?B?WDc2bzQ5S0NsU0hBTUVUU29PZHBTbWt6S0VxRXlnWTNlS1RVVTY3dFIyS2Fn?=
 =?utf-8?B?L0x6MFpUS0MwdXVmaTNYU1U3YWF2QURGcEFHZ3o1L2twY2NJNm0wNHJySHEz?=
 =?utf-8?B?QXlvNjM4NEVqNzlZZE4vZ2FBWjQ4bHk4WnRoRkF3ejlaYWZaMmE4MzBuUWR6?=
 =?utf-8?B?clp2Z1BtaEc5TDdnbmdGaWFhYUxYaiszT004T3Z3aHZIL3MvM082MXNMQVF3?=
 =?utf-8?B?eDRnQ2JZTnVOYTVucXFDM1BHUk9vczNiRkVIS1JkVlM4TG4rRm5yOUp2bTZB?=
 =?utf-8?B?a0k3N0hhN2wweS9BK3VFZzNMbTFJWi92dUo3ZCtxUG1md1FEZHRPNW9lL2FZ?=
 =?utf-8?B?MVNlWjQ4SGpPUWQxWW90R00rTUhlM0JYbHhpcVk0RzRTaHJ5Ny92Zmsydk1w?=
 =?utf-8?B?WkN1RWhLN3RoUjBqaUR0TGV3UGNyQWM1R0hCUGZJelNTTUFBanBKR2hJUUE5?=
 =?utf-8?Q?rLPk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA0A871FDF6D9748AA654C685E9B966C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae35f3-f4f4-4da6-3400-08ddaa6bd8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 11:17:13.0028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iX1Qv8r5YxkLK5m8FOxgtlDncY3+eJ/EoKKFGYi4rg+yz0WoneMA/lJtXXG+lm8HvuDcUJ1Qnsk9NQpV7damBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2456
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

QW0gRnJlaXRhZywgZGVtIDMwLjA1LjIwMjUgdW0gMTI6MTggKzAxMDAgc2NocmllYiBTaW1vbiBH
bGFzczoKPiBIaSBZYW5uaWMsCj4gCj4gT24gVHVlLCAyNyBNYXkgMjAyNSBhdCAxNDoyNCwgWWFu
bmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOgo+ID4gCj4gPiBfZW50cmllcywgYXMg
aGlnaGxpZ2h0ZWQgYnkgbGVhZGluZyBfLCBpcyBhIHByaXZhdGUgbWVtYmVyIGFuZCB0aHVzCj4g
PiBzaG91bGQgbm90IGJlIGFjY2Vzc2VkIGRpcmVjdGx5LiBBcyBhIHJlc3VsdCB1c2UgdGhlIEdl
dEVudHJpZXMgZnVuY3Rpb24KPiA+IGluc3RlYWQuCj4gPiBHZXRFbnRyaWVzKCkgcmV0dXJucyBf
ZW50cmllcy4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50cm9kdWNlZCBpbiB0aGlzCj4gPiBjb21t
aXQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRl
Pgo+ID4gLS0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9hdGZfZmlwLnB5wqDCoMKgwqDCoMKg
wqDCoCB8wqAgNCArKy0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9ibG9iX3BoYXNlLnB5wqDC
oMKgwqDCoCB8wqAgNCArKy0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9jYmZzLnB5wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDEyICsrKysrLS0tLS0KPiA+IMKgdG9vbHMvYmlubWFuL2V0eXBl
L2VmaV9jYXBzdWxlLnB5wqDCoMKgwqAgfMKgIDIgKy0KPiA+IMKgdG9vbHMvYmlubWFuL2V0eXBl
L2ZpdC5wecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKy0tCj4gPiDCoHRvb2xzL2Jp
bm1hbi9ldHlwZS9ta2ltYWdlLnB5wqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKy0tCj4gPiDCoHRv
b2xzL2Jpbm1hbi9ldHlwZS9ueHBfaW14OG1jc3QucHnCoMKgwqAgfMKgIDIgKy0KPiA+IMKgdG9v
bHMvYmlubWFuL2V0eXBlL254cF9pbXg4bWltYWdlLnB5wqAgfMKgIDIgKy0KPiA+IMKgdG9vbHMv
YmlubWFuL2V0eXBlL3NlY3Rpb24ucHnCoMKgwqDCoMKgwqDCoMKgIHwgNDQgKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0KPiA+IC0tLQo+ID4gwqB0b29scy9iaW5tYW4vZXR5cGUvdGlf
Ym9hcmRfY29uZmlnLnB5IHzCoCA4ICsrKy0tLS0KPiA+IMKgdG9vbHMvYmlubWFuL2Z0ZXN0LnB5
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPiA+IMKgMTEgZmlsZXMg
Y2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pCj4gCj4gQXJlIHlvdSBz
dXJlIHRoaXMgaXMgcmlnaHQ/IFRoZSBjbGFzc2VzIHdoaWNoIHVzZSBfZW50cmllcyBhcmUKPiBz
dWJjbGFzc2VzLCBleGNlcHQgZm9yIGZ0ZXN0LnB5IHdoaWNoIGlzIHRlc3QgY29kZSB3aGVyZSB3
ZSBzaG91bGQKPiBwcm9iYWJseSBhZGQ6Cj4gCj4gI3B5bGludDogZGlzYWJsZT1wcm90ZWN0ZWQt
YWNjZXNzCgpJIGRvbid0IHRoaW5rIHRoaXMgaXMgcmlnaHQgb24gc2Vjb25kIHRob3VnaHQuIEkn
bGwgZHJvcCB0aGlzIHBhdGNoIGFsdG9nZXRoZXIKYXMgSSB3b3VsZCBsaWtlIHRvIGZvY3VzIG9u
IChpbW8pIG1vcmUgaW1wb3J0YW50IGFzcGVjdHMgb2YgdGhlIHNlcmllcyBmaXJzdC4KCgo+IAo+
IFJlZ2FyZHMsCj4gU2ltb24K
