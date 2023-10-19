Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900DFCDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 11:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C49A86FD5;
	Thu, 19 Oct 2023 13:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Swk1Kbn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDED6871BD; Thu, 19 Oct 2023 10:59:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360268715C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 10:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.ivanov@suse.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8tnbBlodanBnm3HBPtNzVorUOawX8hS1NVJEU00iIb5wf6S/mZKKGHK4AnaQwKtP9H8Gxd9RDe+tqNc7oCwx2GiK+feEniWbJjNfMKdG2MGcBe16zHQFwSbP1PjkTnhexSdBEWoBN8AxHC5LkmyDV+3wTbU1GQYt5779vMqJxtelXrU6/1UK4v9LA1CqUMHizkDVfSC+UYp/Yz6hKW/ScQT7CMSEXMHqPl9I7e68XLFsj7/kHyXNH/hKwFdiF68p9VdLS69Y9+wLSX3tYvVjhhucoXoGdhiocGhW5H9SAnv7vXRQXXjUWyK8Ljza0q7sgI2/w3xnFwX/uLek+udfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQvdbpNRhq6ZooIZN4s7EdGBuJteKlTTM864txKpDuY=;
 b=nZ2qfbaYv2XXS/99n7sy+RB7AdV8utPW3ZVdw0LhrVJ33c2tM5EV1CA6EXTs6/FKG3rmDWLtsb8Ru3afzT2p7b79yIVEOu6ZEVPQr2ZZZczMyfOpqK1oXSQ2c+ZpRNmIPyLtrE0e2YOwP4z/MTnFHTMYq910ZJGrkFOeppIgKt98IGoFTtmf4V+YmT8vH+/WFWQ9HbUwsYUdXiu1Tp1brlc620+FiRMoFwALrkBQLNhxYMfNBg4kS8oVGZMSWYOmAxzZidB/FkxY6HkU7C1BwVAF5Ulx7Hwp+dV1q64kAIPpC4xaCk4IlDs6kIJxwpZaXGJ9UTPIMUt4fWxKzR7oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQvdbpNRhq6ZooIZN4s7EdGBuJteKlTTM864txKpDuY=;
 b=Swk1Kbn0qaJqB60N9FTZT1dhs1AqX5IgT/NmzyrSO0i89AEqT9gWL31i1Tvg/DCgJtGWhy4x1dzkR+3qiYC2l4Gs/V2/XPd0hjzCQNHVnJmED1AuaPxseGzud1Ysogh0YqO4ZHQb/B3KcinRL0V/YRqJ7ObIY21l7WMgVCC/hsK81DBxDHWGPZaha9H0OPe9Nkccrd3hFhfsgBj82fYVmaJS60AAXX5ofkV2C3TCUgLPWNqlXN+qne2PBzZt0CfNxF03E3AYyzwu6wzddZlwLb5r7vVlJ/xai5AZQNH+TO2SdKfZOJZE2r0TLpfvRJ/oYapXthnUl/PgDy/TcEGUPQ==
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Thu, 19 Oct
 2023 08:58:55 +0000
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b]) by AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b%7]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 08:58:55 +0000
From: Ivan Ivanov <ivan.ivanov@suse.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: Guillaume Gardet <Guillaume.Gardet@arm.com>, Matthias Brugger
 <mbrugger@suse.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxargACOEoAAAB9fxAACSUYgACMvy5QAStVywA=
Date: Thu, 19 Oct 2023 08:58:55 +0000
Message-ID: <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6839:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: ddf3fa32-e403-4bb1-509a-08dbd0819fa8
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xvfXXT5qfQYtMfnUBrssVxyuAQX8ZiWv0FYutnC2OVVQMHbcVr6sNSK+PsbZG6dRGeYee7XQJiUywTl2wlJuUWhRYbUuAEwxM6hQRltx1k9dUFRfGiNSWWu4N7vbTRiSejOh2+EihEExx/EDd4ufUhJ8Q2PVnxxB1G7iR/JHtGDS8+Rucb3+2alLs23wKwnHBlbOG1JOr1VA2ZnJ/W7WlircqF7SUd+kx6iVJrJtrARgMoCbUlSG5fTv3xY5JSFHXlLQmiQuN84fhqqbgRTTvgXTpCRGbB7u8JVPm+j/1PsH/VlMITJOmymeSv+ioV9Z+8NYR7azSU5QknwK0fE/7wXNG9LCcFek+/W1xqA8vVkUbySNMuTa/b+IlHY0jmwFo0gQfVZiazgZw+XoYkZ/rQTGLE5ciQC1TXvSboiRVUI1MASCw3hshTIqNXGfp5+1hhCuay5uPQ6UeriQ97Cyb9/SA1WpWHuboqbn/zodIbqKywfn4vjkphyov/ytO8WUm1hAkPZcg1gTRjeYkwtjjfWUmReghbaDiEuBUQF2/FzR9luKOJE4Ubhm+0zBmi2mZEsMS5jZpXFzp9YSANeyctZgZLgq/Kd9/FFHBxpTkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6839.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(76116006)(66946007)(66446008)(91956017)(64756008)(54906003)(66556008)(66476007)(316002)(6916009)(71200400001)(6486002)(478600001)(966005)(8936002)(5660300002)(44832011)(41300700001)(36756003)(4001150100001)(8676002)(4326008)(86362001)(6506007)(38100700002)(38070700005)(2616005)(6512007)(83380400001)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkdvUTNrL1E4RWtBM0loMGFmeWxMdFJVMjk5Rk9xR01GVGVNdEQwR0NYNlFy?=
 =?utf-8?B?L2xyZE9FVFNyLzZZRHM5aFhoTnhCRktyc3Zpck4zQ0dsN01aNis5RjFnMjJU?=
 =?utf-8?B?RkRta0lScnFkNlFaN1BGR1dJU1BrMnFGYjJOTXZoZHM4MStLZHRtTHBaMXVS?=
 =?utf-8?B?d1BuVWMvTDVJMCtxWDJXeFdCN1NPS2x0dWhLVlNJb3lWWWxyczBQMlRucGpC?=
 =?utf-8?B?TjFJNjR5N2Q5MU5TVkVmTWFzbEdpRFdHbVQ1UU95NU00NDVJOTl5TjR5OUVF?=
 =?utf-8?B?VWxYVHhyYjlzaFVsYVlUekVtZGdQM09hTXlqZzBkLzVKUUxoR2J5aE9vOGVN?=
 =?utf-8?B?M0FoWTg4ZHVFd0pIWHVnMDBic2xuRlQ3bzRhTU12VStXNUFnT29od1FXK0c3?=
 =?utf-8?B?REVENWttZUx5U1puUWVJN0VtbEJGNlpRd1UxayttaWprdS9HelE5QnMwcFgr?=
 =?utf-8?B?WG9ISkdlc2JHRWpIeS9RQWE5QmVXUUFrNFF6eGd0cG4vaUdPU2FZZWExb0Jw?=
 =?utf-8?B?ZlhJZys4UGM3bkQvYmY4clFIZjFsdkQzaWtrb0w1bVFiRTNoSmlUdzVKMmM1?=
 =?utf-8?B?bGJMRGEzQ3NHT3ZrTEpISU9mbUR2R25NeFdIZzkwSUpaR1hrU1FWK25sN2hn?=
 =?utf-8?B?S3I1WEJuZ2RudDZiUlNDbDJYVmdQVkcxTmo5S3ZSdndFT0l4di9VR3R0cnJ1?=
 =?utf-8?B?OVU5WGY0VWpFNEtWdzIzbFhuUjFTQ1M5aWkzZEhFZ0hQS3orbHVlZnR0MEVw?=
 =?utf-8?B?dEcwS1h3Z2FiTWZPTzhTY1ZNZTkyQitoa3NhS21ZUXQ2aE5XVU1POW9NTUtN?=
 =?utf-8?B?SXNTMnpoWWoyR243OGVGSW5kQSttVC9mS050MDFXMklGVGhvc1NtT1Rsekdo?=
 =?utf-8?B?a3E3NlN4a21FUnQyQTNPNE9rd3c3eklLbEdybXpCNzlCSmtuQ0o5MGxsem5I?=
 =?utf-8?B?K0ZvYlIwN0FGb0IxcXRLWUErUVNwUXhuV0hWcVlnN1dsSHVIclJ1WWZ4VStl?=
 =?utf-8?B?blhQOGdxN01mL3ZrRlFsaGhlN1VuN1h3OGxYWDFwNjBWSVZQZHdDS0YwenVE?=
 =?utf-8?B?aVg2MzZRZFZkN0xQUHI0N1BtTVNFd0duVXlsYmdHbE9TYjhObDR0Y3o1UEFB?=
 =?utf-8?B?QlBuU2tCZ1RucWpTNTdLcXl4YWhJSGZnTFBGTVNscjY4MHNpNTNGQ05yRk1C?=
 =?utf-8?B?a3R5dDZld3FOSnBlTzJOakQxWmxUNFJkcTdCSFNIRUREVU9rZ2p1TkxXTVBL?=
 =?utf-8?B?YVFEbFJtZXZtdnZheG1kZWYxOGZGTkRtNTlaMC9INnMxdTFpQ01CdExVa3RM?=
 =?utf-8?B?QnpsZ0x6TDk0N0ExREFwRHlac2NQSko5TStxTjE2MkRWWE1seXNaK25LNVhF?=
 =?utf-8?B?KzNtL1FER1phTVcyVjVsSVEwR1hEdVJUMzBFazBRdmpYMmZGVCtYTm5TZWY3?=
 =?utf-8?B?QzR0SGNlekVSRWlGbDBrYmdCVmxwWUllZHArc0lERzNmWDBnNkR3YVpORklF?=
 =?utf-8?B?N3FrSVlqdEFzL1FqZVNLbkhVMUMycDFEdk9xOFZNeWpOUllPU3MwM3Jpc1lZ?=
 =?utf-8?B?VE1GL3JqN2RXWnEwOHQvV2Z3RDVLNE91YjFJbFBEVnZ6S3FnVUQ3NUExTzUr?=
 =?utf-8?B?eE1wWDB6ZkRoMmFaSk1FaUgwSjBaOWk5cDZRaUdHMGwxc1RzVWkzL1VXRjh6?=
 =?utf-8?B?eVRYLzhVMjlGVmNrNFczZXBFbzdNamRYSXhtU2k2QmZFajdhYkpZcEdjc3JY?=
 =?utf-8?B?MitwQTc5YlBwKzk5bnNuZDFiZG1yV2xkaUZheXpYUUdkTjF3V0ZpNDlDVkVS?=
 =?utf-8?B?SWxPUEhvVE9OZlgrM1BHSVNFNmlUUXpHRktPdjNRUHBXMXQ5STkrNVdqTnV2?=
 =?utf-8?B?WEV6L0paeHhCUlFYWDBLY2JXOGMvMmNHa0JZUEVqYTBobk9YalQyRmk0UXNK?=
 =?utf-8?B?TnRZc0FTMmluR2swUjhMT1FZR0plY2M3YlR0K3ZkUUpZSlFxNU92bmhMcmJw?=
 =?utf-8?B?Q3o5NGdKeWlCdDBPZ3hvZytWMGVUZXhPY2p4ZXdQMkRYNTBsNTNjZEFTTmVl?=
 =?utf-8?B?TGRuZGRzQ1BoYUVjTmRucWNnbktDaVJJTlhheHZiWnVCb2tvbkhZZFN6ZFJH?=
 =?utf-8?Q?w5pcTioU3Tds6f3L1jxWLwRm8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B143EAC6E734F4D8B93F2AF9868EA68@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6839.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf3fa32-e403-4bb1-509a-08dbd0819fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 08:58:55.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKZBZIOXSgw7gQWAbQxLsOz0phsxXCS9vCzHFk/rBpC3Hdp3zL4jBTyx0CCPGdDudYbLPSwDtRCNr/a50yOHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918
X-Mailman-Approved-At: Thu, 19 Oct 2023 13:18:11 +0200
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

DQpIaSwNCg0KU29ycnkgSSBjYW4ndCBmaW5kIG1haWwgdGhyZWFkIHJlZ2FyZGluZyBwYXRjaCBp
dHNlbGYsIHNvIHVzaW5nIHRoaXMgb25lOg0KDQpPbiBGcmksIDIwMjMtMTAtMTMgYXQgMTA6MDgg
KzAwMDAsIEd1aWxsYXVtZSBHYXJkZXQgd3JvdGU6DQo+IA0KPiANCj4gDQo+IEhpLA0KPiDCoA0K
PiBJbmRlZWQsIHlvdXIgcGF0Y2ggWzJdIGZpeGVzIG15IGJvb3QgcHJvYmxlbS4NCj4gwqANCg0K
PHNuaXA+DQoNCj4gDQo+IA0KPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L3Vib290L3BhdGNoLzIwMjMwOTIzMjA1MDE3LjE3NTQzNDAtMS1zamdAY2hyb21pdW0ub3Jn
Lw0KPiANCj4gPiA+IA0KPiA+ID4gWzFdIGh0dHBzOi8vbGlzdHMuZGVueC5kZS9waXBlcm1haWwv
dS1ib290LzIwMjMtT2N0b2Jlci81MzMxNTguaHRtbA0KPiA+ID4gDQo+ID4gPiA+ICdnaXQgYmlz
ZWN0JyBwb2ludHMgdG86DQo+ID4gPiA+ICoqKioqKioqKioNCj4gPiA+ID4gY29tbWl0IGM3NzFl
NWI4YzJhMTg2ZmIwNzJiNmM2ZjU3MWQ0YTNjYzg2ZWZiYTkNCj4gPiA+ID4gQXV0aG9yOiBTaW1v
biBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gRGF0ZTrCoCDCoFRodSBKdWwgMjcg
MTU6NTQ6MjggMjAyMyAtMDYwMA0KPiA+ID4gPiANCj4gPiA+ID4gwqAgwqAgwqBhcm06IHJwaTog
U3dpdGNoIHRvIHN0YW5kYXJkIGJvb3QNCj4gPiA+ID4gDQo+ID4gPiA+IMKgIMKgIMKgRHJvcCB1
c2Ugb2YgdGhlIGRpc3RybyBzY3JpcHRzIGFuZCB1c2Ugc3RhbmRhcmQgYm9vdCBpbnN0ZWFkLg0K
PiA+ID4gPiANCj4gPiA+ID4gwqAgwqAgwqBXZSBkb24ndCBuZWVkIHRvIHNwZWNpZnkgdGhlIG1t
YyBkZXZpY2VzIGluZGl2aWR1YWxseSwgc2luY2UgdGhleSBhcmUNCj4gPiA+ID4gwqAgwqAgwqB1
c2VkIGluIG9yZGVyIGZyb20gMCB0byAyLCBhbmQgc3RhbmRhcmQgYm9vdCB1c2VzIHRoYXQgb3Jk
ZXIgYW55d2F5Lg0KPiA+ID4gPiANCj4gPiA+ID4gwqAgwqAgwqBTaWduZWQtb2ZmLWJ5OiBTaW1v
biBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gKioqKioqKioqKg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhlIGZvbGxvd2luZyBwYXRjaCBmaXhlcyB0aGUgYm9vdCBmcm9tIHVTRCBvbiBS
UGk0IChub3QgdGVzdGVkIG9uIFJQaTMgbm9yIFJQaQ0KPiA+ID4gWmVybyAyIFcpOg0KPiA+ID4g
PiAqKioqKioqKioqDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9yYXNwYmVycnlwaS9ycGkv
cnBpLmVudg0KPiA+ID4gPiBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuZW52IGluZGV4IDMw
MjI4Mjg1ZWQuLjAyMjEwYjk3YjUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2JvYXJkL3Jhc3BiZXJy
eXBpL3JwaS9ycGkuZW52DQo+ID4gPiA+ICsrKyBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGku
ZW52DQo+ID4gPiA+IEBAIC03NCw0ICs3NCw0IEBAIHB4ZWZpbGVfYWRkcl9yPTB4MDI1MDAwMDAN
Cj4gPiA+ID4gwqAgZmR0X2FkZHJfcj0weDAyNjAwMDAwDQo+ID4gPiA+IMKgIHJhbWRpc2tfYWRk
cl9yPTB4MDI3MDAwMDANCj4gPiA+ID4gDQo+ID4gPiA+IC1ib290X3RhcmdldHM9bW1jIHVzYiBw
eGUgZGhjcA0KPiA+ID4gPiArYm9vdF90YXJnZXRzPW1tYzAgbW1jMSBtbWMyIHVzYiBweGUgZGhj
cA0KPiA+ID4gPiAqKioqKioqKioqDQo+ID4gPiA+IA0KPiA+ID4gPiBTbywgdGhlIGNvbW1lbnQg
ZnJvbSBTaW1vbiAiIFdlIGRvbid0IG5lZWQgdG8gc3BlY2lmeSB0aGUgbW1jIGRldmljZXMNCj4g
PiA+IGluZGl2aWR1YWxseSwgc2luY2UgdGhleSBhcmUgdXNlZCBpbiBvcmRlciBmcm9tIDAgdG8g
MiwgYW5kIHN0YW5kYXJkIGJvb3QgdXNlcyB0aGF0DQo+ID4gPiBvcmRlciBhbnl3YXkiIHNlZW1z
IHdyb25nIGZvciB0aGUgUlBpNCBjYXNlLg0KPiA+ID4gPiANCg0KSSBhbSBhZnJhaWQgd2Ugc3Rp
bGwgaGF2ZSBhIGJvb3QgaXNzdWUuIFRoaXMgdGltZSBkZXZpY2UgY2FuIG5vdCBib290IGZyb20g
VVNCLg0KRGV2aWNlIGJvb3Qgb3JkZXIgd2FzIGNoYW5nZWQgdG8gVVNCIGZpcnN0IHRoZW4gdVNE
LiB1U0QgY2FyZCBpcyByZW1vdmVkLg0KDQpQbGVhc2Ugc2VlIFsxXSBhdHRhY2htZW50ICM4NzAz
MjEgZm9yIGJvb3QgbG9nIGRldGFpbHMuDQoNCkkgaGF2ZSBub3QgaW52ZXN0ZWQgdGltZSB0byBk
ZWJ1ZyB0aGlzLCBzdGlsbC4NCg0KUmVnYXJkcywNCkl2YW4NCg0KWzFdIGh0dHBzOi8vYnVnemls
bGEuc3VzZS5jb20vc2hvd19idWcuY2dpP2lkPTEyMTYwMzYNCg0K
