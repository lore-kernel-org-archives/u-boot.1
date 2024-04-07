Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EE6CD128A
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 23:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14F387D1D;
	Mon,  8 Apr 2024 01:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ce3pZSuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CFA8785E; Mon,  8 Apr 2024 01:51:48 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871D587D1D
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 01:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eebf79m04l9fhWqRYgrwYcDJIte8txB3YmQM4N+9+UtvCWEggvAx9DOqOojO5AQyy1yF+d+H1Anj3+gHtVjnB+Npof/U3qXm2fNqvc6QPHGTwOBi/awHsqAQWu5ptbziCnMFCX1JvVCJVIrCVuC9RqL3ljzaya2UmfVdO4Kh7gOGMkvJJWPC+VL/i4nVZTeQfrsaw7sEpPfsvUV1RJHqJ2p4hdJ6fyjRBUjfnrEggdNkGtMx5LMccxFj9a0qqEhlLpzchn6lT4LfwFGrtDRo4M8f+6SJCGKTUTSuo1D8aShnL5TrSQad+gyIJ/l41XdFjqWJSYzf8rNrSTS6zsy4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFjwiWQGSLowrYUwjG8vf+br0tosLooRDjvF5eEWHRo=;
 b=l6JwUqzgy2UY0zASwArWvDjSq8pt9Deok7BxT+rQSORr27MpDbdKz3kxghYmSPD3y+TV3RtVZQn4heww/muhyJ6s6nQd1wgn8YVhvoFn/tnlfLaHbEzRBKC2dkz4vl1A2xG4eb7/fnIXh3fsg4pDifp7SPBXJnD1mfLTzhQZUNF4aPQIsVoim1mAj7ohFAKGuBWBLuE0mTPHZSo51b0Bhs3FbACBwGWNhLDJfHQyEoYKJjEbTKbjTANECkS+XrvZlInY19ch/VGcve7uIfaLu9KTJ5YJ2u1bR2B2cR1X3ZKECziITs+Mcw1h4CRN4FFwtlMEuuxAn07LU6pxjNLMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFjwiWQGSLowrYUwjG8vf+br0tosLooRDjvF5eEWHRo=;
 b=Ce3pZSuMd6Bb6qEYpB9zF6AYRLO6Ts4CIHRtKhZQuK7R482cK6dGynD6ACPbITEDLIhTkAkIuzT2iRMOXX2WFGZCoDBhO2xicYtC4MJT6rLD8FwhZ2x2X/1GkaUZDmwUe+b/Yc+ICJ/7sP2Ts/+iWMszcTteckZLbkwyxUUS6mQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 23:51:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 23:51:44 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Mathieu Othacehe <othacehe@gnu.org>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?=
 <sebastien.szymanski@armadeus.com>, Stefano Babic <sbabic@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHagMVDT80nSMU610ixQHv1ZnD59bFcqpGQgAAA/W6AAAB88IAAavEAgAB0J+A=
Date: Sun, 7 Apr 2024 23:51:44 +0000
Message-ID: <DU0PR04MB94177F495D562A8183C9745F88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87v84ta2jj.fsf@gnu.org>
 <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAOMZO5Codo2sBCugD4cgF72rTqzNN3Zo0i_3HJOwNHdKYhKMZA@mail.gmail.com>
In-Reply-To: <CAOMZO5Codo2sBCugD4cgF72rTqzNN3Zo0i_3HJOwNHdKYhKMZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9693:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVH5tHLvwAwoLwyyHQKKsoqUS/BFsc+IEz+VS6mV2yXYLIDDfiCFyiAsNHp7cjCFIBfLlX3K81hYO9gFiEFzVXQtLjGhwlX8owCXz5Q/gyHYbMDo0qiQfzqqS5LQrVPhSQQzYLZSuYgcgB/2RI5xS4HQ75pWgDoflv0xVN1HRj3ADwEocftblnvmwLGnwNzmWBVb78yLV84Yzu/NBVk9cHjv3w4pOqL/LCBNRGjV5Lwfm1TAqUfTMLP/WkTOrM5chJjPHxqY6mFpNCvIiXN8IHSM6Xzz1hlkIFtO5UOZCeOmVK+FphuA083/w+uPwjJg9vw06wOdNDlBdW3IUgCm22kCBLNCk6KvRfpDCFd+GekQP3worrEfHxr0P+hf7YiUZ9o9gekApuNmwzqVuxOtuopxtoroxxi7B9NPlWr4gJDtp0OsKrio+lS2WiRXMujCgK/qF5IPCEFWnOCyiURgTQuG21Bnwv/ormPznqRcFcSaGox5lwffe2daa2EjKQzh4gZ0b4i+3o9WXe0e0paP11LmezM0TPGZsYTkfsa6W1ILePSM+W6BloTgs76et2r5UnH87jALdcQcrN9g7UCsXRMSjOGnxaGxjPXbXM9qTtcAa81rlIUDwWeQQJQTG8WEsmOHWhsQGgboVl1BeT8V+s2ZN8Kj+cEBLPbmDn1gBSc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmVKb1VtRFlVRzM0d255Z01jQnpMeFZOZnREUmxUMmVkMXMrR3M2REttbU5K?=
 =?utf-8?B?V21HWGF1WEJZN2FxT3NPSXRnaERxZFdzMWV3ZEFpdWtqbFgzRDNyYzZkdGx1?=
 =?utf-8?B?SlhadHBPbzhmV25WM3NVSlpIcWdDS05LRlA4a0NoOGY0d1BhL1Fmakd0b1Qv?=
 =?utf-8?B?c0MrQ21pOGllQjBDeCt0Qm4wdCtLZk50NFk0aUJwQTdhUjZ6V0ZXR0RMTjBE?=
 =?utf-8?B?ZlpsdTUyU29NaDUzR3pBZUNnSVR6cEtOWXY0WHNXQ2FCZVdEOXFnZ0pvaWYr?=
 =?utf-8?B?MU1US01uSHQzSW9YcGltT2tXOHc4SlVDalBpMFJQczRSdkE0ejdzdWpYeVA0?=
 =?utf-8?B?dUc5dUJUVGlGWGxkTUhjWE5BVkpQcHpITTV6VnVjcjJWdDFPa0szVzc4bThy?=
 =?utf-8?B?dGdUU2tqa2Z1MlZpdTQyL01jQmtpM0d3eUgvL1F6U3l4cXlpR3hkbnVRSElC?=
 =?utf-8?B?WWllWW1SM2lqeDJhQ2xlZG9FMmk5OWluY0ovMk9sdXluUHA1bWFJcVl4N2g1?=
 =?utf-8?B?OHFndFN1czBaVzRpbHdLRjdNdjBjZzVyQW4zQzd2cDl5cWFVVGxqZkJZUmhE?=
 =?utf-8?B?Um5LM3pBcEtqMzRBZFVQZnFLQ1BNU3hYZklLa0p5UGFuK0U1YUZXdjNPQXJY?=
 =?utf-8?B?aVlHSVBLYUNpRXFWbmdCYmJ1OHNmTVkxcUR5M0xKczFaUk1HSGVhY0xWeGJI?=
 =?utf-8?B?azhMSDAvRGRQc3VZUHlIUG42R0REdGZVTGxsbVgrZ1BndTRHdlg0bXBUVDd6?=
 =?utf-8?B?dmdFUHJtRU0vbE5lanB1N3RveWFUc2U2R2Qwb2hrOGpsK1FQZmlzdUJPZzlx?=
 =?utf-8?B?TWhkTmFkMG9ZUnRWQlE4V0owYmVPMzhGSXlPblVYUlRwMW82cVgxTkMrYzJJ?=
 =?utf-8?B?SHFJMFJwdlRibHlrdVMyMnFaZTYrTnBpLzVDK3cwbWVVM3BDZkFsMmFBMmdT?=
 =?utf-8?B?MzJiRWg0c0NxUzRqRTVJVG5OdG5sNC91eFR5S3JIdkxKMk1hR2gvVWw3ZUc3?=
 =?utf-8?B?RHFnclhBeTA4cS9MbWlkSWNHSGRlcFovelR6Z3JzYjExK2lhaVM5N1dTMElM?=
 =?utf-8?B?R1o5NFdZak1ENWtFVjNFa2ZDckZ1ZmpGKzVGaVpmWXluTjl1bVMwa3RYWldN?=
 =?utf-8?B?bEdLa3I2cWNtQVhzejB4WUIwMDI5UW1jaUtBUVI3czR2VUZBNjNDYnlCcXB3?=
 =?utf-8?B?bitEbFUxS0dPYzRweUp5THFpTFROamUzNnFMTW9IMVdub1dnZEczWlV3SWtt?=
 =?utf-8?B?NzR2bURjNWdZRHFZWDhZblJHb0Y1bk5YeWdLdERLRnUvcVJKVnF2RW1lT01i?=
 =?utf-8?B?aVA1RExUWVJmb2dYQUNpdzc0dUFrM0FBdWdSSFlpQ0FtNFhzdGlrZUhVaTRB?=
 =?utf-8?B?YVFkSDJab1IrM2lpWlg4V3lMQy9kazlBZjIzaUhHOGJROUNVcXhSNUNGZWxY?=
 =?utf-8?B?UDJBVUNWTTh2bm52VldaS29qeEYrbmJOU0NIZEp2SlZSMU9DVlloQkRiRGxs?=
 =?utf-8?B?alZiUTZoMDErb2daQ3hlNFpmS0w0TDVRTm1wV2p0ZEtwU0JacGd0R1R4RXdt?=
 =?utf-8?B?WjFqRE43Zm5LM1k1cWlVWHd6aU1pcURObVd4UFpkRHlFNXJOakxxWGZ4eFpa?=
 =?utf-8?B?Q1NMTnJ5R1hYZFRCQ1F1QUtwYWxRZEdhN1ZFUnE4N09ORU44OHlGZ2JGMUlV?=
 =?utf-8?B?SWhudHo4b2xld2RYeE5ScHpocExZMUhOS2ZyRW1wY0Jyc0phZFVaMXUwY3k5?=
 =?utf-8?B?K3l5ZVo0eGZYYWYwWjNQSFhkVGNIdSs0OHRNVmduUDdvUU5aN3Q4ejdDeXZ5?=
 =?utf-8?B?YWJlMm9YZVFvQXBVV01idk04dThOV1pDK3ljdXJJYkNPODRzeHlwYk8rMzNw?=
 =?utf-8?B?aGNHU21JbEV4UXRCNElXVHBzaFRRMWx0T09XQVNNSUdtcDRvaVBjdWpNb05B?=
 =?utf-8?B?N3hHOGw4ODMzVjdTdHhpUmNUTnUzWGhmSmJkdXRPZkpDTG11TVM1SGJhYmdh?=
 =?utf-8?B?R3h1SFN4dUl6VFV0Q0FtTW04VFoydGRvc3QzNXFoV3dJaVMxQXd6TmVhZmw3?=
 =?utf-8?B?aXJQQS9hbW5vN2kraExPNkpEU3R6dENsUEZqT0ZNYTFPeUZrNk16dU9TVStD?=
 =?utf-8?Q?WPDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5353871-972c-4506-7f4e-08dc575dae4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 23:51:44.7291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzdOzEE597/4ffvxn+v6iEX05ozMdRFLW/hMxs0qBwQEj5ifgCBXeRIreyTSdtKl2BgslCa2jgu3vxnjJZqXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNV0gaW14OTM6IENvbnZlciB0byBPRl9VUFNUUkVB
TQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IEhlcmUgYXJlIHNvbWUgY29tbWVudHMgdW5yZWxhdGVk
IHRvIHRoZSBVQVJUIGlzc3VlLg0KPiANCj4gT24gU3VuLCBBcHIgNywgMjAyNCBhdCA3OjM14oCv
QU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBTT0M6IDB4YTEw
MDkzMDANCj4gPiBMQzogMHgyMDQwMDEwDQo+ID4gTTMzIHByZXBhcmUgb2sNCj4gDQo+IENvdWxk
IHlvdSByZW1vdmUgdGhlc2UgdGhyZWUgbGluZXM/DQoNCk9rLiBCdXQgdGhlc2Ugc2hvdWxkIG5v
dCBiZSByZWxhdGVkIHRvIHRoaXMgcGF0Y2hzZXQuDQoNCj4gDQo+IFRoZXkgYXJlIG5vdCB2ZXJ5
IGhlbHBmdWwgYW5kIGFkZCBub2lzZSB0byB0aGUgYm9vdCBsb2cuDQo+IA0KPiA+IE5vcm1hbCBC
b290DQo+ID4gVHJ5aW5nIHRvIGJvb3QgZnJvbSBCT09UUk9NDQo+ID4gQm9vdCBTdGFnZTogUHJp
bWFyeSBib290DQo+ID4gaW1hZ2Ugb2Zmc2V0IDB4ODAwMCwgcGFnZXNpemUgMHgyMDAsIGl2dCBv
ZmZzZXQgMHgwIExvYWQgaW1hZ2UgZnJvbQ0KPiA+IDB4NDk4MDAgYnkgUk9NX0FQSQ0KPiA+IE5P
VElDRTogIEJMMzE6IHYyLjgocmVsZWFzZSk6bGYtNi42LjMtMS4wLjAtMTAtZ2YxMmQ5MDE0MQ0K
PiA+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMDk6MzQ6NDQsIE1hciAyNyAyMDI0DQo+ID4NCj4g
Pg0KPiA+IFUtQm9vdCAyMDI0LjA0LXJjNS0wMDM4OC1nMzUxOTg4ZTJkY2UgKEFwciAwNyAyMDI0
IC0gMTk6Mjk6NTYgKzA4MDApDQo+ID4NCj4gPiBSZXNldCBTdGF0dXM6IFBPUg0KPiA+DQo+ID4g
Q291bGQgbm90IHJlYWQgQ1BVIGZyZXF1ZW5jeTogLTINCj4gPiBDUFU6ICAgTlhQIGkuTVg5Myg1
MikgUmV2MS4xIEE1NSBhdCAwIE1Ieg0KPiANCj4gUGxlYXNlIGZpeCB0aGlzLiBJIGFtIHN1cmUg
dGhlIENQVSBpcyBub3QgcnVubmluZyBhdCAwIE1IeiA6LSkNCg0KWWVzLCBJIHdpbGwgZml4IC4g
QWxzbyBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoc2V0Lg0KDQo+IA0KPiA+IENQVTogICBJbmR1
c3RyaWFsIHRlbXBlcmF0dXJlIGdyYWRlICAoLTQwQyB0byAxMDVDKSBhdCAyNkMNCj4gPg0KPiA+
IE1vZGVsOiBOWFAgaS5NWDkzIDExWDExIEVWSyBib2FyZA0KPiA+IERSQU06ICAyIEdpQg0KPiA+
IENvcmU6ICAxODggZGV2aWNlcywgMjQgdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQo+
ID4gV0RUOiAgIFN0YXJ0ZWQgd2F0Y2hkb2dANDI0OTAwMDAgd2l0aCBzZXJ2aWNpbmcgZXZlcnkg
MTAwMG1zICg0MHMNCj4gdGltZW91dCkNCj4gPiBNTUM6ICAgRlNMX1NESEM6IDAsIEZTTF9TREhD
OiAxDQo+ID4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIE1NQy4uLiAqKiogV2FybmluZyAtIGJh
ZCBDUkMsIHVzaW5nIGRlZmF1bHQNCj4gPiBlbnZpcm9ubWVudA0KPiA+DQo+ID4gSW46ICAgIHNl
cmlhbEA0NDM4MDAwMA0KPiA+IE91dDogICBzZXJpYWxANDQzODAwMDANCj4gPiBFcnI6ICAgc2Vy
aWFsQDQ0MzgwMDAwDQo+ID4gc3dpdGNoIHRvIHBhcnRpdGlvbnMgIzAsIE9LDQo+ID4gbW1jMSBp
cyBjdXJyZW50IGRldmljZQ0KPiA+IE5ldDoNCj4gPiBXYXJuaW5nOiBldGhlcm5ldEA0MjhhMDAw
MCAoZXRoMSkgdXNpbmcgcmFuZG9tIE1BQyBhZGRyZXNzIC0NCj4gPiA2YTpjMjo5NjpkMjo2ODph
Ng0KPiA+IGV0aDA6IGV0aGVybmV0QDQyODkwMDAwIFtQUklNRV0sIGV0aDE6IGV0aGVybmV0QDQy
OGEwMDAwDQo+IA0KPiBBcmVuJ3QgdGhlIE1BQyBhZGRyZXNzIGZ1c2VzIHByb2dyYW1tZWQ/IE9y
IGFyZSB0aGV5IG5vdCBiZWluZyByZWFkDQo+IGNvcnJlY3RseT8NCg0KSSB3aWxsIGNoZWNrLCBi
dXQgSSB0aGluayBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoc2V0Lg0KDQpUaGFua3MsDQpQZW5n
Lg0K
