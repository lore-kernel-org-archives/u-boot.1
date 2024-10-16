Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D13D1AD30
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D08488EDA;
	Wed, 16 Oct 2024 11:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFCB88E5D; Wed, 16 Oct 2024 11:00:02 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F3A88E69
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:59:59 +0200 (CEST)
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
Subject: [PATCH v1 2/3] ARM: dts: ast2500: Add SGPIO to device tree
Date: Wed, 16 Oct 2024 16:59:54 +0800
Message-ID: <20241016085955.314236-3-billy_tsai@aspeedtech.com>
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

Add SGPIO DTS node and enable it for AST2500 EVB.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/dts/ast2500-evb.dts             |  5 +++++
 arch/arm/dts/ast2500.dtsi                | 20 ++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl_ast2500.c |  1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/ast2500-evb.dts b/arch/arm/dts/ast2500-evb.dts
index d481eadfeb0..9a5037deca2 100644
--- a/arch/arm/dts/ast2500-evb.dts
+++ b/arch/arm/dts/ast2500-evb.dts
@@ -129,3 +129,8 @@
                 reg = <0x4d>;
         };
 };
+
+&sgpio {
+	status = "okay";
+	ngpios = <80>;
+};
diff --git a/arch/arm/dts/ast2500.dtsi b/arch/arm/dts/ast2500.dtsi
index 320d2e5340a..d677705fe85 100644
--- a/arch/arm/dts/ast2500.dtsi
+++ b/arch/arm/dts/ast2500.dtsi
@@ -255,6 +255,21 @@
 				interrupt-controller;
 			};
 
+			sgpio: sgpio@1e780200 {
+				compatible = "aspeed,ast2500-sgpio";
+				reg = <0x1e780200 0x100>;
+				interrupts = <40>;
+				clocks = <&scu ASPEED_CLK_APB>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				bus-frequency = <1000000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm_default>;
+				status = "disabled";
+			};
+
 			timer: timer@1e782000 {
 				/* This timer is a Faraday FTTMR010 derivative */
 				compatible = "aspeed,ast2400-timer";
@@ -1445,4 +1460,9 @@
 		function = "WDTRST2";
 		groups = "WDTRST2";
 	};
+
+	pinctrl_sgpm_default: sgpm_default {
+		function = "SGPM";
+		groups = "SGPM";
+	};
 };
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2500.c b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
index 9e7c347caf8..5ecd3f262b9 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2500.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
@@ -62,6 +62,7 @@ static const struct ast2500_group_config ast2500_groups[] = {
 	{ "SD2", 5, (1 << 1) },
 	{ "FWSPICS1", 3, (1 << 24) },
 	{ "SPI1CS1", 1, (1 << 15) },
+	{ "SGPM", 2, (1 << 11) | (1 << 10) | (1 << 9) | (1 << 8) },
 };
 
 static int ast2500_pinctrl_get_groups_count(struct udevice *dev)
-- 
2.25.1

