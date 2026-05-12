Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2747CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8A5803C6;
	Tue, 12 May 2026 11:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LT9Yk2P4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FE283015; Tue, 12 May 2026 11:08:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1DF80398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBFaS4SEGxuiIO9ADrmuVm2/DfLJ3pQmyP3o6EbBC/9sgYfOYtg3WVwfKuO5irPeMKP7YEVL4/5ntkdPh+Vt1Tw6Tjo8EZ7s6xs5wvcdY4E6dI9qWFV1/a2duKzF9USji1oekN1inZOouIeBcGbthGHYQvYmynwEO7jVs9VNik+U+deSIdbaIw7REiqiLtxCa6P6Kne+j33q3ZNwocwxAQ+9Bmvo44OmyIGHF5bWywvykZ0X9H3yJfEhLtWX0wXyOgGeMk3UTR5mGGmwvfDeOcHGicvMneMQjiWyUPoUnd0lSePiqE5XZHDVtlLPEe/oVMFlE0qIGzRj9OVx4uv0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xgN1HYV43SHkc8AtcsXaHBPlV48uzq57YudrVuXPLU=;
 b=Q8VlHN0nO1yqPTunLpFrbVi0ra3DsyF+opYCo9zKD+dkkDzteX2hnpiituXtPD+aUT3qulHZaFOuH3big1Jj1xuZV29jR6RKkvnuL7fuXqc4J6yXs4MGDYqtSRyBmL2uqE72qd3yyzI+5FeRVu9F3/LDGkeKuoi57XkjQg+XKUulH5F4/oTe1d+AN1KNryiqj60iQ83z9zpVJTGJLz73XHqZ0leljjvJ9OEHoKc5UyMEtsyah9yq9ZEbU0LU8v0/LFbBlTXLQY9u40wAmr0ekkjifD4WY1/PCM4YqaksTpz8WY9Li3f4pFldvyaKurdFV5891VAYPdkVmrgVWm2iTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xgN1HYV43SHkc8AtcsXaHBPlV48uzq57YudrVuXPLU=;
 b=LT9Yk2P4tzjKrjIy7dP2z+eGeY3S/aDvqf71gPNe+0NFQLvVklp4lbdIgwXpy9PeCLyphW7O3QN52T53gy/B+75CDbIuAgMIQnlgwNlP2NAMMq8U7F64hS6NPj3H3s2IFC2zfQQLODnfXyrNQ29u7iftZ7XXXT65UnW3/atQBLJGl/YFrm512YCAup5aUhfbLPGjoOgMj7YKMrVY3Vc5sberkzr0OTwHp1Yq1kNhYbqYSMj7WDHuHvpFr7X8gP9BW/kgakyHcEBvz7apQxRU9aNiE+MwMbSTe/2HhCTuiMciQwVtIpkLzU6E4Ls6FaB2Jh/lo6nn7QQiHIltCQm04w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:08:11 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:08:11 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 6/8] rtc: pcf85063: support loading quartz-load
 capacitance from device tree
Thread-Topic: [PATCH v2 6/8] rtc: pcf85063: support loading quartz-load
 capacitance from device tree
Thread-Index: AQHc4T8wQxL2JngXPEeeF0u21q9drLYKGzYA
Date: Tue, 12 May 2026 09:08:11 +0000
Message-ID: <af47885bcd2ce50eee5596f09d6701fea51bbb33.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-7-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-7-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3956:EE_
x-ms-office365-filtering-correlation-id: f980b022-c56d-4470-0ec1-08deb005fdd1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: jDQQPfZFuFglVov1NY2PXPTbHPIpIgLM2VlaU/yrCVMt0L13wpmVADyfQjBm6S+1TZIdco6Dj1rWmE4Wy3tHsb4ltbJqWenGvbka5vakN2/TjgZi1nH3H9jD6Y0SBvRIo6SsQvaPua/Dt+a+m3lyspWUC8qzH8UM1Gvu1yvj2RVER0h3B3FqLC5+8G0bKL9qqCFDPjSNrZiz8SDXYga7e4Ii2vI0JreHSJf1A3wCEHV2CpThYH2aUnT1GsbucWBsHsaAT3ObnQd6LA4GkE4ZwNr3V8A1mgWiT+4K483ZY3aw8v2+nxqbqPPcf23xns0u1wB49RxOFAcr9lk7vmZsK5ETzA3HUzH1iwd3vcYJ96gpoDd6aXw8BUfPfs5R9NXhJSzUqzes4VYNLnlUTQ0pNfwGu4IZu+EEAA9EUb0knpqhBVR5NE6BHw7skfcx6TPDSRhk/rfjrj9psKYDkCM/v/jBEKw58hbBb9DiaJqH482PIIYmqU+4d+TmOtFmDHQG3qNX8LmKKxRz9BsY9spUA39S4UZdU2b9LeLMfUfCVO4FojyeLkymrqYeiUpbh+aTDj8o4TXdW1HaxA27J97MC0XiKEhfkgiCPe4dA4Mz6Z9jd20EDztBD/5bStIWtBgnLCZAHe9TCIufe6GsehMqRuccgMYNQMY67wRBP1zaH5QQq8CWxmfFfq62cRX0oOGVvxaiX6ZuvmxqCr2dmW3qsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29WYUpPRDNSUVFMaThwT28yRk1jZEdUK1l0S1NvMkRBSHRUUTI3QVd4OFQ4?=
 =?utf-8?B?Rk5zMEJOWlpFbzl0QlNTemkwcC9iSTN6RG1JM2dMKzBacnNkZk5HaHF2eG1l?=
 =?utf-8?B?YldsblVmeUVpNi9PdGpXNFpuVXEyUGJpUEJLYnJ3ZnRNcnFoMkwwdFNkL1lB?=
 =?utf-8?B?blFZMmZVMXgyeHo0UDM4VWNtU1prMHlzc0tGcThpN3NzOGdPNHpPdERWZ0k0?=
 =?utf-8?B?RmFSUi9lMmRsTWZOaDNwcVI2MERJME5vaWFMZmdIQnR1aW10eHFkdGx4cGlN?=
 =?utf-8?B?cktiN2R0NnB6c0Z0OGtRR0NzRmIxQlVNWFJuRU9uRnA5UWFDVU1uWS9oUzRK?=
 =?utf-8?B?eHBHaTdzbFRiVHRKSTVQamk4clM5UXNTYnFSaWlXclMyWVdPaVBqc3lqM2Zh?=
 =?utf-8?B?YmV0MS9FckxzNE1aOTd5TEdVa2N6T2tHQzJPUFlxUDBJTzNmZ0JyaG9wdFdH?=
 =?utf-8?B?N1RiR1VMZmtkNzdzMEZqNUhBWlNiZlQ5V0s1Q2g1d2xtMmo5cjRLTWlpNTVk?=
 =?utf-8?B?UGFzWTFpMk1qR2ludlpVTnd4WXZZdmZmZVAvWml4MUcvUFBGcWhqakhMYmhu?=
 =?utf-8?B?NlppUlk2VklmWXhxc1YyZVZNL0tDRS9PYVR4ZVEyVTA5S0JKbTBhZG13QVQz?=
 =?utf-8?B?SmV4c3BoYmlTclVHdlV5Q1kxaVpCNEdaV1kwcjBVdzBhNTZITDk5dXpHRVhL?=
 =?utf-8?B?aGJsNUIrODhmVHVYcFIvbGVUWVhhVXVFMHMwQWZMVW5INjRjZTZFc1J3VHIr?=
 =?utf-8?B?dWpNUkJJODJScTBSS21ZakE0MGo5NzhzY0tUTllEa0xSR3RmM0oxTnorc2g2?=
 =?utf-8?B?eVJ0TTZlUjVTWm4rdVVUQjFpTXl4SGh5eENzYldNUXZ5U1M0WU9UWnplWWlR?=
 =?utf-8?B?TGxsV0FwN2xIS2l5a2hHVVZSanljMFJVaXFXRXYwMUMySmRFYWk1KzNnRDdn?=
 =?utf-8?B?aFh3VzBtQXo2Niswc0tBNFhLS1N2MlNWQ0h3M3REWW1xcjlBT0lIaC9ydTJO?=
 =?utf-8?B?VXFaUWhQRE4vOHFiN0h2R1ZhcktGSVhHdW9vZ094MVY1WWtPa2hRMmYvWWl3?=
 =?utf-8?B?TnJ3ZklEdGhXUm9rZUFMcE5KdVRMZEZiVkJVRHZGSFNkSE5obmFSNjFjYlRU?=
 =?utf-8?B?WDJlLzFQbnlrblFCcnZHMEhtMTRvOTNra1l3VTlLckwxMVN0ZERGenNaNEp2?=
 =?utf-8?B?c2RpNHJ1YWpZL1Z2Y3JrYm5QQ01JTDNWU285V3lrbFV3Qk5QTmVRZlJBbk9i?=
 =?utf-8?B?TlYyam54eHlac1JZWW5qbk5HVzlHWnRPYkxMT20vSUtZSjdudkNXS2JLNXpS?=
 =?utf-8?B?OUFBMmhyZ3pJcmJhQ3BzMGh3b1dOS2tJdGJ0a3NkajJMalppL25FWFZMcUtT?=
 =?utf-8?B?SlhMdVI1YnQwTHk5U3kwdjAvWTVmeXJ4WkVRRVZHL2RnT0pkMFRvNitqR0Ez?=
 =?utf-8?B?cHk2OUJrSDliY1I1cEJFTWlNaGZrWjFiY0ZaWHArVUdDNWUwWklmcGpiemJk?=
 =?utf-8?B?UHpaZE0yZ3JjYzduSW1TQ0tVeVloZUJqYmdZcThhS1Q1TE1TaDNEd2pnQ1VD?=
 =?utf-8?B?cVIzL3FSMUlwanBXMVlLR0ZObW13M1JUVXpOeThBOElXdlFwV0txWER0T2s1?=
 =?utf-8?B?QS9ZZ3JoR3VQS1crc3Y5d1psbVpVdWFiS1FpUUtZM2REY2RWdnhMN1NoT1Uv?=
 =?utf-8?B?aWNQQ2VmdHNtLzhxVnl2Und0MGdaSFdFckFrTWowOEF2aFVJYlhjWW8rWUk3?=
 =?utf-8?B?eHRPSjkzcmlYZm8zVkoyeG9oeG40RVhQNVlpQ2RuTmp5T1JsY28yZGZHMDVK?=
 =?utf-8?B?Rlo5Zk44VGxpS1J2VmtnZ0I3NFJJY0FqMm9FYUtQb29HUHlDZE0wYlhVcnVD?=
 =?utf-8?B?UkxobFFoSWdFV2FHOCtRNkxvdUh6MEpMdXNFelhNY2Q5clM1SjVlWFo4Z3dT?=
 =?utf-8?B?OUpwL1VnWUR0OEtJaVpPUzZCNTkxT1hhZjRzOTVaQ0lVQzRmTGFnYUdVNzgy?=
 =?utf-8?B?QlNVNlBacWkyU3RiUVN6YXV3NTdIaURUY2JCdFpTY0s5a3NGZnY1Y05SOUJs?=
 =?utf-8?B?d0p1cHhtSEpKKy92V1JkVHdZaHd4Ti9iZlBoZnkweXBKRkVOQzVmM2JnbHJx?=
 =?utf-8?B?R0JaQlFvc2lQcURObnNpamphOTg3aTlXVFdQZTJ4K1JLRmhGZ0w0L3lXK3Q0?=
 =?utf-8?B?bjdaanl4MzluSnV3dHpRSlltc2lnS21LMHZjb1RPVGQyZHd3Nk82MTJFVHFL?=
 =?utf-8?B?Umpobk1tU28wY2hPaGRidEJFUG1kbnlJM25yT0t2aU1HWDJ6dHB5T09Wc0E3?=
 =?utf-8?B?WURzYjV6eW44bmEvdThWMEVLWVh4NHVlU1BBdk5CUzBydld0bSs5N3Eyb2Ri?=
 =?utf-8?Q?XC5AOkDiTyo3Fhp92Z1eg5gp1ssm/ndqIGTHr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17C04C2C3436DB46AFE9AC3DB0532F34@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f980b022-c56d-4470-0ec1-08deb005fdd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:08:11.2075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDYQs7lhKX3+Wi/SxtjM67nuQjVaip9DHf69Syzi57bHfFqTcd1WtmJJGJYRXF1jlFsjRuJ79/cjCp5JPdf4MF2Ce4rBVN2exO9BGmglZPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3956
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
LmNvbT4NCj4gDQo+IFVzZSBwcmV2aW91c2x5IGlnbm9yZWQgcXVhcnR6LWxvYWQtZmVtdG9mYXJh
ZHMgcHJvcGVydHkgZnJvbSBkZXZpY2UgdHJlZQ0KPiB0byBzZXQgbG9hZCBjYXBhY2l0YW5jZS4g
SWYgbWlzc2luZywgbGVhdmUgdGhlIGRldmljZSB1bmNvbmZpZ3VyZWQNCj4gYXMgYSBkZWZhdWx0
IG1pZ2h0IGhhdmUgYmVlbiBzZXQuIGZvcmNlX2NhcCBpcyBsZWZ0IG91dCBmb3Igbm93IGJ1dA0K
PiBjYW4gYmUgcmV0cm9maXR0ZWQgaW4gdGhlIGZ1dHVyZSBhcyB0aGVyZSBtYXkgYmUgZGlmZmVy
ZW50IGhhcmR3YXJlDQo+IHdpdGhvdXQgdGhlIDEyLjUwMHBGIGZsYWcuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3VwLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvcnRjL3BjZjg1MDYzLmMgfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcGNmODUw
NjMuYyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gaW5kZXggMGIzMzZiOGM1ZWUuLjEwN2U4
YjRkNGM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9wY2Y4NTA2My5jDQo+ICsrKyBiL2Ry
aXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gQEAgLTE0MCw2ICsxNDAsMzAgQEAgc3RhdGljIGludCBw
Y2Y4NTA2M193cml0ZShzdHJ1Y3QgdWRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LA0K
PiDCoAlyZXR1cm4gZG1faTJjX3dyaXRlKGRldiwgb2Zmc2V0LCBidWYsIGxlbik7DQo+IMKgfQ0K
PiDCoA0KPiArc3RhdGljIGludCBwY2Y4NTA2M19sb2FkX2NhcGFjaXRhbmNlKHN0cnVjdCB1ZGV2
aWNlICpkZXYpDQo+ICt7DQo+ICsJdTMyIGxvYWQgPSA3MDAwOw0KPiArCXU4IHJlZyA9IDA7DQo+
ICsNCj4gKwlpZiAob2Zub2RlX3JlYWRfdTMyKGRldl9vZm5vZGUoZGV2KSwgInF1YXJ0ei1sb2Fk
LWZlbXRvZmFyYWRzIiwgJmxvYWQpKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXN3aXRjaCAo
bG9hZCkgew0KPiArCWRlZmF1bHQ6DQo+ICsJCWRldl93YXJuKGRldiwgIlVua25vd24gcXVhcnR6
LWxvYWQtZmVtdG9mYXJhZHMgdmFsdWU6ICVkLiBBc3N1bWluZyA3MDAwIiwNCj4gKwkJCSBsb2Fk
KTsNCj4gKwkJZmFsbHRocm91Z2g7DQo+ICsJY2FzZSA3MDAwOg0KPiArCQlicmVhazsNCj4gKwlj
YXNlIDEyNTAwOg0KPiArCQlyZWcgPSBQQ0Y4NTA2M19SRUdfQ1RSTDFfQ0FQX1NFTDsNCj4gKwkJ
YnJlYWs7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGRtX2kyY19yZWdfY2xyc2V0KGRldiwgUENG
ODUwNjNfUkVHX0NUUkwxLA0KPiArCQkJCSBQQ0Y4NTA2M19SRUdfQ1RSTDFfQ0FQX1NFTCwgcmVn
KTsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnRjX29wcyBwY2Y4NTA2M19y
dGNfb3BzID0gew0KPiDCoAkuZ2V0ID0gcGNmODUwNjNfZ2V0X3RpbWUsDQo+IMKgCS5zZXQgPSBw
Y2Y4NTA2M19zZXRfdGltZSwNCj4gQEAgLTE1MCw4ICsxNzQsMjIgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBydGNfb3BzIHBjZjg1MDYzX3J0Y19vcHMgPSB7DQo+IMKgDQo+IMKgc3RhdGljIGludCBw
Y2Y4NTA2M19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiDCoHsNCj4gKwl1OCB0bXA7DQo+
ICsJaW50IGVycjsNCj4gKw0KPiDCoAlpMmNfc2V0X2NoaXBfZmxhZ3MoZGV2LCBETV9JMkNfQ0hJ
UF9SRF9BRERSRVNTIHwgRE1fSTJDX0NISVBfV1JfQUREUkVTUyk7DQo+IMKgDQo+ICsJZXJyID0g
ZG1faTJjX3JlYWQoZGV2LCBQQ0Y4NTA2M19SRUdfU0MsICZ0bXAsIHNpemVvZih0bXApKTsNCj4g
KwlpZiAoZXJyKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiUlRDIGNoaXAgaXMgbm90IHByZXNlbnRc
biIpOw0KPiArCQlyZXR1cm4gZXJyOw0KPiArCX0NCj4gKw0KPiArCWVyciA9IHBjZjg1MDYzX2xv
YWRfY2FwYWNpdGFuY2UoZGV2KTsNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJZGV2X3dhcm4oZGV2
LCAiZmFpbGVkIHRvIHNldCB4dGFsIGxvYWQgY2FwYWNpdGFuY2U6ICVkIiwNCj4gKwkJCSBlcnIp
Ow0KPiArDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4gwqANCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
