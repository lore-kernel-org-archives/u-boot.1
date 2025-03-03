Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBECC19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 01:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B9980F70;
	Mon,  3 Mar 2025 02:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9112C810EA; Mon,  3 Mar 2025 02:05:33 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92795807B1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 02:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3RecjSxza2HZJWLACiAwWLP2KLwGdUXu2W0JhfKZ/+dFLcEN1f52evYRDSwhuZK7vNKm+0zNT1ypABWJ7umqV4WKoWu43kDff+g3CA4ByDu4G5H6AMMyzfvg2eGioLzyeaY8NCUomEF76Omp9O3NESxcrWD+C/R/NxoTgx5zUUsDKN5uhV2ke3h17Ky6BLNc+msZegiVymNE5l/KDwYcOPDD4Szh81utmD5/4Hn1udf7TnvVjyCt1TsprKxk2tf92l7dCpF57ARF4BEnbhJnontEIuVb59g5QaucwFybiyHeQBjdms9aCdcfvh6RfSZnFvWb1394ghvOyhc+W2hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTxc/vmcTItx5LC+tWPOE1zuZp/EpRy4aF6gRSxVOto=;
 b=CMeTn6l/MjibKrkGEeVA515tou2XLuUmJj92+zZFpqvvCp6hkpyhtC3x+IZ+5zWXwHjuEUcWq/6258eyhVVkPEEzZaVxWkfSocqS3e/C88Zv6GXocTBg4nG17dIheCYEu/7Nbp+k0VpHfShbrj6uqWJiYH2Lr6AHQrmoSev3CiN+Pi8IGqhQWEdQlsWFlkt0jN9Wq2D6SMOjMPwgpsWmzDgBEa2GTzpaphtL0txQ99XcrcwqdB0kyGuJ/WNHpmntgFuZdSG5R9tw6AlHa8ryZCdXRYvVxydin3Fod82jjq9bYvCyGt0v7NSREI7VSYNoQ1NZr/k0N+Ti9FXivsixDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0687.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 3 Mar
 2025 01:05:21 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Mon, 3 Mar 2025 01:05:21 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, E Shattow <lucent@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>, Rick
 Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6 0/8] Add Starfive JH7110 Cadence USB driver
Thread-Topic: [PATCH v6 0/8] Add Starfive JH7110 Cadence USB driver
Thread-Index: AQHbbTJQ67dboCrFHUWCjldtx3JnL7MkciIAgC0bn4CACC8sAIAHGVjw
Date: Mon, 3 Mar 2025 01:05:21 +0000
Message-ID: <SHXPR01MB08630123F1A65A231C610275E6C9A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
 <CANV2PTN0w4XvmC9dt5aQcfcVS2nezShLxwSfJL1Xm-2Z-8=QLA@mail.gmail.com>
 <CANV2PTPrdF7spLK89BZ4fwnD9k8Y_9buMBNPnzJN7CDjBO6pKw@mail.gmail.com>
 <f61045a5-7faf-434e-bd80-3a8c8e49ffb3@denx.de>
In-Reply-To: <f61045a5-7faf-434e-bd80-3a8c8e49ffb3@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0687:EE_
x-ms-office365-filtering-correlation-id: 5c3c73d7-4340-487e-031c-08dd59ef7894
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|41320700013|38070700018; 
x-microsoft-antispam-message-info: eWBfM9Y4pPmq8hCpZ/hJmqDD7OYC+Jp3MnfvbFBXOAD+pkm6DtU6x7Er8P75pqUGQ0ycH34LzD8ZTHw8gT3FrtKSor3Ks04LNUPefuVLA3zCRLkDuQTBd0xgnrvN5ut2Z2RKPYqkjkuRrgj/zMdG6K2OYjO+7HLAnupyog2WDMYbMreYq9LblPfIDIim5gRNq6zKcuYG7z6E+pKk2/Zck/ACbStRka7VVA4Xf51Y9O3u+iAotSn8Yc0fPCNd5JkFexcUvDqN2ja6lPlFi9YfFFM76U2Y+8KyhKWcOf7NJCzsj2LFP5798XEalNL3DnZG0N8hHWozezBUxtUURMeTrlt9xCHKtz1EmcMdr8sf1kk0ztTge3eStVWTGhPUzvU8lXwZe/iADU0fFOi8nEffCBV7vCuRMmgZqC1/g6DrKyXYTT3RyPRPRg4iNu1znxXZmYP4oprxJWEFN9ZBzKkCP+LPCr13c6Q2zhDz10Xp5W5DPBd+Rw0ptkT39OtNtqqc84R+JcS1AxkTHadBGmLk4nUzq9/+eL+paQXbehikhP4yIxD9Ks1VLBla+DOWWsjqxnz9mw/cxZFWVVqVTWQpxMUVe0FRxU9XG4Avp9t9vUg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(41320700013)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3lTQ3hLVnlmZ3hnUHNhZHZkMUJWTmE5U21RMDBFWlVRQ21JdTZQaGZOV0Mx?=
 =?utf-8?B?cUhoS3NGYTN2ZG9qQmlXcXNmaEZUZWczQ0dHdktuSXB6N2xKZ3ZnanZjaGxQ?=
 =?utf-8?B?dW1XT2xoQ0haS3djSXRNTEtkTFVRNUJFdlg3Z3M0TG1nY0pEQTJoT3hWeUs3?=
 =?utf-8?B?ZFpzRnA5a2FDNU9PQkMyNngwRUhFZmUxTGRsU1Y2N2tDclNZUm9uN3Q4WHRo?=
 =?utf-8?B?WmhvbTEySDhPMEs0dEZGMTdLY014SGxvNG5iRDVDYVRZUytPWVFzay9EaUdk?=
 =?utf-8?B?WExSaDMya2V5dTgvSWZxbktKUnBZSjB2ZlVGdXFnZVNmSTBpb0lWUnhzdmxv?=
 =?utf-8?B?bmpLM3dSdm9qWVZKU2xMay9RVlJpUGg5eGFiZ0N6V1VBMzVLV01UNkVaZXNP?=
 =?utf-8?B?UEVQWVhjNDBXNkdNenN0cDJPWG9tNnZyUXJ1cEhoemdGQ0M0amFJaCtienh0?=
 =?utf-8?B?UlJNL253bCt1d1RlUlp2MU5WNUorK2VBWmRyblBnTVltRjVmdDlrajU0dEox?=
 =?utf-8?B?UzZVbjBYd25sT1RNOWZXMzJtSUdqUWVkNGk0RmZGbUpXRjFtaWhqN3RWZHpa?=
 =?utf-8?B?Zi9NZHFRQXF3QkUvUFczUUc1aUs4T2hPRndiVmtQQXQ4SUhEKzFhdFg5Kys5?=
 =?utf-8?B?ZTdDSXBYcDNpQ2JDQVJaYnFxNmgyWGtMSFhvTGRiSnZjMHNXcllqa2JyT0sr?=
 =?utf-8?B?WGNrRTlRbTF3U1NoRjJaaXJDekdhVEQ0VTA0TjhuUTJCNS9zTmpiR1pjSkFn?=
 =?utf-8?B?V0xTNWZHcVNjSlJsSzJTNXZwbDNSNU1Bb3dyQ1JHUlVJTWRhNG8zVFNxU21J?=
 =?utf-8?B?eVF3MStneGU3eFNqeEtXcXo4SVlybVZhNkNHZVZ3aEdKMlBSKzVsSmJwRHNR?=
 =?utf-8?B?MmhpRmdFRnNVMHp5Q0FEKzZvQXNLdVVLRkl4RGVsUmNObnlJc3N3N0N3Z1VJ?=
 =?utf-8?B?SVk4OGk5U0FJVzlMZ0tOZEpzVlp1QmRZQU9uRVNjVENlR202MlUrZUpzVi9G?=
 =?utf-8?B?Si9Qd0RIblM5SDhmcFFVL0RrR2xUcnhTSFRGOXp4L3ErQVlteXBNODlROVNu?=
 =?utf-8?B?SU9hZzgxL2thUFZYWE5IK1p1S1FUZnJNMnFwY3NuSlJFZjNORFhYR0w4SW1n?=
 =?utf-8?B?aEJMSm04VHhveHNSRDNvb2ZJanU5WXhxSnVhZ2JhcDZEZzRtMSt1OWtkRVAw?=
 =?utf-8?B?Zm56R2VoU1NzTTV2T0hkTWp3U0lpSC9VZmhwR0xVcVlZcUZ1OWdlT3FhZk1Q?=
 =?utf-8?B?clBBR25KQ2xiVTBzSkFUc1lrbGhwQ3gzbVpMODkzbzVveHd6WkNNcm5iT0Q5?=
 =?utf-8?B?NVhkWFZXWFNmcWxWSGVPcG9hamdjaGVQRGpiMnZqcFVDejFMVThVWVlSTGVJ?=
 =?utf-8?B?d1dHRVptaFJ6dFNPUWE5VVNVQ0dBVFh1NmNCSmZWNTZsbWMyanFXVHN2SU4v?=
 =?utf-8?B?T2dJOFE2OVNxMnQ1dTloVlREb3pyTytEeC9vUk1KMU1mWDhFTHRSV1E0Mm93?=
 =?utf-8?B?UWF2di96TjdJUjJiSm4rcmg3NktiUDB3TmlzTzI4UEI4cFN0L1daTGN6K21l?=
 =?utf-8?B?bzFxZ3diR2I4VmhKdTl6c2xaUWpWdkRtaStVamJueDQwQTVvaEZEcEI5Tm1w?=
 =?utf-8?B?ZEIzSVBRd2xPY1VaOTcyNzFrVVVQRTVrQnhSbVpoeUxIVGxxK0IzY0NDVHgz?=
 =?utf-8?B?ZFNXN0k2ak8xd0pyRkxUalc4WjNpRnVaTisvcVdJUHRweVdwSW04T1AyUysr?=
 =?utf-8?B?UHpOSUptdE1QRnZuQ0gzWThmL0g3OWZWUTdEWDNiZXljWHVHUmhwUmdkd20z?=
 =?utf-8?B?QnFMOTFPNDVvM2FwZTIvVytrc000VGdzbVpFWXJLRlpodnpSUzFJYjlNVU5u?=
 =?utf-8?B?ZDlRQllvdGF2MmlSRnMyZ09hSXBoS0ZQSHNQSnBEbDgvMUExLzA0aStWL1Za?=
 =?utf-8?B?cjRMMnNSaGt6Z0FkdWVTdmlsbzJvbFRXaExFVkdWMVFXdFkybVFCYkxaL1ZU?=
 =?utf-8?B?cG51YUthc1VyQW4rREhlVEJyeThNMGN2c2p0RkFSdk40RjNLRXBmZ291Nktk?=
 =?utf-8?B?K2Q4ZEprOHdHbWpyL1RyY3g2NzNjUmI4SndmY1ZxRU54M2VnWk5wMkpDazRl?=
 =?utf-8?Q?bMIPUF9eKPrbFajR42NU5owso?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3c73d7-4340-487e-031c-08dd59ef7894
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 01:05:21.1082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvdFaPfPdEL22WTXRYvHmTooCxal4UgdRmzk6tQKJDYrMsdoijnXY0y1mlZn0H87TDmFAtopEQ3yKbxkhyuniHlClrNVNd9nU4XDDJeBtXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0687
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

DQoNCj4gDQo+IE9uIDIvMjEvMjUgODo0MSBBTSwgRSBTaGF0dG93IHdyb3RlOg0KPiA+IE9uIFRo
dSwgSmFuIDIzLCAyMDI1IGF0IDY6NTHigK9BTSBFIFNoYXR0b3cgPGx1Y2VudEBnbWFpbC5jb20+
IHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCA1OjAx4oCvUE0gTWlu
ZGEgQ2hlbg0KPiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPiB3cm90ZToNCj4gPj4+DQo+
ID4+PiBBZGQgU3RhcmZpdmUgSkg3MTEwIENhZGVuY2UgVVNCIGRyaXZlciBhbmQgcmVsYXRlZCBQ
SFkgZHJpdmVyLg0KPiA+Pj4gU28gdGhlIGNvZGVzIGNhbiBiZSB1c2VkIGluIHZpc2lvbmZpdmUy
IGFuZCBzdGFyNjQgNzExMCBib2FyZC4NCj4gPj4+DQo+ID4+PiBUaGUgZHJpdmVyIGlzIGFsbW9z
dCB0aGUgc2FtZSB3aXRoIGtlcm5lbCBkcml2ZXIuDQo+ID4+Pg0KPiA+Pj4gVGVzdCB3aXRoIFN0
YXI2NCBKSDcxMTAgYm9hcmQgVVNCIDMuMCArIFVTQiAyLjAgaG9zdC4NCj4gPj4+IFRoZSBjb2Rl
IGNhbiB3b3JrLg0KPiA+Pj4NCj4gPj4+IFRoZSBTdGFyZml2ZSBKSDcxMTAgaGFzIGVuYWJsZSBD
T05GSUdfT0ZfVVBTVFJFQU0uIFRoZSBkdHMgaXMgZnJvbQ0KPiA+Pj4ga2VybmVsDQo+ID4+Pg0K
PiA+Pj4gLSBwcmV2aW91cyB2ZXJzaW9uDQo+ID4+PiAgICB2MToNCj4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQwNTA0MTUwMzU4LjE5NjAwLTEt
DQo+IG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbS8NCj4gPj4+ICAgIHYyOg0KPiBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvY292ZXIvMjAyNDA3MDQwNTUwMTQu
NTUxMTctMS0NCj4gbWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tLw0KPiA+Pj4gICAgdjM6DQo+
IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9jb3Zlci8yMDI0MDcx
OTAxMzgyMi4xMDEzNzQtMS0NCj4gbWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tLw0KPiA+Pj4g
ICAgdjQ6DQo+ID4+PiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3Qv
Y292ZXIvMjAyNDA4MjkwMTMwNTguNjE3OA0KPiA+Pj4gLTEtbWluZGEuY2hlbkBzdGFyZml2ZXRl
Y2guY29tLw0KPiA+Pj4NCj4gPj4+IC0gcGF0Y2ggZGVzY3JpcHRpb24uDQo+ID4+Pg0KPiA+Pj4g
cGF0Y2gxOiBBZGQgc2V0IHBoeSBtb2RlIGZ1bmN0aW9uIGluIGNkbnMzIGNvcmUgZHJpdmVyDQo+
ID4+PiAgICAgICAgICB3aGljaCBpcyB1c2VkIGJ5IFN0YXJmaXZlIEpINzExMC4NCj4gPj4+IHBh
dGNoMi0zOiBVU0IgYW5kIFBDSWUgMi4wICh1c2IgMy4wKSBQSFkgZHJpdmllcg0KPiA+Pj4gcGF0
Y2g0OiBDYWRlbmNlIFVTQiB3cmFwcGVyIGRyaXZlci4NCj4gPj4+IHBhdGNoNTogR2V0IHRoZSBk
ciBtb2RlIGZyb20gd3JhcHBlciBkZXZpY2Ugbm9kZS4NCj4gPj4+IHBhdGNoNjogQWRkIEpINzEx
MCBVU0IgZGVmYXVsdCBvdmVyY3VycmVudCBwaW4uDQo+ID4+PiBwYXRjaDc6IGNvbmZpZyB1cGRh
dGUuDQo+ID4+PiBwYXRjaDg6IE1BSU5UQUlORVJTIHVwZGF0ZQ0KPiA+Pj4NCj4gPj4+IC0gY2hh
bmdlOg0KPiA+Pj4gICAgICAgICAgdjY6DQo+ID4+PiAgICAgICAgICAtIHBhdGNoIDUgZm9ybWF0
IGNoYW5nZWQuDQo+ID4+PiAgICAgICAgICAtIHNwbGl0IHY1IHBhdGNoNCB0byB2NiBwYXRjaCA0
IGFuZCBwYXRjaCA1DQo+ID4+PiAgICAgICAgICAtIGRlbGV0ZSB2NiBkdHMgcGF0Y2g3IGJlY2F1
c2UgdGhlIFN0YXJGaXZlIEpINzExMA0KPiA+Pj4gICAgICAgICAgICBDT05GSUdfT0ZfVVBTVFJF
QU0gaXMgZW5ibGVkLg0KPiA+Pj4gICAgICAgICAgdjU6DQo+ID4+PiAgICAgICAgICAtIHBhdGNo
IDItNCBmb3JtYXQgY2hhbmdlZC4NCj4gPj4+ICAgICAgICAgIC0gRm9yIHBhcmVwYXJpbmcgZW5h
YmxlIE9GX1VQU1RSRUFNLCBwYXRjaDQgZ2V0IHRoZSBkciBtb2RlDQo+ID4+PiAgICAgICAgICAg
IGZyb20gcGFyZW50IGRldmljZSBkdHMgbm9kZSBub3QgdGhlIGNkbnMgY29yZSBkZXZpY2UgZHRz
Lg0KPiA+Pj4gICAgICAgICAgLSBwYXRjaDIgYWRkIGEgY29tbW9uIHVzYiBzeXNjb24gc2V0dGlu
ZyBoZWFkZmlsZS4NCj4gPj4+ICAgICAgICAgIC0gZGVsZXRlIHY0IHBhdGNoOCBhbmQgdGhlIHN0
YXI2NCBkdHMgc2V0dGluZyBjYW4gYmUgc2V0dGluZw0KPiA+Pj4gICAgICAgICAgICBpbnQgc3Rh
cjY0IGJvYXJkIGR0cyBjb25maWd1cmF0aW9uIGlmIHRoZSBPRl9VUFNUUkVBTSBpcw0KPiA+Pj4g
ICAgICAgICAgICBlbmFibGUuDQo+ID4+PiAgICAgICAgICB2NDoNCj4gPj4+ICAgICAgICAgIC0g
cGF0Y2ggMiBBZGQgdXNiIHNwbGl0IHNldHRpbmcsIGRlZmF1bHQgc2V0IFVTQiAyLjAgb25seS4N
Cj4gPj4+ICAgICAgICAgIC0gcGF0Y2ggNSBtb3ZlIHRvIHNwbCBzdGFnZS4NCj4gPj4+ICAgICAg
ICAgIC0gQWRkIGEgbmV3IHBhdGNoIDggZm9yIHN0YXI2NCBib2FyZCB1c2IgaG9zdCwgdmJ1cyBw
aW4gc2V0dGluZw0KPiA+Pj4gICAgICAgICAgICBhbmQgdXNiIDMuMA0KPiA+Pj4gICAgICAgICAg
djM6DQo+ID4+PiAgICAgICAgICAtIHBhdGNoIDEgTW92ZSB0aGUgYWRkZWQgY29kZSB0byBjZG5z
M19kcmRfdXBkYXRlX21vZGUoKS4NCj4gPj4+ICAgICAgICAgIC0gcGF0Y2ggMS00IGNvcnJlY3Qg
dGhlIGNvZGUgZm9ybWF0Lihmb2xsb3cgUm9nZXJzJ3MgY29tbWVudHMuKQ0KPiA+Pj4gICAgICAg
ICAgLSBwYXRjaCAzIHVzaW5nIHJlZ21hcF9maWVsZC4NCj4gPj4+DQo+ID4+PiAgICAgICAgICB2
MjoNCj4gPj4+ICAgICAgICAgIC0gcGF0Y2ggMSBNb3ZlIHRoZSBhZGRlZCBjb2RlIHRvIGNkbnMz
X2NvcmVfaW5pdF9yb2xlKCkuIE11c3QNCj4gPj4+ICAgICAgICAgICAgc2V0IFBIWSBtb2RlIGJl
Zm9yZSBjYWxsaW5nIGNkbnMzIHJvbGUgc3RhcnQgZnVuY3Rpb24uDQo+ID4+PiAgICAgICAgICAt
IHBhdGNoIDEtNCBjb3JyZWN0IHRoZSBjb2RlIGZvcm1hdC4oZm9sbG93IE1hcmVrJ3MgY29tbWVu
dHMuKQ0KPiA+Pj4gICAgICAgICAgLSBwYXRjaCAyIEFkZCBzZXQgMTI1TSBjbG9jayBpbiBQSFkg
aW5pdCBmdW5jdGlvbi4NCj4gPj4+ICAgICAgICAgIC0gQWRkIG5ldyBwYXRjaDUuDQo+ID4+Pg0K
PiA+Pj4NCj4gPj4+IE1pbmRhIENoZW4gKDgpOg0KPiA+Pj4gICAgdXNiOiBjZG5zMzogU2V0IFVT
QiBQSFkgbW9kZSBpbiBjZG5zM19kcmRfdXBkYXRlX21vZGUoKQ0KPiA+Pj4gICAgcGh5OiBzdGFy
Zml2ZTogQWRkIFN0YXJmaXZlIEpINzExMCBVU0IgMi4wIFBIWSBkcml2ZXINCj4gPj4+ICAgIHBo
eTogc3RhcmZpdmU6IEFkZCBTdGFyZml2ZSBKSDcxMTAgUENJZSAyLjAgUEhZIGRyaXZlcg0KPiA+
Pj4gICAgdXNiOiBjZG5zOiBzdGFyZml2ZTogR2V0IGRyIG1vZGUgZnJvbSB3cmFwcGVyIGRldmlj
ZSBkdHMgbm9kZQ0KPiA+Pj4gICAgdXNiOiBjZG5zOiBzdGFyZml2ZTogQWRkIGNkbnMgVVNCIGRy
aXZlcg0KPiA+Pj4gICAgc3BsOiBzdGFyZml2ZTogdmlzaW9uZml2ZTI6IERpc2FibGUgVVNCIG92
ZXJjdXJyZW50IHBpbiBieSBkZWZhdWx0Lg0KPiA+Pj4gICAgY29uZmlnczogc3RhcmZpdmU6IEFk
ZCB2aXNpb25maXZlMiBjYWRlbmNlIFVTQiBjb25maWd1cmF0aW9uDQo+ID4+PiAgICBNQUlOVEFJ
TkVSUzogVXBkYXRlIFN0YXJmaXZlIHZpc2lvbmZpdmUyIG1haW50YWluIGZpbGVzLg0KPiA+Pj4N
Cj4gPj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLWpoNzExMC9ncGlvLmggICAgfCAg
IDUgKw0KPiA+Pj4gICBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUyAgICAg
ICB8ICAgMiArDQo+ID4+PiAgIGJvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3NwbC5jICAgICAg
ICAgICAgIHwgICAzICsNCj4gPj4+ICAgY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZj
b25maWcgICAgICAgfCAgMTAgKw0KPiA+Pj4gICBkcml2ZXJzL3BoeS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4+PiAgIGRyaXZlcnMvcGh5L01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPj4+ICAgZHJpdmVycy9waHkvc3RhcmZp
dmUvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgMjEgKysNCj4gPj4+ICAgZHJpdmVycy9waHkv
c3RhcmZpdmUvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+Pj4gICBkcml2ZXJz
L3BoeS9zdGFyZml2ZS9waHktamg3MTEwLXBjaWUuYyAgICAgICB8IDIzOQ0KPiArKysrKysrKysr
KysrKysrKysrDQo+ID4+PiAgIGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtdXNiLXN5
c2Nvbi5oIHwgICA5ICsNCj4gPj4+ICAgZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11
c2IyLmMgICAgICAgfCAxNjIgKysrKysrKysrKysrKw0KPiA+Pj4gICBkcml2ZXJzL3VzYi9jZG5z
My9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4+PiAgIGRyaXZlcnMvdXNi
L2NkbnMzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPj4+ICAgZHJpdmVy
cy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYyAgICAgICAgICAgfCAxODIgKysrKysrKysrKysr
KysNCj4gPj4+ICAgZHJpdmVycy91c2IvY2RuczMvY29yZS5jICAgICAgICAgICAgICAgICAgICAg
fCAgIDMgKw0KPiA+Pj4gICBkcml2ZXJzL3VzYi9jZG5zMy9kcmQuYyAgICAgICAgICAgICAgICAg
ICAgICB8ICAxNCArKw0KPiA+Pj4gICAxNiBmaWxlcyBjaGFuZ2VkLCA2NjcgaW5zZXJ0aW9ucygr
KQ0KPiA+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvc3RhcmZpdmUvS2NvbmZp
Zw0KPiA+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvc3RhcmZpdmUvTWFrZWZp
bGUNCj4gPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1q
aDcxMTAtcGNpZS5jDQo+ID4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9zdGFy
Zml2ZS9waHktamg3MTEwLXVzYi1zeXNjb24uaA0KPiA+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11c2IyLmMNCj4gPj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLXN0YXJmaXZlLmMNCj4gPj4+DQo+ID4+
Pg0KPiA+Pj4gYmFzZS1jb21taXQ6IGJjMTU3YmI2NjY3ZWQ5N2UzM2JlOGNlODQzNmMyOGJhYTI3
NWIyOTUNCj4gPj4+IC0tDQo+ID4+PiAyLjE3LjENCj4gPj4+DQo+ID4+DQo+ID4+IFRoZXJlIGFy
ZSBzcGVsbGluZyBhbmQgZ3JhbW1hciBlcnJvcnMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlcyBmb3Ig
dGhpcw0KPiA+PiBzZXJpZXMgdGhhdCBJIHdvdWxkIGxpa2UgdG8gc2VlIGNvcnJlY3RlZC4gSSB3
aWxsIGxlYXZlIHRoYXQgZm9yDQo+ID4+IG90aGVycyBkb2luZyBjb2RlIHJldmlldyB0byBwcm92
aWRlIHN1Z2dlc3Rpb25zLg0KPiA+Pg0KPiA+PiBUaGlzIHNlcmllcyBjYW4gYmUgYXBwbGllZCBh
cy1pcyBhbmQgZG9lcyBzZXQgdGhlIFVTQiBvdmVyLWN1cnJlbnQNCj4gPj4gcmVnaXN0ZXIgd2hp
Y2ggYWxsb3dzIFVTQiBmdW5jdGlvbiBpbiBMaW51eCAtbmV4dCAoaS5lLiBQaW5lNjQNCj4gPj4g
U3RhcjY0LCBNaWxrLVYgTWFycykuIEhvd2V2ZXIgaWYgeW91IHdhbnQgVVNCMi4wIGZ1bmN0aW9u
YWxpdHkgaW4gVS1Cb290DQo+IChpLmUuDQo+ID4+IFBpbmU2NCBTdGFyNjQsIE1pbGstViBNYXJz
KSB0aGVuIGl0IGlzIGRlcGVuZGluZyBvbiBhdCBsZWFzdA0KPiA+PiBkdC1yZWJhc2luZyA2LjE0
LXJjMSB3aGljaCBpcyBub3QgdGhlcmUgeWV0IGFzIG9mIHRoaXMgd3JpdGluZywgYW5kDQo+ID4+
IFVTQjMuMCB0aGVuIGFkZGl0aW9uYWxseQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1yaXNjdi8yMDI1MDEwMjE4Mzc0Ni40MTE1MjYtMS1lQGZyZWVzaGUNCj4gPj4gbGwuZGUg
c2VyaWVzIHRvIHJlYWNoIGR0LXJlYmFzaW5nIHdoaWNoIGlzIG5vdCBleHBlY3RlZCBiZWZvcmUg
dGhlDQo+ID4+IGNsb3NlIG9mIExpbnV4IDYuMTQgbWVyZ2Ugd2luZG93Lg0KPiA+Pg0KPiA+PiBX
aXRob3V0IHJlZ2FyZCB0byBjb2RlIHF1YWxpdHkgb3Igc3BlbGxpbmcgYW5kIGdyYW1tYXIgbWlz
dGFrZXMsIEkNCj4gPj4gaGF2ZSB0ZXN0ZWQgdGhpcyBzZXJpZXMgYm90aCB3aXRoIGFuZCB3aXRo
b3V0IHRoZSBhbnRpY2lwYXRlZCBjaGFuZ2VzDQo+ID4+IGZyb20gdXBzdHJlYW0gTGludXguIEFs
bCBmZWF0dXJlcyBhcmUgd29ya2luZyB0byB0aGUgZXh0ZW50IHRoYXQgSQ0KPiA+PiB3b3VsZCBl
eHBlY3QuIEZvciB0aGUgc2VyaWVzOg0KPiA+Pg0KPiA+PiBUZXN0ZWQtYnk6IEUgU2hhdHRvdyA8
bHVjZW50QGdtYWlsLmNvbT4NCj4gPg0KPiA+IENhbiBzb21lb25lIHRha2UgdGhpcyBwYXRjaCBz
ZXJpZXM/IEVsc2UgZG9lcyBpdCBuZWVkIGFub3RoZXIgcmV2aXNpb24NCj4gPiBmcm9tIE1pbmRh
PyAtRQ0KPiANCj4gVGhlcmUgaXMgYSBiaXQgb2YgZmVlZGJhY2sgb24gNS84ICwgc28geWVzLCBW
NyBwbGVhc2UuIFRoZW4gSSBjYW4gdGFrZSB0aGUgVVNCDQo+IHBhcnRzLg0KSSB3aWxsIHNlbmQg
djcgaW4gdGhpcyB3ZWVrDQo=
