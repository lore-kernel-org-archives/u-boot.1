Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01BC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8650C8206E;
	Tue,  1 Apr 2025 12:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B753681F0D; Tue,  1 Apr 2025 12:39:34 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E65801FB
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7bjwDlc9J/8W4GSCfb1kZNzWRlLkMih03oWT+xoT3BiPoGu0UODlrKpXc7Kn7KgLz0NEgPksXT4QQc1tTVyKwc0In3kY0aXyXOYRx3YDAWQJiofdPxt3uCfcZYvAZS8qPt7AVUzxOeUjePYpyE3MGSIT+sb0tbvRJIapXZ0MJ6CPDuS2EZQZ7YFqGAywOhfy0stnGJRoi1dLlMEh6/c77R3j3w8JPc4k1wbJmHAYP8cNdIg/2xmrgdQDg0uzdrR89iqWOeNGGA2Bzu7XV6a2FhPV66EoDf9kHc9DBf/2ynBqJ9qTvyK9XPd/z4hjZzyPbL1QBOR31ZmHizjqHgqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRz8pktzA6B0d/zX+Cq4D0j9R0BgVElOE5FIn14K178=;
 b=DDfYC+EleHRT2kK0KadBWIXYixYn0HEdVwR5sX2WNwySblLtVk16yPmKr4Vn7QD5CWR2qI+p9iv9YLIy/dJgcnWAN1PkWAws8epJFoEEWN9HFmIkSRKPr8eijMFTlZm583pE6LGPeelRGCtSoAVSPmlY5TphNObZ30I1wAoF2XhV7BQWkFfC0TnTKlzQImlkLPfrH5W+h+KQSBGaye89CqgywVt3hScFCQd/PxIOuaxQLZV24q6qqc9bu2/zjGEHmBbQhgeP9ulkNtasGEswvM1rLMpOYOcSwzHswFoTbWtYA9yth3KsdZwWJ0XgVwGMB8AEoQZC1r0Xzc86YxoYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0454.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 10:39:24 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9]) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9%3]) with mapi id 15.20.8398.013; Tue, 1 Apr 2025
 10:39:24 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Hal Feng
 <hal.feng@starfivetech.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
Thread-Topic: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
Thread-Index: AQHblzDVWITfvcCCqUSlqwA8m6SyhrN3RmQAgADOGGCABOfOgIARuf7Q
Date: Tue, 1 Apr 2025 10:39:24 +0000
Message-ID: <BJXPR01MB085540910B06F9EF9C484C0AE6AC2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20250317113627.84885-1-minda.chen@starfivetech.com>
 <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
 <SHXPR01MB086382C94AD9C7988302D1B0E6DE2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <1fb4a575-b9c5-4c20-9479-d0bffc6e6945@denx.de>
In-Reply-To: <1fb4a575-b9c5-4c20-9479-d0bffc6e6945@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0454:EE_
x-ms-office365-filtering-correlation-id: 6eb99685-6a48-4fd6-7d27-08dd7109786d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700018; 
x-microsoft-antispam-message-info: ZKRcWWMz/nK7SgAGIQ4RCcx4jwDxhKM1jXiuBu9e8E3+CDVtbvgcnBw9LaxWnkRPHJq3Jkz5DYMNqT8Nd8Ki1mEpqHcJcz6Rjnzkgk6uoCEddTBCQkPBbL3WcStvvW1SCWXdkKY19V4gADQbwxIgUPW/SZ60GbIWmdeyLzSEYBTTK5IcY5mDaVLn3p82bE3IwryWq0Rj82kJTqBQ12/6cRmUUOLZpPUBuu3iTrL6/+VAqw40mzGmZIb5Qp37EF1F4p2ivwA+WoTP68yfiCRPPntvIUnaB3Sxzo+jR+Ur2oiKbXAX5Vp4t7WoDQzypxDNZLaNiiPBIvrF1MwkyYWkdtbpmLffzLK+BDF7lsBJC3qEycDHcrYVwYCqMchO9g6SUSrg+BY1N4ynKVpV9Af8jy86OE9K5Nc+GvMhs3mc0D4+hiIXKuUuqfVRyYYH0Fvm/owCnucF2yGzBbraWSK+IOPr4KmhA6AItj2VqAewggkuxOGrnoAPlC0BPPQtNkopIE/F/an60jhLGA8BUHWsDZ/ucsWYSciZTKzcfUYaJo8kqbdpZcxwz0TzhFa9NFzU2mkJhOy+FJAx8LsZh5xDjeDhrAtiUEge2t/KQpS10Tk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWFJMDRYZldCaThWMElQSHl4blNTblFOcFUwRXdMcDJaR1VsanhwNEJnbWpt?=
 =?utf-8?B?QTlJbHJKVHdQelJ2ZzlscGRaVjFIWEltb2hJZVJMZGhtR3BQaGJrTzkwRlVo?=
 =?utf-8?B?cDhTZGUzOE96dGIrNUsrVWplenhUQ3FZRk9YbENGWDNqdTcxWEVxeVFNUS9Y?=
 =?utf-8?B?b090WWwwZW13ZW5DcGQ4RU93K2JjbVQ3YW02cjBXMjFIRHlGVTFKeXJtaWxV?=
 =?utf-8?B?NU1NN2RRTERzT2JYWml6bUNMZmNhLzhjY2xuWXZYc0RwYW5kUFc5YnltV2l0?=
 =?utf-8?B?SzNCMmVBK2duOGNPU1luSUw3cWRkUlgzby9JOU9yVmRmSkFxWElualh5NW1L?=
 =?utf-8?B?aGhTdDFVTlhKZ0R3V2VDK0FsOTZpYTlpVDNrMk5hblBDUEFIajhMclYwbzRM?=
 =?utf-8?B?WFBXazVRMTYzK1NPU1R2VENodHA1TTJNN2d3M3dEUmRyT3hCVEJjUXRnRXp1?=
 =?utf-8?B?bUJFSld5V2pwWEV6SlBhYzhUcEhCK1N2MWoyOC92R0wrelpIUTIyQmFnUi9S?=
 =?utf-8?B?RlFxamxNWm5laXB0N1dLaityVnR4R1VqelNTSmc0MHVNMjhyRzdjTHljSkVk?=
 =?utf-8?B?d0h4ajJDSk5Nb1dXTmtXeWVWU2lNbzlGeFdLMlVRckhMK3gxZVRqcHNYcG04?=
 =?utf-8?B?YlZDb0NYeXdEWi81Vm5nQVA5T0M3MDJWVk05Z2VESU10TXRHaFliTXZwTFFX?=
 =?utf-8?B?N2kydjdkNStoSHVEU0pMK01NMlppcm5lY3BQUnlBZ01wcTc0dGR2aTJwN0tT?=
 =?utf-8?B?SU1IdjhqbzdxNENsdTZFdGhxT2xVYVRjenFtTm9uMU1IQjI3N2Vxb2VuMnFu?=
 =?utf-8?B?MUU1bU0zYms3Z0E5amhaTHZKamw0dkV4M0tlUmR2OWFEK29uMG9ZZStCQUhk?=
 =?utf-8?B?TjFUTEJsY2tVejJmODFZZ1E5S25qWWUzVVFxanVCWUNxQmtCT0czMkRFTGpi?=
 =?utf-8?B?bE9FWS96WC84b0xXU0VIeU9DZjFSRGpHQTEzazd2STRDd2VJQ3BWbjB6RThW?=
 =?utf-8?B?M0pyNHBJbWpxWUxReDV5dkdmQm00NG5SN203NWxsa0xPc3FxZHVXYVhnYkxj?=
 =?utf-8?B?MU1CYmVzeTgrTXd2TUtCclFFS3ZYWW9GNE53b1VzYTlsZmw5QmxXbDFaSzlk?=
 =?utf-8?B?WTZEdndKMWRHVHl6TFhOU2UyQ0ZiditLbjhsQTc2eHVhblR4WGkzTDNHdTZL?=
 =?utf-8?B?RVlVdERuK0NCZHkxZUJaOXIwbTZCeWJMZy9XQnVIU1dpMk9IQ05JT3BsMWRK?=
 =?utf-8?B?SXNyRTRWSnhDaWhSL2VRbEhPaVcyaHhqRzZhUWdQQU13Q2pDR3J4MWtDUDBw?=
 =?utf-8?B?bDNqYlRDNUViZDVsNnBCZEk1cWxNZ0xGM3pDcndGZG5aQ1Z1RVhkZHJzMnVN?=
 =?utf-8?B?SE5hS2swdkdLd2Z3N3plZk9vVzJ3Vm1FWWJOazlWZVh4N1gwM2dqSG00c2Fr?=
 =?utf-8?B?STVTaUZZd2lJOW95Z0FWQXlBS3MwRUE2YTNJem1NSmZiekR4MEUvSEUvTE40?=
 =?utf-8?B?WEhnT0F0Y0NLclAvWkx6c012NkE2eGFyZGUxOE81b05NZ1ZweVJaVDhjVVd6?=
 =?utf-8?B?cE9zZDhmaXdjd05UYWd5a0FDWWZsdDlJSGdmcDIvcGZtYlRja2d0WmlPVzM3?=
 =?utf-8?B?Sm1GWmpTbjUyRUhvMmp3UFBUSmlVSE9keFh3QmdyK3dlMnBQT1NnRHZ0Z215?=
 =?utf-8?B?RWdIc2daaFlMcFJ3enFUREx1K2N6Q2pCOEs4SWppbGdiT3V0TmdvdUs2QTNq?=
 =?utf-8?B?L3VqV1RRbHErSUM3bWV1bWo4MFo4QkRmU09Ga053RW1ieW5zZTlPbG1xYlZm?=
 =?utf-8?B?eFpKbG43ZHAxZTdMVDBWR210ZUdwTEt5WlJuYVB0cWlrZTlkMVFTclpBaWls?=
 =?utf-8?B?Z3ovWGgxNDMwT1VSWVFuWGRnR0ZhY1ZnOGJDNDY1Zjd4S3ZCVmZaR1JSV1Yx?=
 =?utf-8?B?UjVOYmxURlI4UjVwTkYzZ216UHJOWmlZNVFJNDRsQ1ppdTdoY3h3UGJwbVVa?=
 =?utf-8?B?YkY0bFZJZW5XbExid0dldFdtdlNnZldnZDE3RDVZdFN0RTBaYjVmMHJieStQ?=
 =?utf-8?B?NDNLc0VMRlA4OXBncFZQL0pwcEV3MzdyckNya0IxK21CMjl5MDVwUTdqOUtP?=
 =?utf-8?B?a0FRby9lTENTL2xxYXZXdVdSZSsxNTA4RXJ6eDk2aGR5dE12cDJhaVVxTTI0?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb99685-6a48-4fd6-7d27-08dd7109786d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 10:39:24.5318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cykmi+u0T87qkW+yfXuO4MyAtKxM81GQ9IUfxDHDB2hiLkvowsqdmnkbWfcw4g6AGAIVCIpN3nmZsClzGChonJthnRM+3pUDbnJinCwFjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0454
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

DQoNCj4gDQo+IE9uIDMvMTgvMjUgMjowMiBBTSwgTWluZGEgQ2hlbiB3cm90ZToNCj4gPg0KPiA+
DQo+ID4+DQo+ID4+IE9uIDMvMTcvMjUgMTI6MzYgUE0sIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4+
PiBBZGQgVVNCIHJlbGF0ZWQgZmlsZSB0byBTdGFyZml2ZSB2aXNpb25maXZlMiBNQUlOVEFJTkVS
Uy4NCj4gPj4+IFRoZSBOOiBwYXR0ZXJuIGNhbiBvdmVycmlkZSB0aGlzLg0KPiA+Pj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IE1pbmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4N
Cj4gPj4+IC0tLQ0KPiA+Pj4gICAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5F
UlMgfCAxICsNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVS
Uw0KPiA+Pj4gYi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUw0KPiA+Pj4g
aW5kZXggODk4ZTI4NGNlMmMuLmYxZDJkZWI5ZjVjIDEwMDY0NA0KPiA+Pj4gLS0tIGEvYm9hcmQv
c3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMNCj4gPj4+ICsrKyBiL2JvYXJkL3N0YXJm
aXZlL3Zpc2lvbmZpdmUyL01BSU5UQUlORVJTDQo+ID4+PiBAQCAtMyw1ICszLDYgQEAgTToJTWlu
ZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+Pj4gICAgTToJSGFsIEZl
bmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4+PiAgICBTOglNYWludGFpbmVkDQo+
ID4+PiAgICBGOglkcml2ZXJzL3JhbS9zdGFyZml2ZS8NCj4gPj4+ICtGOglkcml2ZXJzL3VzYi9j
ZG5zMy9jZG5zMy1zdGFyZml2ZS5jDQo+ID4+DQo+ID4+IFdoYXQgYWJvdXQgdXNpbmcgJ046IHN0
YXJmaXZlJyBpbnN0ZWFkIHRvIG1hdGNoIG9uIGFsbCBmaWxlcyB3aGljaA0KPiA+PiBpbmNsdWRl
IHRoZSBzdHJpbmcgJ3N0YXJmaXZlJyA/DQo+ID4+DQo+ID4gTWF5YmUgb3RoZXIgSUMgY29kZSB3
aWxsIGJlIHVwc3RyZWFtZWQuIEl0IGlzIG5vdCBtZSB0byBtYWludGFpbg0KPiBPSywgaW4gdGhh
dCBjYXNlIHBsZWFzZSBwdXQgdGhpcyBVU0IgY29udHJvbGxlciBtYWludGFpbmVyIGxpbmUgaW50
byB0aGUgdG9wIGxldmVsDQo+IE1BSU5UQUlORVJTIGZpbGUsIHNpbmNlIHRoaXMgaXMgYSBnZW5l
cmljIGRyaXZlciwgbm90IGEgYm9hcmQtc3BlY2lmaWMgb25lLg0KDQpJIHRoaW5rIGl0IGlzIGlj
LXNwZWNpZmljIGZpbGUuIEl0IGlzIGp1c3QgYWJvdXQgcGxhdGZvcm0gc2V0dGluZy4gSXQgaXMg
bm90IHByb3BlciB0byB0aGUgdG9wLg0KTWF5YmUgSSBzZXQgaXQgTjogc3RhcmZpdmUuIE5vdyBq
dXN0IG9uZSBib2FyZCBzZXR0aW5nIC4gIA0K
