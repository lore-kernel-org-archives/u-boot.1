Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228C2C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 01:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBF4877FB;
	Wed,  7 Feb 2024 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jsXZKzXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A909D87CCF; Wed,  7 Feb 2024 02:07:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACB587C9A
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 02:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707267985; bh=N2MLf/VSp0W0HZfqhN9E63T2brhXH8JNak2dufvdGVY=;
 b=jsXZKzXqsjTl7bHygJXRX16dcZdjDxawCN4FRgRvYz33lK4emc/+V+God9VEevmuemQdmXtAW
 CsxW5+OxN1YfC8NIyuLSjilE9NLhWap0JpzhsePQXVe89dE5Xi7aRIXUgj8aUnJ8ffPe2n4veFz
 lqIYSKhKRiZBIyFf8ObSyaE+mUY+6NlOlSUhWqx9RxqDX/AwlN5mQP3Wjsb6rhaduQVXE14RYMV
 fOEtLA2Q/QCOkoQ6te4QNaUkRTNFDJUFWU8hVi1yNI/f2dBOMcO6Up+spSkMm5YXQbd1X/DieGJ
 7ez4+X3gngEQGl0lgyF8Gju9Eps+WSKJcTl/lQCtDBJg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 08/15] rockchip: rk3328: Fix loading FIT from SD-card when
 booting from eMMC
Date: Wed,  7 Feb 2024 00:02:37 +0000
Message-ID: <20240207000301.3270722-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c2c8d8d5b31093c56fbf92
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

When RK3328 boards run SPL from eMMC and fail to load FIT from eMMC due
to it being missing or checksum validation fails there is a fallback to
read FIT from SD-card. However, without proper pinctrl configuration
reading FIT from SD-card will fail:

  U-Boot SPL 2024.04-rc1 (Feb 05 2024 - 22:18:22 +0000)
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC2
  Card did not respond to voltage select! : -110
  spl: mmc init failed with error: -95
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###

Fix this by tagging related emmc and sdmmc pinctrl nodes with bootph
props. Also sort and move common nodes shared by all boards to the SoC
u-boot.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3328-evb-u-boot.dtsi           |  4 +
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    | 17 ----
 .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   | 25 ++----
 .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   | 25 ++----
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        | 17 ----
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     | 17 ----
 arch/arm/dts/rk3328-rock64-u-boot.dtsi        | 25 ++----
 arch/arm/dts/rk3328-u-boot.dtsi               | 82 ++++++++++++++++---
 8 files changed, 92 insertions(+), 120 deletions(-)

diff --git a/arch/arm/dts/rk3328-evb-u-boot.dtsi b/arch/arm/dts/rk3328-evb-u-boot.dtsi
index 12b68df1ac67..38ad3cc16d09 100644
--- a/arch/arm/dts/rk3328-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-evb-u-boot.dtsi
@@ -44,3 +44,7 @@
 	/* Integrated PHY unsupported by U-Boot */
 	status = "broken";
 };
+
+&vcc_sd {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
index 0a1152e8b52d..0ffac0e6f930 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
@@ -7,23 +7,6 @@
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
-	bootph-pre-ram;
-};
-
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
-};
-
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index 8a4189c6f1cc..7cdf6913795d 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -7,29 +7,16 @@
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-lpddr3-666.dtsi"
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
+&spi0 {
 	bootph-pre-ram;
-};
+	bootph-some-ram;
 
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
 };
 
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
-
-&spi0 {
-	spi_flash: spiflash@0 {
-		bootph-all;
-	};
-};
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 2e3b6a77a268..35baeb2464bc 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -7,29 +7,16 @@
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
+&spi0 {
 	bootph-pre-ram;
-};
+	bootph-some-ram;
 
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
 };
 
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
-
-&spi0 {
-	spi_flash: spiflash@0 {
-		bootph-all;
-	};
-};
diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
index 8bc2f134f8f4..47d74964fd0c 100644
--- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
@@ -29,23 +29,6 @@
 	};
 };
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
-	bootph-pre-ram;
-};
-
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
-};
-
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
index 1f220c6dcd0f..9ed0aef1ecc9 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
@@ -29,23 +29,6 @@
 	};
 };
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
-	bootph-pre-ram;
-};
-
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
-};
-
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
index bfe506fd2249..9de645d8d7ab 100644
--- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
@@ -29,29 +29,16 @@
 	};
 };
 
-&gpio0 {
-	bootph-pre-ram;
-};
-
-&pinctrl {
-	bootph-pre-ram;
-};
-
-&sdmmc0m1_pin {
+&spi0 {
 	bootph-pre-ram;
-};
+	bootph-some-ram;
 
-&pcfg_pull_up_4ma {
-	bootph-pre-ram;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
 };
 
-/* Need this and all the pinctrl/gpio stuff above to set pinmux */
 &vcc_sd {
 	bootph-pre-ram;
 };
-
-&spi0 {
-	spi_flash: flash@0 {
-		bootph-all;
-	};
-};
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a12be7876db0..e087b02893c1 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -38,33 +38,91 @@
 	bootph-all;
 };
 
+&emmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
+	u-boot,spl-fifo-mode;
+};
+
+&emmc_bus8 {
+	bootph-pre-ram;
+};
+
+&emmc_clk {
+	bootph-pre-ram;
+};
+
+&emmc_cmd {
+	bootph-pre-ram;
+};
+
+&gpio0 {
+	bootph-pre-ram;
+};
+
 &grf {
 	bootph-all;
 };
 
-&uart2 {
-	bootph-all;
-	clock-frequency = <24000000>;
+&pcfg_pull_none_8ma {
+	bootph-pre-ram;
 };
 
-&emmc {
-	bootph-all;
+&pcfg_pull_none_12ma {
+	bootph-pre-ram;
+};
 
-	/* mmc to sram can't do dma, prevent aborts transfering TF-A parts */
-	u-boot,spl-fifo-mode;
+&pcfg_pull_up_4ma {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_up_12ma {
+	bootph-pre-ram;
+};
+
+&pinctrl {
+	bootph-pre-ram;
 };
 
 &sdmmc {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 
-	/* mmc to sram can't do dma, prevent aborts transfering TF-A parts */
+	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
 	u-boot,spl-fifo-mode;
 };
 
-&usb20_otg {
-	hnp-srp-disable;
+&sdmmc0_bus4 {
+	bootph-pre-ram;
+};
+
+&sdmmc0_clk {
+	bootph-pre-ram;
+};
+
+&sdmmc0_cmd {
+	bootph-pre-ram;
 };
 
-&spi0 {
+&sdmmc0_dectn {
+	bootph-pre-ram;
+};
+
+&sdmmc0m1_pin {
+	bootph-pre-ram;
+};
+
+&uart2 {
 	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&usb20_otg {
+	hnp-srp-disable;
 };
-- 
2.43.0

