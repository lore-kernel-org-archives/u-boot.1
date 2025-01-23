Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0498C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72A580817;
	Thu, 23 Jan 2025 23:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bd4sPp/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFF480821; Thu, 23 Jan 2025 23:49:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED07808B6
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672570; bh=kqkfwnnDSMOFUKPSYEBVT6k9DoM4eSJUtPy5cRgXjAI=;
 b=Bd4sPp/jGdi8Rifjiffg2BXByvmuTZ7v9frWBUVC/gDdzb9Yyq0Cedl8K8QLPC4+LNPYPePbW
 zaOuY2tfwc8lVm3vOQrGM+Hhyrp0wff2BmDoFIwIMe+xM93wlgM/BU3YTqO7VCHD08VhDwSLxbK
 cybJBGdb7URRZLwM7W6dSesvHmMWUWJKC/DumBwZLL8OmmCfKzLh/6w8JhQuyBTkAwQVImBPmAA
 pHtUHtgOqr+XINqa/9keerrOAwo2NOhrACFaPIp8p3upPXzy9Zf+JNoYTp8uzhqXKdkb3XaInkB
 5kZbqtc7J/aMmqado0YhQNfTd/0uEh7qvs9ElPiAFPNQ==
X-Forward-Email-ID: 6792c777f07771e5c89e01c0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/13] arm: dts: rockchip: Add rk3528-u-boot.dtsi
Date: Thu, 23 Jan 2025 22:48:23 +0000
Message-ID: <20250123224844.3104592-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123224844.3104592-1-jonas@kwiboo.se>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
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

Add a rk3528-u-boot.dtsi extending the basic dts/upstream rk3528.dtsi
with bare minimum nodes to have a booting system from eMMC and SD-card.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-u-boot.dtsi | 249 ++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-u-boot.dtsi

diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
new file mode 100644
index 000000000000..4b7e4693ac62
--- /dev/null
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include <dt-bindings/clock/rk3528-cru.h>
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+	};
+
+	dmc {
+		compatible = "rockchip,rk3528-dmc";
+		bootph-all;
+	};
+
+	soc {
+		grf: syscon@ff300000 {
+			compatible = "rockchip,rk3528-grf",
+				     "syscon", "simple-mfd";
+			reg = <0x0 0xff300000 0x0 0x90000>;
+		};
+
+		cru: clock-controller@ff4a0000 {
+			compatible = "rockchip,rk3528-cru";
+			reg = <0x0 0xff4a0000 0x0 0x30000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		ioc_grf: syscon@ff540000 {
+			compatible = "rockchip,rk3528-ioc-grf", "syscon";
+			reg = <0x0 0xff540000 0x0 0x40000>;
+		};
+
+		sdhci: mmc@ffbf0000 {
+			compatible = "rockchip,rk3528-dwcmshc";
+			reg = <0x0 0xffbf0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru CCLK_SRC_EMMC>, <&cru HCLK_EMMC>,
+				 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
+				 <&cru TCLK_EMMC>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		sdmmc: mmc@ffc30000 {
+			compatible = "rockchip,rk3528-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xffc30000 0x0 0x4000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SRC_SDMMC0>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x100>;
+			status = "disabled";
+		};
+
+		rng: rng@ffc50000 {
+			compatible = "rockchip,rkrng";
+			reg = <0x0 0xffc50000 0x0 0x200>;
+		};
+
+		otp: otp@ffce0000 {
+			compatible = "rockchip,rk3528-otp",
+				     "rockchip,rk3568-otp";
+			reg = <0x0 0xffce0000 0x0 0x400>;
+		};
+
+		pinctrl: pinctrl {
+			compatible = "rockchip,rk3528-pinctrl";
+			rockchip,grf = <&ioc_grf>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gpio0: gpio@ff610000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xff610000 0x0 0x200>;
+				clocks = <&cru PCLK_GPIO0>, <&cru DBCLK_GPIO0>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 0 32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio1: gpio@ffaf0000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffaf0000 0x0 0x200>;
+				clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 32 32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio@ffb00000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffb00000 0x0 0x200>;
+				clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 64 32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio3: gpio@ffb10000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffb10000 0x0 0x200>;
+				clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 96 32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio4: gpio@ffb20000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffb20000 0x0 0x200>;
+				clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 128 32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+	};
+};
+
+#include "rk3528-pinctrl.dtsi"
+
+&cru {
+	bootph-all;
+};
+
+&emmc_bus8 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_strb {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&grf {
+	bootph-all;
+};
+
+&ioc_grf {
+	bootph-all;
+};
+
+&otp {
+	bootph-some-ram;
+};
+
+&pcfg_pull_none {
+	bootph-all;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
+&pcfg_pull_up_drv_level_2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&sdhci {
+	bootph-pre-ram;
+	bootph-some-ram;
+	u-boot,spl-fifo-mode;
+};
+
+&sdmmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+	u-boot,spl-fifo-mode;
+};
+
+&sdmmc_bus4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_det {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&uart0 {
+	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&uart0m0_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
+&xin24m {
+	bootph-all;
+};
-- 
2.48.1

