Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62844CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE7A836AC;
	Wed, 22 Oct 2025 09:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D7D8323A; Wed, 22 Oct 2025 05:02:43 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9535F82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 05:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds3Y4OGlXtUj401EiffDGHBFnBfsAizJKeiYJVqrmyHN5NYHpOwC23FjNPuZnyqwkMsFo1v78snVeEMCnfmIawVjr6TQLoygBy+x7fySjcIQYT8koDwZRSzziZySaa9IqOmCAnCHWaGV6HJIK0oTX8wb1L+IP/XQKvB7k+dF0S5zlAoyYbRsPjfcrIoCENhTP++ltUuT3MO19jW4XqwiAlFTD9aqWznB5q2OdsDdL4fP1Vo9h0kv4qblTHTinCLtOvTmtzvxR9GJ7gx2k/uGQTlZU75ZPDJp2X+eKBs28rXvQvHPWG6imnW5buZma4NA5qTvVyHju+G2xhg93UpbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v3e12YdmNoC8F++jm1gG/79eYsSgLu2GMEVePwsOKE=;
 b=VyyrcOUMKFE5HCFaE+kEX30euJLCFlTZRQw8kBr6/aRUgbH95SfkCLaSKLq3b69MaOP4Dr+9hH11O7A3yXDh3RhURC8R2YpXPAd4FBHB4qDO4vrDkOgrTPUyX5kpJjpRy04vQ+YFu45ZMNHyz4OJ0/GWfhSet2JL18nSpXYiPk8/aFjoe4DwGrR+EwEM8IbpdbEUENT9tZ3qxJ2xtctbZWhwQBSHlursCLHSrXDh8aGm1Dijf9pJdLd7loicLyITJ3qVSz6ufxE70HfKHbF6R8XbVOA4MYXNKuPB9nRw2pRp+9dfUWkDEOvpYl74LZOBL3ucx50WvtQAd/e5OaUndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 03:02:35 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 03:02:35 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, E Shattow
 <e@freeshell.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>
Subject: RE: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
Thread-Topic: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
Thread-Index: AQHcGKuTWM2Kq+GOykaliHufSb7fJrR5QBQAgAZDXACAAPiuAIAABWqAgE1Js6A=
Date: Wed, 22 Oct 2025 03:02:35 +0000
Message-ID: <ZQ2PR01MB130759C5E1FCE630443B87E2E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-5-hal.feng@starfivetech.com>
 <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
 <ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <7f46fbd8-00bf-4a05-af78-a089332e55d6@freeshell.de>
 <00962cc7-4930-4dbf-9c51-0faacee221a1@canonical.com>
In-Reply-To: <00962cc7-4930-4dbf-9c51-0faacee221a1@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
x-ms-office365-filtering-correlation-id: 2e086334-dd11-4a71-6e86-08de111773a9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700021; 
x-microsoft-antispam-message-info: P+1yCu7vAtN6PIO4O3CuT56zwVtfKl5diDdZZ9x+F0XISuE7klHYVrZWl83DiPxQMMeEsCTMJjTUfZ1+D+T2dxqacK/IaPpWQMi38yPgyjP4hvHLa/V0X8p1AFmTzY3WjRAZmme0/QvaFGe7zoavXI2O7Se6tqrwoYMyYJUFgEDU7OAoiVNR4KyM6uRBVEMeSXqK2+RuIHGYP+28yUn7YBK7hCbqo+fgxJWXUd88m1PZwzHxvLrd2QRETXntI7VKgX12IY0+RmVA+MXY8OkverBkDTXAHVE4D7cF3OX0MB2uOD4fn1dOH8iyQps8d93iuPFCfDUOgX1K4+kU/3nMojpbaRePEcwamLapMX3ppHfGUAoWIjMQToxrNjroefF4AtdIxLmq5IQsnB/GJyByBMgAAokjv7xAMkAxAcRadRqOmeYclquNHd9AzhmZ73G2mGMGCL0T3h+d8Q0HZmy79V8Hvqe/VAP8rYxRz5vXcBOG5cOr5cW5qt/7cI71xRrfkcERa5Fgsn9qjOV3areN81Rby/gExmcyD+DL5MxAiQdKaNZcPvVg9hp22kJsba216rVSz5RHYIHFGqvMKgD7I5qF2safZWWYQYfRzsPUGxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpzSk5RRXAyZjVmZmtidjJ0MXRHTjlReDNVT3M0ZkZNTmdNSFFXOHl0ajVG?=
 =?utf-8?B?QWhrRXJLUDBvckNDaHhJc2svZXNNYjBycCtiRm03d2pETmppcndtWkt0b3J3?=
 =?utf-8?B?WEgzN2NCUmFNVUVtZmlqMytwMVJRSG0yS2hYTDdzdE9UVkZIMVh3dXZmTEhS?=
 =?utf-8?B?Y3ZJNUpkUDVkMmdkcHhiWG9JcDBTZnhWZ1ZZZmQxU096M2dlLzgyR0RPalFK?=
 =?utf-8?B?cDluNVdiM3F5S1JDdkpvNjhPY0w1UzVpcEo4M0lPT0NOK3lCSmdEa3JaaUdZ?=
 =?utf-8?B?UHQ3aGt2ZDJhUUZpMWFqNnNHb1NlZVppanhqejUxT0RFWG1IZUxRMWg0L0Nu?=
 =?utf-8?B?czM5ZE1WWXZKZnZuTEVNb284TnZRZjFQMk5OalluNlFBaFFkaG51MVFkRkNT?=
 =?utf-8?B?Q3k2djJ5ZkcxMXE3Y0tVVEpzZ1JPeVo2MWtxMjJFbmJFWC9ENVlRQ1VBZWQv?=
 =?utf-8?B?NDVZanNlVGNYWTNmdW10dEphVHZJdnp2ZHNlMGd2S3NSaUVPVWh3ak4wYXM1?=
 =?utf-8?B?d29aVmdKQ3krWGhmdU10TWFHSHVhemxza0F2K2wzSTdOVUpZM3VMbVRJM1R6?=
 =?utf-8?B?Tk1yTGc0ZCt0NlVrT1dONXgrdXdjYkJncDRNQkVPVVpvajhuVFk2U3ZqS0lw?=
 =?utf-8?B?ak82UDdKVGpqZGxMM3doQ1VrcU1QWnpPeGhwMURXWEZVZHZIS2taQ3llUUFD?=
 =?utf-8?B?WkpudmRraEErUURKWFNNQmw3TzZBdkxiLzE0N0FLQ2UycjBFQThqTUEzbTUz?=
 =?utf-8?B?amtjejBMcjNqTGZNeXZtOVMvTjZTT0pjY3RhS1o0ZGV6TG44ZWlVc1N2M3dn?=
 =?utf-8?B?U2pvSWthTnV0dk1Qck9LU0czbzd6VWJWOWpweFpEOFhKcUJ3M2MxeXlzMC9k?=
 =?utf-8?B?c3dLKy9sUGF1Z1JkUzdZOTM3YkhTQm5lTXNxVVhFeHUrdHUyUjZEWk14akhF?=
 =?utf-8?B?OCs0RCtFSXk3MVFrVXI0eFFPSXJhWlYwM29nMlQzZWlZZUtyTFNiS2VJZUdi?=
 =?utf-8?B?dHc1OHM2Mjlkb1NpN2kxV3ZHSE5GREthZVF1aEZpcUxvMFlIQk90TU5MVGFU?=
 =?utf-8?B?RmdIVEJXaDZ3d2pGLytVZlpIMHhTN1ZocmxySTFraExtZjhzbEFxd3BEQTk1?=
 =?utf-8?B?TmU1SzRPeXZVaE1EQm1iVnpodUlCOTltRlBWOG1oeFFETG9kWFNUa3Awd2xa?=
 =?utf-8?B?ZUhhVGM0Q002Mm9UY1FDdFNhazdLdE9iRTBNT3dWa0t0bUNBSmRDMHdXL3hq?=
 =?utf-8?B?Q0FmVGpya214Y0V4TjJ4YnQ3U09BNUtOUWxwT0FpclBycHlHaExVL0hRWVVC?=
 =?utf-8?B?T1FremROcHlXWkhKdEM5Z0h0d25Vb2dmdFgwYWlmTmF0eFZKb0hDTnQwSFRO?=
 =?utf-8?B?cm5lektzNHJWbE95d2ZzTEFMWWxKWEU3L3B5d2xscWtiQVRKZXhxYU1SMEtS?=
 =?utf-8?B?bXBOQkhsVzRGZEh2T1ZpdnFxRU9jeEs4Ym8xSzJDVTFDM0ExMXhtNmZxZ0pt?=
 =?utf-8?B?MS9IVmNaZmkyNkRwK243bjRiVFBLOFNjcUI2RnhvbmQxTExVd3RxSEYwMldE?=
 =?utf-8?B?L3VERUdjcGVQTjVVQWRNZ1A4aStibkNKaExmU2NZUW9qWUVJZWVnRjBjSzBT?=
 =?utf-8?B?Znd2a1JueU9TcGkzR096MWwxY0FUZ1dBZ2IxRUFHaS94RzVndUY3aXJKbjZl?=
 =?utf-8?B?Z0ZZakswL1g3SVhkdTJlR1VHUk9PeU5HNzhhcVhmTnoxT2ZRRFJzL2k0MEs2?=
 =?utf-8?B?a3lGejdycktsWVVjbFNQNmw2U1hrbUh4R0JmUXpSR1EvVFpnV0NzRlVpQlRq?=
 =?utf-8?B?UDR1bVhCbGR1VWlmd2hXc3pnZmpHelY3STAyL2oxQUlvVkNWOVJBUENuM0Qw?=
 =?utf-8?B?TlgxaFlhdC9IeEllczFEUmdtS3Bja2laSnoxSkUrVUF6UzRmZVZod2NLRG83?=
 =?utf-8?B?U0dtQUM1RndTR3lGSlNLMmRqMitsTHc3cDA5S2ErRGhSSlZKa1Q5NnpOSEVl?=
 =?utf-8?B?aFRxRGJPVU5iS2ZKZmpVa0o0bXJDUTJpNmVrWEVXcERDeGtIdWozMWFZTHFa?=
 =?utf-8?B?R3NLb1M0N0wwMVVmMDZDYTJKamhkdUk4aTlTb1NNYWRRK0Rna3FENkdINEcw?=
 =?utf-8?Q?sblrhYtJLtEM1rag2N7ZnWKh3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e086334-dd11-4a71-6e86-08de111773a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 03:02:35.5060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q4xgmtyOB9XlS2b16Ypm+ODqiu3sEmgdvbzmw0+8W+D4+oHRFIWgcdyOsvaDM19/CCzz9OjXAC1rr3pPfCKZVXbAQGmqUB/nxEapZ2Y44Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

PiBPbiAwMy4wOS4yNSAwNjozMiwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gOS8z
LzI1IDAwOjEyLCBFIFNoYXR0b3cgd3JvdGU6DQo+ID4NCj4gPiBPbiA5LzIvMjUgMDA6NDQsIEhh
bCBGZW5nIHdyb3RlOg0KPiA+Pj4gT24gMjkuMDguMjUgMTU6NDQsIEhlaW5yaWNoIFNjaHVjaGFy
ZHQgd3JvdGU6DQo+ID4+PiBPbiAyOS4wOC4yNSAwODowOSwgSGFsIEZlbmcgd3JvdGU6DQo+ID4+
Pj4gcGNiX3JldmlzaW9uIGlzIHN0b3JlZCBpbiB0aGUgcGNiX3JldmlzaW9uIGZpZWxkIG9mIEFU
T000LiBDb3JyZWN0IGl0Lg0KPiA+Pj4+IE1vdmUgdGhlIGZ1bmN0aW9uIGRlc2NyaXB0aW9uIHRv
IHRoZSBoZWFkZXIgZmlsZS4NCj4gPj4+PiBSZW1vdmUgdGhlIGZ1bmN0aW9uIGNhbGxzIGluIGJv
YXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyLy4NCj4gPj4+Pg0KPiA+Pj4+IEZpeGVzOiBhZWExYmQ5
NWI2MWUgKCJlZXByb206IHN0YXJmaXZlOiBFbmFibGUgSUQgRUVQUk9NDQo+ID4+Pj4gY29uZmln
dXJhdGlvbiIpDQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gICAgYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9hcmNoLWpoNzExMC9lZXByb20uaCAgIHwgIDUgKysrKysNCj4gPj4+PiAgICBib2FyZC9zdGFy
Zml2ZS92aXNpb25maXZlMi9zcGwuYyAgICAgICAgICAgICAgfCAxOCArKysrKystLS0tLS0tLS0t
LQ0KPiA+Pj4+ICAgIC4uLi92aXNpb25maXZlMi9zdGFyZml2ZV92aXNpb25maXZlMi5jICAgICAg
ICB8IDIwICsrKysrKy0tLS0tLS0tLS0tLS0NCj4gPj4+PiAgICAuLi4vdmlzaW9uZml2ZTIvdmlz
aW9uZml2ZTItaTJjLWVlcHJvbS5jICAgICAgfCAxMSArKy0tLS0tLS0tDQo+ID4+Pj4gICAgNCBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gPj4+Pg0K
PiA+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2FyY2gtamg3MTEwL2Vl
cHJvbS5oDQo+ID4+PiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1qaDcxMTAvZWVwcm9t
LmgNCj4gPj4+PiBpbmRleCA2ZDBhMGJhMGM0YS4uMDI1ZjFkMzJjNDkgMTAwNjQ0DQo+ID4+Pj4g
LS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLWpoNzExMC9lZXByb20uaA0KPiA+Pj4+
ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1qaDcxMTAvZWVwcm9tLmgNCj4gPj4+
PiBAQCAtOSw2ICs5LDExIEBADQo+ID4+Pj4NCj4gPj4+PiAgICAjaW5jbHVkZSA8bGludXgvdHlw
ZXMuaD4NCj4gPj4+Pg0KPiA+Pj4+ICsvKioNCj4gPj4+PiArICogZ2V0X3BjYl9yZXZpc2lvbl9m
cm9tX2VlcHJvbSgpIC0gZ2V0IHRoZSBQQ0IgcmV2aXNpb24NCj4gPj4+PiArICoNCj4gPj4+PiAr
ICogQHJldHVybjogdGhlIFBDQiByZXZpc2lvbiBvciAweEZGIG9uIGVycm9yLg0KPiA+Pj4+ICsg
Ki8NCj4gPg0KPiA+IE5vLiBJbnZlcnRlZCBsb2dpYy4gU2VlIGJlbG93IGNvbW1lbnQgYWJvdXQg
Ym9keSBvZiBmdW5jdGlvbi4NCj4gPg0KPiA+Pj4+ICAgIHU4IGdldF9wY2JfcmV2aXNpb25fZnJv
bV9lZXByb20odm9pZCk7DQo+ID4+Pj4NCj4gPj4+PiAgICAvKioNCj4gPj4+PiBkaWZmIC0tZ2l0
IGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMNCj4gPj4+IGIvYm9hcmQvc3RhcmZp
dmUvdmlzaW9uZml2ZTIvc3BsLmMNCj4gPj4+PiBpbmRleCAzZGZhOTMxYjY1NS4uOTAxZTdiNThm
MzYgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMN
Cj4gPj4+PiArKysgYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zcGwuYw0KPiA+Pj4+IEBA
IC0xMjYsMTkgKzEyNiwxMyBAQCBpbnQgYm9hcmRfZml0X2NvbmZpZ19uYW1lX21hdGNoKGNvbnN0
IGNoYXINCj4gPj4+ICpuYW1lKQ0KPiA+Pj4+ICAgIAkJICAgICFzdHJuY21wKGdldF9wcm9kdWN0
X2lkX2Zyb21fZWVwcm9tKCksICJTVEFSNjQiLCA2KSkgew0KPiA+Pj4+ICAgIAkJcmV0dXJuIDA7
DQo+ID4+Pj4gICAgCX0gZWxzZSBpZiAoIXN0cmNtcChuYW1lLA0KPiA+Pj4+ICJzdGFyZml2ZS9q
aDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjJhIikNCj4gPj4+ICYmDQo+ID4+Pj4gLQkJ
ICAgICFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTAiLCA2KSkg
ew0KPiA+Pj4+IC0JCXN3aXRjaCAoZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2VlcHJvbSgpKSB7DQo+
ID4+Pj4gLQkJY2FzZSAnYSc6DQo+ID4+Pj4gLQkJY2FzZSAnQSc6DQo+ID4+Pj4gLQkJCXJldHVy
biAwOw0KPiA+Pj4+IC0JCX0NCj4gPj4+PiArCQkgICAoIXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRf
ZnJvbV9lZXByb20oKSwgIlZGNzExMEEiLCA3KQ0KPiA+Pj4gfHwNCj4gPj4+PiArCQkgICAgIXN0
cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwgIlZGNzExMGEiLCA3KSkpDQo+ID4+
PiB7DQo+ID4+Pj4gKwkJcmV0dXJuIDA7DQo+ID4+Pj4gICAgCX0gZWxzZSBpZiAoIXN0cmNtcChu
YW1lLA0KPiA+Pj4+ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNi
IikNCj4gPj4+ICYmDQo+ID4+Pj4gLQkJICAgICFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21f
ZWVwcm9tKCksICJWRjcxMTAiLCA2KSkgew0KPiA+Pj4+IC0JCXN3aXRjaCAoZ2V0X3BjYl9yZXZp
c2lvbl9mcm9tX2VlcHJvbSgpKSB7DQo+ID4+Pj4gLQkJY2FzZSAnYic6DQo+ID4+Pj4gLQkJY2Fz
ZSAnQic6DQo+ID4+Pj4gLQkJCXJldHVybiAwOw0KPiA+Pj4+IC0JCX0NCj4gPj4+PiArCQkgICAo
IXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwgIlZGNzExMEIiLCA3KQ0KPiA+
Pj4gfHwNCj4gPj4+PiArCQkgICAgIXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20o
KSwgIlZGNzExMGIiLCA3KSkpDQo+ID4+PiB7DQo+ID4+Pj4gKwkJcmV0dXJuIDA7DQo+ID4+Pj4g
ICAgCX0NCj4gPj4+Pg0KPiA+Pj4+ICAgIAlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IEkgYWdy
ZWUgaXQgaXMgZ29vZCB0byBkZWxldGUgdGhlIGNhc2Ugc3RhdGVtZW50IGFuZCBkcm9wIGxvd2Vy
Y2FzZQ0KPiA+IGNvbXBhcmUgYXMgc3VnZ2VzdGVkLCBhbHNvLi4uDQo+ID4NCj4gPj4+PiBkaWZm
IC0tZ2l0IGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3RhcmZpdmVfdmlzaW9uZml2ZTIu
Yw0KPiA+Pj4gYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zdGFyZml2ZV92aXNpb25maXZl
Mi5jDQo+ID4+Pj4gaW5kZXggYmZiYjExYTJlZTcuLmYzODQzM2U5NGFjIDEwMDY0NA0KPiA+Pj4+
IC0tLSBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUyLmMN
Cj4gPj4+PiArKysgYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zdGFyZml2ZV92aXNpb25m
aXZlMi5jDQo+ID4+Pj4gQEAgLTU5LDIwICs1OSwxMiBAQCBzdGF0aWMgdm9pZCBzZXRfZmR0Zmls
ZSh2b2lkKQ0KPiA+Pj4+ICAgIAkJZmR0ZmlsZSA9ICJzdGFyZml2ZS9qaDcxMTAtbWlsa3YtbWFy
cy5kdGIiOw0KPiA+Pj4+ICAgIAl9IGVsc2UgaWYgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zy
b21fZWVwcm9tKCksICJTVEFSNjQiLCA2KSkgew0KPiA+Pj4+ICAgIAkJZmR0ZmlsZSA9ICJzdGFy
Zml2ZS9qaDcxMTAtcGluZTY0LXN0YXI2NC5kdGIiOw0KPiA+Pj4+IC0JfSBlbHNlIGlmICghc3Ry
bmNtcChnZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgpLCAiVkY3MTEwIiwgNikpIHsNCj4gPj4+
PiAtCQlzd2l0Y2ggKGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20oKSkgew0KPiA+Pj4+IC0J
CWNhc2UgJ2EnOg0KPiA+Pj4+IC0JCWNhc2UgJ0EnOg0KPiA+Pj4+IC0JCQlmZHRmaWxlID0gInN0
YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItDQo+ID4+PiB2MS4yYS5kdGIiOw0K
PiA+Pj4+IC0JCQlicmVhazsNCj4gPj4+PiAtCQljYXNlICdiJzoNCj4gPj4+PiAtCQljYXNlICdC
JzoNCj4gPj4+PiAtCQkJZmR0ZmlsZSA9ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9u
Zml2ZS0yLQ0KPiA+Pj4gdjEuM2IuZHRiIjsNCj4gPj4+PiAtCQkJYnJlYWs7DQo+ID4+Pj4gLQkJ
ZGVmYXVsdDoNCj4gPj4+PiAtCQkJbG9nX2VycigiVW5rbm93biByZXZpc2lvblxuIik7DQo+ID4+
Pj4gLQkJCXJldHVybjsNCj4gPj4+PiAtCQl9DQo+ID4+Pj4gKwl9IGVsc2UgaWYgKCFzdHJuY21w
KGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTBBIiwgNykgfHwNCj4gPj4+PiAr
CQkgICAhc3RybmNtcChnZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgpLCAiVkY3MTEwYSIsIDcp
KSB7DQo+ID4+Pg0KPiA+Pj4gV2hlcmUgYm9hcmRzIGJvdGggd2l0aCAnYScgYW5kICdiJyBldmVy
IHNoaXBwZWQ/DQo+ID4+PiBJIGhhdmUgb25seSBzZWVuICdBJyBhbmQgJ0InIGluIHBidWYuZWVw
cm9tLmF0b20xLmRhdGEucHN0cls2XS4NCj4gPj4NCj4gPj4gWW91J3JlIHJpZ2h0LiBUaGVyZSBh
cmUgbm8gYm9hcmRzIG1hcmtlZCAiVkY3MTEwYSIgb3IgIlZGNzExMGIiLg0KPiA+PiBMZXQncyBy
ZW1vdmUgdGhlIGNvbXBhcmlzb24gb2YgIlZGNzExMGEiIGFuZCAiVkY3MTEwYiIuDQo+ID4+DQo+
ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gSGFsDQo+ID4NCj4gPiAuLi4gYWdhaW4gaGVyZSB0b28g
ZGVsZXRlIHRoZSBjYXNlIHN0YXRlbWVudCBhbmQgZHJvcCBsb3dlcmNhc2UgY29tcGFyZS4NCj4g
PiBUaGFua3MuDQo+ID4NCj4gPj4NCj4gPj4+DQo+ID4+PiBUaGUgY2hhbmdlIGxvb2tzIHRlY2hu
aWNhbGx5IGNvcnJlY3QuDQo+ID4+Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEhlaW5yaWNoIFNjaHVj
aGFyZHQgPGhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNvbT4NCj4gPj4+DQo+ID4+Pj4g
KwkJZmR0ZmlsZSA9ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjJh
LmR0YiI7DQo+ID4+Pj4gKwl9IGVsc2UgaWYgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21f
ZWVwcm9tKCksICJWRjcxMTBCIiwgNykgfHwNCj4gPj4+PiArCQkgICAhc3RybmNtcChnZXRfcHJv
ZHVjdF9pZF9mcm9tX2VlcHJvbSgpLCAiVkY3MTEwYiIsIDcpKSB7DQo+ID4+Pj4gKwkJZmR0Zmls
ZSA9ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNiLmR0YiI7DQo+
ID4+Pj4gICAgCX0gZWxzZSB7DQo+ID4+Pj4gICAgCQlsb2dfZXJyKCJVbmtub3duIHByb2R1Y3Rc
biIpOw0KPiA+Pj4+ICAgIAkJcmV0dXJuOw0KPiA+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2JvYXJk
L3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3Zpc2lvbmZpdmUyLWkyYy1lZXByb20uYw0KPiA+Pj4gYi9i
b2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMNCj4gPj4+
PiBpbmRleCAzODY2ZDA3ZjlkNC4uNDNiOGFmNGZjNTkgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvYm9h
cmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4+Pj4g
KysrIGIvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5j
DQo+ID4+Pj4gQEAgLTUzNSwxOSArNTM1LDEyIEBAIGludCBtYWNfcmVhZF9mcm9tX2VlcHJvbSh2
b2lkKQ0KPiA+Pj4+ICAgIAlyZXR1cm4gMDsNCj4gPj4+PiAgICB9DQo+ID4+Pj4NCj4gPj4+PiAt
LyoqDQo+ID4+Pj4gLSAqIGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20gLSBnZXQgdGhlIFBD
QiByZXZpc2lvbg0KPiA+Pj4+IC0gKg0KPiA+Pj4+IC0gKiAxLjJBIHJldHVybiAnQScvJ2EnLCAx
LjNCIHJldHVybiAnQicvJ2InLG90aGVyIHZhbHVlcyBhcmUNCj4gPj4+PiBpbGxlZ2FsDQo+ID4+
Pj4gLSAqLw0KPiA+Pj4+ICAgIHU4IGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20odm9pZCkN
Cj4gPj4+PiAgICB7DQo+ID4+Pj4gLQl1OCBwdiA9IDB4RkY7DQo+ID4+Pj4gLQ0KPiA+Pj4+ICAg
IAlpZiAocmVhZF9lZXByb20oKSkNCj4gPj4+PiAtCQlyZXR1cm4gcHY7DQo+ID4+Pj4gKwkJcmV0
dXJuIDB4RkY7DQo+ID4+Pj4NCj4gPj4+PiAtCXJldHVybiBwYnVmLmVlcHJvbS5hdG9tMS5kYXRh
LnBzdHJbNl07DQo+ID4+Pj4gKwlyZXR1cm4gcGJ1Zi5lZXByb20uYXRvbTQuZGF0YS5wY2JfcmV2
aXNpb247DQo+ID4+Pj4gICAgfQ0KPiA+Pj4+DQo+ID4+Pj4gICAgdTggZ2V0X2Rkcl9zaXplX2Zy
b21fZWVwcm9tKHZvaWQpDQo+ID4+DQo+ID4NCj4gPiBOby4gSSBkbyBub3Qgd2FudCB0byBoYXZl
IHRvIGd1ZXNzIHdoYXQgZXJyb3IgZG9lcyAiMHhGRiIgaGF2ZSB0aGUNCj4gPiBtZWFuaW5nIG9m
LCBpdCBtYWtlcyB0aGUgY29kZSBhbm5veWluZyB0byByZWFkIGV2ZXJ5IGZ1bmN0aW9uIGhlYWRl
cg0KPiA+IGRvY3VtZW50YXRpb24gdG8gbGVhcm4gdGhpcyBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+
IFNpbmNlIHdlIHJlbW92ZSBhbGwgdXNlcnMgb2YgbWFjX3JlYWRfZnJvbV9lZXByb20oKSBpdCBp
cyBjZXJ0YWlubHkNCj4gPiBub3QgYSBwcm9ibGVtIHdlIGNhcmUgYWJvdXQgbm93IGFueW1vcmUu
IERlZmF1bHQgUENCIHJldmlzaW9uIGluIGNhc2UNCj4gPiBvZiBlcnJvciBtYXkgYmUgemVyby4g
SXQgaXMgbm90IGltcG9ydGFudCB0byBtYWtlIGRpc3RpbmN0aW9uIG9mDQo+ID4gYWRkaXRpb25h
bCBmYWlsdXJlIGRldGVjdGlvbiwgdGhpcyBpcyBhbHJlYWR5IHJlc29sdmVkIGJ5DQo+ID4gcmVh
ZF9lZXByb20oKSB3aGVyZSBhbnkgZXJyb3IgbWVzc2FnZSBtYXkgYmUgcHJlc2VudGVkIHRvIHRo
ZSB1c2VyLg0KPiA+DQo+ID4gSSBhcHByZWNpYXRlIHRoZSBlZmZvcnQgdG8gYmUgbW9yZSB0ZWNo
bmljYWxseSBjb3JyZWN0IGFuZCBoYXZlIGENCj4gPiB1bmlxdWUgZXJyb3IgdmFsdWUgYnV0IHdp
dGggdTggcmV0dXJuIHZhbHVlIDB4RkYgaXQgaXMgYW4gYWRkaXRpb25hbA0KPiA+IGxheWVyIG9m
IGNvbXBsaWNhdGlvbiBub3QgbmVlZGVkLiBJZiB5b3UgaW5zaXN0IG9uIHRoaXMgYXBwcm9hY2gg
dGhlbg0KPiA+IHRoZSByZXR1cm4gdmFsdWUgc2hvdWxkIGJlIGFyYml0cmFyaWx5IGRlZmluZWQg
YXMgYSBjb21waWxlciBtYWNybywNCj4gPiBzYXkgQ01EX0VFUFJPTV9GQUlMICgyNTUpIGFuZCBj
b25zaXN0ZW50bHkgdXNlZC4gSW4gZmFjdCBJIHdvdWxkIG5vdA0KPiA+IGNvbXBsYWluIGlmIGl0
IGltcHJvdmVkIGNvZGUgcmVhZGFiaWxpdHkuDQo+IA0KPiBUaGVyZSBpcyBubyBuZWNlc3NpdHkg
dG8gdXNlIHU4IGFzIHRoZSByZXR1cm4gdmFsdWUuIFdlIGNvdWxkIGFsc28gdXNlIGludCBhbmQN
Cj4gcmV0dXJuIGEgbmVnYXRpdmUgZXJyb3IgY29kZSAoLUVJTykgb24gZmFpbHVyZS4NCg0KWWVh
aCwgd2lsbCByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBjb2RlICgtRUlPKSBvbiBmYWlsdXJlLg0K
SSB0aGluayB0aGUgcmVhc29uIHdoeSB3ZSBzZXQgdGhlIHJldHVybiB2YWx1ZSB0byAweEZGIG9u
IGZhaWx1cmUgd2FzIHRoYXQNCjB4RkYgaXMgdGhlIGRlZmF1bHQgdmFsdWUgYWZ0ZXIgRUVQUk9N
IGlzIGVyYXNlZC4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
