Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917CCCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48B4838BB;
	Mon, 27 Oct 2025 14:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D05782C7F; Mon, 27 Oct 2025 09:26:37 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C3780107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 09:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBWkWVAZvAtqUlhFsd42rQpG55IgUx3d/nuPxBUGAia3R22q5mR+5S9sLnp5BgfAs89uJagTnIkk4pMfbR+vLSXDFSnkRu/F74coU4Ju0SeVs4RRONkutGhDUzn/CTcEagVZ9XS5io8jSaQxK+QtYqGef09paXsDOpPreNWa7yTkR1No7oZwtfDjZTPtap/xS1bVTQ+ov/aZk1xeGiJF2ycez+SkU/9Gj5NXAhR7KgFXRclEHXzgw2MLmCBZy6hj8tCqv6EqjIPOG3gzY7tTprpi37yHAFrUnRJP1/rcF7GnJ9CoJ3eQdovO+0qDVF6QATBNoG7NnyiTcPMbam6Iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSaVOwcY4TbjEBPm066LnHkc8gKoZPB5ZZ6+2BlbAIk=;
 b=WxgYutW3YTKnsytiO4byDlEyBSu3o8acN2H008NMCyBjDKZTdqbL8H/mq1ouqCU3yid+OxiuGSGA1ztBn+Cya8cWzk37EaY7B9wdQ7WLobEIolaiJ++mELh/KyS2WwCBw3d5kPdjm7y2subk0rXBoxcZTe+8/uVWaeevK3VAGp2Sg8/UkTbmwB5qxJplOHdk+cBP084/84cUCKn/ogQmNtbp2gkx5pvv8Qy8jlTkFQ/icbGF1wUalVSj+6ovgnm4XbV+4g/1mGdur0rIRzdp9NDXcJfNi6QAJjn1tffyL9m3MlQUt97DswXoLJYHDjsr3Fgl2y9XeY9+2KPKdwkdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.19; Mon, 27 Oct
 2025 08:26:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Mon, 27 Oct 2025
 08:26:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 6/9] pcie: starfive: Add a optional power gpio support
Thread-Topic: [PATCH v1 6/9] pcie: starfive: Add a optional power gpio support
Thread-Index: AQHcRMSKqFw44B73VkajXnFzy6OgdrTRRWAAgARmloA=
Date: Mon, 27 Oct 2025 08:26:30 +0000
Message-ID: <ZQ2PR01MB1307C4F772E3BD3308FC1AE5E6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-7-hal.feng@starfivetech.com>
 <17e37755-6a5b-4950-af34-281e4930969b@freeshell.de>
In-Reply-To: <17e37755-6a5b-4950-af34-281e4930969b@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
x-ms-office365-filtering-correlation-id: deb65372-9100-46e4-4659-08de153287d7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: 0/nGKHvvL3iniHD0ALQ0ys8t388ubEXqHvPbXvw1CHCM9gIHp+09Jqb5M7G5Di9TXYLzHi6Sg24RnPlgBQbEq8vH8tk4CbAaEHGQ3dRXJZ73kmCZ34eds5468D5BgMSAUiy6Kjq4Hqkfa2ZqZRZwRfcMh6sYmewjHrTyuZdO1zC7bmyq6Qd0Kd9fr8DsBaUpKUahvL4V+ojIP7EpqRkwdDnJlSxGotR6tbpR2WUmbVPVuCJSsbuJdpOYpSihL0gZfTyxxAvI3qMcm9bcfWpsxfj4KGs1tOdoFSYN/ndprI/qvdBDV8L8m7qp5KWPTyOnCOywxrXcQxoKb7ldgbOkoR8rY/cm+U4QujpN0KDHeH7F/5wsm+68wq+EUFoh4oa+WqXrEAnAm8O8+QK5KchRgeA+iE0iWpDuz6Jg9LGL4Qz6x8B4pwBc17Sneubzla2pjKX1yBYwMz2xMzulK7UDbLov5oIOOiLy7pDX3LJe51tICJzKhSsJ3kTru7VlGtFg4xQxC5+2aBuf+g8c1tyO1JkllrKtcsOx+Id/qKkAoRxjZ6vRRnzJRYnra5DC/LwrBqo3vlFJHFyCbnlKLkNDpCs9kIgibv5FXefMdqk6SBY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkcyQldYSkVOeTVMaVlkUFV5L21aMDN6bTdjUURyNmdQdmgyL3F5Uk1jQzF6?=
 =?utf-8?B?eThQcGJhSWJ5M3p6cysxWXRBTGQxUjkyVDljZVhsd3FZeW9mOVZKck0vMnJL?=
 =?utf-8?B?a0tTWUcrbVcrbXFUSldxZU9SamlqWUpxZkdaTmVYUDZERzNSWW9DMDR2L05o?=
 =?utf-8?B?RFhCOU9CU3R5WXdpbkZidVUyNEVBQ2dsSVczUWNyejMwSk8rTXcwc1l2d0tW?=
 =?utf-8?B?bWtmNkdYQy9FQjg0Mzgra3ZYZVQ3dGR1K1hEbjFTaGQ1VE03MHNIS3JQZCtI?=
 =?utf-8?B?eE5qOG11bytLUG14K1dhVHN2TUNaWnhSQnpOMzZ3bVh0bVB1K0RiTEVJV2hE?=
 =?utf-8?B?VkVoZlhKY3NsSkpqRnhaalRySzZwQTVxak9LVzl3ZG1FcWwrcWxMd2xtMEtV?=
 =?utf-8?B?bkh5Y0JQWHJzTHE0VTdsTmxGV05PNWpERHJoelpNZGZuMUR1Nnd3VjkrSlY5?=
 =?utf-8?B?VmdCNHFCMk1WTVd6V3hsWU5lcC9XWFBTR09rVmRZbUJiU0I0Yzl2SVpxOFpz?=
 =?utf-8?B?MUFTeGRPUXp4NkJLQ0VqOVpRUjB3TGNrbmlhb2o2b0xkRHNmelBOdE5KWHZV?=
 =?utf-8?B?NlJvNzM5MnhrdmVBbVFlaythaG5xbGNJRVNpbkxNdTgyNHdLSGlVY2FoOFV3?=
 =?utf-8?B?c29HQ0dGWVdqRDJDUExQODI5QkM2UHRhSUtEc1ZhSDJWQ1BVUTNDdHBJMUky?=
 =?utf-8?B?T2Y0amRWZlNGVkVhMGZoUTJUNXN3ZnVlUmFock4zT1Z6WE13SExqMnJaa1Vr?=
 =?utf-8?B?UFJFdlRydUNXdEhVcFFUZng2dnVwYjZwQk1zamt1dHJzZG95NmNYdVBOekRS?=
 =?utf-8?B?aG5PZzhYb1FuYzJDRjc0NGUrcjNoUy9wVnd4U3R5MUhzcnRScEhkNFFjVGJa?=
 =?utf-8?B?c09EN3lWUlUxbm11S2F3eHNRZFc5YjBCbDhzdmpaRHprWC8wZTFMbnFSRWha?=
 =?utf-8?B?cDc3enZtSTNIbGVsb0tNRS9ESTdISXRwM0pTeFhYWi9DVnYrOFNmamhFVmxh?=
 =?utf-8?B?eWlkcE54Z1dzcTJQbWs3R0RFRmNNMm1mK1dGQzFpMnIydXhER2w3OG1ndUtz?=
 =?utf-8?B?UWEvcTlMQ0x5emxaNlBMVmhhYlRlc3k0cGQyQ05XaWNFQWVTSHNQcEJRS3pX?=
 =?utf-8?B?U3BTSTIzRS9LVGlDb0NqMzBFZVlFRzhsVE4rZGpKUUJ5Y3V2VzhTeDRnKzkw?=
 =?utf-8?B?MG9tenhLbFJ2a2llQXBGZCtkK3lUSnU5Q3RnbHhuSER3dWN0UmxJdmtrZ256?=
 =?utf-8?B?RTNCeTJTSlZCVUkram9vTlV5c0tQTWhOalg4Tkxhc2IwOTNibVhQdUVFdzF3?=
 =?utf-8?B?ekV5Uzh3ZTBXbjRsNmtKb2hqYzZyRnpRRGxpY1EvK3JaY2R6ditNS3VZYXRj?=
 =?utf-8?B?UWxNZFVUVko1STNtcnpCYWVtL0hWeTA3eDZUaW5UMWcydmRmTWZBZXcrOSt6?=
 =?utf-8?B?V2dkT2o2TU05UXcrSUkxMDNsdTN2MDIzR0h3MEhoK1BiR2NPeHRBMWN2Q0NR?=
 =?utf-8?B?REdsRG1WR2tsM0ZUOGlLZGFNV0ZqT04xQVI2MjJxeTRZdzhicUNlWktnQVZW?=
 =?utf-8?B?TjVsMk13V3FJOXpYSkpZbGJJcEZaNjkvaTYvRTgyekNFZGpjL2F0UFdwOTFE?=
 =?utf-8?B?Z2RFNVl4Z3NrRFNtSWZuMUhQMEZ5bVp1SUtqdFRZTWl6V3pLbC9FcGFtOW94?=
 =?utf-8?B?NjFKUXFDRHhKZU1DTWQvZ2E4dU51V2pycmFqRXJjay9MR3ZDZGx0N2t5T2tl?=
 =?utf-8?B?SkNCZFdieHlaZ2xNTjVteWNoQUhvaTJqdUJPbWN4amJvRFl1S09oR0RJRkc5?=
 =?utf-8?B?ZG5ybGJuK0x5dDZneHBsNTI0WkVFRFd6UlBKcG5vNGkvaDJoOGRMQWJocjJH?=
 =?utf-8?B?bEllQkgxN3dEL1lTd2ZNUkwwVmxFbnRMbjRZRWFTRE5pWFhuSmIwUFVaa01k?=
 =?utf-8?B?c2RUZUJIaDFuNmpUZGpHMzJMa0FNUWhMNHNJNjEwblJRTTZVMTdzclNnL09V?=
 =?utf-8?B?djlHS1dFNlZwYld1ZktiRUlwazFUSWQ4SXY1VC84THFqS0xWV21oTU44N3Mx?=
 =?utf-8?B?MjZZdkExQ0VCNG94dXowNDJyQlpyVDBxc2ZvRnJuZFVDc1dxTGorY1hYTW8z?=
 =?utf-8?Q?4pJBFh50rr0P0HYIZ6ikUS/4l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: deb65372-9100-46e4-4659-08de153287d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:26:30.4360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKebXGYHHHrURjxmkk6BkdmI/sF9lR65Mq/EGyTnOwwY3ozRx5YcPHZq5YMpMFjDkXP7wmcyrknzTd0m3gapKPEQvYCO0Kg50V32hgZs68s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:02:31 +0100
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

PiBPbiAyNC4xMC4yNSAyMToxMCwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiAxMC8yNC8yNSAwMTo1
OSwgSGFsIEZlbmcgd3JvdGU6DQo+ID4gR2V0IGFuZCBlbmFibGUgYSBvcHRpb25hbCBwb3dlciBn
cGlvLiBUaGlzIGZlYXR1cmUgaXMgcG9ydGVkIGZyb20gdGhlDQo+ID4gamg3MTEwIHBjaWUgZHJp
dmVyIGluIExpbnV4LiBWaXNpb25GaXZlIDIgTGl0ZSBuZWVkcyB0aGlzIGdwaW8gdG8NCj4gPiBl
bmFibGUgdGhlIFBDSSBidXMgZGV2aWNlIChNLjIgTS1LZXkpIHBvd2VyLg0KPiA+DQo+IA0KPiBU
aGF0J3MgYWxyaWdodC4gR29vZC4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhh
bC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3BjaWVf
c3RhcmZpdmVfamg3MTEwLmMgfCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llX3N0YXJm
aXZlX2poNzExMC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9wY2llX3N0YXJmaXZlX2poNzExMC5jDQo+
ID4gaW5kZXggMDkwOGFlMTZiNjcuLjA0MDg4YjQ4ZGRjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL3BjaWVfc3RhcmZpdmVfamg3MTEwLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2ll
X3N0YXJmaXZlX2poNzExMC5jDQo+ID4gQEAgLTQ1LDYgKzQ1LDcgQEAgc3RydWN0IHN0YXJmaXZl
X3BjaWUgew0KPiA+ICAJc3RydWN0IHBjaWVfcGxkYSBwbGRhOw0KPiA+ICAJc3RydWN0IGNsa19i
dWxrCWNsa3M7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY3RsX2J1bGsJcnN0czsNCj4gPiArCXN0cnVj
dCBncGlvX2Rlc2MJcG93ZXJfZ3BpbzsNCj4gPiAgCXN0cnVjdCBncGlvX2Rlc2MJcmVzZXRfZ3Bp
bzsNCj4gPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gPiAgCXVuc2lnbmVkIGludCBzdGdf
cGNpZV9iYXNlOw0KPiA+IEBAIC0xODQsNiArMTg1LDEwIEBAIHN0YXRpYyBpbnQgc3RhcmZpdmVf
cGNpZV9wYXJzZV9kdChzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJCWRldl9lcnIoZGV2
LCAicmVzZXQtZ3BpbyBpcyBub3QgdmFsaWRcbiIpOw0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0K
PiA+ICAJfQ0KPiA+ICsNCj4gPiArCWdwaW9fcmVxdWVzdF9ieV9uYW1lKGRldiwgImVuYWJsZS1n
cGlvcyIsIDAsICZwcml2LT5wb3dlcl9ncGlvLA0KPiA+ICsJCQkgICAgIEdQSU9EX0lTX09VVCk7
DQo+ID4gKw0KPiANCj4gQXJlIHdlIG1pc3Npbmcgc29tZSBlcnJvciBoYW5kbGluZyBoZXJlPyBJ
IGRvbid0IGtub3csIGV2ZXJ5dGhpbmcgZWxzZQ0KPiBhYm92ZSBpbiB0aGUgZnVuY3Rpb24gaXMg
dmVyYm9zZSB3aXRoIHRoZSBkZXZfZXJyKCkgcmVwb3J0aW5nLg0KDQpUaGUgcG93ZXIgZ3BpbyBp
cyBvcHRpb25hbCwgc28gSSBkaWQgbm90IGhhbmRsZSB0aGUgZXJyb3IgcmV0dXJuIGhlcmUuDQoN
CkJlc3QgcmVnYXJkcywNCkhhbA0KDQo+IA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0K
PiA+IEBAIC0yMDUsNiArMjEwLDkgQEAgc3RhdGljIGludCBzdGFyZml2ZV9wY2llX2luaXRfcG9y
dChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+ICAJCWdvdG8gZXJyX2RlYXNzZXJ0X2NsazsNCj4g
PiAgCX0NCj4gPg0KPiA+ICsJaWYgKGRtX2dwaW9faXNfdmFsaWQoJnByaXYtPnBvd2VyX2dwaW8p
KQ0KPiA+ICsJCWRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5wb3dlcl9ncGlvLCAxKTsNCj4gPiAr
DQo+ID4gIAlkbV9ncGlvX3NldF92YWx1ZSgmcHJpdi0+cmVzZXRfZ3BpbywgMSk7DQo+ID4gIAkv
KiBEaXNhYmxlIHBoeXNpY2FsIGZ1bmN0aW9ucyBleGNlcHQgIzAgKi8NCj4gPiAgCWZvciAoaSA9
IDE7IGkgPCBQTERBX0ZVTkNfTlVNOyBpKyspIHsNCj4gDQo+IFdpdGggdGhhdCwNCj4gDQo+IFJl
dmlld2VkLWJ5OiBFIFNoYXR0b3cgPGVAZnJlZXNoZWxsLmRlPg0K
