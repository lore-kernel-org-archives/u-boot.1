Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF110C54E76
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 08:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29F18708C;
	Mon, 20 Nov 2023 09:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="qXqDmnPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48ED18706F; Mon, 20 Nov 2023 09:08:18 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8C58708C
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 09:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1700467694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkmC0E0EvR3i4hT9qWCzYwbBSnOb5dh/QAfGedvJY+o=;
 b=qXqDmnPVfasJWpY5J4Xz80U6NGUhqJ9fS1cGyfPvQf3ZKnp96yC2Xf+0uctoKZKCpbDqE6
 /B8JqmNMgYb6SLY+FJAGDolBBzo/BWRU/eXux67mDG9QJaVtPLtu4P4ScyupAeSWvM7VN4
 rrQWGIEyQ5tP4g3iqc58qVk0K7nCsMg=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-42-JrOKUgCWMJCBH58SyBm1Wg-1; Mon, 20 Nov 2023 09:08:12 +0100
X-MC-Unique: JrOKUgCWMJCBH58SyBm1Wg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB1100.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.26; Mon, 20 Nov 2023 08:08:09 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2%6]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:08:08 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "festevam@gmail.com" <festevam@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "sbabic@denx.de"
 <sbabic@denx.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Topic: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Index: AQHaB96XRXORtSp5rEyqWMgsCwfvILB/DIuAgAP1GQA=
Date: Mon, 20 Nov 2023 08:08:08 +0000
Message-ID: <12f014b9f4899039a9a05251db07942b3335f3d4.camel@toradex.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <20231117194205.GT170968@bill-the-cat>
In-Reply-To: <20231117194205.GT170968@bill-the-cat>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB1100:EE_
x-ms-office365-filtering-correlation-id: 8fec63f4-a8ee-4cd6-2a49-08dbe99fd532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: YqL4S+lVO21SVOFgyoj3sovkGoKHJ2deUSCdXJhTUg/TbIwJzh36dsZF2/oi+cnj/93porcfcSc0n/ShwEIVF66jdvuV7o6PU9hHmhI1790ZQQnvYcT0deGWYjAGZqH+XthnUb26O+K0GC2iR6+Cw/v1Q1CexCUnp4dao/fMr7hbtpADRk5FlpcgFwD2HZg8GOZ/Hb0U+nWKNyx3V0We26R4MUbfK1znTKzmiuVjwct1dIjErfwadmJ9JoRVaqo6PZtkcm1OXEVz5s9u9ozs0S8bea+yfPDRDD+56h7P7zxBAPTvSKqWSt9lukw0eRhozNh5ZLnCE1lKBD2oIk5Un5mJXvI/0dyVBfE+QCHKndoWiEpIIstQebI2dzAD48kktDxfvd6fO0HAubUqR8dQ2ihLHRi4IE+r6ZRNaxPYDIA70JlK6On2Iv8F2zqZ0vrkOuadAykV7oHsNBCe3yechlBwvNl/5WDqH65sl+CYPfK9VRrNkxkoaufF6ZdLrOLjw2VjQZj17ClUCwWks3C+2jKmkjYfX70jBPm1x6qKmkFycAp7dlXttC59XraxqzSw9MsITPRtITz2WjTAUWDD7vZIWblDUKr3Kvdlu8RjJ/Lsuo0SJwt/XB2UCPJJcQeA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66556008)(66446008)(66946007)(76116006)(64756008)(6916009)(54906003)(316002)(6512007)(36756003)(71200400001)(2616005)(6506007)(38070700009)(478600001)(6486002)(26005)(38100700002)(122000001)(83380400001)(86362001)(44832011)(4001150100001)(2906002)(5660300002)(4326008)(8676002)(8936002)(41300700001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXRhZUZpTnJQZGZ2RVRBcVRCSHhuczgyNmdNbDVGV0NUYXlld0ljUkNwUkU0?=
 =?utf-8?B?ZmZUeTd3L0NBRlQ3bEZZMnZHQTllUEZzc0ZNK1BlU2VNQStJUi9RYU5aWU9J?=
 =?utf-8?B?TDJsMVhtUmNxZWpZOVVJc05oeUt1VUoxTGJ0VG5OSXdsamlzaEtvYlZpeFE0?=
 =?utf-8?B?dXQzRHFIbC9xL2swZEQweHF3RTFxZ3ZqempsZ2RMcFRiQjdTa3Fxb2tPQjdP?=
 =?utf-8?B?VmJzMEdMbGtPYjZMZUdDRnV0VGhKbm83aW9hN1k3dVhXWVFkdCt1TUNlM294?=
 =?utf-8?B?dkttdEd3S1MyZGVFL1hQenErNFF3Mi9yd3pxa01tZkJRSTdoYUhGa1lPbWFO?=
 =?utf-8?B?NGVSTlNWZm5uNzBWSTFubkZyVSs3Yzd5UlgrRE5PT3huK0F5VWF6NnB3QzR6?=
 =?utf-8?B?amNjS2xYbnIzc3F3aGZjQVlEdE5adCtiazUrZWNFK3V5UW1zelN1TElGSE1U?=
 =?utf-8?B?dHkwR0NtbFRVSnVpY3pMRVY4MW56dVUxRmtvaW8rcWVVbDk3akRzTXNuUXl0?=
 =?utf-8?B?bFpWMTF0SUJMSHcrdjdrUXVYcHlHWGJOZlU1MjgzWUdOamdSeG9vdUJOcEFo?=
 =?utf-8?B?ZzhMcDQ0UkRVRmx6OEtGTmhxTGRxbVJaWGdmT1FHUldlVXZHNFFaR0xzQkVt?=
 =?utf-8?B?MjhhZ1d1ZGZwWkp3OE9EUitoVkFjL2pxM1F3Wm5MYU1pM3VWRkRrQlFGYXln?=
 =?utf-8?B?TGdDTG1yUVhvbmc3aUxFZjJldW95RkpQMlRoQlR5VE1RWTVHZFFqVEtLMmFJ?=
 =?utf-8?B?NzUwTmxHRXVhd3BlU1oweFdqelN4aU9EY2hyblllUi9kZXk1WmVlQXdUck0z?=
 =?utf-8?B?NW1MUkJER0lRUDZ3OXZxQkRNRW5IZm1kTTRCdGdNZEZNbldxM0JpaGNPYkxm?=
 =?utf-8?B?ZGdGWW93Qk5nSXVkY0dOSjBKWWcyLzZ0Y3FlM2lVLzMrRmI0Yi9lVFZ3djlR?=
 =?utf-8?B?M3p2eSt0VUhKQThyaDRjNW1HdHJjd3FSb09VVVB2VmZPak1OajdsYk80M2hk?=
 =?utf-8?B?dmhTVnR3SllBSjJXakJWbVpLbzNZZWxnK0VCYTBJNGMwakdTQmxxNHpGYzhO?=
 =?utf-8?B?SzdtZ3Q3eHBEam5CdW1wR2dVU01HUld3Y1RoR2pncHZNcjdzbFY4YTJ5TDRj?=
 =?utf-8?B?cERFZ1cxK3Mvdlc5ZHgyUjU4a2lOVjlDdUhtanFtdTgwd1Zsa2NZNHd4NGhl?=
 =?utf-8?B?dEVqZGw4OWpFMGNhMk9HNk5uYVprc29FU1VkUHN5dkJLWUJrd3hIMHRNcGc5?=
 =?utf-8?B?eWd2OTdJNk5EVmpKYTBqOEtxbkVsN2E3RXpkdjEvQklTcEs1UUFlN0o0UGdI?=
 =?utf-8?B?eFdRVVdUMU9TUVFuYmdFTkFndFhheDhrdk5hRm1rVFptUnVVK1FnSXBJRlNn?=
 =?utf-8?B?eTNvN2p5SG9TK090OThOMHROcmxhWGNQbU92WlZ6RTVLUHM5SStSYmo0bXFS?=
 =?utf-8?B?Z0dyNE80RCtKTmsySnBrY2FXdnp2THEraE1idHh3VHNvTi9zeUxaeExpZ1gv?=
 =?utf-8?B?RnhzUmxCK00zUTBZSjRNY0xjbGhJbHVwUm0vc1ljamxtSUJjWnI1ejE0ZXNs?=
 =?utf-8?B?Q1BPb2NwT1VkVTdrSzlsbjBuL2tGY3JxdGFxRmRJcVlqWEJKL2hDTVBOVWRx?=
 =?utf-8?B?bUZlY2xSUmRHdGtwY2JxMUhMYjVHdlAxU1dRNmFneG5EcGlMNDl3N1JhZFNm?=
 =?utf-8?B?MXZDbkhxSGNrOTFPYjEwUXpheFhtZkE0dnZsNkpqaFFDVWdMZEV5UEU0YUMx?=
 =?utf-8?B?cmFnSnd5cmRrSmJTcVJobXZCUkZacktaR2Z2dlFwaUNPU2JCcHdYbkxTaVht?=
 =?utf-8?B?RFJUWWx3ZGYveHpXWEY2ZWxMT2YrUEx1TGYrZjAvSnBMQkhESzRUTzMrUndv?=
 =?utf-8?B?cEY5V2dZOHIwQ2MvSnYyY29mSXRTbFpydHRLT3R4OUw2T1dESk4wR3pTSDVU?=
 =?utf-8?B?QWNTcUdPY1BldlFlOWtVL2cyejdWNWllQmt0RmRaSTJjTVhQUVk0R3BhWTJJ?=
 =?utf-8?B?OU1iS0xJc3BZMTcrdlBMdFZZMlRBNUYyQ0cyNUJQc3d2TTI1TXNYVGxDM3Qy?=
 =?utf-8?B?QnF4ckN6NUd3SzlDZDR4dzlmbkRyeHdyOWFTR0F3VTAyWDZZS1lqTUIyYjll?=
 =?utf-8?B?VGJDMFA5NEptb2puNFEvam5WVnlaK01vY21neTFVM2ZPb0hkb0RSUWtOOTkz?=
 =?utf-8?Q?5AaydjEelPg3SnNmoljODJQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fec63f4-a8ee-4cd6-2a49-08dbe99fd532
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:08:08.8475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Idcs2ggoPZDY1slvnbX6PNSj9LSEQLx9ESVYmXpvZ6fb4NwmmHvZ5tViyhUS5GMIaHshx9KQvS6KVLenn5Z70B37mLntt1MJQ20QAnPfVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1100
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D2BA9EE4DE66294D88A8D69C33EFBB79@CHEP278.PROD.OUTLOOK.COM>
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

T24gRnJpLCAyMDIzLTExLTE3IGF0IDE0OjQyIC0wNTAwLCBUb20gUmluaSB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMjYsIDIwMjMgYXQgMDk6MzI6MjBBTSArMDIwMCwgTWFyY2VsIFppc3dpbGVyIHdy
b3RlOg0KPiANCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3Jh
ZGV4LmNvbT4NCj4gPiANCj4gPiBUaGlzIGZpeGVzIGEgcmVncmVzc2lvbiBpbiB0aGUgZU1NQyBm
YXN0IGJvb3QgbW9kZSBjYXNlIHdoZXJlIHRoZSBidWZmZXINCj4gPiB3YXMgbWlzc2luZyA0NjQg
Ynl0ZXMuDQo+ID4gDQo+ID4gVGhlIGNvZGUgZmlndXJlcyBvdXQgaG93IG1hbnkgYnl0ZXMgbXVz
dCBhdCBsZWFzdCBiZSBmZXRjaGVkIHRvIGhvbm9yDQo+ID4gdGhlIGN1cnJlbnQgcmVhZCwgcm91
bmRzIHRoYXQgdXAgdG8gdGhlIHNzLT5wYWdlc2l6ZSBbd2hpY2ggaXMgYSBuby1vcA0KPiA+IGlu
IHRoZSBVU0IgZG93bmxvYWQgY2FzZSBiZWNhdXNlIHRoYXQgaGFzIC0+cGFnZXNpemU9PTFdLCBm
ZXRjaGVzIHRoYXQNCj4gPiBtYW55IGJ5dGVzLCBidXQgdGhlbiByZWNvcmRlZCB0aGUgb3JpZ2lu
YWwgdXBwZXIgYm91bmQgYXMgdGhlIG5ldyBlbmQgb2YNCj4gPiB0aGUgdmFsaWQgZGF0YS4gSG93
ZXZlciwgdGhpcyBkaWQgbm90IHRha2UgaW50byBhY2NvdW50IHRoZSByb3VuZGluZyB1cA0KPiA+
IHRvIHRoZSBzcy0+cGFnZXNpemUuIEZpeCB0aGlzIGJ5IHJlY29yZGluZyB0aGUgYWN0dWFsIGJ5
dGVzIGRvd25sb2FkZWQuDQo+ID4gDQo+ID4gRml4ZXM6IDRiNDQ3MjQzOGY1YSAoImlteDogc3Bs
X2lteF9yb21hcGk6IGF2b2lkIHRyaWNreSB1c2Ugb2Ygc3BsX2xvYWRfc2ltcGxlX2ZpdCgpIHRv
IGdldCBmdWxsIEZJVCBzaXplIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiBBY2tlZC1ieTogUmFzbXVzIFZpbGxl
bW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+ID4gUmV2aWV3ZWQtYnk6IEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gdS1ib290L21h
c3RlciwgdGhhbmtzIQ0KDQpGaW5hbGx5IG91ciB3ZWVrbHkgbWFzdGVyL3Vwc3RyZWFtIENJIGlz
IHBhc3Npbmcgb24gYWxsIGkuTVggOE0gUGx1cyBTS1VzIGFnYWluIQ0KDQpUaGFua3MhDQoNCkNo
ZWVycw0KDQpNYXJjZWwNCg==

