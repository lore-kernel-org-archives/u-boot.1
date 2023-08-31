Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE3C83F32
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5458586679;
	Thu, 31 Aug 2023 14:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="iFkiupSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284708655C; Thu, 31 Aug 2023 09:37:32 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CAA86558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693467448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxeT0FgoiOrT4YMUo7HWK8iWwZKoFZEuQGBooHZHgYk=;
 b=iFkiupSodKsE2dE02a2XgmiuBpLoHk9222G21Y6x72XWpUhnVn1/LHG/1j97hIzEa0TGeL
 1A3pLu/5JnyOq8oWkjpm5nG15VcmK5awxcMbx/Bzi7IuJZEnCKUkuJn+e6jDv0RHxV6CKU
 b0mr98tYjgIMDIEjQYKp9xEm5SN77xw=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-59-muqo6YCYOvKwCy-Md1pXMg-1; Thu, 31 Aug 2023 09:37:24 +0200
X-MC-Unique: muqo6YCYOvKwCy-Md1pXMg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0079.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.22; Thu, 31 Aug 2023 07:37:22 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 07:37:22 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "clamor95@gmail.com" <clamor95@gmail.com>, "green.wan@sifive.com"
 <green.wan@sifive.com>, "elly.siew.chin.lim@intel.com"
 <elly.siew.chin.lim@intel.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "pan@semihalf.com" <pan@semihalf.com>, "agust@denx.de" <agust@denx.de>,
 "matthias.winker@de.bosch.com" <matthias.winker@de.bosch.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "Gireesh.Hiremath@in.bosch.com"
 <Gireesh.Hiremath@in.bosch.com>, "afd@ti.com" <afd@ti.com>, "marex@denx.de"
 <marex@denx.de>, "martyn.welch@collabora.com" <martyn.welch@collabora.com>,
 "alban.bedel@avionic-design.de" <alban.bedel@avionic-design.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "navin@linumiz.com"
 <navin@linumiz.com>, "mchitale@ventanamicro.com" <mchitale@ventanamicro.com>, 
 "wasim.khan@nxp.com" <wasim.khan@nxp.com>, "udit.agarwal@nxp.com"
 <udit.agarwal@nxp.com>, "open-source@softing.de" <open-source@softing.de>,
 "breno.lima@nxp.com" <breno.lima@nxp.com>, "matteo.lisi@engicam.com"
 <matteo.lisi@engicam.com>, "d-gerlach@ti.com" <d-gerlach@ti.com>,
 "dinguyen@kernel.org" <dinguyen@kernel.org>, "le.jin@siemens.com"
 <le.jin@siemens.com>, "a-govindraju@ti.com" <a-govindraju@ti.com>,
 "patrick@blueri.se" <patrick@blueri.se>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "sr@denx.de" <sr@denx.de>, "michael@walle.cc"
 <michael@walle.cc>, "lusus@denx.de" <lusus@denx.de>
Subject: Re: [PATCH 02/32] spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
Thread-Topic: [PATCH 02/32] spl: Use CONFIG_SPL... instead of
 CONFIG_..._SPL_...
Thread-Index: AQHZ22yoMMOwiNG1u0+c+dVGhhrGtbAEBRqA
Date: Thu, 31 Aug 2023 07:37:22 +0000
Message-ID: <30c990f4f71c166aaa38e25d2360ee59a2cdee6c.camel@toradex.com>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-3-sjg@chromium.org>
In-Reply-To: <20230830180524.315916-3-sjg@chromium.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0079:EE_
x-ms-office365-filtering-correlation-id: 1d29df82-2331-48e0-6629-08dba9f51cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: fBbeIG/41VsBvwW5RdIaKwgX/YTKsuLxOrOGDdmF9pDVb6RYDpLzR0Xh+eGYpkb9yMEsY1IyT7j/cvfHAWT2OKJ2zZHdCYKKasSg+IFDt9FztEhvf2U9EJ2pfw3J+x6dySes3FG71sCylmZNVseia1zSsYGz4SqqyH31hEPBd8Rn20g31H3iUxzF5jOE+B1DL0l8TDxncjGIePm/ZIzqYT7s43hi8a2nx46oTVoZEjKbGX+ewi7fi/PCJpCR3TO64PoifyU4UiUbjOcs11z3VWvmWUVndmLYUuw++tcRslT1krMmwp0zUPflHOckGhrr2cLn5T1edyExSIFkLgxdBlwBLUtod0YrlUvfRsMCT47OSMiMizgGlnV/Wt1jAagfdNkENTGUgOGZLa6UuQP6Ud7A1V54GkKfmZkYESm0VsSgPQT8/hqp8eqrfNQmCwvDPiLrhWOrHWY1SI6Fo+p1qrcbB9Fw0XvxBq9hvlkAwzY39uWSDccaQeeO7OQpIzQxJJnN03SwCPTLTBapNH6Kplqsdq3T2WgZYsgycN+qDBd3hA6+iF4FoZS1p/lgFTJnkb34W7DhCVXUryLumk17AS+K4hZdXgkrg9XOYQ0dz1+c1AiOxblg+zP4MUQNiqTE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39850400004)(346002)(376002)(366004)(451199024)(186009)(1800799009)(6486002)(6506007)(71200400001)(6512007)(478600001)(4744005)(2616005)(26005)(2906002)(7416002)(7406005)(64756008)(66446008)(66476007)(41300700001)(54906003)(316002)(66556008)(5660300002)(44832011)(110136005)(76116006)(66946007)(4326008)(8936002)(8676002)(36756003)(86362001)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTluR2ppVDNTSlA5a2NPMVRDWmllV0V6Rk54Vlc5bDFOVy81eURlU0xDczYw?=
 =?utf-8?B?SlphMCtsMDArZEFxTHQ2OUlvYnQ4UmNGeE5INDFFandKVFV6ZjI1a3ZBQTFT?=
 =?utf-8?B?c3RoWUExNUJFcXFHYmswSXgxRTE3TnJsYmRQV1BReW9BNnhnN3pNVGFiR05I?=
 =?utf-8?B?YVllVWdyc0xlTWl5TTFQZUh4K0VsTVZjelFaRE5MOHdlaG9FejZadVpvQUtR?=
 =?utf-8?B?bGJaSHJGMnh2aklLN25xaGZOc2tMeDI3eTUwOXYwVi9GVHM3dGlYekJaOE01?=
 =?utf-8?B?QjgvcVU5R2h3T0xOYTlnamhaMmNtWDNvbTBGRlZ6amhKbFhnVUlKMkgrVC82?=
 =?utf-8?B?WXh2MWJjV0pSaUQwZWdCR005dnd4anJhOG8zL2lRRStVOGM4MmpqMGdkdzVH?=
 =?utf-8?B?QTJ4ZzRuYythN0lTOFJjSW43WFVuRUZtRk40cXZiTyszdVoxVXhjYlo2TmhX?=
 =?utf-8?B?MkphdFdQVDdOdDVWUG1uN0kvV1FvcmpMSnp5TGhVNTJMZHBnRFcyNFBOVUNz?=
 =?utf-8?B?dEJPVi83RTRiZ0RKN3c0SkVFV1hsR3FnbnBUbXBHaGdBa1BIRmROZUoxMFhx?=
 =?utf-8?B?cWE4dTYyUkxQQlo3MjBZMGo0eFV2d0kvNCtlNU43NHBwbmpJMDd1RnJKK20r?=
 =?utf-8?B?aWlDVE5VTkpoUW5yYkMxSkFwTGZhOVhqMEpWTkFNQWNJY1k3TlhnR0hSUVBV?=
 =?utf-8?B?VTBIQUF5RHdCVEI1anZhQlpNYStKUERaN2F5ME1OYjNOalpEaGVNdVlGMGxr?=
 =?utf-8?B?c0RYR2NRS2VxWC9WdTRCQzg2dnhnL0t5NFhKV1JJdVQ5N1Jra3pTcHF5NnEx?=
 =?utf-8?B?U0VoYjlzakx3ZDlBTW00YjJETElpMUhlNkQ3eEFDUHkvNWNIZWhwRU5QVFA5?=
 =?utf-8?B?YzVwdmQyYlNzU3dmYnhaRVhDSnZVQ29TSVl5WUw3UzRtQmVqeURZQ1FFQzRW?=
 =?utf-8?B?NUdNV0Y4cnFWOUhncnFhWjBOU0kwNStTVzA4dkM4Nm9tWkdnMnVsc3NJOWc2?=
 =?utf-8?B?cExoSC85UDRJWk9PbUc2MHVzdkFWKys5bEg5SUlvMWZ4ZDIrdkNzUSt0ZmFT?=
 =?utf-8?B?M2tiUWRNVDFKQ052eUc2WjNnRHJRN1g5bGkycUN2MWNGMFhuSzVKOHNab05h?=
 =?utf-8?B?UkVRUlJnWjhKZy94SDBaMzV3RFFIaHZIV1REbnpzVzRmRmI5YjBmcEI0dHIv?=
 =?utf-8?B?RWtiSFdFRlJUdnFuc2h5VjB4cXBGWDRLUHJaTjNCTks0THoyc0U0QWpUTzFT?=
 =?utf-8?B?V3pjR2tlWnJWMEtwb051TEs3REFTdTdoM1htZUJVaHhxbk1YUmZ0MC9JYjBl?=
 =?utf-8?B?NFFEcEh5QlhXWnp3dUl3ZmFkelZYS2xqRlNhaUg2VFkwZjMzaW54TTI1R25x?=
 =?utf-8?B?eVNGaDRGZUNVMHhnYkFhQzBSenZUYzczQTh2R2JMWEp6SGhrUEVkWE1YNkZ6?=
 =?utf-8?B?ZnZBMXZ4Y25XMUtQTkFDcVRUVkNJUHlRTVUyWXVsakMrMWNjcktLSG1JOHVJ?=
 =?utf-8?B?Sy85QlZCZUJrYkdveFFmTnRZdk5TbXo4VEFabUlNeXVGNGY1N2Z0SXd6VDlW?=
 =?utf-8?B?U3l2SzVHODZmSk5XNTg1TkM4ZUtxMml0TTU1MXk5SitFcExwY1dBVkMyWFJt?=
 =?utf-8?B?U2lRVXJlZzBmL1ZXeDJRd0RiN01GbG9UMnc2ZjVuSzNiaVBpNGlQeE83YUVI?=
 =?utf-8?B?YnFOeUVpNklXWlBvcmt5YVd3NzVvcnFkL1h5KzRyUkp6N0lVYU9ycFY3MW1o?=
 =?utf-8?B?UlRHbVhTZ21aa2RMRVJvc1ZVWW1UdHpVbXdKQzBWdGh1cnVNbGxtUEZ3SGNk?=
 =?utf-8?B?TkhzSjMwbmZNMzRnZEtDQnlVUURxcTVxem91eFdjZkNRaW9RakZMNUM2Mm1x?=
 =?utf-8?B?UVJCSWFEYmhUeW9zSThLam1QcjdHd1piTnJCKzJybnNDT2xSZVRTcyt2MGRq?=
 =?utf-8?B?T1Bya3NVTGhvWGJPYU9lNVJZV3lFQ2c1RVFsM250ZnlRclR1S1FVLytqcWU5?=
 =?utf-8?B?bC92Y05ndXRYTnZlMWg0aUpFNVRMZnU4bTV5VHIzdTVuNmJsVjJhZDNPeCs3?=
 =?utf-8?B?Nm5LbDVrNW9mdjFhaVhOQW9tam5zNjloNHlXYXA3NlpFbG9wdU5jL3k1NGF5?=
 =?utf-8?B?aWR4V0EvWnZpbVM0UlFBaUVXblZSeWxyeWdtTmI0bk1sOFpzS0tVM0YwMWZx?=
 =?utf-8?B?eWc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d29df82-2331-48e0-6629-08dba9f51cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 07:37:22.1611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKOf9QoZz79lKGYEkoOEv0vYxeQGdtyqYXRfpYm2gCFc8ogHJICFu4+mObTrpwqVIcjGnMOsnWy8ea4D2qYAdyRd3qjmKnIWdieL1CmMMt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0079
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <906CDE9710C7B74F9A7E12B5F695DF63@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

SGkgU2ltb24NCg0KRm9yIHRoZSBUb3JhZGV4IEFwYWxpcywgQ29saWJyaSBhbmQgVmVyZGluIFNv
TXMuDQoNCk9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxMjowNCAtMDYwMCwgU2ltb24gR2xhc3Mgd3Jv
dGU6DQo+IFdlIGxpa2UgdG8gcHV0IHRoZSBTUEwgZmlyc3Qgc28gaXQgaXMgY2xlYXIgdGhhdCBp
dCByZWxhdGVzIHRvIFNQTC4gUmVuYW1lDQo+IHZhcmlvdXMgbWFsbG9jLXJlbGF0ZWQgb3B0aW9u
cyB3aGljaCBoYXZlIGNyZXB0IGluLCB0byBzdGljayB0byB0aGlzDQo+IGNvbnZlbnRpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCg0KUmV2
aWV3ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
DQpbc25pcF0NCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

