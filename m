Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87521CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5114F83980;
	Sun, 31 Aug 2025 18:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TePoFWXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C7983987; Sun, 31 Aug 2025 18:50:50 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190F383955
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659046; bh=VzLgcxzx3u9ClYWbeXbQSkkiYWgTrmIb4Dj7zhVMLSI=;
 b=TePoFWXYWQTBRsXyPXcpetrDhfSF7O2mkblUzwo0ePgiN1Q0eA5pyYBlP9VqSdUXhyhEPNAhq
 Im5pBpSwIHlnkYvvEICga6wOPTvYoRw3rGiHk/AcyxJKrehhXM+WZsj9GLzNuOOx9a7aelQvPoB
 uhndNew8ZPcC475dsgRQ0F9abG+naRayWGJvTJO0DLZj/ZFFk5jxmzQhZrE/L7m9F9GOJcgn0dR
 3OxWEZlzZufd5HbQl48ohltfmejxeB0j4mgEtTzkjYvWTIEEipRL9QsyRnVep8XnVIVq/rOFGuk
 Olr9c6NQx+wVYc46vOPjq8JrqtiHfelQD3AHIijdlNkA==
X-Forward-Email-ID: 68b47d647f68b507ca9c3a38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
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
Subject: [PATCH v2 06/18] rockchip: odroid-go2: Move SoC common overrides into
 a SoC u-boot.dtsi
Date: Sun, 31 Aug 2025 16:49:23 +0000
Message-ID: <20250831165001.2749711-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
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
2.51.0

