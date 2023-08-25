Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA4C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBCF86612;
	Fri, 25 Aug 2023 15:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="nLFwQru4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51564864AA; Fri, 25 Aug 2023 15:20:17 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BB0866BB
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2AdtXOuFtaqGnO4xbeUFpxFnXh0ocbf8gzfLyJIGx2Bn/a00AEtkGruppui4MrgDY+Y2CkFyoLVa5PoDn2M0AxfFt88VT1z5GhSo4t0ANSzAFubCCKs4WG/eDcRshqA3Ick0lcnwUz3MGEK/8zXN6oqKErJkRm1MtybIBJHTZXVxw/f+bcImDza0ZaV9cs2bwZFhnKuU6iDWK+6B3vO7b2rGwOvqet/vHhTgRxMLpUkGqNb0N8d7ua46PAu6cUZ0Q2YCb4zZ0l7uzAec0FFIOjXaSRs80NYkWuyyCtUq7A7+77Km1dumr4XsghnQWbLJtSOpMZUvhU/wbCiEacDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Bob8FDnTkT5VlZgiiXGuuk4Lf/aSQVhDdAWw099Vg=;
 b=R0bkm88quphTOyra0eFrc9f9cXDcMlY4f5OVEofFTtILi/dFlopDl6GfyRyDA/rIG6uGL3Z3sOHEyl1GDt/AN+Ygvk/lkUv/urZkLR9WBncjFUAnt6Dcl8KU8Bzo6zTss98Ll3/V+fC0YGI1OobKOclt43z3rIkZUHkmIJNDD6bmOOhxJ3D9XpYoxXqVe6dEsEGg7fUV4RfJ/EvI1v5FIuT8MN+HHXxDGrMeFy8syg7+cTGpq6hm3ai7/HpBQYcy53Jjh4N+XH0QYxJJFBTS30gf/l5ecpzVx9XVrPHv44Qbft4fRUkDyP1ha/6dp85bhD5xukhMaq9K/RtVmd5LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Bob8FDnTkT5VlZgiiXGuuk4Lf/aSQVhDdAWw099Vg=;
 b=nLFwQru4fuezI2kc/EcQqVx5PV6M7NkUWnVc1QZTf/WJAvVo3gIU+F5W2G7Qs9iq8X4nzEvkLDPNaAvAAvLpNqEqWkHTigFCedl4ojKql9qBBtK7nPA8OS58N+tPdJZlR7TiMVS+Khuxxp2Ib7/DO+MMBnwl55UBogcCdKuSGCTTqyY+hHmJbkcW7K2JPbLzkgdYIQpqok+BZCJgxFyH4zNzUbOzkcQyUYuAE9aDMMLI44K0jyE5GpU87iTIoQxST0gO97O5RMkVrbpvk0aW9FycqggJAEYmYm7IgN3Gk7HNLXWWQUxsS+EZpiAMsqNh16YgDxKWuv4XjNoXCUoKow==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VE1PR10MB3933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:20:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 13:20:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "marcel@ziswiler.com" <marcel@ziswiler.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "philippe.reynes@softathome.com" <philippe.reynes@softathome.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "bb@ti.com"
 <bb@ti.com>, "marex@denx.de" <marex@denx.de>, "pali@kernel.org"
 <pali@kernel.org>, "william.zhang@broadcom.com" <william.zhang@broadcom.com>
Subject: Re: [PATCH v2 3/3] board: toradex: add verdin am62 support
Thread-Topic: [PATCH v2 3/3] board: toradex: add verdin am62 support
Thread-Index: AQHZ11bg/825xbn0pU6e11v5hlgAdA==
Date: Fri, 25 Aug 2023 13:20:12 +0000
Message-ID: <aa6e7ddab0a43f94d8530d4781599d59612764a2.camel@siemens.com>
References: <20230612205444.363727-1-marcel@ziswiler.com>
 <20230612205444.363727-4-marcel@ziswiler.com>
In-Reply-To: <20230612205444.363727-4-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VE1PR10MB3933:EE_
x-ms-office365-filtering-correlation-id: 1802c365-5b48-41d2-034a-08dba56e035e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfC/G50wXrVDyrOjSDxbKZyQc2UR6Qw8sVdN4A7KqdeBOqRTo+St7k5gEZxMSEwKhTFvxjx8RgNbn0xSbXUGDsT1ck1DZfi4+6RGTzwqS3cy63r2G5lZ8EG1hYBp76wd9h7IMapMqQfGZYr0bmOY1rd2+yl0hgeUEMoYXVgSiOFShEKaR9oAds8aynty26oOKBKMcAQPuubbi1Z5+pDL4aws6gnI6ZfEb0VrZrAUhFCAUgng5kr7sXWSw87zPKF3LjOq9T1z8QhTLPq/BUAlB6vvNagK/ga0rXCTbysXV+zdy2dxD5lGAgJgJRgQ3/sLGti/deo2+1SVDtdyTQ4+HZwO5RYnLwiURZIb/CoSZeX4w2oqd8glQi+/oyzThEl4wcmxghJxhdX+prOlfeKr48TPW6xBmdNZyuuNYc7cHdX44b4sMyoGAm0U7vyA19w9wCyVL+4XGRa9c0QTUe6gHEo+EZNraqysB2J2SMIRkB4heUYymOIQR+/Dx1CZe6CcnRiac6VXqO4inH8Pnq4ieTQZPSqbf2GE7kUZ1X3Xkg5WVPtpoXMrGcqJVY7C0qpx8GJjs8AbQ5bqnymCNkedepTv/mB28EkyQaax2I77nO8oyNS2uDEYduqbO0UHp4s6aCHGHQsNRiFY+McOjcSybQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(8936002)(8676002)(4326008)(4744005)(36756003)(7416002)(83380400001)(26005)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(66556008)(64756008)(66476007)(66446008)(54906003)(66946007)(76116006)(316002)(91956017)(110136005)(478600001)(966005)(15974865002)(41300700001)(2906002)(6506007)(86362001)(6486002)(6512007)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUx5d0wxWlV2SWNNYVBtRkVKRXViMGRIeDBCdTlpcG4vT0lERElMdkk5T01p?=
 =?utf-8?B?U09uOVNVZzJ4ZVVxSnJKWTR5d0xUQTV5b1B4MzJaemV1enBVV2owVFpiYVJk?=
 =?utf-8?B?TFlXUnJkV1JzcE1SMHJwVXFQUTZ0VGNpZFRucGU1NDBEVWM1QXZjTElGZjVB?=
 =?utf-8?B?aDZjdGZrMTZ0SWlzYzlQSXZ3eGZPTkhiWW1Edm5YTEZOOGxUZllrMTI5ZEZs?=
 =?utf-8?B?RXlnVGpiWCs2enU5c2NKVnZseXlQZEtqMWdUWWlod2F6Y0NtN291M1ZmRUdx?=
 =?utf-8?B?MDg4M1hnd1hncCtvZTJkdnFQMTU1KzJibjhUeDRNUEoveHBaMnZMY09WaVl1?=
 =?utf-8?B?QjcxanVsVDU1dytzQytxZm0wSVVTc2hOaC9HVmp4alYxN3VtVFVmdlBXQWZI?=
 =?utf-8?B?cjBZZzc1ZU9yYWxNLzRzd2xBOXZKdjZiS3RydTA3RGxKcisxNTZtVFZJTTFs?=
 =?utf-8?B?c0lUc2V0TStGQmNDVUxNVVZwRnUxV2ltaW1HY2wwTFFSSFlJbm1ZY0x0N1k0?=
 =?utf-8?B?b3JrdHl0QkIxYVFUU2ZOdTlPMkRNdlJtNXQyVSt4bE8zMWh6R3dIUGJFQ3ZX?=
 =?utf-8?B?dUF6TjYvWHl5aGpUMitZZHVWRVpPdmRrK2M4WUNNMXlwdXRZb05MRldrL0FG?=
 =?utf-8?B?ZkxXNUN4NVNHTFJxSEc0MTlMMWZ0RVk1RHByVDJjTWxLYUI2MEZSTGx6TVhu?=
 =?utf-8?B?Y3pKN2ZXeGVOQjZJQ2J2cWFDd1FMaVJtSUpld0loOER3T1l3Sy9mWXFYY2px?=
 =?utf-8?B?UFpLbVU3OVAweUxrMWNFWG9sdzAvNjVmMS91SHAvb25RV0F1RUlxNUFQUzMx?=
 =?utf-8?B?d3VQTG8wSm5UQmFJTXpFTnJpT0IyYXVlMEF2SmVHNHZ1YW91Ni9ZN2NzK09S?=
 =?utf-8?B?SURVanlYb0hNRGhwbFFkcU0wRW1QMkxibGJuVytkbXlKODAzVVplUmxCb1ZI?=
 =?utf-8?B?bDVwSFlKN0lYTkxOa0FtQ1FJWkxSbWhGSlZHR1NRbENKcDRJZEJFSkNDQzFT?=
 =?utf-8?B?OGVQODNEcURPSnZsTUE5UitZNjUxSzVKVmhkbnZMQlNSQkJqV1hnWFJtc1Uz?=
 =?utf-8?B?NEcxUm5FNW1oV25RN0tQTDF6Z0U2M0VaZmNLVGoweDVuWFlNOHV1a3k3ZWhX?=
 =?utf-8?B?WFFUczl5d2Z6bkZkUkJUdnpoNVFKMjlrV3VyYWdDUzl3dkZTY2FmWXZtS294?=
 =?utf-8?B?WmQvU0YzVWxDMjVmZHkrWVN2c3hhMThJeFFFdzFNdUErbFJRa3JSeittekhK?=
 =?utf-8?B?RVkxdlREZHBiNE9iRE9DN3g2NS9lclpldkR5bWI4bjVNZXJSVzcvZGVtTlA1?=
 =?utf-8?B?MnFDdmRCZTliMkZXdFQ3RnNTVjFzdC9NUFZuZ2ROQ3VqVVFVcFVjVlZiZlZT?=
 =?utf-8?B?S01hSkUrSzZWK2xZUHZaTlozd2tXdGhHMDYxZkNWOWJib1ZZRk1ISEhvK2NW?=
 =?utf-8?B?MkFGd3ZoYlNXd2dnVS9lV0krV0czYTA0QXIwcjhkOWlpUDc3RnN1Z3NiKytz?=
 =?utf-8?B?dCs0WFJxd1pZYzNWV2FRTzBKaDFXYVNhWEJyakxFaDZQa3BRZ01XeURmbnRW?=
 =?utf-8?B?RE5wRHBsZEZFTXlncHRKem9BSllONSs5QllCbnVQY284Q0NKaFhCTW5pVFRw?=
 =?utf-8?B?NlhNaFdYSnVyZnNMSDQ0cXE0ZmEvRkVFcjVycVVFZXFRdUU1Vng2dUVOTUVF?=
 =?utf-8?B?a3E0STJSWHhNWnp6c3dUaEJLRzUxdUoxRU54MXExUzYxMjFNRnhMNXVqTENY?=
 =?utf-8?B?aEFKdnExc09jZzlNcXdLam1wNkxGYWh6S1d0RHoxbmVpRXlpS0MxOExRRzdD?=
 =?utf-8?B?RHpjZVdQaWJUVHlWVWJiODc1U1ZQVnlYMXhaODRFMUJRamJITVJoK0VEUEFR?=
 =?utf-8?B?Y2djQm44VlhIUmx0UTFiOTJmUlZ5MFRiWThVQ1BNMFozRlpuVm9rdlhUUDgy?=
 =?utf-8?B?RE43a3plVGVYNWYvR2RTZ2pnTnV4MGcwMUgzR1J4OVFqalVheXg1blZaeFI3?=
 =?utf-8?B?NUtGODlKNllNK0hmZEJmTUczWURtSWNDWHA3VE12SndlY0U2aEp3cmtFVmt2?=
 =?utf-8?B?NzFHc2lkT1U0cXRYUGtwdG9SeEY4Sll6V0hQdWt2VUVFNzVWSjJVMzJNT0JI?=
 =?utf-8?B?aVR5ZWpwUDZISlJuQjY4QkhHR2dHZEpEbXEvNXJMbVdlN3hacHpLZWYxL1gy?=
 =?utf-8?Q?3u+nw6DxQIo97LEs2PHRSas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C68B6E8EE60284FA500D385E0DE9115@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1802c365-5b48-41d2-034a-08dba56e035e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 13:20:12.4122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFNcSvCv7Em13KXvOhER82p9s85ZNIj4fB66ZnT6wPk7Aa5RuNNtDgKsEeFiZzaSe4aZxy0nlA93BVaJSJsLgrAt6BeV2p6qz2d/K74GZGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3933
X-Mailman-Approved-At: Fri, 25 Aug 2023 15:22:02 +0200
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

SGVsbG8gTWFyY2VsLA0KDQpPbiBNb24sIDIwMjMtMDYtMTIgYXQgMjI6NTQgKzAyMDAsIE1hcmNl
bCBaaXN3aWxlciB3cm90ZToNCj4gK0J1aWxkIFUtQm9vdCBmb3IgUjUNCj4gKy0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gKw0KPiArLi4gY29kZS1ibG9jazo6IGJhc2gNCj4gKw0KPiArwqDCoMKgICQg
ZXhwb3J0IEFSQ0g9YXJtDQo+ICvCoMKgwqAgJCBleHBvcnQgQ1JPU1NfQ09NUElMRT1hcm0tbm9u
ZS1saW51eC1nbnVlYWJpaGYtDQo+ICvCoMKgwqAgJCBtYWtlIHZlcmRpbi1hbTYyX3I1X2RlZmNv
bmZpZyBPPS90bXAvcjUNCj4gK8KgwqDCoCAkIG1ha2UgTz0vdG1wL3I1DQo+ICvCoMKgwqAgJCBj
ZCAuLi9rMy1pbWFnZS1nZW4NCj4gK8KgwqDCoCAkIG1ha2UgU09DPWFtNjJ4IFNCTD0vdG1wL3I1
L3NwbC91LWJvb3Qtc3BsLmJpbiBTWVNGV19QQVRIPS4uL3RpLWxpbnV4LWZpcm13YXJlL3RpLXN5
c2Z3L3RpLWZzLWZpcm13YXJlLWFtNjJ4LWdwLmJpbg0KPiArwqDCoMKgICQgY3AgdGlib290My1h
bTYyeC1ncC1ldm0uYmluIC4uL3RpYm9vdDMuYmluDQo+ICsNCg0KdGhlIGV4aXN0aW5nIEszIHBs
YXRmb3JtcyBoYXZlIGJlZW4gY29udmVydGVkIHRvIGJpbm1hbiB3b3JrZmxvdzoNCmh0dHBzOi8v
cGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDIzMDcyMTE4NDQ0Ni41
ODIxLTIxLW4tZnJhbmNpc0B0aS5jb20vDQoNCkRvIHlvdSB0aGluayBpdCBtYWtlcyBzZW5zZSB0
byBjb252ZXJ0IHRoZSBuZXdseSBhZGRlZCBWZXJkaW4gYm9hcmQNCnRvIGJpbm1hbiB3b3JrZmxv
dyBhcyB3ZWxsPw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=
