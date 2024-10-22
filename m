Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01434D1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA398926A;
	Tue, 22 Oct 2024 08:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="GyxNxLMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684CC88F5E; Tue, 22 Oct 2024 08:04:38 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66B888F75
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20241022060433653deb012efab508a4 for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2Mx1X5J1tTQQsp7b5OGUiI81YRXrfDBSX+uGme72rvc=;
 b=GyxNxLMhGZxwV20Ja+6rT/vSF+iDs3/jbp+5E6nuVJgOmQJJYcglhF6Ckz9RIj8/KmO1W7
 FCtNvC74sT3kMhgXo0ThSeXNl0vd6Ylp92YTqF3SdBL6bPcZHsQFGAzRCa085A5iFfDbZro9
 03hGKAknqAR/VwJk0ZBTIbz2+sFwLkuZCCnpZwY8/DWDgO1pz/Sjvg05Vz+EISf7KrAAf5+Z
 fH44t0+vHy5bg4bm45DQvI+EzH91g9PkP1Aqvon5Pl0heBhs3LyX5xxZqCLjMYUB6l/R8WSI
 Xr4VLioKoWbeP4FpdhEujbAMFUxRO5MOqEc6GBnzuFSN4NEqKs+3/CDg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 08/13] arm64: dts: ti: iot2050: Add overlays for M.2 used
 by firmware
Date: Tue, 22 Oct 2024 08:04:25 +0200
Message-ID: <247548111148ba32e8aa920df7c4fa97440feb0b.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

To allow firmware to pick up all DTs from here, move the overlays that
are normally applied during DT fixup to the kernel source as well. Hook
then into the build nevertheless to ensure that regular checks are
performed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://lore.kernel.org/r/91f8b825467651ebd51a4051f153ab136eeb1849.1724830741.git.jan.kiszka@siemens.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: dba27d026fc841d28a0ed373f617cc84ec0e4504 ]

(cherry picked from commit 741915246a92fc4c21537f9623a69612f7cef03a)
---
 ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
 ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
 create mode 100644 dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso

diff --git a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
new file mode 100644
index 00000000000..666237f6d79
--- /dev/null
+++ b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050 M.2 variant, overlay for B-key PCIE0_LANE0 + E-key PCIE1_LANE0
+ * Copyright (c) Siemens AG, 2022-2024
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&pcie0_rc {
+	num-lanes = <1>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "okay";
+};
diff --git a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
new file mode 100644
index 00000000000..0f86235c977
--- /dev/null
+++ b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050 M.2 variant, overlay for B-key USB3.0 + E-key PCIE1_LANE0
+ * Copyright (c) Siemens AG, 2022-2024
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&serdes0 {
+	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&pcie1_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&minipcie_pins_default>;
+
+	num-lanes = <1>;
+	phys = <&serdes1 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys = <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names = "usb3-phy";
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
-- 
2.43.0

