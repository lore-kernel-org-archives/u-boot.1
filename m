Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7DBC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D1386456;
	Mon, 28 Aug 2023 23:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="EDQlK2Dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1938647F; Mon, 28 Aug 2023 23:56:13 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED75180569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693259770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRM294XFxnF/Mfm2NGiIDG/5E4CGHF16/dc/WhEwBts=;
 b=EDQlK2DqtY5qGjXqDbGj4Pt/mfEITqS2cUEnzQ9DT15uHMG2ySukgeHX7xk+SJxwu1Yb9R
 6gj+f7KaCEIuogVBvSu/Obh28B2VXukx8GGAgsayNyC5/VmAjiV6JJngHDBtld8DNdACSZ
 fJ+ohoeEtPkKOUhr92Ul+GjO0n9A8C4=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2110.outbound.protection.outlook.com [104.47.22.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-52-MjcJqD0POu-QIOaNmpMYQQ-2; Mon, 28 Aug 2023 23:56:08 +0200
X-MC-Unique: MjcJqD0POu-QIOaNmpMYQQ-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR1P278MB1000.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Mon, 28 Aug 2023 21:56:00 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 21:56:00 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>
CC: "vigneshr@ti.com" <vigneshr@ti.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "afd@ti.com" <afd@ti.com>, "bb@ti.com"
 <bb@ti.com>, "nm@ti.com" <nm@ti.com>, "robertcnelson@gmail.com"
 <robertcnelson@gmail.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, 
 "praneeth@ti.com" <praneeth@ti.com>, "sjg@google.com" <sjg@google.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Thread-Topic: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Thread-Index: AQHZ1mLpXistP2UR+Eu+7OM5/JUJEK/5Wa6AgAAP+4CAADRnAIAAAaeAgAaoXoA=
Date: Mon, 28 Aug 2023 21:56:00 +0000
Message-ID: <1f7bae66ef9a183acbe8044b75e510325c12ad05.camel@toradex.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-3-nm@ti.com> <87il94rh6x.fsf@baylibre.com>
 <20230824120509.72xvy5n2hpl5uh4q@landside>
 <715c5ae929964f51a3c3fec91cb8c9cb4f65eaa0.camel@toradex.com>
 <ZOeA0vxJs4iQXLFL@francesco-nb.int.toradex.com>
 <ZOeCNQJ6zi3jqrQc@francesco-nb.int.toradex.com>
In-Reply-To: <ZOeCNQJ6zi3jqrQc@francesco-nb.int.toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR1P278MB1000:EE_
x-ms-office365-filtering-correlation-id: f9ff54bd-b1f2-4575-d15a-08dba8119128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Rq/7qg1hCxm6CpGyH4k7w73jyaCLHdnXGscm+3utrkTUs6GrwAj7RTuG7RRKJK23IXDi9MgsE+PeYfW9620zSKSFzWOnAYskp+euNTAfU5L2OE59vv56IckCeC8UjXFdXqAbYeAwgnY0/SHGNA1Tdfp/+hrsFSxfPnYlIc8Xul/eM6xsGHd3Uy5ZiGr8dOiXFBqHySxB634EHjt8m5XQFrl5PLbYyYZRyvwE3q7118GRw3VRjX4a8tQPy9TL78wl6f+S0FFFRsVBUFp/5u6JV2npiW8OPVw7yVO0YnLFRuXy6I2iwELio7Uu/2/cS4dOH8tf8lEgPYSK5RmDTs9KzEE39NSuCjnvrClW7Tr+uCXB3xjmuo8hk8mwbqw2kkheQMWfpdAirYo4n/dIczUmImptFDyutF7HUflF8WTvgEPwqzWWjzy4ICblsLFjCcBNIJUXK6mPWi9J/TBxV7yWE0Ymo4KHwepdmTJrA4DCEURnOHQ6YXqio/6gKjcxCPLqKNXAIKSzdjFbDSTNR1hHQNvJP3sc1cy1wdn9UTJbbqhtcXvgicZPk8DelJfU7d+Eh7Sjf7Q7cyV1AJXD7LhPYHdTi5FwftcQsZojrVV8au8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39850400004)(376002)(346002)(1800799009)(451199024)(186009)(4744005)(7416002)(4326008)(5660300002)(86362001)(44832011)(122000001)(38100700002)(2906002)(38070700005)(71200400001)(6486002)(478600001)(966005)(36756003)(2616005)(6506007)(6512007)(316002)(66446008)(54906003)(64756008)(66556008)(76116006)(66946007)(66476007)(6916009)(8676002)(8936002)(41300700001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckZJejM2VVg3Y3dZeWdCQ1g4YzFMbWZIbXBKRkN6aDI3VytnbXA1Nmhod2t3?=
 =?utf-8?B?TitYNHBkL0E5bEZUWmlQdmtLUGUrd21ES3NqaTI2R1JoMXdjeU9YQmlGdFdo?=
 =?utf-8?B?VFcwamNGeW8ydUovd3BrV0h2ZStWS1FkZjhrdzhmZTZ1TWlPS2F4SlNDaHI4?=
 =?utf-8?B?emYxVXpzeE9mMWh5OFdRRkxUaXh5SVptNGdYRmNNYStKTlp5SkhBdUxCNDZU?=
 =?utf-8?B?U2dnT08wKzJHTG01ZEhXTTNXV3U4S20ycWI0VlpiMnBwdFdUejJSOHVpY1hh?=
 =?utf-8?B?b1dJTjRsc0M0RXp6SUoycVhKNjcwUVhXOG50QnpvWVFzTHVtSk5OMGJJTCtY?=
 =?utf-8?B?YXowdzRicWZGRTU2b0JOZHVmSE9tZlgxT3NsV2EwU0tHS2g1WnZhTFRKNE95?=
 =?utf-8?B?WjlSNFVNVkNqUFl4eldYRUVNcUlNYzdKTTN2c2dsVk55bFZBR2I3QktvcFo5?=
 =?utf-8?B?dkpwMzZaQ3lqOFpHQTk2emdjYjFpa0Nqcm5WQ1ZpanFVa2ZtdzArb3VFcGxE?=
 =?utf-8?B?d0dGTW1NVHh3eFRFNmlhUFpZbmZIKzJTMFZUYnhRcFR6bTJ4elR5OEU1Rldq?=
 =?utf-8?B?d3FSWmxoZmxJaWJ1MFI2WjJiZmJTUmtWd1pyT0pEbldxZVBtYjQyK0ZBeEhS?=
 =?utf-8?B?eVBTOVBmcVRuUUE1K0VXNkdxbE4zWWF0VEcycVM4ZDFqUHFvbDdIQXVsZCtM?=
 =?utf-8?B?UWhsWGJkOVlsR2crN2tFOXlqbVBmNVhtanZJQWc2OW84a0YrZGpSeENUSGpw?=
 =?utf-8?B?REo3Mmdxc2V6ZXhoV090K3Y2eWtocHB6a2ltQVRBUjJmOUFLaDdRT0VHaVFE?=
 =?utf-8?B?eVdPWUo4cW1rM2tDVCthb1I4SERSTmxjS0UycWZSS1NpbE1HcWpNK2VvT2Va?=
 =?utf-8?B?c1VTMTRONDFEbWtRS0lYU2VNdk9Pckg3ME9LZ3RPcGl0ajVQU3Rmc2tYeG9W?=
 =?utf-8?B?ZjlMZURwdkJlRzdoV0tlNk83b1A1UHM0Wkd1d1ZScE9WNVZPMUNVemVpcFdT?=
 =?utf-8?B?YW4zZjRkb05oR01mb0h6b2MxODVZRG9nbkVMUHBwd0M5QmNUYVVud0o1aWZP?=
 =?utf-8?B?WFJOUG0xcktLbkN3Z08vWW1ncDI3aEcyZ2MrVG9EMjFrd1FRZTJWNVY2ZHo0?=
 =?utf-8?B?QUlQVW1sc2NXQm02dHZiaWo1UkQwUFBBZWtUOE10eHBOeVpsclUyL2dNd0M2?=
 =?utf-8?B?aHg2UDJSc1F2SWZWOUx4SE5ibjNFaHVCWFRrenQ3TWVWTTNlWkN0N0EzMmZ6?=
 =?utf-8?B?TkxyU3BQclM1V0p1Y3NCRzhxSlE3dUd1NmhNMndxRmxPYnpKL0NtVzdMV1FO?=
 =?utf-8?B?SW03TUZIeWF4SjB1b2k3TzAwVktFejhJQmlJODdTamVVa0NtZ1EyR0JGbG9q?=
 =?utf-8?B?Wm1tSFNoazAxSnovaEJBVVZtaFRoUk1hemYwYlBiakZwK1N1M25rU2dtbnNx?=
 =?utf-8?B?KytNYUI4ZThRb0s2L0haMUp5Q1ZjdHBVQlBjNnBJaEdhalBGQVZnN0x4K1pK?=
 =?utf-8?B?ZU5vazdCcGcxbGJKR0paSE4ydGZkOXBHZkV2N01ZekFVZFhSOU8vVFoycEFp?=
 =?utf-8?B?aU5XanVBQXl5Zi9lVkdkRXRwazhLQ0FRekM0c0l2NytNSGtEVmNQTWZFUkQ5?=
 =?utf-8?B?RUpSL2FRMm01VnVFTTBubzFlbituNHNYVHNIQmlqQnJsRkIvTFN0ZmlDL1lY?=
 =?utf-8?B?dTJ4QURxSEw5ZWVydWt5bGNRWVZMZWtFdkZwVFRWYnlJdDA3cXp1VHpxYUFW?=
 =?utf-8?B?b1NHRGRLTlVDWGpZSzFsWDBqYWd1NXY1Q24xdkJoYVNpZDMxM1k0T0NUZTN4?=
 =?utf-8?B?dTFnVFk5TmRld21ORmpQTjB1eUVoYzMyRFlFKzVFdWN1SGRtekIzTDhpZE5P?=
 =?utf-8?B?VEVISUEwNytjVWFTNmt3ejZ3aGkxV0FWYTVrOU5ISFg0S0xRTWplQkd2bTJY?=
 =?utf-8?B?bFU1ZDZvZDZ3eEVxY0FZNFVReTd5TitKUXRWVHlYdkRhQTk0UEhTRWt3VGpx?=
 =?utf-8?B?RkJETHdPWW1iKzFTeFNta3JFMDVyc01iWGM1YXV1cVkrK0dWcldPUXZ5STR5?=
 =?utf-8?B?eVNJSzFXQTlwNGJaRXBLZC9KVFNUd1MvZ1h1d3VTSGl6SXZ3Q2FiL2tQbmJ3?=
 =?utf-8?B?UlpNcldmQWI3Z1lzWkY0OFVKTFdjbmtPdUNEYWhiRTZDYUNLa0wyUXZBTWZz?=
 =?utf-8?Q?1o3Frlh+yZsFNEtAVJWB3ko=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ff54bd-b1f2-4575-d15a-08dba8119128
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 21:56:00.5991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4Nk/2lXWROmWNk8Sj/PgzSkNzqE2AZANoUlxVwBhQtzVRczR1xZa60b2s2Nug1bT3Xqo3IZ9fCjmbw5KOf3j7XHd9hPnSHhkPZFFlTRS8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1000
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <8E12B9B97022834D9E3631167E5F7792@CHEP278.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDE4OjE1ICswMjAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCg0KW3NuaXBdDQoNCj4gPiA+ID4gPiBXaGF0IGFib3V0IGluY2x1ZGUvY29uZmlncy92ZXJk
aW4tYW02Mi5oID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJdCBzZWVtcyB0aGF0IHRoYXQgYm9h
cmQsIHdoaWNoIGlzIGFtNjJ4IGJhc2VkLCBhbHNvIGhhcyB0aGUgdW4tbmVlZGVkDQo+ID4gPiA+
ID4gaW5jbHVkZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSBpJ20gbm90IDEwMCUgc3Vy
ZSwgSSBoYXZlIGFkZGVkIE1hcmNlbCAod2hvIHBvc3RlZCB0aGUgdmVyZGluIGFtNjINCj4gPiA+
ID4gPiBzdXBwb3J0KSBoZXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gVG9yYWRleCB0ZWFtLCBDYW4g
eW91IGhhbmRsZSB0aGF0IGNsZWFudXA/IEkgc3RheWVkIGZvY3Vzc2VkIG9uIGFtNjJ4X2V2bSBz
aWRlDQo+ID4gPiA+IG9mIHRoaW5ncy4NCj4gPiA+IA0KPiA+ID4gWWVzLCBvZiBjb3Vyc2UuDQo+
ID4gDQo+ID4gSSBiZWxpZXZlIHRoYXQgdGhpcyBpcyB1c2VkIG9uIHZlcmRpbi1hbTYyLCBwbGVh
c2UgZG91YmxlIGNoZWNrIG1hcmNlbC4NCj4gDQo+IE5vLCBsaWtlbHkgSSBuZWVkIHRvIGdvIGhv
bWUgYW5kIG5vdCBzcHJlYWQgaW5jb21wbGV0ZSBpbmZvcm1hdGlvbiBoZXJlIC4uLg0KDQooOy1w
KQ0KDQpXZSB0b29rIGNhcmUgb2YgaXQuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIzMDgyODIxNTAzNy40ODIyNzgtMS1tYXJjZWxAemlzd2lsZXIuY29tDQoNClRoYW5rcyENCg0K
Q2hlZXJzDQoNCk1hcmNlbA0K

