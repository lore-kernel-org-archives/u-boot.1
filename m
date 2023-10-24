Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E64C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 13:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27D486053;
	Tue, 24 Oct 2023 15:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="B+K0f5M8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C5082BBF; Tue, 24 Oct 2023 15:16:01 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903E486053
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 15:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698153355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZEcmV9d8VoCq9TPh6ZWBOYkIjFfWqN/o2fOKsBxajk=;
 b=B+K0f5M8UAIG6JOh3K4vh9S4+cNs8nF+7co5smTPenai+XDmG4CyPcEJ85QqkHcmE9qO/8
 4pNmZPAH4Txdx9hZ2j/iWFB1d5iNyeaBDUYqVGzPsPK2NhuZK02rCdFQ3AzPrCz8bLh5c0
 TFYxEMyzp4lFjC4QwSqsW9Ox9n87mWg=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-60-iCwl1jVlMACDNKtvAL1Ovg-1; Tue, 24 Oct 2023 15:15:53 +0200
X-MC-Unique: iCwl1jVlMACDNKtvAL1Ovg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0899.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 13:15:51 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 13:15:51 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "festevam@denx.de" <festevam@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0LBYqXaAgAAMigCAABTWgIAAIPoA
Date: Tue, 24 Oct 2023 13:15:51 +0000
Message-ID: <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
In-Reply-To: <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0899:EE_
x-ms-office365-filtering-correlation-id: 00e46559-b1b6-4a7f-1fdd-08dbd4935899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 7RP9kcSFlIvTyogrzKu+7v2zncXtbIg40C+Of1aNiNzyJnvue5mE/4d5r1OsAO9EJklkSbuthYEoO6d1gc8wN+TN5nOfdPQSfWQvvzOJiFZ5ITtCkm+nSCgAWfV4HIfPG3JXnSKXZP7m7MceVAotw3ZdSxej47zXZ5j2zAc6B+uuTUyexk7OTtuoAeX9CSmXHqnKJ30Y90vtkcnL3g/6WVmSmYunAXGrFTus8GMpElhjmx2Qs1HyWMZFyOvsuLv7idR0hr4ovfzySMELbgZNUOqYTZ8d9uUaUjTxKJkr3ApBSpDL3DJL4HE/gzPybDaHwTP5fEbDIcLCRIvy3GXVBfoTpASTKDMzhtGVlYFLfhxBZI6oLVTbPus/XTYNFDpjL/H2OwgyN4JTywxDMu+6xUbBHCpDRJijCk7lF2plb9WfM260iVuFSKszULY2bl1rR7gbrgjzY8myKKYRg3bBcd2PhITEU8WAmmtVzPZaqAfcOwsdim2WrwAXa5b7liYVkb5L8qTCENee+PkB8A7xNIUO2xeO/aJ9/zj3q8e/lJxBDlRvimNWuavAbJ4m0qWmGssrcWcinkFT2nnd7zMXqbwxIpr3xMdgK1/f+ZZVSSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(136003)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(44832011)(36756003)(2906002)(38100700002)(54906003)(66476007)(66556008)(66946007)(316002)(76116006)(122000001)(64756008)(66446008)(6506007)(71200400001)(91956017)(110136005)(478600001)(6512007)(2616005)(966005)(6486002)(83380400001)(5660300002)(86362001)(4326008)(8676002)(8936002)(26005)(38070700009)(4001150100001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJ3NnlVY0dYT0FLVjNFOSs3YW1FR2svdlNHZkRpLzJXUy9qQWtBZytMOXNL?=
 =?utf-8?B?cFZBNFBXY1JIa1QvdTFtdUtRWWxCZ1B0ZWZUY3hQVHBwcWM3T0RMOGl5ZW1E?=
 =?utf-8?B?UzBNNnQzTHdnRzJ0aGc2V3k2SXRzMlZzS29xY093V3QwUzBsS2ZqcGMyOTd4?=
 =?utf-8?B?NEw5WVB0YkMwcGNmb2R6b1BHamNwZzlyUWFLTDlUYW9kR3p1bHJRbjB1T3Iv?=
 =?utf-8?B?aGFmNDN0K2gxM0trc0x4UkRvMWpMWGFxZkk2b0tibVUxQzdvS2YxV2pHWC90?=
 =?utf-8?B?MFNVMzB4UXhVK0RjbzM3U0U2cWNYMEpkL3ZyT2hnVzZMcmI0dWRUS2lqZ21k?=
 =?utf-8?B?TWFQVHFIdGlxY1U1Ymp4dmh6L0JaYmx4VXVRSEdUMXQ2RUNJNEdtWEtBY3hh?=
 =?utf-8?B?WStXOW9iUnBiVDE2NkRkOTB4MEVYUHltVWdLaU9EQWVvK1JTeTZZOUtQQitj?=
 =?utf-8?B?T0dIU1RzNlhtZ0JQVE1ZbTlNZzJMRisyWUsxSVVYYnEwclM1dEh4UlpkZWE0?=
 =?utf-8?B?NnZDZ1p5V1Y3SWNpSlZkelhUNmNyMHpZUFhoc1c4ZkQ5b1VjWTJpVVlpcnEv?=
 =?utf-8?B?dHQ4cFk4bndkdlA3bm9QWU9GR2dYS0VmK3V6TnZVM1JiaExvbGFJNUdRQ0RH?=
 =?utf-8?B?MnpaR3RhUTZlNENrbGVubERpMENIc3hXaTNHV2hEc0NIcUhPRVMvckk5MHJ3?=
 =?utf-8?B?UE1XVVFkTU5rL0J4VXJHUDc1OEFqRHo4VE9DRUhOaVdESGlyamJsUFd6N05m?=
 =?utf-8?B?UzRzSmJidzdCOWpTNnZIazVhckVTT0o5ZjBTSkdXeU85WHNQZkxDdDBrTHlZ?=
 =?utf-8?B?QzBjQjViRzZBQ0Q2WVAzRU5IK0JtNzJYRXR0RmpPemhkSXZEck5vbUZ3SXc1?=
 =?utf-8?B?alEwTlFpb3ZwNHp0UUpta2Z0VUFNMG0xYm9TeGlRWmZGVFJBejcrWFRoR1hB?=
 =?utf-8?B?UkFwWTBkSy9TbEhiZ1UwWlp3MXJick9iQ2tua3hlc3dvQm1BcExVWC80bmo0?=
 =?utf-8?B?MjdnOThyRXczYVdaRmF0UXVNU2E2T2pBcjZiV1BadnNyc2tzbE1WaUhTVkE4?=
 =?utf-8?B?ZWR5YnQvdFNMMit3eG5vbzdKdFlueTZvSU1UUFBYTlBFYUU5TmZ3M1NaRnU2?=
 =?utf-8?B?NDk1RDNNVzQ3UXJ6QnNnUUVrQWZWd3l0ZkY3bHpLbHVPVDE2ZWh0UmtnSWFG?=
 =?utf-8?B?QU82RjU1SjlUUVl3V3V4MUU2ekNXbWRhQXFrcXFRK2NwQ2V3UVhCbnAyaUlO?=
 =?utf-8?B?TE5LWndReVkxOGI2cE1FNGcyZnduZGs3REZRQ0VuazU1WE9JQVA1bGFxVmxJ?=
 =?utf-8?B?T1BCQjVIY3hZVFJvYWF6TXV3VG9USVAyRUZkbTVFaHhNaGRGa3FkV3YwTlBp?=
 =?utf-8?B?MTl1eUtEY2RJdTBQSWJROUVMRXljOCtkdmNOVlJRMnExU2RZS2RBbHBjY201?=
 =?utf-8?B?eW9XbjJXdzRKaTZ4Z0Y3WUZDWDVjQ2g0SXBUMUo3Mm85Y29GaHZEMEFYeTdE?=
 =?utf-8?B?V3BqT0l0RTc5bjd2blJTTFArSEFyRWE5b0VhMlp1K1VQYkZyZmlFRVVoSmlF?=
 =?utf-8?B?elJUYVpKRGxXdGtsN3ZkR3RGeHZrQUxjdnUrUm5CQlRqeDZSdlp3TE5EckNx?=
 =?utf-8?B?dWN3NkxyVWJPSTlCWnFRNDFjYWl1SGo4ZHZXMENMOWJRUEw3OExIeGZXSmZH?=
 =?utf-8?B?ekd3SGphV2RzNWJzMEZ3dUpWalgybE9CbzkyeTB3VUhPZWRUYzVneWNrN09j?=
 =?utf-8?B?VVU4M2Q5Sm1iWElsNTZvWTZySGZMQ2lZYVVsT2FvYnpDRnY5S0Mza202d0tZ?=
 =?utf-8?B?VkpSUnhTWDFTMW5QS3JMaTRsVDFBNDFCKzJpVWlqUG5PL2VnQ2RncTBTMFRJ?=
 =?utf-8?B?YnVmbjlTMmcvQzVKakptenhiQnRxU0VEdjE5NzJaaE1CckJsUUtqcXNvTGtD?=
 =?utf-8?B?Ym5UbVlWaE5icHMxeWdoZTJQRFRzWVkyUFJSME9IV2Y3WXVCNHMrR01rOVNJ?=
 =?utf-8?B?N1g0K2lDaHpHa0xkVDJUMTZsZiswNkxXTVE2KzV2SGxySDVOendTWjZXZ1VL?=
 =?utf-8?B?SWhyYUx0ZFdDZkZXMHY4ejZvWE1WZnh0bFR6MjZhZjRvaUhwRnk4aUEyVDhH?=
 =?utf-8?B?bC81eEtpZCtBMi9DOUhZTHpNU2phNll3RXlFTjJyc2I0ZHpmVTVYOWhOU3V0?=
 =?utf-8?B?bFE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e46559-b1b6-4a7f-1fdd-08dbd4935899
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 13:15:51.4333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHEuXAmxejef4ERvHBbm0tVT2Y2PLCexV4NpTUs5D3NTQA7WMrm8ZCZ9AQg1cgRqR6LFsI1xL6rjmjjlJH8/cXm44RO+ZwZxvvfkPf8zjGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0899
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <5B6AF5B091BD0C468A0BCB96F4067030@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUmFzbXVzDQoNClRoYW5rcyBhZ2Fpbi4NCg0KT24gVHVlLCAyMDIzLTEwLTI0IGF0IDEzOjE3
ICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KDQpbc25pcF0NCj4gDQoNCj4gPiANCj4g
U28gdGhpcyBpcyBpbnRlcmVzdGluZy4gSSB0cmllZCBkaXNhYmxpbmcgQ09ORklHX0lNWF9IQUIg
KGJlY2F1c2UgdGhhdA0KPiBjYXNlIGRvZXNuJ3QgY3JlYXRlIGFuIC5pdGIgd2l0aCBleHRlcm5h
bCBkYXRhKSBhbmQgYm9vdCBvbiBhIGJvYXJkDQo+IHdoaWNoIGlzIG5vdCBsb2NrZWQgZG93biwg
YW5kIEkgZ2V0DQo+IA0KPiBUcnlpbmcgdG8gYm9vdCBmcm9tIEJPT1RST00NCj4gQm9vdCBTdGFn
ZTogVVNCIGJvb3QNCj4gRmluZCBpbWcgaW5mbyAweDAwMDAwMDAwNDgwMmRmMDAsIHNpemUgMTUw
NA0KPiBhbHJlYWR5IGhhdmUgMjU2IGJ5dGVzDQo+IE5lZWQgY29udGludWUgZG93bmxvYWQgMjA0
OA0KPiBzcGxfcm9tYXBpX3JlYWRfc3RyZWFtKCk6IHNzLT5wYWdlc2l6ZSA9IDB4MQ0KPiBzcGxf
cm9tYXBpX3JlYWRfc3RyZWFtKCk6IHNzLT5wYWdlc2l6ZSA9IDB4MQ0KPiBkb3dubG9hZGluZyBh
bm90aGVyIDB4OWQ3NjggYnl0ZXMNCj4gc3BsX3JvbWFwaV9yZWFkX3N0cmVhbSgpOiByb21fYXBp
X2Rvd25sb2FkX2ltYWdlIC0+IDI0MA0KPiBzcGxfcm9tYXBpX3JlYWRfc3RyZWFtKCk6IHNzLT5w
YWdlc2l6ZSA9IDB4MQ0KPiBkb3dubG9hZGluZyBhbm90aGVyIDB4MWZmMTggYnl0ZXMNCj4gc3Bs
X3JvbWFwaV9yZWFkX3N0cmVhbSgpOiByb21fYXBpX2Rvd25sb2FkX2ltYWdlIC0+IDI0MA0KPiBz
cGxfcm9tYXBpX3JlYWRfc3RyZWFtKCk6IHNzLT5wYWdlc2l6ZSA9IDB4MQ0KPiBzcGxfcm9tYXBp
X3JlYWRfc3RyZWFtKCk6IHNzLT5wYWdlc2l6ZSA9IDB4MQ0KPiBkb3dubG9hZGluZyBhbm90aGVy
IDB4MTYyMiBieXRlcw0KPiBzcGxfcm9tYXBpX3JlYWRfc3RyZWFtKCk6IHJvbV9hcGlfZG93bmxv
YWRfaW1hZ2UgLT4gMjQwDQo+IE5PVElDRTrCoCBCTDMxOiB2Mi42KHJlbGVhc2UpOmxmLTUuMTUu
NzEtMi4yLjAtMC1nM2MxNTgzYmEwLWRpcnR5DQo+IE5PVElDRTrCoCBCTDMxOiBCdWlsdCA6IDEx
OjAwOjM4LCBOb3YgMjEgMjAyMg0KPiANCj4gYW5kIHRoaXMgd29ya3MganVzdCBmaW5lLiBCdXQg
aW4gbXkgY2FzZSBzcy0+cGFnZXNpemUgaXMgMSwgd2hlcmVhcyB5b3UNCj4gaGF2ZSA1MTIuDQo+
IA0KPiBKdXN0IGV4YWN0bHkgaG93IGFyZSB5b3UgYm9vdGluZz8gSXQgc2F5cyAiQm9vdCBTdGFn
ZTogUHJpbWFyeSBib290Ig0KPiB3aGVyZWFzIEknbSBkb2luZyBzZXJpYWwgZG93bmxvYWQgd2l0
aCB1dXUgKGkuZS4gIkJvb3QgU3RhZ2U6IFVTQiBib290IikuDQoNClllcywgcmVndWxhciBlTU1D
IGJvb3QuIFNlcmlhbCBkb3dubG9hZCBhbHNvIHdvcmtzIGZvciBtZSAobm90ZSB0aGlzIHJlcXVp
cmVzIGEgcGF0Y2ggc3RpbGwgbm90IG1lcmdlZCB1cHN0cmVhbQ0KWzFdKToNCg0KVS1Cb290IFNQ
TCAyMDI0LjAxLXJjMS0wMDAwMS1nMzY0MTNlMjc3MjctZGlydHkgKE9jdCAyNCAyMDIzIC0gMTU6
MDM6MDUgKzAyMDApDQpUcmFpbmluZyBGQUlMRUQNCkREUiBjb25maWd1cmVkIGFzIHNpbmdsZSBy
YW5rDQpTRUMwOiAgUk5HIGluc3RhbnRpYXRlZA0KTm9ybWFsIEJvb3QNCldEVDogICBTdGFydGVk
IHdhdGNoZG9nQDMwMjgwMDAwIHdpdGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcyAoNjBzIHRpbWVv
dXQpDQpUcnlpbmcgdG8gYm9vdCBmcm9tIEJPT1RST00NCkJvb3QgU3RhZ2U6IFVTQiBib290DQpG
aW5kIGltZyBpbmZvIDB4NDgwMmIwMDAsIHNpemUgMTA0NA0KTmVlZCBjb250aW51ZSBkb3dubG9h
ZCAxMDI0DQpzcGxfcm9tYXBpX3JlYWRfc3RyZWFtIHNzLT5wYWdlc2l6ZSAweDENCnNwbF9yb21h
cGlfcmVhZF9zdHJlYW0gc3MtPnBhZ2VzaXplIDB4MQ0KZG93bmxvYWRpbmcgYW5vdGhlciAweGQ2
NDgwIGJ5dGVzDQpyb21fYXBpX2Rvd25sb2FkX2ltYWdlKCk9MjQwDQpzcGxfcm9tYXBpX3JlYWRf
c3RyZWFtIHNzLT5wYWdlc2l6ZSAweDENCmRvd25sb2FkaW5nIGFub3RoZXIgMHgxYWM3MCBieXRl
cw0Kcm9tX2FwaV9kb3dubG9hZF9pbWFnZSgpPTI0MA0Kc3BsX3JvbWFwaV9yZWFkX3N0cmVhbSBz
cy0+cGFnZXNpemUgMHgxDQpOT1RJQ0U6ICBEbyBub3QgcmVsZWFzZSBKUjAgdG8gTlMgYXMgaXQg
Y2FuIGJlIHVzZWQgYnkgSEFCDQpOT1RJQ0U6ICBCTDMxOiB2Mi45KHJlbGVhc2UpOnYyLjkuMC02
MTktZzVmMDFiMGIxMQ0KTk9USUNFOiAgQkwzMTogQnVpbHQgOiAxMTowODowMiwgU2VwICA2IDIw
MjMNCg0KDQpVLUJvb3QgMjAyNC4wMS1yYzEtMDAwMDEtZzM2NDEzZTI3NzI3LWRpcnR5IChPY3Qg
MjQgMjAyMyAtIDE1OjAzOjA1ICswMjAwKQ0KDQpDUFU6ICAgRnJlZXNjYWxlIGkuTVg4TVBbOF0g
cmV2MS4xIDE2MDAgTUh6IChydW5uaW5nIGF0IDEyMDAgTUh6KQ0KDQpbc25pcF0NCg0KPiBJdCBz
ZWVtcyB3ZWlyZCB0aGF0IHlvdSBldmVuIGVuZCB1cCBpbiB0aGUgaXNfYm9vdF9mcm9tX3N0cmVh
bV9kZXZpY2UoKQ0KPiBpZiB5b3UncmUgYm9vdGluZyBmcm9tIGVNTUMgKHdoaWNoIHdvdWxkIGV4
cGxhaW4gdGhlIDUxMiBieXRlIHBhZ2Ugc2l6ZSkuDQoNCkF0IGxlYXN0IEkgYW0gbm90IGF3YXJl
IHRoYXQgd2Ugd291bGQgYmUgZG9pbmcgYW55dGhpbmcgc3BlY2lhbCBmb3IgZU1NQyBib290Lg0K
DQo+IEFsc28sIHRoZSBwcmludHMgYWJvdmUgcmV2ZWFsIHRoYXQgdGhlIGRvd25sb2FkIG9mIHRo
ZSAweDFhZTAwIHN1Y2NlZWRzLA0KPiBidXQgdGhlbiB3ZSBlbnRlciB0aGUgZnVuY3Rpb24gb25j
ZSBtb3JlLCBhbmQgZm9yIHNvbWUgcmVhc29uIHlvdXINCj4gcHJpbnRmKCkgZ2V0cyBjdXQgc2hv
cnQ7IGluIG15IGJvb3QsIHRoYXQncyBmb3IgZmV0Y2hpbmcgYW5vdGhlciAweDE2MjINCj4gYnl0
ZXMuIE15IGd1ZXNzIGlzIHRoYXQgdGhlIGJvYXJkIGhhbmdzIGJlY2F1c2UgaXQgdHJpZXMgdG8g
ZG93bmxvYWQNCj4gbW9yZSBkYXRhIHRoYW4gdGhlIHN0cmVhbSBjYW4gc3VwcGx5LCBkdWUgdG8g
dGhlIHJvdW5kaW5nLXVwIHRvDQo+IHNzLT5wYWdlc2l6ZS4gQ2FuIHlvdSB0cnkgd2l0aCB0aGlz
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDhtcC11LWJvb3QuZHRzaQ0KPiBi
L2FyY2gvYXJtL2R0cy9pbXg4bXAtdS1ib290LmR0c2kNCj4gaW5kZXggZTU0ZGYxNzY2ZmEuLjRi
NWU5ZmY0NjZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvaW14OG1wLXUtYm9vdC5kdHNp
DQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4bXAtdS1ib290LmR0c2kNCj4gQEAgLTEwMCw2ICsx
MDAsNyBAQA0KPiANCj4gwqDCoMKgwqDCoMKgwqAgaXRiIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZpbGVuYW1lID0gInUtYm9vdC5pdGIiOw0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhbGlnbi1zaXplID0gPDUxMj47DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZml0IHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlvbiA9ICJDb25maWd1cmF0aW9uIHRvIGxvYWQgQVRGIGJl
Zm9yZQ0KPiBVLUJvb3QiOw0KPiANCj4gc28gdGhhdCB1LWJvb3QuaXRiIGlzIGV4dGVuZGVkIHNv
IGl0J3MgYSBtdWx0aXBsZSBvZiA1MTIgYnl0ZXM/DQoNClVuZm9ydHVuYXRlbHksIHRoYXQgZGlk
IG5vdCBoZWxwLiBJIG1lYW4gaXQgZG9lcyBtYWtlIHRoZSB1LWJvb3QuaXRiIGEgbXVsdGlwbGUg
b2YgNTEyIGJ1dCBrZWVwcyBjcmFzaGluZyB0aGUNCmV4YWN0IHdheSBhcyBiZWZvcmUuDQoNCj4g
UmFzbXVzDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MjgyMTM4MDMu
NDU0MzAzLTEtbWFyY2VsQHppc3dpbGVyLmNvbQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

