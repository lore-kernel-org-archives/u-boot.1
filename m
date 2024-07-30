Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB924C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1916088356;
	Tue, 30 Jul 2024 09:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JRUeuEB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9427B87F51; Tue, 30 Jul 2024 09:43:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D28B88356
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydw8p0ASeedDI/r+svB9qDxqZpISdKyMbyS5WWDlYBZu6uv2C02iCrGcL6dnzHMRw9rpZIfU3MJsgSdFamTuTFVTBN8UKVaDdVlWAy2hmnqzdmz+V9JRcjMUGyJVauTjMFXGPnXJ7sm81Wz/8nrczyyfRpHI27nclA9g87mfPlJ767ikQ/8WmsRHDD/nk7ECCSwJeO2P6Nw/lDdn4jMMPAoXA9OFEl/ZsGuIa/Gm2p6GE9iZIC/KCxYmV8XKq6ai7eJ68ow3u+0wZeFP96pXj/1bM2euLlOI4kycoFM8W6vxCwEREH1hVR5snmZbXvHo97azMPbbMOdyy8VBIALrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBZojlcFZia6z5VviazUvR+Nrw6vvHGuYlHx/HDJvuE=;
 b=tnyrd4w42R+ObmMC6/uCzEzjbpEBl5PSCP9mtM2tLBGV3haHRoHfOnXymYQnZuJG89g7RxCQ9RhkZLuFbZpzwYVD3WKzZMTFYxJI5AgEe/gPh1m7e5rQfg1nLL9seRt8FdWyklisoojTqPcjfGlSoAdepww04i11XD8Kg+AnKct91DH357gXSvAeyM5aQVPMCqZwr0pX7jRuc96EfVhGFO5CD1IpUCYlHT5+N1AmV6y81ftZmy+L0pnHCUVWZmtNfxCVvRgYE7rzNeZ/su8tZJAcI1x0dKJ7wNCqpS9P4+/n1pzki2kVqWPkApqWYTtTbIG5hywvcOYSj/BWs0fImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBZojlcFZia6z5VviazUvR+Nrw6vvHGuYlHx/HDJvuE=;
 b=JRUeuEB51U2spU42ydhAf4728EgAPX3zuJoyI+XF4veN1NKt7i9DLOE610lfd5ZmfxRJHB1I3lHIym4f7TY4y5lz/qxuefOS3UyAhs1zMe8afcEUJXJ5Dj6iASkjvAwRyeY0cUz/GLxhDm/n/OWzJoDAw7xvXmiZaZE5gLd+LNx4aDNTzAwelCQ1PHhcot20+F3nWUZzAQcM7hcqSAsACEZetePtJkrybQoI4U6cdmE9cfh6+XcEFVbu1ukq2A5N5BSZ5BooOEpV3mJlC8OurDQmCcZ5wdRq3ByJZ1uBgbDZqsPFcNscIc4hI6aDAB4LZpvxLV5vya+C6WglhvE/Jg==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM7PR04MB6838.eurprd04.prod.outlook.com (2603:10a6:20b:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:43:04 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:43:04 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, "marex@denx.de"
 <marex@denx.de>, "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCHv4 01/14] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv4 01/14] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa4k9wBIBwVKWr7kyb6QYDHprlObIO2uWAgAAGsiA=
Date: Tue, 30 Jul 2024 07:43:04 +0000
Message-ID: <DB9PR04MB92369D192CACC82E096CC03084B02@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-2-Zhiqiang.Hou@nxp.com>
 <CAOf5uwk4CMFphnskngXierUoZLwR6deMw+MDa98Xco6GJ=Rf+A@mail.gmail.com>
In-Reply-To: <CAOf5uwk4CMFphnskngXierUoZLwR6deMw+MDa98Xco6GJ=Rf+A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AM7PR04MB6838:EE_
x-ms-office365-filtering-correlation-id: 3448e472-cad6-4bed-1ea9-08dcb06b3f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U29YSXgxOFJPR1oyeGhqK21RUHhBQU03dHZoazJhclA3V21UbGlUUHBSY3I2?=
 =?utf-8?B?R3lQRkgzV1ZCY2VWWVJaSTFjVlp0OTEyYXI3VEk0MkM5cThTeE0wMU11OTVz?=
 =?utf-8?B?OWFsQ0pmbzg2WHkzdjUwVEFvTXpRZWVIVHZLY1ZLejJXYUx0a2YySlN6d1c0?=
 =?utf-8?B?YWNZOUdCelJnZ04xSktWK2NkZHZ1dnNiS05abloyTVZaVUhJQ2g4V0JnenpP?=
 =?utf-8?B?a25QcHlvUU1WSlAxMkFVRXJtZVJDRjl5Rm90TmNMZ1Y1a25UOTliNHV6M2JM?=
 =?utf-8?B?b2FkUE1XbWVveUp2M3dyZlJjeGMwc1lGSGxVaGYrNmJ6eWhnanF3YWlqeTBR?=
 =?utf-8?B?dmIrZ002OG5BWGdDOFVpMnNQNU4raXpXekp4WGNBbVJrZHczTXhQWmxZOFN2?=
 =?utf-8?B?VUx0c21WUkx0c1NXNnNMYmpRR0R6a2Qzb09pY09GYlRXaXZrVUd3QTh3aHhT?=
 =?utf-8?B?MndIVHJvSHJhV0k3R25QS1hZZExZbFZaWWl4RWhqMmhNbE41QUlxRUJDUG9P?=
 =?utf-8?B?aEtWOFZkK2pHSlN0SFN6YjVQeUJ0RTVwTlpaNXdFTEVjT1hmbHB3bVBrcVpC?=
 =?utf-8?B?S1BjcGNsSWRBV29LeU1GMGpoVnJqY3ZZREx0czRLNDNCNThrdUhMSzl1dFpK?=
 =?utf-8?B?dHdzWGdNQjJRdXpaM0hwTGs3cGIvWjdjSTUyT21EZHI1RlE5SWtHNFc1MFQv?=
 =?utf-8?B?TUxvKytDdmJZUmd0MG1jSW9OQjNZK1VFUDYxSHA3SUcrdGJPUEwrcFIxTExl?=
 =?utf-8?B?emtFYVJZa3dhL2VLYWlEVy9Nay8xblR3bmNReEdxeE56czI2blpla2dvMWQx?=
 =?utf-8?B?VzZyMkRZYkpiWHo3Um5YQldZWDBvWHVMcWltUW5UN1pFWWd6c0xvazA5b3kz?=
 =?utf-8?B?RGl4c3Z5NldkT01XUm9NY01wbGFQTVRWbERPL0UvcW5ucjh1dDBqbitqcVJX?=
 =?utf-8?B?dDhENFJQT3VNWFRIRXZEM0FFUzI1SnpZV2RVREQ5eGJLSkw3RWVaSHVwdjBP?=
 =?utf-8?B?UVAxaGhBWXVHMnF4Z2xrTkRpMGNGYUVUc3p4MFpiYll5cC9kTWdWcUJOTEpG?=
 =?utf-8?B?Mk9WaXNXbDU4UEtPYmNZVUk3VTV3TmxFYmJqMnVtQXVPRmN2bFBFT1JZOFNV?=
 =?utf-8?B?c2ZXUHJxLzU2NWxuMHZFMXhka0s0MDYxN2pNVmtiQkprT3ZTWnlKeldmVjlo?=
 =?utf-8?B?ZmRhRWNZWWg4MVB3N0VVL2RHNzU5NnBFdlRtYmlHQiszWWY2ajBaL1NsSkhE?=
 =?utf-8?B?QkRlRFJTS1ArbVFZTDVUa2NvNTJnc0FlbDhoOU1BSHZtTlRSamt6bk1nbGpS?=
 =?utf-8?B?akZOTjhSTzBLVjJGY3U1OGNidGg3NlFaMHpHdER2Vi9LdVZ4RkFKdlo3RGZU?=
 =?utf-8?B?OURiR3FPbTF6azVhWXdoWGdUN2p3dTd3eHJDem9peUcvaUZuUkdwUEJJcVNR?=
 =?utf-8?B?N3VBTWl4L3hnaVZJMjNUa25Ec0I2SzV1T1B3QWtxN0RBK0EyTnA0MHJKWGNj?=
 =?utf-8?B?blN5MVVlUWlqZGEwQ1RsekozTXVCbStSUzJ1MXNvTHZVQUZBTVZTVVAybVdn?=
 =?utf-8?B?ZUtJVXRZaEVrRElqS2ZuNVd4OXYzSTMvSnhwYjI0bEFTODVuMEVnZW5vQkRB?=
 =?utf-8?B?L3lVR3dJOEtkUXNHd05OQzFPdFRqNDF5UVFteFdUWnRmTE9sYVoxVnFaNjZk?=
 =?utf-8?B?QTAyWndWWENyYlJlWWtxK1JkMWk5ZWZPeDNlSWhYWXFER2gwMUNYcGxKdWhL?=
 =?utf-8?B?bnZUUEhLRllNWlk1T1d2WEhEOTY5OG5VbnRZeDd0TVB0T3k2WGovcloyaUQw?=
 =?utf-8?B?MDFSTWhBNTRhNGxwU3ZFeFFmblducll0SFdxMk1HUFBGa003T2lSVkJoVGho?=
 =?utf-8?B?eGZ6MXlMZ3VjNW9reFVScTVJb0k0d3FvdEFQWmQ0YmZhVVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGF1STlTVG1PSWtzRVhJcU14V0dSR2xkKyt4dnE0amJPdWtxZks3WGVDMG1n?=
 =?utf-8?B?blgyR1IxbzBEc0hiQ3Y0clFENkhOQW1IeStkRUV1cVJSMUdwaytsWWdpY0pW?=
 =?utf-8?B?TFVVdS9RM0VGSHBQVEJlS2Z0TjlnOGxmQVExVEdCQ2wrVUp2NUd3WVc4N0h1?=
 =?utf-8?B?UkJwMDBIU0NjS1BrTitPTmw3SkUxNHdZMy9Dei9TYjhEYVB0ZDFzcnFCL2Fq?=
 =?utf-8?B?M0RjU01KbDFZMWhZNDZzbStGV1QveXpTMVhWbVd3enVvOFhpQVZ6VkpiMkhQ?=
 =?utf-8?B?NThSN0FjdDkrZytrZ1d3S2RKQm1KYmtUdEhXMHZqNDVtbUQzd2FENG9mOFJt?=
 =?utf-8?B?Wnp6Qms5TXVrWVVDUXJ2YWxRZlVvZ3Nab0JHVFMrSVpURjFYemlLSW5wSTM3?=
 =?utf-8?B?UWtZdm8zcDRhV25vM1lEeVJ1cGsrNlRlYXdwTmptRnRFOGxnZ2NCaUwvc2xP?=
 =?utf-8?B?aWdKc2ozRVBqQytPaEpqTkpUTnk2VDNkMkRLRmNMY1BmR0ZzaVdhVHNlY2ww?=
 =?utf-8?B?elNXRW1iWDJxeGhyWmVpc0R3ZHllc3dsK21Cd1lVc3hmSm9INUdXNEE4NHBl?=
 =?utf-8?B?N0JYL3FuR0dHMGtsV2RDM0licWg1Y2ZFTEVJK3RTc0VidGUxQWtrY3YxU2dF?=
 =?utf-8?B?WWMrbEdqbzdBblJyYzZKakNsZUlBWDdzKy9Xd01wS3ZSWkZtT3lUaDFLemlQ?=
 =?utf-8?B?OEFFVzcxSlFiYzFFYTNaM1JGbXpQbVdRODhrbzcvb3RxRVpOaUIxTy81ZkpG?=
 =?utf-8?B?OHVqZUo1WnhNZUhNQldJdGVUeUJjR1FXQVBxa1lGcGZ1U0VXdTRYTzdLNTc0?=
 =?utf-8?B?cVdoM0xpQWMzemlTVHB6eDdZWG92Q0dxZHNaZjdMYnVWVGhDaHE2VEk3OHJp?=
 =?utf-8?B?RTVDVUorTWlMYll1MjcwYjVTajlRd2JYWlMrS29DUlVlL0JLWndDV2g5dWkv?=
 =?utf-8?B?OFMrR3A1TkZnLzAwSVVnczUzZjdqbStCUm5uaFpGLytjNmJIOFdRSG5vL3pQ?=
 =?utf-8?B?eFdRMTZpNVRObUhsZnZ2MncyeGlma3BkMEJ4UGVTMExBVlhzWlZ0dUVFbEhF?=
 =?utf-8?B?Z2lFQ2NBMEhscFIyNGhRczhlWkFWRjhtYWU2SmJuUjFQYTVQRE5lVnVYRXNx?=
 =?utf-8?B?ZWhsMGJhRVBIUHRyc2xBNHhJWlBDVGQ4V1k4NWVFenFuRU9mWnd2am4wMU5v?=
 =?utf-8?B?T01MeWJLbXJPVlhqNVlFWkpJNTVLVytaRWpjNTFZbVVZWGNldGdMMnZVR1dD?=
 =?utf-8?B?RmNlMHlsNWJaL0RNOFQvemRPbyt5Zzd4aXJqaGdEL3Z2bEltWkVCd2IrN2ZL?=
 =?utf-8?B?RjVwSGI2SVpOYU5NaU5tRmJ4QXVQdXNTUHIwVXR3eTNETVhDdFcxRDgrL2ky?=
 =?utf-8?B?cm1XaUZHcTlaeStyRE9IU1F6M3gvOGhlR2xXQUNtcjFhMHZveUJJUDJxajVw?=
 =?utf-8?B?WGgxWm83NXNCZkZha2x2cVBGdXBOUWp4M3J1S0F4ZUVrVE5MaUh5NHJMN1A0?=
 =?utf-8?B?NzFwT3VHOTJQMHVPSjd4V005aDdLTFZ4RyswZmlUVFF0OTBGd3A1MVZVY3BK?=
 =?utf-8?B?ejlIVm9SQWdQTitEN2pXUXdqM0M2bllWUHNWelV3RTJxOWZXdGVYcjN2RjVE?=
 =?utf-8?B?Zmd4eEZIdzhIeGZUOStGdXkxc0d2Rlh6Rlk0UXNidXNmeGV4dlk0ZjFsQUJH?=
 =?utf-8?B?MWZDc0RIWjVLUkp0eDVzdDlxWU1jUG56cGVUM25VbVRHMjRjb1pYT2Jnbjg5?=
 =?utf-8?B?RXlBSXR4c1lPNjQvb1JZMjlJd0JrL2hHSjNJU0FLc1hrZlV2MXc0VEVGOGFZ?=
 =?utf-8?B?TU51NkdaYVN2d29XNFVLUnZBemlRaHE2MFUxUm9WWFVjS3d2TFM3b0srMGR4?=
 =?utf-8?B?dmRTaks3S1VlaWpka0kzY2ZDL1pMYmRNTGNORTFjSFpUTUJha3VTVmpQY1Qy?=
 =?utf-8?B?VWtoWnJ0Q2lBRTQ2N3hlQU11N21NcW5KMVhRSmxyUUFnZDZvNkY4K2tTVnR6?=
 =?utf-8?B?emV4d1A3R3BWdzZ5RTJUR2U2WXNZSWhnWmY4ZldyVFNwMSsrUWNGWjFQQ2po?=
 =?utf-8?B?S3AzanFSb0l6ZzBma09sNEphVUU3bmQzWkFhSGlsNGhBaHgwb0VFdTUzMkIw?=
 =?utf-8?Q?1eLtG3GTxOi+bPYuDqyp46VcL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3448e472-cad6-4bed-1ea9-08dcb06b3f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 07:43:04.8137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgwK1Us6h1PE5qXZ8M7Rmo4dZm7LetRFw1Fo3debORBz98eehnz9BOouyCXBN5eX+FovLHF6+S8iy8cN/HV1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6838
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

SGkgTWljaGFlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMzAsIDIwMjQgMzoxMiBQTQ0KPiBUbzogWi5RLiBIb3UgPHpo
aXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtv
bnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFp
bC5jb207IHNqZ0BjaHJvbWl1bS5vcmc7DQo+IG1hcmV4QGRlbnguZGU7IGx1a21hQGRlbnguZGU7
IHNlYW5nYTJAZ21haWwuY29tOw0KPiB4eXByb24uZ2xwa0BnbXguZGUNCj4gU3ViamVjdDogUmU6
IFtQQVRDSHY0IDAxLzE0XSBjbGs6IGlteDhtOiByZWdpc3RlciBBUk0gQTUzIGNvcmUgY2xvY2sN
Cj4gDQo+IEhpDQo+IA0KPiBPbiBUdWUsIEp1bCAzMCwgMjAyNCBhdCA5OjA54oCvQU0gWmhpcWlh
bmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBI
b3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gUmVnaXN0ZXIgQVJN
IEE1MyBjb3JlIGNsb2NrIGZvciBpLk1YIDhNIE1pbmksIE5hbm8gYW5kIFBsdXMsIHByZXBhcmlu
Zw0KPiA+IGZvciBlbmFibGluZyB0aGUgJ2NwdScgY29tbWFuZCwgd2hpY2ggZGVwZW5kcyBvbiB0
aGlzIHRvIHByaW50IENQVQ0KPiA+IGNvcmUgZnJlcXVlbmN5Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBW
NDoNCj4gPiAgLSBNb3ZlZCBoZXJlIGZyb20gb3RoZXIgdGhyZWFkLg0KPiA+DQo+ID4gIGRyaXZl
cnMvY2xrL2lteC9jbGstaW14OG1tLmMgfCA2ICsrKysrKyAgZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg4bW4uYw0KPiA+IHwgNyArKysrKysrICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jIHwg
NyArKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMNCj4gPiBiL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14OG1tLmMgaW5kZXggZTUzOGYwNDdiMy4uOGQ5OGZiYWFhOSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jDQo+ID4gKysrIGIvZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYw0KPiA+IEBAIC0yMSw2ICsyMSw4IEBAIHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3Qgc3lzX3BsbDFfYnlwYXNzX3NlbHNbXSA9DQo+ID4geyJzeXNfcGxs
MSIsICJzeXNfcGxsMV9yZWZfc2UgIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4gPiBzeXNf
cGxsMl9ieXBhc3Nfc2Vsc1tdID0geyJzeXNfcGxsMiIsICJzeXNfcGxsMl9yZWZfc2VsIiwgfTsg
IHN0YXRpYw0KPiA+IGNvbnN0IGNoYXIgKiBjb25zdCBzeXNfcGxsM19ieXBhc3Nfc2Vsc1tdID0g
eyJzeXNfcGxsMyIsDQo+ID4gInN5c19wbGwzX3JlZl9zZWwiLCB9Ow0KPiA+DQo+ID4gK3N0YXRp
YyBjb25zdCBjaGFyICogY29uc3QgaW14OG1tX2FybV9jb3JlX3NlbHNbXSA9IHsiYXJtX2E1M19z
cmMiLA0KPiA+ICsiYXJtX3BsbF9vdXQiLCB9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IGNo
YXIgKiBjb25zdCBpbXg4bW1fYTUzX3NlbHNbXSA9IHsiY2xvY2stb3NjLTI0bSIsDQo+ICJhcm1f
cGxsX291dCIsICJzeXNfcGxsMl81MDBtIiwNCj4gPg0KPiAic3lzX3BsbDJfMTAwMG0iLCAic3lz
X3BsbDFfODAwbSIsICJzeXNfcGxsMV80MDBtIiwNCj4gPg0KPiAiYXVkaW9fcGxsMV9vdXQiLA0K
PiA+ICJzeXNfcGxsM19vdXQiLCB9OyBAQCAtNDE3LDYgKzQxOSwxMCBAQCBzdGF0aWMgaW50DQo+
IGlteDhtbV9jbGtfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgICAgICAgICAgICAg
ICBpbXhfY2xrX2dhdGU0KCJxc3BpX3Jvb3RfY2xrIiwgInFzcGkiLCBiYXNlICsgMHg0MmYwLA0K
PiA+IDApKTsgICNlbmRpZg0KPiA+DQo+ID4gKyAgICAgICBjbGtfZG0oSU1YOE1NX0NMS19BUk0s
DQo+ID4gKyAgICAgICAgICAgICAgaW14X2Nsa19tdXgyKCJhcm1fY29yZSIsIGJhc2UgKyAweDk4
ODAsIDI0LCAxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBpbXg4bW1fYXJtX2Nv
cmVfc2VscywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgQVJSQVlfU0laRShpbXg4
bW1fYXJtX2NvcmVfc2VscykpKTsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiANCj4gaW14X2Ns
a19tdXgyX2ZsYWdzIEkgdGhpbmsgeW91IHNob3VsZCBtYXJrIHRoaXMgY2xvY2sgQ0xLX0lTX0NS
SVRJQ0FMDQogDQpNYWtlIHNlbnNlLCB3aWxsIHVwZGF0ZSBpbiB2NS4NCg0KVGhhbmtzLA0KWmhp
cWlhbmcNCg==
