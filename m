Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BADC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 01:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1EF805D7;
	Tue, 18 Mar 2025 02:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BD480F70; Tue, 18 Mar 2025 02:02:45 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20722.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C1280107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 02:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMKIWYmtqpern48siPMEOxnGz713z+clcDj4i0tC9cXxMJw69Xzc55/1YhiA3clNoX2XjSBvg36aGvGfoOql6kxSSz8Tj924L36EPcWz59H6Cj1gJiwopF2UYIQVyUAbIPRw7y6S+K13DJ9EcT7BF1/1eJNaY+C/EEEWkSCK5FcebUAkIN1brMcJ1npsvlzjY1Ct3O75xPg3IHh8OOYDpwfxMc4rNaeXoUTbiQksQQ06Ujw2GnxqQpUhxn+UFLyD1+8BMQEcF1zpLC7Wv4hgZbbBdfsVoZfvyb0CN+Zas4rV//s06VN3RljG8VKeF09SM/fRapMpFp7KrwudzeTDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLdHzpkGY/qK7guwlcyAqMnwHvu7xCF03zSTerKsK78=;
 b=DOgGiy8KcFrnakL2JiN1rXV1HT7CAS8S0qQdPtwY0WL032MYQycBy1XoB86IF6OIx58JJIUcSIq9KdKfoPs6LOQp3wSGVi9f0q4H+JIjGyBM2gvTkQIqAtzE/p6nWv1gPt+5XkxUgFwv5r4ybtOGLdqMJHqew1ClLMQxzrpG2G2uApav6UpYwEEiFFwdLZIATn849NPtaLVCEydI59fdnxCEEQ7YKUgM2VvySD61r4M2kC76cE1YS/bFpXEVHAF02oDfC3IMVx3pJt3TsULzMnY4SplP+fUapGD0Y4Dau8M7JLTKCP66i6rtZZ+Ef8hhssmu4rUM/ucEAq7Emdmszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0526.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Tue, 18 Mar
 2025 01:02:35 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Tue, 18 Mar 2025 01:02:35 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Hal Feng
 <hal.feng@starfivetech.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
Thread-Topic: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
Thread-Index: AQHblzDVWITfvcCCqUSlqwA8m6SyhrN3RmQAgADOGGA=
Date: Tue, 18 Mar 2025 01:02:35 +0000
Message-ID: <SHXPR01MB086382C94AD9C7988302D1B0E6DE2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20250317113627.84885-1-minda.chen@starfivetech.com>
 <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
In-Reply-To: <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0526:EE_
x-ms-office365-filtering-correlation-id: a45cc6a9-4a77-4e16-e1c5-08dd65b89243
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: l16hno+wd6Hx7eNRcS4423jSCRQ4ld4z4l8t7fzzeVdbmZq01EXy6zletw0cMcJaWDu73S/5Qm36p6kATPNtjtP+wVEnBRXoZq2E93sfHsa2TbqZx2USEGJ+l0ttTGnPY6WKH0MKPMsavTBkqvREvouSmAUPPlVGLXUwSCiN0bk54KnvHWPokzDpJ8KO4BWmWNoJw2o3Rw2xan1Slv9QUgH9Zpj6XadwnwWFkW18BRFXptRitCkqIPv7Rei7p924a9X6JxHx7RHOYpDtPjzGmXyjKHiI9GrB+1Z3db/NBSAdW2RbV+4XGwaamRhZMHlGCZl3QRuUcyca5pvE5b7mmu8Fm+OEJLv81X84mu9n1vR+hFuErGi75Q2UcHnlH1w6OIqw+BlW95JH4M1yGww34y/R8S3CwR5WIrSs6GiA8PiwUpCkLDeEgG+9eV1xCi4HelFfwR3MqeQYf5swLdiftWBLavW5/y2vD8TNW92OuaqiZ13ENVN2dZiEoF8bxdiX3IAxFjwwHEG9XK2yBOETeHxfmc8nYN4YUaMpPOkiiOYIJ3wfAS5z5kZBbyuPTk3nyue4xGrpH24kV6bbxfQTokK5Nr0RbpJJPSp6k8I/TP0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVVkZXFlMUwzdGhZQlpoVVNhZ21qUEFtR3dPWitPaGhvY2hUeUptM3E2RGdS?=
 =?utf-8?B?dVhlYjJIY3ZqQkFsbVR2aEZHcytRUWF4dlZCTXNDaE9nMkRJSHFtOEV2WTBU?=
 =?utf-8?B?WUVqRzhUWEE4bnRoKzFham9JQTVLaWhNa2VoeURGMDNBUFN5K0pVdmVlMGVY?=
 =?utf-8?B?VEpDelNVSDNTdGJjc3RpcFlLWThTUmFmdXFyOW1PWlI4ZFVnQ1FZaVhwaGxL?=
 =?utf-8?B?TlMwRmpxZERubFlhbUFJZFBJdkF4Z3hCVUJyQnBKUjRrSEJTZ1BLai9OR01w?=
 =?utf-8?B?eG9MQXpGdmJ3Z2htbWJxY3IwZlM4d2ZLVU5TR2pQTGoyN2M5dHpjb2hPdkJY?=
 =?utf-8?B?THlLbnI3Ukx2NW1XdkRrYkxBYmVtTVZiUW0xbmFuSHcwdmRoS3BrT0QrUWg4?=
 =?utf-8?B?Zk5Ydjd6U3RHcHVNQThkOUd0bzlPemJ5Wm1SdGp6cmt4VnNBcGFQQUUxK2J5?=
 =?utf-8?B?RzU2djZkY1FSbmMvRUtvSUt3MTI1UTBEUktjVHlpL1dlbkV3LzdiQU5sdTRa?=
 =?utf-8?B?Q2Rod25aZ3lUR3pDZU8velVLQzBhcHdvdXFQNXNuNnc1V0pycXJzMWluQzBp?=
 =?utf-8?B?dFJwRDdIZWtTeG1UTThCTUsxbXdYeXFtTFpNQ2RKNGVvNmR2WGFQa1c4Nlpv?=
 =?utf-8?B?VkZZa3ZrL3ZuSWlFcC83eTRPZWxVb2F5SWFwY0JSYzNFc2krcFNOMlJtQ2Y2?=
 =?utf-8?B?aHhTVnFmNVE0cUlDbUd5OVU1bEJCRUtzQ0RsTVRVWlhLK3lwWXl1azlOaHVJ?=
 =?utf-8?B?TGhDYmcyREFIa0t6YWFNekxIbnRucXhRRmpkMkJVbThBQ01sTStkdVdxWTBr?=
 =?utf-8?B?UHdGaXcwN1RyRWc0em5YK2NTdC95ZjRlTXFjUVhQd3BHZ1Z4RUtETkhjakJT?=
 =?utf-8?B?Vm81MWVDVVJlVHMvSkh5Q3dXakVtL28reStjT09NeFFScDAvbWFVZzNpYlc3?=
 =?utf-8?B?ckhPY3pNSHBxTkE0WElGSFcwL09vYUc1cDhLVHNURVpId2RqUmFWYVY5NkdW?=
 =?utf-8?B?N21WSCtGa3Mwa293NzhaanRMY0xpTW9EZmhDM3VyZkhEUmh1Q2RpaUxCaFdv?=
 =?utf-8?B?RXd3L0hNR0hrelNkaytBemxlM296MGVhVEhpR1JiMmd3VkNGamtjd2ZaMzRV?=
 =?utf-8?B?OUJIQXRaTE1GV0d0KytrVkJtOW5VcjRTNEE1d0hiM1pkeExWdFloTnFUaUYw?=
 =?utf-8?B?RFFnS1NKUlhFZU41a2pZLzk4NmxkSnFpV215YWt5OVYwL3R2WHJFMzZ6OFJt?=
 =?utf-8?B?OGZvcUcvU3RjYURJdEVoZkx5RXdsYTFqOEVNcWR6MU4xSExlZ2VzYWFMejhJ?=
 =?utf-8?B?M2lBcm5GZ3JBSXBwVVFMRmp2cndWZnFZMm1icm93aFg1VUhHL0VDa3RUbW8w?=
 =?utf-8?B?aDAwUEtRQS8zZXIvTG9FUGl6ZVBFcUpITHgxM1RZdnRqV2hreWo2WkVubHc1?=
 =?utf-8?B?TGJKSlV3Qzg2VVNEL3hOT2Q4anEwOENrVkdCZkRvYjE3RHdKdEhETE1xay9i?=
 =?utf-8?B?aXMrU296Zk1ZcXc3UXZ4TVE2MDI0QXowZmJjTFVLcHpBejNSM29XU1ptbVJV?=
 =?utf-8?B?Y2RFN1RpMXhQd3B0anowK3U1bi8vQ2FHLzZrUGNmSnpPUlgxTVJac0FYeWky?=
 =?utf-8?B?TWFnVGI2UmY4L0dZRVd4KzUyeXpuWjk4T09ENkU0djlmWTV0eGZPRGNQMUds?=
 =?utf-8?B?aVVOU3J2NkV1YWFYM0xsa3UvdTR6ZFhjbEluSTMwL2dXNWl2TlJPSGk4UjB1?=
 =?utf-8?B?Ui9ZS2lPZTFKRkxXZVhmR0hkVnRGKzd4cFB1ZXcrME4yMzBna0JKQWZCeVJ0?=
 =?utf-8?B?NGZoeGxWNGpTbC9RQnMwNHhwNzZWazFRVE10bElGY0V3SU5jdWJJS2ZVTHFM?=
 =?utf-8?B?SlJBTTcvWDE3a2dyYmJ1bEM3K2xUMkRFUU1PWGU0anJZakUzQXBHWFJDQ21V?=
 =?utf-8?B?ZEI5bGhwNm1oR25ER1doWGtWdnNDTm5jSGpOZHE4Q3EyWkNQOHNZN0xoKzBG?=
 =?utf-8?B?TS9FQWc5bTBVQUtjUnpicXYyMXB1NkZmTGVrNDhzVVZ0MkhsQTMzdGZtZnN1?=
 =?utf-8?B?cEVkb1VPdkg3Q0RlKzlBN3ZRQ0tTVjIrY2wxdW9sTWw2ODg0TjB2U3hpVUpX?=
 =?utf-8?B?MUlUV3dNYlpFd25RN2p4eVp4N1I4Q1dNM0h3R0N5OTcrTjBTcXZjaCtBd2JX?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a45cc6a9-4a77-4e16-e1c5-08dd65b89243
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 01:02:35.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4qMxlZqnCyG5e7myMcMW9ZFtXE1q+U2LTf5H/W58J0zB6mZV5bPDIZUdTuh2EszT+b8pw46gopzQgVD3T1AZSXhXFD6jpAa3AdB9FcWJIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0526
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

DQoNCj4gDQo+IE9uIDMvMTcvMjUgMTI6MzYgUE0sIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gQWRk
IFVTQiByZWxhdGVkIGZpbGUgdG8gU3RhcmZpdmUgdmlzaW9uZml2ZTIgTUFJTlRBSU5FUlMuDQo+
ID4gVGhlIE46IHBhdHRlcm4gY2FuIG92ZXJyaWRlIHRoaXMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gICBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUyB8IDEgKw0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYm9h
cmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMNCj4gPiBiL2JvYXJkL3N0YXJmaXZl
L3Zpc2lvbmZpdmUyL01BSU5UQUlORVJTDQo+ID4gaW5kZXggODk4ZTI4NGNlMmMuLmYxZDJkZWI5
ZjVjIDEwMDY0NA0KPiA+IC0tLSBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL01BSU5UQUlO
RVJTDQo+ID4gKysrIGIvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMNCj4g
PiBAQCAtMyw1ICszLDYgQEAgTToJTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+ICAgTToJSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4g
ICBTOglNYWludGFpbmVkDQo+ID4gICBGOglkcml2ZXJzL3JhbS9zdGFyZml2ZS8NCj4gPiArRjoJ
ZHJpdmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYw0KPiANCj4gV2hhdCBhYm91dCB1c2lu
ZyAnTjogc3RhcmZpdmUnIGluc3RlYWQgdG8gbWF0Y2ggb24gYWxsIGZpbGVzIHdoaWNoIGluY2x1
ZGUgdGhlDQo+IHN0cmluZyAnc3RhcmZpdmUnID8NCj4gDQpNYXliZSBvdGhlciBJQyBjb2RlIHdp
bGwgYmUgdXBzdHJlYW1lZC4gSXQgaXMgbm90IG1lIHRvIG1haW50YWluDQo+ID4gICBOOglqaDcx
MTANCj4gPiAgIE46CXZpc2lvbmZpdmUyDQoNCg==
