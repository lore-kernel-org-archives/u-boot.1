Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986B8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2568838F;
	Mon, 22 Apr 2024 08:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aiiDotSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FED488380; Mon, 22 Apr 2024 08:30:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AB888376
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767430; bh=8Nbti+7yvV0Ln5ehEP/eMODWH/HAbaAhPFlCkq4W1kI=;
 b=aiiDotSCvuoxpLLltVs4u5RfInLgZ5cCy0ICwT8pd3Tkm6ZutCQftRxoFJOpQduJm2tuD+W8l
 XrbilWBYu0Esqkm6Mx0i/xIGgLGdvKKDTw/HtX3voAHffUe+LD15xOxmPz/TrcTrEyFp0SSpGbT
 4yzPnVKCu8zfIR11RAOgs/dUuXU5PgdvB2x4jtYl/SxVxa61jLsrDOGPZXXXu1Z8Y9oS+Iynp5+
 S+dVrnY+opd0jH0dei1xvo6t1o3Vc35QPioVhxkPviaVaNwtS7e/7XvNsyJfgkG3E1Z3T9FwLKB
 Zq7mDooiYqNlL032Rx73zhWC2kuDx60C4xcxbGEQoGQA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>, John Clark <inindev@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Eugen Hristev <eugen.hristev@collabora.com>, Joshua
 Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 13/28] rockchip: rk3588: Update bootph props
Date: Mon, 22 Apr 2024 06:28:50 +0000
Message-ID: <20240422062936.681359-14-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6626040534ba165ad447437a
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
v3: Split rk3588-generic.dts and evb-rk3588_defconfig changes into
    separate patches
v3: Collect r-b tag
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
 .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |  8 +--
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     | 12 ++---
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  7 ++-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +--
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  6 ++-
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |  8 +--
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  9 ++--
 arch/arm/dts/rk3588s-u-boot.dtsi              | 50 ++++++++++++++-----
 8 files changed, 67 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
index ed15b14ea0ee..f0ef0164664e 100644
--- a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,16 +13,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
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
diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 60494bb8485f..968385622fa5 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -7,12 +7,11 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim1_pins {
-	bootph-all;
-};
-
-&sfc {
 	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
+	bootph-some-ram;
+};
+
+&sfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim1_pins>;
 	#address-cells = <1>;
@@ -20,9 +19,10 @@
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
diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
index 5d5fa6ffb214..1ab31a4ec5ab 100644
--- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim1_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,10 +13,8 @@
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
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 9ee9dd051e32..d6020ca790f6 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -18,7 +18,8 @@
 };
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl {
@@ -35,16 +36,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
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
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index ca2a684f3541..a50bcc45f216 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -12,6 +12,10 @@
 };
 
 &uart9 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
+
+&uart9m0_xfer {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
index 6e4b97028d7c..f51d7f30d787 100644
--- a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588s-u-boot.dtsi"
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,16 +13,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
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
diff --git a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
index 888d1b9c12d7..12a92c0cba10 100644
--- a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
@@ -9,14 +9,13 @@
 };
 
 &fspim0_pins {
-	bootph-all;
-};
-
-&sfc {
 	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
+	bootph-some-ram;
+};
 
+&sfc {
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 7fcbdb969240..d3c257983ecb 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -132,31 +132,40 @@
 #endif
 
 &cru {
-	bootph-pre-ram;
+	bootph-all;
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
 
 &emmc_data_strobe {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_rstnout {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &ioc {
-	bootph-pre-ram;
+	bootph-all;
+};
+
+&pcfg_pull_down {
+	bootph-all;
 };
 
 &pcfg_pull_none {
@@ -168,6 +177,11 @@
 };
 
 &pcfg_pull_up_drv_level_2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&php_grf {
 	bootph-all;
 };
 
@@ -181,10 +195,12 @@
 
 &scmi {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &scmi_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -200,27 +216,35 @@
 };
 
 &sdmmc_bus4 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_det {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc {
+	u-boot,spl-sfc-no-dma;
 };
 
 &sys_grf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &uart2 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
 
-- 
2.43.2

