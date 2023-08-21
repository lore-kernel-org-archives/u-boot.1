Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3C0EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 16:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A50087078;
	Mon, 21 Aug 2023 18:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="VkPK7v8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0530986828; Mon, 21 Aug 2023 18:13:41 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE918705E
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 18:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1692634417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S95Wr5xxs+hiC7Gx0le+Cvh526Z1BBunHcn74beVkHM=;
 b=VkPK7v8b1vy76+LyRRKZKEYneVpEKLKyLI/MfXwoqWO4XsbbZHFVkuWdaZuU+NAA9WOMsI
 cCYs0uTQfcumgkjQqS/UwzJzfaA+gWAIKie3ACIfNa0eKESgzLZmMoVXyjik8n4DSjd8HS
 VYgBWrqHWBANN6vR6aV5CqI84HN/jag=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-59-X7WVosfQOvCvsCPgekxBIQ-1; Mon, 21 Aug 2023 18:13:34 +0200
X-MC-Unique: X7WVosfQOvCvsCPgekxBIQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB1035.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 16:13:32 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:13:32 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "nm@ti.com" <nm@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjoerd@collabora.com" <sjoerd@collabora.com>
CC: "a-govindraju@ti.com" <a-govindraju@ti.com>, "d-gole@ti.com"
 <d-gole@ti.com>, "d-gerlach@ti.com" <d-gerlach@ti.com>, "jpanis@baylibre.com"
 <jpanis@baylibre.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "g-tammana@ti.com" <g-tammana@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "marex@denx.de" <marex@denx.de>, "hayashi.kunihiko@socionext.com"
 <hayashi.kunihiko@socionext.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "angus@akkea.ca" <angus@akkea.ca>, "g-vlaev@ti.com"
 <g-vlaev@ti.com>, "s-anna@ti.com" <s-anna@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] Add DFU, emmc and usb boot for TI am62x
Thread-Topic: [PATCH v2 0/8] Add DFU, emmc and usb boot for TI am62x
Thread-Index: AQHZ1Epus93Xq08zLUOz0eh9QB2SiQ==
Date: Mon, 21 Aug 2023 16:13:32 +0000
Message-ID: <df470ed11d3c7f748a171cf221102b0bcd2ead23.camel@toradex.com>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230531211403.GA980359@bill-the-cat>
 <3f8f03e9736aa93b87a26e8056037d53bb50db56.camel@collabora.com>
In-Reply-To: <3f8f03e9736aa93b87a26e8056037d53bb50db56.camel@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB1035:EE_
x-ms-office365-filtering-correlation-id: c33e784e-f787-4b5c-9edf-08dba26190cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: BzihDEY9TVRiWa5/Z0O6kWIO9MxpVcJ6P46duYiZaqQcVJLQ+FSpXgKR35Sckd18ty0bWTpnU/Qs/gx6pl/F+Md/UAiCzH8Pt4e5j1f31A46BqqHxfDJowpGYnTPk7VHoM5V6lb/0gAfxByXDShPlVoDgpsTbTeuED5KRg/f6tZShNHutAE4ScA76RnrIdZY5ylWQbVtHEJdLA5yFlP8cAO59szQk7z9dXsTMnVJty2hxtOQjLSF3YJP0wfqDYq2bTPx02PUR8S763D0WPVlLS2O1j0TA47SwAw2UyeXTOT6feCPFzBXR8ZGUKZzCZV8hXS3riKC8Xta5Hz6vjURIfYjXYHSQvy5xZMQG/Rj1ls9gtJ+AQSfa3n3umxWesHttEKFKtglzVfN88m1chTNHmZTuk8N2pJ8978ZJ26TUCDM9rkjvH9t0GsA2RfAJ48lAgWKMN3chrRAoxQOBfIjsSrN3wp3U50WQoGvTBoYLrA4Tmf82NICjZSqkT0W3m6tZa72nP4vo0xFDS1wYYON4EU7Wc+OEhjcKjRgeL4a2u3aal2wFtQx9cYudhjPkIQwI5A+SqCz7m7ud/nh8BWTpV8ujnSLXt8P0Cf36ZFlSt8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(966005)(6512007)(6486002)(6506007)(44832011)(7416002)(5660300002)(8676002)(8936002)(86362001)(36756003)(2906002)(64756008)(4326008)(66556008)(110136005)(66446008)(66476007)(38070700005)(54906003)(66946007)(316002)(76116006)(41300700001)(122000001)(71200400001)(478600001)(38100700002)(2616005)(83380400001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzZpV1ZnUmlwY3pFcXp2UzlhaUI1eFphd3BvNTJxOWVQZmI1ViszOUxTaFJu?=
 =?utf-8?B?emVRVjA4bHgzdFRXVkZOeGtoQmI2VnZTRGRGR0dYd1JmSnFENTNXOFZ5M0RS?=
 =?utf-8?B?azRvbTM1TXlTMC9lSEp1R3U4Q2dtZFJObVhvM0Rrcy92Z3Vzd3lZS0dkcjZo?=
 =?utf-8?B?ZXNid2ErU0Jua2VJSVFQb1hZR3VrdXFtL0dNWnVGeHVnSkZFTS85MjdwMnpo?=
 =?utf-8?B?bDY4SXg0dGJSMFBCU2dnZENOM2U0NGxFNjVxd2pReHQ1OS9pWXNKRHVjSlVw?=
 =?utf-8?B?ZSt1TUxKT3pDc2NmWGlLeXN5Z2w4TWVPa1JyMGpqdFVDeFdQUjZUVnI0UnBH?=
 =?utf-8?B?OEVDSWluTW9iU3lOaUIzdTdSVkZtZXVoa3VGcWVXNnpLZ0JpWnJaRE1GY1ZH?=
 =?utf-8?B?RFhJTjB5WHI4dC9MbCt3UE5yUlhrQXd5MHlLR3BkQmtGT05DS2tUOXNIZEU3?=
 =?utf-8?B?MEVPeUpwZkxaNTRTQVJiZUtLYkJJNDNTSTIwZHk1VklxK0RyM3pQZ3VwQ0FI?=
 =?utf-8?B?aFZncy9sajk1UUVyNHorU2k2MFpPQXN0QVQ3NHlxaGowbE1kQzRabmpwdnky?=
 =?utf-8?B?SEVHeTVTcTFSNitsamFwenVyMFZWUHp6RU1xVHRkbm1obTNWQkJrRU15Rkpt?=
 =?utf-8?B?bE04aTYxclhjRHhQVkQyN2ZmZDBjcHNxYzdKZVNONkNNQXZlU2E4dVRWVU80?=
 =?utf-8?B?dStCdC94cWpHL2YxNkxycHFweUZCcWdBWm9uQ2kyWHdtYjBnWk5mZW0vcXpT?=
 =?utf-8?B?bFk5YWlrclpmRU5iRWtGdXZFSXRhNkZsS25PWTZCcCs1cndpRE5RVmJvRnEz?=
 =?utf-8?B?dittcXBpdUtKNlU5dEd3dE5GVVFyUHpRUEdlOVBRd0tDLzlJSzNJM1FCVTRy?=
 =?utf-8?B?aS8yTndBNmhmODg0UjFvU25rNms1ZURNbTVlUWduQ1hPMGRGRDI5N2dGRnM5?=
 =?utf-8?B?cHdDWFJMZXcvTWRxUmhYUk1tYnNuamxvOXZqcFJxVW13dm1hM0xJSFQ0eVp3?=
 =?utf-8?B?ckMzK0hzTXBpZzYyMEN6YWRoUWtNeGh4T1pOZUQ1TkgxZG4wQmZmbzFYc2w2?=
 =?utf-8?B?alo1ZnpQM2svRHdHYVVHdTJJVTRia0FtamllVE10SkwwUG9NVXl6WlFyT3I4?=
 =?utf-8?B?R0pCYkk0QTlQUlkveG96T1JyMTdKKzd2aEZvakZyNHNabllBcXNqZVYxN29C?=
 =?utf-8?B?VnNwY2lCZ2R0QUdOcGh4RjZicDFOS2lNQXhhRUpocm1IdXUxdVdNZ25ielZL?=
 =?utf-8?B?L1g5VG5vNERvWGdEcytheWtZOUc1dDFpRFRIc2hraytWUk9SRDVJRmhaWnN0?=
 =?utf-8?B?TEZ4K1VIMVdmaUZVQ2JCUmdVNjFoaHZIbFpRL0dBVVh3ODhjVE5mdUphd0JG?=
 =?utf-8?B?Rjg3WWRqMUZnZkRXWDNVOGtmdnJCeng3MnU2VVNmbHR3bTA5bStHVmZOYWZO?=
 =?utf-8?B?bFgycHVUNzJzWXkxbDZLZS91b3NPaVJJRzV6TU9YMGxKZEx3QzFzbHljdzVD?=
 =?utf-8?B?LzRacC9GbGlQUzRqZkV3cTN0U1lhdnpRbGkyZkxBNldBYmZJV205S3pEYW40?=
 =?utf-8?B?YzNWYnJoZDdTclZIblU0UUVNb3hwT2ZFSzVBNlhCSEtnc1BJQS9nbHU1WGxG?=
 =?utf-8?B?NnBYVzYxWDZNell4QXNqTEJ2dUtGMXJVa3phTnI3bWs0cFFvTDQ3a1FRWTB5?=
 =?utf-8?B?cWhERnk4RDVNRHRJVmoyVnVoQWgvaE8ycmM0VzlUK05nVEp3cU1qWmNGV2h3?=
 =?utf-8?B?a2J2MWY4alhVTzNOL216dDlGOG05bExBZXNPK0I2NXhsRWVCWHVlNmovNFZB?=
 =?utf-8?B?YWNxRTIxQ2dlMHBYZ2lFRWoxaTdtRmxTcjM3V3RFbWtBSldnQjRLc3JMdkJ5?=
 =?utf-8?B?VmFGRmxXRE05RFl5TmM5Z2U0QlFlRXZkS1hNQndZNzdkTENiM3prVG54RThQ?=
 =?utf-8?B?Rjg3YzFyVmM2Tkd4Zm1zb3NEb05nWmc3K3d6eVdFVjNFSitlUWFrZ1oxZk5J?=
 =?utf-8?B?Z2pzY1p1UUhHYWVEK0J6cklSVWU2alQ2Ukl2NjRDekRWaFlnb21uclVVOVFp?=
 =?utf-8?B?UFFTN09HbVEwWFFxemFkUEZacE00V3UyU2RBNk81Y3hyeGM1eU8vSHh6MzNp?=
 =?utf-8?B?T0MvendoRUNudXJGQnpyTXJsMVFNTGRVM0JDM3hpeGxZWDF6L1pzelNnTFJN?=
 =?utf-8?Q?+RysxwZ2StRzaEIaGTvigF4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c33e784e-f787-4b5c-9edf-08dba26190cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 16:13:32.7867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KStn2INvkDirEHN0/R1yeP7i30NPIk/6QRdvhiK1ZMRREAvJ/e4C7kkbwS8EXnNcGIkXUrBN20HgYCE3nYCTSrPuX7uKPaza32uCb26Z1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1035
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D4A3743B433AA64CBC7BFE7346C5E8FA@CHEP278.PROD.OUTLOOK.COM>
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

SGkgU2pvZXJkDQoNCk9uIFRodSwgMjAyMy0wNi0wMSBhdCAwODozNyArMDIwMCwgU2pvZXJkIFNp
bW9ucyB3cm90ZToNCj4gT24gV2VkLCAyMDIzLTA1LTMxIGF0IDE3OjE0IC0wNDAwLCBUb20gUmlu
aSB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAwNiwgMjAyMyBhdCAwODo1NTozNFBNICswMjAwLCBT
am9lcmQgU2ltb25zIHdyb3RlOg0KPiA+IA0KPiA+ID4gVGhpcyBzZXJpZXMgYWRkcyBtb3JlIGJv
b3Qgc291cmNlcyBmb3IgdGhlIFRJIGFtNjJ4LiBGb3IgdGhhdCB0aGUNCj4gPiA+IGR0cycNCj4g
PiA+IGFyZSBzeW5jZWQgZnJvbSB0aGUgdXBzdHJlYW0gdGktbmV4dCBnaXQgdHJlZSAodG8gYWRk
IHVzYiBub2RlcyksDQo+ID4gPiBzb21lDQo+ID4gPiBkd2MzIGdsdWUgaXMgYW5kIGZpbmFsbHkg
dGhlIGRlZmF1bHQgY29uZmlndXJhdGlvbiBpcyB0dW5lZCB0byBhZGQNCj4gPiA+IHN1cHBvcnQg
Zm9yIERGVSBhbmQgVVNCIChob3N0IGFuZCBnYWRnZXQpDQo+ID4gDQo+ID4gVGhpcyBzZWVtcywg
Y29uY2VwdHVhbGx5LCBmaW5lLsKgIEJ1dCBhcyB3ZSdyZSBnZXR0aW5nIHRoZSBUSSBkdHMNCj4g
PiBmaWxlcw0KPiA+IGluIHN5bmMgd2l0aCB0aGUga2VybmVsLCBJJ20gZGVmZXJyaW5nIHRoaXMg
dmVyc2lvbiBhbmQgeW91J2xsIHdhbnQNCj4gPiB0bw0KPiA+IHJlYmFzZSBhbmQgcmUtcG9zdCBv
bmNlIGV2ZXJ5dGhpbmcgaGFzIHNldHRsZWQuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUv
aGludCA7KSBJIGFsc28gZ290IGEgZmV3IHJldmlldyBjb21tZW50cyBzbyB0aGUNCj4gcGxhbiBp
cyB0byBpbmNsdWRlIHRob3NlIGFuZCByZXBvc3QuLiBKdXN0IG15IG1heSBoYXMgYmVlbiBzdHVw
aWRseQ0KPiBidXN5IGNhdXNpbmcgbWUgdG8gbm90IGdldCBhcm91bmQgaXQgaW4gdGhlIGZpcnN0
IHBsYWNlLCBzbyBtYXliZSB0aGF0DQo+IHR1cm5lZCBpbnRvIGdvb2QgdGltaW5nIGluIHRoZSBl
bmQuDQoNCkFueSBwcm9ncmVzcyBvbiB0aGlzPw0KDQpJIHN0aWxsIGNhcnJ5IHlvdXIgcmUtYmFz
ZWQgc2VyaWVzIG9uIHRvcCBvZiBsYXRlc3QgbWFzdGVyIFsxXSBhbmQgVVNCIERGVSBpcyB3b3Jr
aW5nIHZlcnkgd2VsbCBvbiBWZXJkaW4gQU02Mi4NCg0KVGhhbmtzIQ0KDQpbMV0gaHR0cHM6Ly9n
aXRodWIuY29tL3ppc3dpbGVyL3UtYm9vdC90cmVlL3ZlcmRpbi1hbTYyLXVzYi1zdXBwb3J0DQoN
CkNoZWVycw0KDQpNYXJjZWwNCg==

