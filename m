Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B11C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D584874C5;
	Thu, 16 Nov 2023 17:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="gfM720qR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FB08749E; Thu, 16 Nov 2023 17:43:14 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCAB874BF
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1700152988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoCp0gjlQuFsfzDwpAsV8dbTSs2SO5UsgHTPq91CC+k=;
 b=gfM720qRiBfZ5aheO8Ua3k6gdqXuyQDWxuwMOECzFIlZ/jmwvoPTV9F0OZHWT7dz92Oeik
 7v4LBZgyv02Tk8MyizIPu3emu+9EN5bSbjTc4XqEthsQeYyziVXXeRbqkLmI5HA4hhNeZo
 2P+0lioyvP+2B8bKgJAzJxFnxQC2o6s=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-53-5Fw2NTaZPLGA1CRP0HGQWg-1; Thu, 16 Nov 2023 17:43:05 +0100
X-MC-Unique: 5Fw2NTaZPLGA1CRP0HGQWg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0810.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.21; Thu, 16 Nov 2023 16:43:04 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:43:04 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "n-francis@ti.com"
 <n-francis@ti.com>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "afd@ti.com" <afd@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "nm@ti.com"
 <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
Thread-Topic: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
Thread-Index: AQHaF6v+nIj6D50cjk6t1Q90GuEqLLB9HXCAgAALJoA=
Date: Thu, 16 Nov 2023 16:43:04 +0000
Message-ID: <f99de6984d737ace5b4f6c014909640cef63ce12.camel@toradex.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-2-n-francis@ti.com>
 <CAPnjgZ22W3EpWdw-t=B9CjGJkQcNm1hARi1efe91JCxhzoZUpA@mail.gmail.com>
In-Reply-To: <CAPnjgZ22W3EpWdw-t=B9CjGJkQcNm1hARi1efe91JCxhzoZUpA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0810:EE_
x-ms-office365-filtering-correlation-id: 95ca5311-ec28-4c3a-ccc0-08dbe6c31a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: EwkjVZpp2mwZEY/c5e5OEid4x/w8wCmvhIUqlrAA7cD3MhcxgwQothhBNaeB4WKknPjqDnwXV7WvfIomcCNTK/IRb+brA9wHcS52rgiwJWqAhwjfsmQsy9KDtXgmZWAV0thFfjhTo4KfTDjlnMjwr1eg7mD7k0lBjsIfw7+la06qR16XfybrKMvuKlQ1BLiEFfM0Nsg/2FoO9eKr7VnAd0DvtVsZuniq6jSx6+OVBIETXQ8AEymCL4Dxfudyes1PmYzQDC8WYSxOsb1xsCWkPaWKy8NfNVEajVk8Qqvt9PpAqWDqfFu/n/7h5TQ8+3ZYAA5UcOh1wbglQZbWpC5I8txKDbdT6o4M5CaMygs/zQaCwxu1OnmAMVqShcem4pa3E7PmCz8Hak0FUBzG9T/MR4wL7QbYWUIHvzjyC/C+GeEtDtcloaSefoJEE07LJVsQwDKbwA1I1WQ9S1yW2ESsFJATddBjafA6+PUUvmu/bV9NDl4xDNohNYyvGhMZFaCp4wdIFZKMydz59QxxW+FZLvxkSbntuC+lmqNtAIAkB9mAAOvIBR6H9HvdgJ2RYdXTwMwA4BPlRETsAS46Bji2wnyN04O3iBeG5ZVgA/694IMtp/sjI68ppTOKe9FjhD2v04Z0/Ezxj5gKkeftVXcuxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39850400004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4001150100001)(5660300002)(122000001)(4744005)(83380400001)(7416002)(2906002)(41300700001)(38100700002)(83080400003)(64756008)(54906003)(316002)(110136005)(38070700009)(66946007)(66556008)(66476007)(66446008)(76116006)(6512007)(6506007)(86362001)(966005)(6486002)(36756003)(478600001)(2616005)(44832011)(4326008)(8936002)(8676002)(71200400001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm4zSGl2RnNBWXpUc2EvUjZPaTNvN1JINEg1anpUVXpsb1hsYW9TNldMZ2xS?=
 =?utf-8?B?OGpwWXVhRmN2dHpiYnkreTVtL3g1S1pUWFpHaENsRitibER1ZkFVL2RzdW1x?=
 =?utf-8?B?TDV0bVd1SkhENnNnakVYSSsyc1kzbHdXck1tWGpmbnFQT0pVeUlLTFI1Rjg2?=
 =?utf-8?B?b1dpSE9oQk1LWkFQZXd4OWp4RVFzSnNGOUpoOXBVYXk5QnA2bkovVEdDSDY4?=
 =?utf-8?B?d2pDNk9mcG96OWtiYklrYjlWdjVCZ21YdEExbE53K3k0VGYrSkFNZUNQS1Ny?=
 =?utf-8?B?V1BhNlpXWUlaSlplRGlkM0RlclpZR25yMjJGdVFhbnN2aWZRd3VzZlI0allQ?=
 =?utf-8?B?NjlXTkJuaVF6dmdodDdqeldqekFrTklxWW1pWSswMUdPdXRGODRpK2Q1Vndw?=
 =?utf-8?B?S3dMQzVQTm10YkNpY2lMNzh4UjRVODAwN3JKeXl6aWwxSU8yWkJiK1FwT1Fi?=
 =?utf-8?B?NVNzaTRuajBHZWx1NmN1WXdOYTJLNDdoaGZjaXk0dUYrU2ZCZDdjc2JJaG5D?=
 =?utf-8?B?WjVYbmZlYWYxcldKOEt1T3dxa3cwQW1adXN5eHN5Unc0WS9lL2xhbm12MTdH?=
 =?utf-8?B?M0JYSlFodzVPdGRrenoxUlFUWkhGSCtJQnFtbEc0a3JmWHR3UlNlcEMyZE1l?=
 =?utf-8?B?TUFxWmt5b2VxaUJjUXRXL0pCeDFrRmdGZlhhMThYTFZDREsxeHIydWhndzR1?=
 =?utf-8?B?QUNUU2QwZUVubXUrOHNpd2x4bGQzTzBPMHBjZjhzSWp3Y0NPbDJldUphWGlL?=
 =?utf-8?B?MytPUlRSVTJIS3Ztd2dGeE43QStyTHlhbUNTU25UQlYrNUxzSVdRU2cvbVJJ?=
 =?utf-8?B?bXJNMUYwNktkeG4rU0VFTDRTODN2MjhNd1lmQnF5VzQ0c0I2L3lISTllZThq?=
 =?utf-8?B?azhCYTQxM0dsa0x6RnRvR21CR1VBcVNabXNhOUQ0N1hDTndSNG9SMk5QRVk4?=
 =?utf-8?B?RWhIekppRy9RRjlVRTFDOXI4TER6NTRUd21TUlVhbE55Y3JFL0lUQW9vSkwz?=
 =?utf-8?B?UDZDQTRNNkZ6ZVVSQm5oZnZQMUUvL0VOcnh5dm81N0c0WHB4MkFlb1E3THRX?=
 =?utf-8?B?NmxYN29xMGhSTitnYm4rbWhKL0JwcXN3cWxscXBKbnFPdVpidDJyNXdxSWRi?=
 =?utf-8?B?UmZBSWdwbDlidVphN1Y3RUdIMjd5VzBuMzNLSmQzRW1jZ1RacmFJY0ZaQVZV?=
 =?utf-8?B?Q1o1UFptUmdZOGNJV0I4ckNKalpLMnNLYlVGSEtxcjFRQ2xYNEdJQTJDVHRR?=
 =?utf-8?B?SEUvb216Kyt5TkptNWNzcnJMVENVdlZNUlNVRzVuUFF1dXVjVU5zOEQwc0FG?=
 =?utf-8?B?dDl4VDBodGl0YzQ2Z1dkdU1PQW1QQ3Q0ODVkYkZFaHpwYm0xTGFUTVZXMVIv?=
 =?utf-8?B?VmJwcUhyL2tBVlhMeXB1ZDJvSHZhUTI4Z00vMnAxUkw5NC9ock8zcjBCbG1a?=
 =?utf-8?B?OFVqbVByYis0eXEyUXQxOXE0d2Jod1BKUkFzdDR5dzk2QmxRN3RpOFk1NHNk?=
 =?utf-8?B?SUp6MGovMzFBcVlIa053SmdJb2ZPa2Y1bG1TWDRuSERwN0NoN3ZDVGJqQ3ZP?=
 =?utf-8?B?dnFSV01GMG1wMy92cnB5NnN2SmhxT25KbnlBY3V6VjNwVmRjbmE0VnBWa0Ft?=
 =?utf-8?B?TEFURExmTzd3MjhXYlpucnVZai8rSUlZNXNsNm51UkJVOTNsRHNsdGhMMUpr?=
 =?utf-8?B?T1k2WG4rRzg5UWI0QzJVK0pabUl1enNlemEyN0c3dnh1a1lOV1hienIvcE1i?=
 =?utf-8?B?dXI2WHd2UTBmcGlOTnlnWmZyZ0Q1UTdncC9ENllRajZBSDExMmxVcndCaTBn?=
 =?utf-8?B?OW0zeStsVXdJT0hIUWFXcnRXeDBTZEdaKzI1aUlDZW92azdOWk9Ib2pLK0M0?=
 =?utf-8?B?dFlUTU9MdFk3QVRFa00yNGt2emJkczdGS0xETzlieFlqQk5VM0hVQVhFUUNH?=
 =?utf-8?B?ajFyM1VndzZWK0c0NGM4SWVBZHM3dm9IUzBVeFMybFVqREhMdWdUcXRaOVZw?=
 =?utf-8?B?UTRiVGY3NkJnNm15RjdFOW9TZEpxbG9SSnNiSHRpRGhsQkNYMm1MZFBvTm5X?=
 =?utf-8?B?Zkl0NHNtc043Z05TQnArYTJwUmFPdlkwSGJVZjdBd1R0bjR5U1gwS01HdGg2?=
 =?utf-8?B?Q0VwSmt1ZEdSdVF0UnhHdjNWWldiS2FJa1c1Tm5tVEpMT1hlSzRBQ1ZzTmdu?=
 =?utf-8?Q?0hwxrVpRgSjrMPQNJhIcwcw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ca5311-ec28-4c3a-ccc0-08dbe6c31a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 16:43:04.1797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYaZLaNw8IKjnGqHp3ycY477I1OVyq+eiFMhXnTAdJRq06PJya3snwSgRdTzxBB/NFHXq96k3vM+qmJK4KkzeWOkMDxwhYkJ1ysVUCe8ifI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0810
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C01924E785A3874E863056CAC3E5226F@CHEP278.PROD.OUTLOOK.COM>
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

SGkgU2ltb24NCg0KT24gVGh1LCAyMDIzLTExLTE2IGF0IDA5OjAzIC0wNzAwLCBTaW1vbiBHbGFz
cyB3cm90ZToNCj4gSGkgTmVoYSwNCj4gDQo+IE9uIFdlZCwgMTUgTm92IDIwMjMgYXQgMDM6MTAs
IE5laGEgTWFsY29tIEZyYW5jaXMgPG4tZnJhbmNpc0B0aS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IEFkZCB0ZW1wbGF0ZXMgZm9yIEZJVCBpbWFnZXMgdXNlZCBleHRlbnNpdmVseSBhY3Jvc3MgSzMg
Ym9hcmRzIHdpdGggbW9zdA0KPiA+IG9mIHRoZSBjb2RlIGNvbW1vbi4gVGhpcyBpbmNsdWRlcyB0
aGUgRklUIHBvcnRpb25zIG9mOg0KPiA+IMKgwqDCoMKgwqDCoMKgIC0gdGlzcGwuYmluDQo+ID4g
wqDCoMKgwqDCoMKgwqAgLSB1LWJvb3QuaW1nDQo+ID4gwqDCoMKgwqDCoMKgwqAgLSBzeXNmdy5p
dGIgKGluIGNhc2Ugb2YgbGVnYWN5IGJvb3QgZmxvdykNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOZWhhIE1hbGNvbSBGcmFuY2lzIDxuLWZyYW5jaXNAdGkuY29tPg0KPiA+IC0tLQ0KPiA+IMKg
YXJjaC9hcm0vZHRzL2szLWJpbm1hbi5kdHNpIHwgMzI3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMyNyBpbnNlcnRpb25zKCspDQo+
ID4gDQo+IA0KPiBSZXZpZXdlZC1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+
IA0KPiBXaGF0IGlzIHRoZSBETSBiaW5hcnk/DQoNCkZyb20gWzFdOg0KDQpETSAtIERldmljZSBN
YW5hZ2VtZW50IGZpcm13YXJlIGFsc28gY2FsbGVkIFRJIFN5c3RlbSBDb250cm9sIEludGVyZmFj
ZSBzZXJ2ZXIgKFRJU0NJIFNlcnZlcikgLSBUaGlzIGNvbXBvbmVudA0KcHVyZWx5IHBsYXlzIHRo
ZSByb2xlIG9mIG1hbmFnaW5nIGRldmljZSByZXNvdXJjZXMgc3VjaCBhcyBwb3dlciwgY2xvY2ss
IGludGVycnVwdHMsIGRtYSBldGMuIFRoaXMgZmlybXdhcmUNCnJ1bnMgb24gYSBkZWRpY2F0ZWQg
b3IgbXVsdGktdXNlIG1pY3JvY29udHJvbGxlciBvdXRzaWRlIHRoZSBzZWN1cml0eSBlbmNsYXZl
Lg0KDQpbMV0gaHR0cHM6Ly9kb2NzLnUtYm9vdC5vcmcvZW4vbGF0ZXN0L2JvYXJkL3RpL2FtNjJ4
X3NrLmh0bWwNCg0KPiBSZWdhcmRzLA0KPiBTaW1vbg0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

