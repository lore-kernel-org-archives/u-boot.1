Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00FDCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A2683071;
	Tue, 16 Sep 2025 11:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vqi+vsau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A9C83071; Tue, 16 Sep 2025 11:46:04 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5EA6803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRpqP8Ff36vFK2IXgvaq2zAYETu1hBXmbKUZQxl+I4taWNzqCt+naHKBiSpYF9aK6mVF0jBSVpNOVEt600ZaepqBFO/emQ8ub8ISFOUowMuClZ1WyR/2ZgdJtjS2tB/v3H0tVseKwv/iSuHzfr4g5NlBrzBA4AL7VYQpK9bLKexxxRDq9+WdMCsOQTpGkS1dfLZKnMh3+FNwlpM+/iq/GAVJVlTHgGvDeSoP+SavrmI7yGGnn3a9XSpRWfQGmPrt9rL93hvihe06mvJtiC75tII7Vpjj+AD16PdPldMnW5xPrQ721UPi3k+hhk7Z0AcGm2yf40gQpKjyBvNm2iIp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ULwDzdZ44zja7c2twVoKS+46v2qmp2RHbGLoJsEVds=;
 b=jTNbED1QM5IYCjP/5VkscI4AUV3sHEGn3GgPXVLMdInUrHlJ7OwNE1/BzzaaHYZdxPtUYbJjnzP++oBiuDhJSIJPSD9ATI5g0Gpv4ntyzmsvBSmQIs0L8acjB/hufY0xPKizxAxKxfqziIOWqPES3wptxwGRRX0y292n1csi/iPNlho6aaBrZFi/sAdxOMWkPR/CvPkqTcUgfgi9gp5wO5qGjXOnN5rgfccDsPrF/XvPBHtx4KDWbEYOqq37nY/wWLJDrIUXtq1W13J1A1T3lZcxXY6cHhdAHzUQtoFnsgC3kkIqdd5Nq0Z92amW2N9szk12pbq7xHXwUZnsNfLAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ULwDzdZ44zja7c2twVoKS+46v2qmp2RHbGLoJsEVds=;
 b=Vqi+vsauH804VFDTHL2udygjsODTqwqPhzB1tMlT2XHZvKSBCYGcOJkV7uWBJFuXdnoW0ZKrV9TZE1aip2wVChPgRiXVZpSDKoCRe6LjfNv0b2bixH/eaVeBBuKgaeGMjPqYfxWJL1yceasLNhfmwUxBgg1SUzf9596vldo09InVQgdRGksdwngYi+9Y8u6kpm7P3rT5+Rv67C9rY1D9VnI7QEl+9mvPi0R2i2rAixmvzykbyE8uVdP49lghnOu98yHmIuj4w4KYCKLx2dhLc6udyVEFsSVRHkW+Gc8bKG52feG+znxt/Ch+RF2R+XD4g+gZwCdE5c8kDrj5hRDhyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 11/12] arm: dts: Add i.MX943 EVK board dtsi files
Date: Sun,  7 Sep 2025 04:37:41 +0800
Message-ID: <20250906203743.3352805-12-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: dc88d77d-4055-418d-c16d-08ddf505d749
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UO44ZbRp5z6IIG0rEahvphh5f40CTzBKi9j3hT+zTUOx3Xbb+3JnLhj8kmHH?=
 =?us-ascii?Q?OZ1SsPXGOhBLmoxt1pHkyeZ4zFgJYuglnI9IpZ+zUsuVesHwyVnBl08lgYTf?=
 =?us-ascii?Q?t/Mu/hC9ukMf+rw75/owiMLq76Lw1UTBN3sAfgaS6jmULB7tsPqbjNYIuvHx?=
 =?us-ascii?Q?0dyrOvCHdsbjHaYoA0/Drhi981omHY5sWk0Vla7pvEUm4mUGjy3AmeXTbhQJ?=
 =?us-ascii?Q?o1zmg63+TpOH77RtI0Fh7PaZ46gH8teNfaj8Hxi2qo6R/TVBZgK6KT4u5eKO?=
 =?us-ascii?Q?BKUZ7teahDvlzK9VWP0wZt7yNtPAy6y9SJxhy65VidQ3M7PkqB0tGUrdoZPJ?=
 =?us-ascii?Q?3BwvGVcJvBEpQ0m8tLIrcj+7AYkj7de7yEnl74CIlt46+iXS61GEq+Lu+V7v?=
 =?us-ascii?Q?RFell2PAxJ/CqUBZzsKFinLO/QXVtX7r+B7AQITEvi1GOIy9qGNRQMmyELD4?=
 =?us-ascii?Q?WOfS+yTe5VnwmQgYsDZ84gWEtMQgyKyv2eKbBv7ID7l5T4LwzwVdjhbiR3nI?=
 =?us-ascii?Q?3a2bPHnmjeEzjzkglM7v9XQhBF34RjPh5L8hS0nq9w3aaktU+9h7Zc54gXvG?=
 =?us-ascii?Q?UIMi5ypMwOsIwoM2Ryzd7Q8UgGmEEhayh6t/Jm0qtshEV2B1PUZZXxU2XYAB?=
 =?us-ascii?Q?xWGEZiPeyaI4Pow2Z9h0FK/88HP+XwLSjS7woq0rcXlZUBSK+khi0bP7mEZv?=
 =?us-ascii?Q?2JNdbpXB6i/zW/XY9o9vTispdEjZOT+4oSAe1v+LOAjRYGRXlK4pAiummDBS?=
 =?us-ascii?Q?ZEn4OVFVLjKlUmUmK337wQLmy7dJljK6qknyJP7glJ0QmS8NA1MDYWYkUgJQ?=
 =?us-ascii?Q?Xl7xMK/l2P8StTnoQwtVZmXdH3Ct2G+Dkg1ReOQkgQlgoJXAadnuu7Y7bQfr?=
 =?us-ascii?Q?ZoKh2SktdMi8f89F2wwjL8YoshyFUqBdFbnOWIN+6HeCZ8wnKFa+bLiCYmmo?=
 =?us-ascii?Q?tJbAseVXjyfL2K7dcE4ZM3GffPVzXqI2tX6JQ5Yy8UNC3U6b2VcXSgzCJjbJ?=
 =?us-ascii?Q?PPapOyTrPwCRaok9JXSm/lW+FLRrQZ+sY6qJfB2i1DsXXXmmHEABVRJ80eox?=
 =?us-ascii?Q?8CTI2V11snoe5vA2SpLJrLmh9XPeT8gcEWEsuDkv2CBylRQoMy1NYU2KVQLI?=
 =?us-ascii?Q?cVjRDvBBOKVpFHLAxX0QWNeOg3joUscvS+6+2A0edouBLGsvHXGZxvxI0YmJ?=
 =?us-ascii?Q?srYaCkJE58aPxdnkw87fPFGvHclnqsEEAIh6aODbXc9C9xrMVN1s4XeYHxtP?=
 =?us-ascii?Q?YqJ2ERm2YEXUSyhfi/M5yxNBio+aZNUTUidm14bmBx2iHSmBk+vFeYPLaj7C?=
 =?us-ascii?Q?UQI1tRR9Nfj8K92c+SP2ALI8quhAnZjBGOOUcREjSDWFn7SZBUORYiRnkU+M?=
 =?us-ascii?Q?/0RxdD1gfKWlt7turTKKDEBDDQtTQDbv/+rnQ9LxBq2GISJTu/HKLg0J7mjk?=
 =?us-ascii?Q?bFIZrPsC2GPlrHTKwU4tNqacyZqzXZFFtO1eBqCmONUfcqlElJx9rQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S8bjcWC2mS2OSXHQXxmIQ1Ddy1tayt2BLoqFdXi12DeKcS0uugjcIdm5gLMt?=
 =?us-ascii?Q?JCSzsXw8mNIqGxHcbeKpEccKVRAoOxxljAQdtr3Qyt71NoYrZgfdLQ0V5sv+?=
 =?us-ascii?Q?1mVdxuHdX1SKsjOTkoO+ikNKSQbMF/Vzvuh2Ni5MwlMR5dFGmzwtznQHD3pe?=
 =?us-ascii?Q?v8nX/re1tb4NiaDAlIMeYjR5T5CH+l6hGP1bhN22/Isa9L2mWQtQJ5A+vY7i?=
 =?us-ascii?Q?Dv4LiI+KFA/NbHhdooH+COolpzQs/gwdKNhHrDy22Yjd5ye3gr9LGV9kSQEF?=
 =?us-ascii?Q?QeRyafedv6ixITMphPCxD5I2gxG0QLWbVjBQDev2HGv077YsZ3J0htANcmq8?=
 =?us-ascii?Q?1aUsq+GDdmRKgFlmq6ks5GxwxdIb3PhLMNgmXIsCgynTtLHz14BvLrwsvG4c?=
 =?us-ascii?Q?XUk3kTtJc3bC9MD/4LXt01NPKEJenOHoQkMPIJ11Ll6KnkXfxiX+fyrgQUDp?=
 =?us-ascii?Q?b1vWQ6VEKjCDOXMnijmHUiXP5eEUQzyNQgrAVo5YV5yWTfolz9bhrNwWRn2h?=
 =?us-ascii?Q?zPucaaL8usr6WYRkz/h8gdNZavzsy9pqUQhdaaBInkjBukOrHDQ1HyO5jZ8L?=
 =?us-ascii?Q?MiGvZ49kSx4mcvKHbEZF9HPb09IS4wk2Cck2YqCf2OyHBtbs0p8iD+Xw2byb?=
 =?us-ascii?Q?SHq8ftoqqdWPE9lQjSHf7BP65hIYUDH5TzXEVclLtZ46Zi3xDjqZXIyQ6VPQ?=
 =?us-ascii?Q?WZ4lKn933/SFBG12e3Rc+HLkxN/ser0ZmR+OIOgCj7QcV4COEkc8y/lpE+nW?=
 =?us-ascii?Q?xjQmoJR1GSLYnB4ytOkNNYK8ojWtgsyP9AA9slrekWGSrbUzVmiTXs6Q5sOu?=
 =?us-ascii?Q?Z9e53DatQZc66sMrWrphnBz24zcvGhipD1pR8IKzEqK6Vg83JWyWMUS/TCL2?=
 =?us-ascii?Q?MxPXXe0LSmJogFSIQ9XtryuZgyLV3mZb0AySGU2MaVQVWjvXaGp9UZHuCTGS?=
 =?us-ascii?Q?e1+Zg7s5b26arcyqYvHeWF9v9gFXSYSoueOaUomzR6h3o/f8JS9mKfwRLpZT?=
 =?us-ascii?Q?Lh07FA/KT3qdClO6LecroDMTGczf7ubNLBvsRuy5taqu2SMLel4hjqYQ9fun?=
 =?us-ascii?Q?t+HZG7Up2eU1ydM8bD/7w/ojN6Ahm5dBumX0THmnlJjMLfmaN8nWh9Om1D2W?=
 =?us-ascii?Q?4VZ3WbKHom97OqaHOG8Rnz7xHtLaKm6dRzrtAKhYZh7bQ+Y4KrCR3kZYWBrI?=
 =?us-ascii?Q?pjm5csRWdKg8SCYwaN/64J84ndGEeIIINUJ55VAZKpdSoYw9ZZFUfVcdtmiF?=
 =?us-ascii?Q?RyGpIFuQGgapgjEBbRE4+PXVaXZU4bgWbtJFBGp06Q/Msa00MY0SGH6cQmv5?=
 =?us-ascii?Q?t+NrQAdpHw/L0nqKcZ2jGxjbIgD0FRF1wN0wfcpBs/FkbDK5d2QjZsOFvFZG?=
 =?us-ascii?Q?0j/eONFkgbdgUvaJRzjKE2zNLx4Mvc7KDsPZeCFYxufiJFvtTroICMerfLnD?=
 =?us-ascii?Q?/SnWaaH1sGvampYIMnv8Do0PDVqYgF+xT83LN3/OjKHdffV+dXy1T7zeS++B?=
 =?us-ascii?Q?emWRBCsB2KQ7yo7PoXD3Yf+WkzCot67BPamqwlfAVxk0h/cF6RlDllFpQLHS?=
 =?us-ascii?Q?u6wCGn75zglZTLA/wq+pUtNlsS6zT7NkevZRUEqE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc88d77d-4055-418d-c16d-08ddf505d749
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:59.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzP+828+3PCsQdhlq/iT8Fy5Y5sIEiVJoTdaqm0GSRLW9Wd5dOOO1ncgj7v/lbrIjiWv8LeUjEDlbIEbcWTn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

From: Ye Li <ye.li@nxp.com>

Introduce the base dtsi files for the i.MX943 EVK board. These files
define the essential components such as messaging units, uSDHC, GPIOs
and lpuart for board bring-up.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  62 ++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 212 ++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 arch/arm/dts/imx943-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx943-u-boot.dtsi

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
new file mode 100644
index 00000000000..5496385dc4d
--- /dev/null
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx943-u-boot.dtsi"
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
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
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
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
new file mode 100644
index 00000000000..9c4882f7d79
--- /dev/null
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr5_imem_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr5_dmem_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr5_imem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr5_dmem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx943a0-ahab-container.img";
+				container;
+				dummy-ddr;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+	};
+};
+
+&cpu0 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu1 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu2 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu3 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&dummy {
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+};
+
+&gpio6 {
+	bootph-pre-ram;
+};
+
+&gpio7 {
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&scmi_buf0 {
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+
+	elemu1: mailbox@47530000 {
+		compatible = "fsl,imx93-mu-s4";
+		reg = <0x0 0x47530000 0x0 0x10000>;
+		bootph-all;
+		status = "okay";
+	};
+
+	elemu3: mailbox@47550000 {
+		compatible = "fsl,imx93-mu-s4";
+		reg = <0x0 0x47550000 0x0 0x10000>;
+		bootph-all;
+		status = "okay";
+	};
+};
+
+&sram0 {
+	bootph-all;
+};
-- 
2.43.0

