Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E367C369A4
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B5282E86;
	Tue,  8 Apr 2025 00:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CCdcI/RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EF98309A; Tue,  8 Apr 2025 00:49:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7145E82E77
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066139; bh=5fiuLh9qU5jvZyAiF9RLWBKuWMKVFpLmXdKmFJvhBPI=;
 b=CCdcI/RB/b4xtUzkrnclhA/gm7OjWmEQzcWWIykRk8qfFUTI6B/o7rOKSntB/PWEAwIfLDLRk
 EzGTYyrmIHHV5JhHtu1PDwGJeJsI33hLNBJhCRH6LegOIc57jyAQ9gA2uMU5j1iqsFwikn41wpH
 NTUmAF9faynCMQqRPUn+rGIqQmnGsAk9ALTPUGjhFyu0U1UsRWXDiE2vs+/AX/WtPVaVIoIk6N4
 Hwo6aUoUYf/xzmeT88Xlv6XlNws86Y9mrJv3rtIGdgeCRhdJ8isaVlw+tGNP0Q4yIBWmlC/3E0s
 P8L/BtE4O2eSQxkZ4Uic58D0tImGYUea7G0ST9zsLkeQ==
X-Forward-Email-ID: 67f456579fd75b9b965128de
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 18/30] arm: dts: rockchip: Add rk3528-u-boot.dtsi
Date: Mon,  7 Apr 2025 22:46:51 +0000
Message-ID: <20250407224743.2423921-19-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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
Changes in v2:
- Use more nodes from dts/upstream rk3528.dtsi
- Use sdmmc node from latest mainline Linux patch
---
 arch/arm/dts/rk3528-u-boot.dtsi | 148 ++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-u-boot.dtsi

diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
new file mode 100644
index 000000000000..eb6a55cd5c93
--- /dev/null
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	aliases {
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
+		rng: rng@ffc50000 {
+			compatible = "rockchip,rkrng";
+			reg = <0x0 0xffc50000 0x0 0x200>;
+		};
+
+		otp: nvmem@ffce0000 {
+			compatible = "rockchip,rk3528-otp";
+			reg = <0x0 0xffce0000 0x0 0x4000>;
+		};
+
+		sdmmc: mmc@ffc30000 {
+			compatible = "rockchip,rk3528-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xffc30000 0x0 0x4000>;
+			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SRC_SDMMC0>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x100>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
+				    <&sdmmc_det>;
+			resets = <&cru SRST_H_SDMMC0>;
+			reset-names = "reset";
+			rockchip,default-sample-phase = <90>;
+			status = "disabled";
+		};
+	};
+};
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
+&gmac0_clk {
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
2.49.0

