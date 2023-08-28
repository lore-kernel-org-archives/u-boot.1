Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B80C83F13
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7F386478;
	Mon, 28 Aug 2023 10:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YEifjTpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144F686478; Mon, 28 Aug 2023 10:00:11 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3767803AB
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roman.azarenko@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agpv1Rf0zCX6XMZLXag95C1BbqOCeL1f1SWN+ea/O6Cwdo9Rl220xGZpvYRMOxhv4JIhYbxDhR2yn9SJQd/Qt2ze4QsjLWJar9d55a8RNELrwjDORTK9JGv1w6NACs7Vw7gUudQj8Vodnwx0JDC594ktuTR1yyTu79AvTtq91wckqythCUbS1JKKDdF8mrWxrQ+zg4y+irF26VQuzkeU2aRpoQbnagvhVR365NzaITH1tKMcmUrFVK2MLMuLdMpd+QX3E9JuR0fr0OseCKf0OjGCeChPxbkhrxXYdLps5lEz+yEGQQEno0ec0b20fdLO1CJIcjx99X2SlUtDWsTprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgBO+FfJiFREexl9mJuMGMiibv+kf647yctTv+Bhoak=;
 b=KdXo3xKfnxlVIqUWZkzR4sJKU8CD0WTSof/zeHLwuLEYTIpUlqq7o7e5+T6Uq/J33AheszHRq/hZk941VkGSpIWi02LUXQoKRBPt/Mt1OEm6TBR/ILIx558XglyCFgFpHh5M/3r63LSgalyTaaACHx6ehIKoJFOO4xsbAJSe0AJ9dAUa3cNShGz45EiUA8cl6DEIsEX4tfymbtoZW/EHIC1BsMDMsPrvLczLRdtlfjgUX2McvneO6PDdO1SFKCn4pEstY82fr3NAFyXOOLiFkyemnhhRRbH0osQdC18krmcFM0g3WbmQyUC4rYtPE5/JT93jG5c9HkLS1hFNUblDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgBO+FfJiFREexl9mJuMGMiibv+kf647yctTv+Bhoak=;
 b=YEifjTpTctYGOIEaaB14eRhsgxiAYhXOjcSMugKYsvDQs+guw6mKCwNOtECpOISYqXkQp4LwqufAFxTkMbZVHjJW/iC7jW1dUd5lUnzu2BQsKySHDHusM1Iy4WXNW/o+8GEeQcB2qEiYkFE0ykr1S5pGxBJHfD2SsKVL3lE6vno=
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com (2603:10a6:102:31f::20)
 by GVXPR08MB7702.eurprd08.prod.outlook.com (2603:10a6:150:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 08:00:03 +0000
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::a385:1112:8d43:f01a]) by PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::a385:1112:8d43:f01a%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 08:00:01 +0000
From: Roman Azarenko <roman.azarenko@iopsys.eu>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "massimo.pegorer@vimar.com"
 <massimo.pegorer@vimar.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
Thread-Topic: [PATCH v2] tools: ensure zeroed padding in external FIT images
Thread-Index: AQHZ1yuazzKpqTxGjUmKsfGwSpmdg6/7T1OAgAQNnAA=
Date: Mon, 28 Aug 2023 08:00:01 +0000
Message-ID: <89ab674dc53557f093d42fe4ca54ca4a14f8a276.camel@iopsys.eu>
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
 <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
Accept-Language: en-GB, en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR08MB9819:EE_|GVXPR08MB7702:EE_
x-ms-office365-filtering-correlation-id: 4688cf25-8cfc-40de-53e4-08dba79cc7df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHV6iVpeJKHq8rH4jtGWHam1rswYuheoAZ4hZU+eXG2bBCWtyt2fVANXIfTlcKmOVvcQgttjHfrFK+9AL+4N9eGGynfJCqcYQpaPOKFFF1Pyha8TqbmYG9k6QSSbTfcN919Det4SRc3EstKK02TORI/JuUFu37zAFhmvYEPNtrVITwhhUQPWbght/nRDCmRo5EmTPAWI4jvk3vEFVnuLTVm8US0FDXudMPj6UtOmJFMf+ZguIdwB2eDB5pFQJuE2lT+Aw5j8KOpe2uYjBJUhRKDju/JqaJM8VOmGHrc+1kZEzMFBNwJajrLTu22viqb39iu2VFDkGZeXxOR0eBP99pTHCRDPYqEUlVIPg+PWzJHbCkkVYJINZqBl+RTHxskKSLIYKOavKRLeRZm4TWKztNwAp2EtTK/iRFHju2AV453D4/Vo+YvgjhOktcjvjOMk/yC3c5Nvg17LOGak4+5xV5HWR5LIGEYlIJJIeTsR7yV54wH1TSSgBzwFK9eq/jwB/S31chYiBgC8kFQ6qGitcNxXdJaTyc9FSOj1qGctNWiU4O3HRCBEzGYKvtkvCNGECEWLRt+HgoLGUHXzjop2rC9cBWlRE6qw0Yw3qfysXstP2CbElHf+3fUJ8/HwpHfq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR08MB9819.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39840400004)(136003)(346002)(396003)(376002)(186009)(451199024)(1800799009)(41300700001)(122000001)(38100700002)(86362001)(38070700005)(83380400001)(478600001)(71200400001)(2616005)(26005)(6512007)(6506007)(6486002)(4744005)(76116006)(66946007)(66446008)(64756008)(36756003)(54906003)(66476007)(91956017)(6916009)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(44832011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNLRzBVZlkzUDdzZkt0czJCQ2MzakpwZGFMaytxMlF3NGlIbjlqTHpOYWh4?=
 =?utf-8?B?VGtUL3RzN21PQ2d3b3JmSE5XcGZsb2pMU0tWZlhBOG1Bdmx3REFMRTJFUW1r?=
 =?utf-8?B?VkFHZVJ2R1FNNm1mRzh6c2RFbFNaR25SUVUxcVBkRDh0RW9RcmZrUXlIVTlE?=
 =?utf-8?B?Uml2VEtPZVQxai9RR292MUFHajRjTUtXbkJzWThyY290VkdPNGJUOFU2SEh5?=
 =?utf-8?B?VWdzUXZrbitSSy9LNzhWek9NamN0dzVUNnluS3dLMXErYloyV1R6ejJJVVR3?=
 =?utf-8?B?SUo3bzZhdGxlNDZuOE9GZnFYZEUrV3dDK1dxM3JISkZtMmJJUEZHcFpNTVVr?=
 =?utf-8?B?dUxKY1FtaTRYTWdUN3ZCNzVtcEc3WkFKdlB0VGlHNE95M3BGbm1LeUNWK0VB?=
 =?utf-8?B?UnRHUWY3UXJYVGRpdzVXOXVUT3ZER0ZULzdqT21OS3MySlllcFBYdEw0MDR6?=
 =?utf-8?B?cXgrT1NtY1c1b3FxdGRLa0xmNTJCdzdTeHhab3dwUTIxdXJwMDdhTzdoYjR2?=
 =?utf-8?B?bkM3ZmpvWlhnbmt1VFRMUzd4REJIdUxHeUpVdW12WWJmbEFyY0ZHQkc1SmhU?=
 =?utf-8?B?SjZPYjRVdngrYitIQUhacUNSQTBvVW1FRnI1RUZJd0ZmV0NHdTVUTitiSE9X?=
 =?utf-8?B?cmJqMTdMSWo1MUsreTFmUEl5OEJ3SldzOExpMjlyUHdVdFNIS3RFSE5hTnFN?=
 =?utf-8?B?SzB0NVpXa1B3YU5kdlVGejcrbXVrZi9LckU5WHRBZlhBNTVCenU3MjJFUVFt?=
 =?utf-8?B?S21ZK2hickRHZE1IWm1OS3NMVUhybjVmRjNzdHcxK0ZYT3k5M1d6cUFMaFpP?=
 =?utf-8?B?cm1XTzFMbDdSOWRuTm5ldlMycSs1U1BPMnFmUk82ak44dkk5aGpsZDdqSUVY?=
 =?utf-8?B?R0EvTFBNWDQ4TkJkOW91ZDJWTTZaRUZKelh2eGZQQlk5OFBmU2Jma1BlTWI5?=
 =?utf-8?B?NVZZUzVFL2NyeFJVYlFvQ1I2UWE3elh2a0NSM2U2cUwzc2o1R3pNZ1I5SDJn?=
 =?utf-8?B?RGpoSzlCOElScWcwTm1rbytZbWd3YjVOeVZZcU9FOVI2TWZReFVNNmcxdXFh?=
 =?utf-8?B?YnYwdFViWXBJMC95TEJWME5QY2owLzFkNnFNcXgvUEpscjI2dmVvYy80MkRZ?=
 =?utf-8?B?ejdZNy9QdU1mZVBnVm11OGlOc2dtTnBBUk1IYWFCTXlmVCtYcXpVeG9kdHk5?=
 =?utf-8?B?S05hVjJXUCtYUWhRQ2VYdG9QejVZa1A2RkRFVStUdkVRS1M4WWpWemJYbnI0?=
 =?utf-8?B?MmRxQXJQNzVHVDI3ZldXYm5UM2RRcnIrWmtzY1BzY0JwVENvUHRhdGsyeDZm?=
 =?utf-8?B?UlJFVlNDdVJvbGdNWmVvMWZMWkY4Mzc2Y25sUUdJVGFvcGRReFFVdHl6NnZn?=
 =?utf-8?B?enUzdnQxNjQ5cmd0dzNlWklrUFRhaGdWdlMzNFNob1ZRY01ZYitmcldUMzZk?=
 =?utf-8?B?Rkp6T2h6TVZ2Ujl0QTNsZnJ4SHkrTElqY2tOcWMxQXdzQ1lmKzhLV1hrb1Uz?=
 =?utf-8?B?NmRJM1d6U2QyM1ZKOWU3eE4vN243TUQzdjZVNjVybENEcnAvZE44TUFBSmZC?=
 =?utf-8?B?aEoxUXJ6TVh5Q1Q0RXZ3SlZSUjQxOGhheEhCaktKaEs2MDhqODJyczFiZUdC?=
 =?utf-8?B?djZvdWdjaDVpeTRDKzE3QW1qdUlXVjZHYS9MaEVqT1F0Z0VtUjMxN0JuUjk2?=
 =?utf-8?B?RW9ocEFCWU1WV2FxZWcwc3RKUVA1VWpzbzI3NVRCUngxdjByU05qd0lKaFNy?=
 =?utf-8?B?VXlaa2QwRlY2aW45WTVFaytyc0lBejdXWGRPRkhQaDAwMi92YTRtQll3TnV3?=
 =?utf-8?B?K3VNeDJHV09JOEIxQS80eks0YWpQSE41VStwMURtYlhqbGdoaGowekt2UmNx?=
 =?utf-8?B?Z01tZzMrVk04b045ZCtuUmMrNDRLYVVsZkh3NDQvY20raEx5enMxNkw3SllT?=
 =?utf-8?B?U1ZBVjlHcWNDTUVJU05RZFlDK2dHTFMvSFpGVzhHR2ZieEhrSGpGdTlsYjRH?=
 =?utf-8?B?R2dhOWdTaGF2NEMzU0hXbGxabjRBd09YWHFuS2gzNGJGUGJRbzBkdjdFalVm?=
 =?utf-8?B?QXU0QXZaQThLTmFlajBRbmNVVzZRWWQySmtzN1Z1MWErMEs1djF2QXYyWXJH?=
 =?utf-8?B?OWVuOEVTV3cza1JITVlaWVYwYmtidFV4ZkxhU3N5UjExbDBDNFZUbWhTRWNn?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <597D6F13669A6347A036D5CCD8DF3249@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9819.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4688cf25-8cfc-40de-53e4-08dba79cc7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 08:00:01.2560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdEEEChdrH0XBRXsE7KfG99LOKiY3aXS/hEZ6EvVYf6wpYuP6ZXz+LwfbBX9gMXu7vd9nLYHhb8p4Io2vZXxjyzBald15nmP/9xERCtbJrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7702
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

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDEyOjA2IC0wNjAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
PiBAQCAtNTY0LDkgKzU2NCwxMyBAQCBzdGF0aWMgaW50IGZpdF9leHRyYWN0X2RhdGEoc3RydWN0
DQo+ID4gaW1hZ2VfdG9vbF9wYXJhbXMgKnBhcmFtcywgY29uc3QgY2hhciAqZm5hbWUpDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCAvKiBQYWNrIHRoZSBGRFQgYW5kIHBsYWNlIHRoZSBkYXRhIGFmdGVy
IGl0ICovDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBmZHRfcGFjayhmZHQpOw0KPiA+IA0KPiA+IC3C
oMKgwqDCoMKgwqAgbmV3X3NpemUgPSBmZHRfdG90YWxzaXplKGZkdCk7DQo+ID4gLcKgwqDCoMKg
wqDCoCBuZXdfc2l6ZSA9IEFMSUdOKG5ld19zaXplLCBhbGlnbl9zaXplKTsNCj4gPiArwqDCoMKg
wqDCoMKgIHVucGFkZGVkX3NpemUgPSBmZHRfdG90YWxzaXplKGZkdCk7DQo+ID4gK8KgwqDCoMKg
wqDCoCBuZXdfc2l6ZSA9IEFMSUdOKHVucGFkZGVkX3NpemUsIGFsaWduX3NpemUpOw0KPiA+IMKg
wqDCoMKgwqDCoMKgwqAgZmR0X3NldF90b3RhbHNpemUoZmR0LCBuZXdfc2l6ZSk7DQo+IA0KPiBJ
IGRpZG4ndCBrbm93IHRoYXQgd2FzIGFsbG93ZWQuLi5JIHRob3VnaHQgaXQgbmVlZGVkIGZkdF9v
cGVuX2ludG8oKSA/DQoNClRoZSBpbnRyb2R1Y3Rpb24gb2YgZmR0X3NldF90b3RhbHNpemUoKSBj
b21lcyBmcm9tIGNvbW1pdCBlYmZlNjExYmU5MWUNCigibWtpbWFnZTogZml0X2ltYWdlOiBBZGQg
b3B0aW9uIHRvIG1ha2UgZml0IGhlYWRlciBhbGlnbiIpLiBUaGUgY29tbWl0DQptZXNzYWdlIGRv
ZXNuJ3QgZGVzY3JpYmUgdGhlIGNob2ljZSBvZiB0aGlzIGZ1bmN0aW9uIHZzIGZkdF9vcGVuX2lu
dG8oKS4NCg0KUGVyc29uYWxseSBJJ20gdW5hYmxlIHRvIGRlZmluaXRpdmVseSBjb21tZW50IG9u
IGl0LiBJIGNhbiBvbmx5IGJsaW5kbHkNCmd1ZXNzLCB0aGF0IGJlY2F1c2Ugd2UncmUgb25seSBj
aGFuZ2luZyB0aGUgdG90YWwgbGVuZ3RoIG9mIHRoZSBmZHQNCnN0cnVjdCwgYW5kIGtlZXBpbmcg
YWxsIG90aGVyIGZpZWxkcyB0aGUgc2FtZSwgd2UgZG9uJ3QgbmVlZCB0byBhbGxvY2F0ZQ0KYSBu
ZXcgZmR0IHN0cnVjdCB3aXRoIGEgZGlmZmVyZW50IHNpemUuDQo=
