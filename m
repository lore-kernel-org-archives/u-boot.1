Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D41EF9EDC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECCA8421D;
	Wed, 22 Apr 2026 14:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CQ7WzpGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74B383BC8; Wed, 22 Apr 2026 05:57:32 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BDC8352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO7+DdmruKoX6mXlb3VQRjY1dBCJD2i6a/E+5DpE/XFIjVArE1CPZYUuCvKCn0m5Zt5I04dGBb9sGkiCOM/BXASVALZrPttX2J9cAcTIJ5x7tewu71uOJBRLIugnBJg0lulGLzDKVBb8FdLuSMw9+UK2xZjDRTDjabWdKuaQ1yVcI02gJ2foccJ6fwsWq1cbcfapRzmGcTdDwNu4ikonzNGWikGjQNNBXDkwehXuorOwR2ru7j/AkqFobvTDF92CGDwZ9qp39KRVNjtNczjpmtZ7THrM7xJu+N8sFC32CCWODIokp1+W38Xi3KnVajHyhC2U9w+wjoZb16IYNYHbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwfmt7C+3QF1omGHmTFsQX7A1akYkOjdVJePGVZwyjU=;
 b=gEaP5wWwYd7IFZhR10+ovth65YmcNNRtdkY4iJbILrcqFQmn9CjEjg5sNleW1dhHoM3ksvy9+SB292EDcZhr4M/O16VZIQYEq7Xfs5mS27q0AbfRCQ3P3WoVWfrXb5LYHFpkXfKUL8+I3gFxZ58s0aJ7NfDrl8B4OsSqbI3P6Ktv84OcMFbUcFjV1KySTVluWj70IIYM3azCbs24rD5YZB/zsd9h5DqP/OA3Snlq5K2Z75Cg/S5UH9MEhvuZrglzVBV8dYVL4lqQLyeyP5tt9BypM3pDCRAViIUmWDp6nIAp+JGLCkFkHwjzbgVaF2VTODYicJwCuXwwdv2xOn45oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwfmt7C+3QF1omGHmTFsQX7A1akYkOjdVJePGVZwyjU=;
 b=CQ7WzpGuCO422zo3/6dmWcfUoCNBpU/vnufTg0TpuRKusCQz5swO+d4p8P7u4awLaedeh4lopoZzl3xTgT1Z67W8FgqbL/6tSwQsZfwb4oLmKLyVrPbnsEpn0NzUL6GXKvjIOK3LIlHZs0mxRJwCBf6m/048DXZ7jr5aqJsOUUoBC9u+oxofSBgzC7aQPbEOR7DftwLb6Hf/fcfCA0nogaRLsf55J1qQg1RB6JwhkMftAvee3IxaJ85s1+s1a1cS+RjGevoFq2k34Yr9h6NyddtF7JAAXpQZwxsAK1Y6wv5GFdBqhiic0fdU3rzA1E9c6sWQ7yPf8XssSNZHhSxVCA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB11940.eurprd04.prod.outlook.com (2603:10a6:800:307::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:57:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Wed, 22 Apr 2026
 03:57:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Christoph Stoidner <c.stoidner@phytec.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Simon Glass <sjg@chromium.org>, "Ross, Fedor" <fedor.ross@ifm.com>,
 =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?= <sebastien.szymanski@armadeus.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>,
 =?utf-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVzIChTY2huZWlkZXIgRWxlY3RyaWMp?=
 <jeremie.dautheribes@bootlin.com>, Jacky Bai <ping.bai@nxp.com>, Stefan Roese
 <stefan.roese@mailbox.org>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, Franz Schnyder
 <franz.schnyder@toradex.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Joseph Guo <qijian.guo@nxp.com>, Ji Luo <ji.luo@nxp.com>, Marek Vasut
 <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC81XSBpbXg6IFN3aXRjaCB3YXRjaGRvZyBh?=
 =?utf-8?Q?ddressing_from_macros_to_devicetree?=
Thread-Topic: [PATCH v2 0/5] imx: Switch watchdog addressing from macros to
 devicetree
Thread-Index: AQHc0gwhDQF/vjEbjkeriKZJJSkANw==
Date: Wed, 22 Apr 2026 03:57:26 +0000
Message-ID: <PAXPR04MB9644E18E60DDD94976A8E3D1E22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
 <20260421154813.GA95800@francesco-nb>
In-Reply-To: <20260421154813.GA95800@francesco-nb>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI0PR04MB11940:EE_
x-ms-office365-filtering-correlation-id: f8bb5cce-9863-4922-d639-08dea0234467
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 4rUM+RB9XWwns4HNPxzEcaOJo1XZu3hETJY9LE02gk9FCKq6ECvGeb+el5PPeGSbJ6HMHpAKkPzEf72LfnCVDfEajAWbkfkqGJew+9SXlxj8P5mGRTx8/CnmLXxCmWf2mzZ7f6Ti+ySnAM7ayxGppI15Baz7KtHOeF7KrhkrSrvBBJyTmEuBSuuDt/f2a48JgGT6rim/eLMm7Sj3Z0wXW8CrWTYH08LC2lW/90P0uRtAEG9GTgPEevvVww/Xj7+nvr0LGs31Y8bI7Z2qrTRstgcBxVY8AhmEIG4PE5osSst5ZmzUJD8Bg2Sw38GGxLM+afkXnCjVnvCfN1757bNCfQdtd+moRlth3iy/6CzG6p/g3mcyy6nFYPtctV+5ZBxIl9qWfDnX/zdieFhNwy2kt1Fa3ILG4lcwM9BJlAtMuo9c9ey44JAToB1516cjoFnINsbrN50qP2rsKxJoWbClJBEfA9/AncvFazGMonX6envRTyd8qNurOl/upAUeLeLNOKugePpRZA7tvFdc4w2pQodzQEMhrOgjUGOdNeeq0XLMzCoWK56PCtU524Bc9DjBHqc1hzenda2ffdv5Ghuv1W+Di8LQIve9wy/NCfSEkBynug5fpwD01qClnHMBwCIT46/Snsp89RPPcsCxZ05wszPkpkHQkiIbHCSftjl/Aa+4uuFJKJ5FOXzntA/qzjnf1qf57ALkMu12DNc/rRvBL8PMgBTPz41aexPoFUnTe1VD53YMKV8tI+TqEx9CB/FvqRiPVY9B7A6TvFcgRvPKVIQcxxv0Zb7BcP7BysRM0e+eJnK5U4XpO22nUZfqJFVU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXBwTE1jaWNhZlc0RmNoa0ZLckhlUFpBTFBlODFXVTNhUEp2UFkwdk1vamhM?=
 =?utf-8?B?QVI1NUNRMklja1JxeXljSWY2Vjc1SllKdEJrVGVVRWJ0Sk5HNXhnZjBDbW9N?=
 =?utf-8?B?emRZR2ZUVWlsVy9yclZlTnFKTGFkSmIxZFhONG9QUFpTc3YrMFJoQnF6bjM0?=
 =?utf-8?B?OG1ObVZKdStRSXRHNUFiemJsOE5WVHlhWWRicDBvS0J6bVl1NEtqU1NsYk9P?=
 =?utf-8?B?UEI2OVdTUzBSbHllRDcwZG0zeEt0VTlPZ3F2S1libjZUaHdPcDd2ZkxLZlRi?=
 =?utf-8?B?b3c2K1lSWlQvenhTREVCNzVQc01MaEpPa0dTcTVLYlFVYi9MRWs2MFZVZFkv?=
 =?utf-8?B?dlpoY2dLUE05OTlOZjRXUzJDc01hd3Y0VWR1M3FWWHBPeDMwZUNza0JnOGFa?=
 =?utf-8?B?SE1MYklrTFdGVEFpOFBrMEhLbFNLa0x3d3hGTU1FWG5mWE5aK25CaFlQenVV?=
 =?utf-8?B?bmRnT2Y4R2tvMzVKcmg5NjVNRSsyKzNQZHEvM0FHL1kycmh2dzlsMVZUckdP?=
 =?utf-8?B?REtnWFJTaWEwZWFab3UxMHduN2dNekJoSHJnUkI3YnZXUittVzRNb2haSGVo?=
 =?utf-8?B?eTVKays3TEw2ejlHTUdHck16VkJRL2FyOGt3YzBCcElyd0lzb0Y1RVdUVUpp?=
 =?utf-8?B?dWxWVEdMd3I0cmpSMkgxMmZubDBiR1A3NHZYRy9EelF4N1R4N0I5WmhxaG1N?=
 =?utf-8?B?cm5BaTFGSk1SRGk1eGpvVHNVLzVhNlRCcFFYRTNPVTBJQkNnNnRMQ3pzSVNY?=
 =?utf-8?B?ak5XaWx4UXFzS0dqT3pVS0dvN1NuU3N0TklYN3pEbCtHL1RxY0ZsZURDTEJY?=
 =?utf-8?B?RW9wNHowdklqbTdHTVRPaFNpbnlkbkdEdTJhdmhTVml2TVJqalJjT3M5V2Jm?=
 =?utf-8?B?WUMvRHE5YlpkQXE5MkFYSWsyNjAxTXpIaTQwQzZSeXl1VENLaVd3cHpZSE8v?=
 =?utf-8?B?NlIyck1LaFZJcTRObktLeFY3WVNma1kxWFlnYlBKanQyMVJIWExjT2w3T1Jh?=
 =?utf-8?B?WHZJQyswck11eWRtQi8zL1JhekJGc003aVREZVFIVkdDdHpHanN4Q29FWUli?=
 =?utf-8?B?Y0E4UEp3Y0xXVEVpSXRKQnFBbGRIUnlYV29YZy9VMFdqRjJxNXlaRkkzVUVU?=
 =?utf-8?B?K2kvb2pKbUNNTHNHN29EL1hhTm9YVXcyVFdLWWxIcU8wUnFoN3BhbjZnSHpU?=
 =?utf-8?B?UlhKWTJZVytLL1YvVWtKMnNWQUNaR0p3VjQ0USttN29hK2xMWElaZzhDVlg0?=
 =?utf-8?B?TnhaaHlzaEF6Tm53dy9FdFEvekRVaC9NMTRWQU1MSzN3cTBHOVFESGRvd05j?=
 =?utf-8?B?dUV4QjJoUUdTUm5FNmphbWVMWEd1VllEV0ZmZ2N0ejRkUE53dHR5RFl4SUt2?=
 =?utf-8?B?cWhlZXAzL0xjYkhPeUNqWFFOaENka29wSUwvNHFLcVZBNzJBVTZZYWdVRU1X?=
 =?utf-8?B?UTdac1o3dDFKMzVWNTZpNmpGd3Jab1QrS1RzTGRvVndXbFJxWTlMVVJLV0Q5?=
 =?utf-8?B?MXFrUk5kaDNncEV1TXBpeWF4ZEZkUm9zQlY1OGZPNC9MMWxFY1hTbnFRcnhO?=
 =?utf-8?B?cWM5M2JRenVMRnJYb3ZpekVOWWo0Zm5DUkRlcDhuYWNvSCtPWmdzZFJUeHVF?=
 =?utf-8?B?Ni84UzFUWFpRK1JjRjFaOG45NUljOWhJT0hxaldjWHRZRnl2US9Zekg4S0Rl?=
 =?utf-8?B?ckx1OXNlcGt5MjJmZm9CcHNzcGtsQlI2bnFPL3RVQS9FSGFDZzREUm94VTNL?=
 =?utf-8?B?UjRrOXJMRlRVTWZZNklQb01HSllvVzVYNW94THRLVXZlRzZRZHYwUVBrM2hX?=
 =?utf-8?B?S1hXeCtWcEN3ZS9sT0lqWVUxZFgveG5qVmoxd3dKenZWZHF1eDVKUEZBN3l2?=
 =?utf-8?B?VkJadjMrQ3gvbklLTEpXYnhQbFprVHh6N2pJZ3pNYjIxMDEwb3h2Tk5wYkpR?=
 =?utf-8?B?aTlqYngvNkUrbHI3eG8wa1o0bmZUS2YrTVZ3L0xhQzJWSmhPWFVMMjVmc2tP?=
 =?utf-8?B?b2dhZkg4UzJRemRjbDkwbFlOTXhiWTFuQUh2V2YwWk44aVVNcUg5elNsckNj?=
 =?utf-8?B?Ti9pVWJEWW15VjNTZ3JSUTFJZUpYb1EvdUJXdWd2bnR1dFdVSHFZYWhvc0N2?=
 =?utf-8?B?dng5U1RacTZiUUhZa0Nic05QdGZ1d1lWQXYvTXhWTENaY2hyK2xobVRaL3FN?=
 =?utf-8?B?eEtUdTc4Q1Voc2VRSUVRdEpIcERDb1VKeXZHSi9jeGtWTjFMSjNXQzcxeGF4?=
 =?utf-8?B?enFzRWZNZUlpazRKZ29jUWI4dGlKUHNYWWFxUFk0UHpmek1pVG1zTE44RURI?=
 =?utf-8?Q?BaP483K9/qZOBiB7Cm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bb5cce-9863-4922-d639-08dea0234467
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 03:57:26.4239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdTwlrqAwHgP9DR3msjSQ41wrx1jXj2dWx/oRK/Cih4GELb7+IGy/9+DuW/EkdpSIP0ApVwyHwdj5fuU6gALJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRnJhbmNlc2NvIERvbGNpbmkg
PGZyYW5jZXNjb0Bkb2xjaW5pLml0Pg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQ05pyIMjHml6Ug
MjM6NDgNCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNv
bT4NCj4g5oqE6YCBOiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxp
c3RzLmRlbnguZGU7IENocmlzdG9waA0KPiBTdG9pZG5lciA8Yy5zdG9pZG5lckBwaHl0ZWMuZGU+
OyB1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGU7IFN0ZWZhbm8gQmFiaWMNCj4gPHNiYWJpY0BuYWJs
YWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBUb20gUmluaQ0K
PiA8dHJpbmlAa29uc3Vsa28uY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBZZSBM
aSA8eWUubGlAbnhwLmNvbT47DQo+IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgUm9z
cywgRmVkb3IgPGZlZG9yLnJvc3NAaWZtLmNvbT47IFPDqQ0KPiBiYXN0aWVuIFN6eW1hbnNraSA8
c2ViYXN0aWVuLnN6eW1hbnNraUBhcm1hZGV1cy5jb20+OyBKb8OjbyBQYXVsbw0KPiBHb27Dp2Fs
dmVzIDxqb2FvLmdvbmNhbHZlc0B0b3JhZGV4LmNvbT47IFByaW1veiBGaXNlcg0KPiA8cHJpbW96
LmZpc2VyQG5vcmlrLmNvbT47IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29u
dHJvbi5kZT47IEoNCj4gw6lyw6ltaWUgRGF1dGhlcmliZXMgKFNjaG5laWRlciBFbGVjdHJpYykg
PGplcmVtaWUuZGF1dGhlcmliZXNAYm9vdGxpbi5jb20+Ow0KPiBKYWNreSBCYWkgPHBpbmcuYmFp
QG54cC5jb20+OyBTdGVmYW4gUm9lc2UgPHN0ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz47DQo+IEZy
YW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47IE1hdGhpZXUg
T3RoYWNlaGUNCj4gPG0ub3RoYWNlaGVAZ21haWwuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWtt
YUBkZW54LmRlPjsgRXJuZXN0IFZhbg0KPiBIb2Vja2UgPGVybmVzdC52YW5ob2Vja2VAdG9yYWRl
eC5jb20+OyBFbWFudWVsZSBHaGlkb2xpDQo+IDxlbWFudWVsZS5naGlkb2xpQHRvcmFkZXguY29t
PjsgTWF4IEtydW1tZW5hY2hlcg0KPiA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT47IFdh
ZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRlPjsNCj4gU3VtaXQgR2FyZyA8c3VtaXQuZ2Fy
Z0Bvc3MucXVhbGNvbW0uY29tPjsgdGhhcnZleUBnYXRld29ya3MuY29tOw0KPiBBbnNodWwgRGFs
YWwgPGFuc2h1bGRAdGkuY29tPjsgRnJhbnogU2NobnlkZXINCj4gPGZyYW56LnNjaG55ZGVyQHRv
cmFkZXguY29tPjsgU2FtIFByb3RzZW5rbw0KPiA8c2VtZW4ucHJvdHNlbmtvQGxpbmFyby5vcmc+
OyBKb3NlcGggR3VvIDxxaWppYW4uZ3VvQG54cC5jb20+OyBKaSBMdW8NCj4gPGppLmx1b0BueHAu
Y29tPjsgTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT47IEFsaWNlIEd1bw0KPiA8YWxp
Y2UuZ3VvQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MiAwLzVdIGlteDogU3dpdGNo
IHdhdGNoZG9nIGFkZHJlc3NpbmcgZnJvbSBtYWNyb3MgdG8NCj4gZGV2aWNldHJlZQ0KPiANCj4g
SGVsbG8gQWxpY2UNCj4gDQo+IE9uIFR1ZSwgQXByIDIxLCAyMDI2IGF0IDEwOjAxOjI2UE0gKzA4
MDAsIGFsaWNlLmd1b0Bvc3MubnhwLmNvbSB3cm90ZToNCj4gPiBDSTogaHR0cHM6Ly9naXRodWIu
Y29tL3UtYm9vdC91LWJvb3QvcHVsbC85MzUvY2hlY2tzDQo+ID4NCj4gPiBDaGFuZ2VzIGZvciB2
MjoNCj4gPiAtIEl0ZXJhdGUgYWxsIHdhdGNoZG9nIG5vZGVzIGluIGRldmljZSB0cmVlIGluc3Rl
YWQgb2Ygd2RvZyBhbGlhcw0KPiA+IC0gRGVsZXRlIG5vbi1ETSBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgVUxQIHdhdGNoZG9nIGRyaXZlcg0KPiA+DQo+IA0KPiBQbGVhc2UgYmUgYXdhcmUgb2YNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNDE2MDg0NTM1LjE0OTA0NzYtMS1naGlk
b2xpZW1hbnVlbGVAZ21haQ0KPiBsLmNvbS8NCj4gDQo+IEluIGNhc2UgaXQgZ2V0cyBtZXJnZWQg
YmVmb3JlIHRoaXMgc2VyaWVzLg0KPiANCj4gRnJhbmNlc2NvDQoNCg0KSGkgRnJhbmNlc2NvLA0K
DQpUaGFua3MgZm9yIHRoZSBoZWFkcy11cCwgSSdsbCBrZWVwIGFuIGV5ZSBvbiBpdC4NCg0KQmVz
dCByZWdhcmRzLA0KQWxpY2UNCg0K
