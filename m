Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F13610D14A2
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 12:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EEA84020;
	Mon, 30 Mar 2026 14:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AVWDe6Ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E8384056; Mon, 30 Mar 2026 14:48:28 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1AEE83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 14:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaEXxkokBwkMt70SS6me99Icgl9nQeZeRW85+AmxV4xjLneZZWOhie+BP1vVhUThkYD1MEsR6X5YLunenGVWYxhNyWfVFCbpMpUclQM7fpFJWLAbo6+gm85+1ikYESuNQTVEFxqn5Rfcec3kE2mcKHx6A9vX5p80fpBHQZ5mIYI74fZ/7lb+wytkVrB/5CoSNPvr5o2R0ArnaDmh+LrGVpCpYs7oCt+Dqw1PvFYRG6Zl2QKT3fVFKBMblVtuSlbACSQpLPuj0JkvD20vvELKcUhKWQbAmfNtzCT3abG5fUYWwVcF59fJQfQbeUtJeqo/ft5rDf5l1Onk7FDKCGWx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg+C09YCgfdVdfk9OQdid25S6DTwLp/U9YIIvTGzM7E=;
 b=KDUJC72LaqUgUqVXHEsbG1Z2FgxFbau7HDlTCv0NtSgpNYasXhdm8DtSvC9NlYLQt7L6T2Z/DLtKLC8C6vLoijFCFMPE3d0nUDCNtODdUkPfTsGGjeO+iSzXEx85Zl9Ef2njaHXGp30j7a2G9lQFo3d2OGdk8nForMND5B4wO4ViBdWVDfqJ2K/Tr35Rmhv7E3bpIXg5TgJSCRqgIveiqk06avKE/iemAoqecYYvZ4UYpPfsbW+1/m4z3NP05sdEivCrbnfD0NY0j7lLbAEi/XJHOYK1tVfKdM/NLNeABXcmhLb2EqH6O4RTxUYyvRclw6+EXxGk1dA5IU2YJBm/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg+C09YCgfdVdfk9OQdid25S6DTwLp/U9YIIvTGzM7E=;
 b=AVWDe6EdIW8fLs6szr1SxSaG1F2Nx8E9VrGeyb/tuUBESY95CVPrStjZSCoHGnj+TDS+rftd4dYACCfX4LNaTFBQ4mFljEcGnieYHs0pp6/csKP8hWJqPFS823h3V7JAm1KpOAQT8/b0ip7xgi9dj7RxmhcVSfGuU6XTCEVQ++TyXKJpwyHKbsLJ1MZtKRB00BlRXLdcNq0gXWmaREkI2kT075Wnv4c2JoNOKrZiHsC8faeNVpA/VpXrLlH5/TUOvqT0ro/s42qyL49MKpMy0zCZu1W5r0e0jOJsijdXJ1QZIEojke/UGcyMTDgdemoKUxYuUp4JxDjoB3BMjG5KJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:48:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 12:47:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Mar 2026 22:04:05 +0800
Subject: [PATCH v2 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-power-legacy-v2-3-47dde3182a2c@nxp.com>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: a003014a-bea9-4ee6-3658-08de8e5a8ffe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: ZTV69du9WBCeLNCepGamBuQV4mGDgzEGxkhTVFkNSWfe7g6aZlAFfx3eH3vFJvwhUalZlFzrWBpQdvn6q0Gqyx9r0DnJoTWXLJWIdihfwEUNF+WkIDEV/lIMnw7n+w/v2cjV/7zMn5EsEmA5XUHQnX6yVFBssjv0WMp6eODcQjCSlY3pJ6SG+/IgnpVGtjAXGPDhzXoFwj1+k54JtfX3iK3NxKz4HajouP2ud6KnsQqDxJss8y6CiAr+4cmcWUhvr8HN8/nrNG2uxAL7C2kOuxYLCjKKVEXOq5wypLiS/c2KiiWn4lbOh71GLwdGOG0+FEYy1Ry2Djsl/9W4C945/Vz51CzqtvvATCCzxv7ngViIdXKi1q6G/hhsjW8x5piEn+41lyVTxn/+Flk5QSZTgkfbbtJOm36fAN2E91W358buKaY1gSW45cpo4yRtZeBFVL5IXo3ziE+nVGscSlwCNfiA7kAr20THRwWp3ZjxrmlcJk8LyW6WaKzycjRBMklsws/5+tzDtIDjYoAz2qjCrsPuWdZKO+D2SXAvMj54LGVN2UCsx1PoUmEV0FxXlJeQdbcUF7UAhLztbbzL4PUM6uW1OI01Kfl0VwZMy5QiBMOWTuxm399ar5deS6Bc/eWbbCm3QDuwj9+M/F2F/lmLj6Ri8ZMcW9Q64p1yOq+yglRTVpeuV/OoS6YTlEC7J6YJuzsn/R880uw6d2QEEQdIViZF2VtiELMBHL0hFH8mtKXeTXIoEw1qO/z+rgjt6seu/Rx8lcyN2RHHfUIB5+V50hECITroQEzAaiBWfgzSSt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVA1NzNxbHRHZ2UvSFQxU1VLR0wrVTJyMldhODgzVEM5OUlha2FDSmMrdStr?=
 =?utf-8?B?aUtqWVlyd29rUE5nWnpseEdJL3B6WHpkYWpDdGprUFdtakduRHJQRm1lQlA2?=
 =?utf-8?B?RC9NUXczYTVsSUNEY0dNR2xwbXJoOGUxQXdiZHpkZ1AwWkJJVHYvN1ZJT0Nv?=
 =?utf-8?B?L1AwdlduSi93NXF2R09JaThFdms4blBpWG1mSmZIb3JSenBHZGJHRGF4aDBR?=
 =?utf-8?B?M2hVVXYxMDZPWllndThSTGFKcjUydlF0SWdXcmExUmdyZS9ZckpmdE5xQXpl?=
 =?utf-8?B?NFNUcWptSHVvVkJwVytYMk0xZzNNbjRwNGlqVXUzTzZ1Wmx2ai93Z1RzT3NO?=
 =?utf-8?B?czhxenRaMVhMOTZoSEhXNTcvdFVIZTFVV1Ribk1mRk13bERwVWZsTldGcFl2?=
 =?utf-8?B?YlpMNS9TSVVwaTBWUUpXTGk5YzcwRjFrT3dJdklkc0d2OU9WVG9WditqTDNq?=
 =?utf-8?B?VnY3SWtEN0R3ZUdHbU16a1lmVjNhN3NuYnZsbDE4NDdmTndBTWIwN1ppRDVD?=
 =?utf-8?B?VS92SUtGeTNDaEJLVWplVlV4cXVUQmRqaXplOHJTRlI1TzVXeTlpYUo5ZjBi?=
 =?utf-8?B?eDlSNXJXSW8yNUxaOEFFNkRzZ3lNSEJJcWJEUmNhQ0pTQ2JaWWN5SGdkSm93?=
 =?utf-8?B?dWdTNlYvYzRzVjhsNVJxTEhxYzd2SnYwazR1UUY0YnZjNm9PWElTY2hta2JH?=
 =?utf-8?B?YlM0T2lRSXk3dmRkSVJyK212Mk9qakZFOWc5MXJ4UFU0cGZPdjVqVVhXdksv?=
 =?utf-8?B?MElrYjhnRDBLSkREb3BuNHhqbDQ0Z3diZzdmWEVqZVVtc0FqeWVHNGJDV2Zl?=
 =?utf-8?B?bWp1WWVnb1hocC9zcXdNY1lwTk1vamExOFE4RGI1M0MyMG4vU0dvbTA3S25J?=
 =?utf-8?B?QjZ5eVlXTktwMUVlK09WUmo1M04wOGE1Mm54Vk5xaU51bnB5ZEl1NzRMcDdt?=
 =?utf-8?B?TFoyd043T3hIWXRaZjlDTTR1NGwzQi96ZjUrQjNIajJUTW5GcEJSR01KZWFj?=
 =?utf-8?B?YXlmZFZsekZ6OXBsejF0SnE0QmNuV3FpR1JzQ2lEVmRLZXVySXdvSDlCTkIw?=
 =?utf-8?B?MVhsUDczQkhRU3BpcCtqR3JCNmJITk5KMDZZQTMyWStFQWZ5V3k2dy9wa3I0?=
 =?utf-8?B?QWNGTUpoNDBpMjlYM3ltYkU3MmJTczZjNTY1WU93aTdUcUxoK29MNm5tYVJ5?=
 =?utf-8?B?TE5uYVVBRDRxalBxckFhSG5mdGNBRkhvYm9POTVqbm1lK3ZBYzZWRzVzSkY2?=
 =?utf-8?B?aVRQRysxd2xlRk44aWlWekg1RzZaSHo4UkVlV2ZhRHJockhjVVZ6NENuV2Yx?=
 =?utf-8?B?WnhxdHQxTFBPKzd4a3ZPWTVwY1dzazZTWkNidjZlUEhrNmpPaEFCSFJuT2x5?=
 =?utf-8?B?ZHJyODZjMG5UZUIxZlQxMEloQXo1K3ZNeXJaSlZzTFVSYlhSTnNDUlpTeS91?=
 =?utf-8?B?RmRLcVFZL1FXQ0NGSzNJZTFFQ09nbWVrR3IwK3RCZ3FrNllsaGpTb0ZyRi9z?=
 =?utf-8?B?WmFPbnZiZFpsRUdxZG9jWWxKc3FQdEJpNnhtWWZJcm1ReVp3TUpXVUJTWERP?=
 =?utf-8?B?bE1UZGIwOTJRYXE0OVRkYUdKaWN2akpPQXBHbXJZK3pKMU1sY3VZN09Bc3lB?=
 =?utf-8?B?V0pDN0ZWTXBxODZsaGZzZlF2QUZCOUY4MXVUdzZxS0psZkloOGRldDJXakU2?=
 =?utf-8?B?MVNBL2RBS2dGTGZueFZmNkIzbTFKdUdqcjFDS2E3QXU4Vkp4UVJFV1FaM0l2?=
 =?utf-8?B?U2JIK1N0aHBjVllFZ285UGN4K3V0YThGbk1wek5BWWFlK2FPZnZ3MjZvaE9Q?=
 =?utf-8?B?NUFadm5naE5STlNqUHhGZUQ1enAvb1MyOXFRRGlxSFkzbG13T3lNeGR0cEI5?=
 =?utf-8?B?WWd3cnBOUkZwZDkrM1NpVmJ4S3FrVXF5RkF0MHFQNkZZYTg2Yk5MUlJFUWYv?=
 =?utf-8?B?ZTM4eUR6SWU1Q1lhU01OdmVBYzZCSG8xMTc4aUo1TldENXlJUHNkM084Lzcx?=
 =?utf-8?B?UEExbmh3TGJRVFN1enhlRHl6bTJyK0ZHREJhVDFlUFZlUy9RYUVJcXloa0py?=
 =?utf-8?B?WG9YaHhvTFBYZnlZeVVSRGRNQlZVZ1FiUlVOeXlCcno5S0U3eFVuOGljQ0VW?=
 =?utf-8?B?bmdDTDc4QWEwOERYV2tFTVlIb05PczJreHJCMmg0Y3FhZlhCTTl5STZncUIv?=
 =?utf-8?B?V0tSeG9ZZi90aEhYNnNwUi82cXJiaVNLM1JkcDNBTURoZWhDRytxcDc3Rkgw?=
 =?utf-8?B?REJFZ0VTcW1Gd0o3NFl1L0l0K0hRZ2tPNEhCSE9vVi9GL2hHSTlYakttTTRJ?=
 =?utf-8?B?Q1F6UjFBLytiMlZRSGNEWU5hN1c3eThtMWY4WVRPcHEvTHZiN3EzQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a003014a-bea9-4ee6-3658-08de8e5a8ffe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:47:55.0003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mhPqlV2xWauz7ILXoXYII7he5uvFCyNSHnwB4XSkkj3nsWESNJ09why0WbMbo0plAtnDgXVScGTBs/S4TyKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106
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
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi | 22 ++++++++++--
 board/phytec/imx8mp-libra-fpsc/spl.c           | 46 ++++++++------------------
 configs/imx8mp-libra-fpsc_defconfig            | 10 +++---
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
index 1320f1540ed..f917b71be90 100644
--- a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
@@ -33,6 +33,18 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -78,11 +90,11 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmic {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* USB1 Type-C */
@@ -120,6 +132,12 @@
 
 &usdhc2 {
 	bootph-pre-ram;
+	/*
+	 * LDO5 output depends on SD2_VSEL, but no way to read back SD2_VSEL
+	 * when using SDHC controller VSELECT to control SD2_VSEL. So drop
+	 * vqmmc-supply to avoid fsl_esdhc_imx read back wrong voltage.
+	 */
+	 /delete-property/ vqmmc-supply;
 };
 
 &usdhc3 {
diff --git a/board/phytec/imx8mp-libra-fpsc/spl.c b/board/phytec/imx8mp-libra-fpsc/spl.c
index 08111641aa6..aa22ad0030c 100644
--- a/board/phytec/imx8mp-libra-fpsc/spl.c
+++ b/board/phytec/imx8mp-libra-fpsc/spl.c
@@ -9,9 +9,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/mach-imx/iomux-v3.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
@@ -46,45 +43,32 @@ void spl_dram_init(void)
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
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(0, 0x25);
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
 
 	/* Increase VDD_SOC and VDD_ARM to OD voltage 0.95V */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 
 	/* Set BUCK1 DVS1 to suspend controlled through PMIC_STBY_REQ */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set WDOG_B_CFG to cold reset */
-	pmic_reg_write(p, PCA9450_RESET_CTRL, 0xA1);
+	pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
 
 	return 0;
 }
@@ -120,8 +104,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/imx8mp-libra-fpsc_defconfig b/configs/imx8mp-libra-fpsc_defconfig
index a23e604425d..4a8938d3e43 100644
--- a/configs/imx8mp-libra-fpsc_defconfig
+++ b/configs/imx8mp-libra-fpsc_defconfig
@@ -9,7 +9,6 @@ CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-libra-rdk-fpsc"
 CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
@@ -105,8 +104,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -138,15 +135,16 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

