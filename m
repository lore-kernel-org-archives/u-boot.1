Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE84C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412218808A;
	Thu, 28 Mar 2024 02:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kLe/WCBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789BA87DA7; Thu, 28 Mar 2024 02:37:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80F48808D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/1+mtiveoZsLU5zdZGgAyU7cqiKOE1e5etQZMCqcG7vIRylNTq/Y9OdIDfqdr4YM4T7gmjL8a3LOHB1mTAstCcJG6RZKqNiLFriC3+VY2quYESfc+ZJEaqldu+wDUkEq55FMa+hofySRtRe9gaLYEPxi88p52QVlUnBZTSeT6xLwuXo7peJ9CWz/fQ4aQDBos3JXJOvSnGs7hd52OjUyCVWs/TcgG9aeSF9P3rpWfXop0T+5HcBACwk3+4bTd0fsp7UlQSzAXCIdnoXFCJcyJUbK4MZGGwinpg4b/82JlgwWt5+gouu0YBqXJeeaiXOK7rl0avRFxlULyqJs4wpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl0eB1jh7n2wbcUxXHUI5gLYypl6JM0RpDFvtZaqqZI=;
 b=VfVXDHCX/31fjBZqBNA/KZ0HU3+sM3acf86GbgOFRFurcrxqHPeO9930pOmw6KHg7+koa/USiuldmcjS0MOAfIsPxfnOYxm59sKN996C/Yneh9JuJk3qAAzylYHeGN0Bseije+ma/I6lJB+SW0hid4zwmKpl0322oxxg4nhy5XmMIA5UrnIY9DaJBip4N06v57GeWo6i1+jlLqTavcumZfy2Zp2YIeEum3UUoVzhlz07mgPAZrWcP3Ugmh9r4NnhInB82rq4yZjvS3d6pyKh7m2urhrdRhfpQR/xwAtHeIbICVXy89c4ldDw5bYl1a+g7frQzd0v1wwIqU+ewdkqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl0eB1jh7n2wbcUxXHUI5gLYypl6JM0RpDFvtZaqqZI=;
 b=kLe/WCBveZ4HuX9EPa3MTSJV4la5un11CFwZCSNVj09PD29cEhfiQvhALkOP2CZnosgDoZFnyXUcsFRSsZL3UHuIkkjIvebqnZAFT1w8EUGwZdRZAVgyc3g/gHM/jCnhz+55ltvY5/BWQy8oT1AE84p8zbLlpw/l53ZK8iNMijk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7833.eurprd04.prod.outlook.com (2603:10a6:10:1ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 01:37:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:37:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 4/4] imx: imx8mp_evk: convert to OF_UPSTREAM
Thread-Topic: [PATCH 4/4] imx: imx8mp_evk: convert to OF_UPSTREAM
Thread-Index: AQHagK8MOo3z1O+u5U2C3IxrffCixLFMXtgAgAAAU+A=
Date: Thu, 28 Mar 2024 01:37:04 +0000
Message-ID: <DU0PR04MB9417750DF1711395A0CCA47F883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
 <20240328-imx8m-v1-4-2be5e6657a88@nxp.com>
 <CAOMZO5B3Bhv4wEH-fmG-z7hz+Dq1RTAtdsk7cLyZPsAKh-B5wQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B3Bhv4wEH-fmG-z7hz+Dq1RTAtdsk7cLyZPsAKh-B5wQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7833:EE_
x-ms-office365-filtering-correlation-id: bbb0ed15-fac0-4f37-8073-08dc4ec79269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICCyFO2Rh1B9nTvH+IUZZE4KAh2IxJlYSUzMZzwsekvvDyvLA2t8Kaxm82Z2CxwlsqakNL2J5oou14ogZq7CUW1joMFiHMcggNbLU+g5carF3QBDBxwGX+j5UGyyNiJVXFeajyYDqoIwoY5qOan5p35LQ5BrTbm9rdc++w6+8SiYlal689yjkxdVH+WxAr+cM+Gv5ddJp0Rsu+cUqrgE1ob/m7Uj5VMPtTjSHDyMbFYYZU590TJuNyEO6p+fZlrmNkxo83zxDovjKTQhIWnf7Jpx2eV0nY4InPNsjM8HB2cxFDUSJiNleQ0SBKUvu8KxC2PFcvsGo42U5o1KzB6oIHTIqFU4gosZvCOr/385DGaEEV+9WEaZxg9l010Ic8a1pLNsdfwU4Nfp1ySGn1paLsNq0cvDoRFHcPGNx04WFUS7HAy5Pu+lwuBlaMH69tF9JjPXSqTAc7MxV7QOGAt62fOmEklkavMmXkjYaD7XLWKE5i6RDrNwAR89sIK4hnrrS9+dBzMAsBL/7kSNsZSBsJj8fC9evCoVbbW+BgpMSvkChDj8de0wN5sAHE2ehh7mT8inMnBMDFOu/IbsXnKYltHZz+80o8Y0sAMzoOY8mkbXg/aXTrBRrN+j/Mz1CdHvP84kRe/Dn6te5eif8lslpeA04JUIWfv2fZ3BxA19Co9MURMLzPLU+qT4fgf4ChMrLkgu22/bGwh0hOjUv+f58GBtGzPtolj2CDUtWQ0eg64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dllyYjBpUkxGRUtVVWlud2FtTkl3bytRZWxWVVhCZEdSYmpBaWVpcjBqMUF5?=
 =?utf-8?B?UlRNYjdEaEtsU0dPdmxoZXlEdUFWR0pjVnlLYlNTNHEydFVwQjN1OXlvQmp5?=
 =?utf-8?B?cXZzS0hXSEJyL1d2WVFHamN4UzAvejVtTHcrMDduanNFNDgwNWQ0dk5rU2xI?=
 =?utf-8?B?NXUzaHl5Q25IVnJEeUFSTkdRTE50ZGowbWo1anVPNjlhWjY3MDQ1R1lvTnZG?=
 =?utf-8?B?VjdEbU4vWHJsWGNydnRKcFRzSmpyZFpZbUxGTW1EWFRhVEJJOU9nMnRzajZR?=
 =?utf-8?B?dVZ3dlNUbUZOTk5vd2NpZ2x6d1NCZFgwMGE0ZTQveklqdHltajFhbVJKRHQz?=
 =?utf-8?B?ZC8rNStCaE51WUNOaGUzV1JDSENWc25FMW9TRSswRU0zVU5IS2RXUWtOc1lD?=
 =?utf-8?B?RFFSSUtMK2g3WnJpNTlDdVdkQkdHVXlKdHBmc1p2K2R6OTQ2RTNNSDA3a3dQ?=
 =?utf-8?B?a0VncEhBbVdkMTRLZUR6QzVqdWU4aHZ2cVk1SmVKREhiMkRvLzc3RWJCR3Q2?=
 =?utf-8?B?dXAyVDY3b3hQWWFDREpRUHdjUG1kUHdtNWs0WjNyeWZicmE4L0ZVVlVPUDFw?=
 =?utf-8?B?VThOWGk0S2FmQVlvQ3d3TEhOQjNmKzdmVG1nT2dNb2VOT1RsbFdtRTNaMWtC?=
 =?utf-8?B?bVdncVpQMVFaelE0bWI2eWJZWmlMU29qQkd1UFlneWdrRUMweHdUL2ZNdFlp?=
 =?utf-8?B?UGEyU216NEl0SGdXNmI5ZXF1YmdMVjFjL0h6LzFWbnoxSnNqVHZ5Q0p1V051?=
 =?utf-8?B?WFFORlNjWWZmZlNxb0V6emJSMUpiZnVlSmFPbmZtOEN3QWNwOGptZUJQSTJN?=
 =?utf-8?B?N0VTQ3VVaWdBWEw5ZVU4Q01PajBvS2RodVVFSThrZDB6MTFuYys0elFoaCty?=
 =?utf-8?B?dE9FWXVvNlZkR2wwSHJxRnNNYzF4WU4rSUhibVhvNk9lQTR1ZjR2QzhRbi9D?=
 =?utf-8?B?ejBWckVzYzdaVnJVWEFETWxreGtHWUhrdWZSL0l1WjI0ZHRmZldxR1JHaHoz?=
 =?utf-8?B?TVNpZ0ZWcCtJMFQzUmdPRTNPcUZYazFhZDgyNnNiTlVUQXlkblpPTjhNYjdG?=
 =?utf-8?B?SFJGd3FhNUtQNkJERmozNUNZVTZrT2tkcDBDdVVLeGFEQWl4cTVMK0htNzh3?=
 =?utf-8?B?dEdjTzQvbEpMMEt6SkNub2NTMnVKQU12c0luTGV0Ukt6WGJ4ZTUzRmw3Vk0v?=
 =?utf-8?B?VFJKdTdLdlNYd00wUjd3dHV3SWU0YjZVU1AyWEs3YmxxR2RlbjRRZ1FMQU1M?=
 =?utf-8?B?RGdxNXpNNUovcVAwUzVZNjNRY25mSXFmM0lrNm9oOTdSQkVSZnhmeHJnZ2FH?=
 =?utf-8?B?M0RadHExRnBpRitKanpKdUprOGQzM0xHRmdHSVRKSG5sQ1dseVJQS0w4clJ1?=
 =?utf-8?B?VDBDMjVsbEVUd2p0N2VZVE1XNE1tWEYyVmVidWV6aTJGSHBycnYzdXJ0dzhq?=
 =?utf-8?B?emhlYXF3YlYwRnRQQi81citHakowdGIvaUMrdm9raTNBaDh6TWxKUnBnM29l?=
 =?utf-8?B?S3pXVjBmVTJpZGk0YnAzY0F5T1FRVC9NT0QvRThNckNhQ2lIVmFZTGNIQklD?=
 =?utf-8?B?ZkJpZzkwcWdzRkFhVWU0SnB0Tlpsa3phK3BkWGFzSXBXcWIzWGRKUGZPb2pn?=
 =?utf-8?B?dG14TFUxNVdFWnl5RkpzOWdQV2oyZHBtODl5K2ZNb29yRnBPTlJvWE5yRGl2?=
 =?utf-8?B?ejBCKzVGVkk0UUxZZFhYRjNpWnp0U2tDM3pCMWxIWGE0dzRES0RCcDU4QUhs?=
 =?utf-8?B?Zm85aExlMTBHRW92dEdMcndNUCs2bjJSMlIyT0VHa3ZZREx2UVVrN2s5NU1C?=
 =?utf-8?B?ekR3UnZZWWl0Qis3YThZVGZUMkNRSnp6NjZnenlNQmZzRmRyY1grOFZTcjlk?=
 =?utf-8?B?bFdzYzdEeGFzUi9DdG5DZTM2S1Z0TnRGbllhOEF2WXlieVFabGFCZmRaWFBh?=
 =?utf-8?B?YlVJVGVFOE80bFlwdE1OL0JGKzdwUkNJM1R5ZHJHQW03dFBNdko0YlhKVlBa?=
 =?utf-8?B?SlJVS2dNeVNXdnJLdUYzMjFNY0Nsdi95YXFPaGo5VlRZR0hqdVJRZks0UmNK?=
 =?utf-8?B?R1c1bkc4STdvM0NqOWcyUENKNWxldm0yMWNIamJ3d21KR3VseVVPR0NOMWZO?=
 =?utf-8?Q?VDow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0ed15-fac0-4f37-8073-08dc4ec79269
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 01:37:04.1487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DA7qfIBjp+Ua6VtAa8b/txNX7FYhBvqmaldvfSTzg/PB2KgJ5ndGizyD4nCfz1BVQQZay5xkQJtQ8ghszKwujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7833
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gaW14OiBpbXg4bXBfZXZrOiBjb252ZXJ0IHRvIE9G
X1VQU1RSRUFNDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gV2VkLCBNYXIgMjcsIDIwMjQgYXQg
MTA6MjfigK9QTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3Rl
Og0KPiANCj4gPiAtLS0gYS9hcmNoL2FybS9kdHMvTWFrZWZpbGUNCj4gPiArKysgYi9hcmNoL2Fy
bS9kdHMvTWFrZWZpbGUNCj4gPiBAQCAtMTEwNSw3ICsxMTA1LDYgQEAgZHRiLSQoQ09ORklHX0FS
Q0hfSU1YOE0pICs9IFwNCj4gPiAgICAgICAgIGlteDhtcC1kaGNvbS1wZGsyLmR0YiBcDQo+ID4g
ICAgICAgICBpbXg4bXAtZGhjb20tcGRrMy5kdGIgXA0KPiA+ICAgICAgICAgaW14OG1wLWRoY29t
LXBkazMtb3ZlcmxheS1yZXYxMDAuZHRibyBcDQo+ID4gLSAgICAgICBpbXg4bXAtZXZrLmR0YiBc
DQo+IA0KPiBIZXJlIHlvdSByZW1vdmVkIGlteDhtcC1ldmsuZHRiIGZyb20gdGhlIE1ha2VmaWxl
LCB3aGljaCBpcyBjb3JyZWN0Lg0KPiANCj4gWW91IHNob3VsZCBkbyB0aGUgc2FtZSBvbiB0aGUg
b3RoZXIgcGF0Y2hlcy4NCg0KT2gsIHllcy4NCg0KPiANCj4gSGF2ZSB5b3UgYm9vdC10ZXN0ZWQg
YWxsIHRoZXNlIGJvYXJkcz8NCg0KVGVzdGVkIGlteDhtL24vcCBldmsuIE5vdCBoYXZlIGlteDht
cSBldmsgYXQgaGFuZC4gQnV0IGNoZWNrZWQNCmR0cyBmb3IgaW14OG1xLCB0aGVyZSBpcyBubyBk
aWZmZXJlbmNlIHRoYXQgd291bGQgYWZmZWN0IHVib290IGJvb3QuDQoNClJlZ2FyZHMsDQpQZW5n
Lg0K
