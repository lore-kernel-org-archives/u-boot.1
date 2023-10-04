Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3437EE7B604
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B3F87112;
	Wed,  4 Oct 2023 14:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r8yB1w2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7CE874C0; Wed,  4 Oct 2023 14:56:27 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B60F86B58
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW11N0La3sPGpthlF0aIlKOTxWfdozDqRsMAfHBSBJUxodpewJJbEcHNs3y1LS/sF6lVlm4Oqjo7DuMNfFxL6j6TeaOO9EIo3Lp2bcKt9xRC+igmdVrVqOh0I00o8UrezxpJARff1hy/K9XtI+WRj0qguw+xa7ucrBA6IKXPXkinDjMtw4qfMuioK4ZJCpcKrun7ImSlnUzcAmiuulFLObisUxw18rKqryXfRpUKAZAJpP4qfDcj2dxEzseqJ03ywRIcjYT/dyIYl7Zv4i5IOrSnrHvr9BaeKRABkhT3rK3jrmaKLO40AVq9E66Qo/iuw6qCxFsr5jDRvyisSSsX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8RhRc4yM/DXEKKUYsCf7KuIB5NKUiMEZyXF0fZ6pcg=;
 b=LKqS1M3442JSPtHXdsjhcGJZNnPeTSuvpa8fkX7M+B0xb4g2othReK7XtcO8KwZNd6FxQggLnllEoCd1+gueJrGpRY5PaDGaEByjiXB3ZElJwyxRi9/2IQZi9ED+UbG5TUjgyz9XNbxwEMpCe0rRbplsab/wWgD2A1+8fHlVQOfVSBD10jT1ebUrMUGrQAz0MHr2g/ht4vcXCEFKYWyvfDBnwszM354YRfu7U5tU+JXgNola72Sfy7chUjdRafN5gOvIsk4aBHhbeTYstLHosO8ECeLNCrO3CTIOpWSULkv/HEpPg9W/LB6/Kg40mySEKj1irlN9KI86Li4XI1TOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8RhRc4yM/DXEKKUYsCf7KuIB5NKUiMEZyXF0fZ6pcg=;
 b=r8yB1w2PweXBPPr9Ip7Mxmtz7SQKF6InsAEFcAreppCIlOQlbGS8pSIipOAu5W+Vbqzndg08xdns3bQb5cHwsCGuUAPA5nHh0MtckRWmv9997PKKcsGVtz6heruNd2cwjqNUeL+ccKdCfo7QChuyuHltMEihJnMoS50cKlelZ2M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5309.jpnprd01.prod.outlook.com (2603:1096:404:8025::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 12:56:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 12:56:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham
 <hai.pham.ud@renesas.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Thread-Topic: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Thread-Index: AQHZ9p5/h6LDzDKBOkyAdtZ4sRQeXLA5jj4AgAAHUmA=
Date: Wed, 4 Oct 2023 12:56:14 +0000
Message-ID: <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
In-Reply-To: <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5309:EE_
x-ms-office365-filtering-correlation-id: 26248e72-c560-4e22-0dd5-08dbc4d94ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dV5xp9aLU/1wH5RHER0Ao3AbQLrl8jjV6xrC3JZm2k+RuzjqlAdKUVHSZV5DPrKU3BEVV195+2I7TfA+jqFq+ia/xzMphH9FH85l6udqErBqvxdK7RMbAYdp5RlQH3+dPgxI85ePFdkja0eWc3ZoSIMWOQuf+aajvNxbhGcjFcPkqoc7YX+ZyvgvVdRX61BJlSz8Ln89bVxnYGQ55JOWtj40mmk4E8WHIQ4osN3rk7xZayS+rBxU6EYxR1wAHzzSdotqXGDATJmSgTEGFXPgD/muPkAescnZxuhmf6y4nE826Y4++ZArJwbvdSUBe7nADcCX3cBO1+A++x3S3RKqYavCU/5/lLZ8lkKeMseBAryvCbls5yOkEbRhxsaNO0qBSs3fH0NqIkDS1Kfak3HpLvgdldv3Gxlet2ExPLvdj6/o9KhbyDt9uMt5Fd88PjrjvgDyNVnBPdW3dYzdJUs/jylGDrbQv0PNgTjW7V5au6mLXIltOYYPJbDsLU+y8ug2Qpf7tTOA4pg6sQBfTm6zrQV/J8wiuv0ulK3I1NpFmcxiN8RxrZhLO5EB1J82ZAeVj0/lHYPXzmefQ7A52SiorNOSUbo/tmKsYAwNMSd39vxn6Ymnrj+BiF9Y7kDuK/sncdxQIUYjoDjteBuro8UoGBGkJfmmJl7APVJiJGfkw6E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5922.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(7696005)(71200400001)(53546011)(478600001)(83380400001)(26005)(110136005)(107886003)(9686003)(41300700001)(76116006)(66946007)(66476007)(66556008)(5660300002)(8936002)(4326008)(52536014)(316002)(8676002)(33656002)(66446008)(64756008)(2906002)(86362001)(38070700005)(38100700002)(122000001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ZKWEswWnJKak1wa3B0Vlk4bEsxR2xLLzlJQXp1ejRmSDc4aWJYbWZkZzU2?=
 =?utf-8?B?UWlYcVE4OHZSSFRMeE4wbENwcnY5OWdCcEJtaC9YQ3NONi9zL3ZKejJsTy9U?=
 =?utf-8?B?ME8vMmE1K2JjT3RxWi9Gd1BxUUxoRjdoT0VIWkErYW1leXcrT2E2ZlVkMGFG?=
 =?utf-8?B?akhBK0w3aVY0NjAyNWVqRnAyMTJyOUdINkxDaG0vUzUvUDRQdDd5WTU5cmR4?=
 =?utf-8?B?Rkl5RXNUR3JCVzdrUmJtcVNPdTBPdkR2Qk95c0FSNTk1ZXY2bEZzVkpET2NK?=
 =?utf-8?B?RW8yMVVscjh3OHZMR1hrUFZnYm5zZk5GcUxMZlRvSTl1ellaYkJ3a3pLMHVh?=
 =?utf-8?B?T1cwSVA4RWlyQlFaTzYyRU9qWTg2OEJzTERTb2wrd3ljYlpyTk1NUy9FZkIv?=
 =?utf-8?B?dXRjbXBTaGtpRml6Z0xMWE9yTkpWNk40b3ZGS3FhaXozU3Q5M0diRURDZHBJ?=
 =?utf-8?B?aTc3Y0hiMW9wV0ZlN0dxT2d1VnhlaUtxc1JabldvRDFPaWN1V3h0MG9NVkls?=
 =?utf-8?B?WER4Zlh2WStqUXI5eE5YYzI2TE84WThnQkpVaUNHV3U3aUNaRU1GTHBZYjMx?=
 =?utf-8?B?NWJjN1BETUZna2NrRlYwejlFb0ZCYXRxY1RuWHIrZFZqRi9vMXVsYUs1cVlm?=
 =?utf-8?B?UzdIVFV3NTZrMjVwcTVNd081RWNCUEFJMldLWVlsTERXaXE2MjBwNHFERUZ4?=
 =?utf-8?B?aVIxMXB0MklpZ1V4YklQZFJCb0RBdFc4YVpLODYvaXZ6SDdvbHN0dXdRZTd5?=
 =?utf-8?B?WmhzZCtuVHRxTm02NGhGSXJrVUNHQWxka29XVDIvaU02OWg2RUROeUYvdXFx?=
 =?utf-8?B?ZTNlbjhBN0JFTXlqbE0xUUZnZTVEeHEwU3hKRG84b1VkMDhyeTRqZ0FiOWNu?=
 =?utf-8?B?K0ZXK05aQXp1UDlwNWlsbE1DT2Q3MDFCbkdVNkxUSXBqLzJJWDErazYwS01V?=
 =?utf-8?B?N0FGdHhWUDI1TjVzeDByckt0NjVrTm1uZkRHenNIeCtsQkE3TFlhS3hrdW92?=
 =?utf-8?B?N04yMjMveVgwL2hpQkM1ZExDNUcyUnZjNG9EWUNHcnAyWk9iZEw4eUNtQ0hS?=
 =?utf-8?B?YTJTTHdNNkhuellRYkFiM3VSSEJCTDNqOWNtZThMT28yMkdvNjI2WVZYNGk0?=
 =?utf-8?B?NmZMY0JOWU51ZjgwN1JNaFBPcmN0SnJpdVQ2UWJ3a1JDRmpvWXFwQTVINVo4?=
 =?utf-8?B?aldXVnRqeDZLa3pST29zeHNuaGE0aWxwT1pEdTNNam8rMXdYV1pMa3VPclVF?=
 =?utf-8?B?UGo5ZnVKU1ZiQVJxcnhRUFltZHFBbDBuL0I1NWZIZ0JaMi9OcGxwLzBHV2ti?=
 =?utf-8?B?VXdMVTdreTRrNXJ6TDJreHVtQ29SOWNmQTMyT045Y3RUM3ZTby9PbGxjbVhY?=
 =?utf-8?B?cjZrQU9FbkVKTFdEb3RnbUh0TDlQR2lLb0ZLYm5ZR1Q4QzcvcEZETkQxTm1D?=
 =?utf-8?B?T1FjOHkzcjJPcVBLQzYzZ0MwWlZROTVwc1RIQ0cxdVNWRGUxT3F2aFQ5Ty9o?=
 =?utf-8?B?RitQbEJ6Z2RwdmhRenRDRDYyZk93L2ZPeWx6Zk8yRm1vY0ZWSzhpWWFROVYw?=
 =?utf-8?B?c0pLcG5xaWdIdEtwMTAzaTFWckc2ejNtd21La0pSblorMUQrZXdJNzQ2MElB?=
 =?utf-8?B?MUJtSkIyeGVKL3dpQVJtWk52Qmx6OFR6YWo2TjVXd213YW54OVZrNzY2SkVK?=
 =?utf-8?B?RlE3M2s4MHd4a1dVQ0p2SytrWDkxUUxiUTVpb0RONDF1ZTQrWHBEQU03NVFT?=
 =?utf-8?B?c1hISWloeXErVEpobWNvUU5TcVpaRy9acFRDOWxjaW5WU21Bc0p6dnF4eXlL?=
 =?utf-8?B?N2ZBcWNOdHBrdVR1T2VGTTRlT0t3ampIOXRlbVhhMFlJMENVRzZMQmVTQ3lx?=
 =?utf-8?B?MFNzdHRneHYzeGFwWC83MUcvTUtGWGRPdU03Q0FHckJBWUpJSENHVHNVK1Z6?=
 =?utf-8?B?QkRVYk9vVzVRdEt1cWZNSzZTdEhBYTZIUTE1REwzTXBwVk1uRHF3TW0rNnRI?=
 =?utf-8?B?ZlFPMXdGL3o1cHQ1WUJGaVpKUDRJOWFQYlNmSnZkeThZTWRVdTZ1YTRzakFT?=
 =?utf-8?B?TlJnRm8wQW4remtYeGdvZUJFUzREcHBQR0ltTHo1NDJZelBPdStXeTB5ZG1l?=
 =?utf-8?B?ODRKaUhEelp5c2Z3amFVODBaQlJhODdHTmF4R2VteC9qSEZ2YXlhK0tjWEZC?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26248e72-c560-4e22-0dd5-08dbc4d94ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:56:14.4311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eb68b/LRJWKVH9op1AV9GXmBhfIMIloDkKYW6BcD1sl2lJDJyMG1A+AsREQm00DcG2jl0y++m+3TPzahX8jVq0AThYx+mO+IeYQwfwo0OS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5309
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

SGkgTWFyZWsgYW5kIFBhdWwsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwOS8xNl0gcGluY3Ry
bDogcmVuZXNhczogQWRkIFJaL0cyTCBQRkMgZHJpdmVyDQo+IA0KPiBPbiAxMC80LzIzIDEwOjQw
LCBQYXVsIEJhcmtlciB3cm90ZToNCj4gPiBPbiAwMy8xMC8yMDIzIDE0OjIwLCBNYXJlayBWYXN1
dCB3cm90ZToNCj4gPj4gT24gOS8yMC8yMyAxNDo0MiwgUGF1bCBCYXJrZXIgd3JvdGU6DQo+ID4+
PiBUaGlzIGRyaXZlciBwcm92aWRlcyBwaW5jdHJsIGFuZCBncGlvIGNvbnRyb2wgZm9yIHRoZSBS
ZW5lc2FzIFJaL0cyTA0KPiA+Pj4gKFI5QTA3RzA0NCkgU29DLg0KPiA+Pj4NCj4gPj4+IFRoaXMg
cGF0Y2ggaXMgYmFzZWQgb24gdGhlIGNvcnJlc3BvbmRpbmcgTGludXggdjYuNSBkcml2ZXIuDQo+
ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUGF1bCBCYXJrZXIgPHBhdWwuYmFya2VyLmN0QGJw
LnJlbmVzYXMuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4NCj4gPj4+IFJldmlld2VkLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFr
YXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGFy
Y2gvYXJtL21hY2gtcm1vYmlsZS9LY29uZmlnICAgICAgIHwgICAxICsNCj4gPj4+ICAgIGRyaXZl
cnMvcGluY3RybC9yZW5lc2FzL0tjb25maWcgICAgIHwgICA5ICsNCj4gPj4+ICAgIGRyaXZlcnMv
cGluY3RybC9yZW5lc2FzL01ha2VmaWxlICAgIHwgICAxICsNCj4gPj4+ICAgIGRyaXZlcnMvcGlu
Y3RybC9yZW5lc2FzL3J6ZzJsLXBmYy5jIHwgOTA2DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPj4+ICAgIDQgZmlsZXMgY2hhbmdlZCwgOTE3IGluc2VydGlvbnMoKykNCj4gPj4+
ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9yemcybC1wZmMu
Yw0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXJtb2JpbGUvS2NvbmZp
Zw0KPiA+Pj4gYi9hcmNoL2FybS9tYWNoLXJtb2JpbGUvS2NvbmZpZyBpbmRleCA5MWY1NDRjNzgz
MzcuLjk3M2U4NGZjZjdiYQ0KPiA+Pj4gMTAwNjQ0DQo+ID4+PiAtLS0gYS9hcmNoL2FybS9tYWNo
LXJtb2JpbGUvS2NvbmZpZw0KPiA+Pj4gKysrIGIvYXJjaC9hcm0vbWFjaC1ybW9iaWxlL0tjb25m
aWcNCj4gPj4+IEBAIC03Niw2ICs3Niw3IEBAIGNvbmZpZyBSWkcyTA0KPiA+Pj4gICAgCWltcGx5
IFNZU19NQUxMT0NfRg0KPiA+Pj4gICAgCWltcGx5IFJFTkVTQVNfU0RISQ0KPiA+Pj4gICAgCWlt
cGx5IENMS19SWkcyTA0KPiA+Pj4gKwlpbXBseSBQSU5DVFJMX1JaRzJMDQo+ID4+DQo+ID4+IEtl
ZXAgdGhlIGxpc3Qgc29ydGVkDQo+ID4+DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4+IERyb3AgdGhl
IHBhcmVudGhlc2lzIGFyb3VuZCB2YWx1ZXMgcGxlYXNlLCBmaXggZ2xvYmFsbHkgYW5kIGluIG90
aGVyDQo+ID4+IHBhdGNoZXMgdG9vLg0KPiA+Pg0KPiA+Pj4gKyNkZWZpbmUgUFdQUgkJCSgweDMw
MTQpDQo+ID4+PiArI2RlZmluZSBTRF9DSChuKQkJKDB4MzAwMCArIChuKSAqIDQpDQo+ID4+PiAr
I2RlZmluZSBRU1BJCQkJKDB4MzAwOCkNCj4gPj4+ICsNCj4gPj4+ICsjZGVmaW5lIFBWRERfMTgw
MAkJMQkvKiBJL08gZG9tYWluIHZvbHRhZ2UgPD0gMS44ViAqLw0KPiA+Pj4gKyNkZWZpbmUgUFZE
RF8zMzAwCQkwCS8qIEkvTyBkb21haW4gdm9sdGFnZSA+PSAzLjNWICovDQo+ID4+PiArDQo+ID4+
PiArI2RlZmluZSBQV1BSX0IwV0kJCUJJVCg3KQkvKiBCaXQgV3JpdGUgRGlzYWJsZSAqLw0KPiA+
Pj4gKyNkZWZpbmUgUFdQUl9QRkNXRQkJQklUKDYpCS8qIFBGQyBSZWdpc3RlciBXcml0ZSBFbmFi
bGUgKi8NCj4gPj4+ICsNCj4gPj4+ICsjZGVmaW5lIFBNX01BU0sJCQkweDAzDQo+ID4+PiArI2Rl
ZmluZSBQVkREX01BU0sJCTB4MDENCj4gPj4+ICsjZGVmaW5lIFBGQ19NQVNLCQkweDA3DQo+ID4+
PiArI2RlZmluZSBJRU5fTUFTSwkJMHgwMQ0KPiA+Pj4gKyNkZWZpbmUgSU9MSF9NQVNLCQkweDAz
DQo+ID4+PiArDQo+ID4+PiArI2RlZmluZSBQTV9ISUdIX1oJCTB4MA0KPiA+Pj4gKyNkZWZpbmUg
UE1fSU5QVVQJCTB4MQ0KPiA+Pj4gKyNkZWZpbmUgUE1fT1VUUFVUCQkweDINCj4gPj4+ICsjZGVm
aW5lIFBNX09VVFBVVF9JRU4JCTB4Mw0KPiA+Pj4gKw0KPiA+Pj4gK3N0cnVjdCByemcybF9wZmNf
ZHJpdmVyX2RhdGEgew0KPiA+Pj4gKwl1aW50IG51bV9kZWRpY2F0ZWRfcGluczsNCj4gPj4+ICsJ
dWludCBudW1fcG9ydHM7DQo+ID4+PiArCWNvbnN0IHUzMiAqZ3Bpb19jb25maWdzOw0KPiA+Pj4g
K307DQo+ID4+PiArDQo+ID4+PiArc3RydWN0IHJ6ZzJsX3BmY19kYXRhIHsNCj4gPj4+ICsJdm9p
ZCBfX2lvbWVtICpiYXNlOw0KPiA+Pj4gKwl1aW50IG51bV9kZWRpY2F0ZWRfcGluczsNCj4gPj4+
ICsJdWludCBudW1fcG9ydHM7DQo+ID4+PiArCXVpbnQgbnVtX3BpbnM7DQo+ID4+PiArCWNvbnN0
IHUzMiAqZ3Bpb19jb25maWdzOw0KPiA+Pj4gKwlib29sIHBmY19lbmFibGVkOw0KPiA+Pj4gK307
DQo+ID4+PiArDQo+ID4+PiArc3RydWN0IHJ6ZzJsX2RlZGljYXRlZF9jb25maWdzIHsNCj4gPj4+
ICsJY29uc3QgY2hhciAqbmFtZTsNCj4gPj4+ICsJdTMyIGNvbmZpZzsNCj4gPj4+ICt9Ow0KPiA+
Pj4gKw0KPiA+Pj4gKy8qDQo+ID4+PiArICogV2UgbmVlZCB0byBlbnN1cmUgdGhhdCB0aGUgbW9k
dWxlIGNsb2NrIGlzIGVuYWJsZWQgYW5kIGFsbA0KPiA+Pj4gK3Jlc2V0cyBhcmUNCj4gPj4+ICsg
KiBkZS1hc3NlcnRlZCBiZWZvcmUgdXNpbmcgZWl0aGVyIHRoZSBncGlvIG9yIHBpbmN0cmwNCj4g
Pj4+ICtmdW5jdGlvbmFsaXR5LiBFcnJvcg0KPiA+Pj4gKyAqIGhhbmRsaW5nIGNhbiBiZSBxdWl0
ZSBzaW1wbGUgaGVyZSBhcyBpZiB0aGUgUEZDIGNhbm5vdCBiZQ0KPiA+Pj4gK2VuYWJsZWQgdGhl
biB3ZQ0KPiA+Pj4gKyAqIHdpbGwgbm90IGJlIGFibGUgdG8gcHJvZ3Jlc3Mgd2l0aCB0aGUgYm9v
dCBhbnl3YXkuDQo+ID4+PiArICovDQo+ID4+PiArc3RhdGljIGludCByemcybF9wZmNfZW5hYmxl
KHN0cnVjdCB1ZGV2aWNlICpkZXYpIHsNCj4gPj4+ICsJc3RydWN0IHJ6ZzJsX3BmY19kYXRhICpk
YXRhID0NCj4gPj4+ICsJCShzdHJ1Y3QgcnpnMmxfcGZjX2RhdGEgKilkZXZfZ2V0X2RyaXZlcl9k
YXRhKGRldik7DQo+ID4+PiArCXN0cnVjdCByZXNldF9jdGxfYnVsayByc3RzOw0KPiA+Pj4gKwlz
dHJ1Y3QgY2xrIGNsazsNCj4gPj4+ICsJaW50IHJldDsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKGRh
dGEtPnBmY19lbmFibGVkKQ0KPiA+Pg0KPiA+PiBXaGVuIGRvZXMgdGhpcyBnZXQgdHJpZ2dlcmVk
ID8NCj4gPg0KPiA+IFRoaXMgaXMgaW5pdGlhbGlzZWQgdG8gZmFsc2UgaW4gcnpnMmxfcGZjX2Jp
bmQoKSwgdGhlbiB0aGlzIGZ1bmN0aW9uDQo+ID4gcnpnMmxfcGZjX2VuYWJsZSgpIHNldHMgaXQg
dG8gdHJ1ZSBiZWZvcmUgYSBzdWNjZXNzZnVsIHJldHVybi4gVGhlDQo+ID4gZWZmZWN0IGlzIHRo
YXQgdGhlIFBGQyBpcyBlbmFibGVkIGp1c3Qgb25jZSwgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRo
ZQ0KPiA+IHBpbmN0cmwgb3IgZ3BpbyBkcml2ZXIgaXMgcHJvYmVkIGZpcnN0Lg0KPiANCj4gV2h5
IHdvdWxkIGJlIGNhbGwgdG8gcnpnMmxfcGZjX2VuYWJsZSgpIGEgcHJvYmxlbSBpbiB0aGUgZmly
c3QgcGxhY2UgPw0KPiBJdCBqdXN0IGdyYWJzIGFuZCBlbmFibGVzIGNsb2NrIGFuZCB1bmdhdGVz
IHJlc2V0LCB0aGUgc2Vjb25kIHRpbWUgdGhpcyBpcw0KPiBjYWxsZWQgdGhlIGltcGFjdCBvbiBo
YXJ3YXJlIHNob3VsZCBiZSBuby1vcCAsIHJpZ2h0ID8NCj4gDQo+ID4+PiArCQlyZXR1cm4gMDsN
Cj4gPj4NCj4gPj4gWy4uLl0NCj4gPj4NCj4gPj4+ICtzdGF0aWMgaW50IHJ6ZzJsX2dwaW9fc2V0
X3ZhbHVlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludA0KPiBvZmZzZXQsDQo+ID4+
PiArCQkJCWludCB2YWx1ZSkNCj4gPj4+ICt7DQo+ID4+PiArCXN0cnVjdCByemcybF9wZmNfZGF0
YSAqZGF0YSA9DQo+ID4+PiArCQkoc3RydWN0IHJ6ZzJsX3BmY19kYXRhICopZGV2X2dldF9kcml2
ZXJfZGF0YShkZXYpOw0KPiA+Pj4gKwl1MzIgcG9ydCA9IFJaRzJMX1BJTk1VWF9UT19QT1JUKG9m
ZnNldCk7DQo+ID4+PiArCXU4IHBpbiA9IFJaRzJMX1BJTk1VWF9UT19QSU4ob2Zmc2V0KTsNCj4g
Pj4NCj4gPj4gQSBsb3Qgb2YgdGhpcyBjYW4gYWxzbyBiZSBjb25zdA0KPiA+DQo+ID4gVGhpcyBp
cyBhbGlnbmVkIHdpdGggdGhlIExpbnV4IGRyaXZlciB0byBtYWtlIGl0IGVhc2llciB0byBwb3J0
IGFueQ0KPiA+IGZ1dHVyZSBmaXhlcyBhY3Jvc3MuDQo+IA0KPiBNYXliZSBzZW5kIHBhdGNoZXMg
dG8gR2VlcnQgYW5kIHNlZSB3aGF0IGhhcHBlbnMgPw0KPiANCj4gWy4uLl0NCj4gDQo+ID4+PiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwl1Y19wcml2LT5n
cGlvX2NvdW50ID0gYXJncy5hcmdzWzJdOw0KPiA+Pj4gKwlyZXR1cm4gcnpnMmxfcGZjX2VuYWJs
ZShkZXYpOw0KPiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4+ICtVX0JPT1RfRFJJVkVSKHJ6ZzJsX3Bm
Y19ncGlvKSA9IHsNCj4gPj4+ICsJLm5hbWUJCT0gInJ6ZzJsLXBmYy1ncGlvIiwNCj4gPj4+ICsJ
LmlkCQk9IFVDTEFTU19HUElPLA0KPiA+Pj4gKwkub3BzCQk9ICZyemcybF9ncGlvX29wcywNCj4g
Pj4+ICsJLnByb2JlCQk9IHJ6ZzJsX2dwaW9fcHJvYmUsDQo+ID4+PiArfTsNCj4gPj4NCj4gPj4g
Q2FuIHlvdSBwbGVhc2Ugc3BsaXQgdGhlIEdQSU8gYW5kIFBGQyBkcml2ZXJzIGludG8gc2VwYXJh
dGUgZmlsZXMgPw0KPiA+DQo+ID4gSSBhc3N1bWUgeW91IG1lYW4gZ3BpbyBhbmQgcGluY3RybCBo
ZXJlIC0gdGhlIFBGQyBoYW5kbGVzIGJvdGguIEkgY2FuDQo+ID4gbW92ZSB0aGUgZ3BpbyBkcml2
ZXIgb3V0IHRvIGRyaXZlcnMvZ3Bpby4NCj4gDQo+IFRoYW5rcy4gUi1DYXIgYWxyZWFkeSBkb2Vz
IGl0IHRoYXQgd2F5Lg0KDQpSQ2FyIGhhcyBzZXBhcmF0ZSBHUElPIGJsb2NrIGFuZCBQaW4gY29u
dHJvbCBibG9jaw0KU28gd2UgaGF2ZSBzZXBhcmF0ZSBkcml2ZXJzLg0KDQpPbiBSWi9HMkwgd2Ug
aGF2ZSBvbmx5IHBpbmN0cmwgYmxvY2ssIGllLCB0aGUgcmVhc29uIGl0IGlzDQppbnRlZ3JhdGVk
IGRyaXZlciBpbiBsaW51eC4NCg0KSWYgeW91IG1ha2Ugc2VwYXJhdGUgZHJpdmVyLCBob3cgZG8g
eW91IHBsYW4gdG8gc2hhcmUgcmVzb3VyY2VzIGluIHUtYm9vdC4gRm9yIGVnOiByZWdpc3Rlci9j
bG9jay9yZXNldD8/IA0KDQpDaGVlcnMsDQpCaWp1DQo=
