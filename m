Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5520BE9A741
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9135F80212;
	Tue, 24 Mar 2026 10:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JD8rCbJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D13780517; Tue, 24 Mar 2026 10:14:52 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587D680087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkMOhLeYLPlDCYeszB3+iakF4WFL1AQ5gE5cJnY8uX/slQVPFtKy3SpnzjbJBx2wFDZ3F/YgS1EJwrloOR57LgGBe2Kqhz0EMMdVaSS+h4+EoSt5YzXWZvku0SWU8Mxy5mbyq9YombfXI7DGhtbyV2st6Vv2j6QF1JpPRZkkUH5jH11ZFsVSGhUeVRD+QkN8Sc6tG6IeKr/2QZGQgIbBYIflDj+OPSpIIy/5mTO8EweDZyNozzbDaQjiWfa4R5H/G+0Os5M8Xtvn2y3SBrYh32a80IGeaHw7VbON/xknwabZEWXT4ypLQGYBxGDbrpKWrivZMMU9xQQ5F+H86Y468g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4ldys95YcsnfjR0wCNk4aP5B+dbC7+cAJi+i0Yn/UY=;
 b=GGVnNyKuSvp1CY96F2EPwxkZDK9bBXyUG7v1lB5x4EznwU/KgUMTTayE2bHwlukn7JxkuYxpa2RGJ4zSkr+i1mWTSB0qNuRUBznlI+Zxzt3ZMkWvBeoh5OlRLgW1pjHveIqY8y9HXmtsvMk3aWX01FSGVWNyZqvD7lGaZWRU0G47UHaw/RUF5qyQNVfgOIShzSffJBiDY2sHgxrdFU1lGl4QdSDEI1xL2Q2/3bpFuQ/JLp0wIYmU0dDVsD5D1ddTSLdudXpMPzT+09Y1fO92bPNjkB2OugAJUalGSq2k5JeSowiOxq0t9N3qmUiEyrTrEoYL2wps3b+RQSmkGgNNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4ldys95YcsnfjR0wCNk4aP5B+dbC7+cAJi+i0Yn/UY=;
 b=JD8rCbJTbdPYmK1VxsG+Hpt2ogqYg7xPF3VUsp68DbCk7L4zL1QTHpR5w/kEP8okKTCKvm2yl2KvUPGzjh+dQ1j4eY7YYcJns3KGSPTGYihC1fgoanWELpm7xkTPtDi2F7oOVxL6WANWgN2RqTSUvjA3SZoLgC/kTautZY3Nwp1Ftw3S8dkjPhTzpf2u7W6ZlfKBk6zVkOLvircb2EsMY/Y/lR+MuTS295BDy8Eh2vkNYGayV4HV71HIwBtAhSPbUSVYBm2ENdT1SDCpjzWcx2ODwLh6tCr1WGeSoh9TLscI1XOfqCsahd41I/nVG38JErpIvzpRzJWrdWwBt/BY7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:14:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:14:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] i.MX8MP: Convert to DM_PMIC for a few boards
Date: Tue, 24 Mar 2026 18:30:30 +0800
Message-Id: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdnwmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNj3YL88tQi3ZzU9MTkSl1TSyOLVJM0w5SkJEsloJaCotS0zAqwcdG
 xtbUA774iU14AAAA=
X-Change-ID: 20260323-power-legacy-5928e4f1dbb9
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e85b5c-8d15-4d9b-069b-08de8985bf2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: huYIhw1BSdop4TVqUl1YY0hxAgyibCSzzgDwCa0nxUFSxJnGPHDIzIVGGwCKunxzjL6eGfz8dkoAq30Er2omv1vMlBtqs6MGUUe//aWFRAdmePFoPSh0TLldJLWYo3mUbN3brOFykWJarfuqx6AioVKbVgW8rqzKk8WZ8mar60Uwe9a29Ong+1c2+/IwpL/Gl7GSo6DteycqbDSeJUEZudE+zWXJSI2fIBeeeHFG/SXvtfQRU+GNSkvs4sM+0c6YwSmRk/PHEa7Vz7GfJdNa8DlW0/TushLEIfGSZYuJUJUhxYW8u6CvC+A+lYjysCyYGQlPn6vYAC396dX4PeTJJDTWexxautit7rfUHA0FHc+loSicmPTT8SeXWl1csvU2VXyRO3MTAmiBuAJiR6qPPtaEq9JuQNxpPq3EP8QAjaE06vh3yCjx2HjJmFD4WTxY+/H8RJ2K5IrxP+uLNZOONXwBD5mTD736upsJr4l6OOAIBpP5OZ9xywD8Aws1DESXfPYHpe5Vjr+PmPhHESqXND4lJda0BYtVu1hc3dcV1UwObo+lvInxW8h+Ld4OxiPmKn0WAKdXyMZ4TXKX+bJHMChWM5CZuh6aTQEdSjR1sgyGOzDZWL691yUNrTtIiBo/OVXil/m8y/iEJ+4IXNdNLcnDWJUbN4+m2D209WEY58q1kjO+JBhfsoV//fAuGB4ShCCRsmYhI87nHKsptMzQBm0WiNfxxXdKDmWeLtJpdj+b3Ce3bKw5hvUdtWnqoc+G0Wlkqzxq0lYaWKKRZu4MoiCGytGX1iOuhT9LSjPA0V2ifHErmLLgzHIseQDvzDfe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZCTHR6aUtBa0dQZ2xiZkVIOUU5VUt6L2Y4eFZFTG01VUZwSG0zVm84TzVv?=
 =?utf-8?B?YTRITTl0ZVJxQU5UTFVLT2o4N2xHUXo0RG5iY0t6OTVYUHJPYzRPcVdYR2tv?=
 =?utf-8?B?NzB0WkFWNHlJRThYK0R4ZnpUajBSdGg3SXhNN0F0MUVPRFpyaGk0bXMyWEp0?=
 =?utf-8?B?WXBtQmlYQUI1cmMyR2xyRW02MXVYMzAra0ZneXRFWC9FTkdHRTRpdTFtYTcv?=
 =?utf-8?B?aSt1aUU0OUNFU2p0eFZISE1NdnYzU2ZiK3orQml5RkRsTlpxNTdjTWpaNkhn?=
 =?utf-8?B?VXl2QVBWaFE4UmZXam5QWDBpM1hHWDlncTRmOEFxSXNmKzIzVGtlR2ZSMnV0?=
 =?utf-8?B?RGdMZ2NKZHlvZ3JpeldDSUk0QkNDSXlZc3k3SGQwMm42OTNib1lEY05uaWpr?=
 =?utf-8?B?amFhcnhLMXhGVUVaWTluVGxtTFdRd1NOVnhWWGd3MDVUL241eFlCYklUMDVr?=
 =?utf-8?B?bGVrSE9VMEJOMUJBS1pQbXZDRFlLL2QwWCtjQmQrSzQvQmx4TjM1U0dGMmNa?=
 =?utf-8?B?TC9YU244Nzh5Rk5LL1VSVE1WckhVK1E1RXRCc1VtTWI1NjBzeWtndVl5cHlP?=
 =?utf-8?B?VHErOE43Q1VKYVNCSW8yMGNudUxMS2x2eUVwTlRNd1lpWTh1TTBoUnUzMlRJ?=
 =?utf-8?B?WG1ZcDlNa2dkaUZyU3FRREwwdzVTRjN0RzZ1em1PMU5ibjkvUGdXTEk1UzJS?=
 =?utf-8?B?ektGVldKMXZ3U0pUcTFQSFFJN0NVK2lKU3hoU2xmUkt4cjFxRmluelZFTjcw?=
 =?utf-8?B?OXNvSloyVDZUUXl6ck9jUzVvVTM4MFJTc2EreVlpQ0h3QTdBbERtNEE5OUlu?=
 =?utf-8?B?b3JXZkxWSkt6SE9YWTU5Q2dVLzZrclJwQ3d2dVRhQzF5TzF1anJ6TUNpMVBD?=
 =?utf-8?B?RzNOL1JtTlpVMkVlZ3RkeDZsY0hTTjZEbGNIcFB4Z1hnbjVhUUVwd2tCcGVN?=
 =?utf-8?B?djZnd0RLbnprVnpmVmIzWHBUVmFuaUdBMnhjaW8valRabFpRekIyS21ORll5?=
 =?utf-8?B?Tk03bkZjRlRRVk5Cc2loZEJXai9LdkdiUXUvYWZ2UVlqQnpySHVVMWRCWWxD?=
 =?utf-8?B?TXA1ZVIybG82OUd4OE5PS2ZOUzNjWGo1L1NoOVc1eGRrZDVTRSsvekVNUFV6?=
 =?utf-8?B?SFlmbWM3emV1ellMd2JRbVMxdXUvNGdESHB0UXcxWjl3WXpwcjNoUGF2cFp4?=
 =?utf-8?B?cnhTMlBKa1VYVU1BbFk5aVp5R1E2eDA0dEI5Z2I1bTFGS2E2QXB3ZGZHRUlE?=
 =?utf-8?B?L3QzTGhjYW53WStGWHRIU0tmSEthaDdpdDFnVnh0dkpTenJPSk91SWZaTFlu?=
 =?utf-8?B?cm1CVytaNDZ3ZjlWVkl5Smo5Q2w4M0psbnhtYlF1Y00xWnFWeXdhUlE1Uis5?=
 =?utf-8?B?MnB2eWlndUlSbldSUEhSUjVFUDFCLzRmcWw2TFVPRk1rTCt2MjZVN2ZoNVZQ?=
 =?utf-8?B?T2JOaHVXUUFidFFuYWx4THpxelhWbmFjZWVFb056R2RmTXRRM1g1LzhzbGNN?=
 =?utf-8?B?LzVSZ1d6NkFTNmN3NWxaZnl4OFRtWXJadyszc3VkdHpSNndkN3BDczJpM2JI?=
 =?utf-8?B?bUswTzhnT1ZQTHRBN3BXbUxxSm94QnNIMUZiZ2dtTXp4akNsSkZ5ejIzUzBi?=
 =?utf-8?B?UG9aTEJXMmluMnM3eFl4V0o3Z0FsZDdhQlo4NWMzT1BmYmJ1U2VMQUtSYVJm?=
 =?utf-8?B?ajhuT0k2ek1JeDFHZ3JWMEFJZExFMlBYcGdhQUQyRW0zUnc5cGFVTEUyTUFY?=
 =?utf-8?B?SHEwT1BJUmE4MGdsb3BwV3pmMlhCN0tGUWx3WldTL1FSUUNCYTl6c1FzNXhv?=
 =?utf-8?B?STV0TEFjQjYzdGF2UlpaT0pPdmFKc3E3N3k3UTNkUW96ZmJBUlVaWnBveURo?=
 =?utf-8?B?VTQwOEpWK082bHJqbGFZbGJQWlBreUdKdFVEdkE3WXNCMVNBQ2RNTHhuaFIy?=
 =?utf-8?B?OS9rS3VHMmVUVlJkRFJZRXN1UVhKUFN0Q2tyR0pEdi92bmhVVzhPbnZxN2gr?=
 =?utf-8?B?YkdqOENuR1g3c0I2TGUzb2FyOWttUGNDZmpKTnZqUmI4cHR5d3hURHV3WWcv?=
 =?utf-8?B?d3BsU0VjMWY0ekxjeVVnblNXb1d1eGpjTFNIdHJhOFJWd0VjQjFVbzBRMk9I?=
 =?utf-8?B?cllXTGc0ZXA0R1M1ZHJwYTE0M1V1UENhczRzTEdYcGRWdHIwRjFPZ2xRbzJu?=
 =?utf-8?B?cjlIckIvNHc3UzlnNURIQytQeFN6c2RRTjlyWkJBbWhjMzloSkZrdVdWWnpp?=
 =?utf-8?B?eXBLVURaWVZRaEpkQzhWbjgzS0wzc0YvMm4yVUZxdlhpMUpvdHBRVS8ySGlU?=
 =?utf-8?B?b0FCQnlSaHRIYjRNT044eWg5bW0rYVZ2S0pUWWlDazBlVk5LdUpMUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e85b5c-8d15-4d9b-069b-08de8985bf2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:14:26.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOG4iZwS5C06kish9r/GcN0NX0Y0wLulvgvoAqLl9hMNGWKqoG8ZhGrvfxTyT5IOTKdPL9E0eLF4IHkUjbUXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
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

Convert to DM_PMIC for icore-edimm2.2, libra-fpsc, verdin and
phyboard-pollux-rdk.

I not have the boards to test, so just my best practice to do the
migration.

For i.MX8MQ boards that still using SPL_POWER_LEGACY, it is a bit different,
because the OCRAM is a bit small, I need find more time to check on it.

[1] https://lore.kernel.org/u-boot/20260320214518.GD502704@bill-the-cat/

CI: https://github.com/u-boot/u-boot/pull/916

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
      imx8mp: verdin: Convert to DM_PMIC
      imx8mp: libra-fpsc: Convert to DM_PMIC
      imx8mp: icore-edimm2.2: Convert to DM_PMIC

 .../dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi    | 18 ++++++-
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     | 16 ++++++-
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 16 ++++++-
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    | 14 ++++--
 board/engicam/imx8mp/spl.c                         | 53 +++++++--------------
 board/phytec/imx8mp-libra-fpsc/spl.c               | 46 ++++++------------
 board/phytec/phycore_imx8mp/spl.c                  | 43 ++++++-----------
 board/toradex/verdin-imx8mp/spl.c                  | 55 +++++++---------------
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      | 12 ++---
 configs/imx8mp-libra-fpsc_defconfig                | 10 ++--
 configs/phycore-imx8mp_defconfig                   | 10 ++--
 configs/verdin-imx8mp_defconfig                    | 13 ++---
 12 files changed, 133 insertions(+), 173 deletions(-)
---
base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
change-id: 20260323-power-legacy-5928e4f1dbb9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

