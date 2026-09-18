Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29C4C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF32460E98;
	Fri, 18 Sep 2026 13:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1_PtJcu3pxm; Fri, 18 Sep 2026 13:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A2DD60E65
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738118;
	b=QiuOWWwnZsLUS1gBGEtUQxAFqYjb17PYqYDoPbLQ7tVTp7rgVnAk36IPeWP0YyiREwMI
	 RVEgivvGXegS/g2QSmE4QUthXH7tZHNmh7BUh+n4v/J+PP55bYtXxleTg6bop8G6cUXFZ
	 zykshPD+fP84tMb70Mt3OgU4xpIWW0mw4zSnZEMajFQRNyuiLr/Xz20unDLAikX1xB9PX
	 hw3ybwFvLyhKgp8vnEbYDz8REfDnlUZMR+mWE+skoPOjNPfuqxSm1KxTlIK/zOccw4lwF
	 APOEm3Jb2WcO6sm4YNlYgQfIBvklDYi3J9CaJaWG69h00ggSc2kN9DTAPqV2RQUp/Rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nF3zccExM4xftUHpiCTHoshZ7C2Iza5xgd4jXyWIavQ=;
	b=Jha8HzrB1aja9HOkwWR2MQAnU/GMPYIaN468rCCnHxh+cL6r6guQYGykCczro1cv1WXG
	 70CwvQQOykLmbEZLyUjxSaVFQfsxv7fiXCJkoD57YHpQcV1m7Ln/tAVYLI6cqXIrRuzvI
	 MpIlgI0pyPhymbYuiPkBe5Tk4Y0TM2LfW8hKvXiIxJXRf8Tq3pUkC79Uyab2SMK1hE2uk
	 qUBue4gRio+/UtZOJnhf23cos01CSrRX1S0j9+RHM5BsWHl/b6MpI7QW6pprV/FtWANvG
	 SGWfHlcTyM5Dpb1Kpk11WfFTJf10QWKyu1GXay2OtMOWvfim7s1gPc49vuuc6A7cTqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789738118;
	bh=nF3zccExM4xftUHpiCTHoshZ7C2Iza5xgd4jXyWIavQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JEHYXtgn7D6qiiKAIpg1EQPfGTtO3mFQ+Lf9zja48GADO1H1prCT7py7ul1IsZT3c
	 Lir8otgsYTAgWp1VtTtOtNymHBRzh/g+bo4aC5XsFvopOnQlRVM9jdw4C8IVs0Juqs
	 iX0YUy1PLa+5pemuE6gml6+bWydKKNog+98RCxOyE6N12YOOnvw7fGXSc5viqemCzM
	 pZ7bL767rJCtYAygQ0/TAqxBJm5sZP442O1VCqcscVZ4jt4kfMkKcN/PP22d4eod5B
	 vZfLHuQRamvSkAOWErup//fk0vq790s9b9lgiOZUFcvoxS+e/tVSr43EEFlwBVE3I+
	 7b21OG1It4OEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A2DD60E65;
	Fri, 18 Sep 2026 13:28:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AC0423F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CB2440049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F75Tf_aqBn0Z for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EF58040048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733117;
 b=q9z6+QWJLinoENu/u8JbBEM0FrWIfrWy+DmkBAx8/VCuiTKFwFb9+aDYEmcQJDBjgsI4
 PWq6v7AcDDlpI00b2+xtS1Nj/tli1yhHyGKO4jVUXGEbDu4xYNxwO+FbJR7RocDDu8xDG
 fErwDD6zKHaiR84rETboY8Ppun/c9P/xrhQ1pssHjwBdPaJ36UpRXKlIk7ZCcFT/RETyt
 umnrr+oqe3JUIsJIJ4hLaAoVLqQo67UYeKulkdZogHedC1Qul7mgGitFKKkt5ZTWMeCIW
 0q9R40B6P/ACRVvQwXbNyBhhx2KQ+1rdfqF0Oo/+3W8BHrIVSYCdaAbY6J+cQ8pa59w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733117;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status;
 bh=nF3zccExM4xftUHpiCTHoshZ7C2Iza5xgd4jXyWIavQ=;
 b=Qovbe2OVCS2dZBMUhLTkceQAUIQmDdljpYVUpohns5HMkI5ImTEjs0DchIRSzuf7syPH
 Nq+X3cq+EjWAa8lQNDrScJsQNfodpJuuZDKO5Rt42qA1jt8jp6KPDQf3GIlfz+ksmZIWA
 3zdZUFeEW6b8jg9bbR5iNQCgF47h75l3947xTT4eYZ4vp2dQSJNRxW3dsK158n2F3bTIY
 fT8jkC+51dWDVM20+ngQgGpNwkkXkNZQ0434fliOiyRoI2PYV0+MpfBY8dqtR4GHg2ABu
 y1MqcJpb64vydNVFmPPX3jT2SPxJpIyOHFpxeIqKNx7hcjae1P1pDl3ek8eCbjENJTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=jmu.edu.cn; 
 arc=none smtp.remote-ip=101.71.155.101
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 18 Sep 2026 12:05:16 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=101.71.155.101;
 helo=mail-m155101.qiye.163.com; envelope-from=amadeus@jmu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF58040048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:05:16 +0000 (UTC)
Received: from Vostro-3710.. (unknown [14.220.232.127])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e4b3dc01;
 Fri, 18 Sep 2026 20:00:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Chukun Pan <amadeus@jmu.edu.cn>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add HINLINK H28K
Date: Fri, 18 Sep 2026 20:00:00 +0800
Message-Id: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b4635de803a2kunm0bbbbba53cc9fc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0saVk4ZSxhIQxoZGh0fT1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVUpJTFlXWRYaDxIVHRRZQVlPS0hVSktJT0
 9PS1VKS0tVS1kG
X-Mailman-Approved-At: Fri, 18 Sep 2026 13:28:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The HINLINK H28K (LinkStar H28K) is a SBC with the
Rockchip RK3528 SoC. It has the following features:

- 1x USB 2.0
- 8/32GB eMMC
- 1/2/4GB LPDDR4
- MicroSD card slot
- 1x 1GbE RTL8111H Ethernet
- 1x 1GbE RTL8211F Ethernet

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Link: https://patch.msgid.link/20260610100006.366963-3-amadeus@jmu.edu.cn
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 5fd91b4f3ef20ecdc6db7a9e5c831209c7042c08 ]

(cherry picked from commit 056a3d3a36a2f0bbcfc9019b57dbbbf9ee33929e)
---
 .../arm64/rockchip/rk3528-hinlink-h28k.dts    | 318 ++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-hinlink-h28k.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-hinlink-h28k.dts b/dts/upstream/src/arm64/rockchip/rk3528-hinlink-h28k.dts
new file mode 100644
index 000000000000..0ec50e9156eb
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3528-hinlink-h28k.dts
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3528.dtsi"
+
+/ {
+	model = "HINLINK H28K";
+	compatible = "hinlink,h28k", "rockchip,rk3528";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-boot {
+			label = "BOOT";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan_led>, <&wan_led>, <&work_led>;
+
+		led-0 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio4 RK_PB7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	vdd_0v9: regulator-0v9-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_ddr: regulator-1v1-vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren_l>;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vccio_sd: regulator-vccio-sd {
+		compatible = "regulator-gpio";
+		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x0>, <3300000 0x1>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_arm: regulator-vdd-arm {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_arm";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <746000>;
+		regulator-max-microvolt = <1201000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	vdd_logic: regulator-vdd-logic {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_logic";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <705000>;
+		regulator-max-microvolt = <1006000>;
+		regulator-settling-time-up-us = <250>;
+	};
+};
+
+&combphy {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_miim>,
+		    <&rgmii_tx_bus2>,
+		    <&rgmii_rx_bus2>,
+		    <&rgmii_rgmii_clk>,
+		    <&rgmii_rgmii_bus>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_logic>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_rstn_l>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtl8111hs_isolateb_l>;
+	reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pinctrl {
+	gmac {
+		gmac1_rstn_l: gmac1-rstn-l {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		lan_led: lan-led {
+			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led: wan-led {
+			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		work_led: work-led {
+			rockchip,pins = <4 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		rtl8111hs_isolateb_l: rtl8111hs-isolateb-l {
+			rockchip,pins = <4 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_pwren_l: sdmmc-pwren-l {
+			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1m0_pins>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m0_pins>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	phy-supply = <&vcc5v0_sys>;
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
-- 
2.34.1

