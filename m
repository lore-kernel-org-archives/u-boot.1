Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E743606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j264mwCZ;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=kvdc1Lji
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DFC760817;
	Tue, 24 Nov 2026 11:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRHrLkKZuzop; Tue, 24 Nov 2026 11:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5292160802
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795519429;
	b=Hqa60LQ3mKdKYbbZlif3LFtXBXzHesroT1t+vdolISlXvo0fGR66t5VMf6iru3kwGgm8
	 8Hfu6yE0F4MWj5qN/y/YozqNqiwKm6TCTH5VKqXHFVdBjBy8amrfKyvpd+knZGnJMx1P6
	 udNL0xJhQa6zxFbLlsruSVVjvEdz2EihbwpK0ToZ42G3kxAU6r5DYTcEpYaDldzqPBASL
	 UY8y8P077pSfZySAUi52rf7dgyZED+impbzI7vP39QKrtpqsxcnjsLoh240tM8lAXV2qQ
	 8UTDQTvjMHPu6GjQ7mTXJMDVDzB10c5QgBQ/k56sJpEKPEkazyH/hjOcwdA0uMqKFlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795519429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PKrL5iaLXkXRupgACtEdS0+mhO0DxCwsvTy45Yqwq5c=;
	b=Kwtcaf2ihLouuj748qjo9nXEzHBFr7J9hkzt5wOwS9ViCqnugYxE2mIxkG+x2oN4X6+t
	 OQt33A/GzuO1N6Cz8w0HnLIZzE506yrQK8vqX3IFNZ9To1VDZp/vnV0hrAiqWR9eabaKU
	 7T8aYXq8mefjaMcFN35T/Rxd0RHa8ttl2nG+Wf+HT27pVemV+Nd/3I+LzUq0xGXJXIJCI
	 2tNlW77lG7k9/0sf48B+yGXeH47B5LGFNdi44EOQ0VqAD87ijzPC/M/gjxhisiuIntzGq
	 RiOCsLHXW6p4NV4yCzB5F49kIFVQ29/tVQuA821K/o86oabmv9r+fI0dO/V+Yuzg+zA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795519429;
	bh=PKrL5iaLXkXRupgACtEdS0+mhO0DxCwsvTy45Yqwq5c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j264mwCZUVSAVo2yUNUIncPPfZqddNRdGU5aua7WAKxKgXZCjd9nUsS4M5JOW1FFU
	 q0Xd6bklZT3qWfT0mbx97r8C36gurPHe9WdkH1d8nlS5ujMyF7WLf1OhPlDcko93+p
	 ZpxHiUJyXqW5ksvfF6a70z3WsDIqK6wlpHl3ylKDqu271KK+kN56OsYD4vp9SB+7jF
	 bqTr18mNpkjq4MaI49IRi82Ymwkfzd6H2Txqh9dRc94iWGW7IaHun+2xiFg/uBpvVy
	 DJb2zcNly18Y84Rb/w4O/aqoZ2OZWqkhzX1/qVa+fj8/LYPpVMzdV6o9IGNZ+pNK5z
	 6eOTGTWsgfGYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5292160802;
	Tue, 24 Nov 2026 11:23:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25CE33A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 174FD80CAB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kda78xWCj2uM for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 821EC80CA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=kvdc1Lji
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 821EC80CA8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKrL5iaLXkXRupgACtEdS0+mhO0DxCwsvTy45Yqwq5c=;
 b=kvdc1LjiVRiRgO80EP2B7RxF30ePVa4s/3R/0zxQ76gIfc71Kt5k6X52dpRoD0UK6PLhXIOyid2PwdNCKy2vHdDf7AiqPHKUp9+dmzv1xow2fJgtqGhl2kNv0m1NDI+5kEvrhO1ijyj6KEhmkyxqWQrNxcAat6wBiujWCMzwBHewFjsAmszVZYnQoUcrhzSHZL0gfiyXazNRucF244Oyl5tqcUw3LZA2HL31P5jrstASB7+/fZGeFxCjN9ZAaUEGurr8VM+ltXERR6k1Qw+my34ebl/Kia4sOtW2nG/PsMAATZmaTJKL/JGdsaRqTIzXFjM6cfaYOYQ3Lv5HdpFkVQ==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by BR2PR10MB992333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:1c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 11:23:38 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 11:23:38 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 1/5] timer: provide the counter end value
Thread-Topic: [PATCH v3 1/5] timer: provide the counter end value
Thread-Index: AQHdceDefOzY/g/uIEiW1AzVFEtbHrc5PiEAgAPqnQA=
Date: Tue, 24 Nov 2026 11:23:38 +0000
Message-ID: <ed8fa54cb0a49f179a52e3bfcd144e924ca7bae8.camel@siemens.com>
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
 <20261111133029.2538132-2-felix.moessbauer@siemens.com>
 <b1344e06-fd93-40e2-b065-b0d803f15800@gmx.de>
In-Reply-To: <b1344e06-fd93-40e2-b065-b0d803f15800@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1-4 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|BR2PR10MB992333:EE_
x-ms-office365-filtering-correlation-id: ba82c91b-e97c-4fb3-e5b3-08df4a1d6320
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261021123027099003|261009223027099003|261102123227099003|18002099003|22082099003|55112099003|3023799007;
x-microsoft-antispam-message-info: XzQ1/o7k/c70p7L2YnwobaNbRWQeJolsEHFptctYPSlenWIRSsy471ZgcxGBXOWQKrQRdWRpPgAPZkh0Bij9MJmqV55HAlkVHoSbgHKlIK4+omIe7e9zJzWUSdHwSpnSTYv9fdNZLrBhE8lA4C6rjykI2FdJ6LDvgYmtlhrOJWc5kewIubNcl5WrcViSv911p2lOv6O0nH5vr+1I5CnH7T5cKtjcIVuIrNMhjj52V+3Uo6hbq38Ny5+n2rnDgMzbqzZDc5JoBwe4Ai7aT0ji39yOb0khp8EzuYfjCTeVO9qLDZhv4Dgt9N0HKFDpN7wIj8LWlOXG68qCT7WTYwUcHi0BqmQD6cDk2tHwjfyLGZSZqVWjQOTTOnoL1QpzAhpHHW0W3uBvESzC9wTE5ye+ez0cqcN3YT4LkItVd2X0HW6ZQojyO5FqiE7khaj63A2ZDyDTrn6IxthsexH8sfn9Mz0SPWJ8m2NMYqJDOZ1bqJlk/7RxNsAEcNHT3uSQvpmsgOsSRx1Z9TBwFoFte7OvBUH05eB6lVZtz8tNIP520lvuNJUGELqX/KcY+Ld0SOZl0G9fg8wQxDe0c0JBd0zdWmeFzGGWda1XapSWVvalBwp3LCx4+sORdjzA7V8M8Tswe6VBwu+cLvKzCc2pEOOhK3sg9pBxqN/28RdRoQjDCP5MGCAHztxu7or6HHIyH3ZSeE4j5ulWd13NY/tY19flrTGtd/+1MXgme/bn8nne5ko=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003)(55112099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE9EbkRQVEd1bFpzbnJWbzhuTEZDakxqUEVTVUZGVkdFVjRjTmt6STJIQlRR?=
 =?utf-8?B?ZDFyb0RLc2l4bmpLYjA1ZnllQUltdGlIdW5LaEFDdVV3c1lhamc0RU4xU1lW?=
 =?utf-8?B?UVJTRC90MXkvc1V6OTkvaWQ2amJ4QUI0U2Z4VUkxSVhPeUV5dWFPNVZLbmxC?=
 =?utf-8?B?RURSSzk1UkZlWEVWUU5qcHc3c092Znp6bGZYWllvYkNXVFhSZWVNVTBiVHFC?=
 =?utf-8?B?S0VPQ1g2WUM0azJ2QnQxMUJaRlJwYVBSVFNxKzYvcUloYUNqZkRuYnZtZVFR?=
 =?utf-8?B?Rm5DejcyeTRWSndCcjVKa0FrSm5WcDlHSEhCRXJ5dWJlWXlyc0VxYzBsNUdG?=
 =?utf-8?B?ejVLWUJrb3FjUG1mb0xFcjloczBBVnptZXluSWkwN1hHRkxtdGVaNlJReXo4?=
 =?utf-8?B?S2grUHJhR3FBQWVZQXFTM3JrWE1CWFF3M0x0bE54MWt6RFFQa1ZBS1h4V1VP?=
 =?utf-8?B?MG5qOXMwNmhjNXhuZDZlNFo3bnBZM3luSXpWVHFJV2wrYStDVllad0N4UFpl?=
 =?utf-8?B?bEJRK1VzUCtQR2c5NTJnQkZuRXA1eXlGZndQODRQWVBRU0xFNVpIWVB1R29J?=
 =?utf-8?B?OHVTbzlOcHRaUG1rT08rUFFkSVNiRUxZeGtaYTlYL25FL2kyZHZkVytvUWRQ?=
 =?utf-8?B?TzNiQVIwN0UyR0g3UGJ3N0tVMGk5M1lqeUxUZ0hsMzNqRVBnV200bWJYM1pU?=
 =?utf-8?B?eWE1N2NYVk8wblExWDMvTEQ1bFU0UTE4ajVCb0FWM3B6a2JlMkRTUW45TC8y?=
 =?utf-8?B?K2Q0cjRnM1JSa0k4b2NHQi9JZTQyMTV3YW54UXZRNE9GMXBRTmRSb05wMW5W?=
 =?utf-8?B?YzRPUUlLd3R6amh0cDZGQ0tHazhaOEFKbk5HcWxaZndGOEtMZkNUN3c1UVUr?=
 =?utf-8?B?ZFJMNGJUQ01jNDRrazNrYkNHRk0zOFpEclc2Qm1NS0pvYUxqcDBvdDNINnl4?=
 =?utf-8?B?emptZUNKMmgwQkxyaFRSZUZQTVZvaFE1S3djU3psQ1pKL1d6TmxSTEdNOVFV?=
 =?utf-8?B?NGxCdk5nYmt2bVlWcXZORUZsd2YvL1lpbWVHclM3cU8vdUczckdHb3l3NXNk?=
 =?utf-8?B?bVBxdEp6Uzh4SkVYMDhEb1lUMDdPVVQ0WFJkc3Q1MEV1YWJDZ2xJUTMybk9E?=
 =?utf-8?B?YlYvZkhzTFZOMEdDUmMrVHN1MVVxTG5VdjB4aSthLzEyL1czMlNzWk9ycEph?=
 =?utf-8?B?eStWMUxidTJUSEhYcUt4Zm5FNENsM2czb0ZRa25mN3g0S0hNZUxHdnlBN0xB?=
 =?utf-8?B?OVFMcFJma21SaElFTE1xZlpXOVJKMEY1TFRTcFZnL2QxbzkwZ0tVM0QvMXFX?=
 =?utf-8?B?N2VXUmxGTERBbE5jcUI4SUw1aVBuR2NYODhWZ3ZxbHR1aGpsbFlQa3U5NWJS?=
 =?utf-8?B?YjRMcVF0OUx5OHdqZFNHWUNuYjdJOGhnRzJ0QWhBSkNoK2UvZ1V4WVVDcmZq?=
 =?utf-8?B?bXU4Zk44akYxUm44TnNLQ0NoeGhxd053OVpzVzZaTjVhaldyTUMybnArc2Nw?=
 =?utf-8?B?aXNLQmNSR29ITndOenR5bUNGbG1rdWc0UC9zdjVVYXAySEhwa0doRnIyckRk?=
 =?utf-8?B?YlV2RzI1SUpsNDVFQVVmLzVBVG45b2kxUmh4eUppSkJRODBEKzhjNXpQUnh2?=
 =?utf-8?B?TWsxLytTclpHQWZZd3ptdE4yUGJDU2o1cEdCZi85V0REUzNHZjNrZk9EeFNC?=
 =?utf-8?B?Vk9LZGRIMkpNMUcxdzRDMmVpV01KbHB3cEVYSWt3QUNMdS9KajZjNFAwY2RF?=
 =?utf-8?B?OVhsbzJadCtzVHhpeGxSNmczSi8va0JHUDVBSzdQK2dGSzNUbEtYUVJXRklG?=
 =?utf-8?B?Yld5MlRxNWppRWVYazFVdGJ6QWQ4VTExZXdXT0dEeWtZOG1aS3pUZmVJc2lk?=
 =?utf-8?B?ZVZmazhRVUhtbzkySkszZEdQUjE5RHVaVjZmNkcxWUt6c2Jld253UXkvNmlq?=
 =?utf-8?B?MFdyUkg0Qlh3UVZOMWtBbHFybUR3Y0xWVTBjTzV4MHo2TklFaXpBZ3NtYW5l?=
 =?utf-8?B?QmxFQkdDMnBkaXlCWnVPbENFQVo0eUttbWdLc2I2Yjc2eWExajlCRjlnUElu?=
 =?utf-8?B?aUFzR3ZFM1RMd2hqZVhFcVRZblJNbHJXUEJhaDQxK3B1YVpWN1N6MTRCY2Zv?=
 =?utf-8?B?RUN4L0dEREdVUXNGQ3BZcHdqWU5lQkk2NU95a1QyY2NpSzhuYXd5TXNDT2d1?=
 =?utf-8?B?Mk9UMGxObkN6QWM2VlZVcUt5aVZmRkVOQTduUUJ6ZmsvQzkwUmRsZ0QrN1NR?=
 =?utf-8?B?UXhIZ0ZCSDJYMURUS1UzMEh5ZTR5UDliQXllN2Q4YWY0RjVpc2RJZS9HeGJw?=
 =?utf-8?B?NEVZa2VOUG5VQ2hKQ1RoWC9sb0VZbk9jM3pPTGNiNGtWWkN2a1FaUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5E4B1ABEA7904EB1A6B7B3DCFD43A1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82c91b-e97c-4fb3-e5b3-08df4a1d6320
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 11:23:38.7300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AU0lUWud7WS849nQvI3PlHLRTNUPrr7bz3XMlHUU2OGOj0Uxh9CBCXHJGSu4x0C4oxQzps+GsOSVckm69b75fBybgV7TlvSpgOenVi0ByA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992333
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTIyIGF0IDAwOjM1ICswMTAwLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdy
b3RlOgo+IE9uIDExLzExLzI2IDE0OjMwLCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3RlOgo+ID4gVGhl
IHRpbWVyIGlzIHVzdWFsbHkgYSBmcmVlLXJ1bm5pbmcgdXAgY291bnRlciwgYnV0IGl0cyB3aWR0
aCBkZXBlbmRzIG9uCj4gPiB0aGUgZHJpdmVyLiBTb21lIGRyaXZlcnMgZXh0ZW5kIHRoZSBoYXJk
d2FyZSBjb3VudGVyIHRvIDY0IGJpdHMsIG90aGVycwo+ID4gcmV0dXJuIHRoZSByYXcgMzItYml0
IChvciBuYXJyb3dlcikgdmFsdWUgd2hpY2ggd3JhcHMgbXVjaCBlYXJsaWVyLgo+ID4gCj4gPiBB
ZGQgYW4gZW5kX3ZhbHVlIG1lbWJlciB0byBzdHJ1Y3QgdGltZXJfZGV2X3ByaXYgaG9sZGluZyB0
aGUgbGFzdCBjb3VudAo+ID4gdmFsdWUgYmVmb3JlIHRoZSBjb3VudGVyIHdyYXBzIHRvIHplcm8u
IEl0IGRlZmF1bHRzIHRvIFU2NF9NQVggYW5kIGNhbiBiZQo+ID4gb3ZlcnJpZGRlbiBieSBkcml2
ZXJzIGluIHRoZWlyIHByb2JlIGZ1bmN0aW9uLiBQcm92aWRlIHRoZSBnZXR0ZXIKPiA+IHRpbWVy
X2dldF9lbmRfdmFsdWUoKSBpbiB0aGUgdWNsYXNzLgo+ID4gCj4gPiBBbHNvIGFkZCBnZXRfdGlj
a3NfZW5kX3ZhbHVlKCkgcmV0dXJuaW5nIHRoZSBlbmQgdmFsdWUgb2YgdGhlIGNvdW50ZXIKPiA+
IHVzZWQgYnkgZ2V0X3RpY2tzKCkuIFdpdGhvdXQgQ09ORklHX1RJTUVSIHRoZSBnZW5lcmljIGdl
dF90aWNrcygpIGV4dGVuZHMKPiA+IHRoZSBjb3VudGVyIHRvIDY0IGJpdHMsIHNvIFU2NF9NQVgg
aXMgcmV0dXJuZWQuIFRoZSBmdW5jdGlvbiBpcyB3ZWFrIHRvCj4gPiBhbGxvdyBhcmNoaXRlY3R1
cmVzIG92ZXJyaWRpbmcgZ2V0X3RpY2tzKCkgdG8gcmVwb3J0IHRoZWlyIGVuZCB2YWx1ZS4KPiA+
IAo+ID4gU2lnbmVkLW9mZi1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBz
aWVtZW5zLmNvbT4KPiA+IC0tLQo+ID4gQ2hhbmdlcyBzaW5jZSB2MjoKPiA+IAo+ID4gLSBhZGRl
ZCB0aGlzIHBhdGNoCj4gPiAKPiA+ICAgZHJpdmVycy90aW1lci90aW1lci11Y2xhc3MuYyB8IDE1
ICsrKysrKysrKysrKystLQo+ID4gICBpbmNsdWRlL3RpbWUuaCAgICAgICAgICAgICAgIHwgIDcg
KysrKysrKwo+ID4gICBpbmNsdWRlL3RpbWVyLmggICAgICAgICAgICAgIHwgMTAgKysrKysrKysr
Kwo+ID4gICBsaWIvdGltZS5jICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrKwo+
ID4gICA0IGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RpbWVyL3RpbWVyLXVjbGFzcy5jIGIvZHJpdmVy
cy90aW1lci90aW1lci11Y2xhc3MuYwo+ID4gaW5kZXggODMwNWYwNmQzMTguLmU3ODQwMjU4ODRl
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy90aW1lci90aW1lci11Y2xhc3MuYwo+ID4gKysrIGIv
ZHJpdmVycy90aW1lci90aW1lci11Y2xhc3MuYwo+ID4gQEAgLTI3LDcgKzI3LDggQEAgREVDTEFS
RV9HTE9CQUxfREFUQV9QVFI7Cj4gPiAgICAqIHRoZSBpbnB1dCBjbG9jayBmcmVxdWVuY3kgb2Yg
dGhlIHRpbWVyLiBUaGUgZ2V0X2NvdW50KCkgbWV0aG9kIGlzIHVzZWQKPiA+ICAgICogdG8gZ2V0
IHRoZSBjdXJyZW50IDY0IGJpdHMgY291bnQgdmFsdWUuIElmIHRoZSBoYXJkd2FyZSBpcyBjb3Vu
dGluZyBkb3duLAo+ID4gICAgKiB0aGUgdmFsdWUgc2hvdWxkIGJlIGludmVyc2VkIGluc2lkZSB0
aGUgbWV0aG9kLiBUaGVyZSBtYXkgYmUgbm8gcmVhbAo+ID4gLSAqIHRpY2ssIGFuZCBubyB0aW1l
ciBpbnRlcnJ1cHQuCj4gPiArICogdGljaywgYW5kIG5vIHRpbWVyIGludGVycnVwdC4gVGhlIGVu
ZF92YWx1ZSBtZW1iZXIgb2Ygc3RydWN0Cj4gPiArICogdGltZXJfZGV2X3ByaXYgaG9sZHMgdGhl
IGxhc3QgY291bnQgdmFsdWUgYmVmb3JlIHRoZSBjb3VudGVyIHdyYXBzLgo+ID4gICAgKi8KPiA+
ICAgCj4gPiAgIGludCBub3RyYWNlIHRpbWVyX2dldF9jb3VudChzdHJ1Y3QgdWRldmljZSAqZGV2
LCB1NjQgKmNvdW50KQo+ID4gQEAgLTQ4LDEwICs0OSwyMCBAQCB1bnNpZ25lZCBsb25nIG5vdHJh
Y2UgdGltZXJfZ2V0X3JhdGUoc3RydWN0IHVkZXZpY2UgKmRldikKPiA+ICAgCXJldHVybiB1Y19w
cml2LT5jbG9ja19yYXRlOwo+ID4gICB9Cj4gPiAgIAo+ID4gK3U2NCBub3RyYWNlIHRpbWVyX2dl
dF9lbmRfdmFsdWUoc3RydWN0IHVkZXZpY2UgKmRldikKPiA+ICt7Cj4gPiArCXN0cnVjdCB0aW1l
cl9kZXZfcHJpdiAqdWNfcHJpdiA9IGRldl9nZXRfdWNsYXNzX3ByaXYoZGV2KTsKPiA+ICsKPiA+
ICsJcmV0dXJuIHVjX3ByaXYtPmVuZF92YWx1ZTsKPiA+ICt9Cj4gPiArCj4gPiAgIHN0YXRpYyBp
bnQgdGltZXJfcHJlX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCj4gPiAgIHsKPiA+ICsJc3Ry
dWN0IHRpbWVyX2Rldl9wcml2ICp1Y19wcml2ID0gZGV2X2dldF91Y2xhc3NfcHJpdihkZXYpOwo+
ID4gKwo+ID4gKwl1Y19wcml2LT5lbmRfdmFsdWUgPSBVNjRfTUFYOwo+IAo+IFRoZSBtaXNzaW5n
IHBpZWNlIGluIHRoaXMgcGF0Y2ggc2VyaWVzIGlzIHRvIGFjdHVhbGx5IHNldCB0aGUgZW5kIHZh
bHVlIAo+IHRvIHRoZSBjb3JyZWN0IHZhbHVlIGZvciB0aG9zZSBkcml2ZXJzIHRoYXQgZG9uJ3Qg
c3VwcG9ydCBVNjRfTUFYLgoKSGksIHRoYW5rcyBmb3IgdGhlIHJldmlldy4gVGhpcyBpcyBpbXBs
ZW1lbnRlZCBpbiBwMi4KCj4gCj4gTW9zdCB0aW1lciBkcml2ZXJzIHRoYXQgb25seSBoYXZlIDMy
Yml0IGhhcmR3YXJlIGNvdW50ZXJzIHVzZSBmdW5jdGlvbiAKPiB0aW1lcl9jb252XzY0KCkgdG8g
Y3JlYXRlIGEgNjQgdmFsdWVzLiBTb21lIGhhdmUgaW1wbGVtZW50ZWQgdGhlIHNhbWUgCj4gbG9n
aWMgaW50ZXJuYWxseS4KPiAKPiBkcml2ZXJzL3RpbWVyL2FkaV9zYzV4eF90aW1lci5jIC0gdTY0
Cj4gZHJpdmVycy90aW1lci9hbHRlcmFfdGltZXIuYyAtIHRpbWVyX2NvbnZfNjQKPiBkcml2ZXJz
L3RpbWVyL2FuZGVzX3BsbXRfdGltZXIuYyAtIHU2NAo+IGRyaXZlcnMvdGltZXIvYXJjX3RpbWVy
LmMgLSB0aW1lcl9jb252XzY0Cj4gZHJpdmVycy90aW1lci9hcm1fZ2xvYmFsX3RpbWVyLmMgdTY0
Cj4gZHJpdmVycy90aW1lci9hcm1fdHdkX3RpbWVyLmMgLSB0aW1lcl9jb252XzY0Cj4gZHJpdmVy
cy90aW1lci9hc3RfaWJleF90aW1lci5jIC0gdTY0Cj4gZHJpdmVycy90aW1lci9hc3RfdGltZXIu
YyAtIHUzMgo+IGRyaXZlcnMvdGltZXIvYXRtZWxfcGl0X3RpbWVyLmMgLSB0aW1lcl9jb252XzY0
Cj4gZHJpdmVycy90aW1lci9hdG1lbF90Y2JfdGltZXIuYyAtIHU2NAo+IGRyaXZlcnMvdGltZXIv
Y2FkZW5jZS10dGMuYyAtIHUzMgo+IGRyaXZlcnMvdGltZXIvZHctYXBiLXRpbWVyLmMgLSB0aW1l
cl9jb252XzY0Cj4gZHJpdmVycy90aW1lci9nb2xkZmlzaF90aW1lci5jIC0gdTY0Cj4gZHJpdmVy
cy90aW1lci9neHAtdGltZXIuYyAtIHU2NAo+IGRyaXZlcnMvdGltZXIvaW14LWdwdC10aW1lci5j
IC0gdTY0Cj4gZHJpdmVycy90aW1lci9tY2hwLXBpdDY0Yi10aW1lci5jIC0gdTY0Cj4gZHJpdmVy
cy90aW1lci9tcGM4M3h4X3RpbWVyLmMgLSB1NjQKPiBkcml2ZXJzL3RpbWVyL210a190aW1lci5j
IC0gdGltZXJfY29udl82NAo+IGRyaXZlcnMvdGltZXIvbm9tYWRpay1tdHUtdGltZXIuYyAtIHRp
bWVyX2NvbnZfNjQKPiBkcml2ZXJzL3RpbWVyL25wY20tdGltZXIuYyAtIDB4NjFBODAwMDAwMDAw
Cj4gZHJpdmVycy90aW1lci9vbWFwLXRpbWVyLmMgLSB0aW1lcl9jb252XzY0Cj4gZHJpdmVycy90
aW1lci9vcmlvbi10aW1lci5jIC0gdGltZXJfY29udl82NAo+IGRyaXZlcnMvdGltZXIvb3N0bV90
aW1lci5jIC0gdGltZXJfY29udl82NAo+IGRyaXZlcnMvdGltZXIvcmlzY3ZfYWNsaW50X3RpbWVy
LmMgLSB1NjQKPiBkcml2ZXJzL3RpbWVyL3Jpc2N2X3RpbWVyLmMgLSB1NjQKPiBkcml2ZXJzL3Rp
bWVyL3JvY2tjaGlwX3RpbWVyLmMgLSB1NjQKPiBkcml2ZXJzL3RpbWVyL3NhbmRib3hfdGltZXIu
YyAtIHU2NAo+IGRyaXZlcnMvdGltZXIvc3A4MDRfdGltZXIuYyAtIHUzMgo+IGRyaXZlcnMvdGlt
ZXIvc3RhcmZpdmUtdGltZXIuYyAtIHUzMgo+IGRyaXZlcnMvdGltZXIvc3RtMzJfdGltZXIuYyAt
IHUzMgo+IGRyaXZlcnMvdGltZXIvdGVncmEtdGltZXIuYyAtIHRpbWVyX2NvbnZfNjQKPiBkcml2
ZXJzL3RpbWVyL3RzY190aW1lci5jIC0gdTY0Cj4gZHJpdmVycy90aW1lci94aWxpbngtdGltZXIu
YyAtIHRpbWVyX2NvbnZfNjQKPiAKPiBFLmcuIHRoZSBTdGFyRml2ZSBWaXNpb25GaXZlIDIgaGFz
IHN0YXJmaXZlLXRpbWVyIGFuZCBzdXBwb3J0cyA2NGJpdCAKPiBVRUZJLiBTbyBoZXJlIHlvdXIg
Y3VycmVudCBzZXJpZXMgaXMgcHJvdmlkaW5nIHRoZSB3cm9uZyB2YWx1ZS4KClJlYWxseT8gSW4g
cDIgd2Ugc2V0IGl0IGFjY29yZGluZyB0byB0aGUgZGV2aWNlIHRyZWU6Cgpwcml2LT50aW1lcl9z
aXplID0gZGV2X3JlYWRfdTMyX2RlZmF1bHQoZGV2LCAidGltZXItc2l6ZSIsIC0xVSk7CndyaXRl
bChwcml2LT50aW1lcl9zaXplLCBwcml2LT5iYXNlICsgU1RGX1RJTUVSX0xPQUQpOwp1Y19wcml2
LT5lbmRfdmFsdWUgPSBwcml2LT50aW1lcl9zaXplOwoKPiAKPiBGb3IgYWxsIGRyaXZlcnMgbWFy
a2VkIGFzIHUzMiBhbmQgZm9yIHRoZSBucGNtLXRpbWVyLCBwbGVhc2UsIHVwZGF0ZSAKPiBlbmRf
dmFsdWUgaW4gdGhlIHByb2JlKCkgbWV0aG9kIG9yIGJldHRlciBhZGQgdGhlIG1pc3NpbmcgCj4g
dGltZXJfY29udl82NCgpIGludm9jYXRpb24uCgpJJ20gYSBiaXQgdW5zdXJlIGFib3V0IHRoZSBu
cGNtLXRpbWVyLCBhcyBJIGRvbid0IGhhdmUgYSBkYXRhc2hlZXQgZm9yCnRoZXNlIGNoaXBzLiBU
aGUgY29tbWVudCBpbiBucGNtLXRpbWVyLmMgLyBucGNtX3RpbWVyX2dldF9jb3VudCgpCmluZGlj
YXRlcyB0aGF0IHRoZSB3cmFwcGluZyBvZiB0aGUgMjVNSHogY291bnRlciBpcyBoYW5kbGVkIGlu
dGVybmFsbHkuCkJ5IHRoYXQsIHRoZSBvdmVyYWxsIGNvdW50ZXIgd2lsbCBvbmx5IHdyYXAgYWZ0
ZXIgdGhlIFNFQ0NOVCBsZWF2ZXMgdGhlCjMyLWJpdCByYW5nZSAtIHdoaWNoIGlzIGFmdGVyIG92
ZXIgMTAwIHllYXJzLgoKR2l2ZW4gdGhhdCwgdGhlIGNvZGUgaW4gcDIgc2hvdWxkIGFscmVhZHkg
YmUgY29ycmVjdC4gT3IgZG8gSSBtaXNzCnNvbWV0aGluZz8KCkJlc3QgcmVnYXJkcywKRmVsaXgK
Cj4gCj4gQmVzdCByZWdhcmRzCj4gCj4gSGVpbnJpY2gKPiAKPiA+ICsKPiA+ICAgCWlmIChDT05G
SUdfSVNfRU5BQkxFRChPRl9SRUFMKSkgewo+ID4gLQkJc3RydWN0IHRpbWVyX2Rldl9wcml2ICp1
Y19wcml2ID0gZGV2X2dldF91Y2xhc3NfcHJpdihkZXYpOwo+ID4gICAJCXN0cnVjdCBjbGsgdGlt
ZXJfY2xrOwo+ID4gICAJCWludCBlcnI7Cj4gPiAgIAkJdWxvbmcgcmV0Owo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdGltZS5oIGIvaW5jbHVkZS90aW1lLmgKPiA+IGluZGV4IGY1Yjg2YmY3MGZl
Li41MzE4MzQ2ZGNiZCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvdGltZS5oCj4gPiArKysgYi9p
bmNsdWRlL3RpbWUuaAo+ID4gQEAgLTE1OCw0ICsxNTgsMTEgQEAgdW5zaWduZWQgbG9uZyB0aW1l
cl9nZXRfdXModm9pZCk7Cj4gPiAgICAqLwo+ID4gICB1aW50NjRfdCBnZXRfdGlja3Modm9pZCk7
Cj4gPiAgIAo+ID4gKy8qKgo+ID4gKyAqIGdldF90aWNrc19lbmRfdmFsdWUoKSAtIEdldCB0aGUg
bGFzdCB0aWNrIHZhbHVlIGJlZm9yZSB0aGUgY291bnRlciB3cmFwcwo+ID4gKyAqCj4gPiArICog
UmV0dXJuOiBsYXN0IHZhbHVlIHJldHVybmVkIGJ5IGdldF90aWNrcygpIGJlZm9yZSBpdCB3cmFw
cyB0byB6ZXJvCj4gPiArICovCj4gPiArdTY0IGdldF90aWNrc19lbmRfdmFsdWUodm9pZCk7Cj4g
PiArCj4gPiAgICNlbmRpZiAvKiBfVElNRV9IICovCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90
aW1lci5oIGIvaW5jbHVkZS90aW1lci5oCj4gPiBpbmRleCAwOTFkOGRmYTIyOC4uZTBlMmU4YmJm
OTAgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL3RpbWVyLmgKPiA+ICsrKyBiL2luY2x1ZGUvdGlt
ZXIuaAo+ID4gQEAgLTYyLDYgKzYyLDE0IEBAIGludCB0aW1lcl9nZXRfY291bnQoc3RydWN0IHVk
ZXZpY2UgKmRldiwgdTY0ICpjb3VudCk7Cj4gPiAgICAqLwo+ID4gICB1bnNpZ25lZCBsb25nIHRp
bWVyX2dldF9yYXRlKHN0cnVjdCB1ZGV2aWNlICpkZXYpOwo+ID4gICAKPiA+ICsvKioKPiA+ICsg
KiB0aW1lcl9nZXRfZW5kX3ZhbHVlKCkgLSBHZXQgdGhlIGxhc3QgY291bnQgdmFsdWUgYmVmb3Jl
IHRoZSB0aW1lciB3cmFwcwo+ID4gKyAqIEBkZXY6IFRoZSB0aW1lciBkZXZpY2UKPiA+ICsgKgo+
ID4gKyAqIFJldHVybjogdGhlIGxhc3QgdmFsdWUgcmV0dXJuZWQgYnkgZ2V0X2NvdW50KCkgYmVm
b3JlIGl0IHdyYXBzIHRvIHplcm8KPiA+ICsgKi8KPiA+ICt1NjQgdGltZXJfZ2V0X2VuZF92YWx1
ZShzdHJ1Y3QgdWRldmljZSAqZGV2KTsKPiA+ICsKPiA+ICAgLyoqCj4gPiAgICAqIHN0cnVjdCB0
aW1lcl9vcHMgLSBEcml2ZXIgbW9kZWwgdGltZXIgb3BlcmF0aW9ucwo+ID4gICAgKgo+ID4gQEAg
LTg4LDkgKzk2LDExIEBAIHN0cnVjdCB0aW1lcl9vcHMgewo+ID4gICAgKiBzdHJ1Y3QgdGltZXJf
ZGV2X3ByaXYgLSBpbmZvcm1hdGlvbiBhYm91dCBhIGRldmljZSB1c2VkIGJ5IHRoZSB1Y2xhc3MK
PiA+ICAgICoKPiA+ICAgICogQGNsb2NrX3JhdGU6IHRoZSB0aW1lciBpbnB1dCBjbG9jayBmcmVx
dWVuY3kgaW4gSHoKPiA+ICsgKiBAZW5kX3ZhbHVlOiB0aGUgbGFzdCBjb3VudCB2YWx1ZSBiZWZv
cmUgdGhlIGNvdW50ZXIgd3JhcHMgdG8gemVybwo+ID4gICAgKi8KPiA+ICAgc3RydWN0IHRpbWVy
X2Rldl9wcml2IHsKPiA+ICAgCXVuc2lnbmVkIGxvbmcgY2xvY2tfcmF0ZTsKPiA+ICsJdTY0IGVu
ZF92YWx1ZTsKPiA+ICAgfTsKPiA+ICAgCj4gPiAgIC8qKgo+ID4gZGlmZiAtLWdpdCBhL2xpYi90
aW1lLmMgYi9saWIvdGltZS5jCj4gPiBpbmRleCAwZTliMDc5ZjljZi4uZDliY2UzMDNlNmQgMTAw
NjQ0Cj4gPiAtLS0gYS9saWIvdGltZS5jCj4gPiArKysgYi9saWIvdGltZS5jCj4gPiBAQCAtMTEx
LDggKzExMSwyMSBAQCB1aW50NjRfdCBub3RyYWNlIGdldF90aWNrcyh2b2lkKQo+ID4gICAJcmV0
dXJuIGNvdW50Owo+ID4gICB9Cj4gPiAgIAo+ID4gK3U2NCBub3RyYWNlIGdldF90aWNrc19lbmRf
dmFsdWUodm9pZCkKPiA+ICt7Cj4gPiArCWlmICghZ2QtPnRpbWVyKQo+ID4gKwkJcmV0dXJuIFU2
NF9NQVg7Cj4gPiArCj4gPiArCXJldHVybiB0aW1lcl9nZXRfZW5kX3ZhbHVlKGdkLT50aW1lcik7
Cj4gPiArfQo+ID4gKwo+ID4gICAjZWxzZSAvKiAhQ09ORklHX1RJTUVSICovCj4gPiAgIAo+ID4g
K3U2NCBfX3dlYWsgbm90cmFjZSBnZXRfdGlja3NfZW5kX3ZhbHVlKHZvaWQpCj4gPiArewo+ID4g
KwlyZXR1cm4gVTY0X01BWDsKPiA+ICt9Cj4gPiArCj4gPiAgIHVpbnQ2NF90IF9fd2VhayBub3Ry
YWNlIGdldF90aWNrcyh2b2lkKQo+ID4gICB7Cj4gPiAgIAl1bnNpZ25lZCBsb25nIG5vdyA9IHRp
bWVyX3JlYWRfY291bnRlcigpOwo=
