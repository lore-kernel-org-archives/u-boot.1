Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A55BC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8518484942;
	Tue, 30 Jun 2026 10:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A5li8uxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F7B84A04; Tue, 30 Jun 2026 10:16:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE031848D2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdMOll0tdsVA4EwsiT8gpt3l+7p5+ESdYCuwP0qhasC5A/rCBH1Dp+F2shVPlSE5vNT+YjXl7XcM8Nr5vqgueXIsxhJSSyn9/0EWyu5zRC9W/qRt2OrGoAZjKMOsYCpLa0AeON++3kq26vZpnNoIOo/nqpXEbFBPalu1cd+OD29XV4J/KSOS4+oh1T/rG0/a20KKM/wp/KaDBgQ7fDcS4hK3ixm+5OWSOrvuuEiqpsKvD1in39v6YudYgiclyMezRgc80IWgISmBdvI5K7yBWORVM0xXYoTVte74kE4AmKZej5RT0zvYPj1r225kXoXdeb7LiQfMnrD3zsFXjzEAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIB9Qekv4C3Ja15VxaWT8yBJ+uPLWrqO1Uh0NcSDik4=;
 b=leVKionrUTp5pX8pIDLi1nwhqn/47jutiA3XlubEun2412ntsZNP1fjSO1/QBvzYPDmrEtilCpmTqcDht8SRPk1cemQQM9CBuzYlCoFKXIJ64S3A+kiC6ZwyyzSyWZP596CbuYvwUQm5eP/NOj37+7X3E6QzmNNNEonZewWUNNyCddQ6XOfTmYA0x2sHd20/UqwQwXxK3mwO+abU2FnW2STC4kYIG81sxg6yIMvymQp55Xpx3eH4EAnoZu7mzvy+aEzEUAhD5D94cIpM/nBulFDvjeXjE/eEIlNf/pGnkMIkSg9pfN9rZ1UbPtvr0d8/4wznzq7UWZcmKE8qBL+jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIB9Qekv4C3Ja15VxaWT8yBJ+uPLWrqO1Uh0NcSDik4=;
 b=A5li8uxVQw+fr1wlBcSZSrKv06BzOuEb0Yx0kxWpT2jHg345gSZhv4nAgWyVzxlfHuwe4dZsXTy0O2L5TZcuEbuA2OjoT5LqBQOZT8wOYZfLtCTQVIX5fVWCsD/cnFI3XTOWgOj+pDcSHYTqdzOxVGjWkT7tRDJqwUH1yRNWG2iClbYEG8jBe1RW2v3Fpdgq3sSufblqAZKrlNouPK69SIC4/lcDUrfIAJ9XQcufgiyRilwRanYc5is25ZtqpTOm7WMDYohxl3Yb6lNrz9Kg073aedqhHbJ4o3mlC0w7zRz2wea4Vg7n3HdLWdNSGO/RauztiAbE+BZxU6QyFNS2Ng==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 08:16:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 08:16:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Fabio Estevam <festevam@gmail.com>, Wang
 Jie <dave.wang@rock-chips.com>
CC: Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Kever Yang <kever.yang@rock-chips.com>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, Casey Connolly
 <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Stefano Babic <sbabic@nabladev.com>, Alice Guo
 <alice.guo@nxp.com>, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: RE: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
Thread-Topic: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
Thread-Index: AQHdARfSGGPec/XKP0OpJPDBv6fyL7ZWYwiAgABWZwCAABUaoA==
Date: Tue, 30 Jun 2026 08:16:46 +0000
Message-ID: <MRWPR04MB123305BC4FB40B7B6D083AED788F72@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <akMgh8AbN6BX9UlS@shlinux89>
 <a6dec76b-ed70-49a0-b7bf-affe1aa2f6e7@nabladev.com>
In-Reply-To: <a6dec76b-ed70-49a0-b7bf-affe1aa2f6e7@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PR3PR04MB7355:EE_
x-ms-office365-filtering-correlation-id: eedcc17d-ab6e-488f-2e80-08ded67feda0
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|376014|366016|1800799024|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: YaBYlZdY4wrJ1PnrJrmqVrHrYpvG1vntGbB1J0/DB32petOA/pSWEF0VG4t3kyrweNywMhMdBKj50u2GhrTKFLh3H9ppbTgaAkXfbkpC+MTINt5phmOulD/0LnP2cNs2fr5l3MyHVmpYCjjDZRFRMSEmHM9yarJ7EP2fqUl2o2lUkmypxYoqMpmFMif94o5CWvJe/jmq4J/OkkwoFiYLmyZgNFYYXsrMOHr7oCTS6wTlzNEb7eCROFi+yN7f8ts66QGtx0cQ0uAL1BiZBKSDoOsspWX9xcwDvyEjFOOTWyvU+6t8/3kLJaNvwugW0IFH88mYJyhu7I2tvRXDr/sxvri/mVwveKZjRbazasz3h/7uEhZOmM9Co3eaXVDsOnxDo04MqIIdXvhgQoYJ1LTGYdUNh4XOGyYWGscKTGSZmotQBKXt0Crp6jcEve/qE9uBGsC+mZt5zeEtdCP6AUhXhVM98SrWyA87CBgIW+o0qrOWirFwjFKPRKmxwFdR5h7wPb1cSoUPH8v79mbxRfa9wqtZcLuSnqV7djDcPj1MYtmf0Z9rnAmuYNZMJ9+23jsjVlJT5AQRnl4AauYw1XFmCarSxwc3M74OFAwWNZKwZWdfUUDfvu2WCqHYUuXlcdubqg+23KVFfBfAVTzC7Amy1G0UzgzAeQl+PzDHP8MCXRdk3PsMEFXcx5NE5g2sDLneQn0O2SrHFduPMziAWJt7OZcr8/YRLnW/awmNDXwFjGE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdSeWNsZmdyU1YyaWRjc2thUlZSeUtFSTJUR3lJZVAzelpRRVJWUDZCbWxI?=
 =?utf-8?B?djdVNG9RZ0hPaFdwdzVKTHpLV25CT3YrMTQ1TGdOdXZZTm5nYU52d2lXSnp2?=
 =?utf-8?B?K0doR2dSVTdIdmdGZmhhaVhaZnA2MTNkVUxFdmlQZmgyMzZnaTZvMjdPQUtW?=
 =?utf-8?B?U2tnTHVsQlhrR1hNb3NlVGtDZWVtMUVMU0Z6dlVudjFsQzVYbDRZdlVDRkVE?=
 =?utf-8?B?dmF5U0FRN2tmS3VwcTJ6WnhBNzJQWlI1eTZyYjNQQXNleW5URjVmc1BDdnZu?=
 =?utf-8?B?b2FoclFmRkNuUCs3dlVGMnFGSCtGYk9Ba1JqRnRwWFRNWnlKb2szcmxEWDVl?=
 =?utf-8?B?SlorN29JSkF3cTBLcnFWZjRQMW5OTHhvNkh1OUZmSkozWlNFUlpOaXBudHRZ?=
 =?utf-8?B?NU0zUUtjbURLejF4TUtqMXI3YVFCSlB5ZktWS3VOM3ZDeHNuV2pwem5YdXpS?=
 =?utf-8?B?dHJaaWt1d3lKdzVOQzlJWWtoZEt6MjlSdW45RDhOd0gvUTRUSHpUYy9RdXMw?=
 =?utf-8?B?UkpVVXBxclVvckxYcWZtMVg1cjBsNEFaMktjdjBEcDlwZWJjZ29iNXVyRGJP?=
 =?utf-8?B?cjBWSDVnRWUrS1pVOG1kVmNscmdhcHBrYzhlL0w2eS9CeERoUGRteDk4bWJx?=
 =?utf-8?B?UTV0ZEdEQm5xS2Z0aW9ocGNobjNrbEJBT3VxNTNxdk1DT051Wis2RzgyWG9y?=
 =?utf-8?B?YWRTYTY4elJNVzJWZU1XRjRwbldmdDZUNUJucDI1Rm5STGVhQk81QUY5NmRK?=
 =?utf-8?B?cTlhUlhmOVF1THJjK2psMWhDMWVFaldqTnIrZ2hqMldGK2trMU40eXlkNG53?=
 =?utf-8?B?aGxTZXpiNGhOb3gxOWdiQzlEb2NYSGhVNlJKaHFhakpmaG5FOHhzR3U1eHh3?=
 =?utf-8?B?a1R0STRNQTdUeXEzWTNWMHpmMUhLcURFbERGbXd1SDBJNVBKRmlRQlZySDhJ?=
 =?utf-8?B?a2VzWGlxK0x1b3lheWcyUTB3TXE3TkwxdWFNSGR1eTlGWUdtSU9wZnBoZUY4?=
 =?utf-8?B?elV4SzRoTFJrRXRCaW82d0RuUE1mNG11RUFBaXVQak5wQ1owZVd5dGFBZ1JM?=
 =?utf-8?B?K1lFdnQyRmo5b29KNUVSd08xZFlrenZjTVpUbmZ0Y3h0dlhDNW52dys4Yy94?=
 =?utf-8?B?aHNKOFNDMDd6b0lBRnVHYkdUR1cyRVYvcDN3ZktJcVluOFlScWp3ZUIxWHpy?=
 =?utf-8?B?akNEUU83YWw5Njd2QzgyWElGQnI3b2gyaVNNSzJrZWhZeDgyTUNFQlJNRlQv?=
 =?utf-8?B?U2Z3NWVYK0wvcS9RS3dLRVBGM01MNFpnYUJ0aDVuMXVYR29BbFB1cFM0MS9B?=
 =?utf-8?B?L2FTNHl3MEdjc0U0c3h0TElkREhvSnFHODlvemFSRUl6Q1ZESTJXK1RjY2NX?=
 =?utf-8?B?bDlkQUUzcThjQVRRL3ZvcTdlcXpUZ0ZMNE5iMDlMNmNFWjg1QmhzM0hvUDZs?=
 =?utf-8?B?Wm55NjRGdjl3clBGVExhV0lzWHhzYmgvZ0FrdldhbVNJOC9Valh2L1NRb0hD?=
 =?utf-8?B?YWJWanUvRzhnWWlVR0hmc0Q0RzFMdU9LQ0Ivb1NIOGFsNG4yMXg4WFM4bmZX?=
 =?utf-8?B?TVpnb05qRC9PRmZpS0U2V0dXV05mVGVXeTdXQmV6Y0RDaWRiSVg4d1hBcXp2?=
 =?utf-8?B?RkdpZVVWSllxNnVwbW1GZnI1anN6VTBhUmE1N3M3emFWNDJqekxsc2VaVytF?=
 =?utf-8?B?YXFQekc1V000czhVKy9iem9lNG12akJPOTZNLzc1ellNNExkYzlzcHcwL3JL?=
 =?utf-8?B?cDhMZS9Mb2dFdXZLRERsWjhkMHNTTm1INWl2TXZ3YkFBMHBJWDZkZHdiQ0tD?=
 =?utf-8?B?azVNOS9ucS8vQzI1UFRVSU9PR3RNTjNwRnVBQXpILzhzTlU1VWVHVytoQU1C?=
 =?utf-8?B?VnhjT1VtcGdKVyt2SThjVXVkenV0b2gvVXNZVVZ2UFAwU08vWmNYK1RIK3U3?=
 =?utf-8?B?OW42Q1BLZ21tVXNPWm1td0dKWUpMR2Q5NnVPMVZPZCtNd2owOEVsN2VuaUdo?=
 =?utf-8?B?Q1pzVWpDY0g0Vk4wek5icFFnN1F2L0hGKy9zbStEZHdYdTdqOXhFOGpocExj?=
 =?utf-8?B?d2pSenc3YlVIY3dwWHRuOXN4S0I1cGJieVM3dGVVbUU4YnpqSUU2cXdWaVpX?=
 =?utf-8?B?d0ErQ24zNEZUVnBsUFNnRlhxUDZvbnpJeVdkQkFRMWJsRGEwMW04T1d4Y3p0?=
 =?utf-8?B?TDA5aEpnam5RS3VPRXc1dEtmaVFUUnRKMzRkM3FpT0NCQ2NpZ3ZHb1FDZHJs?=
 =?utf-8?B?TSs3QUQrZTF1cXI5VkdCUW1KS2lZMWQ2S2FPK1lTUURSYkJxSzA1S3lnUHI3?=
 =?utf-8?Q?qvKDmzw6CpMRAPo+aF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedcc17d-ab6e-488f-2e80-08ded67feda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:16:46.8668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo4kQT/Nt3KJpp8Fxag07gwlk8LwacYj3+zAb/TxZqTHJS1JQ4ccGXjxh7hU57H3bylAQiGc1CCm8a7cUMJQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzEwXSB1c2I6IEFkZCBUQ1BDSSBkcml2ZXIgYW5k
IERXQzMgT1RHDQo+IGR1YWwtcm9sZSBzdXBwb3J0DQo+IA0KPiBPbiA2LzMwLzI2IDM6NDggQU0s
IFBlbmcgRmFuIHdyb3RlOg0KPiANCj4gSGVsbG8gUGVuZywNCj4gDQo+ID4gRG8geW91IGhhdmUg
dGltZSB0byBnaXZlIGEgbG9vayBhdCB0aGlzIHNlcmllcz8NCj4gDQo+IE5vLCBzb3JyeSwgSSBh
bSByZWNlbnRseSBlbnRpcmVseSBvdmVyd2hlbG1lZCBieSBlbWFpbHMgYW5kIG15DQo+IGJhY2ts
b2cgb25seSBncm93cy4gRGlkIFNlYmFzdGlhbi9Kb25hcyBwcm92aWRlIGFueSBmZWVkYmFjayBv
biB0aGUNCj4gVENQTSBwYXJ0Pw0KDQpOb3QgeWV0LiBJIGhhdmUgb3RoZXIgcGFydHMgZGVwZW5k
aW5nIG9uIHRoaXMgcGF0Y2ggc2V0LCBzbyBob3BlIHRoZXJlDQphcmUgYW55IGZlZWRiYWNrcyBh
bmQgd2UgY291bGQgbW92ZSBmb3J3YXJkLg0KDQpUaGFua3MNClBlbmcNCg0K
