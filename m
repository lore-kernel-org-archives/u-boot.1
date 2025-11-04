Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49938CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E4783623;
	Tue,  4 Nov 2025 16:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nBAUteE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D464A8003E; Tue,  4 Nov 2025 16:06:12 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBE4832AD
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0/aNa7fwND7g5TmF9QFRzmfEJW7NhAlVe2aVQkeHLMWelF1KrDDYzYW0l+kwCZAWVcxwMK9Yzhj5TlJa2Z3/cl6ENPwb+VxA1FlquBi5RO5v0XjYJ6RDXNLa/T8OBklJtfNLMQart7oWCofIFR7NMt3dzoPuFgNDVBWR7tx6NozL4fNTBinvDbIc4CTjUhGTiX5ei1e9FwIDPayTLogWbbrzJLonJP5P8u90i99pGNihbS4LhSljseo4A7xxQRy/zD6R7Vji7Ur4hORJx7zPOQ7W9dI6+c0Tnh/xzWiSRmu6Q7lJ7fnSZL1l8sMJM63xqpUsqKjpe19TONL9wipTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbPqsUrc78m2mNgiWrgH3MLfbD8jBdsgi0oUc+Q3sHw=;
 b=Nmsg/X57FK0hk7ql9s0Wq+95zIxEwCiArB1V6gZkf7o2LC58vjGWYbh2pjZebzjtliLshGNmVXITvJ0atg8sjXyp09JLYyTeGvQ9Zdsuodz0gvkj4N5nj44R6LQaKkipTOgjtyxsICzm+zkVgkDyyJsWQNJZBYRHOOcX4OCnaMrFBDXxNAv0yf4W4AdvA1FDitkw+AZP/S5YDoD3F8Z22bCJJ3OXKqbstiroNqTAWzrb7Z1OJdv/O0RW1I4kqyxUBhrYo+wnCQIvazazhP47D1/2x2yn5fjSOWS8sGyOl8f4AEcW+DkxQLc39LU9bnXTq/vR0cOgCrE9PI8VEFgahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbPqsUrc78m2mNgiWrgH3MLfbD8jBdsgi0oUc+Q3sHw=;
 b=nBAUteE3gW0RB5j/5j01ZzcS9RLYrY3iPD/WhkISMlQNhKl4kMZL5tU1aoB0sD5Me2m3Cnl7t9TSZBJxGQRq9y8jKnAiWzn1YuNZ8uYZbVY7tk+2p2349u1lx+XG/szoFCS70cE3JCKONLTQe7mbeKd4RVdYLXz2FZlB2+K0DCBpMzkRi/eXGF0cuTzmT0eq6uQbm8lUuhHhmfeSpHYHjWmtaJTEzzQO0GsoCpeL+pqVqpd1WhPr86rMhe9xXWvx4fYv39+s1u4IXoZlUuj5f+DhGOxZ3q3X19nAktetXKy2kECUFc7YdETp5YxnUsDGo0zHUv3iHLvEgFifDKsEZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 15:06:09 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:06:08 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 2/3] arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL
 and binman
Date: Tue,  4 Nov 2025 23:05:36 +0800
Message-Id: <20251104150537.1167930-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251104150537.1167930-1-ye.li@nxp.com>
References: <20251104150537.1167930-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA3PR04MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d14c94-bad2-471a-f3ca-08de1bb3aeee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|42112799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbOvtEwN7UtYiEIDgqCEcnQi62PIedjep99JxpSeWn4DSQvVm3JoXf+7o6X4?=
 =?us-ascii?Q?KWXgd24pUSQTvR+Dopw53zfWbbjhXGoxRuk9s7gEpQsPh27zzuaMcyV7fVz2?=
 =?us-ascii?Q?ey8mtT6pbykopXUMqSq5ecxwVnZsRlIcmP1zcp0/qEPhZxo0dfd2780lWfgG?=
 =?us-ascii?Q?TKQTBLVrPxFY2kz6XeifIs5sylJUdR3esi6XvocK5HfumYa+Ps9lG0PvV4n+?=
 =?us-ascii?Q?fL4GVdvNmHqL8UvmBGAJuIXPqyjelpRg12bXiXingFP9psJ74OHPNhaan8F7?=
 =?us-ascii?Q?ZQuQUNxbrkWlhjAh44S8fb9C7pe8pfMhneyPRZehSRs190O0Oecx88bdBJfu?=
 =?us-ascii?Q?M3mzsXcbKu+1eKqTN0IPEOQrjGznsmKyUorHA2CSWx/Ahnf6DNqoi1D+ZW0s?=
 =?us-ascii?Q?KhgG4x4PzAFfn67t9SMc3IBtTUBUUu0uTyU93FKSwcBIbE/Rr/py7mj29xNc?=
 =?us-ascii?Q?J+EqXI+A/uVEFT50FRUD2soES1jZyIrD2fUsmdLrcLaCmxDxHmwsX7QClkhU?=
 =?us-ascii?Q?q1PVZ3ywPH5GivA6bCzbe1CRcZV2IevalNKVQ54xt+RxcNv0d5g6nbPSpmgD?=
 =?us-ascii?Q?sUprc791EFR9zJ8UVVEskgdKLs06pV8Fcf+33ApHItCBgre+/H/tsEkHqg+a?=
 =?us-ascii?Q?SSUYxro+sBOIX/Hfj3Yy6/1SgnUloykjfwyO1AU8FH09M/qUKIwv8MR4OL1a?=
 =?us-ascii?Q?jZFBK8FEJYeU8fyrl+FYhhhY5JbQ6rtVukvRSPrgSnisYec7Mxo8A8HQJSCa?=
 =?us-ascii?Q?3lJC/vtSip1ScZTArO/mjXEedooLRo7xU3660ve3fmLj6m0zQCPxOLjFbWy3?=
 =?us-ascii?Q?g7fYcTfJf7+kwpZ8hoU2am5Qc7ydu1eI88UxgHwHjhojiNlmQPby+u001Iwk?=
 =?us-ascii?Q?8IAc1ahbfUsa2ZxkHdA4Ocma8V22hbHYXInyFUhXBiqcLS3HL1OTKce4Pw/b?=
 =?us-ascii?Q?SL7xzpsWuXGhy83UfXXF5B1MmGjoFv3n0DQjrI0ITBlcazKde5KQsCSP8Wji?=
 =?us-ascii?Q?kP8fSg+DuXQKj1U0rnSQ80mGlmZEYqF4VO2L9swFPsRBJjVjuUgRFN1PBMA+?=
 =?us-ascii?Q?VXOS9wET8GJPcQWD56/7JtiG3bVhmvK3KT6WneQGE1etFAWaUP29+BO96HUk?=
 =?us-ascii?Q?Y0QeKV7QmPwaDsYiJDqEaJ8klihFLKtvGK35E8o5504s7zc4is56uO1OPOcR?=
 =?us-ascii?Q?97kIKRpgqR/0fcAY4eY3ytupCW3JyDrgmMMEeMYLuoevDKElkj401UNw3ve+?=
 =?us-ascii?Q?F8tLhAIfcnquhc7mGH47AjZPQtNyamtEElSrl9XXpWDlTLqVfEztg1kGpf7j?=
 =?us-ascii?Q?x9kPtcemaHh2lHCfD/rpyTkpiXanrnkALno/Fs/oGcZWbd/ItOKKQSyIcswc?=
 =?us-ascii?Q?avHGSzvdC7vkh+2mYUNrNr9xhTrazLhMZ+u4Irp/U7tIxqxPicw6m5wOQFhV?=
 =?us-ascii?Q?g7/mSZ9kvr7dvUCqPx50IFCjKw8D/2k5CfST+iaPP665j7k0uKpwPF3dOmCe?=
 =?us-ascii?Q?LgG29P+MCUZARKqzeOakuUou5BVa4raCs3gJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(42112799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4EpFYQjQIXH0sJq9wWG7utHAkUCQfM1+9au4S/eWBKqICVxewKB9IfKAu1sa?=
 =?us-ascii?Q?BSLnxZlWQFPJv4BrnFiSLbC9AEcp15pzTOZKWV0HX0x3ZmhsD86CnCTvVvKX?=
 =?us-ascii?Q?SvoBfxqsLsjDoV2KUCpixLQNBraKgbyEe0DXq6mkmyczTuiqbSlzNaUFvYes?=
 =?us-ascii?Q?XKhZwp5QMhAI+/WuSL51zmQrp312sUvEIr7HgNzJikN0GCOdz5ejw+i9lCWS?=
 =?us-ascii?Q?6OJeU7z/0nhW70k1/LF+lhJEyHyUPcLHvir7PRnZkAZF5bPwyuJC7X1+Yaej?=
 =?us-ascii?Q?WjCOPCv21+HFahtzIt8A76CpDCGdmsZc4940qrTlOzYIBJUHpQLKR0DAJzs7?=
 =?us-ascii?Q?TYJu+2t8UFmLOCyot4QRGPjWcKThBHlFMGOKShRLdEMYnakc4xgH9SNq32r0?=
 =?us-ascii?Q?B7QIg08YdBKmdEHm4ysFcyTzByDIt0RyDtaCZizNSnDzDxs8USqLYTmKAXiE?=
 =?us-ascii?Q?3uXpy9kcVLzVbSDcoVZ5Uh1Fo0NyaP5Wk48iGJDpLyzuokkB+Ym5ugFA81OY?=
 =?us-ascii?Q?cuTxjTQ+w6zQdo/k//egguJwW5i4HufV9oUWyd+A9ZFAyUGygVzCMvbdXtwy?=
 =?us-ascii?Q?ouh7GODLb2GO4OM1lYiok6Y2rtVKfDjSt+f6RVgzwBTvjP2YB8CKJnLqJy5k?=
 =?us-ascii?Q?L5A9ueZM6NkD79RNagxhNz+UEnFqFEN2oV470PdtByuQCXueBR3ErVZRHlMO?=
 =?us-ascii?Q?KlwlPHuJKmBbFH2wlUtTxSW+P56kw4VImxBRAOnuLXTElXGFNHte1j3GDh03?=
 =?us-ascii?Q?1EVZi3xWIEg0mAHQeWz6qr2xuU++SX5l2ydru+CL6vsl3h1QIWNM4uikH/UB?=
 =?us-ascii?Q?uVkJP/SRL9JodHulogj7jQea7/kSH//dwh66dzBVZ3qnwlTe60M5N+uZuyKs?=
 =?us-ascii?Q?r814R/x6q3q5RS+LsKSKRpG/iOIs2eDsmmjFCnSchMzID7Ql2o13N7zW2BDp?=
 =?us-ascii?Q?KSK/Y9jhrDT2VVeCQfkR+1Rvciv5snYSQlXenSUA9ySQUMah7S+JtdrUVCny?=
 =?us-ascii?Q?mVFZ/iwZwgx8y6/vZGBTSBvdCWK+NgLLSLxlWSV63Z56febpl1+F4qubaMgy?=
 =?us-ascii?Q?zCdg4x2rSE3CPZ71gIqlJGlX+n9Vre4Wi2O5gMMJMMSY+s8vItjmrt52JWPj?=
 =?us-ascii?Q?f/+DoFYV9mogGuvtLxMJkh8v6nu4/qGJzSqSsBO4STvDrA+o+cCyRkKb8pst?=
 =?us-ascii?Q?J8mznvruMjowLQl11zEUsUpfY6o9IsXYGYxml5EWrkjlj/g8X1iBr8+ri3gQ?=
 =?us-ascii?Q?BbMsmiA2eHI+J0HfjZN3Zi2V+t8UU7dBWNjA7BcNreRYxnbwoclkz98TYjB5?=
 =?us-ascii?Q?jSrf6jzk5wbWiC6gZZV7x7J4SMb65KPuH1IiPxG8Y+hzNpI/5KYRYej2Kyni?=
 =?us-ascii?Q?ix67cuRoBCoYOW6FIYGeeOls41zOmZ7sIyEFFxNQWTgaDtS6e53IXQnGODqD?=
 =?us-ascii?Q?Gpi/PK1yH/XGXsSnfmH1hRrXJVjbQ3b4hsHVq5bUrxItdH55Jccadg6XmZWr?=
 =?us-ascii?Q?ThZpPy2/4weDZ9oNsKrK2RfMBWiY+lGJQtXuRGPBKFl5IuO7ZPuycBTAqpVR?=
 =?us-ascii?Q?YXaKe8T5fBKu5qpvOBM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d14c94-bad2-471a-f3ca-08de1bb3aeee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:06:08.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: monb5R/ZKfzTtCq57EPJ/bsNHZpEuk0FM/FbyHrJrgZjF81HUJSG9K06I9tf3sNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204
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

Add -u-boot.dtsi for iMX95 15x15 EVK used by SPL and binman.
iMX95 15x15 EVK uses LPDDR4X which needs dedicated DDR FW.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi

diff --git a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
new file mode 100644
index 00000000000..514dd729be9
--- /dev/null
+++ b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem} {
+	filename = "lpddr4x_imem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem} {
+	filename = "lpddr4x_dmem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb} {
+	filename = "lpddr4x_imem_qb_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb} {
+	filename = "lpddr4x_dmem_qb_v202409.bin";
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
-- 
2.37.1

