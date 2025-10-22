Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1739FCCD1BC
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F548392C;
	Wed, 22 Oct 2025 17:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3CF83303; Wed, 22 Oct 2025 11:59:36 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20722.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA7F8323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 11:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9ycz6Va6cqevdXk4m10rYpRqCPt/oo1+WuCjsYBsIp/Fjo14aQT9BSl5m7YLjyWNr8Jt7cIDDJHV3uZoh+YfltydYeqpwtziClEjs3gLIyEt535GKKa4VvhfUlEykJpU0xygd6WlCigQWz60LT56n9KfzdCv4ddut89uDCu+PAGhFRfgF8wypMmeLdy5SlRHvEZ/NfYAHFLUMeUkkVTxwbzgHnz0p8S0mx7zeTVhRC2dZdHN5v77nmWXsl/UhRUZ0xGsGISubkACrv0/SEaNvyBz8RfkDauQzMBcGkPvxl/m0KRCr3svePxyHrd2qnbSXp+wZwL03ktYq2+4zUO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK3I/k5GiGPjMDRsBAVOV1ZUqjQwVgfoaDuaDFBxoOg=;
 b=l9fjkWSMz021ggAnpbSp+pv3rbdQCGIjEIG9Ob2q8nrRLrrMBVqPrzh9QrtrHHyV5LYnt9Mmk8cn+wnttAl1LTEK374I7hb6lHfNokt/gdbH30DHtT9k9s/m3NXKmgoGNx8IllKAqX9kDWIgmTCmPKKFjVbg/Op6dNvR6WThXMo9Q8rPvbEZEVEKMZ2czGSOrtr0ZtzA8RsK0LGXoi7jE6XK18bNJ7wSKBVUUXwA4qkcW6HT8mwIfb4Am7+Mc3GuiSadI3q7/4h84ElviaUaiYvmG5orAgeGnqUC42eYym5dzLFEcK6SaA/7CD4S6Lpdh2mPwf8ELFFY2HJDk+Lvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1179.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 09:59:28 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 09:59:28 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>
Subject: RE: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
Thread-Topic: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
Thread-Index: AQHcGKuRGdrOQFDrokCIdoM1lOkBBbR5OQuAgAbf1ICATh/IUA==
Date: Wed, 22 Oct 2025 09:59:28 +0000
Message-ID: <ZQ2PR01MB13075C0C6A214EC48174F248E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-2-hal.feng@starfivetech.com>
 <f8ed3792-70ca-498f-9ce7-65040860db07@canonical.com>
 <01a5ff2b-bc20-4670-93ce-2b66df408b96@freeshell.de>
In-Reply-To: <01a5ff2b-bc20-4670-93ce-2b66df408b96@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1179:EE_
x-ms-office365-filtering-correlation-id: 6cef87e2-3682-4873-8c6d-08de1151b0b2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|38070700021|7053199007; 
x-microsoft-antispam-message-info: LS7XW/LTdDoBt4DLgB0fA2yZj1W5frJ/GNWXG2pnUxQ4VcRleFssuja7DcfsymfAjx9qgH/PgGG0Hg6TqphEMMqfOgWPW1LkhalTbQUyawk25zNv/JiyhBPBiUmEBFmuHWG/eBSViqRni35t0RdR/00tDTXCchWi+Tgr0966+ocNxCFSm9d2RxgtgaG9x1SGq0t1KEOJh1Rj1AiJ1LgpzZ1L5liD9eDrnmph1Hm0ssArdmanVBFoYIKyx5Nkn27PQbx77e7fOLkdJeZ2OqHKY92JBkucPfpRHBQYbH4KGp4r/6m+lOjGSfJiUEwhTC1nIg58n5UiQmoNWL6KjoCTDl/0BIeqPDoDxhp2nO5KDugtDyS31uUIu7Ay6szb5f7R6wPn8/SFXHmoXu13G3deBbJhmczQWFt3xn45ennvyCD/FCGK2qYyhU/E3uf7kcuZfmgwY0Rj4DylDb+uYhe2US/qDy5qqH0cYsSAbWMkp6mFkfaHuquov4EQLXAMzBCRTCO+FYmcFKcW4fqERnRasN6FCY9SnSU96EAspWnu0PHYaoZvmOISupjhWg4zaw2l/wonUzhBcoq+2qE0ormSvbnX5+tzPE/Vhkd7390g4DQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(38070700021)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCttRDZTTVdmbVVUZ2pWTW9HZjFPZnI2bDdyekpqMklTcUZIZFZkeDJEdEtj?=
 =?utf-8?B?SmxXaVZEeEVaRXV2UmRJVFhHSTBBT3FyZHVYaS84bFB3MWFNRjE2ZjBjbkQ4?=
 =?utf-8?B?SVlBSFdEaDFqVnprcHBsUzI5blpyZjMvZ2t1ZElaWGJTS2duemVsMndETVlp?=
 =?utf-8?B?T1RzdzZFYVlyRnh6TjFEWE9MR3lQTHBBdUxITEZjMXIzdHMyL3hMSS9UR3pS?=
 =?utf-8?B?UFdsV1pzQ3BwZmQvMkRlUTJvdm9HZXJvbVk3Mi9TZTI4M3VlTEhoUnR3dmti?=
 =?utf-8?B?bjM0Q1FVOS9aRVF5ZDVNYnVvMHBHZmJGQmtuaFFKbGFQVXJUVVcvTDdBM3Fz?=
 =?utf-8?B?clhPS3Nhd1hhTkJYSTRHRnVFVTRJRFVSZ0pSd05oQUZ2Z0tpcWwwdGhOaVVY?=
 =?utf-8?B?Q1lRMEtuYWhUMG45TlFVeU1Xc21DQlR4RExVRnBHcXp2b0VrN0JRNWQrQ1F1?=
 =?utf-8?B?YjlOY2ZIWWk3M24xdDlpbncrbWlMSVpCanQ0Mk5nNGthdVNYeGo1b0N4U25R?=
 =?utf-8?B?azVrSjJLK1g0T0NLKzYxdnFOS09WYnF0U2s5V0sybEphREJ2Mi9oYkpqV0p3?=
 =?utf-8?B?dXhNNVYrRUd6TmFzT3V0K0lWWndCM2FGVHAwRmR6K3FmSCsvZUlWSlJJZ2hT?=
 =?utf-8?B?Zk9QeG5DczY4TUxxQUEyNjhQQlNEUjlSNGIzeFh1eWVzWWZJdU03cDJQYmdn?=
 =?utf-8?B?RkE5TUg2TmpQSFV5ejRmRmtCUXZHeWhTSzRHNFF3dkpoS3dtcGp5Y21zd2Ra?=
 =?utf-8?B?TjNuSjYwR0YzSXk0VGYxOHl4Uk9oVDhhb0RwR3R2NFFHOWFiL0l6c2h5NDNC?=
 =?utf-8?B?cDBZem02aEpNL2ljdmY4VnhPNmJMd1lsRnZ0TDRwUU5VSUdFVVI4bGM2Y1h2?=
 =?utf-8?B?aE1MTTZZNVJOYXpkRHFwK0V2ZzRFeGplUWxncUI2M2VPOTBpbEdubGVVMFJU?=
 =?utf-8?B?WUZEelUrak53bERkU0hGam1oV1ovUEtUZnBCRUZaK3RPMTV4M0xGTEJiSGND?=
 =?utf-8?B?S1daVHcwNzZ6ajVRL3grNENhRVV6VHM0VTdBS29nNDdJSkQ4R01na0dWVi9L?=
 =?utf-8?B?M05EQXo1NUxEV3FEbmhCb1ZuY1VBZGFKWFRqUFlUNWNxeU5jelJEeVlGTEph?=
 =?utf-8?B?QmMzYU1iSnBualBUNTFVdysrMmh5YXlYK3BZL05meG9zdFVEZ0ErUGxFTzho?=
 =?utf-8?B?SXY4bEVOK2MwZUNHMnhBTDJ5NlY3NWlIOHozTkFWM0FVdGwrRDA5TXhGWkNl?=
 =?utf-8?B?ZU9ZTFZvZ3ZzajlFRjZSUnViTEI0VjNsdndsS3lmQ2JXVWJMTDVxWWdVNTcz?=
 =?utf-8?B?K0EzOEpXZWpDTkQwZmtIaWZ0UG14czlvam5YLzhBczRaRkVqRWVFWHhYQ01n?=
 =?utf-8?B?aGdKNG9sN1lPeDd3Y3djN3VlZEdBVEpEdSttZHNZM2xTcHlmUGJDSnpUNnZJ?=
 =?utf-8?B?UUQ3VEdCencxczBaeHRDVDdpc1Z0ZGpPUXRaMm53bWh0UC9EN1JVejVxdFZp?=
 =?utf-8?B?eUl6NmJZS1Qra0lUTnVvWUZ5YnRDUGNHaHF1MEhJWGFwNzF6d1BndDFsbkRK?=
 =?utf-8?B?cXVZUXdPRlVZUCt2eXVZcFBVK2NPck1rUEpJL3VSNVkvV3RudWlDMk43cEk1?=
 =?utf-8?B?b1V0NXJHWnlscnRLT1I1YVVCcFFDRmcvOFhGdUdRamhnQWgzM0tFcGszUmt6?=
 =?utf-8?B?RlliQlVJMzJNWjlPZzRSSnVlb2MxM3g5SkhCTHREQmZGVnVta1d3Q2xCblVo?=
 =?utf-8?B?VUYyZXY4VWFYazJyeXZHcDRaaFl2SDZ0REdnNnpiZWdyNFF4N05tUjYvWklV?=
 =?utf-8?B?enJmNmNnWmFQRTJ2RksvSlJ4R0RWTXoraDFjalFjK3IrNk1aWWt6MVEvdWhH?=
 =?utf-8?B?d1gvQW9qQjJ4QkI3TjRBdnRPOUVsSnUrNXhEemhWMWR4Yk9DR2JoZFY2bFFl?=
 =?utf-8?B?dXhpQlFmRlYwNUk4RUZwMlBVVHVTRENyYitYanc3bUEyS1hJY3dJa29MSmgr?=
 =?utf-8?B?T3BBeG1Xc2FVTlgyTllrR2tRZUhyc043bXNpVGVXelAvTldvc2MzWnBHNTBZ?=
 =?utf-8?B?VTlCanVST0M3Yi9CSndjd1hWc25IVThBV3hsL1pOMldBVHJUYTZTUG53cDB4?=
 =?utf-8?Q?J4bcvB0fmPDXUc/JblBobwyzA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef87e2-3682-4873-8c6d-08de1151b0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 09:59:28.7609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6uqRPB3lVbg4l1heK+F+/TYZ6v2jSvR1MSGLkRMxZmeLPGw7eIY0yD7KgaT+go1CscHxof4Cr7qvof8lj+JwNb/Y4QttE0DP1es8qVrPm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1179
X-Mailman-Approved-At: Wed, 22 Oct 2025 17:21:14 +0200
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

PiBPbiAwMy4wOS4yNSAwMDoxOCwgRSBTaGF0dG93IHdyb3RlOg0KPiANCj4gSGVsbG8gSGFsLCBh
bmQgSGVpbnJpY2gsDQo+IA0KPiBPbiA4LzI5LzI1IDAwOjE5LCBIZWlucmljaCBTY2h1Y2hhcmR0
IHdyb3RlOg0KPiA+IE9uIDI5LjA4LjI1IDA4OjA5LCBIYWwgRmVuZyB3cm90ZToNCj4gPj4gU29t
ZSBub2RlIGluIHRoaXMgZmlsZSBhcmUgbm90IHVzZWQgYnkgdGhlIHVwY29taW5nIFZpc2lvbkZp
dmUgMiBMaXRlDQo+ID4+IGJvYXJkLiBNb3ZlIHRoZW0gdG8gdGhlIGJvYXJkIGR0cyB0byBwcmVw
YXJlIGZvciBhZGRpbmcgdGhlIG5ldw0KPiA+PiBWaXNpb25GaXZlIDIgTGl0ZSBkZXZpY2UgdHJl
ZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZl
dGVjaC5jb20+DQo+ID4NCj4gPiBMR1RNDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogSGVpbnJpY2gg
U2NodWNoYXJkdCA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0KPiA+DQo+IA0K
PiBOQUsNCg0KUGxlYXNlIGlnbm9yZSBwYXRjaCAxIGFuZCBwYXRjaCAyLg0KDQo+IA0KPiBCZXR0
ZXIgdG8gZHJvcCBqaDcxMTAtY29tbW9uLXUtYm9vdC5kdHNpIGZyb20gVS1Cb290IFsxXS4gQWxz
byB3ZSBjYW4gZHJvcA0KPiBqaDcxMTAtdS1ib290LmR0c2kgZmlsZSBidXQgdGhhdCBkb2VzIHJl
cXVpcmUgc29tZSBhZGRpdGlvbmFsIHdvcms6DQo+IA0KPiAtIHVwc3RyZWFtIGR0LWJpbmRpbmcg
bWVtb3J5LWNvbnRyb2xsZXJzL3N0YXJmaXZlLGpoNzExMC1kbWMueWFtbCBbMl0NCj4gLSB1cHN0
cmVhbSBkZXZpY2V0cmVlIGNoYW5nZXMgYWRkaW5nIG1lbW9yeSBjb250cm9sbGVyIFszXQ0KPiAt
IHVwc3RyZWFtIGJvb3RwaC1wcmUtcmFtIGhpbnRzIFs0XQ0KPiAtIGltcGxlbWVudCBjcHVmcmVx
IGRyaXZlcg0KDQpXaHkgZG8gd2UgbmVlZCB0aGUgY3B1ZnJlcSBkcml2ZXIgaW4gdS1ib290PyBZ
b3Ugd2FudCB0aGUgdS1ib290IHRvIHJ1biBhdCB0aGUNCmhpZ2hlc3QgZnJlcXVlbmN5Pw0KSSB0
aGluayBpdCBpcyBtb3JlIHN0YWJsZSB0byBrZWVwIHRoZSB1LWJvb3QgcnVubmluZyBhdCAxR0h6
IHdpdGggbG93ZXIgcG93ZXINCmNvbnN1bXB0aW9uLg0KDQo+IC0gcmVmYWN0b3IgZHJpdmVycy9y
YW0vc3RhcmZpdmUvc3RhcmZpdmVfZGRyLmMgdG8gdXNlIGNvbW1vbiBjbG9jayBmcmFtZXdvcmsN
Cj4gYW5kIGRlbGV0ZSAnY2xvY2stZnJlcXVlbmN5ID0gPDIxMzM+JyBpbiBkdHMNCg0KMjEzMyBp
cyB0aGUgRERSIGRhdGEgcmF0ZSB0byBzZXQuIFdlIGNhbiBub3QgZ2V0IHRoaXMgZnJlcXVlbmN5
IHVzaW5nIGNvbW1vbg0KY2xvY2sgZnJhbWV3b3JrLg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg0K
PiANCj4gSSBhbSBub3QgaW50ZXJlc3RlZCBpbiB3cml0aW5nIFUtQm9vdCBkcml2ZXJzLiBIYWws
IGNhbiB5b3UgbWFrZSB0aGUgbmVlZGVkDQo+IGltcHJvdmVtZW50cyBpbiBVLUJvb3QgZm9yIGNw
dWZyZXEgYW5kIG1lbW9yeSBjb250cm9sbGVyIGRyaXZlcnM/DQo+IA0KPiAxOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy91LWJvb3QvMjAyNTA4MTUwNTAzMTUuNjI5NTYtMS1lQGZyZWVzaGVsbC5k
ZS8NCj4gMjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDgyMzEwMDE1OS4yMDM5
MjUtMi1lQGZyZWVzaGVsbC5kZS8NCj4gMzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI1MDgyMzEwMDE1OS4yMDM5MjUtMy1lQGZyZWVzaGVsbC5kZS8NCj4gNDogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDI1MDgyMzEwMDE1OS4yMDM5MjUtNC1lQGZyZWVzaGVsbC5kZS8N
Cg0K
