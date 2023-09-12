Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AABBCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883A286E61;
	Tue, 12 Sep 2023 13:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="G7IrmQG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C5E86E5C; Tue, 12 Sep 2023 13:22:01 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA93A86E4B
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 13:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1694517718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgHKzDyMV56b1w3j678o4RIcyIBempFk4anKNSrBwXI=;
 b=G7IrmQG9OtZC6MdZw9kTqMdonZotWdNHPdRfK/Nl/V4XfTvKIQzlkOWv8fNAdwVDoyXzeJ
 vGF4kX7pREeg6LHjOlnbEO/XLpsxVQHU11iYWLF3sk0u/LBbMYwNEvZolYcGKCut2BL2XR
 1beJb2+wnlbEO6vxLpwoJ9E2vI9GClM=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-3cpVSBypNCeeld0gQBxWxA-1; Tue, 12 Sep 2023 13:21:56 +0200
X-MC-Unique: 3cpVSBypNCeeld0gQBxWxA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0895.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Tue, 12 Sep 2023 11:21:53 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 11:21:53 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "nm@ti.com"
 <nm@ti.com>, "j-kacines@ti.com" <j-kacines@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "sabiya.d@ti.com"
 <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>
Subject: Re: [PATCH v3 03/16] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Thread-Topic: [PATCH v3 03/16] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Thread-Index: AQHZ4mBMB99Rxo2T106MmJFKGzZTzbAXEecA
Date: Tue, 12 Sep 2023 11:21:53 +0000
Message-ID: <7c117f6e95dc006ab1c2940f927d5ef90a494413.camel@toradex.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-4-a-nandan@ti.com>
In-Reply-To: <20230908110551.861575-4-a-nandan@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0895:EE_
x-ms-office365-filtering-correlation-id: 181a81ca-f9de-4d47-daa2-08dbb38277bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: JBqqd/6SOB4IyHBGblw7Xh/E+i4Yje9zGArQFZiQvbmC34SFuSmlDPZ2m8r+CzPQqXT+iTRluxJoGAF9xkdlIRWavfFa3ny8SA87y/0tBlaiFbzYlBAUuI6A6UTicMLNwhXFlYyYbBUNo8XDni7ohncMRTFk5X+tYolr70IbsXz9xNCGTZ0A+HmsVJuDqn9Z7yc/7J5L6KukzaJ85r2KU+Dd59HVEIp901IkHzqyzaZsIc/GihdP1NNJO9AaYCTpMRvlkLdI2uo79c1IS/d0Jea/lBm0cCbYpxcW/J1Jce4/WiGwq+0yMtW0uuOyaKfqbToAGZY7j48tcZXKrEWLnDHXRuloXd1ZDvMIRQvkR+I7LKU/3k1qvsz7oxL3pnR+iuuxTqR8j+AZTcni3/XCsPgQiEYHBohbKxHPbeY7A/WXoB1lhuI5BSgRVWpCW6KBIPz2ykoi8Ca1fnZhvt7Mdq5xK2ReefwUza/bOOYJoCAvDvJzi2EoIaY5+N5HUuu8JovYC12w4VyDjesLJ4dr9OZLpQB/JpsitUDy/lFiPO3rc86sVo6o4ZW33aFucm1S1j7RBdEJc2U2zLE4iriKTXJsoHuVOI6kOxX39tAlkAHNefSELIvhsBIT6McP1Uei
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39840400004)(346002)(396003)(1800799009)(451199024)(186009)(26005)(2616005)(44832011)(5660300002)(8936002)(8676002)(6512007)(6486002)(6506007)(66946007)(66476007)(110136005)(66556008)(66446008)(76116006)(64756008)(38070700005)(38100700002)(122000001)(478600001)(921005)(71200400001)(316002)(41300700001)(36756003)(86362001)(2906002)(7416002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bms1NmY3YVZ2YjYwVmJlZXJoL2haRmhoWURVKzhzRC8zTTN6NlR4c0tXOEgw?=
 =?utf-8?B?Zm9nTWtsMzNhL0p1ZGNKTjJSTzdLUStGMEhsNDczYkNIdnRDQjFzRWVGOVZo?=
 =?utf-8?B?a0JUUndmRFdaQzU2K2RYUm5aWVdKTlZGdnJMKzFFSXJobDJDQm5KeEtySTRH?=
 =?utf-8?B?N0lRZmFlNVlQcm81bHVlTFZiR2hza2tncHBzUTh2UTRzTUl0UjZMYTJ3d0FW?=
 =?utf-8?B?ZWo3Zm4zcnlFWjFjaU1CV1BhQnhVVnY0YVhDQ2ljWlV0dTFPeU9GRGNINTJL?=
 =?utf-8?B?c05CN1oxQjJURkdoWjJ1MGt0VFAvR2VhOWkyaWtiOE1oZThSOWVDNFhaRzcy?=
 =?utf-8?B?ampYd2lKUllKQnlKT2RHVnBqTUQzS2IxRC80cWV4YlNrMDg3d2w5VksyNEdR?=
 =?utf-8?B?VXBHVkwrd1g2Y05YWVlPandSZDVSV2tEc0xtTS9wdm9jbk02N3hQUEtCUDN6?=
 =?utf-8?B?WWdKUGRsMFpRdzVxekJKMml1dU9Tak5XNjdsYTl4UUJqa216S29QSDkzb3ly?=
 =?utf-8?B?bnJpSlY3dXAyWnVPNHA1VlRSVk84OWQ2U2ZSOFlnTktrVnBqMDBLU1lqSGxC?=
 =?utf-8?B?YWJXT3VHU0xsdW8zMGN6ZnNybjQ1K2YxcUNXUGFpY2w0NERlU3QvQ2dKU0Y4?=
 =?utf-8?B?TDQ3T253c05nZVlrT3Q5V21QQ0VOdGY2aGJBTllPandZTXBnTmRYWEp5SUtw?=
 =?utf-8?B?ZVRjYUNnZnJ0UmRGczR4ZjBCaC9iem5HL0JmUmdCRVIyVWpSd3NXN2xsKzkr?=
 =?utf-8?B?RGRhamxrTlNyWFRmeXh4dHg3MEFJMENFTFAvN3ZpazNqSWF4b1gzZjBEOU1z?=
 =?utf-8?B?S0IzODB5WnFKNDlvcFkwejZSOWYrbkdENVNUNm8yKzlmUXpIK0hERm5KeG9E?=
 =?utf-8?B?bHBrNElySlVVeW1zaWhCcnJFblFEMWtxL2lPUTFkSSt6MG95bExlUmYxZEJD?=
 =?utf-8?B?MUZWdi8rdE94R2lxVUs3N3dBQ3h1UVRYVFNucGhyVFZmSUxSZndiZEdwZit0?=
 =?utf-8?B?dCtnMzczUW9hV1hCdU9mNUlSaEZYUVN4enVleW9rSXVjR1FsaVJaZks4dVBn?=
 =?utf-8?B?VDBwbUtCYmFrSk43aGl1OGdLOXlqT2ZveDh6am1VTzN6TzEwclVUOWRsWm5E?=
 =?utf-8?B?TWt3SVBRTXVUL1lPT0d3alpCdEpaeGtsTHowNkV1bWhBSG91NmxKN0NVVEFo?=
 =?utf-8?B?ZXpWazAzN09wN2FBOE0xbzlSVjJsR1A4RmRjenlYQU1QMmtSajI0TnFoN2tm?=
 =?utf-8?B?TTRtc21Selhwa3pPaklQTmlRY25tRThJSVdYUUZHM3dySncvQkhSaWQvSVdk?=
 =?utf-8?B?SENUTlYxOHRJc0JqRFJyZ3pDRE5ja0hIU1hLVnQ2WXBRWEZvRk5WYi9yNk9h?=
 =?utf-8?B?ZHhzeXN5Zzl4ak5mekcyYXJHQ2oxZi9NbldhaDQwbncyejZQV3IyS3R3Q05N?=
 =?utf-8?B?dGdETmlFQjVZYi9jQS9VWjM5YXRkbTU4enVTR05OdUxHYmhPTFo1MW5US0dG?=
 =?utf-8?B?dnFLekZxbWVPNGUzSTFIWG1LWEpaVTNicFdpdHNiL21tcWFVSHlxaHRrYVZz?=
 =?utf-8?B?RFQyaXA4SlF4ZHI2S09xdUxjZXlsUS9HUExxLzJjZ0dPeUlWT0xVYThhUVgr?=
 =?utf-8?B?VUJmZGJraXZlZjJxU2dWYW5NVDRNcW9iK0gvSHg3UUpsczdmMkt3SkFKSHRM?=
 =?utf-8?B?dVVIVzZhYTFvdk80eGdKQmJ2M0M4RXZjRUI0emVNeVFDOXh5ZzQwTElOWm1F?=
 =?utf-8?B?dElXUXEySzNuSzVtcERVU1daZW9Wc29jQUJjbWIvTE44eXBHcnlRK3F3Umdm?=
 =?utf-8?B?NVFaMmMwMGJ1anhkMEprY2xWY241UitLZ1k5UDJUdFdwVmhTS2lxNmsrUFo0?=
 =?utf-8?B?TXVxTTZ5WWUvbUEzU01UWUc2THRtTHQ1T2laeitmQkhtR096R3VQNW1EYlNy?=
 =?utf-8?B?V3JOS3dmdlMvMnJmODFsR05uT0FBNGRhd013T1ZYR0hYUHQ0YzlDZ1IxY2pO?=
 =?utf-8?B?SC8wS0ZOcG0ydDd4TjNHQUFrM1N2OFJjT0dxRnNUQndDc0JIVmczUUlMVGJC?=
 =?utf-8?B?blkzT2VLMnh5NDlXREZEMWc3elM0ZTFZaGNlQm92OXVpeGZMQStENzZqeDZy?=
 =?utf-8?B?Y2hXM2NqeVA2RmVaK2NvZ2FyaDFtenV1QllWd2IxYXZOcUdtUjUwbW0xTis0?=
 =?utf-8?B?YVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 181a81ca-f9de-4d47-daa2-08dbb38277bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 11:21:53.8934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ft0660oQYNk1YBVo8mSLZ/YROqtVyW/B3d1hkJXnJPag2y/g/Q2DzbXiZDvOa+CamjKzZFMuIAJYCV18GmgxcDe7VGDt+6wOhqNQ+As6BBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0895
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <FCF5AD9C00800144A6D46927FA1DC25C@CHEP278.PROD.OUTLOOK.COM>
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

T24gRnJpLCAyMDIzLTA5LTA4IGF0IDE2OjM1ICswNTMwLCBBcHVydmEgTmFuZGFuIHdyb3RlOgo+
IEFkZCBzdXBwb3J0IGZvciBKNzg0UzQgU29DIElkZW50aWZpY2F0aW9uLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEhhcmkgTmFnYWxsYSA8aG5hZ2FsbGFAdGkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFw
dXJ2YSBOYW5kYW4gPGEtbmFuZGFuQHRpLmNvbT4KPiAtLS0KPiDCoGFyY2gvYXJtL21hY2gtazMv
aW5jbHVkZS9tYWNoL2hhcmR3YXJlLmggfCAxICsKPiDCoGRyaXZlcnMvc29jL3NvY190aV9rMy5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMgKysrCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWsz
L2luY2x1ZGUvbWFjaC9oYXJkd2FyZS5oIGIvYXJjaC9hcm0vbWFjaC1rMy9pbmNsdWRlL21hY2gv
aGFyZHdhcmUuaAo+IGluZGV4IDAzYjE4ZjZiYWQuLmJhZGE4N2QwYjIgMTAwNjQ0Cj4gLS0tIGEv
YXJjaC9hcm0vbWFjaC1rMy9pbmNsdWRlL21hY2gvaGFyZHdhcmUuaAo+ICsrKyBiL2FyY2gvYXJt
L21hY2gtazMvaW5jbHVkZS9tYWNoL2hhcmR3YXJlLmgKPiBAQCAtNTAsNiArNTAsNyBAQAo+IMKg
I2RlZmluZSBKVEFHX0lEX1BBUlROT19KNzIxUzLCoMKgMHhiYjc1Cj4gwqAjZGVmaW5lIEpUQUdf
SURfUEFSVE5PX0FNNjJYwqDCoMKgMHhiYjdlCj4gwqAjZGVmaW5lIEpUQUdfSURfUEFSVE5PX0FN
NjJBWMKgwqAgMHhiYjhkCj4gKyNkZWZpbmUgSlRBR19JRF9QQVJUTk9fSjc4NFM0wqDCoDB4YmI4
MAoKTm90IHN1cmUgd2hldGhlciBpdCB3b3VsZCBiZSBzbWFydGVyIHRvIHNvcnQgdGhpcyBiYXNl
ZCBvbiB0aGUgSlRBRyBJRCBvciB0aGUgbmFtZSBvZiB0aGUgZGVmaW5lIGxpa2UgeW91IGRpZC4K
Cj4gwqAjZGVmaW5lIEszX1NPQ19JRChpZCwgSUQpIFwKPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBz
b2NfaXNfIyNpZCh2b2lkKSBcCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NvY190aV9rMy5j
IGIvZHJpdmVycy9zb2Mvc29jX3RpX2szLmMKPiBpbmRleCBiNzIwMTMxYWU1Li42ZjdmY2Y5ZTEx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc29jL3NvY190aV9rMy5jCj4gKysrIGIvZHJpdmVycy9z
b2Mvc29jX3RpX2szLmMKPiBAQCAtNDUsNiArNDUsOSBAQCBzdGF0aWMgY29uc3QgY2hhciAqZ2V0
X2ZhbWlseV9zdHJpbmcodTMyIGlkcmVnKQo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIEpUQUdfSURf
UEFSVE5PX0FNNjJBWDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbWlseSA9
ICJBTTYyQVgiOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gK8Kg
wqDCoMKgwqDCoMKgY2FzZSBKVEFHX0lEX1BBUlROT19KNzg0UzQ6Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGZhbWlseSA9ICJKNzg0UzQiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbWlseSA9ICJVbmtub3duIFNpbGljb24iOwo+IMKgwqDC
oMKgwqDCoMKgwqB9Owo=

