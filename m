Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40528F9EDC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE1483FFA;
	Wed, 22 Apr 2026 14:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P5xkWPnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E104B83AC5; Wed, 22 Apr 2026 05:49:05 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED048352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9axZkyqcPF5sZh/EB1gJlUzNBERQnO/LGuEw8bZ02ztfsOVCK2IhX6a9VYx7f3GM6a8s4ygYCopvvTiRnh4mRHKHKDDZX6IYGrTmm0h7cp7eO1myi/2wPfM7WChkzWeDqgAmJ8mR3Zx26cGNUK3SORiaTP4xGcA9Xw3T4FMUMv3obnIZT5HjDpoYERDmtkrSMRng+ssXOlue7KWkGKgIkEo7NQ9dXI8enEJ3a7P9TxWNPHCoDRibhs242c+eyOB75dJkVo8YtdvrDALQmkobeP9haWb2OkCiVgr/9dWKD1cry5Rxl4hBhB9lHwqf3QJ3vYjouHEbS8F58CvcUZDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnctE138r31JduWlvpojoorm5XkPziU/VhlgrsketCA=;
 b=b2AW20STUBludpvgidxWwBo6HynGKATWC2OHxyMqzrpuOdtjPJa7tQBpX2e/rZSFrb/lf8EsaL5DRqzBJZeZCXQF7UBtWi/jqL1kLuBsrTNX0YxrqSY4j7y+yQJ1+KyN9VsUtSjM6FuiKRPsxgX+Btjy1M5o/FG0BX2b/2/mZFRJyEvdiATpxd8DGm5SGHA6Z08Mrwq1RdrSSuzU/1anLhky/Gq2cXufQBdWt2wrhdQB1pqNfB4vM1om+dCcIxjB2TfLP0kfaIn/HbZYxYXcQ63yuQFD3yHjynRuep127n8u8/2ZNgcwiK0OAlhjb4IJ/pTnMfULnLAQ3iSlhESGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnctE138r31JduWlvpojoorm5XkPziU/VhlgrsketCA=;
 b=P5xkWPnZdUgvgapIg569Zr5MAEwhWrCDZjxTpAumXR8Fxptsc//Gd4GmFP9+emdIk67AtAx1moyluoZKP0TUngn5qSkzyTHnk/5HbiKAHCX3wYqDwZzGq9sHFJlO5TDhsh2e3447viHXmGyLzXF/QIF2wgncjmHkv4r2Yjuo6HU4rSD+jgR39/L0Gj4V3RrpLilxfK59K6G5o+5OuaGou8TwgwPtLqh7nQgc2lPGAGN4iIoX2e7GxiUt6I3FAJN6WZWoOQ9IQgYfPo8Vcq1+PbLbeoRv2ogtBRhL9hfJJZT3n34tdqO418HjJOl2mOc6fKO6Vkq3P7srkRSH4ZcTpA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB11593.eurprd04.prod.outlook.com (2603:10a6:150:2c3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 03:48:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Wed, 22 Apr 2026
 03:48:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, "Ross, Fedor"
 <fedor.ross@ifm.com>, =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?=
 <sebastien.szymanski@armadeus.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>,
 =?utf-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVzIChTY2huZWlkZXIgRWxlY3RyaWMp?=
 <jeremie.dautheribes@bootlin.com>, Jacky Bai <ping.bai@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, Franz Schnyder
 <franz.schnyder@toradex.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Joseph Guo <qijian.guo@nxp.com>, Ji Luo <ji.luo@nxp.com>, Marek Vasut
 <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi81XSBhcm06IGR0czogaW14OiBVcGRhdGUg?=
 =?utf-8?Q?watchdog_nodes_for_dynamic_base_address_lookup?=
Thread-Topic: [PATCH v2 2/5] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
Thread-Index: AQHc0grzfkHI8o+PkkGQJjoK5rWX1Q==
Date: Wed, 22 Apr 2026 03:48:59 +0000
Message-ID: <PAXPR04MB96446CF3749068C53E1E8092E22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
 <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
 <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
In-Reply-To: <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB11593:EE_
x-ms-office365-filtering-correlation-id: 8e9864ce-f5fb-4175-a1fb-08dea0221610
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021|18096099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4+jhfBDIspOVhXg6rplViIYt4VOtcymjSKW8iVCl8TU3Z/MtKwUAFgNPGzDrqlIlhBGUdv95527GHMFFS6zFh3iqCRfLq9i2SB8DWomDjiAVY2JLh2wTrxKzU2ncGUt3lhBtrlWtc3zIjXGYM/qqXCpEsrxs5iAJPnazdoU3Is4YprAmqXSOWJ6hkxZR0Bwgbta2G+kCdPMZ396d8z1WyGDx6R+3GqKIrfmZ0vH47kSa8yaMxPIvIq407GM0cm0tO93I147iEVvd/mB6FADuF/fLlBxXPgrGVTa0h5X2roNUNnacA/iifcfeXUTmiabmz+fQepR97AhD5OA+1U2WopwQUuE8KSJyQyMyzwp+7ohhIAojNk14yhrDL4/3wgjLwnsVru37spfJPkrPJjDyFSKPHCHuLKgHEOV66iQEG5YTEodBdxjpwAEVE6cNcO0rP8hXFpsYSRFnmAM29YGRRGu30cQvzprtme5s51ACHQNNvtPrEAthPvm51/9tT3sACbC8Qh3iYhgs4MZiLCQi75A8NlJzYgMuDX3FrILQ9j9UvCnmWEDnYTVYSa6yfNYI3WaJlUp7KLUrzJwDfcl8Y8aEK7ItKHYP6LXTbL+Bpb9LNhB3/z74wcTyEy0ZqYEYr38v0/SPMi9yLZARAlNawQ4q+Qa7Uz3aZjn+fMGomxSGOPDo+YpzIna4+RbWZdHD0Znyi3S3GO477Iu/v4OoWEftJCTTF/YxPTMIW9rj3zMx0SBinlF1W7qfHSGVjhLqTy2K+h6qWOyiGX+KhLXkeP2ScnTHIjB9NnJ4agvp2wE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021)(18096099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjBodTdGZlg5MUZKRkRKMGorZ05pT2dMK1JjZ3ErZVRIWlQ1MDZXM2IwUHFK?=
 =?utf-8?B?bU5idVBEWDMzY2JCWFErYnFMV0hYcUVmVkFFcHYyeVhLM3JTU1FVd1JmZVlY?=
 =?utf-8?B?MXVHdC85K0lrQWcwUXBVczl5MnBESlJZalNmTUFPVHlBanhBR0x4aFdwZjRM?=
 =?utf-8?B?bEQrWmlCT0wyVFNLdkM1dm1pZ2ozclNGdnhDU0gzaVlDanA5VWtZNitPTTBj?=
 =?utf-8?B?NU80cm5MZjJGVnlPZjlBT0lDNDFPeGVEMEJGZXZ3UjROQUx1aUg3Q3FjUFZr?=
 =?utf-8?B?M1BnT3gvbFJDMDhsMXZSYWdMdEhxL1k3VW1ETjlhcE84RldqZHp4UnhBdE52?=
 =?utf-8?B?MVgvK0xZVU9HRUZFSUxqUTlUeUNaT1RqYWtZSzNhZ0l5Z0tDSWtPNmdKQ0JW?=
 =?utf-8?B?WS94c1U2SUU1UnUrMGtrN2RsWnMxd2JvTjQvMFpiMHRDRnFlYXpoR3J3anhD?=
 =?utf-8?B?WFh5RXl6TElXNnVWeTRNWWN6RTdNanVCMDFsNExvNGliMWczWlV4RzFzeFFl?=
 =?utf-8?B?a2tOaDdCL2JKblpWbTg3SGZaZE0xU0ZvNXR5S2dKeDc3d1BaOWNnQzEzOEhy?=
 =?utf-8?B?VjJ6S1N3R3dQRUJRMnU2eU4xV09lQ29jajA0K3ZYejFldUk1QmlkWWFSY2p6?=
 =?utf-8?B?UzAzQjZOZ3F4YXpjZ0JMY1U5c2Fkb0lTVkFHWDRLc0o3VjhOeUZNdW9jaFg1?=
 =?utf-8?B?eDFHMTBwZWJ4TkRoRmFnZDlNMTZFUkJ4cU56cUVCY0ZPZjNYQWdsM0hYWGdZ?=
 =?utf-8?B?bzJnbnUxOU9EanJMT2dmMHJaR2tWVE1mMld5bXFLVEg0MHVUZmFkZlNEaVJw?=
 =?utf-8?B?ZjhnRUVJNVBjeEEvNzhrQWxSRm13NUlheUpMSU9jQ2F4V0UvaVVFSEx1RU5S?=
 =?utf-8?B?N0JPWEwwWEpFZ2Yrc21VRU15aEw1TFBjVkNXWE5Ea2cwNmpYU3pnMWFLTXRt?=
 =?utf-8?B?WWNWY3Vwb09YU1FuSDFscVRwSWZHa0tieHhHWUpLNGY3NXBERlk4N3BKM2R5?=
 =?utf-8?B?YXRYWGxuUE5JQkhYcTVIWW5PaDJQaEV3TGR0VE41Y3ZWb0NSMHJjRlF3Q3A2?=
 =?utf-8?B?bU5JZWw5YkR2RjNVSGE4cWFmbTQxQnM3bTlRRGJ1MXF6RzRraTB4aEovWi9q?=
 =?utf-8?B?azN6N3FORkhVYldIQWFEa1ljK2x5cHd0allMVkgycUdaaVNoaUZraUJqbGcw?=
 =?utf-8?B?dWtPREVXaDNPbThLM2JCdjNBU3hjNFlXZlk0MVdRS01nYXYzaEJrSUVzdVRm?=
 =?utf-8?B?N3lsckJ0V3lZcjg4VkdEVFJNOGZNL213U01YSDQxZUlOaDROL1N5YnQwTWl1?=
 =?utf-8?B?ZmZvOVdnUVlpSHZYbmJoRkdBNGxHS0FWREQzWUhacWdKelVQM2ppUXRORWZJ?=
 =?utf-8?B?TnlDNVJXeldpbmt3eHh2MEZEY3pNck5KUTluR3k2bVJjL0Z4VTF1QURxQkYx?=
 =?utf-8?B?SDZTOUlqWTJhczFHZjkyZ1dOd0RHUm9XSGQ5YTJMQzFOM21nRHFYY0lVMFdj?=
 =?utf-8?B?ZTBIaWFlbTJoa1VBajJDTlp0MUtQOWdhT2Z6TUlzazAzOUlxKzc1NVg4cEJ1?=
 =?utf-8?B?RU9IWEd1SFh4amZoTHR2a0NXR0FETW1NMDFJTTBhZzRLbmt4TG5LK2oyTWVH?=
 =?utf-8?B?S1g5QWllZkRJTEVldk1hTzJ4bE15WmIvUk4xeWtscm9WMWZCTUVLaHVVWkEx?=
 =?utf-8?B?b0prK205YlVsSThDUTBmTWR2eFM4TEl4cXpLOURKRU1vSk9haHRtOHRVYjdh?=
 =?utf-8?B?bXNqYUdKT2t3cmMzSlZLaGVhUVRVeFEwYnZKcVJBZkFxeTdmM2VoVzV0MnFI?=
 =?utf-8?B?NVNLN04xM1U3d0Y1VURHZEVLVmJWcHBtcGR6bGFQdHFoMC9MakUyWXFXcVpF?=
 =?utf-8?B?MEZuaS9MWW9GZ0RzYXpFdE0yU0t1MG1CTU1HVW5Mb0lDMDJZOVZTejl6TS9Z?=
 =?utf-8?B?TXZLN0hJM0VlZm9RbVlscktqVkVPc0ozRHNSa0tYK3ZYeVN4Nm85OWxQVmY5?=
 =?utf-8?B?MkNuenBVQzNaY2YvTnMxbkpMOHhNT2cxYXRtTTA2VjE2NEFHZnVNRXQyQjU0?=
 =?utf-8?B?azJvVkJ1MFNpWmhlMjRYWXRENG0zOXRPaWxmSlI2Ly9yZ3NuM2tOeDM4ZW5X?=
 =?utf-8?B?bHJFYjJRellVd29tczUxU3NOa3VQOUQ3L2ZWOVd2MlVwV2M1TEh2eG1jYTF0?=
 =?utf-8?B?QnFTejB4blA0Snh1NHpmYmk0alRvNnVBUlRUeWg3NzJDUlZzTkNvR0hkTk9U?=
 =?utf-8?B?Y1MvbTdpbERBSjV6U0RBTHY2QW96RVU2RFB2MjdNeXhobzZhekJnQjhBTmR0?=
 =?utf-8?Q?DWhVXJ98152uGGODv9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9864ce-f5fb-4175-a1fb-08dea0221610
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 03:48:59.2647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j73wuYhIEnT2li17BbrlBUkzJMd0xFmFYblnhK2pi2HpDHNpOcv09+9IhT6LzN1v+FTrxMrM1/QddBn22Xq/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11593
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogU3RlZmFuIFJvZXNlIDxzdGVm
YW4ucm9lc2VAbWFpbGJveC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAyNuW5tDTmnIgyMeaXpSAy
MjoxMA0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29t
PjsgZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhwLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54
LmRlOyBDaHJpc3RvcGggU3RvaWRuZXINCj4gPGMuc3RvaWRuZXJAcGh5dGVjLmRlPjsgdXBzdHJl
YW1AbGlzdHMucGh5dGVjLmRlDQo+IOaKhOmAgTogU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxh
ZGV2LmNvbT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+OyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47IFll
IExpIDx5ZS5saUBueHAuY29tPjsgU2ltb24gR2xhc3MNCj4gPHNqZ0BjaHJvbWl1bS5vcmc+OyBS
b3NzLCBGZWRvciA8ZmVkb3Iucm9zc0BpZm0uY29tPjsgU8OpYmFzdGllbiBTenltYW5za2kNCj4g
PHNlYmFzdGllbi5zenltYW5za2lAYXJtYWRldXMuY29tPjsgSm/Do28gUGF1bG8gR29uw6dhbHZl
cw0KPiA8am9hby5nb25jYWx2ZXNAdG9yYWRleC5jb20+OyBQcmltb3ogRmlzZXIgPHByaW1vei5m
aXNlckBub3Jpay5jb20+Ow0KPiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+OyBKw6lyw6ltaWUgRGF1dGhlcmliZXMNCj4gKFNjaG5laWRlciBFbGVjdHJpYykg
PGplcmVtaWUuZGF1dGhlcmliZXNAYm9vdGxpbi5jb20+OyBKYWNreSBCYWkNCj4gPHBpbmcuYmFp
QG54cC5jb20+OyBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5j
b20+Ow0KPiBNYXRoaWV1IE90aGFjZWhlIDxtLm90aGFjZWhlQGdtYWlsLmNvbT47IEx1a2FzeiBN
YWpld3NraQ0KPiA8bHVrbWFAZGVueC5kZT47IEVybmVzdCBWYW4gSG9lY2tlIDxlcm5lc3QudmFu
aG9lY2tlQHRvcmFkZXguY29tPjsNCj4gRW1hbnVlbGUgR2hpZG9saSA8ZW1hbnVlbGUuZ2hpZG9s
aUB0b3JhZGV4LmNvbT47IE1heCBLcnVtbWVuYWNoZXINCj4gPG1heC5rcnVtbWVuYWNoZXJAdG9y
YWRleC5jb20+OyBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRlYy5kZT47DQo+IFN1bWl0IEdh
cmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT47IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsN
Cj4gQW5zaHVsIERhbGFsIDxhbnNodWxkQHRpLmNvbT47IEZyYW56IFNjaG55ZGVyDQo+IDxmcmFu
ei5zY2hueWRlckB0b3JhZGV4LmNvbT47IFNhbSBQcm90c2Vua28NCj4gPHNlbWVuLnByb3RzZW5r
b0BsaW5hcm8ub3JnPjsgSm9zZXBoIEd1byA8cWlqaWFuLmd1b0BueHAuY29tPjsgSmkgTHVvDQo+
IDxqaS5sdW9AbnhwLmNvbT47IE1hcmVrIFZhc3V0IDxtYXJleEBuYWJsYWRldi5jb20+OyBBbGlj
ZSBHdW8NCj4gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjIgMi81
XSBhcm06IGR0czogaW14OiBVcGRhdGUgd2F0Y2hkb2cgbm9kZXMgZm9yIGR5bmFtaWMNCj4gYmFz
ZSBhZGRyZXNzIGxvb2t1cA0KPiANCj4gT24gNC8yMS8yNiAxNjowMSwgYWxpY2UuZ3VvQG9zcy5u
eHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+
ID4NCj4gPiBVcGRhdGUgd2F0Y2hkb2cgZGV2aWNlIHRyZWUgbm9kZXMgdG8gZW5hYmxlIGR5bmFt
aWMgYmFzZSBhZGRyZXNzDQo+ID4gcmV0cmlldmFsIGZvciBpLk1YN1VMUCwgaS5NWDhVTFAsIGku
TVg5MSwgaS5NWDkzLCBpLk1YOTQzLCBpLk1YOTUgYW5kDQo+ID4gaS5NWDk1Mi4gVGhpcyBhbGxv
d3MgdGhlIGJvb3Rsb2FkZXIgdG8gb2J0YWluIHdhdGNoZG9nIGJhc2UgYWRkcmVzc2VzDQo+ID4g
ZnJvbSB0aGUgZGV2aWNlIHRyZWUgaW5zdGVhZCBvZiB1c2luZyBoYXJkY29kZWQgdmFsdWVzLg0K
PiA+DQo+ID4gLSBpbXg3dWxwOiBBZGQgd2RvZzIgbm9kZQ0KPiA+IC0gaW14OHVscDogTWFyayB3
ZG9nMyBhdmFpbGFibGUNCj4gPiAtIGlteDkxL2lteDkzOiBBZGQgd2RvZzQgYW5kIHdkb2c1IG5v
ZGVzDQo+ID4gCSAgICAgICBNYXJrIHdkb2czL3dkb2c0L3dkb2c1IGF2YWlsYWJsZQ0KPiA+IC0g
aW14OTQzOiBBZGQgd2RvZzQgbm9kZSBhbmQgbWFyayB3ZG9nMy93ZG9nNCBhdmFpbGFibGUNCj4g
PiAtIGlteDk1L2lteDk1MjogQWRkIHdkb2c0IG5vZGUgYW5kIG1hcmsgd2RvZzMvd2RvZzQgYXZh
aWxhYmxlDQo+ID4NCj4gPiBXYXRjaGRvZyBub2RlcyBhcmUgbWFya2VkIHdpdGggImJvb3RwaC1h
bGwiIHRvIGVuc3VyZSBhdmFpbGFiaWxpdHkNCj4gPiBkdXJpbmcgZWFybHkgYm9vdCBzdGFnZXMg
d2hlbiBpbml0X3dkb2coKSBvY2N1cnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBH
dW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm0vZHRzL2lteDd1
bHAuZHRzaSAgICAgICAgfCAgNiArKysrKysNCj4gPiAgIGFyY2gvYXJtL2R0cy9pbXg4dWxwLXUt
Ym9vdC5kdHNpIHwgIDQgKysrKw0KPiA+ICAgYXJjaC9hcm0vZHRzL2lteDkxLXUtYm9vdC5kdHNp
ICAgfCAxMiArKysrKysrKysrKysNCj4gPiAgIGFyY2gvYXJtL2R0cy9pbXg5My11LWJvb3QuZHRz
aSAgIHwgMTIgKysrKysrKysrKysrDQo+ID4gICBhcmNoL2FybS9kdHMvaW14OTMuZHRzaSAgICAg
ICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAgYXJjaC9hcm0vZHRzL2lteDk0My11
LWJvb3QuZHRzaSAgfCAxNiArKysrKysrKysrKysrKysrDQo+ID4gICBhcmNoL2FybS9kdHMvaW14
OTUtdS1ib290LmR0c2kgICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gICBhcmNoL2FybS9kdHMv
aW14OTUyLXUtYm9vdC5kdHNpICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gICA4IGZpbGVzIGNo
YW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9k
dHMvaW14N3VscC5kdHNpIGIvYXJjaC9hcm0vZHRzL2lteDd1bHAuZHRzaQ0KPiA+IGluZGV4IGJj
ZWM5OGI5NjQxLi40NWE2OWYwNmUyMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9kdHMvaW14
N3VscC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDd1bHAuZHRzaQ0KPiA+IEBAIC0y
OTUsNiArMjk1LDEyIEBADQo+ID4gICAJCQljbG9jay1uYW1lcyA9ICJkaXZjb3JlIiwgImhzcnVu
X2RpdmNvcmUiOw0KPiA+ICAgCQl9Ow0KPiA+DQo+ID4gKwkJd2RvZzI6IHdhdGNoZG9nQDQwNDMw
MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC13ZHQiOw0KPiA+ICsJCQly
ZWcgPSA8MHg0MDQzMDAwMCAweDEwMDAwPjsNCj4gPiArCQkJdGltZW91dC1zZWMgPSA8NDA+Ow0K
PiA+ICsJCX07DQo+ID4gKw0KPiA+ICAgCQlwY2MzOiBjbG9jay1jb250cm9sbGVyQDQwYjMwMDAw
IHsNCj4gPiAgIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcGNjMyI7DQo+ID4gICAJCQly
ZWcgPSA8MHg0MGIzMDAwMCAweDEwMDAwPjsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRz
L2lteDh1bHAtdS1ib290LmR0c2kNCj4gPiBiL2FyY2gvYXJtL2R0cy9pbXg4dWxwLXUtYm9vdC5k
dHNpDQo+ID4gaW5kZXggMzBiYWFlZmY4ZWYuLjU0ZWNiY2YxNzk1IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtL2R0cy9pbXg4dWxwLXUtYm9vdC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRz
L2lteDh1bHAtdS1ib290LmR0c2kNCj4gPiBAQCAtNjEsMyArNjEsNyBAQA0KPiA+ICAgCX07DQo+
ID4gICB9Ow0KPiA+ICAgI2VuZGlmDQo+ID4gKw0KPiA+ICsmd2RvZzMgew0KPiA+ICsJYm9vdHBo
LWFsbDsNCj4gPiArfTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDkxLXUtYm9v
dC5kdHNpDQo+ID4gYi9hcmNoL2FybS9kdHMvaW14OTEtdS1ib290LmR0c2kgaW5kZXggNWI2Mzlj
OTY1ZDYuLjE0OWY3YmM2ODVhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg5MS11
LWJvb3QuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg5MS11LWJvb3QuZHRzaQ0KPiA+
IEBAIC05MCwzICs5MCwxNSBAQA0KPiA+ICAgCQl9Ow0KPiA+ICAgCX07DQo+ID4gICB9Ow0KPiA+
ICsNCj4gPiArJndkb2czIHsNCj4gPiArCWJvb3RwaC1hbGw7DQo+ID4gK307DQo+ID4gKw0KPiA+
ICsmd2RvZzQgew0KPiA+ICsJYm9vdHBoLWFsbDsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ3ZG9n
NSB7DQo+ID4gKwlib290cGgtYWxsOw0KPiA+ICt9Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9kdHMvaW14OTMtdS1ib290LmR0c2kNCj4gPiBiL2FyY2gvYXJtL2R0cy9pbXg5My11LWJvb3Qu
ZHRzaSBpbmRleCBkYzg2NzQ2YWM5MC4uYTg0Y2RmMmJjNDUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vZHRzL2lteDkzLXUtYm9vdC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDkz
LXUtYm9vdC5kdHNpDQo+ID4gQEAgLTk2LDMgKzk2LDE1IEBADQo+ID4gICAJCQkgICAgICAgMHgw
MDAwMDFiMiAweDgwMDAwMWI2PjsNCj4gPiAgIAkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47
DQo+ID4gICB9Ow0KPiA+ICsNCj4gPiArJndkb2czIHsNCj4gPiArCWJvb3RwaC1hbGw7DQo+ID4g
K307DQo+ID4gKw0KPiA+ICsmd2RvZzQgew0KPiA+ICsJYm9vdHBoLWFsbDsNCj4gPiArfTsNCj4g
PiArDQo+ID4gKyZ3ZG9nNSB7DQo+ID4gKwlib290cGgtYWxsOw0KPiA+ICt9Ow0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9kdHMvaW14OTMuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg5My5kdHNp
IGluZGV4DQo+ID4gZDY5NjQ3MTRlYTAuLjUxMWU5NTk0ZTM3IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJtL2R0cy9pbXg5My5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDkzLmR0c2kN
Cj4gPiBAQCAtNDE0LDYgKzQxNCwyNCBAQA0KPiA+ICAgCQkJCXRpbWVvdXQtc2VjID0gPDQwPjsN
Cj4gPiAgIAkJCX07DQo+ID4NCj4gPiArCQkJd2RvZzQ6IHdhdGNoZG9nQDQyNGEwMDAwIHsNCj4g
PiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDkzLXdkdCI7DQo+ID4gKwkJCQlyZWcgPSA8MHg0
MjRhMDAwMCAweDEwMDAwPjsNCj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MCBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDkzX0NMS19XRE9H
NF9HQVRFPjsNCj4gPiArCQkJCXRpbWVvdXQtc2VjID0gPDQwPjsNCj4gPiArCQkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ID4gKwkJCX07DQo+ID4gKw0KPiA+ICsJCQl3ZG9nNTogd2F0Y2hkb2dA
NDI0YjAwMDAgew0KPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OTMtd2R0IjsNCj4gPiAr
CQkJCXJlZyA9IDwweDQyNGIwMDAwIDB4MTAwMDA+Ow0KPiA+ICsJCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDgxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCQkJY2xvY2tzID0gPCZjbGsg
SU1YOTNfQ0xLX1dET0c1X0dBVEU+Ow0KPiA+ICsJCQkJdGltZW91dC1zZWMgPSA8NDA+Ow0KPiA+
ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4gICAJCQl0
cG0zOiBwd21ANDI0ZTAwMDAgew0KPiA+ICAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAt
cHdtIjsNCj4gPiAgIAkJCQlyZWcgPSA8MHg0MjRlMDAwMCAweDEwMDA+Ow0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9kdHMvaW14OTQzLXUtYm9vdC5kdHNpDQo+ID4gYi9hcmNoL2FybS9kdHMv
aW14OTQzLXUtYm9vdC5kdHNpIGluZGV4IDM0NTc0NDJhM2IwLi5mY2EwZjEwYzg2NQ0KPiA+IDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg5NDMtdS1ib290LmR0c2kNCj4gPiArKysg
Yi9hcmNoL2FybS9kdHMvaW14OTQzLXUtYm9vdC5kdHNpDQo+ID4gQEAgLTE1OSw2ICsxNTksMTgg
QEANCj4gPiAgIAl9Ow0KPiA+ICAgfTsNCj4gPg0KPiA+ICsmYWlwczQgew0KPiA+ICsJYm9vdHBo
LWFsbDsNCj4gPiArDQo+ID4gKwl3ZG9nNDogd2F0Y2hkb2dANDkyMzAwMDAgew0KPiA+ICsJCWJv
b3RwaC1hbGw7DQo+ID4gKw0KPiA+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGlteDk0LXdkdCIsICJm
c2wsaW14OTMtd2R0IjsNCj4gPiArCQlyZWcgPSA8MHg0OTIzMDAwMCAweDEwMDAwPjsNCj4gPiAr
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICAm
Y2xrX2V4dDEgew0KPiA+ICAgCWJvb3RwaC1hbGw7DQo+ID4gICB9Ow0KPiA+IEBAIC00NjAsMyAr
NDcyLDcgQEANCj4gPiAgICZzcmFtMCB7DQo+ID4gICAJYm9vdHBoLWFsbDsNCj4gPiAgIH07DQo+
ID4gKw0KPiA+ICsmd2RvZzMgew0KPiA+ICsJYm9vdHBoLWFsbDsNCj4gPiArfTsNCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDk1LXUtYm9vdC5kdHNpDQo+ID4gYi9hcmNoL2FybS9k
dHMvaW14OTUtdS1ib290LmR0c2kgaW5kZXggNmRlYzE1OTc1MmIuLjJmZGI3ZTMzMWI2IDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg5NS11LWJvb3QuZHRzaQ0KPiA+ICsrKyBiL2Fy
Y2gvYXJtL2R0cy9pbXg5NS11LWJvb3QuZHRzaQ0KPiA+IEBAIC0xMzgsNiArMTM4LDE2IEBADQo+
ID4NCj4gPiAgICZhaXBzMiB7DQo+ID4gICAJYm9vdHBoLWFsbDsNCj4gPiArDQo+ID4gKwl3ZG9n
NDogd2F0Y2hkb2dANDI0YTAwMDAgew0KPiA+ICsJCWJvb3RwaC1hbGw7DQo+ID4gKw0KPiA+ICsJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDkzLXdkdCI7DQo+ID4gKwkJcmVnID0gPDB4NDI0YTAwMDAg
MHgxMDAwMD47DQo+ID4gKwkJY2xvY2tzID0gPCZzY21pX2NsayBJTVg5NV9DTEtfQlVTV0FLRVVQ
PjsNCj4gPiArCQl0aW1lb3V0LXNlYyA9IDw0MD47DQo+ID4gKwkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gDQo+IEkgdW5kZXJzdGFuZCB3aHkgImJvb3RwaC1hbGwiIGlzIGluIHRoZSB1LWJvb3Qg
c3BlY2lhbCBmaWxlLiBCdXQgdGhlIG90aGVyIG1haW4NCj4gcHJvcGVydGllcyBkZWZpbmluZyB0
aGUgd2F0Y2hkb2cgZGV2aWNlIHNob3VsZCBiZSBpbiB0aGUgY29tbW9uIGR0cyhpKSBmaWxlLCBu
bz8NCj4gDQo+IENoZWNraW5nIG1haW5saW5lIGtlcm5lbCBJIHNlZSwgdGhhdCAiYm9vdHBoLWFs
bCIgaXMgdXNlZCB0aGVyZSBhcyB3ZWxsLg0KPiBJdCBzZWVtcyB0byBiZSBhY2NlcHRlZC4gU28g
d2h5IG5vdCBtb3ZlIGV2ZXJ5dGhpbmcgaW50byB0aGUgY29tbW9uIGR0cy9kdHNpDQo+IGZpbGVz
IGluc3RlYWQ/DQo+IA0KPiBUaGFua3MsDQo+IFN0ZWZhbg0KPiANCg0KSGkgU3RlZmFuLA0KDQpG
b3IgcGxhdGZvcm1zIHdpdGggQ09ORklHX09GX1VQU1RSRUFNIGVuYWJsZWQsIHRoZSBEVFMvRFRT
SSBmaWxlcyBjb21lIGRpcmVjdGx5IGZyb20gdGhlIHVwc3RyZWFtIGtlcm5lbCB0cmVlIGFuZCBz
aG91bGQgbm90IGJlIG1vZGlmaWVkIGluIFUtQm9vdCwgc28gdGhlIHdhdGNoZG9nIG5vZGUgaXMg
YWRkZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgeHh4LXUtYm9vdC5kdHNpLg0KDQpGb3IgcGxhdGZv
cm1zIHdpdGhvdXQgQ09ORklHX09GX1VQU1RSRUFNLCB0aGUgRFRTL0RUU0kgZmlsZXMgYXJlIG1h
aW50YWluZWQgbG9jYWxseSBpbiBVLUJvb3QsIGFuZCB0aGUgd2F0Y2hkb2cgbm9kZSBpcyBhZGRl
ZCBkaXJlY3RseSB0byB4eHguZHRzaS4NCg0KVGhhbmtzLA0KQWxpY2UNCg==
