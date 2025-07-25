Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF2C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4638F83930;
	Fri, 25 Jul 2025 12:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lfLb6oA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75CA8391A; Fri, 25 Jul 2025 12:36:22 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0553D83939
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFjKCqAnax2ZJuWbeTkm/goxztxlJVLpfpafWA6MiU+CyibKwATeqGa1Wk3MmEoN6sMMf3eZTTLQ4J7BFsZPqA9ZwVvwydasZ5kgDYjgbHWoQQbX46IKVdgwauD/Yfqq+weYFEkDwuS2FrZm4hsbmX8K50Y2gEz8AaGd9T0IXbRJarDWX5Izc5ufF4ctKyyD4gWZOXPfxW2OuK+MrU113fiCvajAzp/CN//3kPuLL9K2teS+94rKsLmBKKRePIbGMBsAE+BZ/olLLF9GFIwbX2ffwbgMFYJvvZoXmiZMZnxpYLhg4QqBaU6uQALnxEm1RYLb9NUEawQDAkpwAzD/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UloHMAyKAk3qXmCZKtyAWkCneUVjI6ALMAkIeFwYccA=;
 b=aA++B/ckUagWYGVAzM/z1CffGd9mJIQnzsBj551bIbhaMoigiSALjwjuxPuIAB9sLp86niHzs2cxQaFA3d5tferTKtynDYGNSVT7wvzSN8OUGod/t3Iz1jMmolKO5P7WGsKg9ejL2G7Pf5TZ+iDT7X/W4ECwntz58VEpbcXMYvyPAh4d3QJ00kfrvOxcoc2NZkLxdbDMbZCCBBO8UkcFe1OGGmBInVTUXT3if2qAPKDRXKG6Dv8pDMkeMH5fH7FyPvsREaDmlMGtwEO7SpLwtFXxUSojagpnt/M49bhCQ8vBbmRcqoET9cHZPd8xOWQIpnEYAkb9uO9z/6Tf1p6SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UloHMAyKAk3qXmCZKtyAWkCneUVjI6ALMAkIeFwYccA=;
 b=lfLb6oA+8NmPtReDcGKguUCnIUxj8+KnMbSqus7IOOrA9yKRNLwZukBNy1FvZwGknrBQlzjtLCGm/VQm9y1uLJDb2eDUmlb4SkYaHmtQOEMtw9gHoF+C8H6iHuBDxG1xcFvR5I1qzUyi3FN0OxZx50vHAVjM50SRzkZWam7cNjwJxIbrfdINej2ZOMrxQ5CCaEpQip3rPJmCmrKq/judrj8WWu4uW9eORl00uBFXJTgIt3sOCWEJXCBTnXA9WPkMLLZ31rYPuEL47xhQ9Qt/7hI3zrAPWMqmoDL6DJgVq7MGjRPlvQPI0CA9uL656S0nQhmmFfCIKmdNyia72NBWVw==
Received: from DUZPR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::25) by GVXP195MB1614.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:3e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 10:36:10 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::f2) by DUZPR01CA0107.outlook.office365.com
 (2603:10a6:10:4bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 10:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 10:36:10 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:09 +0200
Received: from [192.168.2.141] (172.25.39.126) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:09 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 25 Jul 2025 12:35:38 +0200
Subject: [PATCH 1/3] arm64: dts: add imx8mp-libra-rdk-fpsc board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-imx8mp-libra-initial-support-v1-1-d9982df21a4b@phytec.de>
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
In-Reply-To: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, "Shawn
 Guo" <shawnguo@kernel.org>, Teresa Remmet <t.remmet@phytec.de>,
 Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753439768; l=32390;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=Qh5uRlk8VpWNs8ii6ciApUunJd4Bjo3BztDhIUVxsIo=;
 b=RlVvzlBp+yy3fZ1Nl+VMtrJ/LhBpjG9GqDXwjj43F6lcw52K8F0oYJkAEQaz7IQCNV57owrRS
 egWMUIQwjD9AYNARXbN+WFD3g7IcwCi5J6z9MDsQi7eC+jBPQ+zb98N
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|GVXP195MB1614:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dc368d-a84f-4d91-f2d9-08ddcb67121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2VEYzNTZzZIRTJPQ2IzQllUaFVKQnpVY3RxMnJZZ2hOV3plS3BsMVFHcURK?=
 =?utf-8?B?NzZ3SmpxeWhzLzB4c3NjMXFqbUpxV3JMTW4vemxYaUorYWFVbW9EUkFYOWdI?=
 =?utf-8?B?SUZUVjI5VHdReFU0ZmpMeHVHTGNFd0txdmJ0RjhuUGtzSFpEaWtIeWlRajJP?=
 =?utf-8?B?OEh5eE1LNWZBUTFrdEdwcHZ6SjdWUGxQcGVadWIyaVZOQjEwZnc3NnJNa2Zx?=
 =?utf-8?B?V2Y5dk44UjV4bTN3UzZGK3JtUFpNL1hkd0RtZEtvNzhUK1dmOGhjUjV2bEZ2?=
 =?utf-8?B?U3dJU3kxUWMvbFd2YUplYThtVXoreVlFYTZaNDErVURLZnpLMmNvdzZaZ2tr?=
 =?utf-8?B?S0hoWEpieGhYVDM0YlgrU1pFWlU0dTRQRTBmbThORlhDTVhuTmdwL2xabi9X?=
 =?utf-8?B?cFljck9sNzlIdWxabHhnZEZDZVhFR0tSQkI5bzZ3dW1GSjVwNHgvYnJYblZn?=
 =?utf-8?B?c0lNbkN4RzJBOXNFLzlQWk1XRlhJSVdMTGJuSSs2T3pqUnd4WElFUzhkbDVP?=
 =?utf-8?B?TkoxT2YwekpkbGpPWEc2elEzM3hkT3llc0MxQkVEQ01KNEE1NjJsTVBIYjVC?=
 =?utf-8?B?S0dVZjVXaVhCTE03MTNtTURMZXF3MjB1aE9iZ2Z6OWxyY3dOQVBOVmFndytS?=
 =?utf-8?B?ZDhwT2JvZFA5bFN0YVhPV1IxVC84S0xJVjdOTzBZUk9MZXJsMGt1V0NJQ2RI?=
 =?utf-8?B?WDQrc2VsUk9mWnVISlViTEVENVA1Y1Y3dlBtV3VjQU9UZFQwL1hIdTAxaERa?=
 =?utf-8?B?andDVys0aUhaOGtzSGh4ZzlreEs0WjRqVXpIc0M4SmJPeDBJb2hHZTcwMHVM?=
 =?utf-8?B?TlVYc3Z2MkRRZTdXOGlCRkNMa3FOcTFTUkk2bjV4UTVhdVVKWHVZR25QTUo1?=
 =?utf-8?B?eDBhSkJyVUNtQjA1SkNDYzN6K0djVUNwY0JmTmdvZFZ6MFhGMXJCL0FhVXB2?=
 =?utf-8?B?cVozV1g3dlN3UWlZMU4vTWVJYjZaMVFOOXVUMzVrdEkrYkYxQ2pFWXVYYmJC?=
 =?utf-8?B?Z1hBblFpRk8vY3YxeG5kbkNDb2JOeGpyWGlLQkN5TjJUckhhdm5JSVpzdnI0?=
 =?utf-8?B?a0JsVHI3Qmp1SjJoV2RPOFE0c1hudXd6WEhYd3pDQ3FSd0FwY0NLNE94MWhR?=
 =?utf-8?B?M0tFZTNZbUQyTS9pd25rM3lVQUovbWJxeHBxRkU4SlIwdU1CWS9EbGJ0aEdV?=
 =?utf-8?B?aWtBN1pNclBKUkUxOC9oREl2eUFnL2FrbWtkVDhNYXdIcWJiQzU0KzJtSXh5?=
 =?utf-8?B?Y1F3THJCYkc2VjkzRzBGK1YzNEpMY01Ec2FXayt2Q2VmeU13TmtPU2Z3c1Ur?=
 =?utf-8?B?Sms2clF1S0hZZ1Y5WllmUjdCalFOUkVLZmJpWGJ3UGV4Um9YZCtQbkhHc3py?=
 =?utf-8?B?UjgxVE5TMnBBZUI2cEhBME52N1E5RXA0RVZMRXZzM0dyNkhiZVNuR2l6ZnRE?=
 =?utf-8?B?cjZsUWlRV01UVThOT3cvNkE4RnNDOUtibE1yN0JFbzhzbW04ZFpHMmJ2S2sw?=
 =?utf-8?B?Sk1sQ0h0cXF3dkROMzRjUXF2TzVHNFlRa1o1bXNpME9ua1JZNU15L1ArajZZ?=
 =?utf-8?B?MWU5cVo2Q2g4c0JzMStpTm44TWtHSHZIMVBjVTl2N1R5L1o3U3FtVmN2MVgz?=
 =?utf-8?B?R1pURjB1SEhMR1hrc3BMMnBCelZkMVJOakt0bGVmV1EwUkZ0dk1mVHZYQTRZ?=
 =?utf-8?B?M21kay9MVENWM1IySE05dXoxVC9SY2RxRm9mWXFtTzZTMnpoU1cwTTlQM2lW?=
 =?utf-8?B?d3FHZnZ1U2dqSFJsd2dORys4WTFQaG9mY2wyWUZFaVZNMUkyU3U0bVhRZE5T?=
 =?utf-8?B?M2hVN1hnTHRLZFJ6cVplOHBwQ1d2OVJmRjRCOE1nU2tzZklOUlNwamVuQnVZ?=
 =?utf-8?B?SzdLeWZLMVl0MmU1Q3pXR1hvd1drb00yK1gxVTJ2NEdiSUVSZFErdDRpdGl5?=
 =?utf-8?B?andiZ1ZjV0RUMlVJNXIzWVJzaTU5V1ltcDhyOEZ3Z0o0U0huS25tVS9rMGFL?=
 =?utf-8?B?N1dnbzdkSVlnPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:36:10.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dc368d-a84f-4d91-f2d9-08ddcb67121f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1614
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

From: Yannic Moog <y.moog@phytec.de>

Add device tree for the Libra-i.MX 8M Plus FPSC board. The Libra is a
pure development board and has hardware to support FPSC-24-A.0 set of
features. It can be populated with the phyCORE-i.MX 8M Plus SoM to form
a SBC.
The phyCORE-i.MX 8M Plus FPSC [1] SoM uses only a subset of the hardware
features the Libra board provides. The phyCORE-i.MX8MP FPSC itself is a
System on Module based on the i.MX 8M Plus SoC utilizing the Future
Proof Solder Core [2] standard.

To be able to easily map FPSC interface names to SoC interfaces, the
FPSC interface names are added as inline comments. Example:

&i2c5 { /* FPSC I2C4 */
	pinctrl-0 = <&pinctrl_i2c5>;
	[...]
};

Here, I2C4 is the FPSC interface name. The i2c5 instance of the i.MX 8M Plus
SoC is used to fulfill the i2c functionality and its signals are routed
to the FPSC I2C4 signal pins:

pinctrl_i2c5: i2c5grp {
	fsl,pins = <
		MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c2	/* I2C4_SDA */
		MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL	0x400001c2	/* I2C4_SCL */
	>;
};

The features are almost identical to the existing phyCORE-i.MX 8M Plus
SoM (dts: imx8mp-phycore-som.dtsi), but the pin muxing is different due
to the FPSC standard as well as 1.8V IO voltage instead of 3.3V.

[1] https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-plus-fpsc/
[2] https://www.phytec.eu/en/produkte/system-on-modules/fpsc/

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

[ upstream commit: 95727d056c8f5cad668c1f5711b25102b474216f ]

(cherry picked from commit bb5fe43bf7723eda98856a2d6b050b3993aa9c62)
---
 .../src/arm64/freescale/imx8mp-libra-rdk-fpsc.dts  | 290 ++++++++
 .../src/arm64/freescale/imx8mp-phycore-fpsc.dtsi   | 796 +++++++++++++++++++++
 2 files changed, 1086 insertions(+)

diff --git a/dts/upstream/src/arm64/freescale/imx8mp-libra-rdk-fpsc.dts b/dts/upstream/src/arm64/freescale/imx8mp-libra-rdk-fpsc.dts
new file mode 100644
index 000000000000..6f3a7b863dca
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx8mp-libra-rdk-fpsc.dts
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/leds-pca9532.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "imx8mp-phycore-fpsc.dtsi"
+
+/ {
+	compatible = "phytec,imx8mp-libra-rdk-fpsc",
+		     "phytec,imx8mp-phycore-fpsc", "fsl,imx8mp";
+	model = "PHYTEC i.MX8MP Libra RDK FPSC";
+
+	backlight_lvds0: backlight0 {
+		compatible = "pwm-backlight";
+		pinctrl-0 = <&pinctrl_lvds0>;
+		pinctrl-names = "default";
+		power-supply = <&reg_vdd_12v0>;
+		status = "disabled";
+	};
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	panel0_lvds: panel-lvds {
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_vdd_3v3>;
+		status = "disabled";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "can1-stby";
+		gpio = <&gpio_expander 10 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "can2-stby";
+		gpio = <&gpio_expander 9 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_vdd_12v0: regulator-vdd-12v0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "VDD_12V0";
+	};
+
+	reg_vdd_1v8: regulator-vdd-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VDD_1V8";
+	};
+
+	reg_vdd_3v3: regulator-vdd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD_3V3";
+	};
+
+	reg_vdd_5v0: regulator-vdd-5v0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VDD_5V0";
+	};
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0x1>;
+			enet-phy-lane-no-swap;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		};
+	};
+};
+
+/* CAN FD */
+&flexcan1 {
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&flexspi {
+	status = "okay";
+
+	spi_nor: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "", "I2C5_SDA",
+			  "GPIO1", "", "", "", "SPI1_CS",
+			  "", "", "", "SPI2_CS", "I2C1_SCL",
+			  "I2C1_SDA", "I2C2_SCL", "I2C2_SDA", "I2C3_SCL", "I2C3_SDA",
+			  "", "GPIO2", "", "LVDS1_BL_EN", "SPI3_CS",
+			  "", "GPIO3";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	leds@62 {
+		compatible = "nxp,pca9533";
+		reg = <0x62>;
+
+		led-1 {
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
+};
+
+&i2c5 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	gpio_expander: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "CSI1_CTRL1", "CSI1_CTRL2", "CSI1_CTRL3",
+				  "CSI1_CTRL4", "CSI2_CTRL1", "CSI2_CTRL2",
+				  "CSI2_CTRL3", "CSI2_CTRL4", "CLK_EN_AV",
+				  "nCAN2_EN", "nCAN1_EN", "PCIE1_nWAKE",
+				  "PCIE2_nWAKE", "PCIE2_nALERT_3V3",
+				  "UART1_BT_RS_SEL", "UART1_RS232_485_SEL";
+		vcc-supply = <&reg_vdd_1v8>;
+
+		uart1_bt_rs_sel: bt-rs-hog {
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			gpio-hog;
+			line-name = "UART1_BT_RS_SEL";
+			output-low;	/* default RS232/RS485 */
+		};
+
+		uart1_rs232_485_sel: rs232-485-hog {
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpio-hog;
+			line-name = "UART1_RS232_485_SEL";
+			output-high;	/* default RS232 */
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_lvds0: lvds0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_TXD__GPIO5_IO23	0x12
+		>;
+	};
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_TXD__GPIO5_IO25	0x1C0
+		>;
+	};
+};
+
+&lvds_bridge {
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel0_in>;
+			};
+		};
+	};
+};
+
+/* Mini PCIe */
+&pcie {
+	reset-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
+
+&reg_vdd_io {
+	regulator-max-microvolt = <1800000>;
+	regulator-min-microvolt = <1800000>;
+};
+
+&rv3028 {
+	interrupt-parent = <&gpio5>;
+	interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	aux-voltage-chargeable = <1>;
+	pinctrl-0 = <&pinctrl_rtc>;
+	pinctrl-names = "default";
+	trickle-resistor-ohms = <3000>;
+	wakeup-source;
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* debug console */
+&uart4 {
+	status = "okay";
+};
+
+/* SD-Card */
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	bus-width = <4>;
+	disable-wp;
+	status = "okay";
+};
diff --git a/dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi b/dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi
new file mode 100644
index 000000000000..8b0e8cf86cad
--- /dev/null
+++ b/dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include "imx8mp.dtsi"
+
+/ {
+	compatible = "phytec,imx8mp-phycore-fpsc", "fsl,imx8mp";
+	model = "PHYTEC phyCORE-i.MX8MP FPSC";
+
+	aliases {
+		rtc0 = &rv3028;
+		rtc1 = &snvs_rtc;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x80000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		 compatible = "regulator-fixed";
+		 off-on-delay-us = <12000>;
+		 pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		 pinctrl-names = "default";
+		 regulator-max-microvolt = <3300000>;
+		 regulator-min-microvolt = <3300000>;
+		 regulator-name = "VDDSW_SD2";
+		 startup-delay-us = <100>;
+		 gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		 enable-active-high;
+	 };
+
+	reg_vdd_io: regulator-vdd-io {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "VDD_IO";
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&ecspi1 { /* FPSC SPI1 */
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	pinctrl-names = "default";
+};
+
+&ecspi2 { /* FPSC SPI2 */
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	pinctrl-names = "default";
+};
+
+&ecspi3 { /* FPSC SPI3 */
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	pinctrl-names = "default";
+};
+
+&eqos { /* FPSC RGMII2 */
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-names = "default";
+};
+
+&fec { /* FPSC GB_ETH1 */
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-names = "default";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+			enet-phy-lane-no-swap;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,min-output-impedance;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		};
+	};
+};
+
+&flexcan1 { /* FPSC CAN1 */
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	pinctrl-names = "default";
+};
+
+&flexcan2 { /* FPSC CAN2 */
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+};
+
+&flexspi { /* FPSC QSPI */
+	pinctrl-0 = <&pinctrl_flexspi>;
+	pinctrl-names = "default";
+};
+
+&gpio1 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "PCIE1_nPERST";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "SD2_RESET_B";
+};
+
+&gpio3 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "I2C6_SCL",
+			  "I2C6_SDA", "I2C5_SCL";
+};
+
+&gpio4 { /* FPSC GPIO */
+	gpio-line-names = "GPIO6", "RGMII2_nINT", "GPIO7", "GPIO4", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "X_PMIC_IRQ_B", "",
+			  "", "GPIO5", "", "", "RGMII2_EVENT_OUT",
+			  "", "", "RGMII2_EVENT_IN";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	pinctrl-names = "default";
+};
+
+&gpio5 { /* FPSC GPIO */
+	gpio-line-names = "", "", "", "", "I2C5_SDA",
+			  "GPIO1", "", "", "", "SPI1_CS",
+			  "", "", "", "SPI2_CS", "I2C1_SCL",
+			  "I2C1_SDA", "I2C2_SCL", "I2C2_SDA", "I2C3_SCL", "I2C3_SDA",
+			  "", "GPIO2", "", "", "SPI3_CS",
+			  "", "GPIO3";
+	pinctrl-0 = <&pinctrl_gpio5>;
+	pinctrl-names = "default";
+};
+
+&i2c1 { /* FPSC I2C1 */
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		pinctrl-names = "default";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "VDD_SOC (BUCK1)";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "VDD_ARM (BUCK2)";
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "VDD_3V3 (BUCK4)";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "VDD_1V8 (BUCK5)";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1155000>;
+				regulator-min-microvolt = <1045000>;
+				regulator-name = "NVCC_DRAM_1V1 (BUCK6)";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "NVCC_SNVS_1V8 (LDO1)";
+			};
+
+			ldo3: LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "VDDA_1V8 (LDO3)";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "NVCC_SD2 (LDO5)";
+			};
+		};
+	};
+
+	/* User EEPROM */
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vdd_io>;
+	};
+
+	/* factory EEPROM */
+	eeprom@51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+		read-only;
+		vcc-supply = <&reg_vdd_io>;
+	};
+
+	rv3028: rtc@52 {
+		compatible = "microcrystal,rv3028";
+		reg = <0x52>;
+	};
+};
+
+&i2c2 { /* FPSC I2C2 */
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c3 { /* FPSC I2C3 */
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c5 { /* FPSC I2C4 */
+	pinctrl-0 = <&pinctrl_i2c5>;
+	pinctrl-1 = <&pinctrl_i2c5_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio3 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c6 { /* FPSC I2C5 */
+	pinctrl-0 = <&pinctrl_i2c6>;
+	pinctrl-1 = <&pinctrl_i2c6_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio3 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&iomuxc {
+	pinctrl_flexcan1: can1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__CAN1_TX		0x154	/* CAN1_TX */
+			MX8MP_IOMUXC_SAI2_TXC__CAN1_RX		0x154	/* CAN1_RX */
+		>;
+	};
+
+	pinctrl_flexcan2: can2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXD0__CAN2_TX		0x154	/* CAN2_TX */
+			MX8MP_IOMUXC_UART3_TXD__CAN2_RX		0x154	/* CAN2_RX */
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01				0x10	/* RGMII2_nINT */
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27				0x10	/* RGMII2_EVENT_IN */
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24				0x10	/* RGMII2_EVENT_OUT */
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2	/* RGMII2_MDIO */
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2	/* RGMII2_MDC */
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x12	/* RGMII2_TX_D3 */
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x12	/* RGMII2_TX_D2 */
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x12	/* RGMII2_TX_D1 */
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x12	/* RGMII2_TX_D0 */
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x12	/* RGMII2_TX_CTL */
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x12	/* RGMII2_TXC */
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90	/* RGMII2_RX_D3 */
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90	/* RGMII2_RX_D2 */
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90	/* RGMII2_RX_D1 */
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90	/* RGMII2_RX_D0 */
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90	/* RGMII2_RX_CTL */
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90	/* RGMII2_RXC */
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x140
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x12
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x12
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x14
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x14
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x14
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x14
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
+		>;
+	};
+
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82	/* QSPI_CE */
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2	/* QSPI_CLK */
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82	/* QSPI_DATA_0 */
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82	/* QSPI_DATA_1 */
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82	/* QSPI_DATA_2 */
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82	/* QSPI_DATA_3 */
+			MX8MP_IOMUXC_NAND_DQS__FLEXSPI_A_DQS		0x82	/* QSPI_DQS */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x40	/* GPIO4 */
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x106	/* GPIO5 */
+			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x106	/* GPIO6 */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x106	/* GPIO7 */
+		>;
+	};
+
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x106	/* GPIO1 */
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x106	/* GPIO2 */
+			MX8MP_IOMUXC_UART3_RXD__GPIO5_IO26	0x106	/* GPIO3 */
+		>;
+	};
+
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x106	/* HDMI_CEC */
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x106	/* HDMI_SCL */
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x106	/* HDMI_SDA */
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x106	/* HDMI_HPD */
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x1e2
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x1e2
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2	/* I2C1_SDA_DNU */
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2	/* I2C1_SCL_DNU */
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1e2
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2	/* I2C2_SDA */
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2	/* I2C2_SCL */
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1e2
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1e2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2	/* I2C3_SDA */
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2	/* I2C3_SCL */
+		>;
+	};
+
+	pinctrl_i2c5_gpio: i2c5gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04	0x1e2
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x1e2
+		>;
+	};
+
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c2	/* I2C4_SDA */
+			MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL	0x400001c2	/* I2C4_SCL */
+		>;
+	};
+
+	pinctrl_i2c6_gpio: i2c6gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x1e2
+			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x1e2
+		>;
+	};
+
+	pinctrl_i2c6: i2c6grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c2	/* I2C5_SDA */
+			MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL	0x400001c2	/* I2C5_SCL */
+		>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x10	/* PCIE1_nCLKREQ */
+			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08     0x40	/* PCIE1_nPERST */
+		>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x140
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x106	/* PWM1 */
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO09__PWM2_OUT	0x106	/* PWM2 */
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT		0x106	/* PWM3 */
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x106	/* PWM4 */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19    0x40
+		>;
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__AUDIOMIX_SAI5_MCLK	0x106	/* SAI1_MCLK */
+			MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_SAI5_RX_SYNC	0x106	/* SAI1_RX_SYNC */
+			MX8MP_IOMUXC_SAI3_RXC__AUDIOMIX_SAI5_RX_BCLK	0x106	/* SAI1_RX_BCLK */
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI5_RX_DATA00	0x106	/* SAI1_RX_DATA */
+			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC	0x106	/* SAI1_TX_SYNC */
+			MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK	0x106	/* SAI1_TX_BCLK */
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI5_TX_DATA00	0x106	/* SAI1_TX_DATA */
+		>;
+	};
+
+	pinctrl_ecspi1: spi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK	0x82	/* SPI1_SCLK */
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI	0x82	/* SPI1_MOSI */
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO	0x82	/* SPI1_MISO */
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x106	/* SPI1_CS */
+		>;
+	};
+
+	pinctrl_ecspi2: spi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x82	/* SPI2_SCLK */
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0x82	/* SPI2_MOSI */
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0x82	/* SPI2_MISO */
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x106     /* SPI2_CS */
+		>;
+	};
+
+	pinctrl_ecspi3: spi3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__ECSPI3_SCLK	0x82	/* SPI3_SCLK */
+			MX8MP_IOMUXC_UART1_TXD__ECSPI3_MOSI	0x82	/* SPI3_MOSI */
+			MX8MP_IOMUXC_UART2_RXD__ECSPI3_MISO	0x82	/* SPI3_MISO */
+			MX8MP_IOMUXC_UART2_RXD__GPIO5_IO24	0x106     /* SPI3_CS */
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXC__UART2_DTE_RX	0x140	/* UART2_RXD */
+			MX8MP_IOMUXC_SAI3_TXFS__UART2_DTE_TX	0x140	/* UART2_TXD */
+			MX8MP_IOMUXC_SD1_DATA5__UART2_DTE_RTS	0x140	/* UART2_RTS */
+			MX8MP_IOMUXC_SD1_DATA4__UART2_DTE_CTS	0x140	/* UART2_CTS */
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA6__UART3_DTE_RX	0x140	/* UART1_RXD */
+			MX8MP_IOMUXC_SD1_DATA7__UART3_DTE_TX	0x140	/* UART1_TXD */
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DTE_RTS	0x140	/* UART1_RTS */
+			MX8MP_IOMUXC_SD1_RESET_B__UART3_DTE_CTS	0x140	/* UART1_CTS */
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX	0x140	/* UART3_RXD */
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140	/* UART3_TXD */
+		>;
+	};
+
+	pinctrl_usb0: usb0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__USB1_OTG_PWR	0x106	/* USB1_PWR_EN */
+			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC	0x106	/* USB1_OC */
+			MX8MP_IOMUXC_GPIO1_IO10__USB1_OTG_ID	0x106	/* USB1_ID */
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x106	/* USB2_PWR_EN */
+			MX8MP_IOMUXC_GPIO1_IO15__USB2_OTG_OC	0x106	/* USB2_OC */
+			MX8MP_IOMUXC_GPIO1_IO11__USB2_OTG_ID	0x106	/* USB2_ID */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__USDHC1_WP	0x106	/* SDIO_WP */
+			MX8MP_IOMUXC_GPIO1_IO06__USDHC1_CD_B	0x106	/* SDIO_CD */
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x106	/* SDIO_CLK */
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x106	/* SDIO_CLK */
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x106	/* SDIO_DATA0 */
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x106	/* SDIO_DATA1 */
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x106	/* SDIO_DATA2 */
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x106	/* SDIO_DATA3 */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d2
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d2
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d2
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d2
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d2
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d2
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d2
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d2
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xe6
+		>;
+	};
+};
+
+&pcie { /* FPSC PCIE1 */
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+};
+
+&pwm1 { /* FPSC PWM1 */
+	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-names = "default";
+};
+
+&pwm2 { /* FPSC PWM2 */
+	pinctrl-0 = <&pinctrl_pwm2>;
+	pinctrl-names = "default";
+};
+
+&pwm3 { /* FPSC PWM3 */
+	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
+};
+
+&pwm4 { /* FPSC PWM4 */
+	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default";
+};
+
+&sai5 { /* FPSC SAI1 */
+	pinctrl-0 = <&pinctrl_sai5>;
+	pinctrl-names = "default";
+};
+
+&uart2 { /* FPSC UART2 */
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	fsl,dte-mode;
+};
+
+&uart3 { /* FPSC UART1 */
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	fsl,dte-mode;
+};
+
+&uart4 { /* FPSC UART3 */
+	pinctrl-0 = <&pinctrl_uart4>;
+	pinctrl-names = "default";
+};
+
+&usb3_0 { /* FPSC USB1 */
+	pinctrl-0 = <&pinctrl_usb0>;
+	pinctrl-names = "default";
+};
+
+&usb3_1 { /* FPSC USB2 */
+	pinctrl-0 = <&pinctrl_usb1>;
+	pinctrl-names = "default";
+};
+
+&usdhc1 { /* FPSC SDIO */
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default";
+};
+
+&usdhc2 { /* FPSC SDCARD */
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	sd-uhs-sdr104;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
+};
+
+/* eMMC */
+&usdhc3 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-0 = <&pinctrl_wdog>;
+	pinctrl-names = "default";
+	fsl,ext-reset-output;
+	status = "okay";
+};

-- 
2.43.0

