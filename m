Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D79AD1AD2E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3322B88F2C;
	Wed, 16 Oct 2024 11:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23B788E89; Wed, 16 Oct 2024 11:00:02 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4355888E89
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 16 Oct
 2024 16:59:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 16 Oct 2024 16:59:55 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <chiawei_wang@aspeedtech.com>, <BMC-SW@aspeedtech.com>, <joel@jms.id.au>,
 <billy_tsai@aspeedtech.com>, <fr0st61te@gmail.com>, <clamor95@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <michal.simek@amd.com>,
 <paul.barker.ct@bp.renesas.com>, <piotr.wojtaszczyk@timesys.com>,
 <andre.przywara@arm.com>, <jim.t90615@gmail.com>, <kabel@kernel.org>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>, <ye.li@nxp.com>,
 <pbrobinson@gmail.com>, <u-boot@lists.denx.de>
Subject: [PATCH v1 3/3] ARM: dts: ast2600: Add SGPIO to device tree
Date: Wed, 16 Oct 2024 16:59:55 +0800
Message-ID: <20241016085955.314236-4-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
References: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add SGPIO DTS node and enable them for AST2600 EVB.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/dts/ast2600-evb.dts             | 10 ++++++
 arch/arm/dts/ast2600.dtsi                | 40 ++++++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl_ast2600.c | 10 ++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/arm/dts/ast2600-evb.dts b/arch/arm/dts/ast2600-evb.dts
index 9aac0e26f28..570ba61965a 100644
--- a/arch/arm/dts/ast2600-evb.dts
+++ b/arch/arm/dts/ast2600-evb.dts
@@ -266,3 +266,13 @@
 	bootph-all;
 	status = "okay";
 };
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+};
+
+&sgpiom1 {
+	status = "okay";
+	ngpios = <80>;
+};
diff --git a/arch/arm/dts/ast2600.dtsi b/arch/arm/dts/ast2600.dtsi
index 43db80edfe5..cb8ce8b6b6f 100644
--- a/arch/arm/dts/ast2600.dtsi
+++ b/arch/arm/dts/ast2600.dtsi
@@ -501,6 +501,36 @@
 				ngpios = <208>;
 			};
 
+			sgpiom0: sgpiom@1e780500 {
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780500 0x100>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scu ASPEED_CLK_APB2>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				bus-frequency = <1000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm1_default>;
+				status = "disabled";
+			};
+
+			sgpiom1: sgpiom@1e780600 {
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780600 0x100>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scu ASPEED_CLK_APB2>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm2_default>;
+				status = "disabled";
+			};
+
 			gpio1: gpio@1e780800 {
 				compatible = "aspeed,ast2600-gpio";
 				reg = <0x1e780800 0x800>;
@@ -2167,4 +2197,14 @@
 		function = "PCIE1RC";
 		groups = "PCIE1RC";
 	};
+
+	pinctrl_sgpm1_default: sgpm1_default {
+		function = "SGPM1";
+		groups = "SGPM1";
+	};
+
+	pinctrl_sgpm2_default: sgpm2_default {
+		function = "SGPM2";
+		groups = "SGPM2";
+	};
 };
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
index bc12590e583..f4bec6fe53c 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
@@ -454,6 +454,14 @@ static struct aspeed_sig_desc pwm15g1[] = {
 	{0x41c, BIT(31), 0},
 };
 
+static struct aspeed_sig_desc sgpm1[] = {
+	{0x414, GENMASK(27, 24), 0},
+};
+
+static struct aspeed_sig_desc sgpm2[] = {
+	{0x6d0, GENMASK(7, 4), 0},
+};
+
 static const struct aspeed_group_config ast2600_groups[] = {
 	{ "MAC1LINK", ARRAY_SIZE(mac1_link), mac1_link },
 	{ "MAC2LINK", ARRAY_SIZE(mac2_link), mac2_link },
@@ -543,6 +551,8 @@ static const struct aspeed_group_config ast2600_groups[] = {
 	{ "PWM14G1", ARRAY_SIZE(pwm14g1), pwm14g1 },
 	{ "PWM15G0", ARRAY_SIZE(pwm15g0), pwm15g0 },
 	{ "PWM15G1", ARRAY_SIZE(pwm15g1), pwm15g1 },
+	{ "SGPM1", ARRAY_SIZE(sgpm1), sgpm1 },
+	{ "SGPM2", ARRAY_SIZE(sgpm2), sgpm2 },
 };
 
 static int ast2600_pinctrl_get_groups_count(struct udevice *dev)
-- 
2.25.1

