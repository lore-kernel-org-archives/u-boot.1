Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A5C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 21:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740D8805A1;
	Tue,  4 Feb 2025 22:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gGnqpZ5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2BC800B3; Tue,  4 Feb 2025 22:39:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACA6801DE
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 22:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9c73=U4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738705140; bh=tpFfTk0RPi7jyUKaRtdPnPICmpgeA4MojgmNFOm9Ixw=;
 b=gGnqpZ5t2DJ8/FwsruLMBsZVe8TI+9LO6+doWiLG/PwDX+z0aM6z5wYBAs8lEJTeJCwdQ1Xg6
 +3jU3VbDA1Zpy5Mw1fklFS7PSFW8RnNqSwztq3I3J6mGndAKK99i4JhGnh/XfqslSdZXYimken6
 BPNhAVPX1zIQq/JFwYncTzTrjK9N9rlfZrPcMs39S1HSNgeAq6WpnFwW6kTxUYoKmwq3gCXCUdR
 8SHscEUIK8aBNYmoH5HcdyCQAAP7cv+XLPIPx8S4344MQS30sl9Lo1VO8690/+8j71WbnH9oEdi
 2IKywAcHGdAS4OtEdkZ4aHr0ukbgjbvINK9khreNMIRw==
X-Forward-Email-ID: 67a288f119fd69f834661b73
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 1/2] arm64: dts: rockchip: Fix sdmmc access on
 rk3308-rock-s0 v1.1 boards
Date: Tue,  4 Feb 2025 21:38:43 +0000
Message-ID: <20250204213848.885712-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204213848.885712-1-jonas@kwiboo.se>
References: <20250204213848.885712-1-jonas@kwiboo.se>
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

BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MCI
driver set PRWEN high on MMC_POWER_UP and low on MMC_POWER_OFF.
Similarly U-Boot also set PRWEN high before accessing mmc.

However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.

Model an always-on active low fixed regulator using GPIO4_D6 to fix
use of sdmmc on older HW revisions of the board.

Fixes: adeb5d2a4ba4 ("arm64: dts: rockchip: Add Radxa ROCK S0")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20241119230838.4137130-1-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 26c100232b09ced0857306ac9831a4fa9c9aa231 ]

(cherry picked from commit ca8e0bedbc790b19b11efc223677d178b8eeb74e)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch, pick device tree changes from v6.14-rc1-dts
---
 .../src/arm64/rockchip/rk3308-rock-s0.dts     | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
index bd6419a5c20a..8311af4c8689 100644
--- a/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
@@ -74,6 +74,23 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	/*
+	 * HW revision prior to v1.2 must pull GPIO4_D6 low to access sdmmc.
+	 * This is modeled as an always-on active low fixed regulator.
+	 */
+	vcc_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_2030>;
+		regulator-name = "vcc_sd";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc5v0_sys: regulator-5v0-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -181,6 +198,12 @@
 		};
 	};
 
+	sdmmc {
+		sdmmc_2030: sdmmc-2030 {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	wifi {
 		wifi_reg_on: wifi-reg-on {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -233,7 +256,7 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
-	vmmc-supply = <&vcc_io>;
+	vmmc-supply = <&vcc_sd>;
 	status = "okay";
 };
 
-- 
2.48.1

