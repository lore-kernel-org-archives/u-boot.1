Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A09C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B3F807FB;
	Thu, 27 Feb 2025 03:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Y9+uQXnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC3580FB6; Thu, 27 Feb 2025 03:25:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39F48006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fia9KB/4zs+N9qnKKoRcAcnshrIZdBH0f0hbDVEjetbbf37DZyk7keAyWEp0S2dszvSBdwpffeIZJrsUwxRV68YE5+4sbIu9yV6uRJ5lh8EjSpdAza9rU8Drs1Z+5xLphWpPj8gRzBzEqKM4k4Yb5g4VrXuv7ehOJSTdkiy2d2jW3Q/7kjpTQXROLVhuWGhD8r/wuFD4VAtlJw8oTNI5XdXN7Y8zwIVPvF6Hh9nSh2u/JThB3SkA/ZZLCnIByDSLcGpfc7fTQNR6mJmRD4itFjQzs/8JWf6GuNPctgmFxlY3Sryh5mhx2aLzjLpsbcZzmBkxvNeINqB3J+cem2vGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/bUKonQfXPKFhNaMZVI6TbE47x94rhJz0wUdGo0hMI=;
 b=vV8xAnYWEbO0se1MhBSCMpTsYXuFA+Hv7uatGh8QiwyGYziEfnwm61a4zrO8K2QdV3ZYcDFYeWE8oVT09nJtOOZaHUQ+J7IWlFFimoPAQr2vny9TH1bWb6Qnu5fYb45Q39ex7NkNG/CR76MGbsW0lKS611v4OC16qrI82J1BvS9s/CBfm6wBVflJSO47mafLs5BwZqjhLsg4RryUMrl12W8ZL6QnE+2tjAm3ScHRfd/9WSoxqTgU3SGpLcSicLuXbvcuu5efkp+oMnqAhqVhw0Pox4blkxzNFMLpFnCRIGJoOzpp41uUfB2ywZD5f4Ak4TGmYYysMEJJD9kPFHiDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/bUKonQfXPKFhNaMZVI6TbE47x94rhJz0wUdGo0hMI=;
 b=Y9+uQXnExLB0GgqYDcY+0dBkuXpyaYozSXIHL+9nNwf3f4xHUlm/udCwF0XS+4W9L0F8Aj2jvH94Xhx+PK7s+3BeCXcoR+p5Y4k9xN7cngqYIu6gy9UeaUkWVPfWTOZdfjGBUN4ZHACgre3RsiNSAcrQWV+u6Tmwiqu4kINqRXrxuZgxy8TIEtEv6nIhvO6yumXcxu/peRMC7u0adHBLGW3DWg91phcU4O/3ko38WKdXgd1GVRqObHTgUJETJpr6fL5wXG19mY/uWCf1u6fJ+CmsYOBIpSSmUhI4Hq6hODhpr3oXgj7vyHLJuSRUKWbOrkSQravIVTXq6SkaSmSoyw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 02:25:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 02:25:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Andre Przywara <andre.przywara@arm.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 =?utf-8?B?S3ViYSBTemN6b2RyennFhHNraQ==?= <kuba@szczodrzynski.pl>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>
Subject: RE: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Thread-Topic: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Thread-Index: AQHbiELPNTu8NZZ4TUitLdDXwJQu47NaTTCAgAAfeACAAABjgA==
Date: Thu, 27 Feb 2025 02:25:19 +0000
Message-ID: <PAXPR04MB8459670D2B79385D7580F75A88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-2-andre.przywara@arm.com>
 <PAXPR04MB8459D3EB1E61A160A2C2D78188CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250227022330.GR2640854@bill-the-cat>
In-Reply-To: <20250227022330.GR2640854@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7724:EE_
x-ms-office365-filtering-correlation-id: 25c62228-6136-44be-15aa-08dd56d5fb43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MDA4ZS9LYUdqNlJsQy9ndjNxWlQ1ek5SNGp5VWIzbzgxZUZRZFZBY2NQZkpB?=
 =?utf-8?B?Z0RDK1U3VmlhYnZYMEJmeGlJYzhkaXJwWmI0OFpjRG42YTI0djI3aFdnWVJq?=
 =?utf-8?B?dEpmazdTSTR4VE9yMXhzekh2c09qK1BNMTNBd3Z1alVocjZPNGRHWVpnODJ4?=
 =?utf-8?B?bkczM09obmNENmpuOFV6QTZ2WUtOU0t2Vk5zT1pxU2w1eXEvTmE3MVd5Wk5Y?=
 =?utf-8?B?SXNacEtBWU56SVVYSVZRVFlQOHgvR2p2L3QxUUtsNTZucFdFY0hVQ0ZGQ1gy?=
 =?utf-8?B?M2dPc1QzcEtjVGwvMXErUmpDYjN5ZGtiaTZnVHo5VDJ5RXY1Mk16S05FSVZU?=
 =?utf-8?B?WWo1SFV4MENIQTNyclV5YTB6Z0dFMElLRnN1bmxLUitCSjFSSzd5ckx1MG5M?=
 =?utf-8?B?T3ZQQzRmMkFydGNaRVdsQ3ExOUljTGY2M2JuRE1zQXRDcmJYWTBYZ04zdFF4?=
 =?utf-8?B?TFo4MVRLSXFnUUZ0aVZia2xOdDczQWltbW9QUGM2V3hlTlROWHNCeWhrS1ds?=
 =?utf-8?B?V3N0LzRMeHFHZ0oxZ2JyNFVLYVZRWWg5NHZNMnJVNVFETml3ZWVNUE00c3VE?=
 =?utf-8?B?bDZjYTZQRXZQWnFhclArZGpodDNiSDRGM0tWa2hKWG1CWWd0SFFIZUFkOFd2?=
 =?utf-8?B?cXNJanZjdCtVczF4ZVZUQWRCMUdDRGt5Q2dRKzl0SXFWSHRwd1h6MndXMWdO?=
 =?utf-8?B?OUR5c1BqWWc3d2drbzJBcGlXUUVmM0x0bG5zRXg2eGpvbDNld0lOT283VE12?=
 =?utf-8?B?dEU1TUlJV3I3Zm5lOFBvbG83QnJueEhkcWdTUWZWSTVoS2xSaGpVdG1ubGlB?=
 =?utf-8?B?alZiWnhHcmJGTzJPVGlCQUk5Z3JUL1J2dldzcS9RbEhkcUN5Mm1Ma2hrN1lO?=
 =?utf-8?B?eUM3SjhyZFJmbytGR2JwMnN1cFNJbFRGcWFpUVZDU2xGOWNXdHVhRnQ3SXg3?=
 =?utf-8?B?Q1JZaWNCaGZ4dHF0bGZMcm5LamIweUdsd0w5Z1JUTWtPbTdkem5uUFEzdUJr?=
 =?utf-8?B?c0xTQ2M4ME52QnlMNHd5bXhKbjdlL1JwZ284Qi9tR0JHQzl3R2JoWjJjcUky?=
 =?utf-8?B?dlZsSVdlbENHckxvMHppQTZmMlZQUUgzMGwxeTZLcE1CakJwQjBmZ1RWVXRW?=
 =?utf-8?B?V3dCSXY3dkZac0FSMjYzbVAwc3dESGdXMTl3SWIvaURuUHpEcWlEMUlNTHlU?=
 =?utf-8?B?NXRaTXFXRjNLMzVqblBmOHVSKzhCakV0QjN6ZDR2ZDBTR1lRaHN0RmV0Zlcv?=
 =?utf-8?B?V0tpVWYzREJXYW9ITlI5OUNuUWhRaVFTcE13UHJwUFJCSmFVcVRLbkhBZzFz?=
 =?utf-8?B?T3U3QXpCU2dGOVM5OFN1cEhtZ1ZWTGhOZlZMV2dmWmdVeEwwVzRWUDQ3OXh4?=
 =?utf-8?B?dkRoeG5TenV0WHFXNytoSVg4bjhpYkhMcm03MHlhNnc5eUUwZ1FDV29lckU1?=
 =?utf-8?B?aUpHM202VjlJMmhZOU1nUTVnclhIcFAwR3RlSi93RlozU0FnbERjSHREVzBx?=
 =?utf-8?B?QTFsektseVROWERzV2xIMDlMTFZyK3RZNWxsbkl5K21DNTJncnY1bnZtbHNU?=
 =?utf-8?B?VWZFclpkVGwvNFYxV3JJVy8zcm9YSno4QlRmTFgrS1VTc1k4TFErenBleGJX?=
 =?utf-8?B?K0ZaM011REt4RXg4VDRBMzlVTDFhU2QzTWJjanZkYjdnV3pvUFdtZngrbTVF?=
 =?utf-8?B?bW82UTJ1T2lEY1d5YVgxOXVYanVnQnZwNUt3Y1NDSlp1RnF2b1lZdUNvZWxH?=
 =?utf-8?B?eEN0RlFPNjg3VEp3aXBLcVhVR0x1NnlmOHFUWmhONTJEdzdOQjVxd3lPcHdI?=
 =?utf-8?B?Z2w2QXpqTU1UdksvbGtLeGF0dURqSDNiQjhOeGZ1TGtnU29IdkNwNldOR0hu?=
 =?utf-8?B?WVgyb0hlUkZqY1dRZWw5Qnh5MG9aaEZoL3NocWFiOWcwZ3g5cE9EY0Zvd084?=
 =?utf-8?Q?2ZYCVxHVJtGmThDV4H2JrUVaTl4uHcSS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDVkaWgzZXNlSy82MHREeHVvL24zTytjbzJRTCtyYWpNdnVmQzA2V3JZeEow?=
 =?utf-8?B?WmxqTFdTRzhOSmE3Wks5SlpyVFpoMWZ2aWlYQkovdHlwTGd3QmhRdU13TGps?=
 =?utf-8?B?Y2ZJcFhFZXorZHNMUmdEMUhybjVtVzN2a1NMcTJ5bk1hQWJvNUNJVjIzYWdo?=
 =?utf-8?B?a2F6L2huYjBFZHFWcTZxKzFVR0RWa0RqUGhPQWNpMGVjSk1oQU5zTEhpUVls?=
 =?utf-8?B?c3E2ZkRHSnRTVm5oOHpmMTZHUnJmYVBYUVpPR25BaUR2Z1JSeklGenkzUnFI?=
 =?utf-8?B?VlFETGFuVU9BNGxWbU9GcUdtSm4vL1FaYnNaclUxcGJhV1RTNm9lbjVpN1ov?=
 =?utf-8?B?MTYwRzJBUVNBRUZSUDQrOVloWUJEcjRORkVsZ1QrSk9ub0FLUGFvWFRKRDFC?=
 =?utf-8?B?Tkw4eDZxbzRpcVY1TmRVdW5VOG1vUEtNOFZ6N2ZvSXJyQjNBdFNxT2pkMlp4?=
 =?utf-8?B?K0I2MG9ya2k4UjZSdm1ONHkzR1NoaDFUUTIwRHRKdlRqMWpxQXZFL1ZMK3pF?=
 =?utf-8?B?SnJPd0R0Slhxbzd3eVJKSGJNamxKTVV6NG1idkNoaVhhKzdvSXRRNldqV2tk?=
 =?utf-8?B?UktHdEFoc0IrWm9aTUUrdElMNEJqRkM4OElRU3lYYUtNUWtIVlY1bER1U3M4?=
 =?utf-8?B?MjBWUmI5aWhabHBlNFhuTXB0ZWNqZStHeU9tbVlJZDRxaUVEK0V6SHdzcEJD?=
 =?utf-8?B?cllKcW4xMk8xOStqdEZhSTRmYnJISVNzSzBTa2s0RnZnVFFTVnoxaWdEYzB0?=
 =?utf-8?B?UG1RVGZVeUR6WWdTNW5RWHNyOXlEUERSTzl6anZIWktYMm83Z1JGNmdROE5I?=
 =?utf-8?B?cVhYR29XU2pBZ0ZoMGZEeGdGTUI3angzTXRDZ0tUWnJ5ZG56Qll1V3BudXIw?=
 =?utf-8?B?UWplc1Z2anRFNUlYUTVCeTF4U3VBRXhhSExLdW8rL0M1YmNieUdjelZCV2V1?=
 =?utf-8?B?R2tTei9JcjV2N0dnU3JHNndnVlEyb2RKeHlmam5sSk1FWEtGL3NralJSWUJU?=
 =?utf-8?B?U05LRGhBWXhUUHZpOWtqUVJxQjdSOUMzcXpZK2hFUXJIUlY3RWJqZHpVbDZO?=
 =?utf-8?B?MEFwTVdTVVZwaWdOY3RKZHhJRlIxRGVNMGx5Y00zQkRkY3ArbEZqdkc1OXVV?=
 =?utf-8?B?SjVWd0ZuNGxSZm5lbDh4RDcrVERHWVhvaytsK0VER243WFN0YUdGVCtaRVc3?=
 =?utf-8?B?Ykh2Y2Vvbk41ZUI0eVMvL29XdnEzZjZmVnVVSURTbzlBSmlyUmtHZlhpL3Vn?=
 =?utf-8?B?UG1hZ2lFS2dYbWZHa3pnQ2Rtc3JBald4WmFFc1g0d3QzUkNoSG1FL2RiN3Ey?=
 =?utf-8?B?aVNOaU5TRFRMSjJpQ1lEVWdPVFdsM3FDR21jT2hyTncvcGczUTlscEsrZE1M?=
 =?utf-8?B?WGFXb0psTDBpbXZKN2lRbmk4Tlp4c2FVdTU3V25PckxsSWljSS9wQXN3L1Jo?=
 =?utf-8?B?dGdlRjdCZHduNklEajU4WHRVWVAwRS9abm9ESmh1RTd1blpBdnhGZ3c1OXBt?=
 =?utf-8?B?TGlTcVlZcmw5RGhQQzduMzVJWisyR281RFdXV1I2Z1d0bUtlWEpqTEQydWlJ?=
 =?utf-8?B?NFZyQmJoMWllZUxMUzZrOFVSYjFCcnNhVWUyUVQzdllxRWhlVFVEbkc3SHdp?=
 =?utf-8?B?VmtxYjgzMDMwMGtUOFo1WWJPWnhScFNJMWpaa1R1aVU4QTZhaWlrVEdpUHpQ?=
 =?utf-8?B?UFRad3VhQmhWQzZlQlRsRktPakVkbjVvL3hSRm1IcWVuN05kVG1zQndxeFk3?=
 =?utf-8?B?MjJwQVRZRHNmMTlTRWFIdTBzZGFId0J3VENLbkpLOTViTzJyaDdNN0NxSVlG?=
 =?utf-8?B?YU8rMERFZjNBMEVkN3ZyWkw4Q1c2dTFMV3Q0eTV0WjF0U0sxTGhZZVlMdWRr?=
 =?utf-8?B?Rm5FM0xPN1YwUDhlMzdjZGtIRm85ZjIvRGgxMEphRUltSVRhOVJrRzFwRmhF?=
 =?utf-8?B?VHhRU3dGdjJ1OG14L3N5NEhzT2FmbUFHZzdjYThRSVNGWVVSMVFnMUpKNjlG?=
 =?utf-8?B?Y1VsbFM4bll0bm1BTUFHOEhOSGRTZEVaakZLQngveURhbmNudi9VbnhXY3JX?=
 =?utf-8?B?NUVDRnpGd2lVTlNNWHFqOW9sVDkvL085aVZzanJyQ1BMOUFQQzJkdkI3M1JS?=
 =?utf-8?Q?bjCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c62228-6136-44be-15aa-08dd56d5fb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 02:25:19.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOLGgseXoxY1p/fNXDUL2R9jpX/1YeIMy1AFJI9QqMGT9GP+WWwMcwCyZ/2E/cOiCnBXFAlab/oDbPNQOlhXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gc3VueGk6IG1tYzogRml4IFQxMTMtczMgTU1DIGNs
b2NrIGRpdmlkZXINCj4gDQo+IE9uIFRodSwgRmViIDI3LCAyMDI1IGF0IDEyOjMxOjU5QU0gKzAw
MDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IEhpIEFuZHJlLA0KPiA+DQo+ID4gPiBTdWJqZWN0OiBb
UEFUQ0ggMS8yXSBzdW54aTogbW1jOiBGaXggVDExMy1zMyBNTUMgY2xvY2sgZGl2aWRlcg0KPiA+
ID4NCj4gPiA+IE9uIHRoZSBBbGx3aW5uZXIgRDEvUjUyOC9UMTEzLXMzIFNvQ3MgdGhlIE1NQyBj
bG9jayBzb3VyY2UNCj4gc2VsZWN0ZWQNCj4gPiA+IGJ5IG11eCB2YWx1ZSAxIGlzIFBMTF9QRVJJ
UEgwKDF4KSwgbm90ICgyeCksIGFzIGluIHRoZSBvdGhlciBTb0NzLg0KPiA+ID4gQnV0IHdlIGhh
dmUgc3RpbGwgdGhlIGhpZGRlbiBkaXZpc29yIG9mIDIgaW4gdGhlIE1NQyBtb2QgY2xvY2ssIHNv
DQo+ID4gPiBuZWVkIHRvIGV4cGxpY2l0bHkgY29tcGVuc2F0ZSBmb3IgdGhhdCBvbiB0aG9zZSBT
b0NzLg0KPiA+ID4NCj4gPiA+IFRoaXMgbGVhZHMgdG8gdGhlIGFjdHVhbGx5IHByb2dyYW1tZWQg
Y2xvY2sgcmF0ZSB0byBiZSBkb3VibGUNCj4gPiA+IGNvbXBhcmVkIHRvIGJlZm9yZSwgd2hpY2gg
aW5jcmVhc2VzIHRoZSBNTUMgcGVyZm9ybWFuY2Ugb24NCj4gdGhvc2UNCj4gPiA+IFNvQ3MuDQo+
ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJh
QGFybS5jb20+DQo+ID4gPiBSZXBvcnRlZC1ieTogS3ViYSBTemN6b2RyennFhHNraSA8a3ViYUBz
emN6b2Ryenluc2tpLnBsPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tbWMvc3VueGlfbW1j
LmMgfCA3ICsrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL3N1bnhpX21tYy5jIGIvZHJpdmVy
cy9tbWMvc3VueGlfbW1jLmMNCj4gaW5kZXgNCj4gPiA+IDBiNTZkMTQwNWJlLi44ZjcyZDc1OGU0
NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbW1jL3N1bnhpX21tYy5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL21tYy9zdW54aV9tbWMuYw0KPiA+ID4gQEAgLTkyLDYgKzkyLDEzIEBAIHN0YXRp
YyBpbnQgbW1jX3NldF9tb2RfY2xrKHN0cnVjdA0KPiBzdW54aV9tbWNfcHJpdg0KPiA+ID4gKnBy
aXYsIHVuc2lnbmVkIGludCBoeikNCj4gPiA+ICAJCXBsbCA9IENDTV9NTUNfQ1RSTF9QTEw2Ow0K
PiA+ID4gIAkJcGxsX2h6ID0gY2xvY2tfZ2V0X3BsbDYoKTsNCj4gPiA+ICAjZW5kaWYNCj4gPiA+
ICsJCS8qDQo+ID4gPiArCQkgKiBPbiB0aGUgRDEvUjUyOC9UMTEzIG11eCBzb3VyY2UgMSByZWZl
cnMgdG8NCj4gPiA+IFBMTF9QRVJJUEgwKDF4KSwNCj4gPiA+ICsJCSAqIGxpa2UgZm9yIHRoZSBv
bGRlciBTb0NzLiBIb3dldmVyIHdlIHN0aWxsIGhhdmUgdGhlDQo+ID4gPiBoaWRkZW4NCj4gPiA+
ICsJCSAqIGRpdmlkZXIgb2YgMngsIHNvIGNvbXBlbnNhdGUgZm9yIHRoYXQgaGVyZS4NCj4gPiA+
ICsJCSAqLw0KPiA+ID4gKwkJaWYgKElTX0VOQUJMRUQoQ09ORklHX01BQ0hfU1VOOElfUjUyOCkp
DQo+ID4NCj4gPiBVc2UgQ09ORklHX0lTX0VOQUJMRUQoTUFDSF9TVU44SV9SNTI4KT8NCj4gDQo+
IE5vLCBlaXRoZXIgaXMgZmluZSwgSVNfRU5BQkxFRChDT05GSUdfRk9PKSBpcyBsZXNzIGNvbmZ1
c2luZyBmb3IgdGhlDQo+IGNhc2Ugd2hlcmUgdGhlcmUncyBuZXZlciBhIENPTkZJR194UExfRk9P
Lg0KDQpJIHNlZS4NCg0KUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
DQo+IA0KPiAtLQ0KPiBUb20NCg==
