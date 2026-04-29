Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769E1FF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B685A846D2;
	Wed, 29 Apr 2026 04:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="OKaGBPm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4796A846BD; Wed, 29 Apr 2026 04:32:49 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D400D846D1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kmitran@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv3zSx8B5Nlg/wPaHqzEmF4DBXxolKe+IjgF1dz49aZWLpAioZZDclqMtkx+jun0WG8VAw2wQ7wREo+AW5exqIRMR8X3s7SN0kvTttqiq8O7ws3YuCw1kUNe1O7DHxXzBimZCyZKg1wwwI5Q0CHT496cvYVl/MzY3I2Eavfy5poW7eXcWZUBYjRaB7wJbGndPl7DlInfaGnGns+GsrfOCZJKMuh3G0O8FcCIhVAQaE8Sm+lL7CNvoUJYOOstY5S1y1EZW2uSG/MF+YJQtlMUdIhOIIExxCQ1TGhR7Dz5E55VrG85e4rnLYWVwN72kdK7/oxieyhsf0TG1QqPHC3KGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJE7XX7reop/1wnkdPBZkpfoH9zE7eCJz3/mUEvspGU=;
 b=pD61/+bzNFyznmPZ3Wu7WRSFCnDCQEBGfljZAhcTLToBu7tHW1Zjn4pRSY40mdn3PEUX5fxZzqpD8em9p42YOifmGt+Xdy/AiMPpTLFRDvOVniAse7t6yzHC3kKAjajM5rdi5h/WPPSq5W0qgVyTB6RblTgYjHpu9BUPao3uvWpGw1/UQq9k9t0iygeEwMZskifovM5DYGjxbxmMs7YiFU+z7ynza+/vk8Ucflqi5AscLoZfRjsFvl8gkueCNqUuOVLYv08MkU70gLEq++fapP1oEK8niXS3+I9B74ii+FLyESmgjh8riB69FY1FUBdlngSBO+80P84cbTFebRMHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJE7XX7reop/1wnkdPBZkpfoH9zE7eCJz3/mUEvspGU=;
 b=OKaGBPm/0A9h1s4Pnj5NPimLw/Lw9YxGEkawxMfkUUPFls1ICFFzeHXVJ3tQtZmvVeEdZhIVBSg0awu0V1QSEVTAq9msXcYsq7Uc0oKbJ5Qk468sM3x+hWlf74s3pzA4KbI+gojn8xD3fV3iLaIih1oT6SEKTLeVUO0UTYxIkzSQz8NYTtHDEpfvzS92BpRxfTuWLN6ladw0mRgg70XqeM6IYrZXwOPUdZY798O4cd6ArC24R2EyY1APG43pQDs82sMDY0K9Vw1Qy+H9c7DQT1cUOBacanCV27HBWNVD1npb05vKWKpBSPDzo1AxSVXBdvVu6gPvZliOnp/TL9DAIA==
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by SA1PR18MB4760.namprd18.prod.outlook.com (2603:10b6:806:1db::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:32:41 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::98) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Wed,
 29 Apr 2026 02:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 29 Apr 2026 02:32:41 +0000
Received: from sw-build-jenkins04.axiadord (sw-build-jenkins04.axiadoRD
 [10.4.1.35])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 951084186B5A;
 Tue, 28 Apr 2026 19:30:49 -0700 (PDT)
From: Karthikeyan Mitran <kmitran@axiado.com>
Date: Tue, 28 Apr 2026 19:32:36 -0700
Subject: [PATCH 1/2] arm64: dts: axiado: Add AX3005 SCM3005 device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ax3005_scm3005-v1-1-7fed19ee6fe0@axiado.com>
References: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
In-Reply-To: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891; i=kmitran@axiado.com;
 h=from:subject:message-id; bh=b+dHVHVo65Ap8kZ5GlgVI2hhIHYM49H8LWUmxs6u8Mc=;
 b=owEBbQKS/ZANAwAKAfykr3bAxbrPAcsmYgBp8W3HRJmnrcZV8R+H/PnCzGtSgZZyqCodxtK59
 mPSUwrbFQKJAjMEAAEKAB0WIQQykBiJeI5kfMQLrdj8pK92wMW6zwUCafFtxwAKCRD8pK92wMW6
 zwkfEADHw0+Cs6IeH83TpQT3x73scgHOdR9Gq1hhBhmy4hpzh1Hcwb6j3V8i0bfpCV9xKsRIe/N
 vonmQa+SDriNA6lpd+FdPxi7+tX6C5MgrmxHKqwe0W99gaooU38z6lDtAOYyfJYRQbFr9qjN/cB
 qeJPmJDJ+91B5RGfNJxmPODrqR4zzBIk/QpNLnnDtKtWFyGVxQCPnrq16sfnb2rEqD9X4AgE7vj
 nTOOjeOkBDcEG5PJNFZjyHV9e5bFv8q1KorYmNTaOmFYCrPgf1qEv3otQvUYiUmH31IsFwNSbeY
 FFwrDB/ZwyLCMFyH3HAFzVf792m7Dif1w9SM+zHMRhX9fTy2gQhUw+UsqcuC9UF3wYoVW3GhlE5
 qHa5pFn9FIOPrxxdSevosyh1Fg8luN5KgKmYByscplC6ES6JeThk7tScCOH0DRBvsf6lvIqeGfR
 zSq9/ADOORjsc9ktoI5WRn6iKhLiPZEhJwnj4TgOedIyPEkIujeMZb06lLB5XKI6jHt8QAqLVF6
 UqPEZ+XJVS3pZPo8fjQ168P2UpkqX/jX2PMmqc968FlRtpgae1qqYm4DhXouZ1aBpM7Mcyom6vG
 A1BweVlSju2F8m1Hj7qP6ZdTMtqro6aKT8FTCGwZP7Rya8+wfg8SVWnrrb9uMea72PlKx9O63eL
 0zKyI+U3jrskN2w==
X-Developer-Key: i=kmitran@axiado.com; a=openpgp;
 fpr=32901889788E647CC40BADD8FCA4AF76C0C5BACF
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR18MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: 113d584b-cd0e-473c-8928-08dea5979656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34070700014|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: q2DcQh3ZzksjrgQfEnAVbvfFQD/YsSVYq9AdGgZiTWElULPu0ixf22VgrnOcfnT1nzORXjF7HyvpdHTeGUk2M1ctdRYG882yse2FwPzSj/bFh62g3+VCdt3+KkObiLf3+PMhgIO5jVEMO3dhhj7ijh4ONBQjRmDGgOnxG2UVFXbhnnJn2p+pFmRvzL/yzj43BC9HjTr9jvOU6Ptq+OJtlRK5oBnZjNyoas9ZQQczJy0xi/R15WGzbcVv9UgTpUk7nrgTGSTGfrhrELyB65MXa6uCgBEFe8oPIq50ROd0TeQ1CE1OwJPbhd4qDhJxGOfGapZ3Pz/RnNpcfI1dT/uDi66U3+Nw4Ow4iCn+kNVruQ3p+BIxKQSjcg1GDhH7p/6L0v8ytXzWKgGSKWnxfbbfX93jbW7+aCVvoqIu3MUlhCVRLEVDU4aXh1xE2DJgK+qicPtmZrA7CA3s5yCNTl6CsWqete5qW8MzgiQiV82yJmOyxKEgIoHgh34R2XxBCyb/8V/IZmnUJ/ROJInOM0dFbH8jQU8XLUc06VFgBYgPVau1yz1JALPK+50OJNvfMBP/cw1Lb/RG07Y/mCPmZxp1GWyILuRf1VIhALMEslt2IWMUKFApmXUM2NQElp74A9kfNNbsH40mQqhCCOAZfqp+fUkMSm2Xjc8QIqPt9OaQ4AOqtWGPUVFa+g2BgznnSHZY5lm65QNRZilAs2yZDXtVWks5OgvKHfF//HcZrYGiAmcJg3YNEcgjWJL4zHPIGDtYnxvR3Qj4MzUcFvrdgRih+g==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34070700014)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CWg57YV+od+KHzsgL95/O98eual53NP31pWtLeDdu9XClDO8FwcyJFHD1YccpaH0epFaY7EF7I4Z4AZuGWK9Wqlo2h/47F1os/qQY+qYRji5DluSTHn+wQViSDkAsU9QyZKuqgu2/XlN3XqQP5/uwax9nl2uht2n30zkyYv6oUdLD66uuSUOLjE8SkPnopYs5w80McAHiioPfZpD0Ybghj0tWCFfmUhos3/HxJ3kxrliBN1ntegq/ExlQBEQ6b0R4/QxET0c5xCBOxxFUhGrCTVqMn+uXvvHXhZGfHfuDEsI+VUguCau5jfD/rb/7PEJkxiTKmHJRn4OkpssVfk3BsqtM9iE8loRl7ne9UOyne3zBXuT4ffGgFmH0xq7kqM2ST10Q9IlyUaJ5E80ghVDZfT6gEwqM9b4ChpwvLOfMs1NtxrDFxRcsk4ICeRDKlTO
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:32:41.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113d584b-cd0e-473c-8928-08dea5979656
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4760
X-Mailman-Approved-At: Wed, 29 Apr 2026 04:43:59 +0200
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

From: Siu Ming Tong <smtong@axiado.com>

Add device tree source files for the Axiado AX3005 SCM3005 board.
The AX3005 is a quad-core 64-bit ARMv8 Cortex-A53 SoC.

The DTSI describes the SoC-level nodes: GIC-v3 interrupt controller,
Cadence/Zynq UART, fixed reference clock, and spin-table secondary
CPU boot.  A /memreserve/ directive protects the spin-table release
address at 0x80002fa0 from being overwritten during boot.

The SCM3005 DTS sets the console to uart3 at 115200 baud and declares
2 GB of DRAM starting at 0x80000000.

Tested-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
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

