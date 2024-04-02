Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05B2CD128A
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 01:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1F388344;
	Tue,  2 Apr 2024 03:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CE688346; Tue,  2 Apr 2024 03:19:15 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071e.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E1588322
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 03:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhlIXz3tSh0qetjC9voWrGWWLQmu1+U42uOVTQkFHCLPskIz0zqehpHD4oGej96Bsilm2WaoTPDyf27fVq+hN7iLsXvQPrcKj0c2yiUBHGbFRTqMmFPS6cSj7Pj/OXZCeIpntLordmsQnwph/v4JBKlL2YZTg4P9FpWozhU3BfqaXhNBc94rC6fHjy6r3cYFfjIPFpHrfJADbTYMNr+HgNoU4z9VSJ7r3XBVNhALusgQsybBNCClzIdUTOMKLmRsnKmkENpOybVhomBgDmLE677k/ciK6L0wn5paj/7SCXOZDcToGyeRkH29kIQ5bbMqY7FaZoTiY+OA//dw9LadIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOB/dl8v0zcbBNYVwnLtRvOpnojb+uHTf4yLNr8TqeA=;
 b=RX9bRgidXPZ+1mxjxuQrEDyJWDOk2YdoiIXyDiaSAiosE758MIiVKl8tUEAMYgyuDr9ndM+wee1zk5KO3ksXh7xNMGlgxoHo5HydPii4fagGmj7Ak+H6NuQJ+2rM+jXenq89f5NuPouEEHSH9fuxwDJ4zgyWlDPZmM/oGxs65opw24XmzKos+mw7OSYQQWLgW8eCRII2EQ6qFNnUF0oAR8j1uj/7zgZCvzoKjBoRjwy1gtAx8Fky/fjI2bi+OvQoYfD2xpoksvvmKTrqfkeFeCqXKqsbO1xnoiBfhKBmYjn7l0/eJcVTmNsXXdhFkOiIcBv2lwP2BrfvI5PqGfVYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Tue, 2 Apr
 2024 01:19:05 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.042; Tue, 2 Apr 2024 01:19:05 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Aurelien Jarno
 <aurelien@aurel32.net>
CC: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Lukasz
 Tekieli <tekieli.lukasz@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, E
 Shattow <lucent@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Thread-Topic: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Thread-Index: AQHae7tYHhP1OBwIJEuWo41kwhOK2bFHAJiAgAZaaQCABkAFAIAAB1iAgACdrMA=
Date: Tue, 2 Apr 2024 01:19:05 +0000
Message-ID: <SHXPR01MB0863C007C843146B8EA0A82FE63EA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
 <b5af9050-aa50-4445-9de3-4e5f368621b7@canonical.com>
 <ZgrSnExL1iTg8nSC@aurel32.net>
 <a94ea391-5b0a-49b1-8277-f6d018ce780b@canonical.com>
In-Reply-To: <a94ea391-5b0a-49b1-8277-f6d018ce780b@canonical.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0735:EE_
x-ms-office365-filtering-correlation-id: 51573d50-fe6a-4b75-3b02-08dc52b2e393
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJ4mUtxCnS5nWypmBgFy1gi0MkDbtAWcynRgSKIlcWjwrcokoM8ctx1M9eZGy4X6jeGDfPNBKzTyY6+w+0ZP9Ybs/C7Z2oyYP9I0P3Z7bcSg2QgzFzeGrL6Id+8zaOi31XVA4YyQ0bUAsDjJPyAmw6KY7dWqi6WLp2jGy6P8tKk3ZO8TDYlWu+cDAUcEWkiIe8y6eQSYAqgo3s5RrCNU+Cp3/FT1kP4qHzMm5TK5LeRvZA73HLVEpup2LXaFVzyfcWT+zUnGwpbDQrLcdZUObuj6IhdUBuAkNTY7y8tBkHI6Gs9Ctq3bnPrl8h8KNyBOZtNTZbjq7/2uH9Eo21Ql8ba8H+vDXmbf29VEn/JsdrxTShPxWpqICjYq46u3DYn6aoXPPmdhujWJ/+etn09zCW8+1En2iMAs+cUEGRsDn6T3FmZklzqXFSF6MGgQ8FCwdaEDcT4JWttWiRfLT5ouY9qT6OsI6R4Di4Pn40tSZGXfO7d92OOCNiljoJ0qU8esILli4kRdyY2m1NtOPCW8hNMWLm+vIMxtwFK6wbcYzHdKs8YFSFhUz0BA8effMHbLWPbPUeO3G3Awuz/ks85CqNPYDdc+uR0ORhEMREVPc6VKpERRZGOkuXUHVZ5ht3WU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(41320700004)(366007)(7416005)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bktYM3pPRlhPUGNkNU11M2FNak9KbzBrdkFxZFpOWEFQaTJYMnR1dEFPcjly?=
 =?utf-8?B?Z0h0V2Rhb2ZoMkRyaFhUay91UXpNQjh3TjAybUNpai9GSXBpWW9LQndQbnpo?=
 =?utf-8?B?UFkxRmJlRmNFaXRBSjR3ZTVndkR0U0ZZVlEvYlJCQnRneVoyYytmRlBGMWFx?=
 =?utf-8?B?d284bXdXWTk1dHdxb1gwbDhtQ1JORVVLVjAra1Z6WmxEM2lXZXJtdERFd1dB?=
 =?utf-8?B?L0g0Yk1STThYVjJJWG5VNHoyYmdwRlJGSm9ZdTVVTjQ0Qlg1T1RSUUpJaGJO?=
 =?utf-8?B?ODN1K3JHQ1M4QzhMYWRWMjMvVFVwcjMxa3ZCZDAvdjdwcmtoN2FvdVgrc1RH?=
 =?utf-8?B?dlRScnc5dU9pMC9EWVdSaEVWdjZtK0wvcE9HRkI3L2tRbnpxVGM4ekI1SjNi?=
 =?utf-8?B?L2U4TWdQQTg3YmVLOUdXRi9nblNYYzJlN1dyWHg1UnlMR3o5N3EzU0xoNE9T?=
 =?utf-8?B?UVN1L3FFRGswNFNpaGFPb1pqQUVYQ0ZTNlI3czFkTTllbEFNRDhDMXMyeFln?=
 =?utf-8?B?eGUxeTBNVEdjSHd4SzhpT2JjcFlVZzdGbnpqd3BkNzBYVTBVNFYxVitlMmZL?=
 =?utf-8?B?M1E2UWx4RG5zVzVVdXRST3QwYjB1SjJIek5UMVg3YnRhUVY0bllMeUd5UHhI?=
 =?utf-8?B?MG5TQ0t5c1Z2ZWpIRXIzSnBwcVBPd0IyblFwZ2xPM0NWVDJYZmlYdTZ3ckd6?=
 =?utf-8?B?UGpuQXk0QU15c3VhQnBYRHhjLzFYM1plTmdQRWFaQVdFcU0vdm02NnNvTUpI?=
 =?utf-8?B?ZnovQ05DRUpNRHFmN2R0dmhRTmV4NTJyOU43K3FhU09OcDYzZG0vOUNVQU9M?=
 =?utf-8?B?YkJHNE8ybTVrUUc4MG9HczN4bXNZL3p1QnErbTBlVGdsV2U3RDNVU2IxTlNP?=
 =?utf-8?B?bzhBLzI0d2lSUFVsVysycjM2eDg5dEdlRmRNT0x2UU9waUZVTzU1SVNBaHhq?=
 =?utf-8?B?MGVWOUNiRlVLUDJpTHZvUklmT3MvYnVuQXhmUzZZU0hiQUNaV0NCNmxZaUla?=
 =?utf-8?B?TmpiVmJBY01SSnhoYmkxTSsxcXkxYWN1YkxxTGM3MFRJNnZEQkYrWGhiQ3hR?=
 =?utf-8?B?UU5TN1ZuK0lRbENWbGs5b1J3d2xRRkhRUEdpVENTYnlnZVRudklFOHB3Q1R2?=
 =?utf-8?B?K0g0bGthTkFaYWFhRHQ4T1BrRmlKbUhDalpJZHhsblEyUlRNWmxMRGI0b2ta?=
 =?utf-8?B?VEMrZ2s4dGhLdVlZUU9DRTdFdzlWa3B1RGJJMjBlQjV4LzBsWGEzdlBVNnIr?=
 =?utf-8?B?UU5rVGI2c2h1eXVyR05yOGRuZFJsUGZqZ25yZ3UvMXYvektWbFlVaUtmRXQv?=
 =?utf-8?B?Q0E0TzNUL01TNGhlaUpERWxkWnppb2VJeW96Vnh3MHNudzlhdm1UWVhRVUpu?=
 =?utf-8?B?NlgzSG9HeXdWc0RpMzhHQ2tjUWVrakxHU0FJNFI1bXJCUDRaZjVHMHQ4NXhZ?=
 =?utf-8?B?R0IxTUhRcGtJSk9Gd0dxZHpmdUNNK2dDSWVEa2hZWmc4SlRIRTBET1NObXFa?=
 =?utf-8?B?MUdmdnR4YTBZUlFOaFo2eEhKUVYzdExhS2tIdnhITmVtc2VPdXFRaWJUV0U2?=
 =?utf-8?B?QXkyTUNGdUpDbnNwMS91THp6S0lRZjlZcElicERmclBFN1R0cmM3cDkzaklh?=
 =?utf-8?B?Z3ROQ2t4MWVPVkVzb1RyZGsvRGFaUFBraHE0angyWFpaemMzTnUxUFVMclkw?=
 =?utf-8?B?UEI2WTBHRkdWUlpSeW94bngrZE5xdkJiTkw1MXFGNlNsQlVlWFRnaWdiTTR1?=
 =?utf-8?B?ZE1WSi93S1FMUUpKY0tLSTZ3UFhTQ3llSTJZUXVPZ3NLYlJHZnRBWHJ2cTdE?=
 =?utf-8?B?YlRINHBxTUJUSEFMUlBKUWdrVytpdWFURnpZdDJ6VWdYaUVIWFFuZ0pTUXFH?=
 =?utf-8?B?azFSMDA3LzZzaTIvajkvUXJTQ0IxeHgxN1hXMk5DTFluY25tSTh4d2drVkM4?=
 =?utf-8?B?RXlqbWRSKy9EVnFXcWErZ25BYVJuZ01Na2V5K2RacVJZL3dFd0U0RTMzWjY2?=
 =?utf-8?B?djIvbVJtdHVTaUk3c0pra3EwREZWMVczS2Y4dUREY3Y0OGh6R1E4UTNJSDhW?=
 =?utf-8?B?ZEtpWjVhblFrSWdDenZWVXUya0dWQVZsbTJDZDBLYWdmbGFQN2xscjNHcXNN?=
 =?utf-8?Q?IjWamIlddO5miv8ssOr6lGoOc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 51573d50-fe6a-4b75-3b02-08dc52b2e393
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 01:19:05.5179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMQiKeqxzHWUZR1yzSirkFnd36Vj7cqnfjvmtouBItdwbfAB0zVbp4N+Szjqr1FlEIGnj8wDD4rOaHdjkMaweHYZJxtKr4Wo/voV4wjIjbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0735
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

PiANCj4gT24gNC8xLzI0IDE3OjI4LCBBdXJlbGllbiBKYXJubyB3cm90ZToNCj4gPiBPbiAyMDI0
LTAzLTI4IDE3OjAxLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPiA+PiBPbiAyNC4wMy4y
NCAxNjowMCwgQXVyZWxpZW4gSmFybm8gd3JvdGU6DQo+ID4+PiBPbiAyMDI0LTAzLTIxIDE5OjEx
LCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPiA+Pj4+IFRoZSBkaWZmZXJlbmNlcyBiZXR3
ZWVuIHRoZSBNaWxrLVYgTWFycyBib2FyZCBhbmQgdGhlIFZpc2lvbkZpdmUgMg0KPiA+Pj4+IGJv
YXJkIGFyZSBzbWFsbCBlbm91Z2ggdGhhdCB3ZSBjYW4gc3VwcG9ydCBib3RoIHVzaW5nIHRoZSBz
YW1lIFUtQm9vdA0KPiBidWlsZC4NCj4gPj4+Pg0KPiA+Pj4+ICogVGhlIG1vZGVsIGFuZCBjb21w
YXRpYmxlIHByb3BlcnR5IGFyZSB0YWtlbiBmcm9tIHByb3Bvc2VkIExpbnV4DQo+IHBhdGNoZXMu
DQo+ID4+Pj4gKiBUaGUgRUVQUk9NIGlzIGF0bWVsLDI0YzAyIGFjY29yZGluZyB0byB0aGUgdmVu
ZG9yIFUtQm9vdC4NCj4gPj4+PiAqIFRoZSBzZWNvbmQgRXRoZXJuZXQgcG9ydCBpcyBub3QgYXZh
aWxhYmxlLg0KPiA+Pj4NCj4gPj4+ICAgRnJvbSB0aGUgZGV2aWNlIHRyZWUgdGhhdCBoYXZlIGJl
ZW4gc3VibWl0dGVkIHRvIHRoZSBrZXJuZWwgWzFdIGl0DQo+ID4+PiBzZWVtcyBhbm90aGVyIGRp
ZmZlcmVuY2UgaXMgdGhhdCB0aGVyZSBpcyBhIENEIGdwaW8gZm9yIG1tYzEuDQo+ID4+DQo+ID4+
IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLg0KPiA+Pg0KPiA+PiBPbiBhbGwgb2YgTWlsay1WIE1h
cnMsIFZpc2lvbkZpdmUgMiAxLjJCLCBhbmQgMS4zQSBJIHNlZSBHUElPIDQxDQo+ID4+IGxldmVs
IGNoYW5naW5nIHdoZW4gcmVtb3Zpbmcgb3IgaW5zZXJ0aW5nIGFuIFNEIGNhcmQgdXNpbmcgVS1C
b290DQo+ID4+IGNvbW1hbmQgJ2dwaW8gc3RhdHVzIC1hJy4gU28gdGhpcyBzZWVtcyBub3QgdG8g
YmUgTWlsay1WIHNwZWNpZmljLg0KPiA+Pg0KPiA+PiBDb3VsZCB5b3UsIHBsZWFzZSwgY2hlY2su
DQo+ID4NCj4gPiBUaGlzIGFscmVhZHkgaGF2ZSBiZWVuIGFuc3dlcmVkIGJ5IG90aGVycywgdGhh
bmtzLg0KPiA+DQo+ID4+PiAgIEZyb20gdGhlIHNjaGVtYXRpY3MsIGl0IGFsc28gc2VlbXMgdGhh
dCB0aGUgdXNiMCBwb3J0IGlzIG5vdCBpbg0KPiA+Pj4gcGVyaXBoZXJhbCBtb2RlLCBidXQgaW4g
aG9zdCBtb2RlLiBUaGF0IHNhaWQgb24gdGhlIHN1Ym1pdHRlZCBrZXJuZWwNCj4gPj4+IGRldmlj
ZSB0cmVlIGl0IHNlZW1zIHNpbXBseSBkaXNhYmxlZC4NCj4gPj4NCj4gPj4gQWxsIHRocmVlIGJs
dWUtY29sb3JlZCBVU0IgMy4wIHBvcnRzIGFyZSBhYmxlIHRvIHJlYWQgYW4gU0QtY2FyZCBpbiBV
LUJvb3QuDQo+ID4+DQo+ID4+IFRoZSBibGFjayBwb3J0IHByb3ZpZGVzIDVWIGJ1dCBJIGNvdWxk
IG5vdCBtYWtlIGl0IHdvcmsuDQo+ID4+DQo+ID4+IE9uIHRoZSBzY2hlbWEgSSBmb3VuZDoNCj4g
Pj4NCj4gPj4gVVNCMjA6IERvIG5vdCBzdXBwb3J0IE9URyBtb2RlIGFuZCBBVlNTX1VTQjAtQVZT
U19VU0IyIGF0dGFjaGVkIHRvDQo+IGdyb3VuZC4NCj4gPj4NCj4gPj4gQ291bGQgeW91LCBwbGVh
c2UsIHNwZWNpZnkgd2hpY2ggbm9kZSBpbiB0aGUgZGV2aWNlLXRyZWUgeW91IHdhbnQgdG8NCj4g
Pj4gZGlzYWJsZS4gSSBjYW5ub3Qgc2VlIGFueXRoaW5nIGRpc2FibGVkIGZvciB1c2JAMTAxMDAw
MDAgYW5kIHVzYkAwIGluDQo+ID4+IHRoZSBrZXJuZWwgZGV2aWNlLXRyZWUuDQo+ID4NCj4gPiBE
aXNjbGFpbWVyLCBJIGhhdmUgbm8gc3VjaCBib2FyZCwgYnV0IEkgcmVtZW1iZXIgcGVvcGxlIG9u
IElSQyB0cnlpbmcNCj4gPiB0byB1c2UgdGhlIGRldmljZSB0cmVlIGZyb20gdGhlIFZGMiBvbiBh
IE1pbGstViBNYXJzIGFuZCBnZXR0aW5nIGFuDQo+ID4gZXJyb3Igd2l0aCB0aGUgVVNCIGJlaW5n
IGluIGEgd3JvbmcgbW9kZS4NCj4gPg0KPiA+IFRoZSBkaWZmZXJlbmNlIEkgaGF2ZSBub3RpY2Vk
IGlzIG5vdCBhIG5vZGUgYnV0IHRoZSBkcl9tb2RlIHByb3BlcnR5Og0KPiA+DQo+ID4gJnVzYjAg
ew0KPiA+ICAgICAgICAgIGRyX21vZGUgPSAicGVyaXBoZXJhbCI7DQo+ID4gICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPiA+IH07DQo+IA0KPiBUaGFua3MgQXVyZWxpZW4gZm9yIHRoZSBleHBs
YW5hdGlvbi4NCj4gDQo+IFRoZSBub2RlIHVzYkAxMDEwMDAwMCAoYWthIHVzYjApIGRvZXMgbm90
IGV4aXN0IGluIHRoZSBVLUJvb3QNCj4gVmlzaW9uRml2ZTIgZGV2aWNlLXRyZWUsIHlldC4gVGhl
cmUgaXNuJ3QgYW55IGRyX21vZGUgcHJvcGVydHkgZWl0aGVyLg0KPiANCj4gV2Ugd2lsbCBoYXZl
IHRvIGNvbnNpZGVyIHRoaXMgbm9kZSBvbmNlIHdlIG1lcmdlIHRoZSBMaW51eCBkZXZpY2UtdHJl
ZS4NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiANCj4gSGVpbnJpY2gNCj4gDQp1c2JAMTAxMDAwMDAg
aXMgY2FkZW5jZSB1c2IgY29udHJvbGxlci4gSW4gVkYyLCBkciBtb2RlIGlzIHVzYiBwZXJpcGhl
cmFsIGFuZCANCnNlbGRvbSB1c2VkIGluIHUtYm9vdC4gU28gdGhlIGNhZGVuY2UgdXNiIHdyYXBw
ZXIgY29kZXMgbm90IGluIHVib290IHVwc3RyZWFtLg0KSSBkb24ndCBrbm93IHRoZSBkciBtb2Rl
IGluIG1pbGt2IDcxMTAgYm9hcmQuIEJ1dCBpZiBpdCBpdHMgZHIgbW9kZSBpcyBob3N0LCBJIHRo
aW5rIEkNCm5lZWQgZGV2ZWxvcCBjYWRlbmNlIHVzYiB3cmFwcGVyIGNvZGUgdXBzdHJlYW0uDQoN
Ck1pbmRhIA0KPiA+DQo+ID4gVGhpcyBkb2VzIG5vdCBhcHBlYXIgb24gdGhlIHBhdGNoZXMgc3Vi
bWl0dGVkIG9uIHRoZSBMaW51eCBzaWRlIGZvcg0KPiA+IHRoZSBNaWxrViBNYXJzLg0KPiA+DQo+
ID4gQXVyZWxpZW4NCj4gPg0KDQo=
