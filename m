Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE06ECD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 03:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D5DC848B0;
	Thu, 28 May 2026 05:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="bE7UqTnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21868846E2; Thu, 28 May 2026 04:38:58 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12B88486D
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 04:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smtong@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2jJR/U447BLXX9OurErlIWUnammf5We/KlIIoH14z8popHOy4IIOJbZBBJbPUi+rkPnfVXfqMzFcnWF9eMI+zanfrBUPk0IGXwUlULFNimK1Aex+C0JvFFcfDtcq0vfFtRhv7w8PcEHqdOdYkZX5ZwKhefGFNefNfU7zMEarCXnwsfsESqdincxEoPxBaeQebPh2/EHrBei9CcL9rf4NSvvpN4DNBJwWD+4YlOXHKzVJg54KGdK/Al8E5ffCyv4JyDn9GSaurU/72fJTLUEzoRa2/j5tCvVC0YE6FHgUo9o0a2RIqieZczFVUnSwCy28iElD4LviwxFwH8BfXbARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycB70NGT7im/aotN2QZZZl//RpsNYwXwFe2qZvbAGLc=;
 b=XygprXIug4VM+jqNeP8nqvEMJ1bwzyJS4E4Zut4lci1/bVvzS2ptpVYk7tJO/UmOrP5okNmSKYNZoCaCdzyUCYQQxotOwVJt7UnbtR6cBA/eSReOnP/SbgsOKeYBi4ZoedJdQW3lShuqjB48KC62X6K4IjBnkxiSMcvaRac7m2WoAtH8SJyBPC3mlrC+Eke9rZ4GaXP3R13JUCKvqDVNhe9cp3WEIEoSetMUWrDScKlw7Yr/My6x3QiVECja9tkovDc7IP8cCZf6sA76AWRNy0fhU9NAJAt/EYlZECPAx4B+uw7TSfAM9rX5Bsptoi+4aPdP6WXSEgjBkOK1PwFY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycB70NGT7im/aotN2QZZZl//RpsNYwXwFe2qZvbAGLc=;
 b=bE7UqTnKQniwpHCQX+FxnB5Duu5pdRn5jJmqbIhYSXRf0Q7Ehtz3ht8LIi1orYzkWFCbVEqj7PVO5NIKLKR1RfPI7jzqMuD0LMWXDogv3s0Qe/b76BQlHPvUIN1UG/enNE15Zx9io8njXT5IxqbjoydjOrfnFkwu3mBm7hMhyVJ7CoQX9hi/ifaJWYdDSCdf958UL09pAM07ANU0ip7rnQPVFsfdmrOTdE5otRP//miVCxUSRcMOc5bSaATUVNsPf/4oSB8FxJBus78Mrio1afyLVg4ZsXEzOvDu5sGJ/5Gs/RgdQ+j1CnmKbvbNTmqAZnp+3jgij/BFQMKmBrUsDQ==
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 02:38:51 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::37) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 02:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 02:38:50 +0000
Received: from [127.0.1.1] (super-compute03.axiadoRD [10.4.1.87])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A6DE94186B5A;
 Wed, 27 May 2026 19:36:30 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Wed, 27 May 2026 19:38:36 -0700
Subject: [PATCH v2 1/2] arm64: dts: axiado: Add AX3005 SCM3005 device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-review-v2-1-10daefddf47d@axiado.com>
References: <20260527-review-v2-0-10daefddf47d@axiado.com>
In-Reply-To: <20260527-review-v2-0-10daefddf47d@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4845; i=smtong@axiado.com;
 h=from:subject:message-id; bh=KMqSsg6luPx19mGxJXjjj8YKXWjU8I9VOcHAnj9NnVI=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqF6q5RzTc6fSyfLI0qpWP7IaSVo33jk7uKJbIb
 qKALh2ImkOJAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCahequQAKCRB8HKhyFELz
 jjHJC/0fsSBLGkgeokxSq2CDEBW5nKWeUwNmYZJib/w7S/iQSPeQZNJvHEG0oUwzPxaLHuAPQ/8
 fJXDLXYDi/y90W9nI+SGcr/atNw888PV5hjAnRUSfWeOzp2J02d+vyw6wp3Axp9VuTs6NUnCwpB
 Vyq+VoIK2qp9ijfibBcuV+hTZQ3lUX2YtknJ85x3t862mwT/Jsi3Wo/sVKQO7VHhJt0LfDXcchX
 h7E0b75jUgT9rzIyJWi5fSTmG3Qgbf8qjOoyPgDWzYPoP0vH7GiaerMMysfkmruXXZnonn4ryWx
 d872UD08OTz5TkCvyh6Ig/fjPko9zBgBfLrR01RaWH2zLu4iUQeHwKbfIDkVAcwbFki1tZrcdcI
 CabLxjO78tljDxkwIwcMz3FyAQq70TFZib9HCjwb+dram/GYDspPeKqfs/vBmoXSQhblYOS75cH
 jjjbbPInjuRtKTEfm4RHHGXeRqjAdyZIGHE036NiwSrDntkTfJSFKv0c3G/Zed+xiYcUI=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CO6PR18MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcff9d3-0a95-485e-3bd0-08debc624059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RUG3BQAsnSAtS6tQTir7q/73b2Q5YzS1N6nWL/WV2HE5ueVvZQgTKdRby7quiqpWiVulstICD50H3okY7BgZSpTv508LroKR30++mHtT1Pmg1AARemvV33FQ9Dh7YwC5hJ70WC2Wm+Q0I38Gef45nH7+sKh3Cmpczk5KSS5yTQ+As+N9Z/vT3Lcecdtixo/8OTnwRnWfwi/u0m5SrWs42henlv5n9F1Jp9MEgNUFvnimOw/sl51QaZWxIXMDOaSyuTw0zGneBuIuJDU7/30xt5oIxKQazCb9DPXsD+kx44RyoiCru5qXg7sr6Di1RgWTlXfPvGnWyfd66I4hnhpOPwqiXDQkF/w7V9GDnG0XNP+C4MC2XQwLamzBrZd8by4cfwLt5m2rjoOwAPYYHrea2yI58igWsCff6mugZGlgFycuH/bM1j2a+YUvsmNe94yQz+BGxZcWqL/2x+OidnAnC2R9BjNsmH8Xpwr8n+GO7jT6uq2+unls3UzHCQm06JBOrd/gBmr3MiT5JpiFoIsSUXV4xGRI+dI9/kaEpGjrl00l4PODV+atOGG7h80W49kpQ4IOhzIPgeXR8+qJS+Lbwv9073fV85u99ub3l7clWVr0EyidHOJA60AZTu0lO26G248UDgPLUiPV/OpwxlCb6P42IX/T5/rkMeDVeKFpC+2ot+19KN34oKFqRjWhvBwWWDHNz+KjBRTou5pIQqloZhUbwkDupqTWVoMSpic1ysY=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: woq22EjBNDNTwYCgRt2v5b/gssim7oqzGf5YotaKn3WeF40zD+IYIG24EappQ0yIwsR0cCLUi1jg7STPJULATJG9q/2NAHK/WEWTG4OphfZy1Aeowtpl23bynTW7vAF3uN01MbZBodQ+iKpOZncI9PAD1olJCTCBoc+eBGUYaprHA5Fc1uH1JQWY/WFWLm0NWWrZRMLLtdxDTKrKZ+SCEkwnA/ved5+E7ofE/3pKgrx2XQI9j86DFE2OcKjidsB4RwKKju/Y4t86v4u5oKnIpIv8oLN4WnsPeGUEmtDj3i+v9ryLYLIW5/QA+bKjCc2n/EF/wXQvw0bp7k7uq9i9+hLvRUBZE5VqCWKGyJ13I40v2h3dWE5Em0Cpx1PIx8J+YrAB9iASwGJz1DAWmmLGUnry+jVbplT5fkjZO+pj1Nk4lY05voH9nWkcu4cJxhJC
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 02:38:50.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcff9d3-0a95-485e-3bd0-08debc624059
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4451
X-Mailman-Approved-At: Thu, 28 May 2026 05:00:39 +0200
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

Add device tree source files for the Axiado AX3005 SCM3005 board.
The AX3005 is a quad-core 64-bit ARMv8 Cortex-A53 SoC.

The DTSI describes the SoC-level nodes: GIC-v3 interrupt controller,
Cadence/Zynq UART, fixed reference clock, and spin-table secondary
CPU boot.  A /memreserve/ directive protects the spin-table release
address at 0x80002fa0 from being overwritten during boot.

The SCM3005 DTS sets the console to uart3 at 115200 baud and declares
2 GB of DRAM starting at 0x80000000.

Tested-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 arch/arm/dts/Makefile           |   1 +
 arch/arm/dts/ax3005-scm3005.dts |  28 +++++++++++
 arch/arm/dts/ax3005.dtsi        | 100 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index bff341d6118..fcc62505987 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_TARGET_SMARTWEB) += at91sam9260-smartweb.dtb
 dtb-$(CONFIG_TARGET_TAURUS) += at91sam9g20-taurus.dtb
 dtb-$(CONFIG_TARGET_CORVUS) += at91sam9g45-corvus.dtb
 dtb-$(CONFIG_TARGET_GURNARD) += at91sam9g45-gurnard.dtb
+dtb-$(CONFIG_TARGET_SCM3005) += ax3005-scm3005.dtb
 
 dtb-$(CONFIG_TARGET_SMDKC100) += s5pc1xx-smdkc100.dtb
 dtb-$(CONFIG_TARGET_S5P_GONI) += s5pc1xx-goni.dtb
diff --git a/arch/arm/dts/ax3005-scm3005.dts b/arch/arm/dts/ax3005-scm3005.dts
new file mode 100644
index 00000000000..b684602176c
--- /dev/null
+++ b/arch/arm/dts/ax3005-scm3005.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+ */
+
+/dts-v1/;
+
+#include "ax3005.dtsi"
+
+/ {
+	model = "Axiado AX3005 SCM3005";
+	compatible = "axiado,ax3005-scm3005", "axiado,ax3005";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen {
+		stdout-path = "serial3:115200";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00 0x80000000 0x00 0x80000000>;
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/ax3005.dtsi b/arch/arm/dts/ax3005.dtsi
new file mode 100644
index 00000000000..6df2e4a821c
--- /dev/null
+++ b/arch/arm/dts/ax3005.dtsi
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80002fa0 0x00000008;
+
+/ {
+	aliases {
+		serial3 = &uart3;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+		};
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+		};
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+		};
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <1000000000>;
+	};
+
+	clocks {
+		refclk: refclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+			bootph-pre-reloc;
+		};
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		interrupt-parent = <&gic500>;
+		ranges;
+
+		gic500: interrupt-controller@40400000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			reg = <0x00 0x40400000 0x00 0x10000>,
+			      <0x00 0x40500000 0x00 0xc0000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart3: serial@33020800 {
+			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x00 0x33020800 0x00 0x100>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &refclk>;
+			bootph-pre-reloc;
+			status = "disabled";
+		};
+	};
+};

-- 
2.34.1

