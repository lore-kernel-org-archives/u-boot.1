Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001ACC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791F187964;
	Thu, 28 Mar 2024 02:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TsvGwtSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D5E8272A; Thu, 28 Mar 2024 02:55:24 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECD387964
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUjsu9RI9ZZcU+NA8wixVgPekvHxpvnpootfAvE+jGoaqnYd0NH3BXUjWGpQ14/iR03Mgz+kqxEXPhlWsop9NVtCQtJrdlS8HWYB7pcqK41oWm+D+p+rWDhkZMq6ftL4gbLj4cQH/qh/yQnsv/xlrdIJo1+ZPn26X2GuAfEkUhefvZGrGwOxoEv+s8nuoRQ1J5kRwH2xplLAYTfp68HR1XVbcUVYEjlCnPLXE8BvArczBtbJ6kZfV8su5EBVGoEFyUX6t5s+g3UXALHPzbyhmN65QLs6RCS5lXPIwOZItnWNWBkuXHd8kGwF/WSuDn9iiietqaMckPxEj3SJYqSRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x9Av01/G9KxIwCtqw3nBjoZAKyuRh4p0kbdP87lkDU=;
 b=NiIpOua0OVKSRVyp9LtEY3mRpNjEH6YvN18wvQO9Y8PP964g/YMGGmWqXViKBjocXVvkNXH8B2Thn1Z1qF2F1BohNaZugIF3F2D4ws5y32VCDIIPw+VoE3lxF/2GLd7BaAHSCTzkyms+16v1bvjPGOs8stDSW++emOClCSbbPEBOw7kFtD0gwI1m2Hzku9VcIUUjevae3AJEMHJPCyrnCJS+BpPRhHX7smV8zKg1C2Q4ow1WJmxkJt81Az1bvgny25p3bYHYgQlEqbw872dP3unb7C19MnODDWWHJIheYiiPTkVH0ulQOsUr7l4aKJa36oUb+sIAyV+GiHhsOAZy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x9Av01/G9KxIwCtqw3nBjoZAKyuRh4p0kbdP87lkDU=;
 b=TsvGwtSLrxyW9xMhWZn/FEDQSKJ+C+fE2b5Tts/iX1xzQGqxkcobCKSoDhx0gGFUCPsg5CVDBho9BlWbxukscgJLMDOkamSjQVE3Ccdis1w9uxfzJvij10ooC74AlMivM8zFkdssQbtMPp9W5H04mJiLRwLP5ZQTcd9znDrSpsw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9953.eurprd04.prod.outlook.com (2603:10a6:800:1d7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 01:55:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:55:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Topic: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Index: AQHagKH8rJtU4c2iJkO96kz/KNcu/LFMSGMAgAAcLwA=
Date: Thu, 28 Mar 2024 01:55:19 +0000
Message-ID: <DU0PR04MB9417F5D5B7369623F7313921883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
 <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
In-Reply-To: <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9953:EE_
x-ms-office365-filtering-correlation-id: 6744b99d-5a8a-4f53-4a1e-08dc4eca1f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/EH6Pi5T2hvd+vGeQlokhOlKfbUsCDfscPUkgPrw1AJ9DzXCgkHoZ/x5tVJggYxBXeCsN2hzMNGLh1YthoHjPQ0GaygNPllFiohthD+oFCDeV2cvdTTEdzOz+FzFhzREiyrFH0NkzSNGRrqOnir1faecFavzLQoIQtPZeB6ivEggxmcbXNOB3mPJKumbpMgnrV8+zYswUbL5z1JYEZ+YOIN5F+Io830CPfd1iGijZLnlfM0E5yd+VmDu0ngVmt1aEmrZhO4k5ZOP/07nPczGYpKHzB/oEj3cmc8jLt0ydkKUfz0KDSghMPFpq4Q0R8if2EsDyDkSezPTQMFpBAW4l6n4KrI5aO+inmGLzMp4HMP5EDP7bDkPi2J7F0flIiXnou9lq74n0NCEI2ju245j25tYIj2NcAO/lnel5kOjssLQTmoB/82nQ+iTuPOgBkxqM90+9v9MPmOA9Sr+RXd3+vsVv76+jtnAj6+1FYAWl2h/VZRbNsa1UVVa2RT8adEMfnlEhYry9MIYwjehTfEmmlHUm1rZ0S12WvSa3Mi/HBliKvK++KejoBeyqJa6PtT1NQd9ZiNWZRiWah7DNMw2Kgu4vl+HhGgFtk64IA596RKPrOlY4xobwsxFtDrJq438kLsGLN5WICqi1/EUG71zZckSGpqjQW3YOhW5XLIXk5lQsqliDGkSJ2X+Pl/jNJwrOW94vAjS+mUprB4RdMH/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkRYNitWcDBmTVE3OWIxTlJlNk9sZitseFRpZm5KaWIrakRNcElKaXlIbHlW?=
 =?utf-8?B?USsyU201VG9ZVk9nZVJ6VUpxc3NtUktZdThiVVVoYWJIMFVJZVE4UXhIZE9w?=
 =?utf-8?B?R05BVjlpVUZ4UU9LbDRTclhJTmozTDlvWTZoZlRMWlJTRmRzNnZ2ZFF1SnB3?=
 =?utf-8?B?QkxuYVVES1IxZWJmTlZVNmlxN1FwY1A2M3oycmF4OTdoRjRoWnZhNVpmR2kx?=
 =?utf-8?B?alRPS3V3R24xUW1WeDFDc1ErQWkzd1NkanFneUtqMFZkUGpRUG9VUlIxSmhs?=
 =?utf-8?B?dkE2dzRQUjFpRVhVbTNoalhvTmJSSEJ5d2tWa3E5ZmtIckRzVExHcENBQS9l?=
 =?utf-8?B?Y1RNZk1GcTVQZWNzTlJUSE9vbVFYL25YLy92eXF0S0lzNWFSUGU0WFJBN1ZP?=
 =?utf-8?B?QUh0LzkvbXNacmhLM2dDVHIvbm9GRTBhcTU5WENnRzIvZFhFQkxFa1ErUHRL?=
 =?utf-8?B?L0VZNnUyMWIvM0NVZUkxS2VkV3h5Wk00em5RM3RmcTdrdy9nSXhTRkFmbUdp?=
 =?utf-8?B?M0REREJUOHJJVDVjTEEzRTMxNHdQZytHSFI2WGR6UzFVWXRadlZMWmk3SEJ0?=
 =?utf-8?B?U3k2VmNKMS9kMmxrUlNBZzNLTXNrL0xpcXpHRCs4eXpOY1lORHZpd2kzYjZu?=
 =?utf-8?B?Y1FGK1IvcXVJMHQ5d2UzYnpxVXRRQUM0VjI2OWhzc0Z0ZWFiQWJJY1hhYUhF?=
 =?utf-8?B?VURqUHdUS216c3hRdjV5ZjMwekR3Ujk5ZU5qb1Y2T2VISTYvR20ySURTMVBD?=
 =?utf-8?B?dEdWRW9DVkcxcHNlTW1RTFJCSWpmTzFiUUUyamVlMW1IRFdPMHA1QXJLb0M5?=
 =?utf-8?B?U1UzZ000amlncTVoM1pHbHF5RHZ6SjRocTFHV05FTHZMLzRCdE8rK1NTZDIx?=
 =?utf-8?B?R0FHaTdWVnBGUk9VK0cvU3poVTlVTEozM0ZQMmRSaFZVdUlCOWVSSjcvQ2FV?=
 =?utf-8?B?THRhYU5qTlBObktvODhqWFdTWFNRRDV1YUZkS1Z5d0VHcHdIS0RCbHA4Vm1w?=
 =?utf-8?B?TmJhaWR4M2NvbXowUExTODRuM3hYWHBHek9IZWZ4cVgvMkgzSXZQRjNQWkdy?=
 =?utf-8?B?NzFMY1l2ZUJ4RTBCT1dRa0JIbkswdkQwUUF6cklIK1lqMHFxakorMjZ3WUd2?=
 =?utf-8?B?VHJZOTFaNlNvOEtRZEUwREtaMDlKdmRWRGg1bDc5N3NRUGtzOEdKUFlEUnhi?=
 =?utf-8?B?d0gzblo2TGp6MkVqd0RoN3lubk9jRVptczJ0SkpvL095eTRIRnY4VkwzWmNY?=
 =?utf-8?B?UUN3SUtjVk04cEFxVi9jekY0T0hzTUJVU2ZnYWVMMncvbjJKSHhxSmhvMmpa?=
 =?utf-8?B?bHovRmRFREtyT1o2R3VYVnFzR3YzL0Myejg5SFkzczNuSHN1bG43L0xPSU1q?=
 =?utf-8?B?VksyYmRiVDRRMnhyaDZ0dWZWa1pmbUZRZlVIWUVRYms2UUNhcm9oVUlRVlJp?=
 =?utf-8?B?cHZnSGVhZjJJL1dnRDRKV0ZSR1IwNHlNMVA4djdWYXdZKysxV0RvQW9QVGJU?=
 =?utf-8?B?MU93UTZkOGJtS2toNmdhMDdGeDFTbUdOV3g5SXhjZURIU2V1NGhXYzlEUDlI?=
 =?utf-8?B?NDF6Q2plb3lQVm0zZ2wraWpBVjBTQm5lclR4YXA4RGwxWUFPN01aK3R2NTEy?=
 =?utf-8?B?VXBVTHJZTVdvNDdPZnhTbDQ1dFlxTVBQQXorUUtHM3IyMlJtVHppQkdXZlBw?=
 =?utf-8?B?cW8zTmJkMWlxeVlrZmttN3FDN0hWS0E2UmwrbDVnVUgvcE5iRWhmN2VycVF6?=
 =?utf-8?B?SUFJdTJMWUNZTHc3OERSelFlWm10cnNqdkttUGdzWVJvMEhnYWE4eW01ZjNt?=
 =?utf-8?B?czNCaDY2M1NpK3grN0tKOHBscUxNY3gyU1lKTThvZ1J0N1NraDFvcmNIbjVs?=
 =?utf-8?B?SnZrOUp0Yis0SGJIMEN5UTZ1eXpkRWFpNW9CaWszU3l5b1hvaHhSblNTbzlO?=
 =?utf-8?B?bDVQRUZmSGxzS1BVQktGS2NBeU5mN01uZytWZ2dpWk1IN0ZabDNxenB2OXdX?=
 =?utf-8?B?bEhUUWk5SVZ5bHpraHl5b3B2SFpDbkI3SEVMck9saVR0bWZzOHE1ODdBOGND?=
 =?utf-8?B?TXlSY3JKNXpVR1J1MnFnWitFbzhoZERaR0ZYSVVzd0o2Q2JMU1BvWTlDU1Fa?=
 =?utf-8?Q?uFXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6744b99d-5a8a-4f53-4a1e-08dc4eca1f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 01:55:19.2394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ahox0cxecX/mYXWt1h/MXxs/m+AHiFK/mHXtaH3pu++S3qO2kEMbJJMwovStyxkqFm1oGPb125Wxwx2zQc2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9953
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDYvNl0gaW14OiBpbXg5My0xMXgxMS1ldms6IGNvbnZl
cnQgdG8NCj4gT0ZfVVBTVFJFQU0NCj4gDQo+IE9uIFdlZCwgTWFyIDI3LCAyMDI0IGF0IDg6NTPi
gK9QTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiAN
Cj4gPiArJmxwaTJjMiB7DQo+ID4gKyAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgY2xvY2stZnJlcXVlbmN5ID0g
PDQwMDAwMD47DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAi
Ow0KPiA+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2xwaTJjMj47DQo+ID4gKyAgICAg
ICBwaW5jdHJsLTEgPSA8JnBpbmN0cmxfbHBpMmMyPjsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4gPiArDQo+ID4gKyAgICAgICBwbWljQDI1IHsNCj4gLi4uLg0KPiA+ICsgICAgICAg
YWRwNTU4NWdwaW86IGdwaW9AMzQgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFkcDU1ODUiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHgzND47DQo+ID4gKyAgICAg
ICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4gPiArICAgICAgICAgICAgICAgI2dwaW8tY2Vs
bHMgPSA8Mj47DQo+IA0KPiBQbGVhc2UgYWRkIGEgY29tbWVudCBzYXlpbmcgdGhlc2Ugbm9kZXMg
YXJlIGFscmVhZHkgYXZhaWxhYmxlIGluIDYuOS1yYzEuDQoNCkp1c3QgZ2F2ZSBhIGNoZWNrIG9u
IGxpbnV4LW5leHQvbWFzdGVyLCB0aGUgbm9kZXMgYXJlIG5vdCB0aGVyZS4NCg0KVGhhbmtzLA0K
UGVuZw0KPiANCj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLWlteC9pbXg5L0tjb25maWcNCj4gPiAr
KysgYi9hcmNoL2FybS9tYWNoLWlteC9pbXg5L0tjb25maWcNCj4gPiBAQCAtMzEsNiArMzEsNyBA
QCBjaG9pY2UNCj4gPiAgY29uZmlnIFRBUkdFVF9JTVg5M18xMVgxMV9FVksNCj4gPiAgICAgICAg
IGJvb2wgImlteDkzXzExeDExX2V2ayINCj4gPiAgICAgICAgIHNlbGVjdCBJTVg5Mw0KPiA+ICsg
ICAgICAgaW1wbHkgT0ZfVVBTVFJFQU0NCj4gDQo+IFN1bWl0IGFuZCBJIGFza2VkIHlvdSB0byBh
ZGQgT0ZfVVBTVFJFQU0gdG8gYWxsIGlteDkzIGJvYXJkcywgbm90IGp1c3QgdGhpcw0KPiBvbmUu
DQo+IA0KPiBQbGVhc2UgZG9uJ3QgaWdub3JlIHJldmlldyBjb21tZW50cy4NCg==
