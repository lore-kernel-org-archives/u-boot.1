Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E171C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200D9880AD;
	Wed, 28 Feb 2024 12:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="gE+IqiRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1294488089; Wed, 28 Feb 2024 12:25:24 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947A08806F
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1709119521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrP40IYjW768fNHhPjUYomj5iLtLtLd/PlZG7BQ7x7Y=;
 b=gE+IqiRCt400lwUBUIvMb34ZRfagDqQWwFTEQ6LYPnYCxU83EbzJMYd+hv6TbKl9ixnSuy
 ldE/pXl+tIuDdrTvIeQ+tqg5hKdXcV1mt8K8TlN9HEZk7PFUldM523/alpG7BjRNs8HzNd
 KRksLJ1NG4z9iIcn8jusMMTNj+VMCKo=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-56-daFY2kRPPZW9J3_H99RW9w-2; Wed, 28 Feb 2024 12:25:18 +0100
X-MC-Unique: daFY2kRPPZW9J3_H99RW9w-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1214.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.40; Wed, 28 Feb 2024 11:25:14 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3%3]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 11:25:14 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sumit.garg@linaro.org" <sumit.garg@linaro.org>
CC: "seanga2@gmail.com" <seanga2@gmail.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "christianshewitt@gmail.com" <christianshewitt@gmail.com>, "afd@ti.com"
 <afd@ti.com>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "naoki@radxa.com"
 <naoki@radxa.com>, "bb@ti.com" <bb@ti.com>, "a-nandan@ti.com"
 <a-nandan@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "andre.przywara@arm.com"
 <andre.przywara@arm.com>, "clamor95@gmail.com" <clamor95@gmail.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, "n-jain1@ti.com" <n-jain1@ti.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, "b-kapoor@ti.com" <b-kapoor@ti.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "n-francis@ti.com" <n-francis@ti.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "mr.bossman075@gmail.com" <mr.bossman075@gmail.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "lukma@denx.de"
 <lukma@denx.de>, "marex@denx.de" <marex@denx.de>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, "trini@konsulko.com" <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "nm@ti.com" <nm@ti.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "cnsztl@gmail.com" <cnsztl@gmail.com>
Subject: Re: [PATCH v10 00/15] Introduce initial TI's J784S4 and AM69 support
Thread-Topic: [PATCH v10 00/15] Introduce initial TI's J784S4 and AM69 support
Thread-Index: AQHaZpYZhGqg4xUhVkW8gjwunFUChLEeYxWAgADfPgCAAGIYgA==
Date: Wed, 28 Feb 2024 11:25:14 +0000
Message-ID: <c701f5c252c7864acfa7007a78b078cd8e0b30b0.camel@toradex.com>
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <4f418aa56f55f984a3c096732eb02124545b79eb.camel@toradex.com>
 <CAFA6WYNLMwy+eWyM=GBuOO78d9ZbytQcWRztFq7nDG8L9mhYSg@mail.gmail.com>
In-Reply-To: <CAFA6WYNLMwy+eWyM=GBuOO78d9ZbytQcWRztFq7nDG8L9mhYSg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1214:EE_
x-ms-office365-filtering-correlation-id: 58e6e8a6-bc71-4195-26e5-08dc384fef20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: AZ1M7WsjCmmhUUxEjbhHwLJ3h32S46P8B0WcYl5VCBFsf1tfsZCIpFhNR0l/f5+1srTi20BSiGhWPEDFjsMbZsrPsMhAQk6vsC3DwXimS4TMylE/tnv0q3Om3XSGvFBQGzVUMalwyYp8KXurGw0lAovDiNdTr6cmZMoHOPOapbJVsWu73OH9PlWvmsbr9cTrShIqsGDsyM84BgkCtDowmWMuzhkFu9KwaLeVOt6+EoMcb9Vn/tZ5n9rDg/ALuU34fdf0CelrSx4+7zLz2pP3QSLsAeQv/963wGiUKyTrHwjWUY1cPdH6b3zxm7Y48dg1Kyc2JAEe+FrufGG3+MTFeMgbeX4pRAVT4QflXlxVJPf7IEerJ685hf/rh0mEqqlDHBrI3ohse9HzhXUbkfPGdWiN/zdIdW/nX5+JJdrUhJ8q+JMc0aGgu1isF7NS3n0h1+eui12VMSOFGCEPIcAsqNicuXS8Qgd2y60E7a4uRE4oPFtisVwR7oB4jS0X6v/L7hkCzfE9TB0/hXa1mx+voTqCErPKSdq7FipXJY04HBJ7j3/Y1Lpk/SgQ53jMMc5qQf2tX5khxe3N40nhGvXKSp7iV6c2ieq/E8BUDOVjIE+g8yRIXxB3Wf8OyMpEKfQpqWgrnXco4x4NaoWXuO6VY1whRa+MbScQT6tliPztk/Rc7LTaZkrXLQ2o/mTaue5S4/g8BZfHmffTYLp8YaOiRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R09lRHMzeXlGK2NQckdrT1l5cVlPQXpkY1Q0THhDTGY4Tjc5QVd0enROcVph?=
 =?utf-8?B?Rkc5Z3ZaUFpETVFmSGFmYkUzNGh3L0pTN1VVUGNvVUdBM0lZd252b1VMWXJN?=
 =?utf-8?B?N3hnVzQranY0cGZhMFdLUWVmN2wyMFJtMGJUOEhqTitUaWNjYUE4VE85djJt?=
 =?utf-8?B?dVRVYmsyL0hUMjhUSUdMUmt0SzNLQllYaU9wQ2RPTkFEQ2hja3ZXTWhsdnJ5?=
 =?utf-8?B?eGtxRGZiZ2E1Vy8vMVVoM0UrS2lmV245VlIvSVhqTVlLaVZZeHB3OWEwOG1x?=
 =?utf-8?B?Y2hkRVQ0R3AvWlZuTG5qRmQ0SUtxSHVLTHRsTEtyVVhWQzFTR3ltS2ZzK0N4?=
 =?utf-8?B?eDdKK2NwR1pvbW5FNHBTczhPR3NQbW5UOUlTNVpUd3dnTzRhdldWQ1Yrd04x?=
 =?utf-8?B?T09wT1BQNFlFZitsTTNObEpPRXJRNlVFbGt2WlVQUXdJTGZxTUtFSmp2VXVx?=
 =?utf-8?B?QjZqTDVNcisvcW1lSTBTc2JNTWROK1oyaERyWWFyeDc1bTU5SDJEOWtlbkJt?=
 =?utf-8?B?c0cwMnVlc2FpeDh4dlQycXA5aXJqdkFKTE5yYWZVcmllTlU2VzJRVW1IbzJx?=
 =?utf-8?B?cUZGOThkL0xPa2dWNnBmb0diRE91Z3p0amRsTm5KbFBLdHBjSXFzYk9RdlQw?=
 =?utf-8?B?UGJJU3lWekEwOXdwNHNZbzNWU2dibTJocDNiOFdDS1kvemtsT3FCeGoweXJI?=
 =?utf-8?B?OGROSHcxb3ozaE5lSTZGRzVvMllmMHhxaElqNVVaL1lheXV3TVVWNWh0MHJ6?=
 =?utf-8?B?Q0tKNElLdHZTcUlLZE8ydWhuNkRJTWhjODhZSDF1THlPVlpHdGNRMm80NUZw?=
 =?utf-8?B?Vks1WTFMb0V2U3lVc3lXL1JIQ3FrZmJCOEFLTW0veXYwdDN5NkJ3cUY1UTVT?=
 =?utf-8?B?L1VKZDNzaWRaWlY3UmJUN1A4OEg1c1RrUzBOOXJqZjY4TkN1OTk5cnUrQnVI?=
 =?utf-8?B?V3M3ejZVV0NWWXYrdmR0eHNRVzc2b0ZSekhjNHJjbVI1c2pXajBWdWV5TDNV?=
 =?utf-8?B?d3U5NDh4VDFCYUdaWWpKSWdubXcrSStxYTBMQVovRUtYcEkrcUF6QnQzV2pY?=
 =?utf-8?B?T0ROaGFCcDN2eDBBb2NUVFVJYTVmRm5tTkZQUDBzajYxd0xMWHF4T0h2VXdY?=
 =?utf-8?B?Ukl0US9Ua01JWjVNa2RsZDBXVllUWjdiRDhqOFdMemF3ditlalJNazJsaE82?=
 =?utf-8?B?a3RtblVWT1Z4ZWV5WkFjTG1sUGtRemp5QzYzWE9nbGUrUzRld2ZJMWZQMU1C?=
 =?utf-8?B?bzhFbi8zMG5lSExtTmNCRWNNWTJERzRmT2RJMklBMmZ6NmtoNjdUYnNRbkxW?=
 =?utf-8?B?TDJNbzU4ZmdyaTFjMC9iWEpCTzlvMU9iZzJXYXBKOC9LOVhqaHRtY3huUFdm?=
 =?utf-8?B?TnlianBMbUluUUJBMXp1TjFJdWJFMzg4K044RFV2RmsrdW9NTUl6c3NsUkMy?=
 =?utf-8?B?cSt5RkplcEVBMnZ4SGhFWjRjalM5ZG9PMFRLdDFTdW4zeGJ5ZG5SeUZ2SWEr?=
 =?utf-8?B?cjdQMzR5OEgrY3RIbFJwTHpTWEtjajUrcXpxdTZieUczRXRjWmhucXIxUlRa?=
 =?utf-8?B?eitUU3l6cUlUOVloelJWZHkxYUJNRk9HMjhPL3R3VGFDbDR0cHkwSFRxZTBj?=
 =?utf-8?B?cVNRNFp5b3F4WmNLTEg0dnJoa2Z3NXpPYXloVjJnd1lJSkRmMjljUkJWMFpr?=
 =?utf-8?B?eitVWGFVbE1GMXp1NGNrZDkxM0Q5bGY4N1pUQnJPZnVZQy93c0F1RjBUTkho?=
 =?utf-8?B?MU0wbmpMcDBvL1ZGSlVKNFVMeHN4TFhxVXRNSGJpckoyVVh3YXlRU2xHSGtQ?=
 =?utf-8?B?cHBqQ0EybmwzeDg2KzI4bXBBVnl6enNUWW9uL25lUFFNVGdDYVdTdWRlbzFp?=
 =?utf-8?B?WG9Xb0ZkdHQzdHdybTl2THkzYStLZUpYRFNpckt6NjArNFRIVjcrZUhTSjNE?=
 =?utf-8?B?OFVpVXp5c0NCN3ZOdC9sMmZIaDF4dDNSbThSdHRxZnhISUxHWDFydUwwQVN6?=
 =?utf-8?B?YUQ3UHd4WksyTnhwbFNIM0pqd2ZYR1NMK3g5QmgydTZPTG8zZkMySEJJSWR6?=
 =?utf-8?B?Q1U4b1ZSdFlNdVZnMksyRWJFekg1UkVRdUp3L29kTXdUVmwvblFUNi9HczFs?=
 =?utf-8?B?NTNMczdkd0s5UEk4U0s3VE1HVXg0ektxVUo1ZGE5MXpGc0pWajIvK2tNQ2ZE?=
 =?utf-8?B?YVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e6e8a6-bc71-4195-26e5-08dc384fef20
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 11:25:14.4770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH064vZ95RUmm+SPPszug3mO+hTEy3mGsQz4DS6rvAppBqhXBHemfRliPvS4rR7o2+N1RhQNx3Q9E9E4/dboDqhvLjtZ3DVp37OmxOAATGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1214
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <3A4B926C545BBE4B8683C81109BBADCF@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Wed, 28 Feb 2024 12:49:49 +0100
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

SGkgU3VtaXQNCg0KT24gV2VkLCAyMDI0LTAyLTI4IGF0IDExOjA0ICswNTMwLCBTdW1pdCBHYXJn
IHdyb3RlOg0KPiBIaSBNYXJjZWwsDQo+IA0KPiBPbiBUdWUsIDI3IEZlYiAyMDI0IGF0IDIxOjQ1
LCBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4gd3JvdGU6
DQo+ID4gDQo+ID4gSGkgQXB1cnZhDQo+ID4gDQo+ID4gT24gU2F0LCAyMDI0LTAyLTI0IGF0IDAx
OjUxICswNTMwLCBBcHVydmEgTmFuZGFuIHdyb3RlOg0KPiA+ID4gSGVsbG8gRXZlcnlvbmUhDQo+
ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVzIHdpbGwgaW50cm9kdWNlIGJhc2ljIHN1cHBvcnQgKFNE
IGFuZCBVQVJUKSBzdXBwb3J0IGZvciBUZXhhcw0KPiA+ID4gSW5zdHJ1bWVudHMgSjc4NFM0IEVW
TS4NCj4gPiA+IA0KPiA+ID4gVGhlIEo3ODRTNCBTb0MgZGV2aWNlIHRyZWUgcGF0Y2hlcyBhcmUg
dGFrZW4gZnJvbSBrZXJuZWwgcGF0Y2ggc3VibWlzc2lvbnMNCj4gPiA+IGFuZCB3aWxsIGJlIHVw
ZGF0ZWQgYXMgdGhleSBhcmUgYWNjZXB0ZWQgYW5kIG1lcmdlZCB0byB0aGUga2VybmVsIHRyZWUu
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBzZXQgZG9lcyBub3QgaW5jbHVkZSBhbnkgc3VjaCwgcmln
aHQ/DQo+ID4gDQo+IA0KPiBJIHN1cHBvc2UgeW91IGhhdmUgbWlzc2VkIHRvIGFwcGx5IGRlcGVu
ZGVuY2llcyBmb3IgdGhpcyBwYXRjaC1zZXQsDQo+IGxvb2sgZm9yIGZvbGxvd2luZzoNCj4gDQo+
IE5vdGU6IFRoaXMgc2VyaWVzIGlzIGRlcGVuZGVudCBvbiB0aGUgZm9sbG93aW5nIHNlcmllcyBm
b3IgT0ZfVVBTVFJFQU0gc3VwcG9ydA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDAyMjIwOTM2MDcuMzA4NTU0NS0xLXN1bWl0LmdhcmdAbGluYXJvLm9yZy8NCg0KWWVzLCBzb3Jy
eSwgSSBtaXNzZWQgdGhhdCBvbmUuIFdpdGggdGhhdCBpdCBhcHBsaWVzL2NvbXBpbGVzIHBlcmZl
Y3RseS4gVGhhbmtzIQ0KDQpIb3dldmVyLCBzdGlsbCB0aGUgc2FtZSBpc3N1ZSB3aXRoIHRoZSBT
RCBjYXJkOg0KDQpVLUJvb3QgU1BMIDIwMjQuMDQtcmMzLTAwMDI4LWc5ZWRjZDZmZmQwNiAoRmVi
IDI4IDIwMjQgLSAxMTo1MzoyNyArMDEwMCkNClNZU0ZXIEFCSTogMy4xIChmaXJtd2FyZSByZXYg
MHgwMDA5ICc5LjEuOS0tdjA5LjAxLjA5IChLb29sIEtvYWxhKScpDQpJbml0aWFsaXplZCA0IERS
QU0gY29udHJvbGxlcnMNClNQTCBpbml0aWFsIHN0YWNrIHVzYWdlOiAxMzQxNiBieXRlcw0KVHJ5
aW5nIHRvIGJvb3QgZnJvbSBNTUMyDQpBdXRoZW50aWNhdGlvbiBwYXNzZWQNCkF1dGhlbnRpY2F0
aW9uIHBhc3NlZA0KQXV0aGVudGljYXRpb24gcGFzc2VkDQpMb2FkaW5nIEVudmlyb25tZW50IGZy
b20gbm93aGVyZS4uLiBPSw0KQXV0aGVudGljYXRpb24gcGFzc2VkDQpBdXRoZW50aWNhdGlvbiBw
YXNzZWQNClN0YXJ0aW5nIEFURiBvbiBBUk02NCBjb3JlLi4uDQogICANCk5PVElDRTogIEJMMzE6
IHYyLjEwLjAocmVsZWFzZSk6djIuMTAuMC00MTItZzg4NWU5M2Y5MA0KTk9USUNFOiAgQkwzMTog
QnVpbHQgOiAwOTo0ODoxNSwgRmViIDI3IDIwMjQNCkkvVEM6DQpJL1RDOiBPUC1URUUgdmVyc2lv
bjogNC4xLjAtMTQwLWc0MDc4YmNkZTkgKGdjYyB2ZXJzaW9uIDEzLjIuMSAyMDIzMTAwOSAoQXJt
IEdOVQ0KIFRvb2xjaGFpbiAxMy4yLnJlbDEgKEJ1aWxkIGFybS0xMy43KSkpICMxIFR1ZSBGZWIg
MjcgMDg6NTQ6MjQgVVRDIDIwMjQgYWFyY2g2NA0KSS9UQzogV0FSTklORzogVGhpcyBPUC1URUUg
Y29uZmlndXJhdGlvbiBtaWdodCBiZSBpbnNlY3VyZSENCkkvVEM6IFdBUk5JTkc6IFBsZWFzZSBj
aGVjayBodHRwczovL29wdGVlLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9hcmNoaXRlY3R1cmUv
DQpwb3J0aW5nX2d1aWRlbGluZXMuaHRtbA0KSS9UQzogUHJpbWFyeSBDUFUgaW5pdGlhbGl6aW5n
DQpJL1RDOiBHSUMgcmVkaXN0cmlidXRvciBiYXNlIGFkZHJlc3Mgbm90IHByb3ZpZGVkDQpJL1RD
OiBBc3N1bWluZyBkZWZhdWx0IEdJQyBncm91cCBzdGF0dXMgYW5kIG1vZGlmaWVyDQpJL1RDOiBT
WVNGVyBBQkk6IDMuMSAoZmlybXdhcmUgcmV2IDB4MDAwOSAnOS4xLjktLXYwOS4wMS4wOSAoS29v
bCBLb2FsYSknKQ0KSS9UQzogSFVLIEluaXRpYWxpemVkDQpJL1RDOiBBY3RpdmF0ZWQgU0EyVUwg
ZGV2aWNlDQpJL1RDOiBFbmFibGVkIGZpcmV3YWxscyBmb3IgU0EyVUwgVFJORyBkZXZpY2UNCkkv
VEM6IFNBMlVMIFRSTkcgaW5pdGlhbGl6ZWQNCkkvVEM6IFNBMlVMIERyaXZlcnMgaW5pdGlhbGl6
ZWQNCkkvVEM6IFByaW1hcnkgQ1BVIHN3aXRjaGluZyB0byBub3JtYWwgd29ybGQgYm9vdA0KICAg
DQpVLUJvb3QgU1BMIDIwMjQuMDQtcmMzLTAwMDI4LWc5ZWRjZDZmZmQwNiAoRmViIDI4IDIwMjQg
LSAxMTo1NDowMSArMDEwMCkNClNZU0ZXIEFCSTogMy4xIChmaXJtd2FyZSByZXYgMHgwMDA5ICc5
LjEuOS0tdjA5LjAxLjA5IChLb29sIEtvYWxhKScpDQpUcnlpbmcgdG8gYm9vdCBmcm9tIE1NQzIN
CkF1dGhlbnRpY2F0aW9uIHBhc3NlZA0KQXV0aGVudGljYXRpb24gcGFzc2VkDQoNCg0KVS1Cb290
IDIwMjQuMDQtcmMzLTAwMDI4LWc5ZWRjZDZmZmQwNiAoRmViIDI4IDIwMjQgLSAxMTo1NDowMSAr
MDEwMCkNCg0KU29DOiAgIEo3ODRTNCBTUjEuMCBIUy1GUw0KTW9kZWw6IFRleGFzIEluc3RydW1l
bnRzIEo3ODRTNCBFVk0NCkRSQU06ICAyIEdpQiAoZWZmZWN0aXZlIDMyIEdpQikNCkNvcmU6ICA4
MSBkZXZpY2VzLCAzMCB1Y2xhc3NlcywgZGV2aWNldHJlZTogc2VwYXJhdGUNCkZsYXNoOiAwIEJ5
dGVzDQpNTUM6ICAgbW1jQDRmODAwMDA6IDAsIG1tY0A0ZmIwMDAwOiAxDQpMb2FkaW5nIEVudmly
b25tZW50IGZyb20gbm93aGVyZS4uLiBPSw0KSW46ICAgIHNlcmlhbEAyODgwMDAwDQpPdXQ6ICAg
c2VyaWFsQDI4ODAwMDANCkVycjogICBzZXJpYWxAMjg4MDAwMA0KYW02NV9jcHN3X251c3MgZXRo
ZXJuZXRANDYwMDAwMDA6IEszIENQU1c6IG51c3NfdmVyOiAweDZCQTAyMTAyIGNwc3dfdmVyOiAw
eDZCQTgyMTAyIGFsZV92ZXI6IDB4MDAyOTM5MDQNClBvcnRzOjEgbWRpb19mcmVxOjEwMDAwMDAN
Ck5ldDogICBldGgwOiBldGhlcm5ldEA0NjAwMDAwMHBvcnRAMQ0KSGl0IGFueSBrZXkgdG8gc3Rv
cCBhdXRvYm9vdDogIDAgDQo9PiBtbWMgZGV2IDANCnN3aXRjaCB0byBwYXJ0aXRpb25zICMwLCBP
Sw0KbW1jMChwYXJ0IDApIGlzIGN1cnJlbnQgZGV2aWNlDQo9PiBtbWMgaW5mbw0KRGV2aWNlOiBt
bWNANGY4MDAwMA0KTWFudWZhY3R1cmVyIElEOiAxMw0KT0VNOiA0ZQ0KTmFtZTogRzFNMTVMIA0K
QnVzIFNwZWVkOiAyMDAwMDAwMDANCk1vZGU6IEhTNDAwICgyMDBNSHopDQpSZCBCbG9jayBMZW46
IDUxMg0KTU1DIHZlcnNpb24gNS4xDQpIaWdoIENhcGFjaXR5OiBZZXMNCkNhcGFjaXR5OiAyOS42
IEdpQg0KQnVzIFdpZHRoOiA4LWJpdCBERFINCkVyYXNlIEdyb3VwIFNpemU6IDUxMiBLaUINCkhD
IFdQIEdyb3VwIFNpemU6IDggTWlCDQpVc2VyIENhcGFjaXR5OiAyOS42IEdpQiBXUlJFTA0KQm9v
dCBDYXBhY2l0eTogMzEuNSBNaUIgRU5IDQpSUE1CIENhcGFjaXR5OiA0IE1pQiBFTkgNCkJvb3Qg
YXJlYSAwIGlzIG5vdCB3cml0ZSBwcm90ZWN0ZWQNCkJvb3QgYXJlYSAxIGlzIG5vdCB3cml0ZSBw
cm90ZWN0ZWQNCj0+IG1tYyBkZXYgMQ0KaTJjX3dyaXRlOiBlcnJvciB3YWl0aW5nIGZvciBkYXRh
IEFDSyAoc3RhdHVzPTB4MTE2KQ0KcGNhOTUzeCBncGlvQDIyOiBFcnJvciByZWFkaW5nIG91dHB1
dCByZWdpc3Rlcg0KQ2FyZCBkaWQgbm90IHJlc3BvbmQgdG8gdm9sdGFnZSBzZWxlY3QhIDogLTEx
MA0KbW1jX2luaXQ6IC05NSwgdGltZSAxMTQNCj0+IA0KDQpBbmQgeWVzLCB0aGUgU0QgY2FyZCBw
cmV2aW91c2x5IGRpZCB3b3JrIHByb3Blcmx5LiBBbnkgaWRlYXM/DQoNCj4gQW5kLCAnW1BBVENI
IDAxLzE1XSBNYWtlZmlsZTogcmVtb3ZlIGhhcmRjb2RlZCBkZXZpY2UgdHJlZSBzb3VyY2UNCj4g
ZGlyZWN0b3J5JyBoYXMgYmVlbg0KPiBjaGVycnktcGlja2VkIGZyb20gUEFUQ0ggMTEgb2YNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjAxMDMwNjM0LjExMjA5NjMtMTYtYmJA
dGkuY29tL8KgYnkNCj4gQnJ5YW4NCj4gQnJhdHRsb2YNCj4gDQo+IC1TdW1pdA0KPiANCj4gW3Nu
aXBdDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

