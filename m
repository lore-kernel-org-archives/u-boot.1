Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89433CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C4C803C6;
	Tue, 12 May 2026 11:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VmexqQDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 976338341A; Tue, 12 May 2026 11:12:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BDF280398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLc4ytAO3A+Q6lQPOXGXMS/A5AMprR3eKgMGYU/KjO1aZduGzJCpwCfTaf1oTV+ty71S/f3OY4zr3MQY2wZVZQhvGuJvc4XOOoPpbbLgnhJ4shh0w3VAM/GnMMmfjLELdOeVyPeA5Afa2zSoad+Uwwz7lPOPraLUxwujVZOh6qsAEGKUxT+I+l4ban7wYk2er0Jw8qmxdcoL4z5vxlXkKRCD4U2IDhq3ZBxAaV2Rvx90TNVc/8QNYnwQVrc9C30q4thVdP00/GKxDm/TwC2yueaU3kYZjemAblRRynywCTX9kyppnIBJ19TDveRAUD+YlvLBTAFD1UXJjhyT0Go9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaFVvR/dgD3ZvuGESiD979tlkz1MnIrTRi47LAyATgU=;
 b=qlQaBdkDRuRAk2H5ynagEuxQ6nDBbCntx3B40VO3dgaA9+T0JDabz0Y5/wkCCK20UeLCwn/XHotlV0QmMy9GSMtms8gcJlQn1A0mRkIY07tTH6rn8dSkm3mVFcGAygOkOQOGSOTsLHH84XpWjpY57uWw7R+7CUwEFMc7VL7vtvY4c0Ho4M+GO3dxaRkS1EsLIUUMBi/JK7/eetA69s4F364A3bDPHJrnIECyu/a5zFyrZERYA03RnJcrWu90EplximvBu+3MODdQxirl1PW4tdM9P61hNTHFZosMiM4QlUzuTw1W2Qt/JXyyYfdyDwqULvf4Xj0+HnUOBZtiepH5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaFVvR/dgD3ZvuGESiD979tlkz1MnIrTRi47LAyATgU=;
 b=VmexqQDHtkFFDowHgB0vUEOvRvTtPduCqGYjFza28FQ0fE1V4rPaeGp6fTu+6diwrZIs636z9Wlol7kXs543Rc7cYeAOttiyVEx9Z6gjR+t0GsaaM2vMPpoS/MJnWjzG53h24k/lLB9kjzD/hioZ7XIz/dqYA+zIPjuuqTyFkqv91JNMBOxJVqBioqEAxV0AJtEK2ZaCmP+cKjsvf6z0jG/JqHd7ZhYNwIf2/ZQttJ5OepSMgYrkLzkUXLLJjfXIbvzPQUYYA592HAW2dfvQzf52hLIWYcoRmUI/hQspYQXzGiNyT1KioYc5B3XVVwbIXd3SgKl4Apztz6IoAV86RQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 09:12:24 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:12:24 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 7/8] rtc: pcf85063: add power loss detection during
 probe
Thread-Topic: [PATCH v2 7/8] rtc: pcf85063: add power loss detection during
 probe
Thread-Index: AQHc4T875YO0r1K0/0e+gu0QVGJB9bYKHGMA
Date: Tue, 12 May 2026 09:12:23 +0000
Message-ID: <880cef6455865fcf5c47867f3e9f9d16005e78e7.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-8-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-8-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6517:EE_
x-ms-office365-filtering-correlation-id: 95d1f575-c440-472f-2dc0-08deb0069461
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|11063799003|56012099003|18002099003|55112099003;
x-microsoft-antispam-message-info: aa4U6yYvYWyuzsqx17HNPDsU0jdkyA6Ia4Q7gNrAUDzy4cxmEsjBaAGGKtOEB8D6s5eR+swkhofUnVOvojkPJFHU9d+JwAN10T9Ojon1HuPDac1/5zBU3tKZxtMQlZ2RHRocZiqS+J6rvsyzpYnK9P/6nILB/wlE/rn9W0gkLfVvPyAPQb/sPazmtWNPiccnfkk2TK62Gx3PbAkTsUn8m/qcV6OA/+VY0tB5CGN9S4cpdpu/pXT6+OK14i/LJtn7RD1YJ2iDhEFbhrgBqj9gQ3QTkUKH53HYs6I2Iro+pTEVqFh+9dPWjHPpUnkukwng0t6IY6qOMgAxIBKBiYKKuarRA5jxW8nCEgfvev5egRe6JjkvNaQnpuJHZhrETOR6KEigBIQpH45U2k4dUCzulq0hChGV5D54FWsm2B7yjtU/KVf03wb+9rA5mUrGg9tULFbm1q7OZ3v7C0wWTqo54pwc1eDZPnTy3gdQP2G/wG/dQr7sS7/U1BgKg/LRgsczlFyKSdsuIiozaTE+KPfeZICL0+3DHOQkOptbicDhwtXE1AhCpdSvCFEMx5M19Oab3dIVI3+uubOklPja9npdmgSn0b30ST3vjEWNhJW/0oRTkxvZFcuzn7y37T9SYDtZEUugsAqDQIpCSkurBG2HdnDX4j2iHrLwLolhUHI/gl5WDBq/DKnMRD+pQu4hqz21sTZC9X6SgaDbSzQMR4TMtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(11063799003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWI5OWxXbVdJTFc5M2VQMjlEOThGWlZIVFVYcUtXSTltMjA1NTBneXVDSCsv?=
 =?utf-8?B?c2Qxb1NHNVd0V0pFVWhPdjc0NGRhc1k4N2tKVTkrZWk0cm9hSklVYStDdkcv?=
 =?utf-8?B?TkdIdFI4SGxMazBCdlRWaS9BKzhOMFNQVjZ2SFo5cUpoUHJXSHRaVDBqU3Z2?=
 =?utf-8?B?b1ZHS09ZR3dPS250QkcrWlFCUHJab1BIL2hyYzhsVXdZWmgwK3MxL283L1NW?=
 =?utf-8?B?dHhaT0QrbmZKZWJkNEpjTDdWdmttcFJYclVab1RsNitKbVJvQXB5SVdYdGpD?=
 =?utf-8?B?UkdlQzJFWS9BZjJyYXdQb0dDa1B0U2wyS1RKV2VWMkowRnA4MTJWUGZ0SG5s?=
 =?utf-8?B?MXdxMno3RHlEb2lHT3IyQ1dMUDhwaFd6YXhqVytMMmpLaklvZnFSdXBDNGhO?=
 =?utf-8?B?Tm1aMlE3MnJZcWJTZlErVTZ5clZpblBwYmVuUEZJb2d1Z1FxWTE2RHg0bVIr?=
 =?utf-8?B?UWcwZUgrSGpya1hpazFBbll6TS9TaXhGSU9rK2pOK2ZDQUlwOWJNeGpGWC9j?=
 =?utf-8?B?SG5hQzg3N3lpQWN4UXhYUFd3TkhQWFNsUHU5VmFtd2YvVE91WDJSWkx0NnJz?=
 =?utf-8?B?ZGpTYksxYWJVd0I3enE3Z3ZFTzRiNXA1TmEyeWFURmVabUltTG1sRWtWTHFJ?=
 =?utf-8?B?RDZHdkxaRURvaUFJRnIwNmJURVNHTFNydHNWQ2QxN3VIejEyRXlnaU9sM2kz?=
 =?utf-8?B?MEtYQkxtZDl6WU5KZkFQRklYUFMydzQxMWphQ2doK3NNMEhadzNWSk9OTldh?=
 =?utf-8?B?MCtRTmZHVmoxcTFvZmtZa1Y3WFJmaEhTdEluMVROQlgwV0VSbGM4bFU5clhK?=
 =?utf-8?B?ODhsTXhiTjVNeWM1ZnRUbVhldndEMHcrYnl6L01ybHNBV2ovaVBIN1dEdDNT?=
 =?utf-8?B?ZkVyV3BqanNON2p2c0lHWStCclQzOFZmVnI4eEJucU1JcDZSTHk5cGxFZ0VP?=
 =?utf-8?B?QzU4YlBXb3dHNDJRMmtlT1pCdVdXd242NHdXQjY5TlJ3b1hUSVBCMmVhRm1T?=
 =?utf-8?B?a2VWblovSUxxSzdDRE90T05RS1czb29yOXgvS3ZMUm9GM2VXdUs2empuNmZV?=
 =?utf-8?B?aDdyaWN5cW1qYUJBSXZCYjJKUGlUdWNYVENoRlhoRlpEc2dLTTl4N1RyOXU3?=
 =?utf-8?B?dVlxWDFxV2VNNEJna2FSaitrSUhIZWVVY0c5S1VrYitLZFFoMGRrQ25pTS9S?=
 =?utf-8?B?aWkvTzdEaVErNEpuak1XOWY3bTF6bW5oZENVd2JTeFhzYW5OUW04RDV1bi82?=
 =?utf-8?B?Tjd4cVp4MUkvSzhBcld5SlVUcDBleDlNNnZ4djlMNkhSSUs0WXllOUFnT3BU?=
 =?utf-8?B?QUZwMEpCV3NYaEdUUEZraklPM3dFck9MT1Z6Z2Zod1ZTV0J4a1hDYm5MTVA4?=
 =?utf-8?B?a3I5VGxRakljazM1L2I0Qm1aK2NEdzkrN0ZyRFY0REwxcm92ZWE4RnpVQ0t4?=
 =?utf-8?B?WTVyNWgxWDE0SUFDY1J5WXR2dFoyQlBuV0V3L0I0d2hRSHJKRncrTW5Wc0No?=
 =?utf-8?B?aDlSU2MxblZUQXYxUWpkQk1KVEhTWklxU0dEZXhteFRkY3ZJSkowMWdQK0cx?=
 =?utf-8?B?R2JOTFVrN0V4ZlhWVnJqdjA1bmV3dVkwM3MwbUxMRmp0M1BPY2FYeFVxbUhK?=
 =?utf-8?B?bS9CM3hpTXdXZXdNdWJLQk1uS2ZQUHVTQS82L0dZRjJKOCtycm9laWZHdElX?=
 =?utf-8?B?T2Z2QmYwRUphdFAwb1FuQTBKSjZFSTZlK2ZwTGpkUEJDTGZKRDJRU3VxeXBl?=
 =?utf-8?B?RlJLQjZ5K3UvZlZnZHF5eFVDdWRnaUNGVjluLzhVV2EzR3JVMkF2Tnk0cXFx?=
 =?utf-8?B?VGl0Mjkxa2s1TjVydHQxa2VvUnVQTFBUNkhQZFNKWFJ6bXcrRUFub2Nlc3hB?=
 =?utf-8?B?dXQ5bmI0dnBNYURmd3ZOS3R2alJncTZiMlpBS1dJRVEvK3MvSVU0ZXY1UGln?=
 =?utf-8?B?ZVhINHRtRm1od1pvMXJNOTd0ODNsVjVFUEJqVlN6eVlGa294L3Z4UGFTdzlz?=
 =?utf-8?B?c2ZNQ2I2TGFPUmRPVWpxMmoxdlJzcUdGQlE5VVMzVkt0d1pCTG1GQVczL00z?=
 =?utf-8?B?UERqZ1loUWtpVm42VzBQY0tKb3RrUU1HZ1hTTXNmOHh2bWR6cFMvVndzYXBB?=
 =?utf-8?B?bUU4WXR3RHV0b1ZldUM4QW4vazBzR0tkTCsyMzZUWEF3bFRZU01STThOdTVv?=
 =?utf-8?B?RjRUbkZ2WTFiY25JRGljLy80ZlNxdUhCeVBMNXlSQ2J5bXZiQjFRKzVncDQv?=
 =?utf-8?B?K29LNVQ1VzQ0QmNKdlBzTnBlZ1dlZFpqQW9HY0FLM3ZadGxiY2U5VE5TbnNZ?=
 =?utf-8?B?NTlINUYvN2dEVkJBbjM1YnhkRGZmNmlxWFk3dEQ1SW1UeFdGdHVGRUF0MldY?=
 =?utf-8?Q?yYkwIi5PeVqWzRF7cFXqdYxUTnQZjDZIcIxlR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D661275FE7F0F84E96039892CF6DDC9D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1f575-c440-472f-2dc0-08deb0069461
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:12:23.8613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pePCqdsbiB0T4G+ArGzS6xUDZ9MI1OAh6AfQ+NZEsFoIZl5kuLQiUcBEjZ4zCR1meRl0GlROK94+9hJNiA6bsenmnmIzDswuiQWlmsuAJGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6517
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
LmNvbT4NCj4gDQo+IFJldHJvZml0IGZyb20gdXBzdHJlYW0gbGludXggdG8gdHJ5IHJlc2V0dGlu
ZyB0aGUgZGV2aWNlIGFmdGVyIHBvd2VyIGxvc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3VwLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29t
Pg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvcnRjL3BjZjg1MDYzLmMgfCAxNCArKysrKysrKysrKysr
Kw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ydGMvcGNmODUwNjMuYyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gaW5k
ZXggMTA3ZThiNGQ0YzguLjQyMWM0MmMwYjgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9w
Y2Y4NTA2My5jDQo+ICsrKyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gQEAgLTE4NSw2ICsx
ODUsMjAgQEAgc3RhdGljIGludCBwY2Y4NTA2M19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0K
PiDCoAkJcmV0dXJuIGVycjsNCj4gwqAJfQ0KPiDCoA0KPiArCS8qDQo+ICsJICogSWYgYSBQb3dl
ciBsb3NzIGlzIGRldGVjdGVkLCBTVyByZXNldCB0aGUgZGV2aWNlLg0KPiArCSAqIEZyb20gUENG
ODUwNjNBIGRhdGFzaGVldDoNCj4gKwkgKiBUaGVyZSBpcyBhIGxvdyBwcm9iYWJpbGl0eSB0aGF0
IHNvbWUgZGV2aWNlcyB3aWxsIGhhdmUgY29ycnVwdGlvbg0KPiArCSAqIG9mIHRoZSByZWdpc3Rl
cnMgYWZ0ZXIgdGhlIGF1dG9tYXRpYyBwb3dlci1vbiByZXNldC4uLg0KPiArCSAqLw0KPiArCWlm
ICh0bXAgJiBQQ0Y4NTA2M19SRUdfU0NfT1MpIHsNCj4gKwkJZGV2X3dhcm4oZGV2LCAiUE9SIGlz
c3VlIGRldGVjdGVkLCBzZW5kaW5nIGEgU1cgcmVzZXRcbiIpOw0KPiArCQllcnIgPSBkbV9pMmNf
cmVnX2NscnNldChkZXYsIFBDRjg1MDYzX1JFR19DVFJMMSwNCj4gKwkJCQkJMHhmZiwgUENGODUw
NjNfUkVHX0NUUkwxX1NXUik7DQo+ICsJCWlmIChlcnIgPCAwKQ0KPiArCQkJZGV2X3dhcm4oZGV2
LCAiU1cgcmVzZXQgZmFpbGVkLCB0cnlpbmcgdG8gY29udGludWVcbiIpOw0KPiArCX0NCj4gKw0K
PiDCoAllcnIgPSBwY2Y4NTA2M19sb2FkX2NhcGFjaXRhbmNlKGRldik7DQo+IMKgCWlmIChlcnIg
PCAwKQ0KPiDCoAkJZGV2X3dhcm4oZGV2LCAiZmFpbGVkIHRvIHNldCB4dGFsIGxvYWQgY2FwYWNp
dGFuY2U6ICVkIiwNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5z
aWVtZW5zLmNvbQ0K
