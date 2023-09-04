Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEF5C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E14B86741;
	Mon,  4 Sep 2023 15:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Gmm6Es9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF83A86901; Mon,  4 Sep 2023 15:37:54 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E98B86053
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 15:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693834671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAAJd8dUS+zeKpPHX0zhoEfbaj9TkQyNwQFoKCamfTE=;
 b=Gmm6Es9v5ZiL3h7AinTrarrwuC3sCHxkxMrN/9OoAYqIrIWKQxlzj6P9gRBucSXqTKjxuz
 cM20MVuRMJbpMywKGSD+RcDyWm5weii2axBzS0aw/dsU5I3EpeGha6iPu5NhpLO3EcdrVn
 hVTmCkGAuJ4DsHU7O+fYjU/EpHBHSqg=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-7HQudc_AOva-lTbK7_jqjg-2; Mon, 04 Sep 2023 15:37:50 +0200
X-MC-Unique: 7HQudc_AOva-lTbK7_jqjg-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0042.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Mon, 4 Sep 2023 13:37:49 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 13:37:49 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "hiagofranco@gmail.com" <hiagofranco@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Hiago De Franco
 <hiago.franco@toradex.com>
Subject: Re: [PATCH] verdin-imx8mp: drop unused tdx easy installer ifdef
Thread-Topic: [PATCH] verdin-imx8mp: drop unused tdx easy installer ifdef
Thread-Index: AQHZ3zM0GsbS4EijnUG0vlqGgfmxwLAKq5UA
Date: Mon, 4 Sep 2023 13:37:49 +0000
Message-ID: <f91dc5d596263c4ed747e341295d549285728a09.camel@toradex.com>
References: <20230904132437.36435-1-hiagofranco@gmail.com>
In-Reply-To: <20230904132437.36435-1-hiagofranco@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0042:EE_
x-ms-office365-filtering-correlation-id: 4e42ee22-1e63-4f8f-82a4-08dbad4c218c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Eb3URLtmmEXmGpDvapRCieMPPKxcfUug1e88ILBdcgRbMUwZ9XxbDELCkPwpfm1AvZ6M3bUzHJz/LgpYJX1gZj41usYjZgczpwKvqgBA3NNK2YCXedXXhatpryBdQJgBnQh+QOIl9bXDswQUVdaloYUHwVjnMinVakJk3MTPq+OpH/ErPr4aqOydtlfE1k+IOPiLsgGvyxYaPeXEuw3yr+cUarXcZ8hEIbP2Jpy25vF/TFxBNnb/dogigTMZ2DJGSAtJrjuz0k2pDGvqRNP42U4Ik/gAfzE6YfnuxiaP6jtW+kTOoYNntkHZ4kXx9tZK3LyI46sAgF+2lVqOq6nhvuR9+vt4bF6HNT0pPnhpwjS4kcWDqFvd29pRmasSrkUFDuS6+V1sgP5HFzex2K+e/aZPOIPGsRdQM/54oJZV+yET1oNXRAQzvyyGzrJSZCLsD4qoypAXXCUFlMJYLk7gmLUA6ogFureX9NGv0p1jgJ5mcAk93pczGE2/+nCce5gDgnP9rLUvsMmVlp+0lWAfZErEkUDOFfPnCwHr0cfZRHquFp+yLSGACaySwcFVziBTLUI2UfOlN0Wjomf4ACqJ25me0FIJkDcNdRcMVvV7GBN3wW7YAqtg11YM6UZrcYw1kdPcJ1+ZhhvgqkDl6ao4sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(396003)(366004)(136003)(376002)(346002)(451199024)(186009)(1800799009)(66556008)(6916009)(66476007)(66446008)(316002)(64756008)(36756003)(2906002)(86362001)(76116006)(54906003)(66946007)(8936002)(5660300002)(44832011)(8676002)(4326008)(41300700001)(107886003)(6512007)(2616005)(38100700002)(38070700005)(83380400001)(478600001)(122000001)(6506007)(6486002)(71200400001)(139555002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNFRFF0ZVE5dVViekNpZFZxSS9lNmdJV3NBN1JlZHZoUVIwSE56cjNFc1BB?=
 =?utf-8?B?UU5aQ3AwWVJXYnR4RlRXMzJoTzZzZWsyNUo2RFV2b2FybkxGUllGcWRZUm1n?=
 =?utf-8?B?UGFOS2U0T29UU0l1MmV0MlFzMGl3VTlFajBJcFp5MFozZmM0azUwRC8wdnp5?=
 =?utf-8?B?R29GTlhIRk9HRjNndDQ2VkE1clM5RmozMUtJNHdIbmJTeGFnR0hxc2IwNnMw?=
 =?utf-8?B?dFdmdnR4OSsyRTZPZGNNY3R6UVJldmRqMVNhNng4b0pzY0g4M3U2YnY0amxp?=
 =?utf-8?B?VGFDSURpQWh6dGliRXZRcnpUbkRNVUMxZmJxczZUTjVTN3lwRDBlM3hORjZn?=
 =?utf-8?B?RWNCRk01Zk83a2Y4V240cGhaWHVvR2hkc3FWZHFiYWJQL3pnNmxDM3RXNGtm?=
 =?utf-8?B?cjc4N1krUnNCY2JpcGozQU8xSWtvKzFpeTVEMUhGRlpSaWhQakNhOVZrYkNz?=
 =?utf-8?B?U2xWYjBOUUFpdkNqVlpQODJxeG9iR1I4MUNHSGtkMlltVU5BTDZGakhZZStT?=
 =?utf-8?B?Z0haa01BcjFQRXlWaW5maUp6VFVBNVM4QU9LR1c0ZkJxakJvYkZsNEFYcW1o?=
 =?utf-8?B?Z0d4TjQ0QWVKaGtSVmY5aXVEQXlCeThrWVVXQTlielU1eUpZY2pqVUVrcmVt?=
 =?utf-8?B?NldHZ1Vvc0xZM2F1ZmVSQm0vQXZldGl0Q1pic1pEaVRmL3hOeUk1c2VvWkJJ?=
 =?utf-8?B?UHU1a1A5bzNycHYyUGZNOWk5VzdKVDZiYVFKK1lYYjBqOUUwOTY4WXYwbHdp?=
 =?utf-8?B?Tzc0c2QybHVVaGYxUENNclh5eHVlKzRndkpxQlBYeFB5RS9LaHY5WDB0N3Qx?=
 =?utf-8?B?UzUvYUhvK2ZPeVF2SHJwWEhwNEY4TkROdW1EbFgzRThoczdjR2psMTJqckdu?=
 =?utf-8?B?eEl5SDVLMHhwNnp5N2E1d0NNV1F3cDlOcHJCRXVjRHB5bmh6MlJaL1RCWGR4?=
 =?utf-8?B?VTlSSkxleWZmZzRsVE5ySW8zdmNLbWVVUERsVUhpQmJHaUdVUDhnY1NTZXJt?=
 =?utf-8?B?ckY3Ynp5QzcrbHZSVHJuOExMYXNnb0hvRHJUMjFySWpDdkNCa0o3cWkzZktJ?=
 =?utf-8?B?dmxVNi9rQ0lrK2krdlNPLzdSaEhMR3RSQ1BlVU11TFF5UjFQL0M0ZklJakRO?=
 =?utf-8?B?dXRFd3F6eGlqUlRJZjVrcnBoQXBwSHU3c1hjTGZkbjVIWlM3RVQ3QlhoSmU4?=
 =?utf-8?B?YWppS0g1dmVOYjJTQUlpR0grMUI5Wmw2dzh4SmpBWVowU0hqWXZ0ajZvVnhC?=
 =?utf-8?B?czlxbkVUWnIyVFBtLzlvb2xjUjJBSlYxampQaE1FWXlIYXROZjBsN3NYQnRT?=
 =?utf-8?B?Rk55M2RlWnBaZDBlYnl3WWZEQkNYcnc0djRDbDRCN3BKVld1TXlzeEVrVlVv?=
 =?utf-8?B?TW5lakpzdjFIMGtJaFBESHBUam5VNWpiaUpNci92eUk5NFFOc05Jb3JHZTB0?=
 =?utf-8?B?OU9ZZ2E1V1R1MTNyYzkvdmhDUVExbDZ4bXRsbFRJNDVCdDFJbGlTbFQrNGs4?=
 =?utf-8?B?d0Zoc1duOElLOVUvM2FkL21LMlhrR0pTRDBML1FrRjBjK0FLQnBOSWVzSjZS?=
 =?utf-8?B?cDFuNk5DNDZNWmxmckJzVXR4RmpuS21sdnlla1BIMXc3aHErcmZOL05aeDVO?=
 =?utf-8?B?YU9iUXQ0RjZQck9zS3FaQnBXR2NJdTR6MStySlVDM0txcGltZHhyMDBjWEt0?=
 =?utf-8?B?WWdtWHRzZ0dlOFNPM1hySnAxaUtFaXRpbUJURzZRSmtuWUVaTkp0bEo1U2hG?=
 =?utf-8?B?aEtPdEZlb2trYksrRERhMGJOeUlDMlBVZWZoeEdEN1hSTytwL1R1UE0vd3VQ?=
 =?utf-8?B?SzZ5eE5SK1h1SG5BajYwU1hZaEg3RWxESURYMmsxQkNsVS9aUFk4YlpjWklR?=
 =?utf-8?B?aEZtS2FaWlNFc0NZeVdrSXg1eUxmVEpETnRGc09EdmRNb3N1RUVseVNJYXdm?=
 =?utf-8?B?dll4cVg4TU45QTI4d3B0M3BoNjdlN2xtbjBmTnVtQjlZa0FrRkZNUmsyTTBN?=
 =?utf-8?B?Nkk4OEhYYWVyM0dlQWdnODFGYWxkT1RtK2JHRnVVM1ltem9sdWltQ1hQRnU5?=
 =?utf-8?B?bU9BbmhXZnV2L3VnUDF2Z2wwNHRSZ3JSWjAxQTAzVCsrSUxjWG9TR01WbzBj?=
 =?utf-8?B?V0NyOTFrQ0JJaENJWlMxWXVORitqK2lWTmc5UkFraXJkdXQ2UnNiQXJsNzAv?=
 =?utf-8?Q?JjgDyEMATlHM76cc5j9sogM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e42ee22-1e63-4f8f-82a4-08dbad4c218c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 13:37:49.4822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vKdkouBSRpMOqCQmTEFKwWVJA2Q5mosNtTVreWp9MtozID58wyhDjTQ9BhR0F12d/XRXS6SgpT5caBZq1nqBED6aW+fDm/R1gY0WDt30C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0042
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <CEF9D1CB69AB5E4B8D2D09B5CEA51AE6@CHEP278.PROD.OUTLOOK.COM>
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

SGkgSGlhZ28NCg0KVGhhbmtzIQ0KDQpPbiBNb24sIDIwMjMtMDktMDQgYXQgMTA6MjQgLTAzMDAs
IEhpYWdvIERlIEZyYW5jbyB3cm90ZToNCj4gRnJvbTogSGlhZ28gRGUgRnJhbmNvIDxoaWFnby5m
cmFuY29AdG9yYWRleC5jb20+DQo+IA0KPiBEcm9wIHVudXNlZCBjb2RlIHJlbGF0ZWQgdG8gQ09O
RklHX1REWF9FQVNZX0lOU1RBTExFUiwgdGhhdCBleGlzdGVkIG9ubHkgb24NCj4gdG9yYWRleCBk
b3duc3RyZWFtIGJyYW5jaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhpYWdvIERlIEZyYW5jbyA8
aGlhZ28uZnJhbmNvQHRvcmFkZXguY29tPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxt
YXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IMKgaW5jbHVkZS9jb25maWdz
L3ZlcmRpbi1pbXg4bXAuaCB8IDEwICsrLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
Y29uZmlncy92ZXJkaW4taW14OG1wLmggYi9pbmNsdWRlL2NvbmZpZ3MvdmVyZGluLWlteDhtcC5o
DQo+IGluZGV4IDk0MjA4MWFiODQuLmQ5ODBiZDY2YWUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
Y29uZmlncy92ZXJkaW4taW14OG1wLmgNCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL3ZlcmRpbi1p
bXg4bXAuaA0KPiBAQCAtMzYsMjAgKzM2LDE0IEBADQo+IMKgwqDCoMKgwqDCoMKgwqBmdW5jKERI
Q1AsIGRoY3AsIG5hKQ0KPiDCoCNpbmNsdWRlIDxjb25maWdfZGlzdHJvX2Jvb3RjbWQuaD4NCj4g
wqANCj4gLSNpZiBkZWZpbmVkKENPTkZJR19URFhfRUFTWV9JTlNUQUxMRVIpDQo+IC0jwqAgZGVm
aW5lIEJPT1RfU0NSSVBUwqDCoCJib290LXRlemkuc2NyIg0KPiAtI2Vsc2UNCj4gLSPCoCBkZWZp
bmUgQk9PVF9TQ1JJUFTCoMKgImJvb3Quc2NyIg0KPiAtI2VuZGlmDQo+IC0NCj4gwqAvKiBJbml0
aWFsIGVudmlyb25tZW50IHZhcmlhYmxlcyAqLw0KPiDCoCNkZWZpbmUgQ0ZHX0VYVFJBX0VOVl9T
RVRUSU5HUyBcDQo+IMKgwqDCoMKgwqDCoMKgwqBCT09URU5WIFwNCj4gwqDCoMKgwqDCoMKgwqDC
oE1FTV9MQVlPVVRfRU5WX1NFVFRJTkdTIFwNCj4gwqDCoMKgwqDCoMKgwqDCoCJib290Y21kX21m
Zz1mYXN0Ym9vdCAwXDAiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoCJib290X2ZpbGU9SW1hZ2VcMCIg
XA0KPiAtwqDCoMKgwqDCoMKgwqAiYm9vdF9zY3JpcHRzPSIgQk9PVF9TQ1JJUFQgIlwwIiBcDQo+
IC3CoMKgwqDCoMKgwqDCoCJib290X3NjcmlwdF9kaGNwPSIgQk9PVF9TQ1JJUFQgIlwwIiBcDQo+
ICvCoMKgwqDCoMKgwqDCoCJib290X3NjcmlwdHM9Ym9vdC5zY3JcMCIgXA0KPiArwqDCoMKgwqDC
oMKgwqAiYm9vdF9zY3JpcHRfZGhjcD1ib290LnNjclwwIiBcDQo+IMKgwqDCoMKgwqDCoMKgwqAi
Y29uc29sZT10dHlteGMyXDAiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoCJmZHRfYm9hcmQ9ZGV2XDAi
IFwNCj4gwqDCoMKgwqDCoMKgwqDCoCJpbml0cmRfYWRkcj0weDQzODAwMDAwXDAiIFwNCg0KQ2hl
ZXJzDQoNCk1hcmNlbA0K

