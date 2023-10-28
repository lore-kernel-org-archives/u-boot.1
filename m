Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD724C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 08:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFD887844;
	Sat, 28 Oct 2023 10:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="DK/jv2vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2845387845; Sat, 28 Oct 2023 10:16:18 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE09587836
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 10:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698480975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqy5zK0ODWN5wx6pc2ef/d7UPwVI8bsTK5qJHKxKooY=;
 b=DK/jv2vrAimw2Pt4vx8GhWfZCwOEZO7sdRTxKjMptzKiYj9jTTAfSEjacAxWeJmo8zihlZ
 vvnLBGZLdbmo1PQjYj054qaQaGW5cvpEpuaTb0YoyNmmshABmUAweWWOVWFDtnZ6nKyKYm
 kwdVtaM1JkKyJwU/jIexW20LNajLIn8=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-gZqHehgNPsO4XuWdnba9fQ-1; Sat, 28 Oct 2023 10:16:13 +0200
X-MC-Unique: gZqHehgNPsO4XuWdnba9fQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0082.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Sat, 28 Oct 2023 08:16:12 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 08:16:12 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "nm@ti.com" <nm@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Thread-Topic: [PATCH 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Thread-Index: AQHaCNwHA5Xcb5+Kzku3l2wasjU5cLBeG48AgADAvAA=
Date: Sat, 28 Oct 2023 08:16:12 +0000
Message-ID: <949fda91000f00565ce88f2db7899bdb6f883623.camel@toradex.com>
References: <20231027134630.244886-1-rogerq@kernel.org>
 <20231027204620.oz5hemkw3wwhh3u6@latter>
In-Reply-To: <20231027204620.oz5hemkw3wwhh3u6@latter>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0082:EE_
x-ms-office365-filtering-correlation-id: c876721c-ce34-4216-2623-08dbd78e25b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: XRIPWcJlADysnOYDXP2vZRLRjbIyhz7sx/mPlk/jPcS428j1TK0O4j/cy6oas6ykRVDp00VhB3T3DtBTKQLR/cDGHGTPcvbUOWYdP0PsjB7U8RcMXjpoiDBiR7pmTFm6bjz9sJWr0XsLLkKim4eh1bGWU2Hgnm3PQVOZ9WrU6kB6JCJb7Kk142Lq2DX9VrttxBKEwLzy5vI0llsOgP4cEvigV5rU5rY6md06Q9G85p6niUwihJrGa7IetRGkFE2fCH9C2BQ3zyxPp+0T4LAGegJjA9S/oi6XGiN79HoQOvNO/LgspX+0vV+VjOAOEIPJbDYOnwFXtobY7cUao9QkTJGblAldRs4+6sQ0Wj6BNHAYjO7w4MLhbM1GPGrl+MlqEEYRJnmt/573ei/1lURGMhhncMsk/EKXG0AexfW81W6lYgW8VbIVqsXn3MsYJDTg9dD7BUABWl+HGyXvV2+f0wCrTMkaYvvhDODBrCfAYqtF8nLH5Lydqv6Eas8u+WKWRl76G6XluYjXdkIxxvv3gGprR6fCKkoHJqbJxCozlIs0Sq9DMOPbvuhVdvcOiEz/e1krk+jXBceQBm4llWFO6w7EysbiwoA5yDw5wqR3fWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39840400004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2616005)(26005)(6512007)(66476007)(71200400001)(6506007)(478600001)(83380400001)(4001150100001)(2906002)(6486002)(41300700001)(66556008)(66946007)(44832011)(5660300002)(76116006)(110136005)(8936002)(8676002)(316002)(4326008)(966005)(91956017)(66446008)(64756008)(54906003)(38100700002)(122000001)(86362001)(36756003)(38070700009);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHNyREhEaDVLSysySDRLS2J4Y3UzZmpJTnR2KzZvUmpUUWhjSHA1TFlVZFRq?=
 =?utf-8?B?aTI2ek5YNzdBV0xzc1VLM2paSGRGYXZVTkt6akRPd1ZXeGdkTCtLbU9GTXpV?=
 =?utf-8?B?S3plRWRHQkJtaWJLTmlTYloxS1pvYk1DbTBUdFlCWERUUjlQMUxaZSsyQ3Vv?=
 =?utf-8?B?aW5TbU10emNrRlBVczVRcXE3U0k4T1QxcGc5T2JhY1Z4K2xXbGo5dnFwMTRI?=
 =?utf-8?B?akdsZFJhcHlQQkdDWXZFWGxiTkwvZzFoTFg4SEREZHQ1UUpINEF5YktmWm54?=
 =?utf-8?B?SGM5WlkwZ3ZKWlY1MGpIZUd1dmRqaU9ZZyt5WFhYK01PTGV1K0lRNkJyUjh6?=
 =?utf-8?B?c2F5UjRuY3RTTkQ2WDFZSTY4bzBmanExRnVLcHZVRThhM01HU24zeHdwYnNw?=
 =?utf-8?B?WThYRzdBS1UzODFsZVZjMWZWa2ZOS3JoWE1vaFkyQkZnS3NwRktENVM2WDQw?=
 =?utf-8?B?cUNDQjgxUTMycFFtem5FbWlJY0dUZld0ejdOaWFaZnRyL29MTmVrOWxjd01H?=
 =?utf-8?B?eGxjL2NReWp5bjdxclZ0ZzRYaHJHVjRUOTBBUVMxdTdUVDgzUWw1M0VBK3Vz?=
 =?utf-8?B?MTF4QUxEeVRXM2hCb2VXMmsvMXFXa09IT0ZnQ1N2eUVOWW1iT0FxdWE2MU1B?=
 =?utf-8?B?WWJTWlRiNjM1Wk01dDk1STBIUDVaZkpjZUdna3YraSsyY2ViSWFNT0JMS2Zh?=
 =?utf-8?B?MnU0amZSTVZ2Mm5QNkY5dFZiKzVWMlBWTEJZZzJLTjJMbk1ieHJoNGo2SWlN?=
 =?utf-8?B?SVRzbGxzZWpwWkxTTzB5SUV6N0JDT3lZRVMzaEYxTVB1MGZLbVlFcEMwODhI?=
 =?utf-8?B?cUNDbEtxclZTelJjcVBZcW5oVmxOQmg0VzRRd3JJTmwxSmhtSHlLQVhTL2g1?=
 =?utf-8?B?aUFCcUFZcW4vbjAza1FSRkRqODYvb1Nzb3dYa3RWUS9CLzNmVGFGdVdTTFJx?=
 =?utf-8?B?NWMvOEVoR0Q5bFJnRUZtWG81eFBmbjI1WHBpdWRXNkZuN2hEa0ZQVlg2REhX?=
 =?utf-8?B?NHR6QUZQdnJTaks4MjRrbmN0SHlCdEFPZ3lOVXhlZzlxRC9OaUsvYlV6M2lZ?=
 =?utf-8?B?M0NZOWVWZWhueVFlOHBTUmw2bFhQdHVXT0NqOTRKR1NMOVlrU0pkdzZGNVVz?=
 =?utf-8?B?Y1hrSFpOeW92Zk5ESk5kbjgveHZIWHB1NU5oY3BQTmJFMW9Vdit2RkVIVnlV?=
 =?utf-8?B?TWVsbHNZOEtRY3pBbjVhWitTbEhDL1Q0dWRhWmJBVWxxVWtZbjMrbGRISmVT?=
 =?utf-8?B?OE5UUkRKaUxpelVUcGNhZ1UxUUg0NjRnYVNtVm1HR29qNS94K1VGYzBzVzk5?=
 =?utf-8?B?TysvSFJCK0Y4bElBN2lrMmpsOE01ZjZDN0dTOExSYUk4RUxLMzhiVlN3NUZp?=
 =?utf-8?B?SXEzTFJXQU5ETVhjSklFTE9iQnhZdnFsNVBzd1ZCSFk5OWpsODhjY29KYUFV?=
 =?utf-8?B?WG1uR3hpSDQ5cjdlQ05HdWtFTDB5SGxWSkx5T3plTno1ZmtzMkFjSTZURHVh?=
 =?utf-8?B?UUJjejhWNVdDNDB5N0FTZ1gwT2c5YVJsc1lnMmZpQ1p3RmZQTmNBQ2pKcHlq?=
 =?utf-8?B?Nzg1ZG1WTEN6TUJ6clNWWENxVG5TMXZITjZZN01FOWRXTTU1QzhtTlZCVHl4?=
 =?utf-8?B?U2JnZ2ZjRlVlblIvdnI5NmJIalNSQTR4NVF2SlhDZDFEaWhzcFdUZFkwY25Z?=
 =?utf-8?B?MGpxcjFQWXdOZ0dUUlpFQVRVbC9ONXpyOWdxV1VVMVBUU09pUDRMejhudjdH?=
 =?utf-8?B?SXR2ZzdpekZTU0d5aHpJaFZTMW9xVDVZUWNGYXl0Z3dxbUV2UldnYWdSNE1W?=
 =?utf-8?B?ZXJnalBheUZWdTRMeEVWQUlGQWF3cmNSODRmSGtaSEtDU2VWR2lnZUpCWDdO?=
 =?utf-8?B?TnpyTWdFQ3UwZUIxM0Y5NG5CQzkraHNsUzkvVEJZOElQNkRPdFQzcWRQT0dl?=
 =?utf-8?B?SWtMaFNubys0d1N1aENMa05JV3VFRjhwNkZTOE40U1VpMXd2THc3S1pTMTM0?=
 =?utf-8?B?K21KSTFVRGdyOXFFaFlqR2dkQ2VyUUdwb3FrU3F0R243dU9VK3JLcVBNYU9R?=
 =?utf-8?B?eks2RnU3YmNMS0N2eStwdlEzSUtMUlBHYytpMkthSTRkV1ZWS3J6OXRNOUMx?=
 =?utf-8?B?U0lmOXJRMlpBdXBuSzU2S3ZPUlhSMkZzaVoxZ045R1BqOFlTU3BqN3ZHMVhM?=
 =?utf-8?B?VEE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c876721c-ce34-4216-2623-08dbd78e25b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 08:16:12.0481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8dJguE9vmf1ffUyF7opSDQcZRCPXSIX8Y89BxUL5S1aR1/T3OLRw+9hkZCRf+fIIaDenuRAxmJJxVxcF9hMjsS+PDhp7TNveI+3Eo4ZyQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0082
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <BAC0E1D0AD800B4A907B3BF9B6F8E784@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgTmlzaGFudGgNCg0KT24gRnJpLCAyMDIzLTEwLTI3IGF0IDE1OjQ2IC0wNTAwLCBOaXNoYW50
aCBNZW5vbiB3cm90ZToNCj4gT24gMTY6NDYtMjAyMzEwMjcsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6
DQo+ID4gSGksDQo+ID4gDQo+ID4gU2luY2UgY29tbWl0IFsxXSwgRXRoZXJuZXQgaXMgYnJva2Vu
IG9uIFRJIEFNNjIgYW5kIEFNNjQgcGxhdGZvcm1zLg0KPiA+IA0KPiA+IFRoZSBjb21taXQgWzFd
IGlzIG5vdCB0aGUgY3VscHJpdC4gSXQganVzdCB1bmVhcnRocyB0aGUgcHJvYmxlbSBieSBmaXhp
bmcNCj4gPiB0aGUgZXJyb3IgY2hlY2sgaW4gazMtdWRtYS5jLiBUaGlzIGlzc3VlIHdhcyBzaWxl
bnRseSBiZWluZyBpZ25vcmVkIGVhcmxpZXINCj4gPiBkdWUgdG8gd3JvbmcgZXJyb3IgY2hlY2su
IFtOVUxMIGluc3RlYWQgb2YgRkRUX0FERFJfVF9OT05FXS4NCj4gPiANCj4gPiBGaXggdGhlIGlz
c3VlIGJ5IGFkZGluZyB0aGUgbmVjZXNzYXJ5IHJlZ2lzdGVyIHNwYWNlcyBmb3IgdGhlIHUtYm9v
dCBLMy1VRE1BDQo+ID4gZHJpdmVyIGZvciBBTTYyIGFuZCBBTTY0IHBsYXRmb3Jtcy4NCj4gPiAN
Cj4gPiBbMV0gLSA1ZmVjZWExNzFkZTNkZCAoInRyZWV3aWRlOiB1c2UgZGV2X3JlYWRfYWRkcl8q
X3B0cigpIHdoZXJlIGFwcHJvcHJpYXRlIikNCj4gPiANCj4gPiBjaGVlcnMsDQo+ID4gLXJvZ2Vy
DQo+ID4gDQo+ID4gUm9nZXIgUXVhZHJvcyAoMSk6DQo+ID4gwqAgYXJtOiBkdHM6IGszLWFtNjI1
LXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzaTogRml4IERNQS9FdGhlcm5ldA0KPiA+IA0KPiA+
IFNpZGRoYXJ0aCBWYWRhcGFsbGkgKDIpOg0KPiA+IMKgIGFybTogZHRzOiBrMy1hbTYyNS1zay11
LWJvb3QuZHRzaTogVXBkYXRlIG1haW5fYmNkbWEgYW5kIG1haW5fcGt0ZG1hDQo+ID4gwqDCoMKg
IG5vZGVzDQo+ID4gwqAgYXJtOiBkdHM6IGszLWFtNjQyOiBVcGRhdGUgbWFpbl9iY2RtYSBhbmQg
bWFpbl9wa3RkbWEgbm9kZXMNCj4gPiANCj4gPiDCoGFyY2gvYXJtL2R0cy9rMy1hbTYyNS1zay11
LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoCB8IDI3ICsrKysrKysrKysrKysrKysrKysNCj4g
PiDCoC4uLi9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2LXUtYm9vdC5kdHNpwqAgfCAyNyAr
KysrKysrKysrKysrKysrKysrDQo+ID4gwqBhcmNoL2FybS9kdHMvazMtYW02NDItZXZtLXUtYm9v
dC5kdHNpwqDCoMKgwqDCoMKgwqDCoCB8IDI3ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoGFy
Y2gvYXJtL2R0cy9rMy1hbTY0Mi1zay11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoCB8IDIz
ICsrKysrKysrKysrKysrKysNCj4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiANCj4gPiBiYXNlLWNvbW1pdDogMzUxZGExNWY3MWUzZDcwZGJjNjNlOTA3
ODFiNDAzNDE1NDUyZDg2NA0KPiA+IC0tIA0KPiA+IDIuMzQuMQ0KPiA+IA0KPiANCj4gDQo+IFRo
YW5rcyBmb3IgdGhpcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGku
Y29tPg0KPiANCj4gTk9URTogVGhlc2UgZXh0cmEgcHJvcGVydGllcyBhcmUgYWxyZWFkeSBpbiBk
aXNjdXNzaW9uIGluIExpbnV4DQo+IGNvbW11bml0eS4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMzA4MTAxNzQzNTYuMzMyMjU4My0xLXZpZ25lc2hy
QHRpLmNvbS8NCj4gDQo+IE1hcmNlbCwgY291bGQgdGhlIFRvcmFkZXggdGVhbSBjb25maXJtIGFz
IHdlbGw/DQoNClllcywgSSBqdXN0IHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgaXQuIFdpdGggd2hhdCB5
b3Ugc2F5IGFib3ZlIEkgYWxzbyBhc3N1bWUgZXZlbnR1YWxseSB0aG9zZSBwcm9wZXJ0aWVzIHdp
bGwgbW92ZQ0KdG8gdGhlIFNvQyBkdHNpIHJhdGhlciB0aGFuIGhhdmluZyB0byBiZSBzZXBhcmF0
ZWx5IGRlZmluZWQgVS1Cb290LXNwZWNpZmljIGluIGVhY2ggYW5kIGV2ZXJ5IGJvYXJkLg0KDQpU
aGFua3MgZ3V5cy4NCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

