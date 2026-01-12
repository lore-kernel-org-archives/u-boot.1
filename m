Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0144D2502F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 06:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F2B839AC;
	Mon, 12 Jan 2026 07:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D7183AAE; Mon, 12 Jan 2026 07:00:06 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1047839A8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 07:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/wrrLeDZGUk3psN3YEi/N5q2gXA6pSmkru8W1MEjj6F3NSaPDTNe1ErHdw7gEVM5g7mnbCbSOx15mVPz3GlEG1y40D1tpd6oXtVnntKakutetTfsbwR4WeoLVl6mwdOcMTI5LOJSEnv0rYyjAu9/m6F0+kpBYYJz5I2C6njVB64Jdxnu7iY+kIo+YPViW3TRoHoFbu59YV/fgW9HV51/C4JJnEBZO6dy7tlZkREjLl1HL+gp6dUZFd0w3Kw+84BWT+iIOUNdkB9J+AJv3qqdEfIlGjnRVtNObvkC+uTy/0F1JeDaEzRtQ/44+TtL28c+c5N+7NjdugxH09V1n5oGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdDUohxmAznecGRiBOLW/dL72msAocIZUdk1jyf8OgY=;
 b=IPZ1Woi+Cnu6s9LpsXQbXJ6gcGbrINXZ6WWSV/5dATAiFdzTD6LOmfY70xJh9+QdeufohebjxWppL39woSCUAw7nRho17ubYcnh3iYdZhLTEwBRdojg6+o9+RJ9ajk6wDx5hBw98H9poJpXytOmo/ScjV9unE2H1rZObsDlI/y3Lpl99DB4mtSmXmkXo65wYJtXp6rZvbKg3cw9KSHwnBJAu+MmzoThwswYK0dbYRNXYYHIPtD+QhYdy7kGAqbH4Zn7NyluRHiqZpiPi+O9TrYbkuBxr6GmuWVvGaQAgsVdS0UR2t/Zf+oF/8aX7Zdcjz3OjDQrCks0DxY0nE1bAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1274.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.20; Mon, 12 Jan
 2026 05:59:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%5]) with mapi id 15.20.9456.017; Mon, 12 Jan 2026
 05:59:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, oliver Fendt
 <ofendt@googlemail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: unclear license identifiers
Thread-Topic: unclear license identifiers
Thread-Index: AQHcgLe9NpQpVY9qwECE5sZEjl+K47VJVzMwgACdUgCABBXlUA==
Date: Mon, 12 Jan 2026 05:59:55 +0000
Message-ID: <ZQ2PR01MB130777A4A9A492656EF6F907E6812@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
 <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
 <a1a22e85-8812-4064-8b9a-d779884edbbd@cherry.de>
 <ZQ2PR01MB13072ABFAC3D77E8D781C19AE6822@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <81044800-b1b4-4f37-911b-f94ea3c8a761@cherry.de>
In-Reply-To: <81044800-b1b4-4f37-911b-f94ea3c8a761@cherry.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1274:EE_
x-ms-office365-filtering-correlation-id: b126994f-aa03-4675-11b2-08de519fcf51
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: 5ciYEcdm9hxhOjXz3eGaqPs/FTN25zcFSPN/GE6WkI5Q0UHCPn5HjLl4YBaoJbkrqUK0jgQ8lEx65UbsTt9VnNqudgkbHMASjbP+OCgSo7VQISvL+ZvXKWBsDBjwlrj9X52NMxPybA8FVoD0Q9sMK9EvXZM3QyjaKbYubFRxcp+z8nT3+JlLjTX5Iv2MEsBLCjGOPFa4u7Vw0cNGFwDd6bGSZM78/WzZBdLqSeoJMCvl65MsrAsQhwdxVRFxmviSOvaXuWe49Bgi8onwkR5tjTTjQFj1q0YKcGI/KRhPN1fo7P9E1IKZoilEXSJnh6A/4EyDm7tdW51e5WvaunYWrh2VMrFkUC9de6204zzZcwJNmfadtRk2iHoz59vO8Hg2+SXnQHz0b+7R5IdyACQaLk/asSryQVSYZ+QpcuiZQQmNkCCX92JDTW4dOthlBxCmrOlZyvRiXCSDRcZ1HeCtxrgV5rHidIXPv0XBznU9ydo0SVbCFPfPi0VKoesUk0ZoEcrE1t/W+zB/Y/nrBpCmsbPpqm3Ov9eJh0WmV9hN495A8AltfUm4LKdkG0gOT595megSvb2ljNMnN/sx3s1nuiC7QAhraYdwthOBDKNH174=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2kvOXZnclQ4V0d1WGpZMjJvQTBYN2NDMzZlbzRsa3dQUzhiUVpDajdiYkJj?=
 =?utf-8?B?MHI0WUlwYXFQK0hJaTlmS1ZBSVh6QkdIMEZvSGNvWW5NcElrK3NDeFd3UjdZ?=
 =?utf-8?B?am8zeVd2Tk54Q0lVRjNKeFNFWWVkemw3c2tvSXJ2QkFrVjhseDYzQ282OExh?=
 =?utf-8?B?OVVYcWRaRnRYZWEvZFVQNTAzMEFZZjE4TGRlTDZsSk9hYUQxYmMzdkRPYmZQ?=
 =?utf-8?B?U09lN3duMzFVRDBWS1pHWUUybUZsNDhXclYvQjhEMVpuSUQ0am9TaHVUck1n?=
 =?utf-8?B?RGNYN2pUcUpmQ3g0Ump2MjAxSG9RTjd0dlYyd1FobUZkY2hXY3pkNE1xc0RR?=
 =?utf-8?B?Qi9tVUZRVk5idWUvZVlFWlJTWG9xZmRMYUNvUnpPQWZaOHpDczFEYW1YTExl?=
 =?utf-8?B?a2t0Mlc1TWh3dkFNa2JoSXBIaEJFSWZOWTZNMUc0b0xqS2E1cU4xQWVzUGk3?=
 =?utf-8?B?RFJvN2tMdlJ1Mkhwdlloc2ZONmlwL0l3dUdLdXhhVzRCSlBpTzQxNld2UnBo?=
 =?utf-8?B?WVhsOTArcTNvZ3BEZ1NlZ2RYOXNHS0dSYk9tcDEzc0dxelpHSVliOVdyWTNV?=
 =?utf-8?B?b1ErTFp6Rzh5TUwxMitqelp1eWNsZ1EvcWVMYW9OMXlBREU4bWQ4bTFBVERv?=
 =?utf-8?B?dm8vV0pWUVo1TUtCaStkNGRYT0xTZWgvN2hGMVg4TEJrbWJOTHlkUG1QdEJW?=
 =?utf-8?B?NktHTkdadEU3SFQyT2dicE1pTGZnRk5rSFBubFU5dzJpdEkwY2hQazdEUEhX?=
 =?utf-8?B?UGRoMk5nUXJIS3psNFM4RHlKRlFhUGtsM1AxOXBLdXFkNDhmbURtekRQdEU4?=
 =?utf-8?B?Wm03aDB1T0VXZ2tERlZPSllSK0U1TVRmRVRqNHVENGlXbVJkbUt4QUptWGp0?=
 =?utf-8?B?QTcyMFozN1JWZFArRmtPQkwrREJvWm94MzdqUlZ1MHkvS0NkOHc2Q0V2QitK?=
 =?utf-8?B?UUVwQm1PZTV3VG10czFaL25ML2ptWVlDQlBPYS9lUW94Zk1QR29tYnF5UVNE?=
 =?utf-8?B?SHRCNGNuSFhxaXp0QUxvZWFTaGl2eEVkR2NUNVRORWFVU3JCNjFNRUl3MitT?=
 =?utf-8?B?ZGpCc2FkWDIyOVhsdnN4NDRYZkZwN0d6NXViWXRaTzJVRU1EdkVjMVBvYllH?=
 =?utf-8?B?Qk9DcW9CNWhFSk02VXJ0aG5YZFJhWDlxc3dsMjVPQlVjTnBybktPbytYdGtD?=
 =?utf-8?B?Mkw5aXZtY0Z5d1NJM3BLSUFaVTdpVVFCK2N5SURsUDd0TFJtTFlHWklkbFN1?=
 =?utf-8?B?S1o1cFJwTHl0SDMyTFl6ZEdVQWJSU3MzblhBS3dCdUxLNlN2UkZpWXc5U3ds?=
 =?utf-8?B?OVh4U1k3c3Y5NDM4Z2FjZ2E1T09FWENOWVVaUHIrRnZvT2ZYT0wyTmxMSEdD?=
 =?utf-8?B?N1F1QnhHK0luL2c1TUN6OE82UHlkbmdFSkh5ejdmalBycldRaGdSMVdzSUF6?=
 =?utf-8?B?SDBOb3h1NjFpbENDTUNlWUdhY1hwZGdTZHMxeFpEcFgwZ2RTamRxMXVaYWNX?=
 =?utf-8?B?MDFIYmcvRTVxQnk2U2pLSDc0VmhmYTk3bWNtbCtobVhXWDFOMFpSV0c1bDVF?=
 =?utf-8?B?Q09wcm5KVzdCaGo1TFBjTzd1R3VzcndNSTNQYWYycjRuc1pBaW1OZm93VFU5?=
 =?utf-8?B?dUJPVzJoYnBuNjJiSWxWNDdOM1FyK0MxOEJxU09JWjlwRWZwVHFjekQwZU1K?=
 =?utf-8?B?VmxkVldZT2RSK1Nwc2tKakgvdCtoTW9jWEk5cEh6ci83MGNQaFJiMUNTQXFi?=
 =?utf-8?B?R3B6R201Z3ZvdXc1eWh4WmlCZ25KT0toSVo5T0Q4cTFDeUhrUVlNajcyUTRq?=
 =?utf-8?B?OFU2cjQ1eU9qWlBKNU9RQnNEVU9XaTZMOERRN3RQaUlvS1ZFajMxZXhvaitR?=
 =?utf-8?B?WjRkR05WeXdMQXpXMDRrUm9sZzZJQjYvUFJ0aUZhQUdPMmFCN0czbWZPZjlj?=
 =?utf-8?B?YXdCeDFNSXlicGdNM0pVaUVvaTE5VFVHUTdCT2ozMjhRcDJnajJVUnpDaThu?=
 =?utf-8?B?aFUwUWloSktBVm5YVWlXN1Q5Z2dXRVIvYk9CaHhWeEVMaUhOZ1FvQWNWSzdB?=
 =?utf-8?B?V2FKQjNwVVdFNjBQUWJ5UmlCbXVodGNubzkySG0rQmZhYStTalkvd0VCcUlS?=
 =?utf-8?Q?iY/BDTT+nxtqyvzFPvaq0zgvd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b126994f-aa03-4675-11b2-08de519fcf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 05:59:55.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lp/nKcjdUHgmdBfdv5bdj9KS6uHyfzmZ6wL2dTwQxHI5QgiAY8MkjYYFOm/46ZXD97Y+Rd9GJkP2VFrdUukvY8wvKhTlsqCgXqv6ZJiGVTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1274
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

PiBPbiAwOS4wMS4yNiAyMzoxNywgUXVlbnRpbiBTY2h1bHogd3JvdGU6IA0KPiBIaSBIYWwsDQo+
IA0KPiBZb3VyIG1haWwgZGlkbid0IG1ha2UgaXQgdG8gdGhlIG1haWxpbmcgbGlzdC4gSXQgZG9l
c24ndCBhcHBlYXIgb24gdGhlIGFyY2hpdmUgYXQNCj4gaHR0cHM6Ly9saXN0cy5kZW54LmRlL3Bp
cGVybWFpbC91LWJvb3QvMjAyNi1KYW51YXJ5L3RocmVhZC5odG1sIGFuZCB0aGUNCj4gbW9kZXJh
dG9ycyBvZiB0aGUgbWFpbGluZyBsaXN0IGNhbm5vdCBmaW5kIHlvdXIgbWFpbCBhbnl3aGVyZSBp
biB0aGUgc3lzdGVtDQo+IChpbiBzcGFtcyBvciBmaWx0ZXJlZCBtYWlscykuDQo+IA0KPiBDYW4g
eW91IGNvbnNpZGVyIHN1YnNjcmliaW5nIHRvIHRoZSBsaXN0IChoZXJlIGh0dHBzOi8vbGlzdHMu
ZGVueC5kZS9saXN0aW5mby91LQ0KPiBib290LCBTdWJzY3JpYmluZyB0byBVLUJvb3QpLiBZb3Ug
Y2FuIGRpc2FibGUgcmVjZWl2aW5nIGFsbCBtYWlscyBpbiB0aGUgT3B0aW9ucw0KPiAoTWFpbCBk
ZWxpdmVyeTogRGlzYWJsZWQpIGlmIHlvdSBkb24ndCB3YW50IHRvIHJlY2VpdmUgYWxsIG1haWxz
ICh3aGljaCBJDQo+IHVuZGVyc3RhbmQgOikgKS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIHJlc2Vu
ZCB5b3VyIG1haWwgb25jZSB0aGF0IGlzIGRvbmUgc28gaXQgbWFrZXMgaXQgdG8gdGhlIG1haWxp
bmcNCj4gbGlzdCBhcmNoaXZlIGFuZCBJIGNhbiBwb2ludCBhdCB0aGlzIGluIHRoZSBjb21taXQg
bG9nIGZvciB0aGUgcGF0Y2ggZml4aW5nIHRoZQ0KPiBsaWNlbnNlPyBBbHRlcm5hdGl2ZWx5LCB5
b3UgY2FuIGp1c3Qgc2VuZCB0aGUgcGF0Y2ggZml4aW5nIHRoZSBsaWNlbnNlIHlvdXJzZWxmDQo+
IChidXQgYWdhaW4sIGl0J2xsIG5lZWQgdG8gbWFrZSBpdCB0byB0aGUgbWFpbGluZyBsaXN0IDop
ICkuDQoNCkkgc3Vic2NyaWJlZCB0byB0aGUgbGlzdCBhbmQgc2VudCBhIHBhdGNoIFsxXSB0byBm
aXggaXQuIFRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nIHRoaXMgaXNzdWUuDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAxMTIwMjM5NDguNDYwMDgtMS1oYWwuZmVuZ0BzdGFy
Zml2ZXRlY2guY29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg0KPiANCj4gT24gMS85LzI2IDc6
MTEgQU0sIEhhbCBGZW5nIHdyb3RlOg0KPiA+PiBPbiAwOC4wMS4yNiAyMzo1OSwgUXVlbnRpbiBT
Y2h1bHogd3JvdGU6DQo+ID4+IE9uIDEvOC8yNiA0OjQ3IFBNLCBRdWVudGluIFNjaHVseiB3cm90
ZToNCj4gPj4+IEhpIE9saXZlciwNCj4gPj4+DQo+ID4+PiBPbiAxMi8xOS8yNSA0OjUxIFBNLCBv
bGl2ZXIgRmVuZHQgd3JvdGU6DQo+ID4+Pj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJv
bSBvZmVuZHRAZ29vZ2xlbWFpbC5jb20uIExlYXJuIHdoeQ0KPiA+Pj4+IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbg0KPiA+
Pj4+IF0NCj4gPj4+Pg0KPiA+Pj4+IEhpIGFsbCwNCj4gPj4+Pg0KPiA+Pj4+IEkgcmVjZW50bHkg
ZGlkIGEgbGljZW5zZSBhbmFseXNpcyBvZiB1LWJvb3QgYW4gSSBjYW1lIGFjcm9zcyBzb21lDQo+
ID4+Pj4gdW5jbGVhciBsaWNlbnNlIGluZm9ybWF0aW9uIGluIGZpbGVzLiBJIGRvIG5vdCBrbm93
IHdoZXRoZXIgdGhpcyBpcw0KPiA+Pj4+IHRoZSByaWdodCBwbGFjZSB0byBwdXQgbXkgcG9pbnRz
LCBuZXZlcnRoZWxlc3MgSSB3YW50IHRvIHNoYXJlIG15DQo+ID4+Pj4gZmluZGluZ3MuDQo+ID4+
Pj4gMS4gdGhlIGZpbGUgaHR0cHM6Ly9ldXIwMi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/DQo+ID4+Pj4gdXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUyRnUtYm9vdCUyRnUt
DQo+ID4+Pj4gYm9vdCUyRmJsb2IlMkZtYXN0ZXIlMkZkcml2ZXJzJTJGbW1jJTJGc2RoY2ktDQo+
ID4+Pj4NCj4gPj4NCj4gY2FkZW5jZTYuYyZkYXRhPTA1JTdDMDIlN0NxdWVudGluLnNjaHVseiU0
MGNoZXJyeS5kZSU3Q2M2NWQ1ZWQ3Mg0KPiA+PiBhYzk0Zg0KPiA+Pj4+DQo+ID4+DQo+IDNhZDdi
OTA4ZGU0ZWNkNjExYyU3QzVlMGUxYjUyMjFiNTRlN2I4M2JiNTE0ZWM0NjA2NzdlJTdDMCU3DQo+
ID4+IEMwJTdDNjM5MDMNCj4gPj4+Pg0KPiA+Pg0KPiA0ODQxMTkzMjc2NDkxJTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5DQo+ID4+IGRXVXNJbFlpT2lJDQo+ID4+
Pj4NCj4gPj4NCj4gd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lz
SWxkVUlqb3lmUSUzRCUzRCU3Qw0KPiA+PiAwJTdDJQ0KPiA+Pj4+DQo+ID4+DQo+IDdDJTdDJnNk
YXRhPXFLZ09HYWxMTVVSYWltY1ZyQ3R4Vm53TjBFRWxkd1RHQjFJMTVNN1Jkc1UlM0QmDQo+ID4+
IHJlc2VydmVkPTANCj4gPj4+PiBjb250YWlucyB0aGUgZm9sbG93aW5nIGluZm9ybWF0aW9uIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOg0KPiA+Pj4+IEdQTC0yLjAtb3ItcGxhdGZvcm1fZHJpdmVy
IHdoaWNoIGlzIG5vdCBhIHZhbGlkIGxpY2Vuc2UgaWRlbnRpZmllciwNCj4gPj4+PiBJIHRoaW5r
IEdQTC0yLjAtb3ItbGF0ZXIgaXMgbWVhbnQgaGVyZS4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+ICtD
YyBAS3VhbiBMaW0gTGVlLCBAQWxleCBTb28sIEBXZWkgTGlhbmcgTGltIHdobyBjb250cmlidXRl
ZCB0aGUNCj4gPj4+ICtkcml2ZXIsDQo+ID4+PiB0aGV5IHNob3VsZCBiZSBhYmxlIHRvIGFuc3dl
ciB3aGF0IHRoZSBpbnRlbmRlZCBsaWNlbnNlIHdhcyAoSQ0KPiA+Pj4gYXNzdW1lIHRoZSBzYW1l
IGFzIHlvdSkuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBNYWlscyBhcmUgYm91bmNpbmcuDQo+ID4+DQo+
ID4+ICtDYyBASGFsIEZlbmcsIEBNaW5kYSBDaGVuIGZyb20gdGhlIHNhbWUgY29tcGFueS4NCj4g
Pg0KPiA+IEl0J3MgT0sgdG8gY2hhbmdlIHRoZSBsaWNlbnNlIHRvDQo+ID4NCj4gPiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gPg0KPiA+IEtlZXAgdGhlIHNhbWUgbGljZW5z
ZSBhcyBkcml2ZXJzL21tYy9zZGhjaS1jYWRlbmNlLmggd2hpY2ggd2FzIGFkZGVkDQo+ID4gaW4g
dGhlIHNhbWUgY29tbWl0IGZlMTFhYTBiOGNhMy4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4g
PiBIYWwNCg0K
