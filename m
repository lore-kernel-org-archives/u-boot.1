Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7426E9A742
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5316383952;
	Tue, 24 Mar 2026 10:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TmL5mfjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877C983AAB; Tue, 24 Mar 2026 10:15:10 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8051E838FA
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LErz4krU5KtpVMnz6n2YzaaYfLtYryTp5w4Mk1LLBWjMrw8QSBNjXjFI4nA8i5zjBTZmPiWxbPaITIhoTzug7euEHAfTEXMPvoDUr1noshWVXA5KJmxUbHT+z/7ShZgzd0lYr8prCZNccuYGeWU5FC9s1tHaPzGfVrepXAcRqpxfxiWaVNNKBmn56yqrO4lZsSInT5jzNPmY1B0k8WA5gpUs8mmajb8TOU4xWw4KFwPQ9v3ZIDhpEkKxqD7VxrYGm73aTy6xZBwpmQZO0g1PQSfnNJ18xc8PIodWzWzK3QErskQm0KTvJfEwNxh1vGH85H1ubmq147/gEKtRSZrjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFOu849W6a+kccuGM98h6frY19YANyaM2ivtnC3OQdc=;
 b=DW397cQKNgTuMsZd8773HoV5kYi7dEmBxi31KVQ3vagRrcNZmyeoPb89JAfGneoRpaexDn3ixCoGWqCyhZ9/CdayASJzf1Is7tdtFnojPtKZcb8DdzoNCypgxUpxEADZgElLEVjch6YNLpZqMXCWFiLCIQcJDLt2Tfd7dlgay+PI6ch1lvB63RdPJaMvNBG8Z9XbNKb6KMr+i9Ps3j/Gh8PEYz7GqJ9dq5Ddl+65f70kH75A4DB2z5kXz3XqwaFzuvTYMH/UgK0WVOUXYV2hWeDLPDTTin+4Nw2lESovFppJje57kTHDDLBEcEv+o+8MVNlAKNHuTJO004iYctxbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFOu849W6a+kccuGM98h6frY19YANyaM2ivtnC3OQdc=;
 b=TmL5mfjZKEK6W/V/j/uGRnmNgDXMSwrylb6kqnq/Gzo+IhCybsoYZCxpRtUWDwB7Zy7i0AB3tHEnyAmJSzVYep5WVGwgH9yQCzGUOL24Req52XQymg60Z76bcIL11U6EcVMBS1U2J9n0rbZlIeQgfH9MQYwn3hk1WixpUMrpM5flSPyqGQBqIZ3qAIkIVBjulhB+cMVqgOHLnSW/Xqf8as2u4WM2nunALhCo0GbX14kNNTGVfIuTLEjqP6u0lgPlI/ewR5vOSA1a0cNJ2zzJf+QKBEeo4CWvL6Q065n4d1e7IG0fdFEjwZVf9wHeP3DlvMvaA1S5ihJXXB6WA3h61w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:14:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:14:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 24 Mar 2026 18:30:34 +0800
Subject: [PATCH 4/4] imx8mp: icore-edimm2.2: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-power-legacy-v1-4-ed432367817c@nxp.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
In-Reply-To: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b10c6edc-660a-46ea-f1a9-08de8985cb5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9KJdtnZGt42nHTE+RvXrBsSw1MZX2cyiUlJlOlrBX6SirKPEoJTQG02+jP/h4VMiuBeIgoXAUXmnsiD1rly0XakBFXteyBuNQ+/hlq9s9IyVAYzv9UcKcCjvVaUXY3+aoGqN/b85jY1j2DISJAH4h9u6XrLXLo0TxBAGm5MaKSkTLuzERWDLHSEA2lFD63n+PjWaiaDokUtN1yf843Rd5Lu53FOgQpalfUWAGj9N+WkKWZD60YW6HDkJmsWQIErQzHE8DLT4EKSUK667L4hdz7FMpiFtfvNMcNjotKrqW02MG0mPiT1DO+PXahn4G+ie9Ys8CkuqlfUtwBjA1qqR0FxanVFLle1+sj1mlAePfSryPz7y+eCaL+uASg1vDdCXLyebAOzL/ywOPkbroXL+bHpL/XOK+YLitwqu2em25m8MG/kE4B2vj0IjCHEEukd95vC/hw5EYyG4XptdAbMr19RXtbsKEyrS7huTaHu8jg40uEOZ2xjF4qRLQ965beHBBksKLOTv1bn9049B3rpArG2l3zitwYXhCHVUjmumrtAoBFmkhyeQFYuRV2arNrPZQcn+r77C/vDGbjw2gXZu5VpUWc5cAAXjRlVy5SLI4YreHvU/+zegjOcl8Z9Sm4zotoFBFgunw0PXWD1K8vhPO9+F2949kKkyfoJgLRt591dIETRUzUh4eVvxbjF7lU1MT7froX3nmeiWr6khBkSqkScXgpFLD3kg/F5RkNhfLzRZgzLn51/pZGS2RQdEQLibSM4xY/oFgQm/HUUGbFTl5LiTtO66444EcYKNYmK88Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGlPNGJtVjJPaVJPSTZ2VG1Sc3VwVDhwRkpZa0ZxL0QrSlNIeGRVNjloMWxV?=
 =?utf-8?B?Z0wrUGRvQmRYN292TysvRk1TaXZQTFR2M25kdDNmR1lMZWdKSVJncmljRmNq?=
 =?utf-8?B?alpUYyt2bks4OE03aEtZTmJXVVBFQjl1S0VhNWZncEN0MDV0Nlp0aUtmZDRO?=
 =?utf-8?B?dVlPRGNyN0RPOXpZV0RuSzZPamdlNXZzTGRLUTNMQVBLSkNKT0hlUGFjNGpk?=
 =?utf-8?B?VEY4RWNOajE1L240MTMvSVp0L3lOUExVSmhYQ0laY0NTRGRVRDVldDBBUDR2?=
 =?utf-8?B?aHdhOFNTYmZGNEIyWVlXMXppa2RFWlNldmNBbmZLSWJ3UkxDemhkZ0s0QWE5?=
 =?utf-8?B?d3cyUkIySnIvMUFvY1BXWDVkSlpKWGNnQmdnY3dDcTRsMXRPRWpJTmhvUlJh?=
 =?utf-8?B?WDhQQXhDeDR3MisyY1RWbkNLM25hV3pFVHNkdDlHazJadHlUd1pUQ0JYQU9i?=
 =?utf-8?B?bVpyNnRFcnNPekg5cUpneWlQcWhRK0FLK0ViejZiWUt0eDV2ZjREMnJNVmg4?=
 =?utf-8?B?NzBod2FCWHNPR0sxd3VKYlEvVG5jNUF2TUtSVkxBck5OaEZpczY0N2MzQm5v?=
 =?utf-8?B?L09YT3RFUVZTcGpoRWt1STFrbWdQSU1xS09jODdBbFg2T0N0K2YvM2xMWWo0?=
 =?utf-8?B?UHAxNGNheXpPb21oZE1YQlg4ZkdTYU4yZDRtUXQvNy9CZU1lZVMrR3JjZmN0?=
 =?utf-8?B?ZG5OM0c2dTJXN0pJZnc3Yk05OG9FL01lVlZmeUduOGVJWHhqQmRoSTB0Zk9j?=
 =?utf-8?B?c09reWhxb1Y2ajJrQm1ZYlB2cnR3VFN1WE5uVThUc3p2TWtCbDVWTGVISDdS?=
 =?utf-8?B?QzNudEpYMldOaWVqbm5CUTNSV3I1ay9KYlNvQngwM0lXbktsREJ4S25kVkNh?=
 =?utf-8?B?dE9sVkM2bTZjSTZsem9NL21MZk93c1hlK0xFenVPdUsraHVjVlp4b1FUL0Vm?=
 =?utf-8?B?TXhzNnh6eXNqRzV1dzlEUDRjcld1Z1o3RUpPZzhNWmNyNlpIVlhkTmR6eWdl?=
 =?utf-8?B?OU9zdm15MFBLM3RjaTdHeTNXRUNhTmZ2K1h3Ykl4Rm16aW96djNrVGxsd293?=
 =?utf-8?B?eHNRYjhLWmlrbm4vTk9XMXVleFd1azlCWmRhcXJ0elJrNEFjWTV3bWovSVVX?=
 =?utf-8?B?L1Q4TTB0VDBFREpxL1dRcGtMQUZBbVBOcDVGQWdYdVBQWEtoMk04Z2JMTkRR?=
 =?utf-8?B?WkY4N1dYd0l4NFFaWDlMTi94MHBrNGZEd0hsbzlTcnd2dzF2cCtTdGNmZEs1?=
 =?utf-8?B?OFZNeGlvUmxYblhBRGhUdkJCS0tzdXV5Q2VFZjRpR084cWpEUktJU0pEQmJJ?=
 =?utf-8?B?eUFqakNrZ3h2QVczMllsb21TdzNyR1gvbVRiZ3BJZndaWWpUR051TEpkM3BP?=
 =?utf-8?B?Qi9aaE5rN2hxdjB4KzBnb2pmUjdNZ2VwQlhPQXRsNzc0VjRPMTBmWTMwd0ho?=
 =?utf-8?B?Tit0TGM5QnhtRWU4SWkzMUNvSGVqaTZwNVJJN002ZU52N1hZc2g2Mm9XcU5L?=
 =?utf-8?B?a25sVnlLVDhlcDZ0NFdJZ1pDaFY4WElnOXpaa3h1Sk41VmlpOXJlQ0VUdTVI?=
 =?utf-8?B?UUt3YTA2a2VxV2dFN0gyQ2VMNU56L01abHlVMU5QTzdsSjBFSFVySnJOYlky?=
 =?utf-8?B?SmZPRVhJdVlHM0p3c080TE83VlJoUmJmcTJjYi9Da2lnOGpyUlRjaGkvK3RS?=
 =?utf-8?B?ZDZ5SUljNWhwZk4zZ09Gb1pHN2xITjltYnRPSURPbnRwUzRoTk14WmE5aGlI?=
 =?utf-8?B?TXpETFRuSkdPczRQYlBGdzlob3hNRDUxV1k1cHVKOC9XYUdEajhTR25Mdlhz?=
 =?utf-8?B?WXNYdlJvNzlKS3RVQlRoT3IrR3BzRmxHd2dVMytabGpKYk10eU1UMnU3c2Iw?=
 =?utf-8?B?eDlqTXBrSVFDOTh6a04vQmk1VTluRWlTdkNZZmptUC92V2xoaDBUTFd1K3da?=
 =?utf-8?B?czVYOUtlZFJEUVlGem1UWFI4YktKMGpiblF1VHMycmVSanBIT21oQ0VyNWdy?=
 =?utf-8?B?bjJrRDltem9PNkRQV25kc3pFMi9tRjA1bGFabFp0ZWNsVUtvRDhwNnFOOGRD?=
 =?utf-8?B?Z01CSUNnRU0wSEwySCtLTHdrRkt1SjYvUExnNCtOdUhNTC8xNmlPSWI0N095?=
 =?utf-8?B?dDJDby90dW53YlBWNEo5bndHandBNEFvYlV6TXFGMDhBS2k4aEtKVFg4WVVm?=
 =?utf-8?B?MFhwKzBQbTIwam9jaE1KTTF3OWhKNEhvTGp0eENYTlNCQmFsVDgzNDVHd2NI?=
 =?utf-8?B?dlNkWi9ITkJtZHZtQVA5NUM1bFlEcUtLTjhWeWYwN2Y4cUFYVmdxUk1lMWZh?=
 =?utf-8?B?VFQySmJNdEtZNHNjWGZ4OUExM1VjSndsS3UwczNoZmp6bk53cjJNQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c6edc-660a-46ea-f1a9-08de8985cb5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:14:46.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azukKIBIBuBeWDYOCgdCw1xYspIUx1WL5QDp5oRI4EwnPBkzZ1nv4wk0PuRMhAwbFYq2B3Uz8KkHJadMaPzCWw==
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

From: Peng Fan <peng.fan@nxp.com>

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi    | 18 +++++++-
 board/engicam/imx8mp/spl.c                         | 53 +++++++---------------
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      | 12 ++---
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
index cf2a87a9b90..13e1070c28e 100644
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
@@ -22,6 +22,18 @@
 	bootph-pre-ram;
 };
 
+&pca9450 {
+	bootph-all;
+};
+
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
 &pinctrl_uart2 {
 	bootph-pre-ram;
 };
@@ -63,7 +75,7 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &i2c2 {
@@ -118,3 +130,7 @@
 	phy-reset-duration = <15>;
 	phy-reset-post-delay = <100>;
 };
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
diff --git a/board/engicam/imx8mp/spl.c b/board/engicam/imx8mp/spl.c
index c1aa28a17bc..46c581ea51f 100644
--- a/board/engicam/imx8mp/spl.c
+++ b/board/engicam/imx8mp/spl.c
@@ -16,9 +16,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
@@ -33,36 +30,22 @@ void spl_dram_init(void)
 	ddr_init(&dram_timing);
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
+#if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(I2C_PMIC, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 #ifdef CONFIG_IMX8M_LPDDR4
 	/*
@@ -73,22 +56,22 @@ int power_init_board(void)
 	 */
 #ifdef CONFIG_IMX8M_VDD_SOC_850MV
 	/* set DVS0 to 0.85v for special case*/
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
 #else
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
 #endif
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Kernel uses OD/OD freq for SOC */
 	/* To avoid timing risk from SOC to ARM,increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 #elif defined(CONFIG_IMX8M_DDR4)
 	/* DDR4 runs at 3200MTS, uses default ND 0.85v for VDD_SOC and VDD_ARM */
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set NVCC_DRAM to 1.2v for DDR4 */
-	pmic_reg_write(p, PCA9450_BUCK6OUT, 0x18);
+	pmic_reg_write(dev, PCA9450_BUCK6OUT, 0x18);
 #endif
 
 	return 0;
@@ -136,8 +119,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 0649d746907..ee55d804980 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-icore-mx8mp-edimm2.2"
 CONFIG_TARGET_IMX8MP_ICORE_MX8MP=y
@@ -78,8 +75,6 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -98,12 +93,13 @@ CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y

-- 
2.51.0

