Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E06AC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96948813A;
	Thu, 28 Mar 2024 12:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="j7Y32nJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702DC8813C; Thu, 28 Mar 2024 12:53:07 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3B38810E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyPe53NzITOS0Aon59pqFcagKotE+K+3CUESZDF7DLTuYRfZzruLyi3yEeIVZi0KlxQeHEo+sRFfgRhHN3cs0GBI65+i7wrCVX3gbks5Ii/pCvxJJXKAxtbSqduSwX63o0Zktw2oDnIrYCPVTIX0zPNZK9DkOqunOIjskMT7/RFpxOprK1V0RPpgi/1o9Fj72yX2sGG6h4Hs20mEW5Rbq/oG0QZfjG3gxxZjiX+9OvygV2KZEF6v16U5vOtSiokHNL9wJP52nIvDYO6hPaxRjvSC0Ke3Wrzb6g54roAp94nghVdgAPPzvAx9FoSbeOn5A+96GFOSXRZcA9H/W496jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzpaDQR+0joleBiASvNdEbQ2Rn6jo9mHqE8JY2AdJU8=;
 b=X2BzmMPMzOjjiKWwLGyJA0ofLI5y67rrsQguBphj6cUrzAHKhGk/BSmXaLAXlGMr8AhW697ybXoYrXcCrHSkku+GWpwddYuSoO/KymrYRp3QrUv7hE256cyCEdwNMoK1rWyUT7c77dsb5hl3OKw0pBlFL53uxOX/++jyUDyymJqSDh3KXPJ5OJkJAR2fX32KhRU7j5t/HYM4tX3CfUJEaCkT16XrGE+crw54APTo2eepxIwIySjXMXpRH7tV1zC8cRep9ShNLkODcye40p7UhobZC8G44SQxaLz6Y5eeYThXJvVREdremQ296aF+B35J0eai9nOr189TbHyTUNa73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzpaDQR+0joleBiASvNdEbQ2Rn6jo9mHqE8JY2AdJU8=;
 b=j7Y32nJb6tJFYAr40cv01rDkyWDKoszcrPayyuFvlQukdM24cH81rLkTEEn6wbiLk2bBgpZjEAuudBysLFQ2yTToUt9i03AsBoIZuhI8+0cSZdpqU1N15kVCPqIGDVNRBHh8SlAZNaRmr50nqTdRJrIG9B9lssIkK9e7M3wFxD5DK4J/UTnAm+zMMxZtvV23LzQm8X0Yl7y7WuwJi2E4048q9Z2NvQw1S7QuXL/wUfzh54wzg78lsy7OMK+7jev9u0/fflGdX9BpkbHo8QbeYvL9i4AJz3j3EM7vmU2HQ3YkJV4gYYgVXcAJ3i6bWp0IdJ2PEIWrZkMDrXP9WCZyiQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 11:53:03 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 11:53:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "nm@ti.com" <nm@ti.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "s-anna@ti.com" <s-anna@ti.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Thread-Topic: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Thread-Index: AQHagNlEU5uGPu+kU061+DtXN0/TP7FNCTiAgAACDYA=
Date: Thu, 28 Mar 2024 11:53:02 +0000
Message-ID: <b7627659d44bad98fce87d4526bb8fb105a9233c.camel@siemens.com>
References: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
 <20240328114541.pep2fszctvzc3qqt@slept>
In-Reply-To: <20240328114541.pep2fszctvzc3qqt@slept>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7009:EE_
x-ms-office365-filtering-correlation-id: c1dd5842-0a76-4623-dc03-08dc4f1d9f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhIRiv3ALhzM6c6ucev8UeWF6POWOnmoCGZWUXJjd+BzsxF5+2+M8I/X+leWrr6hEiNhowHQ8ltXo065TV91d8dGPuydxijeM3L47YEsWSiN0nkEDe46unxsxI1w1jQDxP/ROMK1O7QEy/eQ6oIS3jKuq8mQnNNni7DJd2g64LLdKebt6Jzvdh+EY01th0DzwoPAbwE1+gVQMRii6YGrC1Yu3W+aLdu0HfVPHQthZxrS3V7g/DEblViMJeXOslF1Z5D+k7oe0Ffn0bn8nc7S7Rf2v/gVbFp/1Z5qIUaLTATNVuXWZ/3Vzs80LkhFagiRyLqN155Gj1F0vqKpeSp+aDSgg7dvOlr3eby2eFJFa0GHyHT1hGo5Fvx1Srot9xFLXx2c1x8qrec5pbL+JLQDQphD/BqE1z1tL6YVWkDCj/qezy6rvi5drOKJ/BT6nhef6clK2YSeqsTXUR8qdTeFWTJssYtaihGFE9CtvOodchYcWmXxJCaOEtoHZaRp1d8SZg2+Mqo/AV+9+gwV/17HZVkGbti4zJSrRkfBlrxofXZvinO/Rt1NkswTtf9Zt87kL62gZTKAHvuasDDt9sAlVA5qJ4OmafvAWykLAV59sZ8De4HuX8Av284xFEmhckPkzWVu80QhOFE/UvyQv2Wf+qHqx9/y8UyS/qbBEyayc/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emlaYjJvWmh1YUVpWWNLNm5YUzJCZkxYSVpDQUpTYlhIeEZIOVVTbWRsMkFv?=
 =?utf-8?B?OW9oZnU5dDJlaVczdW8yRnNxU3A2UUlvU051TExaWFJMdnRCTDk0dHozTEl2?=
 =?utf-8?B?UDFWWkJTb3QyQVJFYUQzUWF1UmpvdFBLRVYwSkhwRTFTK2dEVVZjcGRxMHJh?=
 =?utf-8?B?RG0rTDh4MmtzVDlUOTdDb1hvdkF6bisxNlQ1L29EV3oyMGZIeThEVUszZ2o5?=
 =?utf-8?B?NWFXajNZdHdsUFV2MjJIeVh0THRuRVg4NFM3cld5VE5FYnB5VlR5UFVZUGt0?=
 =?utf-8?B?TTdRcXE4SHloMlJGRndLSzdxTE5HMDYraGQ2ODdpY1VHVnM2ZXVxUVU1dDZu?=
 =?utf-8?B?ZHo3aUpNVnJKdkI2L2E4T2dVQ3BqdUdzL0FPbThyUUZYSVJSajBzYXYwYU1k?=
 =?utf-8?B?QTh0WUVxUWVLTWNUSzJFN005VWxQY0lRRTZYZFRvK3RqaktIOERtNkgwVkF1?=
 =?utf-8?B?ZWJaMUxKamIwZ1daRUt1c0RnR29EakdGR2dXSGlMdytzZWU3dU9pL3o1dWxU?=
 =?utf-8?B?T09OZyt2RXg4azdVRzZwVzBKTU9hK09YQ1gzZ2ZBWGdLUmF3enRNdEJyK3A0?=
 =?utf-8?B?OEczWVp1TVQ5cHJWc0JyMEIzalJJZmhWZjlGSWEvMVNYSUYwNWFranRwNG8x?=
 =?utf-8?B?Mlk3dEJZazIzMkhTbU1tUXA3UWhNNGZzRUdjZWtRL2I3dUpMclpvcFZCOEhp?=
 =?utf-8?B?Y1ZVd21MZzFBYW5iSEx3L1NES2JRV3d1RUg5MVRkcUFXWU4yVFpvSVJlbHZE?=
 =?utf-8?B?eGlxczRBT1JPQWlPTGhBNHYydVNuYjc3OHdEYlFkSmRvVmJVQnViQ1o2aE44?=
 =?utf-8?B?OVZYNVhLZVFRTXE4NndOWW1VNm1XYlhraGphL25FYnkzWm5SbVAzMDdLbGhE?=
 =?utf-8?B?UHhjNUZOZHhYbTFYdms5aVZ5WnJ1a3V1Z0JUMStkSnJlSkdJeDJnK09IVFhO?=
 =?utf-8?B?eStEUTg2N0FnV0VMOFBBU2tPT2hRbWpoM3F1cGU3d1hwaC9KVmFxdXFFSklZ?=
 =?utf-8?B?eVl6ZURDN29Tb3ZPL2o3Q2VUc2E5bGxhQlhFNHBhYXVOMlQ0V1NlQTRFL29s?=
 =?utf-8?B?WDJCYkRsVi9SMUllbGUvbHRWam5saTRWNmFzSUlLV3VMMVk1U3h6R1dWVi9a?=
 =?utf-8?B?QUtMSG5vSjBmRDdkeGtONWFxMWN2Wmd0aTUxcVVQT08xNzlSQk85amZhb1Mx?=
 =?utf-8?B?M3o4STFucDJSL0NDZHVoUStuWENNUUxiTTZPRTdJVmVtMy94cm5UaERXcklr?=
 =?utf-8?B?TUxSekhjZkIvWWd4RTBBdWlCNVY3bXlSVFdyNXN4VE10OHgwdnRONGgrbEV5?=
 =?utf-8?B?SC85QnpESUtrLzZJaFdMbkxrT201UlhkVTBLT2FFTnQ3MS9xUVc3SVdxS3Nx?=
 =?utf-8?B?T3dnajV6cG9ZRnhqU1RVTWdSckpmWG85WFpKUGJNckM4ZzFqTEVzbzRYeXBp?=
 =?utf-8?B?WS8yNm9lOTJLelRDeER1azlueW5HQXQrOG90T0s3NjVmNXlNV3VsbU9YanJT?=
 =?utf-8?B?L2owUktPVUhnR3pBajFyY3dBSVAzNGNDK3VrNmlpV2NvWUJGSlZKVSs4VnR2?=
 =?utf-8?B?L1N5Q2ZENTZ5T0k2WU5FSUNYN1lKbWs5VkRNOGRpL2VicktNdmdXbzZ0SlNE?=
 =?utf-8?B?TXV5YS9lbjJlYjJYNGxKTHdGK3dsSHVmN2RrYnhwS1NraUVhMWpDVGVXcVJY?=
 =?utf-8?B?WHZGQjdJa1FhalZsK1prcU5OTUVJYnFvaXFsSTl4ZWtocTBrVEUvNWFna3p1?=
 =?utf-8?B?SjNCaU5KbzBGbUVyaklWWndoN28yZThFY2tncE4wc0E1UWYzYUZFMGVDZTlr?=
 =?utf-8?B?UTFKTVV2eEE3b3E5VHpuL3VNT0s1enkvTzBybTRKSEk0Vjd3TnFjdWwxcC9q?=
 =?utf-8?B?bkpkN0kzenVqRDB3NmhlbFN0RkVRNzBaSkVDeWppd3dSZTBLakh4SWw3eXUr?=
 =?utf-8?B?R2d2SnRZenA5TXNDdXVrQkxPYThrMEY4L3JKRDNrL1ZOUXRIZjdJcGRVS2ZR?=
 =?utf-8?B?UDVpU0tUeVFDaUQxb093YlZ4TmxYb1dKc2ZML2tZT3FLb1Rvd3k0dW0wNjFa?=
 =?utf-8?B?em8rcXNtUEpTZ0xNUDFkUjlZUkJGSHpyenF5ekltY04rQ2V2WWd0NlJGa3lW?=
 =?utf-8?B?alpCVlZrYmxTRU9lbkZoRFQ5SWo1QjQ2VzhzczdKajAyV3JPTnlvdXdaK1FC?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <628C1525349E8C438AF693BFEA2B5E25@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd5842-0a76-4623-dc03-08dc4f1d9f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 11:53:02.8478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvxp6JSx5TVg17rdtxqF+HQDswD/NsQydmHDgafgXkt5+ivkc8xANET3Me/vGJ0+GDzzgVh19u1iLov1p2ZIafX/of/l7xZybnoWgpljzUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7009
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

SGkgTmlzaGFudGghDQoNCk9uIFRodSwgMjAyNC0wMy0yOCBhdCAwNjo0NSAtMDUwMCwgTmlzaGFu
dGggTWVub24gd3JvdGU6DQo+IE9uIDA3OjI5LTIwMjQwMzI4LCBBLiBTdmVyZGxpbiB3cm90ZToN
Cj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5z
LmNvbT4NCj4gPiANCj4gPiBhbTY1X2Nwc3dfb2ZkYXRhX3BhcnNlX3BoeSgpIHRyaWVzIHRvIGhh
bmRsZSB0aGUgY2FzZSB3aGVuIFBIWSBpcyBub3QNCj4gPiBzcGVjaWZpZWQgaW4gRFQgZ3JhY2Vm
dWxseToNCj4gPiANCj4gPiBhbTY1X2Nwc3dfbnVzc19wb3J0IGV0aGVybmV0QDgwMDAwMDBwb3J0
QDE6IGNhbid0IHBhcnNlIHBoeS1oYW5kbGUgcG9ydCAxICgtMikNCj4gPiANCj4gPiBhbTY1X2Nw
c3dfbWRpb19pbml0KCkgaW4gdHVybiBpcyBwcmVwYXJlZCBmb3IgdGhpcywgY2hlY2tzDQo+ID4g
aWYgcHJpdi0+aGFzX3BoeSA9PSAwIGFuZCBiYWlscyBvdXQgKGxlYXZpbmcgY3Bzd19jb21tb24t
PmJ1cyA9PSBOVUxMKS4NCj4gPiANCj4gPiBhbTY1X2Nwc3dfcGh5X2luaXQoKSBob3dldmVyIGlz
IG5vdCBwcmVwYXJlZCBmb3IgdGhpcyBhbmQgY2FsbHMNCj4gPiBwaHlfY29ubmVjdChjcHN3X2Nv
bW1vbi0+YnVzLCAuLi4pIHVuY29uZGl0aW9uYWxseSwgd2hpY2ggbGVhZHMgdG86DQo+ID4gDQo+
ID4gIlN5bmNocm9ub3VzIEFib3J0IiBoYW5kbGVyLCBlc3IgMHg4NjAwMDAwZCwgZmFyIDB4MA0K
PiA+IGVscjogZmZmZmZmZmY4MDhhYjAwMCBsciA6IDAwMDAwMDAwODA4M2JkZTQgKHJlbG9jKQ0K
PiA+IA0KPiA+IHdoZXJlIGxyIHBvaW50cyB0byB0aGUgaW5zdHJ1Y3Rpb24gcmlnaHQgYWZ0ZXIg
YnVzLT5yZWFkKCkgaW4gZ2V0X3BoeV9pZCgpLg0KPiA+IA0KPiA+IEZpeGVzOiA5ZDBkY2ExMTk5
ZDEgKCJuZXQ6IGV0aGVybmV0OiB0aTogSW50cm9kdWNlIGFtNjU0IGdpZ2FiaXQgZXRoIHN3aXRj
aCBzdWJzeXN0ZW0gZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRs
aW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogcmV3
cml0dGVuIHN1YmplY3Q7ICJpcyB0dXJuIiAtPiAiaW4gdHVybiIgZnVydGhlciBkb3duIGluIG1l
c3NhZ2UgYm9keQ0KPiA+IA0KPiA+IMKgIGRyaXZlcnMvbmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMg
fCAzICsrKw0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdGkvYW02NS1jcHN3LW51c3MuYyBiL2RyaXZlcnMv
bmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4gPiBpbmRleCA2ZGEwMThjMGY5ZDUuLmQxZTQ1MmI2
YjQzYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiA+IEBAIC03MjIsNiAr
NzIyLDkgQEAgc3RhdGljIGludCBhbTY1X2Nwc3dfcGh5X2luaXQoc3RydWN0IHVkZXZpY2UgKmRl
dikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHN1cHBvcnRlZCA9IFBIWV9HQklUX0ZFQVRVUkVT
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0KPiA+IMKgIA0KPiA+ICvCoMKgwqDCoMKg
wqDCoGlmICghcHJpdi0+aGFzX3BoeSB8fCAhY3Bzd19jb21tb24tPmJ1cykNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDC
oMKgwqBwaHlkZXYgPSBwaHlfY29ubmVjdChjcHN3X2NvbW1vbi0+YnVzLA0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaXYtPnBo
eV9hZGRyLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByaXYtPmRldiwNCj4gPiAtLSANCj4gPiAyLjQ0LjANCj4gPiANCj4gDQo+
IFJldmlld2VkLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KPiANCj4gDQo+IFRoYW5r
cyBmb3IgZml4aW5nIHRoaXMuDQo+IA0KPiBCdHcsIHRoaXMgbm8gbG9uZ2VyIGFwcGxpZXMgb24g
bmV4dC4gb25seSBhcHBsaWVzIG9uIG1hc3Rlci4gRGVwZW5kaW5nDQo+IG9uIHdoZXJlIFRvbSB3
b3VsZCBsaWtlIHRvIGFwcGx5IHRoaXMgY2hhbmdlLCBtaWdodCBuZWVkIGEgcmViYXNlLg0KDQpU
aGFua3MgZm9yIHRoZSBoaW50ISBJJ3ZlIHRvdGFsbHkgbWlzc2VkIHRoaXMhDQpBbmQgSSdtIGV2
ZW4gbm90IHN1cmUgdGhlIHBhdGNoIG1ha2VzIHNlbnNlIG9uICJuZXh0Ii4NCkknZCBuZWVkIHRv
IHJldGVzdCBpZiB0aGUgcHJvYmxlbSBpcyBzdGlsbCB0aGVyZSAoYW5kIGlmIHRoZXJlIHdvdWxk
IGJlIG9uZSwNCnRoZW4gaXQncyByYXRoZXIgc3Vic3lzdGVtIHByb2JsZW0sIG5vdCBhbTY1LWNw
c3cgYW55IG1vcmUuDQoNClNvIHRoZSBwYXRjaCBvbmx5IG1ha2VzIHNlbnNlIGZvciBzdGFibGUg
YnJhbmNoZXMsIGlmIGFueS4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K
