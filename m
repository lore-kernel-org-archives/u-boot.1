Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F8C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369E4801DE;
	Fri,  7 Feb 2025 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE2A806FB; Fri,  7 Feb 2025 02:55:29 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F2A801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 02:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgI4DtUOdQW2xHvNrH9aTx8cPw2uoiCsLxR20izWoY/gXTINTTlilqvDdDquTPt/ZBxwXd/aGZEEXt9OdB+4de/3t9yoF2yp2ZWSHW5Iz+/PIBfJTd3bPgUkbgjKyqsljSy32ZYijJXTQOCxKexU0G0MMGkupNZ0jFtfzK4irP0OLaIb/Ywu/TgXOL5SdlB6Vifk2XxUR5iiqMh4ETMWtW3gqsEM4kUShucVOZb7qcmDKnwxP3CDBTQSyZPZn3djnvvDg17F+nlwwVQ+Nndo5fG3KMyuOOjggvm37IGU8mGeC/IPgQzguhuYu4CkRF02U0hMOlxm3LLO35Ugn1TKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHGxrJIe/51dDjR6JzbdRSLbWnJMbqG+X49I7TrDUfQ=;
 b=Crl0eSQrr+HPOevZyMFwgduCao0jvRRZevhBAv6KJNa82ZVXf+r2cTpbY+nRiKgle/19clEW0M/dtlFz/jyuCHoNPGvOcR0+aQpE7Xl09kd7miscGdi/QU+kJCvbLQl+tNEkHxKNpdcw9/txauLr0DbMYoa5B4MGA5byfTe+7hI5lcByEmRCoJZfgV7Vx70yulmExidVeS/0p+7Zwz19jEvIx7tifhfV6DlhDPkotwvIvPQyMad9D/vNCO1ovtTxmhmb/waJHFQ4j0MKibYxXdBQdIkb2FtG8lX512PrZp1pdddN4Xc7LZtem6JnFUzV7FKnQtgI+UAco+H4OukMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Fri, 7 Feb
 2025 01:55:17 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Fri, 7 Feb 2025
 01:55:17 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Topic: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Index: AQHbd3nMIxMs8+0Kl0yTieANtzpJ9bM4vRAAgAF3v4CAAN+roA==
Date: Fri, 7 Feb 2025 01:55:17 +0000
Message-ID: <ZQ2PR01MB1307F5D04305DCB0C010ED40E6F1A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250205025652.5171-1-hal.feng@starfivetech.com>
 <20250205135818.GQ1233568@bill-the-cat>
 <CAFLszTiNPT3oFLgNKack4ZQ_gfHCBeVHCV7Lh44pk6ODTxiHaw@mail.gmail.com>
In-Reply-To: <CAFLszTiNPT3oFLgNKack4ZQ_gfHCBeVHCV7Lh44pk6ODTxiHaw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
x-ms-office365-filtering-correlation-id: 4c3e0512-8af6-4b4d-f236-08dd471a78b0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: Fu6itMFI+Pmij7UyovlajhCqGVeszc6uxUuTYAkwqgdqIX8amg9Vkl8gib3LPYfx1bFpd2PIrrJnLb6Q5L6G9kJmPb8LS7n7SnMmkcxAZ8ovbEqcWjPoo001YfMtWlgYB3XJEIrUnFhlcwuq4CE/XvQEDyPZkq/hf25MTxFYZ7A3CAB5zzF1ELqacjj9WX8FxODTJnwrtz44hAMfgKXonQy9ZEXsJjZedlJYfnuvCXg4G8xyU8PmUc2cjgAOKAXyG7/6A+//FAaAx432AVs0v/5CxkJoAwGkkRtYgnTbZomAhlm/BcIoZWwLgdOtwaQQWh57cIqDVorFVDyJzqzh/N2Y6gkfNpCgrhLu5g7rxZh1LIoTa6NZFO/CncmKGVT0h8xi+IrygRspIAebYZIzDf3HX8ytD6wxT17yDFqdktTPNLJ20ccRWhoGWV2qBcu4FUYlsgLEKpy4eMrXDP1GME3pF07V+zAsPn5mrv98gdROhq/gU5twH6Aa9nuNQUsr5xU9k8uD8DnqemXlihKKDjN46CJGckdMnylFaXFNqdSDt5cAOBAD0Qv1ngUeFvZrFA6NS3qzPuJjHF09bbds4cLlW2tir24FPl2IKCoKRQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXR4UU1YWEdZZ2NUV29yZ3c5djJ4ZWMxdEhnYnRIM2svYVBmUStraWt5NDdq?=
 =?utf-8?B?NjIvOXV0a2w5aWdYV2hDOGdPTUJzZGJhL2lGUytLQWlaTFlCTlhyWXpubzQ2?=
 =?utf-8?B?cS9nVmhDeXRnSTVDeEFOM1FzM3BPcnNMd2tMOVdBbWNQcURheGNzcnI4OXJY?=
 =?utf-8?B?czRzdU5rNHZNUXFqU09od3oxcldhZUpBSGZ5Mzk0SUFuMEhwbTJlWHdlWVdR?=
 =?utf-8?B?VHYzWXVNNC90MTlWbXZIRTlTMUlUZnFQcm8xS3FCTDVhcFp0VmJOMldGQzdI?=
 =?utf-8?B?Z2NBYmJXTVhNVFZHMmxWQWxyOVYxb29Id3Y3TlJSQTFhVVNLaEMyZzRlUXJE?=
 =?utf-8?B?eHdreG9hS2ZVY2FQam5TOHR5aUNzL1E3OERya1ozVEUyQUg5N2dPNlFsUjJP?=
 =?utf-8?B?YkI0VUdkd1RaNE9JL2svOFp4VlJYNkpDZy9CQ1FkYm1oNnVUamtpMzJzcHpN?=
 =?utf-8?B?RXlZWk55bFc4bjlXSDIrbFRzTktzNmNyRUlLODJYSytCZi9OVEFLbnhhWm1y?=
 =?utf-8?B?MGtRRTBkcVlDaW5PMTF6NWpuc2R5Q3l0YjNVSzlFQ3o3WnVnU0RSRmFLd2hM?=
 =?utf-8?B?aWVoZ1ZVTisrV0dYUTB4enpOQjAxK2JpRXA4UzMweVV6bm1xQjV6ano3SUxh?=
 =?utf-8?B?VVBnRk9Md0JVTGVYU3o0SjhrNTB2YndId2VrK3c4RmhESm43ZTNrWlV0TGhZ?=
 =?utf-8?B?RDFDSDl1N2pxV0tEUzFPelN1bTlQb2NrZm1IUEkwV01oOEJWdFUrY2NibW15?=
 =?utf-8?B?SkoyMWRVLzIvSWMyZWlRK3BLOE43R3FBV3hWSWxkdXdJS2s0aC84bUlGY2p5?=
 =?utf-8?B?bXVCWFlaOTRKSWJQTFJlWUdqcGxiVkJmWjVOSHY2YXV4QW45NHd2aWZ2S2V2?=
 =?utf-8?B?NHorVzFPdXU2VnNrdHFWME84OXA0ZklrM2VlRXBKblgyM2JiK3ZjYzZWVUhH?=
 =?utf-8?B?MFBnbVRKemJkUzViVlVXVzFJajAvV1FuTk9tc0VGaTNEckxNai9Ib2hQOFEv?=
 =?utf-8?B?Ylp6ZURtd0JtWXB6dFpmSlIrUjFsb1VoaVRvMFRVdnBhYkRPMzg2dTVCQmxX?=
 =?utf-8?B?clYzNWUzdHYvUXByRGJPU283STlpY1UreEFpZ1RoN0hLbm1wODl1YzY4WlpG?=
 =?utf-8?B?bGNkVnZGcVcveE5uQjQ4bUZEZ0F3TGtlTGt4MlVueHd6OEdMdjR6QkFlK05M?=
 =?utf-8?B?dXdYNW1ETm1LRDVtdWlxZS80a1IxL2ZEeWV5andsQUp0bEp3Y2ZNTDY4MXN3?=
 =?utf-8?B?Z2pCUjlZZURYa0xIQTB0c0pJZDZ1Q3FucmhFQXJzbnRPK0o4dFVUNjZZUC9j?=
 =?utf-8?B?N1pxNTVvSE0xM09ESWxkdy9PbjB2dnpaSlhWZnZXUjZURmE4UW9mSWJFcEc5?=
 =?utf-8?B?bHBRTWdQUGFTbUo2MFcwU2tkRGh4MkY5Z25mdEZvZnJicEd1bElFS0I0bnpI?=
 =?utf-8?B?U3VVdzBKR2tJTXRaang3OEpSN2dPS0FJR2Q5MWRvTnJaMmVZRWlnT1lVS08w?=
 =?utf-8?B?akpzSnZWdnlhNkdpZGU3Q0JUeU03dkc4RDdydWNKLzVZZkc5U0lLbnVuaDlS?=
 =?utf-8?B?WThXMmNySy9IU2FWbmVwYmhjNXlDMVAxb2hISTdkQmdzMXVHUURPL1E4Y0lW?=
 =?utf-8?B?Mk5YK2h4SlVucGJLdENmMW0xNWQ5UTdBc3M0T3d6dGxBWnVSQmY5a0tNQVFK?=
 =?utf-8?B?OFRObVVEMDFDdFRUNG0xRU5hck5VdjQzTHplYm1DUDZYdXJucFVNbHlaVjRo?=
 =?utf-8?B?SzFLK2FVLzIySjdqby9ZVEoxWXNBQU83QnR3T2VicTZSZTlLbmFQNzlQQnNL?=
 =?utf-8?B?UzlNOFdHSVlRY1RycTRkQW43R0NuNU1ZSXhSblJTNE0xRjZiOTZqRENIMnp0?=
 =?utf-8?B?SWpWUnMyem51MzlmdUdWRXEwZTJmOHhmbG5OWDFVN3pYelllMGNhVThuaWtk?=
 =?utf-8?B?aUJNeDh5ZktZKzU1MFI0SERkT0R4ZVlWZFh4T3NLOE1kMnQrZDdwM0lkc2lG?=
 =?utf-8?B?LzY2LzR3UEFUWG9mWVZDMjJKTlpCRGJQY3FReGhHMGE1NmZKVVZaU0EyTCtM?=
 =?utf-8?B?UG9UOWxicUNSYUN1V0t5bUJEL21HYzNTS3FoMStnV250OUxMVlU1T1JJRzZs?=
 =?utf-8?Q?I08UJQsl7WPagibuIMV1RuE6M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3e0512-8af6-4b4d-f236-08dd471a78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 01:55:17.5724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTBtkJaLoxmU4BqwFUD7eTpyolrDR7/1yWAzRC9FAc8vUvT1S6mMTopj6pVm0PDT6+Z/ZaGPTiCdPWJ0uxf5996Wh3wKL6uV8cHjH9Muscw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

PiBPbiAwNi4wMi4yNSAyMDoyMywgU2ltb24gR2xhc3Mgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24g
V2VkLCA1IEZlYiAyMDI1IGF0IDA2OjU4LCBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPiB3
cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgRmViIDA1LCAyMDI1IGF0IDEwOjU2OjUyQU0gKzA4MDAs
IEhhbCBGZW5nIHdyb3RlOg0KPiA+DQo+ID4gPiBVcGRhdGUgdGhlIG1haW50YWluZXIgZmlsZSBh
bmQgbWFyayBqaDcxMTAgcmVsYXRlZCBmaWxlcyB3aXRoIE46IHBhdHRlcm4uDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ID4gLSBNYXJrIGpo
NzExMCByZWxhdGVkIGZpbGVzIHdpdGggTjogcGF0dGVybi4NCj4gPiA+DQo+ID4gPiBIaXN0b3J5
Og0KPiA+ID4gdjE6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAxMjcw
ODM4MTQuNjc4MzktMS1oYWwuZmVuZ0BzdGFyZml2ZQ0KPiA+ID4gdGVjaC5jb20vDQo+ID4gPg0K
PiA+ID4gLS0tDQo+ID4gPiAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMg
fCA2ICsrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lv
bmZpdmUyL01BSU5UQUlORVJTDQo+ID4gPiBiL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL01B
SU5UQUlORVJTDQo+ID4gPiBpbmRleCBkN2Y2MzhmOWI0MS4uODc1ODk1NTMxNTAgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUw0KPiA+ID4g
KysrIGIvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMNCj4gPiA+IEBAIC0x
LDggKzEsMTAgQEANCj4gPiA+ICBTVEFSRklWRSBKSDcxMTAgVklTSU9ORklWRTIgQk9BUkQNCj4g
PiA+ICBNOiAgIE1pbmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+
ICtNOiAgIEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gIFM6ICAg
TWFpbnRhaW5lZA0KPiA+ID4gLUY6ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLWpoNzEx
MC8NCj4gPiA+ICBGOiAgIGJvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyLw0KPiA+ID4gK0Y6ICAg
ZG9jL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyLnJzdA0KPiA+ID4gIEY6ICAgaW5jbHVkZS9j
b25maWdzL3N0YXJmaXZlLXZpc2lvbmZpdmUyLmgNCj4gPiA+ICBGOiAgIGNvbmZpZ3Mvc3RhcmZp
dmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnDQo+ID4gPiAtRjogICBkcml2ZXJzL3BjaS9wY2llX3N0
YXJmaXZlX2poNzExMC5jDQo+ID4gPiArRjogICBkcml2ZXJzL3JhbS9zdGFyZml2ZS8NCj4gPiA+
ICtOOiAgIGpoNzExMA0KPiA+DQo+ID4gTWlnaHQgYXMgd2VsbCB1c2UgTiBmb3IgdmlzaW9uZml2
ZTIgYXMgd2VsbCAoYW5kIG1heWJlIGFkZCBhbiBlbnRyeQ0KPiA+IGZvciBnZW5lcmFsIHN0YXJm
aXZlIGZpbGVzIGFuZCBOIHRoYXQgdG9vKS4gVGhhbmtzIQ0KPiANCj4gQXMgYSBuZXcgbWFpbnRh
aW5lciwgd291bGQgaXQgYmUgcG9zc2libGUgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIGZhaWxpbmcg
dGVzdD8gWzFdDQo+IA0KPiBSZWdhcmRzLA0KPiBTaW1vbg0KPiANCj4gWzFdIGh0dHBzOi8vY2ku
dS1ib290Lm9yZy91LWJvb3QvdS1ib290Ly0vam9icy8yNTQ1Mg0KDQpIYXMgaXQgYmVlbiBhbHJl
YWR5IGZpeGVkIHdpdGggdGhlIHBhdGNoIEkgc2VudCBiZWZvcmU/DQoNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MDExNjAzNDUzNC45MTUxMy0xLWhhbC5mZW5nQHN0YXJmaXZldGVj
aC5jb20vDQoNCkJlc3QgcmVnYXJkcywNCkhhbA0K
