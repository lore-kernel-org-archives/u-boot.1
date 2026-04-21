Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6733DF8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7707805D7;
	Tue, 21 Apr 2026 14:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OdXSXRvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F0F83693; Tue, 21 Apr 2026 14:24:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C1E801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI8949UyZj5/amxqJPKOniAA/4nhc9Vc2q1RyhfreJv54oXSPa44DLC8H4aeTmXn+VldPcmT4jo21thwkTkW26ujRFnew1Me45swfCVLmOS5aNjuCBUuhvrCv6F+yn1jvfxfbrQDtapgXK2AM7W6X7HZAajxbR+rvOEFq2OL3GoAjcexTV7rmYi7DN1kHtDI5M0m9rr59gZOlpJ9RB3kcsWvOC/9xtedPtDmSBGSWMgUMKYsAaruq5yObTtWhcfyxX056kUAVA9/FFxUjIPQaVW2iQSU0lP/INLh2+rkIooccz4F2DbBbicKYSIZsd5M3FBhnkwgEA9ohiPeiLTKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILid8zTPLjAL3LFeDrlxvyNwcy+pe5OfEKqTZwmBMJ8=;
 b=KpTWiv5xKJZgPpNYzMxgfZgPezRbt+0D7AkZxbjtNJwGLMEsJc8lwOWhsvAOpHpaBX/CULFAIx/jV8YIIGGBZZIcxXxNXupPLOnTu/kDSLxeRJuftzqMSAchbLrVni9uZ7AeYPSHeFHaQ7YVlsP8Y7hW9DQuzw63HB8SNN8UkrMIeO04VUrDFzxPgJIcI1vKMVOpCQfU8fe7RBfjl2JG6HmcZbJpXg60uGfsCm0utOS2PKYZ44z6EYVAGlmFRDpS8D/AkFYVl8Yi76OPkgOE807dT4BaKNjCZC2Y2Lt0O1jW8Yz2n0APirdQ/9TZwbd850+qVAe7urkMZbgS6CaWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILid8zTPLjAL3LFeDrlxvyNwcy+pe5OfEKqTZwmBMJ8=;
 b=OdXSXRvCwMq5/bGuUbsw8nc3CpaWq32+dTLSKSCI33Lphcpydbgnq7iQf7ifrp/DpuqFEOzoc1O9jMUZ10oNDNSkaVL4hAuff2x+yAjxRPyYU4G4GNutgUlFFE9a7T1WJ1VsAD5VOPW6qzi1Q7AJOVVNkDUWf+vlJQ4JIhXuBjsYfNsr+qQesK6LvCXlyUmdq4rGNqxAyv8v1pCJJbBVqdxuEVxH6svLF+AUe5RkqX9sf7OhEN3DvqeWYMHN97R4zYpDEOfzvdVHtPMgBBQw/XpuImP7OK2rOdXnG9HK6UgHbp7/J87NE/tnBwh8AyS0osN0143GWt49vziu312z2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:24:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:24:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/15] i.MX8MQ: Convert to DM_PMIC for a few boards
Date: Tue, 21 Apr 2026 21:41:12 +0800
Message-Id: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHh+52kC/x3MQQqAIBBA0avErBtQMY2uEi1Cp5qFVgohSHdPW
 r7F/xUyJaYMU1ch0cOZz9gg+w7cscadkH0zKKGM0NIihzKGG33AK7BDpa0Qkoxxg4IWXYk2Lv9
 wXt73A1lDct9gAAAA
X-Change-ID: 20260417-imx8mq-dm-pmic-247001e66c52
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUYPR04MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: 95808eed-f8c2-422a-a209-08de9fa0fb1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SehUpzwDFziAkCObis4uN6bTvjAkFpC9SVkwulsqHdO+stkWxfMq1YJnYewh95iIZkrUZ+xH+JAaH4JmITjxiSn574Hj714k//rv8auokgcFQbxm7BISdR9bowKW6ym9YSARpSDFYOP5BH5T78dyZhhkhgbsumElu+tW/BqrNrqO5WzT9FU+31BnFcuPLhJ3Mi93mrrngmib0zAmEPl6bzlctTdOgNJufa7TDEPiaVku+VORn3uHzLGbePgrJoLovXj1WSr2zls5kf3wJ6+UUpnvqvipuE2ys9CYA+4RWmC7TBNJc1Enewm2+eWdoDa/KDzY1GQd265wnPJSspsB+BS/vJTjxQGRdVgjbPlUmm3en/ZMbN6o/NajnEVoU40e/qAbFEMZEG4EtB21OwgqvjR9mcXOw9QBzjGdCld71nW1vAWlTkZOXsEDn7uS8SQLDTbNoAUwk5C+YZsp29aumqFJBUwmY9QgCov8EuykQb693Y/4ffyS9suA4JzTbGL8IxcHwEG3+hOnMj1bRgg19O/nrxfS1FSCGo/9QCQ0oB0E+HyiWcVR61ZyeT9tYueAkBLYWynzWxpK4YSj/MieJt28ksHKRWLkK76bsppAuxhOL/Ucg1dhADFInS+C06qe+0AEvu2v4mQ1H0Exioc7hqK9OkSksIluXPIkAU3MOoeXTwLJX1c7hMsNERqba+yQuQ+ZC7yr+brrhcsXgHxs0nQNSXLJClKx3XN2ccXyobuElv+DLKdL7qf8AE3E+6cjew8O4kAuAcA2ZwTT9QnbgUYFQx1dMqnO2x61rspcUXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JqZERCaFFsTkVoZUdmd1JpOSs4NG44d0xWYVpnWnY3dTIzMDdGV3g0RjRZ?=
 =?utf-8?B?VFk3YjNjT3B2YTF1di8xRmNNYTBXRDFPbjl3a1RvdjdGeEVzbVZuelkwT0lt?=
 =?utf-8?B?MUpoc3dEU2V0dk9nbkJNTVhxV0RFSDkvcEVTT1lxVm5HdEwrU3E4cTFVQXNm?=
 =?utf-8?B?aGdmYTRJVHNEVzg2Ym96bHlKQnZoU2lqcDFtZm05L1pEeUJscUFuWHFsNEZN?=
 =?utf-8?B?YWR6VDVvWWVzMGJqWmliMG9vNVpLT05HK3pya2RiZSsyRGNGMVp4VGVrNUdT?=
 =?utf-8?B?c3ZrZnFzYWxVWE1XYStFblI5YlNLVFlnMkwvR1M4S20zZjk4dEQrN1lMdnpw?=
 =?utf-8?B?a2J5MzZlVlJpSzNBWXRoZjFReC85N1NUL0NwczZ3dE5Cd0lGNHhlTldCU2c2?=
 =?utf-8?B?U1Bpa3VaR1Brc3V2RldFRUJ5V0VhVXNobG1VZnYvS1cra1Z0ak13eFh6eWpL?=
 =?utf-8?B?ZEN5MytxRkVLZDJRTGlFQ0FzaE9NSi9tbDdpYk5waVN4YmNjdU82cHEzOW5Y?=
 =?utf-8?B?WXJFUFlFVmhoMFFmMGF1cVpZbzgzUDRtMm11MGJRS3NGaFR3K2JwZXpHTC9w?=
 =?utf-8?B?ekY4ZXd0S1UzNldoVGR5ZUpjdzFMZzB0T3Jia0Y5Umh5emluK2VEUVBZcUVk?=
 =?utf-8?B?b3R1cUZhcWhrMy94QmVxSUpRRjQrbm8xNk52UncwTmFtL2dwREdBakJjZnZt?=
 =?utf-8?B?UUo1S0FIUlYzb3FVcVNzRVZnR0FQaFVRLzdZZWpBY3ZuVmpGem1FUi9jcXph?=
 =?utf-8?B?WlJoODZwcldEWVRTdDF5cDFpUlhYUW9LOUc3RnE5Mmc2T3I4ZG9Bb0dGTStx?=
 =?utf-8?B?MDNMSVdVOTl4OVlkVEx1elQrY2xmNy9MT3F6OVlKS25xV3V3dDZOcXVNS25Z?=
 =?utf-8?B?U2o2blNCNW5lL1o5cjhFVkdsaDJFY1dxdWFzOWlsSUhRWWJUL2s2MjlMM3gw?=
 =?utf-8?B?dlI3dzAweVdGUFhsZHhUd2N2T1A4cGplOTJZbVpkdXQwVW1mbzZaekQwU1Yr?=
 =?utf-8?B?Zk5yQzRnTTJyOGpzc1NLY2ZRbys1SDZhKy8wQktjam81SHhHT2ZrSUk4N0ZR?=
 =?utf-8?B?Szdyczl4Sk5Bems5U2g4dzM4QzZxRktnS0lORTdEbDVlYmtDd3RhaU5OcmNa?=
 =?utf-8?B?QnQyZHY2Tm1ORVMzazJwelFvYi9ZaDRiZDg0Q01WcXU4cndSSHUzalJHM3dG?=
 =?utf-8?B?d1p3eGFQczhoYzhvbjBKMlBUWEJoamwybEZPY0hyeEcwOVFDUEVOWk9EaGEx?=
 =?utf-8?B?ZGw2UVZnUFQyb1VjQXROOENOVXhQV2RpMW5sSGVtSzhUVDUxSzN1S3ZhZmlt?=
 =?utf-8?B?dE9sWHFNcndsYWVyWFpRZ1JmNFd6ekx2bE9Iem9UVlJsTnEyYmd5OGgxUjVr?=
 =?utf-8?B?dUVzRnZkTUJYeVZPei9YaXdQWDV0MHRoSWF2RXFIR0tzNmpqRzJQdzUrUXV5?=
 =?utf-8?B?VzIxenNyZEN4MVZpU1F2WUpsSitKclFMa01JaFVLOXJFWWhFM0RDNHZLbkZC?=
 =?utf-8?B?bEFhYVhxL1M4eWw4enVsekVmaTBkQklJQ2IrUDluU2hFWi9sZnJKMFV6VC9o?=
 =?utf-8?B?YTJmNmw5QU1SWFF2emVtZnNaVzNRTzZtZUVhOHJDODhqLzNpdzdsdGo2bUV5?=
 =?utf-8?B?TmlzREpxZ3lzLzUxL0lLS3Q0YS9OSHVacmNONjlkb3pyS3IxK0hXZWcvRTY0?=
 =?utf-8?B?YmdMT0N3ZVdCZEw3TU5zY3RmMjZZcWVRelFuaUV0cFd5dUwwVVdiWXBKdUha?=
 =?utf-8?B?eG9VY2w2TEZ4MVkvZkhXL2g3YzlMQ1lmdXhQU3lKcDVwZy96cm9SUlMxNUE5?=
 =?utf-8?B?aU1PRU1PZXFxcTFRVUxha2p1TmFJYkJKdXlYS1hEVWF3V1R1K0NXMWc5bVlj?=
 =?utf-8?B?am1KT2JSS0pHUU5SU0wxNG9vZWdCTUkrT3h5VUFVaXhNUEkzcW5zZVF3VXBw?=
 =?utf-8?B?bTVHbjBUSnduWExtaE5pWFJya3J2YVozNU1Od1NQK0hwWUVOVzNNb2JWSVl2?=
 =?utf-8?B?dXBVOGQvdGxqVGtjYU56K2ZJSXluRncvQ1lRK2gxWEZ0NFcyQW1zdnRmSFY3?=
 =?utf-8?B?L0JiTk95YWxDT0t0cElNYUtPMCtEMDIvakFkNzMzdE4waGlLM0w2aHZwWm5Y?=
 =?utf-8?B?dGROMk83RjBCTDlHOVJMdnMycy9NWUlaZ25IWkZEOTVCa3FFTlpmSTNrbFlp?=
 =?utf-8?B?elhBUFpJUzYrblFaTkovS2JQem1XdzFNcnNiZEc2VGdJY1dMb2QzSGhET1Vq?=
 =?utf-8?B?c05ORVhUTlMvOHRQVjZ1cXJqdDJGTkEzcDlRMmIxdzdCUFo4SEE2Vkl2ek40?=
 =?utf-8?B?M21LYmFnSllQcWNtanBka1NMTXBBaFFhSElObURMZ0xvTExsREpJUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95808eed-f8c2-422a-a209-08de9fa0fb1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:24:49.8609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaZoEVL0MSau6ZPjdTZTZ26SknSAdOFWatXybUuXyzhGVKLovQdOQpcVERwbLwpse80Nv87aAeBJ+BonoNRPcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12667
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

Per the thread [1] that Tom asks.

Convert to DM_PMIC for i.MX8MQ boards. Only tested on i.MX8MQ-EVK.

I not have other boards to test, so just my best practice to do the
migration.

While doing the migration, several cleanups are done by dropping
redundant gd clearing in board_init_f

For i.MX8MQ binman, because with SPL DM enabled, the image size is
large, TCM is not that big. After checking, found that hdmi firmware was
placed at wrong place, so fix the i.mx8mq binman support with patch:
"imx8mq: Correct signed_hdmi firmware position."

THe remaining patch is mainly for migration to DM PMIC, for
pico/reform2/phanbell, no pmic was used, so just drop SPL_POWER_LEGACY.

For imx8mq-evk and kontron board, enable SPL_DM for the migration.

More information could be found in patch commit log:

[1] https://lore.kernel.org/u-boot/20260320214518.GD502704@bill-the-cat/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (15):
      imx8mq: evk: drop redundant gd clearing in board_init_f
      imx8mq: pitx: drop redundant gd clearing in board_init_f
      imx8mq: phanbell: drop redundant gd clearing in board_init_f
      imx8mq: reform2: drop redundant gd clearing in board_init_f
      imx8mq: pico: drop redundant gd clearing in board_init_f
      imx8mq: cm: drop redundant gd clearing in board_init_f
      imx8mq: Correct signed_hdmi firmware position
      mx6: sabreauto/sd: Exclude power_init_board from SPL build
      board: nxp: common: fix PFUZE100 DM build and unify DM/non-DM handling
      imx8mq: evk: Migrate to DM PMIC framework
      imx8mq: phanbell: Drop SPL_POWER_LEGACY
      imx8mq: reform2: Drop SPL_POWER_LEGACY
      imx8mq: pico: Drop SPL_POWER_LEGACY
      imx8mq: kontron: migrate PITX-IMX8M to DM PMIC framework
      imx8mq: phanbell: enable SPL DM

 arch/arm/dts/imx8mq-evk-u-boot.dtsi                |  88 +++++++-
 arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi |  64 ++++++
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi         |   2 +-
 arch/arm/dts/imx8mq-phanbell-u-boot.dtsi           |  41 ++++
 arch/arm/dts/imx8mq-u-boot.dtsi                    | 240 +++++++++++----------
 board/google/imx8mq_phanbell/spl.c                 | 127 +----------
 board/kontron/pitx_imx8m/spl.c                     | 188 +++-------------
 board/mntre/imx8mq_reform2/spl.c                   |   6 -
 board/nxp/common/Makefile                          |   2 +-
 board/nxp/common/pfuze.c                           |  96 ++++-----
 board/nxp/common/pfuze.h                           |   2 +-
 board/nxp/imx8mq_evk/spl.c                         | 186 +++-------------
 board/nxp/mx6sabreauto/mx6sabreauto.c              |   2 +
 board/nxp/mx6sabresd/mx6sabresd.c                  |   2 +
 board/ronetix/imx8mq-cm/spl.c                      |   5 -
 board/technexion/pico-imx8mq/spl.c                 |   6 -
 configs/imx8mq_evk_defconfig                       |  21 +-
 configs/imx8mq_phanbell_defconfig                  |  14 +-
 configs/imx8mq_reform2_defconfig                   |   1 -
 configs/kontron_pitx_imx8m_defconfig               |  16 +-
 configs/pico-imx8mq_defconfig                      |   1 -
 doc/board/nxp/imx8mq_evk.rst                       |   4 +-
 drivers/ddr/imx/phy/helper.c                       |  13 ++
 23 files changed, 484 insertions(+), 643 deletions(-)
---
base-commit: 831aded3966e4a7e5200bde834887b801e9e9b98
change-id: 20260417-imx8mq-dm-pmic-247001e66c52

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

