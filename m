Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F7FCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE408394E;
	Tue, 12 May 2026 10:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="g/5efbiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CEF8394E; Tue, 12 May 2026 10:49:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A29683CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us4qr0iYe1MniDZvazzKBXYNtIesAlzm43evHKvjc7ubaIp57SdOlt/XnbtD7R6GHFZuO7P0DZMCdc2mS4PE8lNMmVGI0iH1tsntbCbpUGeHTJ+sJMgJc5ybfNh1NLRUOaHd0tILGvQ+NkQtXgyMju6DJJ682R78c0U03lbMEh7qozJ+RN9PgUhlnSQPRMEjs/ORUHlCROwRGfqS8gZ8f3ZKxoF3IG2er6LjFtZUwflCQwDOZEt88b4cOS4xX8DmnEBErTBbt0jnlcLv0NiuK0/gTJZrUgsIOrjhrfd4Hz2MwKD/Q89rC9bpzyB/MQy/ZM3Mzk/aXPrYtXxLLXzs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma5+nTJ/8mRSkJpkbHXTGSyPYH8Z4RaMBZ38gA7Fr5U=;
 b=A3yrBrwQWdLeFwyAKgrZO/c9C47MskBngTJ4IvfG7pMHyPcIdFC5mgCLxyISaE9EBgPkO25fvCY2kZ3lS5FPPPuse2yfXCXJOu2Xw7Zgbc6jGKl/cNlNTq+2wg87rJKCm+OGgMhF3bfrCy9xANXo7xBqgzag/y9YU7qAjYEXdW8L5dMAuKlKI+a0RASdVUpeqCXzqVe23X9feGw0CVX+2SkvtRdi69da4F4Wxd1J6YjytrBRiubfrU4wE8sIhySUSVv8TACj39QLq+S0kCfUkHPdIEs590JJHcV/ATE2SzApkL6qh8xfWX9IINfwsbfYtf/Jj3vHJYHwbhfsiVJ4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma5+nTJ/8mRSkJpkbHXTGSyPYH8Z4RaMBZ38gA7Fr5U=;
 b=g/5efbiP5JI6PPJPv9drO610hMFz8KdhElL/vget0bijjA6gfacFAGWQ7taekSRMvjOzh6DYSMgpRLMx6nIYJ9VN47PojlU9v25do3e3nvPIBHBPAcOSvAZMGW45bhUDZTUfVOE0UPyUM+YEm9yA5uDKpa2OTv0UFcfOP3GOqw2yC1lF84Teeb7q1tY02DEvK2n1XVX7JXkx7gqzDdjQ75z6exFWxOBcjIMehuHjYqzkd1tvYeSwYM3li+F1sGvoyMyqkzHWcl41Z9w7bsUDlCWLJDzZQ0PkLCfYGJATyCXnu/vX7sYkkRcdSyxXT9nEF1FVpCKsgBHA5PR9ZufT8w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB8085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:48:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:48:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>, "Markus.Niebel@ew.tq-group.com"
 <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v2 3/8] rtc: pcf85063: add support for NXP PCF85063 family
Thread-Topic: [PATCH v2 3/8] rtc: pcf85063: add support for NXP PCF85063 family
Thread-Index: AQHc4T8hRQIgg8jx6ky42RWtJOHKz7YKE74A
Date: Tue, 12 May 2026 08:48:56 +0000
Message-ID: <210ebb08dc0b19eb86be8bac67b0c5c2068b847c.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-4-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-4-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB8085:EE_
x-ms-office365-filtering-correlation-id: 39fa080d-c9c2-48c4-8946-08deb0034d68
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|55112099003|56012099003|22082099003|18002099003|11063799003;
x-microsoft-antispam-message-info: e15pRitj49ceQWown3vBbEpkfC9f2YD5mDBCU1jJMHS2HS5rS2vglXO0BeQal8OjCdy8QhvzITIziLKP6gsQMnC33Vcr+WInRc4dhaYvdFOFTz6Xb1gXsuWqK46jtAK7o8YCsMGfzdvVcvrg05xr53xDtSIo32w4mkfgZ62ntLdaPWlzWX/fiGLSilqtuK8ROkuqYXy0qK9MzdxW4JlXryi+YK7yuig8VrYgTRjM+xqEamMN4VyAxVU8IFa98Kc1hSdyfYZaj+zmHDgt8Y9AaCkM7n2yG2K/q0q/y4NZI54rgQbvvbwTRBiABarQNCd+BXY06FnaKVt3KY8O+M7nNv7CHpwnKXT7cYA74t432rvYlwAz/xyzEPFFxs0daQGlxB7n2UQA+nceJKiGxWwzBYkaY7TVwuOiay4/BKLcg/8p+iVZ2Rf0M9DvVuI1TXStronp7th+etTvxnXLe3kXs+RjAnl/m8DsCvpuMeexdM//vThdjkwnP9vJq0EVxx+O7gQ32g1+okUtAbUpW9b2aD5JeyMiSzfbl4RRwCmp1evp8k/HhxOfamN5cAUbRnSyJQjsEYa/pF0hSDobZSikG+wOLrtA3MIz37x0SZJwATzH0x8iyrWuvhcduDLuZ8hkTpFQB3x7uW1PHKDsHOn40mkQGnZkdTMa2zyY8xOILb+I+LLOusM+hC8fal/YOHTP8ZjGJlgF1LsGNNDVzfWqsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnIzQ0d0Wkw1WEIzRVROYVc0NWRndjkxKzF1K3RCNVltNmpWcVFOZm8yUnZY?=
 =?utf-8?B?aEViNEdoQWtjQ2xscjNhTTRwL2drd2pqOEJZMi83RWZLUUFIUThBSnI0V1lp?=
 =?utf-8?B?cFA5MmkzOS9rS0UyeGZoT0dCRHd4UkNESVNzNkFvL2pHU1I1NzlaR0dNcHFZ?=
 =?utf-8?B?M0dVY0s2WHdTZ3VreEIzaExuZGxVam51OWg0bTBmcitGcHcwRjhVT0ZaczFD?=
 =?utf-8?B?V09lZXpLUy9VSmxaNlBjdmFtbXVxcSs3MDdTQXB4RjhRT05sYTFJN1ZHTi9V?=
 =?utf-8?B?OUdka1BmVjcxOTJ2c3lDS3BqZHN1ODRva2pkQzZzclViYko0VitieklTMVNH?=
 =?utf-8?B?VTNnZjhqTlRocWUrUFJPTjQxWXNCZjVKQmdSK0o0dnFNOWhEbGhIWmM0SkhY?=
 =?utf-8?B?ZGY4NGdwUVV5Q3FRVzIyYm5LQ0h6THdWdVU2QnBJUlZJRUF2Slc4aTZIVWxa?=
 =?utf-8?B?VWR5SW96ajFZZi8waHNJemtKVmhNaU1HMC9XRnNmZWordzRwQlRYTlAvUnI1?=
 =?utf-8?B?L2thTXdYcXZyRHFNcVdJWitDcmN0VUFhWkVXdmJiem9TSU0wMVZkdFlES3dz?=
 =?utf-8?B?WDlPRzlVT3kyQkNtZXZ3bnhkNXB1WWxrTmRUQ2dvYXVyTGdPUGluZEppaDAx?=
 =?utf-8?B?ZU1uMGI3bUVyZUVCNlhkYldZOTBXUXFhWGNiV1FOWGk5VTQxTk9GNTJ3TCtT?=
 =?utf-8?B?bGkyemVGS1NNL1ZVcXBsL2xWak5zOE1PQnU1L0NURC9MOFVIU2M1SENZeG42?=
 =?utf-8?B?QTVwV0RpclBwTXZWNWlLb25UV2ROd0hTSkhxYUxNbmh1ZVdDc2lIVlpmZFZF?=
 =?utf-8?B?SUhRK2ZyaW1zUkxERXVjNWZBd1BRMG9HKzgvMnhtVVFpb2FxSm1HRmd5WVR1?=
 =?utf-8?B?QXVQSFc1QkZXNkFoU3lITFFsT3FCdlJtRnhhSThNcU8xK1lZV1RYMmhLcmha?=
 =?utf-8?B?aG95SVd2OWcrdm01TE56cmZoTzV3eXQ5ak0yVk1ZZ3dZaXJ3cS84dGVZeUlC?=
 =?utf-8?B?ektJcWVXZjRxeDY0R0VZemNhT2JKRFJYMVYrM0hNdnFUSWV4QnJZRGhvWHlp?=
 =?utf-8?B?N290eVg5YVpJa3lWamV1WGNzMEZBM0tMNnRRd2ZrWlI5dzhNTHMyeWl5SitS?=
 =?utf-8?B?VHV3MGdiVVBwWkhHZnJiWC9GOXNBZEZtT2ZaM2ZYQXJ2YTlyb0IxdE9GNG4w?=
 =?utf-8?B?TFkzMUprK3Q2Y2JkejdTS1UyZ0JqV0R1aWFqMFBPeFppMkFBMWtXWUQ2WXcr?=
 =?utf-8?B?WS9qd0pEV1RZRktWb2ZYRElhbE1EZXB6cjc3aDBBRVdFbkRZWVY5cTJ6U1NP?=
 =?utf-8?B?VEEvbVUvOUNmTC9vTUxXOTMvYXZoRU41YjYzWExlNzBWZnJEMWNhRExiaWMv?=
 =?utf-8?B?RFR3VUJVZGR4RlY5dUNDVndpcS9kTFhxOWswcFcvWXVRN0IzaWtYNTJTaEhE?=
 =?utf-8?B?ejdUSDcvZzc5Zlk2TG96dTQ5NWMvaVA4RXJOOVFwL2ZRdGdTYVZYTjd3Zjln?=
 =?utf-8?B?VGhYTXUzYWNwQVQwWGpuRlc3U1A5ZkhSZXp4blA4dFcvUGxJNG1ISExSbzZT?=
 =?utf-8?B?azFNekw0a0tQc3FwN1ZNajZBODl3MTRXRTYxYmdDaU5HMHpLT3lxVDFtZ2xa?=
 =?utf-8?B?RmlXS3pTVDdCd1ExWGNIVUV5ZHZhT3dJZ2xBaWk5WFlnMHM2TXg2NDlaamNo?=
 =?utf-8?B?WW8vbkJzQkM1QklNQkFUVVdzckJiVFVuelhzZTA4a1NNZFdDTUgyVG1tTUR2?=
 =?utf-8?B?U3JSMlJ1NGUyMVYvZnc1T1JCa29iaytrZWpEMGY0Umt5bVlZODdSd2phdDE0?=
 =?utf-8?B?NUcxQ0VuK3YzcTdkZ3NaTXJ0MkpSKzAwaTgrTktGcjE3dksySUQ4ck1veC9I?=
 =?utf-8?B?ZGJ4c0Rubmdoc2kxamhnOXNvbG9sNndOaWJzejIxUlhxcWNobys5WG5yYnVZ?=
 =?utf-8?B?ZUpIZ1gyZXdiT1ltQUFXNGQ0bmdVT2dDS1I5NGVsdmlva2tjTDZjekY4YUh0?=
 =?utf-8?B?d280c3FmWlhhVnF2Q1VMWFAzOU91d3AwUlM4alMrL25ieUg3YllQcUYwQVlu?=
 =?utf-8?B?enBMV0FOeHR0ak9SU0xlQ0Nwd3pCRkJXSzZIWkV5dW5BaFh1MGNKS2xTQU1X?=
 =?utf-8?B?dUhRTExpNzM1UDhjYmNpTGpnNU1iMmYxcjNBcVhWb2pXamFuZkw4QWd1VlJq?=
 =?utf-8?B?SkIvVURoYkRlWE81SFZjSlJZSGkzS2hqbHdESEJ2WkxFdDZiK0pCN2VEWUd5?=
 =?utf-8?B?SDY0SmxxU2lYc0tndm9yMXlsMUNWcjRlaEI3VHdXM1ZqbFgyVWwwdzU0a01N?=
 =?utf-8?B?MzVmOEhHbGlyYmJuamthWWlxTVV1Vm55ditqSmJST2pLK0g2bHo4U2QwRVIy?=
 =?utf-8?Q?r2uZbkOszU/KFE+x26pTAYiqQE6AhX039jnBo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B93E372110B784DB405F75368E171FD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fa080d-c9c2-48c4-8946-08deb0034d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:48:56.1875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UWYYkW8Kpr9yhqGg7ipLu/hUD+wRvoyTDuSqWParaPk/N4umLNSjW54/3/Ix0ncVEeZZX0Sj17cO7IHjYcbq4g43mySpxi40G9RUS+ERa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8085
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

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjA5ICswMjAwLCBBbGV4YW5kZXIgRmVpbGtlIHdyb3Rl
Og0KPiBGcm9tOiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3Vw
LmNvbT4NCj4gDQo+IFN1cHBvcnRlZCBkZXZpY2VzOg0KPiANCj4gLSBnZW5lcmljIFBDRjg1MDYz
IC8gUENGODUwNjNUUCAobm8gYWxhcm0gcmVncykNCj4gLSBQQ0Y4NTA2M0EgLyBQQ0Y4NTA3M0Eg
KGFsYXJtIHJlZ3MpDQo+IA0KPiBUZXN0ZWQgd2l0aCBUUU1hOE1QeEwgU09NIGZyb20gVFEtU3lz
dGVtcyBHbWJILg0KPiANCj4gQWxzbyBhZGQgbWlzc2luZyAuZGF0YSBmaWVsZCB0byBydjgyNjMg
d2hpY2ggcmVwcmVzZW50cyB0aGUgbnVtYmVyDQo+IG9mIGF2YWlsYWJsZSByZWdpc3RlcnMgKD0g
bGludXggYHBjZjg1MDYzX2NvbmZpZy5tYXhfcmVnaXN0ZXIgKyAxYCkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXJrdXMgTmllYmVsIDxNYXJrdXMuTmllYmVsQGV3LnRxLWdyb3VwLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEZlaWxrZSA8YWxleGFuZGVyLmZlaWxrZUBldy50cS1n
cm91cC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5z
dmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL3J0Yy9wY2Y4NTA2My5j
IHwgMTIgKysrKysrKysrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9wY2Y4NTA2My5j
IGIvZHJpdmVycy9ydGMvcGNmODUwNjMuYw0KPiBpbmRleCAyMTY0MGIwMzljMS4uMTgzYTIxNGEz
ZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gKysrIGIvZHJpdmVy
cy9ydGMvcGNmODUwNjMuYw0KPiBAQCAtODAsMTIgKzgwLDE4IEBAIHN0YXRpYyBpbnQgcGNmODUw
NjNfcmVzZXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gwqBzdGF0aWMgaW50IHBjZjg1MDYzX3Jl
YWQoc3RydWN0IHVkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwgdTggKmJ1ZiwNCj4g
wqAJCQkgdW5zaWduZWQgaW50IGxlbikNCj4gwqB7DQo+ICsJaWYgKG9mZnNldCArIGxlbiA+IGRl
di0+ZHJpdmVyX2RhdGEpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+IMKgCXJldHVybiBk
bV9pMmNfcmVhZChkZXYsIG9mZnNldCwgYnVmLCBsZW4pOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0
aWMgaW50IHBjZjg1MDYzX3dyaXRlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBv
ZmZzZXQsDQo+IMKgCQkJwqAgY29uc3QgdTggKmJ1ZiwgdW5zaWduZWQgaW50IGxlbikNCj4gwqB7
DQo+ICsJaWYgKG9mZnNldCArIGxlbiA+IGRldi0+ZHJpdmVyX2RhdGEpDQo+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiArDQo+IMKgCXJldHVybiBkbV9pMmNfd3JpdGUoZGV2LCBvZmZzZXQsIGJ1Ziwg
bGVuKTsNCj4gwqB9DQo+IMKgDQo+IEBAIC0xMDUsNyArMTExLDExIEBAIHN0YXRpYyBpbnQgcGNm
ODUwNjNfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGlj
IGNvbnN0IHN0cnVjdCB1ZGV2aWNlX2lkIHBjZjg1MDYzX29mX2lkW10gPSB7DQo+IC0JeyAuY29t
cGF0aWJsZSA9ICJtaWNyb2NyeXN0YWwscnY4MjYzIiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAi
bWljcm9jcnlzdGFsLHJ2ODI2MyIsIC5kYXRhID0gMHgxMiB9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAibnhwLHBjZjg1MDYzIiwgLmRhdGEgPSAweGIgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm54
cCxwY2Y4NTA2M2EiLCAuZGF0YSA9IDB4MTIgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm54cCxw
Y2Y4NTA2M3RwIiwgLmRhdGEgPSAweGIgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm54cCxwY2Y4
NTA3M2EiLCAuZGF0YSA9IDB4MTIgfSwNCj4gwqAJeyB9DQo+IMKgfTsNCj4gwqANCg0KLS0gDQpB
bGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
