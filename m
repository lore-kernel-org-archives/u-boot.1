Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76959C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 08:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B178783E;
	Sat, 28 Oct 2023 10:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="qHjepOR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCAB8783F; Sat, 28 Oct 2023 10:13:17 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B10D87836
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 10:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698480794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xECYm03n5aDUsp/C1bOKLqu132kvTP4k/jSnchTQ+SI=;
 b=qHjepOR63nkbfAg6OOP2pxAYOgvXcgj7A20EYNu1yl86Nq70tLYY/e/gF5pM6mVYYR6Stq
 /RC5s5FF1VVNkRl+F3UnFghZr9tGyL+QuEukD+gxNSrP33rhQhseud2oRN/HDQ70B9bqbW
 0b/xNxbPnJskjRPJBOL165i70OwwYM4=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-62-i1ZHDGOlPEukhiQ0IpGX8w-2; Sat, 28 Oct 2023 10:13:13 +0200
X-MC-Unique: i1ZHDGOlPEukhiQ0IpGX8w-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB1154.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:55::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.23; Sat, 28 Oct 2023 08:13:12 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 08:13:11 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "r-gunasekaran@ti.com"
 <r-gunasekaran@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com"
 <srk@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix
 DMA/Ethernet
Thread-Topic: [PATCH 2/3] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix
 DMA/Ethernet
Thread-Index: AQHaCNwLkT4o2O1fiE2WZ8iY3rhl9LBe23UA
Date: Sat, 28 Oct 2023 08:13:11 +0000
Message-ID: <25150d3f75e03ed0c458c5ffd14980e51a71c829.camel@toradex.com>
References: <20231027134630.244886-1-rogerq@kernel.org>
 <20231027134630.244886-3-rogerq@kernel.org>
In-Reply-To: <20231027134630.244886-3-rogerq@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB1154:EE_
x-ms-office365-filtering-correlation-id: dea3f739-1a95-499e-8ad8-08dbd78dba56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: x0jrEpes/BIaz216N8LIHIM35Czz1MfqUiIIs/eHUtFei/jdWWdfjB8dUdPnaLlDgUq05YZ5KNGF4nAFIkaKJRJzokcQCAHkbYmvh+JXgOOgBaJuioQX/egvdavcruIMuZYBWcm735eJOxRuiaqdghzOmgtigDVYhfZqZVAQosZrc9j3ZwbsImjHH17/xhYDmQyUZz8zweYjW/1Udp2kref1Mv6uxzKmm0pOjZ1hYgSva7sdFklojz5ID2o338j1ftIDDXc9VBzlfjlpUCro0KVdT/M68m4IQv5YJwAcN3xEWjfsfB76+3jdb/DkPtIDPDHpEJW6y44vDHG6bG4fx1lTg0IDLCYSP5RgDPxIideWow1kWqmv9Op4NI19WRKKkHEQiSiezDIC6eFRe+7NzXF2IWZZBu31I9maFk5t8NMpYVlr1bGUVYdGsgqNCMx+7yG4VwHelKAbVHjWplsI8eHvm1HxDZBCz+4ud/XgnWlrZi5dKXhrsD+roSkQP8N6VGOqxMXUZXbDju6v4hgeOmbBeQUVAAJoD1qwk/KIrkwvI35eL1eMjtjt1hjUKadfVcCcFZxpGXQbN78GdpGQdFxByEDyJJDhSmXv9Y+CKKdwmXi5BcUhqLspWt+F+APo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39840400004)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(86362001)(8936002)(41300700001)(4326008)(8676002)(5660300002)(44832011)(2906002)(38100700002)(83380400001)(54906003)(64756008)(66446008)(76116006)(316002)(66946007)(4001150100001)(91956017)(66556008)(110136005)(66476007)(6486002)(122000001)(6506007)(71200400001)(478600001)(36756003)(38070700009)(2616005)(6512007)(26005);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZDbzlPYWdWeU1Ucm0vVmJza0xodWJnNlo5MHVuWUdhZ0FXbkNKb2dvM0o5?=
 =?utf-8?B?b3laS1VVekVnMjh4aWJNMzllUlRWaHdoYklWWjZ0T1YrenRGeVlKZWpaRVEz?=
 =?utf-8?B?R3BrMUNRMUkvRmFlUHBZQUhFenhaTjd3UXQrSlVqaWR5TUtvaWNGck1DS1Bk?=
 =?utf-8?B?dWFYOURXTGJyU2l6NW9JVXhYOWFWVlhGVjlUbU03eGoyYkZuTTFhcFhMUElJ?=
 =?utf-8?B?UVQ2dzNkY25HVHNqSkphZkFKazhCOFA1RGROcUhMcVRoZVg3WjF1NVhlR2Q3?=
 =?utf-8?B?dno2d0NRTCtzejVFWkJaWXA0NmRrVWxvVlplMm1NMDEzUHVoeUQ2NzR5Y0U4?=
 =?utf-8?B?cnViWDJJNXd6YjF5R1ZSM2tNck5wVWVmTlJ6VUZJODZod25ZOHZzSEtDbXF4?=
 =?utf-8?B?RG16enpNLzlQVTdqaUhtY0RYT1NLelRjTXNQQngya3NmUnJSaEZxYkRCWG44?=
 =?utf-8?B?ZDRCMld4T254akdCK2RoNDdOVTFuVkJqY3RXQy9vVStKSndZbm41NWpVZEJ3?=
 =?utf-8?B?L3dvU2dQRG1PTk1YR3hlYXlWUXlYVkpBa3c3U2Q3OENmQjB4RXNXblV1aGk0?=
 =?utf-8?B?ZHBQZGJ4UFoxc2Z4MFZQcURSaDhybXdsbHA3OE5pbWliUlp1bTkzNGVmM0NF?=
 =?utf-8?B?bVNMMUFsVkFKVjF2emx5aHFsaGordDN0WmMwM1Uxbjk4T0RGVXB0WW9vWVBH?=
 =?utf-8?B?aSt3bDdMSS9BOHlNQ2FDZTNHMFRLN3ljWUFNaCtmaE42WXRyeE5wK0NoUG1L?=
 =?utf-8?B?aUpHRWJBZzRkRmloZGFxZ3lsMGZLbW9PQXRiSGxPOS81Ui94VGoweXo3QWpI?=
 =?utf-8?B?Y1hTUSthYzdzcldkMGpySDIydUQ0ZHJTbWxiSStvNDFnekw0VmRMK3lOcWJU?=
 =?utf-8?B?S1h1czdzT01FODlFeTJHUnRwZ0NaQnl5S3JhZ2pOdnJmaDUzbk52UkV2cmNC?=
 =?utf-8?B?SUIrQS9yK1crZjkxaHd1VDRwWWFwL0pmblRqRUNCMjc3a3UvSCtiN0pxREtZ?=
 =?utf-8?B?L09vNDJPeEFDd0xxQTFNSXMweXBMVEJKNVhvSGxtVjdXTDluVnNnQnVKdmZv?=
 =?utf-8?B?KzlXSGRZbXVodnY1NVBtUTA5UUdYaWZjM1VJZVg1eUNRcEdoY3ZOOFZWNnNq?=
 =?utf-8?B?THhjUkdqa3pidTN1TmVBRS90SUdGaTVsOEk1TUdUWTVncFBPTngxdjlPTk9V?=
 =?utf-8?B?Q0dUaVdVRXdnMlRERzJWeEErQ0pxTjI2QkE4ckRoUXk3TkFPL3lNZkw5aUJt?=
 =?utf-8?B?dEV1VGFuQ2tBZzJ5cmlKdTNtT002Uk9RTUcwbkxzU2YwLzVTRWlJdDh3Uk5B?=
 =?utf-8?B?dS9yVFgyNU9xeXlnMzlkd0JXWllRRWZWN0d5bTdDa2hLbTJtNDhVNnR2dmRJ?=
 =?utf-8?B?S2oxUlpENDBqVHJOOExDNjNLclpDU1ZXYXY4RUlCMVBjZ0dWUU9sZ09CZ2ZT?=
 =?utf-8?B?em1qRE1xYnI4QUgvWXJWWlNuNnlsQ0t0QUR0TFdUdVRLUVY2amJaTUFvMyt6?=
 =?utf-8?B?LzhKRjZQakJKVkErekF5djR0bjY4Q0NoWHlZcDZlVUFZY3FMdUhYUDBNRy80?=
 =?utf-8?B?YlRjK3lPdmZEZTAwdy9vdldYc1pXSHgxeURmUW9Nbm5JQmVvb1dtMjNkVWth?=
 =?utf-8?B?Yzhkb2NqeGFacjVlOXAwNXlRcGRDTjhZcnYvRkFQendjaVdUYm5xd1g4Ymh5?=
 =?utf-8?B?MTdDakVNWGduRmNqd2FQa2ZVOVNjaWxXL0tWQnZCdjdXVTBMVzB3ZmFldDFN?=
 =?utf-8?B?ZGVlUDlSdUs2SnQ1WTZMeEtXZmk5bExYZTlLZG0xL2hDWXZUMDRoZitra1hI?=
 =?utf-8?B?eDNCYUxaMFhyMy90T3BqNFlORTZqSmZiQnhJcGVqNkJRQWVzMVQ3SW5CaVpN?=
 =?utf-8?B?WXpreFJQWk1PNHBMKzl5MWJ4Uytaa3lzMGNub1JZZzN4Mi9QWjNSUnpQS0hv?=
 =?utf-8?B?S0dCL2QzdzBvamZyaEUvTE4yMVltQWJiVmtRdUFvYnRraEFTRXJwOGZQU2VS?=
 =?utf-8?B?dDlTU3dmUmMraG9UN0FqU0RpNEZhNTlEVGY0UnN5dEVMdEM3Qlc2dFIwVG5s?=
 =?utf-8?B?bUxUMVNIM1JSNWQ0OWtxQUhYcTZJVUtLS2JLUUY3cEl0VTdQQnczR0RybTlu?=
 =?utf-8?B?K3MrRWZEQUN4OEZycTN3VDB0UzFTYkY1VFRSbmJLZzdjbFhpSitUMk1XMUF0?=
 =?utf-8?B?MEE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dea3f739-1a95-499e-8ad8-08dbd78dba56
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 08:13:11.9073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWwEaa3mB1dqUoeUzCx7vQ7H8JiEuPkz8IXLWp2tocOpeegGO6C9Ix7KpiwfvmxuoCHQ8GyKw0LMLtShhnOlOVOsUzzkX3oWWF/ptTxV9GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1154
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E7DCB146F043EA4189518FE81CD0DBAD@CHEP278.PROD.OUTLOOK.COM>
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

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDE2OjQ2ICswMzAwLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBVcGRhdGUgbWFpbl9iY2RtYSBhbmQgbWFpbl9wa3RkbWEgbm9kZXMgZm9yIG5hdGl2ZSBjb25m
aWd1cmF0aW9uIGluIHRoZQ0KPiBhYnNlbmNlIG9mIERNIHNlcnZpY2VzLiB1LWJvb3QgazMtdWRt
YSBkcml2ZXIgZXhwZWN0cyB0aGVzZSBhZGRpdGlvbmFsDQo+IHJlZ2lzdGVyIGZpZWxkcyBlbHNl
IHByb2JlIHdpbGwgZmFpbC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1A
dGkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9y
Zz4NCg0KV2l0aCBqdXN0IG9uZSBtaW5vciBuaXRwaWNrIGJsb3cuDQoNClRlc3RlZC1ieTogTWFy
Y2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IMKg
Li4uL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lmaS1kZXYtdS1ib290LmR0c2nCoCB8IDI3ICsrKysr
KysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lmaS1kZXYtdS1i
b290LmR0c2kgYi9hcmNoL2FybS9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2LXUtDQo+IGJv
b3QuZHRzaQ0KPiBpbmRleCBhZmEyNGQwN2E0Li43MzBjYjIxY2U5IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2LXUtYm9vdC5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lmaS1kZXYtdS1ib290LmR0c2kNCj4gQEAg
LTQyLDYgKzQyLDMzIEBADQo+IMKgCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gKyZtYWlu
X2JjZG1hIHsNCj4gKwlyZWcgPSA8MHgwMCAweDQ4NWMwMTAwIDB4MDAgMHgxMDA+LA0KPiArCcKg
wqDCoMKgwqAgPDB4MDAgMHg0YzAwMDAwMCAweDAwIDB4MjAwMDA+LA0KPiArCcKgwqDCoMKgwqAg
PDB4MDAgMHg0YTgyMDAwMCAweDAwIDB4MjAwMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0
YWE0MDAwMCAweDAwIDB4MjAwMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0YmMwMDAwMCAw
eDAwIDB4MTAwMDAwPiwNCj4gKwnCoMKgwqDCoMKgIDwweDAwIDB4NDg2MDAwMDAgMHgwMCAweDgw
MDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODRhNDAwMCAweDAwIDB4MjAwMD4sDQo+ICsJ
wqDCoMKgwqDCoCA8MHgwMCAweDQ4NGMyMDAwIDB4MDAgMHgyMDAwPjsNCj4gKwlyZWctbmFtZXMg
PSAiZ2NmZyIsICJiY2hhbnJ0IiwgInJjaGFucnQiLCAidGNoYW5ydCIsDQo+ICsJCcKgwqDCoCAi
cmluZ3J0IiAsICJjZmciLCAidGNoYW4iLCAicmNoYW4iOw0KPiArfTsNCj4gKw0KPiArJm1haW5f
cGt0ZG1hIHsNCj4gKwlib290cGgtYWxsOw0KDQpEaXR0bywgSSBiZWxpZXZlIHRoYXQgcHJvcGVy
dHkgd291bGQgdXN1YWxseSBiZSBhZGRlZCBhcyB0aGUgbGFzdCBpdGVtIG9mIGEgbm9kZS4NCg0K
PiArCXJlZyA9IDwweDAwIDB4NDg1YzAwMDAgMHgwMCAweDEwMD4sDQo+ICsJwqDCoMKgwqDCoCA8
MHgwMCAweDRhODAwMDAwIDB4MDAgMHgyMDAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDRh
YTAwMDAwIDB4MDAgMHgyMDAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDRiODAwMDAwIDB4
MDAgMHgyMDAwMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODVlMDAwMCAweDAwIDB4MTAw
MDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODRhMDAwMCAweDAwIDB4MjAwMD4sDQo+ICsJ
wqDCoMKgwqDCoCA8MHgwMCAweDQ4NGMwMDAwIDB4MDAgMHgyMDAwPiwNCj4gKwnCoMKgwqDCoMKg
IDwweDAwIDB4NDg0MzAwMDAgMHgwMCAweDEwMDA+Ow0KPiArCXJlZy1uYW1lcyA9ICJnY2ZnIiwg
InJjaGFucnQiLCAidGNoYW5ydCIsICJyaW5ncnQiLA0KPiArCQnCoMKgwqAgImNmZyIsICJ0Y2hh
biIsICJyY2hhbiIsICJyZmxvdyI7DQo+ICt9Ow0KPiArDQo+IMKgJmNwc3czZyB7DQo+IMKgCWJv
b3RwaC1hbGw7DQo+IMKgfTsNCg==

