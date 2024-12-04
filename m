Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED7CE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32422896CF;
	Wed,  4 Dec 2024 17:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A3C8966C; Wed,  4 Dec 2024 07:52:15 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20703.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A89E891C4
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 07:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW8I6H+X3bMeZPUhRDQUeGqCcmb3k2je/jhB6am7nl3133HVPg7NVspRUMtdhOozH6Z2gBfqmdaQ9VykOtWBJa+Tkg0TVLv1W78m2wSW1HDSo4PlAclycp5ojNI7YXGa4ihwtqdxGtWBZsmXfh868z04O71ZA//EOhot3thVYGDmfAQMmBLSWj71tryq5eTLBZf3IJMFbawesCQB9uhY+YUGZN4U+rPUe6EVUnbw2n6Dv9IvoJj2AyLieduuMEf56HbI7pu6B3bQBtvpiD7DkXLBqteRNx1fBDvUlC+nFw+zQMkqE1utPUXlLyTxFX/koud+fdANxdHiXWj5DkRrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGJg4hVKGFGVEaftLz9zbNFaViFPZyHp9y91WVFHRQ0=;
 b=jDtbTpu9bgJt7kjjfohwgUtaHjIQW8aWgXiXDq2LrkCafXBy89TZmTxZciqeZHqs3cXsWonpG8djqnZM5WrM068LMy2zxJVs4rbWGdZCOiO2QfNkZtiVo3iKcd0sP2NC9hVSpWczcdy9kYdpf4PLWwS8lp0dGxhP6NK879gd1yB91Vf7DrOLWE5RXjtOLGT35if6oRx4apGxaFU/otz937psMWS0LiDHpJ0tqvHu/MjbPQtQblAgu8Fg9RtKOlhsB1mFfT2dDyhc/pSMJ9AcwAg8NVICbXaKayz+7tVV0HBY64nnhNZC8b3mzEAAOw6gTWg+L7pzR2lcItW79VauFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 4 Dec
 2024 06:52:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Wed, 4 Dec 2024
 06:52:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, Bo Gan
 <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Thread-Topic: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Thread-Index: AQHbRTBVBp8x/g2v+0a9gvciG4M9SLLU5SyAgACFsiA=
Date: Wed, 4 Dec 2024 06:52:30 +0000
Message-ID: <ZQ2PR01MB13072E932737DD9D65E3A250E637A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-6-hal.feng@starfivetech.com>
 <CANV2PTOxKz33x4vNioD0rqkTCGTKhdbNHo6eJFrCxn5yq6SX0Q@mail.gmail.com>
In-Reply-To: <CANV2PTOxKz33x4vNioD0rqkTCGTKhdbNHo6eJFrCxn5yq6SX0Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
x-ms-office365-filtering-correlation-id: b85c42f1-16d7-4461-6367-08dd143038df
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: 65jFj1G2WzVQEmPp55BwKdrNFmHp/gVsmWbJkOYtKBHVBXxxiuyXNimd1Du/Vzp/ioMGOn1OTcbq3O5yeUqBKEK7G/QmeFotsXmCPjhbK0ZIN5yMcXz+d1orueCHlHYQDzqudmW8sHHc0o9D38uZuqJabJNExlSxZ3F+tZn4wchoF3eTtTjHiLWwOLu/3xNxOezSzE+KzhrtLC49xJj6S4xWzi/RlixGcg4K8lKxqKwcCUMtMJw5Bzu/fzM4JTdKHMuRJJf85bWGMhZqQzMyZ6mp4rTe3XZJzMfAS0+W3noQKenbwUaubDTM5s7jDiYSu/ms3wWUR5xX+/iNyBFl0HS3/7ahQ7hr3TR62v7hJOSl0F/qtFwFw0NNAxRWp4STzk+U3WE9Rho2nwjxMs9PspdleXfyUcrcV9KS5VUNrY2kzbRzbuZu8OHylPNVMh6pocHVY3U2rtS2wu3BDmkWTekt/fH14E+scvfskHIPVRRJtvfL11YuaB838pmnwKymprBqMwP2tbGXOvSwDfozmzXmfhz0jQIuUWR8HcZ9FQrvCOe5cqeUM3eIcb2McZLmZjP9tvkGR5yKgRtd3jPKgvDttUNc13ogKonqF38kdsb6uVFHp6O5M0EhX4oyedzh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajljTzcvZnJsV3dsTVJCTUhnS1VEcml4ZDRWV0pGcGNaRTZDMG50djF3eUlm?=
 =?utf-8?B?M2RNQnUxUDJObzdVR0FON1dEc2NDdWJoMHNlOUlTSHdBUWRRd3RqZFZtTE1B?=
 =?utf-8?B?SWJ2TjgraHZGaTVSZjN3b0dFZFA0SkF5Yjkzdkp2cmJDVWpObDg0dk5UYWdl?=
 =?utf-8?B?bUFtZExsakt0WTBuYVhuWXlUTG4yTENNc0ZYYVFpRmFCSy90Z3ZRR2RlZFdp?=
 =?utf-8?B?SXAzbFJ6c3hkc0YvMGk3aVVXeml5aU5URGhPOWYzc2xzQ0ttTS9tOEQwc2RQ?=
 =?utf-8?B?aGU3VG42REVBSkNJSEFSckRKVkt4bnpnQnd6Q1lYWEZnOEJkcUhJNEhKWmxJ?=
 =?utf-8?B?OTMwckl0V3RmYkJDd1VaTVJLVE42T3YxRkplcUtSVnE2aUVzU0huWDB1c0po?=
 =?utf-8?B?RGtJUUdzK1M2RzIzNkE3REFMSWVVb3h4eHhaSDMrcXVNcTRCdk5aTTlybHln?=
 =?utf-8?B?Mm1jclhnS09sd3ZOZDZ6VmtoUGpFa0FpeGJ3dmQxMnM3S3QzOXNodVlSUEcw?=
 =?utf-8?B?YUl3cExoVGgzM0ZXbTFXOHNvVnRnSjZVYWs3bWdOaEtQd2FPWkwrOEpWbjRu?=
 =?utf-8?B?T3pHL3FTK2xQeW1VeEE4N2FLVXJNVHVCWmZ4RlJoR0FaYTBYbzVQanVzWGJh?=
 =?utf-8?B?REhLbE1iOWRCcnhONCtFTjdSTTBTTDFjRE10L0VzVk9PY09PeFRORXhjWE1Y?=
 =?utf-8?B?TXBHQ2k2UmE2c2hBcjEwbU9zMG5vOU1TSWQzdG1PQzB0amZhNCt2NDZySnE2?=
 =?utf-8?B?V1FvMmhmajFiR1BtMk95WkxpQ2Zld3ErS2xXUnplbkFJWGU0QWJlYUs1TlpN?=
 =?utf-8?B?a1g2TjRqVzYvMWNWd3EwV2ErTjFGa3ZGNE93TEg5ZGVoUGdPYlFwZ1ZTUVBY?=
 =?utf-8?B?TXlRNXVpNm9EWXMxNXBlVDV3NHdUMTdINGI2RVl1bWZ1Kzhud0F5Z3BtT2FQ?=
 =?utf-8?B?ZEwvNEFGSUw1RTk1MEt6MW5rNGg2VEZocGFIVGFaTkpqaWRhREtydUNIeGQv?=
 =?utf-8?B?TEowN2MzM0FISkJ6REFuNlRNbzdZTE1RNWphL0tzUWNEVndjMTIzSmM4dkZP?=
 =?utf-8?B?S2VQN0xDUGh0TXBVOTJaODBsLzZuL0F4cndjVlZDMWtpV1FuQUdMZC9RekxH?=
 =?utf-8?B?MlcwYkVaRlpWU1FzQVN5Q3QzQ2l3SXg3MHdtQTF4ZlhvZVpoOUtTSzg4dmUr?=
 =?utf-8?B?QU5hWnZ5c2ZxTjhYR3paOUxBckZXTzBDL0VJN0tCckpLNUQ3VnpTN09FYVVw?=
 =?utf-8?B?WGVxa1Z6OThLMWJWbjlUSm4xUmc0Vi9tVFRhcGM0eG9tbVNmajJRNXpnb0lh?=
 =?utf-8?B?UVRLZ3pJV0t1VHkvSXlnYjRwZXorRlJkam42Y1hUUWF3dGQ0cnRVUmtOZTRD?=
 =?utf-8?B?dEtQcDJ3MGhJN0ljWjF6UFczWldaaFRrd1FjNFgrWTFFb0xjSDg2VmFKd016?=
 =?utf-8?B?THhVdStsby9xeXllOUxsMW1BTUZ1UEhmU3V6Umlub2ZpZ0FhTGZYeDNDSXNH?=
 =?utf-8?B?YjBXZlVtYlNucExaTks0OU82ZG9NS0I3Q3JsWWVPbXh0aTAzSnlJTDdnSEdv?=
 =?utf-8?B?eUxwUVpwZ3UwY0dDRjRiY3pLY0hLQTc5Si83eW5xdE8xRUJKYStsVkluVW1C?=
 =?utf-8?B?bitaK3E1LytWUkdCaFVIZ3VvemhxcVZuSkpvaW1ReE5rcjBQUzB1UTNGOXFF?=
 =?utf-8?B?eGxCejhTUEh1bGpHOHVqQzZ1T3pvQWthYkNpT0lPZ1dVMnBIQUhaQWUrTHlp?=
 =?utf-8?B?TjJuZ29wSmF4SlBMQXlneVRqWDYzbXBOcjRIMEtYU1VEQ2RHdEpPYkxidG1n?=
 =?utf-8?B?a3hHY21LZzduTEQ0cWRpRFdRWVZnTnR6TnMxdzRQOEN5SnR2eEQveVRNKzdN?=
 =?utf-8?B?SnR5MzhlSm5zRTQxUlhHbGI3ZUtJTjVUY2FFY1dUTWRzMGJqYm5Ja083MmE4?=
 =?utf-8?B?d1ZSTTloMnZ3b2lLQWlhRUduSm44REZQcWxaK2hyOHhmZWRHbFIyUHV5RzVJ?=
 =?utf-8?B?Z2hXSEcxdWFTY2s5TUhYbmVPTU9TelJWeEFMYUFBVlArdDlSZHdlSjVLaHda?=
 =?utf-8?B?UlN2anRqc1FZM0w1cUNvbjdOWkFjcVIwTUMwYXhJekRZWFRVM3pYNU5mOFlQ?=
 =?utf-8?Q?aRwNqsby9WsroZEG2cVbEFZ+D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b85c42f1-16d7-4461-6367-08dd143038df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 06:52:30.1358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8QKhZ6Wa34tL59wX2NIoFHWvqubkCfdes3g3r/nmo73hfrC0znbkhMcNB/MEMMtYe9PmGARjnxCvpjuCgQ9oXGy+iv6LZ0Ahf24Aj8MTak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Wed, 04 Dec 2024 17:31:58 +0100
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

PiBPbiAwNC4xMi4yNCAwMzoxNiwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiBNb24sIERlYyAyLCAy
MDI0IGF0IDc6MDbigK9QTSBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBUbyBzdXBwb3J0IEpINzExMCBiYXNlZCBib2FyZHMgYmVzaWRlcyB2
MS4zQiwgYWRkIGEgY29tbW9uIGR0c2kgYW5kDQo+ID4gYWRkIGNvbW1vbiBjb2RlIHRvIGl0Lg0K
PiA+DQo+ID4gVGVzdGVkLWJ5OiBBbmFuZCBNb29uIDxsaW51eC5hbW9vbkBnbWFpbC5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBFIFNoYXR0b3cgPGx1Y2VudEBnbWFpbC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEUgU2hhdHRvdyA8bHVjZW50QGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwg
RmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9yaXNj
di9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaSAgICAgIHwgMTQyDQo+ICsrKysrKysrKysr
KysrKysrKw0KPiA+ICAuLi4xMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2ItdS1ib290LmR0
c2kgfCAxMzggKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNDMgaW5z
ZXJ0aW9ucygrKSwgMTM3IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgYXJj
aC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1jb21tb24tdS1ib290LmR0c2kNCj4gPiBiL2FyY2gv
cmlzY3YvZHRzL2poNzExMC1jb21tb24tdS1ib290LmR0c2kNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAuLjc5NTM0NTllNjcNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvYXJjaC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaQ0KPiA+
IEBAIC0wLDAgKzEsMTQyIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wIE9SIE1JVA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgU3RhckZpdmUg
VGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiYmlu
bWFuLmR0c2kiDQo+ID4gKyNpbmNsdWRlICJqaDcxMTAtdS1ib290LmR0c2kiDQo+ID4gKy8gew0K
PiA+ICsgICAgICAgYWxpYXNlcyB7DQo+ID4gKyAgICAgICAgICAgICAgIHNwaTAgPSAmcXNwaTsN
Cj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgY2hvc2VuIHsNCj4gPiArICAgICAg
ICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgIGZpcm13YXJlIHsNCj4gPiArICAgICAgICAgICAgICAgc3BpMCA9ICZxc3BpOw0KPiA+ICsg
ICAgICAgICAgICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+
ICsgICAgICAgY29uZmlnIHsNCj4gPiArICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+
ID4gKyAgICAgICAgICAgICAgIHUtYm9vdCxzcGwtcGF5bG9hZC1vZmZzZXQgPSA8MHgxMDAwMDA+
Ow0KPiA+ICsgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICBtZW1vcnlANDAwMDAwMDAgew0K
PiA+ICsgICAgICAgICAgICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArICAgICAgIH07DQo+ID4g
K307DQo+ID4gKw0KPiA+ICsmdWFydDAgew0KPiA+ICsgICAgICAgYm9vdHBoLXByZS1yYW07DQo+
ID4gKyAgICAgICByZWctb2Zmc2V0ID0gPDA+Ow0KPiA+ICsgICAgICAgY3VycmVudC1zcGVlZCA9
IDwxMTUyMDA+Ow0KPiA+ICsgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDI0MDAwMDAwPjsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKyZtbWMwIHsNCj4gPiArICAgICAgIGJvb3RwaC1wcmUtcmFtOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArJm1tYzEgew0KPiA+ICsgICAgICAgYm9vdHBoLXByZS1yYW07
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcXNwaSB7DQo+ID4gKyAgICAgICBib290cGgtcHJlLXJh
bTsNCj4gDQo+ID4gKyAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwyNTAwMDAwMDA+Ow0KPiAN
Cj4gRHJvcCB0aGlzIGxpbmUgc3BpLW1heC1mcmVxdWVuY3kgMjUwTWh6LiBUaGUgZHJpdmVyIGV4
cGVjdHMgc3BpLW1heC0NCj4gZnJlcXVlbmN5IGluIGFueSBzdWItbm9kZSwgYW5kIG5vdCBoZXJl
Pw0KDQpZZXMsIHRoaXMgcHJvcGVydHkgaXMgdXNlZCBpbiBzdWItbm9kZSwgd2UgY2FuIGRyb3Ag
dGhpcyBsYXRlci4NCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICBmbGFzaEAwIHsNCj4gPiArICAg
ICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+IA0KPiA+ICsgICAgICAgICAgICAgICAvZGVs
ZXRlLXByb3BlcnR5LyBjZG5zLHJlYWQtZGVsYXk7DQo+IA0KPiBEcm9wIHRoaXMgbGluZSAvZGVs
ZXRlLXByb3BlcnR5LyBiZWNhdXNlIGl0IGlzIGEgcHJvYmxlbSBmb3IgdGhlIHBhcnNlciBpZiB3
ZQ0KPiBuZWVkIHRvIHJlLWRlZmluZSAnY2RucyxyZWFkLWRlbGF5JyBsYXRlciBpbiBkdHMgZmls
ZXMgZG93bnN0cmVhbSBvZiBqaDcxMTAtDQo+IGNvbW1vbi11LWJvb3QuZHRzaQ0KPiANCj4gSWYg
eW91IHdhbnQgZHJpdmVycy9zcGkvY2FkZW5jZV9xc3BpLmM6c3BpX2NhbGlicmF0aW9uKCkgdG8g
ZG8gdGhpcyB3b3JrIHRoZW4gaXQNCj4gbmVlZHMgdG8gYmUgdGhlIHNhbWUgdXBzdHJlYW0uIElu
IG15IHRlc3Rpbmcgb24gNEdCDQo+IFN0YXI2NCB0aGUgY2FsaWJyYXRpb24gKHZpYSAvZGVsZXRl
LXByb3BlcnR5LyBjZG5zLHJlYWQtZGVsYXkpIG1ldGhvZCB3aXRoDQo+IHNwaS1tYXgtZnJlcXVl
bmN5IGxlc3MgdGhhbiBleGFjdGx5IDQ5LjhNSHogcmVzdWx0cyBpbiBhIGZhaWx1cmUgdG8gd3Jp
dGUgU1BJLQ0KPiBOT1IgY29ycmVjdGx5LiBXaGVuIHNwaS1tYXgtZnJlcXVlbmN5IGlzIGFwcHJv
eGltYXRlbHkgMjVNSHogdXAgdG8NCj4gNDkuNzk5OTk5TUh6IGFuZCB3cml0dGVuIHdpdGggYSBr
bm93biBnb29kIHRvb2wgdGhlbiB0aGUgYm9vdCBtYXkgYmUNCj4gc3VjY2Vzc2Z1bCBidXQgIk1h
aW4gc2VjdGlvbiBib290IGZhaWwsdXNlIGJhY2t1cCBzZWN0aW9uIg0KPiBvciBvdGhlciBlcnJv
cnMgb24gYm9vdCBhZnRlciB1c2luZyB0aGF0IHVuc3RhYmxlIGNvbmZpZ3VyYXRpb24gb2YgVS1C
b290IHRvDQo+IHdyaXRlIFUtQm9vdCBpbWFnZSB0byB0aGUgU1BJLU5PUi4gTm8gcHJvYmxlbXMg
d3JpdGluZyBhbmQgYm9vdCBkdXJpbmcNCj4gdGVzdGluZyB3aXRoIHNwaS1tYXgtZnJlcXVlbmN5
IDQ5LjhNSHogdXAgdG8gMTAwTUh6IChub3QgdGVzdGVkIGFib3ZlDQo+IDEwME1IeikuDQo+IA0K
PiBUaGUgdXBzdHJlYW0gZHRzIGhhcyBzcGktbWF4LWZyZXF1ZW5jeSAxMk1IeiB3aGljaCBpcyBu
b3Qgc3VjY2Vzc2Z1bCB3aXRoDQo+IGFueSBvZiB0aGUgcmVhZC1kZWxheSB2YWx1ZXMgSSB0ZXN0
ZWQ6IDAgMSAyIDMgNCA1DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMDA+Ow0KPiANCj4gV2h5IDEyTUh6IHVwc3RyZWFtIGFuZCAxMDBNSHogaGVy
ZT8gU29tZXRoaW5nIGlzIHdyb25nIGJ1dCBJIGRvIG5vdA0KPiBrbm93IGlzIGl0IFUtQm9vdCBv
ciBMaW51eD8NCj4gDQo+IFN1Y2Nlc3M6DQo+ICsgICAgICAgICAgICAgL2RlbGV0ZS1wcm9wZXJ0
eS8gY2RucyxyZWFkLWRlbGF5Ow0KPiArICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0g
PDEwMDAwMDAwMD47DQo+IA0KPiBTdWNjZXNzOg0KPiArICAgICAgICAgICAgIGNkbnMscmVhZC1k
ZWxheSA9IDwyPjsNCj4gLSAgICAgICAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBjZG5zLHJlYWQt
ZGVsYXk7DQo+ICsgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsN
Cj4gDQo+IEZhaWx1cmU6DQo+ICsgICAgICAgICAgICAgY2RucyxyZWFkLWRlbGF5ID0gPDI+Ow0K
PiArICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gDQo+IFRo
ZSBhY3R1YWwgZml4IGlzIGdvaW5nIHRvIG5lZWQgdGVzdGluZyBMaW51eCBhbmQgVS1Cb290IG9u
IGFsbCB0aGUgYm9hcmRzIEkgZG8NCj4gbm90IGhhdmUgYWNjZXNzIHRvLg0KPiANCj4gRm9yIHRo
ZSBtb21lbnQgd2UgY2FuOg0KPiAtICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIGNkbnMs
cmVhZC1kZWxheTsNCj4gKyAgICAgICAgICAgICBjZG5zLHJlYWQtZGVsYXkgPSA8Mj47DQo+ICsg
ICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gDQo+IG9yIGRv
IG5vdGhpbmcgKGJ1dCB5ZXMgcGxlYXNlIGRyb3AgdGhhdCAyNTBNaHogbGluZSBpdCBpcyBub24t
b3AgSSB0aGluaykuDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8gIE9yIGVsc2Ugd2UgZGlzY3Vz
cyBoZXJlIGFuZCBmb2xsb3cgd2l0aCBwYXRjaGVzIGluIGZ1dHVyZQ0KPiB0byBmaXggdGhlIG1l
c3MuIEkgcmVhbGx5IGRvIG5vdCB3YW50IGFueSAvZGVsZXRlLXByb3BlcnR5LyB0byBiZSBpbiBk
dHNpIGJ1dCBJDQo+IGRvbid0IGtub3cgd2h5IGl0IGlzIHNvIGRpZmZlcmVudCBiZXR3ZWVuIFUt
Qm9vdCBhbmQgTGludXggYW5kIGNhbm5vdA0KPiBwZXJzb25hbGx5IHRlc3QgYWxsIHRoZSBwb3Nz
aWJsZSBib2FyZHMgdG8gdmVyaWZ5IGEgY2hhbmdlLg0KDQpJIGRvbid0IGtub3cgdGhlIGNhdXNl
IG9mIHRoaXMgcHJvYmxlbSBlaXRoZXIuIEJ1dCBhbGwgcHJvcGVydGllcyBhZGRlZCBpbiB0aGlz
DQpwYXRjaCBhbHJlYWR5IGV4aXN0ZWQgaW4gVS1Cb290IERUIGJlZm9yZS4gSSB0cmllZCBteSBi
ZXN0IHRvIGtlZXAgdGhlIFUtQm9vdA0KRFQgdGhlIHNhbWUgYXMgdGhlIG9uZSBiZWZvcmUgT0Zf
VVBTVFJFQU0gYXBwbGllZC4NCg0KSSB0ZXN0ZWQgYW5kIGZvdW5kIHRoYXQgdGhlIHFzcGkgZmxh
c2ggY2FuIHdvcmsgc3VjY2Vzc2Z1bGx5IGluIExpbnV4IGFuZCBVLUJvb3QNCndpdGggdGhlIHNl
dHRpbmdzIHlvdSBzdWdnZXN0ZWQgYWJvdmUuDQoNCmNkbnMscmVhZC1kZWxheSA9IDwyPjsNCnNw
aS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAwMDAwMD47DQoNCklmIC9kZWxldGUtcHJvcGVydHkvIGlz
IHJlYWxseSBub3Qgc3VpdGFibGUgdG8gZXhpc3QgaW4gdGhpcyBkdHNpLCB3ZSBjYW4gbW9kaWZ5
IGFzDQphYm92ZSBpbiBVLUJvb3QgYW5kIHVwc3RyZWFtIHRoaXMgY2hhbmdlIHRvIExpdW54LiBB
ZnRlciB0aGlzIGNoYW5nZSBpcyBhY2NlcHRlZA0KYnkgTGludXgsIEkgd2lsbCBkcm9wIHRoZXNl
IHR3byBwcm9wZXJ0aWVzIGluIFUtQm9vdC4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
