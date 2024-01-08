Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C939C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972A887A7B;
	Mon,  8 Jan 2024 18:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RAO2HrXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6AE87AB4; Mon,  8 Jan 2024 18:22:09 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7486087A7B
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL65QwqE/SuZDHO553Y5/rOmdoa1vwkIEDai4dcMXen2lJeNktuWJ+721L0Zv/SjxSFwx8naOUQ/Os6PoL8WsjwoyFg1MhhuMdjMo3Y7ZE4+2RSHYBs1edHsuBPl9JCM9tAOrywwb9NAAGM6liMSe71k+bh2rcmVdBS30JQHvZlYHlOncujMtxbQoYiQweRltUehkghtRMdx20iQ0xJ5zzrnUsKQMvseyVAdVl7O8FV/SIy+aIjJy09o4ZyiwfNjxNApoHnslkweuGLfmEeu3GWK1PJvf/v8WgG6A9AHgLoqipzj46iD2pSjqo0/BWko78bvWG6U5jfCd4B7jyAqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvmGkxTd41yGj11l1vl17Fg0Ps2WUc/LI3WKoqaKB84=;
 b=Ini1+uXG5NPQSVXhwkh2OxXeuKk9SOydUJfGeAIusq9az4wG3ysiKea+5FVjFZ1x86J+hOx0UtYnMJ/vaGK51M53GwgPByccUFtEFARDnp6Gvxnb1SMRlP2pY7Dqss2dxDEbx/KGydVc5qP8CCfhp6YHWLe/vkI0NrSV0picExoJUiewrlNK+T651SS94in+jh61qdhGjbRgeMXdJzMolWk7pswodOHEjw/CTgkjToAJxyy7hM0gC7BDQcQCvTlWqBL5te4II1Jfs0NP0er8MmL0QpeUt6SagpOGNGyXeBENfFzJFG8uAQ7DBgHGAkVMfe1kq8XWTGJZfhvst/cpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvmGkxTd41yGj11l1vl17Fg0Ps2WUc/LI3WKoqaKB84=;
 b=RAO2HrXKxe9Ilj1jwBf+iJGSjxMBx+zHFVhZos8KrvmBnAIiBY9chaNIUX7BLxDnss75SQaktahR1levjibyUW+92NoS5MQIPC+pnwTjXZPu2byoA7tBTI1CR3VXopYy+B8jwb3vKnxBggDi6s2F/c57yO2m8S+wWYufz6A6/hpKzwzXm2GgJKRhYcDnQkIxo/iLEuMPwQrETzvXVwtBeFj+E2uAvYJ4tyjl4AHSK4N5ktmJkvVBtkbpowsQOi1F6XuP5JPGvaP7Usmg7HDauA1px/oNazim3da/yB4TsjUedG2kU5w75uunoYVnw39APEDwDxgH2oPQ72Nfij8j3g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 17:22:03 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4e3:6357:166f:b46b]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4e3:6357:166f:b46b%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:22:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico"
 <enrico.leto@siemens.com>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v4 2/6] siemens: eeprom: simplify setup & read
Thread-Topic: [PATCH v4 2/6] siemens: eeprom: simplify setup & read
Thread-Index: AQHaPkk7zWToqm7v2EK4ATjtp1uWVrDQMc+A
Date: Mon, 8 Jan 2024 17:22:02 +0000
Message-ID: <316a3ff010e3dca01f568103f2b4fe1c5a481a5e.camel@siemens.com>
References: <20240103133154.152886-1-enrico.leto@siemens.com>
 <20240103133154.152886-3-enrico.leto@siemens.com>
In-Reply-To: <20240103133154.152886-3-enrico.leto@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6871:EE_
x-ms-office365-filtering-correlation-id: 96813277-1d32-42d2-1cf4-08dc106e5433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lldUHSXYEoKVmcwHhJIXU7tJKZiDL+p9qwnIa8X1wldhDx6q22809UYdbJw5P891Y9qCpLO7/eozpYqamGc3YzbrvQ+s3W9uNGSKlVctyRplHLeiX+31IAaJGBQruo8JdS0z2afRF4LryqsyOflWtvfTYQSjr7f2QVpirTZwWV4gge8X8cEO8QXu4TgAQsF++OO10beG7eip3/eShEy3yczWB1hXZ1D0gsRdoncv6IwSPVjHDSTN6Y0qSho1rB3vKtR74lOgL4MMzN5LZplTFWvs8JrG08WSHyxHNw80o/dx0vPa8cL1teYuVppkZun/VDMEpnKGeF+03GBJa22Y5f8qDpDONE+Va+8iynKIygODHKp/9vp/9sGaUF7qqBk+j/7tX1iWrPtscd9nhLu1RBq9eJ03nb9O303fRgEZPFx5ff9YTB2lXWFS8EronP5ianU/lMHLUDVhVsvN60ofaTK6+5y9LlBqyaWmMkSRbXZJhnyjNBMC6gpgHdnoXlb/iqFmXi3jXAGZGy9GoQRJ4Hx/gx5ismI53JQwxE/X2f5+QSh5H3Nu/APfevWJrp4LvnNsAe3srY6dZJ/ZHHVXUEXd6CET8k9CC7BIUHuyU0Ys39DEFZ9FazSS6WBLPPYvLDyGbQcLSk2Pleg2AyBscA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(71200400001)(83380400001)(15974865002)(36756003)(86362001)(38070700009)(122000001)(38100700002)(82960400001)(5660300002)(4326008)(4744005)(6512007)(6506007)(2616005)(66556008)(64756008)(66476007)(6636002)(76116006)(66446008)(110136005)(316002)(8936002)(8676002)(66946007)(91956017)(2906002)(41300700001)(478600001)(6486002)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXRzZmxFMWNzOUpRWlpDM256SDJxU0hPSWF0RWIzanF3L1pSdTRiSlRNVDZG?=
 =?utf-8?B?LzRVNXNmUGpvYTEvc0w1NWZhVUdHMHNDUVVsT250eXBiaE0vQ0piNitFOFBE?=
 =?utf-8?B?VjBzMVpzZEZTNTJ1Y3I1VGxzVTdGRDVRdWJSblJwc0xwNVJpczNFbWttR1dq?=
 =?utf-8?B?a0ZTSGZ5ejE3eEdJYUtQUVA0dVBsUnJsNnlHT1RLOUJRUTVvVnd0Zk5UR2lj?=
 =?utf-8?B?QnZUWXptT25HWjdKckRIamlLZUhyVytkK1BFZWIzRUM2RGY0MlM1aUpTSWpi?=
 =?utf-8?B?c0YwSEh0RjhPb1I4MHQxSnFUbXJDajk0aU9FQUxQQ1BpUDF4eGErSHBkODZF?=
 =?utf-8?B?SnBiV2F2VFVpdEpVWjJoTXIvbTYyaTBOQkM1Y0xJTlFuUEhTRVIxTHFMOUtk?=
 =?utf-8?B?K2N5RXJ0K0NPS1ZtNDUwNyt4VlNRRlFoSzNzY0JOTFBwaHdSM25CL0QyVGd6?=
 =?utf-8?B?d3RBTWtSNTAyVEdNdml0NUFKMis2RHJaWlA5MVV3c1BxajBiQnBtYXdFOU5i?=
 =?utf-8?B?QUl0d3c0Q1lCcTU4LytZcVZBdytxL2h6Ukx6RzhkakVXcllFYnU4VHRpVVBn?=
 =?utf-8?B?M3BhVWZPWDFLZ3k2ZlZPdE5ZaERodTNUSUszVnNGWVpkUGxVUHVBblh0RHBP?=
 =?utf-8?B?WGdmaTBFb25mMTZvVmtmcE9ySjBOekVZUzVOSlZSS1ZNSTk1MTJNZ2tscUVK?=
 =?utf-8?B?N21iYjFNRlR6YXVteU0rczF5RzdscWZzV0tZLy9rclVSbS9CNCtJd01UNkEr?=
 =?utf-8?B?QnhxRkN3cDNpa0VScWtBREh0UkppK1JoWjVzWW1NNUI1N2V2RnR2UDFoZUJ3?=
 =?utf-8?B?ZkhXSktsemNpNUthTlBrc2NpYnpiTzlqMjVpaXNOQlJYS3FlVEZQaHpGaEdp?=
 =?utf-8?B?MHpnMlMvWnRFMnh6WERjZ1BvNXRQdG1JQ1pTZWhSd1lXRVZIb3JUSnRrTGE5?=
 =?utf-8?B?dVdhcmU5QkFxWTdEWk1CbjViM3JGb1NQUTZGZDE2TEdmSjc4ZmwyOGw3Tk5p?=
 =?utf-8?B?dHZYYloxYjAreFFxaGtMUk1aZEtISnBOakxPeHBRVDhxWktkVVlUTWVvZXJ5?=
 =?utf-8?B?eUxSUlZjS29WYjFnMnp1SXFFL0NZc0E5R2p0WnJoY1BUNm5zWmRuQUQrNGJU?=
 =?utf-8?B?cFNJakhpQ1dBRjJPZ21saEtVMmoxek1Za0N3K2ZGTGtIOWhwMXRhbEFuQk1T?=
 =?utf-8?B?UFlEZU9lV00vUG9BK2Y1dzhjbyttdTdkVE9OYlVKRE4vTkJXSHMvZWtkdGN1?=
 =?utf-8?B?ZGpuNFZYc2tSVlJZVzNsN05jWUxVN3dKQVFxcXUvcUY5MW9hdVBrTGdycTFZ?=
 =?utf-8?B?MEVMSytsNXQxTHlXNUpXNklmaCtvT2lNc3VBRW5nck5EaEthb1lhellxTGRE?=
 =?utf-8?B?ckhiWVpVYmdvMGlMalhaVWpKSjhuUHRZaGwxcHJHcCtQbWNiVDlCOXc4ZXd3?=
 =?utf-8?B?QWI4dTNUUzNKY0FXVTEvZE1XSFA4OXZPR2dHenZ2enUvandlaWw2Q0U4dHVi?=
 =?utf-8?B?SjlTQjNWeXMvbXpzN1lNMW1oN0JXZEV1LzRteVZUZ1VxRHcyS2tDUXhvcWlU?=
 =?utf-8?B?Y09jbGhKS2dQUERzaC96WEx0LzlOb1ZDYnBwb1FnZTlTM3ExYnArYktvMXFl?=
 =?utf-8?B?c2xzS1pjUHkvWUNmVmVuc1I0QXppeUhQanZqREtRRWowRWt1OHM4a3dsQjZh?=
 =?utf-8?B?OXlYa2RSbnR1YW1CR3E5V3pDUEI5V21qTVFkUFZuOWY4K21MVVVlTjZCZEZT?=
 =?utf-8?B?VytxT0laYXRkbmNnM01vaUpFcGRrK0RVblo0OEFHWDk5amY1V0g4clY5SXVV?=
 =?utf-8?B?UUR5Wm5ybjNpSmVra3hmSDBpRDdjVTRhcTQ2WjZNSmhKUFU4azNnMWxnd1F2?=
 =?utf-8?B?N2cxKzNkRFJ4S1NwSXZBc2g5SmNWWlN3SkZ5bklDV3pVNEtNc1FWZGgyd1RO?=
 =?utf-8?B?amx1NEZDN0JkdnZ4cXBJeEdUQ1Z2SzJHUmtLRWZzRUVOT1Vod3NVNHFLQ09P?=
 =?utf-8?B?Uy9rT2diZkFIVWFacE5GemhhcUV5aTlZN1FoTmxsZzFLNkwxQUlBaFZGSW9N?=
 =?utf-8?B?dDVMNGQ0cEF4OUE1QkhVRFUva0lHTWNSZ1I3bUVRa3RPaDhLL0JMSXp2Zkow?=
 =?utf-8?B?SEI4M3V2YS91OEN1MFZOT1piOTh4SzJEZWpLZWdNcUhiTDVENndYMVp4T2hk?=
 =?utf-8?B?TlhwUVhVNkwybDRXa0tzTGRKcmJtUXUxR3hTcS9aZjBiaWVYN1lneUNqL2Rh?=
 =?utf-8?Q?PV2CPvadVQfMnRm5HQY2zF1+nO7vXTrQU1QmFcPoQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2F6EBAAD0B89C4C967A60324FB0F257@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96813277-1d32-42d2-1cf4-08dc106e5433
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 17:22:02.4209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uze9G6FfIBomnR+ZAQ4T0LqF5gkWg6AFfvLFQXWHOFdlv9Dye3u1L6Q9qRl+nls3LTzTOFj3F9PgWTwKZwe2JbMppAgUkODYWvcPyUes1Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6871
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

SGVsbG8gRW5yaWNvIGV0IGFsLiENCg0KT24gV2VkLCAyMDI0LTAxLTAzIGF0IDE0OjMxICswMTAw
LCBFbnJpY28gTGV0byB3cm90ZToNCj4gU2luY2Ugd2UgaGF2ZSBib2FyZHMgdXNpbmcgdGhlIGRy
aXZlciBtb2RlbCBvciBub3QgZm9yIGkyYywgdXNlIGFic3RyYWN0aW9uDQo+IGZ1bmN0aW9uIHRv
IHByb2JlIHRoZSBpMmMsIGNoZWNrIHRoZSBFRVBST00gYW5kIHJlYWQgZnJvbSBFRVBST00uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gTGV0byA8ZW5yaWNvLmxldG9Ac2llbWVucy5jb20+
DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBz
aWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqBib2FyZC9zaWVtZW5zL2NvbW1vbi9ib2FyZC5jwqDC
oMKgwqDCoCB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKy0tDQo+IMKgYm9hcmQvc2llbWVucy9j
b21tb24vYm9hcmQuaMKgwqDCoMKgwqAgfMKgIDMgKysNCj4gwqBib2FyZC9zaWVtZW5zL2NvbW1v
bi9mYWN0b3J5c2V0LmMgfCA2MyArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IMKg
Ym9hcmQvc2llbWVucy9kcmFjby9ib2FyZC5jwqDCoMKgwqDCoMKgIHwgMjMgKysrKy0tLS0tLS0N
Cj4gwqBib2FyZC9zaWVtZW5zL3B4bTIvYm9hcmQuY8KgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+
IMKgYm9hcmQvc2llbWVucy9ydXQvYm9hcmQuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4g
wqA2IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDc0IGRlbGV0aW9ucygtKQ0KDQot
LSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
