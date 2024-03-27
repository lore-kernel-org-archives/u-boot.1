Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5E6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 02:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A993D87EF6;
	Wed, 27 Mar 2024 03:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KEGyKXVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1E187E3D; Wed, 27 Mar 2024 03:01:48 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA2688063
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 03:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTkSNO5UsH35fYO4M+I5wUC7TOQmqdRfzPQKl+74+AKCLt4J6XrMOi6Mo1QsI16mu8tXTly6KRhYZ3ubIfUgc03kMsLYuJLMwMgbcR7FGF/UZLZ1166paTCLIyrZdKEuj1Ui32iLE2xkxCVxsBQkp0kjVL+tJ2X87uvEU5atm6lDoq5Vf3lpg9VMAwWm2KMIThTKRYtsjZYi5MYjeV5KeBUD5mEB33ITaado2qROZaS10dk6CUFOxGmbou1YLz1xskW7coFt4WmuBEjB/xs9xfz1TWT+ssh5Mj30FchKmmAQkxfBpOJ73/H9HFuQy96WY1l6uOkzdx6ZfQA776Jqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a3pVurTtn5ozeyPsDu2qt8zBQI3BP+VvmyC5fK0jRs=;
 b=ge3tljFcMxkOMuxyDSg61Uha7qv/ww3in0buEESMy8dIui+oR9/NCTqS6Yhdp9ux//QpkhqLTjuGK6oN+s6BLECdiweq5absCYBKokRyPUbiIzcoXVsERFN1hdjp+rGDon24kCTdoTzGty8/9xlnS4ysZTx2VpM3QUwNsdstNr4L/xJixN3P/I/ji6Z+gzNTvmsqbM9ZzrOIz+/X+LKf5RWlXadXb3CcMsv5QBDE/o5f7l978RuYkc2vr7XMmn7HY4c8fFZaFz8qLbA1cWrRpnq0Recvf8t3yTDjNL6YldZr+rzRybTUZifVJN7rul+Yj21CTGHlz+Mrsjr8b4afpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a3pVurTtn5ozeyPsDu2qt8zBQI3BP+VvmyC5fK0jRs=;
 b=KEGyKXVgwIwqt4vXEZyLWHGC4NVP71bq/72ZxnQOcm4KEX9JOEoNuq8jAZIsswYOe7tPNjx9IXxs4/G5ZS9hcZ02hGtZmdhjFVNVhYzR8PQzuXskDamefXwJ4MPYVuNbmCiWdKAiKzXUytoV4BWb1JFv0yRfWy2lUh0Qcr/Ikdw=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 02:01:44 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 02:01:44 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "saproj@gmail.com" <saproj@gmail.com>,
 "judge.packham@gmail.com" <judge.packham@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v3 1/3] drivers: rtc: add pcf2131 rtc driver
Thread-Topic: [EXT] Re: [PATCH v3 1/3] drivers: rtc: add pcf2131 rtc driver
Thread-Index: AQHafy3xGUuClYoh0UmYMGGXMr2ukbFKlnKAgAA/NeA=
Date: Wed, 27 Mar 2024 02:01:44 +0000
Message-ID: <AS4PR04MB938675A8F4AC89AC49854DFFE1342@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-2-joy.zou@nxp.com>
 <CAOMZO5DnR_AoZJsnx8FD-y5j5UzgiPSHsPRRQkLKwYFwhCVWQA@mail.gmail.com>
In-Reply-To: <CAOMZO5DnR_AoZJsnx8FD-y5j5UzgiPSHsPRRQkLKwYFwhCVWQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|DB9PR04MB8250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vryc8KbLd1IwLJ+k2jMbLgleBxes6HgER+ueDY6TI+zGM57cpc7D3I7Mo5Ut39QH0xqnXSg1pHrXOhfvHm4e6DXszQi19syK9I1NfCwHCgOFCMm82soU3U4A6cce3QHG7gTP0x4LCmbprlACTlA2kTtenpzxZHMeLxqWZqLC7JfjUgMSwClE5dYTWo7C/TwhA3QWnjOJpgSJasPiwDLq4RyteJPuIl0vdYSLg/YZTHGxlmy433L+Yem14ComjNM7WELPMsrEl0Zk9y8iyVUelhcfnXkPLdSbbj3kHZYO+8ST5ajuKyXs5HbyYxEE5iYDJoPz4PutfCuUVFq7qArTCEv23q5qOsm4dRWtXQiX19oVokXOl2ayIGNTKnP/PjByVXn2y60UJAKJZHpvUM34ZdO3gJsUNJ6pATG/gHy/2C/7CPjrHSlk0jm0qzWoRZEIgwpnQzBPI2qT9sDc7oU3kHTUzL7itI6eBMbwEW63KZB8jVq6tkY5yyvz3Y7woS0qPpaTBnHWpoZlSwrE4XCSnCww0N6GDzBR7ikZqPw68X4VjYv07Pk31EZrDwqJMLrpABD8Zgi9Yj/EPUdpfL1Weww01Xs77XFIox48LEdLkt5pOgZiGNCi+9LXvsE6dqX0zThmJf/Zw2npS01kOnuiEWG57sctYJoABQwat7X6l50=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJTRGoxRXByZ2NtU3Y0R1dHUHRJbStnYjlqTHNIampYZTYzZXFrd0JFV1JQ?=
 =?utf-8?B?QVpEQ3VOZ3ptTkJuVW9MQzVrL1FZZ1dmdWVqLzJXeUVXalBvc2VxQzNObXFr?=
 =?utf-8?B?SW5mL1ZvWkRUdERTSTlqN09JYzk2amxsZU51SnVjdTAzdEdmUHZsYTh6bTlv?=
 =?utf-8?B?K2lKUjFuMXNNZjJsZlR4dER5c1p0ajBhdnZKMkI5aVNTZlI1S0JCSHFOKzYx?=
 =?utf-8?B?YWpJU3Y0UGtKK1diTVNrTU51SmFoU09oTjBHSDdiUVNKZlNNeFZrYXhoaWM0?=
 =?utf-8?B?WEZHb1lpaG41R0xSd3kyT1BlbFB4bXVXOWZGZjBuUmk4aDJ6Z0ZIUi9NRmVv?=
 =?utf-8?B?SU9oREdmZkprOEkvbWJYYUc2RlFRaUE3ZFhSOFRaNEtDUThJbmUvU2c3ZEhr?=
 =?utf-8?B?dnRwa3dTU1Y4b1JZaTNkRGNPbGFUSCtwekhnaWg3aUVxQ2FDd1pZWmZoU0p3?=
 =?utf-8?B?Yk1UNm9VckdqdE5oeks4UDRmdk13cFVzSEdra0lHNk5TYW02SDBRY0JhS0xL?=
 =?utf-8?B?QkltWGV1MWg0R0NCcGRiSHliUmVSYzJPS1ZNZXJMZXVPWnFWQ01XVUxCc0dw?=
 =?utf-8?B?M0lmYzFYcXR2dW5QTlFzSmRRbm1CWkxod2RqdWJ1bUt1ZTNzZndZTFNIWENt?=
 =?utf-8?B?bTRIZjRtRHlWNE5xalYrR2x5R3lvUm1QR1YzL3JpMk10cGxJUzdnbm1lOEY0?=
 =?utf-8?B?ZlNNUldtTTlubVBJUTNGbGtLNTFiWThtTDJCT2FLN0NDRlpTNkFLaThCMWpT?=
 =?utf-8?B?aEcyZDV5KzNtd01yc3lSbEptQjhjeFZZZm4vbU9idU1sb2l4UTBvTktxeUVl?=
 =?utf-8?B?K3VubEJ4a0tUU0Nlbjdlby9YVWJITExCOEVFQzg0cmVEU2E1TDZhRXZOOWxN?=
 =?utf-8?B?a0RtMHVkQUlVbXFnNm4rcGVDUkRhNHVpbFRERHRYTzRPS0UydnhiZC9xQlBQ?=
 =?utf-8?B?QlBmNGxWdk03MngrNjVoYlVhekZSbi8vMGFlNEl3bFdubjZ4RjdaaXBxMmZ0?=
 =?utf-8?B?RFlsN0htK1h0Y25ORTYydzdtNUp3MWVBZEozSjYxQWxRK2M0QkVVKzRSKzBG?=
 =?utf-8?B?L2hDeklpOUZsc3k0ZldtV0NKNmJ0YXAyVWpKeFdrcmRWUS9Vc2lmbjNvVU1O?=
 =?utf-8?B?VjU3dEVHcHZFaTc0WDFFL05CWmdIUW01OEtCcmg3MGMyNmpBQ2paOXAySTVU?=
 =?utf-8?B?aVBUTkFORGlOc2RLaWlxeTducElMeFh6NGZvQnFiVjlxb0ovQW9LOHVYSnFu?=
 =?utf-8?B?NEVFM2hWLzNSeEo4QnMyc0dPSEc4U1cxVHdaV01PblUyVWpCNnd1czVwNi9S?=
 =?utf-8?B?Q2dSUnFIVlVJVGtRWXdiNjBRdkI0bE0rMXZiVlV4djNxWVJtdlJMZEdrZ1Fw?=
 =?utf-8?B?TWMzTFdlZ3hGSlJPN2RTK2pBdnRHRXNEK1VMcURWWXdPaFJEd2tpaUI2MVg1?=
 =?utf-8?B?VzRmUlEwS1BjcEx0UmgwV05BYlpXTHlEWE5HZEZodXJrUHgvdTJDQnNYWTRy?=
 =?utf-8?B?TVlRd2RGall5MHhLN3Ava2cwUzNkMjhBbXdOTzZ4QitCd2pNWUdNL2wyYmhP?=
 =?utf-8?B?S3FUeWtGVElhcGJGY1ViVTRjNFNWdUtQSE92VExkRVBYRTN6bmtoSnJXbmdr?=
 =?utf-8?B?UjBjSDQxQTAxL3NPczJEdm8zSDh2NUtSUEhmUU1mWlFvZUw5NFo5VFZvTjlZ?=
 =?utf-8?B?TWJSWEV0ZFhnSUZJWTBDTFRVb0RQNHpFdHJUUDR4Z2V5QXlxa0hxT0VpZzFq?=
 =?utf-8?B?cEs5SXpNYUZyOWUzUnN5QVlqZ3ZLZ3hqL25DbVU4TnhBMzVBT0NtbFpUOTRO?=
 =?utf-8?B?QUtaeU5RN0NVZ3pKQk5WNU5jU2wrSU1jL0JlaytOeGFoTkF5SG10REExZ3Mr?=
 =?utf-8?B?N2NScXVVN3ZkWjk4Si9DVHV0ampFM3ZZSDA3TG11SDhZbWN3U1BBLzgrOGlO?=
 =?utf-8?B?K0dxQnRnL2lmVnVyVzZQUUwxRGo3R0NQOHRpTXFxd1ZzYzlQMDdTcmgzV2po?=
 =?utf-8?B?MXBBWHV1ZnZJWStaaUs1WndITitOa21BMytTa2F1OEpGZXFyaDkyWDZqNHZE?=
 =?utf-8?B?cGJPOFZ4cUxTVVhIQUFJRFF4ZkVkbnhPZ0hzdGI0bDkrc251dExhVENaQmRo?=
 =?utf-8?Q?5dFQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ab5e50-01b7-434a-feeb-08dc4e01da27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 02:01:44.1403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGkhSJBTIjxbzwQBVoNZH0nFhthNa4SJKRHD2Z1l4TL8jFCIOuAvZyArsTd3+rc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250
X-Mailman-Approved-At: Wed, 27 Mar 2024 03:02:48 +0100
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTlubQz5pyIMjfml6UgNjoxMA0KPiBUbzogSm95
IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
OyBZZSBMaSA8eWUubGlAbnhwLmNvbT47IEphY2t5IEJhaQ0KPiA8cGluZy5iYWlAbnhwLmNvbT47
IHNiYWJpY0BkZW54LmRlOyBzamdAY2hyb21pdW0ub3JnOw0KPiBzYXByb2pAZ21haWwuY29tOyBq
dWRnZS5wYWNraGFtQGdtYWlsLmNvbTsgZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhwLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjMg
MS8zXSBkcml2ZXJzOiBydGM6IGFkZCBwY2YyMTMxIHJ0YyBkcml2ZXINCj4gDQo+IENhdXRpb246
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2lu
ZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQg
dGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0K
PiANCj4gT24gVHVlLCBNYXIgMjYsIDIwMjQgYXQgMTI6MzDigK9BTSBKb3kgWm91IDxqb3kuem91
QG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiArYm9vbCBpc19wY2YyMTMxX3R5cGUoc3RydWN0IHVk
ZXZpY2UgKmRldikNCj4gDQo+IHN0YXRpYyBib29sDQpXaWxsIGFkZCBzdGF0aWMga2V5IHdvcmQh
DQo+IA0KPiA+ICBzdGF0aWMgaW50IHBjZjIxMjdfcnRjX3JlYWQoc3RydWN0IHVkZXZpY2UgKmRl
diwgdWludCBvZmZzZXQsIHU4DQo+ID4gKmJ1ZmZlciwgdWludCBsZW4pICB7DQo+ID4gICAgICAg
ICBzdHJ1Y3QgZG1faTJjX2NoaXAgKmNoaXAgPSBkZXZfZ2V0X3BhcmVudF9wbGF0KGRldik7IEBA
DQo+IC00MywxMA0KPiA+ICs3NSw2NCBAQCBzdGF0aWMgaW50IHBjZjIxMjdfcnRjX3JlYWQoc3Ry
dWN0IHVkZXZpY2UgKmRldiwgdWludCBvZmZzZXQsIHU4DQo+ICpidWZmZXIsIHVpbnQgbA0KPiA+
ICAgICAgICAgcmV0dXJuIGRtX2kyY194ZmVyKGRldiwgJm1zZywgMSk7ICB9DQo+ID4NCj4gPiAr
c3RhdGljIGludCBwY2YyMTMxX3J0Y19sb2NrKHN0cnVjdCB1ZGV2aWNlICpkZXYpIHsNCj4gPiAr
ICAgICAgIGludCByZXQgPSAwOw0KPiANCj4gTm8gbmVlZCB0byBpbml0aWFsaXplIHJldCB3aXRo
IDAuDQpXaWxsIHJlbW92ZSBpbml0aWFsaXphdGlvbiAwLg0KPiANCj4gPiArc3RhdGljIGludCBw
Y2YyMTMxX3J0Y191bmxvY2soc3RydWN0IHVkZXZpY2UgKmRldikgew0KPiA+ICsgICAgICAgaW50
IHJldCA9IDA7DQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gIHN0YXRpYyBpbnQgcGNmMjEyN19ydGNf
d3JpdGUoc3RydWN0IHVkZXZpY2UgKmRldiwgdWludCBvZmZzZXQsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCB1OCAqYnVmZmVyLCB1aW50IGxlbikgIHsNCj4gPiAtICAg
ICAgIHJldHVybiBkbV9pMmNfd3JpdGUoZGV2LCBvZmZzZXQsIGJ1ZmZlciwgbGVuKTsNCj4gPiAr
ICAgICAgIGludCByZXQgPSAwOw0KPiANCj4gRGl0dG8uDQpXaWxsIHJlbW92ZSBpbml0aWFsaXph
dGlvbiAwLg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KQlINCkpveSBab3UNCg==
