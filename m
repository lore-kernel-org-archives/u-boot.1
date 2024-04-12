Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF986C04FF9
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BAF881BB;
	Fri, 12 Apr 2024 22:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="YDLSXcZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D19881BB; Fri, 12 Apr 2024 22:34:52 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C50988080
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4pbyRnGJC75Zd3aLShbuB/H/bGbjtHlmvpZFl/Ch2/tpJ0D2gN9lND8V+BmmEuKiGYFsrjDdXlvUpdjRq+ILWnyMh31FaE35wov00VHrLw+bt6IwIllOsuAAWO7pTF6vXJzExHZ4qBP3y/ilhqQeLaOLXnFeU1kCNrkVr9VEtcKPY64/+MUppK92st55o3+ZdhbK0ExZTJSLqo7IIDCVOHF3UYxGPxawistHxYgzSQPjBn/ZnqEn8Fm6KX9ol+zsji/cedMeU18gtAjHJALeG12t5f1XFLxaAvesSeB6vsxEghIpGwdW611QkzON21QsbPz5262DQQDlprw1f6bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Cg1EpXlLVlVwj8W3kErLRZFEMbgYBlebt4e7uzaK8=;
 b=D+b91k3GVbUxtQQ7eoyC4dUbodG2TDdHp9ZxRgmW/hEwleSVs3xd1zZWiRPexm+EmHj/h9Z7HNAQQP21VpRUe2ys/EXxp4uMFbXoPHO5PENNxrC9pGktFxFjbG2RfKmznpsfsAUYxGEZx9db/OOkbhfnDvuzevHj+MkJaXfmkF/wjVd0/nTtNSaj3HxY3YzqHDE89mz0vf+vKD3s9M/JaqE4tDPnopadDTSBQqDlK/O91i4rMUMclGFJGdy7RMMqIE1Zmq7pHE7V08zNuSHKVRTywxkOOjdbQGxxzbPeQwcfzdWhSMMV3jTKqFi26x8OjlLDiwwRroQWEsW0vnxYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9Cg1EpXlLVlVwj8W3kErLRZFEMbgYBlebt4e7uzaK8=;
 b=YDLSXcZDy5Ijo9pL1J2CvO2VH9UN8y9x2I3u1U4KEijKGnPE44QJVN4WSV5l5SoynZMCJRmDKzoOw0Pz/IoNx9ngBFC2TabjxL12aKFOsnbwKWodotP3DDyyBwoNrJxFUPYM4dFHp/KZqi1NYw+mdMNMebyTUWWE9bmY/Vo0PYYpAECuPs5YxEmKLhKQWsHzwJMZZtwzsayBDfUTZj2VMjLU0lmHxJEFUJdK0JB8He3yATWxiSNfgWYLf7WQF80QhuIq+qJyu+/OppCTIKmYRU3sK3Ug8lv+ZDuD/nB3RKxl117OxZZPzOuSX9B8huZ6cEOdtHxYTyRh/WNRntePog==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:34:48 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:34:48 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "marex@denx.de" <marex@denx.de>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
Thread-Topic: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
Thread-Index: AQHaRTTXpz9MrTdfEUCr+V0Sdlq6vLFlp08A
Date: Fri, 12 Apr 2024 20:34:48 +0000
Message-ID: <19f06316d3bf3c07d2e67d79bc9a4ef24c2b0ad4.camel@siemens.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-2-sjoerd@collabora.com>
In-Reply-To: <20240112085317.1866449-2-sjoerd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3912:EE_
x-ms-office365-filtering-correlation-id: 1655980e-de88-4a3a-3cd2-08dc5b2fff56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFcDF1qVJbRmHJ2ZolMpqz77J64/vQzVhWXB/N2jZ0C896GQ7sEIyiC2IbEsOBAwHYmT3Dw9b7UNmkmg6L+1VYoLFipaPmxdU7lRE+FneuEU7pQFt9riAdlDMlpOEFfsS0ThFPc+9n0SVGH0l0ulNK9PXyYE7CXZpVXCpBTDcSIJEtRqDX2jQTWTpAt7aeV8jcbF+dr7hGLBFGslTOlSTNiWAZt1UjZewj7kAL3J2dhLyePJpV1wEEj/R1QuznPcip/Mors2BCFo1yNMTHtLACqkluS/c9ffzWW3V9rRSWgnZ0RV49qIx+Y8EoQ04O7jghogXGrPnl2+/7ixF7FtFzsDxJ+cgj7BAXD+FHuCUF7LDDd04kX2cmT3BOSml0q02rDoOZH7le+i9kHwklJ5Jwx3NnoR0sJgru21nLylcI7yixS/J58BsPwwJYll1n5a9/YPbUmcNQ44XCs9ayjCCq4dMp4eVZ4O2HA0dtFTOWFrh5rLIaxtn8VonTmnSPUOM7zxKwvgwR8DuB6Aj3Fgq2IAO74EFnTU+3swLKr/Kfy5fggyGQifyZtGir/7Ve3vIDzvjggOdGhANMxHWXX8M/L9u3r+EsKMlDugrQtMxsuhmYcdV8tjKYND2vCD0Ca+UPEj1DO+RwW3dsJ67pCarD3qcsjeoF10TbRHkKGdyJM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm9qam1tb2c4emEwQm8yQXFHQ3ZHdGs5T0tYSmV5S3pkYmxkNVhFRUR4Ny9r?=
 =?utf-8?B?Z2pIdHZkdVlqNEU2cnJ3ekJGelVFZXdDMEVtSXhjY1Q2ZHBuNEpaa3hkK0lM?=
 =?utf-8?B?V1VLNDhsY3A3TE9SczFROFgybEc3MmJQUkVFQi9zYy9LQTJOZWsvWmFiMTJQ?=
 =?utf-8?B?QXl4VlJsZ2RUeTBOQm1vS2lMQ24rK2FCbUZjOFF2T29MdUczNG5IVHlnbnhS?=
 =?utf-8?B?ODdJYURwRExIKzBiQ09jTkIvdDF0VnpMb3ppaFVLNW1EcTR0Z0tDcVhNL2Nt?=
 =?utf-8?B?SGd0U2MrOEducS9LOHlWZzN1dUlUdVBKSERPRDVzSHR3MTIwb3BHQ1dsNUpE?=
 =?utf-8?B?OUhSMExyVkxSMXhnZ3JyTXlWSTdmR0xjc0swV0YwZjNpMHdvdlNaTHBpeVFB?=
 =?utf-8?B?S1V4QlVVZnJDbDJLUkQ0Mlk3M1NveEJqNStMeDE5a1p5bXhwNjVtRjd1c1NE?=
 =?utf-8?B?WmtuR3I5VTVYRndvdUcvNFZPQlNlRElkYWtFSEJWRXpjRDd0M21VeW5QdmdC?=
 =?utf-8?B?ZkFWYTRqWVB4UjNYZEN2UmlOcmlJcmFPQ2Q5Y3FMZXNzYTFKcEs4a3FrZ0xr?=
 =?utf-8?B?ai9pWS9kQmxKYmJ2dyt0Um41YXdsdmN5Q2JsL1hvYXRRSWxTWWxOUWZTVytT?=
 =?utf-8?B?WnZTSVdyWE95TW5pdWh3WmttVGdRVDVQdEsvSnFOcEdZWDEwNENhT0orYWpy?=
 =?utf-8?B?S3ZFRWxLMnVpV05pK25MZm11UFpzdWZHdVVBeHpoeXhKR2VVa0NHRHM5MXhI?=
 =?utf-8?B?SjBWWXlXQXlvS044YzVJSXpNTVhmMDB0bjBkM1lINE1aN21JR0taeGd5dzFx?=
 =?utf-8?B?WWptUWlRcUhnQk1NWUFYRDJJMFFLUXVSOGpsbHRpTUpJOUdFVEhieGVVYlI3?=
 =?utf-8?B?NlBTN2dSdm10TVFDZEd1K0lnWTlRdXByK2Fya1ZzdGdBZms4QVhneFhTZ2h3?=
 =?utf-8?B?R3lSalBRcWUzWlN0bnQyZXU4QThKdmwvT3IwTmxtZGpIUUxHaWZCVWVpaE5L?=
 =?utf-8?B?OFB3RThDeUFQQVZJL283a0pPWjlBZFg1WERNbThIT3RxclBjT3VBODFiVGNo?=
 =?utf-8?B?RThBVFJSL3NURmdHeVBESXRXYWxGUWpTOG5ZZ3g2OVhnZlVBRHNTLzV2bGdG?=
 =?utf-8?B?c2UzWDdTb1R4bCtybnY5OGNuQ0kwcHpKRDdvVzU1cDIvOTRycW11bDl3N0lL?=
 =?utf-8?B?RWNiV2FNUFpnbFNvbXpWbDI5aENUT0VPNjhhQzkvSldwRXhBQTgrQ2x6ZER0?=
 =?utf-8?B?RUhjdzA0VUlmaForc281c2xyWHBUTGpyTGVZQVVuZkoxQ3BXOTZ1SjRGZnZQ?=
 =?utf-8?B?anFBL3dCdytEM0t4L3dhWmVqMFFQQjIzbElwZkFZVUhxZGxVMzhoV2JONUdD?=
 =?utf-8?B?OUg4UHpyenpFV2FONm1lN2UyT2NuZU1JV282S3BiVUkyL1N3ZUdpMmVoWG9W?=
 =?utf-8?B?cU5EVFVuT3ZNQXVuR0RJQ21saXQ5VHloVFlrUjIrcnk3MERueU02UjBYVXVM?=
 =?utf-8?B?SkVEaVRuamxReVV0NTJ6bmtsbXQwZUJkeEVsZ0t3MnZiWElRR0h5WEtqcjRI?=
 =?utf-8?B?Zk12VWUvWWV5bHFGK1U4SzQ2cW9jd2Y4YU50QS9lQ0Rld2M3d0M0SWFFMHJU?=
 =?utf-8?B?NXpTYWlSMDNHUnNkL0YrYWsyeEFuc1BaMUxWdWUzckZxOXZmaVdPdE1ncEZM?=
 =?utf-8?B?cUtlT1JoOGoweU5HRENsTEdNL1o0UkdmR3F1M0F2MnBZeE9DRHFYNWM5WFk0?=
 =?utf-8?B?S2FSOFVuSGhJZzNiVXc0N0Z3WjZFNldOaGd0TVNJMHVRc2ZYdnVrTE1UMkRH?=
 =?utf-8?B?OHRzREpOTktLbkZXeHRIWkVwalNLUlE1N0NsdXQ1NERSWVM1QTNHRUJsaWdU?=
 =?utf-8?B?YzdkVFM3aFRtN3NmSmttb0d6Qks5eVlOQktMRlQzcXhuR2tWTHJaSENSSzBa?=
 =?utf-8?B?bytaWjQ1SHlMV1BzRXFQOGJhOU1YSGZKMUFqL3NHUEtydUhwZ1NsbUhPZ0hv?=
 =?utf-8?B?a2orVVM5NUt1VjBFT3VXbnhZNmtNWGQxMDRJdHQyVUM0VXQ2QXlHM1pMR0Z0?=
 =?utf-8?B?TmlVRU14ZFlUYmJ5Qkl1V2NSR29TVHBRZ1Q3RkhlaXgwZVJDRnc4ekRqckdq?=
 =?utf-8?B?clpKa0FEMGQydVY0YjNYTWM0UmdaZHhlNExzWEtDZUFxYXNHdEhyemVGbFpu?=
 =?utf-8?B?cWhxbFBaVjJzSmt3Mmt6WDRyOTB2YittOThyRWp3Q1E4cWg3THAxNGV6ZEl0?=
 =?utf-8?Q?SJTHDL/pQ46aEeBOL/k2VChN160rIpJJv2dUjLE114=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <329B29A3F4A9CB41A57D6F7F7DA21A14@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1655980e-de88-4a3a-3cd2-08dc5b2fff56
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:34:48.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mlYQ+CEx0FOxW9mlkEgPSrFUebtcCihoGw7xVw9l+NDDmy5e2CeKgbC6BJ98WFlMFB7tEkhUXwNlbxqbHWV9vCJs+SASjf7wDlFqZGxXYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
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

SGkgU2pvZXJkIQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZWZmb3J0cyBvbiB0aGUgdG9waWMhDQoN
Ck9uIEZyaSwgMjAyNC0wMS0xMiBhdCAwOTo1MiArMDEwMCwgU2pvZXJkIFNpbW9ucyB3cm90ZToN
Cj4gQWRkIGdsdWUgY29kZSBmb3IgVEkgQU02MiB0byB0aGUgZHdjMyBkcml2ZXI7IE1vc3QgY29k
ZSBhZG9wdGVkIGZyb20NCj4gVEkgdmVuZG9yIHUtYm9vdCBjb2RlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2pvZXJkIFNpbW9ucyA8c2pvZXJkQGNvbGxhYm9yYS5jb20+DQo+IFJldmlld2VkLWJ5
OiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29ycGVyc2hvZWtAYmF5bGlicmUuY29tPg0KDQpXb3Jr
cyBmb3IgbWUgb24gQU02MjMyOg0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxl
eGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2
NDoNCj4gLSBBZGQgY29uZmlnIGRlcGVuZGVuY3kgb24gU1lTQ09ODQo+IC0gTW92ZSBkZWZpbmVz
IGFuZCBjb25zdGFudHMgb3V0c2lkZSBvdXQgb2YgZnVuY3Rpb24gc2NvcGUNCj4gDQo+IENoYW5n
ZXMgaW4gdjI6DQo+IC0gU3dpdGNoIGR3YzMgZ2x1ZSB0byBhIHNlcGVyYXRlIGRyaXZlciByYXRo
ZXIgdGhlbiBpbiBkd2MtZ2VuZXJpYw0KPiANCj4gwqBkcml2ZXJzL3VzYi9kd2MzL0tjb25maWfC
oMKgwqDCoCB8wqAgMTQgKysrKw0KPiDCoGRyaXZlcnMvdXNiL2R3YzMvTWFrZWZpbGXCoMKgwqAg
fMKgwqAgMSArDQo+IMKgZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDEyNSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTQwIGlu
c2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWFtNjIuYw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1l
bnMuY29tDQo=
