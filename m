Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF2C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F047B87F1F;
	Mon, 15 Apr 2024 14:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="of6Rz+XY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD69688189; Mon, 15 Apr 2024 14:55:51 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F8087F1F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK1e2mfeLHWCG1GsraXX/LDxO+JgzjhjzzrU2hzMRB4qyqqgM0RmVjKh/LXRpueL1/n9cM/q4KUJ/HEiQXAY3eymA/FqR6VKfqeQ3XKCXPgR/sWbE9c9hQ7LxR7W2nKshTIHkrDpMITocNGjtftPhin80k8F+JQZ720p4nETstYGPDwlzO1//V2H0j1CvC6dMFyzfc9lXZUgghn6smrgir/5x2R2Y5ZHnqnhOY0Vad+fH9kN48TOjf5KhzsTqm0VcDsdGtaCeB9hNBsG7DuAggQNFab0LfYWAVhie//T0IF/wZu4ArAuZR7c1ElkRSlaAR/s29nG2Xgcrp6l2GAFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st1BfWzN7DlnjbC7odWTaWhAYv6TvaYqYXPaVDwrcRE=;
 b=fT0tHocUzZG2tS3/gLthuEWRBI2LqXCjDprwQASHOSv8HzM3lXgtOf3T300KgXFSNUHOx4fOlgXxyCEfRFkapnOe2eqlypRVlG3d26E318NyKGDEwXVWR/TvbAlAqhWw3kdw5ipKIlWf1UfiXkLQ5JxgjJ5H7n8WW+cVAmYZiY99VC/J3k5vkpL+0zfOzcEgrGL03QTpsLEfnJcK1vbxkDXrA9zQly1sdNmoTGmGaZiwvYuSq6cH+l44A0a42mAB1mn/9xKhn2mwYH7cff9RP2oIgg3nv/a/HNS3Xfg2lFEeBPna8FINTi0IM9zBxzh6B+2uDDSsMwHDBX5HAEcLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st1BfWzN7DlnjbC7odWTaWhAYv6TvaYqYXPaVDwrcRE=;
 b=of6Rz+XY/tFuKGHWAsogaplg//x4sg0hakUUFcajpIBxkep36ZGt/QgYhuUk+Et0BEuJlysJY5rjQCl7kkl9mSuWpzKZzW3eTmjnqzZSnBIT/BgLlzrhN3EC/scI8quSgPg5hEQdZvExAxq/97kpImjMSL1WmqTYxX4U83SW3SY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8365.eurprd04.prod.outlook.com (2603:10a6:102:1cf::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:55:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 12:55:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Yannic Moog <y.moog@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Wadim Egorov <w.egorov@phytec.de>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, PHYTEC upstream
 <upstream@lists.phytec.de>
Subject: RE: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHajNzKRskkoh2nsU2GGTVdt4HhK7FkpDqAgASk8QCAAAUHsA==
Date: Mon, 15 Apr 2024 12:55:47 +0000
Message-ID: <DU0PR04MB9417723DD3E5F4010A2DB96388092@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
 <CAOMZO5ASD3HuvUMXc6tmStE1AKRheW_NLUjRfpN5HuJ64ZF-Cg@mail.gmail.com>
In-Reply-To: <CAOMZO5ASD3HuvUMXc6tmStE1AKRheW_NLUjRfpN5HuJ64ZF-Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8365:EE_
x-ms-office365-filtering-correlation-id: 31b8c4e2-7de6-4a25-0f16-08dc5d4b5ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7z1z22Hd6qaqK08Uk6Hv2HA2xgPDgJyfYwk6LdCy12DQIWpnX+qoSdusChO+i/F6NpqGCoyIDXfVRuYcxm5ReWkfaY3k4IQgkcfxWpKexsoQ6Aw23mBSUsKPq7BCQj08+Tnz9YJVsabqtPW5pZtJE9yV5cz5cRRIpKOsg+4TGgy7MVNIYZrTO/Q5RswfPpLjDmMJscQpmE9sk2qILisvezOj+DGKzJVXtqhfI/Os8z4fYjLf+Rv2hIWAgW5STiLgHsIdwUQUVzqU4x7yLQGm+CwgJyr/P/o24OCND7lTnkzNP0FJRx4rYIru0PfItkPJ2Xl1y2QcgESRDSxm66lZIsYrwqd5SqUf2FiXL4fUEMVWWO0zCsPD42zCPm7TfDJ2me0/14/lnVr2DAr10Xg6uEf+0ipHS48MJ+L2tt3TjxS2U3xW6ct12fSE4e2AF4Gyk1oW7Zn3y4QjZoflisGHZVavyHrNSzPoJGokVtyjYzxhVZS3Qty1xKdbhhwvS1uZtYaeVNAiuaQQxiognQ0HlP4/0l7FHll9iGBCK93hTzioToBS5szCF5Y9yVkcp/WGVUzkzHXNUAsCgAyNyfe6i5Ab4sAyCw7NIERaTua4SoZb1DzfFiBv7ovcEEnNgYEEFxwfxT93JtU2/k8kLWwQ7JTxjJnOR9XIGyOItgJJuAMphyh471Yv7EbTo60LjkdC3IuUE+dFpoeVUn7cx1HtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllZaEprU08xZkVXa253ODVtaTZUZS9IVDBJZGptUHlnQzNJQjFCeUR2T1Vl?=
 =?utf-8?B?STAzL0ZLbjhTaGJhSGZFam1BcU9rZlJQVmo4dUVyenpaRXVxVTIzTG1hNmJH?=
 =?utf-8?B?V00xQ0VhN0tudGJBZ3lrdTQ1UkdpY0NuTTBGd0EzK1JIYUU1K3RETVJRbDZu?=
 =?utf-8?B?dUQ2Vm4xc3ZrUkltY1Q0MTVuNkN4SkN0U21LL2N1NjZHem9zSnQ3eHY2T0xw?=
 =?utf-8?B?OS8zQjFmSlZKR1R6RHBWZ2tOR0FqM3JBL1B6bEx6SlNrb05ESHFsUzJuTXdL?=
 =?utf-8?B?NlFEVGFGL0dhNGFkdzV3TnE1djVTbFRQM2IrRlZBblQ1VlYwYzBLQVdsOXZS?=
 =?utf-8?B?RmlDM0F0QU5rS3pEcC9tZmZyS1EyQ2FFaEdMNkY3SmZqcCsyaFEzN1hKOFBl?=
 =?utf-8?B?blFYWHE4bW40UVZUZUZhOTVTT1dabll0b2FKbHp5V011K29ZMCtDLytmS2dk?=
 =?utf-8?B?MUo1L2pyb0xWSllVSHh0MXAxMTlkc014STZZNVFDR2crcmEvSldxSGtoVUxW?=
 =?utf-8?B?RlJrWHU5anZLMkYwakFBdE9QOXJIZ1hSZy9YUS9sN25XQ1N0ZVdCU2RNTHZK?=
 =?utf-8?B?Z1Y4cFZOZ05pT1dQQndiRis2dUR4WHk4SWJLYW9VOExoK3o3Y1FJUk5haHhS?=
 =?utf-8?B?c2VoMXhncHo4QzNrQ2M1dnFrbWhSV282L1pVQXZvNklKeEdnaXFDTWk1ZTdB?=
 =?utf-8?B?UTlVaDc0a1VuVE8wM0VaVlA2UUhGblVhbkFxTmVEeHNzcG5pTXk2dzF3YWdo?=
 =?utf-8?B?RlBBRW1jelQwQkE0Q25IcU9qeUlXQzRIMDZxYk1CV0I1Y3JFSnRaMXJwUmNB?=
 =?utf-8?B?REF4NU84MzRjNkFzcXZ4VnFQOGtmbjQxY0hwbDBUWEQ3TzdSem5yL1lqTzdH?=
 =?utf-8?B?ak9kTkNxd0lMZGtYYkdBUHptbWNKODZLRzlLL1hSaDJ5Nk1xblNqbzU0UGV3?=
 =?utf-8?B?ZllFR2MzNkZzdGs3cTU0Mm52b3BwMnVFQk9zeHhldUJIdVd2OGRuNDJ2Qy8r?=
 =?utf-8?B?dUsvMVRRRDJ4bUw5SWYvOVlGL0I4dlhFVEdwMmtzOTZSd3VQNGtIQ21hNUE4?=
 =?utf-8?B?bmU1amdYRHIrZ21ob1M1ZUZibHpqRFA0WUhIRXRkQWhDYVNyVGpRZzZxUW5m?=
 =?utf-8?B?TlhGYzZKMGgxWnM2RTZ4SWN3WGhLWHdCb0xOOFVKNDUvbG5yRk1NSURzSm9k?=
 =?utf-8?B?OGdCb1hvMFFzYmNXeWNnWlJ0MllMSFFBVGdWVWR0VElSMG56Slk0KzM2ek45?=
 =?utf-8?B?S0xvR005a21QM09mRDhHZEZzaXU4MDlQT0hWdnl2SmRFbGp3UlRtYjBpTjdH?=
 =?utf-8?B?S093ZENGVGR3cXNiUzFiTXBMMHFMeWl3VzB5RUQ3UnMwRnhBU0xxTUhYaGZ5?=
 =?utf-8?B?QVRjOUIvWmgrb0prR0tZS3NQOWk4K2krYmN1ZVNtQ0RuMGZiVHNGOXZaL0o1?=
 =?utf-8?B?L1puTjdpL3Z1aml0azJoK0pyS1JsWnErUjNIYk9MaHpOd3BySCt6SzVjNFZk?=
 =?utf-8?B?ZGhydUI2aXRhUjFTSWpYSXJkbVdJdmJNbEI0ak90QVRYVlI4a1l5bm91Wi9D?=
 =?utf-8?B?NXRqNXZMb0NWb3c0ZW4xMVVIZStTREt3N1JESnRlazU3NHZ3anhpM253U3RL?=
 =?utf-8?B?dHovNW05ZmJyNWt5WDQxb3NxOFBtUGJqYTlEVm5sbSttUzRoQU16MnZicnRU?=
 =?utf-8?B?TXovUzBvNlJJY2llQ3A0WFQxMXVqaFlVOHJTWEZmV25mYUJ3KzRSbzMwUi9s?=
 =?utf-8?B?VWpWVDVjeG5qb0h1RHRBb3Q1c0thRU5WUHhLQWdCam55MXAxai9TMW5na2JG?=
 =?utf-8?B?dVF6NVA0NWJZVjRvTk80VXR2bHVQNVJicW91QlpIdEswNnVYeVV2STVJbndy?=
 =?utf-8?B?MWEvOGlTeVdjNUx6c24vNzF6R0RQKzZWbEVCSGtrR3JscTdlUzFtdlIzOWNM?=
 =?utf-8?B?WnNsc1ZGYnYyNSs5ZGtYOGRIWUpTUlN4MWt0bnl5VHlIbHB4MXpWZGMySURT?=
 =?utf-8?B?QXh5N3h4MnVkQzVPalloamU3YU1lQkxIZHBBblEwTGxYSFFCSCtuYW1VN1E1?=
 =?utf-8?B?MDV2MjVlcTdkOEhveTNzWTgvSStTczlzZG5ETndJVkx2d1lkMlJzUVBJZGhh?=
 =?utf-8?Q?/jNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b8c4e2-7de6-4a25-0f16-08dc5d4b5ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:55:47.4870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V01SHFLo1KX2jpDfbP8zVoMWPaLCCKz6f0zdkx8P5APS6xNGhpci67UiSGcBd84if+l6nIbpKLRFukDQ95L4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8365
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvNV0gaW14OTM6IENvbnZlciB0byBPRl9VUFNUUkVB
TQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIEZyaSwgQXByIDEyLCAyMDI0IGF0IDEwOjQw4oCv
QU0gRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+
IE9uIEZyaSwgQXByIDEyLCAyMDI0IGF0IDEwOjI04oCvQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcu
ZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBBIGZldyBub2RlcyB3ZXJl
IGFkZGVkIHRvIHNvYyBhbmQgYm9hcmQgdS1ib290LmR0c2kobHBpMmMsIHVzYm90ZyksDQo+ID4g
PiB0aG9zZSBub2RlcyBjb3VsZCBiZSBkcm9wcGVkIGFmdGVyIHVwc3RyZWFtIGxpbnV4IHN1cHBv
cnRzIHRoZW0uDQo+ID4gPg0KPiA+ID4gVG8gc3VwcG9ydCBPRl9VUFNUUkVBTSwgYSBmZXcgZHJp
dmVyIGNoYW5nZXMgYXJlIGluY2x1ZGVkLg0KPiA+ID4gRm9yIFRNVSwgc3RpbGwgdXNlIFUtQm9v
dCBub2RlLCBJIHdpbGwgcHJlcGFyZSBhIGtlcm5lbCB1cGRhdGUsIHRoZW4NCj4gPiA+IGJhY2sg
dG8gVS1Cb290IHN1cHBvcnQuDQo+ID4gPg0KPiA+ID4gIE1hdGhpZXU6IHBsZWFzZSBoZWxwIHRl
c3QgdGhlIGJvYXJkcyB5b3UgbWFpbnRhaW4gd2hlbiB5b3UgaGF2ZSB0aW1lLg0KPiA+DQo+ID4g
VGhlIHNlcmllcyBsb29rcyBnb29kLg0KPiA+DQo+ID4gSSB3aWxsIGFwcGx5IGl0IGFmdGVyIE1h
dGhpZXUgb3IgdGhlIFBoeXRlYyBmb2xrcyBjb25maXJtIHRoaXMgc2VyaWVzDQo+ID4gZG9lcyBu
b3QgYnJlYWsgaW14OTMtcGh5Ym9hcmQtc2VnaW4uDQo+IA0KPiBJIGFwcGxpZWQgcGF0Y2hlcyAx
IHRvIDQsIHRoYW5rcy4NCj4gDQo+IEkgZHJvcHBlZCB0aGUgbGFzdCBPRl9VUFNUUkVBTSBwYXRj
aCBhcyBpdCBpcyBjYXVzaW5nIGJvb3QgaXNzdWVzIG9uDQo+IE1hdGhpZXUncyB0ZXN0cy4NCg0K
b2suDQpEbyBJIG5lZWQgdG8gc3dpdGNoIGJhY2sgdG8gb25seSBjb252ZXJ0IGkuTVg5MyAxMXgx
MSBFVksgdG8NCk9GX1VQU1RSRU0/IA0KDQpUaGFua3MsDQpQZW5nLg0K
