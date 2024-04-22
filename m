Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC09C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD708834C;
	Mon, 22 Apr 2024 08:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PEN4GTFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292F488376; Mon, 22 Apr 2024 08:30:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047CE88353
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767425; bh=iyNBN36BlkgEIS2MWs/Q2XCubtoA7A58wK8peLvoPmk=;
 b=PEN4GTFdQO0LPApAFBAnfvWOJOKtm6YUNKvx7VkLZuqSYl5G2v2fe8d9h3I/Lbgeqx8g/0asg
 l2Lmk/uLPv4viKy7nhdb/2yD6GAfVeDC+U8GvKLRQyUC9zcE+zV+/Ue+NNb0sY0xiuI6IuxquCv
 vBCighGxzYe7/jFgkLLpdcQQ79c/Znan+YP8mcMCfzVRqnuQhdjcfCYBkqG7xMhACC5y2HKWXDS
 7D3xcVd8Q5+E9B+55wknB0G2PtBLvgexRhxBMY7QeER+W8AL8eYNOE4PMxmhLlnPjST0ogvhM6r
 Fw9cTHoGc3r0EigH5I0WPc52dp/YkasGdvyEr1dFK3Vg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 12/28] rockchip: rk356x: Update bootph props
Date: Mon, 22 Apr 2024 06:28:49 +0000
Message-ID: <20240422062936.681359-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626040134ba165ad447435e
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

After the commit aca95282c1b7 ("Makefile: Use the fdtgrep -u flag")
bootph props is propagating to parent nodes.

Update bootph props to ensure eMMC, SD-card and SPI flash is available
in SPL and U-Boot proper pre-reloc phase also remove unneeded bootph
props that automatically is propagated to parent nodes.

Also adjust pinctrl nodes to only be included in boot phases where they
are needed and add any missing pinctrl node needed in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: Split evb-rk3568_defconfig change into a separate patch
v2: Add bootph-some-ram props and follow kernel sort order

Following bootph props have been applied:

CRU, GRF and UART nodes:
- bootph-all - needed at all or most stages

SD-card regulator related nodes:
- bootph-pre-ram (SPL) - regulator pinctrl may be needed to read FIT
  from SD-card on some boards

eMMC/SD-card/SPI flash related nodes:
- bootph-pre-ram (SPL)
- bootph-some-ram (U-Boot proper pre-reloc)
---
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi   | 25 +++++++----
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi |  8 ++--
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi |  4 +-
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi  |  7 ++-
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi    |  5 +--
 arch/arm/dts/rk356x-u-boot.dtsi            | 51 ++++++++++++++--------
 6 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
index 4aa6ab1c848c..eb18008f2fe3 100644
--- a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
@@ -3,20 +3,31 @@
 #include "rk356x-u-boot.dtsi"
 
 &fspi_dual_io_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio0 {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &i2c0 {
 	bootph-pre-ram;
 };
 
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&i2s1m0_mclk {
+	bootph-pre-ram;
+};
+
+&pmic_int_l {
+	bootph-pre-ram;
+};
+
 &rk817 {
-	bootph-pre-ram;
-
 	regulators {
 		bootph-pre-ram;
 	};
@@ -27,15 +38,13 @@
 };
 
 &sdmmc_pwren_l {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
-
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
index 930d660868bb..0e25b7e108fc 100644
--- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
@@ -3,7 +3,7 @@
 #include "rk356x-u-boot.dtsi"
 
 &gpio0 {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &sdhci {
@@ -13,11 +13,9 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
-
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
@@ -34,5 +32,5 @@
 };
 
 &vcc_sd_h {
-	bootph-all;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
index c235b4357f7d..f2c9d8e167d5 100644
--- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
@@ -9,11 +9,9 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
-
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
index 1fc71faa9e07..d8a6dd87510f 100644
--- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk356x-u-boot.dtsi"
 
 &fspi_dual_io_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -15,10 +16,8 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
-
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 5b823fcca5fb..9d18f5d0b364 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -26,16 +26,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
 
 	flash@0 {
-		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
 		spi-max-frequency = <24000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 8ac10f1698f6..0a0943b462a9 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -54,43 +54,46 @@
 };
 
 &emmc_bus8 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_datastrobe {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_rstnout {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &fspi_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &grf {
 	bootph-all;
 };
 
-&i2c0_xfer {
-	bootph-all;
-};
-
 &pcfg_pull_none {
 	bootph-all;
 };
 
 &pcfg_pull_none_smt {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up {
@@ -98,7 +101,8 @@
 };
 
 &pcfg_pull_up_drv_level_2 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl {
@@ -115,35 +119,46 @@
 
 &sdhci {
 	bootph-pre-ram;
+	bootph-some-ram;
 	max-frequency = <200000000>;
 };
 
 &sdmmc0 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_bus4 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_det {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_pwren {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc {
+	u-boot,spl-sfc-no-dma;
 };
 
 &uart2 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
 
-- 
2.43.2

