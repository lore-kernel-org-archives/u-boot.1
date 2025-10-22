Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6389BCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3FBE8391C;
	Wed, 22 Oct 2025 17:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F7D83303; Wed, 22 Oct 2025 10:44:28 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F82E8323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 10:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKijZhhE+pB7Yc/Qy+I1UHXXheFQu2Xdj22I0zCmplxfarnIAg/oLee6Ne62sud48Ax3+G1Fj2oQiuoBFPOU9PfC4sMaraono+/xaV77aHnNEfps1cQDWackWTeXzPZ5Mn4pDFW2cpcpmJA1mSHNFPQoroCIiGitfwMnVhMHeaqH8hBlnN6XIXdPhI/aWucbVR0/30dcYzOrx9Lo3Sf9jVS1qZGcdT+UEefMdJiBHREB4Q1pmubj0VseS/oPivhEJLfcgtO8Jlwk1mfnIJcBan5YBSyBc/XY2zzanh/14GuyqA8omALHUabBSm1jzpclN0eEkdjlLl1v7/6DY6PYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RElTreE+aTcRi6w8znvMU7m3K7b7KH9fKtkrejU8kQ=;
 b=HCmbGpaHPaQaYs4LWWOVUKDRhblSCvOJQApmDf+xeSr8DldsT37zTU0RprQhLYiH1ET1g9ParwZ3wqG+kwhbxkXZVlVDv/W9p6NGRT3GpUN8vOcRJtcLvNC+/A/hWV730xxSJHsndMTxeaZMJbs/VKIHPEMij+RhuywvLB/TKHPHll4KYceHCIdrtoBpi9BYGQgnPSSB74iqMkpFJTYfybZ6KXW28E6wBA6U6qR5sd1fogIgXPct/4V+JXVl0+oFS+VC0KZKF2/BvfZHpTAi8CDWApBDbbt5zvAi1lgm6vTys2LR8WDvmrJm5J7stmVXGMdlen3us+vRfImL5GIFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 08:44:19 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 08:44:19 +0000
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
Thread-Index: AQHcGKuTWM2Kq+GOykaliHufSb7fJrR5QBQAgAZDXACAAPiuAIAABWqAgE1Js6CAAGGPUA==
Date: Wed, 22 Oct 2025 08:44:19 +0000
Message-ID: <ZQ2PR01MB1307A66988AC38FF99832A1EE6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-5-hal.feng@starfivetech.com>
 <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
 <ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <7f46fbd8-00bf-4a05-af78-a089332e55d6@freeshell.de>
 <00962cc7-4930-4dbf-9c51-0faacee221a1@canonical.com>
 <ZQ2PR01MB130759C5E1FCE630443B87E2E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB130759C5E1FCE630443B87E2E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
x-ms-office365-filtering-correlation-id: a4e5019b-6882-4cf0-a8b8-08de114730f7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|38070700021; 
x-microsoft-antispam-message-info: s6OBAjhv4hsrjR1s7wr/o3JEl0mX/70v11HuB8Z1Us1KOxihWnVSbDZLpW7J+WhonEDVjfczP9BhQaoslFc/ZZ+hyBXNKFaJcKzH7LHhYAuQivpsV4G89GHY7QmZ+Ba7t6BBbsum3OgVf9/FV4bLy8L24IzEcIkkztB/ZkFZE6e15EipIIWVjx7dlKld69rQRTTQShJk3L0BS7zcfq8cIBBtmqKyLHZD8D68wdQNr/yBDzQGBigN1Rfk9IRRDEEVqo3ZZmwfIFMD+W5vX4nS+t5rABzVtlMZgTOLJxUSZgLJAf5xJ1REtUmlG6Ysqn5VD+3tkkb+sO1BZ/aXXHjDjgXUIzlgyMEIEXoljdmh3oxqnHionCF+acqFDTJZGvdc7CSRnG/3A7g5qWDvpTkZRkYJoymKSQvitZEgvbtKIMcJbKqArOVDD55Nh7KSA+my0RkYJSlLTSBPP+M2czd59RDV4faybwAzGL5KsKPE8Jw31pWGz3ymXB4rHXzlEyFqhX1mHOCzy+lIymdlP9xubpfr4Fr4phyMqVps7IXWrVpKT9Dui4dQYstHSZwtULk8kGJCmBxJSz1beu0Ef3IbTOOc86ssUZgPyfcCb4jg2Zk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(41320700013)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpDQjlqM1JteHNsbGh2QnJBdWJVYzRnS2JaLzdYNVozNCtUWkgwZ0FveHJU?=
 =?utf-8?B?OFFoTXAxb21JNlhuamRWZFd5cGdMbnRMeW44LzRWZDZWRXZVcXY3b0c1YUhk?=
 =?utf-8?B?RUk3aGRtRmx5R0RBQjJnRHI4UHVuS2RuVEx2N3M1OCtyNCtuL2FUNDhYaTlT?=
 =?utf-8?B?ME42SFg5MklzalZLMzJ3RG9UQUIxTGJTSm9lblpsWUFPY1Blck4zeDVOKzE3?=
 =?utf-8?B?NnhLMlhWU0d4RkhyZElDVlNjZFJpSXVJcWE4bWs5ZHI4TiszYldjTmpnSE8v?=
 =?utf-8?B?MjZlcGRDUlJ2K2UwcnpyaXNFMnF4MjRFWEduaHBkVE1yNi9NbnU1b0NOeGk2?=
 =?utf-8?B?K2R6SW9kRG5ucVA0bm5Fd1NQY3pCZVI4M0plblVySkYxUk5mQzFSWVZ0SFpI?=
 =?utf-8?B?ME50Tm9Ya3I0aThNNGVuQTFXYzM4UUd1NmJZRFdsaWZtbWhleVNNQ3lwY2Rz?=
 =?utf-8?B?Z3FMZ2lhbVdscWUrRk9aRVZNZjRnUUMrNy93eTFnVm9yaW1LNUF0eTdySUVm?=
 =?utf-8?B?K2xUYlZtV2IwN1hDaHJOd3k2UjRiOUZ5R0FmSXkzZWNtdDQxQmUxKzJMY28r?=
 =?utf-8?B?WXJRZnhkSm9PMUdDdVlqUzJJaVArbWxGSGZtU0tjSCtPT1kxbmFtVWdpM1BR?=
 =?utf-8?B?VVhxWnJCL09FMUp3TVMvY0taLzhxOXdaWVV2NjN4eTY2endMRGNJaHZwSnF0?=
 =?utf-8?B?V29EZVRDTFFCMkdZRkNuSmZHREFnT0k3bkNIZndwaHFDWXJkdENzTFhuc21Y?=
 =?utf-8?B?SURaU3gvNDFOcUJCcVdrM01OejNVaG5nRXAvSFp4U3FGZUNXNTJxVEhUdFFM?=
 =?utf-8?B?TWYwbXd2SXN5eVNjUCt2aEVocXMzMmFlVEpJbjBTV3lPM25jNjdYUEJwQyt2?=
 =?utf-8?B?SFROR3dyWkl1SFhGUUZZUU85VGZGWFZDSXl4RVpaYkp0a1JQL051TXZWcmpL?=
 =?utf-8?B?S20weVJUMUZHYmtNeDNqUUlQSE5JdHNIQkFhWlNTNlBVSkpqSk1tbjllYkNB?=
 =?utf-8?B?cXYwTGsyVnpjbHdhY2Y2c3BHQXpuQWJGSnBsMGRLb25MbitMdHhzNTlVc3ZX?=
 =?utf-8?B?T2VlVnJXeXhhRW9LdGVNNGlxcUtFcjVxc211SDR5T3lRMFZkSzdyMWFvdlhv?=
 =?utf-8?B?TjhhOUNuRmI5SlhiTU11QXMvd0lHZTBDeVlrL1E1NnRsSkVhOElRNzlXUjc0?=
 =?utf-8?B?Zzh3bmllZDdQQ3k1N0tmbUF6NmIvOXhPRXV2eTcrREJWN0gxeFI2YW1nRTJx?=
 =?utf-8?B?R2ZGV0d2ejQ4dEYxam5Bc3B2a1EzLzZRVXpFZFF4Y3JTZkdSSjE0WnZaQkdX?=
 =?utf-8?B?NTNuZU9tTUlZL1UralUzWTRoTkhxa0dIREEyTlFDQkJGWk43aE9LRTMzSkls?=
 =?utf-8?B?OXVhUHBqdUY2Q3JoTkVpSElwQ2UwcUxFdVpBS1MyRTdoekNnQTJ3S1dGMzdE?=
 =?utf-8?B?S0F6ZUJ2d0FGUnlRRmxOUGdYM20vZkVvOUhZMi9LUUN1ZHRRL0lhSHdWLzNw?=
 =?utf-8?B?RDZVcXFiT1ZwQTZpcmVwandoNUhNYTZDTXdBU1g5MDdBSG1uTmZ0NXp1UWR2?=
 =?utf-8?B?MlUrcDZsMk5NbnoyYnoyNTA3MnN0SWg5VjZHVjlrTXF2SC9Hb2NVZ28vS1Zi?=
 =?utf-8?B?WU9mMXU2ajdrQ0xUMXVTU1hvR2JIRk5ySDE4MlJHQlVyN3dFSisreklyc2tI?=
 =?utf-8?B?U0srZzdVMUVlbVM1T3FZY2R4MXQ5V0c1d1JTdVFUeUcwOEJXZzZrMU9qc295?=
 =?utf-8?B?OUluWmJlM0svT3ZWdFhqTm5LQ3hTSm5UeG9PaHd5dHd3NG1XZS9RV1N0YWxQ?=
 =?utf-8?B?R3pTRTVpSmlCQXNZOHdYR0hCYUNvdG0ydGhPRStBZld6TWNVZ3pha21tVDY0?=
 =?utf-8?B?KzVvaktPRmxRUkxHR2VzSTNyMmJVejZIaWRCRE51U1NxUUo5NW50SXZjbHlz?=
 =?utf-8?B?eVE3ZkxSS2VzbURyeUFuRmc0QjZjdWFIRjAxdkRhaUMzZ0E2eXlSWTV5WlBV?=
 =?utf-8?B?RjNNWVZpODdEZVI3OXowQ0N0Nkw0N2xXcittZnh3UlZpRGJpTWtoM3hDbHRm?=
 =?utf-8?B?L0NualdHdE5VTjBuallGZ0NhTWtQY3VVZXpsekdLaElXZnlnekJRN1l0UktM?=
 =?utf-8?Q?fEylPhm/O0vSk30kdD5UeupDq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5019b-6882-4cf0-a8b8-08de114730f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 08:44:19.4458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXCSlyyQhAMwuKLBRMEOmU/342FC5C9El3fSdcKCTGRElJjKocezTNyB5BLi5s1tsM74djuaocJ1C0J9DKjGTGlQpBRfA77d+dDFt5UZfbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
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

PiBPbiAyMi4xMC4yNSAxMTowMywgSGFsIEZlbmcgd3JvdGU6DQo+ID4gT24gMDMuMDkuMjUgMDY6
MzIsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+ID4gT24gOS8zLzI1IDAwOjEyLCBFIFNo
YXR0b3cgd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gOS8yLzI1IDAwOjQ0LCBIYWwgRmVuZyB3cm90
ZToNCj4gPiA+Pj4gT24gMjkuMDguMjUgMTU6NDQsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6
DQo+ID4gPj4+IE9uIDI5LjA4LjI1IDA4OjA5LCBIYWwgRmVuZyB3cm90ZToNCj4gPiA+Pj4+IHBj
Yl9yZXZpc2lvbiBpcyBzdG9yZWQgaW4gdGhlIHBjYl9yZXZpc2lvbiBmaWVsZCBvZiBBVE9NNC4g
Q29ycmVjdCBpdC4NCj4gPiA+Pj4+IE1vdmUgdGhlIGZ1bmN0aW9uIGRlc2NyaXB0aW9uIHRvIHRo
ZSBoZWFkZXIgZmlsZS4NCj4gPiA+Pj4+IFJlbW92ZSB0aGUgZnVuY3Rpb24gY2FsbHMgaW4gYm9h
cmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEZpeGVzOiBhZWEx
YmQ5NWI2MWUgKCJlZXByb206IHN0YXJmaXZlOiBFbmFibGUgSUQgRUVQUk9NDQo+ID4gPj4+PiBj
b25maWd1cmF0aW9uIikNCj4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxoYWwuZmVu
Z0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4+Pj4gLS0tDQo+ID4gPj4+PiAgICBhcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL2FyY2gtamg3MTEwL2VlcHJvbS5oICAgfCAgNSArKysrKw0KPiA+ID4+Pj4g
ICAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMgICAgICAgICAgICAgIHwgMTggKysr
KysrLS0tLS0tLS0tLS0NCj4gPiA+Pj4+ICAgIC4uLi92aXNpb25maXZlMi9zdGFyZml2ZV92aXNp
b25maXZlMi5jICAgICAgICB8IDIwICsrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiA+Pj4+ICAgIC4u
Li92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMgICAgICB8IDExICsrLS0tLS0t
LS0NCj4gPiA+Pj4+ICAgIDQgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMzUgZGVs
ZXRpb25zKC0pDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vYXJjaC1qaDcxMTAvZWVwcm9tLmgNCj4gPiA+Pj4gYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2FyY2gtamg3MTEwL2VlcHJvbS5oDQo+ID4gPj4+PiBpbmRleCA2ZDBhMGJhMGM0YS4u
MDI1ZjFkMzJjNDkgMTAwNjQ0DQo+ID4gPj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2FyY2gtamg3MTEwL2VlcHJvbS5oDQo+ID4gPj4+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL2FyY2gtamg3MTEwL2VlcHJvbS5oDQo+ID4gPj4+PiBAQCAtOSw2ICs5LDExIEBADQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gPj4+Pg0KPiA+
ID4+Pj4gKy8qKg0KPiA+ID4+Pj4gKyAqIGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20oKSAt
IGdldCB0aGUgUENCIHJldmlzaW9uDQo+ID4gPj4+PiArICoNCj4gPiA+Pj4+ICsgKiBAcmV0dXJu
OiB0aGUgUENCIHJldmlzaW9uIG9yIDB4RkYgb24gZXJyb3IuDQo+ID4gPj4+PiArICovDQo+ID4g
Pg0KPiA+ID4gTm8uIEludmVydGVkIGxvZ2ljLiBTZWUgYmVsb3cgY29tbWVudCBhYm91dCBib2R5
IG9mIGZ1bmN0aW9uLg0KPiA+ID4NCj4gPiA+Pj4+ICAgIHU4IGdldF9wY2JfcmV2aXNpb25fZnJv
bV9lZXByb20odm9pZCk7DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gICAgLyoqDQo+ID4gPj4+PiBkaWZm
IC0tZ2l0IGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMNCj4gPiA+Pj4gYi9ib2Fy
ZC9zdGFyZml2ZS92aXNpb25maXZlMi9zcGwuYw0KPiA+ID4+Pj4gaW5kZXggM2RmYTkzMWI2NTUu
LjkwMWU3YjU4ZjM2IDEwMDY0NA0KPiA+ID4+Pj4gLS0tIGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9u
Zml2ZTIvc3BsLmMNCj4gPiA+Pj4+ICsrKyBiL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3Nw
bC5jDQo+ID4gPj4+PiBAQCAtMTI2LDE5ICsxMjYsMTMgQEAgaW50IGJvYXJkX2ZpdF9jb25maWdf
bmFtZV9tYXRjaChjb25zdCBjaGFyDQo+ID4gPj4+ICpuYW1lKQ0KPiA+ID4+Pj4gICAgCQkgICAg
IXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwNCj4gIlNUQVI2NCIsIDYpKSB7
DQo+ID4gPj4+PiAgICAJCXJldHVybiAwOw0KPiA+ID4+Pj4gICAgCX0gZWxzZSBpZiAoIXN0cmNt
cChuYW1lLA0KPiA+ID4+Pj4gInN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIt
djEuMmEiKQ0KPiA+ID4+PiAmJg0KPiA+ID4+Pj4gLQkJICAgICFzdHJuY21wKGdldF9wcm9kdWN0
X2lkX2Zyb21fZWVwcm9tKCksDQo+ICJWRjcxMTAiLCA2KSkgew0KPiA+ID4+Pj4gLQkJc3dpdGNo
IChnZXRfcGNiX3JldmlzaW9uX2Zyb21fZWVwcm9tKCkpIHsNCj4gPiA+Pj4+IC0JCWNhc2UgJ2En
Og0KPiA+ID4+Pj4gLQkJY2FzZSAnQSc6DQo+ID4gPj4+PiAtCQkJcmV0dXJuIDA7DQo+ID4gPj4+
PiAtCQl9DQo+ID4gPj4+PiArCQkgICAoIXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXBy
b20oKSwNCj4gIlZGNzExMEEiLCA3KQ0KPiA+ID4+PiB8fA0KPiA+ID4+Pj4gKwkJICAgICFzdHJu
Y21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksDQo+ICJWRjcxMTBhIiwgNykpKQ0KPiA+
ID4+PiB7DQo+ID4gPj4+PiArCQlyZXR1cm4gMDsNCj4gPiA+Pj4+ICAgIAl9IGVsc2UgaWYgKCFz
dHJjbXAobmFtZSwNCj4gPiA+Pj4+ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2
ZS0yLXYxLjNiIikNCj4gPiA+Pj4gJiYNCj4gPiA+Pj4+IC0JCSAgICAhc3RybmNtcChnZXRfcHJv
ZHVjdF9pZF9mcm9tX2VlcHJvbSgpLA0KPiAiVkY3MTEwIiwgNikpIHsNCj4gPiA+Pj4+IC0JCXN3
aXRjaCAoZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2VlcHJvbSgpKSB7DQo+ID4gPj4+PiAtCQljYXNl
ICdiJzoNCj4gPiA+Pj4+IC0JCWNhc2UgJ0InOg0KPiA+ID4+Pj4gLQkJCXJldHVybiAwOw0KPiA+
ID4+Pj4gLQkJfQ0KPiA+ID4+Pj4gKwkJICAgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21f
ZWVwcm9tKCksDQo+ICJWRjcxMTBCIiwgNykNCj4gPiA+Pj4gfHwNCj4gPiA+Pj4+ICsJCSAgICAh
c3RybmNtcChnZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgpLA0KPiAiVkY3MTEwYiIsIDcpKSkN
Cj4gPiA+Pj4gew0KPiA+ID4+Pj4gKwkJcmV0dXJuIDA7DQo+ID4gPj4+PiAgICAJfQ0KPiA+ID4+
Pj4NCj4gPiA+Pj4+ICAgIAlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+DQo+ID4gPiBJIGFncmVlIGl0
IGlzIGdvb2QgdG8gZGVsZXRlIHRoZSBjYXNlIHN0YXRlbWVudCBhbmQgZHJvcCBsb3dlcmNhc2UN
Cj4gPiA+IGNvbXBhcmUgYXMgc3VnZ2VzdGVkLCBhbHNvLi4uDQo+ID4gPg0KPiA+ID4+Pj4gZGlm
ZiAtLWdpdCBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUy
LmMNCj4gPiA+Pj4gYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zdGFyZml2ZV92aXNpb25m
aXZlMi5jDQo+ID4gPj4+PiBpbmRleCBiZmJiMTFhMmVlNy4uZjM4NDMzZTk0YWMgMTAwNjQ0DQo+
ID4gPj4+PiAtLS0gYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zdGFyZml2ZV92aXNpb25m
aXZlMi5jDQo+ID4gPj4+PiArKysgYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zdGFyZml2
ZV92aXNpb25maXZlMi5jDQo+ID4gPj4+PiBAQCAtNTksMjAgKzU5LDEyIEBAIHN0YXRpYyB2b2lk
IHNldF9mZHRmaWxlKHZvaWQpDQo+ID4gPj4+PiAgICAJCWZkdGZpbGUgPSAic3RhcmZpdmUvamg3
MTEwLW1pbGt2LW1hcnMuZHRiIjsNCj4gPiA+Pj4+ICAgIAl9IGVsc2UgaWYgKCFzdHJuY21wKGdl
dF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJTVEFSNjQiLA0KPiA2KSkgew0KPiA+ID4+Pj4g
ICAgCQlmZHRmaWxlID0gInN0YXJmaXZlL2poNzExMC1waW5lNjQtc3RhcjY0LmR0YiI7DQo+ID4g
Pj4+PiAtCX0gZWxzZSBpZiAoIXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwg
IlZGNzExMCIsDQo+IDYpKSB7DQo+ID4gPj4+PiAtCQlzd2l0Y2ggKGdldF9wY2JfcmV2aXNpb25f
ZnJvbV9lZXByb20oKSkgew0KPiA+ID4+Pj4gLQkJY2FzZSAnYSc6DQo+ID4gPj4+PiAtCQljYXNl
ICdBJzoNCj4gPiA+Pj4+IC0JCQlmZHRmaWxlID0gInN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12
aXNpb25maXZlLTItDQo+ID4gPj4+IHYxLjJhLmR0YiI7DQo+ID4gPj4+PiAtCQkJYnJlYWs7DQo+
ID4gPj4+PiAtCQljYXNlICdiJzoNCj4gPiA+Pj4+IC0JCWNhc2UgJ0InOg0KPiA+ID4+Pj4gLQkJ
CWZkdGZpbGUgPSAic3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi0NCj4gPiA+
Pj4gdjEuM2IuZHRiIjsNCj4gPiA+Pj4+IC0JCQlicmVhazsNCj4gPiA+Pj4+IC0JCWRlZmF1bHQ6
DQo+ID4gPj4+PiAtCQkJbG9nX2VycigiVW5rbm93biByZXZpc2lvblxuIik7DQo+ID4gPj4+PiAt
CQkJcmV0dXJuOw0KPiA+ID4+Pj4gLQkJfQ0KPiA+ID4+Pj4gKwl9IGVsc2UgaWYgKCFzdHJuY21w
KGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTBBIiwNCj4gNykgfHwNCj4gPiA+
Pj4+ICsJCSAgICFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksDQo+ICJWRjcx
MTBhIiwgNykpIHsNCj4gPiA+Pj4NCj4gPiA+Pj4gV2hlcmUgYm9hcmRzIGJvdGggd2l0aCAnYScg
YW5kICdiJyBldmVyIHNoaXBwZWQ/DQo+ID4gPj4+IEkgaGF2ZSBvbmx5IHNlZW4gJ0EnIGFuZCAn
QicgaW4gcGJ1Zi5lZXByb20uYXRvbTEuZGF0YS5wc3RyWzZdLg0KPiA+ID4+DQo+ID4gPj4gWW91
J3JlIHJpZ2h0LiBUaGVyZSBhcmUgbm8gYm9hcmRzIG1hcmtlZCAiVkY3MTEwYSIgb3IgIlZGNzEx
MGIiLg0KPiA+ID4+IExldCdzIHJlbW92ZSB0aGUgY29tcGFyaXNvbiBvZiAiVkY3MTEwYSIgYW5k
ICJWRjcxMTBiIi4NCj4gPiA+Pg0KPiA+ID4+IEJlc3QgcmVnYXJkcywNCj4gPiA+PiBIYWwNCj4g
PiA+DQo+ID4gPiAuLi4gYWdhaW4gaGVyZSB0b28gZGVsZXRlIHRoZSBjYXNlIHN0YXRlbWVudCBh
bmQgZHJvcCBsb3dlcmNhc2UgY29tcGFyZS4NCj4gPiA+IFRoYW5rcy4NCj4gPiA+DQo+ID4gPj4N
Cj4gPiA+Pj4NCj4gPiA+Pj4gVGhlIGNoYW5nZSBsb29rcyB0ZWNobmljYWxseSBjb3JyZWN0Lg0K
PiA+ID4+Pg0KPiA+ID4+PiBSZXZpZXdlZC1ieTogSGVpbnJpY2ggU2NodWNoYXJkdA0KPiA+ID4+
PiA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0KPiA+ID4+Pg0KPiA+ID4+Pj4g
KwkJZmR0ZmlsZSA9ICJzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLQ0KPiB2
MS4yYS5kdGIiOw0KPiA+ID4+Pj4gKwl9IGVsc2UgaWYgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lk
X2Zyb21fZWVwcm9tKCksICJWRjcxMTBCIiwNCj4gNykgfHwNCj4gPiA+Pj4+ICsJCSAgICFzdHJu
Y21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksDQo+ICJWRjcxMTBiIiwgNykpIHsNCj4g
PiA+Pj4+ICsJCWZkdGZpbGUgPSAic3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi0NCj4gdjEuM2IuZHRiIjsNCj4gPiA+Pj4+ICAgIAl9IGVsc2Ugew0KPiA+ID4+Pj4gICAgCQls
b2dfZXJyKCJVbmtub3duIHByb2R1Y3RcbiIpOw0KPiA+ID4+Pj4gICAgCQlyZXR1cm47DQo+ID4g
Pg0KPiA+ID4+Pj4gZGlmZiAtLWdpdCBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3Zpc2lv
bmZpdmUyLWkyYy1lZXByb20uYw0KPiA+ID4+PiBiL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUy
L3Zpc2lvbmZpdmUyLWkyYy1lZXByb20uYw0KPiA+ID4+Pj4gaW5kZXggMzg2NmQwN2Y5ZDQuLjQz
YjhhZjRmYzU5IDEwMDY0NA0KPiA+ID4+Pj4gLS0tIGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2
ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4gPj4+PiArKysgYi9ib2FyZC9zdGFyZml2
ZS92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMNCj4gPiA+Pj4+IEBAIC01MzUs
MTkgKzUzNSwxMiBAQCBpbnQgbWFjX3JlYWRfZnJvbV9lZXByb20odm9pZCkNCj4gPiA+Pj4+ICAg
IAlyZXR1cm4gMDsNCj4gPiA+Pj4+ICAgIH0NCj4gPiA+Pj4+DQo+ID4gPj4+PiAtLyoqDQo+ID4g
Pj4+PiAtICogZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2VlcHJvbSAtIGdldCB0aGUgUENCIHJldmlz
aW9uDQo+ID4gPj4+PiAtICoNCj4gPiA+Pj4+IC0gKiAxLjJBIHJldHVybiAnQScvJ2EnLCAxLjNC
IHJldHVybiAnQicvJ2InLG90aGVyIHZhbHVlcyBhcmUNCj4gPiA+Pj4+IGlsbGVnYWwNCj4gPiA+
Pj4+IC0gKi8NCj4gPiA+Pj4+ICAgIHU4IGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20odm9p
ZCkNCj4gPiA+Pj4+ICAgIHsNCj4gPiA+Pj4+IC0JdTggcHYgPSAweEZGOw0KPiA+ID4+Pj4gLQ0K
PiA+ID4+Pj4gICAgCWlmIChyZWFkX2VlcHJvbSgpKQ0KPiA+ID4+Pj4gLQkJcmV0dXJuIHB2Ow0K
PiA+ID4+Pj4gKwkJcmV0dXJuIDB4RkY7DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gLQlyZXR1cm4gcGJ1
Zi5lZXByb20uYXRvbTEuZGF0YS5wc3RyWzZdOw0KPiA+ID4+Pj4gKwlyZXR1cm4gcGJ1Zi5lZXBy
b20uYXRvbTQuZGF0YS5wY2JfcmV2aXNpb247DQo+ID4gPj4+PiAgICB9DQo+ID4gPj4+Pg0KPiA+
ID4+Pj4gICAgdTggZ2V0X2Rkcl9zaXplX2Zyb21fZWVwcm9tKHZvaWQpDQo+ID4gPj4NCj4gPiA+
DQo+ID4gPiBOby4gSSBkbyBub3Qgd2FudCB0byBoYXZlIHRvIGd1ZXNzIHdoYXQgZXJyb3IgZG9l
cyAiMHhGRiIgaGF2ZSB0aGUNCj4gPiA+IG1lYW5pbmcgb2YsIGl0IG1ha2VzIHRoZSBjb2RlIGFu
bm95aW5nIHRvIHJlYWQgZXZlcnkgZnVuY3Rpb24gaGVhZGVyDQo+ID4gPiBkb2N1bWVudGF0aW9u
IHRvIGxlYXJuIHRoaXMgaW5mb3JtYXRpb24uDQo+ID4gPg0KPiA+ID4gU2luY2Ugd2UgcmVtb3Zl
IGFsbCB1c2VycyBvZiBtYWNfcmVhZF9mcm9tX2VlcHJvbSgpIGl0IGlzIGNlcnRhaW5seQ0KPiA+
ID4gbm90IGEgcHJvYmxlbSB3ZSBjYXJlIGFib3V0IG5vdyBhbnltb3JlLiBEZWZhdWx0IFBDQiBy
ZXZpc2lvbiBpbg0KPiA+ID4gY2FzZSBvZiBlcnJvciBtYXkgYmUgemVyby4gSXQgaXMgbm90IGlt
cG9ydGFudCB0byBtYWtlIGRpc3RpbmN0aW9uDQo+ID4gPiBvZiBhZGRpdGlvbmFsIGZhaWx1cmUg
ZGV0ZWN0aW9uLCB0aGlzIGlzIGFscmVhZHkgcmVzb2x2ZWQgYnkNCj4gPiA+IHJlYWRfZWVwcm9t
KCkgd2hlcmUgYW55IGVycm9yIG1lc3NhZ2UgbWF5IGJlIHByZXNlbnRlZCB0byB0aGUgdXNlci4N
Cj4gPiA+DQo+ID4gPiBJIGFwcHJlY2lhdGUgdGhlIGVmZm9ydCB0byBiZSBtb3JlIHRlY2huaWNh
bGx5IGNvcnJlY3QgYW5kIGhhdmUgYQ0KPiA+ID4gdW5pcXVlIGVycm9yIHZhbHVlIGJ1dCB3aXRo
IHU4IHJldHVybiB2YWx1ZSAweEZGIGl0IGlzIGFuIGFkZGl0aW9uYWwNCj4gPiA+IGxheWVyIG9m
IGNvbXBsaWNhdGlvbiBub3QgbmVlZGVkLiBJZiB5b3UgaW5zaXN0IG9uIHRoaXMgYXBwcm9hY2gN
Cj4gPiA+IHRoZW4gdGhlIHJldHVybiB2YWx1ZSBzaG91bGQgYmUgYXJiaXRyYXJpbHkgZGVmaW5l
ZCBhcyBhIGNvbXBpbGVyDQo+ID4gPiBtYWNybywgc2F5IENNRF9FRVBST01fRkFJTCAoMjU1KSBh
bmQgY29uc2lzdGVudGx5IHVzZWQuIEluIGZhY3QgSQ0KPiA+ID4gd291bGQgbm90IGNvbXBsYWlu
IGlmIGl0IGltcHJvdmVkIGNvZGUgcmVhZGFiaWxpdHkuDQo+ID4NCj4gPiBUaGVyZSBpcyBubyBu
ZWNlc3NpdHkgdG8gdXNlIHU4IGFzIHRoZSByZXR1cm4gdmFsdWUuIFdlIGNvdWxkIGFsc28gdXNl
DQo+ID4gaW50IGFuZCByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBjb2RlICgtRUlPKSBvbiBmYWls
dXJlLg0KPiANCj4gWWVhaCwgd2lsbCByZXR1cm4gYSBuZWdhdGl2ZSBlcnJvciBjb2RlICgtRUlP
KSBvbiBmYWlsdXJlLg0KPiBJIHRoaW5rIHRoZSByZWFzb24gd2h5IHdlIHNldCB0aGUgcmV0dXJu
IHZhbHVlIHRvIDB4RkYgb24gZmFpbHVyZSB3YXMgdGhhdCAweEZGDQo+IGlzIHRoZSBkZWZhdWx0
IHZhbHVlIGFmdGVyIEVFUFJPTSBpcyBlcmFzZWQuDQoNCkZpeCB0aGUgbGFzdCBsaW5lIG9mIGNv
bW1lbnRzLiAweEZGIG1heSBiZSB0aGUgZGVmYXVsdCB2YWx1ZSBhZnRlciBERFIgaXMgaW5pdGVk
LA0KYnV0IEkgYW0gbm90IHN1cmUgYWJvdXQgaXQuDQoNCkJlc3QgcmVnYXJkcywNCkhhbA0K
