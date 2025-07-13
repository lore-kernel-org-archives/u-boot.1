Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C01C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B4B83046;
	Mon, 14 Jul 2025 01:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GnvV+n0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D5C8303B; Mon, 14 Jul 2025 01:35:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4420282F00
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449697; bh=dungs2g3sJu40ruEBRhuK0PclrzJDLgQwQF0ZsBo4aI=;
 b=GnvV+n0KzSQaY69qFqrJo8Xwfgmc2Q/FOXH95r1XShxSd021mLRoh4WO9zIy17enVzDWkfi7V
 vY3olxlz+wxzAwpI1+4Bkjbu5jWWC26WxCeN3QvE2DwDl1gFpCRW9HrQoa4lR3QFqCzEfp1HLAb
 NBWIfa3QNf32PkLIBM8Hd+pTDL8LnYMHmZMvfAMN5xF4GPIej+jaz6BJzHmBuISd1tLPEHRKa0k
 wFioOaOm3YuzdiU4g2IFSg9XGGfbXsM5gIQhHz1XyE5qYVNKus3dN5OSYlWPjrROxTg56kyqyFf
 u/NsLeKWtPuXQ6uZmIZvMCCI/9TedwWwHzof2GaR6wVw==
X-Forward-Email-ID: 687442a05c59ddd2f404fe2f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 05/17] rockchip: odroid-go2: Move SoC common overrides into a
 SoC u-boot.dtsi
Date: Sun, 13 Jul 2025 23:33:53 +0000
Message-ID: <20250713233429.1376172-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a new common rk3326-u-boot.dtsi and move the SoC common overrides
into it.

This should not contain any changes other than a possible reorder of
nodes and props.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 78 ++--------------------
 arch/arm/dts/rk3326-u-boot.dtsi            | 76 +++++++++++++++++++++
 2 files changed, 81 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/dts/rk3326-u-boot.dtsi

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index a27994e450c0..06e2c190b1f9 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -3,56 +3,7 @@
  * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
  */
 
-#include "rockchip-u-boot.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = &sdmmc;
-	};
-
-	dmc {
-		bootph-all;
-		compatible = "rockchip,px30-dmc", "syscon";
-		reg = <0x0 0xff2a0000 0x0 0x1000>;
-	};
-
-	rng: rng@ff0b0000 {
-		compatible = "rockchip,cryptov2-rng";
-		reg = <0x0 0xff0b0000 0x0 0x4000>;
-	};
-};
-
-&cru {
-	bootph-all;
-};
-
-&gpio0 {
-	gpio-ranges = <&pinctrl 0 0 32>;
-};
-
-&gpio1 {
-	gpio-ranges = <&pinctrl 0 32 32>;
-};
-
-&gpio2 {
-	gpio-ranges = <&pinctrl 0 64 32>;
-};
-
-&gpio3 {
-	gpio-ranges = <&pinctrl 0 96 32>;
-};
-
-&grf {
-	bootph-all;
-};
-
-&pmucru {
-	bootph-all;
-};
-
-&pmugrf {
-	bootph-all;
-};
+#include "rk3326-u-boot.dtsi"
 
 &rk817 {
 	regulators {
@@ -73,33 +24,14 @@
 	bootph-all;
 };
 
-&sdmmc {
-	bootph-pre-ram;
-	bootph-some-ram;
-
-	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
-	u-boot,spl-fifo-mode;
-};
-
 &sfc {
-	bootph-some-ram;
-};
-
-&{/spi@ff3a0000/flash@0} {
-	bootph-pre-ram;
-	bootph-some-ram;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
 };
 
 &uart1 {
 	bootph-all;
 	clock-frequency = <24000000>;
 };
-
-&uart2 {
-	bootph-all;
-	clock-frequency = <24000000>;
-};
-
-&xin24m {
-	bootph-all;
-};
diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
new file mode 100644
index 000000000000..2894133cfe6d
--- /dev/null
+++ b/arch/arm/dts/rk3326-u-boot.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = &sdmmc;
+	};
+
+	dmc {
+		compatible = "rockchip,px30-dmc", "syscon";
+		reg = <0x0 0xff2a0000 0x0 0x1000>;
+		bootph-all;
+	};
+
+	rng: rng@ff0b0000 {
+		compatible = "rockchip,cryptov2-rng";
+		reg = <0x0 0xff0b0000 0x0 0x4000>;
+	};
+};
+
+&cru {
+	bootph-all;
+};
+
+&gpio0 {
+	gpio-ranges = <&pinctrl 0 0 32>;
+};
+
+&gpio1 {
+	gpio-ranges = <&pinctrl 0 32 32>;
+};
+
+&gpio2 {
+	gpio-ranges = <&pinctrl 0 64 32>;
+};
+
+&gpio3 {
+	gpio-ranges = <&pinctrl 0 96 32>;
+};
+
+&grf {
+	bootph-all;
+};
+
+&pmucru {
+	bootph-all;
+};
+
+&pmugrf {
+	bootph-all;
+};
+
+&sdmmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
+	u-boot,spl-fifo-mode;
+};
+
+&sfc {
+	bootph-some-ram;
+};
+
+&uart2 {
+	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&xin24m {
+	bootph-all;
+};
-- 
2.49.0

