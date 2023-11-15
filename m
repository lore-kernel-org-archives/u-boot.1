Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62ACC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2548718B;
	Wed, 15 Nov 2023 18:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="O/vVOCEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94079871CD; Wed, 15 Nov 2023 18:30:47 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1758704F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1700069445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mjk5/yYIYr3w4o0+5Ap31UFAkxsFL4sEcpPiTY73xK0=;
 b=O/vVOCEYbZib0WMVQ8ksJsHg3bebSdmD6QjH5kap6Vh1aQ4D1/69oX5Hk19kiwohaRvxgh
 NrkWn9L5OSy6Bho4n7U4KfwVFK38CJl6qCZQHQMcDE+2Vvx/EtcTuAzT7hHloxd2LKfZag
 KsGPB3T5Xcg+rZBJB7GzvNyQqVyrK7I=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-62-d7khjpImOruWVYCZU9FYZw-1; Wed, 15 Nov 2023 18:30:42 +0100
X-MC-Unique: d7khjpImOruWVYCZU9FYZw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0880.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20; Wed, 15 Nov 2023 17:30:41 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 17:30:41 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "nm@ti.com" <nm@ti.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "r-gunasekaran@ti.com"
 <r-gunasekaran@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com"
 <srk@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA
 with BCDMA
Thread-Topic: [PATCH] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA
 with BCDMA
Thread-Index: AQHaFzk6WumY0FGV8E+94XdZ+dB5tLB7pHUA
Date: Wed, 15 Nov 2023 17:30:41 +0000
Message-ID: <926a9c3c2e9fc636afd66a08e2f03d2f235f08ec.camel@toradex.com>
References: <20231114202856.39072-1-rogerq@kernel.org>
In-Reply-To: <20231114202856.39072-1-rogerq@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0880:EE_
x-ms-office365-filtering-correlation-id: 54c09605-5281-4b12-40a2-08dbe60096fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 42yVqUxemjx015mM0q8zvTxWjT5A0IBFDV1qmVu2jMY9L/SahOX1Ljk85AUi9xR1DzVwuQrnM3Jep3F7251ZD43QRiHYuuDsNcuHr8QQ/NGH+Iykcw+JrWv1FLJJlpXrR8rLnwojutF/0/NQVzNoVqLegcwB60n42vHTOsMaG6ZZ5n6xAw4m+xyGfdHxoallVP9U3RxFSnyzdZoxgpBnDVmjE5K6qasX71INxJhmU2oHTWXGqV58YrlEW16squrHQ7GUo1mNe29yAGaOgLHNugn3713h26fbRRB/I/YVc0p+WEWfLADH2rpYLgYG6x6Md9p2LnWeKeug3p3TDA7r7iSO8hILq9kNK6PjZOmhIDh3FJWRSVI9pOOhwFmXnQkKGC83bKlQd1kqhEr37IBgW5YwD3MatOMvlKVRG3oGEssLyzNgU+k57T4o1AzsQscZ8/f4UhjePLuY3e0EqoWSYFDfmKBv4EPTpT7ncDsK9LEtXyrhR11rKTnozCd5Cxw+CPHCK5YnnX60w/7nUgdLVXc+qFF4MvsFE9Jc2A3ioc0vu8Z+zJwJDfHXTTyawgwSARqR/9EY3ntQghfOXlxZcdzrPhE9EaVPy9/vvrZJGful5LLH3t2v9QIkKzL6p4z+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(2906002)(2616005)(36756003)(4326008)(8936002)(8676002)(76116006)(6486002)(478600001)(4001150100001)(86362001)(316002)(5660300002)(66946007)(66446008)(110136005)(64756008)(66476007)(66556008)(54906003)(122000001)(38070700009)(38100700002)(71200400001)(6512007)(41300700001)(6506007);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVlaYlVCZUQ2cFVtRWZDNFVHZ1VyTW9aRkVOb1p2UU5XdFZDUWZNcWkxSGU3?=
 =?utf-8?B?N1FZU2tjNE9FalBoY2E1TUZ0WHl0WVZUUDQyK1h4YXUyT1ZrNWhEcTNYM0Fy?=
 =?utf-8?B?aFhPRVdzS0Y5WG03QTBEYmlZTU1TK1U5elYxMGVjMEpZYW1oOXBDMjI1TEtB?=
 =?utf-8?B?R1E2QkRlZ2FNWlVERklsM1d3SmdCQnRZM29qaFVQMEtlb0h6Q1hHbnBjb0w2?=
 =?utf-8?B?cWpmSjZZb0t4UFhRaTVza3NucDBJY3h5OG1tQmJJZ2NCOWljY255V3VoNUNT?=
 =?utf-8?B?VWRpRWFySHpqRXQ2V0hLRmRaaU9GNmJHbUdoM0RWeDM1cGYrQ3BmeXlyYzcv?=
 =?utf-8?B?K1paUWYwY1ZFWXdISkZlT0Y3TDNmSFgxK1FpMmVDcWVlZnYxQnpFOFc0WXpl?=
 =?utf-8?B?Z0R6N0swZ2dqcjI4cTFQTisvdkltbDJnUGlBdng1OGJTOGhtOGU0T0JiNDFw?=
 =?utf-8?B?WUJoWDZYREkxQjg1MC9KUmJVMHZNbURBTHNDL0xvWXRnRW02ZjB2dFdGTVFI?=
 =?utf-8?B?T1ovWXNYRzJSaFhsbFpNb1FLS0haNkVNVDQwbU92RmtyWTE2ZnJrREVVWTZJ?=
 =?utf-8?B?T2pIanJlbllCN21zdVUyeW5ESERQdlErSWFSemRKc25tZjFqMFRSTzBORFFx?=
 =?utf-8?B?TXhiRS96eUxJUW9IeU5MSXUrM203WHdpL1huZjdZUm9xNW8rczJoRmltTktU?=
 =?utf-8?B?SEllak1pVkVBbW1uSnNadXFPS2czV1hxQnFtTm5QSkx3Y0JCK1N2R1Bmck5j?=
 =?utf-8?B?cEJWMkZGNjZhSGphb2Z4NTUwa0JJdGdWb2VTckV6MG9JVnQzdVJhRDNSZHVM?=
 =?utf-8?B?dEowTGttVlRyemtBK3JhV1N1eklGWW9pY3FjVFVpbUJYblpaMEVtZGMxdFF6?=
 =?utf-8?B?UU1qRXgxbFprSDhIQ2xBRkFxZDBGRk9xQkRzRG5QSW5DaGl2MUhRTmxCYi95?=
 =?utf-8?B?MUY1YzVjcS9vRFk3dEY2UmxDU3NMWE1DRW9FcWp4Y1QwVEZwYkV2cWpXdUMw?=
 =?utf-8?B?bkZTcjVxczd3WmsrQ0w1R04vMlB3UzhpWHZKNEI0YlRRUXlTSG1YeCs2dVVl?=
 =?utf-8?B?aUlBOFI1UHVNTWFCYXR3VThmekRyYTV1VUh4N01WYTQ4RUxIRy93UWlnNGI1?=
 =?utf-8?B?MXYwMnBHaHVqd2VIcDcrWk5JM01JRkozNVpnTm1nTENMWEVYUm1iSXltcTB6?=
 =?utf-8?B?YWh6YXprWFE0ZDNkaGRWVnVRNEdFV3pOWTMrbi9lcVRVcWZwR1FhUEl4YVF5?=
 =?utf-8?B?c3lTQ3YrNjVDQWpSMXd1Nm5GeVBsV05FN1hTWjdva1pKTFlJUm5OYVIxQUZh?=
 =?utf-8?B?Wmc5V2hMeFJ6OVJPdjhUQjlTZ3orOGQ4amt3a3c1OW8xS1BJbHd4bHo1Q1h4?=
 =?utf-8?B?NThHbGFqNkk0ZDVscHg5aTZPRC9vVngwU0hQQmdwaGdaYTExZTAyVVZRSUZD?=
 =?utf-8?B?eEd6Qjh2Ym40VFVlck5zZTkreklkSC9NQXNzMjZoNkwxaCttR3RSVWdnd08z?=
 =?utf-8?B?bmM5VHVDendkU3Q2RWYvQmhGaFJ1U3JtNzVOQ0h5WlNHRkJlN2FKYlZia0xE?=
 =?utf-8?B?eXdUWk5mVUh5WERmR003TjVBbjZxMmV5M2lpZDl1bThUODRFcHB4c0cyTmZx?=
 =?utf-8?B?VHRRK1pHNHBRZ3Q1QXFwUVl3QXNHMHpncG1FVEpXYUxlbVlCNGU2MktzOXYv?=
 =?utf-8?B?OUhrakJKUUpGN1NGY1VWQkVLRmdXSWxjelAyVTNoUERiSjFERVRzOEd4bDdX?=
 =?utf-8?B?bVppcWRJNVk1S0xIZnNTdUdtc2dQaWVXdFFtNzdGNUxpNmF5OThlZTVnVW9X?=
 =?utf-8?B?eWNKK0VQY2FoamFxaCtpMVBySGU1NGVja1BwbGNYdjFveWIyYksyZG5SVkhl?=
 =?utf-8?B?MXFFUU9IR2ZxQWEwWUVWNTh0UE9IUUxRWmpLejZvN2pzdHdiZ1dVeG9rNXNI?=
 =?utf-8?B?ZzlTZzZZa3FwMHVEbmRFN1BsU0VNN2NxM2kxbzEveElXMHJPbVVZM0ZjQy9X?=
 =?utf-8?B?THp2c3VNdVlUOEtjejFiUFBpVWVMYjRwQ0FsZlVxT3lDMjFIS3ZGdXU1MXdL?=
 =?utf-8?B?UzhiVHVJVitaaU1qd0szNEtPNWVhL0xvN3lvMDluSXNMUERhOVJJWm9NWGVC?=
 =?utf-8?B?R0Q5QXRqc3YvTGJRTHF6bllXQWtwM2htSGVObVFPVVdjbzF5VVFvamk3b1Bk?=
 =?utf-8?Q?pqCK+FZtGiVs/vq4BgDe368=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c09605-5281-4b12-40a2-08dbe60096fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 17:30:41.0545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1p771KANItn6mAIitMJ1a6WNtsr9b0lA40PjoRVHimTYYzGdlSs0zDjrvawHIwR/Hsh0QYJ6HyffTAAN0ohNtEb1jybQPDNdv2ppJUNA9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0880
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <A1A1F14C89715D43B4C9B00169BE0FDA@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUm9nZXINCg0KT24gVHVlLCAyMDIzLTExLTE0IGF0IDIyOjI4ICswMjAwLCBSb2dlciBRdWFk
cm9zIHdyb3RlOg0KPiBCQ0RNQSBjYW4gYmUgdXNlZCBhdCBTUEwgZm9yIE9TUEkgYm9vdCBhbmQg
bWVtLXRvLW1lbSBETUENCj4gc28gYWRkICJib290cGgtYWxsIiB0byBCQ0RNQSBub2RlLg0KDQpN
aWdodCBub3QgYmUgc3RyaWN0bHkgcmVxdWlyZWQgKGF0IGxlYXN0IHdlIGRvIG5vdCBzdXBwb3J0
IE9TUEkgYm9vdCBvbiBvdXIgSFcpIGJ1dCBhbHNvIGRvZXMgbm90IGh1cnQuDQoNCj4gU3VnZ2Vz
dGVkLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KPiBGaXhlczogOWEzZjJiNjc5OGIw
ICgiYXJtOiBkdHM6IGszLWFtNjI1LXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzaTogRml4IERN
QS9FdGhlcm5ldCIpDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJu
ZWwub3JnPg0KDQpUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPg0KDQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lm
aS1kZXYtdS1ib290LmR0c2kgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvazMtYW02MjUtdmVyZGluLXdpZmkt
ZGV2LXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2szLWFtNjI1LXZlcmRpbi13aWZpLWRldi11
LQ0KPiBib290LmR0c2kNCj4gaW5kZXggNzVjYjYwYjU3ZC4uNTg4ZDk1OTRhOCAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vZHRzL2szLWFtNjI1LXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzaQ0K
PiArKysgYi9hcmNoL2FybS9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2LXUtYm9vdC5kdHNp
DQo+IEBAIC01Myw2ICs1Myw3IEBADQo+IMKgCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODRjMjAwMCAw
eDAwIDB4MjAwMD47DQo+IMKgCXJlZy1uYW1lcyA9ICJnY2ZnIiwgImJjaGFucnQiLCAicmNoYW5y
dCIsICJ0Y2hhbnJ0IiwNCj4gwqAJCcKgwqDCoCAicmluZ3J0IiAsICJjZmciLCAidGNoYW4iLCAi
cmNoYW4iOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmbWFpbl9wa3RkbWEg
ew0KPiANCj4gYmFzZS1jb21taXQ6IDkyYjI3NTI4ZDc3N2NlODUzNjJhZjQ1ZTdkMjk3NGE2Yzg1
NjIxOWINCg0KVGhhbmtzIQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

