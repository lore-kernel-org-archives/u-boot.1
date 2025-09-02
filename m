Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED97DCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC2283253;
	Tue,  2 Sep 2025 11:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B7883214; Tue,  2 Sep 2025 09:10:34 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD61B8317B
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeDyq5UHtBZNUFpJLeeboiZpDV+lpYKjvQWMG+xu/BwBgw4Nz3lTpIhguHnacAp7XYEekvnMSqOHywVANKdF9LAqsxtefiVOt1mdWXKoKaZ4Zwj5BN/VoPR/PfO6CZbY2zT8EhIEbXnKJkbmULfUjA6t0FHexgka8CvHOtPdyTyUgRwhRkf7CA17NRzUYDf9CB1IQ3H2BBsT35+DFdDZwj0JieL+jwRWqocrddFvbsDuexSwdWLjroYc27AcZgjI/vldtOtRayf1HKiiiNhX0hfO32pSa/FKqKe2o++xHqjhuVtrJYg0sPWXGU1z+tIDYsd0orwq/IbpbWofahGZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMufXTLabFjZzya3HDN47tXlPt6bCzYUBb6lu5z0Cf0=;
 b=ABBAEQA7K3P8M7AX5js2gBUnUdE/9C5OFNmbZRLojCx3C+GSzvhWx+fpfJXEZShhqFb8FSZ//VI6Q1LTPIKENP7j2uNwgtbs2OrDCJoIK/QC2WJaq1NrU5YXtG/EguwhOS8I5yGhUgFehm4HImbqwLoFcE1SMmFQPzP2G3V9lkUAferN3joExOSw8GUnjsC++j6Bvt5v+dfDp5SKdFYuw172D2t+kD3AK8Mlmz1LcP1WyJIhT059AiTKKjPP0Gr8rtaf+Gs1Ro8R9cb66UahCncHMZUonWvZ+FM/v+Np/9QDs49wuCJ3QHOEcJVRc1GvyhVcVCh+HZgjTA5bUIxw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1321.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:10:25 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:10:25 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, E Shattow <e@freeshell.de>
Subject: RE: [RFC 05/10] eeprom: starfive: Update eeprom data format version
 to 3
Thread-Topic: [RFC 05/10] eeprom: starfive: Update eeprom data format version
 to 3
Thread-Index: AQHcGKuT7lYQBMieTEeC01X/aC5P8bR5QPiAgAY8N/A=
Date: Tue, 2 Sep 2025 07:10:25 +0000
Message-ID: <ZQ2PR01MB13073E49E6E3C4C8DED3DEA7E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-6-hal.feng@starfivetech.com>
 <55f9201c-4083-48f3-a90b-89e625d96195@canonical.com>
In-Reply-To: <55f9201c-4083-48f3-a90b-89e625d96195@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1321:EE_
x-ms-office365-filtering-correlation-id: fef2d9fe-7ca8-44a7-d6ca-08dde9efc9ed
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: N4dlM0QfWnE7JL1f8vXBI0Y7XsUibJ/pM5bD4HnaiM8AVNW54p7RLPZTWBYIKZmB3ugQT6ex58VnwY/QHlhpHJozzZeARop+snDRj0ZxexTMiaTmQCv9LpYzlCLtNs23iN/rfJQ7K4Og1x6dxdXKTWzPdGCiqPy4ULM9dRfs3jaSXwuj6MkGzrW/on3IYaPeZK97ryYPlGbHLLTAmhVBV9km76YW4P40XoKM8Do/cSDh+haWvi3RzVYvuYVA/xpSmlzwHNoBcDsRH0Z5j2D1KIOgxMD0xKujWVbvuhme7DTSflDPTMEWmtHrf2oLjtXYXc9a8h+lrwDymBK53pMjEtRwmHXBWwCKwywpV+gvsgxHRPPfExC1l2EvZOfSQokEDNfkJ2lg7TlGofUuqSPvkFXZtWT+3evm+IQ1ZTAZoaFSnp5388WxREvVGqAoD0oMhkWcJ+ov4Br2AHq7ooMhaiJW/ETYiomrQqqBUZ5KN54KWeSIwN7AddqgeKLgSLnqukCtbpG1RXyzqD/ml78dJSGRn13BEoXa9q2/fAPsAKp8gggQ87kc+1FqC3E8qAkx6rUY3cToVdhbc6e1v7ydPtbOUZ5rtywPhFcNOvzkYe0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3hDTFcwYSs0NTIyOUFKU1IyaURlMEorTWNGeFlBOSswU1lSd29lMEhKWjhH?=
 =?utf-8?B?MDVBa1FTT0pUZ0pXaDlkRkV2a0RBd21aRGRzb3FLdkV2MG1vMnVmdG15eGlX?=
 =?utf-8?B?K016b3NoU1ZhWkhhcnVyemFtZ0NHc24wNkgyWUoxaWFWK0NHVHFDeGZSWFFy?=
 =?utf-8?B?M3dNSjBoVWxRcHJrcWkrVGYyWUFpdGRzMjR5cTFpYllSWlJVN0crZVp4OWFK?=
 =?utf-8?B?YUVDSFRQV3haUmg2ZVFXWlVzd0cyYWhKaUJyVmVpa1A0cm0zbUk0aVJLQ255?=
 =?utf-8?B?Z0ZlYWYxeWp2L0VwRFkzUSt3UUhsK2E3R3BBOFI1ZjNYa2psUlc0N0lxS09r?=
 =?utf-8?B?cHdsdFRHSFZ5dHhrTnlmUUxkc2VSamVVZElTeUp5aHVtL3JhREwvVFJuMzhk?=
 =?utf-8?B?aE9NSjB0QUhoVTFpSXJBc1B6THMrc3l1WXAxQ3VVdG91Z25NMVpnTFUxbUhs?=
 =?utf-8?B?SW9qQmlrd2JybXlBSVcyRTlMVjloRU52S1E0L0hwRWVqR1F0b0xJZkkreGFa?=
 =?utf-8?B?MGZId1dGeUUrY0tMdjJCcGpVRnhSeWhaVjl1cUNjYTZGclk3YTNiZngvUlpo?=
 =?utf-8?B?amswTlR4V1FnMU9GeXdnOTdYTVdpSGVEUkhLUDdhRlFTY0FhS1Y3dkFrVW9k?=
 =?utf-8?B?WFFsNkduUXNHcUFQeU9scGNVZ3BQQWg0elRKUjF5aFRGWnk5RE0vVERQbUhw?=
 =?utf-8?B?TEh6bU5UYlFzd05aVVl1TjJNUG9nTmlOS0hveFRKMDJWMTB2RmM3WGk2V1Ir?=
 =?utf-8?B?bmFHSjBpNWcxTzJ3Sk9JcFJpOTBUR04rUDNIbUoxaVIxNDkzU0JVWWJQVEJF?=
 =?utf-8?B?VXlBNTN3MGE1NkRibXlzdFh5MjFPcjNCWnVJSXRSUmJTa0tIMjU3aDJHNzJq?=
 =?utf-8?B?NGNJemozRVo2WGVEZ0NxM2V0SFY0NWpnOG42d1J6ZVE3Y25ud1BHT0dZK01n?=
 =?utf-8?B?TUsxZCtvK0F5bjUyUG1Tc1U2Ynh2NUpxUitkQUZteUZBdUluZ3lwU05tYlJE?=
 =?utf-8?B?dTV6QTNXN01FamowOERhRXRKRUhJVk4rUklpa1NLU1QrREtsUE8vNVdsYSsz?=
 =?utf-8?B?VzlkcldRT1VuY0dWUmZjR2tySURCVzNsa3NQZnY2Tm9wRndLYndxQ3JEU2Ex?=
 =?utf-8?B?Y08rWlFtcithbG5NZldPaXdlVldRdlNSNW9sOTRQT0E3WUxXUnNFM2RFNkp3?=
 =?utf-8?B?bndBYVlsUnNOZ3UrQUdTNE9Jemt2TVBqMi92VU9TUkU3bktLdFJ1UzNaSUlR?=
 =?utf-8?B?NGpOdUFYWUQwSXZxWlV1Y3JYa2tqSUhRRytDR3k5ZnFIaDZZelc3U3lSOGZY?=
 =?utf-8?B?ZTdXS210UDR3OC95eThzVzF0QTJPRGdxd0VGOTYwOXBhb1dWUHZtai9zTk5p?=
 =?utf-8?B?YVNCaWU1dmJqUzhLSEZ1bzNyYWVpWVlQRk9NclZwT3NWVEZ6Ris0RG5uT0R0?=
 =?utf-8?B?R1FjS3Avd01IV1A3R0dVMGc3NHJqM0VyUGlvaUNMcjFwVU5HOG5EM0VneTc3?=
 =?utf-8?B?UDRxQlRkOVFTVTVQa1U5ZkJwcTg2aFp2UmVOeE0zZnVTMGg3aEFPNzJsK0xL?=
 =?utf-8?B?V2FiQjl6anJBdllRQnAxMmZXb3lUTTdva3lqRHlHazgwYk1FcDNzSjBaVXBT?=
 =?utf-8?B?SXdUVU1pUlVvdDVsc0t4Qlhna3pBL3BFanVZdEg5eGFPOFd5Q29LU2xsRUY3?=
 =?utf-8?B?VDV1ZHRhajdsaFRlcHpQU2pxWVkxd0tiZGVlZ2htTDJtNnFpcEoyellvd3pn?=
 =?utf-8?B?eTFBVEVtUnZSZ1JZNG8yODVDcnZZMEpEc3hHb3F1djh4ckdxay9pMVh3TzZp?=
 =?utf-8?B?YWlFbkhQUW9Ma0l0MkVtdVR6VVBnM0NIcTFyUXZwcVM3M0xHM0tua0FKOVpi?=
 =?utf-8?B?V0FzMVB3QjNWQWdqNTljQys0OHZYNUdZSnhwTEliMSt6cU43amo4MERXaFRu?=
 =?utf-8?B?ZjFReXJ4WnJDM2JYZmg2VE1iWDNENDRoUkpBdCs2a0M3YU1Xc2c4VHdPUzl6?=
 =?utf-8?B?RkJGem80ZmpnU1JwcVZmZ1pnSGxTNTFTUW9hOHpUMStwR0c1YUE4bndmZDQ3?=
 =?utf-8?B?ZEl3V2UzMnJFNzA1WW9JVnRvUU9RRTliUC9MUlJNdStqSC9VYVBST1Vsa0NQ?=
 =?utf-8?Q?IPFxHITiLNmE4dEpg4J+rluou?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2d9fe-7ca8-44a7-d6ca-08dde9efc9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 07:10:25.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCDIOPRnP2pmeG/ghzoctzortwjOaqBXz1kIqjclvlvuLeUw4HYW9DrFdU31IBM0vFeE6+K9L+P3Chtv3qwdwI3VJSrcoUphVJqoh+SafSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1321
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:12:53 +0200
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

PiBPbiAyOS4wOC4yNSAxNTo0NywgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMjku
MDguMjUgMDg6MDksIEhhbCBGZW5nIHdyb3RlOg0KPiA+IEFkZCBlZXByb20gZGF0YSBmb3JtYXQg
djMgc3VwcG9ydC4NCj4gPiBBZGQgd2lmaV9idCBmaWVsZCBpbiBBVE9NNCBhbmQgYWRkICJtYWMg
d2lmaV9idCA8Pz4iIGNvbW1hbmQgdG8gbW9kaWZ5DQo+IGl0Lg0KPiA+IFNldCBvciBzaG93IGV0
aDAvMSBNQUMgYWRkcmVzcyBvbmx5IGlmIHRoZSBib2FyZCBoYXMgZXRoMC8xLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4g
LS0tDQo+ID4gICAuLi4vdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jICAgICAg
fCA5MSArKysrKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNzggaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvc3Rh
cmZpdmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4gYi9ib2FyZC9z
dGFyZml2ZS92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMNCj4gPiBpbmRleCA0
M2I4YWY0ZmM1OS4uNzM1MjI1MmM0NzUgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvc3RhcmZpdmUv
dmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4gKysrIGIvYm9hcmQvc3Rh
cmZpdmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4gQEAgLTExLDcg
KzExLDcgQEANCj4gPiAgICNpbmNsdWRlIDx1LWJvb3QvY3JjLmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvZGVsYXkuaD4NCj4gPg0KPiA+IC0jZGVmaW5lIEZPUk1BVF9WRVJTSU9OCQkweDINCj4g
PiArI2RlZmluZSBGT1JNQVRfVkVSU0lPTgkJMHgzDQo+ID4gICAjZGVmaW5lIFBDQl9WRVJTSU9O
CQkweEIxDQo+ID4gICAjZGVmaW5lIEJPTV9WRVJTSU9OCQknQScNCj4gPiAgIC8qDQo+ID4gQEAg
LTEwNSw3ICsxMDUsOCBAQCBzdHJ1Y3QgZWVwcm9tX2F0b200X2RhdGEgew0KPiA+ICAgCXU4IGJv
bV9yZXZpc2lvbjsJCS8qIEJPTSB2ZXJzaW9uICovDQo+ID4gICAJdTggbWFjMF9hZGRyW01BQ19B
RERSX0JZVEVTXTsJLyogRXRoZXJuZXQwIE1BQyAqLw0KPiA+ICAgCXU4IG1hYzFfYWRkcltNQUNf
QUREUl9CWVRFU107CS8qIEV0aGVybmV0MSBNQUMgKi8NCj4gPiAtCXU4IHJlc2VydmVkWzJdOw0K
PiA+ICsJdTggd2lmaV9idDsJCQkvKiBXSUZJL0JUIHN1cHBvcnQgZmxhZyAqLw0KPiA+ICsJdTgg
cmVzZXJ2ZWQ7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdHJ1Y3Qgc3RhcmZpdmVfZWVwcm9tX2F0
b200IHsNCj4gPiBAQCAtMTI4LDYgKzEyOSwzNSBAQCBzdGF0aWMgdW5pb24gew0KPiA+ICAgLyog
U2V0IHRvIDEgaWYgd2UndmUgcmVhZCBFRVBST00gaW50byBtZW1vcnkgKi8NCj4gPiAgIHN0YXRp
YyBpbnQgaGFzX2JlZW5fcmVhZCBfX3NlY3Rpb24oIi5kYXRhIik7DQo+ID4NCj4gPiArc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBib2FyZF9ub19ldGgwX2xpc3RbXSA9IHsNCj4gPiArCSJGTUwx
M1YwMSIsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGJv
YXJkX25vX2V0aDFfbGlzdFtdID0gew0KPiA+ICsJIkZNTDEzVjAxIiwNCj4gPiArCSJNQVJTIiwN
Cj4gPiArCSJWRjcxMTBTTCIsDQo+ID4gK307DQo+IA0KPiBEbyB5b3Uga25vdyBpbiB3aGljaCBj
YXRlZ29yeSB0aGUgTWlsay1WIE1hcnMgQ00gKCJNQVJDIikgZmFsbHM/DQoNCk1pbGstViBNYXJz
IENNIGJvYXJkIGhhcyBldGgwIGJ1dCBubyBldGgxLg0KV2lsbCBhZGQgIk1BUkMiIGluIGJvYXJk
X25vX2V0aDFfbGlzdC4gVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg==
